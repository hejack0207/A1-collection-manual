# grub-reboot(3) - Set the default boot menu entry for the next boot only.

Wed Feb 26 2014

```
grub-reboot [--boot-directory=DIR] MENU_ENTRY
```


<a name="description"></a>

# Description

**grub-reboot** sets the default boot menu entry for the next boot, but not further boots after that.  This command only works for GRUB configuration files created with _GRUB\_DEFAULT=saved_ in _/etc/default/grub_.


<a name="options"></a>

# Options


* --boot-directory=_DIR_  
  Find GRUB images under _DIR/grub_.  The default value is _/boot_, resulting in grub images being search for at _/boot/grub_.
  
* _MENU\_ENTRY_  
  A number, a menu item title or a menu item identifier.
  

<a name="see-also"></a>

# See Also

**info grub**
