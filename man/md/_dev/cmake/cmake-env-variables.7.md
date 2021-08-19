# cmake-env-variables(7) - CMake Environment Variables Reference

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

This page lists environment variables that have special
meaning to CMake.

For general information on environment variables, see the
Environment Variables
section in the cmake-language manual.

<a name="environment-variables-that-control-the-build"></a>

# Environment Variables That Control the Build


<a name="cmake_build_parallel_level"></a>

### CMAKE_BUILD_PARALLEL_LEVEL


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Specifies the maximum number of concurrent processes to use when building
using the **cmake --build** command line
Build Tool Mode.

If this variable is defined empty the native build tool’s default number is
used.

<a name="cmake_config_type"></a>

### CMAKE_CONFIG_TYPE


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

The default build configuration for Build Tool Mode and
**ctest** build handler when there is no explicit configuration given.

<a name="cmake_export_compile_commands"></a>

### CMAKE_EXPORT_COMPILE_COMMANDS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

The default value for **CMAKE\_EXPORT\_COMPILE\_COMMANDS** when there
is no explicit configuration given on the first run while creating a new
build tree.  On later runs in an existing build tree the value persists in
the cache as **CMAKE\_EXPORT\_COMPILE\_COMMANDS**.

<a name="cmake_generator"></a>

### CMAKE_GENERATOR


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Specifies the CMake default generator to use when no generator is supplied
with **-G**. If the provided value doesn’t name a generator known by CMake,
the internal default is used.  Either way the resulting generator selection
is stored in the **CMAKE\_GENERATOR** variable.

Some generators may be additionally configured using the environment
variables:
.INDENT 0.0

* ·  
  **CMAKE\_GENERATOR\_PLATFORM**
* ·  
  **CMAKE\_GENERATOR\_TOOLSET**
* ·  
  **CMAKE\_GENERATOR\_INSTANCE**
  .UNINDENT

<a name="cmake_generator_instance"></a>

### CMAKE_GENERATOR_INSTANCE


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default value for **CMAKE\_GENERATOR\_INSTANCE** if no Cache entry is
present. This value is only applied if **CMAKE\_GENERATOR** is set.

<a name="cmake_generator_platform"></a>

### CMAKE_GENERATOR_PLATFORM


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default value for **CMAKE\_GENERATOR\_PLATFORM** if no Cache entry
is present and no value is specified by **cmake(1)** **-A** option.
This value is only applied if **CMAKE\_GENERATOR** is set.

<a name="cmake_generator_toolset"></a>

### CMAKE_GENERATOR_TOOLSET


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default value for **CMAKE\_GENERATOR\_TOOLSET** if no Cache entry
is present and no value is specified by **cmake(1)** **-T** option.
This value is only applied if **CMAKE\_GENERATOR** is set.

<a name="cmake_ltlanggt_compiler_launcher"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_LAUNCHER


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default compiler launcher to use for the specified language. Will only be used
by CMake to initialize the variable on the first configuration. Afterwards, it
is available through the cache setting of the variable of the same name. For
any configuration run (including the first), the environment variable will be
ignored if the **CMAKE\_&lt;LANG&gt;\_COMPILER\_LAUNCHER** variable is defined.

<a name="cmake_msvcide_run_path"></a>

### CMAKE_MSVCIDE_RUN_PATH


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Extra PATH locations for custom commands when using
**Visual Studio 9 2008** (or above) generators.

The **CMAKE\_MSVCIDE\_RUN\_PATH** environment variable sets the default value for
the **CMAKE\_MSVCIDE\_RUN\_PATH** variable if not already explicitly set.

<a name="cmake_no_verbose"></a>

### CMAKE_NO_VERBOSE


Disables verbose output from CMake when **VERBOSE** environment variable
is set.

Only your build tool of choice will still print verbose output when you start
to actually build your project.

<a name="cmake_osx_architectures"></a>

### CMAKE_OSX_ARCHITECTURES


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Target specific architectures for macOS.

