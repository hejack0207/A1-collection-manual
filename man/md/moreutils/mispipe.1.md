# mispipe(1)

moreutils, 2006\-09\-07

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

mispipe - pipe two commands, returning the exit status of the first

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mispipe&nbsp;'u mispipe ["command1"] ["command2"]
```

<a name="description"></a>

# Description


**mispipe**
pipes two commands together like the shell does, but unlike piping in the shell, which returns the exit status of the last command; when using mispipe, the exit status of the first command is returned.

Note that some shells, notably
**bash**, do offer a pipefail option, however, that option does not behave the same since it makes a failure of any command in the pipeline be returned, not just the exit status of the first.

<a name="exit-status"></a>

# Exit Status


The exit status of the first command. If the process terminated abnormally (due to a signal), 128 will be added to its exit status.

<a name="author"></a>

# Author


Nathanael Nerode
