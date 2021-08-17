# cmake-toolchains(7) - CMake Toolchains Reference

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


CMake uses a toolchain of utilities to compile, link libraries and create
archives, and other tasks to drive the build. The toolchain utilities available
are determined by the languages enabled. In normal builds, CMake automatically
determines the toolchain for host builds based on system introspection and
defaults. In cross-compiling scenarios, a toolchain file may be specified
with information about compiler and utility paths.

<a name="languages"></a>

# Languages


Languages are enabled by the **project()** command.  Language-specific
built-in variables, such as
**CMAKE\_CXX\_COMPILER**,
**CMAKE\_CXX\_COMPILER\_ID** etc are set by
invoking the **project()** command.  If no project command
is in the top-level CMakeLists file, one will be implicitly generated. By default
the enabled languages are **C** and **CXX**:
.INDENT 0.0
.INDENT 3.5

    .ft C
    project(C_Only C)
    .ft P
.UNINDENT
.UNINDENT

A special value of **NONE** can also be used with the **project()** command
to enable no languages:
.INDENT 0.0
.INDENT 3.5

    .ft C
    project(MyProject NONE)
    .ft P
.UNINDENT
.UNINDENT

The **enable\_language()** command can be used to enable languages after the
**project()** command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    enable_language(CXX)
    .ft P
.UNINDENT
.UNINDENT

When a language is enabled, CMake finds a compiler for that language, and
determines some information, such as the vendor and version of the compiler,
the target architecture and bitwidth, the location of corresponding utilities
etc.

The **ENABLED\_LANGUAGES** global property contains the languages which
are currently enabled.

<a name="variables-and-properties"></a>

# Variables and Properties


Several variables relate to the language components of a toolchain which are
enabled. **CMAKE\_&lt;LANG&gt;\_COMPILER** is the full path to the compiler used
for **&lt;LANG&gt;**. **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** is the identifier used
by CMake for the compiler and **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** is the
version of the compiler.

The **CMAKE\_&lt;LANG&gt;\_FLAGS** variables and the configuration-specific
equivalents contain flags that will be added to the compile command when
compiling a file of a particular language.

As the linker is invoked by the compiler driver, CMake needs a way to determine
which compiler to use to invoke the linker. This is calculated by the
**LANGUAGE** of source files in the target, and in the case of static
libraries, the language of the dependent libraries. The choice CMake makes may
be overridden with the **LINKER\_LANGUAGE** target property.

<a name="toolchain-features"></a>

# Toolchain Features


CMake provides the **try\_compile()** command and wrapper macros such as
**CheckCXXSourceCompiles**, **CheckCXXSymbolExists** and
**CheckIncludeFile** to test capability and availability of various
toolchain features. These APIs test the toolchain in some way and cache the
result so that the test does not have to be performed again the next time
CMake runs.

Some toolchain features have built-in handling in CMake, and do not require
compile-tests. For example, **POSITION\_INDEPENDENT\_CODE** allows
specifying that a target should be built as position-independent code, if
the compiler supports that feature. The **&lt;LANG&gt;\_VISIBILITY\_PRESET**
and **VISIBILITY\_INLINES\_HIDDEN** target properties add flags for
hidden visibility, if supported by the compiler.

<a name="cross-compiling"></a>

# Cross Compiling


If **cmake(1)** is invoked with the command line parameter
**-DCMAKE\_TOOLCHAIN\_FILE=path/to/file**, the file will be loaded early to set
values for the compilers.
The **CMAKE\_CROSSCOMPILING** variable is set to true when CMake is
cross-compiling.

Note that using the **CMAKE\_SOURCE\_DIR** or **CMAKE\_BINARY\_DIR**
variables inside a toolchain file is typically undesirable.  The toolchain
file is used in contexts where these variables have different values when used
in different places (e.g. as part of a call to **try\_compile()**).  In most
cases, where there is a need to evaluate paths inside a toolchain file, the more
appropriate variable to use would be **CMAKE\_CURRENT\_LIST\_DIR**, since
it always has an unambiguous, predictable value.

