# MouseClick

Clicks or holds down a mouse button, or turns the mouse wheel. NOTE: The [Click command](Click.htm) is generally more flexible and easier to use.

```
<span class="func">MouseClick</span> <span class="optional">, WhichButton, X, Y, ClickCount, Speed, DownOrUp, Relative</span>
```

## Parameters

WhichButton

The button to click: Left (default), Right, Middle (or just the first letter of each of these); or the fourth or fifth mouse button (X1 or X2). For example: `MouseClick, X1`. This parameter may be omitted, in which case it defaults to Left.

Rotate the mouse wheel: Specify WheelUp or WU to turn the wheel upward (away from you); specify WheelDown or WD to turn the wheel downward (toward you). [v1.0.48+]: Specify WheelLeft (or WL) or WheelRight (or WR) to push the wheel left or right, respectively (but these have no effect on operating systems older than Windows Vista). _ClickCount_ is the number of notches to turn the wheel.

To compensate automatically for cases where the user has swapped the left and right mouse buttons via the system's control panel, use the [Click command](Click.htm) instead.

X, Y

The x/y coordinates to which the mouse cursor is moved prior to clicking, which can be [expressions](../Variables.htm#Expressions). Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that. If omitted, the cursor's current position is used.

ClickCount

The number of times to click the mouse, which can be an [expression](../Variables.htm#Expressions). If omitted, the button is clicked once.

Speed

The speed to move the mouse in the range 0 (fastest) to 100 (slowest), which can be an [expression](../Variables.htm#Expressions).

**Note**: A speed of 0 will move the mouse instantly.

If omitted, the default speed (as set by [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm) or 2 otherwise) will be used.

_Speed_ is ignored for [SendInput/Play modes](SendMode.htm); they move the mouse instantaneously (though [SetMouseDelay](SetMouseDelay.htm) has a mode that applies to SendPlay). To visually move the mouse more slowly -- such as a script that performs a demonstration for an audience -- use `<a href="Send.htm#Click" data-index="10">SendEvent {Click 100 200}</a>` or `<a href="SendMode.htm" data-index="11">SendMode</a> Event` (optionally in conjuction with [BlockInput](BlockInput.htm)).

DownOrUp

If omitted, each click will consist of a "down" event followed by an "up" event. To change this behavior, specify the one of the following letters:

**D:** Press the mouse button down but do not release it (i.e. generate a down-event).

**U:** Release the mouse button (i.e. generate an up-event).

Relative

If omitted, the X and Y coordinates will be treated as absolute values. To change this behavior, specify the following letter:

**R:** The X and Y coordinates will be treated as offsets from the current mouse position. In other words, the cursor will be moved from its current position by X pixels to the right (left if negative) and Y pixels down (up if negative).

## Remarks

This command uses the sending method set by [SendMode](SendMode.htm).

The [Click command](Click.htm) is recommended over MouseClick because:

1. It automatically compensates when the left and right mouse buttons are swapped via the control panel.
2. It is generally easier to use.

To perform a shift-click or control-click, use the [Send](Send.htm) command before and after the operation as shown in these examples:

```
<em>; Example #1: </em>
Send, {Control down}
MouseClick, left, 55, 233
Send, {Control up}
```

```
<em>; Example #2:</em>
Send, {Shift down}
MouseClick, left, 55, 233
Send, {Shift up}
```

The [SendPlay mode](SendMode.htm) is able to successfully generate mouse events in a broader variety of games than the other modes. In addition, some applications and games may have trouble tracking the mouse if it moves too quickly. The _speed_ parameter or [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm) can be used to reduce the speed (in the default [SendEvent mode](SendMode.htm) only).

Some applications do not obey a _ClickCount_ higher than 1 for the mouse wheel. For them, use a [Loop](Loop.htm) such as the following:

```
Loop, 5
    MouseClick, WheelUp
```

The [BlockInput](BlockInput.htm) command can be used to prevent any physical mouse activity by the user from disrupting the simulated mouse events produced by the mouse commands. However, this is generally not needed for the [SendInput/Play](SendMode.htm) modes because they automatically postpone the user's physical mouse activity until afterward.

There is an automatic delay after every click-down and click-up of the mouse (except for [SendInput mode](SendMode.htm) and for turning the mouse wheel). Use [SetMouseDelay](SetMouseDelay.htm) to change the length of the delay.

## Related

[CoordMode](CoordMode.htm), [SendMode](SendMode.htm), [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm), [SetMouseDelay](SetMouseDelay.htm), [Click](Click.htm), [MouseClickDrag](MouseClickDrag.htm), [MouseGetPos](MouseGetPos.htm),
[MouseMove](MouseMove.htm), [ControlClick](ControlClick.htm), [BlockInput](BlockInput.htm)

## Examples

Double-clicks at the current mouse position.

```
MouseClick, left
MouseClick, left
```

Same as above.

```
MouseClick, left,,, 2
```

Moves the mouse cursor to a specific position, then right-clicks once.

```
MouseClick, right, 200, 300
```

Simulates the turning of the mouse wheel.

```
#up::MouseClick, WheelUp,,, 2  <em>; Turn it by two notches.</em>
#down::MouseClick, WheelDown,,, 2
```

