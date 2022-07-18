# ControlGet

Retrieves various types of information about a control.

```
<span class="func">ControlGet</span>, OutputVar, <a href="#SubCommands" data-index="1">SubCommand</a> <span class="optional">, Value, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

## Parameters

OutputVarThe name of the variable in which to store the result of _SubCommand_.SubCommand, ValueThese are dependent upon each other and their usage is described [below](#SubCommands).Control

Can be either ClassNN (the classname and instance number of the control) or the control's text, both of which can be determined via Window Spy. When using text, the matching behavior is determined by [SetTitleMatchMode](SetTitleMatchMode.htm). If this parameter is blank, the target window's topmost control will be used.

To operate upon a control's HWND (window handle), leave the _Control_ parameter blank and specify `ahk_id %ControlHwnd%` for the _WinTitle_ parameter (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off). The HWND of a control is typically retrieved via [ControlGet Hwnd](ControlGet.htm#Hwnd), [MouseGetPos](MouseGetPos.htm), or [DllCall()](DllCall.htm).

WinTitleA window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).WinTextIf present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.ExcludeTitleWindows whose titles include this value will not be considered.ExcludeTextWindows whose text include this value will not be considered.

## Sub-commands

For _SubCommand_, specify one of the following:

- [List](#List): Retrieves a list of items from a ListView, ListBox, ComboBox, or DropDownList.
- [Checked](#Checked): Retrieves 1 if the checkbox or radio button is checked or 0 if not.
- [Enabled](#Enabled): Retrieves 1 if the control is enabled, or 0 if disabled.
- [Visible](#Visible): Retrieves 1 if the control is visible, or 0 if hidden.
- [Tab](#Tab): Retrieves the tab number of a SysTabControl32 control.
- [FindString](#FindString): Retrieves the entry number of a ListBox or ComboBox that is an exact match for the string.
- [Choice](#Choice): Retrieves the name of the currently selected entry in a ListBox or ComboBox.
- [LineCount](#LineCount): Retrieves the number of lines in an Edit control.
- [CurrentLine](#CurrentLine): Retrieves the line number in an Edit control where the caret resides.
- [CurrentCol](#CurrentCol): Retrieves the column number in an Edit control where the caret resides.
- [Line](#Line): Retrieves the text of the specified line number in an Edit control.
- [Selected](#Selected): Retrieves the selected text in an Edit control.
- [Style](#Style): Retrieves an 8-digit hexadecimal number representing the style of the control.
- [ExStyle](#ExStyle): Retrieves an 8-digit hexadecimal number representing the extended style of the control.
- [Hwnd](#Hwnd)[v1.1.04+]: Retrieves the window handle (HWND) of the control.

### List

Retrieves a list of items from a ListView, ListBox, ComboBox, or DropDownList. For ListView, additional options can be specified.

```
<span class="func">ControlGet</span>, OutputVar, List <span class="optional">, Options, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

#### ListView

