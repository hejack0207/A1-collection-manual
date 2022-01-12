# nmtui(1)

NetworkManager 1\&.16\&.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nmtui - Text User Interface for controlling NetworkManager

<a name="synopsis"></a>

# Synopsis

```
.HP \w'nmtui-edit&nbsp;|&nbsp;nmtui&nbsp;edit&nbsp;&nbsp;'u nmtui-edit | nmtui&nbsp;edit  {name&nbsp;|&nbsp;id} .HP \w'nmtui-connect&nbsp;|&nbsp;nmtui&nbsp;connect&nbsp;&nbsp;'u nmtui-connect | nmtui&nbsp;connect  {name&nbsp;|&nbsp;uuid&nbsp;|&nbsp;device&nbsp;|&nbsp;SSID} .HP \w'nmtui-hostname&nbsp;|&nbsp;nmtui&nbsp;hostname&nbsp;&nbsp;'u nmtui-hostname | nmtui&nbsp;hostname 
```

<a name="description"></a>

# Description


**nmtui**
is a curses-based TUI application for interacting with NetworkManager. When starting
**nmtui**, the user is prompted to choose the activity to perform unless it was specified as the first argument.

The supported activities are:

**edit**
Show a connection editor that supports adding, modifying, viewing and deleting connections. It provides similar functionality as
**nm-connection-editor**.

**connect**
Show a list of available connections, with the option to activate or deactivate them. It provides similar functionality as
**nm-applet**.

**hostname**
Set the system hostname.

Corresponding to above activities,
**nmtui**
also comes with binaries named
**nmtui-edit**,
**nmtui-connect**, and
**nmtui-hostname**
to skip the selection of the activities.

<a name="see-also"></a>

# See Also


**nmcli**(1),
**nm-applet**(1),
**nm-connection-editor**(1),
**NetworkManager**(8).
