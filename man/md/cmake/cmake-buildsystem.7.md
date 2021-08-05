# cmake-buildsystem(7) - CMake Buildsystem Reference

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


A CMake-based buildsystem is organized as a set of high-level logical
targets.  Each target corresponds to an executable or library, or
is a custom target containing custom commands.  Dependencies between the
targets are expressed in the buildsystem to determine the build order
and the rules for regeneration in response to change.

<a name="binary-targets"></a>

# Binary Targets


Executables and libraries are defined using the **add\_executable()**
and **add\_library()** commands.  The resulting binary files have
appropriate **PREFIX**, **SUFFIX** and extensions for the platform targeted.
Dependencies between binary targets are expressed using the
**target\_link\_libraries()** command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(archive archive.cpp zip.cpp lzma.cpp)
    add_executable(zipapp zipapp.cpp)
    target_link_libraries(zipapp archive)
    .ft P
.UNINDENT
.UNINDENT

**archive** is defined as a **STATIC** library – an archive containing objects
compiled from **archive.cpp**, **zip.cpp**, and **lzma.cpp**.  **zipapp**
is defined as an executable formed by compiling and linking **zipapp.cpp**.
When linking the **zipapp** executable, the **archive** static library is
linked in.

<a name="binary-executables"></a>

### Binary Executables


The **add\_executable()** command defines an executable target:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(mytool mytool.cpp)
    .ft P
.UNINDENT
.UNINDENT

Commands such as **add\_custom\_command()**, which generates rules to be
run at build time can transparently use an **EXECUTABLE**
target as a **COMMAND** executable.  The buildsystem rules will ensure that
the executable is built before attempting to run the command.

<a name="binary-library-types"></a>

### Binary Library Types


<a name="normal-libraries"></a>

### Normal Libraries


By default, the **add\_library()** command defines a **STATIC** library,
unless a type is specified.  A type may be specified when using the command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(archive SHARED archive.cpp zip.cpp lzma.cpp)
    .ft P
.UNINDENT
.UNINDENT
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(archive STATIC archive.cpp zip.cpp lzma.cpp)
    .ft P
.UNINDENT
.UNINDENT

The **BUILD\_SHARED\_LIBS** variable may be enabled to change the
behavior of **add\_library()** to build shared libraries by default.

In the context of the buildsystem definition as a whole, it is largely
irrelevant whether particular libraries are **SHARED** or **STATIC** –
the commands, dependency specifications and other APIs work similarly
regardless of the library type.  The **MODULE** library type is
dissimilar in that it is generally not linked to – it is not used in
the right-hand-side of the **target\_link\_libraries()** command.
It is a type which is loaded as a plugin using runtime techniques.
If the library does not export any unmanaged symbols (e.g. Windows
resource DLL, C++/CLI DLL), it is required that the library not be a
**SHARED** library because CMake expects **SHARED** libraries to export
at least one symbol.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(archive MODULE 7z.cpp)
    .ft P
.UNINDENT
.UNINDENT

<a name="apple-frameworks"></a>

### Apple Frameworks


A **SHARED** library may be marked with the **FRAMEWORK**
target property to create an macOS or iOS Framework Bundle.
The **MACOSX\_FRAMEWORK\_IDENTIFIER** sets **CFBundleIdentifier** key
and it uniquely identifies the bundle.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(MyFramework SHARED MyFramework.cpp)
    set_target_properties(MyFramework PROPERTIES
      FRAMEWORK TRUE
      FRAMEWORK_VERSION A
      MACOSX_FRAMEWORK_IDENTIFIER org.cmake.MyFramework
    )
    .ft P
.UNINDENT
.UNINDENT

<a name="object-libraries"></a>

### Object Libraries


The **OBJECT** library type defines a non-archival collection of object files
resulting from compiling the given source files.  The object files collection
may be used as source inputs to other targets:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(archive OBJECT archive.cpp zip.cpp lzma.cpp)
    
    add_library(archiveExtras STATIC $<TARGET_OBJECTS:archive> extras.cpp)
    
    add_executable(test_exe $<TARGET_OBJECTS:archive> test.cpp)
    .ft P
.UNINDENT
.UNINDENT

The link (or archiving) step of those other targets will use the object
files collection in addition to those from their own sources.

Alternatively, object libraries may be linked into other targets:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(archive OBJECT archive.cpp zip.cpp lzma.cpp)
    
    add_library(archiveExtras STATIC extras.cpp)
    target_link_libraries(archiveExtras PUBLIC archive)
    
    add_executable(test_exe test.cpp)
    target_link_libraries(test_exe archive)
    .ft P
.UNINDENT
.UNINDENT

The link (or archiving) step of those other targets will use the object
files from **OBJECT** libraries that are _directly_ linked.  Additionally,
usage requirements of the **OBJECT** libraries will be honored when compiling
sources in those other targets.  Furthermore, those usage requirements
will propagate transitively to dependents of those other targets.

