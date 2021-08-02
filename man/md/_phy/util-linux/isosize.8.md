# isosize(8) - output the length of an iso9660 filesystem

util-linux, June 2011

```
isosize [options] iso9660_image_file
```

<a name="description"></a>

# Description


This command outputs the length of an iso9660 filesystem that
is contained in the specified file.  This file may be a normal file or
a block device (e.g. /dev/hdd or /dev/sr0).  In the absence of
any options (and errors), it will output the size of the iso9660
filesystem in bytes.  This can now be a large number (&gt;&gt; 4&nbsp;GB).

<a name="options"></a>

# Options


* **-x**,** --sectors**  
  Show the block count and block size in human-readable form.
  The output uses the term "sectors" for "blocks".
* **-d**,** --divisor **_number_  
  Only has an effect when
  **-x**
  is not given.  The value shown (if no errors)
  is the iso9660 file size in bytes divided by
  _number_.
  So if
  _number_
  is the block size then the shown value will be the block count.

The size of the file (or block device) holding an iso9660
filesystem can be marginally larger than the actual size of the
iso9660 filesystem.  One reason for this is that cd writers
are allowed to add "run out" sectors at the end of an iso9660
image.

<a name="exit-status"></a>

# Exit Status


* **0**
  success
* **1**
  generic failure, such as invalid usage
* **32**
  all failed
* **64**
  some failed

<a name="availability"></a>

# Availability

The isosize command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
