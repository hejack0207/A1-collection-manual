# Hotstring() [v1.1.28+]

Creates, modifies, enables, or disables a [hotstring](../Hotstrings.htm) while the script is running.

```
<span class="func">Hotstring</span>(String <span class="optional">, Replacement, OnOffToggle</span>)
<span class="func">Hotstring</span>(<a href="#NewOptions" data-index="2">NewOptions</a>)
OldValue := <span class="func">Hotstring</span>("<a href="#EndChars" data-index="3">EndChars</a>" <span class="optional">, NewValue</span>)
OldValue := <span class="func">Hotstring</span>("<a href="#MouseReset" data-index="4">MouseReset</a>" <span class="optional">, NewValue</span>)
<span class="func">Hotstring</span>("Reset")

```

## Parameters

String

The hotstring's trigger string, preceded by [the usual colons](../Hotstrings.htm) and [option characters](../Hotstrings.htm#Options). For example, `"::btw"` or `":*:]d"`.

_String_ may be matched to an existing hotstring by considering [case-sensitivity (C)](../Hotstrings.htm#C), [word-sensitivity (?)](../Hotstrings.htm#Question), activation criteria (as set by [#If](_If.htm), [#IfWin](_IfWinActive.htm) or [Hotkey, If](Hotkey.htm#IfWin)) and the trigger string. For example, `"::btw"` and `"::BTW"` match unless the case-sensitive mode was enabled as a default, while `":C:btw"` and `":C:BTW"` never match. The `C` and `?` options may be included in _String_ or set as defaults by the [#Hotstring](_Hotstring.htm) directive or a previous call to [this function](#NewOptions).

If the hotstring already exists, any options specified in _String_ are put into effect, while all other options are left as is. However, since hotstrings with `C` or `?` are considered distinct from other hotstrings, it is not possible to add or remove these options. Instead, turn off the existing hotstring and create a new one.

When a hotstring is first created -- either by the Hotstring function or a [double-colon label](../Hotstrings.htm) in the script -- its trigger string and sequence of option characters becomes the permanent name of that hotstring as reflected by [A\_ThisHotkey](../Variables.htm#ThisHotkey). This name does not change even if the Hotstring function later accesses the hotstring with different option characters.

If the [X (execute) option](../Hotstrings.htm#X) is present in _String_ (not just set as a default), the _Replacement_ parameter is interpreted as a label or function name instead of replacement text. This has no effect if _Replacement_ is an object.

Replacement

The replacement string, or a [label](../misc/Labels.htm), [function](../Functions.htm) or [function object](../objects/Functor.htm) to call (as a new [thread](../misc/Threads.htm)) when the hotstring triggers.

By default, all strings are treated as replacement text. To specify a label or function by name, include the [X (execute)](../Hotstrings.htm#X) option in _String_. Both normal labels and [hotkey](../Hotkeys.htm)/ [hotstring](../Hotstrings.htm) labels can be used, and the trailing colon(s) should not be included. If a function and a label exist with the same name, the label takes precedence. To use the function instead, pass a [function reference](../objects/Func.htm).

This parameter can be left blank if the hotstring already exists, in which case its replacement will not be changed. This is useful to change only the hotstring's options, or to turn it on or off.

**Note**: If this parameter is specified but the hotstring is disabled from a previous use of this function, the hotstring will remain disabled. To prevent this, include the word `"On"` in _OnOffToggle_.

OnOffToggle

One of the following strings (enclosed in quote marks if used literally):

**On**: Enables the hotstring.

**Off**: Disables the hotstring.

**Toggle**: Sets the hotstring to the opposite state (enabled or disabled).

[v1.1.30+]: The values 1 (or `true`), 0 (or `false`) and -1 may be used in place of On, Off and Toggle, respectively.

## Errors

This function throws an exception if the parameters are invalid or a memory allocation fails. It does not affect [ErrorLevel](../misc/ErrorLevel.htm).

An exception is also thrown if _Replacement_ is omitted and _String_ is valid but does not match an existing hotstring. This can be utilized to test for the existence of a hotstring. For example:

```
try
    Hotstring("::btw")
catch
    MsgBox The hotstring does not exist or it has no variant for the current IfWin criteria.
```

## Remarks

The [current IfWin setting](Hotkey.htm#IfWin) determines the [variant](#variant) of a hotstring upon which the Hotstring function will operate.

A given label or function can be the target of more than one hotstring. If it is known that a label or function was called by a hotstring, you can determine which hotstring by checking the built-in variable [A\_ThisHotkey](../Variables.htm#ThisHotkey).

If the script is [suspended](Suspend.htm), newly added/enabled hotstrings will also be suspended until the suspension is turned off (unless they are exempt as described in the [Suspend](Suspend.htm) section).

The [keyboard](_InstallKeybdHook.htm) and/or [mouse](_InstallMouseHook.htm) hooks will be installed or removed if justified by the changes made by this function.

This function cannot directly enable or disable hotstrings in scripts other than its own.

Once a script has at least one hotstring, it becomes persistent, meaning that [ExitApp](ExitApp.htm) rather than Exit should be used to terminate it. Hotstring scripts are also automatically [#SingleInstance](_SingleInstance.htm) unless `#SingleInstance Off` has been specified.

## Variant (Duplicate) Hotstrings

A particular hotstring can be created more than once if each definition has different [IfWin](Hotkey.htm#IfWin) criteria, [case-sensitivity](../Hotstrings.htm#C) ( `C` vs. `C0`/ `C1`), or [word-sensitivity](../Hotstrings.htm#Question) ( `?`). These are known as _hotstring variants_. For example:

```
Hotkey, IfWinActive, ahk_group CarForums
Hotstring("::btw", "behind the wheel")
Hotkey, IfWinActive, Inter-Office Chat
Hotstring("::btw", "back to work")
Hotkey, IfWinActive
Hotstring("::btw", "by the way")
```

If more than one variant of a hotstring is eligible to fire, only the one created earliest will fire.

For more information about IfWin, see [#IfWin's General Remarks](_IfWinActive.htm#gen).

## EndChars

```
OldValue := <span class="func">Hotstring</span>("EndChars" <span class="optional">, NewValue</span>)
```

Retrieves or modifies the set of characters used as [ending characters](../Hotstrings.htm#EndChars) by the hotstring recognizer. For example:

```
prev_chars := Hotstring("EndChars", "-()[]{}':;""/\,.?!`n `t")
MsgBox The previous value was: %prev_chars%
```

[#Hotstring EndChars](Hotstring.htm#EndChars) also affects this setting.

It is currently not possible to specify a different set of end characters for each hotstring.

## MouseReset

```
OldValue := <span class="func">Hotstring</span>("MouseReset" <span class="optional">, NewValue</span>)
```

Retrieves or modifies the global setting which controls whether mouse clicks reset the hotstring recognizer, as described [here](../Hotstrings.htm#NoMouse). _NewValue_ should be 1 (true) to enable mouse click detection and resetting of the hotstring recognizer, or 0 (false) to disable it. The return value is the setting which was in effect before the function was called.

The [mouse](_InstallMouseHook.htm) hook may be installed or removed if justified by the changes made by this function.

[#Hotstring NoMouse](_Hotstring.htm) also affects this setting, and is equivalent to specifying `false` for _NewValue_.

## Reset [v1.1.28.01+]

```
<span class="func">Hotstring</span>("Reset")
```

Immediately resets the hotstring recognizer. In other words, the script will begin waiting for an entirely new hotstring, eliminating from consideration anything you previously typed.

## Setting Default Options

```
<span class="func">Hotstring</span>(NewOptions)
```

To set new default options for subsequently created hotstrings, pass the options to the Hotstring function without any leading or trailing colon. For example: `Hotstring("T")`.

Turning on [case-sensitivity (C)](../Hotstrings.htm#C) or [word-sensitivity (?)](../Hotstrings.htm#Question) also affects which existing hotstrings will be found by any subsequent calls to the Hotstring function. For example, `Hotstring(":T:btw")` will find `::BTW` by default, but not if `Hotstring("C")` or `<a href="_Hotstring.htm" data-index="46">#Hotstring</a> C` is in effect. This can be undone or overridden by passing a mutually-exclusive option; for example, `C0` and `C1` override `C`.

## Related

[Hotstrings](../Hotstrings.htm), [#IfWinActive/Exist](_IfWinActive.htm), [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm), [Suspend](Suspend.htm), [Threads](../misc/Threads.htm), [Thread](Thread.htm), [Critical](Critical.htm)

## Examples

Hotstring Helper. The following script might be useful if you are a heavy user of hotstrings. It's based on [the script created by Andreas Borutta](../Hotstrings.htm#Helper). By pressing Win+H (or another hotkey of your choice), the currently selected text can be turned into a hotstring. For example, if you have "by the way" selected in a word processor, pressing Win+H will prompt you for its abbreviation (e.g. btw) and then add the new hotstring to the script. The hotstring will be activated without reloading the script.

`````
#h::  <em>; Win+H hotkey
; Get the text currently selected. The clipboard is used instead of
; "ControlGet Selected" because it works in a greater variety of editors
; (namely word processors).  Save the current clipboard contents to be
; restored later. Although this handles only plain text, it seems better
; than nothing:</em>
ClipboardOld := Clipboard
Clipboard := "" <em>; Must start off blank for detection to work.</em>
Send ^c
ClipWait 1
if ErrorLevel  <em>; ClipWait timed out.</em>
    return
<em>; Replace CRLF and/or LF with `n for use in a "send-raw" hotstring:
; The same is done for any other characters that might otherwise
; be a problem in raw mode:</em>
ClipContent := StrReplace(Clipboard, "``", "````")  <em>; Do this replacement first to avoid interfering with the others below.</em>
ClipContent := StrReplace(ClipContent, "`r`n", "``r")  <em>; Using `r works better than `n in MS Word, etc.</em>
ClipContent := StrReplace(ClipContent, "`n", "``r")
ClipContent := StrReplace(ClipContent, "`t", "``t")
ClipContent := StrReplace(ClipContent, "`;", "```;")
Clipboard := ClipboardOld  <em>; Restore previous contents of clipboard.</em>
ShowInputBox(":T:`::" ClipContent)
return

ShowInputBox(DefaultValue)
{
    <em>; This will move the input box's caret to a more friendly position:</em>
    SetTimer, MoveCaret, 10
    <em>; Show the input box, providing the default hotstring:</em>
    InputBox, UserInput, New Hotstring,
    (
    Type your abreviation at the indicated insertion point. You can also edit the replacement text if you wish.

    Example entry: :R:btw`::by the way
    ),,,,,,,, %DefaultValue%
    if ErrorLevel  <em>; The user pressed Cancel.</em>
        return

    if RegExMatch(UserInput, "O)(?P<Label>:.*?:(?P<Abbreviation>.*?))::(?P<Replacement>.*)", Hotstring)
    {
        if !Hotstring.Abbreviation
            MsgText := "You didn't provide an abbreviation"
        else if !Hotstring.Replacement
            MsgText := "You didn't provide a replacement"
        else
        {
            Hotstring(Hotstring.Label, Hotstring.Replacement)  <em>; Enable the hotstring now.</em>
            FileAppend, `n%UserInput%, %A_ScriptFullPath%  <em>; Save the hotstring for later use.</em>
        }
    }
    else
        MsgText := "The hotstring appears to be improperly formatted"

    if MsgText
    {
        MsgBox, 4,, %MsgText%. Would you like to try again?
        IfMsgBox, Yes
            ShowInputBox(DefaultValue)
    }
    return

    MoveCaret:
    WinWait, New Hotstring
    <em>; Otherwise, move the input box's insertion point to where the user will type the abbreviation.</em>
    Send {Home}{Right 3}
    SetTimer,, Off
    return
}
`````

