# dmsetup(8)

Linux, Apr 06 2006


<a name="name"></a>

# Name

dmsetup — low level logical volume management

<a name="synopsis"></a>

# Synopsis


```
.HP 9 dmsetup .CMD_CLEAR .HP dmsetup .CMD_CREATE .HP dmsetup .CMD_CREATE_CONCISE .HP dmsetup .CMD_DEPS .HP dmsetup .CMD_HELP .HP dmsetup .CMD_INFO .HP dmsetup .CMD_INFOLONG .HP dmsetup .CMD_LOAD .HP dmsetup .CMD_LS .HP dmsetup .CMD_MANGLE .HP dmsetup .CMD_MESSAGE .HP dmsetup .CMD_MKNODES .HP dmsetup .CMD_RELOAD .HP dmsetup .CMD_REMOVE .HP dmsetup .CMD_REMOVE_ALL .HP dmsetup .CMD_RENAME .HP dmsetup .CMD_RENAME_UUID .HP dmsetup .CMD_RESUME .HP dmsetup .CMD_SETGEOMETRY .HP dmsetup .CMD_SPLITNAME .HP dmsetup .CMD_STATS .HP dmsetup .CMD_STATUS .HP dmsetup .CMD_SUSPEND .HP dmsetup .CMD_TABLE .HP dmsetup .CMD_TARGETS .HP dmsetup .CMD_UDEVCOMPLETE .HP dmsetup .CMD_UDEVCOMPLETE_ALL .HP dmsetup .CMD_UDEVCOOKIES .HP dmsetup .CMD_UDEVCREATECOOKIE .HP dmsetup .CMD_UDEVFLAGS .HP dmsetup .CMD_UDEVRELEASECOOKIE .HP dmsetup .CMD_VERSION .HP dmsetup .CMD_WAIT .HP dmsetup .CMD_WIPE_TABLE 
 .HP devmap_name major minor .HP devmap_name major:minor
```

<a name="description"></a>

# Description

dmsetup manages logical devices that use the device-mapper driver.
Devices are created by loading a table that specifies a target for
each sector (512 bytes) in the logical device.

The first argument to dmsetup is a command.
The second argument is the logical device name or uuid.

Invoking the dmsetup tool as **devmap\_name**
(which is not normally distributed and is supported
only for historical reasons) is equivalent to
**dmsetup&nbsp;info&nbsp;-c&nbsp;--noheadings&nbsp;-j**_&nbsp;major&nbsp;_**-m**_&nbsp;minor_**\c**
.


<a name="options"></a>

# Options

