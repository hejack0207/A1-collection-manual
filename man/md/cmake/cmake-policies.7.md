# cmake-policies(7) - CMake Policies Reference

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


Policies in CMake are used to preserve backward compatible behavior
across multiple releases.  When a new policy is introduced, newer CMake
versions will begin to warn about the backward compatible behavior.  It
is possible to disable the warning by explicitly requesting the OLD, or
backward compatible behavior using the **cmake\_policy()** command.
It is also possible to request **NEW**, or non-backward compatible behavior
for a policy, also avoiding the warning.  Each policy can also be set to
either **NEW** or **OLD** behavior explicitly on the command line with the
**CMAKE\_POLICY\_DEFAULT\_CMP&lt;NNNN&gt;** variable.

A policy is a deprecation mechanism and not a reliable feature toggle.
A policy should almost never be set to **OLD**, except to silence warnings
in an otherwise frozen or stable codebase, or temporarily as part of a
larger migration path. The **OLD** behavior of each policy is undesirable
and will be replaced with an error condition in a future release.

The **cmake\_minimum\_required()** command does more than report an
error if a too-old version of CMake is used to build a project.  It
also sets all policies introduced in that CMake version or earlier to
**NEW** behavior.  To manage policies without increasing the minimum required
CMake version, the **if(POLICY)** command may be used:
.INDENT 0.0
.INDENT 3.5

    .ft C
    if(POLICY CMP0990)
      cmake_policy(SET CMP0990 NEW)
    endif()
    .ft P
.UNINDENT
.UNINDENT

This has the effect of using the **NEW** behavior with newer CMake releases which
users may be using and not issuing a compatibility warning.

The setting of a policy is confined in some cases to not propagate to the
parent scope.  For example, if the files read by the **include()** command
or the **find\_package()** command contain a use of **cmake\_policy()**,
that policy setting will not affect the caller by default.  Both commands accept
an optional **NO\_POLICY\_SCOPE** keyword to control this behavior.

The **CMAKE\_MINIMUM\_REQUIRED\_VERSION** variable may also be used
to determine whether to report an error on use of deprecated macros or
functions.

<a name="policies-introduced-by-cmake-317"></a>

# Policies Introduced by Cmake 3.17


<a name="cmp0102"></a>

### CMP0102


The **mark\_as\_advanced()** command no longer creates a cache entry if one
does not already exist.

In CMake 3.16 and below, if a variable was not defined at all or just defined
locally, the **mark\_as\_advanced()** command would create a new cache
entry with an **UNINITIALIZED** type and no value. When a **find\_path()**
(or other similar **find\_** command) would next run, it would find this
undefined cache entry and set it up with an empty string value. This process
would end up deleting the local variable in the process (due to the way the
cache works), effectively clearing any stored **find\_** results that were only
available in the local scope.

The **OLD** behavior for this policy is to create the empty cache definition.
The **NEW** behavior of this policy is to ignore variables which do not
already exist in the cache.

This policy was introduced in CMake version 3.17.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike many policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0101"></a>

### CMP0101


**target\_compile\_options()** now honors **BEFORE** keyword in all scopes.

In CMake 3.16 and below the **target\_compile\_options()** ignores the
**BEFORE** keyword in private scope. CMake 3.17 and later honors
**BEFORE** keyword in all scopes. This policy provides compatibility for
projects that have not been updated to expect the new behavior.

The **OLD** behavior for this policy is to not honor **BEFORE** keyword in
private scope. The **NEW** behavior of this policy is to honor
**BEFORE** keyword in all scopes.

This policy was introduced in CMake version 3.17.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike many policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0100"></a>

### CMP0100


Let **AUTOMOC** and **AUTOUIC** process
header files that end with a **.hh** extension.

Since version 3.17, CMake processes header files that end with a
**.hh** extension in **AUTOMOC** and **AUTOUIC**.
In earlier CMake versions, these header files were ignored by
**AUTOMOC** and **AUTOUIC**.

This policy affects how header files that end with a **.hh** extension
get treated in **AUTOMOC** and **AUTOUIC**.

The **OLD** behavior for this policy is to ignore **.hh** header files
in **AUTOMOC** and **AUTOUIC**.

The **NEW** behavior for this policy is to process **.hh** header files
in **AUTOMOC** and **AUTOUIC** just like other header files.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
To silence the **CMP0100** warning source files can be excluded from
**AUTOMOC** and **AUTOUIC** processing by setting the
source file properties **SKIP\_AUTOMOC**, **SKIP\_AUTOUIC** or
**SKIP\_AUTOGEN**.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # Source skip example:
    set_property(SOURCE /path/to/file1.hh PROPERTY SKIP_AUTOMOC ON)
    set_property(SOURCE /path/to/file2.hh PROPERTY SKIP_AUTOUIC ON)
    set_property(SOURCE /path/to/file3.hh PROPERTY SKIP_AUTOGEN ON)
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

This policy was introduced in CMake version 3.17.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0099"></a>

### CMP0099


Target link properties **INTERFACE\_LINK\_OPTIONS**,
**INTERFACE\_LINK\_DIRECTORIES** and **INTERFACE\_LINK\_DEPENDS**
are now transitive over private dependencies of static libraries.

In CMake 3.16 and below the interface link properties attached to libraries
are not propagated for private dependencies of static libraries.
Only the libraries themselves are propagated to link the dependent binary.
CMake 3.17 and later prefer to propagate all interface link properties.
This policy provides compatibility for projects that have not been updated
to expect the new behavior.

The **OLD** behavior for this policy is to not propagate interface link
properties. The **NEW** behavior of this policy is to propagate interface link
properties.

This policy was introduced in CMake version 3.17.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike many policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0098"></a>

### CMP0098


**FindFLEX** runs **flex** in directory
**CMAKE\_CURRENT\_BINARY\_DIR** when executing.

The module provides a **FLEX\_TARGET** macro which generates FLEX output.
In CMake 3.16 and below the macro would generate a custom command that runs
**flex** in the current source directory.  CMake 3.17 and later prefer to
run it in the build directory and use **CMAKE\_CURRENT\_BINARY\_DIR**
as the **WORKING\_DIRECTORY** of its **add\_custom\_command()** invocation.
This ensures that any implicitly generated file is written relative to the
build tree rather than the source tree, unless the generated file is
provided as absolute path.

This policy provides compatibility for projects that have not been updated
to expect the new behavior.

The **OLD** behavior for this policy is for **FLEX\_TARGET** to use
the current source directory for the **WORKING\_DIRECTORY** and where
to generate implicit files. The **NEW** behavior of this policy is to
use the current binary directory for the **WORKING\_DIRECTORY** relative to
which implicit files are generated unless provided as absolute path.

This policy was introduced in CMake version 3.17.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike many policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-316"></a>

# Policies Introduced by Cmake 3.16


<a name="cmp0097"></a>

### CMP0097


**ExternalProject\_Add()** with **GIT_SUBMODULES ""** initializes no
submodules.

The module provides a **GIT\_SUBMODULES** option which controls what submodules
to initialize and update. Starting with CMake 3.16, explicitly setting
**GIT\_SUBMODULES** to an empty string means no submodules will be initialized
or updated.

This policy provides compatibility for projects that have not been updated
to expect the new behavior.

The **OLD** behavior for this policy is for **GIT\_SUBMODULES** when set to
an empty string to initialize and update all git submodules.
The **NEW** behavior for this policy is for **GIT\_SUBMODULES** when set to
an empty string to initialize and update no git submodules.

This policy was introduced in CMake version 3.16.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike most policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

<a name="cmp0096"></a>

### CMP0096


The **project()** command preserves leading zeros in version components.

When a **VERSION &lt;major&gt;[.&lt;minor&gt;[.&lt;patch&gt;[.&lt;tweak&gt;]]]]** argument is given
to the **project()** command, it stores the version string in the
**PROJECT\_VERSION** variable and stores individual integer version components
in **PROJECT\_VERSION\_{MAJOR,MINOR,PATCH,TWEAK}** variables (see policy
**CMP0048**).  CMake 3.15 and below dropped leading zeros from each
component.  CMake 3.16 and higher prefer to preserve leading zeros.  This
policy provides compatibility for projects that have not been updated to
expect the new behavior.

The **OLD** behavior of this policy drops leading zeros in all components,
e.g.  such that version **1.07.06** becomes **1.7.6**.  The **NEW** behavior
of this policy preserves the leading zeros in all components, such that
version **1.07.06** remains unchanged.

This policy was introduced in CMake version 3.16.  Unlike many policies, CMake
version 3.17.2 does _not_ warn when this policy is not set and simply uses
the **OLD** behavior.  Use the **cmake\_policy()** command to set it to
**OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0095"></a>

### CMP0095


**RPATH** entries are properly escaped in the intermediary CMake install script.

In CMake 3.15 and earlier, **RPATH** entries set via
**CMAKE\_INSTALL\_RPATH** or via **INSTALL\_RPATH** have not been
escaped before being inserted into the **cmake\_install.cmake** script. Dynamic
linkers on ELF-based systems (e.g. Linux and FreeBSD) allow certain keywords in
**RPATH** entries, such as **${ORIGIN}** (More details are available in the
**ld.so** man pages on those systems). The syntax of these keywords can match
CMake’s variable syntax. In order to not be substituted (usually to an empty
string) already by the intermediary **cmake\_install.cmake** script, the user had
to double-escape such **RPATH** keywords, e.g.
**set(CMAKE_INSTALL_RPATH "\e\e\e${ORIGIN}/../lib")**. Since the intermediary
**cmake\_install.cmake** script is an implementation detail of CMake, CMake 3.16
and later will make sure **RPATH** entries are inserted literally by escaping
any coincidental CMake syntax.

The **OLD** behavior of this policy is to not escape **RPATH** entries in the
intermediary **cmake\_install.cmake** script. The **NEW** behavior is to properly
escape coincidental CMake syntax in **RPATH** entries when generating the
intermediary **cmake\_install.cmake** script.

This policy was introduced in CMake version 3.16. CMake version 3.17.2 warns
when the policy is not set and detected usage of CMake-like syntax and uses
**OLD** behavior. Use the **cmake\_policy()** command to set it to **OLD**
or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-315"></a>

# Policies Introduced by Cmake 3.15


<a name="cmp0094"></a>

### CMP0094


Modules **FindPython3**, **FindPython2** and **FindPython**
use **LOCATION** for lookup strategy.

Starting with CMake 3.15, Modules **FindPython3**, **FindPython2**
and **FindPython** set value **LOCATION** for, respectively, variables
**Python3\_FIND\_STRATEGY**, **Python2\_FIND\_STRATEGY** and
**Python\_FIND\_STRATEGY**. This policy provides compatibility with projects that
expect the legacy behavior.

The **OLD** behavior for this policy set value **VERSION** for variables
**Python3\_FIND\_STRATEGY**, **Python2\_FIND\_STRATEGY** and
**Python\_FIND\_STRATEGY**.

This policy was introduced in CMake version 3.15.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike many policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses the **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0093"></a>

### CMP0093


**FindBoost** reports **Boost\_VERSION** in **x.y.z** format.

In CMake 3.14 and below the module would report the Boost version
number as specified in the preprocessor definition **BOOST\_VERSION** in
the **boost/version.hpp** file. In CMake 3.15 and later it is preferred
that the reported version number matches the **x.y.z** format reported
by the CMake package shipped with Boost **1.70.0** and later. The macro
value is still reported in the **Boost\_VERSION\_MACRO** variable.

The **OLD** behavior for this policy is for **FindBoost** to report
**Boost\_VERSION** as specified in the preprocessor definition
**BOOST\_VERSION** in **boost/version.hpp**. The **NEW** behavior for this
policy is for **FindBoost** to report **Boost\_VERSION** in
**x.y.z** format.

This policy was introduced in CMake version 3.15.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike many policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses the **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0092"></a>

### CMP0092


MSVC warning flags are not in **CMAKE\_&lt;LANG&gt;\_FLAGS** by default.

When using MSVC-like compilers in CMake 3.14 and below, warning flags
like **/W3** are added to **CMAKE\_&lt;LANG&gt;\_FLAGS** by default.
This is problematic for projects that want to choose a different warning
level programmatically.  In particular, it requires string editing of the
**CMAKE\_&lt;LANG&gt;\_FLAGS** variables with knowledge of the
CMake builtin defaults so they can be replaced.

CMake 3.15 and above prefer to leave out warning flags from the value of
**CMAKE\_&lt;LANG&gt;\_FLAGS** by default.

This policy provides compatibility with projects that have not been updated
to expect the lack of warning flags.  The policy setting takes effect as of
the first **project()** or **enable\_language()** command that
initializes **CMAKE\_&lt;LANG&gt;\_FLAGS** for a given lanuage **&lt;LANG&gt;**.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Once the policy has taken effect at the top of a project for a given
language, that choice must be used throughout the tree for that language.
In projects that have nested projects in subdirectories, be sure to
convert everything together.
.UNINDENT
.UNINDENT

The **OLD** behavior for this policy is to place MSVC warning flags in the
default **CMAKE\_&lt;LANG&gt;\_FLAGS** cache entries.  The **NEW** behavior
for this policy is to _not_ place MSVC warning flags in the default cache
entries.