Object libraries may not be used as the **TARGET** in a use of the
**add\_custom\_command(TARGET)** command signature.  However,
the list of objects can be used by **add\_custom\_command(OUTPUT)**
or **file(GENERATE)** by using **$&lt;TARGET\_OBJECTS:objlib&gt;**.

<a name="build-specification-and-usage-requirements"></a>

# Build Specification and Usage Requirements


The **target\_include\_directories()**, **target\_compile\_definitions()**
and **target\_compile\_options()** commands specify the build specifications
and the usage requirements of binary targets.  The commands populate the
**INCLUDE\_DIRECTORIES**, **COMPILE\_DEFINITIONS** and
**COMPILE\_OPTIONS** target properties respectively, and/or the
**INTERFACE\_INCLUDE\_DIRECTORIES**, **INTERFACE\_COMPILE\_DEFINITIONS**
and **INTERFACE\_COMPILE\_OPTIONS** target properties.

Each of the commands has a **PRIVATE**, **PUBLIC** and **INTERFACE** mode.  The
**PRIVATE** mode populates only the non-**INTERFACE\_** variant of the target
property and the **INTERFACE** mode populates only the **INTERFACE\_** variants.
The **PUBLIC** mode populates both variants of the respective target property.
Each command may be invoked with multiple uses of each keyword:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_compile_definitions(archive
      PRIVATE BUILDING_WITH_LZMA
      INTERFACE USING_ARCHIVE_LIB
    )
    .ft P
.UNINDENT
.UNINDENT

Note that usage requirements are not designed as a way to make downstreams
use particular **COMPILE\_OPTIONS** or
**COMPILE\_DEFINITIONS** etc for convenience only.  The contents of
the properties must be **requirements**, not merely recommendations or
convenience.

See the Creating Relocatable Packages section of the
**cmake-packages(7)** manual for discussion of additional care
that must be taken when specifying usage requirements while creating
packages for redistribution.

<a name="target-properties"></a>

### Target Properties


The contents of the **INCLUDE\_DIRECTORIES**,
**COMPILE\_DEFINITIONS** and **COMPILE\_OPTIONS** target
properties are used appropriately when compiling the source files of a
binary target.

Entries in the **INCLUDE\_DIRECTORIES** are added to the compile line
with **-I** or **-isystem** prefixes and in the order of appearance in the
property value.

Entries in the **COMPILE\_DEFINITIONS** are prefixed with **-D** or
**/D** and added to the compile line in an unspecified order.  The
**DEFINE\_SYMBOL** target property is also added as a compile
definition as a special convenience case for **SHARED** and **MODULE**
library targets.

Entries in the **COMPILE\_OPTIONS** are escaped for the shell and added
in the order of appearance in the property value.  Several compile options have
special separate handling, such as **POSITION\_INDEPENDENT\_CODE**.

The contents of the **INTERFACE\_INCLUDE\_DIRECTORIES**,
**INTERFACE\_COMPILE\_DEFINITIONS** and
**INTERFACE\_COMPILE\_OPTIONS** target properties are
_Usage Requirements_ – they specify content which consumers
must use to correctly compile and link with the target they appear on.
For any binary target, the contents of each **INTERFACE\_** property on
each target specified in a **target\_link\_libraries()** command is
consumed:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(srcs archive.cpp zip.cpp)
    if (LZMA_FOUND)
      list(APPEND srcs lzma.cpp)
    endif()
    add_library(archive SHARED ${srcs})
    if (LZMA_FOUND)
      # The archive library sources are compiled with -DBUILDING_WITH_LZMA
      target_compile_definitions(archive PRIVATE BUILDING_WITH_LZMA)
    endif()
    target_compile_definitions(archive INTERFACE USING_ARCHIVE_LIB)
    
    add_executable(consumer)
    # Link consumer to archive and consume its usage requirements. The consumer
    # executable sources are compiled with -DUSING_ARCHIVE_LIB.
    target_link_libraries(consumer archive)
    .ft P
.UNINDENT
.UNINDENT

Because it is common to require that the source directory and corresponding
build directory are added to the **INCLUDE\_DIRECTORIES**, the
**CMAKE\_INCLUDE\_CURRENT\_DIR** variable can be enabled to conveniently
add the corresponding directories to the **INCLUDE\_DIRECTORIES** of
all targets.  The variable **CMAKE\_INCLUDE\_CURRENT\_DIR\_IN\_INTERFACE**
can be enabled to add the corresponding directories to the
**INTERFACE\_INCLUDE\_DIRECTORIES** of all targets.  This makes use of
targets in multiple different directories convenient through use of the
**target\_link\_libraries()** command.

<a name="transitive-usage-requirements"></a>

### Transitive Usage Requirements


