# grub-install(1) - Install GRUB on a device.

Wed Feb 26 2014

```
grub-install [--modules=MODULES] [--install-modules=MODULES] .RS 14 [--themes=THEMES] [--fonts=FONTS] [--locales=LOCALES] .RE .RS 14 [--compress[=no,xz,gz,lzo]] [-d | --directory=DIR] .RE .RS 14 [--grub-mkimage=FILE] [--boot-directory=DIR] .RE .RS 14 [--target=TARGET] [--grub-setup=FILE] .RE .RS 14 [--grub-mkrelpath=FILE] [--grub-probe=FILE] .RE .RS 14 [--allow-floppy] [--recheck] [--force] [--force-file-id] .RE .RS 14 [--disk-module=MODULE] [--no-nvram] [--removable] .RE .RS 14 [--bootloader-id=ID] [--efi-directory=DIR] INSTALL_DEVICE
```


<a name="description"></a>

# Description

**grub-install** installs GRUB onto a device.  This includes copying GRUB images into the target directory (generally _/boot/grub_), and on some platforms may also include installing GRUB onto a boot sector.


<a name="options"></a>

# Options


* **--modules**=_MODULES_\!  
  Pre-load modules specified by _MODULES_.
  
* **--install-modules**=_MODULES_  
  Install only _MODULES_ and their dependencies.  The default is to install all available modules.
  
* **--themes**=_THEMES_  
  Install _THEMES_.  The default is to install the _starfield_ theme, if available.
  
* **--fonts**=_FONTS_  
  Install _FONTS_.  The default is to install the _unicode_ font.
  
* **--locales**=_LOCALES_  
  Install only locales listed in _LOCALES_.  The default is to install all available locales.
  
* **--compress**=_no_,_xz_,_gz_,_lzo_  
  Compress GRUB files using the specified compression algorithm.
  
* **--directory**=_DIR_  
  Use images and modules in _DIR_.
  
* **--grub-mkimage**=_FILE_  
  Use _FILE_ as **grub-mkimage**.  The default is _/usr/bin/grub-mkimage_.
  
* **--boot-directory**=_DIR_  
  Use _DIR_ as the boot directory.  The default is _/boot_.  GRUB will put its files in a subdirectory of this directory named _grub_.
  
* **--target**=_TARGET_  
  Install GRUB for _TARGET_ platform.  The default is the platform **grub-install** is running on.
  
* **--grub-setup**=_FILE_  
  Use _FILE_ as **grub-setup**.  The default is _/usr/bin/grub-setup_.
  
* **--grub-mkrelpath**=_FILE_  
  Use _FILE_ as **grub-mkrelpath**.  The default is _/usr/bin/grub-mkrelpath_.
  
* **--grub-probe**=_FILE_  
  Use _FILE_ as **grub-probe**.  The default is _/usr/bin/grub-mkrelpath_.
  
* --allow-floppy  
  Make the device also bootable as a floppy.  This option is the default for /dev/fdX devices. Some BIOSes will not boot images created with this option.
  
* --recheck  
  Delete any existing device map and create a new one if necessary.
  
* --force  
  Install even if problems are detected.
  
* --force-file-id  
  Use identifier file even if UUID is available.
  
* **--disk-module**=_MODULE_  
  Use _MODULE_ for disk access.  This allows you to manually specify either _biosdisk_ or _native_ disk access.  This option is only available on the BIOS target platform.
  
* --no-nvram  
  Do not update the _boot-device_ NVRAM variable.  This option is only available on IEEE1275 target platforms.
  
* --removable  
  Treat the target device as if it is removeable.  This option is only available on the EFI target platform.
  
* **--bootloader-id**=_ID_  
  Use _ID_ as the bootloader ID.  This opption is only available on the EFI target platform.
  
* **--efi-directory**=_DIR_  
  Use _DIR_ as the EFI System Partition root.  This opption is only available on the EFI ta
  rget platform.
  
* _INSTALL\_DEVICE_  
  Install GRUB to the block device _INSTALL\_DEVICE_.
  

<a name="see-also"></a>

# See Also

**info grub**
