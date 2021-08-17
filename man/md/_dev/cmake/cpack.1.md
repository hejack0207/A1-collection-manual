# cpack(1) - CPack Command-Line Reference

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
    cpack [<options>]
    .ft P
<synopsis>
.UNINDENT .UNINDENT
```

<a name="description"></a>

# Description


The **cpack** executable is the CMake packaging program.  It generates
installers and source packages in a variety of formats.

For each installer or package format, **cpack** has a specific backend,
called “generator”. A generator is responsible for generating the required
inputs and invoking the specific package creation tools. These installer
or package generators are not to be confused with the makefile generators
of the **cmake** command.

All supported generators are specified in the **cpack-generators** manual.  The command **cpack --help** prints a
list of generators supported for the target platform.  Which of them are
to be used can be selected through the **CPACK\_GENERATOR** variable
or through the command-line option **-G**.

The **cpack** program is steered by a configuration file written in the
**CMake language**. Unless chosen differently
through the command-line option **--config**, the file **CPackConfig.cmake**
in the current directory is used.

In the standard CMake workflow, the file **CPackConfig.cmake** is generated
by the **cmake** executable, provided the **CPack**
module is included by the project’s **CMakeLists.txt** file.

<a name="options"></a>

# Options

.INDENT 0.0

* <b>**-G &lt;generators&gt;**</b>  
  **&lt;generators&gt;** is a semicolon-separated list
  of generator names.  **cpack** will iterate through this list and produce
  package(s) in that generator’s format according to the details provided in
  the **CPackConfig.cmake** configuration file.  If this option is not given,
  the **CPACK\_GENERATOR** variable determines the default set of
  generators that will be used.
* <b>**-C &lt;configs&gt;**</b>  
  Specify the project configuration(s) to be packaged (e.g. **Debug**,
  **Release**, etc.), where **&lt;configs&gt;** is a
  semicolon-separated list.
  When the CMake project uses a multi-configuration
  generator such as Xcode or Visual Studio, this option is needed to tell
  **cpack** which built executables to include in the package.
  The user is responsible for ensuring that the configuration(s) listed
  have already been built before invoking **cpack**.
* <b>**-D &lt;var&gt;=&lt;value&gt;**</b>  
  Set a CPack variable.  This will override any value set for **&lt;var&gt;** in the
  input file read by **cpack**.
* <b>**--config &lt;configFile&gt;**</b>  
  Specify the configuration file read by **cpack** to provide the packaging
  details.  By default, **CPackConfig.cmake** in the current directory will
  be used.
* <b>**--verbose, -V**</b>  
  Run **cpack** with verbose output.  This can be used to show more details
  from the package generation tools and is suitable for project developers.
* <b>**--debug**</b>  
  Run **cpack** with debug output.  This option is intended mainly for the
  developers of **cpack** itself and is not normally needed by project
  developers.
* <b>**--trace**</b>  
  Put the underlying cmake scripts in trace mode.
* <b>**--trace-expand**</b>  
  Put the underlying cmake scripts in expanded trace mode.
* <b>**-P &lt;packageName&gt;**</b>  
  Override/define the value of the **CPACK\_PACKAGE\_NAME** variable used
  for packaging.  Any value set for this variable in the **CPackConfig.cmake**
  file will then be ignored.
* <b>**-R &lt;packageVersion&gt;**</b>  
  Override/define the value of the **CPACK\_PACKAGE\_VERSION**
  variable used for packaging.  It will override a value set in the
  **CPackConfig.cmake** file or one automatically computed from
  **CPACK\_PACKAGE\_VERSION\_MAJOR**,
  **CPACK\_PACKAGE\_VERSION\_MINOR** and
  **CPACK\_PACKAGE\_VERSION\_PATCH**.
* <b>**-B &lt;packageDirectory&gt;**</b>  
  Override/define **CPACK\_PACKAGE\_DIRECTORY**, which controls the
  directory where CPack will perform its packaging work.  The resultant
  package(s) will be created at this location by default and a
  **\_CPack\_Packages** subdirectory will also be created below this directory to
  use as a working area during package creation.
* <b>**--vendor &lt;vendorName&gt;**</b>  
  Override/define **CPACK\_PACKAGE\_VENDOR**.
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

