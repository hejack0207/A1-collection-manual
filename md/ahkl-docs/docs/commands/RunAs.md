# RunAs

Specifies a set of user credentials to use for all subsequent uses of [Run](Run.htm) and [RunWait](Run.htm).

```
<span class="func">RunAs</span> <span class="optional">, User, Password, Domain</span>
```

## Parameters

User

If this and the other parameters are all omitted, the RunAs feature will be turned off, which restores [Run](Run.htm) and [RunWait](Run.htm) to their default behavior. Otherwise, this is the username under which new processes will be created.

Password

_User_'s password.

Domain

_User_'s domain. To use a local account, leave this blank. If that fails to work, try using @YourComputerName.

## Remarks

If the script is running with restricted privileges due to User Account Control (UAC), any programs it launches will typically also be restricted, even if RunAs is used. To elevate a process, use [Run \*RunAs](Run.htm#RunAs) instead.

This command does nothing other than notify AutoHotkey to use (or not use) alternate user credentials for all subsequent uses of [Run](Run.htm) and [RunWait](Run.htm).

[ErrorLevel](../misc/ErrorLevel.htm) is not changed by this command. If an invalid _User_, _Password_, or _Domain_ is specified, [Run](Run.htm) and [RunWait](Run.htm) will display an error message explaining the problem (unless their [UseErrorLevel option](Run.htm#UseErrorLevel) is in effect).

While the RunAs feature is in effect, [Run](Run.htm) and [RunWait](Run.htm) will not able to launch documents, URLs, or system verbs. In other words, the file to be launched must be an executable file.

The "Secondary Logon" service must be set to manual or automatic for this command to work (the OS should automatically start it upon demand if set to manual).

## Related

[Run](Run.htm), [RunWait](Run.htm)

## Examples

Opens the registry editor as administrator.

```
RunAs, Administrator, MyPassword
Run, RegEdit.exe
RunAs  <em>; Reset to normal behavior.</em>
```

