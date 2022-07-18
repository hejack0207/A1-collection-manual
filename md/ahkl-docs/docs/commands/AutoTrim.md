# AutoTrim

Determines whether [traditional assignments](SetEnv.htm) like `Var1 = %Var2%` omit spaces and tabs from the beginning and end of _Var2_.

```
<span class="func">AutoTrim</span>, OnOff
```

## Parameters

OnOff

**On**: In a [traditional assignment](SetEnv.htm) like `Var1 = %Var2%`, tabs and spaces at the beginning and end of a _Var2_ are omitted from _Var1_. This is the default.

**Off**: Such tabs and spaces are not omitted.

[v1.1.30+]: The decimal values 1 and 0 may be used in place of On and Off, respectively.

Any literal tabs and spaces are omitted regardless of this setting. Prior to [v1.1.06], this included \`t and any escaped literal spaces or tabs. For example, when AutoTrim is Off, the statement ``Var = `t`` assigns a tab character on [v1.1.06] and an empty string on earlier versions.

## Remarks

If this command is not used by a script, the setting defaults to ON.

The built-in variable **A\_AutoTrim** contains the current setting (On or Off).

The built-in variables [A\_Space](../Variables.htm#Space) and [A\_Tab](../Variables.htm#Tab) contain a single space and single tab character, respectively.

AutoTrim does not affect [expression assignments](SetExpression.htm) such as `Var := " string "`. In other words, leading and trailing spaces and tabs are always retained in such cases.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[SetEnv](SetEnv.htm)

## Examples

Disables the automatic omission of leading and trailing spaces and tabs when assigning a variable using the equals operator.

```
AutoTrim, Off
NewVar1 = %OldVar%  <em>; If OldVar contains leading and trailing spaces, NewVar will have them too.</em>
NewVar2 = %A_Space%  <em>; With AutoTrim off, a single space can be assigned this way.</em>

Var1 := "`t" <strong>.</strong> Var2 <strong>.</strong> " "  <em>; The setting of AutoTrim doesn't matter because this is an <a href="../Variables.htm#Expressions" data-index="12">expression</a>.</em>
```

