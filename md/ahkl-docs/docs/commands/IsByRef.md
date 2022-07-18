# IsByRef() [v1.1.01+]

Returns a non-zero number if the specified [ByRef parameter](../Functions.htm#ByRef) was supplied with a variable.

```
TrueOrFalse := <span class="func">IsByRef</span>(ParameterVar)
```

## Parameters

ParameterVar

A reference to the variable. For example: `IsByRef(MyParameter)`.

## Return Value

This function returns 1 if _ParameterVar_ is a [ByRef parameter](../Functions.htm#ByRef) and the caller supplied a variable; or 0 if _ParameterVar_ is any other kind of variable.

## Related

[ByRef parameters](../Functions.htm#ByRef)

## Examples

Reports 1 (true) because Param is a [ByRef parameter](../Functions.htm#ByRef) and was supplied with a variable.

```
MsgBox, % Function(MyVar)

Function(ByRef Param)
{
    return IsByRef(Param)
}
```

