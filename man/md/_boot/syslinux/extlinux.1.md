# extlinux(1) - install the \s-1SYSLINUX\s+1 bootloader on a ext2/ext3 filesystem

SYSLINUX for ext2/ext3 filesystem, 18 December 2007

```
extlinux [options] directory
```

<a name="description"></a>

# Description

**EXTLINUX** is a new syslinux derivative, which boots from a Linux ext2/ext3
filesystem.  It works the same way as **SYSLINUX**, with a few slight modifications.
It is intended to simplify first-time installation of Linux, and for creation of
rescue and other special-purpose boot disks.

The installer is designed to be run on a mounted directory.  For example, if you have an
ext2 or ext3 usb key mounted on /mnt, you can run the following command:

* **extlinux --install /mnt**

<a name="options"></a>

# Options


* **-H**, **--heads**=#  
  Force the number of heads.
* **-i**, **--install**  
  Install over the current bootsector.
* **-O**, **--clear-once**  
  Clear the boot-once command.
* **-o**, **--once**=_command_  
  Execute a command once upon boot.
* **-M**, **--menu-save**=_label_  
  Set the label to select as default on the next boot
* **-r**, **--raid**  
  Fall back to the next device on boot failure.
* **--reset-adv**  
  Reset auxiliary data.
* **-S**, **--sectors**=_#_  
  Force the number of sectors per track.
* **-U**, **--update**  
  Updates a previous **EXTLINUX** installation.
* **-z**, **--zip**  
  Force zipdrive geometry (-H 64 -S 32).
* **--device**=_devicename_  
  Override the automatic detection of device names.  This option is
  intended for special environments only and should not be used by
  normal users.  Misuse of this option can cause disk corruption and
  lost data.

<a name="files"></a>

# Files

The extlinux configuration file needs to be named syslinux.cfg or
extlinux.conf and needs to be stored in the extlinux installation
directory. For more information about the contents of extlinux.conf,
see syslinux(1) manpage, section files.

<a name="bugs"></a>

# Bugs

I would appreciate hearing of any problems you have with \s-1SYSLINUX\s+1.  I
would also like to hear from you if you have successfully used \s-1SYSLINUX\s+1,
especially if you are using it for a distribution.

If you are reporting problems, please include all possible information
about your system and your BIOS; the vast majority of all problems
reported turn out to be BIOS or hardware bugs, and I need as much
information as possible in order to diagnose the problems.

There is a mailing list for discussion among \s-1SYSLINUX\s+1 users and for
announcements of new and test versions. To join, send a message to
majordomo@linux.kernel.org with the line:

<a name="see-also"></a>

# See Also

**syslinux**(1)
