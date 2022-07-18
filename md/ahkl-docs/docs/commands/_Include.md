# \#Include / \#IncludeAgain

Causes the script to behave as though the specified file's contents are present at this exact position.

```
<span class="func">#Include</span> FileOrDirName
<span class="func">#Include</span> <LibName>
<span class="func">#IncludeAgain</span> FileOrDirName

```

## Parameters

FileOrDirName

The path of a file or directory as explained below. This **must not** contain double quotes, wildcards, or references to non-built-in variables. [Escape sequences](../misc/EscapeChar.htm) other than semicolon ( **\`;**) must not be used, nor are they needed because characters such as percent signs are treated literally.

Percent signs which are not part of a valid variable reference are interpreted literally. All built-in variables are valid, except for [ErrorLevel](../misc/ErrorLevel.htm), [A\_Args](../Scripts.htm#cmd_args) and the [numbered variables](../Scripts.htm#cmd_args_old). Prior to [v1.1.28], only [%A\_ScriptDir%](../Variables.htm#ScriptDir), [%A\_AppData%](../Variables.htm#AppData), [%A\_AppDataCommon%](../Variables.htm#AppDataCommon) and [in v1.1.11+] [%A\_LineFile%](../Variables.htm#LineFile) were supported.

Known limitation: When compiling a script, variables are evaluated by the compiler and may differ from what the script would return when it is finally executed. Ahk2Exe v1.1.30.00 and earlier only support the four variables listed above. [v1.1.30.01+]: The following variables are also supported: [A\_AhkPath](../Variables.htm#AhkPath), [A\_ComputerName](../Variables.htm#ComputerName), [A\_ComSpec](../Variables.htm#ComSpec), [A\_Desktop](../Variables.htm#Desktop), [A\_DesktopCommon](../Variables.htm#DesktopCommon), [A\_IsCompiled](../Variables.htm#IsCompiled), [A\_IsUnicode](../Variables.htm#IsUnicode), [A\_MyDocuments](../Variables.htm#MyDocuments), [A\_ProgramFiles](../Variables.htm#ProgramFiles), [A\_Programs](../Variables.htm#Programs), [A\_ProgramsCommon](../Variables.htm#ProgramsCommon), [A\_ScriptFullPath](../Variables.htm#ScriptFullPath), [A\_ScriptName](../Variables.htm#ScriptName), [A\_Space](../Variables.htm#Space), [A\_StartMenu](../Variables.htm#StartMenu), [A\_StartMenuCommon](../Variables.htm#StartMenuCommon), [A\_Startup](../Variables.htm#Startup), [A\_StartupCommon](../Variables.htm#StartupCommon), [A\_Tab](../Variables.htm#Tab), [A\_Temp](../Variables.htm#Temp), [A\_UserName](../Variables.htm#UserName), [A\_WinDir](../Variables.htm#WinDir).

**File:** The name of the file to be included, which is assumed to be in the startup/working directory if an absolute path is not specified (except for [Ahk2Exe](../Scripts.htm#ahk2exe), which assumes the file is in the script's own directory). Note: [SetWorkingDir](SetWorkingDir.htm) has no effect on #Include because #Include is processed before the script begins executing.

**Directory:** Specify a directory instead of a file to change the working directory used by all subsequent occurrences of #Include and [FileInstall](FileInstall.htm). Note: Changing the working directory in this way does not affect the script's initial working directory when it starts running ( [A\_WorkingDir](../Variables.htm#WorkingDir)). To change that, use [SetWorkingDir](SetWorkingDir.htm) at the top of the script.

LibName

[AHK\_L 57+]: A library file or function name. For example, `#include <lib>` and `#include <lib_func>` would both include lib.ahk from one of the [function library folders](../Functions.htm#lib). _LibName_ cannot contain variable references.

## Remarks

A script behaves as though the included file's contents are physically present at the exact position of the #Include directive (as though a copy-and-paste were done from the included file). Consequently, it generally cannot merge two isolated scripts together into one functioning script.

#Include ensures that _FileName_ is included only once, even if multiple inclusions are encountered for it. By contrast, #IncludeAgain allows multiple inclusions of the same file, while being the same as #Include in all other respects.

The _FileName_ parameter may optionally be preceded by `*i` and a single space, which causes the program to ignore any failure to read the included file. For example: `#Include *i SpecialOptions.ahk`. This option should be used only when the included file's contents are not essential to the main script's operation.

Lines displayed in the main window via [ListLines](ListLines.htm) or the menu View->Lines are always numbered according to their physical order within their own files. In other words, including a new file will change the line numbering of the main script file by only one line, namely that of the #Include line itself (except for [compiled scripts](../Scripts.htm#ahk2exe), which merge their included files into one big script at the time of compilation).

#Include is often used to load [functions](../Functions.htm) defined in an external file. Unlike subroutine labels, [functions](../Functions.htm) can be included at the very top of the script without affecting the [auto-execute section](../Scripts.htm#auto).

Like other directives, #Include cannot be executed conditionally. In other words, this example would not work as expected:

```
if (x = 1)
    #Include SomeFile.ahk  <em>; This line takes effect regardless of the value of x.</em>
```

Files can be automatically included (i.e. without having to use #Include) by calling a [library function](../Functions.htm#lib) by name.

[v1.1.11+]: Use `<a href="../Variables.htm#LineFile" data-index="43">%A_LineFile%</a>\..` to refer to the directory which contains the current file, even if it is not the main script file. For example, `#Include %A_LineFile%\..\other.ahk`. [v1.1.28+]: `<a href="../Variables.htm#AhkPath" data-index="44">%A_AhkPath%</a>\..` can be used to refer to the directory containing AutoHotkey.exe.

## Related

[Libraries of Functions](../Functions.htm#lib), [Functions](../Functions.htm), [FileInstall](FileInstall.htm)

## Examples

Includes the contents of the specified file into the current script.

```
#Include C:\My Documents\Scripts\Utility Subroutines.ahk
```

Changes the working directory for subsequent #Includes and FileInstalls.

```
#Include %A_ScriptDir%
```

Same as above but for an explicitly named directory.

```
#Include C:\My Scripts
```

