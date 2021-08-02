# gcov(1)

gcc-9, 2019-03-12

.if n .ad l
.nh

<a name="name"></a>

# Name

gcov - coverage testing tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" gcov [-v|--version] [-h|--help]      [-a|--all-blocks]      [-b|--branch-probabilities]      [-c|--branch-counts]      [-d|--display-progress]      [-f|--function-summaries]      [-i|--json-format]      [-j|--human-readable]      [-k|--use-colors]      [-l|--long-file-names]      [-m|--demangled-names]      [-n|--no-output]      [-o|--object-directory directory|file]      [-p|--preserve-paths]      [-q|--use-hotness-colors]      [-r|--relative-only]      [-s|--source-prefix directory]      [-t|--stdout]      [-u|--unconditional-branches]      [-x|--hash-filenames]      files
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**gcov** is a test coverage program.  Use it in concert with \s-1GCC\s0
to analyze your programs to help create more efficient, faster running
code and to discover untested parts of your program.  You can use
**gcov** as a profiling tool to help discover where your
optimization efforts will best affect your code.  You can also use
**gcov** along with the other profiling tool, **gprof**, to
assess which parts of your code use the greatest amount of computing
time.

Profiling tools help you analyze your code's performance.  Using a
profiler such as **gcov** or **gprof**, you can find out some
basic performance statistics, such as:

* *  
  how often each line of code executes
* *  
  what lines of code are actually executed
* *  
  how much computing time each section of code uses

Once you know these things about how your code works when compiled, you
can look at each module to see which modules should be optimized.
**gcov** helps you determine where to work on optimization.

Software developers also use coverage testing in concert with
testsuites, to make sure software is actually good enough for a release.
Testsuites can verify that a program works as expected; a coverage
program tests to see how much of the program is exercised by the
testsuite.  Developers can then determine what kinds of test cases need
to be added to the testsuites to create both better testing and a better
final product.

