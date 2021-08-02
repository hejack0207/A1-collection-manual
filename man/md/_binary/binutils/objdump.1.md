# objdump(1)

binutils-2.30.90, 2018-07-09

.if n .ad l
.nh

<a name="name"></a>

# Name

objdump - display information from object files.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" objdump [-a|--archive-headers]         [-b bfdname|--target=bfdname]         [-C|--demangle[=style] ]         [-d|--disassemble]         [-D|--disassemble-all]         [-z|--disassemble-zeroes]         [-EB|-EL|--endian={big | little }]         [-f|--file-headers]         [-F|--file-offsets]         [--file-start-context]         [-g|--debugging]         [-e|--debugging-tags]         [-h|--section-headers|--headers]         [-i|--info]         [-j section|--section=section]         [-l|--line-numbers]         [-S|--source]         [-m machine|--architecture=machine]         [-M options|--disassembler-options=options]         [-p|--private-headers]         [-P options|--private=options]         [-r|--reloc]         [-R|--dynamic-reloc]         [-s|--full-contents]         [-W[lLiaprmfFsoRtUuTgAckK]|          --dwarf[=rawline,=decodedline,=info,=abbrev,=pubnames,=aranges,=macro,=frames,=frames-interp,=str,=loc,=Ranges,=pubtypes,=trace_info,=trace_abbrev,=trace_aranges,=gdb_index,=addr,=cu_index,=links,=follow-links]]         [-G|--stabs]         [-t|--syms]         [-T|--dynamic-syms]         [-x|--all-headers]         [-w|--wide]         [--start-address=address]         [--stop-address=address]         [--prefix-addresses]         [--[no-]show-raw-insn]         [--adjust-vma=offset]         [--dwarf-depth=n]         [--dwarf-start=n]         [--special-syms]         [--prefix=prefix]         [--prefix-strip=level]         [--insn-width=width]         [-V|--version]         [-H|--help]         objfile...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**objdump** displays information about one or more object files.
The options control what particular information to display.  This
information is mostly useful to programmers who are working on the
compilation tools, as opposed to programmers who just want their
program to compile and work.

_objfile_... are the object files to be examined.  When you
specify archives, **objdump** shows information on each of the member
object files.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The long and short forms of options, shown here as alternatives, are
equivalent.  At least one option from the list
**-a,-d,-D,-e,-f,-g,-G,-h,-H,-p,-P,-r,-R,-s,-S,-t,-T,-V,-x** must be given.

* **-a**  
  .IX Item "-a"
* **--archive-header**  
  .IX Item "--archive-header"
  If any of the _objfile_ files are archives, display the archive
  header information (in a format similar to **ls -l**).  Besides the
  information you could list with **ar tv**, **objdump -a** shows
  the object file format of each archive member.
* **--adjust-vma=**_offset_  
  .IX Item "--adjust-vma=offset"
  When dumping information, first add _offset_ to all the section
  addresses.  This is useful if the section addresses do not correspond to
  the symbol table, which can happen when putting sections at particular
  addresses when using a format which can not represent section addresses,
  such as a.out.
* **-b** _bfdname_  
  .IX Item "-b bfdname"
* **--target=**_bfdname_  
  .IX Item "--target=bfdname"
  Specify that the object-code format for the object files is
  _bfdname_.  This option may not be necessary; _objdump_ can
  automatically recognize many formats.
  .Sp
  For example,
  .Sp
  .Vb 1
          objdump -b oasys -m vax -h fu.o
  .Ve
  .Sp
  displays summary information from the section headers (**-h**) of
  _fu.o_, which is explicitly identified (**-m**) as a \s-1VAX\s0 object
  file in the format produced by Oasys compilers.  You can list the
  formats available with the **-i** option.
* **-C**  
  .IX Item "-C"
* **--demangle[=**_style_**]**  
  .IX Item "--demangle[=style]"
  Decode (_demangle_) low-level symbol names into user-level names.
  Besides removing any initial underscore prepended by the system, this
  makes  function names readable.  Different compilers have different
  mangling styles. The optional demangling style argument can be used to
  choose an appropriate demangling style for your compiler.
* **-g**  
  .IX Item "-g"
* **--debugging**  
  .IX Item "--debugging"
  Display debugging information.  This attempts to parse \s-1STABS\s0
  debugging format information stored in the file and print it out using
  a C like syntax.  If no \s-1STABS\s0 debuging was found this option
  falls back on the **-W** option to print any \s-1DWARF\s0 information in
  the file.
* **-e**  
  .IX Item "-e"
* **--debugging-tags**  
  .IX Item "--debugging-tags"
  Like **-g**, but the information is generated in a format compatible
  with ctags tool.
* **-d**  
  .IX Item "-d"
* **--disassemble**  
  .IX Item "--disassemble"
  Display the assembler mnemonics for the machine instructions from
  _objfile_.  This option only disassembles those sections which are
  expected to contain instructions.
* **-D**  
  .IX Item "-D"
* **--disassemble-all**  
  .IX Item "--disassemble-all"
  Like **-d**, but disassemble the contents of all sections, not just
  those expected to contain instructions.
  .Sp
  This option also has a subtle effect on the disassembly of
  instructions in code sections.  When option **-d** is in effect
  objdump will assume that any symbols present in a code section occur
  on the boundary between instructions and it will refuse to disassemble
  across such a boundary.  When option **-D** is in effect however
  this assumption is supressed.  This means that it is possible for the
  output of **-d** and **-D** to differ if, for example, data
  is stored in code sections.
  .Sp
  If the target is an \s-1ARM\s0 architecture this switch also has the effect
  of forcing the disassembler to decode pieces of data found in code
  sections as if they were instructions.
