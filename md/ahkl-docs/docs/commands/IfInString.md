# IfInString / IfNotInString

Checks if a [variable](../Variables.htm) contains the specified string.

**Deprecated:** These commands are not recommended for use in new scripts. Use the [InStr](InStr.htm) function instead.

```
<span class="func">IfInString</span>, Var, SearchString
<span class="func">IfNotInString</span>, Var, SearchString

```

## Parameters

Var

The name of the [variable](../Variables.htm) whose contents will be searched for a match.

SearchString

The string to search for. Matching is not case sensitive unless [StringCaseSense](StringCaseSense.htm) has been turned on.

## Remarks

The built-in variables [%A\_Space%](../Variables.htm) and [%A\_Tab%](../Variables.htm) contain a single space and a single tab character, respectively, which might be useful when searching for these characters alone.

Another command can appear on the same line as this one. In other words, both of these are equivalent:

```
IfInString, MyVar, abc, Gosub, Process1
IfInString, MyVar, abc
    Gosub, Process1
```

However, items other than named commands are not supported on the same line. For example:

```
IfInString, MyVar, abc, found := true  <em><strong>; Invalid.</strong></em>
```

## Related

[InStr()](InStr.htm), [RegExMatch()](RegExMatch.htm), [StringGetPos](StringGetPos.htm), [StringCaseSense](StringCaseSense.htm), [IfEqual](IfEqual.htm), [if var in/contains MatchList](IfIn.htm), [if var between](IfBetween.htm), [if var is type](IfIs.htm), [Blocks](Block.htm), [Else](Else.htm)

## Examples

Checks whether Haystack contains the substring "abc".

```
Haystack := "abcdefghijklmnopqrs"
Needle := "abc"
IfInString, Haystack, %Needle%
{
    MsgBox, The string was found.
    return
}
else
    Sleep, 1
```

