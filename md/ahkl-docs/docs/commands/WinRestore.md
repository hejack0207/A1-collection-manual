# WinRestore

Unminimizes or unmaximizes the specified window if it is minimized or maximized.

```
<span class="func">WinRestore</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

If a particular type of window does not respond correctly to WinRestore, try using the following instead:

```
<a href="PostMessage.htm" data-index="3">PostMessage</a>, 0x0112, 0xF120,,, WinTitle, WinText  <em>; 0x0112 = WM_SYSCOMMAND, 0xF120 = SC_RESTORE</em>
```

This command operates only upon the topmost matching window except when _WinTitle_ is [ahk\_group GroupName](GroupAdd.htm), in which case all windows in the group are affected.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinMinimize](WinMinimize.htm), [WinMaximize](WinMaximize.htm)

## Examples

Unminimizes or unmaximizes Notepad if it is minimized or maximized.

```
WinRestore, Untitled - Notepad
```

