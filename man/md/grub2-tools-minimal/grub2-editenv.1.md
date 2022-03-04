# grub-editenv(1) - Manage the GRUB environment block.

Wed Feb 26 2014

```
grub-editenv [-v | --verbose] [FILE] .RS 14 <create | list | set NAME=VALUE | unset NAME>
```


<a name="description"></a>

# Description

**grub-editenv** is a command line tool to manage GRUB's stored environment.


<a name="options"></a>

# Options


* **--verbose**  
  Print verbose messages.
  
* **FILE**  
      File name to use for grub environment.  Default is /boot/grub/grubenv .
  

<a name="commands"></a>

# Commands


* **create**  
      Create a blank environment block file.
  
* **list**  
      List the current variables.
  
* **set** [_NAME_=_VALUE_ ...]  
  Set variables.
  
* **unset [NAME** ...]  
  Delete variables.
  

<a name="see-also"></a>

# See Also

**info grub**
