# If (Expression)

Specifies one or more [statements](../Concepts.htm#statement) to execute if an [expression](../Variables.htm#Expressions) evaluates to true.

```
<span class="func">If</span> (<i>Expression</i>)
{
    <i>Statements</i>
}
```

## Remarks

An _If_ statement that contains an expression is usually differentiated from a [traditional If statement](IfEqual.htm) such as `if FoundColor != Blue` by enclosing the expression in parentheses, as in `if (FoundColor != "Blue")`. However, this is not strictly required, as any _If_ statement which does not match any of the [legacy if patterns](../Language.htm#legacy-if) is assumed to contain an expression. In particular, the following are also common ways of writing an _If (expression)_:

- Starting with an open parenthesis but not fully enclosing the expression:`if (x > 0) and (y > 0)`
- Starting with a[function call](../Functions.htm): `if InStr(a, b)`
- Starting with an[operator](../Variables.htm#Operators) such as `not` or `!`: `if !MyVar`

**Known limitation:** For historical reasons, _If (expression)_ actually accepts a [numeric parameter](../Language.htm#numeric-parameters) rather than a pure expression. For example, `if %MyVar%` is equivalent to `if MyVar`. This can be avoided by always enclosing the expression in parentheses.

If the _If_ statement's expression evaluates to true (which is any result other than an empty string or the number 0), the line or [block](Block.htm) underneath it is executed. Otherwise, if there is a corresponding [Else](Else.htm) statement, execution jumps to the line or block underneath it.

If an _If_ owns more than one line, those lines must be enclosed in braces (to create a [block](Block.htm)). However, if only one line belongs to an _If_, the braces are optional. See the examples at the bottom of this page.

The space after `if` is optional if the expression starts with an open-parenthesis, as in `if(expression)`.

The One True Brace (OTB) style may optionally be used with _If_ statements that are expressions (but not [traditional If statements](IfEqual.htm)). For example:

```
if (x < y) {
    <em>; ...</em>
}
if WinExist("Untitled - Notepad") {
    WinActivate
}
if IsDone {
    <em>; ...</em>
} else {
    <em>; ...</em>
}
```

Unlike an _If_ statement, an [Else](Else.htm) statement supports any type of statement immediately to its right.

On a related note, the statement `<a href="IfBetween.htm" data-index="13">if Var between LowerBound and UpperBound</a>` checks whether a variable is between two values, and `<a href="IfIn.htm" data-index="14">if Var in MatchList</a>` can be used to check whether a variable's contents exist within a list of values.

## Related

[Expressions](../Variables.htm#Expressions), [Assign expression (:=)](SetExpression.htm), [if var in/contains](IfIn.htm), [if var between](IfBetween.htm), [IfInString](IfInString.htm), [Blocks](Block.htm), [Else](Else.htm), [While-loop](While.htm)

## Examples

If A\_Index is greater than 100, return.

```
if (A_Index > 100)
    return
```

If the result of `A_TickCount - StartTime` is greater than the result of `2*MaxTime + 100`, show "Too much time has passed." and terminate the script.

```
if (A_TickCount - StartTime > 2*MaxTime + 100)
{
    MsgBox Too much time has passed.
    ExitApp
}
```

This example is executed as follows:

1. IfColor is the word "Blue" or "White":

1. Show "The color is one of the allowed values.".
2. Terminate the script.
2. Otherwise ifColor is the word "Silver":

1. Show "Silver is not an allowed color.".
2. Stop further checks.
3. Otherwise:
1. Show "This color is not recognized.".
2. Terminate the script.

```
if (Color = "Blue" or Color = "White")
{
    MsgBox The color is one of the allowed values.
    ExitApp
}
else if (Color = "Silver")
{
    MsgBox Silver is not an allowed color.
    return
}
else
{
    MsgBox This color is not recognized.
    ExitApp
}
```

A single [multi-statement](../Variables.htm#comma) line does not need to be enclosed in braces.

```
MyVar := 3
if (MyVar > 2)
    MyVar++, MyVar := MyVar - 4, MyVar .= " test"
MsgBox % MyVar  <em>; Reports "0 test".</em>

```