<a name="cross-compiling-for-linux"></a>

### Cross Compiling for Linux


A typical cross-compiling toolchain for Linux has content such
as:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME Linux)
    set(CMAKE_SYSTEM_PROCESSOR arm)
    
    set(CMAKE_SYSROOT /home/devel/rasp-pi-rootfs)
    set(CMAKE_STAGING_PREFIX /home/devel/stage)
    
    set(tools /home/devel/gcc-4.7-linaro-rpi-gnueabihf)
    set(CMAKE_C_COMPILER ${tools}/bin/arm-linux-gnueabihf-gcc)
    set(CMAKE_CXX_COMPILER ${tools}/bin/arm-linux-gnueabihf-g++)
    
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
    .ft P
.UNINDENT
.UNINDENT

The **CMAKE\_SYSTEM\_NAME** is the CMake-identifier of the target platform
to build for.

The **CMAKE\_SYSTEM\_PROCESSOR** is the CMake-identifier of the target architecture
to build for.

The **CMAKE\_SYSROOT** is optional, and may be specified if a sysroot
is available.

The **CMAKE\_STAGING\_PREFIX** is also optional. It may be used to specify
a path on the host to install to. The **CMAKE\_INSTALL\_PREFIX** is always
the runtime installation location, even when cross-compiling.

The **CMAKE\_&lt;LANG&gt;\_COMPILER** variables may be set to full paths, or to
names of compilers to search for in standard locations.   For toolchains that
do not support linking binaries without custom flags or scripts one may set
the **CMAKE\_TRY\_COMPILE\_TARGET\_TYPE** variable to **STATIC\_LIBRARY**
to tell CMake not to try to link executables during its checks.

CMake **find\_*** commands will look in the sysroot, and the **CMAKE\_FIND\_ROOT\_PATH**
entries by default in all cases, as well as looking in the host system root prefix.
Although this can be controlled on a case-by-case basis, when cross-compiling, it
can be useful to exclude looking in either the host or the target for particular
artifacts. Generally, includes, libraries and packages should be found in the
target system prefixes, whereas executables which must be run as part of the build
should be found only on the host and not on the target. This is the purpose of
the **CMAKE\_FIND\_ROOT\_PATH\_MODE\_*** variables.

<a name="cross-compiling-for-the-cray-linux-environment"></a>

### Cross Compiling for the Cray Linux Environment


Cross compiling for compute nodes in the Cray Linux Environment can be done
without needing a separate toolchain file.  Specifying
**-DCMAKE\_SYSTEM\_NAME=CrayLinuxEnvironment** on the CMake command line will
ensure that the appropriate build settings and search paths are configured.
The platform will pull its configuration from the current environment
variables and will configure a project to use the compiler wrappers from the
Cray Programming Environment’s **PrgEnv-*** modules if present and loaded.

The default configuration of the Cray Programming Environment is to only
support static libraries.  This can be overridden and shared libraries
enabled by setting the **CRAYPE\_LINK\_TYPE** environment variable to
**dynamic**.

Running CMake without specifying **CMAKE\_SYSTEM\_NAME** will
run the configure step in host mode assuming a standard Linux environment.
If not overridden, the **PrgEnv-*** compiler wrappers will end up getting used,
which if targeting the either the login node or compute node, is likely not the
desired behavior.  The exception to this would be if you are building directly
on a NID instead of cross-compiling from a login node. If trying to build
software for a login node, you will need to either first unload the
currently loaded **PrgEnv-*** module or explicitly tell CMake to use the
system compilers in **/usr/bin** instead of the Cray wrappers.  If instead
targeting a compute node is desired, just specify the
**CMAKE\_SYSTEM\_NAME** as mentioned above.

<a name="cross-compiling-using-clang"></a>

### Cross Compiling using Clang


