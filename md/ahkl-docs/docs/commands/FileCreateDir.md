# FileCreateDir

Creates a folder.

```
<span class="func">FileCreateDir</span>, DirName
```

## Parameters

DirName

Name of the directory to create, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

This command will also create all parent directories given in _DirName_ if they do not already exist.

## Related

[FileRemoveDir](FileRemoveDir.htm)

## Examples

Creates a new directory, including its parent directories if necessary.

```
FileCreateDir, C:\Test1\My Images\Folder2
```

