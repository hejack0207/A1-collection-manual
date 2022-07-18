# List of Keys (Keyboard, Mouse and Joystick)

## Table of Contents

- [Mouse](#mouse)
  - [General Buttons](#mouse-general)
  - [Advanced Buttons](#mouse-advanced)
  - [Wheel](#mouse-wheel)
- [Keyboard](#keyboard)
  - [General Keys](#general)
  - [Cursor Control Keys](#cursor)
  - [Numpad Keys](#numpad)
  - [Function Keys](#function)
  - [Modifier Keys](#modifier)
  - [Multimedia Keys](#multimedia)
  - [Other Keys](#other)
- [Joystick](#Joystick)
- [Hand-held Remote Controls](#remote)
- [Special Keys](#SpecialKeys)
- [CapsLock and IME](#IME)

## Mouse

### General Buttons

NameDescriptionLButtonThe left mouse button when used with Send, but the primary mouse button when used with hotkeys. In other words, if the user has swapped the buttons via system settings, `LButton::` is physically activated by clicking the **right** mouse button, but `Send {LButton}` performs the same as physically clicking the **left** button. To always perform a logical left click, use `Click Left` or `Send {Click Left}`.RButtonThe right mouse button when used with Send, but the secondary mouse button when used with hotkeys. In other words, if the user has swapped the buttons via system settings, `RButton::` is physically activated by clicking the **left** mouse button, but `Send {RButton}` performs the same as physically clicking the **right** button. To always perform a logical right click, use `Click Right` or `Send {Click Right}`.MButtonMiddle or wheel mouse button

### Advanced Buttons

NameDescriptionXButton14th mouse button. Typically performs the same function as Browser\_Back.XButton25th mouse button. Typically performs the same function as Browser\_Forward.

### Wheel

NameDescriptionWheelDownTurn the wheel downward (toward you).WheelUpTurn the wheel upward (away from you).WheelLeft

WheelRight

[v1.0.48+]: Scroll to the left or right.

Requires Windows Vista or later. These can be [used as hotkeys](Hotkeys.htm#HWheel) with some (but not all) mice which have a second wheel or support tilting the wheel to either side. In some cases, software bundled with the mouse must instead be used to control this feature. Regardless of the particular mouse, [Send](commands/Send.htm) and [Click](commands/Click.htm) can be used to scroll horizontally in programs which support it.

## Keyboard

**Note**: The names of the letter and number keys are the same as that single letter or digit. For example: b is B and 5 is 5.

Although any single character can be used as a key name, its meaning (scan code or virtual keycode) depends on the current keyboard layout. Additionally, some special characters may need to be escaped or enclosed in braces, depending on the context. [v1.1.27+]: The letters a-z or A-Z can be used to refer to the corresponding virtual keycodes (usually vk41-vk5A) even if they are not included in the current keyboard layout.

### General Keys

NameDescriptionCapsLockCapsLock (caps lock key)


**Note:** Windows IME may interfere with the detection and functionality of CapsLock; see [CapsLock and IME](#IME) for details.

SpaceSpace (space bar)TabTab (tabulator key)EnterEnterReturn**Deprecated:** Use the synonym `Enter` instead to reduce ambiguity.Escape (or Esc)EscBackspace (or BS)Backspace

### Cursor Control Keys

NameDescriptionScrollLockScrollLock (scroll lock key). While Ctrl is held down, ScrollLock produces the key code of `CtrlBreak`, but can be differentiated from Pause by scan code.Delete (or Del)DelInsert (or Ins)InsHomeHomeEndEndPgUpPgUp (page up key)PgDnPgDn (page down key)Up↑ (up arrow key)Down↓ (down arrow key)Left← (left arrow key)Right→ (right arrow key)

### Numpad Keys

Due to system behavior, the following keys separated by a slash are identified differently depending on whether NumLock is ON or OFF. If NumLock is OFF but Shift is pressed, the system temporarily releases Shift and acts as though NumLock is ON.

NameDescriptionNumpad0 / NumpadIns0 / InsNumpad1 / NumpadEnd1 / EndNumpad2 / NumpadDown2 / ↓Numpad3 / NumpadPgDn3 / PgDnNumpad4 / NumpadLeft4 / ←Numpad5 / NumpadClear5 / typically does nothingNumpad6 / NumpadRight6 / →Numpad7 / NumpadHome7 / HomeNumpad8 / NumpadUp8 / ↑Numpad9 / NumpadPgUp9 / PgUpNumpadDot / NumpadDel. / DelNumLockNumLock (number lock key). While Ctrl is held down, NumLock produces the key code of `Pause`, so use `^Pause` in hotkeys instead of `^NumLock`.NumpadDiv/ (division)NumpadMult\* (multiplication)NumpadAdd+ (addition)NumpadSub- (subtraction)NumpadEnterEnter

### Function Keys

NameDescriptionF1 - F24The 12 or more function keys at the top of most keyboards.

### Modifier Keys

NameDescriptionLWinLeft Win. Corresponds to the `<#` hotkey prefix.RWin

Right Win. Corresponds to the `>#` hotkey prefix.

**Note**: Unlike Ctrl/Alt/Shift, there is no generic/neutral "Win" key because the OS does not support it. However, hotkeys with the `#` modifier can be triggered by either Win.

Control (or Ctrl)Ctrl. As a hotkey ( `Control::`) it fires upon release unless it has the tilde prefix. Corresponds to the `^` hotkey prefix.AltAlt. As a hotkey ( `Alt::`) it fires upon release unless it has the tilde prefix. Corresponds to the `!` hotkey prefix.ShiftShift. As a hotkey ( `Shift::`) it fires upon release unless it has the tilde prefix. Corresponds to the `+` hotkey prefix.LControl (or LCtrl)Left Ctrl. Corresponds to the `<^` hotkey prefix.RControl (or RCtrl)Right Ctrl. Corresponds to the `>^` hotkey prefix.LShiftLeft Shift. Corresponds to the `<+` hotkey prefix.RShiftRight Shift. Corresponds to the `>+` hotkey prefix.LAltLeft Alt. Corresponds to the `<!` hotkey prefix.RAlt

Right Alt. Corresponds to the `>!` hotkey prefix.

**Note**: If your keyboard layout has AltGr instead of RAlt, you can probably use it as a hotkey prefix via `<^>!` as described [here](Hotkeys.htm#AltGr). In addition, `LControl & RAlt::` would make AltGr itself into a hotkey.

### Multimedia Keys

The function assigned to each of the keys listed below can be overridden by modifying the Windows registry. This table shows the default function of each key on most versions of Windows.

NameDescriptionBrowser\_BackBackBrowser\_ForwardForwardBrowser\_RefreshRefreshBrowser\_StopStopBrowser\_SearchSearchBrowser\_FavoritesFavoritesBrowser\_HomeHomepageVolume\_MuteMute the volumeVolume\_DownLower the volumeVolume\_UpIncrease the volumeMedia\_NextNext TrackMedia\_PrevPrevious TrackMedia\_StopStopMedia\_Play\_PausePlay/PauseLaunch\_MailLaunch default e-mail programLaunch\_MediaLaunch default media playerLaunch\_App1Launch My ComputerLaunch\_App2Launch Calculator

### Other Keys

NameDescriptionAppsKeyMenu. This is the key that invokes the right-click context menu.PrintScreenPrtSc (print screen key)CtrlBreakCtrl+Pause or Ctrl+ScrollLockPausePause or Ctrl+NumLock. While Ctrl is held down, Pause produces the key code of `CtrlBreak` and NumLock produces `Pause`, so use `^CtrlBreak` in hotkeys instead of `^Pause`.Break**Deprecated:** Use the synonym `Pause` instead.HelpHelp. This probably doesn't exist on most keyboards. It's usually not the same as F1.SleepSleep. Note that the sleep key on some keyboards might not work with this.SC **nnn**Specify for **nnn** the scan code of a key. Recognizes unusual keys not mentioned above. See [Special Keys](#SpecialKeys) for details.VK **nn**

Specify for **nn** the hexadecimal virtual key code of a key. This rarely-used method also prevents certain types of [hotkeys](Hotkeys.htm) from requiring the [keyboard hook](commands/_InstallKeybdHook.htm). For example, the following hotkey does not use the keyboard hook, but as a side-effect it is triggered by pressing _either_ Home or NumpadHome:

```
^VK24::MsgBox You pressed Home or NumpadHome while holding down Control.

```

**Known limitation:** VK hotkeys that are forced to use the [keyboard hook](commands/_InstallKeybdHook.htm), such as `*VK24` or `~VK24`, will fire for only one of the keys, not both (e.g. NumpadHome but not Home).
For more information about the VKnn method, see [Special Keys](#SpecialKeys).

**Warning:** Only [Send](commands/Send.htm), [GetKeyName()](commands/GetKey.htm), [GetKeyVK()](commands/GetKey.htm), [GetKeySC()](commands/GetKey.htm) and [#MenuMaskKey](commands/_MenuMaskKey.htm) support combining VKnn and SCnnn. [v1.1.27+]: The presence of an invalid suffix prevents VKnn from being recognized. For example, `vk1Bsc001::` raises an error in v1.1.27+, but `sc001` was ignored (had no effect) in previous versions.

## Joystick

**Joy1 through Joy32**: The buttons of the joystick. To help determine the button numbers for your joystick, use this [test script](scripts/index.htm#JoystickTest). Note that [hotkey prefix symbols](Hotkeys.htm) such as ^ (control) and + (shift) are not supported (though [GetKeyState()](commands/GetKeyState.htm#function) can be used as a substitute). Also note that the pressing of joystick buttons always "passes through" to the active window if that window is designed to detect the pressing of joystick buttons.

Although the following Joystick control names cannot be used as hotkeys, they can be used with [GetKeyState()](commands/GetKeyState.htm#function):

- **JoyX, JoyY, and JoyZ**: The X (horizontal), Y (vertical), and Z (altitude/depth) axes of the joystick.
- **JoyR**: The rudder or 4th axis of the joystick.
- **JoyU and JoyV**: The 5th and 6th axes of the joystick.
- **JoyPOV**: The point-of-view (hat) control.
- **JoyName**: The name of the joystick or its driver.
- **JoyButtons**: The number of buttons supported by the joystick (not always accurate).
- **JoyAxes**: The number of axes supported by the joystick.
- **JoyInfo**: Provides a string consisting of zero or more of the following letters to indicate the joystick's capabilities: **Z** (has Z axis), **R** (has R axis), **U** (has U axis), **V** (has V axis), **P** (has POV control), **D** (the POV control has a limited number of discrete/distinct settings), **C** (the POV control is continuous/fine). Example string: ZRUVPD

**Multiple Joysticks**: If the computer has more than one joystick and you want to use one beyond the first, include the joystick number (max 16) in front of the control name. For example, 2joy1 is the second joystick's first button.

**Note**: If you have trouble getting a script to recognize your joystick, one person reported needing to specify a joystick number other than 1 even though only a single joystick was present. It is unclear how this situation arises or whether it is normal, but experimenting with the joystick number in the [joystick test script](scripts/index.htm#JoystickTest) can help determine if this applies to your system.

**See Also**:

- [Joystick remapping:](misc/RemapJoystick.htm) Methods of sending keystrokes and mouse clicks with a joystick.
- [Joystick-To-Mouse script](scripts/index.htm#JoystickMouse): Using a joystick as a mouse.

## Hand-held Remote Controls

Respond to signals from hand-held remote controls via the [WinLIRC client script](scripts/index.htm#WinLIRC).

## Special Keys

If your keyboard or mouse has a key not listed above, you might still be able to make it a hotkey by using the following steps:

1. Ensure that at least one script is running that is using the[keyboard hook](commands/_InstallKeybdHook.htm). You can tell if a script has the keyboard hook by opening its main window and selecting "View-> [Key history](commands/KeyHistory.htm)" from the menu bar.
2. Double-click that script's tray icon to open its main window.
3. Press one of the "mystery keys" on your keyboard.
4. Select the menu item "View-> [Key history](commands/KeyHistory.htm)"
5. Scroll down to the bottom of the page. Somewhere near the bottom are the key-down and key-up events for your key. NOTE: Some keys do not generate events and thus will not be visible here. If this is the case, you cannot directly make that particular key a hotkey because your keyboard driver or hardware handles it at a level too low for AutoHotkey to access. For possible solutions, see further below.
6. If your key is detectable, make a note of the 3-digit hexadecimal value in the second column of the list (e.g.**159**).
7. To define this key as a hotkey, follow this example:


   ```
   <strong>SC159::</strong> <em>; Replace 159 with your key's value.</em>
   MsgBox, %A_ThisHotkey% was pressed.
   return
   ```


**Reverse direction**: To remap some other key to _become_ a "mystery key", follow this example:

```
<em>; Replace 159 with the value discovered above. Replace FF (if needed) with the
; key's virtual key, which can be discovered in the first column of the Key History screen.</em>
#c::Send {vkFFsc159} <em>; See <a href="commands/Send.htm#vk" data-index="43">Send {vkXXscYYY}</a> for more details.</em>
```

**Alternate solutions**: If your key or mouse button is not detectable by the [Key History](commands/KeyHistory.htm) screen, one of the following might help:

1. Reconfigure the software that came with your mouse or keyboard (sometimes accessible in the Control Panel or Start Menu) to have the "mystery key" send some other keystroke. Such a keystroke can then be defined as a hotkey in a script. For example, if you configure a mystery key to send Ctrl+F1, you can then indirectly make that key as a hotkey by using `^F1::` in a script.

2. Try [AHKHID](https://www.autohotkey.com/board/topic/38015-ahkhid-an-ahk-implementation-of-the-hid-functions/). You can also try searching the [forum](https://www.autohotkey.com/boards/) for a keywords like `RawInput*`, `USB HID` or `AHKHID`.

3. The following is a last resort and generally should be attempted only in desperation. This is because the chance of success is low and it may cause unwanted side-effects that are difficult to undo:


    Disable or remove any extra software that came with your keyboard or mouse or change its driver to a more standard one such as the one built into the OS. This assumes there is such a driver for your particular keyboard or mouse and that you can live without the features provided by its custom driver and software.


## CapsLock and IME

Some configurations of Windows IME (such as Japanese input with English keyboard) use CapsLock to toggle between modes. In such cases, CapsLock is suppressed by the IME and cannot be detected by AutoHotkey. However, the Alt+CapsLock, Ctrl+CapsLock and Shift+CapsLock shortcuts can be disabled with a workaround. Specifically, send a key-up to modify the state of the IME, but prevent any other effects by signalling the keyboard hook to suppress the event. The following function can be used for this purpose:

```
<em>; Requires AutoHotkey v1.1.26+, and the keyboard hook must be installed.</em>
#InstallKeybdHook
SendSuppressedKeyUp(key) {
    DllCall("keybd_event"
        , "char", GetKeyVK(key)
        , "char", GetKeySC(key)
        , "uint", KEYEVENTF_KEYUP := 0x2
        , "uptr", KEY_BLOCK_THIS := 0xFFC3D450)
}

```

After copying the function into a script or saving it as _SendSuppressedKeyUp.ahk_ in a [function library](Functions.htm#lib), it can be used as follows:

```
<em>; Disable Alt+key shortcuts for the IME.</em>
~LAlt::SendSuppressedKeyUp("LAlt")

<em>; Test hotkey:</em>
!CapsLock::MsgBox % A_ThisHotkey

<em>; Remap CapsLock to LCtrl in a way compatible with IME.</em>
*CapsLock::
    Send {Blind}{LCtrl DownR}
    SendSuppressedKeyUp("LCtrl")
    return
*CapsLock up::
    Send {Blind}{LCtrl Up}
    return

```

