# systemd\&.service(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.service - Service unit configuration

<a name="synopsis"></a>

# Synopsis

```

 service.service
```

<a name="description"></a>

# Description


A unit configuration file whose name ends in
".service"
encodes information about a process controlled and supervised by systemd.

This man page lists the configuration options specific to this unit type. See
**systemd.unit**(5)
for the common options of all unit configuration files. The common configuration items are configured in the generic
"[Unit]"
and
"[Install]"
sections. The service specific configuration options are configured in the
"[Service]"
section.

Additional options are listed in
**systemd.exec**(5), which define the execution environment the commands are executed in, and in
**systemd.kill**(5), which define the way the processes of the service are terminated, and in
**systemd.resource-control**(5), which configure resource control settings for the processes of the service.

If a service is requested under a certain name but no unit configuration file is found, systemd looks for a SysV init script by the same name (with the
.service
suffix removed) and dynamically creates a service unit from that script. This is useful for compatibility with SysV. Note that this compatibility is quite comprehensive but not 100%. For details about the incompatibilities, see the
\m[blue]**Incompatibilities with SysV**\m[]\s-2\u[1]\d\s+2
document.

<a name="service-templates"></a>

# Service Templates


It is possible for
**systemd**
services to take a single argument via the
"_service_@_argument_.service"
syntax. Such services are called "instantiated" services, while the unit definition without the
_argument_
parameter is called a "template". An example could be a
dhcpcd@.service
service template which takes a network interface as a parameter to form an instantiated service. Within the service file, this parameter or "instance name" can be accessed with %-specifiers. See
**systemd.unit**(5)
for details.

<a name="automatic-dependencies"></a>

# Automatic Dependencies


<a name="implicit-dependencies"></a>

### Implicit Dependencies


The following dependencies are implicitly added:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Services with
  _Type=dbus_
  set automatically acquire dependencies of type
  _Requires=_
  and
  _After=_
  on
  dbus.socket.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Socket activated services are automatically ordered after their activating
  .socket
  units via an automatic
  _After=_
  dependency. Services also pull in all
  .socket
  units listed in
  _Sockets=_
  via automatic
  _Wants=_
  and
  _After=_
  dependencies.

Additional implicit dependencies may be added as result of execution and resource control parameters as documented in
**systemd.exec**(5)
and
**systemd.resource-control**(5).

<a name="default-dependencies"></a>

### Default Dependencies


The following dependencies are added unless
_DefaultDependencies=no_
is set:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Service units will have dependencies of type
  _Requires=_
  and
  _After=_
  on
  sysinit.target, a dependency of type
  _After=_
  on
  basic.target
  as well as dependencies of type
  _Conflicts=_
  and
  _Before=_
  on
  shutdown.target. These ensure that normal service units pull in basic system initialization, and are terminated cleanly prior to system shutdown. Only services involved with early boot or late system shutdown should disable this option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Instanced service units (i.e. service units with an
  "@"
  in their name) are assigned by default a per-template slice unit (see
  **systemd.slice**(5)), named after the template unit, containing all instances of the specific template. This slice is normally stopped at shutdown, together with all template instances. If that is not desired, set
  _DefaultDependencies=no_
  in the template unit, and either define your own per-template slice unit file that also sets
  _DefaultDependencies=no_, or set
  _Slice=system.slice_
  (or another suitable slice) in the template unit. Also see
  **systemd.resource-control**(5).

<a name="options"></a>

# Options


Service files must include a
"[Service]"
section, which carries information about the service and the process it supervises. A number of options that may be used in this section are shared with other unit types. These options are documented in
**systemd.exec**(5),
**systemd.kill**(5)
and
**systemd.resource-control**(5). The options specific to the
"[Service]"
section of service units are the following:

_Type=_
Configures the process start-up type for this service unit. One of
**simple**,
**exec**,
**forking**,
**oneshot**,
**dbus**,
**notify**
or
**idle**:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If set to
  **simple**
  (the default if
  _ExecStart=_
  is specified but neither
  _Type=_
  nor
  _BusName=_
  are), the service manager will consider the unit started immediately after the main service process has been forked off. It is expected that the process configured with
  _ExecStart=_
  is the main process of the service. In this mode, if the process offers functionality to other processes on the system, its communication channels should be installed before the service is started up (e.g. sockets set up by systemd, via socket activation), as the service manager will immediately proceed starting follow-up units, right after creating the main service process, and before executing the services binary. Note that this means
  **systemctl start**
  command lines for
  **simple**
  services will report success even if the services binary cannot be invoked successfully (for example because the selected
  _User=_
  doesnt exist, or the service binary is missing).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The
  **exec**
  type is similar to
  **simple**, but the service manager will consider the unit started immediately after the main service binary has been executed. The service manager will delay starting of follow-up units until that point. (Or in other words:
  **simple**
  proceeds with further jobs right after
  **fork()**
  returns, while
  **exec**
  will not proceed before both
  **fork()**
  and
  **execve()**
  in the service process succeeded.) Note that this means
  **systemctl start**
  command lines for
  **exec**
  services will report failure when the services binary cannot be invoked successfully (for example because the selected
  _User=_
  doesnt exist, or the service binary is missing).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If set to
  **forking**, it is expected that the process configured with
  _ExecStart=_
  will call
  **fork()**
  as part of its start-up. The parent process is expected to exit when start-up is complete and all communication channels are set up. The child continues to run as the main service process, and the service manager will consider the unit started when the parent process exits. This is the behavior of traditional UNIX services. If this setting is used, it is recommended to also use the
  _PIDFile=_
  option, so that systemd can reliably identify the main process of the service. systemd will proceed with starting follow-up units as soon as the parent process exits.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Behavior of
  **oneshot**
  is similar to
  **simple**; however, the service manager will consider the unit up after the main process exits. It will then start follow-up units.
  _RemainAfterExit=_
  is particularly useful for this type of service.
  _Type=_**oneshot**
  is the implied default if neither
  _Type=_
  nor
  _ExecStart=_
  are specified. Note that if this option is used without
  _RemainAfterExit=_
  the service will never enter
  "active"
  unit state, but directly transition from
  "activating"
  to
  "deactivating"
  or
  "dead"
  since no process is configured that shall run continously. In particular this means that after a service of this type ran (and which has
  _RemainAfterExit=_
  not set) it will not show up as started afterwards, but as dead.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Behavior of
  **dbus**
  is similar to
  **simple**; however, it is expected that the service acquires a name on the D-Bus bus, as configured by
  _BusName=_. systemd will proceed with starting follow-up units after the D-Bus bus name has been acquired. Service units with this option configured implicitly gain dependencies on the
  dbus.socket
  unit. This type is the default if
  _BusName=_
  is specified.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Behavior of
  **notify**
  is similar to
  **exec**; however, it is expected that the service sends a notification message via
  **sd\_notify**(3)
  or an equivalent call when it has finished starting up. systemd will proceed with starting follow-up units after this notification message has been sent. If this option is used,
  _NotifyAccess=_
  (see below) should be set to open access to the notification socket provided by systemd. If
  _NotifyAccess=_
  is missing or set to
  **none**, it will be forcibly set to
  **main**. Note that currently
  _Type=_**notify**
  will not work if used in combination with
  _PrivateNetwork=_**yes**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Behavior of
  **idle**
  is very similar to
  **simple**; however, actual execution of the service program is delayed until all active jobs are dispatched. This may be used to avoid interleaving of output of shell services with the status output on the console. Note that this type is useful only to improve console output, it is not useful as a general unit ordering tool, and the effect of this service type is subject to a 5s timeout, after which the service program is invoked anyway.

