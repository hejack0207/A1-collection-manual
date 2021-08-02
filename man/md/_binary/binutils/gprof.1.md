# gprof(1)

binutils-2.31.1, 2020-01-02

.if n .ad l
.nh

<a name="name"></a>

# Name

gprof - display call graph profile data

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" gprof [ -[abcDhilLrsTvwxyz] ] [ -[ACeEfFJnNOpPqQZ][name] ]  [ -I dirs ] [ -d[num] ] [ -k from/to ]  [ -m min-count ] [ -R map_file ] [ -t table-length ]  [ --[no-]annotated-source[=name] ]  [ --[no-]exec-counts[=name] ]  [ --[no-]flat-profile[=name] ] [ --[no-]graph[=name] ]  [ --[no-]time=name] [ --all-lines ] [ --brief ]  [ --debug[=level] ] [ --function-ordering ]  [ --file-ordering map_file ] [ --directory-path=dirs ]  [ --display-unused-functions ] [ --file-format=name ]  [ --file-info ] [ --help ] [ --line ] [ --inline-file-names ]  [ --min-count=n ] [ --no-static ] [ --print-path ]  [ --separate-files ] [ --static-call-graph ] [ --sum ]  [ --table-length=len ] [ --traditional ] [ --version ]  [ --width=n ] [ --ignore-non-functions ]  [ --demangle[=\s-1STYLE\s0] ] [ --no-demangle ]  [--external-symbol-table=name]  [ image-file ] [ profile-file ... ]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\f(CW`gprof\*(C' produces an execution profile of C, Pascal, or Fortran77
programs.  The effect of called routines is incorporated in the profile
of each caller.  The profile data is taken from the call graph profile file
(_gmon.out_ default) which is created by programs
that are compiled with the **-pg** option of
\f(CW`cc\*(C', \f(CW\*(C\`pc\*(C', and \f(CW\*(C\`f77\*(C'.
The **-pg** option also links in versions of the library routines
that are compiled for profiling.  \f(CW`Gprof\*(C' reads the given object
file (the default is \f(CW`a.out\*(C') and establishes the relation between
its symbol table and the call graph profile from _gmon.out_.
If more than one profile file is specified, the \f(CW`gprof\*(C'
output shows the sum of the profile information in the given profile files.

\f(CW`Gprof\*(C' calculates the amount of time spent in each routine.
Next, these times are propagated along the edges of the call graph.
Cycles are discovered, and calls into a cycle are made to share the time
of the cycle.

Several forms of output are available from the analysis.

The _flat profile_ shows how much time your program spent in each function,
and how many times that function was called.  If you simply want to know
which functions burn most of the cycles, it is stated concisely here.

The _call graph_ shows, for each function, which functions called it, which
other functions it called, and how many times.  There is also an estimate
of how much time was spent in the subroutines of each function.  This can
suggest places where you might try to eliminate function calls that use a
lot of time.

The _annotated source_ listing is a copy of the program's
source code, labeled with the number of times each line of the
program was executed.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
These options specify which of several output formats
\f(CW`gprof\*(C' should produce.

Many of these options take an optional _symspec_ to specify
functions to be included or excluded.  These options can be
specified multiple times, with different symspecs, to include
or exclude sets of symbols.

Specifying any of these options overrides the default (**-p -q**),
which prints a flat profile and call graph analysis
for all functions.
.ie n .IP """-A[_symspec_]""" 4
.el .IP "\f(CW-A[\f(CIsymspec\f(CW]" 4
.IX Item "-A[symspec]"
.ie n .IP """--annotated-source[=_symspec_]""" 4
.el .IP "\f(CW--annotated-source[=\f(CIsymspec\f(CW]" 4
.IX Item "--annotated-source[=symspec]"
The **-A** option causes \f(CW`gprof\*(C' to print annotated source code.
If _symspec_ is specified, print output only for matching symbols.
.ie n .IP """-b""" 4
.el .IP "\f(CW-b" 4
.IX Item "-b"
.ie n .IP """--brief""" 4
.el .IP "\f(CW--brief" 4
.IX Item "--brief"
If the **-b** option is given, \f(CW`gprof\*(C' doesn't print the
verbose blurbs that try to explain the meaning of all of the fields in
the tables.  This is useful if you intend to print out the output, or
are tired of seeing the blurbs.
.ie n .IP """-C[_symspec_]""" 4
.el .IP "\f(CW-C[\f(CIsymspec\f(CW]" 4
.IX Item "-C[symspec]"
.ie n .IP """--exec-counts[=_symspec_]""" 4
.el .IP "\f(CW--exec-counts[=\f(CIsymspec\f(CW]" 4
.IX Item "--exec-counts[=symspec]"
The **-C** option causes \f(CW`gprof\*(C' to
print a tally of functions and the number of times each was called.
If _symspec_ is specified, print tally only for matching symbols.
.Sp
If the profile data file contains basic-block count records, specifying
the **-l** option, along with **-C**, will cause basic-block
execution counts to be tallied and displayed.
.ie n .IP """-i""" 4
.el .IP "\f(CW-i" 4
.IX Item "-i"
.ie n .IP """--file-info""" 4
.el .IP "\f(CW--file-info" 4
.IX Item "--file-info"
The **-i** option causes \f(CW`gprof\*(C' to display summary information
about the profile data file(s) and then exit.  The number of histogram,
call graph, and basic-block count records is displayed.
.ie n .IP """-I _dirs_""" 4
.el .IP "\f(CW-I \f(CIdirs\f(CW" 4
.IX Item "-I dirs"
.ie n .IP """--directory-path=_dirs_""" 4
.el .IP "\f(CW--directory-path=\f(CIdirs\f(CW" 4
.IX Item "--directory-path=dirs"
The **-I** option specifies a list of search directories in
which to find source files.  Environment variable _\s-1GPROF\_PATH\s0_
can also be used to convey this information.
Used mostly for annotated source output.
.ie n .IP """-J[_symspec_]""" 4
.el .IP "\f(CW-J[\f(CIsymspec\f(CW]" 4
.IX Item "-J[symspec]"
.ie n .IP """--no-annotated-source[=_symspec_]""" 4
.el .IP "\f(CW--no-annotated-source[=\f(CIsymspec\f(CW]" 4
.IX Item "--no-annotated-source[=symspec]"
The **-J** option causes \f(CW`gprof\*(C' not to
print annotated source code.
If _symspec_ is specified, \f(CW`gprof\*(C' prints annotated source,
but excludes matching symbols.
.ie n .IP """-L""" 4
.el .IP "\f(CW-L" 4
.IX Item "-L"
.ie n .IP """--print-path""" 4
.el .IP "\f(CW--print-path" 4
.IX Item "--print-path"
Normally, source filenames are printed with the path
component suppressed.  The **-L** option causes \f(CW`gprof\*(C'
to print the full pathname of
source filenames, which is determined
from symbolic debugging information in the image file
and is relative to the directory in which the compiler
was invoked.
.ie n .IP """-p[_symspec_]""" 4
.el .IP "\f(CW-p[\f(CIsymspec\f(CW]" 4
.IX Item "-p[symspec]"
.ie n .IP """--flat-profile[=_symspec_]""" 4
.el .IP "\f(CW--flat-profile[=\f(CIsymspec\f(CW]" 4
.IX Item "--flat-profile[=symspec]"
The **-p** option causes \f(CW`gprof\*(C' to print a flat profile.
If _symspec_ is specified, print flat profile only for matching symbols.
.ie n .IP """-P[_symspec_]""" 4
.el .IP "\f(CW-P[\f(CIsymspec\f(CW]" 4
.IX Item "-P[symspec]"
.ie n .IP """--no-flat-profile[=_symspec_]""" 4
.el .IP "\f(CW--no-flat-profile[=\f(CIsymspec\f(CW]" 4
.IX Item "--no-flat-profile[=symspec]"
The **-P** option causes \f(CW`gprof\*(C' to suppress printing a flat profile.
If _symspec_ is specified, \f(CW`gprof\*(C' prints a flat profile,
but excludes matching symbols.
.ie n .IP """-q[_symspec_]""" 4
.el .IP "\f(CW-q[\f(CIsymspec\f(CW]" 4
.IX Item "-q[symspec]"
.ie n .IP """--graph[=_symspec_]""" 4
.el .IP "\f(CW--graph[=\f(CIsymspec\f(CW]" 4
.IX Item "--graph[=symspec]"
The **-q** option causes \f(CW`gprof\*(C' to print the call graph analysis.
If _symspec_ is specified, print call graph only for matching symbols
and their children.
.ie n .IP """-Q[_symspec_]""" 4
.el .IP "\f(CW-Q[\f(CIsymspec\f(CW]" 4
.IX Item "-Q[symspec]"
.ie n .IP """--no-graph[=_symspec_]""" 4
.el .IP "\f(CW--no-graph[=\f(CIsymspec\f(CW]" 4
.IX Item "--no-graph[=symspec]"
The **-Q** option causes \f(CW`gprof\*(C' to suppress printing the
call graph.
If _symspec_ is specified, \f(CW`gprof\*(C' prints a call graph,
but excludes matching symbols.
.ie n .IP """-t""" 4
.el .IP "\f(CW-t" 4
.IX Item "-t"
.ie n .IP """--table-length=_num_""" 4
.el .IP "\f(CW--table-length=\f(CInum\f(CW" 4
.IX Item "--table-length=num"
The **-t** option causes the _num_ most active source lines in
each source file to be listed when source annotation is enabled.  The
default is 10.
.ie n .IP """-y""" 4
.el .IP "\f(CW-y" 4
.IX Item "-y"
.ie n .IP """--separate-files""" 4
.el .IP "\f(CW--separate-files" 4
.IX Item "--separate-files"
This option affects annotated source output only.
Normally, \f(CW`gprof\*(C' prints annotated source files
to standard-output.  If this option is specified,
annotated source for a file named _path/filename_
is generated in the file _filename-ann_.  If the underlying
file system would truncate _filename-ann_ so that it
overwrites the original _filename_, \f(CW`gprof\*(C' generates
annotated source in the file _filename.ann_ instead (if the
original file name has an extension, that extension is _replaced_
with _.ann_).
.ie n .IP """-Z[_symspec_]""" 4
.el .IP "\f(CW-Z[\f(CIsymspec\f(CW]" 4
.IX Item "-Z[symspec]"
.ie n .IP """--no-exec-counts[=_symspec_]""" 4
.el .IP "\f(CW--no-exec-counts[=\f(CIsymspec\f(CW]" 4
.IX Item "--no-exec-counts[=symspec]"
The **-Z** option causes \f(CW`gprof\*(C' not to
print a tally of functions and the number of times each was called.
If _symspec_ is specified, print tally, but exclude matching symbols.
.ie n .IP """-r""" 4
.el .IP "\f(CW-r" 4
.IX Item "-r"
.ie n .IP """--function-ordering""" 4
.el .IP "\f(CW--function-ordering" 4
.IX Item "--function-ordering"
The **--function-ordering** option causes \f(CW`gprof\*(C' to print a
suggested function ordering for the program based on profiling data.
This option suggests an ordering which may improve paging, tlb and
cache behavior for the program on systems which support arbitrary
ordering of functions in an executable.
.Sp
The exact details of how to force the linker to place functions
in a particular order is system dependent and out of the scope of this
manual.
.ie n .IP """-R _map\_file_""" 4
.el .IP "\f(CW-R \f(CImap\_file\f(CW" 4
.IX Item "-R map_file"
.ie n .IP """--file-ordering _map\_file_""" 4
.el .IP "\f(CW--file-ordering \f(CImap\_file\f(CW" 4
.IX Item "--file-ordering map_file"
The **--file-ordering** option causes \f(CW`gprof\*(C' to print a
suggested .o link line ordering for the program based on profiling data.
This option suggests an ordering which may improve paging, tlb and
cache behavior for the program on systems which do not support arbitrary
ordering of functions in an executable.
.Sp
Use of the **-a** argument is highly recommended with this option.
.Sp
The _map\_file_ argument is a pathname to a file which provides
function name to object file mappings.  The format of the file is similar to
the output of the program \f(CW`nm\*(C'.
.Sp
.Vb 8
        c-parse.o:00000000 T yyparse
        c-parse.o:00000004 C yyerrflag
        c-lang.o:00000000 T maybe_objc_method_name
        c-lang.o:00000000 T print_lang_statistics
        c-lang.o:00000000 T recognize_objc_keyword
        c-decl.o:00000000 T print_lang_identifier
        c-decl.o:00000000 T print_lang_type
        ...
.Ve
.Sp
To create a _map\_file_ with \s-1GNU\s0 \f(CW`nm\*(C', type a command like
\f(CW`nm --extern-only --defined-only -v --print-file-name program-name\*(C'.
.ie n .IP """-T""" 4
.el .IP "\f(CW-T" 4
.IX Item "-T"
.ie n .IP """--traditional""" 4
.el .IP "\f(CW--traditional" 4
.IX Item "--traditional"
The **-T** option causes \f(CW`gprof\*(C' to print its output in
traditional\*(R" \s-1BSD\s0 style.
.ie n .IP """-w _width_""" 4
.el .IP "\f(CW-w \f(CIwidth\f(CW" 4
.IX Item "-w width"
.ie n .IP """--width=_width_""" 4
.el .IP "\f(CW--width=\f(CIwidth\f(CW" 4
.IX Item "--width=width"
Sets width of output lines to _width_.
Currently only used when printing the function index at the bottom
of the call graph.
.ie n .IP """-x""" 4
.el .IP "\f(CW-x" 4
.IX Item "-x"
.ie n .IP """--all-lines""" 4
.el .IP "\f(CW--all-lines" 4
.IX Item "--all-lines"
This option affects annotated source output only.
By default, only the lines at the beginning of a basic-block
are annotated.  If this option is specified, every line in
a basic-block is annotated by repeating the annotation for the
first line.  This behavior is similar to \f(CW`tcov\*(C''s **-a**.
.ie n .IP """--demangle[=_style_]""" 4
.el .IP "\f(CW--demangle[=\f(CIstyle\f(CW]" 4
.IX Item "--demangle[=style]"
.ie n .IP """--no-demangle""" 4
.el .IP "\f(CW--no-demangle" 4
.IX Item "--no-demangle"
These options control whether  symbol names should be demangled when
printing output.  The default is to demangle symbols.  The
\f(CW`--no-demangle\*(C' option may be used to turn off demangling. Different
compilers have different mangling styles.  The optional demangling style
argument can be used to choose an appropriate demangling style for your
compiler.

<a name="analysis-options"></a>

### Analysis Options

.IX Subsection "Analysis Options"
.ie n .IP """-a""" 4
.el .IP "\f(CW-a" 4
.IX Item "-a"
.ie n .IP """--no-static""" 4
.el .IP "\f(CW--no-static" 4
.IX Item "--no-static"
The **-a** option causes \f(CW`gprof\*(C' to suppress the printing of
statically declared (private) functions.  (These are functions whose
names are not listed as global, and which are not visible outside the
file/function/block where they were defined.)  Time spent in these
functions, calls to/from them, etc., will all be attributed to the
function that was loaded directly before it in the executable file.
This option affects both the flat profile and the call graph.
.ie n .IP """-c""" 4
.el .IP "\f(CW-c" 4
.IX Item "-c"
.ie n .IP """--static-call-graph""" 4
.el .IP "\f(CW--static-call-graph" 4
.IX Item "--static-call-graph"
The **-c** option causes the call graph of the program to be
augmented by a heuristic which examines the text space of the object
file and identifies function calls in the binary machine code.
Since normal call graph records are only generated when functions are
entered, this option identifies children that could have been called,
but never were.  Calls to functions that were not compiled with
profiling enabled are also identified, but only if symbol table
entries are present for them.
Calls to dynamic library routines are typically _not_ found
by this option.
Parents or children identified via this heuristic
are indicated in the call graph with call counts of **0**.
.ie n .IP """-D""" 4
.el .IP "\f(CW-D" 4
.IX Item "-D"
.ie n .IP """--ignore-non-functions""" 4
.el .IP "\f(CW--ignore-non-functions" 4
.IX Item "--ignore-non-functions"
The **-D** option causes \f(CW`gprof\*(C' to ignore symbols which
are not known to be functions.  This option will give more accurate
profile data on systems where it is supported (Solaris and \s-1HPUX\s0 for
example).
.ie n .IP """-k _from_/_to_""" 4
.el .IP "\f(CW-k \f(CIfrom\f(CW/\f(CIto\f(CW" 4
.IX Item "-k from/to"
The **-k** option allows you to delete from the call graph any arcs from
symbols matching symspec _from_ to those matching symspec _to_.
.ie n .IP """-l""" 4
.el .IP "\f(CW-l" 4
.IX Item "-l"
.ie n .IP """--line""" 4
.el .IP "\f(CW--line" 4
.IX Item "--line"
The **-l** option enables line-by-line profiling, which causes
histogram hits to be charged to individual source code lines,
instead of functions.  This feature only works with programs compiled
by older versions of the \f(CW`gcc\*(C' compiler.  Newer versions of
\f(CW`gcc\*(C' are designed to work with the \f(CW\*(C\`gcov\*(C' tool instead.
.Sp
If the program was compiled with basic-block counting enabled,
this option will also identify how many times each line of
code was executed.
While line-by-line profiling can help isolate where in a large function
a program is spending its time, it also significantly increases
the running time of \f(CW`gprof\*(C', and magnifies statistical
inaccuracies.
.ie n .IP """--inline-file-names""" 4
.el .IP "\f(CW--inline-file-names" 4
.IX Item "--inline-file-names"
This option causes \f(CW`gprof\*(C' to print the source file after each
symbol in both the flat profile and the call graph. The full path to the
file is printed if used with the **-L** option.
.ie n .IP """-m _num_""" 4
.el .IP "\f(CW-m \f(CInum\f(CW" 4
.IX Item "-m num"
.ie n .IP """--min-count=_num_""" 4
.el .IP "\f(CW--min-count=\f(CInum\f(CW" 4
.IX Item "--min-count=num"
This option affects execution count output only.
Symbols that are executed less than _num_ times are suppressed.
.ie n .IP """-n_symspec_""" 4
.el .IP "\f(CW-n\f(CIsymspec\f(CW" 4
.IX Item "-nsymspec"
.ie n .IP """--time=_symspec_""" 4
.el .IP "\f(CW--time=\f(CIsymspec\f(CW" 4
.IX Item "--time=symspec"
The **-n** option causes \f(CW`gprof\*(C', in its call graph analysis,
to only propagate times for symbols matching _symspec_.
.ie n .IP """-N_symspec_""" 4
.el .IP "\f(CW-N\f(CIsymspec\f(CW" 4
.IX Item "-Nsymspec"
.ie n .IP """--no-time=_symspec_""" 4
.el .IP "\f(CW--no-time=\f(CIsymspec\f(CW" 4
.IX Item "--no-time=symspec"
The **-n** option causes \f(CW`gprof\*(C', in its call graph analysis,
not to propagate times for symbols matching _symspec_.
.ie n .IP """-S_filename_""" 4
.el .IP "\f(CW-S\f(CIfilename\f(CW" 4
.IX Item "-Sfilename"
.ie n .IP """--external-symbol-table=_filename_""" 4
.el .IP "\f(CW--external-symbol-table=\f(CIfilename\f(CW" 4
.IX Item "--external-symbol-table=filename"
The **-S** option causes \f(CW`gprof\*(C' to read an external symbol table
file, such as _/proc/kallsyms_, rather than read the symbol table
from the given object file (the default is \f(CW`a.out\*(C'). This is useful
for profiling kernel modules.
.ie n .IP """-z""" 4
.el .IP "\f(CW-z" 4
.IX Item "-z"
.ie n .IP """--display-unused-functions""" 4
.el .IP "\f(CW--display-unused-functions" 4
.IX Item "--display-unused-functions"
If you give the **-z** option, \f(CW`gprof\*(C' will mention all
functions in the flat profile, even those that were never called, and
that had no time spent in them.  This is useful in conjunction with the
**-c** option for discovering which routines were never called.

<a name="miscellaneous-options"></a>

### Miscellaneous Options

.IX Subsection "Miscellaneous Options"
.ie n .IP """-d[_num_]""" 4
.el .IP "\f(CW-d[\f(CInum\f(CW]" 4
.IX Item "-d[num]"
.ie n .IP """--debug[=_num_]""" 4
.el .IP "\f(CW--debug[=\f(CInum\f(CW]" 4
.IX Item "--debug[=num]"
The **-d** _num_ option specifies debugging options.
If _num_ is not specified, enable all debugging.
.ie n .IP """-h""" 4
.el .IP "\f(CW-h" 4
.IX Item "-h"
.ie n .IP """--help""" 4
.el .IP "\f(CW--help" 4
.IX Item "--help"
The **-h** option prints command line usage.
.ie n .IP """-O_name_""" 4
.el .IP "\f(CW-O\f(CIname\f(CW" 4
.IX Item "-Oname"
.ie n .IP """--file-format=_name_""" 4
.el .IP "\f(CW--file-format=\f(CIname\f(CW" 4
.IX Item "--file-format=name"
Selects the format of the profile data files.  Recognized formats are
**auto** (the default), **bsd**, **4.4bsd**, **magic**, and
**prof** (not yet supported).
.ie n .IP """-s""" 4
.el .IP "\f(CW-s" 4
.IX Item "-s"
.ie n .IP """--sum""" 4
.el .IP "\f(CW--sum" 4
.IX Item "--sum"
The **-s** option causes \f(CW`gprof\*(C' to summarize the information
in the profile data files it read in, and write out a profile data
file called _gmon.sum_, which contains all the information from
the profile data files that \f(CW`gprof\*(C' read in.  The file _gmon.sum_
may be one of the specified input files; the effect of this is to
merge the data in the other input files into _gmon.sum_.
.Sp
Eventually you can run \f(CW`gprof\*(C' again without **-s** to analyze the
cumulative data in the file _gmon.sum_.
.ie n .IP """-v""" 4
.el .IP "\f(CW-v" 4
.IX Item "-v"
.ie n .IP """--version""" 4
.el .IP "\f(CW--version" 4
.IX Item "--version"
The **-v** flag causes \f(CW`gprof\*(C' to print the current version
number, and then exit.

<a name="deprecated-options"></a>

### Deprecated Options

.IX Subsection "Deprecated Options"
These options have been replaced with newer versions that use symspecs.
.ie n .IP """-e _function\_name_""" 4
.el .IP "\f(CW-e \f(CIfunction\_name\f(CW" 4
.IX Item "-e function_name"
The **-e** _function_ option tells \f(CW`gprof\*(C' to not print
information about the function _function\_name_ (and its
children...) in the call graph.  The function will still be listed
as a child of any functions that call it, but its index number will be
shown as **[not printed]**.  More than one **-e** option may be
given; only one _function\_name_ may be indicated with each **-e**
option.
.ie n .IP """-E _function\_name_""" 4
.el .IP "\f(CW-E \f(CIfunction\_name\f(CW" 4
.IX Item "-E function_name"
The \f(CW`-E \f(CIfunction\f(CW\*(C' option works like the \f(CW\*(C\`-e\*(C' option, but
time spent in the function (and children who were not called from
anywhere else), will not be used to compute the percentages-of-time for
the call graph.  More than one **-E** option may be given; only one
_function\_name_ may be indicated with each **-E** option.
.ie n .IP """-f _function\_name_""" 4
.el .IP "\f(CW-f \f(CIfunction\_name\f(CW" 4
.IX Item "-f function_name"
The **-f** _function_ option causes \f(CW`gprof\*(C' to limit the
call graph to the function _function\_name_ and its children (and
their children...).  More than one **-f** option may be given;
only one _function\_name_ may be indicated with each **-f**
option.
.ie n .IP """-F _function\_name_""" 4
.el .IP "\f(CW-F \f(CIfunction\_name\f(CW" 4
.IX Item "-F function_name"
The **-F** _function_ option works like the \f(CW`-f\*(C' option, but
only time spent in the function and its children (and their
children...) will be used to determine total-time and
percentages-of-time for the call graph.  More than one **-F** option
may be given; only one _function\_name_ may be indicated with each
**-F** option.  The **-F** option overrides the **-E** option.

<a name="files"></a>

# Files

.IX Header "FILES"
.ie n .IP """_a.out_""" 4
.el .IP "\f(CW\f(CIa.out\f(CW" 4
.IX Item "a.out"
the namelist and text space.
.ie n .IP """_gmon.out_""" 4
.el .IP "\f(CW\f(CIgmon.out\f(CW" 4
.IX Item "gmon.out"
dynamic call graph and profile.
.ie n .IP """_gmon.sum_""" 4
.el .IP "\f(CW\f(CIgmon.sum\f(CW" 4
.IX Item "gmon.sum"
summarized dynamic call graph and profile.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
The granularity of the sampling is shown, but remains
statistical at best.
We assume that the time for each execution of a function
can be expressed by the total time for the function divided
by the number of times the function is called.
Thus the time propagated along the call graph arcs to the function's
parents is directly proportional to the number of times that
arc is traversed.

Parents that are not themselves profiled will have the time of
their profiled children propagated to them, but they will appear
to be spontaneously invoked in the call graph listing, and will
not have their time propagated further.
Similarly, signal catchers, even though profiled, will appear
to be spontaneous (although for more obscure reasons).
Any profiled children of signal catchers should have their times
propagated properly, unless the signal catcher was invoked during
the execution of the profiling routine, in which case all is lost.

The profiled program must call \f(CW`exit\*(C'(2)
or return normally for the profiling information to be saved
in the _gmon.out_ file.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**monitor**\|(3), **profil**\|(2), **cc**\|(1), **prof**\|(1), and the Info entry for _gprof_.

An Execution Profiler for Modular Programs\*(R",
by S. Graham, P. Kessler, M. McKusick;
Software - Practice and Experience,
Vol. 13, pp. 671-685, 1983.

gprof: A Call Graph Execution Profiler\*(R",
by S. Graham, P. Kessler, M. McKusick;
Proceedings of the \s-1SIGPLAN\s0 '82 Symposium on Compiler Construction,
\s-1SIGPLAN\s0 Notices, Vol. 17, No  6, pp. 120-126, June 1982.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1988-2018 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, with no Front-Cover Texts, and with no
Back-Cover Texts.  A copy of the license is included in the
section entitled \s-1GNU\s0 Free Documentation License\*(R".
