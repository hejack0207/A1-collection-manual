# cmake-qt(7) - CMake Qt Features Reference

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


CMake can find and use Qt 4 and Qt 5 libraries.  The Qt 4 libraries are found
by the **FindQt4** find-module shipped with CMake, whereas the
Qt 5 libraries are found using “Config-file Packages” shipped with Qt 5. See
**cmake-packages(7)** for more information about CMake packages, and
see _the Qt cmake manual_
for your Qt version.

Qt 4 and Qt 5 may be used together in the same
**CMake buildsystem**:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.8.0 FATAL_ERROR)
    
    project(Qt4And5)
    
    set(CMAKE_AUTOMOC ON)
    
    find_package(Qt5 COMPONENTS Widgets DBus REQUIRED)
    add_executable(publisher publisher.cpp)
    target_link_libraries(publisher Qt5::Widgets Qt5::DBus)
    
    find_package(Qt4 REQUIRED)
    add_executable(subscriber subscriber.cpp)
    target_link_libraries(subscriber Qt4::QtGui Qt4::QtDBus)
    .ft P
.UNINDENT
.UNINDENT

A CMake target may not link to both Qt 4 and Qt 5.  A diagnostic is issued if
this is attempted or results from transitive target dependency evaluation.

<a name="qt-build-tools"></a>

# Qt Build Tools


Qt relies on some bundled tools for code generation, such as **moc** for
meta-object code generation, **uic** for widget layout and population,
and **rcc** for virtual file system content generation.  These tools may be
automatically invoked by **cmake(1)** if the appropriate conditions
are met.  The automatic tool invocation may be used with both Qt 4 and Qt 5.

<a name="automoc"></a>

### AUTOMOC


The **AUTOMOC** target property controls whether **cmake(1)**
inspects the C++ files in the target to determine if they require **moc** to
be run, and to create rules to execute **moc** at the appropriate time.

If a macro from **AUTOMOC\_MACRO\_NAMES** is found in a header file,
**moc** will be run on the file.  The result will be put into a file named
according to **moc\_&lt;basename&gt;.cpp**.
If the macro is found in a C++ implementation
file, the moc output will be put into a file named according to
**&lt;basename&gt;.moc**, following the Qt conventions.  The **&lt;basename&gt;.moc** must
be included by the user in the C++ implementation file with a preprocessor
**#include**.

Included **moc\_*.cpp** and ***.moc** files will be generated in the
**&lt;AUTOGEN\_BUILD\_DIR&gt;/include** directory which is
automatically added to the target’s **INCLUDE\_DIRECTORIES**.
.INDENT 0.0

* ·  
  This differs from CMake 3.7 and below; see their documentation for details.
* ·  
  For **multi configuration generators**,
  the include directory is **&lt;AUTOGEN\_BUILD\_DIR&gt;/include\_&lt;CONFIG&gt;**.
* ·  
  See **AUTOGEN\_BUILD\_DIR**.
  .UNINDENT

Not included **moc\_&lt;basename&gt;.cpp** files will be generated in custom
folders to avoid name collisions and included in a separate
**&lt;AUTOGEN\_BUILD\_DIR&gt;/mocs\_compilation.cpp** file which is compiled
into the target.
.INDENT 0.0

* ·  
  See **AUTOGEN\_BUILD\_DIR**.
  .UNINDENT

The **moc** command line will consume the **COMPILE\_DEFINITIONS** and
**INCLUDE\_DIRECTORIES** target properties from the target it is being
invoked for, and for the appropriate build configuration.

The **AUTOMOC** target property may be pre-set for all
following targets by setting the **CMAKE\_AUTOMOC** variable.  The
**AUTOMOC\_MOC\_OPTIONS** target property may be populated to set
options to pass to **moc**. The **CMAKE\_AUTOMOC\_MOC\_OPTIONS**
variable may be populated to pre-set the options for all following targets.

