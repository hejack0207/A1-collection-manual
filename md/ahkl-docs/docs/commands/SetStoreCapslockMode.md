# SetStoreCapsLockMode

Whether to restore the state of CapsLock after a [Send](Send.htm).

```
<span class="func">SetStoreCapsLockMode</span>, OnOff
```

## Parameters

OnOff

One of the following values:

**On**: This is the initial setting for all scripts: CapsLock will be restored to its former value if [Send](Send.htm) needed to change it temporarily for its operation.

**Off**: The state of CapsLock is not changed at all. As a result, [Send](Send.htm) will invert the case of the characters if CapsLock happens to be ON during the operation.

[v1.1.30+]: The decimal values 1 and 0 may be used in place of On and Off, respectively.

## Remarks

This means that CapsLock will not always be turned off for [Send](Send.htm) and [ControlSend](ControlSend.htm). Even when it is successfully turned off, it might not get turned back on after the keys are sent.

This command is rarely used because the default behavior is best in most cases.

This setting is ignored by [blind mode](Send.htm#blind) and (in [v1.1.29+]) [text mode](Send.htm#SendText); that is, the state of CapsLock is not changed in those cases.

[v1.1.23+]: The built-in variable **A\_StoreCapsLockMode** contains the current setting.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[SetCaps/Num/ScrollLockState](SetNumScrollCapsLockState.htm), [Send](Send.htm), [ControlSend](ControlSend.htm)

## Examples

Causes the state of CapsLock not to be changed at all.

```
SetStoreCapsLockMode, Off
```

