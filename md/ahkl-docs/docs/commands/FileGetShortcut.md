# FileGetShortcut

Retrieves information about a shortcut (.lnk) file, such as its target file.

```
<span class="func">FileGetShortcut</span>, LinkFile <span class="optional">, OutTarget, OutDir, OutArgs, OutDescription, OutIcon, OutIconNum, OutRunState</span>
```

## Parameters

LinkFile

Name of the shortcut file to be analyzed, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. Be sure to include the **.lnk** extension.

OutTarget

Name of the variable in which to store the shortcut's target (not including any arguments it might have). For example: C:\\WINDOWS\\system32\\notepad.exe

OutDir

Name of the variable in which to store the shortcut's working directory. For example: C:\\My Documents. If environment variables such as %WinDir% are present in the string, one way to resolve them is via [StrReplace()](StrReplace.htm) or [StringReplace](StringReplace.htm). For example: ``StringReplace, OutDir, OutDir, `%WinDir`%, %<a href="../Variables.htm#WinDir" data-index="4">A_WinDir</a>%``.

OutArgs

Name of the variable in which to store the shortcut's parameters (blank if none).

OutDescription

Name of the variable in which to store the shortcut's comments (blank if none).

OutIcon

Name of the variable in which to store the filename of the shortcut's icon (blank if none).

OutIconNum

Name of the variable in which to store the shortcut's icon number within the icon file (blank if none). This value is most often 1, which means the first icon.

OutRunState

Name of the variable in which to store the shortcut's initial launch state, which is one of the following digits:

- 1 = Normal
- 3 = Maximized
- 7 = Minimized

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

If there was a problem -- such as _LinkFile_ not existing -- all the output variables are made blank and [ErrorLevel](../misc/ErrorLevel.htm) is set to 1. Otherwise, ErrorLevel is set to 0.

## Remarks

Any of the output variables may be omitted if the corresponding information is not needed.

## Related

[FileCreateShortcut](FileCreateShortcut.htm), [SplitPath](SplitPath.htm)

## Examples

Allows the user to select an .lnk file to show its information.

```
FileSelectFile, file, 32,, Pick a shortcut to analyze., Shortcuts (*.lnk)
if file =
    return
FileGetShortcut, %file%, OutTarget, OutDir, OutArgs, OutDesc, OutIcon, OutIconNum, OutRunState
MsgBox %OutTarget%`n%OutDir%`n%OutArgs%`n%OutDesc%`n%OutIcon%`n%OutIconNum%`n%OutRunState%
```

