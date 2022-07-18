# OnExit() / OnExit

Specifies a [callback function](../Functions.htm) or [subroutine](Gosub.htm) to run automatically when the script exits.

## OnExit() [v1.1.20+]

```
<span class="func">OnExit</span>(Func <span class="optional">, AddRemove</span>)
```

### Parameters

Func

A function name or [function object](../objects/Functor.htm) to call when the script is exiting. The function can optionally define parameters as shown below. If an OnExit function returns a non-zero integer, the script does not exit (with some [rare exceptions](#close)) and no more functions are called. Otherwise, the script exits after all registered functions are called.

```
<span class="func">ExitFunc</span>(<a href="#ExitReason" data-index="5">ExitReason</a>, <a href="ExitApp.htm" data-index="6">ExitCode</a>)
```

AddRemove

If blank or omitted, it defaults to 1 (call the function after any previously registered functions). Otherwise, specify one of the following numbers:

- 1 = Call the function after any previously registered functions.
- -1 = Call the function before any previously registered functions.
- 0 = Do not call the function.

If a label (subroutine) has been registered, it is always called first.

### Remarks

New scripts should use a function instead of a subroutine -- this reduces the risk of accidentally creating a script which can't be exited, and ensures that the exit code passed to Exit or ExitApp is preserved.

Any number of OnExit functions can be registered. If a label (subroutine) is also registered, the functions are called after the subroutine calls [ExitApp](ExitApp.htm). An OnExit function usually should not call ExitApp; if it does, the script terminates immediately.

## OnExit

**Deprecated:** This command is not recommended for use in new scripts. Use the [OnExit](#function) function instead.

```
<span class="func">OnExit</span> <span class="optional">, Label</span>
```

### Parameters

Label

If omitted, any previously registered label is unregistered. Otherwise, specify the name of the [label](../misc/Labels.htm) whose contents will be executed (as a new [thread](../misc/Threads.htm)) when the script exits by any means.

### Remarks

**IMPORTANT:** Since the specified subroutine is called instead of terminating the script, that subroutine must use the [ExitApp](ExitApp.htm) command if termination is desired.

The built-in variable **A\_ExitReason** is blank unless the OnExit subroutine is currently running or has been called at least once by a prior exit attempt. If not blank, it is one of the words from the [table below](#ExitReason).

## Remarks

The OnExit callback function or subroutine is called when the script exits by any means (except when it is killed by something like "End Task"). It is also called whenever the [#SingleInstance](_SingleInstance.htm) and [Reload](Reload.htm) commands ask a previous instance to terminate.

A script can detect and optionally abort a system shutdown or logoff via `OnMessage(0x0011, "WM_QUERYENDSESSION")` (see [OnMessage example #2](OnMessage.htm#shutdown) for a working script).

The OnExit [thread](../misc/Threads.htm) does not obey [#MaxThreads](_MaxThreads.htm) (it will always launch when needed). In addition, while it is running, it cannot be interrupted by any [thread](../misc/Threads.htm), including [hotkeys](../Hotkeys.htm), [custom menu items](Menu.htm), and [timed subroutines](SetTimer.htm). However, it will be interrupted (and the script will terminate) if the user chooses Exit from the tray menu or main menu, or the script is asked to terminate as a result of [Reload](Reload.htm) or [#SingleInstance](_SingleInstance.htm). Because of this, the OnExit callback function or subroutine should be designed to finish quickly unless the user is aware of what it is doing.

If the OnExit [thread](../misc/Threads.htm) encounters a failure condition such as a runtime error, the script will terminate. This prevents a flawed OnExit callback function or subroutine from making a script impossible to terminate.

If the OnExit [thread](../misc/Threads.htm) was launched due to an [Exit](Exit.htm) or [ExitApp](ExitApp.htm) command that specified an exit code, in [v1.1.19] and earlier that code is ignored and no longer available. In [v1.1.20+] the initial exit code is used unless overridden by calling [ExitApp](ExitApp.htm) with a new exit code.

Whenever an exit attempt is made, each OnExit callback function or subroutine starts off fresh with the default values for settings such as [SendMode](SendMode.htm). These defaults can be changed in the [auto-execute section](../Scripts.htm#auto).

## Exit Reasons

ReasonDescriptionLogoffThe user is logging off.ShutdownThe system is being shut down or restarted, such as by the [Shutdown](Shutdown.htm) command.Close

The script was sent a WM\_CLOSE or WM\_QUIT message, had a critical error, or is being closed in some other way. Although all of these are unusual, WM\_CLOSE might be caused by [WinClose](WinClose.htm) having been used on the script's main window. To close (hide) the window without terminating the script, use [WinHide](WinHide.htm).

If the script is exiting due to a critical error or its [main window](../Program.htm#main-window) being destroyed, it will unconditionally terminate after the OnExit thread completes.

If the main window is being destroyed, it may still exist but cannot be displayed. This condition can be detected by monitoring the WM\_DESTROY message with [OnMessage()](OnMessage.htm).

ErrorA runtime error occurred in a script that has no hotkeys and that is not [persistent](_Persistent.htm). An example of a runtime error is [Run/RunWait](Run.htm) being unable to launch the specified program or document.MenuThe user selected Exit from the main window's menu or from the standard tray menu.ExitThe [Exit](Exit.htm) or [ExitApp](ExitApp.htm) command was used (includes [custom menu items](Menu.htm)).ReloadThe script is being reloaded via the [Reload](Reload.htm) command or menu item.SingleThe script is being replaced by a new instance of itself as a result of [#SingleInstance](_SingleInstance.htm).

## Related

[OnError()](OnError.htm), [OnMessage()](OnMessage.htm), [RegisterCallback()](RegisterCallback.htm), [OnClipboardChange()](OnClipboardChange.htm#function), [OnClipboardChange Label](OnClipboardChange.htm#label), [ExitApp](ExitApp.htm), [Shutdown](Shutdown.htm), [#Persistent](_Persistent.htm), [Threads](../misc/Threads.htm), [Gosub](Gosub.htm), [Return](Return.htm), [Menu](Menu.htm)

## Examples

Function vs. command.

Despite the different approach, both examples have the same effect; that is, they ask the user before exiting the script. To test them, right-click the tray icon and click Exit.

```
<a href="_Persistent.htm" data-index="56">#Persistent</a>  <em>; Prevent the script from exiting automatically.</em>
OnExit("ExitFunc")

ExitFunc(ExitReason, ExitCode)
{
    if ExitReason not in Logoff,Shutdown
    {
        MsgBox, 4, , Are you sure you want to exit?
        IfMsgBox, No
            return 1  <em>; OnExit functions must return non-zero to prevent exit.</em>
    }
    <em>; Do not call ExitApp -- that would prevent other OnExit functions from being called.</em>
}
```

```
<a href="_Persistent.htm" data-index="57">#Persistent</a>  <em>; Prevent the script from exiting automatically.</em>
OnExit, ExitSub
return

ExitSub:
if A_ExitReason not in Logoff,Shutdown  <em>; Avoid spaces around the comma in this line.</em>
{
    MsgBox, 4, , Are you sure you want to exit?
    IfMsgBox, No
        return
}
ExitApp  <em>; A script with an OnExit subroutine will not terminate unless the subroutine uses ExitApp.</em>
```

Registers an object to be called on exit.

```
<a href="_Persistent.htm" data-index="59">#Persistent</a>  <em>; Prevent the script from exiting automatically.</em>
OnExit(<a href="ObjBindMethod.htm" data-index="60">ObjBindMethod</a>(MyObject, "Exiting"))

class MyObject
{
    Exiting()
    {
        MsgBox, MyObject is cleaning up prior to exiting...
        <em>/*
        this.SayGoodbye()
        this.CloseNetworkConnections()
        */</em>
    }
}
```

