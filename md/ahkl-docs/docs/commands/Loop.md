# Loop (normal)

Performs a series of commands repeatedly: either the specified number of times or until [break](Break.htm) is encountered.

```
<span class="func">Loop</span> <span class="optional">, Count</span>
```

## Parameters

Count

How many times (iterations) to perform the loop. If omitted, the Loop continues indefinitely until a [break](Break.htm) or [return](Return.htm) is encountered.

If _Count_ is a variable reference such as %ItemCount%, the loop is skipped entirely whenever the variable is blank or contains a number less than 1.

Due to the need to support [file-pattern loops](LoopFile.htm), _Count_ cannot be an expression. However, as with all non-expression parameters, an expression can be forcibly used by preceding it with a % and a space. For example: `Loop % Count + 1`. In such cases, the expression is evaluated only once, right before the loop begins.

## Remarks

The loop command is usually followed by a [block](Block.htm), which is a collection of statements that form the _body_ of the loop. However, a loop with only a single statement does not require a block (an "if" and its "else" count as a single statement for this purpose).

A common use of this command is an infinite loop that uses the [break](Break.htm) command somewhere in the loop's _body_ to determine when to stop the loop.

The use of [break](Break.htm) and [continue](Continue.htm) inside a loop are encouraged as alternatives to [goto](Goto.htm), since they generally make a script more understandable and maintainable. One can also create a "While" or "Do...While/Until" loop by making the first or last statement of the loop's _body_ an IF statement that conditionally issues the [break](Break.htm) command, but the use of [While](While.htm) or [Loop...Until](Until.htm) is usually preferred.

The built-in variable **A\_Index** contains the number of the current loop iteration. It contains 1 the first time the loop's _body_ is executed. For the second time, it contains 2; and so on. If an inner loop is enclosed by an outer loop, the inner loop takes precedence. A\_Index works inside all types of loops, including [file-loops](LoopFile.htm) and [registry-loops](LoopReg.htm); but A\_Index contains 0 outside of a loop.

The [One True Brace (OTB) style](Block.htm#otb) may optionally be used with normal loops (but not specialized loops such as [file-pattern](LoopFile.htm) and [parsing](LoopParse.htm)). For example:

```
Loop {
    ...
}
Loop %RepeatCount% {
    ...
}
```

Specialized loops: Loops can be used to automatically retrieve files, folders, or registry items (one at a time). See [file-loop](LoopFile.htm) and [registry-loop](LoopReg.htm) for details. In addition, [file-reading loops](LoopReadFile.htm) can operate on the entire contents of a file, one line at a time. Finally, [parsing loops](LoopParse.htm) can operate on the individual fields contained inside a delimited string.

## Related

[Until](Until.htm), [While-loop](While.htm), [For-loop](For.htm), [Files-and-folders loop](LoopFile.htm), [Registry loop](LoopReg.htm), [File-reading loop](LoopReadFile.htm), [Parsing loop](LoopParse.htm), [Break](Break.htm), [Continue](Continue.htm), [Blocks](Block.htm)

## Examples

Creates a loop with 3 iterations.

```
Loop, 3
{
    MsgBox, Iteration number is %A_Index%.  <em>; A_Index will be 1, 2, then 3</em>
    Sleep, 100
}
```

Creates an infinite loop, but it will be terminated after the 25th iteration.

```
Loop
{
    if (A_Index > 25)
        break  <em>; Terminate the loop</em>
    if (A_Index < 20)
        continue <em>; Skip the below and start a new iteration</em>
    MsgBox, A_Index = %A_Index% <em>; This will display only the numbers 20 through 25</em>
}
```

