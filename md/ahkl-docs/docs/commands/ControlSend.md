# ControlSend[Raw]

Sends simulated keystrokes to a window or control.

```
<span class="func">ControlSend</span> <span class="optional">, Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
ControlSendRaw: Same parameters as above.

```

## Parameters

Control

Can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm). If this parameter is blank or omitted, the target window's topmost control will be used. If this parameter is `ahk_parent`, the keystrokes will be sent directly to the target window instead of one of its controls (see [Automating Winamp](../misc/Winamp.htm) for an example).

To operate upon a control's HWND (window handle), leave the _Control_ parameter blank and specify `ahk_id %ControlHwnd%` for the _WinTitle_ parameter (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off). The HWND of a control is typically retrieved via [ControlGet Hwnd](ControlGet.htm#Hwnd), [MouseGetPos](MouseGetPos.htm), or [DllCall()](DllCall.htm).

Keys

The sequence of keys to send (see the [Send](Send.htm) command for details). To send a literal comma, [escape](../misc/EscapeChar.htm) it (\`,). The rate at which characters are sent is determined by [SetKeyDelay](SetKeyDelay.htm).

Unlike the [Send](Send.htm) command, mouse clicks cannot be sent by ControlSend. Use [ControlClick](ControlClick.htm) for that.

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

ControlSendRaw sends the keystrokes in the _Keys_ parameter without translating `{Enter}` to Enter, `^c` to Ctrl+C, etc. For details, see [Raw mode](Send.htm#SendRaw). It is also valid to use [{Raw}](Send.htm#Raw) or [{Text}](Send.htm#Text) with ControlSend. [v1.1.27+]: [Text mode](Send.htm#SendText) may be more reliable for sending text.

If the _Control_ parameter is omitted, this command will attempt to send directly to the target window by sending to its topmost control (which is often the correct one) or the window itself if there are no controls. This is useful if a window does not appear to have any controls at all, or just for the convenience of not having to worry about which control to send to.

By default, modifier keystrokes (Ctrl, Alt, Shift, and Win) are sent as they normally would be by the Send command. This allows command prompt and other console windows to properly detect uppercase letters, control characters, etc. It may also improve reliability in other ways.

However, in some cases these modifier events may interfere with the active window, especially if the user is actively typing during a ControlSend or if Alt is being sent (since Alt activates the active window's menu bar). This can be avoided by explicitly sending modifier up and down events as in this example:

```
ControlSend, Edit1, {Alt down}f{Alt up}, Untitled - Notepad
```

The method above also allows the sending of modifier keystrokes (Ctrl, Alt, Shift, and Win) while the workstation is locked (protected by logon prompt).

[BlockInput](BlockInput.htm) should be avoided when using ControlSend against a console window such as command prompt. This is because it might prevent capitalization and modifier keys such as Ctrl from working properly.

The value of [SetKeyDelay](SetKeyDelay.htm) determines the speed at which keys are sent. If the target window does not receive the keystrokes reliably, try increasing the press duration via the second parameter of [SetKeyDelay](SetKeyDelay.htm) as in these examples:

```
SetKeyDelay, 10, 10
SetKeyDelay, 0, 10
SetKeyDelay, -1, 0
```

If the target control is an Edit control (or something similar), the following are usually more reliable and faster than ControlSend:

```
<a href="Control.htm" data-index="23">Control</a>, EditPaste, This text will be inserted at the caret position., ControlName, WinTitle
```

```
<a href="ControlSetText.htm" data-index="24">ControlSetText</a>, ControlName, This text will entirely replace any current text., WinTitle
```

ControlSend is generally not capable of manipulating a window's menu bar. To work around this, use [WinMenuSelectItem](WinMenuSelectItem.htm). If that is not possible due to the nature of the menu bar, you could try to discover the message that corresponds to the desired menu item by following the [SendMessage Tutorial](../misc/SendMessage.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[SetKeyDelay](SetKeyDelay.htm), [Escape sequences (e.g. \`%)](../misc/EscapeChar.htm), [Control](Control.htm), [ControlGet](ControlGet.htm), [ControlGetText](ControlGetText.htm), [ControlMove](ControlMove.htm), [ControlGetPos](ControlGetPos.htm), [ControlClick](ControlClick.htm), [ControlSetText](ControlSetText.htm), [ControlFocus](ControlFocus.htm), [Send](Send.htm), [Automating Winamp](../misc/Winamp.htm)

## Examples

Opens Notepad minimized and send it some text. This example may fail on Windows 11 systems, as it requires the classic version of Notepad.

```
Run, Notepad,, Min, PID  <em>; Run Notepad minimized.</em>
WinWait, ahk_pid %PID%  <em>; Wait for it to appear.</em>
<em>; Send the text to the inactive Notepad edit control.
; The third parameter is omitted so the last found window is used.</em>
ControlSend, Edit1, This is a line of text in the notepad window.{Enter}
ControlSendRaw, Edit1, Notice that {Enter} is not sent as an Enter keystroke with ControlSendRaw.

MsgBox, Press OK to activate the window to see the result.
WinActivate, ahk_pid %PID%  <em>; Show the result.</em>
```

Opens the command prompt and sent it some text.

```
SetTitleMatchMode, 2
Run, %A_ComSpec%,,, PID  <em>; Run command prompt.</em>
WinWait, ahk_pid %PID%  <em>; Wait for it to appear.</em>
ControlSend,, ipconfig{Enter}, cmd.exe  <em>; Send directly to the command prompt window.</em>
```

