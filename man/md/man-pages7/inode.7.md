# inode(7) - file inode information

Linux, 2017-09-15


<a name="description"></a>

# Description

Each file has an inode containing metadata about the file.
An application can retrieve this metadata using
**stat**(2)
(or related calls), which returns a
_stat_
structure, or
**statx**(2),
which returns a
_statx_
structure.

The following is a list of the information typically found in,
or associated with, the file inode,
with the names of the corresponding structure fields returned by
**stat**(2)
and
**statx**(2):

* Device where inode resides  
  _stat.st\_dev_; _statx.stx\_dev\_minor_ and _statx.stx\_dev\_major_
* Each inode (as well as the associated file) resides in a filesystem
  that is hosted on a device.
  That device is identified by the combination of its major ID
  (which identifies the general class of device)
  and minor ID (which identifies a specific instance in the general class).
* Inode number  
  _stat.st\_ino_; _statx.stx\_ino_
* Each file in a filesystem has a unique inode number.
  Inode numbers are guaranteed to be unique only within a filesystem
  (i.e., the same inode numbers may be used by different filesystems,
  which is the reason that hard links may not cross filesystem boundaries).
  This field contains the file's inode number.
* File type and mode  
  _stat.st\_mode_; _statx.stx\_mode_
* See the discussion of file type and mode, below.
* Link count  
  _stat.st\_nlink_; _statx.stx\_nlink_
* This field contains the number of hard links to the file.
  Additional links to an existing file are created using
  **link**(2).
* User ID  
  _st_uid_
  _stat.st\_uid_; _statx.stx\_uid_
* This field records the user ID of the owner of the file.
  For newly created files,
  the file user ID is the effective user ID of the creating process.
  The user ID of a file can be changed using
  **chown**(2).
* Group ID  
  _stat.st\_gid_; _statx.stx\_gid_
* The inode records the ID of the group owner of the file.
  For newly created files,
  the file group ID is either the group ID of the parent directory or
  the effective group ID of the creating process,
  depending on whether or not the set-group-ID bit
  is set on the parent directory (see below).
  The group ID of a file can be changed using
  **chown**(2).
* Device represented by this inode  
  _stat.st\_rdev_; _statx.stx\_rdev\_minor_ and _statx.stx\_rdev\_major_
* If this file (inode) represents a device,
  then the inode records the major and minor ID of that device.
* File size  
  _stat.st\_size_; _statx.stx\_size_
* This field gives the size of the file (if it is a regular
  file or a symbolic link) in bytes.
  The size of a symbolic link is the length of the pathname
  it contains, without a terminating null byte.
* Preferred block size for I/O  
  _stat.st\_blksize_; _statx.stx\_blksize_
* This field gives the "preferred" blocksize for efficient filesystem I/O.
  (Writing to a file in smaller chunks may cause
  an inefficient read-modify-rewrite.)
* Number of blocks allocated to the file  
  _stat.st\_blocks_; _statx.stx\_size_
* This field indicates the number of blocks allocated to the file,
  512-byte units,
  (This may be smaller than
  _st_size_/512
  when the file has holes.)
* The POSIX.1 standard notes
  
  that the unit for the
  _st_blocks_
  member of the
  _stat_
  structure is not defined by the standard.
  On many  implementations it is 512 bytes;
  on a few systems, a different unit is used, such as 1024.
  Furthermore, the unit may differ on a per-filesystem basis.
* Last access timestamp (atime)  
  _stat.st\_atime_; _statx.stx\_atime_
* This is the file's last access timestamp.
  It is changed by file accesses, for example, by
  **execve**(2),
  **mknod**(2),
  **pipe**(2),
  **utime**(2),
  and
  **read**(2)
  (of more than zero bytes).
  Other interfaces, such as
  **mmap**(2),
  may or may not update the atime timestamp
* Some filesystem types allow mounting in such a way that file
  and/or directory accesses do not cause an update of the atime timestamp.
  (See
  _noatime_,
  _nodiratime_,
  and
  _relatime_
  in
  **mount**(8),
  and related information in
  **mount**(2).)
  In addition, the atime timestamp
  is not updated if a file is opened with the
  **O_NOATIME**
  flag; see
  **open**(2).