If the _Options_ parameter is blank or omitted, all the text in the control is retrieved. Each row except the last will end with a linefeed character (\`n). Within each row, each field (column) except the last will end with a tab character (\`t).

Specify for _Options_ zero or more of the following words, each separated from the next with a space or tab:

OptionDescriptionSelectedRetrieves only the selected (highlighted) rows rather than all rows. If none, _OutputVar_ is made blank.FocusedRetrieves only the focused row. If none, _OutputVar_ is made blank.Col4Retrieves only the fourth column (field) rather than all columns (replace 4 with a number of your choice).CountRetrieves a single number that is the total number of rows in the control.Count SelectedRetrieves the number of selected (highlighted) rows.Count FocusedRetrieves the row number (position) of the focused row (0 if none).Count ColRetrieves the number of columns in the control (or -1 if the count cannot be determined).

**Note**: Some applications store their ListView text privately, which prevents their text from being retrieved. In these cases, ErrorLevel will usually be set to 0 (indicating success) but all the retrieved fields will be empty. Also note that ListView text retrieval is not restricted by [#MaxMem](_MaxMem.htm).

Upon success, ErrorLevel is set to 0. Upon failure, it is set to 1 and _OutputVar_ is made blank. Failure occurs when: 1) the target window or control does not exist; 2) the target control is not of type SysListView32; 3) the process owning the ListView could not be opened, perhaps due to a lack of user permissions or because it is locked; 4) the [Col _N_ option](#ColN) specifies a nonexistent column.

To extract the individual rows and fields out of a ListView, use a [parsing loop](LoopParse.htm) as in this example:

```
ControlGet, SelectedItems, List, Selected, SysListView321, <i>WinTitle</i>
Loop, Parse, SelectedItems, `n  <em>; Rows are delimited by linefeeds (`n).</em>
{
    RowNumber := A_Index
    Loop, Parse, A_LoopField, %A_Tab%  <em>; Fields (columns) in each row are delimited by tabs (A_Tab).</em>
        MsgBox Row #%RowNumber% Col #%A_Index% is %A_LoopField%.
}
```

On a related note, the columns in a ListView can be resized via [SendMessage](PostMessage.htm) as shown in this example:

```
SendMessage, 0x101E, 0, 80, SysListView321, <i>WinTitle</i>  <em>; 0x101E is LVM_SETCOLUMNWIDTH.</em>
```

In the above, 0 indicates the first column (specify 1 for the second, 2 for the third, etc.) Also, 80 is the new width. Replace 80 with -1 to autosize the column. Replace it with -2 to do the same but also take into account the header text width.

#### ListBox, ComboBox, DropDownList

All the text is retrieved from the control (that is, the ListView options above such as _Count_ and _Selected_ are not supported).

Each item except the last will be terminated by a linefeed character (\`n). To access the items individually, use a [parsing loop](LoopParse.htm) as in this example:

```
ControlGet, Items, List,, ComboBox1, <i>WinTitle</i>
Loop, Parse, Items, `n
    MsgBox Item number %A_Index% is %A_LoopField%.
```

### Checked

Retrieves 1 if the checkbox or radio button is checked or 0 if not.

```
<span class="func">ControlGet</span>, OutputVar, Checked <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### Enabled

Retrieves 1 if _Control_ is enabled, or 0 if disabled.

```
<span class="func">ControlGet</span>, OutputVar, Enabled <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### Visible

Retrieves 1 if _Control_ is visible, or 0 if hidden.

```
<span class="func">ControlGet</span>, OutputVar, Visible <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

### Tab

Retrieves the tab number of a SysTabControl32 control.

```
<span class="func">ControlGet</span>, OutputVar, Tab <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

The first tab is 1, the second is 2, etc. To instead discover how many tabs (pages) exist in a tab control, follow this example:

```
<a href="PostMessage.htm" data-index="30">SendMessage</a>, 0x1304,,, SysTabControl321, <i>WinTitle</i>  <em>; 0x1304 is TCM_GETITEMCOUNT.</em>
TabCount := ErrorLevel
```

### FindString

Retrieves the entry number of a ListBox or ComboBox that is an exact match for _String_.

```
<span class="func">ControlGet</span>, OutputVar, FindString, String <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

The first entry in the control is 1, the second 2, and so on. If no match is found, _OutputVar_ is made blank and ErrorLevel is set to 1.

### Choice

Retrieves the name of the currently selected entry in a ListBox or ComboBox.

```
<span class="func">ControlGet</span>, OutputVar, Choice <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

To instead retrieve the position of the selected item, follow this example (use only one of the first two lines):

```
<a href="PostMessage.htm" data-index="31">SendMessage</a>, 0x0188, 0, 0, ListBox1, <i>WinTitle</i>  <em>; 0x0188 is LB_GETCURSEL (for a ListBox).</em>
<a href="PostMessage.htm" data-index="32">SendMessage</a>, 0x0147, 0, 0, ComboBox1, <i>WinTitle</i>  <em>; 0x0147 is CB_GETCURSEL (for a DropDownList or ComboBox).</em>
ChoicePos := ErrorLevel<<32>>32  <em>; Convert UInt to Int to have -1 if there is no item selected.</em>
ChoicePos += 1  <em>; Convert from 0-based to 1-based, i.e. so that the first item is known as 1, not 0.</em>
```

### LineCount

Retrieves the number of lines in an Edit control.

