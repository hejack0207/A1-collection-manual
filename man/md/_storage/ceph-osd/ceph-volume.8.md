# ceph-volume(8) - Ceph OSD deployment and inspection tool

dev, Apr 21, 2020

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

    ceph-volume [-h] [--cluster CLUSTER] [--log-level LOG_LEVEL]
    .in +2
    [--log-path LOG_PATH]
    .in -2
```


</synopsis>
    ceph-volume inventory
<synopsis>


</synopsis>
    ceph-volume lvm [ trigger | create | activate | prepare
    zap | list | batch]
<synopsis>


</synopsis>
    ceph-volume simple [ trigger | scan | activate ]
<synopsis>


```

<a name="description"></a>

# Description


**ceph-volume** is a single purpose command line tool to deploy logical
volumes as OSDs, trying to maintain a similar API to **ceph-disk** when
preparing, activating, and creating OSDs.

It deviates from **ceph-disk** by not interacting or relying on the udev rules
that come installed for Ceph. These rules allow automatic detection of
previously setup devices that are in turn fed into **ceph-disk** to activate
them.

<a name="commands"></a>

# Commands


<a name="inventory"></a>

### inventory


This subcommand provides information about a host's physical disc inventory and
reports metadata about these discs. Among this metadata one can find disc
specific data items (like model, size, rotational or solid state) as well as
data items specific to ceph using a device, such as if it is available for
use with ceph or if logical volumes are present.

Examples:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume inventory
    ceph-volume inventory /dev/sda
    ceph-volume inventory --format json-pretty
    .ft P
.UNINDENT
.UNINDENT

Optional arguments:
.INDENT 0.0

* ·  
  [-h, --help]          show the help message and exit
* ·  
  .INDENT 2.0
* **[--format] report format, valid values are **plain** (default),**  
  **json** and **json-pretty**
  .UNINDENT
  .UNINDENT

<a name="lvm"></a>

### lvm


By making use of LVM tags, the **lvm** sub-command is able to store and later
re-discover and query devices associated with OSDs so that they can later
activated.

Subcommands:

**batch**
Creates OSDs from a list of devices using a **filestore**
or **bluestore** (default) setup. It will create all necessary volume groups
and logical volumes required to have a working OSD.

Example usage with three devices:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm batch --bluestore /dev/sda /dev/sdb /dev/sdc
    .ft P
.UNINDENT
.UNINDENT

Optional arguments:
.INDENT 0.0

* ·  
  [-h, --help]          show the help message and exit
* ·  
  [--bluestore]         Use the bluestore objectstore (default)
* ·  
  [--filestore]         Use the filestore objectstore
* ·  
  [--yes]               Skip the report and prompt to continue provisioning
* ·  
  [--prepare]           Only prepare OSDs, do not activate
* ·  
  [--dmcrypt]           Enable encryption for the underlying OSD devices
* ·  
  [--crush-device-class] Define a CRUSH device class to assign the OSD to
* ·  
  [--no-systemd]         Do not enable or create any systemd units
* ·  
  .INDENT 2.0
* **[--report] Report what the potential outcome would be for the**  
  current input (requires devices to be passed in)
  .UNINDENT
* ·  
  .INDENT 2.0
* **[--format] Output format when reporting (used along with**  
  --report), can be one of 'pretty' (default) or 'json'
  .UNINDENT
* ·  
  .INDENT 2.0
* **[--block-db-size] Set (or override) the bluestore_block_db_size value,**  
  in bytes
  .UNINDENT
* ·  
  [--journal-size]      Override the "osd_journal_size" value, in megabytes
  .UNINDENT

Required positional arguments:
.INDENT 0.0

* ·  
  .INDENT 2.0
* **&lt;DEVICE&gt; Full path to a raw device, like **/dev/sda**. Multiple**  
  **&lt;DEVICE&gt;** paths can be passed in.
  .UNINDENT
  .UNINDENT

**activate**
Enables a systemd unit that persists the OSD ID and its UUID (also called
**fsid** in Ceph CLI tools), so that at boot time it can understand what OSD is
enabled and needs to be mounted.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm activate --bluestore <osd id> <osd fsid>
    .ft P