* File creation (birth) timestamp (btime)  
  (not returned in the _stat_ structure); _statx.stx\_btime_
* The file's creation timestamp.
  This is set on file creation and not changed subsequently.
* The btime timestamp was not historically present on UNIX systems
  and is not currently supported by most Linux filesystems.
  
* Last modification timestamp (mtime)  
  _stat.st\_atime_; _statx.stx\_mtime_
* This is the file's last modification timestamp.
  It is changed by file modifications, for example, by
  **mknod**(2),
  **truncate**(2),
  **utime**(2),
  and
  **write**(2)
  (of more than zero bytes).
  Moreover, the mtime timestamp
  of a directory is changed by the creation or deletion of files
  in that directory.
  The mtime timestamp is
  _not_
  changed for changes in owner, group, hard link count, or mode.
* Last status change timestamp (ctime)  
  _stat.st\_ctime_; _statx.stx\_ctime_
* This is the file's last status change timestamp.
  It is changed by writing or by setting inode information
  (i.e., owner, group, link count, mode, etc.).

Nanosecond timestamps are supported on XFS, JFS, Btrfs, and
ext4 (since Linux 2.6.23).

Nanosecond timestamps are not supported in ext2, ext3, and Reiserfs.
On filesystems that do not support subsecond timestamps,
the nanosecond fields in the
_stat_
and
_statx_
structures are returned with the value 0.


<a name="the-file-type-and-mode"></a>

### The file type and mode

The
_stat.st_mode_
field (for
**statx**(2),
the
_statx.stx_mode_
field) contains the file type and mode.

POSIX refers to the
_stat.st_mode_
bits corresponding to the mask
**S_IFMT**
(see below) as the
_file type_,
the 12 bits corresponding to the mask 07777 as the
_file mode bits_
and the least significant 9 bits (0777) as the
_file permission bits_.

The following mask values are defined for the file type:
.in +4n
.TS
lB l l.
S_IFMT	0170000	bit mask for the file type bit field

S_IFSOCK	0140000	socket
S_IFLNK	0120000	symbolic link
S_IFREG	0100000	regular file
S_IFBLK	0060000	block device
S_IFDIR	0040000	directory
S_IFCHR	0020000	character device
S_IFIFO	0010000	FIFO
.TE
.in

Thus, to test for a regular file (for example), one could write:

.in +4n
.EX
stat(pathname, &sb);
if ((sb.st_mode & S_IFMT) == S_IFREG) {
    /* Handle regular file */
}
.EE
.in

Because tests of the above form are common, additional
macros are defined by POSIX to allow the test of the file type in
_st_mode_
to be written more concisely:

* **S_ISREG**(m)  
  is it a regular file?
* **S_ISDIR**(m)  
  directory?
* **S_ISCHR**(m)  
  character device?
* **S_ISBLK**(m)  
  block device?
* **S_ISFIFO**(m)  
  FIFO (named pipe)?
* **S_ISLNK**(m)  
  symbolic link?  (Not in POSIX.1-1996.)
* **S_ISSOCK**(m)  
  socket?  (Not in POSIX.1-1996.)

The preceding code snippet could thus be rewritten as:

.in +4n
.EX
stat(pathname, &sb);
if (S_ISREG(sb.st_mode)) {
    /* Handle regular file */
}
.EE
.in

The definitions of most of the above file type test macros
are provided if any of the following feature test macros is defined:
**_BSD_SOURCE**
(in glibc 2.19 and earlier),
**_SVID_SOURCE**
(in glibc 2.19 and earlier),
or
**_DEFAULT_SOURCE**
(in glibc 2.20 and later).
In addition, definitions of all of the above macros except
**S_IFSOCK**
and
**S_ISSOCK**()
are provided if
**_XOPEN_SOURCE**
is defined.

