# Progress / SplashImage

Creates or updates a window containing a progress bar or an image.

**Deprecated:** These commands are not recommended for use in new scripts. Use the [Gui](Gui.htm) command instead.

```
<span class="func">SplashImage</span>, Off
<span class="func">SplashImage</span> <span class="optional">, ImageFile, Options, SubText, MainText, WinTitle, FontName</span>

<span class="func">Progress</span>, Off
<span class="func">Progress</span>, ProgressParam1 <span class="optional">, SubText, MainText, WinTitle, FontName</span>

```

## Parameters

ImageFile

If this is the word OFF, the window is destroyed. If this is the word SHOW, the window is shown if it is currently hidden.

Otherwise, this is the file name of the BMP, GIF, or JPG image to display (to display other file formats such as PNG, TIF, and ICO, consider using the [Gui](Gui.htm) command to create a window containing a picture control).

[AHK\_L 59+]: Any image format supported by Gui may be used with SplashImage.

_ImageFile_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. If _ImageFile_ and _Options_ are blank and the window already exists, its image will be unchanged but its text will be updated to reflect any new strings provided in _SubText_, _MainText_, and _WinTitle_.

For newly created windows, if _ImageFile_ is blank or there is a problem loading the image, the window will be displayed without the picture.

[v1.1.23+]: A [bitmap or icon handle](../misc/ImageHandles.htm) can be used instead of a filename. For example, `HBITMAP:%handle%`.

ProgressParam1

If the progress window already exists: If _Param1_ is the word OFF, the window is destroyed. If _Param1_ is the word SHOW, the window is shown if it is currently hidden.

Otherwise, if _Param1_ is an pure number, its bar's position is changed to that value. If _Param1_ is blank, its bar position will be unchanged but its text will be updated to reflect any new strings provided in _SubText_, _MainText_, and _WinTitle_. In both of these modes, if the window doesn't yet exist, it will be created with the defaults for all options.

If the progress window does not exist: A new progress window is created (replacing any old one), and _Param1_ is a string of zero or more options from the list below.

Options

A string of zero or more options from the list further below.

SubText

