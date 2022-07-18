# WinGetActiveStats

Combines the functions of [WinGetActiveTitle](WinGetActiveTitle.htm) and [WinGetPos](WinGetPos.htm) into one command.

```
<span class="func">WinGetActiveStats</span>, Title, Width, Height, X, Y
```

## Parameters

Title

The name of the variable in which to store the title of the active window.

Width, Height

The names of the variables in which to store the width and height of the active window.

X, Y

The names of the variables in which to store the X and Y coordinates of the active window's upper left corner.

## Remarks

If no matching window is found, the output variables will be made blank.

This command is equivalent to the following sequence:

```
<a href="WinGetTitle.htm" data-index="3">WinGetTitle</a>, Title, A
<a href="WinGetPos.htm" data-index="4">WinGetPos</a>, X, Y, Width, Height, A
```

If the active window is a hidden window and [DetectHiddenWindows](DetectHiddenWindows.htm) is off (the default), all commands except [WinShow](WinShow.htm) will fail to "see" it. If there is no active window for this reason or any other, this command will set all of its output variables to be blank.

## Related

[WinGetPos](WinGetPos.htm), [WinGetActiveTitle](WinGetActiveTitle.htm), [WinGetTitle](WinGetTitle.htm), [WinGetClass](WinGetClass.htm), [WinGetText](WinGetText.htm), [ControlGetText](ControlGetText.htm)

## Examples

Retrieves and reports the title, size and position of the active window.

```
WinGetActiveStats, Title, Width, Height, X, Y
MsgBox, The active window "%Title%" is %Width% wide`, %Height% tall`, and positioned at %X%`,%Y%.
```

