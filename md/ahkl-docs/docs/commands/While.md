# While-loop [v1.0.48+]

Performs a series of commands repeatedly until the specified [expression](../Variables.htm#Expressions) evaluates to false.

```
<span class="func">While</span> <i>Expression</i>
<span class="func">While</span>(<i>Expression</i>)

```

## Parameters

Expression

Any valid [expression](../Variables.htm#Expressions). For example: `while x < y`.

## Remarks

The expression is evaluated once before each iteration. If the expression evaluates to true (which is any result other than an empty string or the number 0), the body of the loop is executed; otherwise, execution jumps to the line following the loop's body.

A while-loop is usually followed by a [block](Block.htm), which is a collection of statements that form the _body_ of the loop. However, a loop with only a single statement does not require a block (an "if" and its "else" count as a single statement for this purpose).

The One True Brace (OTB) style may optionally be used, which allows the open-brace to appear on the same line rather than underneath. For example: `while x < y {`.

The built-in variable **A\_Index** contains the number of the current loop iteration. It contains 1 the first time the loop's expression and body are executed. For the second time, it contains 2; and so on. If an inner loop is enclosed by an outer loop, the inner loop takes precedence. A\_Index works inside all types of loops, but contains 0 outside of a loop.

As with all loops, [Break](Break.htm) may be used to exit the loop prematurely. Also, [Continue](Continue.htm) may be used to skip the rest of the current iteration, at which time A\_Index is increased by 1 and the while-loop's expression is re-evaluated. If it is still true, a new iteration begins; otherwise, the loop ends.

Specialized loops: Loops can be used to automatically retrieve files, folders, or registry items (one at a time). See [file-loop](LoopFile.htm) and [registry-loop](LoopReg.htm) for details. In addition, [file-reading loops](LoopReadFile.htm) can operate on the entire contents of a file, one line at a time. Finally, [parsing loops](LoopParse.htm) can operate on the individual fields contained inside a delimited string.

## Related

[Until](Until.htm), [Break](Break.htm), [Continue](Continue.htm), [Blocks](Block.htm), [Loop](Loop.htm), [For-loop](For.htm), [Files-and-folders loop](LoopFile.htm), [Registry loop](LoopReg.htm), [File-reading loop](LoopReadFile.htm), [Parsing loop](LoopParse.htm), [If (expression)](IfExpression.htm)

## Examples

As the user drags the left mouse button, a tooltip displays the size of the region inside the drag-area.

```
CoordMode, Mouse, Screen

~LButton::
    MouseGetPos, begin_x, begin_y
    while GetKeyState("LButton")
    {
        MouseGetPos, x, y
        ToolTip, % begin_x ", " begin_y "`n" Abs(begin_x-x) " x " Abs(begin_y-y)
        Sleep, 10
    }
    ToolTip
return
```

