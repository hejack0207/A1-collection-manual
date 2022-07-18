# InStr()

Searches for a given occurrence of a string, from the left or the right.

```
FoundPos := <span class="func">InStr</span>(Haystack, Needle <span class="optional">, CaseSensitive := false, StartingPos := 1, Occurrence := 1</span>)
```

## Parameters

Haystack

The string whose content is searched.

Needle

The string to search for.

CaseSensitive

If the parameter _CaseSensitive_ is omitted or false, the search is not case sensitive (the method of insensitivity depends on [StringCaseSense](StringCaseSense.htm)); otherwise, the case must match exactly.

StartingPos

If _StartingPos_ is omitted, it defaults to 1 (the beginning of _Haystack_). Otherwise, specify 2 to start at the second character, 3 to start at the third, and so on.

If _StartingPos_ is beyond the length of _Haystack_, 0 is returned. [AHK\_L 57+]: If _StartingPos_ is 0 or negative, the search is conducted in reverse (right-to-left) beginning at that offset from the end.

Regardless of the value of _StartingPos_, the return value is always relative to the first character of _Haystack_. For example, the position of "abc" in "123abc789" is always 4.

Occurrence [AHK\_L 57+]

If _Occurrence_ is omitted, it defaults to the first match of the _Needle_ in _Haystack_. Specify 2 for _Occurrence_ to return the position of the second match, 3 for the third match, etc.

## Return Value

This function returns the position of an occurrence of the string _Needle_ in the string _Haystack_. Position 1 is the first character; this is because 0 is synonymous with "false", making it an intuitive "not found" indicator.

An occurrence of an empty string ( `""`) can be found at any position; therefore, if _Needle_ is an empty string, the return value is 1. As a blank _Needle_ would typically only be passed by mistake, it will be treated as an error in AutoHotkey v2.

## Remarks

This function is a combination of [IfInString](IfInString.htm) and [StringGetPos](StringGetPos.htm).

[RegExMatch()](RegExMatch.htm) can be used to search for a pattern (regular expression) within a string, making it much more flexible than InStr(). However, InStr() is generally faster than RegExMatch() when searching for a simple substring.

## Related

[RegExMatch()](RegExMatch.htm), [StringGetPos](StringGetPos.htm), [IfInString](IfInString.htm), [StringCaseSense](StringCaseSense.htm), [if var in/contains MatchList](IfIn.htm), [if var between](IfBetween.htm), [if var is type](IfIs.htm)

## Examples

Reports the 1-based position of the substring "abc" in the string "123abc789".

```
MsgBox % InStr("123abc789", "abc") <em>; Returns 4</em>
```

Searches for Needle in Haystack.

```
Haystack := "The Quick Brown Fox Jumps Over the Lazy Dog"
Needle := "Fox"
If InStr(Haystack, Needle)
    MsgBox, The string was found.
Else
    MsgBox, The string was not found.
```

Demonstrates the difference between a case insensitive and case sensitive search.

```
Haystack := "The Quick Brown Fox Jumps Over the Lazy Dog"
Needle := "the"
MsgBox % InStr(Haystack, Needle, false, 1, 2) <em>; case insensitive search, return start position of second occurence</em>
MsgBox % InStr(Haystack, Needle, true) <em>; case sensitive search, return start position of first occurence, same result as above</em>

```