The **CMAKE\_OSX\_ARCHITECTURES** environment variable sets the default value for
the **CMAKE\_OSX\_ARCHITECTURES** variable. See
**OSX\_ARCHITECTURES** for more information.

<a name="destdir"></a>

### DESTDIR


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

On UNIX one can use the **DESTDIR** mechanism in order to relocate the
whole installation.  **DESTDIR** means DESTination DIRectory.  It is
commonly used by makefile users in order to install software at
non-default location.  It is usually invoked like this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    make DESTDIR=/home/john install
    .ft P
.UNINDENT
.UNINDENT

which will install the concerned software using the installation
prefix, e.g.  **/usr/local** prepended with the **DESTDIR** value which
finally gives **/home/john/usr/local**.

WARNING: **DESTDIR** may not be used on Windows because installation
prefix usually contains a drive letter like in **C:/Program Files**
which cannot be prepended with some other prefix.

<a name="ldflags"></a>

### LDFLAGS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Will only be used by CMake on the first configuration to determine the default
linker flags, after which the value for **LDFLAGS** is stored in the cache
as **CMAKE\_EXE\_LINKER\_FLAGS\_INIT**,
**CMAKE\_SHARED\_LINKER\_FLAGS\_INIT**, and
**CMAKE\_MODULE\_LINKER\_FLAGS\_INIT**. For any configuration run
(including the first), the environment variable will be ignored if the
equivalent  **CMAKE\_&lt;TYPE&gt;\_LINKER\_FLAGS\_INIT** variable is defined.

<a name="macosx_deployment_target"></a>

### MACOSX_DEPLOYMENT_TARGET


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Specify the minimum version of macOS on which the target binaries are
to be deployed.

The **MACOSX\_DEPLOYMENT\_TARGET** environment variable sets the default value for
the **CMAKE\_OSX\_DEPLOYMENT\_TARGET** variable.

<a name="ltpackagenamegt_root"></a>

### &lt;PackageName&gt;_ROOT


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Calls to **find\_package(&lt;PackageName&gt;)** will search in prefixes
specified by the **&lt;PackageName&gt;\_ROOT** environment variable, where
**&lt;PackageName&gt;** is the name given to the **find\_package()** call
and **\_ROOT** is literal.  For example, **find\_package(Foo)** will search
prefixes specified in the **Foo\_ROOT** environment variable (if set).
See policy **CMP0074**.

This variable may hold a single prefix or a list of prefixes separated
by **:** on UNIX or **;** on Windows (the same as the **PATH** environment
variable convention on those platforms).

See also the **&lt;PackageName&gt;\_ROOT** CMake variable.

<a name="verbose"></a>

### VERBOSE


Activates verbose output from CMake and your build tools of choice when
you start to actually build your project.

Note that any given value is ignored. It’s just checked for existence.

See also Build Tool Mode and
**CMAKE\_NO\_VERBOSE** environment variable

<a name="environment-variables-for-languages"></a>

# Environment Variables for Languages


<a name="asmltdialectgt"></a>

### ASM&lt;DIALECT&gt;


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling a specific dialect of assembly language
files. **ASM&lt;DIALECT&gt;** can be **ASM**, **ASM\_NASM** (Netwide Assembler),
**ASM\_MASM** (Microsoft Assembler) or **ASM-ATT** (Assembler AT&T).
Will only be used by CMake on the first configuration to determine
**ASM&lt;DIALECT&gt;** compiler, after which the value for **ASM&lt;DIALECT&gt;** is stored
in the cache as
**CMAKE\_ASM&lt;DIALECT&gt;\_COMPILER**. For subsequent
configuration runs, the environment variable will be ignored in favor of
**CMAKE\_ASM&lt;DIALECT&gt;\_COMPILER**.

<a name="asmltdialectgtflags"></a>

