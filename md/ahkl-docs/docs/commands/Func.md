# Func() [v1.1.00+]

Retrieves a reference to a function.

```
FunctionReference := <span class="func">Func</span>(FunctionName)
```

## Parameters

FunctionName

The name of the function whose reference is retrieved. _FunctionName_ must exist explicitly in the script.

## Return Value

This function returns a [reference to _FunctionName_](../Objects.htm#Function_References). If _FunctionName_ does not exist explicitly in the script (by means such as [#Include](_Include.htm) or a non-dynamic call to a [library function](../Functions.htm#lib)), it returns 0.

## Remarks

This function can be used to call the function or retrieve [information](../objects/Func.htm) such as the minimum and maximum number of parameters.

## Related

[Function References](../Objects.htm#Function_References), [Func Object](../objects/Func.htm)

## Examples

Retrieves a reference to a function and displays information about it.

```
fn := Func("StrLen")
MsgBox % fn.Name "() is " (fn.IsBuiltIn ? "built-in." : "user-defined.")
```

