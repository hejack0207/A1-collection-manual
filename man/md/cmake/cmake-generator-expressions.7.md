# cmake-generator-expressions(7) - CMake Generator Expressions

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


Generator expressions are evaluated during build system generation to produce
information specific to each build configuration.

Generator expressions are allowed in the context of many target properties,
such as **LINK\_LIBRARIES**, **INCLUDE\_DIRECTORIES**,
**COMPILE\_DEFINITIONS** and others.  They may also be used when using
commands to populate those properties, such as **target\_link\_libraries()**,
**target\_include\_directories()**, **target\_compile\_definitions()**
and others.

They enable conditional linking, conditional definitions used when compiling,
conditional include directories, and more.  The conditions may be based on
the build configuration, target properties, platform information or any other
queryable information.

Generator expressions have the form **$&lt;...&gt;**.  To avoid confusion, this page
deviates from most of the CMake documentation in that it omits angular brackets
**&lt;...&gt;** around placeholders like **condition**, **string**, **target**,
among others.

Generator expressions can be nested, as shown in most of the examples below.

<a name="boolean-generator-expressions"></a>

# Boolean Generator Expressions


Boolean expressions evaluate to either **0** or **1**.
They are typically used to construct the condition in a conditional
generator expression.

Available boolean expressions are:

<a name="logical-operators"></a>

### Logical Operators

.INDENT 0.0

* <b>**$&lt;BOOL:string&gt;**</b>  
  Converts **string** to **0** or **1**. Evaluates to **0** if any of the
  following is true:
  .INDENT 7.0
* ·  
  **string** is empty,
* ·  
  **string** is a case-insensitive equal of
  **0**, **FALSE**, **OFF**, **N**, **NO**, **IGNORE**, or **NOTFOUND**, or
* ·  
  **string** ends in the suffix **-NOTFOUND** (case-sensitive).
  .UNINDENT

Otherwise evaluates to **1**.

* <b>**$&lt;AND:conditions&gt;**</b>  
  where **conditions** is a comma-separated list of boolean expressions.
  Evaluates to **1** if all conditions are **1**.
  Otherwise evaluates to **0**.
* <b>**$&lt;OR:conditions&gt;**</b>  
  where **conditions** is a comma-separated list of boolean expressions.
  Evaluates to **1** if at least one of the conditions is **1**.
  Otherwise evaluates to **0**.
* <b>**$&lt;NOT:condition&gt;**</b>  
  **0** if **condition** is **1**, else **1**.
  .UNINDENT

<a name="string-comparisons"></a>

### String Comparisons

.INDENT 0.0

* <b>**$&lt;STREQUAL:string1,string2&gt;**</b>  
  **1** if **string1** and **string2** are equal, else **0**.
  The comparison is case-sensitive.  For a case-insensitive comparison,
  combine with a _string transforming generator expression_,
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    $<STREQUAL:$<UPPER_CASE:${foo}>,"BAR"> # "1" if ${foo} is any of "BAR", "Bar", "bar", ...
    .ft P
.UNINDENT
.UNINDENT

* <b>**$&lt;EQUAL:value1,value2&gt;**</b>  
  **1** if **value1** and **value2** are numerically equal, else **0**.
* <b>**$&lt;IN\_LIST:string,list&gt;**</b>  
  **1** if **string** is member of the semicolon-separated **list**, else **0**.
  Uses case-sensitive comparisons.
* <b>**$&lt;VERSION\_LESS:v1,v2&gt;**</b>  
  **1** if **v1** is a version less than **v2**, else **0**.
* <b>**$&lt;VERSION\_GREATER:v1,v2&gt;**</b>  
  **1** if **v1** is a version greater than **v2**, else **0**.
* <b>**$&lt;VERSION\_EQUAL:v1,v2&gt;**</b>  
  **1** if **v1** is the same version as **v2**, else **0**.
* <b>**$&lt;VERSION\_LESS\_EQUAL:v1,v2&gt;**</b>  
  **1** if **v1** is a version less than or equal to **v2**, else **0**.
