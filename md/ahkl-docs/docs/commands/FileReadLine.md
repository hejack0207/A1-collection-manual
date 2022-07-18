# FileReadLine

Reads the specified line from a file and stores the text in a [variable](../Variables.htm).

```
<span class="func">FileReadLine</span>, OutputVar, Filename, LineNum
```

## Parameters

OutputVar

The name of the [variable](../Variables.htm) in which to store the retrieved text.

Filename

The name of the file to access, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. Windows and Unix formats are supported; that is, the file's lines may end in either carriage return and linefeed (\`r\`n) or just linefeed (\`n).

LineNum

Which line to read (1 is the first, 2 the second, and so on). This can be an [expression](../Variables.htm#Expressions).

If the specified line number is greater than the number of lines in the file, [ErrorLevel](../misc/ErrorLevel.htm) is set to 1 and _OutputVar_ is not changed. This also happens when the specified line number is the last line in the file but that line is blank and does not end in a newline/CRLF.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 0 upon success. Otherwise it is set to 1 and the original contents of _OutputVar_ are not changed.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

It is strongly recommended to use this command only for small files, or in cases where only a single line of text is needed. To scan and process a large number of lines (one by one), use a [file-reading loop](LoopReadFile.htm) for best performance. To read an entire file into a variable, use [FileRead](FileRead.htm).

Although any leading and trailing tabs and spaces present in the line will be written to _OutputVar_, the linefeed character (\`n) at the end of the line will not. Tabs and spaces can be trimmed from both ends of any variable by assigning it to itself while [AutoTrim](AutoTrim.htm) is on (the default). For example: `MyLine = %MyLine%`.

Lines up to 65,534 characters long can be read. If the length of a line exceeds this, the remaining characters cannot be retrieved by this command (use [FileRead](FileRead.htm) or a [file-reading loop](LoopReadFile.htm) instead).

## Related

[FileOpen()](FileOpen.htm) / [File.ReadLine()](../objects/File.htm#ReadLine), [FileRead](FileRead.htm), [FileAppend](FileAppend.htm), [File-reading loop](LoopReadFile.htm), [IniRead](IniRead.htm)

## Examples

Reads a text file line by line. Note that the same (but with better performance) can be achieved by using a [file-reading loop](LoopReadFile.htm).

```
Loop
{
    FileReadLine, line, C:\My Documents\ContactList.txt, %A_Index%
    if ErrorLevel
        break
    MsgBox, 4, , Line #%A_Index% is "%line%".  Continue?
    IfMsgBox, No
        return
}
MsgBox, The end of the file has been reached or there was a problem.
return
```

