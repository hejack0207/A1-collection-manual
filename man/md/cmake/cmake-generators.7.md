# cmake-generators(7) - CMake Generators Reference

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

<a name="introduction"></a>

# Introduction


A _CMake Generator_ is responsible for writing the input files for
a native build system.  Exactly one of the _CMake Generators_ must be
selected for a build tree to determine what native build system is to
be used.  Optionally one of the _Extra Generators_ may be selected
as a variant of some of the _Command-Line Build Tool Generators_ to
produce project files for an auxiliary IDE.

CMake Generators are platform-specific so each may be available only
on certain platforms.  The **cmake(1)** command-line tool **--help**
output lists available generators on the current platform.  Use its **-G**
option to specify the generator for a new build tree.
The **cmake-gui(1)** offers interactive selection of a generator
when creating a new build tree.

<a name="cmake-generators"></a>

# Cmake Generators


<a name="command-line-build-tool-generators"></a>

### Command\-Line Build Tool Generators


These generators support command-line build tools.  In order to use them,
one must launch CMake from a command-line prompt whose environment is
already configured for the chosen compiler and build tool.

<a name="makefile-generators"></a>

### Makefile Generators


<a name="borland-makefiles"></a>

### Borland Makefiles


Generates Borland makefiles.

<a name="msys-makefiles"></a>

### MSYS Makefiles


Generates makefiles for use with MSYS (Minimal SYStem)
**make** under the MSYS shell.

Use this generator in a MSYS shell prompt and using **make** as the build
tool.  The generated makefiles use **/bin/sh** as the shell to launch build
rules.  They are not compatible with a Windows command prompt.

To build under a Windows command prompt, use the
**MinGW Makefiles** generator.

<a name="mingw-makefiles"></a>

### MinGW Makefiles


Generates makefiles for use with **mingw32-make** under a Windows command
prompt.

Use this generator under a Windows command prompt with
MinGW (Minimalist GNU for Windows) in the **PATH**
and using **mingw32-make** as the build tool.  The generated makefiles use
**cmd.exe** as the shell to launch build rules.  They are not compatible with
MSYS or a unix shell.

To build under the MSYS shell, use the **MSYS Makefiles** generator.

<a name="nmake-makefiles"></a>

### NMake Makefiles


Generates NMake makefiles.

<a name="nmake-makefiles-jom"></a>

### NMake Makefiles JOM


Generates JOM makefiles.

<a name="unix-makefiles"></a>

### Unix Makefiles


Generates standard UNIX makefiles.

A hierarchy of UNIX makefiles is generated into the build tree.  Use
any standard UNIX-style make program to build the project through
the **all** target and install the project through the **install**
(or **install/strip**) target.

For each subdirectory **sub/dir** of the project a UNIX makefile will
be created, containing the following targets:
.INDENT 0.0

* <b>**all**</b>  
  Depends on all targets required by the subdirectory.
* <b>**install**</b>  
  Runs the install step in the subdirectory, if any.
* <b>**install/strip**</b>  
  Runs the install step in the subdirectory followed by a **CMAKE\_STRIP** command,
  if any.

The **CMAKE\_STRIP** variable will contain the platform’s **strip** utility, which
removes symbols information from generated binaries.

* <b>**test**</b>  
  Runs the test step in the subdirectory, if any.
* <b>**package**</b>  
  Runs the package step in the subdirectory, if any.
  .UNINDENT

<a name="watcom-wmake"></a>

### Watcom WMake


Generates Watcom WMake makefiles.

<a name="ninja-generators"></a>

### Ninja Generators


<a name="ninja"></a>

### Ninja


Generates **build.ninja** files.

A **build.ninja** file is generated into the build tree.  Use the ninja
program to build the project through the **all** target and install the
project through the **install** (or **install/strip**) target.

For each subdirectory **sub/dir** of the project, additional targets
are generated:
.INDENT 0.0

* <b>**sub/dir/all**</b>  
  Depends on all targets required by the subdirectory.
* <b>**sub/dir/install**</b>  
  Runs the install step in the subdirectory, if any.
