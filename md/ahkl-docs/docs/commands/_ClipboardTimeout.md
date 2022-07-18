# \#ClipboardTimeout

Changes how long the script keeps trying to access the clipboard when the first attempt fails.

```
<span class="func">#ClipboardTimeout</span> Milliseconds
```

## Parameters

Milliseconds

The length of the interval in milliseconds. Specify -1 to have it keep trying indefinitely. Specify 0 to have it try only once. Scripts that do not contain this directive use a 1000 ms timeout.

## Remarks

Some applications keep the clipboard open for long periods of time, perhaps to write or read large amounts of data. In such cases, increasing this setting causes the script to wait longer before giving up and displaying an error message.

This settings applies to all [clipboard](../misc/Clipboard.htm) operations, the simplest of which are the following examples: `Var := Clipboard` and `Clipboard := "New Text"`.

Whenever the script is waiting for the clipboard to become available, new [threads](../misc/Threads.htm) cannot be launched and [timers](SetTimer.htm) will not run. However, if the user presses a [hotkey](../Hotkeys.htm), selects a [custom menu item](Menu.htm), or performs a [GUI action](Gui.htm) such as pressing a button, that event will be buffered until later; in other words, its subroutine will be performed after the clipboard finally becomes available.

This directive does **not** cause the reading of clipboard data to be reattempted if the first attempt fails. Prior to [v1.1.16], it did cause the script to wait until the timeout expired, but in doing so prevented any further data from being retrieved.

Like other directives, #ClipboardTimeout cannot be executed conditionally.

## Related

[Clipboard](../misc/Clipboard.htm), [Thread](Thread.htm)

## Examples

Causes the script to wait 2 seconds instead of 1 second before giving up accessing the clipboard and displaying an error message.

```
#ClipboardTimeout 2000
```

