# IfWinExist / IfWinNotExist

Checks if the specified window exists.

**Deprecated:** These control flow statements are not recommended for use in new scripts. Use the [WinExist](WinExist.htm) function instead.

```
<span class="func">IfWinExist</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
<span class="func">IfWinNotExist</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

WinTitleA window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).WinTextIf present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.ExcludeTitleWindows whose titles include this value will not be considered. Note: Due to backward compatibility, this parameter will be interpreted as a command if it exactly matches the name of a command. To work around this, use the [WinExist](WinExist.htm) function instead.ExcludeTextWindows whose text include this value will not be considered.

## Remarks

If all parameters are omitted, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be checked to see if it still exists (or doesn't exist in the case of _IfWinNotExist_).

If either of these control flow statements determines that a qualified window exists, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be updated to be that window. In other words, if _IfWinExist_ evaluates to true or _IfWinNotExist_ evaluates to false, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be updated.

To discover the HWND of a control (for use with [Post/SendMessage](PostMessage.htm) or [DllCall](DllCall.htm)), use [ControlGet Hwnd](ControlGet.htm#Hwnd) or [MouseGetPos](MouseGetPos.htm).

[SetWinDelay](SetWinDelay.htm) does not apply to these control flow statements.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinExist()](WinExist.htm), [WinActive()](WinActive.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow), [Process](Process.htm), [WinActivate](WinActivate.htm), [WinWaitActive](WinWaitActive.htm), [WinWait](WinWait.htm), [WinWaitClose](WinWaitClose.htm), [#IfWinActive/Exist](_IfWinActive.htm)

## Examples

Activates and maximizes the Notepad window found by the IfWinExist statement above.

```
IfWinExist, Untitled - Notepad
{
    WinActivate <em>; Use the window found by IfWinExist.</em>
    WinMaximize <em>; Same as above.</em>
    Send, Some text.{Enter}
    return
}
```

Returns if the calculator does not exist, otherwise it will be activated and moved to a new position.

```
IfWinNotExist, Calculator
    return
else
{
    WinActivate <em>; Use the window found by IfWinNotExist.</em>
    WinMove, 40, 40 <em>; Same as above.</em>
    return
}
```

