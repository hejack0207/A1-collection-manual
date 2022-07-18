# Loop (registry)

Retrieves the contents of the specified registry subkey, one item at a time.

## New Syntax [v1.1.21+]

```
<span class="func">Loop, Reg</span>, KeyName <span class="optional">, Mode</span>
```

### Parameters

Reg

The literal word `Reg` (case-insensitive). This cannot be a variable or expression.

KeyName

The full name of the registry key such as `HKLM\Software` or `%FullPathOfKey%`.

This must start with HKEY\_LOCAL\_MACHINE, HKEY\_USERS, HKEY\_CURRENT\_USER, HKEY\_CLASSES\_ROOT, or HKEY\_CURRENT\_CONFIG (or the abbreviations for each of these, such as HKLM). To access a [remote registry](#remote), prepend the computer name and a colon, as in this example: \\\workstation01:HKEY\_LOCAL\_MACHINE

Mode

If blank or omitted, only values are included and subkeys are not recursed into. Otherwise, specify one or more of the following letters:

- K = Include keys.
- V = Include values. Values are also included if both K and V are omitted.
- R = Recurse into subkeys. If R is omitted, keys and values within subkeys of_KeyName_ are not included.

## Old Syntax

**Deprecated:** This syntax is not recommended for use in new scripts. Use the [new syntax](#new) instead.

```
<span class="func">Loop</span>, RootKey <span class="optional">, Key, IncludeSubkeys?, Recurse?</span>
```

### Parameters

RootKey

Must be either HKEY\_LOCAL\_MACHINE (or HKLM), HKEY\_USERS (or HKU), HKEY\_CURRENT\_USER (or HKCU), HKEY\_CLASSES\_ROOT (or HKCR), or HKEY\_CURRENT\_CONFIG (or HKCC).

To access a [remote registry](#remote), prepend the computer name and a colon, as in this example: \\\workstation01:HKEY\_LOCAL\_MACHINE

Key

The name of the key (e.g. Software\\SomeApplication). If blank or omitted, the contents of _RootKey_ will be retrieved.

IncludeSubkeys?

If blank or omitted, it defaults to 0 (only values are retrieved). Otherwise, specify one of the following digits:

- 0 = Subkeys contained within_Key_ are not retrieved (only the values).
- 1 = All values and subkeys are retrieved.
- 2 = Only the subkeys are retrieved (not the values).

Recurse?

If blank or omitted, it defaults to 0 (subkeys are not recursed into). Otherwise, specify one of the following digits:

- 0 = Subkeys are not recursed into.
- 1 = Subkeys are recursed into, so that all values and subkeys contained therein are retrieved.

## Remarks

A registry-loop is useful when you want to operate on a collection registry values or subkeys, one at a time. The values and subkeys are retrieved in reverse order (bottom to top) so that [RegDelete](RegDelete.htm) can be used inside the loop without disrupting the loop.

The following variables exist within any registry-loop. If an inner registry-loop is enclosed by an outer registry-loop, the innermost loop's registry item will take precedence:

VariableDescriptionA\_LoopRegNameName of the currently retrieved item, which can be either a value name or the name of a subkey. Value names displayed by Windows RegEdit as "(Default)" will be retrieved if a value has been assigned to them, but A\_LoopRegName will be blank for them.A\_LoopRegTypeThe type of the currently retrieved item, which is one of the following words: KEY (i.e. the currently retrieved item is a subkey not a value), REG\_SZ, REG\_EXPAND\_SZ, REG\_MULTI\_SZ, REG\_DWORD, REG\_QWORD, REG\_BINARY, REG\_LINK, REG\_RESOURCE\_LIST, REG\_FULL\_RESOURCE\_DESCRIPTOR, REG\_RESOURCE\_REQUIREMENTS\_LIST, REG\_DWORD\_BIG\_ENDIAN (probably rare on most Windows hardware). It will be empty if the currently retrieved item is of an unknown type.A\_LoopRegKeyThe name of the root key being accessed (HKEY\_LOCAL\_MACHINE, HKEY\_USERS, HKEY\_CURRENT\_USER, HKEY\_CLASSES\_ROOT, or HKEY\_CURRENT\_CONFIG). For remote registry access, this value will **not** include the computer name.A\_LoopRegSubKeyName of the current subkey. This will be the same as the _Key_ parameter unless the _Recurse_ parameter is being used to recursively explore other subkeys. In that case, it will be the full path of the currently retrieved item, not including the root key. For example: Software\\SomeApplication\\My SubKeyA\_LoopRegTimeModifiedThe time the current subkey or any of its values was last modified. Format [YYYYMMDDHH24MISS](FileSetTime.htm). This variable will be empty if the currently retrieved item is not a subkey (i.e. _A\_LoopRegType_ is not the word KEY).

When used inside a registry-loop, the following commands can be used in a simplified way to indicate that the currently retrieved item should be operated upon:

SyntaxDescription`<a href="RegRead.htm" data-index="6">RegRead</a>, OutputVar`Reads the current item. If the current item is a key, ErrorLevel will be set to 1 and _OutputVar_ will be made empty.`<a href="RegWrite.htm" data-index="7">RegWrite</a>, Value`

`<a href="RegWrite.htm" data-index="8">RegWrite</a>`Writes to the current item. If _Value_ is omitted, the item will be made 0 or blank depending on its type. If the current item is a key, ErrorLevel will be set to 1 and there will be no other effect.`<a href="RegDelete.htm" data-index="9">RegDelete</a>`Deletes the current item. If the current item is a key, it will be deleted along with any subkeys and values it contains.

When accessing a remote registry (via the _RootKey_ or _KeyName_ parameter described above), the following notes apply:

- The target machine must be running the Remote Registry service.
- Access to a remote registry may fail if the target computer is not in the same domain as yours or the local or remote username lacks sufficient permissions (however, see below for possible workarounds).
- Depending on your username's domain, workgroup, and/or permissions, you may have to connect to a shared device, such as by mapping a drive, prior to attempting remote registry access. Making such a connection -- using a remote username and password that has permission to access or edit the registry -- may as a side-effect enable remote registry access.
- If you're already connected to the target computer as a different user (for example, a mapped drive via user Guest), you may have to terminate that connection to allow the remote registry feature to reconnect and re-authenticate you as your own currently logged-on username.
- For Windows Server 2003 and Windows XP Professional, MSDN states: "If the [registry server] computer is joined to a workgroup and the_Force network logons using local accounts to authenticate as Guest_ policy is enabled, the function fails. Note that this policy is enabled by default if the computer is joined to a workgroup."
- For Windows XP Home Edition, MSDN states that "this function always fails". Home Edition lacks both the registry server and client, though the client can be extracted from one of the OS cab files.

See [Loop](Loop.htm) for information about [Blocks](Block.htm), [Break](Break.htm), [Continue](Continue.htm), and the A\_Index variable (which exists in every type of loop).

## Related

[Loop](Loop.htm), [Break](Break.htm), [Continue](Continue.htm), [Blocks](Block.htm), [RegRead](RegRead.htm), [RegWrite](RegWrite.htm), [RegDelete](RegDelete.htm), [SetRegView](SetRegView.htm)

## Examples

Deletes Internet Explorer's history of URLs typed by the user.

```
Loop, HKEY_CURRENT_USER, Software\Microsoft\Internet Explorer\TypedURLs
    RegDelete
```

A working test script.

```
Loop, Reg, HKEY_CURRENT_USER\Software\Microsoft\Windows, KVR
{
    if (A_LoopRegType = "key")
        value := ""
    else
    {
        RegRead, value
        if ErrorLevel
            value := "*error*"
    }
    MsgBox, 4, , %A_LoopRegName% = %value% (%A_LoopRegType%)`n`nContinue?
    IfMsgBox, NO, break
}
```

Recursively searches the entire registry for particular value(s).

```
SetBatchLines -1  <em>; Makes searching occur at maximum speed.</em>
RegSearchTarget := "Notepad"  <em>; Tell the subroutine what to search for.</em>
Gosub, RegSearch
return

RegSearch:
ContinueRegSearch := true
Loop, Reg, HKEY_LOCAL_MACHINE, KVR
{
    Gosub, CheckThisRegItem
    if not ContinueRegSearch <em>; It told us to stop.</em>
        return
}
Loop, Reg, HKEY_USERS, KVR
{
    Gosub, CheckThisRegItem
    if not ContinueRegSearch <em>; It told us to stop.</em>
        return
}
Loop, Reg, HKEY_CURRENT_CONFIG, KVR
{
    Gosub, CheckThisRegItem
    if not ContinueRegSearch <em>; It told us to stop.</em>
        return
}
<em>; Note: I believe HKEY_CURRENT_USER does not need to be searched if HKEY_USERS
; is being searched.  The same might also be true for HKEY_CLASSES_ROOT if
; HKEY_LOCAL_MACHINE is being searched.</em>
return

CheckThisRegItem:
if (A_LoopRegType = "KEY")  <em>; Remove these two lines if you want to check key names too.</em>
    return
RegRead, RegValue
if ErrorLevel
    return
if InStr(RegValue, RegSearchTarget)
{
    MsgBox, 4, , The following match was found:`n%A_LoopRegKey%\%A_LoopRegSubKey%\%A_LoopRegName%`nValue = %RegValue%`n`nContinue?
    IfMsgBox, No
        ContinueRegSearch := false  <em>; Tell our caller to stop searching.</em>
}
return
```

