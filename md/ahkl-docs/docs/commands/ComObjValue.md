# ComObjValue() [v1.0.91+]

Retrieves the value or pointer stored in a COM wrapper object.

```
Value := <span class="func">ComObjValue</span>(ComObject)
```

## Parameters

ComObject

A wrapper object containing a COM object or typed value.

## Return Value

This function returns a 64-bit signed integer.

## General Remarks

This function is not intended for general use.

Calling ComObjValue is equivalent to `<i>variant</i>.llVal`, where _ComObject_ is treated as a [VARIANT structure](http://msdn.microsoft.com/en-us/library/ms221627.aspx). Any script which uses this function must be aware what [type of value](ComObjType.htm) the wrapper object contains and how it should be treated. For instance, if an interface pointer is returned, [Release](ObjAddRef.htm) should not be called, but [AddRef](ObjAddRef.htm) may be required depending on what the script does with the pointer.

## Related

[ComObjType()](ComObjType.htm), [ComObjCreate()](ComObjCreate.htm), [ComObjGet()](ComObjGet.htm), [ComObjActive()](ComObjActive.htm)

