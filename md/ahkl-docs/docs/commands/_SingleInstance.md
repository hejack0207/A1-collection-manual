# \#SingleInstance

Determines whether a script is allowed to run again when it is already running.

```
<span class="func">#SingleInstance</span> <span class="optional">ForceIgnorePromptOff</span>
```

## Parameters

ForceIgnorePromptOff

If this parameter is omitted, it defaults to _Prompt_. To change this behavior, specify one of the following words:

**Force:** Skips the dialog box and replaces the old instance automatically, which is similar in effect to the [Reload](Reload.htm) command.

**Ignore:** Skips the dialog box and leaves the old instance running. In other words, attempts to launch an already-running script are ignored.

**Prompt:** Displays a dialog box asking whether to keep the old instance or replace it with the new one. This is the default behaviour if this directive is not used.

**Off:** Allows multiple instances of the script to run concurrently.

## Remarks

A script containing [hotkeys](../Hotkeys.htm), [hotstrings](../Hotstrings.htm), [#Persistent](_Persistent.htm), [OnMessage()](OnMessage.htm), or [Gui](Gui.htm) is single-instance (dialog & prompt) by default. Other scripts default to allowing multiple instances. This behavior can be disabled or modified as described above.

This directive is ignored when any of the following [command line switches](../Scripts.htm#cmd) are used: /force /f /restart /r

Like other directives, #SingleInstance cannot be executed conditionally.

## Limitations

Previous instances of the script are identified by searching for a [main window](../Program.htm#main-window) with the [default title](../Program.htm#title). Therefore, a previous instance may not be found if:

- The title of its main window has been changed.
- It is running on a different version of AutoHotkey.
- Its main window is no longer top-level, such as if the script has used[SetParent](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setparent) to change its parent to something other than NULL (0).

At most one previous instance is detected and sent a message asking it to close. Therefore, the following additional limitations also apply:

- If there are multiple instances (such as if previous instances of the script used the`#SingleInstance Off` mode), the topmost matching instance is sent the message, and other instances are not considered.
- If the previous instance is running at a higher integrity level than the new instance (where running as administrator >[running with UI access](../Program.htm#Installer_uiAccess) \> normal), it cannot be closed due to security restrictions.

If multiple instances of the script are started simultaneously, they may fail to detect each other or may all target the same previous instance. This would result in multiple instances of the script starting.

## Related

[Reload](Reload.htm), [#Persistent](_Persistent.htm)

## Examples

Skips the dialog box and replaces the old instance automatically.

```
#SingleInstance Force
```