You should compile your code without optimization if you plan to use
**gcov** because the optimization, by combining some lines of code
into one function, may not give you as much information as you need to
look for \`hot spots' where the code is using a great deal of computer
time.  Likewise, because **gcov** accumulates statistics by line (at
the lowest resolution), it works best with a programming style that
places only one statement on each line.  If you use complicated macros
that expand to loops or to other control structures, the statistics are
less helpful---they only report on the line where the macro call
appears.  If your complex macros behave like functions, you can replace
them with inline functions to solve this problem.

**gcov** creates a logfile called _sourcefile.gcov_ which
indicates how many times each line of a source file _sourcefile.c_
has executed.  You can use these logfiles along with **gprof** to aid
in fine-tuning the performance of your programs.  **gprof** gives
timing information you can use along with the information you get from
**gcov**.

**gcov** works only on code compiled with \s-1GCC.\s0  It is not
compatible with any other profiling or test coverage mechanism.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-a**  
  .IX Item "-a"
* **--all-blocks**  
  .IX Item "--all-blocks"
  Write individual execution counts for every basic block.  Normally gcov
  outputs execution counts only for the main blocks of a line.  With this
  option you can determine if blocks within a single line are not being
  executed.
* **-b**  
  .IX Item "-b"
* **--branch-probabilities**  
  .IX Item "--branch-probabilities"
  Write branch frequencies to the output file, and write branch summary
  info to the standard output.  This option allows you to see how often
  each branch in your program was taken.  Unconditional branches will not
  be shown, unless the **-u** option is given.
* **-c**  
  .IX Item "-c"
* **--branch-counts**  
  .IX Item "--branch-counts"
  Write branch frequencies as the number of branches taken, rather than
  the percentage of branches taken.
* **-d**  
  .IX Item "-d"
* **--display-progress**  
  .IX Item "--display-progress"
  Display the progress on the standard output.
* **-f**  
  .IX Item "-f"
* **--function-summaries**  
  .IX Item "--function-summaries"
  Output summaries for each function in addition to the file level summary.
* **-h**  
  .IX Item "-h"
* **--help**  
  .IX Item "--help"
  Display help about using **gcov** (on the standard output), and
  exit without doing any further processing.
* **-i**  
  .IX Item "-i"
* **--json-format**  
  .IX Item "--json-format"
  Output gcov file in an easy-to-parse \s-1JSON\s0 intermediate format
  which does not require source code for generation.  The \s-1JSON\s0
  file is compressed with gzip compression algorithm
  and the files have _.gcov.json.gz_ extension.
  .Sp
  Structure of the \s-1JSON\s0 is following:
  .Sp
  .Vb 6
          {
            "current_working_directory": &lt;current_working_directory&gt;,
            "format_version": &lt;format_version&gt;,
            "gcc_version": &lt;gcc_version&gt;
            "files": [&lt;file&gt;]
          }
  .Ve
  .Sp
  Fields of the root element have following semantics:
    * *  
      _current\_working\_directory_: working directory where
      a compilation unit was compiled
    * *  
      _format\_version_: semantic version of the format
    * *  
      _gcc\_version_: version of the \s-1GCC\s0 compiler
      .Sp
      Each _file_ has the following form:
      .Sp
      .Vb 5
              {
                "file": &lt;file_name&gt;,
                "functions": [&lt;function&gt;],
                "lines": [&lt;line&gt;]
              }
      .Ve
      .Sp
      Fields of the _file_ element have following semantics:
    * *  
      _file\_name_: name of the source file
      .Sp
      Each _function_ has the following form:
      .Sp
      .Vb 9
              {
                "blocks": &lt;blocks&gt;,
                "blocks_executed": &lt;blocks_executed&gt;,
                "demangled_name": "&lt;demangled_name&gt;,
                "end_line": &lt;end_line&gt;,
                "execution_count": &lt;execution_count&gt;,
                "name": &lt;name&gt;,
                "start_line": &lt;start_line&gt;
              }
      .Ve
      .Sp
      Fields of the _function_ element have following semantics:
    * *  
      _blocks_: number of blocks that are in the function
    * *  
      _blocks\_executed_: number of executed blocks of the function
    * *  
      _demangled\_name_: demangled name of the function
    * *  
      _end\_line_: line in the source file where the function ends
    * *  
      _execution\_count_: number of executions of the function
    * *  
      _name_: name of the function
    * *  
      _start\_line_: line in the source file where the function begins
      .Sp
      Each _line_ has the following form:
      .Sp
      .Vb 7
              {
                "branches": [&lt;branch&gt;],
                "count": &lt;count&gt;,
                "line_number": &lt;line_number&gt;,
                "unexecuted_block": &lt;unexecuted_block&gt;
                "function_name": &lt;function_name&gt;,
              }
      .Ve
      .Sp
      Branches are present only with _-b_ option.
      Fields of the _line_ element have following semantics:
    * *  
      _count_: number of executions of the line
    * *  
      _line\_number_: line number
    * *  
      _unexecuted\_block_: flag whether the line contains an unexecuted block
      (not all statements on the line are executed)
* B  
  .IX Item "B"
  _function\_name_: a name of a function this _line_ belongs to
  (for a line with an inlined statements can be not set)
  .Sp
  Each _branch_ has the following form:
  .Sp
  .Vb 5
          {
            "count": &lt;count&gt;,
            "fallthrough": &lt;fallthrough&gt;,
            "throw": &lt;throw&gt;
          }
  .Ve
  .Sp
  Fields of the _branch_ element have following semantics:
    * *  
      _count_: number of executions of the branch
    * *  
      _fallthrough_: true when the branch is a fall through branch
    * *  
      _throw_: true when the branch is an exceptional branch
  .ie n .IP """-j""" 4
  .el .IP "\f(CW-j" 4
  .IX Item "-j"
  .ie n .IP """--human-readable""" 4
  .el .IP "\f(CW--human-readable" 4
  .IX Item "--human-readable"
  Write counts in human readable format (like 24.6k).
  .ie n .IP """-k""" 4
  .el .IP "\f(CW-k" 4
  .IX Item "-k"
  .ie n .IP """--use-colors""" 4
  .el .IP "\f(CW--use-colors" 4
  .IX Item "--use-colors"
  Use colors for lines of code that have zero coverage.  We use red color for
  non-exceptional lines and cyan for exceptional.  Same colors are used for
  basic blocks with **-a** option.
  .ie n .IP """-l""" 4
  .el .IP "\f(CW-l" 4
  .IX Item "-l"
  .ie n .IP """--long-file-names""" 4
  .el .IP "\f(CW--long-file-names" 4
  .IX Item "--long-file-names"
  Create long file names for included source files.  For example, if the
  header file _x.h_ contains code, and was included in the file
  _a.c_, then running **gcov** on the file _a.c_ will
  produce an output file called _a.c##x.h.gcov_ instead of
  _x.h.gcov_.  This can be useful if _x.h_ is included in
  multiple source files and you want to see the individual
  contributions.  If you use the **-p** option, both the including
  and included file names will be complete path names.
  .ie n .IP """-m""" 4
  .el .IP "\f(CW-m" 4
  .IX Item "-m"
  .ie n .IP """--demangled-names""" 4
  .el .IP "\f(CW--demangled-names" 4
  .IX Item "--demangled-names"
  Display demangled function names in output. The default is to show
  mangled function names.
  .ie n .IP """-n""" 4
  .el .IP "\f(CW-n" 4
  .IX Item "-n"
  .ie n .IP """--no-output""" 4
  .el .IP "\f(CW--no-output" 4
  .IX Item "--no-output"
  Do not create the **gcov** output file.
  .ie n .IP """-o _directory|file_""" 4
  .el .IP "\f(CW-o \f(CIdirectory|file\f(CW" 4
  .IX Item "-o directory|file"
  .ie n .IP """--object-directory _directory_""" 4
  .el .IP "\f(CW--object-directory \f(CIdirectory\f(CW" 4
  .IX Item "--object-directory directory"
  .ie n .IP """--object-file _file_""" 4
  .el .IP "\f(CW--object-file \f(CIfile\f(CW" 4
  .IX Item "--object-file file"
  Specify either the directory containing the gcov data files, or the
  object path name.  The _.gcno_, and
  _.gcda_ data files are searched for using this option.  If a directory
  is specified, the data files are in that directory and named after the
  input file name, without its extension.  If a file is specified here,
  the data files are named after that file, without its extension.
  .ie n .IP """-p""" 4
  .el .IP "\f(CW-p" 4
  .IX Item "-p"
  .ie n .IP """--preserve-paths""" 4
  .el .IP "\f(CW--preserve-paths" 4
  .IX Item "--preserve-paths"
  Preserve complete path information in the names of generated
  _.gcov_ files.  Without this option, just the filename component is
  used.  With this option, all directories are used, with **/** characters
  translated to **#** characters, _._ directory components
  removed and unremoveable _.._
  components renamed to **^**.  This is useful if sourcefiles are in several
  different directories.
  .ie n .IP """-q""" 4
  .el .IP "\f(CW-q" 4
  .IX Item "-q"
  .ie n .IP """--use-hotness-colors""" 4
  .el .IP "\f(CW--use-hotness-colors" 4
  .IX Item "--use-hotness-colors"
  Emit perf-like colored output for hot lines.  Legend of the color scale
  is printed at the very beginning of the output file.
  .ie n .IP """-r""" 4
  .el .IP "\f(CW-r" 4
  .IX Item "-r"
  .ie n .IP """--relative-only""" 4
  .el .IP "\f(CW--relative-only" 4
  .IX Item "--relative-only"
  Only output information about source files with a relative pathname
  (after source prefix elision).  Absolute paths are usually system
  header files and coverage of any inline functions therein is normally
  uninteresting.
  .ie n .IP """-s _directory_""" 4
  .el .IP "\f(CW-s \f(CIdirectory\f(CW" 4
  .IX Item "-s directory"
  .ie n .IP """--source-prefix _directory_""" 4
  .el .IP "\f(CW--source-prefix \f(CIdirectory\f(CW" 4
  .IX Item "--source-prefix directory"
  A prefix for source file names to remove when generating the output
  coverage files.  This option is useful when building in a separate
  directory, and the pathname to the source directory is not wanted when
  determining the output file names.  Note that this prefix detection is
  applied before determining whether the source file is absolute.
  .ie n .IP """-t""" 4
  .el .IP "\f(CW-t" 4
  .IX Item "-t"
  .ie n .IP """--stdout""" 4
  .el .IP "\f(CW--stdout" 4
  .IX Item "--stdout"
  Output to standard output instead of output files.
  .ie n .IP """-u""" 4
  .el .IP "\f(CW-u" 4
  .IX Item "-u"
  .ie n .IP """--unconditional-branches""" 4
  .el .IP "\f(CW--unconditional-branches" 4
  .IX Item "--unconditional-branches"
  When branch probabilities are given, include those of unconditional branches.
  Unconditional branches are normally not interesting.
  .ie n .IP """-v""" 4
  .el .IP "\f(CW-v" 4
  .IX Item "-v"
  .ie n .IP """--version""" 4
  .el .IP "\f(CW--version" 4
  .IX Item "--version"
  Display the **gcov** version number (on the standard output),
  and exit without doing any further processing.
  .ie n .IP """-w""" 4
  .el .IP "\f(CW-w" 4
  .IX Item "-w"
  .ie n .IP """--verbose""" 4
  .el .IP "\f(CW--verbose" 4
  .IX Item "--verbose"
  Print verbose informations related to basic blocks and arcs.
  .ie n .IP """-x""" 4
  .el .IP "\f(CW-x" 4
  .IX Item "-x"
  .ie n .IP """--hash-filenames""" 4
  .el .IP "\f(CW--hash-filenames" 4
  .IX Item "--hash-filenames"
  By default, gcov uses the full pathname of the source files to create
  an output filename.  This can lead to long filenames that can overflow
  filesystem limits.  This option creates names of the form
  _source-file##md5.gcov_,
  where the _source-file_ component is the final filename part and
  the _md5_ component is calculated from the full mangled name that
  would have been used otherwise.

**gcov** should be run with the current directory the same as that
when you invoked the compiler.  Otherwise it will not be able to locate
the source files.  **gcov** produces files called
_mangledname.gcov_ in the current directory.  These contain
the coverage information of the source file they correspond to.
One _.gcov_ file is produced for each source (or header) file
containing code,
which was compiled to produce the data files.  The _mangledname_ part
of the output file name is usually simply the source file name, but can
be something more complicated if the **-l** or **-p** options are
given.  Refer to those options for details.

If you invoke **gcov** with multiple input files, the
contributions from each input file are summed.  Typically you would
invoke it with the same list of files as the final link of your executable.

The _.gcov_ files contain the **:** separated fields along with
program source code.  The format is

.Vb 1
        &lt;execution_count&gt;:&lt;line_number&gt;:&lt;source line text&gt;
.Ve

Additional block information may succeed each line, when requested by
command line option.  The _execution\_count_ is **-** for lines
containing no code.  Unexecuted lines are marked **#####** or
**=====**, depending on whether they are reachable by
non-exceptional paths or only exceptional paths such as  exception
handlers, respectively. Given the **-a** option, unexecuted blocks are
marked **$$$$$** or **%%%%%**, depending on whether a basic block
is reachable via non-exceptional or exceptional paths.
Executed basic blocks having a statement with zero _execution\_count_
end with <b>\*</b> character and are colored with magenta color with
the **-k** option.  This functionality is not supported in Ada.

Note that \s-1GCC\s0 can completely remove the bodies of functions that are
not needed  for instance if they are inlined everywhere.  Such functions
are marked with **-**, which can be confusing.
Use the **-fkeep-inline-functions** and **-fkeep-static-functions**
options to retain these functions and
allow gcov to properly show their _execution\_count_.

Some lines of information at the start have _line\_number_ of zero.
These preamble lines are of the form

.Vb 1
        -:0:&lt;tag&gt;:&lt;value&gt;
.Ve

The ordering and number of these preamble lines will be augmented as
**gcov** development progresses --- do not rely on them remaining
unchanged.  Use _tag_ to locate a particular preamble line.

The additional block information is of the form

.Vb 1
        &lt;tag&gt; &lt;information&gt;
.Ve

The _information_ is human readable, but designed to be simple
enough for machine parsing too.

When printing percentages, 0% and 100% are only printed when the values
are _exactly_ 0% and 100% respectively.  Other values which would
conventionally be rounded to 0% or 100% are instead printed as the
nearest non-boundary value.

When using **gcov**, you must first compile your program
with a special \s-1GCC\s0 option **--coverage**.
This tells the compiler to generate additional information needed by
gcov (basically a flow graph of the program) and also includes
additional code in the object files for generating the extra profiling
information needed by gcov.  These additional files are placed in the
directory where the object file is located.

Running the program will cause profile output to be generated.  For each
source file compiled with **-fprofile-arcs**, an accompanying
_.gcda_ file will be placed in the object file directory.

Running **gcov** with your program's source file names as arguments
will now produce a listing of the code along with frequency of execution
for each line.  For example, if your program is called _tmp.cpp_, this
is what you see when you use the basic **gcov** facility:

.Vb 6
        $ g++ --coverage tmp.cpp
        $ a.out
        $ gcov tmp.cpp -m
        File tmp.cpp\*(Aq
        Lines executed:92.86% of 14
        Creating tmp.cpp.gcov\*(Aq
.Ve

The file _tmp.cpp.gcov_ contains output from **gcov**.
Here is a sample:

.Vb 10
                -:    0:Source:tmp.cpp
                -:    0:Working directory:/home/gcc/testcase
                -:    0:Graph:tmp.gcno
                -:    0:Data:tmp.gcda
                -:    0:Runs:1
                -:    0:Programs:1
                -:    1:#include &lt;stdio.h&gt;
                -:    2:
                -:    3:template&lt;class T&gt;
                -:    4:class Foo
                -:    5:{
                -:    6:  public:
               1*:    7:  Foo(): b (1000) {}
        ------------------
        Foo&lt;char&gt;::Foo():
            #####:    7:  Foo(): b (1000) {}
        ------------------
        Foo&lt;int&gt;::Foo():
                1:    7:  Foo(): b (1000) {}
        ------------------
               2*:    8:  void inc () { b++; }
        ------------------
        Foo&lt;char&gt;::inc():
            #####:    8:  void inc () { b++; }
        ------------------
        Foo&lt;int&gt;::inc():
                2:    8:  void inc () { b++; }
        ------------------
                -:    9:
                -:   10:  private:
                -:   11:  int b;
                -:   12:};
                -:   13:
                -:   14:template class Foo&lt;int&gt;;
                -:   15:template class Foo&lt;char&gt;;
                -:   16:
                -:   17:int
                1:   18:main (void)
                -:   19:{
                -:   20:  int i, total;
                1:   21:  Foo&lt;int&gt; counter;
                -:   22:
                1:   23:  counter.inc();
                1:   24:  counter.inc();
                1:   25:  total = 0;
                -:   26:
               11:   27:  for (i = 0; i &lt; 10; i++)
               10:   28:    total += i;
                -:   29:
               1*:   30:  int v = total &gt; 100 ? 1 : 2;
                -:   31:
                1:   32:  if (total != 45)
            #####:   33:    printf ("Failure\en");
                -:   34:  else
                1:   35:    printf ("Success\en");
                1:   36:  return 0;
                -:   37:}
.Ve

Note that line 7 is shown in the report multiple times.  First occurrence
presents total number of execution of the line and the next two belong
to instances of class Foo constructors.  As you can also see, line 30 contains
some unexecuted basic blocks and thus execution count has asterisk symbol.

When you use the **-a** option, you will get individual block
counts, and the output looks like this:

.Vb 10
                -:    0:Source:tmp.cpp
                -:    0:Working directory:/home/gcc/testcase
                -:    0:Graph:tmp.gcno
                -:    0:Data:tmp.gcda
                -:    0:Runs:1
                -:    0:Programs:1
                -:    1:#include &lt;stdio.h&gt;
                -:    2:
                -:    3:template&lt;class T&gt;
                -:    4:class Foo
                -:    5:{
                -:    6:  public:
               1*:    7:  Foo(): b (1000) {}
        ------------------
        Foo&lt;char&gt;::Foo():
            #####:    7:  Foo(): b (1000) {}
        ------------------
        Foo&lt;int&gt;::Foo():
                1:    7:  Foo(): b (1000) {}
        ------------------
               2*:    8:  void inc () { b++; }
        ------------------
        Foo&lt;char&gt;::inc():
            #####:    8:  void inc () { b++; }
        ------------------
        Foo&lt;int&gt;::inc():
                2:    8:  void inc () { b++; }
        ------------------
                -:    9:
                -:   10:  private:
                -:   11:  int b;
                -:   12:};
                -:   13:
                -:   14:template class Foo&lt;int&gt;;
                -:   15:template class Foo&lt;char&gt;;
                -:   16:
                -:   17:int
                1:   18:main (void)
                -:   19:{
                -:   20:  int i, total;
                1:   21:  Foo&lt;int&gt; counter;
                1:   21-block  0
                -:   22:
                1:   23:  counter.inc();
                1:   23-block  0
                1:   24:  counter.inc();
                1:   24-block  0
                1:   25:  total = 0;
                -:   26:
               11:   27:  for (i = 0; i &lt; 10; i++)
                1:   27-block  0
               11:   27-block  1
               10:   28:    total += i;
               10:   28-block  0
                -:   29:
               1*:   30:  int v = total &gt; 100 ? 1 : 2;
                1:   30-block  0
            %%%%%:   30-block  1
                1:   30-block  2
                -:   31:
                1:   32:  if (total != 45)
                1:   32-block  0
            #####:   33:    printf ("Failure\en");
            %%%%%:   33-block  0
                -:   34:  else
                1:   35:    printf ("Success\en");
                1:   35-block  0
                1:   36:  return 0;
                1:   36-block  0
                -:   37:}
.Ve

In this mode, each basic block is only shown on one line  the last
line of the block.  A multi-line block will only contribute to the
execution count of that last line, and other lines will not be shown
to contain code, unless previous blocks end on those lines.
The total execution count of a line is shown and subsequent lines show
the execution counts for individual blocks that end on that line.  After each
block, the branch and call counts of the block will be shown, if the
**-b** option is given.

Because of the way \s-1GCC\s0 instruments calls, a call count can be shown
after a line with no individual blocks.
As you can see, line 33 contains a basic block that was not executed.

When you use the **-b** option, your output looks like this:

.Vb 10
                -:    0:Source:tmp.cpp
                -:    0:Working directory:/home/gcc/testcase
                -:    0:Graph:tmp.gcno
                -:    0:Data:tmp.gcda
                -:    0:Runs:1
                -:    0:Programs:1
                -:    1:#include &lt;stdio.h&gt;
                -:    2:
                -:    3:template&lt;class T&gt;
                -:    4:class Foo
                -:    5:{
                -:    6:  public:
               1*:    7:  Foo(): b (1000) {}
        ------------------
        Foo&lt;char&gt;::Foo():
        function Foo&lt;char&gt;::Foo() called 0 returned 0% blocks executed 0%
            #####:    7:  Foo(): b (1000) {}
        ------------------
        Foo&lt;int&gt;::Foo():
        function Foo&lt;int&gt;::Foo() called 1 returned 100% blocks executed 100%
                1:    7:  Foo(): b (1000) {}
        ------------------
               2*:    8:  void inc () { b++; }
        ------------------
        Foo&lt;char&gt;::inc():
        function Foo&lt;char&gt;::inc() called 0 returned 0% blocks executed 0%
            #####:    8:  void inc () { b++; }
        ------------------
        Foo&lt;int&gt;::inc():
        function Foo&lt;int&gt;::inc() called 2 returned 100% blocks executed 100%
                2:    8:  void inc () { b++; }
        ------------------
                -:    9:
                -:   10:  private:
                -:   11:  int b;
                -:   12:};
                -:   13:
                -:   14:template class Foo&lt;int&gt;;
                -:   15:template class Foo&lt;char&gt;;
                -:   16:
                -:   17:int
        function main called 1 returned 100% blocks executed 81%
                1:   18:main (void)
                -:   19:{
                -:   20:  int i, total;
                1:   21:  Foo&lt;int&gt; counter;
        call    0 returned 100%
        branch  1 taken 100% (fallthrough)
        branch  2 taken 0% (throw)
                -:   22:
                1:   23:  counter.inc();
        call    0 returned 100%
        branch  1 taken 100% (fallthrough)
        branch  2 taken 0% (throw)
                1:   24:  counter.inc();
        call    0 returned 100%
        branch  1 taken 100% (fallthrough)
        branch  2 taken 0% (throw)
                1:   25:  total = 0;
                -:   26:
               11:   27:  for (i = 0; i &lt; 10; i++)
        branch  0 taken 91% (fallthrough)
        branch  1 taken 9%
               10:   28:    total += i;
                -:   29:
               1*:   30:  int v = total &gt; 100 ? 1 : 2;
        branch  0 taken 0% (fallthrough)
        branch  1 taken 100%
                -:   31:
                1:   32:  if (total != 45)
        branch  0 taken 0% (fallthrough)
        branch  1 taken 100%
            #####:   33:    printf ("Failure\en");
        call    0 never executed
        branch  1 never executed
        branch  2 never executed
                -:   34:  else
                1:   35:    printf ("Success\en");
        call    0 returned 100%
        branch  1 taken 100% (fallthrough)
        branch  2 taken 0% (throw)
                1:   36:  return 0;
                -:   37:}
.Ve

For each function, a line is printed showing how many times the function
is called, how many times it returns and what percentage of the
function's blocks were executed.

For each basic block, a line is printed after the last line of the basic
block describing the branch or call that ends the basic block.  There can
be multiple branches and calls listed for a single source line if there
are multiple basic blocks that end on that line.  In this case, the
branches and calls are each given a number.  There is no simple way to map
these branches and calls back to source constructs.  In general, though,
the lowest numbered branch or call will correspond to the leftmost construct
on the source line.

For a branch, if it was executed at least once, then a percentage
indicating the number of times the branch was taken divided by the
number of times the branch was executed will be printed.  Otherwise, the
message never executed\*(R" is printed.

For a call, if it was executed at least once, then a percentage
indicating the number of times the call returned divided by the number
of times the call was executed will be printed.  This will usually be
100%, but may be less for functions that call \f(CW`exit\*(C' or \f(CW\*(C\`longjmp\*(C',
and thus may not return every time they are called.

The execution counts are cumulative.  If the example program were
executed again without removing the _.gcda_ file, the count for the
number of times each line in the source was executed would be added to
the results of the previous run(s).  This is potentially useful in
several ways.  For example, it could be used to accumulate data over a
number of program runs as part of a test verification suite, or to
provide more accurate long-term information over a large number of
program runs.

The data in the _.gcda_ files is saved immediately before the program
exits.  For each source file compiled with **-fprofile-arcs**, the
profiling code first attempts to read in an existing _.gcda_ file; if
the file doesn't match the executable (differing number of basic block
counts) it will ignore the contents of the file.  It then adds in the
new execution counts and finally writes the data to the file.

