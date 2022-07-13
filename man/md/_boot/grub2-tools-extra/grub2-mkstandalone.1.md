# grub-mkstandalone(3) - Generate a standalone image in the selected format.

Wed Feb 26 2014

```
grub-mkstandalone [-o | --output=FILE] [-O | --format=FORMAT] .RS 19 [-C | --compression=(xz|none|auto)] .RE .RS 19 [--modules=MODULES] [--install-modules=MODULES] .RE .RS 19 [--themes=THEMES] [--fonts=FONTS] .RE .RS 19 [--locales=LOCALES] [--compress[=no,xz,gz,lzo]] .RE .RS 19 [-d | --directory=DIR] [--grub-mkimage=FILE] .RE .RS 19 SOURCE...
```


<a name="description"></a>

# Description



<a name="options"></a>

# Options


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


* --compression=(_xz_|_none_|_auto_)  
  Use one of _xz_, _none_, or _auto_ as the compression method for the core image.
  
* --modules=_MODULES_  
  Pre-load modules specified by _MODULES_.
  
* --install-modules=_MODULES_  
  Install only _MODULES_ and their dependencies.  The default is to install all available modules.
  
* --themes=_THEMES_  
  Install _THEMES_.  The default is to install the _starfield_ theme, if available.
  
* --fonts=_FONTS_  
  Install _FONTS_.  The default is to install the _unicode_ font.
  
* --locales=_LOCALES_  
  Install only locales listed in _LOCALES_.  The default is to install all available locales.
  
* --compress[=_no_,_xz_,_gz_,_lzo_]  
  Compress GRUB files using the specified compression algorithm.
  
* --directory=_DIR_  
  Use images and modules in _DIR_.
  
* --grub-mkimage=_FILE_  
  Use _FILE_ as **grub-mkimage**.  The default is _/usr/bin/grub-mkimage_.
  

<a name="see-also"></a>

# See Also

**info grub**
