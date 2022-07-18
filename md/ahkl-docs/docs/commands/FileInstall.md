# FileInstall

Includes the specified file inside the [compiled version](../Scripts.htm#ahk2exe) of the script.

```
<span class="func">FileInstall</span>, Source, Dest <span class="optional">, Overwrite</span>
```

## Parameters

Source

The name of the file to be added to the compiled EXE. The file is assumed to be in (or relative to) the script's own directory if an absolute path isn't specified.

The file name **must not** contain double quotes, variable references (e.g. %A\_ProgramFiles%), or wildcards. In addition, any special characters such as literal percent signs and commas must be [escaped](../misc/EscapeChar.htm) (just like in the parameters of all other commands). Finally, this parameter must be listed to the right of the FileInstall command (that is, not on a [continuation line](../Scripts.htm#continuation) beneath it).

Dest

When _Source_ is extracted from the EXE, this is the name of the file to be created. It is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. The destination directory must already exist. Unlike _Source_, variable references may be used.

Overwrite

This parameter determines whether to overwrite files if they already exist. If this parameter is 1 (true), the command overwrites existing files. If omitted or 0 (false), the command does not overwrite existing files.

This parameter can be an [expression](../Variables.htm#Expressions), even one that evalutes to true or false (since true and false are stored internally as 1 and 0).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 on failure or 0 on success.

Any case where the file cannot be written to the destination is considered failure. For example:

- The destination file already exists and the_Overwrite_ parameter was 0 (false) or omitted.
- The destination file could not be opened due to a permission error, or because the file is in use.
- The destination path was invalid or specifies a folder which does not exist.
- The source file does not exist (only for uncompiled scripts).
- Source and destination are the same location (only for uncompiled scripts).

## Remarks

When this command is read by [Ahk2Exe](../Scripts.htm#ahk2exe) during compilation of the script, the file specified by _Source_ is added to the resulting compiled script. Later, when the compiled script EXE runs and the call to FileInstall is executed, the file is extracted from the EXE and written to the location specified by _Dest_.

Files added to a script are neither compressed nor encrypted during compilation, but the compiled script EXE can be compressed by using the appropriate option in Ahk2Exe.

If this command is used in a normal (uncompiled) script, a simple file copy will be performed instead -- this helps the testing of scripts that will eventually be compiled.

## Related

[FileCopy](FileCopy.htm), [#Include](_Include.htm)

## Examples

Includes a text file inside the compiled version of the script. Later, when the compiled script is executed, the included file is extracted to another location with another name. If a file with this name already exists at this location, it will be overwritten.

```
FileInstall, My File.txt, %A_Desktop%\Example File.txt, 1
```

