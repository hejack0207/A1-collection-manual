# ListLines

Displays the script lines most recently executed.

```
<span class="func">ListLines</span> <span class="optional">, OnOff</span>
```

## Parameters

OnOff

If blank or omitted, the history of lines most recently executed is shown. [v1.0.48.01+]: An optional first parameter was added, which can be either On or Off. It affects only the behavior of the [current thread](../misc/Threads.htm) as follows:

**On**: Includes subsequently-executed lines in the history. This is the starting default for all scripts.

**Off**: Omits subsequently-executed lines from the history.

[v1.1.30+]: The decimal values 1 and 0 may be used in place of On and Off, respectively.

## Remarks

ListLines (with no parameter) is equivalent to selecting the "View->Lines most recently executed" menu item in the main window. It can help [debug a script](../Scripts.htm#debug).

`ListLines Off/On` can be used to selectively omit some lines from the history, which can help prevent the history from filling up too quickly (such as in a loop with many fast iterations). `ListLines Off` may also improve performance by a few percent.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

[v1.1.28+]: The built-in variable A\_ListLines contains 1 if ListLines is enabled and 0 otherwise.

On a related note, the built-in variables [A\_LineNumber](../Variables.htm#LineNumber) and [A\_LineFile](../Variables.htm#LineFile) contain the currently executing line number and the file name to which it belongs.

## Related

[KeyHistory](KeyHistory.htm), [ListHotkeys](ListHotkeys.htm), [ListVars](ListVars.htm)

## Examples

Displays the script lines most recently executed.

```
ListLines
```

Omits subsequently-executed lines from the history.

```
ListLines Off
```

