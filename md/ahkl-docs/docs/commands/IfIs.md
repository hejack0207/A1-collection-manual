# If var is [not] type

Checks whether a [variable's](../Variables.htm) contents are numeric, uppercase, etc.

```
<span class="func">if</span> Var <span class="func">is</span> Type
<span class="func">if</span> Var <span class="func">is not</span> Type

```

## Parameters

Var

The [variable](../Variables.htm) name.

Type

Specify one of the following types:

TypeDescriptionintegerTrue if _Var_ is non-empty and contains a purely numeric string (decimal or hexadecimal) without a decimal point. Leading and trailing spaces and tabs are allowed. The string may start with a plus or minus sign.floatTrue if _Var_ is non-empty and contains a floating point number; that is, a purely numeric string containing a decimal point. Leading and trailing spaces and tabs are allowed. The string may start with a plus sign, minus sign, or decimal point.numberTrue if _Var_ contains an integer or floating point number (each of which is described above).digitTrue if _Var_ is empty or contains only digits, which consist of the characters 0 through 9. Other characters such as the following are not allowed: spaces, tabs, plus signs, minus signs, decimal points, hexadecimal digits, and the 0x prefix.xdigitHexadecimal digit: Same as _digit_ except the characters A through F (uppercase or lowercase) are also allowed. [v1.0.44.09+]: A prefix of 0x is tolerated if present.alphaTrue if _Var_ is empty or contains only alphabetic characters. False if there are any digits, spaces, tabs, punctuation, or other non-alphabetic characters anywhere in the string. For example, if _Var_ contains a space followed by a letter, it is _not_ considered to be _alpha_.upperTrue if _Var_ is empty or contains only uppercase characters. False if there are any digits, spaces, tabs, punctuation, or other non-uppercase characters anywhere in the string.lowerTrue if _Var_ is empty or contains only lowercase characters. False if there are any digits, spaces, tabs, punctuation, or other non-lowercase characters anywhere in the string.alnumSame as _alpha_ except that characters 0 through 9 are also allowed.spaceTrue if _Var_ is empty or contains only whitespace, which consists of the following characters: space ( [%A\_Space%](../Variables.htm)), tab ( [%A\_Tab%](../Variables.htm) or \`t), linefeed (\`n), return (\`r), vertical tab (\`v), and formfeed (\`f).time

True if _Var_ contains a valid date-time stamp, which can be all or just the leading part of the [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format. For example, a 4-digit string such as 2004 is considered valid. Use [StrLen()](StrLen.htm) or [StringLen](StringLen.htm) to determine whether additional time components are present.

Years less than 1601 are not considered valid because the operating system generally does not support them. The maximum year considered valid is 9999.

The word DATE may be used as a substitute for the word TIME, with the same result.

## Remarks

The "is" operator is not supported in [expressions](../Variables.htm#Expressions).

[AHK\_L 42+]: The system locale is ignored unless [StringCaseSense Locale](StringCaseSense.htm) has been used.

## Related

[%A\_YYYY%](../Variables.htm#YYYY), [Format()](Format.htm), [SetFormat](SetFormat.htm), [FileGetTime](FileGetTime.htm), [IfEqual](IfEqual.htm), [if var in/contains MatchList](IfIn.htm), [if var between](IfBetween.htm), [StrLen()](StrLen.htm), [IfInString](IfInString.htm), [StringUpper](StringLower.htm), [Blocks](Block.htm), [Else](Else.htm), [StringLen](StringLen.htm)

## Examples

Checks whether var is a floating point number or an integer and checks whether it is a valid timestamp.

```
if var is float
    MsgBox, %var% is a floating point number.
else if var is integer
    MsgBox, %var% is an integer.
if var is time
    MsgBox, %var% is also a valid date-time.
```

