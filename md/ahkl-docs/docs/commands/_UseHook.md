# \#UseHook

Forces the use of the hook to implement all or some keyboard [hotkeys](../Hotkeys.htm).

```
<span class="func">#UseHook</span> <span class="optional">OnOff</span>
```

## Parameters

OnOff

Specify one of the following words (if omitted, it defaults to On):

**On**: The [keyboard hook](_InstallKeybdHook.htm) will be used to implement all keyboard hotkeys between here and the next `#UseHook OFF` (if any).

**Off**: Hotkeys will be implemented using the default method (RegisterHotkey() if possible; otherwise, the keyboard hook).

## Remarks

Normally, the windows API function RegisterHotkey() is used to implement a keyboard hotkey whenever possible. However, the responsiveness of hotkeys might be better under some conditions if the [keyboard hook](_InstallKeybdHook.htm) is used instead.

Turning this directive ON is equivalent to using the [$ prefix](../Hotkeys.htm#prefixdollar) in the definition of each affected hotkey.

As with all # directives -- which are processed only once when the script is launched -- `#UseHook` should not be positioned in the script as though it were a command (that is, it is not necessary to have it contained within a subroutine). Instead, position it immediately before the first hotkey label you wish to have affected by it.

By default, hotkeys that use the [keyboard hook](_InstallKeybdHook.htm) cannot be triggered by means of the [Send](Send.htm) command. Similarly, mouse hotkeys cannot be triggered by commands such as [Click](Click.htm) because all mouse hotkeys use the [mouse hook](_InstallMouseHook.htm). One workaround is to use [Gosub](Gosub.htm) to jump directly to the hotkey's subroutine. For example: `Gosub #LButton`.

[v1.1.06+]: [#InputLevel](_InputLevel.htm) and [SendLevel](SendLevel.htm) provide additional control over which hotkeys and hotstrings are triggered by the Send command.

If this directive does not appear in the script at all, it will behave as though set to OFF.

Like other directives, #UseHook cannot be executed conditionally.

## Related

[#InstallKeybdHook](_InstallKeybdHook.htm), [#InstallMouseHook](_InstallMouseHook.htm), [ListHotkeys](ListHotkeys.htm), [#InputLevel](_InputLevel.htm)

## Examples

Causes the first two hotkeys to use the keyboard hook.

```
#UseHook  <em>; Force the use of the hook for hotkeys after this point.</em>
#x::MsgBox, This hotkey will be implemented with the hook.
#y::MsgBox, And this one too.
#UseHook Off
#z::MsgBox, But not this one.
```

