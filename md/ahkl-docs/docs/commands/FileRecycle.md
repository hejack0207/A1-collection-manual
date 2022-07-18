# FileRecycle

Sends a file or directory to the recycle bin if possible, or permanently deletes it.

```
<span class="func">FileRecycle</span>, FilePattern
```

## Parameters

FilePattern

The name of a single file or a wildcard pattern such as C:\\Temp\\\*.tmp. _FilePattern_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

To recycle an entire directory, provide its name without a trailing backslash.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

[SHFileOperation](http://msdn.microsoft.com/en-us/library/bb762164.aspx) is used to do the actual work. This function may permanently delete the file if it is too large to be recycled; as of [v1.0.96], a warning should be shown before this occurs.

The file may be permanently deleted without warning if the file cannot be recycled for other reasons, such as:

- The file is on a removable drive.
- The Recycle Bin has been disabled, such as via the`NukeOnDelete` registry value.

## Related

[FileRecycleEmpty](FileRecycleEmpty.htm), [FileDelete](FileDelete.htm), [FileCopy](FileCopy.htm), [FileMove](FileMove.htm)

## Examples

Sends all .tmp files in a directory to the recycle bin if possible.

```
FileRecycle, C:\temp files\*.tmp
```