<a name="using-fbgcovfp-with-s-1gccs0-optimization"></a>

### Using \fBgcov\fP with \s-1GCC\s0 Optimization

.IX Subsection "Using gcov with GCC Optimization"
If you plan to use **gcov** to help optimize your code, you must
first compile your program with a special \s-1GCC\s0 option
**--coverage**.  Aside from that, you can use any
other \s-1GCC\s0 options; but if you want to prove that every single line
in your program was executed, you should not compile with optimization
at the same time.  On some machines the optimizer can eliminate some
simple code lines by combining them with other lines.  For example, code
like this:

.Vb 4
        if (a != b)
          c = 1;
        else
          c = 0;
.Ve

can be compiled into one instruction on some machines.  In this case,
there is no way for **gcov** to calculate separate execution counts
for each line because there isn't separate code for each line.  Hence
the **gcov** output looks like this if you compiled the program with
optimization:

.Vb 4
              100:   12:if (a != b)
              100:   13:  c = 1;
              100:   14:else
              100:   15:  c = 0;
.Ve

The output shows that this block of code, combined by optimization,
executed 100 times.  In one sense this result is correct, because there
was only one instruction representing all four of these lines.  However,
the output does not indicate how many times the result was 0 and how
many times the result was 1.

Inlineable functions can create unexpected line counts.  Line counts are
shown for the source code of the inlineable function, but what is shown
depends on where the function is inlined, or if it is not inlined at all.

