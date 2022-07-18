# CoordMode

Sets coordinate mode for various commands to be relative to either the active window or the screen.

```
<span class="func">CoordMode</span>, TargetType <span class="optional">, RelativeTo</span>
```

## Parameters

TargetType

The type of target to affect. Specify one of the following words:

**ToolTip**: Affects [ToolTip](ToolTip.htm).

**Pixel**: Affects [PixelGetColor](PixelGetColor.htm), [PixelSearch](PixelSearch.htm), and [ImageSearch](ImageSearch.htm).

**Mouse**: Affects [MouseGetPos](MouseGetPos.htm), [Click](Click.htm), and [MouseMove](MouseMove.htm)/ [Click](MouseClick.htm)/ [Drag](MouseClickDrag.htm).

**Caret**: Affects the built-in variables [A\_CaretX](../Variables.htm#Caret) and [A\_CaretY](../Variables.htm#Caret).

**Menu**: Affects the [Menu Show](Menu.htm#Show) command when coordinates are specified for it.

RelativeTo

The area to which _TargetType_ is to be related. Specify one of the following words (if omitted, it defaults to Screen):

**Screen**: Coordinates are relative to the desktop (entire screen).

**Relative**: Coordinates are relative to the active window.

**Window**[v1.1.05+]: Synonymous with _Relative_ and recommended for clarity.

**Client**[v1.1.05+]: Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.

## Remarks

If this command is not used, all commands except those documented otherwise (e.g. [WinMove](WinMove.htm) and [InputBox](InputBox.htm)) use coordinates that are relative to the active window.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

[v1.1.23+]: The built-in [A\_CoordMode variables](../Variables.htm#CoordMode) contain the current settings.

## Related

[Click](Click.htm), [MouseMove](MouseMove.htm), [MouseClick](MouseClick.htm), [MouseClickDrag](MouseClickDrag.htm), [MouseGetPos](MouseGetPos.htm), [PixelGetColor](PixelGetColor.htm), [PixelSearch](PixelSearch.htm), [ToolTip](ToolTip.htm), [Menu](Menu.htm)

## Examples

Places tooltips at absolute screen coordinates.

```
CoordMode, ToolTip, Screen
```

Same effect as the above because "Screen" is the default.

```
CoordMode, ToolTip
```

