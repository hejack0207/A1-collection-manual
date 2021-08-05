# cmake(1) - CMake Command-Line Reference

3.17.2, Apr 28, 2020

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

```
.INDENT 0.0 .INDENT 3.5 

</synopsis>
    .ft C
    Generate a Project Buildsystem
     cmake [<options>] <path-to-source>
     cmake [<options>] <path-to-existing-build>
     cmake [<options>] -S <path-to-source> -B <path-to-build>
    
    Build a Project
     cmake --build <dir> [<options>] [-- <build-tool-options>]
    
    Install a Project
     cmake --install <dir> [<options>]
    
    Open a Project
     cmake --open <dir>
    
    Run a Script
     cmake [{-D <var>=<value>}...] -P <cmake-script-file>
    
    Run a Command-Line Tool
     cmake -E <command> [<options>]
    
    Run the Find-Package Tool
     cmake --find-package [<options>]
    
    View Help
     cmake --help[-<topic>]
    .ft P
<synopsis>
.UNINDENT .UNINDENT
```

<a name="description"></a>

# Description


The **cmake** executable is the command-line interface of the cross-platform
buildsystem generator CMake.  The above _Synopsis_ lists various actions
the tool can perform as described in sections below.

To build a software project with CMake, _Generate a Project Buildsystem_.
Optionally use **cmake** to _Build a Project_, _Install a Project_ or just
run the corresponding build tool (e.g. **make**) directly.  **cmake** can also
be used to _View Help_.

The other actions are meant for use by software developers writing
scripts in the **CMake language** to support
their builds.

For graphical user interfaces that may be used in place of **cmake**,
see **ccmake** and **cmake-gui**.
For command-line interfaces to the CMake testing and packaging facilities,
see **ctest** and **cpack**.

For more information on CMake at large, _see also_ the links at the end
of this manual.

<a name="introduction-to-cmake-buildsystems"></a>

# Introduction to Cmake Buildsystems


A _buildsystem_ describes how to build a project’s executables and libraries
from its source code using a _build tool_ to automate the process.  For
example, a buildsystem may be a **Makefile** for use with a command-line
**make** tool or a project file for an Integrated Development Environment
(IDE).  In order to avoid maintaining multiple such buildsystems, a project
may specify its buildsystem abstractly using files written in the
**CMake language**.  From these files CMake
generates a preferred buildsystem locally for each user through a backend
called a _generator_.

To generate a buildsystem with CMake, the following must be selected:
.INDENT 0.0

* **Source Tree**  
  The top-level directory containing source files provided by the project.
  The project specifies its buildsystem using files as described in the
  **cmake-language(7)** manual, starting with a top-level file named
  **CMakeLists.txt**.  These files specify build targets and their
  dependencies as described in the **cmake-buildsystem(7)** manual.
* **Build Tree**  
  The top-level directory in which buildsystem files and build output
  artifacts (e.g. executables and libraries) are to be stored.
  CMake will write a **CMakeCache.txt** file to identify the directory
  as a build tree and store persistent information such as buildsystem
  configuration options.

To maintain a pristine source tree, perform an _out-of-source_ build
by using a separate dedicated build tree.  An _in-source_ build in
which the build tree is placed in the same directory as the source
tree is also supported, but discouraged.

* **Generator**  
  This chooses the kind of buildsystem to generate.  See the
  **cmake-generators(7)** manual for documentation of all generators.
  Run **cmake --help** to see a list of generators available locally.
  Optionally use the **-G** option below to specify a generator, or simply
  accept the default CMake chooses for the current platform.

When using one of the Command-Line Build Tool Generators
CMake expects that the environment needed by the compiler toolchain
is already configured in the shell.  When using one of the
IDE Build Tool Generators, no particular environment is needed.
.UNINDENT

<a name="generate-a-project-buildsystem"></a>

# Generate a Project Buildsystem


Run CMake with one of the following command signatures to specify the
source and build trees and generate a buildsystem:
.INDENT 0.0

* <b>**cmake [&lt;options&gt;] &lt;path-to-source&gt;**</b>  
  Uses the current working directory as the build tree, and
  **&lt;path-to-source&gt;** as the source tree.  The specified path may
  be absolute or relative to the current working directory.
  The source tree must contain a **CMakeLists.txt** file and must
  _not_ contain a **CMakeCache.txt** file because the latter
  identifies an existing build tree.  For example:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ mkdir build ; cd build
    $ cmake ../src
    .ft P
.UNINDENT
.UNINDENT

