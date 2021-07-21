# readdir(3am) - directory input parser for gawk

Free Software Foundation, Oct 30 2019

```
@load "readdir"
```

<a name="description"></a>

# Description

The
_readdir_
extension
adds an input parser for directories.

When this extension is in use, instead of skipping directories named
on the command line (or with
**getline**),
they are read, with each entry returned as a record.

The record consists of three fields. The first two are the inode number and the
filename, separated by a forward slash character.
On systems where the directory entry contains the file type, the record
has a third field which is a single letter indicating the type of the
file:
**f**
for file,
**d**
for directory,
**b**
for a block device,
**c**
for a character device,
**p**
for a FIFO,
**l**
for a symbolic link,
**s**
for a socket.

On systems without the file type information, the extension falls back
to calling
_stat_(2),
in order to provide the information.
Thus the third field should never be
**u**.

By default, if a directory cannot be opened (due to permission problems,
for example),
_gawk_
will exit.
As with regular files, this situation can be handled using a
**BEGINFILE**
rule that checks
**ERRNO**
and prints an error or otherwise handles the problem.


<a name="example"></a>

# Example

    @load "readdir"
    ...
    BEGIN { FS = "/" }
    { print "file name is", $2 }

<a name="see-also"></a>

# See Also

_GAWK: Effective AWK Programming_,
_filefuncs_(3am),
_fnmatch_(3am),
_fork_(3am),
_inplace_(3am),
_ordchr_(3am),
_readfile_(3am),
_revoutput_(3am),
_rwarray_(3am),
_time_(3am).

_opendir_(3),
_readdir_(3),
_stat_(2).

<a name="author"></a>

# Author

Arnold Robbins,
**[arnold@skeeve.com](mailto:arnold@skeeve.com)**.

<a name="copying-permissions"></a>

# Copying Permissions

Copyright © 2012, 2013, 2018, 2019
Free Software Foundation, Inc.

Permission is granted to make and distribute verbatim copies of
this manual page provided the copyright notice and this permission
notice are preserved on all copies.

Permission is granted to copy and distribute modified versions of this
manual page under the conditions for verbatim copying, provided that
the entire resulting derived work is distributed under the terms of a
permission notice identical to this one.

Permission is granted to copy and distribute translations of this
manual page into another language, under the above conditions for
modified versions, except that this permission notice may be stated in
a translation approved by the Foundation.

