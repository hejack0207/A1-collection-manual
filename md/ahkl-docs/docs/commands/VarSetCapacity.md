# VarSetCapacity()

Enlarges a variable's holding capacity or frees its memory. Normally, this is necessary only for unusual circumstances such as [DllCall()](DllCall.htm).

```
GrantedCapacity := <span class="func">VarSetCapacity</span>(TargetVar <span class="optional">, RequestedCapacity, FillByte</span>)
```

## Parameters

TargetVar

A reference to a variable. For example: `VarSetCapacity(MyVar, 1000)`. This can also be a dynamic variable such as `Array%i%` or a [function's ByRef parameter](../Functions.htm#ByRef).

RequestedCapacity

If omitted, the variable's current capacity will be returned and its contents will not be altered. Otherwise, anything currently in the variable is lost (the variable becomes blank).

Specify for _RequestedCapacity_ the number of bytes that the variable should be able to hold after the adjustment. For Unicode strings, this should be the length times two. _RequestedCapacity_ does not include the internal zero terminator. For example, specifying 1 would allow the variable to hold up to one byte in addition to its internal terminator. Note: the variable will auto-expand if the script assigns it a larger value later.

Since this function is often called simply to ensure the variable has a certain minimum capacity, for performance reasons, it shrinks the variable only when _RequestedCapacity_ is 0. In other words, if the variable's capacity is already greater than _RequestedCapacity_, it will not be reduced (but the variable will still made blank for consistency).

Therefore, to explicitly shrink a variable, first free its memory with `VarSetCapacity(Var, 0)` and then use `VarSetCapacity(Var, NewCapacity)` \-\- or simply let it auto-expand from zero as needed.

For performance reasons, freeing a variable whose previous capacity was less than 64 characters (128 bytes in Unicode builds) might have no effect because its memory is of a permanent type. In this case, the current capacity will be returned rather than 0.

For performance reasons, the memory of a variable whose capacity is less than 4096 bytes is not freed by storing an empty string in it (e.g. `Var := ""`). However, `VarSetCapacity(Var, 0)` does free it.

[v1.0.44.03+]: Specify -1 for _RequestedCapacity_ to update the variable's internally-stored string length to the length of its current contents. This is useful in cases where the variable has been altered indirectly, such as by passing its [address](../Variables.htm#amp) via [DllCall()](DllCall.htm). In this mode, VarSetCapacity() returns the length in bytes rather than the capacity.

FillByte

This parameter is normally omitted, in which case the memory of the target variable is not initialized (instead, the variable is simply made blank as described above). Otherwise, specify a number between 0 and 255. Each byte in the target variable's memory area (its current capacity, which might be greater than _RequestedCapacity_) is set to that number. Zero is by far the most common value, which is useful in cases where the variable will hold raw binary data such as a [DllCall structure](DllCall.htm#struct).

## Return Value

This function returns the number of bytes that Var can now hold, which will be greater than or equal to _RequestedCapacity_. If _TargetVar_ is not a valid variable name (such as a literal string or number), 0 is returned. If the system has insufficient memory to make the change (very rare), an error dialog is displayed and the current capacity is returned - this behaviour may change in a future version.

## Remarks

In addition to its uses described at [DllCall()](DllCall.htm#str), this function can also be used to enhance performance when building a string by means of gradual concatenation. This is because multiple automatic resizings can be avoided when you have some idea of what the string's final length will be. In such a case, _RequestedCapacity_ need not be accurate: if the capacity is too small, performance is still improved and the variable will begin auto-expanding when the capacity has been exhausted. If the capacity is too large, some of the memory is wasted, but only temporarily because all the memory can be freed after the operation by means of `VarSetCapacity(Var, 0)` or `Var := ""`.

[#MaxMem](_MaxMem.htm) restricts only the automatic expansion that a variable does on its own. It does not affect VarSetCapacity.

## Related

[DllCall()](DllCall.htm), [#MaxMem](_MaxMem.htm), [NumPut()](NumPut.htm), [NumGet()](NumGet.htm)

## Examples

Optimize by ensuring _MyVar_ has plenty of space to work with.

```
VarSetCapacity(MyVar, 10240000)  <em>; ~10 MB</em>
Loop
{
    <em>; ...</em>
    MyVar .= StringToConcatenate
    <em>; ...</em>
}
```

Use a variable to receive a string from an external function via [DllCall()](DllCall.htm).

```
<em>; Calculate required buffer space for a string.</em>
bytes_per_char := A_IsUnicode ? 2 : 1
max_chars := 500
max_bytes := max_chars * bytes_per_char

Loop 2
{
    <em>; Allocate space for use with DllCall.</em>
    VarSetCapacity(buf, max_bytes)

    if (A_Index = 1)
        <em>; Alter the variable indirectly via DllCall.</em>
        DllCall("wsprintf", <span class="red">"Ptr", &buf</span>, "Str", "0x%08x", "UInt", 4919)
    else
        <em>; Use "str" to update the length automatically:</em>
        DllCall("wsprintf", <span class="blue">"Str", buf</span>, "Str", "0x%08x", "UInt", 4919)

    <em>; Concatenate a string to demonstrate why the length needs to be updated:</em>
    wrong_str := buf . "<end>"
    wrong_len := StrLen(buf)

    <em>; Update the variable's length.</em>
    VarSetCapacity(buf, -1)

    right_str := buf . "<end>"
    right_len := StrLen(buf)

    MsgBox,
    (
    Before updating
      String: %wrong_str%
      Length: %wrong_len%

    After updating
      String: %right_str%
      Length: %right_len%
    )
}

```