### ASM&lt;DIALECT&gt;FLAGS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default compilation flags to be used when compiling a specific dialect of an
assembly language. **ASM&lt;DIALECT&gt;FLAGS** can be **ASMFLAGS**, **ASM\_NASMFLAGS**,
**ASM\_MASMFLAGS** or **ASM-ATTFLAGS**. Will only be used by CMake on the
first configuration to determine **ASM\_&lt;DIALECT&gt;** default compilation
flags, after which the value for **ASM&lt;DIALECT&gt;FLAGS** is stored in the cache
as **CMAKE_ASM&lt;DIALECT&gt;_FLAGS &lt;CMAKE\_&lt;LANG&gt;\_FLAGS&gt;**.  For any configuration
run (including the first), the environment variable will be ignored, if the
**CMAKE_ASM&lt;DIALECT&gt;_FLAGS &lt;CMAKE\_&lt;LANG&gt;\_FLAGS&gt;** variable is defined.

<a name="cc"></a>

### CC


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling **C** language files. Will only be used by
CMake on the first configuration to determine **C** compiler, after which the
value for **CC** is stored in the cache as
**CMAKE\_C\_COMPILER**. For any configuration run
(including the first), the environment variable will be ignored if the
**CMAKE\_C\_COMPILER** variable is defined.

<a name="cflags"></a>

### CFLAGS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default compilation flags to be used when compiling **C** files. Will only be
used by CMake on the first configuration to determine **CC** default compilation
flags, after which the value for **CFLAGS** is stored in the cache
as **CMAKE\_C\_FLAGS**. For any configuration run
(including the first), the environment variable will be ignored if the
**CMAKE\_C\_FLAGS** variable is defined.

<a name="csflags"></a>

### CSFLAGS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling **CSharp** language files. Will only be
used by CMake on the first configuration to determine **CSharp** default
compilation flags, after which the value for **CSFLAGS** is stored in the cache
as **CMAKE\_CSharp\_FLAGS**. For any configuration
run (including the first), the environment variable will be ignored if the
**CMAKE\_CSharp\_FLAGS** variable is defined.

<a name="cudacxx"></a>

### CUDACXX


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling **CUDA** language files. Will only be used by
CMake on the first configuration to determine **CUDA** compiler, after which the
value for **CUDA** is stored in the cache as
**CMAKE\_CUDA\_COMPILER**. For any configuration
run (including the first), the environment variable will be ignored if the
**CMAKE\_CUDA\_COMPILER** variable is defined.

<a name="cudaflags"></a>

### CUDAFLAGS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default compilation flags to be used when compiling **CUDA** files. Will only be
used by CMake on the first configuration to determine **CUDA** default
compilation flags, after which the value for **CUDAFLAGS** is stored in the
cache as **CMAKE\_CUDA\_FLAGS**. For any configuration
run (including the first), the environment variable will be ignored if
the **CMAKE\_CUDA\_FLAGS** variable is defined.

<a name="cudahostcxx"></a>

### CUDAHOSTCXX


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling host code when compiling **CUDA**
language files. Will only be used by CMake on the first configuration to
determine **CUDA** host compiler, after which the value for **CUDAHOSTCXX** is
stored in the cache as **CMAKE\_CUDA\_HOST\_COMPILER**. For any
configuration run (including the first), the environment variable will be
ignored if the **CMAKE\_CUDA\_HOST\_COMPILER** variable is defined.

This environment variable is primarily meant for use with projects that
enable **CUDA** as a first-class language.  The **FindCUDA**
module will also use it to initialize its **CUDA\_HOST\_COMPILER** setting.

<a name="cxx"></a>

### CXX


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling **CXX** language files. Will only be used by
CMake on the first configuration to determine **CXX** compiler, after which the
value for **CXX** is stored in the cache as
**CMAKE\_CXX\_COMPILER**. For any configuration
run (including the first), the environment variable will be ignored if the
**CMAKE\_CXX\_COMPILER** variable is defined.

<a name="cxxflags"></a>

### CXXFLAGS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default compilation flags to be used when compiling **CXX** (C++) files. Will
only be used by CMake on the first configuration to determine **CXX** default
compilation flags, after which the value for **CXXFLAGS** is stored in the cache
as **CMAKE\_CXX\_FLAGS**. For any configuration run (
including the first), the environment variable will be ignored if
the **CMAKE\_CXX\_FLAGS** variable is defined.

