# MouseMove

Moves the mouse cursor.

```
<span class="func">MouseMove</span>, X, Y <span class="optional">, Speed, Relative</span>
```

## Parameters

X, Y

The x/y coordinates to move the mouse to, which can be [expressions](../Variables.htm#Expressions). Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that.

Speed

The speed to move the mouse in the range 0 (fastest) to 100 (slowest), which can be an [expression](../Variables.htm#Expressions).

**Note**: A speed of 0 will move the mouse instantly.

If omitted, the default speed (as set by [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm) or 2 otherwise) will be used.

_Speed_ is ignored for [SendInput/Play modes](SendMode.htm); they move the mouse instantaneously (though [SetMouseDelay](SetMouseDelay.htm) has a mode that applies to SendPlay). To visually move the mouse more slowly -- such as a script that performs a demonstration for an audience -- use `<a href="Send.htm#Click" data-index="7">SendEvent {Click 100 200}</a>` or `<a href="SendMode.htm" data-index="8">SendMode</a> Event` (optionally in conjuction with [BlockInput](BlockInput.htm)).

Relative

If omitted, the X and Y coordinates will be treated as absolute values. To change this behavior, specify the following letter:

**R:** The X and Y coordinates will be treated as offsets from the current mouse position. In other words, the cursor will be moved from its current position by X pixels to the right (left if negative) and Y pixels down (up if negative).

## Remarks

This command uses the sending method set by [SendMode](SendMode.htm).

The [SendPlay mode](SendMode.htm) is able to successfully generate mouse events in a broader variety of games than the other modes. In addition, some applications and games may have trouble tracking the mouse if it moves too quickly. The _speed_ parameter or [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm) can be used to reduce the speed (in the default [SendEvent mode](SendMode.htm) only).

The [BlockInput](BlockInput.htm) command can be used to prevent any physical mouse activity by the user from disrupting the simulated mouse events produced by the mouse commands. However, this is generally not needed for the [SendInput/Play](SendMode.htm) modes because they automatically postpone the user's physical mouse activity until afterward.

There is an automatic delay after every movement of the mouse (except for [SendInput mode](SendMode.htm)). Use [SetMouseDelay](SetMouseDelay.htm) to change the length of the delay.

The following is an alternate way to move the mouse cursor that may work better in certain multi-monitor configurations:

```
<a href="DllCall.htm" data-index="18">DllCall</a>("SetCursorPos", "int", 100, "int", 400)  <em>; The first number is the X-coordinate and the second is the Y (relative to the screen).</em>
```

On a related note, the mouse cursor can be temporarily hidden via the [hide-cursor example](DllCall.htm#HideCursor).

## Related

[CoordMode](CoordMode.htm), [SendMode](SendMode.htm), [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm), [SetMouseDelay](SetMouseDelay.htm), [Click](Click.htm), [MouseClick](MouseClick.htm), [MouseClickDrag](MouseClickDrag.htm), [MouseGetPos](MouseGetPos.htm), [BlockInput](BlockInput.htm)

## Examples

Moves the mouse cursor to a new position.

```
MouseMove, 200, 100
```

Moves the mouse cursor slowly (speed 50 vs. 2) by 20 pixels to the right and 30 pixels down from its current location.

```
MouseMove, 20, 30, 50, R
```

