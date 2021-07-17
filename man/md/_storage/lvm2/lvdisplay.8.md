# lvdisplay(8) - Display information about a logical volume

Red Hat, Inc., LVM TOOLS 2.02.183(2) (2018-12-07)


<a name="synopsis"></a>

# Synopsis

```
lvdisplay
[ option_args ]
[ position_args ]

```

<a name="description"></a>

# Description

lvdisplay shows the attributes of LVs, like size, read/write status,
snapshot information, etc.

**lvs**(8) is a preferred alternative that shows the same information
and more, using a more compact and configurable output format.

<a name="usage"></a>

# Usage

**lvdisplay**  
[ **-a**|**--all** ]  
[ **-c**|**--colon** ]  
[ **-C**|**--columns** ]  
[ **-H**|**--history** ]  
[ **-m**|**--maps** ]  
[ **-o**|**--options** _String_ ]  
[ **-O**|**--sort** _String_ ]  
[ **-S**|**--select** _String_ ]  
[    **--aligned** ]  
[    **--binary** ]  
[    **--configreport** **log**|**vg**|**lv**|**pv**|**pvseg**|**seg** ]  
[    **--foreign** ]  
[    **--ignorelockingfailure** ]  
[    **--ignoreskippedcluster** ]  
[    **--logonly** ]  
[    **--noheadings** ]  
[    **--nosuffix** ]  
[    **--readonly** ]  
[    **--reportformat** **basic**|**json** ]  
[    **--segments** ]  
[    **--separator** _String_ ]  
[    **--shared** ]  
[    **--unbuffered** ]  
[    **--units** **r**|**R**|**h**|**H**|**b**|**B**|**s**|**S**|**k**|**K**|**m**|**M**|**g**|**G**|**t**|**T**|**p**|**P**|**e**|**E** ]  
[ COMMON_OPTIONS ]  
[ _VG_|_LV_|_Tag_ ... ]

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
**--aligned**  
Use with --separator to align the output columns
.HP
**-a**|**--all**  
Show information about internal LVs.
These are components of normal LVs, such as mirrors,
which are not independently accessible, e.g. not mountable.
.HP
**--binary**  
Use binary values "0" or "1" instead of descriptive literal values
for columns that have exactly two valid values to report (not counting
the "unknown" value which denotes that the value could not be determined).
.HP
**-c**|**--colon**  
Generate colon separated output for easier parsing in scripts or programs.
Also see **vgs**(8) which provides considerably more control over the output.
.HP
**-C**|**--columns**  
Display output in columns, the equivalent of **vgs**(8).
Options listed are the same as options given in **vgs**(8).
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
**--configreport** **log**|**vg**|**lv**|**pv**|**pvseg**|**seg**  
See **lvmreport**(7).
.HP
**-d**|**--debug** ...  
Set debug level. Repeat from 1 to 6 times to increase the detail of
messages sent to the log file and/or syslog (if configured).
.HP
**--driverloaded** **y**|**n**  
If set to no, the command will not attempt to use device-mapper.
For testing and debugging.
.HP
**--foreign**  
Report/display foreign VGs that would otherwise be skipped.
See **lvmsystemid**(7) for more information about foreign VGs.
.HP
**-h**|**--help**  
Display help text.
.HP
**-H**|**--history**  
Include historical LVs in the output.
(This has no effect unless LVs were removed while
lvm.conf metadata/record_lvs_history was enabled.
.HP
**--ignorelockingfailure**  
Allows a command to continue with read-only metadata
operations after locking failures.
.HP
**--ignoreskippedcluster**  
Use to avoid exiting with an non-zero status code if the command is run
without clustered locking and clustered VGs are skipped.
.HP
**--lockopt** _String_  
Used to pass options for special cases to lvmlockd.
See **lvmlockd**(8) for more information.
.HP
**--logonly**  
Suppress command report and display only log report.
.HP
**--longhelp**  
Display long help text.
.HP
**-m**|**--maps**  
Display the mapping of logical extents to PVs and physical extents.
To map physical extents to logical extents use:
pvs --segments -o+lv_name,seg_start_pe,segtype
.HP
**--noheadings**  
Suppress the headings line that is normally the first line of output.
Useful if grepping the output.
.HP
**--nosuffix**  
Suppress the suffix on output sizes. Use with --units
(except h and H) if processing the output.
.HP
**-o**|**--options** _String_  
Comma-separated, ordered list of fields to display in columns.
String arg syntax is: [+|-|#]Field1[,Field2 ...]
The prefix **+** will append the specified fields to the default fields,
**-** will remove the specified fields from the default fields, and
**#** will compact specified fields (removing them when empty for all rows.)
Use **-o help** to view the list of all available fields.
Use separate lists of fields to add, remove or compact by repeating the -o option:
-o+field1,field2 -o-field3,field4 -o#field5.
These lists are evaluated from left to right.
Use field name **lv\_all** to view all LV fields,
**vg\_all** all VG fields,
**pv\_all** all PV fields,
**pvseg\_all** all PV segment fields,
**seg\_all** all LV segment fields, and
**pvseg\_all** all PV segment columns.
See the lvm.conf report section for more config options.
See **lvmreport**(7) for more information about reporting.
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
**--segments**  
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
**--separator** _String_  
String to use to separate each column. Useful if grepping the output.
.HP
**--shared**  
Report/display shared VGs that would otherwise be skipped when
lvmlockd is not being used on the host.
See **lvmlockd**(8) for more information about shared VGs.
.HP
**-O**|**--sort** _String_  
Comma-separated ordered list of columns to sort by. Replaces the default
selection. Precede any column with **-** for a reverse sort on that column.
.HP
**-t**|**--test**  
Run in test mode. Commands will not update metadata.
This is implemented by disabling all metadata writing but nevertheless
returning success to the calling function. This may lead to unusual
error messages in multi-stage operations if a tool relies on reading
back metadata it believes has changed but hasn't.
.HP
**--unbuffered**  
Produce output immediately without sorting or aligning the columns properly.
.HP
**--units** **r**|**R**|**h**|**H**|**b**|**B**|**s**|**S**|**k**|**K**|**m**|**M**|**g**|**G**|**t**|**T**|**p**|**P**|**e**|**E**  
All sizes are output in these units:
human-(r)eadable with '&lt;' rounding indicator,
(h)uman-readable, (b)ytes, (s)ectors, (k)ilobytes, (m)egabytes,
(g)igabytes, (t)erabytes, (p)etabytes, (e)xabytes.
Capitalise to use multiples of 1000 (S.I.) instead of 1024.
Custom units can be specified, e.g. --units 3M.
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
_LV_  
Logical Volume name.  See **lvm**(8) for valid names.
An LV positional arg generally includes the VG name and LV name, e.g. VG/LV.
.HP
_Tag_  
Tag name.  See **lvm**(8) for information about tag names and using tags
in place of a VG, LV or PV.
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
