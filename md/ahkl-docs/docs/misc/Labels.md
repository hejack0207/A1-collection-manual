# Labels

## Table of Contents

- [Syntax and Usage](#syntax-and-usage)
- [Subroutines](#subroutines)
- [Dynamic Labels](#dynamic-labels)
- [Hotkeys and Hotstrings](#hotkeys-and-hotstrings)
- [Named Loops](#named-loops)
- [Functions](#Functions)
- [Related](#related)

## Syntax and Usage

A label identifies a line of code, and can be used as a [Goto](../commands/Goto.htm) target or to form a [subroutine](#subroutines). There are three kinds of label: normal named labels, [hotkey](../Hotkeys.htm) labels and [hotstring](../Hotstrings.htm) labels.

Normal labels consist of a name followed by a colon.

```
this_is_a_label:

```

Hotkey labels consist of a hotkey followed by double-colon.

```
^a::

```

Hotstring labels consist of a colon, zero or more [options](../Hotstrings.htm#Options), another colon, an abbreviation and double-colon.

```
:*:btw::

```

Generally, aside from whitespace and comments, no other code can be written on the same line as a label. However:

- A hotkey label can be directly followed by a command or other statement to create a_one-line_ hotkey. In other words, if a command, assignment or expression is present on the same line as a hotkey label, it acts as though followed by `return`.
- A hotkey with a[key name](../KeyList.htm) written to the right of the double-colon is actually a [_remapping_](Remap.htm), which is shorthand for [a pair of hotkeys](../misc/Remap.htm#actually). For example, `a::b` creates hotkeys and labels for `*a` and `*a Up`, and does not create a label named `a`.
- A hotstring with text written to the right of the final double-colon is an_auto-replace_ hotstring. Auto-replace hotstrings do not act as labels.

**Names:** Label names are not case sensitive, and may consist of any characters other than space, tab, comma and the [escape character](EscapeChar.htm) (\`). However, due to style conventions, it is generally better to use only letters, numbers, and the underscore character (for example: _MyListView_, _Menu\_File\_Open_, and _outer\_loop_). Label names must be unique throughout the whole script.

Although there are no reserved names, it is strongly recommended that the following names not be used: On, Off, Toggle, AltTab, ShiftAltTab, AltTabAndMenu and AltTabMenuDismiss. These values have special meaning to the [Hotkey command](../commands/Hotkey.htm).

**Target:** The target of a label is the next line of executable code. Executable code includes commands, assignments, [expressions](../Variables.htm#Expressions) and [blocks](../commands/Block.htm), but not directives, labels, hotkeys or hotstrings. In the following example, `run_notepad` and `#n` both point at the `Run` line:

```
run_notepad:
#n::
    Run Notepad
    return

```

**Execution:** Like directives, labels have no effect when reached during normal execution. In the following example, a message box is shown twice - once during execution of the subroutine by [Gosub](../commands/Gosub.htm), and again after the subroutine returns:

```
gosub Label1

Label1:
MsgBox <a href="../Variables.htm#ThisLabel" data-index="21">%A_ThisLabel%</a>
return
```

## Subroutines

A subroutine is a portion of code which can be _called_ to perform a specific task. Execution of a subroutine begins at the target of a label and continues until a [Return](../commands/Return.htm) or [Exit](../commands/Exit.htm) is encountered. Since the end of a subroutine depends on flow of control, any label can act as both a Goto target and the beginning of a subroutine.

## Dynamic Labels

Many commands which accept a label name also accept a [variable](../Variables.htm) reference such as %MyLabel%, in which case the name stored in the variable is used as the target. However, performance is slightly reduced because the target label must be "looked up" each time rather than only once when the script is first loaded.

## Hotkeys and Hotstrings

Each [double-colon hotkey](../Hotkeys.htm) also creates a label, unless it is a [function hotkey](../Hotkeys.htm#Function). The label's name is exactly as written in the script, and can differ from the hotkey's name as reported by [A\_ThisHotkey](../Variables.htm#ThisHotkey), such as if the modifiers are written in a different order. The label name includes the hotkey's modifiers but not the final double-colon ( `::`).

A [hotstring label](../Hotstrings.htm#label)'s name includes the leading colon and options, but not the final double-colon ( `::`).

[Hotkey](../Hotkeys.htm) and [hotstring labels](../Hotstrings.htm#label) are also valid targets for [Goto](../commands/Goto.htm), [Gosub](../commands/Gosub.htm) and other commands. However, a hotkey or hotstring label can only be used in this manner if it is the first label with the given name. For example:

```
gosub ^+a  <em>; Example hotkey.</em>
gosub +^a  <em>; Global hotkey.</em>
gosub Esc  <em>; Esc label.</em>
ExitApp

#IfWinActive Example
^+a::MsgBox Example hotkey.
Esc:
    MsgBox Esc label.
    return
#If
+^a::MsgBox Global hotkey.
Esc::MsgBox Esc hotkey.
```

This limitation also applies to the [Hotkey](../commands/Hotkey.htm) command's _Label_ parameter.

## Named Loops

A label can also be used to identify a loop for the [Continue](../commands/Continue.htm) and [Break](../commands/Break.htm) commands. This allows the script to easily continue or break out of any number of nested loops.

## Functions

[v1.1.20+]: [Functions](../Functions.htm) can be used in place of labels in a number of cases, including:

- [Gui events](../commands/Gui.htm#Labels) such as GuiClose
- [Gui control events](../commands/Gui.htm#label) (g-labels)
- [Hotkey](../commands/Hotkey.htm#Functor)
- [Menu](../commands/Menu.htm#Functor)
- [SetTimer](../commands/SetTimer.htm#Functor)

The benefits of functions are that they can use local variables, and in some cases (such as Gui control events) they also accept parameters containing useful information.

## Related

[IsLabel()](../commands/IsLabel.htm), [A\_ThisLabel](../Variables.htm#ThisLabel), [Gosub](../commands/Gosub.htm), [Goto](../commands/Goto.htm), [OnExit](../commands/OnExit.htm#command), [SetTimer](../commands/SetTimer.htm), [Hotkey](../commands/Hotkey.htm), [Gui Events](../commands/Gui.htm#Labels), [g-label](../commands/Gui.htm#label), [OnClipboardChange Label](../commands/OnClipboardChange.htm#label)

