# FileGetAttrib

Reports whether a file or folder is read-only, hidden, etc.

```
<span class="func">FileGetAttrib</span>, OutputVar <span class="optional">, Filename</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved text.

Filename

The name of the target file, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. If omitted, the current file of the innermost enclosing [File-Loop](LoopFile.htm) will be used instead. Unlike [FileExist()](FileExist.htm), this must be a true filename, not a pattern.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

The string returned will contain a subset of the letters in the string "RASHNDOCT":

- R = READONLY
- A = ARCHIVE
- S = SYSTEM
- H = HIDDEN
- N = NORMAL
- D = DIRECTORY
- O = OFFLINE
- C = COMPRESSED
- T = TEMPORARY

To check if a particular attribute is present in the retrieved string, following this example:

```
FileGetAttrib, Attributes, C:\My File.txt
if InStr(Attributes, "H")
    MsgBox The file is hidden.
```

On a related note, to retrieve a file's 8.3 short name, follow this example:

```
<a href="LoopFile.htm" data-index="7">Loop</a>, C:\My Documents\Address List.txt
    ShortPathName := A_LoopFileShortPath  <em>; Will yield something similar to C:\MYDOCU~1\ADDRES~1.txt</em>
```

A similar method can be used to get the long name of an 8.3 short name.

## Related

[FileExist()](FileExist.htm), [FileSetAttrib](FileSetAttrib.htm), [FileGetTime](FileGetTime.htm), [FileSetTime](FileSetTime.htm), [FileGetSize](FileGetSize.htm), [FileGetVersion](FileGetVersion.htm), [File-loop](LoopFile.htm)

## Examples

Stores the attribute letters of a directory in OutputVar. Note that existing directories always have the attribute letter D.

```
FileGetAttrib, OutputVar, C:\New Folder
```

