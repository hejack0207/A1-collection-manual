# vgs(8) - Display information about volume groups

Red Hat, Inc., LVM TOOLS 2.02.183(2) (2018-12-07)


<a name="synopsis"></a>

# Synopsis

```
vgs
[ option_args ]
[ position_args ]

```

<a name="description"></a>

# Description

vgs produces formatted output about VGs.

<a name="usage"></a>

# Usage

**vgs**  
[ **-a**|**--all** ]  
[ **-o**|**--options** _String_ ]  
[ **-S**|**--select** _String_ ]  
[ **-O**|**--sort** _String_ ]  
[    **--aligned** ]  
[    **--binary** ]  
[    **--configreport** **log**|**vg**|**lv**|**pv**|**pvseg**|**seg** ]  
[    **--foreign** ]  
[    **--ignorelockingfailure** ]  
[    **--ignoreskippedcluster** ]  
[    **--logonly** ]  
[    **--nameprefixes** ]  
[    **--noheadings** ]  
[    **--nolocking** ]  
[    **--nosuffix** ]  
[    **--readonly** ]  
[    **--reportformat** **basic**|**json** ]  
[    **--rows** ]  
[    **--separator** _String_ ]  
[    **--shared** ]  
[    **--trustcache** ]  
[    **--unbuffered** ]  
[    **--units** **r**|**R**|**h**|**H**|**b**|**B**|**s**|**S**|**k**|**K**|**m**|**M**|**g**|**G**|**t**|**T**|**p**|**P**|**e**|**E** ]  
[    **--unquoted** ]  
[ COMMON_OPTIONS ]  
[ _VG_|_Tag_ ... ]

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
List all VGs. Equivalent to not specifying any VGs.
.HP
**--binary**  
Use binary values "0" or "1" instead of descriptive literal values
for columns that have exactly two valid values to report (not counting
the "unknown" value which denotes that the value could not be determined).
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
**--nameprefixes**  
Add an "LVM2_" prefix plus the field name to the output. Useful
with --noheadings to produce a list of field=value pairs that can
be used to set environment variables (for example, in udev rules).
.HP
**--noheadings**  
Suppress the headings line that is normally the first line of output.
Useful if grepping the output.
.HP
**--nolocking**  
Disable locking.
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
**--rows**  
Output columns as rows.
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
**--trustcache**  
Avoids certain device scanning during command processing. Do not use.
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
**--unquoted**  
When used with --nameprefixes, output values in the field=value
pairs are not quoted.
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

<a name="notes"></a>

# Notes

The vg_attr bits are:

* 1  
  Permissions: (w)riteable, (r)ead-only
* 2  
  Resi(z)eable
* 3  
  E(x)ported
* 4  
  (p)artial: one or more physical volumes belonging to the volume group
  are missing from the system
* 5  
  Allocation policy: (c)ontiguous, c(l)ing, (n)ormal, (a)nywhere
* 6  
  (c)lustered, (s)hared

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