* <b>**$&lt;VERSION\_GREATER\_EQUAL:v1,v2&gt;**</b>  
  **1** if **v1** is a version greater than or equal to **v2**, else **0**.
  .UNINDENT

<a name="variable-queries"></a>

### Variable Queries

.INDENT 0.0

* <b>**$&lt;TARGET\_EXISTS:target&gt;**</b>  
  **1** if **target** exists, else **0**.
* <b>**$&lt;CONFIG:cfg&gt;**</b>  
  **1** if config is **cfg**, else **0**. This is a case-insensitive comparison.
  The mapping in **MAP\_IMPORTED\_CONFIG\_&lt;CONFIG&gt;** is also considered by
  this expression when it is evaluated on a property on an **IMPORTED**
  target.
* <b>**$&lt;PLATFORM\_ID:platform\_ids&gt;**</b>  
  where **platform\_ids** is a comma-separated list.
  **1** if the CMake’s platform id matches any one of the entries in
  **platform\_ids**, otherwise **0**.
  See also the **CMAKE\_SYSTEM\_NAME** variable.
* <b>**$&lt;C\_COMPILER\_ID:compiler\_ids&gt;**</b>  
  where **compiler\_ids** is a comma-separated list.
  **1** if the CMake’s compiler id of the C compiler matches any one
  of the entries in **compiler\_ids**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;CXX\_COMPILER\_ID:compiler\_ids&gt;**</b>  
  where **compiler\_ids** is a comma-separated list.
  **1** if the CMake’s compiler id of the CXX compiler matches any one
  of the entries in **compiler\_ids**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;CUDA\_COMPILER\_ID:compiler\_ids&gt;**</b>  
  where **compiler\_ids** is a comma-separated list.
  **1** if the CMake’s compiler id of the CUDA compiler matches any one
  of the entries in **compiler\_ids**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;OBJC\_COMPILER\_ID:compiler\_ids&gt;**</b>  
  where **compiler\_ids** is a comma-separated list.
  **1** if the CMake’s compiler id of the Objective-C compiler matches any one
  of the entries in **compiler\_ids**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;OBJCXX\_COMPILER\_ID:compiler\_ids&gt;**</b>  
  where **compiler\_ids** is a comma-separated list.
  **1** if the CMake’s compiler id of the Objective-C++ compiler matches any one
  of the entries in **compiler\_ids**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;Fortran\_COMPILER\_ID:compiler\_ids&gt;**</b>  
  where **compiler\_ids** is a comma-separated list.
  **1** if the CMake’s compiler id of the Fortran compiler matches any one
  of the entries in **compiler\_ids**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;C\_COMPILER\_VERSION:version&gt;**</b>  
  **1** if the version of the C compiler matches **version**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;CXX\_COMPILER\_VERSION:version&gt;**</b>  
  **1** if the version of the CXX compiler matches **version**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;CUDA\_COMPILER\_VERSION:version&gt;**</b>  
  **1** if the version of the CXX compiler matches **version**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;OBJC\_COMPILER\_VERSION:version&gt;**</b>  
  **1** if the version of the OBJC compiler matches **version**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;OBJCXX\_COMPILER\_VERSION:version&gt;**</b>  
  **1** if the version of the OBJCXX compiler matches **version**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;Fortran\_COMPILER\_VERSION:version&gt;**</b>  
  **1** if the version of the Fortran compiler matches **version**, otherwise **0**.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;TARGET\_POLICY:policy&gt;**</b>  
  **1** if the **policy** was NEW when the ‘head’ target was created,
  else **0**.  If the **policy** was not set, the warning message for the policy
  will be emitted. This generator expression only works for a subset of
  policies.
