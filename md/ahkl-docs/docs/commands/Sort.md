# Sort

Arranges a variable's contents in alphabetical, numerical, or random order (optionally removing duplicates).

```
<span class="func">Sort</span>, VarName <span class="optional">, Options</span>
```

## Parameters

VarName

The name of the variable whose contents will be sorted. This cannot be an expression.

Options

See list below.

## Options

A string of zero or more of the following letters (in any order, with optional spaces in between):

**C**: Case sensitive sort (ignored if the **N** option is also present). If both **C** and **CL** are omitted, the uppercase letters A-Z are considered identical to their lowercase counterparts for the purpose of the sort.

**CL**[v1.0.43.03+]: Case insensitive sort based on the current user's locale. For example, most English and Western European locales treat the letters A-Z and ANSI letters like Ä and Ü as identical to their lowercase counterparts. This method also uses a "word sort", which treats hyphens and apostrophes in such a way that words like "coop" and "co-op" stay together. Depending on the content of the items being sorted, the performance will be 1 to 8 times worse than the default method of insensitivity.

**Dx**: Specifies **x** as the delimiter character, which determines where each item in _VarName_ begins and ends. The delimiter is always case-sensitive. If this option is not present, **x** defaults to linefeed (\`n). In most cases this will work even if lines end with CR+LF (\`r\`n), but the carriage return (\`r) is included in comparisons and therefore affects the sort order. For example, ``B`r`nA`` will sort as expected, but ``A`r`nA`t`r`nB`` will place ``A`t`r`` before ``A`r``.

**F MyFunction**[v1.0.47+]: Uses custom sorting according to the criteria in _MyFunction_ (though sorting takes much longer). Specify the letter "F" followed by optional spaces/tabs followed by the name of a [function](../Functions.htm) to be used for comparing any two items in the list. The function must accept two or three parameters. When the function deems the first parameter to be greater than the second, it should return a positive integer; when it deems the two parameters to be equal, it should return 0, "", or nothing; otherwise, it should return a negative integer. If a decimal point is present in the returned value, that part is ignored (i.e. 0.8 is the same as 0). If present, the third parameter receives the offset (in characters) of the second item from the first as seen in the original/unsorted list (see examples). Finally, the function uses the same global settings (e.g. [StringCaseSense](StringCaseSense.htm)) as the Sort command that called it.

**Note**: The **F** option causes all other options except **D**, **Z**, and **U** to be ignored (though **N**, **C**, and **CL** still affect how [duplicates](#unique) are detected). Also, sorting does not occur when the specified function: 1) does not exist; 2) accepts fewer than two parameters; or 3) the first or second parameter is [ByRef](../Functions.htm#ByRef).

**N**: Numeric sort: Each item is assumed to be a number rather than a string (for example, if this option is not present, the string 233 is considered to be less than the string 40 due to alphabetical ordering). Both decimal and hexadecimal strings (e.g. 0xF1) are considered to be numeric. Strings that do not start with a number are considered to be zero for the purpose of the sort. Numbers are treated as 64-bit floating point values so that the decimal portion of each number (if any) is taken into account.

**Pn**: Sorts items based on character position **n** (do not use hexadecimal for **n**). If this option is not present, **n** defaults to 1, which is the position of the first character. The sort compares each string to the others starting at its **n** th character. If **n** is greater than the length of any string, that string is considered to be blank for the purpose of the sort. When used with option **N** (numeric sort), the string's character position is used, which is not necessarily the same as the number's digit position.

**R**: Sorts in reverse order (alphabetically or numerically depending on the other options).

**Random**: Sorts in random order. This option causes all other options except **D**, **Z**, and **U** to be ignored (though **N**, **C**, and **CL** still affect how duplicates are detected). Examples:

```
Sort, MyVar, Random
Sort, MyVar, Random Z D|
```

**U**: Removes duplicate items from the list so that every item is unique. [ErrorLevel](../misc/ErrorLevel.htm) is set to the number of items removed (0 if none). If the **C** option is in effect, the case of items must match for them to be considered identical. If the **N** option is in effect, an item such as 2 would be considered a duplicate of 2.0. If either the **Pn** or **\** (backslash) option is in effect, the entire item must be a duplicate, not just the substring that is used for sorting. If the **Random** or **F/Function** option is in effect, duplicates are removed only if they appear adjacent to each other as a result of the sort. For example, when "A\|B\|A" is sorted randomly, the result could contain either one or two A's.

**Z**: To understand this option, consider a variable that contains RED\`nGREEN\`nBLUE\`n. If the **Z** option is not present, the last linefeed (\`n) is considered to be part of the last item, and thus there are only 3 items. But by specifying **Z**, the last \`n (if present) will be considered to delimit a blank item at the end of the list, and thus there are 4 items (the last being blank).

**\**: Sorts items based on the substring that follows the last backslash in each. If an item has no backslash, the entire item is used as the substring. This option is useful for sorting bare filenames (i.e. excluding their paths), such as the example below, in which the AAA.txt line is sorted above the BBB.txt line because their directories are ignored for the purpose of the sort:

```
C:\BBB\AAA.txt
C:\AAA\BBB.txt
```

**Note**: Options **N** and **P** are ignored when the backslash option is present.

## Remarks

This command is typically used to sort a variable that contains a list of lines, with each line ending in a linefeed character (\`n). One way to get a list of lines into a variable is to load an entire file via [FileRead](FileRead.htm).

If _VarName_ is _Clipboard_ and the clipboard contains files (such as those copied from an open Explorer window), those files will be replaced with a sorted list of their filenames. In other words, after the operation, the clipboard will no longer contain the files themselves.

[ErrorLevel](../misc/ErrorLevel.htm) is changed by this command only when the **U** option is in effect.

The maximum capacity of a variable can be increased via [#MaxMem](_MaxMem.htm).

If a large variable was sorted and later its contents are no longer needed, you can free its memory by making it blank, e.g. `MyVar =`.

## Related

[FileRead](FileRead.htm), [file-reading loop](LoopReadFile.htm), [parsing loop](LoopParse.htm), [StrSplit()](StrSplit.htm), [RegisterCallback()](RegisterCallback.htm), [clipboard](../misc/Clipboard.htm), [#MaxMem](_MaxMem.htm), [StringSplit](StringSplit.htm)

## Examples

Sorts a comma-separated list of numbers.

```
MyVar := "5,3,7,9,1,13,999,-4"
Sort MyVar, N D,  <em>; Sort numerically, use comma as delimiter.</em>
MsgBox %MyVar%   <em>; The result is -4,1,3,5,7,9,13,999</em>
```

Sorts the contents of a file.

```
<a href="FileRead.htm" data-index="19">FileRead</a>, Contents, C:\Address List.txt
if not ErrorLevel  <em>; Successfully loaded.</em>
{
    Sort, Contents
    FileDelete, C:\Address List (alphabetical).txt
    FileAppend, %Contents%, C:\Address List (alphabetical).txt
    Contents := ""  <em>; Free the memory.</em>
}
```

Makes a hotkey to copy files from an open Explorer window and put their sorted filenames onto the clipboard.

```
#c:: <em>; Win+C</em>
Clipboard := "" <em>; Must be blank for detection to work.</em>
Send ^c
ClipWait 2
if ErrorLevel
    return
Sort Clipboard
MsgBox Ready to be pasted:`n%Clipboard%
return
```

Demonstrates custom sorting via a callback function.

```
MyVar := "def`nabc`nmno`nFGH`nco-op`ncoop`ncop`ncon`n"
Sort, MyVar, F StringSort
StringSort(a1, a2)
{
    return a1 > a2 ? 1 : a1 < a2 ? -1 : 0  <em>; Sorts alphabetically based on the setting of <a href="StringCaseSense.htm" data-index="22">StringCaseSense</a>.</em>
}

MyVar := "5,3,7,9,1,13,999,-4"
Sort, MyVar, F IntegerSort D,
IntegerSort(a1, a2)
{
    return a1 - a2  <em>; Sorts in ascending numeric order.  This method works only if the difference is never so large as to overflow a signed 64-bit integer.</em>
}

MyVar := "1,2,3,4"
Sort, MyVar, F ReverseDirection D,  <em>; Reverses the list so that it contains 4,3,2,1</em>
ReverseDirection(a1, a2, offset)
{
    return offset  <em>; Offset is positive if a2 came after a1 in the original list; negative otherwise.</em>
}
```

