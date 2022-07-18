# ComObjError() [AHK\_L 53+]

Enables or disables notification of COM errors.

```
Enabled := <span class="func">ComObjError</span>(<span class="optional">Enable</span>)
```

## Parameters

Enable

A boolean value (true or false). Optional.

## Return Value [v1.0.91+]

This function returns the setting which was in effect before the function was called.

## General Remarks

Notification of COM errors is enabled by default.

COM errors may be raised by [ComObjCreate()](ComObjCreate.htm), [ComObjGet()](ComObjGet.htm), [ComObjActive()](ComObjActive.htm), [ComObjConnect()](ComObjConnect.htm), [ComObjQuery()](ComObjQuery.htm) (if an invalid pointer is detected) or by a method or property of a COM object. Raising a COM error causes one of the following outcomes:

SettingOutcome0 (disabled)The function, method or property returns a default value (typically an empty string), without showing an error dialog.1 (enabled)

If there is an active [Try](Try.htm) block, an exception is thrown. Otherwise:

An error dialog is shown, giving the user the option to continue the script. If the user chooses "Yes", the function, method or property returns a default value (typically an empty string) and the script continues. Otherwise, the script exits.

After accessing a COM object, [A\_LastError](../Variables.htm#LastError) contains the HRESULT code returned by the COM object's [IDispatch::Invoke](http://msdn.microsoft.com/en-us/library/ms221479.aspx) function. The script may consult A\_LastError within a [Catch](Catch.htm) block or after the method or property returns, provided that `ComObjError(false)` has been used or the user did not choose to exit the script.

## Related

[ComObjCreate()](ComObjCreate.htm), [ComObjGet()](ComObjGet.htm), [ComObjActive()](ComObjActive.htm), [ComObjConnect()](ComObjConnect.htm), [ComObjQuery()](ComObjQuery.htm)

