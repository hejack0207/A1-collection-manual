# resizepart(8) - tell the kernel about the new size of a partition

util-linux, January 2015

```
resizepart device partition length
```

<a name="description"></a>

# Description

**resizepart**
tells the Linux kernel about the new size of the specified partition.
The command is a simple wrapper around the "resize partition" ioctl.

This command doesn't manipulate partitions on a block device.


<a name="parameters"></a>

# Parameters


* _device_  
  The disk device.
* _partition_  
  The partition number.
* _length_  
  The new length of the partition (in 512-byte sectors).
  

<a name="see-also"></a>

# See Also

**addpart**(8),
**delpart**(8),
**fdisk**(8),
**parted**(8),
**partprobe**(8),
**partx**(8)

<a name="availability"></a>

# Availability

The resizepart command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
