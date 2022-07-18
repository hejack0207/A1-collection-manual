# If / IfEqual / IfNotEqual / IfLess / IfLessOrEqual / IfGreater / IfGreaterOrEqual

Specifies one or more [statements](../Concepts.htm#statement) to execute if the comparison of a [variable](../Variables.htm) to a value evaluates to true.

**Deprecated:** Legacy If statements are not recommended for use in new scripts. See [Scripting Language: If Statement](../Language.htm#if-statement) for details and use [If (expression)](IfExpression.htm) instead.

```
<span class="func">IfEqual</span>, Var <span class="optional">, Value</span>          <em>; if Var = Value</em>
<span class="func">IfNotEqual</span>, Var <span class="optional">, Value</span>       <em>; if Var != Value</em>
<span class="func">IfLess</span>, Var <span class="optional">, Value</span>           <em>; if Var < Value</em>
<span class="func">IfLessOrEqual</span>, Var <span class="optional">, Value</span>    <em>; if Var <= Value</em>
<span class="func">IfGreater</span>, Var <span class="optional">, Value</span>        <em>; if Var > Value</em>
<span class="func">IfGreaterOrEqual</span>, Var <span class="optional">, Value</span> <em>; if Var >= Value</em>

```

## Parameters

VarThe name of a [variable](../Variables.htm). Percent signs must be omitted except when attempting a [double reference](../Language.htm#dynamic-variables). Unlike the input variables of other commands, the [percent prefix](../Language.htm#-expression) is not supported.Value[Unquoted text](../Language.htm#unquoted-text) or a [number](../Concepts.htm#numbers). Variable references must be enclosed in percent signs (e.g. %var2%). _Value_ can be omitted if you wish to compare _Var_ to an empty string (blank).

## Remarks

If both _Var_ and _Value_ are purely numeric, they will be compared as numbers rather than as strings. Otherwise, they will be compared alphabetically as strings (that is, alphabetical order will determine whether _Var_ is greater, equal, or less than _Value_).

If an _If_ owns more than one line, those lines must be enclosed in braces (to create a [block](Block.htm)). However, if only one line belongs to an _If_, the braces are optional. For example:

```
if count <= 0
{
    WinClose Untitled - Notepad
    MsgBox There are no items present.
}
```

Note that command-like If statements allow a [command](../Language.htm#commands) or command-like [control flow statement](../Language.htm#control-flow) to be written on the same line, but mispelled command names are treated as literal text. In other words, these are valid:

```
IfEqual, x, 1, Sleep, 1
IfGreater, x, 1, EnvAdd, x, 2
```

But these are not valid:

```
if x = 1 Sleep 1
IfGreater, x, 1, x += 2
```

The One True Brace (OTB) style may **not** be used with legacy If statements. It can only be used with [If (expression)](IfExpression.htm).

On a related note, the statement `<a href="IfBetween.htm" data-index="14">if Var between LowerBound and UpperBound</a>` checks whether a variable is between two values, and `<a href="IfIn.htm" data-index="15">if Var in MatchList</a>` can be used to check whether a variable's contents exist within a list of values.

## Related

[If (expression)](IfExpression.htm), [StringCaseSense](StringCaseSense.htm), [Assign expression (:=)](SetExpression.htm), [if var in/contains](IfIn.htm), [if var between](IfBetween.htm), [IfInString](IfInString.htm), [Blocks](Block.htm), [Else](Else.htm)

## Examples

If counter is greater than or equal to 1, sleep for 10 ms.

```
if counter >= 1
    Sleep, 10
```

If counter is greater than or equal to 1, close Notepad and sleep for 10 ms.

```
if counter >= 1   <em>; For executing more than one line, enclose those lines in braces:</em>
{
    WinClose, Untitled - Notepad
    Sleep 10
}
```

This example is executed as follows:

1. IfMyVar is equal to MyVar2, show "The contents of MyVar and MyVar2 are identical."
2. Otherwise ifMyVar is empty:

1. Show "MyVar is empty/blank. Continue?" and wait for user input.
2. If the user presses "No", stop further checks.
3. Otherwise ifMyVar is not a comma, show "The value in MyVar is not a comma.".
4. Otherwise show "The value in MyVar is a comma.".

```
if MyVar = %MyVar2%
    MsgBox The contents of MyVar and MyVar2 are identical.
else if MyVar =
{
    MsgBox, 4,, MyVar is empty/blank. Continue?
    IfMsgBox, No
        Return
}
else if MyVar != ,
    MsgBox The value in MyVar is not a comma.
else
    MsgBox The value in MyVar is a comma.
```

If Done is neither empty nor zero, show "The variable Done is neither empty nor zero.".

```
if Done
    MsgBox The variable Done is neither empty nor zero.
```