Some compilers such as Clang are inherently cross compilers.
The **CMAKE\_&lt;LANG&gt;\_COMPILER\_TARGET** can be set to pass a
value to those supported compilers when compiling:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME Linux)
    set(CMAKE_SYSTEM_PROCESSOR arm)
    
    set(triple arm-linux-gnueabihf)
    
    set(CMAKE_C_COMPILER clang)
    set(CMAKE_C_COMPILER_TARGET ${triple})
    set(CMAKE_CXX_COMPILER clang++)
    set(CMAKE_CXX_COMPILER_TARGET ${triple})
    .ft P
.UNINDENT
.UNINDENT

Similarly, some compilers do not ship their own supplementary utilities
such as linkers, but provide a way to specify the location of the external
toolchain which will be used by the compiler driver. The
**CMAKE\_&lt;LANG&gt;\_COMPILER\_EXTERNAL\_TOOLCHAIN** variable can be set in a
toolchain file to pass the path to the compiler driver.

<a name="cross-compiling-for-qnx"></a>

### Cross Compiling for QNX


As the Clang compiler the QNX QCC compile is inherently a cross compiler.
And the **CMAKE\_&lt;LANG&gt;\_COMPILER\_TARGET** can be set to pass a
value to those supported compilers when compiling:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME QNX)
    
    set(arch gcc_ntoarmv7le)
    
    set(CMAKE_C_COMPILER qcc)
    set(CMAKE_C_COMPILER_TARGET ${arch})
    set(CMAKE_CXX_COMPILER QCC)
    set(CMAKE_CXX_COMPILER_TARGET ${arch})
    
    set(CMAKE_SYSROOT $ENV{QNX_TARGET})
    .ft P
.UNINDENT
.UNINDENT

<a name="cross-compiling-for-windows-ce"></a>

### Cross Compiling for Windows CE


Cross compiling for Windows CE requires the corresponding SDK being
installed on your system.  These SDKs are usually installed under
**C:/Program Files (x86)/Windows CE Tools/SDKs**.

A toolchain file to configure a Visual Studio generator for
Windows CE may look like this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME WindowsCE)
    
    set(CMAKE_SYSTEM_VERSION 8.0)
    set(CMAKE_SYSTEM_PROCESSOR arm)
    
    set(CMAKE_GENERATOR_TOOLSET CE800) # Can be omitted for 8.0
    set(CMAKE_GENERATOR_PLATFORM SDK_AM335X_SK_WEC2013_V310)
    .ft P
.UNINDENT
.UNINDENT

The **CMAKE\_GENERATOR\_PLATFORM** tells the generator which SDK to use.
Further **CMAKE\_SYSTEM\_VERSION** tells the generator what version of
Windows CE to use.  Currently version 8.0 (Windows Embedded Compact 2013) is
supported out of the box.  Other versions may require one to set
**CMAKE\_GENERATOR\_TOOLSET** to the correct value.

<a name="cross-compiling-for-windows-10-universal-applications"></a>

### Cross Compiling for Windows 10 Universal Applications


A toolchain file to configure a Visual Studio generator for a
Windows 10 Universal Application may look like this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME WindowsStore)
    set(CMAKE_SYSTEM_VERSION 10.0)
    .ft P
.UNINDENT
.UNINDENT

A Windows 10 Universal Application targets both Windows Store and
Windows Phone.  Specify the **CMAKE\_SYSTEM\_VERSION** variable
to be **10.0** to build with the latest available Windows 10 SDK.
Specify a more specific version (e.g. **10.0.10240.0** for RTM)
to build with the corresponding SDK.

<a name="cross-compiling-for-windows-phone"></a>

### Cross Compiling for Windows Phone


A toolchain file to configure a Visual Studio generator for
Windows Phone may look like this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME WindowsPhone)
    set(CMAKE_SYSTEM_VERSION 8.1)
    .ft P
.UNINDENT
.UNINDENT

<a name="cross-compiling-for-windows-store"></a>

### Cross Compiling for Windows Store


A toolchain file to configure a Visual Studio generator for
Windows Store may look like this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME WindowsStore)
    set(CMAKE_SYSTEM_VERSION 8.1)
    .ft P
.UNINDENT
.UNINDENT

<a name="cross-compiling-for-android"></a>

