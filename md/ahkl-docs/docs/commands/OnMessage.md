# OnMessage()

Specifies a [function](../Functions.htm) or [function object](../objects/Functor.htm) to call automatically when the script receives the specified message.

```
<span class="func">OnMessage</span>(MsgNumber <span class="optional">, Function, MaxThreads</span>)
```

## Parameters

MsgNumber

The number of the message to monitor or query, which should be between 0 and 4294967295 (0xFFFFFFFF). If you do not wish to monitor a [system message](../misc/SendMessageList.htm) (that is, one below 0x0400), it is best to choose a number greater than 4096 (0x1000) to the extent you have a choice. This reduces the chance of interfering with messages used internally by current and future versions of AutoHotkey.

Function

A [function](../Functions.htm)'s name or, in [v1.1.20+], a [function object](../objects/Functor.htm). To pass a literal function name, it must be enclosed in quotes.

How the function is registered and the return value of OnMessage depend on whether this parameter is a string or a function object. See [Function Name vs Object](#Name_v_Object) for details.

MaxThreads [v1.0.47+]

This integer is normally omitted, in which case the monitor function is limited to one [thread](../misc/Threads.htm) at a time. This is usually best because otherwise, the script would process messages out of chronological order whenever the monitor function interrupts itself. Therefore, as an alternative to _MaxThreads_, consider using _Critical_ as described [below](#Critical).

If the monitor function directly or indirectly causes the message to be sent again while the function is still running, it is necessary to specify a _MaxThreads_ value greater than 1 or less than -1 to allow the monitor function to be called for the new message (if desired). Messages sent (not posted) by the script's own process to itself cannot be delayed or buffered.

[v1.1.20+]: Specify 0 to unregister a previously registered function. If _Function_ is a string, the "legacy" monitor is removed. Otherwise, only the given function object is unregistered.

[v1.1.20+]: By default, when multiple functions are registered for a single _MsgNumber_, they are called in the order that they were registered. To register a function to be called before any previously registered functions, specify a negative value for _MaxThreads_. For example, `OnMessage(Msg, Fn, -2)` registers `Fn` to be called before any other functions previously registered for _Msg_, and allows _Fn_ a maximum of 2 threads. However, if the function is already registered, the order will not change unless it is unregistered and then re-registered.

## Function Name vs Object

OnMessage's return value and behavior depends on whether the _Function_ parameter is a function name or an object.

### Function Name

For backward compatibility, at most one function can be registered by name to monitor each unique _MsgNumber_ \-\- this is referred to as the "legacy" monitor.

When the legacy monitor is first registered, whether it is called before or after previously registered monitors depends on the _MaxThreads_ parameter. Updating the monitor to call a different function does not affect the order unless the monitor is unregistered first.

This registers or updates the current legacy monitor for _MsgNumber_ (omit the quote marks if passing a variable):

```
Name := <span class="func">OnMessage</span>(MsgNumber, "FunctionName")
```

The return value is one of the following:

- An empty string on[failure](#Failure).
- The name of the previous function, if there was one.
- Otherwise, the name of the new function.

This unregisters the current legacy monitor for _MsgNumber_ (if any) and returns its name (blank if none):

```
Name := <span class="func">OnMessage</span>(MsgNumber, "")
```

This returns the name of the current legacy monitor for _MsgNumber_ (blank if none):

```
Name := <span class="func">OnMessage</span>(MsgNumber)
```

### Function Object

Any number of [function objects](../objects/Functor.htm) (including [normal functions](../objects/Func.htm)) can monitor a given _MsgNumber_.

Either of these two lines registers a function object to be called **after** any previously registered functions:

```
<span class="func">OnMessage</span>(MsgNumber, FuncObj)     <em>; Option 1</em>
<span class="func">OnMessage</span>(MsgNumber, FuncObj, 1)  <em>; Option 2 (MaxThreads = 1)</em>
```

This registers a function object to be called **before** any previously registered functions:

```
<span class="func">OnMessage</span>(MsgNumber, FuncObj, -1)
```

To unregister a function object, specify 0 for _MaxThreads_:

```
<span class="func">OnMessage</span>(MsgNumber, FuncObj, 0)
```

## Failure

Failure occurs when _Function_:

1. is not an object, the name of a user-defined function, or an empty string;
2. is known to require more than four parameters; or
3. in[v1.0.48.05] or older, has any [ByRef](../Functions.htm#ByRef) or [optional](../Functions.htm#optional) parameters.

In [v1.1.19.03] or older, failure also occurs if the script attempts to monitor a new message when there are already 500 messages being monitored.

If _Function_ is an object, an exception is thrown on failure. Otherwise, an empty string is returned.

## The Function's Parameters

A [function](../Functions.htm) assigned to monitor one or more messages can accept up to four parameters:

```
MyMessageMonitor(wParam, lParam, msg, hwnd)
{
    ... body of function...
}
```

Although the names you give the parameters do not matter, the following information is sequentially assigned to them:

- Parameter #1: The message's WPARAM value.
- Parameter #2: The message's LPARAM value.
- Parameter #3: The message number, which is useful in cases where a function monitors more than one message.
- Parameter #4: The HWND (unique ID) of the window or control to which the message was sent. The HWND can be used with[ahk\_id](../misc/WinTitle.htm#ahk_id).

WPARAM and LPARAM are unsigned 32-bit integers (from 0 to 232-1) or signed 64-bit integers (from -263 to 263-1) depending on whether the exe running the script is 32-bit or 64-bit. For 32-bit scripts, if an incoming parameter is intended to be a signed integer, any negative numbers can be revealed by following this example:

```
if (A_PtrSize = 4 && wParam > 0x7FFFFFFF)  <em>; Checking <a href="../Variables.htm#PtrSize" data-index="16">A_PtrSize</a> ensures the script is 32-bit.</em>
    wParam := -(~wParam) - 1
```

You can omit one or more parameters from the end of the list if the corresponding information is not needed. For example, a function defined as `MyMsgMonitor(wParam, lParam)` would receive only the first two parameters, and one defined as `MyMsgMonitor()` would receive none of them.

## Additional Information Available to the Function

In addition to the parameters received above, the function may also consult the values in the following built-in variables:

- [A\_Gui](../Variables.htm#Gui): Blank unless the message was sent to a GUI window or control, in which case A\_Gui is the [Gui Window number](Gui.htm#MultiWin) (this window is also set as the function's [default GUI window](Gui.htm#DefaultWin)).
- [A\_GuiControl](../Variables.htm#GuiControl): Blank unless the message was sent to a GUI control, in which case it contains the control's variable name or other value as described at [A\_GuiControl](../Variables.htm#GuiControl). Some controls never receive certain types of messages. For example, when the user clicks a [text control](GuiControls.htm#Text), the operating system sends WM\_LBUTTONDOWN to the parent window rather than the control; consequently, A\_GuiControl is blank.
- [A\_GuiX](../Variables.htm#GuiX) and [A\_GuiY](../Variables.htm#GuiY): Both contain -2147483648 if the incoming message was sent via [SendMessage](PostMessage.htm). If it was sent via [PostMessage](PostMessage.htm), they contain the mouse cursor's coordinates (relative to the screen) at the time the message was posted.
- [A\_EventInfo](../Variables.htm#EventInfo): Contains 0 if the message was sent via SendMessage. If sent via PostMessage, it contains the [tick-count time](../Variables.htm#TickCount) the message was posted.

A monitor function's [last found window](../misc/WinTitle.htm#LastFoundWindow) starts off as the parent window to which the message was sent (even if it was sent to a control). If the window is hidden but not a GUI window (such as the script's main window), turn on [DetectHiddenWindows](DetectHiddenWindows.htm) before using it. For example:

```
DetectHiddenWindows On
MsgParentWindow := WinExist()  <em>; This stores the unique ID of the window to which the message was sent.</em>
```

## What the Function Should _Return_

If a monitor function uses [Return](Return.htm) without any parameters, or it specifies a blank value such as "" (or it never uses Return at all), the incoming message goes on to be processed normally when the function finishes. The same thing happens if the function [Exits](Exit.htm) or causes a runtime error such as [running](Run.htm) a nonexistent file. By contrast, returning an integer causes it to be sent immediately as a reply; that is, the program does not process the message any further. For example, a function monitoring WM\_LBUTTONDOWN (0x0201) may return an integer to prevent the target window from being notified that a mouse click has occurred. In many cases (such as a message arriving via [PostMessage](PostMessage.htm)), it does not matter which integer is returned; but if in doubt, 0 is usually safest.

The range of valid return values depends on whether the exe running the script is 32-bit or 64-bit. Non-empty return values must be between -231 and 232-1 for 32-bit scripts ( `<a href="../Variables.htm#PtrSize" data-index="35">A_PtrSize</a> = 4`) and between -263 and 263-1 for 64-bit scripts ( `<a href="../Variables.htm#PtrSize" data-index="36">A_PtrSize</a> = 8`).

[v1.1.20+]: If there are multiple functions monitoring a given message number, they are called one by one until one returns a non-empty value.

## General Remarks

Unlike a normal function-call, the arrival of a monitored message calls the function as a new [thread](../misc/Threads.htm). Because of this, the function starts off fresh with the default values for settings such as [SendMode](SendMode.htm) and [DetectHiddenWindows](DetectHiddenWindows.htm). These defaults can be changed in the [auto-execute section](../Scripts.htm#auto).

Messages sent to a control (rather than being posted) are not monitored because the system routes them directly to the control behind the scenes. This is seldom an issue for system-generated messages because most of them are posted.

Any script that calls OnMessage anywhere is automatically [persistent](_Persistent.htm). It is also single-instance unless [#SingleInstance](_SingleInstance.htm) has been used to override that.

If a message arrives while its function is still running due to a previous arrival of the same message, by default the function will not be called again; instead, the message will be treated as unmonitored. If this is undesirable, there are multiple ways it can be avoided:

- If the message is posted rather than sent and has a number greater than 0x0311, it can be buffered until its function completes by specifying[Critical](Critical.htm) as the first line of the function. Alternatively, [Thread Interrupt](Thread.htm) can achieve the same effect as long as it lasts long enough for the function to finish.
- [v1.0.46+]: Using [Critical](Critical.htm) to increase the [message check interval](Critical.htm#Interval) gives the function more time to complete before any messages are dispatched. An interval greater than 16 may be needed for reliability. Due to the granularity of the system timer (usually 15.6 milliseconds), the default interval of 5 milliseconds (for non-Critical threads) or 15 milliseconds (for Critical threads) might appear to pass the instant after the function starts.
- Ensuring that the monitor function returns quickly reduces the risk that messages will be missed due to_MaxThreads_. One way to do this is to have it queue up a future thread by [posting](PostMessage.htm) to its own script a monitored message number greater than 0x0311. That message's function should use [Critical](Critical.htm) as its first line to ensure that its messages are buffered. Alternatively, a [timer](SetTimer.htm) can be used to queue up a future thread.
- Specifying a higher value for the[MaxThreads](#MaxThreads) parameter allows the function to be interrupted to process the newly-received message.

If a monitored message that is numerically greater than 0x0311 is posted while the script is [uninterruptible](../misc/Threads.htm#Interrupt), the message is buffered; that is, its function is not called until the script becomes interruptible. However, messages which are sent rather than posted cannot be buffered as they must provide a return value. Posted messages also might not be buffered when a modal message loop is running, such as for a system dialog, ListView drag-drop operation or menu.

When a monitored message arrives, if it is not buffered and the script is uninterruptible merely due to the settings of [Thread Interrupt](Thread.htm) or [Critical](Critical.htm), the current thread will be interrupted so that the function can be called. However, if the script is absolutely uninterruptible -- such as while a [menu](Menu.htm) is displayed, a [KeyDelay](SetKeyDelay.htm)/ [MouseDelay](SetMouseDelay.htm) is in progress, or the clipboard is being [opened](_ClipboardTimeout.htm) \-\- the message's function will not be called and the message will be treated as unmonitored.

The [priority](../misc/Threads.htm) of OnMessage threads is always 0. Consequently, no messages are monitored or buffered when the current thread's priority is higher than 0.

Caution should be used when monitoring system messages (those below 0x0400). For example, if a monitor function does not finish quickly, the response to the message might take longer than the system expects, which might cause side-effects. Unwanted behavior may also occur if a monitor function returns an integer to suppress further processing of a message, but the system expected different processing or a different response.

When the script is displaying a system dialog such as [MsgBox](MsgBox.htm), any message posted to a control is not monitored. For example, if the script is displaying a message box and the user clicks a button in a GUI window, the WM\_LBUTTONDOWN message is sent directly to the button without calling the monitor function.

Although an external program may post messages directly to a script's thread via PostThreadMessage() or other API call, this is not recommended because the messages would be lost if the script is displaying a system window such as a [message box](MsgBox.htm). Instead, it is usually best to post or send the messages to the script's main window or one of its GUI windows.

## Related

[RegisterCallback()](RegisterCallback.htm), [OnExit()](OnExit.htm#function), [OnExit](OnExit.htm#command), [OnClipboardChange()](OnClipboardChange.htm#function), [OnClipboardChange Label](OnClipboardChange.htm#label), [Post/SendMessage](PostMessage.htm), [Functions](../Functions.htm), [List of Windows Messages](../misc/SendMessageList.htm), [Threads](../misc/Threads.htm), [Critical](Critical.htm), [DllCall()](DllCall.htm)

## Examples

Monitors mouse clicks in a GUI window. Related topic: [GuiContextMenu](Gui.htm#GuiContextMenu)

```
Gui, Add, Text,, Click anywhere in this window.
Gui, Add, Edit, w200 vMyEdit
Gui, Show
OnMessage(0x0201, "WM_LBUTTONDOWN")
return

WM_LBUTTONDOWN(wParam, lParam)
{
    X := lParam & 0xFFFF
    Y := lParam >> 16
    if A_GuiControl
        Ctrl := "`n(in control " . A_GuiControl . ")"
    ToolTip You left-clicked in Gui window #%A_Gui% at client coordinates %X%x%Y%.%Ctrl%
}

GuiClose:
ExitApp
```

Detects system shutdown/logoff and allows the user to abort it. On Windows Vista and later, the system displays a user interface showing which program is blocking shutdown/logoff and allowing the user to force shutdown/logoff. On older OSes, the script displays a confirmation prompt. Related topic: [OnExit](OnExit.htm)

```
<em>; The following DllCall is optional: it tells the OS to shut down this script first (prior to all other applications).</em>
DllCall("kernel32.dll\SetProcessShutdownParameters", "UInt", 0x4FF, "UInt", 0)
OnMessage(0x0011, "WM_QUERYENDSESSION")
return

WM_QUERYENDSESSION(wParam, lParam)
{
    ENDSESSION_LOGOFF := 0x80000000
    if (lParam & ENDSESSION_LOGOFF)  <em>; User is logging off.</em>
        EventType := "Logoff"
    else  <em>; System is either shutting down or restarting.</em>
        EventType := "Shutdown"
    try
    {
        <em>; Set a prompt for the OS shutdown UI to display.  We do not display
        ; our own confirmation prompt because we have only 5 seconds before
        ; the OS displays the shutdown UI anyway.  Also, a program without
        ; a visible window cannot block shutdown without providing a reason.</em>
        BlockShutdown("Example script attempting to prevent " EventType ".")
        return false
    }
    catch
    {
        <em>; ShutdownBlockReasonCreate is not available, so this is probably
        ; Windows XP, 2003 or 2000, where we can actually prevent shutdown.</em>
        MsgBox, 4,, %EventType% in progress.  Allow it?
        IfMsgBox Yes
            return true  <em>; Tell the OS to allow the shutdown/logoff to continue.</em>
        else
            return false  <em>; Tell the OS to abort the shutdown/logoff.</em>
    }
}

BlockShutdown(Reason)
{
    <em>; If your script has a visible GUI, use it instead of A_ScriptHwnd.</em>
    DllCall("ShutdownBlockReasonCreate", "ptr", A_ScriptHwnd, "wstr", Reason)
    OnExit("StopBlockingShutdown")
}

StopBlockingShutdown()
{
    OnExit(A_ThisFunc, 0)
    DllCall("ShutdownBlockReasonDestroy", "ptr", A_ScriptHwnd)
}
```

Receives a custom message and up to two numbers from some other script or program (to send strings rather than numbers, see the example after this one).

```
OnMessage(0x5555, "MsgMonitor")
OnMessage(0x5556, "MsgMonitor")

MsgMonitor(wParam, lParam, msg)
{
    <em>; Since returning quickly is often important, it is better to use ToolTip than</em>
    <em>; something like MsgBox that would prevent the function from finishing:</em>
    ToolTip Message %msg% arrived:`nWPARAM: %wParam%`nLPARAM: %lParam%
}

<em>; The following could be used inside some other script to run the function inside the above script:</em>
SetTitleMatchMode 2
DetectHiddenWindows On
if WinExist("Name of Receiving Script.ahk ahk_class AutoHotkey")
    PostMessage, 0x5555, 11, 22  <em>; The message is sent  to the "<a href="../misc/WinTitle.htm#LastFoundWindow" data-index="77">last found window</a>" due to WinExist() above.</em>
DetectHiddenWindows Off  <em>; Must not be turned off until after PostMessage.</em>
```

Sends a string of any length from one script to another. To use this, save and run both of the following scripts then press Win+Space to show an input box that will prompt you to type in a string. Both scripts must use the same [native encoding](../Concepts.htm#native-encoding).

Save the following script as **Receiver.ahk** then launch it.

```
#SingleInstance
OnMessage(0x004A, "Receive_WM_COPYDATA")  <em>; 0x004A is WM_COPYDATA</em>
return

Receive_WM_COPYDATA(wParam, lParam)
{
    StringAddress := NumGet(lParam + 2*A_PtrSize)  <em>; Retrieves the CopyDataStruct's lpData member.</em>
    CopyOfData := StrGet(StringAddress)  <em>; Copy the string out of the structure.</em>
    <em>; Show it with ToolTip vs. MsgBox so we can return in a timely fashion:</em>
    ToolTip %A_ScriptName%`nReceived the following string:`n%CopyOfData%
    return true  <em>; Returning 1 (true) is the traditional way to acknowledge this message.</em>
}
```

Save the following script as **Sender.ahk** then launch it. After that, press the Win+Space hotkey.

```
TargetScriptTitle := "Receiver.ahk ahk_class AutoHotkey"

#space::  <em>; Win+Space hotkey. Press it to show an input box for entry of a message string.</em>
InputBox, StringToSend, Send text via WM_COPYDATA, Enter some text to Send:
if ErrorLevel  <em>; User pressed the Cancel button.</em>
    return
result := Send_WM_COPYDATA(StringToSend, TargetScriptTitle)
if (result = "FAIL")
    MsgBox SendMessage failed. Does the following WinTitle exist?:`n%TargetScriptTitle%
else if (result = 0)
    MsgBox Message sent but the target window responded with 0, which may mean it ignored it.
return

Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)  <em>; ByRef saves a little memory in this case.
; This function sends the specified string to the specified window and returns the reply.
; The reply is 1 if the target window processed the message, or 0 if it ignored it.</em>
{
    VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  <em>; Set up the structure's memory area.</em>
    <em>; First set the structure's cbData member to the size of the string, including its zero terminator:</em>
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)  <em>; OS requires that this be done.</em>
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)  <em>; Set lpData to point to the string itself.</em>
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    TimeOutTime := 4000  <em>; Optional. Milliseconds to wait for response from receiver.ahk. Default is 5000</em>
    <em>; Must use SendMessage not PostMessage.</em>
    SendMessage, 0x004A, 0, &CopyDataStruct,, %TargetScriptTitle%,,,, %TimeOutTime% <em>; 0x004A is WM_COPYDATA.</em>
    DetectHiddenWindows %Prev_DetectHiddenWindows%  <em>; Restore original setting for the caller.</em>
    SetTitleMatchMode %Prev_TitleMatchMode%         <em>; Same.</em>
    return ErrorLevel  <em>; Return SendMessage's reply back to our caller.</em>
}
```

See the [WinLIRC client script](../scripts/index.htm#WinLIRC) for a demonstration of how to use OnMessage() to receive notification when data has arrived on a network connection.

