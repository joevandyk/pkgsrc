/*
 * Copyright (c) 2003-2007 Tim Kientzle
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR(S) ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR(S) BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * Various utility routines useful for test programs.
 * Each test program is linked against this file.
 */
#include <errno.h>
#include <stdarg.h>
#include <time.h>

#include "test.h"
__FBSDID("$FreeBSD: src/lib/libarchive/test/main.c,v 1.8 2007/07/31 05:03:27 kientzle Exp $");

/*
 * "list.h" is simply created by "grep DEFINE_TEST"; it has
 * a line like
 *      DEFINE_TEST(test_function)
 * for each test.
 * Include it here with a suitable DEFINE_TEST to declare all of the
 * test functions.
 */
#undef DEFINE_TEST
#define DEFINE_TEST(name) void name(void);
#include "list.h"

/* Interix doesn't define these in a standard header. */
#if __INTERIX__
extern char *optarg;
extern int optind;
#endif

/* Default is to crash and try to force a core dump on failure. */
static int dump_on_failure = 1;
/* Default is to print some basic information about each test. */
static int quiet_flag = 0;
/* Cumulative count of component failures. */
static int failures = 0;
/* Cumulative count of skipped component tests. */
static int skips = 0;

/*
 * My own implementation of the standard assert() macro emits the
 * message in the same format as GCC (file:line: message).
 * It also includes some additional useful information.
 * This makes it a lot easier to skim through test failures in
 * Emacs.  ;-)
 *
 * It also supports a few special features specifically to simplify
 * test harnesses:
 *    failure(fmt, args) -- Stores a text string that gets
 *          printed if the following assertion fails, good for
 *          explaining subtle tests.
 */
static char msg[4096];

/*
 * For each test source file, we remember how many times each
 * failure was reported.
 */
static const char *failed_filename;
static struct line {
	int line;
	int count;
}  failed_lines[1000];


/*
 * Count this failure; return the number of previous failures.
 */
static int
previous_failures(const char *filename, int line)
{
	unsigned int i;
	int count;

	if (failed_filename == NULL || strcmp(failed_filename, filename) != 0)
		memset(failed_lines, 0, sizeof(failed_lines));
	failed_filename = filename;

	for (i = 0; i < sizeof(failed_lines)/sizeof(failed_lines[0]); i++) {
		if (failed_lines[i].line == line) {
			count = failed_lines[i].count;
			failed_lines[i].count++;
			return (count);
		}
		if (failed_lines[i].line == 0) {
			failed_lines[i].line = line;
			failed_lines[i].count = 1;
			return (0);
		}
	}
	return (0);
}

/*
 * Inform user that we're skipping a test.
 */
static const char *skipped_filename;
static int skipped_line;
void skipping_setup(const char *filename, int line)
{
	skipped_filename = filename;
	skipped_line = line;
}
void
test_skipping(const char *fmt, ...)
{
	va_list ap;

	if (previous_failures(skipped_filename, skipped_line))
		return;

	va_start(ap, fmt);
	fprintf(stderr, " *** SKIPPING: ");
	vfprintf(stderr, fmt, ap);
	fprintf(stderr, "\n");
	va_end(ap);
	++skips;
}

/* Common handling of failed tests. */
static void
report_failure(void *extra)
{
	if (msg[0] != '\0') {
		fprintf(stderr, "   Description: %s\n", msg);
		msg[0] = '\0';
	}
	if (extra != NULL) {
		fprintf(stderr, "   archive error: %s\n", archive_error_string((struct archive *)extra));
	}

	if (dump_on_failure) {
		fprintf(stderr,
		    " *** forcing core dump so failure can be debugged ***\n");
		*(char *)(NULL) = 0;
		exit(1);
	}
}

/*
 * Summarize repeated failures in the just-completed test file.
 * The reports above suppress multiple failures from the same source
 * line; this reports on any tests that did fail multiple times.
 */
static int
summarize_comparator(const void *a0, const void *b0)
{
	const struct line *a = a0, *b = b0;
	if (a->line == 0 && b->line == 0)
		return (0);
	if (a->line == 0)
		return (1);
	if (b->line == 0)
		return (-1);
	return (a->line - b->line);
}