### Cross Compiling for Android


A toolchain file may configure cross-compiling for Android by setting the
**CMAKE\_SYSTEM\_NAME** variable to **Android**.  Further configuration
is specific to the Android development environment to be used.

For Visual Studio Generators, CMake expects NVIDIA Nsight Tegra
Visual Studio Edition to be installed.  See that section for further
configuration details.

For Makefile Generators and the **Ninja** generator,
CMake expects one of these environments:
.INDENT 0.0

* ·  
  _NDK_
* ·  
  _Standalone Toolchain_
  .UNINDENT

CMake uses the following steps to select one of the environments:
.INDENT 0.0

* ·  
  If the **CMAKE\_ANDROID\_NDK** variable is set, the NDK at the
  specified location will be used.
* ·  
  Else, if the **CMAKE\_ANDROID\_STANDALONE\_TOOLCHAIN** variable
  is set, the Standalone Toolchain at the specified location will be used.
* ·  
  Else, if the **CMAKE\_SYSROOT** variable is set to a directory
  of the form **&lt;ndk&gt;/platforms/android-&lt;api&gt;/arch-&lt;arch&gt;**, the **&lt;ndk&gt;**
  part will be used as the value of **CMAKE\_ANDROID\_NDK** and the
  NDK will be used.
* ·  
  Else, if the **CMAKE\_SYSROOT** variable is set to a directory of the
  form **&lt;standalone-toolchain&gt;/sysroot**, the **&lt;standalone-toolchain&gt;** part
  will be used as the value of **CMAKE\_ANDROID\_STANDALONE\_TOOLCHAIN**
  and the Standalone Toolchain will be used.
* ·  
  Else, if a cmake variable **ANDROID\_NDK** is set it will be used
  as the value of **CMAKE\_ANDROID\_NDK**, and the NDK will be used.
* ·  
  Else, if a cmake variable **ANDROID\_STANDALONE\_TOOLCHAIN** is set, it will be
  used as the value of **CMAKE\_ANDROID\_STANDALONE\_TOOLCHAIN**, and the
  Standalone Toolchain will be used.
* ·  
  Else, if an environment variable **ANDROID\_NDK\_ROOT** or
  **ANDROID\_NDK** is set, it will be used as the value of
  **CMAKE\_ANDROID\_NDK**, and the NDK will be used.
* ·  
  Else, if an environment variable **ANDROID\_STANDALONE\_TOOLCHAIN** is
  set then it will be used as the value of
  **CMAKE\_ANDROID\_STANDALONE\_TOOLCHAIN**, and the Standalone
  Toolchain will be used.
* ·  
  Else, an error diagnostic will be issued that neither the NDK or
  Standalone Toolchain can be found.
  .UNINDENT

<a name="cross-compiling-for-android-with-the-ndk"></a>

### Cross Compiling for Android with the NDK


A toolchain file may configure Makefile Generators or the
**Ninja** generator to target Android for cross-compiling.

Configure use of an Android NDK with the following variables:
.INDENT 0.0

* <b>**CMAKE\_SYSTEM\_NAME**</b>  
  Set to **Android**.  Must be specified to enable cross compiling
  for Android.
* <b>**CMAKE\_SYSTEM\_VERSION**</b>  
  Set to the Android API level.  If not specified, the value is
  determined as follows:
  .INDENT 7.0
* ·  
  If the **CMAKE\_ANDROID\_API** variable is set, its value
  is used as the API level.
* ·  
  If the **CMAKE\_SYSROOT** variable is set, the API level is
  detected from the NDK directory structure containing the sysroot.
* ·  
  Otherwise, the latest API level available in the NDK is used.
  .UNINDENT
* <b>**CMAKE\_ANDROID\_ARCH\_ABI**</b>  
  Set to the Android ABI (architecture).  If not specified, this
  variable will default to **armeabi**.
  The **CMAKE\_ANDROID\_ARCH** variable will be computed
  from **CMAKE\_ANDROID\_ARCH\_ABI** automatically.
  Also see the **CMAKE\_ANDROID\_ARM\_MODE** and
  **CMAKE\_ANDROID\_ARM\_NEON** variables.
