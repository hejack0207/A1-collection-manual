# GroupAdd

Adds a window specification to a window group, creating the group if necessary.

```
<span class="func">GroupAdd</span>, GroupName <span class="optional">, WinTitle, WinText, Label, ExcludeTitle, ExcludeText</span>
```

## Parameters

GroupName

The name of the group to which to add this window specification. If the group doesn't exist, it will be created. Group names are not case sensitive.

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON at the time that [GroupActivate](GroupActivate.htm), [GroupDeactivate](GroupDeactivate.htm), and [GroupClose](GroupClose.htm) are used.

Label

The label of a subroutine to run if no windows matching this group (or this _window specification_ prior to AHK\_L 54) exist when the [GroupActivate](GroupActivate.htm) command is used. The label is jumped to as though a [Gosub](Gosub.htm) had been used. Omit or leave blank for none.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Remarks

Each use of this command adds a new rule to a group. In other words, a group consists of a set of criteria rather than a fixed list of windows. Later, when a group is used by a command such as [GroupActivate](GroupActivate.htm), each window on the desktop is checked against each of these criteria. If a window matches one of the criteria in the group, it is considered a match.

Although [SetTitleMatchMode](SetTitleMatchMode.htm) and [DetectHiddenWindows](DetectHiddenWindows.htm) do not directly affect the behavior of this command, they do affect the other group commands such as [GroupActivate](GroupActivate.htm) and [GroupClose](GroupClose.htm). They also affect the use of ahk\_group in any other command's [WinTitle](../misc/WinTitle.htm).

A window group is typically used to bind together a collection of related windows, which is useful for tasks that involve many related windows, or an application that owns many subwindows. For example, if you frequently work with many instances of a graphics program or text editor, you can use [GroupActivate](GroupActivate.htm) on a hotkey to visit each instance of that program, one at a time, without having to use alt-tab or task bar buttons to locate them.

Since the entries in each group need to be added only once, this command is typically used in the auto-execute section (top part of the script). Attempts to add duplicate entries to a group are ignored.

To include all windows in a group (except the special Program Manager window), use this example:

```
GroupAdd, AllWindows
```

All windowing commands can operate upon a window group by specifying `ahk_group MyGroupName` for the _WinTitle_ parameter. The commands [WinMinimize](WinMinimize.htm), [WinMaximize](WinMaximize.htm), [WinRestore](WinRestore.htm), [WinHide](WinHide.htm), [WinShow](WinShow.htm), [WinClose](WinClose.htm), and [WinKill](WinKill.htm) will act upon **all** the group's windows. To instead act upon only the topmost window, follow this example:

```
WinHide % "ahk_id " . WinExist("ahk_group <strong>MyGroup</strong>")
```

By contrast, the other window commands such as [WinActivate](WinActivate.htm), [WinExist()](WinExist.htm) and [IfWinExist](IfWinExist.htm) will operate only upon the topmost window of the group.

## Related

[GroupActivate](GroupActivate.htm), [GroupDeactivate](GroupDeactivate.htm), [GroupClose](GroupClose.htm)

## Examples

Press a hotkey to traverse all open MSIE windows.

```
<em>; In the autoexecute section at the top of the script:</em>
GroupAdd, MSIE, ahk_class IEFrame <em>; Add only Internet Explorer windows to this group.</em>
return <em>; End of autoexecute section.</em>

<em>; Assign a hotkey to activate this group, which traverses
; through all open MSIE windows, one at a time (i.e. each
; press of the hotkey).</em>
Numpad1::GroupActivate, MSIE, r
```

Press a hotkey to visit each MS Outlook 2002 window, one at a time.

```
<em>; In the autoexecute section at the top of the script:</em>
SetTitleMatchMode, 2
GroupAdd, mail, Message - Microsoft Word <em>; This is for mails currently being composed</em>
GroupAdd, mail, - Message ( <em>; This is for already opened items
; Need extra text to avoid activation of a phantom window:</em>
GroupAdd, mail, Advanced Find, Sear&ch for the word(s)
GroupAdd, mail, , Recurrence:
GroupAdd, mail, Reminder
GroupAdd, mail, - Microsoft Outlook
return  <em>; End of autoexecute section.</em>

<em>; Assign a hotkey to visit each Outlook window, one at a time.</em>
Numpad5::GroupActivate, mail
```

