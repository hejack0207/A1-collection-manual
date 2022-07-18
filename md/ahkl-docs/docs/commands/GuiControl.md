# GuiControl

Makes a variety of changes to a control in a GUI window.

```
<span class="func">GuiControl</span>, <a href="#SubCommands" data-index="1">SubCommand</a>, ControlID <span class="optional">, Value</span>
```

## Parameters

SubCommand, ValueThese are dependent upon each other and their usage is described [below](#SubCommands).ControlID

If the target control has an associated variable, specify the variable's name as the _ControlID_ (this method takes precedence over the ones described next). For this reason, it is usually best to assign a variable to any control that will later be accessed via GuiControl or GuiControlGet, even if that control is not an input-capable type (such as GroupBox or Text).

Otherwise, _ControlID_ can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm).

**Note**: A picture control's file name (as it was specified at the time the control was created) may be used as its _ControlID_.

[v1.1.04+]: _ControlID_ can be the [HWND](Gui.htm#HwndOutputVar) of a control.

If the control is not on the default GUI, **the name or HWND of the GUI must also be specified** \-\- except on [v1.1.20+] when _ControlID_ is a HWND, since each HWND is unique. See [Remarks](#Remarks) for details.

## Sub-commands

For _SubCommand_, specify one of the following:

- [(Blank)](#Blank): Puts new contents into the control.
- [Text](#Text): Changes the text/caption of the control.
- [Move](#Move): Moves and/or resizes the control.
- [MoveDraw](#MoveDraw): Moves and/or resizes the control and repaints the region occupied by it.
- [Focus](#Focus): Sets keyboard focus to the control.
- [Disable](#Disable): Disables (grays out) the control.
- [Enable](#Enable): Enables the control.
- [Hide](#Hide): Hides the control.
- [Show](#Show): Shows the control.
- [Delete](#Delete): Not yet implemented.
- [Choose](#Choose): Selects the specified item number in a multi-item control.
- [ChooseString](#ChooseString): Selects a item in a multi-item control whose leading part matches a string.
- [Font](#Font): Changes the control's font typeface, size, color, and style.
- [Options](#options): Add or remove various control-specific or general options and styles.

### (Blank)

Puts new contents into the control.

```
<span class="func">GuiControl</span>,, ControlID <span class="optional">, Value</span>
```

Leave _SubCommand_ blank to put new contents into the control via _Value_. Specifically:

[Picture](GuiControls.htm#Picture): _Value_ should be the filename (or [handle](../misc/ImageHandles.htm)) of the new image to load (see [Gui Picture](GuiControls.htm#Picture) for supported file types). Zero or more of the following options may be specified immediately in front of the filename: `*wN` (width N), `*hN` (height N), and `*IconN` (icon group number N in a DLL or EXE file). In the following example, the default icon from the second icon group is loaded with a width of 100 and an automatic height via "keep aspect ratio": `GuiControl,, MyPic, *icon2 *w100 *h-1 C:\My Application.exe`. Specify `*w0 *h0` to use the image's actual width and height. If `*w` and `*h` are omitted, the image will be scaled to fit the current size of the control. When loading from a multi-icon .ICO file, specifying a width and height also determines which icon to load.

**Note**: Use only one space or tab between the final option and the filename itself; any other spaces and tabs are treated as part of the filename.

[Text](GuiControls.htm#Text)/ [Button](GuiControls.htm#Button)/ [GroupBox](GuiControls.htm#GroupBox)/ [StatusBar](GuiControls.htm#StatusBar)/ [Link](GuiControls.htm#Link): Specify for _Value_ the control's new text. Since the control will not expand automatically, use `<a href="#Move" data-index="28">GuiControl, Move</a>, MyText, W300` if the control needs to be widened. For [StatusBar](GuiControls.htm#StatusBar), this sets the text of the first part only (use [SB\_SetText()](GuiControls.htm#SB_SetText) for greater flexibility).

[Edit](GuiControls.htm#Edit): Any linefeeds (\`n) in _Value_ that lack a preceding carriage return (\`r) are automatically translated to CR+LF (\`r\`n) to make them display properly. However, this is usually not a concern because the `Gui Submit` and `GuiControlGet OutputVar` commands will automatically undo this translation by replacing CR+LF with LF (\`n).

[Hotkey](GuiControls.htm#Hotkey): _Value_ can be blank to clear the control, or a set of modifiers with a key name. Examples: `^!c`, `^Numpad1`, `+Home`. The only modifiers supported are ^ (Ctrl), ! (Alt), and + (Shift). See the [key list](../KeyList.htm) for available key names.

[Checkbox](GuiControls.htm#Checkbox): _Value_ can be 0 to uncheck the button, 1 to check it, or -1 to give it a gray checkmark. Otherwise, _Value_ is assumed to be the control's new caption/text. See the [Text](#Text) sub-command below for how to override this behavior.

[Radio](GuiControls.htm#Radio): Same as Checkbox above. However, if the radio button is being checked (turned on) and it is a member of a multi-radio group, the other radio buttons in its group will be automatically unchecked. To check a new button within a radio group that only has one variable, specify for _ControlID_ the name/text of the button if it is not the button with which the variable is directly associated.

[DateTime](GuiControls.htm#DateTime)/ [MonthCal](GuiControls.htm#MonthCal): Specify for _Value_ a date-time stamp in [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format. Specify `%A_Now%` to use the current date and time (today). For DateTime controls, _Value_ may be omitted to cause the control to have no date/time selected (if it was created with [that ability](GuiControls.htm#ChooseNone)). For MonthCal controls, a range may be specified if the control is [multi-select](GuiControls.htm#MonthCalMulti).

[UpDown](GuiControls.htm#UpDown)/ [Slider](GuiControls.htm#Slider)/ [Progress](GuiControls.htm#Progress): _Value_ should be the new position of the control. If a _Value_'s first character is a plus sign, the number will be assumed to be an offset from the current position. For example, `+10` would increase the position by 10 and `+-10` (plus minus ten) would decrease it by 10. If the new position would be outside the range of the control, the control is generally set to the nearest valid value.

[Tab](GuiControls.htm#Tab)/ [DropDownList](GuiControls.htm#DropDownList)/ [ComboBox](GuiControls.htm#ComboBox)/ [ListBox](GuiControls.htm#ListBox): _Value_ should contain a pipe-delimited list of entries to be appended at the end of the control's list. To replace (overwrite) the list instead, include a pipe as the first character (e.g. `|Red|Green|Blue`). To make the control empty, specify only a pipe character (\|). To have one of the entries pre-selected, include two pipes after it (e.g. `Red|Green||Blue`). The separator between fields may be changed to something other than pipe. For example, ``<a href="Gui.htm#Delimiter" data-index="49">Gui +Delimiter`n</a>`` would change it to linefeed and `Gui +DelimiterTab` would change it to tab (\`t).

[Tab controls](GuiControls.htm#Tab): In addition to the behavior described in the paragraph above, a tab's sub-controls stay associated with their original tab number; that is, they are never associated with their tab's actual display-name. For this reason, renaming or removing a tab will not change the tab number to which the sub-controls belong. For example, if there are three tabs "Red\|Green\|Blue" and the second tab is removed by means of `GuiControl,, MyTab, |Red|Blue`, the sub-controls originally associated with Green will now be associated with Blue. Because of this behavior, only tabs at the end should generally be removed. Tabs that are removed in this way can be added back later, at which time they will reclaim their original set of controls.

[ListView](ListView.htm) and [TreeView](TreeView.htm): These are not supported when _SubCommand_ is blank. Instead, use the built-in [ListView functions](ListView.htm#BuiltIn) and [TreeView functions](TreeView.htm#BuiltIn).

### Text

Changes the text/caption of the control.

```
<span class="func">GuiControl</span>, Text, ControlID <span class="optional">, Value</span>
```

Behaves the same as the [blank](#Blank) sub-command above except for:

[Checkbox](GuiControls.htm#Checkbox)/ [Radio](GuiControls.htm#Radio): _Value_ is treated as the new text/caption even if it is -1, 0, or 1.

[DateTime](GuiControls.htm#DateTime): _Value_ is treated as the new [date/time format](GuiControls.htm#DateTimeFormat) displayed by the control. If _Value_ is omitted, any custom format is removed and the short-date format is put into effect.

[ComboBox](GuiControls.htm#ComboBox): _Value_ is treated as the text to put directly into the ComboBox's Edit control.

### Move

Moves and/or resizes the control.

```
<span class="func">GuiControl</span>, Move, ControlID, Options
```

Specify one or more of the following option letters in _Options_: X (the x-coordinate relative to the GUI window's client area, which is the area not including title bar, menu bar, and borders); Y (the y-coordinate), W (Width), H (Height). (Specify each number as decimal, not hexadecimal.) For example:

```
GuiControl, Move, MyEdit, x10 y20 w200 h100
GuiControl, Move, MyEdit, % "x" VarX+10 "y" VarY+5 "w" VarW*2 "h" VarH*1.5 <em>; Uses an <a href="../Variables.htm#Expressions" data-index="61">expression</a> via "% " prefix.</em>
```

### MoveDraw

Moves and/or resizes the control and repaints the region of the GUI window occupied by the control.

```
<span class="func">GuiControl</span>, MoveDraw, ControlID <span class="optional">, Options</span>
```

See the [Move](#Move) sub-command (above) for details. Although this may cause an unwanted flickering effect when called repeatedly and rapidly, it solves painting artifacts for certain control types such as [GroupBoxes](GuiControls.htm#GroupBox). [v1.0.48.04+]: The last parameter may be omitted to redraw the control without moving or resizing it.

### Focus

Sets keyboard focus to the control.

```
<span class="func">GuiControl</span>, Focus, ControlID
```

To be effective, the window generally must not be minimized or hidden.

### Disable

Disables (grays out) the control.

```
<span class="func">GuiControl</span>, Disable, ControlID
```

For Tab controls, this will also disable all of the tab's sub-controls. The word Disable may optionally be followed immediately by a 0 or 1. A zero causes the effect to be inverted. For example, `Disable` and `Disable%VarContainingOne%` would both disable the control, but `Disable%VarContainingZero%` would enable it.

### Enable

Enables the control.

```
<span class="func">GuiControl</span>, Enable, ControlID
```

For Tab controls, this will also enable all of the tab's sub-controls. However, any sub-control explicitly disabled via the [Disable](#Disable) sub-command (above) will remember that setting and thus remain disabled even after its Tab control is re-enabled. The word Enable may optionally be followed immediately by a 0 or 1. A zero causes the effect to be inverted. For example, `Enable` and `Enable%VarContainingOne%` would both enable the control, but `Enable%VarContainingZero%` would disable it.

### Hide

Hides the control.

```
<span class="func">GuiControl</span>, Hide, ControlID
```

For Tab controls, this will also hide all of the tab's sub-controls. If you additionally want to prevent a control's shortcut key (underlined letter) from working, disable the control via the [Disable](#Disable) sub-command. The word Hide may optionally be followed immediately by a 0 or 1. A zero causes the effect to be inverted. For example, `Hide` and `Hide%VarContainingOne%` would both hide the control, but `Hide%VarContainingZero%` would show it.

### Show

Shows the control.

```
<span class="func">GuiControl</span>, Show, ControlID
```

For Tab controls, this will also show all of the tab's sub-controls. The word Show may optionally be followed immediately by a 0 or 1. A zero causes the effect to be inverted. For example, `Show` and `Show%VarContainingOne%` would both show the control, but `Show%VarContainingZero%` would hide it.

### Delete

**Not yet implemented**: This sub-command does not yet exist. As a workaround, use the sub-commands [Hide](#Hide) and/or [Disable](#Disable) (above), or destroy and recreate the entire window via [Gui Destroy](Gui.htm#Destroy).

### Choose

Sets the selection in a ListBox, DropDownList, ComboBox, or Tab control to be the Nth entry.

```
<span class="func">GuiControl</span>, Choose, ControlID, N
```

_N_ should be 1 for the first entry, 2 for the second, etc. If _N_ is not an integer, the [ChooseString](#ChooseString) sub-command (below) will be used instead. [v1.1.06+]: If _N_ is zero, the ListBox, DropDownList or ComboBox's current selection is removed.

Unlike [Control Choose](Control.htm), this sub-command will not trigger any [g-label](Gui.htm#label) associated with the control unless _N_ is preceded by a pipe character (even then, the g-label is triggered only when the new selection is different than the old one, at least for [Tab controls](GuiControls.htm#Tab)). For example: `GuiControl, Choose, MyListBox, <strong>|3</strong>`.

To additionally cause a finishing event to occur (a double-click in the case of ListBox), include two leading pipes instead of one (this is not supported for Tab controls).

To select or deselect **all** items in a [multi-select ListBox](GuiControls.htm#ListBoxMulti), follow this example:

```
Gui +LastFound  <em>; Avoids the need to specify WinTitle below.</em>
<a href="PostMessage.htm" data-index="74">PostMessage</a>, 0x0185, 1, -1, ListBox1  <em>; Select all items. 0x0185 is LB_SETSEL.</em>
<a href="PostMessage.htm" data-index="75">PostMessage</a>, 0x0185, 0, -1, ListBox1  <em>; Deselect all items.</em>
GuiControl, Choose, ListBox1, 0  <em>; Deselect all items <span class="ver">[requires v1.1.06+]</span>.</em>
```

### ChooseString

Sets the selection (choice) in a ListBox, DropDownList, ComboBox, or Tab control to be the entry whose leading part matches _String_.

```
<span class="func">GuiControl</span>, ChooseString, ControlID, String
```

The search is not case sensitive. For example, if a control contains the item "UNIX Text", specifying `GuiControl, ChooseString, <i>ControlID</i>, unix` would be enough to select it. The pipe and double-pipe prefix are also supported (see the [Choose](#Choose) sub-command above for details).

### Font

Changes the control's font to the typeface, size, color, and style currently in effect for its window.

```
<span class="func">GuiControl</span>, Font, ControlID
```

For example:

```
Gui, Font, s18 cRed Bold, Verdana  <em>; If desired, use a line like this to set a <a href="Gui.htm#Font" data-index="77">new default font</a> for the window.</em>
GuiControl, Font, MyEdit  <em>; Put the above font into effect for a control.</em>
```

### Options

Add or remove various [control-specific](GuiControls.htm) or [general](Gui.htm#OtherOptions) options and styles.

```
<span class="func">GuiControl</span>, +/-Option1 +/-Option2 ..., ControlID <span class="optional">, Value</span>
```

In the following example, the [AltSubmit](Gui.htm#AltSubmit) option is enabled but control's [g-label](Gui.htm#label) is removed:

```
GuiControl, +AltSubmit -g, MyListBox
```

In the next example, the OK button is made the new default button:

```
GuiControl, +Default, OK
```

Although [styles](../misc/Styles.htm) and extended styles are also recognized, some of them cannot be applied or removed after a control has been created. ErrorLevel is set to 0 if at least one of the specified changes was successfully applied. Otherwise, it is set to 1 to indicate that none of the changes could be applied. Even if a change is successfully applied, the control might choose to ignore it.

[v1.1.20+]: To set a [function object](../objects/Functor.htm) for handling [the control's events](Gui.htm#label), _Value_ must be a single variable reference, as in either of the following examples. Other expressions which return objects are currently unsupported.

```
GuiControl +g, <i>ControlID</i>, %FuncObj%
GuiControl +g, <i>ControlID</i>, % FuncObj
```

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the specified window/control does not exist or some other problem prevented the command from working. Otherwise, it is set to 0.

## Remarks

To operate upon a window other than the default, include its [name or number](Gui.htm#MultiWin) (or [in v1.1.03+] its HWND) followed by a colon in front of the sub-command as in these examples:

```
GuiControl, MyGui:Show, MyButton
GuiControl, MyGui:, MyListBox, Item1|Item2
```

This is required even if _ControlID_ is a control's associated variable, since any one variable can be used on multiple GUI windows. In [v1.1.20+], the GUI name can be omitted if _ControlID_ is a control's HWND.

A GUI [thread](../misc/Threads.htm) is defined as any thread launched as a result of a GUI action. GUI actions include selecting an item from a GUI window's menu bar, or triggering one of its [g-labels](Gui.htm#label) (such as by pressing a button).

The [default window name](Gui.htm#DefaultWin) for a GUI thread is that of the window that launched the thread. Non-GUI threads use 1 as their default.

## Related

[Gui](Gui.htm), [GuiControlGet](GuiControlGet.htm), [Control](Control.htm)

## Examples

Replaces the current list with a new list.

```
GuiControl,, MyListBox, |Red|Green|Blue
```

Puts new text into an Edit control.

```
GuiControl,, MyEdit, New text line 1.`nNew text line 2.
```

Turns on a radio button and turns off all the others in its group.

```
GuiControl,, MyRadio2, 1
```

Moves an OK button to a new location.

```
GuiControl, Move, OK, x100 y200
```

Sets keyboard focus to a control whose variable or text is "LastName".

```
GuiControl, Focus, LastName
```

