# systemd\-remount\-fs\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-remount-fs.service, systemd-remount-fs - Remount root and kernel file systems

<a name="synopsis"></a>

# Synopsis

```

 systemd-remount-fs.service 
 /usr/lib/systemd/systemd-remount-fs
```

<a name="description"></a>

# Description


systemd-remount-fs.service
is an early boot service that applies mount options listed in
**fstab**(5)
to the root file system, the
/usr
file system, and the kernel API file systems. This is required so that the mount options of these file systems — which are pre-mounted by the kernel, the initial RAM disk, container environments or system manager code — are updated to those listed in
/etc/fstab. This service ignores normal file systems and only changes the root file system (i.e.
/),
/usr
and the virtual kernel API file systems such as
/proc,
/sys
or
/dev. This service executes no operation if
/etc/fstab
does not exist or lists no entries for the mentioned file systems.

For a longer discussion of kernel API file systems see
\m[blue]**API File Systems**\m[]\s-2\u[1]\d\s+2.

<a name="see-also"></a>

# See Also


**systemd**(1),
**fstab**(5),
**mount**(8)

<a name="notes"></a>

# Notes


*  1.  
  API File Systems
      https://www.freedesktop.org/wiki/Software/systemd/APIFileSystems
