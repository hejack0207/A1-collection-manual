# StrReplace() [v1.1.21+]

Replaces the specified substring with a new string.

```
ReplacedStr := <span class="func">StrReplace</span>(Haystack, Needle <span class="optional">, ReplaceText, OutputVarCount, Limit</span>)
```

## Parameters

HaystackThe string whose content is searched and replaced.NeedleThe string to search for. Matching is not case sensitive unless [StringCaseSense](StringCaseSense.htm) has been turned on.ReplaceText_Needle_ will be replaced with this text. If omitted or blank, _Needle_ will be replaced with blank (empty). In other words, it will be omitted from the return value.OutputVarCountSpecify a variable in which to store the number of replacements that occurred (0 if none).LimitIf omitted, it defaults to -1, which replaces **all** occurrences of the pattern found in _Haystack_. Otherwise, specify the maximum number of replacements to allow. The part of _Haystack_ to the right of the last replacement is left unchanged.

## Return Value

This function returns a version of _Haystack_ whose contents have been replaced by the operation. If no replacements are needed, _Haystack_ is returned unaltered.

## Remarks

The built-in variables [A\_Space](../Variables.htm) and [A\_Tab](../Variables.htm) contain a single space and a single tab character, respectively. They are useful when searching for spaces and tabs alone or at the beginning or end of _Needle_.

## Related

[StringReplace](StringReplace.htm), [RegExReplace()](RegExReplace.htm), [InStr()](InStr.htm), [StringCaseSense](StringCaseSense.htm), [SubStr()](SubStr.htm), [Trim()](Trim.htm), [StrLen()](StrLen.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm)

## Examples

Removes all CR+LF's from the clipboard contents.

```
Clipboard := StrReplace(Clipboard, "`r`n")
```

Replaces all spaces with pluses.

```
NewStr := StrReplace(OldStr, A_Space, "+")
```

Removes all blank lines from the text in a variable.

```
Loop
{
    MyString := StrReplace(MyString, "`r`n`r`n", "`r`n", Count)
    if (Count = 0)  <em>; No more replacements needed.</em>
        break
}
```