The usage requirements of a target can transitively propagate to dependents.
The **target\_link\_libraries()** command has **PRIVATE**,
**INTERFACE** and **PUBLIC** keywords to control the propagation.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(archive archive.cpp)
    target_compile_definitions(archive INTERFACE USING_ARCHIVE_LIB)
    
    add_library(serialization serialization.cpp)
    target_compile_definitions(serialization INTERFACE USING_SERIALIZATION_LIB)
    
    add_library(archiveExtras extras.cpp)
    target_link_libraries(archiveExtras PUBLIC archive)
    target_link_libraries(archiveExtras PRIVATE serialization)
    # archiveExtras is compiled with -DUSING_ARCHIVE_LIB
    # and -DUSING_SERIALIZATION_LIB
    
    add_executable(consumer consumer.cpp)
    # consumer is compiled with -DUSING_ARCHIVE_LIB
    target_link_libraries(consumer archiveExtras)
    .ft P
.UNINDENT
.UNINDENT

Because **archive** is a **PUBLIC** dependency of **archiveExtras**, the
usage requirements of it are propagated to **consumer** too.  Because
**serialization** is a **PRIVATE** dependency of **archiveExtras**, the usage
requirements of it are not propagated to **consumer**.

Generally, a dependency should be specified in a use of
**target\_link\_libraries()** with the **PRIVATE** keyword if it is used by
only the implementation of a library, and not in the header files.  If a
dependency is additionally used in the header files of a library (e.g. for
class inheritance), then it should be specified as a **PUBLIC** dependency.
A dependency which is not used by the implementation of a library, but only by
its headers should be specified as an **INTERFACE** dependency.  The
**target\_link\_libraries()** command may be invoked with multiple uses of
each keyword:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(archiveExtras
      PUBLIC archive
      PRIVATE serialization
    )
    .ft P
.UNINDENT
.UNINDENT

Usage requirements are propagated by reading the **INTERFACE\_** variants
of target properties from dependencies and appending the values to the
non-**INTERFACE\_** variants of the operand.  For example, the
**INTERFACE\_INCLUDE\_DIRECTORIES** of dependencies is read and
appended to the **INCLUDE\_DIRECTORIES** of the operand.  In cases
where order is relevant and maintained, and the order resulting from the
**target\_link\_libraries()** calls does not allow correct compilation,
use of an appropriate command to set the property directly may update the
order.

For example, if the linked libraries for a target must be specified
in the order **lib1** **lib2** **lib3** , but the include directories must
be specified in the order **lib3** **lib1** **lib2**:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(myExe lib1 lib2 lib3)
    target_include_directories(myExe
      PRIVATE $<TARGET_PROPERTY:lib3,INTERFACE_INCLUDE_DIRECTORIES>)
    .ft P
.UNINDENT
.UNINDENT

Note that care must be taken when specifying usage requirements for targets
which will be exported for installation using the **install(EXPORT)**
command.  See Creating Packages for more.

<a name="compatible-interface-properties"></a>

### Compatible Interface Properties


Some target properties are required to be compatible between a target and
the interface of each dependency.  For example, the
**POSITION\_INDEPENDENT\_CODE** target property may specify a
boolean value of whether a target should be compiled as
position-independent-code, which has platform-specific consequences.
A target may also specify the usage requirement
**INTERFACE\_POSITION\_INDEPENDENT\_CODE** to communicate that
consumers must be compiled as position-independent-code.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(exe1 exe1.cpp)
    set_property(TARGET exe1 PROPERTY POSITION_INDEPENDENT_CODE ON)
    
    add_library(lib1 SHARED lib1.cpp)
    set_property(TARGET lib1 PROPERTY INTERFACE_POSITION_INDEPENDENT_CODE ON)
    
    add_executable(exe2 exe2.cpp)
    target_link_libraries(exe2 lib1)
    .ft P
.UNINDENT
.UNINDENT

Here, both **exe1** and **exe2** will be compiled as position-independent-code.
**lib1** will also be compiled as position-independent-code because that is the
default setting for **SHARED** libraries.  If dependencies have conflicting,
non-compatible requirements **cmake(1)** issues a diagnostic:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1 SHARED lib1.cpp)
    set_property(TARGET lib1 PROPERTY INTERFACE_POSITION_INDEPENDENT_CODE ON)
    
    add_library(lib2 SHARED lib2.cpp)
    set_property(TARGET lib2 PROPERTY INTERFACE_POSITION_INDEPENDENT_CODE OFF)
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 lib1)
    set_property(TARGET exe1 PROPERTY POSITION_INDEPENDENT_CODE OFF)
    
    add_executable(exe2 exe2.cpp)
    target_link_libraries(exe2 lib1 lib2)
    .ft P
.UNINDENT
.UNINDENT

The **lib1** requirement **INTERFACE\_POSITION\_INDEPENDENT\_CODE** is not
“compatible” with the **POSITION\_INDEPENDENT\_CODE** property of
the **exe1** target.  The library requires that consumers are built as
position-independent-code, while the executable specifies to not built as
position-independent-code, so a diagnostic is issued.

The **lib1** and **lib2** requirements are not “compatible”.  One of them
requires that consumers are built as position-independent-code, while
the other requires that consumers are not built as position-independent-code.
Because **exe2** links to both and they are in conflict, a diagnostic is
issued.

To be “compatible”, the **POSITION\_INDEPENDENT\_CODE** property,
if set must be either the same, in a boolean sense, as the
**INTERFACE\_POSITION\_INDEPENDENT\_CODE** property of all transitively
specified dependencies on which that property is set.

