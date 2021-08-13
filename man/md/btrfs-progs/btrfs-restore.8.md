# btrfs\-restore(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-restore - try to restore files from a damaged btrfs filesystem image

<a name="synopsis"></a>

# Synopsis

```

 btrfs restore [options] <device> <path> | -l <device>
```

<a name="description"></a>

# Description


**btrfs restore** is used to try to salvage files from a damaged filesystem and restore them into _&lt;path&gt;_ or just list the subvolume tree roots. The filesystem image is not modified.

If the filesystem is damaged and cannot be repaired by the other tools (**btrfs-check**(8) or **btrfs-rescue**(8)), **btrfs restore** could be used to retrieve file data, as far as the metadata are readable. The checks done by restore are less strict and the process is usually able to get far enough to retrieve data from the whole filesystem. This comes at a cost that some data might be incomplete or from older versions if they’re available.

There are several options to attempt restoration of various file metadata type. You can try a dry run first to see how well the process goes and use further options to extend the set of restored metadata.

For images with damaged tree structures, there are several options to point the process to some spare copy.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

It is recommended to read the following btrfs wiki page if your data is not salvaged with default option: \m[blue]**https://btrfs.wiki.kernel.org/index.php/Restore**\m[]


<a name="options"></a>

# Options


-s|--snapshots
get also snapshots that are skipped by default

-x|--xattr
get extended attributes

-m|--metadata
restore owner, mode and times for files and directories

-S|--symlinks
restore symbolic links as well as normal files

-i|--ignore-errors
ignore errors during restoration and continue

-o|--overwrite
overwrite directories/files in
_&lt;path&gt;_, eg. for repeated runs

-t _&lt;bytenr&gt;_
use
_&lt;bytenr&gt;_
to read the root tree

-f _&lt;bytenr&gt;_
only restore files that are under specified subvolume root pointed by
_&lt;bytenr&gt;_

-u|--super _&lt;mirror&gt;_
use given superblock mirror identified by
_&lt;mirror&gt;_, it can be 0,1 or 2

-r|--root _&lt;rootid&gt;_
only restore files that are under a specified subvolume whose objectid is
_&lt;rootid&gt;_

-d
find directory

-l|--list-roots
list subvolume tree roots, can be used as argument for
_-r_

-D|--dry-run
dry run (only list files that would be recovered)

--path-regex _&lt;regex&gt;_
restore only filenames matching a regular expression (**regex**(7)) with a mandatory format

**^/(|home(|/username(|/Desktop(|/.*))))$**

The format is not very comfortable and restores all files in the directories in the whole path, so this is not useful for restoring single file in a deep hierarchy.

-c
ignore case (--path-regex only)

-v|--verbose
(deprecated) alias for global
_-v_
option

**Global options**

-v|--verbose
be verbose and print what is being restored

<a name="exit-status"></a>

# Exit Status


**btrfs restore** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **btrfs-rescue**(8), **btrfs-check**(8)
