# Variables and Expressions

## Table of Contents

- [Variables](#Intro)
- [Expressions](#Expressions)
- [Operators in Expressions](#Operators)
- [Built-in Variables](#BuiltIn)
- [Variable Capacity and Memory](#cap)

## Variables

See [Variables](Concepts.htm#variables) for general explanation and details about how variables work.

**Storing values in variables**: To store a string or number in a variable, there are two methods: [legacy](Language.htm#legacy-syntax) and [expression](Language.htm#expressions). The legacy method uses the [equal sign operator (=)](commands/SetEnv.htm) to assign [**unquoted** literal strings](Language.htm#unquoted-text) or variables enclosed in percent signs. For example:

```
MyNumber = 123
MyString = This is a literal string.
CopyOfVar = %Var%  <em>; With the = operator, percent signs are required to retrieve a variable's contents.</em>
```

By contrast, the expression method uses the [colon-equal operator (:=)](commands/SetExpression.htm) to store numbers, [**quoted** strings](Language.htm#strings), and other types of [expressions](Language.htm#expressions). The following examples are functionally identical to the previous ones:

```
MyNumber := 123
MyString := "This is a literal string."
CopyOfVar := Var  <em>; Unlike its counterpart in the previous section, percent signs are not used with the := operator.</em>
```

The latter method is preferred by many due to its greater clarity, and because it supports an [expression syntax](Language.htm#expressions) nearly identical to that in many other languages.

You may have guessed from the above that there are two methods to erase the contents of a variable (that is, to make it blank):

```
MyVar =
MyVar := ""
```

The empty pair of quotes above should be used only with the := operator because if it were used with the = operator, it would store two literal quote-characters inside the variable.

**Retrieving the contents of variables**: Like the two methods of storing values, there are also two methods for retrieving them: [legacy](Language.htm#legacy-syntax) and [expression](Language.htm#variables). The legacy method requires that each variable name be enclosed in percent signs to retrieve its contents. For example:

```
<a href="commands/MsgBox.htm" data-index="17">MsgBox</a> The value in the variable named Var is %Var%.
CopyOfVar = %Var%
```

By contrast, the expression method omits the percent signs around variable names, but encloses [literal strings](Language.htm#strings) in quotes. Thus, the following are the expression equivalents of the previous examples:

```
MsgBox % "The value in the variable named Var is " . Var . "."  <em>; A period is used to concatenate (join) two strings.</em>
CopyOfVar := Var
```

In the MsgBox line above, [a percent sign and a space](Language.htm#-expression) is used to change the parameter from legacy to expression mode. This is necessary because the legacy method is used by default by all commands, except where otherwise documented.

**Comparing variables**: Please read the expressions section below for important notes about the different kinds of comparisons, especially about when to use parentheses.

## Expressions

See [Expressions](Language.htm#expressions) for a structured overview and further explanation.

Expressions are used to perform one or more operations upon a series of variables, literal strings, and/or literal numbers.

Variable names in an expression are not enclosed in percent signs (except for [pseudo-arrays](misc/Arrays.htm#pseudo) and other [double references](#ref)). Consequently, literal strings must be enclosed in double quotes to distinguish them from variables. For example:

```
if (CurrentSetting > 100 or FoundColor != "Blue")
    MsgBox The setting is too high or the wrong color is present.
```

In the example above, "Blue" appears in quotes because it is a literal string. To include an _actual_ quote-character inside a literal string, specify two consecutive quotes as shown twice in this example: `"She said, <span class="red">""</span>An apple a day.<span class="red">""</span>"`.

**Note**: There are several types of [If Statement](Language.htm#if-statement) which look like expressions but are not.

**Empty strings**: To specify an empty string in an expression, use an empty pair of quotes. For example, the statement `if (MyVar != "")` would be true if _MyVar_ is not blank. However, in a [traditional-if](commands/IfEqual.htm), a pair of empty quotes is treated literally. For example, the statement `if MyVar = ""` is true only if _MyVar_ contains an actual pair of quotes. Thus, to check if a variable is blank with a traditional-if, use = or != with nothing on the right side as in this example: `if Var =`.

On a related note, any invalid expression such as `(x +* 3)` yields an empty string.

**Storing the result of an expression**: To assign a result to a variable, use the [:= operator](commands/SetExpression.htm). For example:

```
NetPrice := Price * (1 - Discount/100)
```

**Boolean values**: When an expression is required to evaluate to true or false (such as an IF-statement), a blank or zero result is considered false and all other results are considered true. For example, the statement `if ItemCount` would be false only if ItemCount is blank or 0. Similarly, the expression `if not ItemCount` would yield the opposite result.

Operators such as NOT/AND/OR/>/=/< automatically produce a true or false value: they yield 1 for true and 0 for false. For example, in the following expression, the variable _Done_ is assigned 1 if either of the conditions is true:

```
Done := A_Index > 5 or FoundIt
```

As hinted above, a variable can be used to hold a false value simply by making it blank or assigning 0 to it. To take advantage of this, the shorthand statement `if Done` can be used to check whether the variable Done is true or false.

The words _true_ and _false_ are built-in variables containing 1 and 0. They can be used to make a script more readable as in these examples:

```
CaseSensitive := false
ContinueSearch := true
```

**Integers and floating point**: Within an expression, numbers are considered to be floating point if they contain a decimal point; otherwise, they are integers. For most operators -- such as addition and multiplication -- if either of the inputs is a floating point number, the result will also be a floating point number.

Within expressions and non-expressions alike, integers may be written in either hexadecimal or decimal format. Hexadecimal numbers all start with the prefix 0x. For example, `Sleep 0xFF` is equivalent to `Sleep 255`. [v1.0.46.11+]: Floating point numbers written in scientific notation are recognized; but only if they contain a decimal point (e.g. `1<strong>.</strong>0e4` and `-2<strong>.</strong>1E-4`).

**Force an expression**: An expression can be used in a parameter that does not directly support it (except OutputVar parameters) by preceding the expression with a percent sign and a space or tab. In [v1.1.21+], this prefix can be used in the InputVar parameters of all commands except the traditional IF commands (use [If (expression)](commands/IfExpression.htm) instead). This technique is often used to access [arrays](misc/Arrays.htm). For example:

```
<a href="commands/FileAppend.htm" data-index="28">FileAppend</a>, % MyArray[i], My File.txt
<a href="commands/FileAppend.htm" data-index="29">FileAppend</a>, % MyPseudoArray%i%, My File.txt
<a href="commands/MsgBox.htm" data-index="30">MsgBox</a> % "The variable MyVar contains " . MyVar . "."
<a href="commands/Loop.htm" data-index="31">Loop</a> % Iterations + 1
<a href="commands/WinSet.htm" data-index="32">WinSet</a>, Transparent, % X + 100
<a href="commands/Control.htm" data-index="33">Control</a>, Choose, % CurrentSelection - 1
```

## Operators in Expressions

See [Operators](Language.htm#operators) for general information about operators.

Except where noted below, any blank value (empty string) or non-numeric value involved in a math operation is **not** assumed to be zero. Instead, it is treated as an error, which causes that part of the expression to evaluate to an empty string. For example, if the variable X is blank, the expression X+1 yields a blank value rather than 1.

For historical reasons, _quoted_ numeric strings such as `"123"` are always considered non-numeric when used directly in an expression (but not when stored in a variable or returned by a function). This non-numeric attribute is propagated by [concatenation](#concat), so expressions like `"0x" n` also produce a non-numeric value (even when n contains valid hexadecimal digits). This problem can be avoided by assigning the value to a variable or passing it through a function like [Round()](Functions.htm#Round). Scripts should avoid using quote marks around literal numbers, as the behavior may change in a future version.

### Expression Operators (in descending precedence order)

OperatorDescription%Var%

If a variable is enclosed in percent signs within an expression (e.g. %Var%), whatever that variable contains is assumed to be the name or partial name of another variable (if there is no such variable, %Var% resolves to a blank string). This is most commonly used to reference [pseudo-array](misc/Arrays.htm#pseudo) elements such as the following example:

```
Var := MyArray%A_Index% + 100
```

For backward compatibility, command parameters that are documented as "can be an expression" treat an isolated name in percent signs (e.g. %Var%, but not Array%i%) as though the percent signs are absent. This can be avoided by enclosing the reference in parentheses; e.g. `Sleep (%Var%)`.

[AHK\_L 52+]: In addition to normal variables, %Var% may resolve to an [environment variable](Concepts.htm#environment-variables), the clipboard, or any [reserved/read-only variable](#BuiltIn). Prior to revision 52, %Var% yielded an empty string in these cases.

x.y[AHK\_L 31+]: **Object access**. Get or set a value or call a method of object _x_, where _y_ is a literal value. See [object syntax](Objects.htm#Usage_Objects).new[v1.1.00+]: Creates a new object derived from another object. For example, `x := new y` is often equivalent to `x := {base: y}`. `new` should be followed by a variable or simple class name of the form `GlobalClass.NestedClass`, and optionally parameters as in `x := new y(z)` (where `y` is a variable, not a function name). For details, see [Custom Objects](Objects.htm#Custom_Objects).++

 --**Pre- and post-increment/decrement**. Adds or subtracts 1 from a variable (but in versions prior to 1.0.46, these can be used only by themselves on a line; no other operators may be present). The operator may appear either before or after the variable's name. If it appears _before_ the name, the operation is performed immediately and its result is used by the next operation. For example, `Var := ++X` increments X immediately and then assigns its value to _Var_. Conversely, if the operator appears _after_ the variable's name, the operation is performed _after_ the variable is used by the next operation. For example, `Var := X++` increments X only after assigning the current value of X to _Var_. Due to backward compatibility, the operators ++ and -- treat blank variables as zero, but only when they are alone on a line; for example, `y:=1, ++x` and `MsgBox % ++x` both produce a blank result when x is blank.\*\*

**Power**. Both the base and the exponent may contain a decimal point. If the exponent is negative, the result will be formatted as a floating point number even if the base and exponent are both integers. Since \*\* is of higher precedence than unary minus, `-2**2` is evaluated like `-(2**2)` and so yields -4. Thus, to raise a literal negative number to a power, enclose it in parentheses such as `(-2)**2`.

**Note**: A negative base combined with a fractional exponent such as `(-2)**0.5` is not supported; it will yield an empty string. But both `(-2)**2` and `(-2)**2.0` are supported.

**Note**: Unlike its mathematical counterpart, \*\* is left-associative in AutoHotkey v1. For example, `x ** y ** z` is evaluated as `(x ** y) ** z`.

-

 !

 ~

 & \*

**Unary minus (-)**: Although it uses the same symbol as the subtract operator, unary minus applies to only a single item or sub-expression as shown twice in this example: `<strong>-</strong>(3 / <strong>-</strong>x)`. On a related note, any unary plus signs (+) within an expression are ignored.

**Logical-not (!)**: If the operand is blank or 0, the result of applying logical-not is 1, which means "true". Otherwise, the result is 0 (false). For example: `!x or !(y and z)`. Note: The word NOT is synonymous with **!** except that **!** has a higher precedence. [v1.0.46+]: Consecutive unary operators such as `<strong>!!</strong>Var` are allowed because they are evaluated in right-to-left order.

**Bitwise-not (~)**: This inverts each bit of its operand. If the operand is a floating point value, it is truncated to an integer prior to the calculation. If the operand is between 0 and 4294967295 (0xffffffff), it will be treated as an unsigned 32-bit value. Otherwise, it is treated as a signed 64-bit value. For example, `~0xf0f` evaluates to 0xfffff0f0 (4294963440).

**Address (&)**: `&MyVar` retrieves the address of _MyVar_'s contents in memory, which is typically used with [DllCall structures](commands/DllCall.htm#struct). `&MyVar` also disables the caching of binary numbers in that variable, which can slow down its performance if it is ever used for math or numeric comparisons. Caching is re-enabled for a variable whenever its address changes (e.g. via [VarSetCapacity()](commands/VarSetCapacity.htm)).

**Dereference (\*)**: `*Expression` assumes that `Expression` resolves to a numeric memory address; it retrieves the byte at that address as a number between 0 and 255 (0 is always retrieved if the address is 0; but any other invalid address must be avoided because it might crash the script). However, [NumGet()](commands/NumGet.htm) generally performs much better when retrieving binary numbers.

\*

 /

 //


**Multiply (\*)**: The result is an integer if both inputs are integers; otherwise, it is a floating point number.

**True divide (/)**: Unlike [EnvDiv](commands/EnvDiv.htm), true division yields a floating point result even when both inputs are integers. For example, `3/2` yields 1.5 rather than 1, and `4/2` yields 2.0 rather than 2.

**Floor divide (//)**: The double-slash operator uses high-performance integer division if the two inputs are integers. For example, `5//3` is 1 and `5//-3` is -1. If either of the inputs is in floating point format, floating point division is performed and the result is truncated to the nearest integer to the left. For example, `5//3.0` is 1.0 and `5.0//-3` is -2.0. Although the result of this floating point division is an integer, it is stored in floating point format so that anything else that uses it will see it as such. For modulo, see [mod()](commands/Math.htm#Mod).

The [\*= and /= operators](#AssignOp) are a shorthand way to multiply or divide the value in a variable by another value. For example, `Var*=2` produces the same result as `Var:=Var*2` (though the former performs better).

Division by zero yields a blank result (empty string).

+

 -

**Add (+)** and **subtract (-)**. On a related note, the [+= and -= operators](#AssignOp) are a shorthand way to increment or decrement a variable. For example, `Var+=2` produces the same result as `Var:=Var+2` (though the former performs better). Similarly, a variable can be increased or decreased by 1 by using [Var++, Var--, ++Var, or --Var](#IncDec).

<<

 >>**Bit shift left (<<)** and **right (>>)**. Example usage: `Value1 << Value2`. Any floating point input is truncated to an integer prior to the calculation. Shift left ( **<<**) is equivalent to multiplying _Value1_ by "2 to the _Value2_ th power". Shift right ( **>>**) is equivalent to dividing _Value1_ by "2 to the _Value2_ th power" and rounding the result to the nearest integer leftward on the number line; for example, `-3>>1` is -2.&

 ^

 \|
 **Bitwise-and (&)**, **bitwise-exclusive-or (^)**, and **bitwise-or (\|)**. Of the three, **&** has the highest precedence and **\|** has the lowest. Any floating point input is truncated to an integer prior to the calculation..

**Concatenate**. The period (dot) operator is used to combine two items into a single string (there must be at least one space on each side of the period). You may also omit the period to achieve the same result (except where ambiguous such as `x <strong>-</strong>y`, or when the item on the right side has a leading ++ or --). When the dot is omitted, there should be at least one space between the items to be merged.

Example (expression method): `Var := "The color is " <strong>.</strong> FoundColor`

Example (traditional method): `Var = The color is %FoundColor%`

Sub-expressions can also be concatenated. For example: `Var := "The net price is " <strong>.</strong>  Price * (1 - Discount/100)`.

A line that begins with a period (or any other operator) is automatically [appended to](Scripts.htm#continuation) the line above it.

~=[AHK\_L 31+]: Shorthand for [RegExMatch()](commands/RegExMatch.htm). For example, `"abc123" ~= "\d"` sets ErrorLevel to 0 and yields 4 (the position of the first numeric character). Prior to [v1.1.03], this operator had the same precedence as the _equal_ (=) operator and was not fully documented.>   <

 >= <=

**Greater (>)**, **less (<)**, **greater-or-equal (>=)**, and **less-or-equal (<=)**. If both inputs are [numbers](Concepts.htm#numbers) or [numeric strings](Concepts.htm#numeric-strings), they are compared numerically; otherwise they are compared alphabetically. The comparison is case sensitive only if [StringCaseSense](commands/StringCaseSense.htm) has been turned on. See also: [Sort](commands/Sort.htm)

**Note**: In AutoHotkey v1, a quoted string (or the result of concatenating with a quoted string) is never considered numeric when used directly in an expression.

=

 ==

 <\> !=

**Equal (=)**, **case-sensitive-equal (==)**, and **not-equal (<> or !=)**. If both inputs are [numbers](Concepts.htm#numbers) or [numeric strings](Concepts.htm#numeric-strings), they are compared numerically; otherwise they are compared alphabetically. The operators **!=** and **<>** are identical in function. The **==** operator behaves identically to **=** except when either of the inputs is not numeric, in which case **==** is always case sensitive and **=** is always case insensitive (the method of insensitivity depends on [StringCaseSense](commands/StringCaseSense.htm)). By contrast, **<>** and **!=** obey [StringCaseSense](commands/StringCaseSense.htm).

**Note**: In AutoHotkey v1, a quoted string (or the result of concatenating with a quoted string) is never considered numeric when used directly in an expression.

**Deprecated:** The <> operator is not recommended for use in new scripts. Use the != operator instead.

NOT**Logical-NOT**. Except for its lower precedence, this is the same as the **!** operator. For example, `not (x = 3 or y = 3)` is the same as `<strong>!</strong>(x = 3 or y = 3)`.AND

 &&Both of these are **logical-AND**. For example: `x > 3 and x < 10`. To enhance performance, [short-circuit evaluation](Functions.htm#ShortCircuit) is applied. Also, a line that begins with AND/OR/&&/\|\| (or any other operator) is automatically [appended to](Scripts.htm#continuation) the line above it.OR

 \|\|Both of these are **logical-OR**. For example: `x <= 3 or x >= 10`. To enhance performance, [short-circuit evaluation](Functions.htm#ShortCircuit) is applied.?:**Ternary operator**[v1.0.46+]. This operator is a shorthand replacement for the [if-else statement](commands/IfExpression.htm). It evaluates the condition on its left side to determine which of its two branches should become its final result. For example, `var := x>y ? 2 : 3` stores 2 in _Var_ if x is greater than y; otherwise it stores 3. To enhance performance, only the winning branch is evaluated (see [short-circuit evaluation](Functions.htm#ShortCircuit)).:=

 +=

 -=

 \*=

 /=

 //=

 .=

 \|=

 &=

 ^=

 >>=

 <<=


**Assign**. Performs an operation on the contents of a variable and stores the result back in the same variable (but in versions prior to 1.0.46, these could only be used as the leftmost operator on a line, and only the first five operators were supported). The simplest assignment operator is [colon-equals (:=)](commands/SetExpression.htm), which stores the result of an expression in a variable. For a description of what the other operators do, see their related entries in this table. For example, `Var //= 2` performs [floor division](#FloorDivide) to divide _Var_ by 2, then stores the result back in _Var_. Similarly, `Var <strong>.=</strong> "abc"` is a shorthand way of writing `Var := Var <strong>.</strong> "abc"`.

Unlike most other operators, assignments are evaluated from right to left. Consequently, a line such as `Var1 := Var2 := 0` first assigns 0 to _Var2_ then assigns _Var2_ to _Var1_.

If an assignment is used as the input for some other operator, its value is the variable itself. For example, the expression `(Var+=2) > 50` is true if the newly-increased value in _Var_ is greater than 50. This also allows an assignment to be passed [ByRef](Functions.htm#ByRef), or its [address](#amp) taken; for example: `&(x:="abc")`.

The precedence of the assignment operators is automatically raised when it would avoid a syntax error or provide more intuitive behavior. For example: `not x:=y` is evaluated as `not (x:=y)`. Similarly, `++Var := X` is evaluated as `++(Var := X)`; and `Z>0 ? X:=2 : Y:=2` is evaluated as `Z>0 ? (X:=2) : (Y:=2)`.

Known limitations caused by backward compatibility (these may be resolved in a future release): 1) When **/=** is the leftmost operator in an expression and it is not part of a [multi-statement expression](#comma), it performs [floor division](#FloorDivide) unless one of the inputs is floating point (in all other cases, **/=** performs [true division](#divide)); 2) [Date/time math](commands/EnvAdd.htm) is supported by **+=** and **-=** only when that operator is the leftmost one on a line; 3) The operators **+=**, **-=**, and **\*=** treat blank variables as zero, but only when they are alone on a line; for example, `y:=1, x+=1` and `MsgBox % x-=3` both produce a blank result when x is blank.

,

**Comma (multi-statement)**[v1.0.46+]. Commas may be used to write multiple sub-expressions on a single line. This is most commonly used to group together multiple assignments or function calls. For example: `x:=1<strong>,</strong> y+=2<strong>,</strong> ++index, MyFunc()`. Such statements are executed in order from left to right.

**Note**: A line that begins with a comma (or any other operator) is automatically [appended to](Scripts.htm#continuation) the line above it. See also: [comma performance](#CommaPerf).

[v1.0.46.01+]: When a comma is followed immediately by a variable and an equal sign, that equal sign is automatically treated as an [assignment (:=)](commands/SetExpression.htm). For example, all of the following are assignments: `x:=1, y=2, a=b=c`. New scripts should not rely on this behavior as it may change. The rule applies only to plain variables and not [double-derefs](#ref), so the following contains only one assignment: `x:=1, %y%=2`

The following types of sub-expressions override precedence/order of evaluation:

ExpressionDescription**(** _expression_ **)**

Any sub-expression enclosed in parentheses. For example, `(3 + 2) * 2` forces `3 + 2` to be evaluated first.

**mod()

round()

abs()**

**Function call**. The function name must be immediately followed by an open-parenthesis, without any spaces or tabs in between. For details, see [Functions](Functions.htm).

**%** _func_ **%()**

See [Dynamically Calling a Function](Functions.htm#DynCall)._func_ **.()**

**Deprecated:** This syntax is not recommended for use. Use `%func%()` (for function names and objects) or `func.Call()` (for function objects) instead.

[AHK\_L 48+]: Attempts to call an empty-named method of the object _func_. By convention, this is the object's "default" method. If _func_ does not contain an object, the [default base object](Objects.htm#Default_Base_Object) is invoked instead.

[v1.0.95+]: If _func_ contains a function name, the named function is called.

Fn( **_Params_\***)

[AHK\_L 60+]: [Variadic function call](Functions.htm#VariadicCall). _Params_ is an array (object) containing parameter values.

**x[y]

[a, b, c]**

[AHK\_L 31+]: **Member access**. Get or set a value or call a method of object _x_, where _y_ is a parameter list (typically an array index or key) or an expression which returns a method name.

[v1.0.97+]: **Array literal**. If the open-bracket is not preceded by a value (or a sub-expression which yields a value), it is interpreted as the beginning of an array literal. For example, `[a, b, c]` is equivalent to `Array(a, b, c)` (a, b and c are variables).

See [array syntax](Objects.htm#Usage_Simple_Arrays) and [object syntax](Objects.htm#Usage_Objects) for more details.

**{a: b, c: d}**

[v1.0.97+]: **Object literal**. Create an object or associative array. For example, `x := {a: b}` is equivalent to `x := Object("a", b)` or `x := Object(), x.a := b`. See [Associative Arrays](Objects.htm#Usage_Associative_Arrays) for details.

**Performance**: [v1.0.48+]: The comma operator is usually faster than writing separate expressions, especially when assigning one variable to another (e.g. `x:=y, a:=b`). Performance continues to improve as more and more expressions are combined into a single expression; for example, it may be 35% faster to combine five or ten simple expressions into a single expression.

## Built-in Variables

The variables below are built into the program and can be referenced by any script.

See [Built-in Variables](Concepts.htm#built-in-variables) for general information.

### Table of Contents

- Special Characters:[A\_Space](#Space), [A\_Tab](#Tab)
- Script Properties:[command line parameters](#CommandLine), [A\_WorkingDir](#WorkingDir), [A\_ScriptDir](#ScriptDir), [A\_ScriptName](#ScriptName), [(...more...)](#prop)
- Date and Time:[A\_YYYY](#YYYY), [A\_MM](#MM), [A\_DD](#DD), [A\_Hour](#Hour), [A\_Min](#Min), [A\_Sec](#Sec), [(...more...)](#date)
- Script Settings:[A\_IsSuspended](#IsSuspended), [A\_BatchLines](#BatchLines), [A\_ListLines](#ListLines), [A\_TitleMatchMode](#TitleMatchMode), [(...more...)](#settings)
- User Idle Time:[A\_TimeIdle](#TimeIdle), [A\_TimeIdlePhysical](#TimeIdlePhysical), [A\_TimeIdleKeyboard](#TimeIdleKeyboard), [A\_TimeIdleMouse](#TimeIdleMouse)
- GUI Windows and Menu Bars:[A\_Gui](#Gui), [A\_GuiControl](#GuiControl), [A\_GuiEvent](#GuiEvent), [A\_EventInfo](#EventInfo), [(...more...)](#gui)
- Hotkeys, Hotstrings, and Custom Menu Items:[A\_ThisHotkey](#ThisHotkey), [A\_EndChar](#EndChar), [A\_ThisMenuItem](#ThisMenuItem), [(...more...)](#h)
- Operating System and User Info:[A\_OSVersion](#OSVersion), [A\_ScreenWidth](#Screen), [A\_ScreenHeight](#Screen), [(...more...)](#os)
- Misc:[A\_Cursor](#Cursor), [A\_CaretX](#Caret), [A\_CaretY](#Caret), [Clipboard](#Clipboard), [ClipboardAll](#ClipboardAll), [ErrorLevel](#ErrorLevel), [(...more...)](#misc)
- Loop:[A\_Index](#Index), [(...more...)](#loop)

### Special Characters

VariableDescriptionA\_SpaceThis variable contains a single space character. See [AutoTrim](commands/AutoTrim.htm) for details.A\_TabThis variable contains a single tab character. See [AutoTrim](commands/AutoTrim.htm) for details.

### Script Properties

VariableDescription1, 2, 3, etc.These variables are automatically created whenever a script is launched with command line parameters. They can be changed and referenced just like normal variable names (for example: %1%), but cannot be referenced directly in an [expression](#Expressions). The variable %0% contains the number of parameters passed (0 if none). For details, see the [command line parameters](Scripts.htm#cmd).A\_Args

[v1.1.27+]Contains an [array](Objects.htm#Usage_Simple_Arrays) of command line parameters. For details, see [Passing Command Line Parameters to a Script](Scripts.htm#cmd).A\_WorkingDirThe script's current working directory, which is where files will be accessed by default. The final backslash is not included unless it is the root directory. Two examples: C:\ and C:\\My Documents. Use [SetWorkingDir](commands/SetWorkingDir.htm) to change the working directory.A\_ScriptDirThe full path of the directory where the current script is located. The final backslash is omitted (even for root directories).A\_ScriptName

The file name of the current script, without its path, e.g. MyScript.ahk

If the script is [compiled](Scripts.htm#ahk2exe) or [embedded](Program.htm#embedded-scripts), this is the name of the current executable file.

A\_ScriptFullPath

The full path of the current script, e.g. C:\\Scripts\\My Script.ahk

If the script is [compiled](Scripts.htm#ahk2exe) or [embedded](Program.htm#embedded-scripts), this is the full path of the current executable file.

A\_ScriptHwnd

[v1.1.01+]The unique ID (HWND/handle) of the script's hidden [main window](Program.htm#main-window).A\_LineNumber

The number of the currently executing line within the script (or one of its [#Include files](commands/_Include.htm)). This line number will match the one shown by [ListLines](commands/ListLines.htm); it can be useful for error reporting such as this example: `MsgBox Could not write to log file (line number %A_LineNumber%)`.

Since a [compiled script](Scripts.htm#ahk2exe) has merged all its [#Include files](commands/_Include.htm) into one big script, its line numbering may be different than when it is run in non-compiled mode.

A\_LineFile

The full path and name of the file to which [A\_LineNumber](#LineNumber) belongs. If the script was loaded from an external file, this is the same as [A\_ScriptFullPath](#ScriptFullPath) unless the line belongs to one of the script's [#Include files](commands/_Include.htm).

If the script was [compiled](Scripts.htm#ahk2exe) based on a [.bin file](Scripts.htm#ahk2exe-base), this is the full path and name of the current executable file, the same as [A\_ScriptFullPath](#ScriptFullPath).

[v1.1.34+]: If the script is [embedded](Program.htm#embedded-scripts), A\_LineFile contains an asterisk (\*) followed by the resource name; e.g. \*#1

A\_ThisFunc

[v1.0.46.16+]The name of the [user-defined function](Functions.htm) that is currently executing (blank if none); for example: MyFunction. See also: [IsFunc()](commands/IsFunc.htm)A\_ThisLabel

[v1.0.46.16+]The name of the [label](misc/Labels.htm) (subroutine) that is currently executing (blank if none); for example: MyLabel. It is updated whenever the script executes [Gosub](commands/Gosub.htm)/ [Return](commands/Return.htm) or [Goto](commands/Goto.htm). It is also updated for automatically-called labels such as [timers](commands/SetTimer.htm), [GUI threads](commands/Gui.htm#DefaultWin), [menu items](commands/Menu.htm), [hotkeys](Hotkeys.htm), [hotstrings](Hotstrings.htm), [OnClipboardChange labels](commands/OnClipboardChange.htm#label), and [OnExit labels](commands/OnExit.htm#command). However, A\_ThisLabel is not updated when execution "falls into" a label from above; when that happens, A\_ThisLabel retains its previous value. See also: [A\_ThisHotkey](#ThisHotkey) and [IsLabel()](commands/IsLabel.htm)A\_AhkVersionIn versions prior to 1.0.22, this variable is blank. Otherwise, it contains the version of AutoHotkey that is running the script, such as 1.0.22. In the case of a [compiled script](Scripts.htm#ahk2exe), the version that was originally used to compile it is reported. The formatting of the version number allows a script to check whether A\_AhkVersion is greater than some minimum version number with > or >= as in this example: `if A_AhkVersion >= 1.0.25.07`.A\_AhkPath

For non-compiled or [embedded](Program.htm#embedded-scripts) scripts: The full path and name of the EXE file that is actually running the current script. For example: C:\\Program Files\\AutoHotkey\\AutoHotkey.exe

For [compiled scripts](Scripts.htm#ahk2exe) based on a [.bin file](Scripts.htm#ahk2exe-base), the value is determined by reading the installation directory from the registry and appending "\\AutoHotkey.exe". If AutoHotkey is not installed, the value is blank. The example below is equivalent:

```
RegRead InstallDir, HKLM\SOFTWARE\AutoHotkey, InstallDir
AhkPath := ErrorLevel ? "" : InstallDir "\AutoHotkey.exe"
```

[v1.1.34+]: For compiled scripts based on an .exe file, A\_AhkPath contains the full path of the compiled script. This can be used in combination with [/script](Scripts.htm#SlashScript) to execute external scripts. To instead locate the installed copy of AutoHotkey, read the registry as shown above.

A\_IsUnicode

Contains 1 if strings are Unicode (16-bit) and an empty string (which is considered [false](#Boolean)) if strings are ANSI (8-bit). The format of strings depends on the version of AutoHotkey.exe which is used to run the script, or if it is compiled, which bin file was used to compile it.

For ANSI executables prior to [v1.1.06], A\_IsUnicode was left undefined; that is, the script could assign to it, and attempting to read it could trigger a [UseUnsetGlobal warning](commands/_Warn.htm). In later versions it is always defined and is read-only.

A\_IsCompiled

Contains 1 if the script is running as a [compiled EXE](Scripts.htm#ahk2exe) and an empty string (which is considered [false](#Boolean)) if it is not.

For non-compiled scripts prior to [v1.1.06], A\_IsCompiled was left undefined; that is, the script could assign to it, and attempting to read it could trigger a [UseUnsetGlobal warning](commands/_Warn.htm). In later versions it is always defined and is read-only.

A\_ExitReasonThe most recent reason the script was asked to terminate. This variable is blank unless the script has an [OnExit](commands/OnExit.htm#command) subroutine and that subroutine is currently running or has been called at least once by an exit attempt. See [OnExit](commands/OnExit.htm#command) for details.

### Date and Time

VariableDescriptionA\_YYYY

Current 4-digit year (e.g. 2004). Synonymous with A\_Year.

**Note**: To retrieve a formatted time or date appropriate for your locale and language, use `<a href="commands/FormatTime.htm" data-index="180">FormatTime</a>, OutputVar` (time and long date) or `<a href="commands/FormatTime.htm" data-index="181">FormatTime</a>, OutputVar,, LongDate` (retrieves long-format date).

A\_MMCurrent 2-digit month (01-12). Synonymous with A\_Mon.A\_DDCurrent 2-digit day of the month (01-31). Synonymous with A\_MDay.A\_MMMMCurrent month's full name in the current user's language, e.g. JulyA\_MMMCurrent month's abbreviation in the current user's language, e.g. JulA\_DDDDCurrent day of the week's full name in the current user's language, e.g. SundayA\_DDDCurrent day of the week's abbreviation in the current user's language, e.g. SunA\_WDayCurrent 1-digit day of the week (1-7). 1 is Sunday in all locales.A\_YDayCurrent day of the year (1-366). The value is not zero-padded, e.g. 9 is retrieved, not 009. To retrieve a zero-padded value, use the following: `<a href="commands/FormatTime.htm" data-index="182">FormatTime</a>, OutputVar,, YDay0`.A\_YWeekCurrent year and week number (e.g. 200453) according to ISO 8601. To separate the year from the week, use `Year := <a href="commands/SubStr.htm" data-index="183">SubStr</a>(A_YWeek, 1, 4)` and `Week := <a href="commands/SubStr.htm" data-index="184">SubStr</a>(A_YWeek, -1)`. Precise definition of A\_YWeek: If the week containing January 1st has four or more days in the new year, it is considered week 1. Otherwise, it is the last week of the previous year, and the next week is week 1.A\_HourCurrent 2-digit hour (00-23) in 24-hour time (for example, 17 is 5pm). To retrieve 12-hour time as well as an AM/PM indicator, follow this example: `<a href="commands/FormatTime.htm" data-index="185">FormatTime</a>, OutputVar, , h:mm:ss tt`A\_Min

Current 2-digit minute (00-59).

A\_SecCurrent 2-digit second (00-59).A\_MSecCurrent 3-digit millisecond (000-999). To remove the leading zeros, follow this example: `Milliseconds := A_MSec + 0`.A\_Now

The current local time in [YYYYMMDDHH24MISS](commands/FileSetTime.htm#YYYYMMDD) format.

**Note**: Date and time math can be performed with [EnvAdd](commands/EnvAdd.htm) and [EnvSub](commands/EnvSub.htm). Also, [FormatTime](commands/FormatTime.htm) can format the date and/or time according to your locale or preferences.

A\_NowUTCThe current Coordinated Universal Time (UTC) in [YYYYMMDDHH24MISS](commands/FileSetTime.htm#YYYYMMDD) format. UTC is essentially the same as Greenwich Mean Time (GMT).A\_TickCount

The number of milliseconds that have elapsed since the system was started, up to 49.7 days. By storing A\_TickCount in a variable, elapsed time can later be measured by subtracting that variable from the latest A\_TickCount value. For example:

```
StartTime := A_TickCount
Sleep, 1000
ElapsedTime := A_TickCount - StartTime
MsgBox,  %ElapsedTime% milliseconds have elapsed.
```

If you need more precision than A\_TickCount's 10ms, use [QueryPerformanceCounter()](commands/DllCall.htm#QPC).

### Script Settings

VariableDescriptionA\_IsSuspendedContains 1 if the script is [suspended](commands/Suspend.htm) and 0 otherwise.A\_IsPaused

[v1.0.48+]Contains 1 if the [thread](misc/Threads.htm) immediately underneath the current thread is [paused](commands/Pause.htm). Otherwise it contains 0.A\_IsCritical

[v1.0.48+]Contains 0 if [Critical](commands/Critical.htm) is off for the [current thread](misc/Threads.htm). Otherwise it contains an integer greater than zero, namely the [message-check frequency](commands/Critical.htm#Interval) being used by Critical. Since `Critical 0` turns off critical, the current state of Critical can be saved and restored via `Old_IsCritical := A_IsCritical` followed later by `Critical %Old_IsCritical%`.A\_BatchLines(synonymous with A\_NumBatchLines) The current value as set by [SetBatchLines](commands/SetBatchLines.htm). Examples: 200 or 10ms (depending on format).A\_ListLines

[v1.1.28+]Contains 1 if [ListLines](commands/ListLines.htm) is enabled. Otherwise it contains 0.A\_TitleMatchModeThe current mode set by [SetTitleMatchMode](commands/SetTitleMatchMode.htm): 1, 2, 3, or RegEx.A\_TitleMatchModeSpeedThe current match speed (fast or slow) set by [SetTitleMatchMode](commands/SetTitleMatchMode.htm).A\_DetectHiddenWindowsThe current mode (On or Off) set by [DetectHiddenWindows](commands/DetectHiddenWindows.htm).A\_DetectHiddenTextThe current mode (On or Off) set by [DetectHiddenText](commands/DetectHiddenText.htm).A\_AutoTrimThe current mode (On or Off) set by [AutoTrim](commands/AutoTrim.htm).A\_StringCaseSenseThe current mode (On, Off, or Locale) set by [StringCaseSense](commands/StringCaseSense.htm).A\_FileEncoding[AHK\_L 46+]: Contains the default encoding for various commands; see [FileEncoding](commands/FileEncoding.htm).A\_FormatIntegerThe current integer format (H or D) set by [SetFormat](commands/SetFormat.htm). [AHK\_L 42+]: This may also contain lower-case h.A\_FormatFloatThe current floating point number format set by [SetFormat](commands/SetFormat.htm).A\_SendMode[v1.1.23+]: The current mode (Event, Input, Play or InputThenPlay) set by [SendMode](commands/SendMode.htm).A\_SendLevel[v1.1.23+]: The current [SendLevel](commands/SendLevel.htm) setting (an integer between 0 and 100, inclusive).A\_StoreCapsLockMode[v1.1.23+]: The current mode (On or Off) set by [SetStoreCapsLockMode](commands/SetStoreCapslockMode.htm).A\_KeyDelay

 A\_KeyDurationThe current delay or duration set by [SetKeyDelay](commands/SetKeyDelay.htm) (always decimal, not hex). A\_KeyDuration requires [v1.1.23+].A\_KeyDelayPlay

 A\_KeyDurationPlayThe current delay or duration set by [SetKeyDelay](commands/SetKeyDelay.htm) for the [SendPlay](commands/Send.htm#SendPlayDetail) mode (always decimal, not hex). Requires [v1.1.23+].A\_WinDelayThe current delay set by [SetWinDelay](commands/SetWinDelay.htm) (always decimal, not hex).A\_ControlDelayThe current delay set by [SetControlDelay](commands/SetControlDelay.htm) (always decimal, not hex).A\_MouseDelay

 A\_MouseDelayPlayThe current delay set by [SetMouseDelay](commands/SetMouseDelay.htm) (always decimal, not hex). A\_MouseDelay is for the traditional SendEvent mode, whereas A\_MouseDelayPlay is for [SendPlay](commands/Send.htm#SendPlayDetail). A\_MouseDelayPlay requires [v1.1.23+].A\_DefaultMouseSpeedThe current speed set by [SetDefaultMouseSpeed](commands/SetDefaultMouseSpeed.htm) (always decimal, not hex).A\_CoordModeToolTip

 A\_CoordModePixel

 A\_CoordModeMouse

 A\_CoordModeCaret

 A\_CoordModeMenu[v1.1.23+]: The current mode (Window, Client or Screen) set by [CoordMode](commands/CoordMode.htm).A\_RegView[v1.1.08+]: The current registry view as set by [SetRegView](commands/SetRegView.htm).A\_IconHiddenContains 1 if the [tray icon](Program.htm#tray-icon) is currently hidden or 0 otherwise. The icon can be hidden via [#NoTrayIcon](commands/_NoTrayIcon.htm) or the [Menu](commands/Menu.htm) command.A\_IconTipBlank unless a custom tooltip for the [tray icon](Program.htm#tray-icon) has been specified via `<a href="commands/Menu.htm" data-index="226">Menu</a>, Tray, Tip` \-\- in which case it's the text of the tip.A\_IconFileBlank unless a custom [tray icon](Program.htm#tray-icon) has been specified via `<a href="commands/Menu.htm" data-index="228">Menu</a>, tray, icon` \-\- in which case it's the full path and name of the icon's file.A\_IconNumberBlank if A\_IconFile is blank. Otherwise, it's the number of the icon in A\_IconFile (typically 1).

### User Idle Time

VariableDescriptionA\_TimeIdleThe number of milliseconds that have elapsed since the system last received keyboard, mouse, or other input. This is useful for determining whether the user is away. Physical input from the user as well as artificial input generated by **any** program or script (such as the [Send](commands/Send.htm) or [MouseMove](commands/MouseMove.htm) commands) will reset this value back to zero. Since this value tends to increase by increments of 10, do not check whether it is equal to another value. Instead, check whether it is greater or less than another value. For example: `IfGreater, A_TimeIdle, 600000, MsgBox, The last keyboard or mouse activity was at least 10 minutes ago`.A\_TimeIdlePhysicalSimilar to above but ignores artificial keystrokes and/or mouse clicks whenever the corresponding hook ( [keyboard](commands/_InstallKeybdHook.htm) or [mouse](commands/_InstallMouseHook.htm)) is installed; that is, it responds only to physical events. (This prevents simulated keystrokes and mouse clicks from falsely indicating that a user is present.) If neither hook is installed, this variable is equivalent to A\_TimeIdle. If only one hook is installed, only its type of physical input affects A\_TimeIdlePhysical (the other/non-installed hook's input, both physical and artificial, has no effect).A\_TimeIdleKeyboard

[v1.1.28+]If the [keyboard hook](commands/_InstallKeybdHook.htm) is installed, this is the number of milliseconds that have elapsed since the system last received physical keyboard input. Otherwise, this variable is equivalent to A\_TimeIdle.A\_TimeIdleMouse

[v1.1.28+]If the [mouse hook](commands/_InstallMouseHook.htm) is installed, this is the number of milliseconds that have elapsed since the system last received physical mouse input. Otherwise, this variable is equivalent to A\_TimeIdle.

### GUI Windows and Menu Bars

VariableDescriptionA\_DefaultGui [v1.1.23+]The name or number of the current thread's [default GUI](commands/Gui.htm#Default).A\_DefaultListView [v1.1.23+]The [variable name](commands/Gui.htm#Events) or [HWND](commands/Gui.htm#HwndOutputVar) of the [ListView control](commands/ListView.htm) upon which the [ListView functions](commands/ListView.htm#BuiltIn) operate. If the default GUI lacks a ListView, this variable is blank.A\_DefaultTreeView [v1.1.23+]The [variable name](commands/Gui.htm#Events) or [HWND](commands/Gui.htm#HwndOutputVar) of the [TreeView control](commands/TreeView.htm) upon which the [TreeView functions](commands/TreeView.htm#BuiltIn) operate. If the default GUI lacks a TreeView, this variable is blank.A\_GuiThe name or number of the [GUI](commands/Gui.htm) that launched the [current thread](misc/Threads.htm). This variable is blank unless a Gui control, menu bar item, or event such as GuiClose/GuiEscape launched the current thread.A\_GuiControlThe name of the variable associated with the GUI control that launched the [current thread](misc/Threads.htm). If that control lacks an [associated variable](commands/Gui.htm#Events), A\_GuiControl instead contains the first 63 characters of the control's text/caption (this is most often used to avoid giving each button a variable name). A\_GuiControl is blank whenever: 1) A\_Gui is blank; 2) a GUI menu bar item or event such as GuiClose/GuiEscape launched the current thread; 3) the control lacks an associated variable and has no caption; or 4) The control that originally launched the current thread no longer exists (perhaps due to [Gui Destroy](commands/Gui.htm#Destroy)).A\_GuiWidth

 A\_GuiHeightThese contain the GUI window's width and height when referenced in a [GuiSize subroutine](commands/Gui.htm#GuiSize). They apply to the window's client area, which is the area excluding title bar, menu bar, and borders. [v1.1.11+]: These values are affected by [DPI scaling](commands/Gui.htm#DPIScale).A\_GuiX

 A\_GuiYThese contain the X and Y coordinates for [GuiContextMenu](commands/Gui.htm#GuiContextMenu) and [GuiDropFiles](commands/Gui.htm#GuiDropFiles) events. Coordinates are relative to the upper-left corner of the window. [v1.1.11+]: These values are affected by [DPI scaling](commands/Gui.htm#DPIScale).A\_GuiEvent

or A\_GuiControlEvent

The type of event that launched the [current thread](misc/Threads.htm). If the thread was not launched via [GUI action](commands/Gui.htm), this variable is blank. Otherwise, it contains one of the following strings:

**Normal**: The event was triggered by a single left-click or via keystrokes (↑, →, ↓, ←, Tab, Space, underlined shortcut key, etc.). This value is also used for menu bar items and the special events such as GuiClose and GuiEscape.

**DoubleClick**: The event was triggered by a double-click. Note: The first click of the click-pair will still cause a _Normal_ event to be received first. In other words, the subroutine will be launched twice: once for the first click and again for the second.

**RightClick**: Occurs only for [GuiContextMenu](commands/Gui.htm#GuiContextMenu), [ListViews](commands/ListView.htm), and [TreeViews](commands/TreeView.htm).

**Context-sensitive values:** For details see [GuiContextMenu](commands/Gui.htm#GuiContextMenu), [GuiDropFiles](commands/Gui.htm#GuiDropFiles), [Slider](commands/GuiControls.htm#Slider), [MonthCal](commands/GuiControls.htm#MonthCal), [ListView](commands/ListView.htm), and [TreeView](commands/TreeView.htm).

A\_EventInfo

Contains additional information about the following events:

- The[OnClipboardChange label](commands/OnClipboardChange.htm#label)
- [Mouse wheel hotkeys](Hotkeys.htm#Wheel) (WheelDown/Up/Left/Right)
- [OnMessage()](commands/OnMessage.htm)
- [RegisterCallback()](commands/RegisterCallback.htm)
- [Regular Expression Callouts](misc/RegExCallout.htm)
- [GUI events](commands/Gui.htm#label), namely [GuiContextMenu](commands/Gui.htm#GuiContextMenu), [GuiDropFiles](commands/Gui.htm#GuiDropFiles), [ListBox](commands/GuiControls.htm#ListBox), [ListView](commands/ListView.htm), [TreeView](commands/TreeView.htm), and [StatusBar](commands/GuiControls.htm#StatusBar). If there is no additional information for an event, A\_EventInfo contains 0.

**Note**: Unlike variables such as A\_ThisHotkey, each [thread](misc/Threads.htm) retains its own value for A\_Gui, A\_GuiControl, A\_GuiX/Y, A\_GuiEvent, and A\_EventInfo. Therefore, if a thread is interrupted by another, upon being resumed it will still see its original/correct values in these variables.

### Hotkeys, Hotstrings, and Custom Menu Items

VariableDescriptionA\_ThisMenuItemThe name of the most recently selected [custom menu item](commands/Menu.htm) (blank if none).A\_ThisMenuThe name of the menu from which A\_ThisMenuItem was selected.A\_ThisMenuItemPosA number indicating the current position of A\_ThisMenuItem within A\_ThisMenu. The first item in the menu is 1, the second is 2, and so on. Menu separator lines are counted. This variable is blank if A\_ThisMenuItem is blank or no longer exists within A\_ThisMenu. It is also blank if A\_ThisMenu itself no longer exists.A\_ThisHotkey

The most recently executed [hotkey](Hotkeys.htm) or [non-auto-replace hotstring](Hotstrings.htm) (blank if none), e.g. #z. This value will change if the [current thread](misc/Threads.htm) is interrupted by another hotkey, so be sure to copy it into another variable immediately if you need the original value for later use in a subroutine.

When a hotkey is first created -- either by the [Hotkey command](commands/Hotkey.htm) or a [double-colon label](Hotkeys.htm) in the script -- its key name and the ordering of its modifier symbols becomes the permanent name of that hotkey, shared by all [variants](commands/_IfWinActive.htm#variant) of the hotkey.

When a hotstring is first created, the exact text used to create it becomes the permanent name of the hotstring.

See also: [A\_ThisLabel](#ThisLabel)

A\_PriorHotkeySame as above except for the previous hotkey. It will be blank if none.A\_PriorKey[v1.1.01+]: The name of the last key which was pressed prior to the most recent key-press or key-release, or blank if no applicable key-press can be found in the key history. All input generated by AutoHotkey scripts is excluded. For this variable to be of use, the [keyboard](commands/_InstallKeybdHook.htm) or [mouse hook](commands/_InstallMouseHook.htm) must be installed and [key history](commands/KeyHistory.htm) must be enabled.A\_TimeSinceThisHotkeyThe number of milliseconds that have elapsed since A\_ThisHotkey was pressed. It will be -1 whenever A\_ThisHotkey is blank.A\_TimeSincePriorHotkeyThe number of milliseconds that have elapsed since A\_PriorHotkey was pressed. It will be -1 whenever A\_PriorHotkey is blank.A\_EndCharThe [ending character](Hotstrings.htm#EndChars) that was pressed by the user to trigger the most recent [non-auto-replace hotstring](Hotstrings.htm). If no ending character was required (due to the \* option), this variable will be blank.

### Operating System and User Info

VariableDescriptionComSpec [v1.0.43.08+]

 A\_ComSpec [v1.1.28+]

Contains the same string as the environment's ComSpec variable. Often used with [Run/RunWait](commands/Run.htm). For example:

```
C:\Windows\system32\cmd.exe
```

A\_Temp

[v1.0.43.09+]

The full path and name of the folder designated to hold temporary files. It is retrieved from one of the following locations (in order): 1) the [environment variables](Concepts.htm#environment-variables) TMP, TEMP, or USERPROFILE; 2) the Windows directory. For example:

```
C:\Users\<UserName>\AppData\Local\Temp
```

A\_OSTypeThe type of operating system being run. Since AutoHotkey 1.1 only supports NT-based operating systems, this is always WIN32\_NT. Older versions of AutoHotkey return WIN32\_WINDOWS when run on Windows 95/98/ME.A\_OSVersion

One of the following strings, if appropriate: WIN\_7 [requires AHK\_L 42+], WIN\_8 [requires v1.1.08+], WIN\_8.1 [requires v1.1.15+], WIN\_VISTA, WIN\_2003, WIN\_XP, WIN\_2000.

Applying compatibility settings in the AutoHotkey executable or compiled script's properties causes the OS to report a different version number, which is reflected by A\_OSVersion.

[v1.1.20+]: If the OS version is not recognized as one of those listed above, a string in the format "major.minor.build" is returned. For example, `10.0.14393` is Windows 10 build 14393, also known as version 1607.

```
<em>; This example is obsolete as these operating systems are no longer supported.</em>
if A_OSVersion in WIN_NT4,WIN_95,WIN_98,WIN_ME  <em>; Note: No spaces around commas.</em>
{
    MsgBox This script requires Windows 2000/XP or later.
    ExitApp
}
```

A\_Is64bitOS[v1.1.08+]: Contains 1 (true) if the OS is 64-bit or 0 (false) if it is 32-bit.A\_PtrSize[AHK\_L 42+]: Contains the size of a pointer, in bytes. This is either 4 (32-bit) or 8 (64-bit), depending on what type of executable (EXE) is running the script.A\_LanguageThe system's default language, which is one of [these 4-digit codes](misc/Languages.htm).A\_ComputerNameThe name of the computer as seen on the network.A\_UserNameThe logon name of the user who launched this script.A\_WinDirThe Windows directory. For example: `C:\Windows`A\_ProgramFiles

 or ProgramFiles

The Program Files directory (e.g. `C:\Program Files` or `C:\Program Files (x86)`). This is usually the same as the _ProgramFiles_ [environment variable](Concepts.htm#environment-variables).

On [64-bit systems](#Is64bitOS) (and not 32-bit systems), the following applies:

- If the executable (EXE) that is running the script is 32-bit, A\_ProgramFiles returns the path of the "Program Files (x86)" directory.
- For 32-bit processes, the_ProgramW6432_ environment variable contains the path of the 64-bit Program Files directory. On Windows 7 and later, it is also set for 64-bit processes.
- The_ProgramFiles(x86)_ environment variable contains the path of the 32-bit Program Files directory.

[v1.0.43.08+]: The A\_ prefix may be omitted, which helps ease the transition to [#NoEnv](commands/_NoEnv.htm).

A\_AppData

[v1.0.43.09+]

The full path and name of the folder containing the current user's application-specific data. For example:

```
C:\Users\<UserName>\AppData\Roaming
```

A\_AppDataCommon

[v1.0.43.09+]

The full path and name of the folder containing the all-users application-specific data. For example:

```
C:\ProgramData
```

A\_Desktop

The full path and name of the folder containing the current user's desktop files. For example:

```
C:\Users\<UserName>\Desktop
```

A\_DesktopCommon

The full path and name of the folder containing the all-users desktop files. For example:

```
C:\Users\Public\Desktop
```

A\_StartMenu

The full path and name of the current user's Start Menu folder. For example:

```
C:\Users\<UserName>\AppData\Roaming\Microsoft\Windows\Start Menu
```

A\_StartMenuCommon

The full path and name of the all-users Start Menu folder. For example:

```
C:\ProgramData\Microsoft\Windows\Start Menu
```

A\_Programs

The full path and name of the Programs folder in the current user's Start Menu. For example:

```
C:\Users\<UserName>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
```

A\_ProgramsCommon

The full path and name of the Programs folder in the all-users Start Menu. For example:

```
C:\ProgramData\Microsoft\Windows\Start Menu\Programs
```

A\_Startup

The full path and name of the Startup folder in the current user's Start Menu. For example:

```
C:\Users\<UserName>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

A\_StartupCommon

The full path and name of the Startup folder in the all-users Start Menu. For example:

```
C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
```

A\_MyDocuments

The full path and name of the current user's "My Documents" folder. Unlike most of the similar variables, if the folder is the root of a drive, the final backslash is not included (e.g. it would contain `M:` rather than `M:\`). For example:

```
C:\Users\<UserName>\Documents
```

A\_IsAdmin

If the current user has admin rights, this variable contains 1. Otherwise, it contains 0.

To have the script restart itself as admin (or show a prompt to the user requesting admin), use [Run \*RunAs](commands/Run.htm#RunAs). However, note that running the script as admin causes all programs launched by the script to also run as admin. For a possible alternative, see [the FAQ](FAQ.htm#uac).

A\_ScreenWidth

A\_ScreenHeight

The width and height of the primary monitor, in pixels (e.g. 1024 and 768).

To discover the dimensions of other monitors in a multi-monitor system, use [SysGet](commands/SysGet.htm).

To instead discover the width and height of the entire desktop (even if it spans multiple monitors), use the following example:

```
<a href="commands/SysGet.htm" data-index="300">SysGet</a>, VirtualWidth, 78
<a href="commands/SysGet.htm" data-index="301">SysGet</a>, VirtualHeight, 79

```

In addition, use [SysGet](commands/SysGet.htm) to discover the work area of a monitor, which can be smaller than the monitor's total area because the taskbar and other registered desktop toolbars are excluded.

A\_ScreenDPI [v1.1.11+]Number of pixels per logical inch along the screen width. In a system with multiple display monitors, this value is the same for all monitors. On most systems this is 96; it depends on the system's text size (DPI) setting. See also [Gui -DPIScale](commands/Gui.htm#DPIScale).A\_IPAddress1 through 4The IP addresses of the first 4 network adapters in the computer.

### Misc.

VariableDescriptionA\_Cursor

The type of mouse cursor currently being displayed. It will be one of the following words: AppStarting, Arrow, Cross, Help, IBeam, Icon, No, Size, SizeAll, SizeNESW, SizeNS, SizeNWSE, SizeWE, UpArrow, Wait, Unknown. The acronyms used with the size-type cursors are compass directions, e.g. NESW = NorthEast+SouthWest. The hand-shaped cursors (pointing and grabbing) are classified as Unknown.

A\_CaretX

 A\_CaretY

The current X and Y coordinates of the caret (text insertion point). The coordinates are relative to the active window unless [CoordMode](commands/CoordMode.htm) is used to make them relative to the entire screen. If there is no active window or the caret position cannot be determined, these variables are blank.

The following script allows you to move the caret around to see its current position displayed in an auto-update tooltip. Note that some windows (e.g. certain versions of MS Word) report the same caret position regardless of its actual position.

```
#Persistent
SetTimer, WatchCaret, 100
return
WatchCaret:
    ToolTip, X%A_CaretX% Y%A_CaretY%, A_CaretX, A_CaretY - 20
return

```

ClipboardCan be used to get or set the contents of the OS's clipboard. For details, see [Clipboard](misc/Clipboard.htm).ClipboardAllThe entire contents of the clipboard (such as formatting and text). For details, see [ClipboardAll](misc/Clipboard.htm#ClipboardAll).ErrorLevelThis variable is set by some commands to indicate their success or failure. For details, see [ErrorLevel](misc/ErrorLevel.htm).A\_LastErrorThe result from the OS's GetLastError() function or the last COM object invocation. For details, see [DllCall()](commands/DllCall.htm#LastError) and [Run/RunWait](commands/Run.htm#LastError).True

False

Contain 1 and 0. They can be used to make a script more readable. For details, see [Boolean Values](Concepts.htm#boolean).

### Loop

VariableDescriptionA\_IndexThis is the number of the current loop iteration (a 64-bit integer). For example, the first time the script executes the body of a loop, this variable will contain the number 1. For details see [Loop](commands/Loop.htm) or [While-loop](commands/While.htm).A\_LoopFileName, etc.This and other related variables are valid only inside a [file-loop](commands/LoopFile.htm).A\_LoopRegName, etc.This and other related variables are valid only inside a [registry-loop](commands/LoopReg.htm).A\_LoopReadLineSee [file-reading loop](commands/LoopReadFile.htm).A\_LoopFieldSee [parsing loop](commands/LoopParse.htm).

## Variable Capacity and Memory

- Each variable may contain up to 64 MB of text (this limit can be increased with[#MaxMem](commands/_MaxMem.htm)).
- When a variable is given a new string longer than its current contents, additional system memory is allocated automatically.
- The memory occupied by a large variable can be freed by setting it equal to nothing, e.g.`var := ""`.
- There is no limit to how many variables a script may create. The program is designed to support at least several million variables without a significant drop in performance.
- Commands, functions, and expressions that accept numeric inputs generally support 15 digits of precision for floating point values. For integers, 64-bit signed values are supported, which range from -9223372036854775808 (-0x8000000000000000) to 9223372036854775807 (0x7FFFFFFFFFFFFFFF). Any integer constants or numeric strings outside this range are not supported and might yield inconsistent results when used as numbers. By contrast, arithmetic operations on integers wrap around upon overflow (e.g. 0x7FFFFFFFFFFFFFFF + 1 = -0x8000000000000000).

