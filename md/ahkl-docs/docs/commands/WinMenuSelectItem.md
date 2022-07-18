# WinMenuSelectItem

Invokes a menu item from the menu bar of the specified window.

```
<span class="func">WinMenuSelectItem</span>, WinTitle, WinText, Menu <span class="optional">, SubMenu1, SubMenu2, SubMenu3, SubMenu4, SubMenu5, SubMenu6, ExcludeTitle, ExcludeText</span>
```

## Parameters

WinTitle

A window title or other criteria identifying the target window. See [WinTitle](../misc/WinTitle.htm).

WinText

If present, this parameter must be a substring from a single text element of the target window (as revealed by the included Window Spy utility). Hidden text elements are detected if [DetectHiddenText](DetectHiddenText.htm) is ON.

Menu

The name (or a prefix of the name) of the top-level menu item, e.g. File, Edit, View. It can also be the position of the desired menu item by using `1&` to represent the first menu, `2&` the second, and so on.

The search is case-insensitive according to the rules of the current user's locale, and stops at the first matching item. The use of ampersand (&) to indicate the underlined letter in a menu item is _usually_ not necessary (i.e. &File is the same as File).

**Known limitation:** If the parameter contains an ampersand, it must match the item name exactly, including all non-literal ampersands (which are hidden or displayed as an underline). If the parameter does not contain an ampersand, all ampersands are ignored, including literal ones. For example, an item displayed as "a & b" may match a parameter value of `a && b` or `a  b`.

[v1.1.28+]: Specify `0&` to use the window's [system menu](#sys).

SubMenu1

The name of the menu item to select or its position (see above).

This can be omitted if the top-level item does not contain a menu (rare).

SubMenu2

If _SubMenu1_ itself contains a menu, this is the name of the menu item inside, or its position.

SubMenu3SubMenu4SubMenu5SubMenu6

Same as above.

ExcludeTitle

Windows whose titles include this value will not be considered.

ExcludeText

Windows whose text include this value will not be considered.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

For this command to work, the target window need not be active. However, some windows might need to be in a [non-minimized](WinRestore.htm) state.

This command **will not work** with applications that use non-standard menu bars. Examples include Microsoft Outlook and Outlook Express, which use disguised toolbars for their menu bars. In these cases, consider using [ControlSend](ControlSend.htm) or [PostMessage](PostMessage.htm), which should be able to interact with some of these non-standard menu bars.

The menu name parameters can also specify positions. This method exists to support menus that don't contain text (perhaps because they contain pictures of text rather than actual text). Position 1& is the first menu item (e.g. the File menu), position 2& is the second menu item (e.g. the Edit menu), and so on. Menu separator lines count as menu items for the purpose of determining the position of a menu item.

Window titles and text are case sensitive. Hidden windows are not detected unless [DetectHiddenWindows](DetectHiddenWindows.htm) has been turned on.

## System Menu [v1.1.28+]

_Menu_ can be `0&` to select an item within the window's system menu, which typically appears when the user presses Alt+Space or clicks on the icon in the window's title bar. For example:

```
<em>; Paste a command into cmd.exe without activating the window.</em>
Clipboard := "echo Hello, world!`r"
WinMenuSelectItem ahk_exe cmd.exe,, 0&, Edit, Paste
```

**Caution:** Use this only on windows which have custom items in their system menu.

If the window does not already have a custom system menu, a copy of the standard system menu will be created and assigned to the target window as a side effect. This copy is destroyed by the system when the script exits, leaving other scripts unable to access it. Therefore, avoid using 0& for the standard items which appear on all windows. Instead, post the [WM\_SYSCOMMAND](https://msdn.microsoft.com/library/ms646360) message directly. For example:

```
<em>; Like "<a href="WinMinimize.htm" data-index="11">WinMinimize</a> A", but also play the system sound for minimizing.</em>
WM_SYSCOMMAND := 0x0112
SC_MINIMIZE := 0xF020
PostMessage WM_SYSCOMMAND, SC_MINIMIZE, 0,, A
```

## Related

[ControlSend](ControlSend.htm), [PostMessage](PostMessage.htm)

## Examples

Selects File->Open in Notepad.

```
WinMenuSelectItem, Untitled - Notepad,, File, Open
```

Same as above except it is done by position instead of name.

```
WinMenuSelectItem, Untitled - Notepad,, 1&, 2&
```

