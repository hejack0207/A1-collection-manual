# Frequently Asked Questions (FAQ)

## Table of Contents

**[Language Syntax](#language-syntax)**

- [When are quotation marks used with commands and their parameters?](#quotes)
- [When exactly are variable names enclosed in percent signs?](#percent)
- [When should percent signs and commas be escaped?](#esc)

**[General Troubleshooting](#general-troubleshooting)**

- [What can I do if AutoHotkey won't install?](#install)
- [How do I restore the right-click context menu options for .ahk files?](#rightclick)
- [Why do some lines in my script never execute?](#autoexec)
- [Why doesn't my script work on Windows _xxx_ even though it worked on a previous version?](#vista)
- [How do I work around problems caused by User Account Control (UAC)?](#uac)
- [I can't edit my script via tray icon because it won't start due to an error. Can I find my script somewhere else?](#DefaultScript)
- [How can I find and fix errors in my code?](#Debug)
- [Why is the Run command unable to launch my game or program?](#run)
- [Why are the non-ASCII characters in my script displaying or sending incorrectly?](#nonascii)
- [Why don't Hotstrings, Send, and MouseClick work in certain games?](#games)
- [How can performance be improved for games or at other times when the CPU is under heavy load?](#perf)
- [My antivirus program flagged AHK as malware. Does it really contain a virus?](#Virus)

**[Common Tasks](#common-tasks)**

- [Where can I find the official build, or older releases?](#Download)
- [Can I run AHK from a USB drive?](#USB)
- [How can the output of a command line operation be retrieved?](#output)
- [How can a script close, pause, suspend or reload other script(s)?](#close)
- [How can a repeating action be stopped without exiting the script?](#repeat)
- [How can context sensitive help for AutoHotkey commands be used in any editor?](#help)
- [How to detect when a web page is finished loading?](#load)
- [How can dates and times be compared or manipulated?](#time)
- [How can I send the current Date and/or Time?](#SendDate)
- [How can I send text to a window which isn't active or isn't visible?](#ControlSend)
- [How can Winamp be controlled even when it isn't active?](#winamp)
- [How can MsgBox's button names be changed?](#msgbox)
- [How can I change the default editor, which is accessible via context menu or tray icon?](#DefaultEditor)
- [How can I save the contents of my GUI associated variables?](#GuiSubmit)
- [Can I draw something with AHK?](#GDIPlus)
- [How can I start an action when a window appears, closes or becomes [in]active?](#WinWaitAction)

**[Hotkeys, Hotstrings, and Remapping](#hotkeys-hotstrings-and-remapping)**

- [How do I put my hotkeys and hotstrings into effect automatically every time I start my PC?](#Startup)
- [I'm having trouble getting my mouse buttons working as hotkeys. Any advice?](#HotMouse)
- [How can tab and space be defined as hotkeys?](#HotSymb)
- [How can keys or mouse buttons be remapped so that they become different keys?](#Remap)
- [How do I detect the double press of a key or button?](#DoublePress)
- [How can a hotkey or hotstring be made exclusive to certain program(s)? In other words, I want a certain key to act as it normally does except when a specific window is active.](#HotContext)
- [How can a prefix key be made to perform its native function rather than doing nothing?](#HotPrefix)
- [How can the built-in Windows shortcut keys, such as Win+U (Utility Manager) and Win+R (Run), be changed or disabled?](#HotOverride)
- [Can I use wildcards or regular expressions in Hotstrings?](#HotRegex)
- [How can I use a hotkey that is not in my keyboard layout?](#SpecialKey)
- [My keypad has a special 000 key. Is it possible to turn it into a hotkey?](#HotZero)

## Language Syntax

### When are quotation marks used with commands and their parameters?

Double quotes (") have special meaning only within [expressions](Variables.htm#Expressions). In all other places, they are treated literally as if they were normal characters. However, when a script launches a program or document, the operating system usually requires quotes around any command-line parameter that contains spaces, such as in this example: `Run, Notepad.exe "C:\My Documents\Address List.txt"`.

### When exactly are variable names enclosed in percent signs?

Variable names are always enclosed in percent signs except in cases illustrated in **bold** below:

- In parameters that are input or output variables:`<a href="commands/StringLen.htm" data-index="48">StringLen</a>, <strong>OutputVar</strong>, <strong>InputVar</strong>`
- On the left side of an assignment:`<strong>Var</strong> = 123abc`
- On the left side of[traditional (non-expression) if-statements](commands/IfEqual.htm): `If <strong>Var1</strong> < %Var2%`
- Everywhere in[expressions](Variables.htm#Expressions). For example:


  ```
  If (<strong>Var1</strong> <> <strong>Var2</strong>)
        <strong>Var1 <a href="commands/SetExpression.htm" data-index="51">:=</a> Var2</strong> + 100
  ```


For further explanation of how percent signs are used, see [Legacy Syntax](Language.htm#legacy-syntax) and [Dynamic Variables](Language.htm#dynamic-variables). Percent signs can also have other meanings:

- The[percent-space prefix](Language.htm#-expression) causes a command parameter to be interpreted as an expression.
- [Escaped](misc/EscapeChar.htm) percent signs ( `` `%``) and percent signs in [quoted literal strings](Language.htm#strings) have no special meaning (they are interpreted as literal percent signs).

### When should percent signs and commas be [escaped](misc/EscapeChar.htm)?

Literal percent signs must be [escaped](misc/EscapeChar.htm) by preceding them with an accent/backtick. For example: ``MsgBox The current percentage is 25`%.`` Literal commas must also be escaped ( `` `,``) except when used in [MsgBox](commands/MsgBox.htm) or the last parameter of any command (in which case the accent is permitted but not necessary).

When commas or percent signs are enclosed in quotes within an [expression](Variables.htm#Expressions), the accent is permitted but not necessary. For example: `Var := "15%"`.

## General Troubleshooting

### What can I do if AutoHotkey won't install?

**7-zip Error:** Use 7-zip or a compatible program to extract the setup files from the installer EXE, then run setup.exe or Installer.ahk (drag and drop Installer.ahk onto AutoHotkeyU32.exe).

AutoHotkey's installer comes packaged as a 7-zip self-extracting archive which attempts to extract to the user's Temp directory and execute a compiled script. Sometimes system policies or other factors prevent the files from being extracted or executed. Usually in such cases the message "7-zip Error" is displayed. Manually extracting the files to a different directory may help.

**Setup hangs:** If the setup window comes up blank or not at all, try one or both of the following:

- HoldCtrl or Shift when the installer starts. If you get a UAC prompt, hold Ctrl or Shift as you click Yes/Continue. You should get a prompt asking whether you want to install with default options.
- Install using[command line options](Program.htm#install). If you have manually extracted the setup files from the installer EXE, use either `setup.exe /S` or `AutoHotkeyU32.exe Installer.ahk /S`.

**Other:** The suggestions above cover the most common problems. For further assistance, post on the forums.

### How do I restore the right-click context menu options for .ahk files?

Normally if AutoHotkey is installed, right-clicking an AutoHotkey script (.ahk) file should give the following options:

- Run Script
- Compile Script (depending on the_Install script compiler_ installation option)
- Edit Script
- Run as administrator (if UAC was enabled when AutoHotkey was installed)
- Run with UI Access (if[the option](Program.htm#Installer_uiAccess) was enabled during installation)

Sometimes these options are overridden by settings in the current user's profile, such as if _Open With_ has been used to change the default program for opening .ahk files. This can be fixed by deleting the following registry key:

```
HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ahk\UserChoice
```

This can be done by applying [this registry patch](misc/remove-userchoice.reg).

It may also be necessary to repair the default registry values, either by reinstalling AutoHotkey or by running AutoHotkey Setup (from the Start menu) and selecting _apply_ near the top of the window.

### Why do some lines in my script never execute?

Any lines you want to execute immediately when the script starts should appear at the top of the script, prior to the first [hotkey](Hotkeys.htm), [hotstring](Hotstrings.htm), or [Return](commands/Return.htm). For details, see [auto-execute section](Scripts.htm#auto).

Also, a [hotkey](Hotkeys.htm) that executes more than one line must list its first line _beneath_ the hotkey, not on the same line. For example:

```
#space::  <em>; Win+Spacebar</em>
Run Notepad
WinWaitActive Untitled - Notepad
WinMaximize
return
```

### Why doesn't my script work on Windows _xxx_ even though it worked on a previous version?

There are many variations of this problem, such as:

- I've upgraded my computer/Windows and now my script won't work.
- Hotkeys/hotstrings don't work when a program running as admin is active.
- Some windows refuse to be automated (e.g. Device Manager ignores Send).

If you've switched operating systems, it is likely that something else has also changed and may be affecting your script. For instance, if you've got a new computer, it might have different drivers or other software installed. If you've also updated to a newer version of AutoHotkey, find out which version you had before and then check the [changelog](AHKL_ChangeLog.htm) and [compatibility notes](Compat.htm).

[SoundGet](commands/SoundGet.htm), [SoundSet](commands/SoundSet.htm), [SoundGetWaveVolume](commands/SoundGetWaveVolume.htm) and [SoundSetWaveVolume](commands/SoundSetWaveVolume.htm) behave differently on Vista and later than on earlier versions of Windows. In particular, device numbers are different and some components may be unavailable. Behaviour depends on the audio drivers, which are necessarily different to the ones used on XP. The [soundcard analysis script](commands/SoundSet.htm#Ex) can be used to find the correct device numbers.

Also refer to the following question:

### How do I work around problems caused by User Account Control (UAC)?

By default, [User Account Control (UAC)](https://en.wikipedia.org/wiki/User_Account_Control) protects "elevated" programs (that is, programs which are running as admin) from being automated by non-elevated programs, since that would allow them to bypass security restrictions. Hotkeys are also blocked, so for instance, a non-elevated program cannot spy on input intended for an elevated program.

UAC may also prevent [SendPlay](commands/Send.htm#SendPlayDetail) and [BlockInput](commands/BlockInput.htm) from working.

Common workarounds are as follows:

- Enable the_[Add 'Run with UI Access' to context menus](Program.htm#Installer_uiAccess)_ option in AutoHotkey Setup. This option can be enabled or disabled without reinstalling AutoHotkey by re-running AutoHotkey Setup from the Start menu. Once it is enabled, launch your script file by right-clicking it and selecting _Run with UI Access_, or use a [command line](Scripts.htm#cmd) like `"AutoHotkeyU32_UIA.exe" "Your script.ahk"` (but include full paths).
- Run the script[as administrator](Variables.htm#IsAdmin). Note that this also causes any programs launched by the script to run as administrator, and may require the user to accept an approval prompt when launching the script.
- Disable the local security policy "Run all administrators in Admin Approval Mode" (not recommended).
- Disable UAC completely. This is not recommended, and is not feasible on Windows 8 or later.

### I can't edit my script via tray icon because it won't start due to an error. What do I do?

You need to fix the error in your script before you can get your tray icon back. But first, you need to find the script file.

Look for AutoHotkey.ahk in the following directories:

- Your_Documents_ (or _My Documents_) folder.
- The directory where you installed AutoHotkey, usually C:\\Program Files\\AutoHotkey. If you are using AutoHotkey without having installed it, look in the directory which contains AutoHotkey.exe.

If you are running another AutoHotkey executable directly, the name of the script depends on the executable. For example, if you are running AutoHotkeyU32.exe, look for AutoHotkeyU32.ahk. Note that depending on your system settings the ".ahk" part may be hidden, but the file should have an icon like ![[H]](static/ahkfile16.png)

You can usually edit a script file by right clicking it and selecting _Edit Script_. If that doesn't work, you can open the file in Notepad or another editor.

If you launch AutoHotkey from the Start menu or by running AutoHotkey.exe directly (without command line parameters), it will look for a script in one of the locations shown above. Alternatively, you can create a script file (something.ahk) anywhere you like, and run the script file instead of running AutoHotkey.

See also [Command Line Parameter "Script Filename"](Scripts.htm#defaultfile) and [Portability of AutoHotkey.exe](Program.htm#portability).

### How can I find and fix errors in my code?

For simple scripts, see [Debugging a Script](Scripts.htm#debug). To show contents of a variable, use [MsgBox](commands/MsgBox.htm) or [ToolTip](commands/ToolTip.htm). For complex scripts, see [Interactive Debugging](Scripts.htm#idebug).

### Why is the [Run](commands/Run.htm) command unable to launch my game or program?

Some programs need to be started in their own directories (when in doubt, it is usually best to do so). For example:

```
Run, %A_ProgramFiles%\Some Application\App.exe, %A_ProgramFiles%\Some Application
```

If the program you are trying to start is in `%A_WinDir%\System32` and you are using AutoHotkey 32-bit on a 64-bit system, the [File System Redirector](https://msdn.microsoft.com/en-us/library/aa384187) may be interfering. To work around this, use `%A_WinDir%\SysNative` instead; this is a virtual directory only visible to 32-bit programs running on 64-bit systems.

### Why are the non-ASCII characters in my script displaying or sending incorrectly?

Short answer: Save the script as UTF-8 with BOM.

Although AutoHotkey supports Unicode text, it is optimized for backward-compatibility, which means defaulting to the ANSI encoding rather than the more internationally recommended UTF-8. AutoHotkey will not automatically recognize a UTF-8 file unless it begins with a byte order mark.

In other words, UTF-8 files which lack a byte order mark are misinterpreted, causing non-ASCII characters to be decoded incorrectly. To resolve this, save the file as UTF-8 with BOM or [add the /CP65001 command line switch](Scripts.htm#cp).

To save as UTF-8 with BOM in Notepad, select _UTF-8_ from the _Encoding_ drop-down in the Save As dialog.

To read other UTF-8 files which lack a byte order mark, use `<a href="commands/FileEncoding.htm" data-index="91">FileEncoding</a> UTF-8-RAW`, the `*P65001` option with [FileRead](commands/FileRead.htm), or `"UTF-8-RAW"` for the third parameter of [FileOpen()](commands/FileOpen.htm). The `-RAW` suffix can be omitted, but in that case any newly created files will have a byte order mark.

Note that INI files accessed with the standard INI commands do not support UTF-8; they must be saved as ANSI or UTF-16.

### Why do [Hotstrings](Hotstrings.htm), [Send](commands/Send.htm), and [Click](commands/Click.htm) have no effect in certain games?

Not all games allow AHK to send keys and clicks or receive pixel colors.

But there are some alternatives, try all the solutions mentioned below. If all these fail, it may not be possible for AHK to work with your game. Sometimes games have a hack and cheat prevention measure, such as GameGuard and Hackshield. If they do, there is a high chance that AutoHotkey will not work with that game.

- Use SendPlay via the [SendPlay](commands/Send.htm#SendPlay) command, [SendMode Play](commands/SendMode.htm) and/or the [hotstring option SP](Hotstrings.htm).


  ```
  SendPlay, abc
  ```



  ```
  SendMode, Play
  Send, abc
  ```



  ```
  :SP:btw::by the way

  <em>; or</em>

  #Hotstring SP
  ::btw::by the way
  ```


  **Note**: SendPlay may have no effect at all on Windows Vista or later if User Account Control is enabled, even if the script is running as an administrator.

- Increase [SetKeyDelay](commands/SetKeyDelay.htm). For example:


  ```
  SetKeyDelay, 0, 50
  SetKeyDelay, 0, 50, Play
  ```

- Try [ControlSend](commands/ControlSend.htm), which might work in cases where the other Send modes fail:


  ```
  ControlSend,, abc, game_title
  ```

- Try the down and up event of a key with the various send methods:


  ```
  Send {KEY down}{KEY up}
  ```

- Try the down and up event of a key with a [Sleep](commands/ControlSend.htm) between them:


  ```
  Send {KEY down}
  Sleep 10 <em>; try various milliseconds</em>
  Send {KEY up}
  ```


### How can performance be improved for games or at other times when the CPU is under heavy load?

If a script's [Hotkeys](Hotkeys.htm), [Clicks](commands/Click.htm), or [Sends](commands/Send.htm) are noticeably slower than normal while the CPU is under heavy load, raising the script's process-priority may help. To do this, include the following line near the top of the script:

```
<a href="commands/Process.htm" data-index="106">Process</a>, Priority, , High
```

### My antivirus program flagged AutoHotkey or a compiled script as malware. Is it really a virus?

Although it is certainly possible that the file has been infected, most often these alerts are _false positives_, meaning that the antivirus program is mistaken. One common suggestion is to upload the file to an online service such as [virustotal](https://www.virustotal.com/) or [Jotti](https://virusscan.jotti.org/) and see what other antivirus programs have to say. If in doubt, you could send the file to the vendor of your antivirus software for confirmation. This might also help us and other AutoHotkey users, as the vendor may confirm it is a false positive and fix their product to play nice with AutoHotkey.

False positives might be more common for compiled scripts which have been compressed, such as with UPX (default for AutoHotkey 1.0 but not 1.1) or MPRESS (optional for AutoHotkey 1.1). As the default AutoHotkey installation does not include a compressor, compiled scripts are not compressed by default.

## Common Tasks

### Where can I find the official build, or older releases?

See [download page of AutoHotkey](https://www.autohotkey.com/download/).

### Can I run AHK from a USB drive?

See [Portability of AutoHotkey.exe](Program.htm#portability).

Note that when you compile a script that uses auto-included function libraries, AutoHotkey.exe and the Lib folder must be up one level from Ahk2Exe.exe (e.g. \\AutoHotkey.exe vs \\Compiler\\Ahk2Exe.exe). Also note that Ahk2Exe saves settings to the following registry key: `HKCU\Software\AutoHotkey\Ahk2Exe`. The compiler itself (Ahk2Exe) is not needed to run scripts.

### How can the output of a command line operation be retrieved?

Testing shows that due to file caching, a temporary file can be very fast for relatively small outputs. In fact, if the file is deleted immediately after use, it often does not actually get written to disk. For example:

```
<a href="commands/Run.htm" data-index="111">RunWait</a> %ComSpec% /c dir > C:\My Temp File.txt
FileRead, VarToContainContents, C:\My Temp File.txt
FileDelete, C:\My Temp File.txt
```

To avoid using a temporary file (especially if the output is large), consider using the [Shell.Exec()](commands/Run.htm#StdOut) method as shown in the examples for the [Run](commands/Run.htm) command.

### How can a script close, pause, suspend or reload other script(s)?

First, here is an example that closes another script:

```
DetectHiddenWindows On  <em>; Allows a script's hidden main window to be detected.</em>
SetTitleMatchMode 2  <em>; Avoids the need to specify the full path of the file below.</em>
WinClose ScriptFileName.ahk - AutoHotkey  <em>; Update this to reflect the script's name (case sensitive).</em>
```

To [suspend](commands/Suspend.htm), [pause](commands/Pause.htm) or [reload](commands/Reload.htm) another script, replace the last line above with one of these:

```
PostMessage, 0x0111, 65305,,, ScriptFileName.ahk - AutoHotkey  <em>; Suspend.</em>
PostMessage, 0x0111, 65306,,, ScriptFileName.ahk - AutoHotkey  <em>; Pause.</em>
PostMessage, 0x0111, 65303,,, ScriptFileName.ahk - AutoHotkey  <em>; Reload.</em>
```

### How can a repeating action be stopped without exiting the script?

To pause or resume the entire script at the press of a key, assign a hotkey to the [Pause](commands/Pause.htm) command as in this example:

```
^!p::Pause  <em>; Press Ctrl+Alt+P to pause. Press it again to resume.</em>
```

To stop an action that is repeating inside a [Loop](commands/Loop.htm), consider the following working example, which is a hotkey that both starts and stops its own repeating action. In other words, pressing the hotkey once will start the Loop. Pressing the same hotkey again will stop it.

```
#MaxThreadsPerHotkey 3
#z::  <em><strong>; Win+Z hotkey (change this hotkey to suit your preferences).</strong></em>
#MaxThreadsPerHotkey 1
if KeepWinZRunning  <em>; This means an underlying <a href="misc/Threads.htm" data-index="119">thread</a> is already running the loop below.</em>
{
    KeepWinZRunning := false  <em>; Signal that thread's loop to stop.</em>
    return  <em>; End this thread so that the one underneath will resume and see the change made by the line above.</em>
}
<em>; Otherwise:</em>
KeepWinZRunning := true
Loop
{
    <em><strong>; The next four lines are the action you want to repeat (update them to suit your preferences):</strong></em>
    ToolTip, Press Win-Z again to stop this from flashing.
    Sleep 1000
    ToolTip
    Sleep 1000
    <em><strong>; But leave the rest below unchanged.</strong></em>
    if not KeepWinZRunning  <em>; The user signaled the loop to stop by pressing Win-Z again.</em>
        break  <em>; Break out of this loop.</em>
}
KeepWinZRunning := false  <em>; Reset in preparation for the next press of this hotkey.</em>
return
```

### How can context sensitive help for AutoHotkey commands be used in any editor?

Rajat created [this script](scripts/index.htm#ContextSensitiveHelp).

### How to detect when a web page is finished loading?

With Internet Explorer, perhaps the most reliable method is to use DllCall() and COM as demonstrated at [www.autohotkey.com/forum/topic19256.html](https://www.autohotkey.com/forum/topic19256.html). On a related note, the contents of the address bar and status bar can be retrieved as demonstrated at [www.autohotkey.com/forum/topic19255.html](https://www.autohotkey.com/forum/topic19255.html).

**Older, less reliable method:** The technique in the following example will work with MS Internet Explorer for most pages. A similar technique might work in other browsers:

```
Run, www.yahoo.com
MouseMove, 0, 0  <em>; Prevents the status bar from showing a mouse-hover link instead of "Done".</em>
WinWait, Yahoo! -
WinActivate
<a href="commands/StatusBarWait.htm" data-index="123">StatusBarWait</a>, Done, 30
if ErrorLevel
    MsgBox The wait timed out or the window was closed.
else
    MsgBox The page is done loading.
```

### How can dates and times be compared or manipulated?

The [EnvAdd](commands/EnvAdd.htm) command can add or subtract a quantity of days, hours, minutes, or seconds to a time-string that is in the [YYYYMMDDHH24MISS](commands/FileSetTime.htm#YYYYMMDD) format. The following example subtracts 7 days from the specified time: `EnvAdd, VarContainingTimestamp, -7, days`.

To determine the amount of time between two dates or times, see [EnvSub](commands/EnvSub.htm), which gives an example. Also, the built-in variable [A\_Now](Variables.htm#Now) contains the current local time. Finally, there are several built-in [date/time variables](Variables.htm#date), as well as the [FormatTime](commands/FormatTime.htm) command to create a custom date/time string.

### How can I send the current Date and/or Time?

Use [FormatTime](commands/FormatTime.htm) or [built-in variables for date and time](Variables.htm#date).

### How can I send text to a window which isn't active or isn't visible?

Use [ControlSend](commands/ControlSend.htm).

### How can Winamp be controlled even when it isn't active?

See [Automating Winamp](misc/Winamp.htm).

### How can [MsgBox](commands/MsgBox.htm)'s button names be changed?

Here is an [example](scripts/index.htm#MsgBoxButtonNames).

### How can I change the default editor, which is accessible via context menu or tray icon?

In the example section of [Edit](commands/Edit.htm) you will find a script that allows you to change the default editor.

### How can I save the contents of my GUI associated variables?

Use [Gui Submit](commands/Gui.htm#Submit). For Example:

```
Gui, Add, Text,, Enter some Text and press Submit:
Gui, Add, Edit, vAssociatedVar
Gui, Add, Button,, Submit
Gui, Show
Return

ButtonSubmit:
Gui, Submit, NoHide
MsgBox, Content of the edit control: %AssociatedVar%
Return
```

### Can I draw something with AHK?

See [GDI+ standard library](https://www.autohotkey.com/forum/topic32238.html) by tic. It's also possible with some rudimentary methods using Gui, but in a limited way.

### How can I start an action when a window appears, closes or becomes [in]active?

Use [WinWait](commands/WinWait.htm), [WinWaitClose](commands/WinWaitClose.htm) or [WinWait[Not]Active](commands/WinWaitActive.htm).

There are also user-created solutions such as [OnWin.ahk](https://www.autohotkey.com/boards/viewtopic.php?f=6&t=6463) and [[How to] Hook on to Shell to receive its messages](https://www.autohotkey.com/board/topic/80644-how-to-hook-on-to-shell-to-receive-its-messages/).

## Hotkeys, Hotstrings, and Remapping

### How do I put my hotkeys and hotstrings into effect automatically every time I start my PC?

There are several ways to make a script (or any program) launch automatically every time you start your PC. The easiest is to place a shortcut to the script in the Startup folder:

1. Find the script file, select it, and pressCtrl+C.
2. PressWin+R to open the Run dialog, then enter `shell:startup` and click OK or Enter. This will open the Startup folder for the current user. To instead open the folder for all users, enter `shell:common startup` (however, in that case you must be an administrator to proceed).
3. Right click inside the window, and click "Paste Shortcut". The shortcut to the script should now be in the Startup folder.

### I'm having trouble getting my mouse buttons working as hotkeys. Any advice?

The left and right mouse buttons should be assignable normally (for example, `#LButton::` is the Win+LeftButton hotkey). Similarly, the middle button and the turning of the [mouse wheel](KeyList.htm) should be assignable normally except on mice whose drivers directly control those buttons.

The fourth button (XButton1) and the fifth button (XButton2) might be assignable if your mouse driver allows their clicks to be [seen](commands/KeyHistory.htm) by the system. If they cannot be seen -- or if your mouse has more than five buttons that you want to use -- you can try configuring the software that came with the mouse (sometimes accessible in the Control Panel or Start Menu) to send a keystroke whenever you press one of these buttons. Such a keystroke can then be defined as a hotkey in a script. For example, if you configure the fourth button to send Ctrl+F1, you can then indirectly configure that button as a hotkey by using `^F1::` in a script.

If you have a five-button mouse whose fourth and fifth buttons cannot be [seen](commands/KeyHistory.htm), you can try changing your mouse driver to the default driver included with the OS. This assumes there is such a driver for your particular mouse and that you can live without the features provided by your mouse's custom software.

### How can Tab and Space be defined as hotkeys?

Use the names of the keys (Tab and Space) rather than their characters. For example, `#Space` is Win+Space and `^!Tab` is Ctrl+Alt+Tab.

### How can keys or mouse buttons be remapped so that they become different keys?

This is described on the [remapping](misc/Remap.htm) page.

### How do I detect the double press of a key or button?

Use [built-in variables for hotkeys](Variables.htm#h) as follows:

```
~Ctrl::
    if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
        MsgBox double-press
return
```

### How can a [hotkey](Hotkeys.htm) or [hotstring](Hotstrings.htm) be made exclusive to certain program(s)? In other words, I want a certain key to act as it normally does except when a specific window is active.

The preferred method is [#IfWinActive](commands/_IfWinActive.htm). For example:

```
#IfWinActive, ahk_class Notepad
^a::MsgBox You pressed Control-A while Notepad is active.

```

### How can a prefix key be made to perform its native function rather than doing nothing?

Consider the following example, which makes Numpad0 into a prefix key:

```
Numpad0 & Numpad1::MsgBox, You pressed Numpad1 while holding down Numpad0.
```

Now, to make Numpad0 send a real Numpad0 keystroke whenever it wasn't used to launch a hotkey such as the above, add the following hotkey:

```
 $Numpad0::Send, {Numpad0}
```

The $ prefix is needed to prevent a warning dialog about an infinite loop (since the hotkey "sends itself"). In addition, the above action occurs at the time the key is **released.**

### How can the built-in Windows shortcut keys, such as Win+U (Utility Manager) and Win+R (Run), be changed or disabled?

Here are some [examples](misc/Override.htm).

### Can I use wildcards or regular expressions in Hotstrings?

Use the [script](https://github.com/polyethene/AutoHotkey-Scripts/blob/master/Hotstrings.ahk) by polyethene (examples are included).

### How can I use a hotkey that is not in my keyboard layout?

See [Special Keys](KeyList.htm#SpecialKeys).

### My keypad has a special 000 key. Is it possible to turn it into a hotkey?

Yes. This [example script](scripts/index.htm#Numpad000) makes 000 into an equals key. You can change the action by replacing the `Send, =` line with line(s) of your choice.

