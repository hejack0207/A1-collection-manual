# WinTitle Parameter & Last Found Window

Various commands, functions and control flow statements have a WinTitle parameter, used to identify which window (or windows) to operate on. This parameter can be the title or partial title of the window, and/or any other criteria described on this page.

 **Quick Reference:**_Title_[Matching Behaviour](#Matching)A[The Active Window](#ActiveWindow)ahk\_class[Window Class](#ahk_class)ahk\_id[Unique ID/HWND](#ahk_id)ahk\_pid[Process ID](#ahk_pid)ahk\_exe[Process Name/Path](#ahk_exe)ahk\_group[Window Group](#ahk_group)[Multiple Criteria](#multi)(All empty)[Last Found Window](#LastFoundWindow)

## Matching Behaviour

[SetTitleMatchMode](../commands/SetTitleMatchMode.htm) controls how a partial or complete title is compared against the title of each window. Depending on the setting, WinTitle can be an exact title, or it can contain a prefix, a substring which occurs anywhere in the title, or a [RegEx pattern](RegEx-QuickRef.htm). This setting also controls whether the [ahk\_class](#ahk_class) and [ahk\_exe](#ahk_exe) criteria are interpreted as RegEx patterns.

Window titles are case sensitive, except when using the [i) modifier](RegEx-QuickRef.htm#opt_i) in a RegEx pattern.

Hidden windows are only detected if [DetectHiddenWindows](../commands/DetectHiddenWindows.htm) is turned on, except with [WinShow](../commands/WinShow.htm), which always detects hidden windows.

If multiple windows match WinTitle and any other criteria, the topmost matching window is used. If the active window matches the criteria, it usually takes precedence since it is usually above all other windows. However, if an [always-on-top](../commands/WinSet.htm#AlwaysOnTop) window also matches (and the active window is not always-on-top), it may be used instead.

## A (Active Window)

Use the letter `A` for WinTitle and omit the other three window parameters ( _WinText_, _ExcludeTitle_ and _ExcludeText_), to operate on the active window.

The following example retrieves and reports the unique ID (HWND) of the active window:

```
MsgBox % WinExist("A")
```

The following example creates a hotkey which can be pressed to maximize the active window:

```
#Up::WinMaximize, A  <em>; Win+Up</em>
```

## ahk\_ Criteria

Specify one or more of the following ahk\_ criteria (optionally in addition to a window's title). An ahk\_ criterion always consists of an ahk\_ keyword and its criterion value, both separated by zero or more spaces or tabs. For example, `ahk_class Notepad` represents a Notepad window.

The ahk\_ keyword and its criterion value do not need to be separated by spaces or tabs. This is primarily useful when specifying ahk\_ criteria as expressions in combination with variables. For example, you could specify `"ahk_pid" PID` instead of `"ahk_pid " PID`. In all other cases, however, it is recommended to use at least one space or tab as a separation to improve readability.

### ahk\_class (Window Class)

Use `ahk_class <var>ClassName</var>` in WinTitle to identify a window by its window class.

A window class is a set of attributes that the system uses as a template to create a window. In other words, the class name of the window identifies what _type_ of window it is. A window class can be revealed via Window Spy or retrieved by [WinGetClass](../commands/WinGetClass.htm). If the RegEx [title matching mode](../commands/SetTitleMatchMode.htm) is active, ClassName accepts a [regular expression](RegEx-QuickRef.htm).

The following example activates a console window (e.g. cmd.exe):

```
WinActivate, ahk_class ConsoleWindowClass
```

The following example does the same as above, but uses a [regular expression](RegEx-QuickRef.htm) (note that the RegEx [title matching mode](../commands/SetTitleMatchMode.htm) must be turned on beforehand to make it work):

```
WinActivate, ahk_class i)^ConsoleWindowClass$
```

### ahk\_id (Unique ID / HWND)

Use `ahk_id <var>HWND</var>` in WinTitle to identify a window or control by its unique ID.

Each window or control has a unique ID, also known as a HWND (short for handle to window). This ID can be used to identify the window or control even if its title changes. The ID of a window is typically retrieved via [WinExist()](../commands/WinExist.htm) or [WinGet](../commands/WinGet.htm). The ID of a control is typically retrieved via [ControlGet Hwnd](../commands/ControlGet.htm#Hwnd), [MouseGetPos](../commands/MouseGetPos.htm), or [DllCall()](../commands/DllCall.htm). Also, the ahk\_id criterion will operate on controls even if they are hidden; that is, the setting of [DetectHiddenWindows](../commands/DetectHiddenWindows.htm) does not matter for controls.

The following example activates a window by a unique ID stored in VarContainingID:

```
WinActivate, ahk_id %VarContainingID%
```

### ahk\_pid (Process ID)

Use `ahk_pid <var>PID</var>` in WinTitle to identify a window belonging to a specific process. The process identifier (PID) is typically retrieved by [WinGet](../commands/WinGet.htm), [Run](../commands/Run.htm) or [Process](../commands/Process.htm). The ID of a window's process can be revealed via Window Spy.

The following example activates a window by a process ID stored in VarContainingPID:

```
WinActivate, ahk_pid %VarContainingPID%
```

### ahk\_exe (Process Name/Path) [v1.1.01+]

Use `ahk_exe <var>ProcessNameOrPath</var>` in WinTitle to identify a window belonging to any process with the given name or path.

While the [ahk\_pid criterion](#ahk_pid) is limited to one specific process, the ahk\_exe criterion considers all processes with name or full path matching a given string. If the RegEx [title matching mode](../commands/SetTitleMatchMode.htm) is active, ProcessNameOrPath accepts a [regular expression](RegEx-QuickRef.htm) which must match the full path of the process. Otherwise, it accepts a case-insensitive name or full path; for example, `ahk_exe notepad.exe` covers `ahk_exe C:\Windows\Notepad.exe`, `ahk_exe C:\Windows\System32\Notepad.exe` and other variations. The name of a window's process can be revealed via Window Spy.

The following example activates a Notepad window by its process name:

```
WinActivate, ahk_exe notepad.exe
```

The following example does the same as above, but uses a [regular expression](RegEx-QuickRef.htm) (note that the RegEx [title matching mode](../commands/SetTitleMatchMode.htm) must be turned on beforehand to make it work):

```
WinActivate, ahk_exe i)\\notepad\.exe$  <em>; Match the name part of the full path.</em>
```

### ahk\_group (Window Group)

Use `ahk_group <var>GroupName</var>` in WinTitle to identify a window or windows matching the rules contained by a previously defined [window group](../commands/GroupAdd.htm).

[WinMinimize](../commands/WinMinimize.htm), [WinMaximize](../commands/WinMaximize.htm), [WinRestore](../commands/WinRestore.htm), [WinHide](../commands/WinHide.htm), [WinShow](../commands/WinShow.htm), [WinClose](../commands/WinClose.htm), and [WinKill](../commands/WinKill.htm) will act on **all** the group's windows. By contrast, other window commands, functions and control flow statements such as [WinActivate](../commands/WinActivate.htm), [WinExist()](../commands/WinExist.htm) and [IfWinExist](../commands/IfWinExist.htm) will operate only on the topmost window of the group.

The following example activates any window matching the criteria defined by a window group:

```
<em>; Define the group: Windows Explorer windows</em>
GroupAdd, Explorer, ahk_class ExploreWClass <em>; Unused on Vista and later</em>
GroupAdd, Explorer, ahk_class CabinetWClass

<em>; Activate any window matching the above criteria</em>
WinActivate, ahk_group Explorer
```

## Multiple Criteria

By contrast with the [ahk\_group criterion](#ahk_group) (which broadens the search), the search may be narrowed by specifying more than one criterion within the WinTitle parameter. In the following example, the script waits for a window whose title contains _My File.txt_ **and** whose class is _Notepad_:

```
WinWait <strong>My File.txt</strong> ahk_class <strong>Notepad</strong>
WinActivate  <em>; Activate the window it found.</em>
```

When using this method, the text of the title (if any is desired) should be listed first, followed by one or more additional criteria. Criteria beyond the first should be separated from the previous with exactly one space or tab (any other spaces or tabs are treated as a literal part of the previous criterion).

The [ahk\_id criterion](#ahk_id) can be combined with other criteria to test a window's title, class or other attributes:

```
MouseGetPos,,, id
if WinExist("ahk_class Notepad ahk_id " id)
    MsgBox The mouse is over Notepad.

```

## Last Found Window

This is the window most recently found by [IfWinExist](../commands/IfWinExist.htm), [IfWinNotExist](../commands/IfWinExist.htm), [WinExist()](../commands/WinExist.htm), [IfWinActive](../commands/IfWinActive.htm), [IfWinNotActive](../commands/IfWinActive.htm), [WinActive()](../commands/WinActive.htm), [WinWaitActive](../commands/WinWaitActive.htm), [WinWaitNotActive](../commands/WinWaitActive.htm), or [WinWait](../commands/WinWait.htm). It can make scripts easier to create and maintain since WinTitle and WinText of the target window do not need to be repeated for every windowing command, function or control flow statement. In addition, scripts perform better because they don't need to search for the target window again after it has been found the first time.

The last found window can be used by all of the windowing commands, functions and control flow statements except [WinWait](../commands/WinWait.htm), [WinActivateBottom](../commands/WinActivateBottom.htm), [GroupAdd](../commands/GroupAdd.htm), [WinGet Count](../commands/WinGet.htm#Count), and [WinGet List](../commands/WinGet.htm#List). To use it, simply omit all four window parameters (WinTitle, WinText, ExcludeTitle, and ExcludeText).

Each [thread](Threads.htm) retains its own value of the last found window, meaning that if the [current thread](Threads.htm) is interrupted by another, when the original thread is resumed it will still have its original value of the last found window, not that of the interrupting thread.

If the last found window is a hidden [Gui window](../commands/Gui.htm), it can be used even when [DetectHiddenWindows](../commands/DetectHiddenWindows.htm) is turned off. This is often used in conjunction with [Gui +LastFound](../commands/Gui.htm#LastFound).

The following example opens Notepad, waits until it exists and activates it:

```
Run Notepad
WinWait Untitled - Notepad
WinActivate <em>; Use the window found by WinWait.</em>
```

The following example activates and maximizes the Notepad window found by the WinExist function above:

```
if WinExist("Untitled - Notepad")
{
    WinActivate <em>; Use the window found by WinExist.</em>
    WinMaximize <em>; Same as above.</em>
    Send, Some text.{Enter}
    return
}
```

The following example returns if the calculator does not exist, otherwise the calculator will be activated and moved to a new position:

```
if not WinExist("Calculator")
    return
else
{
    WinActivate <em>; Use the window found by WinExist.</em>
    WinMove, 40, 40 <em>; Same as above.</em>
    return
}
```

