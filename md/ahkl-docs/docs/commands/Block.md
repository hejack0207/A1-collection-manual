# {...} (block)

Blocks are one or more [statements](../Concepts.htm#statement) enclosed in braces. Typically used with [function definitions](../Functions.htm#define) and [control flow statements](../Language.htm#control-flow).

```
{
    <i>Statements</i>
}
```

## Remarks

A block is used to bind two or more [statements](../Concepts.htm#statement) together. It can also be used to change which [If statement](../Language.htm#if-statement) an [Else statement](Else.htm) belongs to, as in this example where the block forces the Else statement to belong to the first If statement rather than the second:

```
if (Var1 = 1)
{
    if (Var2 = "abc")
        Sleep, 1
}
else
    return
```

Although blocks can be used anywhere, currently they are only meaningful when used with [function definitions](../Functions.htm#define), [If statements](../Language.htm#if-statement), [Else](Else.htm), [Loop statements](../Language.htm#loop-statement), [Try](Try.htm), [Catch](Catch.htm) or [Finally](Finally.htm).

If any of the control flow statements mentioned above has only a single statement, that statement need not be enclosed in a block (this does not work for function definitions). However, there may be cases where doing so enhances the readability or maintainability of the script.

A block may be empty (contain zero statements), which may be useful in cases where you want to comment out the contents of the block without removing the block itself.

**One True Brace (OTB, K&R style):** The OTB style may optionally be used in the following places: [function definitions](../Functions.htm#define), [If (expression)](IfExpression.htm), [Else](Else.htm), [Loop Count](Loop.htm), [While](While.htm), [For](For.htm), [Try](Try.htm), [Catch](Catch.htm), and [Finally](Finally.htm). This style puts the block's opening brace on the same line as the block's controlling statement rather than underneath on a line by itself. For example:

```
MyFunction(x, y) {
    ...
}
if (x < y) {
    ...
} else {
    ...
}
Loop %RepeatCount% {
    ...
}
While x < y {
    ...
}
For k, v in obj {
    ...
}
Try {
    ...
} Catch e {
    ...
} Finally {
    ....
}
```

Similarly, a statement may exist to the right of a brace (except the open-brace of the One True Brace style). For example:

```
if (x = 1)
{ MsgBox This line appears to the right of an opening brace. It executes whenever the IF-statement is true.
    MsgBox This is the next line.
} MsgBox This line appears to the right of a closing brace. It executes unconditionally.
```

## Related

[Function Definitions](../Functions.htm#define), [Control Flow Statements](../Language.htm#control-flow), [If Statements](../Language.htm#if-statement), [Else](Else.htm), [Loop Statements](../Language.htm#loop-statement), [Try](Try.htm), [Catch](Catch.htm), [Finally](Finally.htm)

## Examples

By enclosing the two statements `MsgBox, test1` and `Sleep, 5` with braces, the If statement knows that it should execute both if x is equal to 1.

```
if (x = 1)
{
    MsgBox, test1
    Sleep, 5
}
else
    MsgBox, test2
```

