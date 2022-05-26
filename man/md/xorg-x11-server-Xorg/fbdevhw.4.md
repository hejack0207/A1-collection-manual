# fbdevhw(4) - os-specific submodule for framebuffer device access

X Version 11, xorg-server 1.20.11


<a name="description"></a>

# Description

**fbdevhw**
provides functions for talking to a framebuffer device.  It is
os-specific.  It is a submodule used by other video drivers.
A
**fbdevhw**
module is currently available for linux framebuffer devices.

fbdev(4) is a non-accelerated driver which runs on top of the
fbdevhw module.  fbdevhw can be used by other drivers too, this
is usually activated with \`Option "UseFBDev"' in the device section.

<a name="see-also"></a>

# See Also

Xorg(1), xorg.conf(5),
xorgconfig(1), Xserver(1), X(7),
fbdev(4)

<a name="authors"></a>

# Authors

Authors include: Gerd Knorr, based on the XF68_FBDev Server code
(Martin Schaller, Geert Uytterhoeven).
