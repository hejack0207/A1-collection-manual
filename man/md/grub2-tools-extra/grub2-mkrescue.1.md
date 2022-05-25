# grub-mkrescue(3) - Generate a GRUB rescue image using GNU Xorriso.

Wed Feb 26 2014

```
grub-mkrescue [-o | --output=FILE] [--modules=MODULES] .RS 15 [--install-modules=MODULES] [--themes=THEMES] .RE .RS 15 [--fonts=FONTS] [--locales=LOCALES] .RE .RS 15 [--compress[=no,xz,gz,lzo]] [-d | --directory=DIR] .RE .RS 15 [--grub-mkimage=FILE] [--rom-directory=DIR] .RE .RS 15 [--xorriso=FILE] [--grub-glue-efi=FILE] .RE .RS 15 [--grub-render-label=FILE] [--label-font=FILE] .RE .RS 15 [--label-color=COLOR] [--label-bgcolor=FILE] .RE .RS 15 [--product-name=STRING] [--product-version=STRING] .RE .RS 15 [--sparc-boot] [--arcs-boot]
```


<a name="description"></a>

# Description

**grub-mkrescue** can be used to generate a rescue image with the GRUB bootloader.


<a name="options"></a>

# Options


* **--output**=_FILE_  
  Write the generated file to _FILE_.  The default is to write to standard output.
  
* **--modules**=_MODULES_  
  Pre-load modules specified by _MODULES_.
  
* **--install-modules**=_MODULES_  
  Install only _MODULES_ and their dependencies.  The default is to install all available modules.
  
* **--themes**=_THEMES_  
  Install _THEMES_.  The default is to install the _starfield_ theme, if available.
  
* **--fonts**=_FONTS_  
  Install _FONTS_.  The default is to install the _unicode_ font.
  
* **--locales**=_LOCALES_  
  Install only locales listed in _LOCALES_.  The default is to install all available locales.
  
* **--compress**[=_no_,_xz_,_gz_,_lzo_]  
  Compress GRUB files using the specified compression algorithm.
  
* **--directory**=_DIR_  
  Use images and modules in _DIR_.
  
* **--grub-mkimage**=_FILE_  
  Use _FILE_ as **grub-mkimage**(1).  The default is _/usr/bin/grub-mkimage_.
  
* **--rom-directory**=_DIR_  
  Save ROM images in _DIR_.
  
* **--xorriso**=_FILE_  
  Use _FILE_ as xorriso.
  
* **--grub-glue-efi**=_FILE_  
  Use _FILE_ as **grub-glue-efi**(3).
  
* **--grub-render-label**=_FILE_  
  Use _FILE_ as **grub-render-label**(3).
  
* **--label-font**=_FILE_  
  Use _FILE_ as the font file for generated labels.
  
* **--label-color**=_COLOR_  
  Use COLOR as the color for generated labels.
  
* **--label-bgcolor**=_COLOR_  
  Use _COLOR_ as the background color for generated labels.
  
* **--product-name**=_STRING_  
  Use _STRING_ as the product name in generated labels.
  
* **--product-version**=_STRING_  
  Use _STRING_ as the product version in generated labels.
  
* **--sparc-boot**  
  Enable booting the SPARC platform.  This disables HFS+, APM, ARCS, and "boot as disk image" on the _i386-pc_ target platform.
  
* **--arcs-boot**  
  Enable ARCS booting.  This is typically for big-endian MIPS machines, and disables HFS+, APM, sparc64, and "boot as disk image" on the _i386-pc_ target platform.
  
* **--**  
  All options after a **--** will be passed directly to xorriso's command line when generating the image.
  

<a name="see-also"></a>

# See Also

**info grub**
