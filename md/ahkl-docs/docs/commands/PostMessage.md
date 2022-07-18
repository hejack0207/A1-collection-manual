# PostMessage / SendMessage

Sends a message to a window or control (SendMessage additionally waits for acknowledgement).

```
<span class="func">PostMessage</span>, Msg <span class="optional">, wParam, lParam, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
<span class="func">SendMessage</span>, Msg <span class="optional">, wParam, lParam, Control, WinTitle, WinText, ExcludeTitle, ExcludeText, Timeout</span>

```

## Parameters

Msg

The message number to send, which can be an [expression](../Variables.htm#Expressions). See the [message list](../misc/SendMessageList.htm) to determine the number.

wParam

The first component of the message, which can be an [expression](../Variables.htm#Expressions). If blank or omitted, 0 will be sent.

lParam

The second component of the message, which can be an [expression](../Variables.htm#Expressions). If blank or omitted, 0 will be sent.

Control

If this parameter is blank or omitted, the message will be sent directly to the target window rather than one of its controls. Otherwise, this parameter can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm).

To operate upon a control's HWND (window handle), leave the _Control_ parameter blank and specify `ahk_id %ControlHwnd%` for the _WinTitle_ parameter (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off). The HWND of a control is typically retrieved via [ControlGet Hwnd](ControlGet.htm#Hwnd), [MouseGetPos](MouseGetPos.htm), or [DllCall()](DllCall.htm).

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

Timeout

[AHK\_L 42+]: The maximum number of milliseconds to wait for the target window to process the message. If omitted, it defaults to 5000 (milliseconds), which is also the default behaviour in older versions of AutoHotkey which did not support this parameter. If the message is not processed within this time, the command finishes and sets ErrorLevel to the word FAIL. This parameter can be an [expression](../Variables.htm#Expressions).

## ErrorLevel

[v1.1.04+]: These commands are able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

PostMessage: [ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem such as the target window or control not existing. Otherwise, it is set to 0.

SendMessage: [ErrorLevel](../misc/ErrorLevel.htm) is set to the word FAIL if there was a problem or the command timed out. Otherwise, it is set to the numeric result of the message, which might sometimes be a "reply" depending on the nature of the message and its target window.

The range of possible values depends on the target window and the version of AutoHotkey that is running. When using a 32-bit version of AutoHotkey, or if the target window is 32-bit, the result is a 32-bit unsigned integer between 0 and 4294967295. When using the 64-bit version of AutoHotkey with a 64-bit window, the result is a 64-bit signed integer between -9223372036854775808 and 9223372036854775807.

If the result is intended to be a 32-bit signed integer (a value from -2147483648 to 2147483648), it can be truncated to 32-bit and converted to a signed value as follows:

```
MsgReply := ErrorLevel << 32 >> 32
```

This conversion may be necessary even on AutoHotkey 64-bit, because results from 32-bit windows are zero-extended. For example, a result of -1 from a 32-bit window is seen as 0xFFFFFFFF on any version of AutoHotkey, whereas a result of -1 from a 64-bit window is seen as 0xFFFFFFFF on AutoHotkey 32-bit and -1 on AutoHotkey 64-bit.

## Remarks

These commands should be used with caution because sending a message to the wrong window (or sending an invalid message) might cause unexpected behavior or even crash the target application. This is because most applications are not designed to expect certain types of messages from external sources.

PostMessage places the message in the message queue associated with the target window. It does not wait for acknowledgement or reply. By contrast, SendMessage waits for the target window to process the message, up until the timeout period expires.

The _wParam_ and _lParam_ parameters should be integers. If AutoHotkey or the target window is 32-bit, only the low 32 bits are used; that is, the value should be between -2147483648 and 4294967295 (0xFFFFFFFF). If AutoHotkey and the target window are both 64-bit, any integer value [supported by AutoHotkey](../Variables.htm#cap) can be used. As with all integer values in AutoHotkey, a prefix of 0x indicates a hex value. For example, 0xFF is equivalent to 255.

A string may be sent via _wParam_ or _lParam_ by specifying the address of a variable. The following example uses the [address operator (&)](../Variables.htm#amp) to do this:

```
SendMessage, 0x000C, 0, <strong>&MyVar</strong>, ClassNN, WinTitle  <em>; 0x000C is WM_SETTEXT</em>
```

[v1.0.43.06+]: A string put into MyVar by the receiver of the message is properly recognized without the need for extra steps. However, this works only if the parameter's first character is an ampersand (&); for example, `5+&MyVar` would not work but `&MyVar` or `&MyVar+5` would work.

A quoted/literal string may also be sent as in the following working example (the & operator should not be used in this case):

```
Run Notepad
WinWait Untitled - Notepad
SendMessage, 0x000C, 0, "<strong>New Notepad Title</strong>"  <em>; 0x000C is WM_SETTEXT</em>
```

To send a message to all windows in the system, including those that are hidden or disabled, specify `ahk_id 0xFFFF` for _WinTitle_ (0xFFFF is HWND\_BROADCAST). This technique should be used only for messages intended to be broadcast, such as the following example:

```
SendMessage, 0x001A,,,, ahk_id 0xFFFF  <em>; 0x001A is WM_SETTINGCHANGE</em>
```

To have a script receive a message, use [OnMessage()](OnMessage.htm).

See the [Message Tutorial](../misc/SendMessage.htm) for an introduction to using these commands.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[Message List](../misc/SendMessageList.htm), [Message Tutorial](../misc/SendMessage.htm), [OnMessage()](OnMessage.htm), [Automating Winamp](../misc/Winamp.htm), [DllCall()](DllCall.htm), [ControlSend](ControlSend.htm), [WinMenuSelectItem](WinMenuSelectItem.htm)

## Examples

Press a hotkey to turn off the monitor.

```
#o:: <em>; Win+O</em>
Sleep 1000  <em>; Give user a chance to release keys (in case their release would wake up the monitor again).
; Turn Monitor Off:</em>
SendMessage, 0x0112, 0xF170, 2,, Program Manager  <em>; 0x0112 is WM_SYSCOMMAND, 0xF170 is SC_MONITORPOWER.
; Note for the above: Use -1 in place of 2 to turn the monitor on.
; Use 1 in place of 2 to activate the monitor's low-power mode.</em>
return
```

Starts the user's chosen screen saver.

```
SendMessage, 0x0112, 0xF140, 0,, Program Manager  <em>; 0x0112 is WM_SYSCOMMAND, and 0xF140 is SC_SCREENSAVE.</em>
```

Scrolls up by one line (for a control that has a vertical scroll bar).

```
ControlGetFocus, control, A
SendMessage, 0x0115, 0, 0, %control%, A
```

Scrolls down by one line (for a control that has a vertical scroll bar).

```
ControlGetFocus, control, A
SendMessage, 0x0115, 1, 0, %control%, A
```

Switches the active window's keyboard layout/language to English.

```
PostMessage, 0x0050, 0, 0x4090409,, A  <em>; 0x0050 is WM_INPUTLANGCHANGEREQUEST.</em>
```

Asks Winamp which track number is currently active (see [Automating Winamp](../misc/Winamp.htm) for more information).

```
SetTitleMatchMode, 2
SendMessage, 0x0400, 0, 120,, - Winamp
if (ErrorLevel != "FAIL")
{
    ErrorLevel++  <em>; Winamp's count starts at "0", so adjust by 1.</em>
    MsgBox, Track #%ErrorLevel% is active or playing.
}
```

Finds the process ID of an AHK script (an alternative to [WinGet PID](WinGet.htm)).

```
SetTitleMatchMode, 2
DetectHiddenWindows, On
SendMessage, 0x0044, 0x405, 0, , SomeOtherScript.ahk - AutoHotkey v
MsgBox %ErrorLevel% is the process id.
```

