# cmake-compile-features(7) - CMake Compile Features Reference

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


Project source code may depend on, or be conditional on, the availability
of certain features of the compiler.  There are three use-cases which arise:
_Compile Feature Requirements_, _Optional Compile Features_
and _Conditional Compilation Options_.

While features are typically specified in programming language standards,
CMake provides a primary user interface based on granular handling of
the features, not the language standard that introduced the feature.

The **CMAKE\_C\_KNOWN\_FEATURES**, **CMAKE\_CUDA\_KNOWN\_FEATURES**,
and **CMAKE\_CXX\_KNOWN\_FEATURES** global properties contain all the
features known to CMake, regardless of compiler support for the feature.
The **CMAKE\_C\_COMPILE\_FEATURES**, **CMAKE\_CUDA\_COMPILE\_FEATURES**
, and **CMAKE\_CXX\_COMPILE\_FEATURES** variables contain all features
CMake knows are known to the compiler, regardless of language standard
or compile flags needed to use them.

Features known to CMake are named mostly following the same convention
as the Clang feature test macros.  There are some exceptions, such as
CMake using **cxx\_final** and **cxx\_override** instead of the single
**cxx\_override\_control** used by Clang.

Note that there are no separate compile features properties or variables for
the **OBJC** or **OBJCXX** languages.  These are based off **C** or **C++**
respectively, so the properties and variables for their corresponding base
language should be used instead.

<a name="compile-feature-requirements"></a>

# Compile Feature Requirements


Compile feature requirements may be specified with the
**target\_compile\_features()** command.  For example, if a target must
be compiled with compiler support for the
**cxx\_constexpr** feature:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(mylib requires_constexpr.cpp)
    target_compile_features(mylib PRIVATE cxx_constexpr)
    .ft P
.UNINDENT
.UNINDENT

In processing the requirement for the **cxx\_constexpr** feature,
**cmake(1)** will ensure that the in-use C++ compiler is capable
of the feature, and will add any necessary flags such as **-std=gnu++11**
to the compile lines of C++ files in the **mylib** target.  A
**FATAL\_ERROR** is issued if the compiler is not capable of the
feature.

The exact compile flags and language standard are deliberately not part
of the user interface for this use-case.  CMake will compute the
appropriate compile flags to use by considering the features specified
for each target.

Such compile flags are added even if the compiler supports the
particular feature without the flag. For example, the GNU compiler
supports variadic templates (with a warning) even if **-std=gnu++98** is
used.  CMake adds the **-std=gnu++11** flag if **cxx\_variadic\_templates**
is specified as a requirement.

In the above example, **mylib** requires **cxx\_constexpr** when it
is built itself, but consumers of **mylib** are not required to use a
compiler which supports **cxx\_constexpr**.  If the interface of
**mylib** does require the **cxx\_constexpr** feature (or any other
known feature), that may be specified with the **PUBLIC** or
**INTERFACE** signatures of **target\_compile\_features()**:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(mylib requires_constexpr.cpp)
    # cxx_constexpr is a usage-requirement
    target_compile_features(mylib PUBLIC cxx_constexpr)
    
    # main.cpp will be compiled with -std=gnu++11 on GNU for cxx_constexpr.
    add_executable(myexe main.cpp)
    target_link_libraries(myexe mylib)
    .ft P
.UNINDENT
.UNINDENT

Feature requirements are evaluated transitively by consuming the link
implementation.  See **cmake-buildsystem(7)** for more on
transitive behavior of build properties and usage requirements.

<a name="requiring-language-standards"></a>

### Requiring Language Standards


In projects that use a large number of commonly available features from
a particular language standard (e.g. C++ 11) one may specify a
meta-feature (e.g. **cxx\_std\_11**) that requires use of a compiler mode
that is at minimum aware of that standard, but could be greater.
This is simpler than specifying all the features individually, but does
not guarantee the existence of any particular feature.
Diagnosis of use of unsupported features will be delayed until compile time.

For example, if C++ 11 features are used extensively in a project’s
header files, then clients must use a compiler mode that is no less
than C++ 11.  This can be requested with the code:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_compile_features(mylib PUBLIC cxx_std_11)
    .ft P
.UNINDENT
.UNINDENT

In this example, CMake will ensure the compiler is invoked in a mode
of at-least C++ 11 (or C++ 14, C++ 17, …), adding flags such as
**-std=gnu++11** if necessary.  This applies to sources within **mylib**
as well as any dependents (that may include headers from **mylib**).

<a name="availability-of-compiler-extensions"></a>

### Availability of Compiler Extensions


