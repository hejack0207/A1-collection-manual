# Using the Program

AutoHotkey doesn't do anything on its own; it needs a script to tell it what to do. A script is simply a plain text file with the `.ahk` filename extension containing instructions for the program, like a configuration file, but much more powerful. A script can do as little as performing a single action and then exiting, but most scripts define a number of [hotkeys](Hotkeys.htm), with each hotkey followed by one or more actions to take when the hotkey is pressed.

```
#z::Run https://www.autohotkey.com  <em>; Win+Z</em>

^!n::  <em>; Ctrl+Alt+N</em>
if WinExist("Untitled - Notepad")
    WinActivate
else
    Run Notepad
return
```

**Tip:** If your browser supports it, you can download any code block (such as the one above) as a script file by clicking the button which appears in the top-right of the code block when you hover your mouse over it.

## Table of Contents

- [Create a Script](#create)
- [Edit a Script](#edit)
- [Run a Script](#run)
- [Tray Icon](#tray-icon)
- [Main Window](#main-window)
- [Embedded Scripts](#embedded-scripts)
- [Command Line Usage](#cmd)
- [Portability of AutoHotkey.exe](#portability)
- [Installer Options](#install)
  - [Run with UI Access](#Installer_uiAccess)

## Create a Script

There are a couple of common ways to create a script file:

- In Notepad (or a[text editor](commands/Edit.htm#Editors) of your choice), save a file with the `.ahk` filename extension. On some systems you may need to enclose the name in quotes to ensure the editor does not add another extension (such as .txt).

  Be sure to save the file as UTF-8 with BOM if it will contain non-ASCII characters. For details, see the [FAQ](FAQ.htm#nonascii).

- In Explorer, right-click in empty space in the folder where you want to save the script, then select**New** and **AutoHotkey Script**. You can then type a name for the script (taking care not to erase the `.ahk` extension if it is visible).

See [Scripting Language](Language.htm) for details about how to write a script.

## Edit a Script

To open a script for editing, right-click on the script file and select **Edit Script**. If the script is already running, you can use the [Edit](commands/Edit.htm) command or right-click the script's [tray icon](#tray-icon) and select **Edit This Script**. By default this will open Notepad, but that can be changed by writing to the registry as shown [here](commands/Edit.htm#Example). Of course, you can always open your text editor first and then open the script as you would any other text file.

After editing a script, you must run or [reload](commands/Reload.htm) the script for the changes to take effect. A running script can usually be reloaded via its [tray menu](#tray-icon).

## Run a Script

With AutoHotkey installed, there are several ways to run a script:

- Double-click a script file (or shortcut to a script file) in Explorer.
- Call AutoHotkey.exe on the command line and pass the script's filename as a[command-line parameter](Scripts.htm#cmd).
- After creating[the default script](Scripts.htm#defaultfile), launch AutoHotkey via the shortcut in the Start menu to run it.
- If AutoHotkey is pinned to the taskbar or Start menu on Windows 7 or later, recent or pinned scripts can be launched via the program's Jump List.

Most scripts have an effect only while they are running. Use the [tray menu](#tray-icon) or the [ExitApp](commands/ExitApp.htm) command to exit a script. Scripts are also forced to exit when Windows shuts down. To configure a script to start automatically after the user logs in, the easiest way is to place a shortcut to the script file in the [Startup](Variables.htm#Startup) folder.

Scripts can also be [compiled](Scripts.htm#ahk2exe); that is, combined together with an AutoHotkey binary file to form a self-contained executable (.exe) file.

## Tray Icon

By default, each script adds its own icon to the taskbar notification area (commonly known as the tray).

The tray icon usually looks like this (but the color or letter changes when the script is [paused](commands/Pause.htm) or [suspended](commands/Suspend.htm)): ![H](static/ahk16.png)

Right-click the tray icon to show the tray menu, which has the following options by default:

- Open - Open the script's[main window](#main-window).
- Help - Open the AutoHotkey offline help file.
- Window Spy - Displays various information about a window.
- Reload This Script - See[Reload](commands/Reload.htm).
- Edit This Script - See[Edit](commands/Edit.htm).
- Suspend Hotkeys -[Suspend](commands/Suspend.htm) or unsuspend hotkeys.
- Pause Script -[Pause](commands/Pause.htm) or unpause the script.
- Exit - Exit the script.

By default, double-clicking the tray icon shows the script's [main window](#main-window).

The [Menu](commands/Menu.htm) command can be used to customise the tray icon and menu.

The [#NoTrayIcon](commands/_NoTrayIcon.htm) directive can be used to hide the tray icon.

## Main Window

The script's main window is usually hidden, but can be shown via the [tray icon](#tray-icon) or one of the commands listed below to gain access to information useful for debugging the script. Items under the **View** menu control what the main window displays:

- Lines most recently executed - See[ListLines](commands/ListLines.htm).
- Variables and their contents - See[ListVars](commands/ListVars.htm).
- Hotkeys and their methods - See[ListHotkeys](commands/ListHotkeys.htm).
- Key history and script info - See[KeyHistory](commands/KeyHistory.htm).

**Known issue:** Keyboard shortcuts for menu items do not work while the script is displaying a [message box](commands/MsgBox.htm) or other dialog.

The built-in variable [A\_ScriptHwnd](Variables.htm#ScriptHwnd) contains the unique ID (HWND) of the script's main window.

Closing this window with [WinClose](commands/WinClose.htm) (even from another script) causes the script to exit, but most other methods just hide the window and leave the script running.

Minimizing the main window causes it to automatically be hidden. This is done to prevent any owned windows (such as GUI windows or certain dialog windows) from automatically being minimized, but also has the effect of hiding the main window's taskbar button. To instead allow the main window to be minimized normally, override the default handling with [OnMessage](commands/OnMessage.htm). For example:

```
; This prevents the main window from hiding on minimize:
OnMessage(0x0112, Func("PreventAutoMinimize")) <em>; WM_SYSCOMMAND = 0x0112</em>
OnMessage(0x0005, Func("PreventAutoMinimize")) <em>; WM_SIZE = 0x0005
; This prevents owned GUI windows (but not dialogs) from automatically minimizing:</em>
OnMessage(0x0018, Func("PreventAutoMinimize"))

PreventAutoMinimize(wParam, lParam, uMsg, hwnd) {
    if (uMsg = 0x0112 && wParam = 0xF020 && hwnd = A_ScriptHwnd) { <em>; SC_MINIMIZE = 0xF020</em>
        WinMinimize
        return 0 <em>; Prevent main window from hiding.</em>
    }
    if (uMsg = 0x0005 && wParam = 1 && hwnd = A_ScriptHwnd) <em>; SIZE_MINIMIZED = 1</em>
        return 0 <em>; Prevent main window from hiding.</em>
    if (uMsg = 0x0018 && lParam = 1) <em>; SW_PARENTCLOSING = 1</em>
        return 0 <em>; Prevent owned window from minimizing.</em>
}
```

### Main Window Title

The title of the script's main window is used by the [#SingleInstance](commands/_SingleInstance.htm) and [Reload](commands/Reload.htm) mechanisms to identify other instances of the same script. [Changing the title](commands/WinSetTitle.htm) prevents the script from being identified as such. The default title depends on how the script was loaded:

Loaded FromTitle ExpressionExample.ahk file`A_ScriptFullPath " - AutoHotkey v" A_AhkVersion`E:\\My Script.ahk - AutoHotkey v1.1.33.09Main resource (compiled script)`A_ScriptFullPath`E:\\My Script.exeAny other resource`A_ScriptFullPath " - " A_LineFile`E:\\My AutoHotkey.exe - \*BUILTIN-TOOL.AHK

The following code illustrates how the default title could be determined by the script itself (but the actual title can be retrieved with [WinGetTitle](commands/WinGetTitle.htm)):

```
title := A_ScriptFullPath
if !A_IsCompiled
    title .= " - AutoHotkey v" A_AhkVersion
<em>; For the correct result, this must be evaluated by the resource being executed,
; not an #include (unless the #include was merged into the script by Ahk2Exe):</em>
else if SubStr(A_LineFile, 1, 1) = "*" && A_LineFile != "*#1"
    title .= " - " A_LineFile

```

## Embedded Scripts [v1.1.34+]

Scripts may be embedded into a standard AutoHotkey .exe file by adding them as Win32 (RCDATA) resources using the [Ahk2Exe compiler](Scripts.htm#ahk2exe). To add additional scripts, see the [AddResource](misc\Ahk2ExeDirectives.htm#AddResource) compiler directive.

An embedded script can be specified on the command line or with [#Include](commands/_Include.htm) by writing an asterisk (\*) followed by the resource name. For an integer ID, the resource name must be a hash sign (#) followed by a decimal number.

The program may automatically load script code from the following resources, if present in the file:

IDSpecUsage1\*#1This is the means by which a [compiled script](Scripts.htm#ahk2exe) is created from an .exe file. This script is executed automatically and most command line switches are passed to the script instead of being interpreted by the program. External scripts and alternative embedded scripts can be executed by using the [/script](Scripts.htm#SlashScript) switch.2\*#2If present, this script is automatically "included" before any script that the program loads, and before any file specified with [/include](Scripts.htm#SlashInclude).

When the source of the main script is an embedded resource, the program acts in "compiled script" mode, with the exception that [A\_AhkPath](Variables.htm#AhkPath) always contains the path of the current executable file (the same as [A\_ScriptFullPath](Variables.htm#ScriptFullPath)). For resources other than \*#1, the resource specifier is included in [the main window's title](#title) to support [#SingleInstance](commands/_SingleInstance.htm) and [Reload](commands/Reload.htm).

When referenced from code that came from an embedded resource, [A\_LineFile](Variables.htm#LineFile) contains an asterisk (\*) followed by the resource name.

## Command Line Usage

See [Passing Command Line Parameters to a Script](Scripts.htm#cmd) for command line usage, including a list of command line switches which affect the program's behavior.

## Portability of AutoHotkey.exe

The file AutoHotkey.exe is all that is needed to launch any .ahk script.

[AHK\_L 51+]: Renaming AutoHotkey.exe also changes which script it runs [by default](Scripts.htm#defaultfile), which can be an alternative to compiling a script for use on a computer without AutoHotkey installed. For instance, _MyScript_.exe automatically runs _MyScript_.ahk if a filename is not supplied, but is also capable of running other scripts.

## Installer Options

To silently install AutoHotkey into the default directory (which is the same directory displayed by non-silent mode), pass the parameter /S to the installer. For example:

```
AutoHotkey110800_Install.exe /S
```

A directory other than the default may be specified via the /D parameter (in the absence of /S, this changes the default directory displayed by the installer). For example:

```
AutoHotkey110800_Install.exe /S /D=C:\Program Files\AutoHotkey
```

**Version**: If AutoHotkey was previously installed, the installer automatically detects which version of AutoHotkey.exe to set as the default. Otherwise, the default is Unicode 32-bit or Unicode 64-bit depending on whether the OS is 64-bit. To override which version of AutoHotkey.exe is set as the default, pass one of the following switches:

- `/A32` or `/ANSI`: ANSI 32-bit.
- `/U64` or `/x64`: Unicode 64-bit (only valid on 64-bit systems).
- `/U32`: Unicode 32-bit.

For example, the following installs silently and sets ANSI 32-bit as the default:

```
AutoHotkey110800_Install.exe /S /A32
```

**Uninstall**: To silently uninstall AutoHotkey, pass the `/Uninstall` parameter to Installer.ahk. For example:

```
"C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\Program Files\AutoHotkey\Installer.ahk" /Uninstall
```

For AutoHotkey versions older than 1.1.08.00, use `uninst.exe /S`. For example:

```
"C:\Program Files\AutoHotkey\uninst.exe" /S
```

**Note:** Installer.ahk must be run as admin to work correctly.

**Extract**: Later versions of the installer include a link in the bottom-right corner to extract setup files without installing. If this function is present, the `/E` switch can be used to invoke it from the command line. For example:

```
AutoHotkey110903_Install.exe /D=F:\AutoHotkey /E
```

**Restart scripts**[v1.1.19.02+]: In silent install/uninstall mode, running scripts are closed automatically, where necessary. Pass the `/R` switch to automatically reload these scripts using whichever EXE they were running on, **without** command line args. Setup will attempt to launch the scripts via Explorer, so they do not run as administrator if UAC is enabled.

**Taskbar buttons**[v1.1.08+]: On Windows 7 and later, taskbar buttons for multiple scripts are automatically grouped together or combined into one button by default. The _Separate taskbar buttons_ option disables this by registering each AutoHotkey executable as a [host app (IsHostApp)](https://msdn.microsoft.com/en-us/library/ee872121#APPLICATIONS).

[v1.1.24.02+]: For command-line installations, specify `/IsHostApp` or `/IsHostApp=1` to enable the option and `/IsHostApp=0` to disable it.

### Run with UI Access [v1.1.24.02+]

The installer GUI has an option "Add 'Run with UI Access' to context menus". This context menu option provides a workaround for common [UAC-related issues](FAQ.htm#uac) by allowing the script to automate administrative programs - without the script running as admin. To achieve this, the installer does the following:

- Copies AutoHotkeyA32.exe, AutoHotkeyU32.exe and (if present) AutoHotkeyU64.exe to AutoHotkey\*\_UIA.exe.
- Sets the[uiAccess attribute](https://msdn.microsoft.com/en-us/library/ee671610) in each UIA file's embedded manifest.
- Creates a self-signed digital certificate named "AutoHotkey" and signs each UIA file.
- Registers the context menu option to run the appropriate exe file.

If any these UIA files are present before installation, the installer will automatically update them even if the UI Access option is not enabled.

For command-line installations, specify `/uiAccess` or `/uiAccess=1` to enable the option and `/uiAccess=0` to disable it. By default, the installer will enable the option if UAC is enabled and the UI Access context menu option was present before installation.

Scripts which need to run other scripts with UI access can simply [Run](commands/Run.htm) the appropriate UIA.exe file with the normal [command line parameters](#cmd).

**Known limitations**:

- UIA is only effective if the file is in a trusted location; i.e. a Program Files sub-directory.
- UIA.exe files created on one computer cannot run on other computers without first installing the digital certificate which was used to sign them.
- UIA.exe files cannot be started via CreateProcess due to security restrictions. ShellExecute can be used instead.[Run](commands/Run.htm) tries both.
- UIA.exe files cannot be modified, as it would invalidate the file's digital signature.
- Because UIA programs run at a different "integrity level" than other programs, they can only access objects registered by other UIA programs. For example,`<a href="commands/ComObjActive.htm" data-index="69">ComObjActive</a>("Word.Application")` will fail because Word is not marked for UI Access.
- The script's own windows can't be automated by non-UIA programs/scripts for security reasons.
- Running a non-UIA script which uses a mouse hook (even as simple as`#InstallMouseHook`) may prevent all mouse hotkeys from working when the mouse is pointing at a window owned by a UIA script, even hotkeys implemented by the UIA script itself. A workaround is to ensure UIA scripts are loaded last.

For more details, see [Enable interaction with administrative programs](https://www.autohotkey.com/board/topic/70449-enable-interaction-with-administrative-programs/) on the archive forum.