* <b>**cmake [&lt;options&gt;] &lt;path-to-existing-build&gt;**</b>  
  Uses **&lt;path-to-existing-build&gt;** as the build tree, and loads the
  path to the source tree from its **CMakeCache.txt** file, which must
  have already been generated by a previous run of CMake.  The specified
  path may be absolute or relative to the current working directory.
  For example:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ cd build
    $ cmake .
    .ft P
.UNINDENT
.UNINDENT

* <b>**cmake [&lt;options&gt;] -S &lt;path-to-source&gt; -B &lt;path-to-build&gt;**</b>  
  Uses **&lt;path-to-build&gt;** as the build tree and **&lt;path-to-source&gt;**
  as the source tree.  The specified paths may be absolute or relative
  to the current working directory.  The source tree must contain a
  **CMakeLists.txt** file.  The build tree will be created automatically
  if it does not already exist.  For example:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $ cmake -S src -B build
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT

In all cases the **&lt;options&gt;** may be zero or more of the _Options_ below.

After generating a buildsystem one may use the corresponding native
build tool to build the project.  For example, after using the
**Unix Makefiles** generator one may run **make** directly:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ make
    $ make install
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

Alternatively, one may use **cmake** to _Build a Project_ by
automatically choosing and invoking the appropriate native build tool.

<a name="options"></a>

### Options

.INDENT 0.0

* <b>**-S &lt;path-to-source&gt;**</b>  
  Path to root directory of the CMake project to build.
* <b>**-B &lt;path-to-build&gt;**</b>  
  Path to directory which CMake will use as the root of build directory.

If the directory doesn’t already exist CMake will make it.

* <b>**-C &lt;initial-cache&gt;**</b>  
  Pre-load a script to populate the cache.

When CMake is first run in an empty build tree, it creates a
**CMakeCache.txt** file and populates it with customizable settings for
the project.  This option may be used to specify a file from which
to load cache entries before the first pass through the project’s
CMake listfiles.  The loaded entries take priority over the
project’s default values.  The given file should be a CMake script
containing **set()** commands that use the **CACHE** option, not a
cache-format file.

References to **CMAKE\_SOURCE\_DIR** and **CMAKE\_BINARY\_DIR**
within the script evaluate to the top-level source and build tree.

* <b>**-D &lt;var&gt;:&lt;type&gt;=&lt;value&gt;, -D &lt;var&gt;=&lt;value&gt;**</b>  
  Create or update a CMake **CACHE** entry.

When CMake is first run in an empty build tree, it creates a
**CMakeCache.txt** file and populates it with customizable settings for
the project.  This option may be used to specify a setting that
takes priority over the project’s default value.  The option may be
repeated for as many **CACHE** entries as desired.

If the **:&lt;type&gt;** portion is given it must be one of the types
specified by the **set()** command documentation for its
**CACHE** signature.
If the **:&lt;type&gt;** portion is omitted the entry will be created
with no type if it does not exist with a type already.  If a
command in the project sets the type to **PATH** or **FILEPATH**
then the **&lt;value&gt;** will be converted to an absolute path.

This option may also be given as a single argument:
**-D&lt;var&gt;:&lt;type&gt;=&lt;value&gt;** or **-D&lt;var&gt;=&lt;value&gt;**.

* <b>**-U &lt;globbing\_expr&gt;**</b>  
  Remove matching entries from CMake **CACHE**.

This option may be used to remove one or more variables from the
**CMakeCache.txt** file, globbing expressions using *** and ?** are
supported.  The option may be repeated for as many **CACHE** entries as
desired.

Use with care, you can make your **CMakeCache.txt** non-working.

* <b>**-G &lt;generator-name&gt;**</b>  
  Specify a build system generator.

CMake may support multiple native build systems on certain
platforms.  A generator is responsible for generating a particular
build system.  Possible generator names are specified in the
**cmake-generators(7)** manual.

If not specified, CMake checks the **CMAKE\_GENERATOR** environment
variable and otherwise falls back to a builtin default selection.

* <b>**-T &lt;toolset-spec&gt;**</b>  
  Toolset specification for the generator, if supported.

Some CMake generators support a toolset specification to tell
the native build system how to choose a compiler.  See the
**CMAKE\_GENERATOR\_TOOLSET** variable for details.

* <b>**-A &lt;platform-name&gt;**</b>  
  Specify platform name if supported by generator.

Some CMake generators support a platform name to be given to the
native build system to choose a compiler or SDK.  See the
**CMAKE\_GENERATOR\_PLATFORM** variable for details.

* <b>**-Wno-dev**</b>  
  Suppress developer warnings.

Suppress warnings that are meant for the author of the
**CMakeLists.txt** files. By default this will also turn off
deprecation warnings.

* <b>**-Wdev**</b>  
  Enable developer warnings.