* <b>**CMAKE\_ANDROID\_NDK**</b>  
  Set to the absolute path to the Android NDK root directory.
  A **${CMAKE\_ANDROID\_NDK}/platforms** directory must exist.
  If not specified, a default for this variable will be chosen
  as specified _above_.
* <b>**CMAKE\_ANDROID\_NDK\_DEPRECATED\_HEADERS**</b>  
  Set to a true value to use the deprecated per-api-level headers
  instead of the unified headers.  If not specified, the default will
  be false unless using a NDK that does not provide unified headers.
* <b>**CMAKE\_ANDROID\_NDK\_TOOLCHAIN\_VERSION**</b>  
  On NDK r19 or above, this variable must be unset or set to **clang**.
  On NDK r18 or below, set this to the version of the NDK toolchain to
  be selected as the compiler.  If not specified, the default will be
  the latest available GCC toolchain.
* <b>**CMAKE\_ANDROID\_STL\_TYPE**</b>  
  Set to specify which C++ standard library to use.  If not specified,
  a default will be selected as described in the variable documentation.
  .UNINDENT

The following variables will be computed and provided automatically:
.INDENT 0.0

* <b>**CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_PREFIX**</b>  
  The absolute path prefix to the binutils in the NDK toolchain.
* <b>**CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_SUFFIX**</b>  
  The host platform suffix of the binutils in the NDK toolchain.
  .UNINDENT

For example, a toolchain file might contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME Android)
    set(CMAKE_SYSTEM_VERSION 21) # API level
    set(CMAKE_ANDROID_ARCH_ABI arm64-v8a)
    set(CMAKE_ANDROID_NDK /path/to/android-ndk)
    set(CMAKE_ANDROID_STL_TYPE gnustl_static)
    .ft P
.UNINDENT
.UNINDENT

Alternatively one may specify the values without a toolchain file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ cmake ../src e
      -DCMAKE_SYSTEM_NAME=Android e
      -DCMAKE_SYSTEM_VERSION=21 e
      -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a e
      -DCMAKE_ANDROID_NDK=/path/to/android-ndk e
      -DCMAKE_ANDROID_STL_TYPE=gnustl_static
    .ft P
.UNINDENT
.UNINDENT

<a name="cross-compiling-for-android-with-a-standalone-toolchain"></a>

### Cross Compiling for Android with a Standalone Toolchain


A toolchain file may configure Makefile Generators or the
**Ninja** generator to target Android for cross-compiling
using a standalone toolchain.

Configure use of an Android standalone toolchain with the following variables:
.INDENT 0.0

* <b>**CMAKE\_SYSTEM\_NAME**</b>  
  Set to **Android**.  Must be specified to enable cross compiling
  for Android.
* <b>**CMAKE\_ANDROID\_STANDALONE\_TOOLCHAIN**</b>  
  Set to the absolute path to the standalone toolchain root directory.
  A **${CMAKE\_ANDROID\_STANDALONE\_TOOLCHAIN}/sysroot** directory
  must exist.
  If not specified, a default for this variable will be chosen
  as specified _above_.
* <b>**CMAKE\_ANDROID\_ARM\_MODE**</b>  
  When the standalone toolchain targets ARM, optionally set this to **ON**
  to target 32-bit ARM instead of 16-bit Thumb.
  See variable documentation for details.
* <b>**CMAKE\_ANDROID\_ARM\_NEON**</b>  
  When the standalone toolchain targets ARM v7, optionally set thisto **ON**
  to target ARM NEON devices.  See variable documentation for details.
  .UNINDENT

The following variables will be computed and provided automatically:
.INDENT 0.0

* <b>**CMAKE\_SYSTEM\_VERSION**</b>  
  The Android API level detected from the standalone toolchain.
* <b>**CMAKE\_ANDROID\_ARCH\_ABI**</b>  
  The Android ABI detected from the standalone toolchain.
