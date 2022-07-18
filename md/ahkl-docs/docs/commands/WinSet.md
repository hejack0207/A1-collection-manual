# WinSet

Makes a variety of changes to the specified window, such as "always on top" and transparency.

```
<span class="func">WinSet</span>, <a href="#SubCommands" data-index="1">SubCommand</a>, Value <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

SubCommand, ValueThese are dependent upon each other and their usage is described [below](#SubCommands).WinTitleA window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).WinTextIf present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.ExcludeTitleWindows whose titles include this value will not be considered.ExcludeTextWindows whose text include this value will not be considered.

## Sub-commands

For _SubCommand_, specify one of the following:

- [AlwaysOnTop](#AlwaysOnTop): Makes a window stay on top of all other windows.
- [Bottom](#Bottom): Sends a window to the bottom of stack; that is, beneath all other windows.
- [Top](#Top): Brings a window to the top of the stack without explicitly activating it.
- [Disable](#Disable): Disables a window.
- [Enable](#Enable): Enables a window.
- [Redraw](#Redraw): Redraws a window.
- [Style](#Style): Changes the style of a window.
- [ExStyle](#ExStyle): Changes the extended style of a window.
- [Region](#Region): Changes the shape of a window to be the specified rectangle, ellipse, or polygon.
- [Transparent](#Transparent): Makes a window semi-transparent.
- [TransColor](#TransColor): Makes all pixels of the chosen color invisible inside the target window.

### AlwaysOnTop

Makes a window stay on top of all other windows.

```
<span class="func">WinSet</span>, AlwaysOnTop <span class="optional">, OnOffToggle, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

For _OnOffToggle_, specify `On` turn on the setting, `Off` to turn it off, or `Toggle` to set it to the opposite of its current state. If _OnOffToggle_ is blank or omitted, it defaults to `Toggle`. The word Topmost can be used in place of AlwaysOnTop.

[v1.1.30+]: The decimal values 1, 0 and -1 may be used in place of On, Off and Toggle, respectively.

### Bottom

Sends a window to the bottom of stack; that is, beneath all other windows.

```
<span class="func">WinSet</span>, Bottom <span class="optional">,, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

The effect is similar to pressing Alt+Esc.

### Top

Brings a window to the top of the stack without explicitly [activating](WinActivate.htm) it.

```
<span class="func">WinSet</span>, Top <span class="optional">,, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

However, the system default settings will probably cause it to activate in most cases. In addition, this sub-command may have no effect due to the operating system's protection against applications that try to steal focus from the user (it may depend on factors such as what type of window is currently active and what the user is currently doing). One possible work-around is to make the window briefly [AlwaysOnTop](#AlwaysOnTop), then turn off AlwaysOnTop.

### Disable

Disables a window.

```
<span class="func">WinSet</span>, Disable <span class="optional">,, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

When a window is disabled, the user cannot move it or interact with its controls. In addition, disabled windows are omitted from the alt-tab list.

### Enable

Enables a window.

```
<span class="func">WinSet</span>, Enable <span class="optional">,, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### Redraw

Redraws a window.

```
<span class="func">WinSet</span>, Redraw <span class="optional">,, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

This sub-command attempts to update the appearance/contents of a window by informing the OS that the window's rectangle needs to be redrawn. If this approach does not work for a particular window, try [WinMove](WinMove.htm). If that does not work, try [WinHide](WinHide.htm) in combination with [WinShow](WinShow.htm).

### Style

Changes the style of a window.

```
<span class="func">WinSet</span>, Style, N <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If the first character of _N_ is a plus or minus sign, the style(s) in _N_ are added or removed, respectively. If the first character is a caret (^), the style(s) in N are each toggled to the opposite state. If the first character is a digit, the window's style is overwritten completely; that is, it becomes _N_.

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 upon failure and 0 upon success. Failure occurs if the target window is not found or the style is not allowed to be applied.

