# File Object [AHK\_L 42+]

Provides an interface for file input/output. [FileOpen()](../commands/FileOpen.htm) returns an object of this type.

## Table of Contents

- [Methods](#Methods):

  - [Read](#Read): Reads a string of characters from the file and advances the file pointer.
  - [Write](#Write): Writes a string of characters to the file and advances the file pointer.
  - [ReadLine](#ReadLine): Reads a line of text from the file and advances the file pointer.
  - [WriteLine](#WriteLine): Writes a string of characters followed by `` `n`` or `` `r`n`` depending on the flags used to open the file. Advances the file pointer.
  - [Read _NumType_](#ReadNum): Reads a number from the file and advances the file pointer.
  - [Write _NumType_](#WriteNum): Writes a number to the file and advances the file pointer.
  - [RawRead](#RawRead): Reads raw binary data from the file into memory and advances the file pointer.
  - [RawWrite](#RawWrite): Writes raw binary data to the file and advances the file pointer.
  - [Seek](#Seek): Moves the file pointer. If the second parameter is omitted, it is equivalent to `File.Pos := Distance`.
  - [Tell](#Tell): Returns the position of the file pointer. Equivalent to `Pos := File.Pos`.
  - [Close](#Close): Closes the file, flushes any data in the cache to disk and releases the share locks.
- [Properties](#Properties):

  - [Position / Pos](#Seek): Retrieves or sets the position of the file pointer. Equivalent to `Pos := File.Tell()` or `File.Seek(Distance)`.
  - [Length](#Length): Retrieves or sets the size of the file.
  - [AtEOF](#AtEOF): Retrieves a non-zero value if the file pointer has reached the end of the file.
  - [Encoding](#Encoding): Retrieves or sets the text encoding used by this file object.
  - [\_\_Handle](#Handle): Retrieves a system file handle, intended for use with DllCall().

## Methods

### Read

Reads a string of characters from the file and advances the file pointer.

```
String := File.<span class="func">Read</span>(<span class="optional">Characters</span>)
```

CharactersThe maximum number of characters to read. If omitted, the rest of the file is read and returned as one string. If the File object was created from a handle to a non-seeking device such as a console buffer or pipe, omitting this parameter may cause the method to fail or return only what data is currently available.

Returns a string.

### Write

Writes a string of characters to the file and advances the file pointer.

```
File.<span class="func">Write</span>(String)
```

StringA string to write.

Returns the number of bytes (not characters) that were written.

### ReadLine

Reads a line of text from the file and advances the file pointer.

```
TextLine := File.<span class="func">ReadLine</span>()
```

Returns a line of text. This may include `` `n``, `` `r`n`` or `` `r`` depending on the file and EOL flags used to open the file.

Lines up to 65,534 characters long can be read. If the length of a line exceeds this, the remainder of the line is returned by subsequent calls to this method.

### WriteLine

Writes a string of characters followed by `` `n`` or `` `r`n`` depending on the flags used to open the file. Advances the file pointer.

```
File.<span class="func">WriteLine</span>(<span class="optional">String</span>)
```

StringAn optional string to write.

Returns the number of bytes (not characters) that were written.

### Read _NumType_

Reads a number from the file and advances the file pointer.

```
Num := File.Read<i>NumType</i>()
```

_NumType_ is either UInt, Int, Int64, Short, UShort, Char, UChar, Double, or Float. These type names have the same meanings as with [DllCall()](../commands/DllCall.htm#types).

Returns a number if successful, otherwise an empty string.

If a Try statement is active and no bytes were read, an exception is thrown. However, no exception is thrown if at least one byte was read, even if the size of the given _NumType_ is greater than the number of bytes read. Instead, the missing bytes are assumed to be zero.

### Write _NumType_

Writes a number to the file and advances the file pointer.

```
File.Write<i>NumType</i>(Num)
```

NumA number to write.

_NumType_ is either UInt, Int, Int64, Short, UShort, Char, UChar, Double, or Float. These type names have the same meanings as with [DllCall()](../commands/DllCall.htm#types).

Returns the number of bytes that were written. For instance, WriteUInt returns 4 if successful.

### RawRead

Reads raw binary data from the file into memory and advances the file pointer.

```
File.<span class="func">RawRead</span>(VarOrAddress, Bytes)
```

VarOrAddressA variable or memory address to which the data will be copied. Usage is similar to [NumGet()](../commands/NumGet.htm). If a variable is specified, it is expanded automatically when necessary.BytesThe maximum number of bytes to read.

Returns the number of bytes that were read.

If a Try statement is active and _Bytes_ is non-zero but no bytes were read, an exception is thrown. [AtEOF](#AtEOF) can be used to avoid this, if needed.

### RawWrite

Writes raw binary data to the file and advances the file pointer.

```
File.<span class="func">RawWrite</span>(VarOrAddress, Bytes)
```

VarOrAddressA variable containing the data or the address of the data in memory. Usage is similar to [NumPut()](../commands/NumPut.htm).BytesThe number of bytes to write.

Returns the number of bytes that were written.

### Seek

Moves the file pointer.

```
File.<span class="func">Seek</span>(Distance <span class="optional">, Origin := 0</span>)
File.Position := Distance
File.Pos := Distance

```

DistanceDistance to move, in bytes. Lower values are closer to the beginning of the file.Origin

Starting point for the file pointer move. Must be one of the following:

- 0 (SEEK\_SET): Beginning of the file._Distance_ must be zero or greater.
- 1 (SEEK\_CUR): Current position of the file pointer.
- 2 (SEEK\_END): End of the file._Distance_ should usually be negative.

If omitted, _Origin_ defaults to SEEK\_END when _Distance_ is negative and SEEK\_SET otherwise.

Returns a non-zero value if successful, otherwise zero.

### Tell

Returns the current position of the file pointer, where 0 is the beginning of the file.

```
Pos := File.<span class="func">Tell</span>()
Pos := File.Position
Pos := File.Pos

```

### Close

Closes the file, flushes any data in the cache to disk and releases the share locks.

```
File.<span class="func">Close</span>()
```

Although the file is closed automatically when the object is freed, it is recommended to close the file as soon as possible.

## Properties

### Length

Retrieves or sets the size of the file.

```
FileSize := File.Length
```

```
File.Length := NewSize
```

_FileSize_ and _NewSize_ is the size of the file, in bytes.

This property should be used only with an actual file. If the File object was created from a handle to a pipe, it may return the amount of data currently available in the pipe's internal buffer, but this behaviour is not guaranteed.

### AtEOF

Retrieves a non-zero value if the file pointer has reached the end of the file, otherwise zero.

```
IsAtEOF := File.AtEOF
```

This property should be used only with an actual file. If the File object was created from a handle to a non-seeking device such as a console buffer or pipe, the returned value may not be meaningful, as such devices do not logically have an "end of file".

### Encoding

Retrieves or sets the text encoding used by this file object.

```
RetrievedEncoding := File.Encoding
```

```
File.Encoding := NewEncoding
```

_RetrievedEncoding_ and _NewEncoding_ is a numeric code page identifier (see [MSDN](http://msdn.microsoft.com/en-us/library/dd317756.aspx)) or one of the following strings:

- `UTF-8`: Unicode UTF-8, equivalent to CP65001.
- `UTF-16`: Unicode UTF-16 with little endian byte order, equivalent to CP1200.
- `CP<i>nnn</i>`: a code page with numeric identifier _nnn_.

_RetrievedEncoding_ is never a value with the `-RAW` suffix, regardless of how the file was opened or whether it contains a byte order mark (BOM). Setting _NewEncoding_ never causes a BOM to be added or removed, as the BOM is normally written to the file when it is first created.

[v1.1.15.04+]: Setting _NewEncoding_ to `UTF-8-RAW` or `UTF-16-RAW` is valid, but the `-RAW` suffix is ignored. In earlier versions, `UTF-8-RAW` and `UTF-16-RAW` behaved like an invalid 8-bit encoding, causing all non-ASCII characters to be discarded. This only applies to `File.Encoding`, not [FileOpen()](../commands/FileOpen.htm).

### \_\_Handle

Returns a system file handle, intended for use with DllCall(). See [CreateFile](http://msdn.microsoft.com/en-us/library/aa363858.aspx).

```
File.__Handle
```

File objects internally buffer reads or writes. If data has been written into the object's internal buffer, it is committed to disk before the handle is returned. If the buffer contains data read from file, it is discarded and the actual file pointer is reset to the logical position indicated by `File.Pos`.