.UNINDENT
.UNINDENT

Optional Arguments:
.INDENT 0.0

* ·  
  [-h, --help]  show the help message and exit
* ·  
  [--auto-detect-objectstore] Automatically detect the objectstore by inspecting
  the OSD
* ·  
  [--bluestore] bluestore objectstore (default)
* ·  
  [--filestore] filestore objectstore
* ·  
  [--all] Activate all OSDs found in the system
* ·  
  [--no-systemd] Skip creating and enabling systemd units and starting of OSD
  services
  .UNINDENT

Multiple OSDs can be activated at once by using the (idempotent) **--all** flag:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm activate --all
    .ft P
.UNINDENT
.UNINDENT

**prepare**
Prepares a logical volume to be used as an OSD and journal using a **filestore**
or **bluestore** (default) setup. It will not create or modify the logical volumes
except for adding extra metadata.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm prepare --filestore --data <data lv> --journal <journal device>
    .ft P
.UNINDENT
.UNINDENT

Optional arguments:
.INDENT 0.0

* ·  
  [-h, --help]          show the help message and exit
* ·  
  [--journal JOURNAL]   A logical group name, path to a logical volume, or path to a device
* ·  
  [--bluestore]         Use the bluestore objectstore (default)
* ·  
  [--block.wal]         Path to a bluestore block.wal logical volume or partition
* ·  
  [--block.db]          Path to a bluestore block.db logical volume or partition
* ·  
  [--filestore]         Use the filestore objectstore
* ·  
  [--dmcrypt]           Enable encryption for the underlying OSD devices
* ·  
  [--osd-id OSD_ID]     Reuse an existing OSD id
* ·  
  [--osd-fsid OSD_FSID] Reuse an existing OSD fsid
* ·  
  [--crush-device-class] Define a CRUSH device class to assign the OSD to
  .UNINDENT

Required arguments:
.INDENT 0.0

* ·  
  .INDENT 2.0
* **--data**  
  A logical group name or a path to a logical volume
  .UNINDENT
  .UNINDENT

For encrypting an OSD, the **--dmcrypt** flag must be added when preparing
(also supported in the **create** sub-command).

**create**
Wraps the two-step process to provision a new osd (calling **prepare** first
and then **activate**) into a single one. The reason to prefer **prepare** and
then **activate** is to gradually introduce new OSDs into a cluster, and
avoiding large amounts of data being rebalanced.

The single-call process unifies exactly what **prepare** and **activate** do,
with the convenience of doing it all at once. Flags and general usage are
equivalent to those of the **prepare** and **activate** subcommand.

**trigger**
This subcommand is not meant to be used directly, and it is used by systemd so
that it proxies input to **ceph-volume lvm activate** by parsing the
input from systemd, detecting the UUID and ID associated with an OSD.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm trigger <SYSTEMD-DATA>
    .ft P
.UNINDENT
.UNINDENT

The systemd "data" is expected to be in the format of:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <OSD ID>-<OSD UUID>
    .ft P
.UNINDENT
.UNINDENT

The lvs associated with the OSD need to have been prepared previously,
so that all needed tags and metadata exist.

Positional arguments:
.INDENT 0.0

* ·  
  &lt;SYSTEMD_DATA&gt;  Data from a systemd unit containing ID and UUID of the OSD.
  .UNINDENT

**list**
List devices or logical volumes associated with Ceph. An association is
determined if a device has information relating to an OSD. This is
verified by querying LVM's metadata and correlating it with devices.

The lvs associated with the OSD need to have been prepared previously by
ceph-volume so that all needed tags and metadata exist.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm list
    .ft P
.UNINDENT
.UNINDENT

List a particular device, reporting all metadata about it:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm list /dev/sda1
    .ft P
.UNINDENT
.UNINDENT

List a logical volume, along with all its metadata (vg is a volume
group, and lv the logical volume name):
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm list {vg/lv}
    .ft P
.UNINDENT
.UNINDENT

Positional arguments:
.INDENT 0.0

* ·  
  &lt;DEVICE&gt;  Either in the form of **vg/lv** for logical volumes,
  **/path/to/sda1** or **/path/to/sda** for regular devices.
  .UNINDENT

