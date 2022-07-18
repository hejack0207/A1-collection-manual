# Remapping a Joystick to Keyboard or Mouse

## Table of Contents

- [Important Notes](#imp)
- [Making a Joystick Button Send Keystrokes or Mouse Clicks](#button)
  - [Different Approaches](#different-approaches)
  - [Auto-repeating a Keystroke](#auto-repeating-joystick-buttons)
  - [Context-sensitive Joystick Buttons](#context-sensitive-joystick-buttons)
  - [Using a Joystick as a Mouse](#using-a-joystick-as-a-mouse)
- [Making Other Joystick Controls Send Keystrokes or Mouse Clicks](#axis)
  - [Joystick Axes](#joystick-axes)
  - [Joystick POV Hat](#joystick-pov-hat)
  - [Auto-repeating a Keystroke](#auto-repeating-other)
- [Remarks](#Remarks)
- [Related Topics](#related)

## Important Notes

- Although a joystick button or axis can be remapped to become a key or mouse button, it cannot be remapped to some other joystick button or axis. That would be possible only with the help of a joystick emulator such as[vJoy](https://sourceforge.net/projects/vjoystick/).
- AutoHotkey identifies each button on a joystick with a unique number between 1 and 32. To determine these numbers, use the[joystick test script](../scripts/index.htm#JoystickTest).

## Making a Joystick Button Send Keystrokes or Mouse Clicks

### Different Approaches

Below are three approaches, starting at the simplest and ending with the most complex. The most complex method works in the broadest variety of circumstances (such as games that require a key or mouse button to be held down).

#### Method \#1

This method sends simple keystrokes and mouse clicks. For example:

```
Joy1::<a href="../commands/Send.htm" data-index="15">Send</a> {Left}  <em>; Have button #1 send a left-arrow keystroke.</em>
Joy2::<a href="../commands/Click.htm" data-index="16">Click</a>  <em>; Have button #2 send a click of left mouse button.</em>
Joy3::Send a{Esc}{Space}{Enter}  <em>; Have button #3 send the letter "a" followed by Escape, Space, and Enter.</em>
Joy4::Send Sincerely,{Enter}John Smith  <em>; Have button #4 send a two-line signature.</em>
```

To have a button perform more than one command, put the first command _beneath_ the button name and make the last command a [return](../commands/Return.htm). For example:

```
Joy5::
Run Notepad
WinWait Untitled - Notepad
WinActivate
Send This is the text that will appear in Notepad.{Enter}
return
```

See the [Key List](../KeyList.htm) for the complete list of keys and mouse/joystick buttons.

#### Method \#2

This method is necessary in cases where a key or mouse button must be held down for the entire time that you're holding down a joystick button. The following example makes the joystick's second button become the left-arrow key:

```
Joy2::
Send {Left down}  <em>; Hold down the left-arrow key.</em>
<a href="../commands/KeyWait.htm" data-index="19">KeyWait</a> Joy2  <em>; Wait for the user to release the joystick button.</em>
Send {Left up}  <em>; Release the left-arrow key.</em>
return
```

#### Method \#3

This method is necessary in cases where you have more than one joystick hotkey of the type described in Method #2, and you sometimes press and release such hotkeys simultaneously. The following example makes the joystick's third button become the left mouse button:

```
Joy3::
Send {LButton down}   <em>; Hold down the left mouse button.</em>
SetTimer, WaitForButtonUp3, 10
return

WaitForButtonUp3:
if <a href="../commands/GetKeyState.htm#function" data-index="20">GetKeyState</a>("Joy3")  <em>; The button is still, down, so keep waiting.</em>
    return
<em>; Otherwise, the button has been released.</em>
Send {LButton up}  <em>; Release the left mouse button.</em>
SetTimer, WaitForButtonUp3, Off
return

```

### Auto-repeating a Keystroke

Some programs or games might require a key to be sent repeatedly (as though you are holding it down on the keyboard). The following example achieves this by sending spacebar keystrokes repeatedly while you hold down the joystick's second button:

```
Joy2::
Send {Space down}   <em>; Press the spacebar down.</em>
SetTimer, WaitForJoy2, <strong>30</strong>  <em>; Reduce the number <strong>30</strong> to 20 or 10 to send keys faster. Increase it to send slower.</em>
return

WaitForJoy2:
if not GetKeyState("Joy2")  <em>; The button has been released.</em>
{
    Send {Space up}  <em>; Release the spacebar.</em>
    SetTimer, WaitForJoy2, Off  <em>; Stop monitoring the button.</em>
    return
}
<em>; Since above didn't "return", the button is still being held down.</em>
Send {Space down}  <em>; Send another Spacebar keystroke.</em>
return
```

### Context-sensitive Joystick Buttons

The directives [#IfWinActive/Exist](../commands/_IfWinActive.htm) can be used to make selected joystick buttons perform a different action (or none at all) depending on the type of window that is active or exists.

### Using a Joystick as a Mouse

The [Joystick-To-Mouse script](../scripts/index.htm#JoystickMouse) converts a joystick into a mouse by remapping its buttons and axis control.

## Making Other Joystick Controls Send Keystrokes or Mouse Clicks

To have a script respond to movement of a joystick's axis or POV hat, use [SetTimer](../commands/SetTimer.htm) and [GetKeyState()](../commands/GetKeyState.htm#function).

### Joystick Axes

The following example makes the joystick's X and Y axes behave like the arrow key cluster on a keyboard (left, right, up, and down):

```
#Persistent  <em>; Keep this script running until the user explicitly exits it.</em>
<a href="../commands/SetTimer.htm" data-index="25">SetTimer</a>, WatchAxis, 5
return

WatchAxis:
JoyX := <a href="../commands/GetKeyState.htm#function" data-index="26">GetKeyState</a>("JoyX")  <em>; Get position of X axis.</em>
JoyY := GetKeyState("JoyY")  <em>; Get position of Y axis.</em>
KeyToHoldDownPrev := KeyToHoldDown  <em>; Prev now holds the key that was down before (if any).</em>

if (JoyX > 70)
    KeyToHoldDown := "Right"
else if (JoyX < 30)
    KeyToHoldDown := "Left"
else if (JoyY > 70)
    KeyToHoldDown := "Down"
else if (JoyY < 30)
    KeyToHoldDown := "Up"
else
    KeyToHoldDown := ""

if (KeyToHoldDown = KeyToHoldDownPrev)  <em>; The correct key is already down (or no key is needed).</em>
    return  <em>; Do nothing.</em>

<em>; Otherwise, release the previous key and press down the new key:</em>
SetKeyDelay -1  <em>; Avoid delays between keystrokes.</em>
if KeyToHoldDownPrev   <em>; There is a previous key to release.</em>
    Send, {%KeyToHoldDownPrev% up}  <em>; Release it.</em>
if KeyToHoldDown   <em>; There is a key to press down.</em>
    Send, {%KeyToHoldDown% down}  <em>; Press it down.</em>
return
```

### Joystick POV Hat

The following example makes the joystick's POV hat behave like the arrow key cluster on a keyboard; that is, the POV hat will send arrow keystrokes (left, right, up, and down):

```
#Persistent  <em>; Keep this script running until the user explicitly exits it.</em>
SetTimer, WatchPOV, 5
return

WatchPOV:
POV := GetKeyState("JoyPOV")  <em>; Get position of the POV control.</em>
KeyToHoldDownPrev := KeyToHoldDown  <em>; Prev now holds the key that was down before (if any).</em>

<em>; Some joysticks might have a smooth/continous POV rather than one in fixed increments.
; To support them all, use a range:</em>
if (POV < 0)   <em>; No angle to report</em>
    KeyToHoldDown := ""
else if (POV > 31500)               <em>; 315 to 360 degrees: Forward</em>
    KeyToHoldDown := "Up"
else if POV between 0 and 4500      <em>; 0 to 45 degrees: Forward</em>
    KeyToHoldDown := "Up"
else if POV between 4501 and 13500  <em>; 45 to 135 degrees: Right</em>
    KeyToHoldDown := "Right"
else if POV between 13501 and 22500 <em>; 135 to 225 degrees: Down</em>
    KeyToHoldDown := "Down"
else                                <em>; 225 to 315 degrees: Left</em>
    KeyToHoldDown := "Left"

if (KeyToHoldDown = KeyToHoldDownPrev)  <em>; The correct key is already down (or no key is needed).</em>
    return  <em>; Do nothing.</em>

<em>; Otherwise, release the previous key and press down the new key:</em>
SetKeyDelay -1  <em>; Avoid delays between keystrokes.</em>
if KeyToHoldDownPrev   <em>; There is a previous key to release.</em>
    Send, {%KeyToHoldDownPrev% up}  <em>; Release it.</em>
if KeyToHoldDown   <em>; There is a key to press down.</em>
    Send, {%KeyToHoldDown% down}  <em>; Press it down.</em>
return
```

### Auto-repeating a Keystroke

Both examples above can be modified to send the key repeatedly rather than merely holding it down (that is, they can mimic physically holding down a key on the keyboard). To do this, replace the following line:

```
return  <em>; Do nothing.</em>
```

With the following:

```
{
    if KeyToHoldDown
        Send, {%KeyToHoldDown% down}  <em>; Auto-repeat the keystroke.</em>
    return
}
```

## Remarks

A joystick other than first may be used by preceding the button or axis name with the number of the joystick. For example, `2Joy1` would be the second joystick's first button.

To find other useful joystick scripts, visit the [AutoHotkey forum](https://www.autohotkey.com/forum/). A keyword search such as _Joystick and GetKeyState and Send_ is likely to produce topics of interest.

## Related Topics

- [Joystick-To-Mouse script (using a joystick as a mouse)](../scripts/index.htm#JoystickMouse)
- [List of joystick buttons, axes, and controls](../KeyList.htm#Joystick)
- [GetKeyState()](../commands/GetKeyState.htm#function)
- [Remapping the keyboard and mouse](Remap.htm)

