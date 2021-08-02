# vipe(1)

moreutils, 2015-07-13

.if n .ad l
.nh

<a name="name"></a>

# Name

vipe - edit pipe

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" command1 | vipe | command2
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
vipe allows you to run your editor in the middle of a unix pipeline and
edit the data that is being piped between programs. Your editor will
have the full data being piped from command1 loaded into it, and when you
close it, that data will be piped into command2.

<a name="environment-variables"></a>

# Environment Variables

.IX Header "ENVIRONMENT VARIABLES"

* \s-1EDITOR\s0  
  .IX Item "EDITOR"
  Editor to use.
* \s-1VISUAL\s0  
  .IX Item "VISUAL"
  Also supported to determine what editor to use.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Copyright 2006 by Joey Hess &lt;[id@joeyh.name](mailto:id@joeyh.name)&gt;

Licensed under the \s-1GNU GPL.\s0
