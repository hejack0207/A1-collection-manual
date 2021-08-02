# quotaon(8)

.UC 4

<a name="name"></a>

# Name

quotaon, quotaoff - turn filesystem quotas on and off

<a name="synopsis"></a>

# Synopsis

```
quotaon [ -vugfp ] [ -F format-name ] filesystem.\|.\|.
quotaon [ -avugPfp ] [ -F format-name ] 
 quotaoff [ -vugPp ] [ -x state ] filesystem.\|.\|.
quotaoff [ -avugp ]
```

<a name="description"></a>

# Description


<a name="quotaon"></a>

### quotaon

.IX  "quotaon command"  ""  "\fLquotaon — turn filesystem quotas on"
.IX  "user quotas"  "quotaon command"  ""  "\fLquotaon — turn filesystem quotas on"
.IX  "disk quotas"  "quotaon command"  ""  "\fLquotaon — turn filesystem quotas on"
.IX  "quotas"  "quotaon command"  ""  "\fLquotaon — turn filesystem quotas on"
.IX  "filesystem"  "quotaon command"  ""  "\fLquotaon — turn filesystem quotas on"

**quotaon**
announces to the system that disk quotas should be enabled on one or
more filesystems. The filesystem quota files must be present in the root
directory of the specified filesystem and be named either
_aquota.user_
(for version 2 user quota),
_quota.user_
(for version 1 user quota),
_aquota.group_
(for version 2 group quota), or
_quota.group_
(for version 1 group quota).

XFS filesystems are a special case - XFS considers quota
information as filesystem metadata and uses journaling to provide
a higher level guarantee of consistency.
There are two components to the XFS disk quota system:
accounting and limit enforcement.
XFS filesystems require that quota accounting be turned on at mount time.
It is possible to enable and disable limit enforcement on an XFS
filesystem after quota accounting is already turned on.
The default is to turn on both accounting and enforcement.

The XFS quota implementation does not maintain quota information in
user-visible files, but rather stores this information internally.

<a name="quotaoff"></a>

### quotaoff

.IX  "quotaoff command"  ""  "\fLquotaoff — turn filesystem quotas off"
.IX  "user quotas"  "quotaoff command"  ""  "\fLquotaoff — turn filesystem quotas off"
.IX  "disk quotas"  "quotaoff command"  ""  "\fLquotaoff — turn filesystem quotas off"
.IX  "quotas"  "quotaoff command"  ""  "\fLquotaoff — turn filesystem quotas off"
.IX  "filesystem"  "quotaoff command"  ""  "\fLquotaoff — turn filesystem quotas off"

**quotaoff**
announces to the system that the specified filesystems should
have any disk quotas turned off.

<a name="options"></a>

# Options


<a name="quotaon"></a>

### quotaon


* **-F, --format=_format-name_**  
  Report quota for specified format (ie. don't perform format autodetection).
  Possible format names are:
  **vfsold**
  Original quota format with 16-bit UIDs / GIDs,
  **vfsv0**
  Quota format with 32-bit UIDs / GIDs, 64-bit space usage, 32-bit inode usage and limits,
  **vfsv1**
  Quota format with 64-bit quota limits and usage,
  **xfs**
  (quota on XFS filesystem)
* **-a, --all**  
  All automatically mounted (no
  **noauto**
  option) non-NFS filesystems in
  **/etc/fstab**
  with quotas will have their quotas turned on.
  This is normally used at boot time to enable quotas.
* **-v, --verbose**  
  Display a message for each filesystem where quotas are turned on.
* **-u, --user**  
  Manipulate user quotas. This is the default.
* **-g, --group**  
  Manipulate group quotas.
* **-P, --project**  
  Manipulate project quotas.
* **-p, --print-state**  
  Instead of turning quotas on just print state of quotas (ie. whether. quota is on or off)
* **-x, --xfs-command enforce**  
  Switch on limit enforcement for XFS filesystems. This is the default action for
  any XFS filesystem. This option is only applicable to XFS, and is silently
  ignored for other filesystem types.
* **-f, --off**  
  Make
  **quotaon**
  behave like being called as
  **quotaoff**.

<a name="quotaoff"></a>

### quotaoff


* **-F, --format=_format-name_**  
  Report quota for specified format (ie. don't perform format autodetection).
  Possible format names are:
  **vfsold**
  (version 1 quota),
  **vfsv0**
  (version 2 quota),
  **xfs**
  (quota on XFS filesystem)
* **-a, --all**  
  Force all filesystems in
  **/etc/fstab**
  to have their quotas disabled.
* **-v, --verbose**  
  Display a message for each filesystem affected.
* **-u, --user**  
  Manipulate user quotas. This is the default.
* **-g, --group**  
  Manipulate group quotas.
* **-P, --project**  
  Manipulate project quotas.
* **-p, --print-state**  
  Instead of turning quotas off just print state of quotas (ie. whether. quota is on or off)
* **-x, --xfs-command delete**  
  Free up the space used to hold quota information (maintained
  internally) within XFS.
  This option is only applicable to XFS, and is silently
  ignored for other filesystem types.
  It can only be used on a filesystem with quota previously turned off.
* **-x, --xfs-command enforce**  
  Switch off limit enforcement for XFS filesystems (perform quota accounting
  only). This is the default action for any XFS filesystem.  This option is only
  applicable to XFS, and is silently ignored for other filesystem types.
* **-x, --xfs-command account**  
  This option can be used to disable quota accounting. It is not possible to
  enable quota accounting by quota tools. Use
  _mount_(8)
  for that. This option is only applicable to XFS filesystems, and is silently
  ignored for other filesystem types.

<a name="notes-on-xfs-filesystems"></a>

# Notes on Xfs Filesystems

To enable quotas on an XFS filesystem, use
_mount_(8)
or
**/etc/fstab**
quota option to enable both accounting and limit enforcement.
**quotaon**
utility cannot be used for this purpose.

Turning on quotas on an XFS root filesystem requires the quota mount
options be passed into the kernel at boot time through the Linux
**rootflags**
boot option.

To turn off quota limit enforcement on any XFS filesystem, first make
sure that quota accounting and enforcement are both turned on using
**repquota -v**
_filesystem_.
Then, use
**quotaoff -v**
_filesystem_
to disable limit enforcement.
This may be done while the filesystem is mounted.

Turning on quota limit enforcement on an XFS filesystem is
achieved using
**quotaon -v**
_filesystem_.
This may be done while the filesystem is mounted.

<a name="files"></a>

# Files


* **aquota.user or aquota.group**  
  quota file at the filesystem root (version 2 quota, non-XFS filesystems)
* **quota.user or quota.group**  
  quota file at the filesystem root (version 1 quota, non-XFS filesystems)
* **/etc/fstab**  
  default filesystems

<a name="see-also"></a>

# See Also

**quotactl**(2),
**fstab**(5),
**quota_nld**(8),
**repquota**(8),
**warnquota**(8)
