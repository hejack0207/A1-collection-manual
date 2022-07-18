# FileSetAttrib

Changes the attributes of one or more files or folders. Wildcards are supported.

```
<span class="func">FileSetAttrib</span>, Attributes <span class="optional">, FilePattern, OperateOnFolders?, Recurse?</span>
```

## Parameters

Attributes

The attributes to change. For example, `+HA-R`.

To easily turn on, turn off or toggle attributes, prefix one or more of the following attribute letters with a plus sign (+), minus sign (-) or caret (^), respectively:

- R = READONLY
- A = ARCHIVE
- S = SYSTEM
- H = HIDDEN
- N = NORMAL (this is valid only when used without any other attributes)
- O = OFFLINE
- T = TEMPORARY

**Note**: Currently, the compression state of files cannot be changed with this command.

FilePatternThe name of a single file or folder, or a wildcard pattern such as `C:\Temp\*.tmp`. _FilePattern_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.


If omitted, the current file of the innermost enclosing [File-Loop](LoopFile.htm) will be used instead.

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

[ErrorLevel](../misc/ErrorLevel.htm) is set to the number of files that failed to be changed or 0 otherwise.

If files were found, [A\_LastError](../Variables.htm#LastError) is set to 0 (zero) or the result of the operating system's GetLastError() function immediately after the last failure. Otherwise A\_LastError contains an error code that might indicate why no files were found.

## Related

[FileGetAttrib](FileGetAttrib.htm), [FileGetTime](FileGetTime.htm), [FileSetTime](FileSetTime.htm), [FileGetSize](FileGetSize.htm), [FileGetVersion](FileGetVersion.htm), [File-loop](LoopFile.htm)

## Examples

Turns on the "read-only" and "hidden" attributes of all files and directories (subdirectories are not recursed into).

```
FileSetAttrib, +RH, C:\MyFiles\*.*, 1  <em>; +RH is identical to +R+H</em>
```

Toggles the "hidden" attribute of a single directory.

```
FileSetAttrib, ^H, C:\MyFiles
```

Turns off the "read-only" attribute and turns on the "archive" attribute of a single file.

```
FileSetAttrib, -R+A, C:\New Text File.txt
```

Recurses through all .ini files on the C drive and turns on their "archive" attribute.

```
FileSetAttrib, +A, C:\*.ini, , 1
```

