# IfExist / IfNotExist

Checks for the existence of a file or folder.

**Deprecated:** These commands are not recommended for use in new scripts. Use the [FileExist](FileExist.htm) function instead.

```
<span class="func">IfExist</span>, FilePattern
<span class="func">IfNotExist</span>, FilePattern

```

## Parameters

FilePattern

The path, filename, or file pattern to check. _FilePattern_ is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

## Related

[FileExist()](FileExist.htm), [Blocks](Block.htm), [Else](Else.htm), [File-loops](LoopFile.htm)

## Examples

Shows a message box if the D drive does exist.

```
IfExist, D:\
    MsgBox, The drive exists.
```

Shows a message box if at least one text file does exist in a directory.

```
IfExist, D:\Docs\*.txt
    MsgBox, At least one .txt file exists.
```

Shows a message box if a file does **not** exist.

```
IfNotExist, C:\Temp\FlagFile.txt
    MsgBox, The target file does not exist.
```

