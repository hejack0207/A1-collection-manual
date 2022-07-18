# WinExist()

Checks if the specified window exists and returns the unique ID (HWND) of the first matching window.

```
UniqueID := <span class="func">WinExist</span>(<span class="optional">WinTitle, WinText, ExcludeTitle, ExcludeText</span>)
```

## Parameters

WinTitleA window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).WinTextIf present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.ExcludeTitleWindows whose titles include this value will not be considered.ExcludeTextWindows whose text include this value will not be considered.

## Return Value

This function returns the [unique ID (HWND)](../misc/WinTitle.htm#ahk_id) (as hexadecimal integer) of the first matching window (0 if none).

Since all non-zero numbers are seen as "true", the statement `if WinExist(WinTitle)` is true whenever WinTitle exists.

## Remarks

If all parameters are omitted, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be checked to see if it still exists.

If a qualified window exists, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be updated to be that window.

To discover the HWND of a control (for use with [Post/SendMessage](PostMessage.htm) or [DllCall](DllCall.htm)), use [ControlGet Hwnd](ControlGet.htm#Hwnd) or [MouseGetPos](MouseGetPos.htm).

[SetWinDelay](SetWinDelay.htm) does not apply to this function.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[IfWinExist / IfWinNotExist](IfWinExist.htm), [WinActive()](WinActive.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm), [Last Found Window](../misc/WinTitle.htm#LastFoundWindow), [Process](Process.htm), [WinActivate](WinActivate.htm), [WinWaitActive](WinWaitActive.htm), [WinWait](WinWait.htm), [WinWaitClose](WinWaitClose.htm), [#IfWinActive/Exist](_IfWinActive.htm)

## Examples

Activates either Notepad or another window, depending on which of them was found by the WinExist functions above. Note that the space between an "ahk\_" keyword and its criterion value can be omitted; this is especially useful when using variables, as shown by the second WinExist.

```
if WinExist("ahk_class Notepad") or WinExist("ahk_class" ClassName)
    WinActivate <em>; Use the window found by WinExist.</em>
```

Retrieves and reports the unique ID (HWND) of the active window.

```
MsgBox % "The active window's ID is " WinExist("A")
```

Returns if the calculator does not exist.

```
if not WinExist("Calculator")
    return
```