Enable warnings that are meant for the author of the **CMakeLists.txt**
files. By default this will also turn on deprecation warnings.

* <b>**-Werror=dev**</b>  
  Make developer warnings errors.

Make warnings that are meant for the author of the **CMakeLists.txt** files
errors. By default this will also turn on deprecated warnings as errors.

* <b>**-Wno-error=dev**</b>  
  Make developer warnings not errors.

Make warnings that are meant for the author of the **CMakeLists.txt** files not
errors. By default this will also turn off deprecated warnings as errors.

* <b>**-Wdeprecated**</b>  
  Enable deprecated functionality warnings.

Enable warnings for usage of deprecated functionality, that are meant
for the author of the **CMakeLists.txt** files.

* <b>**-Wno-deprecated**</b>  
  Suppress deprecated functionality warnings.

Suppress warnings for usage of deprecated functionality, that are meant
for the author of the **CMakeLists.txt** files.

* <b>**-Werror=deprecated**</b>  
  Make deprecated macro and function warnings errors.

Make warnings for usage of deprecated macros and functions, that are meant
for the author of the **CMakeLists.txt** files, errors.

* <b>**-Wno-error=deprecated**</b>  
  Make deprecated macro and function warnings not errors.

Make warnings for usage of deprecated macros and functions, that are meant
for the author of the **CMakeLists.txt** files, not errors.

* <b>**-L[A][H]**</b>  
  List non-advanced cached variables.

List **CACHE** variables will run CMake and list all the variables from
the CMake **CACHE** that are not marked as **INTERNAL** or **ADVANCED**.
This will effectively display current CMake settings, which can then be
changed with **-D** option.  Changing some of the variables may result
in more variables being created.  If **A** is specified, then it will
display also advanced variables.  If **H** is specified, it will also
display help for each variable.

* <b>**-N**</b>  
  View mode only.

Only load the cache.  Do not actually run configure and generate
steps.

* <b>**--graphviz=[file]**</b>  
  Generate graphviz of dependencies, see **CMakeGraphVizOptions** for more.

Generate a graphviz input file that will contain all the library and
executable dependencies in the project.  See the documentation for
**CMakeGraphVizOptions** for more details.

* <b>**--system-information [file]**</b>  
  Dump information about this system.

Dump a wide range of information about the current system.  If run
from the top of a binary tree for a CMake project it will dump
additional information such as the cache, log files etc.

* <b>**--log-level=&lt;ERROR|WARNING|NOTICE|STATUS|VERBOSE|DEBUG|TRACE&gt;**</b>  
  Set the log level.

The **message()** command will only output messages of the specified
log level or higher.  The default log level is **STATUS**.

To make a log level persist between CMake runs, set
**CMAKE\_MESSAGE\_LOG\_LEVEL** as a cache variable instead.
If both the command line option and the variable are given, the command line
option takes precedence.

For backward compatibility reasons, **--loglevel** is also accepted as a
synonym for this option.

* <b>**--log-context**</b>  
  Enable the **message()** command outputting context attached to each
  message.

This option turns on showing context for the current CMake run only.
To make showing the context persistent for all subsequent CMake runs, set
**CMAKE\_MESSAGE\_CONTEXT\_SHOW** as a cache variable instead.
When this command line option is given, **CMAKE\_MESSAGE\_CONTEXT\_SHOW**
is ignored.

* <b>**--debug-trycompile**</b>  
  Do not delete the **try\_compile()** build tree.
  Only useful on one **try\_compile()** at a time.

Do not delete the files and directories created for **try\_compile()**
calls.  This is useful in debugging failed try_compiles.  It may
however change the results of the try-compiles as old junk from a
previous try-compile may cause a different test to either pass or
fail incorrectly.  This option is best used for one try-compile at a
time, and only when debugging.

* <b>**--debug-output**</b>  
  Put cmake in a debug mode.

Print extra information during the cmake run like stack traces with
**message(SEND\_ERROR)** calls.

* <b>**--debug-find**</b>  
  Put cmake find commands in a debug mode.

Print extra find call information during the cmake run to standard
error. Output is designed for human consumption and not for parsing.
See also the **CMAKE\_FIND\_DEBUG\_MODE** variable for debugging
a more local part of the project.

* <b>**--trace**</b>  
  Put cmake in trace mode.

Print a trace of all calls made and from where.

* <b>**--trace-expand**</b>  
  Put cmake in trace mode.

Like **--trace**, but with variables expanded.

* <b>**--trace-format=&lt;format&gt;**</b>  
  Put cmake in trace mode and sets the trace output format.

