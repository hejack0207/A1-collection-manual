# systemd\&.socket(5)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.socket - Socket unit configuration

<a name="synopsis"></a>

# Synopsis

```

 socket.socket
```

<a name="description"></a>

# Description


A unit configuration file whose name ends in
".socket"
encodes information about an IPC or network socket or a file system FIFO controlled and supervised by systemd, for socket-based activation.

This man page lists the configuration options specific to this unit type. See
**systemd.unit**(5)
for the common options of all unit configuration files. The common configuration items are configured in the generic [Unit] and [Install] sections. The socket specific configuration options are configured in the [Socket] section.

Additional options are listed in
**systemd.exec**(5), which define the execution environment the
**ExecStartPre=**,
**ExecStartPost=**,
**ExecStopPre=**
and
**ExecStopPost=**
commands are executed in, and in
**systemd.kill**(5), which define the way the processes are terminated, and in
**systemd.resource-control**(5), which configure resource control settings for the processes of the socket.

For each socket file, a matching service file must exist, describing the service to start on incoming traffic on the socket (see
**systemd.service**(5)
for more information about .service files). The name of the .service unit is by default the same as the name of the .socket unit, but can be altered with the
**Service=**
option described below. Depending on the setting of the
**Accept=**
option described below, this .service unit must either be named like the .socket unit, but with the suffix replaced, unless overridden with
**Service=**; or it must be a template unit named the same way. Example: a socket file
foo.socket
needs a matching service
foo.service
if
**Accept=no**
is set. If
**Accept=yes**
is set, a service template file
foo@.service
must exist from which services are instantiated for each incoming connection.

No implicit
_WantedBy=_
or
_RequiredBy=_
dependency from the socket to the service is added. This means that the service may be started without the socket, in which case it must be able to open sockets by itself. To prevent this, an explicit
_Requires=_
dependency may be added.

Socket units may be used to implement on-demand starting of services, as well as parallelized starting of services. See the blog stories linked at the end for an introduction.

Note that the daemon software configured for socket activation with socket units needs to be able to accept sockets from systemd, either via systemds native socket passing interface (see
**sd\_listen\_fds**(3)
for details) or via the traditional
**inetd**(8)-style socket passing (i.e. sockets passed in via standard input and output, using
_StandardInput=socket_
in the service file).