* <b>**sub/dir/install/strip**</b>  
  Runs the install step in the subdirectory followed by a **CMAKE\_STRIP** command,
  if any.

The **CMAKE\_STRIP** variable will contain the platform’s **strip** utility, which
removes symbols information from generated binaries.

* <b>**sub/dir/test**</b>  
  Runs the test step in the subdirectory, if any.
* <b>**sub/dir/package**</b>  
  Runs the package step in the subdirectory, if any.
  .UNINDENT

<a name="fortran-support"></a>

### Fortran Support


The **Ninja** generator conditionally supports Fortran when the **ninja**
tool is at least version 1.10 (which has the required features).

<a name="see-also"></a>

### See Also


The **Ninja Multi-Config** generator is similar to the **Ninja**
generator, but generates multiple configurations at once.

<a name="ninja-multi-config"></a>

### Ninja Multi\-Config


Generates multiple **build-&lt;Config&gt;.ninja** files.

This generator is very much like the **Ninja** generator, but with
some key differences. Only these differences will be discussed in this
document.

Unlike the **Ninja** generator, **Ninja Multi-Config** generates
multiple configurations at once with **CMAKE\_CONFIGURATION\_TYPES**
instead of only one configuration with **CMAKE\_BUILD\_TYPE**. One
**build-&lt;Config&gt;.ninja** file will be generated for each of these
configurations (with **&lt;Config&gt;** being the configuration name.) These files
are intended to be run with **ninja -f build-&lt;Config&gt;.ninja**. A
**build.ninja** file is also generated, using the configuration from either
**CMAKE\_DEFAULT\_BUILD\_TYPE** or the first item from
**CMAKE\_CONFIGURATION\_TYPES**.

**cmake --build . --config &lt;Config&gt;** will always use **build-&lt;Config&gt;.ninja**
to build. If no **--config** argument is specified, **cmake --build .** will
default to **build-Debug.ninja**, unless a **build.ninja** is generated (see
below), in which case that will be used instead.

Each **build-&lt;Config&gt;.ninja** file contains **&lt;target&gt;** targets as well as
**&lt;target&gt;:&lt;Config&gt;** targets, where **&lt;Config&gt;** is the same as the
configuration specified in **build-&lt;Config&gt;.ninja** Additionally, if
cross-config mode is enabled, **build-&lt;Config&gt;.ninja** may contain
**&lt;target&gt;:&lt;OtherConfig&gt;** targets, where **&lt;OtherConfig&gt;** is a cross-config,
as well as **&lt;target&gt;:all**, which builds the target in all cross-configs. See
below for how to enable cross-config mode.

The **Ninja Multi-Config** generator recognizes the following variables:
.INDENT 0.0

* <b>**CMAKE\_CONFIGURATION\_TYPES**</b>  
  Specifies the total set of configurations to build.
* <b>**CMAKE\_CROSS\_CONFIGS**</b>  
  Specifies a semicolon-separated list of
  configurations available from all **build-&lt;Config&gt;.ninja** files.
* <b>**CMAKE\_DEFAULT\_BUILD\_TYPE**</b>  
  Specifies the configuration to use by default in a **build.ninja** file.
* <b>**CMAKE\_DEFAULT\_CONFIGS**</b>  
  Specifies a semicolon-separated list of
  configurations to build for a target in **build.ninja**
  if no **:&lt;Config&gt;** suffix is specified.
  .UNINDENT

Consider the following example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.16)
    project(MultiConfigNinja C)
    
    add_executable(generator generator.c)
    add_custom_command(OUTPUT generated.c COMMAND generator generated.c)
    add_library(generated ${CMAKE_BINARY_DIR}/generated.c)
    .ft P
.UNINDENT
.UNINDENT

Now assume you configure the project with **Ninja Multi-Config** and run one of
the following commands:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ninja -f build-Debug.ninja generated
    # OR
    cmake --build . --config Debug --target generated
    .ft P
.UNINDENT
.UNINDENT

This would build the **Debug** configuration of **generator**, which would be
used to generate **generated.c**, which would be used to build the **Debug**
configuration of **generated**.

