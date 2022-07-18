# Return

Returns from a subroutine to which execution had previously jumped via [function-call](../Functions.htm), [Gosub](Gosub.htm), [Hotkey](../Hotkeys.htm) activation, [GroupActivate](GroupActivate.htm), or other means.

```
<span class="func">Return</span> <span class="optional">, Expression</span>
```

## Parameters

Expression

This parameter should be omitted except when `return` is used inside a [function](../Functions.htm).

Since this parameter is an [expression](../Variables.htm#Expressions), all of the following are valid examples:

```
return 3
return "literal string"
return MyVar
return i + 1
return true  <em>; Returns the number 1 to mean "true".</em>
return ItemCount < MaxItems  <em>; Returns a true or false value.</em>
return FindColor(TargetColor)
```

**Known limitation**: For backward compatibility and ease-of-use, the following two examples are functionally identical:

```
return MyVar
return %MyVar%
```

In other words, a single variable enclosed in percent signs is treated as a non-expression. To work around this, make it unambiguously an expression by enclosing it in parentheses; for example: `return (%MyVar%)`.

## Remarks

If there is no caller to which to return, _Return_ will do an [Exit](Exit.htm) instead.

There are various ways to return multiple values from function to caller described within [Returning Values to Caller](../Functions.htm#return).

## Related

[Functions](../Functions.htm), [Gosub](Gosub.htm), [Exit](Exit.htm), [ExitApp](ExitApp.htm), [GroupActivate](GroupActivate.htm)

## Examples

The first Return separates the hotkey from the subroutine below. If it were not present, pressing the hotkey would cause `Sleep 1000` to be executed twice.

```
#z::
MsgBox The Win-Z hotkey was pressed.
Gosub MySubroutine
return

MySubroutine:
Sleep 1000
return
```

