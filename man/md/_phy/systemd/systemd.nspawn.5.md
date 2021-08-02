# systemd\&.nspawn(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.nspawn - Container settings

<a name="synopsis"></a>

# Synopsis

```

 /etc/systemd/nspawn/machine.nspawn 
 /run/systemd/nspawn/machine.nspawn 
 /var/lib/machines/machine.nspawn
```

<a name="description"></a>

# Description


An nspawn container settings file (suffix
.nspawn) encodes additional runtime information about a local container, and is searched, read and used by
**systemd-nspawn**(1)
when starting a container. Files of this type are named after the containers they define settings for. They are optional, and only required for containers whose execution environment shall differ from the defaults. Files of this type mostly contain settings that may also be set on the
**systemd-nspawn**
command line, and make it easier to persistently attach specific settings to specific containers. The syntax of these files is inspired by
.desktop
files following the
\m[blue]**XDG Desktop Entry Specification**\m[]\s-2\u[1]\d\s+2, which in turn are inspired by Microsoft Windows
.ini
files.

Boolean arguments used in these settings files can be written in various formats. For positive settings, the strings
**1**,
**yes**,
**true**
and
**on**
are equivalent. For negative settings, the strings
**0**,
**no**,
**false**
and
**off**
are equivalent.

Empty lines and lines starting with # or ; are ignored. This may be used for commenting. Lines ending in a backslash are concatenated with the following line while reading and the backslash is replaced by a space character. This may be used to wrap long lines.

<a name="nspawn-file-discovery"></a>

# \&.Nspawn File Discovery


Files are searched by appending the
.nspawn
suffix to the machine name of the container, as specified with the
**--machine=**
switch of
**systemd-nspawn**, or derived from the directory or image file name. This file is first searched in
/etc/systemd/nspawn/
and
/run/systemd/nspawn/. If found in these directories, its settings are read and all of them take full effect (but are possibly overridden by corresponding command line arguments). If not found, the file will then be searched next to the image file or in the immediate parent of the root directory of the container. If the file is found there, only a subset of the settings will take effect however. All settings that possibly elevate privileges or grant additional access to resources of the host (such as files or directories) are ignored. To which options this applies is documented below.

Persistent settings files created and maintained by the administrator (and thus trusted) should be placed in
/etc/systemd/nspawn/, while automatically downloaded (and thus potentially untrusted) settings files are placed in
/var/lib/machines/
instead (next to the container images), where their security impact is limited. In order to add privileged settings to
.nspawn
files acquired from the image vendor, it is recommended to copy the settings files into
/etc/systemd/nspawn/
and edit them there, so that the privileged options become available. The precise algorithm for how the files are searched and interpreted may be configured with
**systemd-nspawn**s
**--settings=**
switch, see
**systemd-nspawn**(1)
for details.

<a name="exec-section-options"></a>

# [Exec] Section Options


Settings files may include an
"[Exec]"
section, which carries various execution parameters:

_Boot=_
Takes a boolean argument, which defaults to off. If enabled,
**systemd-nspawn**
will automatically search for an
init
executable and invoke it. In this case, the specified parameters using
_Parameters=_
are passed as additional arguments to the
init
process. This setting corresponds to the
**--boot**
switch on the
**systemd-nspawn**
command line. This option may not be combined with
_ProcessTwo=yes_. This option is the default if the
systemd-nspawn@.service
template unit file is used.

_Ephemeral=_
Takes a boolean argument, which defaults to off, If enabled, the container is run with a temporary snapshot of its file system that is removed immediately when the container terminates. This is equivalent to the
**--ephemeral**
command line switch. See
**systemd-nspawn**(1)
for details about the specific options supported.

_ProcessTwo=_
Takes a boolean argument, which defaults to off. If enabled, the specified program is run as PID 2. A stub init process is run as PID 1. This setting corresponds to the
**--as-pid2**
switch on the
**systemd-nspawn**
command line. This option may not be combined with
_Boot=yes_.

_Parameters=_
Takes a space-separated list of arguments. This is either a command line, beginning with the binary name to execute, or – if
_Boot=_
is enabled – the list of arguments to pass to the init process. This setting corresponds to the command line parameters passed on the
**systemd-nspawn**
command line.

_Environment=_
Takes an environment variable assignment consisting of key and value, separated by
"=". Sets an environment variable for the main process invoked in the container. This setting may be used multiple times to set multiple environment variables. It corresponds to the
**--setenv=**
command line switch.

_User=_
Takes a UNIX user name. Specifies the user name to invoke the main process of the container as. This user must be known in the containers user database. This corresponds to the
**--user=**
command line switch.

