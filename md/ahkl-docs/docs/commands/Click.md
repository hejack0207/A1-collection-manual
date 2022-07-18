# Click [v1.0.43+]

Clicks a mouse button at the specified coordinates. It can also hold down a mouse button, turn the mouse wheel, or move the mouse.

```
<span class="func">Click</span> <span class="optional">, Options</span>
```

## Parameters

Options

Specify zero or more of the following components: Coords, WhichButton, ClickCount, DownOrUp, and/or Relative. Separate each component from the next with at least one space, tab, and/or comma. The components can appear in any order except ClickCount, which must occur somewhere to the right of Coords, if present.

**Coords:** The X and Y coordinates to which the mouse cursor is moved prior to clicking. For example, `Click, 100 200` clicks the left mouse button at a specific position. Coordinates are relative to the active window unless [CoordMode](CoordMode.htm) was used to change that. If omitted, the cursor's current position is used.

**WhichButton:** Left (default), Right, Middle (or just the first letter of each of these); or the fourth or fifth mouse button (X1 or X2). For example, `Click, Right` clicks the right mouse button at the mouse cursor's current position. Unlike [MouseClick](MouseClick.htm), the left and right buttons behave consistently across all systems, even if the user has swapped the buttons via the system's control panel.

WhichButton can also be WheelUp or WU to turn the wheel upward (away from you), or WheelDown or WD to turn the wheel downward (toward you). [v1.0.48+]: WheelLeft (or WL) or WheelRight (or WR) may also be specified (but they have no effect on older operating systems older than Windows Vista). For ClickCount, specify the number of notches to turn the wheel. However, some applications do not obey a ClickCount value higher than 1 for the mouse wheel. For them, use the Click command multiple times by means such as [Loop](Loop.htm).

**ClickCount:** The number of times to click the mouse. For example, `Click, 2` performs a double-click at the mouse cursor's current position. If omitted, the button is clicked once. If Coords is specified, ClickCount must appear after it. Specify zero (0) to move the mouse without clicking; for example, `Click, 100 200 0`.

**DownOrUp:** This component is normally omitted, in which case each click consists of a down-event followed by an up-event. Otherwise, specify the word Down (or the letter D) to press the mouse button down without releasing it. Later, use the word Up (or the letter U) to release the mouse button. For example, `Click, Down` presses down the left mouse button and holds it.

**Relative:** The word Rel or Relative treats the specified X and Y coordinates as offsets from the current mouse position. In other words, the cursor will be moved from its current position by X pixels to the right (left if negative) and Y pixels down (up if negative).

## Remarks

The Click command is generally preferred over [MouseClick](MouseClick.htm) because it automatically compensates if the user has swapped the left and right mouse buttons via the system's control panel.

The Click command uses the sending method set by [SendMode](SendMode.htm). To override this mode for a particular click, use a specific Send command in combination with [{Click}](Send.htm#Click), as in this example: `SendEvent {Click 100 200}`.

To perform a shift-click or control-click, [clicking via Send](Send.htm#Click) is generally easiest. For example:

```
Send +{Click 100 200}  <em>; Shift+LeftClick</em>
Send ^{Click 100 200 Right}  <em>; Control+RightClick</em>
```

Unlike [Send](Send.htm), the Click command does not automatically release the modifier keys (Ctrl, Alt, Shift, and Win). For example, if Ctrl is currently down, `Click` would produce a control-click but `Send {Click}` would produce a normal click.

The [SendPlay mode](SendMode.htm) is able to successfully generate mouse events in a broader variety of games than the other modes. In addition, some applications and games may have trouble tracking the mouse if it moves too quickly, in which case [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm) can be used to reduce the speed (but only in [SendEvent mode](SendMode.htm)).

The [BlockInput](BlockInput.htm) command can be used to prevent any physical mouse activity by the user from disrupting the simulated mouse events produced by the mouse commands. However, this is generally not needed for the [SendInput](SendMode.htm) and [SendPlay](SendMode.htm) modes because they automatically postpone the user's physical mouse activity until afterward.

There is an automatic delay after every click-down and click-up of the mouse (except for [SendInput mode](SendMode.htm) and for turning the mouse wheel). Use [SetMouseDelay](SetMouseDelay.htm) to change the length of the delay.

## Related

[Send {Click}](Send.htm#Click), [SendMode](SendMode.htm), [CoordMode](CoordMode.htm), [SetDefaultMouseSpeed](SetDefaultMouseSpeed.htm), [SetMouseDelay](SetMouseDelay.htm), [MouseClick](MouseClick.htm), [MouseClickDrag](MouseClickDrag.htm), [MouseMove](MouseMove.htm), [ControlClick](ControlClick.htm), [BlockInput](BlockInput.htm)

## Examples

Clicks the left mouse button at the mouse cursor's current position.

```
Click
```

Clicks the left mouse button at a specific position.

```
Click, 100 200
```

Moves the mouse cursor to a specific position without clicking.

```
Click, 100 200 0
```

Clicks the right mouse button at a specific position.

```
Click, 100 200 Right
```

Performs a double-click at the mouse cursor's current position.

```
Click, 2
```

Presses down the left mouse button and holds it.

```
Click, Down
```

Releases the right mouse button.

```
Click, Up Right
```

