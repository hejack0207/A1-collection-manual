# \#If [AHK\_L 4+]

Creates context-sensitive [hotkeys](../Hotkeys.htm) and [hotstrings](../Hotstrings.htm). Such hotkeys perform a different action (or none at all) depending on the result of an expression.

```
<span class="func">#If</span> <span class="optional">Expression</span>
```

## Parameters

Expression

Any valid [expression](../Variables.htm#Expressions).

## Basic Operation

Any valid expression may be used to define the context in which a hotkey should be active. For example:

```
#If WinActive("ahk_class Notepad") or WinActive(MyWindowTitle)
#Space::MsgBox You pressed Win+Spacebar in Notepad or %MyWindowTitle%.
```

Like the #IfWin directives, #If is positional: it affects all hotkeys and hotstrings physically beneath it in the script. #If and #IfWin are also mutually exclusive; that is, only the most recent #If or #IfWin will be in effect.

To turn off context sensitivity, specify #If or any #IfWin directive but omit all the parameters. For example:

```
#If
```

Like other directives, #If cannot be executed conditionally.

## General Remarks

When the key, mouse or joystick button combination which forms a hotkey is pressed, the #If expression is evaluated to determine if the hotkey should activate.

**Note:** Scripts should not assume that the expression is only evaluated when the key is pressed (see below).

The expression may also be evaluated whenever the program needs to know whether the hotkey is active. For example, the #If expression for a custom combination like `a & b::` might be evaluated when the prefix key ( `a` in this example) is pressed, to determine whether it should act as a custom modifier key.

**Note:** Use of #If in an unresponsive script may cause input lag or break hotkeys (see below).

There are several more caveats to the #If directive:

- Keyboard or mouse input is typically buffered (delayed) until expression evaluation completes or[times out](_IfTimeout.htm).
- Expression evaluation can only be performed by the script's main thread (at the OS level, not a[quasi-thread](../misc/Threads.htm)), not directly by the keyboard/mouse hook. If the script is busy or unresponsive, such as if a FileCopy is in progress, expression evaluation is delayed and may time out.
- If the[system-defined timeout](_IfTimeout.htm#LowLevelHooksTimeout) is reached, the system may stop notifying the script of keyboard or mouse input (see #IfTimeout for details).
- Sending keystrokes or mouse clicks while the expression is being evaluated (such as from a function which it calls) may cause complications and should be avoided.

[AHK\_L 53+]: [A\_ThisHotkey](../Variables.htm#ThisHotkey) and [A\_TimeSinceThisHotkey](../Variables.htm#TimeSinceThisHotkey) are set based on the hotkey for which the current #If expression is being evaluated.

[v1.0.95.00+]: [A\_PriorHotkey](../Variables.htm#PriorHotkey) and [A\_TimeSincePriorHotkey](../Variables.htm#TimeSincePriorHotkey) temporarily contain the previous values of the corresponding "This" variables.

## Related

Most behavioural properties of the [#IfWin](_IfWinActive.htm) directives also apply to #If.

[#IfTimeout](_IfTimeout.htm) may be used to override the default timeout value.

## Examples

Allows the volume to be adjusted by scrolling the mouse wheel over the taskbar.

```
#If MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send {Volume_Up}
WheelDown::Send {Volume_Down}

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}

```

Simple word-delete shortcuts for all Edit controls.

```
#If ActiveControlIsOfClass("Edit")
^BS::Send ^+{Left}{Del}
^Del::Send ^+{Right}{Del}

ActiveControlIsOfClass(Class) {
    ControlGetFocus, FocusedControl, A
    ControlGet, FocusedControlHwnd, Hwnd,, %FocusedControl%, A
    WinGetClass, FocusedControlClass, ahk_id %FocusedControlHwnd%
    return (FocusedControlClass=Class)
}

```

Context-insensitive Hotkey.

```
#If
Esc::ExitApp

```

Dynamic Hotkeys. This example should be combined with [example #1](#ExVolume) before running it.

```
NumpadAdd::
Hotkey, If, MouseIsOver("ahk_class Shell_TrayWnd")
if (doubleup := !doubleup)
    Hotkey, WheelUp, DoubleUp
else
    Hotkey, WheelUp, WheelUp
return

DoubleUp:
Send {Volume_Up 2}
return

```

