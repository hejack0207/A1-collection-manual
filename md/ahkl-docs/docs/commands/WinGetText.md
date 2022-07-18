# WinGetText

Retrieves the text from the specified window.

```
<span class="func">WinGetText</span>, OutputVar <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved text.

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

If there is no matching window, _OutputVar_ is made blank.

The text retrieved is generally the same as what Window Spy shows for that window. However, if [DetectHiddenText](DetectHiddenText.htm) has been turned off, hidden text is omitted from _OutputVar_.

Each text element ends with a carriage return and linefeed (CR+LF), which can be represented in the script as \`r\`n. To extract individual lines or substrings, use commands or built-in functions such as [InStr()](InStr.htm) and [SubStr()](SubStr.htm). A [parsing loop](LoopParse.htm) can also be used to examine each line or word one by one.

If the retrieved text appears to be truncated (incomplete), try using `<a href="VarSetCapacity.htm" data-index="9">VarSetCapacity</a>(OutputVar, 55)` prior to WinGetText [replace 55 with a size that is considerably longer than the truncated text]. This is necessary because some applications do not respond properly to the WM\_GETTEXTLENGTH message, which causes AutoHotkey to make the output variable too small to fit all the text.

The amount of text retrieved is limited to a variable's maximum capacity (which can be changed via the [#MaxMem](_MaxMem.htm) directive). As a result, this command might use a large amount of RAM if the target window (e.g. an editor with a large document open) contains a large quantity of text. To avoid this, it might be possible to retrieve only portions of the window's text by using [ControlGetText](ControlGetText.htm) instead. In any case, a variable's memory can be freed later by assigning it to nothing, i.e. `OutputVar =`.

To retrieve a list of all controls in a window, follow this example: `<a href="WinGet.htm" data-index="12">WinGet</a>, OutputVar, ControlList, WinTitle`

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[ControlGetText](ControlGetText.htm), [WinGetActiveStats](WinGetActiveStats.htm), [WinGetActiveTitle](WinGetActiveTitle.htm), [WinGetTitle](WinGetTitle.htm), [WinGetPos](WinGetPos.htm), [#MaxMem](_MaxMem.htm)

## Examples

Opens the calculator, waits until it exists, and retrieves and reports its text.

```
Run, Calc.exe
WinWait, Calculator
WinGetText, text <em>; Use the window found by WinWait.</em>
MsgBox, The text is:`n%text%
```

