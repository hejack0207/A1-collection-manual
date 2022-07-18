# WinSetTitle

Changes the title of the specified window.

```
<span class="func">WinSetTitle</span>, NewTitle
<span class="func">WinSetTitle</span>, WinTitle, WinText, NewTitle <span class="optional">, ExcludeTitle, ExcludeText</span>

```

## Parameters

NewTitle

The new title for the window. If this is the only parameter given, the [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) will be used.

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

A change to a window's title might be merely temporary if the application that owns the window frequently changes the title.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinMove](WinMove.htm), [WinGetActiveStats](WinGetActiveStats.htm), [WinGetActiveTitle](WinGetActiveTitle.htm), [WinGetText](WinGetText.htm), [ControlGetText](ControlGetText.htm), [WinGetPos](WinGetPos.htm), [WinSet](WinSet.htm)

## Examples

Changes the title of Notepad.

```
WinSetTitle, Untitled - Notepad, , This is a new title
```

Opens Notepad, waits until it is active and changes its title.

```
Run, notepad.exe
WinWaitActive, Untitled - Notepad
WinSetTitle, This is a new title <em>; Use the window found by WinWaitActive.</em>
```

