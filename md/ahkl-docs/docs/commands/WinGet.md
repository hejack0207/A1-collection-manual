# WinGet

Retrieves the specified window's unique ID, process ID, process name, or a list of its controls. It can also retrieve a list of all windows matching the specified criteria.

```
<span class="func">WinGet</span>, OutputVar <span class="optional">, <a href="#SubCommands" data-index="1">SubCommand</a>, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

OutputVarThe name of the variable in which to store the result of _SubCommand_.SubCommandThe operation to perform, which if blank defaults to the [ID](#ID) sub-command. See [Sub-commands](#SubCommands).
WinTitleA window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).WinTextIf present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.ExcludeTitleWindows whose titles include this value will not be considered.ExcludeTextWindows whose text include this value will not be considered.

## Sub-commands

For _SubCommand_, specify one of the following:

- [ID](#ID): Retrieves the unique ID number of a window.
- [IDLast](#IDLast): Retrieves the unique ID number of the last/bottommost window if there is more than one match.
- [PID](#PID): Retrieves the Process ID number of a window.
- [ProcessName](#ProcessName): Retrieves the name of the process that owns a window.
- [ProcessPath](#ProcessPath)[v1.1.01+]: Retrieves the full path and name of the process that owns a window.
- [Count](#Count): Retrieves the number of existing windows that match the title/text parameters.
- [List](#List): Retrieves the unique ID numbers of all existing windows that match the title/text parameters.
- [MinMax](#MinMax): Retrieves the minimized/maximized state for a window.
- [ControlList](#ControlList): Retrieves the control name for each control in a window.
- [ControlListHwnd](#ControlListHwnd)[v1.0.43.06+]: Retrieves the unique ID number for each control in a window.
- [Transparent](#Transparent): Retrieves the degree of transparency of a window.
- [TransColor](#TransColor): Retrieves the color that is marked transparent in a window.
- [Style](#Style): Retrieves an 8-digit hexadecimal number representing the style of a window.
- [ExStyle](#ExStyle): Retrieves an 8-digit hexadecimal number representing the extended style of a window.

### ID

Retrieves the unique ID number of a window.

```
<span class="func">WinGet</span>, OutputVar, ID <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

