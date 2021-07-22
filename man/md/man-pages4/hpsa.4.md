# hpsa(4) - HP Smart Array SCSI driver

Linux, 2017-09-15

    modprobe hpsa [ hpsa_allow_any=1 ]

<a name="description"></a>

# Description

**hpsa**
is a SCSI driver for HP Smart Array RAID controllers.

<a name="options"></a>

### Options

_hpsa_allow_any=1_:
This option allows the driver to attempt to operate on
any HP Smart Array hardware RAID controller,
even if it is not explicitly known to the driver.
This allows newer hardware to work with older drivers.
Typically this is used to allow installation of
operating systems from media that predates the
RAID controller, though it may also be used to enable
**hpsa**
to drive older controllers that would normally be handled by the
**cciss**(4)
driver.
These older boards have not been tested and are
not supported with
**hpsa**,
and
**cciss**(4)
should still be used for these.

<a name="supported-hardware"></a>

### Supported hardware

The
**hpsa**
driver supports the following Smart Array boards:

        Smart Array P700M
        Smart Array P212
        Smart Array P410
        Smart Array P410i
        Smart Array P411
        Smart Array P812
        Smart Array P712m
        Smart Array P711m
        StorageWorks P1210m


Since Linux 4.14, the following Smart Array boards are also supported:

        Smart Array 5300
        Smart Array 5312
        Smart Array 532
        Smart Array 5i
        Smart Array 6400
        Smart Array 6400 EM
        Smart Array 641
        Smart Array 642
        Smart Array 6i
        Smart Array E200
        Smart Array E200i
        Smart Array E200i
        Smart Array E200i
        Smart Array E200i
        Smart Array E500
        Smart Array P400
        Smart Array P400i
        Smart Array P600
        Smart Array P700m
        Smart Array P800

<a name="configuration-details"></a>

### Configuration details

To configure HP Smart Array controllers,
use the HP Array Configuration Utility (either
**hpacuxe**(8)
or
**hpacucli**(8))
or the Offline ROM-based Configuration Utility (ORCA)
run from the Smart Array's option ROM at boot time.

<a name="files"></a>

# Files


<a name="device-nodes"></a>

### Device nodes

Logical drives are accessed via the SCSI disk driver
(**sd**(4)),
tape drives via the SCSI tape driver
(**st**(4)),
and
the RAID controller via the SCSI generic driver
(**sg**(4)),
with device nodes named
_/dev/sd*_,
_/dev/st*_,
and
_/dev/sg*_,
respectively.

<a name="hpsa-specific-host-attribute-files-in-sys"></a>

### HPSA-specific host attribute files in /sys


* _/sys/class/scsi_host/host*/rescan_  
  This is a write-only attribute.
  Writing to this attribute will cause the driver to scan for
  new, changed, or removed devices (e.g., hot-plugged tape drives,
  or newly configured or deleted logical drives, etc.)
  and notify the SCSI midlayer of any changes detected.
  Normally a rescan is triggered automatically
  by HP's Array Configuration Utility (either the GUI or the
  command-line variety);
  thus, for logical drive changes, the user should not
  normally have to use this attribute.
  This attribute may be useful when hot plugging devices like tape drives,
  or entire storage boxes containing preconfigured logical drives.
* _/sys/class/scsi_host/host*/firmware_revision_  
  This attribute contains the firmware version of the Smart Array.
* For example:
* .in +4n
  .EX
  # **cd /sys/class/scsi\_host/host4**
  # **cat firmware\_revision**
  7.14
  .EE
  .in
  

<a name="hpsa-specific-disk-attribute-files-in-sys"></a>

### HPSA-specific disk attribute files in /sys


* _/sys/class/scsi_disk/c:b:t:l/device/unique_id_  
  This attribute contains a 32 hex-digit unique ID for each logical drive.
* For example:
* .in +4n
  .EX
  # **cd /sys/class/scsi\_disk/4:0:0:0/device**
  # **cat unique\_id**
  600508B1001044395355323037570F77
  .EE
  .in
* _/sys/class/scsi_disk/c:b:t:l/device/raid_level_  
  This attribute contains the RAID level of each logical drive.
* For example:
* .in +4n
  .EX
  # **cd /sys/class/scsi\_disk/4:0:0:0/device**
  # **cat raid\_level**
  RAID 0
  .EE
  .in
* _/sys/class/scsi_disk/c:b:t:l/device/lunid_  
  This attribute contains the 16 hex-digit (8 byte) LUN ID
  by which a logical drive or physical device can be addressed.
  _c_:_b_:_t_:_l_
  are the controller, bus, target, and lun of the device.

For example:

* .in +4n
  .EX
  # **cd /sys/class/scsi\_disk/4:0:0:0/device**
  # **cat lunid**
  0x0000004000000000
  .EE
  .in
  

<a name="supported-ioctl-operations"></a>

### Supported ioctl() operations

For compatibility with applications written for the
**cciss**(4)
driver, many, but
not all of the ioctls supported by the
**cciss**(4)
driver are also supported by the
**hpsa**
driver.
The data structures used by these ioctls are described in
the Linux kernel source file
_include/linux/cciss_ioctl.h_.

* **CCISS_DEREGDISK**, **CCISS_REGNEWDISK**, **CCISS_REGNEWD**  
  These three ioctls all do exactly the same thing,
  which is to cause the driver to rescan for new devices.
  This does exactly the same thing as writing to the
  hpsa-specific host "rescan" attribute.
* **CCISS_GETPCIINFO**  
  Returns PCI domain, bus, device and function and "board ID" (PCI subsystem ID).
* **CCISS_GETDRIVVER**  
  Returns driver version in three bytes encoded as:
* .in +4n
  .EX
  (major_version &lt;&lt; 16) | (minor_version &lt;&lt; 8) |
      (subminor_version)
  .EE
  .in
* **CCISS_PASSTHRU**, **CCISS_BIG_PASSTHRU**  
  Allows "BMIC" and "CISS" commands to be passed through to the Smart Array.
  These are used extensively by the HP Array Configuration Utility,
  SNMP storage agents, and so on.
  See
  _cciss_vol_status_
  at
  .UR http://cciss.sf.net
  .UE
  for some examples.

<a name="see-also"></a>

# See Also

**cciss**(4),
**sd**(4),
**st**(4),
**cciss_vol_status**(8),
**hpacucli**(8),
**hpacuxe**(8),

[](http://cciss.sf.net),
and
_Documentation/scsi/hpsa.txt_
and
_Documentation/ABI/testing/sysfs-bus-pci-devices-cciss_
in the Linux kernel source tree




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
