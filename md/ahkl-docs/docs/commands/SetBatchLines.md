# SetBatchLines

Determines how fast a script will run (affects CPU utilization).

```
<span class="func">SetBatchLines</span>, 20ms
<span class="func">SetBatchLines</span>, LineCount

```

## Parameters

20ms

(The 20ms is just an example.) If the value ends in ms, it indicates how often the script should sleep (each sleep is 10 ms long). In the following example, the script will sleep for 10ms every time it has run for 20ms: `SetBatchLines, 20ms`.

LineCount

The number of script lines to execute prior to sleeping for 10ms. The value can be as high as 9223372036854775807. Also, this mode is mutually exclusive of the 20ms mode in the previous paragraph; that is, only one of them can be in effect at a time.

## Remarks

Use `SetBatchLines -1` to never sleep (i.e. have the script run at maximum speed).

The default setting is 10ms, except in versions prior to [v1.0.16], which use 10 (lines) instead.

The "ms" method is recommended for scripts whenever speed and cooperation are important. For example, on most systems a setting of 10ms will prevent the script from using any more than 50% of an idle CPU's time. This allows scripts to run quickly while still maintaining a high level of cooperation with CPU sensitive tasks such as games and video capture/playback.

The built-in variable **A\_BatchLines** contains the current setting.

The speed of a script can also be impacted by the following commands, depending on the nature of the script: [SetWinDelay](SetWinDelay.htm), [SetControlDelay](SetControlDelay.htm), [SendMode](SendMode.htm), [SetKeyDelay](SetKeyDelay.htm), [SetMouseDelay](SetMouseDelay.htm), and [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm).

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[SetWinDelay](SetWinDelay.htm), [SetControlDelay](SetControlDelay.htm), [SendMode](SendMode.htm), [SetKeyDelay](SetKeyDelay.htm), [SetMouseDelay](SetMouseDelay.htm), [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm), [Critical](Critical.htm)

## Examples

Causes the script to sleep every 10 ms.

```
SetBatchLines, 10ms
```

Causes the script to sleep every 1000 lines.

```
SetBatchLines, 1000
```

