# FileMoveDir

Moves a folder along with all its sub-folders and files. It can also rename a folder.

```
<span class="func">FileMoveDir</span>, Source, Dest <span class="optional">, Flag</span>
```

## Parameters

Source

Name of the source directory (with no trailing backslash), which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. For example: C:\\My Folder

Dest

The new path and name of the directory (with no trailing baskslash), which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. For example: D:\\My Folder.

**Note**: _Dest_ is the actual path and name that the directory will have after it is moved; it is _not_ the directory into which _Source_ is moved (except for the known limitation mentioned below).

Flag

(options) Specify one of the following single characters:

**0** (default): Do not overwrite existing files. The operation will fail if _Dest_ already exists as a file or directory.

**1**: Overwrite existing files. However, any files or subfolders inside _Dest_ that do not have a counterpart in _Source_ will not be deleted. **Known limitation:** If _Dest_ already exists as a folder and it is on the same volume as _Source_, _Source_ will be moved into it rather than overwriting it. To avoid this, see the next option.

**2**: The same as mode 1 above except that the limitation is absent.

**R**: Rename the directory rather than moving it. Although renaming normally has the same effect as moving, it is helpful in cases where you want "all or none" behavior; that is, when you don't want the operation to be only partially successful when _Source_ or one of its files is locked (in use). Although this method cannot move _Source_ onto a different volume, it can move it to any other directory on its own volume. The operation will fail if _Dest_ already exists as a file or directory.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

FileMoveDir moves a single folder to a new location. To instead move the contents of a folder (all its files and subfolders), see the examples section of [FileMove](FileMove.htm).

If the source and destination are on different volumes or UNC paths, a copy/delete operation will be performed rather than a move.

## Related

[FileCopyDir](FileCopyDir.htm), [FileCopy](FileCopy.htm), [FileMove](FileMove.htm), [FileDelete](FileDelete.htm), [File-loops](LoopFile.htm), [FileSelectFolder](FileSelectFolder.htm), [SplitPath](SplitPath.htm)

## Examples

Moves a directory to a new drive.

```
FileMoveDir, C:\My Folder, D:\My Folder
```

Performs a simple rename.

```
FileMoveDir, C:\My Folder, C:\My Folder (renamed), R
```

Directories can be "renamed into" another location as long as it's on the same volume.

```
FileMoveDir, C:\My Folder, C:\New Location\My Folder, R
```

