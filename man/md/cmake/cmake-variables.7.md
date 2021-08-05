# cmake-variables(7) - CMake Variables Reference

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

This page documents variables that are provided by CMake
or have meaning to CMake when set by project code.

For general information on variables, see the
Variables
section in the cmake-language manual.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
CMake reserves identifiers that:
.INDENT 0.0

* ·  
  begin with **CMAKE\_** (upper-, lower-, or mixed-case), or
* ·  
  begin with **\_CMAKE\_** (upper-, lower-, or mixed-case), or
* ·  
  begin with **\_** followed by the name of any **CMake Command**.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="variables-that-provide-information"></a>

# Variables That Provide Information


<a name="cmake_ar"></a>

### CMAKE_AR


Name of archiving tool for static libraries.

This specifies the name of the program that creates archive or static
libraries.

<a name="cmake_argc"></a>

### CMAKE_ARGC


Number of command line arguments passed to CMake in script mode.

When run in -P script mode, CMake sets this
variable to the number of command line arguments.  See also
**CMAKE\_ARGV0**, **1**, **2** …

<a name="cmake_argv0"></a>

### CMAKE_ARGV0


Command line argument passed to CMake in script mode.

When run in -P script mode, CMake sets this
variable to the first command line argument.  It then also sets **CMAKE\_ARGV1**,
**CMAKE\_ARGV2**, … and so on, up to the number of command line arguments
given.  See also **CMAKE\_ARGC**.

<a name="cmake_binary_dir"></a>

### CMAKE_BINARY_DIR


The path to the top level of the build tree.

This is the full path to the top level of the current CMake build
tree.  For an in-source build, this would be the same as
**CMAKE\_SOURCE\_DIR**.

When run in -P script mode, CMake sets the variables
_CMAKE\_BINARY\_DIR_, **CMAKE\_SOURCE\_DIR**,
**CMAKE\_CURRENT\_BINARY\_DIR** and
**CMAKE\_CURRENT\_SOURCE\_DIR** to the current working directory.

<a name="cmake_build_tool"></a>

### CMAKE_BUILD_TOOL


This variable exists only for backwards compatibility.
It contains the same value as **CMAKE\_MAKE\_PROGRAM**.
Use that variable instead.

<a name="cmake_cachefile_dir"></a>

### CMAKE_CACHEFILE_DIR


The directory with the **CMakeCache.txt** file.

This is the full path to the directory that has the **CMakeCache.txt**
file in it.  This is the same as **CMAKE\_BINARY\_DIR**.

<a name="cmake_cache_major_version"></a>

### CMAKE_CACHE_MAJOR_VERSION


Major version of CMake used to create the **CMakeCache.txt** file

This stores the major version of CMake used to write a CMake cache
file.  It is only different when a different version of CMake is run
on a previously created cache file.

<a name="cmake_cache_minor_version"></a>

### CMAKE_CACHE_MINOR_VERSION


Minor version of CMake used to create the **CMakeCache.txt** file

This stores the minor version of CMake used to write a CMake cache
file.  It is only different when a different version of CMake is run
on a previously created cache file.

<a name="cmake_cache_patch_version"></a>

### CMAKE_CACHE_PATCH_VERSION


Patch version of CMake used to create the **CMakeCache.txt** file

This stores the patch version of CMake used to write a CMake cache
file.  It is only different when a different version of CMake is run
on a previously created cache file.

<a name="cmake_cfg_intdir"></a>

### CMAKE_CFG_INTDIR


Build-time reference to per-configuration output subdirectory.

For native build systems supporting multiple configurations in the
build tree (such as Visual Studio Generators and **Xcode**),
the value is a reference to a build-time variable specifying the name
of the per-configuration output subdirectory.  On Makefile Generators
this evaluates to _._ because there is only one configuration in a build tree.
Example values:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $(ConfigurationName) = Visual Studio 9
    $(Configuration)     = Visual Studio 10
    $(CONFIGURATION)     = Xcode
    .                    = Make-based tools
    .                    = Ninja
    ${CONFIGURATION}     = Ninja Multi-Config
    .ft P
.UNINDENT
.UNINDENT

Note that this variable only has limited support on
**Ninja Multi-Config**. It is recommended that you use the
**$&lt;CONFIG&gt;** **generator expression**
instead.

Since these values are evaluated by the native build system, this
variable is suitable only for use in command lines that will be
evaluated at build time.  Example of intended usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(mytool mytool.c)
    add_custom_command(
      OUTPUT out.txt
      COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/mytool
              ${CMAKE_CURRENT_SOURCE_DIR}/in.txt out.txt
      DEPENDS mytool in.txt
      )
    add_custom_target(drive ALL DEPENDS out.txt)
    .ft P
.UNINDENT
.UNINDENT

Note that **CMAKE\_CFG\_INTDIR** is no longer necessary for this purpose but
has been left for compatibility with existing projects.  Instead
**add\_custom\_command()** recognizes executable target names in its
**COMMAND** option, so
**${CMAKE\_CURRENT\_BINARY\_DIR}/${CMAKE\_CFG\_INTDIR}/mytool** can be replaced
by just **mytool**.

This variable is read-only.  Setting it is undefined behavior.  In
multi-configuration build systems the value of this variable is passed
as the value of preprocessor symbol **CMAKE\_INTDIR** to the compilation
of all source files.

<a name="cmake_command"></a>

### CMAKE_COMMAND


The full path to the **cmake(1)** executable.

This is the full path to the CMake executable **cmake(1)** which is
useful from custom commands that want to use the **cmake -E** option for
portable system commands.  (e.g.  **/usr/local/bin/cmake**)

<a name="cmake_cpack_command"></a>

### CMAKE_CPACK_COMMAND


Full path to **cpack(1)** command installed with CMake.

This is the full path to the CPack executable **cpack(1)** which is
useful from custom commands that want to use the **cmake(1)** **-E**
option for portable system commands.

<a name="cmake_crosscompiling"></a>

### CMAKE_CROSSCOMPILING


Intended to indicate whether CMake is cross compiling, but note limitations
discussed below.

This variable will be set to true by CMake if the **CMAKE\_SYSTEM\_NAME**
variable has been set manually (i.e. in a toolchain file or as a cache entry
from the **cmake** command line). In most cases, manually
setting **CMAKE\_SYSTEM\_NAME** will only be done when cross compiling,
since it will otherwise be given the same value as
**CMAKE\_HOST\_SYSTEM\_NAME** if not manually set, which is correct for
the non-cross-compiling case. In the event that **CMAKE\_SYSTEM\_NAME**
is manually set to the same value as **CMAKE\_HOST\_SYSTEM\_NAME**, then
**CMAKE\_CROSSCOMPILING** will still be set to true.

Another case to be aware of is that builds targeting Apple platforms other than
macOS are handled differently to other cross compiling scenarios. Rather than
relying on **CMAKE\_SYSTEM\_NAME** to select the target platform, Apple
device builds use **CMAKE\_OSX\_SYSROOT** to select the appropriate SDK,
which indirectly determines the target platform. Furthermore, when using the
**Xcode** generator, developers can switch between device and
simulator builds at build time rather than having a single
choice at configure time, so the concept
of whether the build is cross compiling or not is more complex. Therefore, the
use of **CMAKE\_CROSSCOMPILING** is not recommended for projects targeting Apple
devices.

<a name="cmake_crosscompiling_emulator"></a>

### CMAKE_CROSSCOMPILING_EMULATOR


This variable is only used when **CMAKE\_CROSSCOMPILING** is on. It
should point to a command on the host system that can run executable built
for the target system.

If this variable contains a semicolon-separated list, then the first value is the command and remaining values are its
arguments.

The command will be used to run **try\_run()** generated executables,
which avoids manual population of the **TryRunResults.cmake** file.

It is also used as the default value for the
**CROSSCOMPILING\_EMULATOR** target property of executables.

<a name="cmake_ctest_command"></a>

### CMAKE_CTEST_COMMAND


Full path to **ctest(1)** command installed with CMake.

This is the full path to the CTest executable **ctest(1)** which is
useful from custom commands that want to use the **cmake(1)** **-E**
option for portable system commands.

<a name="cmake_current_binary_dir"></a>

### CMAKE_CURRENT_BINARY_DIR


The path to the binary directory currently being processed.

This the full path to the build directory that is currently being
processed by cmake.  Each directory added by **add\_subdirectory()** will
create a binary directory in the build tree, and as it is being
processed this variable will be set.  For in-source builds this is the
current source directory being processed.

When run in -P script mode, CMake sets the variables
**CMAKE\_BINARY\_DIR**, **CMAKE\_SOURCE\_DIR**,
_CMAKE\_CURRENT\_BINARY\_DIR_ and
**CMAKE\_CURRENT\_SOURCE\_DIR** to the current working directory.

<a name="cmake_current_function"></a>

### CMAKE_CURRENT_FUNCTION


When executing code inside a **function()**, this variable
contains the name of the current function.  It can be useful for
diagnostic or debug messages.

See also **CMAKE\_CURRENT\_FUNCTION\_LIST\_DIR**,
**CMAKE\_CURRENT\_FUNCTION\_LIST\_FILE** and
**CMAKE\_CURRENT\_FUNCTION\_LIST\_LINE**.

<a name="cmake_current_function_list_dir"></a>

### CMAKE_CURRENT_FUNCTION_LIST_DIR


When executing code inside a **function()**, this variable
contains the full directory of the listfile that defined the current function.

It is quite common practice in CMake for modules to use some additional files,
such as templates to be copied in after substituting CMake variables.
In such cases, a function needs to know where to locate those files in a way
that doesn’t depend on where the function is called.  Without
**CMAKE\_CURRENT\_FUNCTION\_LIST\_DIR**, the code to do that would typically use
the following pattern:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(_THIS_MODULE_BASE_DIR "${CMAKE_CURRENT_LIST_DIR}")
    
    function(foo)
      configure_file(
        "${_THIS_MODULE_BASE_DIR}/some.template.in"
        some.output
      )
    endfunction()
    .ft P
.UNINDENT
.UNINDENT

Using **CMAKE\_CURRENT\_FUNCTION\_LIST\_DIR** inside the function instead
eliminates the need for the extra variable which would otherwise be visible
outside the function’s scope.
The above example can be written in the more concise and more robust form:
.INDENT 0.0
.INDENT 3.5

    .ft C
    function(foo)
      configure_file(
        "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/some.template.in"
        some.output
      )
    endfunction()
    .ft P
.UNINDENT
.UNINDENT

See also **CMAKE\_CURRENT\_FUNCTION**,
**CMAKE\_CURRENT\_FUNCTION\_LIST\_FILE** and
**CMAKE\_CURRENT\_FUNCTION\_LIST\_LINE**.

<a name="cmake_current_function_list_file"></a>

### CMAKE_CURRENT_FUNCTION_LIST_FILE


When executing code inside a **function()**, this variable
contains the full path to the listfile that defined the current function.

See also **CMAKE\_CURRENT\_FUNCTION**,
**CMAKE\_CURRENT\_FUNCTION\_LIST\_DIR** and
**CMAKE\_CURRENT\_FUNCTION\_LIST\_LINE**.

<a name="cmake_current_function_list_line"></a>

### CMAKE_CURRENT_FUNCTION_LIST_LINE


When executing code inside a **function()**, this variable
contains the line number in the listfile where the current function
was defined.

See also **CMAKE\_CURRENT\_FUNCTION**,
**CMAKE\_CURRENT\_FUNCTION\_LIST\_DIR** and
**CMAKE\_CURRENT\_FUNCTION\_LIST\_FILE**.

<a name="cmake_current_list_dir"></a>

### CMAKE_CURRENT_LIST_DIR


Full directory of the listfile currently being processed.

As CMake processes the listfiles in your project this variable will
always be set to the directory where the listfile which is currently
being processed (**CMAKE\_CURRENT\_LIST\_FILE**) is located.  The value
has dynamic scope.  When CMake starts processing commands in a source file
it sets this variable to the directory where this file is located.
When CMake finishes processing commands from the file it restores the
previous value.  Therefore the value of the variable inside a macro or
function is the directory of the file invoking the bottom-most entry
on the call stack, not the directory of the file containing the macro
or function definition.

See also **CMAKE\_CURRENT\_LIST\_FILE**.

<a name="cmake_current_list_file"></a>

### CMAKE_CURRENT_LIST_FILE


Full path to the listfile currently being processed.

As CMake processes the listfiles in your project this variable will
always be set to the one currently being processed.  The value has
dynamic scope.  When CMake starts processing commands in a source file
it sets this variable to the location of the file.  When CMake
finishes processing commands from the file it restores the previous
value.  Therefore the value of the variable inside a macro or function
is the file invoking the bottom-most entry on the call stack, not the
file containing the macro or function definition.

See also **CMAKE\_PARENT\_LIST\_FILE**.

<a name="cmake_current_list_line"></a>

### CMAKE_CURRENT_LIST_LINE


The line number of the current file being processed.

This is the line number of the file currently being processed by
cmake.

<a name="cmake_current_source_dir"></a>

### CMAKE_CURRENT_SOURCE_DIR


The path to the source directory currently being processed.

This the full path to the source directory that is currently being
processed by cmake.

When run in -P script mode, CMake sets the variables
**CMAKE\_BINARY\_DIR**, **CMAKE\_SOURCE\_DIR**,
**CMAKE\_CURRENT\_BINARY\_DIR** and
_CMAKE\_CURRENT\_SOURCE\_DIR_ to the current working directory.

<a name="cmake_debug_target_properties"></a>

### CMAKE_DEBUG_TARGET_PROPERTIES


Enables tracing output for target properties.

This variable can be populated with a list of properties to generate
debug output for when evaluating target properties.  Currently it can
only be used when evaluating:
.INDENT 0.0

* ·  
  **AUTOUIC\_OPTIONS**
* ·  
  **COMPILE\_DEFINITIONS**
* ·  
  **COMPILE\_FEATURES**
* ·  
  **COMPILE\_OPTIONS**
* ·  
  **INCLUDE\_DIRECTORIES**
* ·  
  **LINK\_DIRECTORIES**
* ·  
  **LINK\_OPTIONS**
* ·  
  **POSITION\_INDEPENDENT\_CODE**
* ·  
  **SOURCES**
  .UNINDENT

target properties and any other property listed in
**COMPATIBLE\_INTERFACE\_STRING** and other
**COMPATIBLE\_INTERFACE\_** properties.  It outputs an origin for each entry
in the target property.  Default is unset.

<a name="cmake_directory_labels"></a>

### CMAKE_DIRECTORY_LABELS


Specify labels for the current directory.

This is used to initialize the **LABELS** directory property.

<a name="cmake_dl_libs"></a>

### CMAKE_DL_LIBS


Name of library containing **dlopen** and **dlclose**.

The name of the library that has **dlopen** and **dlclose** in it, usually
**-ldl** on most UNIX machines.

<a name="cmake_dotnet_target_framework"></a>

### CMAKE_DOTNET_TARGET_FRAMEWORK


Default value for **DOTNET\_TARGET\_FRAMEWORK** property  of
targets.

This variable is used to initialize the
**DOTNET\_TARGET\_FRAMEWORK** property on all targets. See that
target property for additional information.

Setting **CMAKE\_DOTNET\_TARGET\_FRAMEWORK** may be necessary
when working with **C#** and newer .NET framework versions to
avoid referencing errors with the **ALL\_BUILD** CMake target.

This variable is only evaluated for Visual Studio Generators
VS 2010 and above.

<a name="cmake_dotnet_target_framework_version"></a>

### CMAKE_DOTNET_TARGET_FRAMEWORK_VERSION


Default value for **DOTNET\_TARGET\_FRAMEWORK\_VERSION**
property of targets.

This variable is used to initialize the
**DOTNET\_TARGET\_FRAMEWORK\_VERSION** property on all
targets. See that target property for additional information. When set,
**CMAKE\_DOTNET\_TARGET\_FRAMEWORK** takes precednece over this
variable. See that variable or the associated target property
**DOTNET\_TARGET\_FRAMEWORK** for additional information.

Setting **CMAKE\_DOTNET\_TARGET\_FRAMEWORK\_VERSION** may be necessary
when working with **C#** and newer .NET framework versions to
avoid referencing errors with the **ALL\_BUILD** CMake target.

This variable is only evaluated for Visual Studio Generators
VS 2010 and above.

<a name="cmake_edit_command"></a>

### CMAKE_EDIT_COMMAND


Full path to **cmake-gui(1)** or **ccmake(1)**.  Defined only for
Makefile Generators when not using an “extra” generator for an IDE.

This is the full path to the CMake executable that can graphically
edit the cache.  For example, **cmake-gui(1)** or **ccmake(1)**.

<a name="cmake_executable_suffix"></a>

### CMAKE_EXECUTABLE_SUFFIX


The suffix for executables on this platform.

The suffix to use for the end of an executable filename if any, **.exe**
on Windows.

**CMAKE\_EXECUTABLE\_SUFFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_extra_generator"></a>

### CMAKE_EXTRA_GENERATOR


The extra generator used to build the project.  See
**cmake-generators(7)**.

When using the Eclipse, CodeBlocks, CodeLite, Kate or Sublime generators, CMake
generates Makefiles (**CMAKE\_GENERATOR**) and additionally project
files for the respective IDE.  This IDE project file generator is stored in
**CMAKE\_EXTRA\_GENERATOR** (e.g.  **Eclipse CDT4**).

<a name="cmake_extra_shared_library_suffixes"></a>

### CMAKE_EXTRA_SHARED_LIBRARY_SUFFIXES


Additional suffixes for shared libraries.

Extensions for shared libraries other than that specified by
**CMAKE\_SHARED\_LIBRARY\_SUFFIX**, if any.  CMake uses this to recognize
external shared library files during analysis of libraries linked by a
target.

<a name="cmake_find_debug_mode"></a>

### CMAKE_FIND_DEBUG_MODE


Print extra find call information for the following commands to standard
error:
.INDENT 0.0

* ·  
  **find\_program()**
* ·  
  **find\_library()**
* ·  
  **find\_file()**
* ·  
  **find\_path()**
* ·  
  **find\_package()**
  .UNINDENT

Output is designed for human consumption and not for parsing.
Enabling this variable is equivalent to using **cmake** **--debug-find**
with the added ability to enable debugging for a subset of find calls.
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_FIND_DEBUG_MODE TRUE)
    find_program(...)
    set(CMAKE_FIND_DEBUG_MODE FALSE)
    .ft P
.UNINDENT
.UNINDENT

Default is unset.

<a name="cmake_find_package_name"></a>

### CMAKE_FIND_PACKAGE_NAME


Defined by the **find\_package()** command while loading
a find module to record the caller-specified package name.
See command documentation for details.

<a name="cmake_find_package_sort_direction"></a>

### CMAKE_FIND_PACKAGE_SORT_DIRECTION


The sorting direction used by **CMAKE\_FIND\_PACKAGE\_SORT\_ORDER**.
It can assume one of the following values:
.INDENT 0.0

* <b>**DEC**</b>  
  Default.  Ordering is done in descending mode.
  The highest folder found will be tested first.
* <b>**ASC**</b>  
  Ordering is done in ascending mode.
  The lowest folder found will be tested first.
  .UNINDENT

If **CMAKE\_FIND\_PACKAGE\_SORT\_ORDER** is not set or is set to **NONE**
this variable has no effect.

<a name="cmake_find_package_sort_order"></a>

### CMAKE_FIND_PACKAGE_SORT_ORDER


The default order for sorting packages found using **find\_package()**.
It can assume one of the following values:
.INDENT 0.0

* <b>**NONE**</b>  
  Default.  No attempt is done to sort packages.
  The first valid package found will be selected.
* <b>**NAME**</b>  
  Sort packages lexicographically before selecting one.
* <b>**NATURAL**</b>  
  Sort packages using natural order (see **strverscmp(3)** manual),
  i.e. such that contiguous digits are compared as whole numbers.
  .UNINDENT

Natural sorting can be employed to return the highest version when multiple
versions of the same library are found by **find\_package()**.  For
example suppose that the following libraries have been found:
.INDENT 0.0

* ·  
  libX-1.1.0
* ·  
  libX-1.2.9
* ·  
  libX-1.2.10
  .UNINDENT

By setting **NATURAL** order we can select the one with the highest
version number **libX-1.2.10**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
    find_package(libX CONFIG)
    .ft P
.UNINDENT
.UNINDENT

The sort direction can be controlled using the
**CMAKE\_FIND\_PACKAGE\_SORT\_DIRECTION** variable
(by default decrescent, e.g. lib-B will be tested before lib-A).

<a name="cmake_generator"></a>

### CMAKE_GENERATOR


The generator used to build the project.  See **cmake-generators(7)**.

The name of the generator that is being used to generate the build
files.  (e.g.  **Unix Makefiles**, **Ninja**, etc.)

The value of this variable should never be modified by project code.
A generator may be selected via the **cmake(1)** **-G** option,
interactively in **cmake-gui(1)**, or via the **CMAKE\_GENERATOR**
environment variable.

<a name="cmake_generator_instance"></a>

### CMAKE_GENERATOR_INSTANCE


Generator-specific instance specification provided by user.

Some CMake generators support selection of an instance of the native build
system when multiple instances are available.  If the user specifies an
instance (e.g. by setting this cache entry or via the
**CMAKE\_GENERATOR\_INSTANCE** environment variable), or after a default
instance is chosen when a build tree is first configured, the value will be
available in this variable.

The value of this variable should never be modified by project code.
A toolchain file specified by the **CMAKE\_TOOLCHAIN\_FILE**
variable may initialize **CMAKE\_GENERATOR\_INSTANCE** as a cache entry.
Once a given build tree has been initialized with a particular value
for this variable, changing the value has undefined behavior.

Instance specification is supported only on specific generators:
.INDENT 0.0

* ·  
  For the **Visual Studio 15 2017** generator (and above)
  this specifies the absolute path to the VS installation directory
  of the selected VS instance.
  .UNINDENT

See native build system documentation for allowed instance values.

<a name="cmake_generator_platform"></a>

### CMAKE_GENERATOR_PLATFORM


Generator-specific target platform specification provided by user.

Some CMake generators support a target platform name to be given
to the native build system to choose a compiler toolchain.
If the user specifies a platform name (e.g. via the **cmake(1)** **-A**
option or via the **CMAKE\_GENERATOR\_PLATFORM** environment variable)
the value will be available in this variable.

The value of this variable should never be modified by project code.
A toolchain file specified by the **CMAKE\_TOOLCHAIN\_FILE**
variable may initialize **CMAKE\_GENERATOR\_PLATFORM**.  Once a given
build tree has been initialized with a particular value for this
variable, changing the value has undefined behavior.

Platform specification is supported only on specific generators:
.INDENT 0.0

* ·  
  For Visual Studio Generators with VS 2005 and above this
  specifies the target architecture.
* ·  
  For **Green Hills MULTI** this specifies the target architecture.
  .UNINDENT

See native build system documentation for allowed platform names.

<a name="visual-studio-platform-selection"></a>

### Visual Studio Platform Selection


On Visual Studio Generators the selected platform name
is provided in the **CMAKE\_VS\_PLATFORM\_NAME** variable.

<a name="cmake_generator_toolset"></a>

### CMAKE_GENERATOR_TOOLSET


Native build system toolset specification provided by user.

Some CMake generators support a toolset specification to tell the
native build system how to choose a compiler.  If the user specifies
a toolset (e.g. via the **cmake(1)** **-T** option or via
the **CMAKE\_GENERATOR\_TOOLSET** environment variable) the value
will be available in this variable.

The value of this variable should never be modified by project code.
A toolchain file specified by the **CMAKE\_TOOLCHAIN\_FILE**
variable may initialize **CMAKE\_GENERATOR\_TOOLSET**.  Once a given
build tree has been initialized with a particular value for this
variable, changing the value has undefined behavior.

Toolset specification is supported only on specific generators:
.INDENT 0.0

* ·  
  Visual Studio Generators for VS 2010 and above
* ·  
  The **Xcode** generator for Xcode 3.0 and above
* ·  
  The **Green Hills MULTI** generator
  .UNINDENT

See native build system documentation for allowed toolset names.

<a name="visual-studio-toolset-selection"></a>

### Visual Studio Toolset Selection


The Visual Studio Generators support toolset specification
using one of these forms:
.INDENT 0.0

* ·  
  **toolset**
* ·  
  **toolset[,key=value]***
* ·  
  **key=value[,key=value]***
  .UNINDENT

The **toolset** specifies the toolset name.  The selected toolset name
is provided in the **CMAKE\_VS\_PLATFORM\_TOOLSET** variable.

The **key=value** pairs form a comma-separated list of options to
specify generator-specific details of the toolset selection.
Supported pairs are:
.INDENT 0.0

* <b>**cuda=&lt;version&gt;|&lt;path&gt;**</b>  
  Specify the CUDA toolkit version to use or the path to a
  standalone CUDA toolkit directory.  Supported by VS 2010
  and above. The version can only be used with the CUDA
  toolkit VS integration globally installed.
  See the **CMAKE\_VS\_PLATFORM\_TOOLSET\_CUDA** and
  **CMAKE\_VS\_PLATFORM\_TOOLSET\_CUDA\_CUSTOM\_DIR** variables.
* <b>**host=&lt;arch&gt;**</b>  
  Specify the host tools architecture as **x64** or **x86**.
  Supported by VS 2013 and above.
  See the **CMAKE\_VS\_PLATFORM\_TOOLSET\_HOST\_ARCHITECTURE**
  variable.
* <b>**version=&lt;version&gt;**</b>  
  Specify the toolset version to use.  Supported by VS 2017
  and above with the specified toolset installed.
  See the **CMAKE\_VS\_PLATFORM\_TOOLSET\_VERSION** variable.
* <b>**VCTargetsPath=&lt;path&gt;**</b>  
  Specify an alternative **VCTargetsPath** value for Visual Studio
  project files.  This allows use of VS platform extension configuration
  files (**.props** and **.targets**) that are not installed with VS.
  .UNINDENT

<a name="cmake_import_library_prefix"></a>

### CMAKE_IMPORT_LIBRARY_PREFIX


The prefix for import libraries that you link to.

The prefix to use for the name of an import library if used on this
platform.

**CMAKE\_IMPORT\_LIBRARY\_PREFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_import_library_suffix"></a>

### CMAKE_IMPORT_LIBRARY_SUFFIX


The suffix for import libraries that you link to.

The suffix to use for the end of an import library filename if used on
this platform.

**CMAKE\_IMPORT\_LIBRARY\_SUFFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_job_pool_compile"></a>

### CMAKE_JOB_POOL_COMPILE


This variable is used to initialize the **JOB\_POOL\_COMPILE**
property on all the targets. See **JOB\_POOL\_COMPILE**
for additional information.

<a name="cmake_job_pool_link"></a>

### CMAKE_JOB_POOL_LINK


This variable is used to initialize the **JOB\_POOL\_LINK**
property on all the targets. See **JOB\_POOL\_LINK**
for additional information.

<a name="cmake_job_pool_precompile_header"></a>

### CMAKE_JOB_POOL_PRECOMPILE_HEADER


This variable is used to initialize the **JOB\_POOL\_PRECOMPILE\_HEADER**
property on all the targets. See **JOB\_POOL\_PRECOMPILE\_HEADER**
for additional information.

<a name="cmake_job_pools"></a>

### CMAKE_JOB_POOLS


If the **JOB\_POOLS** global property is not set, the value
of this variable is used in its place.  See **JOB\_POOLS**
for additional information.

<a name="cmake_ltlanggt_compiler_ar"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_AR


A wrapper around **ar** adding the appropriate **--plugin** option for the
compiler.

See also **CMAKE\_AR**.

<a name="cmake_ltlanggt_compiler_ranlib"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_RANLIB


A wrapper around **ranlib** adding the appropriate **--plugin** option for the
compiler.

See also **CMAKE\_RANLIB**.

<a name="cmake_ltlanggt_link_library_suffix"></a>

### CMAKE_&lt;LANG&gt;_LINK_LIBRARY_SUFFIX


Language-specific suffix for libraries that you link to.

The suffix to use for the end of a library filename, **.lib** on Windows.

<a name="cmake_link_library_suffix"></a>

### CMAKE_LINK_LIBRARY_SUFFIX


The suffix for libraries that you link to.

The suffix to use for the end of a library filename, **.lib** on Windows.

<a name="cmake_link_search_end_static"></a>

### CMAKE_LINK_SEARCH_END_STATIC


End a link line such that static system libraries are used.

Some linkers support switches such as **-Bstatic** and **-Bdynamic** to
determine whether to use static or shared libraries for **-lXXX** options.
CMake uses these options to set the link type for libraries whose full
paths are not known or (in some cases) are in implicit link
directories for the platform.  By default CMake adds an option at the
end of the library list (if necessary) to set the linker search type
back to its starting type.  This property switches the final linker
search type to **-Bstatic** regardless of how it started.

This variable is used to initialize the target property
**LINK\_SEARCH\_END\_STATIC** for all targets. If set, it’s
value is also used by the **try\_compile()** command.

See also **CMAKE\_LINK\_SEARCH\_START\_STATIC**.

<a name="cmake_link_search_start_static"></a>

### CMAKE_LINK_SEARCH_START_STATIC


Assume the linker looks for static libraries by default.

Some linkers support switches such as **-Bstatic** and **-Bdynamic** to
determine whether to use static or shared libraries for **-lXXX** options.
CMake uses these options to set the link type for libraries whose full
paths are not known or (in some cases) are in implicit link
directories for the platform.  By default the linker search type is
assumed to be **-Bdynamic** at the beginning of the library list.  This
property switches the assumption to **-Bstatic**.  It is intended for use
when linking an executable statically (e.g.  with the GNU **-static**
option).

This variable is used to initialize the target property
**LINK\_SEARCH\_START\_STATIC** for all targets.  If set, it’s
value is also used by the **try\_compile()** command.

See also **CMAKE\_LINK\_SEARCH\_END\_STATIC**.

<a name="cmake_major_version"></a>

### CMAKE_MAJOR_VERSION


First version number component of the **CMAKE\_VERSION**
variable.

<a name="cmake_make_program"></a>

### CMAKE_MAKE_PROGRAM


Tool that can launch the native build system.
The value may be the full path to an executable or just the tool
name if it is expected to be in the **PATH**.

The tool selected depends on the **CMAKE\_GENERATOR** used
to configure the project:
.INDENT 0.0

* ·  
  The Makefile Generators set this to **make**, **gmake**, or
  a generator-specific tool (e.g. **nmake** for **NMake Makefiles**).

These generators store **CMAKE\_MAKE\_PROGRAM** in the CMake cache
so that it may be edited by the user.

* ·  
  The **Ninja** generator sets this to **ninja**.

This generator stores **CMAKE\_MAKE\_PROGRAM** in the CMake cache
so that it may be edited by the user.

* ·  
  The **Xcode** generator sets this to **xcodebuild**.

This generator prefers to lookup the build tool at build time
rather than to store **CMAKE\_MAKE\_PROGRAM** in the CMake cache
ahead of time.  This is because **xcodebuild** is easy to find.

For compatibility with versions of CMake prior to 3.2, if
a user or project explicitly adds **CMAKE\_MAKE\_PROGRAM** to
the CMake cache then CMake will use the specified value.

