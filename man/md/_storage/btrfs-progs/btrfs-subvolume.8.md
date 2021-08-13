# btrfs\-subvolume(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-subvolume - manage btrfs subvolumes

<a name="synopsis"></a>

# Synopsis

```

 btrfs subvolume <subcommand> [<args>]
```

<a name="description"></a>

# Description


**btrfs subvolume** is used to create/delete/list/show btrfs subvolumes and snapshots.

<a name="subvolume-and-snapshot"></a>

# Subvolume and Snapshot


A subvolume is a part of filesystem with its own independent file/directory hierarchy. Subvolumes can share file extents. A snapshot is also subvolume, but with a given initial content of the original subvolume.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

A subvolume in btrfs is not like an LVM logical volume, which is block-level snapshot while btrfs subvolumes are file extent-based.


A subvolume looks like a normal directory, with some additional operations described below. Subvolumes can be renamed or moved, nesting subvolumes is not restricted but has some implications regarding snapshotting.

A subvolume in btrfs can be accessed in two ways:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  like any other directory that is accessible to the user

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  like a separately mounted filesystem (options
  _subvol_
  or
  _subvolid_)

In the latter case the parent directory is not visible and accessible. This is similar to a bind mount, and in fact the subvolume mount does exactly that.

A freshly created filesystem is also a subvolume, called _top-level_, internally has an id 5. This subvolume cannot be removed or replaced by another subvolume. This is also the subvolume that will be mounted by default, unless the default subvolume has been changed (see subcommand _set-default_).

A snapshot is a subvolume like any other, with given initial content. By default, snapshots are created read-write. File modifications in a snapshot do not affect the files in the original subvolume.

<a name="subcommand"></a>

# Subcommand


**create** [-i _&lt;qgroupid&gt;_] [&lt;dest&gt;/]_&lt;name&gt;_
Create a subvolume
_&lt;name&gt;_
in
_&lt;dest&gt;_.

If
_&lt;dest&gt;_
is not given, subvolume
_&lt;name&gt;_
will be created in the current directory.

**Options**

-i _&lt;qgroupid&gt;_
Add the newly created subvolume to a qgroup. This option can be given multiple times.

**delete** [options] _&lt;[&lt;subvolume&gt;_ [_&lt;subvolume&gt;_...]], **delete** -i|--subvolid _&lt;subvolid&gt;_ _&lt;path&gt;_&gt;
Delete the subvolume(s) from the filesystem.

If
_&lt;subvolume&gt;_
is not a subvolume, btrfs returns an error but continues if there are more arguments to process.

If --subvolid is used,
_&lt;path&gt;_
must point to a btrfs filesystem. See
**btrfs subvolume list**
or
**btrfs inspect-internal rootid**
how to get the subvolume id.

The corresponding directory is removed instantly but the data blocks are removed later in the background. The command returns immediately. See
**btrfs subvolume sync**
how to wait until the subvolume gets completely removed.

The deletion does not involve full transaction commit by default due to performance reasons. As a consequence, the subvolume may appear again after a crash. Use one of the
_--commit_
options to wait until the operation is safely stored on the device.

**Options**

-c|--commit-after
wait for transaction commit at the end of the operation.

-C|--commit-each
wait for transaction commit after deleting each subvolume.

-i|--subvolid _&lt;subvolid&gt;_
subvolume id to be removed instead of the
_&lt;path&gt;_
that should point to the filesystem with the subvolume

-v|--verbose
(deprecated) alias for global
_-v_
option

**find-new** _&lt;subvolume&gt;_ _&lt;last\_gen&gt;_
List the recently modified files in a subvolume, after
_&lt;last\_gen&gt;_
generation.

**get-default** _&lt;path&gt;_
Get the default subvolume of the filesystem
_&lt;path&gt;_.

The output format is similar to
**subvolume list**
command.

**list** [options] [-G [+|-]_&lt;value&gt;_] [-C [+|-]_&lt;value&gt;_] [--sort=rootid,gen,ogen,path] _&lt;path&gt;_
List the subvolumes present in the filesystem
_&lt;path&gt;_.

For every subvolume the following information is shown by default:

ID
_&lt;ID&gt;_
gen
_&lt;generation&gt;_
top level
_&lt;ID&gt;_
path
_&lt;path&gt;_

where ID is subvolume’s id, gen is an internal counter which is updated every transaction, top level is the same as parent subvolume’s id, and path is the relative path of the subvolume to the top level subvolume. The subvolume’s ID may be used by the subvolume set-default command, or at mount time via the subvolid= option.

**Options**

Path filtering

-o
print only subvolumes below specified
_&lt;path&gt;_.