But if **CMAKE\_CROSS\_CONFIGS** is set to **all**, and you run the
following instead:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ninja -f build-Release.ninja generated:Debug
    # OR
    cmake --build . --config Release --target generated:Debug
    .ft P
.UNINDENT
.UNINDENT

This would build the **Release** configuration of **generator**, which would be
used to generate **generated.c**, which would be used to build the **Debug**
configuration of **generated**. This is useful for running a release-optimized
version of a generator utility while still building the debug version of the
targets built with the generated code.

<a name="ide-build-tool-generators"></a>

### IDE Build Tool Generators


These generators support Integrated Development Environment (IDE)
project files.  Since the IDEs configure their own environment
one may launch CMake from any environment.

<a name="visual-studio-generators"></a>

### Visual Studio Generators


<a name="visual-studio-6"></a>

### Visual Studio 6


Removed.  This once generated Visual Studio 6 project files, but the
generator has been removed since CMake 3.6.  It is still possible to
build with VS 6 tools using the **NMake Makefiles** generator.

<a name="visual-studio-7"></a>

### Visual Studio 7


Removed.  This once generated Visual Studio .NET 2002 project files, but
the generator has been removed since CMake 3.6.  It is still possible to
build with VS 7.0 tools using the **NMake Makefiles** generator.

<a name="visual-studio-7-net-2003"></a>

### Visual Studio 7 .NET 2003


Removed.  This once generated Visual Studio .NET 2003 project files, but
the generator has been removed since CMake 3.9.  It is still possible to
build with VS 7.1 tools using the **NMake Makefiles** generator.

<a name="visual-studio-8-2005"></a>

### Visual Studio 8 2005


Removed.  This once generated Visual Studio 8 2005 project files, but
the generator has been removed since CMake 3.12.  It is still possible to
build with VS 2005 tools using the **NMake Makefiles** generator.

<a name="visual-studio-9-2008"></a>

### Visual Studio 9 2008


Generates Visual Studio 9 2008 project files.

<a name="platform-selection"></a>

### Platform Selection


The default target platform name (architecture) is **Win32**.

The **CMAKE\_GENERATOR\_PLATFORM** variable may be set, perhaps
via the **cmake(1)** **-A** option, to specify a target platform
name (architecture).  For example:
.INDENT 0.0

* ·  
  **cmake -G "Visual Studio 9 2008" -A Win32**
* ·  
  **cmake -G "Visual Studio 9 2008" -A x64**
* ·  
  **cmake -G "Visual Studio 9 2008" -A Itanium**
* ·  
  **cmake -G "Visual Studio 9 2008" -A &lt;WinCE-SDK&gt;**
  (Specify a target platform matching a Windows CE SDK name.)
  .UNINDENT

For compatibility with CMake versions prior to 3.1, one may specify
a target platform name optionally at the end of the generator name.
This is supported only for:
.INDENT 0.0

* <b>**Visual Studio 9 2008 Win64**</b>  
  Specify target platform **x64**.
* <b>**Visual Studio 9 2008 IA64**</b>  
  Specify target platform **Itanium**.
* <b>**Visual Studio 9 2008 &lt;WinCE-SDK&gt;**</b>  
  Specify target platform matching a Windows CE SDK name.
  .UNINDENT

<a name="visual-studio-10-2010"></a>

### Visual Studio 10 2010


Generates Visual Studio 10 (VS 2010) project files.

For compatibility with CMake versions prior to 3.0, one may specify this
generator using the name **Visual Studio 10** without the year component.

<a name="project-types"></a>

### Project Types


Only Visual C++ and C# projects may be generated.  Other types of
projects (Database, Website, etc.) are not supported.

<a name="platform-selection"></a>

### Platform Selection


The default target platform name (architecture) is **Win32**.

The **CMAKE\_GENERATOR\_PLATFORM** variable may be set, perhaps
via the **cmake(1)** **-A** option, to specify a target platform
name (architecture).  For example:
.INDENT 0.0

* ·  
  **cmake -G "Visual Studio 10 2010" -A Win32**
* ·  
  **cmake -G "Visual Studio 10 2010" -A x64**