* ·  
  The Visual Studio Generators set this to the full path to
  **MSBuild.exe** (VS &gt;= 10), **devenv.com** (VS 7,8,9), or
  **VCExpress.exe** (VS Express 8,9).
  (See also variables
  **CMAKE\_VS\_MSBUILD\_COMMAND** and
  **CMAKE\_VS\_DEVENV\_COMMAND**.

These generators prefer to lookup the build tool at build time
rather than to store **CMAKE\_MAKE\_PROGRAM** in the CMake cache
ahead of time.  This is because the tools are version-specific
and can be located using the Windows Registry.  It is also
necessary because the proper build tool may depend on the
project content (e.g. the Intel Fortran plugin to VS 10 and 11
requires **devenv.com** to build its **.vfproj** project files
even though **MSBuild.exe** is normally preferred to support
the **CMAKE\_GENERATOR\_TOOLSET**).

For compatibility with versions of CMake prior to 3.0, if
a user or project explicitly adds **CMAKE\_MAKE\_PROGRAM** to
the CMake cache then CMake will use the specified value if
possible.

* ·  
  The **Green Hills MULTI** generator sets this to the full
  path to **gbuild.exe(Windows)** or **gbuild(Linux)** based upon
  the toolset being used.

Once the generator has initialized a particular value for this
variable, changing the value has undefined behavior.
.UNINDENT

The **CMAKE\_MAKE\_PROGRAM** variable is set for use by project code.
The value is also used by the **cmake(1)** **--build** and
**ctest(1)** **--build-and-test** tools to launch the native
build process.

<a name="cmake_match_count"></a>

### CMAKE_MATCH_COUNT


The number of matches with the last regular expression.

When a regular expression match is used, CMake fills in
**CMAKE\_MATCH\_&lt;n&gt;** variables with the match contents.
The **CMAKE\_MATCH\_COUNT** variable holds the number of match
expressions when these are filled.

<a name="cmake_match_ltngt"></a>

### CMAKE_MATCH_&lt;n&gt;


Capture group **&lt;n&gt;** matched by the last regular expression, for groups
0 through 9.  Group 0 is the entire match.  Groups 1 through 9 are the
subexpressions captured by **()** syntax.

When a regular expression match is used, CMake fills in **CMAKE\_MATCH\_&lt;n&gt;**
variables with the match contents.  The **CMAKE\_MATCH\_COUNT**
variable holds the number of match expressions when these are filled.

<a name="cmake_minimum_required_version"></a>

### CMAKE_MINIMUM_REQUIRED_VERSION


The **&lt;min&gt;** version of CMake given to the most recent call to the
**cmake\_minimum\_required(VERSION)** command.

<a name="cmake_minor_version"></a>

### CMAKE_MINOR_VERSION


Second version number component of the **CMAKE\_VERSION**
variable.

<a name="cmake_netrc"></a>

### CMAKE_NETRC


This variable is used to initialize the **NETRC** option for
**file(DOWNLOAD)** and **file(UPLOAD)** commands and the
module **ExternalProject**. See those commands for additional
information.

The local option takes precedence over this variable.

<a name="cmake_netrc_file"></a>

### CMAKE_NETRC_FILE


This variable is used to initialize the **NETRC\_FILE** option for
**file(DOWNLOAD)** and **file(UPLOAD)** commands and the
module **ExternalProject**. See those commands for additional
information.

The local option takes precedence over this variable.

<a name="cmake_parent_list_file"></a>

### CMAKE_PARENT_LIST_FILE


Full path to the CMake file that included the current one.

While processing a CMake file loaded by **include()** or
**find\_package()** this variable contains the full path to the file
including it.  The top of the include stack is always the **CMakeLists.txt**
for the current directory.  See also **CMAKE\_CURRENT\_LIST\_FILE**.

<a name="cmake_patch_version"></a>

### CMAKE_PATCH_VERSION


Third version number component of the **CMAKE\_VERSION**
variable.

<a name="cmake_project_description"></a>

### CMAKE_PROJECT_DESCRIPTION


The description of the top level project.

This variable holds the description of the project as specified in the top
level CMakeLists.txt file by a **project()** command.  In the event that
the top level CMakeLists.txt contains multiple **project()** calls,
the most recently called one from that top level CMakeLists.txt will determine
the value that **CMAKE\_PROJECT\_DESCRIPTION** contains.  For example, consider
the following top level CMakeLists.txt:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.0)
    project(First DESCRIPTION "I am First")
    project(Second DESCRIPTION "I am Second")
    add_subdirectory(sub)
    project(Third DESCRIPTION "I am Third")
    .ft P
.UNINDENT
.UNINDENT

And **sub/CMakeLists.txt** with the following contents:
.INDENT 0.0
.INDENT 3.5

    .ft C
    project(SubProj DESCRIPTION "I am SubProj")
    message("CMAKE_PROJECT_DESCRIPTION = ${CMAKE_PROJECT_DESCRIPTION}")
    .ft P
.UNINDENT
.UNINDENT

The most recently seen **project()** command from the top level
CMakeLists.txt would be **project(Second ...)**, so this will print:
.INDENT 0.0
.INDENT 3.5

    .ft C
    CMAKE_PROJECT_DESCRIPTION = I am Second
    .ft P
.UNINDENT
.UNINDENT

To obtain the description from the most recent call to **project()** in
the current directory scope or above, see the **PROJECT\_DESCRIPTION**
variable.

<a name="cmake_project_homepage_url"></a>

### CMAKE_PROJECT_HOMEPAGE_URL


The homepage URL of the top level project.

This variable holds the homepage URL of the project as specified in the top
level CMakeLists.txt file by a **project()** command.  In the event that
the top level CMakeLists.txt contains multiple **project()** calls,
the most recently called one from that top level CMakeLists.txt will determine
the value that **CMAKE\_PROJECT\_HOMEPAGE\_URL** contains.  For example, consider
the following top level CMakeLists.txt:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.0)
    project(First HOMEPAGE_URL "http://first.example.com")
    project(Second HOMEPAGE_URL "http://second.example.com")
    add_subdirectory(sub)
    project(Third HOMEPAGE_URL "http://third.example.com")
    .ft P
.UNINDENT
.UNINDENT

And **sub/CMakeLists.txt** with the following contents:
.INDENT 0.0
.INDENT 3.5

    .ft C
    project(SubProj HOMEPAGE_URL "http://subproj.example.com")
    message("CMAKE_PROJECT_HOMEPAGE_URL = ${CMAKE_PROJECT_HOMEPAGE_URL}")
    .ft P
.UNINDENT
.UNINDENT

The most recently seen **project()** command from the top level
CMakeLists.txt would be **project(Second ...)**, so this will print:
.INDENT 0.0
.INDENT 3.5

    .ft C
    CMAKE_PROJECT_HOMEPAGE_URL = http://second.example.com
    .ft P
.UNINDENT
.UNINDENT

To obtain the homepage URL from the most recent call to **project()** in
the current directory scope or above, see the **PROJECT\_HOMEPAGE\_URL**
variable.

<a name="cmake_project_name"></a>

### CMAKE_PROJECT_NAME


The name of the top level project.

This variable holds the name of the project as specified in the top
level CMakeLists.txt file by a **project()** command.  In the event that
the top level CMakeLists.txt contains multiple **project()** calls,
the most recently called one from that top level CMakeLists.txt will determine
the name that **CMAKE\_PROJECT\_NAME** contains.  For example, consider
the following top level CMakeLists.txt:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.0)
    project(First)
    project(Second)
    add_subdirectory(sub)
    project(Third)
    .ft P
.UNINDENT
.UNINDENT

And **sub/CMakeLists.txt** with the following contents:
.INDENT 0.0
.INDENT 3.5

    .ft C
    project(SubProj)
    message("CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}")
    .ft P
.UNINDENT
.UNINDENT

The most recently seen **project()** command from the top level
CMakeLists.txt would be **project(Second)**, so this will print:
.INDENT 0.0
.INDENT 3.5

    .ft C
    CMAKE_PROJECT_NAME = Second
    .ft P
.UNINDENT
.UNINDENT

To obtain the name from the most recent call to **project()** in
the current directory scope or above, see the **PROJECT\_NAME**
variable.

<a name="cmake_project_version"></a>

### CMAKE_PROJECT_VERSION


The version of the top level project.

This variable holds the version of the project as specified in the top
level CMakeLists.txt file by a **project()** command.  In the event that
the top level CMakeLists.txt contains multiple **project()** calls,
the most recently called one from that top level CMakeLists.txt will determine
the value that **CMAKE\_PROJECT\_VERSION** contains.  For example, consider
the following top level CMakeLists.txt:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.0)
    project(First VERSION 1.2.3)
    project(Second VERSION 3.4.5)
    add_subdirectory(sub)
    project(Third VERSION 6.7.8)
    .ft P
.UNINDENT
.UNINDENT

And **sub/CMakeLists.txt** with the following contents:
.INDENT 0.0
.INDENT 3.5

    .ft C
    project(SubProj VERSION 1)
    message("CMAKE_PROJECT_VERSION = ${CMAKE_PROJECT_VERSION}")
    .ft P
.UNINDENT
.UNINDENT

The most recently seen **project()** command from the top level
CMakeLists.txt would be **project(Second ...)**, so this will print:
.INDENT 0.0
.INDENT 3.5

    .ft C
    CMAKE_PROJECT_VERSION = 3.4.5
    .ft P
.UNINDENT
.UNINDENT

To obtain the version from the most recent call to **project()** in
the current directory scope or above, see the **PROJECT\_VERSION**
variable.

<a name="cmake_project_version_major"></a>

### CMAKE_PROJECT_VERSION_MAJOR


The major version of the top level project.

This variable holds the major version of the project as specified in the top
level CMakeLists.txt file by a **project()** command. Please see
**CMAKE\_PROJECT\_VERSION** documentation for the behavior when
multiple **project()** commands are used in the sources.

<a name="cmake_project_version_minor"></a>

### CMAKE_PROJECT_VERSION_MINOR


The minor version of the top level project.

This variable holds the minor version of the project as specified in the top
level CMakeLists.txt file by a **project()** command. Please see
**CMAKE\_PROJECT\_VERSION** documentation for the behavior when
multiple **project()** commands are used in the sources.

<a name="cmake_project_version_patch"></a>

### CMAKE_PROJECT_VERSION_PATCH


The patch version of the top level project.

This variable holds the patch version of the project as specified in the top
level CMakeLists.txt file by a **project()** command. Please see
**CMAKE\_PROJECT\_VERSION** documentation for the behavior when
multiple **project()** commands are used in the sources.

<a name="cmake_project_version_tweak"></a>

### CMAKE_PROJECT_VERSION_TWEAK


The tweak version of the top level project.

This variable holds the tweak version of the project as specified in the top
level CMakeLists.txt file by a **project()** command. Please see
**CMAKE\_PROJECT\_VERSION** documentation for the behavior when
multiple **project()** commands are used in the sources.

<a name="cmake_ranlib"></a>

### CMAKE_RANLIB


Name of randomizing tool for static libraries.

This specifies name of the program that randomizes libraries on UNIX,
not used on Windows, but may be present.

<a name="cmake_root"></a>

### CMAKE_ROOT


Install directory for running cmake.

This is the install root for the running CMake and the **Modules**
directory can be found here.  This is commonly used in this format:
**${CMAKE\_ROOT}/Modules**

<a name="cmake_rule_messages"></a>

### CMAKE_RULE_MESSAGES


Specify whether to report a message for each make rule.

If set in the cache it is used to initialize the value of the **RULE\_MESSAGES** property.
Users may disable the option in their local build tree to disable granular messages
and report only as each target completes in Makefile builds.

<a name="cmake_script_mode_file"></a>

### CMAKE_SCRIPT_MODE_FILE


Full path to the **cmake(1)** **-P** script file currently being
processed.

When run in **cmake(1)** **-P** script mode, CMake sets this variable to
the full path of the script file.  When run to configure a **CMakeLists.txt**
file, this variable is not set.

<a name="cmake_shared_library_prefix"></a>

### CMAKE_SHARED_LIBRARY_PREFIX


The prefix for shared libraries that you link to.

The prefix to use for the name of a shared library, **lib** on UNIX.

**CMAKE\_SHARED\_LIBRARY\_PREFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_shared_library_suffix"></a>

### CMAKE_SHARED_LIBRARY_SUFFIX


The suffix for shared libraries that you link to.

The suffix to use for the end of a shared library filename, **.dll** on
Windows.

**CMAKE\_SHARED\_LIBRARY\_SUFFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_shared_module_prefix"></a>

### CMAKE_SHARED_MODULE_PREFIX


The prefix for loadable modules that you link to.

The prefix to use for the name of a loadable module on this platform.

**CMAKE\_SHARED\_MODULE\_PREFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_shared_module_suffix"></a>

### CMAKE_SHARED_MODULE_SUFFIX


The suffix for shared libraries that you link to.

The suffix to use for the end of a loadable module filename on this
platform

**CMAKE\_SHARED\_MODULE\_SUFFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_sizeof_void_p"></a>

### CMAKE_SIZEOF_VOID_P


Size of a **void** pointer.

This is set to the size of a pointer on the target machine, and is determined
by a try compile.  If a 64-bit size is found, then the library search
path is modified to look for 64-bit libraries first.

<a name="cmake_skip_install_rules"></a>

### CMAKE_SKIP_INSTALL_RULES


Whether to disable generation of installation rules.

If **TRUE**, CMake will neither generate installation rules nor
will it generate **cmake\_install.cmake** files. This variable is **FALSE** by
default.

<a name="cmake_skip_rpath"></a>

### CMAKE_SKIP_RPATH


If true, do not add run time path information.

If this is set to **TRUE**, then the rpath information is not added to
compiled executables.  The default is to add rpath information if the
platform supports it.  This allows for easy running from the build
tree.  To omit RPATH in the install step, but not the build step, use
**CMAKE\_SKIP\_INSTALL\_RPATH** instead.

<a name="cmake_source_dir"></a>

### CMAKE_SOURCE_DIR


The path to the top level of the source tree.

This is the full path to the top level of the current CMake source
tree.  For an in-source build, this would be the same as
**CMAKE\_BINARY\_DIR**.

When run in **-P** script mode, CMake sets the variables
**CMAKE\_BINARY\_DIR**, _CMAKE\_SOURCE\_DIR_,
**CMAKE\_CURRENT\_BINARY\_DIR** and
**CMAKE\_CURRENT\_SOURCE\_DIR** to the current working directory.

<a name="cmake_static_library_prefix"></a>

### CMAKE_STATIC_LIBRARY_PREFIX


The prefix for static libraries that you link to.

The prefix to use for the name of a static library, **lib** on UNIX.

**CMAKE\_STATIC\_LIBRARY\_PREFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_static_library_suffix"></a>

### CMAKE_STATIC_LIBRARY_SUFFIX


The suffix for static libraries that you link to.

The suffix to use for the end of a static library filename, **.lib** on
Windows.

**CMAKE\_STATIC\_LIBRARY\_SUFFIX\_&lt;LANG&gt;** overrides this for language **&lt;LANG&gt;**.

<a name="cmake_swift_module_directory"></a>

### CMAKE_Swift_MODULE_DIRECTORY


Swift module output directory.

This variable is used to initialise the **Swift\_MODULE\_DIRECTORY**
property on all the targets.  See the target property for additional
information.

<a name="cmake_swift_num_threads"></a>

### CMAKE_Swift_NUM_THREADS


Number of threads for parallel compilation for Swift targets.

This variable controls the number of parallel jobs that the swift driver creates
for building targets.  If not specified, it will default to the number of
logical CPUs on the host.

<a name="cmake_toolchain_file"></a>

### CMAKE_TOOLCHAIN_FILE


Path to toolchain file supplied to **cmake(1)**.

This variable is specified on the command line when cross-compiling with CMake.
It is the path to a file which is read early in the CMake run and which
specifies locations for compilers and toolchain utilities, and other target
platform and compiler related information.

<a name="cmake_tweak_version"></a>

### CMAKE_TWEAK_VERSION


Defined to **0** for compatibility with code written for older
CMake versions that may have defined higher values.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
In CMake versions 2.8.2 through 2.8.12, this variable holds
the fourth version number component of the
**CMAKE\_VERSION** variable.
.UNINDENT
.UNINDENT

<a name="cmake_verbose_makefile"></a>

### CMAKE_VERBOSE_MAKEFILE


Enable verbose output from Makefile builds.

This variable is a cache entry initialized (to **FALSE**) by
the **project()** command.  Users may enable the option
in their local build tree to get more verbose output from
Makefile builds and show each command line as it is launched.

<a name="cmake_version"></a>

### CMAKE_VERSION


The CMake version string as three non-negative integer components
separated by **.** and possibly followed by **-** and other information.
The first two components represent the feature level and the third
component represents either a bug-fix level or development date.

Release versions and release candidate versions of CMake use the format:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <major>.<minor>.<patch>[-rc<n>]
    .ft P
.UNINDENT
.UNINDENT

where the **&lt;patch&gt;** component is less than **20000000**.  Development
versions of CMake use the format:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <major>.<minor>.<date>[-<id>]
    .ft P
.UNINDENT
.UNINDENT

where the **&lt;date&gt;** component is of format **CCYYMMDD** and **&lt;id&gt;**
may contain arbitrary text.  This represents development as of a
particular date following the **&lt;major&gt;.&lt;minor&gt;** feature release.

Individual component values are also available in variables:
.INDENT 0.0

* ·  
  **CMAKE\_MAJOR\_VERSION**
* ·  
  **CMAKE\_MINOR\_VERSION**
* ·  
  **CMAKE\_PATCH\_VERSION**
* ·  
  **CMAKE\_TWEAK\_VERSION**
  .UNINDENT

Use the **if()** command **VERSION\_LESS**, **VERSION\_GREATER**,
**VERSION\_EQUAL**, **VERSION\_LESS\_EQUAL**, or **VERSION\_GREATER\_EQUAL**
operators to compare version string values against **CMAKE\_VERSION** using a
component-wise test.  Version component values may be 10 or larger so do not
attempt to compare version strings as floating-point numbers.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
CMake versions 2.8.2 through 2.8.12 used three components for the
feature level.  Release versions represented the bug-fix level in a
fourth component, i.e. **&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;[.&lt;tweak&gt;][-rc&lt;n&gt;]**.
Development versions represented the development date in the fourth
component, i.e. **&lt;major&gt;.&lt;minor&gt;.&lt;patch&gt;.&lt;date&gt;[-&lt;id&gt;]**.

CMake versions prior to 2.8.2 used three components for the
feature level and had no bug-fix component.  Release versions
used an even-valued second component, i.e.
**&lt;major&gt;.&lt;even-minor&gt;.&lt;patch&gt;[-rc&lt;n&gt;]**.  Development versions
used an odd-valued second component with the development date as
the third component, i.e. **&lt;major&gt;.&lt;odd-minor&gt;.&lt;date&gt;**.

The **CMAKE\_VERSION** variable is defined by CMake 2.6.3 and higher.
Earlier versions defined only the individual component variables.
.UNINDENT
.UNINDENT

<a name="cmake_vs_devenv_command"></a>

### CMAKE_VS_DEVENV_COMMAND


The generators for **Visual Studio 9 2008** and above set this
variable to the **devenv.com** command installed with the corresponding
Visual Studio version.  Note that this variable may be empty on
Visual Studio Express editions because they do not provide this tool.

This variable is not defined by other generators even if **devenv.com**
is installed on the computer.

The **CMAKE\_VS\_MSBUILD\_COMMAND** is also provided for
**Visual Studio 10 2010** and above.
See also the **CMAKE\_MAKE\_PROGRAM** variable.

<a name="cmake_vs_msbuild_command"></a>

### CMAKE_VS_MSBUILD_COMMAND


The generators for **Visual Studio 10 2010** and above set this
variable to the **MSBuild.exe** command installed with the corresponding
Visual Studio version.

This variable is not defined by other generators even if **MSBuild.exe**
is installed on the computer.

The **CMAKE\_VS\_DEVENV\_COMMAND** is also provided for the
non-Express editions of Visual Studio.
See also the **CMAKE\_MAKE\_PROGRAM** variable.

<a name="cmake_vs_nsighttegra_version"></a>

### CMAKE_VS_NsightTegra_VERSION


When using a Visual Studio generator with the
**CMAKE\_SYSTEM\_NAME** variable set to **Android**,
this variable contains the version number of the
installed NVIDIA Nsight Tegra Visual Studio Edition.

<a name="cmake_vs_platform_name"></a>

### CMAKE_VS_PLATFORM_NAME


Visual Studio target platform name used by the current generator.

VS 8 and above allow project files to specify a target platform.
CMake provides the name of the chosen platform in this variable.
See the **CMAKE\_GENERATOR\_PLATFORM** variable for details.

See also the **CMAKE\_VS\_PLATFORM\_NAME\_DEFAULT** variable.

<a name="cmake_vs_platform_name_default"></a>

### CMAKE_VS_PLATFORM_NAME_DEFAULT


Default for the Visual Studio target platform name for the current generator
without considering the value of the **CMAKE\_GENERATOR\_PLATFORM**
variable.  For Visual Studio Generators for VS 2017 and below this is
always **Win32**.  For VS 2019 and above this is based on the host platform.

See also the **CMAKE\_VS\_PLATFORM\_NAME** variable.

<a name="cmake_vs_platform_toolset"></a>

### CMAKE_VS_PLATFORM_TOOLSET


Visual Studio Platform Toolset name.

VS 10 and above use MSBuild under the hood and support multiple
compiler toolchains.  CMake may specify a toolset explicitly, such as
**v110** for VS 11 or **Windows7.1SDK** for 64-bit support in VS 10
Express.  CMake provides the name of the chosen toolset in this
variable.

See the **CMAKE\_GENERATOR\_TOOLSET** variable for details.

<a name="cmake_vs_platform_toolset_cuda"></a>

### CMAKE_VS_PLATFORM_TOOLSET_CUDA


NVIDIA CUDA Toolkit version whose Visual Studio toolset to use.

The Visual Studio Generators for VS 2010 and above support using
a CUDA toolset provided by a CUDA Toolkit.  The toolset version number
may be specified by a field in **CMAKE\_GENERATOR\_TOOLSET** of
the form **cuda=8.0**. Or it is automatically detected if a path to
a standalone CUDA directory is specified in the form **cuda=C:\epath\eto\ecuda**.
If none is specified CMake will choose a default version.
CMake provides the selected CUDA toolset version in this variable.
The value may be empty if no CUDA Toolkit with Visual Studio integration
is installed.

<a name="cmake_vs_platform_toolset_cuda_custom_dir"></a>

### CMAKE_VS_PLATFORM_TOOLSET_CUDA_CUSTOM_DIR


Path to standalone NVIDIA CUDA Toolkit (eg. extracted from installer).

The Visual Studio Generators for VS 2010 and above support using
a standalone (non-installed) NVIDIA CUDA toolkit.  The path
may be specified by a field in **CMAKE\_GENERATOR\_TOOLSET** of
the form **cuda=C:\epath\eto\ecuda**.  The given directory must at least
contain a folder **.\envcc** and must provide Visual Studio integration
files in path .\eCUDAVisualStudioIntegration\eextras\e
visual\_studio\_integration\eMSBuildExtensions\e. One can create a standalone
CUDA toolkit directory by either opening a installer with 7zip or
copying the files that are extracted by the running installer.
The value may be empty if no path to a standalone CUDA Toolkit was
specified.

<a name="cmake_vs_platform_toolset_host_architecture"></a>

### CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE


Visual Studio preferred tool architecture.

The Visual Studio Generators for VS 2013 and above support using
either the 32-bit or 64-bit host toolchains by specifying a **host=x86**
or **host=x64** value in the **CMAKE\_GENERATOR\_TOOLSET** option.
CMake provides the selected toolchain architecture preference in this
variable (**x86**, **x64**, or empty).

<a name="cmake_vs_platform_toolset_version"></a>

### CMAKE_VS_PLATFORM_TOOLSET_VERSION


Visual Studio Platform Toolset version.

The Visual Studio Generators for VS 2017 and above allow to
select minor versions of the same toolset. The toolset version number
may be specified by a field in **CMAKE\_GENERATOR\_TOOLSET** of
the form **version=14.11**. If none is specified CMake will choose a default
toolset. The value may be empty if no minor version was selected and the
default is used.

<a name="cmake_vs_windows_target_platform_version"></a>

### CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION


Visual Studio Windows Target Platform Version.

When targeting Windows 10 and above Visual Studio 2015 and above support
specification of a target Windows version to select a corresponding SDK.
The **CMAKE\_SYSTEM\_VERSION** variable may be set to specify a
version.  Otherwise CMake computes a default version based on the Windows
SDK versions available.  The chosen Windows target version number is provided
in **CMAKE\_VS\_WINDOWS\_TARGET\_PLATFORM\_VERSION**.  If no Windows 10 SDK
is available this value will be empty.

One may set a **CMAKE\_WINDOWS\_KITS\_10\_DIR** _environment variable_
to an absolute path to tell CMake to look for Windows 10 SDKs in
a custom location.  The specified directory is expected to contain
**Include/10.0.*** directories.

<a name="cmake_xcode_generate_scheme"></a>

### CMAKE_XCODE_GENERATE_SCHEME


If enabled, the **Xcode** generator will generate schema files.  These
are useful to invoke analyze, archive, build-for-testing and test
actions from the command line.

This variable initializes the
**XCODE\_GENERATE\_SCHEME**
target property on all targets.

<a name="cmake_xcode_platform_toolset"></a>

### CMAKE_XCODE_PLATFORM_TOOLSET


Xcode compiler selection.

**Xcode** supports selection of a compiler from one of the installed
toolsets.  CMake provides the name of the chosen toolset in this
variable, if any is explicitly selected (e.g.  via the **cmake(1)**
**-T** option).

<a name="ltproject-namegt_binary_dir"></a>

### &lt;PROJECT\-NAME&gt;_BINARY_DIR


Top level binary directory for the named project.

A variable is created with the name used in the **project()** command,
and is the binary directory for the project.  This can be useful when
**add\_subdirectory()** is used to connect several projects.

<a name="ltproject-namegt_description"></a>

### &lt;PROJECT\-NAME&gt;_DESCRIPTION


Value given to the **DESCRIPTION** option of the most recent call to the
**project()** command with project name **&lt;PROJECT-NAME&gt;**, if any.

<a name="ltproject-namegt_homepage_url"></a>

### &lt;PROJECT\-NAME&gt;_HOMEPAGE_URL


Value given to the **HOMEPAGE\_URL** option of the most recent call to the
**project()** command with project name **&lt;PROJECT-NAME&gt;**, if any.

<a name="ltproject-namegt_source_dir"></a>

### &lt;PROJECT\-NAME&gt;_SOURCE_DIR


Top level source directory for the named project.

A variable is created with the name used in the **project()** command,
and is the source directory for the project.  This can be useful when
**add\_subdirectory()** is used to connect several projects.

<a name="ltproject-namegt_version"></a>

### &lt;PROJECT\-NAME&gt;_VERSION


Value given to the **VERSION** option of the most recent call to the
**project()** command with project name **&lt;PROJECT-NAME&gt;**, if any.

See also the component-wise version variables
**&lt;PROJECT-NAME&gt;\_VERSION\_MAJOR**,
**&lt;PROJECT-NAME&gt;\_VERSION\_MINOR**,
**&lt;PROJECT-NAME&gt;\_VERSION\_PATCH**, and
**&lt;PROJECT-NAME&gt;\_VERSION\_TWEAK**.

<a name="ltproject-namegt_version_major"></a>

### &lt;PROJECT\-NAME&gt;_VERSION_MAJOR


First version number component of the **&lt;PROJECT-NAME&gt;\_VERSION**
variable as set by the **project()** command.

<a name="ltproject-namegt_version_minor"></a>

### &lt;PROJECT\-NAME&gt;_VERSION_MINOR


Second version number component of the **&lt;PROJECT-NAME&gt;\_VERSION**
variable as set by the **project()** command.

<a name="ltproject-namegt_version_patch"></a>

### &lt;PROJECT\-NAME&gt;_VERSION_PATCH


Third version number component of the **&lt;PROJECT-NAME&gt;\_VERSION**
variable as set by the **project()** command.

<a name="ltproject-namegt_version_tweak"></a>

### &lt;PROJECT\-NAME&gt;_VERSION_TWEAK


Fourth version number component of the **&lt;PROJECT-NAME&gt;\_VERSION**
variable as set by the **project()** command.

<a name="project_binary_dir"></a>

### PROJECT_BINARY_DIR


Full path to build directory for project.

This is the binary directory of the most recent **project()** command.

<a name="project_description"></a>

### PROJECT_DESCRIPTION


Short project description given to the project command.

This is the description given to the most recently called **project()**
command in the current directory scope or above.  To obtain the description
of the top level project, see the **CMAKE\_PROJECT\_DESCRIPTION**
variable.

<a name="project_homepage_url"></a>

### PROJECT_HOMEPAGE_URL


The homepage URL of the project.

This is the homepage URL given to the most recently called **project()**
command in the current directory scope or above.  To obtain the homepage URL
of the top level project, see the **CMAKE\_PROJECT\_HOMEPAGE\_URL**
variable.

<a name="project_name"></a>

### PROJECT_NAME


Name of the project given to the project command.

This is the name given to the most recently called **project()**
command in the current directory scope or above.  To obtain the name of
the top level project, see the **CMAKE\_PROJECT\_NAME** variable.

<a name="project_source_dir"></a>

### PROJECT_SOURCE_DIR


Top level source directory for the current project.

This is the source directory of the most recent **project()** command.

<a name="project_version"></a>

### PROJECT_VERSION


Value given to the **VERSION** option of the most recent call to the
**project()** command, if any.

See also the component-wise version variables
**PROJECT\_VERSION\_MAJOR**,
**PROJECT\_VERSION\_MINOR**,
**PROJECT\_VERSION\_PATCH**, and
**PROJECT\_VERSION\_TWEAK**.

<a name="project_version_major"></a>

### PROJECT_VERSION_MAJOR


First version number component of the **PROJECT\_VERSION**
variable as set by the **project()** command.

<a name="project_version_minor"></a>

### PROJECT_VERSION_MINOR


Second version number component of the **PROJECT\_VERSION**
variable as set by the **project()** command.

<a name="project_version_patch"></a>

### PROJECT_VERSION_PATCH


Third version number component of the **PROJECT\_VERSION**
variable as set by the **project()** command.

<a name="project_version_tweak"></a>

### PROJECT_VERSION_TWEAK


Fourth version number component of the **PROJECT\_VERSION**
variable as set by the **project()** command.

<a name="variables-that-change-behavior"></a>

# Variables That Change Behavior


<a name="build_shared_libs"></a>

### BUILD_SHARED_LIBS


Global flag to cause **add\_library()** to create shared libraries if on.

If present and true, this will cause all libraries to be built shared
unless the library was explicitly added as a static library.  This
variable is often added to projects as an **option()** so that each user
of a project can decide if they want to build the project using shared or
static libraries.

<a name="cmake_absolute_destination_files"></a>

### CMAKE_ABSOLUTE_DESTINATION_FILES


List of files which have been installed using an **ABSOLUTE DESTINATION** path.

