# Control

Makes a variety of changes to a control.

```
<span class="func">Control</span>, <a href="#SubCommands" data-index="1">SubCommand</a> <span class="optional">, Value, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

SubCommand, ValueThese are dependent upon each other and their usage is described [below](#SubCommands).Control

Can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm). If this parameter is blank, the target window's topmost control will be used.

To operate upon a control's HWND (window handle), leave the _Control_ parameter blank and specify `ahk_id %ControlHwnd%` for the _WinTitle_ parameter (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off). The HWND of a control is typically retrieved via [ControlGet Hwnd](ControlGet.htm#Hwnd), [MouseGetPos](MouseGetPos.htm), or [DllCall()](DllCall.htm).

WinTitleA window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).WinTextIf present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.ExcludeTitleWindows whose titles include this value will not be considered.ExcludeTextWindows whose text include this value will not be considered.

## Sub-commands

For _SubCommand_, specify one of the following:

- [Check](#Check): Turns on (checks) a radio button or checkbox.
- [Uncheck](#Uncheck): Turns off a radio button or checkbox.
- [Enable](#Enable): Enables a control if it was previously disabled.
- [Disable](#Disable): Disables or "grays out" a control.
- [Show](#Show): Shows a control if it was previously hidden.
- [Hide](#Hide): Hides a control.
- [Style](#Style): Changes the style of a control.
- [ExStyle](#ExStyle): Changes the extended style of a control.
- [ShowDropDown](#ShowDropDown): Shows the drop-down list of a ComboBox control.
- [HideDropDown](#HideDropDown): Hides the drop-down list of a ComboBox control.
- [TabLeft](#TabLeft): Moves left by one or more tabs in a SysTabControl32.
- [TabRight](#TabRight): Moves right by one or more tabs in a SysTabControl32.
- [Add](#Add): Adds the specified string as a new entry at the bottom of a ListBox, ComboBox (and possibly other types).
- [Delete](#Delete): Deletes the specified entry number from a ListBox or ComboBox.
- [Choose](#Choose): Sets the selection in a ListBox or ComboBox to be the specified entry number.
- [ChooseString](#ChooseString): Sets the selection in a ListBox or ComboBox to be the first entry whose leading part matches the specified string.
- [EditPaste](#EditPaste): Pastes the specified string at the caret in an Edit control.

### Check

Turns on (checks) a radio button or checkbox.

```
<span class="func">Control</span>, Check <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

To ensure correct functionality, this sub-command also sets the input focus to the control.

### Uncheck

Turns off a radio button or checkbox.

```
<span class="func">Control</span>, Uncheck <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

To ensure correct functionality, this sub-command also sets the input focus to the control.

### Enable

Enables a control if it was previously disabled.

```
<span class="func">Control</span>, Enable <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### Disable

Disables or "grays out" a control.

```
<span class="func">Control</span>, Disable <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### Show

Shows a control if it was previously hidden.

```
<span class="func">Control</span>, Show <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### Hide

Hides a control.

```
<span class="func">Control</span>, Hide <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If you additionally want to prevent a control's shortcut key (underlined letter) from working, disable the control via the [Disable](#Disable) sub-command.

### Style

Changes the style of a control.

```
<span class="func">Control</span>, Style, N <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If the first character of _N_ is a plus or minus sign, the style(s) in _N_ are added or removed, respectively. If the first character is a caret (^), the style(s) in N are each toggled to the opposite state. If the first character is a digit, the control's style is overwritten completely; that is, it becomes _N_. [ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the target window/control is not found or the style is not allowed to be applied.

Certain style changes require that the entire window be redrawn using [WinSet Redraw](WinSet.htm). Also, the [styles table](../misc/Styles.htm) lists some of the style numbers. For example:

```
Control, Style, ^0x800000, Edit1, WinTitle  <em>; Set the WS_BORDER style to its opposite state.</em>
```

### ExStyle

Changes the extended style of a control.

```
<span class="func">Control</span>, ExStyle, N <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

See the [Style](#Style) sub-command above for details.

### ShowDropDown

Shows the drop-down list of a ComboBox control.

```
<span class="func">Control</span>, ShowDropDown <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### HideDropDown

Hides the drop-down list of a ComboBox control.

```
<span class="func">Control</span>, HideDropDown <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### TabLeft

Moves left by one or more tabs in a SysTabControl32.

```
<span class="func">Control</span>, TabLeft <span class="optional">, Count, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

_Count_ is assumed to be 1 if omitted or blank. To instead select a tab directly by number, replace the number 5 below with one less than the tab number you wish to select. In other words, 0 selects the first tab, 1 selects the second, and so on:

```
<a href="PostMessage.htm" data-index="32">SendMessage</a>, 0x1330, <span class="red">5</span>,, SysTabControl321, WinTitle  <em>; 0x1330 is TCM_SETCURFOCUS.</em>
Sleep 0  <em>; This line and the next are necessary only for certain tab controls.</em>
SendMessage, 0x130C, <span class="red">5</span>,, SysTabControl321, WinTitle  <em>; 0x130C is TCM_SETCURSEL.</em>
```

### TabRight

Moves right by one or more tabs in a SysTabControl32.

```
<span class="func">Control</span>, TabRight <span class="optional">, Count, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

See the [TabLeft](#Style) sub-command above for details.

### Add

Adds _String_ as a new entry at the bottom of a ListBox, ComboBox (and possibly other types).

```
<span class="func">Control</span>, Add, String <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### Delete

Deletes the Nth entry from a ListBox or ComboBox.

```
<span class="func">Control</span>, Delete, N <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

_N_ should be 1 for the first entry, 2 for the second, etc.

### Choose

Sets the selection in a ListBox or ComboBox to be the Nth entry.

```
<span class="func">Control</span>, Choose, N <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

_N_ should be 1 for the first entry, 2 for the second, etc. To select or deselect all items in a _multi-select_ listbox, follow this example:

```
<a href="PostMessage.htm" data-index="34">PostMessage</a>, 0x0185, 1, -1, ListBox1, WinTitle  <em>; Select all listbox items. 0x0185 is LB_SETSEL.</em>
```

### ChooseString

Sets the selection (choice) in a ListBox or ComboBox to be the first entry whose leading part matches _String_.

```
<span class="func">Control</span>, ChooseString, String <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

The search is not case sensitive. For example, if a ListBox/ComboBox contains the item "UNIX Text", specifying the word unix (lowercase) would be enough to select it.

### EditPaste

Pastes _String_ at the caret/insert position in an Edit control.

```
<span class="func">Control</span>, EditPaste, String <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

This does not affect the contents of the [clipboard](../misc/Clipboard.htm).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

To improve reliability, a delay is done automatically after every use of this command (except for the sub-commands [Style](#Style) and [ExStyle](#ExStyle)). That delay can be changed via [SetControlDelay](SetControlDelay.htm).

To discover the ClassNN or HWND of the control that the mouse is currently hovering over, use [MouseGetPos](MouseGetPos.htm).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[SetControlDelay](SetControlDelay.htm), [ControlGet](ControlGet.htm), [GuiControl](GuiControl.htm), [ControlGetText](ControlGetText.htm), [ControlSetText](ControlSetText.htm), [ControlMove](ControlMove.htm), [ControlGetPos](ControlGetPos.htm), [ControlClick](ControlClick.htm), [ControlFocus](ControlFocus.htm), [ControlSend](ControlSend.htm), [WinSet](WinSet.htm)

## Examples

Hides the drop-down list of the first ComboBox.

```
Control, HideDropDown,, ComboBox1, Some Window Title
```

