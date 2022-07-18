# Hotstrings

## Table of Contents

- [Introduction and Simple Examples](#intro)
- [Ending Characters](#EndChars)
- [Options](#Options)
- [Long Replacements](#continuation)
- [Context-sensitive Hotstrings](#variant)
- [AutoCorrect](#AutoCorrect)
- [Remarks](#remarks)
- [Function Hotstrings](#Function)[v1.1.28+]
- [Hotstring Helper](#Helper)

## Introduction and Simple Examples

Although hotstrings are mainly used to expand abbreviations as you type them (auto-replace), they can also be used to launch any scripted action. In this respect, they are similar to [hotkeys](Hotkeys.htm) except that they are typically composed of more than one character (that is, a string).

To define a hotstring, enclose the triggering abbreviation between pairs of colons as in this example:

```
::btw::by the way
```

In the above example, the abbreviation btw will be automatically replaced with "by the way" whenever you type it (however, by default you must type an [ending character](#EndChars) after typing btw, such as Space, ., or Enter).

The "by the way" example above is known as an auto-replace hotstring because the typed text is automatically erased and replaced by the string specified after the second pair of colons. By contrast, a hotstring may also be defined to perform any custom action as in the following examples. Note that the commands must appear beneath the hotstring:

```
::btw::
MsgBox You typed "btw".
return

:*:]d::  <em>; This hotstring replaces "]d" with the current date and time via the commands below.</em>
<a href="commands/FormatTime.htm" data-index="12">FormatTime</a>, CurrentDateTime,, M/d/yyyy h:mm tt  <em>; It will look like 9/1/2005 3:53 PM</em>
SendInput %CurrentDateTime%
return
```

Even though the two examples above are not auto-replace hotstrings, the abbreviation you type is erased by default. This is done via automatic backspacing, which can be disabled via the [b0 option](#b0).

## Ending Characters

Unless the [asterisk option](#Asterisk) is in effect, you must type an _ending character_ after a hotstring's abbreviation to trigger it. Ending characters initially consist of the following: **-()[]{}':;"/\\,.?!\`n \`t** (note that \`n is Enter, \`t is Tab, and there is a plain space between \`n and \`t). This set of characters can be changed by editing the following example, which sets the new ending characters for all hotstrings, not just the ones beneath it:

```
#Hotstring EndChars -()[]{}:;'"/\,.?!`n `t
```

[v1.1.28+]: The ending characters can be changed while the script is running by calling the [Hotstring](commands/Hotstring.htm) function as demonstrated below:

```
Hotstring("EndChars", "-()[]{}:;")
```

## Options

A hotstring's default behavior can be changed in two possible ways:

1. The[#Hotstring](commands/_Hotstring.htm) directive, which affects all hotstrings physically beneath that point in the script. The following example puts the C and R options into effect: `#Hotstring <strong>c r</strong>`.
2. Putting options inside a hotstring's first pair of colons. The following example puts the C and \* options (case sensitive and "ending character not required") into effect for a single hotstring:
   `:<strong>c*</strong>:j@::john@somedomain.com`.

The list below describes each option. When specifying more than one option using the methods above, spaces optionally may be included between them.

**\*** (asterisk): An ending character (e.g. Space, ., or Enter) is not required to trigger the hotstring. For example:

```
:*:j@::jsmith@somedomain.com
```

The example above would send its replacement the moment you type the @ character. When using the [#Hotstring directive](commands/_Hotstring.htm), use **\*0** to turn this option back off.

**?** (question mark): The hotstring will be triggered even when it is inside another word; that is, when the character typed immediately before it is alphanumeric. For example, if `:?:al::airline` is a hotstring, typing "practical " would produce "practicairline ". Use **?0** to turn this option back off.

**B0** (B followed by a zero): Automatic backspacing is not done to erase the abbreviation you type. Use a plain **B** to turn backspacing back on after it was previously turned off. A script may also do its own backspacing via {bs 5}, which sends Backspace five times. Similarly, it may send ← five times via {left 5}. For example, the following hotstring produces "<em></em>" and moves the caret 5 places to the left (so that it's between the tags):

```
:*b0:<em>::</em>{left 5}
```

**C**: Case sensitive: When you type an abbreviation, it must exactly match the case defined in the script. Use **C0** to turn case sensitivity back off.

**C1**: Do not conform to typed case. Use this option to make [auto-replace hotstrings](#auto) case insensitive and prevent them from conforming to the case of the characters you actually type. Case-conforming hotstrings (which are the default) produce their replacement text in all caps if you type the abbreviation in all caps. If you type the first letter in caps, the first letter of the replacement will also be capitalized (if it is a letter). If you type the case in any other way, the replacement is sent exactly as defined. When using the [#Hotstring directive](commands/_Hotstring.htm), **C0** can be used to turn this option back off, which makes hotstrings conform again.

**Kn**: Key-delay: This rarely-used option sets the delay between keystrokes produced by auto-backspacing or [auto-replacement](#auto). Specify the new delay for **n**; for example, specify k10 to have a 10ms delay and k-1 to have no delay. The exact behavior of this option depends on which [sending mode](#SendMode) is in effect:

- SI (SendInput): Key-delay is ignored because a delay is not possible in this mode. The exception to this is when SendInput is[unavailable](commands/Send.htm#SendInputUnavail), in which case hotstrings revert to SendPlay mode below (which does obey key-delay).
- SP (SendPlay): A delay of length zero is the default, which for SendPlay is the same as -1 (no delay). In this mode, the delay is actually a[PressDuration](commands/SetKeyDelay.htm#dur) rather than a delay between keystrokes.
- SE (SendEvent): A delay of length zero is the default. Zero is recommended for most purposes since it is fast but still cooperates well with other processes (due to internally doing a[Sleep 0](commands/Sleep.htm)). Specify k-1 to have no delay at all, which is useful to make auto-replacements faster if your CPU is frequently under heavy load. When set to -1, a script's process-priority becomes an important factor in how fast it can send keystrokes. To raise a script's priority, use `<a href="commands/Process.htm" data-index="25">Process</a>, Priority,, High`.

**O**: Omit the ending character of [auto-replace hotstrings](#auto) when the replacement is produced. This is useful when you want a hotstring to be kept unambiguous by still requiring an ending character, but don't actually want the ending character to be shown on the screen. For example, if `:o:ar::aristocrat` is a hotstring, typing "ar" followed by the spacebar will produce "aristocrat" with no trailing space, which allows you to make the word plural or possessive without having to press Backspace. Use **O0** (the letter O followed by a zero) to turn this option back off.

**Pn**: The [priority](misc/Threads.htm) of the hotstring (e.g. P1). This rarely-used option has no effect on [auto-replace hotstrings](#auto).

**R**: Send the replacement text [raw](commands/Send.htm#SendRaw); that is, without translating {Enter} to Enter, ^c to Ctrl+C, etc. This option is put into effect automatically for hotstrings that have a [continuation section](#continuation). Use **R0** to turn this option back off.

**Note:** [Text mode](#T) may be more reliable. The R and T options are mutually exclusive.

**SI** or **SP** or **SE**[v1.0.43+]: Sets the method by which [auto-replace hotstrings](#auto) send their keystrokes. These options are mutually exclusive: only one can be in effect at a time. The following describes each option:

- SI stands for[SendInput](commands/Send.htm#SendInputDetail), which typically has superior speed and reliability than the other modes. Another benefit is that like SendPlay below, SendInput postpones anything you type during a hotstring's [auto-replacement text](#auto). This prevents your keystrokes from being interspersed with those of the replacement. When SendInput is [unavailable](commands/Send.htm#SendInputUnavail), hotstrings automatically use SendPlay instead.
- SP stands for[SendPlay](commands/Send.htm#SendPlayDetail), which may allow hotstrings to work in a broader variety of games.
- SE stands for[SendEvent](commands/Send.htm#SendEvent), which is the default in versions older than 1.0.43.

If none of the above options are used, the default mode in [v1.0.43] and later is SendInput. However, unlike the SI option, SendEvent is used instead of SendPlay when SendInput is unavailable.

**T**[v1.1.27+]: Send the replacement text [raw](#raw), without translating each character to a keystroke. For details, see [Text mode](commands/Send.htm#SendText). Use **T0** or **R0** to turn this option back off, or override it with **R**.

**X**[v1.1.28+]: Execute. Instead of replacement text, the hotstring accepts a command or expression to execute. For example, `:X:~mb::MsgBox` would cause a message box to be displayed when the user types "~mb" instead of auto-replacing it with the word "MsgBox". This is most useful when defining a large number of hotstrings which call functions, as it would otherwise require three lines per hotstring.

When used with the [Hotstring](commands/Hotstring.htm) function, the X option causes the _Replacement_ parameter to be interpreted as a label or function name instead of replacement text. However, the X option has this effect only if it is specified each time the function is called.

**Z**: This rarely-used option resets the hotstring recognizer after each triggering of the hotstring. In other words, the script will begin waiting for an entirely new hotstring, eliminating from consideration anything you previously typed. This can prevent unwanted triggerings of hotstrings. To illustrate, consider the following hotstring:

```
:b0*?:11::
SendInput xx
return
```

Since the above lacks the Z option, typing 111 (three consecutive 1's) would trigger the hotstring twice because the middle 1 is the _last_ character of the first triggering but also the _first_ character of the second triggering. By adding the letter Z in front of b0, you would have to type four 1's instead of three to trigger the hotstring twice. Use **Z0** to turn this option back off.

## Long Replacements

Hotstrings that produce a large amount of replacement text can be made more readable and maintainable by using a [continuation section](Scripts.htm#continuation). For example:

```
::text1::
(
Any text between the top and bottom parentheses is treated literally, including commas and percent signs.
By default, the hard carriage return (Enter) between the previous line and this one is also preserved.
    By default, the indentation (tab) to the left of this line is preserved.
)
```

See [continuation section](Scripts.htm#continuation) for how to change these default behaviors. The presence of a continuation section also causes the hotstring to default to [raw mode](#raw). The only way to override this special default is to specify the [r0 option](#raw) in each hotstring that has a continuation section (e.g. `:r0:text1::`).

## Context-sensitive Hotstrings

The directives [#IfWinActive/Exist](commands/_IfWinActive.htm) can be used to make selected hotstrings context sensitive. Such hotstrings send a different replacement, perform a different action, or do nothing at all depending on the type of window that is active or exists. For example:

```
#IfWinActive ahk_class Notepad
::btw::This replacement text will appear only in Notepad.
#IfWinActive
::btw::This replacement text appears in windows other than Notepad.
```

## AutoCorrect

The following script uses hotstrings to correct about 4700 common English misspellings on-the-fly. It also includes a Win+H hotkey to make it easy to add more misspellings:

Download: [AutoCorrect.ahk](https://www.autohotkey.com/download/AutoCorrect.ahk) (127 KB)

Author: [Jim Biancolo](http://www.biancolo.com/blog/autocorrect/) and [Wikipedia's Lists of Common Misspellings](https://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings)

## Remarks

Variable references such as `%MyVar%` are not currently supported within the replacement text. To work around this, don't make such hotstrings [auto-replace](#auto). Instead, use the [SendInput](commands/Send.htm#SendInput) command beneath the abbreviation, followed by a line containing only the word Return.

To send an extra space or tab after a replacement, include the space or tab at the end of the replacement but make the last character an accent/backtick (\`). For example:

```
:*:btw::By the way `
```

By default, any click of the left or right mouse button will reset the hotstring recognizer. In other words, the script will begin waiting for an entirely new hotstring, eliminating from consideration anything you previously typed (if this is undesirable, specify the line `<a href="commands/_Hotstring.htm" data-index="51">#Hotstring</a> NoMouse` anywhere in the script). This "reset upon mouse click" behavior is the default because each click typically moves the text insertion point (caret) or sets keyboard focus to a new control/field. In such cases, it is usually desirable to: 1) fire a hotstring even if it lacks the [question mark option](#Question); 2) prevent a firing when something you type after clicking the mouse accidentally forms a valid abbreviation with what you typed before.

The hotstring recognizer checks the active window each time a character is typed, and resets if a different window is active than before. If the active window changes but reverts before any characters are typed, the change is not detected (but the hotstring recognizer may be reset for some other reason). The hotstring recognizer can also be reset by calling `<a href="commands/Hotstring.htm#Reset" data-index="53">Hotstring("Reset")</a>`.

The built-in variable **A\_EndChar** contains the ending character that you typed to trigger the most recent non-auto-replace hotstring. If no ending character was required (due to the [\\* option](#Asterisk)), it will be blank. A\_EndChar is useful when making hotstrings that use the Send command or whose behavior should vary depending on which ending character you typed. To send the ending character itself, use `SendRaw %A_EndChar%` ( [SendRaw](commands/Send.htm) is used because characters such as !{} would not be sent correctly by the normal Send command).

Although commas, percent signs, and single-colons within hotstring definitions do not need to be [escaped](misc/EscapeChar.htm), backticks and those semicolons having a space or tab to their left require it. See [Escape Sequences](misc/EscapeChar.htm) for a complete list.

Although the [Send command](commands/Send.htm)'s special characters such as {Enter} are supported in [auto-replacement text](#auto) (unless the [raw option](#raw) is used), the hotstring abbreviations themselves do not use this. Instead, specify \`n for Enter and \`t (or a literal tab) for Tab (see [Escape Sequences](misc/EscapeChar.htm) for a complete list). For example, the hotstring ``:*:ab`t::`` would be triggered when you type "ab" followed by a tab.

Spaces and tabs are treated literally within hotstring definitions. For example, the following would produce two different results: `::btw::by the way` and `::btw:: by the way`.

Each hotstring abbreviation can be no more than 40 characters long. The program will warn you if this length is exceeded. By contrast, the length of hotstring's replacement text is limited to about 5000 characters when the [sending mode](#SendMode) is at its default of SendInput. That limit can be increased to 16,383 characters by switching to one of the other [sending modes](#SendMode). Furthermore, an unlimited amount of text can be sent by using `<a href="commands/Send.htm#SendPlayDetail" data-index="64">SendPlay</a> %MyVariable%` in the body of the hotstring.

The order in which hotstrings are defined determines their precedence with respect to each other. In other words, if more than one hotstring matches something you type, only the one listed first in the script will take effect. Related topic: [context-sensitive hotstrings](#variant).

Any backspacing you do is taken into account for the purpose of detecting hotstrings. However, the use of ↑, →, ↓, ←, PgUp, PgDn, Home, and End to navigate within an editor will cause the hotstring recognition process to reset. In other words, it will begin waiting for an entirely new hotstring.

A hotstring may be typed even when the active window is ignoring your keystrokes. In other words, the hotstring will still fire even though the triggering abbreviation is never visible. In addition, you may still press Backspace to undo the most recently typed keystroke (even though you can't see the effect).

It is possible to [Gosub](commands/Gosub.htm) or [Goto](commands/Goto.htm) a hotstring label by including its first pair of colons (including any option symbols) in front of its name. For example: `Gosub ::xyz`. However, jumping to a [single-line (auto-replace) hotstring](#auto) will do nothing other than execute a [return](commands/Return.htm).

Although hotstrings are not monitored and will not be triggered during the course of an invisible [Input](commands/Input.htm) command, visible Inputs are capable of triggering them.

By default, hotstrings are never triggered by keystrokes produced by any AutoHotkey script. This avoids the possibility of an infinite loop where hotstrings trigger each other over and over. In [v1.1.06] and later, this behaviour can be controlled with [#InputLevel](commands/_InputLevel.htm) and [SendLevel](commands/SendLevel.htm). However, auto-replace hotstrings always use send level 0 and therefore never trigger [hook hotkeys](commands/_UseHook.htm) or hotstrings.

[v1.1.28+]: Hotstrings can be created dynamically by means of the [Hotstring](commands/Hotstring.htm) function, which can also modify, disable, or enable the script's existing hotstrings individually.

The [Input](commands/Input.htm) command is more flexible than hotstrings for certain purposes. For example, it allows your keystrokes to be invisible in the active window (such as a game). It also supports non-character ending keys such as Esc.

The [keyboard hook](commands/_InstallKeybdHook.htm) is automatically used by any script that contains hotstrings.

Hotstrings behave identically to hotkeys in the following ways:

- They are affected by the[Suspend](commands/Suspend.htm) command.
- They obey[#MaxThreads](commands/_MaxThreads.htm) and [#MaxThreadsPerHotkey](commands/_MaxThreadsPerHotkey.htm) (but not [#MaxThreadsBuffer](commands/_MaxThreadsBuffer.htm)).
- Scripts containing hotstrings are automatically[persistent](commands/_Persistent.htm).
- Non-auto-replace hotstrings will create a new[thread](misc/Threads.htm) when launched. In addition, they will update the built-in hotkey variables such as [A\_ThisHotkey](Variables.htm#ThisHotkey).

Known limitation: On some systems in Java applications, hotstrings might interfere with the user's ability to type diacritical letters (via dead keys). To work around this, [Suspend](commands/Suspend.htm) can be turned on temporarily (which disables all hotstrings).

## Function Hotstrings [v1.1.28+]

One or more hotstrings can be assigned a [function](Functions.htm) by simply defining it immediately after the hotstring label, as in this example:

```
<em>; This example also demonstrates one way to implement case conformity in a script.</em>
:C:BTW::  <em>; Typed in all-caps.</em>
:C:Btw::  <em>; Typed with only the first letter upper-case.</em>
: :btw::  <em>; Typed in any other combination.</em>
    case_conform_btw() {
        hs := A_ThisHotkey  <em>; For convenience and in case we're interrupted.</em>
        if (hs == ":C:BTW")
            Send BY THE WAY
        else if (hs == ":C:Btw")
            Send By the way
        else
            Send by the way
    }

```

For additional details, see [Function Hotkeys](Hotkeys.htm#function-details).

The [Hotstring](commands/Hotstring.htm) function can also be used to assign a function or function object to a hotstring.

## Hotstring Helper

Andreas Borutta suggested the following script, which might be useful if you are a heavy user of hotstrings. By pressing Win+H (or another hotkey of your choice), the currently selected text can be turned into a hotstring. For example, if you have "by the way" selected in a word processor, pressing Win+H will prompt you for its abbreviation (e.g. btw) and then add the new hotstring to the script. It will then reload the script to activate the hotstring.

**Note:** The [Hotstring](commands/Hotstring.htm) function can be used to create new hotstrings without reloading. Take a look at the [first example](commands/Hotstring.htm#ExHelper) in the example section of the function's page to see how this could be done.

`````
#h::  <em>; Win+H hotkey
; Get the text currently selected. The clipboard is used instead of
; "ControlGet Selected" because it works in a greater variety of editors
; (namely word processors).  Save the current clipboard contents to be
; restored later. Although this handles only plain text, it seems better
; than nothing:</em>
AutoTrim Off  <em>; Retain any leading and trailing whitespace on the clipboard.</em>
ClipboardOld := ClipboardAll
Clipboard := ""  <em>; Must start off blank for detection to work.</em>
Send ^c
ClipWait 1
if ErrorLevel  <em>; ClipWait timed out.</em>
    return
<em>; Replace CRLF and/or LF with `n for use in a "send-raw" hotstring:
; The same is done for any other characters that might otherwise
; be a problem in raw mode:</em>
StringReplace, Hotstring, Clipboard, ``, ````, All  <em>; Do this replacement first to avoid interfering with the others below.</em>
StringReplace, Hotstring, Hotstring, `r`n, ``r, All  <em>; Using `r works better than `n in MS Word, etc.</em>
StringReplace, Hotstring, Hotstring, `n, ``r, All
StringReplace, Hotstring, Hotstring, %A_Tab%, ``t, All
StringReplace, Hotstring, Hotstring, `;, ```;, All
Clipboard := ClipboardOld  <em>; Restore previous contents of clipboard.
; This will move the input box's caret to a more friendly position:</em>
SetTimer, MoveCaret, 10
<em>; Show the input box, providing the default hotstring:</em>
InputBox, Hotstring, New Hotstring, Type your abreviation at the indicated insertion point. You can also edit the replacement text if you wish.`n`nExample entry: :R:btw`::by the way,,,,,,,, :R:`::%Hotstring%
if ErrorLevel  <em>; The user pressed Cancel.</em>
    return
if InStr(Hotstring, ":R`:::")
{
    MsgBox You didn't provide an abbreviation. The hotstring has not been added.
    return
}
<em>; Otherwise, add the hotstring and reload the script:</em>
FileAppend, `n%Hotstring%, %A_ScriptFullPath%  <em>; Put a `n at the beginning in case file lacks a blank line at its end.</em>
Reload
Sleep 200 <em>; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.</em>
MsgBox, 4,, The hotstring just added appears to be improperly formatted.  Would you like to open the script for editing? Note that the bad hotstring is at the bottom of the script.
IfMsgBox, Yes, Edit
return

MoveCaret:
if not WinActive("New Hotstring")
    return
<em>; Otherwise, move the input box's insertion point to where the user will type the abbreviation.</em>
Send {Home}{Right 3}
SetTimer, MoveCaret, Off
return
`````

