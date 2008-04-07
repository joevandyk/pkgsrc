/*	$NetBSD: sha1hl.c,v 1.7 2007/09/21 18:44:37 joerg Exp $	*/

/* sha1hl.c
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <phk@login.dkuug.dk> wrote this file.  As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.   Poul-Henning Kamp
 * ----------------------------------------------------------------------------
 */

/* #include "namespace.h" */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#ifdef HAVE_FCNTL_H
#include <fcntl.h>
#endif
#ifdef HAVE_SYS_FILE_H
#include <sys/file.h>
#endif
#include <sys/uio.h>

#include <assert.h>
#include <errno.h>
#include <sha1.h>
#include <stdio.h>
#include <stdlib.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

#if defined(LIBC_SCCS) && !defined(lint)
__RCSID("$NetBSD: sha1hl.c,v 1.7 2007/09/21 18:44:37 joerg Exp $");
#endif /* LIBC_SCCS and not lint */

#ifndef _DIAGASSERT
#define _DIAGASSERT(cond)	assert(cond)
#endif

/* ARGSUSED */
char *
SHA1End(SHA1_CTX *ctx, char *buf)
{
    int i;
    char *p = buf;
    uint8_t digest[20];
    static const char hex[]="0123456789abcdef";

    _DIAGASSERT(ctx != NULL);
    /* buf may be NULL */

    if (p == NULL && (p = malloc(41)) == NULL)
	return 0;

    SHA1Final(digest,ctx);
    for (i = 0; i < 20; i++) {
	p[i + i] = hex[((uint32_t)digest[i]) >> 4];
	p[i + i + 1] = hex[digest[i] & 0x0f];
    }
    p[i + i] = '\0';
    return(p);
}

char *
SHA1File(char *filename, char *buf)
{
    uint8_t buffer[BUFSIZ];
    SHA1_CTX ctx;
    int fd, oerrno;
    size_t num;

    _DIAGASSERT(filename != NULL);
    /* XXX: buf may be NULL ? */

    SHA1Init(&ctx);

    if ((fd = open(filename,O_RDONLY)) < 0)
	return(0);

    while ((num = read(fd, buffer, sizeof(buffer))) > 0)
	SHA1Update(&ctx, buffer, (size_t)num);

    oerrno = errno;
    close(fd);
    errno = oerrno;
    return(num < 0 ? 0 : SHA1End(&ctx, buf));
}

char *
SHA1Data(const uint8_t *data, size_t len, char *buf)
{
    SHA1_CTX ctx;

    _DIAGASSERT(data != NULL);
    /* XXX: buf may be NULL ? */

    SHA1Init(&ctx);
    SHA1Update(&ctx, data, len);
    return(SHA1End(&ctx, buf));
}
