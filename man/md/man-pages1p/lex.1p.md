# lex(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

lex
— generate programs for lexical tasks (**DEVELOPMENT**)

<a name="synopsis"></a>

# Synopsis

```


```
    lex [(mit] [(min|(miv] [file...]

<a name="description"></a>

# Description

The
_lex_
utility shall generate C programs to be used in lexical processing of
character input, and that can be used as an interface to
_yacc_.
The C programs shall be generated from
_lex_
source code and conform to the ISO&nbsp;C standard, without depending on any undefined,
unspecified, or implementation-defined behavior, except in cases where
the code is copied directly from the supplied source, or in cases that
are documented by the implementation. Usually, the
_lex_
utility shall write the program it generates to the file
**lex.yy.c**;
the state of this file is unspecified if
_lex_
exits with a non-zero exit status. See the EXTENDED DESCRIPTION
section for a complete description of the
_lex_
input language.

<a name="options"></a>

# Options

The
_lex_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_,
except for Guideline 9.

The following options shall be supported:

* **\(min**  
  Suppress the summary of statistics usually written with the
  **\(miv**
  option. If no table sizes are specified in the
  _lex_
  source code and the
  **\(miv**
  option is not specified, then
  **\(min**
  is implied.
* **\(mit**  
  Write the resulting program to standard output instead of
  **lex.yy.c**.
* **\(miv**  
  Write a summary of
  _lex_
  statistics to the standard output. (See the discussion of
  _lex_
  table sizes in
  _Definitions in lex_.)
  If the
  **\(mit**
  option is specified and
  **\(min**
  is not specified, this report shall be written to standard error. If
  table sizes are specified in the
  _lex_
  source code, and if the
  **\(min**
  option is not specified, the
  **\(miv**
  option may be enabled.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of an input file. If more than one such
  _file_
  is specified, all files shall be concatenated to produce a single
  _lex_
  program. If no
  _file_
  operands are specified, or if a
  _file_
  operand is
  **'\(mi'**,
  the standard input shall be used.

<a name="stdin"></a>

# Stdin

The standard input shall be used if no
_file_
operands are specified, or if a
_file_
operand is
**'\(mi'**.
See INPUT FILES.

<a name="input-files"></a>

# Input Files

The input files shall be text files containing
_lex_
source code, as described in the EXTENDED DESCRIPTION section.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_lex_:

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
  and multi-character collating elements within regular expressions. If
  this variable is not set to the POSIX locale, the results are
  unspecified.
* _LC\_CTYPE_  
  Determine the locale for the interpretation of sequences of bytes of
  text data as characters (for example, single-byte as opposed to
  multi-byte characters in arguments and input files), and the behavior
  of character classes within regular expressions. If this variable is
  not set to the POSIX locale, the results are unspecified.
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

If the
**\(mit**
option is specified, the text file of C source code output of
_lex_
shall be written to standard output.

If the
**\(mit**
option is not specified:

*  *  
  Implementation-defined informational, error, and warning messages
  concerning the contents of
  _lex_
  source code input shall be written to either the standard output or
  standard error.
*  *  
  If the
  **\(miv**
  option is specified and the
  **\(min**
  option is not specified,
  _lex_
  statistics shall also be written to either the standard output or
  standard error, in an implementation-defined format. These
  statistics may also be generated if table sizes are specified with a
  **'%'**
  operator in the
  _Definitions_
  section, as long as the
  **\(min**
  option is not specified.

<a name="stderr"></a>

# Stderr

If the
**\(mit**
option is specified, implementation-defined informational, error, and
warning messages concerning the contents of
_lex_
source code input shall be written to the standard error.

If the
**\(mit**
option is not specified:

*  1.  
  Implementation-defined informational, error, and warning messages
  concerning the contents of
  _lex_
  source code input shall be written to either the standard output or
  standard error.
*  2.  
  If the
  **\(miv**
  option is specified and the
  **\(min**
  option is not specified,
  _lex_
  statistics shall also be written to either the standard output or
  standard error, in an implementation-defined format. These
  statistics may also be generated if table sizes are specified with a
  **'%'**
  operator in the
  _Definitions_
  section, as long as the
  **\(min**
  option is not specified.

<a name="output-files"></a>

# Output Files

A text file containing C source code shall be written to
**lex.yy.c**,
or to the standard output if the
**\(mit**
option is present.

<a name="extended-description"></a>

# Extended Description

Each input file shall contain
_lex_
source code, which is a table of regular expressions with corresponding
actions in the form of C program fragments.

When
**lex.yy.c**
is compiled and linked with the
_lex_
library (using the
**\(mil&nbsp;l**
operand with
_c99_),
the resulting program shall read character input from the standard
input and shall partition it into strings that match the given
expressions.  

When an expression is matched, these actions shall occur:

*  *  
  The input string that was matched shall be left in
  _yytext_
  as a null-terminated string;
  _yytext_
  shall either be an external character array or a pointer to a
  character string. As explained in
  _Definitions in lex_,
  the type can be explicitly selected using the
  **%array**
  or
  **%pointer**
  declarations, but the default is implementation-defined.
*  *  
  The external
  **int**
  _yyleng_
  shall be set to the length of the matching string.
*  *  
  The expression's corresponding program fragment, or action, shall be
  executed.

During pattern matching,
_lex_
shall search the set of patterns for the single longest possible
match. Among rules that match the same number of characters, the rule
given first shall be chosen.

The general format of
_lex_
source shall be:

_Definitions_
**%%**
_Rules_
**%%**
_User_Subroutines

The first
**"%%"**
is required to mark the beginning of the rules (regular expressions and
actions); the second
**"%%"**
is required only if user subroutines follow.

Any line in the
_Definitions_
section beginning with a
&lt;blank&gt;
shall be assumed to be a C program fragment and shall be copied to the
external definition area of the
**lex.yy.c**
file. Similarly, anything in the
_Definitions_
section included between delimiter lines containing only
**"%{"**
and
**"%}"**
shall also be copied unchanged to the external definition area of the
**lex.yy.c**
file.

Any such input (beginning with a
&lt;blank&gt;
or within
**"%{"**
and
**"%}"**
delimiter lines) appearing at the beginning of the
_Rules_
section before any rules are specified shall be written to
**lex.yy.c**
after the declarations of variables for the
_yylex_()
function and before the first line of code in
_yylex_().
Thus, user variables local to
_yylex_()
can be declared here, as well as application code to execute upon entry
to
_yylex_().

The action taken by
_lex_
when encountering any input beginning with a
&lt;blank&gt;
or within
**"%{"**
and
**"%}"**
delimiter lines appearing in the
_Rules_
section but coming after one or more rules is undefined. The presence
of such input may result in an erroneous definition of the
_yylex_()
function.

C-language code in the input shall not contain C-language trigraphs.
The C-language code within
**"%{"**
and
**"%}"**
delimiter lines shall not contain any lines consisting only of
**"%}"**,
or only of
**"%%"**.

<a name="definitions-in-lex"></a>

### Definitions in lex


_Definitions_
appear before the first
**"%%"**
delimiter. Any line in this section not contained between
**"%{"**
and
**"%}"**
lines and not beginning with a
&lt;blank&gt;
shall be assumed to define a
_lex_
substitution string. The format of these lines shall be:

    
    name substitute


If a
_name_
does not meet the requirements for identifiers in the ISO&nbsp;C standard, the result
is undefined. The string
_substitute_
shall replace the string {\c
_name_}
when it is used in a rule. The
_name_
string shall be recognized in this context only when the braces are
provided and when it does not appear within a bracket expression or
within double-quotes.

In the
_Definitions_
section, any line beginning with a
&lt;percent-sign&gt;
(\c
**'%'**)
character and followed by an alphanumeric word beginning with either
**'s'**
or
**'S'**
shall define a set of start conditions. Any line beginning with a
**'%'**
followed by a word beginning with either
**'x'**
or
**'X'**
shall define a set of exclusive start conditions. When the generated
scanner is in a
**%s**
state, patterns with no state specified shall be also active; in a
**%x**
state, such patterns shall not be active. The rest of the line, after
the first word, shall be considered to be one or more
&lt;blank&gt;-separated
names of start conditions. Start condition names shall be constructed
in the same way as definition names. Start conditions can be used to
restrict the matching of regular expressions to one or more states as
described in
_Regular Expressions in lex_.

Implementations shall accept either of the following two
mutually-exclusive declarations in the
_Definitions_
section:

* **%array**  
  Declare the type of
  _yytext_
  to be a null-terminated character array.
* **%pointer**  
  Declare the type of
  _yytext_
  to be a pointer to a null-terminated character string.

The default type of
_yytext_
is implementation-defined. If an application refers to
_yytext_
outside of the scanner source file (that is, via an
**extern**),
the application shall include the appropriate
**%array**
or
**%pointer**
declaration in the scanner source file.

Implementations shall accept declarations in the
_Definitions_
section for setting certain internal table sizes. The declarations are
shown in the following table.

.ce 1
**Table: Table Size Declarations in lex**
.TS
center tab(!) box;
cB | cB | cB
l | l | n.
Declaration!Description!Minimum Value
_
%**p n**!Number of positions!2\|500
%**n n**!Number of states!500
%**a n**!Number of transitions!2\|000
%**e n**!Number of parse tree nodes!1\|000
%**k n**!Number of packed character classes!1\|000
%**o n**!Size of the output array!3\|000
.TE

In the table,
_n_
represents a positive decimal integer, preceded by one or more
&lt;blank&gt;
characters. The exact meaning of these table size numbers is
implementation-defined. The implementation shall document how these
numbers affect the
_lex_
utility and how they are related to any output that may be generated by
the implementation should limitations be encountered during the
execution of
_lex_.
It shall be possible to determine from this output which of the table
size values needs to be modified to permit
_lex_
to successfully generate tables for the input language. The values in
the column Minimum Value represent the lowest values conforming
implementations shall provide.

<a name="rules-in-lex"></a>

### Rules in lex


The rules in
_lex_
source files are a table in which the left column contains regular
expressions and the right column contains actions (C program fragments)
to be executed when the expressions are recognized.

    
    ERE action
    ERE action
    ...


The extended regular expression (ERE) portion of a row shall be
separated from
_action_
by one or more
&lt;blank&gt;
characters. A regular expression containing
&lt;blank&gt;
characters shall be recognized under one of the following conditions:

*  *  
  The entire expression appears within double-quotes.
*  *  
  The
  &lt;blank&gt;
  characters appear within double-quotes or square brackets.
*  *  
  Each
  &lt;blank&gt;
  is preceded by a
  &lt;backslash&gt;
  character.

<a name="user-subroutines-in-lex"></a>

### User Subroutines in lex


Anything in the user subroutines section shall be copied to
**lex.yy.c**
following
_yylex_().

<a name="regular-expressions-in-lex"></a>

### Regular Expressions in lex


The
_lex_
utility shall support the set of extended regular expressions (see the Base Definitions volume of POSIX.1-2008,
_Section 9.4_, _Extended Regular Expressions_),
with the following additions and exceptions to the syntax:

* ""  
  Any string enclosed in double-quotes shall represent the characters
  within the double-quotes as themselves, except that
  &lt;backslash&gt;-escapes
  (which appear in the following table) shall be recognized. Any
  &lt;backslash&gt;-escape
  sequence shall be terminated by the closing quote. For example,
  **"\e01"**\c
  **"1"**
  represents a single string: the octal value 1 followed by the
  character
  **'1'**.
* &lt;_state_&gt;_r_,&nbsp;&lt;_state1,state2,_.\|.\|.&gt;_r_    
  The regular expression
  _r_
  shall be matched only when the program is in one of the start
  conditions indicated by
  _state_,
  _state1_,
  and so on; see
  _Actions in lex_.
  (As an exception to the typographical conventions of the rest of this volume of POSIX.1-2008,
  in this case &lt;_state_&gt; does not represent a metavariable, but the
  literal angle-bracket characters surrounding a symbol.) The start
  condition shall be recognized as such only at the beginning of a
  regular expression.
* _r_/_x_  
  The regular expression
  _r_
  shall be matched only if it is followed by an occurrence of regular
  expression
  _x_
  (\c
  _x_
  is the instance of trailing context, further defined below). The token
  returned in
  _yytext_
  shall only match
  _r_.
  If the trailing portion of
  _r_
  matches the beginning of
  _x_,
  the result is unspecified. The
  _r_
  expression cannot include further trailing context or the
  **'$'**
  (match-end-of-line) operator;
  _x_
  cannot include the
  **'^'**
  (match-beginning-of-line) operator, nor trailing context, nor the
  **'$'**
  operator. That is, only one occurrence of trailing context is allowed
  in a
  _lex_
  regular expression, and the
  **'^'**
  operator only can be used at the beginning of such an expression.
* {_name_}  
  When
  _name_
  is one of the substitution symbols from the
  _Definitions_
  section, the string, including the enclosing braces, shall be replaced
  by the
  _substitute_
  value. The
  _substitute_
  value shall be treated in the extended regular expression as if it were
  enclosed in parentheses. No substitution shall occur if {\c
  _name_}
  occurs within a bracket expression or within double-quotes.

Within an ERE, a
&lt;backslash&gt;
character shall be considered to begin an escape sequence as specified
in the table in the Base Definitions volume of POSIX.1-2008,
_Chapter 5_, _File Format Notation_
(\c
**'\e\e'**,
**'\ea'**,
**'\eb'**,
**'\ef'**,
**'\en'**,
**'\er'**,
**'\et'**,
**'\ev'**).
In addition, the escape sequences in the following table shall be
recognized.

A literal
&lt;newline&gt;
cannot occur within an ERE; the escape sequence
**'\en'**
can be used to represent a
&lt;newline&gt;.
A
&lt;newline&gt;
shall not be matched by a period operator.  

.ce 1
**Table: Escape Sequences in lex**
.TS
center tab(@) box;
cB | cB | cB
cB | cB | cB
lf5 | lw(2.4i) | lw(2.4i).
Escape
Sequence@Description@Meaning
_
\e_digits_@T{
A
&lt;backslash&gt;
character followed by the longest sequence of one, two, or three
octal-digit characters (01234567). If all of the digits are 0 (that is,
representation of the NUL character), the behavior is undefined.
T}@T{
The character whose encoding is represented by the one, two, or
three-digit octal integer. Multi-byte characters require
multiple, concatenated escape sequences of this type, including the
leading
&lt;backslash&gt;
for each byte.
T}
_
\ex_digits_@T{
A
&lt;backslash&gt;
character followed by the longest sequence of hexadecimal-digit
characters (01234567abcdefABCDEF). If all of the digits are 0 (that is,
representation of the NUL character), the behavior is undefined.
T}@T{
The character whose encoding is represented by the hexadecimal
integer.
T}
_
\ec@T{
A
&lt;backslash&gt;
character followed by any character not described in this
table or in the table in the Base Definitions volume of POSIX.1-2008,
_Chapter 5_, _File Format Notation_
(\c
**'\e\e'**,
**'\ea'**,
**'\eb'**,
**'\ef'**,
**'\en'**,
**'\er'**,
**'\et'**,
**'\ev'**).
T}@T{
The character
**'c'**,
unchanged.
T}
.TE

* **Note:**  
  If a
  **'\ex'**
  sequence needs to be immediately followed by a hexadecimal digit
  character, a sequence such as
  **"\ex1"**\c
  **"1"**
  can be used, which represents a character containing the value 1,
  followed by the character
  **'1'**.


The order of precedence given to extended regular expressions for
_lex_
differs from that specified in the Base Definitions volume of POSIX.1-2008,
_Section 9.4_, _Extended Regular Expressions_.
The order of precedence for
_lex_
shall be as shown in the following table, from high to low.

* **Note:**  
  The escaped characters entry is not meant to imply that these are
  operators, but they are included in the table to show their
  relationships to the true operators. The start condition, trailing
  context, and anchoring notations have been omitted from the table
  because of the placement restrictions described in this section; they
  can only appear at the beginning or ending of an ERE.
  

.ce 1
**Table: ERE Precedence in lex**
.TS
center tab(@) box;
cB | cB
lf2 | lf5.
Extended Regular Expression@Precedence
_
collation-related bracket symbols@[= =]  [: :]  [. .]
escaped characters@\e&lt;_special character_&gt;
bracket expression@[ ]
quoting@"..."
grouping@( )
definition@{_name_}
single-character RE duplication@* + ?
concatenation
interval expression@{m,n}
alternation@|
.TE

The ERE anchoring operators
**'^'**
and
**'$'**
do not appear in the table. With
_lex_
regular expressions, these operators are restricted in their use: the
**'^'**
operator can only be used at the beginning of an entire regular
expression, and the
**'$'**
operator only at the end. The operators apply to the entire regular
expression. Thus, for example, the pattern
**"(^abc)|(def$)"**
is undefined; it can instead be written as two separate rules, one with
the regular expression
**"^abc"**
and one with
**"def$"**,
which share a common action via the special
**'|'**
action (see below). If the pattern were written
**"^abc|def$"**,
it would match either
**"abc"**
or
**"def"**
on a line by itself.

Unlike the general ERE rules, embedded anchoring is not allowed by most
historical
_lex_
implementations. An example of embedded anchoring would be for
patterns such as
**"(^|&nbsp;)foo(&nbsp;|$)"**
to match
**"foo"**
when it exists as a complete word. This functionality can be obtained
using existing
_lex_
features:

    
    ^foo/[ en]      |
    " foo"/[ en]    /* Found foo as a separate word. */


Note also that
**'$'**
is a form of trailing context (it is equivalent to
**"/\en"**)
and as such cannot be used with regular expressions containing another
instance of the operator (see the preceding discussion of trailing
context).

The additional regular expressions trailing-context operator
**'/'**
can be used as an ordinary character if presented within double-quotes,
**"/"**;
preceded by a
&lt;backslash&gt;,
**"\e/"**;
or within a bracket expression,
**"[/]"**.
The start-condition
**'&lt;'**
and
**'&gt;'**
operators shall be special only in a start condition at the beginning
of a regular expression; elsewhere in the regular expression they shall
be treated as ordinary characters.

<a name="actions-in-lex"></a>

### Actions in lex


The action to be taken when an ERE is matched can be a C program
fragment or the special actions described below; the program fragment
can contain one or more C statements, and can also include special
actions. The empty C statement
**';'**
shall be a valid action; any string in the
**lex.yy.c**
input that matches the pattern portion of such a rule is effectively
ignored or skipped. However, the absence of an action shall not be
valid, and the action
_lex_
takes in such a condition is undefined.

The specification for an action, including C statements and special
actions, can extend across several lines if enclosed in braces:

    
    ERE <one or more blanks> { program statement
                               program statement }


The program statements shall not contain unbalanced curly brace
preprocessing tokens.

The default action when a string in the input to a
**lex.yy.c**
program is not matched by any expression shall be to copy the string to
the output. Because the default behavior of a program generated by
_lex_
is to read the input and copy it to the output, a minimal
_lex_
source program that has just
**"%%"**
shall generate a C program that simply copies the input to the output
unchanged.

Four special actions shall be available:

    
    |   ECHO;   REJECT;   BEGIN


* |  
  The action
  **'|'**
  means that the action for the next rule is the action for this rule.
  Unlike the other three actions,
  **'|'**
  cannot be enclosed in braces or be
  &lt;semicolon&gt;-terminated;
  the application shall ensure that it is specified alone, with no other
  actions.
* **ECHO;**  
  Write the contents of the string
  _yytext_
  on the output.
* **REJECT;**  
  Usually only a single expression is matched by a given string in the
  input.
  **REJECT**
  means \`\`continue to the next expression that matches the current
  input'', and shall cause whatever rule was the second choice after the
  current rule to be executed for the same input. Thus, multiple rules
  can be matched and executed for one input string or overlapping input
  strings. For example, given the regular expressions
  **"xyz"**
  and
  **"xy"**
  and the input
  **"xyz"**,
  usually only the regular expression
  **"xyz"**
  would match. The next attempted match would start after
  **z.**
  If the last action in the
  **"xyz"**
  rule is
  **REJECT**,
  both this rule and the
  **"xy"**
  rule would be executed. The
  **REJECT**
  action may be implemented in such a fashion that flow of control does
  not continue after it, as if it were equivalent to a
  **goto**
  to another part of
  _yylex_().
  The use of
  **REJECT**
  may result in somewhat larger and slower scanners.
* **BEGIN**  
  The action:

    
    BEGIN newstate;


switches the state (start condition) to
_newstate_.
If the string
_newstate_
has not been declared previously as a start condition in the
_Definitions_
section, the results are unspecified. The initial state is indicated
by the digit
**'0'**
or the token
**INITIAL**.

The functions or macros described below are accessible to user code
included in the
_lex_
input. It is unspecified whether they appear in the C code output of
_lex_,
or are accessible only through the
**\(mil&nbsp;l**
operand to
_c99_
(the
_lex_
library).

* **int&nbsp;yylex**(**void**)    
  Performs lexical analysis on the input; this is the primary function
  generated by the
  _lex_
  utility. The function shall return zero when the end of input is
  reached; otherwise, it shall return non-zero values (tokens) determined
  by the actions that are selected.
* **int&nbsp;yymore**(**void**)    
  When called, indicates that when the next input string is recognized,
  it is to be appended to the current value of
  _yytext_
  rather than replacing it; the value in
  _yyleng_
  shall be adjusted accordingly.
* **int&nbsp;yyless**(**int&nbsp;n**)    
  Retains
  _n_
  initial characters in
  _yytext_,
  NUL-terminated, and treats the remaining characters as if they had not
  been read; the value in
  _yyleng_
  shall be adjusted accordingly.
* **int&nbsp;input**(**void**)    
  Returns the next character from the input, or zero on end-of-file. It
  shall obtain input from the stream pointer
  _yyin_,
  although possibly via an intermediate buffer. Thus, once scanning has
  begun, the effect of altering the value of
  _yyin_
  is undefined. The character read shall be removed from the input
  stream of the scanner without any processing by the scanner.
* **int&nbsp;unput**(**int&nbsp;c**)    
  Returns the character
  **'c'**
  to the input;
  _yytext_
  and
  _yyleng_
  are undefined until the next expression is matched. The result of
  using
  _unput_()
  for more characters than have been input is unspecified.

The following functions shall appear only in the
_lex_
library accessible through the
**\(mil&nbsp;l**
operand; they can therefore be redefined by a conforming application:

* **int&nbsp;yywrap**(**void**)    
  Called by
  _yylex_()
  at end-of-file; the default
  _yywrap_()
  shall always return 1. If the application requires
  _yylex_()
  to continue processing with another source of input, then the
  application can include a function
  _yywrap_(),
  which associates another file with the external variable
  **FILE ***
  _yyin_
  and shall return a value of zero.
* **int&nbsp;main**(**int&nbsp;argc**, **char *argv**[\|])    
  Calls
  _yylex_()
  to perform lexical analysis, then exits. The user code can contain
  _main_()
  to perform application-specific operations, calling
  _yylex_()
  as applicable.

Except for
_input_(),
_unput_(),
and
_main_(),
all external and static names generated by
_lex_
shall begin with the prefix
**yy**
or
**YY**.

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

Conforming applications are warned that in the
_Rules_
section, an ERE without an action is not acceptable, but need not be
detected as erroneous by
_lex_.
This may result in compilation or runtime errors.

The purpose of
_input_()
is to take characters off the input stream and discard them as far as
the lexical analysis is concerned. A common use is to discard the body
of a comment once the beginning of a comment is recognized.

The
_lex_
utility is not fully internationalized in its treatment of regular
expressions in the
_lex_
source code or generated lexical analyzer. It would seem desirable to
have the lexical analyzer interpret the regular expressions given in
the
_lex_
source according to the environment specified when the lexical analyzer
is executed, but this is not possible with the current
_lex_
technology. Furthermore, the very nature of the lexical analyzers
produced by
_lex_
must be closely tied to the lexical requirements of the input language
being described, which is frequently locale-specific anyway. (For
example, writing an analyzer that is used for French text is not
automatically useful for processing other languages.)

<a name="examples"></a>

# Examples

The following is an example of a
_lex_
program that implements a rudimentary scanner for a Pascal-like
syntax:

    
    %{
    /* Need this for the call to atof() below. */
    #include <math.h>
    /* Need this for printf(), fopen(), and stdin below. */
    #include <stdio.h>
    %}
    
    DIGIT    [0(mi9]
    ID       [a(miz][a(miz0(mi9]*
    
    %%
    
    {DIGIT}+ {
        printf("An integer: %s (%d)en", yytext,
            atoi(yytext));
        }
    
    {DIGIT}+"."{DIGIT}*        {
        printf("A float: %s (%g)en", yytext,
            atof(yytext));
        }
    
    if|then|begin|end|procedure|function        {
        printf("A keyword: %sen", yytext);
        }
    
    {ID}    printf("An identifier: %sen", yytext);
    
    "+"|"(mi"|"*"|"/"        printf("An operator: %sen", yytext);
    
    "{"[^}en]*"}"    /* Eat up one-line comments. */
    
    [ eten]+        /* Eat up white space. */
    
    .  printf("Unrecognized character: %sen", yytext);
    
    %%
    
    int main(int argc, char *argv[])
    {
        ++argv, (mi|(miargc;  /* Skip over program name. */
        if (argc > 0)
            yyin = fopen(argv[0], "r");
        else
            yyin = stdin;
    
        yylex();
    }


<a name="rationale"></a>

# Rationale

Even though the
**\(mic**
option and references to the C language are retained in this
description,
_lex_
may be generalized to other languages, as was done at one time for EFL,
the Extended FORTRAN Language. Since the
_lex_
input specification is essentially language-independent, versions of
this utility could be written to produce Ada, Modula-2, or Pascal code,
and there are known historical implementations that do so.

The current description of
_lex_
bypasses the issue of dealing with internationalized EREs in the
_lex_
source code or generated lexical analyzer. If it follows the model used
by
_awk_
(the source code is assumed to be presented in the POSIX locale, but
input and output are in the locale specified by the environment
variables), then the tables in the lexical analyzer produced by
_lex_
would interpret EREs specified in the
_lex_
source in terms of the environment variables specified when
_lex_
was executed. The desired effect would be to have the lexical analyzer
interpret the EREs given in the
_lex_
source according to the environment specified when the lexical analyzer
is executed, but this is not possible with the current
_lex_
technology.

The description of octal and hexadecimal-digit escape sequences agrees
with the ISO&nbsp;C standard use of escape sequences.

Earlier versions of this standard allowed for implementations with
bytes other than eight bits, but this has been modified in this
version.

There is no detailed output format specification. The observed behavior
of
_lex_
under four different historical implementations was that none of these
implementations consistently reported the line numbers for error and
warning messages. Furthermore, there was a desire that
_lex_
be allowed to output additional diagnostic messages. Leaving message
formats unspecified avoids these formatting questions and problems with
internationalization.

Although the
**%x**
specifier for
_exclusive_
start conditions is not historical practice, it is believed to be a
minor change to historical implementations and greatly enhances the
usability of
_lex_
programs since it permits an application to obtain the expected
functionality with fewer statements.

The
**%array**
and
**%pointer**
declarations were added as a compromise between historical systems.
The System V-based
_lex_
copies the matched text to a
_yytext_
array. The
_flex_
program, supported in BSD and GNU systems, uses a pointer. In the
latter case, significant performance improvements are available for
some scanners. Most historical programs should require no change in
porting from one system to another because the string being referenced
is null-terminated in both cases. (The method used by
_flex_
in its case is to null-terminate the token in place by remembering the
character that used to come right after the token and replacing it
before continuing on to the next scan.) Multi-file programs with
external references to
_yytext_
outside the scanner source file should continue to operate on their
historical systems, but would require one of the new declarations to be
considered strictly portable.

The description of EREs avoids unnecessary duplication of ERE details
because their meanings within a
_lex_
ERE are the same as that for the ERE in this volume of POSIX.1-2008.

The reason for the undefined condition associated with text beginning
with a
&lt;blank&gt;
or within
**"%{"**
and
**"%}"**
delimiter lines appearing in the
_Rules_
section is historical practice. Both the BSD and System V
_lex_
copy the indented (or enclosed) input in the
_Rules_
section (except at the beginning) to unreachable areas of the
_yylex_()
function (the code is written directly after a
_break_
statement). In some cases, the System V
_lex_
generates an error message or a syntax error, depending on the form of
indented input.

The intention in breaking the list of functions into those that may
appear in
**lex.yy.c**
_versus_ those that only appear in
**libl.a**
is that only those functions in
**libl.a**
can be reliably redefined by a conforming application.

The descriptions of standard output and standard error are somewhat
complicated because historical
_lex_
implementations chose to issue diagnostic messages to standard output
(unless
**\(mit**
was given). POSIX.1-2008 allows this behavior, but leaves an opening
for the more expected behavior of using standard error for diagnostics.
Also, the System V behavior of writing the statistics when any table
sizes are given is allowed, while BSD-derived systems can avoid it. The
programmer can always precisely obtain the desired results by using
either the
**\(mit**
or
**\(min**
options.

The OPERANDS section does not mention the use of
**\(mi**
as a synonym for standard input; not all historical implementations
support such usage for any of the
_file_
operands.

A description of the
_translation table_
was deleted from early proposals because of its relatively low usage in
historical applications.

The change to the definition of the
_input_()
function that allows buffering of input presents the opportunity for
major performance gains in some applications.

The following examples clarify the differences between
_lex_
regular expressions and regular expressions appearing elsewhere in
this volume of POSIX.1-2008. For regular expressions of the form
**"r/x"**,
the string matching
_r_
is always returned; confusion may arise when the beginning of
_x_
matches the trailing portion of
_r_.
For example, given the regular expression
**"a*b/cc"**
and the input
**"aaabcc"**,
_yytext_
would contain the string
**"aaab"**
on this match. But given the regular expression
**"x*/xy"**
and the input
**"xxxy"**,
the token
**xxx**,
not
**xx**,
is returned by some implementations because
**xxx**
matches
**"x*"**.

In the rule
**"ab*/bc"**,
the
**"b*"**
at the end of
_r_
extends
_r_'s
match into the beginning of the trailing context, so the result is
unspecified. If this rule were
**"ab/bc"**,
however, the rule matches the text
**"ab"**
when it is followed by the text
**"bc"**.
In this latter case, the matching of
_r_
cannot extend into the beginning of
_x_,
so the result is specified.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

__c99_\^_,
__ed_\^_,
__yacc_\^_

The Base Definitions volume of POSIX.1-2008,
_Chapter 5_, _File Format Notation_,
_Chapter 8_, _Environment Variables_,
_Chapter 9_, _Regular Expressions_,
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