**&lt;format&gt;** can be one of the following values.
.INDENT 7.0
.INDENT 3.5
.INDENT 0.0

* <b>**human**</b>  
  Prints each trace line in a human-readable format. This is the
  default format.
* <b>**json-v1**</b>  
  Prints each line as a separate JSON document. Each document is
  separated by a newline ( **\en** ). It is guaranteed that no
  newline characters will be present inside a JSON document.

JSON trace format:
.INDENT 7.0
.INDENT 3.5

    .ft C
    {
      "file": "/full/path/to/the/CMake/file.txt",
      "line": 0,
      "cmd": "add_executable",
      "args": ["foo", "bar"],
      "time": 1579512535.9687231,
      "frame": 2
    }
    .ft P
.UNINDENT
.UNINDENT

The members are:
.INDENT 7.0

* <b>**file**</b>  
  The full path to the CMake source file where the function
  was called.
* <b>**line**</b>  
  The line in **file** of the function call.
* <b>**cmd**</b>  
  The name of the function that was called.
* <b>**args**</b>  
  A string list of all function parameters.
* <b>**time**</b>  
  Timestamp (seconds since epoch) of the function call.
* <b>**frame**</b>  
  Stack frame depth of the function that was called.
  .UNINDENT

Additionally, the first JSON document outputted contains the
**version** key for the current major and minor version of the

JSON trace format:
.INDENT 7.0
.INDENT 3.5

    .ft C
    {
      "version": {
        "major": 1,
        "minor": 0
      }
    }
    .ft P
.UNINDENT
.UNINDENT

The members are:
.INDENT 7.0

* <b>**version**</b>  
  Indicates the version of the JSON format. The version has a
  major and minor components following semantic version conventions.
  .UNINDENT
  .UNINDENT
  .UNINDENT
  .UNINDENT
* <b>**--trace-source=&lt;file&gt;**</b>  
  Put cmake in trace mode, but output only lines of a specified file.

Multiple options are allowed.

* <b>**--trace-redirect=&lt;file&gt;**</b>  
  Put cmake in trace mode and redirect trace output to a file instead of stderr.
* <b>**--warn-uninitialized**</b>  
  Warn about uninitialized values.

Print a warning when an uninitialized variable is used.

* <b>**--warn-unused-vars**</b>  
  Warn about unused variables.

Find variables that are declared or set, but not used.

* <b>**--no-warn-unused-cli**</b>  
  Don’t warn about command line options.

Don’t find variables that are declared on the command line, but not
used.

* <b>**--check-system-vars**</b>  
  Find problems with variable usage in system files.

Normally, unused and uninitialized variables are searched for only
in **CMAKE\_SOURCE\_DIR** and **CMAKE\_BINARY\_DIR**.
This flag tells CMake to warn about other files as well.
.UNINDENT

<a name="build-a-project"></a>

# Build a Project


CMake provides a command-line signature to build an already-generated
project binary tree:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake --build <dir> [<options>] [-- <build-tool-options>]
    .ft P
.UNINDENT
.UNINDENT

This abstracts a native build tool’s command-line interface with the
following options:
.INDENT 0.0

* <b>**--build &lt;dir&gt;**</b>  
  Project binary directory to be built.  This is required and must be first.
* <b>**--parallel [&lt;jobs&gt;], -j [&lt;jobs&gt;]**</b>  
  The maximum number of concurrent processes to use when building.
  If **&lt;jobs&gt;** is omitted the native build tool’s default number is used.

The **CMAKE\_BUILD\_PARALLEL\_LEVEL** environment variable, if set,
specifies a default parallel level when this option is not given.

Some native build tools always build in parallel.  The use of **&lt;jobs&gt;**
value of **1** can be used to limit to a single job.

* <b>**--target &lt;tgt&gt;..., -t &lt;tgt&gt;...**</b>  
  Build **&lt;tgt&gt;** instead of the default target.  Multiple targets may be
  given, separated by spaces.
* <b>**--config &lt;cfg&gt;**</b>  
  For multi-configuration tools, choose configuration **&lt;cfg&gt;**.
* <b>**--clean-first**</b>  
  Build target **clean** first, then build.
  (To clean only, use **--target clean**.)
* <b>**--use-stderr**</b>  
  Ignored.  Behavior is default in CMake &gt;= 3.0.
* <b>**--verbose, -v**</b>  
  Enable verbose output - if supported - including the build commands to be
  executed.

This option can be omitted if **VERBOSE** environment variable or
**CMAKE\_VERBOSE\_MAKEFILE** cached variable is set.

* <b>**--**</b>  
  Pass remaining options to the native tool.
  .UNINDENT

Run **cmake --build** with no options for quick help.

