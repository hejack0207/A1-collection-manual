# ControlMove

Moves or resizes a control.

```
<span class="func">ControlMove</span>, Control, X, Y, Width, Height <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

Control

Can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm). If this parameter is blank, the target window's topmost control will be used.

To operate upon a control's HWND (window handle), leave the _Control_ parameter blank and specify `ahk_id %ControlHwnd%` for the _WinTitle_ parameter (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off). The HWND of a control is typically retrieved via [ControlGet Hwnd](ControlGet.htm#Hwnd), [MouseGetPos](MouseGetPos.htm), or [DllCall()](DllCall.htm).

X, Y

The X and Y coordinates (in pixels) of the upper left corner of _Control_'s new location, which can be [expressions](../Variables.htm#Expressions). If either coordinate is blank, _Control_'s position in that dimension will not be changed. The coordinates are relative to the upper-left corner of the _Control_'s parent window; [ControlGetPos](ControlGetPos.htm) or Window Spy can be used to determine them.

Width, Height

The new width and height of _Control_ (in pixels), which can be [expressions](../Variables.htm#Expressions). If either parameter is blank or omitted, _Control_'s size in that dimension will not be changed.

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

To improve reliability, a delay is done automatically after every use of this command. That delay can be changed via [SetControlDelay](SetControlDelay.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[ControlGetPos](ControlGetPos.htm), [WinMove](WinMove.htm), [SetControlDelay](SetControlDelay.htm), [Control](Control.htm), [ControlGet](ControlGet.htm), [ControlGetText](ControlGetText.htm), [ControlSetText](ControlSetText.htm), [ControlClick](ControlClick.htm), [ControlFocus](ControlFocus.htm), [ControlSend](ControlSend.htm)

## Examples

Demonstrates how to manipulate the OK button of an input box while the script is waiting for user input.

```
SetTimer, ControlMoveTimer
InputBox, OutputVar, My Input Box
return

ControlMoveTimer:
if not WinExist("My Input Box")
    return
<em>; Otherwise the above set the "last found" window for us:</em>
SetTimer, ControlMoveTimer, Off
WinActivate
ControlMove, OK, 10, , 200  <em>; Move the OK button to the left and increase its width.</em>
return
```

