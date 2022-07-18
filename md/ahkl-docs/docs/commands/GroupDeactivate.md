# GroupDeactivate

Similar to [GroupActivate](GroupActivate.htm) except activates the next window **not** in the group.

```
<span class="func">GroupDeactivate</span>, GroupName <span class="optional">, Mode</span>
```

## Parameters

GroupName

The name of the target group, as originally defined by [GroupAdd](GroupAdd.htm).

Mode

If omitted, the command activates the oldest non-member window. To change this behavior, specify the following letter:

**R:** The newest non-member window (the one most recently active) is activated, but only if a member of the group is active when the command is given. "R" is useful in cases where you temporarily switch to working on an unrelated task. When you return to the group via [GroupActivate](GroupActivate.htm), GroupDeactivate, or [GroupClose](GroupClose.htm), the window you were most recently working with is activated rather than the oldest window.

## Remarks

GroupDeactivate causes the first window that does **not** match any of the group's window specifications to be activated. Using GroupDeactivate a second time will activate the next window in the series and so on. Normally, GroupDeactivate is assigned to a hotkey so that this window-traversal behavior is automated by pressing that key.

This command is useful in cases where you have a collection of favorite windows that are almost always running. By adding these windows to a group, you can use GroupDeactivate to visit each window that isn't one of your favorites and decide whether to close it. This allows you to clean up your desktop much more quickly than doing it manually.

See [GroupAdd](GroupAdd.htm) for more details about window groups.

## Related

[GroupAdd](GroupAdd.htm), [GroupActivate](GroupActivate.htm), [GroupClose](GroupClose.htm)

## Examples

Activates the oldest window which is not a member of a window group.

```
GroupDeactivate, MyFavoriteWindows  <em>; Visit non-favorite windows to clean up desktop.</em>
```

