# grub-glue-efi(3) - Create an Apple fat EFI binary.

Wed Feb 26 2014

```
grub-glue-efi <-3 | --input32=FILE> <-6 | --input64=FILE> .RS 15 <-o | --output=FILE> [-v | --verbose]
```


<a name="description"></a>

# Description

**grub-glue-efi** creates an Apple fat EFI binary from two EFI binaries.


<a name="options"></a>

# Options


* **--input32**=_FILE_  
  Read 32-bit binary from _FILE_.
  
* **--input64**=_FILE_  
  Read 64-bit binary from _FILE_.
  
* **--output**=_FILE_  
  Write resulting fat binary to _FILE_.
  
* **--verbose**  
  Print verbose messages.
  

<a name="see-also"></a>

# See Also

**info grub**
