# Script Performance

To maximize performance, avoid using SetFormat (except the [fast mode](../commands/SetFormat.htm#Fast)) and include the following lines near the top of each script:

```
<a href="../commands/_NoEnv.htm" data-index="2">#NoEnv</a>
<a href="../commands/SetBatchLines.htm" data-index="3">SetBatchLines -1</a>
<a href="../commands/ListLines.htm" data-index="4">ListLines Off</a>
```

In addition, the following commands may also affect performance depending on the nature of the script: [SendMode](../commands/SendMode.htm), [SetKeyDelay](../commands/SetKeyDelay.htm), [SetMouseDelay](../commands/SetMouseDelay.htm), [SetWinDelay](../commands/SetWinDelay.htm), [SetControlDelay](../commands/SetControlDelay.htm), and [SetDefaultMouseSpeed](../commands/SetDefaultMouseSpeed.htm).

## Built-in Performance Features

Each script is semi-compiled while it is being loaded and syntax-checked. In addition to reducing the memory consumed by the script, this also greatly improves runtime performance.

Here are the technical details of the optimization process (semi-compiling):

- Input and output variables (when their names don't contain references to other variables) and[group](../commands/GroupAdd.htm) names are resolved to memory addresses.
- [Loops](../commands/Loop.htm), [blocks](../commands/Block.htm), [IFs (expression)](../commands/IfExpression.htm), [IFs (legacy)](../commands/IfEqual.htm), and [ELSEs](../commands/Else.htm) are given the memory addresses of their related jump-points in the script.
- The destination of each[Hotkey](../Hotkeys.htm), [Gosub](../commands/Gosub.htm), and [Goto](../commands/Goto.htm) is resolved to a memory address unless it is a variable.
- Each command name is replaced by an address in a jump table.
- Each line is pre-parsed into a list of parameters, and each parameter is pre-parsed into a list of[variables](../Variables.htm) (if any).
- Each[expression](../Variables.htm#Expressions) is tokenized and converted from infix to postfix.
- Each reference to a[variable](../Variables.htm) or [function](../Functions.htm) is resolved to a memory address.
- Literal integers in expressions and math/comparison commands are replaced with binary integers.

In addition, during script execution, binary numbers are cached in variables to avoid conversions to/from strings. See [SetFormat](../commands/SetFormat.htm#Fast) for details.

