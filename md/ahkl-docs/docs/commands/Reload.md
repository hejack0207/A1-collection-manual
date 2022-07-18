# Reload

Replaces the currently running instance of the script with a new one.

```
<span class="func">Reload</span>
```

This command is useful for scripts that are frequently changed. By assigning a hotkey to this command, you can easily restart the script after saving your changes in an editor.

By default, the script can also be reloaded via its [tray icon](../Program.htm#tray-icon) or [main window](../Program.htm#main-window).

[v1.1.34+]: If the [/include](../Scripts.htm#SlashInclude) switch was passed to the script's current instance, it is automatically passed to the new instance.

Any other [command-line parameters](../Scripts.htm#cmd) passed to the script's current instance are not passed to the new instance. To pass such parameters, do not use Reload. Instead, use [Run](Run.htm) in conjunction with [A\_AhkPath](../Variables.htm#AhkPath) and [A\_ScriptFullPath](../Variables.htm#ScriptFullPath) (and [A\_IsCompiled](../Variables.htm#IsCompiled) if the script is ever used in compiled form). Also, include the string `/restart` as the first parameter (i.e. after the name of the executable), which tells the program to use the same behavior as Reload. See also: [command line switches and syntax](../Scripts.htm#cmd).

When the script restarts, it is launched in its original working directory (the one that was in effect when it was first launched). In other words, [SetWorkingDir](SetWorkingDir.htm) will not change the working directory that will be used for the new instance.

If the script cannot be reloaded -- perhaps because it has a syntax error -- the original instance of the script will continue running. Therefore, the reload command should be followed by whatever actions you want taken in the event of a failure (such as a [return](Return.htm) to exit the current subroutine). To have the original instance detect the failure, follow this example:

```
Reload
Sleep 1000 <em>; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.</em>
MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
IfMsgBox, Yes, Edit
return
```

Previous instances of the script are identified by the same mechanism as for [#SingleInstance](_SingleInstance.htm), with the same [limitations](_SingleInstance.htm#Limitations).

If the script allows multiple instances, Reload may fail to identify the correct instance. The simplest alternative is to [Run](Run.htm) a new instance and then exit. For example:

```
if A_IsCompiled
    Run "%A_ScriptFullPath%" /force
else
    Run "%A_AhkPath%" /force "%A_ScriptFullPath%"
ExitApp
```

## Related

[Edit](Edit.htm)

## Examples

Press a hotkey to restart the script.

```
^!r::Reload  <em>; Ctrl+Alt+R</em>
```

