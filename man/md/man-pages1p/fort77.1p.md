# fort77(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

fort77
— FORTRAN compiler (**FORTRAN**)

<a name="synopsis"></a>

# Synopsis

```


```
    fort77 [(mic] [(mig] [(miL directory]... [(miO optlevel] [(mio outfile] [(mis]
        [(miw] operand...

<a name="description"></a>

# Description

The
_fort77_
utility is the interface to the FORTRAN compilation system; it shall
accept the full FORTRAN-77 language defined by the ANSI&nbsp;X3.9-1978 standard. The system
conceptually consists of a compiler and link editor. The files
referenced by
_operand_s
are compiled and linked to produce an executable file. It is
unspecified whether the linking occurs entirely within the operation of
_fort77_;
some implementations may produce objects that are not fully resolved
until the file is executed.

If the
**\(mic**
option is present, for all pathname operands of the form
_file_\c
**.f**,
the files:

    
    $(basename pathname.f).o


shall be created or overwritten as the result of successful
compilation. If the
**\(mic**
option is not specified, it is unspecified whether such
**.o**
files are created or deleted for the
_file_\c
**.f**
operands.

If there are no options that prevent link editing (such as
**\(mic**)
and all operands compile and link without error, the resulting
executable file shall be written into the file named by the
**\(mio**
option (if present) or to the file
**a.out**.
The executable file shall be created as specified in the System Interfaces volume of POSIX.1-2008, except
that the file permissions shall be set to:
S_IRWXO | S_IRWXG | S_IRWXU

and that the bits specified by the
_umask_
of the process shall be cleared.

<a name="options"></a>

# Options

The
_fort77_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that:

*  *  
  The
  **\(mil**
  _library_
  operands have the format of options, but their position within a list
  of operands affects the order in which libraries are searched.
*  *  
  The order of specifying the multiple
  **\(miL**
  options is significant.
*  *  
  Conforming applications shall specify each option separately; that is,
  grouping option letters (for example,
  **\(micg**)
  need not be recognized by all implementations.

The following options shall be supported:

* **\(mic**  
  Suppress the link-edit phase of the compilation, and do not remove any
  object files that are produced.
* **\(mig**  
  Produce symbolic information in the object or executable files; the
  nature of this information is unspecified, and may be modified by
  implementation-defined interactions with other options.
* **\(mis**  
  Produce object or executable files, or both, from which symbolic and
  other information not required for proper execution using the
  _exec_
  family of functions defined in the System Interfaces volume of POSIX.1-2008 has been removed (stripped).
  If both
  **\(mig**
  and
  **\(mis**
  options are present, the action taken is unspecified.
* **\(mio&nbsp;outfile**  
  Use the pathname
  _outfile_,
  instead of the default
  **a.out**,
  for the executable file produced. If the
  **\(mio**
  option is present with
  **\(mic**,
  the result is unspecified.
* **\(miL&nbsp;directory**  
  Change the algorithm of searching for the libraries named in
  **\(mil**
  operands to look in the directory named by the
  _directory_
  pathname before looking in the usual places. Directories named in
  **\(miL**
  options shall be searched in the specified order. At least ten
  instances of this option shall be supported in a single
  _fort77_
  command invocation. If a directory specified by a
  **\(miL**
  option contains a file named
  **libf.a**,
  the results are unspecified.
* **\(miO&nbsp;optlevel**  
  Specify the level of code optimization. If the
  _optlevel_
  option-argument is the digit
  **'0'**,
  all special code optimizations shall be disabled. If it is the digit
  **'1'**,
  the nature of the optimization is unspecified. If the
  **\(miO**
  option is omitted, the nature of the system's default optimization is
  unspecified. It is unspecified whether code generated in the presence
  of the
  **\(miO**
  0 option is the same as that generated when
  **\(miO**
  is omitted. Other
  _optlevel_
  values may be supported.
* **\(miw**  
  Suppress warnings.

Multiple instances of
**\(miL**
options can be specified.

<a name="operands"></a>

# Operands

An
_operand_
is either in the form of a pathname or the form
**\(mil**
_library_.
At least one operand of the pathname form shall be specified. The
following operands shall be supported:

* file.**f**  
  The pathname of a FORTRAN source file to be compiled and optionally
  passed to the link editor. The filename operand shall be of this form
  if the
  **\(mic**
  option is used.
* file.**a**  
  A library of object files typically produced by
  _ar_,
  and passed directly to the link editor. Implementations may recognize
  implementation-defined suffixes other than
  **.a**
  as denoting object file libraries.
* file.**o**  
  An object file produced by
  _fort77_
  **\(mic**
  and passed directly to the link editor. Implementations may recognize
  implementation-defined suffixes other than
  **.o**
  as denoting object files.

The processing of other files is implementation-defined.

* **\(mil&nbsp;library**  
  (The letter ell.) Search the library named:

    
    liblibrary.a


A library is searched when its name is encountered, so the placement of
a
**\(mil**
operand is significant. Several standard libraries can be specified in
this manner, as described in the EXTENDED DESCRIPTION section.
Implementations may recognize implementation-defined suffixes other
than
**.a**
as denoting libraries.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

The input file shall be one of the following: a text file containing
FORTRAN source code; an object file in the format produced by
_fort77_
**\(mic**;
or a library of object files, in the format produced by archiving zero
or more object files, using
_ar_.
Implementations may supply additional utilities that produce files in
these formats. Additional input files are implementation-defined.

A
&lt;tab&gt;
encountered within the first six characters on a line of source code
shall cause the compiler to interpret the following character as if it
were the seventh character on the line (that is, in column 7).

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_fort77_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files).
* _LC\_MESSAGES_    
  Determine the locale that should be used to affect the format and
  contents of diagnostic messages written to standard error.
* _NLSPATH_  
  Determine the location of message catalogs for the processing of
  _LC_MESSAGES_.
* _TMPDIR_  
  Determine the pathname that should override the default directory for
  temporary files, if any.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.
If more than one
_file_
operand ending in
**.f**
(or possibly other unspecified suffixes) is given, for each such file:

    
    "%s:en", <file>


may be written to allow identification of the diagnostic message with
the appropriate input file.

This utility may produce warning messages about certain conditions that
do not warrant returning an error (non-zero) exit value.

<a name="output-files"></a>

# Output Files

Object files, listing files, and executable files shall be produced in
unspecified formats.

<a name="extended-description"></a>

# Extended Description


<a name="standard-libraries"></a>

### Standard Libraries


The
_fort77_
utility shall recognize the following
**\(mil**
operand for the standard library:

* **\(mil&nbsp;f**  
  This library contains all functions referenced in the ANSI&nbsp;X3.9-1978 standard. This
  operand shall not be required to be present to cause a search of this
  library.

In the absence of options that inhibit invocation of the link editor,
such as
**\(mic**,
the
_fort77_
utility shall cause the equivalent of a
**\(mil&nbsp;f**
operand to be passed to the link editor as the last
**\(mil**
operand, causing it to be searched after all other object files and
libraries are loaded.

It is unspecified whether the library
**libf.a**
exists as a regular file. The implementation may accept as
**\(mil**
operands names of objects that do not exist as regular files.

<a name="external-symbols"></a>

### External Symbols


The FORTRAN compiler and link editor shall support the significance of
external symbols up to a length of at least 31 bytes; case folding is
permitted. The action taken upon encountering symbols exceeding the
implementation-defined maximum symbol length is unspecified.

The compiler and link editor shall support a minimum of 511 external
symbols per source or object file, and a minimum of 4\|095 external
symbols total. A diagnostic message is written to standard output if
the implementation-defined limit is exceeded; other actions are
unspecified.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful compilation or link edit.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

When
_fort77_
encounters a compilation error, it shall write a diagnostic to standard
error and continue to compile other source code operands. It shall
return a non-zero exit status, but it is implementation-defined
whether an object module is created. If the link edit is unsuccessful,
a diagnostic message shall be written to standard error, and
_fort77_
shall exit with a non-zero status.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

None.

<a name="examples"></a>

# Examples

The following usage example compiles
**xyz.f**
and creates the executable file
**foo**:

    
    fort77 (mio foo xyz.f


The following example compiles
**xyz.f**
and creates the object file
**xyz.o**:

    
    fort77 (mic xyz.f


The following example compiles
**xyz.f**
and creates the executable file
**a.out**:

    
    fort77 xyz.f


The following example compiles
**xyz.f**,
links it with
**b.o**,
and creates the executable
**a.out**:

    
    fort77 xyz.f b.o


<a name="rationale"></a>

# Rationale

The name of this utility was chosen as
_fort77_
to parallel the renaming of the C compiler. The name
_f77_
was not chosen to avoid problems with historical implementations. The
ANSI&nbsp;X3.9-1978 standard was selected as a normative reference because the ISO/IEC version
of FORTRAN-77 has been superseded by the ISO/IEC&nbsp;1539:\|1991 standard.

The file inclusion and symbol definition
**#define**
mechanisms used by the
_c99_
utility were not included in this volume of POSIX.1-2008—even though they are commonly
implemented—since there is no requirement that the FORTRAN compiler
use the C preprocessor.

The
**\(mionetrip**
option was not included in this volume of POSIX.1-2008, even though many historical compilers
support it, because it is derived from FORTRAN-66; it is an anachronism
that should not be perpetuated.

Some implementations produce compilation listings. This aspect of
FORTRAN has been left unspecified because there was controversy
concerning the various methods proposed for implementing it: a
**\(miV**
option overlapped with historical vendor practice and a naming
convention of creating files with
**.l**
suffixes collided with historical
_lex_
file naming practice.

There is no
**\(miI**
option in this version of this volume of POSIX.1-2008 to specify a directory for file
inclusion. An INCLUDE directive has been a part of the Fortran-90
discussions, but an interface supporting that standard is not in the
current scope.

It is noted that many FORTRAN compilers produce an object module even
when compilation errors occur; during a subsequent compilation, the
compiler may patch the object module rather than recompiling all the
code. Consequently, it is left to the implementor whether or not an
object file is created.

A reference to MIL-STD-1753
was removed from an early proposal in response to a request from the
POSIX FORTRAN-binding standard developers. It was not the intention of
the standard developers to require certification of the FORTRAN
compiler, and IEEE&nbsp;Std&nbsp;1003.9-1992 does not specify the military standard or any
special preprocessing requirements. Furthermore, use of that document
would have been inappropriate for an international standard.

The specification of optimization has been subject to changes through
early proposals. At one time,
**\(miO**
and
**\(miN**
were Booleans: optimize and do not optimize (with an unspecified
default). Some historical practice led this to be changed to:

* **\(miO**&nbsp;0  
  No optimization.
* **\(miO**&nbsp;1  
  Some level of optimization.
* **\(miO&nbsp;n**  
  Other, unspecified levels of optimization.

It is not always clear whether \`\`good code generation'' is the same
thing as optimization. Simple optimizations of local actions do not
usually affect the semantics of a program. The
**\(miO**
0 option has been included to accommodate the very particular nature of
scientific calculations in a highly optimized environment; compilers
make errors. Some degree of optimization is expected, even if it is not
documented here, and the ability to shut it off completely could be
important when porting an application. An implementation may treat
**\(miO**
0 as \`\`do less than normal'' if it wishes, but this is only meaningful
if any of the operations it performs can affect the semantics of a
program. It is highly dependent on the implementation whether doing
less than normal is logical. It is not the intent of the
**\(miO**
0 option to ask for inefficient code generation, but rather to assure
that any semantically visible optimization is suppressed.

The specification of standard library access is consistent with the C
compiler specification. Implementations are not required to have
**/usr/lib/libf.a**,
as many historical implementations do, but if not they are required to
recognize
**f**
as a token.

External symbol size limits are in normative text; conforming
applications need to know these limits. However, the minimum maximum
symbol length should be taken as a constraint on a conforming
application, not on an implementation, and consequently the action
taken for a symbol exceeding the limit is unspecified. The minimum size
for the external symbol table was added for similar reasons.

The CONSEQUENCES OF ERRORS section clearly specifies the behavior of
the compiler when compilation or link-edit errors occur. The behavior
of several historical implementations was examined, and the choice was
made to be silent on the status of the executable, or
**a.out**,
file in the face of compiler or linker errors. If a linker writes the
executable file, then links it on disk with
_lseek_()s
and
_write_()s,
the partially linked executable file can be left on disk and its
execute bits turned off if the link edit fails. However, if the linker
links the image in memory before writing the file to disk, it need not
touch the executable file (if it already exists) because the link edit
fails. Since both approaches are historical practice, a conforming
application shall rely on the exit status of
_fort77_,
rather than on the existence or mode of the executable file.

The
**\(mig**
and
**\(mis**
options are not specified as mutually-exclusive. Historically, these two
options have been mutually-exclusive, but because both are so loosely
specified, it seemed appropriate to leave their interaction
unspecified.

The requirement that conforming applications specify compiler options
separately is to reserve the multi-character option name space for
vendor-specific compiler options, which are known to exist in many
historical implementations. Implementations are not required to
recognize, for example,
**\(migc**
as if it were
**\(mig**
**\(mic**;
nor are they forbidden from doing so. The SYNOPSIS shows all of the
options separately to highlight this requirement on applications.

Echoing filenames to standard error is considered a diagnostic message
because it would otherwise be difficult to associate an error message
with the erring file. They are described with \`\`may'' to allow
implementations to use other methods of identifying files and to
parallel the description in
_c99_.

<a name="future-directions"></a>

# Future Directions

A compilation system based on the ISO/IEC&nbsp;1539:\|1991 standard may be considered for a
future version; it may have a different utility name from
_fort77_.

<a name="see-also"></a>

# See Also

__ar_\^_,
__asa_\^_,
__c99_\^_,
__umask_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__exec_\^_

<a name="copyright"></a>

# Copyright

Portions of this text are reprinted and reproduced in electronic form
from IEEE Std 1003.1, 2013 Edition, Standard for Information Technology
-- Portable Operating System Interface (POSIX), The Open Group Base
Specifications Issue 7, Copyright (C) 2013 by the Institute of
Electrical and Electronics Engineers, Inc and The Open Group.
(This is POSIX.1-2008 with the 2013 Technical Corrigendum 1 applied.) In the
event of any discrepancy between this version and the original IEEE and
The Open Group Standard, the original IEEE and The Open Group Standard
is the referee document. The original Standard can be obtained online at
http://www.unix.org/online.html .

Any typographical or formatting errors that appear
in this page are most likely
to have been introduced during the conversion of the source files to
man page format. To report such errors, see
https://www.kernel.org/doc/man-pages/reporting_bugs.html .
