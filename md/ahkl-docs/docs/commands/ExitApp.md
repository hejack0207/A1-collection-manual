# ExitApp

Terminates the script.

```
<span class="func">ExitApp</span> <span class="optional">, ExitCode</span>
```

## Parameters

ExitCode

An integer between -2147483648 and 2147483647 (or [in v1.0.48.01+] an [expression](../Variables.htm#Expressions)) that is returned to its caller when the script exits. This code is accessible to any program that spawned the script, such as another script (via RunWait) or a batch (.bat) file. If omitted, _ExitCode_ defaults to zero. Zero is traditionally used to indicate success.

## Remarks

This is equivalent to choosing "Exit" from the script's tray menu or main menu.

Any [OnExit](OnExit.htm) function or subroutine which has been registered by the script will be called automatically, and may prevent the script from terminating. In such a case, the current [thread](../misc/Threads.htm) exits as if [Exit](Exit.htm) was called.

Terminating the script is not the same as exiting each thread. For instance, [Finally](Finally.htm) blocks are not executed and [\_\_Delete](../Objects.htm#Custom_NewDelete) is not called for objects contained by local variables.

## Related

[Exit](Exit.htm), [OnExit()](OnExit.htm#function), [OnExit](OnExit.htm#command), [#Persistent](_Persistent.htm)

## Examples

Press a hotkey to terminate the script.

```
#x::ExitApp  <em>; Win+X</em>
```

