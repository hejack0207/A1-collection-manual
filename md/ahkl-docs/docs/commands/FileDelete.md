# FileDelete

Deletes one or more files.

```
<span class="func">FileDelete</span>, FilePattern
```

## Parameters

FilePattern

The name of a single file or a wildcard pattern such as `C:\Temp\*.tmp`. _FilePattern_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

To remove an entire folder, along with all its sub-folders and files, use [FileRemoveDir](FileRemoveDir.htm).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to the number of files that failed to be deleted (if any) or 0 otherwise. Deleting a wildcard pattern such as `*.tmp` is considered a success even if it does not match any files; thus ErrorLevel is set to 0.

If files were found, [A\_LastError](../Variables.htm#LastError) is set to 0 (zero) or the result of the operating system's GetLastError() function immediately after the last failure. Otherwise A\_LastError contains an error code that might indicate why no files were found.

## Remarks

To delete a read-only file, first remove the read-only attribute. For example: `<a href="FileSetAttrib.htm" data-index="6">FileSetAttrib</a>, -R, C:\My File.txt`.

## Related

[FileRecycle](FileRecycle.htm), [FileRemoveDir](FileRemoveDir.htm), [FileCopy](FileCopy.htm), [FileMove](FileMove.htm)

## Examples

Deletes all .tmp files in a directory.

```
FileDelete, C:\temp files\*.tmp
```

