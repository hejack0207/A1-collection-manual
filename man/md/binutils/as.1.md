# as(1)

binutils-2.31.1, 2020-01-02

.if n .ad l
.nh

<a name="name"></a>

# Name

AS - the portable GNU assembler.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" as [-a[cdghlns][=file]] [--alternate] [-D]  [--compress-debug-sections]  [--nocompress-debug-sections]  [--debug-prefix-map old=new]  [--defsym sym=val] [-f] [-g] [--gstabs]  [--gstabs+] [--gdwarf-2] [--gdwarf-sections]  [--help] [-I dir] [-J]  [-K] [-L] [--listing-lhs-width=\s-1NUM\s0]  [--listing-lhs-width2=\s-1NUM\s0] [--listing-rhs-width=\s-1NUM\s0]  [--listing-cont-lines=\s-1NUM\s0] [--keep-locals]  [--no-pad-sections]  [-o objfile] [-R]  [--hash-size=\s-1NUM\s0] [--reduce-memory-overheads]  [--statistics]  [-v] [-version] [--version]  [-W] [--warn] [--fatal-warnings] [-w] [-x]  [-Z] [@\s-1FILE\s0]  [--sectname-subst] [--size-check=[error|warning]]  [--elf-stt-common=[no|yes]]  [--generate-missing-build-notes=[no|yes]]  [--target-help] [target-options]  [--|files ...]
```

<a name="target"></a>

# Target

.IX Header "TARGET"
_Target AArch64 options:_
   [**-EB**|**-EL**]
   [**-mabi**=_\s-1ABI\s0_]

_Target Alpha options:_
   [**-m**_cpu_]
   [**-mdebug** | **-no-mdebug**]
   [**-replace** | **-noreplace**]
   [**-relax**] [**-g**] [**-G**_size_]
   [**-F**] [**-32addr**]

_Target \s-1ARC\s0 options:_
   [**-mcpu=**_cpu_]
   [**-mA6**|**-mARC600**|**-mARC601**|**-mA7**|**-mARC700**|**-mEM**|**-mHS**]
   [**-mcode-density**]
   [**-mrelax**]
   [**-EB**|**-EL**]

_Target \s-1ARM\s0 options:_
   [**-mcpu**=_processor_[+_extension_...]]
   [**-march**=_architecture_[+_extension_...]]
   [**-mfpu**=_floating-point-format_]
   [**-mfloat-abi**=_abi_]
   [**-meabi**=_ver_]
   [**-mthumb**]
   [**-EB**|**-EL**]
   [**-mapcs-32**|**-mapcs-26**|**-mapcs-float**|
    **-mapcs-reentrant**]
   [**-mthumb-interwork**] [**-k**]

_Target Blackfin options:_
   [**-mcpu**=_processor_[-_sirevision_]]
   [**-mfdpic**]
   [**-mno-fdpic**]
   [**-mnopic**]

_Target \s-1CRIS\s0 options:_
   [**--underscore** | **--no-underscore**]
   [**--pic**] [**-N**]
   [**--emulation=criself** | **--emulation=crisaout**]
   [**--march=v0\_v10** | **--march=v10** | **--march=v32** | **--march=common\_v10\_v32**]

_Target D10V options:_
   [**-O**]

_Target D30V options:_
   [**-O**|**-n**|**-N**]

_Target \s-1EPIPHANY\s0 options:_
   [**-mepiphany**|**-mepiphany16**]

_Target H8/300 options:_
   [-h-tick-hex]

_Target i386 options:_
   [**--32**|**--x32**|**--64**] [**-n**]
   [**-march**=_\s-1CPU\s0_[+_\s-1EXTENSION\s0_...]] [**-mtune**=_\s-1CPU\s0_]

_Target \s-1IA-64\s0 options:_
   [**-mconstant-gp**|**-mauto-pic**]
   [**-milp32**|**-milp64**|**-mlp64**|**-mp64**]
   [**-mle**|**mbe**]
   [**-mtune=itanium1**|**-mtune=itanium2**]
   [**-munwind-check=warning**|**-munwind-check=error**]
   [**-mhint.b=ok**|**-mhint.b=warning**|**-mhint.b=error**]
   [**-x**|**-xexplicit**] [**-xauto**] [**-xdebug**]

_Target \s-1IP2K\s0 options:_
   [**-mip2022**|**-mip2022ext**]

_Target M32C options:_
   [**-m32c**|**-m16c**] [-relax] [-h-tick-hex]

_Target M32R options:_
   [**--m32rx**|**--[no-]warn-explicit-parallel-conflicts**|
   **--W[n]p**]

_Target M680X0 options:_
   [**-l**] [**-m68000**|**-m68010**|**-m68020**|...]

_Target M68HC11 options:_
   [**-m68hc11**|**-m68hc12**|**-m68hcs12**|**-mm9s12x**|**-mm9s12xg**]
   [**-mshort**|**-mlong**]
   [**-mshort-double**|**-mlong-double**]
   [**--force-long-branches**] [**--short-branches**]
   [**--strict-direct-mode**] [**--print-insn-syntax**]
   [**--print-opcodes**] [**--generate-example**]

_Target \s-1MCORE\s0 options:_
   [**-jsri2bsr**] [**-sifilter**] [**-relax**]
   [**-mcpu=[210|340]**]

_Target Meta options:_
   [**-mcpu=**_cpu_] [**-mfpu=**_cpu_] [**-mdsp=**_cpu_]
_Target \s-1MICROBLAZE\s0 options:_

_Target \s-1MIPS\s0 options:_
   [**-nocpp**] [**-EL**] [**-EB**] [**-O**[_optimization level_]]
   [**-g**[_debug level_]] [**-G** _num_] [**-KPIC**] [**-call\_shared**]
   [**-non\_shared**] [**-xgot** [**-mvxworks-pic**]
   [**-mabi**=_\s-1ABI\s0_] [**-32**] [**-n32**] [**-64**] [**-mfp32**] [**-mgp32**]
   [**-mfp64**] [**-mgp64**] [**-mfpxx**]
   [**-modd-spreg**] [**-mno-odd-spreg**]
   [**-march**=_\s-1CPU\s0_] [**-mtune**=_\s-1CPU\s0_] [**-mips1**] [**-mips2**]
   [**-mips3**] [**-mips4**] [**-mips5**] [**-mips32**] [**-mips32r2**]
   [**-mips32r3**] [**-mips32r5**] [**-mips32r6**] [**-mips64**] [**-mips64r2**]
   [**-mips64r3**] [**-mips64r5**] [**-mips64r6**]
   [**-construct-floats**] [**-no-construct-floats**]
   [**-mignore-branch-isa**] [**-mno-ignore-branch-isa**]
   [**-mnan=**_encoding_]
   [**-trap**] [**-no-break**] [**-break**] [**-no-trap**]
   [**-mips16**] [**-no-mips16**]
   [**-mmips16e2**] [**-mno-mips16e2**]
   [**-mmicromips**] [**-mno-micromips**]
   [**-msmartmips**] [**-mno-smartmips**]
   [**-mips3d**] [**-no-mips3d**]
   [**-mdmx**] [**-no-mdmx**]
   [**-mdsp**] [**-mno-dsp**]
   [**-mdspr2**] [**-mno-dspr2**]
   [**-mdspr3**] [**-mno-dspr3**]
   [**-mmsa**] [**-mno-msa**]
   [**-mxpa**] [**-mno-xpa**]
   [**-mmt**] [**-mno-mt**]
   [**-mmcu**] [**-mno-mcu**]
   [**-mcrc**] [**-mno-crc**]
   [**-mginv**] [**-mno-ginv**]
   [**-minsn32**] [**-mno-insn32**]
   [**-mfix7000**] [**-mno-fix7000**]
   [**-mfix-rm7000**] [**-mno-fix-rm7000**]
   [**-mfix-vr4120**] [**-mno-fix-vr4120**]
   [**-mfix-vr4130**] [**-mno-fix-vr4130**]
   [**-mdebug**] [**-no-mdebug**]
   [**-mpdr**] [**-mno-pdr**]

_Target \s-1MMIX\s0 options:_
   [**--fixed-special-register-names**] [**--globalize-symbols**]
   [**--gnu-syntax**] [**--relax**] [**--no-predefined-symbols**]
   [**--no-expand**] [**--no-merge-gregs**] [**-x**]
   [**--linker-allocated-gregs**]

_Target Nios \s-1II\s0 options:_
   [**-relax-all**] [**-relax-section**] [**-no-relax**]
   [**-EB**] [**-EL**]

_Target \s-1NDS32\s0 options:_
    [**-EL**] [**-EB**] [**-O**] [**-Os**] [**-mcpu=**_cpu_]
    [**-misa=**_isa_] [**-mabi=**_abi_] [**-mall-ext**]
    [**-m[no-]16-bit**]  [**-m[no-]perf-ext**] [**-m[no-]perf2-ext**]
    [**-m[no-]string-ext**] [**-m[no-]dsp-ext**] [**-m[no-]mac**] [**-m[no-]div**]
    [**-m[no-]audio-isa-ext**] [**-m[no-]fpu-sp-ext**] [**-m[no-]fpu-dp-ext**]
    [**-m[no-]fpu-fma**] [**-mfpu-freg=**_\s-1FREG\s0_] [**-mreduced-regs**]
    [**-mfull-regs**] [**-m[no-]dx-regs**] [**-mpic**] [**-mno-relax**]
    [**-mb2bb**]

_Target \s-1PDP11\s0 options:_
   [**-mpic**|**-mno-pic**] [**-mall**] [**-mno-extensions**]
   [**-m**_extension_|**-mno-**_extension_]
   [**-m**_cpu_] [**-m**_machine_]

_Target picoJava options:_
   [**-mb**|**-me**]

_Target PowerPC options:_
   [**-a32**|**-a64**]
   [**-mpwrx**|**-mpwr2**|**-mpwr**|**-m601**|**-mppc**|**-mppc32**|**-m603**|**-m604**|**-m403**|**-m405**|
    **-m440**|**-m464**|**-m476**|**-m7400**|**-m7410**|**-m7450**|**-m7455**|**-m750cl**|**-mppc64**|
    **-m620**|**-me500**|**-e500x2**|**-me500mc**|**-me500mc64**|**-me5500**|**-me6500**|**-mppc64bridge**|
    **-mbooke**|**-mpower4**|**-mpwr4**|**-mpower5**|**-mpwr5**|**-mpwr5x**|**-mpower6**|**-mpwr6**|
    **-mpower7**|**-mpwr7**|**-mpower8**|**-mpwr8**|**-mpower9**|**-mpwr9****-ma2**|
    **-mcell**|**-mspe**|**-mspe2**|**-mtitan**|**-me300**|**-mcom**]
   [**-many**] [**-maltivec**|**-mvsx**|**-mhtm**|**-mvle**]
   [**-mregnames**|**-mno-regnames**]
   [**-mrelocatable**|**-mrelocatable-lib**|**-K \s-1PIC\s0**] [**-memb**]
   [**-mlittle**|**-mlittle-endian**|**-le**|**-mbig**|**-mbig-endian**|**-be**]
   [**-msolaris**|**-mno-solaris**]
   [**-nops=**_count_]

_Target \s-1PRU\s0 options:_
   [**-link-relax**]
   [**-mnolink-relax**]
   [**-mno-warn-regname-label**]

_Target RISC-V options:_
   [**-fpic**|**-fPIC**|**-fno-pic**]
   [**-march**=_\s-1ISA\s0_]
   [**-mabi**=_\s-1ABI\s0_]

_Target \s-1RL78\s0 options:_
   [**-mg10**]
   [**-m32bit-doubles**|**-m64bit-doubles**]

_Target \s-1RX\s0 options:_
   [**-mlittle-endian**|**-mbig-endian**]
   [**-m32bit-doubles**|**-m64bit-doubles**]
   [**-muse-conventional-section-names**]
   [**-msmall-data-limit**]
   [**-mpid**]
   [**-mrelax**]
   [**-mint-register=**_number_]
   [**-mgcc-abi**|**-mrx-abi**]

_Target s390 options:_
   [**-m31**|**-m64**] [**-mesa**|**-mzarch**] [**-march**=_\s-1CPU\s0_]
   [**-mregnames**|**-mno-regnames**]
   [**-mwarn-areg-zero**]

_Target \s-1SCORE\s0 options:_
   [**-EB**][**-EL**][**-FIXDD**][**-NWARN**]
   [**-SCORE5**][**-SCORE5U**][**-SCORE7**][**-SCORE3**]
   [**-march=score7**][**-march=score3**]
   [**-USE\_R1**][**-KPIC**][**-O0**][**-G** _num_][**-V**]

_Target \s-1SPARC\s0 options:_
   [**-Av6**|**-Av7**|**-Av8**|**-Aleon**|**-Asparclet**|**-Asparclite**
    **-Av8plus**|**-Av8plusa**|**-Av8plusb**|**-Av8plusc**|**-Av8plusd**
    **-Av8plusv**|**-Av8plusm**|**-Av9**|**-Av9a**|**-Av9b**|**-Av9c**
    **-Av9d**|**-Av9e**|**-Av9v**|**-Av9m**|**-Asparc**|**-Asparcvis**
    **-Asparcvis2**|**-Asparcfmaf**|**-Asparcima**|**-Asparcvis3**
    **-Asparcvisr**|**-Asparc5**]
   [**-xarch=v8plus**|**-xarch=v8plusa**]|**-xarch=v8plusb**|**-xarch=v8plusc**
    **-xarch=v8plusd**|**-xarch=v8plusv**|**-xarch=v8plusm**|**-xarch=v9**
    **-xarch=v9a**|**-xarch=v9b**|**-xarch=v9c**|**-xarch=v9d**|**-xarch=v9e**
    **-xarch=v9v**|**-xarch=v9m**|**-xarch=sparc**|**-xarch=sparcvis**
    **-xarch=sparcvis2**|**-xarch=sparcfmaf**|**-xarch=sparcima**
    **-xarch=sparcvis3**|**-xarch=sparcvisr**|**-xarch=sparc5**
    **-bump**]
   [**-32**|**-64**]
   [**--enforce-aligned-data**][**--dcti-couples-detect**]

_Target \s-1TIC54X\s0 options:_
 [**-mcpu=54[123589]**|**-mcpu=54[56]lp**] [**-mfar-mode**|**-mf**]
 [**-merrors-to-file** _&lt;filename&gt;_|**-me** _&lt;filename&gt;_]

_Target \s-1TIC6X\s0 options:_
   [**-march=**_arch_] [**-mbig-endian**|**-mlittle-endian**]
   [**-mdsbt**|**-mno-dsbt**] [**-mpid=no**|**-mpid=near**|**-mpid=far**]
   [**-mpic**|**-mno-pic**]

_Target TILE-Gx options:_
   [**-m32**|**-m64**][**-EB**][**-EL**]

_Target Visium options:_
   [**-mtune=**_arch_]

_Target Xtensa options:_
 [**--[no-]text-section-literals**] [**--[no-]auto-litpools**]
 [**--[no-]absolute-literals**]
 [**--[no-]target-align**] [**--[no-]longcalls**]
 [**--[no-]transform**]
 [**--rename-section** _oldname_=_newname_]
 [**--[no-]trampolines**]

_Target Z80 options:_
  [**-z80**] [**-r800**]
  [ **-ignore-undocumented-instructions**] [**-Wnud**]
  [ **-ignore-unportable-instructions**] [**-Wnup**]
  [ **-warn-undocumented-instructions**] [**-Wud**]
  [ **-warn-unportable-instructions**] [**-Wup**]
  [ **-forbid-undocumented-instructions**] [**-Fud**]
  [ **-forbid-unportable-instructions**] [**-Fup**]

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\s-1GNU\s0 **as** is really a family of assemblers.
If you use (or have used) the \s-1GNU\s0 assembler on one architecture, you
should find a fairly similar environment when you use it on another
architecture.  Each version has much in common with the others,
including object file formats, most assembler directives (often called
_pseudo-ops_) and assembler syntax.

**as** is primarily intended to assemble the output of the
\s-1GNU C\s0 compiler \f(CW`gcc\*(C' for use by the linker
\f(CW`ld\*(C'.  Nevertheless, we've tried to make **as**
assemble correctly everything that other assemblers for the same
machine would assemble.
Any exceptions are documented explicitly.
This doesn't mean **as** always uses the same syntax as another
assembler for the same architecture; for example, we know of several
incompatible versions of 680x0 assembly language syntax.

Each time you run **as** it assembles exactly one source
program.  The source program is made up of one or more files.
(The standard input is also a file.)

You give **as** a command line that has zero or more input file
names.  The input files are read (from left file name to right).  A
command line argument (in any position) that has no special meaning
is taken to be an input file name.

If you give **as** no file names it attempts to read one input file
from the **as** standard input, which is normally your terminal.  You
may have to type **ctl-D** to tell **as** there is no more program
to assemble.

Use **--** if you need to explicitly name the standard input file
in your command line.

If the source is empty, **as** produces a small, empty object
file.

**as** may write warnings and error messages to the standard error
file (usually your terminal).  This should not happen when  a compiler
runs **as** automatically.  Warnings report an assumption made so
that **as** could keep assembling a flawed program; errors report a
grave problem that stops the assembly.

If you are invoking **as** via the \s-1GNU C\s0 compiler,
you can use the **-Wa** option to pass arguments through to the assembler.
The assembler arguments must be separated from each other (and the **-Wa**)
by commas.  For example:

.Vb 1
        gcc -c -g -O -Wa,-alh,-L file.c
.Ve

This passes two options to the assembler: **-alh** (emit a listing to
standard output with high-level and assembly source) and **-L** (retain
local symbols in the symbol table).

Usually you do not need to use this **-Wa** mechanism, since many compiler
command-line options are automatically passed to the assembler by the compiler.
(You can call the \s-1GNU\s0 compiler driver with the **-v** option to see
precisely what options it passes to each compilation pass, including the
assembler.)

<a name="options"></a>

# Options

.IX Header "OPTIONS"

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
* **-a[cdghlmns]**  
  .IX Item "-a[cdghlmns]"
  Turn on listings, in any of a variety of ways:
    * **-ac**  
      .IX Item "-ac"
      omit false conditionals
    * **-ad**  
      .IX Item "-ad"
      omit debugging directives
    * **-ag**  
      .IX Item "-ag"
      include general information, like as version and options passed
    * **-ah**  
      .IX Item "-ah"
      include high-level source
    * **-al**  
      .IX Item "-al"
      include assembly
    * **-am**  
      .IX Item "-am"
      include macro expansions
    * **-an**  
      .IX Item "-an"
      omit forms processing
    * **-as**  
      .IX Item "-as"
      include symbols
    * **=file**  
      .IX Item "=file"
      set the name of the listing file
      .Sp
      You may combine these options; for example, use **-aln** for assembly
      listing without forms processing.  The **=file** option, if used, must be
      the last one.  By itself, **-a** defaults to **-ahls**.
* **--alternate**  
  .IX Item "--alternate"
  Begin in alternate macro mode.
* **--compress-debug-sections**  
  .IX Item "--compress-debug-sections"
  Compress \s-1DWARF\s0 debug sections using zlib with \s-1SHF_COMPRESSED\s0 from the
  \s-1ELF ABI.\s0  The resulting object file may not be compatible with older
  linkers and object file utilities.  Note if compression would make a
  given section _larger_ then it is not compressed.
* **--compress-debug-sections=none**  
  .IX Item "--compress-debug-sections=none"
* **--compress-debug-sections=zlib**  
  .IX Item "--compress-debug-sections=zlib"
* **--compress-debug-sections=zlib-gnu**  
  .IX Item "--compress-debug-sections=zlib-gnu"
* **--compress-debug-sections=zlib-gabi**  
  .IX Item "--compress-debug-sections=zlib-gabi"
  These options control how \s-1DWARF\s0 debug sections are compressed.
  **--compress-debug-sections=none** is equivalent to
  **--nocompress-debug-sections**.
  **--compress-debug-sections=zlib** and
  **--compress-debug-sections=zlib-gabi** are equivalent to
  **--compress-debug-sections**.
  **--compress-debug-sections=zlib-gnu** compresses \s-1DWARF\s0 debug
  sections using zlib.  The debug sections are renamed to begin with
  **.zdebug**.  Note if compression would make a given section
  _larger_ then it is not compressed nor renamed.
* **--nocompress-debug-sections**  
  .IX Item "--nocompress-debug-sections"
  Do not compress \s-1DWARF\s0 debug sections.  This is usually the default for all
  targets except the x86/x86_64, but a configure time option can be used to
  override this.
* **-D**  
  .IX Item "-D"
  Ignored.  This option is accepted for script compatibility with calls to
  other assemblers.
* **--debug-prefix-map** _old_**=**_new_  
  .IX Item "--debug-prefix-map old=new"
  When assembling files in directory _old_, record debugging
  information describing them as in _new_ instead.
* **--defsym** _sym_**=**_value_  
  .IX Item "--defsym sym=value"
  Define the symbol _sym_ to be _value_ before assembling the input file.
  _value_ must be an integer constant.  As in C, a leading **0x**
  indicates a hexadecimal value, and a leading **0** indicates an octal
  value.  The value of the symbol can be overridden inside a source file via the
  use of a \f(CW`.set\*(C' pseudo-op.
* **-f**  
  .IX Item "-f"
  fast\*(R"---skip whitespace and comment preprocessing (assume source is
  compiler output).
* **-g**  
  .IX Item "-g"
* **--gen-debug**  
  .IX Item "--gen-debug"
  Generate debugging information for each assembler source line using whichever
  debug format is preferred by the target.  This currently means either \s-1STABS,
  ECOFF\s0 or \s-1DWARF2.\s0
* **--gstabs**  
  .IX Item "--gstabs"
  Generate stabs debugging information for each assembler line.  This
  may help debugging assembler code, if the debugger can handle it.
* **--gstabs+**  
  .IX Item "--gstabs+"
  Generate stabs debugging information for each assembler line, with \s-1GNU\s0
  extensions that probably only gdb can handle, and that could make other
  debuggers crash or refuse to read your program.  This
  may help debugging assembler code.  Currently the only \s-1GNU\s0 extension is
  the location of the current working directory at assembling time.
* **--gdwarf-2**  
  .IX Item "--gdwarf-2"
  Generate \s-1DWARF2\s0 debugging information for each assembler line.  This
  may help debugging assembler code, if the debugger can handle it.  Note---this
  option is only supported by some targets, not all of them.
* **--gdwarf-sections**  
  .IX Item "--gdwarf-sections"
  Instead of creating a .debug_line section, create a series of
  .debug\_line._foo_ sections where _foo_ is the name of the
  corresponding code section.  For example a code section called _.text.func_
  will have its dwarf line number information placed into a section called
  _.debug\_line.text.func_.  If the code section is just called _.text_
  then debug line section will still be called just _.debug\_line_ without any
  suffix.
* **--size-check=error**  
  .IX Item "--size-check=error"
* **--size-check=warning**  
  .IX Item "--size-check=warning"
  Issue an error or warning for invalid \s-1ELF\s0 .size directive.
* **--elf-stt-common=no**  
  .IX Item "--elf-stt-common=no"
* **--elf-stt-common=yes**  
  .IX Item "--elf-stt-common=yes"
  These options control whether the \s-1ELF\s0 assembler should generate common
  symbols with the \f(CW`STT\_COMMON\*(C' type.  The default can be controlled
  by a configure option **--enable-elf-stt-common**.
* **--generate-missing-build-notes=yes**  
  .IX Item "--generate-missing-build-notes=yes"
* **--generate-missing-build-notes=no**  
  .IX Item "--generate-missing-build-notes=no"
  These options control whether the \s-1ELF\s0 assembler should generate \s-1GNU\s0 Build
  attribute notes if none are present in the input sources.
  The default can be controlled by the **--enable-generate-build-notes**
  configure option.
* **--help**  
  .IX Item "--help"
  Print a summary of the command line options and exit.
* **--target-help**  
  .IX Item "--target-help"
  Print a summary of all target specific options and exit.
* **-I** _dir_  
  .IX Item "-I dir"
  Add directory _dir_ to the search list for \f(CW`.include\*(C' directives.
* **-J**  
  .IX Item "-J"
  Don't warn about signed overflow.
* **-K**  
  .IX Item "-K"
  Issue warnings when difference tables altered for long displacements.
* **-L**  
  .IX Item "-L"
* **--keep-locals**  
  .IX Item "--keep-locals"
  Keep (in the symbol table) local symbols.  These symbols start with
  system-specific local label prefixes, typically **.L** for \s-1ELF\s0 systems
  or **L** for traditional a.out systems.
* **--listing-lhs-width=**_number_  
  .IX Item "--listing-lhs-width=number"
  Set the maximum width, in words, of the output data column for an assembler
  listing to _number_.
* **--listing-lhs-width2=**_number_  
  .IX Item "--listing-lhs-width2=number"
  Set the maximum width, in words, of the output data column for continuation
  lines in an assembler listing to _number_.
* **--listing-rhs-width=**_number_  
  .IX Item "--listing-rhs-width=number"
  Set the maximum width of an input source line, as displayed in a listing, to
  _number_ bytes.
* **--listing-cont-lines=**_number_  
  .IX Item "--listing-cont-lines=number"
  Set the maximum number of lines printed in a listing for a single line of input
  to _number_ + 1.
* **--no-pad-sections**  
  .IX Item "--no-pad-sections"
  Stop the assembler for padding the ends of output sections to the alignment
  of that section.  The default is to pad the sections, but this can waste space
  which might be needed on targets which have tight memory constraints.
* **-o** _objfile_  
  .IX Item "-o objfile"
  Name the object-file output from **as** _objfile_.
* **-R**  
  .IX Item "-R"
  Fold the data section into the text section.
* **--hash-size=**_number_  
  .IX Item "--hash-size=number"
  Set the default size of \s-1GAS\s0's hash tables to a prime number close to
  _number_.  Increasing this value can reduce the length of time it takes the
  assembler to perform its tasks, at the expense of increasing the assembler's
  memory requirements.  Similarly reducing this value can reduce the memory
  requirements at the expense of speed.
* **--reduce-memory-overheads**  
  .IX Item "--reduce-memory-overheads"
  This option reduces \s-1GAS\s0's memory requirements, at the expense of making the
  assembly processes slower.  Currently this switch is a synonym for
  **--hash-size=4051**, but in the future it may have other effects as well.
* **--sectname-subst**  
  .IX Item "--sectname-subst"
  Honor substitution sequences in section names.
* **--statistics**  
  .IX Item "--statistics"
  Print the maximum space (in bytes) and total time (in seconds) used by
  assembly.
* **--strip-local-absolute**  
  .IX Item "--strip-local-absolute"
  Remove local absolute symbols from the outgoing symbol table.
* **-v**  
  .IX Item "-v"
* **-version**  
  .IX Item "-version"
  Print the **as** version.
* **--version**  
  .IX Item "--version"
  Print the **as** version and exit.
* **-W**  
  .IX Item "-W"
* **--no-warn**  
  .IX Item "--no-warn"
  Suppress warning messages.
* **--fatal-warnings**  
  .IX Item "--fatal-warnings"
  Treat warnings as errors.
* **--warn**  
  .IX Item "--warn"
  Don't suppress warning messages or treat them as errors.
* **-w**  
  .IX Item "-w"
  Ignored.
* **-x**  
  .IX Item "-x"
  Ignored.
* **-Z**  
  .IX Item "-Z"
  Generate an object file even after errors.
* **-- |** _files_ **...**  
  .IX Item "-- | files ..."
  Standard input, or source files to assemble.

The following options are available when as is configured for the
64-bit mode of the \s-1ARM\s0 Architecture (AArch64).

* **-EB**  
  .IX Item "-EB"
  This option specifies that the output generated by the assembler should
  be marked as being encoded for a big-endian processor.
* **-EL**  
  .IX Item "-EL"
  This option specifies that the output generated by the assembler should
  be marked as being encoded for a little-endian processor.
* **-mabi=**_abi_  
  .IX Item "-mabi=abi"
  Specify which \s-1ABI\s0 the source code uses.  The recognized arguments
  are: \f(CW`ilp32\*(C' and \f(CW\*(C\`lp64\*(C', which decides the generated object
  file in \s-1ELF32\s0 and \s-1ELF64\s0 format respectively.  The default is \f(CW`lp64\*(C'.
* **-mcpu=**_processor_**[+**_extension_**...]**  
  .IX Item "-mcpu=processor[+extension...]"
  This option specifies the target processor.  The assembler will issue an error
  message if an attempt is made to assemble an instruction which will not execute
  on the target processor.  The following processor names are recognized:
  \f(CW`cortex-a35\*(C',
  \f(CW`cortex-a53\*(C',
  \f(CW`cortex-a55\*(C',
  \f(CW`cortex-a57\*(C',
  \f(CW`cortex-a72\*(C',
  \f(CW`cortex-a73\*(C',
  \f(CW`cortex-a75\*(C',
  \f(CW`cortex-a76\*(C',
  \f(CW`exynos-m1\*(C',
  \f(CW`falkor\*(C',
  \f(CW`qdf24xx\*(C',
  \f(CW`saphira\*(C',
  \f(CW`thunderx\*(C',
  \f(CW`vulcan\*(C',
  \f(CW`xgene1\*(C'
  and
  \f(CW`xgene2\*(C'.
  The special name \f(CW`all\*(C' may be used to allow the assembler to accept
  instructions valid for any supported processor, including all optional
  extensions.
  .Sp
  In addition to the basic instruction set, the assembler can be told to
  accept, or restrict, various extension mnemonics that extend the
  processor.
  .Sp
  If some implementations of a particular processor can have an
  extension, then then those extensions are automatically enabled.
  Consequently, you will not normally have to specify any additional
  extensions.
* **-march=**_architecture_**[+**_extension_**...]**  
  .IX Item "-march=architecture[+extension...]"
  This option specifies the target architecture.  The assembler will
  issue an error message if an attempt is made to assemble an
  instruction which will not execute on the target architecture.  The
  following architecture names are recognized: \f(CW`armv8-a\*(C',
  \f(CW`armv8.1-a\*(C', \f(CW\*(C\`armv8.2-a\*(C', \f(CW\*(C\`armv8.3-a\*(C' and \f(CW\*(C\`armv8.4-a\*(C'.
  .Sp
  If both **-mcpu** and **-march** are specified, the
  assembler will use the setting for **-mcpu**.  If neither are
  specified, the assembler will default to **-mcpu=all**.
  .Sp
  The architecture option can be extended with the same instruction set
  extension options as the **-mcpu** option.  Unlike
  **-mcpu**, extensions are not always enabled by default,
* **-mverbose-error**  
  .IX Item "-mverbose-error"
  This option enables verbose error messages for AArch64 gas.  This option
  is enabled by default.
* **-mno-verbose-error**  
  .IX Item "-mno-verbose-error"
  This option disables verbose error messages in AArch64 gas.

The following options are available when as is configured for an Alpha
processor.

* **-m**_cpu_  
  .IX Item "-mcpu"
  This option specifies the target processor.  If an attempt is made to
  assemble an instruction which will not execute on the target processor,
  the assembler may either expand the instruction as a macro or issue an
  error message.  This option is equivalent to the \f(CW`.arch\*(C' directive.
  .Sp
  The following processor names are recognized:
  \f(CW21064,
  \f(CW`21064a\*(C',
  \f(CW21066,
  \f(CW21068,
  \f(CW21164,
  \f(CW`21164a\*(C',
  \f(CW`21164pc\*(C',
  \f(CW21264,
  \f(CW`21264a\*(C',
  \f(CW`21264b\*(C',
  \f(CW`ev4\*(C',
  \f(CW`ev5\*(C',
  \f(CW`lca45\*(C',
  \f(CW`ev5\*(C',
  \f(CW`ev56\*(C',
  \f(CW`pca56\*(C',
  \f(CW`ev6\*(C',
  \f(CW`ev67\*(C',
  \f(CW`ev68\*(C'.
  The special name \f(CW`all\*(C' may be used to allow the assembler to accept
  instructions valid for any Alpha processor.
  .Sp
  In order to support existing practice in \s-1OSF/1\s0 with respect to \f(CW`.arch\*(C',
  and existing practice within **\s-1MILO\s0** (the Linux \s-1ARC\s0 bootloader), the
  numbered processor names (e.g. 21064) enable the processor-specific PALcode
  instructions, while the electro-vlasic\*(R" names (e.g. \f(CW\*(C\`ev4\*(C') do not.
* **-mdebug**  
  .IX Item "-mdebug"
* **-no-mdebug**  
  .IX Item "-no-mdebug"
  Enables or disables the generation of \f(CW`.mdebug\*(C' encapsulation for
  stabs directives and procedure descriptors.  The default is to automatically
  enable \f(CW`.mdebug\*(C' when the first stabs directive is seen.
* **-relax**  
  .IX Item "-relax"
  This option forces all relocations to be put into the object file, instead
  of saving space and resolving some relocations at assembly time.  Note that
  this option does not propagate all symbol arithmetic into the object file,
  because not all symbol arithmetic can be represented.  However, the option
  can still be useful in specific applications.
* **-replace**  
  .IX Item "-replace"
* **-noreplace**  
  .IX Item "-noreplace"
  Enables or disables the optimization of procedure calls, both at assemblage
  and at link time.  These options are only available for \s-1VMS\s0 targets and
  \f(CW`-replace\*(C' is the default.  See section 1.4.1 of the OpenVMS Linker
  Utility Manual.
* **-g**  
  .IX Item "-g"
  This option is used when the compiler generates debug information.  When
  **gcc** is using **mips-tfile** to generate debug
  information for \s-1ECOFF,\s0 local labels must be passed through to the object
  file.  Otherwise this option has no effect.
* **-G**_size_  
  .IX Item "-Gsize"
  A local common symbol larger than _size_ is placed in \f(CW`.bss\*(C',
  while smaller symbols are placed in \f(CW`.sbss\*(C'.
* **-F**  
  .IX Item "-F"
* **-32addr**  
  .IX Item "-32addr"
  These options are ignored for backward compatibility.

The following options are available when as is configured for an \s-1ARC\s0
processor.

* **-mcpu=**_cpu_  
  .IX Item "-mcpu=cpu"
  This option selects the core processor variant.
* **-EB | -EL**  
  .IX Item "-EB | -EL"
  Select either big-endian (-EB) or little-endian (-EL) output.
* **-mcode-density**  
  .IX Item "-mcode-density"
  Enable Code Density extenssion instructions.

The following options are available when as is configured for the \s-1ARM\s0
processor family.

* **-mcpu=**_processor_**[+**_extension_**...]**  
  .IX Item "-mcpu=processor[+extension...]"
  Specify which \s-1ARM\s0 processor variant is the target.
* **-march=**_architecture_**[+**_extension_**...]**  
  .IX Item "-march=architecture[+extension...]"
  Specify which \s-1ARM\s0 architecture variant is used by the target.
* **-mfpu=**_floating-point-format_  
  .IX Item "-mfpu=floating-point-format"
  Select which Floating Point architecture is the target.
* **-mfloat-abi=**_abi_  
  .IX Item "-mfloat-abi=abi"
  Select which floating point \s-1ABI\s0 is in use.
* **-mthumb**  
  .IX Item "-mthumb"
  Enable Thumb only instruction decoding.
* **-mapcs-32 | -mapcs-26 | -mapcs-float | -mapcs-reentrant**  
  .IX Item "-mapcs-32 | -mapcs-26 | -mapcs-float | -mapcs-reentrant"
  Select which procedure calling convention is in use.
* **-EB | -EL**  
  .IX Item "-EB | -EL"
  Select either big-endian (-EB) or little-endian (-EL) output.
* **-mthumb-interwork**  
  .IX Item "-mthumb-interwork"
  Specify that the code has been generated with interworking between Thumb and
  \s-1ARM\s0 code in mind.
* **-mccs**  
  .IX Item "-mccs"
  Turns on CodeComposer Studio assembly syntax compatibility mode.
* **-k**  
  .IX Item "-k"
  Specify that \s-1PIC\s0 code has been generated.

The following options are available when as is configured for
the Blackfin processor family.

* **-mcpu=**_processor_[**-**_sirevision_]  
  .IX Item "-mcpu=processor[-sirevision]"
  This option specifies the target processor.  The optional _sirevision_
  is not used in assembler.  It's here such that \s-1GCC\s0 can easily pass down its
  \f(CW`-mcpu=\*(C' option.  The assembler will issue an
  error message if an attempt is made to assemble an instruction which
  will not execute on the target processor.  The following processor names are
  recognized:
  \f(CW`bf504\*(C',
  \f(CW`bf506\*(C',
  \f(CW`bf512\*(C',
  \f(CW`bf514\*(C',
  \f(CW`bf516\*(C',
  \f(CW`bf518\*(C',
  \f(CW`bf522\*(C',
  \f(CW`bf523\*(C',
  \f(CW`bf524\*(C',
  \f(CW`bf525\*(C',
  \f(CW`bf526\*(C',
  \f(CW`bf527\*(C',
  \f(CW`bf531\*(C',
  \f(CW`bf532\*(C',
  \f(CW`bf533\*(C',
  \f(CW`bf534\*(C',
  \f(CW`bf535\*(C' (not implemented yet),
  \f(CW`bf536\*(C',
  \f(CW`bf537\*(C',
  \f(CW`bf538\*(C',
  \f(CW`bf539\*(C',
  \f(CW`bf542\*(C',
  \f(CW`bf542m\*(C',
  \f(CW`bf544\*(C',
  \f(CW`bf544m\*(C',
  \f(CW`bf547\*(C',
  \f(CW`bf547m\*(C',
  \f(CW`bf548\*(C',
  \f(CW`bf548m\*(C',
  \f(CW`bf549\*(C',
  \f(CW`bf549m\*(C',
  \f(CW`bf561\*(C',
  and
  \f(CW`bf592\*(C'.
* **-mfdpic**  
  .IX Item "-mfdpic"
  Assemble for the \s-1FDPIC ABI.\s0
* **-mno-fdpic**  
  .IX Item "-mno-fdpic"
* **-mnopic**  
  .IX Item "-mnopic"
  Disable -mfdpic.

See the info pages for documentation of the CRIS-specific options.

The following options are available when as is configured for
a D10V processor.

* **-O**  
  .IX Item "-O"
  Optimize output by parallelizing instructions.

The following options are available when as is configured for a D30V
processor.

* **-O**  
  .IX Item "-O"
  Optimize output by parallelizing instructions.
* **-n**  
  .IX Item "-n"
  Warn when nops are generated.
* **-N**  
  .IX Item "-N"
  Warn when a nop after a 32-bit multiply instruction is generated.

The following options are available when as is configured for
an Epiphany processor.

* **-mepiphany**  
  .IX Item "-mepiphany"
  Specifies that the both 32 and 16 bit instructions are allowed.  This is the
  default behavior.
* **-mepiphany16**  
  .IX Item "-mepiphany16"
  Restricts the permitted instructions to just the 16 bit set.

The following options are available when as is configured for an H8/300
processor.
\f(CW@chapter H8/300 Dependent Features

<a name="options"></a>

### Options

.IX Subsection "Options"
The Renesas H8/300 version of \f(CW`as\*(C' has one
machine-dependent option:

* **-h-tick-hex**  
  .IX Item "-h-tick-hex"
  Support H'00 style hex constants in addition to 0x00 style.
* **-mach=**_name_  
  .IX Item "-mach=name"
  Sets the H8300 machine variant.  The following machine names
  are recognised:
  \f(CW`h8300h\*(C',
  \f(CW`h8300hn\*(C',
  \f(CW`h8300s\*(C',
  \f(CW`h8300sn\*(C',
  \f(CW`h8300sx\*(C' and 
  \f(CW`h8300sxn\*(C'.

The following options are available when as is configured for
an i386 processor.

* **--32 | --x32 | --64**  
  .IX Item "--32 | --x32 | --64"
  Select the word size, either 32 bits or 64 bits.  **--32**
  implies Intel i386 architecture, while **--x32** and **--64**
  imply \s-1AMD\s0 x86-64 architecture with 32-bit or 64-bit word-size
  respectively.
  .Sp
  These options are only available with the \s-1ELF\s0 object file format, and
  require that the necessary \s-1BFD\s0 support has been included (on a 32-bit
  platform you have to add --enable-64-bit-bfd to configure enable 64-bit
  usage and use x86-64 as target platform).
* **-n**  
  .IX Item "-n"
  By default, x86 \s-1GAS\s0 replaces multiple nop instructions used for
  alignment within code sections with multi-byte nop instructions such
  as leal 0(%esi,1),%esi.  This switch disables the optimization if a single
  byte nop (0x90) is explicitly specified as the fill byte for alignment.
* **--divide**  
  .IX Item "--divide"
  On SVR4-derived platforms, the character **/** is treated as a comment
  character, which means that it cannot be used in expressions.  The
  **--divide** option turns **/** into a normal character.  This does
  not disable **/** at the beginning of a line starting a comment, or
  affect using **#** for starting a comment.
* **-march=**_\s-1CPU\s0_**[+**_\s-1EXTENSION\s0_**...]**  
  .IX Item "-march=CPU[+EXTENSION...]"
  This option specifies the target processor.  The assembler will
  issue an error message if an attempt is made to assemble an instruction
  which will not execute on the target processor.  The following
  processor names are recognized:
  \f(CW`i8086\*(C',
  \f(CW`i186\*(C',
  \f(CW`i286\*(C',
  \f(CW`i386\*(C',
  \f(CW`i486\*(C',
  \f(CW`i586\*(C',
  \f(CW`i686\*(C',
  \f(CW`pentium\*(C',
  \f(CW`pentiumpro\*(C',
  \f(CW`pentiumii\*(C',
  \f(CW`pentiumiii\*(C',
  \f(CW`pentium4\*(C',
  \f(CW`prescott\*(C',
  \f(CW`nocona\*(C',
  \f(CW`core\*(C',
  \f(CW`core2\*(C',
  \f(CW`corei7\*(C',
  \f(CW`l1om\*(C',
  \f(CW`k1om\*(C',
  \f(CW`iamcu\*(C',
  \f(CW`k6\*(C',
  \f(CW`k6\_2\*(C',
  \f(CW`athlon\*(C',
  \f(CW`opteron\*(C',
  \f(CW`k8\*(C',
  \f(CW`amdfam10\*(C',
  \f(CW`bdver1\*(C',
  \f(CW`bdver2\*(C',
  \f(CW`bdver3\*(C',
  \f(CW`bdver4\*(C',
  \f(CW`znver1\*(C',
  \f(CW`znver2\*(C',
  \f(CW`btver1\*(C',
  \f(CW`btver2\*(C',
  \f(CW`generic32\*(C' and
  \f(CW`generic64\*(C'.
  .Sp
  In addition to the basic instruction set, the assembler can be told to
  accept various extension mnemonics.  For example,
  \f(CW`-march=i686+sse4+vmx\*(C' extends _i686_ with _sse4_ and
  _vmx_.  The following extensions are currently supported:
  \f(CW8087,
  \f(CW287,
  \f(CW387,
  \f(CW687,
  \f(CW`no87\*(C',
  \f(CW`no287\*(C',
  \f(CW`no387\*(C',
  \f(CW`no687\*(C',
  \f(CW`mmx\*(C',
  \f(CW`nommx\*(C',
  \f(CW`sse\*(C',
  \f(CW`sse2\*(C',
  \f(CW`sse3\*(C',
  \f(CW`ssse3\*(C',
  \f(CW`sse4.1\*(C',
  \f(CW`sse4.2\*(C',
  \f(CW`sse4\*(C',
  \f(CW`nosse\*(C',
  \f(CW`nosse2\*(C',
  \f(CW`nosse3\*(C',
  \f(CW`nossse3\*(C',
  \f(CW`nosse4.1\*(C',
  \f(CW`nosse4.2\*(C',
  \f(CW`nosse4\*(C',
  \f(CW`avx\*(C',
  \f(CW`avx2\*(C',
  \f(CW`noavx\*(C',
  \f(CW`noavx2\*(C',
  \f(CW`adx\*(C',
  \f(CW`rdseed\*(C',
  \f(CW`prfchw\*(C',
  \f(CW`smap\*(C',
  \f(CW`mpx\*(C',
  \f(CW`sha\*(C',
  \f(CW`rdpid\*(C',
  \f(CW`ptwrite\*(C',
  \f(CW`cet\*(C',
  \f(CW`gfni\*(C',
  \f(CW`vaes\*(C',
  \f(CW`vpclmulqdq\*(C',
  \f(CW`prefetchwt1\*(C',
  \f(CW`clflushopt\*(C',
  \f(CW`se1\*(C',
  \f(CW`clwb\*(C',
  \f(CW`movdiri\*(C',
  \f(CW`movdir64b\*(C',
  \f(CW`avx512f\*(C',
  \f(CW`avx512cd\*(C',
  \f(CW`avx512er\*(C',
  \f(CW`avx512pf\*(C',
  \f(CW`avx512vl\*(C',
  \f(CW`avx512bw\*(C',
  \f(CW`avx512dq\*(C',
  \f(CW`avx512ifma\*(C',
  \f(CW`avx512vbmi\*(C',
  \f(CW`avx512\_4fmaps\*(C',
  \f(CW`avx512\_4vnniw\*(C',
  \f(CW`avx512\_vpopcntdq\*(C',
  \f(CW`avx512\_vbmi2\*(C',
  \f(CW`avx512\_vnni\*(C',
  \f(CW`avx512\_bitalg\*(C',
  \f(CW`noavx512f\*(C',
  \f(CW`noavx512cd\*(C',
  \f(CW`noavx512er\*(C',
  \f(CW`noavx512pf\*(C',
  \f(CW`noavx512vl\*(C',
  \f(CW`noavx512bw\*(C',
  \f(CW`noavx512dq\*(C',
  \f(CW`noavx512ifma\*(C',
  \f(CW`noavx512vbmi\*(C',
  \f(CW`noavx512\_4fmaps\*(C',
  \f(CW`noavx512\_4vnniw\*(C',
  \f(CW`noavx512\_vpopcntdq\*(C',
  \f(CW`noavx512\_vbmi2\*(C',
  \f(CW`noavx512\_vnni\*(C',
  \f(CW`noavx512\_bitalg\*(C',
  \f(CW`vmx\*(C',
  \f(CW`vmfunc\*(C',
  \f(CW`smx\*(C',
  \f(CW`xsave\*(C',
  \f(CW`xsaveopt\*(C',
  \f(CW`xsavec\*(C',
  \f(CW`xsaves\*(C',
  \f(CW`aes\*(C',
  \f(CW`pclmul\*(C',
  \f(CW`fsgsbase\*(C',
  \f(CW`rdrnd\*(C',
  \f(CW`f16c\*(C',
  \f(CW`bmi2\*(C',
  \f(CW`fma\*(C',
  \f(CW`movbe\*(C',
  \f(CW`ept\*(C',
  \f(CW`lzcnt\*(C',
  \f(CW`hle\*(C',
  \f(CW`rtm\*(C',
  \f(CW`invpcid\*(C',
  \f(CW`clflush\*(C',
  \f(CW`mwaitx\*(C',
  \f(CW`clzero\*(C',
  \f(CW`wbnoinvd\*(C',
  \f(CW`pconfig\*(C',
  \f(CW`waitpkg\*(C',
  \f(CW`cldemote\*(C',
  \f(CW`lwp\*(C',
  \f(CW`fma4\*(C',
  \f(CW`xop\*(C',
  \f(CW`cx16\*(C',
  \f(CW`syscall\*(C',
  \f(CW`rdtscp\*(C',
  \f(CW`3dnow\*(C',
  \f(CW`3dnowa\*(C',
  \f(CW`sse4a\*(C',
  \f(CW`sse5\*(C',
  \f(CW`svme\*(C',
  \f(CW`abm\*(C' and
  \f(CW`padlock\*(C'.
  Note that rather than extending a basic instruction set, the extension
  mnemonics starting with \f(CW`no\*(C' revoke the respective functionality.
  .Sp
  When the \f(CW`.arch\*(C' directive is used with **-march**, the
  \f(CW`.arch\*(C' directive will take precedent.
* **-mtune=**_\s-1CPU\s0_  
  .IX Item "-mtune=CPU"
  This option specifies a processor to optimize for. When used in
  conjunction with the **-march** option, only instructions
  of the processor specified by the **-march** option will be
  generated.
  .Sp
  Valid _\s-1CPU\s0_ values are identical to the processor list of
  **-march=**_\s-1CPU\s0_.
* **-msse2avx**  
  .IX Item "-msse2avx"
  This option specifies that the assembler should encode \s-1SSE\s0 instructions
  with \s-1VEX\s0 prefix.
* **-msse-check=**_none_  
  .IX Item "-msse-check=none"
* **-msse-check=**_warning_  
  .IX Item "-msse-check=warning"
* **-msse-check=**_error_  
  .IX Item "-msse-check=error"
  These options control if the assembler should check \s-1SSE\s0 instructions.
  **-msse-check=**_none_ will make the assembler not to check \s-1SSE\s0
  instructions,  which is the default.  **-msse-check=**_warning_
  will make the assembler issue a warning for any \s-1SSE\s0 instruction.
  **-msse-check=**_error_ will make the assembler issue an error
  for any \s-1SSE\s0 instruction.
* **-mavxscalar=**_128_  
  .IX Item "-mavxscalar=128"
* **-mavxscalar=**_256_  
  .IX Item "-mavxscalar=256"
  These options control how the assembler should encode scalar \s-1AVX\s0
  instructions.  **-mavxscalar=**_128_ will encode scalar
  \s-1AVX\s0 instructions with 128bit vector length, which is the default.
  **-mavxscalar=**_256_ will encode scalar \s-1AVX\s0 instructions
  with 256bit vector length.
* **-mevexlig=**_128_  
  .IX Item "-mevexlig=128"
* **-mevexlig=**_256_  
  .IX Item "-mevexlig=256"
* **-mevexlig=**_512_  
  .IX Item "-mevexlig=512"
  These options control how the assembler should encode length-ignored
  (\s-1LIG\s0) \s-1EVEX\s0 instructions.  **-mevexlig=**_128_ will encode \s-1LIG
  EVEX\s0 instructions with 128bit vector length, which is the default.
  **-mevexlig=**_256_ and **-mevexlig=**_512_ will
  encode \s-1LIG EVEX\s0 instructions with 256bit and 512bit vector length,
  respectively.
* **-mevexwig=**_0_  
  .IX Item "-mevexwig=0"
* **-mevexwig=**_1_  
  .IX Item "-mevexwig=1"
  These options control how the assembler should encode w-ignored (\s-1WIG\s0)
  \s-1EVEX\s0 instructions.  **-mevexwig=**_0_ will encode \s-1WIG
  EVEX\s0 instructions with evex.w = 0, which is the default.
  **-mevexwig=**_1_ will encode \s-1WIG EVEX\s0 instructions with
  evex.w = 1.
* **-mmnemonic=**_att_  
  .IX Item "-mmnemonic=att"
* **-mmnemonic=**_intel_  
  .IX Item "-mmnemonic=intel"
  This option specifies instruction mnemonic for matching instructions.
  The \f(CW`.att\_mnemonic\*(C' and \f(CW\*(C\`.intel\_mnemonic\*(C' directives will
  take precedent.
* **-msyntax=**_att_  
  .IX Item "-msyntax=att"
* **-msyntax=**_intel_  
  .IX Item "-msyntax=intel"
  This option specifies instruction syntax when processing instructions.
  The \f(CW`.att\_syntax\*(C' and \f(CW\*(C\`.intel\_syntax\*(C' directives will
  take precedent.
* **-mnaked-reg**  
  .IX Item "-mnaked-reg"
  This option specifies that registers don't require a **%** prefix.
  The \f(CW`.att\_syntax\*(C' and \f(CW\*(C\`.intel\_syntax\*(C' directives will take precedent.
* **-madd-bnd-prefix**  
  .IX Item "-madd-bnd-prefix"
  This option forces the assembler to add \s-1BND\s0 prefix to all branches, even
  if such prefix was not explicitly specified in the source code.
* **-mno-shared**  
  .IX Item "-mno-shared"
  On \s-1ELF\s0 target, the assembler normally optimizes out non-PLT relocations
  against defined non-weak global branch targets with default visibility.
  The **-mshared** option tells the assembler to generate code which
  may go into a shared library where all non-weak global branch targets
  with default visibility can be preempted.  The resulting code is
  slightly bigger.  This option only affects the handling of branch
  instructions.
* **-mbig-obj**  
  .IX Item "-mbig-obj"
  On x86-64 \s-1PE/COFF\s0 target this option forces the use of big object file
  format, which allows more than 32768 sections.
* **-momit-lock-prefix=**_no_  
  .IX Item "-momit-lock-prefix=no"
* **-momit-lock-prefix=**_yes_  
  .IX Item "-momit-lock-prefix=yes"
  These options control how the assembler should encode lock prefix.
  This option is intended as a workaround for processors, that fail on
  lock prefix. This option can only be safely used with single-core,
  single-thread computers
  **-momit-lock-prefix=**_yes_ will omit all lock prefixes.
  **-momit-lock-prefix=**_no_ will encode lock prefix as usual,
  which is the default.
* **-mfence-as-lock-add=**_no_  
  .IX Item "-mfence-as-lock-add=no"
* **-mfence-as-lock-add=**_yes_  
  .IX Item "-mfence-as-lock-add=yes"
  These options control how the assembler should encode lfence, mfence and
  sfence.
  **-mfence-as-lock-add=**_yes_ will encode lfence, mfence and
  sfence as **lock addl \f(CB$0x0, (%rsp)** in 64-bit mode and
  **lock addl \f(CB$0x0, (%esp)** in 32-bit mode.
  **-mfence-as-lock-add=**_no_ will encode lfence, mfence and
  sfence as usual, which is the default.
* **-mrelax-relocations=**_no_  
  .IX Item "-mrelax-relocations=no"
* **-mrelax-relocations=**_yes_  
  .IX Item "-mrelax-relocations=yes"
  These options control whether the assembler should generate relax
  relocations, R_386_GOT32X, in 32-bit mode, or R_X86_64_GOTPCRELX and
  R_X86_64_REX_GOTPCRELX, in 64-bit mode.
  **-mrelax-relocations=**_yes_ will generate relax relocations.
  **-mrelax-relocations=**_no_ will not generate relax
  relocations.  The default can be controlled by a configure option
  **--enable-x86-relax-relocations**.
* **-mevexrcig=**_rne_  
  .IX Item "-mevexrcig=rne"
* **-mevexrcig=**_rd_  
  .IX Item "-mevexrcig=rd"
* **-mevexrcig=**_ru_  
  .IX Item "-mevexrcig=ru"
* **-mevexrcig=**_rz_  
  .IX Item "-mevexrcig=rz"
  These options control how the assembler should encode SAE-only
  \s-1EVEX\s0 instructions.  **-mevexrcig=**_rne_ will encode \s-1RC\s0 bits
  of \s-1EVEX\s0 instruction with 00, which is the default.
  **-mevexrcig=**_rd_, **-mevexrcig=**_ru_
  and **-mevexrcig=**_rz_ will encode SAE-only \s-1EVEX\s0 instructions
  with 01, 10 and 11 \s-1RC\s0 bits, respectively.
* **-mamd64**  
  .IX Item "-mamd64"
* **-mintel64**  
  .IX Item "-mintel64"
  This option specifies that the assembler should accept only \s-1AMD64\s0 or
  Intel64 \s-1ISA\s0 in 64-bit mode.  The default is to accept both.
* **-O0 | -O | -O1 | -O2 | -Os**  
  .IX Item "-O0 | -O | -O1 | -O2 | -Os"
  Optimize instruction encoding with smaller instruction size.  **-O**
  and **-O1** encode 64-bit register load instructions with 64-bit
  immediate as 32-bit register load instructions with 31-bit or 32-bits
  immediates and encode 64-bit register clearing instructions with 32-bit
  register clearing instructions.  **-O2** includes **-O1**
  optimization plus encodes 256-bit and 512-bit vector register clearing
  instructions with 128-bit vector register clearing instructions.
  **-Os** includes **-O2** optimization plus encodes 16-bit, 32-bit
  and 64-bit register tests with immediate as 8-bit register test with
  immediate.  **-O0** turns off this optimization.

The following options are available when as is configured for the
Ubicom \s-1IP2K\s0 series.

* **-mip2022ext**  
  .IX Item "-mip2022ext"
  Specifies that the extended \s-1IP2022\s0 instructions are allowed.
* **-mip2022**  
  .IX Item "-mip2022"
  Restores the default behaviour, which restricts the permitted instructions to
  just the basic \s-1IP2022\s0 ones.

The following options are available when as is configured for the
Renesas M32C and M16C processors.

* **-m32c**  
  .IX Item "-m32c"
  Assemble M32C instructions.
* **-m16c**  
  .IX Item "-m16c"
  Assemble M16C instructions (the default).
* **-relax**  
  .IX Item "-relax"
  Enable support for link-time relaxations.
* **-h-tick-hex**  
  .IX Item "-h-tick-hex"
  Support H'00 style hex constants in addition to 0x00 style.

The following options are available when as is configured for the
Renesas M32R (formerly Mitsubishi M32R) series.

* **--m32rx**  
  .IX Item "--m32rx"
  Specify which processor in the M32R family is the target.  The default
  is normally the M32R, but this option changes it to the M32RX.
* **--warn-explicit-parallel-conflicts or --Wp**  
  .IX Item "--warn-explicit-parallel-conflicts or --Wp"
  Produce warning messages when questionable parallel constructs are
  encountered.
* **--no-warn-explicit-parallel-conflicts or --Wnp**  
  .IX Item "--no-warn-explicit-parallel-conflicts or --Wnp"
  Do not produce warning messages when questionable parallel constructs are
  encountered.

The following options are available when as is configured for the
Motorola 68000 series.

* **-l**  
  .IX Item "-l"
  Shorten references to undefined symbols, to one word instead of two.
* **-m68000 | -m68008 | -m68010 | -m68020 | -m68030**  
  .IX Item "-m68000 | -m68008 | -m68010 | -m68020 | -m68030"
* **| -m68040 | -m68060 | -m68302 | -m68331 | -m68332**  
  .IX Item "| -m68040 | -m68060 | -m68302 | -m68331 | -m68332"
* **| -m68333 | -m68340 | -mcpu32 | -m5200**  
  .IX Item "| -m68333 | -m68340 | -mcpu32 | -m5200"
  Specify what processor in the 68000 family is the target.  The default
  is normally the 68020, but this can be changed at configuration time.
* **-m68881 | -m68882 | -mno-68881 | -mno-68882**  
  .IX Item "-m68881 | -m68882 | -mno-68881 | -mno-68882"
  The target machine does (or does not) have a floating-point coprocessor.
  The default is to assume a coprocessor for 68020, 68030, and cpu32.  Although
  the basic 68000 is not compatible with the 68881, a combination of the
  two can be specified, since it's possible to do emulation of the
  coprocessor instructions with the main processor.
* **-m68851 | -mno-68851**  
  .IX Item "-m68851 | -mno-68851"
  The target machine does (or does not) have a memory-management
  unit coprocessor.  The default is to assume an \s-1MMU\s0 for 68020 and up.

The following options are available when as is configured for an
Altera Nios \s-1II\s0 processor.

* **-relax-section**  
  .IX Item "-relax-section"
  Replace identified out-of-range branches with PC-relative \f(CW`jmp\*(C'
  sequences when possible.  The generated code sequences are suitable
  for use in position-independent code, but there is a practical limit
  on the extended branch range because of the length of the sequences.
  This option is the default.
* **-relax-all**  
  .IX Item "-relax-all"
  Replace branch instructions not determinable to be in range
  and all call instructions with \f(CW`jmp\*(C' and \f(CW\*(C\`callr\*(C' sequences
  (respectively).  This option generates absolute relocations against the
  target symbols and is not appropriate for position-independent code.
* **-no-relax**  
  .IX Item "-no-relax"
  Do not replace any branches or calls.
* **-EB**  
  .IX Item "-EB"
  Generate big-endian output.
* **-EL**  
  .IX Item "-EL"
  Generate little-endian output.  This is the default.
* **-march=**_architecture_  
  .IX Item "-march=architecture"
  This option specifies the target architecture.  The assembler issues
  an error message if an attempt is made to assemble an instruction which
  will not execute on the target architecture.  The following architecture
  names are recognized:
  \f(CW`r1\*(C',
  \f(CW`r2\*(C'.  
  The default is \f(CW`r1\*(C'.

The following options are available when as is configured for a
\s-1PRU\s0 processor.

* **-mlink-relax**  
  .IX Item "-mlink-relax"
  Assume that \s-1LD\s0 would optimize \s-1LDI32\s0 instructions by checking the upper
  16 bits of the _expression_. If they are all zeros, then \s-1LD\s0 would
  shorten the \s-1LDI32\s0 instruction to a single \s-1LDI.\s0 In such case \f(CW`as\*(C'
  will output \s-1DIFF\s0 relocations for diff expressions.
* **-mno-link-relax**  
  .IX Item "-mno-link-relax"
  Assume that \s-1LD\s0 would not optimize \s-1LDI32\s0 instructions. As a consequence,
  \s-1DIFF\s0 relocations will not be emitted.
* **-mno-warn-regname-label**  
  .IX Item "-mno-warn-regname-label"
  Do not warn if a label name matches a register name. Usually assembler
  programmers will want this warning to be emitted. C compilers may want
  to turn this off.

The following options are available when as is configured for
a \s-1MIPS\s0 processor.

* **-G** _num_  
  .IX Item "-G num"
  This option sets the largest size of an object that can be referenced
  implicitly with the \f(CW`gp\*(C' register.  It is only accepted for targets that
  use \s-1ECOFF\s0 format, such as a DECstation running Ultrix.  The default value is 8.
* **-EB**  
  .IX Item "-EB"
  Generate big endian\*(R" format output.
* **-EL**  
  .IX Item "-EL"
  Generate little endian\*(R" format output.
* **-mips1**  
  .IX Item "-mips1"
* **-mips2**  
  .IX Item "-mips2"
* **-mips3**  
  .IX Item "-mips3"
* **-mips4**  
  .IX Item "-mips4"
* **-mips5**  
  .IX Item "-mips5"
* **-mips32**  
  .IX Item "-mips32"
* **-mips32r2**  
  .IX Item "-mips32r2"
* **-mips32r3**  
  .IX Item "-mips32r3"
* **-mips32r5**  
  .IX Item "-mips32r5"
* **-mips32r6**  
  .IX Item "-mips32r6"
* **-mips64**  
  .IX Item "-mips64"
* **-mips64r2**  
  .IX Item "-mips64r2"
* **-mips64r3**  
  .IX Item "-mips64r3"
* **-mips64r5**  
  .IX Item "-mips64r5"
* **-mips64r6**  
  .IX Item "-mips64r6"
  Generate code for a particular \s-1MIPS\s0 Instruction Set Architecture level.
  **-mips1** is an alias for **-march=r3000**, **-mips2** is an
  alias for **-march=r6000**, **-mips3** is an alias for
  **-march=r4000** and **-mips4** is an alias for **-march=r8000**.
  **-mips5**, **-mips32**, **-mips32r2**, **-mips32r3**,
  **-mips32r5**, **-mips32r6**, **-mips64**, **-mips64r2**,
  **-mips64r3**, **-mips64r5**, and **-mips64r6** correspond to generic
  \s-1MIPS V, MIPS32, MIPS32\s0 Release 2, \s-1MIPS32\s0 Release 3, \s-1MIPS32\s0 Release 5, \s-1MIPS32\s0
  Release 6, \s-1MIPS64, MIPS64\s0 Release 2, \s-1MIPS64\s0 Release 3, \s-1MIPS64\s0 Release 5, and
  \s-1MIPS64\s0 Release 6 \s-1ISA\s0 processors, respectively.
* **-march=**_cpu_  
  .IX Item "-march=cpu"
  Generate code for a particular \s-1MIPS CPU.\s0
* **-mtune=**_cpu_  
  .IX Item "-mtune=cpu"
  Schedule and tune for a particular \s-1MIPS CPU.\s0
* **-mfix7000**  
  .IX Item "-mfix7000"
* **-mno-fix7000**  
  .IX Item "-mno-fix7000"
  Cause nops to be inserted if the read of the destination register
  of an mfhi or mflo instruction occurs in the following two instructions.
* **-mfix-rm7000**  
  .IX Item "-mfix-rm7000"
* **-mno-fix-rm7000**  
  .IX Item "-mno-fix-rm7000"
  Cause nops to be inserted if a dmult or dmultu instruction is
  followed by a load instruction.
* **-mdebug**  
  .IX Item "-mdebug"
* **-no-mdebug**  
  .IX Item "-no-mdebug"
  Cause stabs-style debugging output to go into an ECOFF-style .mdebug
  section instead of the standard \s-1ELF\s0 .stabs sections.
* **-mpdr**  
  .IX Item "-mpdr"
* **-mno-pdr**  
  .IX Item "-mno-pdr"
  Control generation of \f(CW`.pdr\*(C' sections.
* **-mgp32**  
  .IX Item "-mgp32"
* **-mfp32**  
  .IX Item "-mfp32"
  The register sizes are normally inferred from the \s-1ISA\s0 and \s-1ABI,\s0 but these
  flags force a certain group of registers to be treated as 32 bits wide at
  all times.  **-mgp32** controls the size of general-purpose registers
  and **-mfp32** controls the size of floating-point registers.
* **-mgp64**  
  .IX Item "-mgp64"
* **-mfp64**  
  .IX Item "-mfp64"
  The register sizes are normally inferred from the \s-1ISA\s0 and \s-1ABI,\s0 but these
  flags force a certain group of registers to be treated as 64 bits wide at
  all times.  **-mgp64** controls the size of general-purpose registers
  and **-mfp64** controls the size of floating-point registers.
* **-mfpxx**  
  .IX Item "-mfpxx"
  The register sizes are normally inferred from the \s-1ISA\s0 and \s-1ABI,\s0 but using
  this flag in combination with **-mabi=32** enables an \s-1ABI\s0 variant
  which will operate correctly with floating-point registers which are
  32 or 64 bits wide.
* **-modd-spreg**  
  .IX Item "-modd-spreg"
* **-mno-odd-spreg**  
  .IX Item "-mno-odd-spreg"
  Enable use of floating-point operations on odd-numbered single-precision
  registers when supported by the \s-1ISA.\s0  **-mfpxx** implies
  **-mno-odd-spreg**, otherwise the default is **-modd-spreg**.
* **-mips16**  
  .IX Item "-mips16"
* **-no-mips16**  
  .IX Item "-no-mips16"
  Generate code for the \s-1MIPS 16\s0 processor.  This is equivalent to putting
  \f(CW`.module mips16\*(C' at the start of the assembly file.  **-no-mips16**
  turns off this option.
* **-mmips16e2**  
  .IX Item "-mmips16e2"
* **-mno-mips16e2**  
  .IX Item "-mno-mips16e2"
  Enable the use of MIPS16e2 instructions in \s-1MIPS16\s0 mode.  This is equivalent
  to putting \f(CW`.module mips16e2\*(C' at the start of the assembly file.
  **-mno-mips16e2** turns off this option.
* **-mmicromips**  
  .IX Item "-mmicromips"
* **-mno-micromips**  
  .IX Item "-mno-micromips"
  Generate code for the microMIPS processor.  This is equivalent to putting
  \f(CW`.module micromips\*(C' at the start of the assembly file.
  **-mno-micromips** turns off this option.  This is equivalent to putting
  \f(CW`.module nomicromips\*(C' at the start of the assembly file.
* **-msmartmips**  
  .IX Item "-msmartmips"
* **-mno-smartmips**  
  .IX Item "-mno-smartmips"
  Enables the SmartMIPS extension to the \s-1MIPS32\s0 instruction set.  This is
  equivalent to putting \f(CW`.module smartmips\*(C' at the start of the assembly
  file.  **-mno-smartmips** turns off this option.
* **-mips3d**  
  .IX Item "-mips3d"
* **-no-mips3d**  
  .IX Item "-no-mips3d"
  Generate code for the \s-1MIPS-3D\s0 Application Specific Extension.
  This tells the assembler to accept \s-1MIPS-3D\s0 instructions.
  **-no-mips3d** turns off this option.
* **-mdmx**  
  .IX Item "-mdmx"
* **-no-mdmx**  
  .IX Item "-no-mdmx"
  Generate code for the \s-1MDMX\s0 Application Specific Extension.
  This tells the assembler to accept \s-1MDMX\s0 instructions.
  **-no-mdmx** turns off this option.
* **-mdsp**  
  .IX Item "-mdsp"
* **-mno-dsp**  
  .IX Item "-mno-dsp"
  Generate code for the \s-1DSP\s0 Release 1 Application Specific Extension.
  This tells the assembler to accept \s-1DSP\s0 Release 1 instructions.
  **-mno-dsp** turns off this option.
* **-mdspr2**  
  .IX Item "-mdspr2"
* **-mno-dspr2**  
  .IX Item "-mno-dspr2"
  Generate code for the \s-1DSP\s0 Release 2 Application Specific Extension.
  This option implies **-mdsp**.
  This tells the assembler to accept \s-1DSP\s0 Release 2 instructions.
  **-mno-dspr2** turns off this option.
* **-mdspr3**  
  .IX Item "-mdspr3"
* **-mno-dspr3**  
  .IX Item "-mno-dspr3"
  Generate code for the \s-1DSP\s0 Release 3 Application Specific Extension.
  This option implies **-mdsp** and **-mdspr2**.
  This tells the assembler to accept \s-1DSP\s0 Release 3 instructions.
  **-mno-dspr3** turns off this option.
* **-mmsa**  
  .IX Item "-mmsa"
* **-mno-msa**  
  .IX Item "-mno-msa"
  Generate code for the \s-1MIPS SIMD\s0 Architecture Extension.
  This tells the assembler to accept \s-1MSA\s0 instructions.
  **-mno-msa** turns off this option.
* **-mxpa**  
  .IX Item "-mxpa"
* **-mno-xpa**  
  .IX Item "-mno-xpa"
  Generate code for the \s-1MIPS\s0 eXtended Physical Address (\s-1XPA\s0) Extension.
  This tells the assembler to accept \s-1XPA\s0 instructions.
  **-mno-xpa** turns off this option.
* **-mmt**  
  .IX Item "-mmt"
* **-mno-mt**  
  .IX Item "-mno-mt"
  Generate code for the \s-1MT\s0 Application Specific Extension.
  This tells the assembler to accept \s-1MT\s0 instructions.
  **-mno-mt** turns off this option.
* **-mmcu**  
  .IX Item "-mmcu"
* **-mno-mcu**  
  .IX Item "-mno-mcu"
  Generate code for the \s-1MCU\s0 Application Specific Extension.
  This tells the assembler to accept \s-1MCU\s0 instructions.
  **-mno-mcu** turns off this option.
* **-mcrc**  
  .IX Item "-mcrc"
* **-mno-crc**  
  .IX Item "-mno-crc"
  Generate code for the \s-1MIPS\s0 cyclic redundancy check (\s-1CRC\s0) Application
  Specific Extension.  This tells the assembler to accept \s-1CRC\s0 instructions.
  **-mno-crc** turns off this option.
* **-mginv**  
  .IX Item "-mginv"
* **-mno-ginv**  
  .IX Item "-mno-ginv"
  Generate code for the Global INValidate (\s-1GINV\s0) Application Specific
  Extension.  This tells the assembler to accept \s-1GINV\s0 instructions.
  **-mno-ginv** turns off this option.
* **-minsn32**  
  .IX Item "-minsn32"
* **-mno-insn32**  
  .IX Item "-mno-insn32"
  Only use 32-bit instruction encodings when generating code for the
  microMIPS processor.  This option inhibits the use of any 16-bit
  instructions.  This is equivalent to putting \f(CW`.set insn32\*(C' at
  the start of the assembly file.  **-mno-insn32** turns off this
  option.  This is equivalent to putting \f(CW`.set noinsn32\*(C' at the
  start of the assembly file.  By default **-mno-insn32** is
  selected, allowing all instructions to be used.
* **--construct-floats**  
  .IX Item "--construct-floats"
* **--no-construct-floats**  
  .IX Item "--no-construct-floats"
  The **--no-construct-floats** option disables the construction of
  double width floating point constants by loading the two halves of the
  value into the two single width floating point registers that make up
  the double width register.  By default **--construct-floats** is
  selected, allowing construction of these floating point constants.
* **--relax-branch**  
  .IX Item "--relax-branch"
* **--no-relax-branch**  
  .IX Item "--no-relax-branch"
  The **--relax-branch** option enables the relaxation of out-of-range
  branches.  By default **--no-relax-branch** is selected, causing any
  out-of-range branches to produce an error.
* **-mignore-branch-isa**  
  .IX Item "-mignore-branch-isa"
* **-mno-ignore-branch-isa**  
  .IX Item "-mno-ignore-branch-isa"
  Ignore branch checks for invalid transitions between \s-1ISA\s0 modes.  The
  semantics of branches does not provide for an \s-1ISA\s0 mode switch, so in
  most cases the \s-1ISA\s0 mode a branch has been encoded for has to be the
  same as the \s-1ISA\s0 mode of the branch's target label.  Therefore \s-1GAS\s0 has
  checks implemented that verify in branch assembly that the two \s-1ISA\s0
  modes match.  **-mignore-branch-isa** disables these checks.  By
  default **-mno-ignore-branch-isa** is selected, causing any invalid
  branch requiring a transition between \s-1ISA\s0 modes to produce an error.
* **-mnan=**_encoding_  
  .IX Item "-mnan=encoding"
  Select between the \s-1IEEE 754-2008\s0 (**-mnan=2008**) or the legacy
  (**-mnan=legacy**) NaN encoding format.  The latter is the default.
* **--emulation=**_name_  
  .IX Item "--emulation=name"
  This option was formerly used to switch between \s-1ELF\s0 and \s-1ECOFF\s0 output
  on targets like \s-1IRIX 5\s0 that supported both.  \s-1MIPS ECOFF\s0 support was
  removed in \s-1GAS 2.24,\s0 so the option now serves little purpose.
  It is retained for backwards compatibility.
  .Sp
  The available configuration names are: **mipself**, **mipslelf** and
  **mipsbelf**.  Choosing **mipself** now has no effect, since the output
  is always \s-1ELF.\s0  **mipslelf** and **mipsbelf** select little- and
  big-endian output respectively, but **-EL** and **-EB** are now the
  preferred options instead.
* **-nocpp**  
  .IX Item "-nocpp"
  **as** ignores this option.  It is accepted for compatibility with
  the native tools.
* **--trap**  
  .IX Item "--trap"
* **--no-trap**  
  .IX Item "--no-trap"
* **--break**  
  .IX Item "--break"
* **--no-break**  
  .IX Item "--no-break"
  Control how to deal with multiplication overflow and division by zero.
  **--trap** or **--no-break** (which are synonyms) take a trap exception
  (and only work for Instruction Set Architecture level 2 and higher);
  **--break** or **--no-trap** (also synonyms, and the default) take a
  break exception.
* **-n**  
  .IX Item "-n"
  When this option is used, **as** will issue a warning every
  time it generates a nop instruction from a macro.

The following options are available when as is configured for a
Meta processor.
.ie n .IP """-mcpu=metac11""" 4
.el .IP "\f(CW-mcpu=metac11" 4
.IX Item "-mcpu=metac11"
Generate code for Meta 1.1.
.ie n .IP """-mcpu=metac12""" 4
.el .IP "\f(CW-mcpu=metac12" 4
.IX Item "-mcpu=metac12"
Generate code for Meta 1.2.
.ie n .IP """-mcpu=metac21""" 4
.el .IP "\f(CW-mcpu=metac21" 4
.IX Item "-mcpu=metac21"
Generate code for Meta 2.1.
.ie n .IP """-mfpu=metac21""" 4
.el .IP "\f(CW-mfpu=metac21" 4
.IX Item "-mfpu=metac21"
Allow code to use \s-1FPU\s0 hardware of Meta 2.1.

See the info pages for documentation of the MMIX-specific options.

The following options are available when as is configured for a
\s-1NDS32\s0 processor.
.ie n .IP """-O1""" 4
.el .IP "\f(CW-O1" 4
.IX Item "-O1"
Optimize for performance.
.ie n .IP """-Os""" 4
.el .IP "\f(CW-Os" 4
.IX Item "-Os"
Optimize for space.
.ie n .IP """-EL""" 4
.el .IP "\f(CW-EL" 4
.IX Item "-EL"
Produce little endian data output.
.ie n .IP """-EB""" 4
.el .IP "\f(CW-EB" 4
.IX Item "-EB"
Produce little endian data output.
.ie n .IP """-mpic""" 4
.el .IP "\f(CW-mpic" 4
.IX Item "-mpic"
Generate \s-1PIC.\s0
.ie n .IP """-mno-fp-as-gp-relax""" 4
.el .IP "\f(CW-mno-fp-as-gp-relax" 4
.IX Item "-mno-fp-as-gp-relax"
Suppress fp-as-gp relaxation for this file.
.ie n .IP """-mb2bb-relax""" 4
.el .IP "\f(CW-mb2bb-relax" 4
.IX Item "-mb2bb-relax"
Back-to-back branch optimization.
.ie n .IP """-mno-all-relax""" 4
.el .IP "\f(CW-mno-all-relax" 4
.IX Item "-mno-all-relax"
Suppress all relaxation for this file.
.ie n .IP """-march=&lt;arch name&gt;""" 4
.el .IP "\f(CW-march=&lt;arch name&gt;" 4
.IX Item "-march=&lt;arch name&gt;"
Assemble for architecture &lt;arch name&gt; which could be v3, v3j, v3m, v3f,
v3s, v2, v2j, v2f, v2s.
.ie n .IP """-mbaseline=&lt;baseline&gt;""" 4
.el .IP "\f(CW-mbaseline=&lt;baseline&gt;" 4
.IX Item "-mbaseline=&lt;baseline&gt;"
Assemble for baseline &lt;baseline&gt; which could be v2, v3, v3m.
.ie n .IP """-mfpu-freg=_FREG_""" 4
.el .IP "\f(CW-mfpu-freg=\f(CIFREG\f(CW" 4
.IX Item "-mfpu-freg=FREG"
Specify a \s-1FPU\s0 configuration.
.ie n .IP """0      8 SP /  4 DP registers""" 4
.el .IP "\f(CW0      8 SP /  4 DP registers" 4
.IX Item "0 8 SP / 4 DP registers"
.ie n .IP """1     16 SP /  8 DP registers""" 4
.el .IP "\f(CW1     16 SP /  8 DP registers" 4
.IX Item "1 16 SP / 8 DP registers"
.ie n .IP """2     32 SP / 16 DP registers""" 4
.el .IP "\f(CW2     32 SP / 16 DP registers" 4
.IX Item "2 32 SP / 16 DP registers"
.ie n .IP """3     32 SP / 32 DP registers""" 4
.el .IP "\f(CW3     32 SP / 32 DP registers" 4
.IX Item "3 32 SP / 32 DP registers"
.ie n .IP """-mabi=_abi_""" 4
.el .IP "\f(CW-mabi=\f(CIabi\f(CW" 4
.IX Item "-mabi=abi"
Specify a abi version &lt;abi&gt; could be v1, v2, v2fp, v2fpp.
.ie n .IP """-m[no-]mac""" 4
.el .IP "\f(CW-m[no-]mac" 4
.IX Item "-m[no-]mac"
Enable/Disable Multiply instructions support.
.ie n .IP """-m[no-]div""" 4
.el .IP "\f(CW-m[no-]div" 4
.IX Item "-m[no-]div"
Enable/Disable Divide instructions support.
.ie n .IP """-m[no-]16bit-ext""" 4
.el .IP "\f(CW-m[no-]16bit-ext" 4
.IX Item "-m[no-]16bit-ext"
Enable/Disable 16-bit extension
.ie n .IP """-m[no-]dx-regs""" 4
.el .IP "\f(CW-m[no-]dx-regs" 4
.IX Item "-m[no-]dx-regs"
Enable/Disable d0/d1 registers
.ie n .IP """-m[no-]perf-ext""" 4
.el .IP "\f(CW-m[no-]perf-ext" 4
.IX Item "-m[no-]perf-ext"
Enable/Disable Performance extension
.ie n .IP """-m[no-]perf2-ext""" 4
.el .IP "\f(CW-m[no-]perf2-ext" 4
.IX Item "-m[no-]perf2-ext"
Enable/Disable Performance extension 2
.ie n .IP """-m[no-]string-ext""" 4
.el .IP "\f(CW-m[no-]string-ext" 4
.IX Item "-m[no-]string-ext"
Enable/Disable String extension
.ie n .IP """-m[no-]reduced-regs""" 4
.el .IP "\f(CW-m[no-]reduced-regs" 4
.IX Item "-m[no-]reduced-regs"
Enable/Disable Reduced Register configuration (\s-1GPR16\s0) option
.ie n .IP """-m[no-]audio-isa-ext""" 4
.el .IP "\f(CW-m[no-]audio-isa-ext" 4
.IX Item "-m[no-]audio-isa-ext"
Enable/Disable \s-1AUDIO ISA\s0 extension
.ie n .IP """-m[no-]fpu-sp-ext""" 4
.el .IP "\f(CW-m[no-]fpu-sp-ext" 4
.IX Item "-m[no-]fpu-sp-ext"
Enable/Disable \s-1FPU SP\s0 extension
.ie n .IP """-m[no-]fpu-dp-ext""" 4
.el .IP "\f(CW-m[no-]fpu-dp-ext" 4
.IX Item "-m[no-]fpu-dp-ext"
Enable/Disable \s-1FPU DP\s0 extension
.ie n .IP """-m[no-]fpu-fma""" 4
.el .IP "\f(CW-m[no-]fpu-fma" 4
.IX Item "-m[no-]fpu-fma"
Enable/Disable \s-1FPU\s0 fused-multiply-add instructions
.ie n .IP """-mall-ext""" 4
.el .IP "\f(CW-mall-ext" 4
.IX Item "-mall-ext"
Turn on all extensions and instructions support

The following options are available when as is configured for a
PowerPC processor.

* **-a32**  
  .IX Item "-a32"
  Generate \s-1ELF32\s0 or \s-1XCOFF32.\s0
* **-a64**  
  .IX Item "-a64"
  Generate \s-1ELF64\s0 or \s-1XCOFF64.\s0
* **-K \s-1PIC\s0**  
  .IX Item "-K PIC"
  Set \s-1EF_PPC_RELOCATABLE_LIB\s0 in \s-1ELF\s0 flags.
* **-mpwrx | -mpwr2**  
  .IX Item "-mpwrx | -mpwr2"
  Generate code for \s-1POWER/2\s0 (\s-1RIOS2\s0).
* **-mpwr**  
  .IX Item "-mpwr"
  Generate code for \s-1POWER\s0 (\s-1RIOS1\s0)
* **-m601**  
  .IX Item "-m601"
  Generate code for PowerPC 601.
* **-mppc, -mppc32, -m603, -m604**  
  .IX Item "-mppc, -mppc32, -m603, -m604"
  Generate code for PowerPC 603/604.
* **-m403, -m405**  
  .IX Item "-m403, -m405"
  Generate code for PowerPC 403/405.
* **-m440**  
  .IX Item "-m440"
  Generate code for PowerPC 440.  BookE and some 405 instructions.
* **-m464**  
  .IX Item "-m464"
  Generate code for PowerPC 464.
* **-m476**  
  .IX Item "-m476"
  Generate code for PowerPC 476.
* **-m7400, -m7410, -m7450, -m7455**  
  .IX Item "-m7400, -m7410, -m7450, -m7455"
  Generate code for PowerPC 7400/7410/7450/7455.
* **-m750cl**  
  .IX Item "-m750cl"
  Generate code for PowerPC 750CL.
* **-m821, -m850, -m860**  
  .IX Item "-m821, -m850, -m860"
  Generate code for PowerPC 821/850/860.
* **-mppc64, -m620**  
  .IX Item "-mppc64, -m620"
  Generate code for PowerPC 620/625/630.
* **-me500, -me500x2**  
  .IX Item "-me500, -me500x2"
  Generate code for Motorola e500 core complex.
* **-me500mc**  
  .IX Item "-me500mc"
  Generate code for Freescale e500mc core complex.
* **-me500mc64**  
  .IX Item "-me500mc64"
  Generate code for Freescale e500mc64 core complex.
* **-me5500**  
  .IX Item "-me5500"
  Generate code for Freescale e5500 core complex.
* **-me6500**  
  .IX Item "-me6500"
  Generate code for Freescale e6500 core complex.
* **-mspe**  
  .IX Item "-mspe"
  Generate code for Motorola \s-1SPE\s0 instructions.
* **-mspe2**  
  .IX Item "-mspe2"
  Generate code for Freescale \s-1SPE2\s0 instructions.
* **-mtitan**  
  .IX Item "-mtitan"
  Generate code for AppliedMicro Titan core complex.
* **-mppc64bridge**  
  .IX Item "-mppc64bridge"
  Generate code for PowerPC 64, including bridge insns.
* **-mbooke**  
  .IX Item "-mbooke"
  Generate code for 32-bit BookE.
* **-ma2**  
  .IX Item "-ma2"
  Generate code for A2 architecture.
* **-me300**  
  .IX Item "-me300"
  Generate code for PowerPC e300 family.
* **-maltivec**  
  .IX Item "-maltivec"
  Generate code for processors with AltiVec instructions.
* **-mvle**  
  .IX Item "-mvle"
  Generate code for Freescale PowerPC \s-1VLE\s0 instructions.
* **-mvsx**  
  .IX Item "-mvsx"
  Generate code for processors with Vector-Scalar (\s-1VSX\s0) instructions.
* **-mhtm**  
  .IX Item "-mhtm"
  Generate code for processors with Hardware Transactional Memory instructions.
* **-mpower4, -mpwr4**  
  .IX Item "-mpower4, -mpwr4"
  Generate code for Power4 architecture.
* **-mpower5, -mpwr5, -mpwr5x**  
  .IX Item "-mpower5, -mpwr5, -mpwr5x"
  Generate code for Power5 architecture.
* **-mpower6, -mpwr6**  
  .IX Item "-mpower6, -mpwr6"
  Generate code for Power6 architecture.
* **-mpower7, -mpwr7**  
  .IX Item "-mpower7, -mpwr7"
  Generate code for Power7 architecture.
* **-mpower8, -mpwr8**  
  .IX Item "-mpower8, -mpwr8"
  Generate code for Power8 architecture.
* **-mpower9, -mpwr9**  
  .IX Item "-mpower9, -mpwr9"
  Generate code for Power9 architecture.
* **-mcell**  
  .IX Item "-mcell"
* **-mcell**  
  .IX Item "-mcell"
  Generate code for Cell Broadband Engine architecture.
* **-mcom**  
  .IX Item "-mcom"
  Generate code Power/PowerPC common instructions.
* **-many**  
  .IX Item "-many"
  Generate code for any architecture (\s-1PWR/PWRX/PPC\s0).
* **-mregnames**  
  .IX Item "-mregnames"
  Allow symbolic names for registers.
* **-mno-regnames**  
  .IX Item "-mno-regnames"
  Do not allow symbolic names for registers.
* **-mrelocatable**  
  .IX Item "-mrelocatable"
  Support for \s-1GCC\s0's -mrelocatable option.
* **-mrelocatable-lib**  
  .IX Item "-mrelocatable-lib"
  Support for \s-1GCC\s0's -mrelocatable-lib option.
* **-memb**  
  .IX Item "-memb"
  Set \s-1PPC_EMB\s0 bit in \s-1ELF\s0 flags.
* **-mlittle, -mlittle-endian, -le**  
  .IX Item "-mlittle, -mlittle-endian, -le"
  Generate code for a little endian machine.
* **-mbig, -mbig-endian, -be**  
  .IX Item "-mbig, -mbig-endian, -be"
  Generate code for a big endian machine.
* **-msolaris**  
  .IX Item "-msolaris"
  Generate code for Solaris.
* **-mno-solaris**  
  .IX Item "-mno-solaris"
  Do not generate code for Solaris.
* **-nops=**_count_  
  .IX Item "-nops=count"
  If an alignment directive inserts more than _count_ nops, put a
  branch at the beginning to skip execution of the nops.

The following options are available when as is configured for a
RISC-V processor.

* **-fpic**  
  .IX Item "-fpic"
* **-fPIC**  
  .IX Item "-fPIC"
  Generate position-independent code
* **-fno-pic**  
  .IX Item "-fno-pic"
  Don't generate position-independent code (default)
* **-march=ISA**  
  .IX Item "-march=ISA"
  Select the base isa, as specified by \s-1ISA.\s0  For example -march=rv32ima.
* **-mabi=ABI**  
  .IX Item "-mabi=ABI"
  Selects the \s-1ABI,\s0 which is either ilp32\*(R" or \*(L"lp64\*(R", optionally followed
  by f\*(R", \*(L"d\*(R", or \*(L"q\*(R" to indicate single-precision, double-precision, or
  quad-precision floating-point calling convention, or none to indicate
  the soft-float calling convention.  Also, ilp32\*(R" can optionally be followed
  by e\*(R" to indicate the \s-1RVE ABI,\s0 which is always soft-float.
* **-mrelax**  
  .IX Item "-mrelax"
  Take advantage of linker relaxations to reduce the number of instructions
  required to materialize symbol addresses. (default)
* **-mno-relax**  
  .IX Item "-mno-relax"
  Don't do linker relaxations.

See the info pages for documentation of the RX-specific options.

The following options are available when as is configured for the s390
processor family.

* **-m31**  
  .IX Item "-m31"
* **-m64**  
  .IX Item "-m64"
  Select the word size, either 31/32 bits or 64 bits.
* **-mesa**  
  .IX Item "-mesa"
* **-mzarch**  
  .IX Item "-mzarch"
  Select the architecture mode, either the Enterprise System
  Architecture (esa) or the z/Architecture mode (zarch).
* **-march=**_processor_  
  .IX Item "-march=processor"
  Specify which s390 processor variant is the target, **g5** (or
  **arch3**), **g6**, **z900** (or **arch5**), **z990** (or
  **arch6**), **z9-109**, **z9-ec** (or **arch7**), **z10** (or
  **arch8**), **z196** (or **arch9**), **zEC12** (or **arch10**),
  **z13** (or **arch11**), or **z14** (or **arch12**).
* **-mregnames**  
  .IX Item "-mregnames"
* **-mno-regnames**  
  .IX Item "-mno-regnames"
  Allow or disallow symbolic names for registers.
* **-mwarn-areg-zero**  
  .IX Item "-mwarn-areg-zero"
  Warn whenever the operand for a base or index register has been specified
  but evaluates to zero.

The following options are available when as is configured for a
\s-1TMS320C6000\s0 processor.

* **-march=**_arch_  
  .IX Item "-march=arch"
  Enable (only) instructions from architecture _arch_.  By default,
  all instructions are permitted.
  .Sp
  The following values of _arch_ are accepted: \f(CW`c62x\*(C',
  \f(CW`c64x\*(C', \f(CW\*(C\`c64x+\*(C', \f(CW\*(C\`c67x\*(C', \f(CW\*(C\`c67x+\*(C', \f(CW\*(C\`c674x\*(C'.
* **-mdsbt**  
  .IX Item "-mdsbt"
* **-mno-dsbt**  
  .IX Item "-mno-dsbt"
  The **-mdsbt** option causes the assembler to generate the
  \f(CW`Tag\_ABI\_DSBT\*(C' attribute with a value of 1, indicating that the
  code is using \s-1DSBT\s0 addressing.  The **-mno-dsbt** option, the
  default, causes the tag to have a value of 0, indicating that the code
  does not use \s-1DSBT\s0 addressing.  The linker will emit a warning if
  objects of different type (\s-1DSBT\s0 and non-DSBT) are linked together.
* **-mpid=no**  
  .IX Item "-mpid=no"
* **-mpid=near**  
  .IX Item "-mpid=near"
* **-mpid=far**  
  .IX Item "-mpid=far"
  The **-mpid=** option causes the assembler to generate the
  \f(CW`Tag\_ABI\_PID\*(C' attribute with a value indicating the form of data
  addressing used by the code.  **-mpid=no**, the default,
  indicates position-dependent data addressing, **-mpid=near**
  indicates position-independent addressing with \s-1GOT\s0 accesses using near
  \s-1DP\s0 addressing, and **-mpid=far** indicates position-independent
  addressing with \s-1GOT\s0 accesses using far \s-1DP\s0 addressing.  The linker will
  emit a warning if objects built with different settings of this option
  are linked together.
* **-mpic**  
  .IX Item "-mpic"
* **-mno-pic**  
  .IX Item "-mno-pic"
  The **-mpic** option causes the assembler to generate the
  \f(CW`Tag\_ABI\_PIC\*(C' attribute with a value of 1, indicating that the
  code is using position-independent code addressing,  The
  \f(CW`-mno-pic\*(C' option, the default, causes the tag to have a value of
  0, indicating position-dependent code addressing.  The linker will
  emit a warning if objects of different type (position-dependent and
  position-independent) are linked together.
* **-mbig-endian**  
  .IX Item "-mbig-endian"
* **-mlittle-endian**  
  .IX Item "-mlittle-endian"
  Generate code for the specified endianness.  The default is
  little-endian.

The following options are available when as is configured for a TILE-Gx
processor.

* **-m32 | -m64**  
  .IX Item "-m32 | -m64"
  Select the word size, either 32 bits or 64 bits.
* **-EB | -EL**  
  .IX Item "-EB | -EL"
  Select the endianness, either big-endian (-EB) or little-endian (-EL).

The following option is available when as is configured for a Visium
processor.

* **-mtune=**_arch_  
  .IX Item "-mtune=arch"
  This option specifies the target architecture.  If an attempt is made to
  assemble an instruction that will not execute on the target architecture,
  the assembler will issue an error message.
  .Sp
  The following names are recognized:
  \f(CW`mcm24\*(C'
  \f(CW`mcm\*(C'
  \f(CW`gr5\*(C'
  \f(CW`gr6\*(C'

The following options are available when as is configured for an
Xtensa processor.

* **--text-section-literals | --no-text-section-literals**  
  .IX Item "--text-section-literals | --no-text-section-literals"
  Control the treatment of literal pools.  The default is
  **--no-text-section-literals**, which places literals in
  separate sections in the output file.  This allows the literal pool to be
  placed in a data \s-1RAM/ROM.\s0  With **--text-section-literals**, the
  literals are interspersed in the text section in order to keep them as
  close as possible to their references.  This may be necessary for large
  assembly files, where the literals would otherwise be out of range of the
  \f(CW`L32R\*(C' instructions in the text section.  Literals are grouped into
  pools following \f(CW`.literal\_position\*(C' directives or preceding
  \f(CW`ENTRY\*(C' instructions.  These options only affect literals referenced
  via PC-relative \f(CW`L32R\*(C' instructions; literals for absolute mode
  \f(CW`L32R\*(C' instructions are handled separately.
* **--auto-litpools | --no-auto-litpools**  
  .IX Item "--auto-litpools | --no-auto-litpools"
  Control the treatment of literal pools.  The default is
  **--no-auto-litpools**, which in the absence of
  **--text-section-literals** places literals in separate sections
  in the output file.  This allows the literal pool to be placed in a data
  \s-1RAM/ROM.\s0  With **--auto-litpools**, the literals are interspersed
  in the text section in order to keep them as close as possible to their
  references, explicit \f(CW`.literal\_position\*(C' directives are not
  required.  This may be necessary for very large functions, where single
  literal pool at the beginning of the function may not be reachable by
  \f(CW`L32R\*(C' instructions at the end.  These options only affect
  literals referenced via PC-relative \f(CW`L32R\*(C' instructions; literals
  for absolute mode \f(CW`L32R\*(C' instructions are handled separately.
  When used together with **--text-section-literals**,
  **--auto-litpools** takes precedence.
* **--absolute-literals | --no-absolute-literals**  
  .IX Item "--absolute-literals | --no-absolute-literals"
  Indicate to the assembler whether \f(CW`L32R\*(C' instructions use absolute
  or PC-relative addressing.  If the processor includes the absolute
  addressing option, the default is to use absolute \f(CW`L32R\*(C'
  relocations.  Otherwise, only the PC-relative \f(CW`L32R\*(C' relocations
  can be used.
* **--target-align | --no-target-align**  
  .IX Item "--target-align | --no-target-align"
  Enable or disable automatic alignment to reduce branch penalties at some
  expense in code size.    This optimization is enabled by default.  Note
  that the assembler will always align instructions like \f(CW`LOOP\*(C' that
  have fixed alignment requirements.
* **--longcalls | --no-longcalls**  
  .IX Item "--longcalls | --no-longcalls"
  Enable or disable transformation of call instructions to allow calls
  across a greater range of addresses.    This option should be used when call
  targets can potentially be out of range.  It may degrade both code size
  and performance, but the linker can generally optimize away the
  unnecessary overhead when a call ends up within range.  The default is
  **--no-longcalls**.
* **--transform | --no-transform**  
  .IX Item "--transform | --no-transform"
  Enable or disable all assembler transformations of Xtensa instructions,
  including both relaxation and optimization.  The default is
  **--transform**; **--no-transform** should only be used in the
  rare cases when the instructions must be exactly as specified in the
  assembly source.  Using **--no-transform** causes out of range
  instruction operands to be errors.
* **--rename-section** _oldname_**=**_newname_  
  .IX Item "--rename-section oldname=newname"
  Rename the _oldname_ section to _newname_.  This option can be used
  multiple times to rename multiple sections.
* **--trampolines | --no-trampolines**  
  .IX Item "--trampolines | --no-trampolines"
  Enable or disable transformation of jump instructions to allow jumps
  across a greater range of addresses.    This option should be used when jump targets can
  potentially be out of range.  In the absence of such jumps this option
  does not affect code size or performance.  The default is
  **--trampolines**.

The following options are available when as is configured for
a Z80 family processor.

* **-z80**  
  .IX Item "-z80"
  Assemble for Z80 processor.
* **-r800**  
  .IX Item "-r800"
  Assemble for R800 processor.
* **-ignore-undocumented-instructions**  
  .IX Item "-ignore-undocumented-instructions"
* **-Wnud**  
  .IX Item "-Wnud"
  Assemble undocumented Z80 instructions that also work on R800 without warning.
* **-ignore-unportable-instructions**  
  .IX Item "-ignore-unportable-instructions"
* **-Wnup**  
  .IX Item "-Wnup"
  Assemble all undocumented Z80 instructions without warning.
* **-warn-undocumented-instructions**  
  .IX Item "-warn-undocumented-instructions"
* **-Wud**  
  .IX Item "-Wud"
  Issue a warning for undocumented Z80 instructions that also work on R800.
* **-warn-unportable-instructions**  
  .IX Item "-warn-unportable-instructions"
* **-Wup**  
  .IX Item "-Wup"
  Issue a warning for undocumented Z80 instructions that do not work on R800.
* **-forbid-undocumented-instructions**  
  .IX Item "-forbid-undocumented-instructions"
* **-Fud**  
  .IX Item "-Fud"
  Treat all undocumented instructions as errors.
* **-forbid-unportable-instructions**  
  .IX Item "-forbid-unportable-instructions"
* **-Fup**  
  .IX Item "-Fup"
  Treat undocumented Z80 instructions that do not work on R800 as errors.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**gcc**\|(1), **ld**\|(1), and the Info entries for _binutils_ and _ld_.

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
