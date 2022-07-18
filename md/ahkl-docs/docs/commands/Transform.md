# Transform

Performs miscellaneous math functions, bitwise operations, and tasks such as ASCII/Unicode conversion.

**Deprecated:** This command is not recommended for use in new scripts. For details on what you can use instead, see the sub-command sections below.

```
<span class="func">Transform</span>, OutputVar, <a href="#SubCommands" data-index="1">SubCommand</a>, Value1 <span class="optional">, Value2</span>
```

The _OutputVar_ parameter is the name of the variable in which to store the result. The _SubCommand_, _Value1_ and _Value2_ parameters are dependent upon each other and their usage is described below.

## Sub-commands

For _SubCommand_, specify one of the following:

- [Unicode](#Unicode) (for ANSI builds only): Retrieves or stores Unicode text on the clipboard.
- [Deref](#Deref): Expands variable references and escape sequences contained inside other variables.
- [HTML](#HTML): Converts the specified string into its HTML equivalent.
- [Asc](#Asc): Retrieves the character code for the first character in the specified string.
- [Chr](#Chr): Retrieves the single character corresponding to the character code.
- [Mod](#Mod): Retrieves the remainder of a division.
- [Exp](#Exp): Retrieves e raised to the _N_ th power.
- [Sqrt](#Sqrt): Retrieves the square root of a number.
- [Log](#Log): Retrieves the logarithm (base 10) of a number.
- [Ln](#Ln): Retrieves the natural logarithm (base e) of a number.
- [Round](#Round): Retrieves a number rounded to _N_ decimal places.
- [Ceil](#Ceil): Retrieves a number rounded up to the nearest integer.
- [Floor](#Floor): Retrieves a number rounded down to the nearest integer.
- [Abs](#Abs): Retrieves the absolute value of a number.
- [Sin](#Sin): Retrieves the trigonometric sine of a number.
- [Cos](#Cos): Retrieves the trigonometric cosine of a number.
- [Tan](#Tan): Retrieves the trigonometric tangent of a number.
- [ASin](#ASin): Retrieves the arcsine in radians.
- [ACos](#ACos): Retrieves the arccosine in radians.
- [ATan](#ATan): Retrieves the arctangent in radians.
- [Pow](#Pow): Retrieves a base raised to the power of an exponent.
- [BitNot](#BitNot): Retrieves the bit-inverted version of a number.
- [BitAnd](#BitAnd): Retrieves the result of the bitwise-AND of the specified numbers.
- [BitOr](#BitOr): Retrieves the result of the bitwise-OR of the specified numbers.
- [BitXOr](#BitXOr): Retrieves the result of the bitwise-EXCLUSIVE-OR of the specified numbers.
- [BitShiftLeft](#BitShiftLeft): Retrieves the result of shifting a number to the left by _N_ bit positions.
- [BitShiftRight](#BitShiftRight): Retrieves the result of shifting a number to the right by _N_ bit positions.

### Unicode

**Deprecated:** Not recommended for use in new scripts. Use the Unicode version of AutoHotkey instead.

Retrieves or stores Unicode text on the clipboard (for ANSI builds only).

```
<span class="func">Transform</span>, OutputVar, Unicode <span class="optional">, String</span>
```

Note: The entire clipboard may be saved and restored by means of [ClipboardAll](../misc/Clipboard.htm#ClipboardAll), which allows this sub-command to operate without losing the original contents of the clipboard.

There are two modes of operation as illustrated in the following examples:

```
Transform, OutputVar, Unicode  <em>; Retrieves the clipboard's Unicode text as a UTF-8 string.</em>
Transform, Clipboard, Unicode, %MyUTF_String%  <em>; Places Unicode text onto the clipboard.</em>
```

In the second example above, a literal UTF-8 string may be optionally used in place of `%MyUTF_String%`.

Use a hotkey such as the following to determine the UTF-8 string that corresponds to a given Unicode string:

```
^!u::  <em>; Control+Alt+U hotkey.</em>
MsgBox Copy some Unicode text onto the clipboard, then return to this window and press OK to continue.
Transform, ClipUTF, Unicode
Clipboard := "Transform, Clipboard, Unicode, %ClipUTF%`r`n"
MsgBox The clipboard now contains the following line that you can paste into your script. When executed, this line will cause the original Unicode string you copied to be placed onto the clipboard:`n`n%Clipboard%
return
```

**Note:** The `<a href="Send.htm#sendu" data-index="30">Send {U+nnnn}</a>` command is an alternate way to produce Unicode characters.

### Deref

**Deprecated:** Not recommended for use in new scripts. Use the [expression syntax](../Language.htm#expressions) or a custom function such as [Deref()](RegExMatch.htm#ExDeref) instead.

Expands variable references and [escape sequences](../misc/EscapeChar.htm) contained inside other variables.

```
<span class="func">Transform</span>, OutputVar, Deref, String
```

Any badly formatted variable references will be omitted from the expanded result. The same is true if _OutputVar_ is expanded into itself; in other words, any references to _OutputVar_ inside _String's_ variables will be omitted from the expansion (note however that _String_ **itself** can be `%OutputVar%`). In the following example, if Var1 contains the string "test" and Var2 contains the **literal** string "%Var1%", _OutputVar_ will be set to the string "test": `Transform, OutputVar, Deref, %Var2%`. Within a [function](../Functions.htm), each variable in _String_ always resolves to a local variable unless there is no such variable, in which case it resolves to a global variable (or blank if none).

### HTML

**Deprecated:** Not recommended for use in new scripts. Use a custom function such as [EncodeHTML()](../scripts/index.htm#HTML_Entities_Encoding) instead.

Converts _String_ into its HTML equivalent by translating characters whose ASCII values are above 127 to their HTML names (e.g. `£` becomes `&pound;`).

```
<span class="func">Transform</span>, OutputVar, HTML, String <span class="optional">, Flags</span>
```

In addition, the four characters `"&<>` are translated to `&quot;&amp;&lt;&gt;`. Finally, each linefeed ( `` `n``) is translated to ``<br>`n`` (i.e. `<br>` followed by a linefeed). The _Flags_ parameter is ignored.

**For Unicode executables:** In addition of the functionality above, _Flags_ can be zero or a combination (sum) of the following values. If omitted, it defaults to 1.

- 1: Converts certain characters to named expressions. e.g.`€` is converted to `&euro;`
- 2: Converts certain characters to numbered expressions. e.g.`€` is converted to `&#8364;`

Only non-ASCII characters are affected. If _Flags_ is the number 3, numbered expressions are used only where a named expression is not available. The following characters are always converted: `<>"&` and `` `n`` (line feed).

### Asc

**Deprecated:** Not recommended for use in new scripts. Use [Asc()](Asc.htm) instead.

Retrieves the character code (a number between 1 and 255, or 1 and 65535 if Unicode is supported) for the first character in _String_.

```
<span class="func">Transform</span>, OutputVar, Asc, String
```

If _String_ is empty, _OutputVar_ will also be made empty. For example: `Transform, OutputVar, Asc, %VarContainingString%`. To allow for Unicode supplementary characters, use [Ord()](Ord.htm) instead.

### Chr

**Deprecated:** Not recommended for use in new scripts. Use [Chr()](Chr.htm) instead.

Retrieves the single character corresponding to the character code indicated by _Number_.

```
<span class="func">Transform</span>, OutputVar, Chr, Number
```

If _Number_ is not between 1 and 255 inclusive (or 1 and 65535 if Unicode is supported), _OutputVar_ will be made blank to indicate the problem. For example: `Transform, OutputVar, Chr, 130`. Unlike [Chr()](Chr.htm), this sub-command does not support Unicode supplementary characters (character codes 0x10000 to 0x10FFFF).

### Mod

**Deprecated:** Not recommended for use in new scripts. Use [Mod()](Math.htm#Mod) instead.

Retrieves the remainder of _Dividend_ divided by _Divisor_.

```
<span class="func">Transform</span>, OutputVar, Mod, Dividend, Divisor
```

If _Divisor_ is zero, _OutputVar_ will be made blank. _Dividend_ and _Divisor_ can both contain a decimal point. If negative, _Divisor_ will be treated as positive for the calculation. In the following example, the result is 2: `Transform, OutputVar, Mod, 5, 3`.

### Exp

**Deprecated:** Not recommended for use in new scripts. Use [Exp()](Math.htm#Exp) instead.

Retrieves e (which is approximately 2.71828182845905) raised to the _N_ th power.

```
<span class="func">Transform</span>, OutputVar, Exp, N
```

_N_ may be negative and may contain a decimal point.

### Sqrt

**Deprecated:** Not recommended for use in new scripts. Use [Sqrt()](Math.htm#Sqrt) instead.

Retrieves the square root of _Number_.

```
<span class="func">Transform</span>, OutputVar, Sqrt, Number
```

If _Number_ is negative, _OutputVar_ will be made blank.

### Log

**Deprecated:** Not recommended for use in new scripts. Use [Log()](Math.htm#Log) instead.

Retrieves the logarithm (base 10) of _Number_.

```
<span class="func">Transform</span>, OutputVar, Log, Number
```

If _Number_ is negative, _OutputVar_ will be made blank.

### Ln

**Deprecated:** Not recommended for use in new scripts. Use [Ln()](Math.htm#Ln) instead.

Retrieves the natural logarithm (base e) of _Number_.

```
<span class="func">Transform</span>, OutputVar, Ln, Number
```

If _Number_ is negative, _OutputVar_ will be made blank.

### Round

**Deprecated:** Not recommended for use in new scripts. Use [Round()](Math.htm#Round) instead.

Retrieves _Number_ rounded to _N_ decimal places.

```
<span class="func">Transform</span>, OutputVar, Round, Number <span class="optional">, N</span>
```

If _N_ is omitted, _OutputVar_ will be set to _Number_ rounded to the nearest integer. If _N_ is positive number, _Number_ will be rounded to _N_ decimal places. If _N_ is negative, _Number_ will be rounded by _N_ digits to the left of the decimal point. For example, -1 rounds to the ones place, -2 rounds to the tens place, and-3 rounds to the hundreds place. Note: The Round sub-command does not remove trailing zeros when rounding decimal places. For example, 12.333 rounded to one decimal place would become 12.300000. This behavior can be altered by using something like `<a href="SetFormat.htm" data-index="46">SetFormat</a>, Float, 0.1` prior to the operation (in fact, [SetFormat](SetFormat.htm) might eliminate the need to use the Round sub-command in the first place).

### Ceil

**Deprecated:** Not recommended for use in new scripts. Use [Ceil()](Math.htm#Ceil) instead.

Retrieves _Number_ rounded up to the nearest integer.

```
<span class="func">Transform</span>, OutputVar, Ceil, Number
```

### Floor

**Deprecated:** Not recommended for use in new scripts. Use [Floor()](Math.htm#Floor) instead.

Retrieves _Number_ rounded down to the nearest integer.

```
<span class="func">Transform</span>, OutputVar, Floor, Number
```

### Abs

**Deprecated:** Not recommended for use in new scripts. Use [Abs()](Math.htm#Abs) instead.

Retrieves the absolute value of _Number_.

```
<span class="func">Transform</span>, OutputVar, Abs, Number
```

This is computed by removing the leading minus sign (dash) from _Number_ if it has one.

### Sin

**Deprecated:** Not recommended for use in new scripts. Use [Sin()](Math.htm#Sin) instead.

Retrieves the trigonometric sine of _Number_.

```
<span class="func">Transform</span>, OutputVar, Sin, Number
```

_Number_ must be expressed in radians.

### Cos

**Deprecated:** Not recommended for use in new scripts. Use [Cos()](Math.htm#Cos) instead.

Retrieves the trigonometric cosine of _Number_.

```
<span class="func">Transform</span>, OutputVar, Cos, Number
```

_Number_ must be expressed in radians.

### Tan

**Deprecated:** Not recommended for use in new scripts. Use [Tan()](Math.htm#Tan) instead.

Retrieves the trigonometric tangent of _Number_.

```
<span class="func">Transform</span>, OutputVar, Tan, Number
```

_Number_ must be expressed in radians.

### ASin

**Deprecated:** Not recommended for use in new scripts. Use [ASin()](Math.htm#ASin) instead.

Retrieves the arcsine (the number whose sine is _Number_) in radians.

```
<span class="func">Transform</span>, OutputVar, ASin, Number
```

If _Number_ is less than -1 or greater than 1, _OutputVar_ will be made blank.

### ACos

**Deprecated:** Not recommended for use in new scripts. Use [ACos()](Math.htm#ACos) instead.

Retrieves the arccosine (the number whose cosine is _Number_) in radians.

```
<span class="func">Transform</span>, OutputVar, ACos, Number
```

If _Number_ is less than -1 or greater than 1, _OutputVar_ will be made blank.

### ATan

**Deprecated:** Not recommended for use in new scripts. Use [ATan()](Math.htm#ATan) instead.

Retrieves the arctangent (the number whose tangent is _Number_) in radians.

```
<span class="func">Transform</span>, OutputVar, ATan, Number
```

### Pow

**Deprecated:** Not recommended for use in new scripts. Use the [`**` operator](../Variables.htm#pow) instead.

Retrieves _Base_ raised to the power of _Exponent_.

```
<span class="func">Transform</span>, OutputVar, Pow, Base, Exponent
```

Both _Base_ and _Exponent_ may contain a decimal point. If _Exponent_ is negative, _OutputVar_ will be formatted as a floating point number even if _Base_ and _Exponent_ are both integers. A negative _Base_ combined with a fractional _Exponent_ such as 1.5 is not supported; it will cause _OutputVar_ to be made blank.

### BitNot

**Deprecated:** Not recommended for use in new scripts. Use the [`~` operator](../Variables.htm#unary) instead.

Retrieves the bit-inverted version of _Number_.

```
<span class="func">Transform</span>, OutputVar, BitNot, Number
```

Floating point values are truncated to integers prior to the calculation. If _Number_ is between 0 and 4294967295 (0xffffffff), it will be treated as an **unsigned** 32-bit value. Otherwise, it is treated as a **signed** 64-bit value. In the following example, the result is 0xfffff0f0 (4294963440): `Transform, OutputVar, BitNot, 0xf0f`.

### BitAnd

**Deprecated:** Not recommended for use in new scripts. Use the [`&` operator](../Variables.htm#bitwise) instead.

Retrieves the result of the bitwise-AND of _Number1_ and _Number2_.

```
<span class="func">Transform</span>, OutputVar, BitAnd, Number1, Number2
```

Floating point values are truncated to integers prior to the calculation. In the following example, the result is 0xff00 (65280): `Transform, OutputVar, BitAnd, 0xff0f, 0xfff0`.

### BitOr

**Deprecated:** Not recommended for use in new scripts. Use the [`|` operator](../Variables.htm#bitwise) instead.

Retrieves the result of the bitwise-OR of _Number1_ and _Number2_.

```
<span class="func">Transform</span>, OutputVar, BitOr, Number1, Number2
```

Floating point values are truncated to integers prior to the calculation. In the following example, the result is 0xf0f0 (61680): `Transform, OutputVar, BitOr, 0xf000, 0x00f0`.

### BitXOr

**Deprecated:** Not recommended for use in new scripts. Use the [`^` operator](../Variables.htm#bitwise) instead.

Retrieves the result of the bitwise-EXCLUSIVE-OR of _Number1_ and _Number2_.

```
<span class="func">Transform</span>, OutputVar, BitXOr, Number1, Number2
```

Floating point values are truncated to integers prior to the calculation. In the following example, the result is 0xff00 (65280): `Transform, OutputVar, BitXOr, 0xf00f, 0x0f0f`.

### BitShiftLeft

**Deprecated:** Not recommended for use in new scripts. Use the [`<<` operator](../Variables.htm#bitwise) instead.

Retrieves the result of shifting _Number_ to the left by _N_ bit positions.

```
<span class="func">Transform</span>, OutputVar, BitShiftLeft, Number, N
```

This is equivalent to multiplying _Number_ by "2 to the _N_ th power". Floating point values are truncated to integers prior to the calculation. In the following example, the result is 8: `Transform, OutputVar, BitShiftLeft, 1, 3`.

### BitShiftRight

**Deprecated:** Not recommended for use in new scripts. Use the [`>>` operator](../Variables.htm#bitwise) instead.

Retrieves the result of shifting _Number_ to the right by _N_ bit positions.

```
<span class="func">Transform</span>, OutputVar, BitShiftRight, Number, N
```

This is equivalent to dividing _Number_ by "2 to the _N_ th power", truncating the remainder. Floating point values are truncated to integers prior to the calculation. In the following example, the result is 2: `Transform, OutputVar, BitShiftRight, 17, 3`.

### FromCodePage / ToCodePage

[AHK\_L 54+]: Removed. Use [StrPut](StrPut.htm)/ [StrGet](StrGet.htm) instead.

## Remarks

Sub-commands that accept numeric parameters can also use [expressions](../Variables.htm#Expressions) for those parameters.

If one of the parameters is a floating point number, the following sub-commands will retrieve a floating point number rather than an integer: [Mod](#Mod), [Pow](#Pow), [Round](#Round), and [Abs](#Abs). The number of decimal places retrieved is determined by [SetFormat](SetFormat.htm).

To convert a radians value to degrees, multiply it by 180/pi (approximately 57.29578). To convert a degrees value to radians, multiply it by pi/180 (approximately 0.01745329252).

The value of pi (approximately 3.141592653589793) is 4 times the arctangent of 1.

## Related

[Math Functions](Math.htm), [SetFormat](SetFormat.htm), [Expressions](../Variables.htm#Expressions), [Operators](../Variables.htm#Operators), [StringLower](StringLower.htm), [if var is type](IfIs.htm)

## Examples

Retrieves the ASCII code of the letter A and stores it in OutputVar.

```
Transform, OutputVar, Asc, A
```

