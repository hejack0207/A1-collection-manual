# StatusBarWait

Waits until a window's status bar contains the specified string.

```
<span class="func">StatusBarWait</span> <span class="optional">, BarText, Timeout, Part#, WinTitle, WinText, Interval, ExcludeTitle, ExcludeText</span>
```

## Parameters

BarText

The text or partial text for the which the command will wait to appear. Default is blank (empty), which means to wait for the status bar to become blank. The text is case sensitive and the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm), similar to _WinTitle_ below.

To instead wait for the bar's text to _change_, either use [StatusBarGetText](StatusBarGetText.htm) in a loop, or use the RegEx example at the bottom of this page.

Timeout

The number of seconds (can contain a decimal point or be an [expression](../Variables.htm#Expressions)) to wait before timing out, in which case [ErrorLevel](../misc/ErrorLevel.htm) will be set to 1. Default is blank, which means the command will wait indefinitely. Specifying 0 is the same as specifying 0.5.

Part#

Which part number of the bar to retrieve, which can be an [expression](../Variables.htm#Expressions). Default 1, which is usually the part that contains the text of interest.

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

Interval

How often the status bar should be checked while the command is waiting (in milliseconds), which can be an [expression](../Variables.htm#Expressions). Default is 50.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Error Handling

[v1.1.04+]: This command is able to throw an exception if the status bar couldn't be accessed. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the command times out before a match could be found in the status bar. It is set to 2 if the status bar could not be accessed. It is set to 0 if a match is found.

## Remarks

StatusBarWait attempts to read the first _standard_ status bar on a window (class msctls\_statusbar32). Some programs use their own status bars or special versions of the MS common control. Such bars are not supported.

Rather than using [StatusBarGetText](StatusBarGetText.htm) in a loop, it is usually more efficient to use StatusBarWait because it contains optimizations that avoid the overhead that repeated calls to [StatusBarGetText](StatusBarGetText.htm) would incur.

StatusBarWait determines its target window before it begins waiting for a match. If that target window is closed, the command will stop waiting even if there is another window matching the specified _WinTitle_ and _WinText_.

While the command is in a waiting state, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[StatusBarGetText](StatusBarGetText.htm), [WinGetTitle](WinGetTitle.htm), [WinGetText](WinGetText.htm), [ControlGetText](ControlGetText.htm)

## Examples

Enters a new search pattern into an existing Explorer/Search window.

```
if WinExist("Search Results") <em>; Sets the Last Found window to simplify the below.</em>
{
    WinActivate
    Send, {tab 2}!o*.txt{enter}  <em>; In the Search window, enter the pattern to search for.</em>
    Sleep, 400  <em>; Give the status bar time to change to "Searching".</em>
    StatusBarWait, found, 30
    if ErrorLevel
        MsgBox, The command timed out or there was a problem.
    else
        MsgBox, The search successfully completed.
}
```

Waits for the status bar of the active window to **change**. This example requires [v1.0.46.06+].

```
SetTitleMatchMode RegEx  <em>; Accept <a href="SetTitleMatchMode.htm#RegEx" data-index="24">regular expressions</a> for use below.</em>
if WinExist("A")  <em>; Set the last-found window to be the active window (for use below).</em>
{
    StatusBarGetText, <span class="red">OrigText</span>
    StatusBarWait, ^(?!^\Q<span class="red">%OrigText%</span>\E$)  <em>; This regular expression waits for any change to the text.</em>
}
```

