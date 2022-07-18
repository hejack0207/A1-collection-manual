# IniDelete

Deletes a value from a standard format .ini file.

```
<span class="func">IniDelete</span>, Filename, Section <span class="optional">, Key</span>
```

## Parameters

Filename

The name of the .ini file, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

Section

The section name in the .ini file, which is the heading phrase that appears in square brackets (do not include the brackets in this parameter).

Key

The key name in the .ini file. **If omitted, the entire _Section_ will be deleted.**

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

A standard ini file looks like:

```
[SectionName]
Key=Value
```

## Related

[IniRead](IniRead.htm), [IniWrite](IniWrite.htm), [RegDelete](RegDelete.htm)

## Examples

Deletes a key and its value located in section2 from a standard format .ini file.

```
IniDelete, C:\Temp\myfile.ini, section2, key
```

