# getopts(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

getopts
— parse utility options

<a name="synopsis"></a>

# Synopsis

```


```
    getopts optstring name [arg...]

<a name="description"></a>

# Description

The
_getopts_
utility shall retrieve options and option-arguments from a list of
parameters. It shall support the Utility Syntax Guidelines 3 to 10,
inclusive, described in the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

Each time it is invoked, the
_getopts_
utility shall place the value of the next option in the shell variable
specified by the
_name_
operand and the index of the next argument to be processed in the shell
variable
_OPTIND_.
Whenever the shell is invoked,
_OPTIND_
shall be initialized to 1.

When the option requires an option-argument, the
_getopts_
utility shall place it in the shell variable
_OPTARG_.
If no option was found, or if the option that was found does not have
an option-argument,
_OPTARG_
shall be unset.

If an option character not contained in the
_optstring_
operand is found where an option character is expected, the shell
variable specified by
_name_
shall be set to the
&lt;question-mark&gt;
(\c
**'?'**)
character. In this case, if the first character in
_optstring_
is a
&lt;colon&gt;
(\c
**':'**),
the shell variable
_OPTARG_
shall be set to the option character found, but no output shall be
written to standard error; otherwise, the shell variable
_OPTARG_
shall be unset and a diagnostic message shall be written to standard
error. This condition shall be considered to be an error detected in
the way arguments were presented to the invoking application, but shall
not be an error in
_getopts_
processing.

If an option-argument is missing:

*  *  
  If the first character of
  _optstring_
  is a
  &lt;colon&gt;,
  the shell variable specified by
  _name_
  shall be set to the
  &lt;colon&gt;
  character and the shell variable
  _OPTARG_
  shall be set to the option character found.
*  *  
  Otherwise, the shell variable specified by
  _name_
  shall be set to the
  &lt;question-mark&gt;
  character, the shell variable
  _OPTARG_
  shall be unset, and a diagnostic message shall be written to standard
  error. This condition shall be considered to be an error detected in
  the way arguments were presented to the invoking application, but shall
  not be an error in
  _getopts_
  processing; a diagnostic message shall be written as stated, but the
  exit status shall be zero.

When the end of options is encountered, the
_getopts_
utility shall exit with a return value greater than zero; the shell
variable
_OPTIND_
shall be set to the index of the first operand, or the value
**"$#"**+1
if there are no operands; the
_name_
variable shall be set to the
&lt;question-mark&gt;
character. Any of the following shall identify the end of options:
the first
**"\(mi\|\(mi"**
argument that is not an option-argument, finding an argument that is
not an option-argument and does not begin with a
**'\(mi'**,
or encountering an error.

The shell variables
_OPTIND_
and
_OPTARG_
shall be local to the caller of
_getopts_
and shall not be exported by default.

The shell variable specified by the
_name_
operand,
_OPTIND_,
and
_OPTARG_
shall affect the current shell execution environment; see
_Section 2.12_, _Shell Execution Environment_.

If the application sets
_OPTIND_
to the value 1, a new set of parameters can be used: either the
current positional parameters or new
_arg_
values. Any other attempt to invoke
_getopts_
multiple times in a single shell execution environment with parameters
(positional parameters or
_arg_
operands) that are not the same in all invocations, or with an
_OPTIND_
value modified to be a value other than 1, produces unspecified
results.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The following operands shall be supported:

* _optstring_  
  A string containing the option characters recognized by the utility
  invoking
  _getopts_.
  If a character is followed by a
  &lt;colon&gt;,
  the option shall be expected to have an argument, which should be supplied
  as a separate argument. Applications should specify an option character
  and its option-argument as separate arguments, but
  _getopts_
  shall interpret the characters following an option character requiring
  arguments as an argument whether or not this is done. An explicit null
  option-argument need not be recognized if it is not supplied as a
  separate argument when
  _getopts_
  is invoked. (See also the
  _getopt_()
  function defined in the System Interfaces volume of POSIX.1-2008.) The characters
  &lt;question-mark&gt;
  and
  &lt;colon&gt;
  shall not be used as option characters by an application. The use of
  other option characters that are not alphanumeric produces unspecified
  results. If the option-argument is not supplied as a separate argument
  from the option character, the value in
  _OPTARG_
  shall be stripped of the option character and the
  **'\(mi'**.
  The first character in
  _optstring_
  determines how
  _getopts_
  behaves if an option character is not known or an option-argument is
  missing.
