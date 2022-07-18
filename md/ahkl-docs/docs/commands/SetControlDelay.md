# SetControlDelay

Sets the delay that will occur after each control-modifying command.

```
<span class="func">SetControlDelay</span>, Delay
```

## Parameters

Delay

Time in milliseconds, which can be an [expression](../Variables.htm#Expressions). Use -1 for no delay at all and 0 for the smallest possible delay. If unset, the default delay is 20.

## Remarks

A short delay (sleep) is done automatically after every Control command that changes a control, namely [Control](Control.htm), [ControlMove](ControlMove.htm), [ControlClick](ControlClick.htm), [ControlFocus](ControlFocus.htm), and [ControlSetText](ControlSetText.htm) ( [ControlSend](ControlSend.htm) uses [SetKeyDelay](SetKeyDelay.htm)). This is done to improve the reliability of scripts because a control sometimes needs a period of "rest" after being changed by one of these commands. The rest period allows it to update itself and respond to the next command that the script may attempt to send to it.

Although a delay of -1 (no delay at all) is allowed, it is recommended that at least 0 be used, to increase confidence that the script will run correctly even when the CPU is under load.

A delay of 0 internally executes a Sleep(0), which yields the remainder of the script's timeslice to any other process that may need it. If there is none, Sleep(0) will not sleep at all.

If the CPU is slow or under load, or if window animation is enabled, higher delay values may be needed.

The built-in variable **A\_ControlDelay** contains the current setting.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[Control](Control.htm), [ControlMove](ControlMove.htm), [ControlClick](ControlClick.htm), [ControlFocus](ControlFocus.htm), [ControlSetText](ControlSetText.htm), [SetWinDelay](SetWinDelay.htm), [SetKeyDelay](SetKeyDelay.htm), [SetMouseDelay](SetMouseDelay.htm), [SetBatchLines](SetBatchLines.htm)

## Examples

Causes the smallest possible delay to occur after each control-modifying command.

```
SetControlDelay, 0
```

