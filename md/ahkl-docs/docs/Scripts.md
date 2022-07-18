# Scripts

Related topics:

- [Using the Program](Program.htm): How to use AutoHotkey, in general.
- [Concepts and Conventions](Concepts.htm): General explanation of various concepts utilised by AutoHotkey.
- [Scripting Language](Language.htm): Specific details about syntax (how to write scripts).

## Table of Contents

- [Introduction](#intro)
- [The Top of the Script (the Auto-execute Section)](#auto): This portion executes automatically when the script starts.
- [Splitting a Long Line into a Series of Shorter Ones](#continuation): This can improve a script's readability and maintainability.
- [Convert a Script to an EXE (Ahk2Exe)](#ahk2exe): Convert a .ahk script into a .exe file that can run on any PC.
- [Passing Command Line Parameters to a Script](#cmd): The variables %1%, %2%, etc. contain the incoming parameters.
- [Script File Codepage](#cp): Using non-ASCII characters safely in scripts.
- [Debugging a Script](#debug): How to find the flaws in a misbehaving script.

## Introduction

Each script is a plain text file containing lines to be executed by the program (AutoHotkey.exe). A script may also contain [hotkeys](Hotkeys.htm) and [hotstrings](Hotstrings.htm), or even consist entirely of them. However, in the absence of hotkeys and hotstrings, a script will perform its commands sequentially from top to bottom the moment it is launched.

The program loads the script into memory line by line, and each line may be up to 16,383 characters long. During loading, the script is [optimized](misc/Performance.htm) and validated. Any syntax errors will be displayed, and they must be corrected before the script can run.

## The Top of the Script (the Auto-execute Section)

After the script has been loaded, it begins executing at the top line, continuing until a [Return](commands/Return.htm), [Exit](commands/Exit.htm), [hotkey/hotstring label](Hotkeys.htm), or the physical end of the script is encountered (whichever comes first). This top portion of the script is referred to as the _auto-execute_ section.

**Note:** While the script's _first_ hotkey/hotstring label has the same effect as [return](commands/Return.htm), other hotkeys and labels do not.

If the script is not [persistent](commands/_Persistent.htm), it will terminate after the auto-execute section has completed. Otherwise, it will stay running in an idle state, responding to events such as [hotkeys](Hotkeys.htm), [hotstrings](Hotstrings.htm), [GUI events](commands/Gui.htm#label), [custom menu items](commands/Menu.htm), and [timers](commands/SetTimer.htm). A script is automatically persistent if it contains hotkeys, hotstrings, [OnMessage()](commands/OnMessage.htm) or [GUI](commands/Gui.htm), and in a few other cases. The [#Persistent](commands/_Persistent.htm) directive can also be used to explicitly make the script persistent.

Every [thread](misc/Threads.htm) launched by a [hotkey](Hotkeys.htm), [hotstring](Hotstrings.htm), [menu item](commands/Menu.htm), [GUI event](commands/Gui.htm#label), or [timer](commands/SetTimer.htm) starts off fresh with the default values for the following attributes as set in the auto-execute section. If unset, the standard defaults will apply (as documented on each of the following pages): [AutoTrim](commands/AutoTrim.htm), [CoordMode](commands/CoordMode.htm), [Critical](commands/Critical.htm), [DetectHiddenText](commands/DetectHiddenText.htm), [DetectHiddenWindows](commands/DetectHiddenWindows.htm), [FileEncoding](commands/FileEncoding.htm), [ListLines](commands/ListLines.htm), [SendLevel](commands/SendLevel.htm), [SendMode](commands/SendMode.htm), [SetBatchLines](commands/SetBatchLines.htm), [SetControlDelay](commands/SetControlDelay.htm), [SetDefaultMouseSpeed](commands/SetDefaultMouseSpeed.htm), [SetFormat](commands/SetFormat.htm), [SetKeyDelay](commands/SetKeyDelay.htm), [SetMouseDelay](commands/SetMouseDelay.htm), [SetRegView](commands/SetRegView.htm), [SetStoreCapsLockMode](commands/SetStoreCapslockMode.htm), [SetTitleMatchMode](commands/SetTitleMatchMode.htm), [SetWinDelay](commands/SetWinDelay.htm), [StringCaseSense](commands/StringCaseSense.htm), and [Thread](commands/Thread.htm).

If the auto-execute section takes a long time to complete (or never completes), the default values for the above settings will be put into effect after 100 milliseconds. When the auto-execute section finally completes (if ever), the defaults are updated again to be those that were in effect at the end of the auto-execute section. Thus, it's usually best to make any desired changes to the defaults at the top of scripts that contain [hotkeys](Hotkeys.htm), [hotstrings](Hotstrings.htm), [timers](commands/SetTimer.htm), or [custom menu items](commands/Menu.htm). Also note that each [thread](misc/Threads.htm) retains its own collection of the above settings. Changes made to those settings will not affect other [threads](misc/Threads.htm).

## Splitting a Long Line into a Series of Shorter Ones

Long lines can be divided up into a collection of smaller ones to improve readability and maintainability. This does not reduce the script's execution speed because such lines are merged in memory the moment the script launches.

**Method #1**: A line that starts with "and", "or", \|\|, &&, a comma, or a [period](Variables.htm#concat) is automatically merged with the line directly above it (in v1.0.46+, the same is true for all other [expression operators](Variables.htm#Operators) except ++ and --). In the following example, the second line is appended to the first because it begins with a comma:

```
FileAppend, This is the text to append.`n   <em>; A comment is allowed here.</em>
    , %A_ProgramFiles%\SomeApplication\LogFile.txt  <em>; Comment.</em>
```

Similarly, the following lines would get merged into a single line because the last two start with "and" or "or":

```
if (Color = "Red" or Color = "Green"  or Color = "Blue"   <em>; Comment.</em>
    <strong>or</strong> Color = "Black" or Color = "Gray" or Color = "White")   <em>; Comment.</em>
    <strong>and</strong> ProductIsAvailableInColor(Product, Color)   <em>; Comment.</em>
```

The [ternary operator](Variables.htm#ternary) is also a good candidate:

```
ProductIsAvailable := (Color = "Red")
    <strong>?</strong> false  <em>; We don't have any red products, so don't bother calling the function.</em>
    <strong>:</strong> ProductIsAvailableInColor(Product, Color)
```

Although the indentation used in the examples above is optional, it might improve clarity by indicating which lines belong to ones above them. Also, it is not necessary to include extra spaces for lines starting with the words "AND" and "OR"; the program does this automatically. Finally, blank lines or [comments](Language.htm#comments) may be added between or at the end of any of the lines in the above examples.

**Method #2**: This method should be used to merge a large number of lines or when the lines are not suitable for Method #1. Although this method is especially useful for [auto-replace hotstrings](Hotstrings.htm), it can also be used with any command or [expression](Variables.htm#Expressions). For example:

```
<em>; EXAMPLE #1:</em>
Var =
(
A line of text.
<i>By default</i>, the hard carriage return (Enter) between the previous line and this one will be stored as a linefeed (`n).
    <i>By default</i>, the spaces to the left of this line will also be stored (the same is true for tabs).
<i>By default</i>, variable references such as %Var% are resolved to the variable's contents.
)

<em>; EXAMPLE #2 - expression syntax (recommended):</em>
Var := "
(
Same as above, except that variable references such as %Var% are not resolved.
Instead, specify variables as follows:" Var "
)"

<em>; EXAMPLE #3:</em>
FileAppend,  <em>; The comma is required in this case.</em>
(
Line 1 of the text.
Line 2 of the text. By default, a linefeed (`n) is present between lines.
), C:\My File.txt
```

In the examples above, a series of lines is bounded at the top and bottom by a pair of parentheses. This is known as a _continuation section_. Notice that the bottom line contains [FileAppend](commands/FileAppend.htm)'s last parameter after the closing parenthesis. This practice is optional; it is done in cases like this so that the comma will be seen as a parameter-delimiter rather than a literal comma.

The default behavior of a continuation section can be overridden by including one or more of the following options to the right of the section's opening parenthesis. If more than one option is present, separate each one from the previous with a space. For example: `( LTrim Join| %`.

**Join**: Specifies how lines should be connected together. If this option is omitted, each line except the last will be followed by a linefeed character (\`n). If the word _Join_ is specified by itself, lines are connected directly to each other without any characters in between. Otherwise, the word _Join_ should be followed immediately by as many as 15 characters. For example, ``Join`s`` would insert a space after each line except the last ("\`s" indicates a literal space -- it is a special escape sequence recognized only by _Join_). Another example is ``Join`r`n``, which inserts CR+LF between lines. Similarly, `Join|` inserts a pipe between lines. To have the final line in the section also ended by a join-string, include a blank line immediately above the section's closing parenthesis.

Known limitation: If the Join string ends with a colon, it must not be the last option on the line. For example, `(Join:` is treated as the label "(Join" and `(LTrim Join:` is unsupported, but `(Join: C` is okay.

**LTrim**: Omits spaces and tabs at the beginning of each line. This is primarily used to allow the continuation section to be indented. Also, this option may be turned on for multiple continuation sections by specifying `#LTrim` on a line by itself. `#LTrim` is positional: it affects all continuation sections physically beneath it. The setting may be turned off via `#LTrim Off`.

**RTrim0** (RTrim followed by a zero): Turns off the omission of spaces and tabs from the end of each line.

**Comments** (or **Comment** or **Com** or **C**) [v1.0.45.03+]: Allows [semicolon comments](Language.htm#comments) inside the continuation section (but not `/*..*/`). Such comments (along with any spaces and tabs to their left) are entirely omitted from the joined result rather than being treated as literal text. Each comment can appear to the right of a line or on a new line by itself.

**%** (percent sign): Treats percent signs as literal rather than as variable references. This avoids the need to [escape](misc/EscapeChar.htm) each percent sign to make it literal. This option is not needed in places where percent signs are already literal, such as [auto-replace hotstrings](Hotstrings.htm).

**,** (comma): Treats commas as delimiters rather than as literal commas. This rarely-used option is necessary only for the commas between command parameters because in [function calls](Functions.htm), the type of comma does not matter. Also, this option transforms only those commas that actually delimit parameters. In other words, once the command's final parameter is reached (or there are no parameters), subsequent commas are treated as literal commas regardless of this option.

**\`** (accent): Treats each backtick character literally rather than as an [escape character](misc/EscapeChar.htm). This also prevents commas and percent signs from being explicitly and individually escaped. In addition, it prevents the translation of any explicitly specified escape sequences such as \`r and \`t.

**)**[v1.1.01+]: If a closing parenthesis appears in the continuation section's options (except as a parameter of the [Join](#Join) option), the line is reinterpreted as an expression instead of the beginning of a continuation section. This allows expressions like `(x.y)[z]()` to work without the need to escape the opening parenthesis.

Remarks

[Escape sequences](misc/EscapeChar.htm) such as \`n (linefeed) and \`t (tab) are supported inside the continuation section except when the [accent (\`) option](#accent) has been specified.

When the [comment option](#CommentOption) is absent, semicolon and /\*..\*/ comments are not supported within the interior of a continuation section because they are seen as literal text. However, comments can be included on the bottom and top lines of the section. For example:

```
FileAppend,   <em>; Comment.
; Comment.</em>
( LTrim Join    <em>; Comment.</em>
     ; This is <strong>not</strong> a comment; it is literal. Include the word <i>Comments</i> in the line above to make it a comment.
), C:\File.txt   <em>; Comment.</em>
```

As a consequence of the above, semicolons never need to be [escaped](misc/EscapeChar.htm) within a continuation section.

A continuation section cannot produce a line whose total length is greater than 16,383 characters (if it tries, the program will alert you the moment the script is launched). One way to work around this is to do a series of concatenations into a variable. For example:

```
Var := "
(
...
)"
Var .= "`n  <em>; Add more text to the variable via another continuation section.</em>
(
...
)"
FileAppend, %Var%, C:\My File.txt
```

Since a closing parenthesis indicates the end of a continuation section, to have a line start with literal closing parenthesis, precede it with an accent/backtick: `` `)``.

A continuation section can be immediately followed by a line containing the open-parenthesis of another continuation section. This allows the options mentioned above to be varied during the course of building a single line.

The piecemeal construction of a continuation section by means of [#Include](commands/_Include.htm) is not supported.

## Convert a Script to an EXE (Ahk2Exe)

A script compiler (courtesy of fincs, with additions by TAC109) is included with the program.

Once a script is compiled, it becomes a standalone executable; that is, AutoHotkey.exe is not required in order to run the script. The compilation process creates an executable file which contains the following: the AutoHotkey interpreter, the script, any files it [includes](commands/_Include.htm), and any files it has incorporated via the [FileInstall](commands/FileInstall.htm) command. [v1.1.33+]: Additional files can be included using [compiler directives](misc/Ahk2ExeDirectives.htm).

Ahk2Exe can be used in the following ways:

- **GUI Interface**: Run the "Convert .ahk to .exe" item in the Start Menu. (After invoking the GUI, there may be a pause before the window is shown; see [Background Information](#information) for more details.)

- **Right-click**: Within an open Explorer window, right-click any .ahk file and select "Compile Script" (only available if the script compiler option was chosen when AutoHotkey was installed). This creates an EXE file of the same base filename as the script, which appears after a short time in the same directory. Note: The EXE file is produced using the same custom icon, .bin file and [compression](#mpress) setting that were last saved in Method #1 above, or as specified by any relevant [compiler directive](misc/Ahk2ExeDirectives.htm) in the script.

- **Command Line**: The compiler can be run from the command line by using the parameters shown below. If any command line parameters are used, the script is compiled immediately unless `/gui` is used. All parameters are optional, except that there must be one `/gui` or `/in` parameter.
  Parameter pairMeaning/in _script\_name_The path and name of the script to compile. This is mandatory if any other parameters are used, unless `/gui` is used./out _exe\_name_The path\\name of the output .exe to be created. Default is the directory\\base\_name of the input file plus extension of .exe, or any relevant [compiler directive](misc/Ahk2ExeDirectives.htm) in the script./icon _icon\_name_The icon file to be used. Default is the last icon saved in the GUI interface, or any [SetMainIcon](misc/Ahk2ExeDirectives.htm#SetMainIcon) compiler directive in the script./base _file\_name_[v1.1.33.10+]: The base file to be used (a .bin file or in [v1.1.34+] an .exe file). Default is the last base file name saved in the GUI interface, or any [Base](misc/Ahk2ExeDirectives.htm#Bin) compiler directive in the script./resourceid _name_[v1.1.34+]: Assigns a non-standard resource ID to be used for the main script for compilations which use an [.exe base file](#SlashBase) (see [Embedded Scripts](Program.htm#embedded-scripts)). Numeric resource IDs should consist of a hash sign (#) followed by a decimal number. Default is #1, or any [ResourceID](misc/Ahk2ExeDirectives.htm#ResourceID) compiler directive in the script./cp _codepage_[v1.1.23.01+]: Overrides the default codepage used to read script files. For a list of possible values, see [Code Page Identifiers](https://docs.microsoft.com/en-au/windows/win32/intl/code-page-identifiers). Note that Unicode scripts should begin with a byte-order-mark (BOM), rendering the use of this parameter unnecessary./compress _n_[v1.1.33+]: [Compress](#mpress) the exe? 0 = no, 1 = use MPRESS if present, 2 = use UPX if present. Default is the last setting saved in the GUI interface./gui[v1.1.33+]: Shows the GUI instead of immediately compiling. The other parameters can be used to override the settings last saved in the GUI. `/in` is optional in this case./silent [verbose][v1.1.33.10+]: Disables all message boxes and instead outputs errors to the standard error stream (stderr); or to the standard output stream (stdout) if stderr fails. Other messages are also output to stdout. Optionally enter the word `verbose` to output status messages to stdout as well.**Deprecated:**

  /ahk _file\_name_[v1.1.33+]: The path\\name of AutoHotkey.exe to be used as a utility when compiling the script.**Deprecated:**

  /mpress _0or1_[Compress](#mpress) the exe with MPRESS? 0 = no, 1 = yes. Default is the last setting used in the GUI interface.**Deprecated:**

  /bin _file\_name_The .bin file to be used. Default is the last .bin file name saved in the GUI interface.
  For example:


  ```
  Ahk2Exe.exe /in "MyScript.ahk" /icon "MyIcon.ico"
  ```


Notes:

- Parameters containing spaces must be enclosed in double quotes.
- Compiling does not typically improve the performance of a script.
- As of v1.1.01, password protection and the /NoDecompile switch are not supported.
- The commands[#NoTrayIcon](commands/_NoTrayIcon.htm) and " [Menu, Tray, MainWindow](commands/Menu.htm#MainWindow)" affect the behavior of compiled scripts.
- The built-in variable[A\_IsCompiled](Variables.htm#IsCompiled) contains 1 if the script is running in compiled form. Otherwise, it is blank.
- [v1.0.43+]: When parameters are passed to Ahk2Exe, a message indicating the success or failure of the compiling process is written to stdout. Although the message will not appear at the command prompt, it can be "caught" by means such as redirecting output to a file.
- [v1.1.22.03+]: Additionally in the case of a failure, Ahk2Exe has exit codes indicating the kind of error that occurred. These error codes can be found at [GitHub (ErrorCodes.md)](https://github.com/AutoHotkey/Ahk2Exe/blob/master/ErrorCodes.md).

The compiler's source code and newer versions can be found at [GitHub](https://github.com/AutoHotkey/Ahk2Exe).

### Base Executable File

Each compiled script .exe is based on an executable file which implements the interpreter. The base files included in the Compiler directory have the ".bin" extension; these are versions of the interpreter which do not include the capability to load external script files. Instead, the program looks for a Win32 (RCDATA) resource named ">AUTOHOTKEY SCRIPT<" and loads that, or fails if it is not found.

[v1.1.34+]: The standard AutoHotkey executable files can also be used as the base of a compiled script, by embedding a Win32 (RCDATA) resource with ID 1. (Additional scripts can be added with the [AddResource](misc\Ahk2ExeDirectives.htm#AddResource) compiler directive.) This allows the compiled script .exe to be used with the [/script](#SlashScript) switch to execute scripts other than the main embedded script. For more details, see [Embedded Scripts](Program.htm#embedded-scripts).

### Script Compiler Directives

[v1.1.33+]: Script compiler directives allow the user to specify details of how a script is to be compiled. Some of the features are:

- Ability to change the version information (such as the name, description, version...).
- Ability to add resources to the compiled script.
- Ability to tweak several miscellaneous aspects of compilation.
- Ability to remove code sections from the compiled script and vice versa.

See [Script Compiler Directives](misc/Ahk2ExeDirectives.htm) for more details.

### Compressing Compiled Scripts

Ahk2Exe optionally uses MPRESS or [v1.1.33+] UPX freeware to compress compiled scripts. If **MPRESS.exe** and/or **UPX.exe** has been copied to the "Compiler" subfolder where AutoHotkey was installed, either can be used to compress the .exe as directed by the `/compress` parameter or the GUI setting.

**MPRESS** official website (downloads and information): [http://www.matcode.com/mpress.htm](http://www.matcode.com/mpress.htm)

MPRESS mirror: [https://www.autohotkey.com/mpress/](https://www.autohotkey.com/mpress/)

**UPX** official website (downloads and information): [https://upx.github.io/](https://upx.github.io/)

**Note:** While compressing the script executable prevents casual inspection of the script's source code using a plain text editor like Notepad or a PE resource editor, it does not prevent the source code from being extracted by tools dedicated to that purpose.

### Background Information

In [v1.1.33.10+], the following folder structure is supported, where the running version of `Ahk2Exe.exe` is in the first \\Compiler directory shown below:

```
\AutoHotkey
   AutoHotkeyA32.exe
   AutoHotkeyU32.exe
   AutoHotkeyU64.exe
   \Compiler
      Ahk2Exe.exe  <em>; the master version of Ahk2Exe</em>
      ANSI 32-bit.bin
      Unicode 32-bit.bin
      Unicode 64-bit.bin
   \AutoHotkey v2.0-a135
      AutoHotkey32.exe
      AutoHotkey64.exe
      \Compiler
   \v2.0-beta.1
      AutoHotkey32.exe
      AutoHotkey64.exe
```

The base file search algorithm runs for a short amount of time when Ahk2Exe starts, and works as follows:

Qualifying AutoHotkey .exe files and all .bin files are searched for in the compiler's directory, the compiler's parent directory, and any of the compiler's sibling directories with directory names that start with `AutoHotkey` or `V`, but do not start with `AutoHotkey_H`. The selected directories are searched recursively. Any AutoHotkey.exe files found are excluded, leaving files such as AutoHotkeyA32.exe, AutoHotkey64.exe, etc. plus all .bin files found. All .exe files that are included must have a name starting with `AutoHotkey` and a file description containing the word `AutoHotkey`, and must have a version of `1.1.34+` or `2.0-a135+`.

A version of the AutoHotkey interpreter is also needed (as a utility) for a successful compile, and one is selected using a similar algorithm. In most cases the version of the interpreter used will match the version of the base file selected by the user for the compile.

## Passing Command Line Parameters to a Script

Scripts support command line parameters. The format is:

```
AutoHotkey.exe [<i>Switches</i>] [<i>Script Filename</i>] [<i>Script Parameters</i>]
```

And for compiled scripts, the format is:

```
CompiledScript.exe [<i>Switches</i>] [<i>Script Parameters</i>]
```

**Switches:** Zero or more of the following:

SwitchMeaningWorks compiled?/f or /forceLaunch unconditionally, skipping any warning dialogs. This has the same effect as [#SingleInstance Off](commands/_SingleInstance.htm).Yes/r or /restartIndicate that the script is being restarted and should attempt to close a previous instance of the script (this is also used by the [Reload](commands/Reload.htm) command, internally).Yes/ErrorStdOut

/ErrorStdOut= _Encoding_

Send syntax errors that prevent a script from launching to the standard error stream (stderr) rather than displaying a dialog. See [#ErrorStdOut](commands/_ErrorStdOut.htm) for details. This can be combined with /iLib to validate the script without running it.

[v1.1.33+]: An [encoding](commands/FileEncoding.htm) can optionally be specified. For example, `/ErrorStdOut=UTF-8` encodes messages as UTF-8 before writing them to stderr.

Yes/Debug[AHK\_L 11+]: Connect to a debugging client. For more details, see [Interactive Debugging](#idebug).No/CP _n_

[AHK\_L 51+]: Overrides the default codepage used to read script files. For more details, see [Script File Codepage](#cp).

[v1.1.33+]: If "Default to UTF-8" is enabled in the installer, the ".ahk" file type is registered with a command line including `/CP65001`. This causes all scripts launched through the shell (Explorer) to default to UTF-8 in the absence of a UTF-16 byte order mark. Scripts launched by running AutoHotkey.exe directly still default to `CP0`, as the `/CP65001` switch is absent.

No/iLib _"OutFile"_

[v1.0.47+]: AutoHotkey loads the script but does not run it. For each script file which is auto-included via [the library mechanism](Functions.htm#lib), two lines are written to the file specified by _OutFile_. These lines are written in the following format, where _LibDir_ is the full path of the Lib folder and _LibFile_ is the filename of the library:

```
#Include LibDir\
#IncludeAgain LibDir\LibFile.ahk
```

If the output file exists, it is overwritten. _OutFile_ can be `*` to write the output to stdout.

If the script contains syntax errors, the output file may be empty. The process exit code can be used to detect this condition; if there is a syntax error, the exit code is 2. The /ErrorStdOut switch can be used to suppress or capture the error message.

No/include _"IncFile"_

[v1.1.34+]: [Includes](commands/_Include.htm) a file prior to the main script. Only a single file can be included by this method. When the script is [reloaded](commands/Reload.htm), this switch is automatically passed to the new instance.

No/script

[v1.1.34+]: When used with a compiled script based on an .exe file, this switch causes the program to ignore the main embedded script. This allows a compiled script .exe to execute external script files or embedded scripts other than the main one. Other switches not normally supported by compiled scripts can be used but must be listed to the right of this switch. For example:

```
CompiledScript.exe /script /ErrorStdOut MyScript.ahk "Script's arg 1"
```

If the current executable file does not have an embedded script, this switch is permitted but has no effect.

This switch is not supported by compiled scripts which are based on a .bin file.

See also: [Base Executable File (Ahk2Exe)](#ahk2exe-base)

N/A

**Script Filename:** This can be omitted if there are no _Script Parameters_. If omitted (such as if you run AutoHotkey directly from the Start menu), the program looks for a script file called `<i>AutoHotkey</i>.ahk` in the following locations, in this order:

- The directory which contains the[AutoHotkey executable](Variables.htm#AhkPath).
- The current user's[Documents](Variables.htm#MyDocuments) folder.

The filename `<i>AutoHotkey</i>.ahk` depends on the name of the executable used to run the script. For example, if you rename AutoHotkey.exe to MyScript.exe, it will attempt to find `MyScript.ahk`. If you run AutoHotkeyU32.exe without parameters, it will look for AutoHotkeyU32.ahk.

Note: In old versions prior to [revision 51](AHKL_ChangeLog.htm#L51), the program looked for AutoHotkey.ini in the working directory or AutoHotkey.ahk in My Documents.

[v1.1.17+]: Specify an asterisk (\*) for the filename to read the script text from standard input (stdin). For an example, see [ExecScript()](commands/Run.htm#ExecScript).

**Script Parameters:** The string(s) you want to pass into the script, with each separated from the next by one or more spaces. Any parameter that contains spaces should be enclosed in quotation marks. If you want to pass an empty string as a parameter, specify two consecutive quotation marks. A literal quotation mark may be passed in by preceding it with a backslash (\\"). Consequently, any trailing slash in a quoted parameter (such as "C:\\My Documents\\") is treated as a literal quotation mark (that is, the script would receive the string C:\\My Documents"). To remove such quotes, use `<a href="commands/StringReplace.htm" data-index="119">StringReplace</a>, 1, 1, <span class="red">"</span>,, All`.

[v1.1.27+]: Incoming parameters, if present, are stored as an array in the built-in variable **A\_Args**, and can be accessed using [array syntax](Objects.htm#Usage_Simple_Arrays). `A_Args[1]` contains the first parameter. The following example exits the script when too few parameters are passed to it:

```
if A_Args.Length() < 3
{
    MsgBox % "This script requires at least 3 parameters but it only received " A_Args.Length() "."
    ExitApp
}
```

If the number of parameters passed into a script varies (perhaps due to the user dragging and dropping a set of files onto a script), the following example can be used to extract them one by one:

```
for n, param in A_Args  <em>; For each parameter:</em>
{
    MsgBox Parameter number %n% is %param%.
}

```

If the parameters are file names, the following example can be used to convert them to their case-corrected long names (as stored in the file system), including complete/absolute path:

```
for n, GivenPath in A_Args  <em>; For each parameter (or file dropped onto a script):</em>
{
    Loop Files, %GivenPath%, FD  <em>; Include files and directories.</em>
        LongPath := A_LoopFileFullPath
    MsgBox The case-corrected long path name of file`n%GivenPath%`nis:`n%LongPath%
}
```

**Known limitation:** dragging files onto a .ahk script may fail to work properly if 8-dot-3 (short) names have been turned off in an NTFS file system. One work-around is to [compile](#ahk2exe) the script then drag the files onto the resulting EXE.

**Legacy:** The command line parameters are also stored in the [variables](Variables.htm) %1%, %2%, and so on, as in versions prior to [v1.1.27]. In addition, %0% contains the number of parameters passed (0 if none). However, these variables cannot be referenced directly in an expression because they would be seen as numbers rather than variables. The following example exits the script when too few parameters are passed to it:

```
if 0 < 3  <em>; The left side of a <a href="commands/IfEqual.htm" data-index="123">non-expression if-statement</a> is always the name of a variable.</em>
{
    MsgBox This script requires at least 3 incoming parameters but it only received %0%.
    ExitApp
}
```

If the number of parameters passed into a script varies (perhaps due to the user dragging and dropping a set of files onto a script), the following example can be used to extract them one by one:

```
Loop, %0%  <em>; For each parameter:</em>
{
    param := %A_Index%  <em>; Fetch the contents of the variable whose name is contained in A_Index.</em>
    MsgBox, 4,, Parameter number %A_Index% is %param%.  Continue?
    IfMsgBox, No
        break
}
```

If the parameters are file names, the following example can be used to convert them to their case-corrected long names (as stored in the file system), including complete/absolute path:

```
Loop %0%  <em>; For each parameter (or file dropped onto a script):</em>
{
    GivenPath := %A_Index%  <em>; Fetch the contents of the variable whose name is contained in A_Index.</em>
    Loop %GivenPath%, 1
        LongPath := A_LoopFileLongPath
    MsgBox The case-corrected long path name of file`n%GivenPath%`nis:`n%LongPath%
}
```

## Script File Codepage [AHK\_L 51+]

In order for non-ASCII characters to be read correctly from file, the encoding used when the file was saved (typically by the text editor) must match what AutoHotkey uses when it reads the file. If it does not match, characters will be decoded incorrectly. AutoHotkey uses the following rules to decide which encoding to use:

- If the file begins with a UTF-8 or UTF-16 (LE) byte order mark, the appropriate codepage is used and the[/CP _n_](#CPn) switch is ignored.
- If the[/CP _n_](#CPn) switch is passed on the command-line, codepage _n_ is used. For a list of possible values, see [Code Page Identifiers](https://docs.microsoft.com/en-au/windows/win32/intl/code-page-identifiers).

  **Note:** The "Default to UTF-8" option in the AutoHotkey [v1.1.33+] installer adds `/CP65001` to the command line for all scripts launched via the shell (Explorer).

- In all other cases, the system default ANSI codepage is used.

Note that this applies only to script files loaded by AutoHotkey, not to file I/O within the script itself. [FileEncoding](commands/FileEncoding.htm) controls the default encoding of files read or written by the script, while [IniRead](commands/IniRead.htm) and [IniWrite](commands/IniWrite.htm) always deal in UTF-16 or ANSI.

As all text is converted (where necessary) to the [native string format](Compat.htm#Format), characters which are invalid or don't exist in the native codepage are replaced with a placeholder: ANSI '?' or Unicode '�'. In Unicode builds, this should only occur if there are encoding errors in the script file or the codepages used to save and load the file don't match.

[RegWrite](commands/RegWrite.htm) may be used to set the default for scripts launched from Explorer (e.g. by double-clicking a file):

```
<em>; Uncomment the appropriate line below or leave them all commented to
;   reset to the default of the current build.  Modify as necessary:
; codepage := 0        ; System default ANSI codepage
; codepage := 65001    ; UTF-8
; codepage := 1200     ; UTF-16
; codepage := 1252     ; ANSI Latin 1; Western European (Windows)</em>
if (codepage != "")
    codepage := " /CP" . codepage
cmd="%A_AhkPath%"%codepage% "`%1" `%*
key=AutoHotkeyScript\Shell\Open\Command
if A_IsAdmin    <em>; Set for all users.</em>
    RegWrite, REG_SZ, HKCR, %key%,, %cmd%
else            <em>; Set for current user only.</em>
    RegWrite, REG_SZ, HKCU, Software\Classes\%key%,, %cmd%
```

This assumes AutoHotkey has already been installed. Results may be less than ideal if it has not.

## Debugging a Script

Commands such as [ListVars](commands/ListVars.htm) and [Pause](commands/Pause.htm) can help you debug a script. For example, the following two lines, when temporarily inserted at carefully chosen positions, create "break points" in the script:

```
ListVars
Pause
```

When the script encounters these two lines, it will display the current contents of all variables for your inspection. When you're ready to resume, un-pause the script via the File or Tray menu. The script will then continue until reaching the next "break point" (if any).

It is generally best to insert these "break points" at positions where the active window does not matter to the script, such as immediately before a WinActivate command. This allows the script to properly resume operation when you un-pause it.

The following commands are also useful for debugging: [ListLines](commands/ListLines.htm), [KeyHistory](commands/KeyHistory.htm), and [OutputDebug](commands/OutputDebug.htm).

Some common errors, such as typos and missing "global" declarations, can be detected by [enabling warnings](commands/_Warn.htm).

### Interactive Debugging [AHK\_L 11+]

Interactive debugging is possible with a supported [DBGp client](AHKL_DBGPClients.htm). Typically the following actions are possible:

- Set and remove breakpoints on lines - pause execution when a[breakpoint](https://en.wikipedia.org/wiki/Breakpoint) is reached.
- Step through code line by line - step into, over or out of functions and subroutines.
- Inspect all variables or a specific variable.
- View the stack of running subroutines and functions.

Note that this functionality is disabled for compiled scripts.

To enable interactive debugging, first launch a supported debugger client then launch the script with the **/Debug** command-line switch.

```
AutoHotkey.exe /Debug<span class="optional">=<i>SERVER</i>:<i>PORT</i></span> ...
```

_SERVER_ and _PORT_ may be omitted. For example, the following are equivalent:

```
AutoHotkey /Debug "myscript.ahk"
AutoHotkey /Debug=localhost:9000 "myscript.ahk"
```

[AHK\_L 59+]: To attach the debugger to a script which is already running, send it a message as shown below:

```
ScriptPath := "" <em>; SET THIS TO THE FULL PATH OF THE SCRIPT</em>
DetectHiddenWindows On
if WinExist(ScriptPath " ahk_class AutoHotkey")
    <em>; Optional parameters:
    ;   wParam  = the IPv4 address of the debugger client, as a 32-bit integer.
    ;   lParam  = the port which the debugger client is listening on.</em>
    PostMessage DllCall("RegisterWindowMessage", "str", "AHK_ATTACH_DEBUGGER")

```

Once the debugger client is connected, it may detach without terminating the script by sending the "detach" DBGp command.

## Script Showcase

See [this page](scripts/) for some useful scripts.

