# sponge(1)

moreutils, 2006\-02\-19

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

sponge - soak up standard input and write to a file

<a name="synopsis"></a>

# Synopsis

```
.HP \w'sed&nbsp;...\*(Aq&nbsp;file&nbsp;|&nbsp;grep&nbsp;\*(Aq...\*(Aq&nbsp;|&nbsp;sponge&nbsp;[-a]&nbsp;file&nbsp;'u sed ...\*(Aq file | grep \*(Aq...\*(Aq | sponge [-a] file
```

<a name="description"></a>

# Description


**sponge**
reads standard input and writes it out to the specified file. Unlike a shell redirect,
**sponge**
soaks up all its input before writing the output file. This allows constructing pipelines that read from and write to the same file.

**sponge**
preserves the permissions of the output file if it already exists.

When possible,
**sponge**
creates or updates the output file atomically by renaming a temp file into place. (This cannot be done if TMPDIR is not in the same filesystem.)

If the output file is a special file or symlink, the data will be written to it, non-atomically.

If no file is specified,
**sponge**
outputs to stdout.

<a name="options"></a>

# Options


**-a**
Replace the file with a new file that contains the files original content, with the standard input appended to it. This is done atomically when possible.

<a name="author"></a>

# Author


Colin Watson and Tollef Fog Heen
