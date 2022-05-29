# mkbootdisk(8)

Tue Mar 31 1998

.UC 4

<a name="name"></a>

# Name

mkbootdisk - creates a stand-alone boot floppy for the running system

<a name="synopsis"></a>

# Synopsis

```
mkbootdisk [--version] [--noprompt] [--verbose]             [--device devicefile] [--size size]            [--kernelargs <args>] [--iso] kernel
```


<a name="description"></a>

# Description

**mkbootdisk** creates a boot floppy appropriate for the running system. The
boot disk is entirely self-contained, and includes an initial ramdisk image
which loads any necessary SCSI modules for the system. The created boot 
disk looks for the root filesystem on the device suggested by /etc/fstab.
The only required argument is the kernel version to put onto the boot
floppy.


<a name="options"></a>

# Options


* **--device devicefile**  
  The boot image is created on _devicefile_. If **--device** is not
  specified, /dev/fd0 is used. If _devicefile_ does not exist 
  **mkinitrd** creates a 1.44Mb floppy image using _devicefile_ as
  the filename.
  
* **--noprompt**  
  Normally, **mkbootdisk** instructs the user to insert a floppy and
  waits for confirmation before continuing. If **--noprompt** is 
  specified, no prompt is displayed.
  
* **--verbose**  
  Instructs **mkbootdisk** to talk about what it's doing as it's doing
  it. Normally, there is no output from **mkbootdisk**.
  
* **--iso**  
  Instructs **mkbootdisk** to make a bootable ISO image as _devicefile_.
  
* **--version**  
  Displays the version of **mkbootdisk** and exits.
  
* **--kernelargs args**  
  Adds _args_ to the arguments appended on the kernel command line. If this
  is not specified **mkbootdisk** uses **grubby** to parse the arguments
  for the default kernel from **grub.conf**, if possible.
  
* **--size size**  
  Uses _size_ (in kilobytes) as the size of the image to use for the boot
  disk.  If this is not specified, **mkbootdisk** will assume a standard 
  1.44Mb floppy device.
  

<a name="see-also"></a>

# See Also

**grubby**(8)
**dracut**(8)


<a name="author"></a>

# Author

    Erik Troan <ewt@redhat.com>