* **--prefix-addresses**  
  .IX Item "--prefix-addresses"
  When disassembling, print the complete address on each line.  This is
  the older disassembly format.
* **-EB**  
  .IX Item "-EB"
* **-EL**  
  .IX Item "-EL"
* **--endian={big|little}**  
  .IX Item "--endian={big|little}"
  Specify the endianness of the object files.  This only affects
  disassembly.  This can be useful when disassembling a file format which
  does not describe endianness information, such as S-records.
* **-f**  
  .IX Item "-f"
* **--file-headers**  
  .IX Item "--file-headers"
  Display summary information from the overall header of
  each of the _objfile_ files.
* **-F**  
  .IX Item "-F"
* **--file-offsets**  
  .IX Item "--file-offsets"
  When disassembling sections, whenever a symbol is displayed, also
  display the file offset of the region of data that is about to be
  dumped.  If zeroes are being skipped, then when disassembly resumes,
  tell the user how many zeroes were skipped and the file offset of the
  location from where the disassembly resumes.  When dumping sections,
  display the file offset of the location from where the dump starts.
* **--file-start-context**  
  .IX Item "--file-start-context"
  Specify that when displaying interlisted source code/disassembly
  (assumes **-S**) from a file that has not yet been displayed, extend the
  context to the start of the file.
* **-h**  
  .IX Item "-h"
* **--section-headers**  
  .IX Item "--section-headers"
* **--headers**  
  .IX Item "--headers"
  Display summary information from the section headers of the
  object file.
  .Sp
  File segments may be relocated to nonstandard addresses, for example by
  using the **-Ttext**, **-Tdata**, or **-Tbss** options to
  **ld**.  However, some object file formats, such as a.out, do not
  store the starting address of the file segments.  In those situations,
  although **ld** relocates the sections correctly, using objdump
  -h to list the file section headers cannot show the correct addresses.
  Instead, it shows the usual addresses, which are implicit for the
  target.
  .Sp
  Note, in some cases it is possible for a section to have both the
  \s-1READONLY\s0 and the \s-1NOREAD\s0 attributes set.  In such cases the \s-1NOREAD\s0
  attribute takes precedence, but **objdump** will report both
  since the exact setting of the flag bits might be important.
* **-H**  
  .IX Item "-H"
* **--help**  
  .IX Item "--help"
  Print a summary of the options to **objdump** and exit.
* **-i**  
  .IX Item "-i"
* **--info**  
  .IX Item "--info"
  Display a list showing all architectures and object formats available
  for specification with **-b** or **-m**.
* **-j** _name_  
  .IX Item "-j name"
* **--section=**_name_  
  .IX Item "--section=name"
  Display information only for section _name_.
* **-l**  
  .IX Item "-l"
* **--line-numbers**  
  .IX Item "--line-numbers"
  Label the display (using debugging information) with the filename and
  source line numbers corresponding to the object code or relocs shown.
  Only useful with **-d**, **-D**, or **-r**.
* **-m** _machine_  
  .IX Item "-m machine"
* **--architecture=**_machine_  
  .IX Item "--architecture=machine"
  Specify the architecture to use when disassembling object files.  This
  can be useful when disassembling object files which do not describe
  architecture information, such as S-records.  You can list the available
  architectures with the **-i** option.
  .Sp
  If the target is an \s-1ARM\s0 architecture then this switch has an
  additional effect.  It restricts the disassembly to only those
  instructions supported by the architecture specified by _machine_.
  If it is necessary to use this switch because the input file does not
  contain any architecture information, but it is also desired to
  disassemble all the instructions use **-marm**.
* **-M** _options_  
  .IX Item "-M options"
