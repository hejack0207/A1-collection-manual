# ClipWait

Waits until the [clipboard](../misc/Clipboard.htm) contains data.

```
<span class="func">ClipWait</span> <span class="optional">, Timeout, WaitForAnyData</span>
```

## Parameters

Timeout

If omitted, the command will wait indefinitely. Otherwise, it will wait no longer than this many seconds (can contain a decimal point or be an [expression](../Variables.htm#Expressions)). Specifying 0 is the same as specifying 0.5.

WaitForAnyData

If this parameter is omitted or 0 (false), the command is more selective, waiting specifically for text or files to appear ("text" includes anything that would produce text when you paste into Notepad). If this parameter is 1 (true) (can be an [expression](../Variables.htm#Expressions)), the command waits for data of any kind to appear on the clipboard.

## ErrorLevel

If the wait period expires, [ErrorLevel](../misc/ErrorLevel.htm) will be set to 1. Otherwise (i.e. the clipboard contains data), ErrorLevel is set to 0.

## Remarks

It's better to use this command than a loop of your own that checks to see if this clipboard is blank. This is because the clipboard is never opened by this command, and thus it performs better and avoids any chance of interfering with another application that may be using the clipboard.

This command considers anything convertible to text (e.g. HTML) to be text. It also considers files, such as those copied in an Explorer window via Ctrl+C, to be text. Such files are automatically converted to their filenames (with full path) whenever the clipboard variable (%clipboard%) is referred to in the script. See [Clipboard](../misc/Clipboard.htm) for details.

When 1 (true) is present as the last parameter, the command will be satisfied when any data appears on the clipboard. This can be used in conjunction with [ClipboardAll](../misc/Clipboard.htm#ClipboardAll) to save non-textual items such as pictures.

While the command is in a waiting state, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

To wait for a fraction of a second, specify a floating point value for the first parameter, for example, 0.25 to wait for a maximum of 250 milliseconds.

## Related

[Clipboard](../misc/Clipboard.htm), [WinWait](WinWait.htm), [KeyWait](KeyWait.htm)

## Examples

Empties the clipboard, copies the current selection into the clipboard and waits a maximum of 2 seconds until the clipboard contains data. If ClipWait times out, an error message is shown, otherwise the clipboard contents is shown.

```
Clipboard := "" <em>; Empty the clipboard</em>
Send, ^c
ClipWait, 2
if ErrorLevel
{
    MsgBox, The attempt to copy text onto the clipboard failed.
    return
}
MsgBox, clipboard = %Clipboard%
return
```

