# StringGetPos

Retrieves the position of the specified substring within a string.

**Deprecated:** This command is not recommended for use in new scripts. Use the [InStr](InStr.htm) function instead.

```
<span class="func">StringGetPos</span>, OutputVar, InputVar, SearchText <span class="optional">, Occurrence, Offset</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved position relative to the first character of _InputVar_. Position 0 is the first character for StringGetPos and position 1 is the first character for [InStr()](InStr.htm).

InputVar

The name of the input variable, whose contents will be searched. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.

SearchText

The string to search for. Matching is not case sensitive unless [StringCaseSense](StringCaseSense.htm) has been turned on.

Occurrence

This affects which occurrence will be found if _SearchText_ occurs more than once within _InputVar_. If this parameter is omitted, it defaults to L1 (meaning _InputVar_ will be searched starting from the left for the first match). To change this behavior, specify one of the following options:

**L _n_:** The search will start looking at the left side of _InputVar_ and will continue rightward until the _n_ th match is found.

**R _n_:** The search will start looking at the right side of _InputVar_ and will continue leftward until the _n_ th match is found. If _n_ is omitted (or if _Occurrence_ is 1), it defaults to R1.

For example, to find the fourth occurrence from the right, specify R4. Note: If _n_ is less than or equal to zero, no match will be found.

Offset

The number of characters on the leftmost or rightmost side (depending on the parameter above) to skip over. If omitted, the default is 0. For example, the following would start searching at the tenth character from the left: `StringGetPos, OutputVar, InputVar, abc, , 9`. This parameter can be an [expression](../Variables.htm#Expressions).

## ErrorLevel

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the specified occurrence of _SearchText_ could not be found within _InputVar_, or 0 otherwise.

## Remarks

Unlike [StringMid](StringMid.htm) and [InStr()](InStr.htm), 0 is defined as the position of the first character for StringGetPos.

The retrieved position is always relative to the first character of _InputVar_, regardless of whether _Occurrence_ and/or _Offset_ are specified. For example, if the string "abc" is found in 123abc789, its reported position will always be 3 regardless of the method by which it was found.

If the specified occurrence of _SearchText_ does not exist within _InputVar_, _OutputVar_ will be set to -1 and [ErrorLevel](../misc/ErrorLevel.htm) will be set to 1.

Use [SplitPath](SplitPath.htm) to more easily parse a file path into its directory, filename, and extension.

The built-in variables [%A\_Space%](../Variables.htm) and [%A\_Tab%](../Variables.htm) contain a single space and a single tab character, respectively. They are useful when searching for spaces and tabs alone or at the beginning or end of _SearchText_.

## Related

[InStr()](InStr.htm), [RegExMatch()](RegExMatch.htm), [IfInString](IfInString.htm), [if var in/contains MatchList](IfIn.htm), [StringCaseSense](StringCaseSense.htm), [StringReplace](StringReplace.htm), [SplitPath](SplitPath.htm), [StringLeft](StringLeft.htm), [StringRight](StringLeft.htm), [StringMid](StringMid.htm), [StringTrimLeft](StringTrimLeft.htm), [StringTrimRight](StringTrimLeft.htm), [StringLen](StringLen.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [if var is type](IfIs.htm)

## Examples

Retrieves and analyzes the position of a substring.

```
Haystack := "abcdefghijklmnopqrs"
Needle := "def"
StringGetPos, pos, Haystack, %Needle%
if (pos >= 0)
    MsgBox, The string was found at position %pos%.
```

Divides up the full path name of a file into components. Note that it would be much easier to use [StrSplit()](StrSplit.htm), [StringSplit](StringSplit.htm) or a [parsing loop](LoopParse.htm) to do this, so the below is just for illustration.

```
FileSelectFile, file, , , Pick a filename in a deeply nested folder:
if (file != "")
{
    pos_prev := StrLen(file)
    pos_prev += 1 <em>; Adjust to be the position after the last char.</em>
    Loop
    {
        <em>; Search from the right for the Nth occurrence:</em>
        StringGetPos, pos, file, \, R%A_Index%
        if ErrorLevel
            break
        length := pos_prev - pos - 1
        pos_prev := pos
        pos += 2  <em>; Adjust for use with StringMid.</em>
        StringMid, path_component, file, %pos%, %length%
        MsgBox Path component #%A_Index% (from the right) is:`n%path_component%
    }
}
```

