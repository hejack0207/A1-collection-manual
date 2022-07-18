# \#Persistent

Keeps a script permanently running (that is, until the user closes it or [ExitApp](ExitApp.htm) is encountered).

```
<span class="func">#Persistent</span>
```

A script is persistent if any of the following conditions are true:

- At least one[hotkey](../Hotkeys.htm) or [hotstring](../Hotstrings.htm) has been defined in the script or created by the [Hotkey](Hotkey.htm) command or [Hotstring](Hotstring.htm) function, even if it is not enabled.
- The[keyboard hook](_InstallKeybdHook.htm) or [mouse hook](_InstallMouseHook.htm) is installed.
- The script contains any use of[Gui](Gui.htm), even if it has not been called.
- The script contains any use of[OnMessage](OnMessage.htm), or has called it dynamically or retrieved a reference with [Func](Func.htm).
- The[Input](Input.htm) command has been called.
- The #Persistent directive is present anywhere in the script.

Use this directive to prevent the script from exiting after the [auto-execute section](../Scripts.htm#auto) (top part of the script) completes. This is useful in cases where a script contains [timers](SetTimer.htm) and/or [custom menu items](Menu.htm) but does not meet any of the other conditions listed above.

If this directive is added to an existing script, you might want to change some or all occurrences of [Exit](Exit.htm) to be [ExitApp](ExitApp.htm). This is because [Exit](Exit.htm) will not terminate a persistent script; it terminates only the [current thread](../misc/Threads.htm).

[v1.0.16+]: This directive also makes a script single-instance. To override this or change the way single-instance behaves, see [#SingleInstance](_SingleInstance.htm).

Like other directives, #Persistent cannot be executed conditionally.

## Related

[#SingleInstance](_SingleInstance.htm), [SetTimer](SetTimer.htm), [Menu](Menu.htm), [Exit](Exit.htm), [ExitApp](ExitApp.htm)

## Examples

Causes the script to run permanently; that is, it will not exit automatically if it could.

```
#Persistent
```