If the function is not inlined, the compiler must emit an out of line
copy of the function, in any object file that needs it.  If
_fileA.o_ and _fileB.o_ both contain out of line bodies of a
particular inlineable function, they will also both contain coverage
counts for that function.  When _fileA.o_ and _fileB.o_ are
linked together, the linker will, on many systems, select one of those
out of line bodies for all calls to that function, and remove or ignore
the other.  Unfortunately, it will not remove the coverage counters for
the unused function body.  Hence when instrumented, all but one use of
that function will show zero counts.

If the function is inlined in several places, the block structure in
each location might not be the same.  For instance, a condition might
now be calculable at compile time in some instances.  Because the
coverage of all the uses of the inline function will be shown for the
same source lines, the line counts themselves might seem inconsistent.

Long-running applications can use the \f(CW`\_\|\_gcov\_reset\*(C' and \f(CW\*(C\`\_\|\_gcov\_dump\*(C'
facilities to restrict profile collection to the program region of
interest. Calling \f(CW`\_\|\_gcov\_reset(void)\*(C' will clear all profile counters
to zero, and calling \f(CW`\_\|\_gcov\_dump(void)\*(C' will cause the profile information
collected at that point to be dumped to _.gcda_ output files.
Instrumented applications use a static destructor with priority 99
to invoke the \f(CW`\_\|\_gcov\_dump\*(C' function. Thus \f(CW\*(C\`\_\|\_gcov\_dump\*(C'
is executed after all user defined static destructors,
as well as handlers registered with \f(CW`atexit\*(C'.
If an executable loads a dynamic shared object via dlopen functionality,
**-Wl,--dynamic-list-data** is needed to dump all profile data.

Profiling run-time library reports various errors related to profile
manipulation and profile saving.  Errors are printed into standard error output
or **\s-1GCOV\_ERROR\_FILE\s0** file, if environment variable is used.
In order to terminate immediately after an errors occurs
set **\s-1GCOV\_EXIT\_AT\_ERROR\s0** environment variable.
That can help users to find profile clashing which leads
to a misleading profile.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**gpl**\|(7), **gfdl**\|(7), **fsf-funding**\|(7), **gcc**\|(1) and the Info entry for _gcc_.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1996-2019 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation; with the
Invariant Sections being \s-1GNU\s0 General Public License\*(R" and \*(L"Funding
Free Software, the Front-Cover texts being (a) (see below), and with
the Back-Cover Texts being (b) (see below).  A copy of the license is
included in the **gfdl**\|(7) man page.

(a) The \s-1FSF\s0's Front-Cover Text is:

.Vb 1
     A GNU Manual
.Ve

(b) The \s-1FSF\s0's Back-Cover Text is:

.Vb 3
     You have freedom to copy and modify this GNU Manual, like GNU
     software.  Copies published by the Free Software Foundation raise
     funds for GNU development.
.Ve