This variable is defined by CMake-generated **cmake\_install.cmake**
scripts.  It can be used (read-only) by programs or scripts that
source those install scripts.  This is used by some CPack generators
(e.g.  RPM).

<a name="cmake_appbundle_path"></a>

### CMAKE_APPBUNDLE_PATH


Semicolon-separated list of directories specifying a search path
for macOS application bundles used by the **find\_program()**, and
**find\_package()** commands.

<a name="cmake_automoc_relaxed_mode"></a>

### CMAKE_AUTOMOC_RELAXED_MODE


Deprecated since version 3.15.


Switch between strict and relaxed automoc mode.

By default, **AUTOMOC** behaves exactly as described in the
documentation of the **AUTOMOC** target property.  When set to
**TRUE**, it accepts more input and tries to find the correct input file for
**moc** even if it differs from the documented behaviour.  In this mode it
e.g.  also checks whether a header file is intended to be processed by moc
when a **"foo.moc"** file has been included.

Relaxed mode has to be enabled for KDE4 compatibility.

<a name="cmake_backwards_compatibility"></a>

### CMAKE_BACKWARDS_COMPATIBILITY


Deprecated.  See CMake Policy **CMP0001** documentation.

<a name="cmake_build_type"></a>

### CMAKE_BUILD_TYPE


Specifies the build type on single-configuration generators.

This statically specifies what build type (configuration) will be
built in this build tree.  Possible values are empty, **Debug**, **Release**,
**RelWithDebInfo**, **MinSizeRel**, …  This variable is only meaningful to
single-configuration generators (such as Makefile Generators and
**Ninja**) i.e.  those which choose a single configuration when CMake
runs to generate a build tree as opposed to multi-configuration generators
which offer selection of the build configuration within the generated build
environment.  There are many per-config properties and variables
(usually following clean **SOME\_VAR\_&lt;CONFIG&gt;** order conventions), such as
**CMAKE\_C\_FLAGS\_&lt;CONFIG&gt;**, specified as uppercase:
**CMAKE\_C\_FLAGS\_[DEBUG|RELEASE|RELWITHDEBINFO|MINSIZEREL|...]**.  For example,
in a build tree configured to build type **Debug**, CMake will see to
having **CMAKE\_C\_FLAGS\_DEBUG** settings get
added to the **CMAKE\_C\_FLAGS** settings.  See
also **CMAKE\_CONFIGURATION\_TYPES**.

<a name="cmake_codeblocks_compiler_id"></a>

### CMAKE_CODEBLOCKS_COMPILER_ID


Change the compiler id in the generated CodeBlocks project files.

CodeBlocks uses its own compiler id string which differs from
**CMAKE\_&lt;LANG&gt;\_COMPILER\_ID**.  If this variable is left empty,
CMake tries to recognize the CodeBlocks compiler id automatically.
Otherwise the specified string is used in the CodeBlocks project file.
See the CodeBlocks documentation for valid compiler id strings.

Other IDEs like QtCreator that also use the CodeBlocks generator may ignore
this setting.

<a name="cmake_codeblocks_exclude_external_files"></a>

### CMAKE_CODEBLOCKS_EXCLUDE_EXTERNAL_FILES


Change the way the CodeBlocks generator creates project files.

If this variable evaluates to **ON** the generator excludes from
the project file any files that are located outside the project root.

<a name="cmake_codelite_use_targets"></a>

### CMAKE_CODELITE_USE_TARGETS


Change the way the CodeLite generator creates projectfiles.

If this variable evaluates to **ON** at the end of the top-level
**CMakeLists.txt** file, the generator creates projectfiles based on targets
rather than projects.

<a name="cmake_color_makefile"></a>

### CMAKE_COLOR_MAKEFILE


Enables color output when using the Makefile Generators.

When enabled, the generated Makefiles will produce colored output.
Default is **ON**.

<a name="cmake_configuration_types"></a>

### CMAKE_CONFIGURATION_TYPES


Specifies the available build types on multi-config generators.

This specifies what build types (configurations) will be available
such as **Debug**, **Release**, **RelWithDebInfo** etc.  This has reasonable
defaults on most platforms, but can be extended to provide other build
types.  See also **CMAKE\_BUILD\_TYPE** for details of managing
configuration data, and **CMAKE\_CFG\_INTDIR**.

<a name="cmake_depends_in_project_only"></a>

### CMAKE_DEPENDS_IN_PROJECT_ONLY


When set to **TRUE** in a directory, the build system produced by the
Makefile Generators is set up to only consider dependencies on source
files that appear either in the source or in the binary directories.  Changes
to source files outside of these directories will not cause rebuilds.

This should be used carefully in cases where some source files are picked up
through external headers during the build.

<a name="cmake_disable_find_package_ltpackagenamegt"></a>

### CMAKE_DISABLE_FIND_PACKAGE_&lt;PackageName&gt;


Variable for disabling **find\_package()** calls.

Every non-**REQUIRED** **find\_package()** call in a project can be
disabled by setting the variable
**CMAKE\_DISABLE\_FIND\_PACKAGE\_&lt;PackageName&gt;** to **TRUE**.
This can be used to build a project without an optional package,
although that package is installed.

This switch should be used during the initial CMake run.  Otherwise if
the package has already been found in a previous CMake run, the
variables which have been stored in the cache will still be there.  In
that case it is recommended to remove the cache variables for this
package from the cache using the cache editor or **cmake(1)** **-U**

<a name="cmake_eclipse_generate_linked_resources"></a>

### CMAKE_ECLIPSE_GENERATE_LINKED_RESOURCES


This cache variable is used by the Eclipse project generator.  See
**cmake-generators(7)**.

The Eclipse project generator generates so-called linked resources
e.g. to the subproject root dirs in the source tree or to the source files
of targets.
This can be disabled by setting this variable to FALSE.

<a name="cmake_eclipse_generate_source_project"></a>

### CMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT


This cache variable is used by the Eclipse project generator.  See
**cmake-generators(7)**.

If this variable is set to TRUE, the Eclipse project generator will generate
an Eclipse project in **CMAKE\_SOURCE\_DIR** . This project can then
be used in Eclipse e.g. for the version control functionality.
_CMAKE\_ECLIPSE\_GENERATE\_SOURCE\_PROJECT_ defaults to FALSE; so
nothing is written into the source directory.

<a name="cmake_eclipse_make_arguments"></a>

### CMAKE_ECLIPSE_MAKE_ARGUMENTS


This cache variable is used by the Eclipse project generator.  See
**cmake-generators(7)**.

This variable holds arguments which are used when Eclipse invokes the make
tool. By default it is initialized to hold flags to enable parallel builds
(using -j typically).

<a name="cmake_eclipse_resource_encoding"></a>

### CMAKE_ECLIPSE_RESOURCE_ENCODING


This cache variable tells the **Eclipse CDT4** project generator
to set the resource encoding to the given value in generated project files.
If no value is given, no encoding will be set.

<a name="cmake_eclipse_version"></a>

### CMAKE_ECLIPSE_VERSION


This cache variable is used by the Eclipse project generator.  See
**cmake-generators(7)**.

When using the Eclipse project generator, CMake tries to find the Eclipse
executable and detect the version of it. Depending on the version it finds,
some features are enabled or disabled. If CMake doesn’t find
Eclipse, it assumes the oldest supported version, Eclipse Callisto (3.2).

<a name="cmake_error_deprecated"></a>

### CMAKE_ERROR_DEPRECATED


Whether to issue errors for deprecated functionality.

If **TRUE**, use of deprecated functionality will issue fatal errors.
If this variable is not set, CMake behaves as if it were set to **FALSE**.

<a name="cmake_error_on_absolute_install_destination"></a>

### CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION


Ask **cmake\_install.cmake** script to error out as soon as a file with
absolute **INSTALL DESTINATION** is encountered.

The fatal error is emitted before the installation of the offending
file takes place.  This variable is used by CMake-generated
**cmake\_install.cmake** scripts.  If one sets this variable to **ON** while
running the script, it may get fatal error messages from the script.

<a name="cmake_execute_process_command_echo"></a>

### CMAKE_EXECUTE_PROCESS_COMMAND_ECHO


If this variable is set to **STDERR**, **STDOUT** or **NONE** then commands
in **execute\_process()** calls will be printed to either stderr or
stdout or not at all.

<a name="cmake_export_compile_commands"></a>

### CMAKE_EXPORT_COMPILE_COMMANDS


Enable/Disable output of compile commands during generation.

If enabled, generates a **compile\_commands.json** file containing the exact
compiler calls for all translation units of the project in machine-readable
form.  The format of the JSON file looks like:
.INDENT 0.0
.INDENT 3.5

    .ft C
    [
      {
        "directory": "/home/user/development/project",
        "command": "/usr/bin/c++ ... -c ../foo/foo.cc",
        "file": "../foo/foo.cc"
      },
    
      ...
    
      {
        "directory": "/home/user/development/project",
        "command": "/usr/bin/c++ ... -c ../foo/bar.cc",
        "file": "../foo/bar.cc"
      }
    ]
    .ft P
.UNINDENT
.UNINDENT

This is initialized by the **CMAKE\_EXPORT\_COMPILE\_COMMANDS** environment
variable.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This option is implemented only by Makefile Generators
and the **Ninja**.  It is ignored on other generators.

This option currently does not work well in combination with
the **UNITY\_BUILD** target property or the
**CMAKE\_UNITY\_BUILD** variable.
.UNINDENT
.UNINDENT

<a name="cmake_export_package_registry"></a>

### CMAKE_EXPORT_PACKAGE_REGISTRY


Enables the **export(PACKAGE)** command when **CMP0090**
is set to **NEW**.

The **export(PACKAGE)** command does nothing by default.  In some cases
it is desirable to write to the user package registry, so the
**CMAKE\_EXPORT\_PACKAGE\_REGISTRY** variable may be set to enable it.

If **CMP0090** is _not_ set to **NEW** this variable does nothing, and
the **CMAKE\_EXPORT\_NO\_PACKAGE\_REGISTRY** variable controls the behavior
instead.

See also Disabling the Package Registry.

<a name="cmake_export_no_package_registry"></a>

### CMAKE_EXPORT_NO_PACKAGE_REGISTRY


Disable the **export(PACKAGE)** command when **CMP0090**
is not set to **NEW**.

In some cases, for example for packaging and for system wide
installations, it is not desirable to write the user package registry.
If the **CMAKE\_EXPORT\_NO\_PACKAGE\_REGISTRY** variable is enabled,
the **export(PACKAGE)** command will do nothing.

If **CMP0090** is set to **NEW** this variable does nothing, and the
**CMAKE\_EXPORT\_PACKAGE\_REGISTRY** variable controls the behavior
instead.

See also Disabling the Package Registry.

<a name="cmake_find_appbundle"></a>

### CMAKE_FIND_APPBUNDLE


This variable affects how **find\_*** commands choose between
macOS Application Bundles and unix-style package components.

On Darwin or systems supporting macOS Application Bundles, the
**CMAKE\_FIND\_APPBUNDLE** variable can be set to empty or
one of the following:
.INDENT 0.0

* <b>**FIRST**</b>  
  Try to find application bundles before standard programs.
  This is the default on Darwin.
* <b>**LAST**</b>  
  Try to find application bundles after standard programs.
* <b>**ONLY**</b>  
  Only try to find application bundles.
* <b>**NEVER**</b>  
  Never try to find application bundles.
  .UNINDENT

<a name="cmake_find_framework"></a>

### CMAKE_FIND_FRAMEWORK


This variable affects how **find\_*** commands choose between
macOS Frameworks and unix-style package components.

On Darwin or systems supporting macOS Frameworks, the
**CMAKE\_FIND\_FRAMEWORK** variable can be set to empty or
one of the following:
.INDENT 0.0

* <b>**FIRST**</b>  
  Try to find frameworks before standard libraries or headers.
  This is the default on Darwin.
* <b>**LAST**</b>  
  Try to find frameworks after standard libraries or headers.
* <b>**ONLY**</b>  
  Only try to find frameworks.
* <b>**NEVER**</b>  
  Never try to find frameworks.
  .UNINDENT

<a name="cmake_find_library_custom_lib_suffix"></a>

### CMAKE_FIND_LIBRARY_CUSTOM_LIB_SUFFIX


Specify a **&lt;suffix&gt;** to tell the **find\_library()** command to
search in a **lib&lt;suffix&gt;** directory before each **lib** directory that
would normally be searched.

This overrides the behavior of related global properties:
.INDENT 0.0

* ·  
  **FIND\_LIBRARY\_USE\_LIB32\_PATHS**
* ·  
  **FIND\_LIBRARY\_USE\_LIB64\_PATHS**
* ·  
  **FIND\_LIBRARY\_USE\_LIBX32\_PATHS**
  .UNINDENT

<a name="cmake_find_library_prefixes"></a>

### CMAKE_FIND_LIBRARY_PREFIXES


Prefixes to prepend when looking for libraries.

This specifies what prefixes to add to library names when the
**find\_library()** command looks for libraries.  On UNIX systems this is
typically **lib**, meaning that when trying to find the **foo** library it
will look for **libfoo**.

<a name="cmake_find_library_suffixes"></a>

### CMAKE_FIND_LIBRARY_SUFFIXES


Suffixes to append when looking for libraries.

This specifies what suffixes to add to library names when the
**find\_library()** command looks for libraries.  On Windows systems this
is typically **.lib** and **.dll**, meaning that when trying to find the
**foo** library it will look for **foo.dll** etc.

<a name="cmake_find_no_install_prefix"></a>

### CMAKE_FIND_NO_INSTALL_PREFIX


Exclude the values of the **CMAKE\_INSTALL\_PREFIX** and
**CMAKE\_STAGING\_PREFIX** variables from
**CMAKE\_SYSTEM\_PREFIX\_PATH**.  CMake adds these project-destination
prefixes to **CMAKE\_SYSTEM\_PREFIX\_PATH** by default in order to
support building a series of dependent packages and installing them into
a common prefix.  Set **CMAKE\_FIND\_NO\_INSTALL\_PREFIX** to **TRUE**
to suppress this behavior.

The **CMAKE\_SYSTEM\_PREFIX\_PATH** is initialized on the first call to a
**project()** or **enable\_language()** command.  Therefore one must
set **CMAKE\_FIND\_NO\_INSTALL\_PREFIX** before this in order to take effect.  A
user may set the variable as a cache entry on the command line to achieve this.

Note that the prefix(es) may still be searched for other reasons, such as being
the same prefix as the CMake installation, or for being a built-in system
prefix.

<a name="cmake_find_package_no_package_registry"></a>

### CMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY


Deprecated since version 3.16: Use the **CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY** variable instead.


By default this variable is not set. If neither
**CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY** nor
**CMAKE\_FIND\_PACKAGE\_NO\_PACKAGE\_REGISTRY** is set, then
**find\_package()** will use the User Package Registry
unless the **NO\_CMAKE\_PACKAGE\_REGISTRY** option is provided.

**CMAKE\_FIND\_PACKAGE\_NO\_PACKAGE\_REGISTRY** is ignored if
**CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY** is set.

In some cases, for example to locate only system wide installations, it
is not desirable to use the User Package Registry when searching
for packages. If the _CMAKE\_FIND\_PACKAGE\_NO\_PACKAGE\_REGISTRY_
variable is **TRUE**, all the **find\_package()** commands will skip
the User Package Registry as if they were called with the
**NO\_CMAKE\_PACKAGE\_REGISTRY** argument.

See also Disabling the Package Registry.

<a name="cmake_find_package_no_system_package_registry"></a>

### CMAKE_FIND_PACKAGE_NO_SYSTEM_PACKAGE_REGISTRY


Deprecated since version 3.16: Use the **CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY** variable instead.


By default this variable is not set. If neither
**CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY** nor
**CMAKE\_FIND\_PACKAGE\_NO\_SYSTEM\_PACKAGE\_REGISTRY** is set, then
**find\_package()** will use the System Package Registry
unless the **NO\_CMAKE\_SYSTEM\_PACKAGE\_REGISTRY** option is provided.

**CMAKE\_FIND\_PACKAGE\_NO\_SYSTEM\_PACKAGE\_REGISTRY** is ignored if
**CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY** is set.

In some cases, it is not desirable to use the
System Package Registry when searching for packages. If the
_CMAKE\_FIND\_PACKAGE\_NO\_SYSTEM\_PACKAGE\_REGISTRY_ variable is
**TRUE**, all the **find\_package()** commands will skip
the System Package Registry as if they were called with the
**NO\_CMAKE\_SYSTEM\_PACKAGE\_REGISTRY** argument.

See also Disabling the Package Registry.

<a name="cmake_find_package_prefer_config"></a>

### CMAKE_FIND_PACKAGE_PREFER_CONFIG


Tell **find\_package()** to try “Config” mode before “Module” mode if no
mode was specified.

The command **find\_package()** operates without an explicit mode when
the reduced signature is used without the **MODULE** option. In this case,
by default, CMake first tries Module mode by searching for a
**Find&lt;pkg&gt;.cmake** module.  If it fails, CMake then searches for the package
using Config mode.

Set **CMAKE\_FIND\_PACKAGE\_PREFER\_CONFIG** to **TRUE** to tell
**find\_package()** to first search using Config mode before falling back
to Module mode.

This variable may be useful when a developer has compiled a custom version of
a common library and wishes to link it to a dependent project.  If this
variable is set to **TRUE**, it would prevent a dependent project’s call
to **find\_package()** from selecting the default library located by the
system’s **Find&lt;pkg&gt;.cmake** module before finding the developer’s custom
built library.

Once this variable is set, it is the responsibility of the exported
**&lt;pkg&gt;Config.cmake** files to provide the same result variables as the
**Find&lt;pkg&gt;.cmake** modules so that dependent projects can use them
interchangeably.

<a name="cmake_find_package_resolve_symlinks"></a>

### CMAKE_FIND_PACKAGE_RESOLVE_SYMLINKS


Set to **TRUE** to tell **find\_package()** calls to resolve symbolic
links in the value of **&lt;PackageName&gt;\_DIR**.

This is helpful in use cases where the package search path points at a
proxy directory in which symlinks to the real package locations appear.
This is not enabled by default because there are also common use cases
in which the symlinks should be preserved.

<a name="cmake_find_package_warn_no_module"></a>

### CMAKE_FIND_PACKAGE_WARN_NO_MODULE


Tell **find\_package()** to warn if called without an explicit mode.

If **find\_package()** is called without an explicit mode option
(**MODULE**, **CONFIG**, or **NO\_MODULE**) and no **Find&lt;pkg&gt;.cmake** module
is in **CMAKE\_MODULE\_PATH** then CMake implicitly assumes that the
caller intends to search for a package configuration file.  If no package
configuration file is found then the wording of the failure message
must account for both the case that the package is really missing and
the case that the project has a bug and failed to provide the intended
Find module.  If instead the caller specifies an explicit mode option
then the failure message can be more specific.

Set **CMAKE\_FIND\_PACKAGE\_WARN\_NO\_MODULE** to **TRUE** to tell
**find\_package()** to warn when it implicitly assumes Config mode.  This
helps developers enforce use of an explicit mode in all calls to
**find\_package()** within a project.

This variable has no effect if **CMAKE\_FIND\_PACKAGE\_PREFER\_CONFIG** is
set to **TRUE**.

<a name="cmake_find_root_path"></a>

### CMAKE_FIND_ROOT_PATH


Semicolon-separated list of root paths to search on the filesystem.

This variable is most useful when cross-compiling. CMake uses the paths in
this list as alternative roots to find filesystem items with
**find\_package()**, **find\_library()** etc.

<a name="cmake_find_root_path_mode_include"></a>

### CMAKE_FIND_ROOT_PATH_MODE_INCLUDE


This variable controls whether the **CMAKE\_FIND\_ROOT\_PATH** and
**CMAKE\_SYSROOT** are used by **find\_file()** and **find\_path()**.

If set to **ONLY**, then only the roots in **CMAKE\_FIND\_ROOT\_PATH**
will be searched. If set to **NEVER**, then the roots in
**CMAKE\_FIND\_ROOT\_PATH** will be ignored and only the host system
root will be used. If set to **BOTH**, then the host system paths and the
paths in **CMAKE\_FIND\_ROOT\_PATH** will be searched.

<a name="cmake_find_root_path_mode_library"></a>

### CMAKE_FIND_ROOT_PATH_MODE_LIBRARY


This variable controls whether the **CMAKE\_FIND\_ROOT\_PATH** and
**CMAKE\_SYSROOT** are used by **find\_library()**.

If set to **ONLY**, then only the roots in **CMAKE\_FIND\_ROOT\_PATH**
will be searched. If set to **NEVER**, then the roots in
**CMAKE\_FIND\_ROOT\_PATH** will be ignored and only the host system
root will be used. If set to **BOTH**, then the host system paths and the
paths in **CMAKE\_FIND\_ROOT\_PATH** will be searched.

<a name="cmake_find_root_path_mode_package"></a>

### CMAKE_FIND_ROOT_PATH_MODE_PACKAGE


This variable controls whether the **CMAKE\_FIND\_ROOT\_PATH** and
**CMAKE\_SYSROOT** are used by **find\_package()**.

If set to **ONLY**, then only the roots in **CMAKE\_FIND\_ROOT\_PATH**
will be searched. If set to **NEVER**, then the roots in
**CMAKE\_FIND\_ROOT\_PATH** will be ignored and only the host system
root will be used. If set to **BOTH**, then the host system paths and the
paths in **CMAKE\_FIND\_ROOT\_PATH** will be searched.

<a name="cmake_find_root_path_mode_program"></a>

### CMAKE_FIND_ROOT_PATH_MODE_PROGRAM


This variable controls whether the **CMAKE\_FIND\_ROOT\_PATH** and
**CMAKE\_SYSROOT** are used by **find\_program()**.

If set to **ONLY**, then only the roots in **CMAKE\_FIND\_ROOT\_PATH**
will be searched. If set to **NEVER**, then the roots in
**CMAKE\_FIND\_ROOT\_PATH** will be ignored and only the host system
root will be used. If set to **BOTH**, then the host system paths and the
paths in **CMAKE\_FIND\_ROOT\_PATH** will be searched.

<a name="cmake_find_use_cmake_environment_path"></a>

### CMAKE_FIND_USE_CMAKE_ENVIRONMENT_PATH


Controls the default behavior of the following commands for whether or not to
search paths provided by cmake-specific environment variables:
.INDENT 0.0

* ·  
  **find\_program()**
* ·  
  **find\_library()**
* ·  
  **find\_file()**
* ·  
  **find\_path()**
* ·  
  **find\_package()**
  .UNINDENT

This is useful in cross-compiling environments.

By default this variable is not set, which is equivalent to it having
a value of **TRUE**.  Explicit options given to the above commands
take precedence over this variable.

See also the **CMAKE\_FIND\_USE\_CMAKE\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY**,
**CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY**,
and **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** variables.

<a name="cmake_find_use_cmake_path"></a>

### CMAKE_FIND_USE_CMAKE_PATH


Controls the default behavior of the following commands for whether or not to
search paths provided by cmake-specific cache variables:
.INDENT 0.0

* ·  
  **find\_program()**
* ·  
  **find\_library()**
* ·  
  **find\_file()**
* ·  
  **find\_path()**
* ·  
  **find\_package()**
  .UNINDENT

This is useful in cross-compiling environments.

By default this variable is not set, which is equivalent to it having
a value of **TRUE**.  Explicit options given to the above commands
take precedence over this variable.

See also the **CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY**,
**CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY**,
and **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** variables.

<a name="cmake_find_use_cmake_system_path"></a>

### CMAKE_FIND_USE_CMAKE_SYSTEM_PATH


Controls the default behavior of the following commands for whether or not to
search paths provided by platform-specific cmake variables:
.INDENT 0.0

* ·  
  **find\_program()**
* ·  
  **find\_library()**
* ·  
  **find\_file()**
* ·  
  **find\_path()**
* ·  
  **find\_package()**
  .UNINDENT

This is useful in cross-compiling environments.

By default this variable is not set, which is equivalent to it having
a value of **TRUE**.  Explicit options given to the above commands
take precedence over this variable.

See also the **CMAKE\_FIND\_USE\_CMAKE\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY**,
**CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY**,
and **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** variables.

<a name="cmake_find_use_package_registry"></a>

### CMAKE_FIND_USE_PACKAGE_REGISTRY


Controls the default behavior of the **find\_package()** command for
whether or not to search paths provided by the User Package Registry.

By default this variable is not set and the behavior will fall back
to that determined by the deprecated
**CMAKE\_FIND\_PACKAGE\_NO\_PACKAGE\_REGISTRY** variable.  If that is
also not set, then **find\_package()** will use the
User Package Registry unless the **NO\_CMAKE\_PACKAGE\_REGISTRY** option
is provided.

This variable takes precedence over
**CMAKE\_FIND\_PACKAGE\_NO\_PACKAGE\_REGISTRY** when both are set.

In some cases, for example to locate only system wide installations, it
is not desirable to use the User Package Registry when searching
for packages.  If the _CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY_
variable is **FALSE**, all the **find\_package()** commands will skip
the User Package Registry as if they were called with the
**NO\_CMAKE\_PACKAGE\_REGISTRY** argument.

See also Disabling the Package Registry and the
**CMAKE\_FIND\_USE\_CMAKE\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY**,
and **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** variables.

<a name="cmake_find_use_package_root_path"></a>

### CMAKE_FIND_USE_PACKAGE_ROOT_PATH


Controls the default behavior of the following commands for whether or not to
search paths provided by **&lt;PackageName&gt;\_ROOT** variables:
.INDENT 0.0

* ·  
  **find\_program()**
* ·  
  **find\_library()**
* ·  
  **find\_file()**
* ·  
  **find\_path()**
* ·  
  **find\_package()**
  .UNINDENT

By default this variable is not set, which is equivalent to it having
a value of **TRUE**.  Explicit options given to the above commands
take precedence over this variable.

See also the **CMAKE\_FIND\_USE\_CMAKE\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY**,
and **CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY** variables.

<a name="cmake_find_use_system_environment_path"></a>

### CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH


Controls the default behavior of the following commands for whether or not to
search paths provided by standard system environment variables:
.INDENT 0.0

* ·  
  **find\_program()**
* ·  
  **find\_library()**
* ·  
  **find\_file()**
* ·  
  **find\_path()**
* ·  
  **find\_package()**
  .UNINDENT

This is useful in cross-compiling environments.

By default this variable is not set, which is equivalent to it having
a value of **TRUE**.  Explicit options given to the above commands
take precedence over this variable.

See also the **CMAKE\_FIND\_USE\_CMAKE\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**,
**CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY**,
**CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH**,
and **CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY** variables.

<a name="cmake_find_use_system_package_registry"></a>

### CMAKE_FIND_USE_SYSTEM_PACKAGE_REGISTRY


Controls searching the System Package Registry by the
**find\_package()** command.

By default this variable is not set and the behavior will fall back
to that determined by the deprecated
**CMAKE\_FIND\_PACKAGE\_NO\_SYSTEM\_PACKAGE\_REGISTRY** variable.
If that is also not set, then **find\_package()** will use the
System Package Registry unless the **NO\_CMAKE\_SYSTEM\_PACKAGE\_REGISTRY**
option is provided.

This variable takes precedence over
**CMAKE\_FIND\_PACKAGE\_NO\_SYSTEM\_PACKAGE\_REGISTRY** when both are set.

In some cases, for example to locate only user specific installations, it
is not desirable to use the System Package Registry when searching
for packages. If the **CMAKE\_FIND\_USE\_SYSTEM\_PACKAGE\_REGISTRY**
variable is **FALSE**, all the **find\_package()** commands will skip
the System Package Registry as if they were called with the
**NO\_CMAKE\_SYSTEM\_PACKAGE\_REGISTRY** argument.

See also Disabling the Package Registry.

See also the **CMAKE\_FIND\_USE\_CMAKE\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_CMAKE\_SYSTEM\_PATH**,
**CMAKE\_FIND\_USE\_SYSTEM\_ENVIRONMENT\_PATH**,
**CMAKE\_FIND\_USE\_PACKAGE\_REGISTRY**,
and **CMAKE\_FIND\_USE\_PACKAGE\_ROOT\_PATH** variables.

<a name="cmake_framework_path"></a>

### CMAKE_FRAMEWORK_PATH


Semicolon-separated list of directories specifying a search path
for macOS frameworks used by the **find\_library()**,
**find\_package()**, **find\_path()**, and **find\_file()**
commands.

<a name="cmake_ignore_path"></a>

### CMAKE_IGNORE_PATH


Semicolon-separated list of directories to be _ignored_ by
the **find\_program()**, **find\_library()**, **find\_file()**,
and **find\_path()** commands.  This is useful in cross-compiling
environments where some system directories contain incompatible but
possibly linkable libraries.  For example, on cross-compiled cluster
environments, this allows a user to ignore directories containing
libraries meant for the front-end machine.

By default this is empty; it is intended to be set by the project.
Note that **CMAKE\_IGNORE\_PATH** takes a list of directory names, _not_
a list of prefixes.  To ignore paths under prefixes (**bin**, **include**,
**lib**, etc.), specify them explicitly.

See also the **CMAKE\_PREFIX\_PATH**, **CMAKE\_LIBRARY\_PATH**,
**CMAKE\_INCLUDE\_PATH**, and **CMAKE\_PROGRAM\_PATH** variables.

<a name="cmake_include_directories_before"></a>

### CMAKE_INCLUDE_DIRECTORIES_BEFORE


Whether to append or prepend directories by default in
**include\_directories()**.

This variable affects the default behavior of the **include\_directories()**
command.  Setting this variable to **ON** is equivalent to using the **BEFORE**
option in all uses of that command.

<a name="cmake_include_directories_project_before"></a>

### CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE


Whether to force prepending of project include directories.

This variable affects the order of include directories generated in compiler
command lines.  If set to **ON**, it causes the **CMAKE\_SOURCE\_DIR**
and the **CMAKE\_BINARY\_DIR** to appear first.

<a name="cmake_include_path"></a>

### CMAKE_INCLUDE_PATH


Semicolon-separated list of directories specifying a search path
for the **find\_file()** and **find\_path()** commands.  By default it
is empty, it is intended to be set by the project.  See also
**CMAKE\_SYSTEM\_INCLUDE\_PATH** and **CMAKE\_PREFIX\_PATH**.

<a name="cmake_install_default_component_name"></a>

### CMAKE_INSTALL_DEFAULT_COMPONENT_NAME


Default component used in **install()** commands.

If an **install()** command is used without the **COMPONENT** argument,
these files will be grouped into a default component.  The name of this
default install component will be taken from this variable.  It
defaults to **Unspecified**.

<a name="cmake_install_default_directory_permissions"></a>

### CMAKE_INSTALL_DEFAULT_DIRECTORY_PERMISSIONS


Default permissions for directories created implicitly during installation
of files by **install()** and **file(INSTALL)**.

If **make install** is invoked and directories are implicitly created they
get permissions set by _CMAKE\_INSTALL\_DEFAULT\_DIRECTORY\_PERMISSIONS_
variable or platform specific default permissions if the variable is not set.

Implicitly created directories are created if they are not explicitly installed
by **install()** command but are needed to install a file on a certain
path. Example of such locations are directories created due to the setting of
**CMAKE\_INSTALL\_PREFIX**.

