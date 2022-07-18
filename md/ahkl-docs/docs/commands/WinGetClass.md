# WinGetClass

Retrieves the specified window's class name.

```
<span class="func">WinGetClass</span>, OutputVar <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved class name.

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

Only the class name is retrieved (the prefix "ahk\_class" is not included in _OutputVar_).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinGet](WinGet.htm), [WinGetTitle](WinGetTitle.htm)

## Examples

Retrieves and reports the class name of the active window.

```
WinGetClass, class, A
MsgBox, The active window's class is "%class%".
```

