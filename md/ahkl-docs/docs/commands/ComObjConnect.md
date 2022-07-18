# ComObjConnect() [AHK\_L 53+]

Connects a COM object's event sources to functions with a given prefix.

```
<span class="func">ComObjConnect</span>(ComObject <span class="optional">, PrefixOrSink</span>)
```

## Parameters

ComObject

An object which raises events.

If the object does not support the IConnectionPointContainer interface or type information about the object's class cannot be retrieved, an error message is shown. This can be suppressed or handled with [ComObjError()](ComObjError.htm) or [try](Try.htm)/ [catch](Catch.htm).

[v1.1.22+]: The IProvideClassInfo interface is used to retrieve type information about the object's class if the object supports it. Otherwise, ComObjConnect attempts to retrieve type information via the object's IDispatch interface, which may be unreliable.

PrefixOrSink

A string to prefix to the event name to determine which function to call when an event occurs, or [in v1.1.01+] an [event sink object](#event-sink) defining a method for each event to be handled.

If omitted, the object is "disconnected"; that is, the script will no longer receive notification of its events.

## Usage

To make effective use of ComObjConnect, you must first write functions in the script to handle any events of interest. Such functions, or "event-handlers," have the following structure:

```
<i>Prefix</i><b>EventName</b>([<i>Params...</i>, ComObject])
{
    <i class="dull">... event-handling code ...</i>
    return <i>ReturnValue</i>
}
```

_Prefix_ should be the same as the _PrefixOrSink_ parameter if it is a string; otherwise, it should be omitted. **EventName** should be replaced with the name of whatever event the function should handle.

_Params_ corresponds to whatever parameters the event has. If the event has no parameters, _Params_ should be omitted entirely. _ComObject_ is optional, and can only be used if the correct number of _Params_ are defined; it contains a reference to the original wrapper object which was passed to ComObjConnect. "ComObject" should be replaced with a name more meaningful in the context of your script.

Note that event handlers may have return values. To return a COM-specific type of value, use [ComObject(type, value)](ComObjActive.htm#param). For example, `return ComObject(0,0)` returns a variant of type VT\_EMPTY, which is equivalent to returning `undefined` (or not returning) from a JavaScript function.

Call `ComObjConnect(yourObject, "<i>Prefix</i>")` to enable event-handling.

Call `ComObjConnect(yourObject)` to disconnect the object (stop handling events).

If the number of parameters is not known, a [variadic function](../Functions.htm#Variadic) can be used.

### Event Sink [v1.1.01+]

If _PrefixOrSink_ is an object, whenever an event is raised, the corresponding method of that object is called. Although the object can be constructed dynamically, it is more typical for _PrefixOrSink_ to refer to a class or an instance of a class. In that case, methods are defined as shown above, but without _Prefix_.

As with any call to a method, the method's (normally hidden) `this` parameter contains a reference to the object through which the method was called; i.e. the event sink object, not the COM object. This can be used to provide context to the event handlers, or share values between them.

To catch all events without defining a method for each one, define a [\_\_Call meta-function](../Objects.htm#Meta_Functions).

## Remarks

The script must retain a reference to _ComObject_, otherwise it would be freed automatically and would disconnect from its COM object, preventing any further events from being detected. There is no standard way to detect when the connection is no longer required, so the script must disconnect manually by calling ComObjConnect.

The [#Persistent](_Persistent.htm) directive may be needed to keep the script running while it is listening for events.

On failure, the function may throw an exception, exit the script or simply return, depending on the current [ComObjError()](ComObjError.htm) setting and [other factors](ComObjError.htm#factors).

## Related

[ComObjCreate()](ComObjCreate.htm), [ComObjGet()](ComObjGet.htm), [ComObjActive()](ComObjActive.htm), [ComObjError()](ComObjError.htm), [WScript.ConnectObject (MSDN)](http://msdn.microsoft.com/en-us/library/ccxe1xe6.aspx)

## Examples

Launches an instance of Internet Explorer and connects events to corresponding script functions with the prefix "IE\_". For details about the COM object and DocumentComplete event used below, see [InternetExplorer object (Microsoft Docs)](http://msdn.microsoft.com/en-us/library/aa752084.aspx).

```
ie := ComObjCreate("InternetExplorer.Application")

<em>; Connects events to corresponding script functions with the prefix "IE_".</em>
ComObjConnect(ie, "IE_")

ie.Visible := true  <em>; This is known to work incorrectly on IE7.</em>
ie.Navigate("https://www.autohotkey.com/")
#Persistent

IE_DocumentComplete(ieEventParam, url, ieFinalParam) {
    global ie
    if (ie != ieEventParam)
        s .= "First parameter is a new wrapper object.`n"
    if (ie == ieFinalParam)
        s .= "Final parameter is the original wrapper object.`n"
    if ((disp1:=<a href="ComObjActive.htm#enwrap" data-index="18">ComObjUnwrap</a>(ieEventParam)) == (disp2:=ComObjUnwrap(ieFinalParam)))
        s .= "Both wrapper objects refer to the same IDispatch instance.`n"
    <a href="ObjAddRef.htm" data-index="19">ObjRelease</a>(disp1), ObjRelease(disp2)
    MsgBox % s . "Finished loading " ie.Document.title " @ " url
    ie.Quit()
    ExitApp
}

```

