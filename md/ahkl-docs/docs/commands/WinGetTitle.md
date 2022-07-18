# WinGetTitle

Retrieves the title of the specified window.

```
<span class="func">WinGetTitle</span>, OutputVar <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved title.

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

If there is no matching window, _OutputVar_ is made blank.

To discover the name of the window that the mouse is currently hovering over, use [MouseGetPos](MouseGetPos.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinGetActiveStats](WinGetActiveStats.htm), [WinGetActiveTitle](WinGetActiveTitle.htm), [WinGetClass](WinGetClass.htm), [WinGet](WinGet.htm), [WinGetText](WinGetText.htm), [ControlGetText](ControlGetText.htm), [WinGetPos](WinGetPos.htm)

## Examples

Retrieves and reports the title of the active window.

```
WinGetTitle, Title, A
MsgBox, The active window is "%Title%".
```

