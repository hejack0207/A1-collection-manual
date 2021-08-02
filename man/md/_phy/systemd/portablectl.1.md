# portablectl(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

portablectl - Attach, detach or inspect portable service images

<a name="synopsis"></a>

# Synopsis

```
.HP \w'portablectl&nbsp;'u portablectl [OPTIONS...] {COMMAND} [NAME...]
```

<a name="description"></a>

# Description


**portablectl**
may be used to attach, detach or inspect portable service images. Its primarily a command interfacing with
**systemd-portabled.service**(8).

Portable service images contain an OS file system tree along with
**systemd**(1)
unit file information. A service image may be "attached" to the local system. If attached, a set of unit files are copied from the image to the host, and extended with
_RootDirectory=_
or
_RootImage=_
assignments (in case of service units) pointing to the image file or directory, ensuring the services will run within the file system context of the image.

Portable service images are an efficient way to bundle multiple related services and other units together, and transfer them as a whole between systems. When these images are attached the local system the contained units may run in most ways like regular system-provided units, either with full privileges or inside strict sandboxing, depending on the selected configuration.

Specifically portable service images may be of the following kind:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Directory trees containing an OS, including the top-level directories
  /usr/,
  /etc/, and so on.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  btrfs subvolumes containing OS trees, similar to normal directory trees.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Binary "raw" disk images containing MBR or GPT partition tables and Linux file system partitions. (These must be regular files, with the
  .raw
  suffix.)

<a name="options"></a>

# Options


The following options are understood:

**-q**, **--quiet**
Suppresses additional informational output while running.

**-p** _PROFILE_, **--profile=**_PROFILE_
When attaching an image, select the profile to use. By default the
"default"
profile is used. For details about profiles, see below.

**--copy=**
When attaching an image, select whether to prefer copying or symlinking of files installed into the host system. Takes one of
"copy"
(to prefer copying of files),
"symlink"
(to prefer creation of symbolic links) or
"auto"
for an intermediary mode where security profile drop-ins are symlinked while unit files are copied. Note that this option expresses a preference only, in cases where symbolic links cannot be created — for example when the image operated on is a raw disk image, and hence not directly referentiable from the host file system — copying of files is used unconditionally.

**--runtime**
When specified the unit and drop-in files are placed in
/run/systemd/system.attached/
instead of
/etc/systemd/system.attached/. Images attached with this option set hence remain attached only until the next reboot, while they are normally attached persistently.

**--no-reload**
Dont reload the service manager after attaching or detaching a portable service image. Normally the service manager is reloaded to ensure it is aware of added or removed unit files.

**--cat**
When inspecting portable service images, show the (unprocessed) contents of the metadata files pulled from the image, instead of brief summaries. Specifically, this will show the
**os-release**(5)
and unit file contents of the image.

**-H**, **--host=**
Execute the operation remotely. Specify a hostname, or a username and hostname separated by
"@", to connect to. The hostname may optionally be suffixed by a port ssh is listening on, seperated by
":", and then a container name, separated by
"/", which connects directly to a specific container on the specified host. This will use SSH to talk to the remote machine manager instance. Container names may be enumerated with
**machinectl -H ****HOST**. Put IPv6 addresses in brackets.

**-M**, **--machine=**
Execute operation on a local container. Specify a container name to connect to.

**--no-pager**
Do not pipe output into a pager.

**--no-legend**
Do not print the legend, i.e. column headers and the footer with hints.

**--no-ask-password**
Do not query the user for authentication for privileged operations.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="commands"></a>

# Commands


The following commands are understood:

**list**
List available portable service images. This will list all portable service images discovered in the portable image search paths (see below), along with brief metadata and state information. Note that many of the commands below may both operate on images inside and outside of the search paths. This command is hence mostly a convenience option, the commands are generally not restricted to what this list shows.

**attach** _IMAGE_ [_PREFIX..._]
Attach a portable service image to the host system. Expects a file system path to a portable service image file or directory as first argument. If the specified path contains no slash character ("/") it is understood as image filename that is searched for in the portable service image search paths (see below). To reference a file in the current working directory prefix the filename with
"./"
to avoid this search path logic.

