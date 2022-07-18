# StatusBarGetText

Retrieves the text from a standard status bar control.

```
<span class="func">StatusBarGetText</span>, OutputVar <span class="optional">, Part#, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved text.

Part#

Which part number of the bar to retrieve, which can be an [expression](../Variables.htm#Expressions). Default 1, which is usually the part that contains the text of interest.

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

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there is a problem or 0 otherwise. If there was a problem, _OutputVar_ is also made blank.

## Remarks

This command attempts to read the first _standard_ status bar on a window (Microsoft common control: msctls\_statusbar32). Some programs use their own status bars or special versions of the MS common control, in which case the text cannot be retrieved.

Rather than using this command in a loop, it is usually more efficient to use [StatusBarWait](StatusBarWait.htm), which contains optimizations that avoid the overhead of repeated calls to StatusBarGetText.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[StatusBarWait](StatusBarWait.htm), [WinGetTitle](WinGetTitle.htm), [WinGetText](WinGetText.htm), [ControlGetText](ControlGetText.htm)

## Examples

Retrieves and analyzes the text from the first part of a status bar.

```
StatusBarGetText, RetrievedText, 1, Search Results
if InStr(RetrievedText, "found")
    MsgBox, Search results have been found.
```

