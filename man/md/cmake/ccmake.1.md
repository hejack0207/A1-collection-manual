# ccmake(1) - CMake Curses Dialog Command-Line Reference

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
    ccmake [<options>] {<path-to-source> | <path-to-existing-build>}
    .ft P
<synopsis>
.UNINDENT .UNINDENT
```

<a name="description"></a>

# Description


The **ccmake** executable is the CMake curses interface.  Project
configuration settings may be specified interactively through this
GUI.  Brief instructions are provided at the bottom of the terminal
when the program is running.

CMake is a cross-platform build system generator.  Projects specify
their build process with platform-independent CMake listfiles included
in each directory of a source tree with the name **CMakeLists.txt**.
Users build a project by using CMake to generate a build system for a
native tool on their platform.

<a name="options"></a>

# Options

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
.UNINDENT
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

