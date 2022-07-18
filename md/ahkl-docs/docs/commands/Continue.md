# Continue

Skips the rest of a [loop statement](../Language.htm#loop-statement)'s current iteration and begins a new one.

```
<span class="func">Continue</span> <span class="optional">, LoopLabel</span>
```

## Parameters

LoopLabel [AHK\_L 59+]_LoopLabel_ identifies which loop this statement should apply to; either by [label name](../misc/Labels.htm) or numeric nesting level. If omitted or 1, this statement applies to the innermost loop in which it is enclosed. _LoopLabel_ must be a constant value - variables and expressions are not supported. If a [label](../misc/Labels.htm) is specified, it must point directly at a [loop statement](../Language.htm#loop-statement).

## Remarks

Continue behaves the same as reaching the loop's closing brace:

1. It increases[A\_Index](../Variables.htm#Index) by 1.
2. It skips the rest of the loop's body.
3. The loop's condition (if it has one) is checked to see if it is satisified. If so, a new iteration begins; otherwise the loop ends.

The use of [Break](Break.htm) and Continue are encouraged over [Goto](Goto.htm) since they usually make scripts more readable and maintainable.

## Related

[Break](Break.htm), [Loop](Loop.htm), [Until](Until.htm), [While-loop](While.htm), [For-loop](For.htm), [Blocks](Block.htm), [Labels](../misc/Labels.htm)

## Examples

Displays 5 message boxes, one for each number between 6 and 10. Note that in the first 5 iterations of the loop, the Continue statement causes the loop to start over before it reaches the MsgBox line.

```
Loop, 10
{
    if (A_Index <= 5)
        continue
    MsgBox %A_Index%
}
```

Continues the outer loop from within a nested loop.

```
outer:
Loop 3
{
    x := A_Index
    Loop 3
    {
        if (x*A_Index = 4)
            continue outer  <em>; Equivalent to <b>continue 2</b> or <b>goto continue_outer</b>.</em>
        MsgBox %x%,%A_Index%
    }
    continue_outer: <em>; For goto.</em>
    ErrorLevel:=ErrorLevel <em>; Prior to revision 57, labels could not point to the end of a block.</em>
}
```