* ·  
  **cmake -G "Visual Studio 10 2010" -A Itanium**
  .UNINDENT

For compatibility with CMake versions prior to 3.1, one may specify
a target platform name optionally at the end of the generator name.
This is supported only for:
.INDENT 0.0

* <b>**Visual Studio 10 2010 Win64**</b>  
  Specify target platform **x64**.
* <b>**Visual Studio 10 2010 IA64**</b>  
  Specify target platform **Itanium**.
  .UNINDENT

<a name="toolset-selection"></a>

### Toolset Selection


The **v100** toolset that comes with Visual Studio 10 2010 is selected by
default.  The **CMAKE\_GENERATOR\_TOOLSET** option may be set, perhaps
via the **cmake(1)** **-T** option, to specify another toolset.

<a name="visual-studio-11-2012"></a>

### Visual Studio 11 2012


Generates Visual Studio 11 (VS 2012) project files.

For compatibility with CMake versions prior to 3.0, one may specify this
generator using the name “Visual Studio 11” without the year component.

<a name="project-types"></a>

### Project Types


Only Visual C++ and C# projects may be generated.  Other types of
projects (JavaScript, Database, Website, etc.) are not supported.

<a name="platform-selection"></a>

### Platform Selection


The default target platform name (architecture) is **Win32**.

The **CMAKE\_GENERATOR\_PLATFORM** variable may be set, perhaps
via the **cmake(1)** **-A** option, to specify a target platform
name (architecture).  For example:
.INDENT 0.0

* ·  
  **cmake -G "Visual Studio 11 2012" -A Win32**
* ·  
  **cmake -G "Visual Studio 11 2012" -A x64**
* ·  
  **cmake -G "Visual Studio 11 2012" -A ARM**
* ·  
  **cmake -G "Visual Studio 11 2012" -A &lt;WinCE-SDK&gt;**
  (Specify a target platform matching a Windows CE SDK name.)
  .UNINDENT

For compatibility with CMake versions prior to 3.1, one may specify
a target platform name optionally at the end of the generator name.
This is supported only for:
.INDENT 0.0

* <b>**Visual Studio 11 2012 Win64**</b>  
  Specify target platform **x64**.
* <b>**Visual Studio 11 2012 ARM**</b>  
  Specify target platform **ARM**.
* <b>**Visual Studio 11 2012 &lt;WinCE-SDK&gt;**</b>  
  Specify target platform matching a Windows CE SDK name.
  .UNINDENT

<a name="toolset-selection"></a>

### Toolset Selection


The **v110** toolset that comes with Visual Studio 11 2012 is selected by
default.  The **CMAKE\_GENERATOR\_TOOLSET** option may be set, perhaps
via the **cmake(1)** **-T** option, to specify another toolset.

<a name="visual-studio-12-2013"></a>

### Visual Studio 12 2013


Generates Visual Studio 12 (VS 2013) project files.

For compatibility with CMake versions prior to 3.0, one may specify this
generator using the name “Visual Studio 12” without the year component.

<a name="project-types"></a>

### Project Types


Only Visual C++ and C# projects may be generated.  Other types of
projects (JavaScript, Powershell, Python, etc.) are not supported.

<a name="platform-selection"></a>

### Platform Selection


The default target platform name (architecture) is **Win32**.

The **CMAKE\_GENERATOR\_PLATFORM** variable may be set, perhaps
via the **cmake(1)** **-A** option, to specify a target platform
name (architecture).  For example:
.INDENT 0.0

* ·  
  **cmake -G "Visual Studio 12 2013" -A Win32**
* ·  
  **cmake -G "Visual Studio 12 2013" -A x64**
* ·  
  **cmake -G "Visual Studio 12 2013" -A ARM**
  .UNINDENT

For compatibility with CMake versions prior to 3.1, one may specify
a target platform name optionally at the end of the generator name.
This is supported only for:
.INDENT 0.0

* <b>**Visual Studio 12 2013 Win64**</b>  
  Specify target platform **x64**.
* <b>**Visual Studio 12 2013 ARM**</b>  
  Specify target platform **ARM**.
  .UNINDENT

