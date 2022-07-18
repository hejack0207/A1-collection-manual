# ListView

## Table of Contents

- [Introduction and Simple Example](#Intro)
- [Options and Styles for the Options Parameter](#Options)
- [View Modes](#View): Report (default), Icon, Tile, IconSmall, and List.
- [Built-in Functions for ListViews](#BuiltIn)
- [G-Label Notifications](#notify)
- [ImageLists](#IL) (the means by which icons are added to a ListView)
- [Remarks](#Remarks)
- [Examples](#Examples)

## Introduction and Simple Example

A List-View is one of the most elaborate controls provided by the operating system. In its most recognizable form, it displays a tabular view of rows and columns, the most common example of which is Explorer's list of files and folders (detail view).

A ListView usually looks like this:

![ListView](../static/ctrl_listview.png)

Though it may be elaborate, a ListView's basic features are easy to use. The syntax for creating a ListView is:

```
<span class="func">Gui</span>, Add, ListView, Options, ColumnTitle1|ColumnTitle2|...
```

Here is a working script that creates and displays a ListView containing a list of files in the user's "My Documents" folder:

```
<em>; Create the ListView with two columns, Name and Size:</em>
Gui, Add, ListView, r20 w700 gMyListView, Name|Size (KB)

<em>; Gather a list of file names from a folder and put them into the ListView:</em>
Loop, %A_MyDocuments%\*.*
    <a href="#LV_Add" data-index="9">LV_Add</a>("", A_LoopFileName, A_LoopFileSizeKB)

<a href="#LV_ModifyCol" data-index="10">LV_ModifyCol</a>()  <em>; Auto-size each column to fit its contents.</em>
LV_ModifyCol(2, "Integer")  <em>; For sorting purposes, indicate that column 2 is an integer.</em>

<em>; Display the window and return. The script will be notified whenever the user double clicks a row.</em>
Gui, Show
return

MyListView:
if (A_GuiEvent = "DoubleClick")
{
    <a href="#LV_GetText" data-index="11">LV_GetText</a>(RowText, A_EventInfo)  <em>; Get the text from the row's first field.</em>
    ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
}
return

GuiClose:  <em>; Indicate that the script should exit automatically when the window is closed.</em>
ExitApp
```

## Options and Styles for the Options Parameter

**AltSubmit:** Notifies the script for more types of ListView events than normal. In other words, the g-label is launched more often. See [ListView Notifications](#notify) for details.

**Background:** Specify the word Background followed immediately by a color name (see [color chart](Progress.htm#colors)) or RGB value (the 0x prefix is optional). Examples: `BackgroundSilver`, `BackgroundFFDD99`. If this option is not present, the ListView initially defaults to the background color set by the last parameter of [Gui Color](Gui.htm#Color) (or if none, the system's default background color). Specifying `BackgroundDefault` applies the system's default background color (usually white). For example, a ListView can be restored to the default color via `GuiControl, +BackgroundDefault, MyListView`.

**C**: Text color. Specify the letter C followed immediately by a color name (see [color chart](Progress.htm#colors)) or RGB value (the 0x prefix is optional). Examples: `cRed`, `cFF2211`, `c0xFF2211`, `cDefault`.

**Checked:** Provides a checkbox at the left side of each row. When [adding](#LV_Add) a row, specify the word _Check_ in its options to have the box to start off checked instead of unchecked. The user may either click the checkbox or press the spacebar to check or uncheck a row.

**Count:** Specify the word Count followed immediately by the total number of rows that the ListView will ultimately contain. This is not a limit: rows beyond the count can still be added. Instead, this option serves as a hint to the control that allows it to allocate memory only once rather than each time a row is added, which greatly improves row-adding performance (it may also improve sorting performance). To improve performance even more, use `GuiControl, -Redraw, MyListView` prior to adding a large number of rows. Afterward, use `GuiControl, +Redraw, MyListView` to re-enable redrawing (which also repaints the control).

**Grid:** Provides horizontal and vertical lines to visually indicate the boundaries between rows and columns.

**Hdr:** Specify `-Hdr` (minus Hdr) to omit the header (the special top row that contains column titles). To make it visible later, use `GuiControl, +Hdr, MyListView`.

**LV:** Specify the string LV followed immediately by the number of an [extended ListView style](../misc/Styles.htm#LVS_EX). These styles are entirely separate from generic extended styles. For example, specifying `<strong>-E</strong>0x200` would remove the generic extended style WS\_EX\_CLIENTEDGE to eliminate the control's default border. By contrast, specifying `<strong>-LV</strong>0x20` would remove [LVS\_EX\_FULLROWSELECT](#frs).

**LV0x10**: Specify `-LV0x10` to prevent the user from dragging column headers to the left or right to reorder them. However, it is usually not necessary to do this because the physical reordering of columns does not affect the column order seen by the script. For example, the first column will always be column 1 from the script's point of view, even if the user has physically moved it to the right of other columns.

**LV0x20**: Specify `-LV0x20` to require that a row be clicked at its first field to select it (normally, a click on _any_ field will select it). The advantage of this is that it makes it easier for the user to drag a rectangle around a group of rows to select them.

**Multi:** Specify `-Multi` (minus Multi) to prevent the user from selecting more than one row at a time.

**NoSortHdr:** Prevents the header from being clickable. It will take on a flat appearance rather than its normal button-like appearance. Unlike most other ListView styles, this one cannot be changed after the ListView is created.

**NoSort:** Turns off the automatic sorting that occurs when the user clicks a column header. However, the header will still behave visually like a button (unless NoSortHdr has been specified). In addition, the g-label will still receive the [ColClick notification](#ColClick), to which it can respond with a custom sort or other action.

**ReadOnly:** Specify `-ReadOnly` (minus ReadOnly) to allow editing of the text in the first column of each row. To edit a row, select it then press F2 (see the [WantF2](#WantF2) option below). Alternatively, you can click a row once to select it, wait at least half a second, then click the same row again to edit it.

**R**: Rows of height (upon creation). Specify the letter R followed immediately by the number of rows for which to make room inside the control. For example, `R10` would make the control 10 rows tall. If the ListView is created with a [view mode](#View) other than report view, the control is sized to fit rows of icons instead of rows of text. Note: adding [icons](#IL) to a ListView's rows will increase the height of each row, which will make this option inaccurate.

**Sort:** The control is kept alphabetically sorted according to the contents of the first column.

**SortDesc:** Same as above except in descending order.

**WantF2**[v1.0.44+]: Specify `-WantF2` (minus WantF2) to prevent F2 from [editing](#ReadOnly) the currently focused row. This setting is ignored unless `-<a href="#ReadOnly" data-index="24">ReadOnly</a>` is also in effect. Regardless of this setting, the g-label still receives F2 [notifications](#NotifyK).

**(Unnamed numeric styles):** Since styles other than the above are rarely used, they do not have names. See the [ListView styles table](../misc/Styles.htm#ListView) for a list.

## View Modes

A ListView has five viewing modes, of which the most common is report view (which is the default). To use one of the other views, specify its name in the options list. The view can also be changed after the control is created; for example: `GuiControl, +IconSmall, MyListView`.

**Icon:** Shows a large-icon view. In this view and all the others except _Report_, the text in columns other than the first is not visible. To display icons in this mode, the ListView must have a large-icon [ImageList](#IL) assigned to it.

**Tile**: Shows a large-icon view but with ergonomic differences such as displaying each item's text to the right of the icon rather than underneath it. [Checkboxes](#Checked) do not function in this view. Also, attempting to show this view on operating systems older than Windows XP has no effect.

**IconSmall:** Shows a small-icon view.

**List:** Shows a small-icon view in list format, which displays the icons in columns. The number of columns depends on the width of the control and the width of the widest text item in it.

**Report:** Switches back to report view, which is the initial default. For example: `GuiControl, +Report, MyListView`.

## Built-in Functions for ListViews

All of the ListView functions operate upon the current thread's [default GUI window](Gui.htm#DefaultWin) (which can be changed via `<a href="Gui.htm#Default" data-index="30">Gui, 2:Default</a>`). If the default window does not exist or has no ListView controls, all functions return zero to indicate the problem.

If the window has more than one ListView control, by default the functions operate upon the one most recently added. To change this, specify `Gui, ListView, ListViewName`, where _ListViewName_ is the name of the ListView's [associated variable](Gui.htm#var), its ClassNN as shown by Window Spy or [in v1.1.04+] its HWND. Once changed, all existing and future [threads](../misc/Threads.htm) will use the indicated ListView. [v1.1.23+]: [A\_DefaultListView](../Variables.htm#DefaultListView) contains the current setting.

When the phrase "row number" is used on this page, it refers to a row's current position within the ListView. The top row is 1, the second row is 2, and so on. After a row is added, its row number tends to change due to sorting, deleting, and inserting of other rows. Therefore, to locate specific row(s) based on their contents, it is usually best to use [LV\_GetText()](#LV_GetText) in a loop.

**Row functions:**

- [LV\_Add](#LV_Add): Adds a new row to the bottom of the list.
- [LV\_Insert](#LV_Insert): Inserts a new row at the specified row number.
- [LV\_Modify](#LV_Modify): Modifies the attributes and/or text of a row.
- [LV\_Delete](#LV_Delete): Deletes the specified row or all rows.

**Column functions:**

- [LV\_ModifyCol](#LV_ModifyCol): Modifies the attributes and/or text of the specified column and its header.
- [LV\_InsertCol](#LV_InsertCol): Inserts a new column at the specified column number.
- [LV\_DeleteCol](#LV_DeleteCol): Deletes the specified column and all of the contents beneath it.

**Retrieval functions:**

- [LV\_GetCount](#LV_GetCount): Returns the total number of rows or columns.
- [LV\_GetNext](#LV_GetNext): Returns the row number of the next selected, checked, or focused row.
- [LV\_GetText](#LV_GetText): Retrieves the text at the specified row and column.

**Other functions:**

- [LV\_SetImageList](#LV_SetImageList): Sets or replaces an ImageList for displaying icons.

### LV\_Add

Adds a new row to the bottom of the list.

```
<span class="func">LV_Add</span>(<span class="optional">Options, Field1, Field2, ...</span>)
```

The parameters _Field1_ and beyond are the columns of the new row, which can be text or numeric (including numeric [expression](../Variables.htm#Expressions) results). To make any field blank, specify "" or the equivalent. If there are too few fields to fill all the columns, the columns at the end are left blank. If there are too many fields, the fields at the end are completely ignored.

Upon failure, LV\_Add() returns 0. Upon success, it returns the new [row number](#RowNumber), which is not necessarily the last row if the ListView has the [Sort](#Sort) or [SortDesc](#SortDesc) style.

#### Row Options

The _Options_ parameter is a string containing zero or more words from the list below (not case sensitive). Separate each word from the next with a space or tab. To remove an option, precede it with a minus sign. To add an option, a plus sign is permitted but not required.

**Check**: Shows a checkmark in the row (if the ListView has [checkboxes](#Checked)). To later uncheck it, use `LV_Modify(RowNumber, "-Check")`.

**Col**: Specify the word Col followed immediately by the column number at which to begin applying the parameters _Col1_ and beyond. This is most commonly used with [LV\_Modify()](#LV_Modify) to alter individual fields in a row without affecting those that lie to their left.

**Focus**: Sets keyboard focus to the row (often used in conjunction with Select). To later de-focus it, use `LV_Modify(RowNumber, "-Focus")`.

**Icon**: Specify the word Icon followed immediately by the number of this row's icon, which is displayed in the left side of the first column. If this option is absent, the first icon in the [ImageList](#IL) is used. To display a blank icon, specify -1 or a number that is larger than the number of icons in the ImageList. If the control lacks a small-icon ImageList, no icon is displayed nor is any space reserved for one in [report view](#View).

This option accepts a one-based icon number, but this is internally translated to a zero-based index; therefore, `Icon0` corresponds to the constant [I\_IMAGECALLBACK](https://docs.microsoft.com/en-us/windows/win32/controls/list-view-controls-overview#callback-items-and-the-callback-mask), which is normally defined as -1, and `Icon-1` corresponds to I\_IMAGENONE. Other out of range values may also cause a blank space where the icon would be.

**Select**: Selects the row. To later deselect it, use `LV_Modify(RowNumber, "-Select")`. When selecting rows, it is usually best to ensure that at least one row always has the [focus property](#Focus) because that allows the Apps key to display its [context menu](Gui.htm#GuiContextMenu) (if any) near the focused row. The word _Select_ may optionally be followed immediately by a 0 or 1 to indicate the starting state. In other words, both `"Select"` and `"Select" <strong>.</strong> VarContainingOne` are the same (the period used here is the [concatenation operator](../Variables.htm#concat)). This technique also works with _Focus_ and _Check_ above.

**Vis**[v1.0.44+]: Ensures that the specified row is completely visible by scrolling the ListView, if necessary. This has an effect only for [LV\_Modify()](#LV_Modify); for example: `LV_Modify(RowNumber, "Vis")`.

### LV\_Insert

Inserts a new row at the specified row number.

```
<span class="func">LV_Insert</span>(RowNumber <span class="optional">, Options, Col1, Col2, ...</span>)
```

Behaves identically to [LV\_Add()](#LV_Add) except for its different first parameter, which specifies the row number for the newly inserted row. Any rows at or beneath _RowNumber_ are shifted downward to make room for the new row. If _RowNumber_ is greater than the number of rows in the list (even as high as 2147483647), the new row is added to the end of the list. For _Options_, see [row options](#RowOptions).

### LV\_Modify

Modifies the attributes and/or text of a row.

```
<span class="func">LV_Modify</span>(RowNumber <span class="optional">, Options, NewCol1, NewCol2, ...</span>)
```

It returns 1 upon success and 0 upon failure. If _RowNumber_ is 0, all rows in the control are modified (in this case the function returns 1 on complete success and 0 if any part of the operation failed). When only the first two parameters are present, only the row's attributes and not its text are changed. Similarly, if there are too few parameters to cover all the columns, the columns at the end are not changed. The [ColN option](#ColN) may be used to update specific columns without affecting the others. For other options, see [row options](#RowOptions).

### LV\_Delete

Deletes the specified row or all rows.

```
<span class="func">LV_Delete</span>(<span class="optional">RowNumber</span>)
```

If the parameter is omitted, **all** rows in the ListView are deleted. Otherwise, only the specified _RowNumber_ is deleted. It returns 1 upon success and 0 upon failure.

### LV\_ModifyCol

Modifies the attributes and/or text of the specified column and its header.

```
<span class="func">LV_ModifyCol</span>(<span class="optional">ColumnNumber, Options, ColumnTitle</span>)
```

The first column is number 1 (not 0). If all parameters are omitted, the width of every column is adjusted to fit the contents of the rows. If only the first parameter is present, only the specified column is auto-sized. Auto-sizing has no effect when not in Report (Details) view. This function returns 1 upon success and 0 upon failure.

#### Column Options

The _Options_ parameter is a string containing zero or more words from the list below (not case sensitive). Separate each word from the next with a space or tab. To remove an option, precede it with a minus sign. To add an option, a plus sign is permitted but not required.

#### Column Options: General

**N**: Specify for N the new width of the column, in pixels. This number can be unquoted if is the only option. For example, the following are both valid: `LV_ModifyCol(1, 50)` and `LV_ModifyCol(1, "50 Integer")`.

**Auto**: Adjusts the column's width to fit its contents. This has no effect when not in Report (Details) view.

**AutoHdr**: Adjusts the column's width to fit its contents and the column's header text, whichever is wider. If applied to the last column, it will be made at least as wide as all the remaining space in the ListView. It is usually best to apply this setting only after the rows have been added because that allows any newly-arrived vertical scroll bar to be taken into account when sizing the last column. This option has no effect when not in Report (Details) view.

**Icon**: Specify the word Icon followed immediately by the number of the [ImageList's](#IL) icon to display next to the column header's text. Specify `-Icon` (minus icon) to remove any existing icon.

**IconRight**: Puts the icon on the right side of the column rather than the left.

#### Column Options: Data Type

**Float**: For sorting purposes, indicates that this column contains floating point numbers (hexadecimal format is not supported). Sorting performance for Float and Text columns is up to 25 times slower than it is for integers.

**Integer**: For sorting purposes, indicates that this column contains integers. To be sorted properly, each integer must be 32-bit; that is, within the range -2147483648 to 2147483647. If any of the values are not integers, they will be considered zero when sorting (unless they start with a number, in which case that number is used). Numbers may appear in either decimal or hexadecimal format (e.g. `0xF9E0`).

**Text**: Changes the column back to text-mode sorting, which is the initial default for every column. Only the first 8190 characters of text are significant for sorting purposes (except for the [_Logical_ option](#Logical), in which case the limit is 4094).

#### Column Options: Alignment

**Center**: Centers the text in the column. To center an Integer or Float column, specify the word Center after the word Integer or Float.

**Left**: Left-aligns the column's text, which is the initial default for every column. On older operating systems, the first column might have a forced left-alignment.

**Right**: Right-aligns the column's text. This attribute need not be specified for Integer and Float columns because they are right-aligned by default. That default can be overridden by specifying something such as `"Integer Left"` or `"Float Center"`.

#### Column Options: Sorting

**Case**: The sorting of the column is case sensitive (affects only [text](#Text) columns). If the options _Case_, _CaseLocale_, and _Logical_ are all omitted, the uppercase letters A-Z are considered identical to their lowercase counterparts for the purpose of the sort.

**CaseLocale**[v1.0.43.03+]: The sorting of the column is case insensitive based on the current user's locale (affects only [text](#Text) columns). For example, most English and Western European locales treat the letters A-Z and ANSI letters like Ä and Ü as identical to their lowercase counterparts. This method also uses a "word sort", which treats hyphens and apostrophes in such a way that words like "coop" and "co-op" stay together.

**Desc**: Descending order. The column starts off in descending order the first time the user sorts it.

**Logical**[v1.0.44.12+]: Same as _CaseLocale_ except that any sequences of digits in the text are treated as true numbers rather than mere characters. For example, the string "T33" would be considered greater than "T4". _Logical_ requires Windows XP or later (on older OSes, _CaseLocale_ is automatically used instead). In addition, _Logical_ and _Case_ are currently mutually exclusive: only the one most recently specified will be in effect.

**NoSort**: Prevents a user's click on this column from having any automatic sorting effect. To disable sorting for all columns rather than only a subset, include [NoSort](#NoSort) in the ListView's options. If the ListView has a g-label, the [ColClick notification](#ColClick) will still be received when the user clicks a no-sort column.

**Sort**: Immediately sorts the column in ascending order (even if it has the [Desc](#Desc) option).

**SortDesc**: Immediately sorts the column in descending order.

**Uni**: Unidirectional sort. This prevents a second click on the same column from reversing the sort direction.

### LV\_InsertCol

Inserts a new column at the specified column number.

```
<span class="func">LV_InsertCol</span>(ColumnNumber <span class="optional">, Options, ColumnTitle</span>)
```

Creates a new column, inserting it as the specified _ColumnNumber_ (shifting any other columns to the right to make room). The first column is 1 (not 0). If _ColumnNumber_ is larger than the number of columns currently in the control, the new column is added to the end of the list. The newly inserted column starts off with empty contents beneath it unless it is the first column, in which case it inherits the old first column's contents and the old first column acquires blank contents. The new column's attributes -- such as whether or not it uses [integer sorting](#Integer) \-\- always start off at their defaults unless changed via _[Options](#ColOptions)_. This function returns the new column's position number (or 0 upon failure). The maximum number of columns in a ListView is 200.

### LV\_DeleteCol

Deletes the specified column and all of the contents beneath it.

```
<span class="func">LV_DeleteCol</span>(ColumnNumber)
```

It returns 1 upon success and 0 upon failure. Once a column is deleted, the column numbers of any that lie to its right are reduced by 1. Consequently, calling `LV_DeleteCol(2)` twice would delete the second and third columns. On operating systems older than Windows XP, attempting to delete the original first column might fail and return 0.

### LV\_GetCount

Returns the total number of rows or columns, or the number of selected rows only.

```
<span class="func">LV_GetCount</span>(<span class="optional">Mode</span>)
```

When the parameter is omitted, the function returns the total number of rows in the control. When the parameter is "S" or "Selected", the count includes only the selected/highlighted rows. When the parameter is "Col" or "Column", the function returns the number of columns in the control. This function is always instantaneous because the control keeps track of these counts.

This function is often used in the top line of a Loop, in which case the function would get called only once (prior to the first iteration). For example:

```
Loop % LV_GetCount()
{
    LV_GetText(RetrievedText, A_Index)
    if InStr(RetrievedText, "some filter text")
        LV_Modify(A_Index, "Select")  <em>; Select each row whose first field contains the filter-text.</em>
}
```

To retrieve the widths of a ListView's columns -- for uses such as saving them to an INI file to be remembered between sessions -- follow this example:

```
Gui +LastFound
Loop % LV_GetCount("Column")
{
    SendMessage, 0x101D, A_Index - 1, 0, SysListView321  <em>; 0x101D is LVM_GETCOLUMNWIDTH.</em>
    MsgBox Column %A_Index%'s width is %ErrorLevel%.
}
```

### LV\_GetNext

Returns the row number of the next selected, checked, or focused row.

```
<span class="func">LV_GetNext</span>(<span class="optional">StartingRowNumber, RowType</span>)
```

If none is found, zero is returned. If _StartingRowNumber_ is omitted or less than 1, the search begins at the top of the list. Otherwise, the search begins at the row after _StartingRowNumber_. If _RowType_ is omitted, the function searches for the next selected/highlighted row. Otherwise, specify "C" or "Checked" to find the next checked row; or "F" or "Focused" to find the focused row (there is never more than one focused row in the entire list, and sometimes there is none at all). The following example reports all selected rows in the ListView:

```
RowNumber := 0  <em>; This causes the first loop iteration to start the search at the top of the list.</em>
Loop
{
    RowNumber := LV_GetNext(RowNumber)  <em>; Resume the search at the row after that found by the previous iteration.</em>
    if not RowNumber  <em>; The above returned zero, so there are no more selected rows.</em>
        break
    LV_GetText(Text, RowNumber)
    MsgBox The next selected row is #%RowNumber%, whose first field is "%Text%".
}
```

An alternate method to find out if a particular row number is checked is the following:

```
Gui +LastFound
SendMessage, 0x102C, <i>RowNumber</i> - 1, 0xF000, SysListView321  <em>; 0x102C is LVM_GETITEMSTATE. 0xF000 is LVIS_STATEIMAGEMASK.</em>
IsChecked := (ErrorLevel >> 12) - 1  <em>; This sets IsChecked to true if <i>RowNumber</i> is checked or false otherwise.</em>
```

### LV\_GetText

Retrieves the text at the specified _RowNumber_ and _ColumnNumber_ and stores it in _OutputVar_.

```
<span class="func">LV_GetText</span>(OutputVar, RowNumber <span class="optional">, ColumnNumber</span>)
```

If _ColumnNumber_ is omitted, it defaults to 1 (the text in the first column). If _RowNumber_ is 0, the column header text is retrieved. If the text is longer than 8191, only the first 8191 characters are retrieved. The function returns 1 upon success and 0 upon failure. Upon failure, _OutputVar_ is also made blank.

Column numbers seen by the script are not altered by any dragging and dropping of columns the user may have done. For example, the original first column is still number 1 even if the user drags it to the right of other columns.

### LV\_SetImageList

Sets or replaces an [ImageList](#IL) for displaying icons.

```
<span class="func">LV_SetImageList</span>(ImageListID <span class="optional">, IconType</span>)
```

This function is normally called prior to adding any rows to the ListView. It sets the [ImageList](#IL) whose icons will be displayed by the ListView's rows (and optionally, its columns). _ImageListID_ is the number returned from a previous call to [IL\_Create()](#IL_Create). If _IconType_ is omitted, the type of icons in the ImageList is detected automatically as large or small. Otherwise, specify 0 for large icons, 1 for small icons, and 2 for state icons (state icons are not yet directly supported, but they could be used via [SendMessage](PostMessage.htm)).

A ListView may have up to two ImageLists: small-icon and/or large-icon. This is useful when the script allows the user to switch to and from the large-icon view. To add more than one ImageList to a ListView, call LV\_SetImageList() a second time, specifying the _ImageListID_ of the second list. A ListView with both a large-icon and small-icon ImageList should ensure that both lists contain the icons in the same order. This is because the same ID number is used to reference both the large and small versions of a particular icon.

Although it is traditional for all [viewing modes](#View) except Icon and Tile to show small icons, this can be overridden by passing a large-icon list to LV\_SetImageList() and specifying 1 (small-icon) for the second parameter. This also increases the height of each row in the ListView to fit the large icon.

If successful, LV\_SetImageList() returns the _ImageListID_ that was previously associated with the ListView (or 0 if none). Any such detached ImageList should normally be destroyed via [IL\_Destroy(ImageListID)](#IL_Destroy).

## G-Label Notifications (Primary)

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user performs an action in the control. This subroutine may consult the built-in variables [A\_Gui](../Variables.htm#Gui) and [A\_GuiControl](../Variables.htm#GuiControl) to find out which window and ListView generated the event. More importantly, it may consult **A\_GuiEvent**, which contains one of the following strings or letters (for compatibility with future versions, a script should not assume these are the only possible values):

**DoubleClick**: The user has double-clicked within the control. The variable A\_EventInfo contains the focused row number. [LV\_GetNext()](#LV_GetNext) can be used to instead get the first _selected_ row number, which is 0 if the user double-clicked on empty space.

**R**: The user has _double-right_-clicked within the control. The variable A\_EventInfo contains the focused row number.

**ColClick**: The user has clicked a column header. The variable A\_EventInfo contains the column number, which is the original number assigned when the column was created; that is, it does not reflect any dragging and dropping of columns done by the user. One possible response to a column click is to sort by a hidden column (zero width) that contains data in a sort-friendly format (such as a YYYYMMDD integer date). Such a hidden column can mirror some other column that displays the same data in a more friendly format (such as MM/DD/YY). For example, a script could hide column 3 via `<a href="#LV_ModifyCol" data-index="82">LV_ModifyCol</a>(3, 0)`, then disable automatic sorting in the visible column 2 via `LV_ModifyCol(2, "NoSort")`. Then in response to the ColClick notification for column 2, the script would sort the ListView by the hidden column via `LV_ModifyCol(3, "Sort")`.

**D**: The user has attempted to start dragging a row or icon (there is currently no built-in support for dragging rows or icons). The variable A\_EventInfo contains the focused row number. [v1.0.44+]: This notification occurs even without [AltSubmit](#AltSubmit).

**d** (lowercase D): Same as above except a right-click-drag rather than a left-drag.

**e** (lowercase E): The user has finished editing the first field of a row (the user may edit it only when the ListView has `<a href="#ReadOnly" data-index="84"><strong>-</strong>ReadOnly</a>` in its options). The variable A\_EventInfo contains the row number.

## G-Label Notifications (Secondary)

If the ListView has the word AltSubmit in its [options](#Options), its g-label is launched more often and **A\_GuiEvent** may contain the following additional values:

**Normal**: The user has left-clicked a row. The variable A\_EventInfo contains the focused row number.

**RightClick**: The user has right-clicked a row. The variable A\_EventInfo contains the focused row number. In most cases, it is best not to display a menu in response to this. Instead, use the [GuiContextMenu label](Gui.htm#GuiContextMenu) because it also recognizes the Apps key. For example:

```
GuiContextMenu:  <em>; Launched in response to a right-click or press of the Apps key.</em>
if (A_GuiControl != "MyListView")  <em>; This check is optional. It displays the menu only for clicks inside the ListView.</em>
    return
<em>; Show the menu at the provided coordinates, A_GuiX and A_GuiY. These should be used
; because they provide correct coordinates even if the user pressed the Apps key:</em>
Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
return
```

**A**: A row has been activated, which by default occurs when it is double clicked. The variable A\_EventInfo contains the row number.

**C**: The ListView has released mouse capture.

**E**: The user has begun editing the first field of a row (the user may edit it only when the ListView has `-<a href="#ReadOnly" data-index="87">ReadOnly</a>` in its options). The variable A\_EventInfo contains the row number.

**F**: The ListView has received keyboard focus.

**f** (lowercase F): The ListView has lost keyboard focus.

**I**: Item changed. A row has changed by becoming selected/deselected, checked/unchecked, etc. If the user selects a new row, at least two such notifications are received: one for the de-selection of the previous row, and one for the selection of the new row. [v1.0.44+]: The variable A\_EventInfo contains the row number. [v1.0.46.10+]: ErrorLevel contains zero or more of the following letters to indicate how the item changed: S (select) or s (de-select), and/or F (focus) or f (de-focus), and/or C (checkmark) or c (uncheckmark). For example, SF means that the row has been selected and focused. To detect whether a particular letter is present, use a [parsing loop](LoopParse.htm) or the case-sensitive option of [InStr()](InStr.htm); for example: `InStr(ErrorLevel, "S", true)`. Note: For compatibility with future versions, a script should not assume that "SsFfCc" are the only possible letters. Also, specifying [Critical](Critical.htm) as the [g-label](Gui.htm#label)'s first line ensures that all "I" notifications are received (otherwise, some might be lost if the script cannot keep up with them).

**K**: The user has pressed a key while the ListView has focus. A\_EventInfo contains the virtual key code of the key, which is a number between 1 and 255. This can be translated to a key name or character via [GetKeyName()](GetKey.htm). For example, `key := GetKeyName(<a href="Format.htm" data-index="93">Format</a>("vk{:x}", A_EventInfo))`. On most keyboard layouts, keys A-Z can be translated to the corresponding character via `<a href="Chr.htm" data-index="94">Chr</a>(A_EventInfo)`. F2 is received regardless of [WantF2](#WantF2). However, Enter is not received; to receive it, use a default button as described [below](#Enter).

**M**: Marquee. The user has started to drag a selection-rectangle around a group of rows or icons.

**S**: The user has begun scrolling the ListView.

**s** (lowercase S): The user has finished scrolling the ListView.

## ImageLists

An Image-List is a group of identically sized icons stored in memory. Upon creation, each ImageList is empty. The script calls [IL\_Add()](#IL_Add) repeatedly to add icons to the list, and each icon is assigned a sequential number starting at 1. This is the number to which the script refers to display a particular icon in a row or column header. Here is a working example that demonstrates how to put icons into a ListView's rows:

```
Gui, Add, ListView, h200 w180, Icon & Number|Description  <em>; Create a ListView.</em>
ImageListID := <a href="#IL_Create" data-index="98">IL_Create</a>(10)  <em>; Create an ImageList to hold 10 small icons.</em>
<a href="#LV_SetImageList" data-index="99">LV_SetImageList</a>(ImageListID)  <em>; Assign the above ImageList to the current ListView.</em>
Loop 10  <em>; Load the ImageList with a series of icons from the DLL.</em>
    <a href="#IL_Add" data-index="100">IL_Add</a>(ImageListID, "shell32.dll", A_Index)
Loop 10  <em>; Add rows to the ListView (for demonstration purposes, one for each icon).</em>
    LV_Add("Icon" . A_Index, A_Index, "n/a")
LV_ModifyCol("Hdr")  <em>; Auto-adjust the column widths.</em>
Gui Show
return

GuiClose:  <em>; Exit the script when the user closes the ListView's GUI window.</em>
ExitApp
```

### IL\_Create

Creates a new ImageList, initially empty, and returns the unique ID of the ImageList (or 0 upon failure).

```
<span class="func">IL_Create</span>(<span class="optional">InitialCount, GrowCount, LargeIcons</span>)
```

_InitialCount_ is the number of icons you expect to put into the list immediately (if omitted, it defaults to 2). _GrowCount_ is the number of icons by which the list will grow each time it exceeds the current list capacity (if omitted, it defaults to 5). _LargeIcons_ should be a numeric value: If non-zero, the ImageList will contain large icons. If zero, it will contain small icons (this is the default when omitted). Icons added to the list are scaled automatically to conform to the system's dimensions for small and large icons.

### IL\_Add

Adds an icon or picture to the specified _ImageListID_ and returns the new icon's index (1 is the first icon, 2 is the second, and so on).

```
<span class="func">IL_Add</span>(ImageListID, Filename <span class="optional">, IconNumber, ResizeNonIcon</span>)
```

_Filename_ is the name of an icon (.ICO), cursor (.CUR), or animated cursor (.ANI) file (animated cursors will not actually be animated when displayed in a ListView). Other sources of icons include the following types of files: EXE, DLL, CPL, SCR, and other types that contain icon resources. To use an icon group other than the first one in the file, specify its number for _IconNumber_. If _IconNumber_ is negative, its absolute value is assumed to be the resource ID of an icon within an executable file. In the following example, the default icon from the second icon group would be used: `IL_Add(ImageListID, "C:\My Application.exe", 2)`.

Non-icon images such as BMP, GIF and JPG may also be loaded. However, in this case the last two parameters should be specified to ensure correct behavior: _IconNumber_ should be the mask/transparency color number (0xFFFFFF [the color white] might be best for most pictures); and _ResizeNonIcon_ should be non-zero to cause the picture to be scaled to become a single icon, or zero to divide up the image into however many icons can fit into its actual width.

All operating systems support GIF, JPG, BMP, ICO, CUR, and ANI images. On Windows XP or later, additional image formats such as PNG, TIF, Exif, WMF, and EMF are supported. Operating systems older than XP can be given support by copying Microsoft's free GDI+ DLL into the AutoHotkey.exe folder (but in the case of a [compiled script](../Scripts.htm#ahk2exe), copy the DLL into the script's folder). To download the DLL, search for the following phrase at [www.microsoft.com](https://www.microsoft.com): gdi redistributable

[v1.1.23+]: A [bitmap or icon handle](../misc/ImageHandles.htm) can be used instead of a filename. For example, `HBITMAP:%handle%`.

### IL\_Destroy

Deletes the specified ImageList and returns 1 upon success and 0 upon failure.

```
<span class="func">IL_Destroy</span>(ImageListID)
```

It is normally not necessary to destroy ImageLists because once attached to a ListView, they are destroyed automatically when the ListView or its parent window is destroyed. However, if the ListView shares ImageLists with other ListViews (by having `0x40` in its options), the script should explicitly destroy the ImageList after destroying all the ListViews that use it. Similarly, if the script replaces one of a ListView's old ImageLists with a new one, it should explicitly destroy the old one.

## Remarks

The [Gui Submit](Gui.htm#Submit) command has no effect on a ListView control. Therefore, the script may use the ListView's [associated variable](Gui.htm#var) (if any) to store other data without concern that it will ever be overwritten.

After a column is sorted -- either by means of the user clicking its header or the script calling `<a href="#LV_ModifyCol" data-index="106">LV_ModifyCol</a>(1, "Sort")` \-\- any subsequently added rows will appear at the bottom of the list rather than obeying the sort order. The exception to this is the [Sort](#Sort) and [SortDesc](#SortDesc) styles, which move newly added rows into the correct positions.

To detect when the user has pressed Enter while a ListView has focus, use a [default button](GuiControls.htm#DefaultButton) (which can be hidden if desired). For example:

```
Gui, Add, Button, Hidden Default, OK
...
ButtonOK:
GuiControlGet, FocusedControl, FocusV
if (FocusedControl != "MyListView")
    return
MsgBox % "Enter was pressed. The focused row number is " . LV_GetNext(0, "Focused")
return
```

In addition to navigating from row to row with the keyboard, the user may also perform incremental search by typing the first few characters of an item in the first column. This causes the selection to jump to the nearest matching row.

Although any length of text can be stored in each field of a ListView, only the first 260 characters are displayed.

Although the maximum number of rows in a ListView is limited only by available system memory, row-adding performance can be greatly improved as described in the [Count](#Count) option.

A picture may be used as a background around a ListView (that is, to frame the ListView). To do this, create the [picture control](GuiControls.htm#Picture) after the ListView and include `0x4000000` (which is WS\_CLIPSIBLINGS) in the picture's _Options_.

A script may create more than one ListView per window. To operate upon a ListView other than the default one, see [built-in functions](#BuiltIn).

It is best not to insert or delete columns directly with [SendMessage](PostMessage.htm). This is because the program maintains a collection of [sorting preferences](#Integer) for each column, which would then get out of sync. Instead, use the [built-in column functions](#BuiltIn).

To perform actions such as resizing, hiding, or changing the font of a ListView, use [GuiControl](GuiControl.htm).

To extract text from external ListViews (those not owned by the script), use [ControlGet List](ControlGet.htm#List).

## Related

[TreeView](TreeView.htm), [Other Control Types](GuiControls.htm), [Gui](Gui.htm), [GuiContextMenu](Gui.htm#GuiContextMenu), [GuiControl](GuiControl.htm), [GuiControlGet](GuiControlGet.htm), [ListView styles table](../misc/Styles.htm#ListView)

## Examples

Selects or de-selects all rows by specifying 0 as the row number.

```
<a href="#LV_Modify" data-index="126">LV_Modify</a>(0, "Select")   <em>; Select all.</em>
LV_Modify(0, "-Select")  <em>; De-select all.</em>
LV_Modify(0, "-Check")  <em>; Uncheck all the <a href="#Checked" data-index="127">checkboxes</a>.</em>
```

Auto-sizes all columns to fit their contents.

```
<a href="#LV_ModifyCol" data-index="129">LV_ModifyCol</a>()  <em>; There are no parameters in this mode.</em>
```

The following is a working script that is more elaborate than the one near the top of this page. It displays the files in a folder chosen by the user, with each file assigned the icon associated with its type. The user can double-click a file, or right-click one or more files to display a context menu.

```
<em>; Allow the user to maximize or drag-resize the window:</em>
Gui +Resize

<em>; Create some buttons:</em>
Gui, Add, Button, Default gButtonLoadFolder, Load a folder
Gui, Add, Button, x+20 gButtonClear, Clear List
Gui, Add, Button, x+20, Switch View

<em>; Create the ListView and its columns via <a href="#GuiAdd" data-index="131">Gui Add</a>:</em>
Gui, Add, ListView, xm r20 w700 vMyListView gMyListView, Name|In Folder|Size (KB)|Type
<a href="#LV_ModifyCol" data-index="132">LV_ModifyCol</a>(3, "Integer")  <em>; For sorting, indicate that the Size column is an integer.</em>

<em>; Create an ImageList so that the ListView can display some icons:</em>
ImageListID1 := <a href="#IL_Create" data-index="133">IL_Create</a>(10)
ImageListID2 := IL_Create(10, 10, true)  <em>; A list of large icons to go with the small ones.</em>

<em>; Attach the ImageLists to the ListView so that it can later display the icons:</em>
<a href="#LV_SetImageList" data-index="134">LV_SetImageList</a>(ImageListID1)
LV_SetImageList(ImageListID2)

<em>; Create a popup menu to be used as the context menu:</em>
<a href="Menu.htm" data-index="135">Menu</a>, MyContextMenu, Add, Open, ContextOpenFile
Menu, MyContextMenu, Add, Properties, ContextProperties
Menu, MyContextMenu, Add, Clear from ListView, ContextClearRows
Menu, MyContextMenu, Default, Open  <em>; Make "Open" a bold font to indicate that double-click does the same thing.</em>

<em>; Display the window and return. The OS will notify the script whenever the user
; performs an eligible action:</em>
Gui, Show
return

ButtonLoadFolder:
Gui +OwnDialogs  <em>; Forces user to dismiss the following dialog before using main window.</em>
FileSelectFolder, Folder,, 3, Select a folder to read:
if not Folder  <em>; The user canceled the dialog.</em>
    return

<em>; Check if the last character of the folder name is a backslash, which happens for root
; directories such as C:\. If it is, remove it to prevent a double-backslash later on.</em>
LastChar := SubStr(Folder, 0)
if (LastChar = "\")
    Folder := SubStr(Folder, 1, -1)  <em>; Remove the trailing backslash.</em>

<em>; Calculate buffer size required for SHFILEINFO structure.</em>
sfi_size := A_PtrSize + 8 + (A_IsUnicode ? 680 : 340)
VarSetCapacity(sfi, sfi_size)

<em>; Gather a list of file names from the selected folder and append them to the ListView:</em>
GuiControl, -Redraw, MyListView  <em>; Improve performance by disabling redrawing during load.</em>
Loop %Folder%\*.*
{
    FileName := A_LoopFileFullPath  <em>; Must save it to a writable variable for use below.</em>

    <em>; Build a unique extension ID to avoid characters that are illegal in variable names,</em>
    <em>; such as dashes. This unique ID method also performs better because finding an item</em>
    <em>; in the array does not require search-loop.</em>
    SplitPath, FileName,,, FileExt  <em>; Get the file's extension.</em>
    if FileExt in EXE,ICO,ANI,CUR
    {
        ExtID := FileExt  <em>; Special ID as a placeholder.</em>
        IconNumber := 0  <em>; Flag it as not found so that these types can each have a unique icon.</em>
    }
    else  <em>; Some other extension/file-type, so calculate its unique ID.</em>
    {
        ExtID := 0  <em>; Initialize to handle extensions that are shorter than others.</em>
        Loop 7     <em>; Limit the extension to 7 characters so that it fits in a 64-bit value.</em>
        {
            ExtChar := SubStr(FileExt, A_Index, 1)
            if not ExtChar  <em>; No more characters.</em>
                break
            <em>; Derive a Unique ID by assigning a different bit position to each character:</em>
            ExtID := ExtID | (Asc(ExtChar) << (8 * (A_Index - 1)))
        }
        <em>; Check if this file extension already has an icon in the ImageLists. If it does,</em>
        <em>; several calls can be avoided and loading performance is greatly improved,</em>
        <em>; especially for a folder containing hundreds of files:</em>
        IconNumber := IconArray%ExtID%
    }
    if not IconNumber  <em>; There is not yet any icon for this extension, so load it.</em>
    {
        <em>; Get the high-quality small-icon associated with this file extension:</em>
        if not DllCall("Shell32\SHGetFileInfo" . (A_IsUnicode ? "W":"A"), "Str", FileName
            , "UInt", 0, "Ptr", &sfi, "UInt", sfi_size, "UInt", 0x101)  <em>; 0x101 is SHGFI_ICON+SHGFI_SMALLICON</em>
            IconNumber := 9999999  <em>; Set it out of bounds to display a blank icon.</em>
        else <em>; Icon successfully loaded.</em>
        {
            <em>; Extract the hIcon member from the structure:</em>
            hIcon := NumGet(sfi, 0)
            <em>; Add the HICON directly to the small-icon and large-icon lists.</em>
            <em>; Below uses +1 to convert the returned index from zero-based to one-based:</em>
            IconNumber := DllCall("ImageList_ReplaceIcon", "Ptr", ImageListID1, "Int", -1, "Ptr", hIcon) + 1
            DllCall("ImageList_ReplaceIcon", "Ptr", ImageListID2, "Int", -1, "Ptr", hIcon)
            <em>; Now that it's been copied into the ImageLists, the original should be destroyed:</em>
            DllCall("DestroyIcon", "Ptr", hIcon)
            <em>; Cache the icon to save memory and improve loading performance:</em>
            IconArray%ExtID% := IconNumber
        }
    }

    <em>; Create the new row in the ListView and assign it the icon number determined above:</em>
    <a href="#LV_Add" data-index="136">LV_Add</a>("Icon" . IconNumber, A_LoopFileName, A_LoopFileDir, A_LoopFileSizeKB, FileExt)
}
GuiControl, +Redraw, MyListView  <em>; Re-enable redrawing (it was disabled above).</em>
LV_ModifyCol()  <em>; Auto-size each column to fit its contents.</em>
LV_ModifyCol(3, 60) <em>; Make the Size column at little wider to reveal its header.</em>
return

ButtonClear:
<a href="#LV_Delete" data-index="137">LV_Delete</a>()  <em>; Clear the ListView, but keep icon cache intact for simplicity.</em>
return

ButtonSwitchView:
if not IconView
    GuiControl, +Icon, MyListView    <em>; Switch to icon view.</em>
else
    GuiControl, +Report, MyListView  <em>; Switch back to details view.</em>
IconView := not IconView             <em>; Invert in preparation for next time.</em>
return

MyListView:
if (A_GuiEvent = "DoubleClick")  <em>; There are many other possible values the script can check.</em>
{
    <a href="#LV_GetText" data-index="138">LV_GetText</a>(FileName, A_EventInfo, 1) <em>; Get the text of the first field.</em>
    LV_GetText(FileDir, A_EventInfo, 2)  <em>; Get the text of the second field.</em>
    Run %FileDir%\%FileName%,, UseErrorLevel
    if ErrorLevel
        MsgBox Could not open "%FileDir%\%FileName%".
}
return

<a href="Gui.htm#GuiContextMenu" data-index="139">GuiContextMenu</a>:  <em>; Launched in response to a right-click or press of the Apps key.</em>
if (A_GuiControl != "MyListView")  <em>; Display the menu only for clicks inside the ListView.</em>
    return
<em>; Show the menu at the provided coordinates, A_GuiX and A_GuiY. These should be used
; because they provide correct coordinates even if the user pressed the Apps key:</em>
Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
return

ContextOpenFile:  <em>; The user selected "Open" in the context menu.</em>
ContextProperties:  <em>; The user selected "Properties" in the context menu.
; For simplicitly, operate upon only the focused row rather than all selected rows:</em>
FocusedRowNumber := <a href="#LV_GetNext" data-index="140">LV_GetNext</a>(0, "F")  <em>; Find the focused row.</em>
if not FocusedRowNumber  <em>; No row is focused.</em>
    return
LV_GetText(FileName, FocusedRowNumber, 1) <em>; Get the text of the first field.</em>
LV_GetText(FileDir, FocusedRowNumber, 2)  <em>; Get the text of the second field.</em>
if InStr(A_ThisMenuItem, "Open")  <em>; User selected "Open" from the context menu.</em>
    Run %FileDir%\%FileName%,, UseErrorLevel
else  <em>; User selected "Properties" from the context menu.</em>
    Run Properties "%FileDir%\%FileName%",, UseErrorLevel
if ErrorLevel
    MsgBox Could not perform requested action on "%FileDir%\%FileName%".
return

ContextClearRows:  <em>; The user selected "Clear" in the context menu.</em>
RowNumber := 0  <em>; This causes the first iteration to start the search at the top.</em>
Loop
{
    <em>; Since deleting a row reduces the RowNumber of all other rows beneath it,</em>
    <em>; subtract 1 so that the search includes the same row number that was previously</em>
    <em>; found (in case adjacent rows are selected):</em>
    RowNumber := LV_GetNext(RowNumber - 1)
    if not RowNumber  <em>; The above returned zero, so there are no more selected rows.</em>
        break
    LV_Delete(RowNumber)  <em>; Clear the row from the ListView.</em>
}
return

GuiSize:  <em>; Expand or shrink the ListView in response to the user's resizing of the window.</em>
if (A_EventInfo = 1)  <em>; The window has been minimized. No action needed.</em>
    return
<em>; Otherwise, the window has been resized or maximized. Resize the ListView to match.</em>
GuiControl, Move, MyListView, % "W" . (A_GuiWidth - 20) . " H" . (A_GuiHeight - 40)
return

GuiClose:  <em>; When the window is closed, exit the script automatically:</em>
ExitApp
```