Expected content of the _CMAKE\_INSTALL\_DEFAULT\_DIRECTORY\_PERMISSIONS_
variable is a list of permissions that can be used by **install()** command
_PERMISSIONS_ section.

Example usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_INSTALL_DEFAULT_DIRECTORY_PERMISSIONS
         OWNER_READ
         OWNER_WRITE
         OWNER_EXECUTE
         GROUP_READ
       )
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_install_message"></a>

### CMAKE_INSTALL_MESSAGE


Specify verbosity of installation script code generated by the
**install()** command (using the **file(INSTALL)** command).
For paths that are newly installed or updated, installation
may print lines like:
.INDENT 0.0
.INDENT 3.5

    .ft C
    -- Installing: /some/destination/path
    .ft P
.UNINDENT
.UNINDENT

For paths that are already up to date, installation may print
lines like:
.INDENT 0.0
.INDENT 3.5

    .ft C
    -- Up-to-date: /some/destination/path
    .ft P
.UNINDENT
.UNINDENT

The **CMAKE\_INSTALL\_MESSAGE** variable may be set to control
which messages are printed:
.INDENT 0.0

* <b>**ALWAYS**</b>  
  Print both **Installing** and **Up-to-date** messages.
* <b>**LAZY**</b>  
  Print **Installing** but not **Up-to-date** messages.
* <b>**NEVER**</b>  
  Print neither **Installing** nor **Up-to-date** messages.
  .UNINDENT

Other values have undefined behavior and may not be diagnosed.

If this variable is not set, the default behavior is **ALWAYS**.

<a name="cmake_install_prefix"></a>

### CMAKE_INSTALL_PREFIX


Install directory used by **install()**.

If **make install** is invoked or **INSTALL** is built, this directory is
prepended onto all install directories.  This variable defaults to
**/usr/local** on UNIX and **c:/Program Files/${PROJECT\_NAME}** on Windows.
See **CMAKE\_INSTALL\_PREFIX\_INITIALIZED\_TO\_DEFAULT** for how a
project might choose its own default.

On UNIX one can use the **DESTDIR** mechanism in order to relocate the
whole installation. See **DESTDIR** for more information.

The installation prefix is also added to **CMAKE\_SYSTEM\_PREFIX\_PATH**
so that **find\_package()**, **find\_program()**,
**find\_library()**, **find\_path()**, and **find\_file()**
will search the prefix for other software.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Use the **GNUInstallDirs** module to provide GNU-style
options for the layout of directories within the installation.
.UNINDENT
.UNINDENT

<a name="cmake_install_prefix_initialized_to_default"></a>

### CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT


CMake sets this variable to a **TRUE** value when the
**CMAKE\_INSTALL\_PREFIX** has just been initialized to
its default value, typically on the first run of CMake within
a new build tree.  This can be used by project code to change
the default without overriding a user-provided value:
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
      set(CMAKE_INSTALL_PREFIX "/my/default" CACHE PATH "..." FORCE)
    endif()
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_library_path"></a>

### CMAKE_LIBRARY_PATH


Semicolon-separated list of directories specifying a search path
for the **find\_library()** command.  By default it is empty, it is
intended to be set by the project.  See also
**CMAKE\_SYSTEM\_LIBRARY\_PATH** and **CMAKE\_PREFIX\_PATH**.

<a name="cmake_link_directories_before"></a>

### CMAKE_LINK_DIRECTORIES_BEFORE


Whether to append or prepend directories by default in
**link\_directories()**.

This variable affects the default behavior of the **link\_directories()**
command.  Setting this variable to **ON** is equivalent to using the **BEFORE**
option in all uses of that command.

<a name="cmake_mfc_flag"></a>

### CMAKE_MFC_FLAG


Use the MFC library for an executable or dll.

Enables the use of the Microsoft Foundation Classes (MFC).
It should be set to **1** for the static MFC library, and
**2** for the shared MFC library.  This is used in Visual Studio
project files.

Usage example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_definitions(-D_AFXDLL)
    set(CMAKE_MFC_FLAG 2)
    add_executable(CMakeSetup WIN32 ${SRCS})
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_maximum_recursion_depth"></a>

### CMAKE_MAXIMUM_RECURSION_DEPTH


Maximum recursion depth for CMake scripts. It is intended to be set on the
command line with **-DCMAKE\_MAXIMUM\_RECURSION\_DEPTH=&lt;x&gt;**, or within
**CMakeLists.txt** by projects that require a large recursion depth. Projects
that set this variable should provide the user with a way to override it. For
example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # About to perform deeply recursive actions
    if(NOT CMAKE_MAXIMUM_RECURSION_DEPTH)
      set(CMAKE_MAXIMUM_RECURSION_DEPTH 2000)
    endif()
    .ft P
.UNINDENT
.UNINDENT

If it is not set, or is set to a non-integer value, a sensible default limit is
used. If the recursion limit is reached, the script terminates immediately with
a fatal error.

Calling any of the following commands increases the recursion depth:
.INDENT 0.0

* ·  
  **include()**
* ·  
  **find\_package()**
* ·  
  **add\_subdirectory()**
* ·  
  **try\_compile()**
* ·  
  **ctest\_read\_custom\_files()**
* ·  
  **ctest\_run\_script()** (unless **NEW\_PROCESS** is specified)
* ·  
  User-defined **function()**’s and **macro()**’s (note that
  **function()** and **macro()** themselves don’t increase recursion
  depth)
* ·  
  Reading or writing variables that are being watched by a
  **variable\_watch()**
  .UNINDENT

<a name="cmake_message_context"></a>

### CMAKE_MESSAGE_CONTEXT


When enabled by the **cmake** **--log-context** command line
option or the **CMAKE\_MESSAGE\_CONTEXT\_SHOW** variable, the
**message()** command converts the **CMAKE\_MESSAGE\_CONTEXT** list into a
dot-separated string surrounded by square brackets and prepends it to each line
for messages of log levels **NOTICE** and below.

For logging contexts to work effectively, projects should generally
**APPEND** and **POP\_BACK** an item to the current value of
**CMAKE\_MESSAGE\_CONTEXT** rather than replace it.
Projects should not assume the message context at the top of the source tree
is empty, as there are scenarios where the context might have already been set
(e.g. hierarchical projects).

**WARNING:**
.INDENT 0.0
.INDENT 3.5
Valid context names are restricted to anything that could be used
as a CMake variable name.  All names that begin with an underscore
or the string **cmake\_** are also reserved for use by CMake and
should not be used by projects.
.UNINDENT
.UNINDENT

Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    function(bar)
      list(APPEND CMAKE_MESSAGE_CONTEXT "bar")
      message(VERBOSE "bar VERBOSE message")
    endfunction()
    
    function(baz)
      list(APPEND CMAKE_MESSAGE_CONTEXT "baz")
      message(DEBUG "baz DEBUG message")
    endfunction()
    
    function(foo)
      list(APPEND CMAKE_MESSAGE_CONTEXT "foo")
      bar()
      message(TRACE "foo TRACE message")
      baz()
    endfunction()
    
    list(APPEND CMAKE_MESSAGE_CONTEXT "top")
    
    message(VERBOSE "Before `foo`")
    foo()
    message(VERBOSE "After `foo`")
    
    list(POP_BACK CMAKE_MESSAGE_CONTEXT)
    .ft P
.UNINDENT
.UNINDENT

Which results in the following output:
.INDENT 0.0
.INDENT 3.5

    .ft C
    -- [top] Before `foo`
    -- [top.foo.bar] bar VERBOSE message
    -- [top.foo] foo TRACE message
    -- [top.foo.baz] baz DEBUG message
    -- [top] After `foo`
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_message_context_show"></a>

### CMAKE_MESSAGE_CONTEXT_SHOW


Setting this variable to true enables showing a context with each line
logged by the **message()** command (see **CMAKE\_MESSAGE\_CONTEXT**
for how the context itself is specified).

This variable is an alternative to providing the **--log-context** option
on the **cmake** command line.  Whereas the command line
option will apply only to that one CMake run, setting
**CMAKE\_MESSAGE\_CONTEXT\_SHOW** to true as a cache variable will ensure that
subsequent CMake runs will continue to show the message context.

Projects should not set **CMAKE\_MESSAGE\_CONTEXT\_SHOW**.  It is intended for
users so that they may control whether or not to include context with messages.

<a name="cmake_message_indent"></a>

### CMAKE_MESSAGE_INDENT


The **message()** command joins the strings from this list and for
log levels of **NOTICE** and below, it prepends the resultant string to
each line of the message.

Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    list(APPEND listVar one two three)
    
    message(VERBOSE [[Collected items in the "listVar":]])
    list(APPEND CMAKE_MESSAGE_INDENT "  ")
    
    foreach(item IN LISTS listVar)
      message(VERBOSE ${item})
    endforeach()
    
    list(POP_BACK CMAKE_MESSAGE_INDENT)
    message(VERBOSE "No more indent")
    .ft P
.UNINDENT
.UNINDENT

Which results in the following output:
.INDENT 0.0
.INDENT 3.5

    .ft C
    -- Collected items in the "listVar":
    --   one
    --   two
    --   three
    -- No more indent
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_message_log_level"></a>

### CMAKE_MESSAGE_LOG_LEVEL


When set, this variable specifies the logging level used by the
**message()** command.  Valid values are the same as those for the
**--log-level** command line option of the **cmake(1)** program.
If this variable is set and the **--log-level** command line option is
given, the command line option takes precedence.

The main advantage to using this variable is to make a log level persist
between CMake runs.  Setting it as a cache variable will ensure that
subsequent CMake runs will continue to use the chosen log level.

Projects should not set this variable, it is intended for users so that
they may control the log level according to their own needs.

<a name="cmake_module_path"></a>

### CMAKE_MODULE_PATH


Semicolon-separated list of directories specifying a search path
for CMake modules to be loaded by the **include()** or
**find\_package()** commands before checking the default modules that come
with CMake.  By default it is empty, it is intended to be set by the project.

<a name="cmake_policy_default_cmpltnnnngt"></a>

### CMAKE_POLICY_DEFAULT_CMP&lt;NNNN&gt;


Default for CMake Policy **CMP&lt;NNNN&gt;** when it is otherwise left unset.

Commands **cmake\_minimum\_required(VERSION)** and
**cmake\_policy(VERSION)** by default leave policies introduced after
the given version unset.  Set **CMAKE\_POLICY\_DEFAULT\_CMP&lt;NNNN&gt;** to **OLD**
or **NEW** to specify the default for policy **CMP&lt;NNNN&gt;**, where **&lt;NNNN&gt;**
is the policy number.

This variable should not be set by a project in CMake code; use
**cmake\_policy(SET)** instead.  Users running CMake may set this
variable in the cache (e.g. **-DCMAKE\_POLICY\_DEFAULT\_CMP&lt;NNNN&gt;=&lt;OLD|NEW&gt;**)
to set a policy not otherwise set by the project.  Set to **OLD** to quiet a
policy warning while using old behavior or to **NEW** to try building the
project with new behavior.

<a name="cmake_policy_warning_cmpltnnnngt"></a>

### CMAKE_POLICY_WARNING_CMP&lt;NNNN&gt;


Explicitly enable or disable the warning when CMake Policy **CMP&lt;NNNN&gt;**
is not set.  This is meaningful only for the few policies that do not
warn by default:
.INDENT 0.0

* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0025** controls the warning for
  policy **CMP0025**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0047** controls the warning for
  policy **CMP0047**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0056** controls the warning for
  policy **CMP0056**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0060** controls the warning for
  policy **CMP0060**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0065** controls the warning for
  policy **CMP0065**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0066** controls the warning for
  policy **CMP0066**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0067** controls the warning for
  policy **CMP0067**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0082** controls the warning for
  policy **CMP0082**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0089** controls the warning for
  policy **CMP0089**.
* ·  
  **CMAKE\_POLICY\_WARNING\_CMP0102** controls the warning for
  policy **CMP0102**.
  .UNINDENT

This variable should not be set by a project in CMake code.  Project
developers running CMake may set this variable in their cache to
enable the warning (e.g. **-DCMAKE\_POLICY\_WARNING\_CMP&lt;NNNN&gt;=ON**).
Alternatively, running **cmake(1)** with the **--debug-output**,
**--trace**, or **--trace-expand** option will also enable the warning.

<a name="cmake_prefix_path"></a>

### CMAKE_PREFIX_PATH


Semicolon-separated list of directories specifying installation
_prefixes_ to be searched by the **find\_package()**,
**find\_program()**, **find\_library()**, **find\_file()**, and
**find\_path()** commands.  Each command will add appropriate
subdirectories (like **bin**, **lib**, or **include**) as specified in its own
documentation.

By default this is empty.  It is intended to be set by the project.

See also **CMAKE\_SYSTEM\_PREFIX\_PATH**, **CMAKE\_INCLUDE\_PATH**,
**CMAKE\_LIBRARY\_PATH**, **CMAKE\_PROGRAM\_PATH**, and
**CMAKE\_IGNORE\_PATH**.

<a name="cmake_program_path"></a>

### CMAKE_PROGRAM_PATH


Semicolon-separated list of directories specifying a search path
for the **find\_program()** command.  By default it is empty, it is
intended to be set by the project.  See also
**CMAKE\_SYSTEM\_PROGRAM\_PATH** and **CMAKE\_PREFIX\_PATH**.

<a name="cmake_project_include"></a>

### CMAKE_PROJECT_INCLUDE


A CMake language file or module to be included as the last step of all
**project()** command calls.  This is intended for injecting custom code
into project builds without modifying their source.

See also the **CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE**,
**CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE\_BEFORE** and
**CMAKE\_PROJECT\_INCLUDE\_BEFORE** variables.

<a name="cmake_project_include_before"></a>

### CMAKE_PROJECT_INCLUDE_BEFORE


A CMake language file or module to be included as the first step of all
**project()** command calls.  This is intended for injecting custom code
into project builds without modifying their source.

See also the **CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE**,
**CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE\_BEFORE** and
**CMAKE\_PROJECT\_INCLUDE** variables.

<a name="cmake_project_ltproject-namegt_include"></a>

### CMAKE_PROJECT_&lt;PROJECT\-NAME&gt;_INCLUDE


A CMake language file or module to be included as the last step of any
**project()** command calls that specify **&lt;PROJECT-NAME&gt;** as the project
name.  This is intended for injecting custom code into project builds without
modifying their source.

See also the **CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE\_BEFORE**,
**CMAKE\_PROJECT\_INCLUDE** and
**CMAKE\_PROJECT\_INCLUDE\_BEFORE** variables.

<a name="cmake_project_ltproject-namegt_include_before"></a>

### CMAKE_PROJECT_&lt;PROJECT\-NAME&gt;_INCLUDE_BEFORE


A CMake language file or module to be included as the first step of any
**project()** command calls that specify **&lt;PROJECT-NAME&gt;** as the project
name.  This is intended for injecting custom code into project builds without
modifying their source.

See also the **CMAKE\_PROJECT\_&lt;PROJECT-NAME&gt;\_INCLUDE**,
**CMAKE\_PROJECT\_INCLUDE** and
**CMAKE\_PROJECT\_INCLUDE\_BEFORE** variables.

<a name="cmake_skip_install_all_dependency"></a>

### CMAKE_SKIP_INSTALL_ALL_DEPENDENCY


Don’t make the **install** target depend on the **all** target.

By default, the **install** target depends on the **all** target.  This
has the effect, that when **make install** is invoked or **INSTALL** is
built, first the **all** target is built, then the installation starts.
If _CMAKE\_SKIP\_INSTALL\_ALL\_DEPENDENCY_ is set to **TRUE**, this
dependency is not created, so the installation process will start immediately,
independent from whether the project has been completely built or not.

<a name="cmake_staging_prefix"></a>

### CMAKE_STAGING_PREFIX


This variable may be set to a path to install to when cross-compiling. This can
be useful if the path in **CMAKE\_SYSROOT** is read-only, or otherwise
should remain pristine.

The _CMAKE\_STAGING\_PREFIX_ location is also used as a search prefix
by the **find\_*** commands. This can be controlled by setting the
**CMAKE\_FIND\_NO\_INSTALL\_PREFIX** variable.

If any **RPATH**/**RUNPATH** entries passed to the linker contain the
_CMAKE\_STAGING\_PREFIX_, the matching path fragments are replaced
with the **CMAKE\_INSTALL\_PREFIX**.

<a name="cmake_sublime_text_2_env_settings"></a>

### CMAKE_SUBLIME_TEXT_2_ENV_SETTINGS


This variable contains a list of env vars as a list of tokens with the
syntax **var=value**.

Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SUBLIME_TEXT_2_ENV_SETTINGS
       "FOO=FOO1e;FOO2e;FOON"
       "BAR=BAR1e;BAR2e;BARN"
       "BAZ=BAZ1e;BAZ2e;BAZN"
       "FOOBAR=FOOBAR1e;FOOBAR2e;FOOBARN"
       "VALID="
       )
    .ft P
.UNINDENT
.UNINDENT

In case of malformed variables CMake will fail:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SUBLIME_TEXT_2_ENV_SETTINGS
        "THIS_IS_NOT_VALID"
        )
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_sublime_text_2_exclude_build_tree"></a>

### CMAKE_SUBLIME_TEXT_2_EXCLUDE_BUILD_TREE


If this variable evaluates to **ON** at the end of the top-level
**CMakeLists.txt** file, the **Sublime Text 2** extra generator
excludes the build tree from the **.sublime-project** if it is inside the
source tree.

<a name="cmake_suppress_regeneration"></a>

### CMAKE_SUPPRESS_REGENERATION


If **CMAKE\_SUPPRESS\_REGENERATION** is **OFF**, which is default, then CMake
adds a special target on which all other targets depend that checks the build
system and optionally re-runs CMake to regenerate the build system when
the target specification source changes.

If this variable evaluates to **ON** at the end of the top-level
**CMakeLists.txt** file, CMake will not add the regeneration target to the
build system or perform any build system checks.

<a name="cmake_sysroot"></a>

### CMAKE_SYSROOT


Path to pass to the compiler in the **--sysroot** flag.

The **CMAKE\_SYSROOT** content is passed to the compiler in the **--sysroot**
flag, if supported.  The path is also stripped from the **RPATH**/**RUNPATH**
if necessary on installation.  The **CMAKE\_SYSROOT** is also used to prefix
paths searched by the **find\_*** commands.

This variable may only be set in a toolchain file specified by
the **CMAKE\_TOOLCHAIN\_FILE** variable.

See also the **CMAKE\_SYSROOT\_COMPILE** and
**CMAKE\_SYSROOT\_LINK** variables.

<a name="cmake_sysroot_compile"></a>

### CMAKE_SYSROOT_COMPILE


Path to pass to the compiler in the **--sysroot** flag when compiling source
files.  This is the same as **CMAKE\_SYSROOT** but is used only for
compiling sources and not linking.

This variable may only be set in a toolchain file specified by
the **CMAKE\_TOOLCHAIN\_FILE** variable.

<a name="cmake_sysroot_link"></a>

### CMAKE_SYSROOT_LINK


Path to pass to the compiler in the **--sysroot** flag when linking.  This is
the same as **CMAKE\_SYSROOT** but is used only for linking and not
compiling sources.

This variable may only be set in a toolchain file specified by
the **CMAKE\_TOOLCHAIN\_FILE** variable.

<a name="cmake_system_appbundle_path"></a>

### CMAKE_SYSTEM_APPBUNDLE_PATH


Search path for macOS application bundles used by the **find\_program()**,
and **find\_package()** commands.  By default it contains the standard
directories for the current system.  It is _not_ intended to be modified by
the project, use **CMAKE\_APPBUNDLE\_PATH** for this.

<a name="cmake_system_framework_path"></a>

### CMAKE_SYSTEM_FRAMEWORK_PATH


Search path for macOS frameworks used by the **find\_library()**,
**find\_package()**, **find\_path()**, and **find\_file()**
commands.  By default it contains the standard directories for the
current system.  It is _not_ intended to be modified by the project,
use **CMAKE\_FRAMEWORK\_PATH** for this.

<a name="cmake_system_ignore_path"></a>

### CMAKE_SYSTEM_IGNORE_PATH


Semicolon-separated list of directories to be _ignored_ by
the **find\_program()**, **find\_library()**, **find\_file()**,
and **find\_path()** commands.  This is useful in cross-compiling
environments where some system directories contain incompatible but
possibly linkable libraries.  For example, on cross-compiled cluster
environments, this allows a user to ignore directories containing
libraries meant for the front-end machine.

By default this contains a list of directories containing incompatible
binaries for the host system.  See the **CMAKE\_IGNORE\_PATH** variable
that is intended to be set by the project.

See also the **CMAKE\_SYSTEM\_PREFIX\_PATH**,
**CMAKE\_SYSTEM\_LIBRARY\_PATH**, **CMAKE\_SYSTEM\_INCLUDE\_PATH**,
and **CMAKE\_SYSTEM\_PROGRAM\_PATH** variables.

<a name="cmake_system_include_path"></a>

### CMAKE_SYSTEM_INCLUDE_PATH


Semicolon-separated list of directories specifying a search path
for the **find\_file()** and **find\_path()** commands.  By default
this contains the standard directories for the current system.  It is _not_
intended to be modified by the project; use **CMAKE\_INCLUDE\_PATH** for
this.  See also **CMAKE\_SYSTEM\_PREFIX\_PATH**.

<a name="cmake_system_library_path"></a>

### CMAKE_SYSTEM_LIBRARY_PATH


Semicolon-separated list of directories specifying a search path
for the **find\_library()** command.  By default this contains the
standard directories for the current system.  It is _not_ intended to be
modified by the project; use **CMAKE\_LIBRARY\_PATH** for this.
See also **CMAKE\_SYSTEM\_PREFIX\_PATH**.

<a name="cmake_system_prefix_path"></a>

### CMAKE_SYSTEM_PREFIX_PATH


Semicolon-separated list of directories specifying installation
_prefixes_ to be searched by the **find\_package()**,
**find\_program()**, **find\_library()**, **find\_file()**, and
**find\_path()** commands.  Each command will add appropriate
subdirectories (like **bin**, **lib**, or **include**) as specified in its own
documentation.

By default this contains the standard directories for the current system, the
**CMAKE\_INSTALL\_PREFIX**, and the **CMAKE\_STAGING\_PREFIX**.
The installation and staging prefixes may be excluded by setting
the **CMAKE\_FIND\_NO\_INSTALL\_PREFIX** variable.

**CMAKE\_SYSTEM\_PREFIX\_PATH** is _not_ intended to be modified by the project;
use **CMAKE\_PREFIX\_PATH** for this.

See also **CMAKE\_SYSTEM\_INCLUDE\_PATH**,
**CMAKE\_SYSTEM\_LIBRARY\_PATH**, **CMAKE\_SYSTEM\_PROGRAM\_PATH**,
and **CMAKE\_SYSTEM\_IGNORE\_PATH**.

<a name="cmake_system_program_path"></a>

### CMAKE_SYSTEM_PROGRAM_PATH


Semicolon-separated list of directories specifying a search path
for the **find\_program()** command.  By default this contains the
standard directories for the current system.  It is _not_ intended to be
modified by the project; use **CMAKE\_PROGRAM\_PATH** for this.
See also **CMAKE\_SYSTEM\_PREFIX\_PATH**.

<a name="cmake_user_make_rules_override"></a>

### CMAKE_USER_MAKE_RULES_OVERRIDE


Specify a CMake file that overrides platform information.

CMake loads the specified file while enabling support for each
language from either the **project()** or **enable\_language()**
commands.  It is loaded after CMake’s builtin compiler and platform information
modules have been loaded but before the information is used.  The file
may set platform information variables to override CMake’s defaults.

This feature is intended for use only in overriding information
variables that must be set before CMake builds its first test project
to check that the compiler for a language works.  It should not be
used to load a file in cases that a normal **include()** will work.  Use
it only as a last resort for behavior that cannot be achieved any
other way.  For example, one may set the
**CMAKE\_C\_FLAGS\_INIT** variable
to change the default value used to initialize the
**CMAKE\_C\_FLAGS** variable
before it is cached.  The override file should NOT be used to set anything
that could be set after languages are enabled, such as variables like
**CMAKE\_RUNTIME\_OUTPUT\_DIRECTORY** that affect the placement of
binaries.  Information set in the file will be used for **try\_compile()**
and **try\_run()** builds too.

<a name="cmake_warn_deprecated"></a>

### CMAKE_WARN_DEPRECATED


Whether to issue warnings for deprecated functionality.

If not **FALSE**, use of deprecated functionality will issue warnings.
If this variable is not set, CMake behaves as if it were set to **TRUE**.

When running **cmake(1)**, this option can be enabled with the
**-Wdeprecated** option, or disabled with the **-Wno-deprecated** option.

<a name="cmake_warn_on_absolute_install_destination"></a>

### CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION


Ask **cmake\_install.cmake** script to warn each time a file with absolute
**INSTALL DESTINATION** is encountered.

This variable is used by CMake-generated **cmake\_install.cmake** scripts.
If one sets this variable to **ON** while running the script, it may get
warning messages from the script.

<a name="cmake_xcode_generate_top_level_project_only"></a>

### CMAKE_XCODE_GENERATE_TOP_LEVEL_PROJECT_ONLY


If enabled, the **Xcode** generator will generate only a
single Xcode project file for the topmost **project()** command
instead of generating one for every **project()** command.

This could be useful to speed up the CMake generation step for
large projects and to work-around a bug in the **ZERO\_CHECK** logic.

<a name="cmake_xcode_scheme_address_sanitizer"></a>

### CMAKE_XCODE_SCHEME_ADDRESS_SANITIZER


Whether to enable **Address Sanitizer** in the Diagnostics
section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_ADDRESS\_SANITIZER**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_address_sanitizer_use_after_return"></a>

### CMAKE_XCODE_SCHEME_ADDRESS_SANITIZER_USE_AFTER_RETURN


Whether to enable **Detect use of stack after return**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_ADDRESS\_SANITIZER\_USE\_AFTER\_RETURN**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_debug_document_versioning"></a>

### CMAKE_XCODE_SCHEME_DEBUG_DOCUMENT_VERSIONING


Whether to enable
**Allow debugging when using document Versions Browser**
in the Options section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_DEBUG\_DOCUMENT\_VERSIONING**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_disable_main_thread_checker"></a>

### CMAKE_XCODE_SCHEME_DISABLE_MAIN_THREAD_CHECKER


Whether to disable the **Main Thread Checker**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_DISABLE\_MAIN\_THREAD\_CHECKER**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_dynamic_library_loads"></a>

### CMAKE_XCODE_SCHEME_DYNAMIC_LIBRARY_LOADS


Whether to enable **Dynamic Library Loads**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_DYNAMIC\_LIBRARY\_LOADS**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_dynamic_linker_api_usage"></a>

### CMAKE_XCODE_SCHEME_DYNAMIC_LINKER_API_USAGE


Whether to enable **Dynamic Linker API usage**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_DYNAMIC\_LINKER\_API\_USAGE**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_environment"></a>

### CMAKE_XCODE_SCHEME_ENVIRONMENT


Specify environment variables that should be added to the Arguments
section of the generated Xcode scheme.

If set to a list of environment variables and values of the form
**MYVAR=value** those environment variables will be added to the
scheme.

This variable initializes the **XCODE\_SCHEME\_ENVIRONMENT**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_guard_malloc"></a>

### CMAKE_XCODE_SCHEME_GUARD_MALLOC


Whether to enable **Guard Malloc**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_GUARD\_MALLOC**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_main_thread_checker_stop"></a>

### CMAKE_XCODE_SCHEME_MAIN_THREAD_CHECKER_STOP


Whether to enable the **Main Thread Checker** option
**Pause on issues**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_MAIN\_THREAD\_CHECKER\_STOP**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_malloc_guard_edges"></a>

### CMAKE_XCODE_SCHEME_MALLOC_GUARD_EDGES


Whether to enable **Malloc Guard Edges**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_MALLOC\_GUARD\_EDGES**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_malloc_scribble"></a>

### CMAKE_XCODE_SCHEME_MALLOC_SCRIBBLE


Whether to enable **Malloc Scribble**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_MALLOC\_SCRIBBLE**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_malloc_stack"></a>

### CMAKE_XCODE_SCHEME_MALLOC_STACK


Whether to enable **Malloc Stack** in the Diagnostics
section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_MALLOC\_STACK**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_thread_sanitizer"></a>

### CMAKE_XCODE_SCHEME_THREAD_SANITIZER


Whether to enable **Thread Sanitizer** in the Diagnostics
section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_THREAD\_SANITIZER**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_thread_sanitizer_stop"></a>

### CMAKE_XCODE_SCHEME_THREAD_SANITIZER_STOP


Whether to enable **Thread Sanitizer - Pause on issues**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_THREAD\_SANITIZER\_STOP**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_undefined_behaviour_sanitizer"></a>

### CMAKE_XCODE_SCHEME_UNDEFINED_BEHAVIOUR_SANITIZER


Whether to enable **Undefined Behavior Sanitizer**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_UNDEFINED\_BEHAVIOUR\_SANITIZER**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_undefined_behaviour_sanitizer_stop"></a>

### CMAKE_XCODE_SCHEME_UNDEFINED_BEHAVIOUR_SANITIZER_STOP


Whether to enable **Undefined Behavior Sanitizer** option
**Pause on issues**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_UNDEFINED\_BEHAVIOUR\_SANITIZER\_STOP**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_working_directory"></a>

### CMAKE_XCODE_SCHEME_WORKING_DIRECTORY


Specify the **Working Directory** of the _Run_ and _Profile_
actions in the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_WORKING\_DIRECTORY**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="cmake_xcode_scheme_zombie_objects"></a>

### CMAKE_XCODE_SCHEME_ZOMBIE_OBJECTS


Whether to enable **Zombie Objects**
in the Diagnostics section of the generated Xcode scheme.

This variable initializes the
**XCODE\_SCHEME\_ZOMBIE\_OBJECTS**
property on all targets.

Please refer to the **XCODE\_GENERATE\_SCHEME** target property
documentation to see all Xcode schema related properties.

<a name="ltpackagenamegt_root"></a>

### &lt;PackageName&gt;_ROOT


Calls to **find\_package(&lt;PackageName&gt;)** will search in prefixes
specified by the **&lt;PackageName&gt;\_ROOT** CMake variable, where
**&lt;PackageName&gt;** is the name given to the **find\_package()** call
and **\_ROOT** is literal.  For example, **find\_package(Foo)** will search
prefixes specified in the **Foo\_ROOT** CMake variable (if set).
See policy **CMP0074**.

This variable may hold a single prefix or a
semicolon-separated list of multiple prefixes.

See also the **&lt;PackageName&gt;\_ROOT** environment variable.

<a name="variables-that-describe-the-system"></a>

# Variables That Describe the System


<a name="android"></a>

### ANDROID


Set to **1** when the target system (**CMAKE\_SYSTEM\_NAME**) is
**Android**.

<a name="apple"></a>

### APPLE


Set to **True** when the target system is an Apple platform
(macOS, iOS, tvOS or watchOS).

<a name="borland"></a>

### BORLAND


**True** if the Borland compiler is being used.

This is set to **true** if the Borland compiler is being used.

<a name="cmake_cl_64"></a>

