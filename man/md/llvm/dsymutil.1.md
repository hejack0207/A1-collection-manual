# dsymutil(1) - manipulate archived DWARF debug symbol files

11, 2020-10-15

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

    dsymutil [options] executable
```


```

<a name="description"></a>

# Description


**dsymutil** links the DWARF debug information found in the object files
for an executable _executable_ by using debug symbols information contained in
its symbol table. By default, the linked debug information is placed in a
**.dSYM** bundle with the same name as the executable.

<a name="options"></a>

# Options

.INDENT 0.0

* **--accelerator=&lt;accelerator type&gt;**  
  Specify the desired type of accelerator table. Valid options are 'Apple',
  'Dwarf' and 'Default'.
  .UNINDENT
  .INDENT 0.0
* **--arch &lt;arch&gt;**  
  Link DWARF debug information only for specified CPU architecture types.
  Architectures may be specified by name. When using this option, an error will
  be returned if any architectures can not be properly linked.  This option can
  be specified multiple times, once for each desired architecture. All CPU
  architectures will be linked by default and any architectures that can't be
  properly linked will cause **dsymutil** to return an error.
  .UNINDENT
  .INDENT 0.0
* **--dump-debug-map**  
  Dump the _executable_'s debug-map (the list of the object files containing the
  debug information) in YAML format and exit. Not DWARF link will take place.
  .UNINDENT
  .INDENT 0.0
* **--flat, -f**  
  Produce a flat dSYM file. A **.dwarf** extension will be appended to the
  executable name unless the output file is specified using the **-o** option.
  .UNINDENT
  .INDENT 0.0
* **--gen-reproducer**  
  Generate a reproducer consisting of the input object files.
  .UNINDENT
  .INDENT 0.0
* **--help, -h**  
  Print this help output.
  .UNINDENT
  .INDENT 0.0
* **--minimize, -z**  
  When used when creating a dSYM file, this option will suppress the emission of
  the .debug_inlines, .debug_pubnames, and .debug_pubtypes sections since
  dsymutil currently has better equivalents: .apple_names and .apple_types. When
  used in conjunction with **--update** option, this option will cause redundant
  accelerator tables to be removed.
  .UNINDENT
  .INDENT 0.0
* **--no-odr**  
  Do not use ODR (One Definition Rule) for uniquing C++ types.
  .UNINDENT
  .INDENT 0.0
* **--no-output**  
  Do the link in memory, but do not emit the result file.
  .UNINDENT
  .INDENT 0.0
* **--no-swiftmodule-timestamp**  
  Don't check the timestamp for swiftmodule files.
  .UNINDENT
  .INDENT 0.0
* **--num-threads &lt;threads&gt;, -j &lt;threads&gt;**  
  Specifies the maximum number (**n**) of simultaneous threads to use when
  linking multiple architectures.
  .UNINDENT
  .INDENT 0.0
* **--object-prefix-map &lt;prefix=remapped&gt;**  
  Remap object file paths (but no source paths) before processing.  Use
  this for Clang objects where the module cache location was remapped using
  **-fdebug-prefix-map**; to help dsymutil find the Clang module cache.
  .UNINDENT
  .INDENT 0.0
* **--oso-prepend-path &lt;path&gt;**  
  Specifies a **path** to prepend to all debug symbol object file paths.
  .UNINDENT
  .INDENT 0.0
* **--out &lt;filename&gt;, -o &lt;filename&gt;**  
  Specifies an alternate **path** to place the dSYM bundle. The default dSYM
  bundle path is created by appending **.dSYM** to the executable name.
  .UNINDENT
  .INDENT 0.0
* **--papertrail**  
  When running dsymutil as part of your build system, it can be desirable for
  warnings to be part of the end product, rather than just being emitted to the
  output stream. When enabled warnings are embedded in the linked DWARF debug
  information.
  .UNINDENT
  .INDENT 0.0
* **--remarks-output-format &lt;format&gt;**  
  Specify the format to be used when serializing the linked remarks.
  .UNINDENT
  .INDENT 0.0
* **--remarks-prepend-path &lt;path&gt;**  
  Specify a directory to prepend the paths of the external remark files.
  .UNINDENT
  .INDENT 0.0
* **--statistics**  
  Print statistics about the contribution of each object file to the linked
  debug info. This prints a table after linking with the object file name, the
  size of the debug info in the object file (in bytes) and the size contributed
  (in bytes) to the linked dSYM. The table is sorted by the output size listing
  the obj ect files with the largest contribution first.
  .UNINDENT
  .INDENT 0.0
* **--symbol-map &lt;bcsymbolmap&gt;**  
  Update the existing dSYMs inplace using symbol map specified.
  .UNINDENT
  .INDENT 0.0
* **-s, --symtab**  
  Dumps the symbol table found in _executable_ or object file(s) and exits.
  .UNINDENT
  .INDENT 0.0
* **-S**  
  Output textual assembly instead of a binary dSYM companion file.
  .UNINDENT
  .INDENT 0.0
* **--toolchain &lt;toolchain&gt;**  
  Embed the toolchain in the dSYM bundle's property list.
  .UNINDENT
  .INDENT 0.0
* **-u, --update**  
  Update an existing dSYM file to contain the latest accelerator tables and
  other DWARF optimizations. This option will rebuild the '.apple_names' and
  '.apple_types' hashed accelerator tables.
  .UNINDENT
  .INDENT 0.0
* **--use-reproducer &lt;path&gt;**  
  Use the object files from the given reproducer path.
  .UNINDENT
  .INDENT 0.0
* **--verbose**  
  Display verbose information when linking.
  .UNINDENT
  .INDENT 0.0
* **--verify**  
  Run the DWARF verifier on the linked DWARF debug info.
  .UNINDENT
  .INDENT 0.0
* **-v, --version**  
  Display the version of the tool.
  .UNINDENT
  .INDENT 0.0
* **-y**  
  Treat _executable_ as a YAML debug-map rather than an executable.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**dsymutil** returns 0 if the DWARF debug information was linked
successfully. Otherwise, it returns 1.

<a name="see-also"></a>

# See Also


**llvm-dwarfdump(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

