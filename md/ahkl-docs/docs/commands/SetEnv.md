# SetEnv (Var = Value)

Assigns the specified value to a [variable](../Variables.htm).

**Deprecated:** This command or a legacy assignment is not recommended for use in new scripts. Use [expression assignments](SetExpression.htm) like `Var := Value` instead.

```
<span class="func">SetEnv</span>, Var, Value
Var = Value

```

## Parameters

Var

The name of the [variable](../Variables.htm) in which to store _Value_.

Value

The string or number to store. If the string is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

## Remarks

By default, any spaces or tabs at the beginning and end of _Value_ are omitted from _Var_. To prevent this, use the methods described at [AutoTrim Off](AutoTrim.htm#Off).

The name "SetEnv" is misleading and is a holdover from AutoIt v2. Unlike AutoIt v2, AutoHotkey does not store its variables in the environment. This is because performance would be worse and also because the OS limits the size of each environment variable to 32 KB. Use [EnvSet](EnvSet.htm) instead of SetEnv to write to an [environment variable](../Concepts.htm#environment-variables).

The memory occupied by a large variable can be freed by setting it equal to nothing, e.g. `Var =`.

It is possible to create a [pseudo-array](../misc/Arrays.htm#pseudo) with this command and any others that accept an _OutputVar_. This is done by making _OutputVar_ contain a reference to another variable, e.g. `array%i% = 123`. See [Arrays](../misc/Arrays.htm) for more details.

## Related

[AutoTrim](AutoTrim.htm), [EnvSet](EnvSet.htm), [EnvAdd](EnvAdd.htm), [EnvSub](EnvSub.htm), [EnvMult](EnvMult.htm), [EnvDiv](EnvDiv.htm), [If (legacy)](IfEqual.htm), [Arrays](../misc/Arrays.htm)

## Examples

Assigns a string to a variable.

```
Var1 = This is a string.
```

Assigns a number to a variable.

```
Color2 = 450
```

Assigns the value of Var1 to a variable.

```
Var1 = This is a string.
Color3 = %Var1%
```

Assigns the value of [A\_TickCount](../Variables.htm#TickCount) to a [pseudo-array](../misc/Arrays.htm#pseudo) variable.

```
i = 1
Array%i% = %A_TickCount%
```

