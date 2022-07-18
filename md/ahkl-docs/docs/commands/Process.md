# Process

Performs one of the following operations on a process: checks if it exists; changes its priority; closes it; waits for it to close.

```
<span class="func">Process</span>, <a href="#SubCommands" data-index="1">SubCommand</a> <span class="optional">, PIDOrName, Value</span>
```

## Parameters

SubCommand, ValueThese are dependent upon each other and their usage is described [below](#SubCommands).PIDOrName

This parameter can be either a number (the PID) or a process name as described below. It can also be left blank to change the priority of the script itself.

**PID:** The Process ID, which is a number that uniquely identifies one specific process (this number is valid only during the lifetime of that process). The PID of a newly launched process can be determined via the [Run](Run.htm) command. Similarly, the PID of a window can be determined with [WinGet](WinGet.htm). The Process command itself can also be used to discover a PID.

**Name:** The name of a process is usually the same as its executable (without path), e.g. notepad.exe or winword.exe. Since a name might match multiple running processes, only the first process will be operated upon. The name is not case sensitive.

## Sub-commands

For _SubCommand_, specify one of the following:

- [Exist](#Exist): Checks whether the specified process is present.
- [Close](#Close): Forces the first matching process to close.
- [List](#List): Not yet implemented.
- [Priority](#Priority): Changes the priority level of the first matching process.
- [Wait](#Wait): Waits for the specified process to exist.
- [WaitClose](#WaitClose): Waits for all matching processes to close.

### Exist

Checks whether the specified process is present.

```
<span class="func">Process</span>, Exist <span class="optional">, PIDOrName</span>
```

Sets [ErrorLevel](../misc/ErrorLevel.htm) to the Process ID (PID) if a matching process exists, or 0 otherwise. If the _PIDOrName_ parameter is blank, the script's own PID is retrieved. An alternate, single-line method to retrieve the script's PID is `PID := DllCall("GetCurrentProcessId")`.

### Close

Forces the first matching process to close.

```
<span class="func">Process</span>, Close <span class="optional">, PIDOrName</span>
```

If a matching process is successfully terminated, [ErrorLevel](../misc/ErrorLevel.htm) is set to its former Process ID (PID). Otherwise (there was no matching process or there was a problem terminating it), it is set to 0. Since the process will be abruptly terminated -- possibly interrupting its work at a critical point or resulting in the loss of unsaved data in its windows (if it has any) -- this method should be used only if a process cannot be closed by using [WinClose](WinClose.htm) on one of its windows.

### List

Although this sub-command is not yet supported, [example #4](#ListEx) demonstrates how to retrieve a list of processes via [DllCall()](DllCall.htm).

### Priority

Changes the priority level of the first matching process.

```
<span class="func">Process</span>, Priority, PIDOrName, Level
```

Changes the priority (as seen in Windows Task Manager) of the first matching process to _Level_ and sets [ErrorLevel](../misc/ErrorLevel.htm) to its Process ID (PID). If the _PIDOrName_ parameter is blank, the script's own priority will be changed. If there is no matching process or there was a problem changing its priority, ErrorLevel is set to 0.

_Level_ should be one of the following letters or words: L (or Low), B (or BelowNormal), N (or Normal), A (or AboveNormal), H (or High), R (or Realtime). Note: Any process not designed to run at Realtime priority might reduce system stability if set to that level.

### Wait

Waits for the specified process to exist.

```
<span class="func">Process</span>, Wait, PIDOrName <span class="optional">, Timeout</span>
```

Specify for _Timeout_ the number of seconds (can contain a decimal point) to wait before timing out. If _Timeout_ is omitted, the sub-command will wait indefinitely. If a matching process is discovered, [ErrorLevel](../misc/ErrorLevel.htm) is set to its Process ID (PID). If the sub-command times out, ErrorLevel is set to 0.

### WaitClose

Waits for **all** matching processes to close.

```
<span class="func">Process</span>, WaitClose, PIDOrName <span class="optional">, Timeout</span>
```

Specify for _Timeout_ the number of seconds (can contain a decimal point) to wait before timing out. If _Timeout_ is omitted, the sub-command will wait indefinitely. If all matching processes are closed, [ErrorLevel](../misc/ErrorLevel.htm) is set to 0. If the sub-command times out, ErrorLevel is set to the Process ID (PID) of the first matching process that still exists.

## ErrorLevel

[ErrorLevel](../misc/ErrorLevel.htm) is set to 0 if a sub-command failed or timed out. Otherwise, it is set to a Process ID (PID). See the sub-commands above for details.

## Remarks

For the sub-commands [Wait](#Wait) and [WaitClose](#WaitClose): Processes are checked every 100 milliseconds; the moment the condition is satisfied, the sub-command stops waiting. In other words, rather than waiting for the timeout to expire, it immediately sets [ErrorLevel](../misc/ErrorLevel.htm) as described above, then continues execution of the script. Also, while the sub-command is in a waiting state, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

## Related

[Run](Run.htm), [WinGet](WinGet.htm), [WinClose](WinClose.htm), [WinKill](WinKill.htm), [WinWait](WinWait.htm), [WinWaitClose](WinWaitClose.htm), [WinExist()](WinExist.htm)

## Examples

Launches Notepad, sets its priority to "High" and reports its current PID.

```
Run notepad.exe,,, NewPID
Process, Priority, %NewPID%, High
MsgBox The newly launched Notepad's PID is %NewPID%.
```

Waits up to 5.5 seconds for Notepad to appear. If Notepad appears within this number of seconds, its priority is set to "Low" and the script's own priority is set to "High". After that, Notepad will be closed and a message box will be shown if it did not close within 5 seconds.

```
Process, Wait, notepad.exe, 5.5
NewPID := ErrorLevel  <em>; Save the value immediately since ErrorLevel is often changed.</em>
if not NewPID
{
    MsgBox The specified process did not appear within 5.5 seconds.
    return
}
<em>; Otherwise:</em>
MsgBox A matching process has appeared (Process ID is %NewPID%).
Process, Priority, %NewPID%, Low
Process, Priority,, High  <em>; Have the script set itself to high priority.</em>
WinClose Untitled - Notepad
Process, WaitClose, %NewPID%, 5
if ErrorLevel <em>; The PID still exists.</em>
    MsgBox The process did not close within 5 seconds.
```

Press a hotkey to change the priority of the active window's process.

```
#z:: <em>; Win+Z hotkey</em>
WinGet, active_pid, PID, A
WinGetTitle, active_title, A
Gui, 5:Add, Text,, Press ESCAPE to cancel, or double-click a new`npriority level for the following window:`n%active_title%
Gui, 5:Add, ListBox, vMyListBox gMyListBox r5, Normal|High|Low|BelowNormal|AboveNormal
Gui, 5:Add, Button, default, OK
Gui, 5:Show,, Set Priority
return

5GuiEscape:
5GuiClose:
Gui, Destroy
return

MyListBox:
if (A_GuiEvent != "DoubleClick")
    return
<em>; else fall through to the next label:</em>
5ButtonOK:
GuiControlGet, MyListBox
Gui, Destroy
Process, Priority, %active_pid%, %MyListBox%
if ErrorLevel
    MsgBox Success: Its priority was changed to "%MyListBox%".
else
    MsgBox Error: Its priority could not be changed to "%MyListBox%".
return
```

Retrieves a list of running processes via [DllCall()](DllCall.htm) then shows them in a message box.

```
d := "  |  "  <em>; string separator</em>
s := 4096  <em>; size of buffers and arrays (4 KB)</em>

Process, Exist  <em>; Sets ErrorLevel to the PID of this running script.</em>
<em>; Get the handle of this script with PROCESS_QUERY_INFORMATION (0x0400):</em>
h := DllCall("OpenProcess", "UInt", 0x0400, "Int", false, "UInt", ErrorLevel, "Ptr")
<em>; Open an adjustable access token with this process (TOKEN_ADJUST_PRIVILEGES = 32):</em>
DllCall("Advapi32.dll\OpenProcessToken", "Ptr", h, "UInt", 32, "PtrP", t)
VarSetCapacity(ti, 16, 0)  <em>; structure of privileges</em>
NumPut(1, ti, 0, "UInt")  <em>; one entry in the privileges array...</em>
<em>; Retrieves the locally unique identifier of the debug privilege:</em>
DllCall("Advapi32.dll\LookupPrivilegeValue", "Ptr", 0, "Str", "SeDebugPrivilege", "Int64P", luid)
NumPut(luid, ti, 4, "Int64")
NumPut(2, ti, 12, "UInt")  <em>; Enable this privilege: SE_PRIVILEGE_ENABLED = 2</em>
<em>; Update the privileges of this process with the new access token:</em>
r := DllCall("Advapi32.dll\AdjustTokenPrivileges", "Ptr", t, "Int", false, "Ptr", &ti, "UInt", 0, "Ptr", 0, "Ptr", 0)
DllCall("CloseHandle", "Ptr", t)  <em>; Close this access token handle to save memory.</em>
DllCall("CloseHandle", "Ptr", h)  <em>; Close this process handle to save memory.</em>

hModule := DllCall("LoadLibrary", "Str", "Psapi.dll")  <em>; Increase performance by preloading the library.</em>
s := VarSetCapacity(a, s)  <em>; An array that receives the list of process identifiers:</em>
c := 0  <em>; counter for process idendifiers</em>
DllCall("Psapi.dll\EnumProcesses", "Ptr", &a, "UInt", s, "UIntP", r)
Loop, % r // 4  <em>; Parse array for identifiers as DWORDs (32 bits):</em>
{
    id := NumGet(a, A_Index * 4, "UInt")
<em>; Open process with: PROCESS_VM_READ (0x0010) | PROCESS_QUERY_INFORMATION (0x0400)</em>
    h := DllCall("OpenProcess", "UInt", 0x0010 | 0x0400, "Int", false, "UInt", id, "Ptr")
    if !h
        continue
    VarSetCapacity(n, s, 0)  <em>; a buffer that receives the base name of the module:</em>
    e := DllCall("Psapi.dll\GetModuleBaseName", "Ptr", h, "Ptr", 0, "Str", n, "UInt", A_IsUnicode ? s//2 : s)
    if !e    <em>; fall-back method for 64-bit processes when in 32-bit mode:</em>
        if e := DllCall("Psapi.dll\GetProcessImageFileName", "Ptr", h, "Str", n, "UInt", A_IsUnicode ? s//2 : s)
            SplitPath n, n
    DllCall("CloseHandle", "Ptr", h)  <em>; close process handle to save memory</em>
    if (n && e)  <em>; if image is not null add to list:</em>
        l .= n . d, c++
}
DllCall("FreeLibrary", "Ptr", hModule)  <em>; Unload the library to free memory.</em>
<em>;Sort, l, C  ; Uncomment this line to sort the list alphabetically.</em>
MsgBox, 0, %c% Processes, %l%
```

Retrieves a list of running processes via COM.

```
Gui, Add, ListView, x2 y0 w400 h500, Process Name|Command Line
for proc in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
    LV_Add("", proc.Name, proc.CommandLine)
Gui, Show,, Process List

<em>; Win32_Process: <a href="http://msdn.microsoft.com/en-us/library/aa394372.aspx" data-index="40">http://msdn.microsoft.com/en-us/library/aa394372.aspx</a></em>
```

