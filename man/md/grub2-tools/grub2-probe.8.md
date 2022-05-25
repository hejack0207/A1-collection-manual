# grub-probe(3) - Probe device information for a given path.

Wed Feb 26 2014

```
grub-probe \[-d | --device] [-m | --device-map=FILE] .RS 12 [-t | --target=(fs|fs_uuid|fs_label|drive|device|partmap| .RE .RS 28 abstraction|cryptodisk_uuid| .RE .RS 28 msdos_parttype)] .RE .RS 12 [-v | --verbose] (PATH|DEVICE)
```


<a name="description"></a>

# Description

**grub-probe** probes a path or device for filesystem and related information.


<a name="options"></a>

# Options


* --device  
  Final option represents a _DEVICE_, rather than a filesystem _PATH_.
* --device-map=_FILE_  
  Use _FILE_ as the device map.  The default value is _/boot/grub/device.map_.
  
* --target=(fs|fs_uuid|fs_label|drive|device|partmap|msdos_parttype)  
  Select among various output definitions.  The default is _fs_.
    * _fs_  
      filesystem module
      
    * _fs\_uuid_  
      filesystem UUID
      
    * _fs\_label_  
      filesystem label
      
    * _drive_  
      GRUB drive name
      
    * _device_  
      System device
      
    * _partmap_  
      partition map module
      
    * _abstraction_  
      abstraction module
      
    * _cryptodisk\_uuid_  
      cryptographic container
      
    * _msdos\_partmap_  
      MS-DOS partition map
  
* --verbose  
  Print verbose output.
  
* (_PATH_|_DEVICE_)  
  If --device is passed, a block _DEVICE_.  Otherwise, the _PATH_ of a file on the filesystem.
  

<a name="see-also"></a>

# See Also

**info grub**
