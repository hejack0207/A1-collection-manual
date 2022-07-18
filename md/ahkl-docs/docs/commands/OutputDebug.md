# OutputDebug

Sends a string to the debugger (if any) for display.

```
<span class="func">OutputDebug</span>, Text
```

## Parameters

Text

The text to send to the debugger for display. This text may include linefeed characters (\`n) to start new lines. In addition, a single long line can be broken up into several shorter ones by means of a [continuation section](../Scripts.htm#continuation).

## Remarks

If the script's process has no debugger, the system debugger displays the string. If the system debugger is not active, this command has no effect.

One example of a debugger is DebugView, which is free and available at [microsoft.com](https://docs.microsoft.com/en-us/sysinternals/downloads/debugview).

See also: [other debugging methods](../Scripts.htm#debug)

## Related

[FileAppend](FileAppend.htm), [continuation sections](../Scripts.htm#continuation)

## Examples

Sends a string to the debugger (if any) for display.

```
OutputDebug, %A_Now%: Because the window "%TargetWindowTitle%" did not exist, the process was aborted.
```