<a name="install-a-project"></a>

# Install a Project


CMake provides a command-line signature to install an already-generated
project binary tree:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake --install <dir> [<options>]
    .ft P
.UNINDENT
.UNINDENT

This may be used after building a project to run installation without
using the generated build system or the native build tool.
The options are:
.INDENT 0.0

* <b>**--install &lt;dir&gt;**</b>  
  Project binary directory to install. This is required and must be first.
* <b>**--config &lt;cfg&gt;**</b>  
  For multi-configuration generators, choose configuration **&lt;cfg&gt;**.
* <b>**--component &lt;comp&gt;**</b>  
  Component-based install. Only install component **&lt;comp&gt;**.
* <b>**--prefix &lt;prefix&gt;**</b>  
  Override the installation prefix, **CMAKE\_INSTALL\_PREFIX**.
* <b>**--strip**</b>  
  Strip before installing.
* <b>**-v, --verbose**</b>  
  Enable verbose output.

This option can be omitted if **VERBOSE** environment variable is set.
.UNINDENT

Run **cmake --install** with no options for quick help.

<a name="open-a-project"></a>

# Open a Project

.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake --open <dir>
    .ft P
.UNINDENT
.UNINDENT

Open the generated project in the associated application.  This is only
supported by some generators.

<a name="run-a-script"></a>

# Run a Script

.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake [{-D <var>=<value>}...] -P <cmake-script-file>
    .ft P
.UNINDENT
.UNINDENT

Process the given cmake file as a script written in the CMake
language.  No configure or generate step is performed and the cache
is not modified.  If variables are defined using **-D**, this must be
done before the **-P** argument.

<a name="run-a-command-line-tool"></a>

# Run a Command-Line Tool


CMake provides builtin command-line tools through the signature
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake -E <command> [<options>]
    .ft P
.UNINDENT
.UNINDENT

Run **cmake -E** or **cmake -E help** for a summary of commands.
Available commands are:
.INDENT 0.0

* <b>**capabilities**</b>  
  Report cmake capabilities in JSON format. The output is a JSON object
  with the following keys:
  .INDENT 7.0
* <b>**version**</b>  
  A JSON object with version information. Keys are:
  .INDENT 7.0
* <b>**string**</b>  
  The full version string as displayed by cmake **--version**.
* <b>**major**</b>  
  The major version number in integer form.
* <b>**minor**</b>  
  The minor version number in integer form.
* <b>**patch**</b>  
  The patch level in integer form.
* <b>**suffix**</b>  
  The cmake version suffix string.
* <b>**isDirty**</b>  
  A bool that is set if the cmake build is from a dirty tree.
  .UNINDENT
* <b>**generators**</b>  
  A list available generators. Each generator is a JSON object with the
  following keys:
  .INDENT 7.0
* <b>**name**</b>  
  A string containing the name of the generator.
* <b>**toolsetSupport**</b>  
  **true** if the generator supports toolsets and **false** otherwise.
* <b>**platformSupport**</b>  
  **true** if the generator supports platforms and **false** otherwise.
* <b>**extraGenerators**</b>  
  A list of strings with all the extra generators compatible with
  the generator.
  .UNINDENT
* <b>**fileApi**</b>  
  Optional member that is present when the **cmake-file-api(7)**
  is available.  The value is a JSON object with one member:
  .INDENT 7.0
* <b>**requests**</b>  
  A JSON array containing zero or more supported file-api requests.
  Each request is a JSON object with members:
  .INDENT 7.0
* <b>**kind**</b>  
  Specifies one of the supported file-api object kinds.
* <b>**version**</b>  
  A JSON array whose elements are each a JSON object containing
  **major** and **minor** members specifying non-negative integer
  version components.
  .UNINDENT
  .UNINDENT
* <b>**serverMode**</b>  
  **true** if cmake supports server-mode and **false** otherwise.
  .UNINDENT
* <b>**chdir &lt;dir&gt; &lt;cmd&gt; [&lt;arg&gt;...]**</b>  
  Change the current working directory and run a command.
* <b>**compare_files [--ignore-eol] &lt;file1&gt; &lt;file2&gt;**</b>  
  Check if **&lt;file1&gt;** is same as **&lt;file2&gt;**. If files are the same,
  then returns **0**, if not it returns **1**.  The **--ignore-eol** option
  implies line-wise comparison and ignores LF/CRLF differences.
* <b>**copy &lt;file&gt;... &lt;destination&gt;**</b>  
  Copy files to **&lt;destination&gt;** (either file or directory).
  If multiple files are specified, the **&lt;destination&gt;** must be
  directory and it must exist. Wildcards are not supported.
  **copy** does follow symlinks. That means it does not copy symlinks,
  but the files or directories it point to.