This property of “compatible interface requirement” may be extended to other
properties by specifying the property in the content of the
**COMPATIBLE\_INTERFACE\_BOOL** target property.  Each specified property
must be compatible between the consuming target and the corresponding property
with an **INTERFACE\_** prefix from each dependency:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1Version2 SHARED lib1_v2.cpp)
    set_property(TARGET lib1Version2 PROPERTY INTERFACE_CUSTOM_PROP ON)
    set_property(TARGET lib1Version2 APPEND PROPERTY
      COMPATIBLE_INTERFACE_BOOL CUSTOM_PROP
    )
    
    add_library(lib1Version3 SHARED lib1_v3.cpp)
    set_property(TARGET lib1Version3 PROPERTY INTERFACE_CUSTOM_PROP OFF)
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 lib1Version2) # CUSTOM_PROP will be ON
    
    add_executable(exe2 exe2.cpp)
    target_link_libraries(exe2 lib1Version2 lib1Version3) # Diagnostic
    .ft P
.UNINDENT
.UNINDENT

Non-boolean properties may also participate in “compatible interface”
computations.  Properties specified in the
**COMPATIBLE\_INTERFACE\_STRING**
property must be either unspecified or compare to the same string among
all transitively specified dependencies. This can be useful to ensure
that multiple incompatible versions of a library are not linked together
through transitive requirements of a target:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1Version2 SHARED lib1_v2.cpp)
    set_property(TARGET lib1Version2 PROPERTY INTERFACE_LIB_VERSION 2)
    set_property(TARGET lib1Version2 APPEND PROPERTY
      COMPATIBLE_INTERFACE_STRING LIB_VERSION
    )
    
    add_library(lib1Version3 SHARED lib1_v3.cpp)
    set_property(TARGET lib1Version3 PROPERTY INTERFACE_LIB_VERSION 3)
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 lib1Version2) # LIB_VERSION will be "2"
    
    add_executable(exe2 exe2.cpp)
    target_link_libraries(exe2 lib1Version2 lib1Version3) # Diagnostic
    .ft P
.UNINDENT
.UNINDENT

The **COMPATIBLE\_INTERFACE\_NUMBER\_MAX** target property specifies
that content will be evaluated numerically and the maximum number among all
specified will be calculated:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1Version2 SHARED lib1_v2.cpp)
    set_property(TARGET lib1Version2 PROPERTY INTERFACE_CONTAINER_SIZE_REQUIRED 200)
    set_property(TARGET lib1Version2 APPEND PROPERTY
      COMPATIBLE_INTERFACE_NUMBER_MAX CONTAINER_SIZE_REQUIRED
    )
    
    add_library(lib1Version3 SHARED lib1_v3.cpp)
    set_property(TARGET lib1Version3 PROPERTY INTERFACE_CONTAINER_SIZE_REQUIRED 1000)
    
    add_executable(exe1 exe1.cpp)
    # CONTAINER_SIZE_REQUIRED will be "200"
    target_link_libraries(exe1 lib1Version2)
    
    add_executable(exe2 exe2.cpp)
    # CONTAINER_SIZE_REQUIRED will be "1000"
    target_link_libraries(exe2 lib1Version2 lib1Version3)
    .ft P
.UNINDENT
.UNINDENT

Similarly, the **COMPATIBLE\_INTERFACE\_NUMBER\_MIN** may be used to
calculate the numeric minimum value for a property from dependencies.

Each calculated “compatible” property value may be read in the consumer at
generate-time using generator expressions.

Note that for each dependee, the set of properties specified in each
compatible interface property must not intersect with the set specified in
any of the other properties.

<a name="property-origin-debugging"></a>

### Property Origin Debugging


Because build specifications can be determined by dependencies, the lack of
locality of code which creates a target and code which is responsible for
setting build specifications may make the code more difficult to reason about.
**cmake(1)** provides a debugging facility to print the origin of the
contents of properties which may be determined by dependencies.  The properties
which can be debugged are listed in the
**CMAKE\_DEBUG\_TARGET\_PROPERTIES** variable documentation:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_DEBUG_TARGET_PROPERTIES
      INCLUDE_DIRECTORIES
      COMPILE_DEFINITIONS
      POSITION_INDEPENDENT_CODE
      CONTAINER_SIZE_REQUIRED
      LIB_VERSION
    )
    add_executable(exe1 exe1.cpp)
    .ft P
.UNINDENT
.UNINDENT

In the case of properties listed in **COMPATIBLE\_INTERFACE\_BOOL** or
**COMPATIBLE\_INTERFACE\_STRING**, the debug output shows which target
was responsible for setting the property, and which other dependencies also
defined the property.  In the case of
**COMPATIBLE\_INTERFACE\_NUMBER\_MAX** and
**COMPATIBLE\_INTERFACE\_NUMBER\_MIN**, the debug output shows the
value of the property from each dependency, and whether the value determines
the new extreme.

