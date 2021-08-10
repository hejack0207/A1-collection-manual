# dracut(8)

Version 050, 03/04/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dracut - low-level tool for generating an initramfs/initrd image

<a name="synopsis"></a>

# Synopsis

```

 dracut [OPTION...] [<image> [<kernel version>]]
```

<a name="description"></a>

# Description


Create an initramfs &lt;image&gt; for the kernel with the version &lt;kernel version&gt;. If &lt;kernel version&gt; is omitted, then the version of the actual running kernel is used. If &lt;image&gt; is omitted or empty, then the default location /boot/initramfs-&lt;kernel version&gt;.img is used.

dracut creates an initial image used by the kernel for preloading the block device modules (such as IDE, SCSI or RAID) which are needed to access the root filesystem, mounting the root filesystem and booting into the real system.

At boot time, the kernel unpacks that archive into RAM disk, mounts and uses it as initial root file system. All finding of the root device happens in this early userspace.

Initramfs images are also called "initrd".

For a complete list of kernel command line options see **dracut.cmdline**(7).

If you are dropped to an emergency shell, while booting your initramfs, the file _/run/initramfs/rdsosreport.txt_ is created, which can be saved to a (to be mounted by hand) partition (usually /boot) or a USB stick. Additional debugging info can be produced by adding **rd.debug** to the kernel command line. _/run/initramfs/rdsosreport.txt_ contains all logs and the output of some tools. It should be attached to any report about dracut problems.

<a name="usage"></a>

# Usage


To create a initramfs image, the most simple command is:

.if n \{.RS 4
.\}
    # dracut
.if n \{.RE
.\}

This will generate a general purpose initramfs image, with all possible functionality resulting of the combination of the installed dracut modules and system tools. The image is /boot/initramfs-_&lt;kernel version&gt;_.img and contains the kernel modules of the currently active kernel with version _&lt;kernel version&gt;_.

If the initramfs image already exists, dracut will display an error message, and to overwrite the existing image, you have to use the --force option.

.if n \{.RS 4
.\}
    # dracut --force
.if n \{.RE
.\}

If you want to specify another filename for the resulting image you would issue a command like:

.if n \{.RS 4
.\}
    # dracut foobar.img
.if n \{.RE
.\}

To generate an image for a specific kernel version, the command would be:

.if n \{.RS 4
.\}
    # dracut foobar.img 2.6.40-1.rc5.f20
.if n \{.RE
.\}

A shortcut to generate the image at the default location for a specific kernel version is:

.if n \{.RS 4
.\}
    # dracut --kver 2.6.40-1.rc5.f20
.if n \{.RE
.\}

If you want to create lighter, smaller initramfs images, you may want to specify the --hostonly or -H option. Using this option, the resulting image will contain only those dracut modules, kernel modules and filesystems, which are needed to boot this specific machine. This has the drawback, that you can’t put the disk on another controller or machine, and that you can’t switch to another root filesystem, without recreating the initramfs image. The usage of the --hostonly option is only for experts and you will have to keep the broken pieces. At least keep a copy of a general purpose image (and corresponding kernel) as a fallback to rescue your system.

<a name="inspecting-the-contents"></a>

### Inspecting the Contents


To see the contents of the image created by dracut, you can use the lsinitrd tool.

.if n \{.RS 4
.\}
    # lsinitrd | less
.if n \{.RE
.\}

To display the contents of a file in the initramfs also use the lsinitrd tool:

