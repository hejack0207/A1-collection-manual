# WinGetPos

Retrieves the position and size of the specified window.

```
<span class="func">WinGetPos</span> <span class="optional">, X, Y, Width, Height, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

X, Y

The names of the variables in which to store the X and Y coordinates of the target window's upper left corner. If omitted, the corresponding values will not be stored.

Width, Height

The names of the variables in which to store the width and height of the target window. If omitted, the corresponding values will not be stored.

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

If no matching window is found, the output variables will be made blank.

If the _WinTitle_ "Program Manager" is used, the command will retrieve the size of the desktop, which is usually the same as the current screen resolution.

A minimized window will still have a position and size. The values returned in this case may vary depending on OS and configuration.

To discover the name of the window and control that the mouse is currently hovering over, use [MouseGetPos](MouseGetPos.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinMove](WinMove.htm), [ControlGetPos](ControlGetPos.htm), [WinGetActiveStats](WinGetActiveStats.htm), [WinGetActiveTitle](WinGetActiveTitle.htm), [WinGetTitle](WinGetTitle.htm), [WinGetText](WinGetText.htm), [ControlGetText](ControlGetText.htm)

## Examples

Retrieves and reports the position and size of the calculator.

```
WinGetPos, X, Y, W, H, Calculator
MsgBox, Calculator is at %X%`,%Y% and its size is %W%x%H%
```

Retrieves and reports the position of the active window.

```
WinGetPos, X, Y,,, A
MsgBox, The active window is at %X%`,%Y%
```

If Notepad does exist, retrieve and report its position.

```
if WinExist("Untitled - Notepad")
{
    WinGetPos, Xpos, Ypos <em>; Use the window found by WinExist.</em>
    MsgBox, Notepad is at %Xpos%`,%Ypos%
}
```