**zap**
Zaps the given logical volume or partition. If given a path to a logical
volume it must be in the format of vg/lv. Any filesystems present
on the given lv or partition will be removed and all data will be purged.

However, the lv or partition will be kept intact.

Usage, for logical volumes:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm zap {vg/lv}
    .ft P
.UNINDENT
.UNINDENT

Usage, for logical partitions:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm zap /dev/sdc1
    .ft P
.UNINDENT
.UNINDENT

For full removal of the device use the **--destroy** flag (allowed for all
device types):
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm zap --destroy /dev/sdc1
    .ft P
.UNINDENT
.UNINDENT

Multiple devices can be removed by specifying the OSD ID and/or the OSD FSID:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume lvm zap --destroy --osd-id 1
    ceph-volume lvm zap --destroy --osd-id 1 --osd-fsid C9605912-8395-4D76-AFC0-7DFDAC315D59
    .ft P
.UNINDENT
.UNINDENT

Positional arguments:
.INDENT 0.0

* ·  
  &lt;DEVICE&gt;  Either in the form of **vg/lv** for logical volumes,
  **/path/to/sda1** or **/path/to/sda** for regular devices.
  .UNINDENT

<a name="simple"></a>

### simple


Scan legacy OSD directories or data devices that may have been created by
ceph-disk, or manually.

Subcommands:

**activate**
Enables a systemd unit that persists the OSD ID and its UUID (also called
**fsid** in Ceph CLI tools), so that at boot time it can understand what OSD is
enabled and needs to be mounted, while reading information that was previously
created and persisted at **/etc/ceph/osd/** in JSON format.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume simple activate --bluestore <osd id> <osd fsid>
    .ft P
.UNINDENT
.UNINDENT

Optional Arguments:
.INDENT 0.0

* ·  
  [-h, --help]  show the help message and exit
* ·  
  [--bluestore] bluestore objectstore (default)
* ·  
  [--filestore] filestore objectstore
  .UNINDENT

Note: It requires a matching JSON file with the following format:
.INDENT 0.0
.INDENT 3.5

    .ft C
    /etc/ceph/osd/<osd id>-<osd fsid>.json
    .ft P
.UNINDENT
.UNINDENT

**scan**
Scan a running OSD or data device for an OSD for metadata that can later be
used to activate and manage the OSD with ceph-volume. The scan method will
create a JSON file with the required information plus anything found in the OSD
directory as well.

Optionally, the JSON blob can be sent to stdout for further inspection.

Usage on all running OSDs:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-voume simple scan
    .ft P
.UNINDENT
.UNINDENT

Usage on data devices:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume simple scan <data device>
    .ft P
.UNINDENT
.UNINDENT

Running OSD directories:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume simple scan <path to osd dir>
    .ft P
.UNINDENT
.UNINDENT

Optional arguments:
.INDENT 0.0

* ·  
  [-h, --help]          show the help message and exit
* ·  
  [--stdout]            Send the JSON blob to stdout
* ·  
  [--force]             If the JSON file exists at destination, overwrite it
  .UNINDENT

Optional Positional arguments:
.INDENT 0.0

* ·  
  &lt;DATA DEVICE or OSD DIR&gt;  Actual data partition or a path to the running OSD
  .UNINDENT

**trigger**
This subcommand is not meant to be used directly, and it is used by systemd so
that it proxies input to **ceph-volume simple activate** by parsing the
input from systemd, detecting the UUID and ID associated with an OSD.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph-volume simple trigger <SYSTEMD-DATA>
    .ft P
.UNINDENT
.UNINDENT

The systemd "data" is expected to be in the format of:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <OSD ID>-<OSD UUID>
    .ft P
.UNINDENT
.UNINDENT

The JSON file associated with the OSD need to have been persisted previously by
a scan (or manually), so that all needed metadata can be used.

Positional arguments:
.INDENT 0.0

* ·  
  &lt;SYSTEMD_DATA&gt;  Data from a systemd unit containing ID and UUID of the OSD.
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph-volume** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the documentation at _http://docs.ceph.com/_ for more information.

<a name="see-also"></a>

# See Also


ceph-osd(8),

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

