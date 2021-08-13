# btrfs(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs - a toolbox to manage btrfs filesystems

<a name="synopsis"></a>

# Synopsis

```

 btrfs <command> [<args>]
```

<a name="description"></a>

# Description


The **btrfs** utility is a toolbox for managing btrfs filesystems. There are command groups to work with subvolumes, devices, for whole filesystem or other specific actions. See section **COMMANDS**.

There are also standalone tools for some tasks like **btrfs-convert** or **btrfstune** that were separate historically and/or haven’t been merged to the main utility. See section _STANDALONE TOOLS_ for more details.

For other topics (mount options, etc) please refer to the separate manual page **btrfs**(5).

<a name="command-syntax"></a>

# Command Syntax


Any command name can be shortened so long as the shortened form is unambiguous, however, it is recommended to use full command names in scripts. All command groups have their manual page named **btrfs-****&lt;group&gt;**.

For example: it is possible to run **btrfs sub snaps** instead of **btrfs subvolume snapshot**. But **btrfs file s** is not allowed, because **file s** may be interpreted both as **filesystem show** and as **filesystem sync**.

If the command name is ambiguous, the list of conflicting options is printed.

For an overview of a given command use _btrfs command --help_ or _btrfs [command...] --help --full_ to print all available options.

<a name="commands"></a>

# Commands


**balance**
Balance btrfs filesystem chunks across single or several devices.

See
**btrfs-balance**(8) for details.

**check**
Do off-line check on a btrfs filesystem.

See
**btrfs-check**(8) for details.

**device**
Manage devices managed by btrfs, including add/delete/scan and so on.

See
**btrfs-device**(8) for details.

**filesystem**
Manage a btrfs filesystem, including label setting/sync and so on.

See
**btrfs-filesystem**(8) for details.

**inspect-internal**
Debug tools for developers/hackers.

See
**btrfs-inspect-internal**(8) for details.

**property**
Get/set a property from/to a btrfs object.

See
**btrfs-property**(8) for details.

**qgroup**
Manage quota group(qgroup) for btrfs filesystem.

See
**btrfs-qgroup**(8) for details.

**quota**
Manage quota on btrfs filesystem like enabling/rescan and etc.

See
**btrfs-quota**(8) and
**btrfs-qgroup**(8) for details.

**receive**
Receive subvolume data from stdin/file for restore and etc.

See
**btrfs-receive**(8) for details.

**replace**
Replace btrfs devices.

See
**btrfs-replace**(8) for details.

**rescue**
Try to rescue damaged btrfs filesystem.

See
**btrfs-rescue**(8) for details.

**restore**
Try to restore files from a damaged btrfs filesystem.

See
**btrfs-restore**(8) for details.

**scrub**
Scrub a btrfs filesystem.

See
**btrfs-scrub**(8) for details.

**send**
Send subvolume data to stdout/file for backup and etc.

See
**btrfs-send**(8) for details.

**subvolume**
Create/delete/list/manage btrfs subvolume.

See
**btrfs-subvolume**(8) for details.

<a name="standalone-tools"></a>

# Standalone Tools


New functionality could be provided using a standalone tool. If the functionality proves to be useful, then the standalone tool is declared obsolete and its functionality is copied to the main tool. Obsolete tools are removed after a long (years) depreciation period.

Tools that are still in active use without an equivalent in **btrfs**:

**btrfs-convert**
in-place conversion from ext2/3/4 filesystems to btrfs

**btrfstune**
tweak some filesystem properties on a unmounted filesystem

**btrfs-select-super**
rescue tool to overwrite primary superblock from a spare copy

**btrfs-find-root**
rescue helper to find tree roots in a filesystem

Deprecated and obsolete tools:

**btrfs-debug-tree**
moved to
**btrfs inspect-internal dump-tree**. Removed from source distribution.

**btrfs-show-super**
moved to
**btrfs inspect-internal dump-super**, standalone removed.

**btrfs-zero-log**
moved to
**btrfs rescue zero-log**, standalone removed.

For space-constrained environments, it’s possible to build a single binary with functionality of several standalone tools. This is following the concept of busybox where the file name selects the functionality. This works for symlinks or hardlinks. The full list can be obtained by **btrfs help --box**.

<a name="exit-status"></a>

# Exit Status


**btrfs** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**btrfs**(5), **btrfs-balance**(8), **btrfs-check**(8), **btrfs-convert**(8), **btrfs-device**(8), **btrfs-filesystem**(8), **btrfs-inspect-internal**(8), **btrfs-property**(8), **btrfs-qgroup**(8), **btrfs-quota**(8), **btrfs-receive**(8), **btrfs-replace**(8), **btrfs-rescue**(8), **btrfs-restore**(8), **btrfs-scrub**(8), **btrfs-send**(8), **btrfs-subvolume**(8), **btrfstune**(8), **mkfs.btrfs**(8)
