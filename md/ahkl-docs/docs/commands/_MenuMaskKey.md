# \#MenuMaskKey [AHK\_L 38+]

Changes which key is used to mask Win or Alt keyup events.

```
<span class="func">#MenuMaskKey</span> KeyName
```

## Parameters

KeyName

A [key name](../KeyList.htm) or [VKnn](../KeyList.htm#vk) sequence which specifies a non-zero virtual keycode. Scan codes are used only in [v1.1.28+], which also supports [SCnnn](../KeyList.htm#sc) and VKnnSCnnn.

## Remarks

The mask key is sent automatically to prevent the Start menu or the active window's menu bar from activating at unexpected times.

The default mask key is Ctrl. This directive can be used to change the mask key to a key with fewer side effects.

Good candidates are virtual key codes which generally have no effect, such as vkE8, which Microsoft documents as "unassigned", or vkFF, which is reserved to mean "no mapping" (a key which has no function).

**Note**: Microsoft can assign an effect to an unassigned key code at any time. For example, vk07 was once undefined and safe to use, but since Windows 10 1909 it is reserved for opening the game bar.

[v1.1.28+]: Both the VK and SC can be specified, and are not required to match an existing key. Specifying `vk00sc000` will disable all automatic masking. Some values, such as zero VK with non-zero SC, may fail to suppress the Start menu.

This setting is global, meaning that it needs to be specified only once (anywhere in the script) to affect the behavior of the entire script.

Like other directives, #MenuMaskKey cannot be executed conditionally.

**Hotkeys:** If a hotkey is implemented using the keyboard hook or mouse hook, the final keypress may be invisible to the active window and the system. If the system was to detect _only_ a Win or Alt keydown and keyup with no intervening keypress, it would usually activate a menu. To prevent this, the keyboard or mouse hook may automatically send the mask key.

[v1.1.27+]: Pressing a hook hotkey causes the next Alt or Win keyup to be masked if all of the following conditions are met:

- The hotkey is suppressed (it lacks the[tilde modifier](../Hotkeys.htm#Tilde)).
- Alt or Win is logically down when the hotkey is pressed.
- The modifier is physically down or the hotkey requires the modifier to activate. For example,`$#a::` in combination with `AppsKey::RWin` causes masking when Menu+A is pressed, but Menu on its own is able to open the Start Menu.
- Alt is not masked if Ctrl was down when the hotkey was pressed, since Ctrl+Alt does not activate the menu bar.
- Win is not masked if the most recent Win keydown was modified with Ctrl, Shift or Alt, since the Start Menu does not normally activate in those cases. However, key-repeat occurs even for Win if it was the last key physically pressed, so it can be hard to predict _when_ the most recent Win keydown was.
- Either the keyboard hook is not installed (i.e. for a mouse hotkey), or there have been no other (unsuppressed) keydown or keyup events since the last Alt or Win keydown. Note that key-repeat occurs even for modifier keys and even after sending other keys, but only for the last physically pressed key.

Mouse hotkeys may send the mask key immediately if the keyboard hook is not installed.

Hotkeys with the [tilde modifier](../Hotkeys.htm#Tilde) are not intended to block the native function of the key, so in [v1.1.27+] they do not cause masking. Hotkeys like `~#a::` still suppress the menu, since the system detects that Win has been used in combination with another key. However, mouse hotkeys and both Win themselves ( `~LWin::` and `~RWin::`) do not suppress the Start Menu.

The Start Menu (or the active window's menu bar) can be suppressed by sending any keystroke. The following example disables the ability for the left Win to activate the Start Menu, while still allowing its use as a modifier:

```
~LWin::Send {Blind}{vkE8}
```

**Send:** [Send](Send.htm), [ControlSend](ControlSend.htm) and related often release modifier keys as part of their normal operation. For example, the hotkey `<#a::SendRaw %Address%` usually must release the left Win prior to sending the contents of _Address_, and press the left Win back down afterward (so that other Win key combinations continue working). The mask key may be sent in such cases to prevent a Win or Alt keyup from activating a menu.

## Related

See [this thread](https://www.autohotkey.com/board/topic/20619-extraneous-control-key-presses-generated-by-or-hotkeys/) for background information.

## Examples

Basic usage.

```
#MenuMaskKey vkE8  <em>; Change the masking key to something unassigned such as vkE8.</em>
#Space::Run % A_ScriptDir  <em>; An additional Ctrl keystroke is not triggered.</em>
```

Shows in detail how this directive causes vkFF to be sent instead of LControl.

```
#MenuMaskKey vkFF  <em>; vkFF is no mapping.</em>
#UseHook
#Space::
!Space::
    KeyWait LWin
    KeyWait RWin
    KeyWait Alt
    KeyHistory
return
```

