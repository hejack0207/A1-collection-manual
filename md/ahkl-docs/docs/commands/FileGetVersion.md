# FileGetVersion

Retrieves the version of a file.

```
<span class="func">FileGetVersion</span>, OutputVar <span class="optional">, Filename</span>
```

## Parameters

OutputVar

The name of the variable in which to store the version number/string.

Filename

The name of the target file. If a full path is not specified, this function uses the search sequence specified by the system [LoadLibrary](https://msdn.microsoft.com/en-us/library/windows/desktop/ms684175) function. If omitted, the current file of the innermost enclosing [File-Loop](LoopFile.htm) will be used instead.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

Most non-executable files (and even some EXEs) won't have a version, and thus _OutputVar_ will be blank in these cases.

## Related

[FileGetAttrib](FileGetAttrib.htm), [FileSetAttrib](FileSetAttrib.htm), [FileGetTime](FileGetTime.htm), [FileSetTime](FileSetTime.htm), [FileGetSize](FileGetSize.htm), [File-loop](LoopFile.htm)

## Examples

Retrieves the version of a file and stores it in Version.

```
FileGetVersion, Version, C:\My Application.exe
```

Retrieves the version of the file "AutoHotkey.exe" located in AutoHotkey's installation directory and stores it in Version.

```
FileGetVersion, Version, %A_ProgramFiles%\AutoHotkey\AutoHotkey.exe
```

