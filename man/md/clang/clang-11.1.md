# clang(1) - the Clang C, C++, and Objective-C compiler

11, Apr 14, 2021

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

<a name="synopsis"></a>

# Synopsis

```

 clang [options] filename ...
```

<a name="description"></a>

# Description


**clang** is a C, C++, and Objective-C compiler which encompasses
preprocessing, parsing, optimization, code generation, assembly, and linking.
Depending on which high-level mode setting is passed, Clang will stop before
doing a full link.  While Clang is highly integrated, it is important to
understand the stages of compilation, to understand how to invoke it.  These
stages are:
.INDENT 0.0

* **Driver**  
  The clang executable is actually a small driver which controls the overall
  execution of other tools such as the compiler, assembler and linker.
  Typically you do not need to interact with the driver, but you
  transparently use it to run the other tools.
* **Preprocessing**  
  This stage handles tokenization of the input source file, macro expansion,
  #include expansion and handling of other preprocessor directives.  The
  output of this stage is typically called a ".i" (for C), ".ii" (for C++),
  ".mi" (for Objective-C), or ".mii" (for Objective-C++) file.
* **Parsing and Semantic Analysis**  
  This stage parses the input file, translating preprocessor tokens into a
  parse tree.  Once in the form of a parse tree, it applies semantic
  analysis to compute types for expressions as well and determine whether
  the code is well formed. This stage is responsible for generating most of
  the compiler warnings as well as parse errors. The output of this stage is
  an "Abstract Syntax Tree" (AST).
* **Code Generation and Optimization**  
  This stage translates an AST into low-level intermediate code (known as
  "LLVM IR") and ultimately to machine code.  This phase is responsible for
  optimizing the generated code and handling target-specific code generation.
  The output of this stage is typically called a ".s" file or "assembly" file.

Clang also supports the use of an integrated assembler, in which the code
generator produces object files directly. This avoids the overhead of
generating the ".s" file and of calling the target assembler.

* **Assembler**  
  This stage runs the target assembler to translate the output of the
  compiler into a target object file. The output of this stage is typically
  called a ".o" file or "object" file.
* **Linker**  
  This stage runs the target linker to merge multiple object files into an
  executable or dynamic library. The output of this stage is typically called
  an "a.out", ".dylib" or ".so" file.
  .UNINDENT

**Clang Static Analyzer**

The Clang Static Analyzer is a tool that scans source code to try to find bugs
through code analysis.  This tool uses many parts of Clang and is built into
the same driver.  Please see &lt;_https://clang-analyzer.llvm.org_&gt; for more details
on how to use the static analyzer.

<a name="options"></a>

# Options


<a name="stage-selection-options"></a>

### Stage Selection Options

.INDENT 0.0

* **-E**  
  Run the preprocessor stage.
  .UNINDENT
  .INDENT 0.0
* **-fsyntax-only**  
  Run the preprocessor, parser and type checking stages.
  .UNINDENT
  .INDENT 0.0
* **-S**  
  Run the previous stages as well as LLVM generation and optimization stages
  and target-specific code generation, producing an assembly file.
  .UNINDENT
  .INDENT 0.0
* **-c**  
  Run all of the above, plus the assembler, generating a target ".o" object file.
  .UNINDENT
  .INDENT 0.0
* **no stage selection option**  
  If no stage selection option is specified, all stages above are run, and the
  linker is run to combine the results into an executable or shared library.
  .UNINDENT

<a name="language-selection-and-mode-options"></a>

### Language Selection and Mode Options

.INDENT 0.0

* **-x &lt;language&gt;**  
  Treat subsequent input files as having type language.
  .UNINDENT
  .INDENT 0.0
* **-std=&lt;standard&gt;**  
  Specify the language standard to compile for.

Supported values for the C language are:
.INDENT 7.0
.INDENT 3.5
    c89
    c90
    iso9899:1990

.INDENT 0.0
.INDENT 3.5
ISO C 1990
.UNINDENT
.UNINDENT
    iso9899:199409

.INDENT 0.0
.INDENT 3.5
ISO C 1990 with amendment 1
.UNINDENT
.UNINDENT
    gnu89
    gnu90

