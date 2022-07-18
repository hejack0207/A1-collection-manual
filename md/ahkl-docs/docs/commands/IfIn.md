# If var [not] in/contains value1,value2,...

Checks whether a [variable's](../Variables.htm) contents match one of the items in a list.

```
<span class="func">if</span> Var <span class="func">in</span> MatchList
<span class="func">if</span> Var <span class="func">not in</span> MatchList

<span class="func">if</span> Var <span class="func">contains</span> MatchList
<span class="func">if</span> Var <span class="func">not contains</span> MatchList

```

## Parameters

Var

The name of the [variable](../Variables.htm) whose contents will be checked. For the "in" operator, an exact match with one of the list items is required. For the "contains" operator, a match occurs more easily: whenever _Var_ contains one of the list items as a substring.

MatchList

A comma-separated list of strings, each of which will be compared to the contents of _Var_ for a match. **Any spaces or tabs around the delimiting commas are significant**, meaning that they are part of the match string. For example, if _MatchList_ is set to `ABC , XYZ` then _Var_ must contain either ABC with a trailing space or XYZ with a leading space to cause a match.

Two consecutive commas results in a single literal comma. For example, the following would produce a single literal comma at the end of string1: `if Var in string1,,,string2`. Similarly, the following list contains only a single item with a literal comma inside it: `if Var in single,,item`. To include a blank item in the list, make the first character a comma as in this example: `if Var in ,string1,string2` (when using the "contains" operator, a blank item will always result in a match since the empty string is found in all strings).

Because the items in _MatchList_ are not treated as individual parameters, the list can be contained entirely within a variable. In fact, all or part of it must be contained in a variable if its length exceeds 16383 since that is the maximum length of any script line. For example, _MatchList_ might consist of `%List1%,%List2%,%List3%` \-\- where each of the sublists contains a large list of match phrases.

Any single item in the list that is longer than 16384 characters will have those extra characters treated as a new list item. Thus, it is usually best to avoid including such items.

## Remarks

The comparison is always done alphabetically, not numerically. For example, the string "11" would not match the list item "11.0".

The "contains" operator is the same as using [InStr()](InStr.htm) or [If[Not]InString](IfInString.htm) except that multiple search strings are supported (any one of which will cause a match).

`<a href="StringCaseSense.htm" data-index="5">StringCaseSense</a> On` can be used to make the comparison case sensitive.

If _MatchList_ is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

The operators "in" and "contains" are not supported in [expressions](../Variables.htm#Expressions). Instead, use [If statements](IfExpression.htm) such as `if (Var ~= "i)\A(Value1|Value2)\z")` for "in" or `if (Var ~= "i)Value1|Value2")` for "contains" to simulate the behavior of these operators.

## Related

[if var between](IfBetween.htm), [IfEqual/Greater/Less](IfEqual.htm), [IfInString](IfInString.htm), [StringCaseSense](StringCaseSense.htm), [Blocks](Block.htm), [Else](Else.htm)

## Examples

Checks whether var is the file extension exe, bat or com.

```
if var in exe,bat,com
    MsgBox The file extension is an executable type.
```

Checks whether var is the prime number 1, 2, 3, 5, 7 or 11.

```
if var in 1,2,3,5,7,11 <em>; Avoid spaces in list.</em>
    MsgBox %var% is a small prime number.
```

Checks whether var contains the digit 1 or 3.

```
if var contains 1,3  <em>; Note that it compares the values as strings, not numbers.</em>
    MsgBox Var contains the digit 1 or 3 (Var could be 1, 3, 10, 21, 23, etc.)
```

Checks whether var is one of the items in MyItemList.

```
if var in %MyItemList%
    MsgBox %var% is in the list.
```

Allows the user to enter a string and checks whether it is the word yes or no.

```
InputBox, UserInput, Enter YES or NO
if UserInput not in yes,no
    MsgBox Your input is not valid.
```

Checks whether active\_title contains "Address List.txt" or "Customer List.txt" and checks whether it contains "metapad" or "Notepad".

```
WinGetTitle, active_title, A
if active_title contains Address List.txt,Customer List.txt
    MsgBox One of the desired windows is active.
if active_title not contains metapad,Notepad
    MsgBox But the file is not open in either Metapad or Notepad.
```

