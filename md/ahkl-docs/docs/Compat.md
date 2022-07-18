# Script Compatibility

Although many scripts written for AutoHotkey 1.0 do not require changes to run on AutoHotkey 1.1, some may function incorrectly due to necessary differences between the two versions. As the most problematic differences only affect advanced functionality like DllCall(), most users do not need to be concerned.

AutoHotkey 1.1 is also known as "AutoHotkey\_L", while AutoHotkey 1.0 was retrospectively labelled "AutoHotkey Basic". Some older versions of AutoHotkey\_L used 1.0.\* version numbers, so for clarity, this document refers to the two branches of AutoHotkey by name rather than version number.

**Note:** Some of the most common problems are caused by changes required to support Unicode text, and can be avoided by simply using the ANSI version of AutoHotkey\_L.

## Table of Contents

### Basic

High impact:

- [Certain syntax errors are no longer tolerated](#Syntax_Errors)
- [FileRead may return corrupt binary data](#FileRead)
- [Variable and function names do not allow [, ] or ?](#Names)
- [DPI scaling is enabled by default for GUIs](#DPIScale)

Medium impact:

- [Transform's _Unicode_ sub-command is unavailable on Unicode versions](#Transform)
- [AutoHotkey.ahk is launched instead of AutoHotkey.ini](#Default_Script)
- [SetFormat, Integer, **H** is case-sensitive](#SetFormat)
- [A\_LastError is modified by more commands](#LastError)
- [MsgBox's handles commas more consistently](#MsgBox)
- [Gui +Owner overrides additional styles](#GuiOwner)
- [SoundSet and SoundGet work better on Vista and later](#VistaSound)
- [~Tilde affects how custom modifier keys work](#Tilde)
- [`x & y::` causes both `x::` and `x up::` to fire when x is released](#ComboUpDown)

Low impact:

- [If _var_ is _type_ ignores the system locale by default](#IfIs)
- [GroupActivate sets ErrorLevel and GroupAdd's _Label_ works differently](#Window_Groups)
- [Run and RunWait interpret _Target_ differently](#Run)
- [Control-Z is not interpreted as end-of-file](#ControlZ)
- [Compatibility mode may cause confusion](#Compatibility_Mode)
- [A\_IsCompiled is always read-only](#IsCompiled)
- [Leading and trailing \`t sequences are no longer discarded](#Escaped_Whitespace)

### Advanced

- [Unicode vs ANSI](#Format)
  - [VarSetCapacity](#VarSetCapacity)
  - [DllCall](#DllCall)
  - [NumPut / NumGet](#NumPutGet)
- [Pointer Size](#ptr)

## Basic

### Syntax Errors

Certain syntax errors which were tolerated by AutoHotkey Basic are not tolerated by AutoHotkey\_L. Most such errors can be easily corrected once they are identified. The following errors are detected immediately upon launching a script in AutoHotkey\_L, and must be corrected for the script to run:

- A space, tab or comma is required between each command and its parameters. For example,`MsgBox< foo` and `If!foo` are not tolerated.
- `Hotkey, If<i>Something</i>`, where _Something_ is invalid, is not tolerated.

Some other syntax errors are detected while the script is running. These cause an error message to be displayed prior to exiting the current thread:

- **Common:** Unrecognized or badly formatted [Gui](commands/Gui.htm#Options), [Gui Show](commands/Gui.htm#Show) or [GuiControl](commands/GuiControl.htm) options.
- GroupAdd with a blank group name. Previously this caused the thread to_silently_ exit.
- Gui option[+LastFoundExist](commands/Gui.htm#LastFoundExist) must not be combined with another option, since that would cause it to act the same as [+LastFound](commands/Gui.htm#LastFound).

Some other syntax errors are currently not detected, but cause problems with AutoHotkey\_L:

- [Auto-concat](Variables.htm#concat) with `(` is more selective, so some invalid expressions like `12(34)` no longer work.

### FileRead

[FileRead](commands/FileRead.htm#Binary) translates text between code pages in certain common cases and therefore might output corrupt binary data. To avoid this, add the `*c` option or use [FileOpen()](commands/FileOpen.htm) instead.

### Variable and Function Names

The characters `[`, `]` and `?` are reserved for use in [expressions](Variables.htm#Expressions), so are no longer valid in variable names. Consequently, `?` (used in [ternary operations](Variables.htm#ternary)) no longer requires a space on either side. See also [object syntax](Objects.htm#Syntax).

Errors may or may not be detected automatically:

- If a script used these characters in variable names in expressions, generally the script will run without displaying an error message, but will misbehave as the characters will be interpreted as operators rather than as part of a variable name.
- If these characters are used in a[double-deref](Variables.htm#ref) (such as `Array%n%` where _n_ contains one of the above characters), an error message is displayed when the double-deref is evaluated, while the script is running.
- If these characters are used in other contexts, such as on the left hand side of an assignment, in the name of a command's input/output variable or between %percent% signs, an error message is displayed and the script is prevented from launching.

### DPI Scaling

[DPI scaling](commands/Gui.htm#DPIScale) is enabled by default for script GUIs to ensure they scale according to the [system DPI setting](Variables.htm#ScreenDPI). If enabled and the system DPI setting is not 96 (100%), positions and sizes accepted by or returned from Gui commands are not compatible with other commands. To disable DPI scaling, use `Gui -DPIScale`.

### Transform

Some _Transform_ sub-commands are altered or unavailable in Unicode versions of AutoHotkey\_L:

- [Transform, Unicode](commands/Transform.htm#Unicode) is unavailable. To assign Unicode text to the clipboard, use a regular assignment. See also: [StrPut()](commands/StrPut.htm) / [StrGet()](commands/StrGet.htm).
- [Transform, HTML](commands/Transform.htm#HTML) supports additional features.

### Default Script

When AutoHotkey\_L is launched without specifying a script, an .ahk file is loaded by default instead of an .ini file. The name of this file depends on the filename of the current executable. For more details, see [Passing Command Line Parameters to a Script](Scripts.htm#cmd).

### SetFormat, Integer[Fast], H

When an uppercase H is used, hexadecimal digits A-F will also be in uppercase. AutoHotkey Basic always uses lowercase digits. See [SetFormat](commands/SetFormat.htm).

### A\_LastError

The following commands now set [A\_LastError](Variables.htm#LastError) to assist with debugging: FileAppend, FileRead, FileReadLine, FileDelete, FileCopy, FileMove, FileGetAttrib/Time/Size/Version, FileSetAttrib/Time, FileCreateDir, RegRead, RegWrite, RegDelete. Using any of these commands causes the previous value of A\_LastError to be overwritten.

### MsgBox

[MsgBox](commands/MsgBox.htm)'s smart comma handling has been changed to improve flexibility and consistency with all other commands. In most cases, MsgBox will just work as intended. In some rare cases, scripts relying on the old quirky behaviour may observe a change in behaviour. For instance:

```
<em>; This is now interpreted as an expression (Options) followed by text (Title)
; instead of as a single expression (Text) with multiple <a href="Variables.htm#comma" data-index="48">sub-expressions</a>:</em>
MsgBox % x, y
<em>; Parentheses can be added to force the old interpretation:</em>
MsgBox % (x, y)

<em>; This now shows an empty dialog instead of the text "0, Title":</em>
MsgBox 0, Title
<em>; These behave as expected in both AutoHotkey_L and AutoHotkey Basic:</em>
MsgBox 0, Title, % ""   <em>; Shows an empty dialog</em>
MsgBox 0`, Title        <em>; Shows the text "0, Title"</em>

<em>; This now shows an empty dialog instead of the text ", Title":</em>
MsgBox,, Title

```

### Gui +Owner

Applying the [+Owner](commands/Gui.htm#Owner) option to a Gui also removes the WS\_CHILD style and sets the WS\_POPUP style. This may break scripts which used `+Owner` to set the parent window of a Gui _after_ setting the styles.

### Sound Commands on Windows Vista and later

[SoundSet](commands/SoundSet.htm), [SoundGet](commands/SoundGet.htm), [SoundSetWaveVolume](commands/SoundSetWaveVolume.htm) and [SoundGetWaveVolume](commands/SoundGetWaveVolume.htm) have improved support for Windows Vista and later. Typical changes in behaviour include:

- Scripts affecting the whole system (as is usually intended) instead of just the script itself.
- Devices being numbered differently - each output or input is considered a separate device.

### ~Tilde and Custom Combination Hotkeys

As of [v1.1.14], the [tilde prefix](Hotkeys.htm#Tilde) affects how a key works when used as a modifier key in a custom combination.

### Custom Combinations and Down/Up Hotkeys

Except when the tilde prefix is used, if both a key-down and a key-up hotkey are defined for a custom modifier key, they will both fire when the key is released. For example, `x & y::` causes both `x::` and `x up::` to fire when x is released, where previously `x::` never fired.

### If _var_ is _type_

[If _var_ is _type_](commands/IfIs.htm) ignores the system locale unless [StringCaseSense, Locale](commands/StringCaseSense.htm) has been used.

### Window Groups

[GroupActivate](commands/GroupActivate.htm) sets ErrorLevel to 1 if no window was found to activate or 0 otherwise. Previously, ErrorLevel was left unchanged.

[GroupAdd](commands/GroupAdd.htm)'s _Label_ parameter applies to the window group as a whole instead of to one particular window specification within the group. A discussion of this change can be found [on the forums](https://www.autohotkey.com/community/viewtopic.php?t=61362). However, using this parameter is **not recommended**; check ErrorLevel after calling GroupActivate instead.

### Run / RunWait

AutoHotkey\_L includes some enhancements to the way the [Run](commands/Run.htm) and [RunWait](commands/Run.htm) commands interpret the _Target_ parameter. This allows some things that didn't work previously, but in some very rare cases, may also affect scripts which were already working in AutoHotkey Basic. The new behaviour is as follows:

- If_Target_ begins with a quotation mark, everything up to the next quotation mark is considered the action, typically an executable file.
- Otherwise the first substring which ends at a space and is either an existing file or ends in .exe, .bat, .com, .cmd or .hta is considered the action. This allows file types such as .ahk, .vbs or .lnk to accept parameters while still allowing "known" executables such as wordpad.exe to be launched without an absolute path as in previous versions.

### Control-Z

[Loop Read](commands/LoopReadFile.htm) and [FileReadLine](commands/FileReadLine.htm) no longer interpret the character Ctrl+Z (0x1A) as an end-of-file marker. Any Ctrl+Z, even one appearing at the very end of the file, is loaded as-is. [FileRead](commands/FileRead.htm) already ignored this character, so is not affected by this issue.

### Compatibility Mode

If [Compatibility mode](https://support.microsoft.com/en-us/help/15078/windows-make-older-programs-compatible) is set to Windows 95, 98/ME or NT4 in the properties of the EXE file used to run the script, the script may not behave correctly. This is because compatibility mode causes a specific version of Windows to be reported to the application, but AutoHotkey\_L omits support for these versions. For example, setting compatibility mode to Windows 95 or 98/ME will cause `MsgBox %A_OSVersion%` to report `WIN_NT4`.

### A\_IsCompiled

[A\_IsCompiled](Variables.htm#IsCompiled) is defined as an empty string if the script has not been compiled. Previously it was left undefined, which meant that assignments such as `A_IsCompiled := 1` were valid if the script hadn't been compiled. Now it is treated as a read-only built-in variable in all cases.

### Escaped Whitespace

Escaped whitespace characters such as `` `t`` and `` ` `` are no longer trimmed from the beginning and end of each arg. For example, ``StringReplace s, s, `t`` is now valid and will remove all tab characters from _s_.

## Unicode vs ANSI

**Note:** This section builds on topics covered in other parts of the documentation: [Strings](Concepts.htm#strings), [String Encoding](Concepts.htm#string-encoding).

Within a string (text value), the numeric character code and size (in bytes) of each character depends on the [native encoding](Concepts.htm#native-encoding) of the script or AutoHotkey executable; i.e. _Unicode_ or _ANSI_. These details are typically important for scripts which do any of the following:

- Pass strings to external functions via[DllCall](#DllCall).
- Pass strings via[PostMessage/SendMessage](commands/PostMessage.htm).
- Manipulate strings directly via[NumPut/NumGet](#NumPutGet).
- Use[VarSetCapacity](#VarSetCapacity) to ensure a variable can hold a specific number of characters.

Scripts designed with one particular format in mind will often encounter problems when run on the wrong version of AutoHotkey. For instance, some scripts written for AutoHotkey Basic will function correctly on the ANSI version of AutoHotkey\_L but fail on Unicode versions. If you aren't sure which version you are using, run the following script:

```
MsgBox % <a href="Variables.htm#IsUnicode" data-index="74">A_IsUnicode</a> ? "Unicode" : "ANSI"
```

**ANSI:** Each character is **one byte** (8 bits). Character codes above 127 depend on your system's language settings.

**Unicode:** Each character is **two bytes** (16 bits). Character codes are as defined by the [UTF-16](https://en.wikipedia.org/wiki/UTF-16) format.

_Semantic note:_ Technically, some Unicode characters are represented by _two_ 16-bit code units, collectively known as a "surrogate pair." Similarly, some [ANSI code pages](http://msdn.microsoft.com/en-us/library/dd317752.aspx) (commonly known as [Double Byte Character Sets](http://msdn.microsoft.com/en-us/library/dd317794.aspx)) contain some double-byte characters. However, for practical reasons these are almost always treated as two individual units (referred to as "characters" for simplicity).

### VarSetCapacity

VarSetCapacity sets the capacity of a var _in bytes_. To set a variable's capacity based on the number of characters, the size of a character must be taken into account. For example:

```
VarSetCapacity(ansi_var,    capacity_in_chars)
VarSetCapacity(unicode_var, capacity_in_chars * 2)
VarSetCapacity(native_var,  capacity_in_chars * (A_IsUnicode ? 2 : 1))
VarSetCapacity(native_var,  t_size(capacity_in_chars))  <em>; see <a href="#NumPutGet" data-index="78">below</a></em>

```

There are two main uses for VarSetCapacity:

1. Expand a variable to hold an estimated number of characters, to enhance performance when building a string by means of gradual concatenation. For example,`VarSetCapacity(var, 1000)` allows for 1000 bytes, which is only 500 characters on Unicode versions of AutoHotkey\_L. This could affect performance, but the script should still function correctly.
2. Resize a variable to hold a binary structure. If the structure directly contains text, the format of that text must be taken into account. This depends on the structure - sometimes ANSI text will be used even in a Unicode version of AutoHotkey\_L. If the variable is too small, the script may crash or otherwise behave unpredictably (depending on how the structure is used).

### DllCall

When the "Str" type is used, it means a string in the native format of the current build. Since some functions may require or return strings in a particular format, the following string types are available:

Char SizeC / Win32 TypesEncodingWStr16-bitwchar\_t\*, WCHAR\*, LPWSTR, LPCWSTRUTF-16AStr8-bitchar\*, CHAR\*, LPSTR, LPCSTRANSI (the system default ANSI code page)Str--TCHAR\*, LPTSTR, LPCTSTREquivalent to **WStr** in Unicode builds and **AStr** in ANSI builds.

If "Str" or the equivalent type for the current build is used as a parameter, the address of the string or var is passed to the function, otherwise a temporary copy of the string is created in the desired format and passed instead. As a general rule, "AStr" and "WStr" should not be used if the function writes a value into that parameter.

**Note:** "AStr" and "WStr" are equally valid for parameters and the function's return value.

In general, if a script calls a function via DllCall() which accepts a string as a parameter, one of the following approaches must be taken:

1. If both Unicode (W) and ANSI (A) versions of the function are available, call the appropriate one for the current build. In the following example, "DeleteFile" is internally known as "DeleteFileA" or "DeleteFileW". Since "DeleteFile" itself doesn't really exist, DllCall() automatically tries "A" or "W" as appropriate for the current build:


   ```
   DllCall("DeleteFile", "Ptr", &filename)
   DllCall("DeleteFile", "Str", filename)
   ```


   In this example, `&filename` passes the address of the string exactly as-is, so the function must expect a string in the same format as the "Str" type. Note that "UInt" must be used in place of "Ptr" in AutoHotkey Basic, but the resulting code may not be 64-bit compatible.

   **Note:** If the function cannot be found exactly as specified, AutoHotkey\_L appends the "A" or "W" suffix regardless of which DLL is specified. However, AutoHotkey Basic appends the "A" suffix only for functions in User32.dll, Kernel32.dll, ComCtl32.dll, or Gdi32.dll.

2. If the function only accepts a specific type of string as input, the script may use the appropriate string type:


   ```
   DllCall("DeleteFileA", "AStr", filename)
   DllCall("DeleteFileW", "WStr", filename)
   ```

3. If the function must modify a string (in a non-native format), the script must allocate a buffer as described[above](#VarSetCapacity) and pass its address to the function. If the parameter accepts input, the script must also convert the input string to the appropriate format; this can be done using [StrPut()](commands/StrPut.htm).

### NumPut / NumGet

When NumPut() or NumGet() are used with strings, the offset and type must be correct for the given type of string. The following may be used as a guide:

```
<em>;  8-bit/ANSI   strings:  size_of_char=1  type_of_char="Char"
; 16-bit/UTF-16 strings:  size_of_char=2  type_of_char="UShort"</em>
<i>n</i>th_char := NumGet(var, (<i>n</i>-1)*<i>size_of_char</i>, <i>type_of_char</i>)
NumPut(<i>n</i>th_char, var, (<i>n</i>-1)*<i>size_of_char</i>, <i>type_of_char</i>)
```

If `var` contains a string in the native format, the appropriate values may be determined based on the value of `A_IsUnicode`:

```
<i>n</i>th_char := NumGet(var, t_size(<i>n</i>-1), t_char())
NumPut(<i>n</i>th_char, var, t_size(<i>n</i>-1), t_char())

<em>; Define functions for convenience and clarity:</em>
t_char() {
    return A_IsUnicode ? "UShort" : "Char"
}
t_size(char_count=1) {
    return A_IsUnicode ? char_count*2 : char_count
}
```

## Pointer Size

Pointers are 4 bytes in 32-bit builds (including AutoHotkey Basic) and 8 bytes in 64-bit builds. Scripts using structures or DllCalls may need to account for this to run correctly on both platforms. Specific areas which are affected include:

- Offset calculation for fields in structures which contain one or more pointers.
- Size calculation for structures containing one or more pointers.
- Type names used with[DllCall()](commands/DllCall.htm), [NumPut()](commands/NumPut.htm) or [NumGet()](commands/NumGet.htm).

For size and offset calculations, use [A\_PtrSize](Variables.htm#PtrSize). For DllCall(), NumPut() and NumGet(), use the [Ptr](commands/DllCall.htm) type where appropriate.

Remember that the offset of a field is usually the total size of all fields preceding it. Also note that handles (including types like HWND and HBITMAP) are essentially pointer-types.

```
<em>/*
  typedef struct _PROCESS_INFORMATION {
    HANDLE hProcess;    // Ptr
    HANDLE hThread;
    DWORD  dwProcessId; // UInt (4 bytes)
    DWORD  dwThreadId;
  } <a href="http://msdn.microsoft.com/en-us/library/ms684873.aspx" data-index="86">PROCESS_INFORMATION</a>, *LPPROCESS_INFORMATION;
*/</em>
VarSetCapacity(pi, A_PtrSize*2 + 8) <em>; Ptr + Ptr + UInt + UInt</em>
DllCall("<a href="http://msdn.microsoft.com/en-us/library/ms682425.aspx" data-index="87">CreateProcess</a>", <span class="dull"><omitted for brevity></span>, "Ptr", &pi, <span class="dull"><omitted></span>)
hProcess    := NumGet(pi, 0)         <em>; Defaults to "Ptr".</em>
hThread     := NumGet(pi, A_PtrSize) <em>;</em>
dwProcessId := NumGet(pi, A_PtrSize*2,     "UInt")
dwProcessId := NumGet(pi, A_PtrSize*2 + 4, "UInt")

```

