# StrSplit() [v1.1.13+]

Separates a string into an array of substrings using the specified delimiters.

```
Array := <span class="func">StrSplit</span>(String <span class="optional">, Delimiters, OmitChars, MaxParts</span>)
```

## Parameters

String

A string to split.

Delimiters

If this parameter is blank or omitted, each character of the input string will be treated as a separate substring.

Otherwise, _Delimiters_ can be either a single string or an array of strings, each of which is used to determine where the boundaries between substrings occur. Since the delimiters are not considered to be part of the substrings themselves, they are never included in the returned array. Also, if there is nothing between a pair of delimiters within the input string, the corresponding array element will be blank.

For example: `","` would divide the string based on every occurrence of a comma. Similarly, `[A_Tab, A_Space]` would create a new array element every time a space or tab is encountered in the input string.

OmitChars

An optional list of characters (case sensitive) to exclude from the beginning and end of each array element. For example, if _OmitChars_ is ``" `t"``, spaces and tabs will be removed from the beginning and end (but not the middle) of every element.

If _Delimiters_ is blank, _OmitChars_ indicates which characters should be excluded from the array.

MaxParts [v1.1.28+]If omitted, it defaults to -1, which means "no limit". Otherwise, specify the maximum number of substrings to return. If non-zero, the string is split a maximum of _MaxParts_-1 times and the remainder of the string is returned in the last substring (excluding any leading or trailing _OmitChars_).

## Return Value

This function returns an [array](../Objects.htm#Usage_Simple_Arrays) (object) of strings.

## Remarks

Whitespace characters such as spaces and tabs will be preserved unless those characters are themselves delimiters or included in _OmitChars_. Tabs and spaces can be trimmed from both ends of any variable by calling the [Trim](Trim.htm) function. For example: `MyArray1 := Trim(MyArray1)`.

To split a string that is in standard CSV (comma separated value) format, use a [parsing loop](LoopParse.htm) since it has built-in CSV handling.

To arrange the fields in a different order prior to splitting them, use the [Sort](Sort.htm) command.

If you do not need the substrings to be permanently stored in memory, consider using a [parsing loop](LoopParse.htm) \-\- especially if _String_ is very large, in which case a large amount of memory would be saved. For example:

```
Colors := "red,green,blue"
Loop, Parse, Colors, % ","
    MsgBox % "Color number " A_Index " is " A_LoopField
```

## Related

[StringSplit](StringSplit.htm), [Parsing loop](LoopParse.htm), [Arrays](../misc/Arrays.htm), [Sort](Sort.htm), [SplitPath](SplitPath.htm), [InStr()](InStr.htm), [SubStr()](SubStr.htm), [StrLen()](StrLen.htm), [StringLower](StringLower.htm), [StringUpper](StringLower.htm), [StrReplace()](StrReplace.htm)

## Examples

Separates a sentence into an array of words and reports the fourth word.

```
TestString := "This is a test."
word_array := StrSplit(TestString, A_Space, ".") <em>; Omits periods.</em>
MsgBox % "The 4th word is " word_array[4]
```

Separates a comma-separated list of colors into an array of substrings and traverses them, one by one.

```
colors := "red,green,blue"
for index, color in StrSplit(colors, ",")
    MsgBox % "Color number " index " is " color
```

