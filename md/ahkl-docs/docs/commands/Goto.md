# Goto

Jumps to the specified label and continues execution.

```
<span class="func">Goto</span>, Label
```

## Parameters

Label

The name of the [label](../misc/Labels.htm) to which to jump.

## Remarks

When using a dynamic label such as %MyLabel%, an error dialog will be displayed if the label does not exist. To avoid this, call [IsLabel()](IsLabel.htm) beforehand. For example:

```
if IsLabel(VarContainingLabelName)
    Goto %VarContainingLabelName%
```

The use of Goto is discouraged because it generally makes scripts less readable and harder to maintain. Consider using [Else](Else.htm), [Blocks](Block.htm), [Break](Break.htm), and [Continue](Continue.htm) as substitutes for Goto.

## Related

[Gosub](Gosub.htm), [Return](Return.htm), [IsLabel()](IsLabel.htm), [Else](Else.htm), [Blocks](Block.htm), [Break](Break.htm), [Continue](Continue.htm), [A\_ThisLabel](../Variables.htm#ThisLabel)

## Examples

Jumps to the label named "MyLabel" and continues execution.

```
Goto, MyLabel
<em>; ...</em>
MyLabel:
Sleep, 100
<em>; ...</em>
```

