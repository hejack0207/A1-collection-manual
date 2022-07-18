# FileOpen() [AHK\_L 42+]

Opens a file to read specific content from it and/or to write new content into it.

```
file := <span class="func">FileOpen</span>(Filename, Flags <span class="optional">, Encoding</span>)
```

## Parameters

Filename

The path of the file to open, which is assumed to be in [A\_WorkingDir](../Variables.htm#WorkingDir) if an absolute path isn't specified.

[v1.1.17+]: Specify an asterisk (or two) as shown below to open the standard input/output/error stream:

```
FileOpen("*", "r")   <em>; for stdin</em>
FileOpen("*", "w")   <em>; for stdout</em>
FileOpen("**", "w")  <em>; for stderr</em>
```

Flags

Either [in AHK\_L 54+] a string of characters indicating the desired access mode followed by other options (with optional spaces or tabs in between); or [in AHK\_L 42+] a combination (sum) of numeric flags. Supported values are described in the tables below.

Encoding

The code page to use for text I/O if the file does not contain a UTF-8 or UTF-16 [byte order mark](https://en.wikipedia.org/wiki/Byte_order_mark), or if the `h` (handle) flag is used. If omitted, the current value of [A\_FileEncoding](../Variables.htm#FileEncoding) is used.

## Flags

### Access modes (mutually-exclusive)

FlagDecHexDescriptionr00x0_Read:_ Fails if the file doesn't exist.w10x1_Write:_ Creates a new file, **overwriting any existing file**.a20x2_Append:_ Creates a new file if the file didn't exist, otherwise moves the file pointer to the end of the file.rw30x3_Read/Write:_ Creates a new file if the file didn't exist.hIndicates that _Filename_ is a file handle to wrap in an object. Sharing mode flags are ignored and the file or stream represented by the handle is not checked for a byte order mark. The file handle is **not** closed automatically when the file object is destroyed and calling [Close](../objects/File.htm#Close) has no effect. Note that [Seek](../objects/File.htm#Seek), [Tell](../objects/File.htm#Tell) and [Length](../objects/File.htm#Length) should not be used if _Filename_ is a handle to a nonseeking device such as a pipe or a communications device.

### Sharing mode flags

FlagDecHexDescription-rwdLocks the file for read, write and/or delete access. Any combination of `r`, `w` and `d` may be used. Specifying `-` is the same as specifying `-rwd`. If omitted entirely, the default is to share all access.00x0If _Flags_ is numeric, the absence of sharing mode flags causes the file to be locked.2560x100Shares _read_ access.5120x200Shares _write_ access.10240x400Shares _delete_ access.

### End of line (EOL) options

FlagDecHexDescription\`n40x4Replace `` `r`n`` with `` `n`` when reading and `` `n`` with `` `r`n`` when writing.\`r80x8Replace standalone `` `r`` with `` `n`` when reading.

## Return Value

If the file is opened successfully, the return value is a [File object](../objects/File.htm).

If the function fails, the return value is 0 and [in AHK\_L 54+] [A\_LastError](../Variables.htm#LastError) contains an error code.

Use `if file` or `IsObject(file)` to check if the function succeeded.

## Remarks

When a UTF-8 or UTF-16 file is created, a byte order mark is written to the file **unless** _Encoding_ (or [A\_FileEncoding](FileEncoding.htm) if _Encoding_ is omitted) contains `UTF-8-RAW` or `UTF-16-RAW`.

When a file containing a UTF-8 or UTF-16 byte order mark (BOM) is opened with read access, the BOM is excluded from the output by positioning the file pointer after it. Therefore, `File.Position` may report 3 or 2 immediately after opening the file.

## Related

[FileEncoding](FileEncoding.htm), [File Object](../objects/File.htm), [FileRead](FileRead.htm)

## Examples

Writes some text to a file then reads it back into memory (it provides the same functionality as [this DllCall example](DllCall.htm#file)).

```
FileSelectFile, FileName, S16,, Create a new file:
if (FileName = "")
    return
file := FileOpen(FileName, "w")
if !IsObject(file)
{
    MsgBox Can't open "%FileName%" for writing.
    return
}
TestString := "This is a test string.`r`n"  <em>; When writing a file this way, use `r`n rather than `n to start a new line.</em>
file.Write(TestString)
file.Close()

<em>; Now that the file was written, read its contents back into memory.</em>
file := FileOpen(FileName, "r-d") <em>; read the file ("r"), share all access except for delete ("-d")</em>
if !IsObject(file)
{
    MsgBox Can't open "%FileName%" for reading.
    return
}
CharsToRead := StrLen(TestString)
TestString := file.Read(CharsToRead)
file.Close()
MsgBox The following string was read from the file: %TestString%
```

Opens the script in read-only mode and read its first line.

```
file := FileOpen(A_ScriptFullPath, "r")
MsgBox % file.ReadLine()
```

Demonstrates the usage of the standard input/output streams.

```
<em>; Open a console window for this demonstration:</em>
DllCall("AllocConsole")
<em>; Open the application's stdin/stdout streams in newline-translated mode.</em>
stdin  := FileOpen("*", "r `n")  <em>; Requires <span class="ver">[v1.1.17+]</span></em>
stdout := FileOpen("*", "w `n")
<em>; For older versions:
;   stdin  := FileOpen(DllCall("GetStdHandle", "int", -10, "ptr"), "h `n")
;   stdout := FileOpen(DllCall("GetStdHandle", "int", -11, "ptr"), "h `n")</em>
stdout.Write("Enter your query.`n\> ")
stdout.Read(0) <em>; Flush the write buffer.</em>
query := RTrim(stdin.ReadLine(), "`n")
stdout.WriteLine("Your query was '" query "'. Have a nice day.")
stdout.Read(0) <em>; Flush the write buffer.</em>
Sleep 5000

```