This policy was introduced in CMake version 3.15.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike many policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0091"></a>

### CMP0091


MSVC runtime library flags are selected by an abstraction.

Compilers targeting the MSVC ABI have flags to select the MSVC runtime library.
Runtime library selection typically varies with build configuration because
there is a separate runtime library for Debug builds.

In CMake 3.14 and below, MSVC runtime library selection flags are added to
the default **CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** cache entries by CMake
automatically.  This allows users to edit their cache entries to adjust the
flags.  However, the presence of such default flags is problematic for
projects that want to choose a different runtime library programmatically.
In particular, it requires string editing of the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** variables with knowledge of the
CMake builtin defaults so they can be replaced.

CMake 3.15 and above prefer to leave the MSVC runtime library selection flags
out of the default **CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** values and instead
offer a first-class abstraction.  The **CMAKE\_MSVC\_RUNTIME\_LIBRARY**
variable and **MSVC\_RUNTIME\_LIBRARY** target property may be set to
select the MSVC runtime library.  If they are not set then CMake uses the
default value **MultiThreaded$&lt;$&lt;CONFIG:Debug&gt;:Debug&gt;DLL** which is
equivalent to the original flags.

This policy provides compatibility with projects that have not been updated
to be aware of the abstraction.  The policy setting takes effect as of the
first **project()** or **enable\_language()** command that enables
a language whose compiler targets the MSVC ABI.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Once the policy has taken effect at the top of a project, that choice
must be used throughout the tree.  In projects that have nested projects
in subdirectories, be sure to convert everything together.
.UNINDENT
.UNINDENT

The **OLD** behavior for this policy is to place MSVC runtime library
flags in the default **CMAKE\_&lt;LANG&gt;\_FLAGS\_&lt;CONFIG&gt;** cache
entries and ignore the **CMAKE\_MSVC\_RUNTIME\_LIBRARY** abstraction.
The **NEW** behavior for this policy is to _not_ place MSVC runtime
library flags in the default cache entries and use the abstraction instead.

This policy was introduced in CMake version 3.15.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike many policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0090"></a>

### CMP0090


**export(PACKAGE)** does not populate package registry by default.

In CMake 3.14 and below the **export(PACKAGE)** command populated the
user package registry by default and users needed to set the
**CMAKE\_EXPORT\_NO\_PACKAGE\_REGISTRY** to disable it, e.g. in automated
build and packaging environments.  Since the user package registry is stored
outside the build tree, this side effect should not be enabled by default.
Therefore CMake 3.15 and above prefer that **export(PACKAGE)** does
nothing unless an explicit **CMAKE\_EXPORT\_PACKAGE\_REGISTRY** variable
is set to enable it.  This policy provides compatibility with projects that
have not been updated.

The **OLD** behavior for this policy is for **export(PACKAGE)** command
to populate the user package registry unless
**CMAKE\_EXPORT\_NO\_PACKAGE\_REGISTRY** is enabled.
The **NEW** behavior is for **export(PACKAGE)** command to do nothing
unless the **CMAKE\_EXPORT\_PACKAGE\_REGISTRY** is enabled.

This policy was introduced in CMake version 3.15.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike most policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0089"></a>

### CMP0089


Compiler id for IBM Clang-based XL compilers is now **XLClang**.

CMake 3.15 and above recognize that IBM’s Clang-based XL compilers
that define **\_\_ibmxl\_\_** are a new front-end distinct from **xlc**
with a different command line and set of capabilities.
CMake now prefers to present this to projects by setting the
**CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable to **XLClang** instead
of **XL**.  However, existing projects may assume the compiler id for
Clang-based XL is just **XL** as it was in CMake versions prior to 3.15.
Therefore this policy determines for Clang-based XL compilers which
compiler id to report in the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID**
variable after language **&lt;LANG&gt;** is enabled by the **project()**
or **enable\_language()** command.  The policy must be set prior
to the invocation of either command.

The **OLD** behavior for this policy is to use compiler id **XL**.  The
**NEW** behavior for this policy is to use compiler id **XLClang**.

This policy was introduced in CMake version 3.15.  Use the
**cmake\_policy()** command to set this policy to **OLD** or **NEW** explicitly.
Unlike most policies, CMake version 3.17.2 does _not_ warn
by default when this policy is not set and simply uses **OLD** behavior.
See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0089**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-314"></a>

# Policies Introduced by Cmake 3.14


<a name="cmp0088"></a>

### CMP0088


**FindBISON** runs bison in **CMAKE\_CURRENT\_BINARY\_DIR**
when executing.

The module provides a **BISON\_TARGET** macro which generates BISON output.
In CMake 3.13 and below the macro would generate a custom command that runs
**bison** in the source directory.  CMake 3.14 and later prefer to run it
in the build directory and use **CMAKE\_CURRENT\_BINARY\_DIR** as the
**WORKING\_DIRECTORY** of its **add\_custom\_command()** invocation.
This ensures that any implicitly generated file is written to the build
tree rather than the source.

This policy provides compatibility for projects that have not been updated
to expect the new behavior.

The **OLD** behavior for this policy is for **BISON\_TARGET** to use
the current source directory for the **WORKING\_DIRECTORY** and where
to generate implicit files. The **NEW** behavior of this policy is to
use the current binary directory for the **WORKING\_DIRECTORY** and where
to generate implicit files.

This policy was introduced in CMake version 3.14.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike most policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0087"></a>

### CMP0087


**install(CODE)** and **install(SCRIPT)** support generator
expressions.

In CMake 3.13 and earlier, **install(CODE)** and
**install(SCRIPT)** did not evaluate generator expressions.  CMake 3.14
and later will evaluate generator expressions for **install(CODE)** and
**install(SCRIPT)**.

The **OLD** behavior of this policy is for **install(CODE)** and
**install(SCRIPT)** to not evaluate generator expressions.  The **NEW**
behavior is to evaluate generator expressions for **install(CODE)** and
**install(SCRIPT)**.

Note that it is the value of this policy setting at the end of the directory
scope that is important, not its setting at the time of the call to
**install(CODE)** or **install(SCRIPT)**.  This has implications
for calling these commands from places that have their own policy scope but not
their own directory scope (e.g. from files brought in via **include()**
rather than **add\_subdirectory()**).

This policy was introduced in CMake version 3.14.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0086"></a>

### CMP0086


**UseSWIG** honors **SWIG\_MODULE\_NAME** via **-module** flag.

Starting with CMake 3.14, **UseSWIG** passes option
**-module &lt;module\_name&gt;** to **SWIG** compiler if the file property
**SWIG\_MODULE\_NAME** is specified. This policy provides compatibility with
projects that expect the legacy behavior.

The **OLD** behavior for this policy is to never pass **-module** option.
The **NEW** behavior is to pass **-module** option to **SWIG** compiler if
**SWIG\_MODULE\_NAME** is specified.

This policy was introduced in CMake version 3.14.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0085"></a>

### CMP0085


**$&lt;IN\_LIST:...&gt;** handles empty list items.

In CMake 3.13 and lower, the **$&lt;IN\_LIST:...&gt;** generator expression always
returned **0** if the first argument was empty, even if the list contained an
empty item. This behavior is inconsistent with the **IN\_LIST** behavior of
**if()**, which this generator expression is meant to emulate. CMake 3.14
and later handles this case correctly.

The **OLD** behavior of this policy is for **$&lt;IN\_LIST:...&gt;** to always return
**0** if the first argument is empty. The **NEW** behavior is to return **1**
if the first argument is empty and the list contains an empty item.

This policy was introduced in CMake version 3.14.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0084"></a>

### CMP0084


The **FindQt** module does not exist for **find\_package()**.

The existence of **FindQt** means that for Qt upstream to provide
package config files that can be found by **find\_package(Qt)**, the consuming
project has to explicitly specify **find_package(Qt CONFIG)**. Removing this
module gives Qt a path forward for exporting its own config files which can
easily be found by consuming projects.

This policy pretends that CMake’s internal **FindQt** module does not
exist for **find\_package()**. If a project really wants to use Qt 3 or 4,
it can call **find\_package(Qt[34])**, **include(FindQt)**, or add
**FindQt** to their **CMAKE\_MODULE\_PATH**.

The **OLD** behavior of this policy is for **FindQt** to exist for
**find\_package()**. The **NEW** behavior is to pretend that it doesn’t
exist for **find\_package()**.

This policy was introduced in CMake version 3.14.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0083"></a>

### CMP0083


To control generation of Position Independent Executable (**PIE**) or not, some
flags are required at link time.

CMake 3.13 and lower did not add these link flags when
**POSITION\_INDEPENDENT\_CODE** is set.

The **OLD** behavior for this policy is to not manage **PIE** link flags. The
**NEW** behavior is to add link flags if **POSITION\_INDEPENDENT\_CODE**
is set:
.INDENT 0.0

* ·  
  Set to **TRUE**: flags to produce a position independent executable are
  passed to the linker step. For example **-pie** for **GCC**.
* ·  
  Set to **FALSE**: flags not to produce a position independent executable are
  passed to the linker step. For example **-no-pie** for **GCC**.
* ·  
  Not set: no flags are passed to the linker step.
  .UNINDENT

Since a given linker may not support **PIE** flags in all environments in
which it is used, it is the project’s responsibility to use the
**CheckPIESupported** module to check for support to ensure that the
**POSITION\_INDEPENDENT\_CODE** target property for executables will be
honored at link time.

This policy was introduced in CMake version 3.14. Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike most policies, CMake version 3.17.2 does not warn when this policy is
not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
Android platform has a special handling of **PIE** so it is not required
to use the **CheckPIESupported** module to ensure flags are passed to
the linker.
.UNINDENT
.UNINDENT

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="examples"></a>

### Examples


Behave like CMake 3.13 and do not apply any **PIE** flags at link stage.
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.13)
    project(foo)
    
    # ...
    
    add_executable(foo ...)
    set_property(TARGET foo PROPERTY POSITION_INDEPENDENT_CODE TRUE)
    .ft P
.UNINDENT
.UNINDENT

Use the **CheckPIESupported** module to detect whether **PIE** is
supported by the current linker and environment.  Apply **PIE** flags only
if the linker supports them.
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.14) # CMP0083 NEW
    project(foo)
    
    include(CheckPIESupported)
    check_pie_supported()
    
    # ...
    
    add_executable(foo ...)
    set_property(TARGET foo PROPERTY POSITION_INDEPENDENT_CODE TRUE)
    .ft P
.UNINDENT
.UNINDENT

<a name="cmp0082"></a>

### CMP0082


Install rules from **add\_subdirectory()** calls are interleaved with
those in caller.

CMake 3.13 and lower ran the install rules from **add\_subdirectory()**
after all other install rules, even if **add\_subdirectory()** was called
before the other install rules.  CMake 3.14 and above prefer to interleave
these **add\_subdirectory()** install rules with the others so that
they are run in the order they are declared.  This policy provides
compatibility for projects that have not been updated to expect the
new behavior.

The **OLD** behavior for this policy is to run the install rules from
**add\_subdirectory()** after the other install rules.  The **NEW**
behavior for this policy is to run all install rules in the order they are
declared.

This policy was introduced in CMake version 3.14.  Unlike most policies,
CMake version 3.17.2 does _not_ warn by default when this policy
is not set and simply uses **OLD** behavior.  See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0082**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-313"></a>

# Policies Introduced by Cmake 3.13


<a name="cmp0081"></a>

### CMP0081


Relative paths not allowed in **LINK\_DIRECTORIES** target property.

CMake 3.12 and lower allowed the **LINK\_DIRECTORIES** directory
property to contain relative paths.  The base path for such relative
entries is not well defined.  CMake 3.13 and later will issue a
**FATAL\_ERROR** if the **LINK\_DIRECTORIES** target property
(which is initialized by the **LINK\_DIRECTORIES** directory property)
contains a relative path.

The **OLD** behavior for this policy is not to warn about relative paths
in the **LINK\_DIRECTORIES** target property.  The **NEW** behavior for
this policy is to issue a **FATAL\_ERROR** if **LINK\_DIRECTORIES**
contains a relative path.

This policy was introduced in CMake version 3.13.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0080"></a>

### CMP0080


**BundleUtilities** cannot be included at configure time.

The macros provided by **BundleUtilities** are intended to be invoked
at install time rather than at configure time, because they depend on the
listed targets already existing at the time they are invoked. If they are
invoked at configure time, the targets haven’t been built yet, and the
commands will fail.

This policy restricts the inclusion of **BundleUtilities** to
**cmake -P** style scripts and install rules. Specifically, it looks for the
presence of **CMAKE\_GENERATOR** and throws a fatal error if it exists.

The **OLD** behavior of this policy is to allow **BundleUtilities** to
be included at configure time. The **NEW** behavior of this policy is to
disallow such inclusion.

This policy was introduced in CMake version 3.13.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0079"></a>

### CMP0079


**target\_link\_libraries()** allows use with targets in other directories.

Prior to CMake 3.13 the **target\_link\_libraries()** command did not
accept targets not created in the calling directory as its first argument
for calls that update the **LINK\_LIBRARIES** of the target itself.
It did accidentally accept targets from other directories on calls that
only update the **INTERFACE\_LINK\_LIBRARIES**, but would simply
add entries to the property as if the call were made in the original
directory.  Thus link interface libraries specified this way were always
looked up by generators in the scope of the original target rather than
in the scope that called **target\_link\_libraries()**.

