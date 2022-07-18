# If var [not] between LowerBound and UpperBound

Checks whether a [variable's](../Variables.htm) contents are numerically or alphabetically between two values (inclusive).

```
<span class="func">if</span> Var <span class="func">between</span> LowerBound <span class="func">and</span> UpperBound
<span class="func">if</span> Var <span class="func">not between</span> LowerBound <span class="func">and</span> UpperBound

```

## Parameters

Var

The [variable](../Variables.htm) name whose contents will be checked.

LowerBound

To be within the specified range, _Var_ must be greater than or equal to this string, number, or variable reference.

UpperBound

To be within the specified range, _Var_ must be less than or equal to this string, number, or variable reference.

## Remarks

If all three of the parameters are purely numeric, they will be compared as numbers rather than as strings. Otherwise, they will be compared alphabetically as strings (that is, alphabetical order will determine whether _Var_ is within the specified range). In that case, `<a href="StringCaseSense.htm" data-index="3">StringCaseSense</a> On` can be used to make the comparison case sensitive.

The "between" operator is not supported in [expressions](../Variables.htm#Expressions). Instead, use [If statements](IfExpression.htm) such as `if (Var >= LowerBound and Var <= UpperBound)` to simulate the behavior of this operator.

## Related

[IfEqual/Greater/Less](IfEqual.htm), [if var in/contains MatchList](IfIn.htm), [if var is type](IfIs.htm), [IfInString](IfInString.htm), [StringCaseSense](StringCaseSense.htm), [EnvAdd](EnvAdd.htm) [, Blocks](Block.htm), [Else](Else.htm)

## Examples

Checks whether var is in the range 1 to 5.

```
if var between 1 and 5
    MsgBox, %var% is in the range 1 to 5, inclusive.
```

Checks whether var is in the range 0.0 to 1.0.

```
if var not between 0.0 and 1.0
    MsgBox %var% is not in the range 0.0 to 1.0, inclusive.
```

Checks whether var is between VarLow and VarHigh (inclusive).

```
if var between %VarLow% and %VarHigh%
    MsgBox %var% is between %VarLow% and %VarHigh%.
```

Checks whether var is alphabetically between the words blue and red (inclusive).

```
if var between blue and red
    MsgBox %var% is alphabetically between the words blue and red.
```

Allows the user to enter a number and checks whether it is in the range 1 to 10.

```
LowerLimit := 1
UpperLimit := 10
InputBox, UserInput, Enter a number between %LowerLimit% and %UpperLimit%
if UserInput not between %LowerLimit% and %UpperLimit%
    MsgBox Your input is not within the valid range.
```