* <b>**copy_directory &lt;dir&gt;... &lt;destination&gt;**</b>  
  Copy content of **&lt;dir&gt;...** directories to **&lt;destination&gt;** directory.
  If **&lt;destination&gt;** directory does not exist it will be created.
  **copy\_directory** does follow symlinks.
* <b>**copy_if_different &lt;file&gt;... &lt;destination&gt;**</b>  
  Copy files to **&lt;destination&gt;** (either file or directory) if
  they have changed.
  If multiple files are specified, the **&lt;destination&gt;** must be
  directory and it must exist.
  **copy\_if\_different** does follow symlinks.
* <b>**create_symlink &lt;old&gt; &lt;new&gt;**</b>  
  Create a symbolic link **&lt;new&gt;** naming **&lt;old&gt;**.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
Path to where **&lt;new&gt;** symbolic link will be created has to exist beforehand.
.UNINDENT
.UNINDENT

* <b>**echo [&lt;string&gt;...]**</b>  
  Displays arguments as text.
* <b>**echo_append [&lt;string&gt;...]**</b>  
  Displays arguments as text but no new line.
* <b>**env [--unset=NAME]... [NAME=VALUE]... COMMAND [ARG]...**</b>  
  Run command in a modified environment.
* <b>**environment**</b>  
  Display the current environment variables.
* <b>**false**</b>  
  Do nothing, with an exit code of 1.
* <b>**make_directory &lt;dir&gt;...**</b>  
  Create **&lt;dir&gt;** directories.  If necessary, create parent
  directories too.  If a directory already exists it will be
  silently ignored.
* <b>**md5sum &lt;file&gt;...**</b>  
  Create MD5 checksum of files in **md5sum** compatible format:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    351abe79cd3800b38cdfb25d45015a15  file1.txt
    052f86c15bbde68af55c7f7b340ab639  file2.txt
    .ft P
.UNINDENT
.UNINDENT

* <b>**sha1sum &lt;file&gt;...**</b>  
  Create SHA1 checksum of files in **sha1sum** compatible format:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    4bb7932a29e6f73c97bb9272f2bdc393122f86e0  file1.txt
    1df4c8f318665f9a5f2ed38f55adadb7ef9f559c  file2.txt
    .ft P
.UNINDENT
.UNINDENT

* <b>**sha224sum &lt;file&gt;...**</b>  
  Create SHA224 checksum of files in **sha224sum** compatible format:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    b9b9346bc8437bbda630b0b7ddfc5ea9ca157546dbbf4c613192f930  file1.txt
    6dfbe55f4d2edc5fe5c9197bca51ceaaf824e48eba0cc453088aee24  file2.txt
    .ft P
.UNINDENT
.UNINDENT

* <b>**sha256sum &lt;file&gt;...**</b>  
  Create SHA256 checksum of files in **sha256sum** compatible format:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    76713b23615d31680afeb0e9efe94d47d3d4229191198bb46d7485f9cb191acc  file1.txt
    15b682ead6c12dedb1baf91231e1e89cfc7974b3787c1e2e01b986bffadae0ea  file2.txt
    .ft P
.UNINDENT
.UNINDENT

* <b>**sha384sum &lt;file&gt;...**</b>  
  Create SHA384 checksum of files in **sha384sum** compatible format:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    acc049fedc091a22f5f2ce39a43b9057fd93c910e9afd76a6411a28a8f2b8a12c73d7129e292f94fc0329c309df49434  file1.txt
    668ddeb108710d271ee21c0f3acbd6a7517e2b78f9181c6a2ff3b8943af92b0195dcb7cce48aa3e17893173c0a39e23d  file2.txt
    .ft P
.UNINDENT
.UNINDENT

* <b>**sha512sum &lt;file&gt;...**</b>  
  Create SHA512 checksum of files in **sha512sum** compatible format:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    2a78d7a6c5328cfb1467c63beac8ff21794213901eaadafd48e7800289afbc08e5fb3e86aa31116c945ee3d7bf2a6194489ec6101051083d1108defc8e1dba89  file1.txt
    7a0b54896fe5e70cca6dd643ad6f672614b189bf26f8153061c4d219474b05dad08c4e729af9f4b009f1a1a280cb625454bf587c690f4617c27e3aebdf3b7a2d  file2.txt
    .ft P
.UNINDENT
.UNINDENT

* <b>**remove [-f] &lt;file&gt;...**</b>  
  Deprecated since version 3.17.
  