_WorkingDirectory=_
Selects the working directory for the process invoked in the container. Expects an absolute path in the containers file system namespace. This corresponds to the
**--chdir=**
command line switch.

_PivotRoot=_
Selects a directory to pivot to
/
inside the container when starting up. Takes a single path, or a pair of two paths separated by a colon. Both paths must be absolute, and are resolved in the containers file system namespace. This corresponds to the
**--pivot-root=**
command line switch.

_Capability=_, _DropCapability=_
Takes a space-separated list of Linux process capabilities (see
**capabilities**(7)
for details). The
_Capability=_
setting specifies additional capabilities to pass on top of the default set of capabilities. The
_DropCapability=_
setting specifies capabilities to drop from the default set. These settings correspond to the
**--capability=**
and
**--drop-capability=**
command line switches. Note that
_Capability=_
is a privileged setting, and only takes effect in
.nspawn
files in
/etc/systemd/nspawn/
and
/run/system/nspawn/
(see above). On the other hand,
_DropCapability=_
takes effect in all cases.

_NoNewPrivileges=_
Takes a boolean argument that controls the
**PR\_SET\_NO\_NEW\_PRIVS**
flag for the container payload. This is equivalent to the
**--no-new-privileges=**
command line switch. See
**systemd-nspawn**(1)
for details.

_KillSignal=_
Specify the process signal to send to the containers PID 1 when nspawn itself receives SIGTERM, in order to trigger an orderly shutdown of the container. Defaults to SIGRTMIN+3 if
**Boot=**
is used (on systemd-compatible init systems SIGRTMIN+3 triggers an orderly shutdown). For a list of valid signals, see
**signal**(7).

_Personality=_
Configures the kernel personality for the container. This is equivalent to the
**--personality=**
switch.

_MachineID=_
Configures the 128-bit machine ID (UUID) to pass to the container. This is equivalent to the
**--uuid=**
command line switch. This option is privileged (see above).

_PrivateUsers=_
Configures support for usernamespacing. This is equivalent to the
**--private-users=**
command line switch, and takes the same options. This option is privileged (see above). This option is the default if the
systemd-nspawn@.service
template unit file is used.

_NotifyReady=_
Configures support for notifications from the containers init process. This is equivalent to the
**--notify-ready=**
command line switch, and takes the same parameters. See
**systemd-nspawn**(1)
for details about the specific options supported.

_SystemCallFilter=_
Configures the system call filter applied to containers. This is equivalent to the
**--system-call-filter=**
command line switch, and takes the same list parameter. See
**systemd-nspawn**(1)
for details.

_LimitCPU=_, _LimitFSIZE=_, _LimitDATA=_, _LimitSTACK=_, _LimitCORE=_, _LimitRSS=_, _LimitNOFILE=_, _LimitAS=_, _LimitNPROC=_, _LimitMEMLOCK=_, _LimitLOCKS=_, _LimitSIGPENDING=_, _LimitMSGQUEUE=_, _LimitNICE=_, _LimitRTPRIO=_, _LimitRTTIME=_
Configures various types of resource limits applied to containers. This is equivalent to the
**--rlimit=**
command line switch, and takes the same arguments. See
**systemd-nspawn**(1)
for details.

_OOMScoreAdjust=_
Configures the OOM score adjustment value. This is equivalent to the
**--oom-score-adjust=**
command line switch, and takes the same argument. See
**systemd-nspawn**(1)
for details.

_CPUAffinity=_
Configures the CPU affinity. This is equivalent to the
**--cpu-affinity=**
command line switch, and takes the same argument. See
**systemd-nspawn**(1)
for details.

_Hostname=_
Configures the kernel hostname set for the container. This is equivalent to the
**--hostname=**
command line switch, and takes the same argument. See
**systemd-nspawn**(1)
for details.

_ResolvConf=_
Configures how
/etc/resolv.conf
in the container shall be handled. This is equivalent to the
**--resolv-conf=**
command line switch, and takes the same argument. See
**systemd-nspawn**(1)
for details.

_Timezone=_
Configures how
/etc/localtime
in the container shall be handled. This is equivalent to the
**--timezone=**
command line switch, and takes the same argument. See
**systemd-nspawn**(1)
for details.

_LinkJournal=_
Configures how to link host and container journal setups. This is equivalent to the
**--link-journal=**
command line switch, and takes the same parameter. See
**systemd-nspawn**(1)
for details.

<a name="files-section-options"></a>

# [Files] Section Options


