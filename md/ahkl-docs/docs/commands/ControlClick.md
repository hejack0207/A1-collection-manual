# ControlClick

Sends a mouse button or mouse wheel event to a control.

```
<span class="func">ControlClick</span> <span class="optional">, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText</span>
```

## Parameters

Control-or-Pos

If this parameter is blank, the target window's topmost control will be clicked (or the target window itself if it has no controls). Otherwise, one of the two modes below will be used.

Mode 1 (Position): Specify the X and Y coordinates relative to the target window's upper left corner. The X coordinate must precede the Y coordinate and there must be at least one space or tab between them. For example: `X55 Y33`. If there is a control at the specified coordinates, it will be sent the click-event at those exact coordinates. If there is no control, the target window itself will be sent the event (which might have no effect depending on the nature of the window).

**Note**: In mode 1, the X and Y option letters of the _Options_ parameter are ignored.

Mode 2 (ClassNN or Text): Specify either ClassNN (the classname and instance number of the control) or the name/text of the control, both of which can be determined via Window Spy. When using name/text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm).

By default, mode 2 takes precedence over mode 1. For example, in the unlikely event that there is a control whose text or ClassNN has the format "Xnnn Ynnn", it would be acted upon by Mode 2. To override this and use mode 1 unconditionally, specify the word Pos in _Options_ as in the following example: `ControlClick, x255 y152, WinTitle,,,, Pos`.

To operate upon a control's HWND (window handle), leave this parameter blank and specify `ahk_id %ControlHwnd%` for the _WinTitle_ parameter (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off). The HWND of a control is typically retrieved via [ControlGet Hwnd](ControlGet.htm#Hwnd), [MouseGetPos](MouseGetPos.htm), or [DllCall()](DllCall.htm).

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

WhichButton

The button to click: LEFT, RIGHT, MIDDLE (or just the first letter of each of these). If omitted or blank, the LEFT button will be used.

X1 (XButton1, the 4th mouse button) and X2 (XButton2, the 5th mouse button) are also supported.

WheelUp (or WU) and WheelDown (or WD) are also supported. In this case, _ClickCount_ is the number of notches to turn the wheel.

Windows Vista or later [v1.0.48+]: WheelLeft (or WL) and WheelRight (or WR) are also supported (they have no effect on older operating systems). In this case, _ClickCount_ is the number of notches to turn the wheel.

ClickCount

The number of clicks to send, which can be an [expression](../Variables.htm#Expressions). If omitted or blank, 1 click is sent.

Options

A series of zero or more of the following option letters. For example: `d x50 y25`.

**NA**[v1.0.45+]: May improve reliability. See [reliability](#Reliability) below.

**D**: Press the mouse button down but do not release it (i.e. generate a down-event). If both the **D** and **U** options are absent, a complete click (down and up) will be sent.

**U**: Release the mouse button (i.e. generate an up-event). This option should not be present if the **D** option is already present (and vice versa).

**Pos**: Specify the word Pos anywhere in _Options_ to unconditionally use the X/Y positioning mode as described in the _Control-or-Pos_ parameter above.

**Xn**: Specify for **n** the X position to click at, relative to the control's upper left corner. If unspecified, the click will occur at the horizontal-center of the control.

**Yn**: Specify for **n** the Y position to click at, relative to the control's upper left corner. If unspecified, the click will occur at the vertical-center of the control.

Use decimal (not hexadecimal) numbers for the **X** and **Y** options.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Reliability

To improve reliability -- especially during times when the user is physically moving the mouse during the ControlClick -- one or both of the following may help:

1) Use `<a href="SetControlDelay.htm" data-index="12">SetControlDelay</a> -1` prior to ControlClick. This avoids holding the mouse button down during the click, which in turn reduces interference from the user's physical movement of the mouse.

2) Specify the string NA anywhere in the sixth parameter ( _Options_) as shown below:

```
SetControlDelay -1
ControlClick, Toolbar321, WinTitle,,,, NA
```

`NA` avoids marking the target window as active and avoids merging its input processing with that of the script, which may prevent physical movement of the mouse from interfering (but usually only when the target window is not active). However, this method might not work for all types of windows and controls.

## Remarks

Not all applications obey a _ClickCount_ higher than 1 for turning the mouse wheel. For those applications, use a Loop to turn the wheel more than one notch as in this example, which turns it 5 notches:

```
Loop, 5
    ControlClick, <i>Control</i>, <i>WinTitle</i>, <i>WinText</i>, WheelUp
```

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[SetControlDelay](SetControlDelay.htm), [Control](Control.htm), [ControlGet](ControlGet.htm), [ControlGetText](ControlGetText.htm), [ControlMove](ControlMove.htm), [ControlGetPos](ControlGetPos.htm), [ControlFocus](ControlFocus.htm), [ControlSetText](ControlSetText.htm), [ControlSend](ControlSend.htm), [Click](Click.htm)

## Examples

Clicks the OK button.

```
ControlClick, OK, Some Window Title
```

Clicks at a set of coordinates. Note the lack of a comma between X and Y.

```
ControlClick, x55 y77, Some Window Title
```

Clicks in NA mode at coordinates that are relative to a named control.

```
SetControlDelay -1  <em>; May improve reliability and reduce side effects.</em>
ControlClick, Toolbar321, Some Window Title,,,, NA x192 y10
```

