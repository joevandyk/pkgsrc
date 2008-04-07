/*	$NetBSD: libsetenv.c,v 1.1.1.1 2007/08/03 21:30:59 tnn Exp $	*/

/*
 * Copyright (c) 1987, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

extern char **environ;

/*
 * __findenv --
 *	Returns pointer to value associated with name, if any, else NULL.
 *	Sets offset to be the offset of the name/value combination in the
 *	environmental array, for use by setenv(3) and unsetenv(3).
 *	Explicitly removes '=' in argument name.
 *
 *	This routine *should* be a static; don't use it.
 */
static char *
__findenv(const char *name, int *offset)
{
	size_t len;
	const char *np;
	char **p, *c;

	if (name == NULL || environ == NULL)
		return NULL;
	for (np = name; *np && *np != '='; ++np)
		continue;
	len = np - name;
	for (p = environ; (c = *p) != NULL; ++p)
		if (strncmp(c, name, len) == 0 && c[len] == '=') {
			*offset = p - environ;
			return c + len + 1;
		}
	return NULL;
}

/*
 * setenv --
 *	Set the value of the environmental variable "name" to be
 *	"value".  If rewrite is set, replace any current value.
 */
int
setenv(name, value, rewrite)
	const char *name;
	const char *value;
	int rewrite;
{
	static char **saveenv;	/* copy of previously allocated space */
	char *c, **newenv;
	const char *cc;
	size_t l_value, size;
	int offset;

	if (*value == '=')			/* no `=' in value */
		++value;
	l_value = strlen(value);
	/* find if already exists */
	if ((c = __findenv(name, &offset)) != NULL) {
		if (!rewrite)
			goto good;
		if (strlen(c) >= l_value)	/* old larger; copy over */
			goto copy;
	} else {					/* create new slot */
		size_t cnt;

		for (cnt = 0; environ[cnt]; ++cnt)
			continue;
		size = (size_t)(sizeof(char *) * (cnt + 2));
		if (saveenv == environ) {		/* just increase size */
			if ((newenv = realloc(saveenv, size)) == NULL)
				goto bad;
			saveenv = newenv;
		} else {				/* get new space */
			free(saveenv);
			if ((saveenv = malloc(size)) == NULL)
				goto bad;
			(void)memcpy(saveenv, environ, cnt * sizeof(char *));
		}
		environ = saveenv;
		environ[cnt + 1] = NULL;
		offset = (int)cnt;
	}
	for (cc = name; *cc && *cc != '='; ++cc)	/* no `=' in name */
		continue;
	size = cc - name;
	/* name + `=' + value */
	if ((environ[offset] = malloc(size + l_value + 2)) == NULL)
		goto bad;
	c = environ[offset];
	(void)memcpy(c, name, size);
	c += size;
	*c++ = '=';
copy:
	(void)memcpy(c, value, l_value + 1);
good:
	return 0;
bad:
	return -1;
}

/*
 * unsetenv(name) --
 *	Delete environmental variable "name".
 */
int
unsetenv(name)
	const char *name;
{
	char **p;
	int offset;

	if (name == NULL || *name == '\0' || strchr(name, '=') != NULL) {
		errno = EINVAL;
		return -1;
	}

	while (__findenv(name, &offset))	/* if set multiple times */
		for (p = &environ[offset];; ++p)
			if (!(*p = *(p + 1)))
				break;

	return 0;
}
