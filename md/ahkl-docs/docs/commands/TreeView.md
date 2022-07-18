# TreeView [v1.0.44+]

## Table of Contents

- [Introduction and Simple Example](#Intro)
- [Options and Styles for the Options Parameter](#Options)
- [Built-in Functions for TreeViews](#BuiltIn)
- [G-Label Notifications](#notify)
- [Remarks](#Remarks)
- [Examples](#Examples)

## Introduction and Simple Example

A Tree-View displays a hierarchy of items by indenting child items beneath their parents. The most common example is Explorer's tree of drives and folders.

A TreeView usually looks like this:

![TreeView](../static/ctrl_treeview.png)

The syntax for creating a TreeView is:

```
<span class="func">Gui</span>, Add, TreeView, Options
```

Here is a working script that creates and displays a simple hierarchy of items:

```
Gui, Add, TreeView
<span class="red">P1</span> := <a href="#TV_Add" data-index="7">TV_Add</a>("First parent")
P1C1 := TV_Add("Parent 1's first child", <span class="red">P1</span>)  <em>; Specify P1 to be this item's parent.</em>
P2 := TV_Add("Second parent")
P2C1 := TV_Add("Parent 2's first child", P2)
P2C2 := TV_Add("Parent 2's second child", P2)
P2C2C1 := TV_Add("Child 2's first child", P2C2)

Gui, Show  <em>; Show the window and its TreeView.</em>
return

GuiClose:  <em>; Exit the script when the user closes the TreeView's GUI window.</em>
ExitApp
```

## Options and Styles for the Options Parameter

**AltSubmit:** Notifies the script for more types of TreeView events than normal. In other words, the g-label is launched more often. See [TreeView Notifications](#notify) for details.

**Background:** Specify the word Background followed immediately by a color name (see [color chart](Progress.htm#colors)) or RGB value (the 0x prefix is optional). Examples: `BackgroundSilver`, `BackgroundFFDD99`. If this option is not present, the TreeView initially defaults to the background color set by the last parameter of [Gui Color](Gui.htm#Color) (or if none, the system's default background color). Specifying `BackgroundDefault` applies the system's default background color (usually white). For example, a TreeView can be restored to the default color via `GuiControl, +BackgroundDefault, MyTreeView`.

**Buttons**: Specify `-Buttons` (minus Buttons) to avoid displaying a plus or minus button to the left of each item that has children.

**C**: Text color. Specify the letter C followed immediately by a color name (see [color chart](Progress.htm#colors)) or RGB value (the 0x prefix is optional). Examples: `cRed`, `cFF2211`, `c0xFF2211`, `cDefault`.

**Checked:** Provides a checkbox at the left side of each item. When [adding](#TV_Add) an item, specify the word _Check_ in its options to have the box to start off checked instead of unchecked. The user may either click the checkbox or press the spacebar to check or uncheck an item. To discover which items in a TreeView are currently checked, call [TV\_GetNext()](#TV_GetNext) or [TV\_Get()](#TV_Get).

**HScroll**: Specify `-HScroll` (minus HScroll) to disable horizontal scrolling in the control (in addition, the control will not display any horizontal scroll bar).

**ImageList**: This is the means by which icons are added to a TreeView. Specify the word _ImageList_ followed immediately by the ImageListID returned from a previous call to [IL\_Create()](ListView.htm#IL_Create). This option has an effect only when creating a TreeView (however, [TV\_SetImageList()](#TV_SetImageList) does not have this limitation). Here is a working example:

```
ImageListID := <a href="ListView.htm#IL_Create" data-index="17">IL_Create</a>(10)  <em>; Create an ImageList with initial capacity for 10 icons.</em>
Loop 10  <em>; Load the ImageList with some standard system icons.</em>
    <a href="ListView.htm#IL_Add" data-index="18">IL_Add</a>(ImageListID, "shell32.dll", A_Index)
Gui, Add, TreeView, ImageList%ImageListID%
<a href="#TV_Add" data-index="19">TV_Add</a>("Name of Item", 0, "Icon4")  <em>; Add an item to the TreeView and give it a folder icon.</em>
Gui Show
```

**Lines**: Specify `-Lines` (minus Lines) to avoid displaying a network of lines connecting parent items to their children. However, removing these lines also prevents the plus/minus buttons from being shown for top-level items.

**ReadOnly:** Specify `-ReadOnly` (minus ReadOnly) to allow editing of the text/name of each item. To edit an item, select it then press F2 (see the [WantF2](#WantF2) option below). Alternatively, you can click an item once to select it, wait at least half a second, then click the same item again to edit it. After being edited, an item can be alphabetically repositioned among its siblings via the following example:

```
Gui, Add, TreeView, -ReadOnly gMyTree  <em>; For gMyTree, see <a href="#notify" data-index="21">TreeView's g-label</a>.</em>
<em>; ...</em>
MyTree:
if (A_GuiEvent == "e")  <em>; The user has finished editing an item (use == for case sensitive comparison).</em>
    TV_Modify(TV_GetParent(A_EventInfo), "Sort")  <em>; This works even if the item has no parent.</em>
return
```

**R**: Rows of height (upon creation). Specify the letter R followed immediately by the number of rows for which to make room inside the control. For example, `R10` would make the control 10 items tall.

**WantF2**: Specify `-WantF2` (minus WantF2) to prevent F2 from [editing](#ReadOnly) the currently selected item. This setting is ignored unless [-ReadOnly](#ReadOnly) is also in effect. Regardless of this setting, the g-label still receives F2 [notifications](#NotifyK).

**(Unnamed numeric styles):** Since styles other than the above are rarely used, they do not have names. See the [TreeView styles table](../misc/Styles.htm#TreeView) for a list.

## Built-in Functions for TreeViews

All of the TreeView functions operate upon the current thread's [default GUI window](Gui.htm#DefaultWin) (which can be changed via `<a href="Gui.htm#Default" data-index="27">Gui, 2:Default</a>`). If the default window does not exist or has no TreeView controls, all functions return zero to indicate the problem.

If the window has more than one TreeView control, by default the functions operate upon the one most recently added. To change this, specify `Gui, TreeView, TreeViewName`, where _TreeViewName_ is the name of the TreeView's [associated variable](Gui.htm#var), its ClassNN as shown by Window Spy or [in v1.1.04+] its HWND. Once changed, all existing and future [threads](../misc/Threads.htm) will use the indicated TreeView. [v1.1.23+]: [A\_DefaultTreeView](../Variables.htm#DefaultTreeView) contains the current setting.

**Item functions:**

- [TV\_Add](#TV_Add): Adds a new item to the TreeView.
- [TV\_Modify](#TV_Modify): Modifies the attributes and/or name of an item.
- [TV\_Delete](#TV_Delete): Deletes the specified item or all items.

**Retrieval functions:**

- [TV\_GetSelection](#TV_GetSelection): Returns the selected item's ID number.
- [TV\_GetCount](#TV_GetCount): Returns the total number of items in the control.
- [TV\_GetParent](#TV_GetParent): Returns the specified item's parent as an item ID.
- [TV\_GetChild](#TV_GetChild): Returns the ID number of the specified item's first/top child.
- [TV\_GetPrev](#TV_GetPrev): Returns the ID number of the sibling above the specified item.
- [TV\_GetNext](#TV_GetNext): Returns the ID number of the next item below the specified item.
- [TV\_GetText](#TV_GetText): Retrieves the text/name of the specified item.
- [TV\_Get](#TV_Get): Returns the ID number of the specified item if it has the specified attribute.

**Other functions:**

- [TV\_SetImageList](#TV_SetImageList)[v1.1.02+]: Sets or replaces an ImageList for displaying icons.

### TV\_Add

Adds a new item to the TreeView and returns its unique Item ID number (or 0 upon failure).

```
<span class="func">TV_Add</span>(Name, <span class="optional">ParentItemID, Options</span>)
```

_Name_ is the displayed text of the item, which can be text or numeric (including numeric [expression](../Variables.htm#Expressions) results). _ParentItemID_ is the ID number of the new item's parent (omit it or specify 0 to add the item at the top level). When adding a large number of items, performance can be improved by using `GuiControl, -Redraw, MyTreeView` before adding the items, and `GuiControl, +Redraw, MyTreeView` afterward.

#### Options for TV\_Add() and TV\_Modify()

The _Options_ parameter is a string containing zero or more words from the list below (not case sensitive). Separate each word from the next with a space or tab. To remove an option, precede it with a minus sign. To add an option, a plus sign is permitted but not required.

**Bold**: Displays the item's name in a bold font. To later un-bold the item, use `TV_Modify(ItemID, "-Bold")`. [v1.1.30.01+]: The word _Bold_ may optionally be followed immediately by a 0 or 1 to indicate the starting state.

**Check**: Shows a checkmark to the left of the item (if the TreeView has [checkboxes](#Checked)). To later uncheck it, use `TV_Modify(ItemID, "-Check")`. The word _Check_ may optionally be followed immediately by a 0 or 1 to indicate the starting state. In other words, both `"Check"` and `"Check" <strong>.</strong> VarContainingOne` are the same (the period used here is the [concatenation operator](../Variables.htm#concat)).

**Expand**: Expands the item to reveal its children (if any). To later collapse the item, use `TV_Modify(ItemID, "-Expand")`. If there are no children, [TV\_Modify()](#TV_Modify) returns 0 instead of the item's ID. By contrast, [TV\_Add()](#TV_Add) marks the item as expanded in case children are added to it later. Unlike "Select" (below), expanding an item does not automatically expand its parent. Finally, the word _Expand_ may optionally be followed immediately by a 0 or 1 to indicate the starting state. In other words, both `"Expand"` and `"Expand" <strong>.</strong> VarContainingOne` are the same.

**First \| Sort \| N**: These options apply only to [TV\_Add()](#TV_Add). They specify the new item's position relative to its siblings (a _sibling_ is any other item on the same level). If none of these options is present, the new item is added as the last/bottom sibling. Otherwise, specify _First_ to add the item as the first/top sibling, or specify _Sort_ to insert it among its siblings in alphabetical order. If a plain integer ( **N**) is specified, it is assumed to be ID number of the sibling after which to insert the new item (if integer N is the only option present, it does not have to be enclosed in quotes).

**Icon**: Specify the word _Icon_ followed immediately by the number of this item's icon, which is displayed to the left of the item's name. If this option is absent, the first icon in the [ImageList](#ImageList) is used. To display a blank icon, specify a number that is larger than the number of icons in the ImageList. If the control lacks an ImageList, no icon is displayed nor is any space reserved for one.

**Select**: Selects the item. Since only one item at a time can be selected, any previously selected item is automatically de-selected. In addition, this option reveals the newly selected item by expanding its parent(s), if necessary. To find out the current selection, call [TV\_GetSelection()](#TV_GetSelection).

**Sort**: For [TV\_Modify()](#TV_Modify), this option alphabetically sorts the children of the specified item. To instead sort all top-level items, use `TV_Modify(0, "Sort")`. If there are no children, 0 is returned instead of the ID of the modified item.

**Vis**: Ensures that the item is completely visible by scrolling the TreeView and/or expanding its parent, if necessary.

**VisFirst**: Same as above except that the TreeView is also scrolled so that the item appears at the top, if possible. This option is typically more effective when used with [TV\_Modify()](#TV_Modify) than with [TV\_Add()](#TV_Add).

### TV\_Modify

Modifies the attributes and/or name of an item.

```
<span class="func">TV_Modify</span>(ItemID <span class="optional">, Options, NewName</span>)
```

It returns the item's own ID upon success or 0 upon failure (or partial failure). When only the first parameter is present, the specified item is [selected](#Select). When _NewName_ is omitted, the current name is left unchanged. For _Options_, see the list above.

### TV\_Delete

Deletes the specified item or all items.

```
<span class="func">TV_Delete</span>(<span class="optional">ItemID</span>)
```

If _ItemID_ is omitted, **all** items in the TreeView are deleted. Otherwise, only the specified _ItemID_ is deleted. It returns 1 upon success and 0 upon failure.

### TV\_GetSelection

Returns the selected item's ID number.

```
<span class="func">TV_GetSelection</span>()
```

### TV\_GetCount

Returns the total number of items in the control.

```
<span class="func">TV_GetCount</span>()
```

This function is always instantaneous because the control keeps track of the count.

### TV\_GetParent

Returns the specified item's parent as an item ID.

```
<span class="func">TV_GetParent</span>(ItemID)
```

Items at the top level have no parent and thus return 0.

### TV\_GetChild

Returns the ID number of the specified item's first/top child (or 0 if none).

```
<span class="func">TV_GetChild</span>(ParentItemID)
```

### TV\_GetPrev

Returns the ID number of the sibling above the specified item (or 0 if none).

```
<span class="func">TV_GetPrev</span>(ItemID)
```

### TV\_GetNext

Returns the ID number of the next item below the specified item (or 0 if none).

```
<span class="func">TV_GetNext</span>(<span class="optional">ItemID, ItemType</span>)
```

This has the following modes:

- When all parameters are omitted, it returns the ID number of the first/top item in the TreeView (or 0 if none).
- When only_ItemID_ is present, it returns the ID number of the sibling below the specified item (or 0 if none). If _ItemID_ is 0, it returns the ID number of the first/top item in the TreeView (or 0 if none).
- When_ItemType_ is "Full" or "F", the next item is retrieved regardless of its relationship to the specified item. This allows the script to easily traverse the entire tree, item by item. For example:


  ```
  ItemID := 0  <em>; Causes the loop's first iteration to start the search at the top of the tree.</em>
  Loop
  {
      ItemID := TV_GetNext(ItemID, "Full")  <em>; Replace "Full" with "Checked" to find all checkmarked items.</em>
      if not ItemID  <em>; No more items in tree.</em>
          break
      TV_GetText(ItemText, ItemID)
      MsgBox The next Item is %ItemID%, whose text is "%ItemText%".
  }
  ```

- When_ItemType_ is either "Check", "Checked", or "C", the same behavior as above is used except that any item without a checkmark is skipped over. This allows all checkmarked items in the TreeView to be retrieved, one by one.

### TV\_GetText

Retrieves the text/name of the specified _ItemID_ and stores it in _OutputVar_.

```
<span class="func">TV_GetText</span>(OutputVar, ItemID)
```

If the text is longer than 8191, only the first 8191 characters are retrieved. Upon success, the function returns the item's own ID. Upon failure, it returns 0 (and _OutputVar_ is also made blank).

### TV\_Get

Returns the ID number of the specified item if it has the specified attribute.

```
<span class="func">TV_Get</span>(ItemID, Attribute)
```

If the specified item has the specified attribute, its own _ItemID_ is returned. Otherwise, 0 is returned. For _Attribute_, specify "E", "Expand", or "Expanded" to determine if the item is currently [expanded](#Expand) (that is, its children are being displayed); specify "C", "Check", or "Checked" to determine if the item has a [checkmark](#Check); or specify "B" or "Bold" to determine if the item is currently [bold](#Bold) in font.

**Note:** Since an IF-statement sees any non-zero value as "true", the following two lines are functionally identical: `if TV_Get(ItemID, "Checked") = ItemID` and `if TV_Get(ItemID, "Checked")`.

### TV\_SetImageList [v1.1.02+]

Sets or replaces an [ImageList](#ImageList) for displaying icons.

```
<span class="func">TV_SetImageList</span>(ImageListID <span class="optional">, IconType</span>)
```

_ImageListID_ is the number returned from a previous call to [IL\_Create()](ListView.htm#IL_Create). _IconType_ is normally omitted, in which case it defaults to 0. Otherwise, specify 2 for state icons (which are not yet directly supported, but could be used via [SendMessage](PostMessage.htm)). If successful, TV\_SetImageList() returns the _ImageListID_ that was previously associated with the TreeView (or 0 if none). Any such detached ImageList should normally be destroyed via [IL\_Destroy(ImageListID)](ListView.htm#IL_Destroy).

## G-Label Notifications (Primary)

A [g-label](Gui.htm#label) such as `<strong>g</strong>MySubroutine` may be listed in the control's options. This would cause the _MySubroutine_ label to be launched automatically whenever the user performs an action in the control. This subroutine may consult the built-in variables [A\_Gui](../Variables.htm#Gui) and [A\_GuiControl](../Variables.htm#GuiControl) to find out which window and TreeView generated the event. More importantly, it may consult **A\_GuiEvent**, which contains one of the following strings or letters (for compatibility with future versions, a script should not assume these are the only possible values):

**DoubleClick**: The user has double-clicked an item. The variable A\_EventInfo contains the item ID.

**D**: The user has attempted to start dragging an item (there is currently no built-in support for this). The variable A\_EventInfo contains the item ID.

**d** (lowercase D): Same as above except a right-click-drag rather than a left-drag.

**e** (lowercase E): The user has finished editing an item (the user may edit items only when the TreeView has `-<a href="#ReadOnly" data-index="65">ReadOnly</a>` in its options). The variable A\_EventInfo contains the item ID.

**S**: A new item has been selected, either by the user or the script itself. The variable A\_EventInfo contains the newly selected item ID.

## G-Label Notifications (Secondary)

If the TreeView has the word AltSubmit in its [options](#Options), its g-label is launched more often and **A\_GuiEvent** may contain the following additional values:

**Normal**: The user has left-clicked an item. The variable A\_EventInfo contains the item ID.

**RightClick**: The user has right-clicked an item. The variable A\_EventInfo contains the item ID. In most cases, it is best not to display a menu in response to this. Instead, use the [GuiContextMenu label](Gui.htm#GuiContextMenu) because it also recognizes the Apps key. For example:

```
GuiContextMenu:  <em>; Launched in response to a right-click or press of the Apps key.</em>
if (A_GuiControl != "MyTreeView")  <em>; This check is optional. It displays the menu only for clicks inside the TreeView.</em>
    return
<em>; Show the menu at the provided coordinates, A_GuiX and A_GuiY. These should be used
; because they provide correct coordinates even if the user pressed the Apps key:</em>
Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
return
```

**E**: The user has begun editing an item (the user may edit items only when the TreeView has [-ReadOnly](#ReadOnly) in its options). The variable A\_EventInfo contains the item ID.

**F**: The TreeView has received keyboard focus.

**f** (lowercase F): The TreeView has lost keyboard focus.

**K**: The user has pressed a key while the TreeView has focus. A\_EventInfo contains the virtual key code of the key, which is a number between 1 and 255. If the key is alphabetic, on most keyboard layouts it can be translated to the corresponding character via `<a href="Chr.htm" data-index="69">Chr</a>(A_EventInfo)`. F2 is received regardless of [WantF2](#WantF2). However, Enter is not received; to receive it, use a default button as described [below](#Enter).

**+** (plus sign): An item has been expanded to reveal its children. The variable A\_EventInfo contains the item ID.

**-** (minus sign): An item has been collapsed to hide its children. The variable A\_EventInfo contains the item ID.

## Remarks

The [Gui Submit](Gui.htm#Submit) command has no effect on a TreeView control. Therefore, the script may use the TreeView's [associated variable](Gui.htm#var) (if any) to store other data without concern that it will ever be overwritten.

To detect when the user has pressed Enter while a TreeView has focus, use a [default button](GuiControls.htm#DefaultButton) (which can be hidden if desired). For example:

```
Gui, Add, Button, Hidden Default, OK
...
ButtonOK:
GuiControlGet, FocusedControl, FocusV
if (FocusedControl != "MyTreeView")
    return
MsgBox % "Enter was pressed. The selected item ID is " . TV_GetSelection()
return
```

In addition to navigating from item to item with the keyboard, the user may also perform incremental search by typing the first few characters of an item's name. This causes the selection to jump to the nearest matching item.

Although any length of text can be stored in each item of a TreeView, only the first 260 characters are displayed.

Although the theoretical maximum number of items in a TreeView is 65536, item-adding performance will noticeably decrease long before then. This can be alleviated somewhat by using the redraw tip described in [TV\_Add()](#TV_Add).

Unlike [ListViews](ListView.htm), a TreeView's ImageList is not automatically destroyed when the TreeView is destroyed. Therefore, a script should call [IL\_Destroy(ImageListID)](ListView.htm#IL_Destroy) after destroying a TreeView's window if the ImageList will not be used for anything else. However, this is not necessary if the script will soon be exiting because all ImageLists are automatically destroyed at that time.

A script may create more than one TreeView per window. To operate upon a TreeView other than the default one, see [built-in functions](#BuiltIn).

To perform actions such as resizing, hiding, or changing the font of a TreeView, use [GuiControl](GuiControl.htm).

Tree View eXtension (TVX) extends TreeViews to support moving, inserting and deleting. It is demonstrated at [www.autohotkey.com/forum/topic19021.html](https://www.autohotkey.com/forum/topic19021.html)

## Related

[ListView](ListView.htm), [Other Control Types](GuiControls.htm), [Gui](Gui.htm), [GuiContextMenu](Gui.htm#GuiContextMenu), [GuiControl](GuiControl.htm), [GuiControlGet](GuiControlGet.htm), [TreeView styles table](../misc/Styles.htm#TreeView)

## Examples

The following is a working script that is more elaborate than the one near the top of this page. It creates and displays a TreeView containing all folders in the all-users Start Menu. When the user selects a folder, its contents are shown in a ListView to the right (like Windows Explorer). In addition, a [StatusBar](GuiControls.htm#StatusBar) control shows information about the currently selected folder.

```
<em>; The following folder will be the root folder for the TreeView. Note that loading might take a long
; time if an entire drive such as C:\ is specified:</em>
TreeRoot := A_StartMenuCommon
TreeViewWidth := 280
ListViewWidth := A_ScreenWidth - TreeViewWidth - 30

<em>; Allow the user to maximize or drag-resize the window:</em>
Gui +Resize

<em>; Create an ImageList and put some standard system icons into it:</em>
ImageListID := <a href="ListView.htm#IL_Create" data-index="90">IL_Create</a>(5)
Loop 5
    <a href="ListView.htm#IL_Add" data-index="91">IL_Add</a>(ImageListID, "shell32.dll", A_Index)
<em>; Create a <a href="#GuiAdd" data-index="92">TreeView</a> and a ListView side-by-side to behave like Windows Explorer:</em>
Gui, Add, TreeView, vMyTreeView r20 w%TreeViewWidth% gMyTreeView <a href="#ImageList" data-index="93">ImageList</a>%ImageListID%
Gui, Add, ListView, vMyListView r20 w%ListViewWidth% x+10, Name|Modified

<em>; Set the ListView's column widths (this is optional):</em>
Col2Width := 70  <em>; Narrow to reveal only the YYYYMMDD part.</em>
LV_ModifyCol(1, ListViewWidth - Col2Width - 30)  <em>; Allows room for vertical scrollbar.</em>
LV_ModifyCol(2, Col2Width)

<em>; Create a <a href="GuiControls.htm#StatusBar" data-index="94">Status Bar</a> to give info about the number of files and their total size:</em>
Gui, Add, StatusBar
<a href="GuiControls.htm#SB_SetParts" data-index="95">SB_SetParts</a>(60, 85)  <em>; Create three parts in the bar (the third part fills all the remaining width).</em>

<em>; Add folders and their subfolders to the tree. Display the status in case loading takes a long time:</em>
SplashTextOn, 200, 25, TreeView and StatusBar Example, Loading the tree...
AddSubFoldersToTree(TreeRoot)
SplashTextOff

<em>; Display the window and return. The OS will notify the script whenever the user performs an eligible action:</em>
Gui, Show,, %TreeRoot%  <em>; Display the source directory (TreeRoot) in the title bar.</em>
return

AddSubFoldersToTree(Folder, ParentItemID = 0)
{
    <em>; This function adds to the TreeView all subfolders in the specified folder.</em>
    <em>; It also calls itself recursively to gather nested folders to any depth.</em>
    Loop %Folder%\*.*, 2  <em>; Retrieve all of Folder's sub-folders.</em>
        AddSubFoldersToTree(A_LoopFileFullPath, <a href="#TV_Add" data-index="96">TV_Add</a>(A_LoopFileName, ParentItemID, "Icon4"))
}

MyTreeView:  <em>; This subroutine handles user actions (such as clicking).</em>
if (A_GuiEvent != "S")  <em>; i.e. an event other than "select new tree item".</em>
    return  <em>; Do nothing.
; Otherwise, populate the ListView with the contents of the selected folder.
; First determine the full path of the selected folder:</em>
<a href="#TV_GetText" data-index="97">TV_GetText</a>(SelectedItemText, A_EventInfo)
ParentID := A_EventInfo
Loop  <em>; Build the full path to the selected folder.</em>
{
    ParentID := <a href="#TV_GetParent" data-index="98">TV_GetParent</a>(ParentID)
    if not ParentID  <em>; No more ancestors.</em>
        break
    TV_GetText(ParentText, ParentID)
    SelectedItemText := ParentText "\" SelectedItemText
}
SelectedFullPath := TreeRoot "\" SelectedItemText

<em>; Put the files into the ListView:</em>
LV_Delete()  <em>; Clear all rows.</em>
GuiControl, -Redraw, MyListView  <em>; Improve performance by disabling redrawing during load.</em>
FileCount := 0  <em>; Init prior to loop below.</em>
TotalSize := 0
Loop %SelectedFullPath%\*.*  <em>; For simplicity, this omits folders so that only files are shown in the ListView.</em>
{
    LV_Add("", A_LoopFileName, A_LoopFileTimeModified)
    FileCount += 1
    TotalSize += A_LoopFileSize
}
GuiControl, +Redraw, MyListView

<em>; Update the three parts of the status bar to show info about the currently selected folder:</em>
<a href="GuiControls.htm#SB_SetText" data-index="99">SB_SetText</a>(FileCount . " files", 1)
SB_SetText(Round(TotalSize / 1024, 1) . " KB", 2)
SB_SetText(SelectedFullPath, 3)
return

GuiSize:  <em>; Expand/shrink the ListView and TreeView in response to user's resizing of window.</em>
if (A_EventInfo = 1)  <em>; The window has been minimized. No action needed.</em>
    return
<em>; Otherwise, the window has been resized or maximized. Resize the controls to match.</em>
GuiControl, Move, MyTreeView, % "H" . (A_GuiHeight - 30)  <em>; -30 for StatusBar and margins.</em>
GuiControl, Move, MyListView, % "H" . (A_GuiHeight - 30) . " W" . (A_GuiWidth - TreeViewWidth - 30)
return

GuiClose:  <em>; Exit the script when the user closes the TreeView's GUI window.</em>
ExitApp
```

