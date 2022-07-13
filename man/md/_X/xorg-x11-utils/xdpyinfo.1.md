# xdpyinfo(1) - display information utility for X

X Version 11, xdpyinfo 1.3.2

```
"xdpyinfo" [-display displayname] [-queryExtensions] [-ext extension-name] [-version]
```

<a name="description"></a>

# Description


_Xdpyinfo_
is a utility for displaying information about an X server.  It is used to
examine the
capabilities of a server, the predefined values for various parameters used
in communicating between clients and the server, and the different types of
screens and visuals that are available.

By default, numeric information (opcode, base event, base error) about
protocol extensions is not displayed.  This information can be obtained
with the **-queryExtensions** option.  Use of this option on servers
that dynamically load extensions will likely cause all possible extensions
to be loaded, which can be slow and can consume significant server resources.

Detailed information about a particular extension is displayed with the
**-ext** _extensionName_ option.  If _extensionName_ is
**all**, information about all extensions supported by both _xdpyinfo_
and the server is displayed.

If **-version** is specified, xdpyinfo prints its version and exits, without
contacting the X server.

<a name="environment"></a>

# Environment



* **DISPLAY**  
  To get the default host, display number, and screen.

<a name="see-also"></a>

# See Also

_X_(7),
_xprop_(1),
_xrdb_(1),
_xwininfo_(1),
_xrandr_(1),
_xdriinfo_(1),
_xvinfo_(1),
_glxinfo_(1)

<a name="author"></a>

# Author

Jim Fulton, MIT X Consortium  
Support for the XFree86-VidModeExtension, XFree86-DGA, XFree86-Misc,
and XKB extensions added by Joe Moss
