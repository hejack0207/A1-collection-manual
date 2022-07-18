# SetRegView [v1.1.08+]

Sets the registry view used by [RegRead](RegRead.htm), [RegWrite](RegWrite.htm), [RegDelete](RegDelete.htm) and [registry loops](LoopReg.htm), allowing them in a 32-bit script to access the 64-bit registry view and vice versa.

```
<span class="func">SetRegView</span>, RegView
```

## Parameters

RegView

Specify **32** to view the registry as a 32-bit application would, or **64** to view the registry as a 64-bit application would.

Specify the word **Default** to restore normal behaviour.

## General Remarks

This command is only useful on Windows 64-bit. It has no effect on Windows 32-bit.

On 64-bit systems, 32-bit applications run on a subsystem of Windows called [WOW64](http://msdn.microsoft.com/en-us/library/aa384249). By default, the system redirects certain [registry keys](http://msdn.microsoft.com/en-us/library/aa384253) to prevent conflicts. For example, in a 32-bit script, `HKLM\SOFTWARE\AutoHotkey` is redirected to `HKLM\SOFTWARE\Wow6432Node\AutoHotkey`. SetRegView allows the registry commands in a 32-bit script to access redirected keys in the 64-bit registry view and vice versa.

The built-in variable _A\_RegView_ contains the current setting. Every newly launched [thread](../misc/Threads.htm) (such as a [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timed](SetTimer.htm) subroutine) starts off fresh with the default setting for this command. That default may be changed by using this command in the auto-execute section (top part of the script).

## Related

[RegRead](RegRead.htm), [RegWrite](RegWrite.htm), [RegDelete](RegDelete.htm), [Loop (registry)](LoopReg.htm)

## Examples

Shows how to set a specific registry view, and how registry redirection affects the script.

```
<em>; Access the registry as a 32-bit application would.</em>
SetRegView 32
RegWrite REG_SZ, HKLM, SOFTWARE\Test.ahk, Value, 123

<em>; Access the registry as a 64-bit application would.</em>
SetRegView 64
RegRead value, HKLM, SOFTWARE\Wow6432Node\Test.ahk, Value
RegDelete HKLM, SOFTWARE\Wow6432Node\Test.ahk

MsgBox Read value '%value%' via Wow6432Node.

<em>; Restore the registry view to the default, which
; depends on whether the script is 32-bit or 64-bit.</em>
SetRegView Default
<em>;...</em>

```

Shows how to detect the type of EXE and operating system on which the script is running.

```
if (A_PtrSize = 8)
    script_is := "64-bit"
else <em>; if (A_PtrSize = 4)</em>
    script_is := "32-bit"

if (A_Is64bitOS)
    OS_is := "64-bit"
else
    OS_is := "32-bit, which has only a single registry view"

MsgBox This script is %script_is%, and the OS is %OS_is%.
```

