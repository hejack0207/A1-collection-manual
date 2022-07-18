# MouseGetPos

Retrieves the current position of the mouse cursor, and optionally which window and control it is hovering over.

```
<span class="func">MouseGetPos</span> <span class="optional">, OutputVarX, OutputVarY, OutputVarWin, OutputVarControl, Flag</span>
```

## Parameters

OutputVarX, OutputVarY

The names of the variables in which to store the X and Y coordinates. The retrieved coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change to screen coordinates.

OutputVarWin

This optional parameter is the name of the variable in which to store the [unique ID number](WinGet.htm) of the window under the mouse cursor. If the window cannot be determined, this variable will be made blank.

The window does not have to be active to be detected. Hidden windows cannot be detected.

OutputVarControl

This optional parameter is the name of the variable in which to store the name (ClassNN) of the control under the mouse cursor. If the control cannot be determined, this variable will be made blank.

The names of controls should always match those shown by the version of Window Spy distributed with [v1.0.14+] (but not necessarily older versions of Window Spy). However, unlike Window Spy, the window under the mouse cursor does not have to be active for a control to be detected.

Flag

If omitted or 0, the command uses the default method to determine _OutputVarControl_ and stores the control's ClassNN. To change this behavior, add up one or both of the following digits:

**1**: Uses a simpler method to determine _OutputVarControl_. This method correctly retrieves the active/topmost child window of an Multiple Document Interface (MDI) application such as SysEdit or TextPad. However, it is less accurate for other purposes such as detecting controls inside a GroupBox control.

**2**[v1.0.43.06+]: Stores the [control's HWND](ControlGet.htm#Hwnd) in _OutputVarControl_ rather than the control's ClassNN.

For example, to put both options into effect, the _Flag_ parameter must be set to 3.

## Remarks

Any of the output variables may be omitted if the corresponding information is not needed.

## Related

[CoordMode](CoordMode.htm), [WinGet](WinGet.htm), [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm), [Click](Click.htm)

## Examples

Reports the position of the mouse cursor.

```
MouseGetPos, xpos, ypos
MsgBox, The cursor is at X%xpos% Y%ypos%.
```

Allows you to move the mouse cursor around to see the title of the window currently under the cursor.

```
#Persistent
SetTimer, WatchCursor, 100
return

WatchCursor:
MouseGetPos, , , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
ToolTip, ahk_id %id%`nahk_class %class%`n%title%`nControl: %control%
return
```

