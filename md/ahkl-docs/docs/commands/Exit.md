# Exit

Exits the [current thread](../misc/Threads.htm) or (if the script is not [persistent](_Persistent.htm)) the entire script.

```
<span class="func">Exit</span> <span class="optional">, ExitCode</span>
```

## Parameters

ExitCode

An integer between -2147483648 and 2147483647 (can be an [expression](../Variables.htm#Expressions)) that is returned to its caller when the script exits. This code is accessible to any program that spawned the script, such as another script (via RunWait) or a batch (.bat) file. If omitted, _ExitCode_ defaults to zero. Zero is traditionally used to indicate success.

## Remarks

If the script is not [persistent](_Persistent.htm), Exit will attempt to terminate the entire script as though [ExitApp](ExitApp.htm) was called.

If the script is not terminated, the Exit command terminates the [current thread](../misc/Threads.htm). In other words, the stack of subroutines called directly or indirectly by a [menu](Menu.htm), [timer](SetTimer.htm), or [hotkey](../Hotkeys.htm) subroutine will all be returned from as though a [Return](Return.htm) were immediately encountered in each. If used directly inside such a subroutine -- rather than in one of the subroutines called indirectly by it -- Exit is equivalent to [Return](Return.htm).

Use [ExitApp](ExitApp.htm) to completely terminate a script that is [persistent](_Persistent.htm).

## Related

[ExitApp](ExitApp.htm), [OnExit()](OnExit.htm#function), [OnExit](OnExit.htm#command), [Functions](../Functions.htm), [Gosub](Gosub.htm), [Return](Return.htm), [Threads](../misc/Threads.htm), [#Persistent](_Persistent.htm)

## Examples

In this example, the Exit command terminates the Sub2 subroutine as well as the calling subroutine.

```
#z::
Gosub, Sub2
MsgBox, This MsgBox will never happen because of the EXIT.
return

Sub2:
Exit  <em>; Terminate this subroutine as well as the calling subroutine.</em>
```

