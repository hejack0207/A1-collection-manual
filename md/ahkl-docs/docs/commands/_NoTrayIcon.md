# \#NoTrayIcon

Disables the showing of a [tray icon](../Program.htm#tray-icon).

```
<span class="func">#NoTrayIcon</span>
```

Specifying this anywhere in a script will prevent the showing of a tray icon for that script when it is launched (even if the script is compiled into an EXE).

If you use this for a script that has hotkeys, you might want to bind a hotkey to the [ExitApp](ExitApp.htm) command. Otherwise, there will be no easy way to exit the program (without restarting the computer or killing the process). For example: `#x::ExitApp`.

The tray icon can be made to disappear or reappear at any time during the execution of the script by using the command `<a href="Menu.htm" data-index="3">Menu</a>, Tray, Icon` or `<a href="Menu.htm" data-index="4">Menu</a>, Tray, NoIcon`. The only drawback of using `<a href="Menu.htm" data-index="5">Menu</a>, Tray, NoIcon` at the very top of the script is that the tray icon might be briefly visible when the script is first launched. To avoid that, use #NoTrayIcon instead.

The built-in variable **A\_IconHidden** contains 1 if the tray icon is currently hidden or 0 otherwise.

Like other directives, #NoTrayIcon cannot be executed conditionally.

## Related

[Tray Icon](../Program.htm#tray-icon), [Menu](Menu.htm), [ExitApp](ExitApp.htm)

## Examples

Causes the script to launch without a tray icon.

```
#NoTrayIcon
```

