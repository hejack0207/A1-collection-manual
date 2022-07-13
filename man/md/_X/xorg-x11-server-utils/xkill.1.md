# xkill(1) - kill a client by its X resource

X Version 11, xkill 1.0.5

```
"xkill" [-display displayname] [-id resource] [-button number] [-frame] [-all] [-version]
```

<a name="description"></a>

# Description


_Xkill_
is a utility for forcing the X server to close connections to clients.  This
program is very dangerous, but is useful for aborting programs that have
displayed undesired windows on a user's screen.  If no resource identifier
is given with _-id_, _xkill_ will display a special cursor
as a prompt for the user to select a window to be killed.  If a pointer button
is pressed over a non-root window, the server will close its connection to
the client that created the window.

<a name="options"></a>

# Options


* **-display _displayname_**  
  This option specifies the name of the X server to contact.
* **-id _resource_**  
  This option specifies the X identifier for the resource whose creator is
  to be aborted.  If no resource is specified, _xkill_ will display a
  special cursor with which you should select a window to be kill.
* **-button _number_**  
  This option specifies the number of pointer button
  that should be used in selecting a window to kill.
  If the word "any" is specified, any button on the pointer may be used.  By
  default, the first button in the pointer map (which is usually the leftmost
  button) is used.
* **-all**  
  This option indicates that all clients with top-level windows on the screen
  should be killed.  _Xkill_ will ask you to select the root window with
  each of the currently defined buttons to give you several chances to abort.
  Use of this option is highly discouraged.
* **-frame**  
  This option indicates that xkill should ignore the standard conventions for
  finding top-level client windows (which are typically nested inside a window
  manager window), and simply believe that you want to kill direct children of
  the root.
* **-version**  
  This option makes xkill print its version and exit without killing anything.

<a name="caveats"></a>

# Caveats

This command does not provide any warranty that the application whose
connection to the X server is closed will abort nicely, or even abort
at all. All this command does is to close the connection to the X
server. Many existing applications do indeed abort when their
connection to the X server is closed, but some can choose to
continue.

<a name="xdefaults"></a>

# Xdefaults


* **Button**  
  Specifies a specific pointer button number or the word "any" to use when
  selecting windows.

<a name="see-also"></a>

# See Also

X(7), xwininfo(1),
XKillClient(3), XGetPointerMapping(3),
KillClient in the X Protocol Specification

<a name="author"></a>

# Author

Jim Fulton, MIT X Consortium  
Dana Chee, Bellcore
