# FileAppend

Writes text to the end of a file (first creating the file, if necessary).

```
<span class="func">FileAppend</span> <span class="optional">, Text, Filename, Encoding</span>
```

## Parameters

Text

The text to append to the file. This text may include linefeed characters (\`n) to start new lines. In addition, a single long line can be broken up into several shorter ones by means of a [continuation section](../Scripts.htm#continuation).

If _Text_ is blank, _Filename_ will be created as an empty file (but if the file already exists, its modification time will be updated).

If _Text_ is [%ClipboardAll%](../misc/Clipboard.htm#ClipboardAll) or a variable that was previously assigned the value of ClipboardAll, _Filename_ will be unconditionally overwritten with the entire contents of the clipboard (i.e. [FileDelete](FileDelete.htm) is not necessary).

Filename

The name of the file to be appended, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. The destination directory must already exist.

**End of line (EOL) translation**: To disable EOL translation, prepend an asterisk to the filename. This causes each linefeed character (\`n) to be written as a single linefeed (LF) rather than the Windows standard of CR+LF. For example: `*C:\My Unix File.txt`.

If the file is not already open (due to being inside a [file-reading loop](LoopReadFile.htm)), EOL translation is automatically disabled if _Text_ contains any carriage return and linefeed pairs (\`r\`n). In other words, the asterisk option described in the previous paragraph is put into effect automatically. However, specifying the asterisk when _Text_ contains \`r\`n improves performance because the program does not need to scan _Text_ for \`r\`n.

**Standard Output (stdout)**: Specifying an asterisk (\*) for _Filename_ causes _Text_ to be sent to standard output (stdout). Such text can be redirected to a file, piped to another EXE, or captured by [fancy text editors](_ErrorStdOut.htm). For example, the following would be valid if typed at a command prompt:

```
"%ProgramFiles%\AutoHotkey\AutoHotkey.exe" "My Script.ahk" >"Error Log.txt"
```

However, text sent to stdout will not appear at the command prompt it was launched from. This can be worked around by 1) [v1.1.33+] compiling the script with the [Ahk2Exe ConsoleApp directive](../misc/Ahk2ExeDirectives.htm#ConsoleApp), or 2) piping a script's output to another command or program. For example:

```
"%ProgramFiles%\AutoHotkey\AutoHotkey.exe" "My Script.ahk" |more
```

```
For /F "tokens=*" %L in ('""%ProgramFiles%\AutoHotkey\AutoHotkey.exe" "My Script .ahk""') do @Echo %L
```

[v1.1.20+]: Specifying two asterisks (\*\*) for _Filename_ causes _Text_ to be sent to the standard error stream (stderr).

Encoding

[AHK\_L 42+]: Overrides the default encoding set by [FileEncoding](FileEncoding.htm), where _Encoding_ follows the same format.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

[A\_LastError](../Variables.htm#LastError) is set to the result of the operating system's GetLastError() function.

## Remarks

To overwrite an existing file, delete it with [FileDelete](FileDelete.htm) prior to using FileAppend.

The target file is automatically closed after the text is appended (except when FileAppend is used in its single-parameter mode inside a [file-reading/writing loop](LoopReadFile.htm)).

[AHK\_L 42+]: [FileOpen()](FileOpen.htm) in append mode provides more control than FileAppend and allows the file to be kept open rather than opening and closing it each time. Once a file is opened in append mode, use `file.<a href="../objects/File.htm#Write" data-index="15">Write</a>(string)` to append the string. File objects also support binary I/O via [RawWrite](../objects/File.htm#RawWrite)/ [RawRead](../objects/File.htm#RawRead) or [Write _Num_](../objects/File.htm#WriteNum)/ [Read _Num_](../objects/File.htm#ReadNum), whereas FileAppend supports only text.

## Related

[FileOpen()](FileOpen.htm) / [File Object](../objects/File.htm), [FileRead](FileRead.htm), [file-reading loop](LoopReadFile.htm), [FileReadLine](FileReadLine.htm), [IniWrite](IniWrite.htm), [FileDelete](FileDelete.htm), [OutputDebug](OutputDebug.htm), [continuation sections](../Scripts.htm#continuation)

## Examples

Creates a file, if necessary, and appends a line.

```
FileAppend, Another line.`n, C:\My Documents\Test.txt
```

Use a [continuation section](../Scripts.htm#continuation) to enhance readability and maintainability.

```
FileAppend,
(
A line of text.
By default, the hard carriage return (Enter) between the previous line and this one will be written to the file.
    This line is indented with a tab; by default, that tab will also be written to the file.
Variable references such as %Var% are expanded by default.
), C:\My File.txt
```

Demonstrates how to automate FTP uploading using the operating system's built-in FTP command. This script has been tested on Windows XP.

```
FTPCommandFile := A_ScriptDir "\FTPCommands.txt"
FTPLogFile := A_ScriptDir "\FTPLog.txt"
FileDelete %FTPCommandFile%  <em>; In case previous run was terminated prematurely.</em>

FileAppend,  <em>; The comma is required in this case.</em>
(
open host.domain.com
username
password
binary
cd htdocs
put %VarContainingNameOfTargetFile%
delete SomeOtherFile.htm
rename OldFileName.htm NewFileName.htm
ls -l
quit
), %FTPCommandFile%

RunWait %ComSpec% /c ftp.exe -s:"%FTPCommandFile%" >"%FTPLogFile%"
FileDelete %FTPCommandFile%  <em>; Delete for security reasons.</em>
Run %FTPLogFile%  <em>; Display the log for review.</em>
```

