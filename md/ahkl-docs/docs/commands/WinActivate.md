# WinActivate

Activates the specified window.

```
<span class="func">WinActivate</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
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

When an inactive window becomes active, the operating system also makes it foremost (brings it to the top of the stack). This does not occur if the window is already active.

If the window is minimized and inactive, it is automatically restored prior to being activated. [v1.1.20+]: If _WinTitle_ is the letter "A" and the other parameters are omitted, the active window is restored. [v1.1.28.02+]: The window is restored even if it was already active.

Six attempts will be made to activate the target window over the course of 60ms. If all six attempts fail, WinActivate automatically sends `{Alt 2}` as a workaround for possible restrictions enforced by the operating system, and then makes a seventh attempt. Thus, it is usually unnecessary to follow WinActivate with [WinWaitActive](WinWaitActive.htm), [WinActive()](WinActive.htm) or [IfWinNotActive](IfWinActive.htm).

In general, if more than one window matches, the topmost matching window (typically the one most recently used) will be activated. If the window is already active, it will be kept active rather than activating any other matching window beneath it. However, if the active window is moved to the bottom of the stack with [WinSet Bottom](WinSet.htm#Bottom), some other window may be activated even if the active window is a match.

[WinActivateBottom](WinActivateBottom.htm) activates the bottommost matching window (typically the one least recently used).

[GroupActivate](GroupActivate.htm) activates the next window that matches criteria specified by a window group.

[v1.1.20+]: If the active window is hidden and [DetectHiddenWindows](DetectHiddenWindows.htm) is turned off, it is never considered a match. Instead, a visible matching window is activated if one exists.

When a window is activated immediately after the activation of some other window, task bar buttons might start flashing on some systems (depending on OS and settings). To prevent this, use [#WinActivateForce](_WinActivateForce.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

**Known issue:** If the script is running on a computer or server being accessed via remote desktop, WinActivate may hang if the remote desktop client is minimized. One workaround is to use commands which don't require window activation, such as [ControlSend](ControlSend.htm) and [ControlClick](ControlClick.htm). Another possible workaround is to apply the following registry setting on the local/client computer:

```
<em>; Change HKCU to HKLM to affect all users on this system.</em>
RegWrite REG_DWORD, HKCU, Software\Microsoft\Terminal Server Client
    , RemoteDesktop_SuppressWhenMinimized, 2
```

## Related

[WinActivateBottom](WinActivateBottom.htm), [#WinActivateForce](_WinActivateForce.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow), [WinExist()](WinExist.htm), [WinActive()](WinActive.htm), [WinWaitActive](WinWaitActive.htm), [WinWait](WinWait.htm), [WinWaitClose](WinWaitClose.htm), [WinClose](WinClose.htm), [GroupActivate](GroupActivate.htm), [WinSet](WinSet.htm)

## Examples

If Notepad does exist, activate it, otherwise activate the calculator.

```
if WinExist("Untitled - Notepad")
    WinActivate <em>; Use the window found by WinExist.</em>
else
    WinActivate, Calculator
```