Because the **CXX\_EXTENSIONS** target property is **ON** by default,
CMake uses extended variants of language dialects by default, such as
**-std=gnu++11** instead of **-std=c++11**.  That target property may be
set to **OFF** to use the non-extended variant of the dialect flag.  Note
that because most compilers enable extensions by default, this could
expose cross-platform bugs in user code or in the headers of third-party
dependencies.

<a name="optional-compile-features"></a>

# Optional Compile Features


Compile features may be preferred if available, without creating a hard
requirement.  For example, a library may provides alternative
implementations depending on whether the **cxx\_variadic\_templates**
feature is available:
.INDENT 0.0
.INDENT 3.5

    .ft C
    #if Foo_COMPILER_CXX_VARIADIC_TEMPLATES
    template<int I, int... Is>
    struct Interface;
    
    template<int I>
    struct Interface<I>
    {
      static int accumulate()
      {
        return I;
      }
    };
    
    template<int I, int... Is>
    struct Interface
    {
      static int accumulate()
      {
        return I + Interface<Is...>::accumulate();
      }
    };
    #else
    template<int I1, int I2 = 0, int I3 = 0, int I4 = 0>
    struct Interface
    {
      static int accumulate() { return I1 + I2 + I3 + I4; }
    };
    #endif
    .ft P
.UNINDENT
.UNINDENT

Such an interface depends on using the correct preprocessor defines for the
compiler features.  CMake can generate a header file containing such
defines using the **WriteCompilerDetectionHeader** module.  The
module contains the **write\_compiler\_detection\_header** function which
accepts parameters to control the content of the generated header file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    write_compiler_detection_header(
      FILE "${CMAKE_CURRENT_BINARY_DIR}/foo_compiler_detection.h"
      PREFIX Foo
      COMPILERS GNU
      FEATURES
        cxx_variadic_templates
    )
    .ft P
.UNINDENT
.UNINDENT

Such a header file may be used internally in the source code of a project,
and it may be installed and used in the interface of library code.

For each feature listed in **FEATURES**, a preprocessor definition
is created in the header file, and defined to either **1** or **0**.

Additionally, some features call for additional defines, such as the
**cxx\_final** and **cxx\_override** features. Rather than being used in
**#ifdef** code, the **final** keyword is abstracted by a symbol
which is defined to either **final**, a compiler-specific equivalent, or
to empty.  That way, C++ code can be written to unconditionally use the
symbol, and compiler support determines what it is expanded to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    struct Interface {
      virtual void Execute() = 0;
    };
    
    struct Concrete Foo_FINAL {
      void Execute() Foo_OVERRIDE;
    };
    .ft P
.UNINDENT
.UNINDENT

In this case, **Foo\_FINAL** will expand to **final** if the
compiler supports the keyword, or to empty otherwise.

In this use-case, the CMake code will wish to enable a particular language
standard if available from the compiler. The **CXX\_STANDARD**
target property variable may be set to the desired language standard
for a particular target, and the **CMAKE\_CXX\_STANDARD** may be
set to influence all following targets:
.INDENT 0.0
.INDENT 3.5

    .ft C
    write_compiler_detection_header(
      FILE "${CMAKE_CURRENT_BINARY_DIR}/foo_compiler_detection.h"
      PREFIX Foo
      COMPILERS GNU
      FEATURES
        cxx_final cxx_override
    )
    
    # Includes foo_compiler_detection.h and uses the Foo_FINAL symbol
    # which will expand to 'final' if the compiler supports the requested
    # CXX_STANDARD.
    add_library(foo foo.cpp)
    set_property(TARGET foo PROPERTY CXX_STANDARD 11)
    
    # Includes foo_compiler_detection.h and uses the Foo_FINAL symbol
    # which will expand to 'final' if the compiler supports the feature,
    # even though CXX_STANDARD is not set explicitly.  The requirement of
    # cxx_constexpr causes CMake to set CXX_STANDARD internally, which
    # affects the compile flags.
    add_library(foo_impl foo_impl.cpp)
    target_compile_features(foo_impl PRIVATE cxx_constexpr)
    .ft P
.UNINDENT
.UNINDENT

The **write\_compiler\_detection\_header** function also creates compatibility
code for other features which have standard equivalents.  For example, the
**cxx\_static\_assert** feature is emulated with a template and abstracted
via the **&lt;PREFIX&gt;\_STATIC\_ASSERT** and **&lt;PREFIX&gt;\_STATIC\_ASSERT\_MSG**
function-macros.

<a name="conditional-compilation-options"></a>

# Conditional Compilation Options


