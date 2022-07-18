# SendMode [v1.0.43+]

Makes [Send](Send.htm) synonymous with SendInput or SendPlay rather than the default (SendEvent). Also makes Click and MouseMove/Click/Drag use the specified method.

```
<span class="func">SendMode</span> Mode
```

## Parameters

Mode

Specify one of the following words:

**Event**: This is the starting default used by all scripts. It uses the [SendEvent](Send.htm#SendEvent) method for [Send](Send.htm), [SendRaw](Send.htm), [Click](Click.htm), and [MouseMove](MouseMove.htm)/ [Click](MouseClick.htm)/ [Drag](MouseClickDrag.htm).

**Input**: Switches to the [SendInput](Send.htm#SendInput) method for [Send](Send.htm), [SendRaw](Send.htm), [Click](Click.htm), and [MouseMove](MouseMove.htm)/ [Click](MouseClick.htm)/ [Drag](MouseClickDrag.htm). Known limitations:

- Windows Explorer ignores SendInput's simulation of certain navigational hotkeys such asAlt+←. To work around this, use either `SendEvent !{Left}` or `SendInput {Backspace}`.

**InputThenPlay**[v1.0.43.02+]: Same as above except that rather than falling back to Event mode when SendInput is [unavailable](Send.htm#SendInputUnavail), it reverts to Play mode (below). This also causes the [SendInput command](Send.htm#SendInput) itself to revert to Play mode when SendInput is unavailable.

**Play**: Switches to the [SendPlay](Send.htm#SendPlay) method for [Send](Send.htm), [SendRaw](Send.htm), [Click](Click.htm), and [MouseMove](MouseMove.htm)/ [Click](MouseClick.htm)/ [Drag](MouseClickDrag.htm). Known limitations:

- Characters that do not exist in the current keyboard layout (such as Ô in English) cannot be sent. To work around this, use[SendEvent](Send.htm#SendEvent).
- Simulated mouse dragging might have no effect in RichEdit controls (and possibly others) such as those of WordPad and Metapad. To use an alternate mode for a particular drag, follow this example:`<a href="Send.htm#SendEvent" data-index="26">SendEvent</a> {Click 6 52 Down}{Click 45 52 Up}`.
- Simulated mouse wheel rotation produces movement in only one direction (usually downward, but upward in some applications). Also, wheel rotation might have no effect in applications such as MS Word and Notepad. To use an alternate mode for a particular rotation, follow this example:`<a href="Send.htm#SendEvent" data-index="27">SendEvent</a> {WheelDown 5}`.
- When using`SendMode Play` in the auto-execute section (top part of the script), all remapped keys are affected and might lose some of their functionality. See [SendPlay remapping limitations](../misc/Remap.htm#SendPlay) for details.
- SendPlay does not trigger AutoHotkey's hotkeys or hotstrings, or global hotkeys registered by other programs or the OS.

## Remarks

Since SendMode also changes the mode of [Click](Click.htm) and [MouseMove](MouseMove.htm)/ [Click](MouseClick.htm)/ [Drag](MouseClickDrag.htm), there may be times when you wish to use a different mode for a particular mouse event. The easiest way to do this is via [{Click}](Send.htm#Click). For example:

```
SendEvent {Click 100 200}  <em>; SendEvent uses the older, traditional method of clicking.</em>
```

If SendMode is used in the auto-execute section (top part of the script), it also affects [keyboard and mouse remapping](../misc/Remap.htm). In particular, if you use `SendMode Play` with remapping, see [SendPlay remapping limitations](../misc/Remap.htm#SendPlay).

[v1.1.23+]: The built-in variable **A\_SendMode** contains the current setting.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[Send](Send.htm), [SetKeyDelay](SetKeyDelay.htm), [SetMouseDelay](SetMouseDelay.htm), [Click](Click.htm), [MouseClick](MouseClick.htm), [MouseClickDrag](MouseClickDrag.htm), [MouseMove](MouseMove.htm)

## Examples

Makes Send synonymous with SendInput. Recommended for new scripts due to its superior speed and reliability.

```
SendMode Input
```

Makes Send synonymous with SendInput, but falls back to SendPlay if SendInput is not available.

```
SendMode InputThenPlay
```

