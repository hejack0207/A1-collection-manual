# cmake-developer(7) - CMake Developer Reference

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


This manual is intended for reference by developers working with
**cmake-language(7)** code, whether writing their own modules,
authoring their own build systems, or working on CMake itself.

See _https://cmake.org/get-involved/_ to get involved in development of
CMake upstream.  It includes links to contribution instructions, which
in turn link to developer guides for CMake itself.

<a name="find-modules"></a>

# Find Modules


A “find module” is a **Find&lt;PackageName&gt;.cmake** file to be loaded
by the **find\_package()** command when invoked for **&lt;PackageName&gt;**.

The primary task of a find module is to determine whether a package
exists on the system, set the **&lt;PackageName&gt;\_FOUND** variable to reflect
this and provide any variables, macros and imported targets required to
use the package.  A find module is useful in cases where an upstream
library does not provide a
config file package.

The traditional approach is to use variables for everything, including
libraries and executables: see the _Standard Variable Names_ section
below.  This is what most of the existing find modules provided by CMake
do.

The more modern approach is to behave as much like
config file packages files as possible, by
providing imported target.  This has the advantage
of propagating Target Usage Requirements to consumers.

In either case (or even when providing both variables and imported
targets), find modules should provide backwards compatibility with old
versions that had the same name.

A FindFoo.cmake module will typically be loaded by the command:
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_package(Foo [major[.minor[.patch[.tweak]]]]
                 [EXACT] [QUIET] [REQUIRED]
                 [[COMPONENTS] [components...]]
                 [OPTIONAL_COMPONENTS components...]
                 [NO_POLICY_SCOPE])
    .ft P
.UNINDENT
.UNINDENT

See the **find\_package()** documentation for details on what
variables are set for the find module.  Most of these are dealt with by
using **FindPackageHandleStandardArgs**.

Briefly, the module should only locate versions of the package
compatible with the requested version, as described by the
**Foo\_FIND\_VERSION** family of variables.  If **Foo\_FIND\_QUIETLY** is
set to true, it should avoid printing messages, including anything
complaining about the package not being found.  If **Foo\_FIND\_REQUIRED**
is set to true, the module should issue a **FATAL\_ERROR** if the package
cannot be found.  If neither are set to true, it should print a
non-fatal message if it cannot find the package.

Packages that find multiple semi-independent parts (like bundles of
libraries) should search for the components listed in
**Foo\_FIND\_COMPONENTS** if it is set , and only set **Foo\_FOUND** to
true if for each searched-for component **&lt;c&gt;** that was not found,
**Foo\_FIND\_REQUIRED\_&lt;c&gt;** is not set to true.  The **HANDLE\_COMPONENTS**
argument of **find\_package\_handle\_standard\_args()** can be used to
implement this.

If **Foo\_FIND\_COMPONENTS** is not set, which modules are searched for
and required is up to the find module, but should be documented.

For internal implementation, it is a generally accepted convention that
variables starting with underscore are for temporary use only.

<a name="standard-variable-names"></a>

### Standard Variable Names


For a **FindXxx.cmake** module that takes the approach of setting
variables (either instead of or in addition to creating imported
targets), the following variable names should be used to keep things
consistent between find modules.  Note that all variables start with
**Xxx\_** to make sure they do not interfere with other find modules; the
same consideration applies to macros, functions and imported targets.
.INDENT 0.0

* <b>**Xxx\_INCLUDE\_DIRS**</b>  
  The final set of include directories listed in one variable for use by
  client code.  This should not be a cache entry.
* <b>**Xxx\_LIBRARIES**</b>  
  The libraries to link against to use Xxx. These should include full
  paths.  This should not be a cache entry.
* <b>**Xxx\_DEFINITIONS**</b>  
  Definitions to use when compiling code that uses Xxx. This really
  shouldn’t include options such as **-DHAS\_JPEG** that a client
  source-code file uses to decide whether to **#include &lt;jpeg.h&gt;**
* <b>**Xxx\_EXECUTABLE**</b>  
  Where to find the Xxx tool.