static void
summarize(void)
{
	unsigned int i;

	qsort(failed_lines, sizeof(failed_lines)/sizeof(failed_lines[0]),
	    sizeof(failed_lines[0]), summarize_comparator);
	for (i = 0; i < sizeof(failed_lines)/sizeof(failed_lines[0]); i++) {
		if (failed_lines[i].line == 0)
			break;
		if (failed_lines[i].count > 1)
			fprintf(stderr, "%s:%d: Failed %d times\n",
			    failed_filename, failed_lines[i].line,
			    failed_lines[i].count);
	}
	/* Clear the failure history for the next file. */
	memset(failed_lines, 0, sizeof(failed_lines));
}

/* Set up a message to display only after a test fails. */
void
failure(const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	vsprintf(msg, fmt, ap);
	va_end(ap);
}

/* Generic assert() just displays the failed condition. */
void
test_assert(const char *file, int line, int value, const char *condition, void *extra)
{
	if (value) {
		msg[0] = '\0';
		return;
	}
	failures ++;
	if (previous_failures(file, line))
		return;
	fprintf(stderr, "%s:%d: Assertion failed\n", file, line);
	fprintf(stderr, "   Condition: %s\n", condition);
	report_failure(extra);
}

/* assertEqualInt() displays the values of the two integers. */
void
test_assert_equal_int(const char *file, int line,
    int v1, const char *e1, int v2, const char *e2, void *extra)
{
	if (v1 == v2) {
		msg[0] = '\0';
		return;
	}
	failures ++;
	if (previous_failures(file, line))
		return;
	fprintf(stderr, "%s:%d: Assertion failed: Ints not equal\n",
	    file, line);
	fprintf(stderr, "      %s=%d\n", e1, v1);
	fprintf(stderr, "      %s=%d\n", e2, v2);
	report_failure(extra);
}

/* assertEqualString() displays the values of the two strings. */
void
test_assert_equal_string(const char *file, int line,
    const char *v1, const char *e1,
    const char *v2, const char *e2,
    void *extra)
{
	if (v1 == NULL || v2 == NULL) {
		if (v1 == v2) {
			msg[0] = '\0';
			return;
		}
	} else if (strcmp(v1, v2) == 0) {
		msg[0] = '\0';
		return;
	}
	failures ++;
	if (previous_failures(file, line))
		return;
	fprintf(stderr, "%s:%d: Assertion failed: Strings not equal\n",
	    file, line);
	fprintf(stderr, "      %s = \"%s\"\n", e1, v1);
	fprintf(stderr, "      %s = \"%s\"\n", e2, v2);
	report_failure(extra);
}

/* assertEqualWString() displays the values of the two strings. */
void
test_assert_equal_wstring(const char *file, int line,
    const wchar_t *v1, const char *e1,
    const wchar_t *v2, const char *e2,
    void *extra)
{
	if (wcscmp(v1, v2) == 0) {
		msg[0] = '\0';
		return;
	}
	failures ++;
	if (previous_failures(file, line))
		return;
	fprintf(stderr, "%s:%d: Assertion failed: Unicode strings not equal\n",
	    file, line);
	fwprintf(stderr, L"      %s = \"%ls\"\n", e1, v1);
	fwprintf(stderr, L"      %s = \"%ls\"\n", e2, v2);
	report_failure(extra);
}

/* assertEqualMem() displays the values of the two strings. */
void
test_assert_equal_mem(const char *file, int line,
    const char *v1, const char *e1,
    const char *v2, const char *e2,
    size_t l, const char *ld, void *extra)
{
	unsigned int i;

	if (v1 == NULL || v2 == NULL) {
		if (v1 == v2) {
			msg[0] = '\0';
			return;
		}
	} else if (memcmp(v1, v2, l) == 0) {
		msg[0] = '\0';
		return;
	}
	failures ++;
	if (previous_failures(file, line))
		return;
	fprintf(stderr, "%s:%d: Assertion failed: memory not equal\n",
	    file, line);
	fprintf(stderr, "      size %s = %d\n", ld, (int)l);
	fprintf(stderr, "      %s = ", e1);
	for(i=0; i < 32 && i < l; i++) {
		int c = v1[i];
		if (c >= ' ' && c <= 126)
			fprintf(stderr, "'%c'", c);
		else
			fprintf(stderr, "0x%02x", c);
		if (i < l)
			fprintf(stderr, ", ");
	}
	fprintf(stderr, "\n");
	fprintf(stderr, "      %s = ", e2);
	for(i=0; i < 32 && i < l; i++) {
		int c = v2[i];
		if (c >= ' ' && c <= 126)
			fprintf(stderr, "'%c'", c);
		else
			fprintf(stderr, "0x%02x", c);
		if (i < l)
			fprintf(stderr, ", ");
	}
	fprintf(stderr, "\n");
	report_failure(extra);
}


