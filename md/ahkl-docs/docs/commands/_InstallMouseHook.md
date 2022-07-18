# \#InstallMouseHook

Forces the unconditional installation of the mouse hook.

```
<span class="func">#InstallMouseHook</span>
```

## Remarks

The mouse hook monitors mouse clicks for the purpose of activating mouse [hotkeys](../Hotkeys.htm) and [facilitating hotstrings](../Hotstrings.htm#NoMouse).

AutoHotkey does not install the keyboard and mouse hooks unconditionally because together they consume at least 500 KB of memory (but if the keyboard hook is installed, installing the mouse hook only requires about 50 KB of additional memory; and vice versa). Therefore, the mouse hook is normally installed only when the script contains one or more mouse [hotkeys](../Hotkeys.htm). It is also installed for [hotstrings](../Hotstrings.htm), but that can be disabled via [#Hotstring NoMouse](_Hotstring.htm).

By contrast, the #InstallMouseHook directive will unconditionally install the mouse hook, which might be useful to allow [KeyHistory](KeyHistory.htm) to monitor mouse clicks.

You can determine whether a script is using the hook via the [KeyHistory](KeyHistory.htm) command or menu item. You can determine which hotkeys are using the hook via the [ListHotkeys](ListHotkeys.htm) command or menu item.

This directive also makes a script [persistent](_Persistent.htm), meaning that [ExitApp](ExitApp.htm) should be used to terminate it.

Like other directives, #InstallMouseHook cannot be executed conditionally.

## Related

[#InstallKeybdHook](_InstallKeybdHook.htm), [#UseHook](_UseHook.htm), [Hotkey](Hotkey.htm), [#Persistent](_Persistent.htm), [KeyHistory](KeyHistory.htm), [GetKeyState()](GetKeyState.htm#function), [KeyWait](KeyWait.htm)

## Examples

Installs the mouse hook unconditionally.

```
#InstallMouseHook
```

