# ComObjFlags() [v1.0.96.00+]

Retrieves or changes flags which control a COM wrapper object's behaviour.

```
Flags := <span class="func">ComObjFlags</span>(ComObject <span class="optional">, NewFlags, Mask</span>)
```

## Parameters

ComObject

A COM wrapper object.

NewFlags

New values for the flags identified by _Mask_, or flags to add or remove.

Mask

A bitmask of flags to change.

## Return Value

This function returns the current flags of the specified COM object (after applying NewFlags, if specified).

## Flags

FlagEffect1F\_OWNVALUE. Currently only affects SafeArrays. If this flag is set, the SafeArray is destroyed when the wrapper object is freed. Since SafeArrays have no reference counting mechanism, if a SafeArray with this flag is assigned to an element of another SafeArray, a separate copy is created.

## General Remarks

If _Mask_ is omitted, _NewFlags_ specifies the flags to add (if positive) or remove (if negative). For example, `ComObjFlags(obj, -1)` removes the F\_OWNVALUE flag. Do not specify any value for _Mask_ other than 0 or 1; all other bits are reserved for future use.

## Related

[ComObjActive()](ComObjActive.htm), [ComObjArray()](ComObjArray.htm)

## Examples

Checks for the presence of the F\_OWNVALUE flag.

```
arr := ComObjArray(0xC, 1)
if ComObjFlags(arr) & 1
    MsgBox arr will be automatically destroyed.
else
    MsgBox arr will not be automatically destroyed.

```

Changes array-in-array behaviour.

```
arr1 := ComObjArray(0xC, 3)
arr2 := ComObjArray(0xC, 1)
arr2[0] := "original value"
arr1[0] := arr2         <em>; Assign implicit copy.</em>
ComObjFlags(arr2, -1)   <em>; Remove F_OWNVALUE.</em>
arr1[1] := arr2         <em>; Assign original array.</em>
arr1[2] := arr2.Clone() <em>; Assign explicit copy.</em>
arr2[0] := "new value"
for arr in arr1
    MsgBox % arr[0]

arr1 := ""
<em>; Not valid since arr2 == arr1[1], which has been destroyed:
;  arr2[0] := "foo"</em>

```

