# WinGetActiveTitle

Retrieves the title of the active window.

```
<span class="func">WinGetActiveTitle</span>, OutputVar
```

## Parameters

OutputVar

The name of the variable in which to store the title of the active window.

## Remarks

This command is equivalent to: `<a href="WinGetTitle.htm" data-index="1">WinGetTitle</a>, OutputVar, A`.

## Related

[WinGetPos](WinGetPos.htm), [WinGetActiveStats](WinGetActiveStats.htm), [WinGetTitle](WinGetTitle.htm), [WinGetClass](WinGetClass.htm), [WinGetText](WinGetText.htm), [ControlGetText](ControlGetText.htm)

## Examples

Retrieves and reports the title of the active window.

```
WinGetActiveTitle, Title
MsgBox, The active window is "%Title%".
```

