# FileSetTime

Changes the datetime stamp of one or more files or folders. Wildcards are supported.

```
<span class="func">FileSetTime</span> <span class="optional">, YYYYMMDDHH24MISS, FilePattern, WhichTime, OperateOnFolders?, Recurse?</span>
```

## Parameters

YYYYMMDDHH24MISS

If blank or omitted, it defaults to the current time. Otherwise, specify the time to use for the operation (see Remarks for the format).
Years prior to 1601 are not supported.

This parameter is an [expression](../Variables.htm#Expressions). Consequently, if multiple variables need to be concatenated to form a single timestamp, the [dot operator](../Variables.htm#concat) should be used instead of percent signs. For example: `FileSetTime, Year <strong>.</strong> Month <strong>.</strong> Day, C:\My File.txt`.

FilePattern

The name of a single file or folder, or a wildcard pattern such as C:\\Temp\\\*.tmp. _FilePattern_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

If omitted, the current file of the innermost enclosing [File-Loop](LoopFile.htm) will be used instead.

WhichTime

If blank or omitted, it defaults to M (modification time). Otherwise, specify one of the following letters to set which timestamp should be changed:

- M = Modification time
- C = Creation time
- A = Last access time

OperateOnFolders?

If blank or omitted, it defaults to 0 (only files are operated upon). Otherwise, specify one of the following digits:

- 0 = Folders are not operated upon (only files).
- 1 = All files and folders that match the wildcard pattern are operated upon.
- 2 = Only folders are operated upon (no files).

**Note**: If _FilePattern_ is a single folder rather than a wildcard pattern, it will always be operated upon regardless of this setting.

This parameter can be an [expression](../Variables.htm#Expressions).

Recurse?

If blank or omitted, it defaults to 0 (subfolders are not recursed into). Otherwise, specify one of the following digits:

- 0 = Subfolders are not recursed into.
- 1 = Subfolders are recursed into so that files and folders contained therein are operated upon if they match_FilePattern_. All subfolders will be recursed into, not just those whose names match _FilePattern_. However, files and folders with a complete path name longer than 259 characters are skipped over as though they do not exist. Such files are rare because normally, the operating system does not allow their creation.

This parameter can be an [expression](../Variables.htm#Expressions).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to the number of files that failed to be changed or 0 otherwise. If the specified timestamp is invalid, or _FilePattern_ resolves to a blank value, ErrorLevel is set to 1.

If files were found, [A\_LastError](../Variables.htm#LastError) is set to 0 (zero) or the result of the operating system's GetLastError() function immediately after the last failure. Otherwise A\_LastError contains an error code that might indicate why no files were found.

## Remarks

A file's last access time might not be as precise on FAT16 & FAT32 volumes as it is on NTFS volumes.

The elements of the YYYYMMDDHH24MISS format are:

ElementDescriptionYYYYThe 4-digit yearMMThe 2-digit month (01-12)DDThe 2-digit day of the month (01-31)HH24The 2-digit hour in 24-hour format (00-23). For example, 09 is 9am and 21 is 9pm.MIThe 2-digit minutes (00-59)SSThe 2-digit seconds (00-59)

If only a partial string is given for YYYYMMDDHH24MISS (e.g. 200403), any remaining element that has been omitted will be supplied with the following default values:

- MM = Month 01
- DD = Day 01
- HH24 = Hour 00
- MI = Minute 00
- SS = Second 00

The built-in variable [A\_Now](../Variables.htm#Now) contains the current local time in the above format. Similarly, [A\_NowUTC](../Variables.htm#NowUTC) contains the current Coordinated Universal Time.

**Note:** Date-time values can be compared, added to, or subtracted from via [EnvAdd](EnvAdd.htm) and [EnvSub](EnvSub.htm). Also, it is best to not use greater-than or less-than to compare times unless they are both the same string length. This is because they would be compared as numbers; for example, 20040201 is always numerically less (but chronologically greater) than 200401010533. So instead use [EnvSub](EnvSub.htm) to find out whether the amount of time between them is positive or negative.

## Related

[FileGetTime](FileGetTime.htm), [FileGetAttrib](FileGetAttrib.htm), [FileSetAttrib](FileSetAttrib.htm), [FileGetSize](FileGetSize.htm), [FileGetVersion](FileGetVersion.htm), [FormatTime](FormatTime.htm), [File-loop](LoopFile.htm), [EnvAdd (date math)](EnvAdd.htm), [EnvSub (date difference)](EnvSub.htm)

## Examples

Sets the modification time to the current time for all matching files.

```
FileSetTime, , C:\temp\*.txt
```

Sets the modification date (time will be midnight).

```
FileSetTime, 20040122, C:\My Documents\test.doc
```

Sets the creation date. The time will be set to 4:55pm.

```
FileSetTime, 200401221655, C:\My Documents\test.doc, C
```

Changes the mod-date of all files that match a pattern. Any matching folders will also be changed due to the last parameter.

```
FileSetTime, 20040122165500, C:\Temp\*.*, M, 1
```