* <b>**Xxx\_Yyy\_EXECUTABLE**</b>  
  Where to find the Yyy tool that comes with Xxx.
* <b>**Xxx\_LIBRARY\_DIRS**</b>  
  Optionally, the final set of library directories listed in one
  variable for use by client code.  This should not be a cache entry.
* <b>**Xxx\_ROOT\_DIR**</b>  
  Where to find the base directory of Xxx.
* <b>**Xxx\_VERSION\_Yy**</b>  
  Expect Version Yy if true. Make sure at most one of these is ever true.
* <b>**Xxx\_WRAP\_Yy**</b>  
  If False, do not try to use the relevant CMake wrapping command.
* <b>**Xxx\_Yy\_FOUND**</b>  
  If False, optional Yy part of Xxx system is not available.
* <b>**Xxx\_FOUND**</b>  
  Set to false, or undefined, if we haven’t found, or don’t want to use
  Xxx.
* <b>**Xxx\_NOT\_FOUND\_MESSAGE**</b>  
  Should be set by config-files in the case that it has set
  **Xxx\_FOUND** to FALSE.  The contained message will be printed by the
  **find\_package()** command and by
  **find\_package\_handle\_standard\_args()** to inform the user about the
  problem.
* <b>**Xxx\_RUNTIME\_LIBRARY\_DIRS**</b>  
  Optionally, the runtime library search path for use when running an
  executable linked to shared libraries.  The list should be used by
  user code to create the **PATH** on windows or **LD\_LIBRARY\_PATH** on
  UNIX.  This should not be a cache entry.
* <b>**Xxx\_VERSION**</b>  
  The full version string of the package found, if any.  Note that many
  existing modules provide **Xxx\_VERSION\_STRING** instead.
* <b>**Xxx\_VERSION\_MAJOR**</b>  
  The major version of the package found, if any.
* <b>**Xxx\_VERSION\_MINOR**</b>  
  The minor version of the package found, if any.
* <b>**Xxx\_VERSION\_PATCH**</b>  
  The patch version of the package found, if any.
  .UNINDENT

The following names should not usually be used in CMakeLists.txt files, but
are typically cache variables for users to edit and control the
behaviour of find modules (like entering the path to a library manually)
.INDENT 0.0

* <b>**Xxx\_LIBRARY**</b>  
  The path of the Xxx library (as used with **find\_library()**, for
  example).
* <b>**Xxx\_Yy\_LIBRARY**</b>  
  The path of the Yy library that is part of the Xxx system. It may or
  may not be required to use Xxx.
* <b>**Xxx\_INCLUDE\_DIR**</b>  
  Where to find headers for using the Xxx library.
* <b>**Xxx\_Yy\_INCLUDE\_DIR**</b>  
  Where to find headers for using the Yy library of the Xxx system.
  .UNINDENT

To prevent users being overwhelmed with settings to configure, try to
keep as many options as possible out of the cache, leaving at least one
option which can be used to disable use of the module, or locate a
not-found library (e.g. **Xxx\_ROOT\_DIR**).  For the same reason, mark
most cache options as advanced.  For packages which provide both debug
and release binaries, it is common to create cache variables with a
**\_LIBRARY\_&lt;CONFIG&gt;** suffix, such as **Foo\_LIBRARY\_RELEASE** and
**Foo\_LIBRARY\_DEBUG**.

While these are the standard variable names, you should provide
backwards compatibility for any old names that were actually in use.
Make sure you comment them as deprecated, so that no-one starts using
them.

<a name="a-sample-find-module"></a>

### A Sample Find Module


We will describe how to create a simple find module for a library **Foo**.

