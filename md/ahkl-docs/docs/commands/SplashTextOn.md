# SplashTextOn / SplashTextOff

Creates or removes a customizable text popup window.

**Deprecated:** These commands are not recommended for use in new scripts. Use the [Gui](Gui.htm) command instead.

```
<span class="func">SplashTextOn</span> <span class="optional">, Width, Height, Title, Text</span>
<span class="func">SplashTextOff</span>

```

## Parameters

Width

The width in pixels of the Window. Default 200. This parameter can be an [expression](../Variables.htm#Expressions).

Height

The height in pixels of the window (not including its title bar). Default 0 (i.e. just the title bar will be shown). This parameter can be an [expression](../Variables.htm#Expressions).

Title

The title of the window. Default empty (blank).

Text

The text of the window. Default empty (blank). If _Text_ is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

## Remarks

To have more control over layout and font name/color/size, use the [Progress](Progress.htm) command with the `zh0` option, which omits the bar and displays only text. For example: `Progress, zh0 fs18, Some 18-point text to display`.

Use the SplashTextOff command to remove an existing splash window.

The splash window is "always on top", meaning that it stays above all other normal windows. To change this, use `<a href="WinSet.htm" data-index="6">WinSet</a>, AlwaysOnTop, Off, <insert title of splash window>`. [WinSet](WinSet.htm) can also make the splash window transparent.

[WinMove](WinMove.htm) can be used to reposition and resize the SplashText window after it has been displayed with this command.

Unlike [Progress](Progress.htm), [SplashImage](Progress.htm), [MsgBox](MsgBox.htm), [InputBox](InputBox.htm), [FileSelectFile](FileSelectFile.htm), and [FileSelectFolder](FileSelectFolder.htm), only one SplashText window per script is possible.

If SplashTextOn is used while the splash window is already displayed, the window will be recreated with the new parameter values. However, rather than recreating the splash window every time you wish to change its title or text, better performance can be achieved by using the following, especially if the window needs to be changed frequently:

```
<a href="WinSetTitle.htm" data-index="15">WinSetTitle</a>, <insert title of splash window>, , NewTitle
<a href="ControlSetText.htm" data-index="16">ControlSetText</a>, Static1, NewText, <insert title of splash window>
```

## Related

[Progress](Progress.htm), [SplashImage](Progress.htm), [ToolTip](ToolTip.htm), [MsgBox](MsgBox.htm), [InputBox](InputBox.htm), [FileSelectFile](FileSelectFile.htm), [FileSelectFolder](FileSelectFolder.htm), [WinMove](WinMove.htm), [WinSet](WinSet.htm)

## Examples

Creates a fixed-size popup window that shows the contents of the clipboard and moves it to the upper-left corner of the screen.

```
SplashTextOn, 400, 300, Clipboard, The clipboard contains:`n%Clipboard%
WinMove, Clipboard,, 0, 0
MsgBox, Press OK to dismiss the SplashText
SplashTextOff
```

Creates a popup window that displays only a title bar.

```
SplashTextOn,,, Displays only a title bar.
Sleep, 2000
```

