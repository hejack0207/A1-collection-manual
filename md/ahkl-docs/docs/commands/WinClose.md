# WinClose

Closes the specified window.

```
<span class="func">WinClose</span> <span class="optional">, WinTitle, WinText, SecondsToWait, ExcludeTitle, ExcludeText</span>
```

## Parameters

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

SecondsToWait

If omitted or blank, the command will not wait at all. If 0, it will wait 500ms. Otherwise, it will wait the indicated number of seconds (can contain a decimal point or be an [expression](../Variables.htm#Expressions)) for the window to close. If the window does not close within that period, the script will continue. ErrorLevel is **not** set by this command, so use [WinExist()](WinExist.htm), [IfWinExist](IfWinExist.htm) or [WinWaitClose](WinWaitClose.htm) if you need to determine for certain that a window is closed. While the command is in a waiting state, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

This command sends a close message to a window. The result depends on the window (it may ask to save data, etc.)

If a matching window is active, that window will be closed in preference to any other matching window. In general, if more than one window matches, the topmost (most recently used) will be closed.

This command operates only upon a single window except when _WinTitle_ is [ahk\_group GroupName](GroupAdd.htm) (with no other criteria specified), in which case all windows in the group are affected.

WinClose sends a WM\_CLOSE message to the target window, which is a somewhat forceful method of closing it. An alternate method of closing is to send the following message. It might produce different behavior because it is similar in effect to pressing Alt+F4 or clicking the window's close button in its title bar:

```
PostMessage, 0x0112, 0xF060,,, WinTitle, WinText  <em>; 0x0112 = WM_SYSCOMMAND, 0xF060 = SC_CLOSE</em>
```

If a window does not close via WinClose, you can force it to close with [WinKill](WinKill.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinKill](WinKill.htm), [WinWaitClose](WinWaitClose.htm), [Process](Process.htm), [WinActivate](WinActivate.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow), [WinExist()](WinExist.htm), [WinActive()](WinActive.htm), [WinWaitActive](WinWaitActive.htm), [WinWait](WinWait.htm), [GroupActivate](GroupActivate.htm)

## Examples

If Notepad does exist, close it, otherwise close the calculator.

```
if WinExist("Untitled - Notepad")
    WinClose <em>; Use the window found by WinExist.</em>
else
    WinClose, Calculator
```

