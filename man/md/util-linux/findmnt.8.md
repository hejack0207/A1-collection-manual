# findmnt(8) - find a filesystem

util-linux, May 2018

```
findmnt [options] 
 findmnt [options] device|mountpoint 
 findmnt [options] [--source] device [--target|--mountpoint] mountpoint
```

<a name="description"></a>

# Description

**findmnt**
will list all mounted filesystems or search for a filesystem.  The
**findmnt**
command is able to search in
_/etc/fstab_,
_/etc/mtab_
or
_/proc/self/mountinfo_.
If
_device_
or
_mountpoint_
is not given, all filesystems are shown.

The device may be specified by device name, major:minor numbers,
filesystem label or UUID, or partition label or UUID.  Note that
**findmnt**
follows
**mount**(8)
behavior where a device name may be interpreted
as a mountpoint (and vice versa) if the **--target**, **--mountpoint** or
**--source** options are not specified.

The command prints all mounted filesystems in the tree-like format by default.

<a name="options"></a>

# Options


* **-A**,** --all**  
  Disable all built-in filters and print all filesystems.
* **-a**,** --ascii**  
  Use ascii characters for tree formatting.
* **-b**,** --bytes**  
  Print the SIZE, USED and AVAIL columns in bytes rather than in a human-readable format.
* **-C**,** --nocanonicalize**  
  Do not canonicalize paths at all.  This option affects the comparing of paths
  and the evaluation of tags (LABEL, UUID, etc.).
* **-c**,** --canonicalize**  
  Canonicalize all printed paths.
* **-D**,** --df**  
  Imitate the output of
  **df**(1).
  This option is equivalent to
  **-o&nbsp;SOURCE,FSTYPE,SIZE,USED,AVAIL,USE%,TARGET**
  but excludes all pseudo filesystems.
  Use **--all** to print all filesystems.
* **-d**,** --direction _word_**  
  The search direction, either
  **forward**
  or
  **backward**.
* **-e**,** --evaluate**  
  Convert all tags (LABEL, UUID, PARTUUID or PARTLABEL) to the corresponding device names.
* **-F**,** --tab-file _path_**  
  Search in an alternative file.  If used with **--fstab**, **--mtab**
  or **--kernel**, then it overrides the default paths.  If specified more
  than once, then tree-like output is disabled (see the **--list** option).
* **-f**,** --first-only**  
  Print the first matching filesystem only.
* **-h**,** --help**  
  Display help text and exit.
* **-i**,** --invert**  
  Invert the sense of matching.
* **-J**,** --json**  
  Use JSON output format.
* **-k**,** --kernel**  
  Search in
  _/proc/self/mountinfo_.
  The output is in the tree-like format.  This is the default.  The output
  contains only mount options maintained by kernel (see also **--mtab)**.
* **-l**,** --list**  
  Use the list output format.  This output format is automatically enabled if the
  output is restricted by the **-t**, **-O**, **-S** or **-T**
  option and the option **--submounts** is not used or if more that one
  source file (the option **-F**) is specified.
* **-M**,** --mountpoint _path_**  
  Explicitly define the mountpoint file or directory.  See also **--target**.
* **-m**,** --mtab**  
  Search in
  _/etc/mtab_.
  The output is in the list format by default (see **--tree**).  The output may include user
  space mount options.
* **-N**,** --task _tid_**  
  Use alternative namespace /proc/&lt;tid&gt;/mountinfo rather than the default
  /proc/self/mountinfo.  If the option is specified more than once, then
  tree-like output is disabled (see the **--list** option).  See also the
  **unshare**(1)
  command.
* **-n**,** --noheadings**  
  Do not print a header line.
* **-O**,** --options _list_**  
  Limit the set of printed filesystems.  More than one option
  may be specified in a comma-separated list.  The
  **-t**
  and
  **-O**
  options are cumulative in effect.  It is different from
  **-t**
  in that each option is matched exactly; a leading
  _no_
  at the beginning does not have global meaning.  The "no" can used for
  individual items in the list.  The "no" prefix interpretation can be disabled
  by "+" prefix.
* **-o**,** --output _list_**  
  Define output columns.  See the **--help** output to get a list of the
  currently supported columns.  The
  **TARGET**
  column contains tree formatting if the
  **--list**
  or
  **--raw**
  options are not specified.
  
  The default list of columns may be extended if _list_ is
  specified in the format _+list_ (e.g. **findmnt -o +PROPAGATION**).
* **--output-all**  
  Output almost all available columns.  The columns that require
  **--poll**
  are not included.
* **-P**,** --pairs**  
  Use key="value" output format.  All potentially unsafe characters are hex-escaped (\\x&lt;code&gt;).
* **-p**,** --poll[_=list_]**  
  Monitor changes in the /proc/self/mountinfo file.  Supported actions are: mount,
  umount, remount and move.  More than one action may be specified in a
  comma-separated list.  All actions are monitored by default.
  
  The time for which **--poll** will block can be restricted with the **--timeout**
  or **--first-only** options.
  
  The standard columns always use the new version of the information from the
  mountinfo file, except the umount action which is based on the original
  information cached by
  **findmnt**(8).
  The poll mode allows to use extra columns:
    * **ACTION**  
      mount, umount, move or remount action name; this column is enabled by default
    * **OLD-TARGET**  
      available for umount and move actions
    * **OLD-OPTIONS**  
      available for umount and remount actions
