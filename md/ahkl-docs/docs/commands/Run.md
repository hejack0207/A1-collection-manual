# Run / RunWait

Runs an external program. Unlike Run, RunWait will wait until
the program finishes before continuing.

```
<span class="func">Run</span>, Target <span class="optional">, WorkingDir, Options, OutputVarPID</span>
<span class="func">RunWait</span>, Target <span class="optional">, WorkingDir, Options, OutputVarPID</span>

```

## Parameters

Target

A document, URL, executable file (.exe, .com, .bat, etc.), shortcut (.lnk), or [system verb](#verbs) to launch (see remarks). If _Target_ is a local file and no path was specified with it, [A\_WorkingDir](../Variables.htm#WorkingDir) will be searched first. If no matching file is found there, the system will search for and launch the file if it is integrated ("known"), e.g. by being contained in one of the PATH folders.

To pass parameters, add them immediately after the program or document name. For example, `Run, MyProgram.exe Param1 Param2`.

If the program/document name or a parameter contains spaces, it is safest to enclose it in double quotes (even though it may work without them in some cases). For example, `Run, "My Program.exe" "param with spaces"`.

WorkingDir

The working directory for the launched item. Do not enclose the name in double quotes even if it contains spaces. If omitted, the script's own working directory ( [A\_WorkingDir](../Variables.htm#WorkingDir)) will be used.

Options

If omitted, the command launches _Target_ normally and shows a warning dialog whenever _Target_ could not be launched. To change this behavior, specify one or more of the following words:

**Max**: launch maximized

**Min**: launch minimized

**Hide**: launch hidden (cannot be used in combination with either of the above)

**Note**: Some applications (e.g. Calc.exe) do not obey the requested startup state and thus Max/Min/Hide will have no effect.

**UseErrorLevel**: UseErrorLevel can be specified alone or in addition to one of the above words (by separating it from the other word with a space). If the launch fails, this option skips the warning dialog, sets [ErrorLevel](../misc/ErrorLevel.htm) to the word ERROR, and allows the [current thread](../misc/Threads.htm) to continue. If the launch succeeds, RunWait sets [ErrorLevel](../misc/ErrorLevel.htm) to the program's exit code, and Run sets it to 0.

When UseErrorLevel is specified, the variable **A\_LastError** is set to the result of the operating system's GetLastError() function. A\_LastError is a number between 0 and 4294967295 (always formatted as decimal, not hexadecimal). Zero (0) means success, but any other number means the launch failed. Each number corresponds to a specific error condition (to get a list, search [www.microsoft.com](https://www.microsoft.com) for "system error codes"). Like [ErrorLevel](../misc/ErrorLevel.htm), A\_LastError is a per-thread setting; that is, interruptions by other [threads](../misc/Threads.htm) cannot change it. However, A\_LastError is also set by [DllCall()](DllCall.htm#LastError).

OutputVarPID

The name of the variable in which to store the newly launched program's unique [Process ID (PID)](Process.htm). The variable will be made blank if the PID could not be determined, which usually happens if a system verb, document, or shortcut is launched rather than a direct executable file. RunWait also supports this parameter, though its _OutputVarPID_ must be checked in [another thread](../misc/Threads.htm) (otherwise, the PID will be invalid because the process will have terminated by the time the line following RunWait executes).

After the Run command retrieves a PID, any windows to be created by the process might not exist yet. To wait for at least one window to be created, use `<a href="WinWait.htm" data-index="13">WinWait</a> ahk_pid %OutputVarPID%`.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

Run: Does not set [ErrorLevel](../misc/ErrorLevel.htm) unless UseErrorLevel (above) is in effect, in which case ErrorLevel is set to the word ERROR upon failure or 0 upon success.

RunWait: Sets ErrorLevel to the program's exit code (a signed 32-bit integer). If UseErrorLevel is in effect and the launch failed, the word ERROR is stored.

## Remarks

Unlike Run, RunWait will wait until _Target_ is closed or exits, at which time [ErrorLevel](../misc/ErrorLevel.htm) will be set to the program's exit code (as a signed 32-bit integer). Some programs will appear to return immediately even though they are still running; these programs spawn another process.

If _Target_ contains any commas, they must be [escaped](../misc/EscapeChar.htm) as highlighted three times in the following example:

```
Run rundll32.exe shell32.dll<span class="style3">`,</span>Control_RunDLL desk.cpl<span class="style3">`,`,</span> 3  <em>; Opens Control Panel > Display Properties > Settings</em>
```

When running a program via [ComSpec](../Variables.htm#ComSpec) (cmd.exe) -- perhaps because you need to redirect the program's input or output -- if the path or name of the executable contains spaces, the entire string should be enclosed in an outer pair of quotes. In the following example, the outer quotes are highlighted in yellow:

```
Run %ComSpec% /c <span class="style3">"</span>"C:\My Utility.exe" "param 1" "second param" >"C:\My File.txt"<span class="style3">"</span>
```

If _Target_ cannot be launched, an error window is displayed and the current thread is exited, unless the string **UseErrorLevel** is included in the third parameter or the error is caught by a [Try](Try.htm)/ [Catch](Catch.htm) statement.

Performance may be slightly improved if _Target_ is an exact path, e.g. `Run, C:\Windows\Notepad.exe "C:\My Documents\Test.txt"` rather than `Run, C:\My Documents\Test.txt`.

Special [CLSID folders](../misc/CLSID-List.htm) may be opened via Run. For example:

```
Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d}  <em>; Opens the "My Computer" folder.</em>
Run ::{645ff040-5081-101b-9f08-00aa002f954e}  <em>; Opens the Recycle Bin.</em>
```

System verbs correspond to actions available in a file's right-click menu in the Explorer. If a file is launched without a verb, the default verb (usually "open") for that particular file type will be used. If specified, the verb should be followed by the name of the target file. The following verbs are currently supported:

VerbDescription\* _verb_[AHK\_L 57+]: Any system-defined or custom verb. For example: `Run *Compile %A_ScriptFullPath%`. On Windows Vista and later, the [\*RunAs](#RunAs) verb may be used in place of the _Run as administrator_ right-click menu item.properties

Displays the Explorer's properties window for the indicated file. For example: `Run, properties "C:\My File.txt"`

**Note**: The properties window will automatically close when the script terminates. To prevent this, use [WinWait](WinWait.htm) to wait for the window to appear, then use [WinWaitClose](WinWaitClose.htm) to wait for the user to close it.

findOpens an instance of the Explorer's Search Companion or Find File window at the indicated folder. For example: `Run, find D:\`exploreOpens an instance of Explorer at the indicated folder. For example: `Run, explore %A_ProgramFiles%`.editOpens the indicated file for editing. It might not work if the indicated file's type does not have an "edit" action associated with it. For example: `Run, edit "C:\My File.txt"`openOpens the indicated file (normally not needed because it is the default action for most file types). For example: `Run, open "My File.txt"`.printPrints the indicated file with the associated application, if any. For example: `Run, print "My File.txt"`

While RunWait is in a waiting state, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

## Run as Administrator [AHK\_L 57+]

For an executable file, the _\*RunAs_ verb is equivalent to selecting _Run as administrator_ from the right-click menu of the file. For example, the following code attempts to restart the current script as admin:

```
full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

