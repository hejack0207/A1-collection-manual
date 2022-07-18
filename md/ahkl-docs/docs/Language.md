# Scripting Language

An AutoHotkey script is basically a set of instructions for the program to follow, written in a custom language exclusive to AutoHotkey. This language bears some similarities to several other scripting languages, but also has its own unique strengths and pitfalls. This document describes the language and also tries to point out common pitfalls.

See [Concepts and Conventions](Concepts.htm) for more general explanation of various concepts utilised by AutoHotkey.

There are two distinct styles of syntax used in AutoHotkey: [legacy syntax](#legacy-syntax) and [expressions](#expressions).

## Table of Contents

- [General Conventions](#general-conventions)
- [Comments](#comments)
- [Expressions](#expressions)
  - [Strings / Text](#strings)
  - [Variables](#variables)
  - [Operators](#operators)
  - [Function Calls](#function-calls)
  - [Operators for Objects](#operators-for-objects)
  - [Expression Statements](#expression-statements)
- [Legacy Syntax](#legacy-syntax)
- [Commands](#commands)
  - [OutputVar and InputVar Parameters](#outputvar-and-inputvar-parameters)
  - [Text Parameters](#text-parameters)
  - [Numeric Parameters](#numeric-parameters)
  - [% Expression](#-expression)
  - [Documentation Conventions](#documentation-conventions)
  - [Optional Parameters](#optional-parameters)
- [Expressions vs Legacy Syntax](#expressions-vs-legacy-syntax)
  - [Different Equals](#different-equals)
  - [Commands vs Functions](#commands-vs-functions)
- [Control Flow Statements](#control-flow)
  - [Control Flow vs Commands](#control-flow-vs-commands)
  - [If Statement](#if-statement)
  - [Loop Statement](#loop-statement)
  - [Not Control Flow](#not-control-flow)
- [Structure of a Script](#structure-of-a-script)
  - [Auto-execute Section](#auto-execute-section)
  - [Subroutines](#subroutines)
  - [User-Defined Functions](#user-defined-functions)
  - [#Include](#-include)
- [Miscellaneous](#misc)
  - [Dynamic Variables](#dynamic-variables)
    - [Pseudo-arrays](#pseudo-arrays)
    - [Associative pseudo-arrays](#associative-pseudo-arrays)
    - [Commands which create pseudo-arrays](#commands-which-create-pseudo-arrays)
  - [Labels](#labels)

## General Conventions

**Names:** Variable and function names are not case sensitive (for example, `CurrentDate` is the same as `currentdate`). For details such as maximum length and usable characters, see [Names](Concepts.htm#names).

**No typed variables:** Variables have no explicitly defined type; instead, a value of any type can be stored in any variable (excluding built-in variables). Numbers may be automatically converted to strings (text) and vice versa, depending on the situation.

**Declarations are optional:** Except where noted on the [functions page](Functions.htm), variables do not need to be declared; they come into existence simply by using them (and each variable starts off empty/blank).

**Spaces are mostly ignored:** Indentation (leading space) is important for writing readable code, but is not required by the program and is generally ignored. Spaces and tabs are _generally_ ignored at the end of a line, within an expression (except between quotes), and before and after command parameters. However, spaces are significant in some cases, including:

- [Function](#function-calls) and method calls require there to be no space between the function/method name and `(`.
- Spaces are required when performing concatenation.
- Spaces may be required between two operators, to remove ambiguity.
- Single-line[comments](#comments) require a leading space if they are not at the start of the line.

**Line breaks are meaningful:** Line breaks generally act as a statement separator, terminating the previous command or expression. (A _statement_ is simply the smallest standalone element of the language that expresses some action to be carried out.) The exception to this is line continuation (see below).

**Line continuation:** Long lines can be divided up into a collection of smaller ones to improve readability and maintainability. This is achieved by preprocessing, so is not part of the language as such. There are two methods:

- [Line continuation](Scripts.htm#continuation-line), where lines that begin with an [expression operator](Variables.htm#operators) (except ++ and --) are merged with the previous line. Lines are merged regardless of whether the line actually contains an expression.
- [Continuation sections](Scripts.htm#continuation-section), where multiple lines are merged with the line above the section. The start and end of a continuation section are marked with `(` and `)` (both symbols must appear at the beginning of a line, excluding whitespace).

## Comments

_Comments_ are portions of text within the script which are ignored by the program. They are typically used to add explanation or disable parts of the code.

Scripts can be commented by using a semicolon at the beginning of a line. For example:

```
<em>; This entire line is a comment.</em>
```

Comments may also be added at the end of a line, in which case the semicolon must have at least one space or tab to its left. For example:

```
Run Notepad  <em>; This is a comment on the same line as a command.</em>
```

In addition, the `<em>/*</em>` and `<em>*/</em>` symbols can be used to comment out an entire section, _but only if the symbols appear at the beginning of a line_ (excluding whitespace), as in this example:

```
<em>/*
MsgBox, This line is commented out (disabled).
MsgBox, Common mistake: */ this does not end the comment.
MsgBox, This line is commented out.
*/</em>

```

Since comments are ignored when a script is launched, they do not impact performance or memory utilization.

The default comment character (semicolon) can be changed to some other character or string via [#CommentFlag](commands/_CommentFlag.htm).

## Expressions

_Expressions_ are combinations of one or more [values](Concepts.htm#values), [variables](Concepts.htm#variables), [operators](#operators) and [function calls](#function-calls). For example, `10`, `1+1` and `MyVar` are valid expressions. Usually, an expression takes one or more values as input, performs one or more operations, and produces a value as the result. The process of finding out the value of an expression is called _evaluation_. For example, the expression `1+1` _evaluates_ to the number 2.

[Commands](#commands) are designed to take a list of parameters and perform only a single action per line, whereas simple expressions can be pieced together to form increasingly more complex expressions. For example, if `Discount/100` converts a discount percentage to a fraction, `1 - Discount/100` calculates a fraction representing the remaining amount, and `Price * (1 - Discount/100)` applies it to produce the net price.

_Values_ are [numbers](Concepts.htm#numbers), [objects](Concepts.htm#objects) or [strings](Concepts.htm#strings). A _literal_ value is one written physically in the script; one that you can see when you look at the code.

### Strings / Text

For a more general explanation of strings, see [Strings](Concepts.htm#strings).

A _string_, or _string of characters_, is just a text value. In an expression, literal text must be enclosed in quotation marks to differentiate it from a variable name or some other expression. This is often referred to as a _quoted literal string_, or just _quoted string_. For example, `"This is a quoted string."`.

To include an _actual_ quote character inside a quoted string, specify two consecutive quotes as shown twice in this example: `"She said, ""An apple a day."""`.

Quoted strings can contain [escape sequences](misc/EscapeChar.htm) such as `` `t`` (tab), `` `n`` (linefeed), and `` `r`` (carriage return). Unlike [unquoted text](#unquoted-text), it is not necessary to escape commas or percent signs, as quoted strings cannot contain variables. The use of the `` `"`` escape sequence to produce a literal quote-character is currently not supported; instead, use two consecutive quotes as shown above.

### Variables

For a basic explanation and general details about variables, see [Variables](Concepts.htm#variables).

_Variables_ can be used in an expression simply by writing the variable's name. For example, `A_ScreenWidth/2`. However, variables cannot be used inside a quoted string. Instead, variables and other values can be combined with text through a process called [_concatenation_](Variables.htm#concat). There are two ways to _concatenate_ values in an expression:

- Implicit concatenation:`"The value is " MyVar`
- Explicit concatenation:`"The value is " . MyVar`

Implicit concatenation is also known as _auto-concat_. In both cases, the spaces preceding the variable and dot are mandatory.

The [Format](commands/Format.htm) function can also be used for this purpose. For example:

```
MsgBox % Format("You are using AutoHotkey v{1} {2}-bit.", A_AhkVersion, A_PtrSize*8)

```

To assign a value to a variable, use the `:=` [assignment operator](Variables.htm#AssignOp), as in `MyVar := "Some text"`.

_Percent signs_ within an expression are used to create [dynamic variable references](#dynamic-variables) and [dynamic function calls](Functions.htm#DynCall). Most of the time these constructs are not needed, so in general, variable names should not be enclosed in percent signs within an expression.

### Operators

_Operators_ take the form of a symbol or group of symbols such as `+` or `:=`, or one of the words `and`, `or`, `not` or `new`. They take one, two or three values as input and return a value as the result. A value or sub-expression used as input for an operator is called an _operand_.

- _Unary_ operators are written either before or after a single operand, depending on the operator. For example, `-x` or `not keyIsDown`.
- _Binary_ operators are written in between their two operands. For example, `1+1` or `2 * 5`.
- AutoHotkey has only one_ternary_ operator, which takes the form [`condition ? valueIfTrue : valueIfFalse`](Variables.htm#ternary).

Some unary and binary operators share the same symbols, in which case the meaning of the operator depends on whether it is written before, after or in between two values. For example, `x-y` performs subtraction while `-x` inverts the sign of `x` (producing a positive value from a negative value and vice versa).

Operators of equal precedence such as multiply ( `*`) and divide ( `/`) are evaluated in left-to-right order unless otherwise specified in the [operator table](Variables.htm#operators). By contrast, an operator of lower precedence such as add ( `+`) is evaluated after a higher one such as multiply ( `*`). For example, `3 + 2 * 2` is evaluated as `3 + (2 * 2)`. Parentheses may be used to override precedence as in this example: `(3 + 2) * 2`

### Function Calls

For a general explanation of functions and related terminology, see [Functions/Commands](Concepts.htm#functions).

_Functions_ take a varying number of inputs, perform some action or calculation, and then [_return_](Concepts.htm#return-a-value) a result. The inputs of a function are called [_parameters_](Concepts.htm#parameters) or _arguments_. A function is [_called_](Concepts.htm#call) simply by writing its name followed by its parameters enclosed in parentheses. For example, `GetKeyState("Shift")` returns (evaluates to) 1 if Shift is being held down or 0 otherwise.

**Note:** There must not be any space between the function name and open parenthesis.

When compared to [commands](#commands), the requirement for parentheses may seem cryptic or verbose at first, but they are what allows a function call to be combined with other operations. For example, the expression `GetKeyState("Shift", "P") and GetKeyState("Ctrl", "P")` returns 1 only if both keys are being physically held down.

Function names are always global, and are separate to variable names. For example, `Round` can be both a variable name and a function name, and `Round := 1` will not affect `Round(n)` in any way.

### Operators for Objects

There are other symbols used in expressions which don't quite fit into any of the categories defined above, or that affect the meaning of other parts of the expression, as described below. These all relate to _objects_ in some way. Providing a full explanation of what each construct does would require introducing more concepts which are outside the scope of this section.

`Alpha.Beta` is often called _member access_. _Alpha_ is an ordinary variable, and could be replaced with a function call or some other sub-expression which returns an object. When evaluated, the object is sent a request "give me the value of property _Beta_", "store this value in property _Beta_" or "call the method named _Beta_". In other words, _Beta_ is a name which has meaning to the object; it is not a local or global variable.

`Alpha.Beta()` is a _method call_, as described above.

`Alpha.Beta[Param]` is a specialised form of member access which includes additional parameters in the request. While _Beta_ is a simple name, _Param_ is an ordinary variable or sub-expression, or a list of sub-expressions separated by commas (the same as in a function's parameter list).

`Alpha[Index]` has a similar function to `Alpha.Beta`, but each part is interpreted in a more standard way. That is, both _Alpha_ and _Index_ are variables in this case, and could be replaced with virtually any sub-expression. This syntax is usually used to retrieve an element of an [array](Objects.htm#Usage_Simple_Arrays) or [associative array](Objects.htm#Usage_Associative_Arrays).

`new ClassName()` is used to instantiate a class, or create an object derived from another object. Although this looks like a function call, _ClassName_ is actually an ordinary variable. Similarly, `new Alpha.Beta()` would create an object derived from the object returned by `Alpha.Beta`; _Beta_ is neither a function nor a method. If the optional parentheses are present, they may contain parameters for the object's [\_\_New](Objects.htm#Custom_NewDelete) method.

`[A, B, C]` creates an [array](Objects.htm#Usage_Simple_Arrays) with the initial contents A, B and C (all variables in this case), where A is element 1.

`{Key1: Value1, Key2: Value2}` creates an [associative array](Objects.htm#Usage_Associative_Arrays) from a list of key-value pairs. A value can later be retrieved by its associated key. Writing a plain word (consisting of alphanumeric characters, underscore and non-ASCII characters) to the left of `:` is equivalent to enclosing that word in quotation marks. For example, `{A: B}` is equivalent to `{"A": B}`. However, `{(A): B}` uses the contents of the variable `A` as the key.

`MyFunc(Params*)` is a [variadic function call](Functions.htm#VariadicCall). The asterisk must immediately precede the closing parenthesis at the end of the function's parameter list. _Params_ must be a variable or sub-expression which returns an array object. Although it isn't valid to use `Params*` just anywhere, it can be used in an array literal ( `[A, B, C, ArrayToAppend*]`) or indexer ( `Alpha[Params*]`).

### Expression Statements

Not all expressions can be used alone on a line. For example, a line consisting of just `21*2` or `"Some text"` wouldn't make any sense. An expression _statement_ is an expression used on its own, typically for its side-effects. Most expressions with side-effects can be used this way, so it is generally not necessary to memorise the details of this section.

The following types of expressions can be used as statements:

Assignments, as in `x := y`, compound assignments such as `x += y`, and increment/decrement operators such as `++x` and `x--`. However, in AutoHotkey v1, `++`, `--`, `+=`, `-=`, `*=` and `/=` have slightly different behavior when used alone on a line, as they are actually equivalent to EnvAdd, EnvSub, EnvMult or EnvDiv. For details, see "Known limitations" under [Assign](Variables.htm#AssignOp) in the table of operators.

Function calls such as `MyFunc(Params)`. However, a standalone function call cannot be followed by an open brace `{` (at the end of the line or on the next line), because it would be confused with a function declaration.

Method calls such as `MyObj.MyMethod()`.

Member access using square brackets, such as `MyObj[Index]`, which can have side-effects like a function call.

Expressions starting with the `new` operator, as in `new ClassName`, because sometimes a class can be instantiated just for its side-effects.

Ternary expressions such as `x ? CallIfTrue() : CallIfFalse()`. However, it is safer to utilize the rule below; that is, always enclose the expression (or just the condition) in parentheses.

**Note:** Command names take precedence over ternary in AutoHotkey v1. For example, `MsgBox ? 1 : 0` shows a message box.

**Note:** The condition cannot begin with `!` or any other expression operator, as it would be interpreted as a [continuation line](Scripts.htm#continuation-line).

Expressions starting with `(`. However, there usually must be a matching `)` on the same line, otherwise the line would be interpreted as the start of a [continuation section](Scripts.htm#continuation).

Expressions that start with any of those described above (but not those described below) are also allowed, for simplicity. For example, `MyFunc()+1` is currently allowed, although the `+1` has no effect and its result is discarded. Such expressions might become invalid in the future due to enhanced error-checking.

Member access using a dot (once or in a series), such as `ExcelApp.Quit` or `x.y.z`. However, unless parentheses are used (as in a method call), this cannot be the prefix of a larger expression. For example, `ExcelApp.Quit, xxx` is prohibited due to the apparent similarity to command syntax.

## Legacy Syntax

_Legacy_ or _command_ syntax generally only allows a single action per line, but uses fewer characters to perform simple tasks such as [sending keystrokes](commands/Send.htm) or [running a program](commands/Run.htm). The syntax consists of command and variable names, _unquoted text_ and a few symbols such as `,`, `=` and `%`.

_Unquoted text_ is simply text, not enclosed in quote marks, just straight up. Since the text has no explicit start and end marks, it ends at the end of the line or the end of the parameter. Leading and trailing spaces and tabs are ignored. Within unquoted text, the following characters have special meaning:

- `%`: Enclose a variable name in percent signs to include the contents of that variable. For example, `The year is %A_Year%.`

  **Note:** Variable names are not _always_ enclosed in percent signs; they are required only within unquoted text. Percent signs should not be used anywhere else, except to create a [dynamic variable reference](#dynamic-variables) or [dynamic function call](Functions.htm#DynCall).


  **Note:** Only a plain variable name can be used. [Array elements](Objects.htm#Usage_Simple_Arrays), [properties](Objects.htm#Usage_Objects) and other [expressions](#expressions) are not supported.

- `,`: Comma is used to delimit (separate) the parameters of a command, with [some exceptions](#escape-comma). It has no special meaning when used in an assignment or comparison, so is interpreted literally in such cases.

- `` ` ``: An [escape character](misc/EscapeChar.htm) is usually used to indicate that the character immediately following it should be interpreted differently than it normally would. For example, `` `%`` produces a literal percent sign and `` `,`` produces a literal comma. Some other common escape sequences produce special characters, such as `` `t`` (tab), `` `n`` (linefeed), and `` `r`` (carriage return).


[Commands](#commands) accept a mixture of [unquoted text](#text-parameters), [variable names](#outputvar-and-inputvar-parameters) and [numeric expressions](#numeric-parameters).

```
Send, The time is %A_Hour% o'clock.

```

[Legacy assignment](commands/SetEnv.htm) assigns [unquoted text](#unquoted-text) to a variable.

```
Clipboard = This text is copied to the clipboard.

```

[If statements](#if-statement) perform an action only if the specified condition is met.

```
If Var = Text value

```

There are also several other [control flow statements](#control-flow) (such as loops) which use legacy syntax similar to commands.

## Commands

A _command_ is an instruction to carry out a specific predefined action. "Command" may also refer to a specific predefined action, such as [MsgBox](commands/MsgBox.htm). The set of available [commands](commands/index.htm) is predefined and cannot be changed by the script.

A command is _called_ simply by writing its name at the beginning of a line, optionally followed by parameters. For example:

```
MsgBox, The time is %A_Hour% o'clock.

```

The comma separating the command name from its parameters is optional, except in the following cases:

- When it's necessary to prevent the line from being interpreted as a [legacy assignment](commands/SetEnv.htm) or [assignment expression](Variables.htm#AssignOp).


  ```
  MsgBox, := This would be an assignment without the comma.

  ```

- When the first parameter is blank.


  ```
  MsgBox,, Second, Third

  ```

- When the command is alone at the top of a [continuation section](Scripts.htm#continuation).


Each parameter of a command may accept different syntax, depending on the command. There are four types of parameters:

- OutputVar
- InputVar
- Text
- Number

In most cases the [percent prefix](#-expression) can be used to pass an expression.

### OutputVar and InputVar Parameters

_OutputVar_ and _InputVar_ parameters require a variable name or [dynamic variable reference](#dynamic-variables). For example:

```
<em>; Replace all spaces with pluses:</em>
StringReplace, NewStr, OldStr, %A_Space%, +, All

```

This command reads the value from _OldStr_ (the InputVar) and stores the result in _NewStr_ (the OutputVar).

**Note:** Only a plain variable can be used as an _OutputVar_. [Array elements](Objects.htm#Usage_Simple_Arrays), [properties](Objects.htm#Usage_Objects) and other [expressions](#expressions) are not supported.

_InputVar_ parameters can accept an expression only when the [percent prefix](#-expression) is used. However, the prefix is not supported in the _Var_ parameters of [legacy If commands](#legacy-if), so [If (expression)](commands/IfExpression.htm) should be used instead.

### Text Parameters

Text parameters accept [unquoted text](#unquoted-text). For example:

```
MsgBox, The time is %A_Hour% o'clock.

```

Since commas and percent signs have special meaning, use the [escape sequence](misc/EscapeChar.htm) `` `,`` to specify a literal comma and `` `%`` to specify a literal percent sign. For clarity, it is best to always escape any comma which is intended to be literal, but escaping comma is optional in the following cases:

- In the last parameter of any command.
- In the_Text_ parameter of MsgBox, which has smart comma handling.

To include a leading or trailing space or tab, use the built-in variables [%A\_Space%](Variables.htm#Space) and [%A\_Tab%](Variables.htm#Tab) or a forced expression such as `% " x "`. [v1.1.06+]: Whitespace can also be preserved by preceding the space or tab with an [escape character](misc/EscapeChar.htm), except for whitespace at the end of a line.

Text parameters can also accept a [forced expression](#-expression).

### Numeric Parameters

Numeric parameters accept a literal number or an [expression](#expressions), and can be identified by phrasing like "This parameter can be an expression."

For historical reasons, simple variable references alone or combined with digits are not interpreted as expressions. For example:

```
Sleep %n%000  <em>; Sleep for n seconds.</em>
Sleep %m%     <em>; Sleep for m milliseconds.</em>

```

To perform a [double-deref](#dynamic-variables) in such cases, enclose the expression in parentheses: `Sleep (%m%)`

Note that mixed-type parameters such as [SetTimer's](commands/SetTimer.htm) second parameter, which sometimes accepts a number and sometimes accepts a string such as `On` or `Off`, are actually Text parameters, and as such, they do not accept expressions unless the [percent prefix](#-expression) is used.

Numeric parameters allow and ignore the [percent prefix](#-expression).

### % Expression

Although purely numeric parameters accept an expression by default, all other parameters of commands do not. Specify a percent sign followed by a space or tab to force a parameter to accept an [expression](#expressions). For example, all of the following are effectively identical because [Sleep](commands/Sleep.htm)'s first parameter is expression-capable:

```
Sleep MillisecondsToWait
Sleep %MillisecondsToWait%
Sleep % MillisecondsToWait

```

**Note:** Using the percent-space prefix in a [numeric parameter](#numeric-parameters) does not necessarily force it to be an expression.

All parameters support the percent-space prefix except for:

- The_Var_ parameter of any [legacy If](#legacy-if) command. Users can avoid confusion by always using [if (expression)](commands/IfExpression.htm).
- _OutputVar_ parameters, which accept a variable reference using the same syntax as expressions.

Some users may find it easier to always force an expression, keeping to one consistent syntax (expression syntax) as much as possible.

### Documentation Conventions

At the top of each page which documents a command, there is usually a block showing syntax, like this:

```
<span class="func">StringLower</span>, OutputVar, InputVar <span class="optional">, T</span>
```

The square brackets denote optional parameters; the brackets themselves must be omitted from the actual code.

Sometimes the value a parameter accepts is written directly in the syntax block. For example, the third parameter of StringLower shown above accepts the letter T as text. The exact usage of a parameter is described in the _Parameters_ section, and varies between commands.

### Optional Parameters

Optional parameters can simply be left blank. The comma preceding an optional parameter can also be omitted if all subsequent parameters are omitted. For example, the [Run](commands/Run.htm) command can accept between one and four parameters. All of the following are valid:

```
Run, notepad.exe, C:\
Run, notepad.exe,, Min
Run notepad.exe, , , notepadPID

```

## Expressions vs Legacy Syntax

Many command parameters do not accept expressions by default. Use the [percent-space prefix](#-expression) at the beginning of a parameter to evaluate that parameter as an expression. In the following examples, the expression is shown on the first line (beginning _after_ the percent sign), with pure legacy syntax shown on the second line.

```
MsgBox % 1+1  <em>; Shows "2"</em>
MsgBox   1+1  <em>; Shows "1+1"</em>

```

Literal text in an expression is always enclosed in quote marks. These are called _quoted strings_.

```
MsgBox % "This is text."
MsgBox    This is text.

```

Variables in an expression are never enclosed in percent signs, except to create a [double reference](#dynamic-variables).

```
MsgBox %  A_AhkVersion
MsgBox   %A_AhkVersion%

```

Variables cannot be used inside a quoted string.

```
MsgBox % "Hello %A_UserName%."  <em>; Shows "%A_UserName%"</em>
MsgBox    Hello %A_UserName%.   <em>; Shows your username.</em>

```

Instead, values are [_concatenated_](Variables.htm#concat) by writing them in sequence, separated by a space or tab, or a dot surrounded by spaces.

```
MsgBox % "Hello " . A_UserName . "."  <em>; Shows your username.</em>

```

One alternative is to use the [Format](commands/Format.htm) function, which can also format the parameter value in various ways.

```
MsgBox % Format("Hello {1}.", A_UserName)  <em>; {} also works in place of {1}.</em>

```

A value is assigned to a variable with `:=` instead of `=`:

```
MyVar := "This is text."
MyVar = This is text.

```

Comparisons are performed using the same symbols as [legacy If](#legacy-if): `=`, `<>` or `!=`, `>`, `>=`, `<` and `<=`.

```
if (Var1 = Var2)
if Var1 = %Var2%

```

In an expression, both values can be simple values or complex sub-expressions. A comparison can also be combined with other conditions using [operators](Variables.htm#Operators) such as `and` and `or` (which are equivalent to `&&` and `||`).

```
if (Var1 >= Low and Var1 <= High)
if Var1 between %Low% and %High%

```

### Different Equals

One common mistake is to write `=` where `:=` is needed. For example:

```
Total = A + B   <em>; Assigns the literal text "A + B"</em>

```

This can be difficult to avoid (at least until such time as the legacy assignment syntax is removed), but it may help to always use `:=` where an assignment is intended.

The equal sign (when not used with another symbol, such as `<=`) has the following meanings:

- [Legacy assignment](commands/SetEnv.htm): `Var = Value`
- [Legacy If equal](commands/IfEqual.htm): `if Var = Value`
- [Case-insensitive equal](Variables.htm#equal): `if (Expr1 = Expr2)` (also valid in other expressions, not just `if`)
- [Assign after comma](Variables.htm#comma): `x:=1, y=2, a=b=c` (all are assignments due to a special rule)
- [Declare and initialize](Functions.htm#DeclareInit): `local x = Expr` (always accepts an expression)
- [Set parameter default value](Functions.htm#optional): `MyFunc(Param="Default value") {`...

The first two cases can be avoided by always using the `:=` [assignment operator](Variables.htm#AssignOp) and [if (expression)](commands/IfExpression.htm).

For the last three cases, `:=` should have been used instead of `=`.

### Commands vs Functions

In AutoHotkey v1, it is currently not possible to call a command from an expression, or to call a function using the _command syntax_. However, several commands have a function replacement.

CommandReplacement[FileAppend](commands/FileAppend.htm)[FileOpen](commands/FileOpen.htm) and [File.Write](objects/File.htm#Write)[FileGetAttrib](commands/FileGetAttrib.htm)[FileExist](commands/FileExist.htm)[FileRead](commands/FileRead.htm)[FileOpen](commands/FileOpen.htm) and [File.Read](objects/File.htm#Read)[GetKeyState](commands/GetKeyState.htm#command)[GetKeyState](commands/GetKeyState.htm#function) (the function returns 0 or 1, not "U" or "D")[IfExist](commands/IfExist.htm)[FileExist](commands/FileExist.htm)[IfInString](commands/IfInString.htm)[InStr](commands/InStr.htm)[IfWinActive](commands/IfWinActive.htm)[WinActive](commands/WinActive.htm)[IfWinExist](commands/IfWinExist.htm)[WinExist](commands/WinExist.htm)[StringGetPos](commands/StringGetPos.htm)[InStr](commands/InStr.htm)[StringLen](commands/StringLen.htm)[StrLen](commands/StrLen.htm)[StringReplace](commands/StringReplace.htm)[StrReplace](commands/StrReplace.htm)[StringSplit](commands/StringSplit.htm)[StrSplit](commands/StrSplit.htm)[StringLower\
\
StringUpper](commands/StringLower.htm)`<a href="commands/Format.htm" data-index="169">Format</a>("{:L}", input)`, `Format("{:U}", input)` or `Format("{:T}", input)`[StringLeft](commands/StringLeft.htm)

[StringMid](commands/StringMid.htm)

[StringRight](commands/StringLeft.htm)

[StringTrimLeft](commands/StringTrimLeft.htm)

[StringTrimRight](commands/StringTrimLeft.htm)[SubStr](commands/SubStr.htm)

## Control Flow Statements

For a general explanation of control flow, see [Control Flow](Concepts.htm#control-flow).

[Statements](Concepts.htm#statement) are grouped together into a [_block_](commands/Block.htm) by enclosing them in braces `{}`, as in C, JavaScript and similar languages, but usually the braces must appear at the start of a line. Control flow statements can be applied to an entire block or just a single statement.

The [body](Concepts.htm#cf-body) of a control flow statement is always a single _group_ of statements. A block counts as a single group of statements, as does a control flow statement and its body. The following related statements are also grouped with each other, along with their bodies: `If` with `Else`; `Loop`/ `For` with `Until`; `Try` with `Catch` and/or `Finally`. In other words, when a group of these statements is used as a whole, it does not always need to be enclosed in braces (however, some coding styles always include the braces, for clarity).

Control flow statements which have a body and therefore must always be followed by a related statement or group of statements: `If`, `Else`, `Loop`, `While`, `For`, `Try`, `Catch` and `Finally`.

The following control flow statements exist:

- A[block](commands/Block.htm) (denoted by a pair of braces) groups zero or more statements to act as a single statement.
- An[If statement](#if-statement) causes its body to be executed or not depending on a condition. It can be followed by an [Else](commands/Else.htm) statement, which executes only if the condition was not met.
- [Goto](commands/Goto.htm) jumps to the specified label and continues execution.
- [Gosub](commands/Gosub.htm) calls a [subroutine](#subroutines).
- [Return](commands/Return.htm) returns from a [subroutine](#subroutines) or function.
- A[Loop statement](#loop-statement) ( [Loop](commands/Loop.htm), [While](commands/While.htm) or [For](commands/For.htm)) executes its body repeatedly.

  - [Break](commands/Break.htm) exits (terminates) a loop.
  - [Continue](commands/Continue.htm) skips the rest of the current loop iteration and begins a new one.
  - [Until](commands/Until.htm) causes a loop to terminate when an expression evaluates to true. The expression is evaluated after each iteration.
- [Switch](commands/Switch.htm) executes one case from a list of mutually exclusive candidates.
- Exception handling:
  - [Try](commands/Try.htm) guards its body against runtime errors and exceptions thrown by the throw command.
  - [Catch](commands/Catch.htm) executes its body after an exception is thrown within a try statement (and only if an exception is thrown).
  - [Finally](commands/Finally.htm) executes its body when control is being transferred out of a try or catch statement's body.
  - [Throw](commands/Throw.htm) throws an exception to be handled by try/catch or display an error dialog.

### Control Flow vs Commands

Control flow statements have syntax resembling [commands](#commands), and are often referred to as such, but some differ from commands:

- There are several types of[If statement](#if-statement), with each having different syntax.
- [For](commands/For.htm) and several types of [If statement](#if-statement) use keywords or an operator instead of commas to separate some of their parameters.
- The opening brace of a[block](commands/Block.htm) can be written at the end of the same line as an [If (expression)](commands/IfExpression.htm), [Else](commands/Else.htm), [Loop Count](commands/Loop.htm), [While](commands/While.htm), [For](commands/For.htm), [Try](commands/Try.htm), [Catch](commands/Catch.htm) or [Finally](commands/Finally.htm) statement (basically any control flow statement which does not use [legacy syntax](#legacy-syntax)). This is referred to as the One True Brace (OTB) style. It is not supported by the other Loop sub-commands or [legacy If statement](#legacy-if), as the brace would be interpreted as a literal `{` character.
- [Else](commands/Else.htm), [Try](commands/Try.htm) and [Finally](commands/Finally.htm) allow any valid statement to their right, as they require a [body](Concepts.htm#cf-body) but have no parameters.
- [If (expression)](commands/IfExpression.htm) and [While](commands/While.htm) allow an open parenthesis to be used immediately after the name. For example, `if(expression)`.
- [For](commands/For.htm), [While](commands/While.htm), [Until](commands/Until.htm) and [Throw](commands/Throw.htm) always accept expressions. They treat `%var%`, `%var%000` and similar as expressions, whereas [numeric parameters](#numeric-parameters) of other commands do not. The requirement for backward-compatibility does not apply to these control flow statements as they are relatively new.

### If Statement

[If (expression)](commands/IfExpression.htm) evaluates an expression and executes the following statement only if the result is true.

**Common cause of confusion:** There are several other types of If statements, some of which look very similar to _If (expression)_. These should be avoided in new scripts. If in doubt, it is best to always begin the expression with an open-parenthesis. The "legacy" If statements are as follows:

- [If Var _op_ Value](commands/IfEqual.htm), where _op_ is one of the following operators: `=`, `<>`, `!=`, `>`, `>=`, `<`, `<=`.
- [If Var [not] between Lower and Upper](commands/IfBetween.htm)
- [If Var [not] in/contains MatchList](commands/IfIn.htm)
- [If Var is [not] Type](commands/IfIs.htm)

Any If statement which does not match one of the usages shown above is interpreted as [If (expression)](commands/IfExpression.htm).

These are some common points of confusion related to legacy If statements:

- Variable names must be enclosed in percent signs_only_ on the right-hand side of the operator.
- `between`, `in`, `contains` and `is` are only valid in this context; they cannot be used in [expressions](#expressions).
- Multiple conditions cannot be written on the same line (such as with the`and` operator).
- None of the parameters are expressions.

The following "legacy" named If statements also exist:

- [IfEqual, IfNotEqual, IfLess, IfLessOrEqual, IfGreater and IfGreaterOrEqual](commands/IfEqual.htm)
- [If[Not]Exist](commands/IfExist.htm)
- [If[Not]InString](commands/IfInString.htm)
- [If[Not]WinActive](commands/IfWinActive.htm)
- [If[Not]WinExist](commands/IfWinExist.htm)
- [IfMsgBox](commands/IfMsgBox.htm)

With the exception of IfMsgBox, these are all obsolete and generally should be avoided in new scripts.

Named If statements allow a [command](#commands) to be written on the same line, but mispelled command names are treated as literal text. Such errors may be difficult to detect.

### Loop Statement

There are several types of loop statements:

- [Loop Count](commands/Loop.htm) executes a statement repeatedly: either the specified number of times or until break is encountered.
- [Loop Reg](commands/LoopReg.htm) retrieves the contents of the specified registry subkey, one item at a time.
- [Loop Files](commands/LoopFile.htm) retrieves the specified files or folders, one at a time.
- [Loop Parse](commands/LoopParse.htm) retrieves substrings (fields) from a string, one at a time.
- [Loop Read](commands/LoopReadFile.htm) retrieves the lines in a text file, one at a time.
- [While](commands/While.htm) executes a statement repeatedly until the specified expression evaluates to false. The expression is evaluated before each iteration.
- [For](commands/For.htm) executes a statement once for each value or pair of values returned by an enumerator, such as each key-value pair in an object.

[Break](commands/Break.htm) exits (terminates) a loop, effectively jumping to the next line after the loop's body.

[Continue](commands/Continue.htm) skips the rest of the current loop iteration and begins a new one.

[Until](commands/Until.htm) causes a loop to terminate when an expression evaluates to true. The expression is evaluated after each iteration.

A [label](#labels) can be used to "name" a loop for [Continue](commands/Continue.htm) and [Break](commands/Break.htm). This allows the script to easily continue or break out of any number of nested loops without using [Goto](commands/Goto.htm).

The built-in variable **A\_Index** contains the number of the current loop iteration. It contains 1 the first time the loop's body is executed. For the second time, it contains 2; and so on. If an inner loop is enclosed by an outer loop, the inner loop takes precedence. A\_Index works inside all types of loops, but contains 0 outside of a loop.

For some loop types, other built-in variables return information about the current loop item (registry key/value, file, substring or line of text). These variables have names beginning with **A\_Loop**, such as A\_LoopFileName and A\_LoopReadLine. Their values always correspond to the most recently started (but not yet stopped) loop of the appropriate type. For example, A\_LoopField returns the current substring in the innermost parsing loop, even if it is used inside a file or registry loop.

```
t := "column 1`tcolumn 2`nvalue 1`tvalue 2"
Loop Parse, t, `n
{
    rowtext := A_LoopField
    rownum := A_Index  <em>; Save this for use in the second loop, below.</em>
    Loop Parse, rowtext, `t
    {
        MsgBox %rownum%:%A_Index% = %A_LoopField%
    }
}

```

Loop variables can also be used outside the body of a loop, such as in a function or subroutine which is called from within a loop.

### Not Control Flow

As directives, labels (including hotkeys and hotstrings), and declarations without assignments are processed when the script is loaded from file, they are not subject to control flow. In other words, they take effect unconditionally, before the script ever executes any control flow statements. Similarly, the #If directives such as [#IfWinActive](commands/_If.htm) cannot affect control flow; they merely set the criteria for any hotkey labels and hotstrings specified in the code. A hotkey's criteria is evaluated each time it is pressed, not when the #If directive is encountered in the code.

## Structure of a Script

### Auto-execute Section

After the script has been loaded, it begins executing at the top line, continuing until a [Return](commands/Return.htm), [Exit](commands/ExitApp.htm), the script's first [hotkey/hotstring label](Hotkeys.htm), or the physical end of the script is encountered (whichever comes first). This top portion of the script is referred to as the _auto-execute section_, but it is really just a [subroutine](#subroutines) which is called after program startup.

**Note:** While the script's _first_ hotkey/hotstring label has the same effect as [return](commands/Return.htm), other hotkeys and labels do not.

The auto-execute section is often used to configure settings which apply to every newly launched [thread](misc/Threads.htm). For details, see [The Top of the Script](Scripts.htm#auto).

### Subroutines

A _subroutine_ (or sub) is a reusable block of code which can be _called_ to perform some task.

Scripts use subroutines to define what should happen when a particular hotkey is pressed or some other event occurs. Scripts can also call subroutines directly, by using [Gosub](commands/Gosub.htm).

Any [label](#labels) can be used as the starting point of a subroutine. A subroutine has no explicitly marked ending point, but instead ends if and when control is returned to the subroutine's caller by [Return](commands/Return.htm) or when the thread is exited. For example:

```
gosub Label1

Label1:
MsgBox %A_ThisLabel%
return

```

Note that as labels have no effect when reached during normal execution, in this example a message box would be shown twice: once while the subroutine is running and again after it returns. One important consequence is that you cannot define one subroutine inside another subroutine, because the "body" of the inner subroutine would execute automatically and then _return_, effectively terminating the outer subroutine.

Subroutines should typically be defined separately to any other block of code, but can also be [defined inside a function](Functions.htm#gosub), allowing the subroutine access to that function's static variables (and local variables, but only while the function is running).

**Note:** Subroutines defined inside a function have certain limitations regarding the use of local variables and [dynamic variable references](#dynamic-variables), including [Gui control variables](commands/Gui.htm#Events). For details, see [Using Subroutines Within a Function](Functions.htm#gosub).

### User-Defined Functions

Generally speaking, a [function](Functions.htm) is a kind of subroutine. However, within the AutoHotkey documentation, "subroutine" typically refers to the kind of subroutine defined by a label (described above).

User-defined functions differ from subroutines in that they can _accept parameters_ and _return a value_, and they can have [local variables](Functions.htm#Local). They can be called either by a [function call](#function-calls) within the script or by the program itself, such as if a function was passed to the [Hotkey](commands/Hotkey.htm) or [SetTimer](commands/SetTimer.htm) commands.

Functions are defined using syntax resembling a function call followed by a block of code enclosed in braces:

```
MyFunction(FirstParameter, Second, ByRef Third, Fourth:="")
{
    ...
    return "a value"
}

```

As with function calls, there must be no space between the function name and open-parenthesis.

The line break between the close-parenthesis and open-brace is optional. There can be any amount of whitespace or comments between the two.

[ByRef](Functions.htm#ByRef) indicates that the parameter accepts a variable reference, making that parameter an alias for whichever variable the caller passes. If the caller does not pass a variable, the parameter acts as a normal local variable. ByRef parameters can also be optional.

[Optional](Functions.htm#optional) parameters are specified by following the parameter name with `:=` or `=` and a default value, which must be a literal quoted string, a number, `true` or `false`. The operators `:=` and `=` are interchangeable for historical reasons, but it is best to use `:=` for consistency with assignment in expressions.

The function can [return a value](Functions.htm#return). If it does not, the default return value is an empty string.

A function cannot be defined inside another function. Otherwise, the position of a function definition does not matter; any function defined within the script can be called from anywhere else.

See [Functions](Functions.htm) for much more detail.

### \#Include

The [#Include](commands/_Include.htm) directive causes the script to behave as though the specified file's contents are present at this exact position. This is often used to organise code into separate files, or to make use of script libraries written by other users.

**Note:** The following paragraphs detail some common points of confusion.

When using #Include, it is important to consider what effect the file's contents would have if placed at that position, since #Include will have the same effect. For instance:

- #Include generally should not be used in the middle of a subroutine or function.

- The use of #Include in the script's [auto-execute section](#auto-execute-section) requires special consideration, because the auto-execute section is essentially just a subroutine. Execution of a subroutine halts if it reaches a `return`, regardless of which file that `return` is in. Similarly, if the file contains a hotkey/hotstring, it may be considered the script's _first_ hotkey/hotstring, which would act like `return`.

- The script only has one [auto-execute section](#auto-execute-section), not one per file.


#Include can be safely used within the [auto-execute section](#auto-execute-section) to include files which contain only function definitions, since function definitions (but not function calls) are skipped over during execution. If a file contains other code, one can avoid breaking the auto-execute section by skipping over the file's contents with [Goto](commands/Goto.htm).

Unlike in C/C++, #Include does nothing if the file has already been included by a previous directive. To include the contents of the same file multiple times, use [#IncludeAgain](commands/_Include.htm).

Script files containing functions can be _automatically_ included without having to use #Include, if they are saved in a standard location and named appropriately. The effect is similar to using #Include at the end of the main script file. For details, see [Libraries of Functions](Functions.htm#lib).

## Miscellaneous

### Dynamic Variables

A _dynamic variable reference_ takes a text value and interprets it as the name of a variable.

The most common form of dynamic variable reference is called a _double reference_ or _double-deref_. Before performing a double reference, the name of the target variable is stored in a second variable. This second variable can then be used to assign a value to the target variable indirectly, using a double reference. For example:

```
target := 42
second := "target"
MsgBox   %second%  <em>; Normal (single) variable reference in text => target</em>
MsgBox %  second   <em>; Normal (single) variable reference in an expression => target</em>
MsgBox % %second%  <em>; Double-deref in an expression => 42</em>

```

At first, it would appear that percent signs have a different meaning depending on whether they are used in text or in an expression. However, it may make more sense to think of `%second%` as being replaced with the contents of the variable `second` in _both_ cases:

- `MsgBox %second%` → `MsgBox target`: Shows "target".
- `MsgBox % %second%` → `MsgBox % target`: Shows the contents of `target`, i.e. "42".

Currently, `second` must always contain a variable name in the second case; arbitrary expressions are not supported.

A dynamic variable reference can also take one or more pieces of literal text and the content of one or more variables, and join them together to form a single variable name. This is done simply by writing the pieces of the name and percent-enclosed variables in sequence, without any spaces. For example, `MyArray%A_Index%` or `MyGrid%X%_%Y%`. This is used to access _pseudo-arrays_, described below.

For a description of how dynamic variable references inside functions are resolved, see [Functions: More about locals and globals](Functions.htm#Dynamic).

#### Pseudo-arrays

A _pseudo-array_ is actually just a bunch of discrete variables, but with a naming pattern which allows them to be used like elements of an array. For example:

```
MyArray1 = A
MyArray2 = B
MyArray3 = C
Loop 3
    MsgBox % MyArray%A_Index%  <em>; Shows A, then B, then C.</em>

```

As the individual elements are just normal variables, one can assign or retrieve a value, but cannot _remove_ or _insert_ elements. Because the pseudo-array itself doesn't really exist, it can't be passed to or returned from a function, or copied as a whole. For these reasons, it is generally recommended to use [normal arrays](Objects.htm#Usage_Simple_Arrays) instead, where possible.

#### Associative pseudo-arrays

The "index" used to form the final variable name does not have to be numeric; it could instead be a letter or keyword, making the pseudo-array similar to an [associative array](Objects.htm#Usage_Associative_Arrays) or an [object](Objects.htm). The following example creates a pseudo-array with elements "Left", "Top", "Right" and "Bottom":

```
SysGet, WA, MonitorWorkArea
MsgBox, Left: %WALeft% -- Top: %WATop% -- Right: %WARight% -- Bottom: %WABottom%.

```

#### Commands which create pseudo-arrays

There are several commands which create associative pseudo-arrays:

- [GuiControlGet Pos](commands/GuiControlGet.htm).
- [RegExMatch](commands/RegExMatch.htm), except when given the `O)` option, which causes it to output a single object containing all match information.
- [SysGet Monitor/MonitorWorkArea](commands/SysGet.htm), as demonstrated above.
- [StringSplit](commands/StringSplit.htm). New scripts should use [StrSplit()](commands/StrSplit.htm) instead, as it creates a [normal array](Objects.htm#Usage_Simple_Arrays).
- [WinGet List](commands/WinGet.htm).

**Caution:** These commands do not follow the same rules as _dynamic variable references_. If used within a function, the resulting pseudo-array is either entirely global or entirely local, depending only on the first element (or base name) of the array. Some of the variables in the pseudo-array may be inaccessible if they are not individually declared. For details, see [Functions: More about locals and globals](Functions.htm#PseudoArrays).

AutoHotkey also creates one global pseudo-array to contain any [command line parameters](Scripts.htm#cmd_args) that were passed to the script.

### Labels

A label identifies a line of code, and can be used as a [Goto](commands/Goto.htm) target or to form a [subroutine](#subroutines). There are three kinds of label: normal named labels, [hotkey](Hotkeys.htm) labels and [hotstring](Hotstrings.htm) labels.

Normal labels consist of a name followed by a colon.

```
this_is_a_label:

```

Hotkey labels consist of a hotkey followed by double-colon.

```
^a::

```

Hotstring labels consist of a colon, zero or more [options](Hotstrings.htm#Options), another colon, an abbreviation and double-colon.

```
:*:btw::

```

Generally, aside from whitespace and comments, no other code can be written on the same line as a label. However:

- A hotkey label can be directly followed by a command or other statement to create a_one-line_ hotkey. In other words, if a command, assignment or expression is present on the same line as a hotkey label, it acts as though followed by `return`.
- A hotkey with a[key name](KeyList.htm) written to the right of the double-colon is actually a [_remapping_](misc/Remap.htm), which is shorthand for [a pair of hotkeys](misc/Remap.htm#actually). For example, `a::b` creates hotkeys and labels for `*a` and `*a Up`, and does not create a label named `a`.
- A hotstring with text written to the right of the final double-colon is an_auto-replace_ hotstring. Auto-replace hotstrings do not act as labels.

For more details, see [Labels](misc/Labels.htm).

