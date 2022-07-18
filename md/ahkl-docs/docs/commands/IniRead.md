# IniRead

Reads a value, section or list of section names from a standard format .ini file.

```
<span class="func">IniRead</span>, OutputVar, Filename, Section, Key <span class="optional">, Default</span>
<span class="func">IniRead</span>, OutputVarSection, Filename, Section
<span class="func">IniRead</span>, OutputVarSectionNames, Filename

```

## Parameters

OutputVar

The name of the variable in which to store the retrieved value. If the value cannot be retrieved, the variable is set to the value indicated by the _Default_ parameter (described below).

OutputVarSection

[AHK\_L 57+]: Omit the _Key_ parameter to read an entire section. Comments and empty lines are omitted. Only the first 65,533 characters of the section are retrieved.

OutputVarSectionNames

[AHK\_L 57+]: Omit the _Key_ and _Section_ parameters to retrieve a linefeed ( `` `n``) delimited list of section names.

Filename

The name of the .ini file, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

Section

The section name in the .ini file, which is the heading phrase that appears in square brackets (do not include the brackets in this parameter).

Key

The key name in the .ini file.

Default

The value to store in _OutputVar_ if the requested key is not found. If omitted, it defaults to the word ERROR. To store a blank value (empty string), specify [%A\_Space%](../Variables.htm#Space).

[AHK\_L 57+]: This parameter is not used if _Key_ is omitted.

## Error Handling

[ErrorLevel](../misc/ErrorLevel.htm) is **not** set by this command. If there was a problem, _OutputVar_ will be set to the _Default_ value as described above.

## Remarks

The operating system automatically omits leading and trailing spaces/tabs from the retrieved string. To prevent this, enclose the string in single or double quote marks. The outermost set of single or double quote marks is also omitted, but any spaces inside the quote marks are preserved.

Values longer than 65,535 characters are likely to yield inconsistent results.

A standard ini file looks like:

```
[SectionName]
Key=Value
```

**Unicode:** IniRead and IniWrite rely on the external functions [GetPrivateProfileString](http://msdn.microsoft.com/en-us/library/ms724353.aspx) and [WritePrivateProfileString](http://msdn.microsoft.com/en-us/library/ms725501.aspx) to read and write values. These functions support Unicode only in UTF-16 files; all other files are assumed to use the system's default ANSI code page.

## Related

[IniDelete](IniDelete.htm), [IniWrite](IniWrite.htm), [RegRead](RegRead.htm), [file-reading loop](LoopReadFile.htm), [FileRead](FileRead.htm)

## Examples

Reads the value of a key located in section2 from a standard format .ini file and stores it in OutputVar.

```
IniRead, OutputVar, C:\Temp\myfile.ini, section2, key
MsgBox, The value is %OutputVar%.
```

