# Math Functions

Functions for performing various mathematical operations such as rounding, exponentiation, squaring, etc.

## Table of Contents

- [General Math](#General):

  - [Abs](#Abs): Returns the absolute value of a number.
  - [Ceil](#Ceil): Returns a number rounded up to the nearest integer.
  - [Exp](#Exp): Returns e raised to the _N_ th power.
  - [Floor](#Floor): Returns a number rounded down to the nearest integer.
  - [Log](#Log): Returns the logarithm (base 10) of a number.
  - [Ln](#Ln): Returns the natural logarithm (base e) of a number.
  - [Max](#Max)[v1.1.27+]: Returns the highest value of one or more numbers.
  - [Min](#Min)[v1.1.27+]: Returns the lowest value of one or more numbers.
  - [Mod](#Mod): Returns the remainder of a division.
  - [Round](#Round): Returns a number rounded to _N_ decimal places.
  - [Sqrt](#Sqrt): Returns the square root of a number.
- [Trigonometry](#Trigonometry):

  - [Sin](#Sin): Returns the trigonometric sine of a number.
  - [Cos](#Cos): Returns the trigonometric cosine of a number.
  - [Tan](#Tan): Returns the trigonometric tangent of a number.
  - [ASin](#ASin): Returns the arcsine (the number whose sine is the specified number) in radians.
  - [ACos](#ACos): Returns the arccosine (the number whose cosine is the specified number) in radians.
  - [ATan](#ATan): Returns the arctangent (the number whose tangent is the specified number) in radians.
- [Error-handling](#Errors)

## General Math

### Abs

Returns the absolute value of _Number_.

```
Value := <span class="func">Abs</span>(Number)
```

The return value is the same type as _Number_ (integer or floating point).

```
MsgBox, % Abs(-1.2) <em>; Returns 1.2</em>
```

### Ceil

Returns _Number_ rounded up to the nearest integer (without any .00 suffix).

```
Value := <span class="func">Ceil</span>(Number)
```

```
MsgBox, % Ceil(1.2)  <em>; Returns 2</em>
MsgBox, % Ceil(-1.2) <em>; Returns -1</em>
```

### Exp

Returns e (which is approximately 2.71828182845905) raised to the _N_ th power.

```
Value := <span class="func">Exp</span>(N)
```

_N_ may be negative and may contain a decimal point. To raise numbers other than e to a power, use the [\\*\\* operator](../Variables.htm#pow).

```
MsgBox, % Exp(1.2) <em>; Returns 3.320117</em>
```

### Floor

Returns _Number_ rounded down to the nearest integer (without any .00 suffix).

```
Value := <span class="func">Floor</span>(Number)
```

```
MsgBox, % Floor(1.2)  <em>; Returns 1</em>
MsgBox, % Floor(-1.2) <em>; Returns -2</em>
```

### Log

Returns the logarithm (base 10) of _Number_.

```
Value := <span class="func">Log</span>(Number)
```

The result is formatted as [floating point](SetFormat.htm#Float). If _Number_ is negative, an empty string is returned.

```
MsgBox, % Log(1.2) <em>; Returns 0.079181</em>
```

### Ln

Returns the natural logarithm (base e) of _Number_.

```
Value := <span class="func">Ln</span>(Number)
```

The result is formatted as [floating point](SetFormat.htm#Float). If _Number_ is negative, an empty string is returned.

```
MsgBox, % Ln(1.2) <em>; Returns 0.182322</em>
```

### Max [v1.1.27+]

Returns the highest value of one or more numbers.

```
Value := <span class="func">Max</span>(Number1 <span class="optional">, Number2, ...</span>)
```

If one of the input values is non-numeric, an empty string is returned.

```
MsgBox, % Max(2.11, -2, 0) <em>; Returns 2.11</em>
```

You can also specify a [variadic parameter](../Functions.htm#Variadic) to compare multiple values within an array. For example:

```
array := [1, 2, 3, 4]
MsgBox, % Max(array*) <em>; Returns 4</em>

```

### Min [v1.1.27+]

Returns the lowest value of one or more numbers.

```
Value := <span class="func">Min</span>(Number1 <span class="optional">, Number2, ...</span>)
```

If one of the input values is non-numeric, an empty string is returned.

```
MsgBox, % Min(2.11, -2, 0) <em>; Returns -2</em>
```

You can also specify a [variadic parameter](../Functions.htm#Variadic) to compare multiple values within an array. For example:

```
array := [1, 2, 3, 4]
MsgBox, % Min(array*) <em>; Returns 1</em>
```

### Mod

Modulo. Returns the remainder when _Dividend_ is divided by _Divisor_.

```
Value := <span class="func">Mod</span>(Dividend, Divisor)
```

The sign of the result is always the same as the sign of the first parameter. If either input is a floating point number, the result is also a floating point number. If the second parameter is zero, the function yields a blank result (empty string).

```
MsgBox, % Mod(7.5, 2) <em>; Returns 1.5 (2 x 3 + 1.5)</em>
```

### Round

Returns _Number_ rounded to _N_ decimal places.

```
Value := <span class="func">Round</span>(Number <span class="optional">, N</span>)
```

If _N_ is omitted or 0, _Number_ is rounded to the nearest integer:

```
MsgBox, % Round(3.14)    <em>; Returns 3</em>
```

If _N_ is positive number, _Number_ is rounded to _N_ decimal places:

```
MsgBox, % Round(3.14, 1) <em>; Returns 3.1</em>
```

If _N_ is negative, _Number_ is rounded by _N_ digits to the left of the decimal point:

```
MsgBox, % Round(345, -1) <em>; Returns 350</em>
MsgBox, % Round(345, -2) <em>; Returns 300</em>
```

Unlike [Transform Round](Transform.htm), the result has no .000 suffix whenever _N_ is omitted or less than 1. [v1.0.44.01+]: A value of _N_ greater than zero displays exactly _N_ decimal places rather than obeying [SetFormat](SetFormat.htm). To avoid this, perform another math operation on Round()'s return value; for example: `Round(3.333, 1)<strong>+0</strong>`.

### Sqrt

Returns the square root of _Number_.

```
Value := <span class="func">Sqrt</span>(Number)
```

The result is formatted as [floating point](SetFormat.htm#Float). If _Number_ is negative, the function yields a blank result (empty string).

```
MsgBox, % Sqrt(16) <em>; Returns 4</em>
```

## Trigonometry

**Note**: To convert a radians value to degrees, multiply it by 180/pi (approximately 57.29578). To convert a degrees value to radians, multiply it by pi/180 (approximately 0.01745329252). The value of pi (approximately 3.141592653589793) is 4 times the arctangent of 1.

### Sin

Returns the trigonometric sine of _Number_.

```
Value := <span class="func">Sin</span>(Number)
```

_Number_ must be expressed in radians.

```
MsgBox, % Sin(1.2) <em>; Returns 0.932039</em>
```

### Cos

Returns the trigonometric cosine of _Number_.

```
Value := <span class="func">Cos</span>(Number)
```

_Number_ must be expressed in radians.

```
MsgBox, % Cos(1.2) <em>; Returns 0.362358</em>
```

### Tan

Returns the trigonometric tangent of _Number_.

```
Value := <span class="func">Tan</span>(Number)
```

_Number_ must be expressed in radians.

```
MsgBox, % Tan(1.2) <em>; Returns 2.572152</em>
```

### ASin

Returns the arcsine (the number whose sine is _Number_) in radians.

```
Value := <span class="func">ASin</span>(Number)
```

If _Number_ is less than -1 or greater than 1, the function yields a blank result (empty string).

```
MsgBox, % ASin(0.2) <em>; Returns 0.201358</em>
```

### ACos

Returns the arccosine (the number whose cosine is _Number_) in radians.

```
Value := <span class="func">ACos</span>(Number)
```

If _Number_ is less than -1 or greater than 1, the function yields a blank result (empty string).

```
MsgBox, % ACos(0.2) <em>; Returns 1.369438</em>
```

### ATan

Returns the arctangent (the number whose tangent is _Number_) in radians.

```
Value := <span class="func">ATan</span>(Number)
```

```
MsgBox, % ATan(1.2) <em>; Returns 0.876058</em>
```

## Error-Handling

Invalid operations such as divide by zero generally yield a blank result (empty string).

[Abs](#Abs), [Max](#Max), [Min](#Min) and [Mod](#Mod) return an empty string if any of their incoming parameters are non-numeric. Most math functions do not perform strict type-checking, so may treat non-numeric values as zero or another number. For example, `Round("1.0foo")` produces 1. However, this is expected to change in [AutoHotkey v2](https://www.autohotkey.com/v2/).

