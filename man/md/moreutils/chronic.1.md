# chronic(1)

moreutils, 2015-07-13

.if n .ad l
.nh

<a name="name"></a>

# Name

chronic - runs a command quietly unless it fails

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" chronic \s-1COMMAND...\s0
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
chronic runs a command, and arranges for its standard out and standard
error to only be displayed if the command fails (exits nonzero or crashes).
If the command succeeds, any extraneous output will be hidden.

A common use for chronic is for running a cron job. Rather than
trying to keep the command quiet, and having to deal with mails containing
accidental output when it succeeds, and not verbose enough output when it
fails, you can just run it verbosely always, and use chronic to hide
the successful output.

.Vb 1
        0 1 * * * chronic backup # instead of backup &gt;/dev/null 2&gt;&1
.Ve

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Copyright 2010 by Joey Hess &lt;[id@joeyh.name](mailto:id@joeyh.name)&gt;

Original concept and chronic\*(R" name by Chuck Houpt.

Licensed under the \s-1GNU GPL\s0 version 2 or higher.
