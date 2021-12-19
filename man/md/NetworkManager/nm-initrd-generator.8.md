# nm\-initrd\-generator(8)

NetworkManager 1\&.16\&.4, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nm-initrd-generator - early boot NetworkManager configuration generator

<a name="synopsis"></a>

# Synopsis

```
.HP \w'nm-initrd-generator&nbsp;'u nm-initrd-generator [OPTIONS...] -- [CMDLINE...]
```

<a name="description"></a>

# Description


**nm-initrd-generator**
scans the command line for options relevant to network configuration and creates configuration files for an early instance of NetworkManager run from the initial ramdisk during early boot.

<a name="options"></a>

# Options


**-c** | **--connections-dir** _path_
Output connection directory.

**-d** | **--sysfs-dir** _path_
The sysfs mount point.

**-s** | **--stdout**
Dump connections to standard output. Useful for debugging.

_CMDLINE_
The options that appear on the kernel command line. The following options are recognized:
**ip**
**rd.route**
**bridge**
**bond**
**team**
**vlan**
**bootdev**
**nameserver**
**rd.peerdns**
**rd.bootif**
**BOOTIF**
Please consult the
**dracut.cmdline**(7)
manual for the documentation of the precise format of the values supported.

<a name="exit-status"></a>

# Exit Status


**nm-initrd-generator**
exits with status 0. It ignores unrecognized options and prints an error message if it encounters a malformed option.

<a name="see-also"></a>

# See Also


**dracut.cmdline**(7),
**NetworkManager**(8).
