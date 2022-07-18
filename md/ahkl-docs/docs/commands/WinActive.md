# WinActive()

Checks if the specified window is active and returns its unique ID (HWND).

```
UniqueID := <span class="func">WinActive</span>(<span class="optional">WinTitle, WinText, ExcludeTitle, ExcludeText</span>)
```

## Parameters

WinTitleA window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).WinTextIf present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.ExcludeTitleWindows whose titles include this value will not be considered.ExcludeTextWindows whose text include this value will not be considered.

## Return Value

This function returns the [unique ID (HWND)](../misc/WinTitle.htm#ahk_id) (as hexadecimal integer) of the active window if it matches the specified criteria, or 0 if it does not.

Since all non-zero numbers are seen as "true", the statement `if WinActive(WinTitle)` is true whenever WinTitle is active.

## Remarks

If all parameters are omitted, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be used.

If the active window is a qualified match, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be updated to be the active window.

An easy way to retrieve the unique ID of the active window is with `ActiveHwnd := WinExist("A")`.

[SetWinDelay](SetWinDelay.htm) does not apply to this function.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[IfWinActive / IfWinNotActive](IfWinActive.htm), [WinExist()](WinExist.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow), [WinActivate](WinActivate.htm), [WinWaitActive](WinWaitActive.htm), [WinWait](WinWait.htm), [WinWaitClose](WinWaitClose.htm), [#IfWinActive/Exist](_IfWinActive.htm)

## Examples

Closes either Notepad or another window, depending on which of them was found by the WinActive functions above. Note that the space between an "ahk\_" keyword and its criterion value can be omitted; this is especially useful when using variables, as shown by the second WinActive.

```
if WinActive("ahk_class Notepad") or WinActive("ahk_class" ClassName)
    WinClose <em>; Use the window found by WinActive.</em>
```

