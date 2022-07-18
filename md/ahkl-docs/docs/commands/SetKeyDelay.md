# SetKeyDelay

Sets the delay that will occur after each keystroke sent by [Send](Send.htm) or [ControlSend](ControlSend.htm).

```
<span class="func">SetKeyDelay</span> <span class="optional">, Delay, PressDuration, Play</span>
```

## Parameters

Delay

Time in milliseconds, which can be an [expression](../Variables.htm#Expressions). Use -1 for no delay at all and 0 for the smallest possible delay (however, if the _Play_ parameter is present, both 0 and -1 produce no delay). Leave this parameter blank to retain the current _Delay_.

If SetKeyDelay is never used by a script, the default _Delay_ for the tradional SendEvent mode is 10. For [SendPlay mode](Send.htm#SendPlayDetail), the default _Delay_ is -1. The default _PressDuration_ (below) is -1 for both modes.

PressDuration

Certain games and other specialized applications may require a delay inside each keystroke; that is, after the press of the key but before its release.

Use -1 for no delay at all (default) and 0 for the smallest possible delay (however, if the _Play_ parameter is present, both 0 and -1 produce no delay). Omit this parameter to leave the current _PressDuration_ unchanged.

**Note**: _PressDuration_ also produces a delay after any change to the modifier key state (Ctrl, Alt, Shift, and Win) needed to support the keys being sent.

This parameter can be an [expression](../Variables.htm#Expressions).

Play [v1.0.43+]

The word _Play_ applies the above settings to the [SendPlay mode](Send.htm#SendPlayDetail) rather than the traditional SendEvent mode. If a script never uses this parameter, the delay is always -1/-1 for SendPlay.

## Remarks

**Note:** SetKeyDelay is not obeyed by [SendInput](Send.htm#SendInputDetail); there is no delay between keystrokes in that mode. This same is true for [Send](Send.htm) when [SendMode Input](SendMode.htm) is in effect.

A short delay (sleep) is done automatically after every keystroke sent by [Send](Send.htm) or [ControlSend](ControlSend.htm). This is done to improve the reliability of scripts because a window sometimes can't keep up with a rapid flood of keystrokes.

During the delay (sleep), the current thread is made [uninterruptible](../misc/Threads.htm#Interrupt).

Due to the granularity of the OS's time-keeping system, delays might be rounded up to the nearest multiple of 10 or 15. For example, a delay between 1 and 10 (inclusive) is equivalent to 10 or 15 on most Windows XP systems (and probably 2k).

For Send/SendEvent mode, a delay of 0 internally executes a Sleep(0), which yields the remainder of the script's timeslice to any other process that may need it. If there is none, Sleep(0) will not sleep at all. By contrast, a delay of -1 will never sleep. For better reliability, 0 is recommended as an alternative to -1.

When the delay is set to -1, a script's process-priority becomes an important factor in how fast it can send keystrokes when using the traditional [SendEvent mode](SendMode.htm). To raise a script's priority, use `<a href="Process.htm" data-index="14">Process</a>, Priority,, High`. Although this typically causes keystrokes to be sent faster than the [active window](WinActivate.htm) can process them, the system automatically buffers them. Buffered keystrokes continue to arrive in the target window after the [Send](Send.htm) command completes (even if the window is no longer active). This is usually harmless because any subsequent keystrokes sent to the same window get queued up behind the ones already in the buffer.

The built-in variable **A\_KeyDelay** contains the current setting of _Delay_ for Send/SendEvent mode. [v1.1.23+]: **A\_KeyDuration** contains the setting for _PressDuration_, while **A\_KeyDelayPlay** and **A\_KeyDurationPlay** contain the settings for [SendPlay](Send.htm#SendPlayDetail).

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[Send](Send.htm), [ControlSend](ControlSend.htm), [SendMode](SendMode.htm), [SetMouseDelay](SetMouseDelay.htm), [SetControlDelay](SetControlDelay.htm), [SetWinDelay](SetWinDelay.htm), [SetBatchLines](SetBatchLines.htm), [Click](Click.htm)

## Examples

Causes the smallest possible delay to occur after each keystroke sent via [Send](Send.htm) or [ControlSend](ControlSend.htm).

```
SetKeyDelay, 0
```

