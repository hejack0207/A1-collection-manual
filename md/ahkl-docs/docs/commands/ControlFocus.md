# ControlFocus

Sets input focus to a given control on a window.

```
<span class="func">ControlFocus</span> <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

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

To be effective, the control's window generally must not be minimized or hidden.

To improve reliability, a delay is done automatically after every use of this command. That delay can be changed via [SetControlDelay](SetControlDelay.htm).

To discover the ClassNN or HWND of the control that the mouse is currently hovering over, use [MouseGetPos](MouseGetPos.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[SetControlDelay](SetControlDelay.htm), [ControlGetFocus](ControlGetFocus.htm), [Control](Control.htm), [ControlGet](ControlGet.htm), [ControlMove](ControlMove.htm), [ControlGetPos](ControlGetPos.htm), [ControlClick](ControlClick.htm), [ControlGetText](ControlGetText.htm), [ControlSetText](ControlSetText.htm), [ControlSend](ControlSend.htm)

## Examples

Sets the input focus to the OK button.

```
ControlFocus, OK, Some Window Title
```

