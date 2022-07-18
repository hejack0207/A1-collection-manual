# MenuGetName() [v1.1.23+]

Retrieves the name of a menu given a handle to its underlying [Win32 menu](Menu.htm#Win32_Menus).

```
MenuName := <span class="func">MenuGetName</span>(Handle)
```

## Parameters

Handle

A Win32 menu handle (HMENU).

## Remarks

Only the menu's current handle is recognized. When the menu's underlying Win32 menu is destroyed and recreated, the handle changes. For details, see [Win32 Menus](Menu.htm#Win32_Menus).

## Related

[Menu](Menu.htm), [MenuGetHandle()](MenuGetHandle.htm)

