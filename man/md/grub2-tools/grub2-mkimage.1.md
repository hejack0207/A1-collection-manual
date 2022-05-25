# grub-mkimage(1) - Make a bootable GRUB image.

Wed Feb 26 2014

```
grub-mkimage [-c | --config=FILE] [-C | --compression=(xz,none,auto)] .RS 14 [-d | --directory=DIR] [-k | --pubkey=FILE] .RE .RS 14 [-m | --memdisk=FILE] [-n | --note] [-o | --output=FILE] .RE .RS 14 [-O | --format=FORMAT] [-p | --prefix=DIR] .RE .RS 14 [-v | --verbose] MODULES
```


<a name="description"></a>

# Description

**grub-mkimage** builds a bootable image of GRUB.


<a name="options"></a>

# Options


* --config=_FILE_  
  Embed _FILE_ as the image's initial configuration file.
  
* --compression=(_xz_,_none_,_auto_)  
  Use one of _xz_, _none_, or _auto_ as the compression method for the core image.
  
* --directory=_DIR_  
  Use images and modules from _DIR_.  The default value is **/usr/lib/grub/&lt;platform&gt;**.
  
* --pubkey=_FILE_  
  Embed the public key _FILE_ for signature checking.
  
* --memdisk=_FILE_  
  Embed the memdisk image _FILE_.  If no **-p** option is also specified, this implies _-p (memdisk)/boot/grub_.
  
* --note  
  Add a CHRP _NOTE_ section.  This option is only valid on IEEE1275 platforms.
  
* --output=_FILE_  
  Write the generated file to _FILE_.  The default is to write to standard output.
  
* --format=_FORMAT_  
  Generate an image in the specified _FORMAT_.  Valid values are:

i386-coreboot,
i386-multiboot,
i386-pc,
i386-pc-pxe,
i386-efi,
i386-ieee1275,
i386-qemu,
x86_64-efi,
mipsel-yeeloong-flash,
mipsel-fuloong2f-flash,
mipself-loongson-elf,
powerpc-ieee1275,
sparc64-ieee1275-raw,
sparc64-ieee1275-cdcore,
sparc64-ieee1275-aout,
ia64-efi,
mips-arc,
mipsel-arc,
mipsel-qemu_mips-elf,
mips-qemu_mips-flash,
mipsel-qemu_mips-flash,
mips-qemu_mips-elf


* --prefix=_DIR_  
  Set prefix directory.  The default value is _/boot/grub_.
  
* --verbose  
  Print verbose messages.
  
* _MODULES_  
  Include _MODULES_.
  

<a name="see-also"></a>

# See Also

**info grub**