CMake 3.13 now allows the **target\_link\_libraries()** command to
be called from any directory to add link dependencies and link interface
libraries to targets created in other directories.  The entries are added
to **LINK\_LIBRARIES** and **INTERFACE\_LINK\_LIBRARIES**
using a special (internal) suffix to tell the generators to look up the
names in the calling scope rather than the scope that created the target.

This policy provides compatibility with projects that already use
**target\_link\_libraries()** with the **INTERFACE** keyword
on a target in another directory to add **INTERFACE\_LINK\_LIBRARIES**
entries to be looked up in the target’s directory.  Such projects should
be updated to be aware of the new scoping rules in that case.

The **OLD** behavior of this policy is to disallow
**target\_link\_libraries()** calls naming targets from another directory
except in the previously accidentally allowed case of using the **INTERFACE**
keyword only.  The **NEW** behavior of this policy is to allow all such
calls but use the new scoping rules.

This policy was introduced in CMake version 3.13.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0078"></a>

### CMP0078


**UseSWIG** generates standard target names.

Starting with CMake 3.13, **UseSWIG** generates now standard target
names. This policy provides compatibility with projects that expect the legacy
behavior.

The **OLD** behavior for this policy relies on
**UseSWIG\_TARGET\_NAME\_PREFERENCE** variable that can be used to specify an
explicit preference.  The value may be one of:
.INDENT 0.0

* ·  
  **LEGACY**: legacy strategy is applied. Variable
  **SWIG\_MODULE\_&lt;name&gt;\_REAL\_NAME** must be used to get real target name.
  This is the default if not specified.
* ·  
  **STANDARD**: target name matches specified name.
  .UNINDENT

This policy was introduced in CMake version 3.13.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0077"></a>

### CMP0077


**option()** honors normal variables.

The **option()** command is typically used to create a cache entry
to allow users to set the option.  However, there are cases in which a
normal (non-cached) variable of the same name as the option may be
defined by the project prior to calling the **option()** command.
For example, a project that embeds another project as a subdirectory
may want to hard-code options of the subproject to build the way it needs.

For historical reasons in CMake 3.12 and below the **option()**
command _removes_ a normal (non-cached) variable of the same name when:
.INDENT 0.0

* ·  
  a cache entry of the specified name does not exist at all, or
* ·  
  a cache entry of the specified name exists but has not been given
  a type (e.g. via **-D&lt;name&gt;=ON** on the command line).
  .UNINDENT

In both of these cases (typically on the first run in a new build tree),
the **option()** command gives the cache entry type **BOOL** and
removes any normal (non-cached) variable of the same name.  In the
remaining case that the cache entry of the specified name already
exists and has a type (typically on later runs in a build tree), the
**option()** command changes nothing and any normal variable of
the same name remains set.

In CMake 3.13 and above the **option()** command prefers to
do nothing when a normal variable of the given name already exists.
It does not create or update a cache entry or remove the normal variable.
The new behavior is consistent between the first and later runs in a
build tree.  This policy provides compatibility with projects that have
not been updated to expect the new behavior.

When the **option()** command sees a normal variable of the given
name:
.INDENT 0.0

* ·  
  The **OLD** behavior for this policy is to proceed even when a normal
  variable of the same name exists.  If the cache entry does not already
  exist and have a type then it is created and/or given a type and the
  normal variable is removed.
* ·  
  The **NEW** behavior for this policy is to do nothing when a normal
  variable of the same name exists.  The normal variable is not removed.
  The cache entry is not created or updated and is ignored if it exists.
  .UNINDENT

This policy was introduced in CMake version 3.13.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0076"></a>

### CMP0076


The **target\_sources()** command converts relative paths to absolute.

In CMake 3.13 and above, the **target\_sources()** command now converts
relative source file paths to absolute paths in the following cases:
.INDENT 0.0

* ·  
  Source files are added to the target’s **INTERFACE\_SOURCES**
  property.
* ·  
  The target’s **SOURCE\_DIR** property differs from
  **CMAKE\_CURRENT\_SOURCE\_DIR**.
  .UNINDENT

A path that begins with a generator expression is always left unmodified.

This policy provides compatibility with projects that have not been updated
to expect this behavior.  The **OLD** behavior for this policy is to leave
all relative source file paths unmodified.  The **NEW** behavior of this
policy is to convert relative paths to absolute according to above rules.

This policy was introduced in CMake version 3.13.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-312"></a>

# Policies Introduced by Cmake 3.12


<a name="cmp0075"></a>

### CMP0075


Include file check macros honor **CMAKE\_REQUIRED\_LIBRARIES**.

In CMake 3.12 and above, the
.INDENT 0.0

* ·  
  **check\_include\_file** macro in the **CheckIncludeFile** module, the
* ·  
  **check\_include\_file\_cxx** macro in the
  **CheckIncludeFileCXX** module, and the
* ·  
  **check\_include\_files** macro in the **CheckIncludeFiles** module
  .UNINDENT

now prefer to link the check executable to the libraries listed in the
**CMAKE\_REQUIRED\_LIBRARIES** variable.  This policy provides compatibility
with projects that have not been updated to expect this behavior.

The **OLD** behavior for this policy is to ignore **CMAKE\_REQUIRED\_LIBRARIES**
in the include file check macros.  The **NEW** behavior of this policy is to
honor **CMAKE\_REQUIRED\_LIBRARIES** in the include file check macros.

This policy was introduced in CMake version 3.12.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0074"></a>

### CMP0074


**find\_package()** uses **&lt;PackageName&gt;\_ROOT** variables.

In CMake 3.12 and above the **find\_package(&lt;PackageName&gt;)** command now
searches prefixes specified by the **&lt;PackageName&gt;\_ROOT** CMake
variable and the **&lt;PackageName&gt;\_ROOT** environment variable.
Package roots are maintained as a stack so nested calls to all **find\_***
commands inside find modules and config packages also search the roots as
prefixes.  This policy provides compatibility with projects that have not been
updated to avoid using **&lt;PackageName&gt;\_ROOT** variables for other purposes.

The **OLD** behavior for this policy is to ignore **&lt;PackageName&gt;\_ROOT**
variables.  The **NEW** behavior for this policy is to use
**&lt;PackageName&gt;\_ROOT** variables.

This policy was introduced in CMake version 3.12.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0073"></a>

### CMP0073


Do not produce legacy **\_LIB\_DEPENDS** cache entries.

Ancient CMake versions once used **&lt;tgt&gt;\_LIB\_DEPENDS** cache entries to
propagate library link dependencies.  This has long been done by other
means, leaving the **export\_library\_dependencies()** command as the
only user of these values.  That command has long been disallowed by
policy **CMP0033**, but the **&lt;tgt&gt;\_LIB\_DEPENDS** cache entries
were left for compatibility with possible non-standard uses by projects.

CMake 3.12 and above now prefer to not produce these cache entries
at all.  This policy provides compatibility with projects that have
not been updated to avoid using them.

The **OLD** behavior for this policy is to set **&lt;tgt&gt;\_LIB\_DEPENDS** cache
entries.  The **NEW** behavior for this policy is to not set them.

This policy was introduced in CMake version 3.12.  Use the
**cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.
Unlike most policies, CMake version 3.17.2 does _not_ warn
when this policy is not set and simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-311"></a>

# Policies Introduced by Cmake 3.11


<a name="cmp0072"></a>

### CMP0072


**FindOpenGL** prefers GLVND by default when available.

The **FindOpenGL** module provides an **OpenGL::GL** target and an
**OPENGL\_LIBRARIES** variable for projects to use for legacy GL interfaces.
When both a legacy GL library (e.g. **libGL.so**) and GLVND libraries
for OpenGL and GLX (e.g. **libOpenGL.so** and **libGLX.so**) are available,
the module must choose between them.  It documents an **OpenGL\_GL\_PREFERENCE**
variable that can be used to specify an explicit preference.  When no such
preference is set, the module must choose a default preference.

CMake 3.11 and above prefer to choose GLVND libraries.  This policy provides
compatibility with projects that expect the legacy GL library to be used.

The **OLD** behavior for this policy is to set **OpenGL\_GL\_PREFERENCE** to
**LEGACY**.  The **NEW** behavior for this policy is to set
**OpenGL\_GL\_PREFERENCE** to **GLVND**.

This policy was introduced in CMake version 3.11.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-310"></a>

# Policies Introduced by Cmake 3.10


<a name="cmp0071"></a>

### CMP0071


Let **AUTOMOC** and **AUTOUIC** process
**GENERATED** files.

Since version 3.10, CMake processes **regular** and **GENERATED**
source files in **AUTOMOC** and **AUTOUIC**.
In earlier CMake versions, only **regular** source files were processed.
**GENERATED** source files were ignored silently.

This policy affects how source files that are **GENERATED**
get treated in **AUTOMOC** and **AUTOUIC**.

The **OLD** behavior for this policy is to ignore **GENERATED**
source files in **AUTOMOC** and **AUTOUIC**.

The **NEW** behavior for this policy is to process **GENERATED**
source files in **AUTOMOC** and **AUTOUIC** just like regular
source files.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
To silence the **CMP0071** warning source files can be excluded from
**AUTOMOC** and **AUTOUIC** processing by setting the
source file properties **SKIP\_AUTOMOC**, **SKIP\_AUTOUIC** or
**SKIP\_AUTOGEN**.
.UNINDENT
.UNINDENT

Source skip example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # ...
    set_property(SOURCE /path/to/file1.h PROPERTY SKIP_AUTOMOC ON)
    set_property(SOURCE /path/to/file2.h PROPERTY SKIP_AUTOUIC ON)
    set_property(SOURCE /path/to/file3.h PROPERTY SKIP_AUTOGEN ON)
    # ...
    .ft P
.UNINDENT
.UNINDENT

This policy was introduced in CMake version 3.10.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0070"></a>

### CMP0070


Define **file(GENERATE)** behavior for relative paths.

CMake 3.10 and newer define that relative paths given to **INPUT** and
**OUTPUT** arguments of **file(GENERATE)** are interpreted relative to the
current source and binary directories, respectively.  CMake 3.9 and lower did
not define any behavior for relative paths but did not diagnose them either
and accidentally treated them relative to the process working directory.
Policy **CMP0070** provides compatibility with projects that used the old
undefined behavior.

This policy affects behavior of relative paths given to **file(GENERATE)**.
The **OLD** behavior for this policy is to treat the paths relative to the
working directory of CMake.  The **NEW** behavior for this policy is to
interpret relative paths with respect to the current source or binary
directory of the caller.

This policy was introduced in CMake version 3.10.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-39"></a>

# Policies Introduced by Cmake 3.9


<a name="cmp0069"></a>

### CMP0069


**INTERPROCEDURAL\_OPTIMIZATION** is enforced when enabled.

CMake 3.9 and newer prefer to add IPO flags whenever the
**INTERPROCEDURAL\_OPTIMIZATION** target property is enabled and
produce an error if flags are not known to CMake for the current compiler.
Since a given compiler may not support IPO flags in all environments in which
it is used, it is now the project’s responsibility to use the
**CheckIPOSupported** module to check for support before enabling the
**INTERPROCEDURAL\_OPTIMIZATION** target property.  This approach
allows a project to conditionally activate IPO when supported.  It also
allows an end user to set the **CMAKE\_INTERPROCEDURAL\_OPTIMIZATION**
variable in an environment known to support IPO even if the project does
not enable the property.

Since CMake 3.8 and lower only honored **INTERPROCEDURAL\_OPTIMIZATION**
for the Intel compiler on Linux, some projects may unconditionally enable the
target property.  Policy **CMP0069** provides compatibility with such projects.

This policy takes effect whenever the IPO property is enabled.  The **OLD**
behavior for this policy is to add IPO flags only for Intel compiler on Linux.
The **NEW** behavior for this policy is to add IPO flags for the current
compiler or produce an error if CMake does not know the flags.

This policy was introduced in CMake version 3.9.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="examples"></a>

### Examples


