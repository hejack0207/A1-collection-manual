# FileRemoveDir

Deletes a folder.

```
<span class="func">FileRemoveDir</span>, DirName <span class="optional">, Recurse</span>
```

## Parameters

DirName

Name of the directory to delete, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

Recurse

This parameter determines whether to recurse into subdirectories. If omitted, it defaults to 0 (false). Specify one of the following values:

**0** (false): Do **not** remove files and sub-directories contained in _DirName_. In this case, if _DirName_ is not empty, no action will be taken and ErrorLevel will be set to 1.

**1** (true): Remove all files and subdirectories (like the Windows command "rmdir /S").

This parameter can be an [expression](../Variables.htm#Expressions), even one that evalutes to true or false (since true and false are stored internally as 1 and 0).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Related

[FileCreateDir](FileCreateDir.htm), [FileDelete](FileDelete.htm)

## Examples

Removes the directory, but only if it is empty.

```
FileRemoveDir, C:\Download Temp
```

Removes the directory including its files and subdirectories.

```
FileRemoveDir, C:\Download Temp, 1
```

