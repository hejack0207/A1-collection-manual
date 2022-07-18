# IsObject() [v1.0.90+]

Returns a non-zero number if the specified value is an object.

```
TrueOrFalse := <span class="func">IsObject</span>(ObjectValue)
```

## Parameters

ObjectValue

A [object](../Objects.htm) stored in a variable, returned from a function, stored in another object or written directly.

## Return Value

This function returns 1 if _ObjectValue_ is an object; otherwise 0.

## Related

[Objects](../Objects.htm)

## Examples

Reports "This is an object." because the value is an object.

```
object := {key: "value"}

if IsObject(object)
    MsgBox, This is an object.
else
    MsgBox, This is not an object.
```