* <b>**CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_PREFIX**</b>  
  The absolute path prefix to the **binutils** in the standalone toolchain.
* <b>**CMAKE\_&lt;LANG&gt;\_ANDROID\_TOOLCHAIN\_SUFFIX**</b>  
  The host platform suffix of the **binutils** in the standalone toolchain.
  .UNINDENT

For example, a toolchain file might contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME Android)
    set(CMAKE_ANDROID_STANDALONE_TOOLCHAIN /path/to/android-toolchain)
    .ft P
.UNINDENT
.UNINDENT

Alternatively one may specify the values without a toolchain file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ cmake ../src e
      -DCMAKE_SYSTEM_NAME=Android e
      -DCMAKE_ANDROID_STANDALONE_TOOLCHAIN=/path/to/android-toolchain
    .ft P
.UNINDENT
.UNINDENT

<a name="cross-compiling-for-android-with-nvidia-nsight-tegra-visual-studio-edition"></a>

### Cross Compiling for Android with NVIDIA Nsight Tegra Visual Studio Edition


A toolchain file to configure one of the Visual Studio Generators
to build using NVIDIA Nsight Tegra targeting Android may look like this:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_SYSTEM_NAME Android)
    .ft P
.UNINDENT
.UNINDENT

The **CMAKE\_GENERATOR\_TOOLSET** may be set to select
the Nsight Tegra “Toolchain Version” value.

See also target properties:
.INDENT 0.0

* ·  
  **ANDROID\_ANT\_ADDITIONAL\_OPTIONS**
* ·  
  **ANDROID\_API\_MIN**
* ·  
  **ANDROID\_API**
* ·  
  **ANDROID\_ARCH**
* ·  
  **ANDROID\_ASSETS\_DIRECTORIES**
* ·  
  **ANDROID\_GUI**
* ·  
  **ANDROID\_JAR\_DEPENDENCIES**
* ·  
  **ANDROID\_JAR\_DIRECTORIES**
* ·  
  **ANDROID\_JAVA\_SOURCE\_DIR**
* ·  
  **ANDROID\_NATIVE\_LIB\_DEPENDENCIES**
* ·  
  **ANDROID\_NATIVE\_LIB\_DIRECTORIES**
* ·  
  **ANDROID\_PROCESS\_MAX**
* ·  
  **ANDROID\_PROGUARD\_CONFIG\_PATH**
* ·  
  **ANDROID\_PROGUARD**
* ·  
  **ANDROID\_SECURE\_PROPS\_PATH**
* ·  
  **ANDROID\_SKIP\_ANT\_STEP**
* ·  
  **ANDROID\_STL\_TYPE**
  .UNINDENT

<a name="cross-compiling-for-ios-tvos-or-watchos"></a>

### Cross Compiling for iOS, tvOS, or watchOS


For cross-compiling to iOS, tvOS, or watchOS, the **Xcode**
generator is recommended.  The **Unix Makefiles** or
**Ninja** generators can also be used, but they require the
project to handle more areas like target CPU selection and code signing.

Any of the three systems can be targeted by setting the
**CMAKE\_SYSTEM\_NAME** variable to a value from the table below.
By default, the latest Device SDK is chosen.  As for all Apple platforms,
a different SDK (e.g. a simulator) can be selected by setting the
**CMAKE\_OSX\_SYSROOT** variable, although this should rarely be
necessary (see _Switching Between Device and Simulator_ below).
A list of available SDKs can be obtained by running **xcodebuild -showsdks**.
.TS
center;
|l|l|l|l|.
_
T{
OS
T}	T{
CMAKE_SYSTEM_NAME
T}	T{
Device SDK (default)
T}	T{
Simulator SDK
T}
_
T{
iOS
T}	T{
iOS
T}	T{
iphoneos
T}	T{
iphonesimulator
T}
_
T{
tvOS
T}	T{
tvOS
T}	T{
appletvos
T}	T{
appletvsimulator
T}
_
T{
watchOS
T}	T{
watchOS
T}	T{
watchos
T}	T{
watchsimulator
T}
_
.TE

