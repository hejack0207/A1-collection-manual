# EnvSub

Sets a [variable](../Variables.htm) to itself minus the given value (can also compare [date-time](FileSetTime.htm#YYYYMMDD) values). Synonymous with: `Var -= Value`.

```
<span class="func">EnvSub</span>, Var, Value <span class="optional">, TimeUnits</span>
Var -= Value <span class="optional">, TimeUnits</span>
Var--

```

## Parameters

Var

The name of the [variable](../Variables.htm) upon which to operate.

Value

Any integer, floating point number, or [expression](../Variables.htm#Expressions).

TimeUnits

If present, this parameter directs the command to subtract _Value_ from _Var_ as though both of them are date-time stamps in the [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format. _TimeUnits_ can be either Seconds, Minutes, Hours, or Days (or just the first letter of each of these). If _Value_ is blank, the current time will be used in its place. Similarly, if _Var_ is an empty variable, the current time will be used in its place.

The result is always rounded _down_ to the nearest integer. For example, if the actual difference between two timestamps is 1.999 days, it will be reported as 1 day. If higher precision is needed, specify Seconds for _TimeUnits_ and divide the result by 60.0, 3600.0, or 86400.0.

If either _Var_ or _Value_ is an invalid timestamp or contains a year prior to 1601, _Var_ will be made blank to indicate the problem.

The built-in variable **A\_Now** contains the current local time in [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format.

To precisely determine the elapsed time between two events, use the [A\_TickCount method](../Variables.htm#TickCount) because it provides millisecond precision.

To add or subtract a certain number of seconds, minutes, hours, or days from a timestamp, use [EnvAdd](EnvAdd.htm) (subtraction is achieved by adding a negative number).

## Remarks

This command is equivalent to the shorthand style: `Var -= Value`.

Variables can be increased or decreased by 1 by using `Var++`, `Var--`, `++Var`, or `--Var`.

If either _Var_ or _Value_ is blank or does not start with a number, it is considered to be 0 for the purpose of the calculation (except when used _internally_ in an expression and except when using the _TimeUnits_ parameter).

If either _Var_ or _Value_ contains a decimal point, the end result will be a floating point number in the format set by [SetFormat](SetFormat.htm).

## Related

[EnvAdd](EnvAdd.htm), [EnvMult](EnvMult.htm), [EnvDiv](EnvDiv.htm), [SetFormat](SetFormat.htm), [Expressions](../Variables.htm#Expressions), [If var is [not] type](IfIs.htm), [SetEnv](SetEnv.htm), [FileGetTime](FileGetTime.htm)

## Examples

Sets MyCount to itself minus 2.

```
EnvSub, MyCount, 2
```

Equivalent to above.

```
MyCount -= 2
```

Calculates the number of days between two timestamps and reports the result.

```
var1 := 20050126
var2 := 20040126
EnvSub, var1, %var2%, days
MsgBox, %var1%  <em>; The answer will be 366 since 2004 is a leap year.</em>
```

