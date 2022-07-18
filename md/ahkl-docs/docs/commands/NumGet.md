# NumGet()

Returns the binary number stored at the specified address+offset.

```
Number := <span class="func">NumGet</span>(VarOrAddress <span class="optional">, Offset := 0</span><span class="optional">, Type := "UPtr"</span>)
```

## Parameters

VarOrAddress

A memory address or variable. If _VarOrAddress_ is a variable such as `MyVar`, the address of the variable's string buffer is used. This is usually equivalent to passing `&MyVar`, but omitting the "&" performs better and ensures that the target address + offset is [valid](VarSetCapacity.htm).

**Do not pass a variable reference** if the variable _contains_ the target address; in that case, pass an expression such as `MyVar+0`.

Offset

An offset - in bytes - which is added to _VarOrAddress_ to determine the target address.

Type

If blank or omitted, it defaults to UPtr. Otherwise, specify UInt, Int, Int64, Short, UShort, Char, UChar, Double, Float, Ptr or UPtr.

_Unsigned_ 64-bit integers are not supported, as AutoHotkey's native integer type is Int64. Therefore, to work with numbers greater than or equal to 0x8000000000000000, omit the U prefix and interpret any negative values as large integers. For example, a value of -1 as an Int64 is really 0xFFFFFFFFFFFFFFFF if it is intended to be a UInt64. On 64-bit builds, UPtr is equivalent to Int64.

Unlike DllCall(), these must be enclosed in quotes when used as literal strings.

For details see [DllCall Types](DllCall.htm#types).

## Return Value

If the target address is invalid, an empty string is returned. However, some invalid addresses cannot be detected as such and may cause unpredictable behaviour.

Otherwise, the number at the specified address+offset is returned.

## General Remarks

If only two parameters are present, the second parameter can be either _Offset_ or _Type_. For example, `NumGet(var, "int")` is valid.

## Related

[NumPut()](NumPut.htm), [DllCall()](DllCall.htm), [VarSetCapacity()](VarSetCapacity.htm)