### CMAKE_CL_64


Discouraged.  Use **CMAKE\_SIZEOF\_VOID\_P** instead.

Set to a true value when using a Microsoft Visual Studio **cl** compiler that
_targets_ a 64-bit architecture.

<a name="cmake_compiler_2005"></a>

### CMAKE_COMPILER_2005


Using the Visual Studio 2005 compiler from Microsoft

Set to true when using the Visual Studio 2005 compiler from Microsoft.

<a name="cmake_host_apple"></a>

### CMAKE_HOST_APPLE


**True** for Apple macOS operating systems.

Set to **true** when the host system is Apple macOS.

<a name="cmake_host_solaris"></a>

### CMAKE_HOST_SOLARIS


**True** for Oracle Solaris operating systems.

Set to **true** when the host system is Oracle Solaris.

<a name="cmake_host_system"></a>

### CMAKE_HOST_SYSTEM


Composite Name of OS CMake is being run on.

This variable is the composite of **CMAKE\_HOST\_SYSTEM\_NAME** and
**CMAKE\_HOST\_SYSTEM\_VERSION**, e.g.
**${CMAKE\_HOST\_SYSTEM\_NAME}-${CMAKE\_HOST\_SYSTEM\_VERSION}**.  If
**CMAKE\_HOST\_SYSTEM\_VERSION** is not set, then this variable is
the same as **CMAKE\_HOST\_SYSTEM\_NAME**.

<a name="cmake_host_system_name"></a>

### CMAKE_HOST_SYSTEM_NAME


Name of the OS CMake is running on.

On systems that have the uname command, this variable is set to the
output of **uname -s**.  **Linux**, **Windows**, and **Darwin** for macOS
are the values found on the big three operating systems.

<a name="cmake_host_system_processor"></a>

### CMAKE_HOST_SYSTEM_PROCESSOR


The name of the CPU CMake is running on.

On Windows, this variable is set to the value of the environment variable
**PROCESSOR\_ARCHITECTURE**. On systems that support **uname**, this variable is
set to the output of:
.INDENT 0.0

* ·  
  **uname -m** on GNU, Linux, Cygwin, Darwin, Android, or
* ·  
  **arch** on OpenBSD, or
* ·  
  on other systems,
  .INDENT 2.0
* ·  
  **uname -p** if its exit code is nonzero, or
* ·  
  **uname -m** otherwise.
  .UNINDENT
  .UNINDENT

<a name="cmake_host_system_version"></a>

### CMAKE_HOST_SYSTEM_VERSION


The OS version CMake is running on.

A numeric version string for the system.  On systems that support
**uname**, this variable is set to the output of **uname -r**. On other
systems this is set to major-minor version numbers.

<a name="cmake_host_unix"></a>

### CMAKE_HOST_UNIX


**True** for UNIX and UNIX like operating systems.

Set to **true** when the host system is UNIX or UNIX like (i.e.  APPLE and
CYGWIN).

<a name="cmake_host_win32"></a>

### CMAKE_HOST_WIN32


**True** if the host system is running Windows, including Windows 64-bit and MSYS.

Set to **false** on Cygwin.

<a name="cmake_library_architecture"></a>

### CMAKE_LIBRARY_ARCHITECTURE


Target architecture library directory name, if detected.

This is the value of **CMAKE\_&lt;LANG&gt;\_LIBRARY\_ARCHITECTURE** as detected
for one of the enabled languages.

<a name="cmake_library_architecture_regex"></a>

### CMAKE_LIBRARY_ARCHITECTURE_REGEX


Regex matching possible target architecture library directory names.

This is used to detect **CMAKE\_&lt;LANG&gt;\_LIBRARY\_ARCHITECTURE** from the
implicit linker search path by matching the **&lt;arch&gt;** name.

<a name="cmake_object_path_max"></a>

### CMAKE_OBJECT_PATH_MAX


Maximum object file full-path length allowed by native build tools.

CMake computes for every source file an object file name that is
unique to the source file and deterministic with respect to the full
path to the source file.  This allows multiple source files in a
target to share the same name if they lie in different directories
without rebuilding when one is added or removed.  However, it can
produce long full paths in a few cases, so CMake shortens the path
using a hashing scheme when the full path to an object file exceeds a
limit.  CMake has a built-in limit for each platform that is
sufficient for common tools, but some native tools may have a lower
limit.  This variable may be set to specify the limit explicitly.  The
value must be an integer no less than 128.

<a name="cmake_system"></a>

### CMAKE_SYSTEM


Composite name of operating system CMake is compiling for.

This variable is the composite of **CMAKE\_SYSTEM\_NAME** and
**CMAKE\_SYSTEM\_VERSION**, e.g.
**${CMAKE\_SYSTEM\_NAME}-${CMAKE\_SYSTEM\_VERSION}**.  If
**CMAKE\_SYSTEM\_VERSION** is not set, then this variable is
the same as **CMAKE\_SYSTEM\_NAME**.

<a name="cmake_system_name"></a>

### CMAKE_SYSTEM_NAME


The name of the operating system for which CMake is to build.
See the **CMAKE\_SYSTEM\_VERSION** variable for the OS version.

Note that **CMAKE\_SYSTEM\_NAME** is not set to anything by default when running
in script mode, since it’s not building anything.

<a name="system-name-for-host-builds"></a>

### System Name for Host Builds


**CMAKE\_SYSTEM\_NAME** is by default set to the same value as the
**CMAKE\_HOST\_SYSTEM\_NAME** variable so that the build
targets the host system.

<a name="system-name-for-cross-compiling"></a>

### System Name for Cross Compiling


**CMAKE\_SYSTEM\_NAME** may be set explicitly when first configuring a new build
tree in order to enable cross compiling.
In this case the **CMAKE\_SYSTEM\_VERSION** variable must also be
set explicitly.

<a name="cmake_system_processor"></a>

### CMAKE_SYSTEM_PROCESSOR


The name of the CPU CMake is building for.

This variable is the same as **CMAKE\_HOST\_SYSTEM\_PROCESSOR** if
you build for the host system instead of the target system when
cross compiling.

<a name="cmake_system_version"></a>

### CMAKE_SYSTEM_VERSION


The version of the operating system for which CMake is to build.
See the **CMAKE\_SYSTEM\_NAME** variable for the OS name.

<a name="system-version-for-host-builds"></a>

### System Version for Host Builds


When the **CMAKE\_SYSTEM\_NAME** variable takes its default value
then **CMAKE\_SYSTEM\_VERSION** is by default set to the same value as the
**CMAKE\_HOST\_SYSTEM\_VERSION** variable so that the build targets
the host system version.

In the case of a host build then **CMAKE\_SYSTEM\_VERSION** may be set
explicitly when first configuring a new build tree in order to enable
targeting the build for a different version of the host operating system
than is actually running on the host.  This is allowed and not considered
cross compiling so long as the binaries built for the specified OS version
can still run on the host.

<a name="system-version-for-cross-compiling"></a>

### System Version for Cross Compiling


When the **CMAKE\_SYSTEM\_NAME** variable is set explicitly to
enable cross compiling then the
value of **CMAKE\_SYSTEM\_VERSION** must also be set explicitly to specify
the target system version.

<a name="cygwin"></a>

### CYGWIN


**True** for Cygwin.

Set to **true** when using Cygwin.

<a name="ghs-multi"></a>

### GHS\-MULTI


**True** when using **Green Hills MULTI** generator.

<a name="ios"></a>

### IOS


Set to **1** when the target system (**CMAKE\_SYSTEM\_NAME**) is **iOS**.

<a name="mingw"></a>

### MINGW


**True** when using MinGW

Set to **true** when the compiler is some version of MinGW.

<a name="msvc"></a>

### MSVC


Set to **true** when the compiler is some version of Microsoft Visual
C++ or another compiler simulating Visual C++.  Any compiler defining
**\_MSC\_VER** is considered simulating Visual C++.

See also the **MSVC\_VERSION** variable.

<a name="msvc10"></a>

### MSVC10


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using the Microsoft Visual Studio **v100** toolset
(**cl** version 16) or another compiler that simulates it.

<a name="msvc11"></a>

### MSVC11


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using the Microsoft Visual Studio **v110** toolset
(**cl** version 17) or another compiler that simulates it.

<a name="msvc12"></a>

### MSVC12


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using the Microsoft Visual Studio **v120** toolset
(**cl** version 18) or another compiler that simulates it.

<a name="msvc14"></a>

### MSVC14


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using the Microsoft Visual Studio **v140** or **v141**
toolset (**cl** version 19) or another compiler that simulates it.

<a name="msvc60"></a>

### MSVC60


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using Microsoft Visual C++ 6.0.

Set to **true** when the compiler is version 6.0 of Microsoft Visual C++.

<a name="msvc70"></a>

### MSVC70


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using Microsoft Visual C++ 7.0.

Set to **true** when the compiler is version 7.0 of Microsoft Visual C++.

<a name="msvc71"></a>

### MSVC71


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using Microsoft Visual C++ 7.1.

Set to **true** when the compiler is version 7.1 of Microsoft Visual C++.

<a name="msvc80"></a>

### MSVC80


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using the Microsoft Visual Studio **v80** toolset
(**cl** version 14) or another compiler that simulates it.

<a name="msvc90"></a>

### MSVC90


Discouraged.  Use the **MSVC\_VERSION** variable instead.

**True** when using the Microsoft Visual Studio **v90** toolset
(**cl** version 15) or another compiler that simulates it.

<a name="msvc_ide"></a>

### MSVC_IDE


**True** when using the Microsoft Visual C++ IDE.

Set to **true** when the target platform is the Microsoft Visual C++ IDE, as
opposed to the command line compiler.

<a name="msvc_toolset_version"></a>

### MSVC_TOOLSET_VERSION


The toolset version of Microsoft Visual C/C++ being used if any.
If MSVC-like is being used, this variable is set based on the version
of the compiler as given by the **MSVC\_VERSION** variable.

Known toolset version numbers are:
.INDENT 0.0
.INDENT 3.5

    .ft C
    80        = VS 2005 (8.0)
    90        = VS 2008 (9.0)
    100       = VS 2010 (10.0)
    110       = VS 2012 (11.0)
    120       = VS 2013 (12.0)
    140       = VS 2015 (14.0)
    141       = VS 2017 (15.0)
    142       = VS 2019 (16.0)
    .ft P
.UNINDENT
.UNINDENT

Compiler versions newer than those known to CMake will be reported
as the latest known toolset version.

See also the **MSVC\_VERSION** variable.

<a name="msvc_version"></a>

### MSVC_VERSION


The version of Microsoft Visual C/C++ being used if any.
If a compiler simulating Visual C++ is being used, this variable is set
to the toolset version simulated as given by the **\_MSC\_VER**
preprocessor definition.

Known version numbers are:
.INDENT 0.0
.INDENT 3.5

    .ft C
    1200      = VS  6.0
    1300      = VS  7.0
    1310      = VS  7.1
    1400      = VS  8.0 (v80 toolset)
    1500      = VS  9.0 (v90 toolset)
    1600      = VS 10.0 (v100 toolset)
    1700      = VS 11.0 (v110 toolset)
    1800      = VS 12.0 (v120 toolset)
    1900      = VS 14.0 (v140 toolset)
    1910-1919 = VS 15.0 (v141 toolset)
    1920-1929 = VS 16.0 (v142 toolset)
    .ft P
.UNINDENT
.UNINDENT

See also the  **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** and
**MSVC\_TOOLSET\_VERSION** variable.

<a name="msys"></a>

### MSYS


**True** when using the **MSYS Makefiles** generator.

<a name="unix"></a>

### UNIX


Set to **True** when the target system is UNIX or UNIX-like
(e.g. **APPLE** and **CYGWIN**).  The
**CMAKE\_SYSTEM\_NAME** variable should be queried if
a more specific understanding of the target system is required.

<a name="win32"></a>

### WIN32


Set to **True** when the target system is Windows, including Win64.

<a name="wince"></a>

### WINCE


True when the **CMAKE\_SYSTEM\_NAME** variable is set
to **WindowsCE**.

<a name="windows_phone"></a>

### WINDOWS_PHONE


True when the **CMAKE\_SYSTEM\_NAME** variable is set
to **WindowsPhone**.

<a name="windows_store"></a>

### WINDOWS_STORE


True when the **CMAKE\_SYSTEM\_NAME** variable is set
to **WindowsStore**.

<a name="xcode"></a>

### XCODE


**True** when using **Xcode** generator.

<a name="xcode_version"></a>

### XCODE_VERSION


Version of Xcode (**Xcode** generator only).

Under the **Xcode** generator, this is the version of Xcode
as specified in **Xcode.app/Contents/version.plist** (such as **3.1.2**).

<a name="variables-that-control-the-build"></a>

# Variables That Control the Build


<a name="cmake_aix_export_all_symbols"></a>

### CMAKE_AIX_EXPORT_ALL_SYMBOLS


Default value for **AIX\_EXPORT\_ALL\_SYMBOLS** target property.
This variable is used to initialize the property on each target as it is
created.

<a name="cmake_android_ant_additional_options"></a>

### CMAKE_ANDROID_ANT_ADDITIONAL_OPTIONS


Default value for the **ANDROID\_ANT\_ADDITIONAL\_OPTIONS** target property.
See that target property for additional information.

<a name="cmake_android_api"></a>

### CMAKE_ANDROID_API


When Cross Compiling for Android with NVIDIA Nsight Tegra Visual Studio
Edition, this variable may be set to specify the default value for the
**ANDROID\_API** target property.  See that target property for
additional information.

Otherwise, when Cross Compiling for Android, this variable provides
the Android API version number targeted.  This will be the same value as
the **CMAKE\_SYSTEM\_VERSION** variable for **Android** platforms.

<a name="cmake_android_api_min"></a>

### CMAKE_ANDROID_API_MIN


Default value for the **ANDROID\_API\_MIN** target property.
See that target property for additional information.

<a name="cmake_android_arch"></a>

### CMAKE_ANDROID_ARCH


When Cross Compiling for Android with NVIDIA Nsight Tegra Visual Studio
Edition, this variable may be set to specify the default value for the
**ANDROID\_ARCH** target property.  See that target property for
additional information.

Otherwise, when Cross Compiling for Android, this variable provides
the name of the Android architecture corresponding to the value of the
**CMAKE\_ANDROID\_ARCH\_ABI** variable.  The architecture name
may be one of:
.INDENT 0.0

* ·  
  **arm**
* ·  
  **arm64**
* ·  
  **mips**
* ·  
  **mips64**
* ·  
  **x86**
* ·  
  **x86\_64**
  .UNINDENT

<a name="cmake_android_arch_abi"></a>

### CMAKE_ANDROID_ARCH_ABI


When Cross Compiling for Android, this variable specifies the
target architecture and ABI to be used.  Valid values are:
.INDENT 0.0

* ·  
  **arm64-v8a**
* ·  
  **armeabi-v7a**
* ·  
  **armeabi-v6**
* ·  
  **armeabi**
* ·  
  **mips**
* ·  
  **mips64**
* ·  
  **x86**
* ·  
  **x86\_64**
  .UNINDENT

See also the **CMAKE\_ANDROID\_ARM\_MODE** and
**CMAKE\_ANDROID\_ARM\_NEON** variables.

<a name="cmake_android_arm_mode"></a>

### CMAKE_ANDROID_ARM_MODE


When Cross Compiling for Android and **CMAKE\_ANDROID\_ARCH\_ABI**
is set to one of the **armeabi** architectures, set **CMAKE\_ANDROID\_ARM\_MODE**
to **ON** to target 32-bit ARM processors (**-marm**).  Otherwise, the
default is to target the 16-bit Thumb processors (**-mthumb**).

<a name="cmake_android_arm_neon"></a>

### CMAKE_ANDROID_ARM_NEON


When Cross Compiling for Android and **CMAKE\_ANDROID\_ARCH\_ABI**
is set to **armeabi-v7a** set **CMAKE\_ANDROID\_ARM\_NEON** to **ON** to target
ARM NEON devices.

<a name="cmake_android_assets_directories"></a>

### CMAKE_ANDROID_ASSETS_DIRECTORIES


Default value for the **ANDROID\_ASSETS\_DIRECTORIES** target property.
See that target property for additional information.

<a name="cmake_android_gui"></a>

### CMAKE_ANDROID_GUI


Default value for the **ANDROID\_GUI** target property of
executables.  See that target property for additional information.

<a name="cmake_android_jar_dependencies"></a>

### CMAKE_ANDROID_JAR_DEPENDENCIES


Default value for the **ANDROID\_JAR\_DEPENDENCIES** target property.
See that target property for additional information.

<a name="cmake_android_jar_directories"></a>

### CMAKE_ANDROID_JAR_DIRECTORIES


Default value for the **ANDROID\_JAR\_DIRECTORIES** target property.
See that target property for additional information.

<a name="cmake_android_java_source_dir"></a>

### CMAKE_ANDROID_JAVA_SOURCE_DIR


Default value for the **ANDROID\_JAVA\_SOURCE\_DIR** target property.
See that target property for additional information.

<a name="cmake_android_native_lib_dependencies"></a>

### CMAKE_ANDROID_NATIVE_LIB_DEPENDENCIES


Default value for the **ANDROID\_NATIVE\_LIB\_DEPENDENCIES** target
property.  See that target property for additional information.

<a name="cmake_android_native_lib_directories"></a>

### CMAKE_ANDROID_NATIVE_LIB_DIRECTORIES


Default value for the **ANDROID\_NATIVE\_LIB\_DIRECTORIES** target
property.  See that target property for additional information.

<a name="cmake_android_ndk"></a>

### CMAKE_ANDROID_NDK


When Cross Compiling for Android with the NDK, this variable holds
the absolute path to the root directory of the NDK.  The directory must
contain a **platforms** subdirectory holding the **android-&lt;api&gt;**
directories.

<a name="cmake_android_ndk_deprecated_headers"></a>

### CMAKE_ANDROID_NDK_DEPRECATED_HEADERS


When Cross Compiling for Android with the NDK, this variable
may be set to specify whether to use the deprecated per-api-level
headers instead of the unified headers.

If not specified, the default will be _false_ if using a NDK version
that provides the unified headers and _true_ otherwise.

<a name="cmake_android_ndk_toolchain_host_tag"></a>

### CMAKE_ANDROID_NDK_TOOLCHAIN_HOST_TAG


When Cross Compiling for Android with the NDK, this variable
provides the NDK’s “host tag” used to construct the path to prebuilt
toolchains that run on the host.

<a name="cmake_android_ndk_toolchain_version"></a>

### CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION


When Cross Compiling for Android with the NDK, this variable
may be set to specify the version of the toolchain to be used
as the compiler.

On NDK r19 or above, this variable must be unset or set to **clang**.

On NDK r18 or below, this variable must be set to one of these forms:
.INDENT 0.0

* ·  
  **&lt;major&gt;.&lt;minor&gt;**: GCC of specified version
* ·  
  **clang&lt;major&gt;.&lt;minor&gt;**: Clang of specified version
* ·  
  **clang**: Clang of most recent available version
  .UNINDENT

A toolchain of the requested version will be selected automatically to
match the ABI named in the **CMAKE\_ANDROID\_ARCH\_ABI** variable.

If not specified, the default will be a value that selects the latest
available GCC toolchain.

<a name="cmake_android_process_max"></a>

### CMAKE_ANDROID_PROCESS_MAX


Default value for the **ANDROID\_PROCESS\_MAX** target property.
See that target property for additional information.

<a name="cmake_android_proguard"></a>

### CMAKE_ANDROID_PROGUARD


Default value for the **ANDROID\_PROGUARD** target property.
See that target property for additional information.

<a name="cmake_android_proguard_config_path"></a>

### CMAKE_ANDROID_PROGUARD_CONFIG_PATH


Default value for the **ANDROID\_PROGUARD\_CONFIG\_PATH** target property.
See that target property for additional information.

<a name="cmake_android_secure_props_path"></a>

### CMAKE_ANDROID_SECURE_PROPS_PATH


Default value for the **ANDROID\_SECURE\_PROPS\_PATH** target property.
See that target property for additional information.

<a name="cmake_android_skip_ant_step"></a>

### CMAKE_ANDROID_SKIP_ANT_STEP


Default value for the **ANDROID\_SKIP\_ANT\_STEP** target property.
See that target property for additional information.

<a name="cmake_android_standalone_toolchain"></a>

### CMAKE_ANDROID_STANDALONE_TOOLCHAIN


When Cross Compiling for Android with a Standalone Toolchain, this
variable holds the absolute path to the root directory of the toolchain.
The specified directory must contain a **sysroot** subdirectory.

<a name="cmake_android_stl_type"></a>

### CMAKE_ANDROID_STL_TYPE


When Cross Compiling for Android with NVIDIA Nsight Tegra Visual Studio
Edition, this variable may be set to specify the default value for the
**ANDROID\_STL\_TYPE** target property.  See that target property
for additional information.

When Cross Compiling for Android with the NDK, this variable may be
set to specify the STL variant to be used.  The value may be one of:
.INDENT 0.0

* <b>**none**</b>  
  No C++ Support
* <b>**system**</b>  
  Minimal C++ without STL
* <b>**gabi++\_static**</b>  
  GAbi++ Static
* <b>**gabi++\_shared**</b>  
  GAbi++ Shared
* <b>**gnustl\_static**</b>  
  GNU libstdc++ Static
* <b>**gnustl\_shared**</b>  
  GNU libstdc++ Shared
* <b>**c++\_static**</b>  
  LLVM libc++ Static
* <b>**c++\_shared**</b>  
  LLVM libc++ Shared
* <b>**stlport\_static**</b>  
  STLport Static
* <b>**stlport\_shared**</b>  
  STLport Shared
  .UNINDENT

The default value is **gnustl\_static** on NDK versions that provide it
and otherwise **c++\_static**.  Note that this default differs from
the native NDK build system because CMake may be used to build projects for
Android that are not natively implemented for it and use the C++ standard
library.

<a name="cmake_archive_output_directory"></a>

### CMAKE_ARCHIVE_OUTPUT_DIRECTORY


Where to put all the ARCHIVE
target files when built.

This variable is used to initialize the **ARCHIVE\_OUTPUT\_DIRECTORY**
property on all the targets.  See that target property for additional
information.

<a name="cmake_archive_output_directory_ltconfiggt"></a>

### CMAKE_ARCHIVE_OUTPUT_DIRECTORY_&lt;CONFIG&gt;


Where to put all the ARCHIVE
target files when built for a specific configuration.

This variable is used to initialize the
**ARCHIVE\_OUTPUT\_DIRECTORY\_&lt;CONFIG&gt;** property on all the targets.
See that target property for additional information.

<a name="cmake_autogen_origin_depends"></a>

### CMAKE_AUTOGEN_ORIGIN_DEPENDS


Switch for forwarding origin target dependencies to the corresponding
**\_autogen** targets.

This variable is used to initialize the **AUTOGEN\_ORIGIN\_DEPENDS**
property on all the targets.  See that target property for additional
information.

By default _CMAKE\_AUTOGEN\_ORIGIN\_DEPENDS_ is **ON**.

<a name="cmake_autogen_parallel"></a>

### CMAKE_AUTOGEN_PARALLEL


Number of parallel **moc** or **uic** processes to start when using
**AUTOMOC** and **AUTOUIC**.

This variable is used to initialize the **AUTOGEN\_PARALLEL** property
on all the targets.  See that target property for additional information.

By default _CMAKE\_AUTOGEN\_PARALLEL_ is unset.

<a name="cmake_autogen_verbose"></a>

### CMAKE_AUTOGEN_VERBOSE


Sets the verbosity of **AUTOMOC**, **AUTOUIC** and
**AUTORCC**.  A positive integer value or a true boolean value
lets the **AUTO*** generators output additional processing information.

Setting _CMAKE\_AUTOGEN\_VERBOSE_ has the same effect
as setting the **VERBOSE** environment variable during
generation (e.g. by calling **make VERBOSE=1**).
The extra verbosity is limited to the **AUTO*** generators though.

By default _CMAKE\_AUTOGEN\_VERBOSE_ is unset.

<a name="cmake_automoc"></a>

### CMAKE_AUTOMOC


Whether to handle **moc** automatically for Qt targets.

This variable is used to initialize the **AUTOMOC** property on all the
targets.  See that target property for additional information.

<a name="cmake_automoc_compiler_predefines"></a>

### CMAKE_AUTOMOC_COMPILER_PREDEFINES


This variable is used to initialize the **AUTOMOC\_COMPILER\_PREDEFINES**
property on all the targets. See that target property for additional
information.

By default it is ON.

<a name="cmake_automoc_depend_filters"></a>

### CMAKE_AUTOMOC_DEPEND_FILTERS


Filter definitions used by **CMAKE\_AUTOMOC**
to extract file names from source code as additional dependencies
for the **moc** file.

This variable is used to initialize the **AUTOMOC\_DEPEND\_FILTERS**
property on all the targets. See that target property for additional
information.

By default it is empty.

<a name="cmake_automoc_macro_names"></a>

### CMAKE_AUTOMOC_MACRO_NAMES


Semicolon-separated list list of macro names used by
**CMAKE\_AUTOMOC** to determine if a C++ file needs to be
processed by **moc**.

This variable is used to initialize the **AUTOMOC\_MACRO\_NAMES**
property on all the targets. See that target property for additional
information.

The default value is **Q\_OBJECT;Q\_GADGET;Q\_NAMESPACE**.

<a name="example"></a>

### Example


Let CMake know that source files that contain **CUSTOM\_MACRO** must be **moc**
processed as well:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_AUTOMOC ON)
    list(APPEND CMAKE_AUTOMOC_MACRO_NAMES "CUSTOM_MACRO")
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_automoc_moc_options"></a>

### CMAKE_AUTOMOC_MOC_OPTIONS


Additional options for **moc** when using **CMAKE\_AUTOMOC**.

This variable is used to initialize the **AUTOMOC\_MOC\_OPTIONS** property
on all the targets.  See that target property for additional information.

<a name="cmake_automoc_path_prefix"></a>

### CMAKE_AUTOMOC_PATH_PREFIX


Whether to generate the **-p** path prefix option for **moc** on
**AUTOMOC** enabled Qt targets.

This variable is used to initialize the **AUTOMOC\_PATH\_PREFIX**
property on all the targets.  See that target property for additional
information.

The default value is **ON**.

<a name="cmake_autorcc"></a>

### CMAKE_AUTORCC


Whether to handle **rcc** automatically for Qt targets.

This variable is used to initialize the **AUTORCC** property on all
the targets.  See that target property for additional information.

<a name="cmake_autorcc_options"></a>

### CMAKE_AUTORCC_OPTIONS


Additional options for **rcc** when using **CMAKE\_AUTORCC**.

This variable is used to initialize the **AUTORCC\_OPTIONS** property on
all the targets.  See that target property for additional information.

<a name="example"></a>

### EXAMPLE

.INDENT 0.0
.INDENT 3.5

    .ft C
    # ...
    set(CMAKE_AUTORCC_OPTIONS "--compress;9")
    # ...
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_autouic"></a>

### CMAKE_AUTOUIC


Whether to handle **uic** automatically for Qt targets.

This variable is used to initialize the **AUTOUIC** property on all
the targets.  See that target property for additional information.

<a name="cmake_autouic_options"></a>

### CMAKE_AUTOUIC_OPTIONS


Additional options for **uic** when using **CMAKE\_AUTOUIC**.

This variable is used to initialize the **AUTOUIC\_OPTIONS** property on
all the targets.  See that target property for additional information.

<a name="example"></a>

### EXAMPLE

.INDENT 0.0
.INDENT 3.5

    .ft C
    # ...
    set_property(CMAKE_AUTOUIC_OPTIONS "--no-protection")
    # ...
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_autouic_search_paths"></a>

### CMAKE_AUTOUIC_SEARCH_PATHS


Search path list used by **CMAKE\_AUTOUIC** to find included
**.ui** files.

This variable is used to initialize the **AUTOUIC\_SEARCH\_PATHS**
property on all the targets. See that target property for additional
information.

By default it is empty.

<a name="cmake_build_rpath"></a>

### CMAKE_BUILD_RPATH


Semicolon-separated list specifying runtime path (**RPATH**)
entries to add to binaries linked in the build tree (for platforms that
support it).  The entries will _not_ be used for binaries in the install
tree.  See also the **CMAKE\_INSTALL\_RPATH** variable.

This is used to initialize the **BUILD\_RPATH** target property
for all targets.

<a name="cmake_build_rpath_use_origin"></a>

### CMAKE_BUILD_RPATH_USE_ORIGIN


Whether to use relative paths for the build **RPATH**.

This is used to initialize the **BUILD\_RPATH\_USE\_ORIGIN** target
property for all targets, see that property for more details.

<a name="cmake_build_with_install_name_dir"></a>

### CMAKE_BUILD_WITH_INSTALL_NAME_DIR


Whether to use **INSTALL\_NAME\_DIR** on targets in the build tree.

This variable is used to initialize the **BUILD\_WITH\_INSTALL\_NAME\_DIR**
property on all targets.

<a name="cmake_build_with_install_rpath"></a>

### CMAKE_BUILD_WITH_INSTALL_RPATH


Use the install path for the **RPATH**.

Normally CMake uses the build tree for the **RPATH** when building
executables etc on systems that use **RPATH**.  When the software is
installed the executables etc are relinked by CMake to have the
install **RPATH**.  If this variable is set to true then the software is
always built with the install path for the **RPATH** and does not need to
be relinked when installed.

<a name="cmake_compile_pdb_output_directory"></a>

### CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY


Output directory for MS debug symbol **.pdb** files
generated by the compiler while building source files.

This variable is used to initialize the
**COMPILE\_PDB\_OUTPUT\_DIRECTORY** property on all the targets.

<a name="cmake_compile_pdb_output_directory_ltconfiggt"></a>

### CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY_&lt;CONFIG&gt;


Per-configuration output directory for MS debug symbol **.pdb** files
generated by the compiler while building source files.

This is a per-configuration version of
**CMAKE\_COMPILE\_PDB\_OUTPUT\_DIRECTORY**.
This variable is used to initialize the
**COMPILE\_PDB\_OUTPUT\_DIRECTORY\_&lt;CONFIG&gt;**
property on all the targets.

<a name="cmake_ltconfiggt_postfix"></a>

### CMAKE_&lt;CONFIG&gt;_POSTFIX


Default filename postfix for libraries under configuration **&lt;CONFIG&gt;**.

When a non-executable target is created its **&lt;CONFIG&gt;\_POSTFIX**
target property is initialized with the value of this variable if it is set.

<a name="cmake_cross_configs"></a>

### CMAKE_CROSS_CONFIGS


Specifies a semicolon-separated list of
configurations available from all **build-&lt;Config&gt;.ninja** files in the
**Ninja Multi-Config** generator.  This variable activates
cross-config mode. Targets from each config specified in this variable can be
built from any **build-&lt;Config&gt;.ninja** file. Custom commands will use the
configuration native to **build-&lt;Config&gt;.ninja**. If it is set to **all**, all
configurations from **CMAKE\_CONFIGURATION\_TYPES** are cross-configs. If
it is not specified, or empty, each **build-&lt;Config&gt;.ninja** file will only
contain build rules for its own configuration.

