# convertquota(8)

Fri Aug 20 1999

.UC 4

<a name="name"></a>

# Name

convertquota - convert quota from old file format to new one

<a name="synopsis"></a>

# Synopsis

```
convertquota [ -ug ]  -e filesystem 
 convertquota [ -ug ]  -f oldformat,newformat filesystem
```

<a name="description"></a>

# Description

**convertquota**
converts old quota files
**quota.user**
and
**quota.group**
to files
**aquota.user**
and
**aquota.group**
in new format currently used by 2.4.0-ac? and newer or by SuSE or Red Hat Linux 2.4 kernels on
_filesystem_.

New file format allows using quotas for 32-bit uids / gids, setting quotas for root,
accounting used space in bytes (and so allowing use of quotas in ReiserFS) and it
is also architecture independent. This format introduces Radix Tree (a simple form of tree
structure) to quota file.

<a name="options"></a>

# Options


* **-u, --user**  
  convert user quota file. This is the default.
* **-g, --group**  
  convert group quota file.
* **-f, --convert-format _oldformat,newformat_**  
  convert quota file from
  _oldformat_
  to
  _newformat_.
* **-e, --convert-endian**  
  convert vfsv0 file format from big endian to little endian (old kernels had
  a bug and did not store quota files in little endian format).
* **-V, --version**  
  print version information.

<a name="files"></a>

# Files


* **aquota.user**  
  new user quota file
* **aquota.group**  
  new group quota file

<a name="see-also"></a>

# See Also

**quota**(1),
**setquota**(8),
**edquota**(8),
**quotacheck**(8),
**quotaon**(8),
**repquota**(8)

<a name="author"></a>

# Author

Jan Kara \&lt;[jack@suse.cz](mailto:jack@suse.cz)\&gt;

