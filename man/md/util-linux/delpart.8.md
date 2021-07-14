# delpart(8) - tell the kernel to forget about a partition

util-linux, January 2015

```
delpart device partition
```

<a name="description"></a>

# Description

**delpart**
asks the Linux kernel to forget about the specified _partition_
(a number) on the specified _device_.
The command is a simple wrapper around the "del partition" ioctl.

This command doesn't manipulate partitions on a block device.


<a name="see-also"></a>

# See Also

**addpart**(8),
**fdisk**(8),
**parted**(8),
**partprobe**(8),
**partx**(8)

<a name="availability"></a>

# Availability

The delpart command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
