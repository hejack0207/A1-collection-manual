# MouseClickDrag

Clicks and holds the specified mouse button, moves the mouse to the destination coordinates, then releases the button.

```
<span class="func">MouseClickDrag</span>, WhichButton, X1, Y1, X2, Y2 <span class="optional">, Speed, Relative</span>
```

## Parameters

WhichButton

The button to click: Left, Right, Middle (or just the first letter of each of these). Specify X1 for the fourth button and X2 for the fifth. For example: `MouseClickDrag, X1, ...`.

To compensate automatically for cases where the user has swapped the left and right mouse buttons via the system's control panel, use the [Click command](Click.htm) instead.

X1, Y1

The x/y coordinates of the drag's starting position, which can be [expressions](../Variables.htm#Expressions) (the mouse will be moved to these coordinates right before the drag is started). Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that. If omitted, the mouse's current position is used.

X2, Y2

The x/y coordinates to drag the mouse to (that is, while the button is held down), which can be [expressions](../Variables.htm#Expressions). Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that.

Speed

The speed to move the mouse in the range 0 (fastest) to 100 (slowest), which can be an [expression](../Variables.htm#Expressions).

**Note**: A speed of 0 will move the mouse instantly.

If omitted, the default speed (as set by [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm) or 2 otherwise) will be used.

_Speed_ is ignored for [SendInput/Play modes](SendMode.htm); they move the mouse instantaneously (though [SetMouseDelay](SetMouseDelay.htm) has a mode that applies to SendPlay). To visually move the mouse more slowly -- such as a script that performs a demonstration for an audience -- use `<a href="Send.htm#Click" data-index="10">SendEvent {Click 100 200}</a>` or `<a href="SendMode.htm" data-index="11">SendMode</a> Event` (optionally in conjuction with [BlockInput](BlockInput.htm)).

Relative

If omitted, the X and Y coordinates will be treated as absolute values. To change this behavior, specify the following letter:

**R:** The X1 and Y1 coordinates will be treated as offsets from the current mouse position. In other words, the cursor will be moved from its current position by X1 pixels to the right (left if negative) and Y1 pixels down (up if negative). Similarly, the X2 and Y2 coordinates will be treated as offsets from the X1 and Y1 coordinates. For example, the following would first move the cursor down and to the right by 5 pixels from its starting position, and then drag it from that position down and to the right by 10 pixels: `MouseClickDrag, Left, 5, 5, 10, 10, , R`.

## Remarks

This command uses the sending method set by [SendMode](SendMode.htm).

Dragging can also be done via the various Send commands, which is more flexible because the mode can be specified via the command name. For example:

```
SendEvent {Click 6 52 Down}{Click 45 52 Up}
```

Another advantage of the method above is that unlike MouseClickDrag, it automatically compensates when the user has swapped the left and right mouse buttons via the system's control panel.

The [SendPlay mode](SendMode.htm) is able to successfully generate mouse events in a broader variety of games than the other modes. However, dragging via SendPlay might not work in RichEdit controls (and possibly others) such as those of WordPad and Metapad.

Some applications and games may have trouble tracking the mouse if it moves too quickly. The _speed_ parameter or [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm) can be used to reduce the speed (in the default [SendEvent mode](SendMode.htm) only).

The [BlockInput](BlockInput.htm) command can be used to prevent any physical mouse activity by the user from disrupting the simulated mouse events produced by the mouse commands. However, this is generally not needed for the [SendInput/Play](SendMode.htm) modes because they automatically postpone the user's physical mouse activity until afterward.

There is an automatic delay after every click-down and click-up of the mouse (except for [SendInput mode](SendMode.htm)). This delay also occurs after the movement of the mouse during the drag operation. Use [SetMouseDelay](SetMouseDelay.htm) to change the length of the delay.

## Related

[CoordMode](CoordMode.htm), [SendMode](SendMode.htm), [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm), [SetMouseDelay](SetMouseDelay.htm), [Click](Click.htm), [MouseClick](MouseClick.htm), [MouseGetPos](MouseGetPos.htm),
[MouseMove](MouseMove.htm), [BlockInput](BlockInput.htm)

## Examples

Clicks and holds the left mouse button, moves the mouse cursor to the destination coordinates, then releases the button.

```
MouseClickDrag, left, 0, 200, 600, 400
```

Opens MS Paint and draws a little house.

```
Run, mspaint.exe
WinWaitActive, ahk_class MSPaintApp,, 2
if ErrorLevel
    return
MouseClickDrag, L, 150, 250, 150, 150
MouseClickDrag, L, 150, 150, 200, 100
MouseClickDrag, L, 200, 100, 250, 150
MouseClickDrag, L, 250, 150, 150, 150
MouseClickDrag, L, 150, 150, 250, 250
MouseClickDrag, L, 250, 250, 250, 150
MouseClickDrag, L, 250, 150, 150, 250
MouseClickDrag, L, 150, 250, 250, 250
```

