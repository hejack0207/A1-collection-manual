# \#IfWinActive / \#IfWinNotActive / \#IfWinExist / \#IfWinNotExist

Creates context-sensitive [hotkeys](../Hotkeys.htm) and [hotstrings](../Hotstrings.htm). Such hotkeys perform a different action (or none at all) depending on the type of window that is active or exists.

```
<span class="func">#IfWinActive</span> <span class="optional">WinTitle, WinText</span>
<span class="func">#IfWinExist</span> <span class="optional">WinTitle, WinText</span>
<span class="func">#IfWinNotActive</span> <span class="optional">WinTitle, WinText</span>
<span class="func">#IfWinNotExist</span> <span class="optional">WinTitle, WinText</span>
<a href="_If.htm" data-index="3">#If <span class="optional">, Expression</span></a>

```

## Parameters

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

Title matching behaviour is determined by [SetTitleMatchMode](SetTitleMatchMode.htm) as set in the [auto-execute section](../Scripts.htm#auto).

As with most other directives, variables are not supported. Although [ahk\_pid](../misc/WinTitle.htm#ahk_pid) and [ahk\_id](../misc/WinTitle.htm#ahk_id) can be used with a hard-coded process or window ID, it is more common for #IfWin to use them indirectly via [GroupAdd](GroupAdd.htm) or [Hotkey IfWin](Hotkey.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) has been turned on in the auto-execute section (top part of the script).

ExcludeTitle, ExcludeText

Although these are **not** supported, they can be used indirectly by specifying `ahk_group MyGroup` for _WinTitle_ (where _MyGroup_ is a group created via [GroupAdd](GroupAdd.htm), which supports ExcludeTitle/Text).

## Basic Operation

The #IfWin directives make it easy to create context-sensitive [hotkeys](../Hotkeys.htm) and [hotstrings](../Hotstrings.htm). For example:

```
#IfWinActive ahk_class Notepad
#space::MsgBox You pressed Win+Spacebar in Notepad.
```

The #IfWin directives are positional: they affect all hotkeys and hotstrings physically beneath them in the script. They are also mutually exclusive; that is, only the most recent one will be in effect.

To turn off context sensitivity, specify any #IfWin directive but omit all of its parameters. For example:

```
#IfWinActive
```

When #IfWin is turned off (or never used in a script), all [hotkeys](../Hotkeys.htm) and [hotstrings](../Hotstrings.htm) are enabled for all windows (unless disabled via [Suspend](Suspend.htm) or the [Hotkey command](Hotkey.htm)).

When a mouse or keyboard hotkey is disabled via #IfWin, it performs its native function; that is, it passes through to the active window as though there is no such hotkey. There is one exception: Joystick hotkeys: although #IfWin works, it never prevents other programs from seeing the press of a button.

#IfWin can also be used to alter the behavior of an ordinary key like Enter or Space. This is useful when a particular window ignores that key or performs some action you find undesirable. For example:

```
#IfWinActive Reminders ahk_class #32770  <em>; The "reminders" window in Outlook.</em>
Enter::Send !o  <em>; Have an "Enter" keystroke open the selected reminder rather than snoozing it.</em>
#IfWinActive
```

Like other directives, #IfWin cannot be executed conditionally.

## Variant (Duplicate) Hotkeys

A particular [hotkey](../Hotkeys.htm) or [hotstring](../Hotstrings.htm) can be defined more than once in the script if each definition has different #IfWin criteria. These are known as _hotkey variants_. For example:

```
#IfWinActive ahk_class Notepad
^!c::MsgBox You pressed Control+Alt+C in Notepad.
#IfWinActive ahk_class WordPadClass
^!c::MsgBox You pressed Control+Alt+C in WordPad.
#IfWinActive
^!c::MsgBox You pressed Control+Alt+C in a window other than Notepad/WordPad.
```

If more than one variant is eligible to fire, only the one closest to the top of the script will fire. The exception to this is the global variant (the one with no #IfWin criteria): It always has the lowest precedence; therefore, it will fire only if no other variant is eligible (this exception does not apply to [hotstrings](../Hotstrings.htm)).

When creating duplicate hotkeys, the order of [modifier symbols](../Hotkeys.htm#Symbols) such as ^!+# does not matter. For example, `^!c` is the same as `!^c`. However, keys must be spelled consistently. For example, _Esc_ is not the same as _Escape_ for this purpose (though the case does not matter). Also, any hotkey with a [wildcard prefix (\*)](../Hotkeys.htm#wildcard) is entirely separate from a non-wildcard one; for example, `*F1` and `F1` would each have their own set of variants.

To have the same hotkey subroutine executed by more than one variant, the easiest way is to create a stack of identical hotkeys, each with a different #IfWin directive above it. For example:

```
#IfWinActive ahk_class Notepad
#z::
#IfWinActive ahk_class WordPadClass
#z::
MsgBox You pressed Win+Z in either Notepad or WordPad.
return
```

Alternatively, a [window group](GroupAdd.htm) can be used via `#IfWinActive ahk_group MyGroup`.

To create hotkey variants dynamically (while the script is running), see ["Hotkey IfWin"](Hotkey.htm#IfWin).

## General Remarks

#IfWin also restores prefix keys to their native function when appropriate (a [prefix key](../Hotkeys.htm#prefix) is A in a hotkey such as "a & b"). This occurs whenever there are no enabled hotkeys for a given prefix.

When Gosub or Goto is used to jump to a hotkey or hotstring label, it jumps to the variant closest to the top of the script.

When a hotkey is currently disabled via #IfWin, its key or mouse button will appear with a "#" character in [KeyHistory's](KeyHistory.htm) "Type" column. This can help debug a script.

Variable references such as %Var% are not currently supported. Therefore, percent signs must be [escaped](../misc/EscapeChar.htm) via \`% to allow future support for them. Similarly, literal commas must be escaped (via \`,) to allow additional parameters to be added in the future. If you need to work around this limitation, use [GroupAdd](GroupAdd.htm) and [ahk\_group](../misc/WinTitle.htm#ahk_group).

A label to which the [Hotkey command](Hotkey.htm) has assigned a hotkey is not directly affected by #IfWin. Instead, the use of #IfWin closest to the bottom of the script (if any) will be in effect for all hotkeys created by the Hotkey command (unless ["Hotkey IfWin"](Hotkey.htm#IfWin) has been used to change that).

[Alt-tab hotkeys](../Hotkeys.htm#alttab) are not affected by #IfWin: they are in effect for all windows.

The [Last Found Window](../misc/WinTitle.htm#LastFoundWindow) is set by #IfWinActive/Exist (though not by #IfWin _Not_ Active/ _Not_ Exist). For example:

```
#IfWinExist ahk_class Notepad
#n::WinActivate  <em>; Activates the window found by #IfWin.</em>
```

The [escape sequences](../misc/EscapeChar.htm) \`s and \`t may be used if leading or trailing spaces/tabs are needed in one of #IfWin's parameters.

For performance reasons, #IfWin does not continuously monitor the activation or existence of the specified windows. Instead, it checks for a matching window only when you type a hotkey or hotstring. If a matching window is not present, your keystroke or mouse click is allowed to pass through to the active window unaltered.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on in the auto-execute section (top part of the script).

## Related

[#If _expression_](_If.htm), [Hotkey command](Hotkey.htm), [Hotkeys](../Hotkeys.htm), [Hotstrings](../Hotstrings.htm), [Suspend](Suspend.htm), [WinActive()](WinActive.htm), [WinExist()](WinExist.htm), [SetTitleMatchMode](SetTitleMatchMode.htm), [DetectHiddenWindows](DetectHiddenWindows.htm)

## Examples

Creates two hotkeys and one hotstring which only work when Notepad is active, and one hotkey which works for any window except Notepad.

```
#IfWinActive ahk_class Notepad
^!a::MsgBox You pressed Ctrl-Alt-A while Notepad is active.  <em>; This hotkey will have no effect if pressed in other windows (and it will "pass through").</em>
#c::MsgBox You pressed Win-C while Notepad is active.
::btw::This replacement text for "btw" will occur only in Notepad.
#IfWinActive
#c::MsgBox You pressed Win-C in a window other than Notepad.
```

