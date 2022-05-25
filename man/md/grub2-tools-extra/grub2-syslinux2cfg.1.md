# grub-syslinux2cfg(1) - Transform a syslinux config file into a GRUB config.

Wed Feb 26 2014

```
grub-syslinux2cfg [-c | --cwd=DIR] [-r | --root=DIR] [-v | --verbose] .RE .RS 25 [-t | --target-root=DIR] [-T | --target-cwd=DIR] .RE .RS 25 [-o | --output=FILE] [[-i | --isolinux] | .RE .RS 46  [-s | --syslinux] | .RE .RS 46  [-p | --pxelinux]] FILE
```


<a name="description"></a>

# Description

**grub-syslinux2cfg** builds a GRUB configuration file out of an existing
syslinux configuration file.


<a name="options"></a>

# Options


* --cwd=_DIR_  
  Set _DIR_ as syslinux's working directory.  The default is to use the
  parent directory of the input file.
  
* --root=_DIR_  
  Set _DIR_ as the root directory of the syslinux disk.  The default value
  is "/".
  
* --verbose  
  Print verbose messages.
  
* --target-root=_DIR_  
  Root directory as it will be seen at runtime.  The default value is "/".
  
* --target-cwd=_DIR_  
  Working directory of syslinux as it will be seen at runtime.  The default
  value is the parent directory of the input file.
  
* --output=_FILE_  
  Write the new config file to _FILE_.  The default value is standard output.
  
* --isolinux  
  Assume that the input file is an isolinux configuration file.
  
* --pxelinux  
  Assume that the input file is a pxelinux configuration file.
  
* --syslinux  
  Assume that the input file is a syslinux configuration file.
  

<a name="see-also"></a>

# See Also

**info grub**