The value of this variable must be a subset of
**CMAKE\_CONFIGURATION\_TYPES**.

<a name="cmake_ctest_arguments"></a>

### CMAKE_CTEST_ARGUMENTS


Set this to a semicolon-separated list of
command-line arguments to pass to **ctest(1)** when running tests
through the **test** (or **RUN\_TESTS**) target of the generated build system.

<a name="cmake_cuda_separable_compilation"></a>

### CMAKE_CUDA_SEPARABLE_COMPILATION


Default value for **CUDA\_SEPARABLE\_COMPILATION** target property.
This variable is used to initialize the property on each target as it is
created.

<a name="cmake_cuda_resolve_device_symbols"></a>

### CMAKE_CUDA_RESOLVE_DEVICE_SYMBOLS


Default value for **CUDA\_RESOLVE\_DEVICE\_SYMBOLS** target
property. This variable is used to initialize the property on each target as
it is created.

<a name="cmake_cuda_runtime_library"></a>

### CMAKE_CUDA_RUNTIME_LIBRARY


Select the CUDA runtime library for use by compilers targeting the MSVC ABI.
This variable is used to initialize the **CUDA\_RUNTIME\_LIBRARY**
property on all targets as they are created.

The allowed case insensitive values are:
.INDENT 0.0

* <b>**None**</b>  
  Link with **-cudart=none** or equivalent flag(s) to use no CUDA
  runtime library.
* <b>**Shared**</b>  
  Link with **-cudart=shared** or equivalent flag(s) to use a
  dynamically-linked CUDA runtime library.
* <b>**Static**</b>  
  Link with **-cudart=static** or equivalent flag(s) to use a
  statically-linked CUDA runtime library.
  .UNINDENT

Contents of **CMAKE\_CUDA\_RUNTIME\_LIBRARY** may use
**generator expressions**.

If this variable is not set then the **CUDA\_RUNTIME\_LIBRARY** target
property will not be set automatically.  If that property is not set then
CMake uses the default value **Static** to select the CUDA runtime library.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This property has effect only when the **CUDA** language is enabled. To
control the CUDA runtime linking when only using the CUDA SDK with the
**C** or **C++** language we recommend using the **FindCUDAToolkit**
module.
.UNINDENT
.UNINDENT

<a name="cmake_debug_postfix"></a>

### CMAKE_DEBUG_POSTFIX


See variable **CMAKE\_&lt;CONFIG&gt;\_POSTFIX**.

This variable is a special case of the more-general
**CMAKE\_&lt;CONFIG&gt;\_POSTFIX** variable for the _DEBUG_ configuration.

<a name="cmake_default_build_type"></a>

### CMAKE_DEFAULT_BUILD_TYPE


Specifies the configuration to use by default in a **build.ninja** file in the
**Ninja Multi-Config** generator. If this variable is specified,
**build.ninja** uses build rules from **build-&lt;Config&gt;.ninja** by default. All
custom commands are executed with this configuration. If the variable is not
specified, the first item from **CMAKE\_CONFIGURATION\_TYPES** is used
instead.

The value of this variable must be one of the items from
**CMAKE\_CONFIGURATION\_TYPES**.

<a name="cmake_default_configs"></a>

### CMAKE_DEFAULT_CONFIGS


Specifies a semicolon-separated list of configurations
to build for a target in **build.ninja** if no **:&lt;Config&gt;** suffix is specified in
the **Ninja Multi-Config** generator. If it is set to **all**, all
configurations from **CMAKE\_CROSS\_CONFIGS** are used. If it is not
specified, it defaults to **CMAKE\_DEFAULT\_BUILD\_TYPE**.

For example, if you set **CMAKE\_DEFAULT\_BUILD\_TYPE** to **Release**,
but set _CMAKE\_DEFAULT\_CONFIGS_ to **Debug** or **all**, all
**&lt;target&gt;** aliases in **build.ninja** will resolve to **&lt;target&gt;:Debug** or
**&lt;target&gt;:all**, but custom commands will still use the **Release**
configuration.

The value of this variable must be a subset of **CMAKE\_CROSS\_CONFIGS**
or be the same as **CMAKE\_DEFAULT\_BUILD\_TYPE**. It must not be
specified if **CMAKE\_DEFAULT\_BUILD\_TYPE** or
**CMAKE\_CROSS\_CONFIGS** is not used.

<a name="cmake_disable_precompile_headers"></a>

### CMAKE_DISABLE_PRECOMPILE_HEADERS


Default value for **DISABLE\_PRECOMPILE\_HEADERS** of targets.

By default **CMAKE\_DISABLE\_PRECOMPILE\_HEADERS** is **OFF**.

<a name="cmake_enable_exports"></a>

### CMAKE_ENABLE_EXPORTS


Specify whether executables export symbols for loadable modules.

This variable is used to initialize the **ENABLE\_EXPORTS** target
property for executable targets when they are created by calls to the
**add\_executable()** command.  See the property documentation for details.

<a name="cmake_exe_linker_flags"></a>

### CMAKE_EXE_LINKER_FLAGS


Linker flags to be used to create executables.

These flags will be used by the linker when creating an executable.

<a name="cmake_exe_linker_flags_ltconfiggt"></a>

### CMAKE_EXE_LINKER_FLAGS_&lt;CONFIG&gt;


Flags to be used when linking an executable.

Same as **CMAKE\_C\_FLAGS\_*** but used by the linker when creating
executables.

<a name="cmake_exe_linker_flags_ltconfiggt_init"></a>

### CMAKE_EXE_LINKER_FLAGS_&lt;CONFIG&gt;_INIT


Value used to initialize the **CMAKE\_EXE\_LINKER\_FLAGS\_&lt;CONFIG&gt;**
cache entry the first time a build tree is configured.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also **CMAKE\_EXE\_LINKER\_FLAGS\_INIT**.

<a name="cmake_exe_linker_flags_init"></a>

### CMAKE_EXE_LINKER_FLAGS_INIT


Value used to initialize the **CMAKE\_EXE\_LINKER\_FLAGS**
cache entry the first time a build tree is configured.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also the configuration-specific variable
**CMAKE\_EXE\_LINKER\_FLAGS\_&lt;CONFIG&gt;\_INIT**.

<a name="cmake_folder"></a>

### CMAKE_FOLDER


Set the folder name. Use to organize targets in an IDE.

This variable is used to initialize the **FOLDER** property on all the
targets.  See that target property for additional information.

<a name="cmake_framework"></a>

### CMAKE_FRAMEWORK


Default value for **FRAMEWORK** of targets.

This variable is used to initialize the **FRAMEWORK** property on
all the targets.  See that target property for additional information.

<a name="cmake_fortran_format"></a>

### CMAKE_Fortran_FORMAT


Set to **FIXED** or **FREE** to indicate the Fortran source layout.

This variable is used to initialize the **Fortran\_FORMAT** property on
all the targets.  See that target property for additional information.

<a name="cmake_fortran_module_directory"></a>

### CMAKE_Fortran_MODULE_DIRECTORY


Fortran module output directory.

This variable is used to initialize the **Fortran\_MODULE\_DIRECTORY**
property on all the targets.  See that target property for additional
information.

<a name="cmake_ghs_no_source_group_file"></a>

### CMAKE_GHS_NO_SOURCE_GROUP_FILE


**ON** / **OFF** boolean to control if the project file for a target should
be one single file or multiple files.  Refer to
**GHS\_NO\_SOURCE\_GROUP\_FILE** for further details.

<a name="cmake_global_autogen_target"></a>

### CMAKE_GLOBAL_AUTOGEN_TARGET


Switch to enable generation of a global **autogen** target.

When _CMAKE\_GLOBAL\_AUTOGEN\_TARGET_ is enabled, a custom target
**autogen** is generated.  This target depends on all **AUTOMOC** and
**AUTOUIC** generated **&lt;ORIGIN&gt;\_autogen** targets in the project.
By building the global **autogen** target, all **AUTOMOC** and
**AUTOUIC** files in the project will be generated.

The name of the global **autogen** target can be changed by setting
**CMAKE\_GLOBAL\_AUTOGEN\_TARGET\_NAME**.

By default _CMAKE\_GLOBAL\_AUTOGEN\_TARGET_ is unset.

See the **cmake-qt(7)** manual for more information on using CMake
with Qt.

<a name="note"></a>

### Note


**&lt;ORIGIN&gt;\_autogen** targets by default inherit their origin target’s
dependencies.  This might result in unintended dependency target
builds when only **&lt;ORIGIN&gt;\_autogen** targets are built.  A solution is to
disable **AUTOGEN\_ORIGIN\_DEPENDS** on the respective origin targets.

<a name="cmake_global_autogen_target_name"></a>

### CMAKE_GLOBAL_AUTOGEN_TARGET_NAME


Change the name of the global **autogen** target.

When **CMAKE\_GLOBAL\_AUTOGEN\_TARGET** is enabled, a global custom target
named **autogen** is created.  _CMAKE\_GLOBAL\_AUTOGEN\_TARGET\_NAME_
allows to set a different name for that target.

By default _CMAKE\_GLOBAL\_AUTOGEN\_TARGET\_NAME_ is unset.

See the **cmake-qt(7)** manual for more information on using CMake
with Qt.

<a name="cmake_global_autorcc_target"></a>

### CMAKE_GLOBAL_AUTORCC_TARGET


Switch to enable generation of a global **autorcc** target.

When _CMAKE\_GLOBAL\_AUTORCC\_TARGET_ is enabled, a custom target
**autorcc** is generated. This target depends on all **AUTORCC**
generated **&lt;ORIGIN&gt;\_arcc\_&lt;QRC&gt;** targets in the project.
By building the global **autorcc** target, all **AUTORCC**
files in the project will be generated.

The name of the global **autorcc** target can be changed by setting
**CMAKE\_GLOBAL\_AUTORCC\_TARGET\_NAME**.

By default _CMAKE\_GLOBAL\_AUTORCC\_TARGET_ is unset.

See the **cmake-qt(7)** manual for more information on using CMake
with Qt.

<a name="cmake_global_autorcc_target_name"></a>

### CMAKE_GLOBAL_AUTORCC_TARGET_NAME


Change the name of the global **autorcc** target.

When **CMAKE\_GLOBAL\_AUTORCC\_TARGET** is enabled, a global custom target
named **autorcc** is created.  _CMAKE\_GLOBAL\_AUTORCC\_TARGET\_NAME_
allows to set a different name for that target.

By default **CMAKE\_GLOBAL\_AUTOGEN\_TARGET\_NAME** is unset.

See the **cmake-qt(7)** manual for more information on using CMake
with Qt.

<a name="cmake_gnutoms"></a>

### CMAKE_GNUtoMS


Convert GNU import libraries (**.dll.a**) to MS format (**.lib**).

This variable is used to initialize the **GNUtoMS** property on
targets when they are created.  See that target property for additional
information.

<a name="cmake_include_current_dir"></a>

### CMAKE_INCLUDE_CURRENT_DIR


Automatically add the current source and build directories to the include path.

If this variable is enabled, CMake automatically adds
**CMAKE\_CURRENT\_SOURCE\_DIR** and **CMAKE\_CURRENT\_BINARY\_DIR**
to the include path for each directory.  These additional include
directories do not propagate down to subdirectories.  This is useful
mainly for out-of-source builds, where files generated into the build
tree are included by files located in the source tree.

By default **CMAKE\_INCLUDE\_CURRENT\_DIR** is **OFF**.

<a name="cmake_include_current_dir_in_interface"></a>

### CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE


Automatically add the current source and build directories to the
**INTERFACE\_INCLUDE\_DIRECTORIES** target property.

If this variable is enabled, CMake automatically adds for each shared
library target, static library target, module target and executable
target, **CMAKE\_CURRENT\_SOURCE\_DIR** and
**CMAKE\_CURRENT\_BINARY\_DIR** to
the **INTERFACE\_INCLUDE\_DIRECTORIES** target property.  By default
**CMAKE\_INCLUDE\_CURRENT\_DIR\_IN\_INTERFACE** is **OFF**.

<a name="cmake_install_name_dir"></a>

### CMAKE_INSTALL_NAME_DIR


macOS directory name for installed targets.

**CMAKE\_INSTALL\_NAME\_DIR** is used to initialize the
**INSTALL\_NAME\_DIR** property on all targets.  See that target
property for more information.

<a name="cmake_install_remove_environment_rpath"></a>

### CMAKE_INSTALL_REMOVE_ENVIRONMENT_RPATH


Sets the default for whether toolchain-defined rpaths should be removed during
installation.

**CMAKE\_INSTALL\_REMOVE\_ENVIRONMENT\_RPATH** is a boolean that provides the
default value for the **INSTALL\_REMOVE\_ENVIRONMENT\_RPATH** property
of all subsequently created targets.

<a name="cmake_install_rpath"></a>

### CMAKE_INSTALL_RPATH


The rpath to use for installed targets.

A semicolon-separated list specifying the rpath to use in installed
targets (for platforms that support it).  This is used to initialize
the target property **INSTALL\_RPATH** for all targets.

<a name="cmake_install_rpath_use_link_path"></a>

### CMAKE_INSTALL_RPATH_USE_LINK_PATH


Add paths to linker search and installed rpath.

**CMAKE\_INSTALL\_RPATH\_USE\_LINK\_PATH** is a boolean that if set to **True**
will append to the runtime search path (rpath) of installed binaries
any directories outside the project that are in the linker search path or
contain linked library files.  The directories are appended after the
value of the **INSTALL\_RPATH** target property.

This variable is used to initialize the target property
**INSTALL\_RPATH\_USE\_LINK\_PATH** for all targets.

<a name="cmake_interprocedural_optimization"></a>

### CMAKE_INTERPROCEDURAL_OPTIMIZATION


Default value for **INTERPROCEDURAL\_OPTIMIZATION** of targets.

This variable is used to initialize the **INTERPROCEDURAL\_OPTIMIZATION**
property on all the targets.  See that target property for additional
information.

<a name="cmake_interprocedural_optimization_ltconfiggt"></a>

### CMAKE_INTERPROCEDURAL_OPTIMIZATION_&lt;CONFIG&gt;


Default value for **INTERPROCEDURAL\_OPTIMIZATION\_&lt;CONFIG&gt;** of targets.

This variable is used to initialize the **INTERPROCEDURAL\_OPTIMIZATION\_&lt;CONFIG&gt;**
property on all the targets.  See that target property for additional
information.

<a name="cmake_ios_install_combined"></a>

### CMAKE_IOS_INSTALL_COMBINED


Default value for **IOS\_INSTALL\_COMBINED** of targets.

This variable is used to initialize the **IOS\_INSTALL\_COMBINED**
property on all the targets.  See that target property for additional
information.

<a name="cmake_ltlanggt_clang_tidy"></a>

### CMAKE_&lt;LANG&gt;_CLANG_TIDY


Default value for **&lt;LANG&gt;\_CLANG\_TIDY** target property
when **&lt;LANG&gt;** is **C** or **CXX**.

This variable is used to initialize the property on each target as it is
created.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_CXX_CLANG_TIDY clang-tidy -checks=-*,readability-*)
    add_executable(foo foo.cxx)
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_ltlanggt_compiler_launcher"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_LAUNCHER


Default value for **&lt;LANG&gt;\_COMPILER\_LAUNCHER** target property.
This variable is used to initialize the property on each target as it is
created.  This is done only when **&lt;LANG&gt;** is **C**, **CXX**, **Fortran**,
**OBJC**, **OBJCXX**, or **CUDA**.

This variable is initialized to the **CMAKE\_&lt;LANG&gt;\_COMPILER\_LAUNCHER**
environment variable if it is set.

<a name="cmake_ltlanggt_cppcheck"></a>

### CMAKE_&lt;LANG&gt;_CPPCHECK


Default value for **&lt;LANG&gt;\_CPPCHECK** target property. This variable
is used to initialize the property on each target as it is created.  This
is done only when **&lt;LANG&gt;** is **C** or **CXX**.

<a name="cmake_ltlanggt_cpplint"></a>

### CMAKE_&lt;LANG&gt;_CPPLINT


Default value for **&lt;LANG&gt;\_CPPLINT** target property. This variable
is used to initialize the property on each target as it is created.  This
is done only when **&lt;LANG&gt;** is **C** or **CXX**.

<a name="cmake_ltlanggt_include_what_you_use"></a>

### CMAKE_&lt;LANG&gt;_INCLUDE_WHAT_YOU_USE


Default value for **&lt;LANG&gt;\_INCLUDE\_WHAT\_YOU\_USE** target property.
This variable is used to initialize the property on each target as it is
created.  This is done only when **&lt;LANG&gt;** is **C** or **CXX**.

<a name="cmake_ltlanggt_link_library_file_flag"></a>

### CMAKE_&lt;LANG&gt;_LINK_LIBRARY_FILE_FLAG


Language-specific flag to be used to link a library specified by
a path to its file.

The flag will be used before a library file path is given to the
linker.  This is needed only on very few platforms.

<a name="cmake_ltlanggt_link_library_flag"></a>

### CMAKE_&lt;LANG&gt;_LINK_LIBRARY_FLAG


Flag to be used to link a library into a shared library or executable.

This flag will be used to specify a library to link to a shared library or an
executable for the specific language.  On most compilers this is **-l**.

<a name="cmake_ltlanggt_visibility_preset"></a>

### CMAKE_&lt;LANG&gt;_VISIBILITY_PRESET


Default value for the **&lt;LANG&gt;\_VISIBILITY\_PRESET** target
property when a target is created.

<a name="cmake_library_output_directory"></a>

### CMAKE_LIBRARY_OUTPUT_DIRECTORY


Where to put all the LIBRARY
target files when built.

This variable is used to initialize the **LIBRARY\_OUTPUT\_DIRECTORY**
property on all the targets.  See that target property for additional
information.

<a name="cmake_library_output_directory_ltconfiggt"></a>

### CMAKE_LIBRARY_OUTPUT_DIRECTORY_&lt;CONFIG&gt;


Where to put all the LIBRARY
target files when built for a specific configuration.

This variable is used to initialize the
**LIBRARY\_OUTPUT\_DIRECTORY\_&lt;CONFIG&gt;** property on all the targets.
See that target property for additional information.

<a name="cmake_library_path_flag"></a>

### CMAKE_LIBRARY_PATH_FLAG


The flag to be used to add a library search path to a compiler.

The flag will be used to specify a library directory to the compiler.
On most compilers this is **-L**.

<a name="cmake_link_def_file_flag"></a>

### CMAKE_LINK_DEF_FILE_FLAG


Linker flag to be used to specify a **.def** file for dll creation.

The flag will be used to add a **.def** file when creating a dll on
Windows; this is only defined on Windows.

<a name="cmake_link_depends_no_shared"></a>

### CMAKE_LINK_DEPENDS_NO_SHARED


Whether to skip link dependencies on shared library files.

This variable initializes the **LINK\_DEPENDS\_NO\_SHARED** property on
targets when they are created.  See that target property for
additional information.

<a name="cmake_link_interface_libraries"></a>

### CMAKE_LINK_INTERFACE_LIBRARIES


Default value for **LINK\_INTERFACE\_LIBRARIES** of targets.

This variable is used to initialize the **LINK\_INTERFACE\_LIBRARIES**
property on all the targets.  See that target property for additional
information.

<a name="cmake_link_library_file_flag"></a>

### CMAKE_LINK_LIBRARY_FILE_FLAG


Flag to be used to link a library specified by a path to its file.

The flag will be used before a library file path is given to the
linker.  This is needed only on very few platforms.

<a name="cmake_link_library_flag"></a>

### CMAKE_LINK_LIBRARY_FLAG


Flag to be used to link a library into an executable.

The flag will be used to specify a library to link to an executable.
On most compilers this is **-l**.

<a name="cmake_link_what_you_use"></a>

### CMAKE_LINK_WHAT_YOU_USE


Default value for **LINK\_WHAT\_YOU\_USE** target property.
This variable is used to initialize the property on each target as it is
created.

<a name="cmake_macosx_bundle"></a>

### CMAKE_MACOSX_BUNDLE


Default value for **MACOSX\_BUNDLE** of targets.

This variable is used to initialize the **MACOSX\_BUNDLE** property on
all the targets.  See that target property for additional information.

This variable is set to **ON** by default if **CMAKE\_SYSTEM\_NAME**
equals to iOS, tvOS or watchOS.

<a name="cmake_macosx_rpath"></a>

### CMAKE_MACOSX_RPATH


Whether to use rpaths on macOS and iOS.

This variable is used to initialize the **MACOSX\_RPATH** property on
all targets.

<a name="cmake_map_imported_config_ltconfiggt"></a>

### CMAKE_MAP_IMPORTED_CONFIG_&lt;CONFIG&gt;


Default value for **MAP\_IMPORTED\_CONFIG\_&lt;CONFIG&gt;** of targets.

This variable is used to initialize the
**MAP\_IMPORTED\_CONFIG\_&lt;CONFIG&gt;** property on all the targets.  See
that target property for additional information.

<a name="cmake_module_linker_flags"></a>

### CMAKE_MODULE_LINKER_FLAGS


Linker flags to be used to create modules.

These flags will be used by the linker when creating a module.

<a name="cmake_module_linker_flags_ltconfiggt"></a>

### CMAKE_MODULE_LINKER_FLAGS_&lt;CONFIG&gt;


Flags to be used when linking a module.

Same as **CMAKE\_C\_FLAGS\_*** but used by the linker when creating modules.

<a name="cmake_module_linker_flags_ltconfiggt_init"></a>

### CMAKE_MODULE_LINKER_FLAGS_&lt;CONFIG&gt;_INIT


Value used to initialize the **CMAKE\_MODULE\_LINKER\_FLAGS\_&lt;CONFIG&gt;**
cache entry the first time a build tree is configured.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also **CMAKE\_MODULE\_LINKER\_FLAGS\_INIT**.

<a name="cmake_module_linker_flags_init"></a>

### CMAKE_MODULE_LINKER_FLAGS_INIT


Value used to initialize the **CMAKE\_MODULE\_LINKER\_FLAGS**
cache entry the first time a build tree is configured.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also the configuration-specific variable
**CMAKE\_MODULE\_LINKER\_FLAGS\_&lt;CONFIG&gt;\_INIT**.

<a name="cmake_msvcide_run_path"></a>

### CMAKE_MSVCIDE_RUN_PATH


Extra PATH locations that should be used when executing
**add\_custom\_command()** or **add\_custom\_target()** when using the
**Visual Studio 9 2008** (or above) generator. This allows
for running commands and using dll’s that the IDE environment is not aware of.

If not set explicitly the value is initialized by the **CMAKE\_MSVCIDE\_RUN\_PATH**
environment variable, if set, and otherwise left empty.

<a name="cmake_msvc_runtime_library"></a>

### CMAKE_MSVC_RUNTIME_LIBRARY


Select the MSVC runtime library for use by compilers targeting the MSVC ABI.
This variable is used to initialize the **MSVC\_RUNTIME\_LIBRARY**
property on all targets as they are created.  It is also propagated by
calls to the **try\_compile()** command into the test project.

The allowed values are:
.INDENT 0.0

* <b>**MultiThreaded**</b>  
  Compile with **-MT** or equivalent flag(s) to use a multi-threaded
  statically-linked runtime library.
* <b>**MultiThreadedDLL**</b>  
  Compile with **-MD** or equivalent flag(s) to use a multi-threaded
  dynamically-linked runtime library.
* <b>**MultiThreadedDebug**</b>  
  Compile with **-MTd** or equivalent flag(s) to use a multi-threaded
  statically-linked runtime library.
* <b>**MultiThreadedDebugDLL**</b>  
  Compile with **-MDd** or equivalent flag(s) to use a multi-threaded
  dynamically-linked runtime library.
  .UNINDENT

The value is ignored on non-MSVC compilers but an unsupported value will
be rejected as an error when using a compiler targeting the MSVC ABI.

The value may also be the empty string (**""**) in which case no runtime
library selection flag will be added explicitly by CMake.  Note that with
Visual Studio Generators the native build system may choose to
add its own default runtime library selection flag.

Use **generator expressions** to
support per-configuration specification.  For example, the code:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    .ft P
.UNINDENT
.UNINDENT

selects for all following targets a multi-threaded statically-linked runtime
library with or without debug information depending on the configuration.

If this variable is not set then the **MSVC\_RUNTIME\_LIBRARY** target
property will not be set automatically.  If that property is not set then
CMake uses the default value **MultiThreaded$&lt;$&lt;CONFIG:Debug&gt;:Debug&gt;DLL**
to select a MSVC runtime library.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This variable has effect only when policy **CMP0091** is set to **NEW**
prior to the first **project()** or **enable\_language()** command
that enables a language using a compiler targeting the MSVC ABI.
.UNINDENT
.UNINDENT

<a name="cmake_ninja_output_path_prefix"></a>

### CMAKE_NINJA_OUTPUT_PATH_PREFIX


Set output files path prefix for the **Ninja** generator.

Every output files listed in the generated **build.ninja** will be
prefixed by the contents of this variable (a trailing slash is
appended if missing).  This is useful when the generated ninja file is
meant to be embedded as a **subninja** file into a _super_ ninja
project.  For example, a ninja build file generated with a command
like:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cd top-build-dir/sub &&
    cmake -G Ninja -DCMAKE_NINJA_OUTPUT_PATH_PREFIX=sub/ path/to/source
    .ft P
.UNINDENT
.UNINDENT

can be embedded in **top-build-dir/build.ninja** with a directive like
this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    subninja sub/build.ninja
    .ft P
.UNINDENT
.UNINDENT

The **auto-regeneration** rule in **top-build-dir/build.ninja** must have an
order-only dependency on **sub/build.ninja**.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
When **CMAKE\_NINJA\_OUTPUT\_PATH\_PREFIX** is set, the project generated
by CMake cannot be used as a standalone project.  No default targets
are specified.
.UNINDENT
.UNINDENT

<a name="cmake_no_builtin_chrpath"></a>

### CMAKE_NO_BUILTIN_CHRPATH


Do not use the builtin ELF editor to fix RPATHs on installation.

When an ELF binary needs to have a different RPATH after installation
than it does in the build tree, CMake uses a builtin editor to change
the RPATH in the installed copy.  If this variable is set to true then
CMake will relink the binary before installation instead of using its
builtin editor.

<a name="cmake_no_system_from_imported"></a>

### CMAKE_NO_SYSTEM_FROM_IMPORTED


Default value for **NO\_SYSTEM\_FROM\_IMPORTED** of targets.

This variable is used to initialize the **NO\_SYSTEM\_FROM\_IMPORTED**
property on all the targets.  See that target property for additional
information.

<a name="cmake_osx_architectures"></a>

### CMAKE_OSX_ARCHITECTURES


Target specific architectures for macOS and iOS.

This variable is used to initialize the **OSX\_ARCHITECTURES**
property on each target as it is created.  See that target property
for additional information.

The value of this variable should be set prior to the first
**project()** or **enable\_language()** command invocation
because it may influence configuration of the toolchain and flags.
It is intended to be set locally by the user creating a build tree.
This variable should be set as a **CACHE** entry (or else CMake may
remove it while initializing a cache entry of the same name).

Despite the **OSX** part in the variable name(s) they apply also to
other SDKs than macOS like iOS, tvOS, or watchOS.

This variable is ignored on platforms other than Apple.

<a name="cmake_osx_deployment_target"></a>

### CMAKE_OSX_DEPLOYMENT_TARGET


Specify the minimum version of the target platform (e.g. macOS or iOS)
on which the target binaries are to be deployed.  CMake uses this
variable value for the **-mmacosx-version-min** flag or their respective
target platform equivalents.  For older Xcode versions that shipped
multiple macOS SDKs this variable also helps to choose the SDK in case
**CMAKE\_OSX\_SYSROOT** is unset.

If not set explicitly the value is initialized by the
**MACOSX\_DEPLOYMENT\_TARGET** environment variable, if set,
and otherwise computed based on the host platform.

The value of this variable should be set prior to the first
**project()** or **enable\_language()** command invocation
because it may influence configuration of the toolchain and flags.
It is intended to be set locally by the user creating a build tree.
This variable should be set as a **CACHE** entry (or else CMake may
remove it while initializing a cache entry of the same name).

Despite the **OSX** part in the variable name(s) they apply also to
other SDKs than macOS like iOS, tvOS, or watchOS.

This variable is ignored on platforms other than Apple.

<a name="cmake_osx_sysroot"></a>

### CMAKE_OSX_SYSROOT


Specify the location or name of the macOS platform SDK to be used.
CMake uses this value to compute the value of the **-isysroot** flag
or equivalent and to help the **find\_*** commands locate files in
the SDK.

If not set explicitly the value is initialized by the **SDKROOT**
environment variable, if set, and otherwise computed based on the
**CMAKE\_OSX\_DEPLOYMENT\_TARGET** or the host platform.

The value of this variable should be set prior to the first
**project()** or **enable\_language()** command invocation
because it may influence configuration of the toolchain and flags.
It is intended to be set locally by the user creating a build tree.
This variable should be set as a **CACHE** entry (or else CMake may
remove it while initializing a cache entry of the same name).

Despite the **OSX** part in the variable name(s) they apply also to
other SDKs than macOS like iOS, tvOS, or watchOS.

This variable is ignored on platforms other than Apple.

<a name="cmake_pdb_output_directory"></a>

### CMAKE_PDB_OUTPUT_DIRECTORY


Output directory for MS debug symbol **.pdb** files generated by the
linker for executable and shared library targets.

This variable is used to initialize the **PDB\_OUTPUT\_DIRECTORY**
property on all the targets.  See that target property for additional
information.

<a name="cmake_pdb_output_directory_ltconfiggt"></a>

### CMAKE_PDB_OUTPUT_DIRECTORY_&lt;CONFIG&gt;


Per-configuration output directory for MS debug symbol **.pdb** files
generated by the linker for executable and shared library targets.

This is a per-configuration version of **CMAKE\_PDB\_OUTPUT\_DIRECTORY**.
This variable is used to initialize the
**PDB\_OUTPUT\_DIRECTORY\_&lt;CONFIG&gt;**
property on all the targets.  See that target property for additional
information.

<a name="cmake_position_independent_code"></a>

### CMAKE_POSITION_INDEPENDENT_CODE


Default value for **POSITION\_INDEPENDENT\_CODE** of targets.

This variable is used to initialize the
**POSITION\_INDEPENDENT\_CODE** property on all the targets.
See that target property for additional information.  If set, it’s
value is also used by the **try\_compile()** command.

<a name="cmake_runtime_output_directory"></a>

### CMAKE_RUNTIME_OUTPUT_DIRECTORY


Where to put all the RUNTIME
target files when built.

This variable is used to initialize the **RUNTIME\_OUTPUT\_DIRECTORY**
property on all the targets.  See that target property for additional
information.

<a name="cmake_runtime_output_directory_ltconfiggt"></a>

### CMAKE_RUNTIME_OUTPUT_DIRECTORY_&lt;CONFIG&gt;


Where to put all the RUNTIME
target files when built for a specific configuration.

This variable is used to initialize the
**RUNTIME\_OUTPUT\_DIRECTORY\_&lt;CONFIG&gt;** property on all the targets.
See that target property for additional information.

<a name="cmake_shared_linker_flags"></a>

### CMAKE_SHARED_LINKER_FLAGS


