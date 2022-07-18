# FileRead

Reads a file's contents into a [variable](../Variables.htm).

```
<span class="func">FileRead</span>, OutputVar, Filename
```

## Parameters

OutputVar

The name of the [variable](../Variables.htm) in which to store the retrieved data. _OutputVar_ will be made blank if a problem occurs such as the file being "in use" or not existing (in which case [ErrorLevel](../misc/ErrorLevel.htm) is set to 1). It will also be made blank if _Filename_ is an empty file (in which case ErrorLevel is set to 0).

Filename

The name of the file to read, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

**Options**: Zero or more of the following strings may be also be present immediately before the name of the file. Separate each option from the next with a single space or tab. For example: `*t *m5000 C:\Log Files\200601.txt`.

**\*c**: Load a [ClipboardAll](../misc/Clipboard.htm#ClipboardAll) file or other binary data. All other options are ignored when **\*c** is present.

**\*m1024**: If this option is omitted, the entire file is loaded unless there is insufficient memory, in which case an error message is shown and the thread exits (but [Try](Try.htm) can be used to avoid this). Otherwise, replace 1024 with a decimal or hexadecimal number of bytes. If the file is larger than this, only its leading part is loaded.

**Note**: This might result in the last line ending in a naked carriage return (\`r) rather than \`r\`n.

**\*t**: Replaces any/all occurrences of carriage return & linefeed (\`r\`n) with linefeed (\`n). However, this translation reduces performance and is usually not necessary. For example, text containing \`r\`n is already in the right format to be added to a [Gui Edit control](GuiControls.htm#Edit). Similarly, [FileAppend](FileAppend.htm) detects the presence of \`r\`n when it opens a new file; it knows to write each \`r\`n as-is rather than translating it to \`r\`r\`n. Finally, the following [parsing loop](LoopParse.htm) will work correctly regardless of whether each line ends in \`r\`n or just \`n: ``Loop, parse, MyFileContents, `n, `r``.

**\*Pnnn**: [AHK\_L 42+]: Overrides the default encoding set by [FileEncoding](FileEncoding.htm), where _nnn_ must be a numeric [code page identifier](http://msdn.microsoft.com/en-us/library/dd317756.aspx).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 0 if the load was successful. It is set to 1 if a problem occurred such as: 1) file does not exist; 2) file is locked or inaccessible; 3) the system lacks sufficient memory to load the file.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Reading Binary Data

Depending on the file, parameters and default settings, FileRead may interpret the file data as text and convert it to the [native encoding](../Compat.htm#Format) used by the script. This is likely to cause problems if the file contains binary data, except in the following cases:

- If the\*C option is present, all code page and end-of-line translations are unconditionally bypassed.
- If the\*P _nnn_ option is present and _nnn_ corresponds to the native string encoding, no code page translation occurrs.
- If the current[file encoding](FileEncoding.htm) setting corresponds to the native string encoding, no code page translation occurrs.

Note that once the data has been read into _OutputVar_, only the text before the first binary zero (if any are present) will be "seen" by most AutoHotkey commands and functions. However, the entire contents are still present and can be accessed by advanced methods such as [NumGet()](NumGet.htm).

Finally, [FileOpen()](FileOpen.htm) and [File.RawRead()](../objects/File.htm#RawRead) or [File.Read _Num_()](../objects/File.htm#ReadNum) may be used to read binary data without first reading the entire file into memory.

## Remarks

When the goal is to load all or a large part of a file into memory, FileRead performs much better than using a [file-reading loop](LoopReadFile.htm).

A file greater than 1 GB in size will cause [ErrorLevel](../misc/ErrorLevel.htm) to be set to 1 and _OutputVar_ to be made blank unless the **\*m** option is present, in which case the leading part of the file is loaded.

FileRead does not obey [#MaxMem](_MaxMem.htm). If there is concern about using too much memory, check the file size beforehand with [FileGetSize](FileGetSize.htm).

[FileOpen()](FileOpen.htm) provides more advanced functionality than FileRead, such as reading or writing data at a specific location in the file without reading the entire file into memory. See [File Object](../objects/File.htm) for a list of functions.

## Related

[FileEncoding](FileEncoding.htm), [FileOpen()](FileOpen.htm) / [File Object](../objects/File.htm), [file-reading loop](LoopReadFile.htm), [FileReadLine](FileReadLine.htm), [FileGetSize](FileGetSize.htm), [FileAppend](FileAppend.htm), [IniRead](IniRead.htm), [Sort](Sort.htm), [UrlDownloadToFile](URLDownloadToFile.htm)

## Examples

Reads a text file into _OutputVar_.

```
FileRead, OutputVar, C:\My Documents\My File.txt
```

Quickly sorts the contents of a file.

```
FileRead, Contents, C:\Address List.txt
if not ErrorLevel  <em>; Successfully loaded.</em>
{
    <a href="Sort.htm" data-index="39">Sort</a>, Contents
    FileDelete, C:\Address List (alphabetical).txt
    FileAppend, %Contents%, C:\Address List (alphabetical).txt
    Contents := ""  <em>; Free the memory.</em>
}
```