After applying certain style changes to a visible window, it might be necessary to redraw the window using the [Redraw](#Redraw) sub-command above. Finally, the [styles table](../misc/Styles.htm) lists some of the common style numbers. For example:

```
WinSet, Style, -0xC00000, A  <em>; Remove the active window's title bar (WS_CAPTION).</em>
```

### ExStyle

Changes the extended style of a window.

```
<span class="func">WinSet</span>, ExStyle, N <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

See the [Style](#Style) sub-command for details. For example:

```
WinSet, ExStyle, ^0x80, <i>WinTitle</i> <em>; Toggle the WS_EX_TOOLWINDOW attribute, which removes/adds the window from the alt-tab list.</em>
```

### Region

Changes the shape of a window to be the specified rectangle, ellipse, or polygon.

```
<span class="func">WinSet</span>, Region <span class="optional">, Options, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If the _Options_ parameter is blank or omitted, the window is restored to its original/default display area. Otherwise, one or more of the following options can be specified, each separated from the others with space(s):

**Wn**: Width of rectangle or ellipse. For example: `w200`.

**Hn**: Height of rectangle or ellipse. For example: `h200`.

**X-Y**: Each of these is a pair of X/Y coordinates. For example, `200-0` would use 200 for the X coordinate and 0 for the Y.

**E**: Makes the region an ellipse rather than a rectangle. This option is valid only when **W** and **H** are present.

**R[w-h]**: Makes the region a rectangle with rounded corners. For example, `R30-30` would use a 30x30 ellipse for each corner. If **w-h** is omitted, 30-30 is used. **R** is valid only when **W** and **H** are present.

**Rectangle or ellipse**: If the **W** and **H** options are present, the new display area will be a rectangle whose upper left corner is specified by the first (and only) pair of **X-Y** coordinates. However, if the **E** option is also present, the new display area will be an ellipse rather than a rectangle. For example: `WinSet, Region, 50-0 W200 H250 E, WinTitle`.

**Polygon**: When the **W** and **H** options are absent, the new display area will be a polygon determined by multiple pairs of **X-Y** coordinates (each pair of coordinates is a point inside the window relative to its upper left corner). For example, if three pairs of coordinates are specified, the new display area will be a triangle in most cases. The order of the coordinate pairs with respect to each other is sometimes important. In addition, the word **Wind** maybe be present in _Options_ to use the winding method instead of the alternating method to determine the polygon's region.

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 upon failure and 0 upon success. Failure occurs when: 1) the target window does not exist; 2) one or more _Options_ are invalid; 3) more than 2000 pairs of coordinates were specified; or 4) the specified region is invalid or could not be applied to the target window.

