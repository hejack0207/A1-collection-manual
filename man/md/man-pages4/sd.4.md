# sd(4) - driver for SCSI disk drives

Linux, 2017-09-15

    #include <linux/hdreg.h>        /* for HDIO_GETGEO */
    #include <linux/fs.h>           /* for BLKGETSIZE and BLKRRPART */

<a name="configuration"></a>

# Configuration

The block device name has the following form:
**sd**_lp,_
where
_l_
is a letter denoting the physical drive, and
_p_
is a number denoting the partition on that physical drive.
Often, the partition number,
_p_,
will be left off when the device corresponds to the whole drive.

SCSI disks have a major device number of 8, and a minor device number of
the form (16 *
_drive_number_) + _partition_number_,
where
_drive_number_
is the number of the physical drive in order of detection, and
_partition_number_
is as follows:

* +3  
  partition 0 is the whole drive
* partitions 1–4 are the DOS "primary" partitions
* partitions 5–8 are the DOS "extended" (or "logical") partitions

For example,
_/dev/sda_
will have major 8, minor 0, and will refer to all of the first SCSI drive
in the system; and
_/dev/sdb3_
will have major 8, minor 19, and will refer to the third DOS "primary"
partition on the second SCSI drive in the system.

At this time, only block devices are provided.
Raw devices have not yet been implemented.

<a name="description"></a>

# Description

The following
_ioctl_s
are provided:

* **HDIO_GETGEO**  
  Returns the BIOS disk parameters in the following structure:

.in +4n
.EX
struct hd_geometry {
    unsigned char  heads;
    unsigned char  sectors;
    unsigned short cylinders;
    unsigned long  start;
};
.EE
.in

* A pointer to this structure is passed as the
  **ioctl**(2)
  parameter.
* The information returned in the parameter is the disk geometry of the drive
  _as understood by DOS!_
  This geometry is
  _not_
  the physical geometry of the drive.
  It is used when constructing the
  drive's partition table, however, and is needed for convenient operation
  of
  **fdisk**(1),
  **efdisk**(1),
  and
  **lilo**(1).
  If the geometry information is not available, zero will be returned for all
  of the parameters.
* **BLKGETSIZE**  
  Returns the device size in sectors.
  The
  **ioctl**(2)
  parameter should be a pointer to a
  _long_.
* **BLKRRPART**  
  Forces a reread of the SCSI disk partition tables.
  No parameter is needed.
* The SCSI
  **ioctl**(2)
  operations are also supported.
  If the
  **ioctl**(2)
  parameter is required, and it is NULL, then
  **ioctl**(2)
  fails with the error
  **EINVAL**.

<a name="files"></a>

# Files


* _/dev/sd[a-h]_  
  the whole device
* _/dev/sd[a-h][0-8]_  
  individual block partitions
  
  

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