When a portable service is attached four operations are executed:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  All unit files of types
  .service,
  .socket,
  .target,
  .timer
  and
  .path
  which match the indicated unit file name prefix are copied from the image to the hosts
  /etc/systemd/system.attached/
  directory (or
  /run/systemd/system.attached/
  — depending whether
  **--runtime**
  is specified, see above), which is included in the built-in unit search path of the system service manager.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  For unit files of type
  .service
  a drop-in is added to these copies that adds
  _RootDirectory=_
  or
  _RootImage=_
  settings (see
  **systemd.unit**(5)
  for details), that ensures these services are run within the file system of the originating portable service image.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  A second drop-in is created: the "profile" drop-in, that may contain additional security settings (and other settings). A number of profiles are available by default but administrators may define their own ones. See below.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  If the portable service image file is not already in the search path (see below), a symbolic link to it is created in
  /etc/portables/
  or
  /run/portables/, to make sure it is included in it.

By default all unit files whose names start with a prefix generated from the images file name are copied out. Specifically, the prefix is determined from the image file name with any suffix such as
.raw
removed, truncated at the first occurrence of and underscore character ("_"), if there is one. The underscore logic is supposed to be used to versioning so that the an image file
foobar_47.11.raw
will result in a unit file matching prefix of
foobar. This prefix is then compared with all unit files names contained in the image in the usual directories, but only unit file names where the prefix is followed by
"-",
"."
or
"@"
are considered. Example: if a portable service image file is named
foobar_47.11.raw
then by default all its unit files with names such as
foobar-quux-waldi.service,
foobar.service
or
foobar@.service
will be considered. Its possible to override the matching prefix: all strings listed on the command line after the image file name are considered prefixes, overriding the implicit logic where the prefix is derived from the image file name.

By default, after the unit files are attached the service managers configuration is reloaded, except when
**--no-reload**
is specified (see above). This ensures that the new units made available to the service manager are seen by it.

**detach** _IMAGE_
Detaches a portable service image from the host. This undoes the operations executed by the
**attach**
command above, and removes the unit file copies, drop-ins and image symlink again. This command expects an image name or path as parameter. Note that if a path is specified only the last component of it (i.e. the file or directory name itself, not the path to it) is used for finding matching unit files. This is a convencience feature to allow all arguments passed as
**attach**
also to
**detach**.

**inspect** _IMAGE_ [_PREFIX..._]
Extracts various metadata from a portable service image and presents it to the caller. Specifically, the
**os-release**(5)
file of the image is retrieved as well as all matching unit files. By default a short summary showing the most relevant metadata in combination with a list of matching unit files is shown (that is the unit files
**attach**
would install to the host system). If combined with
**--cat**
(see above), the
os-release
data and the units files contents is displayed unprocessed. This command is useful to determine whether an image qualifies as portable service image, and which unit files are included. This command expects the path to the image as parameter, optionally followed by a list of unit file prefixes to consider, similar to the
**attach**
command described above.

**is-attached** _IMAGE_
Determines whether the specified image is currently attached or not. Unless combined with the
**--quiet**
switch this will show a short state identifier for the image. Specifically:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Image attachment states**
.TS
allbox tab(:);
lB lB.
T{
State
T}:T{
Description
T}
.T&
l l
l l
l l
l l
l l
l l
l l.
T{
**detached**
T}:T{
The image is currently not attached.
T}
T{
**attached**
T}:T{
The image is currently attached, i.e. its unit files have been made available to the host system.
T}
T{
**attached-runtime**
T}:T{
Like **attached**, but the unit files have been made available transiently only, i.e. the **attach** command has been invoked with the **--runtime** option.
T}
T{
**enabled**
T}:T{
The image is currently attached, and at least one unit file associated with it has been enabled.
T}
T{
**enabled-runtime**
T}:T{
Like **enabled**, but the the unit files have been made available transiently only, i.e. the **attach** command has been invoked with the **--runtime** option.
T}
T{
**running**
T}:T{
The image is currently attached, and at least one unit file associated with it is running.
T}
T{
**running-runtime**
T}:T{
The image is currently attached transiently, and at least one unit file associated with it is running.
T}
.TE


