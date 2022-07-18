# Hotkey

Creates, modifies, enables, or disables a hotkey while the script is running.

```
<span class="func">Hotkey</span>, KeyName <span class="optional">, Label, Options</span>
<span class="func">Hotkey</span>, IfWinActive/Exist <span class="optional">, WinTitle, WinText</span>
<span class="func">Hotkey</span>, If <span class="optional">, Expression</span>
<span class="func">Hotkey</span>, If, % FunctionObject

```

## Parameters

KeyName

Name of the hotkey's activation key, including any [modifier symbols](../Hotkeys.htm#Symbols). For example, specify `#c` for the Win+C hotkey.

If _KeyName_ already exists as a hotkey, that hotkey will be updated with the values of the command's other parameters.

_KeyName_ can also be the name of an existing hotkey label (i.e. a double-colon label), which will cause that hotkey to be updated with the values of the command's other parameters.

When specifying an _existing_ hotkey, _KeyName_ is not case sensitive. However, the names of keys must be spelled the same as in the existing hotkey (e.g. Esc is not the same as Escape for this purpose). Also, the order of [modifier symbols](../Hotkeys.htm#Symbols) such as ^!+# does not matter. [GetKeyName()](GetKey.htm) can be used to retrieve the standard spelling of a key name.

When a hotkey is first created -- either by the Hotkey command or a [double-colon label](../Hotkeys.htm) in the script -- its key name and the ordering of its modifier symbols becomes the permanent name of that hotkey as reflected by [A\_ThisHotkey](../Variables.htm#ThisHotkey). This name is shared by all [variants](_IfWinActive.htm#variant) of the hotkey, and does not change even if the Hotkey command later accesses the hotkey with a different symbol ordering.

[v1.1.15+]: If the hotkey variant already exists, its behavior is updated according to whether _KeyName_ includes or excludes the [tilde (~) prefix](../Hotkeys.htm#Tilde). However, prior to [v1.1.19], the hotkey was not updated if _Label_ was omitted.

[v1.1.19+]: The [use hook ($) prefix](../Hotkeys.htm#prefixdollar) can be added to existing hotkeys. This prefix affects all variants of the hotkey and cannot be removed. Prior to [v1.1.19], the prefix was ignored when modifying an existing hotkey variant.

Label

The name of the [label](../misc/Labels.htm) whose contents will be executed (as a new [thread](../misc/Threads.htm)) when the hotkey is pressed. Both normal labels and [hotkey](../Hotkeys.htm)/ [hotstring](../Hotstrings.htm) labels can be used, but if the script contains multiple labels with the same name, only the first can be used. The trailing colon(s) should not be included. If _Label_ is dynamic (e.g. %VarContainingLabelName%), [IsLabel(VarContainingLabelName)](IsLabel.htm) may be called beforehand to verify that the label exists.

[v1.1.20+]: If not a valid label name, this parameter can be the name of a function, or a single variable reference containing a [function object](../objects/Functor.htm). For example, `Hotkey #z, %FuncObj%, On` or `Hotkey #z, % FuncObj, On`. Other expressions which return objects are currently unsupported. When the hotkey executes, the function is called without parameters. Hotkeys can also be [defined as functions](../Hotkeys.htm#Function) without the Hotkey command.

This parameter can be left blank if _KeyName_ already exists as a hotkey, in which case its label will not be changed. This is useful to change only the hotkey's _Options_.

**Note**: If the label or function is specified but the hotkey is disabled from a previous use of this command, the hotkey will remain disabled. To prevent this, include the word ON in _Options_.

This parameter can also be one of the following special values:

**On**: The hotkey becomes enabled. No action is taken if the hotkey is already On.

**Off**: The hotkey becomes disabled. No action is taken if the hotkey is already Off.

**Toggle**: The hotkey is set to the opposite state (enabled or disabled).

**AltTab** (and others): These are special Alt-Tab hotkey actions that are described [here](../Hotkeys.htm#alttab).

**Caution:** Defining a label named On, Off, Toggle or AltTab (or any variation recognized by this command) may cause inconsistent behavior. It is strongly recommended that these values not be used as label names.

Options

A string of zero or more of the following letters with optional spaces in between. For example: `UseErrorLevel B0`.

**UseErrorLevel**: If the command encounters a problem, this option skips the warning dialog, sets [ErrorLevel](../misc/ErrorLevel.htm) to one of the codes from the table [below](#ErrorLevel), then allows the [current thread](../misc/Threads.htm) to continue.

**On**: Enables the hotkey if it is currently disabled.

**Off**: Disables the hotkey if it is currently enabled. This is typically used to create a hotkey in an initially-disabled state.

**B** or **B0**: Specify the letter B to buffer the hotkey as described in [#MaxThreadsBuffer](_MaxThreadsBuffer.htm). Specify B0 (B with the number 0) to disable this type of buffering.

**Pn**: Specify the letter P followed by the hotkey's [thread priority](../misc/Threads.htm). If the P option is omitted when creating a hotkey, 0 will be used.

**Tn**: Specify the letter T followed by a the number of threads to allow for this hotkey as described in [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm). For example: `T5`.

**In** (InputLevel) [v1.1.23+]: Specify the letter I (or i) followed by the hotkey's [input level](_InputLevel.htm). For example: `I1`.

If any of the option letters are omitted and the hotkey already exists, those options will not be changed. But if the hotkey does not yet exist -- that is, it is about to be created by this command -- the options will default to those most recently in effect. For example, the instance of [#MaxThreadsBuffer](_MaxThreadsBuffer.htm) that occurs closest to the bottom of the script will be used. If [#MaxThreadsBuffer](_MaxThreadsBuffer.htm) does not appear in the script, its default setting (OFF in this case) will be used. This behavior also applies to [#IfWin](_IfWinActive.htm): the bottommost occurrence applies to newly created hotkeys unless " [Hotkey IfWin](#IfWin)" has executed since the script started.

IfWinActive

 IfWinExist

 IfWinNotActive

 IfWinNotExist

 If, Expression

 If, % FunctionObject

These sub-commands make all subsequently-created hotkeys context sensitive. See [below](#IfWin) for details.

WinTitle

 WinText

Within these parameters, any variable reference such as %var% becomes permanent the moment the command finishes. In other words, subsequent changes to the contents of the variable are not seen by existing IfWin hotkeys.

Like [#IfWinActive/Exist](_IfWinActive.htm), _WinTitle_ and _WinText_ use the default settings for [SetTitleMatchMode](SetTitleMatchMode.htm) and [DetectHiddenWindows](DetectHiddenWindows.htm) as set in the [auto-execute section](../Scripts.htm#auto). See [#IfWinActive/Exist](_IfWinActive.htm) for details.

If, Expression

[AHK\_L 4+]: Associates subsequently-created hotkeys with a given #If expression. _Expression_ must be an expression which has been used with the [#If directive](_If.htm) elsewhere in the script. Although this command is unable to create new expressions, it can create new hotkeys using an existing expression. See [#If example 4](_If.htm#ExDynamic).

**Note:** The Hotkey command uses the string that you pass to it, not the original source code. Commas and deref chars (percent signs) are interpreted _before_ the command is called, so may need to be escaped if they are part of the original expression. [Escape sequences](../misc/EscapeChar.htm) are resolved when the script loads, so only the resulting characters are considered; for example, ``Hotkey, If, x = "`t"`` and `Hotkey, If, % "x = """ A_Tab """"` both correspond to ``#If x = "`t"``.

**Known limitation:** If _Expression_ contains an `and`/ `or` operator, it is not recognized as an existing expression. As a workaround, use the equivalent `&&`/ `||` operator in both the original #If expression and the one passed to the Hotkey command.

If, % FunctionObject

[v1.1.25+]: Associates subsequently-created hotkeys with a given [function object](../objects/Functor.htm). Such hotkeys will only execute if calling the given function object yields a non-zero number. This is like `Hotkey, If, Expression`, except that each hotkey can have many [variants](#variant) (one per object). _FunctionObject_ must be a single variable (not an expression) containing an object with a _call_ method. The function or _call_ method can accept one parameter, the [name](../Variables.htm#ThisHotkey) of the hotkey.

Once passed to the Hotkey command, the object will never be deleted (but memory will be reclaimed by the OS when the process exits).

The ["three-key combination" example](#ExampleIfFn) below uses this sub-command.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is changed only when: 1) the first parameter is IfWin[Not]Active/Exist, in which case it is set to 1 if there was a problem or 0 otherwise; or 2) the word UseErrorLevel is present in the _Options_ parameter.

[v1.1.25+]: If the first parameter is "If", an exception is thrown if the second parameter is invalid or a memory allocation fails. ErrorLevel is not set in those cases, but is still set to 0 on success.

ErrorDescription1The _Label_ parameter specifies a nonexistent label name.2The _KeyName_ parameter specifies one or more keys that are either not recognized or not supported by the current keyboard layout/language.3Unsupported prefix key. For example, using the mouse wheel as a prefix in a hotkey such as `WheelDown & Enter` is not supported.4The _KeyName_ parameter is not suitable for use with the [AltTab or ShiftAltTab](../Hotkeys.htm#alttab) actions. A combination of (at most) two keys is required. For example: `RControl & RShift::AltTab`.5The command attempted to modify a nonexistent hotkey.6The command attempted to modify a nonexistent [variant](#variant) of an existing hotkey. To solve this, use [Hotkey IfWin](#IfWin) to set the criteria to match those of the hotkey to be modified.98Creating this hotkey would exceed the limit of hotkeys per script (however, each hotkey can have an unlimited number of [variants](#variant), and there is no limit to the number of [hotstrings](../Hotstrings.htm)). The limit was raised from 700 to 1000 in [v1.0.48], and to 32762 in [v1.1.30].99Out of memory. This is very rare and usually happens only when the operating system has become unstable.

Tip: The UseErrorLevel option can be used to test for the existence of a hotkey variant. For example:

```
Hotkey, ^!p,, UseErrorLevel
if ErrorLevel in 5,6
    MsgBox The hotkey does not exist or it has no variant for the current IfWin criteria.
```

## Remarks

The [current IfWin setting](#IfWin) determines the [variant](#variant) of a hotkey upon which the Hotkey command will operate.

If the goal is to disable selected hotkeys or hotstrings automatically based on the type of window that is active, `Hotkey, ^!c, Off` is usually less convenient than using [#IfWinActive/Exist](_IfWinActive.htm) (or their dynamic counterparts "Hotkey IfWinActive/Exist" [below](#IfWin)).

Creating hotkeys via [double-colon labels](../Hotkeys.htm) performs better than using the Hotkey command because the hotkeys can all be enabled as a batch when the script starts (rather than one by one). Therefore, it is best to use this command to create only those hotkeys whose key names are not known until after the script has started running. One such case is when a script's hotkeys for various actions are configurable via an [INI file](IniRead.htm).

A given label can be the target of more than one hotkey. If it is known that a label was called by a hotkey, you can determine which hotkey by checking the built-in variable [A\_ThisHotkey](../Variables.htm#ThisHotkey).

If the script is [suspended](Suspend.htm), newly added/enabled hotkeys will also be suspended until the suspension is turned off (unless they are exempt as described in the [Suspend](Suspend.htm) section).

The [keyboard](_InstallKeybdHook.htm) and/or [mouse](_InstallMouseHook.htm) hooks will be installed or removed if justified by the changes made by this command.

Although the Hotkey command cannot directly enable or disable hotkeys in scripts other than its own, in most cases it can [override](../misc/Override.htm) them by creating or enabling the same hotkeys. Whether this works depends on a combination of factors: 1) Whether the hotkey to be overridden is a [hook hotkey](ListHotkeys.htm) in the other script (non-hook hotkeys can always be overridden); 2) The fact that the most recently started script's hotkeys generally take precedence over those in other scripts (therefore, if the script intending to override was started most recently, its override should always succeed); 3) Whether the enabling or creating of this hotkey will newly activate the [keyboard](_InstallKeybdHook.htm) or [mouse](_InstallMouseHook.htm) hook (if so, the override will always succeed).

Once a script has at least one hotkey, it becomes persistent, meaning that [ExitApp](ExitApp.htm) rather than Exit should be used to terminate it. Hotkey scripts are also automatically [#SingleInstance](_SingleInstance.htm) unless `#SingleInstance Off` has been specified.

## Remarks About _Hotkey, If_

The "Hotkey If" commands allow context-sensitive [hotkeys](../Hotkeys.htm) to be created and modified while the script is running (by contrast, the [#If](_If.htm) and [#IfWinActive/Exist](_IfWinActive.htm) directives are positional and take effect before the script begins executing). For example:

```
Hotkey, IfWinActive, ahk_class Notepad
Hotkey, ^!e, MyLabel  <em>; Creates a hotkey that works only in Notepad.</em>
```

Using "Hotkey If" puts context sensitivity into effect for all subsequently created or modified [hotkeys](../Hotkeys.htm). In addition, each If sub-command is mutually exclusive; that is, only the most recent one will be in effect.

To turn off context sensitivity (that is, to make subsequently-created hotkeys work in all windows), specify any If sub-command but omit the parameters. For example: `Hotkey, If` or `Hotkey, IfWinActive`.

If "Hotkey If" is never used by a script, the bottommost use of any [#If](_If.htm) or [#IfWin](_IfWinActive.htm) directive (if any) will be in effect for the Hotkey command.

When a mouse or keyboard hotkey is disabled via an If sub-command or directive, it performs its native function; that is, it passes through to the active window as though there is no such hotkey. However, joystick hotkeys always pass through, whether they are disabled or not.

## Variant (Duplicate) Hotkeys

A particular hotkey can be created more than once if each definition has different IfWin criteria. These are known as _hotkey variants_. For example:

```
Hotkey, IfWinActive, ahk_class Notepad
Hotkey, ^!c, MyLabelForNotepad
Hotkey, IfWinActive, ahk_class WordPadClass
Hotkey, ^!c, MyLabelForWordPad
Hotkey, IfWinActive
Hotkey, ^!c, MyLabelForAllOtherWindows
```

If more than one variant of a hotkey is eligible to fire, only the one created earliest will fire. The exception to this is the global variant (the one with no IfWin criteria): It always has the lowest precedence, and thus will fire only if no other variant is eligible.

When creating duplicate hotkeys, the order of [modifier symbols](../Hotkeys.htm#Symbols) such as ^!+# does not matter. For example, `^!c` is the same as `!^c`. However, keys must be spelled consistently. For example, _Esc_ is not the same as _Escape_ for this purpose (though the case does not matter). Finally, any hotkey with a [wildcard prefix (\*)](../Hotkeys.htm#wildcard) is entirely separate from a non-wildcard one; for example, `*F1` and `F1` would each have their own set of variants.

For more information about IfWin hotkeys, see [#IfWin's General Remarks](_IfWinActive.htm#gen).

## Related

[Hotkey Symbols](../Hotkeys.htm#Symbols), [#IfWinActive/Exist](_IfWinActive.htm), [#MaxThreadsBuffer](_MaxThreadsBuffer.htm), [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm), [Suspend](Suspend.htm), [IsLabel()](IsLabel.htm), [Threads](../misc/Threads.htm), [Thread](Thread.htm), [Critical](Critical.htm), [Gosub](Gosub.htm), [Return](Return.htm), [Menu](Menu.htm), [SetTimer](SetTimer.htm)

## Examples

Creates a Ctrl-Alt-Z hotkey.

```
Hotkey, ^!z, MyLabel
return

MyLabel:
MsgBox You pressed %A_ThisHotkey%.
return
```

Makes RCtrl & RShift operate like Alt-Tab.

```
Hotkey, RCtrl & RShift, AltTab
```

Re-enables the Win-C hotkey.

```
Hotkey, #c, On
```

Disables the Shift-Win-C hotkey.

```
Hotkey, $+#c, Off
```

Changes a hotkey to allow 5 threads.

```
Hotkey, ^!a, , T5
```

Creates a Ctrl-Alt-C hotkey that works only in Notepad.

```
Hotkey, IfWinActive, ahk_class Notepad
Hotkey, ^!c, MyLabelForNotepad
```

Creates a GUI that allows to register primitive three-key combination hotkeys.

```
Gui Add, Text, xm, Prefix key:
Gui Add, Edit, yp x100 w100 vPrefix, Space
Gui Add, Text, xm, Suffix hotkey:
Gui Add, Edit, yp x100 w100  vSuffix, f & j
Gui Add, Button, Default, Register
Gui Show
return

ButtonRegister() {
    global
    Gui Submit, NoHide
    local fn
    fn := Func("HotkeyShouldFire").Bind(Prefix)
    Hotkey If, % fn
    Hotkey % Suffix, FireHotkey
}

HotkeyShouldFire(prefix, thisHotkey) {
    return GetKeyState(prefix)
}

FireHotkey() {
    MsgBox %A_ThisHotkey%
}

GuiClose:
GuiEscape:
ExitApp
```