<a name="toolset-selection"></a>

### Toolset Selection


The **v120** toolset that comes with Visual Studio 12 2013 is selected by
default.  The **CMAKE\_GENERATOR\_TOOLSET** option may be set, perhaps
via the **cmake(1)** **-T** option, to specify another toolset.

For each toolset that comes with this version of Visual Studio, there are
variants that are themselves compiled for 32-bit (**x86**) and
64-bit (**x64**) hosts (independent of the architecture they target).
By default this generator uses the 32-bit variant even on a 64-bit host.
One may explicitly request use of either the 32-bit or 64-bit host tools
by adding either **host=x86** or **host=x64** to the toolset specification.
See the **CMAKE\_GENERATOR\_TOOLSET** variable for details.

<a name="visual-studio-14-2015"></a>

### Visual Studio 14 2015


Generates Visual Studio 14 (VS 2015) project files.

<a name="project-types"></a>

### Project Types


Only Visual C++ and C# projects may be generated.  Other types of
projects (JavaScript, Powershell, Python, etc.) are not supported.

<a name="platform-selection"></a>

### Platform Selection


The default target platform name (architecture) is **Win32**.

The **CMAKE\_GENERATOR\_PLATFORM** variable may be set, perhaps
via the **cmake(1)** **-A** option, to specify a target platform
name (architecture).  For example:
.INDENT 0.0

* ·  
  **cmake -G "Visual Studio 14 2015" -A Win32**
* ·  
  **cmake -G "Visual Studio 14 2015" -A x64**
* ·  
  **cmake -G "Visual Studio 14 2015" -A ARM**
  .UNINDENT

For compatibility with CMake versions prior to 3.1, one may specify
a target platform name optionally at the end of the generator name.
This is supported only for:
.INDENT 0.0

* <b>**Visual Studio 14 2015 Win64**</b>  
  Specify target platform **x64**.
* <b>**Visual Studio 14 2015 ARM**</b>  
  Specify target platform **ARM**.
  .UNINDENT

<a name="toolset-selection"></a>

### Toolset Selection


The **v140** toolset that comes with Visual Studio 14 2015 is selected by
default.  The **CMAKE\_GENERATOR\_TOOLSET** option may be set, perhaps
via the **cmake(1)** **-T** option, to specify another toolset.

For each toolset that comes with this version of Visual Studio, there are
variants that are themselves compiled for 32-bit (**x86**) and
64-bit (**x64**) hosts (independent of the architecture they target).
By default this generator uses the 32-bit variant even on a 64-bit host.
One may explicitly request use of either the 32-bit or 64-bit host tools
by adding either **host=x86** or **host=x64** to the toolset specification.
See the **CMAKE\_GENERATOR\_TOOLSET** variable for details.

<a name="visual-studio-15-2017"></a>

### Visual Studio 15 2017


Generates Visual Studio 15 (VS 2017) project files.

<a name="project-types"></a>

### Project Types


Only Visual C++ and C# projects may be generated.  Other types of
projects (JavaScript, Powershell, Python, etc.) are not supported.

<a name="instance-selection"></a>

### Instance Selection


VS 2017 supports multiple installations on the same machine.
The **CMAKE\_GENERATOR\_INSTANCE** variable may be set as a
cache entry containing the absolute path to a Visual Studio instance.
If the value is not specified explicitly by the user or a toolchain file,
CMake queries the Visual Studio Installer to locate VS instances, chooses
one, and sets the variable as a cache entry to hold the value persistently.

When CMake first chooses an instance, if the **VS150COMNTOOLS** environment
variable is set and points to the **Common7/Tools** directory within
one of the instances, that instance will be used.  Otherwise, if more
than one instance is installed we do not define which one is chosen
by default.

<a name="platform-selection"></a>

### Platform Selection


The default target platform name (architecture) is **Win32**.

The **CMAKE\_GENERATOR\_PLATFORM** variable may be set, perhaps
via the **cmake(1)** **-A** option, to specify a target platform
name (architecture).  For example:
.INDENT 0.0

