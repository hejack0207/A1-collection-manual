# DetectHiddenWindows

Determines whether invisible windows are "seen" by the script.

```
<span class="func">DetectHiddenWindows</span>, OnOff
```

## Parameters

OnOff

**On**: Hidden windows are detected.

**Off**: This is the default. Hidden windows are not detected, except by the [WinShow](WinShow.htm) command.

[v1.1.30+]: The decimal values 1 and 0 may be used in place of On and Off, respectively.

## Remarks

Turning on DetectHiddenWindows can make scripting harder in some cases since some hidden system windows might accidentally match the title or text of another window you're trying to work with. So most scripts should leave this setting turned off. However, turning it on may be useful if you wish to work with hidden windows directly without first using [WinShow](WinShow.htm) to unhide them.

All windowing commands, built-in functions and control flow statements except [WinShow](WinShow.htm) are affected by this setting, including [WinActivate](WinActivate.htm), [WinActive()](WinActive.htm), [IfWinActive](IfWinActive.htm), [WinWait](WinWait.htm), [WinExist()](WinExist.htm), [IfWinExist](IfWinExist.htm). By contrast, [WinShow](WinShow.htm) will always unhide a hidden window even if hidden windows are not being detected.

Turning on DetectHiddenWindows is not necessary when accessing a control or child window via the [ahk\_id method](../misc/WinTitle.htm#ahk_id) or as the [last-found-window](../misc/WinTitle.htm#LastFoundWindow). It is also not necessary when accessing GUI windows via `Gui +<a href="Gui.htm#LastFound" data-index="13">LastFound</a>`.

[v1.1.32+]: Cloaked windows are also considered hidden. Cloaked windows, introduced with Windows 8, are windows on a non-active virtual desktop or UWP apps which have been suspended to improve performance, or more precisely to reduce their memory consumption. On Windows 10, the processes of those are indicated with a green leaf in the Task Manager. Such windows are hidden from view, but might still have the WS\_VISIBLE window style. Prior to v1.1.32, all windows with the WS\_VISIBLE style were considered visible.

The built-in variable **A\_DetectHiddenWindows** contains the current setting (On or Off).

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[DetectHiddenText](DetectHiddenText.htm)

## Examples

Turns on the detection of hidden windows.

```
DetectHiddenWindows, On
```

