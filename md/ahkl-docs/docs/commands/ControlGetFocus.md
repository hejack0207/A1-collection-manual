# ControlGetFocus

Retrieves which control of the target window has input focus, if any.

```
<span class="func">ControlGetFocus</span>, OutputVar <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

OutputVar

The name of the variable in which to store the identifier of the control, which consists of its classname followed by its sequence number within its parent window, e.g. Button12.

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

[ErrorLevel](../misc/ErrorLevel.htm) is set to 0 if the control with input focus was successfully retrieved. Otherwise (e.g. the target window doesn't exist or none of its controls have input focus) it will be set to 1.

## Remarks

The control retrieved by this command is the one that has keyboard focus, that is, the one that would receive keystrokes if the user were to type any.

The target window must be active to have a focused control. If the window is not active, _OutputVar_ will be made blank.

Prior to [v1.1.19.03], if ControlGetFocus was executed repeatedly at a high frequency (i.e. every 500 ms or faster), it usually disrupted the user's ability to double-click. This has been fixed.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[ControlFocus](ControlFocus.htm), [ControlMove](ControlMove.htm), [ControlClick](ControlClick.htm), [ControlGetText](ControlGetText.htm), [ControlSetText](ControlSetText.htm), [ControlSend](ControlSend.htm)

## Examples

Reports the ClassNN of the control which has the input focus in Notepad.

```
ControlGetFocus, OutputVar, Untitled - Notepad
if ErrorLevel
    MsgBox, The target window doesn't exist or none of its controls has input focus.
else
    MsgBox, Control with focus = %OutputVar%
```

