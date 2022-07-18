# Until [AHK\_L 59+]

Applies a condition to the continuation of a Loop or For-loop.

```
<span class="func">Loop</span> {
    ...
} <span class="func">Until</span> <i>Expression</i>

```

## Parameters

Expression

Any valid [expression](../Variables.htm#Expressions).

## Remarks

The expression is evaluated once after each iteration, and is evaluated even if [continue](Continue.htm) was used. If the expression evaluates to false (which is an empty string or the number 0), the loop continues; otherwise, the loop is broken and execution continues at the line following _Until_.

Loop Until is shorthand for the following:

```
Loop {
    ...
    if (<i>Expression</i>)
        break
}
```

However, Loop Until is often easier to understand and unlike the above, can be used with a single-line action. For example:

```
Loop
    x *= 2
Until x > y
```

_Until_ can be used with any Loop or For. For example:

```
Loop, Read, %A_ScriptFullPath%
    lines .= A_LoopReadLine . "`n"
Until A_Index=5  <em>; Read the first five lines.</em>
MsgBox % lines

```

If [A\_Index](../Variables.htm#Index) is used in _Expression_, it contains the index of the iteration which has just finished.

## Related

[Loop](Loop.htm), [While-loop](While.htm), [For-loop](For.htm), [Break](Break.htm), [Continue](Continue.htm), [Blocks](Block.htm), [Files-and-folders loop](LoopFile.htm), [Registry loop](LoopReg.htm), [File-reading loop](LoopReadFile.htm), [Parsing loop](LoopParse.htm), [If (expression)](IfExpression.htm)

