# Pause

Pauses the script's [current thread](../misc/Threads.htm).

```
<span class="func">Pause</span> <span class="optional">, OnOffToggle, OperateOnUnderlyingThread</span>
```

## Parameters

OnOffToggle

If blank or omitted, it defaults to Toggle. Otherwise, specify one of the following words:

**Toggle**: Pauses the [current thread](../misc/Threads.htm) unless the thread beneath it is paused, in which case the underlying thread is unpaused.

**On**: Pauses the current thread.

**Off**: If the thread beneath the current thread is paused, it will be in an unpaused state when resumed. Otherwise, the command has no effect.

[v1.1.30+]: The decimal values 1, 0 and -1 may be used in place of On, Off and Toggle, respectively.

OperateOnUnderlyingThread

This parameter is ignored for `Pause Off` because that always operates on the underlying thread. For the others, it is ignored unless Pause is being turned on (including via Toggle).

Specify one of the following numbers:

**0** (or omitted): The command pauses the current thread; that is, the one now running the Pause command.

**1**: The command marks the thread beneath the current thread as paused so that when it resumes, it will finish the command it was running (if any) and then enter a paused state. If there is no thread beneath the current thread, the script itself is paused, which prevents [timers](SetTimer.htm) from running (this effect is the same as having used the menu item "Pause Script" while the script has no threads).

**Note**: [A\_IsPaused](../Variables.htm#IsPaused) contains the pause state of the underlying thread.

## Remarks

By default, the script can also be paused via its [tray icon](../Program.htm#tray-icon) or [main window](../Program.htm#main-window).

Unlike [Suspend](Suspend.htm) \-\- which disables [hotkeys](../Hotkeys.htm) and [hotstrings](../Hotstrings.htm) \-\- turning on pause will freeze the [current thread](../misc/Threads.htm). As a side-effect, any interrupted threads beneath it will lie dormant.

Whenever any thread is paused, [timers](SetTimer.htm) will not run. By contrast, explicitly launched threads such as [hotkeys](../Hotkeys.htm) and [menu items](Menu.htm) can still be launched; but when their [threads](../misc/Threads.htm) finish, the underlying thread will still be paused. In other words, each thread can be paused independently of the others.

The color of the tray icon changes from green to red whenever the script's [current thread](../misc/Threads.htm) is in a paused state. This color change can be avoided by freezing the icon, which is achieved by specifying 1 for the last parameter of the Menu command. For example:

```
<a href="Menu.htm" data-index="16">Menu</a>, Tray, Icon, C:\My Icon.ico, , 1
```

To disable [timers](SetTimer.htm) without pausing the script, use [Thread, NoTimers](Thread.htm).

A script is always halted (though not officially paused) while it is displaying any kind of [menu](Menu.htm) (tray menu, menu bar, GUI context menu, etc.)

## Related

[Suspend](Suspend.htm), [Menu](Menu.htm), [ExitApp](ExitApp.htm), [Threads](../misc/Threads.htm), [SetTimer](SetTimer.htm)

## Examples

Press a hotkey once to pause the script. Press it again to unpause.

```
Pause::Pause  <em>; The Pause/Break key.</em>
#p::Pause  <em>; Win+P</em>
```

Sends a Pause command to another script.

```
<a href="DetectHiddenWindows.htm" data-index="27">DetectHiddenWindows</a>, On
WM_COMMAND := 0x0111
ID_FILE_PAUSE := 65403
<a href="PostMessage.htm" data-index="28">PostMessage</a>, WM_COMMAND, ID_FILE_PAUSE,,, C:\YourScript.ahk ahk_class AutoHotkey
```