* _name_  
  The name of a shell variable that shall be set by the
  _getopts_
  utility to the option character that was found.

The
_getopts_
utility by default shall parse positional parameters passed to the
invoking shell procedure. If
_arg_s
are given, they shall be parsed instead of the positional parameters.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_getopts_:

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
* _OPTIND_  
  This variable shall be used by the
  _getopts_
  utility as the index of the next argument to be processed.

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

Not used.

<a name="stderr"></a>

# Stderr

Whenever an error is detected and the first character in the
_optstring_
operand is not a
&lt;colon&gt;
(\c
**':'**),
a diagnostic message shall be written to standard error with the
following information in an unspecified format:

*  *  
  The invoking program name shall be identified in the message. The
  invoking program name shall be the value of the shell special parameter
  0 (see
  _Section 2.5.2_, _Special Parameters_)
  at the time the
  _getopts_
  utility is invoked. A name equivalent to:

    
    basename "$0"


may be used.

*  *  
  If an option is found that was not specified in
  _optstring_,
  this error is identified and the invalid option character shall be
  identified in the message.
*  *  
  If an option requiring an option-argument is found, but an
  option-argument is not found, this error shall be identified and the
  invalid option character shall be identified in the message.

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
  An option, specified or unspecified by
  _optstring_,
  was found.
* &gt;0  
  The end of options was encountered or an error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Since
_getopts_
affects the current shell execution environment, it is generally
provided as a shell regular built-in. If it is called in a subshell or
separate utility execution environment, such as one of the following:

    
    (getopts abc value "$@")
    nohup getopts ...
    find . (miexec getopts ... e;


it does not affect the shell variables in the caller's environment.

Note that shell functions share
_OPTIND_
with the calling shell even though the positional parameters are
changed. If the calling shell and any of its functions uses
_getopts_
to parse arguments, the results are unspecified.

<a name="examples"></a>

# Examples

The following example script parses and displays its arguments:

    
    aflag=
    bflag=
    while getopts ab: name
    do
        case $name in
        a)    aflag=1;;
        b)    bflag=1
              bval="$OPTARG";;
        ?)   printf "Usage: %s: [(mia] [(mib value] argsen" $0
              exit 2;;
        esac
    done
    if [ ! (miz "$aflag" ]; then
        printf "Option (mia specifieden"
    fi
    if [ ! (miz "$bflag" ]; then
        printf 'Option (mib "%s" specifieden' "$bval"
    fi
    shift $(($OPTIND (mi 1))
    printf "Remaining arguments are: %sen$*"


<a name="rationale"></a>

# Rationale

The
_getopts_
utility was chosen in preference to the System V
_getopt_
utility because
_getopts_
handles option-arguments containing
&lt;blank&gt;
characters.

The
_OPTARG_
variable is not mentioned in the ENVIRONMENT VARIABLES section because
it does not affect the execution of
_getopts_;
it is one of the few \`\`output-only'' variables used by the standard
utilities.

The
&lt;colon&gt;
is not allowed as an option character because that is not historical
behavior, and it violates the Utility Syntax Guidelines. The
&lt;colon&gt;
is now specified to behave as in the KornShell version of the
_getopts_
utility; when used as the first character in the
_optstring_
operand, it disables diagnostics concerning missing option-arguments
and unexpected option characters. This replaces the use of the
_OPTERR_
variable that was specified in an early proposal.

The formats of the diagnostic messages produced by the
_getopts_
utility and the
_getopt_()
function are not fully specified because implementations with superior
(\`\`friendlier'') formats objected to the formats used by some
historical implementations. The standard developers considered it
important that the information in the messages used be uniform between
_getopts_
and
_getopt_().
Exact duplication of the messages might not be possible, particularly
if a utility is built on another system that has a different
_getopt_()
function, but the messages must have specific information included so
that the program name, invalid option character, and type of error can
be distinguished by a user.

Only a rare application program intercepts a
_getopts_
standard error message and wants to parse it. Therefore,
implementations are free to choose the most usable messages they can
devise. The following formats are used by many historical
implementations:

    
    "%s: illegal option (mi|(mi %cen", <program name>, <option character>
    
    "%s: option requires an argument (mi|(mi %cen", <program name>, e
        <option character>


Historical shells with built-in versions of
_getopt_()
or
_getopts_
have used different formats, frequently not even indicating the option
character found in error.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.5.2_, _Special Parameters_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 12.2_, _Utility Syntax Guidelines_

The System Interfaces volume of POSIX.1-2008,
__getopt_\^(\|)_

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
