# Suspend

Disables or enables all or selected [hotkeys](../Hotkeys.htm) and [hotstrings](../Hotstrings.htm).

```
<span class="func">Suspend</span> <span class="optional">, Mode</span>
```

## Parameters

Mode

**On**: Suspends all [hotkeys](../Hotkeys.htm) and [hotstrings](../Hotstrings.htm) except those explained the Remarks section.

**Off**: Re-enables the hotkeys and hotstrings that were disable above.

**Toggle** (default): Changes to the opposite of its previous state (On or Off).

**Permit**: Does nothing except mark the current subroutine as being exempt from suspension.

[v1.1.30+]: The decimal values 1, 0 and -1 may be used in place of On, Off and Toggle, respectively.

## Remarks

By default, the script can also be suspended via its [tray icon](../Program.htm#tray-icon) or [main window](../Program.htm#main-window).

Any hotkey/hotstring subroutine whose very first line is Suspend (except `Suspend On`) will be exempt from suspension. In other words, the hotkey will remain enabled even while suspension is ON. This allows suspension to be turned off via such a hotkey.

The [keyboard](_InstallKeybdHook.htm) and/or [mouse](_InstallMouseHook.htm) hooks will be installed or removed if justified by the changes made by this command.

To disable selected hotkeys or hotstrings automatically based on the type of window that is present, use [#IfWinActive/Exist](_IfWinActive.htm).

Suspending a script's hotkeys does not stop the script's already-running [threads](../misc/Threads.htm) (if any); use [Pause](Pause.htm) to do that.

When a script's hotkeys are suspended, its tray icon changes to the letter S. This can be avoided by freezing the icon, which is done by specifying 1 for the last parameter of the Menu command. For example:

```
<a href="Menu.htm" data-index="12">Menu</a>, Tray, Icon, C:\My Icon.ico, , 1
```

The built-in variable [A\_IsSuspended](../Variables.htm#IsSuspended) contains 1 if the script is suspended and 0 otherwise.

## Related

[#IfWinActive/Exist](_IfWinActive.htm), [Pause](Pause.htm), [Menu](Menu.htm), [ExitApp](ExitApp.htm)

## Examples

Press a hotkey once to suspend all hotkeys and hotstrings. Press it again to unsuspend.

```
^!s::Suspend  <em>; Ctrl+Alt+S</em>
```

Sends a Suspend command to another script.

```
<a href="DetectHiddenWindows.htm" data-index="20">DetectHiddenWindows</a>, On
WM_COMMAND := 0x0111
ID_FILE_SUSPEND := 65404
<a href="PostMessage.htm" data-index="21">PostMessage</a>, WM_COMMAND, ID_FILE_SUSPEND,,, C:\YourScript.ahk ahk_class AutoHotkey
```

