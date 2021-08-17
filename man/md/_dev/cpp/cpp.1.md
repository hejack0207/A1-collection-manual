# cpp(1)

gcc-9, 2019-03-12

.if n .ad l
.nh

<a name="name"></a>

# Name

cpp - The C Preprocessor

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" cpp [-Dmacro[=defn]...] [-Umacro]     [-Idir...] [-iquotedir...]     [-M|-MM] [-MG] [-MF filename]     [-MP] [-MQ target...]     [-MT target...]     infile [[-o] outfile] 
 Only the most useful options are given above; see below for a more complete list of preprocessor-specific options.   In addition, cpp accepts most gcc driver options, which are not listed here.  Refer to the \s-1GCC\s0 documentation for details.
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The C preprocessor, often known as _cpp_, is a _macro processor_
that is used automatically by the C compiler to transform your program
before compilation.  It is called a macro processor because it allows
you to define _macros_, which are brief abbreviations for longer
constructs.

The C preprocessor is intended to be used only with C, , and
Objective-C source code.  In the past, it has been abused as a general
text processor.  It will choke on input which does not obey C's lexical
rules.  For example, apostrophes will be interpreted as the beginning of
character constants, and cause errors.  Also, you cannot rely on it
preserving characteristics of the input which are not significant to
C-family languages.  If a Makefile is preprocessed, all the hard tabs
will be removed, and the Makefile will not work.

Having said that, you can often get away with using cpp on things which
are not C.  Other Algol-ish programming languages are often safe
(Ada, etc.) So is assembly, with caution.  **-traditional-cpp**
mode preserves more white space, and is otherwise more permissive.  Many
of the problems can be avoided by writing C or  style comments
instead of native language comments, and keeping macros simple.

Wherever possible, you should use a preprocessor geared to the language
you are writing in.  Modern versions of the \s-1GNU\s0 assembler have macro
facilities.  Most high level programming languages have their own
conditional compilation and inclusion mechanism.  If all else fails,
try a true general text processor, such as \s-1GNU M4.\s0

C preprocessors vary in some details.  This manual discusses the \s-1GNU C\s0
preprocessor, which provides a small superset of the features of \s-1ISO\s0
Standard C.  In its default mode, the \s-1GNU C\s0 preprocessor does not do a
few things required by the standard.  These are features which are
rarely, if ever, used, and may cause surprising changes to the meaning
of a program which does not expect them.  To get strict \s-1ISO\s0 Standard C,
you should use the **-std=c90**, **-std=c99**,
**-std=c11** or **-std=c17** options, depending
on which version of the standard you want.  To get all the mandatory
diagnostics, you must also use **-pedantic**.

This manual describes the behavior of the \s-1ISO\s0 preprocessor.  To
minimize gratuitous differences, where the \s-1ISO\s0 preprocessor's
behavior does not conflict with traditional semantics, the
traditional preprocessor should behave the same way.  The various
differences that do exist are detailed in the section Traditional
Mode.

For clarity, unless noted otherwise, references to **\s-1CPP\s0** in this
manual refer to \s-1GNU CPP.\s0

<a name="options"></a>

# Options

.IX Header "OPTIONS"
The **cpp** command expects two file names as arguments, _infile_ and
_outfile_.  The preprocessor reads _infile_ together with any
other files it specifies with **#include**.  All the output generated
by the combined input files is written in _outfile_.

Either _infile_ or _outfile_ may be **-**, which as
_infile_ means to read from standard input and as _outfile_
means to write to standard output.  If either file is omitted, it
means the same as if **-** had been specified for that file.
You can also use the **-o** _outfile_ option to specify the 
output file.

Unless otherwise noted, or the option ends in **=**, all options
which take an argument may have that argument appear either immediately
after the option, or with a space between option and argument:
**-Ifoo** and **-I foo** have the same effect.

Many options have multi-letter names; therefore multiple single-letter
options may _not_ be grouped: **-dM** is very different from
**-d&nbsp;-M**.

