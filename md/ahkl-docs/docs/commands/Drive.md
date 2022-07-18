# Drive

Ejects/retracts the tray in a CD or DVD drive, or sets a drive's volume label.

```
<span class="func">Drive</span>, <a href="#SubCommands" data-index="1">SubCommand</a> <span class="optional">, Value1, Value2</span>
```

The _SubCommand_, _Value1_, and _Value2_ parameters are dependent upon each other and their usage is described below.

## Sub-commands

For _SubCommand_, specify one of the following:

- [Label](#Label): Renames the volume label of a drive.
- [Lock](#Lock): Prevents a drive's eject feature from working.
- [Unlock](#Unlock): Restores a drive's eject feature.
- [Eject](#Eject): Ejects or retracts the tray of a CD or DVD drive.

### Label

Changes _Drive_'s volume label to be _NewLabel_.

```
<span class="func">Drive</span>, Label, Drive <span class="optional">, NewLabel</span>
```

_Drive_ is the drive letter followed by a colon and an optional backslash (might also work on UNCs and mapped drives). If _NewLabel_ is omitted, the drive will have no label.

To retrieve the current label, follow this example: `<a href="DriveGet.htm" data-index="6">DriveGet</a>, OutputVar, Label, C:`.

### Lock

Prevents a drive's eject feature from working.

```
<span class="func">Drive</span>, Lock, Drive
```

_Drive_ is the drive letter followed by a colon and an optional backslash (might also work on UNCs and mapped drives). For example: `Drive, Lock, D:`. Most drives cannot be "locked open". However, locking the drive while it is open will probably result in it becoming locked the moment it is closed. This sub-command has no effect on drives that do not support locking (such as most read-only drives). If a drive is locked by a script and that script exits, the drive will stay locked until another script or program unlocks it, or the system is restarted. If the specified drive does not exist or does not support the locking feature, ErrorLevel is set to 1. Otherwise, it is set to 0.

### Unlock

Restores a drive's eject feature.

```
<span class="func">Drive</span>, Unlock, Drive
```

_Drive_ is the drive letter followed by a colon and an optional backslash (might also work on UNCs and mapped drives). The Unlock sub-command needs to be executed multiple times if the drive was locked multiple times (at least for some drives). For example, if `Drive, Lock, D:` was executed three times, three executions of `Drive, Unlock, D:` might be needed to unlock it. Because of this and the fact that there is no way to determine whether a drive is currently locked, it is often useful to keep track of its lock-state in a [variable](../Variables.htm).

### Eject

Ejects or retracts the tray of a CD or DVD drive.

```
<span class="func">Drive</span>, Eject <span class="optional">, Drive, 1</span>
```

To eject other types of media or devices, see [example #3](#ExDllCall) at the bottom of this page.

_Drive_ is the drive letter followed by a colon and an optional backslash. If _Drive_ is omitted, the default CD/DVD drive will be used. To eject the tray, omit the last parameter. To retract/close the tray, specify 1 for the last parameter; for example: `Drive, Eject, D:, 1`.

This sub-command waits for the ejection or retraction to complete before allowing the script to continue. If the tray is already in the correct state (open or closed), [ErrorLevel](../misc/ErrorLevel.htm) is set to 0 (i.e. "no error").

This sub-command will probably not work on a network drive or non-CD/DVD drive. If it fails in such cases or for any other reason, [ErrorLevel](../misc/ErrorLevel.htm) is set to 1.

It may be possible to detect the previous tray state by measuring the time the sub-command takes to complete. For example, the following hotkey toggles the tray to the opposite state (open or closed):

```
#c::
Drive, Eject
<em>; If the command completed quickly, the tray was probably already ejected.
; In that case, retract it:</em>
if (A_TimeSinceThisHotkey < 1000)  <em>; Adjust this time if needed.</em>
    Drive, Eject,, 1
return
```

To determine the media status of a CD or DVD drive (playing, stopped, open, etc.), see [DriveGet](DriveGet.htm).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Related

[DriveGet](DriveGet.htm), [DriveSpaceFree](DriveSpaceFree.htm)

## Examples

Changes the volume label of the D drive.

```
Drive, Label, D:, BackupDrive
```

Retracts (closes) the tray of the default CD or DVD drive.

```
Drive, Eject,, 1
```

This is an alternate ejection method that also works on types of media/devices other than CD/DVD. Update the first line below to match the desired drive letter (you can ignore all the other lines below).

```
DriveLetter := "I:"  <em>; Set this to the drive letter you wish to eject.</em>

hVolume := DllCall("CreateFile"
    , "Str", "\\.\" . DriveLetter
    , "UInt", 0x80000000 | 0x40000000  <em>; GENERIC_READ | GENERIC_WRITE</em>
    , "UInt", 0x1 | 0x2  <em>; FILE_SHARE_READ | FILE_SHARE_WRITE</em>
    , "UInt", 0
    , "UInt", 0x3  <em>; OPEN_EXISTING</em>
    , "UInt", 0, "UInt", 0)
if (hVolume != -1)
{
    DllCall("DeviceIoControl"
        , "UInt", hVolume
        , "UInt", 0x2D4808   <em>; IOCTL_STORAGE_EJECT_MEDIA</em>
        , "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0
        , "UIntP", dwBytesReturned  <em>; Unused.</em>
        , "UInt", 0)
    DllCall("CloseHandle", "UInt", hVolume)
}
```

