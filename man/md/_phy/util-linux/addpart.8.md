# addpart(8) - tell the kernel about the existence of a partition

util-linux, January 2015

```
addpart device partition start length
```

<a name="description"></a>

# Description

**addpart**
tells the Linux kernel about the existence of the specified partition.
The command is a simple wrapper around the "add partition" ioctl.

This command doesn't manipulate partitions on a block device.


<a name="parameters"></a>

# Parameters


* _device_  
  The disk device.
* _partition_  
  The partition number.
* _start_  
  The beginning of the partition (in 512-byte sectors).
* _length_  
  The length of the partition (in 512-byte sectors).
  

<a name="see-also"></a>

# See Also

**delpart**(8),
**fdisk**(8),
**parted**(8),
**partprobe**(8),
**partx**(8)

<a name="availability"></a>

# Availability

The addpart command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
