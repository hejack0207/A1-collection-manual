# FileCreateShortcut

Creates a shortcut (.lnk) file.

```
<span class="func">FileCreateShortcut</span>, Target, LinkFile <span class="optional">, WorkingDir, Args, Description, IconFile, ShortcutKey, IconNumber, RunState</span>
```

## Parameters

Target

Name of the file that the shortcut refers to, which should include an absolute path unless the file is integrated with the system (e.g. Notepad.exe). The file does not have to exist at the time the shortcut is created; however, if it does not, some systems might [alter the path in unexpected ways](https://devblogs.microsoft.com/oldnewthing/20180509-00/?p=98715).

LinkFile

Name of the shortcut file to be created, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified. Be sure to include the **.lnk** extension. The destination directory must already exist. If the file already exists, it will be overwritten.

WorkingDir

Directory that will become _Target's_ current working directory when the shortcut is launched. If blank or omitted, the shortcut will have a blank "Start in" field and the system will provide a default working directory when the shortcut is launched.

Args

Parameters that will be passed to _Target_ when it is launched. Separate parameters with spaces. If a parameter contains spaces, enclose it in double quotes.

Description

Comments that describe the shortcut (used by the OS to display a tooltip, etc.)

IconFile

The full path and name of the icon to be displayed for _LinkFile_. It must either be an ico file or the very first icon of an EXE or DLL.

ShortcutKey

A single letter, number, or the name of a single key from the [key list](../KeyList.htm) (mouse buttons and other non-standard keys might not be supported). **Do not** include modifier symbols. Currently, all shortcut keys are created as Ctrl+Alt shortcuts. For example, if the letter B is specified for this parameter, the shortcut key will be Ctrl+Alt+B.

IconNumber

To use an icon in _IconFile_ other than the first, specify that number here (can be an [expression](../Variables.htm#Expressions)). For example, 2 is the second icon.

RunState

Launch _Target_ minimized or maximized. If blank or omitted, it defaults to 1 (normal). Otherwise, specify one of the following digits:

- 1 = Normal
- 3 = Maximized
- 7 = Minimized

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

_Target_ might not need to include a path if the target file resides in one of the folders listed in the system's PATH environment variable.

The _ShortcutKey_ of a newly created shortcut will have no effect unless the shortcut file resides on the desktop or somewhere in the Start Menu. If the _ShortcutKey_ you choose is already in use, your new shortcut takes precedence.

An alternative way to create a shortcut to a URL is the following example, which creates a special URL shortcut. Change the first two parameters to suit your preferences:

```
<a href="IniWrite.htm" data-index="7">IniWrite</a>, https://www.google.com, C:\My Shortcut.url, InternetShortcut, URL
```

The following may be optionally added to assign an icon to the above:

```
<a href="IniWrite.htm" data-index="8">IniWrite</a>, <IconFile>, C:\My Shortcut.url, InternetShortcut, IconFile
<a href="IniWrite.htm" data-index="9">IniWrite</a>, 0, C:\My Shortcut.url, InternetShortcut, IconIndex
```

In the above, replace 0 with the index of the icon (0 is used for the first icon) and replace <IconFile> with a URL, EXE, DLL, or ICO file. Examples: C:\\Icons.dll, C:\\App.exe, https://www.somedomain.com/ShortcutIcon.ico

The operating system will treat a .URL file created by the above as a real shortcut even though it is a plain text file rather than a .LNK file.

## Related

[FileGetShortcut](FileGetShortcut.htm), [FileAppend](FileAppend.htm)

## Examples

The letter "i" in the last parameter makes the shortcut key be Ctrl+Alt+I.

```
FileCreateShortcut, Notepad.exe, %A_Desktop%\My Shortcut.lnk, C:\, "%A_ScriptFullPath%", My Description, C:\My Icon.ico, i
```

