# ToolTip

Creates an always-on-top window anywhere on the screen.

```
<span class="func">ToolTip</span> <span class="optional">, Text, X, Y, WhichToolTip</span>
```

## Parameters

Text

If blank or omitted, the existing tooltip (if any) will be hidden. Otherwise, this parameter is the text to display in the tooltip. To create a multi-line tooltip, use the linefeed character (\`n) in between each line, e.g. Line1\`nLine2.

If _Text_ is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

X, Y

The X and Y position of the tooltip relative to the active window (use `<a href="CoordMode.htm" data-index="2">CoordMode</a>, ToolTip` to change to screen coordinates). If the coordinates are omitted, the tooltip will be shown near the mouse cursor. X and Y can be [expressions](../Variables.htm#Expressions).

WhichToolTip

Omit this parameter if you don't need multiple tooltips to appear simultaneously. Otherwise, this is a number between 1 and 20 to indicate which tooltip window to operate upon. If unspecified, that number is 1 (the first). This parameter can be an [expression](../Variables.htm#Expressions).

## Remarks

A tooltip usually looks like this: ![ToolTip](../static/dlg_tooltip.png)

If the X & Y coordinates would cause the tooltip to run off screen, it is repositioned to be entirely visible.

The tooltip is displayed until one of the following occurs:

- The script terminates.
- The ToolTip command is executed again with a blank_Text_ parameter.
- The user clicks on the tooltip (this behavior may vary depending on operating system version).

A GUI window may be made the owner of a tooltip by means of [Gui +OwnDialogs](Gui.htm#OwnDialogs). Such a tooltip is automatically destroyed when its owner is destroyed.

## Related

[CoordMode](CoordMode.htm), [TrayTip](TrayTip.htm), [GUI](Gui.htm), [Progress](Progress.htm), [SplashTextOn](SplashTextOn.htm), [MsgBox](MsgBox.htm), [InputBox](InputBox.htm), [FileSelectFile](FileSelectFile.htm), [FileSelectFolder](FileSelectFolder.htm)

## Examples

Shows a multiline tooltip at a specific position in the active window.

```
ToolTip, Multiline`nTooltip, 100, 150
```

Hides a tooltip after a certain amount of time without having to use Sleep (which would stop the current thread).

```
#Persistent
ToolTip, Timed ToolTip`nThis will be displayed for 5 seconds.
SetTimer, RemoveToolTip, -5000
return

RemoveToolTip:
ToolTip
return
```