The top of the module should begin with a license notice, followed by
a blank line, and then followed by a Bracket Comment.  The comment
should begin with **.rst:** to indicate that the rest of its content is
reStructuredText-format documentation.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
    # file Copyright.txt or https://cmake.org/licensing for details.
    
    #[=======================================================================[.rst:
    FindFoo
    -------
    
    Finds the Foo library.
    
    Imported Targets
    ^^^^^^^^^^^^^^^^
    
    This module provides the following imported targets, if found:
    
    ``Foo::Foo``
      The Foo library
    
    Result Variables
    ^^^^^^^^^^^^^^^^
    
    This will define the following variables:
    
    ``Foo_FOUND``
      True if the system has the Foo library.
    ``Foo_VERSION``
      The version of the Foo library which was found.
    ``Foo_INCLUDE_DIRS``
      Include directories needed to use Foo.
    ``Foo_LIBRARIES``
      Libraries needed to link to Foo.
    
    Cache Variables
    ^^^^^^^^^^^^^^^
    
    The following cache variables may also be set:
    
    ``Foo_INCLUDE_DIR``
      The directory containing ``foo.h``.
    ``Foo_LIBRARY``
      The path to the Foo library.
    
    #]=======================================================================]
    .ft P
.UNINDENT
.UNINDENT

The module documentation consists of:
.INDENT 0.0

* ·  
  An underlined heading specifying the module name.
* ·  
  A simple description of what the module finds.
  More description may be required for some packages.  If there are
  caveats or other details users of the module should be aware of,
  specify them here.
* ·  
  A section listing imported targets provided by the module, if any.
* ·  
  A section listing result variables provided by the module.
* ·  
  Optionally a section listing cache variables used by the module, if any.
  .UNINDENT

If the package provides any macros or functions, they should be listed in
an additional section, but can be documented by additional **.rst:**
comment blocks immediately above where those macros or functions are defined.

The find module implementation may begin below the documentation block.
Now the actual libraries and so on have to be found.  The code here will
obviously vary from module to module (dealing with that, after all, is the
point of find modules), but there tends to be a common pattern for libraries.

First, we try to use **pkg-config** to find the library.  Note that we
cannot rely on this, as it may not be available, but it provides a good
starting point.
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_package(PkgConfig)
    pkg_check_modules(PC_Foo QUIET Foo)
    .ft P
.UNINDENT
.UNINDENT

This should define some variables starting **PC\_Foo\_** that contain the
information from the **Foo.pc** file.

Now we need to find the libraries and include files; we use the
information from **pkg-config** to provide hints to CMake about where to
look.
.INDENT 0.0
.INDENT 3.5

    .ft C
    find_path(Foo_INCLUDE_DIR
      NAMES foo.h
      PATHS ${PC_Foo_INCLUDE_DIRS}
      PATH_SUFFIXES Foo
    )
    find_library(Foo_LIBRARY
      NAMES foo
      PATHS ${PC_Foo_LIBRARY_DIRS}
    )
    .ft P
.UNINDENT
.UNINDENT

If you have a good way of getting the version (from a header file, for
example), you can use that information to set **Foo\_VERSION** (although
note that find modules have traditionally used **Foo\_VERSION\_STRING**,
so you may want to set both).  Otherwise, attempt to use the information
from **pkg-config**
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(Foo_VERSION ${PC_Foo_VERSION})
    .ft P
.UNINDENT
.UNINDENT

Now we can use **FindPackageHandleStandardArgs** to do most of the
rest of the work for us
.INDENT 0.0
.INDENT 3.5

    .ft C
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(Foo
      FOUND_VAR Foo_FOUND
      REQUIRED_VARS
        Foo_LIBRARY
        Foo_INCLUDE_DIR
      VERSION_VAR Foo_VERSION
    )
    .ft P
.UNINDENT
.UNINDENT

This will check that the **REQUIRED\_VARS** contain values (that do not
end in **-NOTFOUND**) and set **Foo\_FOUND** appropriately.  It will also
cache those values.  If **Foo\_VERSION** is set, and a required version
was passed to **find\_package()**, it will check the requested version
against the one in **Foo\_VERSION**.  It will also print messages as
appropriate; note that if the package was found, it will print the
contents of the first required variable to indicate where it was found.

