# vgexport(8) - Unregister volume group(s) from the system

Red Hat, Inc., LVM TOOLS 2.02.183(2) (2018-12-07)


<a name="synopsis"></a>

# Synopsis

```
vgexport option_args position_args
[ option_args ]

```

<a name="description"></a>

# Description

vgexport changes a VG into the exported state, which ensures that the VG
and its disks are not being used, and cannot be used until the VG is
imported by **vgimport**(8).  Putting a VG into an unusable, offline
state can be useful when doing things like moving a VG's disks to another
system.  Exporting a VG provides some protection from its LVs being
accidentally used, or being used by an automated system before it's ready.

A VG cannot be exported until all of its LVs are inactive.

LVM commands will ignore an exported VG or report an error if a command
tries to use it.

For an exported VG, the vgs command will display 
attribute, and the pvs command will display 
attribute.  Both vgs and pvs will display 
report field.

vgexport clears the VG system ID, and vgimport sets the VG system ID to
match the host running vgimport (if the host has a system ID).

<a name="usage"></a>

# Usage

Export specified VGs.  

**vgexport** _VG_|_Tag_|_Select_ ...  
[ **-S**|**--select** _String_ ]  
[ COMMON_OPTIONS ]  

Export all VGs.  

**vgexport** **-a**|**--all**  
[ COMMON_OPTIONS ]  

Common options for command:
[    **--reportformat** **basic**|**json** ]

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
**-a**|**--all**  
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
**--reportformat** **basic**|**json**  
Overrides current output format for reports which is defined globally by
the report/output_format setting in lvm.conf.
**basic** is the original format with columns and rows.
If there is more than one report per command, each report is prefixed
with the report name for identification. **json** produces report
output in JSON format. See **lvmreport**(7) for more information.
.HP
**-S**|**--select** _String_  
Select objects for processing and reporting based on specified criteria.
The criteria syntax is described by **--select help** and **lvmreport**(7).
For reporting commands, one row is displayed for each object matching the criteria.
See **--options help** for selectable object fields.
Rows can be displayed with an additional "selected" field (-o selected)
showing 1 if the row matches the selection and 0 otherwise.
For non-reporting commands which process LVM entities, the selection is
used to choose items to process.
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
_VG_  
Volume Group name.  See **lvm**(8) for valid names.
.HP
_Tag_  
Tag name.  See **lvm**(8) for information about tag names and using tags
in place of a VG, LV or PV.
.HP
_Select_  
Select indicates that a required positional parameter can
be omitted if the **--select** option is used.
No arg appears in this position.
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
