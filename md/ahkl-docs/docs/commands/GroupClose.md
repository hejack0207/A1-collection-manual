# GroupClose

Closes the active window if it was just activated by [GroupActivate](GroupActivate.htm) or [GroupDeactivate](GroupDeactivate.htm). It then activates the next window in the series. It can also close all windows in a group.

```
<span class="func">GroupClose</span>, GroupName <span class="optional">, Mode</span>
```

## Parameters

GroupName

The name of the group as originally defined by [GroupAdd](GroupAdd.htm).

Mode

If omitted, the command closes the active window and activates the oldest window in the series. To change this behavior, specify one of the following letters:

**R:** The newest window (the one most recently active) is activated, but only if no members of the group are active when the command is given. "R" is useful in cases where you temporarily switch to working on an unrelated task. When you return to the group via [GroupActivate](GroupActivate.htm), [GroupDeactivate](GroupDeactivate.htm), or GroupClose, the window you were most recently working with is activated rather than the oldest window.

**A:** All members of the group will be closed. This is the same effect as `<a href="WinClose.htm" data-index="6">WinClose</a> ahk_group GroupName`.

## Remarks

When the _Mode_ parameter is not "A", the behavior of this command is determined by whether the previous action on _GroupName_ was [GroupActivate](GroupActivate.htm) or [GroupDeactivate](GroupDeactivate.htm). If it was [GroupDeactivate](GroupDeactivate.htm), this command will close the active window only if it is **not** a member of the group (otherwise it will do nothing). If it was [GroupActivate](GroupActivate.htm) or nothing, this command will close the active window only if it **is** a member of the group (otherwise it will do nothing). This behavior allows GroupClose to be assigned to a hotkey as a companion to _GroupName_'s [GroupActivate](GroupActivate.htm) or [GroupDeactivate](GroupDeactivate.htm) hotkey.

See [GroupAdd](GroupAdd.htm) for more details about window groups.

## Related

[GroupAdd](GroupAdd.htm), [GroupActivate](GroupActivate.htm), [GroupDeactivate](GroupDeactivate.htm)

## Examples

Closes the active window activated by [GroupActivate](GroupActivate.htm) or [GroupDeactivate](GroupDeactivate.htm) and activates the newest window (the one most recently active) in a window group.

```
GroupClose, MyGroup, R
```

