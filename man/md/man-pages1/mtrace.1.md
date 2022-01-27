# mtrace(1) - interpret the malloc trace log

GNU, 2017-09-15

```
mtrace [option]... [binary] mtracedata
```

<a name="description"></a>

# Description

**mtrace**
is a Perl script used to interpret and provide human readable output
of the trace log contained in the file
_mtracedata_,
whose contents were produced by
**mtrace**(3).
If
_binary_
is provided, the output of
**mtrace**
also contains the source file name with line number information
for problem locations
(assuming that
_binary_
was compiled with debugging information).

For more information about the
**mtrace**(3)
function and
**mtrace**
script usage, see
**mtrace**(3).

<a name="options"></a>

# Options


* **--help**  
  Print help and exit.
* **--version**  
  Print version information and exit.

<a name="bugs"></a>

# Bugs

For bug reporting instructions, please see:
[](http://www.gnu.org/software/libc/bugs.html).

<a name="see-also"></a>

# See Also

**memusage**(1),
**mtrace**(3)

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