* **--disassembler-options=**_options_  
  .IX Item "--disassembler-options=options"
  Pass target specific information to the disassembler.  Only supported on
  some targets.  If it is necessary to specify more than one
  disassembler option then multiple **-M** options can be used or
  can be placed together into a comma separated list.
  .Sp
  For \s-1ARC,\s0 **dsp** controls the printing of \s-1DSP\s0 instructions,
  **spfp** selects the printing of \s-1FPX\s0 single precision \s-1FP\s0
  instructions, **dpfp** selects the printing of \s-1FPX\s0 double
  precision \s-1FP\s0 instructions, **quarkse\_em** selects the printing of
  special QuarkSE-EM instructions, **fpuda** selects the printing
  of double precision assist instructions, **fpus** selects the
  printing of \s-1FPU\s0 single precision \s-1FP\s0 instructions, while **fpud**
  selects the printing of \s-1FPU\s0 double precision \s-1FP\s0 instructions.
  Additionally, one can choose to have all the immediates printed in
  hexadecimal using **hex**.  By default, the short immediates are
  printed using the decimal representation, while the long immediate
  values are printed as hexadecimal.
  .Sp
  **cpu=...** allows to enforce a particular \s-1ISA\s0 when disassembling
  instructions, overriding the **-m** value or whatever is in the \s-1ELF\s0 file.
  This might be useful to select \s-1ARC EM\s0 or \s-1HS ISA,\s0 because architecture is same
  for those and disassembler relies on private \s-1ELF\s0 header data to decide if code
  is for \s-1EM\s0 or \s-1HS.\s0  This option might be specified multiple times - only the
  latest value will be used.  Valid values are same as for the assembler
  **-mcpu=...** option.
  .Sp
  If the target is an \s-1ARM\s0 architecture then this switch can be used to
  select which register name set is used during disassembler.  Specifying
  **-M reg-names-std** (the default) will select the register names as
  used in \s-1ARM\s0's instruction set documentation, but with register 13 called
  'sp', register 14 called 'lr' and register 15 called 'pc'.  Specifying
  **-M reg-names-apcs** will select the name set used by the \s-1ARM\s0
  Procedure Call Standard, whilst specifying **-M reg-names-raw** will
  just use **r** followed by the register number.
  .Sp
  There are also two variants on the \s-1APCS\s0 register naming scheme enabled
  by **-M reg-names-atpcs** and **-M reg-names-special-atpcs** which
  use the ARM/Thumb Procedure Call Standard naming conventions.  (Either
  with the normal register names or the special register names).
  .Sp
  This option can also be used for \s-1ARM\s0 architectures to force the
  disassembler to interpret all instructions as Thumb instructions by
  using the switch **--disassembler-options=force-thumb**.  This can be
  useful when attempting to disassemble thumb code produced by other
  compilers.
  .Sp
  For AArch64 targets this switch can be used to set whether instructions are
  disassembled as the most general instruction using the **-M no-aliases**
  option or whether instruction notes should be generated as comments in the
  disasssembly using **-M notes**.
  .Sp
  For the x86, some of the options duplicate functions of the **-m**
  switch, but allow finer grained control.  Multiple selections from the
  following may be specified as a comma separated string.
      .ie n .IP """x86-64""" 4
      .el .IP "\f(CWx86-64" 4
      .IX Item "x86-64"
      .ie n .IP """i386""" 4
      .el .IP "\f(CWi386" 4
      .IX Item "i386"
      .ie n .IP """i8086""" 4
      .el .IP "\f(CWi8086" 4
      .IX Item "i8086"
      Select disassembly for the given architecture.
      .ie n .IP """intel""" 4
      .el .IP "\f(CWintel" 4
      .IX Item "intel"
      .ie n .IP """att""" 4
      .el .IP "\f(CWatt" 4
      .IX Item "att"
      Select between intel syntax mode and \s-1AT&T\s0 syntax mode.
      .ie n .IP """amd64""" 4
      .el .IP "\f(CWamd64" 4
      .IX Item "amd64"
      .ie n .IP """intel64""" 4
      .el .IP "\f(CWintel64" 4
      .IX Item "intel64"
      Select between \s-1AMD64 ISA\s0 and Intel64 \s-1ISA.\s0
      .ie n .IP """intel-mnemonic""" 4
      .el .IP "\f(CWintel-mnemonic" 4
      .IX Item "intel-mnemonic"
      .ie n .IP """att-mnemonic""" 4
      .el .IP "\f(CWatt-mnemonic" 4
      .IX Item "att-mnemonic"
      Select between intel mnemonic mode and \s-1AT&T\s0 mnemonic mode.
      Note: \f(CW`intel-mnemonic\*(C' implies \f(CW\*(C\`intel\*(C' and
      \f(CW`att-mnemonic\*(C' implies \f(CW\*(C\`att\*(C'.
      .ie n .IP """addr64""" 4
      .el .IP "\f(CWaddr64" 4
      .IX Item "addr64"
      .ie n .IP """addr32""" 4
      .el .IP "\f(CWaddr32" 4
      .IX Item "addr32"
      .ie n .IP """addr16""" 4
      .el .IP "\f(CWaddr16" 4
      .IX Item "addr16"
      .ie n .IP """data32""" 4
      .el .IP "\f(CWdata32" 4
      .IX Item "data32"
      .ie n .IP """data16""" 4
      .el .IP "\f(CWdata16" 4
      .IX Item "data16"
      Specify the default address size and operand size.  These four options
      will be overridden if \f(CW`x86-64\*(C', \f(CW\*(C\`i386\*(C' or \f(CW\*(C\`i8086\*(C'
      appear later in the option string.
      .ie n .IP """suffix""" 4
      .el .IP "\f(CWsuffix" 4
      .IX Item "suffix"
      When in \s-1AT&T\s0 mode, instructs the disassembler to print a mnemonic
      suffix even when the suffix could be inferred by the operands.
      .Sp
      For PowerPC, the **-M** argument **raw** selects
      disasssembly of hardware insns rather than aliases.  For example, you
      will see \f(CW`rlwinm\*(C' rather than \f(CW\*(C\`clrlwi\*(C', and \f(CW\*(C\`addi\*(C'
      rather than \f(CW`li\*(C'.  All of the **-m** arguments for
      **gas** that select a \s-1CPU\s0 are supported.  These are:
      **403**, **405**, **440**, **464**, **476**,
      **601**, **603**, **604**, **620**, **7400**,
      **7410**, **7450**, **7455**, **750cl**,
      **821**, **850**, **860**, **a2**, **booke**,
      **booke32**, **cell**, **com**, **e200z4**,
      **e300**, **e500**, **e500mc**, **e500mc64**,
      **e500x2**, **e5500**, **e6500**, **efs**,
      **power4**, **power5**, **power6**, **power7**,
      **power8**, **power9**, **ppc**, **ppc32**,
      **ppc64**, **ppc64bridge**, **ppcps**, **pwr**,
      **pwr2**, **pwr4**, **pwr5**, **pwr5x**,
      **pwr6**, **pwr7**, **pwr8**, **pwr9**,
      **pwrx**, **titan**, and **vle**.
      **32** and **64** modify the default or a prior \s-1CPU\s0
      selection, disabling and enabling 64-bit insns respectively.  In
      addition, **altivec**, **any**, **htm**, **vsx**,
      and **spe** add capabilities to a previous _or later_ \s-1CPU\s0
      selection.  **any** will disassemble any opcode known to
      binutils, but in cases where an opcode has two different meanings or
      different arguments, you may not see the disassembly you expect.
      If you disassemble without giving a \s-1CPU\s0 selection, a default will be
      chosen from information gleaned by \s-1BFD\s0 from the object files headers,
      but the result again may not be as you expect.
      .Sp
      For \s-1MIPS,\s0 this option controls the printing of instruction mnemonic
      names and register names in disassembled instructions.  Multiple
      selections from the following may be specified as a comma separated
      string, and invalid options are ignored:
      .ie n .IP """no-aliases""" 4
      .el .IP "\f(CWno-aliases" 4
      .IX Item "no-aliases"
      Print the 'raw' instruction mnemonic instead of some pseudo
      instruction mnemonic.  I.e., print 'daddu' or 'or' instead of 'move',
      'sll' instead of 'nop', etc.
      .ie n .IP """msa""" 4
      .el .IP "\f(CWmsa" 4
      .IX Item "msa"
      Disassemble \s-1MSA\s0 instructions.
      .ie n .IP """virt""" 4
      .el .IP "\f(CWvirt" 4
      .IX Item "virt"
      Disassemble the virtualization \s-1ASE\s0 instructions.
      .ie n .IP """xpa""" 4
      .el .IP "\f(CWxpa" 4
      .IX Item "xpa"
      Disassemble the eXtended Physical Address (\s-1XPA\s0) \s-1ASE\s0 instructions.
      .ie n .IP """gpr-names=_ABI_""" 4
      .el .IP "\f(CWgpr-names=\f(CIABI\f(CW" 4
      .IX Item "gpr-names=ABI"
      Print \s-1GPR\s0 (general-purpose register) names as appropriate
      for the specified \s-1ABI.\s0  By default, \s-1GPR\s0 names are selected according to
      the \s-1ABI\s0 of the binary being disassembled.
      .ie n .IP """fpr-names=_ABI_""" 4
      .el .IP "\f(CWfpr-names=\f(CIABI\f(CW" 4
      .IX Item "fpr-names=ABI"
      Print \s-1FPR\s0 (floating-point register) names as
      appropriate for the specified \s-1ABI.\s0  By default, \s-1FPR\s0 numbers are printed
      rather than names.
      .ie n .IP """cp0-names=_ARCH_""" 4
      .el .IP "\f(CWcp0-names=\f(CIARCH\f(CW" 4
      .IX Item "cp0-names=ARCH"
      Print \s-1CP0\s0 (system control coprocessor; coprocessor 0) register names
      as appropriate for the \s-1CPU\s0 or architecture specified by
      _\s-1ARCH\s0_.  By default, \s-1CP0\s0 register names are selected according to
      the architecture and \s-1CPU\s0 of the binary being disassembled.
      .ie n .IP """hwr-names=_ARCH_""" 4
      .el .IP "\f(CWhwr-names=\f(CIARCH\f(CW" 4
      .IX Item "hwr-names=ARCH"
      Print \s-1HWR\s0 (hardware register, used by the \f(CW`rdhwr\*(C' instruction) names
      as appropriate for the \s-1CPU\s0 or architecture specified by
      _\s-1ARCH\s0_.  By default, \s-1HWR\s0 names are selected according to
      the architecture and \s-1CPU\s0 of the binary being disassembled.
      .ie n .IP """reg-names=_ABI_""" 4
      .el .IP "\f(CWreg-names=\f(CIABI\f(CW" 4
      .IX Item "reg-names=ABI"
      Print \s-1GPR\s0 and \s-1FPR\s0 names as appropriate for the selected \s-1ABI.\s0
      .ie n .IP """reg-names=_ARCH_""" 4
      .el .IP "\f(CWreg-names=\f(CIARCH\f(CW" 4
      .IX Item "reg-names=ARCH"
      Print CPU-specific register names (\s-1CP0\s0 register and \s-1HWR\s0 names)
      as appropriate for the selected \s-1CPU\s0 or architecture.
      .Sp
      For any of the options listed above, _\s-1ABI\s0_ or
      _\s-1ARCH\s0_ may be specified as **numeric** to have numbers printed
      rather than names, for the selected types of registers.
      You can list the available values of _\s-1ABI\s0_ and _\s-1ARCH\s0_ using
      the **--help** option.
      .Sp
      For \s-1VAX,\s0 you can specify function entry addresses with -M
      entry:0xf00ba.  You can use this multiple times to properly
      disassemble \s-1VAX\s0 binary files that don't contain symbol tables (like
      \s-1ROM\s0 dumps).  In these cases, the function entry mask would otherwise
      be decoded as \s-1VAX\s0 instructions, which would probably lead the rest
      of the function being wrongly disassembled.
* **-p**  
  .IX Item "-p"
* **--private-headers**  
  .IX Item "--private-headers"
  Print information that is specific to the object file format.  The exact
  information printed depends upon the object file format.  For some
  object file formats, no additional information is printed.
* **-P** _options_  
  .IX Item "-P options"
* **--private=**_options_  
  .IX Item "--private=options"
  Print information that is specific to the object file format.  The
  argument _options_ is a comma separated list that depends on the
  format (the lists of options is displayed with the help).
  .Sp
  For \s-1XCOFF,\s0 the available options are:
      .ie n .IP """header""" 4
      .el .IP "\f(CWheader" 4
      .IX Item "header"
      .ie n .IP """aout""" 4
      .el .IP "\f(CWaout" 4
      .IX Item "aout"
      .ie n .IP """sections""" 4
      .el .IP "\f(CWsections" 4
      .IX Item "sections"
      .ie n .IP """syms""" 4
      .el .IP "\f(CWsyms" 4
      .IX Item "syms"
      .ie n .IP """relocs""" 4
      .el .IP "\f(CWrelocs" 4
      .IX Item "relocs"
      .ie n .IP """lineno,""" 4
      .el .IP "\f(CWlineno," 4
      .IX Item "lineno,"
      .ie n .IP """loader""" 4
      .el .IP "\f(CWloader" 4
      .IX Item "loader"
      .ie n .IP """except""" 4
      .el .IP "\f(CWexcept" 4
      .IX Item "except"
      .ie n .IP """typchk""" 4
      .el .IP "\f(CWtypchk" 4
      .IX Item "typchk"
      .ie n .IP """traceback""" 4
      .el .IP "\f(CWtraceback" 4
      .IX Item "traceback"
      .ie n .IP """toc""" 4
      .el .IP "\f(CWtoc" 4
      .IX Item "toc"
      .ie n .IP """ldinfo""" 4
      .el .IP "\f(CWldinfo" 4
      .IX Item "ldinfo"
      .Sp
      Not all object formats support this option.  In particular the \s-1ELF\s0
      format does not use it.
* **-r**  
  .IX Item "-r"
* **--reloc**  
  .IX Item "--reloc"
  Print the relocation entries of the file.  If used with **-d** or
  **-D**, the relocations are printed interspersed with the
  disassembly.
* **-R**  
  .IX Item "-R"
* **--dynamic-reloc**  
  .IX Item "--dynamic-reloc"
  Print the dynamic relocation entries of the file.  This is only
  meaningful for dynamic objects, such as certain types of shared
  libraries.  As for **-r**, if used with **-d** or
  **-D**, the relocations are printed interspersed with the
  disassembly.
* **-s**  
  .IX Item "-s"
* **--full-contents**  
  .IX Item "--full-contents"
  Display the full contents of any sections requested.  By default all
  non-empty sections are displayed.
* **-S**  
  .IX Item "-S"
* **--source**  
  .IX Item "--source"
  Display source code intermixed with disassembly, if possible.  Implies
  **-d**.
* **--prefix=**_prefix_  
  .IX Item "--prefix=prefix"
  Specify _prefix_ to add to the absolute paths when used with
  **-S**.
* **--prefix-strip=**_level_  
  .IX Item "--prefix-strip=level"
  Indicate how many initial directory names to strip off the hardwired
  absolute paths. It has no effect without **--prefix=**_prefix_.
* **--show-raw-insn**  
  .IX Item "--show-raw-insn"
  When disassembling instructions, print the instruction in hex as well as
  in symbolic form.  This is the default except when
  **--prefix-addresses** is used.
* **--no-show-raw-insn**  
  .IX Item "--no-show-raw-insn"
  When disassembling instructions, do not print the instruction bytes.
  This is the default when **--prefix-addresses** is used.
* **--insn-width=**_width_  
  .IX Item "--insn-width=width"
  Display _width_ bytes on a single line when disassembling
  instructions.
* **-W[lLiaprmfFsoRtUuTgAckK]**  
  .IX Item "-W[lLiaprmfFsoRtUuTgAckK]"
* **--dwarf[=rawline,=decodedline,=info,=abbrev,=pubnames,=aranges,=macro,=frames,=frames-interp,=str,=loc,=Ranges,=pubtypes,=trace\_info,=trace\_abbrev,=trace\_aranges,=gdb\_index,=addr,=cu\_index,=links,=follow-links]**  
  .IX Item "--dwarf[=rawline,=decodedline,=info,=abbrev,=pubnames,=aranges,=macro,=frames,=frames-interp,=str,=loc,=Ranges,=pubtypes,=trace_info,=trace_abbrev,=trace_aranges,=gdb_index,=addr,=cu_index,=links,=follow-links]"
  Displays the contents of the \s-1DWARF\s0 debug sections in the file, if any
  are present.  Compressed debug sections are automatically decompressed
  (temporarily) before they are displayed.  If one or more of the
  optional letters or words follows the switch then only those type(s)
  of data will be dumped.  The letters and words refer to the following
  information:
      .ie n .IP """a""" 4
      .el .IP "\f(CWa" 4
      .IX Item "a"
      .ie n .IP """=abbrev""" 4
      .el .IP "\f(CW=abbrev" 4
      .IX Item "=abbrev"
      Displays the contents of the **.debug\_abbrev** section.
      .ie n .IP """A""" 4
      .el .IP "\f(CWA" 4
      .IX Item "A"
      .ie n .IP """=addr""" 4
      .el .IP "\f(CW=addr" 4
      .IX Item "=addr"
      Displays the contents of the **.debug\_addr** section.
      .ie n .IP """c""" 4
      .el .IP "\f(CWc" 4
      .IX Item "c"
      .ie n .IP """=cu_index""" 4
      .el .IP "\f(CW=cu\_index" 4
      .IX Item "=cu_index"
      Displays the contents of the **.debug\_cu\_index** and/or
      **.debug\_tu\_index** sections.
      .ie n .IP """f""" 4
      .el .IP "\f(CWf" 4
      .IX Item "f"
      .ie n .IP """=frames""" 4
      .el .IP "\f(CW=frames" 4
      .IX Item "=frames"
      Display the raw contents of a **.debug\_frame** section.
      .ie n .IP """F""" 4
      .el .IP "\f(CWF" 4
      .IX Item "F"
      .ie n .IP """=frame-interp""" 4
      .el .IP "\f(CW=frame-interp" 4
      .IX Item "=frame-interp"
      Display the interpreted contents of a **.debug\_frame** section.
      .ie n .IP """g""" 4
      .el .IP "\f(CWg" 4
      .IX Item "g"
      .ie n .IP """=gdb_index""" 4
      .el .IP "\f(CW=gdb\_index" 4
      .IX Item "=gdb_index"
      Displays the contents of the **.gdb\_index** and/or
      **.debug\_names** sections.
      .ie n .IP """i""" 4
      .el .IP "\f(CWi" 4
      .IX Item "i"
      .ie n .IP """=info""" 4
      .el .IP "\f(CW=info" 4
      .IX Item "=info"
      Displays the contents of the **.debug\_info** section.  Note: the
      output from this option can also be restricted by the use of the 
      **--dwarf-depth** and **--dwarf-start** options.
      .ie n .IP """k""" 4
      .el .IP "\f(CWk" 4
      .IX Item "k"
      .ie n .IP """=links""" 4
      .el .IP "\f(CW=links" 4
      .IX Item "=links"
      Displays the contents of the **.gnu\_debuglink** and/or
      **.gnu\_debugaltlink** sections.  Also displays the link to a
      separate dwarf object file (dwo), if one is specified by the 
      DW_AT_GNU_dwo_name or DW_AT_dwo_name attributes in the
      **.debug\_info** section.
      .ie n .IP """K""" 4
      .el .IP "\f(CWK" 4
      .IX Item "K"
      .ie n .IP """=follow-links""" 4
      .el .IP "\f(CW=follow-links" 4
      .IX Item "=follow-links"
      Display the contents of any selected debug sections that are found in
      a linked, separate debug info file.  This can result in multiple
      versions of the same debug section being displayed if both the main
      file and the separate debug info file contain sections with the same
      name.
      .Sp
      In addition, when displaying \s-1DWARF\s0 attributes, if a form is found that
      references the separate debug info file, then the referenced contents
      will also be displayed.
      .ie n .IP """l""" 4
      .el .IP "\f(CWl" 4
      .IX Item "l"
      .ie n .IP """=rawline""" 4
      .el .IP "\f(CW=rawline" 4
      .IX Item "=rawline"
      Displays the contents of the **.debug\_line** section in a raw
      format.
      .ie n .IP """L""" 4
      .el .IP "\f(CWL" 4
      .IX Item "L"
      .ie n .IP """=decodedline""" 4
      .el .IP "\f(CW=decodedline" 4
      .IX Item "=decodedline"
      Displays the interpreted contents of the **.debug\_line** section.
      .ie n .IP """m""" 4
      .el .IP "\f(CWm" 4
      .IX Item "m"
      .ie n .IP """=macro""" 4
      .el .IP "\f(CW=macro" 4
      .IX Item "=macro"
      Displays the contents of the **.debug\_macro** and/or
      **.debug\_macinfo** sections.
      .ie n .IP """o""" 4
      .el .IP "\f(CWo" 4
      .IX Item "o"
      .ie n .IP """=loc""" 4
      .el .IP "\f(CW=loc" 4
      .IX Item "=loc"
      Displays the contents of the **.debug\_loc** and/or
      **.debug\_loclists** sections.
      .ie n .IP """p""" 4
      .el .IP "\f(CWp" 4
      .IX Item "p"
      .ie n .IP """=pubnames""" 4
      .el .IP "\f(CW=pubnames" 4
      .IX Item "=pubnames"
      Displays the contents of the **.debug\_pubnames** and/or
      **.debug\_gnu\_pubnames** sections.
      .ie n .IP """r""" 4
      .el .IP "\f(CWr" 4
      .IX Item "r"
      .ie n .IP """=aranges""" 4
      .el .IP "\f(CW=aranges" 4
      .IX Item "=aranges"
      Displays the contents of the **.debug\_aranges** section.
      .ie n .IP """R""" 4
      .el .IP "\f(CWR" 4
      .IX Item "R"
      .ie n .IP """=Ranges""" 4
      .el .IP "\f(CW=Ranges" 4
      .IX Item "=Ranges"
      Displays the contents of the **.debug\_ranges** and/or
      **.debug\_rnglists** sections.
      .ie n .IP """s""" 4
      .el .IP "\f(CWs" 4
      .IX Item "s"
      .ie n .IP """=str""" 4
      .el .IP "\f(CW=str" 4
      .IX Item "=str"
      Displays the contents of the **.debug\_str**, **.debug\_line\_str**
      and/or **.debug\_str\_offsets** sections.
      .ie n .IP """t""" 4
      .el .IP "\f(CWt" 4
      .IX Item "t"
      .ie n .IP """=pubtype""" 4
      .el .IP "\f(CW=pubtype" 4
      .IX Item "=pubtype"
      Displays the contents of the **.debug\_pubtypes** and/or
      **.debug\_gnu\_pubtypes** sections.
      .ie n .IP """T""" 4
      .el .IP "\f(CWT" 4
      .IX Item "T"
      .ie n .IP """=trace_aranges""" 4
      .el .IP "\f(CW=trace\_aranges" 4
      .IX Item "=trace_aranges"
      Displays the contents of the **.trace\_aranges** section.
      .ie n .IP """u""" 4
      .el .IP "\f(CWu" 4
      .IX Item "u"
      .ie n .IP """=trace_abbrev""" 4
      .el .IP "\f(CW=trace\_abbrev" 4
      .IX Item "=trace_abbrev"
      Displays the contents of the **.trace\_abbrev** section.
      .ie n .IP """U""" 4
      .el .IP "\f(CWU" 4
      .IX Item "U"
      .ie n .IP """=trace_info""" 4
      .el .IP "\f(CW=trace\_info" 4
      .IX Item "=trace_info"
      Displays the contents of the **.trace\_info** section.
      .Sp
      Note: displaying the contents of **.debug\_static\_funcs**,
      **.debug\_static\_vars** and **debug\_weaknames** sections is not
      currently supported.
* **--dwarf-depth=**_n_  
  .IX Item "--dwarf-depth=n"
  Limit the dump of the \f(CW`.debug\_info\*(C' section to _n_ children.
  This is only useful with **--debug-dump=info**.  The default is
  to print all DIEs; the special value 0 for _n_ will also have this
  effect.
  .Sp
  With a non-zero value for _n_, DIEs at or deeper than _n_
  levels will not be printed.  The range for _n_ is zero-based.
* **--dwarf-start=**_n_  
  .IX Item "--dwarf-start=n"
  Print only DIEs beginning with the \s-1DIE\s0 numbered _n_.  This is only
  useful with **--debug-dump=info**.
  .Sp
  If specified, this option will suppress printing of any header
  information and all DIEs before the \s-1DIE\s0 numbered _n_.  Only
  siblings and children of the specified \s-1DIE\s0 will be printed.
  .Sp
  This can be used in conjunction with **--dwarf-depth**.
* **--dwarf-check**  
  .IX Item "--dwarf-check"
  Enable additional checks for consistency of Dwarf information.
* **-G**  
  .IX Item "-G"
* **--stabs**  
  .IX Item "--stabs"
  Display the full contents of any sections requested.  Display the
  contents of the .stab and .stab.index and .stab.excl sections from an
  \s-1ELF\s0 file.  This is only useful on systems (such as Solaris 2.0) in which
  \f(CW`.stab\*(C' debugging symbol-table entries are carried in an \s-1ELF\s0
  section.  In most other file formats, debugging symbol-table entries are
  interleaved with linkage symbols, and are visible in the **--syms**
  output.
* **--start-address=**_address_  
  .IX Item "--start-address=address"
  Start displaying data at the specified address.  This affects the output
  of the **-d**, **-r** and **-s** options.
* **--stop-address=**_address_  
  .IX Item "--stop-address=address"
  Stop displaying data at the specified address.  This affects the output
  of the **-d**, **-r** and **-s** options.
* **-t**  
  .IX Item "-t"
* **--syms**  
  .IX Item "--syms"
  Print the symbol table entries of the file.
  This is similar to the information provided by the **nm** program,
  although the display format is different.  The format of the output
  depends upon the format of the file being dumped, but there are two main
  types.  One looks like this:
  .Sp
  .Vb 2
          [  4](sec  3)(fl 0x00)(ty   0)(scl   3) (nx 1) 0x00000000 .bss
          [  6](sec  1)(fl 0x00)(ty   0)(scl   2) (nx 0) 0x00000000 fred
  .Ve
  .Sp
  where the number inside the square brackets is the number of the entry
  in the symbol table, the _sec_ number is the section number, the
  _fl_ value are the symbol's flag bits, the _ty_ number is the
  symbol's type, the _scl_ number is the symbol's storage class and
  the _nx_ value is the number of auxilary entries associated with
  the symbol.  The last two fields are the symbol's value and its name.
  .Sp
  The other common output format, usually seen with \s-1ELF\s0 based files,
  looks like this:
  .Sp
  .Vb 2
          00000000 l    d  .bss   00000000 .bss
          00000000 g       .text  00000000 fred
  .Ve
  .Sp
  Here the first number is the symbol's value (sometimes refered to as
  its address).  The next field is actually a set of characters and
  spaces indicating the flag bits that are set on the symbol.  These
  characters are described below.  Next is the section with which the
  symbol is associated or _*ABS*_ if the section is absolute (ie
  not connected with any section), or _*UND*_ if the section is
  referenced in the file being dumped, but not defined there.
  .Sp
  After the section name comes another field, a number, which for common
  symbols is the alignment and for other symbol is the size.  Finally
  the symbol's name is displayed.
  .Sp
  The flag characters are divided into 7 groups as follows:
      .ie n .IP """l""" 4
      .el .IP "\f(CWl" 4
      .IX Item "l"
      .ie n .IP """g""" 4
      .el .IP "\f(CWg" 4
      .IX Item "g"
      .ie n .IP """u""" 4
      .el .IP "\f(CWu" 4
      .IX Item "u"
      .ie n .IP """!""" 4
      .el .IP "\f(CW!" 4
      .IX Item "!"
      The symbol is a local (l), global (g), unique global (u), neither
      global nor local (a space) or both global and local (!).  A
      symbol can be neither local or global for a variety of reasons, e.g.,
      because it is used for debugging, but it is probably an indication of
      a bug if it is ever both local and global.  Unique global symbols are
      a \s-1GNU\s0 extension to the standard set of \s-1ELF\s0 symbol bindings.  For such
      a symbol the dynamic linker will make sure that in the entire process
      there is just one symbol with this name and type in use.
      .ie n .IP """w""" 4
      .el .IP "\f(CWw" 4
      .IX Item "w"
      The symbol is weak (w) or strong (a space).
      .ie n .IP """C""" 4
      .el .IP "\f(CWC" 4
      .IX Item "C"
      The symbol denotes a constructor (C) or an ordinary symbol (a space).
      .ie n .IP """W""" 4
      .el .IP "\f(CWW" 4
      .IX Item "W"
      The symbol is a warning (W) or a normal symbol (a space).  A warning
      symbol's name is a message to be displayed if the symbol following the
      warning symbol is ever referenced.
      .ie n .IP """I""" 4
      .el .IP "\f(CWI" 4
      .IX Item "I"
      .ie n .IP """i""" 4
      .el .IP "\f(CWi" 4
      .IX Item "i"
      The symbol is an indirect reference to another symbol (I), a function
      to be evaluated during reloc processing (i) or a normal symbol (a
      space).
      .ie n .IP """d""" 4
      .el .IP "\f(CWd" 4
      .IX Item "d"
      .ie n .IP """D""" 4
      .el .IP "\f(CWD" 4
      .IX Item "D"
      The symbol is a debugging symbol (d) or a dynamic symbol (D) or a
      normal symbol (a space).
      .ie n .IP """F""" 4
      .el .IP "\f(CWF" 4
      .IX Item "F"
      .ie n .IP """f""" 4
      .el .IP "\f(CWf" 4
      .IX Item "f"
      .ie n .IP """O""" 4
      .el .IP "\f(CWO" 4
      .IX Item "O"
      The symbol is the name of a function (F) or a file (f) or an object
      (O) or just a normal symbol (a space).
* **-T**  
  .IX Item "-T"
* **--dynamic-syms**  
  .IX Item "--dynamic-syms"
  Print the dynamic symbol table entries of the file.  This is only
  meaningful for dynamic objects, such as certain types of shared
  libraries.  This is similar to the information provided by the **nm**
  program when given the **-D** (**--dynamic**) option.
  .Sp
  The output format is similar to that produced by the **--syms**
  option, except that an extra field is inserted before the symbol's
  name, giving the version information associated with the symbol.
  If the version is the default version to be used when resolving
  unversioned references to the symbol then it's displayed as is,
  otherwise it's put into parentheses.
* **--special-syms**  
  .IX Item "--special-syms"
  When displaying symbols include those which the target considers to be
  special in some way and which would not normally be of interest to the
  user.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Print the version number of **objdump** and exit.
* **-x**  
  .IX Item "-x"
* **--all-headers**  
  .IX Item "--all-headers"
  Display all available header information, including the symbol table and
  relocation entries.  Using **-x** is equivalent to specifying all of
  **-a -f -h -p -r -t**.
* **-w**  
  .IX Item "-w"
* **--wide**  
  .IX Item "--wide"
  Format some lines for output devices that have more than 80 columns.
  Also do not truncate symbol names when they are displayed.
* **-z**  
  .IX Item "-z"
* **--disassemble-zeroes**  
  .IX Item "--disassemble-zeroes"
  Normally the disassembly output will skip blocks of zeroes.  This
  option directs the disassembler to disassemble those blocks, just like
  any other data.
* **@**_file_  
  .IX Item "@file"
  Read command-line options from _file_.  The options read are
  inserted in place of the original @_file_ option.  If _file_
  does not exist, or cannot be read, then the option will be treated
  literally, and not removed.
  .Sp
  Options in _file_ are separated by whitespace.  A whitespace
  character may be included in an option by surrounding the entire
  option in either single or double quotes.  Any character (including a
  backslash) may be included by prefixing the character to be included
  with a backslash.  The _file_ may itself contain additional
  @_file_ options; any such options will be processed recursively.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
_nm_\|(1), _readelf_\|(1), and the Info entries for _binutils_.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1991-2018 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3
or any later version published by the Free Software Foundation;
with no Invariant Sections, with no Front-Cover Texts, and with no
Back-Cover Texts.  A copy of the license is included in the
section entitled \s-1GNU\s0 Free Documentation License\*(R".
