# ControlGetText

Retrieves text from a control.

```
<span class="func">ControlGetText</span>, OutputVar <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved text.

Control

Can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm). If this parameter is blank or omitted, the target window's topmost control will be used.

To operate upon a control's HWND (window handle), leave the _Control_ parameter blank and specify `ahk_id %ControlHwnd%` for the _WinTitle_ parameter (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off). The HWND of a control is typically retrieved via [ControlGet Hwnd](ControlGet.htm#Hwnd), [MouseGetPos](MouseGetPos.htm), or [DllCall()](DllCall.htm).

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

**Note**: To retrieve text from a ListView, ListBox, or ComboBox, use [ControlGet List](ControlGet.htm#List) instead.

If the retrieved text appears to be truncated (incomplete), try using `<a href="VarSetCapacity.htm" data-index="11">VarSetCapacity</a>(OutputVar, 55)` prior to ControlGetText [replace 55 with a size that is considerably longer than the truncated text]. This is necessary because some applications do not respond properly to the WM\_GETTEXTLENGTH message, which causes AutoHotkey to make the output variable too small to fit all the text.

The amount of text retrieved is limited to a variable's maximum capacity (which can be changed via the [#MaxMem](_MaxMem.htm) directive). As a result, this command might use a large amount RAM if the target control (e.g. an editor with a large document open) contains a large quantity of text. However, a variable's memory can be freed after use by assigning it to nothing, i.e. `OutputVar =`.

Text retrieved from most control types uses carriage return and linefeed (\`r\`n) rather than a solitary linefeed (\`n) to mark the end of each line.

It is not necessary to do `SetTitleMatchMode Slow` because ControlGetText always retrieves the text using the slow method (since it works on a broader range of control types).

To retrieve a list of all controls in a window, use [WinGet ControlList](WinGet.htm#ControlList).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[ControlSetText](ControlSetText.htm), [WinGetText](WinGetText.htm), [Control](Control.htm), [ControlGet](ControlGet.htm), [ControlMove](ControlMove.htm), [ControlFocus](ControlFocus.htm), [ControlClick](ControlClick.htm), [ControlSend](ControlSend.htm), [#MaxMem](_MaxMem.htm)

## Examples

Retrieves the current text from Notepad's edit control and stores it in OutputVar.

```
ControlGetText, OutputVar, Edit1, Untitled -
```