Linker flags to be used to create shared libraries.

These flags will be used by the linker when creating a shared library.

<a name="cmake_shared_linker_flags_ltconfiggt"></a>

### CMAKE_SHARED_LINKER_FLAGS_&lt;CONFIG&gt;


Flags to be used when linking a shared library.

Same as **CMAKE\_C\_FLAGS\_*** but used by the linker when creating shared
libraries.

<a name="cmake_shared_linker_flags_ltconfiggt_init"></a>

### CMAKE_SHARED_LINKER_FLAGS_&lt;CONFIG&gt;_INIT


Value used to initialize the **CMAKE\_SHARED\_LINKER\_FLAGS\_&lt;CONFIG&gt;**
cache entry the first time a build tree is configured.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also **CMAKE\_SHARED\_LINKER\_FLAGS\_INIT**.

<a name="cmake_shared_linker_flags_init"></a>

### CMAKE_SHARED_LINKER_FLAGS_INIT


Value used to initialize the **CMAKE\_SHARED\_LINKER\_FLAGS**
cache entry the first time a build tree is configured.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also the configuration-specific variable
**CMAKE\_SHARED\_LINKER\_FLAGS\_&lt;CONFIG&gt;\_INIT**.

<a name="cmake_skip_build_rpath"></a>

### CMAKE_SKIP_BUILD_RPATH


Do not include RPATHs in the build tree.

Normally CMake uses the build tree for the RPATH when building
executables etc on systems that use RPATH.  When the software is
installed the executables etc are relinked by CMake to have the
install RPATH.  If this variable is set to true then the software is
always built with no RPATH.

<a name="cmake_skip_install_rpath"></a>

### CMAKE_SKIP_INSTALL_RPATH


Do not include RPATHs in the install tree.

Normally CMake uses the build tree for the RPATH when building
executables etc on systems that use RPATH.  When the software is
installed the executables etc are relinked by CMake to have the
install RPATH.  If this variable is set to true then the software is
always installed without RPATH, even if RPATH is enabled when
building.  This can be useful for example to allow running tests from
the build directory with RPATH enabled before the installation step.
To omit RPATH in both the build and install steps, use
**CMAKE\_SKIP\_RPATH** instead.

<a name="cmake_static_linker_flags"></a>

### CMAKE_STATIC_LINKER_FLAGS


Flags to be used to create static libraries.  These flags will be passed
to the archiver when creating a static library.

See also **CMAKE\_STATIC\_LINKER\_FLAGS\_&lt;CONFIG&gt;**.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Static libraries do not actually link.  They are essentially archives
of object files.  The use of the name “linker” in the name of this
variable is kept for compatibility.
.UNINDENT
.UNINDENT

<a name="cmake_static_linker_flags_ltconfiggt"></a>

### CMAKE_STATIC_LINKER_FLAGS_&lt;CONFIG&gt;


Flags to be used to create static libraries.  These flags will be passed
to the archiver when creating a static library in the **&lt;CONFIG&gt;**
configuration.

See also **CMAKE\_STATIC\_LINKER\_FLAGS**.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Static libraries do not actually link.  They are essentially archives
of object files.  The use of the name “linker” in the name of this
variable is kept for compatibility.
.UNINDENT
.UNINDENT

<a name="cmake_static_linker_flags_ltconfiggt_init"></a>

### CMAKE_STATIC_LINKER_FLAGS_&lt;CONFIG&gt;_INIT


Value used to initialize the **CMAKE\_STATIC\_LINKER\_FLAGS\_&lt;CONFIG&gt;**
cache entry the first time a build tree is configured.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also **CMAKE\_STATIC\_LINKER\_FLAGS\_INIT**.

<a name="cmake_static_linker_flags_init"></a>

### CMAKE_STATIC_LINKER_FLAGS_INIT


Value used to initialize the **CMAKE\_STATIC\_LINKER\_FLAGS**
cache entry the first time a build tree is configured.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also the configuration-specific variable
**CMAKE\_STATIC\_LINKER\_FLAGS\_&lt;CONFIG&gt;\_INIT**.

<a name="cmake_try_compile_configuration"></a>

### CMAKE_TRY_COMPILE_CONFIGURATION


Build configuration used for **try\_compile()** and **try\_run()**
projects.

Projects built by **try\_compile()** and **try\_run()** are built
synchronously during the CMake configuration step.  Therefore a specific build
configuration must be chosen even if the generated build system
supports multiple configurations.

<a name="cmake_try_compile_platform_variables"></a>

### CMAKE_TRY_COMPILE_PLATFORM_VARIABLES


List of variables that the **try\_compile()** command source file signature
must propagate into the test project in order to target the same platform as
the host project.

This variable should not be set by project code.  It is meant to be set by
CMake’s platform information modules for the current toolchain, or by a
toolchain file when used with **CMAKE\_TOOLCHAIN\_FILE**.

Variables meaningful to CMake, such as **CMAKE\_&lt;LANG&gt;\_FLAGS**, are
propagated automatically.  The **CMAKE\_TRY\_COMPILE\_PLATFORM\_VARIABLES**
variable may be set to pass custom variables meaningful to a toolchain file.
For example, a toolchain file may contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME ...)
    set(CMAKE_TRY_COMPILE_PLATFORM_VARIABLES MY_CUSTOM_VARIABLE)
    # ... use MY_CUSTOM_VARIABLE ...
    .ft P
.UNINDENT
.UNINDENT

If a user passes **-DMY\_CUSTOM\_VARIABLE=SomeValue** to CMake then this
setting will be made visible to the toolchain file both for the main
project and for test projects generated by the **try\_compile()**
command source file signature.

<a name="cmake_try_compile_target_type"></a>

### CMAKE_TRY_COMPILE_TARGET_TYPE


Type of target generated for **try\_compile()** calls using the
source file signature.  Valid values are:
.INDENT 0.0

* <b>**EXECUTABLE**</b>  
  Use **add\_executable()** to name the source file in the
  generated project.  This is the default if no value is given.
* <b>**STATIC\_LIBRARY**</b>  
  Use **add\_library()** with the **STATIC** option to name the
  source file in the generated project.  This avoids running the
  linker and is intended for use with cross-compiling toolchains
  that cannot link without custom flags or linker scripts.
  .UNINDENT

<a name="cmake_unity_build"></a>

### CMAKE_UNITY_BUILD


This variable is used to initialize the **UNITY\_BUILD**
property of targets when they are created.  Setting it to true
enables batch compilation of multiple sources within each target.
This feature is known as a _Unity_ or _Jumbo_ build.

Projects should not set this variable, it is intended as a developer
control to be set on the **cmake(1)** command line or other
equivalent methods.  The developer must have the ability to enable or
disable unity builds according to the capabilities of their own machine
and compiler.

By default, this variable is not set, which will result in unity builds
being disabled.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This option currently does not work well in combination with
the **CMAKE\_EXPORT\_COMPILE\_COMMANDS** variable.
.UNINDENT
.UNINDENT

<a name="cmake_unity_build_batch_size"></a>

### CMAKE_UNITY_BUILD_BATCH_SIZE


This variable is used to initialize the **UNITY\_BUILD\_BATCH\_SIZE**
property of targets when they are created.  It specifies the default upper
limit on the number of source files that may be combined in any one unity
source file when unity builds are enabled for a target.

<a name="cmake_use_relative_paths"></a>

### CMAKE_USE_RELATIVE_PATHS


This variable has no effect.  The partially implemented effect it
had in previous releases was removed in CMake 3.4.

<a name="cmake_visibility_inlines_hidden"></a>

### CMAKE_VISIBILITY_INLINES_HIDDEN


Default value for the **VISIBILITY\_INLINES\_HIDDEN** target
property when a target is created.

<a name="cmake_vs_globals"></a>

### CMAKE_VS_GLOBALS


List of **Key=Value** records to be set per target as target properties
**VS\_GLOBAL\_&lt;variable&gt;** with **variable=Key** and value **Value**.

For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_VS_GLOBALS
      "DefaultLanguage=en-US"
      "MinimumVisualStudioVersion=14.0"
      )
    .ft P
.UNINDENT
.UNINDENT

will set properties **VS\_GLOBAL\_DefaultLanguage** to **en-US** and
**VS\_GLOBAL\_MinimumVisualStudioVersion** to **14.0** for all targets
(except for **INTERFACE** libraries).

This variable is meant to be set by a
**toolchain file**.

<a name="cmake_vs_include_install_to_default_build"></a>

### CMAKE_VS_INCLUDE_INSTALL_TO_DEFAULT_BUILD


Include **INSTALL** target to default build.

In Visual Studio solution, by default the **INSTALL** target will not be part
of the default build. Setting this variable will enable the **INSTALL** target
to be part of the default build.

<a name="cmake_vs_include_package_to_default_build"></a>

### CMAKE_VS_INCLUDE_PACKAGE_TO_DEFAULT_BUILD


Include **PACKAGE** target to default build.

In Visual Studio solution, by default the **PACKAGE** target will not be part
of the default build. Setting this variable will enable the **PACKAGE** target
to be part of the default build.

<a name="cmake_vs_just_my_code_debugging"></a>

### CMAKE_VS_JUST_MY_CODE_DEBUGGING


Enable Just My Code with Visual Studio debugger.

This variable is used to initialize the **VS\_JUST\_MY\_CODE\_DEBUGGING**
property on all targets when they are created.  See that target property for
additional information.

<a name="cmake_vs_sdk_exclude_directories"></a>

### CMAKE_VS_SDK_EXCLUDE_DIRECTORIES


This variable allows to override Visual Studio default Exclude Directories.

<a name="cmake_vs_sdk_executable_directories"></a>

### CMAKE_VS_SDK_EXECUTABLE_DIRECTORIES


This variable allows to override Visual Studio default Executable Directories.

<a name="cmake_vs_sdk_include_directories"></a>

### CMAKE_VS_SDK_INCLUDE_DIRECTORIES


This variable allows to override Visual Studio default Include Directories.

<a name="cmake_vs_sdk_library_directories"></a>

### CMAKE_VS_SDK_LIBRARY_DIRECTORIES


This variable allows to override Visual Studio default Library Directories.

<a name="cmake_vs_sdk_library_winrt_directories"></a>

### CMAKE_VS_SDK_LIBRARY_WINRT_DIRECTORIES


This variable allows to override Visual Studio default Library WinRT
Directories.

<a name="cmake_vs_sdk_reference_directories"></a>

### CMAKE_VS_SDK_REFERENCE_DIRECTORIES


This variable allows to override Visual Studio default Reference Directories.

<a name="cmake_vs_sdk_source_directories"></a>

### CMAKE_VS_SDK_SOURCE_DIRECTORIES


This variable allows to override Visual Studio default Source Directories.

<a name="cmake_vs_winrt_by_default"></a>

### CMAKE_VS_WINRT_BY_DEFAULT


Inform Visual Studio Generators for VS 2010 and above that the
target platform enables WinRT compilation by default and it needs to
be explicitly disabled if **/ZW** or **VS\_WINRT\_COMPONENT** is
omitted (as opposed to enabling it when either of those options is
present)

This makes cmake configuration consistent in terms of WinRT among
platforms - if you did not enable the WinRT compilation explicitly, it
will be disabled (by either not enabling it or explicitly disabling it)

Note: WinRT compilation is always explicitly disabled for C language
source files, even if it is expliclty enabled for a project

This variable is meant to be set by a
**toolchain file** for such platforms.

<a name="cmake_win32_executable"></a>

### CMAKE_WIN32_EXECUTABLE


Default value for **WIN32\_EXECUTABLE** of targets.

This variable is used to initialize the **WIN32\_EXECUTABLE** property
on all the targets.  See that target property for additional information.

<a name="cmake_windows_export_all_symbols"></a>

### CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS


Default value for **WINDOWS\_EXPORT\_ALL\_SYMBOLS** target property.
This variable is used to initialize the property on each target as it is
created.

<a name="cmake_xcode_attribute_ltan-attributegt"></a>

### CMAKE_XCODE_ATTRIBUTE_&lt;an\-attribute&gt;


Set Xcode target attributes directly.

Tell the **Xcode** generator to set ‘&lt;an-attribute&gt;’ to a given value
in the generated Xcode project.  Ignored on other generators.

See the **XCODE\_ATTRIBUTE\_&lt;an-attribute&gt;** target property
to set attributes on a specific target.

Contents of **CMAKE\_XCODE\_ATTRIBUTE\_&lt;an-attribute&gt;** may use
“generator expressions” with the syntax **$&lt;...&gt;**.  See the
**cmake-generator-expressions(7)** manual for available
expressions.  See the **cmake-buildsystem(7)** manual
for more on defining buildsystem properties.

<a name="executable_output_path"></a>

### EXECUTABLE_OUTPUT_PATH


Old executable location variable.

The target property **RUNTIME\_OUTPUT\_DIRECTORY** supercedes this
variable for a target if it is set.  Executable targets are otherwise placed in
this directory.

<a name="library_output_path"></a>

### LIBRARY_OUTPUT_PATH


Old library location variable.

The target properties **ARCHIVE\_OUTPUT\_DIRECTORY**,
**LIBRARY\_OUTPUT\_DIRECTORY**, and **RUNTIME\_OUTPUT\_DIRECTORY**
supersede this variable for a target if they are set.  Library targets are
otherwise placed in this directory.

<a name="variables-for-languages"></a>

# Variables for Languages


<a name="cmake_compiler_is_gnucc"></a>

### CMAKE_COMPILER_IS_GNUCC


True if the **C** compiler is GNU.
Use **CMAKE\_C\_COMPILER\_ID** instead.

<a name="cmake_compiler_is_gnucxx"></a>

### CMAKE_COMPILER_IS_GNUCXX


True if the C++ (**CXX**) compiler is GNU.
Use **CMAKE\_CXX\_COMPILER\_ID** instead.

<a name="cmake_compiler_is_gnug77"></a>

### CMAKE_COMPILER_IS_GNUG77


True if the **Fortran** compiler is GNU.
Use **CMAKE\_Fortran\_COMPILER\_ID** instead.

<a name="cmake_cuda_compile_features"></a>

### CMAKE_CUDA_COMPILE_FEATURES


List of features known to the CUDA compiler

These features are known to be available for use with the CUDA compiler. This
list is a subset of the features listed in the
**CMAKE\_CUDA\_KNOWN\_FEATURES** global property.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_cuda_host_compiler"></a>

### CMAKE_CUDA_HOST_COMPILER


Executable to use when compiling host code when compiling **CUDA** language
files. Maps to the **nvcc -ccbin** option.  Will only be used by CMake on the first
configuration to determine a valid host compiler for **CUDA**. After a valid
host compiler has been found, this value is read-only.  This variable takes
priority over the **CUDAHOSTCXX** environment variable.

<a name="cmake_cuda_extensions"></a>

### CMAKE_CUDA_EXTENSIONS


Default value for **CUDA\_EXTENSIONS** property of targets.

This variable is used to initialize the **CUDA\_EXTENSIONS**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_cuda_standard"></a>

### CMAKE_CUDA_STANDARD


Default value for **CUDA\_STANDARD** property of targets.

This variable is used to initialize the **CUDA\_STANDARD**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_cuda_standard_required"></a>

### CMAKE_CUDA_STANDARD_REQUIRED


Default value for **CUDA\_STANDARD\_REQUIRED** property of targets.

This variable is used to initialize the **CUDA\_STANDARD\_REQUIRED**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_cuda_toolkit_include_directories"></a>

### CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES


When the **CUDA** language has been enabled, this provides a
semicolon-separated list of include directories provided
by the CUDA Toolkit.  The value may be useful for C++ source files
to include CUDA headers.

<a name="cmake_cxx_compile_features"></a>

### CMAKE_CXX_COMPILE_FEATURES


List of features known to the C++ compiler

These features are known to be available for use with the C++ compiler. This
list is a subset of the features listed in the
**CMAKE\_CXX\_KNOWN\_FEATURES** global property.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_cxx_extensions"></a>

### CMAKE_CXX_EXTENSIONS


Default value for **CXX\_EXTENSIONS** property of targets.

This variable is used to initialize the **CXX\_EXTENSIONS**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_cxx_standard"></a>

### CMAKE_CXX_STANDARD


Default value for **CXX\_STANDARD** property of targets.

This variable is used to initialize the **CXX\_STANDARD**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_cxx_standard_required"></a>

### CMAKE_CXX_STANDARD_REQUIRED


Default value for **CXX\_STANDARD\_REQUIRED** property of targets.

This variable is used to initialize the **CXX\_STANDARD\_REQUIRED**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_c_compile_features"></a>

### CMAKE_C_COMPILE_FEATURES


List of features known to the C compiler

These features are known to be available for use with the C compiler. This
list is a subset of the features listed in the
**CMAKE\_C\_KNOWN\_FEATURES** global property.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_c_extensions"></a>

### CMAKE_C_EXTENSIONS


Default value for **C\_EXTENSIONS** property of targets.

This variable is used to initialize the **C\_EXTENSIONS**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_c_standard"></a>

### CMAKE_C_STANDARD


Default value for **C\_STANDARD** property of targets.

This variable is used to initialize the **C\_STANDARD**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_c_standard_required"></a>

### CMAKE_C_STANDARD_REQUIRED


Default value for **C\_STANDARD\_REQUIRED** property of targets.

This variable is used to initialize the **C\_STANDARD\_REQUIRED**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_fortran_moddir_default"></a>

### CMAKE_Fortran_MODDIR_DEFAULT


Fortran default module output directory.

Most Fortran compilers write **.mod** files to the current working
directory.  For those that do not, this is set to **.** and used when
the **Fortran\_MODULE\_DIRECTORY** target property is not set.

<a name="cmake_fortran_moddir_flag"></a>

### CMAKE_Fortran_MODDIR_FLAG


Fortran flag for module output directory.

This stores the flag needed to pass the value of the
**Fortran\_MODULE\_DIRECTORY** target property to the compiler.

<a name="cmake_fortran_modout_flag"></a>

### CMAKE_Fortran_MODOUT_FLAG


Fortran flag to enable module output.

Most Fortran compilers write **.mod** files out by default.  For others,
this stores the flag needed to enable module output.

<a name="cmake_ltlanggt_android_toolchain_machine"></a>

### CMAKE_&lt;LANG&gt;_ANDROID_TOOLCHAIN_MACHINE


When Cross Compiling for Android this variable contains the
toolchain binutils machine name (e.g. **gcc -dumpmachine**).  The
binutils typically have a **&lt;machine&gt;-** prefix on their name.

See also **CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_PREFIX**
and **CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_SUFFIX**.

<a name="cmake_ltlanggt_android_toolchain_prefix"></a>

### CMAKE_&lt;LANG&gt;_ANDROID_TOOLCHAIN_PREFIX


When Cross Compiling for Android this variable contains the absolute
path prefixing the toolchain GNU compiler and its binutils.

See also **CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_SUFFIX**
and **CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_MACHINE**.

For example, the path to the linker is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ${CMAKE_CXX_ANDROID_TOOLCHAIN_PREFIX}ld${CMAKE_CXX_ANDROID_TOOLCHAIN_SUFFIX}
    .ft P
.UNINDENT
.UNINDENT

<a name="cmake_ltlanggt_android_toolchain_suffix"></a>

### CMAKE_&lt;LANG&gt;_ANDROID_TOOLCHAIN_SUFFIX


When Cross Compiling for Android this variable contains the
host platform suffix of the toolchain GNU compiler and its binutils.

See also **CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_PREFIX**
and **CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_MACHINE**.

<a name="cmake_ltlanggt_archive_append"></a>

### CMAKE_&lt;LANG&gt;_ARCHIVE_APPEND


Rule variable to append to a static archive.

This is a rule variable that tells CMake how to append to a static
archive.  It is used in place of **CMAKE\_&lt;LANG&gt;\_CREATE\_STATIC\_LIBRARY**
on some platforms in order to support large object counts.  See also
**CMAKE\_&lt;LANG&gt;\_ARCHIVE\_CREATE** and
**CMAKE\_&lt;LANG&gt;\_ARCHIVE\_FINISH**.

<a name="cmake_ltlanggt_archive_create"></a>

### CMAKE_&lt;LANG&gt;_ARCHIVE_CREATE


Rule variable to create a new static archive.

This is a rule variable that tells CMake how to create a static
archive.  It is used in place of **CMAKE\_&lt;LANG&gt;\_CREATE\_STATIC\_LIBRARY**
on some platforms in order to support large object counts.  See also
**CMAKE\_&lt;LANG&gt;\_ARCHIVE\_APPEND** and
**CMAKE\_&lt;LANG&gt;\_ARCHIVE\_FINISH**.

<a name="cmake_ltlanggt_archive_finish"></a>

### CMAKE_&lt;LANG&gt;_ARCHIVE_FINISH


Rule variable to finish an existing static archive.

This is a rule variable that tells CMake how to finish a static
archive.  It is used in place of **CMAKE\_&lt;LANG&gt;\_CREATE\_STATIC\_LIBRARY**
on some platforms in order to support large object counts.  See also
**CMAKE\_&lt;LANG&gt;\_ARCHIVE\_CREATE** and
**CMAKE\_&lt;LANG&gt;\_ARCHIVE\_APPEND**.

<a name="cmake_ltlanggt_compiler"></a>

### CMAKE_&lt;LANG&gt;_COMPILER


The full path to the compiler for **LANG**.

This is the command that will be used as the **&lt;LANG&gt;** compiler.  Once
set, you can not change this variable.

<a name="cmake_ltlanggt_compiler_external_toolchain"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_EXTERNAL_TOOLCHAIN


The external toolchain for cross-compiling, if supported.

Some compiler toolchains do not ship their own auxiliary utilities such as
archivers and linkers.  The compiler driver may support a command-line argument
to specify the location of such tools.
**CMAKE\_&lt;LANG&gt;\_COMPILER\_EXTERNAL\_TOOLCHAIN** may be set to a path to
the external toolchain and will be passed to the compiler driver if supported.

This variable may only be set in a toolchain file specified by
the **CMAKE\_TOOLCHAIN\_FILE** variable.

<a name="cmake_ltlanggt_compiler_id"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_ID


Compiler identification string.

A short string unique to the compiler vendor.  Possible values
include:
.INDENT 0.0
.INDENT 3.5

    .ft C
    Absoft = Absoft Fortran (absoft.com)
    ADSP = Analog VisualDSP++ (analog.com)
    AppleClang = Apple Clang (apple.com)
    ARMCC = ARM Compiler (arm.com)
    ARMClang = ARM Compiler based on Clang (arm.com)
    Bruce = Bruce C Compiler
    CCur = Concurrent Fortran (ccur.com)
    Clang = LLVM Clang (clang.llvm.org)
    Cray = Cray Compiler (cray.com)
    Embarcadero, Borland = Embarcadero (embarcadero.com)
    Flang = Flang LLVM Fortran Compiler
    G95 = G95 Fortran (g95.org)
    GNU = GNU Compiler Collection (gcc.gnu.org)
    GHS = Green Hills Software (www.ghs.com)
    HP = Hewlett-Packard Compiler (hp.com)
    IAR = IAR Systems (iar.com)
    Intel = Intel Compiler (intel.com)
    MSVC = Microsoft Visual Studio (microsoft.com)
    NVIDIA = NVIDIA CUDA Compiler (nvidia.com)
    OpenWatcom = Open Watcom (openwatcom.org)
    PGI = The Portland Group (pgroup.com)
    PathScale = PathScale (pathscale.com)
    SDCC = Small Device C Compiler (sdcc.sourceforge.net)
    SunPro = Oracle Solaris Studio (oracle.com)
    TI = Texas Instruments (ti.com)
    TinyCC = Tiny C Compiler (tinycc.org)
    XL, VisualAge, zOS = IBM XL (ibm.com)
    XLClang = IBM Clang-based XL (ibm.com)
    .ft P
.UNINDENT
.UNINDENT

This variable is not guaranteed to be defined for all compilers or
languages.

<a name="cmake_ltlanggt_compiler_loaded"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_LOADED


Defined to true if the language is enabled.

When language **&lt;LANG&gt;** is enabled by **project()** or
**enable\_language()** this variable is defined to **1**.

<a name="cmake_ltlanggt_compiler_predefines_command"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_PREDEFINES_COMMAND


Command that outputs the compiler pre definitions.

See **AUTOMOC** which uses
_CMAKE\_CXX\_COMPILER\_PREDEFINES\_COMMAND_
to generate the **AUTOMOC\_COMPILER\_PREDEFINES**.

<a name="cmake_ltlanggt_compiler_target"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_TARGET


The target for cross-compiling, if supported.

Some compiler drivers are inherently cross-compilers, such as clang and
QNX qcc. These compiler drivers support a command-line argument to specify
the target to cross-compile for.

This variable may only be set in a toolchain file specified by
the **CMAKE\_TOOLCHAIN\_FILE** variable.

<a name="cmake_ltlanggt_compiler_version"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_VERSION


Compiler version string.

Compiler version in major[.minor[.patch[.tweak]]] format.  This
variable is not guaranteed to be defined for all compilers or
languages.

For example **CMAKE\_C\_COMPILER\_VERSION** and
**CMAKE\_CXX\_COMPILER\_VERSION** might indicate the respective C and C++
compiler version.

<a name="cmake_ltlanggt_compile_object"></a>

### CMAKE_&lt;LANG&gt;_COMPILE_OBJECT


Rule variable to compile a single object file.

This is a rule variable that tells CMake how to compile a single
object file for the language **&lt;LANG&gt;**.

<a name="cmake_ltlanggt_create_shared_library"></a>

### CMAKE_&lt;LANG&gt;_CREATE_SHARED_LIBRARY


Rule variable to create a shared library.

This is a rule variable that tells CMake how to create a shared
library for the language **&lt;LANG&gt;**.  This rule variable is a **;** delimited
list of commands to run to perform the linking step.

<a name="cmake_ltlanggt_create_shared_module"></a>

### CMAKE_&lt;LANG&gt;_CREATE_SHARED_MODULE


Rule variable to create a shared module.

This is a rule variable that tells CMake how to create a shared
library for the language **&lt;LANG&gt;**.  This rule variable is a **;** delimited
list of commands to run.

<a name="cmake_ltlanggt_create_static_library"></a>

### CMAKE_&lt;LANG&gt;_CREATE_STATIC_LIBRARY


Rule variable to create a static library.

This is a rule variable that tells CMake how to create a static
library for the language **&lt;LANG&gt;**.

<a name="cmake_ltlanggt_flags"></a>

### CMAKE_&lt;LANG&gt;_FLAGS


Flags for all build types.

**&lt;LANG&gt;** flags used regardless of the value of **CMAKE\_BUILD\_TYPE**.

This is initialized for each language from environment variables:
.INDENT 0.0

* ·  
  **CMAKE\_C\_FLAGS**:
  Initialized by the **CFLAGS** environment variable.
* ·  
  **CMAKE\_CXX\_FLAGS**:
  Initialized by the **CXXFLAGS** environment variable.
* ·  
  **CMAKE\_CUDA\_FLAGS**:
  Initialized by the **CUDAFLAGS** environment variable.
* ·  
  **CMAKE\_Fortran\_FLAGS**:
  Initialized by the **FFLAGS** environment variable.
  .UNINDENT

<a name="cmake_ltlanggt_flags_ltconfiggt"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_&lt;CONFIG&gt;


Flags for language **&lt;LANG&gt;** when building for the **&lt;CONFIG&gt;** configuration.

<a name="cmake_ltlanggt_flags_ltconfiggt_init"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_&lt;CONFIG&gt;_INIT


Value used to initialize the **CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** cache
entry the first time a build tree is configured for language **&lt;LANG&gt;**.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also **CMAKE\_&lt;LANG&gt;\_FLAGS\_INIT**.

<a name="cmake_ltlanggt_flags_debug"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_DEBUG


This variable is the **Debug** variant of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** variable.

<a name="cmake_ltlanggt_flags_debug_init"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_DEBUG_INIT


This variable is the **Debug** variant of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;\_INIT** variable.

<a name="cmake_ltlanggt_flags_init"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_INIT


Value used to initialize the **CMAKE\_&lt;LANG&gt;\_FLAGS** cache entry
the first time a build tree is configured for language **&lt;LANG&gt;**.
This variable is meant to be set by a **toolchain file**.  CMake may prepend or append content to
the value based on the environment and target platform.

See also the configuration-specific
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;\_INIT** variable.

<a name="cmake_ltlanggt_flags_minsizerel"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_MINSIZEREL


This variable is the **MinSizeRel** variant of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** variable.

<a name="cmake_ltlanggt_flags_minsizerel_init"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_MINSIZEREL_INIT


This variable is the **MinSizeRel** variant of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;\_INIT** variable.

<a name="cmake_ltlanggt_flags_release"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_RELEASE


This variable is the **Release** variant of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** variable.

<a name="cmake_ltlanggt_flags_release_init"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_RELEASE_INIT


This variable is the **Release** variant of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;\_INIT** variable.

<a name="cmake_ltlanggt_flags_relwithdebinfo"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_RELWITHDEBINFO


This variable is the **RelWithDebInfo** variant of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** variable.

<a name="cmake_ltlanggt_flags_relwithdebinfo_init"></a>

### CMAKE_&lt;LANG&gt;_FLAGS_RELWITHDEBINFO_INIT


This variable is the **RelWithDebInfo** variant of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;\_INIT** variable.

<a name="cmake_ltlanggt_ignore_extensions"></a>

### CMAKE_&lt;LANG&gt;_IGNORE_EXTENSIONS


File extensions that should be ignored by the build.

This is a list of file extensions that may be part of a project for a
given language but are not compiled.

<a name="cmake_ltlanggt_implicit_include_directories"></a>

### CMAKE_&lt;LANG&gt;_IMPLICIT_INCLUDE_DIRECTORIES


Directories implicitly searched by the compiler for header files.

CMake does not explicitly specify these directories on compiler
command lines for language **&lt;LANG&gt;**.  This prevents system include
directories from being treated as user include directories on some
compilers, which is important for **C**, **CXX**, and **CUDA** to
avoid overriding standard library headers.

This value is not used for **Fortran** because it has no standard
library headers and some compilers do not search their implicit
include directories for module **.mod** files.

<a name="cmake_ltlanggt_implicit_link_directories"></a>

### CMAKE_&lt;LANG&gt;_IMPLICIT_LINK_DIRECTORIES


Implicit linker search path detected for language **&lt;LANG&gt;**.

Compilers typically pass directories containing language runtime
libraries and default library search paths when they invoke a linker.
These paths are implicit linker search directories for the compiler’s
language.  CMake automatically detects these directories for each
language and reports the results in this variable.

Some toolchains read implicit directories from an environment variable such as
**LIBRARY\_PATH**.  If using such an environment variable, keep its value
consistent when operating in a given build tree because CMake saves the value
detected when first creating a build tree.

If policy **CMP0060** is not set to **NEW**, then when a library in one
of these directories is given by full path to **target\_link\_libraries()**
CMake will generate the **-l&lt;name&gt;** form on link lines for historical
purposes.

<a name="cmake_ltlanggt_implicit_link_framework_directories"></a>

### CMAKE_&lt;LANG&gt;_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES


Implicit linker framework search path detected for language **&lt;LANG&gt;**.

These paths are implicit linker framework search directories for the
compiler’s language.  CMake automatically detects these directories
for each language and reports the results in this variable.

