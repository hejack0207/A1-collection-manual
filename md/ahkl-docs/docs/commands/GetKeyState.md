# GetKeyState() / GetKeyState

Checks if a keyboard key or mouse/joystick button is down or up. Also retrieves joystick status.

## GetKeyState()

```
KeyIsDown := <span class="func">GetKeyState</span>(KeyName <span class="optional">, Mode</span>)

```

### Parameters

KeyName

This can be just about any single character from the keyboard or one of the key names from the [key list](../KeyList.htm), such as a mouse/joystick button. Examples: B, 5, LWin, RControl, Alt, Enter, Escape, LButton, MButton, Joy1.

Alternatively, an explicit virtual key code such as vkFF may be specified. This is useful in the rare case where a key has no name. The virtual key code of such a key can be determined by following the steps at the bottom of the [key list page](../KeyList.htm#SpecialKeys).

**Known limitation:** This function cannot differentiate between two keys which share the same virtual key code, such as Left and NumpadLeft.

Mode

This parameter is ignored when retrieving joystick status.

If omitted, the mode will default to that which retrieves the logical state of the key. This is the state that the OS and the active window believe the key to be in, but is not necessarily the same as the physical state.

Alternatively, one of these letters may be specified:

**P**: Retrieve the physical state (i.e. whether the user is physically holding it down). The physical state of a key or mouse button will usually be the same as the logical state unless the keyboard and/or mouse hooks are installed, in which case it will accurately reflect whether or not the user is physically holding down the key or button (as long as it was pressed down while the script was running). You can determine if your script is using the hooks via the [KeyHistory](KeyHistory.htm) command or menu item. You can force the hooks to be installed by adding the [#InstallKeybdHook](_InstallKeybdHook.htm) and/or [#InstallMouseHook](_InstallMouseHook.htm) directives to the script.

**T**: Retrieve the toggle state. For keys other than CapsLock, NumLock and ScrollLock, the toggle state is generally 0 when the script starts and is not synchronized between processes.

### Return Value

This function returns 1 if the key is down (or toggled on) or 0 if it is up (or toggled off). For the joystick's special keys such as axes and POV switch, [other values are retrieved](#joystick).

If _KeyName_ is invalid or the state of the key could not be determined, an empty string is returned.

## GetKeyState

**Deprecated:** This command is not recommended for use in new scripts. Use the [GetKeyState](#function) function instead.

```
<span class="func">GetKeyState</span>, OutputVar, KeyName <span class="optional">, Mode</span>

```

### Parameters

OutputVar

The name of the variable in which to store the retrieved key state, which is either D for down or U for up. The variable will be empty (blank) if the state of the key could not be determined. For the joystick's special keys such as axes and POV switch, [other values are retrieved](#joystick).

KeyName

This can be just about any single character from the keyboard or one of the key names from the [key list](../KeyList.htm), such as a mouse/joystick button. Examples: B, 5, LWin, RControl, Alt, Enter, Escape, LButton, MButton, Joy1.

Alternatively, an explicit virtual key code such as vkFF may be specified. This is useful in the rare case where a key has no name. The virtual key code of such a key can be determined by following the steps at the bottom of the [key list page](../KeyList.htm#SpecialKeys).

**Known limitation:** This command cannot differentiate between two keys which share the same virtual key code, such as Left and NumpadLeft.

Mode

This parameter is ignored when retrieving joystick status.

If omitted, the mode will default to that which retrieves the logical state of the key. This is the state that the OS and the active window believe the key to be in, but is not necessarily the same as the physical state.

Alternatively, one of these letters may be specified:

**P**: Retrieve the physical state (i.e. whether the user is physically holding it down). The physical state of a key or mouse button will usually be the same as the logical state unless the keyboard and/or mouse hooks are installed, in which case it will accurately reflect whether or not the user is physically holding down the key or button (as long as it was pressed down while the script was running). You can determine if your script is using the hooks via the [KeyHistory](KeyHistory.htm) command or menu item. You can force the hooks to be installed by adding the [#InstallKeybdHook](_InstallKeybdHook.htm) and/or [#InstallMouseHook](_InstallMouseHook.htm) directives to the script.

**T**: Retrieve the toggle state. A retrieved value of D means the key is "on", while U means it's "off". For keys other than CapsLock, NumLock and ScrollLock, the toggle state is generally U when the script starts and is not synchronized between processes.

## Joystick's special keys

When _KeyName_ is a joystick axis such as JoyX, the retrieved value will be a floating point number between 0 and 100 to indicate the joystick's position as a percentage of that axis's range of motion. The format of the number can be changed via [Format()](Format.htm) or [SetFormat](SetFormat.htm). This [test script](../scripts/index.htm#JoystickTest) can be used to analyze your joystick(s).

When _KeyName_ is JoyPOV, the retrieved value will be between 0 and 35900. The following approximate POV values are used by many joysticks:

- -1: no angle to report
- 0: forward POV
- 9000 (i.e. 90 degrees): right POV
- 27000 (i.e. 270 degrees): left POV
- 18000 (i.e. 180 degrees): backward POV

## Remarks

To wait for a key or mouse/joystick button to achieve a new state, it is usually easier to use [KeyWait](KeyWait.htm) instead of a GetKeyState loop.

Systems with unusual keyboard drivers might be slow to update the state of their keys, especially the toggle-state of keys like CapsLock. A script that checks the state of such a key immediately after it changed may use [Sleep](Sleep.htm) beforehand to give the system time to update the key state.

For examples of using GetKeyState with a joystick, see the [joystick remapping page](../misc/RemapJoystick.htm) and the [Joystick-To-Mouse script](../scripts/index.htm#JoystickMouse).

## Related

[KeyWait](KeyWait.htm), [Key List](../KeyList.htm), [Joystick remapping](../misc/RemapJoystick.htm), [KeyHistory](KeyHistory.htm), [#InstallKeybdHook](_InstallKeybdHook.htm), [#InstallMouseHook](_InstallMouseHook.htm)

## Examples

Command vs. function. Although the first code block uses the command and the second one uses the function, these two blocks are functionally identical.

```
GetKeyState, state, RButton  <em>; Right mouse button.</em>
GetKeyState, state, Joy2  <em>; The second button of the first joystick.</em>

GetKeyState, state, Shift
if (state = "D")
    MsgBox At least one Shift key is down.
else
    MsgBox Neither Shift key is down.

GetKeyState, state, CapsLock, T <em>;  D if CapsLock is ON or U otherwise.</em>

```

```
state := GetKeyState("RButton")  <em>; Right mouse button.</em>
state := GetKeyState("Joy2")  <em>; The second button of the first joystick.</em>

if GetKeyState("Shift")
    MsgBox At least one Shift key is down.
else
    MsgBox Neither Shift key is down.

state := GetKeyState("CapsLock", "T") <em>; True if CapsLock is ON, false otherwise.</em>

```

Remapping. (This example is only for illustration because it would be easier to use the [built-in remapping feature](../misc/Remap.htm).) In the following hotkey, the mouse button is kept held down while NumpadAdd is down, which effectively transforms NumpadAdd into a mouse button. This method can also be used to repeat an action while the user is holding down a key or button.

```
*NumpadAdd::
MouseClick, left,,, 1, 0, D  <em>; Hold down the left mouse button.</em>
Loop
{
    Sleep, 10
    if !GetKeyState("NumpadAdd", "P")  <em>; The key has been released, so break out of the loop.</em>
        break
    <em>; ... insert here any other actions you want repeated.</em>
}
MouseClick, left,,, 1, 0, U  <em>; Release the mouse button.</em>
return
```

Makes joystick button behavior depend on joystick axis position.

```
joy2::
JoyX := GetKeyState("JoyX")
if (JoyX > 75)
    MsgBox Action #1 (button pressed while joystick was pushed to the right).
else if (JoyX < 25)
    MsgBox Action #2 (button pressed while joystick was pushed to the left).
else
    MsgBox Action #3 (button pressed while joystick was centered horizontally).
return

```

See the [joystick remapping page](../misc/RemapJoystick.htm) and the [Joystick-To-Mouse script](../scripts/index.htm#JoystickMouse) for other examples.

