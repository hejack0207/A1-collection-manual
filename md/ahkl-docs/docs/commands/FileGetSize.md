# FileGetSize

Retrieves the size of a file.

```
<span class="func">FileGetSize</span>, OutputVar <span class="optional">, Filename, Units</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved size (rounded down to the nearest whole number).

Filename

The name of the target file, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. If omitted, the current file of the innermost enclosing [File-Loop](LoopFile.htm) will be used instead.

Units

If present, this parameter causes the result to be returned in units other than bytes:

- K = kilobytes
- M = megabytes

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

Files of any size are supported, even those over 4 gigabytes, and even if _Units_ is bytes.

If the target file is a directory, the size will be reported as whatever the OS believes it to be (probably zero in all cases).

To calculate the size of folder, including all its files, follow this example:

```
SetBatchLines, -1  <em>; Make the operation run at maximum speed.</em>
FolderSize := 0
FileSelectFolder, WhichFolder  <em>; Ask the user to pick a folder.</em>
Loop, %WhichFolder%\*.*, , 1
    FolderSize += A_LoopFileSize
MsgBox Size of %WhichFolder% is %FolderSize% bytes.
```

## Related

[FileGetAttrib](FileGetAttrib.htm), [FileSetAttrib](FileSetAttrib.htm), [FileGetTime](FileGetTime.htm), [FileSetTime](FileSetTime.htm), [FileGetVersion](FileGetVersion.htm), [File-loop](LoopFile.htm)

## Examples

Retrieves the size in bytes and stores it in OutputVar.

```
FileGetSize, OutputVar, C:\My Documents\test.doc
```

Retrieves the size in kilobytes and stores it in OutputVar.

```
FileGetSize, OutputVar, C:\My Documents\test.doc, K
```

