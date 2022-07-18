# ComObjType() [AHK\_L 53+]

Retrieves type information from a COM object.

```
VarType := <span class="func">ComObjType</span>(ComObject)           <em>; Requires <span class="ver">[v1.0.91+]</span></em>
IName   := <span class="func">ComObjType</span>(ComObject, "Name")
IID     := <span class="func">ComObjType</span>(ComObject, "IID")
CName   := <span class="func">ComObjType</span>(ComObject, "Class")  <em>; Requires <span class="ver">[v1.1.26+]</span></em>
CLSID   := <span class="func">ComObjType</span>(ComObject, "CLSID")  <em>; Requires <span class="ver">[v1.1.26+]</span></em>
```

## Parameters

ComObject

A wrapper object containing a COM object or typed value.

Param2

The second parameter is a string indicating the type information to retrieve.

## Return Value

The return value depends on the value of _Param2_:

Param2Return ValueOmitted[v1.0.91+]: An integer [variant type code](#vt) indicating the type of value contained by the COM wrapper object.`"Name"`The name of the object's default interface.`"IID"`The globally unique identifier (GUID) of the object's default interface.`"Class"`[v1.1.26+]: The object's class name. Note that this is not the same as a Prog ID (a Prog ID is a name used to identify the class in the system registry, or for ComObjCreate).`"CLSID"`[v1.1.26+]: The globally unique identifier (GUID) of the object's class. Classes are often registered by CLSID under the `HKCR\CLSID` registry key.

An empty string is returned if either parameter is invalid or if the requested type information could not be retrieved.

## Variant Type Constants

```
VT_EMPTY     :=      0  <em>; No value</em>
VT_NULL      :=      1  <em>; SQL-style Null</em>
VT_I2        :=      2  <em>; 16-bit signed int</em>
VT_I4        :=      3  <em>; 32-bit signed int</em>
VT_R4        :=      4  <em>; 32-bit floating-point number</em>
VT_R8        :=      5  <em>; 64-bit floating-point number</em>
VT_CY        :=      6  <em>; Currency</em>
VT_DATE      :=      7  <em>; Date</em>
VT_BSTR      :=      8  <em>; COM string (Unicode string with length prefix)</em>
VT_DISPATCH  :=      9  <em>; COM object</em>
VT_ERROR     :=    0xA  <em>; Error code (32-bit integer)</em>
VT_BOOL      :=    0xB  <em>; Boolean True (-1) or False (0)</em>
VT_VARIANT   :=    0xC  <em>; <a href="http://msdn.microsoft.com/en-us/library/ms221627.aspx" data-index="2">VARIANT</a> (must be combined with VT_ARRAY or VT_BYREF)</em>
VT_UNKNOWN   :=    0xD  <em>; IUnknown interface pointer</em>
VT_DECIMAL   :=    0xE  <em>; (not supported)</em>
VT_I1        :=   0x10  <em>; 8-bit signed int</em>
VT_UI1       :=   0x11  <em>; 8-bit unsigned int</em>
VT_UI2       :=   0x12  <em>; 16-bit unsigned int</em>
VT_UI4       :=   0x13  <em>; 32-bit unsigned int</em>
VT_I8        :=   0x14  <em>; 64-bit signed int</em>
VT_UI8       :=   0x15  <em>; 64-bit unsigned int</em>
VT_INT       :=   0x16  <em>; Signed machine int</em>
VT_UINT      :=   0x17  <em>; Unsigned machine int</em>
VT_RECORD    :=   0x24  <em>; User-defined type -- NOT SUPPORTED</em>
VT_ARRAY     := 0x2000  <em>; <a href="http://msdn.microsoft.com/en-us/library/ms221482.aspx" data-index="3">SAFEARRAY</a></em>
VT_BYREF     := 0x4000  <em>; Pointer to another type of value</em>
<em>/*
 VT_ARRAY and VT_BYREF are combined with another value (using bitwise OR)
 to specify the exact type. For instance, 0x2003 identifies a <a href="http://msdn.microsoft.com/en-us/library/ms221482.aspx" data-index="4">SAFEARRAY</a>
 of 32-bit signed integers and 0x400C identifies a pointer to a <a href="http://msdn.microsoft.com/en-us/library/ms221627.aspx" data-index="5">VARIANT</a>.
*/</em>

```

## General Remarks

In most common cases, return values from methods or properties of COM objects are converted to an appropriate data type supported by AutoHotkey. Types which aren't specifically handled are coerced to strings via [VariantChangeType](http://msdn.microsoft.com/en-us/library/ms221258.aspx); if this fails or if the variant type contains the VT\_ARRAY or VT\_BYREF flag, an object containing both the value and its type is returned instead.

For any variable _x_, if `ComObjType(x)` returns an integer, _x_ contains a COM object wrapper.

If _Param2_ is `"Name"` or `"IID"`, type information is retrieved via the [IDispatch::GetTypeInfo](https://msdn.microsoft.com/en-us/library/ms221571.aspx) interface method. _ComObject_'s variant type must be VT\_DISPATCH.

If _Param2_ is `"Class"` or `"CLSID"`, type information is retrieved via the [IProvideClassInfo::GetClassInfo](https://msdn.microsoft.com/en-us/library/ms690192.aspx) interface method. _ComObject_'s variant type must be VT\_DISPATCH or VT\_UNKNOWN, and the object must implement the IProvideClassInfo interface (some objects do not).

## Related

[ComObjValue()](ComObjValue.htm), [ComObjCreate()](ComObjCreate.htm), [ComObjGet()](ComObjGet.htm), [ComObjActive()](ComObjActive.htm)

## Examples

Reports various type information of a COM object.

```
d := <a href="ComObjCreate.htm" data-index="14">ComObjCreate</a>("Scripting.Dictionary")
VarType := ComObjType(d)
IName   := ComObjType(d, "Name")
IID     := ComObjType(d, "IID")
CName   := ComObjType(d, "Class")  <em>; Requires <span class="ver">[v1.1.26+]</span></em>
CLSID   := ComObjType(d, "CLSID")  <em>; Requires <span class="ver">[v1.1.26+]</span></em>
MsgBox % "Variant type:`t" VarType
	. "`nInterface name:`t" IName "`nInterface ID:`t" IID
	. "`nClass name:`t" CName "`nClass ID (CLSID):`t" CLSID

```

