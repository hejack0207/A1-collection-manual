# FileCopy

Copies one or more files.

```
<span class="func">FileCopy</span>, SourcePattern, DestPattern <span class="optional">, Overwrite</span>
```

## Parameters

SourcePattern

The name of a single file or folder, or a wildcard pattern such as C:\\Temp\\\*.tmp. _SourcePattern_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

DestPattern

The name or pattern of the destination, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

If present, the first asterisk ( `*`) in the filename is replaced with the source filename excluding its extension, while the first asterisk after the last full stop ( `.`) is replaced with the source file's extension. If an asterisk is present but the extension is omitted, the source file's extension is used.

To perform a simple copy -- retaining the existing file name(s) -- specify only the folder name as shown in these mostly equivalent examples:

```
FileCopy, C:\*.txt, C:\My Folder
```

```
FileCopy, C:\*.txt, C:\My Folder\*.*
```

The destination directory must already exist. If _My Folder_ does not exist, the first example above will use "My Folder" as the target filename, while the second example will copy no files.

Overwrite

This parameter determines whether to overwrite files if they already exist. If this parameter is 1 (true), the command overwrites existing files. If omitted or 0 (false), the command does not overwrite existing files.

This parameter can be an [expression](../Variables.htm#Expressions), even one that evalutes to true or false (since true and false are stored internally as 1 and 0).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to the number of files that could not be copied due to an error, or 0 otherwise.

In either case, if the source file is a single file (no wildcards) and it does not exist, ErrorLevel is set to 0. To detect this condition, use [FileExist()](FileExist.htm) or [IfExist](IfExist.htm) on the source file prior to copying it.

Unlike [FileMove](FileMove.htm), copying a file onto itself is always counted as an error, even if the overwrite mode is in effect.

If files were found, [A\_LastError](../Variables.htm#LastError) is set to 0 (zero) or the result of the operating system's GetLastError() function immediately after the last failure. Otherwise A\_LastError contains an error code that might indicate why no files were found.

## Remarks

FileCopy copies files only. To instead copy the contents of a folder (all its files and subfolders), see the examples section below. To copy a single folder (including its subfolders), use [FileCopyDir](FileCopyDir.htm).

The operation will continue even if error(s) are encountered.

## Related

[FileMove](FileMove.htm), [FileCopyDir](FileCopyDir.htm), [FileMoveDir](FileMoveDir.htm), [FileDelete](FileDelete.htm)

## Examples

Makes a copy but keep the original file name.

```
FileCopy, C:\My Documents\List1.txt, D:\Main Backup\
```

Copies a file into the same directory by providing a new name.

```
FileCopy, C:\My File.txt, C:\My File New.txt
```

Copies text files to a new location and gives them a new extension.

```
FileCopy, C:\Folder1\*.txt, D:\New Folder\*.bkp
```

Copies all files and folders inside a folder to a different folder.

```
ErrorCount := CopyFilesAndFolders("C:\My Folder\*.*", "D:\Folder to receive all files & folders")
if (ErrorCount != 0)
    MsgBox %ErrorCount% files/folders could not be copied.

CopyFilesAndFolders(SourcePattern, DestinationFolder, DoOverwrite = false)
<em>; Copies all files and folders matching SourcePattern into the folder named DestinationFolder and
; returns the number of files/folders that could not be copied.</em>
{
    <em>; First copy all the files (but not the folders):</em>
    FileCopy, %SourcePattern%, %DestinationFolder%, %DoOverwrite%
    ErrorCount := ErrorLevel
    <em>; Now copy all the folders:</em>
    Loop, %SourcePattern%, 2  <em>; 2 means "retrieve folders only".</em>
    {
        FileCopyDir, %A_LoopFileFullPath%, %DestinationFolder%\%A_LoopFileName%, %DoOverwrite%
        ErrorCount += ErrorLevel
        if ErrorLevel  <em>; Report each problem folder by name.</em>
            MsgBox Could not copy %A_LoopFileFullPath% into %DestinationFolder%.
    }
    return ErrorCount
}
```

