# StringCaseSense

Determines whether string comparisons are case sensitive (default is "not case sensitive").

```
<span class="func">StringCaseSense</span>, OnOffLocale
```

## Parameters

OnOffLocale

Specify one of the following words:

**On**: String comparisons are case sensitive. This setting also makes the [expression equal sign operator (=)](../Variables.htm#equal) and the case-insensitive mode of [InStr()](InStr.htm) use the _locale_ method described below.

**Off** (starting default): The letters A-Z are considered identical to their lowercase counterparts. This is the starting default for all scripts due to backward compatibility and performance ( _Locale_ is 1 to 8 times slower than _Off_ depending on the nature of the strings being compared).

**Locale**[v1.0.43.03+]: String comparisons are case **in** sensitive according to the rules of the current user's locale. For example, most English and Western European locales treat not only the letters A-Z as identical to their lowercase counterparts, but also ANSI letters like Ä and Ü as identical to theirs.

[v1.1.30+]: The decimal values 1 and 0 may be used in place of On and Off, respectively.

## Remarks

This setting applies to:

- [Expression comparison operators](../Variables.htm#equal) (except ==). However, since the [equal-sign operator (=)](../Variables.htm#equal) is always case-insensitive, it uses the _Locale_ mode when _StringCaseSense_ is _On_, as does the case-insensitive mode of [InStr()](InStr.htm).
- [IfInString](IfInString.htm), [StringGetPos](StringGetPos.htm), and [InStr()](InStr.htm). However, InStr() is not affected when its _CaseSensitive_ parameter is _true_.
- [StrReplace()](StrReplace.htm) and [StringReplace](StringReplace.htm).
- [if var in/contains MatchList](IfIn.htm), [if var between](IfBetween.htm), and [IfEqual and its family](IfEqual.htm).
- [AHK\_L 42+]: [if var is [not] type](IfIs.htm) respects the system locale only if the _Locale_ mode is in effect.

The built-in variable **A\_StringCaseSense** contains the current setting (the word On, Off, or Locale).

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[IfEqual](IfEqual.htm), [IfInString](IfInString.htm), [if var between](IfBetween.htm), [StrReplace()](StrReplace.htm), [StringGetPos](StringGetPos.htm), [StringReplace](StringReplace.htm)

## Examples

Makes string comparisons case insensitive according to the rules of the current user's locale.

```
StringCaseSense Locale
```