.if n \{.RS 4
.\}
    # lsinitrd -f /etc/ld.so.conf
    include ld.so.conf.d/*.conf
.if n \{.RE
.\}

<a name="adding-dracut-modules"></a>

### Adding dracut Modules


Some dracut modules are turned off by default and have to be activated manually. You can do this by adding the dracut modules to the configuration file _/etc/dracut.conf_ or _/etc/dracut.conf.d/myconf.conf_. See **dracut.conf**(5). You can also add dracut modules on the command line by using the -a or --add option:

.if n \{.RS 4
.\}
    # dracut --add bootchart initramfs-bootchart.img
.if n \{.RE
.\}

To see a list of available dracut modules, use the --list-modules option:

.if n \{.RS 4
.\}
    # dracut --list-modules
.if n \{.RE
.\}

<a name="omitting-dracut-modules"></a>

### Omitting dracut Modules


Sometimes you don’t want a dracut module to be included for reasons of speed, size or functionality. To do this, either specify the omit_dracutmodules variable in the _dracut.conf_ or _/etc/dracut.conf.d/myconf.conf_ configuration file (see **dracut.conf**(5)), or use the -o or --omit option on the command line:

.if n \{.RS 4
.\}
    # dracut -o "multipath lvm" no-multipath-lvm.img
.if n \{.RE
.\}

<a name="adding-kernel-modules"></a>

### Adding Kernel Modules


If you need a special kernel module in the initramfs, which is not automatically picked up by dracut, you have the use the --add-drivers option on the command line or the drivers variable in the _/etc/dracut.conf_ or _/etc/dracut.conf.d/myconf.conf_ configuration file (see **dracut.conf**(5)):

.if n \{.RS 4
.\}
    # dracut --add-drivers mymod initramfs-with-mymod.img
.if n \{.RE
.\}

<a name="boot-parameters"></a>

### Boot parameters


An initramfs generated without the "hostonly" mode, does not contain any system configuration files (except for some special exceptions), so the configuration has to be done on the kernel command line. With this flexibility, you can easily boot from a changed root partition, without the need to recompile the initramfs image. So, you could completely change your root partition (move it inside a md raid with encryption and LVM on top), as long as you specify the correct filesystem LABEL or UUID on the kernel command line for your root device, dracut will find it and boot from it.

The kernel command line can also be provided by the dhcp server with the root-path option. See the section called “Network Boot”.

For a full reference of all kernel command line parameters, see **dracut.cmdline**(5).

To get a quick start for the suitable kernel command line on your system, use the _--print-cmdline_ option:

.if n \{.RS 4
.\}
    # dracut --print-cmdline
     root=UUID=8b8b6f91-95c7-4da2-831b-171e12179081 rootflags=rw,relatime,discard,data=ordered rootfstype=ext4
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Specifying the root Device**

This is the only option dracut really needs to boot from your root partition. Because your root partition can live in various environments, there are a lot of formats for the root= option. The most basic one is root=_&lt;path to device node&gt;_:

.if n \{.RS 4
.\}
    root=/dev/sda2
.if n \{.RE
.\}

Because device node names can change, dependent on the drive ordering, you are encouraged to use the filesystem identifier (UUID) or filesystem label (LABEL) to specify your root partition:

.if n \{.RS 4
.\}
    root=UUID=19e9dda3-5a38-484d-a9b0-fa6b067d0331
.if n \{.RE
.\}

or

.if n \{.RS 4
.\}
    root=LABEL=myrootpartitionlabel
.if n \{.RE
.\}

To see all UUIDs or LABELs on your system, do:

.if n \{.RS 4
.\}
    # ls -l /dev/disk/by-uuid
.if n \{.RE
.\}

or

.if n \{.RS 4
.\}
    # ls -l /dev/disk/by-label
.if n \{.RE
.\}

If your root partition is on the network see the section called “Network Boot”.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Keyboard Settings**

If you have to input passwords for encrypted disk volumes, you might want to set the keyboard layout and specify a display font.

A typical german kernel command line would contain:

.if n \{.RS 4
.\}
    rd.vconsole.font=eurlatgr rd.vconsole.keymap=de-latin1-nodeadkeys rd.locale.LANG=de_DE.UTF-8
.if n \{.RE
.\}

Setting these options can override the setting stored on your system, if you use a modern init system, like systemd.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Blacklisting Kernel Modules**

Sometimes it is required to prevent the automatic kernel module loading of a specific kernel module. To do this, just add rd.blacklist=_&lt;kernel module name&gt;_, with _&lt;kernel module name&gt;_ not containing the _.ko_ suffix, to the kernel command line. For example:

.if n \{.RS 4
.\}
    rd.driver.blacklist=mptsas rd.driver.blacklist=nouveau
.if n \{.RE
.\}

The option can be specified multiple times on the kernel command line.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Speeding up the Boot Process**

If you want to speed up the boot process, you can specify as much information for dracut on the kernel command as possible. For example, you can tell dracut, that you root partition is not on a LVM volume or not on a raid partition, or that it lives inside a specific crypto LUKS encrypted volume. By default, dracut searches everywhere. A typical dracut kernel command line for a plain primary or logical partition would contain:

.if n \{.RS 4
.\}
    rd.luks=0 rd.lvm=0 rd.md=0 rd.dm=0
.if n \{.RE
.\}

This turns off every automatic assembly of LVM, MD raids, DM raids and crypto LUKS.

Of course, you could also omit the dracut modules in the initramfs creation process, but then you would lose the possibility to turn it on on demand.

<a name="injecting-custom-files"></a>

### Injecting custom Files


To add your own files to the initramfs image, you have several possibilities.

The --include option let you specify a source path and a target path. For example

.if n \{.RS 4
.\}
    # dracut --include cmdline-preset /etc/cmdline.d/mycmdline.conf initramfs-cmdline-pre.img
.if n \{.RE
.\}

will create an initramfs image, where the file cmdline-preset will be copied inside the initramfs to _/etc/cmdline.d/mycmdline.conf_. --include can only be specified once.

.if n \{.RS 4
.\}
    # mkdir -p rd.live.overlay/etc/cmdline.d
    # mkdir -p rd.live.overlay/etc/conf.d
    # echo "ip=dhcp" >> rd.live.overlay/etc/cmdline.d/mycmdline.conf
    # echo export FOO=testtest >> rd.live.overlay/etc/conf.d/testvar.conf
    # echo export BAR=testtest >> rd.live.overlay/etc/conf.d/testvar.conf
    # tree rd.live.overlay/
    rd.live.overlay/
    `-- etc
        |-- cmdline.d
        |   `-- mycmdline.conf
        `-- conf.d
            `-- testvar.conf
    
    # dracut --include rd.live.overlay / initramfs-rd.live.overlay.img
.if n \{.RE
.\}

This will put the contents of the rd.live.overlay directory into the root of the initramfs image.

The --install option let you specify several files, which will get installed in the initramfs image at the same location, as they are present on initramfs creation time.

.if n \{.RS 4
.\}
    # dracut --install strace fsck.ext3 ssh*(Aq initramfs-dbg.img
.if n \{.RE
.\}

This will create an initramfs with the strace, fsck.ext3 and ssh executables, together with the libraries needed to start those. The --install option can be specified multiple times.

<a name="network-boot"></a>

### Network Boot


If your root partition is on a network drive, you have to have the network dracut modules installed to create a network aware initramfs image.

If you specify ip=dhcp on the kernel command line, then dracut asks a dhcp server about the ip address for the machine. The dhcp server can also serve an additional root-path, which will set the root device for dracut. With this mechanism, you have static configuration on your client machine and a centralized boot configuration on your TFTP/DHCP server. If you can’t pass a kernel command line, then you can inject _/etc/cmdline.d/mycmdline.conf_, with a method described in the section called “Injecting custom Files”.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Reducing the Image Size**

To reduce the size of the initramfs, you should create it with by omitting all dracut modules, which you know, you don’t need to boot the machine.

You can also specify the exact dracut and kernel modules to produce a very tiny initramfs image.

For example for a NFS image, you would do:

.if n \{.RS 4
.\}
    # dracut -m "nfs network base" initramfs-nfs-only.img
.if n \{.RE
.\}

Then you would boot from this image with your target machine and reduce the size once more by creating it on the target machine with the --host-only option:

.if n \{.RS 4
.\}
    # dracut -m "nfs network base" --host-only initramfs-nfs-host-only.img
.if n \{.RE
.\}

This will reduce the size of the initramfs image significantly.

<a name="troubleshooting"></a>

# Troubleshooting


If the boot process does not succeed, you have several options to debug the situation. Some of the basic operations are covered here. For more information you should also visit: \m[blue]**https://www.kernel.org/pub/linux/utils/boot/dracut/dracut.html**\m[]

<a name="identifying-your-problem-area"></a>

### Identifying your problem area


.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Remove
  _rhgb_\*(Aq and
  _quiet_\*(Aq from the kernel command line

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Add
  _rd.shell_\*(Aq to the kernel command line. This will present a shell should dracut be unable to locate your root device

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Add
  _rd.shell rd.debug log\_buf\_len=1M_\*(Aq to the kernel command line so that dracut shell commands are printed as they are executed

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  The file /run/initramfs/rdsosreport.txt is generated, which contains all the logs and the output of all significant tools, which are mentioned later.

If you want to save that output, simply mount /boot by hand or insert an USB stick and mount that. Then you can store the output for later inspection.

<a name="information-to-include-in-your-report"></a>

### Information to include in your report


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**All bug reports**

In all cases, the following should be mentioned and attached to your bug report:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The exact kernel command-line used. Typically from the bootloader configuration file (e.g.
  _/boot/grub2/grub.cfg_) or from
  _/proc/cmdline_.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A copy of your disk partition information from
  _/etc/fstab_, which might be obtained booting an old working initramfs or a rescue medium.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Turn on dracut debugging (see
  _the __debugging dracut__ section_), and attach the file /run/initramfs/rdsosreport.txt.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If you use a dracut configuration file, please include
  _/etc/dracut.conf_
  and all files in
  _/etc/dracut.conf.d/*.conf_

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Network root device related problems**

This section details information to include when experiencing problems on a system whose root device is located on a network attached volume (e.g. iSCSI, NFS or NBD). As well as the information from the section called “All bug reports”, include the following information:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Please include the output of

.if n \{.RS 4
.\}
    # /sbin/ifup <interfacename>
    # ip addr show
.if n \{.RE
.\}

<a name="debugging-dracut"></a>

### Debugging dracut


.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Configure a serial console**

Successfully debugging dracut will require some form of console logging during the system boot. This section documents configuring a serial console connection to record boot messages.

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  First, enable serial console output for both the kernel and the bootloader.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Open the file
  _/boot/grub2/grub.cfg_
  for editing. Below the line
  _timeout=5_\*(Aq, add the following:

.if n \{.RS 4
.\}
    serial --unit=0 --speed=9600
    terminal --timeout=5 serial console
.if n \{.RE
.\}

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Also in
  _/boot/grub2/grub.cfg_, add the following boot arguments to the
  _kernel_\*(Aq line:

.if n \{.RS 4
.\}
    console=tty0 console=ttyS0,9600
.if n \{.RE
.\}

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  When finished, the
  _/boot/grub2/grub.cfg_
  file should look similar to the example below.

.if n \{.RS 4
.\}
    default=0
    timeout=5
    serial --unit=0 --speed=9600
    terminal --timeout=5 serial console
    title Fedora (2.6.29.5-191.fc11.x86_64)
      root (hd0,0)
      kernel /vmlinuz-2.6.29.5-191.fc11.x86_64 ro root=/dev/mapper/vg_uc1-lv_root console=tty0 console=ttyS0,9600
      initrd /dracut-2.6.29.5-191.fc11.x86_64.img
.if n \{.RE
.\}

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  More detailed information on how to configure the kernel for console output can be found at
  \m[blue]**http://www.faqs.org/docs/Linux-HOWTO/Remote-Serial-Console-HOWTO.html#CONFIGURE-KERNEL**\m[].

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  Redirecting non-interactive output
  .if n \{.sp
  .\}
      .it 1 an-trap
      .nr an-no-space-flag 1
      .nr an-break-flag 1  
      .ps +1
      **Note**
      .ps -1  
      You can redirect all non-interactive output to
      _/dev/kmsg_
      and the kernel will put it out on the console when it reaches the kernel buffer by doing


.if n \{.RS 4
.\}
    # exec >/dev/kmsg 2>&1 </dev/console
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Using the dracut shell**

dracut offers a shell for interactive debugging in the event dracut fails to locate your root filesystem. To enable the shell:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Add the boot parameter
  _rd.shell_\*(Aq to your bootloader configuration file (e.g.
  _/boot/grub2/grub.cfg_)

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Remove the boot arguments
  _rhgb_\*(Aq and
  _quiet_\*(Aq

A sample
_/boot/grub2/grub.cfg_
bootloader configuration file is listed below.

.if n \{.RS 4
.\}
    default=0
    timeout=5
    serial --unit=0 --speed=9600
    terminal --timeout=5 serial console
    title Fedora (2.6.29.5-191.fc11.x86_64)
      root (hd0,0)
      kernel /vmlinuz-2.6.29.5-191.fc11.x86_64 ro root=/dev/mapper/vg_uc1-lv_root console=tty0 rd.shell
      initrd /dracut-2.6.29.5-191.fc11.x86_64.img
.if n \{.RE
.\}

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  If system boot fails, you will be dropped into a shell as seen in the example below.

.if n \{.RS 4
.\}
    No root device found
    Dropping to debug shell.
    
    #
.if n \{.RE
.\}

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  Use this shell prompt to gather the information requested above (see
  the section called “All bug reports”).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Accessing the root volume from the dracut shell**

From the dracut debug shell, you can manually perform the task of locating and preparing your root volume for boot. The required steps will depend on how your root volume is configured. Common scenarios include:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A block device (e.g.
  _/dev/sda7_)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A LVM logical volume (e.g.
  _/dev/VolGroup00/LogVol00_)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  An encrypted device (e.g.
  _/dev/mapper/luks-4d5972ea-901c-4584-bd75-1da802417d83_)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A network attached device (e.g.
  _netroot=iscsi:@192.168.0.4::3260::iqn.2009-02.org.example:for.all_)

The exact method for locating and preparing will vary. However, to continue with a successful boot, the objective is to locate your root volume and create a symlink _/dev/root_ which points to the file system. For example, the following example demonstrates accessing and booting a root volume that is an encrypted LVM Logical volume.

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Inspect your partitions using parted

.if n \{.RS 4
.\}
    # parted /dev/sda -s p
    Model: ATA HTS541060G9AT00 (scsi)
    Disk /dev/sda: 60.0GB
    Sector size (logical/physical): 512B/512B
    Partition Table: msdos
    Number  Start   End     Size    Type      File system  Flags
    1      32.3kB  10.8GB  107MB   primary   ext4         boot
    2      10.8GB  55.6GB  44.7GB  logical                lvm
.if n \{.RE
.\}

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  You recall that your root volume was a LVM logical volume. Scan and activate any logical volumes.

.if n \{.RS 4
.\}
    # lvm vgscan
    # lvm vgchange -ay
.if n \{.RE
.\}

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  You should see any logical volumes now using the command blkid:

.if n \{.RS 4
.\}
    # blkid
    /dev/sda1: UUID="3de247f3-5de4-4a44-afc5-1fe179750cf7" TYPE="ext4"
    /dev/sda2: UUID="Ek4dQw-cOtq-5MJu-OGRF-xz5k-O2l8-wdDj0I" TYPE="LVM2_member"
    /dev/mapper/linux-root: UUID="def0269e-424b-4752-acf3-1077bf96ad2c" TYPE="crypto_LUKS"
    /dev/mapper/linux-home: UUID="c69127c1-f153-4ea2-b58e-4cbfa9257c5e" TYPE="ext3"
    /dev/mapper/linux-swap: UUID="47b4d329-975c-4c08-b218-f9c9bf3635f1" TYPE="swap"
.if n \{.RE
.\}

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  From the output above, you recall that your root volume exists on an encrypted block device. Following the guidance disk encryption guidance from the Installation Guide, you unlock your encrypted root volume.

.if n \{.RS 4
.\}
    # UUID=$(cryptsetup luksUUID /dev/mapper/linux-root)
    # cryptsetup luksOpen /dev/mapper/linux-root luks-$UUID
    Enter passphrase for /dev/mapper/linux-root:
    Key slot 0 unlocked.
.if n \{.RE
.\}

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  Next, make a symbolic link to the unlocked root volume

.if n \{.RS 4
.\}
    # ln -s /dev/mapper/luks-$UUID /dev/root
.if n \{.RE
.\}

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  With the root volume available, you may continue booting the system by exiting the dracut shell

.if n \{.RS 4
.\}
    # exit
.if n \{.RE
.\}

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Additional dracut boot parameters**

For more debugging options, see **dracut.cmdline**(7).

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Debugging dracut on shutdown**

To debug the shutdown sequence on systemd systems, you can _rd.break_ on _pre-shutdown_ or _shutdown_.

To do this from an already booted system:

.if n \{.RS 4
.\}
    # mkdir -p /run/initramfs/etc/cmdline.d
    # echo "rd.debug rd.break=pre-shutdown rd.break=shutdown" > /run/initramfs/etc/cmdline.d/debug.conf
    # touch /run/initramfs/.need_shutdown
.if n \{.RE
.\}

This will give you a dracut shell after the system pivot’ed back in the initramfs.

<a name="options"></a>

# Options


**--kver** _&lt;kernel version&gt;_
set the kernel version. This enables to specify the kernel version, without specifying the location of the initramfs image. For example:

.if n \{.RS 4
.\}
    # dracut --kver 3.5.0-0.rc7.git1.2.fc18.x86_64
.if n \{.RE
.\}

**-f, --force**
overwrite existing initramfs file.

**-a, --add**&nbsp;_&lt;list of dracut modules&gt;_
add a space-separated list of dracut modules to the default set of modules. This parameter can be specified multiple times.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --add "module1 module2"  ...
.if n \{.RE
.\}


**--force-add**&nbsp;_&lt;list of dracut modules&gt;_
force to add a space-separated list of dracut modules to the default set of modules, when -H is specified. This parameter can be specified multiple times.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --force-add "module1 module2"  ...
.if n \{.RE
.\}


**-o, --omit**&nbsp;_&lt;list of dracut modules&gt;_
omit a space-separated list of dracut modules. This parameter can be specified multiple times.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --omit "module1 module2"  ...
.if n \{.RE
.\}


**-m, --modules** _&lt;list of dracut modules&gt;_
specify a space-separated list of dracut modules to call when building the initramfs. Modules are located in
_/usr/lib/dracut/modules.d_. This parameter can be specified multiple times. This option forces dracut to only include the specified dracut modules. In most cases the "--add" option is what you want to use.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --modules "module1 module2"  ...
.if n \{.RE
.\}


**-d, --drivers**&nbsp;_&lt;list of kernel modules&gt;_
specify a space-separated list of kernel modules to exclusively include in the initramfs. The kernel modules have to be specified without the ".ko" suffix. This parameter can be specified multiple times.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --drivers "kmodule1 kmodule2"  ...
.if n \{.RE
.\}


**--add-drivers**&nbsp;_&lt;list of kernel modules&gt;_
specify a space-separated list of kernel modules to add to the initramfs. The kernel modules have to be specified without the ".ko" suffix. This parameter can be specified multiple times.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --add-drivers "kmodule1 kmodule2"  ...
.if n \{.RE
.\}


**--force-drivers** _&lt;list of kernel modules&gt;_
See add-drivers above. But in this case it is ensured that the drivers are tried to be loaded early via modprobe.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --force-drivers "kmodule1 kmodule2"  ...
.if n \{.RE
.\}


**--omit-drivers**&nbsp;_&lt;list of kernel modules&gt;_
specify a space-separated list of kernel modules not to add to the initramfs. The kernel modules have to be specified without the ".ko" suffix. This parameter can be specified multiple times.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --omit-drivers "kmodule1 kmodule2"  ...
.if n \{.RE
.\}


**--filesystems**&nbsp;_&lt;list of filesystems&gt;_
specify a space-separated list of kernel filesystem modules to exclusively include in the generic initramfs. This parameter can be specified multiple times.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --filesystems "filesystem1 filesystem2"  ...
.if n \{.RE
.\}


**-k, --kmoddir**&nbsp;_&lt;kernel directory&gt;_
specify the directory, where to look for kernel modules

**--fwdir**&nbsp;_&lt;dir&gt;[:&lt;dir&gt;...]++_
specify additional directories, where to look for firmwares. This parameter can be specified multiple times.

**--kernel-cmdline &lt;parameters&gt;**
specify default kernel command line parameters

**--kernel-only**
only install kernel drivers and firmware files

**--no-kernel**
do not install kernel drivers and firmware files

**--early-microcode**
Combine early microcode with ramdisk

**--no-early-microcode**
Do not combine early microcode with ramdisk

**--print-cmdline**
print the kernel command line for the current disk layout

**--mdadmconf**
include local
_/etc/mdadm.conf_

**--nomdadmconf**
do not include local
_/etc/mdadm.conf_

**--lvmconf**
include local
_/etc/lvm/lvm.conf_

**--nolvmconf**
do not include local
_/etc/lvm/lvm.conf_

**--fscks** [LIST]
add a space-separated list of fsck tools, in addition to
_dracut.conf_s specification; the installation is opportunistic (non-existing tools are ignored)
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --fscks "fsck.foo barfsck"  ...
.if n \{.RE
.\}


**--nofscks**
inhibit installation of any fsck tools

**--strip**
strip binaries in the initramfs (default)

**--nostrip**
do not strip binaries in the initramfs

**--hardlink**
hardlink files in the initramfs (default)

**--nohardlink**
do not hardlink files in the initramfs

**--prefix**&nbsp;_&lt;dir&gt;_
prefix initramfs files with the specified directory

**--noprefix**
do not prefix initramfs files (default)

**-h, --help**
display help text and exit.

**--debug**
output debug information of the build process

**-v, --verbose**
increase verbosity level (default is info(4))

**-q, --quiet**
decrease verbosity level (default is info(4))

**-c, --conf**&nbsp;_&lt;dracut configuration file&gt;_
specify configuration file to use.

Default:
_/etc/dracut.conf_

**--confdir**&nbsp;_&lt;configuration directory&gt;_
specify configuration directory to use.

Default:
_/etc/dracut.conf.d_

**--tmpdir**&nbsp;_&lt;temporary directory&gt;_
specify temporary directory to use.

Default:
_/var/tmp_

**-r, --sysroot** _&lt;sysroot directory&gt;_
specify the sysroot directory to collect files from. This is useful to create the initramfs image from a cross-compiled sysroot directory. For the extra helper variables, see
**ENVIRONMENT**
below.

Default:
_empty_

**--sshkey**&nbsp;_&lt;sshkey file&gt;_
ssh key file used with ssh-client module.

**--logfile**&nbsp;_&lt;logfile&gt;_
logfile to use; overrides any setting from the configuration files.

Default:
_/var/log/dracut.log_

**-l, --local**
activates the local mode. dracut will use modules from the current working directory instead of the system-wide installed modules in
_/usr/lib/dracut/modules.d_. This is useful when running dracut from a git checkout.

**-H, --hostonly**
Host-Only mode: Install only what is needed for booting the local host instead of a generic host and generate host-specific configuration.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
If chrooted to another root other than the real root device, use "--fstab" and provide a valid
_/etc/fstab_.


**-N, --no-hostonly**
Disable Host-Only mode

**--hostonly-cmdline**: Store kernel command line arguments needed in the initramfs

**--no-hostonly-cmdline**: Do not store kernel command line arguments needed in the initramfs

**--no-hostonly-default-device**: Do not generate implicit host devices like root, swap, fstab, etc. Use "--mount" or "--add-device" to explicitly add devices as needed.

**--hostonly-i18n**: Install only needed keyboard and font files according to the host configuration (default).

**--no-hostonly-i18n**: Install all keyboard and font files available.

**--persistent-policy** _&lt;policy&gt;_
Use
_&lt;policy&gt;_
to address disks and partitions.
_&lt;policy&gt;_
can be any directory name found in /dev/disk. E.g. "by-uuid", "by-label"

**--fstab**
Use
_/etc/fstab_
instead of
_/proc/self/mountinfo_.

**--add-fstab** _&lt;filename&gt;_
Add entries of
_&lt;filename&gt;_
to the initramfs /etc/fstab.

**--mount**&nbsp;"_&lt;device&gt;_ _&lt;mountpoint&gt;_ _&lt;filesystem type&gt;_ [_&lt;filesystem options&gt;_ [_&lt;dump frequency&gt;_ [_&lt;fsck order&gt;_]]]"
Mount
_&lt;device&gt;_
on
_&lt;mountpoint&gt;_
with
_&lt;filesystem type&gt;_
in the initramfs.
_&lt;filesystem options&gt;_,
_&lt;dump options&gt;_
and
_&lt;fsck order&gt;_
can be specified, see fstab manpage for the details. The default
_&lt;filesystem options&gt;_
is "defaults". The default
_&lt;dump frequency&gt;_
is "0". the default
_&lt;fsck order&gt;_
is "2".

**--mount** "_&lt;mountpoint&gt;_"
Like above, but
_&lt;device&gt;_,
_&lt;filesystem type&gt;_
and
_&lt;filesystem options&gt;_
are determined by looking at the current mounts.

**--add-device** _&lt;device&gt;_
Bring up
_&lt;device&gt;_
in initramfs,
_&lt;device&gt;_
should be the device name. This can be useful in hostonly mode for resume support when your swap is on LVM or an encrypted partition. [NB --device can be used for compatibility with earlier releases]

**-i, --include** _&lt;SOURCE&gt;_ _&lt;TARGET&gt;_
include the files in the SOURCE directory into the TARGET directory in the final initramfs. If SOURCE is a file, it will be installed to TARGET in the final initramfs. This parameter can be specified multiple times.

**-I, --install** _&lt;file list&gt;_
install the space separated list of files into the initramfs.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
If [LIST] has multiple arguments, then you have to put these in quotes. For example:

.if n \{.RS 4
.\}
    # dracut --install "/bin/foo /sbin/bar"  ...
.if n \{.RE
.\}


**--install-optional** _&lt;file list&gt;_
install the space separated list of files into the initramfs, if they exist.

**--gzip**
Compress the generated initramfs using gzip. This will be done by default, unless another compression option or --no-compress is passed. Equivalent to "--compress=gzip -9"

**--bzip2**
Compress the generated initramfs using bzip2.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Make sure your kernel has bzip2 decompression support compiled in, otherwise you will not be able to boot. Equivalent to "--compress=bzip2"


**--lzma**
Compress the generated initramfs using lzma.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Make sure your kernel has lzma decompression support compiled in, otherwise you will not be able to boot. Equivalent to "lzma --compress=lzma -9"


**--xz**
Compress the generated initramfs using xz.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
Make sure your kernel has xz decompression support compiled in, otherwise you will not be able to boot. Equivalent to "lzma --compress=xz --check=crc32 --lzma2=dict=1MiB"


**--lzo**
Compress the generated initramfs using lzop.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

Make sure your kernel has lzo decompression support compiled in, otherwise you will not be able to boot.


**--lz4**
Compress the generated initramfs using lz4.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

Make sure your kernel has lz4 decompression support compiled in, otherwise you will not be able to boot.


**--zstd**
Compress the generated initramfs using Zstandard.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

Make sure your kernel has zstd decompression support compiled in, otherwise you will not be able to boot.


**--compress**&nbsp;_&lt;compressor&gt;_
Compress the generated initramfs using the passed compression program. If you pass it just the name of a compression program, it will call that program with known-working arguments. If you pass a quoted string with arguments, it will be called with exactly those arguments. Depending on what you pass, this may result in an initramfs that the kernel cannot decompress. The default value can also be set via the
_INITRD\_COMPRESS_
environment variable.

**--no-compress**
Do not compress the generated initramfs. This will override any other compression options.

**--reproducible**
Create reproducible images.

**--no-reproducible**
Do not create reproducible images.

**--list-modules**
List all available dracut modules.

**-M, --show-modules**
Print included module’s name to standard output during build.

**--keep**
Keep the initramfs temporary directory for debugging purposes.

**--printsize**
Print out the module install size

**--profile**: Output profile information of the build process

**--ro-mnt**: Mount / and /usr read-only by default.

**-L, --stdlog**&nbsp;_&lt;level&gt;_
[0-6] Specify logging level (to standard error)

.if n \{.RS 4
.\}
              0 - suppress any messages
              1 - only fatal errors
              2 - all errors
              3 - warnings
              4 - info
              5 - debug info (here starts lots of output)
              6 - trace info (and even more)
.if n \{.RE
.\}

**--regenerate-all**
Regenerate all initramfs images at the default location with the kernel versions found on the system. Additional parameters are passed through.

**--loginstall ****&lt;DIR&gt;**
Log all files installed from the host to
_&lt;DIR&gt;_.

**--uefi**
Instead of creating an initramfs image, dracut will create an UEFI executable, which can be executed by an UEFI BIOS. The default output filename is
_&lt;EFI&gt;/EFI/Linux/linux-$kernel$-&lt;MACHINE\_ID&gt;-&lt;BUILD\_ID&gt;.efi_. &lt;EFI&gt; might be
_/efi_,
_/boot_
or
_/boot/efi_
depending on where the ESP partition is mounted. The &lt;BUILD_ID&gt; is taken from BUILD_ID in
_/usr/lib/os-release_
or if it exists
_/etc/os-release_
and is left out, if BUILD_ID is non-existant or empty.

**--no-machineid**
affects the default output filename of
**--uefi**
and will discard the &lt;MACHINE_ID&gt; part.

**--uefi-stub ****&lt;FILE&gt;**
Specifies the UEFI stub loader, which will load the attached kernel, initramfs and kernel command line and boots the kernel. The default is
_$prefix/lib/systemd/boot/efi/linux&lt;EFI-MACHINE-TYPE-NAME&gt;.efi.stub_
or
_$prefix/lib/gummiboot/linux&lt;EFI-MACHINE-TYPE-NAME&gt;.efi.stub_

**--uefi-splash-image ****&lt;FILE&gt;**
Specifies the UEFI stub loader’s splash image. Requires bitmap (**.bmp**) image format.

**--kernel-image ****&lt;FILE&gt;**
Specifies the kernel image, which to include in the UEFI executable. The default is
_/lib/modules/&lt;KERNEL-VERSION&gt;/vmlinuz_
or
_/boot/vmlinuz-&lt;KERNEL-VERSION&gt;_

<a name="environment"></a>

# Environment


_INITRD\_COMPRESS_
sets the default compression program. See
**--compress**.

_DRACUT\_LDCONFIG_
sets the
_ldconfig_
program path and options. Optional. Used for
**--sysroot**.

Default:
_ldconfig_

_DRACUT\_LDD_
sets the
_ldd_
program path and options. Optional. Used for
**--sysroot**.

Default:
_ldd_

_DRACUT\_TESTBIN_
sets the initially tested binary for detecting library paths. Optional. Used for
**--sysroot**. In the cross-compiled sysroot, the default value (_/bin/sh_) is unusable, as it is an absolute symlink and points outside the sysroot directory.

Default:
_/bin/sh_

_DRACUT\_INSTALL_
overrides path and options for executing
_dracut-install_
internally. Optional. Can be used to debug
_dracut-install_
while running the main dracut script.

Default:
_dracut-install_

Example: DRACUT_INSTALL="valgrind dracut-install"

_DRACUT\_COMPRESS\_BZIP2_, _DRACUT\_COMPRESS\_BZIP2_, _DRACUT\_COMPRESS\_LBZIP2_, _DRACUT\_COMPRESS\_LZMA_, _DRACUT\_COMPRESS\_XZ_, _DRACUT\_COMPRESS\_GZIP_, _DRACUT\_COMPRESS\_PIGZ_, _DRACUT\_COMPRESS\_LZOP_, _DRACUT\_COMPRESS\_ZSTD_, _DRACUT\_COMPRESS\_LZ4_, _DRACUT\_COMPRESS\_CAT_
overrides for compression utilities to support using them from non-standard paths.

Default values are the default compression utility names to be found in
**PATH**.

_DRACUT\_ARCH_
overrides the value of
**uname -m**. Used for
**--sysroot**.

Default:
_empty_
(the value of
**uname -m**
on the host system)

_SYSTEMD\_VERSION_
overrides systemd version. Used for
**--sysroot**.

_DRACUT\_INSTALL\_PATH_
overrides
**PATH**
environment for
**dracut-install**
to look for binaries relative to
**--sysroot**. In a cross-compiled environment (e.g. Yocto), PATH points to natively built binaries that are not in the host’s /bin, /usr/bin, etc.
**dracut-install**
still needs plain /bin and /usr/bin that are relative to the cross-compiled sysroot.

Default:
_PATH_

_DRACUT\_INSTALL\_LOG\_TARGET_
overrides
**DRACUT\_LOG\_TARGET**
for
**dracut-install**. It allows running
**dracut-install* to run with different log target that **dracut** runs with.

Default:
_DRACUT\_LOG\_TARGET_

_DRACUT\_INSTALL\_LOG\_LEVEL_
overrides
**DRACUT\_LOG\_LEVEL**
for
**dracut-install**. It allows running
**dracut-install* to run with different log level that **dracut** runs with.

Default:
_DRACUT\_LOG\_LEVEL_

<a name="files"></a>

# Files


_/var/log/dracut.log_
logfile of initramfs image creation

_/tmp/dracut.log_
logfile of initramfs image creation, if
_/var/log/dracut.log_
is not writable

_/etc/dracut.conf_
see dracut.conf5

_/etc/dracut.conf.d/*.conf_
see dracut.conf5

_/usr/lib/dracut/dracut.conf.d/*.conf_
see dracut.conf5

<a name="configuration-in-the-initramfs"></a>

### Configuration in the initramfs


_/etc/conf.d/_
Any files found in
_/etc/conf.d/_
will be sourced in the initramfs to set initial values. Command line options will override these values set in the configuration files.

_/etc/cmdline_
Can contain additional command line options. Deprecated, better use /etc/cmdline.d/*.conf.

_/etc/cmdline.d/*.conf_
Can contain additional command line options.

<a name="availability"></a>

# Availability


The dracut command is part of the dracut package and is available from \m[blue]**https://dracut.wiki.kernel.org**\m[]

<a name="authors"></a>

# Authors


Harald Hoyer

Victor Lowther

Philippe Seewer

Warren Togami

Amadeusz Żołnowski

Jeremy Katz

David Dillow

Will Woods

<a name="see-also"></a>

# See Also


**dracut.cmdline**(7) **dracut.conf**(5) **lsinitrd**(1)