/*
 * Call standard system() call, but build up the command line using
 * sprintf() conventions.
 */
int
systemf(const char *fmt, ...)
{
	char buff[8192];
	va_list ap;
	int r;

	va_start(ap, fmt);
	vsprintf(buff, fmt, ap);
	r = system(buff);
	va_end(ap);
	return (r);
}

/*
 * Slurp a file into memory for ease of comparison and testing.
 * Returns size of file in 'sizep' if non-NULL, null-terminates
 * data in memory for ease of use.
 */
char *
slurpfile(size_t * sizep, const char *fmt, ...)
{
	char filename[8192];
	struct stat st;
	va_list ap;
	char *p;
	ssize_t bytes_read;
	int fd;
	int r;

	va_start(ap, fmt);
	vsprintf(filename, fmt, ap);
	va_end(ap);

	fd = open(filename, O_RDONLY);
	if (fd < 0) {
		/* Note: No error; non-existent file is okay here. */
		return (NULL);
	}
	r = fstat(fd, &st);
	if (r != 0) {
		fprintf(stderr, "Can't stat file %s\n", filename);
		close(fd);
		return (NULL);
	}
	p = malloc(st.st_size + 1);
	if (p == NULL) {
		fprintf(stderr, "Can't allocate %ld bytes of memory to read file %s\n", (long int)st.st_size, filename);
		close(fd);
		return (NULL);
	}
	bytes_read = read(fd, p, st.st_size);
	if (bytes_read < st.st_size) {
		fprintf(stderr, "Can't read file %s\n", filename);
		close(fd);
		free(p);
		return (NULL);
	}
	p[st.st_size] = '\0';
	if (sizep != NULL)
		*sizep = (size_t)st.st_size;
	close(fd);
	return (p);
}

/*
 * "list.h" is automatically generated; it just has a lot of lines like:
 * 	DEFINE_TEST(function_name)
 * The common "test.h" includes it to declare all of the test functions.
 * We reuse it here to define a list of all tests to run.
 */
#undef DEFINE_TEST
#define DEFINE_TEST(n) { n, #n },
struct { void (*func)(void); const char *name; } tests[] = {
	#include "list.h"
};

/*
 * Each test is run in a private work dir.  Those work dirs
 * do have consistent and predictable names, in case a group
 * of tests need to collaborate.  However, there is no provision
 * for requiring that tests run in a certain order.
 */
static int test_run(int i, const char *tmpdir)
{
	int failures_before = failures;

	if (!quiet_flag)
		printf("%d: %s\n", i, tests[i].name);
	/*
	 * Always explicitly chdir() in case the last test moved us to
	 * a strange place.
	 */
	if (chdir(tmpdir)) {
		fprintf(stderr,
		    "ERROR: Couldn't chdir to temp dir %s\n",
		    tmpdir);
		exit(1);
	}
	/* Create a temp directory for this specific test. */
	if (mkdir(tests[i].name, 0755)) {
		fprintf(stderr,
		    "ERROR: Couldn't create temp dir ``%s''\n",
		    tests[i].name);
		exit(1);
	}
	/* Chdir() to that work directory. */
	if (chdir(tests[i].name)) {
		fprintf(stderr,
		    "ERROR: Couldn't chdir to temp dir ``%s''\n",
		    tests[i].name);
		exit(1);
	}
	/* Run the actual test. */
	(*tests[i].func)();
	/* Summarize the results of this test. */
	summarize();
	/* Return appropriate status. */
	return (failures == failures_before ? 0 : 1);
}

