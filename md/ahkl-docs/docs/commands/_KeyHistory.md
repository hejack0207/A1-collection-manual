# \#KeyHistory

Sets the maximum number of keyboard and mouse events displayed by the [KeyHistory](KeyHistory.htm) window. You can set it to 0 to disable key history.

```
<span class="func">#KeyHistory</span> MaxEvents
```

## Parameters

MaxEvents

The maximum number of keyboard and mouse events displayed by the [KeyHistory](KeyHistory.htm) window (default 40, limit 500). Specify 0 to disable key history entirely.

## Remarks

Because this setting is put into effect before the script begins running, it is only necessary to specify it once (anywhere in the script).

Because each keystroke or mouse click consists of a down-event and an up-event, [KeyHistory](KeyHistory.htm) displays only half as many "complete events" as specified here. For example, if the script contains `#KeyHistory 50`, up to 25 keystrokes and mouse clicks will be displayed.

Like other directives, #KeyHistory cannot be executed conditionally.

## Related

[KeyHistory](KeyHistory.htm), [#NoTrayIcon](_NoTrayIcon.htm)

## Examples

Causes [KeyHistory](KeyHistory.htm) to display the last 100 instead 40 keyboard and mouse events.

```
#KeyHistory 100
```

Disables key history entirely.

```
#KeyHistory 0
```

