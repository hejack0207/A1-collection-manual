# test(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

test
— evaluate expression

<a name="synopsis"></a>

# Synopsis

```


```
    test [expression]
    
    [ [expression] ]

<a name="description"></a>

# Description

The
_test_
utility shall evaluate the
_expression_
and indicate the result of the evaluation by its exit status. An exit
status of zero indicates that the expression evaluated as true and an
exit status of 1 indicates that the expression evaluated as false.

In the second form of the utility, which uses
**"[]"**
rather than
_test_,
the application shall ensure that the square brackets are separate
arguments.

<a name="options"></a>

# Options

The
_test_
utility shall not recognize the
**"\(mi\|\(mi"**
argument in the manner specified by Guideline 10 in the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

No options shall be supported.

<a name="operands"></a>

# Operands

The application shall ensure that all operators and elements of
primaries are presented as separate arguments to the
_test_
utility.

The following primaries can be used to construct
_expression_:

* **\(mib&nbsp;pathname**  
  True if
  _pathname_
  resolves to en existing directory entry for a block special file.
  False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that is not a block
  special file.
* **\(mic&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a character special file.
  False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that is not a character
  special file.
* **\(mid&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a directory. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that is not a
  directory.
* **\(mie&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry. False if
  _pathname_
  cannot be resolved.
* **\(mif&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a regular file. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that is not a
  regular file.
* **\(mig&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a file that has its
  set-group-ID flag set. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that does not have
  its set-group-ID flag set.
* **\(mih&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a symbolic link. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that is not a symbolic
  link. If the final component of
  _pathname_
  is a symbolic link, that symbolic link is not followed.
* **\(miL&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a symbolic link. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that is not a symbolic
  link. If the final component of
  _pathname_
  is a symbolic link, that symbolic link is not followed.
* **\(min&nbsp;string**  
  True if the length of
  _string_
  is non-zero; otherwise, false.
* **\(mip&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a FIFO. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that is not a FIFO.
* **\(mir&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a file for which permission
  to read from the file will be granted, as defined in
  _Section 1.1.1.4_, _File Read_, _Write_, _and Creation_.
  False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file for which permission
  to read from the file will not be granted.
* **\(miS&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a socket. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that is not a socket.
* **\(mis&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a file that has a size
  greater than zero. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that does not have
  a size greater than zero.
* **\(mit&nbsp;file\_descriptor**    
  True if file descriptor number
  _file_descriptor_
  is open and is associated with a terminal. False if
  _file_descriptor_
  is not a valid file descriptor number, or if file descriptor number
  _file_descriptor_
  is not open, or if it is open but is not associated with a terminal.
* **\(miu&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a file that has its
  set-user-ID flag set. False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file that does not have
  its set-user-ID flag set.
* **\(miw&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a file for which permission
  to write to the file will be granted, as defined in
  _Section 1.1.1.4_, _File Read_, _Write_, _and Creation_.
  False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file for which permission
  to write to the file will not be granted.
* **\(mix&nbsp;pathname**  
  True if
  _pathname_
  resolves to an existing directory entry for a file for which permission
  to execute the file (or search it, if it is a directory) will be granted,
  as defined in
  _Section 1.1.1.4_, _File Read_, _Write_, _and Creation_.
  False if
  _pathname_
  cannot be resolved, or if
  _pathname_
  resolves to an existing directory entry for a file for which permission
  to execute (or search) the file will not be granted.
* **\(miz&nbsp;string**  
  True if the length of string
  _string_
  is zero; otherwise, false.
* _string_  
  True if the string
  _string_
  is not the null string; otherwise, false.
* s1**&nbsp;\(eq&nbsp;s2**  
  True if the strings
  _s1_
  and
  _s2_
  are identical; otherwise, false.
* s1**&nbsp;!=&nbsp;s2**  
  True if the strings
  _s1_
  and
  _s2_
  are not identical; otherwise, false.
* n1**&nbsp;\(mieq&nbsp;n2**  
  True if the integers
  _n1_
  and
  _n2_
  are algebraically equal; otherwise, false.
* n1**&nbsp;\(mine&nbsp;n2**  
  True if the integers
  _n1_
  and
  _n2_
  are not algebraically equal; otherwise, false.
* n1**&nbsp;\(migt&nbsp;n2**  
  True if the integer
  _n1_
  is algebraically greater than the integer
  _n2_;
  otherwise, false.
* n1**&nbsp;\(mige&nbsp;n2**  
  True if the integer
  _n1_
  is algebraically greater than or equal to the integer
  _n2_;
  otherwise, false.
* n1**&nbsp;\(milt&nbsp;n2**  
  True if the integer
  _n1_
  is algebraically less than the integer
  _n2_;
  otherwise, false.
* n1**&nbsp;\(mile&nbsp;n2**  
  True if the integer
  _n1_
  is algebraically less than or equal to the integer
  _n2_;
  otherwise, false.
* expression1**&nbsp;\(mia&nbsp;expression2**    
  True if both
  _expression1_
  and
  _expression2_
  are true; otherwise, false. The
  **\(mia**
  binary primary is left associative. It has a higher precedence than
  **\(mio**.
* expression1**&nbsp;\(mio&nbsp;expression2**    
  True if either
  _expression1_
  or
  _expression2_
  is true; otherwise, false. The
  **\(mio**
  binary primary is left associative.

With the exception of the
**\(mih**
_pathname_
and
**\(miL**
_pathname_
primaries, if a
_pathname_
argument is a symbolic link,
_test_
shall evaluate the expression by resolving the symbolic link and using
the file referenced by the link.

These primaries can be combined with the following operators:

* **!&nbsp;expression**  
  True if
  _expression_
  is false. False if
  _expression_
  is true.
* **(&nbsp;expression&nbsp;)**  
  True if
  _expression_
  is true. False if
  _expression_
  is false. The parentheses can be used to alter the normal precedence
  and associativity.

The primaries with two elements of the form:

    
    (miprimary_operator primary_operand


are known as
_unary primaries_.
The primaries with three elements in either of the two forms:

    
    primary_operand (miprimary_operator primary_operand
    
    primary_operand primary_operator primary_operand


are known as
_binary primaries_.
Additional implementation-defined operators and
_primary_operator_s
may be provided by implementations. They shall be of the form \(mi\c
_operator_
where the first character of
_operator_
is not a digit.

The algorithm for determining the precedence of the operators and the
return value that shall be generated is based on the number of
arguments presented to
_test_.
(However, when using the
**"[...]"**
form, the
&lt;right-square-bracket&gt;
final argument shall not be counted in this algorithm.)

In the following list, $1, $2, $3, and $4 represent the arguments
presented to
_test_:

* 0&nbsp;arguments:  
  Exit false (1).
* 1&nbsp;argument:  
  Exit true (0) if $1 is not null; otherwise, exit false.
* 2&nbsp;arguments:  


*  *  
  If $1 is
  **'!'**,
  exit true if $2 is null, false if $2 is not null.
*  *  
  If $1 is a unary primary, exit true if the unary test is true, false if
  the unary test is false.
*  *  
  Otherwise, produce unspecified results.

* 3&nbsp;arguments:  


*  *  
  If $2 is a binary primary, perform the binary test of $1 and $3.
*  *  
  If $1 is
  **'!'**,
  negate the two-argument test of $2 and $3.
*  *  
  If $1 is
  **'('**
  and $3 is
  **')'**,
  perform the unary test of $2.
  On systems that do not support the XSI option, the results are
  unspecified if $1 is
  **'('**
  and $3 is
  **')'**.
*  *  
  Otherwise, produce unspecified results.

* 4&nbsp;arguments:  


*  *  
  If $1 is
  **'!'**,
  negate the three-argument test of $2, $3, and $4.
*  *  
  If $1 is
  **'('**
  and $4 is
  **')'**,
  perform the two-argument test of $2 and $3.
  On systems that do not support the XSI option, the results are
  unspecified if $1 is
  **'('**
  and $4 is
  **')'**.
*  *  
  Otherwise, the results are unspecified.

* &gt;4&nbsp;arguments:  
  The results are unspecified.

On XSI-conformant systems, combinations of primaries and operators
shall be evaluated using the precedence and associativity rules
described previously. In addition, the string comparison binary
primaries
**'='**
and
**"!="**
shall have a higher precedence than any unary primary.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_test_:

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
  multi-byte characters in arguments).
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

Not used.

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
  _expression_
  evaluated to true.
* \01  
  _expression_
  evaluated to false or
  _expression_
  was missing.
* &gt;1  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

The XSI extensions specifying the
**\(mia**
and
**\(mio**
binary primaries and the
**'('**
and
**')'**
operators have been marked obsolescent. (Many expressions using them
are ambiguously defined by the grammar depending on the specific
expressions being evaluated.) Scripts using these expressions should be
converted to the forms given below. Even though many implementations
will continue to support these obsolescent forms, scripts should be
extremely careful when dealing with user-supplied input that could be
confused with these and other primaries and operators. Unless the
application developer knows all the cases that produce input to the
script, invocations like:

    
    test "$1" (mia "$2"


should be written as:

    
    test "$1" && test "$2"


to avoid problems if a user supplied values such as $1 set to
**'!'**
and $2 set to the null string. That is, in cases where maximal
portability is of concern, replace:

    
    test expr1 (mia expr2


with:

    
    test expr1 && test expr2


and replace:

    
    test expr1 (mio expr2


with:

    
    test expr1 || test expr2


but note that, in
_test_,
**\(mia**
has higher precedence than
**\(mio**
while
**"&&"**
and
**"||"**
have equal precedence in the shell.

Parentheses or braces can be used in the shell command language to
effect grouping.

Parentheses must be escaped when using
_sh_;
for example:

    
    test e( expr1 (mia expr2 e) (mio expr3


This command is not always portable even on XSI-conformant systems
depending on the expressions specified by
_expr_1,
_expr_2,
and
_expr_3.
The following form can be used instead:

    
    ( test expr1 && test expr2 ) || test expr3


The two commands:

    
    test "$1"
    test ! "$1"


could not be used reliably on some historical systems. Unexpected
results would occur if such a
_string_
expression were used and $1 expanded to
**'!'**,
**'('**,
or a known unary primary. Better constructs are:

    
    test (min "$1"
    test (miz "$1"

respectively.

Historical systems have also been unreliable given the common
construct:

    
    test "$response" = "expected string"


One of the following is a more reliable form:

    
    test "X$response" = "Xexpected string"
    test "expected string" = "$response"


Note that the second form assumes that
_expected string_
could not be confused with any unary primary. If
_expected string_
starts with
**'\(mi'**,
**'('**,
**'!'**,
or even
**'='**,
the first form should be used instead. Using the preceding rules
without the XSI marked extensions, any of the three comparison forms is
reliable, given any input. (However, note that the strings are quoted
in all cases.)

Because the string comparison binary primaries,
**'='**
and
**"!="**,
have a higher precedence than any unary primary in the greater than 4
argument case, unexpected results can occur if arguments are not
properly prepared. For example, in:

    
    test (mid $1 (mio (mid $2


If $1 evaluates to a possible directory name of
**'='**,
the first three arguments are considered a string comparison, which
shall cause a syntax error when the second
**\(mid**
is encountered. One of the following forms prevents this; the second
is preferred:

    
    test e( (mid "$1" e) (mio e( (mid "$2" e)
    test (mid "$1" || test (mid "$2"


Also in the greater than 4 argument case:

    
    test "$1" = "bat" (mia "$2" = "ball"


syntax errors occur if $1 evaluates to
**'('**
or
**'!'**.
One of the following forms prevents this; the third is preferred:

    
    test "X$1" = "Xbat" (mia "X$2" = "Xball"
    test "$1" = "bat" && test "$2" = "ball"
    test "X$1" = "Xbat" && test "X$2" = "Xball"


<a name="examples"></a>

# Examples


*  1.  
  Exit if there are not two or three arguments (two variations):

    
    if [ $# (mine 2 ] && [ $# (mine 3 ]; then exit 1; fi
    if [ $# (milt 2 ] || [ $# (migt 3 ]; then exit 1; fi


*  2.  
  Perform a
  _mkdir_
  if a directory does not exist:

    
    test ! (mid tempdir && mkdir tempdir


*  3.  
  Wait for a file to become non-readable:

    
    while test (mir thefile
    do
        sleep 30
    done
    echo '"thefile" is no longer readable'


*  4.  
  Perform a command if the argument is one of three strings (two
  variations):

    
    if [ "$1" = "pear" ] || [ "$1" = "grape" ] || [ "$1" = "apple" ]
    then
        command
    fi
    
    case "$1" in
        pear|grape|apple) command ;;
    esac


<a name="rationale"></a>

# Rationale

The KornShell-derived conditional command (double bracket
**[[\|]]**)
was removed from the shell command language description in an early
proposal. Objections were raised that the real problem is misuse of the
_test_
command (\c
**[**),
and putting it into the shell is the wrong way to fix the problem.
Instead, proper documentation and a new shell reserved word (\c
**!**)
are sufficient.

Tests that require multiple
_test_
operations can be done at the shell level using individual invocations
of the
_test_
command and shell logicals, rather than using the error-prone
**\(mio**
flag of
_test_.

XSI-conformant systems support more than four arguments.

XSI-conformant systems support the combining of primaries with the
following constructs:

* expression1** \(mia expression2**    
  True if both
  _expression1_
  and
  _expression2_
  are true.
* expression1** \(mio expression2**    
  True if at least one of
  _expression1_
  and
  _expression2_
  are true.
* **( expression )**    
  True if
  _expression_
  is true.

In evaluating these more complex combined expressions, the following
precedence rules are used:

*  *  
  The unary primaries have higher precedence than the algebraic binary
  primaries.
*  *  
  The unary primaries have lower precedence than the string binary
  primaries.
*  *  
  The unary and binary primaries have higher precedence than the unary
  _string_
  primary.
*  *  
  The
  **!**
  operator has higher precedence than the
  **\(mia**
  operator, and the
  **\(mia**
  operator has higher precedence than the
  **\(mio**
  operator.
*  *  
  The
  **\(mia**
  and
  **\(mio**
  operators are left associative.
*  *  
  The parentheses can be used to alter the normal precedence and
  associativity.

The BSD and System V versions of
**\(mif**
are not the same. The BSD definition was:

* **\(mif&nbsp;file**  
  True if
  _file_
  exists and is not a directory.

The SVID version (true if the file exists and is a regular file) was
chosen for this volume of POSIX.1-2008 because its use is consistent with the
**\(mib**,
**\(mic**,
**\(mid**,
and
**\(mip**
operands (\c
_file_
exists and is a specific file type).

The
**\(mie**
primary, possessing similar functionality to that provided by the C
shell, was added because it provides the only way for a shell script to
find out if a file exists without trying to open the file. Since
implementations are allowed to add additional file types, a portable
script cannot use:

    
    test (mib foo (mio (mic foo (mio (mid foo (mio (mif foo (mio (mip foo


to find out if
**foo**
is an existing file. On historical BSD systems, the existence of a
file could be determined by:

    
    test (mif foo (mio (mid foo


but there was no easy way to determine that an existing file was a
regular file. An early proposal used the KornShell
**\(mia**
primary (with the same meaning), but this was changed to
**\(mie**
because there were concerns about the high probability of humans
confusing the
**\(mia**
primary with the
**\(mia**
binary operator.

The following options were not included in this volume of POSIX.1-2008, although they are
provided by some implementations. These operands should not be used by
new implementations for other purposes:

* **\(mik&nbsp;file**  
  True if
  _file_
  exists and its sticky bit is set.
* **\(miC&nbsp;file**  
  True if
  _file_
  is a contiguous file.
* **\(miV&nbsp;file**  
  True if
  _file_
  is a version file.

The following option was not included because it was undocumented in
most implementations, has been removed from some implementations
(including System V), and the functionality is provided by the shell
(see
_Section 2.6.2_, _Parameter Expansion_.

* **\(mil&nbsp;string**  
  The length of the string
  _string_.

The
**\(mib**,
**\(mic**,
**\(mig**,
**\(mip**,
**\(miu**,
and
**\(mix**
operands are derived from the SVID; historical BSD does not provide
them. The
**\(mik**
operand is derived from System V; historical BSD does not provide it.

On historical BSD systems,
_test_
**\(miw**
_directory_
always returned false because
_test_
tried to open the directory for writing, which always fails.

Some additional primaries newly invented or from the KornShell appeared
in an early proposal as part of the conditional command (\c
**[[\|]]**):
_s1_
**&gt;**
_s2_,
_s1_
**&lt;**
_s2_,
_str_
**=**
_pattern_,
_str_
**!=**
_pattern_,
_f1_
**\(mint**
_f2_,
_f1_
**\(miot**
_f2_,
and
_f1_
**\(mief**
_f2_.
They were not carried forward into the
_test_
utility when the conditional command was removed from the shell because
they have not been included in the
_test_
utility built into historical implementations of the
_sh_
utility.

The
**\(mit**
_file_descriptor_
primary is shown with a mandatory argument because the grammar is
ambiguous if it can be omitted. Historical implementations have allowed
it to be omitted, providing a default of 1.

It is noted that
**'['**
is not part of the portable filename character set; however, since it
is required to be encoded by a single byte, and is part of the portable
character set, the name of this utility forms a character string across
all supported locales.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 1.1.1.4_, _File Read_, _Write_, _and Creation_,
__find_\^_

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