It is generally recommended to use
_Type=_**simple**
for long-running services whenever possible, as it is the simplest and fastest option. However, as this service type wont propagate service start-up failures and doesn\*(Aqt allow ordering of other units against completion of initialization of the service (which for example is useful if clients need to connect to the service through some form of IPC, and the IPC channel is only established by the service itself — in contrast to doing this ahead of time through socket or bus activation or similar), it might not be sufficient for many cases. If so,
**notify**
or
**dbus**
(the latter only in case the service provides a D-Bus interface) are the preferred options as they allow service program code to precisely schedule when to consider the service started up successfully and when to proceed with follow-up units. The
**notify**
service type requires explicit support in the service codebase (as
**sd\_notify()**
or an equivalent API needs to be invoked by the service at the appropriate time) — if its not supported, then
**forking**
is an alternative: it supports the traditional UNIX service start-up protocol. Finally,
**exec**
might be an option for cases where it is enough to ensure the service binary is invoked, and where the service binary itself executes no or little initialization on its own (and its initialization is unlikely to fail). Note that using any type other than
**simple**
possibly delays the boot process, as the service manager needs to wait for service initialization to complete. It is hence recommended not to needlessly use any types other than
**simple**. (Also note it is generally not recommended to use
**idle**
or
**oneshot**
for long-running services.)

_RemainAfterExit=_
Takes a boolean value that specifies whether the service shall be considered active even when all its processes exited. Defaults to
**no**.

_GuessMainPID=_
Takes a boolean value that specifies whether systemd should try to guess the main PID of a service if it cannot be determined reliably. This option is ignored unless
**Type=forking**
is set and
**PIDFile=**
is unset because for the other types or with an explicitly configured PID file, the main PID is always known. The guessing algorithm might come to incorrect conclusions if a daemon consists of more than one process. If the main PID cannot be determined, failure detection and automatic restarting of a service will not work reliably. Defaults to
**yes**.

_PIDFile=_
Takes a path referring to the PID file of the service. Usage of this option is recommended for services where
_Type=_
is set to
**forking**. The path specified typically points to a file below
/run/. If a relative path is specified it is hence prefixed with
/run/. The service manager will read the PID of the main process of the service from this file after start-up of the service. The service manager will not write to the file configured here, although it will remove the file after the service has shut down if it still exists. The PID file does not need to be owned by a privileged user, but if it is owned by an unprivileged user additional safety restrictions are enforced: the file may not be a symlink to a file owned by a different user (neither directly nor indirectly), and the PID file must refer to a process already belonging to the service.

_BusName=_
Takes a D-Bus bus name that this service is reachable as. This option is mandatory for services where
_Type=_
is set to
**dbus**.

_ExecStart=_
Commands with their arguments that are executed when this service is started. The value is split into zero or more command lines according to the rules described below (see section "Command Lines" below).

Unless
_Type=_
is
**oneshot**, exactly one command must be given. When
_Type=oneshot_
is used, zero or more commands may be specified. Commands may be specified by providing multiple command lines in the same directive, or alternatively, this directive may be specified more than once with the same effect. If the empty string is assigned to this option, the list of commands to start is reset, prior assignments of this option will have no effect. If no
_ExecStart=_
is specified, then the service must have
_RemainAfterExit=yes_
and at least one
_ExecStop=_
line set. (Services lacking both
_ExecStart=_
and
_ExecStop=_
are not valid.)

For each of the specified commands, the first argument must be either an absolute path to an executable or a simple file name without any slashes. Optionally, this filename may be prefixed with a number of special characters:

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;1.&nbsp;Special executable prefixes**
.TS
allbox tab(:);
lB lB.
T{
Prefix
T}:T{
Effect
T}
.T&
l l
l l
l l
l l
l l.
T{
"@"
T}:T{
If the executable path is prefixed with "@", the second specified token will be passed as "argv[0]" to the executed process (instead of the actual filename), followed by the further arguments specified.
T}
T{
"-"
T}:T{
If the executable path is prefixed with "-", an exit code of the command normally considered a failure (i.e. non-zero exit status or abnormal exit due to signal) is recorded, but has no further effect and is considered equivalent to success.
T}
T{
"+"
T}:T{
If the executable path is prefixed with "+" then the process is executed with full privileges. In this mode privilege restrictions configured with _User=_, _Group=_, _CapabilityBoundingSet=_ or the various file system namespacing options (such as _PrivateDevices=_, _PrivateTmp=_) are not applied to the invoked command line (but still affect any other _ExecStart=_, _ExecStop=_, ... lines).
T}
T{
"!"
T}:T{
Similar to the "+" character discussed above this permits invoking command lines with elevated privileges. However, unlike "+" the "!" character exclusively alters the effect of _User=_, _Group=_ and _SupplementaryGroups=_, i.e. only the stanzas that affect user and group credentials. Note that this setting may be combined with _DynamicUser=_, in which case a dynamic user/group pair is allocated before the command is invoked, but credential changing is left to the executed process itself.
T}
T{
"!!"
T}:T{
This prefix is very similar to "!", however it only has an effect on systems lacking support for ambient process capabilities, i.e. without support for _AmbientCapabilities=_. Its intended to be used for unit files that take benefit of ambient capabilities to run processes with minimal privileges wherever possible while remaining compatible with systems that lack ambient capabilities support. Note that when "!!" is used, and a system lacking ambient capability support is detected any configured _SystemCallFilter=_ and _CapabilityBoundingSet=_ stanzas are implicitly modified, in order to permit spawned processes to drop credentials and capabilities themselves, even if this is configured to not be allowed. Moreover, if this prefix is used and a system lacking ambient capability support is detected _AmbientCapabilities=_ will be skipped and not be applied. On systems supporting ambient capabilities, "!!" has no effect and is redundant.
T}
.TE

"@",
"-", and one of
"+"/"!"/"!!"
may be used together and they can appear in any order. However, only one of
"+",
"!",
"!!"
may be used at a time. Note that these prefixes are also supported for the other command line settings, i.e.
_ExecStartPre=_,
_ExecStartPost=_,
_ExecReload=_,
_ExecStop=_
and
_ExecStopPost=_.

If more than one command is specified, the commands are invoked sequentially in the order they appear in the unit file. If one of the commands fails (and is not prefixed with
"-"), other lines are not executed, and the unit is considered failed.

Unless
_Type=forking_
is set, the process started via this command line will be considered the main process of the daemon.

_ExecStartPre=_, _ExecStartPost=_
Additional commands that are executed before or after the command in
_ExecStart=_, respectively. Syntax is the same as for
_ExecStart=_, except that multiple command lines are allowed and the commands are executed one after the other, serially.

If any of those commands (not prefixed with
"-") fail, the rest are not executed and the unit is considered failed.

_ExecStart=_
commands are only run after all
_ExecStartPre=_
commands that were not prefixed with a
"-"
exit successfully.

_ExecStartPost=_
commands are only run after the commands specified in
_ExecStart=_
have been invoked successfully, as determined by
_Type=_
(i.e. the process has been started for
_Type=simple_
or
_Type=idle_, the last
_ExecStart=_
process exited successfully for
_Type=oneshot_, the initial process exited successfully for
_Type=forking_,
"READY=1"
is sent for
_Type=notify_, or the
_BusName=_
has been taken for
_Type=dbus_).

Note that
_ExecStartPre=_
may not be used to start long-running processes. All processes forked off by processes invoked via
_ExecStartPre=_
will be killed before the next service process is run.

Note that if any of the commands specified in
_ExecStartPre=_,
_ExecStart=_, or
_ExecStartPost=_
fail (and are not prefixed with
"-", see above) or time out before the service is fully up, execution continues with commands specified in
_ExecStopPost=_, the commands in
_ExecStop=_
are skipped.

_ExecReload=_
Commands to execute to trigger a configuration reload in the service. This argument takes multiple command lines, following the same scheme as described for
_ExecStart=_
above. Use of this setting is optional. Specifier and environment variable substitution is supported here following the same scheme as for
_ExecStart=_.

One additional, special environment variable is set: if known,
_$MAINPID_
is set to the main process of the daemon, and may be used for command lines like the following:

.if n \{.RS 4
.\}
    /bin/kill -HUP $MAINPID
.if n \{.RE
.\}

Note however that reloading a daemon by sending a signal (as with the example line above) is usually not a good choice, because this is an asynchronous operation and hence not suitable to order reloads of multiple services against each other. It is strongly recommended to set
_ExecReload=_
to a command that not only triggers a configuration reload of the daemon, but also synchronously waits for it to complete.

_ExecStop=_
Commands to execute to stop the service started via
_ExecStart=_. This argument takes multiple command lines, following the same scheme as described for
_ExecStart=_
above. Use of this setting is optional. After the commands configured in this option are run, it is implied that the service is stopped, and any processes remaining for it are terminated according to the
_KillMode=_
setting (see
**systemd.kill**(5)). If this option is not specified, the process is terminated by sending the signal specified in
_KillSignal=_
when service stop is requested. Specifier and environment variable substitution is supported (including
_$MAINPID_, see above).

Note that it is usually not sufficient to specify a command for this setting that only asks the service to terminate (for example, by queuing some form of termination signal for it), but does not wait for it to do so. Since the remaining processes of the services are killed according to
_KillMode=_
and
_KillSignal=_
as described above immediately after the command exited, this may not result in a clean stop. The specified command should hence be a synchronous operation, not an asynchronous one.

Note that the commands specified in
_ExecStop=_
are only executed when the service started successfully first. They are not invoked if the service was never started at all, or in case its start-up failed, for example because any of the commands specified in
_ExecStart=_,
_ExecStartPre=_
or
_ExecStartPost=_
failed (and werent prefixed with
"-", see above) or timed out. Use
_ExecStopPost=_
to invoke commands when a service failed to start up correctly and is shut down again. Also note that the stop operation is always performed if the service started successfully, even if the processes in the service terminated on their own or were killed. The stop commands must be prepared to deal with that case.
_$MAINPID_
will be unset if systemd knows that the main process exited by the time the stop commands are called.

Service restart requests are implemented as stop operations followed by start operations. This means that
_ExecStop=_
and
_ExecStopPost=_
are executed during a service restart operation.

It is recommended to use this setting for commands that communicate with the service requesting clean termination. For post-mortem clean-up steps use
_ExecStopPost=_
instead.

_ExecStopPost=_
Additional commands that are executed after the service is stopped. This includes cases where the commands configured in
_ExecStop=_
were used, where the service does not have any
_ExecStop=_
defined, or where the service exited unexpectedly. This argument takes multiple command lines, following the same scheme as described for
_ExecStart=_. Use of these settings is optional. Specifier and environment variable substitution is supported. Note that – unlike
_ExecStop=_
– commands specified with this setting are invoked when a service failed to start up correctly and is shut down again.

It is recommended to use this setting for clean-up operations that shall be executed even when the service failed to start up correctly. Commands configured with this setting need to be able to operate even if the service failed starting up half-way and left incompletely initialized data around. As the services processes have been terminated already when the commands specified with this setting are executed they should not attempt to communicate with them.

Note that all commands that are configured with this setting are invoked with the result code of the service, as well as the main process exit code and status, set in the
_$SERVICE\_RESULT_,
_$EXIT\_CODE_
and
_$EXIT\_STATUS_
environment variables, see
**systemd.exec**(5)
for details.

_RestartSec=_
Configures the time to sleep before restarting a service (as configured with
_Restart=_). Takes a unit-less value in seconds, or a time span value such as "5min 20s". Defaults to 100ms.

_TimeoutStartSec=_
Configures the time to wait for start-up. If a daemon service does not signal start-up completion within the configured time, the service will be considered failed and will be shut down again. Takes a unit-less value in seconds, or a time span value such as "5min 20s". Pass
"infinity"
to disable the timeout logic. Defaults to
_DefaultTimeoutStartSec=_
from the manager configuration file, except when
_Type=oneshot_
is used, in which case the timeout is disabled by default (see
**systemd-system.conf**(5)).

If a service of
_Type=notify_
sends
"EXTEND_TIMEOUT_USEC=...", this may cause the start time to be extended beyond
_TimeoutStartSec=_. The first receipt of this message must occur before
_TimeoutStartSec=_
is exceeded, and once the start time has exended beyond
_TimeoutStartSec=_, the service manager will allow the service to continue to start, provided the service repeats
"EXTEND_TIMEOUT_USEC=..."
within the interval specified until the service startup status is finished by
"READY=1". (see
**sd\_notify**(3)).

_TimeoutStopSec=_
This option serves two purposes. First, it configures the time to wait for each
**ExecStop=**
command. If any of them times out, subsequent
**ExecStop=**
commands are skipped and the service will be terminated by
**SIGTERM**. If no
**ExecStop=**
commands are specified, the service gets the
**SIGTERM**
immediately. Second, it configures the time to wait for the service itself to stop. If it doesnt terminate in the specified time, it will be forcibly terminated by
**SIGKILL**
(see
_KillMode=_
in
**systemd.kill**(5)). Takes a unit-less value in seconds, or a time span value such as "5min 20s". Pass
"infinity"
to disable the timeout logic. Defaults to
_DefaultTimeoutStopSec=_
from the manager configuration file (see
**systemd-system.conf**(5)).

If a service of
_Type=notify_
sends
"EXTEND_TIMEOUT_USEC=...", this may cause the stop time to be extended beyond
_TimeoutStopSec=_. The first receipt of this message must occur before
_TimeoutStopSec=_
is exceeded, and once the stop time has exended beyond
_TimeoutStopSec=_, the service manager will allow the service to continue to stop, provided the service repeats
"EXTEND_TIMEOUT_USEC=..."
within the interval specified, or terminates itself (see
**sd\_notify**(3)).

_TimeoutSec=_
A shorthand for configuring both
_TimeoutStartSec=_
and
_TimeoutStopSec=_
to the specified value.

_RuntimeMaxSec=_
Configures a maximum time for the service to run. If this is used and the service has been active for longer than the specified time it is terminated and put into a failure state. Note that this setting does not have any effect on
_Type=oneshot_
services, as they terminate immediately after activation completed. Pass
"infinity"
(the default) to configure no runtime limit.

If a service of
_Type=notify_
sends
"EXTEND_TIMEOUT_USEC=...", this may cause the runtime to be extended beyond
_RuntimeMaxSec=_. The first receipt of this message must occur before
_RuntimeMaxSec=_
is exceeded, and once the runtime has exended beyond
_RuntimeMaxSec=_, the service manager will allow the service to continue to run, provided the service repeats
"EXTEND_TIMEOUT_USEC=..."
within the interval specified until the service shutdown is achieved by
"STOPPING=1"
(or termination). (see
**sd\_notify**(3)).

_WatchdogSec=_
Configures the watchdog timeout for a service. The watchdog is activated when the start-up is completed. The service must call
**sd\_notify**(3)
regularly with
"WATCHDOG=1"
(i.e. the "keep-alive ping"). If the time between two such calls is larger than the configured time, then the service is placed in a failed state and it will be terminated with
**SIGABRT**
(or the signal specified by
_WatchdogSignal=_). By setting
_Restart=_
to
**on-failure**,
**on-watchdog**,
**on-abnormal**
or
**always**, the service will be automatically restarted. The time configured here will be passed to the executed service process in the
_WATCHDOG\_USEC=_
environment variable. This allows daemons to automatically enable the keep-alive pinging logic if watchdog support is enabled for the service. If this option is used,
_NotifyAccess=_
(see below) should be set to open access to the notification socket provided by systemd. If
_NotifyAccess=_
is not set, it will be implicitly set to
**main**. Defaults to 0, which disables this feature. The service can check whether the service manager expects watchdog keep-alive notifications. See
**sd\_watchdog\_enabled**(3)
for details.
**sd\_event\_set\_watchdog**(3)
may be used to enable automatic watchdog notification support.

_Restart=_
Configures whether the service shall be restarted when the service process exits, is killed, or a timeout is reached. The service process may be the main service process, but it may also be one of the processes specified with
_ExecStartPre=_,
_ExecStartPost=_,
_ExecStop=_,
_ExecStopPost=_, or
_ExecReload=_. When the death of the process is a result of systemd operation (e.g. service stop or restart), the service will not be restarted. Timeouts include missing the watchdog "keep-alive ping" deadline and a service start, reload, and stop operation timeouts.

Takes one of
**no**,
**on-success**,
**on-failure**,
**on-abnormal**,
**on-watchdog**,
**on-abort**, or
**always**. If set to
**no**
(the default), the service will not be restarted. If set to
**on-success**, it will be restarted only when the service process exits cleanly. In this context, a clean exit means an exit code of 0, or one of the signals
**SIGHUP**,
**SIGINT**,
**SIGTERM**
or
**SIGPIPE**, and additionally, exit statuses and signals specified in
_SuccessExitStatus=_. If set to
**on-failure**, the service will be restarted when the process exits with a non-zero exit code, is terminated by a signal (including on core dump, but excluding the aforementioned four signals), when an operation (such as service reload) times out, and when the configured watchdog timeout is triggered. If set to
**on-abnormal**, the service will be restarted when the process is terminated by a signal (including on core dump, excluding the aforementioned four signals), when an operation times out, or when the watchdog timeout is triggered. If set to
**on-abort**, the service will be restarted only if the service process exits due to an uncaught signal not specified as a clean exit status. If set to
**on-watchdog**, the service will be restarted only if the watchdog timeout for the service expires. If set to
**always**, the service will be restarted regardless of whether it exited cleanly or not, got terminated abnormally by a signal, or hit a timeout.

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;2.&nbsp;Exit causes and the effect of the _Restart=_ settings on them**
.TS
allbox tab(:);
lB lB lB lB lB lB lB lB.
T{
Restart settings/Exit causes
T}:T{
**no**
T}:T{
**always**
T}:T{
**on-success**
T}:T{
**on-failure**
T}:T{
**on-abnormal**
T}:T{
**on-abort**
T}:T{
**on-watchdog**
T}
.T&
l l l l l l l l
l l l l l l l l
l l l l l l l l
l l l l l l l l
l l l l l l l l.
T{
Clean exit code or signal
T}:T{
&nbsp;T}:T{
X
T}:T{
X
T}:T{
&nbsp;T}:T{
&nbsp;T}:T{
&nbsp;T}:T{
&nbsp;T}
T{
Unclean exit code
T}:T{
&nbsp;T}:T{
X
T}:T{
&nbsp;T}:T{
X
T}:T{
&nbsp;T}:T{
&nbsp;T}:T{
&nbsp;T}
T{
Unclean signal
T}:T{
&nbsp;T}:T{
X
T}:T{
&nbsp;T}:T{
X
T}:T{
X
T}:T{
X
T}:T{
&nbsp;T}
T{
Timeout
T}:T{
&nbsp;T}:T{
X
T}:T{
&nbsp;T}:T{
X
T}:T{
X
T}:T{
&nbsp;T}:T{
&nbsp;T}
T{
Watchdog
T}:T{
&nbsp;T}:T{
X
T}:T{
&nbsp;T}:T{
X
T}:T{
X
T}:T{
&nbsp;T}:T{
X
T}
.TE

As exceptions to the setting above, the service will not be restarted if the exit code or signal is specified in
_RestartPreventExitStatus=_
(see below) or the service is stopped with
**systemctl stop**
or an equivalent operation. Also, the services will always be restarted if the exit code or signal is specified in
_RestartForceExitStatus=_
(see below).

Note that service restart is subject to unit start rate limiting configured with
_StartLimitIntervalSec=_
and
_StartLimitBurst=_, see
**systemd.unit**(5)
for details. A restarted service enters the failed state only after the start limits are reached.

Setting this to
**on-failure**
is the recommended choice for long-running services, in order to increase reliability by attempting automatic recovery from errors. For services that shall be able to terminate on their own choice (and avoid immediate restarting),
**on-abnormal**
is an alternative choice.

_SuccessExitStatus=_
Takes a list of exit status definitions that, when returned by the main service process, will be considered successful termination, in addition to the normal successful exit code 0 and the signals
**SIGHUP**,
**SIGINT**,
**SIGTERM**, and
**SIGPIPE**. Exit status definitions can either be numeric exit codes or termination signal names, separated by spaces. For example:

.if n \{.RS 4
.\}
    SuccessExitStatus=1 2 8 SIGKILL
.if n \{.RE
.\}

ensures that exit codes 1, 2, 8 and the termination signal
**SIGKILL**
are considered clean service terminations.

This option may appear more than once, in which case the list of successful exit statuses is merged. If the empty string is assigned to this option, the list is reset, all prior assignments of this option will have no effect.

_RestartPreventExitStatus=_
Takes a list of exit status definitions that, when returned by the main service process, will prevent automatic service restarts, regardless of the restart setting configured with
_Restart=_. Exit status definitions can either be numeric exit codes or termination signal names, and are separated by spaces. Defaults to the empty list, so that, by default, no exit status is excluded from the configured restart logic. For example:

.if n \{.RS 4
.\}
    RestartPreventExitStatus=1 6 SIGABRT
.if n \{.RE
.\}

ensures that exit codes 1 and 6 and the termination signal
**SIGABRT**
will not result in automatic service restarting. This option may appear more than once, in which case the list of restart-preventing statuses is merged. If the empty string is assigned to this option, the list is reset and all prior assignments of this option will have no effect.

Note that this setting has no effect on processes configured via
_ExecStartPre=_,
_ExecStartPost=_,
_ExecStop=_,
_ExecStopPost=_
or
_ExecReload=_, but only on the main service process, i.e. either the one invoked by
_ExecStart=_
or (depending on
_Type=_,
_PIDFile=_, ...) the otherwise configured main process.

_RestartForceExitStatus=_
Takes a list of exit status definitions that, when returned by the main service process, will force automatic service restarts, regardless of the restart setting configured with
_Restart=_. The argument format is similar to
_RestartPreventExitStatus=_.

_RootDirectoryStartOnly=_
Takes a boolean argument. If true, the root directory, as configured with the
_RootDirectory=_
option (see
**systemd.exec**(5)
for more information), is only applied to the process started with
_ExecStart=_, and not to the various other
_ExecStartPre=_,
_ExecStartPost=_,
_ExecReload=_,
_ExecStop=_, and
_ExecStopPost=_
commands. If false, the setting is applied to all configured commands the same way. Defaults to false.

_NonBlocking=_
Set the
**O\_NONBLOCK**
flag for all file descriptors passed via socket-based activation. If true, all file descriptors &gt;= 3 (i.e. all except stdin, stdout, stderr), excluding those passed in via the file descriptor storage logic (see
_FileDescriptorStoreMax=_
for details), will have the
**O\_NONBLOCK**
flag set and hence are in non-blocking mode. This option is only useful in conjunction with a socket unit, as described in
**systemd.socket**(5)
and has no effect on file descriptors which were previously saved in the file-descriptor store for example. Defaults to false.

_NotifyAccess=_
Controls access to the service status notification socket, as accessible via the
**sd\_notify**(3)
call. Takes one of
**none**
(the default),
**main**,
**exec**
or
**all**. If
**none**, no daemon status updates are accepted from the service processes, all status update messages are ignored. If
**main**, only service updates sent from the main process of the service are accepted. If
**exec**, only service updates sent from any of the main or control processes originating from one of the
_Exec*=_
commands are accepted. If
**all**, all services updates from all members of the services control group are accepted. This option should be set to open access to the notification socket when using
_Type=notify_
or
_WatchdogSec=_
(see above). If those options are used but
_NotifyAccess=_
is not configured, it will be implicitly set to
**main**.

Note that
**sd\_notify()**
notifications may be attributed to units correctly only if either the sending process is still around at the time PID 1 processes the message, or if the sending process is explicitly runtime-tracked by the service manager. The latter is the case if the service manager originally forked off the process, i.e. on all processes that match
**main**
or
**exec**. Conversely, if an auxiliary process of the unit sends an
**sd\_notify()**
message and immediately exits, the service manager might not be able to properly attribute the message to the unit, and thus will ignore it, even if
_NotifyAccess=_**all**
is set for it.

_Sockets=_
Specifies the name of the socket units this service shall inherit socket file descriptors from when the service is started. Normally, it should not be necessary to use this setting, as all socket file descriptors whose unit shares the same name as the service (subject to the different unit name suffix of course) are passed to the spawned process.

Note that the same socket file descriptors may be passed to multiple processes simultaneously. Also note that a different service may be activated on incoming socket traffic than the one which is ultimately configured to inherit the socket file descriptors. Or, in other words: the
_Service=_
setting of
.socket
units does not have to match the inverse of the
_Sockets=_
setting of the
.service
it refers to.

This option may appear more than once, in which case the list of socket units is merged. If the empty string is assigned to this option, the list of sockets is reset, and all prior uses of this setting will have no effect.

_FileDescriptorStoreMax=_
Configure how many file descriptors may be stored in the service manager for the service using
**sd\_pid\_notify\_with\_fds**(3)s
"FDSTORE=1"
messages. This is useful for implementing services that can restart after an explicit request or a crash without losing state. Any open sockets and other file descriptors which should not be closed during the restart may be stored this way. Application state can either be serialized to a file in
/run, or better, stored in a
**memfd\_create**(2)
memory file descriptor. Defaults to 0, i.e. no file descriptors may be stored in the service manager. All file descriptors passed to the service manager from a specific service are passed back to the services main process on the next service restart. Any file descriptors passed to the service manager are automatically closed when
**POLLHUP**
or
**POLLERR**
is seen on them, or when the service is fully stopped and no job is queued or being executed for it. If this option is used,
_NotifyAccess=_
(see above) should be set to open access to the notification socket provided by systemd. If
_NotifyAccess=_
is not set, it will be implicitly set to
**main**.

_USBFunctionDescriptors=_
Configure the location of a file containing
\m[blue]**USB FunctionFS**\m[]\s-2\u[2]\d\s+2
descriptors, for implementation of USB gadget functions. This is used only in conjunction with a socket unit with
_ListenUSBFunction=_
configured. The contents of this file are written to the
ep0
file after it is opened.

_USBFunctionStrings=_
Configure the location of a file containing USB FunctionFS strings. Behavior is similar to
_USBFunctionDescriptors=_
above.

Check
**systemd.exec**(5)
and
**systemd.kill**(5)
for more settings.

<a name="command-lines"></a>

# Command Lines


This section describes command line parsing and variable and specifier substitutions for
_ExecStart=_,
_ExecStartPre=_,
_ExecStartPost=_,
_ExecReload=_,
_ExecStop=_, and
_ExecStopPost=_
options.

Multiple command lines may be concatenated in a single directive by separating them with semicolons (these semicolons must be passed as separate words). Lone semicolons may be escaped as
"\e;".

Each command line is split on whitespace, with the first item being the command to execute, and the subsequent items being the arguments. Double quotes ("...") and single quotes (...\*(Aq) may be used to wrap a whole item (the opening quote may appear only at the beginning or after whitespace that is not quoted, and the closing quote must be followed by whitespace or the end of line), in which case everything until the next matching quote becomes part of the same argument. Quotes themselves are removed. C-style escapes are also supported. The table below contains the list of known escape patterns. Only escape patterns which match the syntax in the table are allowed; other patterns may be added in the future and unknown patterns will result in a warning. In particular, any backslashes should be doubled. Finally, a trailing backslash ("\e") may be used to merge lines.

This syntax is inspired by shell syntax, but only the meta-characters and expansions described in the following paragraphs are understood, and the expansion of variables is different. Specifically, redirection using
"&lt;",
"&lt;&lt;",
"&gt;", and
"&gt;&gt;", pipes using
"|", running programs in the background using
"&", and
_other elements of shell syntax are not supported_.

The command to execute may contain spaces, but control characters are not allowed.

The command line accepts
"%"
specifiers as described in
**systemd.unit**(5).

Basic environment variable substitution is supported. Use
"${FOO}"
as part of a word, or as a word of its own, on the command line, in which case it will be replaced by the value of the environment variable including all whitespace it contains, resulting in a single argument. Use
"$FOO"
as a separate word on the command line, in which case it will be replaced by the value of the environment variable split at whitespace, resulting in zero or more arguments. For this type of expansion, quotes are respected when splitting into words, and afterwards removed.

If the command is not a full (absolute) path, it will be resolved to a full path using a fixed search path determinted at compilation time. Searched directories include
/usr/local/bin/,
/usr/bin/,
/bin/
on systems using split
/usr/bin/
and
/bin/
directories, and their
sbin/
counterparts on systems using split
bin/
and
sbin/. It is thus safe to use just the executable name in case of executables located in any of the "standard" directories, and an absolute path must be used in other cases. Using an absolute path is recommended to avoid ambiguity. Hint: this search path may be queried using
**systemd-path search-binaries-default**.

Example:

.if n \{.RS 4
.\}
    Environment="ONE=one" TWO=two two*(Aq
    ExecStart=echo $ONE $TWO ${TWO}
.if n \{.RE
.\}

This will execute
**/bin/echo**
with four arguments:
"one",
"two",
"two", and
"two two".

Example:

.if n \{.RS 4
.\}
    Environment=ONE=one*(Aq "TWO=*(Aqtwo&nbsp;two*(Aq&nbsp;too" THREE=
    ExecStart=/bin/echo ${ONE} ${TWO} ${THREE}
    ExecStart=/bin/echo $ONE $TWO $THREE
.if n \{.RE
.\}

This results in
/bin/echo
being called twice, the first time with arguments
"one\*(Aq",
"two&nbsp;two\*(Aq&nbsp;too",
"", and the second time with arguments
"one",
"two&nbsp;two",
"too".

To pass a literal dollar sign, use
"$$". Variables whose value is not known at expansion time are treated as empty strings. Note that the first argument (i.e. the program to execute) may not be a variable.

Variables to be used in this fashion may be defined through
_Environment=_
and
_EnvironmentFile=_. In addition, variables listed in the section "Environment variables in spawned processes" in
**systemd.exec**(5), which are considered "static configuration", may be used (this includes e.g.
_$USER_, but not
_$TERM_).

Note that shell command lines are not directly supported. If shell command lines are to be used, they need to be passed explicitly to a shell implementation of some kind. Example:

.if n \{.RS 4
.\}
    ExecStart=sh -c dmesg | tac*(Aq
.if n \{.RE
.\}

Example:

.if n \{.RS 4
.\}
    ExecStart=echo one ; echo "two two"
.if n \{.RE
.\}

This will execute
**echo**
two times, each time with one argument:
"one"
and
"two two", respectively. Because two commands are specified,
_Type=oneshot_
must be used.

Example:

.if n \{.RS 4
.\}
    ExecStart=echo / >/dev/null & e; e
    ls
.if n \{.RE
.\}

This will execute
**echo**
with five arguments:
"/",
"&gt;/dev/null",
"&",
";", and
"ls".

.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
**Table&nbsp;3.&nbsp;C escapes supported in command lines and environment variables**
.TS
allbox tab(:);
lB lB.
T{
Literal
T}:T{
Actual value
T}
.T&
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l.
T{
"\ea"
T}:T{
bell
T}
T{
"\eb"
T}:T{
backspace
T}
T{
"\ef"
T}:T{
form feed
T}
T{
"\en"
T}:T{
newline
T}
T{
"\er"
T}:T{
carriage return
T}
T{
"\et"
T}:T{
tab
T}
T{
"\ev"
T}:T{
vertical tab
T}
T{
"\e\e"
T}:T{
backslash
T}
T{
"\e""
T}:T{
double quotation mark
T}
T{
"\e"
T}:T{
single quotation mark
T}
T{
"\es"
T}:T{
space
T}
T{
"\ex_xx_"
T}:T{
character number _xx_ in hexadecimal encoding
T}
T{
"\e_nnn_"
T}:T{
character number _nnn_ in octal encoding
T}
.TE


<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Simple service**

The following unit file creates a service that will execute
/usr/sbin/foo-daemon. Since no
_Type=_
is specified, the default
_Type=_**simple**
will be assumed. systemd will assume the unit to be started immediately after the program has begun executing.

.if n \{.RS 4
.\}
    [Unit]
    Description=Foo
    
    [Service]
    ExecStart=/usr/sbin/foo-daemon
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

Note that systemd assumes here that the process started by systemd will continue running until the service terminates. If the program daemonizes itself (i.e. forks), please use
_Type=_**forking**
instead.

Since no
_ExecStop=_
was specified, systemd will send SIGTERM to all processes started from this service, and after a timeout also SIGKILL. This behavior can be modified, see
**systemd.kill**(5)
for details.

Note that this unit type does not include any type of notification when a service has completed initialization. For this, you should use other unit types, such as
_Type=_**notify**
if the service understands systemds notification protocol,
_Type=_**forking**
if the service can background itself or
_Type=_**dbus**
if the unit acquires a DBus name once initialization is complete. See below.

**Example&nbsp;2.&nbsp;Oneshot service**

Sometimes, units should just execute an action without keeping active processes, such as a filesystem check or a cleanup action on boot. For this,
_Type=_**oneshot**
exists. Units of this type will wait until the process specified terminates and then fall back to being inactive. The following unit will perform a cleanup action:

.if n \{.RS 4
.\}
    [Unit]
    Description=Cleanup old Foo data
    
    [Service]
    Type=oneshot
    ExecStart=/usr/sbin/foo-cleanup
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

Note that systemd will consider the unit to be in the state "starting" until the program has terminated, so ordered dependencies will wait for the program to finish before starting themselves. The unit will revert to the "inactive" state after the execution is done, never reaching the "active" state. That means another request to start the unit will perform the action again.

_Type=_**oneshot**
are the only service units that may have more than one
_ExecStart=_
specified. They will be executed in order until either they are all successful or one of them fails.

**Example&nbsp;3.&nbsp;Stoppable oneshot service**

Similarly to the oneshot services, there are sometimes units that need to execute a program to set up something and then execute another to shut it down, but no process remains active while they are considered "started". Network configuration can sometimes fall into this category. Another use case is if a oneshot service shall not be executed each time when they are pulled in as a dependency, but only the first time.

For this, systemd knows the setting
_RemainAfterExit=_**yes**, which causes systemd to consider the unit to be active if the start action exited successfully. This directive can be used with all types, but is most useful with
_Type=_**oneshot**
and
_Type=_**simple**. With
_Type=_**oneshot**, systemd waits until the start action has completed before it considers the unit to be active, so dependencies start only after the start action has succeeded. With
_Type=_**simple**, dependencies will start immediately after the start action has been dispatched. The following unit provides an example for a simple static firewall.

.if n \{.RS 4
.\}
    [Unit]
    Description=Simple firewall
    
    [Service]
    Type=oneshot
    RemainAfterExit=yes
    ExecStart=/usr/local/sbin/simple-firewall-start
    ExecStop=/usr/local/sbin/simple-firewall-stop
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

Since the unit is considered to be running after the start action has exited, invoking
**systemctl start**
on that unit again will cause no action to be taken.

**Example&nbsp;4.&nbsp;Traditional forking services**

Many traditional daemons/services background (i.e. fork, daemonize) themselves when starting. Set
_Type=_**forking**
in the services unit file to support this mode of operation. systemd will consider the service to be in the process of initialization while the original program is still running. Once it exits successfully and at least a process remains (and
_RemainAfterExit=_**no**), the service is considered started.

Often, a traditional daemon only consists of one process. Therefore, if only one process is left after the original process terminates, systemd will consider that process the main process of the service. In that case, the
_$MAINPID_
variable will be available in
_ExecReload=_,
_ExecStop=_, etc.

In case more than one process remains, systemd will be unable to determine the main process, so it will not assume there is one. In that case,
_$MAINPID_
will not expand to anything. However, if the process decides to write a traditional PID file, systemd will be able to read the main PID from there. Please set
_PIDFile=_
accordingly. Note that the daemon should write that file before finishing with its initialization. Otherwise, systemd might try to read the file before it exists.

The following example shows a simple daemon that forks and just starts one process in the background:

.if n \{.RS 4
.\}
    [Unit]
    Description=Some simple daemon
    
    [Service]
    Type=forking
    ExecStart=/usr/sbin/my-simple-daemon -d
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

Please see
**systemd.kill**(5)
for details on how you can influence the way systemd terminates the service.

**Example&nbsp;5.&nbsp;DBus services**

For services that acquire a name on the DBus system bus, use
_Type=_**dbus**
and set
_BusName=_
accordingly. The service should not fork (daemonize). systemd will consider the service to be initialized once the name has been acquired on the system bus. The following example shows a typical DBus service:

.if n \{.RS 4
.\}
    [Unit]
    Description=Simple DBus service
    
    [Service]
    Type=dbus
    BusName=org.example.simple-dbus-service
    ExecStart=/usr/sbin/simple-dbus-service
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

For
_bus-activatable_
services, do not include a
"[Install]"
section in the systemd service file, but use the
_SystemdService=_
option in the corresponding DBus service file, for example (/usr/share/dbus-1/system-services/org.example.simple-dbus-service.service):

.if n \{.RS 4
.\}
    [D-BUS Service]
    Name=org.example.simple-dbus-service
    Exec=/usr/sbin/simple-dbus-service
    User=root
    SystemdService=simple-dbus-service.service
.if n \{.RE
.\}

Please see
**systemd.kill**(5)
for details on how you can influence the way systemd terminates the service.

**Example&nbsp;6.&nbsp;Services that notify systemd about their initialization**

_Type=_**simple**
services are really easy to write, but have the major disadvantage of systemd not being able to tell when initialization of the given service is complete. For this reason, systemd supports a simple notification protocol that allows daemons to make systemd aware that they are done initializing. Use
_Type=_**notify**
for this. A typical service file for such a daemon would look like this:

.if n \{.RS 4
.\}
    [Unit]
    Description=Simple notifying service
    
    [Service]
    Type=notify
    ExecStart=/usr/sbin/simple-notifying-service
    
    [Install]
    WantedBy=multi-user.target
.if n \{.RE
.\}

Note that the daemon has to support systemds notification protocol, else systemd will think the service has not started yet and kill it after a timeout. For an example of how to update daemons to support this protocol transparently, take a look at
**sd\_notify**(3). systemd will consider the unit to be in the starting\*(Aq state until a readiness notification has arrived.

Please see
**systemd.kill**(5)
for details on how you can influence the way systemd terminates the service.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd-system.conf**(5),
**systemd.unit**(5),
**systemd.exec**(5),
**systemd.resource-control**(5),
**systemd.kill**(5),
**systemd.directives**(7)

<a name="notes"></a>

# Notes


*  1.  
  Incompatibilities with SysV
      https://www.freedesktop.org/wiki/Software/systemd/Incompatibilities
*  2.  
  USB FunctionFS
      https://www.kernel.org/doc/Documentation/usb/functionfs.txt
