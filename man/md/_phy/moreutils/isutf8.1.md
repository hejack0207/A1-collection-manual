# isutf8(1)

moreutils, 2006\-02\-19

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

isutf8 - check whether files are valid UTF-8

<a name="synopsis"></a>

# Synopsis

```
.HP \w'isutf8&nbsp;'u isutf8 [-hq] [--help] [--quiet] [[file]]
```

<a name="description"></a>

# Description


**isutf8**
checks whether files are syntactically valid UTF-8. Input is either files named on the command line, or the standard input. Notices about files with invalid UTF-8 are printed to standard output.

<a name="options"></a>

# Options


**-h**, **--help**
Print out a help summary.

**-q**, **--quiet**
Dont print messages telling which files are invalid UTF-8, merely indicate it with the exit status.

<a name="exit-status"></a>

# Exit Status


If the file is valid UTF-8, the exit status is zero. If the file is not valid UTF-8, or there is some error, the exit status is non-zero.

<a name="author"></a>

# Author


Lars Wirzenius

<a name="see-also"></a>

# See Also


**utf8**(7)
