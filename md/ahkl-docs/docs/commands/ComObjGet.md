# ComObjGet() [AHK\_L 53+]

Returns a reference to an object provided by a COM component.

```
ComObject := <span class="func">ComObjGet</span>(Name)
```

## Parameters

Name

The display name of the object to be retrieved. See [MkParseDisplayName (MSDN)](http://msdn.microsoft.com/en-us/library/ms691253.aspx) for more information.

## Remarks

On failure, the function may throw an exception, exit the script or return an empty string, depending on the current [ComObjError()](ComObjError.htm) setting and [other factors](ComObjError.htm#factors).

## Related

 [ComObjCreate()](ComObjCreate.htm), [ComObjActive()](ComObjActive.htm), [ComObjConnect()](ComObjConnect.htm), [ComObjError()](ComObjError.htm), [ComObjQuery()](ComObjQuery.htm), [CoGetObject (MSDN)](http://msdn.microsoft.com/en-us/library/ms678805.aspx)

## Examples

Press Shift+Esc to show the command line which was used to launch the active window's process. Requires XP or later.

```
+Esc::
    WinGet pid, PID, A
    <em>; Get WMI service object.</em>
    wmi := ComObjGet("winmgmts:")
    <em>; Run query to retrieve matching process(es).</em>
    queryEnum := wmi.ExecQuery(""
        . "Select * from Win32_Process where ProcessId=" . pid)
        ._NewEnum()
    <em>; Get first matching process.</em>
    if queryEnum[proc]
        MsgBox 0, Command line, % proc.CommandLine
    else
        MsgBox Process not found!
    <em>; Free all global objects (not necessary when using local vars).</em>
    wmi := queryEnum := proc := ""
return
<em>; Win32_Process: <a href="http://msdn.microsoft.com/en-us/library/aa394372.aspx" data-index="11">http://msdn.microsoft.com/en-us/library/aa394372.aspx</a></em>

```