MsgBox A_IsAdmin: %A_IsAdmin%`nCommand line: %full_command_line%
```

If the user cancels the UAC dialog or Run fails for some other reason, the script will simply exit.

Using [/restart](../Scripts.htm#SlashR) ensures that a [single instance](_SingleInstance.htm) prompt is not shown if the new instance of the script starts before ExitApp is called.

If UAC is disabled, _\*RunAs_ will launch the process without elevating it. Checking for `/restart` in the command line ensures that the script does not enter a runaway loop in that case. Note that `/restart` is a built-in switch, so is not included in the [array of command-line parameters](../Scripts.htm#cmd_args).

The example can be modified to fit the script's needs:

- If the script absolutely requires admin rights, check A\_IsAdmin a second time in case_\*RunAs_ failed to elevate the script (i.e. because UAC is disabled).
- To keep the script running even if the user cancels the UAC prompt, move ExitApp into the try block.
- To keep the script running even if it failed to restart (i.e. because the script file has been changed or deleted), remove ExitApp and use RunWait instead of Run. On success,`/restart` causes the new instance to terminate the old one. On failure, the new instance exits and RunWait returns.

[v1.0.92.01+]: If UAC is enabled, the AutoHotkey installer registers the _RunAs_ verb for _.ahk_ files, which allows `Run *RunAs script.ahk` to launch a script as admin with the default executable.

## Related

[RunAs](RunAs.htm), [Process](Process.htm), [Exit](Exit.htm), [CLSID List](../misc/CLSID-List.htm), [DllCall()](DllCall.htm)

## Examples

Run is able to launch Windows system programs from any directory. Note that executable file extensions such as .exe can be omitted.

```
Run, notepad
```

Run is able to launch URLs:

The following opens an internet address in the user's default web browser.

```
Run, https://www.google.com
```

The following opens the default e-mail application with the recipient filled in.

```
Run, mailto:someone@somedomain.com
```

The following does the same as above, plus the subject and body.

```
Run, mailto:someone@somedomain.com?subject=This is the subject line&body=This is the message body's text.
```

Opens a document in a maximized application and displays a custom error message on failure.

```
Run, ReadMe.doc, , Max UseErrorLevel
if (ErrorLevel = "ERROR")
    MsgBox The document could not be launched.
```

Runs the dir command in minimized state and stores the output in a text file. After that, the text file and its properties dialog will be opened.

```
#Persistent
RunWait, %ComSpec% /c dir C:\ >>C:\DirTest.txt, , Min
Run, C:\DirTest.txt
Run, properties C:\DirTest.txt
```

Run is able to launch [CLSIDs](../misc/CLSID-List.htm):

The following opens the recycle bin.

```
Run, ::{645ff040-5081-101b-9f08-00aa002f954e}
```

The following opens the "My Computer" directory.

```
Run, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}
```

To run multiple commands consecutively, use "&&" between each.

```
Run, %ComSpec% /c dir /b > C:\list.txt && type C:\list.txt && pause
```

The following functions can be used to run a command and retrieve its output or to run multiple commands in one go and retrieve their output.

```
MsgBox % RunWaitOne("dir " A_ScriptDir)

MsgBox % RunWaitMany("
(
echo Put your commands here,
echo each one will be run,
echo and you'll get the output.
)")

RunWaitOne(command) {
    <em>; WshShell object: <a href="http://msdn.microsoft.com/en-us/library/aew9yb99" data-index="45">http://msdn.microsoft.com/en-us/library/aew9yb99</a></em>
    shell := ComObjCreate("WScript.Shell")
    <em>; Execute a single command via cmd.exe</em>
    exec := shell.Exec(ComSpec " /C " command)
    <em>; Read and return the command's output</em>
    return exec.StdOut.ReadAll()
}

RunWaitMany(commands) {
    shell := ComObjCreate("WScript.Shell")
    <em>; Open cmd.exe with echoing of commands disabled</em>
    exec := shell.Exec(ComSpec " /Q /K echo off")
    <em>; Send the commands to execute, separated by newline</em>
    exec.StdIn.WriteLine(commands "`nexit")  <em>; Always exit at the end!</em>
    <em>; Read and return the output of all commands</em>
    return exec.StdOut.ReadAll()
}

```

Executes the given code as a new AutoHotkey process.

```
ExecScript(Script, Wait:=true)
{
    shell := ComObjCreate("WScript.Shell")
    exec := shell.Exec("AutoHotkey.exe /ErrorStdOut *")
    exec.StdIn.Write(script)
    exec.StdIn.Close()
    if Wait
        return exec.StdOut.ReadAll()
}

<em>; Example:</em>
InputBox expr,, Enter an expression to evaluate as a new script.,,,,,,,, Asc("*")
result := ExecScript("FileAppend % (" expr "), *")
MsgBox % "Result: " result

```

