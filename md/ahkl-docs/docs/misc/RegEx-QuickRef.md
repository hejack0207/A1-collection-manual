# Regular Expressions (RegEx) - Quick Reference

## Table of Contents

- [Fundamentals](#fundamentals)
- [Options (case sensitive)](#Options)
- [Commonly Used Symbols and Syntax](#Common)

## Fundamentals

**Match anywhere**: By default, a regular expression matches a substring _anywhere_ inside the string to be searched. For example, the regular expression abc matches abc123, 123abc, and 123abcxyz. To require the match to occur only at the beginning or end, use an [anchor](#anchor).

**Escaped characters**: Most characters like abc123 can be used literally inside a regular expression. However, the characters **\\.\*?+[{\|()^$** must be preceded by a backslash to be seen as literal. For example, \\. is a literal period and \\\ is a literal backslash. Escaping can be avoided by using \\Q...\\E. For example: \\QLiteral Text\\E.

**Case-sensitive**: By default, regular expressions are case-sensitive. This can be changed via the "i" option. For example, the pattern i)abc searches for "abc" without regard to case. See below for other modifiers.

## Options (case sensitive)

At the very beginning of a regular expression, specify zero or more of the following options followed by a close-parenthesis. For example, the pattern im)abc would search for "abc" with the case-insensitive and multiline options (the parenthesis may be omitted when there are no options). Although this syntax breaks from tradition, it requires no special delimiters (such as forward-slash), and thus there is no need to escape such delimiters inside the pattern. In addition, performance is improved because the options are easier to parse.

OptionDescriptioniCase-insensitive matching, which treats the letters A through Z as identical to their lowercase counterparts.m

Multiline. Views _Haystack_ as a collection of individual lines (if it contains newlines) rather than as a single continuous line. Specifically, it changes the following:

1) Circumflex (^) matches immediately after all internal newlines -- as well as at the start of _Haystack_ where it always matches (but it does not match after a newline _at the very end_ of _Haystack_).

2) Dollar-sign ($) matches before any newlines in _Haystack_ (as well as at the very end where it always matches).

For example, the pattern m)^abc$ matches xyz\`r\`nabc. But without the "m" option, it wouldn't match.

The "D" option is ignored when "m" is present.

sDotAll. This causes a period (.) to match all characters including newlines (normally, it does not match newlines). However, when the newline character is at its default of CRLF (\`r\`n), two dots are required to match it (not one). Regardless of this option, a negative class such as [^a] always matches newlines.xIgnores whitespace characters in the pattern except when escaped or inside a character class. The characters \`n and \`t are among those ignored because by the time they get to PCRE, they are already raw/literal whitespace characters (by contrast, \\n and \\t are not ignored because they are PCRE escape sequences). The "x" option also ignores characters between a non-escaped # outside a character class and the next newline character, inclusive. This makes it possible to include comments inside complicated patterns. However, this applies only to data characters; whitespace may never appear within special character sequences such as (?(, which begins a conditional subpattern.AForces the pattern to be anchored; that is, it can match only at the start of _Haystack_. Under most conditions, this is equivalent to explicitly anchoring the pattern by means such as "^".DForces dollar-sign ($) to match at the very end of _Haystack_, even if _Haystack_'s last item is a newline. Without this option, $ instead matches right before the final newline (if there is one). Note: This option is ignored when the "m" option is present.JAllows duplicate [named subpatterns](../commands/RegExMatch.htm#NamedSubPat). This can be useful for patterns in which only one of a collection of identically-named subpatterns can match. Note: If more than one instance of a particular name matches something, only the leftmost one is stored. Also, variable names are not case-sensitive.UUngreedy. Makes the quantifiers **\***, **?**, **+** and **{min,max}** consume only those characters absolutely necessary to form a match, leaving the remaining ones available for the next part of the pattern. When the "U" option is not in effect, an individual quantifier can be made non-greedy by following it with a question mark. Conversely, when "U" _is_ in effect, the question mark makes an individual quantifier greedy.XPCRE\_EXTRA. Enables PCRE features that are incompatible with Perl. Currently, the only such feature is that any backslash in a pattern that is followed by a letter that has no special meaning causes the match to fail and ErrorLevel to be set accordingly. This option helps reserve unused backslash sequences for future use. Without this option, a backslash followed by a letter with no special meaning is treated as a literal (e.g. \\g and g are both recognized as a literal g). Regardless of this option, non-alphabetic backslash sequences that have no special meaning are always treated as literals (e.g. \\/ and / are both recognized as forward-slash).PPosition mode. This causes RegExMatch() to yield the position and length of the match and its subpatterns rather than their matching substrings. For details, see [OutputVar](../commands/RegExMatch.htm#PosMode).OObject mode. [v1.1.05+]: This causes RegExMatch() to yield all information of the match and its subpatterns to a [match object](../commands/RegExMatch.htm#MatchObject) in OutputVar. For details, see [OutputVar](../commands/RegExMatch.htm#ObjectMode).SStudies the pattern to try improve its performance. This is useful when a particular pattern (especially a complex one) will be executed many times. If PCRE finds a way to improve performance, that discovery is stored alongside the pattern in the cache for use by subsequent executions of the same pattern (subsequent uses of that pattern should also specify the S option because finding a match in the cache requires that the option letters exactly match, including their order).CEnables the auto-callout mode. See [Regular Expression Callouts](../misc/RegExCallout.htm#auto) for more info.\`nSwitches from the default newline character (\`r\`n) to a solitary linefeed (\`n), which is the standard on UNIX systems. The chosen newline character affects the behavior of [anchors (^ and $)](../misc/RegEx-QuickRef.htm#anchor) and the [dot/period pattern](../misc/RegEx-QuickRef.htm#dot).\`rSwitches from the default newline character (\`r\`n) to a solitary carriage return (\`r).\`a[v1.0.46.06+]: \`a recognizes any type of newline, namely \`r, \`n, \`r\`n, \`v/VT/vertical tab/chr(0xB), \`f/FF/formfeed/chr(0xC), and NEL/next-line/chr(0x85). [v1.0.47.05+]: Newlines can be restricted to only CR, LF, and CRLF by instead specifying (\*ANYCRLF) in uppercase at the beginning of the pattern (after the options); e.g. im)(\*ANYCRLF)^abc$.

**Note**: Spaces and tabs may optionally be used to separate each option from the next.

## Commonly Used Symbols and Syntax

ElementDescription.By default, a dot matches any single character except \`r in a newline (\`r\`n) sequence, but this can be changed by using the [DotAll (s)](#opt_s), [linefeed (\`n)](#opt_esc_n), [carriage return (\`r)](#opt_esc_r), [\`a or (\*ANYCRLF)](#NEWLINE_ANY) options. For example, ab. matches abc and abz and ab\_.\*

An asterisk matches zero or more of the preceding character, [class](#class), or [subpattern](#subpat). For example, a\* matches ab and aaab. It also matches at the very beginning of any string that contains no "a" at all.

**Wildcard:** The dot-star pattern .\* is one of the most permissive because it matches zero or more occurrences of _any_ character (except newline: \`r and \`n). For example, abc.\*123 matches abcAnything123 as well as abc123.

?A question mark matches zero or one of the preceding character, [class](#class), or [subpattern](#subpat). Think of this as "the preceding item is optional". For example, colou?r matches both color and colour because the "u" is optional.+A plus sign matches one or more of the preceding character, [class](#class), or [subpattern](#subpat). For example a+ matches ab and aaab. But unlike a\* and a?, the pattern a+ does not match at the beginning of strings that lack an "a" character.{min,max}

Matches between _min_ and _max_ occurrences of the preceding character, [class](#class), or [subpattern](#subpat). For example, a{1,2} matches ab but only the first two a's in aaab.

Also, {3} means exactly 3 occurrences, and {3 **,**} means 3 or more occurrences. Note: The specified numbers must be less than 65536, and the first must be less than or equal to the second.

[...]

**Classes of characters:** The square brackets enclose a list or range of characters (or both). For example, [abc] means "any single character that is either a, b or c". Using a dash in between creates a range; for example, [a-z] means "any single character that is between lowercase a and z (inclusive)". Lists and ranges may be combined; for example [a-zA-Z0-9\_] means "any single character that is alphanumeric or underscore".

A character class may be followed by **\***, **?**, **+**, or **{min,max}**. For example, [0-9]+ matches one or more occurrence of any digit; thus it matches xyz123 but not abcxyz.

The following POSIX named sets are also supported via the form **[[:xxx:]]**, where xxx is one of the following words: alnum, alpha, ascii (0-127), blank (space or tab), cntrl (control character), digit (0-9), xdigit (hex digit), print, graph (print excluding space), punct, lower, upper, space (whitespace), word (same as [\\w](#word)).

Within a character class, characters do not need to be escaped except when they have special meaning inside a class; e.g. [\\^a], [a\\-b], [a\\]], and [\\\a].

[^...]Matches any single character that is **not** in the class. For example, [^/]\* matches zero or more occurrences of any character that is _not_ a forward-slash, such as http://. Similarly, [^0-9xyz] matches any single character that isn't a digit and isn't the letter x, y, or z.\\dMatches any single digit (equivalent to the class [0-9]). Conversely, capital **\\D** means "any _non_-digit". This and the other two below can also be used inside a [class](#class); for example, [\\d.-] means "any single digit, period, or minus sign".\\sMatches any single whitespace character, mainly space, tab, and newline (\`r and \`n). Conversely, capital **\\S** means "any _non_-whitespace character".\\wMatches any single "word" character, namely alphanumeric or underscore. This is equivalent to [a-zA-Z0-9\_]. Conversely, capital **\\W** means "any _non_-word character".^

$

Circumflex (^) and dollar sign ($) are called _anchors_ because they don't consume any characters; instead, they tie the pattern to the beginning or end of the string being searched.

**^** may appear at the beginning of a pattern to require the match to occur at the very beginning of a line. For example, ^abc matches abc123 but not 123abc.

**$** may appear at the end of a pattern to require the match to occur at the very end of a line. For example, abc$ matches 123abc but not abc123.

The two anchors may be combined. For example, ^abc$ matches only abc (i.e. there must be no other characters before or after it).

If the text being searched contains multiple lines, the anchors can be made to apply to each line rather than the text as a whole by means of the ["m" option](#Multiline). For example, m)^abc$ matches 123\`r\`nabc\`r\`n789. But without the "m" option, it wouldn't match.

\\b**\\b** means "word boundary", which is like an anchor because it doesn't consume any characters. It requires the current character's [status as a word character (\\w)](#word) to be the opposite of the previous character's. It is typically used to avoid accidentally matching a word that appears inside some other word. For example, \\bcat\\b doesn't match catfish, but it matches cat regardless of what punctuation and whitespace surrounds it. Capital **\\B** is the opposite: it requires that the current character _not_ be at a word boundary.\|The vertical bar separates two or more alternatives. A match occurs if _any_ of the alternatives is satisfied. For example, gray\|grey matches both gray and grey. Similarly, the pattern gr(a\|e)y does the same thing with the help of the parentheses described below.(...)

Items enclosed in parentheses are most commonly used to:

- Determine the order of evaluation. For example,(Sun\|Mon\|Tues\|Wednes\|Thurs\|Fri\|Satur)day matches the name of any day.
- Apply**\***, **?**, **+**, or **{min,max}** to a _series_ of characters rather than just one. For example, (abc)+ matches one or more occurrences of the string "abc"; thus it matches abcabc123 but not ab123 or bc123.
- Capture a subpattern such as the dot-star inabc(.\*)xyz. For example, [RegExMatch()](../commands/RegExMatch.htm) stores the substring that matches each subpattern in its [output array](../commands/RegExMatch.htm#Array). Similarly, [RegExReplace()](../commands/RegExReplace.htm) allows the substring that matches each subpattern to be reinserted into the result via [backreferences](../commands/RegExReplace.htm#BackRef) like $1. To use the parentheses without the side-effect of capturing a subpattern, specify **?:** as the first two characters inside the parentheses; for example: (?:.\*)
- Change[options](#Options) on-the-fly. For example, (?im) turns on the case-insensitive and multiline options for the remainder of the pattern (or subpattern if it occurs inside a subpattern). Conversely, (?-im) would turn them both off. All options are supported except DPS\`r\`n\`a.

\\t

\\r

etc.

These escape sequences stand for special characters. The most common ones are **\\t** (tab), **\\r** (carriage return), and **\\n** (linefeed). In AutoHotkey, an accent (\`) may optionally be used in place of the backslash in these cases. Escape sequences in the form **\\xhh** are also supported, in which _hh_ is the hex code of any ANSI character between 00 and FF.

[v1.0.46.06+]: **\\R** means "any single newline of any type", namely those listed at the [\`a option](#NEWLINE_ANY) (however, \\R inside a [character class](#class) is merely the letter "R"). [v1.0.47.05+]: \\R can be restricted to CR, LF, and CRLF by specifying (\*BSR\_ANYCRLF) in uppercase at the beginning of the pattern (after the options); e.g. im)(\*BSR\_ANYCRLF)abc\\Rxyz

\\p{xx}

\\P{xx}

\\X

[AHK\_L 61+]: Unicode character properties. Not supported on ANSI builds. **\\p{xx}** matches a character with the xx property while **\\P{xx}** matches any character _without_ the xx property. For example, \\pL matches any letter and \\p{Lu} matches any upper-case letter. **\\X** matches any number of characters that form an extended Unicode sequence.

For a full list of supported property names and other details, search for "\\p{xx}" at [www.pcre.org/pcre.txt](http://www.pcre.org/pcre.txt).

(\*UCP)

[AHK\_L 61+]: For performance, \\d, \\D, \\s, \\S, \\w, \\W, \\b and \\B recognize only ASCII characters by default, even on Unicode builds. If the pattern begins with **(\*UCP)**, Unicode properties will be used to determine which characters match. For example, \\w becomes equivalent to [\\p{L}\\p{N}\_] and \\d becomes equivalent to \\p{Nd}.

**Greed**: By default, **\***, **?**, **+**, and **{min,max}** are greedy because they consume all characters up through the _last_ possible one that still satisfies the entire pattern. To instead have them stop at the _first_ possible character, follow them with a question mark. For example, the pattern <.+> (which lacks a question mark) means: "search for a <, followed by one or more of any character, followed by a >". To stop this pattern from matching the _entire_ string **<**em>text</em**>**, append a question mark to the plus sign: <.+?>. This causes the match to stop at the first '>' and thus it matches only the first tag **<**em**>**.

**Look-ahead and look-behind assertions**: The groups (?=...), (?!...), (?<=...), and (?<!...) are called _assertions_ because they demand a condition to be met but don't consume any characters. For example, abc(?=.\*xyz) is a look-ahead assertion that requires the string xyz to exist somewhere to the right of the string abc (if it doesn't, the entire pattern is not considered a match). (?=...) is called a _positive_ look-ahead because it requires that the specified pattern exist. Conversely, (?!...) is a _negative_ look-ahead because it requires that the specified pattern _not_ exist. Similarly, (?<=...) and (?<!...) are positive and negative look- _behinds_ (respectively) because they look to the _left_ of the current position rather than the right. Look-behinds are more limited than look-aheads because they do not support quantifiers of varying size such as **\***, **?**, and **+**. The escape sequence **\\K** is similar to a look-behind assertion because it causes any previously-matched characters to be omitted from the final matched string. For example, foo\\Kbar matches "foobar" but reports that it has matched "bar".

**Related**: Regular expressions are supported by [RegExMatch()](../commands/RegExMatch.htm), [RegExReplace()](../commands/RegExReplace.htm), and [SetTitleMatchMode](../commands/SetTitleMatchMode.htm).

**Final note**: Although this page touches upon most of the commonly-used RegEx features, there are quite a few other features you may want to explore such as conditional subpatterns. The complete PCRE manual is at [www.pcre.org/pcre.txt](http://www.pcre.org/pcre.txt)

