# shred(1) - overwrite a file to hide its contents, and optionally delete it

GNU coreutils 8.31, March 2019

```
shred [OPTION]... FILE...
```

<a name="description"></a>

# Description



Overwrite the specified FILE(s) repeatedly, in order to make it harder
for even very expensive hardware probing to recover the data.

If FILE is -, shred standard output.

Mandatory arguments to long options are mandatory for short options too.

* **-f**, **--force**  
  change permissions to allow writing if necessary
* **-n**, **--iterations**=_N_  
  overwrite N times instead of the default (3)
* **--random-source**=_FILE_  
  get random bytes from FILE
* **-s**, **--size**=_N_  
  shred this many bytes (suffixes like K, M, G accepted)
* **-u**  
  deallocate and remove file after overwriting
* **--remove**[=_HOW_]  
  like **-u** but give control on HOW to delete;  See below
* **-v**, **--verbose**  
  show progress
* **-x**, **--exact**  
  do not round file sizes up to the next full block;
* this is the default for non-regular files
* **-z**, **--zero**  
  add a final overwrite with zeros to hide shredding
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

Delete FILE(s) if **--remove** (**-u**) is specified.  The default is not to remove
the files because it is common to operate on device files like _/dev/hda_,
and those files usually should not be removed.
The optional HOW parameter indicates how to remove a directory entry:
'unlink' =&gt; use a standard unlink call.
'wipe' =&gt; also first obfuscate bytes in the name.
'wipesync' =&gt; also sync each obfuscated byte to disk.
The default mode is 'wipesync', but note it can be expensive.

CAUTION: Note that shred relies on a very important assumption:
that the file system overwrites data in place.  This is the traditional
way to do things, but many modern file system designs do not satisfy this
assumption.  The following are examples of file systems on which shred is
not effective, or is not guaranteed to be effective in all file system modes:

* log-structured or journaled file systems, such as those supplied with
AIX and Solaris (and JFS, ReiserFS, XFS, Ext3, etc.)

* file systems that write redundant data and carry on even if some writes
fail, such as RAID-based file systems

* file systems that make snapshots, such as Network Appliance's NFS server

* file systems that cache in temporary locations, such as NFS
version 3 clients

* compressed file systems

In the case of ext3 file systems, the above disclaimer applies
(and shred is thus of limited effectiveness) only in data=journal mode,
which journals file data in addition to just metadata.  In both the
data=ordered (default) and data=writeback modes, shred works as usual.
Ext3 journaling modes can be changed by adding the data=something option
to the mount options for a particular file system in the _/etc/fstab_ file,
as documented in the mount man page (man mount).

In addition, file system backups and remote mirrors may contain copies
of the file that cannot be removed, and that will allow a shredded file
to be recovered later.

<a name="author"></a>

# Author

Written by Colin Plumb.

<a name="reporting-bugs"></a>

# Reporting Bugs

GNU coreutils online help: &lt;https://www.gnu.org/software/coreutils/&gt;  
Report any translation bugs to &lt;https://translationproject.org/team/&gt;

<a name="copyright"></a>

# Copyright

Copyright © 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later &lt;https://gnu.org/licenses/gpl.html&gt;.  
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

<a name="see-also"></a>

# See Also

Full documentation &lt;https://www.gnu.org/software/coreutils/shred&gt;  
or available locally via: info '(coreutils) shred invocation'
