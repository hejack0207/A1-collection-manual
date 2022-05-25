# grub-bios-setup(3) - Set up images to boot from a device.

Wed Feb 26 2014

```
grub-bios-setup [-a | --allow-floppy] [-b | --boot-image=FILE] .RS 17 [-c | --core-image=FILE] [-d | --directory=DIR] .RE .RS 17 [-f | --force] [-m | --device-map=FILE] .RE .RS 17 [-s | --skip-fs-probe] [-v | --verbose] DEVICE
```


<a name="description"></a>

# Description

You should not normally run this program directly.  Use grub-install instead.


<a name="options"></a>

# Options


* **--allow-floppy**  
  Make the device also bootable as a floppy.  This option is the default for
  /dev/fdX devices.  Some BIOSes will not boot images created with this option.
  
* **--boot-image**=_FILE_  
  Use FILE as the boot image.  The default value is **boot.img**.
  
* **--core-image**=_FILE_  
  Use FILE as ther core image.  The default value is **core.img**.
  
* **--directory**=_DIR_  
  Use GRUB files in the directory DIR.  The default value is **/boot/grub**.
  
* **--force**  
  Install even if problems are detected.
  
* **--device-map**=_FILE_  
  Use FILE as the device map.  The default value is /boot/grub/device.map .
  
* **--skip-fs-probe**  
  Do not probe DEVICE for filesystems.
  
* **--verbose**  
  Print verbose messages.
  

<a name="see-also"></a>

# See Also

**info grub**