static void usage(const char *program)
{
	static const int limit = sizeof(tests) / sizeof(tests[0]);
	int i;

	printf("Usage: %s [options] <test> <test> ...\n", program);
	printf("Default is to run all tests.\n");
	printf("Otherwise, specify the numbers of the tests you wish to run.\n");
	printf("Options:\n");
	printf("  -k  Keep running after failures.\n");
	printf("      Default: Core dump after any failure.\n");
	printf("  -q  Quiet.\n");
	printf("  -r <dir>   Path to dir containing reference files.\n");
	printf("      Default: Current directory.\n");
	printf("Available tests:\n");
	for (i = 0; i < limit; i++)
		printf("  %d: %s\n", i, tests[i].name);
	exit(1);
}

int main(int argc, char **argv)
{
	static const int limit = sizeof(tests) / sizeof(tests[0]);
	int i, tests_run = 0, tests_failed = 0, opt;
	time_t now;
	char *progname, *p;
	char tmpdir[256];
	char tmpdir_timestamp[256];

	/*
	 * Name of this program, used to build root of our temp directory
	 * tree.
	 */
	progname = p = argv[0];
	while (*p != '\0') {
		if (*p == '/')
			progname = p + 1;
		++p;
	}

	/* Get the directory holding test files from environment. */
	refdir = getenv("LIBARCHIVE_TEST_FILES");

	/*
	 * Parse options.
	 */
	while ((opt = getopt(argc, argv, "kqr:")) != -1) {
		switch (opt) {
		case 'k':
			dump_on_failure = 0;
			break;
		case 'q':
			quiet_flag++;
			break;
		case 'r':
			refdir = optarg;
			break;
		case '?':
		default:
			usage(progname);
		}
	}
	argc -= optind;
	argv += optind;

	/*
	 * Create a temp directory for the following tests.
	 * Include the time the tests started as part of the name,
	 * to make it easier to track the results of multiple tests.
	 */
	now = time(NULL);
	for (i = 0; i < 1000; i++) {
		strftime(tmpdir_timestamp, sizeof(tmpdir_timestamp),
		    "%Y-%m-%dT%H.%M.%S",
		    localtime(&now));
		sprintf(tmpdir, "/tmp/%s.%s-%03d", progname, tmpdir_timestamp, i);
		if (mkdir(tmpdir,0755) == 0)
			break;
		if (errno == EEXIST)
			continue;
		fprintf(stderr, "ERROR: Unable to create temp directory %s\n",
		    tmpdir);
		exit(1);
	}

	/*
	 * If the user didn't specify a directory for locating
	 * reference files, use the current directory for that.
	 */
	if (refdir == NULL) {
		systemf("/bin/pwd > %s/refdir", tmpdir);
		refdir = slurpfile(NULL, "%s/refdir", tmpdir);
		p = refdir + strlen(refdir);
		while (p[-1] == '\n') {
			--p;
			*p = '\0';
		}
	}

	/*
	 * Banner with basic information.
	 */
	if (!quiet_flag) {
		printf("Running tests in: %s\n", tmpdir);
		printf("Reference files will be read from: %s\n", refdir);
		printf("Exercising %s\n", archive_version());
	}

	/*
	 * Run some or all of the individual tests.
	 */
	if (argc == 0) {
		/* Default: Run all tests. */
		for (i = 0; i < limit; i++) {
			if (test_run(i, tmpdir))
				tests_failed++;
			tests_run++;
		}
	} else {
		while (*(argv) != NULL) {
			i = atoi(*argv);
			if (**argv < '0' || **argv > '9' || i < 0 || i >= limit) {
				printf("*** INVALID Test %s\n", *argv);
				usage(progname);
			} else {
				if (test_run(i, tmpdir))
					tests_failed++;
				tests_run++;
			}
			argv++;
		}
	}

	/*
	 * Report summary statistics.
	 */
	if (!quiet_flag) {
		printf("\n");
		printf("%d of %d test groups reported failures\n",
		    tests_failed, tests_run);
		printf(" Total of %d individual tests failed.\n", failures);
		printf(" Total of %d individual tests were skipped.\n", skips);
	}
	return (tests_failed);
}