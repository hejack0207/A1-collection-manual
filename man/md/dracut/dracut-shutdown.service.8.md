# dracut\-shutdown\&.s(8)

dracut, 03/04/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dracut-shutdown.service - unpack the initramfs to /run/initramfs

<a name="synopsis"></a>

# Synopsis

```

 dracut-shutdown.service
```

<a name="description"></a>

# Description


This service unpacks the initramfs image to /run/initramfs. systemd pivots into /run/initramfs at shutdown, so the root filesystem can be safely unmounted.

The following steps are executed during a shutdown:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  systemd switches to the shutdown.target

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  systemd starts /lib/systemd/system/shutdown.target.wants/dracut-shutdown.service

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  dracut-shutdown.service executes /usr/lib/dracut/dracut-initramfs-restore which unpacks the initramfs to /run/initramfs

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  systemd finishes shutdown.target

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  systemd kills all processes

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  systemd tries to unmount everything and mounts the remaining read-only

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  systemd checks, if there is a /run/initramfs/shutdown executable

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  if yes, it does a pivot_root to /run/initramfs and executes ./shutdown. The old root is then mounted on /oldroot. /usr/lib/dracut/modules.d/99shutdown/shutdown.sh is the shutdown executable.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  shutdown will try to umount every /oldroot mount and calls the various shutdown hooks from the dracut modules

This ensures, that all devices are disassembled and unmounted cleanly.

To debug the shutdown process, you can get a shell in the shutdown procedure by injecting "rd.break=pre-shutdown rd.shell" or "rd.break=shutdown rd.shell".

.if n \{.RS 4
.\}
    # mkdir -p /run/initramfs/etc/cmdline.d
    # echo "rd.break=pre-shutdown rd.shell" > /run/initramfs/etc/cmdline.d/debug.conf
    # touch /run/initramfs/.need_shutdown
.if n \{.RE
.\}

<a name="authors"></a>

# Authors


Harald Hoyer

<a name="see-also"></a>

# See Also


**dracut**(8)
