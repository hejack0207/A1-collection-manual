# RegWrite

Writes a value to the registry.

## New Syntax [v1.1.21+]

```
<span class="func">RegWrite</span>, ValueType, KeyName <span class="optional">, ValueName, Value</span>
```

### Parameters

ValueType

Must be either REG\_SZ, REG\_EXPAND\_SZ, REG\_MULTI\_SZ, REG\_DWORD, or REG\_BINARY.

KeyName

The full name of the registry key.

This must start with HKEY\_LOCAL\_MACHINE, HKEY\_USERS, HKEY\_CURRENT\_USER, HKEY\_CLASSES\_ROOT, or HKEY\_CURRENT\_CONFIG (or the abbreviations for each of these, such as HKLM). To access a [remote registry](LoopReg.htm#remote), prepend the computer name and a colon (or [in v1.1.21+] a slash), as in this example: `\\workstation01:HKEY_LOCAL_MACHINE`

ValueName

The name of the value that will be written to. If blank or omitted, _KeyName_'s default value will be used, which is the value displayed as "(Default)" by RegEdit.

Value

The value to be written. If omitted, it will default to an empty (blank) string, or 0, depending on _ValueType_. If the text is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

## Old Syntax

**Deprecated:** This syntax is not recommended for use in new scripts. Use the [new syntax](#new) instead.

```
<span class="func">RegWrite</span>, ValueType, RootKey, SubKey <span class="optional">, ValueName, Value</span>
```

### Parameters

ValueType

Must be either REG\_SZ, REG\_EXPAND\_SZ, REG\_MULTI\_SZ, REG\_DWORD, or REG\_BINARY.

RootKey

Must be either HKEY\_LOCAL\_MACHINE, HKEY\_USERS, HKEY\_CURRENT\_USER, HKEY\_CLASSES\_ROOT, or HKEY\_CURRENT\_CONFIG (or the abbreviations for each of these, such as HKLM). To access a [remote registry](LoopReg.htm#remote), prepend the computer name and a colon (or [in v1.1.21+] a slash), as in this example: `\\workstation01:HKEY_LOCAL_MACHINE`

SubKey

The name of the subkey (e.g. Software\\SomeApplication). If _SubKey_ does not exist, it is created (along with its ancestors, if necessary). If _SubKey_ is left blank, the value is written directly into _RootKey_ (though some operating systems might refuse to write in HKEY\_CURRENT\_USER's top level).

ValueName

The name of the value that will be written to. If blank or omitted, _SubKey_'s default value will be used, which is the value displayed as "(Default)" by RegEdit.

Value

The value to be written. If omitted, it will default to an empty (blank) string, or 0, depending on _ValueType_. If the text is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

If _ValueType_ is REG\_DWORD, _Value_ should be between -2147483648 and 4294967295 (0xFFFFFFFF). In the registry, REG\_DWORD values are always expressed as positive decimal numbers. To read it as a negative number with means such as [RegRead](RegRead.htm), convert it to a signed 32-bit integer by using `OutputVar := OutputVar << 32 >> 32` or similar.

When writing a REG\_BINARY key, use a string of hex characters, e.g. the REG\_BINARY value of 01,a9,ff,77 can be written by using the string 01A9FF77.

When writing a REG\_MULTI\_SZ key, you must separate each component from the next with a linefeed character (\`n). The last component may optionally end with a linefeed as well. No blank components are allowed. In other words, do not specify two linefeeds in a row (\`n\`n) because that will result in a shorter-than-expected value being written to the registry.

[v1.1.10.01+]: REG\_BINARY and REG\_MULTI\_SZ values larger than 64K are also supported. In older versions, they are truncated to 64K.

To retrieve and operate upon multiple registry keys or values, consider using a [registry-loop](LoopReg.htm).

For details about how to access the registry of a remote computer, see the remarks in [registry-loop](LoopReg.htm).

To read and write entries from the 64-bit sections of the registry in a 32-bit script or vice versa, use [SetRegView](SetRegView.htm).

## Related

[RegDelete](RegDelete.htm), [RegRead](RegRead.htm), [Registry-loop](LoopReg.htm), [SetRegView](SetRegView.htm), [IniWrite](IniWrite.htm)

## Examples

New syntax vs. old syntax.

Despite the different syntax, both examples have the same effect; that is, they write a string to the registry.

```
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE\SOFTWARE\TestKey, MyValueName, Test Value
```

```
RegWrite, REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\TestKey, MyValueName, Test Value
```

Writes binary data to the registry.

```
RegWrite, REG_BINARY, HKEY_CURRENT_USER\Software\TEST_APP, TEST_NAME, 01A9FF77
```

Writes a multi-line string to the registry.

```
RegWrite, REG_MULTI_SZ, HKEY_CURRENT_USER\Software\TEST_APP, TEST_NAME, Line1`nLine2
```