```
<span class="func">ControlGet</span>, OutputVar, LineCount <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

All Edit controls have at least 1 line, even if the control is empty.

### CurrentLine

Retrieves the line number in an Edit control where the caret (insert point) resides.

```
<span class="func">ControlGet</span>, OutputVar, CurrentLine <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

The first line is 1. If there is text selected in the control, _OutputVar_ is set to the line number where the selection begins.

### CurrentCol

Retrieves the column number in an Edit control where the caret (text insertion point) resides.

```
<span class="func">ControlGet</span>, OutputVar, CurrentCol <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

The first column is 1. If there is text selected in the control, _OutputVar_ is set to the column number where the selection begins.

### Line

Retrieves the text of line _N_ in an Edit control.

```
<span class="func">ControlGet</span>, OutputVar, Line, N <span class="optional">, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

Line 1 is the first line. Depending on the nature of the control, _OutputVar_ might end in a carriage return (\`r) or a carriage return + linefeed (\`r\`n). If the specified line number is blank or does not exist, [ErrorLevel](../misc/ErrorLevel.htm) is set to 1 and _OutputVar_ is made blank.

### Selected

Retrieves the selected text in an Edit control.

```
<span class="func">ControlGet</span>, OutputVar, Selected <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

If no text is selected, _OutputVar_ will be made blank and ErrorLevel will be set to 0 (i.e. no error). Certain types of controls, such as RichEdit20A, might not produce the correct text in some cases (e.g. Metapad).

### Style

Retrieves an 8-digit hexadecimal number representing the style of the control.

```
<span class="func">ControlGet</span>, OutputVar, Style <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

See the [styles table](../misc/Styles.htm) for a listing of some styles.

### ExStyle

Retrieves an 8-digit hexadecimal number representing the extended style of the control.

```
<span class="func">ControlGet</span>, OutputVar, ExStyle <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

See the [styles table](../misc/Styles.htm) for a listing of some styles.

### Hwnd [v1.0.43.06+]

Retrieves the window handle (HWND) of the control.

```
<span class="func">ControlGet</span>, OutputVar, Hwnd <span class="optional">,, Control, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

For example: `ControlGet, OutputVar, Hwnd,, Edit1, <i>WinTitle</i>`. A control's HWND is often used with [PostMessage](PostMessage.htm), [SendMessage](PostMessage.htm), and [DllCall()](DllCall.htm). On a related note, a control's HWND can also be retrieved via [MouseGetPos](MouseGetPos.htm). Finally, a control's HWND can be used directly as an [ahk\_id WinTitle](../misc/WinTitle.htm#ahk_id) (this also works on hidden controls even when [DetectHiddenWindows](DetectHiddenWindows.htm) is Off).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

Upon success, [ErrorLevel](../misc/ErrorLevel.htm) is set to 0. If a problem occurred -- such as a nonexistent window or control -- [ErrorLevel](../misc/ErrorLevel.htm) is set to 1 and _OutputVar_ is made blank.

## Remarks

Unlike commands that change a control, ControlGet does not have an automatic delay; that is, [SetControlDelay](SetControlDelay.htm) does not affect it.

To discover the ClassNN or HWND of the control that the mouse is currently hovering over, use [MouseGetPos](MouseGetPos.htm). To retrieve a list of all controls in a window, use [WinGet ControlList](WinGet.htm#ControlList).

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## Related

[Control](Control.htm), [GuiControlGet](GuiControlGet.htm), [ControlMove](ControlMove.htm), [ControlGetText](ControlGetText.htm), [ControlSetText](ControlSetText.htm), [ControlGetPos](ControlGetPos.htm), [ControlClick](ControlClick.htm), [ControlFocus](ControlFocus.htm), [ControlSend](ControlSend.htm), [WinGet](WinGet.htm)

## Examples

Retrieves the first line of the first Edit control.

```
ControlGet, OutputVar, Line, 1, Edit1, Some Window Title
```

Retrieves the currently active tab of the first Tab control.

```
ControlGet, WhichTab, Tab,, SysTabControl321, Some Window Title
if ErrorLevel
    MsgBox There was a problem.
else
    MsgBox Tab #%WhichTab% is active.
```