* ·  
  **cmake -G "Visual Studio 15 2017" -A Win32**
* ·  
  **cmake -G "Visual Studio 15 2017" -A x64**
* ·  
  **cmake -G "Visual Studio 15 2017" -A ARM**
* ·  
  **cmake -G "Visual Studio 15 2017" -A ARM64**
  .UNINDENT

For compatibility with CMake versions prior to 3.1, one may specify
a target platform name optionally at the end of the generator name.
This is supported only for:
.INDENT 0.0

* <b>**Visual Studio 15 2017 Win64**</b>  
  Specify target platform **x64**.
* <b>**Visual Studio 15 2017 ARM**</b>  
  Specify target platform **ARM**.
  .UNINDENT

<a name="toolset-selection"></a>

### Toolset Selection


The **v141** toolset that comes with Visual Studio 15 2017 is selected by
default.  The **CMAKE\_GENERATOR\_TOOLSET** option may be set, perhaps
via the **cmake(1)** **-T** option, to specify another toolset.

For each toolset that comes with this version of Visual Studio, there are
variants that are themselves compiled for 32-bit (**x86**) and
64-bit (**x64**) hosts (independent of the architecture they target).
By default this generator uses the 32-bit variant even on a 64-bit host.
One may explicitly request use of either the 32-bit or 64-bit host tools
by adding either **host=x86** or **host=x64** to the toolset specification.
See the **CMAKE\_GENERATOR\_TOOLSET** variable for details.

<a name="visual-studio-16-2019"></a>

### Visual Studio 16 2019


Generates Visual Studio 16 (VS 2019) project files.

<a name="project-types"></a>

### Project Types


Only Visual C++ and C# projects may be generated.  Other types of
projects (JavaScript, Powershell, Python, etc.) are not supported.

<a name="instance-selection"></a>

### Instance Selection


VS 2019 supports multiple installations on the same machine.
The **CMAKE\_GENERATOR\_INSTANCE** variable may be set as a
cache entry containing the absolute path to a Visual Studio instance.
If the value is not specified explicitly by the user or a toolchain file,
CMake queries the Visual Studio Installer to locate VS instances, chooses
one, and sets the variable as a cache entry to hold the value persistently.

When CMake first chooses an instance, if the **VS160COMNTOOLS** environment
variable is set and points to the **Common7/Tools** directory within
one of the instances, that instance will be used.  Otherwise, if more
than one instance is installed we do not define which one is chosen
by default.

<a name="platform-selection"></a>

### Platform Selection


The default target platform name (architecture) is that of the host
and is provided in the **CMAKE\_VS\_PLATFORM\_NAME\_DEFAULT** variable.

The **CMAKE\_GENERATOR\_PLATFORM** variable may be set, perhaps
via the **cmake(1)** **-A** option, to specify a target platform
name (architecture).  For example:
.INDENT 0.0

* ·  
  **cmake -G "Visual Studio 16 2019" -A Win32**
* ·  
  **cmake -G "Visual Studio 16 2019" -A x64**
* ·  
  **cmake -G "Visual Studio 16 2019" -A ARM**
* ·  
  **cmake -G "Visual Studio 16 2019" -A ARM64**
  .UNINDENT

<a name="toolset-selection"></a>

### Toolset Selection


The **v142** toolset that comes with Visual Studio 16 2019 is selected by
default.  The **CMAKE\_GENERATOR\_TOOLSET** option may be set, perhaps
via the **cmake(1)** **-T** option, to specify another toolset.

For each toolset that comes with this version of Visual Studio, there are
variants that are themselves compiled for 32-bit (**x86**) and
64-bit (**x64**) hosts (independent of the architecture they target).
By default this generator uses the 64-bit variant on x64 hosts and
the 32-bit variant otherwise.
One may explicitly request use of either the 32-bit or 64-bit host tools
by adding either **host=x86** or **host=x64** to the toolset specification.
See the **CMAKE\_GENERATOR\_TOOLSET** variable for details.

<a name="other-generators"></a>

### Other Generators


<a name="green-hills-multi"></a>

### Green Hills MULTI