* **-D** _name_  
  .IX Item "-D name"
  Predefine _name_ as a macro, with definition \f(CW1.
* **-D** _name_**=**_definition_  
  .IX Item "-D name=definition"
  The contents of _definition_ are tokenized and processed as if
  they appeared during translation phase three in a **#define**
  directive.  In particular, the definition is truncated by
  embedded newline characters.
  .Sp
  If you are invoking the preprocessor from a shell or shell-like
  program you may need to use the shell's quoting syntax to protect
  characters such as spaces that have a meaning in the shell syntax.
  .Sp
  If you wish to define a function-like macro on the command line, write
  its argument list with surrounding parentheses before the equals sign
  (if any).  Parentheses are meaningful to most shells, so you should
  quote the option.  With **sh** and **csh**,
  **-D'**_name_**(**_args..._**)=**_definition_**'** works.
  .Sp
  **-D** and **-U** options are processed in the order they
  are given on the command line.  All **-imacros** _file_ and
  **-include** _file_ options are processed after all
  **-D** and **-U** options.
* **-U** _name_  
  .IX Item "-U name"
  Cancel any previous definition of _name_, either built in or
  provided with a **-D** option.
* **-include** _file_  
  .IX Item "-include file"
  Process _file_ as if \f(CW`#include "file"\*(C' appeared as the first
  line of the primary source file.  However, the first directory searched
  for _file_ is the preprocessor's working directory _instead of_
  the directory containing the main source file.  If not found there, it
  is searched for in the remainder of the \f(CW`#include "..."\*(C' search
  chain as normal.
  .Sp
  If multiple **-include** options are given, the files are included
  in the order they appear on the command line.
* **-imacros** _file_  
  .IX Item "-imacros file"
  Exactly like **-include**, except that any output produced by
  scanning _file_ is thrown away.  Macros it defines remain defined.
  This allows you to acquire all the macros from a header without also
  processing its declarations.
  .Sp
  All files specified by **-imacros** are processed before all files
  specified by **-include**.
* **-undef**  
  .IX Item "-undef"
  Do not predefine any system-specific or GCC-specific macros.  The
  standard predefined macros remain defined.
* **-pthread**  
  .IX Item "-pthread"
  Define additional macros required for using the \s-1POSIX\s0 threads library.
  You should use this option consistently for both compilation and linking.
  This option is supported on GNU/Linux targets, most other Unix derivatives,
  and also on x86 Cygwin and MinGW targets.
* **-M**  
  .IX Item "-M"
  Instead of outputting the result of preprocessing, output a rule
  suitable for **make** describing the dependencies of the main
  source file.  The preprocessor outputs one **make** rule containing
  the object file name for that source file, a colon, and the names of all
  the included files, including those coming from **-include** or
  **-imacros** command-line options.
  .Sp
  Unless specified explicitly (with **-MT** or **-MQ**), the
  object file name consists of the name of the source file with any
  suffix replaced with object file suffix and with any leading directory
  parts removed.  If there are many included files then the rule is
  split into several lines using **\e**-newline.  The rule has no
  commands.
  .Sp
  This option does not suppress the preprocessor's debug output, such as
  **-dM**.  To avoid mixing such debug output with the dependency
  rules you should explicitly specify the dependency output file with
  **-MF**, or use an environment variable like
  **\s-1DEPENDENCIES\_OUTPUT\s0**.  Debug output
  is still sent to the regular output stream as normal.
  .Sp
  Passing **-M** to the driver implies **-E**, and suppresses
  warnings with an implicit **-w**.
* **-MM**  
  .IX Item "-MM"
  Like **-M** but do not mention header files that are found in
  system header directories, nor header files that are included,
  directly or indirectly, from such a header.
  .Sp
  This implies that the choice of angle brackets or double quotes in an
  **#include** directive does not in itself determine whether that
  header appears in **-MM** dependency output.
* **-MF** _file_  
  .IX Item "-MF file"
  When used with **-M** or **-MM**, specifies a
  file to write the dependencies to.  If no **-MF** switch is given
  the preprocessor sends the rules to the same place it would send
  preprocessed output.
  .Sp
  When used with the driver options **-MD** or **-MMD**,
  **-MF** overrides the default dependency output file.
  .Sp
  If _file_ is _-_, then the dependencies are written to _stdout_.
* **-MG**  
  .IX Item "-MG"
  In conjunction with an option such as **-M** requesting
  dependency generation, **-MG** assumes missing header files are
  generated files and adds them to the dependency list without raising
  an error.  The dependency filename is taken directly from the
  \f(CW`#include\*(C' directive without prepending any path.  **-MG**
  also suppresses preprocessed output, as a missing header file renders
  this useless.
  .Sp
  This feature is used in automatic updating of makefiles.
* **-MP**  
  .IX Item "-MP"
  This option instructs \s-1CPP\s0 to add a phony target for each dependency
  other than the main file, causing each to depend on nothing.  These
  dummy rules work around errors **make** gives if you remove header
  files without updating the _Makefile_ to match.
  .Sp
  This is typical output:
  .Sp
  .Vb 1
          test.o: test.c test.h
          
          test.h:
  .Ve
* **-MT** _target_  
  .IX Item "-MT target"
  Change the target of the rule emitted by dependency generation.  By
  default \s-1CPP\s0 takes the name of the main input file, deletes any
  directory components and any file suffix such as **.c**, and
  appends the platform's usual object suffix.  The result is the target.
  .Sp
  An **-MT** option sets the target to be exactly the string you
  specify.  If you want multiple targets, you can specify them as a single
  argument to **-MT**, or use multiple **-MT** options.
  .Sp
  For example, **-MT&nbsp;'$(objpfx)foo.o'** might give
  .Sp
  .Vb 1
          $(objpfx)foo.o: foo.c
  .Ve
* **-MQ** _target_  
  .IX Item "-MQ target"
  Same as **-MT**, but it quotes any characters which are special to
  Make.  **-MQ&nbsp;'$(objpfx)foo.o'** gives
  .Sp
  .Vb 1
          $$(objpfx)foo.o: foo.c
  .Ve
  .Sp
  The default target is automatically quoted, as if it were given with
  **-MQ**.
* **-MD**  
  .IX Item "-MD"
  **-MD** is equivalent to **-M -MF** _file_, except that
  **-E** is not implied.  The driver determines _file_ based on
  whether an **-o** option is given.  If it is, the driver uses its
  argument but with a suffix of _.d_, otherwise it takes the name
  of the input file, removes any directory components and suffix, and
  applies a _.d_ suffix.
  .Sp
  If **-MD** is used in conjunction with **-E**, any
  **-o** switch is understood to specify the dependency output file, but if used without **-E**, each **-o**
  is understood to specify a target object file.
  .Sp
  Since **-E** is not implied, **-MD** can be used to generate
  a dependency output file as a side effect of the compilation process.
* **-MMD**  
  .IX Item "-MMD"
  Like **-MD** except mention only user header files, not system
  header files.
* **-fpreprocessed**  
  .IX Item "-fpreprocessed"
  Indicate to the preprocessor that the input file has already been
  preprocessed.  This suppresses things like macro expansion, trigraph
  conversion, escaped newline splicing, and processing of most directives.
  The preprocessor still recognizes and removes comments, so that you can
  pass a file preprocessed with **-C** to the compiler without
  problems.  In this mode the integrated preprocessor is little more than
  a tokenizer for the front ends.
  .Sp
  **-fpreprocessed** is implicit if the input file has one of the
  extensions **.i**, **.ii** or **.mi**.  These are the
  extensions that \s-1GCC\s0 uses for preprocessed files created by
  **-save-temps**.
* **-fdirectives-only**  
  .IX Item "-fdirectives-only"
  When preprocessing, handle directives, but do not expand macros.
  .Sp
  The option's behavior depends on the **-E** and **-fpreprocessed**
  options.
  .Sp
  With **-E**, preprocessing is limited to the handling of directives
  such as \f(CW`#define\*(C', \f(CW\*(C\`#ifdef\*(C', and \f(CW\*(C\`#error\*(C'.  Other
  preprocessor operations, such as macro expansion and trigraph
  conversion are not performed.  In addition, the **-dD** option is
  implicitly enabled.
  .Sp
  With **-fpreprocessed**, predefinition of command line and most
  builtin macros is disabled.  Macros such as \f(CW`\_\|\_LINE\_\|\_\*(C', which are
  contextually dependent, are handled normally.  This enables compilation of
  files previously preprocessed with \f(CW`-E -fdirectives-only\*(C'.
  .Sp
  With both **-E** and **-fpreprocessed**, the rules for
  **-fpreprocessed** take precedence.  This enables full preprocessing of
  files previously preprocessed with \f(CW`-E -fdirectives-only\*(C'.
* **-fdollars-in-identifiers**  
  .IX Item "-fdollars-in-identifiers"
  Accept **$** in identifiers.
* **-fextended-identifiers**  
  .IX Item "-fextended-identifiers"
  Accept universal character names in identifiers.  This option is
  enabled by default for C99 (and later C standard versions) and .
* **-fno-canonical-system-headers**  
  .IX Item "-fno-canonical-system-headers"
  When preprocessing, do not shorten system header paths with canonicalization.
* **-ftabstop=**_width_  
  .IX Item "-ftabstop=width"
  Set the distance between tab stops.  This helps the preprocessor report
  correct column numbers in warnings or errors, even if tabs appear on the
  line.  If the value is less than 1 or greater than 100, the option is
  ignored.  The default is 8.
* **-ftrack-macro-expansion**[**=**_level_]  
  .IX Item "-ftrack-macro-expansion[=level]"
  Track locations of tokens across macro expansions. This allows the
  compiler to emit diagnostic about the current macro expansion stack
  when a compilation error occurs in a macro expansion. Using this
  option makes the preprocessor and the compiler consume more
  memory. The _level_ parameter can be used to choose the level of
  precision of token location tracking thus decreasing the memory
  consumption if necessary. Value **0** of _level_ de-activates
  this option. Value **1** tracks tokens locations in a
  degraded mode for the sake of minimal memory overhead. In this mode
  all tokens resulting from the expansion of an argument of a
  function-like macro have the same location. Value **2** tracks
  tokens locations completely. This value is the most memory hungry.
  When this option is given no argument, the default parameter value is
  **2**.
  .Sp
  Note that \f(CW`-ftrack-macro-expansion=2\*(C' is activated by default.
* **-fmacro-prefix-map=**_old_**=**_new_  
  .IX Item "-fmacro-prefix-map=old=new"
  When preprocessing files residing in directory _old_,
  expand the \f(CW`\_\|\_FILE\_\|\_\*(C' and \f(CW\*(C\`\_\|\_BASE\_FILE\_\|\_\*(C' macros as if the
  files resided in directory _new_ instead.  This can be used
  to change an absolute path to a relative path by using _._ for
  _new_ which can result in more reproducible builds that are
  location independent.  This option also affects
  \f(CW`\_\|\_builtin\_FILE()\*(C' during compilation.  See also
  **-ffile-prefix-map**.
* **-fexec-charset=**_charset_  
  .IX Item "-fexec-charset=charset"
  Set the execution character set, used for string and character
  constants.  The default is \s-1UTF-8.\s0  _charset_ can be any encoding
  supported by the system's \f(CW`iconv\*(C' library routine.
* **-fwide-exec-charset=**_charset_  
  .IX Item "-fwide-exec-charset=charset"
  Set the wide execution character set, used for wide string and
  character constants.  The default is \s-1UTF-32\s0 or \s-1UTF-16,\s0 whichever
  corresponds to the width of \f(CW`wchar\_t\*(C'.  As with
  **-fexec-charset**, _charset_ can be any encoding supported
  by the system's \f(CW`iconv\*(C' library routine; however, you will have
  problems with encodings that do not fit exactly in \f(CW`wchar\_t\*(C'.
* **-finput-charset=**_charset_  
  .IX Item "-finput-charset=charset"
  Set the input character set, used for translation from the character
  set of the input file to the source character set used by \s-1GCC.\s0  If the
  locale does not specify, or \s-1GCC\s0 cannot get this information from the
  locale, the default is \s-1UTF-8.\s0  This can be overridden by either the locale
  or this command-line option.  Currently the command-line option takes
  precedence if there's a conflict.  _charset_ can be any encoding
  supported by the system's \f(CW`iconv\*(C' library routine.
* **-fworking-directory**  
  .IX Item "-fworking-directory"
  Enable generation of linemarkers in the preprocessor output that
  let the compiler know the current working directory at the time of
  preprocessing.  When this option is enabled, the preprocessor
  emits, after the initial linemarker, a second linemarker with the
  current working directory followed by two slashes.  \s-1GCC\s0 uses this
  directory, when it's present in the preprocessed input, as the
  directory emitted as the current working directory in some debugging
  information formats.  This option is implicitly enabled if debugging
  information is enabled, but this can be inhibited with the negated
  form **-fno-working-directory**.  If the **-P** flag is
  present in the command line, this option has no effect, since no
  \f(CW`#line\*(C' directives are emitted whatsoever.
* **-A** _predicate_**=**_answer_  
  .IX Item "-A predicate=answer"
  Make an assertion with the predicate _predicate_ and answer
  _answer_.  This form is preferred to the older form **-A**
  _predicate_**(**_answer_**)**, which is still supported, because
  it does not use shell special characters.
* **-A -**_predicate_**=**_answer_  
  .IX Item "-A -predicate=answer"
  Cancel an assertion with the predicate _predicate_ and answer
  _answer_.
* **-C**  
  .IX Item "-C"
  Do not discard comments.  All comments are passed through to the output
  file, except for comments in processed directives, which are deleted
  along with the directive.
  .Sp
  You should be prepared for side effects when using **-C**; it
  causes the preprocessor to treat comments as tokens in their own right.
  For example, comments appearing at the start of what would be a
  directive line have the effect of turning that line into an ordinary
  source line, since the first token on the line is no longer a **#**.
* **-CC**  
  .IX Item "-CC"
  Do not discard comments, including during macro expansion.  This is
  like **-C**, except that comments contained within macros are
  also passed through to the output file where the macro is expanded.
  .Sp
  In addition to the side effects of the **-C** option, the
  **-CC** option causes all -style comments inside a macro
  to be converted to C-style comments.  This is to prevent later use
  of that macro from inadvertently commenting out the remainder of
  the source line.
  .Sp
  The **-CC** option is generally used to support lint comments.
* **-P**  
  .IX Item "-P"
  Inhibit generation of linemarkers in the output from the preprocessor.
  This might be useful when running the preprocessor on something that is
  not C code, and will be sent to a program which might be confused by the
  linemarkers.
* **-traditional**  
  .IX Item "-traditional"
* **-traditional-cpp**  
  .IX Item "-traditional-cpp"
  Try to imitate the behavior of pre-standard C preprocessors, as
  opposed to \s-1ISO C\s0 preprocessors.
  .Sp
  Note that \s-1GCC\s0 does not otherwise attempt to emulate a pre-standard 
  C compiler, and these options are only supported with the **-E** 
  switch, or when invoking \s-1CPP\s0 explicitly.
* **-trigraphs**  
  .IX Item "-trigraphs"
  Support \s-1ISO C\s0 trigraphs.
  These are three-character sequences, all starting with **??**, that
  are defined by \s-1ISO C\s0 to stand for single characters.  For example,
  **??/** stands for **\e**, so **'??/n'** is a character
  constant for a newline.
  .Sp
  By default, \s-1GCC\s0 ignores trigraphs, but in
  standard-conforming modes it converts them.  See the **-std** and
  **-ansi** options.
* **-remap**  
  .IX Item "-remap"
  Enable special code to work around file systems which only permit very
  short file names, such as MS-DOS.
* **-H**  
  .IX Item "-H"
  Print the name of each header file used, in addition to other normal
  activities.  Each name is indented to show how deep in the
  **#include** stack it is.  Precompiled header files are also
  printed, even if they are found to be invalid; an invalid precompiled
  header file is printed with **...x** and a valid one with **...!** .
* **-d**_letters_  
  .IX Item "-dletters"
  Says to make debugging dumps during compilation as specified by
  _letters_.  The flags documented here are those relevant to the
  preprocessor.  Other _letters_ are interpreted
  by the compiler proper, or reserved for future versions of \s-1GCC,\s0 and so
  are silently ignored.  If you specify _letters_ whose behavior
  conflicts, the result is undefined.
    * **-dM**  
      .IX Item "-dM"
      Instead of the normal output, generate a list of **#define**
      directives for all the macros defined during the execution of the
      preprocessor, including predefined macros.  This gives you a way of
      finding out what is predefined in your version of the preprocessor.
      Assuming you have no file _foo.h_, the command
      .Sp
      .Vb 1
              touch foo.h; cpp -dM foo.h
      .Ve
      .Sp
      shows all the predefined macros.
    * **-dD**  
      .IX Item "-dD"
      Like **-dM** except in two respects: it does _not_ include the
      predefined macros, and it outputs _both_ the **#define**
      directives and the result of preprocessing.  Both kinds of output go to
      the standard output file.
    * **-dN**  
      .IX Item "-dN"
      Like **-dD**, but emit only the macro names, not their expansions.
    * **-dI**  
      .IX Item "-dI"
      Output **#include** directives in addition to the result of
      preprocessing.
    * **-dU**  
      .IX Item "-dU"
      Like **-dD** except that only macros that are expanded, or whose
      definedness is tested in preprocessor directives, are output; the
      output is delayed until the use or test of the macro; and
      **#undef** directives are also output for macros tested but
      undefined at the time.
* **-fdebug-cpp**  
  .IX Item "-fdebug-cpp"
  This option is only useful for debugging \s-1GCC.\s0  When used from \s-1CPP\s0 or with
  **-E**, it dumps debugging information about location maps.  Every
  token in the output is preceded by the dump of the map its location
  belongs to.
  .Sp
  When used from \s-1GCC\s0 without **-E**, this option has no effect.
* **-I** _dir_  
  .IX Item "-I dir"
* **-iquote** _dir_  
  .IX Item "-iquote dir"
* **-isystem** _dir_  
  .IX Item "-isystem dir"
* **-idirafter** _dir_  
  .IX Item "-idirafter dir"
  Add the directory _dir_ to the list of directories to be searched
  for header files during preprocessing.
  .Sp
  If _dir_ begins with **=** or \f(CW$SYSROOT, then the **=**
  or \f(CW$SYSROOT is replaced by the sysroot prefix; see
  **--sysroot** and **-isysroot**.
  .Sp
  Directories specified with **-iquote** apply only to the quote 
  form of the directive, \f(CW`#include&nbsp;"\f(CIfile\f(CW"\*(C'.
  Directories specified with **-I**, **-isystem**, 
  or **-idirafter** apply to lookup for both the
  \f(CW`#include&nbsp;"\f(CIfile\f(CW"\*(C' and
  \f(CW`#include&nbsp;&lt;\f(CIfile\f(CW&gt;\*(C' directives.
  .Sp
  You can specify any number or combination of these options on the 
  command line to search for header files in several directories.  
  The lookup order is as follows:
    * 1.  
      .IX Item "1."
      For the quote form of the include directive, the directory of the current
      file is searched first.
    * 2.  
      .IX Item "2."
      For the quote form of the include directive, the directories specified
      by **-iquote** options are searched in left-to-right order,
      as they appear on the command line.
    * 3.  
      .IX Item "3."
      Directories specified with **-I** options are scanned in
      left-to-right order.
    * 4.  
      .IX Item "4."
      Directories specified with **-isystem** options are scanned in
      left-to-right order.
    * 5.  
      .IX Item "5."
      Standard system directories are scanned.
    * 6.  
      .IX Item "6."
      Directories specified with **-idirafter** options are scanned in
      left-to-right order.
      .Sp
      You can use **-I** to override a system header
      file, substituting your own version, since these directories are
      searched before the standard system header file directories.  
      However, you should
      not use this option to add directories that contain vendor-supplied
      system header files; use **-isystem** for that.
      .Sp
      The **-isystem** and **-idirafter** options also mark the directory
      as a system directory, so that it gets the same special treatment that
      is applied to the standard system directories.
      .Sp
      If a standard system include directory, or a directory specified with
      **-isystem**, is also specified with **-I**, the **-I**
      option is ignored.  The directory is still searched but as a
      system directory at its normal position in the system include chain.
      This is to ensure that \s-1GCC\s0's procedure to fix buggy system headers and
      the ordering for the \f(CW`#include\_next\*(C' directive are not inadvertently
      changed.
      If you really need to change the search order for system directories,
      use the **-nostdinc** and/or **-isystem** options.
* **-I-**  
  .IX Item "-I-"
  Split the include path.
  This option has been deprecated.  Please use **-iquote** instead for
  **-I** directories before the **-I-** and remove the **-I-**
  option.
  .Sp
  Any directories specified with **-I**
  options before **-I-** are searched only for headers requested with
  \f(CW`#include&nbsp;"\f(CIfile\f(CW"\*(C'; they are not searched for
  \f(CW`#include&nbsp;&lt;\f(CIfile\f(CW&gt;\*(C'.  If additional directories are
  specified with **-I** options after the **-I-**, those
  directories are searched for all **#include** directives.
  .Sp
  In addition, **-I-** inhibits the use of the directory of the current
  file directory as the first search directory for \f(CW`#include&nbsp;"\f(CIfile\f(CW"\*(C'.  There is no way to override this effect of **-I-**.
* **-iprefix** _prefix_  
  .IX Item "-iprefix prefix"
  Specify _prefix_ as the prefix for subsequent **-iwithprefix**
  options.  If the prefix represents a directory, you should include the
  final **/**.
* **-iwithprefix** _dir_  
  .IX Item "-iwithprefix dir"
* **-iwithprefixbefore** _dir_  
  .IX Item "-iwithprefixbefore dir"
  Append _dir_ to the prefix specified previously with
  **-iprefix**, and add the resulting directory to the include search
  path.  **-iwithprefixbefore** puts it in the same place **-I**
  would; **-iwithprefix** puts it where **-idirafter** would.
* **-isysroot** _dir_  
  .IX Item "-isysroot dir"
  This option is like the **--sysroot** option, but applies only to
  header files (except for Darwin targets, where it applies to both header
  files and libraries).  See the **--sysroot** option for more
  information.
* **-imultilib** _dir_  
  .IX Item "-imultilib dir"
  Use _dir_ as a subdirectory of the directory containing
  target-specific  headers.
* **-nostdinc**  
  .IX Item "-nostdinc"
  Do not search the standard system directories for header files.
  Only the directories explicitly specified with **-I**,
  **-iquote**, **-isystem**, and/or **-idirafter**
  options (and the directory of the current file, if appropriate) 
  are searched.
* **-nostdinc++**  
  .IX Item "-nostdinc++"
  Do not search for header files in the -specific standard directories,
  but do still search the other standard directories.  (This option is
  used when building the  library.)
* **-Wcomment**  
  .IX Item "-Wcomment"
* **-Wcomments**  
  .IX Item "-Wcomments"
  Warn whenever a comment-start sequence **/*** appears in a **/***
  comment, or whenever a backslash-newline appears in a **//** comment.
  This warning is enabled by **-Wall**.
* **-Wtrigraphs**  
  .IX Item "-Wtrigraphs"
  Warn if any trigraphs are encountered that might change the meaning of
  the program.  Trigraphs within comments are not warned about,
  except those that would form escaped newlines.
  .Sp
  This option is implied by **-Wall**.  If **-Wall** is not
  given, this option is still enabled unless trigraphs are enabled.  To
  get trigraph conversion without warnings, but get the other
  **-Wall** warnings, use **-trigraphs -Wall -Wno-trigraphs**.
* **-Wundef**  
  .IX Item "-Wundef"
  Warn if an undefined identifier is evaluated in an \f(CW`#if\*(C' directive.
  Such identifiers are replaced with zero.
* **-Wexpansion-to-defined**  
  .IX Item "-Wexpansion-to-defined"
  Warn whenever **defined** is encountered in the expansion of a macro
  (including the case where the macro is expanded by an **#if** directive).
  Such usage is not portable.
  This warning is also enabled by **-Wpedantic** and **-Wextra**.
* **-Wunused-macros**  
  .IX Item "-Wunused-macros"
  Warn about macros defined in the main file that are unused.  A macro
  is _used_ if it is expanded or tested for existence at least once.
  The preprocessor also warns if the macro has not been used at the
  time it is redefined or undefined.
  .Sp
  Built-in macros, macros defined on the command line, and macros
  defined in include files are not warned about.
  .Sp
  _Note:_ If a macro is actually used, but only used in skipped
  conditional blocks, then the preprocessor reports it as unused.  To avoid the
  warning in such a case, you might improve the scope of the macro's
  definition by, for example, moving it into the first skipped block.
  Alternatively, you could provide a dummy use with something like:
  .Sp
  .Vb 2
          #if defined the_macro_causing_the_warning
          #endif
  .Ve
* **-Wno-endif-labels**  
  .IX Item "-Wno-endif-labels"
  Do not warn whenever an \f(CW`#else\*(C' or an \f(CW\*(C\`#endif\*(C' are followed by text.
  This sometimes happens in older programs with code of the form
  .Sp
  .Vb 5
          #if FOO
          ...
          #else FOO
          ...
          #endif FOO
  .Ve
  .Sp
  The second and third \f(CW`FOO\*(C' should be in comments.
  This warning is on by default.

<a name="environment"></a>

# Environment

.IX Header "ENVIRONMENT"
This section describes the environment variables that affect how \s-1CPP\s0
operates.  You can use them to specify directories or prefixes to use
when searching for include files, or to control dependency output.

Note that you can also specify places to search using options such as
**-I**, and control dependency output with options like
**-M**.  These take precedence over
environment variables, which in turn take precedence over the
configuration of \s-1GCC.\s0

* **\s-1CPATH\s0**  
  .IX Item "CPATH"
* **C\_INCLUDE\_PATH**  
  .IX Item "C_INCLUDE_PATH"
* **\s-1CPLUS\_INCLUDE\_PATH\s0**  
  .IX Item "CPLUS_INCLUDE_PATH"
* **\s-1OBJC\_INCLUDE\_PATH\s0**  
  .IX Item "OBJC_INCLUDE_PATH"
  Each variable's value is a list of directories separated by a special
  character, much like **\s-1PATH\s0**, in which to look for header files.
  The special character, \f(CW`PATH\_SEPARATOR\*(C', is target-dependent and
  determined at \s-1GCC\s0 build time.  For Microsoft Windows-based targets it is a
  semicolon, and for almost all other targets it is a colon.
  .Sp
  **\s-1CPATH\s0** specifies a list of directories to be searched as if
  specified with **-I**, but after any paths given with **-I**
  options on the command line.  This environment variable is used
  regardless of which language is being preprocessed.
  .Sp
  The remaining environment variables apply only when preprocessing the
  particular language indicated.  Each specifies a list of directories
  to be searched as if specified with **-isystem**, but after any
  paths given with **-isystem** options on the command line.
  .Sp
  In all these variables, an empty element instructs the compiler to
  search its current working directory.  Empty elements can appear at the
  beginning or end of a path.  For instance, if the value of
  **\s-1CPATH\s0** is \f(CW`:/special/include\*(C', that has the same
  effect as **-I.&nbsp;-I/special/include**.
* **\s-1DEPENDENCIES\_OUTPUT\s0**  
  .IX Item "DEPENDENCIES_OUTPUT"
  If this variable is set, its value specifies how to output
  dependencies for Make based on the non-system header files processed
  by the compiler.  System header files are ignored in the dependency
  output.
  .Sp
  The value of **\s-1DEPENDENCIES\_OUTPUT\s0** can be just a file name, in
  which case the Make rules are written to that file, guessing the target
  name from the source file name.  Or the value can have the form
  _file_** **_target_, in which case the rules are written to
  file _file_ using _target_ as the target name.
  .Sp
  In other words, this environment variable is equivalent to combining
  the options **-MM** and **-MF**,
  with an optional **-MT** switch too.
* **\s-1SUNPRO\_DEPENDENCIES\s0**  
  .IX Item "SUNPRO_DEPENDENCIES"
  This variable is the same as **\s-1DEPENDENCIES\_OUTPUT\s0** (see above),
  except that system header files are not ignored, so it implies
  **-M** rather than **-MM**.  However, the dependence on the
  main input file is omitted.
* **\s-1SOURCE\_DATE\_EPOCH\s0**  
  .IX Item "SOURCE_DATE_EPOCH"
  If this variable is set, its value specifies a \s-1UNIX\s0 timestamp to be
  used in replacement of the current date and time in the \f(CW`\_\|\_DATE\_\|\_\*(C'
  and \f(CW`\_\|\_TIME\_\|\_\*(C' macros, so that the embedded timestamps become
  reproducible.
  .Sp
  The value of **\s-1SOURCE\_DATE\_EPOCH\s0** must be a \s-1UNIX\s0 timestamp,
  defined as the number of seconds (excluding leap seconds) since
  01 Jan 1970 00:00:00 represented in \s-1ASCII\s0; identical to the output of
  **\f(CB@command{date +%s**} on GNU/Linux and other systems that support the
  \f(CW%s extension in the \f(CW`date\*(C' command.
  .Sp
  The value should be a known timestamp such as the last modification
  time of the source or package and it should be set by the build
  process.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**gpl**\|(7), **gfdl**\|(7), **fsf-funding**\|(7),
**gcc**\|(1), and the Info entries for _cpp_ and _gcc_.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 1987-2019 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation.  A copy of
the license is included in the
man page **gfdl**\|(7).
This manual contains no Invariant Sections.  The Front-Cover Texts are
(a) (see below), and the Back-Cover Texts are (b) (see below).

(a) The \s-1FSF\s0's Front-Cover Text is:

.Vb 1
     A GNU Manual
.Ve

(b) The \s-1FSF\s0's Back-Cover Text is:

.Vb 3
     You have freedom to copy and modify this GNU Manual, like GNU
     software.  Copies published by the Free Software Foundation raise
     funds for GNU development.
.Ve