**read-only** _IMAGE_ [_BOOL_]
Marks or (unmarks) a portable service image read-only. Takes an image name, followed by a boolean as arguments. If the boolean is omitted, positive is implied, i.e. the image is marked read-only.

**remove** _IMAGE_...
Removes one or more portable service images. Note that this command will only remove the specified image path itself — it refers to a symbolic link then the symbolic link is removed and not the image it points to.

**set-limit** [_IMAGE_] _BYTES_
Sets the maximum size in bytes that a specific portable service image, or all images, may grow up to on disk (disk quota). Takes either one or two parameters. The first, optional parameter refers to a portable service image name. If specified, the size limit of the specified image is changed. If omitted, the overall size limit of the sum of all images stored locally is changed. The final argument specifies the size limit in bytes, possibly suffixed by the usual K, M, G, T units. If the size limit shall be disabled, specify
"-"
as size.

Note that per-image size limits are only supported on btrfs file systems. Also, depending on
_BindPaths=_
settings in the portable services unit files directories from the host might be visible in the image environment during runtime which are not affected by this setting, as only the image itself is counted against this limit.

<a name="files-and-directories"></a>

# Files and Directories


Portable service images are preferably stored in
/var/lib/portables/, but are also searched for in
/etc/portables/,
/run/systemd/portables/,
/usr/local/lib/portables/
and
/usr/lib/portables/. Its recommended not to place image files directly in
/etc/portables/
or
/run/systemd/portables/
(as these are generally not suitable for storing large or non-textual data), but use these directories only for linking images located elsewhere into the image search path.

When a portable service image is attached, matching unit files are copied onto the host into the
/etc/systemd/system.attached/
and
/run/systemd/system.attached/
directories. When an image is detached, the unit files are removed again from these directories.

<a name="profiles"></a>

# Profiles


When portable service images are attached a "profile" drop-in is linked in, which may be used to enforce additional security (and other) restrictions locally. Four profile drop-ins are defined by default, and shipped in
/usr/lib/systemd/portable/profile/. Additional, local profiles may be defined by placing them in
/etc/systemd/portable/profile/. The default profiles are:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;2.&nbsp;Profiles**
.TS
allbox tab(:);
lB lB.
T{
Name
T}:T{
Description
T}
.T&
l l
l l
l l
l l.
T{
default
T}:T{
This is the default profile if no other profile name is set via the **--profile=** (see above). Its fairly restrictive, but should be useful for common, unprivileged system workloads. This includes write access to the logging framework, as well as IPC access to the D-Bus system.
T}
T{
nonetwork
T}:T{
Very similar to default, but networking is turned off for any services of the portable service image.
T}
T{
strict
T}:T{
A profile with very strict settings. This profile excludes IPC (D-Bus) and network access.
T}
T{
trusted
T}:T{
A profile with very relaxed settings. In this profile the services run with full privileges.
T}
.TE


For details on this profiles, and their effects please have a look at their precise definitions, e.g.
/usr/lib/systemd/portable/profile/default/service.conf
and similar.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="environment"></a>

# Environment


_$SYSTEMD\_PAGER_
Pager to use when
**--no-pager**
is not given; overrides
_$PAGER_. If neither
_$SYSTEMD\_PAGER_
nor
_$PAGER_
are set, a set of well-known pager implementations are tried in turn, including
**less**(1)
and
**more**(1), until one is found. If no pager implementation is discovered no pager is invoked. Setting this environment variable to an empty string or the value
"cat"
is equivalent to passing
**--no-pager**.

_$SYSTEMD\_LESS_
Override the options passed to
**less**
(by default
"FRSXMK").

If the value of
_$SYSTEMD\_LESS_
does not include
"K", and the pager that is invoked is
**less**,
Ctrl+C
will be ignored by the executable. This allows
**less**
to handle
Ctrl+C
itself.

_$SYSTEMD\_LESSCHARSET_
Override the charset passed to
**less**
(by default
"utf-8", if the invoking terminal is determined to be UTF-8 compatible).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-portabled.service**(8)
