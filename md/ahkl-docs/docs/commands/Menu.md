# Menu

Creates, deletes, modifies and displays menus and menu items. Changes the tray icon and its tooltip. Controls whether the main window of a [compiled script](../Scripts.htm#ahk2exe) can be opened.

```
<span class="func">Menu</span>, MenuName, <a href="#SubCommands" data-index="2">SubCommand</a> <span class="optional">, Value1, Value2, Value3, Value4</span>
```

The _MenuName_ parameter can be `Tray` or the name of any custom menu. A custom menu is automatically created the first time its name is used with the [Add](#Add) sub-command. For example: `Menu, MyMenu, Add, Item1`. Once created, a custom menu can be displayed with the [Show](#Show) sub-command. It can also be attached as a submenu to one or more other menus via the [Add](#Add) sub-command.

The _SubCommand_, _Value1_, _Value2_, _Value3_ and _Value4_ parameters are dependent on each other their usage is described below.

## Table of Contents

- [Sub-commands](#SubCommands)
- [The _MenuItemName_ Parameter](#MenuItemName)
- [Win32 Menus](#Win32_Menus)
- [Remarks](#Remarks)
- [Related](#Related)
- [Examples](#Examples)

## Sub-commands

For _SubCommand_, specify one of the following:

- [Add](#Add): Adds a menu item, updates one with a new submenu or label, or converts one from a normal item into a submenu (or vice versa).
- [Insert](#Insert)[v1.1.23+]: Inserts a new item before the specified menu item.
- [Delete](#Delete): Deletes the specified menu item from the menu.
- [DeleteAll](#DeleteAll): Deletes all custom menu items from the menu.
- [Rename](#Rename): Renames the specified menu item.
- [Check](#Check): Adds a visible checkmark in the menu next to the specified menu item.
- [Uncheck](#Uncheck): Removes the checkmark from the specified menu item.
- [ToggleCheck](#ToggleCheck): Adds a checkmark to the specified menu item; otherwise, removes it.
- [Enable](#Enable): Enables the specified menu item if was previously disabled.
- [Disable](#Disable): Disables the specified menu item.
- [ToggleEnable](#ToggleEnable): Disables the specified menu item; otherwise, enables it.
- [Default](#Default): Changes the menu's default item to be the specified menu item and makes its font bold.
- [NoDefault](#NoDefault): Reverses setting a user-defined default menu item.
- [Standard](#Standard): Inserts the standard menu items at the bottom of the menu.
- [NoStandard](#NoStandard): Removes all standard menu items from the menu.
- [Icon](#Icon): Changes the script's tray icon or [in AHK\_L 17+] sets a icon for the specified menu item.
- [NoIcon](#NoIcon): Removes the tray icon or [in AHK\_L 17+] removes the icon from the specified menu item.
- [Tip](#Tip): Changes the tray icon's tooltip.
- [Show](#Show): Displays the specified menu.
- [Color](#Color): Changes the background color of the menu.
- [Click](#Click): Sets the number of clicks to activate the tray menu's default menu item.
- [MainWindow](#MainWindow): Allows the main window of a script to be opened via the tray icon.
- [NoMainWindow](#NoMainWindow): Prevents the main window from being opened via the tray icon.
- [UseErrorLevel](#UseErrorLevel): Skips any warning dialogs and thread terminations whenever the Menu command generates an error.

### Add

Adds a menu item, updates one with a new submenu or label, or converts one from a normal item into a submenu (or vice versa).

```
<span class="func">Menu</span>, MenuName, Add <span class="optional">, MenuItemName, LabelOrSubmenu, Options</span>
```

This is a multipurpose sub-command. _MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details). If _MenuItemName_ does not yet exist, it will be added to the menu. Otherwise, _MenuItemName_ is updated with the newly specified _LabelOrSubmenu_.

To add a menu separator line, omit all three parameters.

The label subroutine is run as a new [thread](../misc/Threads.htm) when the user selects the menu item (similar to [Gosub](Gosub.htm) and [hotkey subroutines](../Hotkeys.htm)). If _LabelOrSubmenu_ is omitted, _MenuItemName_ will be used as both the label and the menu item's name.

[v1.1.20+]: If it is not the name of an existing label, _LabelOrSubmenu_ can be the name of a function, or a single variable reference containing a [function object](../objects/Functor.htm). For example, `%FuncObj%` or `% FuncObj`. See [example #5](#ExBoundFunc) for a fully functional demonstration. Other expressions which return objects are currently unsupported. The function can optionally define parameters as shown below:

```
<i>FunctionName</i>(ItemName, ItemPos, MenuName)
```

To have _MenuItemName_ become a submenu -- which is a menu item that opens a new menu when selected -- specify for _LabelOrSubmenu_ a colon followed by the _MenuName_ of an existing custom menu. For example:

```
Menu, MySubmenu, Add, Item1
Menu, Tray, Add, This menu item is a submenu, :MySubmenu
```

If not omitted, _Options_ must be a space- or tab-delimited list of one or more of the following options:

OptionDescriptionP _n_Replace _n_ with the menu item's [thread priority](../misc/Threads.htm), e.g. `P1`. If this option is omitted when adding a menu item, the priority will be 0, which is the standard default. If omitted when updating a menu item, the item's priority will not be changed. Use a decimal (not hexadecimal) number as the priority.+Radio[v1.1.23+]: If the item is checked, a bullet point is used instead of a check mark.+Right[v1.1.23+]: The item is right-justified within the menu bar. This only applies to [menu bars](Gui.htm#Menu), not popup menus or submenus.+Break[v1.1.23+]: The item begins a new column in a popup menu.+BarBreak[v1.1.23+]: As above, but with a dividing line between columns.

The plus sign (+) is optional and can be replaced with minus (-) to remove the option, as in `-Radio`. Options are not case sensitive.

To change an existing item's options without affecting its label or submenu, simply omit the _LabelOrSubmenu_ parameter.

### Insert [v1.1.23+]

Inserts a new item before the specified menu item.

```
<span class="func">Menu</span>, MenuName, Insert <span class="optional">, MenuItemName, ItemToInsert, LabelOrSubmenu, Options</span>
```

Usage is identical to the [Add](#Add) sub-command (above), except that _MenuItemName_ is always the name or position of an existing menu item (see [MenuItemName](#MenuItemName) for details) and _ItemToInsert_ is the name of a new menu item to insert before _MenuItemName_. Menu items can also be appended by omitting _MenuItemName_ (by writing two consecutive commas). Unlike the [Add](#Add) sub-command, the Insert sub-command creates a new menu item even if _MenuItemName_ matches the name of an existing menu item.

### Delete

Deletes the specified menu item from the menu.

```
<span class="func">Menu</span>, MenuName, Delete <span class="optional">, MenuItemName</span>
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details). Standard menu items such as "Exit" (see below) cannot be individually deleted. If the _default_ menu item is deleted, the effect will be similar to having used the [NoDefault](#NoDefault) sub-command. If _MenuItemName_ is omitted, the entire _MenuName_ menu will be deleted as will any menu items in other menus that use _MenuName_ as a submenu. Deleting a menu also causes the current [Win32 menu](#Win32_Menus) of its parent and submenus to be destroyed, to be recreated later as needed.

### DeleteAll

Deletes all custom menu items from the menu.

```
<span class="func">Menu</span>, MenuName, DeleteAll
```

Any existing _standard_ menu items (see below) remain unaffected. Unlike a menu entirely deleted by the [Delete](#Delete) sub-command (see above), an empty menu still exists and thus any other menus that use it as a submenu will retain those submenus.

### Rename

Renames the specified menu item to _NewName_.

```
<span class="func">Menu</span>, MenuName, Rename, MenuItemName <span class="optional">, NewName</span>
```

If _NewName_ is blank, the specified menu item will be converted into a separator line. _MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details). The menu item's current target label or submenu is unchanged. [v1.1.23+]: A separator line can be converted to a normal menu item by specifying the position& of the separator and a non-blank _NewName_, and then using the [Add](#Add) sub-command to give the menu item a label or submenu.

### Check

Adds a visible checkmark in the menu next to the specified menu item (if there isn't one already).

```
<span class="func">Menu</span>, MenuName, Check, MenuItemName
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details).

### Uncheck

Removes the checkmark (if there is one) from the specified menu item.

```
<span class="func">Menu</span>, MenuName, Uncheck, MenuItemName
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details).

### ToggleCheck

Adds a checkmark to the specified menu item if there wasn't one; otherwise, removes it.

```
<span class="func">Menu</span>, MenuName, ToggleCheck, MenuItemName
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details).

### Enable

Allows the user to once again select the specified menu item if was previously disabled (grayed).

```
<span class="func">Menu</span>, MenuName, Enable, MenuItemName
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details).

### Disable

Changes the specified menu item to a gray color to indicate that the user cannot select it.

```
<span class="func">Menu</span>, MenuName, Disable, MenuItemName
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details).

### ToggleEnable

Disables the specified menu item if it was previously enabled; otherwise, enables it.

```
<span class="func">Menu</span>, MenuName, ToggleEnable, MenuItemName
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details).

### Default

Changes the menu's default item to be the specified menu item and makes its font bold.

```
<span class="func">Menu</span>, MenuName, Default <span class="optional">, MenuItemName</span>
```

Setting a default item in menus other than TRAY is currently purely cosmetic. _MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details). When the user double-clicks the tray icon, its default menu item is launched. If there is no default, double-clicking has no effect. If _MenuItemName_ is omitted, the effect is the same as having used the [NoDefault](#NoDefault) sub-command below.

### NoDefault

Reverses setting a user-defined default menu item.

```
<span class="func">Menu</span>, MenuName, NoDefault
```

For the tray menu: Changes the menu back to having its standard default menu item, which is OPEN for non-compiled scripts and none for [compiled scripts](../Scripts.htm#ahk2exe) (except when the [MainWindow](#MainWindow) sub-command is in effect). If the OPEN menu item does not exist due to a previous use of the [NoStandard](#NoStandard) sub-command below, there will be no default and thus double-clicking the tray icon will have no effect. For menus other than TRAY: Any existing default item is returned to a non-bold font.

### Standard

Inserts the standard menu items at the bottom of the menu (if they are not already present).

```
<span class="func">Menu</span>, MenuName, Standard
```

This sub-command can be used with the tray menu or any other menu.

### NoStandard

Removes all standard (non-custom) menu items from the menu (if they are present).

```
<span class="func">Menu</span>, MenuName, NoStandard
```

This sub-command can be used with the tray menu or any other menu.

### Icon

Affects the [tray icon](#TrayIcon) or [in AHK\_L 17+] the [menu item's icon](#MenuIcon) depending on syntax usage below.

#### Setting the tray icon

Changes the script's [tray icon](../Program.htm#tray-icon) to one of the ones from _FileName_.

```
<span class="func">Menu</span>, Tray, Icon <span class="optional">, FileName, IconNumber, 1</span>
```

The following types of files are supported: ICO, CUR, ANI, EXE, DLL, CPL, SCR, and other types that contain icon resources. To use an icon group other than the first one in the file, specify its number for _IconNumber_ (if omitted, it defaults to 1). For example, **2** would load the default icon from the second icon group. If _IconNumber_ is negative, its absolute value is assumed to be the resource ID of an icon within an executable file. Specify an asterisk (\*) for _FileName_ to restore the script to its default icon.

The last parameter: Specify 1 for the last parameter to freeze the icon, or 0 to unfreeze it (or leave it blank to keep the frozen/unfrozen state unchanged). When the icon has been frozen, [Pause](Pause.htm) and [Suspend](Suspend.htm) will not change it. Note: To freeze or unfreeze the _current_ icon, use 1 or 0 as in the following example: `Menu, Tray, Icon,,, 1`.

Changing the tray icon also changes the icon displayed by [InputBox](InputBox.htm), [Progress](Progress.htm), and subsequently-created [GUI](Gui.htm) windows. [Compiled scripts](../Scripts.htm#ahk2exe) are also affected even if a custom icon was specified at the time of compiling.

**Note:** Changing the icon will not unhide the tray icon if it was previously hidden by means such as [#NoTrayIcon](_NoTrayIcon.htm); to do that, use `Menu, Tray, Icon` (with no parameters).

Slight distortion may occur when loading tray icons from file types other than .ICO. This is especially true for 16x16 icons. To prevent this, store the desired tray icon inside a .ICO file.

There are some icons built into the operating system's DLLs and CPLs that might be useful. For example: `Menu, Tray, Icon, Shell32.dll, 174`.

The built-in variables **A\_IconNumber** and **A\_IconFile** contain the number and name (with full path) of the current icon (both are blank if the icon is the default).

[v1.1.23+]: An [icon handle](../misc/ImageHandles.htm) can be used instead of a filename. For example, `Menu Tray, Icon, HICON:*%handle%`. The asterisk is required as the icon must be "loaded" twice: once for the small icon and again for the large icon.

[v1.1.27+]: Non-icon image files and [bitmap handles](../misc/ImageHandles.htm) are supported for _Filename_. For example, `Menu Tray, Icon, HBITMAP:*%handle%`.

#### Setting the menu item's icon [AHK\_L 17+]

Sets a icon for the specified menu item.

```
<span class="func">Menu</span>, MenuName, Icon, MenuItemName, FileName <span class="optional">, IconNumber, IconWidth</span>
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details). _FileName_ can either be an icon file or any image in a format supported by AutoHotkey. To use an icon group other than the first one in the file, specify its number for _IconNumber_ (if omitted, it defaults to 1). If _IconNumber_ is negative, its absolute value is assumed to be the resource ID of an icon within an executable file. Specify the desired width of the icon in _IconWidth_. If the icon group indicated by _IconNumber_ contains multiple icon sizes, the closest match is used and the icon is scaled to the specified size. See [example #4](#ExIcon) for usage examples.

Currently it is necessary to specify "actual size" when setting the icon to preserve transparency on Windows Vista and later. For example:

```
Menu, <i>MenuName</i>, Icon, <i>MenuItemName</i>, Filename.png,, 0
```

Known limitation: Icons on Gui menu bars are positioned incorrectly on Windows XP and older.

[v1.1.23+]: A [bitmap or icon handle](../misc/ImageHandles.htm) can be used instead of a filename. For example, `HBITMAP:%handle%`.

### NoIcon

Affects the [tray icon](#RemoveTrayIcon) or [in AHK\_L 17+] the [menu item's icon](#RemoveMenuIcon) depending on syntax usage below.

#### Removing the tray icon

Removes the tray icon if it exists.

```
<span class="func">Menu</span>, Tray, NoIcon
```

If this sub-command is used at the very top of the script, the tray icon might be briefly visible when the script is launched. To prevent that, use [#NoTrayIcon](_NoTrayIcon.htm) instead. The built-in variable **A\_IconHidden** contains 1 if the tray icon is currently hidden or 0 otherwise.

#### Removing the menu item's icon [AHK\_L 17+]

Removes the icon from the specified menu item, if any.

```
<span class="func">Menu</span>, MenuName, NoIcon, MenuItemName
```

_MenuItemName_ is the name or position of a menu item (see [MenuItemName](#MenuItemName) for details).

### Tip

Changes the tray icon's tooltip.

```
<span class="func">Menu</span>, Tray, Tip <span class="optional">, Text</span>
```

The tray icon's tooltip is displayed when the mouse hovers over it. To create a multi-line tooltip, use the linefeed character (\`n) in between each line, e.g. Line1\`nLine2. Only the first 127 characters of _Text_ are displayed, and _Text_ is truncated at the first tab character, if present. If _Text_ is omitted, the tooltip is restored to its default text. The built-in variable **A\_IconTip** contains the current text of the tooltip (blank if the text is at its default).

### Show

Displays _MenuName_.

```
<span class="func">Menu</span>, MenuName, Show <span class="optional">, X, Y</span>
```

The user can select an item with arrow keys, menu shortcuts (underlined letters), or the mouse. Any menu can be shown, including the tray menu but with the exception of [GUI](Gui.htm) menu bars. If both X and Y are omitted, the menu is displayed at the current position of the mouse cursor. If only one of them is omitted, the mouse cursor's position will be used for it. X and Y are relative to the active window. Specify " [CoordMode](CoordMode.htm), Menu" beforehand to make them relative to the entire screen.

### Color

Changes the background color of the menu to _ColorValue_.

```
<span class="func">Menu</span>, MenuName, Color, ColorValue <span class="optional">, Single</span>
```

_ColorValue_ is one of the 16 primary HTML color names or a 6-digit RGB color value (see [color chart](Progress.htm#colors)). Leave _ColorValue_ blank (or specify the word Default) to restore the menu to its default color. If the word Single is not present as the next parameter, any submenus attached to this menu will also be changed in color.

### Click

Sets the number of clicks to activate the tray menu's default menu item.

```
<span class="func">Menu</span>, Tray, Click, ClickCount
```

Specify 1 for _ClickCount_ to allow a single-click to activate the tray menu's default menu item. Specify 2 for _ClickCount_ to return to the default behavior (double-click). For example: `Menu, Tray, Click, 1`.

### MainWindow

Allows the [main window](../Program.htm#main-window) of a script to be opened via the tray icon, which is impossible by default for [compiled](../Scripts.htm#ahk2exe) or [embedded](../Program.htm#embedded-scripts) scripts.

```
<span class="func">Menu</span>, Tray, MainWindow
```

This sub-command restores the "Open" option to the tray menu, unless the [NoStandard](#NoStandard) sub-command was used. It also enables the items in the main window's View menu such as "Lines most recently executed", which allows viewing of the script's source code and other info.

This mode is the default for scripts which are neither [compiled](../Scripts.htm#ahk2exe) nor [embedded](../Program.htm#embedded-scripts).

### NoMainWindow

Prevents the [main window](../Program.htm#main-window) from being opened via the tray icon.

```
<span class="func">Menu</span>, Tray, NoMainWindow
```

This sub-command removes the standard "Open" option from the tray menu. It also disables the items in the main window's View menu such as "Lines most recently executed". However, the following commands are still able to show the main window and activate the corresponding View options when they are encountered in the script at runtime: [ListLines](ListLines.htm), [ListVars](ListVars.htm), [ListHotkeys](ListHotkeys.htm), and [KeyHistory](KeyHistory.htm).

This sub-command does not prevent the main window from being shown by [WinShow](WinShow.htm) or inspected by [ControlGetText](ControlGetText.htm) or similar methods, but it does prevent the script's source code and other info from being exposed via the main window, except when one of the commands listed above is called by the script.

This mode is the default for scripts which are [compiled](../Scripts.htm#ahk2exe) or [embedded](../Program.htm#embedded-scripts).

[v1.1.34+]: This sub-command can be used even in a non-compiled script.

### UseErrorLevel

Skips any warning dialogs and thread terminations whenever the Menu command generates an error.

```
<span class="func">Menu</span>, MenuName, UseErrorLevel <span class="optional">, Off</span>
```

If this option is never used in the script, it defaults to OFF. The OFF setting displays a dialog and terminates the [current thread](../misc/Threads.htm) whenever the Menu command generates an error. Specify `Menu, Tray, UseErrorLevel` to prevent the dialog and thread termination; instead, [ErrorLevel](../misc/ErrorLevel.htm) will be set to 1 if there was a problem or 0 otherwise. To turn this option back off, specify OFF (or in [v1.1.30+], 0) for the next parameter. This setting is global, meaning it affects all menus, not just _MenuName_.

## The _MenuItemName_ Parameter

The name or position of a menu item. Some common rules apply to this parameter across all sub-commands which use it:

- To underline one of the letters in a menu item's name, precede that letter with an ampersand (&). When the menu is displayed, such an item can be selected by pressing the corresponding key on the keyboard. To display a literal ampersand, specify two consecutive ampersands as in this example:`Save && Exit`
- When referring to an existing menu or menu item, the name is not case sensitive but any ampersands must be included. For example:`&Open`
- [v1.1.23+]: To identify an existing item by its position in the menu, write the item's position followed by an ampersand. For example, `1&` indicates the first item.

## Win32 Menus

As items are added to a menu or modified, the name and other properties of each item are recorded by the Menu command, but the actual [Win32 menu](https://msdn.microsoft.com/en-us/library/ms646977) is not constructed immediately. This occurs when the menu or its parent menu is attached to a GUI or shown, either for the first time or if the menu has been "destroyed" since it was last shown. Any of the following can cause this Win32 menu to be destroyed, along with any parent menus and submenus:

- Deleting a menu.
- Replacing an item's submenu with a label or a different menu.
- Prior to[v1.1.27.03], calling the sub-commands [NoStandard](#NoStandard) (if the standard items were present) or [DeleteAll](#DeleteAll).

Any modifications which are made to the menu directly by Win32 API calls only apply to the current "instance" of the menu, and are lost when the menu is destroyed.

Each menu item is assigned an ID when it is first added to the menu. Scripts cannot rely on an item receiving a particular ID, but can retrieve the ID of an item by using GetMenuItemID as shown in the [MenuGetHandle example](MenuGetHandle.htm#Examples). This ID cannot be used with the Menu command, but can be used with various [Win32 functions](https://msdn.microsoft.com/en-us/library/ms646977).

## Remarks

A menu usually looks like this:

![Menu](../static/ctrl_menu.png)

The names of menus and menu items can be up to 260 characters long.

Separator lines can be added to the menu by using `Menu, <i>MenuName</i>, Add` (i.e. omit all other parameters). [v1.1.23+]: To delete separator lines individually, identify them by their position in the menu. For example, use `Menu, <i>MenuName</i>, Delete, 3&` if there are two items preceding the separator. Alternatively, use `Menu, <i>MenuName</i>, DeleteAll` and then re-add your custom menu items.

New menu items are always added at the bottom of the menu. For the tray menu: To put your menu items on top of the standard menu items (after adding your own menu items) run `Menu, Tray, NoStandard` followed by `Menu, Tray, Standard`.

The standard menu items such as "Pause Script" and "Suspend Hotkeys" cannot be individually operated upon by any menu sub-command.

If a menu ever becomes completely empty -- such as by using `Menu, MyMenu, DeleteAll` \-\- it cannot be shown. If the tray menu becomes empty, right-clicking and double-clicking the tray icon will have no effect (in such cases it is usually better to use [#NoTrayIcon](_NoTrayIcon.htm)).

If a menu item's subroutine is already running and the user selects the same menu item again, a new [thread](../misc/Threads.htm) will be created to run that same subroutine, interrupting the previous thread. To instead buffer such events until later, use [Critical](Critical.htm) as the subroutine's first line (however, this will also buffer/defer other threads such as the press of a hotkey).

Whenever a subroutine is launched via a menu item, it starts off fresh with the default values for settings such as [SendMode](SendMode.htm). These defaults can be changed in the [auto-execute section](../Scripts.htm#auto).

The built-in variables **A\_ThisMenuItem** and **A\_ThisMenuItemPos** contain the name and position of the custom menu item most recently selected by the user (blank if none). Similarly, **A\_ThisMenu** is the name of the menu from which **A\_ThisMenuItem** was selected. These variables are useful when building a menu whose contents are not always the same. In such a case, it is usually best to point all such menu items to the same label and have that label refer to the above variables to determine what action to take.

To keep a non-hotkey, non- [GUI](Gui.htm) script running -- such as one that contains only custom menus or menu items -- use [#Persistent](_Persistent.htm).

## Related

[GUI](Gui.htm), [Threads](../misc/Threads.htm), [Thread](Thread.htm), [Critical](Critical.htm), [#NoTrayIcon](_NoTrayIcon.htm), [Gosub](Gosub.htm), [Return](Return.htm), [SetTimer](SetTimer.htm), [#Persistent](_Persistent.htm)

## Examples

Adds a new menu item to the bottom of the tray icon menu.

```
#Persistent  <em>; Keep the script running until the user exits it.</em>
Menu, Tray, Add  <em>; Creates a separator line.</em>
Menu, Tray, Add, Item1, MenuHandler  <em>; Creates a new menu item.</em>
return

MenuHandler:
MsgBox You selected %A_ThisMenuItem% from menu %A_ThisMenu%.
return
```

Creates a popup menu that is displayed when the user presses a hotkey.

```
<em>; Create the popup menu by adding some items to it.</em>
Menu, MyMenu, Add, Item1, MenuHandler
Menu, MyMenu, Add, Item2, MenuHandler
Menu, MyMenu, Add  <em>; Add a separator line.</em>

<em>; Create another menu destined to become a submenu of the above menu.</em>
Menu, Submenu1, Add, Item1, MenuHandler
Menu, Submenu1, Add, Item2, MenuHandler

<em>; Create a submenu in the first menu (a right-arrow indicator). When the user selects it, the second menu is displayed.</em>
Menu, MyMenu, Add, My Submenu, :Submenu1

Menu, MyMenu, Add  <em>; Add a separator line below the submenu.</em>
Menu, MyMenu, Add, Item3, MenuHandler  <em>; Add another menu item beneath the submenu.</em>
return  <em>; End of script's auto-execute section.</em>

MenuHandler:
MsgBox You selected %A_ThisMenuItem% from the menu %A_ThisMenu%.
return

#z::Menu, MyMenu, Show  <em>; i.e. press the Win-Z hotkey to show the menu.</em>
```

Demonstrates some of the various menu sub-commands.

```
#Persistent
#SingleInstance
Menu, Tray, Add <em>; separator</em>
Menu, Tray, Add, TestToggle&Check
Menu, Tray, Add, TestToggleEnable
Menu, Tray, Add, TestDefault
Menu, Tray, Add, TestStandard
Menu, Tray, Add, TestDelete
Menu, Tray, Add, TestDeleteAll
Menu, Tray, Add, TestRename
Menu, Tray, Add, Test
return

<em>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</em>

TestToggle&Check:
Menu, Tray, ToggleCheck, TestToggle&Check
Menu, Tray, Enable, TestToggleEnable <em>; Also enables the next test since it can't undo the disabling of itself.</em>
Menu, Tray, Add, TestDelete <em>; Similar to above.</em>
return

TestToggleEnable:
Menu, Tray, ToggleEnable, TestToggleEnable
return

TestDefault:
if (Default = "TestDefault")
{
    Menu, Tray, NoDefault
    Default := ""
}
else
{
    Menu, Tray, Default, TestDefault
    Default := "TestDefault"
}
return

TestStandard:
if (Standard != false)
{
    Menu, Tray, NoStandard
    Standard := false
}
else
{
    Menu, Tray, Standard
    Standard := true
}
return

TestDelete:
Menu, Tray, Delete, TestDelete
return

TestDeleteAll:
Menu, Tray, DeleteAll
return

TestRename:
if (NewName != "renamed")
{
    OldName := "TestRename"
    NewName := "renamed"
}
else
{
    OldName := "renamed"
    NewName := "TestRename"
}
Menu, Tray, Rename, %OldName%, %NewName%
return

Test:
MsgBox, You selected "%A_ThisMenuItem%" in menu "%A_ThisMenu%".
return
```

Demonstrates how to add icons to menu items.

```
Menu, FileMenu, Add, Script Icon, MenuHandler
Menu, FileMenu, Add, Suspend Icon, MenuHandler
Menu, FileMenu, Add, Pause Icon, MenuHandler
Menu, FileMenu, Icon, Script Icon, %A_AhkPath%, 2 <em>; Use the 2nd icon group from the file</em>
Menu, FileMenu, Icon, Suspend Icon, %A_AhkPath%, -206 <em>; Use icon with resource identifier 206</em>
Menu, FileMenu, Icon, Pause Icon, %A_AhkPath%, -207 <em>; Use icon with resource identifier 207</em>
Menu, MyMenuBar, Add, &File, :FileMenu
Gui, Menu, MyMenuBar
Gui, Add, Button, gExit, Exit This Example
Gui, Show
return

MenuHandler:
return

Exit:
ExitApp

```

Demonstrates the usage of [BoundFunc objects](../objects/Functor.htm#BoundFunc) to pass additional parameters when using a function instead of a subroutine.

```
<em>; Bind parameters to the function and return BoundFunc objects:</em>
BoundGivePar := Func("GivePar").Bind("First", "Test one")
BoundGivePar2 := Func("GivePar").Bind("Second", "Test two")

<em>; Create the menu and show it:</em>
Menu MyMenu, Add, Give parameters, % BoundGivePar
Menu MyMenu, Add, Give parameters2, % BoundGivePar2
Menu MyMenu, Show

<em>; Definition of custom function GivePar:</em>
GivePar(a, b, ItemName, ItemPos, MenuName)
{
    MsgBox % "a:`t`t" a "`n"
           . "b:`t`t" b "`n"
           . "ItemName:`t" ItemName "`n"
           . "ItemPos:`t`t" ItemPos "`n"
           . "MenuName:`t" MenuName
}
```