* <b>**$&lt;COMPILE\_FEATURES:features&gt;**</b>  
  where **features** is a comma-spearated list.
  Evaluates to **1** if all of the **features** are available for the ‘head’
  target, and **0** otherwise. If this expression is used while evaluating
  the link implementation of a target and if any dependency transitively
  increases the required **C\_STANDARD** or **CXX\_STANDARD**
  for the ‘head’ target, an error is reported.  See the
  **cmake-compile-features(7)** manual for information on
  compile features and a list of supported compilers.
  .UNINDENT
  .INDENT 0.0
* <b>**$&lt;COMPILE\_LANG\_AND\_ID:language,compiler\_ids&gt;**</b>  
  **1** when the language used for compilation unit matches **language** and
  the CMake’s compiler id of the language compiler matches any one of the
  entries in **compiler\_ids**, otherwise **0**. This expression is a short form
  for the combination of **$&lt;COMPILE\_LANGUAGE:language&gt;** and
  **$&lt;LANG\_COMPILER\_ID:compiler\_ids&gt;**. This expression may be used to specify
  compile options, compile definitions, and include directories for source files of a
  particular language and compiler combination in a target. For example:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    add_executable(myapp main.cpp foo.c bar.cpp zot.cu)
    target_compile_definitions(myapp
      PRIVATE $<$<COMPILE_LANG_AND_ID:CXX,AppleClang,Clang>:COMPILING_CXX_WITH_CLANG>
              $<$<COMPILE_LANG_AND_ID:CXX,Intel>:COMPILING_CXX_WITH_INTEL>
              $<$<COMPILE_LANG_AND_ID:C,Clang>:COMPILING_C_WITH_CLANG>
    )
    .ft P
.UNINDENT
.UNINDENT

This specifies the use of different compile definitions based on both
the compiler id and compilation language. This example will have a
**COMPILING\_CXX\_WITH\_CLANG** compile definition when Clang is the CXX
compiler, and **COMPILING\_CXX\_WITH\_INTEL** when Intel is the CXX compiler.
Likewise when the C compiler is Clang it will only see the  **COMPILING\_C\_WITH\_CLANG**
definition.

Without the **COMPILE\_LANG\_AND\_ID** generator expression the same logic
would be expressed as:
.INDENT 7.0
.INDENT 3.5

    .ft C
    target_compile_definitions(myapp
      PRIVATE $<$<AND:$<COMPILE_LANGUAGE:CXX>,$<CXX_COMPILER_ID:AppleClang,Clang>>:COMPILING_CXX_WITH_CLANG>
              $<$<AND:$<COMPILE_LANGUAGE:CXX>,$<CXX_COMPILER_ID:Intel>>:COMPILING_CXX_WITH_INTEL>
              $<$<AND:$<COMPILE_LANGUAGE:C>,$<C_COMPILER_ID:Clang>>:COMPILING_C_WITH_CLANG>
    )
    .ft P
.UNINDENT
.UNINDENT

* <b>**$&lt;COMPILE\_LANGUAGE:languages&gt;**</b>  
  **1** when the language used for compilation unit matches any of the entries
  in **languages**, otherwise **0**.  This expression may be used to specify
  compile options, compile definitions, and include directories for source files of a
  particular language in a target. For example:
  .INDENT 7.0
  .INDENT 3.5

    .ft C
    add_executable(myapp main.cpp foo.c bar.cpp zot.cu)
    target_compile_options(myapp
      PRIVATE $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    )
    target_compile_definitions(myapp
      PRIVATE $<$<COMPILE_LANGUAGE:CXX>:COMPILING_CXX>
              $<$<COMPILE_LANGUAGE:CUDA>:COMPILING_CUDA>
    )
    target_include_directories(myapp
      PRIVATE $<$<COMPILE_LANGUAGE:CXX,CUDA>:/opt/foo/headers>
    )
    .ft P
.UNINDENT
.UNINDENT

This specifies the use of the **-fno-exceptions** compile option,
**COMPILING\_CXX** compile definition, and **cxx\_headers** include
directory for C++ only (compiler id checks elided).  It also specifies
a **COMPILING\_CUDA** compile definition for CUDA.