Remove the file(s). The planned behaviour was that if any of the
listed files already do not exist, the command returns a non-zero exit code,
but no message is logged. The **-f** option changes the behavior to return a
zero exit code (i.e. success) in such situations instead.
**remove** does not follow symlinks. That means it remove only symlinks
and not files it point to.

The implementation was buggy and always returned 0. It cannot be fixed without
breaking backwards compatibility. Use **rm** instead.

* <b>**remove_directory &lt;dir&gt;...**</b>  
  Deprecated since version 3.17.
  

Remove **&lt;dir&gt;** directories and their contents. If a directory does
not exist it will be silently ignored.  If **&lt;dir&gt;** is a symlink to
a directory, just the symlink will be removed.
Use **rm** instead.

* <b>**rename &lt;oldname&gt; &lt;newname&gt;**</b>  
  Rename a file or directory (on one volume). If file with the **&lt;newname&gt;** name
  already exists, then it will be silently replaced.
* <b>**rm [-rRf] &lt;file&gt; &lt;dir&gt;...**</b>  
  Remove the files **&lt;file&gt;** or directories **dir**.
  Use **-r** or **-R** to remove directories and their contents recursively.
  If any of the listed files/directories do not exist, the command returns a
  non-zero exit code, but no message is logged. The **-f** option changes
  the behavior to return a zero exit code (i.e. success) in such
  situations instead.
* <b>**server**</b>  
  Launch **cmake-server(7)** mode.
* <b>**sleep &lt;number&gt;...**</b>  
  Sleep for given number of seconds.
* <b>**tar [cxt][vf][zjJ] file.tar [&lt;options&gt;] [--] [&lt;pathname&gt;...]**</b>  
  Create or extract a tar or zip archive.  Options are:
  .INDENT 7.0
* <b>**c**</b>  
  Create a new archive containing the specified files.
  If used, the **&lt;pathname&gt;...** argument is mandatory.
* <b>**x**</b>  
  Extract to disk from the archive.
  The **&lt;pathname&gt;...** argument could be used to extract only selected files
  or directories.
  When extracting selected files or directories, you must provide their exact
  names including the path, as printed by list (**-t**).
* <b>**t**</b>  
  List archive contents.
  The **&lt;pathname&gt;...** argument could be used to list only selected files
  or directories.
* <b>**v**</b>  
  Produce verbose output.
* <b>**z**</b>  
  Compress the resulting archive with gzip.
* <b>**j**</b>  
  Compress the resulting archive with bzip2.
* <b>**J**</b>  
  Compress the resulting archive with XZ.
* <b>**--zstd**</b>  
  Compress the resulting archive with Zstandard.
* <b>**--files-from=&lt;file&gt;**</b>  
  Read file names from the given file, one per line.
  Blank lines are ignored.  Lines may not start in **-**
  except for **--add-file=&lt;name&gt;** to add files whose
  names start in **-**.
* <b>**--format=&lt;format&gt;**</b>  
  Specify the format of the archive to be created.
  Supported formats are: **7zip**, **gnutar**, **pax**,
  **paxr** (restricted pax, default), and **zip**.
* <b>**--mtime=&lt;date&gt;**</b>  
  Specify modification time recorded in tarball entries.
* <b>**--**</b>  
  Stop interpreting options and treat all remaining arguments
  as file names, even if they start with **-**.
  .UNINDENT
* <b>**time &lt;command&gt; [&lt;args&gt;...]**</b>  
  Run command and display elapsed time.
* <b>**touch &lt;file&gt;...**</b>  
  Creates **&lt;file&gt;** if file do not exist.
  If **&lt;file&gt;** exists, it is changing **&lt;file&gt;** access and modification times.
* <b>**touch_nocreate &lt;file&gt;...**</b>  
  Touch a file if it exists but do not create it.  If a file does
  not exist it will be silently ignored.
* <b>**true**</b>  
  Do nothing, with an exit code of 0.
  .UNINDENT

<a name="windows-specific-command-line-tools"></a>

### Windows\-specific Command\-Line Tools


The following **cmake -E** commands are available only on Windows:
.INDENT 0.0

* <b>**delete_regv &lt;key&gt;**</b>  
  Delete Windows registry value.
* <b>**env_vs8_wince &lt;sdkname&gt;**</b>  
  Displays a batch file which sets the environment for the provided
  Windows CE SDK installed in VS2005.
* <b>**env_vs9_wince &lt;sdkname&gt;**</b>  
  Displays a batch file which sets the environment for the provided
  Windows CE SDK installed in VS2008.
* <b>**write_regv &lt;key&gt; &lt;value&gt;**</b>  
  Write Windows registry value.
  .UNINDENT

<a name="run-the-find-package-tool"></a>

