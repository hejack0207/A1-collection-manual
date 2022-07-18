# WinMaximize

Enlarges the specified window to its maximum size.

```
<span class="func">WinMaximize</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
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

Use [WinRestore](WinRestore.htm) to unmaximize a window and [WinMinimize](WinMinimize.htm) to minimize it.

If a particular type of window does not respond correctly to WinMaximize, try using the following instead:

```
<a href="PostMessage.htm" data-index="5">PostMessage</a>, 0x0112, 0xF030,,, WinTitle, WinText  <em>; 0x0112 = WM_SYSCOMMAND, 0xF030 = SC_MAXIMIZE</em>
```

This command operates only upon the topmost matching window except when _WinTitle_ is [ahk\_group GroupName](GroupAdd.htm), in which case all windows in the group are affected.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinRestore](WinRestore.htm), [WinMinimize](WinMinimize.htm)

## Examples

Opens Notepad, waits until it exists and maximizes it.

```
Run, notepad.exe
WinWait, Untitled - Notepad
WinMaximize <em>; Use the window found by WinWait.</em>
```

Press a hotkey to maximize the active window.

```
^Up::WinMaximize, A  <em>; Ctrl+Up</em>
```

