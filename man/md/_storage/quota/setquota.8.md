# setquota(8) - set disk quotas

```
setquota [ -rm ] [ -u | -g | -P ] [ -F quotaformat ] name block-softlimit block-hardlimit inode-softlimit inode-hardlimit -a | filesystem... 
 setquota [ -rm ] [ -u | -g | -P ] [ -F quotaformat ] [ -p protoname  ] name -a | filesystem... 
 setquota -b [ -rm ] [ -u | -g | -P ] [ -F quotaformat ] -a | filesystem... 
 setquota -t [ -u | -g | -P ] [ -F quotaformat ] block-grace inode-grace -a | filesystem... 
 setquota -T [ -u | -g | -P ] [ -F quotaformat ] name block-grace inode-grace -a | filesystem...
```

<a name="description"></a>

# Description

.IX  "setquota command"  ""  "\fLsetquota — set disk quotas"
.IX  set "disk quotas — \fLsetquota"
.IX  "disk quotas"  "setquota command"  ""  "\fLsetquota — set disk quotas"
.IX  "disk quotas"  "setquota command"  ""  "\fLsetquota — set disk quotas"
.IX  "quotas"  "setquota command"  ""  "\fLsetquota — set disk quotas"
.IX  "filesystem"  "setquota command"  ""  "\fLsetquota — set disk quotas"
**setquota**
is a command line quota editor.
The filesystem, user/group/project name and new quotas for this
filesystem can be specified on the command line. Note that if a number is
given in the place of a user/group/project name it is treated as an UID/GID/project ID.

* **-r, --remote**  
  Edit also remote quota use rpc.rquotad on remote server to set quota. This
  option is available only if quota tools were compiled with enabled support
  for setting quotas over RPC.
* **-m, --no-mixed-pathnames**  
  Currently, pathnames of NFSv4 mountpoints are sent without leading slash in the path.
  **rpc.rquotad**
  uses this to recognize NFSv4 mounts and properly prepend pseudoroot of NFS filesystem
  to the path. If you specify this option,
  **setquota**
  will always send paths with a leading slash. This can be useful for legacy reasons but
  be aware that quota over RPC will stop working if you are using new
  **rpc.rquotad**.
* **-F, --format=_quotaformat_**  
  Perform setting for specified format (ie. don't perform format autodetection).
  Possible format names are:
  **vfsold**
  Original quota format with 16-bit UIDs / GIDs,
  **vfsv0**
  Quota format with 32-bit UIDs / GIDs, 64-bit space usage, 32-bit inode usage and limits,
  **vfsv1**
  Quota format with 64-bit quota limits and usage,
  **rpc**
  (quota over NFS),
  **xfs**
  (quota on XFS filesystem)
* **-u, --user**  
  Set user quotas for named user. This is the default.
* **-g, --group**  
  Set group quotas for named group.
* **-P, --project**  
  Set project quotas for named project.
* **-p, --prototype=_protoname_**  
  Use quota settings of user, group or project
  _protoname_
  to set the quota for the named user, group or project.
* **--always-resolve**  
  Always try to translate user / group / project name to
  uid / gid / project ID even if the name is composed of
  digits only.
* **-b, --batch**  
  Read information to set from stdin (input format is
  _name block-softlimit block-hardlimit inode-softlimit inode-hardlimit_
  ). Empty lines and lines starting with # are ignored.
* **-c, --continue-batch**  
  If parsing of an input line in batch mode fails, continue with processing the next line.
* **-t, --edit-period**  
  Set grace times for users/groups/projects. Times
  **block-grace**
  and
  **inode-grace**
  are specified in seconds.
* **-T, --edit-times**  
  Alter times for individual user/group/project when softlimit is enforced. Times
  **block-grace**
  and
  **inode-grace**
  are specified in seconds or can be string 'unset'.
* **-a, --all**  
  Go through all filesystems with quota in
  **/etc/mtab**
  and perform setting.

_block-softlimit_
and
_block-hardlimit_
are interpreted as multiples of kibibyte (1024 bytes) blocks by default.
Symbols K, M, G, and T can be appended to numeric value to express kibibytes,
mebibytes, gibibytes, and tebibytes.

_inode-softlimit_
and
_inode-hardlimit_
are interpreted literally. Symbols k, m, g, and t can be appended to numeric
value to express multiples of 10^3, 10^6, 10^9, and 10^12 inodes.

To disable a quota, set the corresponding parameter to 0. To change quotas
for several filesystems, invoke once for each filesystem.

Only the super-user may edit quotas.

<a name="files"></a>

# Files


* **aquota.user or aquota.group**  
  quota file at the filesystem root (version 2 quota, non-XFS filesystems)
* **quota.user or quota.group**  
  quota file at the filesystem root (version 1 quota, non-XFS filesystems)
* **/etc/mtab**  
  mounted filesystem table

<a name="see-also"></a>

# See Also

**edquota**(8),
**quota**(1),
**quotactl**(2),
**quotacheck**(8),
**quotaon**(8),
**repquota**(8)
