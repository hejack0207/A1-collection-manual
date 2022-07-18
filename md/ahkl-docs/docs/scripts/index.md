# AutoHotkey Script Showcase

This showcase lists some scripts created by different authors which show what AutoHotkey might be capable of. For more ready-to-run scripts and functions, see [Scripts and Functions Forum](https://www.autohotkey.com/boards/viewforum.php?f=6).

## Table of Contents

- [Screen Magnifier](#Screen_Magnifier)
- [LiveWindows](#LiveWindows)
- [Mouse Gestures](#MouseGestures)
- [Context Sensitive Help in Any Editor](#ContextSensitiveHelp)
- [Easy Window Dragging](#EasyWindowDrag)
- [Easy Window Dragging (KDE style)](#EasyWindowDrag_(KDE))
- [Easy Access to Favorite Folders](#FavoriteFolders)
- [IntelliSense](#IntelliSense)
- [Using a Joystick as a Mouse](#JoystickMouse)
- [Joystick Test Script](#JoystickTest)
- [On-Screen ANSI Keyboard (OSAK)](#KeyboardOnScreen)
- [Minimize Window to Tray Menu](#MinimizeToTrayMenu)
- [Changing MsgBox's Button Names](#MsgBoxButtonNames)
- [Numpad 000 Key](#Numpad000)
- [Using Keyboard Numpad as a Mouse](#NumpadMouse)
- [Seek (Search the Start Menu)](#Seek_(SearchTheStartMenu))
- [ToolTip Mouse Menu](#TooltipMouseMenu)
- [Volume On-Screen-Display (OSD)](#VolumeOSD)
- [Window Shading](#WindowShading)
- [WinLIRC Client](#WinLIRC)
- [HTML Entities Encoding](#HTML_Entities_Encoding)
- [1 Hour Software](#1_Hour_Software)
- [Toralf's Scripts](#Toralf_s_Scripts)
- [Sean's Scripts](#Sean_s_Scripts)
- [Archived Scripts and Functions Forum](#Scripts_and_Functions_Forum)

## Screen Magnifier

Author: Holomind

This screen magnifier has the several advantages over the one included with the operating system, including: Customizable refresh interval and zoom level (including shrink/de-magnify); antialiasing to provide nicer output; and it is open-source (as a result, there are several variations to choose from, or you can tweak the script yourself).

[Archived forum thread](https://www.autohotkey.com/forum/topic11700.html)

## LiveWindows

Author: Holomind

LiveWindows allows you to monitor the progress of downloads, file-copying, and other dialogs by displaying a small replica of each dialog and its progress bar (dialogs are automatically detected, even if they're behind other windows). The preview window stays always-on-top but uses very little screen space (it can also be resized by dragging its edges). You can also monitor any window by dragging a selection rectangle around the area of interest (with control-shift-drag), then press Win+W to display that section in the preview window with real-time updates.

[Archived forum thread](https://www.autohotkey.com/forum/topic11588.html)

## Mouse Gestures

Author: deguix

This script watches how you move the mouse whenever the right mouse button is being held down. If it sees you "draw" a recognized shape or symbol, it will launch a program or perform another custom action of your choice (just like hotkeys). See the included README file for how to define gestures.

[Download (17 KB ZIP file)](MouseGestures.zip)

## Context Sensitive Help in Any Editor

Author: Rajat

This script makes Ctrl+2 (or another hotkey of your choice) show the help file page for the selected AutoHotkey command or keyword. If nothing is selected, the command name will be extracted from the beginning of the current line.

[Show code](ContextSensitiveHelp.ahk)

## Easy Window Dragging

Requirement: Windows XP/2k/NT or later

Normally, a window can only be dragged by clicking on its title bar. This script extends that so that any point inside a window can be dragged. To activate this mode, hold down CapsLock or the middle mouse button while clicking, then drag the window to a new position.

[Show code](EasyWindowDrag.ahk)

## Easy Window Dragging (KDE style)

Author: Jonny

Requirement: Windows XP/2k/NT or later

This script makes it much easier to move or resize a window: 1) Hold down Alt and LEFT-click anywhere inside a window to drag it to a new location; 2) Hold down Alt and RIGHT-click-drag anywhere inside a window to easily resize it; 3) Press Alt twice, but before releasing it the second time, left-click to minimize the window under the mouse cursor, right-click to maximize it, or middle-click to close it.

[Show code](EasyWindowDrag_(KDE).ahk)

## Easy Access to Favorite Folders

Author: Savage

When you click the middle mouse button while certain types of windows are active, this script displays a menu of your favorite folders. Upon selecting a favorite, the script will instantly switch to that folder within the active window. The following window types are supported: 1) Standard file-open or file-save dialogs; 2) Explorer windows; 3) Console (command prompt) windows. The menu can also be optionally shown for unsupported window types, in which case the chosen favorite will be opened as a new Explorer window.

[Show code](FavoriteFolders.ahk)

## IntelliSense

Author: Rajat

Requirement: Windows XP/2k/NT or later

This script watches while you edit an AutoHotkey script. When it sees you type a command followed by a comma or space, it displays that command's parameter list to guide you. In addition, you can press Ctrl+F1 (or another hotkey of your choice) to display that command's page in the help file. To dismiss the parameter list, press Esc or Enter.

[Show code](IntelliSense.ahk)

## Using a Joystick as a Mouse

This script converts a joystick into a three-button mouse. It allows each button to drag just like a mouse button and it uses virtually no CPU time. Also, it will move the cursor faster depending on how far you push the joystick from center. You can personalize various settings at the top of the script.

[Show code](JoystickMouse.ahk)

## Joystick Test Script

This script helps determine the button numbers and other attributes of your joystick. It might also reveal if your joystick is in need of calibration; that is, whether the range of motion of each of its axes is from 0 to 100 percent as it should be. If calibration is needed, use the operating system's control panel or the software that came with your joystick.

[Show code](JoystickTest.ahk)

## On-Screen ANSI Keyboard (OSAK)

Authors: Jon, Lehnemann, anonymous1184, KeronCyst

Requirement: AutoHotkey v1.1 or later

This script creates a mock keyboard at the bottom of your screen that shows the keys you are pressing in real time. I made it to help me to learn to touch-type (to get used to not looking at the keyboard). The size of the on-screen keyboard can be customized at the top of the script. Also, you can double-click the tray icon to show or hide the keyboard.

[Show code](KeyboardOnScreen.ahk)

## Minimize Window to Tray Menu

This script assigns a hotkey of your choice to hide any window so that it becomes an entry at the bottom of the script's tray menu. Hidden windows can then be unhidden individually or all at once by selecting the corresponding item on the menu. If the script exits for any reason, all the windows that it hid will be unhidden automatically.

[Show code](MinimizeToTrayMenu.ahk)

## Changing MsgBox's Button Names

This is a working example script that uses a timer to change the names of the buttons in a message box. Although the button names are changed, the IfMsgBox command still requires that the buttons be referred to by their original names.

[Show code](MsgBoxButtonNames.ahk)

## Numpad 000 Key

This example script makes the special 000 that appears on certain keypads into an equals key. You can change the action by replacing the `Send, =` line with line(s) of your choice.

[Show code](Numpad000.ahk)

## Using Keyboard Numpad as a Mouse

Author: deguix

This script makes mousing with your keyboard almost as easy as using a real mouse (maybe even easier for some tasks). It supports up to five mouse buttons and the turning of the mouse wheel. It also features customizable movement speed, acceleration, and "axis inversion".

[Show code](NumpadMouse.ahk)

## Seek (Search the Start Menu)

Author: Phi

Navigating the Start Menu can be a hassle, especially if you have installed many programs over time. 'Seek' lets you specify a case-insensitive key word/phrase that it will use to filter only the matching programs and directories from the Start Menu, so that you can easily open your target program from a handful of matched entries. This eliminates the drudgery of searching and traversing the Start Menu.

[Show code](Seek_(SearchTheStartMenu).ahk)

## ToolTip Mouse Menu

Author: Rajat

Requirement: Windows XP/2k/NT or later

This script displays a popup menu in response to briefly holding down the middle mouse button. Select a menu item by left-clicking it. Cancel the menu by left-clicking outside of it. A recent improvement is that the contents of the menu can change depending on which type of window is active (Notepad and Word are used as examples here).

[Show code](TooltipMouseMenu.ahk)

## Volume On-Screen-Display (OSD)

Author: Rajat

This script assigns hotkeys of your choice to raise and lower the master and/or wave volume. Both volumes are displayed as different color bar graphs.

[Show code](VolumeOSD.ahk)

## Window Shading

Author: Rajat

This script reduces a window to its title bar and then back to its original size by pressing a single hotkey. Any number of windows can be reduced in this fashion (the script remembers each). If the script exits for any reason, all "rolled up" windows will be automatically restored to their original heights.

[Show code](WindowShading.ahk)

## WinLIRC Client

This script receives notifications from [WinLIRC](http://winlirc.sourceforge.net) whenever you press a button on your remote control. It can be used to automate Winamp, Windows Media Player, etc. It's easy to configure. For example, if WinLIRC recognizes a button named "VolUp" on your remote control, create a label named VolUp and beneath it use the command `SoundSet +5` to increase the soundcard's volume by 5%.

[Show code](WinLIRC.ahk)

## HTML Entities Encoding

Similar to [Transform HTML](../commands/Transform.htm#HTML), this function converts a string into its HTML equivalent by translating characters whose ASCII values are above 127 to their HTML names (e.g. `£` becomes `&pound;`). In addition, the four characters `"&<>` are translated to `&quot;&amp;&lt;&gt;`. Finally, each linefeed ( `` `n``) is translated to ``<br>`n`` (i.e. `<br>` followed by a linefeed).

[Show code](EncodeHTML.ahk)

## 1 Hour Software

Author: skrommel

This is a large collection of useful scripts, professionally presented with short descriptions and screenshots.

[Downloads and more](https://www.dcmembers.com/skrommel/)

## Toralf's Scripts

This collection includes useful scripts such as:

- AHK Window Info: Reveals information on windows, controls, etc.
- Electronic Program Guide: Browses the TV programs/schedules of your region (supports several countries).
- Auto-Syntax-Tidy: Changes indentation and case of commands in a script to give it a consistent format/style.

[Archived forum thread](https://www.autohotkey.com/forum/topic12338.html)

## Sean's Scripts

Network Download/Upload Meter: Displays the network download/upload KB in a small, always-on-top progress bar. See [archived forum thread](https://www.autohotkey.com/forum/topic18033.html).

StdoutToVar: Redirects the output of a command or application into one of the script's variables. See [archived forum thread](https://www.autohotkey.com/forum/topic16823.html).

Capture a Screen Rectangle: A callable function that captures a portion of the screen and saves it as a file (BMP/JPG/PNG/GIF/TIF). It can also capture transparent windows and the mouse cursor. See [archived forum thread](https://www.autohotkey.com/forum/topic18146.html).

Color Zoomer/Picker: Magnifies the area near the cursor, allowing a single pixel to be selected and its color identified. See [archived forum thread](https://www.autohotkey.com/forum/topic18167.html).

## Archived Scripts and Functions Forum

An archive of an older forum containing many more scripts, but some scripts might not run as-is on AutoHotkey v1.1.

[Archived Scripts and Functions Forum](https://www.autohotkey.com/board/forum/49-)

Hide code

Loading code...

