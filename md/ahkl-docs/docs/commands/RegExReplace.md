# RegExReplace() [v1.0.45+]

Replaces occurrences of a pattern (regular expression) inside a string.

```
NewStr := <span class="func">RegExReplace</span>(Haystack, NeedleRegEx <span class="optional">, Replacement := "", OutputVarCount := "", Limit := -1, StartingPos := 1</span>)
```

## Parameters

Haystack

The string whose content is searched and replaced.

NeedleRegEx

The pattern to search for, which is a Perl-compatible regular expression (PCRE). The pattern's [options](../misc/RegEx-QuickRef.htm#Options) (if any) must be included at the beginning of the string followed by a close-parenthesis. For example, the pattern i)abc.\*123 would turn on the case-insensitive option and search for "abc", followed by zero or more occurrences of any character, followed by "123". If there are no options, the ")" is optional; for example, )abc is equivalent to abc.

Replacement

The string to be substituted for each match, which is plain text (not a regular expression). It may include backreferences like $1, which brings in the substring from _Haystack_ that matched the first [subpattern](../misc/RegEx-QuickRef.htm#subpat). The simplest backreferences are $0 through $9, where $0 is the substring that matched the entire pattern, $1 is the substring that matched the first subpattern, $2 is the second, and so on. For backreferences above 9 (and optionally those below 9), enclose the number in braces; e.g. ${10}, ${11}, and so on. For [named subpatterns](RegExMatch.htm#NamedSubPat), enclose the name in braces; e.g. ${SubpatternName}. To specify a literal $, use $$ (this is the only character that needs such special treatment; backslashes are never needed to escape anything).

To convert the case of a subpattern, follow the $ with one of the following characters: U or u (uppercase), L or l (lowercase), T or t (title case, in which the first letter of each word is capitalized but all others are made lowercase). For example, both $U1 and $U{1} transcribe an uppercase version of the first subpattern.

Nonexistent backreferences and those that did not match anything in _Haystack_ \-\- such as one of the subpatterns in (abc)\|(xyz) \-\- are transcribed as empty strings.

OutputVarCount

Specify a variable in which to store the number of replacements that occurred (0 if none).

Limit

If _Limit_ is omitted, it defaults to -1, which replaces **all** occurrences of the pattern found in _Haystack_. Otherwise, specify the maximum number of replacements to allow. The part of _Haystack_ to the right of the last replacement is left unchanged.

StartingPos

If _StartingPos_ is omitted, it defaults to 1 (the beginning of _Haystack_). Otherwise, specify 2 to start at the second character, 3 to start at the third, and so on. If _StartingPos_ is beyond the length of _Haystack_, the search starts at the empty string that lies at the end of _Haystack_ (which typically results in no replacements).

If _StartingPos_ is less than 1, it is considered to be an offset from the end of _Haystack_. For example, 0 starts at the last character and -1 starts at the next-to-last character. If _StartingPos_ tries to go beyond the left end of _Haystack_, all of _Haystack_ is searched.

Regardless of the value of _StartingPos_, the return value is always a complete copy of _Haystack_ \-\- the only difference is that more of its left side might be unaltered compared to what would have happened with a _StartingPos_ of 1.

## Return Value

This function returns a version of _Haystack_ whose contents have been replaced by the operation. If no replacements are needed, _Haystack_ is returned unaltered. If an error occurs (such as a syntax error inside _NeedleRegEx_), _Haystack_ is returned unaltered (except in versions prior to 1.0.46.06, which return "") and ErrorLevel is set to one of the values [below](#ErrorLevel) instead of 0.

## Error Handling

[v1.1.04+]: This function is able to throw an exception on failure (not to be confused with "no match found"). For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to one of the following:

- 0, which means that no error occurred.
- A string in the following form:_Compile error N at offset M: description_. In that string, _N_ is the PCRE error number, _M_ is the position of the offending character inside the regular expression, and _description_ is the text describing the error.
- A negative number, which means an error occurred during the_execution_ of the regular expression. Although such errors are rare, the ones most likely to occur are "too many possible empty-string matches" (-22), "recursion too deep" (-21), and "reached match limit" (-8). If these happen, try to redesign the pattern to be more restrictive, such as replacing each \* with a ?, +, or a limit like {0,3} wherever feasible.

## Options

See [Options](../misc/RegEx-QuickRef.htm#Options) for modifiers such as i)abc, which turns off case-sensitivity in the pattern "abc".

## Performance

To replace simple substrings, use [StrReplace()](StrReplace.htm) or [StringReplace](StringReplace.htm) because it is faster than RegExReplace().

If you know what the maximum number of replacements will be, specifying that for the _Limit_ parameter improves performance because the search can be stopped early (this might also reduce the memory load on the system during the operation). For example, if you know there can be only one match near the beginning of a large string, specify a limit of 1.

To improve performance, the 100 most recently used regular expressions are kept cached in memory (in compiled form).

The [study option (S)](../misc/RegEx-QuickRef.htm#Study) can sometimes improve the performance of a regular expression that is used many times (such as in a loop).

## Remarks

Most characters like abc123 can be used literally inside a regular expression. However, the characters **\\.\*?+[{\|()^$** must be preceded by a backslash to be seen as literal. For example, **\\.** is a literal period and **\\\** is a literal backslash. Escaping can be avoided by using \\Q...\\E. For example: \\QLiteral Text\\E.

Within a regular expression, special characters such as tab and newline can be escaped with either an accent (\`) or a backslash (\\). For example, \`t is the same as \\t.

To learn the basics of regular expressions (or refresh your memory of pattern syntax), see the [RegEx Quick Reference](../misc/RegEx-QuickRef.htm).

## Related

[RegExMatch()](RegExMatch.htm), [RegEx Quick Reference](../misc/RegEx-QuickRef.htm), [Regular Expression Callouts](../misc/RegExCallout.htm), [StrReplace()](StrReplace.htm), [InStr()](InStr.htm), [StringReplace](StringReplace.htm)

Common sources of text data: [FileRead](FileRead.htm), [UrlDownloadToFile](URLDownloadToFile.htm), [Clipboard](../misc/Clipboard.htm), [GUI Edit controls](GuiControls.htm#Edit)

## Examples

For general RegEx examples, see the [RegEx Quick Reference](../misc/RegEx-QuickRef.htm).

Reports "abc123xyz" because the $ allows a match only at the end.

```
MsgBox % RegExReplace("abc123123", "123$", "xyz")
```

Reports "123" because a match was achieved via the case-insensitive option.

```
MsgBox % RegExReplace("abc123", "i)^ABC")
```

Reports "aaaXYZzzz" by means of the $1 [backreference](#BackRef).

```
MsgBox % RegExReplace("abcXYZ123", "abc(.*)123", "aaa$1zzz")
```

Reports an empty string and stores 2 in ReplacementCount.

```
MsgBox % RegExReplace("abc123abc456", "abc\d+", "", ReplacementCount)
```

