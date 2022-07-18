# GroupActivate

Activates the next window in a window group that was defined with [GroupAdd](GroupAdd.htm).

```
<span class="func">GroupActivate</span>, GroupName <span class="optional">, Mode</span>
```

## Parameters

GroupName

The name of the group to activate, as originally defined by [GroupAdd](GroupAdd.htm).

Mode

If omitted, the command activates the oldest window in the series. To change this behavior, specify the following letter:

**R:** The newest window (the one most recently active) is activated, but only if no members of the group are active when the command is given. "R" is useful in cases where you temporarily switch to working on an unrelated task. When you return to the group via GroupActivate, [GroupDeactivate](GroupDeactivate.htm), or [GroupClose](GroupClose.htm), the window you were most recently working with is activated rather than the oldest window.

## ErrorLevel [AHK\_L 54+]

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if no window was found to activate or 0 otherwise.

## Remarks

This command causes the first window that matches any of the group's window specifications to be activated. Using it a second time will activate the next window in the series and so on. Normally, it is assigned to a hotkey so that this window-traversal behavior is automated by pressing that key.

When a window is activated immediately after another window was activated, task bar buttons may start flashing on some systems (depending on OS and settings). To prevent this, use [#WinActivateForce](_WinActivateForce.htm).

See [GroupAdd](GroupAdd.htm) for more details about window groups.

## Related

[GroupAdd](GroupAdd.htm), [GroupDeactivate](GroupDeactivate.htm), [GroupClose](GroupClose.htm), [#WinActivateForce](_WinActivateForce.htm)

## Examples

Activates the newest window (the one most recently active) in a window group.

```
GroupActivate, MyGroup, R
```

