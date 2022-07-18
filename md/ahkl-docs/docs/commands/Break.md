# Break

Exits (terminates) any type of [loop statement](../Language.htm#loop-statement).

```
<span class="func">Break</span> <span class="optional">, LoopLabel</span>
```

## Parameters

LoopLabel [AHK\_L 59+]_LoopLabel_ identifies which loop this statement should apply to; either by [label name](../misc/Labels.htm) or numeric nesting level. If omitted or 1, this statement applies to the innermost loop in which it is enclosed. _LoopLabel_ must be a constant value - variables and expressions are not supported. If a [label](../misc/Labels.htm) is specified, it must point directly at a [loop statement](../Language.htm#loop-statement).

## Remarks

The use of Break and [Continue](Continue.htm) are encouraged over [Goto](Goto.htm) since they usually make scripts more readable and maintainable.

## Related

[Continue](Continue.htm), [Loop](Loop.htm), [While-loop](While.htm), [For-loop](For.htm), [Blocks](Block.htm), [Labels](../misc/Labels.htm)

## Examples

Breaks the loop if var is greater than 25.

```
Loop
{
    <em>; ...</em>
    if (var > 25)
        break
    <em>; ...</em>
    if (var <= 5)
        continue
}
```

Breaks the outer loop from within a nested loop.

```
outer:
Loop 3
{
    x := A_Index
    Loop 3
    {
        if (x*A_Index = 6)
            break outer  <em>; Equivalent to <b>break 2</b> or <b>goto break_outer</b>.</em>
        MsgBox %x%,%A_Index%
    }
}
break_outer: <em>; For goto.</em>

```

