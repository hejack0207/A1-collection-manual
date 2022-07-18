# PixelGetColor

Retrieves the color of the pixel at the specified x,y coordinates.

```
<span class="func">PixelGetColor</span>, OutputVar, X, Y <span class="optional">, Mode</span>
```

## Parameters

OutputVar

The name of the variable in which to store the color ID in hexadecimal blue-green-red (BGR) format. For example, the color purple is defined 0x800080 because it has an intensity of 80 for its blue and red components but an intensity of 00 for its green component.

X, Y

The X and Y coordinates of the pixel, which can be [expressions](../Variables.htm#Expressions). Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that.

Mode

This parameter may contain zero or more of the following words. If more than one word is present, separate each from the next with a space (e.g. `Alt RGB`).

**Alt**[v1.0.43.10+]: Uses an alternate method to retrieve the color, which should be used when the normal method produces invalid or inaccurate colors for a particular type of window. This method is about 10% slower than the normal method.

**Slow**[v1.0.43.10+]: Uses a more elaborate method to retrieve the color, which may work in certain full-screen applications when the other methods fail. This method is about three times slower than the normal method. Note: _Slow_ takes precedence over _Alt_, so there is no need to specify _Alt_ in this case.

**RGB**: Retrieves the color in RGB vs. BGR format. In other words, the red and the blue components are swapped. This is useful for retrieving colors compatible with [WinSet](WinSet.htm), [Gui](Gui.htm), [Progress](Progress.htm), and [SplashImage](Progress.htm).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

The pixel must be visible; in other words, it is not possible to retrieve the pixel color of a window hidden behind another window. By contrast, pixels beneath the mouse cursor can usually be detected. The exception to this is game cursors, which in most cases will hide any pixels beneath them.

Use Window Spy (available in tray icon menu) or the example at the bottom of this page to determine the colors currently on the screen.

Known limitations:

- A window that is[partially transparent](WinSet.htm#trans) or that has one of its colors marked invisible ( [TransColor](WinSet.htm#TransColor)) typically yields colors for the window behind itself rather than its own.
- PixelGetColor might not produce accurate results for certain applications. If this occurs, try specifying the word_Alt_ or _Slow_ in the last parameter.

## Related

[PixelSearch](PixelSearch.htm), [ImageSearch](ImageSearch.htm), [CoordMode](CoordMode.htm), [MouseGetPos](MouseGetPos.htm)

## Examples

Press a hotkey to show the color of the pixel located at the current position of the mouse cursor.

```
^!z::  <em>; Control+Alt+Z hotkey.</em>
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
MsgBox The color at the current cursor position is %color%.
return
```

