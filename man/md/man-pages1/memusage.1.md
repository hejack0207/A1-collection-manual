# memusage(1) - profile memory usage of a program

GNU, 2017-09-15

```
memusage [option]... program [programoption]...
```

<a name="description"></a>

# Description

**memusage**
is a bash script which profiles memory usage of the program,
_program_.
It preloads the
**libmemusage.so**
library into the caller's environment (via the
**LD_PRELOAD**
environment variable; see
**ld.so**(8)).
The
**libmemusage.so**
library traces memory allocation by intercepting calls to
**malloc**(3),
**calloc**(3),
**free**(3),
and
**realloc**(3);
optionally, calls to
**mmap**(2),
**mremap**(2),
and
**munmap**(2)
can also be intercepted.

**memusage**
can output the collected data in textual form, or it can use
**memusagestat**(1)
(see the
**-p**
option,  below)
to create a PNG file containing graphical representation
of the collected data.

<a name="memory-usage-summary"></a>

### Memory usage summary

The "Memory usage summary" line output by
**memusage**
contains three fields:

* **heap total**  
  Sum of _size_ arguments of all
  **malloc**(3)
  calls,
  products of arguments (_nmemb_*_size_) of all
  **calloc**(3)
  calls,
  and sum of _length_ arguments of all
  **mmap**(2)
  calls.
  In the case of
  **realloc**(3)
  and
  **mremap**(2),
  if the new size of an allocation is larger than the previous size,
  the sum of all such differences (new size minus old size) is added.
* **heap peak**  
  Maximum of all _size_ arguments of
  **malloc**(3),
  all products of _nmemb_*_size_ of
  **calloc**(3),
  all _size_ arguments of
  **realloc**(3),
  _length_
  arguments of
  **mmap**(2),
  and
  _new\_size_ arguments of
  **mremap**(2).
* **stack peak**  
  Before the first call to any monitored function,
  the stack pointer address (base stack pointer) is saved.
  After each function call, the actual stack pointer address is read and
  the difference from the base stack pointer computed.
  The maximum of these differences is then the stack peak.

Immediately following this summary line, a table shows the number calls,
total memory allocated or deallocated,
and number of failed calls for each intercepted function.
For
**realloc**(3)
and
**mremap**(2),
the additional field "nomove" shows reallocations that
changed the address of a block,
and the additional "dec" field shows reallocations that
decreased the size of the block.
For
**realloc**(3),
the additional field "free" shows reallocations that
caused a block to be freed (i.e., the reallocated size was 0).

The "realloc/total memory" of the table output by
**memusage**
does not reflect cases where
**realloc**(3)
is used to reallocate a block of memory
to have a smaller size than previously.
This can cause sum of all "total memory" cells (excluding "free")
to be larger than the "free/total memory" cell.

<a name="histogram-for-block-sizes"></a>

### Histogram for block sizes

The "Histogram for block sizes" provides a breakdown of memory
allocations into various bucket sizes.

<a name="options"></a>

# Options


* **-n&nbsp;**_name_**,&nbsp;--progname=**_name_  
  Name of the program file to profile.
* **-p&nbsp;**_file_**,&nbsp;--png=**_file_  
  Generate PNG graphic and store it in
  _file_.
* **-d&nbsp;**_file_**,&nbsp;--data=**_file_  
  Generate binary data file and store it in
  _file_.
* **-u,&nbsp;--unbuffered**  
  Do not buffer output.
* **-b&nbsp;**_size_**,&nbsp;--buffer=**_size_  
  Collect
  _size_
  entries before writing them out.
* **--no-timer**  
  Disable timer-based
  (**SIGPROF**)
  sampling of stack pointer value.
* **-m,&nbsp;--mmap**  
  Also trace
  **mmap**(2),
  **mremap**(2),
  and
  **munmap**(2).
* **-?,&nbsp;--help**  
  Print help and exit.
* **--usage**  
  Print a short usage message and exit.
* **-V,&nbsp;--version**  
  Print version information and exit.
* The following options apply only when generating graphical output:  
* **-t,&nbsp;--time-based**  
  Use time (rather than number of function calls) as the scale for the X axis.
* **-T,&nbsp;--total**  
  Also draw a graph of total memory use.
* **--title=**_name_  
  Use
  _name_
  as the title of the graph.
* **-x&nbsp;**_size_**,&nbsp;--x-size=**_size_  
  Make the graph
  _size_
  pixels wide.
* **-y&nbsp;**_size_**,&nbsp;--y-size=**_size_  
  Make the graph
  _size_
  pixels high.

<a name="exit-status"></a>

# Exit Status

Exit status is equal to the exit status of profiled program.

<a name="bugs"></a>

# Bugs

To report bugs, see
[](http://www.gnu.org/software/libc/bugs.html)

<a name="example"></a>

# Example

Below is a simple program that reallocates a block of
memory in cycles that rise to a peak before then cyclically
reallocating the memory in smaller blocks that return to zero.
After compiling the program and running the following commands,
a graph of the memory usage of the program can be found in the file
_memusage.png_:

.in +4n
.EX
$ **memusage --data=memusage.dat ./a.out**
...
Memory usage summary: heap total: 45200, heap peak: 6440, stack peak: 224
        total calls  total memory  failed calls
 malloc|         1           400             0
realloc|        40         44800             0  (nomove:40, dec:19, free:0)
 calloc|         0             0             0
   free|         1           440
Histogram for block sizes:
  192-207             1   2% ================
...
 2192-2207            1   2% ================
 2240-2255            2   4% =================================
 2832-2847            2   4% =================================
 3440-3455            2   4% =================================
 4032-4047            2   4% =================================
 4640-4655            2   4% =================================
 5232-5247            2   4% =================================
 5840-5855            2   4% =================================
 6432-6447            1   2% ================
$ **memusagestat memusage.dat memusage.png**
.EE
.in

<a name="program-source"></a>

### Program source

.EX
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;

#define CYCLES 20

int
main(int argc, char *argv[])
{
     int i, j;
     int *p;

     printf("malloc: %zd\\n", sizeof(int) * 100);
     p = malloc(sizeof(int) * 100);

     for (i = 0; i &lt; CYCLES; i++) {
         if (i &lt; CYCLES / 2)
             j = i;
         else
             j--;

         printf("realloc: %zd\\n", sizeof(int) * (j * 50 + 110));
         p = realloc(p, sizeof(int) * (j * 50 + 100));

         printf("realloc: %zd\\n", sizeof(int) * ((j+1) * 150 + 110));
         p = realloc(p, sizeof(int) * ((j + 1) * 150 + 110));
     }

     free(p);
     exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**memusagestat**(1),
**mtrace**(1)
**ld.so**(8)

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
