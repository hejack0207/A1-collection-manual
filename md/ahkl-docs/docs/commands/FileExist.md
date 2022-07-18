# FileExist()

Checks for the existence of a file or folder and returns its attributes.

```
AttributeString := <span class="func">FileExist</span>(FilePattern)
```

## Parameters

FilePattern

The path, filename, or file pattern to check. _FilePattern_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

## Return Value

This function returns the attribute string (a subset of "RASHNDOCT") of the first matching file or folder:

- R = READONLY
- A = ARCHIVE
- S = SYSTEM
- H = HIDDEN
- N = NORMAL
- D = DIRECTORY
- O = OFFLINE
- C = COMPRESSED
- T = TEMPORARY

If the file has no attributes (rare), "X" is returned. If no file is found, an empty string is returned.

## Remarks

This function is a combination of [IfExist](IfExist.htm) and [FileGetAttrib](FileGetAttrib.htm).

Since an empty string is seen as "false", the function's return value can always be used as a quasi-boolean value. For example, the statement `if FileExist("C:\My File.txt")` would be true if the file exists and false otherwise. Similarly, the statement `if InStr(FileExist("C:\My Folder"), "D")` would be true only if the file exists _and_ is a directory.

Since _FilePattern_ may contain wildcards, FileExist may be unsuitable for validating a file path which is to be used with another function or program. For example, `FileExist("*.txt")` may return attributes even though "\*.txt" is not a valid filename. In such cases, [FileGetAttrib](FileGetAttrib.htm) is preferred.

## Related

[IfExist](IfExist.htm), [FileGetAttrib](FileGetAttrib.htm), [Blocks](Block.htm), [Else](Else.htm), [File-loops](LoopFile.htm)

## Examples

Shows a message box if the D drive does exist.

```
if FileExist("D:\")
    MsgBox, The drive exists.
```

Shows a message box if at least one text file does exist in a directory.

```
if FileExist("D:\Docs\*.txt")
    MsgBox, At least one .txt file exists.
```

Shows a message box if a file does **not** exist.

```
if !FileExist("C:\Temp\FlagFile.txt")
    MsgBox, The target file does not exist.
```

Demonstrates how to check a file for a specific attribute.

```
if InStr(FileExist("C:\My File.txt"), "H")
    MsgBox The file is hidden.
```

