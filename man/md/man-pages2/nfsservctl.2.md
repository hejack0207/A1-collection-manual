# nfsservctl(2) - syscall interface to kernel nfs daemon

Linux, 2017-09-15

    #include <linux/nfsd/syscall.h>
    
    long nfsservctl(int cmd, struct nfsctl_arg *argp,
                    union nfsctl_res *resp);

<a name="description"></a>

# Description

_Note_:
Since Linux 3.1, this system call no longer exists.
It has been replaced by a set of files in the
_nfsd_
filesystem; see
**nfsd**(7).

.in +4n
.EX
/*
 * These are the commands understood by nfsctl().
 */
#define NFSCTL_SVC        0  /* This is a server process. */
#define NFSCTL_ADDCLIENT  1  /* Add an NFS client. */
#define NFSCTL_DELCLIENT  2  /* Remove an NFS client. */
#define NFSCTL_EXPORT     3  /* Export a filesystem. */
#define NFSCTL_UNEXPORT   4  /* Unexport a filesystem. */
#define NFSCTL_UGIDUPDATE 5  /* Update a client's UID/GID map
                                (only in Linux 2.4.x and earlier). */
#define NFSCTL_GETFH      6  /* Get a file handle (used by mountd)
                                (only in Linux 2.4.x and earlier). */

struct nfsctl_arg {
    int                       ca_version;     /* safeguard */
    union {
        struct nfsctl_svc     u_svc;
        struct nfsctl_client  u_client;
        struct nfsctl_export  u_export;
        struct nfsctl_uidmap  u_umap;
        struct nfsctl_fhparm  u_getfh;
        unsigned int          u_debug;
    } u;
}

union nfsctl_res {
        struct knfs_fh          cr_getfh;
        unsigned int            cr_debug;
};
.EE
.in

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="conforming-to"></a>

# Conforming to

This call is Linux-specific.

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
