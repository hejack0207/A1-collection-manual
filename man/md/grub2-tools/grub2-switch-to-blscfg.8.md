# grub-switch-to-blscfg(1) - Switch to using BLS config files.

Wed Feb 26 2014

```
grub-switch-to-blscfg [--grub-directory=DIR] [--config-file=FILE] [--grub-defaults=FILE]
```


<a name="description"></a>

# Description

**grub-switch-to-blscfg** reconfigures grub-mkconfig to use BLS-style config files, and then regenerates the GRUB configuration.


<a name="options"></a>

# Options


* --grub-directory=_DIR_  
  Search for grub.cfg under _DIR_.  The default value is _/boot/efi/EFI/**VENDOR** on UEFI machines and /boot/grub2_ elsewhere.
  
* --config-file=_FILE_  
  The grub config file to use.  The default value is _/etc/grub2-efi.cfg_ on UEFI machines and _/etc/grub2.cfg_ elsewhere.  Symbolic links will be followed.
  
* --grub-defaults=_FILE_  
  The defaults file for grub-mkconfig.  The default value is _/etc/default/grub_.
  
* --bls-directory=_DIR_  
  Create BootLoaderSpec fragments in _DIR_.  The default value is _/boot/loader/entries_.
  
* --backup-suffix=\fSUFFIX  
  The suffix to use for saved backup files.  The default value is _.bak_.
  

<a name="see-also"></a>

# See Also

**info grub**
