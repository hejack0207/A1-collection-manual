# Loop (read file contents)

Retrieves the lines in a text file, one at a time (performs better than [FileReadLine](FileReadLine.htm)).

```
<span class="func">Loop, Read</span>, InputFile <span class="optional">, OutputFile</span>
```

## Parameters

Read

This parameter must be the word READ.

InputFile

The name of the text file whose contents will be read by the loop, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. Windows and Unix formats are supported; that is, the file's lines may end in either carriage return and linefeed (\`r\`n) or just linefeed (\`n).

OutputFile

(Optional) The name of the file to be kept open for the duration of the loop, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

Within the loop's body, use the [FileAppend](FileAppend.htm) command with only one parameter (the text to be written) to append to this special file. Appending to a file in this manner performs better than using [FileAppend](FileAppend.htm) in its 2-parameter mode because the file does not need to be closed and re-opened for each operation. Remember to include a linefeed (\`n) after the text, if desired.

The file is not opened if nothing is ever written to it. This happens if the Loop performs zero iterations or if it never uses the [FileAppend](FileAppend.htm) command.

**End of line (EOL) translation**: To disable EOL translation, prepend an asterisk to the filename. This causes each linefeed character (\`n) to be written as a single linefeed (LF) rather than the Windows standard of CR+LF. For example: `<strong>*</strong>C:\My Unix File.txt`. Even without the asterisk, EOL translation is disabled automatically if the Loop's first use of [FileAppend](FileAppend.htm) writes any carriage return and linefeed pairs (\`r\`n).

**Standard Output (stdout)**: Specifying an asterisk (\*) for _OutputFile_ sends any text written by [FileAppend](FileAppend.htm) to standard output (stdout). Such text can be redirected to a file, piped to another EXE, or captured by [fancy text editors](_ErrorStdOut.htm). However, text sent to stdout will not appear at the command prompt it was launched from. This can be worked around by 1) [v1.1.33+] compiling the script with the [Ahk2Exe ConsoleApp directive](../misc/Ahk2ExeDirectives.htm#ConsoleApp), or 2) piping a script's output to another command or program. See [FileAppend](FileAppend.htm) for more details.

**Escaped Commas**: Unlike the last parameter of most other commands, commas in _OutputFile_ must be escaped (\`,).

## Remarks

A file-reading loop is useful when you want to operate on each line contained in a text file, one at a time. It performs better than using [FileReadLine](FileReadLine.htm) because: 1) the file can be kept open for the entire operation; and 2) the file does not have to be re-scanned each time to find the requested line number.

The built-in variable **A\_LoopReadLine** exists within any file-reading loop. It contains the contents of the current line excluding the carriage return and linefeed (\`r\`n) that marks the end of the line. If an inner file-reading loop is enclosed by an outer file-reading loop, the innermost loop's file-line will take precedence.

Lines up to 65,534 characters long can be read. If the length of a line exceeds this, its remaining characters will be read during the next loop iteration.

[StrSplit()](StrSplit.htm), [StringSplit](StringSplit.htm) or a [parsing loop](LoopParse.htm) is often used inside a file-reading loop to parse the contents of each line retrieved from _InputFile_. For example, if _InputFile_'s lines are each a series of tab-delimited fields, those fields can individually retrieved as in this example:

```
Loop, read, C:\Database Export.txt
{
    Loop, parse, A_LoopReadLine, %A_Tab%
    {
        MsgBox, Field number %A_Index% is %A_LoopField%.
    }
}
```

To load an entire file into a variable, use [FileRead](FileRead.htm) because it performs much better than a loop (especially for large files).

To have multiple files open simultaneously, use [FileOpen()](FileOpen.htm).

See [Loop](Loop.htm) for information about [Blocks](Block.htm), [Break](Break.htm), [Continue](Continue.htm), and the A\_Index variable (which exists in every type of loop).

To control how the file is decoded when no byte order mark is present, use [FileEncoding](FileEncoding.htm).

## Related

[FileEncoding](FileEncoding.htm), [FileOpen()](FileOpen.htm) / [File Object](../objects/File.htm), [FileRead](FileRead.htm), [FileReadLine](FileReadLine.htm), [FileAppend](FileAppend.htm), [Sort](Sort.htm), [Loop](Loop.htm), [Break](Break.htm), [Continue](Continue.htm), [Blocks](Block.htm), [FileSetAttrib](FileSetAttrib.htm), [FileSetTime](FileSetTime.htm)

## Examples

Only those lines of the 1st file that contain the word FAMILY will be written to the 2nd file. Uncomment the first line to overwrite rather than append to any existing file.

```
<em>;FileDelete, C:\Docs\Family Addresses.txt</em>

Loop, read, C:\Docs\Address List.txt, C:\Docs\Family Addresses.txt
{
    if InStr(A_LoopReadLine, "family")
        FileAppend, %A_LoopReadLine%`n
}
```

Retrieves the last line from a text file.

```
Loop, read, C:\Log File.txt
    last_line := A_LoopReadLine  <em>; When loop finishes, this will hold the last line.</em>
```

Attempts to extract all FTP and HTTP URLs from a text or HTML file.

```
FileSelectFile, SourceFile, 3,, Pick a text or HTML file to analyze.
if (SourceFile = "")
    return  <em>; This will exit in this case.</em>

SplitPath, SourceFile,, SourceFilePath,, SourceFileNoExt
DestFile := SourceFilePath "\" SourceFileNoExt " Extracted Links.txt"

if FileExist(DestFile)
{
    MsgBox, 4,, Overwrite the existing links file? Press No to append to it.`n`nFILE: %DestFile%
    IfMsgBox, Yes
        FileDelete, %DestFile%
}

LinkCount := 0
Loop, read, %SourceFile%, %DestFile%
{
    URLSearchString := A_LoopReadLine
    Gosub, URLSearch
}
MsgBox %LinkCount% links were found and written to "%DestFile%".
return

URLSearch:
<em>; It's done this particular way because some URLs have other URLs embedded inside them:</em>
URLStart1 := InStr(URLSearchString, "https://")
URLStart2 := InStr(URLSearchString, "http://")
URLStart3 := InStr(URLSearchString, "ftp://")
URLStart4 := InStr(URLSearchString, "www.")

<em>; Find the left-most starting position:</em>
URLStart := URLStart1  <em>; Set starting default.</em>
Loop
{
    <em>; It helps performance (at least in a script with many variables) to resolve</em>
    <em>; "URLStart%A_Index%" only once:</em>
    ArrayElement := URLStart%A_Index%
    if (ArrayElement = "")  <em>; End of the <a href="../misc/Arrays.htm#pseudo" data-index="39">pseudo-array</a> has been reached.</em>
        break
    if (ArrayElement = 0)  <em>; This element is disqualified.</em>
        continue
    if (URLStart = 0)
        URLStart := ArrayElement
    else <em>; URLStart has a valid position in it, so compare it with ArrayElement.</em>
    {
        if (ArrayElement != 0)
            if (ArrayElement < URLStart)
                URLStart := ArrayElement
    }
}

if (URLStart = 0)  <em>; No URLs exist in URLSearchString.</em>
    return

<em>; Otherwise, extract this URL:</em>
URL := SubStr(URLSearchString, URLStart)  <em>; Omit the beginning/irrelevant part.</em>
Loop, parse, URL, %A_Tab%%A_Space%<>  <em>; Find the first space, tab, or angle (if any).</em>
{
    URL := A_LoopField
    break  <em>; i.e. perform only one loop iteration to fetch the first "field".</em>
}
<em>; If the above loop had zero iterations because there were no ending characters found,
; leave the contents of the URL var untouched.</em>

<em>; If the URL ends in a double quote, remove it.  For now, StringReplace is used, but
; note that it seems that double quotes can legitimately exist inside URLs, so this
; might damage them:</em>
StringReplace, URLCleansed, URL, ",, All
FileAppend, %URLCleansed%`n
LinkCount += 1

<em>; See if there are any other URLs in this line:</em>
CharactersToOmit := StrLen(URL)
CharactersToOmit += URLStart
URLSearchString := SubStr(URLSearchString, CharactersToOmit)
Gosub, URLSearch  <em>; Recursive call to self.</em>
return
```