-a
print all the subvolumes in the filesystem and distinguish between absolute and relative path with respect to the given
_&lt;path&gt;_.

Field selection

-p
print the parent ID (_parent_
here means the subvolume which contains this subvolume).

-c
print the ogeneration of the subvolume, aliases: ogen or origin generation.

-g
print the generation of the subvolume (default).

-u
print the UUID of the subvolume.

-q
print the parent UUID of the subvolume (_parent_
here means subvolume of which this subvolume is a snapshot).

-R
print the UUID of the sent subvolume, where the subvolume is the result of a receive operation.

Type filtering

-s
only snapshot subvolumes in the filesystem will be listed.

-r
only readonly subvolumes in the filesystem will be listed.

-d
list deleted subvolumes that are not yet cleaned.

Other

-t
print the result as a table.

Sorting
By default the subvolumes will be sorted by subvolume ID ascending.

-G [+|-]_&lt;value&gt;_
list subvolumes in the filesystem that its generation is &gt;=, \(la or = value. +\*(Aq means &gt;= value, \*(Aq-\*(Aq means &lt;= value, If there is neither \*(Aq+\*(Aq nor \*(Aq-\*(Aq, it means = value.

-C [+|-]_&lt;value&gt;_
list subvolumes in the filesystem that its ogeneration is &gt;=, &lt;= or = value. The usage is the same to
_-G_
option.

--sort=rootid,gen,ogen,path
list subvolumes in order by specified items. you can add +\*(Aq or \*(Aq-\*(Aq in front of each items, \*(Aq+\*(Aq means ascending, \*(Aq-\*(Aq means descending. The default is ascending.

for --sort you can combine some items together by ,\*(Aq, just like --sort=+ogen,-gen,path,rootid.

**set-default** [_&lt;subvolume&gt;_|_&lt;id&gt;_ _&lt;path&gt;_]
Set the default subvolume for the (mounted) filesystem.

Set the default subvolume for the (mounted) filesystem at
_&lt;path&gt;_. This will hide the top-level subvolume (i.e. the one mounted with
_subvol=/_
or
_subvolid=5_). Takes action on next mount.

There are two ways how to specify the subvolume, by
_&lt;id&gt;_
or by the
_&lt;subvolume&gt;_
path. The id can be obtained from
**btrfs subvolume list**,
**btrfs subvolume show**
or
**btrfs inspect-internal rootid**.

**show** [options] _&lt;path&gt;_
Show more information about subvolume
_&lt;path&gt;_
regarding UUIDs, times, generations, flags and related snapshots.

.if n \{.RS 4
.\}
    /mnt/btrfs/subvolume
            Name:                   subvolume
            UUID:                   5e076a14-4e42-254d-ac8e-55bebea982d1
            Parent UUID:            -
            Received UUID:          -
            Creation time:          2018-01-01 12:34:56 +0000
            Subvolume ID:           79
            Generation:             2844
            Gen at creation:        2844
            Parent ID:              5
            Top level ID:           5
            Flags:                  -
            Snapshot(s):
.if n \{.RE
.\}

**Options**

-r|--rootid
rootid of the subvolume.

-u|--uuid
UUID of the subvolume.

**snapshot** [-r|-i _&lt;qgroupid&gt;_] _&lt;source&gt;_ _&lt;dest&gt;_|[&lt;dest&gt;/]_&lt;name&gt;_
Create a snapshot of the subvolume
_&lt;source&gt;_
with the name
_&lt;name&gt;_
in the
_&lt;dest&gt;_
directory.

If only
_&lt;dest&gt;_
is given, the subvolume will be named the basename of
_&lt;source&gt;_. If
_&lt;source&gt;_
is not a subvolume, btrfs returns an error.

**Options**

-r
Make the new snapshot read only.

-i _&lt;qgroupid&gt;_
Add the newly created subvolume to a qgroup. This option can be given multiple times.

**sync** _&lt;path&gt;_ [subvolid...]
Wait until given subvolume(s) are completely removed from the filesystem after deletion. If no subvolume id is given, wait until all current deletion requests are completed, but do not wait for subvolumes deleted in the meantime.

**Options**

-s _&lt;N&gt;_
sleep N seconds between checks (default: 1)

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Deleting a subvolume**

If we want to delete a subvolume called **foo** from a btrfs volume mounted at **/mnt/bar** we could run the following:

.if n \{.RS 4
.\}
    btrfs subvolume delete /mnt/bar/foo
.if n \{.RE
.\}

<a name="exit-status"></a>

# Exit Status


**btrfs subvolume** returns a zero exit status if it succeeds. A non-zero value is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **mount**(8), **btrfs-quota**(8), **btrfs-qgroup**(8),
