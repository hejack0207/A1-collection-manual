# llvm-bcanalyzer(1) - LLVM bitcode analyzer

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

 llvm-bcanalyzer [options] [filename]
```

<a name="description"></a>

# Description


The **llvm-bcanalyzer** command is a small utility for analyzing bitcode
files.  The tool reads a bitcode file (such as generated with the
**llvm-as** tool) and produces a statistical report on the contents of
the bitcode file.  The tool can also dump a low level but human readable
version of the bitcode file.  This tool is probably not of much interest or
utility except for those working directly with the bitcode file format.  Most
LLVM users can just ignore this tool.

If _filename_ is omitted or is **-**, then **llvm-bcanalyzer** reads its
input from standard input.  This is useful for combining the tool into a
pipeline.  Output is written to the standard output.

<a name="options"></a>

# Options

.INDENT 0.0

* **-nodetails**  
  Causes **llvm-bcanalyzer** to abbreviate its output by writing out only
  a module level summary.  The details for individual functions are not
  displayed.
  .UNINDENT
  .INDENT 0.0
* **-dump**  
  Causes **llvm-bcanalyzer** to dump the bitcode in a human readable
  format.  This format is significantly different from LLVM assembly and
  provides details about the encoding of the bitcode file.
  .UNINDENT
  .INDENT 0.0
* **-verify**  
  Causes **llvm-bcanalyzer** to verify the module produced by reading the
  bitcode.  This ensures that the statistics generated are based on a consistent
  module.
  .UNINDENT
  .INDENT 0.0
* **-help**  
  Print a summary of command line options.
  .UNINDENT

<a name="exit-status"></a>

# Exit Status


If **llvm-bcanalyzer** succeeds, it will exit with 0.  Otherwise, if an
error occurs, it will exit with a non-zero value, usually 1.

<a name="summary-output-definitions"></a>

# Summary Output Definitions


The following items are always printed by llvm-bcanalyzer.  They comprize the
summary output.

**Bitcode Analysis Of Module**
.INDENT 0.0
.INDENT 3.5
This just provides the name of the module for which bitcode analysis is being
generated.
.UNINDENT
.UNINDENT

**Bitcode Version Number**
.INDENT 0.0
.INDENT 3.5
The bitcode version (not LLVM version) of the file read by the analyzer.
.UNINDENT
.UNINDENT

**File Size**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of the entire bitcode file.
.UNINDENT
.UNINDENT

**Module Bytes**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of the module block.  Percentage is relative to File Size.
.UNINDENT
.UNINDENT

**Function Bytes**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of all the function blocks.  Percentage is relative to File
Size.
.UNINDENT
.UNINDENT

**Global Types Bytes**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of the Global Types Pool.  Percentage is relative to File
Size.  This is the size of the definitions of all types in the bitcode file.
.UNINDENT
.UNINDENT

**Constant Pool Bytes**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of the Constant Pool Blocks Percentage is relative to File
Size.
.UNINDENT
.UNINDENT

**Module Globals Bytes**
.INDENT 0.0
.INDENT 3.5
Ths size, in bytes, of the Global Variable Definitions and their initializers.
Percentage is relative to File Size.
.UNINDENT
.UNINDENT

**Instruction List Bytes**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of all the instruction lists in all the functions.
Percentage is relative to File Size.  Note that this value is also included in
the Function Bytes.
.UNINDENT
.UNINDENT

**Compaction Table Bytes**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of all the compaction tables in all the functions.
Percentage is relative to File Size.  Note that this value is also included in
the Function Bytes.
.UNINDENT
.UNINDENT

**Symbol Table Bytes**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of all the symbol tables in all the functions.  Percentage is
relative to File Size.  Note that this value is also included in the Function
Bytes.
.UNINDENT
.UNINDENT

**Dependent Libraries Bytes**
.INDENT 0.0
.INDENT 3.5
The size, in bytes, of the list of dependent libraries in the module.  Percentage
is relative to File Size.  Note that this value is also included in the Module
Global Bytes.
.UNINDENT
.UNINDENT

**Number Of Bitcode Blocks**
.INDENT 0.0
.INDENT 3.5
The total number of blocks of any kind in the bitcode file.
.UNINDENT
.UNINDENT

**Number Of Functions**
.INDENT 0.0
.INDENT 3.5
The total number of function definitions in the bitcode file.
.UNINDENT
.UNINDENT

**Number Of Types**
.INDENT 0.0
.INDENT 3.5
The total number of types defined in the Global Types Pool.
.UNINDENT
.UNINDENT

**Number Of Constants**
.INDENT 0.0
.INDENT 3.5
The total number of constants (of any type) defined in the Constant Pool.
.UNINDENT
.UNINDENT

**Number Of Basic Blocks**
.INDENT 0.0
.INDENT 3.5
The total number of basic blocks defined in all functions in the bitcode file.
.UNINDENT
.UNINDENT

**Number Of Instructions**
.INDENT 0.0
.INDENT 3.5
The total number of instructions defined in all functions in the bitcode file.
.UNINDENT
.UNINDENT

**Number Of Long Instructions**
.INDENT 0.0
.INDENT 3.5
The total number of long instructions defined in all functions in the bitcode
file.  Long instructions are those taking greater than 4 bytes.  Typically long
instructions are GetElementPtr with several indices, PHI nodes, and calls to
functions with large numbers of arguments.
.UNINDENT
.UNINDENT

**Number Of Operands**
.INDENT 0.0
.INDENT 3.5
The total number of operands used in all instructions in the bitcode file.
.UNINDENT
.UNINDENT

**Number Of Compaction Tables**
.INDENT 0.0
.INDENT 3.5
The total number of compaction tables in all functions in the bitcode file.
.UNINDENT
.UNINDENT

**Number Of Symbol Tables**
.INDENT 0.0
.INDENT 3.5
The total number of symbol tables in all functions in the bitcode file.
.UNINDENT
.UNINDENT

**Number Of Dependent Libs**
.INDENT 0.0
.INDENT 3.5
The total number of dependent libraries found in the bitcode file.
.UNINDENT
.UNINDENT

**Total Instruction Size**
.INDENT 0.0
.INDENT 3.5
The total size of the instructions in all functions in the bitcode file.
.UNINDENT
.UNINDENT

**Average Instruction Size**
.INDENT 0.0
.INDENT 3.5
The average number of bytes per instruction across all functions in the bitcode
file.  This value is computed by dividing Total Instruction Size by Number Of
Instructions.
.UNINDENT
.UNINDENT

**Maximum Type Slot Number**
.INDENT 0.0
.INDENT 3.5
The maximum value used for a type's slot number.  Larger slot number values take
more bytes to encode.
.UNINDENT
.UNINDENT

**Maximum Value Slot Number**
.INDENT 0.0
.INDENT 3.5
The maximum value used for a value's slot number.  Larger slot number values take
more bytes to encode.
.UNINDENT
.UNINDENT

**Bytes Per Value**
.INDENT 0.0
.INDENT 3.5
The average size of a Value definition (of any type).  This is computed by
dividing File Size by the total number of values of any type.
.UNINDENT
.UNINDENT

**Bytes Per Global**
.INDENT 0.0
.INDENT 3.5
The average size of a global definition (constants and global variables).
.UNINDENT
.UNINDENT

**Bytes Per Function**
.INDENT 0.0
.INDENT 3.5
The average number of bytes per function definition.  This is computed by
dividing Function Bytes by Number Of Functions.
.UNINDENT
.UNINDENT

**# of VBR 32-bit Integers**
.INDENT 0.0
.INDENT 3.5
The total number of 32-bit integers encoded using the Variable Bit Rate
encoding scheme.
.UNINDENT
.UNINDENT

**# of VBR 64-bit Integers**
.INDENT 0.0
.INDENT 3.5
The total number of 64-bit integers encoded using the Variable Bit Rate encoding
scheme.
.UNINDENT
.UNINDENT

**# of VBR Compressed Bytes**
.INDENT 0.0
.INDENT 3.5
The total number of bytes consumed by the 32-bit and 64-bit integers that use
the Variable Bit Rate encoding scheme.
.UNINDENT
.UNINDENT

**# of VBR Expanded Bytes**
.INDENT 0.0
.INDENT 3.5
The total number of bytes that would have been consumed by the 32-bit and 64-bit
integers had they not been compressed with the Variable Bit Rage encoding
scheme.
.UNINDENT
.UNINDENT

**Bytes Saved With VBR**
.INDENT 0.0
.INDENT 3.5
The total number of bytes saved by using the Variable Bit Rate encoding scheme.
The percentage is relative to # of VBR Expanded Bytes.
.UNINDENT
.UNINDENT

<a name="detailed-output-definitions"></a>

# Detailed Output Definitions


The following definitions occur only if the -nodetails option was not given.
The detailed output provides additional information on a per-function basis.

**Type**
.INDENT 0.0
.INDENT 3.5
The type signature of the function.
.UNINDENT
.UNINDENT

**Byte Size**
.INDENT 0.0
.INDENT 3.5
The total number of bytes in the function's block.
.UNINDENT
.UNINDENT

**Basic Blocks**
.INDENT 0.0
.INDENT 3.5
The number of basic blocks defined by the function.
.UNINDENT
.UNINDENT

**Instructions**
.INDENT 0.0
.INDENT 3.5
The number of instructions defined by the function.
.UNINDENT
.UNINDENT

**Long Instructions**
.INDENT 0.0
.INDENT 3.5
The number of instructions using the long instruction format in the function.
.UNINDENT
.UNINDENT

**Operands**
.INDENT 0.0
.INDENT 3.5
The number of operands used by all instructions in the function.
.UNINDENT
.UNINDENT

**Instruction Size**
.INDENT 0.0
.INDENT 3.5
The number of bytes consumed by instructions in the function.
.UNINDENT
.UNINDENT

**Average Instruction Size**
.INDENT 0.0
.INDENT 3.5
The average number of bytes consumed by the instructions in the function.
This value is computed by dividing Instruction Size by Instructions.
.UNINDENT
.UNINDENT

**Bytes Per Instruction**
.INDENT 0.0
.INDENT 3.5
The average number of bytes used by the function per instruction.  This value
is computed by dividing Byte Size by Instructions.  Note that this is not the
same as Average Instruction Size.  It computes a number relative to the total
function size not just the size of the instruction list.
.UNINDENT
.UNINDENT

**Number of VBR 32-bit Integers**
.INDENT 0.0
.INDENT 3.5
The total number of 32-bit integers found in this function (for any use).
.UNINDENT
.UNINDENT

**Number of VBR 64-bit Integers**
.INDENT 0.0
.INDENT 3.5
The total number of 64-bit integers found in this function (for any use).
.UNINDENT
.UNINDENT

**Number of VBR Compressed Bytes**
.INDENT 0.0
.INDENT 3.5
The total number of bytes in this function consumed by the 32-bit and 64-bit
integers that use the Variable Bit Rate encoding scheme.
.UNINDENT
.UNINDENT

**Number of VBR Expanded Bytes**
.INDENT 0.0
.INDENT 3.5
The total number of bytes in this function that would have been consumed by
the 32-bit and 64-bit integers had they not been compressed with the Variable
Bit Rate encoding scheme.
.UNINDENT
.UNINDENT

**Bytes Saved With VBR**
.INDENT 0.0
.INDENT 3.5
The total number of bytes saved in this function by using the Variable Bit
Rate encoding scheme.  The percentage is relative to # of VBR Expanded Bytes.
.UNINDENT
.UNINDENT

<a name="see-also"></a>

# See Also


**llvm-dis(1)**, /BitCodeFormat

<a name="author"></a>

# Author

Maintained by the LLVM Team (https://llvm.org/).

<a name="copyright"></a>

# Copyright

2003-2020, LLVM Project

