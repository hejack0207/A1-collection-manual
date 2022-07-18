# Gosub

Jumps to the specified label and continues execution until [Return](Return.htm) is encountered.

```
<span class="func">Gosub</span>, Label
```

## Parameters

Label

The name of the [label](../misc/Labels.htm), [hotkey label](../Hotkeys.htm), or [hotstring label](../Hotstrings.htm#label) to which to jump, which causes the commands beneath _Label_ to be executed until a Return or Exit is encountered. ["Return"](Return.htm) causes the script to jump back to the first command beneath the Gosub and resume execution there. ["Exit"](Exit.htm) terminates the [current thread](../misc/Threads.htm).

## Remarks

As with the parameters of almost all other commands, _Label_ can be a [variable](../Variables.htm) reference such as %MyLabel%, in which case the name stored in the variable is used as the target. However, performance is slightly reduced because the target label must be "looked up" each time rather than only once when the script is first loaded.

When using a dynamic label such as %MyLabel%, an error dialog will be displayed if the label does not exist. To avoid this, call [IsLabel()](IsLabel.htm) beforehand. For example:

```
if IsLabel(VarContainingLabelName)
    Gosub %VarContainingLabelName%
```

Although Gosub is useful for simple, general purpose subroutines, consider using [functions](../Functions.htm) for more complex purposes.

## Related

[Return](Return.htm), [Functions](../Functions.htm), [IsLabel()](IsLabel.htm), [Blocks](Block.htm), [Loop](Loop.htm), [Goto](Goto.htm), [A\_ThisLabel](../Variables.htm#ThisLabel)

## Examples

This example is executed as follows:

1. Jump to the label named "Label1".
2. Show the message "The Label1 subroutine is now running."
3. Return to the line immediately after Gosub.
4. Show the message "The Label1 subroutine has returned (it is finished)."
5. End the[auto-execute section](../Language.htm#auto-execute-section).

```
Gosub, Label1
MsgBox, The Label1 subroutine has returned (it is finished).
return

Label1:
MsgBox, The Label1 subroutine is now running.
return
```

