# memusagestat(1) - generate graphic from memory profiling data

GNU, 2017-09-15

```
memusagestat [option]... datafile [outfile]
```

<a name="description"></a>

# Description

**memusagestat**
creates a PNG file containing a graphical representation of the
memory profiling data in the file
_datafile_;
that file is generated via the
_-d_
(or
_--data_)
option of
**memusage**(1).

The red line in the graph shows the heap usage (allocated memory)
and the green line shows the stack usage.
The x-scale is either the number of memory-handling function calls or
(if the
_-t_
option is specified)
time.

<a name="options"></a>

# Options


* **-o&nbsp;**_file_**,&nbsp;--output=**_file_  
  Name of the output file.
* **-s&nbsp;**_string_**,&nbsp;--string=**_string_  
  Use
  _string_
  as the title inside the output graph.
* **-t,&nbsp;--time**  
  Use time (rather than number of function calls) as the scale for the X axis.
* **-T,&nbsp;--total**  
  Also draw a graph of total memory consumption.
* **-x&nbsp;**_size_**,&nbsp;--x-size=**_size_  
  Make the output graph
  _size_
  pixels wide.
* **-y&nbsp;**_size_**,&nbsp;--y-size=**_size_  
  Make the output graph
  _size_
  pixels high.
* **-?,&nbsp;--help**  
  Print a help message and exit.
* **--usage**  
  Print a short usage message and exit.
* **-V,&nbsp;--version**  
  Print version information and exit.

<a name="bugs"></a>

# Bugs

To report bugs, see
[](http://www.gnu.org/software/libc/bugs.html)

<a name="example"></a>

# Example

See
**memusage**(1).

<a name="see-also"></a>

# See Also

**memusage**(1),
**mtrace**(1)

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
