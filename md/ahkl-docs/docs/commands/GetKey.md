# GetKeyName() / GetKeyVK() / GetKeySC() [v1.1.01+]

Retrieves the name/text, virtual key code or scan code of a key.

```
String := <span class="func">GetKeyName</span>(Key)
Number := <span class="func">GetKeyVK</span>(Key)
Number := <span class="func">GetKeySC</span>(Key)

```

## Parameters

Key

A VK or SC code, such as `"vkA2"` or `"sc01D"`, a combination of both, or a [key name](../KeyList.htm). For example, both `GetKeyName("vk1B")` and `GetKeyName("Esc")` return `Escape`, while `GetKeyVK("Esc")` returns `27`. Note that VK and SC codes must be in hexadecimal. To convert a decimal number to the appropriate format, use `<a href="Format.htm" data-index="2">Format</a>("vk{:x}", vk_code)` or `Format("sc{:x}", sc_code)`.

## Return Value

These functions return a name, virtual key code or scan code of _Key_.

## Related

[GetKeyState()](GetKeyState.htm#function), [Key List](../KeyList.htm), [Format()](Format.htm)

## Examples

Reports information for a specific key.

```
key  := "LWin" <em>; Any key can be used here.</em>

name := GetKeyName(key)
vk   := GetKeyVK(key)
sc   := GetKeySC(key)

MsgBox, % Format("Name:`t{}`nVK:`t{:X}`nSC:`t{:X}", name, vk, sc)
```

