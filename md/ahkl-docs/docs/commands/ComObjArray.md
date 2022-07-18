# ComObjArray() [v1.0.91+]

Creates a SafeArray for use with COM.

```
ArrayObj := <span class="func">ComObjArray</span>(VarType, Count1 <span class="optional">, Count2, ... Count8</span>)
```

## Parameters

VarTypeThe base type of the array (the VARTYPE of each element of the array). The VARTYPE is restricted to a subset of the variant types. Neither the VT\_ARRAY nor the VT\_BYREF flag can be set. VT\_EMPTY and VT\_NULL are not valid base types for the array. All other types are legal.


See [ComObjType](ComObjType.htm) for a list of possible values.

Count _N_

The size of each dimension. Arrays containing up to 8 dimensions are supported.

## Return Value

This function returns a wrapper object containing a new SafeArray.

## Methods

Array wrapper objects support the following methods:

`Array.MaxIndex(n)`: Returns the upper bound of the _n_ th dimension. If _n_ is omitted, it defaults to 1.

`Array.MinIndex(n)`: Returns the lower bound of the _n_ th dimension. If _n_ is omitted, it defaults to 1.

`Array.Clone()`[v1.0.96.00+]: Returns a copy of the array.

`Array._NewEnum()`[v1.0.96.00+]: Not typically called by script; allows [for-loops](For.htm) to be used with SafeArrays.

## General Remarks

Array wrapper objects may also be returned by COM methods and [ComObjActive()](ComObjActive.htm). Scripts may determine if a value is an array as follows:

```
if ComObjType(<i>obj</i>) & 0x2000
    MsgBox % "Array subtype: " . ComObjType(obj) & 0xfff
else
    MsgBox Not an array.
```

Arrays with up to 8 dimensions are supported.

[v1.0.96.00+]: Since SafeArrays are not designed to support multiple references, when one SafeArray is assigned to an element of another SafeArray, a separate copy is created. However, this only occurs if the wrapper object has the F\_OWNVALUE flag, which indicates it is responsible for destroying the array. This flag can be removed by using [ComObjFlags()](ComObjFlags.htm).

[v1.1.17.00+]: When a function or method called by a COM client returns a SafeArray with the F\_OWNVALUE flag, a copy is created and returned instead, as the original SafeArray is automatically destroyed.

## Related

[ComObjType()](ComObjType.htm), [ComObjValue()](ComObjValue.htm), [ComObjActive()](ComObjActive.htm), [ComObjFlags()](ComObjFlags.htm), [Array Manipulation Functions (MSDN)](http://msdn.microsoft.com/en-us/library/ms221145.aspx)

## Examples

Simple usage.

```
arr := ComObjArray(VT_VARIANT:=12, 3)
arr[0] := "Auto"
arr[1] := "Hot"
arr[2] := "key"
Loop % arr.MaxIndex() + 1
    t .= arr[A_Index-1]
MsgBox % t

```

Multiple dimensions.

```
arr := ComObjArray(VT_VARIANT:=12, 3, 4)

<em>; Get the number of dimensions:</em>
dim := DllCall("oleaut32\SafeArrayGetDim", "ptr", ComObjValue(arr))

<em>; Get the bounds of each dimension:</em>
Loop %dim%
    dims .= arr.MinIndex(A_Index) " .. " arr.MaxIndex(A_Index) "`n"
MsgBox %dims%

<em>; Simple usage:</em>
Loop 3 {
    x := A_Index-1
    Loop 4 {
        y := A_Index-1
        arr[x, y] := x * y
    }
}
MsgBox % arr[2, 3]

```

