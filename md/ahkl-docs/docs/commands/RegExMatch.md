# RegExMatch() [v1.0.45+]

Determines whether a string contains a pattern (regular expression).

```
FoundPos := <span class="func">RegExMatch</span>(Haystack, NeedleRegEx <span class="optional">, OutputVar, StartingPos := 1</span>)
```

## Parameters

Haystack

The string whose content is searched.

NeedleRegEx

The pattern to search for, which is a Perl-compatible regular expression (PCRE). The pattern's [options](../misc/RegEx-QuickRef.htm#Options) (if any) must be included at the beginning of the string followed by a close-parenthesis. For example, the pattern i)abc.\*123 would turn on the case-insensitive option and search for "abc", followed by zero or more occurrences of any character, followed by "123". If there are no options, the ")" is optional; for example, )abc is equivalent to abc.

OutputVar

**Mode 1 (default):** Specify a variable in which to store the part of _Haystack_ that matched the entire pattern. If the pattern is not found (that is, if the function returns 0), this variable and all array elements below are made blank.

If any [capturing subpatterns](../misc/RegEx-QuickRef.htm#subpat) are present inside _NeedleRegEx_, their matches are stored in a [pseudo-array](../misc/Arrays.htm#pseudo) whose base name is _OutputVar_. For example, if the variable's name is _Match_, the substring that matches the first subpattern would be stored in _Match1_, the second would be stored in _Match2_, and so on. The exception to this is [named subpatterns](#NamedSubPat): they are stored by name instead of number. For example, the substring that matches the named subpattern (?P<Year>\\d{4}) would be stored in _MatchYear_. If a particular subpattern does not match anything (or if the function returns zero), the corresponding variable is made blank.

Within a [function](../Functions.htm), to create a pseudo-array that is global instead of local, [declare](../Functions.htm#Global) the base name of the pseudo-array (e.g. Match) as a global variable prior to using it. The converse is true for [assume-global](../Functions.htm#AssumeGlobal) functions. However, it is often also necessary to declare each element, due to a [common source of confusion](../Functions.htm#ArrayConfusion).

**Mode 2 (position-and-length):** If a capital P is present in the RegEx's options -- such as P)abc.\*123 \-\- the _length_ of the entire-pattern match is stored in _OutputVar_ (or 0 if no match). If any [capturing subpatterns](../misc/RegEx-QuickRef.htm#subpat) are present, their positions and lengths are stored in two [pseudo-arrays](../misc/Arrays.htm#pseudo): _OutputVarPos_ and _OutputVarLen_. For example, if the variable's base name is _Match_, the one-based _position_ of the first subpattern's match would be stored in _MatchPos1_, and its length in _MatchLen1_ (zero is stored in both if the subpattern was not matched or the function returns 0). The exception to this is [named subpatterns](#NamedSubPat): they are stored by name instead of number (e.g. _MatchPosYear_ and _MatchLenYear_).

**Mode 3 (match object)**[v1.1.05+] **:** If a capital O is present in the RegEx's options -- such as O)abc.\*123 \-\- a [match object](#MatchObject) is stored in _OutputVar_. This object can be used to retrieve the position, length and value of the overall match and of each [captured subpattern](../misc/RegEx-QuickRef.htm#subpat), if present.

StartingPos

If _StartingPos_ is omitted, it defaults to 1 (the beginning of _Haystack_). Otherwise, specify 2 to start at the second character, 3 to start at the third, and so on. If _StartingPos_ is beyond the length of _Haystack_, the search starts at the empty string that lies at the end of _Haystack_ (which typically results in no match).

If _StartingPos_ is less than 1, it is considered to be an offset from the end of _Haystack_. For example, 0 starts at the last character and -1 starts at the next-to-last character. If _StartingPos_ tries to go beyond the left end of _Haystack_, all of _Haystack_ is searched.

Regardless of the value of _StartingPos_, the return value is always relative to the first character of _Haystack_. For example, the position of "abc" in "123abc789" is always 4.

## Return Value

This function returns the position of the leftmost occurrence of _NeedleRegEx_ in the string _Haystack_. Position 1 is the first character. Zero is returned if the pattern is not found. If an error occurs (such as a syntax error inside _NeedleRegEx_), an empty string is returned and ErrorLevel is set to one of the values [below](#ErrorLevel) instead of 0.

## Error Handling

[v1.1.04+]: This function is able to throw an exception on failure (not to be confused with "no match found"). For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to one of the following:

- 0, which means that no error occurred.
- A string in the following form:_Compile error N at offset M: description_. In that string, _N_ is the PCRE error number, _M_ is the position of the offending character inside the regular expression, and _description_ is the text describing the error.
- A negative number, which means an error occurred during the_execution_ of the regular expression. Although such errors are rare, the ones most likely to occur are "too many possible empty-string matches" (-22), "recursion too deep" (-21), and "reached match limit" (-8). If these happen, try to redesign the pattern to be more restrictive, such as replacing each \* with a ?, +, or a limit like {0,3} wherever feasible.

## Options

See [Options](../misc/RegEx-QuickRef.htm#Options) for modifiers such as i)abc, which turns off case-sensitivity in the pattern "abc".

## Match Object [v1.1.05+]

If a capital O is present in the RegEx's options, a match object is stored in _OutputVar_. This object has the following methods and properties:

**Match.Pos(N)**: Returns the position of the overall match or a captured subpattern.

**Match.Len(N)**: Returns the length of the overall match or a captured subpattern.

**Match.Value(N)**: Returns the overall match or a captured subpattern.

**Match.Name(N)**: Returns the name of the given subpattern, if it has one.

**Match.Count()**: Returns the overall number of subpatterns.

**Match.Mark()**: Returns the _NAME_ of the last encountered (\*MARK:NAME), when applicable.

**Match[N]**: If _N_ is 0 or a valid subpattern number or name, this is equivalent to `Match.Value(N)`. Otherwise, _N_ can be the name of one of the above methods. For example, `Match["Pos"]` and `Match.Pos` are equivalent to `Match.Pos()` unless a subpattern named "Pos" exists, in which case they are equivalent to `Match.Value("Pos")`.

**Match.N**: Same as above, except that _N_ is an unquoted name or number.

For all of the above methods and properties, _N_ can be any of the following:

- 0 for the overall match.
- The number of a subpattern, even one that also has a name.
- The name of a subpattern.

Brackets [] may be used in place of parentheses () if _N_ is specified.

## Performance

To search for a simple substring inside a larger string, use [InStr()](InStr.htm) because it is faster than RegExMatch().

To improve performance, the 100 most recently used regular expressions are kept cached in memory (in compiled form).

The [study option (S)](../misc/RegEx-QuickRef.htm#Study) can sometimes improve the performance of a regular expression that is used many times (such as in a loop).

## Remarks

A subpattern may be given a name such as the word _Year_ in the pattern (?P<Year>\\d{4}). Such names may consist of up to 32 alphanumeric characters and underscores. The following limitation does not apply to the "O" (match object) mode: Although named subpatterns are also available by their numbers during the RegEx operation itself (e.g. \\1 is a backreference to the string that actually matched the first capturing subpattern), they are stored in the [output pseudo-array](#Array) _only_ by name (not by number). For example, if "Year" is the first subpattern, _OutputVarYear_ would be set to the matching substring, but _OutputVar1_ would not be changed at all (it would retain its previous value, if any). However, if an [unnamed subpattern](../misc/RegEx-QuickRef.htm#subpat) occurs after "Year", it would be stored in _OutputVar2_, not _OutputVar1_.

Most characters like abc123 can be used literally inside a regular expression. However, the characters **\\.\*?+[{\|()^$** must be preceded by a backslash to be seen as literal. For example, **\\.** is a literal period and **\\\** is a literal backslash. Escaping can be avoided by using \\Q...\\E. For example: \\QLiteral Text\\E.

Within a regular expression, special characters such as tab and newline can be escaped with either an accent (\`) or a backslash (\\). For example, \`t is the same as \\t except when the **x** option is used.

To learn the basics of regular expressions (or refresh your memory of pattern syntax), see the [RegEx Quick Reference](../misc/RegEx-QuickRef.htm).

AutoHotkey's regular expressions are implemented using Perl-compatible Regular Expressions (PCRE) from [www.pcre.org](http://www.pcre.org/).

[AHK\_L 31+]: Within an [expression](../Variables.htm#Expressions), the `a <a href="../Variables.htm#regex" data-index="25">~=</a> b` can be used as shorthand for `RegExMatch(a, b)`.

## Related

[RegExReplace()](RegExReplace.htm), [RegEx Quick Reference](../misc/RegEx-QuickRef.htm), [Regular Expression Callouts](../misc/RegExCallout.htm), [InStr()](InStr.htm), [IfInString](IfInString.htm), [StringGetPos](StringGetPos.htm), [SubStr()](SubStr.htm), [SetTitleMatchMode RegEx](SetTitleMatchMode.htm#RegEx), [Global matching and Grep (forum link)](https://www.autohotkey.com/forum/topic16164.html)

Common sources of text data: [FileRead](FileRead.htm), [UrlDownloadToFile](URLDownloadToFile.htm), [Clipboard](../misc/Clipboard.htm), [GUI Edit controls](GuiControls.htm#Edit)

## Examples

For general RegEx examples, see the [RegEx Quick Reference](../misc/RegEx-QuickRef.htm).

Reports 4, which is the position where the match was found.

```
MsgBox % RegExMatch("xxxabc123xyz", "abc.*xyz")
```

Reports 7 because the $ requires the match to be at the end.

```
MsgBox % RegExMatch("abc123123", "123$")
```

Reports 1 because a match was achieved via the case-insensitive option.

```
MsgBox % RegExMatch("abc123", "i)^ABC")
```

Reports 1 and stores "XYZ" in SubPat1.

```
MsgBox % RegExMatch("abcXYZ123", "abc(.*)123", SubPat)
```

Reports 7 instead of 1 due to the starting position 2 instead of 1.

```
MsgBox % RegExMatch("abc123abc456", "abc\d+",, 2)
```

Demonstrates the usage of the Match object.

```
FoundPos := RegExMatch("Michiganroad 72", "O)(.*) (?<nr>\d+)", SubPat)  <em>; The starting "O)" turns SubPat into an object.</em>
Msgbox % SubPat.Count() ": " SubPat.Value(1) " " SubPat.Name(2) "=" SubPat["nr"]  <em>; Displays "2: Michiganroad nr=72"</em>
```

Retrieves the extension of a file. Note that [SplitPath](SplitPath.htm) can also be used for this, which is more reliable.

```
Path := "C:\Foo\Bar\Baz.txt"
RegExMatch(Path, "\w+$", Extension)
MsgBox % Extension  <em>; Reports "txt".</em>
```

Similar to [Transform Deref](Transform.htm#Deref), the following function expands variable references and [escape sequences](../misc/EscapeChar.htm) contained inside other variables. Furthermore, this example shows how to find all matches in a string rather than stopping at the first match (similar to the g flag in JavaScript's RegEx).

```
var1 := "abc"
var2 := 123
MsgBox % Deref("%var1%def%var2%")  <em>; Reports abcdef123.</em>

Deref(String)
{
    spo := 1
    out := ""
    while (fpo:=RegexMatch(String, "(%(.*?)%)|``(.)", m, spo))
    {
        out .= SubStr(String, spo, fpo-spo)
        spo := fpo + StrLen(m)
        if (m1)
            out .= %m2%
        else switch (m3)
        {
            case "a": out .= "`a"
            case "b": out .= "`b"
            case "f": out .= "`f"
            case "n": out .= "`n"
            case "r": out .= "`r"
            case "t": out .= "`t"
            case "v": out .= "`v"
            default: out .= m3
        }
    }
    return out SubStr(String, spo)
}
```

