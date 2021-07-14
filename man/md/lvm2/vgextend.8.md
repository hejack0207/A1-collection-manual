# vgextend(8) - Add physical volumes to a volume group

Red Hat, Inc., LVM TOOLS 2.02.183(2) (2018-12-07)


<a name="synopsis"></a>

# Synopsis

```
vgextend position_args
[ option_args ]

```

<a name="description"></a>

# Description

vgextend adds one or more PVs to a VG. This increases the space available
for LVs in the VG.

Also, PVs that have gone missing and then returned, e.g. due to a
transient device failure, can be added back to the VG without
re-initializing them (see --restoremissing).

If the specified PVs have not yet been initialized with pvcreate, vgextend
will initialize them. In this case pvcreate options can be used, e.g.
--labelsector, --metadatasize, --metadataignore,
--pvmetadatacopies, --dataalignment, --dataalignmentoffset.

<a name="usage"></a>

# Usage

**vgextend** _VG_ _PV_ ...  
[ **-A**|**--autobackup** **y**|**n** ]  
[ **-f**|**--force** ]  
[ **-Z**|**--zero** **y**|**n** ]  
[ **-M**|**--metadatatype** **lvm2** ]  
[    **--labelsector** _Number_ ]  
[    **--metadatasize** _Size_[m|UNIT] ]  
[    **--pvmetadatacopies** **0**|**1**|**2** ]  
[    **--metadataignore** **y**|**n** ]  
[    **--dataalignment** _Size_[k|UNIT] ]  
[    **--dataalignmentoffset** _Size_[k|UNIT] ]  
[    **--reportformat** **basic**|**json** ]  
[    **--restoremissing** ]  
[ COMMON_OPTIONS ]  

Common options for lvm:
[ **-d**|**--debug** ]  
[ **-h**|**--help** ]  
[ **-q**|**--quiet** ]  
[ **-t**|**--test** ]  
[ **-v**|**--verbose** ]  
[ **-y**|**--yes** ]  
[    **--commandprofile** _String_ ]  
[    **--config** _String_ ]  
[    **--driverloaded** **y**|**n** ]  
[    **--lockopt** _String_ ]  
[    **--longhelp** ]  
[    **--profile** _String_ ]  
[    **--version** ]

<a name="options"></a>

# Options

.HP
**-A**|**--autobackup** **y**|**n**  
Specifies if metadata should be backed up automatically after a change.
Enabling this is strongly advised! See **vgcfgbackup**(8) for more information.
.HP
**--commandprofile** _String_  
The command profile to use for command configuration.
See **lvm.conf**(5) for more information about profiles.
.HP
**--config** _String_  
Config settings for the command. These override lvm.conf settings.
The String arg uses the same format as lvm.conf,
or may use section/field syntax.
See **lvm.conf**(5) for more information about config.
.HP
**--dataalignment** _Size_[k|UNIT]  
Align the start of the data to a multiple of this number.
Also specify an appropriate Physical Extent size when creating a VG.
To see the location of the first Physical Extent of an existing PV,
use pvs -o +pe_start. In addition, it may be shifted by an alignment offset.
See lvm.conf/data_alignment_offset_detection and --dataalignmentoffset.
.HP
**--dataalignmentoffset** _Size_[k|UNIT]  
Shift the start of the data area by this additional offset.
.HP
**-d**|**--debug** ...  
Set debug level. Repeat from 1 to 6 times to increase the detail of
messages sent to the log file and/or syslog (if configured).
.HP
**--driverloaded** **y**|**n**  
If set to no, the command will not attempt to use device-mapper.
For testing and debugging.
.HP
**-f**|**--force** ...  
Override various checks, confirmations and protections.
Use with extreme caution.
.HP
**-h**|**--help**  
Display help text.
.HP
**--labelsector** _Number_  
By default the PV is labelled with an LVM2 identifier in its second
sector (sector 1). This lets you use a different sector near the
start of the disk (between 0 and 3 inclusive - see LABEL_SCAN_SECTORS
in the source). Use with care.
.HP
**--lockopt** _String_  
Used to pass options for special cases to lvmlockd.
See **lvmlockd**(8) for more information.
.HP
**--longhelp**  
Display long help text.
.HP
**--metadataignore** **y**|**n**  
Specifies the metadataignore property of a PV.
If yes, metadata areas on the PV are ignored, and lvm will
not store metadata in the metadata areas of the PV.
If no, lvm will store metadata on the PV.
.HP
**--metadatasize** _Size_[m|UNIT]  
The approximate amount of space used for each VG metadata area.
The size may be rounded.
.HP
**-M**|**--metadatatype** **lvm2**  
Specifies the type of on-disk metadata to use.
**lvm2** (or just **2**) is the current, standard format.
**lvm1** (or just **1**) is no longer used.
.HP
**--profile** _String_  
An alias for --commandprofile or --metadataprofile, depending
on the command.
.HP
**--pvmetadatacopies** **0**|**1**|**2**  
The number of metadata areas to set aside on a PV for storing VG metadata.
When 2, one copy of the VG metadata is stored at the front of the PV
and a second copy is stored at the end.
When 1, one copy of the VG metadata is stored at the front of the PV
(starting in the 5th sector).
When 0, no copies of the VG metadata are stored on the given PV.
This may be useful in VGs containing many PVs (this places limitations
on the ability to use vgsplit later.)
.HP
**-q**|**--quiet** ...  
Suppress output and log messages. Overrides --debug and --verbose.
Repeat once to also suppress any prompts with answer 'no'.
.HP
**--reportformat** **basic**|**json**  
Overrides current output format for reports which is defined globally by
the report/output_format setting in lvm.conf.
**basic** is the original format with columns and rows.
If there is more than one report per command, each report is prefixed
with the report name for identification. **json** produces report
output in JSON format. See **lvmreport**(7) for more information.
.HP
**--restoremissing**  
Add a PV back into a VG after the PV was missing and then returned,
e.g. due to a transient failure. The PV is not reinitialized.
.HP
**-t**|**--test**  
Run in test mode. Commands will not update metadata.
This is implemented by disabling all metadata writing but nevertheless
returning success to the calling function. This may lead to unusual
error messages in multi-stage operations if a tool relies on reading
back metadata it believes has changed but hasn't.
.HP
**-v**|**--verbose** ...  
Set verbose level. Repeat from 1 to 4 times to increase the detail
of messages sent to stdout and stderr.
.HP
**--version**  
Display version information.
.HP
**-y**|**--yes**  
Do not prompt for confirmation interactively but always assume the
answer yes. Use with extreme caution.
(For automatic no, see -qq.)
.HP
**-Z**|**--zero** **y**|**n**  
Controls if the first 4 sectors (2048 bytes) of the device are wiped.
The default is to wipe these sectors unless either or both of
--restorefile or --uuid are specified.

