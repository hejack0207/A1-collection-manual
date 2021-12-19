# lwresd(8)

ISC, 2009\-01\-20

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

lwresd - lightweight resolver daemon

<a name="synopsis"></a>

# Synopsis

```
.HP \w'lwresd&nbsp;'u lwresd [-c&nbsp;config-file] [-C&nbsp;config-file] [-d&nbsp;debug-level] [-f] [-g] [-i&nbsp;pid-file] [-m&nbsp;flag] [-n&nbsp;#cpus] [-P&nbsp;port] [-p&nbsp;port] [-s] [-t&nbsp;directory] [-u&nbsp;user] [-v] [[-4] | [-6]]
```

<a name="description"></a>

# Description


**lwresd**
is the daemon providing name lookup services to clients that use the BIND 9 lightweight resolver library. It is essentially a stripped-down, caching-only name server that answers queries using the BIND 9 lightweight resolver protocol rather than the DNS protocol.

**lwresd**
listens for resolver queries on a UDP port on the IPv4 loopback interface, 127.0.0.1. This means that
**lwresd**
can only be used by processes running on the local machine. By default, UDP port number 921 is used for lightweight resolver requests and responses.

Incoming lightweight resolver requests are decoded by the server which then resolves them using the DNS protocol. When the DNS lookup completes,
**lwresd**
encodes the answers in the lightweight resolver format and returns them to the client that made the request.

If
/etc/resolv.conf
contains any
**nameserver**
entries,
**lwresd**
sends recursive DNS queries to those servers. This is similar to the use of forwarders in a caching name server. If no
**nameserver**
entries are present, or if forwarding fails,
**lwresd**
resolves the queries autonomously starting at the root name servers, using a built-in list of root server hints.

<a name="options"></a>

# Options


-4
Use IPv4 only even if the host machine is capable of IPv6.
**-4**
and
**-6**
are mutually exclusive.

-6
Use IPv6 only even if the host machine is capable of IPv4.
**-4**
and
**-6**
are mutually exclusive.

-c _config-file_
Use
_config-file_
as the configuration file instead of the default,
/etc/lwresd.conf.
**-c**
can not be used with
**-C**.

-C _config-file_
Use
_config-file_
as the configuration file instead of the default,
/etc/resolv.conf.
**-C**
can not be used with
**-c**.

-d _debug-level_
Set the daemons debug level to
_debug-level_. Debugging traces from
**lwresd**
become more verbose as the debug level increases.

-f
Run the server in the foreground (i.e. do not daemonize).

-g
Run the server in the foreground and force all logging to
stderr.

-i _pid-file_
Use
_pid-file_
as the PID file instead of the default,
/var/run/lwresd/lwresd.pid.

-m _flag_
Turn on memory usage debugging flags. Possible flags are
_usage_,
_trace_,
_record_,
_size_, and
_mctx_. These correspond to the ISC_MEM_DEBUGXXXX flags described in
&lt;isc/mem.h&gt;.

-n _#cpus_
Create
_#cpus_
worker threads to take advantage of multiple CPUs. If not specified,
**lwresd**
will try to determine the number of CPUs present and create one thread per CPU. If it is unable to determine the number of CPUs, a single worker thread will be created.

-P _port_
Listen for lightweight resolver queries on port
_port_. If not specified, the default is port 921.

-p _port_
Send DNS lookups to port
_port_. If not specified, the default is port 53. This provides a way of testing the lightweight resolver daemon with a name server that listens for queries on a non-standard port number.

-s
Write memory usage statistics to
stdout
on exit.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
This option is mainly of interest to BIND 9 developers and may be removed or changed in a future release.


-t _directory_
Chroot to
_directory_
after processing the command line arguments, but before reading the configuration file.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Warning**
.ps -1  
This option should be used in conjunction with the
**-u**
option, as chrooting a process running as root doesnt enhance security on most systems; the way
**chroot(2)**
is defined allows a process with root privileges to escape a chroot jail.


-u _user_
Setuid to
_user_
after completing privileged operations, such as creating sockets that listen on privileged ports.

-v
Report the version number and exit.

<a name="files"></a>

# Files


/etc/resolv.conf
The default configuration file.

/var/run/lwresd.pid
The default process-id file.

<a name="see-also"></a>

# See Also


**named**(8),
**lwres**(3),
**resolver**(5).

<a name="author"></a>

# Author


**Internet Systems Consortium, Inc.**

<a name="copyright"></a>

# Copyright
  
Copyright © 2000, 2001, 2004, 2005, 2007-2009, 2014-2021 Internet Systems Consortium, Inc. ("ISC")  
