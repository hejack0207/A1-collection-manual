# stat(2) - get file status

Linux, 2017-09-15

    #include <sys/types.h>
    #include <sys/stat.h>
    #include <unistd.h>
    
    int stat(const char *pathname, struct stat *statbuf);
    int fstat(int fd, struct stat *statbuf);
    int lstat(const char *pathname, struct stat *statbuf);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <sys/stat.h>
    
    int fstatat(int dirfd, const char *pathname, struct stat *statbuf,
                int flags);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 lstat(): .RS 4 /* glibc 2.19 and earlier */ _BSD_SOURCE
|| /* Since glibc 2.20 */ _DEFAULT_SOURCE
|| _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>

|| /* Since glibc 2.10: */ _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L .RE 
 fstatat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE .RE
```

<a name="description"></a>

# Description


These functions return information about a file, in the buffer pointed to by
_statbuf_.
No permissions are required on the file itself, but—in the case of
**stat**(),
**fstatat**(),
and
**lstat**()—execute
(search) permission is required on all of the directories in
_pathname_
that lead to the file.

**stat**()
and
**fstatat**()
retrieve information about the file pointed to by
_pathname_;
the differences for
**fstatat**()
are described below.

**lstat**()
is identical to
**stat**(),
except that if
_pathname_
is a symbolic link, then it returns information about the link itself,
not the file that it refers to.

**fstat**()
is identical to
**stat**(),
except that the file about which information is to be retrieved
is specified by the file descriptor
_fd_.


<a name="the-stat-structure"></a>

### The stat structure

All of these system calls return a
_stat_
structure, which contains the following fields:

.in +4n
.EX
struct stat {
    dev_t     st_dev;         /* ID of device containing file */
    ino_t     st_ino;         /* Inode number */
    mode_t    st_mode;        /* File type and mode */
    nlink_t   st_nlink;       /* Number of hard links */
    uid_t     st_uid;         /* User ID of owner */
    gid_t     st_gid;         /* Group ID of owner */
    dev_t     st_rdev;        /* Device ID (if special file) */
    off_t     st_size;        /* Total size, in bytes */
    blksize_t st_blksize;     /* Block size for filesystem I/O */
    blkcnt_t  st_blocks;      /* Number of 512B blocks allocated */

    /* Since Linux 2.6, the kernel supports nanosecond
       precision for the following timestamp fields.
       For the details before Linux 2.6, see NOTES. */

    struct timespec st_atim;  /* Time of last access */
    struct timespec st_mtim;  /* Time of last modification */
    struct timespec st_ctim;  /* Time of last status change */

#define st_atime st_atim.tv_sec      /* Backward compatibility */
#define st_mtime st_mtim.tv_sec
#define st_ctime st_ctim.tv_sec
};
.EE
.in

_Note_:
the order of fields in the
_stat_
structure varies somewhat
across architectures.
In addition,
the definition above does not show the padding bytes
that may be present between some fields on various architectures.
Consult the glibc and kernel source code
if you need to know the details.



_Note_:
for performance and simplicity reasons, different fields in the
_stat_
structure may contain state information from different moments
during the execution of the system call.
For example, if
_st_mode_
or
_st_uid_
is changed by another process by calling
**chmod**(2)
or
**chown**(2),
**stat**()
might return the old
_st_mode_
together with the new
_st_uid_,
or the old
_st_uid_
together with the new
_st_mode_.

The fields in the
_stat_
structure are as follows:

* _st_dev_  
  This field describes the device on which this file resides.
  (The
  **major**(3)
  and
  **minor**(3)
  macros may be useful to decompose the device ID in this field.)
* _st_ino_  
  This field contains the file's inode number.
* _st_mode_  
  This field contains the file type and mode.
  See
  **inode**(7)
  for further information.
* _st_nlink_  
  This field contains the number of hard links to the file.
* _st_uid_  
  This field contains the user ID of the owner of the file.
* _st_gid_  
  This field contains the ID of the group owner of the file.
* _st_rdev_  
  This field describes the device that this file (inode) represents.
* _st_size_  
  This field gives the size of the file (if it is a regular
  file or a symbolic link) in bytes.
  The size of a symbolic link is the length of the pathname
  it contains, without a terminating null byte.
* _st_blksize_  
  This field gives the "preferred" block size for efficient filesystem I/O.
* _st_blocks_  
  This field indicates the number of blocks allocated to the file,
  in 512-byte units.
  (This may be smaller than
  _st_size_/512
  when the file has holes.)
* _st_atime_  
  This is the file's last access timestamp.
* _st_mtime_  
  This is the file's last modification timestamp.
* _st_ctime_  
  This is the file's last status change timestamp.

For further information on the above fields, see
**inode**(7).


<a name="fstatat"></a>

### fstatat()

The
**fstatat**()
system call is a more general interface for accessing file information
which can still provide exactly the behavior of each of
**stat**(),
**lstat**(),
and
**fstat**().

If the pathname given in
_pathname_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**stat**()
and
**lstat**()
for a relative pathname).

If
_pathname_
is relative and
_dirfd_
is the special value
**AT_FDCWD**,
then
_pathname_
is interpreted relative to the current working
directory of the calling process (like
**stat**()
and
**lstat**()).

If
_pathname_
is absolute, then
_dirfd_
is ignored.

_flags_
can either be 0, or include one or more of the following flags ORed:

* **AT_EMPTY_PATH** (since Linux 2.6.39)  
  
  If
  _pathname_
  is an empty string, operate on the file referred to by
  _dirfd_
  (which may have been obtained using the
  **open**(2)
  **O_PATH**
  flag).
  In this case,
  _dirfd_
  can refer to any type of file, not just a directory, and
  the behavior of
  **fstatat**()
  is similar to that of
  **fstat**().
  If
  _dirfd_
  is
  **AT_FDCWD**,
  the call operates on the current working directory.
  This flag is Linux-specific; define
  **_GNU_SOURCE**
  
  to obtain its definition.
* **AT_NO_AUTOMOUNT** (since Linux 2.6.38)  
  Don't automount the terminal ("basename") component of
  _pathname_
  if it is a directory that is an automount point.
  This allows the caller to gather attributes of an automount point
  (rather than the location it would mount).
  Since Linux 4.14,
  
  also don't instantiate a nonexistent name in an
  on-demand directory such as used for automounter indirect maps.
  This flag can be used in tools that scan directories
  to prevent mass-automounting of a directory of automount points.
  The
  **AT_NO_AUTOMOUNT**
  flag has no effect if the mount point has already been mounted over.
  This flag is Linux-specific; define
  **_GNU_SOURCE**
  
  to obtain its definition.
  Both
  **stat**()
  and
  **lstat**()
  act as though
  **AT_NO_AUTOMOUNT**
  was set.
* **AT_SYMLINK_NOFOLLOW**  
  If
  _pathname_
  is a symbolic link, do not dereference it:
  instead return information about the link itself, like
  **lstat**().
  (By default,
  **fstatat**()
  dereferences symbolic links, like
  **stat**().)

See
**openat**(2)
for an explanation of the need for
**fstatat**().

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EACCES**  
  Search permission is denied for one of the directories
  in the path prefix of
  _pathname_.
  (See also
  **path_resolution**(7).)
* **EBADF**  
  _fd_
  is not a valid open file descriptor.
* **EFAULT**  
  Bad address.
* **ELOOP**  
  Too many symbolic links encountered while traversing the path.
* **ENAMETOOLONG**  
  _pathname_
  is too long.
* **ENOENT**  
  A component of
  _pathname_
  does not exist, or
  _pathname_
  is an empty string and
  **AT_EMPTY_PATH**
  was not specified in
  _flags_.
* **ENOMEM**  
  Out of memory (i.e., kernel memory).
* **ENOTDIR**  
  A component of the path prefix of
  _pathname_
  is not a directory.
* **EOVERFLOW**  
  _pathname_
  or
  _fd_
  refers to a file whose size, inode number,
  or number of blocks cannot be represented in, respectively, the types
  _off_t_,
  _ino_t_,
  or
  _blkcnt_t_.
  This error can occur when, for example,
  an application compiled on a 32-bit platform without
  _-D_FILE_OFFSET_BITS=64_
  calls
  **stat**()
  on a file whose size exceeds
  _(1&lt;&lt;31)-1_
  bytes.

The following additional errors can occur for
**fstatat**():

* **EBADF**  
  _dirfd_
  is not a valid file descriptor.
* **EINVAL**  
  Invalid flag specified in
  _flags_.
* **ENOTDIR**  
  _pathname_
  is relative and
  _dirfd_
  is a file descriptor referring to a file other than a directory.

<a name="versions"></a>

# Versions

**fstatat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

**stat**(),
**fstat**(),
**lstat**():
SVr4, 4.3BSD, POSIX.1-2001, POSIX.1.2008.









**fstatat**():
POSIX.1-2008.

According to POSIX.1-2001,
**lstat**()
on a symbolic link need return valid information only in the
_st_size_
field and the file type of the
_st_mode_
field of the
_stat_
structure.
POSIX.1-2008 tightens the specification, requiring
**lstat**()
to return valid information in all fields except the mode bits in
_st_mode_.

Use of the
_st_blocks_
and
_st_blksize_
fields may be less portable.
(They were introduced in BSD.
The interpretation differs between systems,
and possibly on a single system when NFS mounts are involved.)

<a name="notes"></a>

# Notes


<a name="timestamp-fields"></a>

### Timestamp fields

Older kernels and older standards did not support nanosecond timestamp
fields.
Instead, there were three timestamp
fields—_st_atime_,
_st_mtime_,
and
_st_ctime_—typed
as
_time_t_
that recorded timestamps with one-second precision.

Since kernel 2.5.48, the
_stat_
structure supports nanosecond resolution for the three file timestamp fields.
The nanosecond components of each timestamp are available
via names of the form
_st_atim.tv_nsec_,
if suitable feature test macros are defined.
Nanosecond timestamps were standardized in POSIX.1-2008,
and, starting with version 2.12,
glibc exposes the nanosecond component names if
**_POSIX_C_SOURCE**
is defined with the value 200809L or greater, or
**_XOPEN_SOURCE**
is defined with the value 700 or greater.
Up to and including glibc 2.19,
the definitions of the nanoseconds components are also defined if
**_BSD_SOURCE**
or
**_SVID_SOURCE**
is defined.
If none of the aforementioned macros are defined,
then the nanosecond values are exposed with names of the form
_st_atimensec_.


<a name="c-librarykernel-differences"></a>

### C library/kernel differences

Over time, increases in the size of the
_stat_
structure have led to three successive versions of
**stat**():
_sys_stat_()
(slot
___NR_oldstat_),
_sys_newstat_()
(slot
___NR_stat_),
and
_sys_stat64()_
(slot
___NR_stat64_)
on 32-bit platforms such as i386.
The first two versions were already present in Linux 1.0
(albeit with different names);


the last was added in Linux 2.4.
Similar remarks apply for
**fstat**()
and
**lstat**().

The kernel-internal versions of the
_stat_
structure dealt with by the different versions are, respectively:

* ___old_kernel_stat_  
  The original structure, with rather narrow fields, and no padding.
* _stat_  
  Larger
  _st_ino_
  field and padding added to various parts of the structure to
  allow for future expansion.
* _stat64_  
  Even larger
  _st_ino_
  field,
  larger
  _st_uid_
  and
  _st_gid_
  fields to accommodate the Linux-2.4 expansion of UIDs and GIDs to 32 bits,
  and various other enlarged fields and further padding in the structure.
  (Various padding bytes were eventually consumed in Linux 2.6,
  with the advent of 32-bit device IDs and nanosecond components
  for the timestamp fields.)

The glibc
**stat**()
wrapper function hides these details from applications,
invoking the most recent version of the system call provided by the kernel,
and repacking the returned information if required for old binaries.





























On modern 64-bit systems, life is simpler: there is a single
**stat**()
system call and the kernel deals with a
_stat_
structure that contains fields of a sufficient size.

The underlying system call employed by the glibc
**fstatat**()
wrapper function is actually called
**fstatat64**()
or, on some architectures,

**newfstatat**().

<a name="example"></a>

# Example

The following program calls
**lstat**()
and displays selected fields in the returned
_stat_
structure.

.EX
#include &lt;sys/types.h&gt;
#include &lt;sys/stat.h&gt;
#include &lt;time.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;sys/sysmacros.h&gt;

int
main(int argc, char *argv[])
{
    struct stat sb;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s &lt;pathname&gt;\\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    if (lstat(argv[1], &sb) == -1) {
        perror("lstat");
        exit(EXIT_FAILURE);
    }

    printf("ID of containing device:  [%lx,%lx]\\n",
	    (long) major(sb.st_dev), (long) minor(sb.st_dev));

    printf("File type:                ");

    switch (sb.st_mode & S_IFMT) {
    case S_IFBLK:  printf("block device\\n");            break;
    case S_IFCHR:  printf("character device\\n");        break;
    case S_IFDIR:  printf("directory\\n");               break;
    case S_IFIFO:  printf("FIFO/pipe\\n");               break;
    case S_IFLNK:  printf("symlink\\n");                 break;
    case S_IFREG:  printf("regular file\\n");            break;
    case S_IFSOCK: printf("socket\\n");                  break;
    default:       printf("unknown?\\n");                break;
    }

    printf("I-node number:            %ld\\n", (long) sb.st_ino);

    printf("Mode:                     %lo (octal)\\n",
            (unsigned long) sb.st_mode);

    printf("Link count:               %ld\\n", (long) sb.st_nlink);
    printf("Ownership:                UID=%ld   GID=%ld\\n",
            (long) sb.st_uid, (long) sb.st_gid);

    printf("Preferred I/O block size: %ld bytes\\n",
            (long) sb.st_blksize);
    printf("File size:                %lld bytes\\n",
            (long long) sb.st_size);
    printf("Blocks allocated:         %lld\\n",
            (long long) sb.st_blocks);

    printf("Last status change:       %s", ctime(&sb.st_ctime));
    printf("Last file access:         %s", ctime(&sb.st_atime));
    printf("Last file modification:   %s", ctime(&sb.st_mtime));

    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**ls**(1),
**stat**(1),
**access**(2),
**chmod**(2),
**chown**(2),
**readlink**(2),
**utime**(2),
**capabilities**(7),
**inode**(7),
**symlink**(7)

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
