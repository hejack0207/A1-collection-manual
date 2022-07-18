# RegDelete

Deletes a subkey or value from the registry.

## New Syntax [v1.1.21+]

```
<span class="func">RegDelete</span>, KeyName <span class="optional">, ValueName</span>
```

### Parameters

KeyName

The full name of the registry key.

This must start with HKEY\_LOCAL\_MACHINE, HKEY\_USERS, HKEY\_CURRENT\_USER, HKEY\_CLASSES\_ROOT, or HKEY\_CURRENT\_CONFIG (or the abbreviations for each of these, such as HKLM). To access a [remote registry](LoopReg.htm#remote), prepend the computer name and a colon (or [in v1.1.21+] a slash), as in this example: `\\workstation01:HKEY_LOCAL_MACHINE`

ValueName

The name of the value to delete. **If omitted, the entire _KeyName_ will be deleted**. To delete _KeyName_'s default value -- which is the value displayed as "(Default)" by RegEdit -- use the phrase `AHK_DEFAULT` for this parameter.

## Old Syntax

**Deprecated:** This syntax is not recommended for use in new scripts. Use the [new syntax](#new) instead.

```
<span class="func">RegDelete</span>, RootKey, SubKey <span class="optional">, ValueName</span>
```

### Parameters

RootKey

Must be either HKEY\_LOCAL\_MACHINE, HKEY\_USERS, HKEY\_CURRENT\_USER, HKEY\_CLASSES\_ROOT, or HKEY\_CURRENT\_CONFIG (or the abbreviations for each of these, such as HKLM). To access a [remote registry](LoopReg.htm#remote), prepend the computer name and a colon (or [in v1.1.21+] a slash), as in this example: `\\workstation01:HKEY_LOCAL_MACHINE`

SubKey

The name of the subkey (e.g. Software\\SomeApplication).

ValueName

The name of the value to delete. **If omitted, the entire _SubKey_ will be deleted**. To delete _SubKey_'s default value -- which is the value displayed as "(Default)" by RegEdit -- use the phrase `AHK_DEFAULT` for this parameter.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

**Warning**: Deleting from the registry is potentially dangerous - please exercise caution!

To retrieve and operate upon multiple registry keys or values, consider using a [registry-loop](LoopReg.htm).

For details about how to access the registry of a remote computer, see the remarks in [registry-loop](LoopReg.htm).

To delete entries from the 64-bit sections of the registry in a 32-bit script or vice versa, use [SetRegView](SetRegView.htm).

## Related

[RegRead](RegRead.htm), [RegWrite](RegWrite.htm), [Registry-loop](LoopReg.htm), [SetRegView](SetRegView.htm), [IniDelete](IniDelete.htm)

## Examples

New syntax vs. old syntax.

Despite the different syntax, both examples have the same effect; that is, they delete a value from the registry.

```
RegDelete, HKEY_LOCAL_MACHINE\Software\SomeApplication, TestValue
```

```
RegDelete, HKEY_LOCAL_MACHINE, Software\SomeApplication, TestValue
```

