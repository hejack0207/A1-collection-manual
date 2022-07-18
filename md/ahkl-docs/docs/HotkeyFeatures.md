# Advanced Hotkey Features

## Table of Contents

- [General](#general)
  - [Remap easy to reach but rarely used keys](#easy-to-reach)
  - [Use any keys as modifiers](#keys-as-modifiers)
  - [Make the mouse wheel perform alt-tabbing](#AltTab)
  - [Make a keyboard key become a mouse button](#keyboard-to-mouse)
  - [Make your hotkeys context-sensitive](#context-sensitive)
  - [Define abbreviations that expand as you type them](#hotstrings)
- [Gaming](#gaming)
  - [Reduce wear and tear on your fingers](#wear-and-tear)
  - [Create mouse hotkeys](#mouse-hotkeys)
  - [Create "pass-through" hotkeys](#pass-through)
  - [Automate game actions on the screen](#game-actions)
  - [Use the keyboard hook](#keyboard-hook)
- [Related Topics](#related)

## General

### Remap easy to reach but rarely used keys

Some of the easiest keys to reach on the keyboard are also the least frequently used. Make these keys do something useful! For example, if you rarely use the right Alt, make it perform the action you do most often:

```
RAlt::
MsgBox You pressed the right ALT key.
return
```

You can even do the above without losing the native function of the right Alt by assigning the right Alt to be a "prefix" for at least one other hotkey. In the below example, the right Alt has become a prefix, which automatically allows it to modify **all** other keys as it normally would. But if you press and release the right Alt without having used it to modify another key, its hotkey action (above) will take effect immediately:

```
RAlt & j::AltTab
```

### Use any keys as modifiers

Don't be limited to using only Ctrl, Alt, Shift, and Win as modifiers; you can combine **any** two keys or mouse buttons to form a custom hotkey. For example: Hold down Numpad0 and press Numpad1 to launch a hotkey ( `Numpad0 & Numpad1::`); hold down CapsLock and press another key, or click a mouse button ( `CapsLock & RButton::`). In this case, CapsLock's state (on or off) is not changed when it is used to launch the hotkey. For details, see [custom combinations of keys](Hotkeys.htm#combo).

### Make the mouse wheel perform alt-tabbing

Convert the mouse wheel (or any other keys of your choice) into a complete substitute for Alt-Tab. Click the wheel to show or hide the menu, and turn it to navigate through the menu. The wheel will still function normally whenever the Alt-Tab menu isn't visible. Syntax:

```
MButton::AltTabMenu
WheelDown::AltTab
WheelUp::ShiftAltTab
```

### Make a keyboard key become a mouse button

Make a keyboard key **become** a mouse button, or have an action repeated continuously while you're holding down a key or mouse button. See the [remapping page](misc/Remap.htm#RemapMouse) for examples.

### Make your hotkeys context-sensitive

Have your easiest-to-reach hotkeys perform an action appropriate to the type of window you're working with. In the following example, the right Ctrl performs a different action depending on whether Notepad or Calculator is the active window:

```
#IfWinActive ahk_class Notepad
RControl::WinMenuSelectItem, , , File, Save  <em>; Save the current file in Notepad.</em>

#IfWinActive Calculator
RControl::Send, ^c!{tab}^v  <em>; Copy the Calculator's result into the previously active window.</em>
```

See [#IfWinActive](commands/_IfWinActive.htm) for details.

### Define abbreviations that expand as you type them

Also known as [hotstrings](Hotstrings.htm). No special training or scripting experience is needed. For example, a script containing the following lines would expand ceo, cfo, and btw wherever you type them:

```
::ceo::Chief Executive Officer
::cfo::Chief Financial Officer
::btw::by the way
```

## Gaming

### Reduce wear and tear on your fingers

Reduce wear and tear on your fingers by using virtually [any key](KeyList.htm) as a hotkey, including single letters, arrow keys, Numpad keys, and even the modifier keys themselves (Ctrl, Alt, Win, and Shift).

### Create mouse hotkeys

Create mouse hotkeys, including the mouse wheel button (MButton) and the turning of the wheel up/down or left/right (WheelUp, WheelDown, WheelLeft, and WheelRight). You can also combine a keyboard key with a mouse button. For example, control-right-button would be expressed as `^RButton::`.

### Create "pass-through" hotkeys

For example, the left mouse button can trigger a hotkey action even while the click itself is being sent into the game normally (syntax: `~LButton::`).

### Automate game actions on the screen

Use commands such as [PixelSearch](commands/PixelSearch.htm), [PixelGetColor](commands/PixelGetColor.htm), and [ImageSearch](commands/ImageSearch.htm) to automate game actions.

### Use the keyboard hook

Have the option of using the [keyboard hook](commands/_UseHook.htm) to implement hotkeys, which might be more responsive than other hotkey methods while the CPU is under load in a game. The hook might also be able to override any restrictions a game may have about which keys can be "mapped" to game actions.

## Related Topics

- [Hotkeys](Hotkeys.htm)
- [Hotstrings](Hotstrings.htm)
- [Remapping Keys](misc/Remap.htm)

