# dracut\&.bootup(7)

dracut 050, 03/04/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dracut.bootup - boot ordering in the initramfs

<a name="description"></a>

# Description


This flow chart illustrates the ordering of the services, if systemd is used in the dracut initramfs.

.if n \{.RS 4
.\}
                                        systemd-journal.socket
                                                   |
                                                   v
                                        dracut-cmdline.service
                                                   |
                                                   v
                                        dracut-pre-udev.service
                                                   |
                                                   v
                                         systemd-udevd.service
                                                   |
                                                   v
    local-fs-pre.target                dracut-pre-trigger.service
             |                                     |
             v                                     v
     (various mounts)  (various swap  systemd-udev-trigger.service
             |           devices...)               |             (various low-level   (various low-level
             |               |                     |             services: seed,       API VFS mounts:
             v               v                     v             tmpfiles, random     mqueue, configfs,
      local-fs.target   swap.target     dracut-initqueue.service    sysctl, ...)        debugfs, ...)
             |               |                     |                    |                    |
             e_______________|____________________ | ___________________|____________________/
                                                  e|/
                                                   v
                                            sysinit.target
                                                   |
                                 _________________/|e___________________
                                /                  |                    e
                                |                  |                    |
                                v                  |                    v
                            (various               |              rescue.service
                           sockets...)             |                    |
                                |                  |                    v
                                v                  |              rescue.target
                         sockets.target            |
                                |                  |
                                e_________________ |                                 emergency.service
                                                  e|                                         |
                                                   v                                         v
                                             basic.target                             emergency.target
                                                   |
                            ______________________/|
                           /                       |
                           |                       v
                           |            dracut-pre-mount.service
                           |                       |
                           |                       v
                           |                  sysroot.mount
                           |                       |
                           |                       v
                           |             initrd-root-fs.target
               (custom initrd services)            |
                           |                       v
                           |             dracut-mount.service
                           |                       |
                           |                       v
                           |            initrd-parse-etc.service
                           |                       |
                           |                       v
                           |            (sysroot-usr.mount and
                           |             various mounts marked
                           |               with fstab option
                           |                x-initrd.mount)
                           |                       |
                           |                       v
                           |                initrd-fs.target
                           e______________________ |
                                                  e|
                                                   v
                                              initrd.target
                                                   |
                                                   v
                                        dracut-pre-pivot.service
                                                   |
                                                   v
                                         initrd-cleanup.service
                                              isolates to
                                        initrd-switch-root.target
                                                   |
                                                   v
                            ______________________/|
                           /                       |
                           |        initrd-udevadm-cleanup-db.service
                           |                       |
               (custom initrd services)            |
                           |                       |
                           e______________________ |
                                                  e|
                                                   v
                                       initrd-switch-root.target
                                                   |
                                                   v
                                       initrd-switch-root.service
                                                   |
                                                   v
                                              switch-root
.if n \{.RE
.\}

<a name="author"></a>

# Author


Harald Hoyer

<a name="see-also"></a>

# See Also


**dracut**(8) **bootup**(7)