See [example #7](#ExRegion) at the bottom of this page for how to use this sub-command.

When a region is set for a window owned by the script, the system may automatically change the method it uses to render the window's frame, thereby altering its appearance. The effect is similar to workaround #2 shown below, but only affects the window until its region is reset.

**Known limitation**: Setting a region for a window not owned by the script may produce unexpected results if the window has a caption (title bar), and the system has desktop composition enabled. This is because the visible frame is not actually part of the window, but rendered by a separate system process known as the "desktop window manager". Note that desktop composition is [always enabled](https://docs.microsoft.com/en-us/windows/compatibility/desktop-window-manager-is-always-on) on Windows 8 and later. One of the following two workarounds can be used:

```
<em>; #1: Remove the window's caption.</em>
WinSet Style, -0xC00000, Window Title

<em>; To undo it:</em>
WinSet Style, +0xC00000, Window Title
```

```
<em>; #2: Disable DWM rendering of the window's frame.</em>
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", WinExist("Window Title")
  , "uint", DWMWA_NCRENDERING_POLICY := 2, "int*", DWMNCRP_DISABLED := 1, "uint", 4)

<em>; To undo it (this might also cause any set region to be ignored):</em>
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", WinExist("Window Title")
  , "uint", DWMWA_NCRENDERING_POLICY := 2, "int*", DWMNCRP_ENABLED := 2, "uint", 4)

```

### Transparent

Makes a window semi-transparent.

```
<span class="func">WinSet</span>, Transparent <span class="optional">, N, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

Specify for _N_ a number between 0 and 255 to indicate the degree of transparency: 0 makes the window invisible while 255 makes it opaque.

The word `Off` may be specified to completely turn off transparency for a window. This is functionally identical to `WinSet, <a href="#TransColor" data-index="28">TransColor</a>, Off, <i>WinTitle</i>`. Specifying `Off` is different than specifying 255 because it may improve performance and reduce usage of system resources.

For example, to make the task bar transparent, use `WinSet, Transparent, 150, ahk_class Shell_TrayWnd`. Similarly, to make the classic Start Menu transparent, see [example #5](#ExTransStartMenu). To make the Start Menu's submenus transparent, also include the script from [example #6](#ExTransMenu).

Setting the transparency level to 255 before using `Off` might avoid window redrawing problems such as a black background. If the window still fails to be redrawn correctly, see [Redraw](#Redraw) for a possible workaround.

[v1.1.24.05+]: This sub-command also works with a window that lacks a caption (title bar) and lacks the [always-on-top](#AlwaysOnTop) property.

### TransColor

Makes all pixels of the chosen color invisible inside the target window.

```
<span class="func">WinSet</span>, TransColor, Color <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

This allows the contents of the window behind it to show through. If the user clicks on an invisible pixel, the click will "fall through" to the window behind it. Specify for _Color_ a color name or RGB value (see the [color chart](Progress.htm#colors) for guidance, or use [PixelGetColor](PixelGetColor.htm) in its RGB mode). To additionally make the visible part of the window partially transparent, append a space (not a comma) followed by the transparency level (0-255). For example: `WinSet, TransColor, EEAA99 150, <i>WinTitle</i>`.

The word `Off` may be specified to completely turn off transparency for a window. This is functionally identical to `WinSet, <a href="#Transparent" data-index="35">Transparent</a>, Off, <i>WinTitle</i>`. Specifying `Off` is different than specifying 255 because it may improve performance and reduce usage of system resources.

TransColor is often used to create on-screen displays and other visual effects. There is an example of an on-screen display [at the bottom of the Gui page](Gui.htm#OSD).

Setting the transparency level to 255 before using `Off` might avoid window redrawing problems such as a black background. If the window still fails to be redrawn correctly, see [Redraw](#Redraw) for a possible workaround.

To change a window's existing TransColor, it may be necessary to turn off transparency before making the change.

[v1.1.24.05+]: This sub-command also works with a window that lacks a caption (title bar) and lacks the [always-on-top](#AlwaysOnTop) property.

## Remarks

[ErrorLevel](../misc/ErrorLevel.htm) is not changed by this command except where indicated above.

Although transparency is supported on Windows 2000/XP or later, retrieving the current transparency settings of a window is possible only on Windows XP or later (via [WinGet](WinGet.htm)).

A script's [SplashText](SplashTextOn.htm) window can be made non-AlwaysOnTop via:

```
WinSet, AlwaysOnTop, Off, My Splash Window Title
```

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinGet](WinGet.htm), [WinHide](WinHide.htm), [WinSetTitle](WinSetTitle.htm), [WinMove](WinMove.htm), [WinActivate](WinActivate.htm), [Control](Control.htm)

## Examples

Makes Notepad a little bit transparent.

```
WinSet, Transparent, 200, Untitled - Notepad
```

Makes all white pixels in Notepad invisible.

```
WinSet, TransColor, White, Untitled - Notepad
```

Toggles the always-on-top status of the calculator.

```
WinSet, AlwaysOnTop, Toggle, Calculator
```

Demonstrates the effects of the sub-commands [Transparent](#Transparent) and [TransColor](#TransColor). Note: If you press one of the hotkeys while the mouse cursor is hovering over a pixel that is invisible as a result of TransColor, the window visible beneath that pixel will be acted upon instead! Also, Win+G will have an effect only on Windows XP or later because retrieval of transparency settings is not supported by Windows 2000.

```
#t::  <em>; Press Win+T to make the color under the mouse cursor invisible.</em>
MouseGetPos, MouseX, MouseY, MouseWin
PixelGetColor, MouseRGB, %MouseX%, %MouseY%, RGB
<em>; It seems necessary to turn off any existing transparency first:</em>
WinSet, TransColor, Off, ahk_id %MouseWin%
WinSet, TransColor, %MouseRGB% 220, ahk_id %MouseWin%
return

#o::  <em>; Press Win+O to turn off transparency for the window under the mouse.</em>
MouseGetPos,,, MouseWin
WinSet, TransColor, Off, ahk_id %MouseWin%
return

#g::  <em>; Press Win+G to show the current settings of the window under the mouse.</em>
MouseGetPos,,, MouseWin
WinGet, Transparent, Transparent, ahk_id %MouseWin%
WinGet, TransColor, TransColor, ahk_id %MouseWin%
ToolTip Translucency:`t%Transparent%`nTransColor:`t%TransColor%
return
```

Makes the classic Start Menu transparent (to additionally make the Start Menu's submenus transparent, see [example #6](#ExTransMenu)).

```
DetectHiddenWindows, On
WinSet, Transparent, 150, ahk_class BaseBar
```

Makes all or selected menus transparent throughout the system as soon as they appear. Note that although such a script cannot make its own menus transparent, it can make those of other scripts transparent.

```
#Persistent
SetTimer, WatchForMenu, 5
return  <em>; End of auto-execute section.</em>

WatchForMenu:
DetectHiddenWindows, On  <em>; Might allow detection of menu sooner.</em>
if WinExist("ahk_class #32768")
    WinSet, Transparent, 150  <em>; Uses the window found by the above line.</em>
return
```

Usage of the [Region](#Region) sub-command:

The following makes all parts of Notepad outside this rectangle invisible.

```
WinSet, Region, 50-0 W200 H250, ahk_class Notepad
```

The following does the same as above but with corners rounded to 40x40.

```
WinSet, Region, 50-0 W200 H250 R40-40, ahk_class Notepad
```

The following creates an ellipse instead of a rectangle.

```
WinSet, Region, 50-0 W200 H250 E, ahk_class Notepad
```

The following creates a triangle with apex pointing down.

```
WinSet, Region, 50-0 250-0 150-250, ahk_class Notepad
```

The following restores the window to its original/default display area.

```
WinSet, Region,, ahk_class Notepad
```

The following creates a see-through rectangular hole inside Notepad (or any other window). There are two rectangles specified below: an outer and an inner. Each rectangle consists of 5 pairs of X/Y coordinates because the first pair is repeated at the end to "close off" each rectangle.

```
WinSet, Region, 0-0 300-0 300-300 0-300 0-0   100-100 200-100 200-200 100-200 100-100, ahk_class Notepad
```

