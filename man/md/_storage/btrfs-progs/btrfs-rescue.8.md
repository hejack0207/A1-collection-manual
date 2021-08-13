# btrfs\-rescue(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-rescue - Recover a damaged btrfs filesystem

<a name="synopsis"></a>

# Synopsis

```

 btrfs rescue <subcommand> <args>
```

<a name="description"></a>

# Description


**btrfs rescue** is used to try to recover a damaged btrfs filesystem.

<a name="subcommand"></a>

# Subcommand


**chunk-recover** [options] _&lt;device&gt;_
Recover the chunk tree by scanning the devices

**Options**

-y
assume an answer of
_yes_
to all questions.

-h
help.

-v
(deprecated) alias for global
_-v_
option
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

Since **chunk-recover** will scan the whole device, it will be **VERY** slow especially executed on a large device.


**fix-device-size** _&lt;device&gt;_
fix device size and super block total bytes values that are do not match

Kernel 4.11 starts to check the device size more strictly and this might mismatch the stored value of total bytes. See the exact error message below. Newer kernel will refuse to mount the filesystem where the values do not match. This error is not fatal and can be fixed. This command will fix the device size values if possible.

.if n \{.RS 4
.\}
    BTRFS error (device sdb): super_total_bytes 92017859088384 mismatch with fs_devices total_rw_bytes 92017859094528
.if n \{.RE
.\}

The mismatch may also exhibit as a kernel warning:

.if n \{.RS 4
.\}
    WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559 btrfs_update_device+0x1c5/0x1d0 [btrfs]
.if n \{.RE
.\}

**super-recover** [options] _&lt;device&gt;_
Recover bad superblocks from good copies.

**Options**

-y
assume an answer of
_yes_
to all questions.

-v
(deprecated) alias for global
_-v_
option

**zero-log** _&lt;device&gt;_
clear the filesystem log tree

This command will clear the filesystem log tree. This may fix a specific set of problem when the filesystem mount fails due to the log replay. See below for sample stacktraces that may show up in system log.

The common case where this happens was fixed a long time ago, so it is unlikely that you will see this particular problem, but the command is kept around.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
clearing the log may lead to loss of changes that were made since the last transaction commit. This may be up to 30 seconds (default commit period) or less if the commit was implied by other filesystem activity.

One can determine whether
**zero-log**
is needed according to the kernel backtrace:

.if n \{.RS 4
.\}
    ? replay_one_dir_item+0xb5/0xb5 [btrfs]
    ? walk_log_tree+0x9c/0x19d [btrfs]
    ? btrfs_read_fs_root_no_radix+0x169/0x1a1 [btrfs]
    ? btrfs_recover_log_trees+0x195/0x29c [btrfs]
    ? replay_one_dir_item+0xb5/0xb5 [btrfs]
    ? btree_read_extent_buffer_pages+0x76/0xbc [btrfs]
    ? open_ctree+0xff6/0x132c [btrfs]
.if n \{.RE
.\}

If the errors are like above, then
**zero-log**
should be used to clear the log and the filesystem may be mounted normally again. The keywords to look for are
_open\_ctree_
which says that it’s during mount and function names that contain
_replay_,
_recover_
or
_log\_tree_.

<a name="exit-status"></a>

# Exit Status


**btrfs rescue** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **btrfs-scrub**(8), **btrfs-check**(8)
