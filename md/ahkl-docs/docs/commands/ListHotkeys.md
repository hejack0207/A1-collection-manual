# ListHotkeys

Displays the hotkeys in use by the current script, whether their subroutines are currently running, and whether or not they use the [keyboard](_InstallKeybdHook.htm) or [mouse](_InstallMouseHook.htm) hook.

```
<span class="func">ListHotkeys</span>
```

This command is equivalent to selecting the View->Hotkeys menu item in the main window.

If a hotkey has been disabled via the [Hotkey](Hotkey.htm) command, it will be listed as OFF or PART ("PART" means that only some of the hotkey's [variants](Hotkey.htm#variant) are disabled).

[v1.1.16+]: If any of a hotkey's variants have a non-zero [#InputLevel](_InputLevel.htm), the level (or minimum and maximum levels) are displayed.

If any of a hotkey's subroutines are currently running, the total number of threads is displayed for that hotkey.

Finally, the type of hotkey is also displayed, which is one of the following:

- reg: The hotkey is implemented via the operating system's RegisterHotkey() function.
- reg(no): Same as above except that this hotkey is inactive (due to being unsupported, disabled, or[suspended](Suspend.htm)).
- k-hook: The hotkey is implemented via the[keyboard hook](_InstallKeybdHook.htm).
- m-hook: The hotkey is implemented via the[mouse hook](_InstallMouseHook.htm).
- 2-hooks: The hotkey requires both the hooks mentioned above.
- joypoll: The hotkey is implemented by polling the joystick at regular intervals.

## Related

[#InstallKeybdHook](_InstallKeybdHook.htm), [#InstallMouseHook](_InstallMouseHook.htm), [#UseHook](_UseHook.htm), [KeyHistory](KeyHistory.htm), [ListLines](ListLines.htm), [ListVars](ListVars.htm), [#MaxThreadsPerHotkey](_MaxThreadsPerHotkey.htm), [#MaxHotkeysPerInterval](_MaxHotkeysPerInterval.htm)

## Examples

Displays information about the hotkeys used by the current script.

```
ListHotkeys
```

