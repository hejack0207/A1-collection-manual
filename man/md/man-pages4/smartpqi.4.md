# smartpqi(4) - Microsemi Smart Family SCSI driver

Linux, 2017-10-19

```
.SY "modprobe smartpqi" [disable_device_id_wildcards={0|1}] [disable_heartbeat={0|1}] [disable_ctrl_shutdown={0|1}] [lockup_action={none|reboot|panic}] .YS
```

<a name="description"></a>

# Description

**smartpqi**
is a SCSI driver for Microsemi Smart Family controllers.

<a name="supported-fbiioctlfp-operations"></a>

### Supported \f[BI]ioctl\fP\/() operations

For compatibility with applications written for the
**cciss**(4)
and
**hpsa**(4)
drivers, many, but not all of the
**ioctl**(2)
operations supported by the
**hpsa**
driver are also supported by the
**smartpqi**
driver.
The data structures used by these operations
are described in the Linux kernel source file
_include/linux/cciss_ioctl.h_.

* **CCISS_DEREGDISK**, **CCISS_REGNEWDISK**, **CCISS_REGNEWD**  
  These operations
  all do exactly the same thing, which is to cause the driver to re-scan
  for new devices.
  This does exactly the same thing as writing to the
  **smartpqi**-specific
  host
  _rescan_
  attribute.
* **CCISS_GETPCIINFO**  
  This operation Returns the PCI domain, bus,
  device and function and "board ID" (PCI subsystem ID).
* **CCISS_GETDRIVVER**  
  This operation returns the driver version in four bytes, encoded as:
* .in +4n
  .EX
  (major_version &lt;&lt; 28) | (minor_version &lt;&lt; 24) |
          (release &lt;&lt; 16) | revision
  .EE
  .in
* **CCISS_PASSTHRU**  
  Allows BMIC and CISS commands to be passed through to the controller.

<a name="boot-options"></a>

### Boot options


* **disable_device_id_wildcards=**{**0**|**1**}  
  Disables support for device ID wildcards.
  The default value is 0.
* **disable_heartbeat=**{**0**|**1**}  
  Disables support for the controller's heartbeat check.
  This parameter is used for debugging purposes.
  The default value is 0, leaving the controller's heartbeat check active.
* **disable_ctrl_shutdown=**{**0**|**1**}  
  Disables support for shutting down the controller in the
  event of a controller lockup.
  The default value is 0.
* **lockup_action=**{**none**|**reboot**|**panic**}  
  Specifies the action the driver takes when a controller
  lockup is detected.
  The default action is
  **none**.
  .TS
  l l
  ---
  l l.
  parameter	action
  **none**	take controller offline only
  **reboot**	reboot the system
  **panic**	panic the system
  .TE

<a name="files"></a>

# Files


<a name="device-nodes"></a>

### Device nodes

Logical drives are accessed via the SCSI disk driver
(_sd_),
tape drives via the SCSI tape driver
(_st_),
and the RAID controller via the SCSI generic driver
(_sg_),
with device nodes named
_/dev/sd_*,
_/dev/st_*,
and
_/dev/sg_*,
respectively.

<a name="smartpqi-specific-host-attribute-files-in-fbisysfp"></a>

### SmartPQI-specific host attribute files in \f[BI]/sys\fP


* _/sys/class/scsi_host/host_*_/rescan_  
  The host
  _rescan_
  attribute is a write-only attribute.
  Writing to this attribute will cause the driver to scan for new,
  changed, or removed devices (e.g., hot-plugged tape drives, or newly
  configured or deleted logical drives) and notify the SCSI mid-layer of
  any changes detected.
  Usually this action is triggered automatically by configuration
  changes, so the user should not normally have to write to this file.
  Doing so may be useful when hot-plugging devices such as tape drives or
  entire storage boxes containing pre-configured logical drives.
* _/sys/class/scsi_host/host_*_/version_  
  The host
  _version_
  attribute is a read-only attribute.
  This attribute contains the driver version and the controller firmware
  version.
* For example:
* .in +4n
  .EX
  $ \c
  **cat /sys/class/scsi_host/host1/version**
  driver: 1.1.2-126
  firmware: 1.29-112
  .EE
  .in
* _/sys/class/scsi_host/host_*_/lockup_action_  
  The host
  _lockup_action_
  attribute is a read/write attribute.
  This attribute will cause the driver to perform a specific action in the
  unlikely event that a controller lockup has been detected.
  See
  **OPTIONS**
  above
  for an explanation of the
  _lockup_action_
  values.

<a name="smartpqi-specific-disk-attribute-files-in-fbisysfp"></a>

### SmartPQI-specific disk attribute files in \f[BI]/sys\fP

In the file specifications below,
_c_
stands for the number of the appropriate SCSI controller,
_b_
is the bus number,
_t_
the target number, and
_l_
is the logical unit number (LUN).

* _/sys/class/scsi_disk/_c_:_b_:_t_:_l_/device/raid_level_  
  The
  _raid_level_
  attribute is read-only.
  This attribute contains the RAID level of each logical drive.
* For example:
* .in +4n
  .EX
  $ \c
  **cat /sys/class/scsi_disk/4:0:0:0/device/raid_level**
  RAID 0
  .EE
  .in
* _/sys/class/scsi_disk/c_:_b_:_t_:_l/device/sas_address_  
  The
  _sas_address_
  attribute is read-only.
  This attribute contains the unique identifier of the disk.
* For example:
* .in +4n
  .EX
  $ \c
  **cat /sys/class/scsi_disk/1:0:3:0/device/sas_address**
  0x5001173d028543a2
  .EE
  .in
* _/sys/class/scsi_disk/c_:_b_:_t_:_l/device/ssd_smart_path_enabled_  
  The
  _ssd_smart_path_enabled_
  attribute is read-only.
  This attribute is for ioaccel-enabled volumes.
  (Ioaccel is an alternative driver submission path that allows the
  driver to send I/O requests directly to backend SCSI devices,
  bypassing the controller firmware.
  This results in an increase in performance.
  This method is used for HBA disks and for logical volumes comprised of SSDs.)
  Contains 1 if ioaccel is enabled for the volume and 0 otherwise.
* For example:
* .in +2n
  .EX
  $ \c
  **cat /sys/class/scsi_disk/1:0:3:0/device/ssd_smart_path_enabled**
  0
  .EE
  .in

<a name="versions"></a>

# Versions

The
**smarpqi**
driver was added in Linux 4.9.

<a name="notes"></a>

# Notes


<a name="configuration"></a>

### Configuration

To configure a Microsemi Smart Family controller,
refer to the User Guide for the controller,
which can be found by searching for the specific controller at
[](https://storage.microsemi.com/).

<a name="see-also"></a>

# See Also

**cciss**(4),
**hpsa**(4),
**sd**(4),
**st**(4)

_Documentation/ABI/testing/sysfs-bus-pci-devices-cciss_
in the Linux kernel source tree.

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