Generates Green Hills MULTI project files (experimental, work-in-progress).

The buildsystem has predetermined build-configuration settings that can be controlled
via the **CMAKE\_BUILD\_TYPE** variable.

Customizations that are used to pick toolset and target system:

The **-A &lt;arch&gt;** can be supplied for setting the target architecture.
**&lt;arch&gt;** usually is one of **arm**, **ppc**, **86**, etcetera.
If the target architecture is not specified then
the default architecture of **arm** will be used.

The **-T &lt;toolset&gt;** option can be used to set the directory location of the toolset.
Both absolute and relative paths are valid. Relative paths use **GHS\_TOOLSET\_ROOT**
as the root. If the toolset is not specified then the latest toolset found in
**GHS\_TOOLSET\_ROOT** will be used.

Cache variables that are used for toolset and target system customization:
.INDENT 0.0

* ·  
  **GHS\_TARGET\_PLATFORM**
    Defaults to integrity.
    Usual values are integrity, threadx, uvelosity, velosity,
    vxworks, standalone.


* ·  
  **GHS\_PRIMARY\_TARGET**
    Sets primaryTarget entry in project file.
    Defaults to <arch>_<GHS_TARGET_PLATFORM>.tgt.


* ·  
  **GHS\_TOOLSET\_ROOT**
    Root path for toolset searches.
    Defaults to C:/ghs in Windows or /usr/ghs in Linux.


* ·  
  **GHS\_OS\_ROOT**
    Root path for RTOS searches.
    Defaults to C:/ghs in Windows or /usr/ghs in Linux.


* ·  
  **GHS\_OS\_DIR** and **GHS\_OS\_DIR\_OPTION**
    Sets -os_dir entry in project file.
    Defaults to latest platform OS installation at GHS_OS_ROOT.  Set this value if
    a specific RTOS is to be used.
    GHS_OS_DIR_OPTION default value is -os_dir.


* ·  
  **GHS\_BSP\_NAME**
    Sets -bsp entry in project file.
    Defaults to sim<arch> for integrity platforms.

.UNINDENT

Customizations are available through the following cache variables:
.INDENT 0.0

* ·  
  **GHS\_CUSTOMIZATION**
* ·  
  **GHS\_GPJ\_MACROS**
  .UNINDENT

The following properties are available:
.INDENT 0.0

* ·  
  **GHS\_INTEGRITY\_APP**
* ·  
  **GHS\_NO\_SOURCE\_GROUP\_FILE**
  .UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
This generator is deemed experimental as of CMake 3.17.2
and is still a work in progress.  Future versions of CMake
may make breaking changes as the generator matures.
.UNINDENT
.UNINDENT

<a name="xcode"></a>

### Xcode


Generate Xcode project files.

This supports Xcode 5.0 and above.

<a name="toolset-selection"></a>

### Toolset Selection


By default Xcode is allowed to select its own default toolchain.
The **CMAKE\_GENERATOR\_TOOLSET** option may be set, perhaps
via the **cmake(1)** **-T** option, to specify another toolset.

<a name="extra-generators"></a>

# Extra Generators


Some of the _CMake Generators_ listed in the **cmake(1)**
command-line tool **--help** output may have variants that specify
an extra generator for an auxiliary IDE tool.  Such generator
names have the form **&lt;extra-generator&gt; - &lt;main-generator&gt;**.
The following extra generators are known to CMake.

<a name="codeblocks"></a>

### CodeBlocks


Generates CodeBlocks project files.

Project files for CodeBlocks will be created in the top directory and
in every subdirectory which features a **CMakeLists.txt** file containing
a **project()** call.  Additionally a hierarchy of makefiles is generated
into the build tree.
The **CMAKE\_CODEBLOCKS\_EXCLUDE\_EXTERNAL\_FILES** variable may
be set to **ON** to exclude any files which are located outside of
the project root directory.
The appropriate make program can build the
project through the default **all** target.  An **install** target is
also provided.

This “extra” generator may be specified as:
.INDENT 0.0

* <b>**CodeBlocks - MinGW Makefiles**</b>  
  Generate with **MinGW Makefiles**.
