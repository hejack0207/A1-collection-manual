# blkdeactivate(8) - utility to deactivate block devices

Red Hat, Inc, LVM TOOLS 2.03.10(2) (2020-08-09)

```
blkdeactivate [-d&nbsp;dm_options] [-e] [-h] [-l&nbsp;lvm_options] [-m&nbsp;mpath_options] [-r&nbsp;mdraid_options] [-o&nbsp;vdo_options] [-u] [-v] [device]
```

<a name="description"></a>

# Description

The blkdeactivate utility deactivates block devices. For mounted
block devices, it attempts to unmount it automatically before
trying to deactivate. The utility currently supports
device-mapper devices (DM), including LVM volumes and
software RAID MD devices. LVM volumes are handled directly
using the **lvm**(8) command, the rest of device-mapper
based devices are handled using the **dmsetup**(8) command.
MD devices are handled using the **mdadm**(8) command.

<a name="options"></a>

# Options


* **-d**, **--dmoptions**&nbsp;_dm\_options_  
  Comma separated list of device-mapper specific options.
  Accepted **dmsetup**(8) options are:
    * _retry_  
      Retry removal several times in case of failure.
    * _force_  
      Force device removal.
* **-e**, **--errors**  
  Show errors reported from tools called by **blkdeactivate**. Without this
  option, any error messages from these external tools are suppressed and the
  **blkdeactivate** itself provides only a summary message to indicate
  the device was skipped.
* **-h**, **--help**  
  Display the help text.
* **-l**, **--lvmoptions**&nbsp;_lvm\_options_  
  Comma-separated list of LVM specific options:
    * _retry_  
      Retry removal several times in case of failure.
    * _wholevg_  
      Deactivate the whole LVM Volume Group when processing a Logical Volume.
      Deactivating the Volume Group as a whole is quicker than deactivating
      each Logical Volume separately.
* **-m**, **--mpathoptions**&nbsp;_mpath\_options_  
  Comma-separated list of device-mapper multipath specific options:
    * _disablequeueing_  
      Disable queueing on all multipath devices before deactivation.
      This avoids a situation where blkdeactivate may end up waiting if
      all the paths are unavailable for any underlying device-mapper multipath
      device.
* **-r**, **--mdraidoptions**&nbsp;_mdraid\_options_  
  Comma-separated list of MD RAID specific options:
    * _wait_  
      Wait MD device's resync, recovery or reshape action to complete
      before deactivation.
  
* **-o**, **--vdooptions**&nbsp;_vdo\_options_  
  Comma-separated list of VDO specific options:
    * _configfile=file_  
      Use specified VDO configuration file.
  
* **-u**, **--umount**  
  Unmount a mounted device before trying to deactivate it.
  Without this option used, a device that is mounted is not deactivated.
* **-v**, **--verbose**  
  Run in verbose mode. Use --vv for even more verbose mode.

<a name="examples"></a>

# Examples

Deactivate all supported block devices found in the system, skipping mounted
devices.  
#
**blkdeactivate**  

Deactivate all supported block devices found in the system, unmounting any
mounted devices first, if possible.  
#
**blkdeactivate -u**  

Deactivate the device /dev/vg/lvol0 together with all its holders, unmounting 
any mounted devices first, if possible.  
#
**blkdeactivate -u /dev/vg/lvol0**  

Deactivate all supported block devices found in the system. If the deactivation
of a device-mapper device fails, retry it. Deactivate the whole
Volume Group at once when processing an LVM Logical Volume.  
#
**blkdeactivate -u -d retry -l wholevg**  

Deactivate all supported block devices found in the system. If the deactivation
of a device-mapper device fails, retry it and force removal.  
#
**blkdeactivate -d force,retry**

<a name="see-also"></a>

# See Also

**dmsetup**(8),
**lsblk**(8),
**lvm**(8),
**mdadm**(8),
**multipathd**(8),
**vdo**(8),
**umount**(8)