<a name="cmake_ltlanggt_implicit_link_libraries"></a>

### CMAKE_&lt;LANG&gt;_IMPLICIT_LINK_LIBRARIES


Implicit link libraries and flags detected for language **&lt;LANG&gt;**.

Compilers typically pass language runtime library names and other
flags when they invoke a linker.  These flags are implicit link
options for the compiler’s language.  CMake automatically detects
these libraries and flags for each language and reports the results in
this variable.

<a name="cmake_ltlanggt_library_architecture"></a>

### CMAKE_&lt;LANG&gt;_LIBRARY_ARCHITECTURE


Target architecture library directory name detected for **&lt;LANG&gt;**.

If the **&lt;LANG&gt;** compiler passes to the linker an architecture-specific
system library search directory such as **&lt;prefix&gt;/lib/&lt;arch&gt;** this
variable contains the **&lt;arch&gt;** name if/as detected by CMake.

<a name="cmake_ltlanggt_linker_preference"></a>

### CMAKE_&lt;LANG&gt;_LINKER_PREFERENCE


Preference value for linker language selection.

The “linker language” for executable, shared library, and module
targets is the language whose compiler will invoke the linker.  The
**LINKER\_LANGUAGE** target property sets the language explicitly.
Otherwise, the linker language is that whose linker preference value
is highest among languages compiled and linked into the target.  See
also the **CMAKE\_&lt;LANG&gt;\_LINKER\_PREFERENCE\_PROPAGATES** variable.

<a name="cmake_ltlanggt_linker_preference_propagates"></a>

### CMAKE_&lt;LANG&gt;_LINKER_PREFERENCE_PROPAGATES


True if **CMAKE\_&lt;LANG&gt;\_LINKER\_PREFERENCE** propagates across targets.

This is used when CMake selects a linker language for a target.
Languages compiled directly into the target are always considered.  A
language compiled into static libraries linked by the target is
considered if this variable is true.

<a name="cmake_ltlanggt_linker_wrapper_flag"></a>

### CMAKE_&lt;LANG&gt;_LINKER_WRAPPER_FLAG


Defines the syntax of compiler driver option to pass options to the linker
tool. It will be used to translate the **LINKER:** prefix in the link options
(see **add\_link\_options()** and **target\_link\_options()**).

This variable holds a semicolon-separated list of tokens.
If a space (i.e. ” “) is specified as last token, flag and **LINKER:**
arguments will be specified as separate arguments to the compiler driver.
The **CMAKE\_&lt;LANG&gt;\_LINKER\_WRAPPER\_FLAG\_SEP** variable can be specified
to manage concatenation of arguments.

For example, for **Clang** we have:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set (CMAKE_C_LINKER_WRAPPER_FLAG "-Xlinker" " ")
    .ft P
.UNINDENT
.UNINDENT

Specifying **"LINKER:-z,defs"** will be transformed in
**-Xlinker -z -Xlinker defs**.

For **GNU GCC**:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set (CMAKE_C_LINKER_WRAPPER_FLAG "-Wl,")
    set (CMAKE_C_LINKER_WRAPPER_FLAG_SEP ",")
    .ft P
.UNINDENT
.UNINDENT

Specifying **"LINKER:-z,defs"** will be transformed in **-Wl,-z,defs**.

And for **SunPro**:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set (CMAKE_C_LINKER_WRAPPER_FLAG "-Qoption" "ld" " ")
    set (CMAKE_C_LINKER_WRAPPER_FLAG_SEP ",")
    .ft P
.UNINDENT
.UNINDENT

Specifying **"LINKER:-z,defs"** will be transformed in **-Qoption ld -z,defs**.

<a name="cmake_ltlanggt_linker_wrapper_flag_sep"></a>

### CMAKE_&lt;LANG&gt;_LINKER_WRAPPER_FLAG_SEP


This variable is used with **CMAKE\_&lt;LANG&gt;\_LINKER\_WRAPPER\_FLAG**
variable to format **LINKER:** prefix in the link options
(see **add\_link\_options()** and **target\_link\_options()**).

When specified, arguments of the **LINKER:** prefix will be concatenated using
this value as separator.

<a name="cmake_ltlanggt_link_executable"></a>

### CMAKE_&lt;LANG&gt;_LINK_EXECUTABLE


Rule variable to link an executable.

Rule variable to link an executable for the given language.

<a name="cmake_ltlanggt_output_extension"></a>

### CMAKE_&lt;LANG&gt;_OUTPUT_EXTENSION


Extension for the output of a compile for a single file.

This is the extension for an object file for the given **&lt;LANG&gt;**.  For
example **.obj** for C on Windows.

<a name="cmake_ltlanggt_simulate_id"></a>

### CMAKE_&lt;LANG&gt;_SIMULATE_ID


Identification string of “simulated” compiler.

Some compilers simulate other compilers to serve as drop-in
replacements.  When CMake detects such a compiler it sets this
variable to what would have been the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** for
the simulated compiler.

<a name="cmake_ltlanggt_simulate_version"></a>

### CMAKE_&lt;LANG&gt;_SIMULATE_VERSION


Version string of “simulated” compiler.

Some compilers simulate other compilers to serve as drop-in
replacements.  When CMake detects such a compiler it sets this
variable to what would have been the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION**
for the simulated compiler.

<a name="cmake_ltlanggt_sizeof_data_ptr"></a>

### CMAKE_&lt;LANG&gt;_SIZEOF_DATA_PTR


Size of pointer-to-data types for language **&lt;LANG&gt;**.

This holds the size (in bytes) of pointer-to-data types in the target
platform ABI.  It is defined for languages **C** and **CXX** (C++).

<a name="cmake_ltlanggt_source_file_extensions"></a>

### CMAKE_&lt;LANG&gt;_SOURCE_FILE_EXTENSIONS


Extensions of source files for the given language.

This is the list of extensions for a given language’s source files.

<a name="cmake_ltlanggt_standard_include_directories"></a>

### CMAKE_&lt;LANG&gt;_STANDARD_INCLUDE_DIRECTORIES


Include directories to be used for every source file compiled with
the **&lt;LANG&gt;** compiler.  This is meant for specification of system
include directories needed by the language for the current platform.
The directories always appear at the end of the include path passed
to the compiler.

This variable should not be set by project code.  It is meant to be set by
CMake’s platform information modules for the current toolchain, or by a
toolchain file when used with **CMAKE\_TOOLCHAIN\_FILE**.

See also **CMAKE\_&lt;LANG&gt;\_STANDARD\_LIBRARIES**.

<a name="cmake_ltlanggt_standard_libraries"></a>

### CMAKE_&lt;LANG&gt;_STANDARD_LIBRARIES


Libraries linked into every executable and shared library linked
for language **&lt;LANG&gt;**.  This is meant for specification of system
libraries needed by the language for the current platform.

This variable should not be set by project code.  It is meant to be set by
CMake’s platform information modules for the current toolchain, or by a
toolchain file when used with **CMAKE\_TOOLCHAIN\_FILE**.

See also **CMAKE\_&lt;LANG&gt;\_STANDARD\_INCLUDE\_DIRECTORIES**.

<a name="cmake_objc_extensions"></a>

### CMAKE_OBJC_EXTENSIONS


Default value for **OBJC\_EXTENSIONS** property of targets.

This variable is used to initialize the **OBJC\_EXTENSIONS**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_objc_standard"></a>

### CMAKE_OBJC_STANDARD


Default value for **OBJC\_STANDARD** property of targets.

This variable is used to initialize the **OBJC\_STANDARD**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_objc_standard_required"></a>

### CMAKE_OBJC_STANDARD_REQUIRED


Default value for **OBJC\_STANDARD\_REQUIRED** property of targets.

This variable is used to initialize the **OBJC\_STANDARD\_REQUIRED**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_objcxx_extensions"></a>

### CMAKE_OBJCXX_EXTENSIONS


Default value for **OBJCXX\_EXTENSIONS** property of targets.

This variable is used to initialize the **OBJCXX\_EXTENSIONS**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_objcxx_standard"></a>

### CMAKE_OBJCXX_STANDARD


Default value for **OBJCXX\_STANDARD** property of targets.

This variable is used to initialize the **OBJCXX\_STANDARD**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_objcxx_standard_required"></a>

### CMAKE_OBJCXX_STANDARD_REQUIRED


Default value for **OBJCXX\_STANDARD\_REQUIRED** property of targets.

This variable is used to initialize the **OBJCXX\_STANDARD\_REQUIRED**
property on all targets.  See that target property for additional
information.

See the **cmake-compile-features(7)** manual for information on
compile features and a list of supported compilers.

<a name="cmake_swift_language_version"></a>

### CMAKE_Swift_LANGUAGE_VERSION


Set to the Swift language version number.  If not set, the oldest legacy
version known to be available in the host Xcode version is assumed:
.INDENT 0.0

* ·  
  Swift **4.0** for Xcode 10.2 and above.
* ·  
  Swift **3.0** for Xcode 8.3 and above.
* ·  
  Swift **2.3** for Xcode 8.2 and below.
  .UNINDENT

<a name="cmake_user_make_rules_override_ltlanggt"></a>

### CMAKE_USER_MAKE_RULES_OVERRIDE_&lt;LANG&gt;


Specify a CMake file that overrides platform information for **&lt;LANG&gt;**.

This is a language-specific version of
**CMAKE\_USER\_MAKE\_RULES\_OVERRIDE** loaded only when enabling language
**&lt;LANG&gt;**.

<a name="variables-for-ctest"></a>

# Variables for Ctest


<a name="ctest_binary_directory"></a>

### CTEST_BINARY_DIRECTORY


Specify the CTest **BuildDirectory** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_build_command"></a>

### CTEST_BUILD_COMMAND


Specify the CTest **MakeCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_build_name"></a>

### CTEST_BUILD_NAME


Specify the CTest **BuildName** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_bzr_command"></a>

### CTEST_BZR_COMMAND


Specify the CTest **BZRCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_bzr_update_options"></a>

### CTEST_BZR_UPDATE_OPTIONS


Specify the CTest **BZRUpdateOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_change_id"></a>

### CTEST_CHANGE_ID


Specify the CTest **ChangeId** setting
in a **ctest(1)** dashboard client script.

This setting allows CTest to pass arbitrary information about this
build up to CDash.  One use of this feature is to allow CDash to
post comments on your pull request if anything goes wrong with your build.

<a name="ctest_checkout_command"></a>

### CTEST_CHECKOUT_COMMAND


Tell the **ctest\_start()** command how to checkout or initialize
the source directory in a **ctest(1)** dashboard client script.

<a name="ctest_configuration_type"></a>

### CTEST_CONFIGURATION_TYPE


Specify the CTest **DefaultCTestConfigurationType** setting
in a **ctest(1)** dashboard client script.

If the configuration type is set via **-C &lt;cfg&gt;** from the command line
then this variable is populated accordingly.

<a name="ctest_configure_command"></a>

### CTEST_CONFIGURE_COMMAND


Specify the CTest **ConfigureCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_coverage_command"></a>

### CTEST_COVERAGE_COMMAND


Specify the CTest **CoverageCommand** setting
in a **ctest(1)** dashboard client script.

<a name="cobertura"></a>

### Cobertura


Using _Cobertura_ as the coverage generation within your multi-module
Java project can generate a series of XML files.

The Cobertura Coverage parser expects to read the coverage data from a
single XML file which contains the coverage data for all modules.
Cobertura has a program with the ability to merge given **cobertura.ser** files
and then another program to generate a combined XML file from the previous
merged file.  For command line testing, this can be done by hand prior to
CTest looking for the coverage files. For script builds,
set the **CTEST\_COVERAGE\_COMMAND** variable to point to a file which will
perform these same steps, such as a **.sh** or **.bat** file.
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CTEST_COVERAGE_COMMAND .../run-coverage-and-consolidate.sh)
    .ft P
.UNINDENT
.UNINDENT

where the **run-coverage-and-consolidate.sh** script is perhaps created by
the **configure\_file()** command and might contain the following code:
.INDENT 0.0
.INDENT 3.5

    .ft C
    #!/usr/bin/env bash
    CoberturaFiles="$(find "/path/to/source" -name "cobertura.ser")"
    SourceDirs="$(find "/path/to/source" -name "java" -type d)"
    cobertura-merge --datafile coberturamerge.ser $CoberturaFiles
    cobertura-report --datafile coberturamerge.ser --destination . e
                     --format xml $SourceDirs
    .ft P
.UNINDENT
.UNINDENT

The script uses **find** to capture the paths to all of the **cobertura.ser**
files found below the project’s source directory.  It keeps the list of files
and supplies it as an argument to the **cobertura-merge** program. The
**--datafile** argument signifies where the result of the merge will be kept.

The combined **coberturamerge.ser** file is then used to generate the XML report
using the **cobertura-report** program.  The call to the cobertura-report
program requires some named arguments.
.INDENT 0.0

* <b>**--datafila**</b>  
  path to the merged **.ser** file
* <b>**--destination**</b>  
  path to put the output files(s)
* <b>**--format**</b>  
  file format to write output in: xml or html
  .UNINDENT

The rest of the supplied arguments consist of the full paths to the
**/src/main/java** directories of each module within the source tree. These
directories are needed and should not be forgotten.

<a name="ctest_coverage_extra_flags"></a>

### CTEST_COVERAGE_EXTRA_FLAGS


Specify the CTest **CoverageExtraFlags** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_curl_options"></a>

### CTEST_CURL_OPTIONS


Specify the CTest **CurlOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_custom_coverage_exclude"></a>

### CTEST_CUSTOM_COVERAGE_EXCLUDE


A list of regular expressions which will be used to exclude files by their
path from coverage output by the **ctest\_coverage()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_error_exception"></a>

### CTEST_CUSTOM_ERROR_EXCEPTION


A list of regular expressions which will be used to exclude when detecting
error messages in build outputs by the **ctest\_test()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_error_match"></a>

### CTEST_CUSTOM_ERROR_MATCH


A list of regular expressions which will be used to detect error messages in
build outputs by the **ctest\_test()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_error_post_context"></a>

### CTEST_CUSTOM_ERROR_POST_CONTEXT


The number of lines to include as context which follow an error message by the
**ctest\_test()** command. The default is 10.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_error_pre_context"></a>

### CTEST_CUSTOM_ERROR_PRE_CONTEXT


The number of lines to include as context which precede an error message by
the **ctest\_test()** command. The default is 10.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_maximum_failed_test_output_size"></a>

### CTEST_CUSTOM_MAXIMUM_FAILED_TEST_OUTPUT_SIZE


When saving a failing test’s output, this is the maximum size, in bytes, that
will be collected by the **ctest\_test()** command. Defaults to 307200
(300 KiB).

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_maximum_number_of_errors"></a>

### CTEST_CUSTOM_MAXIMUM_NUMBER_OF_ERRORS


The maximum number of errors in a single build step which will be detected.
After this, the **ctest\_test()** command will truncate the output.
Defaults to 50.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_maximum_number_of_warnings"></a>

### CTEST_CUSTOM_MAXIMUM_NUMBER_OF_WARNINGS


The maximum number of warnings in a single build step which will be detected.
After this, the **ctest\_test()** command will truncate the output.
Defaults to 50.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_maximum_passed_test_output_size"></a>

### CTEST_CUSTOM_MAXIMUM_PASSED_TEST_OUTPUT_SIZE


When saving a passing test’s output, this is the maximum size, in bytes, that
will be collected by the **ctest\_test()** command. Defaults to 1024
(1 KiB).

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_memcheck_ignore"></a>

### CTEST_CUSTOM_MEMCHECK_IGNORE


A list of regular expressions to use to exclude tests during the
**ctest\_memcheck()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_post_memcheck"></a>

### CTEST_CUSTOM_POST_MEMCHECK


A list of commands to run at the end of the **ctest\_memcheck()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_post_test"></a>

### CTEST_CUSTOM_POST_TEST


A list of commands to run at the end of the **ctest\_test()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_pre_memcheck"></a>

### CTEST_CUSTOM_PRE_MEMCHECK


A list of commands to run at the start of the **ctest\_memcheck()**
command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_pre_test"></a>

### CTEST_CUSTOM_PRE_TEST


A list of commands to run at the start of the **ctest\_test()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_tests_ignore"></a>

### CTEST_CUSTOM_TESTS_IGNORE


A list of regular expressions to use to exclude tests during the
**ctest\_test()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_warning_exception"></a>

### CTEST_CUSTOM_WARNING_EXCEPTION


A list of regular expressions which will be used to exclude when detecting
warning messages in build outputs by the **ctest\_build()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_custom_warning_match"></a>

### CTEST_CUSTOM_WARNING_MATCH


A list of regular expressions which will be used to detect warning messages in
build outputs by the **ctest\_build()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_cvs_checkout"></a>

### CTEST_CVS_CHECKOUT


Deprecated.  Use **CTEST\_CHECKOUT\_COMMAND** instead.

<a name="ctest_cvs_command"></a>

### CTEST_CVS_COMMAND


Specify the CTest **CVSCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_cvs_update_options"></a>

### CTEST_CVS_UPDATE_OPTIONS


Specify the CTest **CVSUpdateOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_drop_location"></a>

### CTEST_DROP_LOCATION


Specify the CTest **DropLocation** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_drop_method"></a>

### CTEST_DROP_METHOD


Specify the CTest **DropMethod** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_drop_site"></a>

### CTEST_DROP_SITE


Specify the CTest **DropSite** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_drop_site_cdash"></a>

### CTEST_DROP_SITE_CDASH


Specify the CTest **IsCDash** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_drop_site_password"></a>

### CTEST_DROP_SITE_PASSWORD


Specify the CTest **DropSitePassword** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_drop_site_user"></a>

### CTEST_DROP_SITE_USER


Specify the CTest **DropSiteUser** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_extra_coverage_glob"></a>

### CTEST_EXTRA_COVERAGE_GLOB


A list of regular expressions which will be used to find files which should be
covered by the **ctest\_coverage()** command.

It is initialized by **ctest(1)**, but may be edited in a **CTestCustom**
file. See **ctest\_read\_custom\_files()** documentation.

<a name="ctest_git_command"></a>

### CTEST_GIT_COMMAND


Specify the CTest **GITCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_git_init_submodules"></a>

### CTEST_GIT_INIT_SUBMODULES


Specify the CTest **GITInitSubmodules** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_git_update_custom"></a>

### CTEST_GIT_UPDATE_CUSTOM


Specify the CTest **GITUpdateCustom** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_git_update_options"></a>

### CTEST_GIT_UPDATE_OPTIONS


Specify the CTest **GITUpdateOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_hg_command"></a>

### CTEST_HG_COMMAND


Specify the CTest **HGCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_hg_update_options"></a>

### CTEST_HG_UPDATE_OPTIONS


Specify the CTest **HGUpdateOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_labels_for_subprojects"></a>

### CTEST_LABELS_FOR_SUBPROJECTS


Specify the CTest **LabelsForSubprojects** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_memorycheck_command"></a>

### CTEST_MEMORYCHECK_COMMAND


Specify the CTest **MemoryCheckCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_memorycheck_command_options"></a>

### CTEST_MEMORYCHECK_COMMAND_OPTIONS


Specify the CTest **MemoryCheckCommandOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_memorycheck_sanitizer_options"></a>

### CTEST_MEMORYCHECK_SANITIZER_OPTIONS


Specify the CTest **MemoryCheckSanitizerOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_memorycheck_suppressions_file"></a>

### CTEST_MEMORYCHECK_SUPPRESSIONS_FILE


Specify the CTest **MemoryCheckSuppressionFile** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_memorycheck_type"></a>

### CTEST_MEMORYCHECK_TYPE


Specify the CTest **MemoryCheckType** setting
in a **ctest(1)** dashboard client script.
Valid values are **Valgrind**, **Purify**, **BoundsChecker**, **DrMemory** and
**ThreadSanitizer**, **AddressSanitizer**, **LeakSanitizer**, **MemorySanitizer**, and
**UndefinedBehaviorSanitizer**.

<a name="ctest_nightly_start_time"></a>

### CTEST_NIGHTLY_START_TIME


Specify the CTest **NightlyStartTime** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_p4_client"></a>

### CTEST_P4_CLIENT


Specify the CTest **P4Client** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_p4_command"></a>

### CTEST_P4_COMMAND


Specify the CTest **P4Command** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_p4_options"></a>

### CTEST_P4_OPTIONS


Specify the CTest **P4Options** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_p4_update_options"></a>

### CTEST_P4_UPDATE_OPTIONS


Specify the CTest **P4UpdateOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_run_current_script"></a>

### CTEST_RUN_CURRENT_SCRIPT


Setting this to 0 prevents **ctest(1)** from being run again when it
reaches the end of a script run by calling **ctest -S**.

<a name="ctest_scp_command"></a>

### CTEST_SCP_COMMAND


Legacy option.  Not used.

<a name="ctest_site"></a>

### CTEST_SITE


Specify the CTest **Site** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_submit_url"></a>

### CTEST_SUBMIT_URL


Specify the CTest **SubmitURL** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_source_directory"></a>

### CTEST_SOURCE_DIRECTORY


Specify the CTest **SourceDirectory** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_svn_command"></a>

### CTEST_SVN_COMMAND


Specify the CTest **SVNCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_svn_options"></a>

### CTEST_SVN_OPTIONS


Specify the CTest **SVNOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_svn_update_options"></a>

### CTEST_SVN_UPDATE_OPTIONS


Specify the CTest **SVNUpdateOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_test_load"></a>

### CTEST_TEST_LOAD


Specify the **TestLoad** setting in the CTest Test Step
of a **ctest(1)** dashboard client script.  This sets the
default value for the **TEST\_LOAD** option of the **ctest\_test()**
command.

<a name="ctest_test_timeout"></a>

### CTEST_TEST_TIMEOUT


Specify the CTest **TimeOut** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_trigger_site"></a>

### CTEST_TRIGGER_SITE


Legacy option.  Not used.

<a name="ctest_update_command"></a>

### CTEST_UPDATE_COMMAND


Specify the CTest **UpdateCommand** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_update_options"></a>

### CTEST_UPDATE_OPTIONS


Specify the CTest **UpdateOptions** setting
in a **ctest(1)** dashboard client script.

<a name="ctest_update_version_only"></a>

### CTEST_UPDATE_VERSION_ONLY


Specify the CTest UpdateVersionOnly setting
in a **ctest(1)** dashboard client script.

<a name="ctest_update_version_override"></a>

### CTEST_UPDATE_VERSION_OVERRIDE


Specify the CTest UpdateVersionOverride setting
in a **ctest(1)** dashboard client script.

<a name="ctest_use_launchers"></a>

### CTEST_USE_LAUNCHERS


Specify the CTest **UseLaunchers** setting
in a **ctest(1)** dashboard client script.

<a name="variables-for-cpack"></a>

# Variables for Cpack


<a name="cpack_absolute_destination_files"></a>

### CPACK_ABSOLUTE_DESTINATION_FILES


List of files which have been installed using an **ABSOLUTE DESTINATION** path.

This variable is a Read-Only variable which is set internally by CPack
during installation and before packaging using
**CMAKE\_ABSOLUTE\_DESTINATION\_FILES** defined in **cmake\_install.cmake**
scripts.  The value can be used within CPack project configuration
file and/or **CPack&lt;GEN&gt;.cmake** file of **&lt;GEN&gt;** generator.

<a name="cpack_component_include_toplevel_directory"></a>

### CPACK_COMPONENT_INCLUDE_TOPLEVEL_DIRECTORY


Boolean toggle to include/exclude top level directory (component case).

Similar usage as **CPACK\_INCLUDE\_TOPLEVEL\_DIRECTORY** but for the
component case.  See **CPACK\_INCLUDE\_TOPLEVEL\_DIRECTORY**
documentation for the detail.

<a name="cpack_error_on_absolute_install_destination"></a>

### CPACK_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION


Ask CPack to error out as soon as a file with absolute **INSTALL DESTINATION**
is encountered.

The fatal error is emitted before the installation of the offending
file takes place.  Some CPack generators, like **NSIS**, enforce this
internally.  This variable triggers the definition
of **CMAKE\_ERROR\_ON\_ABSOLUTE\_INSTALL\_DESTINATION** when CPack
runs.

<a name="cpack_include_toplevel_directory"></a>

### CPACK_INCLUDE_TOPLEVEL_DIRECTORY


Boolean toggle to include/exclude top level directory.

When preparing a package CPack installs the item under the so-called
top level directory.  The purpose of is to include (set to **1** or **ON** or
**TRUE**) the top level directory in the package or not (set to **0** or
**OFF** or **FALSE**).

Each CPack generator has a built-in default value for this variable.
E.g.  Archive generators (ZIP, TGZ, …) includes the top level
whereas RPM or DEB don’t.  The user may override the default value by
setting this variable.

There is a similar variable
**CPACK\_COMPONENT\_INCLUDE\_TOPLEVEL\_DIRECTORY** which may be used
to override the behavior for the component packaging
case which may have different default value for historical (now
backward compatibility) reason.

<a name="cpack_install_default_directory_permissions"></a>

### CPACK_INSTALL_DEFAULT_DIRECTORY_PERMISSIONS


Default permissions for implicitly created directories during packaging.

This variable serves the same purpose during packaging as the
**CMAKE\_INSTALL\_DEFAULT\_DIRECTORY\_PERMISSIONS** variable
serves during installation (e.g. **make install**).

If _include(CPack)_ is used then by default this variable is set to the content
of **CMAKE\_INSTALL\_DEFAULT\_DIRECTORY\_PERMISSIONS**.

<a name="cpack_packaging_install_prefix"></a>

### CPACK_PACKAGING_INSTALL_PREFIX


The prefix used in the built package.

Each CPack generator has a default value (like **/usr**).  This default
value may be overwritten from the **CMakeLists.txt** or the **cpack(1)**
command line by setting an alternative value.  Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CPACK_PACKAGING_INSTALL_PREFIX "/opt")
    .ft P
.UNINDENT
.UNINDENT

This is not the same purpose as **CMAKE\_INSTALL\_PREFIX** which is used
when installing from the build tree without building a package.

<a name="cpack_set_destdir"></a>

### CPACK_SET_DESTDIR


Boolean toggle to make CPack use **DESTDIR** mechanism when packaging.

**DESTDIR** means DESTination DIRectory.  It is commonly used by makefile
users in order to install software at non-default location.  It is a
basic relocation mechanism that should not be used on Windows (see
**CMAKE\_INSTALL\_PREFIX** documentation).  It is usually invoked like
this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    make DESTDIR=/home/john install
    .ft P
.UNINDENT
.UNINDENT

which will install the concerned software using the installation
prefix, e.g. **/usr/local** prepended with the **DESTDIR** value which
finally gives **/home/john/usr/local**.  When preparing a package, CPack
first installs the items to be packaged in a local (to the build tree)
directory by using the same **DESTDIR** mechanism.  Nevertheless, if
**CPACK\_SET\_DESTDIR** is set then CPack will set **DESTDIR** before doing the
local install.  The most noticeable difference is that without
**CPACK\_SET\_DESTDIR**, CPack uses **CPACK\_PACKAGING\_INSTALL\_PREFIX**
as a prefix whereas with **CPACK\_SET\_DESTDIR** set, CPack will use
**CMAKE\_INSTALL\_PREFIX** as a prefix.

Manually setting **CPACK\_SET\_DESTDIR** may help (or simply be necessary)
if some install rules uses absolute **DESTINATION** (see CMake
**install()** command).  However, starting with CPack/CMake 2.8.3 RPM
and DEB installers tries to handle **DESTDIR** automatically so that it is
seldom necessary for the user to set it.

<a name="cpack_warn_on_absolute_install_destination"></a>

### CPACK_WARN_ON_ABSOLUTE_INSTALL_DESTINATION


Ask CPack to warn each time a file with absolute **INSTALL DESTINATION** is
encountered.

This variable triggers the definition of
**CMAKE\_WARN\_ON\_ABSOLUTE\_INSTALL\_DESTINATION** when CPack runs
**cmake\_install.cmake** scripts.

<a name="variable-expansion-operators"></a>

# Variable Expansion Operators


<a name="cache"></a>

### CACHE


Operator to read cache variables.

Use the syntax **$CACHE{VAR}** to read cache entry **VAR**.
See the cmake-language(7) variables
documentation for more complete documentation of the interaction of
normal variables and cache entries.

When evaluating Variable References of the form **${VAR}**,
CMake first searches for a normal variable with that name, and if not
found CMake will search for a cache entry with that name.
The **$CACHE{VAR}** syntax can be used to do direct cache lookup and
ignore any existing normal variable.

See the **set()** and **unset()** commands to see how to
write or remove cache variables.

<a name="env"></a>

### ENV


Operator to read environment variables.

Use the syntax **$ENV{VAR}** to read environment variable **VAR**.

To test whether an environment variable is defined, use the signature
**if(DEFINED ENV{&lt;name&gt;})** of the **if()** command.

See the **set()** and **unset()** commands to see how to
write or remove environment variables.

<a name="internal-variables"></a>

# Internal Variables


CMake has many internal variables.  Most of them are undocumented.
Some of them, however, were at some point described as normal
variables, and therefore may be encountered in legacy code. They
are subject to change, and not recommended for use in project code.

<a name="cmake_home_directory"></a>

### CMAKE_HOME_DIRECTORY


Path to top of source tree. Same as **CMAKE\_SOURCE\_DIR**.

This is an internal cache entry used to locate the source directory
when loading a **CMakeCache.txt** from a build tree.  It should not
be used in project code.  The variable **CMAKE\_SOURCE\_DIR**
has the same value and should be preferred.

<a name="cmake_internal_platform_abi"></a>

### CMAKE_INTERNAL_PLATFORM_ABI


An internal variable subject to change.

This is used in determining the compiler ABI and is subject to change.

<a name="cmake_ltlanggt_compiler_abi"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_ABI


An internal variable subject to change.

This is used in determining the compiler ABI and is subject to change.

<a name="cmake_ltlanggt_compiler_architecture_id"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_ARCHITECTURE_ID


An internal variable subject to change.

This is used to identify the variant of a compiler based on its target
architecture.  For some compilers this is needed to determine the correct
usage.

<a name="cmake_ltlanggt_compiler_version_internal"></a>

### CMAKE_&lt;LANG&gt;_COMPILER_VERSION_INTERNAL


An internal variable subject to change.

This is used to identify the variant of a compiler based on an internal
version number.  For some compilers this is needed to determine the
correct usage.

<a name="cmake_ltlanggt_platform_id"></a>

### CMAKE_&lt;LANG&gt;_PLATFORM_ID


An internal variable subject to change.

This is used in determining the platform and is subject to change.

<a name="cmake_not_using_config_flags"></a>

### CMAKE_NOT_USING_CONFIG_FLAGS


Skip **\_BUILD\_TYPE** flags if true.

This is an internal flag used by the generators in CMake to tell CMake
to skip the **\_BUILD\_TYPE** flags.

<a name="cmake_vs_intel_fortran_project_version"></a>

### CMAKE_VS_INTEL_Fortran_PROJECT_VERSION


When generating for **Visual Studio 9 2008** or greater with the Intel
Fortran plugin installed, this specifies the **.vfproj** project file format
version.  This is intended for internal use by CMake and should not be
used by project code.

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