.INDENT 0.0
.INDENT 3.5
ISO C 1990 with GNU extensions
.UNINDENT
.UNINDENT
    c99
    iso9899:1999

.INDENT 0.0
.INDENT 3.5
ISO C 1999
.UNINDENT
.UNINDENT
    gnu99

.INDENT 0.0
.INDENT 3.5
ISO C 1999 with GNU extensions
.UNINDENT
.UNINDENT
    c11
    iso9899:2011

.INDENT 0.0
.INDENT 3.5
ISO C 2011
.UNINDENT
.UNINDENT
    gnu11

.INDENT 0.0
.INDENT 3.5
ISO C 2011 with GNU extensions
.UNINDENT
.UNINDENT
    c17
    iso9899:2017

.INDENT 0.0
.INDENT 3.5
ISO C 2017
.UNINDENT
.UNINDENT
    gnu17

.INDENT 0.0
.INDENT 3.5
ISO C 2017 with GNU extensions
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

The default C language standard is **gnu17**, except on PS4, where it is
**gnu99**.

Supported values for the C++ language are:
.INDENT 7.0
.INDENT 3.5
    c++98
    c++03

.INDENT 0.0
.INDENT 3.5
ISO C++ 1998 with amendments
.UNINDENT
.UNINDENT
    gnu++98
    gnu++03

.INDENT 0.0
.INDENT 3.5
ISO C++ 1998 with amendments and GNU extensions
.UNINDENT
.UNINDENT
    c++11

.INDENT 0.0
.INDENT 3.5
ISO C++ 2011 with amendments
.UNINDENT
.UNINDENT
    gnu++11

.INDENT 0.0
.INDENT 3.5
ISO C++ 2011 with amendments and GNU extensions
.UNINDENT
.UNINDENT
    c++14

.INDENT 0.0
.INDENT 3.5
ISO C++ 2014 with amendments
.UNINDENT
.UNINDENT
    gnu++14

.INDENT 0.0
.INDENT 3.5
ISO C++ 2014 with amendments and GNU extensions
.UNINDENT
.UNINDENT
    c++17

.INDENT 0.0
.INDENT 3.5
ISO C++ 2017 with amendments
.UNINDENT
.UNINDENT
    gnu++17

.INDENT 0.0
.INDENT 3.5
ISO C++ 2017 with amendments and GNU extensions
.UNINDENT
.UNINDENT
    c++2a

.INDENT 0.0
.INDENT 3.5
Working draft for ISO C++ 2020
.UNINDENT
.UNINDENT
    gnu++2a

.INDENT 0.0
.INDENT 3.5
Working draft for ISO C++ 2020 with GNU extensions
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

The default C++ language standard is **gnu++14**.

Supported values for the OpenCL language are:
.INDENT 7.0
.INDENT 3.5
    cl1.0

.INDENT 0.0
.INDENT 3.5
OpenCL 1.0
.UNINDENT
.UNINDENT
    cl1.1

.INDENT 0.0
.INDENT 3.5
OpenCL 1.1
.UNINDENT
.UNINDENT
    cl1.2

.INDENT 0.0
.INDENT 3.5
OpenCL 1.2
.UNINDENT
.UNINDENT
    cl2.0

.INDENT 0.0
.INDENT 3.5
OpenCL 2.0
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT

The default OpenCL language standard is **cl1.0**.

Supported values for the CUDA language are:
.INDENT 7.0
.INDENT 3.5
    cuda

.INDENT 0.0
.INDENT 3.5
NVIDIA CUDA(tm)
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-stdlib=&lt;library&gt;**  
  Specify the C++ standard library to use; supported options are libstdc++ and
  libc++. If not specified, platform default will be used.
  .UNINDENT
  .INDENT 0.0
* **-rtlib=&lt;library&gt;**  
  Specify the compiler runtime library to use; supported options are libgcc and
  compiler-rt. If not specified, platform default will be used.
  .UNINDENT
  .INDENT 0.0
* **-ansi**  
  Same as -std=c89.
  .UNINDENT
  .INDENT 0.0
