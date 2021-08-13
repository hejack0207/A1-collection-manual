# btrfs\-qgroup(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-qgroup - control the quota group of a btrfs filesystem

<a name="synopsis"></a>

# Synopsis

```

 btrfs qgroup <subcommand> <args>
```

<a name="description"></a>

# Description


**btrfs qgroup** is used to control quota group (qgroup) of a btrfs filesystem.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

To use qgroup you need to enable quota first using **btrfs quota enable** command.

.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  

Qgroup is not stable yet and will impact performance in current mainline kernel (v4.14).


<a name="qgroup"></a>

# Qgroup


Quota groups or qgroup in btrfs make a tree hierarchy, the leaf qgroups are attached to subvolumes. The size limits are set per qgroup and apply when any limit is reached in tree that contains a given subvolume.

The limits are separated between shared and exclusive and reflect the extent ownership. For example a fresh snapshot shares almost all the blocks with the original subvolume, new writes to either subvolume will raise towards the exclusive limit.

The qgroup identifiers conform to _level/id_ where level 0 is reserved to the qgroups associated with subvolumes. Such qgroups are created automatically.

The qgroup hierarchy is built by commands **create** and **assign**.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  

If the qgroup of a subvolume is destroyed, quota about the subvolume will not be functional until qgroup _0/__&lt;subvolume id&gt;_ is created again.


<a name="subcommand"></a>

# Subcommand


**assign** [options] _&lt;src&gt;_ _&lt;dst&gt;_ _&lt;path&gt;_
Assign qgroup
_&lt;src&gt;_
as the child qgroup of
_&lt;dst&gt;_
in the btrfs filesystem identified by
_&lt;path&gt;_.

**Options**

--rescan
(default since: 4.19) Automatically schedule quota rescan if the new qgroup assignment would lead to quota inconsistency. See
_QUOTA RESCAN_
for more information.

--no-rescan
Explicitly ask not to do a rescan, even if the assignment will make the quotas inconsistent. This may be useful for repeated calls where the rescan would add unnecessary overhead.

**create** _&lt;qgroupid&gt;_ _&lt;path&gt;_
Create a subvolume quota group.

For the
_0/__&lt;subvolume id&gt;_
qgroup, a qgroup can be created even before the subvolume is created.

**destroy** _&lt;qgroupid&gt;_ _&lt;path&gt;_
Destroy a qgroup.

If a qgroup is not isolated, meaning it is a parent or child qgroup, then it can only be destroyed after the relationship is removed.

**limit** [options] _&lt;size&gt;_|none [_&lt;qgroupid&gt;_] _&lt;path&gt;_
Limit the size of a qgroup to
_&lt;size&gt;_
or no limit in the btrfs filesystem identified by
_&lt;path&gt;_.

If
_&lt;qgroupid&gt;_
is not given, qgroup of the subvolume identified by
_&lt;path&gt;_
is used if possible.

**Options**

-c
limit amount of data after compression. This is the default, it is currently not possible to turn off this option.

-e
limit space exclusively assigned to this qgroup.

**remove** _&lt;src&gt;_ _&lt;dst&gt;_ _&lt;path&gt;_
Remove the relationship between child qgroup
_&lt;src&gt;_
and parent qgroup
_&lt;dst&gt;_
in the btrfs filesystem identified by
_&lt;path&gt;_.

**Options**

--rescan
(default since: 4.19) Automatically schedule quota rescan if the removed qgroup relation would lead to quota inconsistency. See
_QUOTA RESCAN_
for more information.

--no-rescan
Explicitly ask not to do a rescan, even if the removal will make the quotas inconsistent. This may be useful for repeated calls where the rescan would add unnecessary overhead.

**show** [options] _&lt;path&gt;_
Show all qgroups in the btrfs filesystem identified by
_&lt;path&gt;_.

**Options**

-p
print parent qgroup id.

-c
print child qgroup id.

-r
print limit of referenced size of qgroup.

-e
print limit of exclusive size of qgroup.

-F
list all qgroups which impact the given path(include ancestral qgroups)

-f
list all qgroups which impact the given path(exclude ancestral qgroups)

--raw
raw numbers in bytes, without the
_B_
suffix.

--human-readable
print human friendly numbers, base 1024, this is the default

--iec
select the 1024 base for the following options, according to the IEC standard.

--si
select the 1000 base for the following options, according to the SI standard.

--kbytes
show sizes in KiB, or kB with --si.

--mbytes
show sizes in MiB, or MB with --si.

--gbytes
show sizes in GiB, or GB with --si.

--tbytes
show sizes in TiB, or TB with --si.

--sort=[+/-]_&lt;attr&gt;_[,[+/-]_&lt;attr&gt;_]...
list qgroups in order of
_&lt;attr&gt;_.

_&lt;attr&gt;_
can be one or more of qgroupid,rfer,excl,max_rfer,max_excl.

Prefix +\*(Aq means ascending order and \*(Aq-\*(Aq means descending order of
_&lt;attr&gt;_. If no prefix is given, use ascending order by default.

If multiple
_&lt;attr&gt;_s is given, use comma to separate.

--sync
To retrieve information after updating the state of qgroups, force sync of the filesystem identified by
_&lt;path&gt;_
before getting information.

<a name="quota-rescan"></a>

# Quota Rescan


The rescan reads all extent sharing metadata and updates the respective qgoups accordingly.

The information consists of bytes owned exclusively (_excl_) or shared/referred to (_rfer_). There’s no explicit information about which extents are shared or owned exclusively. This means when qgroup relationship changes, extent owners change and qgroup numbers are no longer consistent unless we do a full rescan.

However there are cases where we can avoid a full rescan, if a subvolume whose _rfer_ number equals its _excl_ number, which means all bytes are exclusively owned, then assigning/removing this subvolume only needs to add/subtract _rfer_ number from its parent qgroup. This can speed up the rescan.

<a name="exit-status"></a>

# Exit Status


**btrfs qgroup** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **btrfs-subvolume**(8), **btrfs-quota**(8),
