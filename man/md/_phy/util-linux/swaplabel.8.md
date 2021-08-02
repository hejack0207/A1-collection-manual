# swaplabel(8) - print or change the label or UUID of a swap area

util-linux, April 2010

```
swaplabel [-L label] [-U UUID] device
```

<a name="description"></a>

# Description

**swaplabel**
will display or change the label or UUID of a swap partition located on
_device_
(or regular file).

If the optional arguments
**-L**
and
**-U**
are not given,
**swaplabel**
will simply display the current swap-area label and UUID of
_device_.

If an optional argument is present, then
**swaplabel**
will change the appropriate value on
_device_.
These values can also be set during swap creation using
**mkswap**(8).
The
**swaplabel**
utility allows to change the label or UUID on an actively used swap device.

<a name="options"></a>

# Options


* **-h**,** --help**  
  Display help text and exit.
* **-L**,** --label **_label_  
  Specify a new _label_ for the device.
  Swap partition labels can be at most 16 characters long.  If
  _label_
  is longer than 16 characters,
  **swaplabel**
  will truncate it and print a warning message.
* **-U**,** --uuid **_UUID_  
  Specify a new _UUID_ for the device.
  The _ UUID_
  must be in the standard 8-4-4-4-12 character format, such as is output by
  **uuidgen**(1).


<a name="author"></a>

# Author

**swaplabel**
was written by Jason Borden &lt;[jborden@bluehost.com](mailto:jborden@bluehost.com)&gt; and Karel Zak &lt;kzak@redhat.com&gt;.

<a name="environment"></a>

# Environment


* LIBBLKID_DEBUG=all  
  enables libblkid debug output.

<a name="availability"></a>

# Availability

The swaplabel command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.

<a name="see-also"></a>

# See Also

**uuidgen**(1),
**mkswap**(8),
**swapon**(8)
