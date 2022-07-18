# WinKill

Forces the specified window to close.

```
<span class="func">WinKill</span> <span class="optional">, WinTitle, WinText, SecondsToWait, ExcludeTitle, ExcludeText</span>
```

## Parameters

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

SecondsToWait

If omitted or blank, the command will not wait at all. If 0, it will wait 500ms. Otherwise, it will wait the indicated number of seconds (can contain a decimal point or be an [expression](../Variables.htm#Expressions)) for the window to close. If the window does not close within that period, the script will continue. ErrorLevel is **not** set by this command, so use [WinExist()](WinExist.htm), [IfWinExist](IfWinExist.htm) or [WinWaitClose](WinWaitClose.htm) if you need to determine for certain that a window is closed.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

This command first makes a brief attempt to close the window normally. If that fails, it will attempt to force the window closed by terminating its process.

If a matching window is active, that window will be closed in preference to any other matching window. In general, if more than one window matches, the topmost (most recently used) will be closed.

This command operates only upon a single window except when _WinTitle_ is [ahk\_group GroupName](GroupAdd.htm), in which case all windows in the group are affected.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinClose](WinClose.htm), [WinWaitClose](WinWaitClose.htm), [Process](Process.htm), [WinActivate](WinActivate.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow), [WinExist()](WinExist.htm), [WinActive()](WinActive.htm), [WinWaitActive](WinWaitActive.htm), [WinWait](WinWait.htm), [GroupActivate](GroupActivate.htm)

## Examples

If Notepad does exist, force it to close, otherwise force the calculator to close.

```
if WinExist("Untitled - Notepad")
    WinKill <em>; Use the window found by WinExist.</em>
else
    WinKill, Calculator
```

