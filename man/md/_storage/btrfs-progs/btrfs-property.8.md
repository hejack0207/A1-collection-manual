# btrfs\-property(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-property - get/set/list properties for given filesystem object

<a name="synopsis"></a>

# Synopsis

```

 btrfs property <subcommand> <args>
```

<a name="description"></a>

# Description


**btrfs property** is used to get/set/list property for given filesystem object. The object can be an inode (file or directory), subvolume or the whole filesystem. See the description of **get** subcommand for more information about both btrfs object and property.

**btrfs property** provides an unified and user-friendly method to tune different btrfs properties instead of using the traditional method like **chattr**(1) or **lsattr**(1).

<a name="subcommand"></a>

# Subcommand


**get** [-t _&lt;type&gt;_] _&lt;object&gt;_ [_&lt;name&gt;_]
get property from a btrfs
_&lt;object&gt;_
of given
_&lt;type&gt;_

A btrfs object, which is set by
_&lt;object&gt;_, can be a btrfs filesystem itself, a btrfs subvolume, an inode (file or directory) inside btrfs, or a device on which a btrfs exists.

The option
_-t_
can be used to explicitly specify what type of object you meant. This is only needed when a property could be set for more then one object type.

Possible types are
_s[ubvol]_,
_f[ilesystem]_,
_i[node]_
and
_d[evice]_, where the first lettes is a shortcut.

Set the name of property by
_name_. If no
_name_
is specified, all properties for the given object are printed.
_name_
is one of the following:

ro
read-only flag of subvolume: true or false

label
label of the filesystem. For an unmounted filesystem, provide a path to a block device as object. For a mounted filesystem, specify a mount point.

compression
compression algorithm set for an inode, possible values:
_lzo_,
_zlib_,
_zstd_. To disable compression use "" (empty string),
_no_
or
_none_.

**list** [-t _&lt;type&gt;_] _&lt;object&gt;_
Lists available properties with their descriptions for the given object.

See the description of
**get**
subcommand for the meaning of each option.

**set** [-t _&lt;type&gt;_] _&lt;object&gt;_ _&lt;name&gt;_ _&lt;value&gt;_
Sets a property on a btrfs object.

See the description of
**get**
subcommand for the meaning of each option.

<a name="exit-status"></a>

# Exit Status


**btrfs property** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **lsattr**(1), **chattr**(1)
