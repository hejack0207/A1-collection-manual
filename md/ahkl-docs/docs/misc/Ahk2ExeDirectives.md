# Script Compiler Directives [v1.1.33+]

## Table of Contents

- [Introduction](#Intro1)
- [Directives that control the script behaviour](#IgnoreKeep):

  - [IgnoreBegin](#IgnoreKeep)
  - [IgnoreEnd](#IgnoreKeep)
  - [IgnoreKeep](#IgnoreKeep)

- [Directives that control executable metadata](#Directives):
  - [Introduction](#Intro2)
  - [AddResource](#AddResource): Adds a resource to the .exe.
  - [Bin / Base](#Bin)[v1.1.33.10+]: Specifies the base version of AutoHotkey to use.
  - [ConsoleApp](#ConsoleApp): Sets Console mode.
  - [Cont](#Cont): Specifies a directive continuation line.
  - [Debug](#Debug): Shows directive debugging text.
  - [ExeName](#ExeName): Specifies the location and name for the .exe.
  - [Let](#Let): Sets a user variable.
  - [Obey](#Obey): Obeys a command or expression.
  - [PostExec](#PostExec): Runs a program after compilation.
  - [ResourceID](#ResourceID)[v1.1.34+]: Assigns a non-standard resource ID to the main script.
  - [SetMainIcon](#SetMainIcon): Sets the main icon.
  - [Set _Prop_](#SetProp): Sets an .exe property.
  - [Set](#Set): Sets a miscellaneous property.
  - [UpdateManifest](#UpdateManifest): Changes the .exe's manifest.
  - [UseResourceLang](#UseResourceLang): Changes the resource language.

## Introduction

Script compiler directives allow the user to specify details of how a script is to be compiled via [Ahk2Exe](../Scripts.htm#ahk2exe). Some of the features are:

- Ability to change the version information (such as the name, description, version...).
- Ability to add resources to the compiled script.
- Ability to tweak several miscellaneous aspects of compilation.
- Ability to remove code sections from the compiled script and vice versa.

The script compiler looks for special comments in the source script and recognises these as Compiler Directives. All compiler directives are introduced by the string `@Ahk2Exe-`, preceded by the comment flag (usually `;`).

## Directives that control the script behaviour

It is possible to remove code sections from the compiled script by wrapping them in directives:

```
MsgBox This message appears in both the compiled and uncompiled script
<em>;@Ahk2Exe-IgnoreBegin</em>
MsgBox This message does NOT appear in the compiled script
<em>;@Ahk2Exe-IgnoreEnd</em>
MsgBox This message appears in both the compiled and uncompiled script

```

The reverse is also possible, i.e. marking a code section to only be executed in the compiled script:

```
<em>/*@Ahk2Exe-Keep
MsgBox This message appears only in the compiled script
*/</em>
MsgBox This message appears in both the compiled and uncompiled script

```

This has advantage over [A\_IsCompiled](../Variables.htm#IsCompiled) because the code is completely removed from the compiled script during preprocessing, thus making the compiled script smaller. The reverse is also true: it will not be necessary to check for [A\_IsCompiled](../Variables.htm#IsCompiled) because the code is inside a comment block in the uncompiled script.

## Directives that control executable metadata

### Introduction

In the parameters of these directives, the following escape sequences are supported: ``` `` ```, `` `,``, `` `n``, `` `r`` and `` `t``. Commas _always_ need to be escaped, regardless of the parameter position. "Integer" refers to unsigned 16-bit integers (0..0xFFFF).

If required, directive parameters can reference the following list of standard built-in variables by enclosing the variable name with `%` signs:

**Group 1:** [A\_AhkPath](../Variables.htm#AhkPath), [A\_AppData](../Variables.htm#AppData), [A\_AppDataCommon](../Variables.htm#AppDataCommon), [A\_ComputerName](../Variables.htm#ComputerName), [A\_ComSpec](../Variables.htm#ComSpec), [A\_Desktop](../Variables.htm#Desktop), [A\_DesktopCommon](../Variables.htm#DesktopCommon), [A\_MyDocuments](../Variables.htm#MyDocuments), [A\_ProgramFiles](../Variables.htm#ProgramFiles), [A\_Programs](../Variables.htm#Programs), [A\_ProgramsCommon](../Variables.htm#ProgramsCommon), [A\_ScriptDir](../Variables.htm#ScriptDir), [A\_ScriptFullPath](../Variables.htm#ScriptFullPath), [A\_ScriptName](../Variables.htm#ScriptName), [A\_Space](../Variables.htm#Space), [A\_StartMenu](../Variables.htm#StartMenu), [A\_StartMenuCommon](../Variables.htm#StartMenuCommon), [A\_Startup](../Variables.htm#Startup), [A\_StartupCommon](../Variables.htm#StartupCommon), [A\_Tab](../Variables.htm#Tab), [A\_Temp](../Variables.htm#Temp), [A\_UserName](../Variables.htm#UserName), [A\_WinDir](../Variables.htm#WinDir).

**Group 2:** [A\_AhkVersion](../Variables.htm#AhkVersion), [A\_IsCompiled](../Variables.htm#IsCompiled), [A\_IsUnicode](../Variables.htm#IsUnicode), [A\_PtrSize](../Variables.htm#PtrSize).

In addition to these variable names, the special variable **A\_WorkFileName** holds the temporary name of the processed .exe file. This can be used to pass the file name as a parameter to any [PostExec](#PostExec) directives which need to access the generated .exe.

Also, the special variable **A\_PriorLine** contains the source line immediately preceding the current compiler directive. Intervening lines of blanks and comments only are ignored, as are any intervening compiler directive lines. This variable can be used to 'pluck' constant information from the script source, and use it in later compiler directives. An example would be accessing the version number of the script, which may be changed often. Accessing the version number in this way means that it needs to be changed only once in the source code, and the change will get copied through to the necessary directive. (See the RegEx example below for more information.)

As well, special user variables can be created with the format `U_<i>Name</i>` using the [Let](#Let) and [Obey](#Obey) directives, described below.

In addition to being available for directive parameters, all variables can be accessed from any RT\_MENU, RT\_DIALOG, RT\_STRING, RT\_ACCELERATORS, RT\_HTML, and RT\_MANIFEST file supplied to the [AddResource](#AddResource) directive, below.

If needed, the value returned from the above variables can be manipulated by including at the end of the built-in variable name before the ending `%`, up to 2 parameters (called p2 and p3) all separated by tilde `~`. The p2 and p3 parameters will be used as literals in the 2nd and 3rd parameters of a [RegExReplace](../commands/RegExReplace.htm) function to manipulate the value returned. (See [RegEx Quick Reference](RegEx-QuickRef.htm).) Note that p3 is optional.

To include a tilde as data in p2 or p3, preceded it with a back-tick, i.e. `` `~``. To include a back-tick character as data in p2 or p3, double it, i.e. ``` `` ```.

 **RegEx examples:**

- ```
  %A_ScriptName~\.[^\.]+$~.exe%
  ```


  This replaces the extension plus preceding full-stop, with `.exe` in the actual script name.

  ( `\.[^\.]+$~.exe` means scan for a `.` followed by 1 or more non- `.` characters followed by end-of-string, and replace them with `.exe`)

- Assume there is a source line followed by two compiler directives as follows:


  ```
  CodeVersion := "1.2.3.4", company := "My Company"
  ```



  ```
  ;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
  ```



  ```
  ;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
  ```


  These directives copy the version number `1.2.3.4` into the special variable `U_version`, and the company name `My Company` into the special variable `U_company` for use in other directives later.


   (The `{1}` in the first regex was changed to `{3}` in the second regex to select after the third `"` to extract the company name.)


**Other examples:** Other working examples which can be downloaded and examined, are available from [here](https://github.com/AutoHotkey/Ahk2Exe/releases/tag/DemoCode_1).

### AddResource

Adds a resource to the compiled executable. (Also see [UseResourceLang](#UseResourceLang) below)

```
<span class="func">;@Ahk2Exe-AddResource</span> FileName <span class="optional">, ResourceName</span>
```

FileNameThe filename of the resource to add. The file is assumed to be in (or relative to) the script's own directory if an absolute path isn't specified. The type of the resource (as an integer or string) can be explicitly specified by prepending an asterisk to it: `*type Filename`. If omitted, Ahk2Exe automatically detects the type according to the file extension.ResourceName_(Optional)_ The name that the resource will have (can be a string or an integer). If omitted, it defaults to the name (with no path) of the file, in uppercase.

Here is a list of common standard resource types and the extensions that trigger them by default.

- 2 (RT\_BITMAP):`.bmp`, `.dib`
- 4 (RT\_MENU)
- 5 (RT\_DIALOG)
- 6 (RT\_STRING)
- 9 (RT\_ACCELERATORS)
- 10 (RT\_RCDATA): Every single other extension.
- 11 (RT\_MESSAGETABLE)
- 12 (RT\_GROUP\_CURSOR):`.cur` (not yet supported)
- 14 (RT\_GROUP\_ICON):`.ico`
- 23 (RT\_HTML):`.htm`, `.html`, `.mht`
- 24 (RT\_MANIFEST):`.manifest`. If the name for the resource is not specified, it defaults to `1`

**Example 1:** To replace the standard icons (other than the [main icon](#SetMainIcon)):

```
;@Ahk2Exe-AddResource Icon1.ico, 160  ; Replaces 'H on blue'
;@Ahk2Exe-AddResource Icon2.ico, 206  ; Replaces 'S on green'
;@Ahk2Exe-AddResource Icon3.ico, 207  ; Replaces 'H on red'
;@Ahk2Exe-AddResource Icon4.ico, 208  ; Replaces 'S on red'
```

**Example 2:**[v1.1.34+] To include another script as a separate RCDATA resource (see [Embedded Scripts](../Program.htm#embedded-scripts)):

```
;@Ahk2Exe-AddResource MyScript.ahk, MYRESOURCE
```

Note that each script added with this directive will be fully and separately processed by the compiler, and can include further directives. If there are any competing directives overall, the last encountered by the compiler will be used.

### Bin / Base [v1.1.33.10+]

Specifies the base version of AutoHotkey to be used to generate the .exe file. This directive may be overridden by a base file parameter specified in the GUI or CLI. This directive can be specified many times if necessary, but only in the top level script file (i.e. not in an [#Include](../commands/_Include.htm) file). The compiler will be run at least once for each Bin/Base directive found. (If an actual comment is appended to this directive, it must use the ` ;` flag. To truly comment out this directive, insert a space after the first comment flag.)

```
<span class="func">;@Ahk2Exe-Bin </span> [Path\]Name <span class="optional">, [Exe_path\][Name], Codepage</span> <em>; Deprecated</em>
<span class="func">;@Ahk2Exe-Base</span> [Path\]Name <span class="optional">, [Exe_path\][Name], Codepage</span> <em>; <span class="ver">[v1.1.33.10+]</span></em>
```

[Path\\]NameThe \*.bin file or in [v1.1.33.10+] the \*.exe file to use. If no extension is supplied, `.bin` is assumed. The file is assumed to be in (or relative to) the compiler's own directory if an absolute path isn't specified. A DOS mask may be specified for _Name_, e.g. `ANSI*`, `Unicode 32*`, `Unicode 64*`, or `*bit` for all three. The compiler will be run for each \*.bin or \*.exe file that matches. Any use of built-in variable replacements must only be from [group 1](#group1) above.[Exe\_path\\][Name]_(Optional)_ The file name to be given to the .exe. Any extension supplied will be replaced by `.exe`. If no path is specified, the .exe will be created in the script folder. If no name is specified, the .exe will have the default name. (This parameter can be overridden by the [ExeName](#ExeName) directive.)Codepage_(Optional)_ Overrides the default [codepage](http://msdn.microsoft.com/en-us/library/dd317756.aspx)
 used to process script files. (Scripts should begin with a Unicode byte-order-mark (BOM), rendering the use of this parameter unnecessary.)

### ConsoleApp

Changes the executable subsystem to Console mode.

```
<span class="func">;@Ahk2Exe-ConsoleApp</span>
```

### Cont

Specifies a continuation line for the preceding directive. This allows a long-lined directive to be formatted so that it is easy to read in the source code.

```
<span class="func">;@Ahk2Exe-Cont</span> Text
```

TextThe text to be appended to the previous directive line, before that line is processed. The text starts after the single space following the `Cont` key-word.

### Debug

Shows a message box with the supplied text, for debugging purposes.

```
<span class="func">;@Ahk2Exe-Debug</span> Text
```

TextThe text to be shown. Include any special variables between `%` signs to see the (manipulated) contents.

### ExeName

Specifies the location and name given to the generated .exe file. (Also see the [Base](#Bin) directive.) This directive may be overridden by an output file specified in the GUI or CLI.

```
<span class="func">;@Ahk2Exe-ExeName</span> [Path\][Name]
```

[Path\\][Name]The .exe file name. Any extension supplied will be replaced by `.exe`. If no path is specified, the .exe will be created in the script folder. If no name is specified, the .exe will have the default name.**Example:**

```
;@Ahk2Exe-Obey U_bits, = %A_PtrSize% * 8
;@Ahk2Exe-Obey U_type, = "%A_IsUnicode%" ? "Unicode" : "ANSI"
;@Ahk2Exe-ExeName %A_ScriptName~\.[^\.]+$%_%U_type%_%U_bits%
```

### Let

Creates (or modifies) one or more user variables which can be accessed by `%U_<i>Name</i>%`, similar to the built-in variables (see above).

```
<span class="func">;@Ahk2Exe-Let</span> Name = Value <span class="optional">, Name = Value, ...</span>
```

NameThe name of the variable (with or without the leading `U_`).ValueThe value to be used.

### Obey

Obeys isolated AutoHotkey commands or expressions, with result in `U_<i>Name</i>`.

```
<span class="func">;@Ahk2Exe-Obey</span> Name, CmdOrExp <span class="optional">, Extra</span>
```

NameThe name of the variable (with or without the leading `U_`) to receive the result.CmdOrExp

The command or expression to obey.

**Command** format must use _Name_ as the output variable (often the first parameter), e.g.

```
;@Ahk2Exe-Obey U_date, FormatTime U_date`, R D2 T2
```

**Expression** format must start with `=`, e.g.

```
;@Ahk2Exe-Obey U_type, = "%A_IsUnicode%" ? "Unicode" : "ANSI"
```

Expressions can be written in command format, e.g.

```
;@Ahk2Exe-Obey U_bits, U_bits := %A_PtrSize% * 8
```

If needed, separate multiple commands and expressions with `` `n``.

Extra_(Optional)_ A number (1-9) specifying the number of extra results to be returned. e.g. if extra = 2, results will be returned in `U_<i>name</i>`, `U_<i>name</i>1`, and `U_<i>name</i>2`. The values in the `<i>name</i>` s must first be set by the expression or command.

### PostExec

Specifies a program to be executed after a successful compilation, before (or after) any [Compression](../Scripts.htm#mpress) is applied to the .exe.

```
<span class="func">;@Ahk2Exe-PostExec</span> Program [parameters] <span class="optional">, When, WorkingDir, Hidden, IgnoreErrors</span>
```

Program [parameters]The program to execute, plus parameters. To allow access to the processed .exe file, specify the special variable [A\_WorkFileName](#WorkFileName) as a quoted parameter, such as `"%A_WorkFileName%"`. If the program changes the .exe, the altered .exe must be moved back to the input file specified by `%A_WorkFileName%`, by the program. (Note that the .exe will contain binary data.)When

_(Optional)_ Leave blank to execute before any [Compression](../Scripts.htm#mpress) is done. Otherwise set to a number to run after compression as follows:

- 0 - Only run when no compression is specified.
- 1 - Only run when MPRESS compression is specified.
- 2 - Only run when UPX compression is specified.

WorkingDir [v1.1.33.03+]_(Optional)_ The working directory for the program. Do not enclose the name in double quotes even if it contains spaces. If omitted, the directory of the compiler (Ahk2Exe) will be used.Hidden [v1.1.33.03+]_(Optional)_ If set to 1, the program will be launched hidden.IgnoreErrors [v1.1.33.03+]_(Optional)_ If set to 1, any errors that occur during the launching or running of the program will not be reported to the user.

**Example 1:** (To use these examples, first download [BinMod.ahk](https://github.com/AutoHotkey/Ahk2Exe/blob/master/BinMod.ahk) and compile it according to the instructions in the downloaded script.)

This example can be used to remove a reference to "AutoHotkey" in the generated .exe to disguise that it is a compiled AutoHotkey script:

```
;@Ahk2Exe-Obey U_au, = "%A_IsUnicode%" ? 2 : 1    ; Script ANSI or Unicode?
;@Ahk2Exe-PostExec "BinMod.exe" "%A_WorkFileName%"
;@Ahk2Exe-Cont  "%U_au%2.>AUTOHOTKEY SCRIPT<. DATA              "
```

**Example 2:** This example will alter a UPX compressed .exe so that it can't be de-compressed with `UPX -d`:

```
;@Ahk2Exe-PostExec "BinMod.exe" "%A_WorkFileName%"
;@Ahk2Exe-Cont  "11.UPX." "1.UPX!.", 2
```

There are other examples mentioned in the [BinMod.ahk](https://github.com/AutoHotkey/Ahk2Exe/blob/master/BinMod.ahk) script.

### ResourceID [v1.1.34+]

Assigns a non-standard resource ID to be used for the main script for compilations which use an [.exe base file](#Bin) (see [Embedded Scripts](../Program.htm#embedded-scripts)). This directive may be overridden by a Resource ID specified in the GUI or CLI. This directive is ignored if it appears in a script inserted by the [AddResource](#AddResource) directive.

```
<span class="func">;@Ahk2Exe-ResourceID</span> Name
```

NameThe resource ID to use. Numeric resource IDs should consist of a hash sign (#) followed by a decimal number.

### SetMainIcon

Overrides the custom EXE icon used for compilation. (To change the other icons, see the [AddResource](#AddResource) example.) This directive may be overridden by an icon file specified in the GUI or CLI.

```
<span class="func">;@Ahk2Exe-SetMainIcon</span> <span class="optional">IcoFile</span>
```

IcoFile_(Optional)_ The icon file to use. If omitted, the default AutoHotkey icon is used.

### Set _Prop_

Changes a property in the compiled executable's version information. Note that all properties are processed in alphabetical order, regardless of the order they are specified.

```
<span class="func">;@Ahk2Exe-Set<i>Prop</i></span> Value
```

_Prop_

The name of the property to change. Must be one of those listed below.

PropertyDescriptionCompanyNameChanges the company name.CopyrightChanges the legal copyright information.DescriptionChanges the file description.FileVersionChanges the file version, in both text and raw binary format. (See _Version_ below, for more details.)InternalNameChanges the internal name.LanguageChanges the [language code](Languages.htm). Please note that hexadecimal numbers must have an `0x` prefix.LegalTrademarksChanges the legal trademarks information.NameChanges the product name and the internal name.OrigFilenameChanges the original filename information.ProductNameChanges the product name.ProductVersionChanges the product version, in both text and raw binary format. (See _Version_ below, for more details.)Version

Changes the file version and the product version, in both text and raw binary format.

Ahk2Exe fills the binary version fields with the period-delimited numbers (up to four) that may appear at the beginning of the version text. Unfilled fields are set to zero. For example, `1.3-alpha` would produce a binary version number of `1.3.0.0`. If this property is not modified, it defaults to the AutoHotkey version used to compile the script.

ValueThe value to set the property to.

### Set

Changes other miscellaneous properties in the compiled executable's version information not covered by the [SetProp](#SetProp) directive. Note that all properties are processed in alphabetical order, regardless of the order they are specified. This directive is for specialised use only.

```
<span class="func">;@Ahk2Exe-Set</span> Prop, Value
```

PropThe name of the property to change.ValueThe value to set the property to.

### UpdateManifest

Changes details in the .exe's manifest. This directive is for specialised use only.

```
<span class="func">;@Ahk2Exe-UpdateManifest</span> RequireAdmin <span class="optional">, Name, Version, UIAccess</span>
```

RequireAdminSet to 1 to change the executable to require administrative privileges when run. Set to 2 to change the executable to request highest available privileges when run. Set to 0 to leave unchanged.Name_(Optional)_ The name to be set in the manifest.Version_(Optional)_ The version to be set in the manifest.UIAccess_(Optional)_ Set to 1 to make UIAccess true in the manifest.

### UseResourceLang

Changes the resource language used by [AddResource](#AddResource). This directive is positional and affects all [AddResource](#AddResource) directives that follow it.

```
<span class="func">;@Ahk2Exe-UseResourceLang</span> LangCode
```

LangCodeThe [language code](Languages.htm). Please note that hexadecimal numbers must have an `0x` prefix. The default resource language is US English (0x0409).