* **-ObjC, -ObjC++**  
  Treat source input files as Objective-C and Object-C++ inputs respectively.
  .UNINDENT
  .INDENT 0.0
* **-trigraphs**  
  Enable trigraphs.
  .UNINDENT
  .INDENT 0.0
* **-ffreestanding**  
  Indicate that the file should be compiled for a freestanding, not a hosted,
  environment. Note that it is assumed that a freestanding environment will
  additionally provide _memcpy_, _memmove_, _memset_ and _memcmp_
  implementations, as these are needed for efficient codegen for many programs.
  .UNINDENT
  .INDENT 0.0
* **-fno-builtin**  
  Disable special handling and optimizations of builtin functions like
  **strlen()** and **malloc()**.
  .UNINDENT
  .INDENT 0.0
* **-fmath-errno**  
  Indicate that math functions should be treated as updating **errno**.
  .UNINDENT
  .INDENT 0.0
* **-fpascal-strings**  
  Enable support for Pascal-style strings with "\epfoo".
  .UNINDENT
  .INDENT 0.0
* **-fms-extensions**  
  Enable support for Microsoft extensions.
  .UNINDENT
  .INDENT 0.0
* **-fmsc-version=**  
  Set _MSC_VER. Defaults to 1300 on Windows. Not set otherwise.
  .UNINDENT
  .INDENT 0.0
* **-fborland-extensions**  
  Enable support for Borland extensions.
  .UNINDENT
  .INDENT 0.0
* **-fwritable-strings**  
  Make all string literals default to writable.  This disables uniquing of
  strings and other optimizations.
  .UNINDENT
  .INDENT 0.0
* **-flax-vector-conversions, -flax-vector-conversions=&lt;kind&gt;, -fno-lax-vector-conversions**  
  Allow loose type checking rules for implicit vector conversions.
  Possible values of &lt;kind&gt;:
  .INDENT 7.0
* ·  
  **none**: allow no implicit conversions between vectors
* ·  
  **integer**: allow implicit bitcasts between integer vectors of the same
  overall bit-width
* ·  
  **all**: allow implicit bitcasts between any vectors of the same
  overall bit-width
  .UNINDENT

&lt;kind&gt; defaults to **integer** if unspecified.
.UNINDENT
.INDENT 0.0

* **-fblocks**  
  Enable the "Blocks" language feature.
  .UNINDENT
  .INDENT 0.0
* **-fobjc-abi-version=version**  
  Select the Objective-C ABI version to use. Available versions are 1 (legacy
  "fragile" ABI), 2 (non-fragile ABI 1), and 3 (non-fragile ABI 2).
  .UNINDENT
  .INDENT 0.0
* **-fobjc-nonfragile-abi-version=&lt;version&gt;**  
  Select the Objective-C non-fragile ABI version to use by default. This will
  only be used as the Objective-C ABI when the non-fragile ABI is enabled
  (either via _-fobjc-nonfragile-abi_, or because it is the platform
  default).
  .UNINDENT
  .INDENT 0.0
* **-fobjc-nonfragile-abi, -fno-objc-nonfragile-abi**  
  Enable use of the Objective-C non-fragile ABI. On platforms for which this is
  the default ABI, it can be disabled with _-fno-objc-nonfragile-abi_.
  .UNINDENT

<a name="target-selection-options"></a>

### Target Selection Options


Clang fully supports cross compilation as an inherent part of its design.
Depending on how your version of Clang is configured, it may have support for a
number of cross compilers, or may only support a native target.
.INDENT 0.0

* **-arch &lt;architecture&gt;**  
  Specify the architecture to build for.
  .UNINDENT
  .INDENT 0.0
* **-mmacosx-version-min=&lt;version&gt;**  
  When building for macOS, specify the minimum version supported by your
  application.
  .UNINDENT
  .INDENT 0.0
* **-miphoneos-version-min**  
  When building for iPhone OS, specify the minimum version supported by your
  application.
  .UNINDENT
  .INDENT 0.0