Settings files may include a
"[Files]"
section, which carries various parameters configuring the file system of the container:

_ReadOnly=_
Takes a boolean argument, which defaults to off. If specified, the container will be run with a read-only file system. This setting corresponds to the
**--read-only**
command line switch.

_Volatile=_
Takes a boolean argument, or the special value
"state". This configures whether to run the container with volatile state and/or configuration. This option is equivalent to
**--volatile=**, see
**systemd-nspawn**(1)
for details about the specific options supported.

_Bind=_, _BindReadOnly=_
Adds a bind mount from the host into the container. Takes a single path, a pair of two paths separated by a colon, or a triplet of two paths plus an option string separated by colons. This option may be used multiple times to configure multiple bind mounts. This option is equivalent to the command line switches
**--bind=**
and
**--bind-ro=**, see
**systemd-nspawn**(1)
for details about the specific options supported. This setting is privileged (see above).

_TemporaryFileSystem=_
Adds a
"tmpfs"
mount to the container. Takes a path or a pair of path and option string, separated by a colon. This option may be used multiple times to configure multiple
"tmpfs"
mounts. This option is equivalent to the command line switch
**--tmpfs=**, see
**systemd-nspawn**(1)
for details about the specific options supported. This setting is privileged (see above).

_Overlay=_, _OverlayReadOnly=_
Adds an overlay mount point. Takes a colon-separated list of paths. This option may be used multiple times to configure multiple overlay mounts. This option is equivalent to the command line switches
**--overlay=**
and
**--overlay-ro=**, see
**systemd-nspawn**(1)
for details about the specific options supported. This setting is privileged (see above).

_PrivateUsersChown=_
Configures whether the ownership of the files and directories in the container tree shall be adjusted to the UID/GID range used, if necessary and user namespacing is enabled. This is equivalent to the
**--private-users-chown**
command line switch. This option is privileged (see above).

<a name="network-section-options"></a>

# [Network] Section Options


Settings files may include a
"[Network]"
section, which carries various parameters configuring the network connectivity of the container:

_Private=_
Takes a boolean argument, which defaults to off. If enabled, the container will run in its own network namespace and not share network interfaces and configuration with the host. This setting corresponds to the
**--private-network**
command line switch.

_VirtualEthernet=_
Takes a boolean argument. Configures whether to create a virtual Ethernet connection ("veth") between host and the container. This setting implies
_Private=yes_. This setting corresponds to the
**--network-veth**
command line switch. This option is privileged (see above). This option is the default if the
systemd-nspawn@.service
template unit file is used.

_VirtualEthernetExtra=_
Takes a colon-separated pair of interface names. Configures an additional virtual Ethernet connection ("veth") between host and the container. The first specified name is the interface name on the host, the second the interface name in the container. The latter may be omitted in which case it is set to the same name as the host side interface. This setting implies
_Private=yes_. This setting corresponds to the
**--network-veth-extra=**
command line switch, and maybe be used multiple times. It is independent of
_VirtualEthernet=_. This option is privileged (see above).

_Interface=_
Takes a space-separated list of interfaces to add to the container. This option corresponds to the
**--network-interface=**
command line switch and implies
_Private=yes_. This option is privileged (see above).

_MACVLAN=_, _IPVLAN=_
Takes a space-separated list of interfaces to add MACLVAN or IPVLAN interfaces to, which are then added to the container. These options correspond to the
**--network-macvlan=**
and
**--network-ipvlan=**
command line switches and imply
_Private=yes_. These options are privileged (see above).

_Bridge=_
Takes an interface name. This setting implies
_VirtualEthernet=yes_
and
_Private=yes_
and has the effect that the host side of the created virtual Ethernet link is connected to the specified bridge interface. This option corresponds to the
**--network-bridge=**
command line switch. This option is privileged (see above).

_Zone=_
Takes a network zone name. This setting implies
_VirtualEthernet=yes_
and
_Private=yes_
and has the effect that the host side of the created virtual Ethernet link is connected to an automatically managed bridge interface named after the passed argument, prefixed with
"vz-". This option corresponds to the
**--network-zone=**
command line switch. This option is privileged (see above).

_Port=_
Exposes a TCP or UDP port of the container on the host. This option corresponds to the
**--port=**
command line switch, see
**systemd-nspawn**(1)
for the precise syntax of the argument this option takes. This option is privileged (see above).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-nspawn**(1),
**systemd.directives**(7)

<a name="notes"></a>

# Notes


*  1.  
  XDG Desktop Entry Specification
      http://standards.freedesktop.org/desktop-entry-spec/latest/