The definition of
**S_IFSOCK**
can also be exposed either by defining
**_XOPEN_SOURCE**
with a value of 500 or greater or (since glibc 2.24) by defining both
**_XOPEN_SOURCE**
and
**_XOPEN_SOURCE_EXTENDED**.

The definition of
**S_ISSOCK**()
is exposed if any of the following feature test macros is defined:
**_BSD_SOURCE**
(in glibc 2.19 and earlier),
**_DEFAULT_SOURCE**
(in glibc 2.20 and later),
**_XOPEN_SOURCE**
with a value of 500 or greater,
**_POSIX_C_SOURCE**
with a value of 200112L or greater, or (since glibc 2.24) by defining both
**_XOPEN_SOURCE**
and
**_XOPEN_SOURCE_EXTENDED**.

The following mask values are defined for
the file mode component of the
_st_mode_
field:
.in +4n
.TS
lB l l.
S_ISUID	  04000	set-user-ID bit
S_ISGID	  02000	set-group-ID bit (see below)
S_ISVTX	  01000	sticky bit (see below)

S_IRWXU	  00700	owner has read, write, and execute permission
S_IRUSR	  00400	owner has read permission
S_IWUSR	  00200	owner has write permission
S_IXUSR	  00100	owner has execute permission

S_IRWXG	  00070	group has read, write, and execute permission
S_IRGRP	  00040	group has read permission
S_IWGRP	  00020	group has write permission
S_IXGRP	  00010	group has execute permission

S_IRWXO	  00007	T{
others (not in group) have read, write, and execute permission
T}
S_IROTH	  00004	others have read permission
S_IWOTH	  00002	others have write permission
S_IXOTH	  00001	others have execute permission
.TE
.in

The set-group-ID bit
(**S_ISGID**)
has several special uses.
For a directory, it indicates that BSD semantics is to be used
for that directory: files created there inherit their group ID from
the directory, not from the effective group ID of the creating process,
and directories created there will also get the
**S_ISGID**
bit set.
For a file that does not have the group execution bit
(**S_IXGRP**)
set,
the set-group-ID bit indicates mandatory file/record locking.

The sticky bit
(**S_ISVTX**)
on a directory means that a file
in that directory can be renamed or deleted only by the owner
of the file, by the owner of the directory, and by a privileged
process.

<a name="conforming-to"></a>

# Conforming to

If you need to obtain the definition of the
_blkcnt_t_
or
_blksize_t_
types from
_&lt;sys/stat.h&gt;_,
then define
**_XOPEN_SOURCE**
with the value 500 or greater (before including
_any_
header files).

POSIX.1-1990 did not describe the
**S_IFMT**,
**S_IFSOCK**,
**S_IFLNK**,
**S_IFREG**,
**S_IFBLK**,
**S_IFDIR**,
**S_IFCHR**,
**S_IFIFO**,
**S_ISVTX**
constants, but instead specified the use of
the macros
**S_ISDIR**(),
and so on.
The
**S_IF***
constants are present in POSIX.1-2001 and later.

The
**S_ISLNK**()
and
**S_ISSOCK**()
macros were not in
POSIX.1-1996, but both are present in POSIX.1-2001;
the former is from SVID 4, the latter from SUSv2.

UNIX&nbsp;V7 (and later systems) had
**S_IREAD**,
**S_IWRITE**,
**S_IEXEC**,
where POSIX
prescribes the synonyms
**S_IRUSR**,
**S_IWUSR**,
**S_IXUSR**.

<a name="notes"></a>

# Notes

For pseudofiles that are autogenerated by the kernel, the file size
(_stat.st\_size_; _statx.stx\_size_)
reported by the kernel is not accurate.
For example, the value 0 is returned for many files under the
_/proc_
directory,
while various files under
_/sys_
report a size of 4096 bytes, even though the file content is smaller.
For such files, one should simply try to read as many bytes as possible
(and append '\e0' to the returned buffer
if it is to be interpreted as a string).
_st_atimensec_.

<a name="see-also"></a>

# See Also

**stat**(1),
**stat**(2),
**statx**(2),
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