The text to display below the image or bar indicator. Although word-wrapping will occur, to begin a new line explicitly, use linefeed (\`n). To set an existing window's text to be blank, specify [%A\_Space%](../Variables.htm#Space). For the purpose of auto-calculating the window's height, blank lines can be reserved in a way similar to _MainText_ below.

MainText

The text to display above the image or bar indicator (its font is semi-bold). Although word-wrapping will occur, to begin a new line explicitly, use linefeed (\`n).

If blank or omitted, no space will be reserved in the window for _MainText_. To reserve space for single line to be added later, or to set an existing window's text to be blank, specify [%A\_Space%](../Variables.htm#Space). To reserve extra lines beyond the first, append one or more linefeeds (\`n).

Once the height of _MainText_'s control area has been set, it cannot be changed without recreating the window.

WinTitle

The title of the window. If omitted and the window is being newly created, the title defaults to the name of the script (without path). If the **B** (borderless) option has been specified, there will be no visible title bar but the window can still be referred to by this title in commands such as [WinMove](WinMove.htm).

FontName

The name of the font to use for both _MainText_ and _SubText_. The [font table](../misc/FontsStandard.htm) lists the fonts included with the various versions of Windows. If unspecified or if the font cannot be found, the system's default GUI font will be used.

See the options section below for how to change the size, weight, and color of the font.

## Window Size, Position, and Behavior

**A**: The window will not be always-on-top.

**B**: Borderless: The window will have no border and no title bar. To have a border but no title bar, use **B1** for a thin border or **B2** for a dialog style border.

**M**: The window will be movable by the user (except if borderless). To additionally make the window resizable (by means of dragging its borders), specify **M1**. To additionally include a system menu and a set of minimize/maximize/close buttons in the title bar, specify **M2**.

**Pn**: For Progress windows, specify for **n** the starting position of the bar (the default is 0 or the number in the allowable range that is closest to 0). To later change the position of the bar, follow this example: `Progress, 50`.

**Rx-y**: For Progress windows, specify for **x-y** the numerical range of the bar (if the **R** option is not present, the default is 0-100). For example, `R0-1000` would allow numbers between 0 and 1000; `R-50-50` would allow numbers between -50 and 50; and `R-10--5` would allow numbers between -10 and -5.

**T**: The window will be given a button in the task bar and it will be unowned. Normally, there is no button because the window is owned by the script's main window. This setting also prevents a GUI window's [Gui +OwnDialogs](Gui.htm#OwnDialogs) setting from taking ownership of a Splash or Progress window.

**Hn**: Specify for **n** the height of the window's client area (which is the area not including title bar and borders). If unspecified, the height will be calculated automatically based on the height of the image/bar and text in the window.

**Wn**: Specify for **n** the width of the window's client area. If unspecified, the width will be calculated automatically for SplashImage (if there is an image). Otherwise, it will default to 300.

**Xn**: Specify for **n** the x-coordinate of the window's upper left corner. If unspecified, the window will be horizontally centered on the screen.

**Yn**: Specify for **n** the y-coordinate of the window's upper left corner. If unspecified, the window will be vertically centered on the screen.

**Hide**: The window will be initially hidden. Use `Progress Show` or `SplashImage Show` to show it later.

## Layout of Objects in the Window

**Cxy**: Centered: If this option is absent, both _SubText_ and _MainText_ will be centered inside the window. Specify 0 for **x** to make _SubText_ left-justified. Specify a 1 to keep it centered. The same is true for **y** except that it applies to _MainText_ ( **y** can be omitted). For example: `c10`.

**ZHn**: Height of object: For Progress windows, specify for **n** the thickness of the progress bar (default 20). For SplashImage windows, specify for **n** the height to which to scale image. Specify -1 to make the height proportional to the width specified in ZWn (i.e. "keep aspect ratio"). If unspecified, the actual image height will be used. In either case, a value of 0 can be specified to omit the object entirely, which allows the window to be used to display only text in custom fonts, sizes, and colors.

**ZWn**: Width of object (for SplashImage windows only): Specify for **n** the width to which to scale the image. Specify -1 to make the width proportional to the height specified in ZHn (i.e. "keep aspect ratio"). If unspecified, the actual image width will be used.

**ZXn**: Specify for **n** the amount of margin space to leave on the left/right sides of the window. The default is 10 except for SplashImage windows with no text, which have a default of 0.

**ZYn**: Specify for **n** the amount of vertical blank space to leave at the top and bottom of the window and between each control. The default is 5 except for SplashImage windows with no text, which have a default of 0.

Note: To create a vertical progress bar or to have more layout flexibility, use the [Gui](Gui.htm) command such as this example:

```
Gui, Add, Progress, Vertical vMyProgress
Gui, Show
return
<em>; ... later...</em>
GuiControl,, MyProgress, +10  <em>; Move the bar upward by 10 percent. Omit the + to set an absolute position.</em>
```

## Font Size and Weight

**FMn**: Specify for **n** the font size for _MainText_. Default 0, which causes 10 to be used on most systems. This default is not affected by the system's selected font size in Control Panel > Display settings.

**FSn**: Specify for **n** the font size for _SubText_. Default 0, which causes 8 to be used on most systems.

**WMn**: Specify for **n** the font weight of _MainText_. The weight should be between 1 and 1000. If unspecified, 600 (semi-bold) will be used.

**WSn**: Specify for **n** the font weight of _SubText_. The weight should be between 1 and 1000 (700 is traditionally considered to be "bold"). If unspecified, 400 (normal) will be used.

## Object Colors

A color can be one of the names from the list below or a 6-digit hexadecimal RGB value. For example, specifying `cw1A00FF` would set a window background color with red component 1A, green component 00, and blue component FF.

Add a space after each color option if there are any more options that follow it. For example: `cbRed ct900000 cwBlue`.

**CBn**: Color of progress bar: Specify for **n** one of the 16 primary HTML color names or a 6-digit RGB color value. If unspecified, the system's default bar color will be used. Specify the word Default to return to the system's default progress bar color.

**CTn**: Color of text: Specify for **n** one of the 16 primary HTML color names or a 6-digit RGB color value. If unspecified, the system's default text color (usually black) will be used. Specify the word Default to return to the system's default text color.

**CWn**: Color of window (background): Specify for **n** one of the 16 primary HTML color names or a 6-digit RGB color value. If unspecified, the system's color for the face of buttons will be used (specify the word Default to later return to this color). To make the background transparent, use [WinSet TransColor](WinSet.htm#TransColor).

Color nameRGB valueBlack000000SilverC0C0C0Gray808080WhiteFFFFFFMaroon800000RedFF0000Purple800080FuchsiaFF00FFGreen008000Lime00FF00Olive808000YellowFFFF00Navy000080Blue0000FFTeal008080Aqua00FFFF

## Remarks

If the first parameter is the word **OFF**, the window is destroyed.

Each script can display up to 10 Progress windows and 10 SplashImage windows. Each window has a number assigned to it at the time it is created. If unspecified, that number is 1 (the first). Otherwise, precede the first parameter with the number of the window followed by a colon. For example, the Progress command with `2:Off` would turn off the number-2 Progress window, `2:75` would set its bar to 75%, `2:` would change one or more of its text fields, and `2:B` would create a new borderless Progress window. Similarly, the SplashImage command with `2:Off` would turn off the number-2 SplashImage window, `2:` would change one or more of its text fields, and `2:C:\My Images\Picture1.jpg` would create a new number-2 SplashImage window.

Upon creation, a window that would be larger than the desktop is automatically shrunk to fit.

A naked progress bar can be displayed by specifying no _SubText_, no _MainText_, and including the following options: `b zx0 zy0`. A naked image can be displayed the same way except that only the B option is needed.

On Windows XP or later, if there is a non-Classic theme is in effect, the interior of a progress bar may appear as a series of segments rather than a smooth continuous bar. To avoid this, specify a bar color explicitly such as cbBlue.

Use decimal (not hexadecimal) numbers for option letters that need them, except where noted.

Commands such as [WinSet](WinSet.htm) and [WinMove](WinMove.htm) can be used to change the attributes of an existing window without having to recreate it.

A GUI window may take ownership of a Progress or Splash window by means of [Gui +OwnDialogs](Gui.htm#OwnDialogs). This causes the Splash or Progress to stay always on top of its owner. In addition, the Progress or Splash is automatically destroyed when its GUI window is destroyed.

## Related

[GUI](Gui.htm), [SplashTextOn](SplashTextOn.htm), [ToolTip](ToolTip.htm)

## Examples

Creates a borderless Progress window and sets the position of the bar to 50%.

```
Progress, b w200, My SubText, My MainText, My Title
Progress, 50 <em>; Set the position of the bar to 50%.</em>
Sleep, 4000
Progress, Off
```

Creates a window just to display some 18-point Courier text.

```
Progress, m2 b fs18 zh0, This is the Text.`nThis is a 2nd line., , , Courier New
```

Creates a simple SplashImage window.

```
SplashImage, C:\My Pictures\Company Logo.gif
```

Creates a borderless SplashImage window with some large text beneath the image.

```
SplashImage, C:\My Pictures\Company Logo.gif, b fs18, This is our company logo.
Sleep, 4000
SplashImage, Off
```

Demonstrates how a Progress window can be overlayed on a SplashImage to make a professional looking Installer screen. [Gui example #7](Gui.htm#ExProgressBar) is similar to this but its advantage is that it uses only a single window and it gives you more control over window layout.

```
if FileExist("C:\WINDOWS\system32\ntimage.gif")
    SplashImage, %A_WinDir%\system32\ntimage.gif, A,,, Installation
Loop, %A_WinDir%\system32\*.*
{
    Progress, %A_Index%, %A_LoopFileName%, Installing..., Draft Installation
    Sleep, 50
    if (A_Index = 100)
        break
}
```

