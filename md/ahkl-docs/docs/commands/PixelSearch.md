# PixelSearch

Searches a region of the screen for a pixel of the specified color.

```
<span class="func">PixelSearch</span>, OutputVarX, OutputVarY, X1, Y1, X2, Y2, ColorID <span class="optional">, Variation, Mode</span>
```

## Parameters

OutputVarX, OutputVarY

The names of the variables in which to store the X and Y coordinates of the first pixel that matches _ColorID_ (if no match is found, the variables are made blank). Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that.

Either or both of these parameters may be left blank, in which case ErrorLevel (see below) can be used to determine whether a match was found.

X1, Y1

The X and Y coordinates of the starting corner of the rectangle to search, which can be [expressions](../Variables.htm#Expressions). Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that.

X2, Y2

The X and Y coordinates of the ending corner of the rectangle to search, which can be [expressions](../Variables.htm#Expressions). Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that.

ColorID

The decimal or hexadecimal color ID to search for, in Blue-Green-Red (BGR) format, which can be an [expression](../Variables.htm#Expressions). Color IDs can be determined using Window Spy (accessible from the tray menu) or via [PixelGetColor](PixelGetColor.htm). For example: `0x9d6346`.

Variation

A number between 0 and 255 (inclusive) to indicate the allowed number of shades of variation in either direction for the intensity of the red, green, and blue components of the color (can be an [expression](../Variables.htm#Expressions)). For example, if 2 is specified and ColorID is 0x444444, any color from 0x424242 to 0x464646 will be considered a match. This parameter is helpful if the color sought is not always exactly the same shade. If you specify 255 shades of variation, all colors will match. The default is 0 shades.

Mode

This parameter may contain the word Fast, RGB, or both (if both are present, separate them with a space; that is, _Fast RGB_).

**Fast**: Uses a faster searching method that in most cases dramatically reduces the amount of CPU time used by the search. Although color depths as low as 8-bit (256-color) are supported, the fast mode performs much better in 24-bit or 32-bit color. If the screen's color depth is 16-bit or lower, the _Variation_ parameter might behave slightly differently in fast mode than it does in slow mode. Finally, the fast mode searches the screen row by row instead of column by column. Therefore, it might find a different pixel than that of the slow mode if there is more than one matching pixel.

**Note:** The default _Slow_ mode is unusable on most modern systems due to an incompatibility with desktop composition, which causes it to be orders of magnitude slower.

**RGB**: Causes _ColorID_ to be interpreted as an RGB value instead of BGR. In other words, the red and blue components are swapped.

## Error Handling

[v1.1.04+]: This command is able to throw an exception if there was a problem while searching. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 0 if the color was found in the specified region, 1 if it was not found, or 2 if there was a problem that prevented the command from conducting the search.

## Remarks

The region to be searched must be visible; in other words, it is not possible to search a region of a window hidden behind another window. By contrast, pixels beneath the mouse cursor can usually be detected. The exception to this is cursors in games, which in most cases will hide any pixels beneath them.

The search order depends on the order of the parameters. In other words, if _X1_ is greater than _X2_, the search will be conducted from right to left, starting at column _X1_. Similarly, if _Y1_ is greater than _Y2_, the search will be conducted from bottom to top. However, prior to [v1.1.32], the fast mode required _X1_ and _Y1_ to be the top-left corner.

Fast mode: The search starts at the coordinates specified by _X1_ and _Y1_ and checks all pixels in the row from _X1_ to _X2_ for a match. If no match is found there, the search continues toward _Y2_, row by row, until it finds a matching pixel.

Slow mode: The search starts at the coordinates specified by _X1_ and _Y1_ and checks all pixels in the column from _Y1_ to _Y2_ for a match. If no match is found there, the search continues toward _X2_, column by column, until it finds a matching pixel.

If the region to be searched is large and the search is repeated with high frequency, it may consume a lot of CPU time. To alleviate this, keep the size of the area to a minimum.

## Related

[PixelGetColor](PixelGetColor.htm), [ImageSearch](ImageSearch.htm), [CoordMode](CoordMode.htm), [MouseGetPos](MouseGetPos.htm)

## Examples

Searches a region of the active window for a pixel and stores in Px and Py the X and Y coordinates of the first pixel that matches the specified color with 3 shades of variation.

```
PixelSearch, Px, Py, 200, 200, 300, 300, 0x9d6346, 3, Fast
if ErrorLevel
    MsgBox, That color was not found in the specified region.
else
    MsgBox, A color within 3 shades of variation was found at X%Px% Y%Py%.
```