Libraries may provide entirely different header files depending on
requested compiler features.

For example, a header at **with\_variadics/interface.h** may contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    template<int I, int... Is>
    struct Interface;
    
    template<int I>
    struct Interface<I>
    {
      static int accumulate()
      {
        return I;
      }
    };
    
    template<int I, int... Is>
    struct Interface
    {
      static int accumulate()
      {
        return I + Interface<Is...>::accumulate();
      }
    };
    .ft P
.UNINDENT
.UNINDENT

while a header at **no\_variadics/interface.h** may contain:
.INDENT 0.0
.INDENT 3.5

    .ft C
    template<int I1, int I2 = 0, int I3 = 0, int I4 = 0>
    struct Interface
    {
      static int accumulate() { return I1 + I2 + I3 + I4; }
    };
    .ft P
.UNINDENT
.UNINDENT

It would be possible to write a abstraction **interface.h** header
containing something like:
.INDENT 0.0
.INDENT 3.5

    .ft C
    #include "foo_compiler_detection.h"
    #if Foo_COMPILER_CXX_VARIADIC_TEMPLATES
    #include "with_variadics/interface.h"
    #else
    #include "no_variadics/interface.h"
    #endif
    .ft P
.UNINDENT
.UNINDENT

However this could be unmaintainable if there are many files to
abstract. What is needed is to use alternative include directories
depending on the compiler capabilities.

CMake provides a **COMPILE\_FEATURES**
**generator expression** to implement
such conditions.  This may be used with the build-property commands such as
**target\_include\_directories()** and **target\_link\_libraries()**
to set the appropriate **buildsystem**
properties:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_library(foo INTERFACE)
    set(with_variadics ${CMAKE_CURRENT_SOURCE_DIR}/with_variadics)
    set(no_variadics ${CMAKE_CURRENT_SOURCE_DIR}/no_variadics)
    target_include_directories(foo
      INTERFACE
        "$<$<COMPILE_FEATURES:cxx_variadic_templates>:${with_variadics}>"
        "$<$<NOT:$<COMPILE_FEATURES:cxx_variadic_templates>>:${no_variadics}>"
      )
    .ft P
.UNINDENT
.UNINDENT

Consuming code then simply links to the **foo** target as usual and uses
the feature-appropriate include directory
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(consumer_with consumer_with.cpp)
    target_link_libraries(consumer_with foo)
    set_property(TARGET consumer_with CXX_STANDARD 11)
    
    add_executable(consumer_no consumer_no.cpp)
    target_link_libraries(consumer_no foo)
    .ft P
.UNINDENT
.UNINDENT

<a name="supported-compilers"></a>

# Supported Compilers


CMake is currently aware of the **C++ standards**
and **compile features** available from
the following **compiler ids** as of the
versions specified for each:
.INDENT 0.0

* ·  
  **AppleClang**: Apple Clang for Xcode versions 4.4+.
* ·  
  **Clang**: Clang compiler versions 2.9+.
* ·  
  **GNU**: GNU compiler versions 4.4+.
* ·  
  **MSVC**: Microsoft Visual Studio versions 2010+.
* ·  
  **SunPro**: Oracle SolarisStudio versions 12.4+.
* ·  
  **Intel**: Intel compiler versions 12.1+.
  .UNINDENT

CMake is currently aware of the **C standards**
and **compile features** available from
the following **compiler ids** as of the
versions specified for each:
.INDENT 0.0

* ·  
  all compilers and versions listed above for C++.
* ·  
  **GNU**: GNU compiler versions 3.4+
  .UNINDENT

CMake is currently aware of the **C++ standards** and
their associated meta-features (e.g. **cxx\_std\_11**) available from the
following **compiler ids** as of the
versions specified for each:
.INDENT 0.0

* ·  
  **Cray**: Cray Compiler Environment version 8.1+.
* ·  
  **PGI**: PGI version 12.10+.
* ·  
  **XL**: IBM XL version 10.1+.
  .UNINDENT

CMake is currently aware of the **C standards** and
their associated meta-features (e.g. **c\_std\_99**) available from the
following **compiler ids** as of the
versions specified for each:
.INDENT 0.0

* ·  
  all compilers and versions listed above with only meta-features for C++.
* ·  
  **TI**: Texas Instruments compiler.
  .UNINDENT

CMake is currently aware of the **CUDA standards** and
their associated meta-features (e.g. **cuda\_std\_11**) available from the
following **compiler ids** as of the
versions specified for each:
.INDENT 0.0

* ·  
  **NVIDIA**: NVIDIA nvcc compiler 7.5+.
  .UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

