# MenuGetHandle() [v1.1.23+]

Retrieves the [Win32 menu](Menu.htm#Win32_Menus) handle of a menu.

```
Handle := <span class="func">MenuGetHandle</span>(MenuName)
```

## Parameters

MenuName

The name of an existing menu. Menu names are not case sensitive.

## Remarks

The returned handle is valid only until the Win32 menu is destroyed. Once the menu is destroyed, the operating system may reassign the handle value to any menus subsequently created by the script or any other program. Conditions which can cause the menu to be destroyed are listed under [Win32 Menus](Menu.htm#Win32_Menus).

## Related

[Menu](Menu.htm), [MenuGetName()](MenuGetName.htm)

## Examples

Reports the number of items in a menu and the ID of the last item.

```
Menu MyMenu, Add, Item 1, no
Menu MyMenu, Add, Item 2, no
Menu MyMenu, Add, Item B, no

<em>; Retrieve the number of items in a menu.</em>
item_count := DllCall("GetMenuItemCount", "ptr", MenuGetHandle("MyMenu"))

<em>; Retrieve the ID of the last item.</em>
last_id := DllCall("GetMenuItemID", "ptr", MenuGetHandle("MyMenu"), "int", item_count-1)

MsgBox, MyMenu has %item_count% items, and its last item has ID %last_id%.

no:
return

```