.HP
**--addnodeoncreate**  
Ensure _/dev/mapper_ node exists after **dmsetup create**.
.HP
**--addnodeonresume**  
Ensure _/dev/mapper_ node exists after **dmsetup resume** (default with udev).
.HP
**--checks**  
Perform additional checks on the operations requested and report
potential problems.  Useful when debugging scripts.
In some cases these checks may slow down operations noticeably.
.HP
**-c**|**-C**|**--columns**  
Display output in columns rather than as Field: Value lines.
.HP
**--count**
_count_  
Specify the number of times to repeat a report. Set this to zero
continue until interrupted.  The default interval is one second.
.HP
**-f**|**--force**  
Try harder to complete operation.
.HP
**-h**|**--help**  
Outputs a summary of the commands available, optionally including
the list of report fields (synonym with **help** command).
.HP
**--inactive**  
When returning any table information from the kernel report on the
inactive table instead of the live table.
Requires kernel driver version 4.16.0 or above.
.HP
**--interval**
_seconds_  
Specify the interval in seconds between successive iterations for
repeating reports. If **--interval** is specified but **--count**
is not, reports will continue to repeat until interrupted.
The default interval is one second.
.HP
**--manglename**
**auto**|**hex**|**none**  
Mangle any character not on a whitelist using mangling_mode when
processing device-mapper device names and UUIDs. The names and UUIDs
are mangled on input and unmangled on output where the mangling mode
is one of:
**auto** (only do the mangling if not mangled yet, do nothing
if already mangled, error on mixed),
**hex** (always do the mangling) and
**none** (no mangling).
Default mode is **auto**.
Character whitelist: 0-9, A-Z, a-z, #+-.:=@_. This whitelist is
also supported by udev. Any character not on a whitelist is replaced
with its hex value (two digits) prefixed by \\x.
Mangling mode could be also set through
**DM\_DEFAULT\_NAME\_MANGLING\_MODE**
environment variable.
.HP
**-j**|**--major**
_major_  
Specify the major number.
.HP
**-m**|**--minor**
_minor_  
Specify the minor number.
.HP
**-n**|**--notable**  
When creating a device, don't load any table.
.HP
**--nameprefixes**  
Add a "DM_" prefix plus the field name to the output.  Useful with
**--noheadings** to produce a list of
field=value pairs that can be used to set environment variables
(for example, in
**udev**(7)
rules).
.HP
**--noheadings**
Suppress the headings line when using columnar output.
.HP
**--noflush**
Do not flush outstading I/O when suspending a device, or do not
commit thin-pool metadata when obtaining thin-pool status.
.HP
**--nolockfs**  
Do not attempt to synchronize filesystem eg, when suspending a device.
.HP
**--noopencount**  
Tell the kernel not to supply the open reference count for the device.
.HP
**--noudevrules**  
Do not allow udev to manage nodes for devices in device-mapper directory.
.HP
**--noudevsync**  
Do not synchronise with udev when creating, renaming or removing devices.
.HP
**-o**|**--options**
_options_  
Specify which fields to display.
.HP
**--readahead**
[**+**]**sectors**|**auto**|**none**  
Specify read ahead size in units of sectors.
The default value is **auto** which allows the kernel to choose
a suitable value automatically.  The **+** prefix lets you
specify a minimum value which will not be used if it is
smaller than the value chosen by the kernel.
The value **none** is equivalent to specifying zero.
.HP
**-r**|**--readonly**  
Set the table being loaded read-only.
.HP
**-S**|**--select**
_selection_  
Process only items that match _selection_ criteria.  If the command is
producing report output, adding the "selected" column (-o
selected) displays all rows and shows 1 if the row matches the
_selection_ and 0 otherwise. The selection criteria are defined by
specifying column names and their valid values while making use of supported
comparison operators. As a quick help and to see full list of column names that
can be used in selection and the set of supported selection operators, check
the output of **dmsetup&nbsp;info&nbsp;-c&nbsp;-S&nbsp;help** command.
.HP
**--table**
_table_  
Specify a one-line table directly on the command line.
See below for more information on the table format.
.HP
**--udevcookie**
_cookie_  
Use cookie for udev synchronisation.
Note: Same cookie should be used for same type of operations i.e. creation of
multiple different devices. It's not adviced to combine different
operations on the single device.
.HP
**-u**|**--uuid**  
Specify the _uuid_.
.HP
**-y**|**--yes**  
Answer yes to all prompts automatically.
.HP
**-v**|**--verbose**
[**-v**|**--verbose**]  
Produce additional output.
.HP
**--verifyudev**  
If udev synchronisation is enabled, verify that udev operations get performed
correctly and try to fix up the device nodes afterwards if not.
.HP
**--version**  
Display the library and kernel driver version.  

<a name="commands"></a>

# Commands

.HP
.CMD_CLEAR  
Destroys the table in the inactive table slot for device_name.
.HP
.CMD_CREATE  
Creates a device with the given name.
If _table_ or _table\_file_ is supplied, the table is loaded and made live.
Otherwise a table is read from standard input unless **--notable** is used.
The optional _uuid_ can be used in place of
device_name in subsequent dmsetup commands.
If successful the device will appear in table and for live
device the node _/dev/mapper/device\_name_ is created.
See below for more information on the table format.
.HP
.CMD_CREATE_CONCISE  
Creates one or more devices from a concise device specification.
Each device is specified by a comma-separated list: name, uuid, minor number, flags, comma-separated table lines.
Flags defaults to read-write (rw) or may be read-only (ro).
Uuid, minor number and flags are optional so those fields may be empty.
A semi-colon separates specifications of different devices.
Use a backslash to escape the following character, for example a comma or semi-colon in a name or table. See also CONCISE FORMAT below.
.HP
.CMD_DEPS  
Outputs a list of devices referenced by the live table for the specified
device. Device names on output can be customised by following _options_:
**devno** (major and minor pair, used by default),
**blkdevname** (block device name),
**devname** (map name for device-mapper devices, equal to blkdevname otherwise).
.HP
.CMD_HELP  
Outputs a summary of the commands available, optionally including
the list of report fields.
.HP
.CMD_INFO  
Outputs some brief information about the device in the form:
 State: SUSPENDED|ACTIVE, READ-ONLY
 Tables present: LIVE and/or INACTIVE
 Open reference count
 Last event sequence number (used by **wait**)
 Major and minor device number
 Number of targets in the live table
 UUID
