# [GUI](Gui.htm) Control Types

## Table of Contents

- [Text](#Text), [Edit](#Edit), [UpDown](#UpDown), [Picture](#Picture)
- [Button](#Button), [Checkbox](#Checkbox), [Radio](#Radio)
- [DropDownList](#DropDownList), [ComboBox](#ComboBox)
- [ListBox](#ListBox), [ListView](ListView.htm), [TreeView](TreeView.htm)
- [Link](#Link), [Hotkey](#Hotkey), [DateTime](#DateTime)
- [MonthCal](#MonthCal), [Slider](#Slider), [Progress](#Progress)
- [GroupBox](#GroupBox), [Tab3](#Tab), [StatusBar](#StatusBar)
- [ActiveX](#ActiveX) (e.g. Internet Explorer Control)
- [Custom](#Custom)

## Text

Description: A region containing borderless text that the user cannot edit. Often used to label other controls.

For example:

```
Gui, Add, Text,, Please enter your name:
```

Appearance:

![Text](../static/ctrl_text.png)

In this case, the last parameter is the string to display. It may contain linefeeds (\`n) to start new lines. In addition, a single long line can be broken up into several shorter ones by means of a [continuation section](../Scripts.htm#continuation).

If a width (W) is specified in _Options_ but no [rows (R)](Gui.htm#R) or height (H), the text will be word-wrapped as needed, and the control's height will be set automatically.

Since the control's contents are in the last parameter of the Gui command, literal commas do not need to be escaped. This is also true for the last parameter of all other commands.

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user clicks the text. This can be used to simulate an underlined, blue hyperlink as shown in the following working script:

```
Gui, Font, underline
Gui, Add, Text, cBlue gLaunchGoogle, Click here to launch Google.

<em>; Alternatively, Link controls can be used:</em>
Gui, Add, Link,, Click <a href="www.google.com">here</a> to launch Google.
Gui, Font, norm
Gui, Show
return

LaunchGoogle:
Run www.google.com
return
```

A double-click can be detected by checking whether [A\_GuiEvent](../Variables.htm#GuiEvent) contains the word DoubleClick.

An ampersand (&) may be used in the text to underline one of its letters. For example:

```
Gui, Add, Text,, &First Name:
Gui, Add, Edit
```

In the example above, the letter F will be underlined, which allows the user to press the [shortcut key](Gui.htm#ShortcutKey) Alt+F to set keyboard focus to the first input-capable control that was added after the text control. To instead display a literal ampersand, specify two consecutive ampersands (&&). To disable all special treatment of ampersands, include [0x80](../misc/Styles.htm#SS_NOPREFIX) in the control's options.

See [general options](Gui.htm#OtherOptions) for other options like _Right_, _Center_, and _Hidden_. See also: [position and sizing of controls](Gui.htm#PosSize).

## Edit

Description: An area where free-form text can be typed by the user.

For example:

```
Gui, Add, Edit, r9 vMyEdit w135, Text to appear inside the edit control (omit this parameter to start off empty).
```

Appearance:

![Edit](../static/ctrl_edit.png)

The control will be multi-line if it has more than one row of text. For example, specifying `r3` in _Options_ will create a 3-line edit control with the following default properties: a vertical scroll bar, word-wrapping enabled, and Enter captured as part of the input rather than triggering the window's [default button](#DefaultButton).

To start a new line in a multi-line edit control, the last parameter (contents) may contain either a solitary linefeed (\`n) or a carriage return and linefeed (\`r\`n). Both methods produce literal \`r\`n pairs inside the Edit control. However, when the control is saved to its variable via [Gui Submit](Gui.htm#Submit) or [GuiControlGet](GuiControlGet.htm), each \`r\`n in the text is always translated to a plain linefeed (\`n). To write the text to a file, follow this example: `<a href="FileAppend.htm" data-index="36">FileAppend</a>, %MyEdit%, C:\Saved File.txt`.

If the control has word-wrapping enabled (which is the default for multi-line edit controls), any wrapping that occurs as the user types will not produce linefeed characters (only Enter can do that).

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user or the script changes the contents of the control.

TIP: To load a text file into an Edit control, use [FileRead](FileRead.htm) and [GuiControl](GuiControl.htm). For example:

```
Gui, Add, Edit, R20 vMyEdit
FileRead, FileContents, C:\My File.txt
GuiControl,, MyEdit, %FileContents%
```

### Edit Options

To remove an option rather than adding it, precede it with a minus sign:

**Limit**: Restricts the user's input to the visible width of the edit field. Alternatively, to limit input to a specific number of characters, include a number immediately afterward. For example, `Limit10` would allow no more than 10 characters to be entered.

**Lowercase**: The characters typed by the user are automatically converted to lowercase.

**Multi**: Makes it possible to have more than one line of text. However, it is usually not necessary to specify this because it will be auto-detected based on height (H), [rows (R)](Gui.htm#R), or contents ( _Text_).

**Number**: Prevents the user from typing anything other than digits into the field (however, it is still possible to paste non-digits into it). An alternate way of forcing a numeric entry is to attach an [UpDown](#UpDown) control to the Edit.

**Password**: Hides the user's input (such as for password entry) by substituting masking characters for what the user types. If a non-default masking character is desired, include it immediately after the word Password. For example, `Password*` would make the masking character an asterisk rather than the black circle (bullet), which is the default on Windows XP. Note: This option has no effect for multi-line edit controls.

**ReadOnly**: Prevents the user from changing the control's contents. However, the text can still be scrolled, selected and copied to the clipboard.

**Tn**: The letter T may be used to set tab stops inside a [multi-line edit control](#EditMulti) (since tab stops determine the column positions to which literal TAB characters will jump, they can be used to format the text into columns). If the letter T is not used, tab stops are set at every 32 dialog units (the width of each "dialog unit" is determined by the operating system). If the letter T is used only once, tab stops are set at every **n** units across the entire width of the control. For example, `Gui, Add, Edit, vMyEdit r16 t64` would double the default distance between tab stops. To have custom tab stops, specify the letter T multiple times as in the following example: `Gui, Add, Edit, vMyEdit r16 t8 t16 t32 t64 t128`. One tab stop is set for each of the absolute column positions in the list, up to a maximum of 50 tab stops. Note: Tab stops require a multiline edit control.

**Uppercase**: The characters typed by the user are automatically converted to uppercase.

**WantCtrlA**[v1.0.44+]: Specify `-WantCtrlA` (minus WantCtrlA) to prevent the user's press of Ctrl+A from selecting all text in the edit control.

**WantReturn**: Specify `-WantReturn` (minus WantReturn) to prevent a multi-line edit control from capturing Enter. Pressing Enter will then be the same as pressing the window's [default button](#DefaultButton) (if any). In this case, the user may press Ctrl+Enter to start a new line.

**WantTab**: Causes Tab to produce a tab character rather than navigating to the next control. Without this option, the user may press Ctrl+Tab to produce a tab character inside a multi-line edit control. Note: _WantTab_ also works in a single-line edit control, but in Windows XP and lower each tab character is displayed as an empty-box character (though it is stored as a real tab).

**Wrap**: Specify `-Wrap` (minus Wrap) to turn off word-wrapping in a multi-line edit control. Since this style cannot be changed after the control has been created, use one of the following to change it: 1) [Destroy](Gui.htm#Destroy) then recreate the window and its control; or 2) Create two overlapping edit controls, one with wrapping enabled and the other without it. The one not currently in use can be kept empty and/or hidden.

See [general options](Gui.htm#OtherOptions) for other options like _Right_, _Center_, and _Hidden_. See also: [position and sizing of controls](Gui.htm#PosSize).

**A more powerful edit control**: HiEdit is a free, multitabbed, large-file edit control consuming very little memory. It can edit both text and binary files. For details and a demonstration, see [HiEdit on GitHub](https://github.com/majkinetor/mm-autohotkey/tree/master/HiEdit).

## UpDown

Description: A pair of arrow buttons that the user can click to increase or decrease a value. By default, an UpDown control automatically snaps onto the previously added control. This previous control is known as the UpDown's _buddy control_. The most common example is a "spinner", which is an UpDown attached to an [Edit control](#Edit).

For example:

```
Gui, Add, Edit
Gui, Add, UpDown, vMyUpDown Range1-10, 5
```

Appearance:

![UpDown](../static/ctrl_updown.png)

In the example above, the Edit control is the UpDown's buddy control. Whenever the user presses one of the arrow buttons, the number in the Edit control is automatically increased or decreased.

An UpDown's buddy control can also be a [Text control](#Text) or [ListBox](#ListBox). However, due to OS limitations, controls other than these (such as ComboBox and DropDownList) might not work properly with [g-labels](Gui.htm#label) and other features.

Specify the UpDown's starting position as the last parameter (if omitted, it starts off at 0 or the number in the allowable range that is closest to 0).

When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the current numeric position of the UpDown. If the UpDown is attached to an Edit control and you do not wish to validate the user's input, it is best to use the UpDown's value rather than the Edit's. This is because the UpDown will always yield an in-range number, even when the user has typed something non-numeric or out-of-range in the Edit control. On a related note, numbers with more than three digits get a [thousands separator](../misc/Styles.htm#UpDownSep) (such as comma) by default. These separators are stored in the Edit's output variable but not that of the UpDown.

If the UpDown has a [g-label](Gui.htm#label), it will be launched whenever the user clicks one of the arrow buttons or presses an arrow key on the keyboard. Each launch of the g-label also stores the UpDown's position in its [associated output variable](Gui.htm#var) (if any).

### UpDown Options

**Horz**: Make's the control's buttons point left/right rather than up/down. By default, _Horz_ also makes the control isolated (no buddy). This can be overridden by specifying `Horz 16` in the control's options.

**Left**: Puts the UpDown on the left side of its buddy rather than the right.

**Range**: Sets the range to be something other than 0 to 100. After the word Range, specify the minimum, a dash, and maximum. For example, `Range1-1000` would allow a number between 1 and 1000 to be selected; `Range-50-50` would allow a number between -50 and 50; and `Range-10--5` would allow a number between -10 and -5. The minimum and maximum may be swapped to cause the arrows to move in the opposite of their normal direction. The broadest allowable range is -2147483648-2147483647. Finally, if the buddy control is a [ListBox](#ListBox), the range defaults to 32767-0 for verticals and the inverse for horizontals ( [Horz](#Horz)).

**Wrap**: Causes the control to wrap around to the other end of its range when the user attempts to go beyond the minimum or maximum. Without _Wrap_, the control stops when the minimum or maximum is reached.

**16**: Specify -16 (minus 16) to cause a vertical UpDown to be isolated; that is, it will have no buddy. This also causes the control to obey any specified width, height, and position rather than conforming to the size of its buddy control. In addition, an isolated UpDown tracks its own position internally. This position can be retrieved normally by means such as [Gui Submit](Gui.htm#Submit).

**0x80**: Include `0x80` in _Options_ to omit the thousands separator that is normally present between every three decimal digits in the buddy control. However, this style is normally not used because the separators are omitted from the number whenever the script retrieves it from the UpDown control itself (rather than its buddy control).

**Increments other than 1**: In [this script](http://numeric.nerim.net/AutoHotkey/Scripts/UpDown%20-%20Non-unitary%20increments.ahk), NumEric demonstrates how to change an UpDown's increment to a value other than 1 (such as 5 or 0.1).

**Hexadecimal number format**: The number format displayed inside the buddy control may be changed from decimal to hexadecimal by following this example:

```
Gui +LastFound
SendMessage, 0x046D, 16, 0, msctls_updown321 <em>; 0x046D is UDM_SETBASE</em>
```

However, this affects only the buddy control, not the UpDown's reported position.

See also: [position and sizing of controls](Gui.htm#PosSize).

## Picture (or Pic)

Description: An area containing an image (see last two paragraphs for supported file types). The last parameter is the filename of the image, which is assumed to be in [A\_WorkingDir](../Variables.htm#WorkingDir) if an absolute path isn't specified.

For example:

```
Gui, Add, Picture, w300 h-1, C:\My Pictures\Company Logo.gif
```

To retain the image's actual width and/or height, omit the W and/or H options. Otherwise, the image is scaled to the specified width and/or height (this width and height also determines which icon to load from a multi-icon .ICO file). To shrink or enlarge the image while preserving its aspect ratio, specify -1 for one of the dimensions and a positive number for the other. For example, specifying `w200 h-1` would make the image 200 pixels wide and cause its height to be set automatically. If the picture cannot be loaded or displayed (e.g. file not found), the control is left empty and its width and height are set to zero.

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user clicks the picture. A double-click can be detected by checking whether [A\_GuiEvent](../Variables.htm#GuiEvent) contains the word DoubleClick.

To use a picture as a background for other controls, the picture should normally be added prior to those controls. However, if those controls are input-capable and the picture has a [g-label](Gui.htm#label), create the picture after the other controls and include `0x4000000` (which is WS\_CLIPSIBLINGS) in the picture's _Options_. This trick also allows a picture to be the background behind a [Tab control](#Tab) or [ListView](ListView.htm).

**Icons, cursors, and animated cursors**: Icons and cursors may be loaded from the following types of files: ICO, CUR, ANI, EXE, DLL, CPL, SCR, and other types that contain icon resources. To use an icon group other than the first one in the file, include in _Options_ the word Icon followed by the number of the group. In the following example, the default icon from the second icon group would be used: `Gui, Add, Picture, Icon2, C:\My Application.exe`.

Specifying the word AltSubmit in _Options_ tells the program to use Microsoft's GDIPlus.dll to load the image, which might result in a different appearance for GIF, BMP, and icon images. For example, it would load an ICO/GIF that has a transparent background as a transparent bitmap, which allows the [BackgroundTrans](Gui.htm#BackgroundTrans) option to take effect (but in [v1.1.23+], icons support transparency without AltSubmit). If GDIPlus is not available (see next paragraph), AltSubmit is ignored and the image is loaded using the normal method.

All operating systems support GIF, JPG, BMP, ICO, CUR, and ANI images. On Windows XP or later, additional image formats such as PNG, TIF, Exif, WMF, and EMF are supported. Operating systems older than XP can be given support by copying Microsoft's free GDI+ DLL into the AutoHotkey.exe folder (but in the case of a [compiled script](../Scripts.htm#ahk2exe), copy the DLL into the script's folder). To download the DLL, search for the following phrase at [www.microsoft.com](https://www.microsoft.com): gdi redistributable

**Animated GIFs**: Although animated GIF files can be displayed in a picture control, they will not actually be animated. To solve this, use the AniGIF DLL (which is free for non-commercial use) as demonstrated at the [AutoHotkey Forums](https://www.autohotkey.com/boards/viewtopic.php?t=6457). [v1.1.03+]: Alternatively, the [ActiveX](#ActiveX) control type can be used. For example:

```
<em>; Specify below the path to the GIF file to animate (local files are allowed too):</em>
pic := "http://www.animatedgif.net/cartoons/A_5odie_e0.gif"
Gui, Add, ActiveX, w100 h150, % "mshtml:<img src='" pic "' />"
Gui, Show
```

[v1.1.23+]: A [bitmap or icon handle](../misc/ImageHandles.htm) can be used instead of a filename. For example, `HBITMAP:%handle%`.

## Button

Description: A pushbutton, which can be pressed to trigger an action. In this case, the last parameter is the name of the button (shown on the button itself), which may include linefeeds (\`n) to start new lines.

For example:

```
Gui, Add, Button, Default w80, OK
```

Appearance:

![Button](../static/ctrl_button.png)

The example above includes the word **Default** in its _Options_ to make "OK" the default button. The default button's action is automatically triggered whenever the user presses Enter, except when the keyboard focus is on a different button or a multi-line edit control having the [WantReturn](#WantReturn) style. To later change the default button to another button, follow this example, which makes the Cancel button become the default: `<a href="GuiControl.htm" data-index="75">GuiControl</a>, +Default, Cancel`. To later change the window to have no default button, follow this example: `GuiControl, -Default, OK`.

An ampersand (&) may be used in the button name to underline one of its letters. For example:

```
Gui, Add, Button,, &Pause
```

In the example above, the letter P will be underlined, which allows the user to press Alt+P as [shortcut key](Gui.htm#ShortcutKey). To display a literal ampersand, specify two consecutive ampersands (&&).

If a button lacks an explicit [g-label](Gui.htm#label), an automatic label is assumed. For example, if the first GUI window contains an OK button, the ButtonOK label (if it exists) will be launched when the button is pressed. For GUI windows [other than the first](Gui.htm#MultiWin), the window number is included in front of the button's automatic label; for example: `2ButtonOK`.

If the text on the button contains spaces or any of the characters in the set **&\`r\`n\`t\`**, its automatic label omits those characters. For example, a button titled "&Pause" would have an automatic label of ButtonPause. Similarly, a button titled "Save && Exit" would have an automatic label of ButtonSaveExit (the double-ampersand is used to display a single, literal ampersand).

Known limitation: Certain desktop themes might not display a button's text properly. If this occurs, try including `-Wrap` (minus Wrap) in the control's options. However, this also prevents having more than one line of text.

## Checkbox

Description: A small box that can be checked or unchecked to represent On/Off, Yes/No, etc.

For example:

```
Gui, Add, CheckBox, vShipToBillingAddress, Ship to billing address?
```

Appearance:

![Checkbox](../static/ctrl_check.png)

The last parameter is a label displayed next to the box, which is typically used as a prompt or description of what the checkbox does. It may include linefeeds (\`n) to start new lines. If a width (W) is specified in _Options_ but no [rows (R)](Gui.htm#R) or height (H), the control's text will be word-wrapped as needed, and the control's height will be set automatically. The checkbox's [associated output variable](Gui.htm#var) (if any) receives the number 1 for checked, 0 for unchecked, and -1 for gray/indeterminate.

Specify the word **Check3** in _Options_ to enable a third state that displays a gray checkmark instead of a black one (the gray state indicates that the checkbox is neither checked nor unchecked). Specify the word **Checked** or **CheckedGray** in _Options_ to have the checkbox start off with a black or gray checkmark, respectively. The word Checked may optionally be followed immediately by a 0, 1, or -1 to indicate the starting state. In other words, `Checked` and `Checked%VarContainingOne%` are the same.

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user clicks or changes the checkbox.

Known limitation: Certain desktop themes might not display a checkbox's text properly. If this occurs, try including `-Wrap` (minus Wrap) in the control's options. However, this also prevents having more than one line of text.

## Radio

Description: A radio button is a small empty circle that can be checked (on) or unchecked (off).

For example:

```
Gui, Add, Radio, vMyRadioGroup, Wait for all items to be in stock before shipping.
```

Appearance:

![Radio](../static/ctrl_radio.png)

These controls usually appear in _radio groups_, each of which contains two or more radio buttons. When the user clicks a radio button to turn it on, any others in its radio group are turned off automatically (the user may also navigate inside a group with the arrow keys). A radio group is created automatically around all consecutively added radio buttons. To start a new group, specify the word **Group** in the _Options_ of the first button of the new group -- or simply add a non-radio control in between, since that automatically starts a new group.

For the last parameter, specify the label to display to the right of the radio button. This label is typically used as a prompt or description, and it may include linefeeds (\`n) to start new lines. If a width (W) is specified in _Options_ but no rows (R) or height (H), the control's text will be word-wrapped as needed, and the control's height will be set automatically.

Specify the word **Checked** in _Options_ to have the button start off in the "on" state. The word Checked may optionally be followed immediately by a 0 or 1 to indicate the starting state: 0 for unchecked and 1 for checked. In other words, `Checked` and `Checked%VarContainingOne%` are the same.

The radio button's [associated output variable](Gui.htm#var) (if any) receives the number 1 for "on" and 0 for "off". However, if only one button in a radio group has a variable, that variable will instead receive the number of the currently selected button: 1 is the first radio button (according to original creation order), 2 is the second, and so on. If there is no button selected, 0 is stored.

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user turns on the button. Unlike the single-variable mode in the previous paragraph, the g-label must be specified for each button in a radio group for which the label should be launched. This allows the flexibility to ignore the clicks of certain buttons. Finally, a double-click can be detected by checking whether [A\_GuiEvent](../Variables.htm#GuiEvent) contains the word DoubleClick.

Known limitation: Certain desktop themes might not display a radio button's text properly. If this occurs, try including `-Wrap` (minus Wrap) in the control's options. However, this also prevents having more than one line of text.

## DropDownList (or DDL)

Description: A list of choices that is displayed in response to pressing a small button. In this case, the last parameter is a pipe-delimited list of choices such as `Choice1|Choice2|Choice3`.

For example:

```
Gui, Add, DropDownList, vColorChoice, Black|White|Red|Green|Blue
```

Appearance:

![DDL](../static/ctrl_ddl.png)

To have one of the items pre-selected when the window first appears, include two pipe characters after it (e.g. `Red|Green||Blue`). Alternatively, include in _Options_ the word **Choose** followed immediately by the number of an item to be pre-selected. For example, `Choose5` would pre-select the fifth item (as with other options, it can also be a variable such as `Choose%Var%`). To change the choice or add/remove entries from the list after the control has been created, use [GuiControl](GuiControl.htm).

Specify either the word **Uppercase** or **Lowercase** in _Options_ to automatically convert all items in the list to uppercase or lowercase. Specify the word **Sort** to automatically sort the contents of the list alphabetically (this also affects any items added later via [GuiControl](GuiControl.htm)). The Sort option also enables incremental searching whenever the list is dropped down; this allows an item to be selected by typing the first few characters of its name.

When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the text of the currently selected item. However, if the control has the [AltSubmit](Gui.htm#AltSubmit) property, the output variable will receive the item's position number instead (the first item is 1, the second is 2, etc.).

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user selects a new item.

Use the [R or H option](Gui.htm#R) to control the height of the popup list. For example, specifying `R5` would make the list 5 rows tall, while `H400` would set the total height of the selection field and list to 400 pixels. If both R and H are omitted, the list will automatically expand to take advantage of the available height of the user's desktop (however, operating systems older than Windows XP will show 3 rows by default).

To set the height of the selection field or list items, use the [CB\_SETITEMHEIGHT](http://msdn.microsoft.com/en-us/library/windows/desktop/bb775911) message as in the example below:

```
Gui Add, DDL, vcbx w200 hwndhcbx, One||Two
<em>; CB_SETITEMHEIGHT = 0x0153</em>
PostMessage, 0x0153, -1, 50,, ahk_id %hcbx%  <em>; Set height of selection field.</em>
PostMessage, 0x0153,  0, 50,, ahk_id %hcbx%  <em>; Set height of list items.</em>
Gui Show, h70, Test
```

The separator between fields may be changed to something other than pipe (\|). For example ``Gui +<a href="Gui.htm#Delimiter" data-index="93">Delimiter</a>`n`` would change it to linefeed and `Gui +DelimiterTab` would change it to tab (\`t).

## ComboBox

Description: Same as DropDownList but also permits free-form text to be entered as an alternative to picking an item from the list.

For example:

```
Gui, Add, ComboBox, vColorChoice, Red|Green|Blue|Black|White
```

Appearance:

![ComboBox](../static/ctrl_combo.png)

In addition to allowing all the same options as DropDownList above, the word **Limit** may be included in _Options_ to restrict the user's input to the visible width of the ComboBox's edit field. Also, the word **Simple** may be specified to make the ComboBox behave as though it is an Edit field with a ListBox beneath it.

When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the text of the currently selected item. However, if the control has the [AltSubmit](Gui.htm#AltSubmit) property, the output variable will receive the item's position number instead (the first item is 1, the second is 2, etc.). If either case, if there is no selected item, the output variable will be set to the contents of the ComboBox's edit field.

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user selects a new item.

## ListBox

Description: A relatively tall box containing a list of choices that can be selected. In this case, the last parameter is a pipe-delimited list of choices such as `Choice1|Choice2|Choice3`.

For example:

```
Gui, Add, ListBox, r5 vColorChoice, Red|Green|Blue|Black|White
```

Appearance:

![ListBox](../static/ctrl_list.png)

To have list item(s) pre-selected when the window first appears, include two pipe characters after each (the [Multi](#ListBoxMulti) option is required if more than one item is to be pre-selected). Alternatively, include in _Options_ the word **Choose** followed immediately by the number of an item to be pre-selected. For example, `Choose5` would pre-select the fifth item. To change the choice or add/remove entries from the list after the control has been created, use [GuiControl](GuiControl.htm).

When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the text of the currently selected item. However, if the control has the [AltSubmit](Gui.htm#AltSubmit) property, the output variable instead receives the item's position number (the first item is 1, the second is 2, etc.).

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user selects a new item. If the user double-clicks an item, the built-in variable A\_GuiEvent will contain the string DoubleClick rather than Normal. Also, the variable A\_EventInfo will contain the position of the item that was double-clicked (1 is the first item, 2 is the second, etc.).

When adding a large number of items to a ListBox, performance may be improved by using `GuiControl, -Redraw, MyListBox` prior to the operation, and `GuiControl, +Redraw, MyListBox` afterward.

### ListBox Options

**Choose**: See [above](#ChooseLB).

**Multi**: Allows more than one item to be selected simultaneously via shift-click and control-click (to avoid the need for shift/control-click, specify [the number 8](../misc/Styles.htm#LBS_MULTIPLESEL) instead of the word Multi). In this case, [Gui Submit](Gui.htm#Submit) stores a pipe-delimited list of item strings in the control's [output variable](Gui.htm#var). However, if the [AltSubmit](Gui.htm#AltSubmit) option is in effect, [Gui Submit](Gui.htm#Submit) stores a pipe-delimited list of item numbers instead. For example, `1|2|3` would indicate that the first three items are selected. To extract the individual items from the string, use a [parsing loop](LoopParse.htm) such as this example:

```
Loop, Parse, MyListBox, |
{
    MsgBox Selection number %A_Index% is %A_LoopField%.
}
```

The separator between fields may be changed to something other than pipe (\|). For example ``Gui +<a href="Gui.htm#Delimiter" data-index="111">Delimiter</a>`n`` would change it to linefeed and `Gui +DelimiterTab` would change it to tab (\`t).

**ReadOnly**: Prevents items from being visibly highlighted when they are selected (but [Gui Submit](Gui.htm#Submit) will still store the selected item).

**Sort**: Automatically sorts the contents of the list alphabetically (this also affects any items added later via [GuiControl](GuiControl.htm)). The Sort option also enables incremental searching, which allows an item to be selected by typing the first few characters of its name.

**Tn**: The letter T may be used to set tab stops, which can be used to format the text into columns. If the letter T is not used, tab stops are set at every 32 dialog units (the width of each "dialog unit" is determined by the operating system). If the letter T is used only once, tab stops are set at every **n** units across the entire width of the control. For example, `Gui, Add, ListBox, vMyListBox t64` would double the default distance between tab stops. To have custom tab stops, specify the letter T multiple times as in the following example: `Gui, Add, ListBox, vMyListBox t8 t16 t32 t64 t128`. One tab stop is set for each of the absolute column positions in the list, up to a maximum of 50 tab stops.

**0x100**: Include 0x100 in _Options_ to turn on the LBS\_NOINTEGRALHEIGHT style. This forces the ListBox to be exactly the height specified rather than a height that prevents a partial row from appearing at the bottom. This option also prevents the ListBox from shrinking when its font is changed.

To specify the number of rows of text (or the height and width), see [position and sizing of controls](Gui.htm#PosSize).

## ListView and TreeView

See separate pages [ListView](ListView.htm) and [TreeView](TreeView.htm).

## Link [v1.1.06+]

Description: A text control that can contain links that can be clicked. Link controls use HTML-like markup language, but they only support the <A> tag. Inside the opening tag, an attribute of the form `href="value"` or `id="value"` may be specified.

For example:

```
Gui, Add, Link,, This is a <a href="https://www.autohotkey.com">link</a>
Gui, Add, Link,, Links may be used anywhere in the text like <a id="A">this</a> or <a id="B">that</a>
```

Appearance:

![Link](../static/ctrl_link.png)

If the HREF attribute is set and contains a valid executable command or URL, it is executed as if passed to the [Run](Run.htm) command. However, an executable command cannot contain double-quote marks. A URL can usually contain percent-encoded characters such as `` `%22``, but these are interpreted by the user's web browser, not the Link control.

If the control has a [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine`, the subroutine is launched whenever a link without a HREF attribute is clicked, or if the command or URL failed to execute. This subroutine may consult the following variables:

- A\_GuiEvent contains the type of event; currently always the word "Normal".
- A\_EventInfo contains the 1-based index of the link.
- ErrorLevel contains the value of the link's HREF attribute, if any; otherwise, the value of the link's ID attribute or an empty string.

If the g-label is a function, it can accept the following parameters:

```
<span class="func">MyFunction</span>(CtrlHwnd, GuiEvent, LinkIndex, HrefOrID)
```

## Hotkey

Description: A box that looks like a single-line edit control but instead accepts a keyboard combination pressed by the user. For example, if the user presses Ctrl+Alt+C on an English keyboard layout, the box would display "Ctrl + Alt + C".

For example:

```
Gui, Add, Hotkey, vChosenHotkey
```

Appearance:

![Hotkey](../static/ctrl_hotkey.png)

When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the hotkey modifiers and name, which are compatible with the [Hotkey](Hotkey.htm) command. Examples: `^!C`, `+!Home`, `+^Down`, `^Numpad1`, `!NumpadEnd`. If there is no hotkey in the control, the output variable is made blank.

**Note**: Some keys are displayed the same even though they are retrieved as different names. For example, both `^Numpad7` and `^NumpadHome` might be displayed as Ctrl + Num 7.

By default, the control starts off with no hotkey specified. To instead have a default, specify its modifiers and name as the last parameter as in this example: `Gui, Add, Hotkey, vChosenHotkey, ^!p`. The only modifiers supported are ^ (Control), ! (Alt), and + (Shift). See the [key list](../KeyList.htm) for available key names.

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user changes the hotkey. Each launch of the g-label also stores the hotkey in control's [associated output variable](Gui.htm#var) (if any).

**Note**: The g-label is launched even when an incomplete hotkey is present. For example, if the user holds down Ctrl, the g-label is launched once and the output variable contains only a circumflex (^). When the user completes the hotkey, the label is launched again and the variable contains the complete hotkey.

To restrict the types of hotkeys the user may enter, include the word **Limit** followed by the sum of one or more of the following numbers:

- 1: Prevent unmodified keys
- 2: PreventShift-only keys
- 4: PreventCtrl-only keys
- 8: PreventAlt-only keys
- 16: PreventShift+Ctrl keys
- 32: PreventShift+Alt keys
- 64: This value is not supported (it will not behave correctly)
- 128: PreventShift+Ctrl+Alt keys

For example, `Limit1` would prevent unmodified hotkeys such as letters and numbers from being entered, and `Limit15` would require at least two modifier keys. If the user types a forbidden modifier combination, the Ctrl+Alt combination is automatically and visibly substituted.

The Hotkey control has limited capabilities. For example, it does not support mouse/joystick hotkeys or Win (LWin and RWin). One way to work around this is to provide one or more [checkboxes](#Checkbox) as a means for the user to enable extra modifiers such as Win.

## DateTime

Description: A box that looks like a single-line edit control but instead accepts a date and/or time. A drop-down calendar is also provided.

For example:

```
Gui, Add, DateTime, vMyDateTime, LongDate
```

Appearance:

![DateTime](../static/ctrl_datetime.png)

The last parameter may be one of the following:

**(omitted)**: When omitted, the locale's short date format is used. For example, in some locales it would look like: 6/1/2005

**LongDate**: Uses the locale's long date format. For example, in some locales it would look like: Wednesday, June 01, 2005

**Time**: Shows only the time using the locale's time format. Although the date is not shown, it is still present in the control and will be retrieved along with the time in the [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format. For example, in some locales it would look like: 9:37:45 PM

**(custom format)**: Specify any combination of [date and time formats](FormatTime.htm). For example, `M/d/yy HH:mm` would look like 6/1/05 21:37. Similarly, `dddd MMMM d, yyyy hh:mm:ss tt` would look like Wednesday June 1, 2005 09:37:45 PM. Letters and numbers to be displayed literally should be enclosed in single quotes as in this example: `'Date:' MM/dd/yy 'Time:' hh:mm:ss tt`. By contrast, non-alphanumeric characters such as spaces, tabs, slashes, colons, commas, and other punctuation do not need to be enclosed in single quotes. The exception to this is the single quote character itself: to produce it literally, use four consecutive single quotes (''''), or just two if the quote is already inside an outer pair of quotes.

### DateTime Usage

To have a date other than today pre-selected, include in _Options_ the word **Choose** followed immediately by a date in YYYYMMDD format. For example, `Choose20050531` would pre-select May 31, 2005 (as with other options, it can also be a variable such as `Choose%Var%`). To have no date/time selected, specify **ChooseNone**. _ChooseNone_ also creates a checkbox inside the control that is unchecked whenever the control has no date. Whenever the control has no date, [Gui Submit](Gui.htm#Submit) and [GuiControlGet](GuiControlGet.htm) will retrieve a blank value (empty string).

The time of day may optionally be present. However, it must always be preceded by a date when going into or coming out of the control. The format of the time portion is HH24MISS (hours, minutes, seconds), where HH24 is expressed in 24-hour format; for example, 09 is 9am and 21 is 9pm. Thus, a complete date-time string would have the format [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD).

When specifying dates in the YYYYMMDDHH24MISS format, only the leading part needs to be present. Any remaining element that has been omitted will be supplied with the following default values: MM with month 01, DD with day 01, HH24 with hour 00, MI with minute 00 and SS with second 00.

Within the drop-down calendar, the today-string at the bottom can be clicked to select today's date. In addition, the year and month name are clickable and allow easy navigation to a new month or year.

Keyboard navigation: Use the ↑/↓ arrow keys, the +/- numpad keys, and Home/End to increase or decrease the control's values. Use ← and → to move from field to field inside the control. Within the drop-down calendar, use the arrow keys to move from day to day; use PgUp/PgDn to move backward/forward by one month; use Ctrl+PgUp/PgDn to move backward/forward by one year (only supported on Win XP and earlier); and use Home/End to select the first/last day of the month.

When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the selected date and time in [YYYYMMDDHH24MISS](FileSetTime.htm#YYYYMMDD) format. Both the date and the time are present regardless of whether they were actually visible in the control.

If the control has a [g-label](Gui.htm#label), the label is launched whenever the user changes the date or time. For each launch, the control's [associated output variable](Gui.htm#var) (if any) is automatically updated with the currently selected date/time.

### DateTime Options

**Choose**: See [above](#ChooseDT).

**Range**: Restricts how far back or forward in time the selected date can be. After the word Range, specify the minimum and maximum dates in YYYYMMDD format (with a dash between them). For example, `Range20050101-20050615` would restrict the date to the first 5.5 months of 2005. Either the minimum or maximum may be omitted to leave the control unrestricted in that direction. For example, `Range20010101` would prevent a date prior to 2001 from being selected and `Range-20091231` (leading dash) would prevent a date later than 2009 from being selected. Without the Range option, any date between the years 1601 and 9999 can be selected. The time of day cannot be restricted.

**Right**: Causes the drop-down calendar to drop down on the right side of the control instead of the left.

**1**: Specify the number 1 in _Options_ to provide an up-down control to the right of the control to modify date-time values, which replaces the button of the drop-down month calendar that would otherwise be available. This does not work in conjunction with the format option LongDate described above.

**2**: Specify the number 2 in _Options_ to provide a checkbox inside the control that the user may uncheck to indicate that no date/time is selected. Once the control is created, this option cannot be changed.

**Colors inside the drop-down calendar**: The colors of the day numbers inside the drop-down calendar obey that set by the [Gui Font](../commands/Gui.htm#Font) command or the [c (Color)](../commands/Gui.htm#OtherOptions) option. To change the colors of other parts of the calendar, follow this example:

```
Gui +LastFound
<a href="PostMessage.htm" data-index="139">SendMessage</a>, 0x1006, 4, 0xFFAA99, SysDateTimePick321 <em>; 0x1006 is DTM_SETMCCOLOR. 4 is MCSC_MONTHBK (background color). The color must be specified in BGR vs. RGB format (red and blue components swapped).</em>
```

## MonthCal

Description: A tall and wide control that displays all the days of the month in calendar format. The user may select a single date or a range of dates.

For example:

```
Gui, Add, MonthCal, vMyCalendar
```

Appearance:

![MonthCal](../static/ctrl_monthcal.png)

To have a date other than today pre-selected, specify it as the last parameter in YYYYMMDD format (e.g. `20050531`). A range of dates may also be pre-selected by including a dash between two dates (e.g. `20050525-20050531`).

It is usually best to omit width (W) and height (H) for a MonthCal because it automatically sizes itself to fit exactly one month. To display more than one month vertically, specify `R2` or higher in _Options_. To display more than one month horizontally, specify `W-2` (W negative two) or higher. These options may both be present to expand in both directions.

The today-string at the bottom of the control can be clicked to select today's date. In addition, the year and month name are clickable and allow easy selection of a new year or month.

Keyboard navigation: On Windows Vista and later, keyboard navigation is fully supported in MonthCal, but only if it has the keyboard focus. For supported keyboard shortcuts, see [DateTime's keyboard navigation](#DateTime_Keyboard_Navigation) (within the drop-down calendar).

When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the selected date in YYYYMMDD format (without any time portion). However, when the [multi-select](#MonthCalMulti) option is in effect, the minimum and maximum dates are retrieved with a dash between them (e.g. `20050101-20050108`). If only a single date was selected in a multi-select calendar, the minimum and maximum are both present but identical. [StrSplit()](StrSplit.htm) or [StringSplit](StringSplit.htm) can be used to separate the dates. For example, the following would put the minimum in Date1 and the maximum in Date2: `StringSplit, Date, MyMonthCal, -`.

If the MonthCal has a [g-label](Gui.htm#label), each launch of it updates the control's [associated output variable](Gui.htm#var) (if any) with the currently selected date or range. By default, the label is launched only when the user changes the selection. On Windows XP and earlier, due to a quirk of the OS, the label is also launched every two minutes for the case a new day has arrived. However, if the word AltSubmit is in the control's _Options_, the [g-label](Gui.htm#label) is launched more often and the built-in variable A\_GuiEvent will contain the word Normal for a change of the date, the number 1 for a click of a date, and the number 2 when the MonthCal releases "mouse capture". For example, if the user double-clicks a new date, the label would be launched five times: Once with Normal, twice with 1, and twice with 2. This can be used to detect double clicks by [measuring the time](../Variables.htm#TickCount) between instances of the number 1.

When specifying dates in the YYYYMMDD format, the MM and/or DD portions may be omitted, in which case they are assumed to be 1. For example, `200205` is seen as 20020501, and `2005` is seen as 20050101.

### MonthCal Options

**Multi**: Multi-select. Allows the user to shift-click or click-drag to select a range of adjacent dates (the user may still select a single date too). This option may be specified explicitly or put into effect automatically by means of specifying a selection range when the control is created. For example: `Gui, Add, MonthCal, vMyCal, 20050101-20050108`. Once the control is created, this option cannot be changed.

**Range**: Restricts how far back or forward in time the calendar can go. After the word Range, specify the minimum and maximum dates in YYYYMMDD format (with a dash between them). For example, `Range20050101-20050615` would restrict the selection to the first 5.5 months of 2005. Either the minimum or maximum may be omitted to leave the calendar unrestricted in that direction. For example, `Range20010101` would prevent a date prior to 2001 from being selected and `Range-20091231` (leading dash) would prevent a date later than 2009 from being selected. Without the Range option, any date between the years 1601 and 9999 can be selected.

**4**: Specify the number 4 in _Options_ to display week numbers (1-52) to the left of each row of days. Week 1 is defined as the first week that contains at least four days.

**8**: Specify the number 8 in _Options_ to prevent the circling of today's date within the control.

**16**: Specify the number 16 in _Options_ to prevent the display of today's date at the bottom of the control.

**Colors**: The colors of the day numbers inside the calendar obey that set by the [Gui Font](../commands/Gui.htm#Font) command or the [c (Color)](../commands/Gui.htm#OtherOptions) option. To change the colors of other parts of the calendar, follow this example:

```
Gui +LastFound
<a href="PostMessage.htm" data-index="152">SendMessage</a>, 0x100A, 5, 0xFFAA99, SysMonthCal321 <em>; 0x100A is MCM_SETCOLOR. 5 is MCSC_TITLETEXT (color of title text). The color must be specified in BGR vs. RGB format (red and blue components swapped).</em>
```

## Slider

Description: A sliding bar that the user can move along a vertical or horizontal track. The standard volume control in the taskbar's tray is an example of a slider.

For example:

```
Gui, Add, Slider, vMySlider, 50
```

Appearance:

![Slider](../static/ctrl_slider.png)

Specify the starting position of the slider as the last parameter. If the last parameter is omitted, the slider starts off at 0 or the number in the allowable range that is closest to 0.

The user may slide the control by the following means: 1) dragging the bar with the mouse; 2) clicking inside the bar's track area with the mouse; 3) turning the mouse wheel while the control has focus; or 4) pressing the following keys while the control has focus: ↑, →, ↓, ←, PgUp, PgDn, Home, and End.

When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the current numeric position of the slider. The position is also stored in the output variable whenever the control's [g-label](Gui.htm#label) is launched.

If the slider has a [g-label](Gui.htm#label), by default it will be launched only when the user has stopped moving the slider (such as by releasing the mouse button after having dragging it). However, if the word AltSubmit is in the control's _Options_, the [g-label](Gui.htm#label) is launched for all slider events and the built-in variable A\_GuiEvent will contain one of the following digits or strings:

- 0: The user pressed← or ↑.
- 1: The user pressed→ or ↓.
- 2: The user pressedPgUp.
- 3: The user pressedPgDn.
- 4: The user moved the slider via the mouse wheel, or finished a drag-and-drop to a new position.
- 5: The user is currently dragging the slider via the mouse; that is, the mouse button is currently down.
- 6: The user pressedHome to send the slider to the left or top side.
- 7: The user pressedEnd to send the slider to the right or bottom side.
- Normal: The user has finished moving the slider, either via the mouse or the keyboard. Note: With the exception of mouse wheel movement (#4), the[g-label](Gui.htm#label) is launched again for the "normal" event even though it was already launched for one of the digit-events above.

### Slider Options

**Buddy1** and **Buddy2**: Specifies up to two existing controls to automatically reposition at the ends of the slider. Buddy1 is displayed at the left or top side (depending on whether the Vertical option is present). Buddy2 is displayed at the right or bottom side. After the word Buddy1 or Buddy2, specify the [variable name](Gui.htm#var) of an existing control. For example, `Buddy1MyTopText` would assign the control whose variable name is MyTopText.

**Center**: The thumb (the bar moved by the user) will be blunt on both ends rather than pointed at one end.

**Invert**: Reverses the control so that the lower value is considered to be on the right/bottom rather than the left/top. This is typically used to make a vertical slider move in the direction of a traditional volume control. Note: The ToolTip option described below will not obey the inversion and therefore should not be used in this case.

**Left**: The thumb (the bar moved by the user) will point to the top rather than the bottom. But if the Vertical option is in effect, the thumb will point to the left rather than the right.

**Line**: Specifies the number of positions to move when the user presses one of the arrow keys. After the word Line, specify number of positions to move. For example: `Line2`.

**NoTicks**: Omits tickmarks alongside the track.

**Page**: Specifies the number of positions to move when the user presses PgUp or PgDn. After the word Page, specify number of positions to move. For example: `Page10`.

**Range**: Sets the range to be something other than 0 to 100. After the word Range, specify the minimum, a dash, and maximum. For example, `Range1-1000` would allow a number between 1 and 1000 to be selected; `Range-50-50` would allow a number between -50 and 50; and `Range-10--5` would allow a number between -10 and -5.

**Thick**: Specifies the length of the thumb (the bar moved by the user). After the word Thick, specify the thickness in pixels (e.g. `Thick30`). To go beyond a certain thickness on Windows XP or later, it is probably necessary to either specify the Center option or remove the theme from the control (which can be done by specifying `-Theme` in the control's options).

**TickInterval**: Provides tickmarks alongside the track at the specified interval. After the word TickInterval, specify the interval at which to display additional tickmarks (if the interval is never set, it defaults to 1). For example, `TickInterval10` would display a tickmark once every 10 positions.

**ToolTip**: Creates a tooltip that reports the numeric position of the slider as the user is dragging it. To have the tooltip appear in a non-default position, specify one of the following instead: `ToolTipLeft` or `ToolTipRight` (for vertical sliders); `ToolTipTop` or `ToolTipBottom` (for horizontal sliders).

**Vertical**: Makes the control slide up and down rather than left and right.

The above options can be changed via [GuiControl](GuiControl.htm) after the control is created.

## Progress

Description: A dual-color bar typically used to indicate how much progress has been made toward the completion of an operation.

For example:

```
Gui, Add, Progress, w200 h20 cBlue vMyProgress, 75
```

Appearance:

![Progress](../static/ctrl_progress.png)

Specify the starting position of the bar as the last parameter (if omitted, the bar starts off at 0 or the number in the allowable range that is closest to 0). To later change the position of the bar, follow these examples, all of which operate upon a progress bar whose [associated variable name](Gui.htm#var) is MyProgress:

```
<a href="GuiControl.htm" data-index="162">GuiControl</a>,, MyProgress, +20  <em>; Increase the current position by 20.</em>
<a href="GuiControl.htm" data-index="163">GuiControl</a>,, MyProgress, 50  <em>; Set the current position to 50.</em>
```

For horizontal Progress Bars, the thickness of the bar is equal to the control's height. For vertical Progress Bars it is equal to the control's width.

### Progress Options

**Cn**: Changes the bar's color. Specify for **n** one of the 16 primary HTML [color names](Progress.htm#colors) or a 6-digit RGB color value. Examples: `cRed`, `cFFFF33`, `cDefault`. If the C option is never used (or `cDefault` is specified), the system's default bar color will be used.

**BackgroundN**: Changes the bar's background color. Specify for **n** one of the 16 primary HTML [color names](Progress.htm#colors) or a 6-digit RGB color value. Examples: `BackgroundGreen`, `BackgroundFFFF33`, `BackgroundDefault`. If the Background option is never used (or `BackgroundDefault` is specified), the background color will be that of the window or [tab control](#Tab) behind it.

**Range**: Sets the range to be something other than 0 to 100. After the word Range, specify the minimum, a dash, and maximum. For example, `Range0-1000` would allow numbers between 0 and 1000; `Range-50-50` would allow numbers between -50 and 50; and `Range-10--5` would allow numbers between -10 and -5.

**Smooth**: Specify `-Smooth` (minus Smooth) to display a length of segments rather than a smooth continuous bar. Specifying `-Smooth` is also one of the requirements to show a themed progress bar on Windows XP or later. The other requirement is that the bar not have any custom colors; that is, that the C and Background options be omitted.

**Vertical**: Makes the bar rise or fall vertically rather than move along horizontally.

The above options can be changed via [GuiControl](GuiControl.htm) after the control is created.

## GroupBox

Description: A rectangular border/frame, often used around other controls to indicate they are related. In this case, the last parameter is the title of the box, which if present is displayed at its upper-left edge.

For example:

```
Gui, Add, GroupBox, w200 h100, Geographic Criteria
```

Appearance:

![GroupBox](../static/ctrl_group.png)

By default, a GroupBox's title may have only one line of text. This can be overridden by specifying `Wrap` in _Options_.

To specify the number of rows inside the control (or its height and width), see [position and sizing of controls](Gui.htm#PosSize).

## Tab3

Description: A large control containing multiple pages, each of which contains other controls. From this point forward, these pages are referred to as "tabs".

There are three types of Tab control:

- **Tab3**[v1.1.23.00+]: Fixes some issues which affect Tab2 and Tab. Controls are placed within an invisible "tab dialog" which moves and resizes with the tab control. The tab control is themed by default.
- **Tab2**[v1.0.47.05+]: Fixes rare redrawing problems in the original "Tab" control but introduces [some other problems](#Tab2_Issues).
- **Tab**: Retained for backward compatibility because of [differences in behavior](#Tab_vs) between Tab2/Tab3 and Tab.

For example:

```
Gui, Add, Tab3,, General|View|Settings
```

Appearance:

![Tab](../static/ctrl_tab.png)

The last parameter above is a pipe-delimited list of tab names. To have one of the tabs pre-selected when the window first appears, include two pipe characters after it (e.g. `Red|Green||Blue`). Alternatively, include in _Options_ the word **Choose** followed immediately by the number of a tab to be pre-selected. For example, `Choose5` would pre-select the fifth tab (as with other options, it can also be a variable such as `Choose%Var%`). To change the selected tab, add tabs, or remove tabs after the control has been created, use [GuiControl](GuiControl.htm).

After creating a Tab control, subsequently added controls automatically belong to its first tab. This can be changed at any time by following these examples:

```
Gui, Tab  <em>; Future controls are not part of any tab control.</em>
Gui, Tab, 3  <em>; Future controls are owned by the third tab of the current tab control.</em>
Gui, Tab, 3, 2  <em>; Future controls are owned by the third tab of the second tab control.</em>
Gui, Tab, Name  <em>; Future controls are owned by the tab whose name starts with <i>Name</i> (not case sensitive).</em>
Gui, Tab, Name,, Exact  <em>; Same as above but requires exact match (case sensitive too).</em>
```

It is also possible to use any of the examples above to assign controls to a tab or tab-control that does not yet exist (except in the case of the _Name_ method). But in that case, the relative positioning options described below are not supported.

**Positioning**: When each tab of a Tab control receives its first sub-control, that sub-control will have a special default position under the following conditions: 1) The X and Y coordinates are both omitted, in which case the first sub-control is positioned at the upper-left corner of the tab control's interior (with a standard [margin](Gui.htm#Margin)), and sub-controls beyond the first are positioned beneath the previous control; 2) The [X+n and/or Y+n](Gui.htm#PosPlus) positioning options are specified, in which case the sub-control is positioned relative to the upper-left corner of the tab control's interior. For example, specifying `x+10 y+10` would position the control 10 pixels right and 10 pixels down from the upper left corner.

**V**: When the [Gui Submit](Gui.htm#Submit) command is used, the control's [associated output variable](Gui.htm#var) (if any) receives the name of the currently selected tab. However, if the control has the [AltSubmit](Gui.htm#AltSubmit) property, the output variable will receive the tab's position number instead (the first tab is 1, the second is 2, etc.).

**G**: A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user changes to a new tab. If the tab control has both a [g-label](Gui.htm#label) and an [output variable](Gui.htm#var), whenever the user switches to a new tab, the output variable will be set to the previously selected tab name (or number in the case of [AltSubmit](Gui.htm#AltSubmit)).

**Keyboard navigation**: The user may press Ctrl+PgDn/PgUp to navigate from page to page in a tab control; if the keyboard focus is on a control that does not belong to a Tab control, the window's first Tab control will be navigated. Ctrl+Tab and Ctrl+Shift+Tab may also be used except that they will not work if the currently focused control is a multi-line Edit control.

**Limits**: Each window may have no more than 255 tab controls. Each tab control may have no more than 256 tabs (pages). In addition, a tab control may not contain other tab controls.

### Tab3 vs. Tab2 vs. Tab

**Parent window**: The parent window of a control affects the positioning and visibility of the control and tab-key navigation order. If a sub-control is added to an existing Tab3 control, its parent window is the "tab dialog", which fills the tab control's display area. Most other controls, including sub-controls of Tab or Tab2 controls, have no parent other than the GUI window itself.

**Positioning**: For Tab and Tab2, sub-controls do not necessarily need to exist within their tab control's boundaries: they will still be hidden and shown whenever their tab is selected or de-selected. This behavior is especially appropriate for the "buttons" style described below.

For Tab3, sub-controls assigned to a tab _before_ the tab control is created behave as though added to a Tab or Tab2 control. All other sub-controls are visible only within the display area of the tab control.

If a Tab3 control is moved, its sub-controls are moved with it. Tab and Tab2 controls do not have this behavior.

In the rare case that [WinMove](WinMove.htm) (or an equivalent DllCall) is used to move a control, the coordinates must be relative to the parent window of the control, which might not be the GUI (see [above](#Tab_Parent)). By contrast, [GuiControl Move](GuiControl.htm#Move) takes GUI coordinates and [ControlMove](ControlMove.htm) takes window coordinates, regardless of the control's parent window.

**Autosizing**: If not specified by the script, the width and/or height of the Tab3 control are automatically calculated at one of the following times (whichever comes first after the control is created):

- The first time the Tab3 control ceases to be the current tab control. This can occur as a result of calling[Gui Tab](#TabCmd) (with or without parameters) or creating another tab control.
- The first time[Gui Show](Gui.htm#Show) is called for that particular Gui.

The calculated size accounts for sub-controls which exist when autosizing occurs, plus the default margins. The size is calculated only once, and will not be recalculated even if controls are added later. If the Tab3 control is empty, it receives the same default size as a Tab or Tab2 control.

Tab and Tab2 controls are not autosized; they receive an arbitrary default size.

**Tab-key navigation order**: The navigation order via Tab usually depends on the order in which the controls are created. When tab controls are used, the order also depends on the type of tab control:

- Tab and Tab2 allow their sub-controls to be mixed with other controls within the tab-key order.
- Tab2 puts its tab buttons after its sub-controls in the tab-key order.
- Tab3 groups its sub-controls within the tab-key order and puts them after its tab buttons.

**Notification messages (Tab3)**: Common and [Custom](#Custom) controls typically send notification messages to their [parent window](#Tab_Parent). Any WM\_COMMAND, WM\_NOTIFY, WM\_VSCROLL, WM\_HSCROLL or WM\_CTLCOLOR' messages received by a Tab3 control's [tab dialog](#Tab_Parent) are forwarded to the GUI window and can be detected by using [OnMessage()](OnMessage.htm). If the tab control is themed and the sub-control lacks the [+BackgroundTrans](Gui.htm#BackgroundTrans) option, WM\_CTLCOLORSTATIC is fully handled by the tab dialog and not forwarded. Other notification messages (such as custom messages) are not supported.

**Known issues with Tab2**:

- [BackgroundTrans](Gui.htm#BackgroundTrans) has no effect inside a Tab2 control.
- [WebBrowser](#ActiveX) controls do not redraw correctly.
- AnimateWindow and possibly other Win32 API calls can cause the tab's controls to disappear.

**Known issues with Tab**:

- Activating a GUI window by clicking certain parts of its controls, such as scrollbars, might redraw improperly.
- [BackgroundTrans](Gui.htm#BackgroundTrans) has no effect if the Tab control contains a ListView.
- [WebBrowser](#ActiveX) controls are invisible.

### Tab Options

**Choose**: See [above](#ChooseTab).

**Background**: Specify `-Background` (minus Background) to override the [window's custom background color](Gui.htm#Color) and use the system's default Tab control color. Specify `+Theme -Background` to make the Tab control conform to the current desktop theme. However, most control types will look strange inside such a Tab control because their backgrounds will not match that of the tab control. This can be fixed for some control types (such as [Text](#Text)) by adding BackgroundTrans to their options.

**Buttons**: Creates a series of buttons at the top of the control rather than a series of tabs (in this case, there will be no border by default because the display area does not typically contain controls).

**Left/Right/Bottom**: Specify one of these words to have the tabs on the left, right, or bottom side instead of the top. See [TCS\_VERTICAL](../misc/Styles.htm#TCS_VERTICAL) for limitations on Left and Right.

**Wrap**: Specify `-Wrap` (minus Wrap) to prevent the tabs from taking up more than a single row (in which case if there are too many tabs to fit, arrow buttons are displayed to allow the user to slide more tabs into view).

To specify the number of rows of text inside the control (or its height and width), see [position and sizing of controls](Gui.htm#PosSize).

**Icons in Tabs**: An icon may be displayed next to each tab's name/text via [SendMessage](PostMessage.htm). This is demonstrated in the forum topic [Icons in tabs](https://www.autohotkey.com/forum/topic6060.html).

## StatusBar [v1.0.44+]

Description: A row of text and/or icons attached to the bottom of a window, which is typically used to report changing conditions.

For example:

```
Gui, Add, StatusBar,, Bar's starting text (omit to start off empty).
SB_SetText("There are " . RowCount . " rows selected.")
```

Appearance:

![StatusBar](../static/ctrl_status.png)

The simplest use of a status bar is to call [SB\_SetText()](#SB_SetText) whenever something changes that should be reported to the user. To report more than one piece of information, divide the bar into sections via [SB\_SetParts()](#SB_SetParts). To display icon(s) in the bar, call [SB\_SetIcon()](#SB_SetIcon).

### StatusBar Functions

All of the following StatusBar functions operate upon the current thread's [default GUI window](Gui.htm#DefaultWin) (which can be changed via `<a href="Gui.htm#Default" data-index="207">Gui, 2:Default</a>`). If the default window does not exist or has no status bar, all SB functions return 0 to indicate the problem.

#### SB\_SetText

Displays _NewText_ in the specified part of the status bar.

```
<span class="func">SB_SetText</span>(NewText <span class="optional">, PartNumber, Style</span>)
```

If _PartNumber_ is omitted, it defaults to 1. Otherwise, specify an integer between 1 and 256. If _Style_ is omitted, it defaults to 0, which uses a traditional border that makes that part of the bar look sunken. Otherwise, specify 1 to have no border or 2 to have border that makes that part of the bar look raised. Finally, up to two tab characters (\`t) may be present anywhere in _NewText_: anything to the right of the first tab is centered within the part, and anything to the right of the second tab is right-justified. SB\_SetText() returns 1 upon success and 0 upon failure.

#### SB\_SetParts

Divides the bar into multiple sections according to the specified widths (in pixels).

```
<span class="func">SB_SetParts</span>(<span class="optional">Width1, Width2, ... Width255</span>)
```

If all parameters are omitted, the bar is restored to having only a single, long part. Otherwise, specify the width of each part except the last (the last will fill the remaining width of the bar). For example, `SB_SetParts(50, 50)` would create three parts: the first two of width 50 and the last one of all the remaining width.

**Note**: Any parts "deleted" by SB\_SetParts() will start off with no text the next time they are shown (furthermore, their icons are automatically destroyed).

Upon success, SB\_SetParts() returns a non-zero value (the status bar's [HWND](ControlGet.htm#Hwnd)). Upon failure it returns 0.

#### SB\_SetIcon

Displays a small icon to the left of the text in the specified part.

```
<span class="func">SB_SetIcon</span>(Filename <span class="optional">, IconNumber, PartNumber</span>)
```

If _PartNumber_ is omitted, it defaults to 1. _Filename_ is the name of an icon (.ICO), cursor (.CUR), or animated cursor (.ANI) file (animated cursors will not actually be animated in the bar). Other sources of icons include the following types of files: EXE, DLL, CPL, SCR, and other types that contain icon resources. To use an icon group other than the first one in the file, specify its number for _IconNumber_. For example, `SB_SetIcon("Shell32.dll", 2)` would use the default icon from the second icon group. If _IconNumber_ is negative, its absolute value is assumed to be the resource ID of an icon within an executable file. SB\_SetIcon() returns the icon's HICON upon success and 0 upon failure. The HICON is a system resource that can be safely ignored by most scripts because it is destroyed automatically when the status bar's window is destroyed. Similarly, any old icon is destroyed when SB\_SetIcon() replaces it with a new one. This can be avoided via:

```
Gui +LastFound
<a href="PostMessage.htm" data-index="209">SendMessage</a>, 0x040F, part_number - 1, my_hIcon, msctls_statusbar321  <em>; 0x040F is SB_SETICON.</em>
```

[v1.1.23+]: An [icon handle](../misc/ImageHandles.htm) can be used instead of a filename. For example, `SB_SetIcon("HICON:" handle)`.

[v1.1.27+]: Non-icon image files and [bitmap handles](../misc/ImageHandles.htm) are supported for _Filename_. For example, `SB_SetIcon("HBITMAP:" handle)`.

#### SB\_SetProgress

Creates and controls a progress bar inside the status bar. This function is available at [www.autohotkey.com/forum/topic37754.html](https://www.autohotkey.com/forum/topic37754.html)

### StatusBar Usage

**G-Label notifications**: A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user clicks on the bar. This subroutine may consult the built-in variables [A\_Gui](../Variables.htm#Gui) and [A\_GuiControl](../Variables.htm#GuiControl). More importantly, it may consult **A\_GuiEvent**, which contains one of the following strings (for compatibility with future versions, a script should not assume these are the only possible values):

- **Normal**: The user left-clicked the bar. The variable A\_EventInfo contains the part number (however, the part number might be a very large integer if the user clicks near the sizing grip at the right side of the bar).
- **RightClick**: The user right-clicked the bar. The variable A\_EventInfo contains the part number. NOTE: [GuiContextMenu](Gui.htm#GuiContextMenu) will not be called for the status bar if it has a g-label. Also, the g-label's RightClick event should be used instead of [GuiContextMenu](Gui.htm#GuiContextMenu) when the script needs to know which part number the user clicked on (A\_EventInfo).
- **DoubleClick**: The user double-clicked the bar. The variable A\_EventInfo contains the part number.
- **R**: The user _double-right_-clicked the bar. The variable A\_EventInfo contains the part number.

**Font and color**: Although the font size, face, and style can be set via [Gui Font](Gui.htm#Font) (just like normal controls), the text color cannot be changed. Also, [Gui Color](Gui.htm#Color) is not obeyed; instead, the status bar's background color may be changed by specifying in _Options_ the word **Background** followed immediately by a color name (see [color chart](Progress.htm#colors)) or RGB value (the 0x prefix is optional). Examples: `BackgroundSilver`, `BackgroundFFDD99`, `BackgroundDefault`.

**Hiding the StatusBar**: Upon creation, the bar can be hidden via `Gui, Add, StatusBar, Hidden vMyStatusBar`. To hide it sometime after creation, use `GuiControl, Hide, MyStatusBar`. To show it, use `GuiControl, Show, MyStatusBar`. Note: Hiding the bar does not reduce the height of the window. If that is desired, one easy way is `Gui, Show, <a href="Gui.htm#AutoSize" data-index="221">AutoSize</a>`.

**Styles (rarely used)**: See the [StatusBar styles table](../misc/Styles.htm#StatusBar).

**Known limitations**: 1) Any control that overlaps the status bar might sometimes get drawn on top of it. One way to avoid this is to dynamically shrink such controls via the [GuiSize label](Gui.htm#GuiSize). 2) There is a limit of one status bar per window.

**Example**: [Example #1](TreeView.htm#ExAdvanced) at the bottom of the TreeView page demonstrates a multipart status bar.

## ActiveX [v1.1.03+]

ActiveX components such as the MSIE browser control can be embedded into a GUI window as follows. For details about the ActiveX component and its method used below, see [WebBrowser object (Microsoft Docs)](http://msdn.microsoft.com/en-us/library/aa752085) and [Navigate method (Microsoft Docs)](http://msdn.microsoft.com/en-us/library/aa752093).

```
Gui Add, ActiveX, w980 h640 vWB, Shell.Explorer  <em>; The final parameter is the name of the ActiveX component.</em>
WB.Navigate("https://www.autohotkey.com/docs/")  <em>; This is specific to the web browser control.</em>
Gui Show
```

When the control is created, an ActiveX object is stored in the control's associated variable, if it has one. [GuiControlGet](GuiControlGet.htm) can also be used to retrieve the object.

To handle events exposed by the object, use [ComObjConnect()](ComObjConnect.htm) as follows. For details about the event used below, see [NavigateComplete2 event (Microsoft Docs)](http://msdn.microsoft.com/en-us/library/aa768334).

```
Gui Add, Edit, w930 r1 vURL, https://www.autohotkey.com/docs/
Gui Add, Button, x+6 yp w44 Default, Go
Gui Add, ActiveX, xm w980 h640 vWB, Shell.Explorer
ComObjConnect(WB, WB_events)  <em>; Connect WB's events to the WB_events class object.</em>
Gui Show
<em>; Continue on to load the initial page:</em>
ButtonGo:
Gui Submit, NoHide
WB.Navigate(URL)
return

class WB_events
{
    NavigateComplete2(wb, NewURL)
    {
        GuiControl,, URL, %NewURL%  <em>; Update the URL edit control.</em>
    }
}

GuiClose:
ExitApp
```

[ComObjType()](ComObjType.htm) can be used to determine the type of object stored in the control's variable.

## Custom [v1.1.10+]

Other controls which are not directly supported by AutoHotkey can be also embedded into a GUI window. In order to do so, include in _Options_ the word **Class** followed by the Win32 class name of the desired control. Examples:

```
Gui, Add, Custom, ClassComboBoxEx32  <em>; Adds a <a href="http://msdn.microsoft.com/en-us/library/windows/desktop/bb775740.aspx" data-index="231">ComboBoxEx</a> control.</em>
Gui, Add, Custom, ClassScintilla  <em>; Adds a <a href="https://scintilla.org/" data-index="232">Scintilla</a> control. Note that the SciLexer.dll library must be loaded before the control can be added.</em>
```

AutoHotkey uses the standard Windows control text routines when text is to be retrieved/replaced in the control via [Gui Add](Gui.htm#Add), [GuiControl](GuiControl.htm) or [GuiControlGet](GuiControlGet.htm).

**G-Label Notifications**: A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options in order to capture events coming from the control. This subroutine may consult the built-in variables [A\_Gui](../Variables.htm#Gui) and [A\_GuiControl](../Variables.htm#GuiControl). More importantly, it may consult **A\_GuiEvent**, which contains one of the following strings (for compatibility with future versions, a script should not assume these are the only possible values):

- **Normal**: A [WM\_COMMAND](http://msdn.microsoft.com/en-us/library/windows/desktop/ms647591.aspx) message was received. The built-in variable A\_EventInfo contains a control-defined notification code (equivalent to `HIWORD(wParam)` in C/C++).
- **N**: A [WM\_NOTIFY](http://msdn.microsoft.com/en-us/library/windows/desktop/bb775583.aspx) message was received. The built-in variable A\_EventInfo contains a pointer to the control notification structure (NMHDR). A 32-bit signed integer value may be returned to the control by assigning it to [ErrorLevel](../misc/ErrorLevel.htm) (by default, the g-label thread's ErrorLevel is set to zero). Invalid values are treated as zero.

Here is an example that shows how to add and use an [IP address control](http://msdn.microsoft.com/en-us/library/windows/desktop/bb761374.aspx):

```
Gui, Add, Custom, ClassSysIPAddress32 r1 w150 hwndhIPControl gIPControlEvent
Gui, Add, Button, Default, OK
IPCtrlSetAddress(hIPControl, A_IPAddress1)
Gui, Show
return

GuiClose:
ExitApp

ButtonOK:
Gui, Hide
ToolTip
MsgBox % "You chose " IPCtrlGetAddress(hIPControl)
ExitApp

IPControlEvent:
if (A_GuiEvent = "Normal")
{
    <em>; WM_COMMAND was received.</em>

    if (A_EventInfo = 0x0300)  <em>; EN_CHANGE</em>
        ToolTip Control changed!
}
else if (A_GuiEvent = "N")
{
    <em>; WM_NOTIFY was received.

    ; Get the notification code. Normally this field is UInt but the IP address
    ; control uses negative codes, so for convenience we read it as a signed int.</em>
    nmhdr_code := NumGet(A_EventInfo + 2*A_PtrSize, "int")
    if (nmhdr_code != -860)  <em>; IPN_FIELDCHANGED</em>
        return

    <em>; Extract info from the NMIPADDRESS structure</em>
    iField := NumGet(A_EventInfo + 3*A_PtrSize + 0, "int")
    iValue := NumGet(A_EventInfo + 3*A_PtrSize + 4, "int")
    if (iValue >= 0)
        ToolTip Field #%iField% modified: %iValue%
    else
        ToolTip Field #%iField% left empty
}
return

IPCtrlSetAddress(hControl, IPAddress)
{
    static WM_USER := 0x0400
    static IPM_SETADDRESS := WM_USER + 101

    <em>; Pack the IP address into a 32-bit word for use with SendMessage.</em>
    IPAddrWord := 0
    Loop, Parse, IPAddress, .
        IPAddrWord := (IPAddrWord * 256) + A_LoopField
    SendMessage IPM_SETADDRESS, 0, IPAddrWord,, ahk_id %hControl%
}

IPCtrlGetAddress(hControl)
{
    static WM_USER := 0x0400
    static IPM_GETADDRESS := WM_USER + 102

    VarSetCapacity(AddrWord, 4)
    SendMessage IPM_GETADDRESS, 0, &AddrWord,, ahk_id %hControl%
    return NumGet(AddrWord, 3, "UChar") "." NumGet(AddrWord, 2, "UChar") "." NumGet(AddrWord, 1, "UChar") "." NumGet(AddrWord, 0, "UChar")
}
```

## Related Pages

[ListView](ListView.htm), [TreeView](TreeView.htm), [Gui](Gui.htm), [GuiControl](GuiControl.htm), [GuiControlGet](GuiControlGet.htm), [Menu](Menu.htm)