Also known as the [window handle (HWND)](ControlGet.htm#Hwnd). If there is no matching window, _OutputVar_ is made blank. The functions [WinExist()](WinExist.htm) and [WinActive()](WinActive.htm) can also be used to retrieve the ID of a window; for example, `WinExist("A")` is a fast way to get the ID of the active window. To discover the HWND of a control (for use with [Post/SendMessage](PostMessage.htm) or [DllCall](DllCall.htm)), use [ControlGet Hwnd](ControlGet.htm#Hwnd) or [MouseGetPos](MouseGetPos.htm).

### IDLast

Retrieves the unique ID number of the last/bottommost window if there is more than one match.

```
<span class="func">WinGet</span>, OutputVar, IDLast <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

Also known as the [window handle (HWND)](ControlGet.htm#Hwnd). If there is no matching window, _OutputVar_ is made blank. If there is only one match, it performs identically to the [ID](#ID) sub-command. This concept is similar to that used by [WinActivateBottom](WinActivateBottom.htm).

### PID

Retrieves the [Process ID number](Process.htm) of a window.

```
<span class="func">WinGet</span>, OutputVar, PID <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If there is no matching window, _OutputVar_ is made blank.

### ProcessName

Retrieves the name of the process that owns a window.

```
<span class="func">WinGet</span>, OutputVar, ProcessName <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

For example, this would be "notepad.exe". If there are no matching windows, _OutputVar_ is made blank.

### ProcessPath [v1.1.01+]

Retrieves the full path and name of the process that owns a window.

```
<span class="func">WinGet</span>, OutputVar, ProcessPath <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

For example, this would be "C:\\Windows\\System32\\notepad.exe". If there are no matching windows, _OutputVar_ is made blank.

### Count

Retrieves the number of existing windows that match the title/text parameters.

```
<span class="func">WinGet</span>, OutputVar, Count <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If there are no matching windows, _OutputVar_ is set to zero. To count all windows on the system, omit all four title/text parameters. Hidden windows are included only if [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

### List

Retrieves the unique ID numbers of all existing windows that match the title/text parameters.

```
<span class="func">WinGet</span>, OutputVar, List <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

To retrieve all windows on the entire system, omit all four title/text parameters. Each ID number is stored in a variable whose name begins with _OutputVar_'s own name (to form a [pseudo-array](../misc/Arrays.htm#pseudo)), while _OutputVar_ itself is set to the number of retrieved items (0 if none). For example, if _OutputVar_ is MyArray and two matching windows are discovered, MyArray1 will be set to the ID of the first window, MyArray2 will be set to the ID of the second window, and MyArray itself will be set to the number 2. Windows are retrieved in order from topmost to bottommost (according to how they are stacked on the desktop). Hidden windows are included only if [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on. Within a [function](../Functions.htm), to create a pseudo-array that is global instead of local, [declare](../Functions.htm#Global) MyArray as a global variable prior to using this command (the converse is true for [assume-global](../Functions.htm#AssumeGlobal) functions). However, it is often also necessary to declare each variable in the set, due to a [common source of confusion](../Functions.htm#ArrayConfusion).

### MinMax

Retrieves the minimized/maximized state for a window.

```
<span class="func">WinGet</span>, OutputVar, MinMax <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

_OutputVar_ is made blank if no matching window exists; otherwise, it is set to one of the following numbers:

- -1: The window is minimized ( [WinRestore](WinRestore.htm) can unminimize it).
- 1: The window is maximized ( [WinRestore](WinRestore.htm) can unmaximize it).
- 0: The window is neither minimized nor maximized.

### ControlList

Retrieves the control name for each control in a window.

```
<span class="func">WinGet</span>, OutputVar, ControlList <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If no matching window exists or there are no controls in the window, _OutputVar_ is made blank. Otherwise, each control name consists of its class name followed immediately by its sequence number (ClassNN), as shown by Window Spy.

Each item except the last is terminated by a linefeed (\`n). To examine the individual control names one by one, use a [parsing loop](LoopParse.htm) as shown in [example #3](#ExControlList) below.

Controls are sorted according to their Z-order, which is usually the same order as the navigation order via Tab if the window supports tabbing.

### ControlListHwnd [v1.0.43.06+]

Retrieves the unique ID number for each control in a window.

```
<span class="func">WinGet</span>, OutputVar, ControlListHwnd <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If no matching window exists or there are no controls in the window, _OutputVar_ is made blank. Otherwise, each unique ID is the [window handle (HWND)](ControlGet.htm#Hwnd) of the control. Each item except the last is terminated by a linefeed (\`n).

Controls are sorted according to their Z-order, which is usually the same order as the navigation order via Tab if the window supports tabbing.

### Transparent

Retrieves the degree of transparency of a window.

```
<span class="func">WinGet</span>, OutputVar, Transparent <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

See [WinSet](WinSet.htm) for how to set transparency. _OutputVar_ is made blank if: 1) the OS is older than Windows XP; 2) there are no matching windows; 3) the window has no transparency level; or 4) other conditions (caused by OS behavior) such as the window having been minimized, restored, and/or resized since it was made transparent. Otherwise, a number between 0 and 255 is stored, where 0 indicates an invisible window and 255 indicates an opaque window. For example:

```
MouseGetPos,,, MouseWin
WinGet, Transparent, Transparent, ahk_id %MouseWin%  <em>; Transparency of window under the mouse cursor.</em>
```

### TransColor

Retrieves the color that is marked transparent in a window.

```
<span class="func">WinGet</span>, OutputVar, TransColor <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

See [WinSet](WinSet.htm#TransColor) for how to set the TransColor. _OutputVar_ is made blank if: 1) the OS is older than Windows XP; 2) there are no matching windows; 3) the window has no transparent color; or 4) other conditions (caused by OS behavior) such as the window having been minimized, restored, and/or resized since it was made transparent. Otherwise, a six-digit hexadecimal RGB color is stored, e.g. 0x00CC99. For example:

```
MouseGetPos,,, MouseWin
WinGet, TransColor, TransColor, ahk_id %MouseWin%  <em>; TransColor of the window under the mouse cursor.</em>
```

### Style

Retrieves an 8-digit hexadecimal number representing the style of a window.

```
<span class="func">WinGet</span>, OutputVar, Style <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If there are no matching windows, _OutputVar_ is made blank. The following example determines whether a window has the WS\_DISABLED style:

```
WinGet, Style, Style, My Window Title
if (Style & 0x8000000)  <em>; 0x8000000 is WS_DISABLED.</em>
  MsgBox The window is disabled.
```

See the [styles table](../misc/Styles.htm) for a partial listing of styles.

### ExStyle

Retrieves an 8-digit hexadecimal number representing the extended style of a window.

```
<span class="func">WinGet</span>, OutputVar, ExStyle <span class="optional">, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If there are no matching windows, _OutputVar_ is made blank. The following example determines whether a window has the WS\_EX\_TOPMOST style (always-on-top):

```
WinGet, ExStyle, ExStyle, My Window Title
if (ExStyle & 0x8)  <em>; 0x8 is WS_EX_TOPMOST.</em>
   MsgBox The window is always-on-top.
```

See the [styles table](../misc/Styles.htm) for a partial listing of styles.

## Remarks

A window's ID number is valid only during its lifetime. In other words, if an application restarts, all of its windows will get new ID numbers.

ID numbers retrieved by this command are numeric (the prefix "ahk\_id" is not included) and are stored in hexadecimal format regardless of the setting of [SetFormat](SetFormat.htm).

The ID of the window under the mouse cursor can be retrieved with [MouseGetPos](MouseGetPos.htm).

Although ID numbers are currently 32-bit unsigned integers, they may become 64-bit in future versions. Therefore, it is unsafe to perform numerical operations such as addition on these values because such operations require that their input strings be parsable as signed rather than unsigned integers.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[WinGetClass](WinGetClass.htm), [Process](Process.htm), [WinGetTitle](WinGetTitle.htm), [MouseGetPos](MouseGetPos.htm), [ControlGet](ControlGet.htm), [ControlFocus](ControlFocus.htm), [GroupAdd](GroupAdd.htm)

## Examples

Maximizes the active window and reports its unique ID.

```
WinGet, active_id, ID, A
WinMaximize, ahk_id %active_id%
MsgBox, The active window's ID is "%active_id%".
```

Visits all windows on the entire system and displays info about each of them.

```
WinGet, id, List,,, Program Manager
Loop, %id%
{
    this_id := id%A_Index%
    WinActivate, ahk_id %this_id%
    WinGetClass, this_class, ahk_id %this_id%
    WinGetTitle, this_title, ahk_id %this_id%
    MsgBox, 4, , Visiting All Windows`n%A_Index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
    IfMsgBox, NO, break
}
```

Extracts the individual control names from the active window's control list.

```
WinGet, ActiveControlList, ControlList, A
Loop, Parse, ActiveControlList, `n
{
    MsgBox, 4,, Control #%A_Index% is "%A_LoopField%". Continue?
    IfMsgBox, No
        break
}
```

Displays in real time the active window's control list.

```
#Persistent
SetTimer, WatchActiveWindow, 200
return

WatchActiveWindow:
WinGet, ControlList, ControlList, A
ToolTip, %ControlList%
return
```