.HP
.CMD_INFOLONG  
Output you can customise.
Fields are comma-separated and chosen from the following list:
**name**,
**major**,
**minor**,
**attr**,
**open**,
**segments**,
**events**,
**uuid**.
Attributes are:
(_L_)ive,
(_I_)nactive,
(_s_)uspended,
(_r_)ead-only,
read-(_w_)rite.
Precede the list with '**+**' to append
to the default selection of columns instead of replacing it.
Precede any sort field with '**-**' for a reverse sort on that column.
.HP
.CMD_LS  
List device names.  Optionally only list devices that have at least
one target of the specified type.  Optionally execute a command for
each device.  The device name is appended to the supplied command.
Device names on output can be customised by following options:
**devno** (major and minor pair, used by default),
**blkdevname** (block device name),
**devname** (map name for device-mapper devices, equal to blkdevname otherwise).
**--tree** displays dependencies between devices as a tree.
It accepts a comma-separate list of _options_.
Some specify the information displayed against each node:
**device**/**nodevice**;
**blkdevname**;
**active**, **open**, **rw**, **uuid**.
Others specify how the tree is displayed:
**ascii**, **utf**, **vt100**;
**compact**, **inverted**, **notrunc**.
.HP
**load**|**\c**
.CMD_RELOAD  
Loads _table_ or _table\_file_ into the inactive table slot for device_name.
If neither is supplied, reads a table from standard input.
.HP
.CMD_MANGLE  
Ensure existing device-mapper _device\_name_ and UUID is in the correct mangled
form containing only whitelisted characters (supported by udev) and do
a rename if necessary. Any character not on the whitelist will be mangled
based on the **--manglename** setting. Automatic rename works only for device
names and not for device UUIDs because the kernel does not allow changing
the UUID of active devices. Any incorrect UUIDs are reported only and they
must be manually corrected by deactivating the device first and then
reactivating it with proper mangling mode used (see also **--manglename**).
.HP
.CMD_MESSAGE  
Send message to target. If sector not needed use 0.
.HP
.CMD_MKNODES  
Ensure that the node in _/dev/mapper_ for _device\_name_ is correct.
If no device_name is supplied, ensure that all nodes in _/dev/mapper_
correspond to mapped devices currently loaded by the device-mapper kernel
driver, adding, changing or removing nodes as necessary.
.HP
.CMD_REMOVE  
Removes a device.  It will no longer be visible to dmsetup.  Open devices
cannot be removed, but adding **--force** will replace the table with one
that fails all I/O.  **--deferred** will enable deferred removal of open
devices - the device will be removed when the last user closes it. The deferred
removal feature is supported since version 4.27.0 of the device-mapper
driver available in upstream kernel version 3.13.  (Use **dmsetup version**
to check this.)  If an attempt to remove a device fails, perhaps because a process run
from a quick udev rule temporarily opened the device, the **--retry**
option will cause the operation to be retried for a few seconds before failing.
Do NOT combine
**--force** and **--udevcookie**, as udev may start to process udev
rules in the middle of error target replacement and result in nondeterministic
result.
.HP
.CMD_REMOVE_ALL  
Attempts to remove all device definitions i.e. reset the driver.  This also runs
**mknodes** afterwards.  Use with care!  Open devices cannot be removed, but
adding **--force** will replace the table with one that fails all I/O.
**--deferred** will enable deferred removal of open devices - the device
will be removed when the last user closes it.  The deferred removal feature is
supported since version 4.27.0 of the device-mapper driver available in
upstream kernel version 3.13.
.HP
.CMD_RENAME  
Renames a device.
.HP
.CMD_RENAME_UUID  
Sets the uuid of a device that was created without a uuid.
After a uuid has been set it cannot be changed.
.HP
.CMD_RESUME  
Un-suspends a device.
If an inactive table has been loaded, it becomes live.
Postponed I/O then gets re-queued for processing.
.HP
.CMD_SETGEOMETRY  
Sets the device geometry to C/H/S.
.HP
.CMD_SPLITNAME  
Splits given _device name_ into _subsystem_ constituents.
The default subsystem is LVM.
LVM currently generates device names by concatenating the names of the Volume
Group, Logical Volume and any internal Layer with a hyphen as separator.
Any hyphens within the names are doubled to escape them.
The precise encoding might change without notice in any future
release, so we recommend you always decode using the current version of
this command.
.HP
.CMD_STATS  
Manages IO statistics regions for devices.
See
**dmstats**(8)
for more details.
.HP
.CMD_STATUS  
Outputs status information for each of the device's targets.
With **--target**, only information relating to the specified target type
any is displayed.  With **--noflush**, the thin target (from version 1.3.0)
doesn't commit any outstanding changes to disk before reporting its statistics.

.HP
.CMD_SUSPEND  
Suspends a device.  Any I/O that has already been mapped by the device
but has not yet completed will be flushed.  Any further I/O to that
device will be postponed for as long as the device is suspended.
If there's a filesystem on the device which supports the operation,
an attempt will be made to sync it first unless **--nolockfs** is specified.
Some targets such as recent (October 2006) versions of multipath may support
the **--noflush** option.  This lets outstanding I/O that has not yet reached the
device to remain unflushed.
.HP
.CMD_TABLE  
Outputs the current table for the device in a format that can be fed
back in using the create or load commands.
With **--target**, only information relating to the specified target type
is displayed.
Real encryption keys are suppressed in the table output for crypt and integrity
targets unless the **--showkeys** parameter is supplied. Kernel key
references prefixed with **:** are not affected by the parameter and get
displayed always (crypt target only).
With **--concise**, the output is presented concisely on a single line.
Commas then separate the name, uuid, minor device number, flags ('ro' or 'rw')
and the table (if present). Semi-colons separate devices. Backslashes escape
any commas, semi-colons or backslashes.  See CONCISE FORMAT below.
.HP
.CMD_TARGETS  
Displays the names and versions of the currently-loaded targets.
.HP
.CMD_UDEVCOMPLETE  
Wake any processes that are waiting for udev to complete processing the specified cookie.
.HP
.CMD_UDEVCOMPLETE_ALL  
Remove all cookies older than the specified number of minutes.
Any process waiting on a cookie will be resumed immediately.
.HP
.CMD_UDEVCOOKIES  
List all existing cookies. Cookies are system-wide semaphores with keys
prefixed by two predefined bytes (0x0D4D).
.HP
.CMD_UDEVCREATECOOKIE  
Creates a new cookie to synchronize actions with udev processing.
The output is a cookie value. Normally we don't need to create cookies since
dmsetup creates and destroys them for each action automatically. However, we can
generate one explicitly to group several actions together and use only one
cookie instead. We can define a cookie to use for each relevant command by using
**--udevcookie** option. Alternatively, we can export this value into the environment
of the dmsetup process as **DM\_UDEV\_COOKIE** variable and it will be used automatically
with all subsequent commands until it is unset.
Invoking this command will create system-wide semaphore that needs to be cleaned
up explicitly by calling udevreleasecookie command.
.HP
.CMD_UDEVFLAGS  
Parses given _cookie_ value and extracts any udev control flags encoded.
The output is in environment key format that is suitable for use in udev
rules. If the flag has its symbolic name assigned then the output is
DM_UDEV_FLAG_&lt;flag_name&gt; = '1', DM_UDEV_FLAG&lt;flag_position&gt; = '1' otherwise.
Subsystem udev flags don't have symbolic names assigned and these ones are
always reported as DM_SUBSYSTEM_UDEV_FLAG&lt;flag_position&gt; = '1'. There are
16 udev flags altogether.
.HP
.CMD_UDEVRELEASECOOKIE  
Waits for all pending udev processing bound to given cookie value and clean up
the cookie with underlying semaphore. If the cookie is not given directly,
the command will try to use a value defined by **DM\_UDEV\_COOKIE** environment variable.
.HP
.CMD_VERSION  
Outputs version information.
.HP
.CMD_WAIT  
Sleeps until the event counter for device_name exceeds event_nr.
Use **-v** to see the event number returned.
To wait until the next event is triggered, use **info** to find
the last event number.
With **--noflush**, the thin target (from version 1.3.0) doesn't commit
any outstanding changes to disk before reporting its statistics.
.HP
.CMD_WIPE_TABLE  
Wait for any I/O in-flight through the device to complete, then
replace the table with a new table that fails any new I/O
sent to the device.  If successful, this should release any devices
held open by the device's table(s).

<a name="table-format"></a>

# Table Format

Each line of the table specifies a single target and is of the form:

_logical_start_sector num_sectors_
**target_type**
_target_args_

Simple target types and target args include:

* **linear destination_device start_sector**  
  The traditional linear mapping.
* **striped _num_stripes chunk_size _[_destination start\_sector_]...**  
  Creates a striped area.  
  e.g. striped 2 32 /dev/hda1 0 /dev/hdb1 0
  will map the first chunk (16k) as follows:
           LV chunk 1-&gt; hda1, chunk 1
           LV chunk 2-&gt; hdb1, chunk 1
           LV chunk 3-&gt; hda1, chunk 2
           LV chunk 4-&gt; hdb1, chunk 2
           etc.
* **error**  
  Errors any I/O that goes to this area.  Useful for testing or
  for creating devices with holes in them.
* **zero**  
  Returns blocks of zeroes on reads.  Any data written is discarded silently.
  This is a block-device equivalent of the _/dev/zero_
  character-device data sink described in **null**(4).

More complex targets include:

* **cache**  
  Improves performance of a block device (eg, a spindle) by dynamically
  migrating some of its data to a faster smaller device (eg, an SSD).
* **crypt**  
  Transparent encryption of block devices using the kernel crypto API.
* **delay**  
  Delays reads and/or writes to different devices.  Useful for testing.
* **flakey**  
  Creates a similar mapping to the linear target but
  exhibits unreliable behaviour periodically.
  Useful for simulating failing devices when testing.
* **mirror**  
  Mirrors data across two or more devices.
* **multipath**  
  Mediates access through multiple paths to the same device.
* **raid**  
  Offers an interface to the kernel's software raid driver, md.
* **snapshot**  
  Supports snapshots of devices.
* **thin**, **thin-pool**  
  Supports thin provisioning of devices and also provides a better snapshot support.

To find out more about the various targets and their table formats and status
lines, please read the files in the Documentation/device-mapper directory in
the kernel source tree.
(Your distribution might include a copy of this information in the
documentation directory for the device-mapper package.)

<a name="examples"></a>

# Examples

# A table to join two disks together  
0 1028160 linear /dev/hda 0  
1028160 3903762 linear /dev/hdb 0  
# A table to stripe across the two disks,  
# and add the spare space from  
# hdb to the back of the volume  
0 2056320 striped 2 32 /dev/hda 0 /dev/hdb 0  
2056320 2875602 linear /dev/hdb 1028160

<a name="concise-format"></a>

# Concise Format

A concise representation of one of more devices.
  
- A comma separates the fields of each device.  
- A semi-colon separates devices.

* The representation of a device takes the form:  

&lt;name&gt;,&lt;uuid&gt;,&lt;minor&gt;,&lt;flags&gt;,&lt;table&gt;[,&lt;table&gt;+][;&lt;dev_name&gt;,&lt;uuid&gt;,&lt;minor&gt;,&lt;flags&gt;,&lt;table&gt;[,&lt;table&gt;+]]

* The fields are:  
* **name**  
  The name of the device.
* **uuid**  
  The UUID of the device (or empty).
* **minor**  
  The minor number of the device.  If empty, the kernel assigns a suitable minor number.
* **flags**  
  Supported flags are:

**ro**
Sets the table being loaded for the device read-only  
**rw**
Sets the table being loaded for the device read-write (default)

* **table**  
  One line of the table. See TABLE FORMAT above.

<a name="examples"></a>

# Examples

# A simple linear read-only device  
test-linear-small,,,ro,0 2097152 linear /dev/loop0 0, 2097152 2097152 linear /dev/loop1 0  

# Two linear devices  
test-linear-small,,,,0 2097152 linear /dev/loop0 0;test-linear-large,,,, 0 2097152 linear /dev/loop1 0, 2097152 2097152 linear /dev/loop2 0  

<a name="environment-variables"></a>

# Environment Variables


* **DM_DEV_DIR**  
  The device directory name.
  Defaults to "_/dev_" and must be an absolute path.
* **DM_UDEV_COOKIE**  
  A cookie to use for all relevant commands to synchronize with udev processing.
  It is an alternative to using **--udevcookie** option.
* **DM_DEFAULT_NAME_MANGLING_MODE**  
  A default mangling mode. Defaults to "**auto**"
  and it is an alternative to using **--manglename** option.

<a name="authors"></a>

# Authors

Original version: Joe Thornber &lt;[thornber@redhat.com](mailto:thornber@redhat.com)&gt;

<a name="see-also"></a>

# See Also

**dmstats**(8),
**udev**(7),
**udevadm**(8)

LVM2 resource page: https://www.sourceware.org/lvm2/  
Device-mapper resource page: http://sources.redhat.com/dm/
