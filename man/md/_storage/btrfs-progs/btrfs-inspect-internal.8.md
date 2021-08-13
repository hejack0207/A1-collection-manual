# btrfs\-inspect\-inte(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-inspect-internal - query various internal information

<a name="synopsis"></a>

# Synopsis

```

 btrfs inspect-internal <subcommand> <args>
```

<a name="description"></a>

# Description


This command group provides an interface to query internal information. The functionality ranges from a simple UI to an ioctl or a more complex query that assembles the result from several internal structures. The latter usually requires calls to privileged ioctls.

<a name="subcommand"></a>

# Subcommand


**dump-super** [options] _&lt;device&gt;_ [device...]
(replaces the standalone tool
**btrfs-show-super**)

Show btrfs superblock information stored on given devices in textual form. By default the first superblock is printed, more details about all copies or additional backup data can be printed.

Besides verification of the filesystem signature, there are no other sanity checks. The superblock checksum status is reported, the device item and filesystem UUIDs are checked and reported.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
the meaning of option
_-s_
has changed in version 4.8 to be consistent with other tools to specify superblock copy rather the offset. The old way still works, but prints a warning. Please update your scripts to use
_--bytenr_
instead. The option
_-i_
has been deprecated.

**Options**

-f|--full
print full superblock information, including the system chunk array and backup roots

-a|--all
print information about all present superblock copies (cannot be used together with
_-s_
option)

-i _&lt;super&gt;_
(deprecated since 4.8, same behaviour as
_--super_)

--bytenr _&lt;bytenr&gt;_
specify offset to a superblock in a non-standard location at
_bytenr_, useful for debugging (disables the
_-f_
option)

If there are multiple options specified, only the last one applies.

-F|--force
attempt to print the superblock even if a valid BTRFS signature is not found; the result may be completely wrong if the data does not resemble a superblock

-s|--super _&lt;bytenr&gt;_
(see compatibility note above)

specify which mirror to print, valid values are 0, 1 and 2 and the superblock must be present on the device with a valid signature, can be used together with
_--force_

**dump-tree** [options] _&lt;device&gt;_ [device...]
(replaces the standalone tool
**btrfs-debug-tree**)

Dump tree structures from a given device in textual form, expand keys to human readable equivalents where possible. This is useful for analyzing filesystem state or inconsistencies and has a positive educational effect on understanding the internal filesystem structure.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
contains file names, consider that if you’re asked to send the dump for analysis. Does not contain file data.

**Options**

-e|--extents
print only extent-related information: extent and device trees

-d|--device
print only device-related information: tree root, chunk and device trees

-r|--roots
print only short root node information, ie. the root tree keys

-R|--backups
same as --roots plus print backup root info, ie. the backup root keys and the respective tree root block offset

-u|--uuid
print only the uuid tree information, empty output if the tree does not exist

-b _&lt;block\_num&gt;_
print info of the specified block only, can be specified multiple times

--follow
use with
_-b_, print all children tree blocks of
_&lt;block\_num&gt;_

--dfs
(default up to 5.2)

use depth-first search to print trees, the nodes and leaves are intermixed in the output

--bfs
(default since 5.3)

use breadth-first search to print trees, the nodes are printed before all leaves

--hide-names
print a placeholder
_HIDDEN_
instead of various names, useful for developers to inspect the dump while keeping potentially sensitive information hidden

This is:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  directory entries (files, directories, subvolumes)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  default subvolume

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  extended attributes (name, value)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  hardlink names (if stored inside another item or as extended references in standalone items)
  .if n \{.sp
  .\}
      .it 1 an-trap
      .nr an-no-space-flag 1
      .nr an-break-flag 1  
      .ps +1
      **Note**
      .ps -1  
      lengths are not hidden because they can be calculated from the item size anyway.


--noscan
do not automatically scan the system for other devices from the same filesystem, only use the devices provided as the arguments

-t _&lt;tree\_id&gt;_
print only the tree with the specified ID, where the ID can be numerical or common name in a flexible human readable form

The tree id name recognition rules:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  case does not matter

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  the C source definition, eg. BTRFS_ROOT_TREE_OBJECTID

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  short forms without BTRFS_ prefix, without _TREE and _OBJECTID suffix, eg. ROOT_TREE, ROOT

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  convenience aliases, eg. DEVICE for the DEV tree, CHECKSUM for CSUM

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  unrecognized ID is an error

**inode-resolve** [-v] _&lt;ino&gt;_ _&lt;path&gt;_
(needs root privileges)

resolve paths to all files with given inode number
_ino_
in a given subvolume at
_path_, ie. all hardlinks

**Options**

-v
(deprecated) alias for global
_-v_
option

**logical-resolve** [-Pvo] [-s _&lt;bufsize&gt;_] _&lt;logical&gt;_ _&lt;path&gt;_
(needs root privileges)

resolve paths to all files at given
_logical_
address in the linear filesystem space

**Options**

-P
skip the path resolving and print the inodes instead

-o
ignore offsets, find all references to an extent instead of a single block. Requires kernel support for the V2 ioctl (added in 4.15). The results might need further processing to filter out unwanted extents by the offset that is supposed to be obtained by other means.

-s _&lt;bufsize&gt;_
set internal buffer for storing the file names to
_bufsize_, default is 64k, maximum 16m. Buffer sizes over 64K require kernel support for the V2 ioctl (added in 4.15).

-v
(deprecated) alias for global
_-v_
option

**min-dev-size** [options] _&lt;path&gt;_
(needs root privileges)

return the minimum size the device can be shrunk to, without performing any resize operation, this may be useful before executing the actual resize operation

**Options**

--id _&lt;id&gt;_
specify the device
_id_
to query, default is 1 if this option is not used

**rootid** _&lt;path&gt;_
for a given file or directory, return the containing tree root id, but for a subvolume itself return its own tree id (ie. subvol id)
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
The result is undefined for the so-called empty subvolumes (identified by inode number 2), but such a subvolume does not contain any files anyway


**subvolid-resolve** _&lt;subvolid&gt;_ _&lt;path&gt;_
(needs root privileges)

resolve the absolute path of the subvolume id
_subvolid_

**tree-stats** [options] _&lt;device&gt;_
(needs root privileges)

Print sizes and statistics of trees.

**Options**

-b
Print raw numbers in bytes.

<a name="exit-status"></a>

# Exit Status


**btrfs inspect-internal** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8)