Behave like CMake 3.8 and do not apply any IPO flags except for Intel compiler
on Linux:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.8)
    project(foo)
    
    # ...
    
    set_property(TARGET ... PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
    .ft P
.UNINDENT
.UNINDENT

Use the **CheckIPOSupported** module to detect whether IPO is
supported by the current compiler, environment, and CMake version.
Produce a fatal error if support is not available:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.9) # CMP0069 NEW
    project(foo)
    
    include(CheckIPOSupported)
    check_ipo_supported()
    
    # ...
    
    set_property(TARGET ... PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
    .ft P
.UNINDENT
.UNINDENT

Apply IPO flags only if compiler supports it:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.9) # CMP0069 NEW
    project(foo)
    
    include(CheckIPOSupported)
    
    # ...
    
    check_ipo_supported(RESULT result)
    if(result)
      set_property(TARGET ... PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
    endif()
    .ft P
.UNINDENT
.UNINDENT

Apply IPO flags without any checks.  This may lead to build errors if IPO
is not supported by the compiler in the current environment.  Produce an
error if CMake does not know IPO flags for the current compiler:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION 3.9) # CMP0069 NEW
    project(foo)
    
    # ...
    
    set_property(TARGET ... PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
    .ft P
.UNINDENT
.UNINDENT

<a name="cmp0068"></a>

### CMP0068


**RPATH** settings on macOS do not affect **install\_name**.

CMake 3.9 and newer remove any effect the following settings may have on the
**install\_name** of a target on macOS:
.INDENT 0.0

* ·  
  **BUILD\_WITH\_INSTALL\_RPATH** target property
* ·  
  **SKIP\_BUILD\_RPATH** target property
* ·  
  **CMAKE\_SKIP\_RPATH** variable
* ·  
  **CMAKE\_SKIP\_INSTALL\_RPATH** variable
  .UNINDENT

Previously, setting **BUILD\_WITH\_INSTALL\_RPATH** had the effect of
setting both the **install\_name** of a target to **INSTALL\_NAME\_DIR**
and the **RPATH** to **INSTALL\_RPATH**.  In CMake 3.9, it only affects
setting of **RPATH**.  However, if one wants **INSTALL\_NAME\_DIR** to
apply to the target in the build tree, one may set
**BUILD\_WITH\_INSTALL\_NAME\_DIR**.

If **SKIP\_BUILD\_RPATH**, **CMAKE\_SKIP\_RPATH** or
**CMAKE\_SKIP\_INSTALL\_RPATH** were used to strip the directory portion
of the **install\_name** of a target, one may set **INSTALL\_NAME\_DIR=""**
instead.

The **OLD** behavior of this policy is to use the **RPATH** settings for
**install\_name** on macOS.  The **NEW** behavior of this policy is to ignore
the **RPATH** settings for **install\_name** on macOS.

This policy was introduced in CMake version 3.9.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-38"></a>

# Policies Introduced by Cmake 3.8


<a name="cmp0067"></a>

### CMP0067


Honor language standard in **try\_compile()** source-file signature.

The **try\_compile()** source file signature is intended to allow
callers to check whether they will be able to compile a given source file
with the current toolchain.  In order to match compiler behavior, any
language standard mode should match.  However, CMake 3.7 and below did not
do this.  CMake 3.8 and above prefer to honor the language standard settings
for **C**, **CXX** (C++), and **CUDA** using the values of the variables:
.INDENT 0.0

* ·  
  **CMAKE\_C\_STANDARD**
* ·  
  **CMAKE\_C\_STANDARD\_REQUIRED**
* ·  
  **CMAKE\_C\_EXTENSIONS**
* ·  
  **CMAKE\_CXX\_STANDARD**
* ·  
  **CMAKE\_CXX\_STANDARD\_REQUIRED**
* ·  
  **CMAKE\_CXX\_EXTENSIONS**
* ·  
  **CMAKE\_CUDA\_STANDARD**
* ·  
  **CMAKE\_CUDA\_STANDARD\_REQUIRED**
* ·  
  **CMAKE\_CUDA\_EXTENSIONS**
  .UNINDENT

This policy provides compatibility for projects that do not expect
the language standard settings to be used automatically.

The **OLD** behavior of this policy is to ignore language standard
setting variables when generating the **try\_compile** test project.
The **NEW** behavior of this policy is to honor language standard
setting variables.

This policy was introduced in CMake version 3.8.  Unlike most policies,
CMake version 3.17.2 does _not_ warn by default when this policy
is not set and simply uses **OLD** behavior.  See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0067**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-37"></a>

# Policies Introduced by Cmake 3.7


<a name="cmp0066"></a>

### CMP0066


Honor per-config flags in **try\_compile()** source-file signature.

The source file signature of the **try\_compile()** command uses the value
of the **CMAKE\_&lt;LANG&gt;\_FLAGS** variable in the test project so that the
test compilation works as it would in the main project.  However, CMake 3.6 and
below do not also honor config-specific compiler flags such as those in the
**CMAKE\_&lt;LANG&gt;\_FLAGS\_DEBUG** variable.  CMake 3.7 and above prefer to
honor config-specific compiler flags too.  This policy provides compatibility
for projects that do not expect config-specific compiler flags to be used.

The **OLD** behavior of this policy is to ignore config-specific flag
variables like **CMAKE\_&lt;LANG&gt;\_FLAGS\_DEBUG** and only use CMake’s
built-in defaults for the current compiler and platform.

The **NEW** behavior of this policy is to honor config-specific flag
variabldes like **CMAKE\_&lt;LANG&gt;\_FLAGS\_DEBUG**.

This policy was introduced in CMake version 3.7.  Unlike most policies,
CMake version 3.17.2 does _not_ warn by default when this policy
is not set and simply uses **OLD** behavior.  See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0066**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-34"></a>

# Policies Introduced by Cmake 3.4


<a name="cmp0065"></a>

### CMP0065


Do not add flags to export symbols from executables without
the **ENABLE\_EXPORTS** target property.

CMake 3.3 and below, for historical reasons, always linked executables
on some platforms with flags like **-rdynamic** to export symbols from
the executables for use by any plugins they may load via **dlopen**.
CMake 3.4 and above prefer to do this only for executables that are
explicitly marked with the **ENABLE\_EXPORTS** target property.

The **OLD** behavior of this policy is to always use the additional link
flags when linking executables regardless of the value of the
**ENABLE\_EXPORTS** target property.

The **NEW** behavior of this policy is to only use the additional link
flags when linking executables if the **ENABLE\_EXPORTS** target
property is set to **True**.

This policy was introduced in CMake version 3.4.  Unlike most policies,
CMake version 3.17.2 does _not_ warn by default when this policy
is not set and simply uses **OLD** behavior.  See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0065**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0064"></a>

### CMP0064


Recognize **TEST** as a operator for the **if()** command.

The **TEST** operator was added to the **if()** command to determine if a
given test name was created by the **add\_test()** command.

The **OLD** behavior for this policy is to ignore the **TEST** operator.
The **NEW** behavior is to interpret the **TEST** operator.

This policy was introduced in CMake version 3.4.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-33"></a>

# Policies Introduced by Cmake 3.3


<a name="cmp0063"></a>

### CMP0063


Honor visibility properties for all target types.

The **&lt;LANG&gt;\_VISIBILITY\_PRESET** and
**VISIBILITY\_INLINES\_HIDDEN** target properties affect visibility
of symbols during dynamic linking.  When first introduced these properties
affected compilation of sources only in shared libraries, module libraries,
and executables with the **ENABLE\_EXPORTS** property set.  This
was sufficient for the basic use cases of shared libraries and executables
with plugins.  However, some sources may be compiled as part of static
libraries or object libraries and then linked into a shared library later.
CMake 3.3 and above prefer to honor these properties for sources compiled
in all target types.  This policy preserves compatibility for projects
expecting the properties to work only for some target types.

The **OLD** behavior for this policy is to ignore the visibility properties
for static libraries, object libraries, and executables without exports.
The **NEW** behavior for this policy is to honor the visibility properties
for all target types.

This policy was introduced in CMake version 3.3.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0062"></a>

### CMP0062


Disallow **install()** of **export()** result.

The **export()** command generates a file containing
Imported Targets, which is suitable for use from the build
directory.  It is not suitable for installation because it contains absolute
paths to buildsystem locations, and is particular to a single build
configuration.

The **install(EXPORT)** generates and installs files which contain
Imported Targets.  These files are generated with relative paths
(unless the user specifies absolute paths), and are designed for
multi-configuration use.  See Creating Packages for more.

CMake 3.3 no longer allows the use of the **install(FILES)** command
with the result of the **export()** command.

The **OLD** behavior for this policy is to allow installing the result of
an **export()** command.  The **NEW** behavior for this policy is
not to allow installing the result of an **export()** command.

This policy was introduced in CMake version 3.3.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0061"></a>

### CMP0061


CTest does not by default tell **make** to ignore errors (**-i**).

The **ctest\_build()** and **build\_command()** commands no
longer generate build commands for Makefile Generators with
the **-i** option.  Previously this was done to help build as much
of tested projects as possible.  However, this behavior is not
consistent with other generators and also causes the return code
of the **make** tool to be meaningless.

Of course users may still add this option manually by setting
**CTEST\_BUILD\_COMMAND** or the **MAKECOMMAND** cache entry.
See the CTest Build Step **MakeCommand** setting documentation
for their effects.

The **OLD** behavior for this policy is to add **-i** to **make**
calls in CTest.  The **NEW** behavior for this policy is to not
add **-i**.

This policy was introduced in CMake version 3.3.  Unlike most policies,
CMake version 3.17.2 does _not_ warn when this policy is not set and
simply uses **OLD** behavior.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0060"></a>

### CMP0060


Link libraries by full path even in implicit directories.

Policy **CMP0003** was introduced with the intention of always
linking library files by full path when a full path is given to the
**target\_link\_libraries()** command.  However, on some platforms
(e.g. HP-UX) the compiler front-end adds alternative library search paths
for the current architecture (e.g. **/usr/lib/&lt;arch&gt;** has alternatives
to libraries in **/usr/lib** for the current architecture).
On such platforms the **find\_library()** may find a library such as
**/usr/lib/libfoo.so** that does not belong to the current architecture.

Prior to policy **CMP0003** projects would still build in such
cases because the incorrect library path would be converted to **-lfoo**
on the link line and the linker would find the proper library in the
arch-specific search path provided by the compiler front-end implicitly.
At the time we chose to remain compatible with such projects by always
converting library files found in implicit link directories to **-lfoo**
flags to ask the linker to search for them.  This approach allowed existing
projects to continue to build while still linking to libraries outside
implicit link directories via full path (such as those in the build tree).

CMake does allow projects to override this behavior by using an
IMPORTED library target with its
**IMPORTED\_LOCATION** property set to the desired full path to
a library file.  In fact, many Find Modules are learning to provide
Imported Targets instead of just the traditional **Foo\_LIBRARIES**
variable listing library files.  However, this makes the link line
generated for a library found by a Find Module depend on whether it
is linked through an imported target or not, which is inconsistent.
Furthermore, this behavior has been a source of confusion because the
generated link line for a library file depends on its location.  It is
also problematic for projects trying to link statically because flags
like **-Wl,-Bstatic -lfoo -Wl,-Bdynamic** may be used to help the linker
select **libfoo.a** instead of **libfoo.so** but then leak dynamic linking
to following libraries.  (See the **LINK\_SEARCH\_END\_STATIC**
target property for a solution typically used for that problem.)

When the special case for libraries in implicit link directories was first
introduced the list of implicit link directories was simply hard-coded
(e.g. **/lib**, **/usr/lib**, and a few others).  Since that time, CMake
has learned to detect the implicit link directories used by the compiler
front-end.  If necessary, the **find\_library()** command could be
taught to use this information to help find libraries of the proper
architecture.

For these reasons, CMake 3.3 and above prefer to drop the special case
and link libraries by full path even when they are in implicit link
directories.  Policy **CMP0060** provides compatibility for existing
projects.

The **OLD** behavior for this policy is to ask the linker to search for
libraries whose full paths are known to be in implicit link directories.
The **NEW** behavior for this policy is to link libraries by full path even
if they are in implicit link directories.

This policy was introduced in CMake version 3.3.  Unlike most policies,
CMake version 3.17.2 does _not_ warn by default when this policy
is not set and simply uses **OLD** behavior.  See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0060**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0059"></a>

### CMP0059


Do not treat **DEFINITIONS** as a built-in directory property.

CMake 3.3 and above no longer make a list of definitions available through
the **DEFINITIONS** directory property.  The
**COMPILE\_DEFINITIONS** directory property may be used instead.

The **OLD** behavior for this policy is to provide the list of flags given
so far to the **add\_definitions()** command.  The **NEW** behavior is
to behave as a normal user-defined directory property.

This policy was introduced in CMake version 3.3.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set
it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0058"></a>

### CMP0058


Ninja requires custom command byproducts to be explicit.

When an intermediate file generated during the build is consumed
by an expensive operation or a large tree of dependents, one may
reduce the work needed for an incremental rebuild by updating the
file timestamp only when its content changes.  With this approach
the generation rule must have a separate output file that is always
updated with a new timestamp that is newer than any dependencies of
the rule so that the build tool re-runs the rule only when the input
changes.  We refer to the separate output file as a rule’s _witness_
and the generated file as a rule’s _byproduct_.

Byproducts may not be listed as outputs because their timestamps are
allowed to be older than the inputs.  No build tools (like **make**)
that existed when CMake was designed have a way to express byproducts.
Therefore CMake versions prior to 3.2 had no way to specify them.
Projects typically left byproducts undeclared in the rules that
generate them.  For example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_custom_command(
      OUTPUT witness.txt
      COMMAND ${CMAKE_COMMAND} -E copy_if_different
              ${CMAKE_CURRENT_SOURCE_DIR}/input.txt
              byproduct.txt # timestamp may not change
      COMMAND ${CMAKE_COMMAND} -E touch witness.txt
      DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/input.txt
      )
    add_custom_target(Provider DEPENDS witness.txt)
    add_custom_command(
      OUTPUT generated.c
      COMMAND expensive-task -i byproduct.txt -o generated.c
      DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/byproduct.txt
      )
    add_library(Consumer generated.c)
    add_dependencies(Consumer Provider)
    .ft P
.UNINDENT
.UNINDENT

This works well for all generators except **Ninja**.
The Ninja build tool sees a rule listing **byproduct.txt**
as a dependency and no rule listing it as an output.  Ninja then
complains that there is no way to satisfy the dependency and
stops building even though there are order-only dependencies
that ensure **byproduct.txt** will exist before its consumers
need it.  See discussion of this problem in _Ninja Issue 760_
for further details on why Ninja works this way.

Instead of leaving byproducts undeclared in the rules that generate
them, Ninja expects byproducts to be listed along with other outputs.
Such rules may be marked with a **restat** option that tells Ninja
to check the timestamps of outputs after the rules run.  This
prevents byproducts whose timestamps do not change from causing
their dependents to re-build unnecessarily.

Since the above approach does not tell CMake what custom command
generates **byproduct.txt**, the Ninja generator does not have
enough information to add the byproduct as an output of any rule.
CMake 2.8.12 and above work around this problem and allow projects
using the above approach to build by generating **phony** build
rules to tell Ninja to tolerate such missing files.  However, this
workaround prevents Ninja from diagnosing a dependency that is
really missing.  It also works poorly in in-source builds where
every custom command dependency, even on source files, needs to
be treated this way because CMake does not have enough information
to know which files are generated as byproducts of custom commands.

CMake 3.2 introduced the **BYPRODUCTS** option to the
**add\_custom\_command()** and **add\_custom\_target()**
commands.  This option allows byproducts to be specified explicitly:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_custom_command(
      OUTPUT witness.txt
      BYPRODUCTS byproduct.txt # explicit byproduct specification
      COMMAND ${CMAKE_COMMAND} -E copy_if_different
              ${CMAKE_CURRENT_SOURCE_DIR}/input.txt
              byproduct.txt # timestamp may not change
    ...
    .ft P
.UNINDENT
.UNINDENT

The **BYPRODUCTS** option is used by the **Ninja** generator
to list byproducts among the outputs of the custom commands that
generate them, and is ignored by other generators.

CMake 3.3 and above prefer to require projects to specify custom
command byproducts explicitly so that it can avoid using the
**phony** rule workaround altogether.  Policy **CMP0058** was
introduced to provide compatibility with existing projects that
still need the workaround.

This policy has no effect on generators other than **Ninja**.
The **OLD** behavior for this policy is to generate Ninja **phony**
rules for unknown dependencies in the build tree.  The **NEW**
behavior for this policy is to not generate these and instead
require projects to specify custom command **BYPRODUCTS** explicitly.

This policy was introduced in CMake version 3.3.
CMake version 3.17.2 warns when it sees unknown dependencies in
out-of-source build trees if the policy is not set and then uses
**OLD** behavior.  Use the **cmake\_policy()** command to set
the policy to **OLD** or **NEW** explicitly.  The policy setting
must be in scope at the end of the top-level **CMakeLists.txt**
file of the project and has global effect.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0057"></a>

### CMP0057


Support new **if()** IN_LIST operator.

CMake 3.3 adds support for the new IN_LIST operator.

The **OLD** behavior for this policy is to ignore the IN_LIST operator.
The **NEW** behavior is to interpret the IN_LIST operator.

This policy was introduced in CMake version 3.3.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set
it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-32"></a>

# Policies Introduced by Cmake 3.2


<a name="cmp0056"></a>

### CMP0056


Honor link flags in **try\_compile()** source-file signature.

The **try\_compile()** command source-file signature generates a
**CMakeLists.txt** file to build the source file into an executable.
In order to compile the source the same way as it might be compiled
by the calling project, the generated project sets the value of the
**CMAKE\_&lt;LANG&gt;\_FLAGS** variable to that in the calling project.
The value of the **CMAKE\_EXE\_LINKER\_FLAGS** variable may be
needed in some cases too, but CMake 3.1 and lower did not set it in
the generated project.  CMake 3.2 and above prefer to set it so that
linker flags are honored as well as compiler flags.  This policy
provides compatibility with the pre-3.2 behavior.

The **OLD** behavior for this policy is to not set the value of the
**CMAKE\_EXE\_LINKER\_FLAGS** variable in the generated test
project.  The **NEW** behavior for this policy is to set the value of
the **CMAKE\_EXE\_LINKER\_FLAGS** variable in the test project
to the same as it is in the calling project.

If the project code does not set the policy explicitly, users may
set it on the command line by defining the
**CMAKE\_POLICY\_DEFAULT\_CMP0056**
variable in the cache.

This policy was introduced in CMake version 3.2.  Unlike most policies,
CMake version 3.17.2 does _not_ warn by default when this policy
is not set and simply uses **OLD** behavior.  See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0056**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0055"></a>

### CMP0055


Strict checking for the **break()** command.

CMake 3.1 and lower allowed calls to the **break()** command
outside of a loop context and also ignored any given arguments.
This was undefined behavior.

The **OLD** behavior for this policy is to allow **break()** to be placed
outside of loop contexts and ignores any arguments.  The **NEW** behavior for this
policy is to issue an error if a misplaced break or any arguments are found.

This policy was introduced in CMake version 3.2.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-31"></a>

# Policies Introduced by Cmake 3.1


<a name="cmp0054"></a>

### CMP0054


Only interpret **if()** arguments as variables or keywords when unquoted.

CMake 3.1 and above no longer implicitly dereference variables or
interpret keywords in an **if()** command argument when
it is a Quoted Argument or a Bracket Argument.

The **OLD** behavior for this policy is to dereference variables and
interpret keywords even if they are quoted or bracketed.
The **NEW** behavior is to not dereference variables or interpret keywords
that have been quoted or bracketed.

Given the following partial example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(A E)
    set(E "")
    
    if("${A}" STREQUAL "")
      message("Result is TRUE before CMake 3.1 or when CMP0054 is OLD")
    else()
      message("Result is FALSE in CMake 3.1 and above if CMP0054 is NEW")
    endif()
    .ft P
.UNINDENT
.UNINDENT

After explicit expansion of variables this gives:
.INDENT 0.0
.INDENT 3.5

    .ft C
    if("E" STREQUAL "")
    .ft P
.UNINDENT
.UNINDENT

With the policy set to **OLD** implicit expansion reduces this semantically to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    if("" STREQUAL "")
    .ft P
.UNINDENT
.UNINDENT

With the policy set to **NEW** the quoted arguments will not be
further dereferenced:
.INDENT 0.0
.INDENT 3.5

    .ft C
    if("E" STREQUAL "")
    .ft P
.UNINDENT
.UNINDENT

This policy was introduced in CMake version 3.1.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set
it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0053"></a>

### CMP0053


Simplify variable reference and escape sequence evaluation.

CMake 3.1 introduced a much faster implementation of evaluation of the
Variable References and Escape Sequences documented in the
**cmake-language(7)** manual.  While the behavior is identical
to the legacy implementation in most cases, some corner cases were
cleaned up to simplify the behavior.  Specifically:
.INDENT 0.0

* ·  
  Expansion of **@VAR@** reference syntax defined by the
  **configure\_file()** and **string(CONFIGURE)**
  commands is no longer performed in other contexts.
* ·  
  Literal **${VAR}** reference syntax may contain only
  alphanumeric characters (**A-Z**, **a-z**, **0-9**) and
  the characters **\_**, **.**, **/**, **-**, and **+**.
  Note that **$** is technically allowed in the **NEW** behavior, but is
  invalid for **OLD** behavior.  This is due to an oversight during the
  implementation of _CMP0053_ and its use as a literal variable
  reference is discouraged for this reason.
  Variables with other characters in their name may still
  be referenced indirectly, e.g.
  .INDENT 2.0
  .INDENT 3.5

    .ft C
    set(varname "otherwise & disallowed $ characters")
    message("${${varname}}")
    .ft P
.UNINDENT
.UNINDENT

* ·  
  The setting of policy **CMP0010** is not considered,
  so improper variable reference syntax is always an error.
* ·  
  More characters are allowed to be escaped in variable names.
  Previously, only **()#" \e@^** were valid characters to
  escape. Now any non-alphanumeric, non-semicolon, non-NUL
  character may be escaped following the **escape\_identity**
  production in the Escape Sequences section of the
  **cmake-language(7)** manual.
  .UNINDENT

The **OLD** behavior for this policy is to honor the legacy behavior for
variable references and escape sequences.  The **NEW** behavior is to
use the simpler variable expansion and escape sequence evaluation rules.

This policy was introduced in CMake version 3.1.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set
it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0052"></a>

### CMP0052


Reject source and build dirs in installed
**INTERFACE\_INCLUDE\_DIRECTORIES**.

CMake 3.0 and lower allowed subdirectories of the source directory or build
directory to be in the **INTERFACE\_INCLUDE\_DIRECTORIES** of
installed and exported targets, if the directory was also a subdirectory of
the installation prefix.  This makes the installation depend on the
existence of the source dir or binary dir, and the installation will be
broken if either are removed after installation.

See Include Directories and Usage Requirements for more on
specifying include directories for targets.

The **OLD** behavior for this policy is to export the content of the
**INTERFACE\_INCLUDE\_DIRECTORIES** with the source or binary
directory.  The **NEW** behavior for this
policy is to issue an error if such a directory is used.

This policy was introduced in CMake version 3.1.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it
to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0051"></a>

### CMP0051


List TARGET_OBJECTS in SOURCES target property.

CMake 3.0 and lower did not include the **TARGET\_OBJECTS**
**generator expression** when
returning the **SOURCES** target property.

Configure-time CMake code is not able to handle generator expressions.  If
using the **SOURCES** target property at configure time, it may be
necessary to first remove generator expressions using the
**string(GENEX\_STRIP)** command.  Generate-time CMake code such as
**file(GENERATE)** can handle the content without stripping.

The **OLD** behavior for this policy is to omit **TARGET\_OBJECTS**
expressions from the **SOURCES** target property.  The **NEW**
behavior for this policy is to include **TARGET\_OBJECTS** expressions
in the output.

This policy was introduced in CMake version 3.1.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it
to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-30"></a>

# Policies Introduced by Cmake 3.0


<a name="cmp0050"></a>

### CMP0050


Disallow add_custom_command SOURCE signatures.

CMake 2.8.12 and lower allowed a signature for **add\_custom\_command()**
which specified an input to a command.  This was undocumented behavior.
Modern use of CMake associates custom commands with their output, rather
than their input.

The **OLD** behavior for this policy is to allow the use of
**add\_custom\_command()** SOURCE signatures.  The **NEW** behavior for this
policy is to issue an error if such a signature is used.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0049"></a>

### CMP0049


Do not expand variables in target source entries.

CMake 2.8.12 and lower performed an extra layer of variable expansion
when evaluating source file names:
.INDENT 0.0
.INDENT 3.5

    .ft C
    set(a_source foo.c)
    add_executable(foo e${a_source})
    .ft P
.UNINDENT
.UNINDENT

This was undocumented behavior.

The **OLD** behavior for this policy is to expand such variables when processing
the target sources.  The **NEW** behavior for this policy is to issue an error
if such variables need to be expanded.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set
it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0048"></a>

### CMP0048


The **project()** command manages **VERSION** variables.

CMake version 3.0 introduced the **VERSION** option of the **project()**
command to specify a project version as well as the name.  In order to keep
**PROJECT\_VERSION** and related variables consistent with variable
**PROJECT\_NAME** it is necessary to set the **VERSION** variables
to the empty string when no **VERSION** is given to **project()**.
However, this can change behavior for existing projects that set **VERSION**
variables themselves since **project()** may now clear them.
This policy controls the behavior for compatibility with such projects.

The **OLD** behavior for this policy is to leave **VERSION** variables untouched.
The **NEW** behavior for this policy is to set **VERSION** as documented by the
**project()** command.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set
it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0047"></a>

### CMP0047


Use **QCC** compiler id for the qcc drivers on QNX.

CMake 3.0 and above recognize that the QNX qcc compiler driver is
different from the GNU compiler.
CMake now prefers to present this to projects by setting the
**CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable to **QCC** instead
of **GNU**.  However, existing projects may assume the compiler id for
QNX qcc is just **GNU** as it was in CMake versions prior to 3.0.
Therefore this policy determines for QNX qcc which compiler id to
report in the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable after
language **&lt;LANG&gt;** is enabled by the **project()** or
**enable\_language()** command.  The policy must be set prior
to the invocation of either command.

The **OLD** behavior for this policy is to use the **GNU** compiler id
for the qcc and QCC compiler drivers. The **NEW** behavior for this policy
is to use the **QCC** compiler id for those drivers.

This policy was introduced in CMake version 3.0.  Use the
**cmake\_policy()** command to set this policy to **OLD** or **NEW**
explicitly.  Unlike most policies, CMake version 3.17.2 does _not_ warn
by default when this policy is not set and simply uses **OLD** behavior.
See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0047**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0046"></a>

### CMP0046


Error on non-existent dependency in add_dependencies.

CMake 2.8.12 and lower silently ignored non-existent dependencies
listed in the **add\_dependencies()** command.

The **OLD** behavior for this policy is to silently ignore non-existent
dependencies. The **NEW** behavior for this policy is to report an error
if non-existent dependencies are listed in the **add\_dependencies()**
command.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it
to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0045"></a>

### CMP0045


Error on non-existent target in get_target_property.

In CMake 2.8.12 and lower, the **get\_target\_property()** command accepted
a non-existent target argument without issuing any error or warning.  The
result variable is set to a **-NOTFOUND** value.

The **OLD** behavior for this policy is to issue no warning and set the result
variable to a **-NOTFOUND** value.  The **NEW** behavior
for this policy is to issue a **FATAL\_ERROR** if the command is called with a
non-existent target.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0044"></a>

### CMP0044


Case sensitive **&lt;LANG&gt;\_COMPILER\_ID** generator expressions

CMake 2.8.12 introduced the **&lt;LANG&gt;\_COMPILER\_ID**
**generator expressions** to allow
comparison of the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** with a test value.  The
possible valid values are lowercase, but the comparison with the test value
was performed case-insensitively.

The **OLD** behavior for this policy is to perform a case-insensitive comparison
with the value in the **&lt;LANG&gt;\_COMPILER\_ID** expression. The **NEW** behavior
for this policy is to perform a case-sensitive comparison with the value in
the **&lt;LANG&gt;\_COMPILER\_ID** expression.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0043"></a>

### CMP0043


Ignore COMPILE_DEFINITIONS_&lt;Config&gt; properties

CMake 2.8.12 and lower allowed setting the
**COMPILE\_DEFINITIONS\_&lt;CONFIG&gt;** target property and
**COMPILE\_DEFINITIONS\_&lt;CONFIG&gt;** directory property to apply
configuration-specific compile definitions.

Since CMake 2.8.10, the **COMPILE\_DEFINITIONS** property has supported
**generator expressions** for setting
configuration-dependent content.  The continued existence of the suffixed
variables is redundant, and causes a maintenance burden.  Population of the
**COMPILE\_DEFINITIONS\_DEBUG** property
may be replaced with a population of **COMPILE\_DEFINITIONS** directly
or via **target\_compile\_definitions()**:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # Old Interfaces:
    set_property(TARGET tgt APPEND PROPERTY
      COMPILE_DEFINITIONS_DEBUG DEBUG_MODE
    )
    set_property(DIRECTORY APPEND PROPERTY
      COMPILE_DEFINITIONS_DEBUG DIR_DEBUG_MODE
    )
    
    # New Interfaces:
    set_property(TARGET tgt APPEND PROPERTY
      COMPILE_DEFINITIONS $<$<CONFIG:Debug>:DEBUG_MODE>
    )
    target_compile_definitions(tgt PRIVATE $<$<CONFIG:Debug>:DEBUG_MODE>)
    set_property(DIRECTORY APPEND PROPERTY
      COMPILE_DEFINITIONS $<$<CONFIG:Debug>:DIR_DEBUG_MODE>
    )
    .ft P
.UNINDENT
.UNINDENT

The **OLD** behavior for this policy is to consume the content of the suffixed
**COMPILE\_DEFINITIONS\_&lt;CONFIG&gt;** target property when generating the
compilation command. The **NEW** behavior for this policy is to ignore the content
of the **COMPILE\_DEFINITIONS\_&lt;CONFIG&gt;** target property .

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0042"></a>

### CMP0042


**MACOSX\_RPATH** is enabled by default.

CMake 2.8.12 and newer has support for using **@rpath** in a target’s install
name.  This was enabled by setting the target property
**MACOSX\_RPATH**.  The **@rpath** in an install name is a more
flexible and powerful mechanism than **@executable\_path** or **@loader\_path**
for locating shared libraries.

CMake 3.0 and later prefer this property to be ON by default.  Projects
wanting **@rpath** in a target’s install name may remove any setting of
the **INSTALL\_NAME\_DIR** and **CMAKE\_INSTALL\_NAME\_DIR**
variables.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0041"></a>

### CMP0041


Error on relative include with generator expression.

Diagnostics in CMake 2.8.12 and lower silently ignored an entry in the
**INTERFACE\_INCLUDE\_DIRECTORIES** of a target if it contained a generator
expression at any position.

The path entries in that target property should not be relative. High-level
API should ensure that by adding either a source directory or a install
directory prefix, as appropriate.

As an additional diagnostic, the **INTERFACE\_INCLUDE\_DIRECTORIES** generated
on an **IMPORTED** target for the install location should not contain
paths in the source directory or the build directory.

The **OLD** behavior for this policy is to ignore relative path entries if they
contain a generator expression. The **NEW** behavior for this policy is to report
an error if a generator expression appears in another location and the path is
relative.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0040"></a>

### CMP0040


The target in the **TARGET** signature of **add\_custom\_command()**
must exist and must be defined in the current directory.

CMake 2.8.12 and lower silently ignored a custom command created with
the **TARGET** signature of **add\_custom\_command()**
if the target is unknown or was defined outside the current directory.

The **OLD** behavior for this policy is to ignore custom commands
for unknown targets.  The **NEW** behavior for this policy is to report
an error if the target referenced in **add\_custom\_command()** is
unknown or was defined outside the current directory.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.
Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0039"></a>

### CMP0039


Utility targets may not have link dependencies.

CMake 2.8.12 and lower allowed using utility targets in the left hand side
position of the **target\_link\_libraries()** command. This is an indicator
of a bug in user code.

The **OLD** behavior for this policy is to ignore attempts to set the link
libraries of utility targets.  The **NEW** behavior for this policy is to
report an error if an attempt is made to set the link libraries of a
utility target.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0038"></a>

### CMP0038


Targets may not link directly to themselves.

CMake 2.8.12 and lower allowed a build target to link to itself directly with
a **target\_link\_libraries()** call. This is an indicator of a bug in
user code.

The **OLD** behavior for this policy is to ignore targets which list themselves
in their own link implementation.  The **NEW** behavior for this policy is to
report an error if a target attempts to link to itself.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0037"></a>

### CMP0037


Target names should not be reserved and should match a validity pattern.

CMake 2.8.12 and lower allowed creating targets using **add\_library()**,
**add\_executable()** and **add\_custom\_target()** with unrestricted
choice for the target name.  Newer cmake features such
as **cmake-generator-expressions(7)** and some
diagnostics expect target names to match a restricted pattern.

Target names may contain upper and lower case letters, numbers, the underscore
character (**\_**), dot(**.**), plus(**+**) and minus(**-**).
As a special case, **ALIAS** and **IMPORTED** targets may contain
two consecutive colons.

Target names reserved by one or more CMake generators are not allowed.
Among others these include **all**, **clean**, **help**, and **install**.

Target names associated with optional features, such as **test** and
**package**, may also be reserved.  CMake 3.10 and below always reserve them.
CMake 3.11 and above reserve them only when the corresponding feature is
enabled (e.g. by including the **CTest** or **CPack** modules).

The **OLD** behavior for this policy is to allow creating targets with
reserved names or which do not match the validity pattern.
The **NEW** behavior for this policy is to report an error
if an add_* command is used with an invalid target name.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0036"></a>

### CMP0036


The **build\_name()** command should not be called.

This command was added in May 2001 to compute a name for the current
operating system and compiler combination.  The command has long been
documented as discouraged and replaced by the **CMAKE\_SYSTEM**
and **CMAKE\_&lt;LANG&gt;\_COMPILER** variables.

CMake &gt;= 3.0 prefer that this command never be called.
The **OLD** behavior for this policy is to allow the command to be called.
The **NEW** behavior for this policy is to issue a **FATAL\_ERROR** when the
command is called.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0035"></a>

### CMP0035


The **variable\_requires()** command should not be called.

This command was introduced in November 2001 to perform some conditional
logic.  It has long been replaced by the **if()** command.

CMake &gt;= 3.0 prefer that this command never be called.
The **OLD** behavior for this policy is to allow the command to be called.
The **NEW** behavior for this policy is to issue a **FATAL\_ERROR** when the
command is called.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0034"></a>

### CMP0034


The **utility\_source()** command should not be called.

This command was introduced in March 2001 to help build executables used to
generate other files.  This approach has long been replaced by
**add\_executable()** combined with **add\_custom\_command()**.

CMake &gt;= 3.0 prefer that this command never be called.
The **OLD** behavior for this policy is to allow the command to be called.
The **NEW** behavior for this policy is to issue a **FATAL\_ERROR** when the
command is called.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0033"></a>

### CMP0033


The **export\_library\_dependencies()** command should not be called.

This command was added in January 2003 to export **&lt;tgt&gt;\_LIB\_DEPENDS**
internal CMake cache entries to a file for installation with a project.
This was used at the time to allow transitive link dependencies to
work for applications outside of the original build tree of a project.
The functionality has been superseded by the **export()** and
**install(EXPORT)** commands.

CMake &gt;= 3.0 prefer that this command never be called.
The **OLD** behavior for this policy is to allow the command to be called.
The **NEW** behavior for this policy is to issue a **FATAL\_ERROR** when the
command is called.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0032"></a>

### CMP0032


The **output\_required\_files()** command should not be called.

This command was added in June 2001 to expose the then-current CMake
implicit dependency scanner.  CMake’s real implicit dependency scanner
has evolved since then but is not exposed through this command.  The
scanning capabilities of this command are very limited and this
functionality is better achieved through dedicated outside tools.

CMake &gt;= 3.0 prefer that this command never be called.
The **OLD** behavior for this policy is to allow the command to be called.
The **NEW** behavior for this policy is to issue a **FATAL\_ERROR** when the
command is called.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0031"></a>

### CMP0031


The **load\_command()** command should not be called.

This command was added in August 2002 to allow projects to add
arbitrary commands implemented in C or C++.  However, it does
not work when the toolchain in use does not match the ABI of
the CMake process.  It has been mostly superseded by the
**macro()** and **function()** commands.

CMake &gt;= 3.0 prefer that this command never be called.
The **OLD** behavior for this policy is to allow the command to be called.
The **NEW** behavior for this policy is to issue a **FATAL\_ERROR** when the
command is called.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0030"></a>

### CMP0030


The **use\_mangled\_mesa()** command should not be called.

This command was created in September 2001 to support VTK before
modern CMake language and custom command capabilities.  VTK has
not used it in years.

CMake &gt;= 3.0 prefer that this command never be called.
The **OLD** behavior for this policy is to allow the command to be called.
The **NEW** behavior for this policy is to issue a **FATAL\_ERROR** when the
command is called.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0029"></a>

### CMP0029


The **subdir\_depends()** command should not be called.

The implementation of this command has been empty since December 2001
but was kept in CMake for compatibility for a long time.

CMake &gt;= 3.0 prefer that this command never be called.
The **OLD** behavior for this policy is to allow the command to be called.
The **NEW** behavior for this policy is to issue a **FATAL\_ERROR** when the
command is called.

This policy was introduced in CMake version 3.0.
CMake version 3.17.2 warns when the policy is not set and uses
**OLD** behavior.  Use the **cmake\_policy()** command to set it to **OLD** or
**NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0028"></a>

### CMP0028


Double colon in target name means **ALIAS** or **IMPORTED** target.

CMake 2.8.12 and lower allowed the use of targets and files with double
colons in **target\_link\_libraries()**, with some buildsystem generators.

The use of double-colons is a common pattern used to namespace **IMPORTED**
targets and **ALIAS** targets.  When computing the link dependencies of
a target, the name of each dependency could either be a target, or a file
on disk.  Previously, if a target was not found with a matching name, the name
was considered to refer to a file on disk.  This can lead to confusing error
messages if there is a typo in what should be a target name.

The **OLD** behavior for this policy is to search for targets, then files on
disk, even if the search term contains double-colons.  The **NEW** behavior
for this policy is to issue a **FATAL\_ERROR** if a link dependency contains
double-colons but is not an **IMPORTED** target or an **ALIAS** target.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0027"></a>

### CMP0027


Conditionally linked imported targets with missing include directories.

CMake 2.8.11 introduced introduced the concept of
**INTERFACE\_INCLUDE\_DIRECTORIES**, and a check at cmake time that the
entries in the **INTERFACE\_INCLUDE\_DIRECTORIES** of an **IMPORTED**
target actually exist.  CMake 2.8.11 also introduced generator expression
support in the **target\_link\_libraries()** command.  However, if an
imported target is linked as a result of a generator expression evaluation, the
entries in the **INTERFACE\_INCLUDE\_DIRECTORIES** of that target were not
checked for existence as they should be.

The **OLD** behavior of this policy is to report a warning if an entry in
the **INTERFACE\_INCLUDE\_DIRECTORIES** of a generator-expression
conditionally linked **IMPORTED** target does not exist.

The **NEW** behavior of this policy is to report an error if an entry in
the **INTERFACE\_INCLUDE\_DIRECTORIES** of a generator-expression
conditionally linked **IMPORTED** target does not exist.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0026"></a>

### CMP0026


Disallow use of the LOCATION property for build targets.

CMake 2.8.12 and lower allowed reading the **LOCATION** target
property (and configuration-specific variants) to
determine the eventual location of build targets.  This relies on the
assumption that all necessary information is available at
configure-time to determine the final location and filename of the
target.  However, this property is not fully determined until later at
generate-time.  At generate time, the **$&lt;TARGET\_FILE&gt;** generator
expression can be used to determine the eventual **LOCATION** of a target
output.

Code which reads the **LOCATION** target property can be ported to
use the **$&lt;TARGET\_FILE&gt;** generator expression together with the
**file(GENERATE)** subcommand to generate a file containing
the target location.

The **OLD** behavior for this policy is to allow reading the **LOCATION**
properties from build-targets.  The **NEW** behavior for this policy is to
not to allow reading the **LOCATION** properties from build-targets.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0025"></a>

### CMP0025


Compiler id for Apple Clang is now **AppleClang**.

CMake 3.0 and above recognize that Apple Clang is a different compiler
than upstream Clang and that they have different version numbers.
CMake now prefers to present this to projects by setting the
**CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable to **AppleClang** instead
of **Clang**.  However, existing projects may assume the compiler id for
Apple Clang is just **Clang** as it was in CMake versions prior to 3.0.
Therefore this policy determines for Apple Clang which compiler id to
report in the **CMAKE\_&lt;LANG&gt;\_COMPILER\_ID** variable after
language **&lt;LANG&gt;** is enabled by the **project()** or
**enable\_language()** command.  The policy must be set prior
to the invocation of either command.

The **OLD** behavior for this policy is to use compiler id **Clang**.  The
**NEW** behavior for this policy is to use compiler id **AppleClang**.

This policy was introduced in CMake version 3.0.  Use the
**cmake\_policy()** command to set this policy to **OLD** or **NEW**
explicitly.  Unlike most policies, CMake version 3.17.2 does _not_ warn
by default when this policy is not set and simply uses **OLD** behavior.
See documentation of the
**CMAKE\_POLICY\_WARNING\_CMP0025**
variable to control the warning.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0024"></a>

### CMP0024


Disallow include export result.

CMake 2.8.12 and lower allowed use of the **include()** command with the
result of the **export()** command.  This relies on the assumption that
the **export()** command has an immediate effect at configure-time during
a cmake run.  Certain properties of targets are not fully determined
until later at generate-time, such as the link language and complete
list of link libraries.  Future refactoring will change the effect of
the **export()** command to be executed at generate-time.  Use **ALIAS**
targets instead in cases where the goal is to refer to targets by
another name.

The **OLD** behavior for this policy is to allow including the result of
an **export()** command.  The **NEW** behavior for this policy is not to
allow including the result of an **export()** command.

This policy was introduced in CMake version 3.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-28"></a>

# Policies Introduced by Cmake 2.8


<a name="cmp0023"></a>

### CMP0023


Plain and keyword **target\_link\_libraries()** signatures cannot be mixed.

CMake 2.8.12 introduced the **target\_link\_libraries()** signature using
the **PUBLIC**, **PRIVATE**, and **INTERFACE** keywords to generalize the
**LINK\_PUBLIC** and **LINK\_PRIVATE** keywords introduced in CMake 2.8.7.
Use of signatures with any of these keywords sets the link interface of a
target explicitly, even if empty.  This produces confusing behavior
when used in combination with the historical behavior of the plain
**target\_link\_libraries()** signature.  For example, consider the code:
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(mylib A)
    target_link_libraries(mylib PRIVATE B)
    .ft P
.UNINDENT
.UNINDENT

After the first line the link interface has not been set explicitly so
CMake would use the link implementation, A, as the link interface.
However, the second line sets the link interface to empty.  In order
to avoid this subtle behavior CMake now prefers to disallow mixing the
plain and keyword signatures of **target\_link\_libraries()** for a single
target.

The **OLD** behavior for this policy is to allow keyword and plain
**target\_link\_libraries()** signatures to be mixed.  The **NEW** behavior for
this policy is to not to allow mixing of the keyword and plain
signatures.

This policy was introduced in CMake version 2.8.12.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0022"></a>

### CMP0022


**INTERFACE\_LINK\_LIBRARIES** defines the link interface.

CMake 2.8.11 constructed the ‘link interface’ of a target from
properties matching **(IMPORTED\_)?LINK\_INTERFACE\_LIBRARIES(\_&lt;CONFIG&gt;)?**.
The modern way to specify config-sensitive content is to use generator
expressions and the **IMPORTED\_** prefix makes uniform processing of the
link interface with generator expressions impossible.  The
**INTERFACE\_LINK\_LIBRARIES** target property was introduced as a
replacement in CMake 2.8.12.  This new property is named consistently
with the **INTERFACE\_COMPILE\_DEFINITIONS**, **INTERFACE\_INCLUDE\_DIRECTORIES**
and **INTERFACE\_COMPILE\_OPTIONS** properties.  For in-build targets, CMake
will use the INTERFACE_LINK_LIBRARIES property as the source of the
link interface only if policy **CMP0022** is **NEW**.  When exporting a target
which has this policy set to **NEW**, only the **INTERFACE\_LINK\_LIBRARIES**
property will be processed and generated for the **IMPORTED** target by
default.  A new option to the **install(EXPORT)** and export commands
allows export of the old-style properties for compatibility with
downstream users of CMake versions older than 2.8.12.  The
**target\_link\_libraries()** command will no longer populate the properties
matching **LINK\_INTERFACE\_LIBRARIES(\_&lt;CONFIG&gt;)?** if this policy is **NEW**.

Warning-free future-compatible code which works with CMake 2.8.7 onwards
can be written by using the **LINK\_PRIVATE** and **LINK\_PUBLIC** keywords
of **target\_link\_libraries()**.

The **OLD** behavior for this policy is to ignore the
**INTERFACE\_LINK\_LIBRARIES** property for in-build targets.
The **NEW** behavior for this policy is to use the **INTERFACE\_LINK\_LIBRARIES**
property for in-build targets, and ignore the old properties matching
**(IMPORTED\_)?LINK\_INTERFACE\_LIBRARIES(\_&lt;CONFIG&gt;)?**.

This policy was introduced in CMake version 2.8.12.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0021"></a>

### CMP0021


Fatal error on relative paths in **INCLUDE\_DIRECTORIES** target
property.

CMake 2.8.10.2 and lower allowed the **INCLUDE\_DIRECTORIES** target
property to contain relative paths.  The base path for such relative
entries is not well defined.  CMake 2.8.12 issues a **FATAL\_ERROR** if the
**INCLUDE\_DIRECTORIES** property contains a relative path.

The **OLD** behavior for this policy is not to warn about relative paths
in the **INCLUDE\_DIRECTORIES** target property.  The **NEW** behavior for this
policy is to issue a **FATAL\_ERROR** if **INCLUDE\_DIRECTORIES** contains a
relative path.

This policy was introduced in CMake version 2.8.12.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0020"></a>

### CMP0020


Automatically link Qt executables to **qtmain** target on Windows.

CMake 2.8.10 and lower required users of Qt to always specify a link
dependency to the **qtmain.lib** static library manually on Windows.
CMake 2.8.11 gained the ability to evaluate generator expressions
while determining the link dependencies from **IMPORTED** targets.  This
allows CMake itself to automatically link executables which link to Qt
to the **qtmain.lib** library when using **IMPORTED** Qt targets.  For
applications already linking to **qtmain.lib**, this should have little
impact.  For applications which supply their own alternative WinMain
implementation and for applications which use the QAxServer library,
this automatic linking will need to be disabled as per the
documentation.

The **OLD** behavior for this policy is not to link executables to
**qtmain.lib** automatically when they link to the QtCore **IMPORTED** target.
The **NEW** behavior for this policy is to link executables to **qtmain.lib**
automatically when they link to QtCore **IMPORTED** target.

This policy was introduced in CMake version 2.8.11.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0019"></a>

### CMP0019


Do not re-expand variables in include and link information.

CMake 2.8.10 and lower re-evaluated values given to the
include_directories, link_directories, and link_libraries commands to
expand any leftover variable references at the end of the
configuration step.  This was for strict compatibility with VERY early
CMake versions because all variable references are now normally
evaluated during CMake language processing.  CMake 2.8.11 and higher
prefer to skip the extra evaluation.

The **OLD** behavior for this policy is to re-evaluate the values for
strict compatibility.  The **NEW** behavior for this policy is to leave
the values untouched.

This policy was introduced in CMake version 2.8.11.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0018"></a>

### CMP0018


Ignore **CMAKE\_SHARED\_LIBRARY\_&lt;Lang&gt;\_FLAGS** variable.

CMake 2.8.8 and lower compiled sources in **SHARED** and **MODULE** libraries
using the value of the undocumented **CMAKE\_SHARED\_LIBRARY\_&lt;Lang&gt;\_FLAGS**
platform variable.  The variable contained platform-specific flags
needed to compile objects for shared libraries.  Typically it included
a flag such as **-fPIC** for position independent code but also included
other flags needed on certain platforms.  CMake 2.8.9 and higher
prefer instead to use the **POSITION\_INDEPENDENT\_CODE** target
property to determine what targets should be position independent, and new
undocumented platform variables to select flags while ignoring
**CMAKE\_SHARED\_LIBRARY\_&lt;Lang&gt;\_FLAGS** completely.

The default for either approach produces identical compilation flags,
but if a project modifies **CMAKE\_SHARED\_LIBRARY\_&lt;Lang&gt;\_FLAGS** from its
original value this policy determines which approach to use.

The **OLD** behavior for this policy is to ignore the
**POSITION\_INDEPENDENT\_CODE** property for all targets and use the
modified value of **CMAKE\_SHARED\_LIBRARY\_&lt;Lang&gt;\_FLAGS** for **SHARED** and
**MODULE** libraries.

The **NEW** behavior for this policy is to ignore
**CMAKE\_SHARED\_LIBRARY\_&lt;Lang&gt;\_FLAGS** whether it is modified or not and
honor the **POSITION\_INDEPENDENT\_CODE** target property.

This policy was introduced in CMake version 2.8.9.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW**
explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0017"></a>

### CMP0017


Prefer files from the CMake module directory when including from there.

Starting with CMake 2.8.4, if a cmake-module shipped with CMake (i.e.
located in the CMake module directory) calls **include()** or
**find\_package()**, the files located in the CMake module directory are
preferred over the files in **CMAKE\_MODULE\_PATH**.  This makes sure
that the modules belonging to CMake always get those files included which
they expect, and against which they were developed and tested.  In all
other cases, the files found in **CMAKE\_MODULE\_PATH** still take
precedence over the ones in the CMake module directory.  The **OLD**
behavior is to always prefer files from CMAKE_MODULE_PATH over files
from the CMake modules directory.

This policy was introduced in CMake version 2.8.4.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0016"></a>

### CMP0016


**target\_link\_libraries()** reports error if its only argument
is not a target.

In CMake 2.8.2 and lower the **target\_link\_libraries()** command silently
ignored if it was called with only one argument, and this argument
wasn’t a valid target.  In CMake 2.8.3 and above it reports an error
in this case.

This policy was introduced in CMake version 2.8.3.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0015"></a>

### CMP0015

.INDENT 0.0
.INDENT 3.5
**link\_directories()** treats paths relative to the source dir.
.UNINDENT
.UNINDENT

In CMake 2.8.0 and lower the **link\_directories()** command passed
relative paths unchanged to the linker.  In CMake 2.8.1 and above the
**link\_directories()** command prefers to interpret relative paths with
respect to **CMAKE\_CURRENT\_SOURCE\_DIR**, which is consistent with
**include\_directories()** and other commands.  The **OLD** behavior for
this policy is to use relative paths verbatim in the linker command.  The
**NEW** behavior for this policy is to convert relative paths to absolute
paths by appending the relative path to **CMAKE\_CURRENT\_SOURCE\_DIR**.

This policy was introduced in CMake version 2.8.1.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0014"></a>

### CMP0014


Input directories must have **CMakeLists.txt**.

CMake versions before 2.8 silently ignored missing **CMakeLists.txt**
files in directories referenced by **add\_subdirectory()** or  **subdirs()**,
treating them as if present but empty.  In CMake 2.8.0 and above this
**cmake\_policy()** determines whether or not the case is an error.
The **OLD** behavior for this policy is to silently ignore the problem.
The **NEW** behavior for this policy is to report an error.

This policy was introduced in CMake version 2.8.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0013"></a>

### CMP0013


Duplicate binary directories are not allowed.

CMake 2.6.3 and below silently permitted add_subdirectory() calls to
create the same binary directory multiple times.  During build system
generation files would be written and then overwritten in the build
tree and could lead to strange behavior.  CMake 2.6.4 and above
explicitly detect duplicate binary directories.  CMake 2.6.4 always
considers this case an error.  In CMake 2.8.0 and above this policy
determines whether or not the case is an error.  The **OLD** behavior for
this policy is to allow duplicate binary directories.  The NEW
behavior for this policy is to disallow duplicate binary directories
with an error.

This policy was introduced in CMake version 2.8.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0012"></a>

### CMP0012


**if()** recognizes numbers and boolean constants.

In CMake versions 2.6.4 and lower the **if()** command implicitly
dereferenced arguments corresponding to variables, even those named
like numbers or boolean constants, except for **0** and **1**.  Numbers and
boolean constants such as **true**, **false**, **yes**, **no**, **on**,
**off**, **y**, **n**, **notfound**, **ignore** (all case insensitive)
were recognized in some cases but not all.  For example, the code **if(TRUE)**
might have evaluated as **false**.
Numbers such as 2 were recognized only in boolean expressions
like **if(NOT 2)** (leading to **false**) but not as a single-argument like
**if(2)** (also leading to **false**).  Later versions of CMake prefer to
treat numbers and boolean constants literally, so they should not be
used as variable names.

The **OLD** behavior for this policy is to implicitly dereference
variables named like numbers and boolean constants.  The **NEW** behavior
for this policy is to recognize numbers and boolean constants without
dereferencing variables with such names.

This policy was introduced in CMake version 2.8.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="policies-introduced-by-cmake-26"></a>

# Policies Introduced by Cmake 2.6


<a name="cmp0011"></a>

### CMP0011


Included scripts do automatic **cmake\_policy()** PUSH and POP.

In CMake 2.6.2 and below, CMake Policy settings in scripts loaded by
the **include()** and **find\_package()** commands would affect
the includer.  Explicit invocations of **cmake\_policy(PUSH)** and
**cmake\_policy(POP)** were required to isolate policy changes and protect
the includer.  While some scripts intend to affect the policies of their
includer, most do not.  In CMake 2.6.3 and above, **include()** and
**find\_package()** by default **PUSH** and **POP** an entry on
the policy stack around an included
script, but provide a **NO\_POLICY\_SCOPE** option to disable it.  This
policy determines whether or not to imply **NO\_POLICY\_SCOPE** for
compatibility.  The **OLD** behavior for this policy is to imply
**NO\_POLICY\_SCOPE** for **include()** and **find\_package()** commands.
The **NEW** behavior for this policy is to allow the commands to do
their default cmake_policy **PUSH** and **POP**.

This policy was introduced in CMake version 2.6.3.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0010"></a>

### CMP0010


Bad variable reference syntax is an error.

In CMake 2.6.2 and below, incorrect variable reference syntax such as
a missing close-brace (**${FOO**) was reported but did not stop
processing of CMake code.  This policy determines whether a bad
variable reference is an error.  The **OLD** behavior for this policy is
to warn about the error, leave the string untouched, and continue.
The **NEW** behavior for this policy is to report an error.

If **CMP0053** is set to **NEW**, this policy has no effect
and is treated as always being **NEW**.

This policy was introduced in CMake version 2.6.3.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0009"></a>

### CMP0009


FILE GLOB_RECURSE calls should not follow symlinks by default.

In CMake 2.6.1 and below, **file(GLOB\_RECURSE)** calls would follow
through symlinks, sometimes coming up with unexpectedly large result sets
because of symlinks to top level directories that contain hundreds of
thousands of files.

This policy determines whether or not to follow symlinks encountered
during a **file(GLOB\_RECURSE)** call.  The **OLD** behavior for this
policy is to follow the symlinks.  The **NEW** behavior for this policy is not
to follow the symlinks by default, but only if **FOLLOW\_SYMLINKS** is given
as an additional argument to the **FILE** command.

This policy was introduced in CMake version 2.6.2.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0008"></a>

### CMP0008


Libraries linked by full-path must have a valid library file name.

In CMake 2.4 and below it is possible to write code like
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(myexe /full/path/to/somelib)
    .ft P
.UNINDENT
.UNINDENT

where **somelib** is supposed to be a valid library file name such as
**libsomelib.a** or **somelib.lib**.  For Makefile generators this
produces an error at build time because the dependency on the full
path cannot be found.  For Visual Studio Generators IDE
and **Xcode** generators this used to
work by accident because CMake would always split off the library
directory and ask the linker to search for the library by name
(**-lsomelib** or **somelib.lib**).  Despite the failure with Makefiles, some
projects have code like this and build only with Visual Studio and/or Xcode.
This version of CMake prefers to pass the full path directly to the
native build tool, which will fail in this case because it does not
name a valid library file.

This policy determines what to do with full paths that do not appear
to name a valid library file.  The **OLD** behavior for this policy is to
split the library name from the path and ask the linker to search for
it.  The **NEW** behavior for this policy is to trust the given path and
pass it directly to the native build tool unchanged.

This policy was introduced in CMake version 2.6.1.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0007"></a>

### CMP0007


list command no longer ignores empty elements.

This policy determines whether the list command will ignore empty
elements in the list.  CMake 2.4 and below list commands ignored all
empty elements in the list.  For example, **a;b;;c** would have length 3
and not 4.  The **OLD** behavior for this policy is to ignore empty list
elements.  The **NEW** behavior for this policy is to correctly count
empty elements in a list.

This policy was introduced in CMake version 2.6.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0006"></a>

### CMP0006


Installing **MACOSX\_BUNDLE** targets requires a **BUNDLE DESTINATION**.

This policy determines whether the **install(TARGETS)** command must be
given a **BUNDLE DESTINATION** when asked to install a target with the
**MACOSX\_BUNDLE** property set.  CMake 2.4 and below did not distinguish
application bundles from normal executables when installing targets.
CMake 2.6 provides a **BUNDLE** option to the **install(TARGETS)**
command that specifies rules specific to application bundles on the Mac.
Projects should use this option when installing a target with the
**MACOSX\_BUNDLE** property set.

The **OLD** behavior for this policy is to fall back to the
**RUNTIME DESTINATION** if a **BUNDLE DESTINATION** is not given.  The **NEW**
behavior for this policy is to produce an error if a bundle target is installed
without a **BUNDLE DESTINATION**.

This policy was introduced in CMake version 2.6.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0005"></a>

### CMP0005


Preprocessor definition values are now escaped automatically.

This policy determines whether or not CMake should generate escaped
preprocessor definition values added via add_definitions.  CMake
versions 2.4 and below assumed that only trivial values would be given
for macros in add_definitions calls.  It did not attempt to escape
non-trivial values such as string literals in generated build rules.
CMake versions 2.6 and above support escaping of most values, but
cannot assume the user has not added escapes already in an attempt to
work around limitations in earlier versions.

The **OLD** behavior for this policy is to place definition values given
to add_definitions directly in the generated build rules without
attempting to escape anything.  The **NEW** behavior for this policy is to
generate correct escapes for all native build tools automatically.
See documentation of the **COMPILE\_DEFINITIONS** target property for
limitations of the escaping implementation.

This policy was introduced in CMake version 2.6.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0004"></a>

### CMP0004


Libraries linked may not have leading or trailing whitespace.

CMake versions 2.4 and below silently removed leading and trailing
whitespace from libraries linked with code like
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(myexe " A ")
    .ft P
.UNINDENT
.UNINDENT

This could lead to subtle errors in user projects.

The **OLD** behavior for this policy is to silently remove leading and
trailing whitespace.  The **NEW** behavior for this policy is to diagnose
the existence of such whitespace as an error.  The setting for this
policy used when checking the library names is that in effect when the
target is created by an **add\_executable()** or **add\_library()**
command.

This policy was introduced in CMake version 2.6.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0003"></a>

### CMP0003


Libraries linked via full path no longer produce linker search paths.

This policy affects how libraries whose full paths are NOT known are
found at link time, but was created due to a change in how CMake deals
with libraries whose full paths are known.  Consider the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(myexe /path/to/libA.so)
    .ft P
.UNINDENT
.UNINDENT

CMake 2.4 and below implemented linking to libraries whose full paths
are known by splitting them on the link line into separate components
consisting of the linker search path and the library name.  The
example code might have produced something like
.INDENT 0.0
.INDENT 3.5

    .ft C
    ... -L/path/to -lA ...
    .ft P
.UNINDENT
.UNINDENT

in order to link to library A.  An analysis was performed to order
multiple link directories such that the linker would find library A in
the desired location, but there are cases in which this does not work.
CMake versions 2.6 and above use the more reliable approach of passing
the full path to libraries directly to the linker in most cases.  The
example code now produces something like
.INDENT 0.0
.INDENT 3.5

    .ft C
    ... /path/to/libA.so ....
    .ft P
.UNINDENT
.UNINDENT

Unfortunately this change can break code like
.INDENT 0.0
.INDENT 3.5

    .ft C
    target_link_libraries(myexe /path/to/libA.so B)
    .ft P
.UNINDENT
.UNINDENT

where **B** is meant to find **/path/to/libB.so**.  This code is wrong
because the user is asking the linker to find library B but has not
provided a linker search path (which may be added with the
link_directories command).  However, with the old linking
implementation the code would work accidentally because the linker
search path added for library A allowed library B to be found.

In order to support projects depending on linker search paths added by
linking to libraries with known full paths, the **OLD** behavior for this
policy will add the linker search paths even though they are not
needed for their own libraries.  When this policy is set to **OLD**, CMake
will produce a link line such as
.INDENT 0.0
.INDENT 3.5

    .ft C
    ... -L/path/to /path/to/libA.so -lB ...
    .ft P
.UNINDENT
.UNINDENT

which will allow library B to be found as it was previously.  When
this policy is set to NEW, CMake will produce a link line such as
.INDENT 0.0
.INDENT 3.5

    .ft C
    ... /path/to/libA.so -lB ...
    .ft P
.UNINDENT
.UNINDENT

which more accurately matches what the project specified.

The setting for this policy used when generating the link line is that
in effect when the target is created by an add_executable or
add_library command.  For the example described above, the code
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_policy(SET CMP0003 OLD) # or cmake_policy(VERSION 2.4)
    add_executable(myexe myexe.c)
    target_link_libraries(myexe /path/to/libA.so B)
    .ft P
.UNINDENT
.UNINDENT

will work and suppress the warning for this policy.  It may also be
updated to work with the corrected linking approach:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_policy(SET CMP0003 NEW) # or cmake_policy(VERSION 2.6)
    link_directories(/path/to) # needed to find library B
    add_executable(myexe myexe.c)
    target_link_libraries(myexe /path/to/libA.so B)
    .ft P
.UNINDENT
.UNINDENT

Even better, library B may be specified with a full path:
.INDENT 0.0
.INDENT 3.5

    .ft C
    add_executable(myexe myexe.c)
    target_link_libraries(myexe /path/to/libA.so /path/to/libB.so)
    .ft P
.UNINDENT
.UNINDENT

When all items on the link line have known paths CMake does not check
this policy so it has no effect.

Note that the warning for this policy will be issued for at most one
target.  This avoids flooding users with messages for every target
when setting the policy once will probably fix all targets.

This policy was introduced in CMake version 2.6.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0002"></a>

### CMP0002


Logical target names must be globally unique.

Targets names created with **add\_executable()**, **add\_library()**, or
**add\_custom\_target()** are logical build target names.  Logical target
names must be globally unique because:
.INDENT 0.0
.INDENT 3.5

    .ft C
    - Unique names may be referenced unambiguously both in CMake
      code and on make tool command lines.
    - Logical names are used by Xcode and VS IDE generators
      to produce meaningful project names for the targets.
    .ft P
.UNINDENT
.UNINDENT

The logical name of executable and library targets does not have to
correspond to the physical file names built.  Consider using the
**OUTPUT\_NAME** target property to create two targets with the same
physical name while keeping logical names distinct.  Custom targets
must simply have globally unique names (unless one uses the global
property **ALLOW\_DUPLICATE\_CUSTOM\_TARGETS** with a Makefiles generator).

This policy was introduced in CMake version 2.6.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0001"></a>

### CMP0001


**CMAKE\_BACKWARDS\_COMPATIBILITY** should no longer be used.

The behavior is to check **CMAKE\_BACKWARDS\_COMPATIBILITY** and present
it to the user.  The **NEW** behavior is to ignore
CMAKE_BACKWARDS_COMPATIBILITY completely.

In CMake 2.4 and below the variable **CMAKE\_BACKWARDS\_COMPATIBILITY** was
used to request compatibility with earlier versions of CMake.  In
CMake 2.6 and above all compatibility issues are handled by policies
and the **cmake\_policy()** command.  However, CMake must still check
**CMAKE\_BACKWARDS\_COMPATIBILITY** for projects written for CMake 2.4 and
below.

This policy was introduced in CMake version 2.6.0.  CMake version
3.17.2 warns when the policy is not set and uses **OLD** behavior.  Use
the **cmake\_policy()** command to set it to **OLD** or **NEW** explicitly.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="cmp0000"></a>

### CMP0000


A minimum required CMake version must be specified.

CMake requires that projects specify the version of CMake to which
they have been written.  This policy has been put in place so users
trying to build the project may be told when they need to update their
CMake.  Specifying a version also helps the project build with CMake
versions newer than that specified.  Use the **cmake\_minimum\_required()**
command at the top of your main **CMakeLists.txt** file:
.INDENT 0.0
.INDENT 3.5

    .ft C
    cmake_minimum_required(VERSION <major>.<minor>)
    .ft P
.UNINDENT
.UNINDENT

where **&lt;major&gt;.&lt;minor&gt;** is the version of CMake you want to support
(such as **3.14**).  The command will ensure that at least the given
version of CMake is running and help newer versions be compatible with
the project.  See documentation of **cmake\_minimum\_required()** for
details.

Note that the command invocation must appear in the **CMakeLists.txt**
file itself; a call in an included file is not sufficient.  However,
the  **cmake\_policy()** command may be called to set policy **CMP0000**
to **OLD** or **NEW** behavior explicitly.  The **OLD** behavior is to
silently ignore the missing invocation.  The **NEW** behavior is to issue
an error instead of a warning.  An included file may set **CMP0000**
explicitly to affect how this policy is enforced for the main
**CMakeLists.txt** file.

This policy was introduced in CMake version 2.6.0.

**NOTE:**
.INDENT 0.0
.INDENT 3.5
The **OLD** behavior of a policy is
**deprecated by definition**
and may be removed in a future version of CMake.
.UNINDENT
.UNINDENT

<a name="copyright"></a>

# Copyright

2000-2020 Kitware, Inc. and Contributors

