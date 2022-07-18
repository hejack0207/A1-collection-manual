# SysGet

Retrieves screen resolution, multi-monitor info, dimensions of system objects, and other system properties.

```
<span class="func">SysGet</span>, OutputVar, <a href="#SubCommands" data-index="1">SubCommand</a> <span class="optional">, Value</span>
```

The _OutputVar_ parameter is the name of the variable in which to store the result. The _SubCommand_ and _Value_ parameters are dependent upon each other and their usage is described below.

## Sub-commands

For _SubCommand_, specify one of the following:

- [MonitorCount](#MonitorCount): Retrieves the total number of monitors.
- [MonitorPrimary](#MonitorPrimary): Retrieves the number of the primary monitor.
- [Monitor](#Monitor): Retrieves the bounding coordinates of the specified monitor.
- [MonitorWorkArea](#MonitorWorkArea): Retrieves the working area's bounding coordinates of the specified monitor.
- [MonitorName](#MonitorName): Retrieves the name of the specified monitor.
- [(Numeric)](#Numeric): Retrieve the corresponding value from the tables below.

### MonitorCount

Retrieves the total number of monitors.

```
<span class="func">SysGet</span>, OutputVar, MonitorCount
```

Unlike SM\_CMONITORS mentioned in the table below, this sub-command includes all monitors, even those not being used as part of the desktop.

### MonitorPrimary

Retrieves the number of the primary monitor.

```
<span class="func">SysGet</span>, OutputVar, MonitorPrimary
```

In a single-monitor system, this will be always 1.

### Monitor

Retrieves the bounding coordinates of monitor number _N_.

```
<span class="func">SysGet</span>, OutputVar, Monitor <span class="optional">, N</span>
```

If _N_ is omitted, the primary monitor is used. The information is stored in four variables whose names all start with _OutputVar_. If _N_ is too high or there is a problem retrieving the info, the variables are all made blank. For example:

```
SysGet, Mon2, Monitor, 2
MsgBox, Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.
```

Within a [function](../Functions.htm), to create a set of variables that is global instead of local, [declare](../Functions.htm#Global) _Mon2_ as a global variable prior to using this command (the converse is true for [assume-global](../Functions.htm#AssumeGlobal) functions). However, it is often also necessary to declare each variable in the set, due to a [common source of confusion](../Functions.htm#ArrayConfusion).

### MonitorWorkArea

Retrieves the working area's bounding coordinates of monitor number _N_.

```
<span class="func">SysGet</span>, OutputVar, MonitorWorkArea <span class="optional">, N</span>
```

Same as the [Monitor sub-command](#Monitor) above except the area is reduced to exclude the area occupied by the taskbar and other registered desktop toolbars.

### MonitorName

Retrieves the operating system's name of monitor number _N_.

```
<span class="func">SysGet</span>, OutputVar, MonitorName <span class="optional">, N</span>
```

If _N_ is omitted, the primary monitor is used.

### (Numeric)

Specify for _SubCommand_ one of the numbers from the tables below to retrieve the corresponding value.

```
<span class="func">SysGet</span>, OutputVar, N
```

The following example would store the number of mouse buttons in a variable named "MouseButtonCount": `SysGet, MouseButtonCount, 43`.

#### Commonly Used

NumberDescription80SM\_CMONITORS: Number of display monitors on the desktop (not including "non-display pseudo-monitors").43SM\_CMOUSEBUTTONS: Number of buttons on mouse (0 if no mouse is installed).16, 17SM\_CXFULLSCREEN, SM\_CYFULLSCREEN: Width and height of the client area for a full-screen window on the primary display monitor, in pixels.61, 62SM\_CXMAXIMIZED, SM\_CYMAXIMIZED: Default dimensions, in pixels, of a maximized top-level window on the primary display monitor.59, 60SM\_CXMAXTRACK, SM\_CYMAXTRACK: Default maximum dimensions of a window that has a caption and sizing borders, in pixels. This metric refers to the entire desktop. The user cannot drag the window frame to a size larger than these dimensions.28, 29SM\_CXMIN, SM\_CYMIN: Minimum width and height of a window, in pixels.57, 58SM\_CXMINIMIZED, SM\_CYMINIMIZED: Dimensions of a minimized window, in pixels.34, 35SM\_CXMINTRACK, SM\_CYMINTRACK: Minimum tracking width and height of a window, in pixels. The user cannot drag the window frame to a size smaller than these dimensions. A window can override these values by processing the WM\_GETMINMAXINFO message.0, 1SM\_CXSCREEN, SM\_CYSCREEN: Width and height of the screen of the primary display monitor, in pixels. These are the same as the built-in variables [A\_ScreenWidth](../Variables.htm#Screen) and [A\_ScreenHeight](../Variables.htm#Screen).78, 79SM\_CXVIRTUALSCREEN, SM\_CYVIRTUALSCREEN: Width and height of the virtual screen, in pixels. The virtual screen is the bounding rectangle of all display monitors. The SM\_XVIRTUALSCREEN, SM\_YVIRTUALSCREEN metrics are the coordinates of the top-left corner of the virtual screen.19SM\_MOUSEPRESENT: Nonzero if a mouse is installed; zero otherwise.75SM\_MOUSEWHEELPRESENT: Nonzero if a mouse with a wheel is installed; zero otherwise.63SM\_NETWORK: Least significant bit is set if a network is present; otherwise, it is cleared. The other bits are reserved for future use.8193
 SM\_REMOTECONTROL: This system metric is used in a Terminal Services environment. Its value is nonzero if the current session is remotely controlled; zero otherwise.4096
 SM\_REMOTESESSION: This system metric is used in a Terminal Services environment. If the calling process is associated with a Terminal Services client session, the return value is nonzero. If the calling process is associated with the Terminal Server console session, the return value is zero. The console session is not necessarily the physical console.70
 SM\_SHOWSOUNDS: Nonzero if the user requires an application to present information visually in situations where it would otherwise present the information only in audible form; zero otherwise.
 8192
 SM\_SHUTTINGDOWN: Nonzero if the current session is shutting down; zero otherwise. **Windows 2000:** The retrieved value is always 0.23SM\_SWAPBUTTON: Nonzero if the meanings of the left and right mouse buttons are swapped; zero otherwise.76, 77
 SM\_XVIRTUALSCREEN, SM\_YVIRTUALSCREEN: Coordinates for the left side and the top of the virtual screen. The virtual screen is the bounding rectangle of all display monitors. By contrast, the SM\_CXVIRTUALSCREEN, SM\_CYVIRTUALSCREEN metrics (further above) are the width and height of the virtual screen.

#### Not Commonly Used

NumberDescription56SM\_ARRANGE: Flags specifying how the system arranged minimized windows. See MSDN for more information.67

SM\_CLEANBOOT: Specifies how the system was started:

- 0 = Normal boot
- 1 = Fail-safe boot
- 2 = Fail-safe with network boot

5, 6SM\_CXBORDER, SM\_CYBORDER: Width and height of a window border, in pixels. This is equivalent to the SM\_CXEDGE value for windows with the 3-D look.13, 14SM\_CXCURSOR, SM\_CYCURSOR: Width and height of a cursor, in pixels. The system cannot create cursors of other sizes.36, 37SM\_CXDOUBLECLK, SM\_CYDOUBLECLK: Width and height of the rectangle around the location of a first click in a double-click sequence, in pixels. The second click must occur within this rectangle for the system to consider the two clicks a double-click. (The two clicks must also occur within a specified time.)68, 69SM\_CXDRAG, SM\_CYDRAG: Width and height of a rectangle centered on a drag point to allow for limited movement of the mouse pointer before a drag operation begins. These values are in pixels. It allows the user to click and release the mouse button easily without unintentionally starting a drag operation.45, 46SM\_CXEDGE, SM\_CYEDGE: Dimensions of a 3-D border, in pixels. These are the 3-D counterparts of SM\_CXBORDER and SM\_CYBORDER.7, 8SM\_CXFIXEDFRAME, SM\_CYFIXEDFRAME (synonymous with SM\_CXDLGFRAME, SM\_CYDLGFRAME): Thickness of the frame around the perimeter of a window that has a caption but is not sizable, in pixels. SM\_CXFIXEDFRAME is the height of the horizontal border and SM\_CYFIXEDFRAME is the width of the vertical border.83, 84SM\_CXFOCUSBORDER, SM\_CYFOCUSBORDER: Width (in pixels) of the left and right edges and the height of the top and bottom edges of a control's focus rectangle. **Windows 2000:** The retrieved value is always 0.21, 3SM\_CXHSCROLL, SM\_CYHSCROLL: Width of the arrow bitmap on a horizontal scroll bar, in pixels; and height of a horizontal scroll bar, in pixels.10SM\_CXHTHUMB: Width of the thumb box in a horizontal scroll bar, in pixels.11, 12SM\_CXICON, SM\_CYICON: Default width and height of an icon, in pixels.38, 39SM\_CXICONSPACING, SM\_CYICONSPACING: Dimensions of a grid cell for items in large icon view, in pixels. Each item fits into a rectangle of this size when arranged. These values are always greater than or equal to SM\_CXICON and SM\_CYICON.71, 72SM\_CXMENUCHECK, SM\_CYMENUCHECK: Dimensions of the default menu check-mark bitmap, in pixels.54, 55SM\_CXMENUSIZE, SM\_CYMENUSIZE: Dimensions of menu bar buttons, such as the child window close button used in the multiple document interface, in pixels.47, 48SM\_CXMINSPACING SM\_CYMINSPACING: Dimensions of a grid cell for a minimized window, in pixels. Each minimized window fits into a rectangle this size when arranged. These values are always greater than or equal to SM\_CXMINIMIZED and SM\_CYMINIMIZED.30, 31SM\_CXSIZE, SM\_CYSIZE: Width and height of a button in a window's caption or title bar, in pixels.32, 33SM\_CXSIZEFRAME, SM\_CYSIZEFRAME: Thickness of the sizing border around the perimeter of a window that can be resized, in pixels. SM\_CXSIZEFRAME is the width of the horizontal border, and SM\_CYSIZEFRAME is the height of the vertical border. Synonymous with SM\_CXFRAME and SM\_CYFRAME.49, 50SM\_CXSMICON, SM\_CYSMICON: Recommended dimensions of a small icon, in pixels. Small icons typically appear in window captions and in small icon view.52, 53SM\_CXSMSIZE SM\_CYSMSIZE: Dimensions of small caption buttons, in pixels.2, 20SM\_CXVSCROLL, SM\_CYVSCROLL: Width of a vertical scroll bar, in pixels; and height of the arrow bitmap on a vertical scroll bar, in pixels.4SM\_CYCAPTION: Height of a caption area, in pixels.18SM\_CYKANJIWINDOW: For double byte character set versions of the system, this is the height of the Kanji window at the bottom of the screen, in pixels.15SM\_CYMENU: Height of a single-line menu bar, in pixels.51SM\_CYSMCAPTION: Height of a small caption, in pixels.9SM\_CYVTHUMB: Height of the thumb box in a vertical scroll bar, in pixels.42SM\_DBCSENABLED: Nonzero if User32.dll supports DBCS; zero otherwise.22SM\_DEBUG: Nonzero if the debug version of User.exe is installed; zero otherwise.82

SM\_IMMENABLED: Nonzero if Input Method Manager/Input Method Editor features are enabled; zero otherwise.

SM\_IMMENABLED indicates whether the system is ready to use a Unicode-based IME on a Unicode application. To ensure that a language-dependent IME works, check SM\_DBCSENABLED and the system ANSI code page. Otherwise the ANSI-to-Unicode conversion may not be performed correctly, or some components like fonts or registry setting may not be present.

87SM\_MEDIACENTER: Nonzero if the current operating system is the Windows XP, Media Center Edition, zero if not.40SM\_MENUDROPALIGNMENT: Nonzero if drop-down menus are right-aligned with the corresponding menu-bar item; zero if the menus are left-aligned.74SM\_MIDEASTENABLED: Nonzero if the system is enabled for Hebrew and Arabic languages, zero if not.41SM\_PENWINDOWS: Nonzero if the Microsoft Windows for Pen computing extensions are installed; zero otherwise.44SM\_SECURE: Nonzero if security is present; zero otherwise.81SM\_SAMEDISPLAYFORMAT: Nonzero if all the display monitors have the same color format, zero otherwise. Note that two displays can have the same bit depth, but different color formats. For example, the red, green, and blue pixels can be encoded with different numbers of bits, or those bits can be located in different places in a pixel's color value.86SM\_TABLETPC: Nonzero if the current operating system is the Windows XP Tablet PC edition, zero if not.

## Remarks

The built-in variables [A\_ScreenWidth](../Variables.htm#Screen) and [A\_ScreenHeight](../Variables.htm#Screen) contain the dimensions of the primary monitor, in pixels.

## Related

[DllCall()](DllCall.htm), [WinGet](WinGet.htm)

## Examples

Retrieves the number of mouse buttons and stores it in MouseButtonCount.

```
SysGet, MouseButtonCount, 43
```

Retrieves the width and height of the virtual screen and stores them in VirtualScreenWidth and VirtualScreenHeight.

```
SysGet, VirtualScreenWidth, 78
SysGet, VirtualScreenHeight, 79
```

Displays info about each monitor.

```
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
MsgBox, Monitor Count:`t%MonitorCount%`nPrimary Monitor:`t%MonitorPrimary%
Loop, %MonitorCount%
{
    SysGet, MonitorName, MonitorName, %A_Index%
    SysGet, Monitor, Monitor, %A_Index%
    SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%
    MsgBox, Monitor:`t#%A_Index%`nName:`t%MonitorName%`nLeft:`t%MonitorLeft% (%MonitorWorkAreaLeft% work)`nTop:`t%MonitorTop% (%MonitorWorkAreaTop% work)`nRight:`t%MonitorRight% (%MonitorWorkAreaRight% work)`nBottom:`t%MonitorBottom% (%MonitorWorkAreaBottom% work)
}
```

