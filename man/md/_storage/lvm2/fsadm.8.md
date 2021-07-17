# fsadm(8) - utility to resize or check filesystem on a device

Red Hat, Inc, LVM TOOLS 2.02.183(2) (2018-12-07)

```
.HP 5 fsadm [options] check device .HP fsadm [options] resize device [new_size]
```

<a name="description"></a>

# Description

fsadm utility checks or resizes the filesystem on a device.
It tries to use the same API for
**ext2**,
**ext3**,
**ext4**,
**ReiserFS**
and
**XFS**
filesystem.

<a name="options"></a>

# Options

.HP
**-e**|**--ext-offline**  
Unmount ext2/ext3/ext4 filesystem before doing resize.
.HP
**-l**|**--lvresize**  
Resize given device if it is LVM device.
.HP
**-f**|**--force**  
Bypass some sanity checks.
.HP
**-h**|**--help**  
Display the help text.
.HP
**-n**|**--dry-run**  
Print commands without running them.
.HP
**-v**|**--verbose**  
Be more verbose.
.HP
**-y**|**--yes**  
Answer "yes" at any prompts.
.HP
**-c**|**--cryptresize**  
Resize dm-crypt mapping together with filesystem detected on the device. The dm-crypt device must be recognizable by cryptsetup(8).
.HP
**new_size**[**B**|**K**|**M**|**G**|**T**|**P**|**E**]  
Absolute number of filesystem blocks to be in the filesystem,
or an absolute size using a suffix (in powers of 1024).
If new_size is not supplied, the whole device is used.

<a name="diagnostics"></a>

# Diagnostics

On successful completion, the status code is 0.
A status code of 2 indicates the operation was interrupted by the user.
A status code of 3 indicates the requested check operation could not be performed
because the filesystem is mounted and does not support an online
**fsck**(8).
A status code of 1 is used for other failures.

<a name="examples"></a>

# Examples

Resize the filesystem on logical volume _/dev/vg/test_ to 1000 megabytes.
If _/dev/vg/test_ contains ext2/ext3/ext4
filesystem it will be unmounted prior the resize.
All [y/n] questions will be answered 'y'.

**fsadm -e -y resize /dev/vg/test 1000M**

<a name="environment-variables"></a>

# Environment Variables


* **TMPDIR   **  
  The temporary directory name for mount points. Defaults to "_/tmp_".
* **DM_DEV_DIR**  
  The device directory name.
  Defaults to "_/dev_" and must be an absolute path.
  

<a name="see-also"></a>

# See Also

.nh
**lvm**(8),
**lvresize**(8),
**lvm.conf**(5),
**fsck**(8),
**tune2fs**(8),
**resize2fs**(8),
**reiserfstune**(8),
**resize_reiserfs**(8),
**xfs_info**(8),
**xfs_growfs**(8),
**xfs_check**(8),
**cryptsetup**(8)
