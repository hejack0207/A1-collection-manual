# EnvAdd

Sets a [variable](../Variables.htm) to the sum of itself plus the given value (can also add or subtract time from a [date-time](FileSetTime.htm#YYYYMMDD) value). Synonymous with: `Var += Value`.

```
<span class="func">EnvAdd</span>, Var, Value <span class="optional">, TimeUnits</span>
Var += Value <span class="optional">, TimeUnits</span>
Var++

```

## Parameters

Var

The name of the [variable](../Variables.htm) upon which to operate.

Value

Any integer, floating point number, or [expression](../Variables.htm#Expressions).

TimeUnits

If present, this parameter directs the command to add _Value_ to _Var_, treating _Var_ as a date-time stamp in the [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format and treating _Value_ as the integer or floating point number of units to add (specify a negative number to perform subtraction). _TimeUnits_ can be either Seconds, Minutes, Hours, or Days (or just the first letter of each of these).

If _Var_ is an empty variable, the current time will be used in its place. If _Var_ contains an invalid timestamp or a year prior to 1601, or if _Value_ is non-numeric, _Var_ will be made blank to indicate the problem.

The built-in variable **A\_Now** contains the current local time in [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format.

To calculate the amount of time between two timestamps, use [EnvSub](EnvSub.htm).

## Remarks

This command is equivalent to the shorthand style: `Var += Value`.

Variables can be increased or decreased by 1 by using `Var++`, `Var--`, `++Var`, or `--Var`.

If either _Var_ or _Value_ is blank or does not start with a number, it is considered to be 0 for the purpose of the calculation (except when used _internally_ in an expression and except when using the _TimeUnits_ parameter).

If either _Var_ or _Value_ contains a decimal point, the end result will be a floating point number in the format set by [SetFormat](SetFormat.htm).

## Related

[EnvSub](EnvSub.htm), [EnvMult](EnvMult.htm), [EnvDiv](EnvDiv.htm), [SetFormat](SetFormat.htm), [Expressions](../Variables.htm#Expressions), [If var is [not] type](IfIs.htm), [SetEnv](SetEnv.htm), [FileGetTime](FileGetTime.htm)

## Examples

Sets MyCount to the sum of itself plus 2.

```
EnvAdd, MyCount, 2
```

Equivalent to above.

```
MyCount += 2
```

Adds 31 days to the current timestamp and reports the result.

```
var1 := ""  <em>; Make it blank so that the below will use the current timestamp instead.</em>
var1 += 31, days
MsgBox, %var1%  <em>; The answer will be the date 31 days from now.</em>
```

