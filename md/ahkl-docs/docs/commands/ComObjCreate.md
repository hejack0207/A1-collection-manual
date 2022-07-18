# ComObjCreate() [AHK\_L 53+]

Creates a COM object.

```
ComObject := <span class="func">ComObjCreate</span>(CLSID <span class="optional">, IID</span>)
```

## Parameters

CLSID

CLSID or human-readable Prog ID of the COM object to create.

IID

[v1.0.96.00+]: The identifier of an interface the object supports.

## Return Value

On failure, the function may throw an exception, exit the script or return an empty string, depending on the current [ComObjError()](ComObjError.htm) setting and [other factors](ComObjError.htm#factors).

If an IID is specified, an interface pointer is returned. The script must typically call [ObjRelease()](ObjAddRef.htm) when it is finished with the pointer.

Otherwise, a wrapper object usable by script is returned. See [object syntax](../Objects.htm#Usage_Objects).

## Related

 [ComObjGet()](ComObjGet.htm), [ComObjActive()](ComObjActive.htm), [ComObjConnect()](ComObjConnect.htm), [ComObjArray()](ComObjArray.htm), [ComObjError()](ComObjError.htm), [ComObjQuery()](ComObjQuery.htm), [CreateObject (MSDN)](http://msdn.microsoft.com/en-us/library/dcw63t7z.aspx)

## Examples

For a constantly growing list of examples, see the following forum topic: [https://www.autohotkey.com/forum/topic61509.html](https://www.autohotkey.com/forum/topic61509.html).

Launches an instance of Internet Explorer, makes it visible and navigates to a website.

```
ie := ComObjCreate("InternetExplorer.Application")
ie.Visible := true  <em>; This is known to work incorrectly on IE7.</em>
ie.Navigate("https://www.autohotkey.com/")

```

