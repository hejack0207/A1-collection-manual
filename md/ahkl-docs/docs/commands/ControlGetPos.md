# ControlGetPos

Retrieves the position and size of a control.

```
<span class="func">ControlGetPos</span> <span class="optional">, X, Y, Width, Height, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

X, Y

The names of the variables in which to store the X and Y coordinates (in pixels) of _Control_'s upper left corner. These coordinates are relative to the target window's upper-left corner and thus are the same as those used by [ControlMove](ControlMove.htm).

If either X or Y is omitted, the corresponding values will not be stored.

Width, Height

The names of the variables in which to store _Control_'s width and height (in pixels). If omitted, the corresponding values will not be stored.

Control

Can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm). If this parameter is blank, the target window's topmost control will be used.

To operate upon a control's HWND (window handle), leave the _Control_ parameter blank and specify `ahk_id %ControlHwnd%` for the _WinTitle_ parameter (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off). The HWND of a control is typically retrieved via [ControlGet Hwnd](ControlGet.htm#Hwnd), [MouseGetPos](MouseGetPos.htm), or [DllCall()](DllCall.htm).

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

If no matching window or control is found, the output variables will be made blank.

Unlike commands that change a control, ControlGetPos does not have an automatic delay ( [SetControlDelay](SetControlDelay.htm) does not affect it).

To discover the ClassNN or HWND of the control that the mouse is currently hovering over, use [MouseGetPos](MouseGetPos.htm). To retrieve a list of all controls in a window, use [WinGet ControlList](WinGet.htm#ControlList).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[ControlMove](ControlMove.htm), [WinGetPos](WinGetPos.htm), [Control](Control.htm), [ControlGet](ControlGet.htm), [ControlGetText](ControlGetText.htm), [ControlSetText](ControlSetText.htm), [ControlClick](ControlClick.htm), [ControlFocus](ControlFocus.htm), [ControlSend](ControlSend.htm)

## Examples

Continuously updates and displays the name and position of the control currently under the mouse cursor.

```
Loop
{
    Sleep, 100
    MouseGetPos, , , WhichWindow, WhichControl
    ControlGetPos, x, y, w, h, %WhichControl%, ahk_id %WhichWindow%
    ToolTip, %WhichControl%`nX%X%`tY%Y%`nW%W%`t%H%
}
```

