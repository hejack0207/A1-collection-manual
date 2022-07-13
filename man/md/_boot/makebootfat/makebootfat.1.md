# makebootfat bootable fat disk creation(1)

makebootfat - Makebootfat Bootable FAT Disk Creation

<a name="synopsis-"></a>

# Synopsis 

makebootfat [options] IMAGE


<a name="description-"></a>

# Description 

This utility creates a bootable FAT filesystem and
populates it with files and boot tools.

It is mainly designed to create bootable USB and
Fixed disk for the AdvanceCD project.

The official site of AdvanceCD and makebootfat is:

http://advancemame.sourceforge.net/


<a name="options-"></a>

# Options 


* **-o, --output DEVICE**  
  Specify the output device. It must be the device
  where you want to setup the filesystem.
  You can use the special \(a"usb\(a" value to automatically
  select the USB Mass Storage device connected at
  the system.
  This option is always required.
* **-b, --boot FILE**  
* **-1, --boot-fat12 FILE**  
* **-2, --boot-fat16 FILE**  
* **-3, --boot-fat32 FILE**  
  Specify the FAT boot sector images to use. The -b option
  uses the same sector for all the FAT types. The other
  options can be used to specify a different sector for
  different FAT types. The FAT types for which a boot sector
  is not specified are not used.
  This option is always required.
* **-m, --mbr FILE**  
  Specify the MBR sector image to use.
  If this option is specified a partition table is
  created on the disk. Otherwise the disk is filled without a
  partition table like a floppy disk.
* **-F, --mbrfat**  
  Change the MBR image specified with the -m option to pretend
  to be a FAT filesystem starting from the first sector of
  the disk. This allows booting from USB-FDD (Floppy Disk Drive)
  also using a partition table generally required by USB-HDD
  (Hard Disk Drive).
  The MBR image specified with the -m option must have
  executable code positioned like a FAT boot sector. You
  can use the included ‘mbrfat.bin’ file.
* **-c, --copy FILE**  
  Copy the specified file in the root directory of the disk.
  The file is copied using the readonly attribute.
* **-x, --exclude FILE**  
  Exclude the specified files and subdirectories in the
  IMAGE directory to copy. The path must be specified using
  the same format used in the IMAGE directory specification.
* **-X, --syslinux2**  
  Enforce the syslinux 2.xx FAT limitations. Syslinux
  2.xx doesn’t support FAT32 at all, and FAT16 with
  64 and 128 sectors per cluster formats.
  This option excludes all the FAT formats not supported
  by syslinux. Please note that it limits the maximum
  size of filesystem to 1 GB.
* **-Y, --syslinux3**  
  Enforce the syslinux 3.xx FAT support. Syslinux 3.00
  supports all the FAT types and sizes but it requires
  a special customisation of the boot sector and of
  the file ‘ldlinux.sys’.
  This option does this customisation without the need
  to use the syslinux installer if the ‘ldlinux.sys’
  file is copied on disk with the -c option.
* **-Z, --zip**  
  If possible force the ZIP-Disk compatibility. It sets
  a geometry of 32 sectors and 64 heads. It also uses the
  4’th partition entry in the partition table.
  It’s required to boot also in USB-ZIP mode.
* **-P, --partition**  
  Ensure to operate on a partition and not on a disk.
* **-D, --disk**  
  Ensure to operate on a disk and not on a partition.
* **-L, --label LABEL**  
  Set the FAT label. The label is a string of 11 chars.
* **-O, --oem OEM**  
  Set the FAT OEM name. The OEM name is a string of 11 chars.
* **-S, --serial SERIAL**  
  Set the FAT serial number. The serial number is a 32 bit
  unsigned integer.
* **-E, --drive DRIVE**  
  Set the BIOS drive to setup in the FAT boot sector.
  Generally this value is ignored by boot sectors, with
  the exception of the FAT12 and FAT16 FreeDOS boot sectors
  that require the correct value or the value 255 to force
  auto detection.
* **-v, --verbose**  
  Print some information on the device and on the filesystem
  created.
* **-i, --interactive**  
  Show the errors in a message box. Only for Windows.
* **-h, --help**  
  Print a short help.
* **-V, --version**  
  Print the version number.
* **IMAGE**  
  Directory image to copy on the disk. All the files
  and subdirectories present in this directory
  are copied on the disk.

<a name="disks-and-partitions-names-"></a>

# Disks and Partitions Names 

In Linux disk devices are named /dev/hdX or /dev/sdX where X
is a letter. Partition devices are named /dev/hdXN or /dev/sdXN
where X is a letter and N a digit.

In Windows disk devices are named \(rs\(rs.\(rsPhysicalDriveN where N is
a digit. Partition devices are named \(rs\(rs.\(rsX: where X is a letter,
but sometimes \(rs\(rs.\(rsX: is a disk and not a partition, for example on
floppies and on all the USB Mass Storage devices without a
partition table.

<a name="syslinux-"></a>

# Syslinux 

To make a bootable FAT using syslinux you must use
the -X option for syslinux version 2.xx or the -Y
option for syslinux version 3.xx. You must also copy in
the root directory of the disk the files:
.HP 4
_ldlinux.sys_
The syslinux loader.
.HP 4
_syslinux.cfg_
The syslinux configuration file.
.HP 4
_linux_
The Linux kernel image  (the file name may be different).
.HP 4
_initrd.img_
The initrd filesystem (the file name may be different
or missing).

You must also specify the ‘ldlinux.bss’ boot sector with the -b
option and possibily the ‘mbr.bin’ MBR sector with the -m option.
Both the sector images are present in the syslinux package.

For example:

makebootfat -o usb \(rs

	-Y \(rs

	-b ldlinux.bss -m mbr.bin \(rs

	-c ldlinux.sys -c syslinux.cfg \(rs

	-c linux -c initrd.img \(rs

	image


<a name="loadlin-and-freedos-"></a>

# Loadlin and Freedos 

To make a bootable FAT using loadlin and FreeDOS you must copy
in the root directory of the disk the files:
.HP 4
_kernel.sys_
The FreeDOS kernel. Remember to use the \(a"32\(a" kernel
version to support FAT32.
.HP 4
_command.com_
The FreeDOS shell.
.HP 4
_autoexec.bat_
Used to start loadlin.
.HP 4
_loadlin.exe_
The loadlin executable.
.HP 4
_linux_
The Linux kernel image  (the file name may be different).
.HP 4
_initrd.img_
The initrd filesystem (the file name may be different
or missing).

You must also specify the FreeDOS boot sectors available on the
FreeDOS ‘sys’ source package with the -1, -2, -3 option.
For the MBR you can use the sectors image available on the FreeDOS
‘fdisk’ source package.

For example:

makebootfat -o /dev/hda1 \(rs

	-E 255 \(rs

	-1 fat12com.bin -2 fat16com.bin -3 fat32lba.bin \(rs

	-c kernel.sys -c command.com \(rs

	-c autoexec.bat -c loadlin.exe \(rs

	-c linux -c initrd.img \(rs

	image


<a name="multi-standard-usb-booting-"></a>

# Multi Standard Usb Booting 

The BIOS USB boot support is generally differentiated in three
categories: USB-HDD, USB-FDD and USB-ZIP.

The USB-HDD (Hard Disk Drive) standard is the preferred choice and
it requires the presence of a partition table in the first sector
of the disk. You can create this type of disk using the -m option.

The USB-FDD (Floppy Disk Drive) standard requires the presence of
a filesystem starting from the first sector of the disk without
a partition table.
You can create this type of disk without using the -m option.

The USB-ZIP (ZIP Drive) standard requires the presence of a
device with a very specific geometry. Specifically, it requires
a geometry with 32 sectors and 64 heads. It also requires the presence
of a partition table with only a bootable partition in the
fourth entry. You can create this type of disk using the -m and -Z option.

Generally these standards are incompatible, but using the -m, -F
and -Z options you can create a disk compatible with all of them.

To use the -F option, the MBR image specified must follow
the constrains:

* ·  
  It must start with a standard FAT 3 bytes jump instruction.
* ·  
  It must have the bytes from address 3 to 89 (included) unused.

And example of such image is in the ‘mbrfat.bin’ file.

For example to create a syslinux image:

makebootfat -o usb \(rs

	-Y \(rs

	-Z \(rs

	-b ldlinux.bss -m mbrfat.bin -F \(rs

	-c ldlinux.sys -c syslinux.cfg \(rs

	-c linux -c initrd.img \(rs

	image


and for a FreeDOS and loadlin image:

makebootfat -o usb \(rs

	-E 255 \(rs

	-Z \(rs

	-1 fat12com.bin -2 fat16com.bin -3 fat32chs.bin \(rs

	-m mbrfat.bin -F \(rs

	-c kernel.sys -c command.com \(rs

	-c autoexec.bat -c loadlin.exe \(rs

	-c linux -c initrd.img \(rs

	image


Please note that FreeDos has some problems booting
from USB. It works only on very few conditions.

<a name="exclusion-"></a>

# Exclusion 

To exclude some files or directories in the image copy, you
can use the -x option using the same path specification
which are you using for the image directory.

For example, if you need to exclude the ‘isolinux’ and
‘syslinux’ subdirectories from the ‘image’ directory
you can use the command:

makebootfat ... \(rs

	-x image/isolinux \(rs

	-x image/syslinux \(rs

	image


<a name="copyright-"></a>

# Copyright 

This file is Copyright (C) 2004, 2005 Andrea Mazzoleni

<a name="see-also-"></a>

# See Also 

syslinux(1), mkdosfs(1), dosfsck(1)
