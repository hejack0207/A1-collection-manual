# mklost+found(8) - create a lost+found directory on a mounted Linux

E2fsprogs version 1.45.6, March 2020

second extended file system

<a name="synopsis"></a>

# Synopsis

```
mklost+found
```

<a name="description"></a>

# Description

**mklost+found**
is used to create a
_lost+found_
directory in the current working directory on a Linux second extended
file system.  There is normally a
_lost+found_
directory in the root directory of each filesystem.

**mklost+found**
pre-allocates disk blocks to the
_lost+found_
directory so that when
**e2fsck**(8)
is being run to recover a filesystem, it does not need to allocate blocks in
the filesystem to store a large number of unlinked files.  This ensures that
**e2fsck**
will not have to allocate data blocks in the filesystem during recovery.

<a name="options"></a>

# Options

There are none.

<a name="author"></a>

# Author

**mklost+found**
has been written by Remy Card &lt;[Remy.Card@linux.org](mailto:Remy.Card@linux.org)&gt;.  It is currently being
maintained by Theodore Ts'o &lt;[tytso@alum.mit](mailto:tytso@alum.mit).edu&gt;.

<a name="bugs"></a>

# Bugs

There are none :-)

<a name="availability"></a>

# Availability

**mklost+found**
is part of the e2fsprogs package and is available from
http://e2fsprogs.sourceforge.net.

<a name="see-also"></a>

# See Also

**e2fsck**(8),
**mke2fs**(8)
