# ObjAddRef() / ObjRelease() [AHK\_L 53+]

Increments or decrements an object's [reference count](../Objects.htm#Reference_Counting).

```
<span class="func">ObjAddRef</span>(Ptr)
<span class="func">ObjRelease</span>(Ptr)
```

## Parameters

Ptr

An unmanaged object pointer or COM interface pointer.

## Return Value

These functions return the new reference count. This value should be used **only** for debugging purposes.

## Related

[Reference Counting](../Objects.htm#Reference_Counting)

Although the following articles discuss reference counting as it applies to COM, they cover some important concepts and rules which generally also apply to AutoHotkey objects: [IUnknown::AddRef](http://msdn.microsoft.com/en-us/library/ms691379.aspx), [IUnknown::Release](http://msdn.microsoft.com/en-us/library/ms682317.aspx), [Reference Counting Rules](https://msdn.microsoft.com/en-us/library/ms692481.aspx).

## Examples

Retrieves the pointer of an object and increments the reference count. For details, see [Pointers to Objects](../Objects.htm#Implementation_Pointers).

```
obj := Object()

<em>; The following two lines are equivalent:</em>
ptr1 := Object(obj)
ptr2 := ObjectToPointer(obj)

ObjectToPointer(obj) {
    if !IsObject(obj)
        return ""
    ptr := &obj
    ObjAddRef(ptr)
    return ptr
}

<em>; Each pointer retrieved via Object() or ObjectToPointer() must be manually released
; to allow the object to be eventually freed and any memory used by it reclaimed.</em>
ObjRelease(ptr2)
ObjRelease(ptr1)

```

For another example, see [ComObjConnect()](ComObjConnect.htm#ExIE).