Note that with Visual Studio Generators and **Xcode** there
is no way to represent target-wide compile definitions or include directories
separately for **C** and **CXX** languages.
Also, with Visual Studio Generators there is no way to represent
target-wide flags separately for **C** and **CXX** languages.  Under these
generators, expressions for both C and C++ sources will be evaluated
using **CXX** if there are any C++ sources and otherwise using **C**.
A workaround is to create separate libraries for each source file language
instead:
.INDENT 7.0
.INDENT 3.5

    .ft C
    add_library(myapp_c foo.c)
    add_library(myapp_cxx bar.cpp)
    target_compile_options(myapp_cxx PUBLIC -fno-exceptions)
    add_executable(myapp main.cpp)
    target_link_libraries(myapp myapp_c myapp_cxx)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT

<a name="string-valued-generator-expressions"></a>

# String-Valued Generator Expressions


These expressions expand to some string.
For example,
.INDENT 0.0
.INDENT 3.5

    .ft C
    include_directories(/usr/include/$<CXX_COMPILER_ID>/)
    .ft P
.UNINDENT
.UNINDENT

expands to **/usr/include/GNU/** or **/usr/include/Clang/** etc, depending on
the compiler identifier.

String-valued expressions may also be combined with other expressions.
Here an example for a string-valued expression within a boolean expressions
within a conditional expression:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $<$<VERSION_LESS:$<CXX_COMPILER_VERSION>,4.2.0>:OLD_COMPILER>
    .ft P
.UNINDENT
.UNINDENT

expands to **OLD\_COMPILER** if the
**CMAKE\_CXX\_COMPILER\_VERSION** is less
than 4.2.0.

And here two nested string-valued expressions:
.INDENT 0.0
.INDENT 3.5

    .ft C
    -I$<JOIN:$<TARGET_PROPERTY:INCLUDE_DIRECTORIES>, -I>
    .ft P
.UNINDENT
.UNINDENT

generates a string of the entries in the **INCLUDE\_DIRECTORIES** target
property with each entry preceded by **-I**.

Expanding on the previous example, if one first wants to check if the
**INCLUDE\_DIRECTORIES** property is non-empty, then it is advisable to
introduce a helper variable to keep the code readable:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(prop "$<TARGET_PROPERTY:INCLUDE_DIRECTORIES>") # helper variable
    $<$<BOOL:${prop}>:-I$<JOIN:${prop}, -I>>
    .ft P
.UNINDENT
.UNINDENT

The following string-valued generator expressions are available:

<a name="escaped-characters"></a>

### Escaped Characters


String literals to escape the special meaning a character would otherwise have:
.INDENT 0.0

* <b>**$&lt;ANGLE-R&gt;**</b>  
  A literal **&gt;**. Used for example to compare strings that contain a **&gt;**.
* <b>**$&lt;COMMA&gt;**</b>  
  A literal **,**. Used for example to compare strings which contain a **,**.
* <b>**$&lt;SEMICOLON&gt;**</b>  
  A literal **;**. Used to prevent list expansion on an argument with **;**.
  .UNINDENT

<a name="conditional-expressions"></a>

### Conditional Expressions


Conditional generator expressions depend on a boolean condition
that must be **0** or **1**.
.INDENT 0.0

* <b>**$&lt;condition:true\_string&gt;**</b>  
  Evaluates to **true\_string** if **condition** is **1**.
  Otherwise evaluates to the empty string.
* <b>**$&lt;IF:condition,true\_string,false\_string&gt;**</b>  
  Evaluates to **true\_string** if **condition** is **1**.
  Otherwise evaluates to **false\_string**.
  .UNINDENT

Typically, the **condition** is a _boolean generator expression_.  For instance,
.INDENT 0.0
.INDENT 3.5

    .ft C
    $<$<CONFIG:Debug>:DEBUG_MODE>
    .ft P
.UNINDENT
.UNINDENT

expands to **DEBUG\_MODE** when the **Debug** configuration is used, and
otherwise expands to the empty string.

<a name="string-transformations"></a>

### String Transformations

.INDENT 0.0

* <b>**$&lt;JOIN:list,string&gt;**</b>  
  Joins the list with the content of **string**.
* <b>**$&lt;REMOVE\_DUPLICATES:list&gt;**</b>  
  Removes duplicated items in the given **list**.
* <b>**$&lt;FILTER:list,INCLUDE|EXCLUDE,regex&gt;**</b>  
  Includes or removes items from **list** that match the regular expression **regex**.
* <b>**$&lt;LOWER\_CASE:string&gt;**</b>  
  Content of **string** converted to lower case.
* <b>**$&lt;UPPER\_CASE:string&gt;**</b>  
  Content of **string** converted to upper case.
* <b>**$&lt;GENEX\_EVAL:expr&gt;**</b>  
  Content of **expr** evaluated as a generator expression in the current
  context. This enables consumption of generator expressions whose
  evaluation results itself in generator expressions.
* <b>**$&lt;TARGET\_GENEX\_EVAL:tgt,expr&gt;**</b>  
  Content of **expr** evaluated as a generator expression in the context of
  **tgt** target. This enables consumption of custom target properties that
  themselves contain generator expressions.

Having the capability to evaluate generator expressions is very useful when
you want to manage custom properties supporting generator expressions.
For example:
.INDENT 7.0
.INDENT 3.5

    .ft C
    add_library(foo ...)
    
    set_property(TARGET foo PROPERTY
      CUSTOM_KEYS $<$<CONFIG:DEBUG>:FOO_EXTRA_THINGS>
    )
    
    add_custom_target(printFooKeys
      COMMAND ${CMAKE_COMMAND} -E echo $<TARGET_PROPERTY:foo,CUSTOM_KEYS>
    )
    .ft P
.UNINDENT
.UNINDENT

This naive implementation of the **printFooKeys** custom command is wrong
because **CUSTOM\_KEYS** target property is not evaluated and the content
is passed as is (i.e. **$&lt;$&lt;CONFIG:DEBUG&gt;:FOO\_EXTRA\_THINGS&gt;**).

To have the expected result (i.e. **FOO\_EXTRA\_THINGS** if config is
**Debug**), it is required to evaluate the output of
**$&lt;TARGET\_PROPERTY:foo,CUSTOM\_KEYS&gt;**:
.INDENT 7.0
.INDENT 3.5

    .ft C
    add_custom_target(printFooKeys
      COMMAND ${CMAKE_COMMAND} -E
        echo $<TARGET_GENEX_EVAL:foo,$<TARGET_PROPERTY:foo,CUSTOM_KEYS>>
    )
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT

<a name="variable-queries"></a>

### Variable Queries

.INDENT 0.0

* <b>**$&lt;CONFIG&gt;**</b>  
  Configuration name.
* <b>**$&lt;CONFIGURATION&gt;**</b>  
  Configuration name. Deprecated since CMake 3.0. Use **CONFIG** instead.
* <b>**$&lt;PLATFORM\_ID&gt;**</b>  
  The current system’s CMake platform id.
  See also the **CMAKE\_SYSTEM\_NAME** variable.
* <b>**$&lt;C\_COMPILER\_ID&gt;**</b>  
  The CMake’s compiler id of the C compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;CXX\_COMPILER\_ID&gt;**</b>  
  The CMake’s compiler id of the CXX compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;CUDA\_COMPILER\_ID&gt;**</b>  
  The CMake’s compiler id of the CUDA compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;OBJC\_COMPILER\_ID&gt;**</b>  
  The CMake’s compiler id of the OBJC compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;OBJCXX\_COMPILER\_ID&gt;**</b>  
  The CMake’s compiler id of the OBJCXX compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;Fortran\_COMPILER\_ID&gt;**</b>  
  The CMake’s compiler id of the Fortran compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable.
* <b>**$&lt;C\_COMPILER\_VERSION&gt;**</b>  
  The version of the C compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;CXX\_COMPILER\_VERSION&gt;**</b>  
  The version of the CXX compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;CUDA\_COMPILER\_VERSION&gt;**</b>  
  The version of the CUDA compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;OBJC\_COMPILER\_VERSION&gt;**</b>  
  The version of the OBJC compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;OBJCXX\_COMPILER\_VERSION&gt;**</b>  
  The version of the OBJCXX compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;Fortran\_COMPILER\_VERSION&gt;**</b>  
  The version of the Fortran compiler used.
  See also the **CMAKE\_&lt;LANG&gt;\_COMPILER\_VERSION** variable.
* <b>**$&lt;COMPILE\_LANGUAGE&gt;**</b>  
  The compile language of source files when evaluating compile options.
  See _the related boolean expression_
  **$&lt;COMPILE\_LANGUAGE:language&gt;**
  for notes about the portability of this generator expression.
  .UNINDENT

<a name="target-dependent-queries"></a>

### Target\-Dependent Queries

.INDENT 0.0

* <b>**$&lt;TARGET\_NAME\_IF\_EXISTS:tgt&gt;**</b>  
  Expands to the **tgt** if the given target exists, an empty string
  otherwise.
* <b>**$&lt;TARGET\_FILE:tgt&gt;**</b>  
  Full path to main file (.exe, .so.1.2, .a) where **tgt** is the name of a
  target.
* <b>**$&lt;TARGET\_FILE\_BASE\_NAME:tgt&gt;**</b>  
  Base name of main file where **tgt** is the name of a target.

The base name corresponds to the target file name (see
**$&lt;TARGET\_FILE\_NAME:tgt&gt;**) without prefix and suffix. For example, if
target file name is **libbase.so**, the base name is **base**.

See also the **OUTPUT\_NAME**, **ARCHIVE\_OUTPUT\_NAME**,
**LIBRARY\_OUTPUT\_NAME** and **RUNTIME\_OUTPUT\_NAME**
target properties and their configuration specific variants
**OUTPUT\_NAME\_&lt;CONFIG&gt;**, **ARCHIVE\_OUTPUT\_NAME\_&lt;CONFIG&gt;**,
**LIBRARY\_OUTPUT\_NAME\_&lt;CONFIG&gt;** and
**RUNTIME\_OUTPUT\_NAME\_&lt;CONFIG&gt;**.

The **&lt;CONFIG&gt;\_POSTFIX** and **DEBUG\_POSTFIX** target
properties can also be considered.

Note that **tgt** is not added as a dependency of the target this
expression is evaluated on.

* <b>**$&lt;TARGET\_FILE\_PREFIX:tgt&gt;**</b>  
  Prefix of main file where **tgt** is the name of a target.

See also the **PREFIX** target property.

Note that **tgt** is not added as a dependency of the target this
expression is evaluated on.

* <b>**$&lt;TARGET\_FILE\_SUFFIX:tgt&gt;**</b>  
  Suffix of main file where **tgt** is the name of a target.

The suffix corresponds to the file extension (such as “.so” or “.exe”).

See also the **SUFFIX** target property.

Note that **tgt** is not added as a dependency of the target this
expression is evaluated on.

* <b>**$&lt;TARGET\_FILE\_NAME:tgt&gt;**</b>  
  Name of main file (.exe, .so.1.2, .a).
* <b>**$&lt;TARGET\_FILE\_DIR:tgt&gt;**</b>  
  Directory of main file (.exe, .so.1.2, .a).
* <b>**$&lt;TARGET\_LINKER\_FILE:tgt&gt;**</b>  
  File used to link (.a, .lib, .so) where **tgt** is the name of a target.
* <b>**$&lt;TARGET\_LINKER\_FILE\_BASE\_NAME:tgt&gt;**</b>  
  Base name of file used to link where **tgt** is the name of a target.

The base name corresponds to the target linker file name (see
**$&lt;TARGET\_LINKER\_FILE\_NAME:tgt&gt;**) without prefix and suffix. For example,
if target file name is **libbase.a**, the base name is **base**.

See also the **OUTPUT\_NAME**, **ARCHIVE\_OUTPUT\_NAME**,
and **LIBRARY\_OUTPUT\_NAME** target properties and their configuration
specific variants **OUTPUT\_NAME\_&lt;CONFIG&gt;**,
**ARCHIVE\_OUTPUT\_NAME\_&lt;CONFIG&gt;** and
**LIBRARY\_OUTPUT\_NAME\_&lt;CONFIG&gt;**.

The **&lt;CONFIG&gt;\_POSTFIX** and **DEBUG\_POSTFIX** target
properties can also be considered.

Note that **tgt** is not added as a dependency of the target this
expression is evaluated on.

* <b>**$&lt;TARGET\_LINKER\_FILE\_PREFIX:tgt&gt;**</b>  
  Prefix of file used to link where **tgt** is the name of a target.

See also the **PREFIX** and **IMPORT\_PREFIX** target
properties.

Note that **tgt** is not added as a dependency of the target this
expression is evaluated on.

* <b>**$&lt;TARGET\_LINKER\_FILE\_SUFFIX:tgt&gt;**</b>  
  Suffix of file used to link where **tgt** is the name of a target.

The suffix corresponds to the file extension (such as “.so” or “.lib”).

See also the **SUFFIX** and **IMPORT\_SUFFIX** target
properties.

Note that **tgt** is not added as a dependency of the target this
expression is evaluated on.

* <b>**$&lt;TARGET\_LINKER\_FILE\_NAME:tgt&gt;**</b>  
  Name of file used to link (.a, .lib, .so).
* <b>**$&lt;TARGET\_LINKER\_FILE\_DIR:tgt&gt;**</b>  
  Directory of file used to link (.a, .lib, .so).
* <b>**$&lt;TARGET\_SONAME\_FILE:tgt&gt;**</b>  
  File with soname (.so.3) where **tgt** is the name of a target.
* <b>**$&lt;TARGET\_SONAME\_FILE\_NAME:tgt&gt;**</b>  
  Name of file with soname (.so.3).
* <b>**$&lt;TARGET\_SONAME\_FILE\_DIR:tgt&gt;**</b>  
  Directory of with soname (.so.3).
* <b>**$&lt;TARGET\_PDB\_FILE:tgt&gt;**</b>  
  Full path to the linker generated program database file (.pdb)
  where **tgt** is the name of a target.

See also the **PDB\_NAME** and **PDB\_OUTPUT\_DIRECTORY**
target properties and their configuration specific variants
**PDB\_NAME\_&lt;CONFIG&gt;** and **PDB\_OUTPUT\_DIRECTORY\_&lt;CONFIG&gt;**.

* <b>**$&lt;TARGET\_PDB\_FILE\_BASE\_NAME:tgt&gt;**</b>  
  Base name of the linker generated program database file (.pdb)
  where **tgt** is the name of a target.

The base name corresponds to the target PDB file name (see
**$&lt;TARGET\_PDB\_FILE\_NAME:tgt&gt;**) without prefix and suffix. For example,
if target file name is **base.pdb**, the base name is **base**.

See also the **PDB\_NAME** target property and its configuration
specific variant **PDB\_NAME\_&lt;CONFIG&gt;**.

The **&lt;CONFIG&gt;\_POSTFIX** and **DEBUG\_POSTFIX** target
properties can also be considered.

Note that **tgt** is not added as a dependency of the target this
expression is evaluated on.

* <b>**$&lt;TARGET\_PDB\_FILE\_NAME:tgt&gt;**</b>  
  Name of the linker generated program database file (.pdb).
* <b>**$&lt;TARGET\_PDB\_FILE\_DIR:tgt&gt;**</b>  
  Directory of the linker generated program database file (.pdb).
* <b>**$&lt;TARGET\_BUNDLE\_DIR:tgt&gt;**</b>  
  Full path to the bundle directory (**my.app**, **my.framework**, or
  **my.bundle**) where **tgt** is the name of a target.
* <b>**$&lt;TARGET\_BUNDLE\_CONTENT\_DIR:tgt&gt;**</b>  
  Full path to the bundle content directory where **tgt** is the name of a
  target. For the macOS SDK it leads to **my.app/Contents**, **my.framework**,
  or **my.bundle/Contents**. For all other SDKs (e.g. iOS) it leads to
  **my.app**, **my.framework**, or **my.bundle** due to the flat bundle
  structure.
* <b>**$&lt;TARGET\_PROPERTY:tgt,prop&gt;**</b>  
  Value of the property **prop** on the target **tgt**.

Note that **tgt** is not added as a dependency of the target this
expression is evaluated on.

* <b>**$&lt;TARGET\_PROPERTY:prop&gt;**</b>  
  Value of the property **prop** on the target on which the generator
  expression is evaluated. Note that for generator expressions in
  Target Usage Requirements this is the value of the property
  on the consuming target rather than the target specifying the
  requirement.
* <b>**$&lt;INSTALL\_PREFIX&gt;**</b>  
  Content of the install prefix when the target is exported via
  **install(EXPORT)**, or when evaluated in
  **INSTALL\_NAME\_DIR**, and empty otherwise.
  .UNINDENT

<a name="output-related-expressions"></a>

### Output\-Related Expressions

.INDENT 0.0

* <b>**$&lt;TARGET\_NAME:...&gt;**</b>  
  Marks **...** as being the name of a target.  This is required if exporting
  targets to multiple dependent export sets.  The **...** must be a literal
  name of a target- it may not contain generator expressions.
* <b>**$&lt;LINK\_ONLY:...&gt;**</b>  
  Content of **...** except when evaluated in a link interface while
  propagating Target Usage Requirements, in which case it is the
  empty string.
  Intended for use only in an **INTERFACE\_LINK\_LIBRARIES** target
  property, perhaps via the **target\_link\_libraries()** command,
  to specify private link dependencies without other usage requirements.
* <b>**$&lt;INSTALL\_INTERFACE:...&gt;**</b>  
  Content of **...** when the property is exported using **install(EXPORT)**,
  and empty otherwise.
* <b>**$&lt;BUILD\_INTERFACE:...&gt;**</b>  
  Content of **...** when the property is exported using **export()**, or
  when the target is used by another target in the same buildsystem. Expands to
  the empty string otherwise.
* <b>**$&lt;MAKE\_C\_IDENTIFIER:...&gt;**</b>  
  Content of **...** converted to a C identifier.  The conversion follows the
  same behavior as **string(MAKE\_C\_IDENTIFIER)**.
* <b>**$&lt;TARGET\_OBJECTS:objLib&gt;**</b>  
  List of objects resulting from build of **objLib**.
* <b>**$&lt;SHELL\_PATH:...&gt;**</b>  
  Content of **...** converted to shell path style. For example, slashes are
  converted to backslashes in Windows shells and drive letters are converted
  to posix paths in MSYS shells. The **...** must be an absolute path.
  The **...** may be a semicolon-separated list
  of paths, in which case each path is converted individually and a result
  list is generated using the shell path separator (**:** on POSIX and
  **;** on Windows).  Be sure to enclose the argument containing this genex
  in double quotes in CMake source code so that **;** does not split arguments.
  .UNINDENT

<a name="debugging"></a>

# Debugging


Since generator expressions are evaluated during generation of the buildsystem,
and not during processing of **CMakeLists.txt** files, it is not possible to
inspect their result with the **message()** command.

One possible way to generate debug messages is to add a custom target,
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_custom_target(genexdebug COMMAND ${CMAKE_COMMAND} -E echo "$<...>")
    .ft P
.UNINDENT
.UNINDENT

The shell command **make genexdebug** (invoked after execution of **cmake**)
would then print the result of **$&lt;...&gt;**.

Another way is to write debug messages to a file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    file(GENERATE OUTPUT filename CONTENT "$<...>")
    .ft P
.UNINDENT
.UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