* **--pseudo**  
  Print only pseudo filesystems.
* **-R**,** --submounts**  
  Print recursively all submounts for the selected filesystems.  The restrictions
  defined by options **-t**, **-O**, **-S**, **-T** and
  **--direction** are not applied to submounts.  All submounts are always
  printed in tree-like order.  The option enables the tree-like output format by
  default.  This option has no effect for **--mtab** or **--fstab**.
* **-r**,** --raw**  
  Use raw output format.  All potentially unsafe characters are hex-escaped (\\x&lt;code&gt;).
* **--real**  
  Print only real filesystems.
* **-S**,** --source _spec_**  
  Explicitly define the mount source.  Supported specifications are _device_,
  maj**:min**, **LABEL=label**, **UUID=uuid**,
  **PARTLABEL=label** and **PARTUUID=uuid**.
* **-s**,** --fstab**  
  Search in
  _/etc/fstab_.
  The output is in the list format (see **--list**).
* **-T**,** --target _path_**  
  Define the mount target.  If _path_
  is not a mountpoint file or directory, then
  **findmnt**
  checks the _path_ elements in reverse order to get the mountpoint (this feature is
  supported only when searching in kernel files and unsupported for **--fstab**).  It's
  recommended to use the option **--mountpoint** when checks of _path_ elements are
  unwanted and _path_ is a strictly specified mountpoint.
* **-t**,** --types _list_**  
  Limit the set of printed filesystems.  More than one type may be
  specified in a comma-separated list.  The list of filesystem types can be
  prefixed with
  **no**
  to specify the filesystem types on which no action should be taken.  For
  more details see
  **mount**(8).
* **--tree**  
  Enable tree-like output if possible.  The options is silently ignored for
  tables where is missing child-parent relation (e.g. fstab).
* **-U**,** --uniq**  
  Ignore filesystems with duplicate mount targets, thus effectively skipping
  over-mounted mount points.
* **-u**,** --notruncate**  
  Do not truncate text in columns.  The default is to not truncate the
  **TARGET**,
  **SOURCE**,
  **UUID**,
  **LABEL**,
  **PARTUUID**,
  **PARTLABEL**
  columns.  This option disables text truncation also in all other columns.
* **-v**,** --nofsroot**  
  Do not print a [/dir] in the SOURCE column for bind mounts or btrfs subvolumes.
* **-w**,** --timeout _milliseconds_**  
  Specify an upper limit on the time for which **--poll** will block, in milliseconds.
* **-x**,** --verify**  
  Check mount table content. The default is to verify
  _/etc/fstab_
  parsability and usability. It's possible to use this option also with **--tab-file**.
  It's possible to specify source (device) or target (mountpoint) to filter mount table. The option
  **--verbose** forces findmnt to print more details.
* **--verbose**  
  Force findmnt to print more information (**--verify** only for now).

<a name="examples"></a>

# Examples


* **findmnt --fstab -t nfs**  
  Prints all NFS filesystems defined in
  _/etc/fstab_.
* **findmnt --fstab /mnt/foo**  
  Prints all
  _/etc/fstab_
  filesystems where the mountpoint directory is /mnt/foo.  It also prints bind mounts where /mnt/foo
  is a source.
* **findmnt --fstab --target /mnt/foo**  
  Prints all
  _/etc/fstab_
  filesystems where the mountpoint directory is /mnt/foo.
* **findmnt --fstab --evaluate**  
  Prints all
  _/etc/fstab_
  filesystems and converts LABEL= and UUID= tags to the real device names.
* **findmnt -n --raw --evaluate --output=target LABEL=/boot**  
  Prints only the mountpoint where the filesystem with label "/boot" is mounted.
* **findmnt --poll --mountpoint /mnt/foo**  
  Monitors mount, unmount, remount and move on /mnt/foo.
* **findmnt --poll=umount --first-only --mountpoint /mnt/foo**  
  Waits for /mnt/foo unmount.
* **findmnt --poll=remount -t ext3 -O ro**  
  Monitors remounts to read-only mode on all ext3 filesystems.

<a name="environment"></a>

# Environment


* LIBMOUNT_FSTAB=&lt;path&gt;  
  overrides the default location of the fstab file
* LIBMOUNT_MTAB=&lt;path&gt;  
  overrides the default location of the mtab file
* LIBMOUNT_DEBUG=all  
  enables libmount debug output
* LIBSMARTCOLS_DEBUG=all  
  enables libsmartcols debug output
* LIBSMARTCOLS_DEBUG_PADDING=on  
  use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.

<a name="authors"></a>

# Authors

    Karel Zak <kzak@redhat.com>

<a name="see-also"></a>

# See Also

**fstab**(5),
**mount**(8)

<a name="availability"></a>

# Availability

The findmnt command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
