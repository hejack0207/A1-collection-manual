# systemd\-backlight@\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-backlight@.service, systemd-backlight - Load and save the display backlight brightness at boot and shutdown

<a name="synopsis"></a>

# Synopsis

```

 systemd-backlight@.service 
 /usr/lib/systemd/systemd-backlight
```

<a name="description"></a>

# Description


systemd-backlight@.service
is a service that restores the display backlight brightness at early boot and saves it at shutdown. On disk, the backlight brightness is stored in
/var/lib/systemd/backlight/. During loading, if the udev property
**ID\_BACKLIGHT\_CLAMP**
is not set to false, the brightness is clamped to a value of at least 1 or 5% of maximum brightness, whichever is greater. This restriction will be removed when the kernel allows user space to reliably set a brightness value which does not turn off the display.

<a name="kernel-command-line"></a>

# Kernel Command Line


systemd-backlight
understands the following kernel command line parameter:

_systemd.restore\_state=_
Takes a boolean argument. Defaults to
"1". If
"0", does not restore the backlight settings on boot. However, settings will still be stored on shutdown.

<a name="see-also"></a>

# See Also


**systemd**(1)