Additional macro names to search for can be added to
**AUTOMOC\_MACRO\_NAMES**.

Additional **moc** dependency file names can be extracted from source code
by using **AUTOMOC\_DEPEND\_FILTERS**.

Source C++ files can be excluded from **AUTOMOC** processing by
enabling **SKIP\_AUTOMOC** or the broader **SKIP\_AUTOGEN**.

<a name="autouic"></a>

### AUTOUIC


The **AUTOUIC** target property controls whether **cmake(1)**
inspects the C++ files in the target to determine if they require **uic** to
be run, and to create rules to execute **uic** at the appropriate time.

If a preprocessor **#include** directive is found which matches
**&lt;path&gt;ui\_&lt;basename&gt;.h**, and a **&lt;basename&gt;.ui** file exists,
then **uic** will be executed to generate the appropriate file.
The **&lt;basename&gt;.ui** file is searched for in the following places
.INDENT 0.0

* 1.  
  **&lt;source\_dir&gt;/&lt;basename&gt;.ui**
* 2.  
  **&lt;source\_dir&gt;/&lt;path&gt;&lt;basename&gt;.ui**
* 3.  
  **&lt;AUTOUIC\_SEARCH\_PATHS&gt;/&lt;basename&gt;.ui**
* 4.  
  **&lt;AUTOUIC\_SEARCH\_PATHS&gt;/&lt;path&gt;&lt;basename&gt;.ui**
  .UNINDENT

where **&lt;source\_dir&gt;** is the directory of the C++ file and
**AUTOUIC\_SEARCH\_PATHS** is a list of additional search paths.

The generated generated **ui\_*.h** files are placed in the
**&lt;AUTOGEN\_BUILD\_DIR&gt;/include** directory which is
automatically added to the target’s **INCLUDE\_DIRECTORIES**.
.INDENT 0.0

* ·  
  This differs from CMake 3.7 and below; see their documentation for details.
* ·  
  For **multi configuration generators**,
  the include directory is **&lt;AUTOGEN\_BUILD\_DIR&gt;/include\_&lt;CONFIG&gt;**.
* ·  
  See **AUTOGEN\_BUILD\_DIR**.
  .UNINDENT

The **AUTOUIC** target property may be pre-set for all following
targets by setting the **CMAKE\_AUTOUIC** variable.  The
**AUTOUIC\_OPTIONS** target property may be populated to set options
to pass to **uic**.  The **CMAKE\_AUTOUIC\_OPTIONS** variable may be
populated to pre-set the options for all following targets.  The
**AUTOUIC\_OPTIONS** source file property may be set on the
**&lt;basename&gt;.ui** file to set particular options for the file.  This
overrides options from the **AUTOUIC\_OPTIONS** target property.

A target may populate the **INTERFACE\_AUTOUIC\_OPTIONS** target
property with options that should be used when invoking **uic**.  This must be
consistent with the **AUTOUIC\_OPTIONS** target property content of the
depender target.  The **CMAKE\_DEBUG\_TARGET\_PROPERTIES** variable may
be used to track the origin target of such
**INTERFACE\_AUTOUIC\_OPTIONS**.  This means that a library which
provides an alternative translation system for Qt may specify options which
should be used when running **uic**:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(KI18n klocalizedstring.cpp)
    target_link_libraries(KI18n Qt5::Core)
    
    # KI18n uses the tr2i18n() function instead of tr().  That function is
    # declared in the klocalizedstring.h header.
    set(autouic_options
      -tr tr2i18n
      -include klocalizedstring.h
    )
    
    set_property(TARGET KI18n APPEND PROPERTY
      INTERFACE_AUTOUIC_OPTIONS ${autouic_options}
    )
    .ft P
.UNINDENT
.UNINDENT

A consuming project linking to the target exported from upstream automatically
uses appropriate options when **uic** is run by **AUTOUIC**, as a
result of linking with the **IMPORTED** target:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(CMAKE_AUTOUIC ON)
    # Uses a libwidget.ui file:
    add_library(LibWidget libwidget.cpp)
    target_link_libraries(LibWidget
      KF5::KI18n
      Qt5::Widgets
    )
    .ft P
