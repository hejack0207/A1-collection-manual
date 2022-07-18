# KeyWait

Waits for a key or mouse/joystick button to be released or pressed down.

```
<span class="func">KeyWait</span>, KeyName <span class="optional">, Options</span>
```

## Parameters

KeyName

This can be just about any single character from the keyboard or one of the key names from the [key list](../KeyList.htm), such as a mouse/joystick button. Joystick attributes other than buttons are not supported.

An explicit virtual key code such as `vkFF` may also be specified. This is useful in the rare case where a key has no name and produces no visible character when pressed. Its virtual key code can be determined by following the steps at the bottom of the [key list page](../KeyList.htm#SpecialKeys).

Options

If this parameter is blank, the command will wait indefinitely for the specified key or mouse/joystick button to be physically released by the user. However, if the [keyboard hook](_InstallKeybdHook.htm) is not installed and _KeyName_ is a keyboard key released artificially by means such as the [Send](Send.htm) command, the key will be seen as having been physically released. The same is true for mouse buttons when the [mouse hook](_InstallMouseHook.htm) is not installed.

Options: A string of one or more of the following letters (in any order, with optional spaces in between):

**D**: Wait for the key to be pushed down.

**L**: Check the logical state of the key, which is the state that the OS and the active window believe the key to be in (not necessarily the same as the physical state). This option is ignored for joystick buttons.

**T**: Timeout (e.g. `T3`). The number of seconds to wait before timing out and setting [ErrorLevel](../misc/ErrorLevel.htm) to 1. If the key or button achieves the specified state, the command will not wait for the timeout to expire. Instead, it will immediately set [ErrorLevel](../misc/ErrorLevel.htm) to 0 and the script will continue executing.

The timeout value can be a floating point number such as 2.5, but it should not be a hexadecimal value such as 0x03.

## ErrorLevel

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the command timed out or 0 otherwise.

## Remarks

The physical state of a key or mouse button will usually be the same as the logical state unless the keyboard and/or mouse hooks are installed, in which case it will accurately reflect whether or not the user is physically holding down the key. You can determine if your script is using the hooks via the [KeyHistory](KeyHistory.htm) command or menu item. You can force either or both of the hooks to be installed by adding the [#InstallKeybdHook](_InstallKeybdHook.htm) and [#InstallMouseHook](_InstallMouseHook.htm) directives to the script.

While the command is in a waiting state, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

To wait for two or more keys to be released, use KeyWait consecutively. For example:

```
KeyWait Control  <em>; Wait for both Control and Alt to be released.</em>
KeyWait Alt
```

To wait for any one key among a set of keys to be pressed down, see the examples section of the [Input](Input.htm) command.

## Related

[GetKeyState()](GetKeyState.htm#function), [Key List](../KeyList.htm), [Input](Input.htm), [KeyHistory](KeyHistory.htm), [#InstallKeybdHook](_InstallKeybdHook.htm), [#InstallMouseHook](_InstallMouseHook.htm), [ClipWait](ClipWait.htm), [WinWait](WinWait.htm)

## Examples

Waits for the A key to be released.

```
KeyWait, a
```

Waits for the left mouse button to be pressed down.

```
KeyWait, LButton, D
```

Waits up to 3 seconds for the first joystick button to be pressed down.

```
KeyWait, Joy1, D T3
```

Waits for the left Alt key to be logically released.

```
KeyWait, LAlt, L
```

When pressing this hotkey, KeyWait waits for the user to physically release the CapsLock key. As a result, subsequent statements are performed on release instead of press. This behavior is similar to `~CapsLock up::`.

```
~CapsLock::
KeyWait, CapsLock  <em>; Wait for user to physically release it.</em>
MsgBox You pressed and released the CapsLock key.
return
```

Remaps a key or mouse button (this is only for illustration because it would be easier to use the [built-in remapping feature](../misc/Remap.htm)). The left mouse button is kept held down while NumpadAdd is down, which effectively transforms NumpadAdd into the left mouse button.

```
*NumpadAdd::
MouseClick, left,,, 1, 0, D  <em>; Hold down the left mouse button.</em>
KeyWait, NumpadAdd  <em>; Wait for the key to be released.</em>
MouseClick, left,,, 1, 0, U  <em>; Release the mouse button.</em>
return
```

Detects when a key has been double-pressed (similar to double-click). KeyWait is used to stop the keyboard's auto-repeat feature from creating an unwanted double-press when you hold down the RControl key to modify another key. It does this by keeping the hotkey's thread running, which blocks the auto-repeats by relying upon #MaxThreadsPerHotkey being at its default setting of 1. Note: There is a more elaborate script to distinguish between single, double, and triple-presses at the bottom of the [SetTimer](SetTimer.htm) page.

```
~RControl::
if (A_PriorHotkey != "~RControl" or A_TimeSincePriorHotkey > 400)
{
    <em>; Too much time between presses, so this isn't a double-press.</em>
    KeyWait, RControl
    return
}
MsgBox You double-pressed the right control key.
return
```