# Run the Find-Package Tool


CMake provides a pkg-config like helper for Makefile-based projects:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake --find-package [<options>]
    .ft P
.UNINDENT
.UNINDENT

It searches a package using **find\_package()** and prints the
resulting flags to stdout.  This can be used instead of pkg-config
to find installed libraries in plain Makefile-based projects or in
autoconf-based projects (via **share/aclocal/cmake.m4**).

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This mode is not well-supported due to some technical limitations.
It is kept for compatibility but should not be used in new projects.
.UNINDENT
.UNINDENT

<a name="view-help"></a>

# View Help


To print selected pages from the CMake documentation, use
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake --help[-<topic>]
    .ft P
.UNINDENT
.UNINDENT

with one of the following options:
.INDENT 0.0

* <b>**--help,-help,-usage,-h,-H,/?**</b>  
  Print usage information and exit.

Usage describes the basic command line interface and its options.

* <b>**--version,-version,/V [&lt;f&gt;]**</b>  
  Show program name/version banner and exit.

If a file is specified, the version is written into it.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-full [&lt;f&gt;]**</b>  
  Print all help manuals and exit.

All manuals are printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-manual &lt;man&gt; [&lt;f&gt;]**</b>  
  Print one help manual and exit.

The specified manual is printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-manual-list [&lt;f&gt;]**</b>  
  List help manuals available and exit.

The list contains all manuals for which help may be obtained by
using the **--help-manual** option followed by a manual name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-command &lt;cmd&gt; [&lt;f&gt;]**</b>  
  Print help for one command and exit.

The **cmake-commands(7)** manual entry for **&lt;cmd&gt;** is
printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-command-list [&lt;f&gt;]**</b>  
  List commands with help available and exit.

The list contains all commands for which help may be obtained by
using the **--help-command** option followed by a command name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-commands [&lt;f&gt;]**</b>  
  Print cmake-commands manual and exit.

The **cmake-commands(7)** manual is printed in a
human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-module &lt;mod&gt; [&lt;f&gt;]**</b>  
  Print help for one module and exit.

The **cmake-modules(7)** manual entry for **&lt;mod&gt;** is printed
in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-module-list [&lt;f&gt;]**</b>  
  List modules with help available and exit.

The list contains all modules for which help may be obtained by
using the **--help-module** option followed by a module name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-modules [&lt;f&gt;]**</b>  
  Print cmake-modules manual and exit.

The **cmake-modules(7)** manual is printed in a human-readable
text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-policy &lt;cmp&gt; [&lt;f&gt;]**</b>  
  Print help for one policy and exit.

The **cmake-policies(7)** manual entry for **&lt;cmp&gt;** is
printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-policy-list [&lt;f&gt;]**</b>  
  List policies with help available and exit.

The list contains all policies for which help may be obtained by
using the **--help-policy** option followed by a policy name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-policies [&lt;f&gt;]**</b>  
  Print cmake-policies manual and exit.

The **cmake-policies(7)** manual is printed in a
human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-property &lt;prop&gt; [&lt;f&gt;]**</b>  
  Print help for one property and exit.

The **cmake-properties(7)** manual entries for **&lt;prop&gt;** are
printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-property-list [&lt;f&gt;]**</b>  
  List properties with help available and exit.

The list contains all properties for which help may be obtained by
using the **--help-property** option followed by a property name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-properties [&lt;f&gt;]**</b>  
  Print cmake-properties manual and exit.

The **cmake-properties(7)** manual is printed in a
human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-variable &lt;var&gt; [&lt;f&gt;]**</b>  
  Print help for one variable and exit.

The **cmake-variables(7)** manual entry for **&lt;var&gt;** is
printed in a human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-variable-list [&lt;f&gt;]**</b>  
  List variables with help available and exit.

The list contains all variables for which help may be obtained by
using the **--help-variable** option followed by a variable name.
The help is printed to a named &lt;f&gt;ile if given.

* <b>**--help-variables [&lt;f&gt;]**</b>  
  Print cmake-variables manual and exit.

The **cmake-variables(7)** manual is printed in a
human-readable text format.
The help is printed to a named &lt;f&gt;ile if given.
.UNINDENT

<a name="see-also"></a>

# See Also


The following resources are available to get help using CMake:
.INDENT 0.0

* **Home Page**  
  _https://cmake.org_

The primary starting point for learning about CMake.

* **Online Documentation and Community Resources**  
  _https://cmake.org/documentation_

Links to available documentation and community resources may be
found on this web page.

* **Discourse Forum**  
  _https://discourse.cmake.org_

The Discourse Forum hosts discussion and questions about CMake.
.UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

