# Var := expression

Evaluates an expression and stores the result in a [variable](../Variables.htm).

```
Var := expression
```

## Parameters

Var

The name of the [variable](../Variables.htm) in which to store the result of _expression_.

Expression

See [expressions](../Variables.htm#Expressions) and the examples below for details.

## Remarks

The := operator is optimized so that it performs just as quickly as the = operator for simple cases such as the following:

```
x := y  <em>; Same performance as x = %y%</em>
x := 5  <em>; Same performance as x = 5.</em>
x := "literal string"  <em>; Same performance as x = literal string.</em>
```

The words `true` and `false` are built-in constants containing 1 and 0. They can be used to make a script more readable as in these examples:

```
CaseSensitive := false
ContinueSearch := true
```

It is possible to create a [pseudo-array](../misc/Arrays.htm#pseudo) with this command and any others that accept an _OutputVar_. This is done by making _OutputVar_ contain a reference to another variable, e.g. `Array%i% := Var/100 + 5`. See [Arrays](../misc/Arrays.htm) for more information.

## Related

[Expressions](../Variables.htm#Expressions), [If (expression)](IfExpression.htm), [Functions](../Functions.htm), [SetEnv](SetEnv.htm), [EnvSet](EnvSet.htm), [EnvAdd](EnvAdd.htm), [EnvSub](EnvSub.htm), [EnvMult](EnvMult.htm), [EnvDiv](EnvDiv.htm), [If (legacy)](IfEqual.htm), [Arrays](../misc/Arrays.htm)

## Examples

Assigns a literal string to a variable.

```
Var := "literal string"
```

Assigns a number to a variable.

```
Var := 3
```

Calculates the net price and stores the result in Var.

```
Var := Price * (1 - Discount/100)
```

Determines the truth of an expression and stores the result (1 for true or 0 for false) in Finished.

```
Finished := not Done or A_Index > 100
if not Finished
{
    FileAppend, %NewText%`n, %TargetFile%
    return
}
else
    ExitApp
```