<a name="build-specification-with-generator-expressions"></a>

### Build Specification with Generator Expressions


Build specifications may use
**generator expressions** containing
content which may be conditional or known only at generate-time.  For example,
the calculated “compatible” value of a property may be read with the
**TARGET\_PROPERTY** expression:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1Version2 SHARED lib1_v2.cpp)
    set_property(TARGET lib1Version2 PROPERTY
      INTERFACE_CONTAINER_SIZE_REQUIRED 200)
    set_property(TARGET lib1Version2 APPEND PROPERTY
      COMPATIBLE_INTERFACE_NUMBER_MAX CONTAINER_SIZE_REQUIRED
    )
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 lib1Version2)
    target_compile_definitions(exe1 PRIVATE
        CONTAINER_SIZE=$<TARGET_PROPERTY:CONTAINER_SIZE_REQUIRED>
    )
    .ft P
.UNINDENT
.UNINDENT

In this case, the **exe1** source files will be compiled with
**-DCONTAINER\_SIZE=200**.

Configuration determined build specifications may be conveniently set using
the **CONFIG** generator expression.
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_compile_definitions(exe1 PRIVATE
        $<$<CONFIG:Debug>:DEBUG_BUILD>
    )
    .ft P
.UNINDENT
.UNINDENT

The **CONFIG** parameter is compared case-insensitively with the configuration
being built.  In the presence of **IMPORTED** targets, the content of
**MAP\_IMPORTED\_CONFIG\_DEBUG** is also
accounted for by this expression.

Some buildsystems generated by **cmake(1)** have a predetermined
build-configuration set in the **CMAKE\_BUILD\_TYPE** variable.  The
buildsystem for the IDEs such as Visual Studio and Xcode are generated
independent of the build-configuration, and the actual build configuration
is not known until build-time.  Therefore, code such as
.INDENT 0.0
.INDENT 3.5

    .ft C
    string(TOLOWER ${CMAKE_BUILD_TYPE} _type)
    if (_type STREQUAL debug)
      target_compile_definitions(exe1 PRIVATE DEBUG_BUILD)
    endif()
    .ft P
.UNINDENT
.UNINDENT

may appear to work for Makefile Generators and **Ninja**
generators, but is not portable to IDE generators.  Additionally,
the **IMPORTED** configuration-mappings are not accounted for
with code like this, so it should be avoided.

The unary **TARGET\_PROPERTY** generator expression and the **TARGET\_POLICY**
generator expression are evaluated with the consuming target context.  This
means that a usage requirement specification may be evaluated differently based
on the consumer:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1 lib1.cpp)
    target_compile_definitions(lib1 INTERFACE
      $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:LIB1_WITH_EXE>
      $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:LIB1_WITH_SHARED_LIB>
      $<$<TARGET_POLICY:CMP0041>:CONSUMER_CMP0041_NEW>
    )
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 lib1)
    
    cmake_policy(SET CMP0041 NEW)
    
    add_library(shared_lib shared_lib.cpp)
    target_link_libraries(shared_lib lib1)
    .ft P
.UNINDENT
.UNINDENT

The **exe1** executable will be compiled with **-DLIB1\_WITH\_EXE**, while the
**shared\_lib** shared library will be compiled with **-DLIB1\_WITH\_SHARED\_LIB**
and **-DCONSUMER\_CMP0041\_NEW**, because policy **CMP0041** is
**NEW** at the point where the **shared\_lib** target is created.

The **BUILD\_INTERFACE** expression wraps requirements which are only used when
consumed from a target in the same buildsystem, or when consumed from a target
exported to the build directory using the **export()** command.  The
**INSTALL\_INTERFACE** expression wraps requirements which are only used when
consumed from a target which has been installed and exported with the
**install(EXPORT)** command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(ClimbingStats climbingstats.cpp)
    target_compile_definitions(ClimbingStats INTERFACE
      $<BUILD_INTERFACE:ClimbingStats_FROM_BUILD_LOCATION>
      $<INSTALL_INTERFACE:ClimbingStats_FROM_INSTALLED_LOCATION>
    )
    install(TARGETS ClimbingStats EXPORT libExport ${InstallArgs})
    install(EXPORT libExport NAMESPACE Upstream::
            DESTINATION lib/cmake/ClimbingStats)
    export(EXPORT libExport NAMESPACE Upstream::)
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 ClimbingStats)
    .ft P
.UNINDENT
.UNINDENT

In this case, the **exe1** executable will be compiled with
**-DClimbingStats\_FROM\_BUILD\_LOCATION**.  The exporting commands generate
**IMPORTED** targets with either the **INSTALL\_INTERFACE** or the
**BUILD\_INTERFACE** omitted, and the ***\_INTERFACE** marker stripped away.
A separate project consuming the **ClimbingStats** package would contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_package(ClimbingStats REQUIRED)
    
    add_executable(Downstream main.cpp)
    target_link_libraries(Downstream Upstream::ClimbingStats)
    .ft P
.UNINDENT
.UNINDENT