* **--print-supported-cpus**  
  Print out a list of supported processors for the given target (specified
  through --target=&lt;architecture&gt; or -arch &lt;architecture&gt;). If no target is
  specified, the system default target will be used.
  .UNINDENT
  .INDENT 0.0
* **-mcpu=?, -mtune=?**  
  Aliases of --print-supported-cpus
  .UNINDENT
  .INDENT 0.0
* **-march=&lt;cpu&gt;**  
  Specify that Clang should generate code for a specific processor family
  member and later.  For example, if you specify -march=i486, the compiler is
  allowed to generate instructions that are valid on i486 and later processors,
  but which may not exist on earlier ones.
  .UNINDENT

<a name="code-generation-options"></a>

### Code Generation Options

.INDENT 0.0

* **-O0, -O1, -O2, -O3, -Ofast, -Os, -Oz, -Og, -O, -O4**  
  Specify which optimization level to use:
  .INDENT 7.0
  .INDENT 3.5
  _-O0_ Means "no optimization": this level compiles the fastest and
  generates the most debuggable code.

_-O1_ Somewhere between _-O0_ and _-O2_.

_-O2_ Moderate level of optimization which enables most
optimizations.

_-O3_ Like _-O2_, except that it enables optimizations that
take longer to perform or that may generate larger code (in an attempt to
make the program run faster).

_-Ofast_ Enables all the optimizations from _-O3_ along
with other aggressive optimizations that may violate strict compliance with
language standards.

_-Os_ Like _-O2_ with extra optimizations to reduce code
size.

_-Oz_ Like _-Os_ (and thus _-O2_), but reduces code
size further.

_-Og_ Like _-O1_. In future versions, this option might
disable different optimizations in order to improve debuggability.

_-O_ Equivalent to _-O1_.

_-O4_ and higher
.INDENT 0.0
.INDENT 3.5
Currently equivalent to _-O3_
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-g, -gline-tables-only, -gmodules**  
  Control debug information output.  Note that Clang debug information works
  best at _-O0_.  When more than one option starting with _-g_ is
  specified, the last one wins:
  .INDENT 7.0
  .INDENT 3.5
  **-g** Generate debug information.

**-gline-tables-only** Generate only line table debug information. This
allows for symbolicated backtraces with inlining information, but does not
include any information about variables, their locations or types.

_-gmodules_ Generate debug information that contains external
references to types defined in Clang modules or precompiled headers instead
of emitting redundant debug type information into every object file.  This
option transparently switches the Clang module format to object file
containers that hold the Clang module together with the debug information.
When compiling a program that uses Clang modules or precompiled headers,
this option produces complete debug information with faster compile
times and much smaller object files.

This option should not be used when building static libraries for
distribution to other machines because the debug info will contain
references to the module cache on the machine the object files in the
library were built on.
.UNINDENT
.UNINDENT
.UNINDENT
.INDENT 0.0

* **-fstandalone-debug -fno-standalone-debug**  
  Clang supports a number of optimizations to reduce the size of debug
  information in the binary. They work based on the assumption that the
  debug type information can be spread out over multiple compilation units.
  For instance, Clang will not emit type definitions for types that are not
  needed by a module and could be replaced with a forward declaration.
  Further, Clang will only emit type info for a dynamic C++ class in the
  module that contains the vtable for the class.

The **-fstandalone-debug** option turns off these optimizations.
This is useful when working with 3rd-party libraries that don't come with
debug information.  This is the default on Darwin.  Note that Clang will
never emit type information for types that are not referenced at all by the
program.
.UNINDENT
.INDENT 0.0

* **-fexceptions**  
  Enable generation of unwind information. This allows exceptions to be thrown
  through Clang compiled stack frames.  This is on by default in x86-64.
  .UNINDENT
  .INDENT 0.0
* **-ftrapv**  
  Generate code to catch integer overflow errors.  Signed integer overflow is
  undefined in C. With this flag, extra code is generated to detect this and
  abort when it happens.
  .UNINDENT
  .INDENT 0.0
* **-fvisibility**  
  This flag sets the default visibility level.
  .UNINDENT
  .INDENT 0.0
