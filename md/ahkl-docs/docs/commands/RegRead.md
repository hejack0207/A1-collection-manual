# RegRead

Reads a value from the registry.

## New Syntax [v1.1.21+]

```
<span class="func">RegRead</span>, OutputVar, KeyName <span class="optional">, ValueName</span>
```

### Parameters

OutputVar

The name of the variable in which to store the retrieved value. If the value cannot be retrieved, the variable is made blank and [ErrorLevel](../misc/ErrorLevel.htm) is set to 1.

KeyName

The full name of the registry key.

This must start with HKEY\_LOCAL\_MACHINE, HKEY\_USERS, HKEY\_CURRENT\_USER, HKEY\_CLASSES\_ROOT, or HKEY\_CURRENT\_CONFIG (or the abbreviations for each of these, such as HKLM). To access a [remote registry](LoopReg.htm#remote), prepend the computer name and a colon (or [in v1.1.21+] a slash), as in this example: `\\workstation01:HKEY_LOCAL_MACHINE`

ValueName

The name of the value to retrieve. If omitted, _KeyName_'s default value will be retrieved, which is the value displayed as "(Default)" by RegEdit. If there is no default value (that is, if RegEdit displays "value not set"), _OutputVar_ is made blank and ErrorLevel is set to 1.

## Old Syntax

**Deprecated:** This syntax is not recommended for use in new scripts. Use the [new syntax](#new) instead.

```
<span class="func">RegRead</span>, OutputVar, RootKey, SubKey <span class="optional">, ValueName</span>
```

### Parameters

OutputVar

The name of the variable in which to store the retrieved value. If the value cannot be retrieved, the variable is made blank and [ErrorLevel](../misc/ErrorLevel.htm) is set to 1.

RootKey

Must be either HKEY\_LOCAL\_MACHINE, HKEY\_USERS, HKEY\_CURRENT\_USER, HKEY\_CLASSES\_ROOT, or HKEY\_CURRENT\_CONFIG (or the abbreviations for each of these, such as HKLM). To access a [remote registry](LoopReg.htm#remote), prepend the computer name and a colon (or [in v1.1.21+] a slash), as in this example: `\\workstation01:HKEY_LOCAL_MACHINE`

SubKey

The name of the subkey (e.g. Software\\SomeApplication).

ValueName

The name of the value to retrieve. If omitted, _SubKey_'s default value will be retrieved, which is the value displayed as "(Default)" by RegEdit. If there is no default value (that is, if RegEdit displays "value not set"), _OutputVar_ is made blank and ErrorLevel is set to 1.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem (such as a nonexistent key or value) or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

Currently only the following value types are supported: REG\_SZ, REG\_EXPAND\_SZ, REG\_MULTI\_SZ, REG\_DWORD, and REG\_BINARY.

REG\_DWORD values are always expressed as positive decimal numbers. If the number was intended to be negative, convert it to a signed 32-bit integer by using `OutputVar := OutputVar << 32 >> 32` or similar.

When reading a REG\_BINARY key the result is a string of hex characters. For example, the REG\_BINARY value of 01,a9,ff,77 will be read as the string 01A9FF77.

When reading a REG\_MULTI\_SZ key, each of the components ends in a linefeed character (\`n). If there are no components, _OutputVar_ will be made blank. See [FileSelectFile](FileSelectFile.htm) for an example of how to extract the individual components from _OutputVar_.

[v1.1.10.01+]: REG\_BINARY values larger than 64K can also be read.

To retrieve and operate upon multiple registry keys or values, consider using a [registry-loop](LoopReg.htm).

For details about how to access the registry of a remote computer, see the remarks in [registry-loop](LoopReg.htm).

To read and write entries from the 64-bit sections of the registry in a 32-bit script or vice versa, use [SetRegView](SetRegView.htm).

## Related

[RegDelete](RegDelete.htm), [RegWrite](RegWrite.htm), [Registry-loop](LoopReg.htm), [SetRegView](SetRegView.htm), [IniRead](IniRead.htm)

## Examples

New syntax vs. old syntax.

Despite the different syntax, both examples have the same effect; that is, they read a value from the registry and store it in OutputVar.

```
RegRead, OutputVar, HKEY_LOCAL_MACHINE\Software\SomeApplication, TestValue
```

```
RegRead, OutputVar, HKEY_LOCAL_MACHINE, Software\SomeApplication, TestValue
```

Retrieves and reports the path of the "Program Files" directory. See [EnvGet example #2](EnvGet.htm#ExProgramFiles) for an alternative method.

```
<em>; The line below ensures that the path of the 64-bit Program Files
; directory is returned if the OS is 64-bit and the script is not.</em>
<a href="SetRegView.htm" data-index="21">SetRegView</a> 64  <em>; Requires <span class="ver">[v1.1.08+]</span></em>

RegRead, OutputVar, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion, ProgramFilesDir
MsgBox, Program files are in: %OutputVar%
```

Retrieves the TYPE of a registry value (e.g. REG\_SZ or REG\_DWORD).

```
MsgBox % RegKeyType("HKCU", "Environment", "TEMP")
return

RegKeyType(RootKey, SubKey, ValueName)  <em>; This function returns the type of the specified value.</em>
{
    Loop, %RootKey%, %SubKey%
        if (A_LoopRegName = ValueName)
            return A_LoopRegType
    return "Error"
}
```