For example, to create a CMake configuration for iOS, the following
command is sufficient:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake .. -GXcode -DCMAKE_SYSTEM_NAME=iOS
    .ft P
.UNINDENT
.UNINDENT

Variable **CMAKE\_OSX\_ARCHITECTURES** can be used to set architectures
for both device and simulator. Variable **CMAKE\_OSX\_DEPLOYMENT\_TARGET**
can be used to set an iOS/tvOS/watchOS deployment target.

Next configuration will install fat 5 architectures iOS library
and add the **-miphoneos-version-min=9.3**/**-mios-simulator-version-min=9.3**
flags to the compiler:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ cmake -S. -B_builds -GXcode e
        -DCMAKE_SYSTEM_NAME=iOS e
        "-DCMAKE_OSX_ARCHITECTURES=armv7;armv7s;arm64;i386;x86_64" e
        -DCMAKE_OSX_DEPLOYMENT_TARGET=9.3 e
        -DCMAKE_INSTALL_PREFIX=`pwd`/_install e
        -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO e
        -DCMAKE_IOS_INSTALL_COMBINED=YES
    .ft P
.UNINDENT
.UNINDENT

Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # CMakeLists.txt
    cmake_minimum_required(VERSION 3.14)
    project(foo)
    add_library(foo foo.cpp)
    install(TARGETS foo DESTINATION lib)
    .ft P
.UNINDENT
.UNINDENT

Install:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ cmake --build _builds --config Release --target install
    .ft P
.UNINDENT
.UNINDENT

Check library:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ lipo -info _install/lib/libfoo.a
    Architectures in the fat file: _install/lib/libfoo.a are: i386 armv7 armv7s x86_64 arm64
    .ft P
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ otool -l _install/lib/libfoo.a | grep -A2 LC_VERSION_MIN_IPHONEOS
          cmd LC_VERSION_MIN_IPHONEOS
      cmdsize 16
      version 9.3
    .ft P
.UNINDENT
.UNINDENT

<a name="code-signing"></a>

### Code Signing


Some build artifacts for the embedded Apple platforms require mandatory
code signing.  If the **Xcode** generator is being used and
code signing is required or desired, the development team ID can be
specified via the **CMAKE\_XCODE\_ATTRIBUTE\_DEVELOPMENT\_TEAM** CMake variable.
This team ID will then be included in the generated Xcode project.
By default, CMake avoids the need for code signing during the internal
configuration phase (i.e compiler ID and feature detection).

<a name="switching-between-device-and-simulator"></a>

### Switching Between Device and Simulator


When configuring for any of the embedded platforms, one can target either
real devices or the simulator.  Both have their own separate SDK, but CMake
only supports specifying a single SDK for the configuration phase.  This
means the developer must select one or the other at configuration time.
When using the **Xcode** generator, this is less of a limitation
because Xcode still allows you to build for either a device or a simulator,
even though configuration was only performed for one of the two.  From
within the Xcode IDE, builds are performed for the selected “destination”
platform.  When building from the command line, the desired sdk can be
specified directly by passing a **-sdk** option to the underlying build
tool (**xcodebuild**).  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ cmake --build ... -- -sdk iphonesimulator
    .ft P
.UNINDENT
.UNINDENT

Please note that checks made during configuration were performed against
the configure-time SDK and might not hold true for other SDKs.  Commands
like **find\_package()**, **find\_library()**, etc. store and use
details only for the configured SDK/platform, so they can be problematic
if wanting to switch between device and simulator builds. You can follow
the next rules to make device + simulator configuration work:
.INDENT 0.0

* ·  
  Use explicit **-l** linker flag,
  e.g. **target_link_libraries(foo PUBLIC "-lz")**
* ·  
  Use explicit **-framework** linker flag,
  e.g. **target_link_libraries(foo PUBLIC "-framework CoreFoundation")**
* ·  
  Use **find\_package()** only for libraries installed with
  **CMAKE\_IOS\_INSTALL\_COMBINED** feature
  .UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