Depending on whether the **ClimbingStats** package was used from the build
location or the install location, the **Downstream** target would be compiled
with either **-DClimbingStats\_FROM\_BUILD\_LOCATION** or
**-DClimbingStats\_FROM\_INSTALL\_LOCATION**.  For more about packages and
exporting see the **cmake-packages(7)** manual.

<a name="include-directories-and-usage-requirements"></a>

### Include Directories and Usage Requirements


Include directories require some special consideration when specified as usage
requirements and when used with generator expressions.  The
**target\_include\_directories()** command accepts both relative and
absolute include directories:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1 lib1.cpp)
    target_include_directories(lib1 PRIVATE
      /absolute/path
      relative/path
    )
    .ft P
.UNINDENT
.UNINDENT

Relative paths are interpreted relative to the source directory where the
command appears.  Relative paths are not allowed in the
**INTERFACE\_INCLUDE\_DIRECTORIES** of **IMPORTED** targets.

In cases where a non-trivial generator expression is used, the
**INSTALL\_PREFIX** expression may be used within the argument of an
**INSTALL\_INTERFACE** expression.  It is a replacement marker which
expands to the installation prefix when imported by a consuming project.

Include directories usage requirements commonly differ between the build-tree
and the install-tree.  The **BUILD\_INTERFACE** and **INSTALL\_INTERFACE**
generator expressions can be used to describe separate usage requirements
based on the usage location.  Relative paths are allowed within the
**INSTALL\_INTERFACE** expression and are interpreted relative to the
installation prefix.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(ClimbingStats climbingstats.cpp)
    target_include_directories(ClimbingStats INTERFACE
      $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/generated>
      $<INSTALL_INTERFACE:/absolute/path>
      $<INSTALL_INTERFACE:relative/path>
      $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/$<CONFIG>/generated>
    )
    .ft P
.UNINDENT
.UNINDENT

Two convenience APIs are provided relating to include directories usage
requirements.  The **CMAKE\_INCLUDE\_CURRENT\_DIR\_IN\_INTERFACE** variable
may be enabled, with an equivalent effect to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set_property(TARGET tgt APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR};${CMAKE_CURRENT_BINARY_DIR}>
    )
    .ft P
.UNINDENT
.UNINDENT

for each target affected.  The convenience for installed targets is
an **INCLUDES DESTINATION** component with the **install(TARGETS)**
command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    install(TARGETS foo bar bat EXPORT tgts ${dest_args}
      INCLUDES DESTINATION include
    )
    install(EXPORT tgts ${other_args})
    install(FILES ${headers} DESTINATION include)
    .ft P
.UNINDENT
.UNINDENT

This is equivalent to appending **${CMAKE\_INSTALL\_PREFIX}/include** to the
**INTERFACE\_INCLUDE\_DIRECTORIES** of each of the installed
**IMPORTED** targets when generated by **install(EXPORT)**.

When the **INTERFACE\_INCLUDE\_DIRECTORIES** of an
_imported target_ is consumed, the entries in the
property are treated as **SYSTEM** include directories, as if they were
listed in the **INTERFACE\_SYSTEM\_INCLUDE\_DIRECTORIES** of the
dependency. This can result in omission of compiler warnings for headers
found in those directories.  This behavior for _Imported Targets_ may
be controlled by setting the **NO\_SYSTEM\_FROM\_IMPORTED** target
property on the _consumers_ of imported targets.

If a binary target is linked transitively to a macOS **FRAMEWORK**, the
**Headers** directory of the framework is also treated as a usage requirement.
This has the same effect as passing the framework directory as an include
directory.

<a name="link-libraries-and-generator-expressions"></a>

### Link Libraries and Generator Expressions


Like build specifications, **link libraries** may be
specified with generator expression conditions.  However, as consumption of
usage requirements is based on collection from linked dependencies, there is
an additional limitation that the link dependencies must form a “directed
acyclic graph”.  That is, if linking to a target is dependent on the value of
a target property, that target property may not be dependent on the linked
dependencies:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1 lib1.cpp)
    add_library(lib2 lib2.cpp)
    target_link_libraries(lib1 PUBLIC
      $<$<TARGET_PROPERTY:POSITION_INDEPENDENT_CODE>:lib2>
    )
    add_library(lib3 lib3.cpp)
    set_property(TARGET lib3 PROPERTY INTERFACE_POSITION_INDEPENDENT_CODE ON)
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 lib1 lib3)
    .ft P
.UNINDENT
.UNINDENT

As the value of the **POSITION\_INDEPENDENT\_CODE** property of
the **exe1** target is dependent on the linked libraries (**lib3**), and the
edge of linking **exe1** is determined by the same
**POSITION\_INDEPENDENT\_CODE** property, the dependency graph above
contains a cycle.  **cmake(1)** issues a diagnostic in this case.

<a name="output-artifacts"></a>

### Output Artifacts


