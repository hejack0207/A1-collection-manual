# \#IfTimeout [AHK\_L 8+]

Sets the maximum time that may be spent evaluating a single [#If](_If.htm) expression.

```
<span class="func">#IfTimeout</span> Timeout
```

## Parameters

Timeout

The timeout value to apply globally, in milliseconds.

## Remarks

A timeout is implemented to prevent long-running expressions from stalling keyboard input processing. If the timeout value is exceeded, the expression continues to evaluate, but the keyboard hook continues as if the expression had already returned false.

If this directive is unspecified in the script, it will behave as though set to 1000.

Note that the system implements its own timeout, defined by the DWORD value _LowLevelHooksTimeout_ in the following registry key:

**HKEY\_CURRENT\_USER\\Control Panel\\Desktop**

If the system timeout value is exceeded, the system may stop calling the script's keyboard hook, thereby preventing hook hotkeys from working until the hook is re-registered or the script is [reloaded](Reload.htm). The hook can _usually_ be re-registered by [suspending](Suspend.htm) and un-suspending all hotkeys.

Microsoft's documentation is unclear about the details of this timeout, but research indicates the following for Windows 7 and later: If _LowLevelHooksTimeout_ is not defined, the default timeout is 300ms. The hook may time out up to 10 times, but is silently removed if it times out an 11th time.

If a given hotkey has multiple #If variants, the timeout might be applied to each variant independently, making it more likely that the system timeout will be exceeded. This may be changed in a future update.

Like other directives, #IfTimeout cannot be executed conditionally.

## Related

[#If](_If.htm)

## Examples

Sets the #If timeout to 10 ms instead of 1000 ms.

```
#IfTimeout 10
```

