# GuiControlGet

Retrieves various types of information about a control in a GUI window.

```
<span class="func">GuiControlGet</span>, OutputVar <span class="optional">, <a href="#SubCommands" data-index="1">SubCommand</a>, ControlID, Value</span>
```

## Parameters

OutputVarThe name of the variable in which to store the result of _SubCommand_.SubCommand, ValueThese are dependent upon each other and their usage is described [below](#SubCommands).ControlID

If blank or omitted, it behaves as though the name of the output variable was specified. For example, `GuiControlGet, MyEdit` is the same as `GuiControlGet, MyEdit,, MyEdit`.

If the target control has an associated variable, specify the variable's name as the _ControlID_ (this method takes precedence over the ones described next). For this reason, it is usually best to assign a variable to any control that will later be accessed via GuiControl or GuiControlGet, even if that control is not input-capable (such as GroupBox or Text).

Otherwise, _ControlID_ can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm).

**Note**: A picture control's file name (as it was specified at the time the control was created) may be used as its _ControlID_.

[v1.1.04+]: _ControlID_ can be the [HWND](Gui.htm#HwndOutputVar) of a control.

If the control is not on the default GUI, **the name of the GUI must also be specified** \-\- except on [v1.1.20+] when _ControlID_ is a HWND, since each HWND is unique. See [Remarks](#Remarks) for details.

## Sub-commands

For _SubCommand_, specify one of the following:

- [(Blank)](#Blank): Retrieves the contents of the control.
- [Pos](#Pos): Retrieves the position and size of the control.
- [Focus](#Focus): Retrieves the control identifier (ClassNN) for the control that currently has keyboard focus.
- [FocusV](#FocusV)[v1.0.43.06+]: Retrieves the name of the focused control's associated variable.
- [Enabled](#Enabled): Retrieves 1 if the control is enabled or 0 if it is disabled.
- [Visible](#Visible): Retrieves 1 if the control is visible or 0 if it is hidden.
- [Hwnd](#Hwnd)[v1.0.46.16+]: Retrieves the window handle (HWND) of the control.
- [Name](#Name)[v1.1.03+]: Retrieves the name of the control's associated variable.

### (Blank)

Retrieves the contents of the control.

```
<span class="func">GuiControlGet</span>, OutputVar <span class="optional">,, ControlID, Value</span>
```

Leave _SubCommand_ blank to retrieve the control's contents. All control types are self-explanatory except the following:

[Picture](GuiControls.htm#Picture): Retrieves the picture's file name as it was originally specified when the control was created. This name does not change even if a new picture file name is specified.

[Edit](GuiControls.htm#Edit): Retrieves the contents but any line breaks in the text will be represented as plain linefeeds (\`n) rather than the traditional CR+LF (\`r\`n) used by non-GUI commands such as [ControlGetText](ControlGetText.htm) and [ControlSetText](ControlSetText.htm).

[Hotkey](GuiControls.htm#Hotkey): Retrieves a blank value if there is no hotkey in the control. Otherwise it retrieves the modifiers and key name. Examples: `^!C`, `^Home`, `+^NumpadHome`.

[Checkbox](GuiControls.htm#Checkbox)/ [Radio](GuiControls.htm#Radio): Retrieves 1 if the control is checked, 0 if it is unchecked, or -1 if it has a gray checkmark. To retrieve the control's text/caption instead, specify the word Text for _Value_. Note: Unlike the [Gui Submit](Gui.htm#Submit) command, radio buttons are always retrieved individually, regardless of whether they are in a radio group.

[UpDown](GuiControls.htm#UpDown)/ [Slider](GuiControls.htm#Slider)/ [Progress](GuiControls.htm#Progress): Retrieves the control's current position.

[Tab](GuiControls.htm#Tab)/ [DropDownList](GuiControls.htm#DropDownList)/ [ComboBox](GuiControls.htm#ComboBox)/ [ListBox](GuiControls.htm#ListBox): Retrieves the text of the currently selected item/tab (or its position if the control has the [AltSubmit](Gui.htm#AltSubmit) property). For a ComboBox, if there is no selected item, the text in the control's edit field is retrieved instead. For a [multi-select ListBox](GuiControls.htm#ListBoxMulti), the output uses the window's [current delimiter](Gui.htm#Delimiter).

[ListView](ListView.htm) and [TreeView](TreeView.htm): These are not supported when _SubCommand_ is blank. Instead, use the built-in [ListView functions](ListView.htm#BuiltIn) and [TreeView functions](TreeView.htm#BuiltIn).

[StatusBar](GuiControls.htm#StatusBar): Retrieves only the first part's text.

[ActiveX](GuiControls.htm#ActiveX): Retrieves a new wrapper object for the control's ActiveX component.

**Note**: To unconditionally retrieve the text/caption of a CheckBox, Radio, DropDownList or ComboBox rather than its contents, specify the word Text for _Value_.

### Pos

Retrieves the position and size of the control.

```
<span class="func">GuiControlGet</span>, OutputVar, Pos <span class="optional">, ControlID</span>
```

The position is relative to the GUI window's client area, which is the area not including title bar, menu bar, and borders. The information is stored in four variables whose names all start with _OutputVar_. For example:

```
GuiControlGet, MyEdit, Pos
MsgBox The X coordinate is %MyEditX%. The Y coordinate is %MyEditY%. The width is %MyEditW%. The height is %MyEditH%.
```

Within a [function](../Functions.htm), to create a set of variables that is global instead of local, [declare](../Functions.htm#Global) _OutputVar_ as a global variable prior to using this command (the converse is true for [assume-global](../Functions.htm#AssumeGlobal) functions). However, it is often also necessary to declare each variable in the set, due to a [common source of confusion](../Functions.htm#ArrayConfusion).

### Focus

Retrieves the control identifier (ClassNN) for the control that currently has keyboard focus.

```
<span class="func">GuiControlGet</span>, OutputVar, Focus <span class="optional">, ControlID</span>
```

Since the specified GUI window must be [active](WinActivate.htm) for one of its controls to have focus, _OutputVar_ will be made blank if it is not active. Example usage: `GuiControlGet, focused_control, Focus`.

### FocusV [v1.0.43.06+]

Retrieves the name of the focused control's [associated variable](Gui.htm#Events).

```
<span class="func">GuiControlGet</span>, OutputVar, FocusV <span class="optional">, ControlID</span>
```

See the [Focus](#Focus) sub-command (above) for details. If that control lacks an associated variable, the first 63 characters of the control's text/caption is retrieved instead (this is most often used to avoid giving each button a variable name).

### Enabled

Retrieves 1 if the control is enabled or 0 if it is disabled.

```
<span class="func">GuiControlGet</span>, OutputVar, Enabled <span class="optional">, ControlID</span>
```

### Visible

Retrieves 1 if the control is visible or 0 if it is hidden.

```
<span class="func">GuiControlGet</span>, OutputVar, Visible <span class="optional">, ControlID</span>
```

### Hwnd [v1.0.46.16+]

Retrieves the window handle (HWND) of the control.

```
<span class="func">GuiControlGet</span>, OutputVar, Hwnd <span class="optional">, ControlID</span>
```

A control's HWND is often used with [PostMessage](PostMessage.htm), [SendMessage](PostMessage.htm), and [DllCall()](DllCall.htm). Note: [HwndOutputVar](Gui.htm#HwndOutputVar) is usually a more concise way to get the HWND.

### Name [v1.1.03+]

Retrieves the name of the control's [associated variable](Gui.htm#Events).

```
<span class="func">GuiControlGet</span>, OutputVar, Name <span class="optional">, ControlID</span>
```

If it doesn't have one, _OutputVar_ is made blank.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if the specified window/control does not exist or some other problem prevented the command from working. Otherwise, it is set to 0.

## Remarks

To operate upon a window other than the default (see below), include its name or number followed by a colon in front of the sub-command as in these examples:

```
GuiControlGet, MyEdit, MyGui:
GuiControlGet, MyEdit, MyGui:Pos
GuiControlGet, OutputVar, MyGui:Focus
```

This is required even if _ControlID_ is a control's associated variable, since any one variable can be used on multiple GUI windows. In [v1.1.20+], the GUI name can be omitted if _ControlID_ is a control's HWND.

A GUI [thread](../misc/Threads.htm) is defined as any thread launched as a result of a GUI action. GUI actions include selecting an item from a GUI window's menu bar, or triggering one of its [g-labels](Gui.htm#label) (such as by pressing a button).

The [default window name](Gui.htm#DefaultWin) for a GUI thread is that of the window that launched the thread. Non-GUI threads use 1 as their default.

## Related

[Gui](Gui.htm), [GuiControl](GuiControl.htm), [ControlGet](ControlGet.htm)

## Examples

Retrieves the text of an Edit control and stores it in MyEdit.

```
GuiControlGet, MyEdit
```

Same as above but stores the text in CtrlContents.

```
GuiControlGet, CtrlContents,, MyEdit
```

Retrieves 1 if a checkbox is checked or 0 if it is unchecked.

```
GuiControlGet, MyCheckbox1
```

Retrieves the caption/text of a checkbox.

```
GuiControlGet, MyCheckbox1,,, Text
```

Stores the position and size in PicX, PicY, PicW, and PicH.

```
GuiControlGet, Pic, Pos, Static4
```

