# Overriding or Disabling Hotkeys

You can disable all built-in Windows hotkeys except Win+L and Win+U by making the following change to the registry (this should work on all OSes but a reboot is probably required):

```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer
NoWinKeys REG_DWORD 0x00000001 (1)
```

But read on if you want to do more than just disable them all.

Hotkeys owned by another application can be overridden or disabled simply by assigning them to an action in the script. The most common use for this feature is to change the hotkeys that are built into Windows itself. For example, if you wish Win+E (the shortcut key that launches Windows Explorer) to perform some other action, use this:

```
#e::
MsgBox This hotkey is now owned by the script.
return
```

In the next example, the Win+R hotkey, which is used to open the RUN window, is completely disabled:

```
#r::return
```

Similarly, to disable both Win, use this:

```
LWin::return
RWin::return
```

To disable or change an application's non-global hotkey (that is, a shortcut key that only works when that application is the active window), consider the following example which disables Ctrl+P (Print) only for Notepad, leaving the key in effect for all other types of windows:

```
$^p::
if WinActive("ahk_class Notepad")
    return  <em>; i.e. do nothing, which causes Control-P to do nothing in Notepad.</em>
Send ^p
return
```

In the above example, the $ prefix is needed so that the hotkey can "send itself" without activating itself (which would otherwise trigger a warning dialog about an infinite loop). See also: [context-sensitive hotkeys](../Hotkeys.htm#Context).

You can try out any of the above examples by copying them into a new text file such as "Override.ahk", then launching the file.

