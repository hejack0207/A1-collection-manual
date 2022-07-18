# IniWrite

Writes a value or section to a standard format .ini file.

```
<span class="func">IniWrite</span>, Value, Filename, Section, Key
<span class="func">IniWrite</span>, Pairs, Filename, Section

```

## Parameters

Value

The string or number that will be written to the right of _Key_'s equal sign (=).

If the text is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

Pairs

[AHK\_L 57+]: The complete content of a section to write to the .ini file, excluding the [SectionName] header. _Key_ must be omitted. _Pairs_ must not contain any blank lines. If the section already exists, everything up to the last key=value pair is overwritten. _Pairs_ can contain lines without an equal sign (=), but this may produce inconsistent results. Comments can be written to the file but are stripped out when they are read back by [IniRead](IniRead.htm).

Filename

The name of the .ini file, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

Section

The section name in the .ini file, which is the heading phrase that appears in square brackets (do not include the brackets in this parameter).

Key

The key name in the .ini file.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

Values longer than 65,535 characters can be written to the file, but may produce inconsistent results as they usually cannot be read correctly by [IniRead](IniRead.htm) or other applications.

A standard ini file looks like:

```
[SectionName]
Key=Value
```

New files are created in either the system's default ANSI code page or UTF-16, depending on [the version of AutoHotkey](../Variables.htm#IsUnicode).

**Unicode:** IniRead and IniWrite rely on the external functions [GetPrivateProfileString](http://msdn.microsoft.com/en-us/library/ms724353.aspx) and [WritePrivateProfileString](http://msdn.microsoft.com/en-us/library/ms725501.aspx) to read and write values. These functions support Unicode only in UTF-16 files; all other files are assumed to use the system's default ANSI code page. In [Unicode scripts](../Variables.htm#IsUnicode), IniWrite uses UTF-16 for each new file. If this is undesired, ensure the file exists before calling IniWrite. For example:

```
FileAppend,, NonUnicode.ini, CP0 <em>; The last parameter is optional in most cases.</em>
```

## Related

[IniDelete](IniDelete.htm), [IniRead](IniRead.htm), [RegWrite](RegWrite.htm)

## Examples

Writes a value to a key located in section2 of a standard format .ini file.

```
IniWrite, this is a new value, C:\Temp\myfile.ini, section2, key
```

