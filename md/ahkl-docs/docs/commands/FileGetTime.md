# FileGetTime

Retrieves the datetime stamp of a file or folder.

```
<span class="func">FileGetTime</span>, OutputVar <span class="optional">, Filename, WhichTime</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved date-time in format [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD). The time is your own local time, not UTC/GMT.

Filename

The name of the target file or folder, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. If omitted, the current file of the innermost enclosing [File-Loop](LoopFile.htm) will be used instead.

WhichTime

If blank or omitted, it defaults to M (modification time). Otherwise, specify one of the following letters to set which timestamp should be retrieved:

- M = Modification time
- C = Creation time
- A = Last access time

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

See [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) for an explanation of dates and times.

## Related

[FileSetTime](FileSetTime.htm), [FormatTime](FormatTime.htm), [If var is [not] type](IfIs.htm), [FileGetAttrib](FileGetAttrib.htm), [FileSetAttrib](FileSetAttrib.htm), [FileGetSize](FileGetSize.htm), [FileGetVersion](FileGetVersion.htm), [File-loop](LoopFile.htm), [EnvAdd (date math)](EnvAdd.htm), [EnvSub (date difference)](EnvSub.htm)

## Examples

Retrieves the modification time and stores it in OutputVar.

```
FileGetTime, OutputVar, C:\My Documents\test.doc
```

Retrieves the creation time and stores it in OutputVar.

```
FileGetTime, OutputVar, C:\My Documents\test.doc, C
```

