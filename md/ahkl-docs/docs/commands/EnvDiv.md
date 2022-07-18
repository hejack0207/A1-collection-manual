# EnvDiv

Sets a [variable](../Variables.htm) to itself divided by the given value. Synonymous with: `Var /= Value`.

**Deprecated:** This command is not recommended for use in new scripts. Use `Var := Var / Value` or `Var /= Value` instead.

```
<span class="func">EnvDiv</span>, Var, Value
```

## Parameters

Var

The name of the [variable](../Variables.htm) upon which to operate.

Value

Any integer, floating point number, or [expression](../Variables.htm#Expressions).

## Remarks

This command is equivalent to the shorthand style: `Var /= Value`.

Division by zero will result in an error-message window when the script is loaded (if possible); otherwise it makes the variable blank.

If either _Var_ or _Value_ is blank or does not start with a number, it is considered to be 0 for the purpose of the calculation (except when used _internally_ in an expression such as `Var := X /= Y`).

If either _Var_ or _Value_ contains a decimal point, the end result will be a floating point number in the format set by [SetFormat](SetFormat.htm). Otherwise, the result will be truncated (e.g. 19 divided by 10 will yield 1).

## Related

[EnvAdd](EnvAdd.htm) [, EnvSub](EnvSub.htm), [EnvMult](EnvMult.htm), [SetFormat](SetFormat.htm), [Expressions](../Variables.htm#Expressions), [If var is [not] type](IfIs.htm), [SetEnv](SetEnv.htm), [bitwise operations (Transform)](Transform.htm)

## Examples

Sets MyCount to itself divided by 2.

```
EnvDiv, MyCount, 2
```

Equivalent to above.

```
MyCount /= 2
```

