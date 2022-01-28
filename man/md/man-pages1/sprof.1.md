# sprof(1) - read and display shared object profiling data

Linux, 2017-09-15

    sprof [option]... shared-object-path [profile-data-path]

<a name="description"></a>

# Description

The
**sprof**
command displays a profiling summary for the
shared object (shared library) specified as its first command-line argument.
The profiling summary is created using previously generated
profiling data in the (optional) second command-line argument.
If the profiling data pathname is omitted, then
**sprof**
will attempt to deduce it using the soname of the shared object,
looking for a file with the name
_&lt;soname&gt;.profile_
in the current directory.

<a name="options"></a>

# Options

The following command-line options specify the profile output
to be produced:

* **-c**, **--call-pairs**  
  Print a list of pairs of call paths for the interfaces exported
  by the shared object,
  along with the number of times each path is used.
* **-p**, **--flat-profile**  
  Generate a flat profile of all of the functions in the monitored object,
  with counts and ticks.
* **-q**, **--graph**  
  Generate a call graph.

If none of the above options is specified,
then the default behavior is to display a flat profile and a call graph.

The following additional command-line options are available:

* **-?**, **--help**  
  Display a summary of command-line options and arguments and exit.
* **--usage**  
  Display a short usage message and exit.
* **-V**, **--version**  
  Display the program version and exit.

<a name="conforming-to"></a>

# Conforming to

The
**sprof**
command is a GNU extension, not present in POSIX.1.

<a name="example"></a>

# Example

The following example demonstrates the use of
**sprof**.
The example consists of a main program that calls two functions
in a shared object.
First, the code of the main program:

.in +4n
.EX
$ **cat prog.c**
#include &lt;stdlib.h&gt;

void x1(void);
void x2(void);

int
main(int argc, char *argv[])
{
    x1();
    x2();
    exit(EXIT_SUCCESS);
}
.EE
.in

The functions
_x1()_
and
_x2()_
are defined in the following source file that is used to
construct the shared object:

.in +4n
.EX
$ **cat libdemo.c**
#include &lt;unistd.h&gt;

void
consumeCpu1(int lim)
{
    int j;

    for (j = 0; j &lt; lim; j++)
	getppid();
}

void
x1(void) {
    int j;

    for (j = 0; j &lt; 100; j++)
	consumeCpu1(200000);
}

void
consumeCpu2(int lim)
{
    int j;

    for (j = 0; j &lt; lim; j++)
	getppid();
}

void
x2(void)
{
    int j;

    for (j = 0; j &lt; 1000; j++)
	consumeCpu2(10000);
}
.EE
.in

Now we construct the shared object with the real name
_libdemo.so.1.0.1_,
and the soname
_libdemo.so.1_:

.in +4n
.EX
$ **cc -g -fPIC -shared -Wl,-soname,libdemo.so.1 \e**
        **-o libdemo.so.1.0.1 libdemo.c**
.EE
.in

Then we construct symbolic links for the library soname and
the library linker name:

.in +4n
.EX
$ **ln -sf libdemo.so.1.0.1 libdemo.so.1**
$ **ln -sf libdemo.so.1 libdemo.so**
.EE
.in

Next, we compile the main program, linking it against the shared object,
and then list the dynamic dependencies of the program:

.in +4n
.EX
$ **cc -g -o prog prog.c -L. -ldemo**
$ **ldd prog**
	linux-vdso.so.1 =&gt;  (0x00007fff86d66000)
	libdemo.so.1 =&gt; not found
	libc.so.6 =&gt; /lib64/libc.so.6 (0x00007fd4dc138000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fd4dc51f000)
.EE
.in

In order to get profiling information for the shared object,
we define the environment variable
**LD_PROFILE**
with the soname of the library:

.in +4n
.EX
$ **export LD\_PROFILE=libdemo.so.1**
.EE
.in

We then define the environment variable
**LD_PROFILE_OUTPUT**
with the pathname of the directory where profile output should be written,
and create that directory if it does not exist already:

.in +4n
.EX
$ **export LD\_PROFILE\_OUTPUT=$(pwd)/prof\_data**
$ **mkdir -p $LD\_PROFILE\_OUTPUT**
.EE
.in

**LD_PROFILE**
causes profiling output to be
_appended_
to the output file if it already exists,
so we ensure that there is no preexisting profiling data:

.in +4n
.EX
$ **rm -f $LD\_PROFILE\_OUTPUT/$LD\_PROFILE.profile**
.EE
.in

We then run the program to produce the profiling output,
which is written to a file in the directory specified in
**LD_PROFILE_OUTPUT**:

.in +4n
.EX
$ **LD_LIBRARY_PATH=. ./prog**
$ **ls prof\_data**
libdemo.so.1.profile
.EE
.in

We then use the
**sprof -p**
option to generate a flat profile with counts and ticks:

.in +4n
.EX
$ **sprof -p libdemo.so.1 $LD\_PROFILE\_OUTPUT/libdemo.so.1.profile**
Flat profile:

Each sample counts as 0.01 seconds.
  %   cumulative   self              self     total
 time   seconds   seconds    calls  us/call  us/call  name
 60.00      0.06     0.06      100   600.00           consumeCpu1
 40.00      0.10     0.04     1000    40.00           consumeCpu2
  0.00      0.10     0.00        1     0.00           x1
  0.00      0.10     0.00        1     0.00           x2
.EE
.in

The
**sprof -q**
option generates a call graph:

.in +4n
.EX
$ **sprof -q libdemo.so.1 $LD\_PROFILE\_OUTPUT/libdemo.so.1.profile**

index % time    self  children    called     name

                0.00    0.00      100/100         x1 [1]
[0]    100.0    0.00    0.00      100         consumeCpu1 [0]
-----------------------------------------------
                0.00    0.00        1/1           &lt;UNKNOWN&gt;
[1]      0.0    0.00    0.00        1         x1 [1]
                0.00    0.00      100/100         consumeCpu1 [0]
-----------------------------------------------
                0.00    0.00     1000/1000        x2 [3]
[2]      0.0    0.00    0.00     1000         consumeCpu2 [2]
-----------------------------------------------
                0.00    0.00        1/1           &lt;UNKNOWN&gt;
[3]      0.0    0.00    0.00        1         x2 [3]
                0.00    0.00     1000/1000        consumeCpu2 [2]
-----------------------------------------------
.EE
.in

Above and below, the "&lt;UNKNOWN&gt;" strings represent identifiers that
are outside of the profiled object (in this example, these are instances of
_main()_).

The
**sprof -c**
option generates a list of call pairs and the number of their occurrences:

.in +4n
.EX
$ **sprof -c libdemo.so.1 $LD\_PROFILE\_OUTPUT/libdemo.so.1.profile**
&lt;UNKNOWN&gt;                  x1                                 1
x1                         consumeCpu1                      100
&lt;UNKNOWN&gt;                  x2                                 1
x2                         consumeCpu2                     1000
.EE
.in

<a name="see-also"></a>

# See Also

**gprof**(1),
**ldd**(1),
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
