# rustc(1) - The Rust compiler

Version 1.56.1, November 2021

```
rustc [OPTIONS] INPUT
```


<a name="description"></a>

# Description

This program is a compiler for the Rust language, available at https://www.rust-lang.org.


<a name="options"></a>

# Options



* **-h**, **--help**  
  Display the help message.
* **--cfg** _SPEC_  
  Configure the compilation environment.
* **-L** [_KIND_=]_PATH_  
  Add a directory to the library search path.
  The optional _KIND_ can be one of:
    * **dependency**  
      only lookup transitive dependencies here
    * **crate**  
      only lookup local \`extern crate\` directives here
    * **native**  
      only lookup native libraries here
    * **framework**  
      only look for OSX frameworks here
    * **all**  
      look for anything here (the default)
* **-l** [_KIND_=]_NAME_  
  Link the generated crate(s) to the specified library _NAME_.
  The optional _KIND_ can be one of _static_, _dylib_, or
  _framework_.
  If omitted, _dylib_ is assumed.
* **--crate-type** [bin|lib|rlib|dylib|cdylib|staticlib]  
  Comma separated list of types of crates for the compiler to emit.
* **--crate-name** _NAME_  
  Specify the name of the crate being built.
* **--emit** [asm|llvm-bc|llvm-ir|obj|link|dep-info|mir][=_PATH_]  
  Configure the output that **rustc** will produce. Each emission may also have
  an optional explicit output _PATH_ specified for that particular emission
  kind. This path takes precedence over the **-o** option.
* **--print** [crate-name|​file-names|​sysroot|​cfg|​target-list|​target-cpus|​target-features|​relocation-models|​code-models|​tls-models|​target-spec-json|​native-static-libs]  
  Comma separated list of compiler information to print on stdout.
* **-g**  
  Equivalent to _-C&nbsp;debuginfo=2_.
* **-O**  
  Equivalent to _-C&nbsp;opt-level=2_.
* **-o** _FILENAME_  
  Write output to _FILENAME_. Ignored if multiple _--emit_ outputs are specified which
  don't have an explicit path otherwise.
* **--out-dir** _DIR_  
  Write output to compiler\[hy]chosen filename in _DIR_. Ignored if _-o_ is specified.
  Defaults to the current directory.
* **--explain** _OPT_  
  Provide a detailed explanation of an error message.
* **--test**  
  Build a test harness.
* **--target** _TARGET_  
  Target triple for which the code is compiled. This option defaults to the host’s target
  triple. The target triple has the general format &lt;arch&gt;&lt;sub&gt;-&lt;vendor&gt;-&lt;sys&gt;-&lt;abi&gt;, where:
    * **&lt;arch&gt;**  
      x86, arm, thumb, mips, etc.
    * **&lt;sub&gt;**  
      for example on ARM: v5, v6m, v7a, v7m, etc.
    * **&lt;vendor&gt;**  
      pc, apple, nvidia, ibm, etc.
    * **&lt;sys&gt;**  
      none, linux, win32, darwin, cuda, etc.
    * **&lt;abi&gt;**  
      eabi, gnu, android, macho, elf, etc.
* **-W help**  
  Print 'lint' options and default settings.
* **-W** _OPT_, **--warn** _OPT_  
  Set lint warnings.
* **-A** _OPT_, **--allow** _OPT_  
  Set lint allowed.
* **-D** _OPT_, **--deny** _OPT_  
  Set lint denied.
* **-F** _OPT_, **--forbid** _OPT_  
  Set lint forbidden.
* **-C** _FLAG_[=_VAL_], **--codegen** _FLAG_[=_VAL_]  
  Set a codegen\[hy]related flag to the value specified.
  Use _-C help_ to print available flags.
  See CODEGEN OPTIONS below.
* **-V**, **--version**  
  Print version info and exit.
* **-v**, **--verbose**  
  Use verbose output.
* **--remap-path-prefix** _from_=_to_  
  Remap source path prefixes in all output, including compiler diagnostics, debug information,
  macro expansions, etc. The _from_=_to_ parameter is scanned from right to left, so _from_
  may contain '=', but _to_ may not.
  
  This is useful for normalizing build products, for example by removing the current directory out of
  pathnames emitted into the object files. The replacement is purely textual, with no consideration of
  the current system's pathname syntax. For example _--remap-path-prefix foo=bar_ will
  match **foo/lib.rs** but not **./foo/lib.rs**.
* **--extern** _NAME_=_PATH_  
  Specify where an external rust library is located. These should match
  _extern_ declarations in the crate's source code.
* **--sysroot** _PATH_  
  Override the system root.
* **-Z** _FLAG_  
  Set internal debugging options.
  Use _-Z help_ to print available options.
* **--color** auto|always|never  
  Configure coloring of output:
    * **auto**  
      colorize, if output goes to a tty (default);
    * **always**  
      always colorize output;
    * **never**  
      never colorize output.
  

<a name="codegen-options"></a>

# Codegen Options



* **linker**=_/path/to/cc_  
  Path to the linker utility to use when linking libraries, executables, and
  objects.
* **link-args**='_-flag1 -flag2_'  
  A space\[hy]separated list of extra arguments to pass to the linker when the linker
  is invoked.
* **lto**  
  Perform LLVM link\[hy]time optimizations.
* **target-cpu**=_help_  
  Selects a target processor.
  If the value is 'help', then a list of available CPUs is printed.
* **target-feature**='_+feature1_,_-feature2_'  
  A comma\[hy]separated list of features to enable or disable for the target.
  A preceding '+' enables a feature while a preceding '-' disables it.
  Available features can be discovered through _llc -mcpu=help_.
* **passes**=_val_  
  A space\[hy]separated list of extra LLVM passes to run.
  A value of 'list' will cause **rustc** to print all known passes and
  exit.
  The passes specified are appended at the end of the normal pass manager.
* **llvm-args**='_-arg1_ _-arg2_'  
  A space\[hy]separated list of arguments to pass through to LLVM.
* **save-temps**  
  If specified, the compiler will save more files (.bc, .o, .no-opt.bc) generated
  throughout compilation in the output directory.
* **rpath**  
  If specified, then the rpath value for dynamic libraries will be set in
  either dynamic library or executable outputs.
* **no-prepopulate-passes**  
  Suppresses pre\[hy]population of the LLVM pass manager that is run over the module.
* **no-vectorize-loops**  
  Suppresses running the loop vectorization LLVM pass, regardless of optimization
  level.
* **no-vectorize-slp**  
  Suppresses running the LLVM SLP vectorization pass, regardless of optimization
  level.
* **soft-float**  
  Generates software floating point library calls instead of hardware
  instructions.
* **prefer-dynamic**  
  Prefers dynamic linking to static linking.
* **no-integrated-as**  
  Force usage of an external assembler rather than LLVM's integrated one.
* **no-redzone**  
  Disable the use of the redzone.
* **relocation-model**=[pic,static,dynamic-no-pic]  
  The relocation model to use.
  (Default: _pic_)
* **code-model**=[small,kernel,medium,large]  
  Choose the code model to use.
* **metadata**=_val_  
  Metadata to mangle symbol names with.
* **extra-filename**=_val_  
  Extra data to put in each output filename.
* **codegen-units**=_n_  
  Divide crate into _n_ units to optimize in parallel.
* **remark**=_val_  
  Print remarks for these optimization passes (space separated, or "all").
* **no-stack-check**  
  Disable checks for stack exhaustion (a memory\[hy]safety hazard!).
* **debuginfo**=_val_  
  Debug info emission level:
    * **0**  
      no debug info;
    * **1**  
      line\[hy]tables only (for stacktraces and breakpoints);
    * **2**  
      full debug info with variable and type information.
* **opt-level**=_VAL_  
  Optimize with possible levels 0\[en]3, s (optimize for size), or z (for minimal size)
  

<a name="environment"></a>

# Environment


Some of these affect only test harness programs (generated via rustc --test);
others affect all programs which link to the Rust standard library.


* **RUST\_TEST\_THREADS**  
  The test framework Rust provides executes tests in parallel. This variable sets
  the maximum number of threads used for this purpose. This setting is overridden
  by the --test-threads option.
  
* **RUST\_TEST\_NOCAPTURE**  
  If set to a value other than "0", a synonym for the --nocapture flag.
  
* **RUST\_MIN\_STACK**  
  Sets the minimum stack size for new threads.
  
* **RUST\_BACKTRACE**  
  If set to a value different than "0", produces a backtrace in the output of a program which panics.
  

<a name="examples"></a>

# Examples

To build an executable from a source file with a main function:
    $ rustc -o hello hello.rs

To build a library from a source file:
    $ rustc --crate-type=lib hello-lib.rs

To build either with a crate (.rs) file:
    $ rustc hello.rs

To build an executable with debug info:
    $ rustc -g -o hello hello.rs


<a name="see-also"></a>

# See Also


**rustdoc**(1)


<a name="bugs"></a>

# Bugs

See https://github.com/rust-lang/rust/issues for issues.


<a name="author"></a>

# Author

See https://github.com/rust-lang/rust/graphs/contributors or use \`git log --all --format='%cN &lt;%cE&gt;' | sort -u\` in the rust source distribution.


<a name="copyright"></a>

# Copyright

This work is dual\[hy]licensed under Apache&nbsp;2.0 and MIT terms.
See _COPYRIGHT_ file in the rust source distribution.