.UNINDENT
.UNINDENT

Source files can be excluded from **AUTOUIC** processing by
enabling **SKIP\_AUTOUIC** or the broader **SKIP\_AUTOGEN**.

<a name="autorcc"></a>

### AUTORCC


The **AUTORCC** target property controls whether **cmake(1)**
creates rules to execute **rcc** at the appropriate time on source files
which have the suffix **.qrc**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(myexe main.cpp resource_file.qrc)
    .ft P
.UNINDENT
.UNINDENT

The **AUTORCC** target property may be pre-set for all following targets
by setting the **CMAKE\_AUTORCC** variable.  The
**AUTORCC\_OPTIONS** target property may be populated to set options
to pass to **rcc**.  The **CMAKE\_AUTORCC\_OPTIONS** variable may be
populated to pre-set the options for all following targets.  The
**AUTORCC\_OPTIONS** source file property may be set on the
**&lt;name&gt;.qrc** file to set particular options for the file.  This
overrides options from the **AUTORCC\_OPTIONS** target property.

Source files can be excluded from **AUTORCC** processing by
enabling **SKIP\_AUTORCC** or the broader **SKIP\_AUTOGEN**.

<a name="the-ltorigingt_autogen-target"></a>

# The &lt;Origin&gt;_Autogen Target


The **moc** and **uic** tools are executed as part of a synthesized
**&lt;ORIGIN&gt;\_autogen** **custom target** generated by
CMake.  By default that **&lt;ORIGIN&gt;\_autogen** target inherits the dependencies
of the **&lt;ORIGIN&gt;** target (see **AUTOGEN\_ORIGIN\_DEPENDS**).
Target dependencies may be added to the **&lt;ORIGIN&gt;\_autogen** target by adding
them to the **AUTOGEN\_TARGET\_DEPENDS** target property.

<a name="visual-studio-generators"></a>

# Visual Studio Generators


When using the **Visual Studio generators**, CMake
generates a **PRE\_BUILD** **custom command**
instead of the **&lt;ORIGIN&gt;\_autogen** **custom target**
(for **AUTOMOC** and **AUTOUIC**).
This isn’t always possible though and
an **&lt;ORIGIN&gt;\_autogen** **custom target** is used,
when either
.INDENT 0.0

* ·  
  the **&lt;ORIGIN&gt;** target depends on **GENERATED** files which aren’t
  excluded from **AUTOMOC** and **AUTOUIC** by
  **SKIP\_AUTOMOC**, **SKIP\_AUTOUIC**, **SKIP\_AUTOGEN**
  or **CMP0071**
* ·  
  **AUTOGEN\_TARGET\_DEPENDS** lists a source file
* ·  
  **CMAKE\_GLOBAL\_AUTOGEN\_TARGET** is enabled
  .UNINDENT

<a name="qtmainlib-on-windows"></a>

# Qtmain.Lib on Windows


The Qt 4 and 5 **IMPORTED** targets for the QtGui libraries specify
that the qtmain.lib static library shipped with Qt will be linked by all
dependent executables which have the **WIN32\_EXECUTABLE** enabled.

To disable this behavior, enable the **Qt5\_NO\_LINK\_QTMAIN** target property for
Qt 5 based targets or **QT4\_NO\_LINK\_QTMAIN** target property for Qt 4 based
targets.
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(myexe WIN32 main.cpp)
    target_link_libraries(myexe Qt4::QtGui)
    
    add_executable(myexe_no_qtmain WIN32 main_no_qtmain.cpp)
    set_property(TARGET main_no_qtmain PROPERTY QT4_NO_LINK_QTMAIN ON)
    target_link_libraries(main_no_qtmain Qt4::QtGui)
    .ft P
.UNINDENT
.UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