The buildsystem targets created by the **add\_library()** and
**add\_executable()** commands create rules to create binary outputs.
The exact output location of the binaries can only be determined at
generate-time because it can depend on the build-configuration and the
link-language of linked dependencies etc.  **TARGET\_FILE**,
**TARGET\_LINKER\_FILE** and related expressions can be used to access the
name and location of generated binaries.  These expressions do not work
for **OBJECT** libraries however, as there is no single file generated
by such libraries which is relevant to the expressions.

There are three kinds of output artifacts that may be build by targets
as detailed in the following sections.  Their classification differs
between DLL platforms and non-DLL platforms.  All Windows-based
systems including Cygwin are DLL platforms.

<a name="runtime-output-artifacts"></a>

### Runtime Output Artifacts


A _runtime_ output artifact of a buildsystem target may be:
.INDENT 0.0

* ·  
  The executable file (e.g. **.exe**) of an executable target
  created by the **add\_executable()** command.
* ·  
  On DLL platforms: the executable file (e.g. **.dll**) of a shared
  library target created by the **add\_library()** command
  with the **SHARED** option.
  .UNINDENT

The **RUNTIME\_OUTPUT\_DIRECTORY** and **RUNTIME\_OUTPUT\_NAME**
target properties may be used to control runtime output artifact locations
and names in the build tree.

<a name="library-output-artifacts"></a>

### Library Output Artifacts


A _library_ output artifact of a buildsystem target may be:
.INDENT 0.0

* ·  
  The loadable module file (e.g. **.dll** or **.so**) of a module
  library target created by the **add\_library()** command
  with the **MODULE** option.
* ·  
  On non-DLL platforms: the shared library file (e.g. **.so** or **.dylib**)
  of a shared library target created by the **add\_library()**
  command with the **SHARED** option.
  .UNINDENT

The **LIBRARY\_OUTPUT\_DIRECTORY** and **LIBRARY\_OUTPUT\_NAME**
target properties may be used to control library output artifact locations
and names in the build tree.

<a name="archive-output-artifacts"></a>

### Archive Output Artifacts


An _archive_ output artifact of a buildsystem target may be:
.INDENT 0.0

* ·  
  The static library file (e.g. **.lib** or **.a**) of a static
  library target created by the **add\_library()** command
  with the **STATIC** option.
* ·  
  On DLL platforms: the import library file (e.g. **.lib**) of a shared
  library target created by the **add\_library()** command
  with the **SHARED** option.  This file is only guaranteed to exist if
  the library exports at least one unmanaged symbol.
* ·  
  On DLL platforms: the import library file (e.g. **.lib**) of an
  executable target created by the **add\_executable()** command
  when its **ENABLE\_EXPORTS** target property is set.
* ·  
  On AIX: the linker import file (e.g. **.imp**) of an executable target
  created by the **add\_executable()** command when its
  **ENABLE\_EXPORTS** target property is set.
  .UNINDENT

The **ARCHIVE\_OUTPUT\_DIRECTORY** and **ARCHIVE\_OUTPUT\_NAME**
target properties may be used to control archive output artifact locations
and names in the build tree.

<a name="directory-scoped-commands"></a>

### Directory\-Scoped Commands


The **target\_include\_directories()**,
**target\_compile\_definitions()** and
**target\_compile\_options()** commands have an effect on only one
target at a time.  The commands **add\_compile\_definitions()**,
**add\_compile\_options()** and **include\_directories()** have
a similar function, but operate at directory scope instead of target
scope for convenience.

<a name="pseudo-targets"></a>

# Pseudo Targets


Some target types do not represent outputs of the buildsystem, but only inputs
such as external dependencies, aliases or other non-build artifacts.  Pseudo
targets are not represented in the generated buildsystem.

<a name="imported-targets"></a>

### Imported Targets


An **IMPORTED** target represents a pre-existing dependency.  Usually
such targets are defined by an upstream package and should be treated as
immutable. After declaring an **IMPORTED** target one can adjust its
target properties by using the customary commands such as
**target\_compile\_definitions()**, **target\_include\_directories()**,
**target\_compile\_options()** or **target\_link\_libraries()** just like
with any other regular target.

**IMPORTED** targets may have the same usage requirement properties
populated as binary targets, such as
**INTERFACE\_INCLUDE\_DIRECTORIES**,
**INTERFACE\_COMPILE\_DEFINITIONS**,
**INTERFACE\_COMPILE\_OPTIONS**,
**INTERFACE\_LINK\_LIBRARIES**, and
**INTERFACE\_POSITION\_INDEPENDENT\_CODE**.

The **LOCATION** may also be read from an IMPORTED target, though there
is rarely reason to do so.  Commands such as **add\_custom\_command()** can
transparently use an **IMPORTED** **EXECUTABLE** target
as a **COMMAND** executable.

The scope of the definition of an **IMPORTED** target is the directory
where it was defined.  It may be accessed and used from subdirectories, but
not from parent directories or sibling directories.  The scope is similar to
the scope of a cmake variable.

It is also possible to define a **GLOBAL** **IMPORTED** target which is
accessible globally in the buildsystem.

See the **cmake-packages(7)** manual for more on creating packages
with **IMPORTED** targets.

<a name="alias-targets"></a>

