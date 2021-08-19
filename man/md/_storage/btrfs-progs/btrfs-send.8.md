# btrfs\-send(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-send - generate a stream of changes between two subvolume snapshots

<a name="synopsis"></a>

# Synopsis

```

 btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]
```

<a name="description"></a>

# Description


This command will generate a stream of instructions that describe changes between two subvolume snapshots. The stream can be consumed by the **btrfs receive** command to replicate the sent snapshot on a different filesystem. The command operates in two modes: full and incremental.

All snapshots involved in one send command must be read-only, and this status cannot be changed as long as there’s a running send operation that uses the snapshot.

In the full mode, the entire snapshot data and metadata will end up in the stream.

In the incremental mode (options _-p_ and _-c_), previously sent snapshots that are available on both the sending and receiving side can be used to reduce the amount of information that has to be sent to reconstruct the sent snapshot on a different filesystem.

The _-p __&lt;parent&gt;_ option can be omitted when _-c __&lt;clone-src&gt;_ options are given, in which case **btrfs send** will determine a suitable parent from among the clone sources.

You must not specify clone sources unless you guarantee that these snapshots are exactly in the same state on both sides—both for the sender and the receiver.

**Options**

-e
if sending multiple subvolumes at once, use the new format and omit the
_end cmd_
marker in the stream separating the subvolumes

-p _&lt;parent&gt;_
send an incremental stream from
_parent_
to
_subvol_

-c _&lt;clone-src&gt;_
use this snapshot as a clone source for an incremental send (multiple allowed)

-f _&lt;outfile&gt;_
output is normally written to standard output so it can be, for example, piped to btrfs receive. Use this option to write it to a file instead.

--no-data
send in
_NO\_FILE\_DATA_
mode

The output stream does not contain any file data and thus cannot be used to transfer changes. This mode is faster and is useful to show the differences in metadata. -q|--quiet:::: (deprecated) alias for global
_-q_
option -v|--verbose:: (deprecated) alias for global
_-v_
option

**Global options**

-q|--quiet
suppress all messages except errors

-v|--verbose
increase output verbosity, print generated commands in a readable form

<a name="exit-status"></a>

# Exit Status


**btrfs send** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **btrfs-receive**(8)
