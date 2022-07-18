# WinMove

Changes the position and/or size of the specified window.

```
<span class="func">WinMove</span>, X, Y
<span class="func">WinMove</span>, WinTitle, WinText, X, Y <span class="optional">, Width, Height, ExcludeTitle, ExcludeText</span>

```

## Parameters

X, Y

The X and Y coordinates (in pixels) of the upper left corner of the target window's new location, which can be [expressions](../Variables.htm#Expressions). The upper-left pixel of the screen is at 0, 0.

If these are the only parameters given with the command, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be used as the target window.

Otherwise, X and/or Y can be omitted, in which case the current position is used.

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm). See also the [known limitation](#limitation) below.

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON. See also the [known limitation](#limitation) below.

Width, Height

The new width and height of the window (in pixels), which can be [expressions](../Variables.htm#Expressions). If either is omitted, blank, or the word DEFAULT, the size in that dimension will not be changed.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

If _Width_ and _Height_ are small (or negative), most windows with a title bar will generally go no smaller than 112 x 27 pixels (however, some types of windows may have a different minimum size). If _Width_ and _Height_ are large, most windows will go no larger than approximately 12 pixels beyond the dimensions of the desktop.

Negative values are allowed for the x and y coordinates to support multi-monitor systems and to allow a window to be moved entirely off screen.

Although WinMove cannot move minimized windows, it can move hidden windows if [DetectHiddenWindows](DetectHiddenWindows.htm) is on.

The speed of WinMove is affected by [SetWinDelay](SetWinDelay.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

**Known limitation**: If _WinTitle_ or _WinText_ contains `(`, `[` or `{`, but not the closing counterpart, such as `WinMove, KEDIT - [`, the parameter is automatically interpreted as an [expression](../Variables.htm#Expressions), resulting in an error message. To avoid this, you can use a [leading percent sign](../Variables.htm#percent-space) to force a literal string instead, such as `WinMove, % "KEDIT - ["`.

## Related

[ControlMove](ControlMove.htm), [WinGetPos](WinGetPos.htm), [WinHide](WinHide.htm), [WinMinimize](WinMinimize.htm), [WinMaximize](WinMaximize.htm), [WinSet](WinSet.htm)

## Examples

Opens the calculator, waits until it exists and moves it to the upper-left corner of the screen.

```
Run, calc.exe
WinWait, Calculator
WinMove, 0, 0 <em>; Use the window found by WinWait.</em>
```

Creates a fixed-size popup window that shows the contents of the clipboard and moves it to the upper-left corner of the screen.

```
SplashTextOn, 400, 300, Clipboard, The clipboard contains:`n%Clipboard%
WinMove, Clipboard,, 0, 0
MsgBox, Press OK to dismiss the SplashText
SplashTextOff
```

Centers a window on the screen.

```
CenterWindow("ahk_class Notepad")

CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}
```

