# DriveGet

Retrieves various types of information about the computer's drive(s).

```
<span class="func">DriveGet</span>, OutputVar, <a href="#SubCommands" data-index="1">SubCommand</a> <span class="optional">, Value</span>
```

The _OutputVar_ parameter is the name of the variable in which to store the result. The _SubCommand_ and _Value_ parameters are dependent upon each other and their usage is described below.

## Sub-commands

For _SubCommand_, specify one of the following:

- [List](#List): Retrieves a string of letters, one character for each drive letter in the system.
- [Capacity](#Capacity): Retrieves the total capacity of the specified path in megabytes.
- [FileSystem](#FileSystem): Retrieves the type of the specified drive's file system.
- [Label](#Label): Retrieves the volume label of the specified drive.
- [Serial](#Serial): Retrieves the volume serial number of the specified drive.
- [Type](#Type): Retrieves the drive type of the specified path.
- [Status](#Status): Retrieves the status of the specified path.
- [StatusCD](#StatusCD): Retrieves the media status of a CD or DVD drive.

### List

Retrieves a string of letters, one character for each drive letter in the system. For example: ACDEZ.

```
<span class="func">DriveGet</span>, OutputVar, List <span class="optional">, Type</span>
```

If _Type_ is omitted, all drive types are retrieved. Otherwise, _Type_ should be one of the following words to retrieve only a specific type of drive: CDROM, REMOVABLE, FIXED, NETWORK, RAMDISK, UNKNOWN.

### Capacity

Retrieves the total capacity of _Path_ (e.g. `C:\`) in megabytes.

```
<span class="func">DriveGet</span>, OutputVar, Capacity, Path
```

Use [DriveSpaceFree](DriveSpaceFree.htm) to determine the free space. The word Cap can be used in place of Capacity.

### FileSystem

Retrieves the type of _Drive_'s file system.

```
<span class="func">DriveGet</span>, OutputVar, FileSystem, Drive
```

_Drive_ is the drive letter followed by a colon and an optional backslash, or a UNC name such `\\server1\share1`. _OutputVar_ will be set to one of the following words: FAT, FAT32, NTFS, CDFS (typically indicates a CD), UDF (typically indicates a DVD). _OutputVar_ will be made blank and [ErrorLevel](../misc/ErrorLevel.htm) set to 1 if the drive does not contain formatted media. The word FS can be used in place of FileSystem.

### Label

Retrieves _Drive_'s volume label.

```
<span class="func">DriveGet</span>, OutputVar, Label, Drive
```

_Drive_ is the drive letter followed by a colon and an optional backslash, or a UNC name such `\\server1\share1`. To change the label, follow this example: `<a href="Drive.htm" data-index="12">Drive</a>, Label, C:, MyLabel`.

### Serial

Retrieves _Drive_'s volume serial number expressed as decimal integer.

```
<span class="func">DriveGet</span>, OutputVar, Serial, Drive
```

_Drive_ is the drive letter followed by a colon and an optional backslash, or a UNC name such `\\server1\share1`. See [Format()](Format.htm) or [SetFormat](SetFormat.htm) for how to convert it to hexadecimal.

### Type

Retrieves _Path_'s drive type.

```
<span class="func">DriveGet</span>, OutputVar, Type, Path
```

_OutputVar_ is set to one of the following words: Unknown, Removable, Fixed, Network, CDROM, RAMDisk.

### Status

Retrieves _Path_'s status.

```
<span class="func">DriveGet</span>, OutputVar, Status, Path
```

_OutputVar_ is set to one of the following words: Unknown (might indicate unformatted/RAW), Ready, NotReady (typical for removable drives that don't contain media), Invalid ( _Path_ does not exist or is a network drive that is presently inaccessible, etc.)

### StatusCD

Retrieves the media status of a CD or DVD drive.

```
<span class="func">DriveGet</span>, OutputVar, StatusCD <span class="optional">, Drive</span>
```

_Drive_ is the drive letter followed by a colon. If _Drive_ is omitted, the default CD/DVD drive will be used. _OutputVar_ is made blank if the status cannot be determined. Otherwise, it is set to one of the following strings:

StringDescriptionnot readyThe drive is not ready to be accessed, perhaps due to being engaged in a write operation. Known limitation: "not ready" also occurs when the drive contains a DVD rather than a CD.openThe drive contains no disc, or the tray is ejected.playingThe drive is playing a disc.pausedThe previously playing audio or video is now paused.seekingThe drive is seeking.stoppedThe drive contains a CD but is not currently accessing it.

This sub-command will probably not work on a network drive or non-CD/DVD drive; if it fails in such cases or for any other reason, _OutputVar_ is made blank and [ErrorLevel](../misc/ErrorLevel.htm) is set to 1.

If the tray was recently closed, there may be a delay before the sub-command completes.

To eject or retract the tray, see the [Drive](Drive.htm) command.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

Some of the sub-commands will accept a network share name as _Path_ or _Drive_, such as `\\MyServer\MyShare\`.

## Related

[Drive](Drive.htm), [DriveSpaceFree](DriveSpaceFree.htm)

## Examples

Allows the user to select a drive in order to analyze it.

```
FileSelectFolder, folder,, 3, Pick a drive to analyze:
if not folder
    return
DriveGet, list, List
DriveGet, cap, Capacity, %folder%
DriveSpaceFree, free, %folder%
DriveGet, fs, FileSystem, %folder%
DriveGet, label, Label, %folder%
DriveGet, serial, Serial, %folder%
DriveGet, type, Type, %folder%
DriveGet, status, Status, %folder%
MsgBox All Drives: %list%`nSelected Drive: %folder%`nDrive Type: %type%`nStatus: %status%`nCapacity: %cap% M`nFree Space: %free% M`nFilesystem: %fs%`nVolume Label: %label%`nSerial Number: %serial%
```

