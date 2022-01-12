# isohybrid(1) - Post-process an ISO 9660 image for booting as a hard disk.

isohybrid, 17 Jan 2014

```
isohybrid [OPTIONS] <boot.iso>
```

<a name="description"></a>

# Description


The **isohybrid** utility modifies an ISO 9660 image generated with
mkisofs, genisoimage, or compatible utilities, to be bootable as a CD-ROM or
as a hard disk.

<a name="options"></a>

# Options


* **-h** _&lt;X&gt;_\fN    
  Number of geometry heads (default 64)
* **-s** _&lt;X&gt;_    
  Number of geometry sectors (default 32)
* **-e** _&lt;X&gt;_, **--entry** _&lt;X&gt;_  
  Specify parititon entry number (1-4)
* **-o** _&lt;X&gt;_, **--offset** _&lt;X&gt;_    
  Specify partition offset (default 0)
* **-t** _&lt;X&gt;_, **--type** _&lt;X&gt;_    
  Specify partition type (default 0x17)
* **-i** _&lt;X&gt;_, **--id** _&lt;X&gt;_    
  Specify MBR ID (default random)
* **-u**, --uefi  
  Build EFI bootable image
* **-m**, --mac  
  Add Apple File Protocol partition table support
* **--forcehd0**  
  Assume we are laoded as disk ID 0
* **--ctrlhd0**  
  Assume disk ID 0 if the Ctrl key is pressed
* **--partok**  
  Allow booting from within a partition
* **-?**, **--help**  
  Display help
* **-v**, **--verbose**  
  Display verbose output
* **-V**, **--version**  
  Display version information
  

<a name="see-also"></a>

# See Also


**mkisofs**(1)