### Alias Targets


An **ALIAS** target is a name which may be used interchangeably with
a binary target name in read-only contexts.  A primary use-case for **ALIAS**
targets is for example or unit test executables accompanying a library, which
may be part of the same buildsystem or built separately based on user
configuration.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(lib1 lib1.cpp)
    install(TARGETS lib1 EXPORT lib1Export ${dest_args})
    install(EXPORT lib1Export NAMESPACE Upstream:: ${other_args})
    
    add_library(Upstream::lib1 ALIAS lib1)
    .ft P
.UNINDENT
.UNINDENT

In another directory, we can link unconditionally to the **Upstream::lib1**
target, which may be an **IMPORTED** target from a package, or an
**ALIAS** target if built as part of the same buildsystem.
.INDENT 0.0
.INDENT 3.5

    .ft C
    if (NOT TARGET Upstream::lib1)
      find_package(lib1 REQUIRED)
    endif()
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 Upstream::lib1)
    .ft P
.UNINDENT
.UNINDENT

**ALIAS** targets are not mutable, installable or exportable.  They are
entirely local to the buildsystem description.  A name can be tested for
whether it is an **ALIAS** name by reading the **ALIASED\_TARGET**
property from it:
.INDENT 0.0
.INDENT 3.5

    .ft C
    get_target_property(_aliased Upstream::lib1 ALIASED_TARGET)
    if(_aliased)
      message(STATUS "The name Upstream::lib1 is an ALIAS for ${_aliased}.")
    endif()
    .ft P
.UNINDENT
.UNINDENT

<a name="interface-libraries"></a>

### Interface Libraries


An **INTERFACE** target has no **LOCATION** and is mutable, but is
otherwise similar to an **IMPORTED** target.

It may specify usage requirements such as
**INTERFACE\_INCLUDE\_DIRECTORIES**,
**INTERFACE\_COMPILE\_DEFINITIONS**,
**INTERFACE\_COMPILE\_OPTIONS**,
**INTERFACE\_LINK\_LIBRARIES**,
**INTERFACE\_SOURCES**,
and **INTERFACE\_POSITION\_INDEPENDENT\_CODE**.
Only the **INTERFACE** modes of the **target\_include\_directories()**,
**target\_compile\_definitions()**, **target\_compile\_options()**,
**target\_sources()**, and **target\_link\_libraries()** commands
may be used with **INTERFACE** libraries.

A primary use-case for **INTERFACE** libraries is header-only libraries.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(Eigen INTERFACE)
    target_include_directories(Eigen INTERFACE
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
      $<INSTALL_INTERFACE:include/Eigen>
    )
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 Eigen)
    .ft P
.UNINDENT
.UNINDENT

Here, the usage requirements from the **Eigen** target are consumed and used
when compiling, but it has no effect on linking.

Another use-case is to employ an entirely target-focussed design for usage
requirements:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(pic_on INTERFACE)
    set_property(TARGET pic_on PROPERTY INTERFACE_POSITION_INDEPENDENT_CODE ON)
    add_library(pic_off INTERFACE)
    set_property(TARGET pic_off PROPERTY INTERFACE_POSITION_INDEPENDENT_CODE OFF)
    
    add_library(enable_rtti INTERFACE)
    target_compile_options(enable_rtti INTERFACE
      $<$<OR:$<COMPILER_ID:GNU>,$<COMPILER_ID:Clang>>:-rtti>
    )
    
    add_executable(exe1 exe1.cpp)
    target_link_libraries(exe1 pic_on enable_rtti)
    .ft P
.UNINDENT
.UNINDENT

This way, the build specification of **exe1** is expressed entirely as linked
targets, and the complexity of compiler-specific flags is encapsulated in an
**INTERFACE** library target.

The properties permitted to be set on or read from an **INTERFACE** library
are:
.INDENT 0.0

* ·  
  Properties matching **INTERFACE\_***
* ·  
  Built-in properties matching **COMPATIBLE\_INTERFACE\_***
* ·  
  **EXPORT\_NAME**
* ·  
  **EXPORT\_PROPERTIES**
* ·  
  **IMPORTED**
* ·  
  **MANUALLY\_ADDED\_DEPENDENCIES**
* ·  
  **NAME**
* ·  
  Properties matching **IMPORTED\_LIBNAME\_***
* ·  
  Properties matching **MAP\_IMPORTED\_CONFIG\_***
  .UNINDENT

**INTERFACE** libraries may be installed and exported.  Any content they refer
to must be installed separately:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(Eigen INTERFACE)
    target_include_directories(Eigen INTERFACE
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
      $<INSTALL_INTERFACE:include/Eigen>
    )
    
    install(TARGETS Eigen EXPORT eigenExport)
    install(EXPORT eigenExport NAMESPACE Upstream::
      DESTINATION lib/cmake/Eigen
    )
    install(FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/src/eigen.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/vector.h
        ${CMAKE_CURRENT_SOURCE_DIR}/src/matrix.h
      DESTINATION include/Eigen
    )
    .ft P
.UNINDENT
.UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

