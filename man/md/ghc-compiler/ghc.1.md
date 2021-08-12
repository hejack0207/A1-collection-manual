# ghc(1) - the Glasgow Haskell Compiler

8.8.4, Jul 27, 2020

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
.INDENT 0.0 .INDENT 3.5 

</synopsis>
    .ft C
    ghc [option|filename]
    ghci [option|filename]
    .ft P
<synopsis>
.UNINDENT .UNINDENT
```

<a name="description"></a>

# Description


This manual page documents briefly the **ghc** and **ghci** commands. Note that
**ghci** is not yet available on all architectures. Extensive documentation is
available in various other formats including PDF and HTML; see below.

Each of GHC's command line options is classified as either _static_ or
_dynamic_. A static flag may only be specified on the command line, whereas a
dynamic flag may also be given in an **OPTIONS** pragma in a source file or
set from the GHCi command-line with **:set** .

As a rule of thumb, all the language options are dynamic, as are the
warning options and the debugging options.

The rest are static, with the notable exceptions of
**-v**, **-cpp**, **-fasm**, **-fvia-C**, **-fllvm**, and
**-#include**.
The OPTIONS sections lists the status of each flag.

Common suffixes of file names for Haskell are:
.INDENT 0.0

* <b>**.hs**</b>  
  Haskell source code; preprocess, compile
* <b>**.lhs**</b>  
  literate Haskell source; unlit, preprocess, compile
* <b>**.hi**</b>  
  Interface file; contains information about exported symbols
* <b>**.hc**</b>  
  intermediate C files
* <b>**.⟨way⟩\_o**</b>  
  object files for "way" ⟨way⟩; common ways are:
  .INDENT 7.0
* <b>**dyn**</b>  
  dynamically-linked
* <b>**p**</b>  
  built with profiling
  .UNINDENT
* <b>**.⟨way⟩\_hi**</b>  
  interface files for "way" ⟨way⟩; common ways are:
  .UNINDENT

<a name="options"></a>

# Options


* **Code generation**  
  **-dynamic-too** **-fasm** **-fbyte-code** **-fexternal-dynamic-refs** **-fllvm** **-fno-code** **-fobject-code** **-fPIC** **-fPIE** **-fwrite-interface** 
* **Debugging the compiler**  
  **-dcmm-lint** **-dcore-lint** **-ddump-asm** **-ddump-asm-expanded** **-ddump-asm-liveness** **-ddump-asm-native** **-ddump-asm-regalloc** **-ddump-asm-regalloc-stages** **-ddump-asm-stats** **-ddump-bcos** **-ddump-cfg-weights** **-ddump-cmm** **-ddump-cmm-caf** **-ddump-cmm-cbe** **-ddump-cmm-cfg** **-ddump-cmm-cps** **-ddump-cmm-from-stg** **-ddump-cmm-info** **-ddump-cmm-proc** **-ddump-cmm-procmap** **-ddump-cmm-raw** **-ddump-cmm-sink** **-ddump-cmm-sp** **-ddump-cmm-split** **-ddump-cmm-switch** **-ddump-cmm-verbose** **-ddump-core-stats** **-ddump-cse** **-ddump-deriv** **-ddump-ds** **-ddump-ds-preopt** **-ddump-ec-trace** **-ddump-file-prefix=⟨str⟩** **-ddump-foreign** **-ddump-hpc** **-ddump-if-trace** **-ddump-inlinings** **-ddump-json** **-ddump-llvm** **-ddump-mod-map** **-ddump-occur-anal** **-ddump-opt-cmm** **-ddump-parsed** **-ddump-parsed-ast** **-ddump-prep** **-ddump-rn** **-ddump-rn-ast** **-ddump-rn-stats** **-ddump-rn-trace** **-ddump-rtti** **-ddump-rule-firings** **-ddump-rule-rewrites** **-ddump-rules** **-ddump-simpl** **-ddump-simpl-iterations** **-ddump-simpl-stats** **-ddump-spec** **-ddump-splices** **-ddump-stg** **-ddump-str-signatures** **-ddump-stranal** **-ddump-tc** **-ddump-tc-ast** **-ddump-tc-trace** **-ddump-ticked** **-ddump-timings** **-ddump-to-file** **-ddump-types** **-ddump-worker-wrapper** **-dfaststring-stats** **-dhex-word-literals** **-dinitial-unique=⟨s⟩** **-dinline-check=⟨str⟩** **-dno-debug-output** **-dppr-case-as-let** **-dppr-cols=⟨n⟩** **-dppr-debug** **-dppr-user-length** **-drule-check=⟨str⟩** **-dshow-passes** **-dstg-lint** **-dsuppress-all** **-dsuppress-coercions** **-dsuppress-idinfo** **-dsuppress-module-prefixes** **-dsuppress-stg-free-vars** **-dsuppress-ticks** **-dsuppress-timestamps** **-dsuppress-type-applications** **-dsuppress-type-signatures** **-dsuppress-unfoldings** **-dsuppress-uniques** **-dsuppress-var-kinds** **-dth-dec-file** **-dunique-increment=⟨i⟩** **-dverbose-core2core** **-dverbose-stg2stg** **-falignment-sanitisation** **-fcatch-bottoms** **-fllvm-fill-undef-with-garbage** **-fproc-alignment** **-g** **-g⟨n⟩** 
* **C pre-processor**  
  **-cpp** **-D⟨symbol⟩[=⟨value⟩]** **-I⟨dir⟩** **-U⟨symbol⟩** 
* **Finding imports**  
  **-i** **-i⟨dir⟩[:⟨dir⟩]*** 
* **Interactive mode**  
  **-fbreak-on-error** **-fbreak-on-exception** **-fghci-hist-size=⟨n⟩** **-fghci-leak-check** **-flocal-ghci-history** **-fno-it** **-fprint-bind-result** **-fshow-loaded-modules** **-ghci-script** **-ignore-dot-ghci** **-interactive-print ⟨expr⟩** 
* **Interface files**  
  **--show-iface ⟨file⟩** **-ddump-hi** **-ddump-hi-diffs** **-ddump-minimal-imports** 
* **Keeping intermediate files**  
  **-keep-hc-file** **-keep-hc-files** **-keep-hi-files** **-keep-hscpp-file** **-keep-hscpp-files** **-keep-llvm-file** **-keep-llvm-files** **-keep-o-files** **-keep-s-file** **-keep-s-files** **-keep-tmp-files** 
* **Language options**  
  **-fno-safe-haskell** **-fsort-by-size-hole-fits** **-fsort-by-subsumption-hole-fits** **-XAllowAmbiguousTypes** **-XApplicativeDo** **-XArrows** **-XBangPatterns** **-XBinaryLiterals** **-XBlockArguments** **-XCApiFFI** **-XConstrainedClassMethods** **-XConstraintKinds** **-XCPP** **-XDataKinds** **-XDatatypeContexts** **-XDefaultSignatures** **-XDeriveAnyClass** **-XDeriveDataTypeable** **-XDeriveFoldable** **-XDeriveFunctor** **-XDeriveGeneric** **-XDeriveLift** **-XDeriveTraversable** **-XDerivingStrategies** **-XDerivingVia** **-XDisambiguateRecordFields** **-XDuplicateRecordFields** **-XEmptyCase** **-XEmptyDataDecls** **-XEmptyDataDeriving** **-XExistentialQuantification** **-XExplicitForAll** **-XExplicitNamespaces** **-XExtendedDefaultRules** **-XFlexibleContexts** **-XFlexibleInstances** **-XForeignFunctionInterface** **-XFunctionalDependencies** **-XGADTs** **-XGADTSyntax** **-XGeneralisedNewtypeDeriving** **-XGeneralizedNewtypeDeriving** **-XHexFloatLiterals** **-XImplicitParams** **-XImpredicativeTypes** **-XIncoherentInstances** **-XInstanceSigs** **-XInterruptibleFFI** **-XKindSignatures** **-XLambdaCase** **-XLiberalTypeSynonyms** **-XMagicHash** **-XMonadComprehensions** **-XMonadFailDesugaring** **-XMonoLocalBinds** **-XMultiParamTypeClasses** **-XMultiWayIf** **-XNamedFieldPuns** **-XNamedWildCards** **-XNegativeLiterals** **-XNoImplicitPrelude** **-XNoMonomorphismRestriction** **-XNoPatternGuards** **-XNoTraditionalRecordSyntax** **-XNPlusKPatterns** **-XNullaryTypeClasses** **-XNumDecimals** **-XNumericUnderscores** **-XOverlappingInstances** **-XOverloadedLabels** **-XOverloadedLists** **-XOverloadedStrings** **-XPackageImports** **-XParallelListComp** **-XPartialTypeSignatures** **-XPatternSynonyms** **-XPolyKinds** **-XPostfixOperators** **-XQuantifiedConstraints** **-XQuasiQuotes** **-XRank2Types** **-XRankNTypes** **-XRebindableSyntax** **-XRecordWildCards** **-XRecursiveDo** **-XRoleAnnotations** **-XSafe** **-XScopedTypeVariables** **-XStandaloneDeriving** **-XStarIsType** **-XStaticPointers** **-XStrict** **-XStrictData** **-XTemplateHaskell** **-XTemplateHaskellQuotes** **-XTransformListComp** **-XTrustworthy** **-XTupleSections** **-XTypeApplications** **-XTypeFamilies** **-XTypeFamilyDependencies** **-XTypeInType** **-XTypeOperators** **-XTypeSynonymInstances** **-XUnboxedSums** **-XUnboxedTuples** **-XUndecidableInstances** **-XUndecidableSuperClasses** **-XUnicodeSyntax** **-XUnsafe** **-XViewPatterns** 
* **Linking options**  
  **-c** **-debug** **-dylib-install-name ⟨path⟩** **-dynamic** **-dynload** **-eventlog** **-fno-embed-manifest** **-fno-gen-manifest** **-fno-shared-implib** **-framework ⟨name⟩** **-framework-path ⟨dir⟩** **-fwhole-archive-hs-libs** **-keep-cafs** **-L ⟨dir⟩** **-l ⟨lib⟩** **-main-is ⟨thing⟩** **-no-hs-main** **-no-rtsopts-suggestions** **-package ⟨name⟩** **-pie** **-rdynamic** **-rtsopts[=⟨none|some|all|ignore|ignoreAll⟩]** **-shared** **-split-objs** **-split-sections** **-static** **-staticlib** **-threaded** **-with-rtsopts=⟨opts⟩** 
* **Miscellaneous options**  
  **-fexternal-interpreter** **-fglasgow-exts** **-ghcversion-file ⟨path to ghcversion.h⟩** **-H ⟨size⟩** **-j[⟨n⟩]** 
* **Modes of operation**  
  **--frontend ⟨module⟩** **--help** **-?** **--info** **--interactive** **--make** **--mk-dll** **--numeric-version** **--print-libdir** **--show-iface ⟨file⟩** **--show-options** **--supported-extensions** **--supported-languages** **--version** **-V** **-e ⟨expr⟩** **-M** 
* **Individual optimizations**  
  **-fasm-shortcutting** **-fblock-layout-cfg** **-fblock-layout-weightless** **-fblock-layout-weights** **-fcall-arity** **-fcase-folding** **-fcase-merge** **-fcmm-elim-common-blocks** **-fcmm-sink** **-fcpr-anal** **-fcross-module-specialise** **-fcse** **-fdicts-cheap** **-fdicts-strict** **-fdmd-tx-dict-sel** **-fdo-eta-reduction** **-fdo-lambda-eta-expansion** **-feager-blackholing** **-fenable-rewrite-rules** **-fexcess-precision** **-fexitification** **-fexpose-all-unfoldings** **-ffloat-in** **-ffull-laziness** **-ffun-to-thunk** **-fignore-asserts** **-fignore-interface-pragmas** **-flate-dmd-anal** **-flate-specialise** **-fliberate-case** **-fliberate-case-threshold=⟨n⟩** **-fllvm-pass-vectors-in-regs** **-floopification** **-fmax-inline-alloc-size=⟨n⟩** **-fmax-inline-memcpy-insns=⟨n⟩** **-fmax-inline-memset-insns=⟨n⟩** **-fmax-simplifier-iterations=⟨n⟩** **-fmax-uncovered-patterns=⟨n⟩** **-fmax-worker-args=⟨n⟩** **-fno-opt-coercion** **-fno-pre-inlining** **-fno-state-hack** **-fomit-interface-pragmas** **-fomit-yields** **-foptimal-applicative-do** **-fpedantic-bottoms** **-fregs-graph** **-fregs-iterative** **-fsimpl-tick-factor=⟨n⟩** **-fsimplifier-phases=⟨n⟩** **-fsolve-constant-dicts** **-fspec-constr** **-fspec-constr-count=⟨n⟩** **-fspec-constr-keen** **-fspec-constr-threshold=⟨n⟩** **-fspecialise** **-fspecialise-aggressively** **-fstatic-argument-transformation** **-fstg-cse** **-fstg-lift-lams** **-fstg-lift-lams-known** **-fstg-lift-lams-non-rec-args** **-fstg-lift-lams-rec-args** **-fstrictness** **-fstrictness-before=⟨n⟩** **-funbox-small-strict-fields** **-funbox-strict-fields** **-funfolding-creation-threshold=⟨n⟩** **-funfolding-dict-discount=⟨n⟩** **-funfolding-fun-discount=⟨n⟩** **-funfolding-keeness-factor=⟨n⟩** **-funfolding-use-threshold=⟨n⟩** 
* **Optimization levels**  
  **-O** **-O1** **-O0** **-O2** 
* **Package options**  
  **-clear-package-db** **-distrust ⟨pkg⟩** **-distrust-all-packages** **-fpackage-trust** **-global-package-db** **-hide-all-packages** **-hide-package ⟨pkg⟩** **-ignore-package ⟨pkg⟩** **-no-auto-link-packages** **-no-global-package-db** **-no-user-package-db** **-package ⟨pkg⟩** **-package-db ⟨file⟩** **-package-env ⟨file⟩|⟨name⟩** **-package-id ⟨unit-id⟩** **-this-unit-id ⟨unit-id⟩** **-trust ⟨pkg⟩** **-user-package-db** 
* **Phases of compilation**  
  **-C** **-c** **-E** **-F** **-S** **-x ⟨suffix⟩** 
* **Overriding external programs**  
  **-pgma ⟨cmd⟩** **-pgmc ⟨cmd⟩** **-pgmdll ⟨cmd⟩** **-pgmF ⟨cmd⟩** **-pgmi ⟨cmd⟩** **-pgmL ⟨cmd⟩** **-pgml ⟨cmd⟩** **-pgmlc ⟨cmd⟩** **-pgmlibtool ⟨cmd⟩** **-pgmlo ⟨cmd⟩** **-pgmP ⟨cmd⟩** **-pgms ⟨cmd⟩** **-pgmwindres ⟨cmd⟩** 
* **Phase-specific options**  
  **-opta ⟨option⟩** **-optc ⟨option⟩** **-optdll ⟨option⟩** **-optF ⟨option⟩** **-opti ⟨option⟩** **-optL ⟨option⟩** **-optl ⟨option⟩** **-optlc ⟨option⟩** **-optlo ⟨option⟩** **-optP ⟨option⟩** **-optwindres ⟨option⟩** 
* **Platform-specific options**  
  **-msse2** **-msse4.2** 
* **Compiler plugins**  
  **-fclear-plugins** **-fplugin-opt=⟨module⟩:⟨args⟩** **-fplugin=⟨module⟩** **-hide-all-plugin-packages** **-plugin-package ⟨pkg⟩** **-plugin-package-id ⟨pkg-id⟩** 
* **Profiling**  
  **-fno-prof-auto** **-fno-prof-cafs** **-fno-prof-count-entries** **-fprof-auto** **-fprof-auto-calls** **-fprof-auto-exported** **-fprof-auto-top** **-fprof-cafs** **-prof** **-ticky** 
* **Program coverage**  
  **-fhpc** 
* **Recompilation checking**  
  **-fforce-recomp** **-fignore-hpc-changes** **-fignore-optim-changes** 
* **Redirecting output**  
  **--exclude-module=⟨file⟩** **-ddump-mod-cycles** **-dep-makefile ⟨file⟩** **-dep-suffix ⟨suffix⟩** **-dumpdir ⟨dir⟩** **-hcsuf ⟨suffix⟩** **-hidir ⟨dir⟩** **-hiedir ⟨dir⟩** **-hiesuf ⟨suffix⟩** **-hisuf ⟨suffix⟩** **-include-pkg-deps** **-o ⟨file⟩** **-odir ⟨dir⟩** **-ohi ⟨file⟩** **-osuf ⟨suffix⟩** **-outputdir ⟨dir⟩** **-stubdir ⟨dir⟩** 
* **Temporary files**  
  **-tmpdir ⟨dir⟩** 
* **Verbosity options**  
  **-fabstract-refinement-hole-fits** **-fdiagnostics-color=⟨always|auto|never⟩** **-fdiagnostics-show-caret** **-ferror-spans** **-fhide-source-paths** **-fmax-refinement-hole-fits=⟨n⟩** **-fmax-relevant-binds=⟨n⟩** **-fmax-valid-hole-fits=⟨n⟩** **-fno-show-valid-hole-fits** **-fno-sort-valid-hole-fits** **-fprint-equality-relations** **-fprint-expanded-synonyms** **-fprint-explicit-coercions** **-fprint-explicit-foralls** **-fprint-explicit-kinds** **-fprint-explicit-runtime-reps** **-fprint-explicit-runtime-reps** **-fprint-potential-instances** **-fprint-typechecker-elaboration** **-fprint-unicode-syntax** **-frefinement-level-hole-fits=⟨n⟩** **-freverse-errors** **-fshow-docs-of-hole-fits** **-fshow-hole-constraints** **-fshow-hole-matches-of-hole-fits** **-fshow-provenance-of-hole-fits** **-fshow-type-app-of-hole-fits** **-fshow-type-app-vars-of-hole-fits** **-fshow-type-of-hole-fits** **-funclutter-valid-hole-fits** **-Rghc-timing** **-v** **-v⟨n⟩** 
* **Warnings**  
  **-fdefer-out-of-scope-variables** **-fdefer-type-errors** **-fdefer-typed-holes** **-fhelpful-errors** **-fmax-pmcheck-iterations=⟨n⟩** **-fshow-warning-groups** **-W** **-w** **-Wall** **-Wall-missed-specialisations** **-Wcompat** **-Wcpp-undef** **-Wdeferred-out-of-scope-variables** **-Wdeferred-type-errors** **-Wdeprecated-flags** **-Wdeprecations** **-Wdodgy-exports** **-Wdodgy-foreign-imports** **-Wdodgy-imports** **-Wduplicate-constraints** **-Wduplicate-exports** **-Wempty-enumerations** **-Werror** **-Weverything** **-Whi-shadowing** **-Widentities** **-Wimplicit-kind-vars** **-Wimplicit-prelude** **-Winaccessible-code** **-Wincomplete-patterns** **-Wincomplete-record-updates** **-Wincomplete-uni-patterns** **-Winline-rule-shadowing** **-Wmissed-extra-shared-lib** **-Wmissed-specialisations** **-Wmissing-deriving-strategies** **-Wmissing-export-lists** **-Wmissing-exported-signatures** **-Wmissing-exported-sigs** **-Wmissing-fields** **-Wmissing-home-modules** **-Wmissing-import-lists** **-Wmissing-local-signatures** **-Wmissing-local-sigs** **-Wmissing-methods** **-Wmissing-monadfail-instances** **-Wmissing-pattern-synonym-signatures** **-Wmissing-signatures** **-Wmonomorphism-restriction** **-Wname-shadowing** **-Wno-compat** **-Wnoncanonical-monad-instances** **-Wnoncanonical-monadfail-instances** **-Wnoncanonical-monoid-instances** **-Worphans** **-Woverflowed-literals** **-Woverlapping-patterns** **-Wpartial-fields** **-Wpartial-type-signatures** **-Wredundant-constraints** **-Wsafe** **-Wsemigroup** **-Wsimplifiable-class-constraints** **-Wspace-after-bang** **-Wstar-binder** **-Wstar-is-type** **-Wtabs** **-Wtrustworthy-safe** **-Wtype-defaults** **-Wtyped-holes** **-Wunbanged-strict-patterns** **-Wunrecognised-pragmas** **-Wunrecognised-warning-flags** **-Wunsafe** **-Wunsupported-calling-conventions** **-Wunsupported-llvm-version** **-Wunticked-promoted-constructors** **-Wunused-binds** **-Wunused-do-bind** **-Wunused-foralls** **-Wunused-imports** **-Wunused-local-binds** **-Wunused-matches** **-Wunused-pattern-binds** **-Wunused-top-binds** **-Wunused-type-patterns** **-Wwarn** **-Wwarnings-deprecations** **-Wwrong-do-bind** 

<a name="code-generation"></a>

### Code generation

.INDENT 0.0

* <b>**-dynamic-too**</b>  
  Build dynamic object files _as well as_ static object files
  during compilation
* <b>**-fasm**</b>  
  Use the native code generator
* <b>**-fbyte-code**</b>  
  Generate byte-code
* <b>**-fexternal-dynamic-refs**</b>  
  Generate code for linking against dynamic libraries
* <b>**-fllvm**</b>  
  Compile using the LLVM code generator
* <b>**-fno-code**</b>  
  Omit code generation
* <b>**-fobject-code**</b>  
  Generate object code
* <b>**-fPIC**</b>  
  Generate position-independent code (where available)
* <b>**-fPIE**</b>  
  Generate code for a position-independent executable (where available)
* <b>**-fwrite-interface**</b>  
  Always write interface files
  .UNINDENT

<a name="debugging-the-compiler"></a>

### Debugging the compiler

.INDENT 0.0

* <b>**-dcmm-lint**</b>  
  C-\e- pass sanity checking
* <b>**-dcore-lint**</b>  
  Turn on internal sanity checking
* <b>**-ddump-asm**</b>  
  Dump final assembly
* <b>**-ddump-asm-expanded**</b>  
  Dump the result of the synthetic instruction expansion pass.
* <b>**-ddump-asm-liveness**</b>  
  Dump assembly augmented with register liveness
* <b>**-ddump-asm-native**</b>  
  Dump initial assembly
* <b>**-ddump-asm-regalloc**</b>  
  Dump the result of register allocation
* <b>**-ddump-asm-regalloc-stages**</b>  
  Dump the build/spill stages of the **-fregs-graph**
  register allocator.
* <b>**-ddump-asm-stats**</b>  
  Dump statistics from the register allocator.
* <b>**-ddump-bcos**</b>  
  Dump interpreter byte code
* <b>**-ddump-cfg-weights**</b>  
  Dump the assumed weights of the CFG.
* <b>**-ddump-cmm**</b>  
  Dump the final C-\e- output
* <b>**-ddump-cmm-caf**</b>  
  Dump the results of the C-\e- CAF analysis pass.
* <b>**-ddump-cmm-cbe**</b>  
  Dump the results of common block elimination
* <b>**-ddump-cmm-cfg**</b>  
  Dump the results of the C-\e- control flow optimisation pass.
* <b>**-ddump-cmm-cps**</b>  
  Dump the results of the CPS pass
* <b>**-ddump-cmm-from-stg**</b>  
  Dump STG-to-C-\e- output
* <b>**-ddump-cmm-info**</b>  
  Dump the results of the C-\e- info table augmentation pass.
* <b>**-ddump-cmm-proc**</b>  
  Dump the results of proc-point analysis
* <b>**-ddump-cmm-procmap**</b>  
  Dump the results of the C-\e- proc-point map pass.
* <b>**-ddump-cmm-raw**</b>  
  Dump raw C-\e-
* <b>**-ddump-cmm-sink**</b>  
  Dump the results of the C-\e- sinking pass.
* <b>**-ddump-cmm-sp**</b>  
  Dump the results of the C-\e- stack layout pass.
* <b>**-ddump-cmm-split**</b>  
  Dump the results of the C-\e- proc-point splitting pass.
* <b>**-ddump-cmm-switch**</b>  
  Dump the results of switch lowering passes
* <b>**-ddump-cmm-verbose**</b>  
  Show output from main C-\e- pipeline passes
* <b>**-ddump-core-stats**</b>  
  Print a one-line summary of the size of the Core program at the
  end of the optimisation pipeline
* <b>**-ddump-cse**</b>  
  Dump CSE output
* <b>**-ddump-deriv**</b>  
  Dump deriving output
* <b>**-ddump-ds**</b>  
  Dump desugarer output.
* <b>**-ddump-ec-trace**</b>  
  Trace exhaustiveness checker
* <b>**-ddump-file-prefix=⟨str⟩**</b>  
  Set the prefix of the filenames used for debugging output.
* <b>**-ddump-foreign**</b>  
  Dump **foreign export** stubs
* <b>**-ddump-hpc**</b>  
  An alias for **-ddump-ticked**.
* <b>**-ddump-if-trace**</b>  
  Trace interface files
* <b>**-ddump-inlinings**</b>  
  Dump inlining info
* <b>**-ddump-json**</b>  
  Dump error messages as JSON documents
* <b>**-ddump-llvm**</b>  
  Dump LLVM intermediate code.
* <b>**-ddump-mod-map**</b>  
  Dump the state of the module mapping database.
* <b>**-ddump-occur-anal**</b>  
  Dump occurrence analysis output
* <b>**-ddump-opt-cmm**</b>  
  Dump the results of C-\e- to C-\e- optimising passes
* <b>**-ddump-parsed**</b>  
  Dump parse tree
* <b>**-ddump-parsed-ast**</b>  
  Dump parser output as a syntax tree
* <b>**-ddump-prep**</b>  
  Dump prepared core
* <b>**-ddump-rn**</b>  
  Dump renamer output
* <b>**-ddump-rn-ast**</b>  
  Dump renamer output as a syntax tree
* <b>**-ddump-rn-stats**</b>  
  Renamer stats
* <b>**-ddump-rn-trace**</b>  
  Trace renamer
* <b>**-ddump-rtti**</b>  
  Trace runtime type inference
* <b>**-ddump-rule-firings**</b>  
  Dump rule firing info
* <b>**-ddump-rule-rewrites**</b>  
  Dump detailed rule firing info
* <b>**-ddump-rules**</b>  
  Dump rewrite rules
* <b>**-ddump-simpl**</b>  
  Dump final simplifier output
* <b>**-ddump-simpl-iterations**</b>  
  Dump output from each simplifier iteration
* <b>**-ddump-simpl-stats**</b>  
  Dump simplifier stats
* <b>**-ddump-spec**</b>  
  Dump specialiser output
* <b>**-ddump-splices**</b>  
  Dump TH spliced expressions, and what they evaluate to
* <b>**-ddump-stg**</b>  
  Dump final STG
* <b>**-ddump-str-signatures**</b>  
  Dump strictness signatures
* <b>**-ddump-stranal**</b>  
  Dump strictness analyser output
* <b>**-ddump-tc**</b>  
  Dump typechecker output
* <b>**-ddump-tc-ast**</b>  
  Dump typechecker output as a syntax tree
* <b>**-ddump-tc-trace**</b>  
  Trace typechecker
* <b>**-ddump-ticked**</b>  
  Dump the code instrumented by HPC (hpc).
* <b>**-ddump-timings**</b>  
  Dump per-pass timing and allocation statistics
* <b>**-ddump-to-file**</b>  
  Dump to files instead of stdout
* <b>**-ddump-types**</b>  
  Dump type signatures
* <b>**-ddump-worker-wrapper**</b>  
  Dump worker-wrapper output
* <b>**-dfaststring-stats**</b>  
  Show statistics for fast string usage when finished
* <b>**-dhex-word-literals**</b>  
  Print values of type _Word#_ in hexadecimal.
* <b>**-dinitial-unique=⟨s⟩**</b>  
  Start **UniqSupply** allocation from ⟨s⟩.
* <b>**-dinline-check=⟨str⟩**</b>  
  Dump information about inlining decisions
* <b>**-dno-debug-output**</b>  
  Suppress unsolicited debugging output
* <b>**-dppr-case-as-let**</b>  
  Print single alternative case expressions as strict lets.
* <b>**-dppr-cols=⟨n⟩**</b>  
  Set the width of debugging output. For example **-dppr-cols200**
* <b>**-dppr-debug**</b>  
  Turn on debug printing (more verbose)
* <b>**-dppr-user-length**</b>  
  Set the depth for printing expressions in error msgs
* <b>**-drule-check=⟨str⟩**</b>  
  Dump information about potential rule application
* <b>**-dshow-passes**</b>  
  Print out each pass name as it happens
* <b>**-dstg-lint**</b>  
  STG pass sanity checking
* <b>**-dsuppress-all**</b>  
  In dumps, suppress everything (except for uniques) that is
  suppressible.
* <b>**-dsuppress-coercions**</b>  
  Suppress the printing of coercions in Core dumps to make them
  shorter
* <b>**-dsuppress-idinfo**</b>  
  Suppress extended information about identifiers where they
  are bound
* <b>**-dsuppress-module-prefixes**</b>  
  Suppress the printing of module qualification prefixes
* <b>**-dsuppress-stg-free-vars**</b>  
  Suppress the printing of closure free variable lists in STG output
* <b>**-dsuppress-ticks**</b>  
  Suppress "ticks" in the pretty-printer output.
* <b>**-dsuppress-timestamps**</b>  
  Suppress timestamps in dumps
* <b>**-dsuppress-type-applications**</b>  
  Suppress type applications
* <b>**-dsuppress-type-signatures**</b>  
  Suppress type signatures
* <b>**-dsuppress-unfoldings**</b>  
  Suppress the printing of the stable unfolding of a variable at
  its binding site
* <b>**-dsuppress-uniques**</b>  
  Suppress the printing of uniques in debug output (easier to use
  **diff**)
* <b>**-dsuppress-var-kinds**</b>  
  Suppress the printing of variable kinds
* <b>**-dth-dec-file**</b>  
  Dump evaluated TH declarations into _*.th.hs_ files
* <b>**-dunique-increment=⟨i⟩**</b>  
  Set the increment for the generated **Unique**'s to ⟨i⟩.
* <b>**-dverbose-core2core**</b>  
  Show output from each core-to-core pass
* <b>**-dverbose-stg2stg**</b>  
  Show output from each STG-to-STG pass
* <b>**-falignment-sanitisation**</b>  
  Compile with alignment checks for all info table dereferences.
* <b>**-fcatch-bottoms**</b>  
  Insert **error** expressions after bottoming expressions; useful
  when debugging the compiler.
* <b>**-fllvm-fill-undef-with-garbage**</b>  
  Intruct LLVM to fill dead STG registers with garbage
* <b>**-fproc-alignment**</b>  
  Align functions at given boundary.
* <b>**-g**</b>  
  Produce DWARF debug information in compiled object files.
  ⟨n⟩ can be 0, 1, or 2, with higher numbers producing richer
  output. If ⟨n⟩ is omitted, level 2 is assumed.
  .UNINDENT

<a name="c-pre-processor"></a>

### C pre\-processor

.INDENT 0.0

* <b>**-cpp**</b>  
  Run the C pre-processor on Haskell source files
* <b>**-D⟨symbol⟩[=⟨value⟩]**</b>  
  Define a symbol in the C pre-processor
* <b>**-I⟨dir⟩**</b>  
  Add ⟨dir⟩ to the directory search list for **#include** files
* <b>**-U⟨symbol⟩**</b>  
  Undefine a symbol in the C pre-processor
  .UNINDENT

<a name="finding-imports"></a>

### Finding imports

.INDENT 0.0

* <b>**-i**</b>  
  Empty the import directory list
* <b>**-i⟨dir⟩[:⟨dir⟩]***</b>  
  add ⟨dir⟩, ⟨dir2⟩, etc. to import path
  .UNINDENT

<a name="interactive-mode"></a>

### Interactive mode

.INDENT 0.0

* <b>**-fbreak-on-error**</b>  
  Break on uncaught exceptions and errors
* <b>**-fbreak-on-exception**</b>  
  Break on any exception thrown
* <b>**-fghci-hist-size=⟨n⟩**</b>  
  Set the number of entries GHCi keeps for **:history**.
  See ghci-debugger.
* <b>**-fghci-leak-check**</b>  
  (Debugging only) check for space leaks when loading
  new modules in GHCi.
* <b>**-flocal-ghci-history**</b>  
  Use current directory for the GHCi command history
  file **.ghci-history**.
* <b>**-fno-it**</b>  
  No longer set the special variable **it**.
* <b>**-fprint-bind-result**</b>  
  Turn on printing of binding results in GHCi
* <b>**-fshow-loaded-modules**</b>  
  Show the names of modules that GHCi loaded after a
  **:load** command.
* <b>**-ghci-script**</b>  
  Read additional **.ghci** files
* <b>**-ignore-dot-ghci**</b>  
  Disable reading of **.ghci** files
* <b>**-interactive-print ⟨expr⟩**</b>  
  Select the function to use for printing evaluated
  expressions in GHCi
  .UNINDENT

<a name="interface-files"></a>

### Interface files

.INDENT 0.0

* <b>**--show-iface ⟨file⟩**</b>  
  See modes.
* <b>**-ddump-hi**</b>  
  Dump the new interface to stdout
* <b>**-ddump-hi-diffs**</b>  
  Show the differences vs. the old interface
* <b>**-ddump-minimal-imports**</b>  
  Dump a minimal set of imports
  .UNINDENT

<a name="keeping-intermediate-files"></a>

### Keeping intermediate files

.INDENT 0.0

* <b>**-keep-hc-file**</b>  
  Retain intermediate **.hc** files.
* <b>**-keep-hi-files**</b>  
  Retain intermediate **.hi** files (the default).
* <b>**-keep-hscpp-file**</b>  
  Retain intermediate **.hscpp** files.
* <b>**-keep-llvm-file**</b>  
  Retain intermediate LLVM **.ll** files.
  Implies **-fllvm**.
* <b>**-keep-o-files**</b>  
  Retain intermediate **.o** files (the default).
* <b>**-keep-s-file**</b>  
  Retain intermediate **.s** files.
* <b>**-keep-tmp-files**</b>  
  Retain all intermediate temporary files.
  .UNINDENT

<a name="language-options"></a>

### Language options

.INDENT 0.0

* <b>**-fno-safe-haskell**</b>  
  Disable Safe Haskell
* <b>**-fsort-by-size-hole-fits**</b>  
  Sort valid hole fits by size.
* <b>**-fsort-by-subsumption-hole-fits**</b>  
  Sort valid hole fits by subsumption.
* <b>**-XAllowAmbiguousTypes**</b>  
  Allow the user to write ambiguous types, and
  the type inference engine to infer them.
* <b>**-XApplicativeDo**</b>  
  Enable Applicative do-notation desugaring
* <b>**-XArrows**</b>  
  Enable arrow notation extension
* <b>**-XBangPatterns**</b>  
  Enable bang patterns.
* <b>**-XBinaryLiterals**</b>  
  Enable support for binary literals.
* <b>**-XBlockArguments**</b>  
  Allow **do** blocks and other constructs as function arguments.
* <b>**-XCApiFFI**</b>  
  Enable the CAPI calling convention.
* <b>**-XConstrainedClassMethods**</b>  
  Enable constrained class methods.
* <b>**-XConstraintKinds**</b>  
  Enable a kind of constraints.
* <b>**-XCPP**</b>  
  Enable the C preprocessor.
* <b>**-XDataKinds**</b>  
  Enable datatype promotion.
* <b>**-XDatatypeContexts**</b>  
  Allow contexts on **data** types.
* <b>**-XDefaultSignatures**</b>  
  Enable default signatures.
* <b>**-XDeriveAnyClass**</b>  
  Enable deriving for any class.
* <b>**-XDeriveDataTypeable**</b>  
  Enable deriving for the Data class.
  Implied by (deprecated) **AutoDeriveTypeable**.
* <b>**-XDeriveFoldable**</b>  
  Enable deriving for the Foldable class.
  Implied by **DeriveTraversable**.
* <b>**-XDeriveFunctor**</b>  
  Enable deriving for the Functor class.
  Implied by **DeriveTraversable**.
* <b>**-XDeriveGeneric**</b>  
  Enable deriving for the Generic class.
* <b>**-XDeriveLift**</b>  
  Enable deriving for the Lift class
* <b>**-XDeriveTraversable**</b>  
  Enable deriving for the Traversable class.
  Implies **DeriveFunctor** and **DeriveFoldable**.
* <b>**-XDerivingStrategies**</b>  
  Enables deriving strategies.
* <b>**-XDerivingVia**</b>  
  Enable deriving instances **via** types of the same runtime
  representation.
  Implies **DerivingStrategies**.
* <b>**-XDisambiguateRecordFields**</b>  
  Enable record field disambiguation.
  Implied by **RecordWildCards**.
* <b>**-XDuplicateRecordFields**</b>  
  Allow definition of record types with identically-named fields.
* <b>**-XEmptyCase**</b>  
  Allow empty case alternatives.
* <b>**-XEmptyDataDecls**</b>  
  Allow definition of empty **data** types.
* <b>**-XEmptyDataDeriving**</b>  
  Allow deriving instances of standard type classes for
  empty data types.
* <b>**-XExistentialQuantification**</b>  
  Enable liberalised type synonyms.
* <b>**-XExplicitForAll**</b>  
  Enable explicit universal quantification.
  Implied by **ScopedTypeVariables**, **LiberalTypeSynonyms**,
  **RankNTypes** and **ExistentialQuantification**.
* <b>**-XExplicitNamespaces**</b>  
  Enable using the keyword **type** to specify the namespace of
  entries in imports and exports (explicit-namespaces).
  Implied by **TypeOperators** and **TypeFamilies**.
* <b>**-XExtendedDefaultRules**</b>  
  Use GHCi's extended default rules in a normal module.
* <b>**-XFlexibleContexts**</b>  
  Enable flexible contexts. Implied by
  **ImplicitParams**.
* <b>**-XFlexibleInstances**</b>  
  Enable flexible instances.
  Implies **TypeSynonymInstances**.
  Implied by **ImplicitParams**.
* <b>**-XForeignFunctionInterface**</b>  
  Enable foreign function interface.
* <b>**-XFunctionalDependencies**</b>  
  Enable functional dependencies.
  Implies **MultiParamTypeClasses**.
* <b>**-XGADTs**</b>  
  Enable generalised algebraic data types.
  Implies **GADTSyntax** and **MonoLocalBinds**.
* <b>**-XGADTSyntax**</b>  
  Enable generalised algebraic data type syntax.
* <b>**-XGeneralisedNewtypeDeriving**</b>  
  Enable newtype deriving.
* <b>**-XGeneralizedNewtypeDeriving**</b>  
  Enable newtype deriving.
* <b>**-XHexFloatLiterals**</b>  
  Enable support for hexadecimal floating point literals.
* <b>**-XImplicitParams**</b>  
  Enable Implicit Parameters.
  Implies **FlexibleContexts** and **FlexibleInstances**.
* <b>**-XImpredicativeTypes**</b>  
  Enable impredicative types.
  Implies **RankNTypes**.
* <b>**-XIncoherentInstances**</b>  
  Enable incoherent instances.
  Implies **OverlappingInstances**.
* <b>**-XInstanceSigs**</b>  
  Enable instance signatures.
* <b>**-XInterruptibleFFI**</b>  
  Enable interruptible FFI.
* <b>**-XKindSignatures**</b>  
  Enable kind signatures.
  Implied by **TypeFamilies** and **PolyKinds**.
* <b>**-XLambdaCase**</b>  
  Enable lambda-case expressions.
* <b>**-XLiberalTypeSynonyms**</b>  
  Enable liberalised type synonyms.
* <b>**-XMagicHash**</b>  
  Allow **#** as a postfix modifier on identifiers.
* <b>**-XMonadComprehensions**</b>  
  Enable monad comprehensions.
* <b>**-XMonadFailDesugaring**</b>  
  Enable monadfail desugaring.
* <b>**-XMonoLocalBinds**</b>  
  Enable do not generalise local bindings.
  Implied by **TypeFamilies** and **GADTs**.
* <b>**-XMultiParamTypeClasses**</b>  
  Enable multi parameter type classes.
  Implied by **FunctionalDependencies**.
* <b>**-XMultiWayIf**</b>  
  Enable multi-way if-expressions.
* <b>**-XNamedFieldPuns**</b>  
  Enable record puns.
* <b>**-XNamedWildCards**</b>  
  Enable named wildcards.
* <b>**-XNegativeLiterals**</b>  
  Enable support for negative literals.
* <b>**-XNoImplicitPrelude**</b>  
  Don't implicitly **import Prelude**.
  Implied by **RebindableSyntax**.
* <b>**-XNoMonomorphismRestriction**</b>  
  Disable the monomorphism restriction.
* <b>**-XNoPatternGuards**</b>  
  Disable pattern guards.
  Implied by **Haskell98**.
* <b>**-XNoTraditionalRecordSyntax**</b>  
  Disable support for traditional record syntax
  (as supported by Haskell 98) **C {f = x}**
* <b>**-XNPlusKPatterns**</b>  
  Enable support for **n+k** patterns.
  Implied by **Haskell98**.
* <b>**-XNullaryTypeClasses**</b>  
  Deprecated, does nothing. nullary (no parameter) type
  classes are now enabled using **MultiParamTypeClasses**.
* <b>**-XNumDecimals**</b>  
  Enable support for 'fractional' integer literals.
* <b>**-XNumericUnderscores**</b>  
  Enable support for numeric underscores.
* <b>**-XOverlappingInstances**</b>  
  Enable overlapping instances.
* <b>**-XOverloadedLabels**</b>  
  Enable overloaded labels.
* <b>**-XOverloadedLists**</b>  
  Enable overloaded lists.
* <b>**-XOverloadedStrings**</b>  
  Enable overloaded string literals.
* <b>**-XPackageImports**</b>  
  Enable package-qualified imports.
* <b>**-XParallelListComp**</b>  
  Enable parallel list comprehensions.
* <b>**-XPartialTypeSignatures**</b>  
  Enable partial type signatures.
* <b>**-XPatternSynonyms**</b>  
  Enable pattern synonyms.
* <b>**-XPolyKinds**</b>  
  Enable kind polymorphism.
  Implies **KindSignatures**.
* <b>**-XPostfixOperators**</b>  
  Enable postfix operators.
* <b>**-XQuantifiedConstraints**</b>  
  Allow **forall** quantifiers in constraints.
* <b>**-XQuasiQuotes**</b>  
  Enable quasiquotation.
* <b>**-XRank2Types**</b>  
  Enable rank-2 types.
  Synonym for **RankNTypes**.
* <b>**-XRankNTypes**</b>  
  Enable rank-N types.
  Implied by **ImpredicativeTypes**.
* <b>**-XRebindableSyntax**</b>  
  Employ rebindable syntax.
  Implies **NoImplicitPrelude**.
* <b>**-XRecordWildCards**</b>  
  Enable record wildcards.
  Implies **DisambiguateRecordFields**.
* <b>**-XRecursiveDo**</b>  
  Enable recursive do (mdo) notation.
* <b>**-XRoleAnnotations**</b>  
  Enable role annotations.
* <b>**-XSafe**</b>  
  Enable the Safe Haskell Safe mode.
* <b>**-XScopedTypeVariables**</b>  
  Enable lexically-scoped type variables.
* <b>**-XStandaloneDeriving**</b>  
  Enable standalone deriving.
* <b>**-XStarIsType**</b>  
  Treat *** as Data.Kind.Type**.
* <b>**-XStaticPointers**</b>  
  Enable static pointers.
* <b>**-XStrict**</b>  
  Make bindings in the current module strict by default.
* <b>**-XStrictData**</b>  
  Enable default strict datatype fields.
* <b>**-XTemplateHaskell**</b>  
  Enable Template Haskell.
* <b>**-XTemplateHaskellQuotes**</b>  
  Enable quotation subset of
  Template Haskell.
* <b>**-XTransformListComp**</b>  
  Enable generalised list comprehensions.
* <b>**-XTrustworthy**</b>  
  Enable the Safe Haskell Trustworthy mode.
* <b>**-XTupleSections**</b>  
  Enable tuple sections.
* <b>**-XTypeApplications**</b>  
  Enable type application syntax in terms and types.
* <b>**-XTypeFamilies**</b>  
  Enable type families.
  Implies **ExplicitNamespaces**, **KindSignatures**,
  and **MonoLocalBinds**.
* <b>**-XTypeFamilyDependencies**</b>  
  Enable injective type families.
  Implies **TypeFamilies**.
* <b>**-XTypeInType**</b>  
  Deprecated. Enable kind polymorphism and datatype promotion.
* <b>**-XTypeOperators**</b>  
  Enable type operators.
  Implies **ExplicitNamespaces**.
* <b>**-XTypeSynonymInstances**</b>  
  Enable type synonyms in instance heads.
  Implied by **FlexibleInstances**.
* <b>**-XUnboxedSums**</b>  
  Enable unboxed sums.
* <b>**-XUnboxedTuples**</b>  
  Enable the use of unboxed tuple syntax.
* <b>**-XUndecidableInstances**</b>  
  Enable undecidable instances.
* <b>**-XUndecidableSuperClasses**</b>  
  Allow all superclass constraints, including those that may
  result in non-termination of the typechecker.
* <b>**-XUnicodeSyntax**</b>  
  Enable unicode syntax.
* <b>**-XUnsafe**</b>  
  Enable Safe Haskell Unsafe mode.
* <b>**-XViewPatterns**</b>  
  Enable view patterns.
  .UNINDENT

<a name="linking-options"></a>

### Linking options

.INDENT 0.0

* <b>**-c**</b>  
  Stop after generating object (**.o**) file
* <b>**-debug**</b>  
  Use the debugging runtime
* <b>**-dylib-install-name ⟨path⟩**</b>  
  Set the install name (via **-install\_name** passed to Apple's
  linker), specifying the full install path of the library file.
  Any libraries or executables that link with it later will pick
  up that path as their runtime search location for it.
  (Darwin/OS X only)
* <b>**-dynamic**</b>  
  Build dynamically-linked object files and executables
* <b>**-dynload**</b>  
  Selects one of a number of modes for finding shared libraries at runtime.
* <b>**-eventlog**</b>  
  Enable runtime event tracing
* <b>**-fno-embed-manifest**</b>  
  Do not embed the manifest in the executable (Windows only)
* <b>**-fno-gen-manifest**</b>  
  Do not generate a manifest file (Windows only)
* <b>**-fno-shared-implib**</b>  
  Don't generate an import library for a DLL (Windows only)
* <b>**-framework ⟨name⟩**</b>  
  On Darwin/OS X/iOS only, link in the framework ⟨name⟩. This
  option corresponds to the **-framework** option for Apple's Linker.
* <b>**-framework-path ⟨dir⟩**</b>  
  On Darwin/OS X/iOS only, add ⟨dir⟩ to the list of directories
  searched for frameworks. This option corresponds to the **-F**
  option for Apple's Linker.
* <b>**-fwhole-archive-hs-libs**</b>  
  When linking a binary executable, this inserts the flag
  **-Wl,--whole-archive** before any **-l** flags for Haskell
  libraries, and **-Wl,--no-whole-archive** afterwards
* <b>**-keep-cafs**</b>  
  Do not garbage-collect CAFs (top-level expressions) at runtime
* <b>**-L ⟨dir⟩**</b>  
  Add ⟨dir⟩ to the list of directories searched for libraries
* <b>**-l ⟨lib⟩**</b>  
  Link in library ⟨lib⟩
* <b>**-main-is ⟨thing⟩**</b>  
  Set main module and function
* <b>**-no-hs-main**</b>  
  Don't assume this program contains **main**
* <b>**-no-rtsopts-suggestions**</b>  
  Don't print RTS suggestions about linking with
  **-rtsopts[=⟨none|some|all|ignore|ignoreAll⟩]**.
* <b>**-package ⟨name⟩**</b>  
  Expose package ⟨pkg⟩
* <b>**-pie**</b>  
  Instruct the linker to produce a position-independent executable.
* <b>**-rdynamic**</b>  
  This instructs the linker to add all symbols, not only used
  ones, to the dynamic symbol table. Currently Linux and
  Windows/MinGW32 only. This is equivalent to using
  **-optl -rdynamic** on Linux, and **-optl -export-all-symbols**
  on Windows.
* <b>**-rtsopts[=⟨none|some|all|ignore|ignoreAll⟩]**</b>  
  Control whether the RTS behaviour can be tweaked via command-line
  flags and the **GHCRTS** environment variable. Using **none**
  means no RTS flags can be given; **some** means only a minimum
  of safe options can be given (the default); **all** (or no
  argument at all) means that all RTS flags are permitted; **ignore**
  means RTS flags can be given, but are treated as regular arguments and
  passed to the Haskell program as arguments; **ignoreAll** is the same as
  **ignore**, but **GHCRTS** is also ignored. **-rtsopts** does not
  affect **-with-rtsopts** behavior; flags passed via **-with-rtsopts**
  are used regardless of **-rtsopts**.
* <b>**-shared**</b>  
  Generate a shared library (as opposed to an executable)
* <b>**-split-objs**</b>  
  Split objects (for libraries)
* <b>**-split-sections**</b>  
  Split sections for link-time dead-code stripping
* <b>**-static**</b>  
  Use static Haskell libraries
* <b>**-staticlib**</b>  
  Generate a standalone static library (as opposed to an
  executable). This is useful when cross compiling. The
  library together with all its dependencies ends up in in a
  single static library that can be linked against.
* <b>**-threaded**</b>  
  Use the threaded runtime
* <b>**-with-rtsopts=⟨opts⟩**</b>  
  Set the default RTS options to ⟨opts⟩.
  .UNINDENT

<a name="miscellaneous-options"></a>

### Miscellaneous options

.INDENT 0.0

* <b>**-fexternal-interpreter**</b>  
  Run interpreted code in a separate process
* <b>**-fglasgow-exts**</b>  
  Deprecated. Enable most language extensions;
  see options-language for exactly which ones.
* <b>**-ghcversion-file ⟨path to ghcversion.h⟩**</b>  
  (GHC as a C compiler only) Use this **ghcversion.h** file
* <b>**-H ⟨size⟩**</b>  
  Set the minimum size of the heap to ⟨size⟩
* <b>**-j[⟨n⟩]**</b>  
  When compiling with **--make**, compile ⟨n⟩ modules
  in parallel.
  .UNINDENT

<a name="modes-of-operation"></a>

### Modes of operation

.INDENT 0.0

* <b>**--frontend ⟨module⟩**</b>  
  run GHC with the given frontend plugin; see
  frontend_plugins for details.
* <b>**--help**</b>  
  Display help
* <b>**--info**</b>  
  display information about the compiler
* <b>**--interactive**</b>  
  Interactive mode - normally used by just running **ghci**;
  see ghci for details.
* <b>**--make**</b>  
  Build a multi-module Haskell program, automatically figuring out
  dependencies. Likely to be much easier, and faster, than using
  **make**; see make-mode for details.
* <b>**--mk-dll**</b>  
  DLL-creation mode (Windows only)
* <b>**--numeric-version**</b>  
  display GHC version (numeric only)
* <b>**--print-libdir**</b>  
  display GHC library directory
* <b>**--show-iface ⟨file⟩**</b>  
  display the contents of an interface file.
* <b>**--show-options**</b>  
  display the supported command line options
* <b>**--supported-extensions**</b>  
  display the supported language extensions
* <b>**--version**</b>  
  display GHC version
* <b>**-e ⟨expr⟩**</b>  
  Evaluate **expr**; see eval-mode for details.
* <b>**-M**</b>  
  generate dependency information suitable for use in a
  **Makefile**; see makefile-dependencies for details.
  .UNINDENT

<a name="individual-optimizations"></a>

### Individual optimizations

.INDENT 0.0

* <b>**-fasm-shortcutting**</b>  
  Enable shortcutting on assembly. Implied by **-O2**.
* <b>**-fblock-layout-cfg**</b>  
  Use the new cfg based block layout algorithm.
* <b>**-fblock-layout-weightless**</b>  
  Ignore cfg weights for code layout.
* <b>**-fblock-layout-weights**</b>  
  Sets edge weights used by the new code layout algorithm.
* <b>**-fcall-arity**</b>  
  Enable call-arity optimisation. Implied by **-O**.
* <b>**-fcase-folding**</b>  
  Enable constant folding in case expressions. Implied by **-O**.
* <b>**-fcase-merge**</b>  
  Enable case-merging. Implied by **-O**.
* <b>**-fcmm-elim-common-blocks**</b>  
  Enable Cmm common block elimination. Implied by **-O**.
* <b>**-fcmm-sink**</b>  
  Enable Cmm sinking. Implied by **-O**.
* <b>**-fcpr-anal**</b>  
  Turn on CPR analysis in the demand analyser. Implied by **-O**.
* <b>**-fcross-module-specialise**</b>  
  Turn on specialisation of overloaded functions imported from
  other modules.
* <b>**-fcse**</b>  
  Enable common sub-expression elimination. Implied by **-O**.
* <b>**-fdicts-cheap**</b>  
  Make dictionary-valued expressions seem cheap to the optimiser.
* <b>**-fdicts-strict**</b>  
  Make dictionaries strict
* <b>**-fdmd-tx-dict-sel**</b>  
  Use a special demand transformer for dictionary selectors.
  Always enabled by default.
* <b>**-fdo-eta-reduction**</b>  
  Enable eta-reduction. Implied by **-O**.
* <b>**-fdo-lambda-eta-expansion**</b>  
  Enable lambda eta-expansion. Always enabled by default.
* <b>**-feager-blackholing**</b>  
  Turn on eager blackholing
* <b>**-fenable-rewrite-rules**</b>  
  Switch on all rewrite rules (including rules generated by
  automatic specialisation of overloaded functions). Implied by
  **-O**.
* <b>**-fexcess-precision**</b>  
  Enable excess intermediate precision
* <b>**-fexitification**</b>  
  Enables exitification optimisation. Implied by **-O**.
* <b>**-fexpose-all-unfoldings**</b>  
  Expose all unfoldings, even for very large or recursive functions.
* <b>**-ffloat-in**</b>  
  Turn on the float-in transformation. Implied by **-O**.
* <b>**-ffull-laziness**</b>  
  Turn on full laziness (floating bindings outwards).
  Implied by **-O**.
* <b>**-ffun-to-thunk**</b>  
  Allow worker-wrapper to convert a function closure into a thunk
  if the function does not use any of its arguments. Off by default.
* <b>**-fignore-asserts**</b>  
  Ignore assertions in the source. Implied by **-O**.
* <b>**-fignore-interface-pragmas**</b>  
  Ignore pragmas in interface files. Implied by **-O0** only.
* <b>**-flate-dmd-anal**</b>  
  Run demand analysis again, at the end of the
  simplification pipeline
* <b>**-flate-specialise**</b>  
  Run a late specialisation pass
* <b>**-fliberate-case**</b>  
  Turn on the liberate-case transformation. Implied by **-O2**.
* <b>**-fliberate-case-threshold=⟨n⟩**</b>  
  _default: 2000._ Set the size threshold for the liberate-case
  transformation to ⟨n⟩
* <b>**-fllvm-pass-vectors-in-regs**</b>  
  Pass vector value in vector registers for function calls
* <b>**-floopification**</b>  
  Turn saturated self-recursive tail-calls into local jumps in the
  generated assembly. Implied by **-O**.
* <b>**-fmax-inline-alloc-size=⟨n⟩**</b>  
  _default: 128._ Set the maximum size of inline array allocations
  to ⟨n⟩ bytes (default: 128).
* <b>**-fmax-inline-memcpy-insns=⟨n⟩**</b>  
  _default: 32._ Inline **memcpy** calls if they would generate no
  more than ⟨n⟩ pseudo instructions.
* <b>**-fmax-inline-memset-insns=⟨n⟩**</b>  
  _default: 32._ Inline **memset** calls if they would generate no
  more than ⟨n⟩ pseudo instructions
* <b>**-fmax-simplifier-iterations=⟨n⟩**</b>  
  _default: 4._ Set the max iterations for the simplifier.
* <b>**-fmax-uncovered-patterns=⟨n⟩**</b>  
  _default: 4._ Set the maximum number of patterns to display in
  warnings about non-exhaustive ones.
* <b>**-fmax-worker-args=⟨n⟩**</b>  
  _default: 10._ If a worker has that many arguments, none will
  be unpacked anymore.
* <b>**-fno-opt-coercion**</b>  
  Turn off the coercion optimiser
* <b>**-fno-pre-inlining**</b>  
  Turn off pre-inlining
* <b>**-fno-state-hack**</b>  
  Turn off the state hackwhereby any lambda with a real-world
  state token as argument is considered to be single-entry. Hence
  OK to inline things inside it.
* <b>**-fomit-interface-pragmas**</b>  
  Don't generate interface pragmas. Implied by **-O0** only.
* <b>**-fomit-yields**</b>  
  Omit heap checks when no allocation is being performed.
* <b>**-foptimal-applicative-do**</b>  
  Use a slower but better algorithm for ApplicativeDo
* <b>**-fpedantic-bottoms**</b>  
  Make GHC be more precise about its treatment of bottom (but see
  also **-fno-state-hack**). In particular, GHC will not
  eta-expand through a case expression.
* <b>**-fregs-graph**</b>  
  Use the graph colouring register allocator for register
  allocation in the native code generator. Implied by **-O2**.
* <b>**-fregs-iterative**</b>  
  Use the iterative coalescing graph colouring register allocator
  in the native code generator.
* <b>**-fsimpl-tick-factor=⟨n⟩**</b>  
  _default: 100._ Set the percentage factor for simplifier ticks.
* <b>**-fsimplifier-phases=⟨n⟩**</b>  
  _default: 2._ Set the number of phases for the simplifier.
  Ignored with **-O0**.
* <b>**-fsolve-constant-dicts**</b>  
  When solving constraints, try to eagerly solve
  super classes using available dictionaries.
* <b>**-fspec-constr**</b>  
  Turn on the SpecConstr transformation. Implied by **-O2**.
* <b>**-fspec-constr-count=⟨n⟩**</b>  
  default: 3.* Set to ⟨n⟩ the maximum number of specialisations that
  will be created for any one function by the SpecConstr
  transformation.
* <b>**-fspec-constr-keen**</b>  
  Specialize a call with an explicit constructor argument,
  even if the argument is not scrutinised in the body of the function
* <b>**-fspec-constr-threshold=⟨n⟩**</b>  
  _default: 2000._ Set the size threshold for the SpecConstr
  transformation to ⟨n⟩.
* <b>**-fspecialise**</b>  
  Turn on specialisation of overloaded functions. Implied by **-O**.
* <b>**-fspecialise-aggressively**</b>  
  Turn on specialisation of overloaded functions regardless of
  size, if unfolding is available
* <b>**-fstatic-argument-transformation**</b>  
  Turn on the static argument transformation.
* <b>**-fstg-cse**</b>  
  Enable common sub-expression elimination on the STG
  intermediate language
* <b>**-fstg-lift-lams**</b>  
  Enable late lambda lifting on the STG intermediate
  language. Implied by **-O2**.
* <b>**-fstg-lift-lams-known**</b>  
  Allow turning known into unknown calls while performing
  late lambda lifting.
* <b>**-fstg-lift-lams-non-rec-args**</b>  
  Create top-level non-recursive functions with at most &lt;n&gt;
  parameters while performing late lambda lifting.
* <b>**-fstg-lift-lams-rec-args**</b>  
  Create top-level recursive functions with at most &lt;n&gt;
  parameters while performing late lambda lifting.
* <b>**-fstrictness**</b>  
  Turn on strictness analysis.
  Implied by **-O**. Implies **-fworker-wrapper**
* <b>**-fstrictness-before=⟨n⟩**</b>  
  Run an additional strictness analysis before simplifier phase ⟨n⟩
* <b>**-funbox-small-strict-fields**</b>  
  Flatten strict constructor fields with a pointer-sized
  representation. Implied by **-O**.
* <b>**-funbox-strict-fields**</b>  
  Flatten strict constructor fields
* <b>**-funfolding-creation-threshold=⟨n⟩**</b>  
  _default: 750._ Tweak unfolding settings.
* <b>**-funfolding-dict-discount=⟨n⟩**</b>  
  _default: 30._ Tweak unfolding settings.
* <b>**-funfolding-fun-discount=⟨n⟩**</b>  
  _default: 60._ Tweak unfolding settings.
* <b>**-funfolding-keeness-factor=⟨n⟩**</b>  
  _default: 1.5._ Tweak unfolding settings.
* <b>**-funfolding-use-threshold=⟨n⟩**</b>  
  _default: 60._ Tweak unfolding settings.
  .UNINDENT

<a name="optimization-levels"></a>

### Optimization levels

.INDENT 0.0

* <b>**-O**</b>  
  Enable level 1 optimisations
* <b>**-O0**</b>  
  Disable optimisations (default)
* <b>**-O2**</b>  
  Enable level 2 optimisations
  .UNINDENT

<a name="package-options"></a>

### Package options

.INDENT 0.0

* <b>**-clear-package-db**</b>  
  Clear the package db stack.
* <b>**-distrust ⟨pkg⟩**</b>  
  Expose package ⟨pkg⟩ and set it to be distrusted. See
  safe-haskell.
* <b>**-distrust-all-packages**</b>  
  Distrust all packages by default. See safe-haskell.
* <b>**-fpackage-trust**</b>  
  Enable Safe Haskell trusted package
  requirement for trustworthy modules.
* <b>**-global-package-db**</b>  
  Add the global package db to the stack.
* <b>**-hide-all-packages**</b>  
  Hide all packages by default
* <b>**-hide-package ⟨pkg⟩**</b>  
  Hide package ⟨pkg⟩
* <b>**-ignore-package ⟨pkg⟩**</b>  
  Ignore package ⟨pkg⟩
* <b>**-no-auto-link-packages**</b>  
  Don't automatically link in the base and rts packages.
* <b>**-no-global-package-db**</b>  
  Remove the global package db from the stack.
* <b>**-no-user-package-db**</b>  
  Remove the user's package db from the stack.
* <b>**-package ⟨pkg⟩**</b>  
  Expose package ⟨pkg⟩
* <b>**-package-db ⟨file⟩**</b>  
  Add ⟨file⟩ to the package db stack.
* <b>**-package-env ⟨file⟩|⟨name⟩**</b>  
  Use the specified package environment.
* <b>**-package-id ⟨unit-id⟩**</b>  
  Expose package by id ⟨unit-id⟩
* <b>**-this-unit-id ⟨unit-id⟩**</b>  
  Compile to be part of unit (i.e. package)
  ⟨unit-id⟩
* <b>**-trust ⟨pkg⟩**</b>  
  Expose package ⟨pkg⟩ and set it to be trusted. See
  safe-haskell.
* <b>**-user-package-db**</b>  
  Add the user's package db to the stack.
  .UNINDENT

<a name="phases-of-compilation"></a>

### Phases of compilation

.INDENT 0.0

* <b>**-C**</b>  
  Stop after generating C (**.hc** file)
* <b>**-c**</b>  
  Stop after generating object (**.o**) file
* <b>**-E**</b>  
  Stop after preprocessing (**.hspp** file)
* <b>**-F**</b>  
  Enable the use of a pre-processor
  (set with **-pgmF ⟨cmd⟩**)
* <b>**-S**</b>  
  Stop after generating assembly (**.s** file)
* <b>**-x ⟨suffix⟩**</b>  
  Override default behaviour for source files
  .UNINDENT

<a name="overriding-external-programs"></a>

### Overriding external programs

.INDENT 0.0

* <b>**-pgma ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the assembler
* <b>**-pgmc ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the C compiler
* <b>**-pgmdll ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the DLL generator
* <b>**-pgmF ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the pre-processor (with **-F** only)
* <b>**-pgmi ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the external interpreter command.
* <b>**-pgmL ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the literate pre-processor
* <b>**-pgml ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the linker
* <b>**-pgmlc ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the LLVM compiler
* <b>**-pgmlibtool ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the command for libtool (with **-staticlib** only).
* <b>**-pgmlo ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the LLVM optimiser
* <b>**-pgmP ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the C pre-processor (with **-cpp** only)
* <b>**-pgms ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the splitter
* <b>**-pgmwindres ⟨cmd⟩**</b>  
  Use ⟨cmd⟩ as the program for embedding manifests on Windows.
  .UNINDENT

<a name="phase-specific-options"></a>

### Phase\-specific options

.INDENT 0.0

* <b>**-opta ⟨option⟩**</b>  
  pass ⟨option⟩ to the assembler
* <b>**-optc ⟨option⟩**</b>  
  pass ⟨option⟩ to the C compiler
* <b>**-optdll ⟨option⟩**</b>  
  pass ⟨option⟩ to the DLL generator
* <b>**-optF ⟨option⟩**</b>  
  pass ⟨option⟩ to the custom pre-processor
* <b>**-opti ⟨option⟩**</b>  
  pass ⟨option⟩ to the interpreter sub-process.
* <b>**-optL ⟨option⟩**</b>  
  pass ⟨option⟩ to the literate pre-processor
* <b>**-optl ⟨option⟩**</b>  
  pass ⟨option⟩ to the linker
* <b>**-optlc ⟨option⟩**</b>  
  pass ⟨option⟩ to the LLVM compiler
* <b>**-optlo ⟨option⟩**</b>  
  pass ⟨option⟩ to the LLVM optimiser
* <b>**-optP ⟨option⟩**</b>  
  pass ⟨option⟩ to cpp (with **-cpp** only)
* <b>**-optwindres ⟨option⟩**</b>  
  pass ⟨option⟩ to **windres**.
  .UNINDENT

<a name="platform-specific-options"></a>

### Platform\-specific options

.INDENT 0.0

* <b>**-msse2**</b>  
  (x86 only) Use SSE2 for floating-point operations
* <b>**-msse4.2**</b>  
  (x86 only) Use SSE4.2 for floating-point operations
  .UNINDENT

<a name="compiler-plugins"></a>

### Compiler plugins

.INDENT 0.0

* <b>**-fclear-plugins**</b>  
  Clear the list of active plugins
* <b>**-fplugin-opt=⟨module⟩:⟨args⟩**</b>  
  Give arguments to a plugin module; module must be specified with
  **-fplugin=⟨module⟩**
* <b>**-fplugin=⟨module⟩**</b>  
  Load a plugin exported by a given module
* <b>**-hide-all-plugin-packages**</b>  
  Hide all packages for plugins by default
* <b>**-plugin-package ⟨pkg⟩**</b>  
  Expose ⟨pkg⟩ for plugins
* <b>**-plugin-package-id ⟨pkg-id⟩**</b>  
  Expose ⟨pkg-id⟩ for plugins
  .UNINDENT

<a name="profiling"></a>

### Profiling

.INDENT 0.0

* <b>**-fno-prof-auto**</b>  
  Disables any previous **-fprof-auto**,
  **-fprof-auto-top**, or **-fprof-auto-exported** options.
* <b>**-fno-prof-cafs**</b>  
  Disables any previous **-fprof-cafs** option.
* <b>**-fno-prof-count-entries**</b>  
  Do not collect entry counts
* <b>**-fprof-auto**</b>  
  Auto-add **SCC**\e s to all bindings not marked INLINE
* <b>**-fprof-auto-calls**</b>  
  Auto-add **SCC**\e s to all call sites
* <b>**-fprof-auto-exported**</b>  
  Auto-add **SCC**\e s to all exported bindings not marked INLINE
* <b>**-fprof-auto-top**</b>  
  Auto-add **SCC**\e s to all top-level bindings not marked INLINE
* <b>**-fprof-cafs**</b>  
  Auto-add **SCC**\e s to all CAFs
* <b>**-prof**</b>  
  Turn on profiling
* <b>**-ticky**</b>  
  Turn on ticky-ticky profiling
  .UNINDENT

<a name="program-coverage"></a>

### Program coverage

.INDENT 0.0

* <b>**-fhpc**</b>  
  Turn on Haskell program coverage instrumentation
  .UNINDENT

<a name="recompilation-checking"></a>

### Recompilation checking

.INDENT 0.0

* <b>**-fforce-recomp**</b>  
  Turn off recompilation checking. This is implied by any
  **-ddump-X** option when compiling a single file
  (i.e. when using **-c**).
* <b>**-fignore-hpc-changes**</b>  
  Do not recompile modules just to match changes to
  HPC flags. This is especially useful for avoiding recompilation
  when using GHCi, and is enabled by default for GHCi.
* <b>**-fignore-optim-changes**</b>  
  Do not recompile modules just to match changes to
  optimisation flags. This is especially useful for avoiding
  recompilation when using GHCi, and is enabled by default for
  GHCi.
  .UNINDENT

<a name="redirecting-output"></a>

### Redirecting output

.INDENT 0.0

* <b>**--exclude-module=⟨file⟩**</b>  
  Regard **⟨file⟩** as "stable"; i.e., exclude it from having
  dependencies on it.
* <b>**-ddump-mod-cycles**</b>  
  Dump module cycles
* <b>**-dep-makefile ⟨file⟩**</b>  
  Use ⟨file⟩ as the makefile
* <b>**-dep-suffix ⟨suffix⟩**</b>  
  Make dependencies that declare that files with suffix
  **.⟨suf⟩⟨osuf⟩** depend on interface files with suffix **.⟨suf⟩hi**
* <b>**-dumpdir ⟨dir⟩**</b>  
  redirect dump files
* <b>**-hcsuf ⟨suffix⟩**</b>  
  set the suffix to use for intermediate C files
* <b>**-hidir ⟨dir⟩**</b>  
  set directory for interface files
* <b>**-hiedir ⟨dir⟩**</b>  
  set directory for extended interface files
* <b>**-hiesuf ⟨suffix⟩**</b>  
  set the suffix to use for extended interface files
* <b>**-hisuf ⟨suffix⟩**</b>  
  set the suffix to use for interface files
* <b>**-include-pkg-deps**</b>  
  Regard modules imported from packages as unstable
* <b>**-o ⟨file⟩**</b>  
  set output filename
* <b>**-odir ⟨dir⟩**</b>  
  set directory for object files
* <b>**-ohi ⟨file⟩**</b>  
  set the filename in which to put the interface
* <b>**-osuf ⟨suffix⟩**</b>  
  set the output file suffix
* <b>**-outputdir ⟨dir⟩**</b>  
  set output directory
* <b>**-stubdir ⟨dir⟩**</b>  
  redirect FFI stub files
  .UNINDENT

<a name="temporary-files"></a>

### Temporary files

.INDENT 0.0

* <b>**-tmpdir ⟨dir⟩**</b>  
  set the directory for temporary files
  .UNINDENT

<a name="verbosity-options"></a>

### Verbosity options

.INDENT 0.0

* <b>**-fabstract-refinement-hole-fits**</b>  
  _default: off._ Toggles whether refinements where one or more
  of the holes are abstract are reported.
* <b>**-fdiagnostics-color=⟨always|auto|never⟩**</b>  
  Use colors in error messages
* <b>**-fdiagnostics-show-caret**</b>  
  Whether to show snippets of original source code
* <b>**-ferror-spans**</b>  
  Output full span in error messages
* <b>**-fhide-source-paths**</b>  
  hide module source and object paths
* <b>**-fmax-refinement-hole-fits=⟨n⟩**</b>  
  _default: 6._ Set the maximum number of refinement hole fits
  for typed holes to display in type error messages.
* <b>**-fmax-relevant-binds=⟨n⟩**</b>  
  _default: 6._ Set the maximum number of bindings to display in
  type error messages.
* <b>**-fmax-valid-hole-fits=⟨n⟩**</b>  
  _default: 6._ Set the maximum number of valid hole fits for
  typed holes to display in type error messages.
* <b>**-fno-show-valid-hole-fits**</b>  
  Disables showing a list of valid hole fits for typed holes
  in type error messages.
* <b>**-fno-sort-valid-hole-fits**</b>  
  Disables the sorting of the list of valid hole fits for typed holes
  in type error messages.
* <b>**-fprint-equality-relations**</b>  
  Distinguish between equality relations when printing
* <b>**-fprint-expanded-synonyms**</b>  
  In type errors, also print type-synonym-expanded types.
* <b>**-fprint-explicit-coercions**</b>  
  Print coercions in types
* <b>**-fprint-explicit-foralls**</b>  
  Print explicit **forall** quantification in types.
  See also **-XExplicitForAll**
* <b>**-fprint-explicit-kinds**</b>  
  Print explicit kind foralls and kind arguments in types.
  See also **-XKindSignatures**
* <b>**-fprint-explicit-runtime-reps**</b>  
  Print **RuntimeRep** variables in types which are
  runtime-representation polymorphic.
* <b>**-fprint-explicit-runtime-reps**</b>  
  Print **RuntimeRep** variables in types which are
  runtime-representation polymorphic.
* <b>**-fprint-potential-instances**</b>  
  display all available instances in type error messages
* <b>**-fprint-typechecker-elaboration**</b>  
  Print extra information from typechecker.
* <b>**-fprint-unicode-syntax**</b>  
  Use unicode syntax when printing expressions, types and kinds.
  See also **-XUnicodeSyntax**
* <b>**-frefinement-level-hole-fits=⟨n⟩**</b>  
  _default: off._ Sets the level of refinement of the
  refinement hole fits, where level **n** means that hole fits
  of up to **n** holes will be considered.
* <b>**-freverse-errors**</b>  
  Output errors in reverse order
* <b>**-fshow-docs-of-hole-fits**</b>  
  Toggles whether to show the documentation of the valid
  hole fits in the output.
* <b>**-fshow-hole-constraints**</b>  
  Show constraints when reporting typed holes.
* <b>**-fshow-hole-matches-of-hole-fits**</b>  
  Toggles whether to show the type of the additional holes
  in refinement hole fits.
* <b>**-fshow-provenance-of-hole-fits**</b>  
  Toggles whether to show the provenance of the valid hole fits
  in the output.
* <b>**-fshow-type-app-of-hole-fits**</b>  
  Toggles whether to show the type application of the valid
  hole fits in the output.
* <b>**-fshow-type-app-vars-of-hole-fits**</b>  
  Toggles whether to show what type each quantified
  variable takes in a valid hole fit.
* <b>**-fshow-type-of-hole-fits**</b>  
  Toggles whether to show the type of the valid hole fits
  in the output.
* <b>**-funclutter-valid-hole-fits**</b>  
  Unclutter the list of valid hole fits by not showing
  provenance nor type applications of suggestions.
* <b>**-Rghc-timing**</b>  
  Summarise timing stats for GHC (same as **+RTS -tstderr**).
* <b>**-v**</b>  
  verbose mode (equivalent to **-v3**)
* <b>**-v⟨n⟩**</b>  
  set verbosity level
  .UNINDENT

<a name="warnings"></a>

### Warnings

.INDENT 0.0

* <b>**-fdefer-out-of-scope-variables**</b>  
  Convert variable out of scope variables errors into warnings.
  Implied by **-fdefer-type-errors**.
  See also **-Wdeferred-out-of-scope-variables**.
* <b>**-fdefer-type-errors**</b>  
  Turn type errors into warnings, deferring the error until
  runtime. Implies
  **-fdefer-typed-holes** and
  **-fdefer-out-of-scope-variables**.
  See also **-Wdeferred-type-errors**
* <b>**-fdefer-typed-holes**</b>  
  Convert typed hole errors into warnings,
  deferring the error until runtime.
  Implied by **-fdefer-type-errors**.
  See also **-Wtyped-holes**.
* <b>**-fhelpful-errors**</b>  
  Make suggestions for mis-spelled names.
* <b>**-fmax-pmcheck-iterations=⟨n⟩**</b>  
  the iteration limit for the pattern match checker
* <b>**-fshow-warning-groups**</b>  
  show which group an emitted warning belongs to.
* <b>**-W**</b>  
  enable normal warnings
* <b>**-w**</b>  
  disable all warnings
* <b>**-Wall**</b>  
  enable almost all warnings (details in options-sanity)
* <b>**-Wall-missed-specialisations**</b>  
  warn when specialisation of any overloaded function fails.
* <b>**-Wcompat**</b>  
  enable future compatibility warnings
  (details in options-sanity)
* <b>**-Wcpp-undef**</b>  
  warn on uses of the _#if_ directive on undefined identifiers
* <b>**-Wdeferred-out-of-scope-variables**</b>  
  Report warnings when variable out-of-scope errors are
  deferred until runtime.
  See **-fdefer-out-of-scope-variables**.
* <b>**-Wdeferred-type-errors**</b>  
  Report warnings when deferred type errors are enabled. This option is enabled by
  default. See **-fdefer-type-errors**.
* <b>**-Wdeprecated-flags**</b>  
  warn about uses of commandline flags that are deprecated
* <b>**-Wdeprecations**</b>  
  warn about uses of functions & types that have warnings or
  deprecated pragmas. Alias for **-Wwarnings-deprecations**
* <b>**-Wdodgy-exports**</b>  
  warn about dodgy exports
* <b>**-Wdodgy-foreign-imports**</b>  
  warn about dodgy foreign imports
* <b>**-Wdodgy-imports**</b>  
  warn about dodgy imports
* <b>**-Wduplicate-constraints**</b>  
  warn when a constraint appears duplicated in a type signature
* <b>**-Wduplicate-exports**</b>  
  warn when an entity is exported multiple times
* <b>**-Wempty-enumerations**</b>  
  warn about enumerations that are empty
* <b>**-Werror**</b>  
  make warnings fatal
* <b>**-Weverything**</b>  
  enable all warnings supported by GHC
* <b>**-Whi-shadowing**</b>  
  warn when a **.hi** file in the current directory shadows a library
* <b>**-Widentities**</b>  
  warn about uses of Prelude numeric conversions that are probably
  the identity (and hence could be omitted)
* <b>**-Wimplicit-kind-vars**</b>  
  warn when kind variables are brought into scope implicitly despite
  the "forall-or-nothing" rule
* <b>**-Wimplicit-prelude**</b>  
  warn when the Prelude is implicitly imported
* <b>**-Winaccessible-code**</b>  
  warn about inaccessible code
* <b>**-Wincomplete-patterns**</b>  
  warn when a pattern match could fail
* <b>**-Wincomplete-record-updates**</b>  
  warn when a record update could fail
* <b>**-Wincomplete-uni-patterns**</b>  
  warn when a pattern match in a lambda expression or
  pattern binding could fail
* <b>**-Winline-rule-shadowing**</b>  
  Warn if a rewrite RULE might fail to fire because the
  function might be inlined before the rule has a chance to fire.
  See rules-inline.
* <b>**-Wmissed-extra-shared-lib**</b>  
  Warn when GHCi can't load a shared lib.
* <b>**-Wmissed-specialisations**</b>  
  warn when specialisation of an imported, overloaded function
  fails.
* <b>**-Wmissing-deriving-strategies**</b>  
  warn when a deriving clause is missing a deriving strategy
* <b>**-Wmissing-export-lists**</b>  
  warn when a module declaration does not explicitly list all
  exports
* <b>**-Wmissing-exported-signatures**</b>  
  warn about top-level functions without signatures, only if they
  are exported. takes precedence over -Wmissing-signatures
* <b>**-Wmissing-exported-sigs**</b>  
  _(deprecated)_
  warn about top-level functions without signatures, only if they
  are exported. takes precedence over -Wmissing-signatures
* <b>**-Wmissing-fields**</b>  
  warn when fields of a record are uninitialised
* <b>**-Wmissing-home-modules**</b>  
  warn when encountering a home module imported, but not listed
  on the command line. Useful for cabal to ensure GHC won't pick
  up modules, not listed neither in **exposed-modules**, nor in
  **other-modules**.
* <b>**-Wmissing-import-lists**</b>  
  warn when an import declaration does not explicitly list all the
  names brought into scope
* <b>**-Wmissing-local-signatures**</b>  
  warn about polymorphic local bindings without signatures
* <b>**-Wmissing-local-sigs**</b>  
  _(deprecated)_
  warn about polymorphic local bindings without signatures
* <b>**-Wmissing-methods**</b>  
  warn when class methods are undefined
* <b>**-Wmissing-monadfail-instances**</b>  
  Warn when a failable pattern is used in a do-block that does
  not have a **MonadFail** instance.
* <b>**-Wmissing-pattern-synonym-signatures**</b>  
  warn when pattern synonyms do not have type signatures
* <b>**-Wmissing-signatures**</b>  
  warn about top-level functions without signatures
* <b>**-Wmonomorphism-restriction**</b>  
  warn when the Monomorphism Restriction is applied
* <b>**-Wname-shadowing**</b>  
  warn when names are shadowed
* <b>**-Wno-compat**</b>  
  Disables all warnings enabled by **-Wcompat**.
* <b>**-Wnoncanonical-monad-instances**</b>  
  warn when **Applicative** or **Monad** instances have
  noncanonical definitions of **return**, **pure**, **(&gt;&gt;)**,
  or **(*&gt;)**.
  See flag description in options-sanity for more details.
* <b>**-Wnoncanonical-monadfail-instances**</b>  
  warn when **Monad** or **MonadFail** instances have
  noncanonical definitions of **fail**.
  See flag description in options-sanity for more details.
* <b>**-Wnoncanonical-monoid-instances**</b>  
  warn when **Semigroup** or **Monoid** instances have
  noncanonical definitions of **(&lt;&gt;)** or **mappend**.
  See flag description in options-sanity for more details.
* <b>**-Worphans**</b>  
  warn when the module contains orphan instance declarations
  or rewrite rules
* <b>**-Woverflowed-literals**</b>  
  warn about literals that will overflow their type
* <b>**-Woverlapping-patterns**</b>  
  warn about overlapping patterns
* <b>**-Wpartial-fields**</b>  
  warn when defining a partial record field.
* <b>**-Wpartial-type-signatures**</b>  
  warn about holes in partial type signatures when
  **-XPartialTypeSignatures** is enabled. Not applicable when
  **-XPartialTypesignatures** is not enabled, in which case
  errors are generated for such holes. See
  partial-type-signatures.
* <b>**-Wredundant-constraints**</b>  
  Have the compiler warn about redundant constraints in type
  signatures.
* <b>**-Wsafe**</b>  
  warn if the module being compiled is regarded to be safe.
* <b>**-Wsemigroup**</b>  
  warn when a **Monoid** is not **Semigroup**, and on non-
  **Semigroup** definitions of **(&lt;&gt;)**?
* <b>**-Wsimplifiable-class-constraints**</b>  
  Warn about class constraints in a type signature that can
  be simplified using a top-level instance declaration.
* <b>**-Wspace-after-bang**</b>  
  warn for missing space before the second argument
  of an infix definition of **(!)** when
  **-XBangPatterns** are not enabled
* <b>**-Wstar-binder**</b>  
  warn about binding the **(*)** type operator despite
  **-XStarIsType**
* <b>**-Wstar-is-type**</b>  
  warn when *** is used to mean Data.Kind.Type**
* <b>**-Wtabs**</b>  
  warn if there are tabs in the source file
* <b>**-Wtrustworthy-safe**</b>  
  warn if the module being compiled is marked as
  **Trustworthy** but it could instead be marked as
  **Safe**, a more informative bound.
* <b>**-Wtype-defaults**</b>  
  warn when defaulting happens
* <b>**-Wtyped-holes**</b>  
  Report warnings when typed hole errors are
  deferred until runtime. See
  **-fdefer-typed-holes**.
* <b>**-Wunbanged-strict-patterns**</b>  
  warn on pattern bind of unlifted variable that is neither bare
  nor banged
* <b>**-Wunrecognised-pragmas**</b>  
  warn about uses of pragmas that GHC doesn't recognise
* <b>**-Wunrecognised-warning-flags**</b>  
  throw a warning when an unreconised **-W...** flag is
  encountered on the command line.
* <b>**-Wunsafe**</b>  
  warn if the module being compiled is regarded to be unsafe.
  See safe-haskell
* <b>**-Wunsupported-calling-conventions**</b>  
  warn about use of an unsupported calling convention
* <b>**-Wunsupported-llvm-version**</b>  
  Warn when using **-fllvm** with an unsupported
  version of LLVM.
* <b>**-Wunticked-promoted-constructors**</b>  
  warn if promoted constructors are not ticked
* <b>**-Wunused-binds**</b>  
  warn about bindings that are unused. Alias for
  **-Wunused-top-binds**, **-Wunused-local-binds** and
  **-Wunused-pattern-binds**
* <b>**-Wunused-do-bind**</b>  
  warn about do bindings that appear to throw away values of types
  other than **()**
* <b>**-Wunused-foralls**</b>  
  warn about type variables in user-written
  **forall**\es that are unused
* <b>**-Wunused-imports**</b>  
  warn about unnecessary imports
* <b>**-Wunused-local-binds**</b>  
  warn about local bindings that are unused
* <b>**-Wunused-matches**</b>  
  warn about variables in patterns that aren't used
* <b>**-Wunused-pattern-binds**</b>  
  warn about pattern match bindings that are unused
* <b>**-Wunused-top-binds**</b>  
  warn about top-level bindings that are unused
* <b>**-Wunused-type-patterns**</b>  
  warn about unused type variables which arise from patterns in
  in type family and data family instances
* <b>**-Wwarn**</b>  
  make warnings non-fatal
* <b>**-Wwarnings-deprecations**</b>  
  warn about uses of functions & types that have warnings or
  deprecated pragmas
* <b>**-Wwrong-do-bind**</b>  
  warn about do bindings that appear to throw away monadic values
  that you should have bound instead
  .UNINDENT

<a name="copyright"></a>

# Copyright


Copyright 2015. The University Court of the University of Glasgow.
All rights reserved.

<a name="author"></a>

# Author

The GHC Team

<a name="copyright"></a>

# Copyright

2020, GHC Team

