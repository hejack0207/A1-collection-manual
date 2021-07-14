# vgimportclone(8) - Import a VG from cloned PVs

Red Hat, Inc., LVM TOOLS 2.02.183(2) (2018-12-07)


<a name="synopsis"></a>

# Synopsis

```
vgimportclone position_args
[ option_args ]

```

<a name="description"></a>

# Description

vgimportclone imports a VG from duplicated PVs, e.g. created by a hardware
snapshot of existing PVs.

A duplicated VG cannot used until it is made to coexist with the original
VG. vgimportclone renames the VG associated with the specified PVs and
changes the associated VG and PV UUIDs.

<a name="usage"></a>

# Usage

**vgimportclone** _PV_ ...  
[ **-n**|**--basevgname** _VG_ ]  
[ **-i**|**--import** ]  
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
**-n**|**--basevgname** _String_  
By default the snapshot VG will be renamed to the original name plus a
numeric suffix to avoid duplicate naming (e.g. 'test_vg' would be renamed
to 'test_vg1'). This option will override the base VG name that is
used for all VG renames. If a VG already exists with the specified name
a numeric suffix will be added (like the previous example) to make it unique.
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
**-d**|**--debug** ...  
Set debug level. Repeat from 1 to 6 times to increase the detail of
messages sent to the log file and/or syslog (if configured).
.HP
**--driverloaded** **y**|**n**  
If set to no, the command will not attempt to use device-mapper.
For testing and debugging.
.HP
**-h**|**--help**  
Display help text.
.HP
**-i**|**--import**  
Import exported VGs. Otherwise VGs that have been exported
will not be changed (nor will their associated PVs).
.HP
**--lockopt** _String_  
Used to pass options for special cases to lvmlockd.
See **lvmlockd**(8) for more information.
.HP
**--longhelp**  
Display long help text.
.HP
**--profile** _String_  
An alias for --commandprofile or --metadataprofile, depending
on the command.
.HP
**-q**|**--quiet** ...  
Suppress output and log messages. Overrides --debug and --verbose.
Repeat once to also suppress any prompts with answer 'no'.
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

<a name="variables"></a>

# Variables

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


An original VG "vg00" has PVs "/dev/sda" and "/dev/sdb".
The corresponding PVs from a hardware snapshot are "/dev/sdc" and "/dev/sdd".
Rename the VG associated with "/dev/sdc" and "/dev/sdd" from "vg00" to "vg00_snap"
(and change associated UUIDs).  
**vgimportclone --basevgname vg00_snap /dev/sdc /dev/sdd**

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
