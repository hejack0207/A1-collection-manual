# IsFunc() [v1.0.48+]

Returns a non-zero number if the specified function exists in the script.

```
MinParamsPlus1 := <span class="func">IsFunc</span>(FunctionName)
```

## Parameters

FunctionName

The name of the function whose minimum number of parameters is retrieved. _FunctionName_ must exist explicitly in the script. In [v1.1.00+], _FunctionName_ can be a [function reference](../Objects.htm#Function_References) instead of a name.

## Return Value

This function returns one plus the minimum number of parameters (e.g. 1 for a function that requires zero parameters, 2 for a function that requires 1 parameter, etc.). If _FunctionName_ does not exist explicitly in the script (by means such as [#Include](_Include.htm) or a non-dynamic call to a [library function](../Functions.htm#lib)), it returns 0.

## Related

[Dynamically Calling a Function](../Functions.htm#DynCall), [Function References](../Objects.htm#Function_References), [Func Object](../objects/Func.htm), [Func()](Func.htm), [A\_ThisFunc](../Variables.htm#ThisFunc)

## Examples

Reports the number of mandatory parameters of a function.

```
count := IsFunc("RegExReplace") <em>; Any function name can be used here.</em>
if count
    MsgBox, % "This function exists and has " count-1 " mandatory parameters."
else
    MsgBox, % "This function does not exist."
```

