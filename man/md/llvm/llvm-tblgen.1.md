# tblgen(1) - Target Description To C++ Code Generator

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

 tblgen [options] [filename]
```

<a name="description"></a>

# Description


**tblgen** translates from target description (**.td**) files into C++
code that can be included in the definition of an LLVM target library.  Most
users of LLVM will not need to use this program.  It is only for assisting with
writing an LLVM target backend.

The input and output of **tblgen** is beyond the scope of this short
introduction; please see the introduction to TableGen.

The _filename_ argument specifies the name of a Target Description (**.td**)
file to read as input.

<a name="options"></a>

# Options

.INDENT 0.0

* **-help**  
  Print a summary of command line options.
  .UNINDENT
  .INDENT 0.0
* **-o filename**  
  Specify the output file name.  If **filename** is **-**, then
  **tblgen** sends its output to standard output.
  .UNINDENT
  .INDENT 0.0
* **-I directory**  
  Specify where to find other target description files for inclusion.  The
  **directory** value should be a full or partial path to a directory that
  contains target description files.
  .UNINDENT
  .INDENT 0.0
* **-asmparsernum N**  
  Make -gen-asm-parser emit assembly writer number **N**.
  .UNINDENT
  .INDENT 0.0
* **-asmwriternum N**  
  Make -gen-asm-writer emit assembly writer number **N**.
  .UNINDENT
  .INDENT 0.0
* **-class className**  
  Print the enumeration list for this class.
  .UNINDENT
  .INDENT 0.0
* **-print-records**  
  Print all records to standard output (default).
  .UNINDENT
  .INDENT 0.0
* **-dump-json**  
  Print a JSON representation of all records, suitable for further
  automated processing.
  .UNINDENT
  .INDENT 0.0
* **-print-enums**  
  Print enumeration values for a class.
  .UNINDENT
  .INDENT 0.0
* **-print-sets**  
  Print expanded sets for testing DAG exprs.
  .UNINDENT
  .INDENT 0.0
* **-gen-emitter**  
  Generate machine code emitter.
  .UNINDENT
  .INDENT 0.0
* **-gen-register-info**  
  Generate registers and register classes info.
  .UNINDENT
  .INDENT 0.0
* **-gen-instr-info**  
  Generate instruction descriptions.
  .UNINDENT
  .INDENT 0.0
* **-gen-asm-writer**  
  Generate the assembly writer.
  .UNINDENT
  .INDENT 0.0
* **-gen-disassembler**  
  Generate disassembler.
  .UNINDENT
  .INDENT 0.0
* **-gen-pseudo-lowering**  
  Generate pseudo instruction lowering.
  .UNINDENT
  .INDENT 0.0
* **-gen-dag-isel**  
  Generate a DAG (Directed Acyclic Graph) instruction selector.
  .UNINDENT
  .INDENT 0.0
* **-gen-asm-matcher**  
  Generate assembly instruction matcher.
  .UNINDENT
  .INDENT 0.0
* **-gen-dfa-packetizer**  
  Generate DFA Packetizer for VLIW targets.
  .UNINDENT
  .INDENT 0.0
* **-gen-fast-isel**  
  Generate a "fast" instruction selector.
  .UNINDENT
  .INDENT 0.0
* **-gen-subtarget**  
  Generate subtarget enumerations.
  .UNINDENT
  .INDENT 0.0
* **-gen-intrinsic-enums**  
  Generate intrinsic enums.
  .UNINDENT
  .INDENT 0.0
* **-gen-intrinsic-impl**  
  Generate intrinsic implementation.
  .UNINDENT
  .INDENT 0.0
* **-gen-tgt-intrinsic**  
  Generate target intrinsic information.
  .UNINDENT
  .INDENT 0.0
* **-gen-enhanced-disassembly-info**  
  Generate enhanced disassembly info.
  .UNINDENT
  .INDENT 0.0
* **-gen-exegesis**  
  Generate llvm-exegesis tables.
  .UNINDENT
  .INDENT 0.0
* **-version**  
  Show the version number of this program.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


If **tblgen** succeeds, it will exit with 0.  Otherwise, if an error
occurs, it will exit with a non-zero value.

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

