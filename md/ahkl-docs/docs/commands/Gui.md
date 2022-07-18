# GUI

Creates and manages windows and controls. Such windows can be used as data entry forms or custom user interfaces.

```
<span class="func">Gui</span>, <a href="#SubCommands" data-index="1">SubCommand</a> <span class="optional">, Value1, Value2, Value3</span>
```

The _SubCommand_, _Value1_, _Value2_ and _Value3_ parameters are dependent upon each other and their usage is described below.

## Table of Contents

- [Sub-commands](#SubCommands)
- [Options for a Control (Gui Add)](#ControlOptions)
  - [Positioning and Sizing of Controls](#PosSize)
  - [Storing and Responding to User Input](#Events)
  - [Controls: Common Styles and Other Options](#OtherOptions)
- [Window Events](#Labels): [GuiClose](#GuiClose) \| [GuiEscape](#GuiEscape) \| [GuiSize](#GuiSize) \| [GuiContextMenu](#GuiContextMenu) \| [GuiDropFiles](#GuiDropFiles)
- [Creating Multiple GUI windows](#MultiWin)
- [GUI Events, Threads, and Subroutines](#DefaultWin)
- [Keyboard Navigation](#Navigate)
- [Window Appearance](#Appear)
- [General Remarks](#GenRemarks)
- [Examples](#Examples)

## Sub-commands

For _SubCommand_, specify one of the following:

- [New](#New)[v1.1.04+]: Creates a new window.
- [Add](#Add): Creates a control such as text, button, or checkbox.
- [Show](#Show): Displays the window. It can also minimize, maximize, or move the window.
- [Submit](#Submit): Saves the user's input and optionally hides the window.
- [Cancel](#Cancel) / [Hide](#Hide): Hides the window.
- [Destroy](#Destroy): Deletes the window.
- [Font](#Font): Sets the typeface, size, style, and text color for subsequently created controls.
- [Color](#Color): Sets the background color for the window and/or its controls.
- [Margin](#Margin): Sets the margin/spacing used whenever no explicit position has been specified for a control.
- [Options and styles for a window](#Options): Sets various options for the appearance and behavior of the window.
- [Menu](#Menu): Adds or removes a menu bar.
- [Minimize](#Minimize) / [Maximize](#Maximize) / [Restore](#Restore): Performs the indicated operation on the window.
- [Flash](#Flash): Blinks the window and its taskbar button.
- [Default](#Default): Changes the current thread's default GUI window name.

### New [v1.1.04+]

Creates a new window and sets it as the [default](#Default) for the current thread.

```
<span class="func">Gui</span>, New <span class="optional">, Options, Title</span>
<span class="func">Gui</span>, GuiName:New <span class="optional">, Options, Title</span>
```

If _GuiName_ is specified, a new GUI will be created, destroying any existing GUI with that name. Otherwise, a new unnamed and unnumbered GUI will be created.

_Options_ can contain any of the [options](#Options) supported by the main GUI command.

If _Title_ is omitted, the script's file name is used.

This sub-command comes with the following caveats:

- In most cases the window is created automatically on demand, so it is usually unnecessary to call`Gui New`.
- Although the new window is set as the[default](#Default) for the _current_ thread, non-GUI threads still [default to GUI number 1](#DefaultWin).
- If the GUI has no name and is not the[default GUI](#Default), it must be identified by its HWND. Use the [+Hwnd _GuiHwnd_](#GuiHwndOutputVar) option to store the HWND of the new window in _GuiHwnd_. `Gui, %<i>GuiHwnd</i>%:Default` can be used to make the other Gui commands operate on it by default.

On the positive side:

- Calling`Gui New` ensures that the script is creating a new GUI, not modifying an existing one. It might also make the script's purpose clearer to other people who read your code (or future you).
- `Gui New` eliminates the need to pick a unique name or number for each GUI. This can be especially useful if the script needs to create more than one GUI, or is intended to be included in other scripts.
- Sometimes it is more intuitive to set the window's title when the GUI is created instead of when it is[shown](#Show).

If no name is given, the following applies:

- Special[labels](#Labels) such as [GuiClose](#GuiClose) have the default "Gui" prefix unless overridden by [+Label _Prefix_](#PlusLabel) in the options.
- Whenever the GUI launches a new thread,[A\_Gui](../Variables.htm#Gui) contains a HWND instead of a name.

**Note:** Prior to [v1.1.08], this sub-command did not set the default Gui if a name was specified.

### Add

Adds a control to a GUI window (first creating the GUI window itself, if necessary).

```
<span class="func">Gui</span>, Add, ControlType <span class="optional">, Options, Text</span>
```

_ControlType_ is one of the following:

- [Text](GuiControls.htm#Text), [Edit](GuiControls.htm#Edit), [UpDown](GuiControls.htm#UpDown), [Picture](GuiControls.htm#Picture)
- [Button](GuiControls.htm#Button), [Checkbox](GuiControls.htm#Checkbox), [Radio](GuiControls.htm#Radio)
- [DropDownList](GuiControls.htm#DropDownList), [ComboBox](GuiControls.htm#ComboBox)
- [ListBox](GuiControls.htm#ListBox), [ListView](ListView.htm), [TreeView](TreeView.htm)
- [Link](GuiControls.htm#Link), [Hotkey](GuiControls.htm#Hotkey), [DateTime](GuiControls.htm#DateTime), [MonthCal](GuiControls.htm#MonthCal)
- [Slider](GuiControls.htm#Slider), [Progress](GuiControls.htm#Progress)
- [GroupBox](GuiControls.htm#GroupBox), [Tab](GuiControls.htm#Tab), [StatusBar](GuiControls.htm#StatusBar)
- [ActiveX](GuiControls.htm#ActiveX) (e.g. Internet Explorer Control)
- [Custom](GuiControls.htm#Custom)

_Options_ is a string of zero or more options, as described in the following sections:

- [Positioning and Sizing of Controls](#PosSize)
- [Storing and Responding to User Input](#Events)
- [Controls: Common Styles and Other Options](#OtherOptions)

For example:

```
Gui, Add, Text,, Please enter your name:
Gui, Add, Edit, vName
Gui, Show
```

### Show

Unless otherwise specified in _Options_, this sub-command makes the window visible, unminimizes it (if necessary), [activates](WinActivate.htm) it, and sets its title.

```
<span class="func">Gui</span>, Show <span class="optional">, Options, Title</span>
```

If _Title_ is omitted, the previous title is retained (or if none, the script's file name is used).

Omit the X, Y, W, and H options below to have the window retain its previous size and position. If there is no previous position, the window will be auto-centered in one or both dimensions if the X and/or Y options mentioned below are absent. If there is no previous size, the window will be auto-sized according to the size and positions of the controls it contains.

Zero or more of the following strings may be present in _Options_ (specify each number as decimal, not hexadecimal):

**Wn**: Specify for **n** the width (in pixels) of the window's client area (the client area excludes the window's borders, title bar, and [menu bar](#Menu)).

**Hn**: Specify for **n** the height of the window's client area, in pixels.

**Xn**: Specify for **n** the window's X-position on the screen, in pixels. Position 0 is the leftmost column of pixels visible on the screen.

**Yn**: Specify for **n** the window's Y-position on the screen, in pixels. Position 0 is the topmost row of pixels visible on the screen.

**Center**: Centers the window horizontally and vertically on the screen.

**xCenter**: Centers the window horizontally on the screen. For example: `Gui, Show, xCenter y0`.

**yCenter**: Centers the window vertically on the screen.

**AutoSize**: Resizes the window to accommodate only its currently visible controls. This is useful to resize the window after new controls are added, or existing controls are resized, hidden, or unhidden. For example: `Gui, Show, AutoSize Center`.

**Minimize**: Minimizes the window and activates the one beneath it.

**Maximize**: Maximizes and activates the window.

**Restore**: Unminimizes or unmaximizes the window, if necessary. The window is also shown and activated, if necessary.

**NoActivate**: Unminimizes or unmaximizes the window, if necessary. The window is also shown without activating it.

**NA**: Shows the window without activating it. If the window is minimized, it will stay that way but will probably rise higher in the z-order (which is the order seen in the alt-tab selector). If the window was previously hidden, this will probably cause it to appear on top of the active window even though the active window is not deactivated.

**Hide**: Hides the window and activates the one beneath it. This is identical in function to [Gui Cancel](#Cancel) except that it allows a hidden window to be moved, resized, or given a new title without showing it. For example: `Gui, Show, Hide x55 y66 w300 h200, New Title`.

### Submit

Saves the contents of each control to its [associated variable](#var) (if any) and hides the window unless the NoHide option is present.

```
<span class="func">Gui</span>, Submit <span class="optional">, NoHide</span>
```

For controls that produce multiple fields of output, such as a [multi-select ListBox](GuiControls.htm#ListBoxMulti), the output uses the window's [current delimiter](#Delimiter). If the window does not exist -- perhaps due to having been destroyed via [Gui Destroy](#Destroy) \-\- this sub-command has no effect.

### Cancel / Hide

Hides the window without saving the controls' contents to their [associated variables](#var).

```
<span class="func">Gui</span>, Cancel
<span class="func">Gui</span>, Hide
```

If the window does not exist -- perhaps due to having been destroyed via [Gui Destroy](#Destroy) \-\- this sub-command has no effect.

### Destroy

Removes the window (if it exists) and all its controls, freeing the corresponding memory and system resources.

```
<span class="func">Gui</span>, Destroy
```

If the script later recreates the window, all of the window's properties such as color and font will start off at their defaults (as though the window never existed). If this sub-command is not used, all GUI windows are automatically destroyed when the script exits.

### Font

Sets the font typeface, size, style, and/or color for controls added to the window from this point onward.

```
<span class="func">Gui</span>, Font <span class="optional">, Options, FontName</span>
```

For example:

```
Gui, Font, s10, Verdana  <em>; Set 10-point Verdana.</em>
```

Omit the last two parameters to restore the font to the system's default GUI typeface, size, and color.

_FontName_ may be the name of any font, such as one from the [font table](../misc/FontsStandard.htm). If _FontName_ is omitted or does not exist on the system, the previous font's typeface will be used (or if none, the system's default GUI typeface). This behavior is useful to make a GUI window have a similar font on multiple systems, even if some of those systems lack the preferred font. For example, by using the following commands in order, Verdana will be given preference over Arial, which in turn is given preference over MS Sans Serif:

```
Gui, Font,, MS Sans Serif
Gui, Font,, Arial
Gui, Font,, Verdana  <em>; Preferred font.</em>
```

If the _Options_ parameter is blank, the previous font's attributes will be used. Otherwise, specify one or more of the following option letters as substitutes:

**C**: Color name (see [color chart](Progress.htm#colors)) or RGB value -- or specify the word Default to return to the system's default color (black on most systems). Example values: `cRed`, `cFFFFAA`, `cDefault`. Note: [Buttons](GuiControls.htm#Button) do not obey custom colors. Also, an individual control can be created with a font color other than the current one by including the C option. For example: `Gui, Add, Text, cRed, My Text`.

**S**: Size (in points). For example: `s12` (specify decimal, not hexadecimal)

**W**: Weight (boldness), which is a number between 1 and 1000 (400 is normal and 700 is bold). For example: `w600` (specify decimal, not hexadecimal)

The following words are also supported: **bold**, _italic_, strike, underline, and norm. _Norm_ returns the font to normal weight/boldness and turns off italic, strike, and underline (but it retains the existing color and size). It is possible to use norm to turn off all attributes and then selectively turn on others. For example, specifying `norm italic` would set the font to normal then to italic.

To specify more than one option, include a space between each. For example: `cBlue s12 bold`.

If a script creates [multiple GUI windows](#MultiWin), each window remembers its own "current font" for the purpose of creating more controls.

On a related note, the operating system offers standard dialog boxes that prompt the user to pick a font, color, or icon. These dialogs can be displayed via [DllCall()](DllCall.htm) as demonstrated at [GitHub](https://github.com/majkinetor/mm-autohotkey/tree/master/Dlg).

**Q**: [AHK\_L 19+]: Text rendering quality. For example: `q3`. Q should be followed by a number from the following table:

NumberWindows ConstantDescription0DEFAULT\_QUALITYAppearance of the font does not matter.1DRAFT\_QUALITYAppearance of the font is less important than when the PROOF\_QUALITY value is used.2PROOF\_QUALITYCharacter quality of the font is more important than exact matching of the logical-font attributes.3NONANTIALIASED\_QUALITYFont is never antialiased, that is, font smoothing is not done.4ANTIALIASED\_QUALITYFont is antialiased, or smoothed, if the font supports it and the size of the font is not too small or too large.5CLEARTYPE\_QUALITYWindows XP and later: If set, text is rendered (when possible) using ClearType antialiasing method.

For more details of what these values mean, see [MSDN: CreateFont](http://msdn.microsoft.com/en-us/library/dd183499.aspx).

Since the highest quality setting is usually the default, this feature is more typically used to disable anti-aliasing in specific cases where doing so makes the text clearer.

### Color

Sets the background color of the window and/or its controls.

```
<span class="func">Gui</span>, Color <span class="optional">, WindowColor, ControlColor</span>
```

_WindowColor_ is used as the background for the GUI window itself. _ControlColor_ is applied to all present and future controls in the window (though some types of controls do not support a custom color). Although _ControlColor_ is initially obeyed by [ListViews](ListView.htm) and [TreeViews](TreeView.htm), subsequent changes to _ControlColor_ do not affect them. In such cases, use `GuiControl +BackgroundFF9977, MyListView` to explicitly change the color.

Leave either parameter blank to retain the current color. Otherwise, specify one of the 16 primary [HTML color names](Progress.htm#colors) or a 6-digit RGB color value (the 0x prefix is optional), or specify the word Default to return either to its default color. Example values: `Silver`, `FFFFAA`, `0xFFFFAA`, `Default`.

By default, the window's background color is the system's color for the face of buttons, and the controls' background color is the system's default window color (usually white).

The color of the [menu bar](#Menu) and its submenus can be changed as in this example: `<a href="Menu.htm" data-index="93">Menu</a>, MyMenuBar, Color, White`.

To make the background transparent, use [WinSet TransColor](WinSet.htm#TransColor). However, if you do this without first having assigned a custom window color via [Gui Color](#Color), buttons will also become transparent. To prevent this, first assign a custom color and then make that color transparent. For example:

```
Gui, Color, EEAA99
Gui +LastFound  <em>; Make the GUI window the <a href="../misc/WinTitle.htm#LastFoundWindow" data-index="96">last found window</a> for use by the line below.</em>
WinSet, TransColor, EEAA99
```

To additionally remove the border and title bar from a window with a transparent background, use the following **after** the window has been made transparent:

```
Gui -Caption  <em>; Or use <i>Gui, GuiName:-Caption</i> if it isn't the <a href="#DefaultWin" data-index="97">default window</a>.</em>
```

To illustrate the above, there is an example of an on-screen display (OSD) near the bottom of this page.

### Margin

Sets the number of pixels of space to leave at the left/right and top/bottom sides of the window when auto-positioning any control that lacks an explicit [X or Y coordinate](#XY).

```
<span class="func">Gui</span>, Margin <span class="optional">, X, Y</span>
```

Also, the margins are used to determine the vertical and horizontal distance that separates auto-positioned controls from each other. Finally, the margins are taken into account by the first use of [Gui Show](#Show) to calculate the window's size (when no explicit size is specified).

`Gui, Margin` affects only the [default window](#Default), while `Gui, Name:Margin` affects only the [named window](#MultiWin). If this command is not used, when the first control is added to a window, the window acquires a default margin on all sides proportional to the size of the currently selected [font](#Font) (0.75 times font-height for top & bottom, and 1.25 times font-height for left & right).

Although the margin may be changed during the course of adding controls, the change will affect only controls added in the future, not ones that already exist. Finally, either X or Y may be blank to leave the corresponding margin unchanged.

### Options and styles for a window

One or more options may be specified immediately after the GUI command.

```
<span class="func">Gui</span>, +/-Option1 +/-Option2 ...
```

For performance reasons, it is better to set all options in a single line, and to do so before creating the window (that is, before any use of other sub-commands such as [Gui Add](#Add)).

The effect of this command is cumulative; that is, it alters only those settings that are explicitly specified, leaving all the others unchanged.

Specify a plus sign to add the option and a minus sign to remove it. For example:

```
Gui +Resize -MaximizeBox  <em>; Change the settings of the <a href="#DefaultWin" data-index="104">default</a> GUI window.</em>
Gui <strong>MyGui:</strong>+Resize -MaximizeBox  <em>; Change the settings of the GUI named <i>MyGui</i>.</em>
```

**AlwaysOnTop**: Makes the window stay on top of all other windows, which is the same effect as [WinSet AlwaysOnTop](WinSet.htm#AlwaysOnTop).

**Border**: Provides a thin-line border around the window. This is not common.

**Caption** (present by default): Provides a title bar and a thick window border/edge. When removing the caption from a window that will use [WinSet TransColor](WinSet.htm#TransColor), remove it only after setting the TransColor.

**Delimiter**: Specifies that the window should use a field separator other than pipe (\|) whenever controls' contents are added via [Gui Add](#Add), modified via [GuiControl](GuiControl.htm), or retrieved via [Gui Submit](#Submit) or [GuiControlGet](GuiControlGet.htm). Specify a single character immediately after the word Delimiter. For example, ``Gui +Delimiter`n`` would use a linefeed character, which might be especially appropriate with [continuation sections](../Scripts.htm#continuation). Similarly, `Gui +Delimiter|` would revert to the default delimiter. To use space or tab, specify `Gui +DelimiterSpace` or `Gui +DelimiterTab`. Once the delimiter is changed, it affects all existing and subsequent [threads](../misc/Threads.htm) that operate on this particular window.

**Disabled**: Disables the window, which prevents the user from interacting with its controls. This is often used on a window that owns other windows (see [Owner](#Owner)).

**DPIScale**[v1.1.11+]: Use `Gui -DPIScale` to disable DPI scaling, which is enabled by default. If DPI scaling is enabled, coordinates and sizes passed to or retrieved from the Gui sub-commands and related variables are automatically scaled based on [screen DPI](../Variables.htm#ScreenDPI). For example, with a DPI of 144 (150%), `Gui Show, w100` would make the Gui 150 (100 \* 1.5) pixels wide, and resizing the window to 200 pixels wide via the mouse or [WinMove](WinMove.htm) would cause [A\_GuiWidth](../Variables.htm#GuiWidth) to return 133 (200 // 1.5). [A\_ScreenDPI](../Variables.htm#ScreenDPI) contains the system's current DPI.

DPI scaling only applies to Gui sub-commands and related variables, so coordinates coming directly from other sources such as ControlGetPos or WinGetPos will not work. There are a number of ways to deal with this:

- Avoid using hard-coded coordinates wherever possible. For example, use the[xp](#xp), [xs](#xs), [xm](#xm) and [x+m](#PosPlusMargin) options for positioning controls and specify height in [rows of text](#R) instead of pixels.
- Enable ( `Gui +DPIScale`) and disable ( `Gui -DPIScale`) scaling on the fly, as needed. Changing the setting does not affect positions or sizes which have already been set.
- Manually scale the coordinates. For example,`x*(A_ScreenDPI/96)` converts x from logical/Gui coordinates to physical/non-Gui coordinates.

**Hwnd** _OutputVar_[v1.1.04+]: This option stores the window handle (HWND) of the GUI in _OutputVar_. For example: `Gui +HwndMyGuiHwnd`. When within a function, _MyGuiHwnd_ is treated as a [function dynamic variable](../Functions.htm#DynVar). A GUI's HWND is often used with [PostMessage](PostMessage.htm), [SendMessage](PostMessage.htm), and [DllCall()](DllCall.htm). It can also be used directly as an [ahk\_id WinTitle](../misc/WinTitle.htm#ahk_id) or in place of a GUI name; for example, `Gui %MyGuiHwnd%:Destroy`.

**Label**[v1.0.44.09+]: Sets custom names for this window's [special labels](#Labels). For example, `Gui MyGui:+LabelMyGui_On` would use the labels MyGui\_OnClose and MyGui\_OnSize (if they exist) instead of MyGuiGuiClose and MyGuiGuiSize. In other words, the string "MyGuiGui" is replaced by "MyGui\_On" in the names of all [special labels](#Labels). This can also be used to make multiple windows share the same set of labels (in which case the script may consult [A\_Gui](../Variables.htm#Gui) to determine which window launched the subroutine).

**LastFound**: Sets the window to be the [last found window](../misc/WinTitle.htm#LastFoundWindow) (though this is unnecessary in a [Gui thread](#DefaultWin) because it is done automatically), which allows commands such as [WinSet](WinSet.htm) to operate on it even if it is hidden (that is, [DetectHiddenWindows](DetectHiddenWindows.htm) is not necessary). This is especially useful for changing the properties of the window before showing it. For example:

```
Gui +LastFound
WinSet, TransColor, %CustomColor% 150
Gui Show
```

**LastFoundExist**[v1.0.43.09+]: Unlike other options, LastFoundExist is recognized only when no other options appear on the same line. _+LastFoundExist_ is the same as _+LastFound_ except that the window is not created if it does not already exist. The main use for this is to detect whether a particular GUI window exists. For example:

```
Gui MyGui:+LastFoundExist
if WinExist()
    MsgBox GUI "MyGui" already exists.
```

**MaximizeBox**: Enables the maximize button in the title bar. This is also included as part of _Resize_ below.

**MinimizeBox** (present by default): Enables the minimize button in the title bar.

**MinSize** and **MaxSize**[v1.0.44.13+]: Determines the minimum and/or maximum size of the window, such as when the user drags its edges to resize it. Specify the word _MinSize_ and/or _MaxSize_ with no suffix to use the window's current size as the limit (if the window has no current size, it will use the size from the first use of [Gui Show](#Show)). Alternatively, append the width, followed by an X, followed by the height; for example: `Gui +Resize +MinSize640x480`. The dimensions are in pixels, and they specify the size of the window's client area (which excludes borders, title bar, and [menu bar](#Menu)). Specify each number as decimal, not hexadecimal.

Either the width or the height may be omitted to leave it unchanged (e.g. `+MinSize640x` or `+MinSizex480`). Furthermore, Min/MaxSize can be specified more than once to use the window's current size for one dimension and an explicit size for the other. For example, `+MinSize +MinSize640x` would use the window's current size for the height and 640 for the width.

If _MinSize_ and _MaxSize_ are never used, the operating system's defaults are used (similarly, `Gui -MinSize -MaxSize` can be used to return to the defaults).

**Note**: the window must have [+Resize](#Resize) to allow resizing by the user.

**OwnDialogs**: `Gui +OwnDialogs` should be specified in each [thread](../misc/Threads.htm) (such as a ButtonOK subroutine) for which subsequently displayed [MsgBox](MsgBox.htm), [InputBox](InputBox.htm), [FileSelectFile](FileSelectFile.htm), and [FileSelectFolder](FileSelectFolder.htm) dialogs should be owned by the window. Such dialogs become modal, meaning that the user cannot interact with the GUI window until dismissing the dialog. By contrast, [ToolTip](ToolTip.htm), [Progress](Progress.htm), and [SplashImage](Progress.htm) windows do not become modal even though they become owned; they will merely stay always on top of their owner. In either case, any owned dialog or window is automatically destroyed when its GUI window is [destroyed](#Destroy).

There is typically no need to turn this setting back off because it does not affect other [threads](../misc/Threads.htm). However, if a thread needs to display both owned and unowned dialogs, it may turn off this setting via `Gui -OwnDialogs`.

If no window name prefix is specified -- such as using `Gui +OwnDialogs` rather than `Gui MyGui:+OwnDialogs` \-\- the [thread's default window](#DefaultWin) will own the dialogs.

**Owner**: Use _+Owner_ to make the window owned by another. An owned window has no taskbar button by default, and when visible it is always on top of its owner. It is also automatically destroyed when its owner is destroyed. _+Owner_ must be used after the window's owner is created, but [v1.1.05] and later allow it to be used before or after the owned window is created. There are two ways to use _+Owner_ as shown in these examples:

```
Gui, MyGui:+OwnerMyOtherGui  <em>; Make <i>MyGui</i> owned by <i>MyOtherGui</i>.</em>
Gui, MyGui:+Owner  <em>; Make <i>MyGui</i> owned by <a href="Menu.htm#MainWindow" data-index="149">script's main window</a> to prevent display of a taskbar button.</em>
```

[v1.1.03+]: `+Owner` can be immediately followed by the [name](#Name) or number of an existing Gui or the [HWND](WinGet.htm#ID) of any top-level window.

**Compatibility note**: In [v1.1.03] and later, `+Owner` removes the WS\_CHILD style and sets the WS\_POPUP style. To set the parent window of a Gui, scripts must either use the `+Parent` option, or override the appropriate styles _after_ the `+Owner` option.

To prevent the user from interacting with the owner while one of its owned window is visible, disable the owner via `Gui +Disabled`. Later (when the time comes to cancel or destroy the owned window), re-enable the owner via `Gui -Disabled`. Do this prior to cancel/destroy so that the owner will be reactivated automatically.

**Parent**[v1.1.03+]: Use `+Parent` immediately followed by the [name](#Name) or number of an existing Gui or the [HWND](WinGet.htm#ID) of any window or control to use it as the parent of this window. To convert the Gui back into a top-level window, use `-Parent`. This option works even after the window is created.

**Resize**: Makes the window resizable and enables its maximize button in the title bar. To avoid enabling the maximize button, specify `+Resize -MaximizeBox`.

**SysMenu** (present by default): Specify `-SysMenu` (minus SysMenu) to omit the system menu and icon in the window's upper left corner. This will also omit the minimize, maximize, and close buttons in the title bar.

**Theme**: By specifying `-Theme`, all subsequently created controls in the window will have Classic Theme appearance on Windows XP and beyond. To later create additional controls that obey the current theme, turn it back on via `+Theme`.

**Note**: The Theme option has no effect on operating systems older than Windows XP, nor does it have any effect on XP itself if the Classic Theme is in effect.

Finally, this setting may be changed for an individual control by specifying `+Theme` or `-Theme` in its options when it is created.

**ToolWindow**: Provides a narrower title bar but the window will have no taskbar button. This always hides the maximize and minimize buttons, regardless of whether the [WS\_MAXIMIZEBOX](../misc/Styles.htm#WS_MAXIMIZEBOX) and [WS\_MINIMIZEBOX](../misc/Styles.htm#WS_MINIMIZEBOX) styles are present.

**(Unnamed Style)**: Specify a plus or minus sign followed immediately by a decimal or hexadecimal [style number](../misc/Styles.htm).

**(Unnamed ExStyle)**: Specify a plus or minus sign followed immediately by the letter E and a decimal or hexadecimal extended style number. For example, `+E0x40000` would add the WS\_EX\_APPWINDOW style, which provides a taskbar button for a window that would otherwise lack one. For other extended styles not documented here (since they are rarely used), see [Extended Window Styles \| Microsoft Docs](https://docs.microsoft.com/en-us/windows/win32/winmsg/extended-window-styles) for a complete list.

### Menu

Attaches a menu bar to the window.

```
<span class="func">Gui</span>, Menu <span class="optional">, MenuName</span>
```

Use the [Menu](Menu.htm) command to create an ordinary menu for this purpose. For example:

```
Menu, FileMenu, Add, &Open<a href="../misc/EscapeChar.htm" data-index="159">`t</a>Ctrl+O, MenuFileOpen  <em>; See remarks below about Ctrl+O.</em>
Menu, FileMenu, Add, E&xit, MenuHandler
Menu, HelpMenu, Add, &About, MenuHandler
Menu, MyMenuBar, Add, &File, :FileMenu  <em>; Attach the two sub-menus that were created above.</em>
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar
```

In the first line above, notice that `&Open` is followed by `Ctrl+O` (with a tab character in between). This indicates a keyboard shortcut that the user may press instead of selecting the menu item. [v1.1.04+]: If the shortcut uses only the standard modifier key names Ctrl, Alt and Shift, it is automatically registered as a _keyboard accelerator_ for the GUI. Single-character accelerators with no modifiers are case-sensitive and can be triggered by unusual means such as IME or Alt+NNNN.

If a particular key combination does not work automatically, the use of a [context-sensitive hotkey](_IfWinActive.htm) may be required. However, such hotkeys typically cannot be triggered by [Send](Send.htm) and are more likely to interfere with other scripts than a standard keyboard accelerator.

To remove a window's current menu bar, use `Gui Menu` (that is, omit the last parameter).

Once a menu has been used as a menu bar, it should not be used as a popup menu or a submenu. This is because menu bars internally require a different format (however, this restriction applies only to the menu bar itself, not its submenus). If you need to work around this, create one menu to use as the menu bar and another identical menu to use for everything else.

The use of certain destructive [menu sub-commands](Menu.htm) such as Delete and DeleteAll against a menu that is currently being used as a menu bar (and in some cases, its submenus) is not supported and will cause an error dialog to be displayed (unless [UseErrorLevel](Menu.htm) is in effect). Use the following steps to make such changes: 1) detach the menu bar via `Gui Menu` (that is, omit _MenuName_); 2) make the changes; 3) reattach the menu bar via `Gui, Menu, MyMenuBar`.

### Minimize / Maximize / Restore

Unhides the window (if necessary) then perform the indicated operation on it.

```
<span class="func">Gui</span>, Minimize
<span class="func">Gui</span>, Maximize
<span class="func">Gui</span>, Restore
```

If the window does not exist -- perhaps due to having been destroyed via [Gui Destroy](#Destroy) \-\- this sub-command has no effect.

### Flash

Blinks the window's button in the taskbar.

```
<span class="func">Gui</span>, Flash <span class="optional">, Off</span>
```

This is done by inverting the color of the window's title bar and/or taskbar button (if it has one). The optional word OFF causes the title bar and taskbar button to return to their original colors (but the actual behavior might vary depending on OS version). In the below example, the window will blink three times because each pair of flashes inverts then restores its appearance:

```
Loop 6
{
    Gui Flash
    Sleep 500  <em>; It's quite sensitive to this value; altering it may change the behavior in unexpected ways.</em>
}
```

### Default

Changes the [current thread](../misc/Threads.htm)'s default [GUI window name](#MultiWin).

```
<span class="func">Gui</span>, GuiName:Default
```

This is used whenever a window name is not specified for [GuiControl](GuiControl.htm), [GuiControlGet](GuiControlGet.htm), and the Gui command itself. In the following example, the default window name is changed to "MyGui": `Gui MyGui:Default`. See [thread's default window](#DefaultWin) for more information about the default window.

[v1.1.03+]: _GuiName_ can be the [HWND](#GuiHwndOutputVar) of one of the script's GUI windows. If the window has a name, it becomes the default name and remains so even after the window itself is destroyed. If the window has no name, the default name reverts to 1 when the window is destroyed.

[v1.1.23+]: The built-in variable **A\_DefaultGui** contains the name or number of the default GUI.

## Options for a Control (Gui Add)

### Positioning and Sizing of Controls

**Note:** Although the options described in this section are suitable for simple layouts, you may find it easier to use Rajat's SmartGUI Creator because it's entirely visual; that is, "what you see is what you get". SmartGUI Creator is free and can be downloaded from [www.autohotkey.com/docs/SmartGUI/](https://www.autohotkey.com/docs/SmartGUI/)

If some dimensions and/or coordinates are omitted from _Options_, the control will be positioned relative to the previous control and/or sized automatically according to its nature and contents.

The following options are supported:

**R**: Rows of text (can contain a floating point number such as R2.5). **R** is often preferable to specifying **H** (Height). If both the **R** and **H** options are present, **R** will take precedence. For a GroupBox, this setting is the number of controls for which to reserve space inside the box. For [DropDownLists](GuiControls.htm#DropDownList), [ComboBoxes](GuiControls.htm#ComboBox), and [ListBoxes](GuiControls.htm#ListBox), it is the number of items visible at one time inside the list portion of the control (but on Windows XP or later, it is often desirable to omit both the **R** and **H** options for DropDownList and ComboBox, which makes the popup list automatically take advantage of the available height of the user's desktop). For other control types, **R** is the number of rows of text that can visibly fit inside the control.

**W**: Width, in pixels. If omitted, the width is calculated automatically for some control types based on their contents; tab controls default to 30 times the current font size, plus 3 times the [X-margin](#Margin); vertical Progress Bars default to two times the current font size; and horizontal Progress Bars, horizontal Sliders, DropDownLists, ComboBoxes, ListBoxes, GroupBoxes, Edits, and Hotkeys default to 15 times the current font size (except GroupBoxes, which multiply by 18 to provide room inside for margins).

**H**: Height, in pixels. If both the **H** and **R** options are absent, DropDownLists, ComboBoxes, ListBoxes, and empty multi-line Edit controls default to 3 rows; GroupBoxes default to 2 rows; vertical Sliders and Progress Bars default to 5 rows; horizontal Sliders default to 30 pixels (except if a thickness has been specified); horizontal Progress Bars default to 2 times the current font size; Hotkey controls default to 1 row; and Tab controls default to 10 rows. For the other control types, the height is calculated automatically based on their contents. Note that for DropDownLists and ComboBoxes, **H** is the combined height of the control's always-visible portion and its list portion (but even if the height is set too low, at least one item will always be visible in the list). Also, for all types of controls, specifying the number of rows via the **R** option is usually preferable to using **H** because it prevents a control from showing partial/incomplete rows of text.

**wp+n**, **hp+n**, **wp-n**, **hp-n** (where **n** is any number) can be used to set the width and/or height of a control equal to the previously added control's width or height, with an optional plus or minus adjustment. For example, `wp` would set a control's width to that of the previous control, and `wp-50` would set it equal to 50 less than that of the previous control.

**X**, **Y**: X-position, Y-position. For example, specifying `x0 y0` would position the control in the upper left corner of the window's client area, which is the area beneath the title bar and menu bar (if any).

**x+n**, **y+n** (where **n** is any number): An optional plus sign can be included to position a control relative to the right or bottom edge (respectively) of the control that was previously added. For example, specifying `Y+10` would position the control 10 pixels beneath the bottom of the previous control rather than using the standard padding distance. Similarly, specifying `X+10` would position the control 10 pixels to the right of the previous control's right edge. Since negative numbers such as `X-10` are reserved for absolute positioning, to use a negative offset, include a plus sign in front of it. For example: `X+-10`.

[v1.1.16+]: For **X+** and **Y+**, the letter **M** can be used as a substitute for the window's current [margin](#Margin). For example, `x+m` uses the right edge of the previous control plus the standard padding distance. `xp y+m` positions a control below the previous control, whereas specifying a relative X coordinate on its own (with xp or x+) would normally imply `yp` by default.

**xp+n**, **yp+n**, **xp-n**, **yp-n** (where **n** is any number) can be used to position controls relative to the previous control's upper left corner, which is often useful for enclosing controls in a [GroupBox](GuiControls.htm#GroupBox).

**xm** and **ym** can be used to position a control at the leftmost and topmost [margins](#Margin) of the window, respectively (these two may also be followed by a plus/minus sign and a number).

**xs** and **ys**: these are similar to **xm** and **ym** except that they refer to coordinates that were saved by having previously added a control with the word [Section](#Section) in its options (the first control of the window always starts a new section, even if that word isn't specified in its options). For example:

```
gui, add, edit, w600  <em>; Add a fairly wide edit control at the top of the window.</em>
gui, add, text, <strong>section</strong>, First Name:  <em>; Save this control's position and start a new section.</em>
gui, add, text,, Last Name:
gui, add, edit, <strong>ys</strong>  <em>; Start a new column within this section.</em>
gui, add, edit
gui, show
```

**xs** and **ys** may optionally be followed by a plus/minus sign and a number. Also, it is possible to specify both the word [Section](#Section) and xs/ys in a control's options; this uses the previous section for itself but establishes a new section for subsequent controls.

Omitting either **X**, **Y** or both is useful to make a GUI layout automatically adjust to any future changes you might make to the size of controls or font. By contrast, specifying an absolute position for every control might require you to manually shift the position of all controls that lie beneath and/or to the right of a control that is being enlarged or reduced.

If both **X** and **Y** are omitted, the control will be positioned beneath the previous control using a standard padding distance (the current [margin](#Margin)). Consecutive Text or Link controls are given additional vertical padding, so that they typically align better in cases where a column of Edit, DDL or similar-sized controls are later added to their right. To use only the standard vertical margin, specify `Y+M` or any value for X.

If only one component is omitted, its default value depends on which option was used to specify the other component:

Specified XDefault for Yx _n_ or xmBeneath all previous controls (maximum Y extent plus margin).xsBeneath all previous controls since the most recent use of the [Section](#Section) option.x+ _n_ or xpSame as the previous control's top edge ( [yp](#xp)).Specified YDefault for Xy _n_ or ymTo the right of all previous controls (maximum X extent plus margin).ysTo the right of all previous controls since the most recent use of the [Section](#Section) option.y+ _n_ or ypSame as the previous control's left edge ( [xp](#xp)).

### Storing and Responding to User Input

**V**: Variable. Associates a variable with a control. Immediately after the letter V, specify the name of a global variable (or a [ByRef local](../Functions.htm#ByRef) that points to a global, or [in v1.0.46.01+] a [static variable](../Functions.htm#static)). For example, specifying `<strong>v</strong>MyEdit` would store the control's contents in the variable _MyEdit_ whenever the [Gui Submit](#Submit) command is used. If a control is not input-capable -- such as a Text control or GroupBox -- associating a variable with it can still be helpful since that variable's name serves as the control's unique identifier for use with [GuiControl](GuiControl.htm), [GuiControlGet](GuiControlGet.htm), and [A\_GuiControl](../Variables.htm#GuiControl).

**Note**: [Gui Submit](#Submit) does not change the contents of variables of non-input-capable controls (such as Text and GroupBox), nor certain others as documented in their sections (such as [ListView](ListView.htm) and [TreeView](TreeView.htm)).

**G**: Gosub (g-label). Launches a subroutine or function automatically when the user clicks or changes a control. Immediately after the letter G, specify the name of the [label](../misc/Labels.htm) to execute. `gCancel` may be specified to perform an implicit [Gui Cancel](#Cancel) (but if a label named "Cancel" exists in the script, it will be executed instead). The subroutine may consult the following built-in variables: [A\_Gui](../Variables.htm#Gui), [A\_GuiControl](../Variables.htm#GuiControl), [A\_GuiEvent](../Variables.htm#GuiEvent), [A\_EventInfo](../Variables.htm#EventInfo), and [A\_ThisLabel](../Variables.htm#ThisLabel).

[v1.1.20+]: If not a valid label name, a function name can be used instead. Alternatively, the [GuiControl](GuiControl.htm#Functor) command can be used to associate a [function object](../objects/Functor.htm) with the control. The function can optionally accept the following parameters (where `gCtrlEvent` sets the function):

```
<span class="func">CtrlEvent</span>(CtrlHwnd, GuiEvent, EventInfo, ErrLevel:="")
```

The meanings of the parameters depends on the type of control. Note that if the fourth parameter is declared without a default value, the function will only be called by events which supply four parameters.

### Controls: Common Styles and Other Options

**Note**: In the absence of a preceding sign, a plus sign is assumed; for example, `Wrap` is the same as `+Wrap`. By contrast, `-Wrap` would remove the word-wrapping property.

**AltSubmit**: Uses alternate submit method. For DropDownList, ComboBox, and ListBox this causes the [Gui Submit](#Submit) command to store the position of the selected item rather than its text. If no item is selected, a ComboBox will still store the text in its edit field; similarly, a DropDownList or ListBox will still make its [output variable](#var) blank. Note: AltSubmit also affects the behavior of [GuiControlGet](GuiControlGet.htm) when retrieves the contents of such a control.

**C**: Color of text (has no effect on [buttons](GuiControls.htm#Button)). Specify the letter C followed immediately by a color name (see [color chart](Progress.htm#colors)) or RGB value (the 0x prefix is optional). Examples: `cRed`, `cFF2211`, `c0xFF2211`, `cDefault`.

**Choose**: Pre-select a single item in a [ComboBox](../commands/GuiControls.htm#ComboBox), [DateTime](../commands/GuiControls.htm#DateTime), [DropDownList](../commands/GuiControls.htm#DropDownList), [ListBox](../commands/GuiControls.htm#ListBox) or [Tab](../commands/GuiControls.htm#Tab) control. Specify the word `Choose` followed immediately by the number of an item. For example: `Choose2`

**Disabled**: Makes an input-capable control appear in a disabled state, which prevents the user from focusing or modifying its contents. Use [GuiControl Enable](GuiControl.htm#EnableDisable) to enable it later. Note: To make an Edit control read-only, specify the string `ReadOnly` instead. Also, the word Disabled may optionally be followed immediately by a 0 or 1 to indicate the starting state (0 for enabled and 1 for disabled). In other words, `Disabled` and `Disabled%VarContainingOne%` are the same.

**Hidden**: The control is initially invisible. Use [GuiControl Show](GuiControl.htm#Show) to show it later. The word Hidden may optionally be followed immediately by a 0 or 1 to indicate the starting state (0 for visible and 1 for hidden). In other words, `Hidden` and `Hidden%VarContainingOne%` are the same.

**Left**: Left-justifies the control's text within its available width. This option affects the following controls: Text, Edit, Button, Checkbox, Radio, UpDown, Slider, Tab, Tab2, GroupBox, DateTime.

**Right**: Right-justifies the control's text within its available width. For checkboxes and radio buttons, this also puts the box itself on the right side of the control rather than the left. This option affects the following controls: Text, Edit, Button, Checkbox, Radio, UpDown, Slider, Tab, Tab2, GroupBox, DateTime, Link.

**Center**: Centers the control's text within its available width. This option affects the following controls: Text, Edit, Button, Checkbox, Radio, Slider, GroupBox.

**Section**: Starts a new section and saves this control's position for later use with the _xs_ and _ys_ positioning options described [above](#xs).

**Tabstop**: Use `-Tabstop` (i.e. minus Tabstop) to have an input-capable control skipped over when the user presses Tab to navigate.

**Wrap**: Enables word-wrapping of the control's contents within its available width. Since nearly all control types start off with word-wrapping enabled, use `-Wrap` to disable word-wrapping.

**VScroll**: Provides a vertical scroll bar if appropriate for this type of control.

**HScroll**: Provides a horizontal scroll bar if appropriate for this type of control. The rest of this paragraph applies to [ListBox](GuiControls.htm#ListBox) only. The horizontal scrolling width defaults to 3 times the width of the ListBox. To specify a different scrolling width, include a number immediately after the word HScroll. For example, `HScroll500` would allow 500 pixels of scrolling inside the ListBox. However, if the specified scrolling width is smaller than the width of the ListBox, no scroll bar will be shown (though the mere presence of _HScroll_ makes it possible for the horizontal scroll bar to be added later via `<a href="GuiControl.htm" data-index="218">GuiControl</a>, +HScroll500, MyScrollBar`, which is otherwise impossible).

### Controls: Uncommon Styles and Options

**BackgroundTrans**: Uses a transparent background, which allows any control that lies behind a Text, Picture, or GroupBox control to show through. For example, a transparent Text control displayed on top of a Picture control would make the text appear to be part of the picture. Use `<a href="GuiControl.htm" data-index="219">GuiControl</a> +Background` to remove this option later. See [Picture control's AltSubmit section](GuiControls.htm#PicAltSubmit) for more information about transparent images. Known limitation: BackgroundTrans might not work properly for controls inside a [Tab control](GuiControls.htm#Tab) that contains a [ListView](ListView.htm).

**-Background** (i.e. minus Background): Uses the standard background color rather than the one set by the [Gui Color](#Color) command. This is most often used to make a Tab control have its standard color rather than the window color. Use `<a href="GuiControl.htm" data-index="224">GuiControl</a> +Background` to remove this option later.

**Border**: Provides a thin-line border around the control. Most controls do not need this because they already have a type-specific border. When adding a border to an _existing_ control, it might be necessary to increase the control's width and height by 1 pixel.

**Hwnd** _OutputVar_[v1.0.46.01+]: When used with [Gui Add](#Add), this option stores the window handle (HWND) of the newly created control in _OutputVar_. For example: `Gui, Add, Edit, vMyEdit HwndMyEditHwnd`. When within a function, _MyEditHwnd_ is treated as a [function dynamic variable](../Functions.htm#DynVar). A control's HWND is often used with [PostMessage](PostMessage.htm), [SendMessage](PostMessage.htm), and [DllCall()](DllCall.htm). It can also be used directly as an [ahk\_id WinTitle](../misc/WinTitle.htm#ahk_id) (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off) or [in v1.1.04+] with GuiControl and GuiControlGet as the _ControlID_ parameter. On a related note, a parent window's HWND can be retrieved via [Gui MyGui:+HwndOutputVar](#GuiHwndOutputVar).

**Theme**: This option can be used to override the window's current theme setting for the newly created control. It has no effect when used on an existing control; however, this may change in a future version. See [Gui +/-Theme](#Theme) for details.

**(Unnamed Style)**: Specify a plus or minus sign followed immediately by a decimal or hexadecimal [style number](../misc/Styles.htm). If the sign is omitted, a plus sign is assumed.

**(Unnamed ExStyle)**: Specify a plus or minus sign followed immediately by the letter E and a decimal or hexadecimal extended style number. If the sign is omitted, a plus sign is assumed. For example, `E0x200` would add the WS\_EX\_CLIENTEDGE style, which provides a border with a sunken edge that might be appropriate for pictures and other controls. Although the other extended styles are not documented here (since they are rarely used), they can be discovered by searching for WS\_EX\_CLIENTEDGE at [www.microsoft.com](https://www.microsoft.com).

## Window Events

The following labels (subroutines) will be automatically associated with a GUI window if they exist in the script:

- [GuiClose](#GuiClose)
- [GuiEscape](#GuiEscape)
- [GuiSize](#GuiSize)
- [GuiContextMenu](#GuiContextMenu)
- [GuiDropFiles](#GuiDropFiles)

[v1.1.20+]: If a label does not exist for a given event, a function with that name can be called instead. The function can optionally receive the [HWND](#GuiHwndOutputVar) of the GUI as its first parameter. Some events have additional parameters.

For windows [other than number 1](#MultiWin), the window's name or number (if it has one) is used as a prefix for the special labels mentioned above; for example, 2GuiEscape and 2GuiClose would be the default labels for window number 2, while _MyGui_ GuiEscape and _MyGui_ GuiClose would be the default labels for _MyGui_. To set a custom prefix, use [Gui +Label](#PlusLabel).

### GuiClose

Launched when the window is closed by any of the following: pressing its X button in the title bar, selecting "Close" from its system menu, or closing it with [WinClose](WinClose.htm). If this label is absent, closing the window simply hides it, which is the same effect as [Gui Cancel](#Cancel). One of the most common actions to take in response to GuiClose is [ExitApp](ExitApp.htm); for example:

```
GuiClose:
ExitApp
```

[v1.1.20+]: If GuiClose is a function, the GUI is hidden by default. The function can prevent this by returning a non-zero integer, as in the example below:

```
GuiClose(GuiHwnd) {  <em>; Declaring this parameter is optional.</em>
    MsgBox 4,, Are you sure you want to hide the GUI?
    IfMsgBox No
        return true  <em>; true = 1</em>
}
```

### GuiEscape

Launched when the user presses Esc while the GUI window is active. If this label is absent, pressing Esc has no effect.
Known limitation: If the first control in the window is disabled (possibly depending on control type), the GuiEscape label will not be launched. There may be other circumstances that produce this effect.

### GuiSize

Launched when the window is resized, minimized, maximized, or restored. The built-in variables [A\_GuiWidth](../Variables.htm#GuiWidth) and [A\_GuiHeight](../Variables.htm#GuiWidth) contain the new width and height of the window's client area, which is the area excluding title bar, menu bar, and borders. In addition, [A\_EventInfo](../Variables.htm#EventInfo) and [ErrorLevel](../misc/ErrorLevel.htm) will both contain one of the following digits:

- 0 = The window has been restored, or resized normally such as by dragging its edges.
- 1 = The window has been minimized.
- 2 = The window has been maximized.

A script may use GuiSize to reposition and resize controls in response to the user's resizing of the window. This process can be made easier by using [AutoXYWH() by tmplinshi and toralf](https://www.autohotkey.com/boards/viewtopic.php?f=6&t=1079).

When the window is resized (even by the script), GuiSize might not be called immediately. As with other window events, if the current thread is [uninterruptible](Thread.htm#Interrupt), GuiSize won't be called until the thread becomes interruptible. If the script has just resized the window, follow this example to ensure GuiSize is called immediately:

```
<a href="Critical.htm#Off" data-index="253">Critical</a> Off  <em>; Even if Critical On was never used.</em>
<a href="Sleep.htm" data-index="254">Sleep</a> -1
```

[v1.1.22.05+]: [Gui Show](#Show) automatically does a `Sleep -1`, so it is generally not necessary to call Sleep in that case.

[v1.1.20+]: If GuiSize is a function, its parameters are as follows:

```
<span class="func">GuiSize</span>(GuiHwnd, EventInfo, Width, Height)
```

### GuiContextMenu

Launched whenever the user right-clicks anywhere in the window except the title bar and menu bar. It is also launched in response to pressing Menu or Shift+F10. Unlike most other GUI labels, GuiContextMenu can have more than one concurrent [thread](../misc/Threads.htm). The following built-in variables are available within GuiContextMenu:

1. [A\_GuiControl](../Variables.htm#GuiControl), which contains the [text or variable name](../Variables.htm#GuiControl) of the control that received the event (blank if none).
2. [A\_EventInfo](../Variables.htm#EventInfo): When a ListBox, ListView, or TreeView is the target of the context menu (as determined by A\_GuiControl above), A\_EventInfo specifies which of the control's items is the target:

   - [ListBox](GuiControls.htm#ListBox) or [ListView](ListView.htm): A\_EventInfo contains the number of the currently focused row (0 if none).
   - [TreeView](TreeView.htm): For right-clicks, A\_EventInfo contains the clicked item's ID number (or 0 if the user clicked somewhere other than an item). For Menu and Shift+F10, A\_EventInfo contains the selected item's ID number.
3. A\_GuiX and A\_GuiY, which contain the X and Y coordinates of where the script should display the menu (e.g.`<a href="Menu.htm" data-index="263">Menu</a>, MyContext, Show, %A_GuiX%, %A_GuiY%`). Coordinates are relative to the upper-left corner of the window.
4. A\_GuiEvent, which contains the word RightClick if the user right-clicked, or Normal if the menu was triggered byMenu or Shift+F10.

**Note**: Since [Edit](GuiControls.htm#Edit) and [MonthCal](GuiControls.htm#MonthCal) controls have their own context menu, a right-click in one of them will not launch GuiContextMenu.

[v1.1.20+]: If GuiContextMenu is a function, its parameters are as follows:

```
<span class="func">GuiContextMenu</span>(GuiHwnd, CtrlHwnd, EventInfo, IsRightClick, X, Y)
```

_CtrlHwnd_ is blank if the event was not received by a control. _IsRightClick_ is true if A\_GuiEvent is RightClick.

### GuiDropFiles

Launched whenever files/folders are dropped onto the window as part of a drag-and-drop operation (but if the label is already running, drop events are ignored). The following built-in variables are available within GuiDropFiles:

1. [A\_GuiControl](../Variables.htm#GuiControl), which contains the [text or variable name](../Variables.htm#GuiControl) of the control upon which the files were dropped (blank if none).
2. [A\_EventInfo](../Variables.htm#EventInfo) and [ErrorLevel](../misc/ErrorLevel.htm), which both contain the number of files dropped.
3. A\_GuiX and A\_GuiY, which contain the X and Y coordinates of where the files were dropped (relative to the window's upper left corner).
4. A\_GuiEvent, which contains the names of the files that were dropped, with each filename except the last terminated by a linefeed (\`n).

To extract the individual files, use a [parsing loop](LoopParse.htm) as shown below:

```
<em>; EXAMPLE #1:</em>
Loop, Parse, A_GuiEvent, `n
{
    MsgBox, 4,, File number %A_Index% is:`n%A_LoopField%.`n`nContinue?
    IfMsgBox, No, break
}

<em>; EXAMPLE #2: To extract only the first file, follow this example:</em>
Loop, Parse, A_GuiEvent, `n
{
    FirstFile := A_LoopField
    break
}

<em>; EXAMPLE #3: To process the files in alphabetical order, follow this example:</em>
FileList := A_GuiEvent
Sort, FileList
Loop, Parse, FileList, `n
    MsgBox File number %A_Index% is:`n%A_LoopField%.
```

To temporarily disable drag-and-drop for a window, remove the WS\_EX\_ACCEPTFILES style via `Gui -E0x10`. To re-enable it later, use `Gui +E0x10`.

[v1.1.20+]: If GuiDropFiles is a function, the parameters are as shown in the example below. _CtrlHwnd_ is blank if files were dropped on the GUI itself. _FileArray_ is an [array (object)](../Objects.htm#Usage_Simple_Arrays) of filenames, where `FileArray[1]` is the first file and `FileArray.MaxIndex()` returns the number of files. A [for-loop](For.htm) can be used to iterate through the files:

```
GuiDropFiles(GuiHwnd, FileArray, CtrlHwnd, X, Y) {
    for i, file in FileArray
        MsgBox File %i% is:`n%file%
}

```

### Other Events

Other types of GUI events can be detected and acted upon via [OnMessage()](OnMessage.htm). For example, a script can display context-sensitive help via ToolTip whenever the user moves the mouse over particular controls in the window. This is demonstrated in the [GUI ToolTip example](#ExToolTip).

## Creating Multiple GUI Windows

To operate upon a window other than the [default](#DefaultWin), include its name or number (or [in v1.1.03+] its [HWND](#GuiHwndOutputVar)) followed by a colon in front of the sub-command, as in these examples:

```
Gui, <strong>MyGui:</strong>Add, Text,, Text for about-box.
Gui, <strong>MyGui:</strong>Show
```

`<a href="#Default" data-index="277">Gui MyGui:Default</a>` can be used to avoid the need for the "MyGui:" prefix above. In addition, the prefix is not necessary inside a [GUI thread](#DefaultWin) that operates upon the same window that launched the thread.

[v1.1.03+]: Gui names must conform to the same rules as [variable names](../Concepts.htm#names). Any number which is either not between 1 and 99 or is longer than two characters (such as 0x01) must be the HWND of an existing Gui, or the command will fail. The number of windows that can be created is limited only by available system resources.

[v1.1.04+]: Any number of unnamed GUI windows can be created using [Gui, New](#New).

## GUI Events, Threads, and Subroutines

A GUI [thread](../misc/Threads.htm) is defined as any thread launched as a result of a GUI action. GUI actions include selecting an item from a GUI window's [menu bar](#Menu), or triggering one of its [g-labels](#label) (such as by pressing a button).

The **default [window name](#MultiWin)** for a GUI thread is that of the window that launched the thread. Non-GUI threads use 1 as their default.

Whenever a GUI [thread](../misc/Threads.htm) is launched, that thread's [last found window](../misc/WinTitle.htm#LastFoundWindow) starts off as the GUI window itself. This allows commands for windows and controls -- such as [WinMove](WinMove.htm), [WinHide](WinHide.htm), [WinSet](WinSet.htm), [WinSetTitle](WinSetTitle.htm), and [ControlGetFocus](ControlGetFocus.htm) \-\- to omit WinTitle and WinText when operating upon the GUI window itself (even if it is hidden).

Clicking on a control while its [g-label](#label) is already running from a prior click will have no effect and the event is discarded. To prevent this, use [Critical](Critical.htm) as the subroutine's first line (however, this will also buffer/defer other [threads](../misc/Threads.htm) such as the press of a hotkey).

The built-in variables A\_Gui and A\_GuiControl contain the window name and Control ID that launched the current thread. For details see [A\_Gui](../Variables.htm#Gui) and [A\_GuiControl](../Variables.htm#GuiControl).

To have multiple events perform the same subroutine, specify their labels consecutively above the subroutine. For example:

```
GuiEscape:
GuiClose:
ButtonCancel:
ExitApp  <em>; All of the above labels will do this.</em>
```

All GUI [threads](../misc/Threads.htm) start off fresh with the default values for settings such as [SendMode](SendMode.htm). These defaults can be changed in the [auto-execute section](../Scripts.htm#auto).

## Keyboard Navigation

A GUI window may be navigated via Tab, which moves keyboard focus to the next input-capable control (controls from which the [Tabstop](#Tabstop) style has been removed are skipped). The order of navigation is determined by the order in which the controls were originally added. When the window is shown for the first time, the first input-capable control that has the Tabstop style (which most control types have by default) will have keyboard focus.

Certain controls may contain an ampersand (&) to create a keyboard shortcut, which might be displayed in the control's text as an underlined character (depending on system settings). A user activates the shortcut by holding down Alt then typing the corresponding character. For buttons, checkboxes, and radio buttons, pressing the shortcut is the same as clicking the control. For GroupBoxes and Text controls, pressing the shortcut causes keyboard focus to jump to the first input-capable [tabstop](#Tabstop) control that was created after it. However, if more than one control has the same shortcut key, pressing the shortcut will alternate keyboard focus among all controls with the same shortcut.

To display a literal ampersand inside the control types mentioned above, specify two consecutive ampersands as in this example: `Gui, Add, Button,, Save && Exit`.

## Window Appearance

For its icon, a GUI window uses the tray icon that was in effect at the time the window was created. Thus, to have a different icon, change the tray icon before creating the window. For example: `<a href="Menu.htm" data-index="302">Menu</a>, Tray, Icon, MyIcon.ico`. It is also possible to have a different large icon for a window than its small icon (the large icon is displayed in the alt-tab task switcher). This can be done via [LoadPicture()](LoadPicture.htm) and [SendMessage](PostMessage.htm); for example:

```
iconsize := 32  <em>; Ideal size for alt-tab varies between systems and OS versions.</em>
hIcon := LoadPicture("My Icon.ico", "Icon1 w" iconsize " h" iconsize, imgtype)
Gui +LastFound
SendMessage 0x0080, 1, hIcon  <em>; 0x0080 is WM_SETICON; and 1 means ICON_BIG (vs. 0 for ICON_SMALL).</em>
Gui Show
```

Due to OS limitations, Checkboxes, Radio buttons, and GroupBoxes for which a non-default text color was specified will take on Classic Theme appearance on Windows XP and beyond.

Related topic: [window's margin](#Margin).

## General Remarks

Use [GuiControl](GuiControl.htm) and [GuiControlGet](GuiControlGet.htm) to operate upon individual controls in a GUI window.

Each GUI window may have up to 11,000 controls. However, use caution when creating more than 5000 controls because system instability may occur for certain control types.

Any script that uses the GUI command anywhere is automatically [persistent](_Persistent.htm) (even if the GUI command is never actually executed). It is also single-instance unless the [#SingleInstance](_SingleInstance.htm) directive has been used to override that.

## Related

[GuiControl](GuiControl.htm), [GuiControlGet](GuiControlGet.htm), [Menu](Menu.htm), [Control Types](GuiControls.htm), [ListView](ListView.htm), [TreeView](TreeView.htm), [Control](Control.htm), [ControlGet](ControlGet.htm), [SplashImage](Progress.htm), [MsgBox](MsgBox.htm), [FileSelectFile](FileSelectFile.htm), [FileSelectFolder](FileSelectFolder.htm)

## Examples

Creates a popup window similar to [SplashTextOn](SplashTextOn.htm).

```
Gui, +AlwaysOnTop +Disabled -SysMenu +Owner  <em>; +Owner avoids a taskbar button.</em>
Gui, Add, Text,, Some text to display.
Gui, Show, NoActivate, Title of Window  <em>; NoActivate avoids deactivating the currently active window.</em>
```

Creates a simple input-box that asks for the first and last name.

```
Gui, Add, Text,, First name:
Gui, Add, Text,, Last name:
Gui, Add, Edit, vFirstName ym  <em>; The ym option starts a new column of controls.</em>
Gui, Add, Edit, vLastName
Gui, Add, Button, default, OK  <em>; The label ButtonOK (if it exists) will be run when the button is pressed.</em>
Gui, Show,, Simple Input Example
return  <em>; End of auto-execute section. The script is idle until the user does something.</em>

GuiClose:
ButtonOK:
Gui, Submit  <em>; Save the input from the user to each control's associated variable.</em>
MsgBox You entered "%FirstName% %LastName%".
ExitApp
```

Creates a tab control with multiple tabs, each containing different controls to interact with.

```
Gui, Add, Tab2,, First Tab|Second Tab|Third Tab  <em>; Tab2 vs. Tab requires <span class="ver">[v1.0.47.05+]</span>.</em>
Gui, Add, Checkbox, vMyCheckbox, Sample checkbox
Gui, Tab, 2
Gui, Add, Radio, vMyRadio, Sample radio1
Gui, Add, Radio,, Sample radio2
Gui, Tab, 3
Gui, Add, Edit, vMyEdit r5  <em>; r5 means 5 rows tall.</em>
Gui, Tab  <em>; i.e. subsequently-added controls will not belong to the tab control.</em>
Gui, Add, Button, default xm, OK  <em>; xm puts it at the bottom left corner.</em>
Gui, Show
return

ButtonOK:
GuiClose:
GuiEscape:
Gui, Submit  <em>; Save each control's contents to its associated variable.</em>
MsgBox You entered:`n%MyCheckbox%`n%MyRadio%`n%MyEdit%
ExitApp
```

Creates a ListBox control containing files in a directory.

```
Gui, Add, Text,, Pick a file to launch from the list below.`nTo cancel, press ESCAPE or close this window.
Gui, Add, ListBox, vMyListBox gMyListBox w640 r10
Gui, Add, Button, Default, OK
Loop, C:\*.*  <em>; Change this folder and wildcard pattern to suit your preferences.</em>
{
    GuiControl,, MyListBox, %A_LoopFileFullPath%
}
Gui, Show
return

MyListBox:
if (A_GuiEvent != "DoubleClick")
    return
<em>; Otherwise, the user double-clicked a list item, so treat that the same as pressing OK.
; So fall through to the next label.</em>
ButtonOK:
GuiControlGet, MyListBox  <em>; Retrieve the ListBox's current selection.</em>
MsgBox, 4,, Would you like to launch the file or document below?`n`n%MyListBox%
IfMsgBox, No
    return
<em>; Otherwise, try to launch it:</em>
Run, %MyListBox%,, UseErrorLevel
if (ErrorLevel = "ERROR")
    MsgBox Could not launch the specified file. Perhaps it is not associated with anything.
return

GuiClose:
GuiEscape:
ExitApp
```

Displays a context-sensitive help (via ToolTip) whenever the user moves the mouse over a particular control.

```
Gui, Add, Edit, v<strong>MyEdit</strong>
<strong>MyEdit</strong>_TT := "This is a tooltip for the control whose variable is MyEdit."
Gui, Add, DropDownList, v<strong>MyDDL</strong>, Red|Green|Blue
<strong>MyDDL</strong>_TT := "Choose a color from the drop-down list."
Gui, Add, Checkbox, vMyCheck, This control has no tooltip.
Gui, Show
<a href="OnMessage.htm" data-index="328">OnMessage</a>(0x0200, "WM_MOUSEMOVE")
return

WM_MOUSEMOVE()
{
    static CurrControl, PrevControl, _TT  <em>; _TT is kept blank for use by the ToolTip command below.</em>
    CurrControl := A_GuiControl
    if (CurrControl != PrevControl and not InStr(CurrControl, " "))
    {
        ToolTip  <em>; Turn off any previous tooltip.</em>
        SetTimer, DisplayToolTip, 1000
        PrevControl := CurrControl
    }
    return

    DisplayToolTip:
    SetTimer, DisplayToolTip, Off
    <a href="ToolTip.htm" data-index="329">ToolTip</a> % %CurrControl%_TT  <em>; The leading percent sign tell it to use an expression.</em>
    SetTimer, RemoveToolTip, 3000
    return

    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
}

GuiClose:
ExitApp
```

Creates an On-screen display (OSD) via transparent window.

```
CustomColor := "EEAA99"  <em>; Can be any RGB color (it will be made transparent below).</em>
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  <em>; +ToolWindow avoids a taskbar button and an alt-tab menu item.</em>
Gui, Color, %CustomColor%
Gui, Font, s32  <em>; Set a large font size (32-point).</em>
Gui, Add, Text, vMyText cLime, XXXXX YYYYY  <em>; XX & YY serve to auto-size the window.
; Make all pixels of this color transparent and make the text itself translucent (150):</em>
WinSet, TransColor, %CustomColor% 150
SetTimer, UpdateOSD, 200
Gosub, UpdateOSD  <em>; Make the first update immediate rather than waiting for the timer.</em>
Gui, Show, x0 y400 NoActivate  <em>; NoActivate avoids deactivating the currently active window.</em>
return

UpdateOSD:
MouseGetPos, MouseX, MouseY
GuiControl,, MyText, X%MouseX%, Y%MouseY%
return
```

Creates a moving progress bar overlayed on a background image.

```
Gui, Color, White
Gui, Add, Picture, x0 y0 h350 w450, %A_WinDir%\system32\ntimage.gif
Gui, Add, Button, Default xp+20 yp+250, Start the Bar Moving
Gui, Add, Progress, vMyProgress w416
Gui, Add, Text, vMyText wp  <em>; wp means "use width of previous".</em>
Gui, Show
return

ButtonStartTheBarMoving:
Loop, %A_WinDir%\*.*
{
    if (A_Index > 100)
        break
    GuiControl,, MyProgress, %A_Index%
    GuiControl,, MyText, %A_LoopFileName%
    Sleep 50
}
GuiControl,, MyText, Bar finished.
return

GuiClose:
ExitApp
```

Creates a simple image viewer.

```
Gui, +Resize
Gui, Add, Button, default, &Load New Image
Gui, Add, Radio, ym+5 x+10 vRadio checked, Load &actual size
Gui, Add, Radio, ym+5 x+10, Load to &fit screen
Gui, Add, Pic, xm vPic
Gui, Show
return

ButtonLoadNewImage:
FileSelectFile, file,,, Select an image:, Images (*.gif; *.jpg; *.bmp; *.png; *.tif; *.ico; *.cur; *.ani; *.exe; *.dll)
if not file
    return
Gui, Submit, NoHide <em>; Save the values of the radio buttons.</em>
if (Radio = 1)  <em>; Display image at its actual size.</em>
{
    Width := 0
    Height := 0
}
else <em>; Second radio is selected: Resize the image to fit the screen.</em>
{
    Width := A_ScreenWidth - 28  <em>; Minus 28 to allow room for borders and margins inside.</em>
    Height := -1  <em>; "Keep aspect ratio" seems best.</em>
}
GuiControl,, Pic, *w%width% *h%height% %file%  <em>; Load the image.</em>
Gui, Show, xCenter y0 AutoSize, %file%  <em>; Resize the window to match the picture size.</em>
return

GuiClose:
ExitApp
```

Creates a simple text editor with menu bar.

```
<em>; Create the sub-menus for the menu bar:</em>
Menu, FileMenu, Add, &New, FileNew
Menu, FileMenu, Add, &Open, FileOpen
Menu, FileMenu, Add, &Save, FileSave
Menu, FileMenu, Add, Save &As, FileSaveAs
Menu, FileMenu, Add  <em>; Separator line.</em>
Menu, FileMenu, Add, E&xit, FileExit
Menu, HelpMenu, Add, &About, HelpAbout

<em>; Create the menu bar by attaching the sub-menus to it:</em>
Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu

<em>; Attach the menu bar to the window:</em>
Gui, Menu, MyMenuBar

<em>; Create the main Edit control and display the window:</em>
Gui, +Resize  <em>; Make the window resizable.</em>
Gui, Add, Edit, vMainEdit WantTab W600 R20
Gui, Show,, Untitled
CurrentFileName := ""  <em>; Indicate that there is no current file.</em>
return

FileNew:
GuiControl,, MainEdit  <em>; Clear the Edit control.</em>
return

FileOpen:
Gui +OwnDialogs  <em>; Force the user to dismiss the FileSelectFile dialog before returning to the main window.</em>
FileSelectFile, SelectedFileName, 3,, Open File, Text Documents (*.txt)
if not SelectedFileName  <em>; No file selected.</em>
    return
Gosub FileRead
return

FileRead:  <em>; Caller has set the variable SelectedFileName for us.</em>
FileRead, MainEdit, %SelectedFileName%  <em>; Read the file's contents into the variable.</em>
if ErrorLevel
{
    MsgBox Could not open "%SelectedFileName%".
    return
}
GuiControl,, MainEdit, %MainEdit%  <em>; Put the text into the control.</em>
CurrentFileName := SelectedFileName
Gui, Show,, %CurrentFileName%   <em>; Show file name in title bar.</em>
return

FileSave:
if not CurrentFileName   <em>; No filename selected yet, so do Save-As instead.</em>
    Goto FileSaveAs
Gosub SaveCurrentFile
return

FileSaveAs:
Gui +OwnDialogs  <em>; Force the user to dismiss the FileSelectFile dialog before returning to the main window.</em>
FileSelectFile, SelectedFileName, S16,, Save File, Text Documents (*.txt)
if not SelectedFileName  <em>; No file selected.</em>
    return
CurrentFileName := SelectedFileName
Gosub SaveCurrentFile
return

SaveCurrentFile:  <em>; Caller has ensured that CurrentFileName is not blank.</em>
if FileExist(CurrentFileName)
{
    FileDelete %CurrentFileName%
    if ErrorLevel
    {
        MsgBox The attempt to overwrite "%CurrentFileName%" failed.
        return
    }
}
GuiControlGet, MainEdit  <em>; Retrieve the contents of the Edit control.</em>
FileAppend, %MainEdit%, %CurrentFileName%  <em>; Save the contents to the file.
; Upon success, Show file name in title bar (in case we were called by FileSaveAs):</em>
Gui, Show,, %CurrentFileName%
return

HelpAbout:
Gui, About:+owner1  <em>; Make the main window (Gui #1) the owner of the "about box".</em>
Gui +Disabled  <em>; Disable main window.</em>
Gui, About:Add, Text,, Text for about box.
Gui, About:Add, Button, Default, OK
Gui, About:Show
return

AboutButtonOK:  <em>; This section is used by the "about box" above.</em>
AboutGuiClose:
AboutGuiEscape:
Gui, 1:-Disabled  <em>; Re-enable the main window (must be done prior to the next step).</em>
Gui Destroy  <em>; Destroy the about box.</em>
return

GuiDropFiles:  <em>; Support drag & drop.</em>
Loop, Parse, A_GuiEvent, `n
{
    SelectedFileName := A_LoopField  <em>; Get the first file only (in case there's more than one).</em>
    break
}
Gosub FileRead
return

GuiSize:
if (ErrorLevel = 1)  <em>; The window has been minimized. No action needed.</em>
    return
<em>; Otherwise, the window has been resized or maximized. Resize the Edit control to match.</em>
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, MainEdit, W%NewWidth% H%NewHeight%
return

FileExit:     <em>; User chose "Exit" from the File menu.</em>
GuiClose:  <em>; User closed the window.</em>
ExitApp
```

