# FileEncoding [AHK\_L 42+]

Sets the default encoding for [FileRead](FileRead.htm), [FileReadLine](FileReadLine.htm), [Loop Read](LoopReadFile.htm), [FileAppend](FileAppend.htm), and [FileOpen()](FileOpen.htm).

```
<span class="func">FileEncoding</span> <span class="optional">, Encoding</span>
```

## Parameters

Encoding

One of the following values (if omitted, it defaults to the system default ANSI code page, which is also the default setting):

**UTF-8:** Unicode UTF-8, equivalent to CP65001.

**UTF-8-RAW:** As above, but no byte order mark is written when a new file is created.

**UTF-16:** Unicode UTF-16 with little endian byte order, equivalent to CP1200.

**UTF-16-RAW:** As above, but no byte order mark is written when a new file is created.

**CP _nnn_:** A code page with numeric identifier _nnn_. See [Code Page Identifiers](http://msdn.microsoft.com/en-us/library/dd317756.aspx).

## Remarks

`A_FileEncoding` contains the current setting.

Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

The default encoding is not used if a UTF-8 or UTF-16 byte order mark is present in the file, unless the file is being opened with write-only access (i.e. the previous contents of the file are being discarded).

## Related

[FileOpen()](FileOpen.htm), [StrGet()](StrGet.htm), [StrPut()](StrPut.htm), [Script Compatibility](../Compat.htm#FileRead)

