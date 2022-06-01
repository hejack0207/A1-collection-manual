# xsetpointer(1) - set an X Input device as the main pointer

X Version 11, xsetpointer 1.0.1

```
xsetpointer -l | device-name
```

<a name="description"></a>

# Description

Xsetpointer sets an XInput device as the main pointer.  When called with
the -l flag it lists the available devices.  When called with the -c/+c
flag, it toggles the sending of core input events, for servers which
implement a virtual core pointer; -c disables core events, and +c enables.

<a name="author"></a>

# Author

Frederic Lepied
