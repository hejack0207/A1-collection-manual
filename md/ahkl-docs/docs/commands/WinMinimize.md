# WinMinimize

Collapses the specified window into a button on the task bar.

```
<span class="func">WinMinimize</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
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

Use [WinRestore](WinRestore.htm) or [WinMaximize](WinMaximize.htm) to unminimize a window.

WinMinimize minimizes the window using a direct method, bypassing the window message which is usually sent when the minimize button, window menu or taskbar is used to minimize the window. This prevents the window from overriding the action (such as to "minimize" to the taskbar by hiding the window), but may also prevent the window from responding correctly, such as to save the [current focus](ControlGetFocus.htm) for when the window is restored. It also prevents the "minimize" system sound from being played.

If a particular type of window does not respond correctly to WinMinimize, try using the following instead:

```
<a href="PostMessage.htm" data-index="6">PostMessage</a>, 0x0112, 0xF020,,, WinTitle, WinText <em>; 0x0112 = WM_SYSCOMMAND, 0xF020 = SC_MINIMIZE</em>
```

This command operates only upon the topmost matching window except when _WinTitle_ is [ahk\_group GroupName](GroupAdd.htm), in which case all windows in the group are affected.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinRestore](WinRestore.htm), [WinMaximize](WinMaximize.htm), [WinMinimizeAll](WinMinimizeAll.htm)

## Examples

Opens Notepad, waits until it exists and minimizes it.

```
Run, notepad.exe
WinWait, Untitled - Notepad
WinMinimize <em>; Use the window found by WinWait.</em>
```

Press a hotkey to minimize the active window.

```
^Down::WinMinimize, A  <em>; Ctrl+Down</em>
```