* <b>**CodeBlocks - NMake Makefiles**</b>  
  Generate with **NMake Makefiles**.
* <b>**CodeBlocks - NMake Makefiles JOM**</b>  
  Generate with **NMake Makefiles JOM**.
* <b>**CodeBlocks - Ninja**</b>  
  Generate with **Ninja**.
* <b>**CodeBlocks - Unix Makefiles**</b>  
  Generate with **Unix Makefiles**.
  .UNINDENT

<a name="codelite"></a>

### CodeLite


Generates CodeLite project files.

Project files for CodeLite will be created in the top directory and
in every subdirectory which features a CMakeLists.txt file containing
a **project()** call.
The **CMAKE\_CODELITE\_USE\_TARGETS** variable may be set to **ON**
to change the default behavior from projects to targets as the basis
for project files.
The appropriate make program can build the
project through the default **all** target.  An **install** target
is also provided.

This “extra” generator may be specified as:
.INDENT 0.0

* <b>**CodeLite - MinGW Makefiles**</b>  
  Generate with **MinGW Makefiles**.
* <b>**CodeLite - NMake Makefiles**</b>  
  Generate with **NMake Makefiles**.
* <b>**CodeLite - Ninja**</b>  
  Generate with **Ninja**.
* <b>**CodeLite - Unix Makefiles**</b>  
  Generate with **Unix Makefiles**.
  .UNINDENT

<a name="eclipse-cdt4"></a>

### Eclipse CDT4


Generates Eclipse CDT 4.0 project files.

Project files for Eclipse will be created in the top directory.  In
out of source builds, a linked resource to the top level source
directory will be created.  Additionally a hierarchy of makefiles is
generated into the build tree.  The appropriate make program can build
the project through the default **all** target.  An **install** target
is also provided.

This “extra” generator may be specified as:
.INDENT 0.0

* <b>**Eclipse CDT4 - MinGW Makefiles**</b>  
  Generate with **MinGW Makefiles**.
* <b>**Eclipse CDT4 - NMake Makefiles**</b>  
  Generate with **NMake Makefiles**.
* <b>**Eclipse CDT4 - Ninja**</b>  
  Generate with **Ninja**.
* <b>**Eclipse CDT4 - Unix Makefiles**</b>  
  Generate with **Unix Makefiles**.
  .UNINDENT

<a name="kate"></a>

### Kate


Generates Kate project files.

A project file for Kate will be created in the top directory in the top level
build directory.
To use it in Kate, the Project plugin must be enabled.
The project file is loaded in Kate by opening the
**ProjectName.kateproject** file in the editor.
If the Kate Build-plugin is enabled, all targets generated by CMake are
available for building.

This “extra” generator may be specified as:
.INDENT 0.0

* <b>**Kate - MinGW Makefiles**</b>  
  Generate with **MinGW Makefiles**.
* <b>**Kate - NMake Makefiles**</b>  
  Generate with **NMake Makefiles**.
* <b>**Kate - Ninja**</b>  
  Generate with **Ninja**.
* <b>**Kate - Unix Makefiles**</b>  
  Generate with **Unix Makefiles**.
  .UNINDENT

<a name="sublime-text-2"></a>

### Sublime Text 2


Generates Sublime Text 2 project files.

Project files for Sublime Text 2 will be created in the top directory
and in every subdirectory which features a **CMakeLists.txt** file
containing a **project()** call.  Additionally **Makefiles**
(or **build.ninja** files) are generated into the build tree.
The appropriate make program can build the project through the default **all**
target.  An **install** target is also provided.

This “extra” generator may be specified as:
.INDENT 0.0

* <b>**Sublime Text 2 - MinGW Makefiles**</b>  
  Generate with **MinGW Makefiles**.
* <b>**Sublime Text 2 - NMake Makefiles**</b>  
  Generate with **NMake Makefiles**.
* <b>**Sublime Text 2 - Ninja**</b>  
  Generate with **Ninja**.
* <b>**Sublime Text 2 - Unix Makefiles**</b>  
  Generate with **Unix Makefiles**.
  .UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

