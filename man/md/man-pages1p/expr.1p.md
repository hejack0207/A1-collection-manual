# expr(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

expr
— evaluate arguments as an expression

<a name="synopsis"></a>

# Synopsis

```


```
    expr operand...

<a name="description"></a>

# Description

The
_expr_
utility shall evaluate an expression and write the result to standard
output.

<a name="options"></a>

# Options

None.

<a name="operands"></a>

# Operands

The single expression evaluated by
_expr_
shall be formed from the
_operand_
operands, as described in the EXTENDED DESCRIPTION section. The
application shall ensure that each of the expression operator symbols:

    
    (  )  |  &  =  >  >=  <  <=  !=  +  (mi  *  /  %  :


and the symbols
_integer_
and
_string_
in the table are provided as separate arguments to
_expr_.

<a name="stdin"></a>

# Stdin

Not used.

<a name="input-files"></a>

# Input Files

None.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_expr_:

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
  Determine the locale for the behavior of ranges, equivalence classes,
  and multi-character collating elements within regular expressions and
  by the string comparison operators.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments) and the behavior of character
  classes within regular expressions.
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

The
_expr_
utility shall evaluate the expression and write the result, followed by
a
&lt;newline&gt;,
to standard output.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description

The formation of the expression to be evaluated is shown in the
following table. The symbols
_expr_,
_expr1_,
and
_expr2_
represent expressions formed from
_integer_
and
_string_
symbols and the expression operator symbols (all separate arguments) by
recursive application of the constructs described in the table. The
expressions are listed in order of increasing precedence, with
equal-precedence operators grouped between horizontal lines. All of
the operators shall be left-associative.
.TS
center tab(@) box;
cB | cB
l | lw(4i).
Expression@Description
_
_expr1_&nbsp;|&nbsp;_expr2_@T{
Returns the evaluation of
_expr1_
if it is neither null nor zero; otherwise, returns the evaluation of
_expr2_
if it is not null; otherwise, zero.
T}
_
_expr1_&nbsp;&&nbsp;_expr2_@T{
Returns the evaluation of
_expr1_
if neither expression evaluates to null or zero; otherwise, returns zero.
T}
_
@T{
Returns the result of a decimal integer comparison if both arguments
are integers; otherwise, returns the result of a string comparison
using the locale-specific collation sequence. The result of each
comparison is 1 if the specified relationship is true, or 0 if the
relationship is false.
T}
_expr1_&nbsp;=&nbsp;_expr2_@Equal.
_expr1_&nbsp;&gt;&nbsp;_expr2_@Greater than.
_expr1_&nbsp;&gt;=&nbsp;_expr2_@Greater than or equal.
_expr1_&nbsp;&lt;&nbsp;_expr2_@Less than.
_expr1_&nbsp;&lt;=&nbsp;_expr2_@Less than or equal.
_expr1_&nbsp;!=&nbsp;_expr2_@Not equal.
_
_expr1_&nbsp;+&nbsp;_expr2_@T{
Addition of decimal integer-valued arguments.
T}
_expr1_&nbsp;\(mi&nbsp;_expr2_@T{
Subtraction of decimal integer-valued arguments.
T}
_
_expr1_&nbsp;*&nbsp;_expr2_@T{
Multiplication of decimal integer-valued arguments.
T}
_expr1_&nbsp;/&nbsp;_expr2_@T{
Integer division of decimal integer-valued arguments, producing
an integer result.
T}
_expr1_&nbsp;%&nbsp;_expr2_@T{
Remainder of integer division of decimal integer-valued arguments.
T}
_
_expr1_&nbsp;:&nbsp;_expr2_@T{
Matching expression; see below.
T}
_
(&nbsp;_expr_&nbsp;)@T{
Grouping symbols. Any expression can be placed within parentheses.
Parentheses can be nested to a depth of
{EXPR_NEST_MAX}.
T}
_
_integer_@T{
An argument consisting only of an (optional) unary minus followed
by digits.
T}
_string_@T{
A string argument; see below.
T}
.TE

<a name="matching-expression"></a>

### Matching Expression


The
**':'**
matching operator shall compare the string resulting from the
evaluation of
_expr1_
with the regular expression pattern resulting from the evaluation of
_expr2_.
Regular expression syntax shall be that defined in the Base Definitions volume of POSIX.1-2008,
_Section 9.3_, _Basic Regular Expressions_,
except that all patterns are anchored to the beginning of the string (that
is, only sequences starting at the first character of a string are matched
by the regular expression) and, therefore, it is unspecified whether
**'^'**
is a special character in that context. Usually, the matching operator
shall return a string representing the number of characters matched (\c
**'0'**
on failure). Alternatively, if the pattern contains at least one
regular expression subexpression
**"[\e(...\e)]"**,
the string matched by the back-reference expression
**"\e1"**
shall be returned. If the back-reference expression
**"\e1"**
does not match, then the null string shall be returned.

<a name="string-operand"></a>

### String Operand


A string argument is an argument that cannot be identified as an
_integer_
argument or as one of the expression operator symbols shown in the
OPERANDS section.

The use of string arguments
**length**,
**substr**,
**index**,
or
**match**
produces unspecified results.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* \00  
  The
  _expression_
  evaluates to neither null nor zero.
* \01  
  The
  _expression_
  evaluates to null or zero.
* \02  
  Invalid
  _expression_.
* &gt;2  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

Default.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

After argument processing by the shell,
_expr_
is not required to be able to tell the difference between an operator
and an operand except by the value. If
**"$a"**
is
**'='**,
the command:

    
    expr $a = '='


looks like:

    
    expr = = =


as the arguments are passed to
_expr_
(and they all may be taken as the
**'='**
operator). The following works reliably:

    
    expr X$a = X=


Also note that this volume of POSIX.1-2008 permits implementations to extend utilities. The
_expr_
utility permits the integer arguments to be preceded with a unary
minus. This means that an integer argument could look like an option.
Therefore, the conforming application must employ the
**"\(mi\|\(mi"**
construct of Guideline 10 of the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_
to protect its operands if there is any chance the first operand might
be a negative integer (or any string with a leading minus).  

<a name="examples"></a>

# Examples

The
_expr_
utility has a rather difficult syntax:

*  *  
  Many of the operators are also shell control operators or reserved
  words, so they have to be escaped on the command line.
*  *  
  Each part of the expression is composed of separate arguments, so
  liberal usage of
  &lt;blank&gt;
  characters is required. For example:
  .TS
  center tab(@) box;
  cB | cB
  lf5 | lf5.
  Invalid@Valid
  _
  _expr_ 1+2@_expr_ 1 + 2
  _expr_ "1 + 2"@_expr_ 1 + 2
  _expr_ 1 + (2 * 3)@_expr_ 1 + \e( 2 \e* 3 \e)
  .TE

In many cases, the arithmetic and string features provided as part of
the shell command language are easier to use than their equivalents in
_expr_.
Newly written scripts should avoid
_expr_
in favor of the new features within the shell; see
_Section 2.5_, _Parameters and Variables_
and
_Section 2.6.4_, _Arithmetic Expansion_.

The following command:

    
    a=$(expr $a + 1)


adds 1 to the variable
_a_.

The following command, for
**"$a"**
equal to either
**/usr/abc/file**
or just
**file**:

    
    expr $a : '.*/e(.*e)' e| $a


returns the last segment of a pathname (that is,
**file**).
Applications should avoid the character
**'/'**
used alone as an argument;
_expr_
may interpret it as the division operator.

The following command:

    
    expr "//$a" : '.*/e(.*e)'


is a better representation of the previous example. The addition of
the
**"//"**
characters eliminates any ambiguity about the division operator and
simplifies the whole expression. Also note that pathnames may contain
characters contained in the
_IFS_
variable and should be quoted to avoid having
**"$a"**
expand into multiple arguments.

The following command:

    
    expr "$VAR" : '.*'


returns the number of characters in
_VAR_.

<a name="rationale"></a>

# Rationale

In an early proposal, EREs were used in the matching expression syntax.
This was changed to BREs to avoid breaking historical applications.

The use of a leading
&lt;circumflex&gt;
in the BRE is unspecified because many historical implementations have
treated it as a special character, despite their system documentation. For
example:

    
    expr foo : ^foo     expr ^foo : ^foo


return 3 and 0, respectively, on those systems; their documentation
would imply the reverse. Thus, the anchoring condition is left
unspecified to avoid breaking historical scripts relying on this
undocumented feature.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 2.5_, _Parameters and Variables_,
_Section 2.6.4_, _Arithmetic Expansion_

The Base Definitions volume of POSIX.1-2008,
_Chapter 8_, _Environment Variables_,
_Section 9.3_, _Basic Regular Expressions_,
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