<a name="fc"></a>

### FC


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling **Fortran** language files. Will only be used
by CMake on the first configuration to determine **Fortran** compiler, after
which the value for **Fortran** is stored in the cache as
**CMAKE\_Fortran\_COMPILER**. For any
configuration run (including the first), the environment variable will be
ignored if the **CMAKE\_Fortran\_COMPILER**
variable is defined.

<a name="fflags"></a>

### FFLAGS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default compilation flags to be used when compiling **Fortran** files. Will only
be used by CMake on the first configuration to determine **Fortran** default
compilation flags, after which the value for **FFLAGS** is stored in the cache
as **CMAKE\_Fortran\_FLAGS**. For any configuration
run (including the first), the environment variable will be ignored if
the **CMAKE\_Fortran\_FLAGS** variable is defined.

<a name="rc"></a>

### RC


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling **resource** files. Will only be used by CMake
on the first configuration to determine **resource** compiler, after which the
value for **RC** is stored in the cache as
**CMAKE\_RC\_COMPILER**. For any configuration run
(including the first), the environment variable will be ignored if the
**CMAKE\_RC\_COMPILER** variable is defined.

<a name="rcflags"></a>

### RCFLAGS


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Default compilation flags to be used when compiling **resource** files. Will
only be used by CMake on the first configuration to determine **resource**
default compilation flags, after which the value for **RCFLAGS** is stored in
the cache as **CMAKE\_RC\_FLAGS**. For any
configuration run (including the first), the environment variable will be ignored
if the **CMAKE\_RC\_FLAGS** variable is defined.

<a name="swiftc"></a>

### SWIFTC


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Preferred executable for compiling **Swift** language files. Will only be used by
CMake on the first configuration to determine **Swift** compiler, after which the
value for **SWIFTC** is stored in the cache as
**CMAKE\_Swift\_COMPILER**. For any configuration run
(including the first), the environment variable will be ignored if the
**CMAKE\_Swift\_COMPILER** variable is defined.

<a name="environment-variables-for-ctest"></a>

# Environment Variables for Ctest


<a name="ctest_interactive_debug_mode"></a>

### CTEST_INTERACTIVE_DEBUG_MODE


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Environment variable that will exist and be set to **1** when a test executed
by **ctest(1)** is run in interactive mode.

<a name="ctest_output_on_failure"></a>

### CTEST_OUTPUT_ON_FAILURE


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Boolean environment variable that controls if the output should be logged for
failed tests. Set the value to **1**, **True**, or **ON** to enable output on failure.
See **ctest(1)** for more information on controlling output of failed
tests.

<a name="ctest_parallel_level"></a>

### CTEST_PARALLEL_LEVEL


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Specify the number of tests for CTest to run in parallel. See **ctest(1)**
for more information on parallel test execution.

<a name="ctest_progress_output"></a>

### CTEST_PROGRESS_OUTPUT


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Boolean environment variable that affects how **ctest**
command output reports overall progress.  When set to **1**, **TRUE**, **ON** or anything
else that evaluates to boolean true, progress is reported by repeatedly
updating the same line.  This greatly reduces the overall verbosity, but is
only supported when output is sent directly to a terminal.  If the environment
variable is not set or has a value that evaluates to false, output is reported
normally with each test having its own start and end lines logged to the
output.

The **--progress** option to **ctest** overrides this
environment variable if both are given.

<a name="ctest_use_launchers_default"></a>

### CTEST_USE_LAUNCHERS_DEFAULT


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Initializes the **CTEST\_USE\_LAUNCHERS** variable if not already defined.

<a name="dashboard_test_from_ctest"></a>

### DASHBOARD_TEST_FROM_CTEST


This is a CMake Environment Variable. Its initial value is taken from
the calling process environment.

Environment variable that will exist when a test executed by **ctest(1)**
is run in non-interactive mode.  The value will be equal to
**CMAKE\_VERSION**.

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

