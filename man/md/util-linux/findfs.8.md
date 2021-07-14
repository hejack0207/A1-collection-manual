# findfs(8) - find a filesystem by label or UUID

util-linux, March 2014

```
findfs NAME=value
```

<a name="description"></a>

# Description

**findfs**
will search the block devices in the system looking for a filesystem or
partition with specified tag. The currently supported tags are:

* **LABEL=&lt;label&gt;**  
  Specifies filesystem label.
* **UUID=&lt;uuid&gt;**  
  Specifies filesystem UUID.
* **PARTUUID=&lt;uuid&gt;**  
  Specifies partition UUID. This partition identifier is supported for example for
  GUID  Partition  Table (GPT) partition tables.
* **PARTLABEL=&lt;label&gt;**  
  Specifies partition label (name). The partition labels are supported for example for
  GUID Partition Table (GPT) or MAC partition tables.

If the filesystem or partition is found, the device name will be printed on
stdout.

The complete overview about filesystems and partitions you can get for example
by
  
**lsblk --fs**  

**partx --show &lt;disk&gt;**  

**blkid**  




<a name="exit-status"></a>

# Exit Status


* **0**
  success
* **1**
  label or uuid cannot be found
* **2**
  usage error, wrong number of arguments or unknown option

<a name="author"></a>

# Author

**findfs**
was originally written by
.MT [tytso@mit.edu](mailto:tytso@mit.edu)
Theodore Ts'o
.ME
and re-written for the util-linux package by
.MT [kzak@redhat.com](mailto:kzak@redhat.com)
Karel Zak
.ME .

<a name="environment"></a>

# Environment


* LIBBLKID_DEBUG=all  
  enables libblkid debug output.

<a name="see-also"></a>

# See Also

**blkid**(8),
**lsblk**(8),
**partx**(8)

<a name="availability"></a>

# Availability

The findfs command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
