# StringReplace

Replaces the specified substring with a new string.

**Deprecated:** This command is not recommended for use in new scripts. Use the [StrReplace](StrReplace.htm) function instead.

```
<span class="func">StringReplace</span>, OutputVar, InputVar, SearchText <span class="optional">, ReplaceText, ReplaceAll</span>
```

## Parameters

OutputVarThe name of the variable in which to store the result of the replacement process.InputVarThe name of the variable whose contents will be read from. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.SearchTextThe string to search for. Matching is not case sensitive unless [StringCaseSense](StringCaseSense.htm) has been turned on.ReplaceText_SearchText_ will be replaced with this text. If omitted or blank, _SearchText_ will be replaced with blank (empty). In other words, it will be omitted from _OutputVar_.ReplaceAll

If omitted, only the first occurrence of _SearchText_ will be replaced. But if this parameter is 1, A, or All, all occurrences will be replaced.

Specify the word **UseErrorLevel** to store in ErrorLevel the number of occurrences replaced (0 if none). UseErrorLevel implies "All".

## ErrorLevel

When the last parameter is _UseErrorLevel_, [ErrorLevel](../misc/ErrorLevel.htm) is given the number occurrences replaced (0 if none). Otherwise, ErrorLevel is set to 1 if _SearchText_ is not found within _InputVar_, or 0 if it is found.

## Remarks

For this and all other commands, _OutputVar_ is allowed to be the same variable as an _InputVar_.

The built-in variables [%A\_Space%](../Variables.htm) and [%A\_Tab%](../Variables.htm) contain a single space and a single tab character, respectively. They are useful when searching for spaces and tabs alone or at the beginning or end of _SearchText_.

[v1.0.45+]: The AllSlow option became obsolete due to improvements to performance and memory utilization. Although it may still be specified, it has no effect.

## Related

[StrReplace()](StrReplace.htm), [RegExReplace()](RegExReplace.htm), [IfInString](IfInString.htm), [StringCaseSense](StringCaseSense.htm), [StringLeft](StringLeft.htm), [StringRight](StringLeft.htm), [StringMid](StringMid.htm), [StringTrimLeft](StringTrimLeft.htm), [StringTrimRight](StringTrimLeft.htm), [StringLen](StringLen.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [StringGetPos](StringGetPos.htm), [if var is type](IfIs.htm)

## Examples

Removes all CR+LF's from the clipboard contents.

```
StringReplace, Clipboard, Clipboard, `r`n, , All
```

Replaces all spaces with pluses.

```
StringReplace, NewStr, OldStr, %A_Space%, +, All
```

Removes all blank lines from the text in a variable.

```
Loop
{
    StringReplace, MyString, MyString, `r`n`r`n, `r`n, UseErrorLevel
    if (ErrorLevel = 0)  <em>; No more replacements needed.</em>
        break
}
```

