# FileCopyDir

Copies a folder along with all its sub-folders and files (similar to xcopy).

```
<span class="func">FileCopyDir</span>, Source, Dest <span class="optional">, Overwrite</span>
```

## Parameters

Source

Name of the source directory (with no trailing backslash), which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. For example: C:\\My Folder

[v1.1.34+]: If supported by the OS, _Source_ can also be the path of a zip file, in which case its content will be copied to the destination directory. This has been confirmed to work on Windows 7 and Windows 11.

Dest

Name of the destination directory (with no trailing baskslash), which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. For example: C:\\Copy of My Folder

Overwrite

This parameter determines whether to overwrite files if they already exist. If omitted, it defaults to 0 (false). Specify one of the following values:

**0** (false): Do not overwrite existing files. The operation will fail and have no effect if _Dest_ already exists as a file or directory.

**1** (true): Overwrite existing files. However, any files or subfolders inside _Dest_ that do not have a counterpart in _Source_ will not be deleted.

This parameter can be an [expression](../Variables.htm#Expressions), even one that evalutes to true or false (since true and false are stored internally as 1 and 0).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise. However, if the source directory contains any saved webpages consisting of a _PageName.htm_ file and a corresponding directory named _PageName\_files_, an error may be indicated even when the copy is successful.

## Remarks

If the destination directory structure doesn't exist it will be created if possible.

Since the operation will recursively copy a folder along with all its subfolders and files, the result of copying a folder to a destination somewhere inside itself is undefined. To work around this, first copy it to a destination outside itself, then use [FileMoveDir](FileMoveDir.htm) to move that copy to the desired location.

FileCopyDir copies a single folder. To instead copy the contents of a folder (all its files and subfolders), see the examples section of [FileCopy](FileCopy.htm).

## Related

[FileMoveDir](FileMoveDir.htm), [FileCopy](FileCopy.htm), [FileMove](FileMove.htm), [FileDelete](FileDelete.htm), [file-loops](LoopFile.htm), [FileSelectFolder](FileSelectFolder.htm), [SplitPath](SplitPath.htm)

## Examples

Copies a directory to a new location.

```
FileCopyDir, C:\My Folder, C:\Copy of My Folder
```

Prompts the user to copy a folder.

```
FileSelectFolder, SourceFolder, , 3, Select the folder to copy
if SourceFolder =
    return
<em>; Otherwise, continue.</em>
FileSelectFolder, TargetFolder, , 3, Select the folder IN WHICH to create the duplicate folder.
if TargetFolder =
    return
<em>; Otherwise, continue.</em>
MsgBox, 4, , A copy of the folder "%SourceFolder%" will be put into "%TargetFolder%".  Continue?
IfMsgBox, No
    return
SplitPath, SourceFolder, SourceFolderName  <em>; Extract only the folder name from its full path.</em>
FileCopyDir, %SourceFolder%, %TargetFolder%\%SourceFolderName%
if ErrorLevel
    MsgBox The folder could not be copied, perhaps because a folder of that name already exists in "%TargetFolder%".
return
```

