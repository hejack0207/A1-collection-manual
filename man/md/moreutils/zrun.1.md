# zrun(1)

moreutils, 2015-07-13

.if n .ad l
.nh

<a name="name"></a>

# Name

zrun - automatically uncompress arguments to command

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" zrun command file.gz [...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Prefixing a shell command with zrun\*(R" causes any compressed files that are
arguments of the command to be transparently uncompressed to temp files
(not pipes) and the uncompressed files fed to the command.

This is a quick way to run a command that does not itself support
compressed files, without manually uncompressing the files.

The following compression types are supported: gz bz2 Z xz lzma lzo

If zrun is linked to some name beginning with z, like zprog, and the link is
executed, this is equivalent to executing zrun prog\*(R".

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
Modifications to the uncompressed temporary file are not fed back into the
input file, so using this as a quick way to make an editor support
compressed files won't work.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Copyright 2006 by Chung-chieh Shan &lt;[ccshan@post.harvard](mailto:ccshan@post.harvard).edu&gt;