At this point, we have to provide a way for users of the find module to
link to the library or libraries that were found.  There are two
approaches, as discussed in the _Find Modules_ section above.  The
traditional variable approach looks like
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(Foo_FOUND)
      set(Foo_LIBRARIES ${Foo_LIBRARY})
      set(Foo_INCLUDE_DIRS ${Foo_INCLUDE_DIR})
      set(Foo_DEFINITIONS ${PC_Foo_CFLAGS_OTHER})
    endif()
    .ft P
.UNINDENT
.UNINDENT

If more than one library was found, all of them should be included in
these variables (see the _Standard Variable Names_ section for more
information).

When providing imported targets, these should be namespaced (hence the
**Foo::** prefix); CMake will recognize that values passed to
**target\_link\_libraries()** that contain **::** in their name are
supposed to be imported targets (rather than just library names), and
will produce appropriate diagnostic messages if that target does not
exist (see policy **CMP0028**).
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(Foo_FOUND AND NOT TARGET Foo::Foo)
      add_library(Foo::Foo UNKNOWN IMPORTED)
      set_target_properties(Foo::Foo PROPERTIES
        IMPORTED_LOCATION "${Foo_LIBRARY}"
        INTERFACE_COMPILE_OPTIONS "${PC_Foo_CFLAGS_OTHER}"
        INTERFACE_INCLUDE_DIRECTORIES "${Foo_INCLUDE_DIR}"
      )
    endif()
    .ft P
.UNINDENT
.UNINDENT

One thing to note about this is that the **INTERFACE\_INCLUDE\_DIRECTORIES** and
similar properties should only contain information about the target itself, and
not any of its dependencies.  Instead, those dependencies should also be
targets, and CMake should be told that they are dependencies of this target.
CMake will then combine all the necessary information automatically.

The type of the **IMPORTED** target created in the
**add\_library()** command can always be specified as **UNKNOWN**
type.  This simplifies the code in cases where static or shared variants may
be found, and CMake will determine the type by inspecting the files.

If the library is available with multiple configurations, the
**IMPORTED\_CONFIGURATIONS** target property should also be
populated:
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(Foo_FOUND)
      if (NOT TARGET Foo::Foo)
        add_library(Foo::Foo UNKNOWN IMPORTED)
      endif()
      if (Foo_LIBRARY_RELEASE)
        set_property(TARGET Foo::Foo APPEND PROPERTY
          IMPORTED_CONFIGURATIONS RELEASE
        )
        set_target_properties(Foo::Foo PROPERTIES
          IMPORTED_LOCATION_RELEASE "${Foo_LIBRARY_RELEASE}"
        )
      endif()
      if (Foo_LIBRARY_DEBUG)
        set_property(TARGET Foo::Foo APPEND PROPERTY
          IMPORTED_CONFIGURATIONS DEBUG
        )
        set_target_properties(Foo::Foo PROPERTIES
          IMPORTED_LOCATION_DEBUG "${Foo_LIBRARY_DEBUG}"
        )
      endif()
      set_target_properties(Foo::Foo PROPERTIES
        INTERFACE_COMPILE_OPTIONS "${PC_Foo_CFLAGS_OTHER}"
        INTERFACE_INCLUDE_DIRECTORIES "${Foo_INCLUDE_DIR}"
      )
    endif()
    .ft P
.UNINDENT
.UNINDENT

The **RELEASE** variant should be listed first in the property
so that the variant is chosen if the user uses a configuration which is
not an exact match for any listed **IMPORTED\_CONFIGURATIONS**.

Most of the cache variables should be hidden in the **ccmake** interface unless
the user explicitly asks to edit them.
.INDENT 0.0
.INDENT 3.5

    .ft C
    mark_as_advanced(
      Foo_INCLUDE_DIR
      Foo_LIBRARY
    )
    .ft P
.UNINDENT
.UNINDENT

If this module replaces an older version, you should set compatibility variables
to cause the least disruption possible.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # compatibility variables
    set(Foo_VERSION_STRING ${Foo_VERSION})
    .ft P
.UNINDENT
.UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

