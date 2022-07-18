# StringSplit

Separates a string into an array of substrings using the specified delimiters.

**Deprecated:** This command is not recommended for use in new scripts. Use the [StrSplit](StrSplit.htm) function instead.

```
<span class="func">StringSplit</span>, OutputArray, InputVar <span class="optional">, Delimiters, OmitChars</span>
```

## Parameters

OutputArray

The name of the [pseudo-array](../misc/Arrays.htm#pseudo) in which to store each substring extracted from _InputVar_. For example, if MyArray is specified, the command will put the number of substrings produced (0 if none) into MyArray0, the first substring into MyArray1, the second into MyArray2, and so on.

Within a [function](../Functions.htm), to create a pseudo-array that is global instead of local, [declare](../Functions.htm#Global) MyArray0 as a global variable inside the function (the converse is true for [assume-global](../Functions.htm#AssumeGlobal) functions). However, it is often also necessary to declare each element, due to a [common source of confusion](../Functions.htm#ArrayConfusion). For more details, see [Functions](../Functions.htm#PseudoArrays).

InputVar

The name of the variable whose contents will be analyzed. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.

**Note**: _InputVar_ must not be one of the variables in _OutputArray_.

Delimiters

If this parameter is blank or omitted, each character of _InputVar_ will be treated as a separate substring.

Otherwise, _Delimiters_ contains one or more characters (case sensitive), each of which is used to determine where the boundaries between substrings occur in _InputVar_. Since the delimiter characters are not considered to be part of the substrings themselves, they are never copied into _OutputArray_. Also, if there is nothing between a pair of delimiters within _InputVar_, the corresponding array element will be blank.

For example: `` `,`` (an escaped comma) would divide the string based on every occurrence of a comma. Similarly, %A\_Tab%%A\_Space% would create a new array element every time a space or tab is encountered in _InputVar_.

To use a string as a delimiter rather than a character, first use [StrReplace()](StrReplace.htm) or [StringReplace](StringReplace.htm) to replace all occurrences of the string with a single character that is never used literally in the text. Consider this example, which uses the string <br> as a delimiter:

```
StringReplace, NewHTML, HTMLString, <br>, ``, All  <em>; Replace each <br> with an accent.</em>
StringSplit, MyArray, NewHTML, ``  <em>; Split the string based on the accent character.</em>
```

OmitChars

An optional list of characters (case sensitive) to exclude from the beginning and end of each array element. For example, if _OmitChars_ is `%A_Space%%A_Tab%`, spaces and tabs will be removed from the beginning and end (but not the middle) of every element.

If _Delimiters_ is blank, _OmitChars_ indicates which characters should be excluded from the array.

Unlike the last parameter of most other commands, commas in _OmitChars_ must be escaped (\`,).

## Remarks

If the array elements already exist, the command will change the values of only the first N elements, where N is the number of substrings present in _InputVar_. Any elements beyond N that existed beforehand will be unchanged. Therefore, it is safest to use the zero element (MyArray0) to determine how many items were actually produced by the command.

Whitespace characters such as spaces and tabs will be preserved unless those characters are themselves delimiters or included in _OmitChars_. Tabs and spaces can be trimmed from both ends of any variable by assigning it to itself while [AutoTrim](AutoTrim.htm) is on (the default). For example: `MyArray1 = %MyArray1%`.

To split a string that is in standard CSV (comma separated value) format, use a [parsing loop](LoopParse.htm) since it has built-in CSV handling.

To arrange the fields in a different order prior to splitting them, use the [Sort](Sort.htm) command.

If you do not need the substrings to be permanently stored in memory, consider using a [parsing loop](LoopParse.htm) \-\- especially if _InputVar_ is very large, in which case a large amount of memory would be saved. For example:

```
Colors := "red,green,blue"
Loop, Parse, Colors, `,
    MsgBox Color number %A_Index% is %A_LoopField%.
```

## Related

[StrSplit()](StrSplit.htm), [Parsing loop](LoopParse.htm), [Arrays](../misc/Arrays.htm), [Sort](Sort.htm), [SplitPath](SplitPath.htm), [IfInString](IfInString.htm), [StringGetPos](StringGetPos.htm), [StringMid](StringMid.htm), [StringTrimLeft](StringTrimLeft.htm), [StringTrimRight](StringTrimLeft.htm), [StringLen](StringLen.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [StringReplace](StringReplace.htm)

## Examples

Separates a sentence into an array of words and reports the fourth word.

```
TestString := "This is a test."
StringSplit, word_array, TestString, %A_Space%, .  <em>; Omits periods.</em>
MsgBox, The 4th word is %word_array4%.
```

Separates a comma-separated list of colors into an array of substrings and traverses them, one by one.

```
Colors := "red,green,blue"
StringSplit, ColorArray, Colors, `,
Loop, %ColorArray0%
{
    this_color := ColorArray%A_Index%
    MsgBox, Color number %A_Index% is %this_color%.
}
```

