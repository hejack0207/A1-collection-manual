# DetectHiddenText

Determines whether invisible text in a window is "seen" for the purpose of finding the window. This affects commands, built-in functions and control flow statements such as WinExist() and WinActivate.

```
<span class="func">DetectHiddenText</span>, OnOff
```

## Parameters

OnOff

**On**: This is the default. Hidden text will be detected.

**Off**: Hidden text is not detected.

[v1.1.30+]: The decimal values 1 and 0 may be used in place of On and Off, respectively.

## Remarks

"Hidden text" is a term that refers to those controls of a window that are not visible. Their text is thus considered "hidden". Turning off DetectHiddenText can be useful in cases where you want to detect the difference between the different panes of a multi-pane window or multi-tabbed dialog. Use Window Spy to determine which text of the currently-active window is hidden. All commands, built-in functions and control flow statements that accept a _WinText_ parameter are affected by this setting, including [WinActivate](WinActivate.htm), [WinActive()](WinActive.htm), [IfWinActive](IfWinActive.htm), [WinWait](WinWait.htm), [WinExist()](WinExist.htm), and [IfWinExist](IfWinExist.htm).

The built-in variable **A\_DetectHiddenText** contains the current setting (On or Off).

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[DetectHiddenWindows](DetectHiddenWindows.htm)

## Examples

Turns off the detection of hidden text.

```
DetectHiddenText, Off
```

