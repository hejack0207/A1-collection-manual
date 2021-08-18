# cflow(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

cflow
— generate a C-language flowgraph (**DEVELOPMENT**)

<a name="synopsis"></a>

# Synopsis

```


```
    cflow [(mir] [(mid num] [(miD name[=def]]... [(mii incl] [(miI dir]...
        [(miU dir]... file...

<a name="description"></a>

# Description

The
_cflow_
utility shall analyze a collection of object files or assembler,
C-language,
_lex_,
or
_yacc_
source files, and attempt to build a graph, written to standard output,
charting the external references.

<a name="options"></a>

# Options

The
_cflow_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except that the order of the
**\(miD**,
**\(miI**,
and
**\(miU**
options (which are identical to their interpretation by
_c99_)
is significant.

The following options shall be supported:

* **\(mid&nbsp;num**  
  Indicate the depth at which the flowgraph is cut off. The application
  shall ensure that the argument
  _num_
  is a decimal integer. By default this is a very large number
  (typically greater than 32\|000). Attempts to set the cut-off depth to
  a non-positive integer shall be ignored.
* **\(mii&nbsp;incl**  
  Increase the number of included symbols. The
  _incl_
  option-argument is one of the following characters:
    * _x_  
      Include external and static data symbols. The default shall be to
      include only functions in the flowgraph.
    * \_  
      (Underscore) Include names that begin with an
      &lt;underscore&gt;.
      The default shall be to exclude these functions (and data if
      **\(mii&nbsp;x**
      is used).
* **\(mir**  
  Reverse the caller:callee relationship, producing an inverted listing
  showing the callers of each function. The listing shall also be sorted
  in lexicographical order by callee.

<a name="operands"></a>

# Operands

The following operand is supported:

* _file_  
  The pathname of a file for which a graph is to be generated.
  Filenames suffixed by
  **.l**
  shall shall be taken to be
  _lex_
  input,
  **.y**
  as
  _yacc_
  input,
  **.c**
  as
  _c99_
  input, and
  **.i**
  as the output of
  _c99_
  **\(miE**.
  Such files shall be processed as appropriate, determined by their
  suffix.

Files suffixed by
**.s**
(conventionally assembler source) may have more limited information
extracted from them.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

The input files shall be object files or assembler, C-language,
_lex_,
or
_yacc_
source files.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_cflow_:

* _LANG_  
  Provide a default value for the internationalization variables that are
  unset or null. (See the Base Definitions volume of POSIX.1-2008,
  _Section 8.2_, _Internationalization Variables_
  for the precedence of internationalization variables used to determine
  the values of locale categories.)
* _LC\_ALL_  
  If set to a non-empty string value, override the values of all the
  other internationalization variables.
* _LC\_COLLATE_    
  Determine the locale for the ordering of the output when the
  **\(mir**
  option is used.
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

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The flowgraph written to standard output shall be formatted as follows:

    
    "%d %s:%sen", <reference number>, <global>, <definition>


Each line of output begins with a reference (that is, line) number,
followed by indentation of at least one column position per level.
This is followed by the name of the global, a
&lt;colon&gt;,
and its definition. Normally globals are only functions not defined as
an external or beginning with an
&lt;underscore&gt;;
see the OPTIONS section for the
**\(mii**
inclusion option. For information extracted from C-language source, the
definition consists of an abstract type declaration (for example,
**char ***)
and, delimited by angle brackets, the name of the source file and the
line number where the definition was found. Definitions extracted from
object files indicate the filename and location counter under which
the symbol appeared (for example,
_text_).

Once a definition of a name has been written, subsequent references to
that name contain only the reference number of the line where the
definition can be found. For undefined references, only
**"&lt;\|&gt;"**
shall be written.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

None.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  Successful completion.
* &gt;0  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Files produced by
_lex_
and
_yacc_
cause the reordering of line number declarations, and this can confuse
_cflow_.
To obtain proper results, the input of
_yacc_
or
_lex_
must be directed to
_cflow_.

<a name="examples"></a>

# Examples

Given the following in
**file.c**:

    
    int i;
    int f();
    int g();
    int h();
    int
    main()
    {
        f();
        g();
        f();
    }
    int
    f()
    {
        i = h();
    }


The command:

    
    cflow (mii x file.c


produces the output:

    
    1 main: int(), <file.c 6>
    2    f: int(), <file.c 13>
    3        h: <>
    4        i: int, <file.c 1>
    5    g: <>


<a name="rationale"></a>

# Rationale

None.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__c99_\^_,
__lex_\^_,
__yacc_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

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
