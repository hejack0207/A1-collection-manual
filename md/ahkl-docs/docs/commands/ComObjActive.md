# ComObjActive() [AHK\_L 53+]

Retrieves a running object that has been registered with OLE.

```
ComObject := <span class="func">ComObjActive</span>(CLSID)
```

Creates an object representing a typed value to be passed as a parameter or return value.

```
ParamObj := <span class="func">ComObject</span>(VarType, Value <span class="optional">, Flags</span>)
```

* * *

**Deprecated:** The usages shown below are deprecated and may be altered or unavailable in a future release.

Creates an object which may be used in place of an optional parameter's default value when calling a method of a COM object. [v1.1.12+]: This function is obsolete. Instead, simply write two consecutive commas, as in `Obj.Method(1,,3)`

```
ParamObj := <span class="func">ComObjMissing</span>()
```

Wraps or unwraps a raw [IDispatch](http://msdn.microsoft.com/en-us/library/dd318520.aspx) pointer in a usable object and automatically calls AddRef.

```
ComObject := <span class="func">ComObjEnwrap</span>(DispPtr)
DispPtr := <span class="func">ComObjUnwrap</span>(ComObject)

```

To write more future-proof code, use the following instead:

```
ComObject := ComObject(9, DispPtr, 1), ObjAddRef(DispPtr)
DispPtr := <a href="ComObjValue.htm" data-index="2">ComObjValue</a>(ComObject), ObjAddRef(DispPtr)
```

* * *

## Parameters

CLSID

CLSID or human-readable Prog ID of the COM object to retrieve.

ComObject

COM object usable with [object syntax](../Objects.htm#Usage_Objects).

VarType

An integer indicating the type of value. See [ComObjType()](ComObjType.htm#vt) for a list of types.

Value

The value to wrap. Currently only integer and pointer values are supported.

Flags

Flags affecting the behaviour of this function and the wrapper object; see below.

DispPtr

Raw IDispatch pointer.

## Flags

FlagEffect0

Default behaviour. [AddRef](http://msdn.microsoft.com/en-us/library/ms691379.aspx) is called automatically for IUnknown and IDispatch pointers, so the caller should use [ObjRelease()](ObjAddRef.htm) to release their copy of the pointer if appropriate.

As the default behaviour may be changing in a future release, it is recommended to always set _Flags_ to `1` when wrapping an interface pointer, and call [ObjAddRef()](ObjAddRef.htm) if needed.

1Take ownership of an IUnknown, IDispatch or SAFEARRAY pointer. AddRef is not called. If the wrapper object contains a SAFEARRAY (excluding VT\_BYREF), [SafeArrayDestroy](https://msdn.microsoft.com/en-us/library/ms221702(v=vs.85).aspx) is called automatically when the wrapper object is freed.

## ByRef [v1.1.17+]

If a wrapper object's [_VarType_](ComObjType.htm) includes the VT\_BYREF (0x4000) flag, empty brackets `[]` can be used to read or write the referenced value.

When creating a reference, _Value_ must be the memory address of a variable or buffer with sufficient capacity to store a value of the given type. For example, the following can be used to create a variable which a VBScript function can write into:

```
VarSetCapacity(var, 24, 0)
vref := ComObject(0x400C, &var)  <em>; 0x400C is a combination of VT_BYREF and VT_VARIANT.</em>

vref[] := "in value"
sc.Run("Example", vref)  <em>; sc should be initialized as in the <a href="#ByRefEx" data-index="10">example below</a>.</em>
MsgBox % vref[]
```

Note that although any previous value is freed when a new value is assigned by `vref[]` or the COM method, the final value is not freed automatically. Freeing the value requires knowing which type it is. Because it is VT\_VARIANT in this case, it can be freed by calling [VariantClear](https://docs.microsoft.com/en-us/windows/win32/api/oleauto/nf-oleauto-variantclear) with [DllCall](DllCall.htm) or by using a simpler method: assign an integer, such as `vref[] := 0`.

## General Remarks

In current versions, any function-call beginning with "ComObj" that does not match one of the other COM functions actually calls ComObjActive. For example, `ComObjEnwrap(DispPtr)` and `ComObjActive(DispPtr)` are both equivalent to `ComObject(DispPtr)` ( _VarType_ 9 is implied). However, this behaviour will be unavailable in a future release, so it is best to use only `ComObject()` and `ComObjActive()` as shown on this page.

If ComObjActive cannot retrieve an active object, it may throw an exception, exit the script or return an empty string, depending on the current [ComObjError()](ComObjError.htm) setting and [other factors](ComObjError.htm#factors).

When this function is used to wrap or retrieve an IDispatch or IUnknown interface pointer, the default behaviour is to increment the COM object's reference count. Therefore, the interface pointer must be [manually released](ObjAddRef.htm) when it is no longer needed. When the wrapper object is freed, the reference it contains is automatically released.

**Known limitation:** Each time a COM object is wrapped, a new wrapper object is created. Comparisons and assignments such as `if (obj1 == obj2)` and `array[obj1] := value` treat the two wrapper objects as unique, even though they contain the same COM object.

## Related

[ComObjCreate()](ComObjCreate.htm), [ComObjGet()](ComObjGet.htm), [ComObjConnect()](ComObjConnect.htm), [ComObjError()](ComObjError.htm), [ComObjFlags()](ComObjFlags.htm), [ObjAddRef() / ObjRelease()](ObjAddRef.htm), [ComObjQuery()](ComObjQuery.htm), [GetActiveObject (MSDN)](http://msdn.microsoft.com/en-us/library/ms221467.aspx)

## Examples

ComObjUnwrap: See [ComObjConnect()](ComObjConnect.htm#Examples).

Passes a VARIANT ByRef to a COM function.

```
<em>; Preamble - ScriptControl requires a 32-bit version of AutoHotkey.</em>
code =
(
Sub Example(Var)
    MsgBox Var
    Var = "out value!"
End Sub
)
sc := <a href="ComObjCreate.htm" data-index="26">ComObjCreate</a>("ScriptControl"), sc.Language := "VBScript", sc.AddCode(code)

<em>; Example: Pass a VARIANT ByRef to a COM function.</em>
var := ComVar()
var[] := "in value"  <em>; Use [] to assign a value.</em>
sc.Run("Example", var.ref)  <em>; Pass the VT_BYREF ComObject (.ref).</em>
MsgBox % var[]  <em>; Use [] to retrieve a value.</em>

<em>; The same thing again, but more direct:</em>
VarSetCapacity(variant_buf, 24, 0)  <em>; Make a buffer big enough for a VARIANT.</em>
var := ComObject(0x400C, &variant_buf)  <em>; Make a reference to a VARIANT.</em>
var[] := "in value"
sc.Run("Example", var)  <em>; Pass the VT_BYREF ComObject itself, no [] or .ref.</em>
MsgBox % var[]
<em>; If a VARIANT contains a string or object, it must be explicitly freed
; by calling VariantClear or assigning a pure numeric value:</em>
var[] := 0

<em>; ComVar: Creates an object which can be used to pass a value ByRef.
;   ComVar[] retrieves the value.
;   ComVar[] := Val sets the value.
;   ComVar.ref retrieves a ByRef object for passing to a COM function.</em>
ComVar(Type := 0xC)
{
    static base := { __Get: Func("ComVarGet"), __Set: Func("ComVarSet")
        , __Delete: Func("ComVarDel") } <em>; For base, see Custom Objects.

    ; Create a new object based on base.</em>
    cv := {base: base}

    <em>; Allocate memory for a VARIANT to hold our value. VARIANT is used even
    ; when Type != VT_VARIANT so that VariantClear can be used by __delete.</em>
    cv.SetCapacity("buf", 24), ptr := cv.GetAddress("buf")
    NumPut(0, NumPut(0, ptr+0, "int64"), "int64")

    if (Type != 0xC) { <em>; Not VT_VARIANT.</em>
        NumPut(Type, ptr+0, "ushort") <em>; Set the variant type for __delete.</em>
        ptr += 8 <em>; Point to the actual value.</em>
    }

    <em>; Create an object which can be used to pass the variable ByRef.</em>
    cv.ref := ComObject(0x4000|Type, ptr)

    return cv
}

ComVarGet(cv, p*) { <em>; Called when script accesses an unknown field.</em>
    if p.MaxIndex() = "" <em>; No name/parameters, i.e. cv[]</em>
        return cv.ref[]
}

ComVarSet(cv, v, p*) { <em>; Called when script sets an unknown field.</em>
    if p.MaxIndex() = "" <em>; No name/parameters, i.e. cv[]:=v</em>
        return cv.ref[] := v
}

ComVarDel(cv) { <em>; Called when the object is being freed.
    ; Depending on type, this may be needed to free the value, if set.</em>
    DllCall("oleaut32\VariantClear", "ptr", cv.GetAddress("buf"))
}

```

