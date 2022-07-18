# WinHide

Hides the specified window.

```
<span class="func">WinHide</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
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

Use [WinShow](WinShow.htm) to unhide a hidden window ( [DetectHiddenWindows](DetectHiddenWindows.htm) can be either On or Off to do this).

This command operates only upon the topmost matching window except when _WinTitle_ is [ahk\_group GroupName](GroupAdd.htm), in which case all windows in the group are affected.

The Explorer taskbar may be hidden/shown as follows:

```
WinHide ahk_class Shell_TrayWnd
WinShow ahk_class Shell_TrayWnd
```

## Related

[WinShow](WinShow.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow), [WinSet](WinSet.htm)

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

