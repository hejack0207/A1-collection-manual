# llvm-dwarfdump(1) - dump and verify DWARF debug information

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

```

 llvm-dwarfdump [options] [filename ...]
```

<a name="description"></a>

# Description


**llvm-dwarfdump** parses DWARF sections in object files,
archives, and _.dSYM_ bundles and prints their contents in
human-readable form. Only the .debug_info section is printed unless one of
the section-specific options or _--all_ is specified.

If no input file is specified, _a.out_ is used instead. If _-_ is used as the
input file, **llvm-dwarfdump** reads the input from its standard input
stream.

<a name="options"></a>

# Options

.INDENT 0.0

* **-a, --all**  
  Dump all supported DWARF sections.
  .UNINDENT
  .INDENT 0.0
* **--arch=&lt;arch&gt;**  
  Dump DWARF debug information for the specified CPU architecture.
  Architectures may be specified by name or by number.  This
  option can be specified multiple times, once for each desired
  architecture.  All CPU architectures will be printed by
  default.
  .UNINDENT
  .INDENT 0.0
* **-c, --show-children**  
  Show a debug info entry's children when selectively printing with
  the _=&lt;offset&gt;_ argument of _--debug-info_, or options such
  as _--find_ or _--name_.
  .UNINDENT
  .INDENT 0.0
* **--color**  
  Use colors in output.
  .UNINDENT
  .INDENT 0.0
* **-f &lt;name&gt;, --find=&lt;name&gt;**  
  Search for the exact text &lt;name&gt; in the accelerator tables
  and print the matching debug information entries.
  When there is no accelerator tables or the name of the DIE
  you are looking for is not found in the accelerator tables,
  try using the slower but more complete _--name_ option.
  .UNINDENT
  .INDENT 0.0
* **-F, --show-form**  
  Show DWARF form types after the DWARF attribute types.
  .UNINDENT
  .INDENT 0.0
* **-h, --help**  
  Show help and usage for this command.
  .UNINDENT
  .INDENT 0.0
* **--help-list**  
  Show help and usage for this command without grouping the options
  into categories.
  .UNINDENT
  .INDENT 0.0
* **-i, --ignore-case**  
  Ignore case distinctions when using _--name_.
  .UNINDENT
  .INDENT 0.0
* **-n &lt;name&gt;, --name=&lt;name&gt;**  
  Find and print all debug info entries whose name
  (_DW\_AT\_name_ attribute) is &lt;name&gt;.
  .UNINDENT
  .INDENT 0.0
* **--lookup=&lt;address&gt;**  
  Look up &lt;address&gt; in the debug information and print out the file,
  function, block, and line table details.
  .UNINDENT
  .INDENT 0.0
* **-o &lt;path&gt;**  
  Redirect output to a file specified by &lt;path&gt;, where _-_ is the
  standard output stream.
  .UNINDENT
  .INDENT 0.0
* **-p, --show-parents**  
  Show a debug info entry's parents when selectively printing with
  the _=&lt;offset&gt;_ argument of _--debug-info_, or options such
  as _--find_ or _--name_.
  .UNINDENT
  .INDENT 0.0
* **--parent-recurse-depth=&lt;N&gt;**  
  When displaying debug info entry parents, only show them to a
  maximum depth of &lt;N&gt;.
  .UNINDENT
  .INDENT 0.0
* **--quiet**  
  Use with _--verify_ to not emit to _STDOUT_.
  .UNINDENT
  .INDENT 0.0
* **-r &lt;N&gt;, --recurse-depth=&lt;N&gt;**  
  When displaying debug info entries, only show children to a maximum
  depth of &lt;N&gt;.
  .UNINDENT
  .INDENT 0.0
* **--show-section-sizes**  
  Show the sizes of all debug sections, expressed in bytes.
  .UNINDENT
  .INDENT 0.0
* **--statistics**  
  Collect debug info quality metrics and print the results
  as machine-readable single-line JSON output. The output
  format is described in the section below (_FORMAT OF STATISTICS OUTPUT_).
  .UNINDENT
  .INDENT 0.0
* **--summarize-types**  
  Abbreviate the description of type unit entries.
  .UNINDENT
  .INDENT 0.0
* **-x, --regex**  
  Treat any &lt;name&gt; strings as regular expressions when searching
  with _--name_. If _--ignore-case_ is also specified,
  the regular expression becomes case-insensitive.
  .UNINDENT
  .INDENT 0.0
* **-u, --uuid**  
  Show the UUID for each architecture.
  .UNINDENT
  .INDENT 0.0
* **--diff**  
  Dump the output in a format that is more friendly for comparing
  DWARF output from two different files.
  .UNINDENT
  .INDENT 0.0
* **-v, --verbose**  
  Display verbose information when dumping. This can help to debug
  DWARF issues.
  .UNINDENT
  .INDENT 0.0
* **--verify**  
  Verify the structure of the DWARF information by verifying the
  compile unit chains, DIE relationships graph, address
  ranges, and more.
  .UNINDENT
  .INDENT 0.0
* **--version**  
  Display the version of the tool.
  .UNINDENT
  .INDENT 0.0
* **--debug-abbrev, --debug-addr, --debug-aranges, --debug-cu-index, --debug-frame[=&lt;offset&gt;], --debug-gnu-pubnames, --debug-gnu-pubtypes, --debug-info [=&lt;offset&gt;], --debug-line [=&lt;offset&gt;], --debug-line-str, --debug-loc [=&lt;offset&gt;], --debug-loclists [=&lt;offset&gt;], --debug-macro, --debug-names, --debug-pubnames, --debug-pubtypes, --debug-ranges, --debug-rnglists, --debug-str, --debug-str-offsets, --debug-tu-index, --debug-types [=&lt;offset&gt;], --eh-frame [=&lt;offset&gt;], --gdb-index, --apple-names, --apple-types, --apple-namespaces, --apple-objc**  
  Dump the specified DWARF section by name. Only the
  _.debug\_info_ section is shown by default. Some entries
  support adding an _=&lt;offset&gt;_ as a way to provide an
  optional offset of the exact entry to dump within the
  respective section. When an offset is provided, only the
  entry at that offset will be dumped, else the entire
  section will be dumped.
  .UNINDENT
  .INDENT 0.0
* **@&lt;FILE&gt;**  
  Read command-line options from _&lt;FILE&gt;_.
  .UNINDENT

<a name="format-of-statistics-output"></a>

# Format of Statistics Output


The :_--statistics_ option generates single-line JSON output
representing quality metrics of the processed debug info. These metrics are
useful to compare changes between two compilers, particularly for judging
the effect that a change to the compiler has on the debug info quality.

The output is formatted as key-value pairs. The first pair contains a version
number. The following naming scheme is used for the keys:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  _variables_ ==&gt; local variables and parameters
* ·  
  _local vars_ ==&gt; local variables
* ·  
  _params_ ==&gt; formal parameters
  .UNINDENT
  .UNINDENT
  .UNINDENT

For aggregated values, the following keys are used:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  _sum\_of\_all\_variables(...)_ ==&gt; the sum applied to all variables
* ·  
  _#bytes_ ==&gt; the number of bytes
* ·  
  _#variables - entry values ..._ ==&gt; the number of variables excluding
  the entry values etc.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


**llvm-dwarfdump** returns 0 if the input files were parsed and dumped
successfully. Otherwise, it returns 1.

<a name="see-also"></a>

# See Also


**dsymutil(1)**

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

