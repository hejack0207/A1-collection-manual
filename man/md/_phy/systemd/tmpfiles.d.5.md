# tmpfiles\&.d(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

tmpfiles.d - Configuration for creation, deletion and cleaning of volatile and temporary files

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    /etc/tmpfiles.d/*.conf
    /run/tmpfiles.d/*.conf
    /usr/lib/tmpfiles.d/*.conf
        
<synopsis>


```
    ~/.config/user-tmpfiles.d/*.conf
    $XDG_RUNTIME_DIR/user-tmpfiles.d/*.conf
    ~/.local/share/user-tmpfiles.d/*.conf
    ...
    /usr/share/user-tmpfiles.d/*.conf
        

<a name="description"></a>

# Description


tmpfiles.d
configuration files provide a generic mechanism to define the
_creation_
of regular files, directories, pipes, and device nodes, adjustments to their
_access mode, ownership, attributes, quota assignments, and contents_, and finally their time-based
_removal_. It is mostly commonly used for volatile and temporary files and directories (such as those located under
/run,
/tmp,
/var/tmp, the API file systems such as
/sys
or
/proc, as well as some other directories below
/var).

**systemd-tmpfiles**
uses this configuration to create volatile files and directories during boot and to do periodic cleanup afterwards. See
**systemd-tmpfiles**(5)
for the description of
systemd-tmpfiles-setup.service,
systemd-tmpfiles-cleanup.service, and associated units.

System daemons frequently require private runtime directories below
/run
to store communication sockets and similar. For these, is is better to use
_RuntimeDirectory=_
in their unit files (see
**systemd.exec**(5)
for details), if the flexibility provided by
tmpfiles.d
is not required. The advantages are that the configuration required by the unit is centralized in one place, and that the lifetime of the directory is tied to the lifetime of the service itself. Similarly,
_StateDirectory=_,
_CacheDirectory=_,
_LogsDirectory=_, and
_ConfigurationDirectory=_
should be used to create directories under
/var/lib/,
/var/cache/,
/var/log/, and
/etc/.
tmpfiles.d
should be used for files whose lifetime is independent of any service or requires more complicated configuration.

<a name="configuration-directories-and-precedence"></a>

# Configuration Directories and Precedence


Each configuration file shall be named in the style of
_package_.conf
or
_package_-_part_.conf. The second variant should be used when it is desirable to make it easy to override just this part of configuration.

Files in
/etc/tmpfiles.d
override files with the same name in
/usr/lib/tmpfiles.d
and
/run/tmpfiles.d. Files in
/run/tmpfiles.d
override files with the same name in
/usr/lib/tmpfiles.d. Packages should install their configuration files in
/usr/lib/tmpfiles.d. Files in
/etc/tmpfiles.d
are reserved for the local administrator, who may use this logic to override the configuration files installed by vendor packages. All configuration files are sorted by their filename in lexicographic order, regardless of which of the directories they reside in. If multiple files specify the same path, the entry in the file with the lexicographically earliest name will be applied. All other conflicting entries will be logged as errors. When two lines are prefix path and suffix path of each other, then the prefix line is always created first, the suffix later (and if removal applies to the line, the order is reversed: the suffix is removed first, the prefix later). Lines that take globs are applied after those accepting no globs. If multiple operations shall be applied on the same file (such as ACL, xattr, file attribute adjustments), these are always done in the same fixed order. Except for those cases, the files/directories are processed in the order they are listed.

If the administrator wants to disable a configuration file supplied by the vendor, the recommended way is to place a symlink to
/dev/null
in
/etc/tmpfiles.d/
bearing the same filename.

<a name="configuration-file-format"></a>

# Configuration File Format


The configuration format is one line per path containing type, path, mode, ownership, age, and argument fields:

.if n \{.RS 4
.\}
    #Type Path        Mode User Group Age Argument
    d     /run/user   0755 root root  10d -
    L     /tmp/foobar -    -    -     -   /dev/null
.if n \{.RE
.\}

Fields may be enclosed within quotes and contain C-style escapes.

<a name="type"></a>

### Type


The type consists of a single letter and optionally an exclamation mark and/or minus sign.

The following line types are understood:

_f_
Create a file if it does not exist yet. If the argument parameter is given and the file did not exist yet, it will be written to the file. Does not follow symlinks.

_F_
Create or truncate a file. If the argument parameter is given, it will be written to the file. Does not follow symlinks.

_w_
Write the argument parameter to a file, if the file exists. Lines of this type accept shell-style globs in place of normal path names. The argument parameter will be written without a trailing newline. C-style backslash escapes are interpreted. Follows symlinks.

_d_
Create a directory. The mode and ownership will be adjusted if specified. Contents of this directory are subject to time based cleanup if the age argument is specified.

_D_
Similar to
_d_, but in addition the contents of the directory will be removed when
**--remove**
is used.

_e_
Adjust the mode and ownership of existing directories and remove their contents based on age. Lines of this type accept shell-style globs in place of normal path names. Contents of the directories are subject to time based cleanup if the age argument is specified. If the age argument is
"0", contents will be unconditionally deleted every time
**systemd-tmpfiles --clean**
is run.

For this entry to be useful, at least one of the mode, user, group, or age arguments must be specified, since otherwise this entry has no effect. As an exception, an entry with no effect may be useful when combined with
_!_, see the examples.

_v_
Create a subvolume if the path does not exist yet, the file system supports subvolumes (btrfs), and the system itself is installed into a subvolume (specifically: the root directory
/
is itself a subvolume). Otherwise, create a normal directory, in the same way as
_d_.

A subvolume created with this line type is not assigned to any higher-level quota group. For that, use
_q_
or
_Q_, which allow creating simple quota group hierarchies, see below.

_q_
Create a subvolume or directory the same as
_v_, but assign the subvolume to the same higher-level quota groups as the parent. This ensures that higher-level limits and accounting applied to the parent subvolume also include the specified subvolume. On non-btrfs file systems, this line type is identical to
_d_.

If the subvolume already exists, no change to the quota hierarchy is made, regardless of whether the subvolume is already attached to a quota group or not. Also see
_Q_
below. See
**btrfs-qgroup**(8)
for details about the btrfs quota group concept.

_Q_
Create the subvolume or directory the same as
_v_, but assign the new subvolume to a new leaf quota group. Instead of copying the higher-level quota group assignments from the parent as is done with
_q_, the lowest quota group of the parent subvolume is determined that is not the leaf quota group. Then, an "intermediary" quota group is inserted that is one level below this level, and shares the same ID part as the specified subvolume. If no higher-level quota group exists for the parent subvolume, a new quota group at level 255 sharing the same ID as the specified subvolume is inserted instead. This new intermediary quota group is then assigned to the parent subvolumes higher-level quota groups, and the specified subvolume\*(Aqs leaf quota group is assigned to it.

Effectively, this has a similar effect as
_q_, however introduces a new higher-level quota group for the specified subvolume that may be used to enforce limits and accounting to the specified subvolume and children subvolume created within it. Thus, by creating subvolumes only via
_q_
and
_Q_, a concept of "subtree quotas" is implemented. Each subvolume for which
_Q_
is set will get a "subtree" quota group created, and all child subvolumes created within it will be assigned to it. Each subvolume for which
_q_
is set will not get such a "subtree" quota group, but it is ensured that they are added to the same "subtree" quota group as their immediate parents.

It is recommended to use
_Q_
for subvolumes that typically contain further subvolumes, and where it is desirable to have accounting and quota limits on all child subvolumes together. Examples for
_Q_
are typically
/home
or
/var/lib/machines. In contrast,
_q_
should be used for subvolumes that either usually do not include further subvolumes or where no accounting and quota limits are needed that apply to all child subvolumes together. Examples for
_q_
are typically
/var
or
/var/tmp.

As with
_q_,
_Q_
has no effect on the quota group hierarchy if the subvolume already exists, regardless of whether the subvolume already belong to a quota group or not.

_p_, _p+_
Create a named pipe (FIFO) if it does not exist yet. If suffixed with
_+_
and a file already exists where the pipe is to be created, it will be removed and be replaced by the pipe.

_L_, _L+_
Create a symlink if it does not exist yet. If suffixed with
_+_
and a file or directory already exists where the symlink is to be created, it will be removed and be replaced by the symlink. If the argument is omitted, symlinks to files with the same name residing in the directory
/usr/share/factory/
are created. Note that permissions and ownership on symlinks are ignored.

_c_, _c+_
Create a character device node if it does not exist yet. If suffixed with
_+_
and a file already exists where the device node is to be created, it will be removed and be replaced by the device node. It is recommended to suffix this entry with an exclamation mark to only create static device nodes at boot, as udev will not manage static device nodes that are created at runtime.

_b_, _b+_
Create a block device node if it does not exist yet. If suffixed with
_+_
and a file already exists where the device node is to be created, it will be removed and be replaced by the device node. It is recommended to suffix this entry with an exclamation mark to only create static device nodes at boot, as udev will not manage static device nodes that are created at runtime.

_C_
Recursively copy a file or directory, if the destination files or directories do not exist yet or the destination directory is empty. Note that this command will not descend into subdirectories if the destination directory already exists and is not empty. Instead, the entire copy operation is skipped. If the argument is omitted, files from the source directory
/usr/share/factory/
with the same name are copied. Does not follow symlinks.

_x_
Ignore a path during cleaning. Use this type to exclude paths from clean-up as controlled with the Age parameter. Note that lines of this type do not influence the effect of
_r_
or
_R_
lines. Lines of this type accept shell-style globs in place of normal path names.

_X_
Ignore a path during cleaning. Use this type to exclude paths from clean-up as controlled with the Age parameter. Unlike
_x_, this parameter will not exclude the content if path is a directory, but only directory itself. Note that lines of this type do not influence the effect of
_r_
or
_R_
lines. Lines of this type accept shell-style globs in place of normal path names.

_r_
Remove a file or directory if it exists. This may not be used to remove non-empty directories, use
_R_
for that. Lines of this type accept shell-style globs in place of normal path names. Does not follow symlinks.

_R_
Recursively remove a path and all its subdirectories (if it is a directory). Lines of this type accept shell-style globs in place of normal path names. Does not follow symlinks.

_z_
Adjust the access mode, user and group ownership, and restore the SELinux security context of a file or directory, if it exists. Lines of this type accept shell-style globs in place of normal path names. Does not follow symlinks.

_Z_
Recursively set the access mode, user and group ownership, and restore the SELinux security context of a file or directory if it exists, as well as of its subdirectories and the files contained therein (if applicable). Lines of this type accept shell-style globs in place of normal path names. Does not follow symlinks.

_t_
Set extended attributes. Lines of this type accept shell-style globs in place of normal path names. This can be useful for setting SMACK labels. Does not follow symlinks.

_T_
Recursively set extended attributes. Lines of this type accept shell-style globs in place of normal path names. This can be useful for setting SMACK labels. Does not follow symlinks.

_h_
Set file/directory attributes. Lines of this type accept shell-style globs in place of normal path names.

The format of the argument field is
_[+-=][aAcCdDeijsStTu] _. The prefix
_+_
(the default one) causes the attribute(s) to be added;
_-_
causes the attribute(s) to be removed;
_=_
causes the attributes to be set exactly as the following letters. The letters
"aAcCdDeijsStTu"
select the new attributes for the files, see
**chattr**(1)
for further information.

Passing only
_=_
as argument resets all the file attributes listed above. It has to be pointed out that the
_=_
prefix limits itself to the attributes corresponding to the letters listed here. All other attributes will be left untouched. Does not follow symlinks.

_H_
Recursively set file/directory attributes. Lines of this type accept shell-style globs in place of normal path names. Does not follow symlinks.

_a_, _a+_
Set POSIX ACLs (access control lists). If suffixed with
_+_, the specified entries will be added to the existing set.
**systemd-tmpfiles**
will automatically add the required base entries for user and group based on the access mode of the file, unless base entries already exist or are explicitly specified. The mask will be added if not specified explicitly or already present. Lines of this type accept shell-style globs in place of normal path names. This can be useful for allowing additional access to certain files. Does not follow symlinks.

_A_, _A+_
Same as
_a_
and
_a+_, but recursive. Does not follow symlinks.

If the exclamation mark is used, this line is only safe to execute during boot, and can break a running system. Lines without the exclamation mark are presumed to be safe to execute at any time, e.g. on package upgrades.
**systemd-tmpfiles**
will execute line with an exclamation mark only if option
**--boot**
is given.

For example:

.if n \{.RS 4
.\}
    # Make sure these are created by default so that nobody else can
    d /tmp/.X11-unix 1777 root root 10d
    
    # Unlink the X11 lock files
    r! /tmp/.X[0-9]*-lock
.if n \{.RE
.\}

The second line in contrast to the first one would break a running system, and will only be executed with
**--boot**.

If the minus sign is used, this line failing to run successfully during create (and only create) will not cause the execution of
**systemd-tmpfiles**
to return an error.

For example:

.if n \{.RS 4
.\}
    # Modify sysfs but dont fail if we are in a container with a read-only /proc
    w- /proc/sys/vm/swappiness - - - - 10
.if n \{.RE
.\}

Note that for all line types that result in creation of any kind of file node (i.e.
_f_/_F_,
_d_/_D_/_v_/_q_/_Q_,
_p_,
_L_,
_c_/_b_
and
_C_) leading directories are implicitly created if needed, owned by root with an access mode of 0755. In order to create them with different modes or ownership make sure to add appropriate
_d_
lines.

<a name="path"></a>

### Path


The file system path specification supports simple specifier expansion, see below. The path (after expansion) must be absolute.

<a name="mode"></a>

### Mode


The file access mode to use when creating this file or directory. If omitted or when set to
"-", the default is used: 0755 for directories, 0644 for all other file objects. For
_z_,
_Z_
lines, if omitted or when set to
"-", the file access mode will not be modified. This parameter is ignored for
_x_,
_r_,
_R_,
_L_,
_t_, and
_a_
lines.

Optionally, if prefixed with
"~", the access mode is masked based on the already set access bits for existing file or directories: if the existing file has all executable bits unset, all executable bits are removed from the new access mode, too. Similarly, if all read bits are removed from the old access mode, they will be removed from the new access mode too, and if all write bits are removed, they will be removed from the new access mode too. In addition, the sticky/SUID/SGID bit is removed unless applied to a directory. This functionality is particularly useful in conjunction with
_Z_.

<a name="user-group"></a>

### User, Group


The user and group to use for this file or directory. This may either be a numeric ID or a user/group name. If omitted or when set to
"-", the user and group of the user who invokes
**systemd-tmpfiles**
is used. For
_z_
and
_Z_
lines, when omitted or when set to
"-", the file ownership will not be modified. These parameters are ignored for
_x_,
_r_,
_R_,
_L_,
_t_, and
_a_
lines.

This field should generally only reference system users/groups, i.e. users/groups that are guaranteed to be resolvable during early boot. If this field references users/groups that only become resolveable during later boot (i.e. after NIS, LDAP or a similar networked directory service become available), execution of the operations declared by the line will likely fail. Also see
\m[blue]**Notes on Resolvability of User and Group Names**\m[]\s-2\u[1]\d\s+2
for more information on requirements on system user/group definitions.

<a name="age"></a>

### Age


The date field, when set, is used to decide what files to delete when cleaning. If a file or directory is older than the current time minus the age field, it is deleted. The field format is a series of integers each followed by one of the following suffixes for the respective time units:
**s**,
**m**
or
**min**,
**h**,
**d**,
**w**,
**ms**, and
**us**, meaning seconds, minutes, hours, days, weeks, milliseconds, and microseconds, respectively. Full names of the time units can be used too.

If multiple integers and units are specified, the time values are summed. If an integer is given without a unit,
**s**
is assumed.

When the age is set to zero, the files are cleaned unconditionally.

The age field only applies to lines starting with
_d_,
_D_,
_e_,
_v_,
_q_,
_Q_,
_C_,
_x_
and
_X_. If omitted or set to
"-", no automatic clean-up is done.

If the age field starts with a tilde character
"~", the clean-up is only applied to files and directories one level inside the directory specified, but not the files and directories immediately inside it.

The age of a file system entry is determined from its last modification timestamp (mtime), its last access timestamp (atime), and (except for directories) its last status change timestamp (ctime). Any of these three (or two) values will prevent cleanup if it is more recent than the current time minus the age field.

<a name="argument"></a>

### Argument


For
_L_
lines determines the destination path of the symlink. For
_c_
and
_b_, determines the major/minor of the device node, with major and minor formatted as integers, separated by
":", e.g.
"1:3". For
_f_,
_F_, and
_w_, the argument may be used to specify a short string that is written to the file, suffixed by a newline. For
_C_, specifies the source file or directory. For
_t_
and
_T_, determines extended attributes to be set. For
_a_
and
_A_, determines ACL attributes to be set. For
_h_
and
_H_, determines the file attributes to set. Ignored for all other lines.

This field can contain specifiers, see below.

<a name="specifiers"></a>

# Specifiers


Specifiers can be used in the "path" and "argument" fields. An unknown or unresolvable specifier is treated as invalid configuration. The following expansions are understood:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Specifiers available**
.TS
allbox tab(:);
lB lB lB.
T{
Specifier
T}:T{
Meaning
T}:T{
Details
T}
.T&
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l
l l l.
T{
"%b"
T}:T{
Boot ID
T}:T{
The boot ID of the running system, formatted as string. See **random**(4) for more information.
T}
T{
"%C"
T}:T{
System or user cache directory
T}:T{
In **--user** mode, this is the same as _$XDG\_CACHE\_HOME_, and /var/cache otherwise.
T}
T{
"%h"
T}:T{
User home directory
T}:T{
This is the home directory of the user running the command. In case of the system instance this resolves to "/root".
T}
T{
"%H"
T}:T{
Host name
T}:T{
The hostname of the running system.
T}
T{
"%L"
T}:T{
System or user log directory
T}:T{
In **--user** mode, this is the same as _$XDG\_CONFIG\_HOME_ with /log appended, and /var/log otherwise.
T}
T{
"%m"
T}:T{
Machine ID
T}:T{
The machine ID of the running system, formatted as string. See **machine-id**(5) for more information.
T}
T{
"%S"
T}:T{
System or user state directory
T}:T{
In **--user** mode, this is the same as _$XDG\_CONFIG\_HOME_, and /var/lib otherwise.
T}
T{
"%t"
T}:T{
System or user runtime directory
T}:T{
In **--user** mode, this is the same _$XDG\_RUNTIME\_DIR_, and /run otherwise.
T}
T{
"%T"
T}:T{
Directory for temporary files
T}:T{
This is either /tmp or the path "$TMPDIR", "$TEMP" or "$TMP" are set to.
T}
T{
"%g"
T}:T{
User group
T}:T{
This is the name of the group running the command. In case of the system instance this resolves to "root".
T}
T{
"%G"
T}:T{
User GID
T}:T{
This is the numeric GID of the group running the command. In case of the system instance this resolves to **0**.
T}
T{
"%u"
T}:T{
User name
T}:T{
This is the name of the user running the command. In case of the system instance this resolves to "root".
T}
T{
"%U"
T}:T{
User UID
T}:T{
This is the numeric UID of the user running the command. In case of the system instance this resolves to **0**.
T}
T{
"%v"
T}:T{
Kernel release
T}:T{
Identical to **uname -r** output.
T}
T{
"%V"
T}:T{
Directory for larger and persistent temporary files
T}:T{
This is either /var/tmp or the path "$TMPDIR", "$TEMP" or "$TMP" are set to.
T}
T{
"%%"
T}:T{
Escaped "%"
T}:T{
Single percent sign.
T}
.TE


<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Create directories with specific mode and ownership**

**screen**(1), needs two directories created at boot with specific modes and ownership:

.if n \{.RS 4
.\}
    # /usr/lib/tmpfiles.d/screen.conf
    d /run/screens  1777 root screen 10d
    d /run/uscreens 0755 root screen 10d12h
.if n \{.RE
.\}

Contents of
/run/screens
and /run/uscreens will be cleaned up after 10 and 10½ days, respectively.

**Example&nbsp;2.&nbsp;Create a directory with a SMACK attribute**

.if n \{.RS 4
.\}
    D /run/cups - - - -
    t /run/cups - - - - security.SMACK64=printing user.attr-with-spaces="foo bar"
          
.if n \{.RE
.\}

The directory will be owned by root and have default mode. Its contents are not subject to time based cleanup, but will be obliterated when
**systemd-tmpfiles --remove**
runs.

**Example&nbsp;3.&nbsp;Create a directory and prevent its contents from cleanup**

**abrt**(1), needs a directory created at boot with specific mode and ownership and its content should be preserved from the automatic cleanup applied to the contents of
/var/tmp:

.if n \{.RS 4
.\}
    # /usr/lib/tmpfiles.d/tmp.conf
    d /var/tmp 1777 root root 30d
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    # /usr/lib/tmpfiles.d/abrt.conf
    d /var/tmp/abrt 0755 abrt abrt -
.if n \{.RE
.\}

**Example&nbsp;4.&nbsp;Apply clean up during boot and based on time**

.if n \{.RS 4
.\}
    # /usr/lib/tmpfiles.d/dnf.conf
    r! /var/cache/dnf/*/*/download_lock.pid
    r! /var/cache/dnf/*/*/metadata_lock.pid
    r! /var/lib/dnf/rpmdb_lock.pid
    e  /var/cache/dnf/ - - - 30d
.if n \{.RE
.\}

The lock files will be removed during boot. Any files and directories in
/var/cache/dnf/
will be removed after they have not been accessed in 30 days.

**Example&nbsp;5.&nbsp;Empty the contents of a cache directory on boot**

.if n \{.RS 4
.\}
    # /usr/lib/tmpfiles.d/krb5rcache.conf
    e! /var/cache/krb5rcache - - - 0
.if n \{.RE
.\}

Any files and subdirectories in
/var/cache/krb5rcache/
will be removed on boot. The directory will not be created.

<a name="run-and-varrun"></a>

# /Run/ and /Var/Run/


/var/run/
is a deprecated symlink to
/run/, and applications should use the latter.
**systemd-tmpfiles**
will warn if
/var/run/
is used.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-tmpfiles**(8),
**systemd-delta**(1),
**systemd.exec**(5),
**attr**(5),
**getfattr**(1),
**setfattr**(1),
**setfacl**(1),
**getfacl**(1),
**chattr**(1),
**btrfs-subvolume**(8),
**btrfs-qgroup**(8)

<a name="notes"></a>

# Notes


*  1.  
  Notes on Resolvability of User and Group Names
      https://systemd.io/UIDS-GIDS.html#notes-on-resolvability-of-user-and-group-names
