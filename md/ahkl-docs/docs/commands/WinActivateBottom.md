# WinActivateBottom

Same as [WinActivate](WinActivate.htm) except that it activates the bottommost matching window rather than the topmost.

```
<span class="func">WinActivateBottom</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
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

The bottommost window is typically the one least recently used, except when windows have been reordered, such as with [WinSet Bottom](WinSet.htm#Bottom).

If there is only one matching window, WinActivateBottom behaves identically to [WinActivate](WinActivate.htm).

[Window groups](GroupAdd.htm) are more advanced than this command, so consider using them for more features and flexibility.

If the window is minimized and inactive, it is automatically restored prior to being activated. [v1.1.20+]: If _WinTitle_ is the letter "A" and the other parameters are omitted, the active window is restored. [v1.1.28.02+]: The window is restored even if it was already active.

Six attempts will be made to activate the target window over the course of 60ms. Thus, it is usually unnecessary to follow it with the [WinWaitActive](WinWaitActive.htm) command.

Unlike [WinActivate](WinActivate.htm), the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) cannot be used because it might not be the bottommost window. Therefore, at least one of the parameters must be non-blank.

When a window is activated immediately after another window was activated, task bar buttons may start flashing on some systems (depending on OS and settings). To prevent this, use [#WinActivateForce](_WinActivateForce.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinActivate](WinActivate.htm), [#WinActivateForce](_WinActivateForce.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [WinExist()](WinExist.htm), [WinActive()](WinActive.htm), [WinWaitActive](WinWaitActive.htm), [WinWait](WinWait.htm), [WinWaitClose](WinWaitClose.htm), [GroupActivate](GroupActivate.htm)

## Examples

Press a hotkey to visit all open browser windows in order from oldest to newest.

```
#i:: <em>; Win+I</em>
SetTitleMatchMode, 2
WinActivateBottom, - Microsoft Internet Explorer
return
```