All network sockets allocated through
.socket
units are allocated in the hosts network namespace (see
**network\_namespaces**(7)). This does not mean however that the service activated by a configured socket unit has to be part of the hosts network namespace as well. It is supported and even good practice to run services in their own network namespace (for example through
_PrivateNetwork=_, see
**systemd.exec**(5)), receiving only the sockets configured through socket-activation from the hosts namespace. In such a set-up communication within the host\*(Aqs network namespace is only permitted through the activation sockets passed in while all sockets allocated from the service code itself will be associated with the service\*(Aqs own namespace, and thus possibly subject to a a much more restrictive configuration.

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
  Socket units automatically gain a
  _Before=_
  dependency on the service units they activate.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Socket units referring to file system paths (such as AF_UNIX sockets or FIFOs) implicitly gain
  _Requires=_
  and
  _After=_
  dependencies on all mount units necessary to access those paths.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Socket units using the
  _BindToDevice=_
  setting automatically gain a
  _BindsTo=_
  and
  _After=_
  dependency on the device unit encapsulating the specified network interface.

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
  Socket units automatically gain a
  _Before=_
  dependency on
  sockets.target.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Socket units automatically gain a pair of
  _After=_
  and
  _Requires=_
  dependency on
  sysinit.target, and a pair of
  _Before=_
  and
  _Conflicts=_
  dependencies on
  shutdown.target. These dependencies ensure that the socket unit is started before normal services at boot, and is stopped on shutdown. Only sockets involved with early boot or late system shutdown should disable
  _DefaultDependencies=_
  option.

<a name="options"></a>

# Options


Socket files must include a [Socket] section, which carries information about the socket or FIFO it supervises. A number of options that may be used in this section are shared with other unit types. These options are documented in
**systemd.exec**(5)
and
**systemd.kill**(5). The options specific to the [Socket] section of socket units are the following:

_ListenStream=_, _ListenDatagram=_, _ListenSequentialPacket=_
Specifies an address to listen on for a stream (**SOCK\_STREAM**), datagram (**SOCK\_DGRAM**), or sequential packet (**SOCK\_SEQPACKET**) socket, respectively. The address can be written in various formats:

If the address starts with a slash ("/"), it is read as file system socket in the
**AF\_UNIX**
socket family.

If the address starts with an at symbol ("@"), it is read as abstract namespace socket in the
**AF\_UNIX**
family. The
"@"
is replaced with a
**NUL**
character before binding. For details, see
**unix**(7).

If the address string is a single number, it is read as port number to listen on via IPv6. Depending on the value of
_BindIPv6Only=_
(see below) this might result in the service being available via both IPv6 and IPv4 (default) or just via IPv6.

If the address string is a string in the format v.w.x.y:z, it is read as IPv4 specifier for listening on an address v.w.x.y on a port z.

If the address string is a string in the format [x]:y, it is read as IPv6 address x on a port y. Note that this might make the service available via IPv4, too, depending on the
_BindIPv6Only=_
setting (see below).

If the address string is a string in the format
"vsock:x:y", it is read as CID
"x"
on a port
"y"
address in the
**AF\_VSOCK**
family. The CID is a unique 32-bit integer identifier in
**AF\_VSOCK**
analogous to an IP address. Specifying the CID is optional, and may be set to the empty string.

Note that
**SOCK\_SEQPACKET**
(i.e.
_ListenSequentialPacket=_) is only available for
**AF\_UNIX**
sockets.
**SOCK\_STREAM**
(i.e.
_ListenStream=_) when used for IP sockets refers to TCP sockets,
**SOCK\_DGRAM**
(i.e.
_ListenDatagram=_) to UDP.

These options may be specified more than once, in which case incoming traffic on any of the sockets will trigger service activation, and all listed sockets will be passed to the service, regardless of whether there is incoming traffic on them or not. If the empty string is assigned to any of these options, the list of addresses to listen on is reset, all prior uses of any of these options will have no effect.

It is also possible to have more than one socket unit for the same service when using
_Service=_, and the service will receive all the sockets configured in all the socket units. Sockets configured in one unit are passed in the order of configuration, but no ordering between socket units is specified.

If an IP address is used here, it is often desirable to listen on it before the interface it is configured on is up and running, and even regardless of whether it will be up and running at any point. To deal with this, it is recommended to set the
_FreeBind=_
option described below.

_ListenFIFO=_
Specifies a file system FIFO to listen on. This expects an absolute file system path as argument. Behavior otherwise is very similar to the
_ListenDatagram=_
directive above.

_ListenSpecial=_
Specifies a special file in the file system to listen on. This expects an absolute file system path as argument. Behavior otherwise is very similar to the
_ListenFIFO=_
directive above. Use this to open character device nodes as well as special files in
/proc
and
/sys.

_ListenNetlink=_
Specifies a Netlink family to create a socket for to listen on. This expects a short string referring to the
**AF\_NETLINK**
family name (such as
_audit_
or
_kobject-uevent_) as argument, optionally suffixed by a whitespace followed by a multicast group integer. Behavior otherwise is very similar to the
_ListenDatagram=_
directive above.

_ListenMessageQueue=_
Specifies a POSIX message queue name to listen on. This expects a valid message queue name (i.e. beginning with /). Behavior otherwise is very similar to the
_ListenFIFO=_
directive above. On Linux message queue descriptors are actually file descriptors and can be inherited between processes.

_ListenUSBFunction=_
Specifies a
\m[blue]**USB FunctionFS**\m[]\s-2\u[1]\d\s+2
endpoints location to listen on, for implementation of USB gadget functions. This expects an absolute file system path of functionfs mount point as the argument. Behavior otherwise is very similar to the
_ListenFIFO=_
directive above. Use this to open the FunctionFS endpoint
ep0. When using this option, the activated service has to have the
_USBFunctionDescriptors=_
and
_USBFunctionStrings=_
options set.

_SocketProtocol=_
Takes one of
**udplite**
or
**sctp**. Specifies a socket protocol (**IPPROTO\_UDPLITE**) UDP-Lite (**IPPROTO\_SCTP**) SCTP socket respectively.

_BindIPv6Only=_
Takes one of
**default**,
**both**
or
**ipv6-only**. Controls the IPV6_V6ONLY socket option (see
**ipv6**(7)
for details). If
**both**, IPv6 sockets bound will be accessible via both IPv4 and IPv6. If
**ipv6-only**, they will be accessible via IPv6 only. If
**default**
(which is the default, surprise!), the system wide default setting is used, as controlled by
/proc/sys/net/ipv6/bindv6only, which in turn defaults to the equivalent of
**both**.

_Backlog=_
Takes an unsigned integer argument. Specifies the number of connections to queue that have not been accepted yet. This setting matters only for stream and sequential packet sockets. See
**listen**(2)
for details. Defaults to SOMAXCONN (128).

_BindToDevice=_
Specifies a network interface name to bind this socket to. If set, traffic will only be accepted from the specified network interfaces. This controls the SO_BINDTODEVICE socket option (see
**socket**(7)
for details). If this option is used, an implicit dependency from this socket unit on the network interface device unit (**systemd.device**(5)
is created. Note that setting this parameter might result in additional dependencies to be added to the unit (see above).

_SocketUser=_, _SocketGroup=_
Takes a UNIX user/group name. When specified, all AF_UNIX sockets and FIFO nodes in the file system are owned by the specified user and group. If unset (the default), the nodes are owned by the root user/group (if run in system context) or the invoking user/group (if run in user context). If only a user is specified but no group, then the group is derived from the users default group.

_SocketMode=_
If listening on a file system socket or FIFO, this option specifies the file system access mode used when creating the file node. Takes an access mode in octal notation. Defaults to 0666.

_DirectoryMode=_
If listening on a file system socket or FIFO, the parent directories are automatically created if needed. This option specifies the file system access mode used when creating these directories. Takes an access mode in octal notation. Defaults to 0755.

_Accept=_
Takes a boolean argument. If true, a service instance is spawned for each incoming connection and only the connection socket is passed to it. If false, all listening sockets themselves are passed to the started service unit, and only one service unit is spawned for all connections (also see above). This value is ignored for datagram sockets and FIFOs where a single service unit unconditionally handles all incoming traffic. Defaults to
**false**. For performance reasons, it is recommended to write new daemons only in a way that is suitable for
**Accept=no**. A daemon listening on an
**AF\_UNIX**
socket may, but does not need to, call
**close**(2)
on the received socket before exiting. However, it must not unlink the socket from a file system. It should not invoke
**shutdown**(2)
on sockets it got with
_Accept=no_, but it may do so for sockets it got with
_Accept=yes_
set. Setting
_Accept=yes_
is mostly useful to allow daemons designed for usage with
**inetd**(8)
to work unmodified with systemd socket activation.

For IPv4 and IPv6 connections, the
_REMOTE\_ADDR_
environment variable will contain the remote IP address, and
_REMOTE\_PORT_
will contain the remote port. This is the same as the format used by CGI. For SOCK_RAW, the port is the IP protocol.

_Writable=_
Takes a boolean argument. May only be used in conjunction with
_ListenSpecial=_. If true, the specified special file is opened in read-write mode, if false, in read-only mode. Defaults to false.

_MaxConnections=_
The maximum number of connections to simultaneously run services instances for, when
**Accept=yes**
is set. If more concurrent connections are coming in, they will be refused until at least one existing connection is terminated. This setting has no effect on sockets configured with
**Accept=no**
or datagram sockets. Defaults to 64.

_MaxConnectionsPerSource=_
The maximum number of connections for a service per source IP address. This is very similar to the
_MaxConnections=_
directive above. Disabled by default.

_KeepAlive=_
Takes a boolean argument. If true, the TCP/IP stack will send a keep alive message after 2h (depending on the configuration of
/proc/sys/net/ipv4/tcp_keepalive_time) for all TCP streams accepted on this socket. This controls the SO_KEEPALIVE socket option (see
**socket**(7)
and the
\m[blue]**TCP Keepalive HOWTO**\m[]\s-2\u[2]\d\s+2
for details.) Defaults to
**false**.

_KeepAliveTimeSec=_
Takes time (in seconds) as argument. The connection needs to remain idle before TCP starts sending keepalive probes. This controls the TCP_KEEPIDLE socket option (see
**socket**(7)
and the
\m[blue]**TCP Keepalive HOWTO**\m[]\s-2\u[2]\d\s+2
for details.) Defaults value is 7200 seconds (2 hours).

_KeepAliveIntervalSec=_
Takes time (in seconds) as argument between individual keepalive probes, if the socket option SO_KEEPALIVE has been set on this socket. This controls the TCP_KEEPINTVL socket option (see
**socket**(7)
and the
\m[blue]**TCP Keepalive HOWTO**\m[]\s-2\u[2]\d\s+2
for details.) Defaults value is 75 seconds.

_KeepAliveProbes=_
Takes an integer as argument. It is the number of unacknowledged probes to send before considering the connection dead and notifying the application layer. This controls the TCP_KEEPCNT socket option (see
**socket**(7)
and the
\m[blue]**TCP Keepalive HOWTO**\m[]\s-2\u[2]\d\s+2
for details.) Defaults value is 9.

_NoDelay=_
Takes a boolean argument. TCP Nagles algorithm works by combining a number of small outgoing messages, and sending them all at once. This controls the TCP_NODELAY socket option (see
**tcp**(7)
Defaults to
**false**.

_Priority=_
Takes an integer argument controlling the priority for all traffic sent from this socket. This controls the SO_PRIORITY socket option (see
**socket**(7)
for details.).

_DeferAcceptSec=_
Takes time (in seconds) as argument. If set, the listening process will be awakened only when data arrives on the socket, and not immediately when connection is established. When this option is set, the
**TCP\_DEFER\_ACCEPT**
socket option will be used (see
**tcp**(7)), and the kernel will ignore initial ACK packets without any data. The argument specifies the approximate amount of time the kernel should wait for incoming data before falling back to the normal behavior of honoring empty ACK packets. This option is beneficial for protocols where the client sends the data first (e.g. HTTP, in contrast to SMTP), because the server process will not be woken up unnecessarily before it can take any action.

If the client also uses the
**TCP\_DEFER\_ACCEPT**
option, the latency of the initial connection may be reduced, because the kernel will send data in the final packet establishing the connection (the third packet in the "three-way handshake").

Disabled by default.

_ReceiveBuffer=_, _SendBuffer=_
Takes an integer argument controlling the receive or send buffer sizes of this socket, respectively. This controls the SO_RCVBUF and SO_SNDBUF socket options (see
**socket**(7)
for details.). The usual suffixes K, M, G are supported and are understood to the base of 1024.

_IPTOS=_
Takes an integer argument controlling the IP Type-Of-Service field for packets generated from this socket. This controls the IP_TOS socket option (see
**ip**(7)
for details.). Either a numeric string or one of
**low-delay**,
**throughput**,
**reliability**
or
**low-cost**
may be specified.

_IPTTL=_
Takes an integer argument controlling the IPv4 Time-To-Live/IPv6 Hop-Count field for packets generated from this socket. This sets the IP_TTL/IPV6_UNICAST_HOPS socket options (see
**ip**(7)
and
**ipv6**(7)
for details.)

_Mark=_
Takes an integer value. Controls the firewall mark of packets generated by this socket. This can be used in the firewall logic to filter packets from this socket. This sets the SO_MARK socket option. See
**iptables**(8)
for details.

_ReusePort=_
Takes a boolean value. If true, allows multiple
**bind**(2)s to this TCP or UDP port. This controls the SO_REUSEPORT socket option. See
**socket**(7)
for details.

_SmackLabel=_, _SmackLabelIPIn=_, _SmackLabelIPOut=_
Takes a string value. Controls the extended attributes
"security.SMACK64",
"security.SMACK64IPIN"
and
"security.SMACK64IPOUT", respectively, i.e. the security label of the FIFO, or the security label for the incoming or outgoing connections of the socket, respectively. See
\m[blue]**Smack.txt**\m[]\s-2\u[3]\d\s+2
for details.

_SELinuxContextFromNet=_
Takes a boolean argument. When true, systemd will attempt to figure out the SELinux label used for the instantiated service from the information handed by the peer over the network. Note that only the security level is used from the information provided by the peer. Other parts of the resulting SELinux context originate from either the target binary that is effectively triggered by socket unit or from the value of the
_SELinuxContext=_
option. This configuration option only affects sockets with
_Accept=_
mode set to
"true". Also note that this option is useful only when MLS/MCS SELinux policy is deployed. Defaults to
"false".

_PipeSize=_
Takes a size in bytes. Controls the pipe buffer size of FIFOs configured in this socket unit. See
**fcntl**(2)
for details. The usual suffixes K, M, G are supported and are understood to the base of 1024.

_MessageQueueMaxMessages=_, _MessageQueueMessageSize=_
These two settings take integer values and control the mq_maxmsg field or the mq_msgsize field, respectively, when creating the message queue. Note that either none or both of these variables need to be set. See
**mq\_setattr**(3)
for details.

_FreeBind=_
Takes a boolean value. Controls whether the socket can be bound to non-local IP addresses. This is useful to configure sockets listening on specific IP addresses before those IP addresses are successfully configured on a network interface. This sets the IP_FREEBIND socket option. For robustness reasons it is recommended to use this option whenever you bind a socket to a specific IP address. Defaults to
**false**.

_Transparent=_
Takes a boolean value. Controls the IP_TRANSPARENT socket option. Defaults to
**false**.

_Broadcast=_
Takes a boolean value. This controls the SO_BROADCAST socket option, which allows broadcast datagrams to be sent from this socket. Defaults to
**false**.

_PassCredentials=_
Takes a boolean value. This controls the SO_PASSCRED socket option, which allows
**AF\_UNIX**
sockets to receive the credentials of the sending process in an ancillary message. Defaults to
**false**.

_PassSecurity=_
Takes a boolean value. This controls the SO_PASSSEC socket option, which allows
**AF\_UNIX**
sockets to receive the security context of the sending process in an ancillary message. Defaults to
**false**.

_TCPCongestion=_
Takes a string value. Controls the TCP congestion algorithm used by this socket. Should be one of "westwood", "veno", "cubic", "lp" or any other available algorithm supported by the IP stack. This setting applies only to stream sockets.

_ExecStartPre=_, _ExecStartPost=_
Takes one or more command lines, which are executed before or after the listening sockets/FIFOs are created and bound, respectively. The first token of the command line must be an absolute filename, then followed by arguments for the process. Multiple command lines may be specified following the same scheme as used for
_ExecStartPre=_
of service unit files.

_ExecStopPre=_, _ExecStopPost=_
Additional commands that are executed before or after the listening sockets/FIFOs are closed and removed, respectively. Multiple command lines may be specified following the same scheme as used for
_ExecStartPre=_
of service unit files.

_TimeoutSec=_
Configures the time to wait for the commands specified in
_ExecStartPre=_,
_ExecStartPost=_,
_ExecStopPre=_
and
_ExecStopPost=_
to finish. If a command does not exit within the configured time, the socket will be considered failed and be shut down again. All commands still running will be terminated forcibly via
**SIGTERM**, and after another delay of this time with
**SIGKILL**. (See
**KillMode=**
in
**systemd.kill**(5).) Takes a unit-less value in seconds, or a time span value such as "5min 20s". Pass
"0"
to disable the timeout logic. Defaults to
_DefaultTimeoutStartSec=_
from the manager configuration file (see
**systemd-system.conf**(5)).

_Service=_
Specifies the service unit name to activate on incoming traffic. This setting is only allowed for sockets with
_Accept=no_. It defaults to the service that bears the same name as the socket (with the suffix replaced). In most cases, it should not be necessary to use this option. Note that setting this parameter might result in additional dependencies to be added to the unit (see above).

_RemoveOnStop=_
Takes a boolean argument. If enabled, any file nodes created by this socket unit are removed when it is stopped. This applies to AF_UNIX sockets in the file system, POSIX message queues, FIFOs, as well as any symlinks to them configured with
_Symlinks=_. Normally, it should not be necessary to use this option, and is not recommended as services might continue to run after the socket unit has been terminated and it should still be possible to communicate with them via their file system node. Defaults to off.

_Symlinks=_
Takes a list of file system paths. The specified paths will be created as symlinks to the
**AF\_UNIX**
socket path or FIFO path of this socket unit. If this setting is used, only one
**AF\_UNIX**
socket in the file system or one FIFO may be configured for the socket unit. Use this option to manage one or more symlinked alias names for a socket, binding their lifecycle together. Note that if creation of a symlink fails this is not considered fatal for the socket unit, and the socket unit may still start. If an empty string is assigned, the list of paths is reset. Defaults to an empty list.

_FileDescriptorName=_
Assigns a name to all file descriptors this socket unit encapsulates. This is useful to help activated services identify specific file descriptors, if multiple fds are passed. Services may use the
**sd\_listen\_fds\_with\_names**(3)
call to acquire the names configured for the received file descriptors. Names may contain any ASCII character, but must exclude control characters and
":", and must be at most 255 characters in length. If this setting is not used, the file descriptor name defaults to the name of the socket unit, including its
.socket
suffix.

_TriggerLimitIntervalSec=_, _TriggerLimitBurst=_
Configures a limit on how often this socket unit my be activated within a specific time interval. The
_TriggerLimitIntervalSec=_
may be used to configure the length of the time interval in the usual time units
"us",
"ms",
"s",
"min",
"h", ... and defaults to 2s (See
**systemd.time**(7)
for details on the various time units understood). The
_TriggerLimitBurst=_
setting takes a positive integer value and specifies the number of permitted activations per time interval, and defaults to 200 for
_Accept=yes_
sockets (thus by default permitting 200 activations per 2s), and 20 otherwise (20 activations per 2s). Set either to 0 to disable any form of trigger rate limiting. If the limit is hit, the socket unit is placed into a failure mode, and will not be connectible anymore until restarted. Note that this limit is enforced before the service activation is enqueued.

Check
**systemd.exec**(5)
and
**systemd.kill**(5)
for more settings.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd-system.conf**(5),
**systemd.unit**(5),
**systemd.exec**(5),
**systemd.kill**(5),
**systemd.resource-control**(5),
**systemd.service**(5),
**systemd.directives**(7),
**sd\_listen\_fds**(3),
**sd\_listen\_fds\_with\_names**(3)

For more extensive descriptions see the "systemd for Developers" series:
\m[blue]**Socket Activation**\m[]\s-2\u[4]\d\s+2,
\m[blue]**Socket Activation, part II**\m[]\s-2\u[5]\d\s+2,
\m[blue]**Converting inetd Services**\m[]\s-2\u[6]\d\s+2,
\m[blue]**Socket Activated Internet Services and OS Containers**\m[]\s-2\u[7]\d\s+2.

<a name="notes"></a>

# Notes


*  1.  
  USB FunctionFS
      https://www.kernel.org/doc/Documentation/usb/functionfs.txt
*  2.  
  TCP Keepalive HOWTO
      http://www.tldp.org/HOWTO/html_single/TCP-Keepalive-HOWTO/
*  3.  
  Smack.txt
      https://www.kernel.org/doc/Documentation/security/Smack.txt
*  4.  
  Socket Activation
      http://0pointer.de/blog/projects/socket-activation.html
*  5.  
  Socket Activation, part II
      http://0pointer.de/blog/projects/socket-activation2.html
*  6.  
  Converting inetd Services
      http://0pointer.de/blog/projects/inetd.html
*  7.  
  Socket Activated Internet Services and OS Containers
      http://0pointer.de/blog/projects/socket-activated-containers.html