<a name="variables"></a>

# Variables

.HP
_VG_  
Volume Group name.  See **lvm**(8) for valid names.
.HP
_PV_  
Physical Volume name, a device path under /dev.
For commands managing physical extents, a PV positional arg
generally accepts a suffix indicating a range (or multiple ranges)
of physical extents (PEs). When the first PE is omitted, it defaults
to the start of the device, and when the last PE is omitted it defaults to end.
Start and end range (inclusive): _PV_[**:**_PE_**-**_PE_]...
Start and length range (counting from 0): _PV_[**:**_PE_**+**_PE_]...
.HP
_String_  
See the option description for information about the string content.
.HP
_Size_[UNIT]  
Size is an input number that accepts an optional unit.
Input units are always treated as base two values, regardless of
capitalization, e.g. 'k' and 'K' both refer to 1024.
The default input unit is specified by letter, followed by |UNIT.
UNIT represents other possible input units: **bBsSkKmMgGtTpPeE**.
b|B is bytes, s|S is sectors of 512 bytes, k|K is kilobytes,
m|M is megabytes, g|G is gigabytes, t|T is terabytes,
p|P is petabytes, e|E is exabytes.
(This should not be confused with the output control --units, where
capital letters mean multiple of 1000.)

<a name="environment-variables"></a>

# Environment Variables

See **lvm**(8) for information about environment variables used by lvm.
For example, LVM_VG_NAME can generally be substituted for a required VG parameter.

<a name="examples"></a>

# Examples


Add two PVs to a VG.  
**vgextend vg00 /dev/sda4 /dev/sdn1**

<a name="see-also"></a>

# See Also


**lvm**(8)
**lvm.conf**(5)
**lvmconfig**(8)

**pvchange**(8)
**pvck**(8)
**pvcreate**(8)
**pvdisplay**(8)
**pvmove**(8)
**pvremove**(8)
**pvresize**(8)
**pvs**(8)
**pvscan**(8)

**vgcfgbackup**(8)
**vgcfgrestore**(8)
**vgchange**(8)
**vgck**(8)
**vgcreate**(8)
**vgconvert**(8)
**vgdisplay**(8)
**vgexport**(8)
**vgextend**(8)
**vgimport**(8)
**vgimportclone**(8)
**vgmerge**(8)
**vgmknodes**(8)
**vgreduce**(8)
**vgremove**(8)
**vgrename**(8)
**vgs**(8)
**vgscan**(8)
**vgsplit**(8)

**lvcreate**(8)
**lvchange**(8)
**lvconvert**(8)
**lvdisplay**(8)
**lvextend**(8)
**lvreduce**(8)
**lvremove**(8)
**lvrename**(8)
**lvresize**(8)
**lvs**(8)
**lvscan**(8)

**lvm-fullreport**(8)
**lvm-lvpoll**(8)
**lvm2-activation-generator**(8)
**blkdeactivate**(8)
**lvmdump**(8)

**dmeventd**(8)
**lvmetad**(8)
**lvmpolld**(8)
**lvmlockd**(8)
**lvmlockctl**(8)
**clvmd**(8)
**cmirrord**(8)
**lvmdbusd**(8)

**lvmsystemid**(7)
**lvmreport**(7)
**lvmraid**(7)
**lvmthin**(7)
**lvmcache**(7)
