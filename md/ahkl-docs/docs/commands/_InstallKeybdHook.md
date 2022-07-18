# \#InstallKeybdHook

Forces the unconditional installation of the keyboard hook.

```
<span class="func">#InstallKeybdHook</span>
```

## Remarks

The keyboard hook monitors keystrokes for the purpose of activating [hotstrings](../Hotstrings.htm) and any keyboard [hotkeys](../Hotkeys.htm) not supported by RegisterHotkey (which is a function built into the operating system). It also supports a few other features such as the [Input](Input.htm) command.

AutoHotkey does not install the keyboard and mouse hooks unconditionally because together they consume at least 500 KB of memory. Therefore, the keyboard hook is normally installed only when the script contains one of the following: 1) [hotstrings](../Hotstrings.htm); 2) one or more [hotkeys](../Hotkeys.htm) that require the keyboard hook (most do not); 3) [SetCaps/Scroll/NumLock AlwaysOn/AlwaysOff](SetNumScrollCapsLockState.htm); 4) the [Input](Input.htm) command, for which the hook is installed upon first actual use.

By contrast, the #InstallKeybdHook directive will unconditionally install the keyboard hook, which might be useful to allow [KeyHistory](KeyHistory.htm) to display the last 20 keystrokes (for debugging purposes), or to avoid the need for [#HotkeyModifierTimeout](_HotkeyModifierTimeout.htm).

Keyboard hotkeys which do not require the hook will use the _reg_ method even if the #InstallKeybdHook directive is used. By contrast, applying the [#UseHook](_UseHook.htm) directive or the [$ prefix](../Hotkeys.htm#prefixdollar) to a keyboard hotkey forces it to require the hook, which causes the hook to be installed if the hotkey is enabled.

You can determine whether a script is using the hook via the [KeyHistory](KeyHistory.htm) command or menu item. You can determine which hotkeys are using the hook via the [ListHotkeys](ListHotkeys.htm) command or menu item.

This directive also makes a script [persistent](_Persistent.htm), meaning that [ExitApp](ExitApp.htm) should be used to terminate it.

Like other directives, #InstallKeybdHook cannot be executed conditionally.

## Related

[#InstallMouseHook](_InstallMouseHook.htm), [#UseHook](_UseHook.htm), [Hotkey](Hotkey.htm), [Input](Input.htm), [#Persistent](_Persistent.htm), [KeyHistory](KeyHistory.htm), [Hotstrings](../Hotstrings.htm), [GetKeyState()](GetKeyState.htm#function), [KeyWait](KeyWait.htm)

## Examples

Installs the keyboard hook unconditionally.

```
#InstallKeybdHook
```

