# BlockInput

Disables or enables the user's ability to interact with the computer via keyboard and mouse.

```
<span class="func">BlockInput</span>, OnOff
<span class="func">BlockInput</span>, SendMouse
<span class="func">BlockInput</span>, MouseMove  <em>; <span class="ver">[v1.0.43.11+]</span></em>
```

## Parameters

OnOff

This mode blocks all user inputs unconditionally. Specify one of the following words:

**On**: The user is prevented from interacting with the computer (mouse and keyboard input has no effect).

**Off**: Input is re-enabled.

[v1.1.30+]: The decimal values 1 and 0 may be used in place of On and Off, respectively.

SendMouse

This mode only blocks user inputs while specific send and/or mouse commands are in progress. Specify one of the following words:

**Send**: The user's keyboard and mouse input is ignored while a [Send](Send.htm) or [SendRaw](Send.htm) is in progress (the traditional [SendEvent mode](SendMode.htm) only). This prevents the user's keystrokes from disrupting the flow of simulated keystrokes. When the Send finishes, input is re-enabled (unless still blocked by a previous use of `BlockInput On`).

**Mouse**: The user's keyboard and mouse input is ignored while a [Click](Click.htm), [MouseMove](MouseMove.htm), [MouseClick](MouseClick.htm), or [MouseClickDrag](MouseClickDrag.htm) is in progress (the traditional [SendEvent mode](SendMode.htm) only). This prevents the user's mouse movements and clicks from disrupting the simulated mouse events. When the mouse command finishes, input is re-enabled (unless still blocked by a previous use of `BlockInput On`).

**SendAndMouse**: A combination of the above two modes.

**Default**: Turns off both the _Send_ and the _Mouse_ modes, but does not change the current state of input blocking. For example, if `BlockInput On` is currently in effect, using `BlockInput Default` will not turn it off.

MouseMove [v1.0.43.11+]

This mode only blocks the mouse cursor movement. Specify one of the following words:

**MouseMove**: The mouse cursor will not move in response to the user's physical movement of the mouse (DirectInput applications are a possible exception). When a script first uses this command, the [mouse hook](_InstallMouseHook.htm) is installed (if it is not already). In addition, the script becomes [persistent](_Persistent.htm), meaning that [ExitApp](ExitApp.htm) should be used to terminate it. The mouse hook will stay installed until the next use of the [Suspend](Suspend.htm) or [Hotkey](Hotkey.htm) command, at which time it is removed if not required by any hotkeys or hotstrings (see [#Hotstring NoMouse](_Hotstring.htm)).

**MouseMoveOff**: Allows the user to move the mouse cursor.

## Remarks

All three BlockInput modes ( _OnOff_, _SendMouse_ and _MouseMove_) operate independently of each other. For example, `BlockInput On` will continue to block input until `BlockInput Off` is used, even if one of the words from _SendMouse_ is also in effect. Another example is, if `BlockInput On` and `BlockInput MouseMove` are both in effect, mouse movement will be blocked until both are turned off.

**Note:** The _OnOff_ and _SendMouse_ modes might have no effect if UAC is enabled or the script has not been run as administrator. For more information, refer to the [FAQ](../FAQ.htm#uac).

In preference to BlockInput, it is often better to use `<a href="SendMode.htm" data-index="16">SendMode</a> Input` or `<a href="SendMode.htm" data-index="17">SendMode</a> Play` so that keystrokes and mouse clicks become uninterruptible. This is because unlike BlockInput, those modes do not discard what the user types during the send; instead, those keystrokes are buffered and sent afterward. Avoiding BlockInput also avoids the need to work around sticking keys as described in the next paragraph.

If BlockInput becomes active while the user is holding down keys, it might cause those keys to become "stuck down". This can be avoided by waiting for the keys to be released prior to turning BlockInput on, as in this example:

```
^!p::
KeyWait Control  <em>; Wait for the key to be released.  Use one KeyWait for each of the hotkey's modifiers.</em>
KeyWait Alt
BlockInput On
<em>; ... send keystrokes and mouse clicks ...</em>
BlockInput Off
return
```

Input blocking is automatically and momentarily disabled whenever an Alt event is sent (then re-enabled afterward).

When BlockInput is in effect, user input is blocked but AutoHotkey can simulate keystrokes and mouse clicks. However, pressing Ctrl+Alt+Del will re-enable input due to a Windows API feature.

Certain types of [hook hotkeys](_UseHook.htm) can still be triggered when BlockInput is on. Examples include `MButton` (mouse hook) and `LWin & Space` (keyboard hook with explicit prefix rather than modifiers `$#`).

Input is automatically re-enabled when the script closes.

## Related

[SendMode](SendMode.htm), [Send](Send.htm), [Click](Click.htm), [MouseMove](MouseMove.htm), [MouseClick](MouseClick.htm), [MouseClickDrag](MouseClickDrag.htm)

## Examples

Opens Notepad and pastes time/date by sending F5 while BlockInput is turned on. Note that BlockInput may only work if the script has been run as administrator.

```
BlockInput, On
Run, notepad
WinWaitActive, Untitled - Notepad
Send, {F5} <em>; pastes time and date</em>
BlockInput, Off
```

