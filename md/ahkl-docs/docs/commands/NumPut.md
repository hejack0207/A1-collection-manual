# NumPut()

Stores a number in binary format at the specified address+offset.

```
<span class="func">NumPut</span>(Number, VarOrAddress <span class="optional">, Offset := 0</span><span class="optional">, Type := "UPtr"</span>)
```

## Parameters

Number

The number to store.

VarOrAddress

A memory address or variable. If _VarOrAddress_ is a variable such as `MyVar`, the address of the variable's string buffer is used. This is usually equivalent to passing `&MyVar`, but omitting the "&" performs better and ensures that the target address + offset is [valid](VarSetCapacity.htm).

**Do not pass a variable reference** if the variable _contains_ the target address; in that case, pass an expression such as `MyVar+0`.

Offset

An offset - in bytes - which is added to _VarOrAddress_ to determine the target address.

Type

If blank or omitted, it defaults to UPtr. Otherwise, specify UInt, UInt64, Int, Int64, Short, UShort, Char, UChar, Double, Float, Ptr or UPtr.

UInt64 is supported in [v1.0.48+] by allowing large unsigned values to be passed as strings. In earlier versions and for all other integer types, or when passing pure integers, signed vs. unsigned does not affect the result due to the use of two's complement to represent signed integers.

Unlike DllCall(), these must be enclosed in quotes when used as literal strings.

For details see [DllCall Types](DllCall.htm#types).

## Return Value

If the target address is invalid, an empty string is returned. However, some invalid addresses cannot be detected as such and may cause unpredictable behaviour.

Otherwise, the address to the right of the item just written is returned. This is often used when writing a sequence of numbers of different types, such as in a structure for use with DllCall().

## General Remarks

If an integer is too large to fit in the specified _Type_, its most significant bytes are ignored; e.g. `NumPut(257, var, 0, "Char")` would store the number 1.

If only three parameters are present, the third parameter can be either _Offset_ or _Type_. For example, `NumPut(x, var, "int")` is valid.

## Related

[NumGet()](NumGet.htm), [DllCall()](DllCall.htm), [VarSetCapacity()](VarSetCapacity.htm)

