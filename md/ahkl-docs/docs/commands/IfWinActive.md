# IfWinActive / IfWinNotActive

Checks if the specified window exists and is currently active (foremost).

**Deprecated:** These control flow statements are not recommended for use in new scripts. Use the [WinActive](WinActive.htm) function instead.

```
<span class="func">IfWinActive</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
<span class="func">IfWinNotActive</span> <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

WinTitleA window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).WinTextIf present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.ExcludeTitleWindows whose titles include this value will not be considered. Note: Due to backward compatibility, this parameter will be interpreted as a command if it exactly matches the name of a command. To work around this, use the [WinActive](WinActive.htm) function instead.ExcludeTextWindows whose text include this value will not be considered.

## Remarks

If all parameters are omitted, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be used.

If either of these control flow statements determines that the active window is a qualified match, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be updated to be the active window. In other words, if _IfWinActive_ evaluates to true or _IfWinNotActive_ evaluates to false, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be updated.

An easy way to retrieve the unique ID of the active window is with `ActiveHwnd := WinExist("A")`.

[SetWinDelay](SetWinDelay.htm) does not apply to these control flow statements.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinActive()](WinActive.htm), [IfWinExist / IfWinNotExist](IfWinExist.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow), [WinActivate](WinActivate.htm), [WinWaitActive](WinWaitActive.htm), [WinWait](WinWait.htm), [WinWaitClose](WinWaitClose.htm), [#IfWinActive/Exist](_IfWinActive.htm)

## Examples

Maximizes the Notepad window found by the IfWinActive statement above.

```
IfWinActive, Untitled - Notepad
{
    WinMaximize <em>; Use the window found by IfWinActive.</em>
    Send, Some text.{Enter}
    return
}
```

