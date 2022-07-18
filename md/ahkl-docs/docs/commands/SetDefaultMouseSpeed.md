# SetDefaultMouseSpeed

Sets the mouse speed that will be used if unspecified in [Click](Click.htm) and [MouseMove](MouseMove.htm)/ [Click](MouseClick.htm)/ [Drag](MouseClickDrag.htm).

```
<span class="func">SetDefaultMouseSpeed</span>, Speed
```

## Parameters

Speed

The speed to move the mouse in the range 0 (fastest) to 100 (slowest). This parameter can be an [expression](../Variables.htm#Expressions).

**Note**: A speed of 0 will move the mouse instantly.

## Remarks

SetDefaultMouseSpeed is ignored for [SendInput/Play modes](SendMode.htm); they move the mouse instantaneously (except when SendInput [reverts to SendEvent](Send.htm#SendInputUnavail); also, [SetMouseDelay](SetMouseDelay.htm) has a mode that applies to SendPlay). To visually move the mouse more slowly -- such as a script that performs a demonstration for an audience -- use `<a href="Send.htm#Click" data-index="9">SendEvent {Click 100 200}</a>` or `<a href="SendMode.htm" data-index="10">SendMode</a> Event` (optionally in conjuction with [BlockInput](BlockInput.htm)).

If this command is not used, the default mouse speed is 2. The built-in variable **A\_DefaultMouseSpeed** contains the current setting.

The commands [MouseClick](MouseClick.htm), [MouseMove](MouseMove.htm), and [MouseClickDrag](MouseClickDrag.htm) all have a parameter to override the default mouse speed.

Whenever _Speed_ is greater than zero, [SetMouseDelay](SetMouseDelay.htm) also influences the speed by producing a delay after each incremental move the mouse makes toward its destination.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[SetMouseDelay](SetMouseDelay.htm), [SendMode](SendMode.htm), [Click](Click.htm), [MouseClick](MouseClick.htm), [MouseMove](MouseMove.htm), [MouseClickDrag](MouseClickDrag.htm), [SetWinDelay](SetWinDelay.htm), [SetControlDelay](SetControlDelay.htm), [SetKeyDelay](SetKeyDelay.htm), [SetKeyDelay](SetMouseDelay.htm)

## Examples

Causes the mouse cursor to be moved instantly.

```
SetDefaultMouseSpeed, 0
```

