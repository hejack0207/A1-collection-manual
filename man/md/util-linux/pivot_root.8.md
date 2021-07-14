# pivot_root(8) - change the root filesystem

util-linux, August 2011

```
pivot_root new_root put_old
```

<a name="description"></a>

# Description

**pivot\_root** moves the root file system of the current process to the
directory _put\_old_ and makes _new\_root_ the new root file system.
Since **pivot\_root**(8) simply calls **pivot\_root**(2), we refer to
the man page of the latter for further details.

Note that, depending on the implementation of **pivot\_root**, root and
cwd of the caller may or may not change. The following is a sequence for
invoking **pivot\_root** that works in either case, assuming that
**pivot\_root** and **chroot** are in the current **PATH**:

cd _new\_root_  
pivot_root . _put\_old_  
exec chroot . _command_

Note that **chroot** must be available under the old root and under the new
root, because **pivot\_root** may or may not have implicitly changed the
root directory of the shell.

Note that **exec chroot** changes the running executable, which is
necessary if the old root directory should be unmounted afterwards.
Also note that standard input, output, and error may still point to a
device on the old root file system, keeping it busy. They can easily be
changed when invoking **chroot** (see below; note the absence of
leading slashes to make it work whether **pivot\_root** has changed the
shell's root or not).

<a name="options"></a>

# Options


* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="examples"></a>

# Examples

Change the root file system to /dev/hda1 from an interactive shell:

    mount /dev/hda1 /new-root
    cd /new-root
    pivot_root . old-root
    exec chroot . sh <dev/console >dev/console 2>&1
    umount /old-root

Mount the new root file system over NFS from 10.0.0.1:/my_root and run
**init**:

    ifconfig lo 127.0.0.1 up   # for portmap
    # configure Ethernet or such
    portmap   # for lockd (implicitly started by mount)
    mount -o ro 10.0.0.1:/my_root /mnt
    killall portmap   # portmap keeps old root busy
    cd /mnt
    pivot_root . old_root
    exec chroot . sh -c 'umount /old_root; exec /sbin/init' &nbsp; <dev/console >dev/console 2>&1

<a name="see-also"></a>

# See Also

**chroot**(1),
**pivot_root**(2),
**mount**(8),
**switch_root**(8),
**umount**(8)

<a name="availability"></a>

# Availability

The pivot_root command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
