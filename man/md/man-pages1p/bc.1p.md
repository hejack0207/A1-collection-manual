# bc(1P)

IEEE/The Open Group, 2013


<a name="prolog"></a>

# Prolog

This manual page is part of the POSIX Programmer's Manual.
The Linux implementation of this interface may differ (consult
the corresponding Linux manual page for details of Linux behavior),
or the interface may not be implemented on Linux.


<a name="name"></a>

# Name

bc
— arbitrary-precision arithmetic language

<a name="synopsis"></a>

# Synopsis

```


```
    bc [(mil] [file...]

<a name="description"></a>

# Description

The
_bc_
utility shall implement an arbitrary precision calculator. It shall
take input from any files given, then read from the standard input. If
the standard input and standard output to
_bc_
are attached to a terminal, the invocation of
_bc_
shall be considered to be
_interactive_,
causing behavioral constraints described in the following sections.

<a name="options"></a>

# Options

The
_bc_
utility shall conform to the Base Definitions volume of POSIX.1-2008,
_Section 12.2_, _Utility Syntax Guidelines_.

The following option shall be supported:

* **\(mil**  
  (The letter ell.) Define the math functions and initialize
  _scale_
  to 20, instead of the default zero; see the EXTENDED DESCRIPTION
  section.

<a name="operands"></a>

# Operands

The following operand shall be supported:

* _file_  
  A pathname of a text file containing
  _bc_
  program statements. After all
  _file_s
  have been read,
  _bc_
  shall read the standard input.

<a name="stdin"></a>

# Stdin

See the INPUT FILES section.

<a name="input-files"></a>

# Input Files

Input files shall be text files containing a sequence of comments,
statements, and function definitions that shall be executed as they are
read.

<a name="environment-variables"></a>

# Environment Variables

The following environment variables shall affect the execution of
_bc_:

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

<a name="asynchronous-events"></a>

# Asynchronous Events

Default.

<a name="stdout"></a>

# Stdout

The output of the
_bc_
utility shall be controlled by the program read, and consist of zero or
more lines containing the value of all executed expressions without
assignments. The radix and precision of the output shall be controlled
by the values of the
**obase**
and
**scale**
variables; see the EXTENDED DESCRIPTION section.

<a name="stderr"></a>

# Stderr

The standard error shall be used only for diagnostic messages.

<a name="output-files"></a>

# Output Files

None.

<a name="extended-description"></a>

# Extended Description


<a name="grammar"></a>

### Grammar


The grammar in this section and the lexical conventions in the
following section shall together describe the syntax for
_bc_
programs. The general conventions for this style of grammar are
described in
_Section 1.3_, _Grammar Conventions_.
A valid program can be represented as the non-terminal symbol
**program**
in the grammar. This formal syntax shall take precedence over the
text syntax description.

    
    %token    EOF NEWLINE STRING LETTER NUMBER
    
    %token    MUL_OP
    /*        '*', '/', '%'                           */
    
    %token    ASSIGN_OP
    /*        '=', '+=', '(mi=', '*=', '/=', '%=', '^=' */
    
    %token    REL_OP
    /*        '==', '<=', '>=', '!=', '<', '>'        */
    
    %token    INCR_DECR
    /*        '++', '(mi|(mi'                              */
    
    %token    Define    Break    Quit    Length
    /*        'define', 'break', 'quit', 'length'     */
    
    %token    Return    For    If    While    Sqrt
    /*        'return', 'for', 'if', 'while', 'sqrt'  */
    
    %token    Scale    Ibase    Obase    Auto
    /*        'scale', 'ibase', 'obase', 'auto'       */
    
    %start    program
    
    %%
    
    program              : EOF
                         | input_item program
                         ;
    
    input_item           : semicolon_list NEWLINE
                         | function
                         ;
    
    semicolon_list       : /* empty */
                         | statement
                         | semicolon_list ';' statement
                         | semicolon_list ';'
                         ;
    
    statement_list       : /* empty */
                         | statement
                         | statement_list NEWLINE
                         | statement_list NEWLINE statement
                         | statement_list ';'
                         | statement_list ';' statement
                         ;
    
    statement            : expression
                         | STRING
                         | Break
                         | Quit
                         | Return
                         | Return '(' return_expression ')'
                         | For '(' expression ';'
                               relational_expression ';'
                               expression ')' statement
                         | If '(' relational_expression ')' statement
                         | While '(' relational_expression ')' statement
                         | '{' statement_list '}'
                         ;
    
    function             : Define LETTER '(' opt_parameter_list ')'
                               '{' NEWLINE opt_auto_define_list
                               statement_list '}'
                         ;
    
    opt_parameter_list   : /* empty */
                         | parameter_list
                         ;
    
    parameter_list       : LETTER
                         | define_list ',' LETTER
                         ;
    
    opt_auto_define_list : /* empty */
                         | Auto define_list NEWLINE
                         | Auto define_list ';'
                         ;
    
    define_list          : LETTER
                         | LETTER '[' ']'
                         | define_list ',' LETTER
                         | define_list ',' LETTER '[' ']'
                         ;
    
    opt_argument_list    : /* empty */
                         | argument_list
                         ;
    
    argument_list        : expression
                         | LETTER '[' ']' ',' argument_list
                         ;
    
    relational_expression : expression
                         | expression REL_OP expression
                         ;
    
    return_expression    : /* empty */
                         | expression
                         ;
    
    expression           : named_expression
                         | NUMBER
                         | '(' expression ')'
                         | LETTER '(' opt_argument_list ')'
                         | '(mi' expression
                         | expression '+' expression
                         | expression '(mi' expression
                         | expression MUL_OP expression
                         | expression '^' expression
                         | INCR_DECR named_expression
                         | named_expression INCR_DECR
                         | named_expression ASSIGN_OP expression
                         | Length '(' expression ')'
                         | Sqrt '(' expression ')'
                         | Scale '(' expression ')'
                         ;
    
    named_expression     : LETTER
                         | LETTER '[' expression ']'
                         | Scale
                         | Ibase
                         | Obase
                         ;


<a name="lexical-conventions-in-bc"></a>

### Lexical Conventions in bc


The lexical conventions for
_bc_
programs, with respect to the preceding grammar, shall be as follows:

*  1.  
  Except as noted,
  _bc_
  shall recognize the longest possible token or delimiter beginning at a
  given point.
*  2.  
  A comment shall consist of any characters beginning with the two adjacent
  characters
  **"/*"**
  and terminated by the next occurrence of the two adjacent characters
  **"*/"**.
  Comments shall have no effect except to delimit lexical tokens.
*  3.  
  The
  &lt;newline&gt;
  shall be recognized as the token
  **NEWLINE**.
*  4.  
  The token
  **STRING**
  shall represent a string constant; it shall consist of any characters
  beginning with the double-quote character (\c
  **'"'**)
  and terminated by another occurrence of the double-quote character. The
  value of the string is the sequence of all characters between, but not
  including, the two double-quote characters. All characters shall be
  taken literally from the input, and there is no way to specify a string
  containing a double-quote character. The length of the value of each
  string shall be limited to
  {BC_STRING_MAX}
  bytes.
*  5.  
  A
  &lt;blank&gt;
  shall have no effect except as an ordinary character if it appears
  within a
  **STRING**
  token, or to delimit a lexical token other than
  **STRING**.
*  6.  
  The combination of a
  &lt;backslash&gt;
  character immediately followed by a
  &lt;newline&gt;
  shall have no effect other than to delimit lexical tokens with the
  following exceptions:
    *  *  
      It shall be interpreted as the character sequence
      **"\e&lt;newline&gt;"**
      in
      **STRING**
      tokens.
    *  *  
      It shall be ignored as part of a multi-line
      **NUMBER**
      token.
*  7.  
  The token
  **NUMBER**
  shall represent a numeric constant. It shall be recognized by the
  following grammar:

    
    NUMBER  : integer
            | '.' integer
            | integer '.'
            | integer '.' integer
            ;
    
    integer : digit
            | integer digit
            ;
    
    digit   : 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7
            | 8 | 9 | A | B | C | D | E | F
            ;


*  8.  
  The value of a
  **NUMBER**
  token shall be interpreted as a numeral in the base specified by the
  value of the internal register
  **ibase**
  (described below). Each of the
  **digit**
  characters shall have the value from 0 to 15 in the order listed here,
  and the
  &lt;period&gt;
  character shall represent the radix point. The behavior is undefined if
  digits greater than or equal to the value of
  **ibase**
  appear in the token. However, note the exception for single-digit
  values being assigned to
  **ibase**
  and
  **obase**
  themselves, in
  _Operations in bc_.
*  9.  
  The following keywords shall be recognized as tokens:
  .TS
  tab(@);
  lBw(0.6i)e lBe lBe lBe lBe.
  T{
    auto
    break
    define
    T}@T{
    .nf
    ibase
    if
    for
    T}@T{
    .nf
    length
    obase
    quit
    T}@T{
    .nf
    return
    scale
    sqrt
    T}@T{
    .nf
    while
  T}
  .TE
* 10.  
  Any of the following characters occurring anywhere except within a
  keyword shall be recognized as the token
  **LETTER**:

    
    a b c d e f g h i j k l m n o p q r s t u v w x y z


* 11.  
  The following single-character and two-character sequences shall be
  recognized as the token
  **ASSIGN_OP**:

    
    =   +=   (mi=   *=   /=   %=   ^=


* 12.  
  If an
  **'='**
  character, as the beginning of a token, is followed by a
  **'\(mi'**
  character with no intervening delimiter, the behavior is undefined.
* 13.  
  The following single-characters shall be recognized as the token
  **MUL_OP**:

    
    *   /   %


* 14.  
  The following single-character and two-character sequences shall be
  recognized as the token
  **REL_OP**:

    
    ==   <=   >=   !=   <   >


* 15.  
  The following two-character sequences shall be recognized as the token
  **INCR_DECR**:

    
    ++   (mi|(mi


* 16.  
  The following single characters shall be recognized as tokens whose
  names are the character:

    
    <newline>  (  )  ,  +  (mi  ;  [  ]  ^  {  }


* 17.  
  The token
  **EOF**
  is returned when the end of input is reached.

<a name="operations-in-bc"></a>

### Operations in bc


There are three kinds of identifiers: ordinary identifiers, array
identifiers, and function identifiers.
All three types consist of single lowercase letters. Array identifiers
shall be followed by square brackets (\c
**"[]"**).
An array subscript is required except in an argument or auto list.
Arrays are singly dimensioned and can contain up to
{BC_DIM_MAX}
elements. Indexing shall begin at zero so an array is indexed from 0 to
{BC_DIM_MAX}\(mi1.
Subscripts shall be truncated to integers. The application shall ensure
that function identifiers are followed by parentheses, possibly
enclosing arguments. The three types of identifiers do not conflict.

The following table summarizes the rules for precedence and
associativity of all operators. Operators on the same line shall have
the same precedence; rows are in order of decreasing precedence.

.ce 1
**Table: Operators in bc**
.TS
center tab(@) box;
cB | cB
lf5 | l.
Operator@Associativity
_
++, \(mi\|\(mi@N/A
unary \(mi@N/A
^@Right to left
*, /, %@Left to right
+, binary \(mi@Left to right
=, +=, \(mi=, *=, /=, %=, ^=@Right to left
==, &lt;=, &gt;=, !=, &lt;, &gt;@None
.TE

Each expression or named expression has a
_scale_,
which is the number of decimal digits that shall be maintained as the
fractional portion of the expression.

_Named expressions_
are places where values are stored. Named expressions shall be valid on
the left side of an assignment. The value of a named expression shall
be the value stored in the place named. Simple identifiers and array
elements are named expressions; they have an initial value of zero and
an initial scale of zero.

The internal registers
**scale**,
**ibase**,
and
**obase**
are all named expressions. The scale of an expression consisting of the
name of one of these registers shall be zero; values assigned to any of
these registers are truncated to integers. The
**scale**
register shall contain a global value used in computing the scale of
expressions (as described below). The value of the register
**scale**
is limited to 0 \(&lt;=
**scale**
\(&lt;=
{BC_SCALE_MAX}
and shall have a default value of zero. The
**ibase**
and
**obase**
registers are the input and output number radix, respectively. The
value of
**ibase**
shall be limited to:

    
    2 (<= ibase (<= 16


The value of
**obase**
shall be limited to:

    
    2 (<= obase (<= {BC_BASE_MAX}


When either
**ibase**
or
**obase**
is assigned a single
**digit**
value from the list in
_Lexical Conventions in bc_,
the value shall be assumed in hexadecimal. (For example,
**ibase**=A
sets to base ten, regardless of the current
**ibase**
value.) Otherwise, the behavior is undefined when digits greater than
or equal to the value of
**ibase**
appear in the input. Both
**ibase**
and
**obase**
shall have initial values of 10.

Internal computations shall be conducted as if in decimal, regardless
of the input and output bases, to the specified number of decimal
digits. When an exact result is not achieved (for example,
**scale**=0;&nbsp;3.2/1)**,**
the result shall be truncated.

For all values of
**obase**
specified by this volume of POSIX.1-2008,
_bc_
shall output numeric values by performing each of the following steps
in order:

*  1.  
  If the value is less than zero, a
  &lt;hyphen&gt;
  (\c
  **'\(mi'**)
  character shall be output.
*  2.  
  One of the following is output, depending on the numerical value:
    *  *  
      If the absolute value of the numerical value is greater than or equal
      to one, the integer portion of the value shall be output as a series of
      digits appropriate to
      **obase**
      (as described below), most significant digit first. The most significant
      non-zero digit shall be output next, followed by each successively
      less significant digit.
    *  *  
      If the absolute value of the numerical value is less than one but
      greater than zero and the scale of the numerical value is greater than
      zero, it is unspecified whether the character 0 is output.
    *  *  
      If the numerical value is zero, the character 0 shall be output.
*  3.  
  If the scale of the value is greater than zero and the numeric value
  is not zero, a
  &lt;period&gt;
  character shall be output, followed by a series of digits appropriate to
  **obase**
  (as described below) representing the most significant portion of the
  fractional part of the value. If
  _s_
  represents the scale of the value being output, the number of digits
  output shall be
  _s_
  if
  **obase**
  is 10, less than or equal to
  _s_
  if
  **obase**
  is greater than 10, or greater than or equal to
  _s_
  if
  **obase**
  is less than 10. For
  **obase**
  values other than 10, this should be the number of digits needed to
  represent a precision of 10\u\s-3_s_\s+3\d.

For
**obase**
values from 2 to 16, valid digits are the first
**obase**
of the single characters:

    
    0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F


which represent the values zero to 15, inclusive, respectively.

For bases greater than 16, each digit shall be written as a separate
multi-digit decimal number. Each digit except the most significant
fractional digit shall be preceded by a single
&lt;space&gt;.
For bases from 17 to 100,
_bc_
shall write two-digit decimal numbers; for bases from 101 to 1\|000,
three-digit decimal strings, and so on. For example, the decimal number
1\|024 in base 25 would be written as:

    
     01 15 24


and in base 125, as:

    
     008 024


Very large numbers shall be split across lines with 70 characters per
line in the POSIX locale; other locales may split at different
character boundaries. Lines that are continued shall end with a
&lt;backslash&gt;.

A function call shall consist of a function name followed by
parentheses containing a
&lt;comma&gt;-separated
list of expressions, which are the function arguments. A whole array
passed as an argument shall be specified by the array name followed
by empty square brackets. All function arguments shall be passed by
value. As a result, changes made to the formal parameters shall have no
effect on the actual arguments. If the function terminates by executing a
**return**
statement, the value of the function shall be the value of the
expression in the parentheses of the
**return**
statement or shall be zero if no expression is provided or if there is
no
**return**
statement.

The result of
**sqrt**(\c
_expression_)
shall be the square root of the expression. The result shall be
truncated in the least significant decimal place. The scale of the
result shall be the scale of the expression or the value of
**scale**,
whichever is larger.

The result of
**length**(\c
_expression_)
shall be the total number of significant decimal digits in the
expression. The scale of the result shall be zero.

The result of
**scale**(\c
_expression_)
shall be the scale of the expression. The scale of the result shall be
zero.

A numeric constant shall be an expression. The scale shall be the
number of digits that follow the radix point in the input representing
the constant, or zero if no radix point appears.

The sequence (&nbsp;_expression_&nbsp;) shall be an expression with the
same value and scale as
_expression_.
The parentheses can be used to alter the normal precedence.

The semantics of the unary and binary operators are as follows:

* \(mi_expression_    
  The result shall be the negative of the
  _expression_.
  The scale of the result shall be the scale of
  _expression_.

The unary increment and decrement operators shall not modify the scale
of the named expression upon which they operate. The scale of the
result shall be the scale of that named expression.

* ++_named-expression_    
  The named expression shall be incremented by one. The result shall be
  the value of the named expression after incrementing.
* \(mi\|\(mi_named-expression_    
  The named expression shall be decremented by one. The result shall be
  the value of the named expression after decrementing.
* _named-expression_++    
  The named expression shall be incremented by one. The result shall be
  the value of the named expression before incrementing.
* _named-expression_\(mi\|\(mi    
  The named expression shall be decremented by one. The result shall be
  the value of the named expression before decrementing.

The exponentiation operator,
&lt;circumflex&gt;
(\c
**'^'**),
shall bind right to left.

* _expression_^_expression_    
  The result shall be the first
  _expression_
  raised to the power of the second
  _expression_.
  If the second expression is not an integer, the behavior is undefined.
  If
  _a_
  is the scale of the left expression and
  _b_
  is the absolute value of the right expression, the scale of the result
  shall be:

    
    if b >= 0 min(a * b, max(scale, a)) if b < 0 scale

The multiplicative operators (\c
**'*'**,
**'/'**,
**'%'**)
shall bind left to right.

* _expression_*_expression_    
  The result shall be the product of the two expressions. If
  _a_
  and
  _b_
  are the scales of the two expressions, then the scale of the result
  shall be:

    
    min(a+b,max(scale,a,b))


* _expression_/_expression_    
  The result shall be the quotient of the two expressions. The scale of the
  result shall be the value of
  **scale**.
* _expression_%_expression_    
  For expressions
  _a_
  and
  _b_,
  _a_%\c
  _b_
  shall be evaluated equivalent to the steps:
    *  1.  
      Compute
      _a_/\c
      _b_
      to current scale.
    *  2.  
      Use the result to compute:

    
    a (mi (a / b) * b


to scale:

    
    max(scale + scale(b), scale(a))

The scale of the result shall be:

    
    max(scale + scale(b), scale(a))


When
**scale**
is zero, the
**'%'**
operator is the mathematical remainder operator.

The additive operators (\c
**'\(pl'**,
**'\(mi'**)
shall bind left to right.

* _expression_+_expression_    
  The result shall be the sum of the two expressions. The scale of the
  result shall be the maximum of the scales of the expressions.
* _expression_\(mi_expression_    
  The result shall be the difference of the two expressions. The scale of
  the result shall be the maximum of the scales of the expressions.

The assignment operators (\c
**'='**,
**"+="**,
**"\(mi="**,
**"*="**,
**"/="**,
**"%="**,
**"^="**)
shall bind right to left.

* _named-expression_=_expression_    
  This expression shall result in assigning the value of the expression
  on the right to the named expression on the left. The scale of both the
  named expression and the result shall be the scale of
  _expression_.

The compound assignment forms:

    
    named-expression <operator>= expression


shall be equivalent to:

    
    named-expression=named-expression <operator> expression


except that the
_named-expression_
shall be evaluated only once.

Unlike all other operators, the relational operators (\c
**'&lt;'**,
**'&gt;'**,
**"&lt;="**,
**"&gt;="**,
**"=="**,
**"!="**)
shall be only valid as the object of an
**if**,
**while**,
or inside a
**for**
statement.

* _expression1_&lt;_expression2_    
  The relation shall be true if the value of
  _expression1_
  is strictly less than the value of
  _expression2_.
* _expression1_&gt;_expression2_    
  The relation shall be true if the value of
  _expression1_
  is strictly greater than the value of
  _expression2_.
* _expression1_&lt;=_expression2_    
  The relation shall be true if the value of
  _expression1_
  is less than or equal to the value of
  _expression2_.
* _expression1_&gt;=_expression2_    
  The relation shall be true if the value of
  _expression1_
  is greater than or equal to the value of
  _expression2_.
* _expression1_=\|=_expression2_    
  The relation shall be true if the values of
  _expression1_
  and
  _expression2_
  are equal.
* _expression1_!=_expression2_    
  The relation shall be true if the values of
  _expression1_
  and
  _expression2_
  are unequal.

There are only two storage classes in
_bc_:
global and automatic (local).
Only identifiers that are local to a function need be declared
with the
**auto**
command. The arguments to a function shall be local to the function.
All other identifiers are assumed to be global and available to all
functions. All identifiers, global and local, have initial values of
zero. Identifiers declared as auto shall be allocated on entry to the
function and released on returning from the function. They therefore do
not retain values between function calls. Auto arrays shall be
specified by the array name followed by empty square brackets. On entry
to a function, the old values of the names that appear as parameters
and as automatic variables shall be pushed onto a stack. Until the
function returns, reference to these names shall refer only to the new
values.

References to any of these names from other functions that are called
from this function also refer to the new value until one of those
functions uses the same name for a local variable.

When a statement is an expression, unless the main operator is an
assignment, execution of the statement shall write the value of the
expression followed by a
&lt;newline&gt;.

When a statement is a string, execution of the statement shall write
the value of the string.

Statements separated by
&lt;semicolon&gt;
or
&lt;newline&gt;
characters shall be executed sequentially. In an interactive invocation of
_bc_,
each time a
&lt;newline&gt;
is read that satisfies the grammatical production:

    
    input_item : semicolon_list NEWLINE


the sequential list of statements making up the
**semicolon_list**
shall be executed immediately and any output produced by that execution
shall be written without any delay due to buffering.

In an
**if**
statement (\c
**if**(\c
_relation_)
_statement_),
the
_statement_
shall be executed if the relation is true.

The
**while**
statement (\c
**while**(\c
_relation_)
_statement_)
implements a loop in which the
_relation_
is tested; each time the
_relation_
is true, the
_statement_
shall be executed and the
_relation_
retested. When the
_relation_
is false, execution shall resume after
_statement_.

A
**for**
statement(\c
**for**(\c
_expression_;
_relation_;
_expression_)
_statement_)
shall be the same as:

    
    first-expression
    while (relation) {
        statement
        last-expression
    }

The application shall ensure that all three expressions are present.

The
**break**
statement shall cause termination of a
**for**
or
**while**
statement.

The
**auto**
statement (\c
**auto**
_identifier_
**[**,\c
_identifier_\c
**]**
.\|.\|.) shall cause the values of the identifiers to be pushed down.
The identifiers can be ordinary identifiers or array identifiers. Array
identifiers shall be specified by following the array name by empty
square brackets. The application shall ensure that the
**auto**
statement is the first statement in a function definition.

A
**define**
statement:

    
    define LETTER ( opt_parameter_list ) {
        opt_auto_define_list
        statement_list
    }


defines a function named
**LETTER**.
If a function named
**LETTER**
was previously defined, the
**define**
statement shall replace the previous definition. The expression:

    
    LETTER ( opt_argument_list )


shall invoke the function named
**LETTER**.
The behavior is undefined if the number of arguments in the invocation
does not match the number of parameters in the definition. Functions
shall be defined before they are invoked. A function shall be
considered to be defined within its own body, so recursive calls are
valid. The values of numeric constants within a function shall be
interpreted in the base specified by the value of the
**ibase**
register when the function is invoked.

The
**return**
statements (\c
**return**
and
**return**(\c
_expression_))
shall cause termination of a function, popping of its auto variables,
and specification of the result of the function. The first form shall
be equivalent to
**return**(0).
The value and scale of the result returned by the function shall be the
value and scale of the expression returned.

The
**quit**
statement (\c
**quit**)
shall stop execution of a
_bc_
program at the point where the statement occurs in the input, even if
it occurs in a function definition, or in an
**if**,
**for**,
or
**while**
statement.

The following functions shall be defined when the
**\(mil**
option is specified:

* **s**(&nbsp;_expression_&nbsp;)    
  Sine of argument in radians.
* **c**(&nbsp;_expression_&nbsp;)    
  Cosine of argument in radians.
* **a**(&nbsp;_expression_&nbsp;)    
  Arctangent of argument.
* **l**(&nbsp;_expression_&nbsp;)    
  Natural logarithm of argument.
* **e**(&nbsp;_expression_&nbsp;)    
  Exponential function of argument.
* **j**(&nbsp;_expression_,&nbsp;_expression_&nbsp;)    
  Bessel function of integer order.

The scale of the result returned by these functions shall be the value
of the
**scale**
register at the time the function is invoked. The value of the
**scale**
register after these functions have completed their execution shall be
the same value it had upon invocation. The behavior is undefined if
any of these functions is invoked with an argument outside the domain
of the mathematical function.

<a name="exit-status"></a>

# Exit Status

The following exit values shall be returned:

* 0  
  All input files were processed successfully.
* _unspecified_  
  An error occurred.

<a name="consequences-of-errors"></a>

# Consequences of Errors

If any
_file_
operand is specified and the named file cannot be accessed,
_bc_
shall write a diagnostic message to standard error and terminate
without any further action.

In an interactive invocation of
_bc_,
the utility should print an error message and recover following any
error in the input. In a non-interactive invocation of
_bc_,
invalid input causes undefined behavior.

_The following sections are informative._

<a name="application-usage"></a>

# Application Usage

Automatic variables in
_bc_
do not work in exactly the same way as in either C or PL/1.

For historical reasons, the exit status from
_bc_
cannot be relied upon to indicate that an error has occurred.
Returning zero after an error is possible. Therefore,
_bc_
should be used primarily by interactive users (who can react to error
messages) or by application programs that can somehow validate the
answers returned as not including error messages.

The
_bc_
utility always uses the
&lt;period&gt;
(\c
**'.'**)
character to represent a radix point, regardless of any decimal-point
character specified as part of the current locale. In languages like C or
_awk_,
the
&lt;period&gt;
character is used in program source, so it can be portable and
unambiguous, while the locale-specific character is used in input and
output. Because there is no distinction between source and input in
_bc_,
this arrangement would not be possible. Using the locale-specific
character in
_bc_'s
input would introduce ambiguities into the language; consider the
following example in a locale with a
&lt;comma&gt;
as the decimal-point character:

    
    define f(a,b) {
        ...
    }
    ...
    
    f(1,2,3)


Because of such ambiguities, the
&lt;period&gt;
character is used in input. Having input follow different conventions
from output would be confusing in either pipeline usage or interactive
usage, so the
&lt;period&gt;
is also used in output.

<a name="examples"></a>

# Examples

In the shell, the following assigns an approximation of the first ten
digits of
**'\(*p'**
to the variable
_x_:

    
    x=$(printf "%sen" 'scale = 10; 104348/33215' | bc)


The following
_bc_
program prints the same approximation of
**'\(*p'**,
with a label, to standard output:

    
    scale = 10
    "pi equals "
    104348 / 33215


The following defines a function to compute an approximate value of the
exponential function (note that such a function is predefined if the
**\(mil**
option is specified):

    
    scale = 20
    define e(x){
        auto a, b, c, i, s
        a = 1
        b = 1
        s = 1
        for (i = 1; 1 == 1; i++){
            a = a*x
            b = b*i
            c = a/b
            if (c == 0) {
                 return(s)
            }
            s = s+c
        }
    }


The following prints approximate values of the exponential function of
the first ten integers:

    
    for (i = 1; i <= 10; ++i) {
        e(i)
    }


<a name="rationale"></a>

# Rationale

The
_bc_
utility is implemented historically as a front-end processor for
_dc_;
_dc_
was not selected to be part of this volume of POSIX.1-2008 because
_bc_
was thought to have a more intuitive programmatic interface. Current
implementations that implement
_bc_
using
_dc_
are expected to be compliant.

The exit status for error conditions has been left unspecified for
several reasons:

*  *  
  The
  _bc_
  utility is used in both interactive and non-interactive situations.
  Different exit codes may be appropriate for the two uses.
*  *  
  It is unclear when a non-zero exit should be given; divide-by-zero,
  undefined functions, and syntax errors are all possibilities.
*  *  
  It is not clear what utility the exit status has.
*  *  
  In the 4.3 BSD, System V, and Ninth Edition implementations,
  _bc_
  works in conjunction with
  _dc_.
  The
  _dc_
  utility is the parent,
  _bc_
  is the child. This was done to cleanly terminate
  _bc_
  if
  _dc_
  aborted.

The decision to have
_bc_
exit upon encountering an inaccessible input file is based on the
belief that
_bc_
_file1_
_file2_
is used most often when at least
_file1_
contains data/function declarations/initializations. Having
_bc_
continue with prerequisite files missing is probably not useful. There
is no implication in the CONSEQUENCES OF ERRORS section that
_bc_
must check all its files for accessibility before opening any of them.

There was considerable debate on the appropriateness of the language
accepted by
_bc_.
Several reviewers preferred to see either a pure subset of the C
language or some changes to make the language more compatible with C.
While the
_bc_
language has some obvious similarities to C, it has never claimed to be
compatible with any version of C. An interpreter for a subset of C
might be a very worthwhile utility, and it could potentially make
_bc_
obsolete. However, no such utility is known in historical practice, and
it was not within the scope of this volume of POSIX.1-2008 to define such a language and
utility. If and when they are defined, it may be appropriate to include
them in a future version of this standard. This left the following
alternatives:

*  1.  
  Exclude any calculator language from this volume of POSIX.1-2008.

The consensus of the standard developers was that a simple programmatic
calculator language is very useful for both applications and
interactive users. The only arguments for excluding any calculator were
that it would become obsolete if and when a C-compatible one emerged,
or that the absence would encourage the development of such a
C-compatible one. These arguments did not sufficiently address the
needs of current application developers.

*  2.  
  Standardize the historical
  _dc_,
  possibly with minor modifications.

The consensus of the standard developers was that
_dc_
is a fundamentally less usable language and that that would be far too
severe a penalty for avoiding the issue of being similar to but
incompatible with C.

*  3.  
  Standardize the historical
  _bc_,
  possibly with minor modifications.

This was the approach taken. Most of the proponents of changing the
language would not have been satisfied until most or all of the
incompatibilities with C were resolved. Since most of the changes
considered most desirable would break historical applications and
require significant modification to historical implementations, almost
no modifications were made. The one significant modification that was
made was the replacement of the historical
_bc_
assignment operators
**"=+"**,
and so on, with the more modern
**"+="**,
and so on. The older versions are considered to be fundamentally flawed
because of the lexical ambiguity in uses like
_a_=\(mi1.

In order to permit implementations to deal with backwards-compatibility
as they see fit, the behavior of this one ambiguous construct was made
undefined. (At least three implementations have been known to support
this change already, so the degree of change involved should not be
great.)

The
**'%'**
operator is the mathematical remainder operator when
**scale**
is zero. The behavior of this operator for other values of
**scale**
is from historical implementations of
_bc_,
and has been maintained for the sake of historical applications despite
its non-intuitive nature.

Historical implementations permit setting
**ibase**
and
**obase**
to a broader range of values. This includes values less than 2, which
were not seen as sufficiently useful to standardize. These
implementations do not interpret input properly for values of
**ibase**
that are greater than 16. This is because numeric constants are
recognized syntactically, rather than lexically, as described in
this volume of POSIX.1-2008. They are built from lexical tokens of single hexadecimal digits
and
&lt;period&gt;
characters. Since
&lt;blank&gt;
characters between tokens are not visible at the syntactic level, it is
not possible to recognize the multi-digit \`\`digits'' used in the higher
bases properly. The ability to recognize input in these bases was not
considered useful enough to require modifying these implementations.
Note that the recognition of numeric constants at the syntactic level
is not a problem with conformance to this volume of POSIX.1-2008, as it does not impact the
behavior of conforming applications (and correct
_bc_
programs). Historical implementations also accept input with all of the
digits
**'0'**\(mi\c
**'9'**
and
**'A'**\(mi\c
**'F'**
regardless of the value of
**ibase**;
since digits with value greater than or equal to
**ibase**
are not really appropriate, the behavior when they appear is undefined,
except for the common case of:

    
    ibase=8;
        /* Process in octal base. */
    ...
    ibase=A
        /* Restore decimal base. */


In some historical implementations, if the expression to be written is
an uninitialized array element, a leading
&lt;space&gt;
and/or up to four leading 0 characters may be output before the
character zero. This behavior is considered a bug; it is unlikely that
any currently conforming application relies on:

    
    echo 'b[3]' | bc


returning 00000 rather than 0.

Exact calculation of the number of fractional digits to output for a
given value in a base other than 10 can be computationally expensive.
Historical implementations use a faster approximation, and this is
permitted. Note that the requirements apply only to values of
**obase**
that this volume of POSIX.1-2008 requires implementations to support (in particular, not to
1, 0, or negative bases, if an implementation supports them as an
extension).

Historical implementations of
_bc_
did not allow array parameters to be passed as the last parameter to a
function. New implementations are encouraged to remove this restriction
even though it is not required by the grammar.

<a name="future-directions"></a>

# Future Directions

None.

<a name="see-also"></a>

# See Also

_Section 1.3_, _Grammar Conventions_,
__awk_\^_

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