* **-fcommon, -fno-common**  
  This flag specifies that variables without initializers get common linkage.
  It can be disabled with _-fno-common_.
  .UNINDENT
  .INDENT 0.0
* **-ftls-model=&lt;model&gt;**  
  Set the default thread-local storage (TLS) model to use for thread-local
  variables. Valid values are: "global-dynamic", "local-dynamic",
  "initial-exec" and "local-exec". The default is "global-dynamic". The default
  model can be overridden with the tls_model attribute. The compiler will try
  to choose a more efficient model if possible.
  .UNINDENT
  .INDENT 0.0
* **-flto, -flto=full, -flto=thin, -emit-llvm**  
  Generate output files in LLVM formats, suitable for link time optimization.
  When used with _-S_ this generates LLVM intermediate language
  assembly files, otherwise this generates LLVM bitcode format object files
  (which may be passed to the linker depending on the stage selection options).

The default for _-flto_ is "full", in which the
LLVM bitcode is suitable for monolithic Link Time Optimization (LTO), where
the linker merges all such modules into a single combined module for
optimization. With "thin", ThinLTO
compilation is invoked instead.

**NOTE:**
.INDENT 7.0
.INDENT 3.5
On Darwin, when using _-flto_ along with **-g** and
compiling and linking in separate steps, you also need to pass
**-Wl,-object\_path\_lto,&lt;lto-filename&gt;.o** at the linking step to instruct the
ld64 linker not to delete the temporary object file generated during Link
Time Optimization (this flag is automatically passed to the linker by Clang
if compilation and linking are done in a single step). This allows debugging
the executable as well as generating the **.dSYM** bundle using **dsymutil(1)**.
.UNINDENT
.UNINDENT
.UNINDENT

<a name="driver-options"></a>

### Driver Options

.INDENT 0.0

* **-###**  
  Print (but do not run) the commands to run for this compilation.
  .UNINDENT
  .INDENT 0.0
* **--help**  
  Display available options.
  .UNINDENT
  .INDENT 0.0
* **-Qunused-arguments**  
  Do not emit any warnings for unused driver arguments.
  .UNINDENT
  .INDENT 0.0
* **-Wa,&lt;args&gt;**  
  Pass the comma separated arguments in args to the assembler.
  .UNINDENT
  .INDENT 0.0
* **-Wl,&lt;args&gt;**  
  Pass the comma separated arguments in args to the linker.
  .UNINDENT
  .INDENT 0.0
* **-Wp,&lt;args&gt;**  
  Pass the comma separated arguments in args to the preprocessor.
  .UNINDENT
  .INDENT 0.0
* **-Xanalyzer &lt;arg&gt;**  
  Pass arg to the static analyzer.
  .UNINDENT
  .INDENT 0.0
* **-Xassembler &lt;arg&gt;**  
  Pass arg to the assembler.
  .UNINDENT
  .INDENT 0.0
* **-Xlinker &lt;arg&gt;**  
  Pass arg to the linker.
  .UNINDENT
  .INDENT 0.0
* **-Xpreprocessor &lt;arg&gt;**  
  Pass arg to the preprocessor.
  .UNINDENT
  .INDENT 0.0
* **-o &lt;file&gt;**  
  Write output to file.
  .UNINDENT
  .INDENT 0.0
* **-print-file-name=&lt;file&gt;**  
  Print the full library path of file.
  .UNINDENT
  .INDENT 0.0
* **-print-libgcc-file-name**  
  Print the library path for the currently used compiler runtime library
  ("libgcc.a" or "libclang_rt.builtins.*.a").
  .UNINDENT
  .INDENT 0.0
* **-print-prog-name=&lt;name&gt;**  
  Print the full program path of name.
  .UNINDENT
  .INDENT 0.0
* **-print-search-dirs**  
  Print the paths used for finding libraries and programs.
  .UNINDENT
  .INDENT 0.0
* **-save-temps**  
  Save intermediate compilation results.
  .UNINDENT
  .INDENT 0.0
* **-save-stats, -save-stats=cwd, -save-stats=obj**  
  Save internal code generation (LLVM) statistics to a file in the current
  directory (_-save-stats_/"-save-stats=cwd") or the directory
  of the output file ("-save-state=obj").
  .UNINDENT
  .INDENT 0.0
