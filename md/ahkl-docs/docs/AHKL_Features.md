# AutoHotkey\_L New Features

This document describes features added in the AutoHotkey\_L branch of AutoHotkey development, now simply known as "AutoHotkey 1.1".

**Caution:** This document has been neglected in recent years and may be missing some of the more recent changes.

## Control Flow

FeatureDescription[Break _LoopLabel_](commands/Break.htm)Break out of a loop or any number of nested loops.[Continue _LoopLabel_](commands/Continue.htm)Continue a loop, even from within any number of nested loops.[For _x_, _y_ in _z_](commands/For.htm)Loop through the contents of an object.[Loop Until](commands/Until.htm)Loop until a condition is true. Applicable to any type of Loop.[Try](commands/Try.htm)... [Catch](commands/Catch.htm)... [Finally](commands/Finally.htm)Provides structured exception handling.[Throw](commands/Throw.htm)Throws an exception.

## Commands

FeatureDescription[FileEncoding](commands/FileEncoding.htm)Sets the default encoding for [FileRead](commands/FileRead.htm), [FileReadLine](commands/FileReadLine.htm), [Loop Read](commands/LoopReadFile.htm), [FileAppend](commands/FileAppend.htm), and [FileOpen()](commands/FileOpen.htm).

_See also:_ [Text Encodings](#enc)[Gui](commands/Gui.htm)See [GUI Enhancements](#GUI_Enhancements) below.[IniRead](commands/IniRead.htm)/ [Write](commands/IniWrite.htm)/ [Delete](commands/IniDelete.htm)Read, write or delete entire sections, or retrieve a list of all section names.[Menu, Icon](commands/Menu.htm#MenuIcon)Sets or removes a menu item's icon.[Run](commands/Run.htm)[Improvements](Compat.htm#Run) were made to the way parameters are parsed.[SendInput {U+nnnn}](commands/Send.htm#Unicode)Sends a Unicode character. Unicode characters may be used directly in Unicode builds.[SendLevel](commands/SendLevel.htm)Controls which artificial keyboard and mouse events are ignored by hotkeys and hotstrings.[SetFormat, IntegerFast, h\|H](commands/SetFormat.htm)Set lower-case or upper-case hexadecimal format.[SetRegView, RegView](commands/SetRegView.htm)Allows registry commands in a 32-bit script to access the 64-bit registry view and vice versa.[Transform, HTML](commands/Transform.htm#HTML)Perform code page or HTML transformations.[WinGet, ..., ProcessPath](commands/WinGet.htm#ProcessPath)Retrieves the full path and name of the process that owns a given window.

## Directives

FeatureDescription[#If _expression_](commands/_If.htm)Similar to [#IfWinActive](commands/_IfWinActive.htm), but for arbitrary expressions.[#IfTimeout](commands/_IfTimeout.htm)Sets the maximum time that may be spent evaluating a single #If expression.[#MenuMaskKey](commands/_MenuMaskKey.htm)Changes which key is used to mask Win or Alt keyup events.[#Include <Lib>](commands/_Include.htm)Includes a script file from a function library folder.[#InputLevel](commands/_InputLevel.htm)Controls which artificial keyboard and mouse events are ignored by hotkeys and hotstrings.[#Warn](commands/_Warn.htm)Enables or disables warnings for selected conditions that may be indicative of developer errors.

## Functions

FeatureDescription[ComObj...](commands/ComObjActive.htm) --

ComObjActive

ComObjEnwrap/Unwrap

ComObjParameter

ComObjType

Retrieves a registered COM object.

Wraps/unwraps a COM object.

Wraps a value and type to pass as a parameter.

Retrieves a COM object's type information.[ComObjArray](commands/ComObjArray.htm)Creates a SAFEARRAY for use with COM.[ComObjConnect](commands/ComObjConnect.htm)Connects a COM object's event sources to functions with a given prefix.[ComObjCreate](commands/ComObjCreate.htm)Creates a COM object.[ComObjError](commands/ComObjError.htm)Enables or disables notification of COM errors.[ComObjFlags](commands/ComObjFlags.htm)Retrieves or changes flags which control a COM wrapper object's behaviour.[ComObjGet](commands/ComObjGet.htm)Returns a reference to an object provided by a COM component.[ComObjQuery](commands/ComObjQuery.htm)Queries a COM object for an interface or service.[ComObjType](commands/ComObjType.htm)Retrieves type information from a COM object.[ComObjValue](commands/ComObjValue.htm)Retrieves the value or pointer stored in a COM wrapper object.[Exception](commands/Throw.htm#Exception)Creates an exception object for [Throw](commands/Throw.htm) (also provides limited access to the call stack).[FileOpen](commands/FileOpen.htm)Provides object-oriented file I/O.[Func](commands/Func.htm)Retrieves a [reference](Objects.htm#Function_References) to a function.[GetKeyName/VK/SC](commands/GetKey.htm)Retrieves the name or text, virtual key code or scan code of a key.[InStr](commands/InStr.htm)Searches for a given _occurrence_ of a string, from the left or the right.[IsByRef](commands/IsByRef.htm)Determines whether a ByRef parameter was supplied with a variable.[IsObject](Objects.htm)Determines whether a value is an object.[StrPut](commands/StrPut.htm) / [StrGet](commands/StrGet.htm)Copies a string to or from a memory address, optional converting it between code pages.[Trim](commands/Trim.htm)Trims certain characters from the beginning and/or end of a string.[RegEx (?C _Num_: _Func_)](misc/RegExCallout.htm)Calls a function during evaluation of a regex pattern.[Function Libraries](#Function_Libraries)New "local library" and `#Include <LibName>`.[Variadic Functions](Functions.htm#Variadic)Functions may accept a variable number of parameters via an array.[Static Initializers](#Static)Static variables can now be initialized using any expression.

## Objects

FeatureDescription[General](Objects.htm)Behaviour and usage of objects in general.[Object](Objects.htm#Arrays)Associative arrays which can be extended with other functionality.[Enumerator](objects/Enumerator.htm)Allows items in a collection to be enumerated.[File](objects/File.htm)Provides an interface to access a file. [FileOpen()](commands/FileOpen.htm) returns an object of this type.[Func](objects/Func.htm)Represents a user-defined or built-in function which can be called by the script.ComObjectSee ComObj functions above.

## Variables

FeatureDescriptionA\_Is64bitOSContains 1 (true) if the OS is 64-bit or 0 (false) if it is 32-bit.A\_IsUnicodeIn Unicode builds, this variable contains 1 ( _true_). In ANSI builds it is not defined, so is effectively _false_.A\_FileEncodingContains the default encoding for various commands; see [FileEncoding](commands/FileEncoding.htm).A\_OSVersionSupports Windows 7 and Windows 8; see [A\_OSVersion](Variables.htm#OSVersion).A\_PriorKeyThe name of the last key which was pressed prior to the most recent key-press or key-release ... [(More)](Variables.htm#PriorKey)A\_PtrSizeContains the size of a pointer, in bytes. This is either 4 (32-bit) or 8 (64-bit).A\_RegViewThe current registry view as set by [SetRegView](commands/SetRegView.htm).A\_ScriptHwndThe unique ID (HWND/handle) of the script's hidden main window.

## Datatypes

FeatureDescription[Ptr](commands/DllCall.htm#ptr)Equivalent to _Int_ in 32-bit builds and _Int64_ in 64-bit builds. Supported by [DllCall()](commands/DllCall.htm), [NumPut()](commands/NumPut.htm) and [NumGet()](commands/NumGet.htm).[AStr](commands/DllCall.htm#astr), [WStr](commands/DllCall.htm#astr)Supported only by [DllCall()](commands/DllCall.htm); see [Script Compatibility](Compat.htm).

## Unicode

FeatureDescription[Compatibility](Compat.htm)How to deal with Unicode in DllCall(), etc.[Script Files](Scripts.htm#cp)Using Unicode in script files.[SendInput](commands/Send.htm#Unicode)Using Unicode with SendInput.

## Other

FeatureDescription[ahk\_exe](misc/WinTitle.htm#ahk_exe)Windows can be identified by the name or path of the process (EXE file) which owns them.[Debugging](Scripts.htm#idebug)Interactive debugging features (line by line execution etc.).[Error Handling](#Error_Handling)Try/catch/throw and increased usefulness for A\_LastError.[GUI Enhancements](#GUI_Enhancements)Various enhancements to the Gui command and related.[Icon Support](#icons)Resource identifiers and improved support for various icon sizes.[Other Changes](Compat.htm)Changes affecting script compatibility.[Version History](AHKL_ChangeLog.htm)History of AutoHotkey\_L revisions.

## Error Handling

Many commands support using [try](commands/Try.htm)/ [catch](commands/Catch.htm) instead of ErrorLevel for error handling. For example:

```
try
{
    FileCopy, file1.txt, C:\folder
    FileDelete, C:\folder\old.txt
}
catch
    MsgBox An error occured!
```

Additionally, the following commands now set [A\_LastError](Variables.htm#LastError) to assist with debugging: FileAppend, FileRead, FileReadLine, FileDelete, FileCopy, FileMove, FileGetAttrib/Time/Size/Version, FileSetAttrib/Time, FileCreateDir, RegRead, RegWrite, RegDelete.

## Function Libraries

In addition to the user library in `%A_MyDocuments%\AutoHotkey\Lib` and standard library in the AutoHotkey directory, functions may be auto-included from the "local library" which resides in `%A_ScriptDir%\Lib`. For more information, see [Libraries of Functions](Functions.htm#lib).

[#Include <LibName>](commands/_Include.htm) explicitly includes a library file which may be located in any one of the function libraries.

## GUI Enhancements

A number of enhancements have been made to the [Gui](commands/Gui.htm) command and related:

- A[name or HWND](commands/Gui.htm#MultiWin) can be used instead of a number between 1 and 99 when referring to a GUI.
- [Gui, New](commands/Gui.htm#New) creates a new anonymous GUI.
- Any number of named or anonymous GUIs can be created.
- New GUI options:[+Hwnd _OutputVar_](commands/Gui.htm#GuiHwndOutputVar), [+Parent _GUI_](commands/Gui.htm#Parent)
- A GUI's owner can be any arbitrary window:[+Owner _%HWND%_](commands/Gui.htm#Owner).
- [Gui, Font](commands/Gui.htm#fontq) can control anti-aliasing of text.
- [ActiveX controls](commands/GuiControls.htm#ActiveX) such as the Internet Explorer WebBrowser control are supported.
- [GuiControlGet, _OutputVar_, Name](commands/GuiControlGet.htm#Name) gets the name of the variable associated with a GUI control.
- Keyboard accelerators such asCtrl+O are supported automatically when used in [Gui menus](commands/Gui.htm#Menu).
- [Font quality](commands/Gui.htm#fontq) can be controlled by the Font sub-command.

## Static Variables

Static variables can now be initialized using any expression. For example:

```
Sleep 500
MsgBox % Time() "ms since the script started."
Time() {
    static Tick := A_TickCount
    return A_TickCount - Tick
}
```

## Text Encodings

[FileRead](commands/FileRead.htm), [FileReadLine](commands/FileReadLine.htm), [Loop Read](commands/LoopReadFile.htm) and [FileAppend](commands/FileAppend.htm) support the majority of Windows-supported text encodings, not just the system default ANSI code page. [FileEncoding](commands/FileEncoding.htm) can be used to set the default encoding, which can be overridden for FileRead and FileAppend as follows:

```
<span class="func">FileRead</span>, OutputVar, *P<i>nnn</i> Filename
<span class="func">FileAppend</span> <span class="optional">, Text, Filename, Encoding</span>

```

While _nnn_ must be a numeric [code page identifier](http://msdn.microsoft.com/en-us/library/dd317756.aspx), _Encoding_ follows the same format as [FileEncoding](commands/FileEncoding.htm).

**See also:** [Script Compatibility](Compat.htm#FileRead)

## Variadic Functions and Function-Calls

[Variadic functions](Functions.htm#Variadic) can receive a variable number of parameters via an array, while [variadic function-calls](Functions.htm#VariadicCall) can be used to pass a variable number of parameters to a function.

## Improvements to Icon Support

### Unusual Sizes

Icon resources of any size supported by the operating system may be extracted from executable files. When multiple sized icon resources exist within an icon group, the most appropriate size is used. Prior to revision 17, an arbitrary icon resource was selected by the system, scaled to the system large icon size, then scaled back to the requested size.

### Resource Identifiers

Negative icon numbers may be used to identify a group icon resource within an executable file. For example, the following sets the tray icon to the default icon used by ahk files:

```
Menu, Tray, Icon, %A_AhkPath%, -160
```

