# cmake-commands(7) - CMake Language Command Reference

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

<a name="scripting-commands"></a>

# Scripting Commands


These commands are always available.

<a name="break"></a>

### break


Break from an enclosing foreach or while loop.
.INDENT 0.0
.INDENT 3.5

    .ft C
    break()
    .ft P
.UNINDENT
.UNINDENT

Breaks from an enclosing **foreach()** or **while()** loop.

See also the **continue()** command.

<a name="cmake_host_system_information"></a>

### cmake_host_system_information


Query host system specific information.
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_host_system_information(RESULT <variable> QUERY <key> ...)
    .ft P
.UNINDENT
.UNINDENT

Queries system information of the host system on which cmake runs.
One or more **&lt;key&gt;** can be provided to select the information to be
queried.  The list of queried values is stored in **&lt;variable&gt;**.

**&lt;key&gt;** can be one of the following values:
.TS
center;
|l|l|.
_
T{
Key
T}	T{
Description
T}
_
T{
**NUMBER\_OF\_LOGICAL\_CORES**
T}	T{
Number of logical cores
T}
_
T{
**NUMBER\_OF\_PHYSICAL\_CORES**
T}	T{
Number of physical cores
T}
_
T{
**HOSTNAME**
T}	T{
Hostname
T}
_
T{
**FQDN**
T}	T{
Fully qualified domain name
T}
_
T{
**TOTAL\_VIRTUAL\_MEMORY**
T}	T{
Total virtual memory in MiB [1]
T}
_
T{
**AVAILABLE\_VIRTUAL\_MEMORY**
T}	T{
Available virtual memory in MiB [1]
T}
_
T{
**TOTAL\_PHYSICAL\_MEMORY**
T}	T{
Total physical memory in MiB [1]
T}
_
T{
**AVAILABLE\_PHYSICAL\_MEMORY**
T}	T{
Available physical memory in MiB [1]
T}
_
T{
**IS\_64BIT**
T}	T{
One if processor is 64Bit
T}
_
T{
**HAS\_FPU**
T}	T{
One if processor has floating point unit
T}
_
T{
**HAS\_MMX**
T}	T{
One if processor supports MMX instructions
T}
_
T{
**HAS\_MMX\_PLUS**
T}	T{
One if processor supports Ext. MMX instructions
T}
_
T{
**HAS\_SSE**
T}	T{
One if processor supports SSE instructions
T}
_
T{
**HAS\_SSE2**
T}	T{
One if processor supports SSE2 instructions
T}
_
T{
**HAS\_SSE\_FP**
T}	T{
One if processor supports SSE FP instructions
T}
_
T{
**HAS\_SSE\_MMX**
T}	T{
One if processor supports SSE MMX instructions
T}
_
T{
**HAS\_AMD\_3DNOW**
T}	T{
One if processor supports 3DNow instructions
T}
_
T{
**HAS\_AMD\_3DNOW\_PLUS**
T}	T{
One if processor supports 3DNow+ instructions
T}
_
T{
**HAS\_IA64**
T}	T{
One if IA64 processor emulating x86
T}
_
T{
**HAS\_SERIAL\_NUMBER**
T}	T{
One if processor has serial number
T}
_
T{
**PROCESSOR\_SERIAL\_NUMBER**
T}	T{
Processor serial number
T}
_
T{
**PROCESSOR\_NAME**
T}	T{
Human readable processor name
T}
_
T{
**PROCESSOR\_DESCRIPTION**
T}	T{
Human readable full processor description
T}
_
T{
**OS\_NAME**
T}	T{
See **CMAKE\_HOST\_SYSTEM\_NAME**
T}
_
T{
**OS\_RELEASE**
T}	T{
The OS sub-type e.g. on Windows **Professional**
T}
_
T{
**OS\_VERSION**
T}	T{
The OS build ID
T}
_
T{
**OS\_PLATFORM**
T}	T{
See **CMAKE\_HOST\_SYSTEM\_PROCESSOR**
T}
_
.TE

<a name="footnotes"></a>

# Footnotes


* [1]  
  One MiB (mebibyte) is equal to 1024x1024 bytes.

<a name="cmake_minimum_required"></a>

### cmake_minimum_required


Require a minimum version of cmake.
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION <min>[...<max>] [FATAL_ERROR])
    .ft P
.UNINDENT
.UNINDENT

Sets the minimum required version of cmake for a project.
Also updates the policy settings as explained below.

**&lt;min&gt;** and the optional **&lt;max&gt;** are each CMake versions of the form
**major.minor[.patch[.tweak]]**, and the **...** is literal.

If the running version of CMake is lower than the **&lt;min&gt;** required
version it will stop processing the project and report an error.
The optional **&lt;max&gt;** version, if specified, must be at least the
**&lt;min&gt;** version and affects policy settings as described below.
If the running version of CMake is older than 3.12, the extra **...**
dots will be seen as version component separators, resulting in the
**...&lt;max&gt;** part being ignored and preserving the pre-3.12 behavior
of basing policies on **&lt;min&gt;**.

The **FATAL\_ERROR** option is accepted but ignored by CMake 2.6 and
higher.  It should be specified so CMake versions 2.4 and lower fail
with an error instead of just a warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Call the **cmake\_minimum\_required()** command at the beginning of
the top-level **CMakeLists.txt** file even before calling the
**project()** command.  It is important to establish version
and policy settings before invoking other commands whose behavior
they may affect.  See also policy **CMP0000**.

Calling **cmake\_minimum\_required()** inside a **function()**
limits some effects to the function scope when invoked.  Such calls
should not be made with the intention of having global effects.
.UNINDENT
.UNINDENT

<a name="policy-settings"></a>

### Policy Settings


The **cmake\_minimum\_required(VERSION)** command implicitly invokes the
**cmake\_policy(VERSION)** command to specify that the current
project code is written for the given range of CMake versions.
All policies known to the running version of CMake and introduced
in the **&lt;min&gt;** (or **&lt;max&gt;**, if specified) version or earlier will
be set to use **NEW** behavior.  All policies introduced in later
versions will be unset.  This effectively requests behavior preferred
as of a given CMake version and tells newer CMake versions to warn
about their new policies.

When a **&lt;min&gt;** version higher than 2.4 is specified the command
implicitly invokes
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_policy(VERSION <min>[...<max>])
    .ft P
.UNINDENT
.UNINDENT

which sets CMake policies based on the range of versions specified.
When a **&lt;min&gt;** version 2.4 or lower is given the command implicitly
invokes
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_policy(VERSION 2.4[...<max>])
    .ft P
.UNINDENT
.UNINDENT

which enables compatibility features for CMake 2.4 and lower.

<a name="cmake_parse_arguments"></a>

### cmake_parse_arguments


Parse function or macro arguments.
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_parse_arguments(<prefix> <options> <one_value_keywords>
                          <multi_value_keywords> <args>...)
    
    cmake_parse_arguments(PARSE_ARGV <N> <prefix> <options>
                          <one_value_keywords> <multi_value_keywords>)
    .ft P
.UNINDENT
.UNINDENT

This command is for use in macros or functions.
It processes the arguments given to that macro or function,
and defines a set of variables which hold the values of the
respective options.

The first signature reads processes arguments passed in the **&lt;args&gt;...**.
This may be used in either a **macro()** or a **function()**.

The **PARSE\_ARGV** signature is only for use in a **function()**
body.  In this case the arguments that are parsed come from the
**ARGV#** variables of the calling function.  The parsing starts with
the **&lt;N&gt;**-th argument, where **&lt;N&gt;** is an unsigned integer.  This allows for
the values to have special characters like **;** in them.

The **&lt;options&gt;** argument contains all options for the respective macro,
i.e.  keywords which can be used when calling the macro without any value
following, like e.g.  the **OPTIONAL** keyword of the **install()**
command.

The **&lt;one\_value\_keywords&gt;** argument contains all keywords for this macro
which are followed by one value, like e.g. **DESTINATION** keyword of the
**install()** command.

The **&lt;multi\_value\_keywords&gt;** argument contains all keywords for this
macro which can be followed by more than one value, like e.g. the
**TARGETS** or **FILES** keywords of the **install()** command.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
All keywords shall be unique. I.e. every keyword shall only be specified
once in either **&lt;options&gt;**, **&lt;one\_value\_keywords&gt;** or
**&lt;multi\_value\_keywords&gt;**. A warning will be emitted if uniqueness is
violated.
.UNINDENT
.UNINDENT

When done, **cmake\_parse\_arguments** will consider for each of the
keywords listed in **&lt;options&gt;**, **&lt;one\_value\_keywords&gt;** and
**&lt;multi\_value\_keywords&gt;** a variable composed of the given **&lt;prefix&gt;**
followed by **"\_"** and the name of the respective keyword.  These
variables will then hold the respective value from the argument list
or be undefined if the associated option could not be found.
For the **&lt;options&gt;** keywords, these will always be defined,
to **TRUE** or **FALSE**, whether the option is in the argument list or not.

All remaining arguments are collected in a variable
**&lt;prefix&gt;\_UNPARSED\_ARGUMENTS** that will be undefined if all arguments
were recognized. This can be checked afterwards to see
whether your macro was called with unrecognized parameters.

**&lt;one\_value\_keywords&gt;** and **&lt;multi\_value\_keywords&gt;** that were given no
values at all are collected in a variable **&lt;prefix&gt;\_KEYWORDS\_MISSING\_VALUES**
that will be undefined if all keywords received values. This can be checked
to see if there were keywords without any values given.

Consider the following example macro, **my\_install()**, which takes similar
arguments to the real **install()** command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    macro(my_install)
        set(options OPTIONAL FAST)
        set(oneValueArgs DESTINATION RENAME)
        set(multiValueArgs TARGETS CONFIGURATIONS)
        cmake_parse_arguments(MY_INSTALL "${options}" "${oneValueArgs}"
                              "${multiValueArgs}" ${ARGN} )
    
        # ...
    .ft P
.UNINDENT
.UNINDENT

Assume **my\_install()** has been called like this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    my_install(TARGETS foo bar DESTINATION bin OPTIONAL blub CONFIGURATIONS)
    .ft P
.UNINDENT
.UNINDENT

After the **cmake\_parse\_arguments** call the macro will have set or undefined
the following variables:
.INDENT 0.0
.INDENT 3.5

    .ft C
    MY_INSTALL_OPTIONAL = TRUE
    MY_INSTALL_FAST = FALSE # was not used in call to my_install
    MY_INSTALL_DESTINATION = "bin"
    MY_INSTALL_RENAME <UNDEFINED> # was not used
    MY_INSTALL_TARGETS = "foo;bar"
    MY_INSTALL_CONFIGURATIONS <UNDEFINED> # was not used
    MY_INSTALL_UNPARSED_ARGUMENTS = "blub" # nothing expected after "OPTIONAL"
    MY_INSTALL_KEYWORDS_MISSING_VALUES = "CONFIGURATIONS"
             # No value for "CONFIGURATIONS" given
    .ft P
.UNINDENT
.UNINDENT

You can then continue and process these variables.

Keywords terminate lists of values, e.g. if directly after a
**one\_value\_keyword** another recognized keyword follows, this is
interpreted as the beginning of the new option.  E.g.
**my_install(TARGETS foo DESTINATION OPTIONAL)** would result in
**MY\_INSTALL\_DESTINATION** set to **"OPTIONAL"**, but as **OPTIONAL**
is a keyword itself **MY\_INSTALL\_DESTINATION** will be empty (but added
to **MY\_INSTALL\_KEYWORDS\_MISSING\_VALUES**) and **MY\_INSTALL\_OPTIONAL** will
therefore be set to **TRUE**.

<a name="cmake_policy"></a>

### cmake_policy


Manage CMake Policy settings.  See the **cmake-policies(7)**
manual for defined policies.

As CMake evolves it is sometimes necessary to change existing behavior
in order to fix bugs or improve implementations of existing features.
The CMake Policy mechanism is designed to help keep existing projects
building as new versions of CMake introduce changes in behavior.  Each
new policy (behavioral change) is given an identifier of the form
**CMP&lt;NNNN&gt;** where **&lt;NNNN&gt;** is an integer index.  Documentation
associated with each policy describes the **OLD** and **NEW** behavior
and the reason the policy was introduced.  Projects may set each policy
to select the desired behavior.  When CMake needs to know which behavior
to use it checks for a setting specified by the project.  If no
setting is available the **OLD** behavior is assumed and a warning is
produced requesting that the policy be set.

<a name="setting-policies-by-cmake-version"></a>

### Setting Policies by CMake Version


The **cmake\_policy** command is used to set policies to **OLD** or **NEW**
behavior.  While setting policies individually is supported, we
encourage projects to set policies based on CMake versions:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_policy(VERSION <min>[...<max>])
    .ft P
.UNINDENT
.UNINDENT

**&lt;min&gt;** and the optional **&lt;max&gt;** are each CMake versions of the form
**major.minor[.patch[.tweak]]**, and the **...** is literal.  The **&lt;min&gt;**
version must be at least **2.4** and at most the running version of CMake.
The **&lt;max&gt;** version, if specified, must be at least the **&lt;min&gt;** version
but may exceed the running version of CMake.  If the running version of
CMake is older than 3.12, the extra **...** dots will be seen as version
component separators, resulting in the **...&lt;max&gt;** part being ignored and
preserving the pre-3.12 behavior of basing policies on **&lt;min&gt;**.

This specifies that the current CMake code is written for the given
range of CMake versions.  All policies known to the running version of CMake
and introduced in the **&lt;min&gt;** (or **&lt;max&gt;**, if specified) version
or earlier will be set to use **NEW** behavior.  All policies
introduced in later versions will be unset (unless the
**CMAKE\_POLICY\_DEFAULT\_CMP&lt;NNNN&gt;** variable sets a default).
This effectively requests behavior preferred as of a given CMake
version and tells newer CMake versions to warn about their new policies.

Note that the **cmake\_minimum\_required(VERSION)**
command implicitly calls **cmake\_policy(VERSION)** too.

<a name="setting-policies-explicitly"></a>

### Setting Policies Explicitly

.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_policy(SET CMP<NNNN> NEW)
    cmake_policy(SET CMP<NNNN> OLD)
    .ft P
.UNINDENT
.UNINDENT

Tell CMake to use the **OLD** or **NEW** behavior for a given policy.
Projects depending on the old behavior of a given policy may silence a
policy warning by setting the policy state to **OLD**.  Alternatively
one may fix the project to work with the new behavior and set the
policy state to **NEW**.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="checking-policy-settings"></a>

### Checking Policy Settings

.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_policy(GET CMP<NNNN> <variable>)
    .ft P
.UNINDENT
.UNINDENT

Check whether a given policy is set to **OLD** or **NEW** behavior.
The output **&lt;variable&gt;** value will be **OLD** or **NEW** if the
policy is set, and empty otherwise.

<a name="cmake-policy-stack"></a>

### CMake Policy Stack


CMake keeps policy settings on a stack, so changes made by the
**cmake\_policy** command affect only the top of the stack.  A new entry on
the policy stack is managed automatically for each subdirectory to
protect its parents and siblings.  CMake also manages a new entry for
scripts loaded by **include()** and **find\_package()** commands
except when invoked with the **NO\_POLICY\_SCOPE** option
(see also policy **CMP0011**).
The **cmake\_policy** command provides an interface to manage custom
entries on the policy stack:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_policy(PUSH)
    cmake_policy(POP)
    .ft P
.UNINDENT
.UNINDENT

Each **PUSH** must have a matching **POP** to erase any changes.
This is useful to make temporary changes to policy settings.
Calls to the **cmake\_minimum\_required(VERSION)**,
**cmake\_policy(VERSION)**, or **cmake\_policy(SET)** commands
influence only the current top of the policy stack.

Commands created by the **function()** and **macro()**
commands record policy settings when they are created and
use the pre-record policies when they are invoked.  If the function or
macro implementation sets policies, the changes automatically
propagate up through callers until they reach the closest nested
policy stack entry.

<a name="configure_file"></a>

### configure_file


Copy a file to another location and modify its contents.
.INDENT 0.0
.INDENT 3.5

    .ft C
    configure_file(<input> <output>
                   [COPYONLY] [ESCAPE_QUOTES] [@ONLY]
                   [NEWLINE_STYLE [UNIX|DOS|WIN32|LF|CRLF] ])
    .ft P
.UNINDENT
.UNINDENT

Copies an **&lt;input&gt;** file to an **&lt;output&gt;** file and substitutes
variable values referenced as **@VAR@** or **${VAR}** in the input
file content.  Each variable reference will be replaced with the
current value of the variable, or the empty string if the variable
is not defined.  Furthermore, input lines of the form
.INDENT 0.0
.INDENT 3.5

    .ft C
    #cmakedefine VAR ...
    .ft P
.UNINDENT
.UNINDENT

will be replaced with either
.INDENT 0.0
.INDENT 3.5

    .ft C
    #define VAR ...
    .ft P
.UNINDENT
.UNINDENT

or
.INDENT 0.0
.INDENT 3.5

    .ft C
    /* #undef VAR */
    .ft P
.UNINDENT
.UNINDENT

depending on whether **VAR** is set in CMake to any value not considered
a false constant by the **if()** command.  The “…” content on the
line after the variable name, if any, is processed as above.
Input file lines of the form **#cmakedefine01 VAR** will be replaced with
either **#define VAR 1** or **#define VAR 0** similarly.
The result lines (with the exception of the **#undef** comments) can be
indented using spaces and/or tabs between the **#** character
and the **cmakedefine** or **cmakedefine01** words. This whitespace
indentation will be preserved in the output lines:
.INDENT 0.0
.INDENT 3.5

    .ft C
    #  cmakedefine VAR
    #  cmakedefine01 VAR
    .ft P
.UNINDENT
.UNINDENT

will be replaced, if **VAR** is defined, with
.INDENT 0.0
.INDENT 3.5

    .ft C
    #  define VAR
    #  define VAR 1
    .ft P
.UNINDENT
.UNINDENT

If the input file is modified the build system will re-run CMake to
re-configure the file and generate the build system again.
The generated file is modified and its timestamp updated on subsequent
cmake runs only if its content is changed.

The arguments are:
.INDENT 0.0

* <b>**&lt;input&gt;**</b>  
  Path to the input file.  A relative path is treated with respect to
  the value of **CMAKE\_CURRENT\_SOURCE\_DIR**.  The input path
  must be a file, not a directory.
* <b>**&lt;output&gt;**</b>  
  Path to the output file or directory.  A relative path is treated
  with respect to the value of **CMAKE\_CURRENT\_BINARY\_DIR**.
  If the path names an existing directory the output file is placed
  in that directory with the same file name as the input file.
* <b>**COPYONLY**</b>  
  Copy the file without replacing any variable references or other
  content.  This option may not be used with **NEWLINE\_STYLE**.
* <b>**ESCAPE\_QUOTES**</b>  
  Escape any substituted quotes with backslashes (C-style).
* <b>**@ONLY**</b>  
  Restrict variable replacement to references of the form **@VAR@**.
  This is useful for configuring scripts that use **${VAR}** syntax.
* <b>**NEWLINE_STYLE &lt;style&gt;**</b>  
  Specify the newline style for the output file.  Specify
  **UNIX** or **LF** for **\en** newlines, or specify
  **DOS**, **WIN32**, or **CRLF** for **\er\en** newlines.
  This option may not be used with **COPYONLY**.
  .UNINDENT

<a name="example"></a>

### Example


Consider a source tree containing a **foo.h.in** file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    #cmakedefine FOO_ENABLE
    #cmakedefine FOO_STRING "@FOO_STRING@"
    .ft P
.UNINDENT
.UNINDENT

An adjacent **CMakeLists.txt** may use **configure\_file** to
configure the header:
.INDENT 0.0
.INDENT 3.5

    .ft C
    option(FOO_ENABLE "Enable Foo" ON)
    if(FOO_ENABLE)
      set(FOO_STRING "foo")
    endif()
    configure_file(foo.h.in foo.h @ONLY)
    .ft P
.UNINDENT
.UNINDENT

This creates a **foo.h** in the build directory corresponding to
this source directory.  If the **FOO\_ENABLE** option is on, the
configured file will contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    #define FOO_ENABLE
    #define FOO_STRING "foo"
    .ft P
.UNINDENT
.UNINDENT

Otherwise it will contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    /* #undef FOO_ENABLE */
    /* #undef FOO_STRING */
    .ft P
.UNINDENT
.UNINDENT

One may then use the **include\_directories()** command to
specify the output directory as an include directory:
.INDENT 0.0
.INDENT 3.5

    .ft C
    include_directories(${CMAKE_CURRENT_BINARY_DIR})
    .ft P
.UNINDENT
.UNINDENT

so that sources may include the header as **#include &lt;foo.h&gt;**.

<a name="continue"></a>

### continue


Continue to the top of enclosing foreach or while loop.
.INDENT 0.0
.INDENT 3.5

    .ft C
    continue()
    .ft P
.UNINDENT
.UNINDENT

The **continue** command allows a cmake script to abort the rest of a block
in a **foreach()** or **while()** loop, and start at the top of
the next iteration.

See also the **break()** command.

<a name="else"></a>

### else


Starts the else portion of an if block.
.INDENT 0.0
.INDENT 3.5

    .ft C
    else([<condition>])
    .ft P
.UNINDENT
.UNINDENT

See the **if()** command.

<a name="elseif"></a>

### elseif


Starts an elseif portion of an if block.
.INDENT 0.0
.INDENT 3.5

    .ft C
    elseif(<condition>)
    .ft P
.UNINDENT
.UNINDENT

See the **if()** command, especially for the syntax and logic
of the **&lt;condition&gt;**.

<a name="endforeach"></a>

### endforeach


Ends a list of commands in a foreach block.
.INDENT 0.0
.INDENT 3.5

    .ft C
    endforeach([<loop_var>])
    .ft P
.UNINDENT
.UNINDENT

See the **foreach()** command.

The optional **&lt;loop\_var&gt;** argument is supported for backward compatibility
only. If used it must be a verbatim repeat of the **&lt;loop\_var&gt;** argument of
the opening **foreach** clause.

<a name="endfunction"></a>

### endfunction


Ends a list of commands in a function block.
.INDENT 0.0
.INDENT 3.5

    .ft C
    endfunction([<name>])
    .ft P
.UNINDENT
.UNINDENT

See the **function()** command.

The optional **&lt;name&gt;** argument is supported for backward compatibility
only. If used it must be a verbatim repeat of the **&lt;name&gt;** argument
of the opening **function** command.

<a name="endif"></a>

### endif


Ends a list of commands in an if block.
.INDENT 0.0
.INDENT 3.5

    .ft C
    endif([<condition>])
    .ft P
.UNINDENT
.UNINDENT

See the **if()** command.

The optional **&lt;condition&gt;** argument is supported for backward compatibility
only. If used it must be a verbatim repeat of the argument of the opening
**if** clause.

<a name="endmacro"></a>

### endmacro


Ends a list of commands in a macro block.
.INDENT 0.0
.INDENT 3.5

    .ft C
    endmacro([<name>])
    .ft P
.UNINDENT
.UNINDENT

See the **macro()** command.

The optional **&lt;name&gt;** argument is supported for backward compatibility
only. If used it must be a verbatim repeat of the **&lt;name&gt;** argument
of the opening **macro** command.

<a name="endwhile"></a>

### endwhile


Ends a list of commands in a while block.
.INDENT 0.0
.INDENT 3.5

    .ft C
    endwhile([<condition>])
    .ft P
.UNINDENT
.UNINDENT

See the **while()** command.

The optional **&lt;condition&gt;** argument is supported for backward compatibility
only. If used it must be a verbatim repeat of the argument of the opening
**while** clause.

<a name="execute_process"></a>

### execute_process


Execute one or more child processes.
.INDENT 0.0
.INDENT 3.5

    .ft C
    execute_process(COMMAND <cmd1> [<arguments>]
                    [COMMAND <cmd2> [<arguments>]]...
                    [WORKING_DIRECTORY <directory>]
                    [TIMEOUT <seconds>]
                    [RESULT_VARIABLE <variable>]
                    [RESULTS_VARIABLE <variable>]
                    [OUTPUT_VARIABLE <variable>]
                    [ERROR_VARIABLE <variable>]
                    [INPUT_FILE <file>]
                    [OUTPUT_FILE <file>]
                    [ERROR_FILE <file>]
                    [OUTPUT_QUIET]
                    [ERROR_QUIET]
                    [COMMAND_ECHO <where>]
                    [OUTPUT_STRIP_TRAILING_WHITESPACE]
                    [ERROR_STRIP_TRAILING_WHITESPACE]
                    [ENCODING <name>])
    .ft P
.UNINDENT
.UNINDENT

Runs the given sequence of one or more commands.

Commands are executed concurrently as a pipeline, with the standard
output of each process piped to the standard input of the next.
A single standard error pipe is used for all processes.

Options:
.INDENT 0.0

* <b>**COMMAND**</b>  
  A child process command line.

CMake executes the child process using operating system APIs directly.
All arguments are passed VERBATIM to the child process.
No intermediate shell is used, so shell operators such as **&gt;**
are treated as normal arguments.
(Use the **INPUT\_***, **OUTPUT\_***, and **ERROR\_*** options to
redirect stdin, stdout, and stderr.)

If a sequential execution of multiple commands is required, use multiple
_execute\_process()_ calls with a single **COMMAND** argument.

* <b>**WORKING\_DIRECTORY**</b>  
  The named directory will be set as the current working directory of
  the child processes.
* <b>**TIMEOUT**</b>  
  After the specified number of seconds (fractions allowed), all unfinished
  child processes will be terminated, and the **RESULT\_VARIABLE** will be
  set to a string mentioning the “timeout”.
* <b>**RESULT\_VARIABLE**</b>  
  The variable will be set to contain the result of last child process.
  This will be an integer return code from the last child or a string
  describing an error condition.
* <b>**RESULTS_VARIABLE &lt;variable&gt;**</b>  
  The variable will be set to contain the result of all processes as a
  semicolon-separated list, in order of the
  given **COMMAND** arguments.  Each entry will be an integer return code
  from the corresponding child or a string describing an error condition.
* <b>**OUTPUT\_VARIABLE**, **ERROR\_VARIABLE**</b>  
  The variable named will be set with the contents of the standard output
  and standard error pipes, respectively.  If the same variable is named
  for both pipes their output will be merged in the order produced.
* <b>**INPUT_FILE, OUTPUT\_FILE**, **ERROR\_FILE**</b>  
  The file named will be attached to the standard input of the first
  process, standard output of the last process, or standard error of
  all processes, respectively.  If the same file is named for both
  output and error then it will be used for both.
* <b>**OUTPUT\_QUIET**, **ERROR\_QUIET**</b>  
  The standard output or standard error results will be quietly ignored.
* <b>**COMMAND_ECHO &lt;where&gt;**</b>  
  The command being run will be echo’ed to **&lt;where&gt;** with **&lt;where&gt;**
  being set to one of **STDERR**, **STDOUT** or **NONE**.
  See the **CMAKE\_EXECUTE\_PROCESS\_COMMAND\_ECHO** variable for a way
  to control the default behavior when this option is not present.
* <b>**ENCODING &lt;name&gt;**</b>  
  On Windows, the encoding that is used to decode output from the process.
  Ignored on other platforms.
  Valid encoding names are:
  .INDENT 7.0
* <b>**NONE**</b>  
  Perform no decoding.  This assumes that the process output is encoded
  in the same way as CMake’s internal encoding (UTF-8).
  This is the default.
* <b>**AUTO**</b>  
  Use the current active console’s codepage or if that isn’t
  available then use ANSI.
* <b>**ANSI**</b>  
  Use the ANSI codepage.
* <b>**OEM**</b>  
  Use the original equipment manufacturer (OEM) code page.
* <b>**UTF8** or **UTF-8**</b>  
  Use the UTF-8 codepage. Prior to CMake 3.11.0, only **UTF8** was accepted
  for this encoding. In CMake 3.11.0, **UTF-8** was added for consistency with
  the _UTF-8 RFC_ naming convention.
  .UNINDENT
  .UNINDENT

If more than one **OUTPUT\_*** or **ERROR\_*** option is given for the
same pipe the precedence is not specified.
If no **OUTPUT\_*** or **ERROR\_*** options are given the output will
be shared with the corresponding pipes of the CMake process itself.

The _execute\_process()_ command is a newer more powerful version of
**exec\_program()**, but the old command has been kept for compatibility.
Both commands run while CMake is processing the project prior to build
system generation.  Use **add\_custom\_target()** and
**add\_custom\_command()** to create custom commands that run at
build time.

<a name="file"></a>

### file


File manipulation command.

<a name="synopsis"></a>

### Synopsis

.INDENT 0.0
.INDENT 3.5

    .ft C
    Reading
      file(READ <filename> <out-var> [...])
      file(STRINGS <filename> <out-var> [...])
      file(<HASH> <filename> <out-var>)
      file(TIMESTAMP <filename> <out-var> [...])
      file(GET_RUNTIME_DEPENDENCIES [...])
    
    Writing
      file({WRITE | APPEND} <filename> <content>...)
      file({TOUCH | TOUCH_NOCREATE} [<file>...])
      file(GENERATE OUTPUT <output-file> [...])
    
    Filesystem
      file({GLOB | GLOB_RECURSE} <out-var> [...] [<globbing-expr>...])
      file(RENAME <oldname> <newname>)
      file({REMOVE | REMOVE_RECURSE } [<files>...])
      file(MAKE_DIRECTORY [<dir>...])
      file({COPY | INSTALL} <file>... DESTINATION <dir> [...])
      file(SIZE <filename> <out-var>)
      file(READ_SYMLINK <linkname> <out-var>)
      file(CREATE_LINK <original> <linkname> [...])
    
    Path Conversion
      file(RELATIVE_PATH <out-var> <directory> <file>)
      file({TO_CMAKE_PATH | TO_NATIVE_PATH} <path> <out-var>)
    
    Transfer
      file(DOWNLOAD <url> <file> [...])
      file(UPLOAD <file> <url> [...])
    
    Locking
      file(LOCK <path> [...])
    .ft P
.UNINDENT
.UNINDENT

<a name="reading"></a>

### Reading

.INDENT 0.0
.INDENT 3.5

    .ft C
    file(READ <filename> <variable>
         [OFFSET <offset>] [LIMIT <max-in>] [HEX])
    .ft P
.UNINDENT
.UNINDENT

Read content from a file called **&lt;filename&gt;** and store it in a
**&lt;variable&gt;**.  Optionally start from the given **&lt;offset&gt;** and
read at most **&lt;max-in&gt;** bytes.  The **HEX** option causes data to
be converted to a hexadecimal representation (useful for binary data).
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(STRINGS <filename> <variable> [<options>...])
    .ft P
.UNINDENT
.UNINDENT

Parse a list of ASCII strings from **&lt;filename&gt;** and store it in
**&lt;variable&gt;**.  Binary data in the file are ignored.  Carriage return
(**\er**, CR) characters are ignored.  The options are:
.INDENT 0.0

* <b>**LENGTH_MAXIMUM &lt;max-len&gt;**</b>  
  Consider only strings of at most a given length.
* <b>**LENGTH_MINIMUM &lt;min-len&gt;**</b>  
  Consider only strings of at least a given length.
* <b>**LIMIT_COUNT &lt;max-num&gt;**</b>  
  Limit the number of distinct strings to be extracted.
* <b>**LIMIT_INPUT &lt;max-in&gt;**</b>  
  Limit the number of input bytes to read from the file.
* <b>**LIMIT_OUTPUT &lt;max-out&gt;**</b>  
  Limit the number of total bytes to store in the **&lt;variable&gt;**.
* <b>**NEWLINE\_CONSUME**</b>  
  Treat newline characters (**\en**, LF) as part of string content
  instead of terminating at them.
* <b>**NO\_HEX\_CONVERSION**</b>  
  Intel Hex and Motorola S-record files are automatically converted to
  binary while reading unless this option is given.
* <b>**REGEX &lt;regex&gt;**</b>  
  Consider only strings that match the given regular expression.
* <b>**ENCODING &lt;encoding-type&gt;**</b>  
  Consider strings of a given encoding.  Currently supported encodings are:
  UTF-8, UTF-16LE, UTF-16BE, UTF-32LE, UTF-32BE.  If the ENCODING option
  is not provided and the file has a Byte Order Mark, the ENCODING option
  will be defaulted to respect the Byte Order Mark.
  .UNINDENT

For example, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(STRINGS myfile.txt myfile)
    .ft P
.UNINDENT
.UNINDENT

stores a list in the variable **myfile** in which each item is a line
from the input file.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(<HASH> <filename> <variable>)
    .ft P
.UNINDENT
.UNINDENT

Compute a cryptographic hash of the content of **&lt;filename&gt;** and
store it in a **&lt;variable&gt;**.  The supported **&lt;HASH&gt;** algorithm names
are those listed by the string(&lt;HASH&gt;)
command.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(TIMESTAMP <filename> <variable> [<format>] [UTC])
    .ft P
.UNINDENT
.UNINDENT

Compute a string representation of the modification time of **&lt;filename&gt;**
and store it in **&lt;variable&gt;**.  Should the command be unable to obtain a
timestamp variable will be set to the empty string (“”).

See the **string(TIMESTAMP)** command for documentation of
the **&lt;format&gt;** and **UTC** options.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(GET_RUNTIME_DEPENDENCIES
      [RESOLVED_DEPENDENCIES_VAR <deps_var>]
      [UNRESOLVED_DEPENDENCIES_VAR <unresolved_deps_var>]
      [CONFLICTING_DEPENDENCIES_PREFIX <conflicting_deps_prefix>]
      [EXECUTABLES [<executable_files>...]]
      [LIBRARIES [<library_files>...]]
      [MODULES [<module_files>...]]
      [DIRECTORIES [<directories>...]]
      [BUNDLE_EXECUTABLE <bundle_executable_file>]
      [PRE_INCLUDE_REGEXES [<regexes>...]]
      [PRE_EXCLUDE_REGEXES [<regexes>...]]
      [POST_INCLUDE_REGEXES [<regexes>...]]
      [POST_EXCLUDE_REGEXES [<regexes>...]]
      )
    .ft P
.UNINDENT
.UNINDENT

Recursively get the list of libraries depended on by the given files.

Please note that this sub-command is not intended to be used in project mode.
Instead, use it in an **install(CODE)** or **install(SCRIPT)**
block. For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    install(CODE [[
      file(GET_RUNTIME_DEPENDENCIES
        # ...
        )
      ]])
    .ft P
.UNINDENT
.UNINDENT

The arguments are as follows:
.INDENT 0.0

* <b>**RESOLVED_DEPENDENCIES_VAR &lt;deps\_var&gt;**</b>  
  Name of the variable in which to store the list of resolved dependencies.
* <b>**UNRESOLVED_DEPENDENCIES_VAR &lt;unresolved\_deps\_var&gt;**</b>  
  Name of the variable in which to store the list of unresolved dependencies.
  If this variable is not specified, and there are any unresolved dependencies,
  an error is issued.
* <b>**CONFLICTING_DEPENDENCIES_PREFIX &lt;conflicting\_deps\_prefix&gt;**</b>  
  Variable prefix in which to store conflicting dependency information.
  Dependencies are conflicting if two files with the same name are found in
  two different directories. The list of filenames that conflict are stored in
  **&lt;conflicting\_deps\_prefix&gt;\_FILENAMES**. For each filename, the list of paths
  that were found for that filename are stored in
  **&lt;conflicting\_deps\_prefix&gt;\_&lt;filename&gt;**.
* <b>**EXECUTABLES &lt;executable\_files&gt;**</b>  
  List of executable files to read for dependencies. These are executables that
  are typically created with **add\_executable()**, but they do not have to
  be created by CMake. On Apple platforms, the paths to these files determine
  the value of **@executable\_path** when recursively resolving the libraries.
  Specifying any kind of library (**STATIC**, **MODULE**, or **SHARED**) here
  will result in undefined behavior.
* <b>**LIBRARIES &lt;library\_files&gt;**</b>  
  List of library files to read for dependencies. These are libraries that are
  typically created with **add\_library(SHARED)**, but they do not have
  to be created by CMake. Specifying **STATIC** libraries, **MODULE**
  libraries, or executables here will result in undefined behavior.
* <b>**MODULES &lt;module\_files&gt;**</b>  
  List of loadable module files to read for dependencies. These are modules
  that are typically created with **add\_library(MODULE)**, but they do
  not have to be created by CMake. They are typically used by calling
  **dlopen()** at runtime rather than linked at link time with **ld -l**.
  Specifying **STATIC** libraries, **SHARED** libraries, or executables here
  will result in undefined behavior.
* <b>**DIRECTORIES &lt;directories&gt;**</b>  
  List of additional directories to search for dependencies. On Linux
  platforms, these directories are searched if the dependency is not found in
  any of the other usual paths. If it is found in such a directory, a warning
  is issued, because it means that the file is incomplete (it does not list all
  of the directories that contain its dependencies). On Windows platforms,
  these directories are searched if the dependency is not found in any of the
  other search paths, but no warning is issued, because searching other paths
  is a normal part of Windows dependency resolution. On Apple platforms, this
  argument has no effect.
* <b>**BUNDLE_EXECUTABLE &lt;bundle\_executable\_file&gt;**</b>  
  Executable to treat as the “bundle executable” when resolving libraries. On
  Apple platforms, this argument determines the value of **@executable\_path**
  when recursively resolving libraries for **LIBRARIES** and **MODULES** files.
  It has no effect on **EXECUTABLES** files. On other platforms, it has no
  effect. This is typically (but not always) one of the executables in the
  **EXECUTABLES** argument which designates the “main” executable of the
  package.
  .UNINDENT

The following arguments specify filters for including or excluding libraries to
be resolved. See below for a full description of how they work.
.INDENT 0.0

* <b>**PRE_INCLUDE_REGEXES &lt;regexes&gt;**</b>  
  List of pre-include regexes through which to filter the names of
  not-yet-resolved dependencies.
* <b>**PRE_EXCLUDE_REGEXES &lt;regexes&gt;**</b>  
  List of pre-exclude regexes through which to filter the names of
  not-yet-resolved dependencies.
* <b>**POST_INCLUDE_REGEXES &lt;regexes&gt;**</b>  
  List of post-include regexes through which to filter the names of resolved
  dependencies.
* <b>**POST_EXCLUDE_REGEXES &lt;regexes&gt;**</b>  
  List of post-exclude regexes through which to filter the names of resolved
  dependencies.
  .UNINDENT

These arguments can be used to blacklist unwanted system libraries when
resolving the dependencies, or to whitelist libraries from a specific
directory. The filtering works as follows:
.INDENT 0.0

* 1.  
  If the not-yet-resolved dependency matches any of the
  **PRE\_INCLUDE\_REGEXES**, steps 2 and 3 are skipped, and the dependency
  resolution proceeds to step 4.
* 2.  
  If the not-yet-resolved dependency matches any of the
  **PRE\_EXCLUDE\_REGEXES**, dependency resolution stops for that dependency.
* 3.  
  Otherwise, dependency resolution proceeds.
* 4.  
  **file(GET\_RUNTIME\_DEPENDENCIES)** searches for the dependency according to
  the linking rules of the platform (see below).
* 5.  
  If the dependency is found, and its full path matches one of the
  **POST\_INCLUDE\_REGEXES**, the full path is added to the resolved
  dependencies, and **file(GET\_RUNTIME\_DEPENDENCIES)** recursively resolves
  that library’s own dependencies. Otherwise, resolution proceeds to step 6.
* 6.  
  If the dependency is found, but its full path matches one of the
  **POST\_EXCLUDE\_REGEXES**, it is not added to the resolved dependencies, and
  dependency resolution stops for that dependency.
* 7.  
  If the dependency is found, and its full path does not match either
  **POST\_INCLUDE\_REGEXES** or **POST\_EXCLUDE\_REGEXES**, the full path is added
  to the resolved dependencies, and **file(GET\_RUNTIME\_DEPENDENCIES)**
  recursively resolves that library’s own dependencies.
  .UNINDENT

Different platforms have different rules for how dependencies are resolved.
These specifics are described here.

On Linux platforms, library resolution works as follows:
.INDENT 0.0

* 1.  
  If the depending file does not have any **RUNPATH** entries, and the library
  exists in one of the depending file’s **RPATH** entries, or its parents’, in
  that order, the dependency is resolved to that file.
* 2.  
  Otherwise, if the depending file has any **RUNPATH** entries, and the
  library exists in one of those entries, the dependency is resolved to that
  file.
* 3.  
  Otherwise, if the library exists in one of the directories listed by
  **ldconfig**, the dependency is resolved to that file.
* 4.  
  Otherwise, if the library exists in one of the **DIRECTORIES** entries, the
  dependency is resolved to that file. In this case, a warning is issued,
  because finding a file in one of the **DIRECTORIES** means that the
  depending file is not complete (it does not list all the directories from
  which it pulls dependencies).
* 5.  
  Otherwise, the dependency is unresolved.
  .UNINDENT

On Windows platforms, library resolution works as follows:
.INDENT 0.0

* 1.  
  The dependent DLL name is converted to lowercase. Windows DLL names are
  case-insensitive, and some linkers mangle the case of the DLL dependency
  names. However, this makes it more difficult for **PRE\_INCLUDE\_REGEXES**,
  **PRE\_EXCLUDE\_REGEXES**, **POST\_INCLUDE\_REGEXES**, and
  **POST\_EXCLUDE\_REGEXES** to properly filter DLL names - every regex would
  have to check for both uppercase and lowercase letters. For example:
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    file(GET_RUNTIME_DEPENDENCIES
      # ...
      PRE_INCLUDE_REGEXES "^[Mm][Yy][Ll][Ii][Bb][Rr][Aa][Rr][Yy]ee.[Dd][Ll][Ll]$"
      )
    .ft P
.UNINDENT
.UNINDENT

Converting the DLL name to lowercase allows the regexes to only match
lowercase names, thus simplifying the regex. For example:
.INDENT 3.0
.INDENT 3.5

    .ft C
    file(GET_RUNTIME_DEPENDENCIES
      # ...
      PRE_INCLUDE_REGEXES "^mylibraryee.dll$"
      )
    .ft P
.UNINDENT
.UNINDENT

This regex will match **mylibrary.dll** regardless of how it is cased,
either on disk or in the depending file. (For example, it will match
**mylibrary.dll**, **MyLibrary.dll**, and **MYLIBRARY.DLL**.)

Please note that the directory portion of any resolved DLLs retains its
casing and is not converted to lowercase. Only the filename portion is
converted.

* 2.  
  (**Not yet implemented**) If the depending file is a Windows Store app, and
  the dependency is listed as a dependency in the application’s package
  manifest, the dependency is resolved to that file.
* 3.  
  Otherwise, if the library exists in the same directory as the depending
  file, the dependency is resolved to that file.
* 4.  
  Otherwise, if the library exists in either the operating system’s
  **system32** directory or the **Windows** directory, in that order, the
  dependency is resolved to that file.
* 5.  
  Otherwise, if the library exists in one of the directories specified by
  **DIRECTORIES**, in the order they are listed, the dependency is resolved to
  that file. In this case, a warning is not issued, because searching other
  directories is a normal part of Windows library resolution.
* 6.  
  Otherwise, the dependency is unresolved.
  .UNINDENT

On Apple platforms, library resolution works as follows:
.INDENT 0.0

* 1.  
  If the dependency starts with **@executable\_path/**, and an **EXECUTABLES**
  argument is in the process of being resolved, and replacing
  **@executable\_path/** with the directory of the executable yields an
  existing file, the dependency is resolved to that file.
* 2.  
  Otherwise, if the dependency starts with **@executable\_path/**, and there is
  a **BUNDLE\_EXECUTABLE** argument, and replacing **@executable\_path/** with
  the directory of the bundle executable yields an existing file, the
  dependency is resolved to that file.
* 3.  
  Otherwise, if the dependency starts with **@loader\_path/**, and replacing
  **@loader\_path/** with the directory of the depending file yields an
  existing file, the dependency is resolved to that file.
* 4.  
  Otherwise, if the dependency starts with **@rpath/**, and replacing
  **@rpath/** with one of the **RPATH** entries of the depending file yields
  an existing file, the dependency is resolved to that file. Note that
  **RPATH** entries that start with **@executable\_path/** or **@loader\_path/**
  also have these items replaced with the appropriate path.
* 5.  
  Otherwise, if the dependency is an absolute file that exists, the dependency
  is resolved to that file.
* 6.  
  Otherwise, the dependency is unresolved.
  .UNINDENT

This function accepts several variables that determine which tool is used for
dependency resolution:
.INDENT 0.0

* **CMAKE_GET_RUNTIME_DEPENDENCIES_PLATFORM**  
  Determines which operating system and executable format the files are built
  for. This could be one of several values:
  .INDENT 7.0
* ·  
  **linux+elf**
* ·  
  **windows+pe**
* ·  
  **macos+macho**
  .UNINDENT

If this variable is not specified, it is determined automatically by system
introspection.
.UNINDENT
.INDENT 0.0

* **CMAKE_GET_RUNTIME_DEPENDENCIES_TOOL**  
  Determines the tool to use for dependency resolution. It could be one of
  several values, depending on the value of
  _CMAKE\_GET\_RUNTIME\_DEPENDENCIES\_PLATFORM_:
  .TS
  center;
  |l|l|.
  _
  T{
  **CMAKE\_GET\_RUNTIME\_DEPENDENCIES\_PLATFORM**
  T}	T{
  **CMAKE\_GET\_RUNTIME\_DEPENDENCIES\_TOOL**
  T}
  _
  T{
  **linux+elf**
  T}	T{
  **objdump**
  T}
  _
  T{
  **windows+pe**
  T}	T{
  **dumpbin**
  T}
  _
  T{
  **windows+pe**
  T}	T{
  **objdump**
  T}
  _
  T{
  **macos+macho**
  T}	T{
  **otool**
  T}
  _
  .TE

If this variable is not specified, it is determined automatically by system
introspection.
.UNINDENT
.INDENT 0.0

* **CMAKE_GET_RUNTIME_DEPENDENCIES_COMMAND**  
  Determines the path to the tool to use for dependency resolution. This is the
  actual path to **objdump**, **dumpbin**, or **otool**.

If this variable is not specified, it is determined automatically by system
introspection.
.UNINDENT

<a name="writing"></a>

### Writing

.INDENT 0.0
.INDENT 3.5

    .ft C
    file(WRITE <filename> <content>...)
    file(APPEND <filename> <content>...)
    .ft P
.UNINDENT
.UNINDENT

Write **&lt;content&gt;** into a file called **&lt;filename&gt;**.  If the file does
not exist, it will be created.  If the file already exists, **WRITE**
mode will overwrite it and **APPEND** mode will append to the end.
Any directories in the path specified by **&lt;filename&gt;** that do not
exist will be created.

If the file is a build input, use the **configure\_file()** command
to update the file only when its content changes.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(TOUCH [<files>...])
    file(TOUCH_NOCREATE [<files>...])
    .ft P
.UNINDENT
.UNINDENT

Create a file with no content if it does not yet exist. If the file already
exists, its access and/or modification will be updated to the time when the
function call is executed.

Use TOUCH_NOCREATE to touch a file if it exists but not create it. If a file
does not exist it will be silently ignored.

With TOUCH and TOUCH_NOCREATE the contents of an existing file will not be
modified.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(GENERATE OUTPUT output-file
         <INPUT input-file|CONTENT content>
         [CONDITION expression])
    .ft P
.UNINDENT
.UNINDENT

Generate an output file for each build configuration supported by the current
**CMake Generator**.  Evaluate
**generator expressions**
from the input content to produce the output content.  The options are:
.INDENT 0.0

* <b>**CONDITION &lt;condition&gt;**</b>  
  Generate the output file for a particular configuration only if
  the condition is true.  The condition must be either **0** or **1**
  after evaluating generator expressions.
* <b>**CONTENT &lt;content&gt;**</b>  
  Use the content given explicitly as input.
* <b>**INPUT &lt;input-file&gt;**</b>  
  Use the content from a given file as input.
  A relative path is treated with respect to the value of
  **CMAKE\_CURRENT\_SOURCE\_DIR**.  See policy **CMP0070**.
* <b>**OUTPUT &lt;output-file&gt;**</b>  
  Specify the output file name to generate.  Use generator expressions
  such as **$&lt;CONFIG&gt;** to specify a configuration-specific output file
  name.  Multiple configurations may generate the same output file only
  if the generated content is identical.  Otherwise, the **&lt;output-file&gt;**
  must evaluate to an unique name for each configuration.
  A relative path (after evaluating generator expressions) is treated
  with respect to the value of **CMAKE\_CURRENT\_BINARY\_DIR**.
  See policy **CMP0070**.
  .UNINDENT

Exactly one **CONTENT** or **INPUT** option must be given.  A specific
**OUTPUT** file may be named by at most one invocation of **file(GENERATE)**.
Generated files are modified and their timestamp updated on subsequent cmake
runs only if their content is changed.

Note also that **file(GENERATE)** does not create the output file until the
generation phase. The output file will not yet have been written when the
**file(GENERATE)** command returns, it is written only after processing all
of a project’s **CMakeLists.txt** files.

<a name="filesystem"></a>

### Filesystem

.INDENT 0.0
.INDENT 3.5

    .ft C
    file(GLOB <variable>
         [LIST_DIRECTORIES true|false] [RELATIVE <path>] [CONFIGURE_DEPENDS]
         [<globbing-expressions>...])
    file(GLOB_RECURSE <variable> [FOLLOW_SYMLINKS]
         [LIST_DIRECTORIES true|false] [RELATIVE <path>] [CONFIGURE_DEPENDS]
         [<globbing-expressions>...])
    .ft P
.UNINDENT
.UNINDENT

Generate a list of files that match the **&lt;globbing-expressions&gt;** and
store it into the **&lt;variable&gt;**.  Globbing expressions are similar to
regular expressions, but much simpler.  If **RELATIVE** flag is
specified, the results will be returned as relative paths to the given
path.  The results will be ordered lexicographically.

On Windows and macOS, globbing is case-insensitive even if the underlying
filesystem is case-sensitive (both filenames and globbing expressions are
converted to lowercase before matching).  On other platforms, globbing is
case-sensitive.

If the **CONFIGURE\_DEPENDS** flag is specified, CMake will add logic
to the main build system check target to rerun the flagged **GLOB** commands
at build time. If any of the outputs change, CMake will regenerate the build
system.

By default **GLOB** lists directories - directories are omitted in result if
**LIST\_DIRECTORIES** is set to false.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
We do not recommend using GLOB to collect a list of source files from
your source tree.  If no CMakeLists.txt file changes when a source is
added or removed then the generated build system cannot know when to
ask CMake to regenerate.
The **CONFIGURE\_DEPENDS** flag may not work reliably on all generators, or if
a new generator is added in the future that cannot support it, projects using
it will be stuck. Even if **CONFIGURE\_DEPENDS** works reliably, there is
still a cost to perform the check on every rebuild.
.UNINDENT
.UNINDENT

Examples of globbing expressions include:
.INDENT 0.0
.INDENT 3.5

    .ft C
    *.cxx      - match all files with extension cxx
    *.vt?      - match all files with extension vta,...,vtz
    f[3-5].txt - match files f3.txt, f4.txt, f5.txt
    .ft P
.UNINDENT
.UNINDENT

The **GLOB\_RECURSE** mode will traverse all the subdirectories of the
matched directory and match the files.  Subdirectories that are symlinks
are only traversed if **FOLLOW\_SYMLINKS** is given or policy
**CMP0009** is not set to **NEW**.

By default **GLOB\_RECURSE** omits directories from result list - setting
**LIST\_DIRECTORIES** to true adds directories to result list.
If **FOLLOW\_SYMLINKS** is given or policy **CMP0009** is not set to
**NEW** then **LIST\_DIRECTORIES** treats symlinks as directories.

Examples of recursive globbing include:
.INDENT 0.0
.INDENT 3.5

    .ft C
    /dir/*.py  - match all python files in /dir and subdirectories
    .ft P
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(RENAME <oldname> <newname>)
    .ft P
.UNINDENT
.UNINDENT

Move a file or directory within a filesystem from **&lt;oldname&gt;** to
**&lt;newname&gt;**, replacing the destination atomically.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(REMOVE [<files>...])
    file(REMOVE_RECURSE [<files>...])
    .ft P
.UNINDENT
.UNINDENT

Remove the given files.  The **REMOVE\_RECURSE** mode will remove the given
files and directories, also non-empty directories. No error is emitted if a
given file does not exist.  Relative input paths are evaluated with respect
to the current source directory.  Empty input paths are ignored with a warning.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(MAKE_DIRECTORY [<directories>...])
    .ft P
.UNINDENT
.UNINDENT

Create the given directories and their parents as needed.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(<COPY|INSTALL> <files>... DESTINATION <dir>
         [FILE_PERMISSIONS <permissions>...]
         [DIRECTORY_PERMISSIONS <permissions>...]
         [NO_SOURCE_PERMISSIONS] [USE_SOURCE_PERMISSIONS]
         [FOLLOW_SYMLINK_CHAIN]
         [FILES_MATCHING]
         [[PATTERN <pattern> | REGEX <regex>]
          [EXCLUDE] [PERMISSIONS <permissions>...]] [...])
    .ft P
.UNINDENT
.UNINDENT

The **COPY** signature copies files, directories, and symlinks to a
destination folder.  Relative input paths are evaluated with respect
to the current source directory, and a relative destination is
evaluated with respect to the current build directory.  Copying
preserves input file timestamps, and optimizes out a file if it exists
at the destination with the same timestamp.  Copying preserves input
permissions unless explicit permissions or **NO\_SOURCE\_PERMISSIONS**
are given (default is **USE\_SOURCE\_PERMISSIONS**).

If **FOLLOW\_SYMLINK\_CHAIN** is specified, **COPY** will recursively resolve
the symlinks at the paths given until a real file is found, and install
a corresponding symlink in the destination for each symlink encountered. For
each symlink that is installed, the resolution is stripped of the directory,
leaving only the filename, meaning that the new symlink points to a file in
the same directory as the symlink. This feature is useful on some Unix systems,
where libraries are installed as a chain of symlinks with version numbers, with
less specific versions pointing to more specific versions.
**FOLLOW\_SYMLINK\_CHAIN** will install all of these symlinks and the library
itself into the destination directory. For example, if you have the following
directory structure:
.INDENT 0.0

* ·  
  **/opt/foo/lib/libfoo.so.1.2.3**
* ·  
  **/opt/foo/lib/libfoo.so.1.2 -&gt; libfoo.so.1.2.3**
* ·  
  **/opt/foo/lib/libfoo.so.1 -&gt; libfoo.so.1.2**
* ·  
  **/opt/foo/lib/libfoo.so -&gt; libfoo.so.1**
  .UNINDENT

and you do:
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(COPY /opt/foo/lib/libfoo.so DESTINATION lib FOLLOW_SYMLINK_CHAIN)
    .ft P
.UNINDENT
.UNINDENT

This will install all of the symlinks and **libfoo.so.1.2.3** itself into
**lib**.

See the **install(DIRECTORY)** command for documentation of
permissions, **FILES\_MATCHING**, **PATTERN**, **REGEX**, and
**EXCLUDE** options.  Copying directories preserves the structure
of their content even if options are used to select a subset of
files.

The **INSTALL** signature differs slightly from **COPY**: it prints
status messages (subject to the **CMAKE\_INSTALL\_MESSAGE** variable),
and **NO\_SOURCE\_PERMISSIONS** is default.
Installation scripts generated by the **install()** command
use this signature (with some undocumented options for internal use).
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(SIZE <filename> <variable>)
    .ft P
.UNINDENT
.UNINDENT

Determine the file size of the **&lt;filename&gt;** and put the result in
**&lt;variable&gt;** variable. Requires that **&lt;filename&gt;** is a valid path
pointing to a file and is readable.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(READ_SYMLINK <linkname> <variable>)
    .ft P
.UNINDENT
.UNINDENT

This subcommand queries the symlink **&lt;linkname&gt;** and stores the path it
points to in the result **&lt;variable&gt;**.  If **&lt;linkname&gt;** does not exist or
is not a symlink, CMake issues a fatal error.

Note that this command returns the raw symlink path and does not resolve
a relative path.  The following is an example of how to ensure that an
absolute path is obtained:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(linkname "/path/to/foo.sym")
    file(READ_SYMLINK "${linkname}" result)
    if(NOT IS_ABSOLUTE "${result}")
      get_filename_component(dir "${linkname}" DIRECTORY)
      set(result "${dir}/${result}")
    endif()
    .ft P
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(CREATE_LINK <original> <linkname>
         [RESULT <result>] [COPY_ON_ERROR] [SYMBOLIC])
    .ft P
.UNINDENT
.UNINDENT

Create a link **&lt;linkname&gt;** that points to **&lt;original&gt;**.
It will be a hard link by default, but providing the **SYMBOLIC** option
results in a symbolic link instead.  Hard links require that **original**
exists and is a file, not a directory.  If **&lt;linkname&gt;** already exists,
it will be overwritten.

The **&lt;result&gt;** variable, if specified, receives the status of the operation.
It is set to **0** upon success or an error message otherwise.  If **RESULT**
is not specified and the operation fails, a fatal error is emitted.

Specifying **COPY\_ON\_ERROR** enables copying the file as a fallback if
creating the link fails.  It can be useful for handling situations such as
**&lt;original&gt;** and **&lt;linkname&gt;** being on different drives or mount points,
which would make them unable to support a hard link.

<a name="path-conversion"></a>

### Path Conversion

.INDENT 0.0
.INDENT 3.5

    .ft C
    file(RELATIVE_PATH <variable> <directory> <file>)
    .ft P
.UNINDENT
.UNINDENT

Compute the relative path from a **&lt;directory&gt;** to a **&lt;file&gt;** and
store it in the **&lt;variable&gt;**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(TO_CMAKE_PATH "<path>" <variable>)
    file(TO_NATIVE_PATH "<path>" <variable>)
    .ft P
.UNINDENT
.UNINDENT

The **TO\_CMAKE\_PATH** mode converts a native **&lt;path&gt;** into a cmake-style
path with forward-slashes (**/**).  The input can be a single path or a
system search path like **$ENV{PATH}**.  A search path will be converted
to a cmake-style list separated by **;** characters.

The **TO\_NATIVE\_PATH** mode converts a cmake-style **&lt;path&gt;** into a native
path with platform-specific slashes (**\e** on Windows and **/** elsewhere).

Always use double quotes around the **&lt;path&gt;** to be sure it is treated
as a single argument to this command.

<a name="transfer"></a>

### Transfer

.INDENT 0.0
.INDENT 3.5

    .ft C
    file(DOWNLOAD <url> <file> [<options>...])
    file(UPLOAD   <file> <url> [<options>...])
    .ft P
.UNINDENT
.UNINDENT

The **DOWNLOAD** mode downloads the given **&lt;url&gt;** to a local **&lt;file&gt;**.
The **UPLOAD** mode uploads a local **&lt;file&gt;** to a given **&lt;url&gt;**.

Options to both **DOWNLOAD** and **UPLOAD** are:
.INDENT 0.0

* <b>**INACTIVITY_TIMEOUT &lt;seconds&gt;**</b>  
  Terminate the operation after a period of inactivity.
* <b>**LOG &lt;variable&gt;**</b>  
  Store a human-readable log of the operation in a variable.
* <b>**SHOW\_PROGRESS**</b>  
  Print progress information as status messages until the operation is
  complete.
* <b>**STATUS &lt;variable&gt;**</b>  
  Store the resulting status of the operation in a variable.
  The status is a **;** separated list of length 2.
  The first element is the numeric return value for the operation,
  and the second element is a string value for the error.
  A **0** numeric error means no error in the operation.
* <b>**TIMEOUT &lt;seconds&gt;**</b>  
  Terminate the operation after a given total time has elapsed.
* <b>**USERPWD &lt;username&gt;:&lt;password&gt;**</b>  
  Set username and password for operation.
* <b>**HTTPHEADER &lt;HTTP-header&gt;**</b>  
  HTTP header for operation. Suboption can be repeated several times.
* <b>**NETRC &lt;level&gt;**</b>  
  Specify whether the .netrc file is to be used for operation.  If this
  option is not specified, the value of the **CMAKE\_NETRC** variable
  will be used instead.
  Valid levels are:
  .INDENT 7.0
* <b>**IGNORED**</b>  
  The .netrc file is ignored.
  This is the default.
* <b>**OPTIONAL**</b>  
  The .netrc file is optional, and information in the URL is preferred.
  The file will be scanned to find which ever information is not specified
  in the URL.
* <b>**REQUIRED**</b>  
  The .netrc file is required, and information in the URL is ignored.
  .UNINDENT
* <b>**NETRC_FILE &lt;file&gt;**</b>  
  Specify an alternative .netrc file to the one in your home directory,
  if the **NETRC** level is **OPTIONAL** or **REQUIRED**. If this option
  is not specified, the value of the **CMAKE\_NETRC\_FILE** variable will
  be used instead.
  .UNINDENT

If neither **NETRC** option is given CMake will check variables
**CMAKE\_NETRC** and **CMAKE\_NETRC\_FILE**, respectively.

Additional options to **DOWNLOAD** are:

**EXPECTED_HASH ALGO=&lt;value&gt;**
.INDENT 0.0
.INDENT 3.5
Verify that the downloaded content hash matches the expected value, where
**ALGO** is one of the algorithms supported by **file(&lt;HASH&gt;)**.
If it does not match, the operation fails with an error.
.UNINDENT
.UNINDENT
.INDENT 0.0

* <b>**EXPECTED_MD5 &lt;value&gt;**</b>  
  Historical short-hand for **EXPECTED_HASH MD5=&lt;value&gt;**.
* <b>**TLS_VERIFY &lt;ON|OFF&gt;**</b>  
  Specify whether to verify the server certificate for **https://** URLs.
  The default is to _not_ verify.
* <b>**TLS_CAINFO &lt;file&gt;**</b>  
  Specify a custom Certificate Authority file for **https://** URLs.
  .UNINDENT

For **https://** URLs CMake must be built with OpenSSL support.  **TLS/SSL**
certificates are not checked by default.  Set **TLS\_VERIFY** to **ON** to
check certificates and/or use **EXPECTED\_HASH** to verify downloaded content.
If neither **TLS** option is given CMake will check variables
**CMAKE\_TLS\_VERIFY** and **CMAKE\_TLS\_CAINFO**, respectively.

<a name="locking"></a>

### Locking

.INDENT 0.0
.INDENT 3.5

    .ft C
    file(LOCK <path> [DIRECTORY] [RELEASE]
         [GUARD <FUNCTION|FILE|PROCESS>]
         [RESULT_VARIABLE <variable>]
         [TIMEOUT <seconds>])
    .ft P
.UNINDENT
.UNINDENT

Lock a file specified by **&lt;path&gt;** if no **DIRECTORY** option present and file
**&lt;path&gt;/cmake.lock** otherwise. File will be locked for scope defined by
**GUARD** option (default value is **PROCESS**). **RELEASE** option can be used
to unlock file explicitly. If option **TIMEOUT** is not specified CMake will
wait until lock succeed or until fatal error occurs. If **TIMEOUT** is set to
**0** lock will be tried once and result will be reported immediately. If
**TIMEOUT** is not **0** CMake will try to lock file for the period specified
by **&lt;seconds&gt;** value. Any errors will be interpreted as fatal if there is no
**RESULT\_VARIABLE** option. Otherwise result will be stored in **&lt;variable&gt;**
and will be **0** on success or error message on failure.

Note that lock is advisory - there is no guarantee that other processes will
respect this lock, i.e. lock synchronize two or more CMake instances sharing
some modifiable resources. Similar logic applied to **DIRECTORY** option -
locking parent directory doesn’t prevent other **LOCK** commands to lock any
child directory or file.

Trying to lock file twice is not allowed.  Any intermediate directories and
file itself will be created if they not exist.  **GUARD** and **TIMEOUT**
options ignored on **RELEASE** operation.

<a name="find_file"></a>

### find_file


A short-hand signature is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_file (<VAR> name1 [path1 path2 ...])
    .ft P
.UNINDENT
.UNINDENT

The general signature is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_file (
              <VAR>
              name | NAMES name1 [name2 ...]
              [HINTS path1 [path2 ... ENV var]]
              [PATHS path1 [path2 ... ENV var]]
              [PATH_SUFFIXES suffix1 [suffix2 ...]]
              [DOC "cache documentation string"]
              [NO_DEFAULT_PATH]
              [NO_PACKAGE_ROOT_PATH]
              [NO_CMAKE_PATH]
              [NO_CMAKE_ENVIRONMENT_PATH]
              [NO_SYSTEM_ENVIRONMENT_PATH]
              [NO_CMAKE_SYSTEM_PATH]
              [CMAKE_FIND_ROOT_PATH_BOTH |
               ONLY_CMAKE_FIND_ROOT_PATH |
               NO_CMAKE_FIND_ROOT_PATH]
             )
    .ft P
.UNINDENT
.UNINDENT

This command is used to find a full path to named file.
A cache entry named by **&lt;VAR&gt;** is created to store the result
of this command.
If the full path to a file is found the result is stored in the variable
and the search will not be repeated unless the variable is cleared.
If nothing is found, the result will be
**&lt;VAR&gt;-NOTFOUND**, and the search will be attempted again the
next time find_file is invoked with the same variable.

Options include:
.INDENT 0.0

* <b>**NAMES**</b>  
  Specify one or more possible names for the full path to a file.

When using this to specify names with and without a version
suffix, we recommend specifying the unversioned name first
so that locally-built packages can be found before those
provided by distributions.

* <b>**HINTS**, **PATHS**</b>  
  Specify directories to search in addition to the default locations.
  The **ENV var** sub-option reads paths from a system environment
  variable.
* <b>**PATH\_SUFFIXES**</b>  
  Specify additional subdirectories to check below each directory
  location otherwise considered.
* <b>**DOC**</b>  
  Specify the documentation string for the **&lt;VAR&gt;** cache entry.
  .UNINDENT

If **NO\_DEFAULT\_PATH** is specified, then no additional paths are
added to the search.
If **NO\_DEFAULT\_PATH** is not specified, the search process is as follows:
.INDENT 0.0

* 1.  
  If called from within a find module or any other script loaded by a call to
  **find\_package(&lt;PackageName&gt;)**, search prefixes unique to the
  current package being found.  Specifically, look in the
  **&lt;PackageName&gt;\_ROOT** CMake variable and the
  **&lt;PackageName&gt;\_ROOT** environment variable.
  The package root variables are maintained as a stack, so if called from
  nested find modules or config packages, root paths from the parent’s find
  module or config package will be searched after paths from the current
  module or package.  In other words, the search order would be
  **&lt;CurrentPackage&gt;\_ROOT**, **ENV{&lt;CurrentPackage&gt;\_ROOT}**,
  **&lt;ParentPackage&gt;\_ROOT**, **ENV{&lt;ParentPackage&gt;\_ROOT}**, etc.
  This can be skipped if **NO\_PACKAGE\_ROOT\_PATH** is passed or by setting
  the **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** to **FALSE**.
  See policy **CMP0074**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;** in the
  **&lt;PackageName&gt;\_ROOT** CMake variable and the
  **&lt;PackageName&gt;\_ROOT** environment variable if
  called from within a find module loaded by
  **find\_package(&lt;PackageName&gt;)**
  .UNINDENT
* 2.  
  Search paths specified in cmake-specific cache variables.
  These are intended to be used on the command line with a **-DVAR=value**.
  The values are interpreted as semicolon-separated lists.
  This can be skipped if **NO\_CMAKE\_PATH** is passed or by setting the
  **CMAKE\_FIND\_USE\_CMAKE\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;** in **CMAKE\_PREFIX\_PATH**
* ·  
  **CMAKE\_INCLUDE\_PATH**
* ·  
  **CMAKE\_FRAMEWORK\_PATH**
  .UNINDENT
* 3.  
  Search paths specified in cmake-specific environment variables.
  These are intended to be set in the user’s shell configuration,
  and therefore use the host’s native path separator
  (**;** on Windows and **:** on UNIX).
  This can be skipped if **NO\_CMAKE\_ENVIRONMENT\_PATH** is passed or
  by setting the **CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;** in **CMAKE\_PREFIX\_PATH**
* ·  
  **CMAKE\_INCLUDE\_PATH**
* ·  
  **CMAKE\_FRAMEWORK\_PATH**
  .UNINDENT
* 4.  
  Search the paths specified by the **HINTS** option.
  These should be paths computed by system introspection, such as a
  hint provided by the location of another item already found.
  Hard-coded guesses should be specified with the **PATHS** option.
* 5.  
  Search the standard system environment variables.
  This can be skipped if **NO\_SYSTEM\_ENVIRONMENT\_PATH** is passed or by
  setting the **CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  The directories in **PATH** and **INCLUDE**.
* ·  
  On Windows hosts:
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;/[s]bin** in **PATH**, and
  **&lt;entry&gt;/include** for other entries in **PATH**.
  .UNINDENT
* 6.  
  Search cmake variables defined in the Platform files
  for the current system.  This can be skipped if **NO\_CMAKE\_SYSTEM\_PATH**
  is passed or by setting the **CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**
  to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;** in
  **CMAKE\_SYSTEM\_PREFIX\_PATH**
* ·  
  **CMAKE\_SYSTEM\_INCLUDE\_PATH**
* ·  
  **CMAKE\_SYSTEM\_FRAMEWORK\_PATH**
  .UNINDENT
* 7.  
  Search the paths specified by the PATHS option
  or in the short-hand version of the command.
  These are typically hard-coded guesses.
  .UNINDENT

On macOS the **CMAKE\_FIND\_FRAMEWORK** and
**CMAKE\_FIND\_APPBUNDLE** variables determine the order of
preference between Apple-style and unix-style package components.

The CMake variable **CMAKE\_FIND\_ROOT\_PATH** specifies one or more
directories to be prepended to all other search directories.  This
effectively “re-roots” the entire search under given locations.
Paths which are descendants of the **CMAKE\_STAGING\_PREFIX** are excluded
from this re-rooting, because that variable is always a path on the host system.
By default the **CMAKE\_FIND\_ROOT\_PATH** is empty.

The **CMAKE\_SYSROOT** variable can also be used to specify exactly one
directory to use as a prefix.  Setting **CMAKE\_SYSROOT** also has other
effects.  See the documentation for that variable for more.

These variables are especially useful when cross-compiling to
point to the root directory of the target environment and CMake will
search there too.  By default at first the directories listed in
**CMAKE\_FIND\_ROOT\_PATH** are searched, then the **CMAKE\_SYSROOT**
directory is searched, and then the non-rooted directories will be
searched.  The default behavior can be adjusted by setting
**CMAKE\_FIND\_ROOT\_PATH\_MODE\_INCLUDE**.  This behavior can be manually
overridden on a per-call basis using options:
.INDENT 0.0

* <b>**CMAKE\_FIND\_ROOT\_PATH\_BOTH**</b>  
  Search in the order described above.
* <b>**NO\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Do not use the **CMAKE\_FIND\_ROOT\_PATH** variable.
* <b>**ONLY\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Search only the re-rooted directories and directories below
  **CMAKE\_STAGING\_PREFIX**.
  .UNINDENT

The default search order is designed to be most-specific to
least-specific for common use cases.
Projects may override the order by simply calling the command
multiple times and using the **NO\_*** options:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_file (<VAR> NAMES name PATHS paths... NO_DEFAULT_PATH)
    find_file (<VAR> NAMES name)
    .ft P
.UNINDENT
.UNINDENT

Once one of the calls succeeds the result variable will be set
and stored in the cache so that no call will search again.

<a name="find_library"></a>

### find_library


A short-hand signature is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_library (<VAR> name1 [path1 path2 ...])
    .ft P
.UNINDENT
.UNINDENT

The general signature is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_library (
              <VAR>
              name | NAMES name1 [name2 ...] [NAMES_PER_DIR]
              [HINTS path1 [path2 ... ENV var]]
              [PATHS path1 [path2 ... ENV var]]
              [PATH_SUFFIXES suffix1 [suffix2 ...]]
              [DOC "cache documentation string"]
              [NO_DEFAULT_PATH]
              [NO_PACKAGE_ROOT_PATH]
              [NO_CMAKE_PATH]
              [NO_CMAKE_ENVIRONMENT_PATH]
              [NO_SYSTEM_ENVIRONMENT_PATH]
              [NO_CMAKE_SYSTEM_PATH]
              [CMAKE_FIND_ROOT_PATH_BOTH |
               ONLY_CMAKE_FIND_ROOT_PATH |
               NO_CMAKE_FIND_ROOT_PATH]
             )
    .ft P
.UNINDENT
.UNINDENT

This command is used to find a library.
A cache entry named by **&lt;VAR&gt;** is created to store the result
of this command.
If the library is found the result is stored in the variable
and the search will not be repeated unless the variable is cleared.
If nothing is found, the result will be
**&lt;VAR&gt;-NOTFOUND**, and the search will be attempted again the
next time find_library is invoked with the same variable.

Options include:
.INDENT 0.0

* <b>**NAMES**</b>  
  Specify one or more possible names for the library.

When using this to specify names with and without a version
suffix, we recommend specifying the unversioned name first
so that locally-built packages can be found before those
provided by distributions.

* <b>**HINTS**, **PATHS**</b>  
  Specify directories to search in addition to the default locations.
  The **ENV var** sub-option reads paths from a system environment
  variable.
* <b>**PATH\_SUFFIXES**</b>  
  Specify additional subdirectories to check below each directory
  location otherwise considered.
* <b>**DOC**</b>  
  Specify the documentation string for the **&lt;VAR&gt;** cache entry.
  .UNINDENT

If **NO\_DEFAULT\_PATH** is specified, then no additional paths are
added to the search.
If **NO\_DEFAULT\_PATH** is not specified, the search process is as follows:
.INDENT 0.0

* 1.  
  If called from within a find module or any other script loaded by a call to
  **find\_package(&lt;PackageName&gt;)**, search prefixes unique to the
  current package being found.  Specifically, look in the
  **&lt;PackageName&gt;\_ROOT** CMake variable and the
  **&lt;PackageName&gt;\_ROOT** environment variable.
  The package root variables are maintained as a stack, so if called from
  nested find modules or config packages, root paths from the parent’s find
  module or config package will be searched after paths from the current
  module or package.  In other words, the search order would be
  **&lt;CurrentPackage&gt;\_ROOT**, **ENV{&lt;CurrentPackage&gt;\_ROOT}**,
  **&lt;ParentPackage&gt;\_ROOT**, **ENV{&lt;ParentPackage&gt;\_ROOT}**, etc.
  This can be skipped if **NO\_PACKAGE\_ROOT\_PATH** is passed or by setting
  the **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** to **FALSE**.
  See policy **CMP0074**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/lib/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE** is set,
  and **&lt;prefix&gt;/lib** for each **&lt;prefix&gt;** in the
  **&lt;PackageName&gt;\_ROOT** CMake variable and the
  **&lt;PackageName&gt;\_ROOT** environment variable if
  called from within a find module loaded by
  **find\_package(&lt;PackageName&gt;)**
  .UNINDENT
* 2.  
  Search paths specified in cmake-specific cache variables.
  These are intended to be used on the command line with a **-DVAR=value**.
  The values are interpreted as semicolon-separated lists.
  This can be skipped if **NO\_CMAKE\_PATH** is passed or by setting the
  **CMAKE\_FIND\_USE\_CMAKE\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/lib/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE** is set,
  and **&lt;prefix&gt;/lib** for each **&lt;prefix&gt;** in **CMAKE\_PREFIX\_PATH**
* ·  
  **CMAKE\_LIBRARY\_PATH**
* ·  
  **CMAKE\_FRAMEWORK\_PATH**
  .UNINDENT
* 3.  
  Search paths specified in cmake-specific environment variables.
  These are intended to be set in the user’s shell configuration,
  and therefore use the host’s native path separator
  (**;** on Windows and **:** on UNIX).
  This can be skipped if **NO\_CMAKE\_ENVIRONMENT\_PATH** is passed or
  by setting the **CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/lib/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE** is set,
  and **&lt;prefix&gt;/lib** for each **&lt;prefix&gt;** in **CMAKE\_PREFIX\_PATH**
* ·  
  **CMAKE\_LIBRARY\_PATH**
* ·  
  **CMAKE\_FRAMEWORK\_PATH**
  .UNINDENT
* 4.  
  Search the paths specified by the **HINTS** option.
  These should be paths computed by system introspection, such as a
  hint provided by the location of another item already found.
  Hard-coded guesses should be specified with the **PATHS** option.
* 5.  
  Search the standard system environment variables.
  This can be skipped if **NO\_SYSTEM\_ENVIRONMENT\_PATH** is passed or by
  setting the **CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  The directories in **PATH** and **INCLUDE**.
* ·  
  On Windows hosts:
  **&lt;prefix&gt;/lib/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/lib** for each **&lt;prefix&gt;/[s]bin** in **PATH**, and
  **&lt;entry&gt;/lib** for other entries in **PATH**.
  .UNINDENT
* 6.  
  Search cmake variables defined in the Platform files
  for the current system.  This can be skipped if **NO\_CMAKE\_SYSTEM\_PATH**
  is passed or by setting the **CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**
  to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/lib/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE** is set,
  and **&lt;prefix&gt;/lib** for each **&lt;prefix&gt;** in
  **CMAKE\_SYSTEM\_PREFIX\_PATH**
* ·  
  **CMAKE\_SYSTEM\_LIBRARY\_PATH**
* ·  
  **CMAKE\_SYSTEM\_FRAMEWORK\_PATH**
  .UNINDENT
* 7.  
  Search the paths specified by the PATHS option
  or in the short-hand version of the command.
  These are typically hard-coded guesses.
  .UNINDENT

On macOS the **CMAKE\_FIND\_FRAMEWORK** and
**CMAKE\_FIND\_APPBUNDLE** variables determine the order of
preference between Apple-style and unix-style package components.

The CMake variable **CMAKE\_FIND\_ROOT\_PATH** specifies one or more
directories to be prepended to all other search directories.  This
effectively “re-roots” the entire search under given locations.
Paths which are descendants of the **CMAKE\_STAGING\_PREFIX** are excluded
from this re-rooting, because that variable is always a path on the host system.
By default the **CMAKE\_FIND\_ROOT\_PATH** is empty.

The **CMAKE\_SYSROOT** variable can also be used to specify exactly one
directory to use as a prefix.  Setting **CMAKE\_SYSROOT** also has other
effects.  See the documentation for that variable for more.

These variables are especially useful when cross-compiling to
point to the root directory of the target environment and CMake will
search there too.  By default at first the directories listed in
**CMAKE\_FIND\_ROOT\_PATH** are searched, then the **CMAKE\_SYSROOT**
directory is searched, and then the non-rooted directories will be
searched.  The default behavior can be adjusted by setting
**CMAKE\_FIND\_ROOT\_PATH\_MODE\_LIBRARY**.  This behavior can be manually
overridden on a per-call basis using options:
.INDENT 0.0

* <b>**CMAKE\_FIND\_ROOT\_PATH\_BOTH**</b>  
  Search in the order described above.
* <b>**NO\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Do not use the **CMAKE\_FIND\_ROOT\_PATH** variable.
* <b>**ONLY\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Search only the re-rooted directories and directories below
  **CMAKE\_STAGING\_PREFIX**.
  .UNINDENT

The default search order is designed to be most-specific to
least-specific for common use cases.
Projects may override the order by simply calling the command
multiple times and using the **NO\_*** options:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_library (<VAR> NAMES name PATHS paths... NO_DEFAULT_PATH)
    find_library (<VAR> NAMES name)
    .ft P
.UNINDENT
.UNINDENT

Once one of the calls succeeds the result variable will be set
and stored in the cache so that no call will search again.

When more than one value is given to the **NAMES** option this command by
default will consider one name at a time and search every directory
for it.  The **NAMES\_PER\_DIR** option tells this command to consider one
directory at a time and search for all names in it.

Each library name given to the **NAMES** option is first considered
as a library file name and then considered with platform-specific
prefixes (e.g. **lib**) and suffixes (e.g. **.so**).  Therefore one
may specify library file names such as **libfoo.a** directly.
This can be used to locate static libraries on UNIX-like systems.

If the library found is a framework, then **&lt;VAR&gt;** will be set to the full
path to the framework **&lt;fullPath&gt;/A.framework**.  When a full path to a
framework is used as a library, CMake will use a **-framework A**, and a
**-F&lt;fullPath&gt;** to link the framework to the target.

If the **CMAKE\_FIND\_LIBRARY\_CUSTOM\_LIB\_SUFFIX** variable is set all
search paths will be tested as normal, with the suffix appended, and with
all matches of **lib/** replaced with
**lib${CMAKE\_FIND\_LIBRARY\_CUSTOM\_LIB\_SUFFIX}/**.  This variable overrides
the **FIND\_LIBRARY\_USE\_LIB32\_PATHS**,
**FIND\_LIBRARY\_USE\_LIBX32\_PATHS**,
and **FIND\_LIBRARY\_USE\_LIB64\_PATHS** global properties.

If the **FIND\_LIBRARY\_USE\_LIB32\_PATHS** global property is set
all search paths will be tested as normal, with **32/** appended, and
with all matches of **lib/** replaced with **lib32/**.  This property is
automatically set for the platforms that are known to need it if at
least one of the languages supported by the **project()** command
is enabled.

If the **FIND\_LIBRARY\_USE\_LIBX32\_PATHS** global property is set
all search paths will be tested as normal, with **x32/** appended, and
with all matches of **lib/** replaced with **libx32/**.  This property is
automatically set for the platforms that are known to need it if at
least one of the languages supported by the **project()** command
is enabled.

If the **FIND\_LIBRARY\_USE\_LIB64\_PATHS** global property is set
all search paths will be tested as normal, with **64/** appended, and
with all matches of **lib/** replaced with **lib64/**.  This property is
automatically set for the platforms that are known to need it if at
least one of the languages supported by the **project()** command
is enabled.

<a name="find_package"></a>

### find_package


Find an external project, and load its settings.

<a name="basic-signature-and-module-mode"></a>

### Basic Signature and Module Mode

.INDENT 0.0
.INDENT 3.5

    .ft C
    find_package(<PackageName> [version] [EXACT] [QUIET] [MODULE]
                 [REQUIRED] [[COMPONENTS] [components...]]
                 [OPTIONAL_COMPONENTS components...]
                 [NO_POLICY_SCOPE])
    .ft P
.UNINDENT
.UNINDENT

Finds and loads settings from an external project.  **&lt;PackageName&gt;\_FOUND**
will be set to indicate whether the package was found.  When the
package is found package-specific information is provided through
variables and Imported Targets documented by the package itself.  The
**QUIET** option disables informational messages, including those indicating
that the package cannot be found if it is not **REQUIRED**.  The **REQUIRED**
option stops processing with an error message if the package cannot be found.

A package-specific list of required components may be listed after the
**COMPONENTS** option (or after the **REQUIRED** option if present).
Additional optional components may be listed after
**OPTIONAL\_COMPONENTS**.  Available components and their influence on
whether a package is considered to be found are defined by the target
package.

The **[version]** argument requests a version with which the package found
should be compatible (format is **major[.minor[.patch[.tweak]]]**).  The
**EXACT** option requests that the version be matched exactly.  If no
**[version]** and/or component list is given to a recursive invocation
inside a find-module, the corresponding arguments are forwarded
automatically from the outer call (including the **EXACT** flag for
**[version]**).  Version support is currently provided only on a
package-by-package basis (see the _Version Selection_ section below).

See the **cmake\_policy()** command documentation for discussion
of the **NO\_POLICY\_SCOPE** option.

The command has two modes by which it searches for packages: “Module”
mode and “Config” mode.  The above signature selects Module mode.
If no module is found the command falls back to Config mode, described
below. This fall back is disabled if the **MODULE** option is given.

In Module mode, CMake searches for a file called **Find&lt;PackageName&gt;.cmake**.
The file is first searched in the **CMAKE\_MODULE\_PATH**,
then among the Find Modules provided by the CMake installation.
If the file is found, it is read and processed by CMake.  It is responsible
for finding the package, checking the version, and producing any needed
messages.  Some find-modules provide limited or no support for versioning;
check the module documentation.

If the **MODULE** option is not specfied in the above signature,
CMake first searches for the package using Module mode. Then, if the
package is not found, it searches again using Config mode. A user
may set the variable **CMAKE\_FIND\_PACKAGE\_PREFER\_CONFIG** to
**TRUE** to direct CMake first search using Config mode before falling
back to Module mode.

<a name="full-signature-and-config-mode"></a>

### Full Signature and Config Mode


User code should generally look for packages using the above basic
signature.  The remainder of this command documentation specifies the
full command signature and details of the search process.  Project
maintainers wishing to provide a package to be found by this command
are encouraged to read on.

The complete Config mode command signature is
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_package(<PackageName> [version] [EXACT] [QUIET]
                 [REQUIRED] [[COMPONENTS] [components...]]
                 [OPTIONAL_COMPONENTS components...]
                 [CONFIG|NO_MODULE]
                 [NO_POLICY_SCOPE]
                 [NAMES name1 [name2 ...]]
                 [CONFIGS config1 [config2 ...]]
                 [HINTS path1 [path2 ... ]]
                 [PATHS path1 [path2 ... ]]
                 [PATH_SUFFIXES suffix1 [suffix2 ...]]
                 [NO_DEFAULT_PATH]
                 [NO_PACKAGE_ROOT_PATH]
                 [NO_CMAKE_PATH]
                 [NO_CMAKE_ENVIRONMENT_PATH]
                 [NO_SYSTEM_ENVIRONMENT_PATH]
                 [NO_CMAKE_PACKAGE_REGISTRY]
                 [NO_CMAKE_BUILDS_PATH] # Deprecated; does nothing.
                 [NO_CMAKE_SYSTEM_PATH]
                 [NO_CMAKE_SYSTEM_PACKAGE_REGISTRY]
                 [CMAKE_FIND_ROOT_PATH_BOTH |
                  ONLY_CMAKE_FIND_ROOT_PATH |
                  NO_CMAKE_FIND_ROOT_PATH])
    .ft P
.UNINDENT
.UNINDENT

The **CONFIG** option, the synonymous **NO\_MODULE** option, or the use
of options not specified in the _basic signature_ all enforce pure Config
mode.  In pure Config mode, the command skips Module mode search and
proceeds at once with Config mode search.

Config mode search attempts to locate a configuration file provided by the
package to be found.  A cache entry called **&lt;PackageName&gt;\_DIR** is created to
hold the directory containing the file.  By default the command
searches for a package with the name **&lt;PackageName&gt;**.  If the **NAMES** option
is given the names following it are used instead of **&lt;PackageName&gt;**.
The command searches for a file called **&lt;PackageName&gt;Config.cmake** or
**&lt;lower-case-package-name&gt;-config.cmake** for each name specified.
A replacement set of possible configuration file names may be given
using the **CONFIGS** option.  The search procedure is specified below.
Once found, the configuration file is read and processed by CMake.
Since the file is provided by the package it already knows the
location of package contents.  The full path to the configuration file
is stored in the cmake variable **&lt;PackageName&gt;\_CONFIG**.

All configuration files which have been considered by CMake while
searching for an installation of the package with an appropriate
version are stored in the cmake variable **&lt;PackageName&gt;\_CONSIDERED\_CONFIGS**,
the associated versions in **&lt;PackageName&gt;\_CONSIDERED\_VERSIONS**.

If the package configuration file cannot be found CMake will generate
an error describing the problem unless the **QUIET** argument is
specified.  If **REQUIRED** is specified and the package is not found a
fatal error is generated and the configure step stops executing.  If
**&lt;PackageName&gt;\_DIR** has been set to a directory not containing a
configuration file CMake will ignore it and search from scratch.

Package maintainers providing CMake package configuration files are
encouraged to name and install them such that the _Search Procedure_
outlined below will find them without requiring use of additional options.

<a name="version-selection"></a>

### Version Selection


When the **[version]** argument is given Config mode will only find a
version of the package that claims compatibility with the requested
version (format is **major[.minor[.patch[.tweak]]]**).  If the **EXACT**
option is given only a version of the package claiming an exact match
of the requested version may be found.  CMake does not establish any
convention for the meaning of version numbers.  Package version
numbers are checked by “version” files provided by the packages
themselves.  For a candidate package configuration file
**&lt;config-file&gt;.cmake** the corresponding version file is located next
to it and named either **&lt;config-file&gt;-version.cmake** or
**&lt;config-file&gt;Version.cmake**.  If no such version file is available
then the configuration file is assumed to not be compatible with any
requested version.  A basic version file containing generic version
matching code can be created using the
**CMakePackageConfigHelpers** module.  When a version file
is found it is loaded to check the requested version number.  The
version file is loaded in a nested scope in which the following
variables have been defined:
.INDENT 0.0

* <b>**PACKAGE\_FIND\_NAME**</b>  
  the **&lt;PackageName&gt;**
* <b>**PACKAGE\_FIND\_VERSION**</b>  
  full requested version string
* <b>**PACKAGE\_FIND\_VERSION\_MAJOR**</b>  
  major version if requested, else 0
* <b>**PACKAGE\_FIND\_VERSION\_MINOR**</b>  
  minor version if requested, else 0
* <b>**PACKAGE\_FIND\_VERSION\_PATCH**</b>  
  patch version if requested, else 0
* <b>**PACKAGE\_FIND\_VERSION\_TWEAK**</b>  
  tweak version if requested, else 0
* <b>**PACKAGE\_FIND\_VERSION\_COUNT**</b>  
  number of version components, 0 to 4
  .UNINDENT

The version file checks whether it satisfies the requested version and
sets these variables:
.INDENT 0.0

* <b>**PACKAGE\_VERSION**</b>  
  full provided version string
* <b>**PACKAGE\_VERSION\_EXACT**</b>  
  true if version is exact match
* <b>**PACKAGE\_VERSION\_COMPATIBLE**</b>  
  true if version is compatible
* <b>**PACKAGE\_VERSION\_UNSUITABLE**</b>  
  true if unsuitable as any version
  .UNINDENT

These variables are checked by the **find\_package** command to determine
whether the configuration file provides an acceptable version.  They
are not available after the **find\_package** call returns.  If the version
is acceptable the following variables are set:
.INDENT 0.0

* <b>**&lt;PackageName&gt;\_VERSION**</b>  
  full provided version string
* <b>**&lt;PackageName&gt;\_VERSION\_MAJOR**</b>  
  major version if provided, else 0
* <b>**&lt;PackageName&gt;\_VERSION\_MINOR**</b>  
  minor version if provided, else 0
* <b>**&lt;PackageName&gt;\_VERSION\_PATCH**</b>  
  patch version if provided, else 0
* <b>**&lt;PackageName&gt;\_VERSION\_TWEAK**</b>  
  tweak version if provided, else 0
* <b>**&lt;PackageName&gt;\_VERSION\_COUNT**</b>  
  number of version components, 0 to 4
  .UNINDENT

and the corresponding package configuration file is loaded.
When multiple package configuration files are available whose version files
claim compatibility with the version requested it is unspecified which
one is chosen: unless the variable **CMAKE\_FIND\_PACKAGE\_SORT\_ORDER**
is set no attempt is made to choose a highest or closest version number.

To control the order in which **find\_package** checks for compatibility use
the two variables **CMAKE\_FIND\_PACKAGE\_SORT\_ORDER** and
**CMAKE\_FIND\_PACKAGE\_SORT\_DIRECTION**.
For instance in order to select the highest version one can set
.INDENT 0.0
.INDENT 3.5

    .ft C
    SET(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
    SET(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
    .ft P
.UNINDENT
.UNINDENT

before calling **find\_package**.

<a name="search-procedure"></a>

### Search Procedure


CMake constructs a set of possible installation prefixes for the
package.  Under each prefix several directories are searched for a
configuration file.  The tables below show the directories searched.
Each entry is meant for installation trees following Windows (**W**), UNIX
(**U**), or Apple (**A**) conventions:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <prefix>/                                                       (W)
    <prefix>/(cmake|CMake)/                                         (W)
    <prefix>/<name>*/                                               (W)
    <prefix>/<name>*/(cmake|CMake)/                                 (W)
    <prefix>/(lib/<arch>|lib*|share)/cmake/<name>*/                 (U)
    <prefix>/(lib/<arch>|lib*|share)/<name>*/                       (U)
    <prefix>/(lib/<arch>|lib*|share)/<name>*/(cmake|CMake)/         (U)
    <prefix>/<name>*/(lib/<arch>|lib*|share)/cmake/<name>*/         (W/U)
    <prefix>/<name>*/(lib/<arch>|lib*|share)/<name>*/               (W/U)
    <prefix>/<name>*/(lib/<arch>|lib*|share)/<name>*/(cmake|CMake)/ (W/U)
    .ft P
.UNINDENT
.UNINDENT

On systems supporting macOS **FRAMEWORK** and **BUNDLE**, the
following directories are searched for Frameworks or Application Bundles
containing a configuration file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <prefix>/<name>.framework/Resources/                    (A)
    <prefix>/<name>.framework/Resources/CMake/              (A)
    <prefix>/<name>.framework/Versions/*/Resources/         (A)
    <prefix>/<name>.framework/Versions/*/Resources/CMake/   (A)
    <prefix>/<name>.app/Contents/Resources/                 (A)
    <prefix>/<name>.app/Contents/Resources/CMake/           (A)
    .ft P
.UNINDENT
.UNINDENT

In all cases the **&lt;name&gt;** is treated as case-insensitive and corresponds
to any of the names specified (**&lt;PackageName&gt;** or names given by **NAMES**).

Paths with **lib/&lt;arch&gt;** are enabled if the
**CMAKE\_LIBRARY\_ARCHITECTURE** variable is set. **lib*** includes one
or more of the values **lib64**, **lib32**, **libx32** or **lib** (searched in
that order).
.INDENT 0.0

* ·  
  Paths with **lib64** are searched on 64 bit platforms if the
  **FIND\_LIBRARY\_USE\_LIB64\_PATHS** property is set to **TRUE**.
* ·  
  Paths with **lib32** are searched on 32 bit platforms if the
  **FIND\_LIBRARY\_USE\_LIB32\_PATHS** property is set to **TRUE**.
* ·  
  Paths with **libx32** are searched on platforms using the x32 ABI
  if the **FIND\_LIBRARY\_USE\_LIBX32\_PATHS** property is set to **TRUE**.
* ·  
  The **lib** path is always searched.
  .UNINDENT

If **PATH\_SUFFIXES** is specified, the suffixes are appended to each
(**W**) or (**U**) directory entry one-by-one.

This set of directories is intended to work in cooperation with
projects that provide configuration files in their installation trees.
Directories above marked with (**W**) are intended for installations on
Windows where the prefix may point at the top of an application’s
installation directory.  Those marked with (**U**) are intended for
installations on UNIX platforms where the prefix is shared by multiple
packages.  This is merely a convention, so all (**W**) and (**U**) directories
are still searched on all platforms.  Directories marked with (**A**) are
intended for installations on Apple platforms.  The
**CMAKE\_FIND\_FRAMEWORK** and **CMAKE\_FIND\_APPBUNDLE**
variables determine the order of preference.

The set of installation prefixes is constructed using the following
steps.  If **NO\_DEFAULT\_PATH** is specified all **NO\_*** options are
enabled.
.INDENT 0.0

* 1.  
  Search paths specified in the **&lt;PackageName&gt;\_ROOT** CMake
  variable and the **&lt;PackageName&gt;\_ROOT** environment variable,
  where **&lt;PackageName&gt;** is the package to be found.
  The package root variables are maintained as a stack so if
  called from within a find module, root paths from the parent’s find
  module will also be searched after paths for the current package.
  This can be skipped if **NO\_PACKAGE\_ROOT\_PATH** is passed or by setting
  the **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** to **FALSE**.
  See policy **CMP0074**.
* 2.  
  Search paths specified in cmake-specific cache variables.  These
  are intended to be used on the command line with a **-DVAR=value**.
  The values are interpreted as semicolon-separated lists.
  This can be skipped if **NO\_CMAKE\_PATH** is passed or by setting the
  **CMAKE\_FIND\_USE\_CMAKE\_PATH** to **FALSE**:
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    CMAKE_PREFIX_PATH
    CMAKE_FRAMEWORK_PATH
    CMAKE_APPBUNDLE_PATH
    .ft P
.UNINDENT
.UNINDENT

* 3.  
  Search paths specified in cmake-specific environment variables.
  These are intended to be set in the user’s shell configuration,
  and therefore use the host’s native path separator
  (**;** on Windows and **:** on UNIX).
  This can be skipped if **NO\_CMAKE\_ENVIRONMENT\_PATH** is passed or by setting
  the **CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH** to **FALSE**:
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    <PackageName>_DIR
    CMAKE_PREFIX_PATH
    CMAKE_FRAMEWORK_PATH
    CMAKE_APPBUNDLE_PATH
    .ft P
.UNINDENT
.UNINDENT

* 4.  
  Search paths specified by the **HINTS** option.  These should be paths
  computed by system introspection, such as a hint provided by the
  location of another item already found.  Hard-coded guesses should
  be specified with the **PATHS** option.
* 5.  
  Search the standard system environment variables.  This can be
  skipped if **NO\_SYSTEM\_ENVIRONMENT\_PATH** is passed  or by setting the
  **CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH** to **FALSE**. Path entries
  ending in **/bin** or **/sbin** are automatically converted to their
  parent directories:
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    PATH
    .ft P
.UNINDENT
.UNINDENT

* 6.  
  Search paths stored in the CMake User Package Registry.
  This can be skipped if **NO\_CMAKE\_PACKAGE\_REGISTRY** is passed or by
  setting the variable **CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY**
  to **FALSE** or the deprecated variable
  **CMAKE\_FIND\_PACKAGE\_NO\_PACKAGE\_REGISTRY** to **TRUE**.

See the **cmake-packages(7)** manual for details on the user
package registry.

* 7.  
  Search cmake variables defined in the Platform files for the
  current system.  This can be skipped if **NO\_CMAKE\_SYSTEM\_PATH** is
  passed or by setting the **CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**
  to **FALSE**:
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    CMAKE_SYSTEM_PREFIX_PATH
    CMAKE_SYSTEM_FRAMEWORK_PATH
    CMAKE_SYSTEM_APPBUNDLE_PATH
    .ft P
.UNINDENT
.UNINDENT

* 8.  
  Search paths stored in the CMake System Package Registry.
  This can be skipped if **NO\_CMAKE\_SYSTEM\_PACKAGE\_REGISTRY** is passed
  or by setting the **CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY**
  variable to **FALSE** or the deprecated variable
  **CMAKE\_FIND\_PACKAGE\_NO\_SYSTEM\_PACKAGE\_REGISTRY** to **TRUE**.

See the **cmake-packages(7)** manual for details on the system
package registry.

* 9.  
  Search paths specified by the **PATHS** option.  These are typically
  hard-coded guesses.
  .UNINDENT

The CMake variable **CMAKE\_FIND\_ROOT\_PATH** specifies one or more
directories to be prepended to all other search directories.  This
effectively “re-roots” the entire search under given locations.
Paths which are descendants of the **CMAKE\_STAGING\_PREFIX** are excluded
from this re-rooting, because that variable is always a path on the host system.
By default the **CMAKE\_FIND\_ROOT\_PATH** is empty.

The **CMAKE\_SYSROOT** variable can also be used to specify exactly one
directory to use as a prefix.  Setting **CMAKE\_SYSROOT** also has other
effects.  See the documentation for that variable for more.

These variables are especially useful when cross-compiling to
point to the root directory of the target environment and CMake will
search there too.  By default at first the directories listed in
**CMAKE\_FIND\_ROOT\_PATH** are searched, then the **CMAKE\_SYSROOT**
directory is searched, and then the non-rooted directories will be
searched.  The default behavior can be adjusted by setting
**CMAKE\_FIND\_ROOT\_PATH\_MODE\_PACKAGE**.  This behavior can be manually
overridden on a per-call basis using options:
.INDENT 0.0

* <b>**CMAKE\_FIND\_ROOT\_PATH\_BOTH**</b>  
  Search in the order described above.
* <b>**NO\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Do not use the **CMAKE\_FIND\_ROOT\_PATH** variable.
* <b>**ONLY\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Search only the re-rooted directories and directories below
  **CMAKE\_STAGING\_PREFIX**.
  .UNINDENT

The default search order is designed to be most-specific to
least-specific for common use cases.
Projects may override the order by simply calling the command
multiple times and using the **NO\_*** options:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_package (<PackageName> PATHS paths... NO_DEFAULT_PATH)
    find_package (<PackageName>)
    .ft P
.UNINDENT
.UNINDENT

Once one of the calls succeeds the result variable will be set
and stored in the cache so that no call will search again.

By default the value stored in the result variable will be the path at
which the file is found.  The **CMAKE\_FIND\_PACKAGE\_RESOLVE\_SYMLINKS**
variable may be set to **TRUE** before calling **find\_package** in order
to resolve symbolic links and store the real path to the file.

Every non-REQUIRED **find\_package** call can be disabled by setting the
**CMAKE\_DISABLE\_FIND\_PACKAGE\_&lt;PackageName&gt;** variable to **TRUE**.

<a name="package-file-interface-variables"></a>

### Package File Interface Variables


When loading a find module or package configuration file **find\_package**
defines variables to provide information about the call arguments (and
restores their original state before returning):
.INDENT 0.0

* <b>**CMAKE\_FIND\_PACKAGE\_NAME**</b>  
  the **&lt;PackageName&gt;** which is searched for
* <b>**&lt;PackageName&gt;\_FIND\_REQUIRED**</b>  
  true if **REQUIRED** option was given
* <b>**&lt;PackageName&gt;\_FIND\_QUIETLY**</b>  
  true if **QUIET** option was given
* <b>**&lt;PackageName&gt;\_FIND\_VERSION**</b>  
  full requested version string
* <b>**&lt;PackageName&gt;\_FIND\_VERSION\_MAJOR**</b>  
  major version if requested, else 0
* <b>**&lt;PackageName&gt;\_FIND\_VERSION\_MINOR**</b>  
  minor version if requested, else 0
* <b>**&lt;PackageName&gt;\_FIND\_VERSION\_PATCH**</b>  
  patch version if requested, else 0
* <b>**&lt;PackageName&gt;\_FIND\_VERSION\_TWEAK**</b>  
  tweak version if requested, else 0
* <b>**&lt;PackageName&gt;\_FIND\_VERSION\_COUNT**</b>  
  number of version components, 0 to 4
* <b>**&lt;PackageName&gt;\_FIND\_VERSION\_EXACT**</b>  
  true if **EXACT** option was given
* <b>**&lt;PackageName&gt;\_FIND\_COMPONENTS**</b>  
  list of requested components
* <b>**&lt;PackageName&gt;\_FIND\_REQUIRED\_&lt;c&gt;**</b>  
  true if component **&lt;c&gt;** is required,
  false if component **&lt;c&gt;** is optional
  .UNINDENT

In Module mode the loaded find module is responsible to honor the
request detailed by these variables; see the find module for details.
In Config mode **find\_package** handles **REQUIRED**, **QUIET**, and
**[version]** options automatically but leaves it to the package
configuration file to handle components in a way that makes sense
for the package.  The package configuration file may set
**&lt;PackageName&gt;\_FOUND** to false to tell **find\_package** that component
requirements are not satisfied.

<a name="find_path"></a>

### find_path


A short-hand signature is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_path (<VAR> name1 [path1 path2 ...])
    .ft P
.UNINDENT
.UNINDENT

The general signature is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_path (
              <VAR>
              name | NAMES name1 [name2 ...]
              [HINTS path1 [path2 ... ENV var]]
              [PATHS path1 [path2 ... ENV var]]
              [PATH_SUFFIXES suffix1 [suffix2 ...]]
              [DOC "cache documentation string"]
              [NO_DEFAULT_PATH]
              [NO_PACKAGE_ROOT_PATH]
              [NO_CMAKE_PATH]
              [NO_CMAKE_ENVIRONMENT_PATH]
              [NO_SYSTEM_ENVIRONMENT_PATH]
              [NO_CMAKE_SYSTEM_PATH]
              [CMAKE_FIND_ROOT_PATH_BOTH |
               ONLY_CMAKE_FIND_ROOT_PATH |
               NO_CMAKE_FIND_ROOT_PATH]
             )
    .ft P
.UNINDENT
.UNINDENT

This command is used to find a directory containing the named file.
A cache entry named by **&lt;VAR&gt;** is created to store the result
of this command.
If the file in a directory is found the result is stored in the variable
and the search will not be repeated unless the variable is cleared.
If nothing is found, the result will be
**&lt;VAR&gt;-NOTFOUND**, and the search will be attempted again the
next time find_path is invoked with the same variable.

Options include:
.INDENT 0.0

* <b>**NAMES**</b>  
  Specify one or more possible names for the file in a directory.

When using this to specify names with and without a version
suffix, we recommend specifying the unversioned name first
so that locally-built packages can be found before those
provided by distributions.

* <b>**HINTS**, **PATHS**</b>  
  Specify directories to search in addition to the default locations.
  The **ENV var** sub-option reads paths from a system environment
  variable.
* <b>**PATH\_SUFFIXES**</b>  
  Specify additional subdirectories to check below each directory
  location otherwise considered.
* <b>**DOC**</b>  
  Specify the documentation string for the **&lt;VAR&gt;** cache entry.
  .UNINDENT

If **NO\_DEFAULT\_PATH** is specified, then no additional paths are
added to the search.
If **NO\_DEFAULT\_PATH** is not specified, the search process is as follows:
.INDENT 0.0

* 1.  
  If called from within a find module or any other script loaded by a call to
  **find\_package(&lt;PackageName&gt;)**, search prefixes unique to the
  current package being found.  Specifically, look in the
  **&lt;PackageName&gt;\_ROOT** CMake variable and the
  **&lt;PackageName&gt;\_ROOT** environment variable.
  The package root variables are maintained as a stack, so if called from
  nested find modules or config packages, root paths from the parent’s find
  module or config package will be searched after paths from the current
  module or package.  In other words, the search order would be
  **&lt;CurrentPackage&gt;\_ROOT**, **ENV{&lt;CurrentPackage&gt;\_ROOT}**,
  **&lt;ParentPackage&gt;\_ROOT**, **ENV{&lt;ParentPackage&gt;\_ROOT}**, etc.
  This can be skipped if **NO\_PACKAGE\_ROOT\_PATH** is passed or by setting
  the **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** to **FALSE**.
  See policy **CMP0074**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;** in the
  **&lt;PackageName&gt;\_ROOT** CMake variable and the
  **&lt;PackageName&gt;\_ROOT** environment variable if
  called from within a find module loaded by
  **find\_package(&lt;PackageName&gt;)**
  .UNINDENT
* 2.  
  Search paths specified in cmake-specific cache variables.
  These are intended to be used on the command line with a **-DVAR=value**.
  The values are interpreted as semicolon-separated lists.
  This can be skipped if **NO\_CMAKE\_PATH** is passed or by setting the
  **CMAKE\_FIND\_USE\_CMAKE\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;** in **CMAKE\_PREFIX\_PATH**
* ·  
  **CMAKE\_INCLUDE\_PATH**
* ·  
  **CMAKE\_FRAMEWORK\_PATH**
  .UNINDENT
* 3.  
  Search paths specified in cmake-specific environment variables.
  These are intended to be set in the user’s shell configuration,
  and therefore use the host’s native path separator
  (**;** on Windows and **:** on UNIX).
  This can be skipped if **NO\_CMAKE\_ENVIRONMENT\_PATH** is passed or
  by setting the **CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;** in **CMAKE\_PREFIX\_PATH**
* ·  
  **CMAKE\_INCLUDE\_PATH**
* ·  
  **CMAKE\_FRAMEWORK\_PATH**
  .UNINDENT
* 4.  
  Search the paths specified by the **HINTS** option.
  These should be paths computed by system introspection, such as a
  hint provided by the location of another item already found.
  Hard-coded guesses should be specified with the **PATHS** option.
* 5.  
  Search the standard system environment variables.
  This can be skipped if **NO\_SYSTEM\_ENVIRONMENT\_PATH** is passed or by
  setting the **CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  The directories in **PATH** and **INCLUDE**.
* ·  
  On Windows hosts:
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;/[s]bin** in **PATH**, and
  **&lt;entry&gt;/include** for other entries in **PATH**.
  .UNINDENT
* 6.  
  Search cmake variables defined in the Platform files
  for the current system.  This can be skipped if **NO\_CMAKE\_SYSTEM\_PATH**
  is passed or by setting the **CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**
  to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/include/&lt;arch&gt;** if **CMAKE\_LIBRARY\_ARCHITECTURE**
  is set, and **&lt;prefix&gt;/include** for each **&lt;prefix&gt;** in
  **CMAKE\_SYSTEM\_PREFIX\_PATH**
* ·  
  **CMAKE\_SYSTEM\_INCLUDE\_PATH**
* ·  
  **CMAKE\_SYSTEM\_FRAMEWORK\_PATH**
  .UNINDENT
* 7.  
  Search the paths specified by the PATHS option
  or in the short-hand version of the command.
  These are typically hard-coded guesses.
  .UNINDENT

On macOS the **CMAKE\_FIND\_FRAMEWORK** and
**CMAKE\_FIND\_APPBUNDLE** variables determine the order of
preference between Apple-style and unix-style package components.

The CMake variable **CMAKE\_FIND\_ROOT\_PATH** specifies one or more
directories to be prepended to all other search directories.  This
effectively “re-roots” the entire search under given locations.
Paths which are descendants of the **CMAKE\_STAGING\_PREFIX** are excluded
from this re-rooting, because that variable is always a path on the host system.
By default the **CMAKE\_FIND\_ROOT\_PATH** is empty.

The **CMAKE\_SYSROOT** variable can also be used to specify exactly one
directory to use as a prefix.  Setting **CMAKE\_SYSROOT** also has other
effects.  See the documentation for that variable for more.

These variables are especially useful when cross-compiling to
point to the root directory of the target environment and CMake will
search there too.  By default at first the directories listed in
**CMAKE\_FIND\_ROOT\_PATH** are searched, then the **CMAKE\_SYSROOT**
directory is searched, and then the non-rooted directories will be
searched.  The default behavior can be adjusted by setting
**CMAKE\_FIND\_ROOT\_PATH\_MODE\_INCLUDE**.  This behavior can be manually
overridden on a per-call basis using options:
.INDENT 0.0

* <b>**CMAKE\_FIND\_ROOT\_PATH\_BOTH**</b>  
  Search in the order described above.
* <b>**NO\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Do not use the **CMAKE\_FIND\_ROOT\_PATH** variable.
* <b>**ONLY\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Search only the re-rooted directories and directories below
  **CMAKE\_STAGING\_PREFIX**.
  .UNINDENT

The default search order is designed to be most-specific to
least-specific for common use cases.
Projects may override the order by simply calling the command
multiple times and using the **NO\_*** options:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_path (<VAR> NAMES name PATHS paths... NO_DEFAULT_PATH)
    find_path (<VAR> NAMES name)
    .ft P
.UNINDENT
.UNINDENT

Once one of the calls succeeds the result variable will be set
and stored in the cache so that no call will search again.

When searching for frameworks, if the file is specified as **A/b.h**, then
the framework search will look for **A.framework/Headers/b.h**.  If that
is found the path will be set to the path to the framework.  CMake
will convert this to the correct **-F** option to include the file.

<a name="find_program"></a>

### find_program


A short-hand signature is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_program (<VAR> name1 [path1 path2 ...])
    .ft P
.UNINDENT
.UNINDENT

The general signature is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_program (
              <VAR>
              name | NAMES name1 [name2 ...] [NAMES_PER_DIR]
              [HINTS path1 [path2 ... ENV var]]
              [PATHS path1 [path2 ... ENV var]]
              [PATH_SUFFIXES suffix1 [suffix2 ...]]
              [DOC "cache documentation string"]
              [NO_DEFAULT_PATH]
              [NO_PACKAGE_ROOT_PATH]
              [NO_CMAKE_PATH]
              [NO_CMAKE_ENVIRONMENT_PATH]
              [NO_SYSTEM_ENVIRONMENT_PATH]
              [NO_CMAKE_SYSTEM_PATH]
              [CMAKE_FIND_ROOT_PATH_BOTH |
               ONLY_CMAKE_FIND_ROOT_PATH |
               NO_CMAKE_FIND_ROOT_PATH]
             )
    .ft P
.UNINDENT
.UNINDENT

This command is used to find a program.
A cache entry named by **&lt;VAR&gt;** is created to store the result
of this command.
If the program is found the result is stored in the variable
and the search will not be repeated unless the variable is cleared.
If nothing is found, the result will be
**&lt;VAR&gt;-NOTFOUND**, and the search will be attempted again the
next time find_program is invoked with the same variable.

Options include:
.INDENT 0.0

* <b>**NAMES**</b>  
  Specify one or more possible names for the program.

When using this to specify names with and without a version
suffix, we recommend specifying the unversioned name first
so that locally-built packages can be found before those
provided by distributions.

* <b>**HINTS**, **PATHS**</b>  
  Specify directories to search in addition to the default locations.
  The **ENV var** sub-option reads paths from a system environment
  variable.
* <b>**PATH\_SUFFIXES**</b>  
  Specify additional subdirectories to check below each directory
  location otherwise considered.
* <b>**DOC**</b>  
  Specify the documentation string for the **&lt;VAR&gt;** cache entry.
  .UNINDENT

If **NO\_DEFAULT\_PATH** is specified, then no additional paths are
added to the search.
If **NO\_DEFAULT\_PATH** is not specified, the search process is as follows:
.INDENT 0.0

* 1.  
  If called from within a find module or any other script loaded by a call to
  **find\_package(&lt;PackageName&gt;)**, search prefixes unique to the
  current package being found.  Specifically, look in the
  **&lt;PackageName&gt;\_ROOT** CMake variable and the
  **&lt;PackageName&gt;\_ROOT** environment variable.
  The package root variables are maintained as a stack, so if called from
  nested find modules or config packages, root paths from the parent’s find
  module or config package will be searched after paths from the current
  module or package.  In other words, the search order would be
  **&lt;CurrentPackage&gt;\_ROOT**, **ENV{&lt;CurrentPackage&gt;\_ROOT}**,
  **&lt;ParentPackage&gt;\_ROOT**, **ENV{&lt;ParentPackage&gt;\_ROOT}**, etc.
  This can be skipped if **NO\_PACKAGE\_ROOT\_PATH** is passed or by setting
  the **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** to **FALSE**.
  See policy **CMP0074**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/[s]bin** for each **&lt;prefix&gt;** in the
  **&lt;PackageName&gt;\_ROOT** CMake variable and the
  **&lt;PackageName&gt;\_ROOT** environment variable if
  called from within a find module loaded by
  **find\_package(&lt;PackageName&gt;)**
  .UNINDENT
* 2.  
  Search paths specified in cmake-specific cache variables.
  These are intended to be used on the command line with a **-DVAR=value**.
  The values are interpreted as semicolon-separated lists.
  This can be skipped if **NO\_CMAKE\_PATH** is passed or by setting the
  **CMAKE\_FIND\_USE\_CMAKE\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/[s]bin** for each **&lt;prefix&gt;** in **CMAKE\_PREFIX\_PATH**
* ·  
  **CMAKE\_PROGRAM\_PATH**
* ·  
  **CMAKE\_APPBUNDLE\_PATH**
  .UNINDENT
* 3.  
  Search paths specified in cmake-specific environment variables.
  These are intended to be set in the user’s shell configuration,
  and therefore use the host’s native path separator
  (**;** on Windows and **:** on UNIX).
  This can be skipped if **NO\_CMAKE\_ENVIRONMENT\_PATH** is passed or
  by setting the **CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/[s]bin** for each **&lt;prefix&gt;** in **CMAKE\_PREFIX\_PATH**
* ·  
  **CMAKE\_PROGRAM\_PATH**
* ·  
  **CMAKE\_APPBUNDLE\_PATH**
  .UNINDENT
* 4.  
  Search the paths specified by the **HINTS** option.
  These should be paths computed by system introspection, such as a
  hint provided by the location of another item already found.
  Hard-coded guesses should be specified with the **PATHS** option.
* 5.  
  Search the standard system environment variables.
  This can be skipped if **NO\_SYSTEM\_ENVIRONMENT\_PATH** is passed or by
  setting the **CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH** to **FALSE**.
  .INDENT 3.0
* ·  
  The directories in **PATH** itself.
* ·  
  On Windows hosts no extra search paths are included
  .UNINDENT
* 6.  
  Search cmake variables defined in the Platform files
  for the current system.  This can be skipped if **NO\_CMAKE\_SYSTEM\_PATH**
  is passed or by setting the **CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**
  to **FALSE**.
  .INDENT 3.0
* ·  
  **&lt;prefix&gt;/[s]bin** for each **&lt;prefix&gt;** in
  **CMAKE\_SYSTEM\_PREFIX\_PATH**
* ·  
  **CMAKE\_SYSTEM\_PROGRAM\_PATH**
* ·  
  **CMAKE\_SYSTEM\_APPBUNDLE\_PATH**
  .UNINDENT
* 7.  
  Search the paths specified by the PATHS option
  or in the short-hand version of the command.
  These are typically hard-coded guesses.
  .UNINDENT

On macOS the **CMAKE\_FIND\_FRAMEWORK** and
**CMAKE\_FIND\_APPBUNDLE** variables determine the order of
preference between Apple-style and unix-style package components.

The CMake variable **CMAKE\_FIND\_ROOT\_PATH** specifies one or more
directories to be prepended to all other search directories.  This
effectively “re-roots” the entire search under given locations.
Paths which are descendants of the **CMAKE\_STAGING\_PREFIX** are excluded
from this re-rooting, because that variable is always a path on the host system.
By default the **CMAKE\_FIND\_ROOT\_PATH** is empty.

The **CMAKE\_SYSROOT** variable can also be used to specify exactly one
directory to use as a prefix.  Setting **CMAKE\_SYSROOT** also has other
effects.  See the documentation for that variable for more.

These variables are especially useful when cross-compiling to
point to the root directory of the target environment and CMake will
search there too.  By default at first the directories listed in
**CMAKE\_FIND\_ROOT\_PATH** are searched, then the **CMAKE\_SYSROOT**
directory is searched, and then the non-rooted directories will be
searched.  The default behavior can be adjusted by setting
**CMAKE\_FIND\_ROOT\_PATH\_MODE\_PROGRAM**.  This behavior can be manually
overridden on a per-call basis using options:
.INDENT 0.0

* <b>**CMAKE\_FIND\_ROOT\_PATH\_BOTH**</b>  
  Search in the order described above.
* <b>**NO\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Do not use the **CMAKE\_FIND\_ROOT\_PATH** variable.
* <b>**ONLY\_CMAKE\_FIND\_ROOT\_PATH**</b>  
  Search only the re-rooted directories and directories below
  **CMAKE\_STAGING\_PREFIX**.
  .UNINDENT

The default search order is designed to be most-specific to
least-specific for common use cases.
Projects may override the order by simply calling the command
multiple times and using the **NO\_*** options:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_program (<VAR> NAMES name PATHS paths... NO_DEFAULT_PATH)
    find_program (<VAR> NAMES name)
    .ft P
.UNINDENT
.UNINDENT

Once one of the calls succeeds the result variable will be set
and stored in the cache so that no call will search again.

When more than one value is given to the **NAMES** option this command by
default will consider one name at a time and search every directory
for it.  The **NAMES\_PER\_DIR** option tells this command to consider one
directory at a time and search for all names in it.

<a name="foreach"></a>

### foreach


Evaluate a group of commands for each value in a list.
.INDENT 0.0
.INDENT 3.5

    .ft C
    foreach(<loop_var> <items>)
      <commands>
    endforeach()
    .ft P
.UNINDENT
.UNINDENT

where **&lt;items&gt;** is a list of items that are separated by
semicolon or whitespace.
All commands between **foreach** and the matching **endforeach** are recorded
without being invoked.  Once the **endforeach** is evaluated, the recorded
list of commands is invoked once for each item in **&lt;items&gt;**.
At the beginning of each iteration the variable **loop\_var** will be set
to the value of the current item.

The commands **break()** and **continue()** provide means to
escape from the normal control flow.

Per legacy, the **endforeach()** command admits
an optional **&lt;loop\_var&gt;** argument.
If used, it must be a verbatim
repeat of the argument of the opening
**foreach** command.
.INDENT 0.0
.INDENT 3.5

    .ft C
    foreach(<loop_var> RANGE <stop>)
    .ft P
.UNINDENT
.UNINDENT

In this variant, **foreach** iterates over the numbers
0, 1, … up to (and including) the nonnegative integer **&lt;stop&gt;**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    foreach(<loop_var> RANGE <start> <stop> [<step>])
    .ft P
.UNINDENT
.UNINDENT

In this variant, **foreach** iterates over the numbers from
**&lt;start&gt;** up to at most **&lt;stop&gt;** in steps of **&lt;step&gt;**.
If **&lt;step&gt;** is not specified, then the step size is 1.
The three arguments **&lt;start&gt;** **&lt;stop&gt;** **&lt;step&gt;** must
all be nonnegative integers, and **&lt;stop&gt;** must not be
smaller than **&lt;start&gt;**; otherwise you enter the danger zone
of undocumented behavior that may change in future releases.
.INDENT 0.0
.INDENT 3.5

    .ft C
    foreach(<loop_var> IN [LISTS [<lists>]] [ITEMS [<items>]])
    .ft P
.UNINDENT
.UNINDENT

In this variant, **&lt;lists&gt;** is a whitespace or semicolon
separated list of list-valued variables. The **foreach**
command iterates over each item in each given list.
The **&lt;items&gt;** following the **ITEMS** keyword are processed
as in the first variant of the **foreach** command.
The forms **LISTS A** and **ITEMS ${A}** are
equivalent.

The following example shows how the **LISTS** option is
processed:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(A 0;1)
    set(B 2 3)
    set(C "4 5")
    set(D 6;7 8)
    set(E "")
    foreach(X IN LISTS A B C D E)
        message(STATUS "X=${X}")
    endforeach()
    .ft P
.UNINDENT
.UNINDENT

yields
.INDENT 0.0
.INDENT 3.5

    .ft C
    -- X=0
    -- X=1
    -- X=2
    -- X=3
    -- X=4 5
    -- X=6
    -- X=7
    -- X=8
    .ft P
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    foreach(<loop_var>... IN ZIP_LISTS <lists>)
    .ft P
.UNINDENT
.UNINDENT

In this variant, **&lt;lists&gt;** is a whitespace or semicolon
separated list of list-valued variables. The **foreach**
command iterates over each list simultaneously setting the
iteration variables as follows:
.INDENT 0.0

* ·  
  if the only **loop\_var** given, then it sets a series of
  **loop\_var\_N** variables to the current item from the
  corresponding list;
* ·  
  if multiple variable names passed, their count should match
  the lists variables count;
* ·  
  if any of the lists are shorter, the corresponding iteration
  variable is not defined for the current iteration.
  .UNINDENT
  .INDENT 0.0
  .INDENT 3.5

    .ft C
    list(APPEND English one two three four)
    list(APPEND Bahasa satu dua tiga)
    
    foreach(num IN ZIP_LISTS English Bahasa)
        message(STATUS "num_0=${num_0}, num_1=${num_1}")
    endforeach()
    
    foreach(en ba IN ZIP_LISTS English Bahasa)
        message(STATUS "en=${en}, ba=${ba}")
    endforeach()
    .ft P
.UNINDENT
.UNINDENT

yields
.INDENT 0.0
.INDENT 3.5

    .ft C
    -- num_0=one, num_1=satu
    -- num_0=two, num_1=dua
    -- num_0=three, num_1=tiga
    -- num_0=four, num_1=
    -- en=one, ba=satu
    -- en=two, ba=dua
    -- en=three, ba=tiga
    -- en=four, ba=
    .ft P
.UNINDENT
.UNINDENT

<a name="function"></a>

### function


Start recording a function for later invocation as a command.
.INDENT 0.0
.INDENT 3.5

    .ft C
    function(<name> [<arg1> ...])
      <commands>
    endfunction()
    .ft P
.UNINDENT
.UNINDENT

Defines a function named **&lt;name&gt;** that takes arguments named
**&lt;arg1&gt;**, …  The **&lt;commands&gt;** in the function definition
are recorded; they are not executed until the function is invoked.

Per legacy, the **endfunction()** command admits an optional
**&lt;name&gt;** argument. If used, it must be a verbatim repeat of the
argument of the opening **function** command.

A function opens a new scope: see **set(var PARENT\_SCOPE)** for
details.

See the **cmake\_policy()** command documentation for the behavior
of policies inside functions.

See the **macro()** command documentation for differences
between CMake functions and macros.

<a name="invocation"></a>

### Invocation


The function invocation is case-insensitive. A function defined as
.INDENT 0.0
.INDENT 3.5

    .ft C
    function(foo)
      <commands>
    endfunction()
    .ft P
.UNINDENT
.UNINDENT

can be invoked through any of
.INDENT 0.0
.INDENT 3.5

    .ft C
    foo()
    Foo()
    FOO()
    .ft P
.UNINDENT
.UNINDENT

and so on. However, it is strongly recommended to stay with the
case chosen in the function definition. Typically functions use
all-lowercase names.

<a name="arguments"></a>

### Arguments


When the function is invoked, the recorded **&lt;commands&gt;** are first
modified by replacing formal parameters (**${arg1}**, …) with the
arguments passed, and then invoked as normal commands.

In addition to referencing the formal parameters you can reference the
**ARGC** variable which will be set to the number of arguments passed
into the function as well as **ARGV0**, **ARGV1**, **ARGV2**, …  which
will have the actual values of the arguments passed in.  This facilitates
creating functions with optional arguments.

Furthermore, **ARGV** holds the list of all arguments given to the
function and **ARGN** holds the list of arguments past the last expected
argument.  Referencing to **ARGV#** arguments beyond **ARGC** have
undefined behavior.  Checking that **ARGC** is greater than **#** is
the only way to ensure that **ARGV#** was passed to the function as an
extra argument.

<a name="get_cmake_property"></a>

### get_cmake_property


Get a global property of the CMake instance.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_cmake_property(<var> <property>)
    .ft P
.UNINDENT
.UNINDENT

Gets a global property from the CMake instance.  The value of
the **&lt;property&gt;** is stored in the variable **&lt;var&gt;**.
If the property is not found, **&lt;var&gt;** will be set to **NOTFOUND**.
See the **cmake-properties(7)** manual for available properties.

See also the **get\_property()** command **GLOBAL** option.

In addition to global properties, this command (for historical reasons)
also supports the **VARIABLES** and **MACROS** directory
properties.  It also supports a special **COMPONENTS** global property that
lists the components given to the **install()** command.

<a name="get_directory_property"></a>

### get_directory_property


Get a property of **DIRECTORY** scope.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_directory_property(<variable> [DIRECTORY <dir>] <prop-name>)
    .ft P
.UNINDENT
.UNINDENT

Stores a property of directory scope in the named **&lt;variable&gt;**.
The **DIRECTORY** argument specifies another directory from which
to retrieve the property value instead of the current directory.
The specified directory must have already been traversed by CMake.

If the property is not defined for the nominated directory scope,
an empty string is returned.  In the case of **INHERITED** properties,
if the property is not found for the nominated directory scope,
the search will chain to a parent scope as described for the
**define\_property()** command.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_directory_property(<variable> [DIRECTORY <dir>]
                           DEFINITION <var-name>)
    .ft P
.UNINDENT
.UNINDENT

Get a variable definition from a directory.  This form is useful to
get a variable definition from another directory.

See also the more general **get\_property()** command.

<a name="get_filename_component"></a>

### get_filename_component


Get a specific component of a full filename.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_filename_component(<var> <FileName> <mode> [CACHE])
    .ft P
.UNINDENT
.UNINDENT

Sets **&lt;var&gt;** to a component of **&lt;FileName&gt;**, where **&lt;mode&gt;** is one of:
.INDENT 0.0
.INDENT 3.5

    .ft C
    DIRECTORY = Directory without file name
    NAME      = File name without directory
    EXT       = File name longest extension (.b.c from d/a.b.c)
    NAME_WE   = File name without directory or longest extension
    LAST_EXT  = File name last extension (.c from d/a.b.c)
    NAME_WLE  = File name without directory or last extension
    PATH      = Legacy alias for DIRECTORY (use for CMake <= 2.8.11)
    .ft P
.UNINDENT
.UNINDENT

Paths are returned with forward slashes and have no trailing slashes.
If the optional **CACHE** argument is specified, the result variable is
added to the cache.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_filename_component(<var> <FileName> <mode> [BASE_DIR <dir>] [CACHE])
    .ft P
.UNINDENT
.UNINDENT

Sets **&lt;var&gt;** to the absolute path of **&lt;FileName&gt;**, where **&lt;mode&gt;** is one
of:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ABSOLUTE  = Full path to file
    REALPATH  = Full path to existing file with symlinks resolved
    .ft P
.UNINDENT
.UNINDENT

If the provided **&lt;FileName&gt;** is a relative path, it is evaluated relative
to the given base directory **&lt;dir&gt;**.  If no base directory is
provided, the default base directory will be
**CMAKE\_CURRENT\_SOURCE\_DIR**.

Paths are returned with forward slashes and have no trailing slashes.  If the
optional **CACHE** argument is specified, the result variable is added to the
cache.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_filename_component(<var> <FileName> PROGRAM [PROGRAM_ARGS <arg_var>] [CACHE])
    .ft P
.UNINDENT
.UNINDENT

The program in **&lt;FileName&gt;** will be found in the system search path or
left as a full path.  If **PROGRAM\_ARGS** is present with **PROGRAM**, then
any command-line arguments present in the **&lt;FileName&gt;** string are split
from the program name and stored in **&lt;arg\_var&gt;**.  This is used to
separate a program name from its arguments in a command line string.

<a name="get_property"></a>

### get_property


Get a property.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_property(<variable>
                 <GLOBAL             |
                  DIRECTORY [<dir>]  |
                  TARGET    <target> |
                  SOURCE    <source> |
                  INSTALL   <file>   |
                  TEST      <test>   |
                  CACHE     <entry>  |
                  VARIABLE           >
                 PROPERTY <name>
                 [SET | DEFINED | BRIEF_DOCS | FULL_DOCS])
    .ft P
.UNINDENT
.UNINDENT

Gets one property from one object in a scope.

The first argument specifies the variable in which to store the result.
The second argument determines the scope from which to get the property.
It must be one of the following:
.INDENT 0.0

* <b>**GLOBAL**</b>  
  Scope is unique and does not accept a name.
* <b>**DIRECTORY**</b>  
  Scope defaults to the current directory but another
  directory (already processed by CMake) may be named by the
  full or relative path **&lt;dir&gt;**.
* <b>**TARGET**</b>  
  Scope must name one existing target.
* <b>**SOURCE**</b>  
  Scope must name one source file.
* <b>**INSTALL**</b>  
  Scope must name one installed file path.
* <b>**TEST**</b>  
  Scope must name one existing test.
* <b>**CACHE**</b>  
  Scope must name one cache entry.
* <b>**VARIABLE**</b>  
  Scope is unique and does not accept a name.
  .UNINDENT

The required **PROPERTY** option is immediately followed by the name of
the property to get.  If the property is not set an empty value is
returned, although some properties support inheriting from a parent scope
if defined to behave that way (see **define\_property()**).

If the **SET** option is given the variable is set to a boolean
value indicating whether the property has been set.  If the **DEFINED**
option is given the variable is set to a boolean value indicating
whether the property has been defined such as with the
**define\_property()** command.

If **BRIEF\_DOCS** or **FULL\_DOCS** is given then the variable is set to a
string containing documentation for the requested property.  If
documentation is requested for a property that has not been defined
**NOTFOUND** is returned.

<a name="if"></a>

### if


Conditionally execute a group of commands.

<a name="synopsis"></a>

### Synopsis

.INDENT 0.0
.INDENT 3.5

    .ft C
    if(<condition>)
      <commands>
    elseif(<condition>) # optional block, can be repeated
      <commands>
    else()              # optional block
      <commands>
    endif()
    .ft P
.UNINDENT
.UNINDENT

Evaluates the **condition** argument of the **if** clause according to the
_Condition syntax_ described below. If the result is true, then the
**commands** in the **if** block are executed.
Otherwise, optional **elseif** blocks are processed in the same way.
Finally, if no **condition** is true, **commands** in the optional **else**
block are executed.

Per legacy, the **else()** and **endif()** commands admit
an optional **&lt;condition&gt;** argument.
If used, it must be a verbatim
repeat of the argument of the opening
**if** command.

<a name="condition-syntax"></a>

### Condition Syntax


The following syntax applies to the **condition** argument of
the **if**, **elseif** and **while()** clauses.

Compound conditions are evaluated in the following order of precedence:
Innermost parentheses are evaluated first. Next come unary tests such
as **EXISTS**, **COMMAND**, and **DEFINED**.  Then binary tests such as
**EQUAL**, **LESS**, **LESS\_EQUAL**, **GREATER**, **GREATER\_EQUAL**,
**STREQUAL**, **STRLESS**, **STRLESS\_EQUAL**, **STRGREATER**,
**STRGREATER\_EQUAL**, **VERSION\_EQUAL**, **VERSION\_LESS**,
**VERSION\_LESS\_EQUAL**, **VERSION\_GREATER**, **VERSION\_GREATER\_EQUAL**,
and **MATCHES**.  Then the boolean operators in the order **NOT**,  **AND**,
and finally **OR**.

Possible conditions are:
.INDENT 0.0

* <b>**if(&lt;constant&gt;)**</b>  
  True if the constant is **1**, **ON**, **YES**, **TRUE**, **Y**,
  or a non-zero number.  False if the constant is **0**, **OFF**,
  **NO**, **FALSE**, **N**, **IGNORE**, **NOTFOUND**, the empty string,
  or ends in the suffix **-NOTFOUND**.  Named boolean constants are
  case-insensitive.  If the argument is not one of these specific
  constants, it is treated as a variable or string and the following
  signature is used.
* <b>**if(&lt;variable|string&gt;)**</b>  
  True if given a variable that is defined to a value that is not a false
  constant.  False otherwise.  (Note macro arguments are not variables.)
* <b>**if(NOT &lt;condition&gt;)**</b>  
  True if the condition is not true.
* <b>**if(&lt;cond1&gt; AND &lt;cond2&gt;)**</b>  
  True if both conditions would be considered true individually.
* <b>**if(&lt;cond1&gt; OR &lt;cond2&gt;)**</b>  
  True if either condition would be considered true individually.
* <b>**if(COMMAND command-name)**</b>  
  True if the given name is a command, macro or function that can be
  invoked.
* <b>**if(POLICY policy-id)**</b>  
  True if the given name is an existing policy (of the form **CMP&lt;NNNN&gt;**).
* <b>**if(TARGET target-name)**</b>  
  True if the given name is an existing logical target name created
  by a call to the **add\_executable()**, **add\_library()**,
  or **add\_custom\_target()** command that has already been invoked
  (in any directory).
* <b>**if(TEST test-name)**</b>  
  True if the given name is an existing test name created by the
  **add\_test()** command.
* <b>**if(EXISTS path-to-file-or-directory)**</b>  
  True if the named file or directory exists.  Behavior is well-defined
  only for full paths. Resolves symbolic links, i.e. if the named file or
  directory is a symbolic link, returns true if the target of the
  symbolic link exists.
* <b>**if(file1 IS_NEWER_THAN file2)**</b>  
  True if **file1** is newer than **file2** or if one of the two files doesn’t
  exist.  Behavior is well-defined only for full paths.  If the file
  time stamps are exactly the same, an **IS\_NEWER\_THAN** comparison returns
  true, so that any dependent build operations will occur in the event
  of a tie.  This includes the case of passing the same file name for
  both file1 and file2.
* <b>**if(IS_DIRECTORY path-to-directory)**</b>  
  True if the given name is a directory.  Behavior is well-defined only
  for full paths.
* <b>**if(IS_SYMLINK file-name)**</b>  
  True if the given name is a symbolic link.  Behavior is well-defined
  only for full paths.
* <b>**if(IS_ABSOLUTE path)**</b>  
  True if the given path is an absolute path.
* <b>**if(&lt;variable|string&gt; MATCHES regex)**</b>  
  True if the given string or variable’s value matches the given regular
  condition.  See Regex Specification for regex format.
  **()** groups are captured in **CMAKE\_MATCH\_&lt;n&gt;** variables.
* <b>**if(&lt;variable|string&gt; LESS &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is a valid number and less
  than that on the right.
* <b>**if(&lt;variable|string&gt; GREATER &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is a valid number and greater
  than that on the right.
* <b>**if(&lt;variable|string&gt; EQUAL &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is a valid number and equal
  to that on the right.
* <b>**if(&lt;variable|string&gt; LESS_EQUAL &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is a valid number and less
  than or equal to that on the right.
* <b>**if(&lt;variable|string&gt; GREATER_EQUAL &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is a valid number and greater
  than or equal to that on the right.
* <b>**if(&lt;variable|string&gt; STRLESS &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is lexicographically less
  than the string or variable on the right.
* <b>**if(&lt;variable|string&gt; STRGREATER &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is lexicographically greater
  than the string or variable on the right.
* <b>**if(&lt;variable|string&gt; STREQUAL &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is lexicographically equal
  to the string or variable on the right.
* <b>**if(&lt;variable|string&gt; STRLESS_EQUAL &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is lexicographically less
  than or equal to the string or variable on the right.
* <b>**if(&lt;variable|string&gt; STRGREATER_EQUAL &lt;variable|string&gt;)**</b>  
  True if the given string or variable’s value is lexicographically greater
  than or equal to the string or variable on the right.
* <b>**if(&lt;variable|string&gt; VERSION_LESS &lt;variable|string&gt;)**</b>  
  Component-wise integer version number comparison (version format is
  **major[.minor[.patch[.tweak]]]**, omitted components are treated as zero).
  Any non-integer version component or non-integer trailing part of a version
  component effectively truncates the string at that point.
* <b>**if(&lt;variable|string&gt; VERSION_GREATER &lt;variable|string&gt;)**</b>  
  Component-wise integer version number comparison (version format is
  **major[.minor[.patch[.tweak]]]**, omitted components are treated as zero).
  Any non-integer version component or non-integer trailing part of a version
  component effectively truncates the string at that point.
* <b>**if(&lt;variable|string&gt; VERSION_EQUAL &lt;variable|string&gt;)**</b>  
  Component-wise integer version number comparison (version format is
  **major[.minor[.patch[.tweak]]]**, omitted components are treated as zero).
  Any non-integer version component or non-integer trailing part of a version
  component effectively truncates the string at that point.
* <b>**if(&lt;variable|string&gt; VERSION_LESS_EQUAL &lt;variable|string&gt;)**</b>  
  Component-wise integer version number comparison (version format is
  **major[.minor[.patch[.tweak]]]**, omitted components are treated as zero).
  Any non-integer version component or non-integer trailing part of a version
  component effectively truncates the string at that point.
* <b>**if(&lt;variable|string&gt; VERSION_GREATER_EQUAL &lt;variable|string&gt;)**</b>  
  Component-wise integer version number comparison (version format is
  **major[.minor[.patch[.tweak]]]**, omitted components are treated as zero).
  Any non-integer version component or non-integer trailing part of a version
  component effectively truncates the string at that point.
* <b>**if(&lt;variable|string&gt; IN_LIST &lt;variable&gt;)**</b>  
  True if the given element is contained in the named list variable.
* <b>**if(DEFINED &lt;name&gt;|CACHE{&lt;name&gt;}|ENV{&lt;name&gt;})**</b>  
  True if a variable, cache variable or environment variable
  with given **&lt;name&gt;** is defined. The value of the variable
  does not matter. Note that macro arguments are not variables.
* <b>**if((condition) AND (condition OR (condition)))**</b>  
  The conditions inside the parenthesis are evaluated first and then
  the remaining condition is evaluated as in the previous examples.
  Where there are nested parenthesis the innermost are evaluated as part
  of evaluating the condition that contains them.
  .UNINDENT

<a name="variable-expansion"></a>

### Variable Expansion


The if command was written very early in CMake’s history, predating
the **${}** variable evaluation syntax, and for convenience evaluates
variables named by its arguments as shown in the above signatures.
Note that normal variable evaluation with **${}** applies before the if
command even receives the arguments.  Therefore code like
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(var1 OFF)
    set(var2 "var1")
    if(${var2})
    .ft P
.UNINDENT
.UNINDENT

appears to the if command as
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(var1)
    .ft P
.UNINDENT
.UNINDENT

and is evaluated according to the **if(&lt;variable&gt;)** case documented
above.  The result is **OFF** which is false.  However, if we remove the
**${}** from the example then the command sees
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(var2)
    .ft P
.UNINDENT
.UNINDENT

which is true because **var2** is defined to **var1** which is not a false
constant.

Automatic evaluation applies in the other cases whenever the
above-documented condition syntax accepts **&lt;variable|string&gt;**:
.INDENT 0.0

* ·  
  The left hand argument to **MATCHES** is first checked to see if it is
  a defined variable, if so the variable’s value is used, otherwise the
  original value is used.
* ·  
  If the left hand argument to **MATCHES** is missing it returns false
  without error
* ·  
  Both left and right hand arguments to **LESS**, **GREATER**, **EQUAL**,
  **LESS\_EQUAL**, and **GREATER\_EQUAL**, are independently tested to see if
  they are defined variables, if so their defined values are used otherwise
  the original value is used.
* ·  
  Both left and right hand arguments to **STRLESS**, **STRGREATER**,
  **STREQUAL**, **STRLESS\_EQUAL**, and **STRGREATER\_EQUAL** are independently
  tested to see if they are defined variables, if so their defined values are
  used otherwise the original value is used.
* ·  
  Both left and right hand arguments to **VERSION\_LESS**,
  **VERSION\_GREATER**, **VERSION\_EQUAL**, **VERSION\_LESS\_EQUAL**, and
  **VERSION\_GREATER\_EQUAL** are independently tested to see if they are defined
  variables, if so their defined values are used otherwise the original value
  is used.
* ·  
  The right hand argument to **NOT** is tested to see if it is a boolean
  constant, if so the value is used, otherwise it is assumed to be a
  variable and it is dereferenced.
* ·  
  The left and right hand arguments to **AND** and **OR** are independently
  tested to see if they are boolean constants, if so they are used as
  such, otherwise they are assumed to be variables and are dereferenced.
  .UNINDENT

To prevent ambiguity, potential variable or keyword names can be
specified in a Quoted Argument or a Bracket Argument.
A quoted or bracketed variable or keyword will be interpreted as a
string and not dereferenced or interpreted.
See policy **CMP0054**.

There is no automatic evaluation for environment or cache
Variable References.  Their values must be referenced as
**$ENV{&lt;name&gt;}** or **$CACHE{&lt;name&gt;}** wherever the above-documented
condition syntax accepts **&lt;variable|string&gt;**.

<a name="include"></a>

### include


Load and run CMake code from a file or module.
.INDENT 0.0
.INDENT 3.5

    .ft C
    include(<file|module> [OPTIONAL] [RESULT_VARIABLE <var>]
                          [NO_POLICY_SCOPE])
    .ft P
.UNINDENT
.UNINDENT

Loads and runs CMake code from the file given.  Variable reads and
writes access the scope of the caller (dynamic scoping).  If **OPTIONAL**
is present, then no error is raised if the file does not exist.  If
**RESULT\_VARIABLE** is given the variable **&lt;var&gt;** will be set to the
full filename which has been included or **NOTFOUND** if it failed.

If a module is specified instead of a file, the file with name
**&lt;modulename&gt;.cmake** is searched first in **CMAKE\_MODULE\_PATH**,
then in the CMake module directory.  There is one exception to this: if
the file which calls **include()** is located itself in the CMake builtin
module directory, then first the CMake builtin module directory is searched and
**CMAKE\_MODULE\_PATH** afterwards.  See also policy **CMP0017**.

See the **cmake\_policy()** command documentation for discussion of the
**NO\_POLICY\_SCOPE** option.

<a name="include_guard"></a>

### include_guard


Provides an include guard for the file currently being processed by CMake.
.INDENT 0.0
.INDENT 3.5

    .ft C
    include_guard([DIRECTORY|GLOBAL])
    .ft P
.UNINDENT
.UNINDENT

Sets up an include guard for the current CMake file (see the
**CMAKE\_CURRENT\_LIST\_FILE** variable documentation).

CMake will end its processing of the current file at the location of the
_include\_guard()_ command if the current file has already been
processed for the applicable scope (see below). This provides functionality
similar to the include guards commonly used in source headers or to the
**#pragma once** directive. If the current file has been processed previously
for the applicable scope, the effect is as though **return()** had been
called. Do not call this command from inside a function being defined within
the current file.

An optional argument specifying the scope of the guard may be provided.
Possible values for the option are:
.INDENT 0.0

* <b>**DIRECTORY**</b>  
  The include guard applies within the current directory and below. The file
  will only be included once within this directory scope, but may be included
  again by other files outside of this directory (i.e. a parent directory or
  another directory not pulled in by **add\_subdirectory()** or
  **include()** from the current file or its children).
* <b>**GLOBAL**</b>  
  The include guard applies globally to the whole build. The current file
  will only be included once regardless of the scope.
  .UNINDENT

If no arguments given, **include\_guard** has the same scope as a variable,
meaning that the include guard effect is isolated by the most recent
function scope or current directory if no inner function scopes exist.
In this case the command behavior is the same as:
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(__CURRENT_FILE_VAR__)
      return()
    endif()
    set(__CURRENT_FILE_VAR__ TRUE)
    .ft P
.UNINDENT
.UNINDENT

<a name="list"></a>

### list


List operations.

<a name="synopsis"></a>

### Synopsis

.INDENT 0.0
.INDENT 3.5

    .ft C
    Reading
      list(LENGTH <list> <out-var>)
      list(GET <list> <element index> [<index> ...] <out-var>)
      list(JOIN <list> <glue> <out-var>)
      list(SUBLIST <list> <begin> <length> <out-var>)
    
    Search
      list(FIND <list> <value> <out-var>)
    
    Modification
      list(APPEND <list> [<element>...])
      list(FILTER <list> {INCLUDE | EXCLUDE} REGEX <regex>)
      list(INSERT <list> <index> [<element>...])
      list(POP_BACK <list> [<out-var>...])
      list(POP_FRONT <list> [<out-var>...])
      list(PREPEND <list> [<element>...])
      list(REMOVE_ITEM <list> <value>...)
      list(REMOVE_AT <list> <index>...)
      list(REMOVE_DUPLICATES <list>)
      list(TRANSFORM <list> <ACTION> [...])
    
    Ordering
      list(REVERSE <list>)
      list(SORT <list> [...])
    .ft P
.UNINDENT
.UNINDENT

<a name="introduction"></a>

### Introduction


The list subcommands **APPEND**, **INSERT**, **FILTER**, **PREPEND**,
**POP\_BACK**, **POP\_FRONT**, **REMOVE\_AT**, **REMOVE\_ITEM**,
**REMOVE\_DUPLICATES**, **REVERSE** and **SORT** may create
new values for the list within the current CMake variable scope.  Similar to
the **set()** command, the LIST command creates new variable values in
the current scope, even if the list itself is actually defined in a parent
scope.  To propagate the results of these operations upwards, use
**set()** with **PARENT\_SCOPE**, **set()** with
**CACHE INTERNAL**, or some other means of value propagation.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
A list in cmake is a **;** separated group of strings.  To create a
list the set command can be used.  For example, **set(var a b c d e)**
creates a list with **a;b;c;d;e**, and **set(var "a b c d e")** creates a
string or a list with one item in it.   (Note macro arguments are not
variables, and therefore cannot be used in LIST commands.)
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
When specifying index values, if **&lt;element index&gt;** is 0 or greater, it
is indexed from the beginning of the list, with 0 representing the
first list element.  If **&lt;element index&gt;** is -1 or lesser, it is indexed
from the end of the list, with -1 representing the last list element.
Be careful when counting with negative indices: they do not start from
0.  -0 is equivalent to 0, the first list element.
.UNINDENT
.UNINDENT

<a name="reading"></a>

### Reading

.INDENT 0.0
.INDENT 3.5

    .ft C
    list(LENGTH <list> <output variable>)
    .ft P
.UNINDENT
.UNINDENT

Returns the list’s length.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(GET <list> <element index> [<element index> ...] <output variable>)
    .ft P
.UNINDENT
.UNINDENT

Returns the list of elements specified by indices from the list.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(JOIN <list> <glue> <output variable>)
    .ft P
.UNINDENT
.UNINDENT

Returns a string joining all list’s elements using the glue string.
To join multiple strings, which are not part of a list, use **JOIN** operator
from **string()** command.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(SUBLIST <list> <begin> <length> <output variable>)
    .ft P
.UNINDENT
.UNINDENT

Returns a sublist of the given list.
If **&lt;length&gt;** is 0, an empty list will be returned.
If **&lt;length&gt;** is -1 or the list is smaller than **&lt;begin&gt;+&lt;length&gt;** then
the remaining elements of the list starting at **&lt;begin&gt;** will be returned.

<a name="search"></a>

### Search

.INDENT 0.0
.INDENT 3.5

    .ft C
    list(FIND <list> <value> <output variable>)
    .ft P
.UNINDENT
.UNINDENT

Returns the index of the element specified in the list or -1
if it wasn’t found.

<a name="modification"></a>

### Modification

.INDENT 0.0
.INDENT 3.5

    .ft C
    list(APPEND <list> [<element> ...])
    .ft P
.UNINDENT
.UNINDENT

Appends elements to the list.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(FILTER <list> <INCLUDE|EXCLUDE> REGEX <regular_expression>)
    .ft P
.UNINDENT
.UNINDENT

Includes or removes items from the list that match the mode’s pattern.
In **REGEX** mode, items will be matched against the given regular expression.

For more information on regular expressions see also the
**string()** command.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(INSERT <list> <element_index> <element> [<element> ...])
    .ft P
.UNINDENT
.UNINDENT

Inserts elements to the list to the specified location.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(POP_BACK <list> [<out-var>...])
    .ft P
.UNINDENT
.UNINDENT

If no variable name is given, removes exactly one element. Otherwise,
assign the last element’s value to the given variable and removes it,
up to the last variable name given.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(POP_FRONT <list> [<out-var>...])
    .ft P
.UNINDENT
.UNINDENT

If no variable name is given, removes exactly one element. Otherwise,
assign the first element’s value to the given variable and removes it,
up to the last variable name given.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(PREPEND <list> [<element> ...])
    .ft P
.UNINDENT
.UNINDENT

Insert elements to the 0th position in the list.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(REMOVE_ITEM <list> <value> [<value> ...])
    .ft P
.UNINDENT
.UNINDENT

Removes all instances of the given items from the list.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(REMOVE_AT <list> <index> [<index> ...])
    .ft P
.UNINDENT
.UNINDENT

Removes items at given indices from the list.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(REMOVE_DUPLICATES <list>)
    .ft P
.UNINDENT
.UNINDENT

Removes duplicated items in the list. The relative order of items is preserved,
but if duplicates are encountered, only the first instance is preserved.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> <ACTION> [<SELECTOR>]
                          [OUTPUT_VARIABLE <output variable>])
    .ft P
.UNINDENT
.UNINDENT

Transforms the list by applying an action to all or, by specifying a
**&lt;SELECTOR&gt;**, to the selected elements of the list, storing the result
in-place or in the specified output variable.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **TRANSFORM** sub-command does not change the number of elements in the
list. If a **&lt;SELECTOR&gt;** is specified, only some elements will be changed,
the other ones will remain the same as before the transformation.
.UNINDENT
.UNINDENT

**&lt;ACTION&gt;** specifies the action to apply to the elements of the list.
The actions have exactly the same semantics as sub-commands of the
**string()** command.  **&lt;ACTION&gt;** must be one of the following:

**APPEND**, **PREPEND**: Append, prepend specified value to each element of
the list.
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> <APPEND|PREPEND> <value> ...)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

**TOUPPER**, **TOLOWER**: Convert each element of the list to upper, lower
characters.
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> <TOLOWER|TOUPPER> ...)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

**STRIP**: Remove leading and trailing spaces from each element of the
list.
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> STRIP ...)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

**GENEX\_STRIP**: Strip any
**generator expressions** from each
element of the list.
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> GENEX_STRIP ...)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

**REPLACE**: Match the regular expression as many times as possible and
substitute the replacement expression for the match for each element
of the list
(Same semantic as **REGEX REPLACE** from **string()** command).
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> REPLACE <regular_expression>
                                  <replace_expression> ...)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

**&lt;SELECTOR&gt;** determines which elements of the list will be transformed.
Only one type of selector can be specified at a time.  When given,
**&lt;SELECTOR&gt;** must be one of the following:

**AT**: Specify a list of indexes.
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> <ACTION> AT <index> [<index> ...] ...)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

**FOR**: Specify a range with, optionally, an increment used to iterate over
the range.
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> <ACTION> FOR <start> <stop> [<step>] ...)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

**REGEX**: Specify a regular expression. Only elements matching the regular
expression will be transformed.
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(TRANSFORM <list> <ACTION> REGEX <regular_expression> ...)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

<a name="ordering"></a>

### Ordering

.INDENT 0.0
.INDENT 3.5

    .ft C
    list(REVERSE <list>)
    .ft P
.UNINDENT
.UNINDENT

Reverses the contents of the list in-place.
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(SORT <list> [COMPARE <compare>] [CASE <case>] [ORDER <order>])
    .ft P
.UNINDENT
.UNINDENT

Sorts the list in-place alphabetically.
Use the **COMPARE** keyword to select the comparison method for sorting.
The **&lt;compare&gt;** option should be one of:
.INDENT 0.0

* ·  
  **STRING**: Sorts a list of strings alphabetically.  This is the
  default behavior if the **COMPARE** option is not given.
* ·  
  **FILE\_BASENAME**: Sorts a list of pathnames of files by their basenames.
  .UNINDENT

Use the **CASE** keyword to select a case sensitive or case insensitive
sort mode.  The **&lt;case&gt;** option should be one of:
.INDENT 0.0

* ·  
  **SENSITIVE**: List items are sorted in a case-sensitive manner.  This is
  the default behavior if the **CASE** option is not given.
* ·  
  **INSENSITIVE**: List items are sorted case insensitively.  The order of
  items which differ only by upper/lowercase is not specified.
  .UNINDENT

To control the sort order, the **ORDER** keyword can be given.
The **&lt;order&gt;** option should be one of:
.INDENT 0.0

* ·  
  **ASCENDING**: Sorts the list in ascending order.  This is the default
  behavior when the **ORDER** option is not given.
* ·  
  **DESCENDING**: Sorts the list in descending order.
  .UNINDENT

<a name="macro"></a>

### macro


Start recording a macro for later invocation as a command
.INDENT 0.0
.INDENT 3.5

    .ft C
    macro(<name> [<arg1> ...])
      <commands>
    endmacro()
    .ft P
.UNINDENT
.UNINDENT

Defines a macro named **&lt;name&gt;** that takes arguments named
**&lt;arg1&gt;**, … Commands listed after macro, but before the
matching **endmacro()**, are not executed until the macro
is invoked.

Per legacy, the **endmacro()** command admits an optional
**&lt;name&gt;** argument. If used, it must be a verbatim repeat of the
argument of the opening **macro** command.

See the **cmake\_policy()** command documentation for the behavior
of policies inside macros.

See the _Macro vs Function_ section below for differences
between CMake macros and **functions**.

<a name="invocation"></a>

### Invocation


The macro invocation is case-insensitive. A macro defined as
.INDENT 0.0
.INDENT 3.5

    .ft C
    macro(foo)
      <commands>
    endmacro()
    .ft P
.UNINDENT
.UNINDENT

can be invoked through any of
.INDENT 0.0
.INDENT 3.5

    .ft C
    foo()
    Foo()
    FOO()
    .ft P
.UNINDENT
.UNINDENT

and so on. However, it is strongly recommended to stay with the
case chosen in the macro definition.  Typically macros use
all-lowercase names.

<a name="arguments"></a>

### Arguments


When a macro is invoked, the commands recorded in the macro are
first modified by replacing formal parameters (**${arg1}**, …)
with the arguments passed, and then invoked as normal commands.

In addition to referencing the formal parameters you can reference the
values **${ARGC}** which will be set to the number of arguments passed
into the function as well as **${ARGV0}**, **${ARGV1}**, **${ARGV2}**,
…  which will have the actual values of the arguments passed in.
This facilitates creating macros with optional arguments.

Furthermore, **${ARGV}** holds the list of all arguments given to the
macro and **${ARGN}** holds the list of arguments past the last expected
argument.
Referencing to **${ARGV#}** arguments beyond **${ARGC}** have undefined
behavior. Checking that **${ARGC}** is greater than **#** is the only
way to ensure that **${ARGV#}** was passed to the function as an extra
argument.

<a name="macro-vs-function"></a>

### Macro vs Function


The **macro** command is very similar to the **function()** command.
Nonetheless, there are a few important differences.

In a function, **ARGN**, **ARGC**, **ARGV** and **ARGV0**, **ARGV1**, …
are true variables in the usual CMake sense.  In a macro, they are not,
they are string replacements much like the C preprocessor would do
with a macro.  This has a number of consequences, as explained in
the _Argument Caveats_ section below.

Another difference between macros and functions is the control flow.
A function is executed by transferring control from the calling
statement to the function body.  A macro is executed as if the macro
body were pasted in place of the calling statement.  This has the
consequence that a **return()** in a macro body does not
just terminate execution of the macro; rather, control is returned
from the scope of the macro call.  To avoid confusion, it is recommended
to avoid **return()** in macros altogether.

Unlike a function, the **CMAKE\_CURRENT\_FUNCTION**,
**CMAKE\_CURRENT\_FUNCTION\_LIST\_DIR**,
**CMAKE\_CURRENT\_FUNCTION\_LIST\_FILE**,
**CMAKE\_CURRENT\_FUNCTION\_LIST\_LINE** variables are not
set for a macro.

<a name="argument-caveats"></a>

### Argument Caveats


Since **ARGN**, **ARGC**, **ARGV**, **ARGV0** etc. are not variables,
you will NOT be able to use commands like
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(ARGV1) # ARGV1 is not a variable
    if(DEFINED ARGV2) # ARGV2 is not a variable
    if(ARGC GREATER 2) # ARGC is not a variable
    foreach(loop_var IN LISTS ARGN) # ARGN is not a variable
    .ft P
.UNINDENT
.UNINDENT

In the first case, you can use **if(${ARGV1})**.  In the second and
third case, the proper way to check if an optional variable was
passed to the macro is to use **if(${ARGC} GREATER 2)**.  In the
last case, you can use **foreach(loop_var ${ARGN})** but this will
skip empty arguments.  If you need to include them, you can use
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(list_var "${ARGN}")
    foreach(loop_var IN LISTS list_var)
    .ft P
.UNINDENT
.UNINDENT

Note that if you have a variable with the same name in the scope from
which the macro is called, using unreferenced names will use the
existing variable instead of the arguments. For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    macro(bar)
      foreach(arg IN LISTS ARGN)
        <commands>
      endforeach()
    endmacro()
    
    function(foo)
      bar(x y z)
    endfunction()
    
    foo(a b c)
    .ft P
.UNINDENT
.UNINDENT

Will loop over **a;b;c** and not over **x;y;z** as one might have expected.
If you want true CMake variables and/or better CMake scope control you
should look at the function command.

<a name="mark_as_advanced"></a>

### mark_as_advanced


Mark cmake cached variables as advanced.
.INDENT 0.0
.INDENT 3.5

    .ft C
    mark_as_advanced([CLEAR|FORCE] <var1> ...)
    .ft P
.UNINDENT
.UNINDENT

Sets the advanced/non-advanced state of the named
cached variables.

An advanced variable will not be displayed in any
of the cmake GUIs unless the **show advanced** option is on.
In script mode, the advanced/non-advanced state has no effect.

If the keyword **CLEAR** is given
then advanced variables are changed back to unadvanced.
If the keyword **FORCE** is given
then the variables are made advanced.
If neither **FORCE** nor **CLEAR** is specified,
new values will be marked as advanced, but if a
variable already has an advanced/non-advanced state,
it will not be changed.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Policy **CMP0102** affects the behavior of the **mark\_as\_advanced**
call. When set to **NEW**, variables passed to this command which are not
already in the cache are ignored. See policy **CMP0102**.
.UNINDENT
.UNINDENT

<a name="math"></a>

### math


Evaluate a mathematical expression.
.INDENT 0.0
.INDENT 3.5

    .ft C
    math(EXPR <variable> "<expression>" [OUTPUT_FORMAT <format>])
    .ft P
.UNINDENT
.UNINDENT

Evaluates a mathematical **&lt;expression&gt;** and sets **&lt;variable&gt;** to the
resulting value.  The result of the expression must be representable as a
64-bit signed integer.

The mathematical expression must be given as a string (i.e. enclosed in
double quotation marks). An example is **"5 * (10 + 13)"**.
Supported operators are **+**, **-**, ***, /**, **%**, **|**, **&**,
**^**, **~**, **&lt;&lt;**, **&gt;&gt;**, and **(...)**; they have the same meaning
as in C code.

Hexadecimal numbers are recognized when prefixed with **0x**, as in C code.

The result is formatted according to the option **OUTPUT\_FORMAT**,
where **&lt;format&gt;** is one of
.INDENT 0.0

* <b>**HEXADECIMAL**</b>  
  Hexadecimal notation as in C code, i. e. starting with “0x”.
* <b>**DECIMAL**</b>  
  Decimal notation. Which is also used if no **OUTPUT\_FORMAT** option
  is specified.
  .UNINDENT

For example
.INDENT 0.0
.INDENT 3.5

    .ft C
    math(EXPR value "100 * 0xA" OUTPUT_FORMAT DECIMAL)      # value is set to "1000"
    math(EXPR value "100 * 0xA" OUTPUT_FORMAT HEXADECIMAL)  # value is set to "0x3e8"
    .ft P
.UNINDENT
.UNINDENT

<a name="message"></a>

### message


Log a message.

<a name="synopsis"></a>

### Synopsis

.INDENT 0.0
.INDENT 3.5

    .ft C
    General messages
      message([<mode>] "message text" ...)
    
    Reporting checks
      message(<checkState> "message text" ...)
    .ft P
.UNINDENT
.UNINDENT

<a name="general-messages"></a>

### General messages

.INDENT 0.0
.INDENT 3.5

    .ft C
    message([<mode>] "message text" ...)
    .ft P
.UNINDENT
.UNINDENT

Record the specified message text in the log.  If more than one message
string is given, they are concatenated into a single message with no
separator between the strings.

The optional **&lt;mode&gt;** keyword determines the type of message, which
influences the way the message is handled:
.INDENT 0.0

* <b>**FATAL\_ERROR**</b>  
  CMake Error, stop processing and generation.
* <b>**SEND\_ERROR**</b>  
  CMake Error, continue processing, but skip generation.
* <b>**WARNING**</b>  
  CMake Warning, continue processing.
* <b>**AUTHOR\_WARNING**</b>  
  CMake Warning (dev), continue processing.
* <b>**DEPRECATION**</b>  
  CMake Deprecation Error or Warning if variable
  **CMAKE\_ERROR\_DEPRECATED** or **CMAKE\_WARN\_DEPRECATED**
  is enabled, respectively, else no message.
* **(none) or **NOTICE****  
  Important message printed to stderr to attract user’s attention.
* <b>**STATUS**</b>  
  The main interesting messages that project users might be interested in.
  Ideally these should be concise, no more than a single line, but still
  informative.
* <b>**VERBOSE**</b>  
  Detailed informational messages intended for project users.  These messages
  should provide additional details that won’t be of interest in most cases,
  but which may be useful to those building the project when they want deeper
  insight into what’s happening.
* <b>**DEBUG**</b>  
  Detailed informational messages intended for developers working on the
  project itself as opposed to users who just want to build it.  These messages
  will not typically be of interest to other users building the project and
  will often be closely related to internal implementation details.
* <b>**TRACE**</b>  
  Fine-grained messages with very low-level implementation details.  Messages
  using this log level would normally only be temporary and would expect to be
  removed before releasing the project, packaging up the files, etc.
  .UNINDENT

The CMake command-line tool displays **STATUS** to **TRACE** messages on stdout
with the message preceded by two hyphens and a space.  All other message types
are sent to stderr and are not prefixed with hyphens.  The
**CMake GUI** displays all messages in its log area.
The **curses interface** shows **STATUS** to **TRACE**
messages one at a time on a status line and other messages in an
interactive pop-up box.  The **--log-level** command-line option to each of
these tools can be used to control which messages will be shown.
To make a log level persist between CMake runs, the
**CMAKE\_MESSAGE\_LOG\_LEVEL** variable can be set instead.
Note that the command line option takes precedence over the cache variable.

Messages of log levels **NOTICE** and below will have each line preceded
by the content of the **CMAKE\_MESSAGE\_INDENT** variable (converted to
a single string by concatenating its list items).  For **STATUS** to **TRACE**
messages, this indenting content will be inserted after the hyphens.

Messages of log levels **NOTICE** and below can also have each line preceded
with context of the form **[some.context.example]**.  The content between the
square brackets is obtained by converting the **CMAKE\_MESSAGE\_CONTEXT**
list variable to a dot-separated string.  The message context will always
appear before any indenting content but after any automatically added leading
hyphens. By default, message context is not shown, it has to be explicitly
enabled by giving the **cmake** **--log-context**
command-line option or by setting the **CMAKE\_MESSAGE\_CONTEXT\_SHOW**
variable to true.  See the **CMAKE\_MESSAGE\_CONTEXT** documentation for
usage examples.

CMake Warning and Error message text displays using a simple markup
language.  Non-indented text is formatted in line-wrapped paragraphs
delimited by newlines.  Indented text is considered pre-formatted.

<a name="reporting-checks"></a>

### Reporting checks


A common pattern in CMake output is a message indicating the start of some
sort of check, followed by another message reporting the result of that check.
For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    message(STATUS "Looking for someheader.h")
    #... do the checks, set checkSuccess with the result
    if(checkSuccess)
      message(STATUS "Looking for someheader.h - found")
    else()
      message(STATUS "Looking for someheader.h - not found")
    endif()
    .ft P
.UNINDENT
.UNINDENT

This can be more robustly and conveniently expressed using the **CHECK\_...**
keyword form of the **message()** command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    message(<checkState> "message" ...)
    .ft P
.UNINDENT
.UNINDENT

where **&lt;checkState&gt;** must be one of the following:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* <b>**CHECK\_START**</b>  
  Record a concise message about the check about to be performed.
* <b>**CHECK\_PASS**</b>  
  Record a successful result for a check.
* <b>**CHECK\_FAIL**</b>  
  Record an unsuccessful result for a check.
  .UNINDENT
  .UNINDENT
  .UNINDENT

When recording a check result, the command repeats the message from the most
recently started check for which no result has yet been reported, then some
separator characters and then the message text provided after the
**CHECK\_PASS** or **CHECK\_FAIL** keyword.  Check messages are always reported
at **STATUS** log level.

Checks may be nested and every **CHECK\_START** should have exactly one
matching **CHECK\_PASS** or **CHECK\_FAIL**.
The **CMAKE\_MESSAGE\_INDENT** variable can also be used to add
indenting to nested checks if desired.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    message(CHECK_START "Finding my things")
    list(APPEND CMAKE_MESSAGE_INDENT "  ")
    unset(missingComponents)
    
    message(CHECK_START "Finding partA")
    # ... do check, assume we find A
    message(CHECK_PASS "found")
    
    message(CHECK_START "Finding partB")
    # ... do check, assume we don't find B
    list(APPEND missingComponents B)
    message(CHECK_FAIL "not found")
    
    list(POP_BACK CMAKE_MESSAGE_INDENT)
    if(missingComponents)
      message(CHECK_FAIL "missing components: ${missingComponents}")
    else()
      message(CHECK_PASS "all components found")
    endif()
    .ft P
.UNINDENT
.UNINDENT

Output from the above would appear something like the following:
.INDENT 0.0
.INDENT 3.5

    .ft C
    -- Finding my things
    --   Finding partA
    --   Finding partA - found
    --   Finding partB
    --   Finding partB - not found
    -- Finding my things - missing components: B
    .ft P
.UNINDENT
.UNINDENT

<a name="option"></a>

### option


Provide an option that the user can optionally select.
.INDENT 0.0
.INDENT 3.5

    .ft C
    option(<variable> "<help_text>" [value])
    .ft P
.UNINDENT
.UNINDENT

Provides an option for the user to select as **ON** or **OFF**.
If no initial **&lt;value&gt;** is provided, **OFF** is used.
If **&lt;variable&gt;** is already set as a normal variable
then the command does nothing (see policy **CMP0077**).

If you have options that depend on the values of other options, see
the module help for **CMakeDependentOption**.

<a name="return"></a>

### return


Return from a file, directory or function.
.INDENT 0.0
.INDENT 3.5

    .ft C
    return()
    .ft P
.UNINDENT
.UNINDENT

Returns from a file, directory or function.  When this command is
encountered in an included file (via **include()** or
**find\_package()**), it causes processing of the current file to stop
and control is returned to the including file.  If it is encountered in a
file which is not included by another file, e.g.  a **CMakeLists.txt**,
control is returned to the parent directory if there is one.  If return is
called in a function, control is returned to the caller of the function.

Note that a **macro**, unlike a **function**,
is expanded in place and therefore cannot handle **return()**.

<a name="separate_arguments"></a>

### separate_arguments


Parse command-line arguments into a semicolon-separated list.
.INDENT 0.0
.INDENT 3.5

    .ft C
    separate_arguments(<variable> <mode> <args>)
    .ft P
.UNINDENT
.UNINDENT

Parses a space-separated string **&lt;args&gt;** into a list of items,
and stores this list in semicolon-separated standard form in **&lt;variable&gt;**.

This function is intended for parsing command-line arguments.
The entire command line must be passed as one string in the
argument **&lt;args&gt;**.

The exact parsing rules depend on the operating system.
They are specified by the **&lt;mode&gt;** argument which must
be one of the following keywords:
.INDENT 0.0

* <b>**UNIX\_COMMAND**</b>  
  Arguments are separated by by unquoted whitespace.
  Both single-quote and double-quote pairs are respected.
  A backslash escapes the next literal character (**\e"** is **"**);
  there are no special escapes (**\en** is just **n**).
* <b>**WINDOWS\_COMMAND**</b>  
  A Windows command-line is parsed using the same
  syntax the runtime library uses to construct argv at startup.  It
  separates arguments by whitespace that is not double-quoted.
  Backslashes are literal unless they precede double-quotes.  See the
  MSDN article _Parsing C Command-Line Arguments_ for details.
* <b>**NATIVE\_COMMAND**</b>  
  Proceeds as in **WINDOWS\_COMMAND** mode if the host system is Windows.
  Otherwise proceeds as in **UNIX\_COMMAND** mode.
  .UNINDENT
  .INDENT 0.0
  .INDENT 3.5

    .ft C
    separate_arguments(<var>)
    .ft P
.UNINDENT
.UNINDENT

Convert the value of **&lt;var&gt;** to a semi-colon separated list.  All
spaces are replaced with ‘;’.  This helps with generating command
lines.

<a name="set"></a>

### set


Set a normal, cache, or environment variable to a given value.
See the cmake-language(7) variables
documentation for the scopes and interaction of normal variables
and cache entries.

Signatures of this command that specify a **&lt;value&gt;...** placeholder
expect zero or more arguments.  Multiple arguments will be joined as
a semicolon-separated list to form the actual variable
value to be set.  Zero arguments will cause normal variables to be
unset.  See the **unset()** command to unset variables explicitly.

<a name="set-normal-variable"></a>

### Set Normal Variable

.INDENT 0.0
.INDENT 3.5

    .ft C
    set(<variable> <value>... [PARENT_SCOPE])
    .ft P
.UNINDENT
.UNINDENT

Sets the given **&lt;variable&gt;** in the current function or directory scope.

If the **PARENT\_SCOPE** option is given the variable will be set in
the scope above the current scope.  Each new directory or function
creates a new scope.  This command will set the value of a variable
into the parent directory or calling function (whichever is applicable
to the case at hand). The previous state of the variable’s value stays the
same in the current scope (e.g., if it was undefined before, it is still
undefined and if it had a value, it is still that value).

<a name="set-cache-entry"></a>

### Set Cache Entry

.INDENT 0.0
.INDENT 3.5

    .ft C
    set(<variable> <value>... CACHE <type> <docstring> [FORCE])
    .ft P
.UNINDENT
.UNINDENT

Sets the given cache **&lt;variable&gt;** (cache entry).  Since cache entries
are meant to provide user-settable values this does not overwrite
existing cache entries by default.  Use the **FORCE** option to
overwrite existing entries.

The **&lt;type&gt;** must be specified as one of:
.INDENT 0.0

* <b>**BOOL**</b>  
  Boolean **ON/OFF** value.  **cmake-gui(1)** offers a checkbox.
* <b>**FILEPATH**</b>  
  Path to a file on disk.  **cmake-gui(1)** offers a file dialog.
* <b>**PATH**</b>  
  Path to a directory on disk.  **cmake-gui(1)** offers a file dialog.
* <b>**STRING**</b>  
  A line of text.  **cmake-gui(1)** offers a text field or a
  drop-down selection if the **STRINGS** cache entry
  property is set.
* <b>**INTERNAL**</b>  
  A line of text.  **cmake-gui(1)** does not show internal entries.
  They may be used to store variables persistently across runs.
  Use of this type implies **FORCE**.
  .UNINDENT

The **&lt;docstring&gt;** must be specified as a line of text providing
a quick summary of the option for presentation to **cmake-gui(1)**
users.

If the cache entry does not exist prior to the call or the **FORCE**
option is given then the cache entry will be set to the given value.
Furthermore, any normal variable binding in the current scope will
be removed to expose the newly cached value to any immediately
following evaluation.

It is possible for the cache entry to exist prior to the call but
have no type set if it was created on the **cmake(1)** command
line by a user through the **-D&lt;var&gt;=&lt;value&gt;** option without
specifying a type.  In this case the **set** command will add the
type.  Furthermore, if the **&lt;type&gt;** is **PATH** or **FILEPATH**
and the **&lt;value&gt;** provided on the command line is a relative path,
then the **set** command will treat the path as relative to the
current working directory and convert it to an absolute path.

<a name="set-environment-variable"></a>

### Set Environment Variable

.INDENT 0.0
.INDENT 3.5

    .ft C
    set(ENV{<variable>} [<value>])
    .ft P
.UNINDENT
.UNINDENT

Sets an **Environment Variable**
to the given value.
Subsequent calls of **$ENV{&lt;variable&gt;}** will return this new value.

This command affects only the current CMake process, not the process
from which CMake was called, nor the system environment at large,
nor the environment of subsequent build or test processes.

If no argument is given after **ENV{&lt;variable&gt;}** or if **&lt;value&gt;** is
an empty string, then this command will clear any existing value of the
environment variable.

Arguments after **&lt;value&gt;** are ignored. If extra arguments are found,
then an author warning is issued.

<a name="set_directory_properties"></a>

### set_directory_properties


Set properties of the current directory and subdirectories.
.INDENT 0.0
.INDENT 3.5

    .ft C
    set_directory_properties(PROPERTIES prop1 value1 [prop2 value2] ...)
    .ft P
.UNINDENT
.UNINDENT

Sets properties of the current directory and its subdirectories in key-value pairs.

See also the **set\_property(DIRECTORY)** command.

See Directory Properties for the list of properties known to CMake
and their individual documentation for the behavior of each property.

<a name="set_property"></a>

### set_property


Set a named property in a given scope.
.INDENT 0.0
.INDENT 3.5

    .ft C
    set_property(<GLOBAL                      |
                  DIRECTORY [<dir>]           |
                  TARGET    [<target1> ...]   |
                  SOURCE    [<src1> ...]      |
                  INSTALL   [<file1> ...]     |
                  TEST      [<test1> ...]     |
                  CACHE     [<entry1> ...]    >
                 [APPEND] [APPEND_STRING]
                 PROPERTY <name> [value1 ...])
    .ft P
.UNINDENT
.UNINDENT

Sets one property on zero or more objects of a scope.

The first argument determines the scope in which the property is set.
It must be one of the following:
.INDENT 0.0

* <b>**GLOBAL**</b>  
  Scope is unique and does not accept a name.
* <b>**DIRECTORY**</b>  
  Scope defaults to the current directory but another directory
  (already processed by CMake) may be named by full or relative path.
  See also the **set\_directory\_properties()** command.
* <b>**TARGET**</b>  
  Scope may name zero or more existing targets.
  See also the **set\_target\_properties()** command.
* <b>**SOURCE**</b>  
  Scope may name zero or more source files.  Note that source
  file properties are visible only to targets added in the same
  directory (**CMakeLists.txt**).
  See also the **set\_source\_files\_properties()** command.
* <b>**INSTALL**</b>  
  Scope may name zero or more installed file paths.
  These are made available to CPack to influence deployment.

Both the property key and value may use generator expressions.
Specific properties may apply to installed files and/or directories.

Path components have to be separated by forward slashes,
must be normalized and are case sensitive.

To reference the installation prefix itself with a relative path use **.**.

Currently installed file properties are only defined for
the WIX generator where the given paths are relative
to the installation prefix.

* <b>**TEST**</b>  
  Scope may name zero or more existing tests.
  See also the **set\_tests\_properties()** command.
* <b>**CACHE**</b>  
  Scope must name zero or more cache existing entries.
  .UNINDENT

The required **PROPERTY** option is immediately followed by the name of
the property to set.  Remaining arguments are used to compose the
property value in the form of a semicolon-separated list.

If the **APPEND** option is given the list is appended to any existing
property value.  If the **APPEND\_STRING** option is given the string is
appended to any existing property value as string, i.e. it results in a
longer string and not a list of strings.  When using **APPEND** or
**APPEND\_STRING** with a property defined to support **INHERITED**
behavior (see **define\_property()**), no inheriting occurs when
finding the initial value to append to.  If the property is not already
directly set in the nominated scope, the command will behave as though
**APPEND** or **APPEND\_STRING** had not been given.

See the **cmake-properties(7)** manual for a list of properties
in each scope.

<a name="site_name"></a>

### site_name


Set the given variable to the name of the computer.
.INDENT 0.0
.INDENT 3.5

    .ft C
    site_name(variable)
    .ft P
.UNINDENT
.UNINDENT

<a name="string"></a>

### string


String operations.

<a name="synopsis"></a>

### Synopsis

.INDENT 0.0
.INDENT 3.5

    .ft C
    Search and Replace
      string(FIND <string> <substring> <out-var> [...])
      string(REPLACE <match-string> <replace-string> <out-var> <input>...)
    
    Regular Expressions
      string(REGEX MATCH <match-regex> <out-var> <input>...)
      string(REGEX MATCHALL <match-regex> <out-var> <input>...)
      string(REGEX REPLACE <match-regex> <replace-expr> <out-var> <input>...)
    
    Manipulation
      string(APPEND <string-var> [<input>...])
      string(PREPEND <string-var> [<input>...])
      string(CONCAT <out-var> [<input>...])
      string(JOIN <glue> <out-var> [<input>...])
      string(TOLOWER <string> <out-var>)
      string(TOUPPER <string> <out-var>)
      string(LENGTH <string> <out-var>)
      string(SUBSTRING <string> <begin> <length> <out-var>)
      string(STRIP <string> <out-var>)
      string(GENEX_STRIP <string> <out-var>)
      string(REPEAT <string> <count> <out-var>)
    
    Comparison
      string(COMPARE <op> <string1> <string2> <out-var>)
    
    Hashing
      string(<HASH> <out-var> <input>)
    
    Generation
      string(ASCII <number>... <out-var>)
      string(CONFIGURE <string> <out-var> [...])
      string(MAKE_C_IDENTIFIER <string> <out-var>)
      string(RANDOM [<option>...] <out-var>)
      string(TIMESTAMP <out-var> [<format string>] [UTC])
      string(UUID <out-var> ...)
    .ft P
.UNINDENT
.UNINDENT

<a name="search-and-replace"></a>

### Search and Replace

.INDENT 0.0
.INDENT 3.5

    .ft C
    string(FIND <string> <substring> <output_variable> [REVERSE])
    .ft P
.UNINDENT
.UNINDENT

Return the position where the given **&lt;substring&gt;** was found in
the supplied **&lt;string&gt;**.  If the **REVERSE** flag was used, the command will
search for the position of the last occurrence of the specified
**&lt;substring&gt;**.  If the **&lt;substring&gt;** is not found, a position of -1 is
returned.

The **string(FIND)** subcommand treats all strings as ASCII-only characters.
The index stored in **&lt;output\_variable&gt;** will also be counted in bytes,
so strings containing multi-byte characters may lead to unexpected results.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(REPLACE <match_string>
           <replace_string> <output_variable>
           <input> [<input>...])
    .ft P
.UNINDENT
.UNINDENT

Replace all occurrences of **&lt;match\_string&gt;** in the **&lt;input&gt;**
with **&lt;replace\_string&gt;** and store the result in the **&lt;output\_variable&gt;**.

<a name="regular-expressions"></a>

### Regular Expressions

.INDENT 0.0
.INDENT 3.5

    .ft C
    string(REGEX MATCH <regular_expression>
           <output_variable> <input> [<input>...])
    .ft P
.UNINDENT
.UNINDENT

Match the **&lt;regular\_expression&gt;** once and store the match in the
**&lt;output\_variable&gt;**.
All **&lt;input&gt;** arguments are concatenated before matching.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(REGEX MATCHALL <regular_expression>
           <output_variable> <input> [<input>...])
    .ft P
.UNINDENT
.UNINDENT

Match the **&lt;regular\_expression&gt;** as many times as possible and store the
matches in the **&lt;output\_variable&gt;** as a list.
All **&lt;input&gt;** arguments are concatenated before matching.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(REGEX REPLACE <regular_expression>
           <replacement_expression> <output_variable>
           <input> [<input>...])
    .ft P
.UNINDENT
.UNINDENT

Match the **&lt;regular\_expression&gt;** as many times as possible and substitute
the **&lt;replacement\_expression&gt;** for the match in the output.
All **&lt;input&gt;** arguments are concatenated before matching.

The **&lt;replacement\_expression&gt;** may refer to parenthesis-delimited
subexpressions of the match using **\e1**, **\e2**, …, **\e9**.  Note that
two backslashes (**\e\e1**) are required in CMake code to get a backslash
through argument parsing.

<a name="regex-specification"></a>

### Regex Specification


The following characters have special meaning in regular expressions:
.INDENT 0.0

* <b>**^**</b>  
  Matches at beginning of input
* <b>**$**</b>  
  Matches at end of input
* <b>**.**</b>  
  Matches any single character
* <b>**\e&lt;char&gt;**</b>  
  Matches the single character specified by **&lt;char&gt;**.  Use this to
  match special regex characters, e.g. **\e.** for a literal **.**
  or **\e\e** for a literal backslash **\e**.  Escaping a non-special
  character is unnecessary but allowed, e.g. **\ea** matches **a**.
* <b>**[ ]**</b>  
  Matches any character(s) inside the brackets
* <b>**[^ ]**</b>  
  Matches any character(s) not inside the brackets
* <b>**-**</b>  
  Inside brackets, specifies an inclusive range between
  characters on either side e.g. **[a-f]** is **[abcdef]**
  To match a literal **-** using brackets, make it the first
  or the last character e.g. **[+*/-]** matches basic
  mathematical operators.
* **<b>\*</b>**  
  Matches preceding pattern zero or more times
* <b>**+**</b>  
  Matches preceding pattern one or more times
* <b>**?**</b>  
  Matches preceding pattern zero or once only
* <b>**|**</b>  
  Matches a pattern on either side of the **|**
* <b>**()**</b>  
  Saves a matched subexpression, which can be referenced
  in the **REGEX REPLACE** operation. Additionally it is saved
  by all regular expression-related commands, including
  e.g. **if(MATCHES)**, in the variables
  **CMAKE\_MATCH\_&lt;n&gt;** for **&lt;n&gt;** 0..9.
  .UNINDENT

***, +** and **?** have higher precedence than concatenation.  **|**
has lower precedence than concatenation.  This means that the regular
expression **^ab+d$** matches **abbd** but not **ababd**, and the regular
expression **^(ab|cd)$** matches **ab** but not **abd**.

CMake language Escape Sequences such as **\et**, **\er**, **\en**,
and **\e\e** may be used to construct literal tabs, carriage returns,
newlines, and backslashes (respectively) to pass in a regex.  For example:
.INDENT 0.0

* ·  
  The quoted argument **"[ \et\er\en]"** specifies a regex that matches
  any single whitespace character.
* ·  
  The quoted argument **"[/\e\e]"** specifies a regex that matches
  a single forward slash **/** or backslash **\e**.
* ·  
  The quoted argument **"[A-Za-z0-9\_]"** specifies a regex that matches
  any single “word” character in the C locale.
* ·  
  The quoted argument **"\e\e(\e\ea\e\e+b\e\e)"** specifies a regex that matches
  the exact string **(a+b)**.  Each **\e\e** is parsed in a quoted argument
  as just **\e**, so the regex itself is actually **\e(\ea\e+\eb\e)**.  This
  can alternatively be specified in a bracket argument without
  having to escape the backslashes, e.g. **[[\e(\ea\e+\eb\e)]]**.
  .UNINDENT

<a name="manipulation"></a>

### Manipulation

.INDENT 0.0
.INDENT 3.5

    .ft C
    string(APPEND <string_variable> [<input>...])
    .ft P
.UNINDENT
.UNINDENT

Append all the **&lt;input&gt;** arguments to the string.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(PREPEND <string_variable> [<input>...])
    .ft P
.UNINDENT
.UNINDENT

Prepend all the **&lt;input&gt;** arguments to the string.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(CONCAT <output_variable> [<input>...])
    .ft P
.UNINDENT
.UNINDENT

Concatenate all the **&lt;input&gt;** arguments together and store
the result in the named **&lt;output\_variable&gt;**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(JOIN <glue> <output_variable> [<input>...])
    .ft P
.UNINDENT
.UNINDENT

Join all the **&lt;input&gt;** arguments together using the **&lt;glue&gt;**
string and store the result in the named **&lt;output\_variable&gt;**.

To join a list’s elements, prefer to use the **JOIN** operator
from the **list()** command.  This allows for the elements to have
special characters like **;** in them.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(TOLOWER <string> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Convert **&lt;string&gt;** to lower characters.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(TOUPPER <string> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Convert **&lt;string&gt;** to upper characters.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(LENGTH <string> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Store in an **&lt;output\_variable&gt;** a given string’s length in bytes.
Note that this means if **&lt;string&gt;** contains multi-byte characters, the
result stored in **&lt;output\_variable&gt;** will _not_ be the number of characters.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(SUBSTRING <string> <begin> <length> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Store in an **&lt;output\_variable&gt;** a substring of a given **&lt;string&gt;**.  If
**&lt;length&gt;** is **-1** the remainder of the string starting at **&lt;begin&gt;**
will be returned.  If **&lt;string&gt;** is shorter than **&lt;length&gt;** then the
end of the string is used instead.

Both **&lt;begin&gt;** and **&lt;length&gt;** are counted in bytes, so care must
be exercised if **&lt;string&gt;** could contain multi-byte characters.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
CMake 3.1 and below reported an error if **&lt;length&gt;** pointed past
the end of **&lt;string&gt;**.
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(STRIP <string> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Store in an **&lt;output\_variable&gt;** a substring of a given **&lt;string&gt;** with
leading and trailing spaces removed.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(GENEX_STRIP <string> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Strip any **generator expressions**
from the input **&lt;string&gt;** and store the result in the **&lt;output\_variable&gt;**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(REPEAT <string> <count> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Produce the output string as the input **&lt;string&gt;** repeated **&lt;count&gt;** times.

<a name="comparison"></a>

### Comparison

.INDENT 0.0
.INDENT 3.5

    .ft C
    string(COMPARE LESS <string1> <string2> <output_variable>)
    string(COMPARE GREATER <string1> <string2> <output_variable>)
    string(COMPARE EQUAL <string1> <string2> <output_variable>)
    string(COMPARE NOTEQUAL <string1> <string2> <output_variable>)
    string(COMPARE LESS_EQUAL <string1> <string2> <output_variable>)
    string(COMPARE GREATER_EQUAL <string1> <string2> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Compare the strings and store true or false in the **&lt;output\_variable&gt;**.

<a name="hashing"></a>

### Hashing

.INDENT 0.0
.INDENT 3.5

    .ft C
    string(<HASH> <output_variable> <input>)
    .ft P
.UNINDENT
.UNINDENT

Compute a cryptographic hash of the **&lt;input&gt;** string.
The supported **&lt;HASH&gt;** algorithm names are:
.INDENT 0.0

* <b>**MD5**</b>  
  Message-Digest Algorithm 5, RFC 1321.
* <b>**SHA1**</b>  
  US Secure Hash Algorithm 1, RFC 3174.
* <b>**SHA224**</b>  
  US Secure Hash Algorithms, RFC 4634.
* <b>**SHA256**</b>  
  US Secure Hash Algorithms, RFC 4634.
* <b>**SHA384**</b>  
  US Secure Hash Algorithms, RFC 4634.
* <b>**SHA512**</b>  
  US Secure Hash Algorithms, RFC 4634.
* <b>**SHA3\_224**</b>  
  Keccak SHA-3.
* <b>**SHA3\_256**</b>  
  Keccak SHA-3.
* <b>**SHA3\_384**</b>  
  Keccak SHA-3.
* <b>**SHA3\_512**</b>  
  Keccak SHA-3.
  .UNINDENT

<a name="generation"></a>

### Generation

.INDENT 0.0
.INDENT 3.5

    .ft C
    string(ASCII <number> [<number> ...] <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Convert all numbers into corresponding ASCII characters.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(CONFIGURE <string> <output_variable>
           [@ONLY] [ESCAPE_QUOTES])
    .ft P
.UNINDENT
.UNINDENT

Transform a **&lt;string&gt;** like **configure\_file()** transforms a file.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(MAKE_C_IDENTIFIER <string> <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Convert each non-alphanumeric character in the input **&lt;string&gt;** to an
underscore and store the result in the **&lt;output\_variable&gt;**.  If the first
character of the **&lt;string&gt;** is a digit, an underscore will also be prepended
to the result.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(RANDOM [LENGTH <length>] [ALPHABET <alphabet>]
           [RANDOM_SEED <seed>] <output_variable>)
    .ft P
.UNINDENT
.UNINDENT

Return a random string of given **&lt;length&gt;** consisting of
characters from the given **&lt;alphabet&gt;**.  Default length is 5 characters
and default alphabet is all numbers and upper and lower case letters.
If an integer **RANDOM\_SEED** is given, its value will be used to seed the
random number generator.
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(TIMESTAMP <output_variable> [<format_string>] [UTC])
    .ft P
.UNINDENT
.UNINDENT

Write a string representation of the current date
and/or time to the **&lt;output\_variable&gt;**.

If the command is unable to obtain a timestamp, the **&lt;output\_variable&gt;**
will be set to the empty string **""**.

The optional **UTC** flag requests the current date/time representation to
be in Coordinated Universal Time (UTC) rather than local time.

The optional **&lt;format\_string&gt;** may contain the following format
specifiers:
.INDENT 0.0
.INDENT 3.5

    .ft C
    %%        A literal percent sign (%).
    %d        The day of the current month (01-31).
    %H        The hour on a 24-hour clock (00-23).
    %I        The hour on a 12-hour clock (01-12).
    %j        The day of the current year (001-366).
    %m        The month of the current year (01-12).
    %b        Abbreviated month name (e.g. Oct).
    %B        Full month name (e.g. October).
    %M        The minute of the current hour (00-59).
    %s        Seconds since midnight (UTC) 1-Jan-1970 (UNIX time).
    %S        The second of the current minute.
              60 represents a leap second. (00-60)
    %U        The week number of the current year (00-53).
    %w        The day of the current week. 0 is Sunday. (0-6)
    %a        Abbreviated weekday name (e.g. Fri).
    %A        Full weekday name (e.g. Friday).
    %y        The last two digits of the current year (00-99)
    %Y        The current year.
    .ft P
.UNINDENT
.UNINDENT

Unknown format specifiers will be ignored and copied to the output
as-is.

If no explicit **&lt;format\_string&gt;** is given, it will default to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    %Y-%m-%dT%H:%M:%S    for local time.
    %Y-%m-%dT%H:%M:%SZ   for UTC.
    .ft P
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
If the **SOURCE\_DATE\_EPOCH** environment variable is set,
its value will be used instead of the current time.
See _https://reproducible-builds.org/specs/source-date-epoch/_ for details.
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(UUID <output_variable> NAMESPACE <namespace> NAME <name>
           TYPE <MD5|SHA1> [UPPER])
    .ft P
.UNINDENT
.UNINDENT

Create a universally unique identifier (aka GUID) as per RFC4122
based on the hash of the combined values of **&lt;namespace&gt;**
(which itself has to be a valid UUID) and **&lt;name&gt;**.
The hash algorithm can be either **MD5** (Version 3 UUID) or
**SHA1** (Version 5 UUID).
A UUID has the format **xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx**
where each **x** represents a lower case hexadecimal character.
Where required, an uppercase representation can be requested
with the optional **UPPER** flag.

<a name="unset"></a>

### unset


Unset a variable, cache variable, or environment variable.

<a name="unset-normal-variable-or-cache-entry"></a>

### Unset Normal Variable or Cache Entry

.INDENT 0.0
.INDENT 3.5

    .ft C
    unset(<variable> [CACHE | PARENT_SCOPE])
    .ft P
.UNINDENT
.UNINDENT

Removes a normal variable from the current scope, causing it
to become undefined.  If **CACHE** is present, then a cache variable
is removed instead of a normal variable.  Note that when evaluating
Variable References of the form **${VAR}**, CMake first searches
for a normal variable with that name.  If no such normal variable exists,
CMake will then search for a cache entry with that name.  Because of this
unsetting a normal variable can expose a cache variable that was previously
hidden.  To force a variable reference of the form **${VAR}** to return an
empty string, use **set(&lt;variable&gt; "")**, which clears the normal variable
but leaves it defined.

If **PARENT\_SCOPE** is present then the variable is removed from the scope
above the current scope.  See the same option in the **set()** command
for further details.

<a name="unset-environment-variable"></a>

### Unset Environment Variable

.INDENT 0.0
.INDENT 3.5

    .ft C
    unset(ENV{<variable>})
    .ft P
.UNINDENT
.UNINDENT

Removes **&lt;variable&gt;** from the currently available
**Environment Variables**.
Subsequent calls of **$ENV{&lt;variable&gt;}** will return the empty string.

This command affects only the current CMake process, not the process
from which CMake was called, nor the system environment at large,
nor the environment of subsequent build or test processes.

<a name="variable_watch"></a>

### variable_watch


Watch the CMake variable for change.
.INDENT 0.0
.INDENT 3.5

    .ft C
    variable_watch(<variable> [<command>])
    .ft P
.UNINDENT
.UNINDENT

If the specified **&lt;variable&gt;** changes, a message will be printed
to inform about the change.

Additionally, if **&lt;command&gt;** is given, this command will be executed.
The command will receive the following arguments:
**COMMAND(&lt;variable&gt; &lt;access&gt; &lt;value&gt; &lt;current_list_file&gt; &lt;stack&gt;)**

<a name="while"></a>

### while


Evaluate a group of commands while a condition is true
.INDENT 0.0
.INDENT 3.5

    .ft C
    while(<condition>)
      <commands>
    endwhile()
    .ft P
.UNINDENT
.UNINDENT

All commands between while and the matching **endwhile()** are recorded
without being invoked.  Once the **endwhile()** is evaluated, the
recorded list of commands is invoked as long as the **&lt;condition&gt;** is true.

The **&lt;condition&gt;** has the same syntax and is evaluated using the same logic
as described at length for the **if()** command.

The commands **break()** and **continue()** provide means to
escape from the normal control flow.

Per legacy, the **endwhile()** command admits
an optional **&lt;condition&gt;** argument.
If used, it must be a verbatim repeat of the argument of the opening
**while** command.

<a name="project-commands"></a>

# Project Commands


These commands are available only in CMake projects.

<a name="add_compile_definitions"></a>

### add_compile_definitions


Add preprocessor definitions to the compilation of source files.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_compile_definitions(<definition> ...)
    .ft P
.UNINDENT
.UNINDENT

Adds preprocessor definitions to the compiler command line for targets in the
current directory and below (whether added before or after this command is
invoked). See documentation of the **directory**
and **target** **COMPILE\_DEFINITIONS** properties.

Definitions are specified using the syntax **VAR** or **VAR=value**.
Function-style definitions are not supported. CMake will automatically
escape the value correctly for the native build system (note that CMake
language syntax may require escapes to specify some values).

Arguments to **add\_compile\_definitions** may use “generator expressions” with
the syntax **$&lt;...&gt;**.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

<a name="add_compile_options"></a>

### add_compile_options


Add options to the compilation of source files.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_compile_options(<option> ...)
    .ft P
.UNINDENT
.UNINDENT

Adds options to the **COMPILE\_OPTIONS** directory property.
These options are used when compiling targets from the current
directory and below.

<a name="arguments"></a>

### Arguments


Arguments to **add\_compile\_options** may use “generator expressions” with
the syntax **$&lt;...&gt;**.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

The final set of compile or link options used for a target is constructed by
accumulating options from the current target and the usage requirements of
its dependencies.  The set of options is de-duplicated to avoid repetition.
While beneficial for individual options, the de-duplication step can break
up option groups.  For example, **-D A -D B** becomes **-D A B**.  One may
specify a group of options using shell-like quoting along with a **SHELL:**
prefix.  The **SHELL:** prefix is dropped, and the rest of the option string
is parsed using the **separate\_arguments()** **UNIX\_COMMAND** mode.
For example, **"SHELL:-D A" "SHELL:-D B"** becomes **-D A -D B**.

<a name="example"></a>

### Example


Since different compilers support different options, a typical use of
this command is in a compiler-specific conditional clause:
.INDENT 0.0
.INDENT 3.5

    .ft C
    if (MSVC)
        # warning level 4 and all warnings as errors
        add_compile_options(/W4 /WX)
    else()
        # lots of warnings and all warnings as errors
        add_compile_options(-Wall -Wextra -pedantic -Werror)
    endif()
    .ft P
.UNINDENT
.UNINDENT

<a name="see-also"></a>

### See Also


This command can be used to add any options. However, for
adding preprocessor definitions and include directories it is recommended
to use the more specific commands **add\_compile\_definitions()**
and **include\_directories()**.

The command **target\_compile\_options()** adds target-specific options.

<a name="add_custom_command"></a>

### add_custom_command


Add a custom build rule to the generated build system.

There are two main signatures for **add\_custom\_command**.

<a name="generating-files"></a>

### Generating Files


The first signature is for adding a custom command to produce an output:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_custom_command(OUTPUT output1 [output2 ...]
                       COMMAND command1 [ARGS] [args1...]
                       [COMMAND command2 [ARGS] [args2...] ...]
                       [MAIN_DEPENDENCY depend]
                       [DEPENDS [depends...]]
                       [BYPRODUCTS [files...]]
                       [IMPLICIT_DEPENDS <lang1> depend1
                                        [<lang2> depend2] ...]
                       [WORKING_DIRECTORY dir]
                       [COMMENT comment]
                       [DEPFILE depfile]
                       [JOB_POOL job_pool]
                       [VERBATIM] [APPEND] [USES_TERMINAL]
                       [COMMAND_EXPAND_LISTS])
    .ft P
.UNINDENT
.UNINDENT

This defines a command to generate specified **OUTPUT** file(s).
A target created in the same directory (**CMakeLists.txt** file)
that specifies any output of the custom command as a source file
is given a rule to generate the file using the command at build time.
Do not list the output in more than one independent target that
may build in parallel or the two instances of the rule may conflict
(instead use the **add\_custom\_target()** command to drive the
command and make the other targets depend on that one).
In makefile terms this creates a new target in the following form:
.INDENT 0.0
.INDENT 3.5

    .ft C
    OUTPUT: MAIN_DEPENDENCY DEPENDS
            COMMAND
    .ft P
.UNINDENT
.UNINDENT

The options are:
.INDENT 0.0

* <b>**APPEND**</b>  
  Append the **COMMAND** and **DEPENDS** option values to the custom
  command for the first output specified.  There must have already
  been a previous call to this command with the same output.
  The **COMMENT**, **MAIN\_DEPENDENCY**, and **WORKING\_DIRECTORY**
  options are currently ignored when APPEND is given, but may be
  used in the future.
* <b>**BYPRODUCTS**</b>  
  Specify the files the command is expected to produce but whose
  modification time may or may not be newer than the dependencies.
  If a byproduct name is a relative path it will be interpreted
  relative to the build tree directory corresponding to the
  current source directory.
  Each byproduct file will be marked with the **GENERATED**
  source file property automatically.

Explicit specification of byproducts is supported by the
**Ninja** generator to tell the **ninja** build tool
how to regenerate byproducts when they are missing.  It is
also useful when other build rules (e.g. custom commands)
depend on the byproducts.  Ninja requires a build rule for any
generated file on which another rule depends even if there are
order-only dependencies to ensure the byproducts will be
available before their dependents build.

The Makefile Generators will remove **BYPRODUCTS** and other
**GENERATED** files during **make clean**.

* <b>**COMMAND**</b>  
  Specify the command-line(s) to execute at build time.
  If more than one **COMMAND** is specified they will be executed in order,
  but _not_ necessarily composed into a stateful shell or batch script.
  (To run a full script, use the **configure\_file()** command or the
  **file(GENERATE)** command to create it, and then specify
  a **COMMAND** to launch it.)
  The optional **ARGS** argument is for backward compatibility and
  will be ignored.

If **COMMAND** specifies an executable target name (created by the
**add\_executable()** command), it will automatically be replaced
by the location of the executable created at build time if either of
the following is true:
.INDENT 7.0

* ·  
  The target is not being cross-compiled (i.e. the
  **CMAKE\_CROSSCOMPILING** variable is not set to true).
* ·  
  The target is being cross-compiled and an emulator is provided (i.e.
  its **CROSSCOMPILING\_EMULATOR** target property is set).
  In this case, the contents of **CROSSCOMPILING\_EMULATOR** will be
  prepended to the command before the location of the target executable.
  .UNINDENT

If neither of the above conditions are met, it is assumed that the
command name is a program to be found on the **PATH** at build time.

Arguments to **COMMAND** may use
**generator expressions**.
Use the **TARGET\_FILE** generator expression to refer to the location of
a target later in the command line (i.e. as a command argument rather
than as the command to execute).

Whenever a target is used as a command to execute or is mentioned in a
generator expression as a command argument, a target-level dependency
will be added automatically so that the mentioned target will be built
before any target using this custom command.  However this does NOT add
a file-level dependency that would cause the custom command to re-run
whenever the executable is recompiled.  List target names with
the **DEPENDS** option to add such file-level dependencies.

* <b>**COMMENT**</b>  
  Display the given message before the commands are executed at
  build time.
* <b>**DEPENDS**</b>  
  Specify files on which the command depends.  Each argument is converted
  to a dependency as follows:
  .INDENT 7.0
* 1.  
  If the argument is the name of a target (created by the
  **add\_custom\_target()**, **add\_executable()**, or
  **add\_library()** command) a target-level dependency is
  created to make sure the target is built before any target
  using this custom command.  Additionally, if the target is an
  executable or library, a file-level dependency is created to
  cause the custom command to re-run whenever the target is
  recompiled.
* 2.  
  If the argument is an absolute path, a file-level dependency
  is created on that path.
* 3.  
  If the argument is the name of a source file that has been
  added to a target or on which a source file property has been set,
  a file-level dependency is created on that source file.
* 4.  
  If the argument is a relative path and it exists in the current
  source directory, a file-level dependency is created on that
  file in the current source directory.
* 5.  
  Otherwise, a file-level dependency is created on that path relative
  to the current binary directory.
  .UNINDENT

If any dependency is an **OUTPUT** of another custom command in the same
directory (**CMakeLists.txt** file), CMake automatically brings the other
custom command into the target in which this command is built.
A target-level dependency is added if any dependency is listed as
**BYPRODUCTS** of a target or any of its build events in the same
directory to ensure the byproducts will be available.

If **DEPENDS** is not specified, the command will run whenever
the **OUTPUT** is missing; if the command does not actually
create the **OUTPUT**, the rule will always run.

Arguments to **DEPENDS** may use
**generator expressions**.

* <b>**COMMAND\_EXPAND\_LISTS**</b>  
  Lists in **COMMAND** arguments will be expanded, including those
  created with
  **generator expressions**,
  allowing **COMMAND** arguments such as
  **${CC} "-I$&lt;JOIN:$&lt;TARGET_PROPERTY:foo,INCLUDE_DIRECTORIES&gt;,;-I&gt;" foo.cc**
  to be properly expanded.
* <b>**IMPLICIT\_DEPENDS**</b>  
  Request scanning of implicit dependencies of an input file.
  The language given specifies the programming language whose
  corresponding dependency scanner should be used.
  Currently only **C** and **CXX** language scanners are supported.
  The language has to be specified for every file in the
  **IMPLICIT\_DEPENDS** list.  Dependencies discovered from the
  scanning are added to those of the custom command at build time.
  Note that the **IMPLICIT\_DEPENDS** option is currently supported
  only for Makefile generators and will be ignored by other generators.
* <b>**JOB\_POOL**</b>  
  Specify a **pool** for the **Ninja**
  generator. Incompatible with **USES\_TERMINAL**, which implies
  the **console** pool.
  Using a pool that is not defined by **JOB\_POOLS** causes
  an error by ninja at build time.
* <b>**MAIN\_DEPENDENCY**</b>  
  Specify the primary input source file to the command.  This is
  treated just like any value given to the **DEPENDS** option
  but also suggests to Visual Studio generators where to hang
  the custom command. Each source file may have at most one command
  specifying it as its main dependency. A compile command (i.e. for a
  library or an executable) counts as an implicit main dependency which
  gets silently overwritten by a custom command specification.
* <b>**OUTPUT**</b>  
  Specify the output files the command is expected to produce.
  If an output name is a relative path it will be interpreted
  relative to the build tree directory corresponding to the
  current source directory.
  Each output file will be marked with the **GENERATED**
  source file property automatically.
  If the output of the custom command is not actually created
  as a file on disk it should be marked with the **SYMBOLIC**
  source file property.
* <b>**USES\_TERMINAL**</b>  
  The command will be given direct access to the terminal if possible.
  With the **Ninja** generator, this places the command in
  the **console** **pool**.
* <b>**VERBATIM**</b>  
  All arguments to the commands will be escaped properly for the
  build tool so that the invoked command receives each argument
  unchanged.  Note that one level of escapes is still used by the
  CMake language processor before add_custom_command even sees the
  arguments.  Use of **VERBATIM** is recommended as it enables
  correct behavior.  When **VERBATIM** is not given the behavior
  is platform specific because there is no protection of
  tool-specific special characters.
* <b>**WORKING\_DIRECTORY**</b>  
  Execute the command with the given current working directory.
  If it is a relative path it will be interpreted relative to the
  build tree directory corresponding to the current source directory.

Arguments to **WORKING\_DIRECTORY** may use
**generator expressions**.

* <b>**DEPFILE**</b>  
  Specify a **.d** depfile for the **Ninja** generator.
  A **.d** file holds dependencies usually emitted by the custom
  command itself.
  Using **DEPFILE** with other generators than Ninja is an error.
  .UNINDENT

<a name="build-events"></a>

### Build Events


The second signature adds a custom command to a target such as a
library or executable.  This is useful for performing an operation
before or after building the target.  The command becomes part of the
target and will only execute when the target itself is built.  If the
target is already built, the command will not execute.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_custom_command(TARGET <target>
                       PRE_BUILD | PRE_LINK | POST_BUILD
                       COMMAND command1 [ARGS] [args1...]
                       [COMMAND command2 [ARGS] [args2...] ...]
                       [BYPRODUCTS [files...]]
                       [WORKING_DIRECTORY dir]
                       [COMMENT comment]
                       [VERBATIM] [USES_TERMINAL]
                       [COMMAND_EXPAND_LISTS])
    .ft P
.UNINDENT
.UNINDENT

This defines a new command that will be associated with building the
specified **&lt;target&gt;**.  The **&lt;target&gt;** must be defined in the current
directory; targets defined in other directories may not be specified.

When the command will happen is determined by which
of the following is specified:
.INDENT 0.0

* <b>**PRE\_BUILD**</b>  
  On Visual Studio Generators, run before any other rules are
  executed within the target.
  On other generators, run just before **PRE\_LINK** commands.
* <b>**PRE\_LINK**</b>  
  Run after sources have been compiled but before linking the binary
  or running the librarian or archiver tool of a static library.
  This is not defined for targets created by the
  **add\_custom\_target()** command.
* <b>**POST\_BUILD**</b>  
  Run after all other rules within the target have been executed.
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Because generator expressions can be used in custom commands,
it is possible to define **COMMAND** lines or whole custom commands
which evaluate to empty strings for certain configurations.
For **Visual Studio 2010 (and newer)** generators these command
lines or custom commands will be omitted for the specific
configuration and no “empty-string-command” will be added.

This allows to add individual build events for every configuration.
.UNINDENT
.UNINDENT

<a name="add_custom_target"></a>

### add_custom_target


Add a target with no output so it will always be built.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_custom_target(Name [ALL] [command1 [args1...]]
                      [COMMAND command2 [args2...] ...]
                      [DEPENDS depend depend depend ... ]
                      [BYPRODUCTS [files...]]
                      [WORKING_DIRECTORY dir]
                      [COMMENT comment]
                      [JOB_POOL job_pool]
                      [VERBATIM] [USES_TERMINAL]
                      [COMMAND_EXPAND_LISTS]
                      [SOURCES src1 [src2...]])
    .ft P
.UNINDENT
.UNINDENT

Adds a target with the given name that executes the given commands.
The target has no output file and is _always considered out of date_
even if the commands try to create a file with the name of the target.
Use the **add\_custom\_command()** command to generate a file with
dependencies.  By default nothing depends on the custom target.  Use
the **add\_dependencies()** command to add dependencies to or
from other targets.

The options are:
.INDENT 0.0

* <b>**ALL**</b>  
  Indicate that this target should be added to the default build
  target so that it will be run every time (the command cannot be
  called **ALL**).
* <b>**BYPRODUCTS**</b>  
  Specify the files the command is expected to produce but whose
  modification time may or may not be updated on subsequent builds.
  If a byproduct name is a relative path it will be interpreted
  relative to the build tree directory corresponding to the
  current source directory.
  Each byproduct file will be marked with the **GENERATED**
  source file property automatically.

Explicit specification of byproducts is supported by the
**Ninja** generator to tell the **ninja** build tool
how to regenerate byproducts when they are missing.  It is
also useful when other build rules (e.g. custom commands)
depend on the byproducts.  Ninja requires a build rule for any
generated file on which another rule depends even if there are
order-only dependencies to ensure the byproducts will be
available before their dependents build.

The Makefile Generators will remove **BYPRODUCTS** and other
**GENERATED** files during **make clean**.

* <b>**COMMAND**</b>  
  Specify the command-line(s) to execute at build time.
  If more than one **COMMAND** is specified they will be executed in order,
  but _not_ necessarily composed into a stateful shell or batch script.
  (To run a full script, use the **configure\_file()** command or the
  **file(GENERATE)** command to create it, and then specify
  a **COMMAND** to launch it.)

If **COMMAND** specifies an executable target name (created by the
**add\_executable()** command), it will automatically be replaced
by the location of the executable created at build time if either of
the following is true:
.INDENT 7.0

* ·  
  The target is not being cross-compiled (i.e. the
  **CMAKE\_CROSSCOMPILING** variable is not set to true).
* ·  
  The target is being cross-compiled and an emulator is provided (i.e.
  its **CROSSCOMPILING\_EMULATOR** target property is set).
  In this case, the contents of **CROSSCOMPILING\_EMULATOR** will be
  prepended to the command before the location of the target executable.
  .UNINDENT

If neither of the above conditions are met, it is assumed that the
command name is a program to be found on the **PATH** at build time.

Arguments to **COMMAND** may use
**generator expressions**.
Use the **TARGET\_FILE** generator expression to refer to the location of
a target later in the command line (i.e. as a command argument rather
than as the command to execute).

Whenever a target is used as a command to execute or is mentioned in a
generator expression as a command argument, a target-level dependency
will be added automatically so that the mentioned target will be built
before this custom target.

The command and arguments are optional and if not specified an empty
target will be created.

* <b>**COMMENT**</b>  
  Display the given message before the commands are executed at
  build time.
* <b>**DEPENDS**</b>  
  Reference files and outputs of custom commands created with
  **add\_custom\_command()** command calls in the same directory
  (**CMakeLists.txt** file).  They will be brought up to date when
  the target is built.
  A target-level dependency is added if any dependency is a byproduct
  of a target or any of its build events in the same directory to ensure
  the byproducts will be available before this target is built.

Use the **add\_dependencies()** command to add dependencies
on other targets.

* <b>**COMMAND\_EXPAND\_LISTS**</b>  
  Lists in **COMMAND** arguments will be expanded, including those
  created with
  **generator expressions**,
  allowing **COMMAND** arguments such as
  **${CC} "-I$&lt;JOIN:$&lt;TARGET_PROPERTY:foo,INCLUDE_DIRECTORIES&gt;,;-I&gt;" foo.cc**
  to be properly expanded.
* <b>**JOB\_POOL**</b>  
  Specify a **pool** for the **Ninja**
  generator. Incompatible with **USES\_TERMINAL**, which implies
  the **console** pool.
  Using a pool that is not defined by **JOB\_POOLS** causes
  an error by ninja at build time.
* <b>**SOURCES**</b>  
  Specify additional source files to be included in the custom target.
  Specified source files will be added to IDE project files for
  convenience in editing even if they have no build rules.
* <b>**VERBATIM**</b>  
  All arguments to the commands will be escaped properly for the
  build tool so that the invoked command receives each argument
  unchanged.  Note that one level of escapes is still used by the
  CMake language processor before **add\_custom\_target** even sees
  the arguments.  Use of **VERBATIM** is recommended as it enables
  correct behavior.  When **VERBATIM** is not given the behavior
  is platform specific because there is no protection of
  tool-specific special characters.
* <b>**USES\_TERMINAL**</b>  
  The command will be given direct access to the terminal if possible.
  With the **Ninja** generator, this places the command in
  the **console** **pool**.
* <b>**WORKING\_DIRECTORY**</b>  
  Execute the command with the given current working directory.
  If it is a relative path it will be interpreted relative to the
  build tree directory corresponding to the current source directory.

Arguments to **WORKING\_DIRECTORY** may use
**generator expressions**.
.UNINDENT

<a name="add_definitions"></a>

### add_definitions


Add -D define flags to the compilation of source files.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_definitions(-DFOO -DBAR ...)
    .ft P
.UNINDENT
.UNINDENT

Adds definitions to the compiler command line for targets in the current
directory and below (whether added before or after this command is invoked).
This command can be used to add any flags, but it is intended to add
preprocessor definitions.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This command has been superseded by alternatives:
.INDENT 0.0

* ·  
  Use **add\_compile\_definitions()** to add preprocessor definitions.
* ·  
  Use **include\_directories()** to add include directories.
* ·  
  Use **add\_compile\_options()** to add other options.
  .UNINDENT
  .UNINDENT
  .UNINDENT

Flags beginning in **-D** or **/D** that look like preprocessor definitions are
automatically added to the **COMPILE\_DEFINITIONS** directory
property for the current directory.  Definitions with non-trivial values
may be left in the set of flags instead of being converted for reasons of
backwards compatibility.  See documentation of the
**directory**,
**target**,
**source file** **COMPILE\_DEFINITIONS**
properties for details on adding preprocessor definitions to specific
scopes and configurations.

See the **cmake-buildsystem(7)** manual for more on defining
buildsystem properties.

<a name="add_dependencies"></a>

### add_dependencies


Add a dependency between top-level targets.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_dependencies(<target> [<target-dependency>]...)
    .ft P
.UNINDENT
.UNINDENT

Makes a top-level **&lt;target&gt;** depend on other top-level targets to
ensure that they build before **&lt;target&gt;** does.  A top-level target
is one created by one of the **add\_executable()**,
**add\_library()**, or **add\_custom\_target()** commands
(but not targets generated by CMake like **install**).

Dependencies added to an imported target
or an interface library are followed
transitively in its place since the target itself does not build.

See the **DEPENDS** option of **add\_custom\_target()** and
**add\_custom\_command()** commands for adding file-level
dependencies in custom rules.  See the **OBJECT\_DEPENDS**
source file property to add file-level dependencies to object files.

<a name="add_executable"></a>

### add_executable


Add an executable to the project using the specified source files.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(<name> [WIN32] [MACOSX_BUNDLE]
                   [EXCLUDE_FROM_ALL]
                   [source1] [source2 ...])
    .ft P
.UNINDENT
.UNINDENT

Adds an executable target called **&lt;name&gt;** to be built from the source
files listed in the command invocation.  (The source files can be omitted
here if they are added later using **target\_sources()**.)  The
**&lt;name&gt;** corresponds to the logical target name and must be globally
unique within a project.  The actual file name of the executable built is
constructed based on conventions of the native platform (such as
**&lt;name&gt;.exe** or just **&lt;name&gt;**).

By default the executable file will be created in the build tree
directory corresponding to the source tree directory in which the
command was invoked.  See documentation of the
**RUNTIME\_OUTPUT\_DIRECTORY** target property to change this
location.  See documentation of the **OUTPUT\_NAME** target property
to change the **&lt;name&gt;** part of the final file name.

If **WIN32** is given the property **WIN32\_EXECUTABLE** will be
set on the target created.  See documentation of that target property for
details.

If **MACOSX\_BUNDLE** is given the corresponding property will be set on
the created target.  See documentation of the **MACOSX\_BUNDLE**
target property for details.

If **EXCLUDE\_FROM\_ALL** is given the corresponding property will be set on
the created target.  See documentation of the **EXCLUDE\_FROM\_ALL**
target property for details.

Source arguments to **add\_executable** may use “generator expressions” with
the syntax **$&lt;...&gt;**.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

See also **HEADER\_FILE\_ONLY** on what to do if some sources are
pre-processed, and you want to have the original sources reachable from
within IDE.


.ce
----

.ce 0

.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(<name> IMPORTED [GLOBAL])
    .ft P
.UNINDENT
.UNINDENT

An IMPORTED executable target references an
executable file located outside the project.  No rules are generated to
build it, and the **IMPORTED** target property is **True**.  The
target name has scope in the directory in which it is created and below, but
the **GLOBAL** option extends visibility.  It may be referenced like any
target built within the project.  **IMPORTED** executables are useful
for convenient reference from commands like **add\_custom\_command()**.
Details about the imported executable are specified by setting properties
whose names begin in **IMPORTED\_**.  The most important such property is
**IMPORTED\_LOCATION** (and its per-configuration version
**IMPORTED\_LOCATION\_&lt;CONFIG&gt;**) which specifies the location of
the main executable file on disk.  See documentation of the **IMPORTED\_***
properties for more information.


.ce
----

.ce 0

.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(<name> ALIAS <target>)
    .ft P
.UNINDENT
.UNINDENT

Creates an Alias Target, such that **&lt;name&gt;** can
be used to refer to **&lt;target&gt;** in subsequent commands.  The **&lt;name&gt;**
does not appear in the generated buildsystem as a make target.  The
**&lt;target&gt;** may not be a non-**GLOBAL**
Imported Target or an **ALIAS**.
**ALIAS** targets can be used as targets to read properties
from, executables for custom commands and custom targets.  They can also be
tested for existence with the regular **if(TARGET)** subcommand.
The **&lt;name&gt;** may not be used to modify properties of **&lt;target&gt;**, that
is, it may not be used as the operand of **set\_property()**,
**set\_target\_properties()**, **target\_link\_libraries()** etc.
An **ALIAS** target may not be installed or exported.

<a name="add_library"></a>

### add_library


Add a library to the project using the specified source files.

<a name="normal-libraries"></a>

### Normal Libraries

.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(<name> [STATIC | SHARED | MODULE]
                [EXCLUDE_FROM_ALL]
                [source1] [source2 ...])
    .ft P
.UNINDENT
.UNINDENT

Adds a library target called **&lt;name&gt;** to be built from the source files
listed in the command invocation.  (The source files can be omitted here
if they are added later using **target\_sources()**.)  The **&lt;name&gt;**
corresponds to the logical target name and must be globally unique within
a project.  The actual file name of the library built is constructed based
on conventions of the native platform (such as **lib&lt;name&gt;.a** or
**&lt;name&gt;.lib**).

**STATIC**, **SHARED**, or **MODULE** may be given to specify the type of
library to be created.  **STATIC** libraries are archives of object files
for use when linking other targets.  **SHARED** libraries are linked
dynamically and loaded at runtime.  **MODULE** libraries are plugins that
are not linked into other targets but may be loaded dynamically at runtime
using dlopen-like functionality.  If no type is given explicitly the
type is **STATIC** or **SHARED** based on whether the current value of the
variable **BUILD\_SHARED\_LIBS** is **ON**.  For **SHARED** and
**MODULE** libraries the **POSITION\_INDEPENDENT\_CODE** target
property is set to **ON** automatically.
A **SHARED** or **STATIC** library may be marked with the **FRAMEWORK**
target property to create an macOS Framework.

If a library does not export any symbols, it must not be declared as a
**SHARED** library.  For example, a Windows resource DLL or a managed C++/CLI
DLL that exports no unmanaged symbols would need to be a **MODULE** library.
This is because CMake expects a **SHARED** library to always have an
associated import library on Windows.

By default the library file will be created in the build tree directory
corresponding to the source tree directory in which the command was
invoked.  See documentation of the **ARCHIVE\_OUTPUT\_DIRECTORY**,
**LIBRARY\_OUTPUT\_DIRECTORY**, and
**RUNTIME\_OUTPUT\_DIRECTORY** target properties to change this
location.  See documentation of the **OUTPUT\_NAME** target
property to change the **&lt;name&gt;** part of the final file name.

If **EXCLUDE\_FROM\_ALL** is given the corresponding property will be set on
the created target.  See documentation of the **EXCLUDE\_FROM\_ALL**
target property for details.

Source arguments to **add\_library** may use “generator expressions” with
the syntax **$&lt;...&gt;**.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

See also **HEADER\_FILE\_ONLY** on what to do if some sources are
pre-processed, and you want to have the original sources reachable from
within IDE.

<a name="imported-libraries"></a>

### Imported Libraries

.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(<name> <SHARED|STATIC|MODULE|OBJECT|UNKNOWN> IMPORTED
                [GLOBAL])
    .ft P
.UNINDENT
.UNINDENT

An IMPORTED library target references a library
file located outside the project.  No rules are generated to build it, and
the **IMPORTED** target property is **True**.  The target name has
scope in the directory in which it is created and below, but the **GLOBAL**
option extends visibility.  It may be referenced like any target built
within the project.  **IMPORTED** libraries are useful for convenient
reference from commands like **target\_link\_libraries()**.  Details
about the imported library are specified by setting properties whose names
begin in **IMPORTED\_** and **INTERFACE\_**.

The most important properties are:
.INDENT 0.0

* ·  
  **IMPORTED\_LOCATION** (and its per-configuration
  variant **IMPORTED\_LOCATION\_&lt;CONFIG&gt;**) which specifies the
  location of the main library file on disk.
* ·  
  **IMPORTED\_OBJECTS** (and **IMPORTED\_OBJECTS\_&lt;CONFIG&gt;**)
  for object libraries, specifies the locations of object files on disk.
* ·  
  **PUBLIC\_HEADER** files to be installed during **install()** invocation
  .UNINDENT

See documentation of the **IMPORTED\_*** and **INTERFACE\_*** properties
for more information.

An **UNKNOWN** library type is typically only used in the implementation of
Find Modules.  It allows the path to an imported library (often found
using the **find\_library()** command) to be used without having to know
what type of library it is.  This is especially useful on Windows where a
static library and a DLL’s import library both have the same file extension.

<a name="object-libraries"></a>

### Object Libraries

.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(<name> OBJECT <src>...)
    .ft P
.UNINDENT
.UNINDENT

Creates an Object Library.  An object library
compiles source files but does not archive or link their object files into a
library.  Instead other targets created by _add\_library()_ or
**add\_executable()** may reference the objects using an expression of the
form **$&lt;TARGET\_OBJECTS:objlib&gt;** as a source, where **objlib** is the
object library name.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(... $<TARGET_OBJECTS:objlib> ...)
    add_executable(... $<TARGET_OBJECTS:objlib> ...)
    .ft P
.UNINDENT
.UNINDENT

will include objlib’s object files in a library and an executable
along with those compiled from their own sources.  Object libraries
may contain only sources that compile, header files, and other files
that would not affect linking of a normal library (e.g. **.txt**).
They may contain custom commands generating such sources, but not
**PRE\_BUILD**, **PRE\_LINK**, or **POST\_BUILD** commands.  Some native build
systems (such as Xcode) may not like targets that have only object files, so
consider adding at least one real source file to any target that references
**$&lt;TARGET\_OBJECTS:objlib&gt;**.

<a name="alias-libraries"></a>

### Alias Libraries

.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(<name> ALIAS <target>)
    .ft P
.UNINDENT
.UNINDENT

Creates an Alias Target, such that **&lt;name&gt;** can be
used to refer to **&lt;target&gt;** in subsequent commands.  The **&lt;name&gt;** does
not appear in the generated buildsystem as a make target.  The **&lt;target&gt;**
may not be a non-**GLOBAL** Imported Target or an
**ALIAS**.
**ALIAS** targets can be used as linkable targets and as targets to
read properties from.  They can also be tested for existence with the
regular **if(TARGET)** subcommand.  The **&lt;name&gt;** may not be used
to modify properties of **&lt;target&gt;**, that is, it may not be used as the
operand of **set\_property()**, **set\_target\_properties()**,
**target\_link\_libraries()** etc.  An **ALIAS** target may not be
installed or exported.

<a name="interface-libraries"></a>

### Interface Libraries

.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(<name> INTERFACE [IMPORTED [GLOBAL]])
    .ft P
.UNINDENT
.UNINDENT

Creates an Interface Library.  An **INTERFACE**
library target does not directly create build output, though it may
have properties set on it and it may be installed, exported and
imported. Typically the **INTERFACE\_*** properties are populated on
the interface target using the commands:
.INDENT 0.0

* ·  
  **set\_property()**,
* ·  
  **target\_link\_libraries(INTERFACE)**,
* ·  
  **target\_link\_options(INTERFACE)**,
* ·  
  **target\_include\_directories(INTERFACE)**,
* ·  
  **target\_compile\_options(INTERFACE)**,
* ·  
  **target\_compile\_definitions(INTERFACE)**, and
* ·  
  **target\_sources(INTERFACE)**,
  .UNINDENT

and then it is used as an argument to **target\_link\_libraries()**
like any other target.

An **INTERFACE** Imported Target may also be
created with this signature.  An **IMPORTED** library target references a
library defined outside the project.  The target name has scope in the
directory in which it is created and below, but the **GLOBAL** option
extends visibility.  It may be referenced like any target built within
the project.  **IMPORTED** libraries are useful for convenient reference
from commands like **target\_link\_libraries()**.

<a name="add_link_options"></a>

### add_link_options


Add options to the link step for executable, shared library or module
library targets in the current directory and below that are added after
this command is invoked.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_link_options(<option> ...)
    .ft P
.UNINDENT
.UNINDENT

This command can be used to add any link options, but alternative commands
exist to add libraries (**target\_link\_libraries()** or
**link\_libraries()**).  See documentation of the
**directory** and
**target** **LINK\_OPTIONS** properties.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This command cannot be used to add options for static library targets,
since they do not use a linker.  To add archiver or MSVC librarian flags,
see the **STATIC\_LIBRARY\_OPTIONS** target property.
.UNINDENT
.UNINDENT

Arguments to **add\_link\_options** may use “generator expressions” with
the syntax **$&lt;...&gt;**.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

The final set of compile or link options used for a target is constructed by
accumulating options from the current target and the usage requirements of
its dependencies.  The set of options is de-duplicated to avoid repetition.
While beneficial for individual options, the de-duplication step can break
up option groups.  For example, **-D A -D B** becomes **-D A B**.  One may
specify a group of options using shell-like quoting along with a **SHELL:**
prefix.  The **SHELL:** prefix is dropped, and the rest of the option string
is parsed using the **separate\_arguments()** **UNIX\_COMMAND** mode.
For example, **"SHELL:-D A" "SHELL:-D B"** becomes **-D A -D B**.

To pass options to the linker tool, each compiler driver has its own syntax.
The **LINKER:** prefix and **,** separator can be used to specify, in a portable
way, options to pass to the linker tool. **LINKER:** is replaced by the
appropriate driver option and **,** by the appropriate driver separator.
The driver prefix and driver separator are given by the values of the
**CMAKE\_&lt;LANG&gt;\_LINKER\_WRAPPER\_FLAG** and
**CMAKE\_&lt;LANG&gt;\_LINKER\_WRAPPER\_FLAG\_SEP** variables.

For example, **"LINKER:-z,defs"** becomes **-Xlinker -z -Xlinker defs** for
**Clang** and **-Wl,-z,defs** for **GNU GCC**.

The **LINKER:** prefix can be specified as part of a **SHELL:** prefix
expression.

The **LINKER:** prefix supports, as an alternative syntax, specification of
arguments using the **SHELL:** prefix and space as separator. The previous
example then becomes **"LINKER:SHELL:-z defs"**.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Specifying the **SHELL:** prefix anywhere other than at the beginning of the
**LINKER:** prefix is not supported.
.UNINDENT
.UNINDENT

<a name="add_subdirectory"></a>

### add_subdirectory


Add a subdirectory to the build.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_subdirectory(source_dir [binary_dir] [EXCLUDE_FROM_ALL])
    .ft P
.UNINDENT
.UNINDENT

Adds a subdirectory to the build.  The source_dir specifies the
directory in which the source CMakeLists.txt and code files are
located.  If it is a relative path it will be evaluated with respect
to the current directory (the typical usage), but it may also be an
absolute path.  The **binary\_dir** specifies the directory in which to
place the output files.  If it is a relative path it will be evaluated
with respect to the current output directory, but it may also be an
absolute path.  If **binary\_dir** is not specified, the value of
**source\_dir**, before expanding any relative path, will be used (the
typical usage).  The CMakeLists.txt file in the specified source
directory will be processed immediately by CMake before processing in
the current input file continues beyond this command.

If the **EXCLUDE\_FROM\_ALL** argument is provided then targets in the
subdirectory will not be included in the **ALL** target of the parent
directory by default, and will be excluded from IDE project files.
Users must explicitly build targets in the subdirectory.  This is
meant for use when the subdirectory contains a separate part of the
project that is useful but not necessary, such as a set of examples.
Typically the subdirectory should contain its own **project()**
command invocation so that a full build system will be generated in the
subdirectory (such as a VS IDE solution file).  Note that inter-target
dependencies supersede this exclusion.  If a target built by the
parent project depends on a target in the subdirectory, the dependee
target will be included in the parent project build system to satisfy
the dependency.

<a name="add_test"></a>

### add_test


Add a test to the project to be run by **ctest(1)**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_test(NAME <name> COMMAND <command> [<arg>...]
             [CONFIGURATIONS <config>...]
             [WORKING_DIRECTORY <dir>]
             [COMMAND_EXPAND_LISTS])
    .ft P
.UNINDENT
.UNINDENT

Adds a test called **&lt;name&gt;**.  The test name may not contain spaces,
quotes, or other characters special in CMake syntax.  The options are:
.INDENT 0.0

* <b>**COMMAND**</b>  
  Specify the test command-line.  If **&lt;command&gt;** specifies an
  executable target (created by **add\_executable()**) it will
  automatically be replaced by the location of the executable created
  at build time.
* <b>**CONFIGURATIONS**</b>  
  Restrict execution of the test only to the named configurations.
* <b>**WORKING\_DIRECTORY**</b>  
  Set the **WORKING\_DIRECTORY** test property to
  specify the working directory in which to execute the test.
  If not specified the test will be run with the current working
  directory set to the build directory corresponding to the
  current source directory.
* <b>**COMMAND\_EXPAND\_LISTS**</b>  
  Lists in **COMMAND** arguments will be expanded, including those
  created with
  **generator expressions**.
  .UNINDENT

The given test command is expected to exit with code **0** to pass and
non-zero to fail, or vice-versa if the **WILL\_FAIL** test
property is set.  Any output written to stdout or stderr will be
captured by **ctest(1)** but does not affect the pass/fail status
unless the **PASS\_REGULAR\_EXPRESSION**,
**FAIL\_REGULAR\_EXPRESSION** or
**SKIP\_REGULAR\_EXPRESSION** test property is used.

The **COMMAND** and **WORKING\_DIRECTORY** options may use “generator
expressions” with the syntax **$&lt;...&gt;**.  See the
**cmake-generator-expressions(7)** manual for available expressions.

Example usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_test(NAME mytest
             COMMAND testDriver --config $<CONFIGURATION>
                                --exe $<TARGET_FILE:myexe>)
    .ft P
.UNINDENT
.UNINDENT

This creates a test **mytest** whose command runs a **testDriver** tool
passing the configuration name and the full path to the executable
file produced by target **myexe**.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
CMake will generate tests only if the **enable\_testing()**
command has been invoked.  The **CTest** module invokes the
command automatically unless the **BUILD\_TESTING** option is turned
**OFF**.
.UNINDENT
.UNINDENT


.ce
----

.ce 0

.INDENT 0.0
.INDENT 3.5

    .ft C
    add_test(<name> <command> [<arg>...])
    .ft P
.UNINDENT
.UNINDENT

Add a test called **&lt;name&gt;** with the given command-line.  Unlike
the above **NAME** signature no transformation is performed on the
command-line to support target names or generator expressions.

<a name="aux_source_directory"></a>

### aux_source_directory


Find all source files in a directory.
.INDENT 0.0
.INDENT 3.5

    .ft C
    aux_source_directory(<dir> <variable>)
    .ft P
.UNINDENT
.UNINDENT

Collects the names of all the source files in the specified directory
and stores the list in the **&lt;variable&gt;** provided.  This command is
intended to be used by projects that use explicit template
instantiation.  Template instantiation files can be stored in a
**Templates** subdirectory and collected automatically using this
command to avoid manually listing all instantiations.

It is tempting to use this command to avoid writing the list of source
files for a library or executable target.  While this seems to work,
there is no way for CMake to generate a build system that knows when a
new source file has been added.  Normally the generated build system
knows when it needs to rerun CMake because the **CMakeLists.txt** file is
modified to add a new source.  When the source is just added to the
directory without modifying this file, one would have to manually
rerun CMake to generate a build system incorporating the new file.

<a name="build_command"></a>

### build_command


Get a command line to build the current project.
This is mainly intended for internal use by the **CTest** module.
.INDENT 0.0
.INDENT 3.5

    .ft C
    build_command(<variable>
                  [CONFIGURATION <config>]
                  [TARGET <target>]
                  [PROJECT_NAME <projname>] # legacy, causes warning
                 )
    .ft P
.UNINDENT
.UNINDENT

Sets the given **&lt;variable&gt;** to a command-line string of the form:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <cmake> --build . [--config <config>] [--target <target>...] [-- -i]
    .ft P
.UNINDENT
.UNINDENT

where **&lt;cmake&gt;** is the location of the **cmake(1)** command-line
tool, and **&lt;config&gt;** and **&lt;target&gt;** are the values provided to the
**CONFIGURATION** and **TARGET** options, if any.  The trailing **-- -i**
option is added for Makefile Generators if policy **CMP0061**
is not set to **NEW**.

When invoked, this **cmake --build** command line will launch the
underlying build system tool.
.INDENT 0.0
.INDENT 3.5

    .ft C
    build_command(<cachevariable> <makecommand>)
    .ft P
.UNINDENT
.UNINDENT

This second signature is deprecated, but still available for backwards
compatibility.  Use the first signature instead.

It sets the given **&lt;cachevariable&gt;** to a command-line string as
above but without the **--target** option.
The **&lt;makecommand&gt;** is ignored but should be the full path to
devenv, nmake, make or one of the end user build tools
for legacy invocations.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
In CMake versions prior to 3.0 this command returned a command
line that directly invokes the native build tool for the current
generator.  Their implementation of the **PROJECT\_NAME** option
had no useful effects, so CMake now warns on use of the option.
.UNINDENT
.UNINDENT

<a name="create_test_sourcelist"></a>

### create_test_sourcelist


Create a test driver and source list for building test programs.
.INDENT 0.0
.INDENT 3.5

    .ft C
    create_test_sourcelist(sourceListName driverName
                           test1 test2 test3
                           EXTRA_INCLUDE include.h
                           FUNCTION function)
    .ft P
.UNINDENT
.UNINDENT

A test driver is a program that links together many small tests into a
single executable.  This is useful when building static executables
with large libraries to shrink the total required size.  The list of
source files needed to build the test driver will be in
**sourceListName**.  **driverName** is the name of the test driver program.
The rest of the arguments consist of a list of test source files, can
be semicolon separated.  Each test source file should have a function
in it that is the same name as the file with no extension (foo.cxx
should have int foo(int, char*[]);) **driverName** will be able to call
each of the tests by name on the command line.  If **EXTRA\_INCLUDE** is
specified, then the next argument is included into the generated file.
If **FUNCTION** is specified, then the next argument is taken as a
function name that is passed a pointer to ac and av.  This can be used
to add extra command line processing to each test.  The
**CMAKE\_TESTDRIVER\_BEFORE\_TESTMAIN** cmake variable can be set to
have code that will be placed directly before calling the test main function.
**CMAKE\_TESTDRIVER\_AFTER\_TESTMAIN** can be set to have code that
will be placed directly after the call to the test main function.

<a name="define_property"></a>

### define_property


Define and document custom properties.
.INDENT 0.0
.INDENT 3.5

    .ft C
    define_property(<GLOBAL | DIRECTORY | TARGET | SOURCE |
                     TEST | VARIABLE | CACHED_VARIABLE>
                     PROPERTY <name> [INHERITED]
                     BRIEF_DOCS <brief-doc> [docs...]
                     FULL_DOCS <full-doc> [docs...])
    .ft P
.UNINDENT
.UNINDENT

Defines one property in a scope for use with the **set\_property()** and
**get\_property()** commands.  This is primarily useful to associate
documentation with property names that may be retrieved with the
**get\_property()** command. The first argument determines the kind of
scope in which the property should be used.  It must be one of the
following:
.INDENT 0.0
.INDENT 3.5

    .ft C
    GLOBAL    = associated with the global namespace
    DIRECTORY = associated with one directory
    TARGET    = associated with one target
    SOURCE    = associated with one source file
    TEST      = associated with a test named with add_test
    VARIABLE  = documents a CMake language variable
    CACHED_VARIABLE = documents a CMake cache variable
    .ft P
.UNINDENT
.UNINDENT

Note that unlike **set\_property()** and **get\_property()** no
actual scope needs to be given; only the kind of scope is important.

The required **PROPERTY** option is immediately followed by the name of
the property being defined.

If the **INHERITED** option is given, then the **get\_property()** command
will chain up to the next higher scope when the requested property is not set
in the scope given to the command.
.INDENT 0.0

* ·  
  **DIRECTORY** scope chains to its parent directory’s scope, continuing the
  walk up parent directories until a directory has the property set or there
  are no more parents.  If still not found at the top level directory, it
  chains to the **GLOBAL** scope.
* ·  
  **TARGET**, **SOURCE** and **TEST** properties chain to **DIRECTORY** scope,
  including further chaining up the directories, etc. as needed.
  .UNINDENT

Note that this scope chaining behavior only applies to calls to
**get\_property()**, **get\_directory\_property()**,
**get\_target\_property()**, **get\_source\_file\_property()** and
**get\_test\_property()**.  There is no inheriting behavior when _setting_
properties, so using **APPEND** or **APPEND\_STRING** with the
**set\_property()** command will not consider inherited values when working
out the contents to append to.

The **BRIEF\_DOCS** and **FULL\_DOCS** options are followed by strings to be
associated with the property as its brief and full documentation.
Corresponding options to the **get\_property()** command will retrieve
the documentation.

<a name="enable_language"></a>

### enable_language


Enable a language (CXX/C/OBJC/OBJCXX/Fortran/etc)
.INDENT 0.0
.INDENT 3.5

    .ft C
    enable_language(<lang> [OPTIONAL] )
    .ft P
.UNINDENT
.UNINDENT

Enables support for the named language in CMake.  This is
the same as the **project()** command but does not create any of the extra
variables that are created by the project command.  Example languages
are **CXX**, **C**, **CUDA**, **OBJC**, **OBJCXX**, **Fortran**, and **ASM**.

If enabling **ASM**, enable it last so that CMake can check whether
compilers for other languages like **C** work for assembly too.

This command must be called in file scope, not in a function call.
Furthermore, it must be called in the highest directory common to all
targets using the named language directly for compiling sources or
indirectly through link dependencies.  It is simplest to enable all
needed languages in the top-level directory of a project.

The **OPTIONAL** keyword is a placeholder for future implementation and
does not currently work. Instead you can use the **CheckLanguage**
module to verify support before enabling.

<a name="enable_testing"></a>

### enable_testing


Enable testing for current directory and below.
.INDENT 0.0
.INDENT 3.5

    .ft C
    enable_testing()
    .ft P
.UNINDENT
.UNINDENT

Enables testing for this directory and below.

This command should be in the source directory root
because ctest expects to find a test file in the build
directory root.

This command is automatically invoked when the **CTest**
module is included, except if the **BUILD\_TESTING** option is
turned off.

See also the **add\_test()** command.

<a name="export"></a>

### export


Export targets from the build tree for use by outside projects.
.INDENT 0.0
.INDENT 3.5

    .ft C
    export(EXPORT <export-name> [NAMESPACE <namespace>] [FILE <filename>])
    .ft P
.UNINDENT
.UNINDENT

Creates a file **&lt;filename&gt;** that may be included by outside projects to
import targets from the current project’s build tree.  This is useful
during cross-compiling to build utility executables that can run on
the host platform in one project and then import them into another
project being compiled for the target platform.  If the **NAMESPACE**
option is given the **&lt;namespace&gt;** string will be prepended to all target
names written to the file.

Target installations are associated with the export **&lt;export-name&gt;**
using the **EXPORT** option of the **install(TARGETS)** command.

The file created by this command is specific to the build tree and
should never be installed.  See the **install(EXPORT)** command to
export targets from an installation tree.

The properties set on the generated IMPORTED targets will have the
same values as the final values of the input TARGETS.
.INDENT 0.0
.INDENT 3.5

    .ft C
    export(TARGETS [target1 [target2 [...]]] [NAMESPACE <namespace>]
           [APPEND] FILE <filename> [EXPORT_LINK_INTERFACE_LIBRARIES])
    .ft P
.UNINDENT
.UNINDENT

This signature is similar to the **EXPORT** signature, but targets are listed
explicitly rather than specified as an export-name.  If the APPEND option is
given the generated code will be appended to the file instead of overwriting it.
The EXPORT_LINK_INTERFACE_LIBRARIES keyword, if present, causes the
contents of the properties matching
**(IMPORTED\_)?LINK\_INTERFACE\_LIBRARIES(\_&lt;CONFIG&gt;)?** to be exported, when
policy CMP0022 is NEW.  If a library target is included in the export
but a target to which it links is not included the behavior is
unspecified.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Object Libraries under **Xcode** have special handling if
multiple architectures are listed in **CMAKE\_OSX\_ARCHITECTURES**.
In this case they will be exported as Interface Libraries with
no object files available to clients.  This is sufficient to satisfy
transitive usage requirements of other targets that link to the
object libraries in their implementation.
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    export(PACKAGE <PackageName>)
    .ft P
.UNINDENT
.UNINDENT

Store the current build directory in the CMake user package registry
for package **&lt;PackageName&gt;**.  The **find\_package()** command may consider the
directory while searching for package **&lt;PackageName&gt;**.  This helps dependent
projects find and use a package from the current project’s build tree
without help from the user.  Note that the entry in the package
registry that this command creates works only in conjunction with a
package configuration file (**&lt;PackageName&gt;Config.cmake**) that works with the
build tree. In some cases, for example for packaging and for system
wide installations, it is not desirable to write the user package
registry.

By default the **export(PACKAGE)** command does nothing (see policy
**CMP0090**) because populating the user package registry has effects
outside the source and build trees.  Set the
**CMAKE\_EXPORT\_PACKAGE\_REGISTRY** variable to add build directories to
the CMake user package registry.
.INDENT 0.0
.INDENT 3.5

    .ft C
    export(TARGETS [target1 [target2 [...]]]  [ANDROID_MK <filename>])
    .ft P
.UNINDENT
.UNINDENT

This signature exports cmake built targets to the android ndk build system
by creating an Android.mk file that references the prebuilt targets. The
Android NDK supports the use of prebuilt libraries, both static and shared.
This allows cmake to build the libraries of a project and make them available
to an ndk build system complete with transitive dependencies, include flags
and defines required to use the libraries. The signature takes a list of
targets and puts them in the Android.mk file specified by the **&lt;filename&gt;**
given. This signature can only be used if policy CMP0022 is NEW for all
targets given. A error will be issued if that policy is set to OLD for one
of the targets.

<a name="fltk_wrap_ui"></a>

### fltk_wrap_ui


Create FLTK user interfaces Wrappers.
.INDENT 0.0
.INDENT 3.5

    .ft C
    fltk_wrap_ui(resultingLibraryName source1
                 source2 ... sourceN )
    .ft P
.UNINDENT
.UNINDENT

Produce .h and .cxx files for all the .fl and .fld files listed.  The
resulting .h and .cxx files will be added to a variable named
**resultingLibraryName\_FLTK\_UI\_SRCS** which should be added to your
library.

<a name="get_source_file_property"></a>

### get_source_file_property


Get a property for a source file.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_source_file_property(VAR file property)
    .ft P
.UNINDENT
.UNINDENT

Gets a property from a source file.  The value of the property is
stored in the variable **VAR**.  If the source property is not found, the
behavior depends on whether it has been defined to be an **INHERITED** property
or not (see **define\_property()**).  Non-inherited properties will set
**VAR** to “NOTFOUND”, whereas inherited properties will search the relevant
parent scope as described for the **define\_property()** command and
if still unable to find the property, **VAR** will be set to an empty string.

Use **set\_source\_files\_properties()** to set property values.  Source
file properties usually control how the file is built. One property that is
always there is **LOCATION**.

See also the more general **get\_property()** command.

<a name="get_target_property"></a>

### get_target_property


Get a property from a target.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_target_property(VAR target property)
    .ft P
.UNINDENT
.UNINDENT

Get a property from a target.  The value of the property is stored in
the variable **VAR**.  If the target property is not found, the behavior
depends on whether it has been defined to be an **INHERITED** property
or not (see **define\_property()**).  Non-inherited properties will
set **VAR** to **NOTFOUND**, whereas inherited properties will search the
relevant parent scope as described for the **define\_property()**
command and if still unable to find the property, **VAR** will be set to
an empty string.

Use **set\_target\_properties()** to set target property values.
Properties are usually used to control how a target is built, but some
query the target instead.  This command can get properties for any
target so far created.  The targets do not need to be in the current
**CMakeLists.txt** file.

See also the more general **get\_property()** command.

See Target Properties for the list of properties known to CMake.

<a name="get_test_property"></a>

### get_test_property


Get a property of the test.
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_test_property(test property VAR)
    .ft P
.UNINDENT
.UNINDENT

Get a property from the test.  The value of the property is stored in
the variable **VAR**.  If the test property is not found, the behavior
depends on whether it has been defined to be an **INHERITED** property
or not (see **define\_property()**).  Non-inherited properties will
set **VAR** to “NOTFOUND”, whereas inherited properties will search the
relevant parent scope as described for the **define\_property()**
command and if still unable to find the property, **VAR** will be set to
an empty string.

For a list of standard properties you can type **cmake --help-property-list**.

See also the more general **get\_property()** command.

<a name="include_directories"></a>

### include_directories


Add include directories to the build.
.INDENT 0.0
.INDENT 3.5

    .ft C
    include_directories([AFTER|BEFORE] [SYSTEM] dir1 [dir2 ...])
    .ft P
.UNINDENT
.UNINDENT

Add the given directories to those the compiler uses to search for
include files.  Relative paths are interpreted as relative to the
current source directory.

The include directories are added to the **INCLUDE\_DIRECTORIES**
directory property for the current **CMakeLists** file.  They are also
added to the **INCLUDE\_DIRECTORIES** target property for each
target in the current **CMakeLists** file.  The target property values
are the ones used by the generators.

By default the directories specified are appended onto the current list of
directories.  This default behavior can be changed by setting
**CMAKE\_INCLUDE\_DIRECTORIES\_BEFORE** to **ON**.  By using
**AFTER** or **BEFORE** explicitly, you can select between appending and
prepending, independent of the default.

If the **SYSTEM** option is given, the compiler will be told the
directories are meant as system include directories on some platforms.
Signalling this setting might achieve effects such as the compiler
skipping warnings, or these fixed-install system files not being
considered in dependency calculations - see compiler docs.

Arguments to **include\_directories** may use “generator expressions” with
the syntax “$&lt;…&gt;”.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Prefer the **target\_include\_directories()** command to add include
directories to individual targets and optionally propagate/export them
to dependents.
.UNINDENT
.UNINDENT

<a name="include_external_msproject"></a>

### include_external_msproject


Include an external Microsoft project file in a workspace.
.INDENT 0.0
.INDENT 3.5

    .ft C
    include_external_msproject(projectname location
                               [TYPE projectTypeGUID]
                               [GUID projectGUID]
                               [PLATFORM platformName]
                               dep1 dep2 ...)
    .ft P
.UNINDENT
.UNINDENT

Includes an external Microsoft project in the generated workspace
file.  Currently does nothing on UNIX.  This will create a target
named **[projectname]**.  This can be used in the **add\_dependencies()**
command to make things depend on the external project.

**TYPE**, **GUID** and **PLATFORM** are optional parameters that allow one to
specify the type of project, id (**GUID**) of the project and the name of
the target platform.  This is useful for projects requiring values
other than the default (e.g.  WIX projects).

If the imported project has different configuration names than the
current project, set the **MAP\_IMPORTED\_CONFIG\_&lt;CONFIG&gt;**
target property to specify the mapping.

<a name="include_regular_expression"></a>

### include_regular_expression


Set the regular expression used for dependency checking.
.INDENT 0.0
.INDENT 3.5

    .ft C
    include_regular_expression(regex_match [regex_complain])
    .ft P
.UNINDENT
.UNINDENT

Sets the regular expressions used in dependency checking.  Only files
matching **regex\_match** will be traced as dependencies.  Only files
matching **regex\_complain** will generate warnings if they cannot be found
(standard header paths are not searched).  The defaults are:
.INDENT 0.0
.INDENT 3.5

    .ft C
    regex_match    = "^.*$" (match everything)
    regex_complain = "^$" (match empty string only)
    .ft P
.UNINDENT
.UNINDENT

<a name="install"></a>

### install


Specify rules to run at install time.

<a name="synopsis"></a>

### Synopsis

.INDENT 0.0
.INDENT 3.5

    .ft C
    install(TARGETS <target>... [...])
    install({FILES | PROGRAMS} <file>... [...])
    install(DIRECTORY <dir>... [...])
    install(SCRIPT <file> [...])
    install(CODE <code> [...])
    install(EXPORT <export-name> [...])
    .ft P
.UNINDENT
.UNINDENT

<a name="introduction"></a>

### Introduction


This command generates installation rules for a project.  Rules
specified by calls to this command within a source directory are
executed in order during installation.  The order across directories
is not defined.

There are multiple signatures for this command.  Some of them define
installation options for files and targets.  Options common to
multiple signatures are covered here but they are valid only for
signatures that specify them.  The common options are:
.INDENT 0.0

* <b>**DESTINATION**</b>  
  Specify the directory on disk to which a file will be installed.
  If a full path (with a leading slash or drive letter) is given
  it is used directly.  If a relative path is given it is interpreted
  relative to the value of the **CMAKE\_INSTALL\_PREFIX** variable.
  The prefix can be relocated at install time using the **DESTDIR**
  mechanism explained in the **CMAKE\_INSTALL\_PREFIX** variable
  documentation.
* <b>**PERMISSIONS**</b>  
  Specify permissions for installed files.  Valid permissions are
  **OWNER\_READ**, **OWNER\_WRITE**, **OWNER\_EXECUTE**, **GROUP\_READ**,
  **GROUP\_WRITE**, **GROUP\_EXECUTE**, **WORLD\_READ**, **WORLD\_WRITE**,
  **WORLD\_EXECUTE**, **SETUID**, and **SETGID**.  Permissions that do
  not make sense on certain platforms are ignored on those platforms.
* <b>**CONFIGURATIONS**</b>  
  Specify a list of build configurations for which the install rule
  applies (Debug, Release, etc.). Note that the values specified for
  this option only apply to options listed AFTER the **CONFIGURATIONS**
  option. For example, to set separate install paths for the Debug and
  Release configurations, do the following:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    install(TARGETS target
            CONFIGURATIONS Debug
            RUNTIME DESTINATION Debug/bin)
    install(TARGETS target
            CONFIGURATIONS Release
            RUNTIME DESTINATION Release/bin)
    .ft P
.UNINDENT
.UNINDENT

Note that **CONFIGURATIONS** appears BEFORE **RUNTIME DESTINATION**.

* <b>**COMPONENT**</b>  
  Specify an installation component name with which the install rule
  is associated, such as “runtime” or “development”.  During
  component-specific installation only install rules associated with
  the given component name will be executed.  During a full installation
  all components are installed unless marked with **EXCLUDE\_FROM\_ALL**.
  If **COMPONENT** is not provided a default component “Unspecified” is
  created.  The default component name may be controlled with the
  **CMAKE\_INSTALL\_DEFAULT\_COMPONENT\_NAME** variable.
* <b>**EXCLUDE\_FROM\_ALL**</b>  
  Specify that the file is excluded from a full installation and only
  installed as part of a component-specific installation
* <b>**RENAME**</b>  
  Specify a name for an installed file that may be different from the
  original file.  Renaming is allowed only when a single file is
  installed by the command.
* <b>**OPTIONAL**</b>  
  Specify that it is not an error if the file to be installed does
  not exist.
  .UNINDENT

Command signatures that install files may print messages during
installation.  Use the **CMAKE\_INSTALL\_MESSAGE** variable
to control which messages are printed.

Many of the **install()** variants implicitly create the directories
containing the installed files. If
**CMAKE\_INSTALL\_DEFAULT\_DIRECTORY\_PERMISSIONS** is set, these
directories will be created with the permissions specified. Otherwise,
they will be created according to the uname rules on Unix-like platforms.
Windows platforms are unaffected.

<a name="installing-targets"></a>

### Installing Targets

.INDENT 0.0
.INDENT 3.5

    .ft C
    install(TARGETS targets... [EXPORT <export-name>]
            [[ARCHIVE|LIBRARY|RUNTIME|OBJECTS|FRAMEWORK|BUNDLE|
              PRIVATE_HEADER|PUBLIC_HEADER|RESOURCE]
             [DESTINATION <dir>]
             [PERMISSIONS permissions...]
             [CONFIGURATIONS [Debug|Release|...]]
             [COMPONENT <component>]
             [NAMELINK_COMPONENT <component>]
             [OPTIONAL] [EXCLUDE_FROM_ALL]
             [NAMELINK_ONLY|NAMELINK_SKIP]
            ] [...]
            [INCLUDES DESTINATION [<dir> ...]]
            )
    .ft P
.UNINDENT
.UNINDENT

The **TARGETS** form specifies rules for installing targets from a
project.  There are several kinds of target files that may be installed:
.INDENT 0.0

* <b>**ARCHIVE**</b>  
  Static libraries are treated as **ARCHIVE** targets, except those
  marked with the **FRAMEWORK** property on macOS (see **FRAMEWORK**
  below.) For DLL platforms (all Windows-based systems including
  Cygwin), the DLL import library is treated as an **ARCHIVE** target.
  On AIX, the linker import file created for executables with
  **ENABLE\_EXPORTS** is treated as an **ARCHIVE** target.
* <b>**LIBRARY**</b>  
  Module libraries are always treated as **LIBRARY** targets. For non-
  DLL platforms shared libraries are treated as **LIBRARY** targets,
  except those marked with the **FRAMEWORK** property on macOS (see
  **FRAMEWORK** below.)
* <b>**RUNTIME**</b>  
  Executables are treated as **RUNTIME** objects, except those marked
  with the **MACOSX\_BUNDLE** property on macOS (see **BUNDLE** below.)
  For DLL platforms (all Windows-based systems including Cygwin), the
  DLL part of a shared library is treated as a **RUNTIME** target.
* <b>**OBJECTS**</b>  
  Object libraries (a simple group of object files) are always treated
  as **OBJECTS** targets.
* <b>**FRAMEWORK**</b>  
  Both static and shared libraries marked with the **FRAMEWORK**
  property are treated as **FRAMEWORK** targets on macOS.
* <b>**BUNDLE**</b>  
  Executables marked with the **MACOSX\_BUNDLE** property are treated as
  **BUNDLE** targets on macOS.
* <b>**PUBLIC\_HEADER**</b>  
  Any **PUBLIC\_HEADER** files associated with a library are installed in
  the destination specified by the **PUBLIC\_HEADER** argument on non-Apple
  platforms. Rules defined by this argument are ignored for **FRAMEWORK**
  libraries on Apple platforms because the associated files are installed
  into the appropriate locations inside the framework folder. See
  **PUBLIC\_HEADER** for details.
* <b>**PRIVATE\_HEADER**</b>  
  Similar to **PUBLIC\_HEADER**, but for **PRIVATE\_HEADER** files. See
  **PRIVATE\_HEADER** for details.
* <b>**RESOURCE**</b>  
  Similar to **PUBLIC\_HEADER** and **PRIVATE\_HEADER**, but for
  **RESOURCE** files. See **RESOURCE** for details.
  .UNINDENT

For each of these arguments given, the arguments following them only apply
to the target or file type specified in the argument. If none is given, the
installation properties apply to all target types. If only one is given then
only targets of that type will be installed (which can be used to install
just a DLL or just an import library.)

For regular executables, static libraries and shared libraries, the
**DESTINATION** argument is not required.  For these target types, when
**DESTINATION** is omitted, a default destination will be taken from the
appropriate variable from **GNUInstallDirs**, or set to a built-in
default value if that variable is not defined.  The same is true for the
public and private headers associated with the installed targets through the
**PUBLIC\_HEADER** and **PRIVATE\_HEADER** target properties.
A destination must always be provided for module libraries, Apple bundles and
frameworks.  A destination can be omitted for interface and object libraries,
but they are handled differently (see the discussion of this topic toward the
end of this section).

The following table shows the target types with their associated variables and
built-in defaults that apply when no destination is given:
.TS
center;
|l|l|l|.
_
T{
Target Type
T}	T{
GNUInstallDirs Variable
T}	T{
Built-In Default
T}
_
T{
**RUNTIME**
T}	T{
**${CMAKE\_INSTALL\_BINDIR}**
T}	T{
**bin**
T}
_
T{
**LIBRARY**
T}	T{
**${CMAKE\_INSTALL\_LIBDIR}**
T}	T{
**lib**
T}
_
T{
**ARCHIVE**
T}	T{
**${CMAKE\_INSTALL\_LIBDIR}**
T}	T{
**lib**
T}
_
T{
**PRIVATE\_HEADER**
T}	T{
**${CMAKE\_INSTALL\_INCLUDEDIR}**
T}	T{
**include**
T}
_
T{
**PUBLIC\_HEADER**
T}	T{
**${CMAKE\_INSTALL\_INCLUDEDIR}**
T}	T{
**include**
T}
_
.TE

Projects wishing to follow the common practice of installing headers into a
project-specific subdirectory will need to provide a destination rather than
rely on the above.

To make packages compliant with distribution filesystem layout policies, if
projects must specify a **DESTINATION**, it is recommended that they use a
path that begins with the appropriate **GNUInstallDirs** variable.
This allows package maintainers to control the install destination by setting
the appropriate cache variables.  The following example shows a static library
being installed to the default destination provided by
**GNUInstallDirs**, but with its headers installed to a project-specific
subdirectory that follows the above recommendation:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(mylib STATIC ...)
    set_target_properties(mylib PROPERTIES PUBLIC_HEADER mylib.h)
    include(GNUInstallDirs)
    install(TARGETS mylib
            PUBLIC_HEADER
              DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/myproj
    )
    .ft P
.UNINDENT
.UNINDENT

In addition to the common options listed above, each target can accept
the following additional arguments:
.INDENT 0.0

* <b>**NAMELINK\_COMPONENT**</b>  
  On some platforms a versioned shared library has a symbolic link such
  as:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    lib<name>.so -> lib<name>.so.1
    .ft P
.UNINDENT
.UNINDENT

where **lib&lt;name&gt;.so.1** is the soname of the library and **lib&lt;name&gt;.so**
is a “namelink” allowing linkers to find the library when given
**-l&lt;name&gt;**. The **NAMELINK\_COMPONENT** option is similar to the
**COMPONENT** option, but it changes the installation component of a shared
library namelink if one is generated. If not specified, this defaults to the
value of **COMPONENT**. It is an error to use this parameter outside of a
**LIBRARY** block.

Consider the following example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    install(TARGETS mylib
            LIBRARY
              COMPONENT Libraries
              NAMELINK_COMPONENT Development
            PUBLIC_HEADER
              COMPONENT Development
           )
    .ft P
.UNINDENT
.UNINDENT

In this scenario, if you choose to install only the **Development**
component, both the headers and namelink will be installed without the
library. (If you don’t also install the **Libraries** component, the
namelink will be a dangling symlink, and projects that link to the library
will have build errors.) If you install only the **Libraries** component,
only the library will be installed, without the headers and namelink.

This option is typically used for package managers that have separate
runtime and development packages. For example, on Debian systems, the
library is expected to be in the runtime package, and the headers and
namelink are expected to be in the development package.

See the **VERSION** and **SOVERSION** target properties for
details on creating versioned shared libraries.

* <b>**NAMELINK\_ONLY**</b>  
  This option causes the installation of only the namelink when a library
  target is installed. On platforms where versioned shared libraries do not
  have namelinks or when a library is not versioned, the **NAMELINK\_ONLY**
  option installs nothing. It is an error to use this parameter outside of a
  **LIBRARY** block.

When **NAMELINK\_ONLY** is given, either **NAMELINK\_COMPONENT** or
**COMPONENT** may be used to specify the installation component of the
namelink, but **COMPONENT** should generally be preferred.

* <b>**NAMELINK\_SKIP**</b>  
  Similar to **NAMELINK\_ONLY**, but it has the opposite effect: it causes the
  installation of library files other than the namelink when a library target
  is installed. When neither **NAMELINK\_ONLY** or **NAMELINK\_SKIP** are given,
  both portions are installed. On platforms where versioned shared libraries
  do not have symlinks or when a library is not versioned, **NAMELINK\_SKIP**
  installs the library. It is an error to use this parameter outside of a
  **LIBRARY** block.

If **NAMELINK\_SKIP** is specified, **NAMELINK\_COMPONENT** has no effect. It
is not recommended to use **NAMELINK\_SKIP** in conjunction with
**NAMELINK\_COMPONENT**.
.UNINDENT

The _install(TARGETS)_ command can also accept the following options at the
top level:
.INDENT 0.0

* <b>**EXPORT**</b>  
  This option associates the installed target files with an export called
  **&lt;export-name&gt;**.  It must appear before any target options.  To actually
  install the export file itself, call _install(EXPORT)_, documented below.
  See documentation of the **EXPORT\_NAME** target property to change
  the name of the exported target.
* <b>**INCLUDES DESTINATION**</b>  
  This option specifies a list of directories which will be added to the
  **INTERFACE\_INCLUDE\_DIRECTORIES** target property of the
  **&lt;targets&gt;** when exported by the _install(EXPORT)_ command. If a
  relative path is specified, it is treated as relative to the
  **$&lt;INSTALL\_PREFIX&gt;**.
  .UNINDENT

One or more groups of properties may be specified in a single call to
the **TARGETS** form of this command.  A target may be installed more than
once to different locations.  Consider hypothetical targets **myExe**,
**mySharedLib**, and **myStaticLib**.  The code:
.INDENT 0.0
.INDENT 3.5

    .ft C
    install(TARGETS myExe mySharedLib myStaticLib
            RUNTIME DESTINATION bin
            LIBRARY DESTINATION lib
            ARCHIVE DESTINATION lib/static)
    install(TARGETS mySharedLib DESTINATION /some/full/path)
    .ft P
.UNINDENT
.UNINDENT

will install **myExe** to **&lt;prefix&gt;/bin** and **myStaticLib** to
**&lt;prefix&gt;/lib/static**.  On non-DLL platforms **mySharedLib** will be
installed to **&lt;prefix&gt;/lib** and **/some/full/path**.  On DLL platforms
the **mySharedLib** DLL will be installed to **&lt;prefix&gt;/bin** and
**/some/full/path** and its import library will be installed to
**&lt;prefix&gt;/lib/static** and **/some/full/path**.

Interface Libraries may be listed among the targets to install.
They install no artifacts but will be included in an associated **EXPORT**.
If Object Libraries are listed but given no destination for their
object files, they will be exported as Interface Libraries.
This is sufficient to satisfy transitive usage requirements of other
targets that link to the object libraries in their implementation.

Installing a target with the **EXCLUDE\_FROM\_ALL** target property
set to **TRUE** has undefined behavior.

_install(TARGETS)_ can install targets that were created in
other directories.  When using such cross-directory install rules, running
**make install** (or similar) from a subdirectory will not guarantee that
targets from other directories are up-to-date.  You can use
**target\_link\_libraries()** or **add\_dependencies()**
to ensure that such out-of-directory targets are built before the
subdirectory-specific install rules are run.

An install destination given as a **DESTINATION** argument may
use “generator expressions” with the syntax **$&lt;...&gt;**.  See the
**cmake-generator-expressions(7)** manual for available expressions.

<a name="installing-files"></a>

### Installing Files

.INDENT 0.0
.INDENT 3.5

    .ft C
    install(<FILES|PROGRAMS> files...
            TYPE <type> | DESTINATION <dir>
            [PERMISSIONS permissions...]
            [CONFIGURATIONS [Debug|Release|...]]
            [COMPONENT <component>]
            [RENAME <name>] [OPTIONAL] [EXCLUDE_FROM_ALL])
    .ft P
.UNINDENT
.UNINDENT

The **FILES** form specifies rules for installing files for a project.
File names given as relative paths are interpreted with respect to the
current source directory.  Files installed by this form are by default
given permissions **OWNER\_WRITE**, **OWNER\_READ**, **GROUP\_READ**, and
**WORLD\_READ** if no **PERMISSIONS** argument is given.

The **PROGRAMS** form is identical to the **FILES** form except that the
default permissions for the installed file also include **OWNER\_EXECUTE**,
**GROUP\_EXECUTE**, and **WORLD\_EXECUTE**.  This form is intended to install
programs that are not targets, such as shell scripts.  Use the **TARGETS**
form to install targets built within the project.

The list of **files...** given to **FILES** or **PROGRAMS** may use
“generator expressions” with the syntax **$&lt;...&gt;**.  See the
**cmake-generator-expressions(7)** manual for available expressions.
However, if any item begins in a generator expression it must evaluate
to a full path.

Either a **TYPE** or a **DESTINATION** must be provided, but not both.
A **TYPE** argument specifies the generic file type of the files being
installed.  A destination will then be set automatically by taking the
corresponding variable from **GNUInstallDirs**, or by using a
built-in default if that variable is not defined.  See the table below for
the supported file types and their corresponding variables and built-in
defaults.  Projects can provide a **DESTINATION** argument instead of a
file type if they wish to explicitly define the install destination.
.TS
center;
|l|l|l|.
_
T{
**TYPE** Argument
T}	T{
GNUInstallDirs Variable
T}	T{
Built-In Default
T}
_
T{
**BIN**
T}	T{
**${CMAKE\_INSTALL\_BINDIR}**
T}	T{
**bin**
T}
_
T{
**SBIN**
T}	T{
**${CMAKE\_INSTALL\_SBINDIR}**
T}	T{
**sbin**
T}
_
T{
**LIB**
T}	T{
**${CMAKE\_INSTALL\_LIBDIR}**
T}	T{
**lib**
T}
_
T{
**INCLUDE**
T}	T{
**${CMAKE\_INSTALL\_INCLUDEDIR}**
T}	T{
**include**
T}
_
T{
**SYSCONF**
T}	T{
**${CMAKE\_INSTALL\_SYSCONFDIR}**
T}	T{
**etc**
T}
_
T{
**SHAREDSTATE**
T}	T{
**${CMAKE\_INSTALL\_SHARESTATEDIR}**
T}	T{
**com**
T}
_
T{
**LOCALSTATE**
T}	T{
**${CMAKE\_INSTALL\_LOCALSTATEDIR}**
T}	T{
**var**
T}
_
T{
**RUNSTATE**
T}	T{
**${CMAKE\_INSTALL\_RUNSTATEDIR}**
T}	T{
**&lt;LOCALSTATE dir&gt;/run**
T}
_
T{
**DATA**
T}	T{
**${CMAKE\_INSTALL\_DATADIR}**
T}	T{
**&lt;DATAROOT dir&gt;**
T}
_
T{
**INFO**
T}	T{
**${CMAKE\_INSTALL\_INFODIR}**
T}	T{
**&lt;DATAROOT dir&gt;/info**
T}
_
T{
**LOCALE**
T}	T{
**${CMAKE\_INSTALL\_LOCALEDIR}**
T}	T{
**&lt;DATAROOT dir&gt;/locale**
T}
_
T{
**MAN**
T}	T{
**${CMAKE\_INSTALL\_MANDIR}**
T}	T{
**&lt;DATAROOT dir&gt;/man**
T}
_
T{
**DOC**
T}	T{
**${CMAKE\_INSTALL\_DOCDIR}**
T}	T{
**&lt;DATAROOT dir&gt;/doc**
T}
_
.TE

Projects wishing to follow the common practice of installing headers into a
project-specific subdirectory will need to provide a destination rather than
rely on the above.

Note that some of the types’ built-in defaults use the **DATAROOT** directory as
a prefix. The **DATAROOT** prefix is calculated similarly to the types, with
**CMAKE\_INSTALL\_DATAROOTDIR** as the variable and **share** as the built-in
default. You cannot use **DATAROOT** as a **TYPE** parameter; please use
**DATA** instead.

To make packages compliant with distribution filesystem layout policies, if
projects must specify a **DESTINATION**, it is recommended that they use a
path that begins with the appropriate **GNUInstallDirs** variable.
This allows package maintainers to control the install destination by setting
the appropriate cache variables.  The following example shows how to follow
this advice while installing headers to a project-specific subdirectory:
.INDENT 0.0
.INDENT 3.5

    .ft C
    include(GNUInstallDirs)
    install(FILES mylib.h
            DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/myproj
    )
    .ft P
.UNINDENT
.UNINDENT

An install destination given as a **DESTINATION** argument may
use “generator expressions” with the syntax **$&lt;...&gt;**.  See the
**cmake-generator-expressions(7)** manual for available expressions.

<a name="installing-directories"></a>

### Installing Directories

.INDENT 0.0
.INDENT 3.5

    .ft C
    install(DIRECTORY dirs...
            TYPE <type> | DESTINATION <dir>
            [FILE_PERMISSIONS permissions...]
            [DIRECTORY_PERMISSIONS permissions...]
            [USE_SOURCE_PERMISSIONS] [OPTIONAL] [MESSAGE_NEVER]
            [CONFIGURATIONS [Debug|Release|...]]
            [COMPONENT <component>] [EXCLUDE_FROM_ALL]
            [FILES_MATCHING]
            [[PATTERN <pattern> | REGEX <regex>]
             [EXCLUDE] [PERMISSIONS permissions...]] [...])
    .ft P
.UNINDENT
.UNINDENT

The **DIRECTORY** form installs contents of one or more directories to a
given destination.  The directory structure is copied verbatim to the
destination.  The last component of each directory name is appended to
the destination directory but a trailing slash may be used to avoid
this because it leaves the last component empty.  Directory names
given as relative paths are interpreted with respect to the current
source directory.  If no input directory names are given the
destination directory will be created but nothing will be installed
into it.  The **FILE\_PERMISSIONS** and **DIRECTORY\_PERMISSIONS** options
specify permissions given to files and directories in the destination.
If **USE\_SOURCE\_PERMISSIONS** is specified and **FILE\_PERMISSIONS** is not,
file permissions will be copied from the source directory structure.
If no permissions are specified files will be given the default
permissions specified in the **FILES** form of the command, and the
directories will be given the default permissions specified in the
**PROGRAMS** form of the command.

The **MESSAGE\_NEVER** option disables file installation status output.

Installation of directories may be controlled with fine granularity
using the **PATTERN** or **REGEX** options.  These “match” options specify a
globbing pattern or regular expression to match directories or files
encountered within input directories.  They may be used to apply
certain options (see below) to a subset of the files and directories
encountered.  The full path to each input file or directory (with
forward slashes) is matched against the expression.  A **PATTERN** will
match only complete file names: the portion of the full path matching
the pattern must occur at the end of the file name and be preceded by
a slash.  A **REGEX** will match any portion of the full path but it may
use **/** and **$** to simulate the **PATTERN** behavior.  By default all
files and directories are installed whether or not they are matched.
The **FILES\_MATCHING** option may be given before the first match option
to disable installation of files (but not directories) not matched by
any expression.  For example, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    install(DIRECTORY src/ DESTINATION include/myproj
            FILES_MATCHING PATTERN "*.h")
    .ft P
.UNINDENT
.UNINDENT

will extract and install header files from a source tree.

Some options may follow a **PATTERN** or **REGEX** expression and are applied
only to files or directories matching them.  The **EXCLUDE** option will
skip the matched file or directory.  The **PERMISSIONS** option overrides
the permissions setting for the matched file or directory.  For
example the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    install(DIRECTORY icons scripts/ DESTINATION share/myproj
            PATTERN "CVS" EXCLUDE
            PATTERN "scripts/*"
            PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ
                        GROUP_EXECUTE GROUP_READ)
    .ft P
.UNINDENT
.UNINDENT

will install the **icons** directory to **share/myproj/icons** and the
**scripts** directory to **share/myproj**.  The icons will get default
file permissions, the scripts will be given specific permissions, and any
**CVS** directories will be excluded.

Either a **TYPE** or a **DESTINATION** must be provided, but not both.
A **TYPE** argument specifies the generic file type of the files within the
listed directories being installed.  A destination will then be set
automatically by taking the corresponding variable from
**GNUInstallDirs**, or by using a built-in default if that variable
is not defined.  See the table below for the supported file types and their
corresponding variables and built-in defaults.  Projects can provide a
**DESTINATION** argument instead of a file type if they wish to explicitly
define the install destination.
.TS
center;
|l|l|l|.
_
T{
**TYPE** Argument
T}	T{
GNUInstallDirs Variable
T}	T{
Built-In Default
T}
_
T{
**BIN**
T}	T{
**${CMAKE\_INSTALL\_BINDIR}**
T}	T{
**bin**
T}
_
T{
**SBIN**
T}	T{
**${CMAKE\_INSTALL\_SBINDIR}**
T}	T{
**sbin**
T}
_
T{
**LIB**
T}	T{
**${CMAKE\_INSTALL\_LIBDIR}**
T}	T{
**lib**
T}
_
T{
**INCLUDE**
T}	T{
**${CMAKE\_INSTALL\_INCLUDEDIR}**
T}	T{
**include**
T}
_
T{
**SYSCONF**
T}	T{
**${CMAKE\_INSTALL\_SYSCONFDIR}**
T}	T{
**etc**
T}
_
T{
**SHAREDSTATE**
T}	T{
**${CMAKE\_INSTALL\_SHARESTATEDIR}**
T}	T{
**com**
T}
_
T{
**LOCALSTATE**
T}	T{
**${CMAKE\_INSTALL\_LOCALSTATEDIR}**
T}	T{
**var**
T}
_
T{
**RUNSTATE**
T}	T{
**${CMAKE\_INSTALL\_RUNSTATEDIR}**
T}	T{
**&lt;LOCALSTATE dir&gt;/run**
T}
_
T{
**DATA**
T}	T{
**${CMAKE\_INSTALL\_DATADIR}**
T}	T{
**&lt;DATAROOT dir&gt;**
T}
_
T{
**INFO**
T}	T{
**${CMAKE\_INSTALL\_INFODIR}**
T}	T{
**&lt;DATAROOT dir&gt;/info**
T}
_
T{
**LOCALE**
T}	T{
**${CMAKE\_INSTALL\_LOCALEDIR}**
T}	T{
**&lt;DATAROOT dir&gt;/locale**
T}
_
T{
**MAN**
T}	T{
**${CMAKE\_INSTALL\_MANDIR}**
T}	T{
**&lt;DATAROOT dir&gt;/man**
T}
_
T{
**DOC**
T}	T{
**${CMAKE\_INSTALL\_DOCDIR}**
T}	T{
**&lt;DATAROOT dir&gt;/doc**
T}
_
.TE

Note that some of the types’ built-in defaults use the **DATAROOT** directory as
a prefix. The **DATAROOT** prefix is calculated similarly to the types, with
**CMAKE\_INSTALL\_DATAROOTDIR** as the variable and **share** as the built-in
default. You cannot use **DATAROOT** as a **TYPE** parameter; please use
**DATA** instead.

To make packages compliant with distribution filesystem layout policies, if
projects must specify a **DESTINATION**, it is recommended that they use a
path that begins with the appropriate **GNUInstallDirs** variable.
This allows package maintainers to control the install destination by setting
the appropriate cache variables.

The list of **dirs...** given to **DIRECTORY** and an install destination
given as a **DESTINATION** argument may use “generator expressions”
with the syntax **$&lt;...&gt;**.  See the **cmake-generator-expressions(7)**
manual for available expressions.

<a name="custom-installation-logic"></a>

### Custom Installation Logic

.INDENT 0.0
.INDENT 3.5

    .ft C
    install([[SCRIPT <file>] [CODE <code>]]
            [COMPONENT <component>] [EXCLUDE_FROM_ALL] [...])
    .ft P
.UNINDENT
.UNINDENT

The **SCRIPT** form will invoke the given CMake script files during
installation.  If the script file name is a relative path it will be
interpreted with respect to the current source directory.  The **CODE**
form will invoke the given CMake code during installation.  Code is
specified as a single argument inside a double-quoted string.  For
example, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    install(CODE "MESSAGE(e"Sample install message.e")")
    .ft P
.UNINDENT
.UNINDENT

will print a message during installation.

**&lt;file&gt;** or **&lt;code&gt;** may use “generator expressions” with the syntax
**$&lt;...&gt;** (in the case of **&lt;file&gt;**, this refers to their use in the file
name, not the file’s contents).  See the
**cmake-generator-expressions(7)** manual for available expressions.

<a name="installing-exports"></a>

### Installing Exports

.INDENT 0.0
.INDENT 3.5

    .ft C
    install(EXPORT <export-name> DESTINATION <dir>
            [NAMESPACE <namespace>] [[FILE <name>.cmake]|
            [PERMISSIONS permissions...]
            [CONFIGURATIONS [Debug|Release|...]]
            [EXPORT_LINK_INTERFACE_LIBRARIES]
            [COMPONENT <component>]
            [EXCLUDE_FROM_ALL])
    install(EXPORT_ANDROID_MK <export-name> DESTINATION <dir> [...])
    .ft P
.UNINDENT
.UNINDENT

The **EXPORT** form generates and installs a CMake file containing code to
import targets from the installation tree into another project.
Target installations are associated with the export **&lt;export-name&gt;**
using the **EXPORT** option of the _install(TARGETS)_ signature
documented above.  The **NAMESPACE** option will prepend **&lt;namespace&gt;** to
the target names as they are written to the import file.  By default
the generated file will be called **&lt;export-name&gt;.cmake** but the **FILE**
option may be used to specify a different name.  The value given to
the **FILE** option must be a file name with the **.cmake** extension.
If a **CONFIGURATIONS** option is given then the file will only be installed
when one of the named configurations is installed.  Additionally, the
generated import file will reference only the matching target
configurations.  The **EXPORT\_LINK\_INTERFACE\_LIBRARIES** keyword, if
present, causes the contents of the properties matching
**(IMPORTED\_)?LINK\_INTERFACE\_LIBRARIES(\_&lt;CONFIG&gt;)?** to be exported, when
policy **CMP0022** is **NEW**.

When a **COMPONENT** option is given, the listed **&lt;component&gt;** implicitly
depends on all components mentioned in the export set. The exported
**&lt;name&gt;.cmake** file will require each of the exported components to be
present in order for dependent projects to build properly. For example, a
project may define components **Runtime** and **Development**, with shared
libraries going into the **Runtime** component and static libraries and
headers going into the **Development** component. The export set would also
typically be part of the **Development** component, but it would export
targets from both the **Runtime** and **Development** components. Therefore,
the **Runtime** component would need to be installed if the **Development**
component was installed, but not vice versa. If the **Development** component
was installed without the **Runtime** component, dependent projects that try
to link against it would have build errors. Package managers, such as APT and
RPM, typically handle this by listing the **Runtime** component as a dependency
of the **Development** component in the package metadata, ensuring that the
library is always installed if the headers and CMake export file are present.

In addition to cmake language files, the **EXPORT\_ANDROID\_MK** mode maybe
used to specify an export to the android ndk build system.  This mode
accepts the same options as the normal export mode.  The Android
NDK supports the use of prebuilt libraries, both static and shared. This
allows cmake to build the libraries of a project and make them available
to an ndk build system complete with transitive dependencies, include flags
and defines required to use the libraries.

The **EXPORT** form is useful to help outside projects use targets built
and installed by the current project.  For example, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    install(TARGETS myexe EXPORT myproj DESTINATION bin)
    install(EXPORT myproj NAMESPACE mp_ DESTINATION lib/myproj)
    install(EXPORT_ANDROID_MK myproj DESTINATION share/ndk-modules)
    .ft P
.UNINDENT
.UNINDENT

will install the executable **myexe** to **&lt;prefix&gt;/bin** and code to import
it in the file **&lt;prefix&gt;/lib/myproj/myproj.cmake** and
**&lt;prefix&gt;/share/ndk-modules/Android.mk**.  An outside project
may load this file with the include command and reference the **myexe**
executable from the installation tree using the imported target name
**mp\_myexe** as if the target were built in its own tree.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This command supercedes the **install\_targets()** command and
the **PRE\_INSTALL\_SCRIPT** and **POST\_INSTALL\_SCRIPT**
target properties.  It also replaces the **FILES** forms of the
**install\_files()** and **install\_programs()** commands.
The processing order of these install rules relative to
those generated by **install\_targets()**,
**install\_files()**, and **install\_programs()** commands
is not defined.
.UNINDENT
.UNINDENT

<a name="generated-installation-script"></a>

### Generated Installation Script


The **install()** command generates a file, **cmake\_install.cmake**, inside
the build directory, which is used internally by the generated install target
and by CPack. You can also invoke this script manually with **cmake -P**. This
script accepts several variables:
.INDENT 0.0

* <b>**COMPONENT**</b>  
  Set this variable to install only a single CPack component as opposed to all
  of them. For example, if you only want to install the **Development**
  component, run **cmake -DCOMPONENT=Development -P cmake\_install.cmake**.
* <b>**BUILD\_TYPE**</b>  
  Set this variable to change the build type if you are using a multi-config
  generator. For example, to install with the **Debug** configuration, run
  **cmake -DBUILD_TYPE=Debug -P cmake\_install.cmake**.
* <b>**DESTDIR**</b>  
  This is an environment variable rather than a CMake variable. It allows you
  to change the installation prefix on UNIX systems. See **DESTDIR** for
  details.
  .UNINDENT

<a name="link_directories"></a>

### link_directories


Add directories in which the linker will look for libraries.
.INDENT 0.0
.INDENT 3.5

    .ft C
    link_directories([AFTER|BEFORE] directory1 [directory2 ...])
    .ft P
.UNINDENT
.UNINDENT

Adds the paths in which the linker should search for libraries.
Relative paths given to this command are interpreted as relative to
the current source directory, see **CMP0015**.

The directories are added to the **LINK\_DIRECTORIES** directory
property for the current **CMakeLists.txt** file, converting relative
paths to absolute as needed.
The command will apply only to targets created after it is called.

By default the directories specified are appended onto the current list of
directories.  This default behavior can be changed by setting
**CMAKE\_LINK\_DIRECTORIES\_BEFORE** to **ON**.  By using
**AFTER** or **BEFORE** explicitly, you can select between appending and
prepending, independent of the default.

Arguments to **link\_directories** may use “generator expressions” with
the syntax “$&lt;…&gt;”.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This command is rarely necessary and should be avoided where there are
other choices.  Prefer to pass full absolute paths to libraries where
possible, since this ensures the correct library will always be linked.
The **find\_library()** command provides the full path, which can
generally be used directly in calls to **target\_link\_libraries()**.
Situations where a library search path may be needed include:
.INDENT 0.0

* ·  
  Project generators like Xcode where the user can switch target
  architecture at build time, but a full path to a library cannot
  be used because it only provides one architecture (i.e. it is not
  a universal binary).
* ·  
  Libraries may themselves have other private library dependencies
  that expect to be found via **RPATH** mechanisms, but some linkers
  are not able to fully decode those paths (e.g. due to the presence
  of things like **$ORIGIN**).
  .UNINDENT

If a library search path must be provided, prefer to localize the effect
where possible by using the **target\_link\_directories()** command
rather than **link\_directories()**.  The target-specific command can also
control how the search directories propagate to other dependent targets.
.UNINDENT
.UNINDENT

<a name="link_libraries"></a>

### link_libraries


Link libraries to all targets added later.
.INDENT 0.0
.INDENT 3.5

    .ft C
    link_libraries([item1 [item2 [...]]]
                   [[debug|optimized|general] <item>] ...)
    .ft P
.UNINDENT
.UNINDENT

Specify libraries or flags to use when linking any targets created later in
the current directory or below by commands such as **add\_executable()**
or **add\_library()**.  See the **target\_link\_libraries()** command
for meaning of arguments.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **target\_link\_libraries()** command should be preferred whenever
possible.  Library dependencies are chained automatically, so directory-wide
specification of link libraries is rarely needed.
.UNINDENT
.UNINDENT

<a name="load_cache"></a>

### load_cache


Load in the values from another project’s CMake cache.
.INDENT 0.0
.INDENT 3.5

    .ft C
    load_cache(pathToBuildDirectory READ_WITH_PREFIX prefix entry1...)
    .ft P
.UNINDENT
.UNINDENT

Reads the cache and store the requested entries in variables with their
name prefixed with the given prefix.  This only reads the values, and
does not create entries in the local project’s cache.
.INDENT 0.0
.INDENT 3.5

    .ft C
    load_cache(pathToBuildDirectory [EXCLUDE entry1...]
               [INCLUDE_INTERNALS entry1...])
    .ft P
.UNINDENT
.UNINDENT

Loads in the values from another cache and store them in the local
project’s cache as internal entries.  This is useful for a project
that depends on another project built in a different tree.  **EXCLUDE**
option can be used to provide a list of entries to be excluded.
**INCLUDE\_INTERNALS** can be used to provide a list of internal entries to
be included.  Normally, no internal entries are brought in.  Use of
this form of the command is strongly discouraged, but it is provided
for backward compatibility.

<a name="project"></a>

### project


Set the name of the project.

<a name="synopsis"></a>

### Synopsis

.INDENT 0.0
.INDENT 3.5

    .ft C
    project(<PROJECT-NAME> [<language-name>...])
    project(<PROJECT-NAME>
            [VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]
            [DESCRIPTION <project-description-string>]
            [HOMEPAGE_URL <url-string>]
            [LANGUAGES <language-name>...])
    .ft P
.UNINDENT
.UNINDENT

Sets the name of the project, and stores it in the variable
**PROJECT\_NAME**. When called from the top-level
**CMakeLists.txt** also stores the project name in the
variable **CMAKE\_PROJECT\_NAME**.

Also sets the variables
.INDENT 0.0

* ·  
  **PROJECT\_SOURCE\_DIR**,
  **&lt;PROJECT-NAME&gt;\_SOURCE\_DIR**
* ·  
  **PROJECT\_BINARY\_DIR**,
  **&lt;PROJECT-NAME&gt;\_BINARY\_DIR**
  .UNINDENT

Further variables are set by the optional arguments described in the following.
If any of these arguments is not used, then the corresponding variables are
set to the empty string.

<a name="options"></a>

### Options


The options are:
.INDENT 0.0

* <b>**VERSION &lt;version&gt;**</b>  
  Optional; may not be used unless policy **CMP0048** is
  set to **NEW**.

Takes a **&lt;version&gt;** argument composed of non-negative integer components,
i.e. **&lt;major&gt;[.&lt;minor&gt;[.&lt;patch&gt;[.&lt;tweak&gt;]]]**,
and sets the variables
.INDENT 7.0

* ·  
  **PROJECT\_VERSION**,
  **&lt;PROJECT-NAME&gt;\_VERSION**
* ·  
  **PROJECT\_VERSION\_MAJOR**,
  **&lt;PROJECT-NAME&gt;\_VERSION\_MAJOR**
* ·  
  **PROJECT\_VERSION\_MINOR**,
  **&lt;PROJECT-NAME&gt;\_VERSION\_MINOR**
* ·  
  **PROJECT\_VERSION\_PATCH**,
  **&lt;PROJECT-NAME&gt;\_VERSION\_PATCH**
* ·  
  **PROJECT\_VERSION\_TWEAK**,
  **&lt;PROJECT-NAME&gt;\_VERSION\_TWEAK**.
  .UNINDENT

When the **project()** command is called from the top-level **CMakeLists.txt**,
then the version is also stored in the variable **CMAKE\_PROJECT\_VERSION**.

* <b>**DESCRIPTION &lt;project-description-string&gt;**</b>  
  Optional.
  Sets the variables
  .INDENT 7.0
* ·  
  **PROJECT\_DESCRIPTION**, **&lt;PROJECT-NAME&gt;\_DESCRIPTION**
  .UNINDENT

to **&lt;project-description-string&gt;**.
It is recommended that this description is a relatively short string,
usually no more than a few words.

When the **project()** command is called from the top-level **CMakeLists.txt**,
then the description is also stored in the variable **CMAKE\_PROJECT\_DESCRIPTION**.

* <b>**HOMEPAGE_URL &lt;url-string&gt;**</b>  
  Optional.
  Sets the variables
  .INDENT 7.0
* ·  
  **PROJECT\_HOMEPAGE\_URL**, **&lt;PROJECT-NAME&gt;\_HOMEPAGE\_URL**
  .UNINDENT

to **&lt;url-string&gt;**, which should be the canonical home URL for the project.

When the **project()** command is called from the top-level **CMakeLists.txt**,
then the URL also is stored in the variable **CMAKE\_PROJECT\_HOMEPAGE\_URL**.

* <b>**LANGUAGES &lt;language-name&gt;...**</b>  
  Optional.
  Can also be specified without **LANGUAGES** keyword per the first, short signature.

Selects which programming languages are needed to build the project.
Supported languages include **C**, **CXX** (i.e.  C++), **CUDA**,
**OBJC** (i.e. Objective-C), **OBJCXX**, **Fortran**, and **ASM**.
By default **C** and **CXX** are enabled if no language options are given.
Specify language **NONE**, or use the **LANGUAGES** keyword and list no languages,
to skip enabling any languages.

If enabling **ASM**, list it last so that CMake can check whether
compilers for other languages like **C** work for assembly too.
.UNINDENT

The variables set through the **VERSION**, **DESCRIPTION** and **HOMEPAGE\_URL**
options are intended for use as default values in package metadata and documentation.

<a name="code-injection"></a>

### Code Injection


If the **CMAKE\_PROJECT\_INCLUDE\_BEFORE** or
**CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE\_BEFORE** variables are set,
the files they point to will be included as the first step of the
**project()** command.
If both are set, then **CMAKE\_PROJECT\_INCLUDE\_BEFORE** will be
included before **CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE\_BEFORE**.

If the **CMAKE\_PROJECT\_INCLUDE** or
**CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE** variables are set, the files
they point to will be included as the last step of the **project()** command.
If both are set, then **CMAKE\_PROJECT\_INCLUDE** will be included before
**CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE**.

<a name="usage"></a>

### Usage


The top-level **CMakeLists.txt** file for a project must contain a
literal, direct call to the **project()** command; loading one
through the **include()** command is not sufficient.  If no such
call exists, CMake will issue a warning and pretend there is a
**project(Project)** at the top to enable the default languages
(**C** and **CXX**).

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Call the **project()** command near the top of the top-level
**CMakeLists.txt**, but _after_ calling **cmake\_minimum\_required()**.
It is important to establish version and policy settings before invoking
other commands whose behavior they may affect.
See also policy **CMP0000**.
.UNINDENT
.UNINDENT

<a name="remove_definitions"></a>

### remove_definitions


Remove -D define flags added by **add\_definitions()**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    remove_definitions(-DFOO -DBAR ...)
    .ft P
.UNINDENT
.UNINDENT

Removes flags (added by **add\_definitions()**) from the compiler
command line for sources in the current directory and below.

<a name="set_source_files_properties"></a>

### set_source_files_properties


Source files can have properties that affect how they are built.
.INDENT 0.0
.INDENT 3.5

    .ft C
    set_source_files_properties([file1 [file2 [...]]]
                                PROPERTIES prop1 value1
                                [prop2 value2 [...]])
    .ft P
.UNINDENT
.UNINDENT

Sets properties associated with source files using a key/value paired
list.

See also the **set\_property(SOURCE)** command.

See Source File Properties for the list of properties known
to CMake.  Source file properties are visible only to targets added
in the same directory (**CMakeLists.txt**).

<a name="set_target_properties"></a>

### set_target_properties


Targets can have properties that affect how they are built.
.INDENT 0.0
.INDENT 3.5

    .ft C
    set_target_properties(target1 target2 ...
                          PROPERTIES prop1 value1
                          prop2 value2 ...)
    .ft P
.UNINDENT
.UNINDENT

Sets properties on targets.  The syntax for the command is to list all
the targets you want to change, and then provide the values you want to
set next.  You can use any prop value pair you want and extract it
later with the **get\_property()** or **get\_target\_property()**
command.

See also the **set\_property(TARGET)** command.

See Target Properties for the list of properties known to CMake.

<a name="set_tests_properties"></a>

### set_tests_properties


Set a property of the tests.
.INDENT 0.0
.INDENT 3.5

    .ft C
    set_tests_properties(test1 [test2...] PROPERTIES prop1 value1 prop2 value2)
    .ft P
.UNINDENT
.UNINDENT

Sets a property for the tests.  If the test is not found, CMake
will report an error.
**Generator expressions** will be
expanded the same as supported by the test’s **add\_test()** call.

See also the **set\_property(TEST)** command.

See Test Properties for the list of properties known to CMake.

<a name="source_group"></a>

### source_group


Define a grouping for source files in IDE project generation.
There are two different signatures to create source groups.
.INDENT 0.0
.INDENT 3.5

    .ft C
    source_group(<name> [FILES <src>...] [REGULAR_EXPRESSION <regex>])
    source_group(TREE <root> [PREFIX <prefix>] [FILES <src>...])
    .ft P
.UNINDENT
.UNINDENT

Defines a group into which sources will be placed in project files.
This is intended to set up file tabs in Visual Studio.
The options are:
.INDENT 0.0

* <b>**TREE**</b>  
  CMake will automatically detect, from **&lt;src&gt;** files paths, source groups
  it needs to create, to keep structure of source groups analogically to the
  actual files and directories structure in the project. Paths of **&lt;src&gt;**
  files will be cut to be relative to **&lt;root&gt;**.
* <b>**PREFIX**</b>  
  Source group and files located directly in **&lt;root&gt;** path, will be placed
  in **&lt;prefix&gt;** source groups.
* <b>**FILES**</b>  
  Any source file specified explicitly will be placed in group
  **&lt;name&gt;**.  Relative paths are interpreted with respect to the
  current source directory.
* <b>**REGULAR\_EXPRESSION**</b>  
  Any source file whose name matches the regular expression will
  be placed in group **&lt;name&gt;**.
  .UNINDENT

If a source file matches multiple groups, the _last_ group that
explicitly lists the file with **FILES** will be favored, if any.
If no group explicitly lists the file, the _last_ group whose
regular expression matches the file will be favored.

The **&lt;name&gt;** of the group and **&lt;prefix&gt;** argument may contain backslashes
to specify subgroups:
.INDENT 0.0
.INDENT 3.5

    .ft C
    source_group(outereeinner ...)
    source_group(TREE <root> PREFIX sourceseeinc ...)
    .ft P
.UNINDENT
.UNINDENT

For backwards compatibility, the short-hand signature
.INDENT 0.0
.INDENT 3.5

    .ft C
    source_group(<name> <regex>)
    .ft P
.UNINDENT
.UNINDENT

is equivalent to
.INDENT 0.0
.INDENT 3.5

    .ft C
    source_group(<name> REGULAR_EXPRESSION <regex>)
    .ft P
.UNINDENT
.UNINDENT

<a name="target_compile_definitions"></a>

### target_compile_definitions


Add compile definitions to a target.
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_compile_definitions(<target>
      <INTERFACE|PUBLIC|PRIVATE> [items1...]
      [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
    .ft P
.UNINDENT
.UNINDENT

Specifies compile definitions to use when compiling a given **&lt;target&gt;**.  The
named **&lt;target&gt;** must have been created by a command such as
**add\_executable()** or **add\_library()** and must not be an
ALIAS target.

The **INTERFACE**, **PUBLIC** and **PRIVATE** keywords are required to
specify the scope of the following arguments.  **PRIVATE** and **PUBLIC**
items will populate the **COMPILE\_DEFINITIONS** property of
**&lt;target&gt;**. **PUBLIC** and **INTERFACE** items will populate the
**INTERFACE\_COMPILE\_DEFINITIONS** property of **&lt;target&gt;**.
(IMPORTED targets only support **INTERFACE** items.)
The following arguments specify compile definitions.  Repeated calls for the
same **&lt;target&gt;** append items in the order called.

Arguments to **target\_compile\_definitions** may use “generator expressions”
with the syntax **$&lt;...&gt;**.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

Any leading **-D** on an item will be removed.  Empty items are ignored.
For example, the following are all equivalent:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_compile_definitions(foo PUBLIC FOO)
    target_compile_definitions(foo PUBLIC -DFOO)  # -D removed
    target_compile_definitions(foo PUBLIC "" FOO) # "" ignored
    target_compile_definitions(foo PUBLIC -D FOO) # -D becomes "", then ignored
    .ft P
.UNINDENT
.UNINDENT

<a name="target_compile_features"></a>

### target_compile_features


Add expected compiler features to a target.
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_compile_features(<target> <PRIVATE|PUBLIC|INTERFACE> <feature> [...])
    .ft P
.UNINDENT
.UNINDENT

Specifies compiler features required when compiling a given target.  If the
feature is not listed in the **CMAKE\_C\_COMPILE\_FEATURES**,
**CMAKE\_CUDA\_COMPILE\_FEATURES**, or **CMAKE\_CXX\_COMPILE\_FEATURES**
variables, then an error will be reported by CMake.  If the use of the feature requires
an additional compiler flag, such as **-std=gnu++11**, the flag will be added
automatically.

The **INTERFACE**, **PUBLIC** and **PRIVATE** keywords are required to
specify the scope of the features.  **PRIVATE** and **PUBLIC** items will
populate the **COMPILE\_FEATURES** property of **&lt;target&gt;**.
**PUBLIC** and **INTERFACE** items will populate the
**INTERFACE\_COMPILE\_FEATURES** property of **&lt;target&gt;**.
(IMPORTED targets only support **INTERFACE** items.)
Repeated calls for the same **&lt;target&gt;** append items.

The named **&lt;target&gt;** must have been created by a command such as
**add\_executable()** or **add\_library()** and must not be an
ALIAS target.

Arguments to **target\_compile\_features** may use “generator expressions”
with the syntax **$&lt;...&gt;**.
See the **cmake-generator-expressions(7)** manual for available
expressions.  See the **cmake-compile-features(7)** manual for
information on compile features and a list of supported compilers.

<a name="target_compile_options"></a>

### target_compile_options


Add compile options to a target.
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_compile_options(<target> [BEFORE]
      <INTERFACE|PUBLIC|PRIVATE> [items1...]
      [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
    .ft P
.UNINDENT
.UNINDENT

Adds options to the **COMPILE\_OPTIONS** or
**INTERFACE\_COMPILE\_OPTIONS** target properties. These options
are used when compiling the given **&lt;target&gt;**, which must have been
created by a command such as **add\_executable()** or
**add\_library()** and must not be an ALIAS target.

<a name="arguments"></a>

### Arguments


If **BEFORE** is specified, the content will be prepended to the property
instead of being appended.

The **INTERFACE**, **PUBLIC** and **PRIVATE** keywords are required to
specify the scope of the following arguments.  **PRIVATE** and **PUBLIC**
items will populate the **COMPILE\_OPTIONS** property of
**&lt;target&gt;**.  **PUBLIC** and **INTERFACE** items will populate the
**INTERFACE\_COMPILE\_OPTIONS** property of **&lt;target&gt;**.
(IMPORTED targets only support **INTERFACE** items.)
The following arguments specify compile options.  Repeated calls for the same
**&lt;target&gt;** append items in the order called.

Arguments to **target\_compile\_options** may use “generator expressions”
with the syntax **$&lt;...&gt;**. See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

The final set of compile or link options used for a target is constructed by
accumulating options from the current target and the usage requirements of
its dependencies.  The set of options is de-duplicated to avoid repetition.
While beneficial for individual options, the de-duplication step can break
up option groups.  For example, **-D A -D B** becomes **-D A B**.  One may
specify a group of options using shell-like quoting along with a **SHELL:**
prefix.  The **SHELL:** prefix is dropped, and the rest of the option string
is parsed using the **separate\_arguments()** **UNIX\_COMMAND** mode.
For example, **"SHELL:-D A" "SHELL:-D B"** becomes **-D A -D B**.

<a name="see-also"></a>

### See Also


This command can be used to add any options. However, for adding
preprocessor definitions and include directories it is recommended
to use the more specific commands **target\_compile\_definitions()**
and **target\_include\_directories()**.

For directory-wide settings, there is the command **add\_compile\_options()**.

<a name="target_include_directories"></a>

### target_include_directories


Add include directories to a target.
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_include_directories(<target> [SYSTEM] [BEFORE]
      <INTERFACE|PUBLIC|PRIVATE> [items1...]
      [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
    .ft P
.UNINDENT
.UNINDENT

Specifies include directories to use when compiling a given target.
The named **&lt;target&gt;** must have been created by a command such
as **add\_executable()** or **add\_library()** and must not be an
ALIAS target.

If **BEFORE** is specified, the content will be prepended to the property
instead of being appended.

The **INTERFACE**, **PUBLIC** and **PRIVATE** keywords are required to specify
the scope of the following arguments.  **PRIVATE** and **PUBLIC** items will
populate the **INCLUDE\_DIRECTORIES** property of **&lt;target&gt;**.
**PUBLIC** and **INTERFACE** items will populate the
**INTERFACE\_INCLUDE\_DIRECTORIES** property of **&lt;target&gt;**.
(IMPORTED targets only support **INTERFACE** items.)
The following arguments specify include directories.

Specified include directories may be absolute paths or relative paths.
Repeated calls for the same &lt;target&gt; append items in the order called.  If
**SYSTEM** is specified, the compiler will be told the
directories are meant as system include directories on some platforms
(signalling this setting might achieve effects such as the compiler
skipping warnings, or these fixed-install system files not being
considered in dependency calculations - see compiler docs).  If **SYSTEM**
is used together with **PUBLIC** or **INTERFACE**, the
**INTERFACE\_SYSTEM\_INCLUDE\_DIRECTORIES** target property will be
populated with the specified directories.

Arguments to **target\_include\_directories** may use “generator expressions”
with the syntax **$&lt;...&gt;**.  See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

Include directories usage requirements commonly differ between the build-tree
and the install-tree.  The **BUILD\_INTERFACE** and **INSTALL\_INTERFACE**
generator expressions can be used to describe separate usage requirements
based on the usage location.  Relative paths are allowed within the
**INSTALL\_INTERFACE** expression and are interpreted relative to the
installation prefix.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_include_directories(mylib PUBLIC
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/mylib>
      $<INSTALL_INTERFACE:include/mylib>  # <prefix>/include/mylib
    )
    .ft P
.UNINDENT
.UNINDENT

<a name="creating-relocatable-packages"></a>

### Creating Relocatable Packages


Note that it is not advisable to populate the **INSTALL\_INTERFACE** of the
**INTERFACE\_INCLUDE\_DIRECTORIES** of a target with absolute paths to the include
directories of dependencies.  That would hard-code into installed packages
the include directory paths for dependencies
**as found on the machine the package was made on**.

The **INSTALL\_INTERFACE** of the **INTERFACE\_INCLUDE\_DIRECTORIES** is only
suitable for specifying the required include directories for headers
provided with the target itself, not those provided by the transitive
dependencies listed in its **INTERFACE\_LINK\_LIBRARIES** target
property.  Those dependencies should themselves be targets that specify
their own header locations in **INTERFACE\_INCLUDE\_DIRECTORIES**.

See the Creating Relocatable Packages section of the
**cmake-packages(7)** manual for discussion of additional care
that must be taken when specifying usage requirements while creating
packages for redistribution.

<a name="target_link_directories"></a>

### target_link_directories


Add link directories to a target.
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_directories(<target> [BEFORE]
      <INTERFACE|PUBLIC|PRIVATE> [items1...]
      [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
    .ft P
.UNINDENT
.UNINDENT

Specifies the paths in which the linker should search for libraries when
linking a given target.  Each item can be an absolute or relative path,
with the latter being interpreted as relative to the current source
directory.  These items will be added to the link command.

The named **&lt;target&gt;** must have been created by a command such as
**add\_executable()** or **add\_library()** and must not be an
ALIAS target.

The **INTERFACE**, **PUBLIC** and **PRIVATE** keywords are required to
specify the scope of the items that follow them.  **PRIVATE** and
**PUBLIC** items will populate the **LINK\_DIRECTORIES** property
of **&lt;target&gt;**.  **PUBLIC** and **INTERFACE** items will populate the
**INTERFACE\_LINK\_DIRECTORIES** property of **&lt;target&gt;**
(IMPORTED targets only support **INTERFACE** items).
Each item specifies a link directory and will be converted to an absolute
path if necessary before adding it to the relevant property.  Repeated
calls for the same **&lt;target&gt;** append items in the order called.

If **BEFORE** is specified, the content will be prepended to the relevant
property instead of being appended.

Arguments to **target\_link\_directories** may use “generator expressions”
with the syntax **$&lt;...&gt;**. See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This command is rarely necessary and should be avoided where there are
other choices.  Prefer to pass full absolute paths to libraries where
possible, since this ensures the correct library will always be linked.
The **find\_library()** command provides the full path, which can
generally be used directly in calls to **target\_link\_libraries()**.
Situations where a library search path may be needed include:
.INDENT 0.0

* ·  
  Project generators like Xcode where the user can switch target
  architecture at build time, but a full path to a library cannot
  be used because it only provides one architecture (i.e. it is not
  a universal binary).
* ·  
  Libraries may themselves have other private library dependencies
  that expect to be found via **RPATH** mechanisms, but some linkers
  are not able to fully decode those paths (e.g. due to the presence
  of things like **$ORIGIN**).
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="target_link_libraries"></a>

### target_link_libraries


Specify libraries or flags to use when linking a given target and/or
its dependents.  Usage requirements
from linked library targets will be propagated.  Usage requirements
of a target’s dependencies affect compilation of its own sources.

<a name="overview"></a>

### Overview


This command has several signatures as detailed in subsections below.
All of them have the general form
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(<target> ... <item>... ...)
    .ft P
.UNINDENT
.UNINDENT

The named **&lt;target&gt;** must have been created by a command such as
**add\_executable()** or **add\_library()** and must not be an
ALIAS target.  If policy **CMP0079** is not
set to **NEW** then the target must have been created in the current
directory.  Repeated calls for the same **&lt;target&gt;** append items in
the order called.

Each **&lt;item&gt;** may be:
.INDENT 0.0

* ·  
  **A library target name**: The generated link line will have the
  full path to the linkable library file associated with the target.
  The buildsystem will have a dependency to re-link **&lt;target&gt;** if
  the library file changes.

The named target must be created by **add\_library()** within
the project or as an IMPORTED library.
If it is created within the project an ordering dependency will
automatically be added in the build system to make sure the named
library target is up-to-date before the **&lt;target&gt;** links.

If an imported library has the **IMPORTED\_NO\_SONAME**
target property set, CMake may ask the linker to search for
the library instead of using the full path
(e.g. **/usr/lib/libfoo.so** becomes **-lfoo**).

The full path to the target’s artifact will be quoted/escaped for
the shell automatically.

* ·  
  **A full path to a library file**: The generated link line will
  normally preserve the full path to the file. The buildsystem will
  have a dependency to re-link **&lt;target&gt;** if the library file changes.

There are some cases where CMake may ask the linker to search for
the library (e.g. **/usr/lib/libfoo.so** becomes **-lfoo**), such
as when a shared library is detected to have no **SONAME** field.
See policy **CMP0060** for discussion of another case.

If the library file is in a macOS framework, the **Headers** directory
of the framework will also be processed as a
usage requirement.  This has the same
effect as passing the framework directory as an include directory.

On Visual Studio Generators for VS 2010 and above, library files
ending in **.targets** will be treated as MSBuild targets files and
imported into generated project files.  This is not supported by other
generators.

The full path to the library file will be quoted/escaped for
the shell automatically.

* ·  
  **A plain library name**: The generated link line will ask the linker
  to search for the library (e.g. **foo** becomes **-lfoo** or **foo.lib**).

The library name/flag is treated as a command-line string fragment and
will be used with no extra quoting or escaping.

* ·  
  **A link flag**: Item names starting with **-**, but not **-l** or
  **-framework**, are treated as linker flags.  Note that such flags will
  be treated like any other library link item for purposes of transitive
  dependencies, so they are generally safe to specify only as private link
  items that will not propagate to dependents.

Link flags specified here are inserted into the link command in the same
place as the link libraries. This might not be correct, depending on
the linker. Use the **LINK\_OPTIONS** target property or
**target\_link\_options()** command to add link
flags explicitly. The flags will then be placed at the toolchain-defined
flag position in the link command.

The link flag is treated as a command-line string fragment and
will be used with no extra quoting or escaping.

* ·  
  **A generator expression**: A **$&lt;...&gt;** **generator expression** may evaluate to any of the above
  items or to a semicolon-separated list of them.
  If the **...** contains any **;** characters, e.g. after evaluation
  of a **${list}** variable, be sure to use an explicitly quoted
  argument **"$&lt;...&gt;"** so that this command receives it as a
  single **&lt;item&gt;**.

Additionally, a generator expression may be used as a fragment of
any of the above items, e.g. **foo$&lt;1:\_d&gt;**.

Note that generator expressions will not be used in OLD handling of
policy **CMP0003** or policy **CMP0004**.

* ·  
  A **debug**, **optimized**, or **general** keyword immediately followed
  by another **&lt;item&gt;**.  The item following such a keyword will be used
  only for the corresponding build configuration.  The **debug** keyword
  corresponds to the **Debug** configuration (or to configurations named
  in the **DEBUG\_CONFIGURATIONS** global property if it is set).
  The **optimized** keyword corresponds to all other configurations.  The
  **general** keyword corresponds to all configurations, and is purely
  optional.  Higher granularity may be achieved for per-configuration
  rules by creating and linking to
  IMPORTED library targets.
  These keywords are interpreted immediately by this command and therefore
  have no special meaning when produced by a generator expression.
  .UNINDENT

Items containing **::**, such as **Foo::Bar**, are assumed to be
IMPORTED or ALIAS library
target names and will cause an error if no such target exists.
See policy **CMP0028**.

See the **cmake-buildsystem(7)** manual for more on defining
buildsystem properties.

<a name="libraries-for-a-target-andor-its-dependents"></a>

### Libraries for a Target and/or its Dependents

.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(<target>
                          <PRIVATE|PUBLIC|INTERFACE> <item>...
                         [<PRIVATE|PUBLIC|INTERFACE> <item>...]...)
    .ft P
.UNINDENT
.UNINDENT

The **PUBLIC**, **PRIVATE** and **INTERFACE** keywords can be used to
specify both the link dependencies and the link interface in one command.
Libraries and targets following **PUBLIC** are linked to, and are made
part of the link interface.  Libraries and targets following **PRIVATE**
are linked to, but are not made part of the link interface.  Libraries
following **INTERFACE** are appended to the link interface and are not
used for linking **&lt;target&gt;**.

<a name="libraries-for-both-a-target-and-its-dependents"></a>

### Libraries for both a Target and its Dependents

.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(<target> <item>...)
    .ft P
.UNINDENT
.UNINDENT

Library dependencies are transitive by default with this signature.
When this target is linked into another target then the libraries
linked to this target will appear on the link line for the other
target too.  This transitive “link interface” is stored in the
**INTERFACE\_LINK\_LIBRARIES** target property and may be overridden
by setting the property directly.  When **CMP0022** is not set to
**NEW**, transitive linking is built in but may be overridden by the
**LINK\_INTERFACE\_LIBRARIES** property.  Calls to other signatures
of this command may set the property making any libraries linked
exclusively by this signature private.

<a name="libraries-for-a-target-andor-its-dependents-legacy"></a>

### Libraries for a Target and/or its Dependents (Legacy)

.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(<target>
                          <LINK_PRIVATE|LINK_PUBLIC> <lib>...
                         [<LINK_PRIVATE|LINK_PUBLIC> <lib>...]...)
    .ft P
.UNINDENT
.UNINDENT

The **LINK\_PUBLIC** and **LINK\_PRIVATE** modes can be used to specify both
the link dependencies and the link interface in one command.

This signature is for compatibility only.  Prefer the **PUBLIC** or
**PRIVATE** keywords instead.

Libraries and targets following **LINK\_PUBLIC** are linked to, and are
made part of the **INTERFACE\_LINK\_LIBRARIES**.  If policy
**CMP0022** is not **NEW**, they are also made part of the
**LINK\_INTERFACE\_LIBRARIES**.  Libraries and targets following
**LINK\_PRIVATE** are linked to, but are not made part of the
**INTERFACE\_LINK\_LIBRARIES** (or **LINK\_INTERFACE\_LIBRARIES**).

<a name="libraries-for-dependents-only-legacy"></a>

### Libraries for Dependents Only (Legacy)

.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(<target> LINK_INTERFACE_LIBRARIES <item>...)
    .ft P
.UNINDENT
.UNINDENT

The **LINK\_INTERFACE\_LIBRARIES** mode appends the libraries to the
**INTERFACE\_LINK\_LIBRARIES** target property instead of using them
for linking.  If policy **CMP0022** is not **NEW**, then this mode
also appends libraries to the **LINK\_INTERFACE\_LIBRARIES** and its
per-configuration equivalent.

This signature is for compatibility only.  Prefer the **INTERFACE** mode
instead.

Libraries specified as **debug** are wrapped in a generator expression to
correspond to debug builds.  If policy **CMP0022** is
not **NEW**, the libraries are also appended to the
**LINK\_INTERFACE\_LIBRARIES\_DEBUG**
property (or to the properties corresponding to configurations listed in
the **DEBUG\_CONFIGURATIONS** global property if it is set).
Libraries specified as **optimized** are appended to the
**INTERFACE\_LINK\_LIBRARIES** property.  If policy **CMP0022**
is not **NEW**, they are also appended to the
**LINK\_INTERFACE\_LIBRARIES** property.  Libraries specified as
**general** (or without any keyword) are treated as if specified for both
**debug** and **optimized**.

<a name="linking-object-libraries"></a>

### Linking Object Libraries


Object Libraries may be used as the **&lt;target&gt;** (first) argument
of **target\_link\_libraries** to specify dependencies of their sources
on other libraries.  For example, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(A SHARED a.c)
    target_compile_definitions(A PUBLIC A)
    
    add_library(obj OBJECT obj.c)
    target_compile_definitions(obj PUBLIC OBJ)
    target_link_libraries(obj PUBLIC A)
    .ft P
.UNINDENT
.UNINDENT

compiles **obj.c** with **-DA -DOBJ** and establishes usage requirements
for **obj** that propagate to its dependents.

Normal libraries and executables may link to Object Libraries
to get their objects and usage requirements.  Continuing the above
example, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(B SHARED b.c)
    target_link_libraries(B PUBLIC obj)
    .ft P
.UNINDENT
.UNINDENT

compiles **b.c** with **-DA -DOBJ**, creates shared library **B**
with object files from **b.c** and **obj.c**, and links **B** to **A**.
Furthermore, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(main main.c)
    target_link_libraries(main B)
    .ft P
.UNINDENT
.UNINDENT

compiles **main.c** with **-DA -DOBJ** and links executable **main**
to **B** and **A**.  The object library’s usage requirements are
propagated transitively through **B**, but its object files are not.

Object Libraries may “link” to other object libraries to get
usage requirements, but since they do not have a link step nothing
is done with their object files.  Continuing from the above example,
the code:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(obj2 OBJECT obj2.c)
    target_link_libraries(obj2 PUBLIC obj)
    
    add_executable(main2 main2.c)
    target_link_libraries(main2 obj2)
    .ft P
.UNINDENT
.UNINDENT

compiles **obj2.c** with **-DA -DOBJ**, creates executable **main2**
with object files from **main2.c** and **obj2.c**, and links **main2**
to **A**.

In other words, when Object Libraries appear in a target’s
**INTERFACE\_LINK\_LIBRARIES** property they will be
treated as Interface Libraries, but when they appear in
a target’s **LINK\_LIBRARIES** property their object files
will be included in the link too.

<a name="cyclic-dependencies-of-static-libraries"></a>

### Cyclic Dependencies of Static Libraries


The library dependency graph is normally acyclic (a DAG), but in the case
of mutually-dependent **STATIC** libraries CMake allows the graph to
contain cycles (strongly connected components).  When another target links
to one of the libraries, CMake repeats the entire connected component.
For example, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(A STATIC a.c)
    add_library(B STATIC b.c)
    target_link_libraries(A B)
    target_link_libraries(B A)
    add_executable(main main.c)
    target_link_libraries(main A)
    .ft P
.UNINDENT
.UNINDENT

links **main** to **A B A B**.  While one repetition is usually
sufficient, pathological object file and symbol arrangements can require
more.  One may handle such cases by using the
**LINK\_INTERFACE\_MULTIPLICITY** target property or by manually
repeating the component in the last **target\_link\_libraries** call.
However, if two archives are really so interdependent they should probably
be combined into a single archive, perhaps by using Object Libraries.

<a name="creating-relocatable-packages"></a>

### Creating Relocatable Packages


Note that it is not advisable to populate the
**INTERFACE\_LINK\_LIBRARIES** of a target with absolute paths to dependencies.
That would hard-code into installed packages the library file paths
for dependencies **as found on the machine the package was made on**.

See the Creating Relocatable Packages section of the
**cmake-packages(7)** manual for discussion of additional care
that must be taken when specifying usage requirements while creating
packages for redistribution.

<a name="target_link_options"></a>

### target_link_options


Add options to the link step for an executable, shared library or module
library target.
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_options(<target> [BEFORE]
      <INTERFACE|PUBLIC|PRIVATE> [items1...]
      [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
    .ft P
.UNINDENT
.UNINDENT

The named **&lt;target&gt;** must have been created by a command such as
**add\_executable()** or **add\_library()** and must not be an
ALIAS target.

This command can be used to add any link options, but alternative commands
exist to add libraries (**target\_link\_libraries()** or
**link\_libraries()**).  See documentation of the
**directory** and
**target** **LINK\_OPTIONS** properties.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This command cannot be used to add options for static library targets,
since they do not use a linker.  To add archiver or MSVC librarian flags,
see the **STATIC\_LIBRARY\_OPTIONS** target property.
.UNINDENT
.UNINDENT

If **BEFORE** is specified, the content will be prepended to the property
instead of being appended.

The **INTERFACE**, **PUBLIC** and **PRIVATE** keywords are required to
specify the scope of the following arguments.  **PRIVATE** and **PUBLIC**
items will populate the **LINK\_OPTIONS** property of
**&lt;target&gt;**.  **PUBLIC** and **INTERFACE** items will populate the
**INTERFACE\_LINK\_OPTIONS** property of **&lt;target&gt;**.
(IMPORTED targets only support **INTERFACE** items.)
The following arguments specify link options.  Repeated calls for the same
**&lt;target&gt;** append items in the order called.

Arguments to **target\_link\_options** may use “generator expressions”
with the syntax **$&lt;...&gt;**. See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

The final set of compile or link options used for a target is constructed by
accumulating options from the current target and the usage requirements of
its dependencies.  The set of options is de-duplicated to avoid repetition.
While beneficial for individual options, the de-duplication step can break
up option groups.  For example, **-D A -D B** becomes **-D A B**.  One may
specify a group of options using shell-like quoting along with a **SHELL:**
prefix.  The **SHELL:** prefix is dropped, and the rest of the option string
is parsed using the **separate\_arguments()** **UNIX\_COMMAND** mode.
For example, **"SHELL:-D A" "SHELL:-D B"** becomes **-D A -D B**.

To pass options to the linker tool, each compiler driver has its own syntax.
The **LINKER:** prefix and **,** separator can be used to specify, in a portable
way, options to pass to the linker tool. **LINKER:** is replaced by the
appropriate driver option and **,** by the appropriate driver separator.
The driver prefix and driver separator are given by the values of the
**CMAKE\_&lt;LANG&gt;\_LINKER\_WRAPPER\_FLAG** and
**CMAKE\_&lt;LANG&gt;\_LINKER\_WRAPPER\_FLAG\_SEP** variables.

For example, **"LINKER:-z,defs"** becomes **-Xlinker -z -Xlinker defs** for
**Clang** and **-Wl,-z,defs** for **GNU GCC**.

The **LINKER:** prefix can be specified as part of a **SHELL:** prefix
expression.

The **LINKER:** prefix supports, as an alternative syntax, specification of
arguments using the **SHELL:** prefix and space as separator. The previous
example then becomes **"LINKER:SHELL:-z defs"**.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Specifying the **SHELL:** prefix anywhere other than at the beginning of the
**LINKER:** prefix is not supported.
.UNINDENT
.UNINDENT

<a name="target_precompile_headers"></a>

### target_precompile_headers


Add a list of header files to precompile.

Precompiling header files can speed up compilation by creating a partially
processed version of some header files, and then using that version during
compilations rather than repeatedly parsing the original headers.

<a name="main-form"></a>

### Main Form

.INDENT 0.0
.INDENT 3.5

    .ft C
    target_precompile_headers(<target>
      <INTERFACE|PUBLIC|PRIVATE> [header1...]
      [<INTERFACE|PUBLIC|PRIVATE> [header2...] ...])
    .ft P
.UNINDENT
.UNINDENT

The command adds header files to the **PRECOMPILE\_HEADERS** and/or
**INTERFACE\_PRECOMPILE\_HEADERS** target properties of **&lt;target&gt;**.
The named **&lt;target&gt;** must have been created by a command such as
**add\_executable()** or **add\_library()** and must not be an
ALIAS target.

The **INTERFACE**, **PUBLIC** and **PRIVATE** keywords are required to
specify the scope of the following arguments.  **PRIVATE** and **PUBLIC**
items will populate the **PRECOMPILE\_HEADERS** property of
**&lt;target&gt;**.  **PUBLIC** and **INTERFACE** items will populate the
**INTERFACE\_PRECOMPILE\_HEADERS** property of **&lt;target&gt;**
(IMPORTED targets only support **INTERFACE** items).
Repeated calls for the same **&lt;target&gt;** will append items in the order called.

Projects should generally avoid using **PUBLIC** or **INTERFACE** for targets
that will be exported, or they should at least use
the **$&lt;BUILD\_INTERFACE:...&gt;** generator expression to prevent precompile
headers from appearing in an installed exported target.  Consumers of a target
should typically be in control of what precompile headers they use, not have
precompile headers forced on them by the targets being consumed (since
precompile headers are not typically usage requirements).  A notable exception
to this is where an interface library is created
to define a commonly used set of precompile headers in one place and then other
targets link to that interface library privately.  In this case, the interface
library exists specifically to propagate the precompile headers to its
consumers and the consumer is effectively still in control, since it decides
whether to link to the interface library or not.

The list of header files is used to generate a header file named
**cmake\_pch.h|xx** which is used to generate the precompiled header file
(**.pch**, **.gch**, **.pchi**) artifact.  The **cmake\_pch.h|xx** header
file will be force included (**-include** for GCC, **/FI** for MSVC) to
all source files, so sources do not need to have **#include "pch.h"**.

Header file names specified with angle brackets (e.g. **&lt;unordered\_map&gt;**) or
explicit double quotes (escaped for the **cmake-language(7)**,
e.g. **[["other\_header.h"]]**) will be treated as is, and include directories
must be available for the compiler to find them.  Other header file names
(e.g. **project\_header.h**) are interpreted as being relative to the current
source directory (e.g. **CMAKE\_CURRENT\_SOURCE\_DIR**) and will be
included by absolute path.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_precompile_headers(myTarget
      PUBLIC
        project_header.h
      PRIVATE
        [["other_header.h"]]
        <unordered_map>
    )
    .ft P
.UNINDENT
.UNINDENT

Arguments to **target\_precompile\_headers()** may use “generator expressions”
with the syntax **$&lt;...&gt;**.
See the **cmake-generator-expressions(7)** manual for available
expressions.
The **$&lt;COMPILE\_LANGUAGE:...&gt;** generator expression is particularly
useful for specifying a language-specific header to precompile for
only one language (e.g. **CXX** and not **C**).  In this case, header
file names that are not explicitly in double quotes or angle brackets
must be specified by absolute path.  Also, when specifying angle brackets
inside a generator expression, be sure to encode the closing **&gt;** as
**$&lt;ANGLE-R&gt;**.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_precompile_headers(mylib PRIVATE
      "$<$<COMPILE_LANGUAGE:CXX>:${CMAKE_CURRENT_SOURCE_DIR}/cxx_only.h>"
      "$<$<COMPILE_LANGUAGE:C>:<stddef.h$<ANGLE-R>>"
      "$<$<COMPILE_LANGUAGE:CXX>:<cstddef$<ANGLE-R>>"
    )
    .ft P
.UNINDENT
.UNINDENT

<a name="reusing-precompile-headers"></a>

### Reusing Precompile Headers


The command also supports a second signature which can be used to specify that
one target re-uses a precompiled header file artefact from another target
instead of generating its own:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_precompile_headers(<target> REUSE_FROM <other_target>)
    .ft P
.UNINDENT
.UNINDENT

This form sets the **PRECOMPILE\_HEADERS\_REUSE\_FROM** property to
**&lt;other\_target&gt;** and adds a dependency such that **&lt;target&gt;** will depend
on **&lt;other\_target&gt;**.  CMake will halt with an error if the
**PRECOMPILE\_HEADERS** property of **&lt;target&gt;** is already set when
the **REUSE\_FROM** form is used.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **REUSE\_FROM** form requires the same set of compiler options,
compiler flags and compiler definitions for both **&lt;target&gt;** and
**&lt;other\_target&gt;**.  Some compilers (e.g. GCC) may issue a warning if the
precompiled header file cannot be used (**-Winvalid-pch**).
.UNINDENT
.UNINDENT

<a name="see-also"></a>

### See Also


To disable precompile headers for specific targets, see the
**DISABLE\_PRECOMPILE\_HEADERS** target property.

To prevent precompile headers from being used when compiling a specific
source file, see the **SKIP\_PRECOMPILE\_HEADERS** source file property.

<a name="target_sources"></a>

### target_sources


Add sources to a target.
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_sources(<target>
      <INTERFACE|PUBLIC|PRIVATE> [items1...]
      [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
    .ft P
.UNINDENT
.UNINDENT

Specifies sources to use when compiling a given target.  Relative
source file paths are interpreted as being relative to the current
source directory (i.e. **CMAKE\_CURRENT\_SOURCE\_DIR**).  The
named **&lt;target&gt;** must have been created by a command such as
**add\_executable()** or **add\_library()** and must not be an
ALIAS target.

The **INTERFACE**, **PUBLIC** and **PRIVATE** keywords are required to
specify the scope of the following arguments.  **PRIVATE** and **PUBLIC**
items will populate the **SOURCES** property of
**&lt;target&gt;**.  **PUBLIC** and **INTERFACE** items will populate the
**INTERFACE\_SOURCES** property of **&lt;target&gt;**.
(IMPORTED targets only support **INTERFACE** items.)
The following arguments specify sources.  Repeated calls for the same
**&lt;target&gt;** append items in the order called.

Arguments to **target\_sources** may use “generator expressions”
with the syntax **$&lt;...&gt;**. See the **cmake-generator-expressions(7)**
manual for available expressions.  See the **cmake-buildsystem(7)**
manual for more on defining buildsystem properties.

See also the **CMP0076** policy for older behavior related to the
handling of relative source file paths.

<a name="try_compile"></a>

### try_compile


Try building some code.

<a name="try-compiling-whole-projects"></a>

### Try Compiling Whole Projects

.INDENT 0.0
.INDENT 3.5

    .ft C
    try_compile(<resultVar> <bindir> <srcdir>
                <projectName> [<targetName>] [CMAKE_FLAGS <flags>...]
                [OUTPUT_VARIABLE <var>])
    .ft P
.UNINDENT
.UNINDENT

Try building a project.  The success or failure of the **try\_compile**,
i.e. **TRUE** or **FALSE** respectively, is returned in **&lt;resultVar&gt;**.

In this form, **&lt;srcdir&gt;** should contain a complete CMake project with a
**CMakeLists.txt** file and all sources.  The **&lt;bindir&gt;** and **&lt;srcdir&gt;**
will not be deleted after this command is run.  Specify **&lt;targetName&gt;** to
build a specific target instead of the **all** or **ALL\_BUILD** target.  See
below for the meaning of other options.

<a name="try-compiling-source-files"></a>

### Try Compiling Source Files

.INDENT 0.0
.INDENT 3.5

    .ft C
    try_compile(<resultVar> <bindir> <srcfile|SOURCES srcfile...>
                [CMAKE_FLAGS <flags>...]
                [COMPILE_DEFINITIONS <defs>...]
                [LINK_OPTIONS <options>...]
                [LINK_LIBRARIES <libs>...]
                [OUTPUT_VARIABLE <var>]
                [COPY_FILE <fileName> [COPY_FILE_ERROR <var>]]
                [<LANG>_STANDARD <std>]
                [<LANG>_STANDARD_REQUIRED <bool>]
                [<LANG>_EXTENSIONS <bool>]
                )
    .ft P
.UNINDENT
.UNINDENT

Try building an executable or static library from one or more source files
(which one is determined by the **CMAKE\_TRY\_COMPILE\_TARGET\_TYPE**
variable).  The success or failure of the **try\_compile**, i.e. **TRUE** or
**FALSE** respectively, is returned in **&lt;resultVar&gt;**.

In this form, one or more source files must be provided.  If
**CMAKE\_TRY\_COMPILE\_TARGET\_TYPE** is unset or is set to **EXECUTABLE**,
the sources must include a definition for **main** and CMake will create a
**CMakeLists.txt** file to build the source(s) as an executable.
If **CMAKE\_TRY\_COMPILE\_TARGET\_TYPE** is set to **STATIC\_LIBRARY**,
a static library will be built instead and no definition for **main** is
required.  For an executable, the generated **CMakeLists.txt** file would
contain something like the following:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_definitions(<expanded COMPILE_DEFINITIONS from caller>)
    include_directories(${INCLUDE_DIRECTORIES})
    link_directories(${LINK_DIRECTORIES})
    add_executable(cmTryCompileExec <srcfile>...)
    target_link_options(cmTryCompileExec PRIVATE <LINK_OPTIONS from caller>)
    target_link_libraries(cmTryCompileExec ${LINK_LIBRARIES})
    .ft P
.UNINDENT
.UNINDENT

The options are:
.INDENT 0.0

* <b>**CMAKE_FLAGS &lt;flags&gt;...**</b>  
  Specify flags of the form **-DVAR:TYPE=VALUE** to be passed to
  the **cmake** command-line used to drive the test build.
  The above example shows how values for variables
  **INCLUDE\_DIRECTORIES**, **LINK\_DIRECTORIES**, and **LINK\_LIBRARIES**
  are used.
* <b>**COMPILE_DEFINITIONS &lt;defs&gt;...**</b>  
  Specify **-Ddefinition** arguments to pass to **add\_definitions()**
  in the generated test project.
* <b>**COPY_FILE &lt;fileName&gt;**</b>  
  Copy the built executable or static library to the given **&lt;fileName&gt;**.
* <b>**COPY_FILE_ERROR &lt;var&gt;**</b>  
  Use after **COPY\_FILE** to capture into variable **&lt;var&gt;** any error
  message encountered while trying to copy the file.
* <b>**LINK_LIBRARIES &lt;libs&gt;...**</b>  
  Specify libraries to be linked in the generated project.
  The list of libraries may refer to system libraries and to
  Imported Targets from the calling project.

If this option is specified, any **-DLINK\_LIBRARIES=...** value
given to the **CMAKE\_FLAGS** option will be ignored.

* <b>**LINK_OPTIONS &lt;options&gt;...**</b>  
  Specify link step options to pass to **target\_link\_options()** or to
  set the **STATIC\_LIBRARY\_OPTIONS** target property in the generated
  project, depending on the **CMAKE\_TRY\_COMPILE\_TARGET\_TYPE** variable.
* <b>**OUTPUT_VARIABLE &lt;var&gt;**</b>  
  Store the output from the build process in the given variable.
* <b>**&lt;LANG&gt;_STANDARD &lt;std&gt;**</b>  
  Specify the **C\_STANDARD**, **CXX\_STANDARD**,
  **OBJC\_STANDARD**, **OBJCXX\_STANDARD**,
  or **CUDA\_STANDARD** target property of the generated project.
* <b>**&lt;LANG&gt;_STANDARD_REQUIRED &lt;bool&gt;**</b>  
  Specify the **C\_STANDARD\_REQUIRED**,
  **CXX\_STANDARD\_REQUIRED**, **OBJC\_STANDARD\_REQUIRED**,
  **OBJCXX\_STANDARD\_REQUIRED**,or **CUDA\_STANDARD\_REQUIRED**
  target property of the generated project.
* <b>**&lt;LANG&gt;_EXTENSIONS &lt;bool&gt;**</b>  
  Specify the **C\_EXTENSIONS**, **CXX\_EXTENSIONS**,
  **OBJC\_EXTENSIONS**, **OBJCXX\_EXTENSIONS**,
  or **CUDA\_EXTENSIONS** target property of the generated project.
  .UNINDENT

In this version all files in **&lt;bindir&gt;/CMakeFiles/CMakeTmp** will be
cleaned automatically.  For debugging, **--debug-trycompile** can be
passed to **cmake** to avoid this clean.  However, multiple sequential
**try\_compile** operations reuse this single output directory.  If you use
**--debug-trycompile**, you can only debug one **try\_compile** call at a time.
The recommended procedure is to protect all **try\_compile** calls in your
project by **if(NOT DEFINED &lt;resultVar&gt;)** logic, configure with cmake
all the way through once, then delete the cache entry associated with
the try_compile call of interest, and then re-run cmake again with
**--debug-trycompile**.

<a name="other-behavior-settings"></a>

### Other Behavior Settings


If set, the following variables are passed in to the generated
try_compile CMakeLists.txt to initialize compile target properties with
default values:
.INDENT 0.0

* ·  
  **CMAKE\_ENABLE\_EXPORTS**
* ·  
  **CMAKE\_LINK\_SEARCH\_START\_STATIC**
* ·  
  **CMAKE\_LINK\_SEARCH\_END\_STATIC**
* ·  
  **CMAKE\_MSVC\_RUNTIME\_LIBRARY**
* ·  
  **CMAKE\_POSITION\_INDEPENDENT\_CODE**
  .UNINDENT

If **CMP0056** is set to **NEW**, then
**CMAKE\_EXE\_LINKER\_FLAGS** is passed in as well.

If **CMP0083** is set to **NEW**, then in order to obtain correct
behavior at link time, the **check\_pie\_supported()** command from the
**CheckPIESupported** module must be called before using the
_try\_compile()_ command.

The current settings of **CMP0065** and **CMP0083** are propagated
through to the generated test project.

Set the **CMAKE\_TRY\_COMPILE\_CONFIGURATION** variable to choose
a build configuration.

Set the **CMAKE\_TRY\_COMPILE\_TARGET\_TYPE** variable to specify
the type of target used for the source file signature.

Set the **CMAKE\_TRY\_COMPILE\_PLATFORM\_VARIABLES** variable to specify
variables that must be propagated into the test project.  This variable is
meant for use only in toolchain files and is only honored by the
**try\_compile()** command for the source files form, not when given a whole
project.

If **CMP0067** is set to **NEW**, or any of the **&lt;LANG&gt;\_STANDARD**,
**&lt;LANG&gt;\_STANDARD\_REQUIRED**, or **&lt;LANG&gt;\_EXTENSIONS** options are used,
then the language standard variables are honored:
.INDENT 0.0

* ·  
  **CMAKE\_C\_STANDARD**
* ·  
  **CMAKE\_C\_STANDARD\_REQUIRED**
* ·  
  **CMAKE\_C\_EXTENSIONS**
* ·  
  **CMAKE\_CXX\_STANDARD**
* ·  
  **CMAKE\_CXX\_STANDARD\_REQUIRED**
* ·  
  **CMAKE\_CXX\_EXTENSIONS**
* ·  
  **CMAKE\_OBJC\_STANDARD**
* ·  
  **CMAKE\_OBJC\_STANDARD\_REQUIRED**
* ·  
  **CMAKE\_OBJC\_EXTENSIONS**
* ·  
  **CMAKE\_OBJCXX\_STANDARD**
* ·  
  **CMAKE\_OBJCXX\_STANDARD\_REQUIRED**
* ·  
  **CMAKE\_OBJCXX\_EXTENSIONS**
* ·  
  **CMAKE\_CUDA\_STANDARD**
* ·  
  **CMAKE\_CUDA\_STANDARD\_REQUIRED**
* ·  
  **CMAKE\_CUDA\_EXTENSIONS**
  .UNINDENT

Their values are used to set the corresponding target properties in
the generated project (unless overridden by an explicit option).

For the **Green Hills MULTI** generator the GHS toolset and target
system customization cache variables are also propagated into the test project.

<a name="try_run"></a>

### try_run


Try compiling and then running some code.

<a name="try-compiling-and-running-source-files"></a>

### Try Compiling and Running Source Files

.INDENT 0.0
.INDENT 3.5

    .ft C
    try_run(<runResultVar> <compileResultVar>
            <bindir> <srcfile> [CMAKE_FLAGS <flags>...]
            [COMPILE_DEFINITIONS <defs>...]
            [LINK_OPTIONS <options>...]
            [LINK_LIBRARIES <libs>...]
            [COMPILE_OUTPUT_VARIABLE <var>]
            [RUN_OUTPUT_VARIABLE <var>]
            [OUTPUT_VARIABLE <var>]
            [ARGS <args>...])
    .ft P
.UNINDENT
.UNINDENT

Try compiling a **&lt;srcfile&gt;**.  Returns **TRUE** or **FALSE** for success
or failure in **&lt;compileResultVar&gt;**.  If the compile succeeded, runs the
executable and returns its exit code in **&lt;runResultVar&gt;**.  If the
executable was built, but failed to run, then **&lt;runResultVar&gt;** will be
set to **FAILED\_TO\_RUN**.  See the **try\_compile()** command for
information on how the test project is constructed to build the source file.

The options are:
.INDENT 0.0

* <b>**CMAKE_FLAGS &lt;flags&gt;...**</b>  
  Specify flags of the form **-DVAR:TYPE=VALUE** to be passed to
  the **cmake** command-line used to drive the test build.
  The example in **try\_compile()** shows how values for variables
  **INCLUDE\_DIRECTORIES**, **LINK\_DIRECTORIES**, and **LINK\_LIBRARIES**
  are used.
* <b>**COMPILE_DEFINITIONS &lt;defs&gt;...**</b>  
  Specify **-Ddefinition** arguments to pass to **add\_definitions()**
  in the generated test project.
* <b>**COMPILE_OUTPUT_VARIABLE &lt;var&gt;**</b>  
  Report the compile step build output in a given variable.
* <b>**LINK_LIBRARIES &lt;libs&gt;...**</b>  
  Specify libraries to be linked in the generated project.
  The list of libraries may refer to system libraries and to
  Imported Targets from the calling project.

If this option is specified, any **-DLINK\_LIBRARIES=...** value
given to the **CMAKE\_FLAGS** option will be ignored.

* <b>**LINK_OPTIONS &lt;options&gt;...**</b>  
  Specify link step options to pass to **target\_link\_options()** in the
  generated project.
* <b>**OUTPUT_VARIABLE &lt;var&gt;**</b>  
  Report the compile build output and the output from running the executable
  in the given variable.  This option exists for legacy reasons.  Prefer
  **COMPILE\_OUTPUT\_VARIABLE** and **RUN\_OUTPUT\_VARIABLE** instead.
* <b>**RUN_OUTPUT_VARIABLE &lt;var&gt;**</b>  
  Report the output from running the executable in a given variable.
  .UNINDENT

<a name="other-behavior-settings"></a>

### Other Behavior Settings


Set the **CMAKE\_TRY\_COMPILE\_CONFIGURATION** variable to choose
a build configuration.

<a name="behavior-when-cross-compiling"></a>

### Behavior when Cross Compiling


When cross compiling, the executable compiled in the first step
usually cannot be run on the build host.  The **try\_run** command checks
the **CMAKE\_CROSSCOMPILING** variable to detect whether CMake is in
cross-compiling mode.  If that is the case, it will still try to compile
the executable, but it will not try to run the executable unless the
**CMAKE\_CROSSCOMPILING\_EMULATOR** variable is set.  Instead it
will create cache variables which must be filled by the user or by
presetting them in some CMake script file to the values the executable
would have produced if it had been run on its actual target platform.
These cache entries are:
.INDENT 0.0

* <b>**&lt;runResultVar&gt;**</b>  
  Exit code if the executable were to be run on the target platform.
* <b>**&lt;runResultVar&gt;\_\_TRYRUN\_OUTPUT**</b>  
  Output from stdout and stderr if the executable were to be run on
  the target platform.  This is created only if the
  **RUN\_OUTPUT\_VARIABLE** or **OUTPUT\_VARIABLE** option was used.
  .UNINDENT

In order to make cross compiling your project easier, use **try\_run**
only if really required.  If you use **try\_run**, use the
**RUN\_OUTPUT\_VARIABLE** or **OUTPUT\_VARIABLE** options only if really
required.  Using them will require that when cross-compiling, the cache
variables will have to be set manually to the output of the executable.
You can also “guard” the calls to **try\_run** with an **if()**
block checking the **CMAKE\_CROSSCOMPILING** variable and
provide an easy-to-preset alternative for this case.

<a name="ctest-commands"></a>

# Ctest Commands


These commands are available only in CTest scripts.

<a name="ctest_build"></a>

### ctest_build


Perform the CTest Build Step as a Dashboard Client.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_build([BUILD <build-dir>] [APPEND]
                [CONFIGURATION <config>]
                [FLAGS <flags>]
                [PROJECT_NAME <project-name>]
                [TARGET <target-name>]
                [NUMBER_ERRORS <num-err-var>]
                [NUMBER_WARNINGS <num-warn-var>]
                [RETURN_VALUE <result-var>]
                [CAPTURE_CMAKE_ERROR <result-var>]
                )
    .ft P
.UNINDENT
.UNINDENT

Build the project and store results in **Build.xml**
for submission with the **ctest\_submit()** command.

The **CTEST\_BUILD\_COMMAND** variable may be set to explicitly
specify the build command line.  Otherwise the build command line is
computed automatically based on the options given.

The options are:
.INDENT 0.0

* <b>**BUILD &lt;build-dir&gt;**</b>  
  Specify the top-level build directory.  If not given, the
  **CTEST\_BINARY\_DIRECTORY** variable is used.
* <b>**APPEND**</b>  
  Mark **Build.xml** for append to results previously submitted to a
  dashboard server since the last **ctest\_start()** call.
  Append semantics are defined by the dashboard server in use.
  This does _not_ cause results to be appended to a **.xml** file
  produced by a previous call to this command.
* <b>**CONFIGURATION &lt;config&gt;**</b>  
  Specify the build configuration (e.g. **Debug**).  If not
  specified the **CTEST\_BUILD\_CONFIGURATION** variable will be checked.
  Otherwise the **-C &lt;cfg&gt;** option given to the **ctest(1)**
  command will be used, if any.
* <b>**FLAGS &lt;flags&gt;**</b>  
  Pass additional arguments to the underlying build command.
  If not specified the **CTEST\_BUILD\_FLAGS** variable will be checked.
  This can, e.g., be used to trigger a parallel build using the
  **-j** option of make. See the **ProcessorCount** module
  for an example.
* <b>**PROJECT_NAME &lt;project-name&gt;**</b>  
  Ignored.  This was once used but is no longer needed.
* <b>**TARGET &lt;target-name&gt;**</b>  
  Specify the name of a target to build.  If not specified the
  **CTEST\_BUILD\_TARGET** variable will be checked.  Otherwise the
  default target will be built.  This is the “all” target
  (called **ALL\_BUILD** in Visual Studio Generators).
* <b>**NUMBER_ERRORS &lt;num-err-var&gt;**</b>  
  Store the number of build errors detected in the given variable.
* <b>**NUMBER_WARNINGS &lt;num-warn-var&gt;**</b>  
  Store the number of build warnings detected in the given variable.
* <b>**RETURN_VALUE &lt;result-var&gt;**</b>  
  Store the return value of the native build tool in the given variable.
* <b>**CAPTURE_CMAKE_ERROR &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable -1 if there are any errors running
  the command and prevent ctest from returning non-zero if an error occurs.
* <b>**QUIET**</b>  
  Suppress any CTest-specific non-error output that would have been
  printed to the console otherwise.  The summary of warnings / errors,
  as well as the output from the native build tool is unaffected by
  this option.
  .UNINDENT

<a name="ctest_configure"></a>

### ctest_configure


Perform the CTest Configure Step as a Dashboard Client.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_configure([BUILD <build-dir>] [SOURCE <source-dir>] [APPEND]
                    [OPTIONS <options>] [RETURN_VALUE <result-var>] [QUIET]
                    [CAPTURE_CMAKE_ERROR <result-var>])
    .ft P
.UNINDENT
.UNINDENT

Configure the project build tree and record results in **Configure.xml**
for submission with the **ctest\_submit()** command.

The options are:
.INDENT 0.0

* <b>**BUILD &lt;build-dir&gt;**</b>  
  Specify the top-level build directory.  If not given, the
  **CTEST\_BINARY\_DIRECTORY** variable is used.
* <b>**SOURCE &lt;source-dir&gt;**</b>  
  Specify the source directory.  If not given, the
  **CTEST\_SOURCE\_DIRECTORY** variable is used.
* <b>**APPEND**</b>  
  Mark **Configure.xml** for append to results previously submitted to a
  dashboard server since the last **ctest\_start()** call.
  Append semantics are defined by the dashboard server in use.
  This does _not_ cause results to be appended to a **.xml** file
  produced by a previous call to this command.
* <b>**OPTIONS &lt;options&gt;**</b>  
  Specify command-line arguments to pass to the configuration tool.
* <b>**RETURN_VALUE &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable the return value of the native
  configuration tool.
* <b>**CAPTURE_CMAKE_ERROR &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable -1 if there are any errors running
  the command and prevent ctest from returning non-zero if an error occurs.
* <b>**QUIET**</b>  
  Suppress any CTest-specific non-error messages that would have
  otherwise been printed to the console.  Output from the underlying
  configure command is not affected.
  .UNINDENT

<a name="ctest_coverage"></a>

### ctest_coverage


Perform the CTest Coverage Step as a Dashboard Client.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_coverage([BUILD <build-dir>] [APPEND]
                   [LABELS <label>...]
                   [RETURN_VALUE <result-var>]
                   [CAPTURE_CMAKE_ERROR <result-var>]
                   [QUIET]
                   )
    .ft P
.UNINDENT
.UNINDENT

Collect coverage tool results and stores them in **Coverage.xml**
for submission with the **ctest\_submit()** command.

The options are:
.INDENT 0.0

* <b>**BUILD &lt;build-dir&gt;**</b>  
  Specify the top-level build directory.  If not given, the
  **CTEST\_BINARY\_DIRECTORY** variable is used.
* <b>**APPEND**</b>  
  Mark **Coverage.xml** for append to results previously submitted to a
  dashboard server since the last **ctest\_start()** call.
  Append semantics are defined by the dashboard server in use.
  This does _not_ cause results to be appended to a **.xml** file
  produced by a previous call to this command.
* <b>**LABELS**</b>  
  Filter the coverage report to include only source files labeled
  with at least one of the labels specified.
* <b>**RETURN_VALUE &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable **0** if coverage tools
  ran without error and non-zero otherwise.
* <b>**CAPTURE_CMAKE_ERROR &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable -1 if there are any errors running
  the command and prevent ctest from returning non-zero if an error occurs.
* <b>**QUIET**</b>  
  Suppress any CTest-specific non-error output that would have been
  printed to the console otherwise.  The summary indicating how many
  lines of code were covered is unaffected by this option.
  .UNINDENT

<a name="ctest_empty_binary_directory"></a>

### ctest_empty_binary_directory


empties the binary directory
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_empty_binary_directory( directory )
    .ft P
.UNINDENT
.UNINDENT

Removes a binary directory.  This command will perform some checks
prior to deleting the directory in an attempt to avoid malicious or
accidental directory deletion.

<a name="ctest_memcheck"></a>

### ctest_memcheck


Perform the CTest MemCheck Step as a Dashboard Client.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_memcheck([BUILD <build-dir>] [APPEND]
                   [START <start-number>]
                   [END <end-number>]
                   [STRIDE <stride-number>]
                   [EXCLUDE <exclude-regex>]
                   [INCLUDE <include-regex>]
                   [EXCLUDE_LABEL <label-exclude-regex>]
                   [INCLUDE_LABEL <label-include-regex>]
                   [EXCLUDE_FIXTURE <regex>]
                   [EXCLUDE_FIXTURE_SETUP <regex>]
                   [EXCLUDE_FIXTURE_CLEANUP <regex>]
                   [PARALLEL_LEVEL <level>]
                   [TEST_LOAD <threshold>]
                   [SCHEDULE_RANDOM <ON|OFF>]
                   [STOP_TIME <time-of-day>]
                   [RETURN_VALUE <result-var>]
                   [DEFECT_COUNT <defect-count-var>]
                   [QUIET]
                   )
    .ft P
.UNINDENT
.UNINDENT

Run tests with a dynamic analysis tool and store results in
**MemCheck.xml** for submission with the **ctest\_submit()**
command.

Most options are the same as those for the **ctest\_test()** command.

The options unique to this command are:
.INDENT 0.0

* <b>**DEFECT_COUNT &lt;defect-count-var&gt;**</b>  
  Store in the **&lt;defect-count-var&gt;** the number of defects found.
  .UNINDENT

<a name="ctest_read_custom_files"></a>

### ctest_read_custom_files


read CTestCustom files.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_read_custom_files( directory ... )
    .ft P
.UNINDENT
.UNINDENT

Read all the CTestCustom.ctest or CTestCustom.cmake files from the
given directory.

By default, invoking **ctest(1)** without a script will read custom
files from the binary directory.

<a name="ctest_run_script"></a>

### ctest_run_script


runs a ctest -S script
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_run_script([NEW_PROCESS] script_file_name script_file_name1
                script_file_name2 ... [RETURN_VALUE var])
    .ft P
.UNINDENT
.UNINDENT

Runs a script or scripts much like if it was run from ctest -S.  If no
argument is provided then the current script is run using the current
settings of the variables.  If **NEW\_PROCESS** is specified then each
script will be run in a separate process.If **RETURN\_VALUE** is specified
the return value of the last script run will be put into **var**.

<a name="ctest_sleep"></a>

### ctest_sleep


sleeps for some amount of time
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_sleep(<seconds>)
    .ft P
.UNINDENT
.UNINDENT

Sleep for given number of seconds.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_sleep(<time1> <duration> <time2>)
    .ft P
.UNINDENT
.UNINDENT

Sleep for t=(time1 + duration - time2) seconds if t &gt; 0.

<a name="ctest_start"></a>

### ctest_start


Starts the testing for a given model
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_start(<model> [<source> [<binary>]] [GROUP <group>] [QUIET])
    
    ctest_start([<model> [<source> [<binary>]]] [GROUP <group>] APPEND [QUIET])
    .ft P
.UNINDENT
.UNINDENT

Starts the testing for a given model.  The command should be called
after the binary directory is initialized.

The parameters are as follows:
.INDENT 0.0

* <b>**&lt;model&gt;**</b>  
  Set the dashboard model. Must be one of **Experimental**, **Continuous**, or
  **Nightly**. This parameter is required unless **APPEND** is specified.
* <b>**&lt;source&gt;**</b>  
  Set the source directory. If not specified, the value of
  **CTEST\_SOURCE\_DIRECTORY** is used instead.
* <b>**&lt;binary&gt;**</b>  
  Set the binary directory. If not specified, the value of
  **CTEST\_BINARY\_DIRECTORY** is used instead.
* <b>**GROUP &lt;group&gt;**</b>  
  If **GROUP** is used, the submissions will go to the specified group on the
  CDash server. If no **GROUP** is specified, the name of the model is used by
  default. This replaces the deprecated option **TRACK**. Despite the name
  change its behavior is unchanged.
* <b>**APPEND**</b>  
  If **APPEND** is used, the existing **TAG** is used rather than creating a new
  one based on the current time stamp. If you use **APPEND**, you can omit the
  **&lt;model&gt;** and **GROUP &lt;group&gt;** parameters, because they will be read from
  the generated **TAG** file. For example:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    ctest_start(Experimental GROUP GroupExperimental)
    .ft P
.UNINDENT
.UNINDENT

Later, in another **ctest -S** script:
.INDENT 7.0
.INDENT 3.5

    .ft C
    ctest_start(APPEND)
    .ft P
.UNINDENT
.UNINDENT

When the second script runs **ctest\_start(APPEND)**, it will read the
**Experimental** model and **GroupExperimental** group from the **TAG** file
generated by the first **ctest\_start()** command. Please note that if you
call **ctest\_start(APPEND)** and specify a different model or group than
in the first **ctest\_start()** command, a warning will be issued, and the
new model and group will be used.

* <b>**QUIET**</b>  
  If **QUIET** is used, CTest will suppress any non-error messages that it
  otherwise would have printed to the console.
  .UNINDENT

The parameters for **ctest\_start()** can be issued in any order, with the
exception that **&lt;model&gt;**, **&lt;source&gt;**, and **&lt;binary&gt;** have to appear
in that order with respect to each other. The following are all valid and
equivalent:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_start(Experimental path/to/source path/to/binary GROUP SomeGroup QUIET APPEND)
    
    ctest_start(GROUP SomeGroup Experimental QUIET path/to/source APPEND path/to/binary)
    
    ctest_start(APPEND QUIET Experimental path/to/source GROUP SomeGroup path/to/binary)
    .ft P
.UNINDENT
.UNINDENT

However, for the sake of readability, it is recommended that you order your
parameters in the order listed at the top of this page.

If the **CTEST\_CHECKOUT\_COMMAND** variable (or the
**CTEST\_CVS\_CHECKOUT** variable) is set, its content is treated as
command-line.  The command is invoked with the current working directory set
to the parent of the source directory, even if the source directory already
exists.  This can be used to create the source tree from a version control
repository.

<a name="ctest_submit"></a>

### ctest_submit


Perform the CTest Submit Step as a Dashboard Client.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_submit([PARTS <part>...] [FILES <file>...]
                 [SUBMIT_URL <url>]
                 [BUILD_ID <result-var>]
                 [HTTPHEADER <header>]
                 [RETRY_COUNT <count>]
                 [RETRY_DELAY <delay>]
                 [RETURN_VALUE <result-var>]
                 [CAPTURE_CMAKE_ERROR <result-var>]
                 [QUIET]
                 )
    .ft P
.UNINDENT
.UNINDENT

Submit results to a dashboard server.
By default all available parts are submitted.

The options are:
.INDENT 0.0

* <b>**PARTS &lt;part&gt;...**</b>  
  Specify a subset of parts to submit.  Valid part names are:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    Start      = nothing
    Update     = ctest_update results, in Update.xml
    Configure  = ctest_configure results, in Configure.xml
    Build      = ctest_build results, in Build.xml
    Test       = ctest_test results, in Test.xml
    Coverage   = ctest_coverage results, in Coverage.xml
    MemCheck   = ctest_memcheck results, in DynamicAnalysis.xml
    Notes      = Files listed by CTEST_NOTES_FILES, in Notes.xml
    ExtraFiles = Files listed by CTEST_EXTRA_SUBMIT_FILES
    Upload     = Files prepared for upload by ctest_upload(), in Upload.xml
    Submit     = nothing
    Done       = Build is complete, in Done.xml
    .ft P
.UNINDENT
.UNINDENT

* <b>**FILES &lt;file&gt;...**</b>  
  Specify an explicit list of specific files to be submitted.
  Each individual file must exist at the time of the call.
* <b>**SUBMIT_URL &lt;url&gt;**</b>  
  The **http** or **https** URL of the dashboard server to send the submission
  to.  If not given, the **CTEST\_SUBMIT\_URL** variable is used.
* <b>**BUILD_ID &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable the ID assigned to this build by
  CDash.
* <b>**HTTPHEADER &lt;HTTP-header&gt;**</b>  
  Specify HTTP header to be included in the request to CDash during submission.
  For example, CDash can be configured to only accept submissions from
  authenticated clients. In this case, you should provide a bearer token in your
  header:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    ctest_submit(HTTPHEADER "Authorization: Bearer <auth-token>")
    .ft P
.UNINDENT
.UNINDENT

This suboption can be repeated several times for multiple headers.

* <b>**RETRY_COUNT &lt;count&gt;**</b>  
  Specify how many times to retry a timed-out submission.
* <b>**RETRY_DELAY &lt;delay&gt;**</b>  
  Specify how long (in seconds) to wait after a timed-out submission
  before attempting to re-submit.
* <b>**RETURN_VALUE &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable **0** for success and
  non-zero on failure.
* <b>**CAPTURE_CMAKE_ERROR &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable -1 if there are any errors running
  the command and prevent ctest from returning non-zero if an error occurs.
* <b>**QUIET**</b>  
  Suppress all non-error messages that would have otherwise been
  printed to the console.
  .UNINDENT

<a name="submit-to-cdash-upload-api"></a>

### Submit to CDash Upload API

.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_submit(CDASH_UPLOAD <file> [CDASH_UPLOAD_TYPE <type>]
                 [SUBMIT_URL <url>]
                 [HTTPHEADER <header>]
                 [RETRY_COUNT <count>]
                 [RETRY_DELAY <delay>]
                 [RETURN_VALUE <result-var>]
                 [QUIET])
    .ft P
.UNINDENT
.UNINDENT

This second signature is used to upload files to CDash via the CDash
file upload API. The API first sends a request to upload to CDash along
with a content hash of the file. If CDash does not already have the file,
then it is uploaded. Along with the file, a CDash type string is specified
to tell CDash which handler to use to process the data.

This signature accepts the **SUBMIT\_URL**, **BUILD\_ID**, **HTTPHEADER**,
**RETRY\_COUNT**, **RETRY\_DELAY**, **RETURN\_VALUE** and **QUIET** options
as described above.

<a name="ctest_test"></a>

### ctest_test


Perform the CTest Test Step as a Dashboard Client.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_test([BUILD <build-dir>] [APPEND]
               [START <start-number>]
               [END <end-number>]
               [STRIDE <stride-number>]
               [EXCLUDE <exclude-regex>]
               [INCLUDE <include-regex>]
               [EXCLUDE_LABEL <label-exclude-regex>]
               [INCLUDE_LABEL <label-include-regex>]
               [EXCLUDE_FIXTURE <regex>]
               [EXCLUDE_FIXTURE_SETUP <regex>]
               [EXCLUDE_FIXTURE_CLEANUP <regex>]
               [PARALLEL_LEVEL <level>]
               [RESOURCE_SPEC_FILE <file>]
               [TEST_LOAD <threshold>]
               [SCHEDULE_RANDOM <ON|OFF>]
               [STOP_TIME <time-of-day>]
               [RETURN_VALUE <result-var>]
               [CAPTURE_CMAKE_ERROR <result-var>]
               [REPEAT <mode>:<n>]
               [QUIET]
               )
    .ft P
.UNINDENT
.UNINDENT

Run tests in the project build tree and store results in
**Test.xml** for submission with the **ctest\_submit()** command.

The options are:
.INDENT 0.0

* <b>**BUILD &lt;build-dir&gt;**</b>  
  Specify the top-level build directory.  If not given, the
  **CTEST\_BINARY\_DIRECTORY** variable is used.
* <b>**APPEND**</b>  
  Mark **Test.xml** for append to results previously submitted to a
  dashboard server since the last **ctest\_start()** call.
  Append semantics are defined by the dashboard server in use.
  This does _not_ cause results to be appended to a **.xml** file
  produced by a previous call to this command.
* <b>**START &lt;start-number&gt;**</b>  
  Specify the beginning of a range of test numbers.
* <b>**END &lt;end-number&gt;**</b>  
  Specify the end of a range of test numbers.
* <b>**STRIDE &lt;stride-number&gt;**</b>  
  Specify the stride by which to step across a range of test numbers.
* <b>**EXCLUDE &lt;exclude-regex&gt;**</b>  
  Specify a regular expression matching test names to exclude.
* <b>**INCLUDE &lt;include-regex&gt;**</b>  
  Specify a regular expression matching test names to include.
  Tests not matching this expression are excluded.
* <b>**EXCLUDE_LABEL &lt;label-exclude-regex&gt;**</b>  
  Specify a regular expression matching test labels to exclude.
* <b>**INCLUDE_LABEL &lt;label-include-regex&gt;**</b>  
  Specify a regular expression matching test labels to include.
  Tests not matching this expression are excluded.
* <b>**EXCLUDE_FIXTURE &lt;regex&gt;**</b>  
  If a test in the set of tests to be executed requires a particular fixture,
  that fixture’s setup and cleanup tests would normally be added to the test
  set automatically. This option prevents adding setup or cleanup tests for
  fixtures matching the **&lt;regex&gt;**. Note that all other fixture behavior is
  retained, including test dependencies and skipping tests that have fixture
  setup tests that fail.
* <b>**EXCLUDE_FIXTURE_SETUP &lt;regex&gt;**</b>  
  Same as **EXCLUDE\_FIXTURE** except only matching setup tests are excluded.
* <b>**EXCLUDE_FIXTURE_CLEANUP &lt;regex&gt;**</b>  
  Same as **EXCLUDE\_FIXTURE** except only matching cleanup tests are excluded.
* <b>**PARALLEL_LEVEL &lt;level&gt;**</b>  
  Specify a positive number representing the number of tests to
  be run in parallel.
* <b>**RESOURCE_SPEC_FILE &lt;file&gt;**</b>  
  Specify a
  resource specification file. See
  ctest-resource-allocation for more information.
* <b>**TEST_LOAD &lt;threshold&gt;**</b>  
  While running tests in parallel, try not to start tests when they
  may cause the CPU load to pass above a given threshold.  If not
  specified the **CTEST\_TEST\_LOAD** variable will be checked,
  and then the **--test-load** command-line argument to **ctest(1)**.
  See also the **TestLoad** setting in the CTest Test Step.
* <b>**REPEAT &lt;mode&gt;:&lt;n&gt;**</b>  
  Run tests repeatedly based on the given **&lt;mode&gt;** up to **&lt;n&gt;** times.
  The modes are:
  .INDENT 7.0
* <b>**UNTIL\_FAIL**</b>  
  Require each test to run **&lt;n&gt;** times without failing in order to pass.
  This is useful in finding sporadic failures in test cases.
* <b>**UNTIL\_PASS**</b>  
  Allow each test to run up to **&lt;n&gt;** times in order to pass.
  Repeats tests if they fail for any reason.
  This is useful in tolerating sporadic failures in test cases.
* <b>**AFTER\_TIMEOUT**</b>  
  Allow each test to run up to **&lt;n&gt;** times in order to pass.
  Repeats tests only if they timeout.
  This is useful in tolerating sporadic timeouts in test cases
  on busy machines.
  .UNINDENT
* <b>**SCHEDULE_RANDOM &lt;ON|OFF&gt;**</b>  
  Launch tests in a random order.  This may be useful for detecting
  implicit test dependencies.
* <b>**STOP_TIME &lt;time-of-day&gt;**</b>  
  Specify a time of day at which the tests should all stop running.
* <b>**RETURN_VALUE &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable **0** if all tests passed.
  Store non-zero if anything went wrong.
* <b>**CAPTURE_CMAKE_ERROR &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable -1 if there are any errors running
  the command and prevent ctest from returning non-zero if an error occurs.
* <b>**QUIET**</b>  
  Suppress any CTest-specific non-error messages that would have otherwise
  been printed to the console.  Output from the underlying test command is not
  affected.  Summary info detailing the percentage of passing tests is also
  unaffected by the **QUIET** option.
  .UNINDENT

See also the **CTEST\_CUSTOM\_MAXIMUM\_PASSED\_TEST\_OUTPUT\_SIZE**
and **CTEST\_CUSTOM\_MAXIMUM\_FAILED\_TEST\_OUTPUT\_SIZE** variables.

<a name="ctest_update"></a>

### ctest_update


Perform the CTest Update Step as a Dashboard Client.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_update([SOURCE <source-dir>]
                 [RETURN_VALUE <result-var>]
                 [CAPTURE_CMAKE_ERROR <result-var>]
                 [QUIET])
    .ft P
.UNINDENT
.UNINDENT

Update the source tree from version control and record results in
**Update.xml** for submission with the **ctest\_submit()** command.

The options are:
.INDENT 0.0

* <b>**SOURCE &lt;source-dir&gt;**</b>  
  Specify the source directory.  If not given, the
  **CTEST\_SOURCE\_DIRECTORY** variable is used.
* <b>**RETURN_VALUE &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable the number of files
  updated or **-1** on error.
* <b>**CAPTURE_CMAKE_ERROR &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable -1 if there are any errors running
  the command and prevent ctest from returning non-zero if an error occurs.
* <b>**QUIET**</b>  
  Tell CTest to suppress most non-error messages that it would
  have otherwise printed to the console.  CTest will still report
  the new revision of the repository and any conflicting files
  that were found.
  .UNINDENT

The update always follows the version control branch currently checked
out in the source directory.  See the CTest Update Step
documentation for information about variables that change the behavior
of **ctest\_update()**.

<a name="ctest_upload"></a>

### ctest_upload


Upload files to a dashboard server as a Dashboard Client.
.INDENT 0.0
.INDENT 3.5

    .ft C
    ctest_upload(FILES <file>... [QUIET] [CAPTURE_CMAKE_ERROR <result-var>])
    .ft P
.UNINDENT
.UNINDENT

The options are:
.INDENT 0.0

* <b>**FILES &lt;file&gt;...**</b>  
  Specify a list of files to be sent along with the build results to the
  dashboard server.
* <b>**QUIET**</b>  
  Suppress any CTest-specific non-error output that would have been
  printed to the console otherwise.
* <b>**CAPTURE_CMAKE_ERROR &lt;result-var&gt;**</b>  
  Store in the **&lt;result-var&gt;** variable -1 if there are any errors running
  the command and prevent ctest from returning non-zero if an error occurs.
  .UNINDENT

<a name="deprecated-commands"></a>

# Deprecated Commands


These commands are deprecated and are only made available to maintain
backward compatibility.  The documentation of each command states the
CMake version in which it was deprecated.  Do not use these commands
in new code.

<a name="build_name"></a>

### build_name


Disallowed since version 3.0.  See CMake Policy **CMP0036**.

Use **${CMAKE\_SYSTEM}** and **${CMAKE\_CXX\_COMPILER}** instead.
.INDENT 0.0
.INDENT 3.5

    .ft C
    build_name(variable)
    .ft P
.UNINDENT
.UNINDENT

Sets the specified variable to a string representing the platform and
compiler settings.  These values are now available through the
**CMAKE\_SYSTEM** and
**CMAKE\_CXX\_COMPILER** variables.

<a name="exec_program"></a>

### exec_program


Deprecated since version 3.0: Use the **execute\_process()** command instead.


Run an executable program during the processing of the CMakeList.txt
file.
.INDENT 0.0
.INDENT 3.5

    .ft C
    exec_program(Executable [directory in which to run]
                 [ARGS <arguments to executable>]
                 [OUTPUT_VARIABLE <var>]
                 [RETURN_VALUE <var>])
    .ft P
.UNINDENT
.UNINDENT

The executable is run in the optionally specified directory.  The
executable can include arguments if it is double quoted, but it is
better to use the optional **ARGS** argument to specify arguments to the
program.  This is because cmake will then be able to escape spaces in
the executable path.  An optional argument **OUTPUT\_VARIABLE** specifies a
variable in which to store the output.  To capture the return value of
the execution, provide a **RETURN\_VALUE**.  If **OUTPUT\_VARIABLE** is
specified, then no output will go to the stdout/stderr of the console
running cmake.

<a name="export_library_dependencies"></a>

### export_library_dependencies


Disallowed since version 3.0.  See CMake Policy **CMP0033**.

Use **install(EXPORT)** or **export()** command.

This command generates an old-style library dependencies file.
Projects requiring CMake 2.6 or later should not use the command.  Use
instead the **install(EXPORT)** command to help export targets from an
installation tree and the **export()** command to export targets from a
build tree.

The old-style library dependencies file does not take into account
per-configuration names of libraries or the
**LINK\_INTERFACE\_LIBRARIES** target property.
.INDENT 0.0
.INDENT 3.5

    .ft C
    export_library_dependencies(<file> [APPEND])
    .ft P
.UNINDENT
.UNINDENT

Create a file named **&lt;file&gt;** that can be included into a CMake listfile
with the INCLUDE command.  The file will contain a number of SET
commands that will set all the variables needed for library dependency
information.  This should be the last command in the top level
CMakeLists.txt file of the project.  If the **APPEND** option is
specified, the SET commands will be appended to the given file instead
of replacing it.

<a name="install_files"></a>

### install_files


Deprecated since version 3.0: Use the **install(FILES)** command instead.


This command has been superceded by the **install()** command.  It is
provided for compatibility with older CMake code.  The **FILES** form is
directly replaced by the **FILES** form of the **install()**
command.  The regexp form can be expressed more clearly using the **GLOB**
form of the **file()** command.
.INDENT 0.0
.INDENT 3.5

    .ft C
    install_files(<dir> extension file file ...)
    .ft P
.UNINDENT
.UNINDENT

Create rules to install the listed files with the given extension into
the given directory.  Only files existing in the current source tree
or its corresponding location in the binary tree may be listed.  If a
file specified already has an extension, that extension will be
removed first.  This is useful for providing lists of source files
such as foo.cxx when you want the corresponding foo.h to be installed.
A typical extension is **.h**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    install_files(<dir> regexp)
    .ft P
.UNINDENT
.UNINDENT

Any files in the current source directory that match the regular
expression will be installed.
.INDENT 0.0
.INDENT 3.5

    .ft C
    install_files(<dir> FILES file file ...)
    .ft P
.UNINDENT
.UNINDENT

Any files listed after the **FILES** keyword will be installed explicitly
from the names given.  Full paths are allowed in this form.

The directory **&lt;dir&gt;** is relative to the installation prefix, which is
stored in the variable **CMAKE\_INSTALL\_PREFIX**.

<a name="install_programs"></a>

### install_programs


Deprecated since version 3.0: Use the **install(PROGRAMS)** command instead.


This command has been superceded by the **install()** command.  It is
provided for compatibility with older CMake code.  The **FILES** form is
directly replaced by the **PROGRAMS** form of the **install()**
command.  The regexp form can be expressed more clearly using the **GLOB**
form of the **file()** command.
.INDENT 0.0
.INDENT 3.5

    .ft C
    install_programs(<dir> file1 file2 [file3 ...])
    install_programs(<dir> FILES file1 [file2 ...])
    .ft P
.UNINDENT
.UNINDENT

Create rules to install the listed programs into the given directory.
Use the **FILES** argument to guarantee that the file list version of the
command will be used even when there is only one argument.
.INDENT 0.0
.INDENT 3.5

    .ft C
    install_programs(<dir> regexp)
    .ft P
.UNINDENT
.UNINDENT

In the second form any program in the current source directory that
matches the regular expression will be installed.

This command is intended to install programs that are not built by
cmake, such as shell scripts.  See the **TARGETS** form of the
**install()** command to create installation rules for targets built
by cmake.

The directory **&lt;dir&gt;** is relative to the installation prefix, which is
stored in the variable **CMAKE\_INSTALL\_PREFIX**.

<a name="install_targets"></a>

### install_targets


Deprecated since version 3.0: Use the **install(TARGETS)** command instead.


This command has been superceded by the **install()** command.  It is
provided for compatibility with older CMake code.
.INDENT 0.0
.INDENT 3.5

    .ft C
    install_targets(<dir> [RUNTIME_DIRECTORY dir] target target)
    .ft P
.UNINDENT
.UNINDENT

Create rules to install the listed targets into the given directory.
The directory **&lt;dir&gt;** is relative to the installation prefix, which is
stored in the variable **CMAKE\_INSTALL\_PREFIX**.  If
**RUNTIME\_DIRECTORY** is specified, then on systems with special runtime
files (Windows DLL), the files will be copied to that directory.

<a name="load_command"></a>

### load_command


Disallowed since version 3.0.  See CMake Policy **CMP0031**.

Load a command into a running CMake.
.INDENT 0.0
.INDENT 3.5

    .ft C
    load_command(COMMAND_NAME <loc1> [loc2 ...])
    .ft P
.UNINDENT
.UNINDENT

The given locations are searched for a library whose name is
cmCOMMAND_NAME.  If found, it is loaded as a module and the command is
added to the set of available CMake commands.  Usually,
**try\_compile()** is used before this command to compile the
module.  If the command is successfully loaded a variable named
.INDENT 0.0
.INDENT 3.5

    .ft C
    CMAKE_LOADED_COMMAND_<COMMAND_NAME>
    .ft P
.UNINDENT
.UNINDENT

will be set to the full path of the module that was loaded.  Otherwise
the variable will not be set.

<a name="make_directory"></a>

### make_directory


Deprecated since version 3.0: Use the **file(MAKE\_DIRECTORY)** command instead.

.INDENT 0.0
.INDENT 3.5

    .ft C
    make_directory(directory)
    .ft P
.UNINDENT
.UNINDENT

Creates the specified directory.  Full paths should be given.  Any
parent directories that do not exist will also be created.  Use with
care.

<a name="output_required_files"></a>

### output_required_files


Disallowed since version 3.0.  See CMake Policy **CMP0032**.

Approximate C preprocessor dependency scanning.

This command exists only because ancient CMake versions provided it.
CMake handles preprocessor dependency scanning automatically using a
more advanced scanner.
.INDENT 0.0
.INDENT 3.5

    .ft C
    output_required_files(srcfile outputfile)
    .ft P
.UNINDENT
.UNINDENT

Outputs a list of all the source files that are required by the
specified **srcfile**.  This list is written into **outputfile**.  This is
similar to writing out the dependencies for **srcfile** except that it
jumps from **.h** files into **.cxx**, **.c** and **.cpp** files if possible.

<a name="qt_wrap_cpp"></a>

### qt_wrap_cpp


Deprecated since version 3.14: This command was originally added to support Qt 3 before the
**add\_custom\_command()** command was sufficiently mature.  The
**FindQt4** module provides the **qt4\_wrap\_cpp()** macro, which
should be used instead for Qt 4 projects.  For projects using Qt 5 or
later, use the equivalent macro provided by Qt itself (e.g. Qt 5 provides
**qt5\_wrap\_cpp()**).


Manually create Qt Wrappers.
.INDENT 0.0
.INDENT 3.5

    .ft C
    qt_wrap_cpp(resultingLibraryName DestName SourceLists ...)
    .ft P
.UNINDENT
.UNINDENT

Produces moc files for all the .h files listed in the SourceLists.  The
moc files will be added to the library using the **DestName** source list.

Consider updating the project to use the **AUTOMOC** target property
instead for a more automated way of invoking the **moc** tool.

<a name="qt_wrap_ui"></a>

### qt_wrap_ui


Deprecated since version 3.14: This command was originally added to support Qt 3 before the
**add\_custom\_command()** command was sufficiently mature.  The
**FindQt4** module provides the **qt4\_wrap\_ui()** macro, which
should be used instead for Qt 4 projects.  For projects using Qt 5 or
later, use the equivalent macro provided by Qt itself (e.g. Qt 5 provides
**qt5\_wrap\_ui()**).


Manually create Qt user interfaces Wrappers.
.INDENT 0.0
.INDENT 3.5

    .ft C
    qt_wrap_ui(resultingLibraryName HeadersDestName
               SourcesDestName SourceLists ...)
    .ft P
.UNINDENT
.UNINDENT

Produces .h and .cxx files for all the .ui files listed in the
**SourceLists**.  The .h files will be added to the library using the
**HeadersDestNamesource** list.  The .cxx files will be added to the
library using the **SourcesDestNamesource** list.

Consider updating the project to use the **AUTOUIC** target property
instead for a more automated way of invoking the **uic** tool.

<a name="remove"></a>

### remove


Deprecated since version 3.0: Use the **list(REMOVE\_ITEM)** command instead.

.INDENT 0.0
.INDENT 3.5

    .ft C
    remove(VAR VALUE VALUE ...)
    .ft P
.UNINDENT
.UNINDENT

Removes **VALUE** from the variable **VAR**.  This is typically used to
remove entries from a vector (e.g.  semicolon separated list).  **VALUE**
is expanded.

<a name="subdir_depends"></a>

### subdir_depends


Disallowed since version 3.0.  See CMake Policy **CMP0029**.

Does nothing.
.INDENT 0.0
.INDENT 3.5

    .ft C
    subdir_depends(subdir dep1 dep2 ...)
    .ft P
.UNINDENT
.UNINDENT

Does not do anything.  This command used to help projects order
parallel builds correctly.  This functionality is now automatic.

<a name="subdirs"></a>

### subdirs


Deprecated since version 3.0: Use the **add\_subdirectory()** command instead.


Add a list of subdirectories to the build.
.INDENT 0.0
.INDENT 3.5

    .ft C
    subdirs(dir1 dir2 ...[EXCLUDE_FROM_ALL exclude_dir1 exclude_dir2 ...]
            [PREORDER] )
    .ft P
.UNINDENT
.UNINDENT

Add a list of subdirectories to the build.  The **add\_subdirectory()**
command should be used instead of **subdirs** although **subdirs** will still
work.  This will cause any CMakeLists.txt files in the sub directories
to be processed by CMake.  Any directories after the **PREORDER** flag are
traversed first by makefile builds, the **PREORDER** flag has no effect on
IDE projects.  Any directories after the **EXCLUDE\_FROM\_ALL** marker will
not be included in the top level makefile or project file.  This is
useful for having CMake create makefiles or projects for a set of
examples in a project.  You would want CMake to generate makefiles or
project files for all the examples at the same time, but you would not
want them to show up in the top level project or be built each time
make is run from the top.

<a name="use_mangled_mesa"></a>

### use_mangled_mesa


Disallowed since version 3.0.  See CMake Policy **CMP0030**.

Copy mesa headers for use in combination with system GL.
.INDENT 0.0
.INDENT 3.5

    .ft C
    use_mangled_mesa(PATH_TO_MESA OUTPUT_DIRECTORY)
    .ft P
.UNINDENT
.UNINDENT

The path to mesa includes, should contain **gl\_mangle.h**.  The mesa
headers are copied to the specified output directory.  This allows
mangled mesa headers to override other GL headers by being added to
the include directory path earlier.

<a name="utility_source"></a>

### utility_source


Disallowed since version 3.0.  See CMake Policy **CMP0034**.

Specify the source tree of a third-party utility.
.INDENT 0.0
.INDENT 3.5

    .ft C
    utility_source(cache_entry executable_name
                   path_to_source [file1 file2 ...])
    .ft P
.UNINDENT
.UNINDENT

When a third-party utility’s source is included in the distribution,
this command specifies its location and name.  The cache entry will
not be set unless the **path\_to\_source** and all listed files exist.  It
is assumed that the source tree of the utility will have been built
before it is needed.

When cross compiling CMake will print a warning if a **utility\_source()**
command is executed, because in many cases it is used to build an
executable which is executed later on.  This doesn’t work when cross
compiling, since the executable can run only on their target platform.
So in this case the cache entry has to be adjusted manually so it
points to an executable which is runnable on the build host.

<a name="variable_requires"></a>

### variable_requires


Disallowed since version 3.0.  See CMake Policy **CMP0035**.

Use the **if()** command instead.

Assert satisfaction of an option’s required variables.
.INDENT 0.0
.INDENT 3.5

    .ft C
    variable_requires(TEST_VARIABLE RESULT_VARIABLE
                      REQUIRED_VARIABLE1
                      REQUIRED_VARIABLE2 ...)
    .ft P
.UNINDENT
.UNINDENT

The first argument (**TEST\_VARIABLE**) is the name of the variable to be
tested, if that variable is false nothing else is done.  If
**TEST\_VARIABLE** is true, then the next argument (**RESULT\_VARIABLE**)
is a variable that is set to true if all the required variables are set.
The rest of the arguments are variables that must be true or not set
to **NOTFOUND** to avoid an error.  If any are not true, an error is
reported.

<a name="write_file"></a>

### write_file


Deprecated since version 3.0: Use the **file(WRITE)** command instead.

.INDENT 0.0
.INDENT 3.5

    .ft C
    write_file(filename "message to write"... [APPEND])
    .ft P
.UNINDENT
.UNINDENT

The first argument is the file name, the rest of the arguments are
messages to write.  If the argument **APPEND** is specified, then the
message will be appended.

NOTE 1: **file(WRITE)**  and **file(APPEND)**  do exactly
the same as this one but add some more functionality.

NOTE 2: When using **write\_file** the produced file cannot be used as an
input to CMake (CONFIGURE_FILE, source file …) because it will lead
to an infinite loop.  Use **configure\_file()** if you want to
generate input files to CMake.

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