* **-integrated-as, -no-integrated-as**  
  Used to enable and disable, respectively, the use of the integrated
  assembler. Whether the integrated assembler is on by default is target
  dependent.
  .UNINDENT
  .INDENT 0.0
* **-time**  
  Time individual commands.
  .UNINDENT
  .INDENT 0.0
* **-ftime-report**  
  Print timing summary of each stage of compilation.
  .UNINDENT
  .INDENT 0.0
* **-v**  
  Show commands to run and use verbose output.
  .UNINDENT

<a name="diagnostics-options"></a>

### Diagnostics Options

.INDENT 0.0

* **-fshow-column, -fshow-source-location, -fcaret-diagnostics, -fdiagnostics-fixit-info, -fdiagnostics-parseable-fixits, -fdiagnostics-print-source-range-info, -fprint-source-range-info, -fdiagnostics-show-option, -fmessage-length**  
  These options control how Clang prints out information about diagnostics
  (errors and warnings). Please see the Clang User's Manual for more information.
  .UNINDENT

<a name="preprocessor-options"></a>

### Preprocessor Options

.INDENT 0.0

* **-D&lt;macroname&gt;=&lt;value&gt;**  
  Adds an implicit #define into the predefines buffer which is read before the
  source file is preprocessed.
  .UNINDENT
  .INDENT 0.0
* **-U&lt;macroname&gt;**  
  Adds an implicit #undef into the predefines buffer which is read before the
  source file is preprocessed.
  .UNINDENT
  .INDENT 0.0
* **-include &lt;filename&gt;**  
  Adds an implicit #include into the predefines buffer which is read before the
  source file is preprocessed.
  .UNINDENT
  .INDENT 0.0
* **-I&lt;directory&gt;**  
  Add the specified directory to the search path for include files.
  .UNINDENT
  .INDENT 0.0
* **-F&lt;directory&gt;**  
  Add the specified directory to the search path for framework include files.
  .UNINDENT
  .INDENT 0.0
* **-nostdinc**  
  Do not search the standard system directories or compiler builtin directories
  for include files.
  .UNINDENT
  .INDENT 0.0
* **-nostdlibinc**  
  Do not search the standard system directories for include files, but do
  search compiler builtin include directories.
  .UNINDENT
  .INDENT 0.0
* **-nobuiltininc**  
  Do not search clang's builtin directory for include files.
  .UNINDENT

<a name="environment"></a>

# Environment

.INDENT 0.0

* **TMPDIR, TEMP, TMP**  
  These environment variables are checked, in order, for the location to write
  temporary files used during the compilation process.
  .UNINDENT
  .INDENT 0.0
* **CPATH**  
  If this environment variable is present, it is treated as a delimited list of
  paths to be added to the default system include path list. The delimiter is
  the platform dependent delimiter, as used in the PATH environment variable.

Empty components in the environment variable are ignored.
.UNINDENT
.INDENT 0.0

* **C_INCLUDE_PATH, OBJC_INCLUDE_PATH, CPLUS_INCLUDE_PATH, OBJCPLUS_INCLUDE_PATH**  
  These environment variables specify additional paths, as for _CPATH_, which are
  only used when processing the appropriate language.
  .UNINDENT
  .INDENT 0.0
* **MACOSX_DEPLOYMENT_TARGET**  
  If _-mmacosx-version-min_ is unspecified, the default deployment
  target is read from this environment variable. This option only affects
  Darwin targets.
  .UNINDENT

<a name="bugs"></a>

# Bugs


To report bugs, please visit &lt;_https://bugs.llvm.org/_&gt;.  Most bug reports should
include preprocessed source files (use the _-E_ option) and the full
output of the compiler, along with information to reproduce.

<a name="see-also"></a>

# See Also


**as(1)**, **ld(1)**

<a name="author"></a>

# Author

Maintained by the Clang / LLVM Team (&lt;http://clang.llvm.org&gt;)

<a name="copyright"></a>

# Copyright

2007-2021, The Clang Team

