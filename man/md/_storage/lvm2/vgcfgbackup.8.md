# vgcfgbackup(8) - Backup volume group configuration(s)

Red Hat, Inc., LVM TOOLS 2.02.183(2) (2018-12-07)


<a name="synopsis"></a>

# Synopsis

```
vgcfgbackup
[ option_args ]
[ position_args ]

```

<a name="description"></a>

# Description

vgcfgbackup creates back up files containing metadata of VGs.
If no VGs are named, back up files are created for all VGs.
See **vgcfgrestore** for information on using the back up
files.

In a default installation, each VG is backed up into a separate file
bearing the name of the VG in the directory _/etc/lvm/backup_.

To use an alternative back up file, use **-f**. In this case, when
backing up multiple VGs, the file name is treated as a template, with %s
replaced by the VG name.

NB. This DOES NOT back up the data content of LVs.

It may also be useful to regularly back up the files in
_/etc/lvm_.

<a name="usage"></a>

# Usage

**vgcfgbackup**  
[ **-f**|**--file** _String_ ]  
[    **--foreign** ]  
[    **--ignorelockingfailure** ]  
[    **--readonly** ]  
[    **--reportformat** **basic**|**json** ]  
[ COMMON_OPTIONS ]  
[ _VG_ ... ]

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
**-f**|**--file** _String_  
Write the backup to the named file.
When backing up more than one VG, the file name is
treated as a template, and %s is replaced by the VG name.
.HP
**--foreign**  
Report/display foreign VGs that would otherwise be skipped.
See **lvmsystemid**(7) for more information about foreign VGs.
.HP
**-h**|**--help**  
Display help text.
.HP
**--ignorelockingfailure**  
Allows a command to continue with read-only metadata
operations after locking failures.
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
**--readonly**  
Run the command in a special read-only mode which will read on-disk
metadata without needing to take any locks. This can be used to peek
inside metadata used by a virtual machine image while the virtual
machine is running.
It can also be used to peek inside the metadata of clustered VGs
when clustered locking is not configured or running. No attempt
will be made to communicate with the device-mapper kernel driver, so
this option is unable to report whether or not LVs are
actually in use.
.HP
**--reportformat** **basic**|**json**  
Overrides current output format for reports which is defined globally by
the report/output_format setting in lvm.conf.
**basic** is the original format with columns and rows.
If there is more than one report per command, each report is prefixed
with the report name for identification. **json** produces report
output in JSON format. See **lvmreport**(7) for more information.
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
