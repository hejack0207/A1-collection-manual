# WinWaitClose

Waits until the specified window does not exist.

```
<span class="func">WinWaitClose</span> <span class="optional">, WinTitle, WinText, Timeout, ExcludeTitle, ExcludeText</span>
```

## Parameters

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

Timeout

How many seconds to wait before timing out and setting [ErrorLevel](../misc/ErrorLevel.htm) to 1. Leave blank to allow the command to wait indefinitely. Specifying 0 is the same as specifying 0.5. This parameter can be an [expression](../Variables.htm#Expressions).

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## ErrorLevel

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the command timed out or 0 otherwise.

## Remarks

Whenever no instances of the specified window exist, the command will not wait for _Timeout_ to expire. Instead, it will immediately set [ErrorLevel](../misc/ErrorLevel.htm) to 0 and the script will continue executing.

While the command is in a waiting state, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

If another [thread](../misc/Threads.htm) changes the contents of any variable(s) that were used for this command's parameters, the command will not see the change -- it will continue to use the title and text that were originally present in the variables when the command first started waiting.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinClose](WinClose.htm), [WinWait](WinWait.htm), [WinWaitActive](WinWaitActive.htm), [WinExist()](WinExist.htm), [WinActive()](WinActive.htm), [Process](Process.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm)

## Examples

Opens Notepad, waits until it exists and then waits until it is closed.

```
Run, notepad.exe
WinWait, Untitled - Notepad
WinWaitClose <em>; Use the window found by WinWait.</em>
MsgBox, Notepad is now closed.
```

