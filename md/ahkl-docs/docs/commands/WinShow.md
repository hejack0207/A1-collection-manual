# WinShow

Unhides the specified window.

```
<span class="func">WinShow</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
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

By default, WinShow is the only command that can always detect hidden windows. Other commands can detect them only if [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

This command operates only upon the topmost matching window except when _WinTitle_ is [ahk\_group GroupName](GroupAdd.htm), in which case all windows in the group are affected.

## Related

[WinHide](WinHide.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow)

## Examples

Opens Notepad, waits until it exists, hides it for a short time and unhides it.

```
Run, notepad.exe
WinWait, Untitled - Notepad
Sleep, 500
WinHide <em>; Use the window found by WinWait.</em>
Sleep, 1000
WinShow <em>; Use the window found by WinWait.</em>
```

