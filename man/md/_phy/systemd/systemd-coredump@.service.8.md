# systemd\-coredump(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-coredump, systemd-coredump.socket, systemd-coredump@.service - Acquire, save and process core dumps

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/systemd-coredump 
 /usr/lib/systemd/systemd-coredump --backtrace 
 systemd-coredump@.service 
 systemd-coredump.socket
```

<a name="description"></a>

# Description


systemd-coredump@.service
is a system service that can acquire core dumps from the kernel and handle them in various ways. The
**systemd-coredump**
executable does the actual work. It is invoked twice: once as the handler by the kernel, and the second time in the
systemd-coredump@.service
to actually write the data to the journal.

When the kernel invokes
**systemd-coredump**
to handle a core dump, it runs in privileged mode, and will connect to the socket created by the
systemd-coredump.socket
unit, which in turn will spawn an unprivileged
systemd-coredump@.service
instance to process the core dump. Hence
systemd-coredump.socket
and
systemd-coredump@.service
are helper units which do the actual processing of core dumps and are subject to normal service management.

Core dumps can be written to the journal or saved as a file. Once saved they can be retrieved for further processing, for example in
**gdb**(1).

By default,
**systemd-coredump**
will log the core dump including a backtrace if possible to the journal and store the core dump itself in an external file in
/var/lib/systemd/coredump.

The behavior of a specific program upon reception of a signal is governed by a few factors which are described in detail in
**core**(5). In particular, the core dump will only be processed when the related resource limits are sufficient.

It is also possible to invoke
**systemd-coredump**
with
**--backtrace**
option. In this case,
**systemd-coredump**
expects a journal entry in the journal
\m[blue]**Journal Export Format**\m[]\s-2\u[1]\d\s+2
on standard input. The entry should contain a
_MESSAGE=_
field and any additional metadata fields the caller deems reasonable.
**systemd-coredump**
will append additional metadata fields in the same way it does for core dumps received from the kernel. In this mode, no core dump is stored in the journal.

<a name="configuration"></a>

# Configuration


For programs started by
**systemd**
process resource limits can be set by directive
_LimitCore=_, see
**systemd.exec**(5).

In order to be used by the kernel to handle core dumps,
**systemd-coredump**
must be configured in
**sysctl**(8)
parameter
_kernel.core\_pattern_. The syntax of this parameter is explained in
**core**(5). systemd installs the file
/usr/lib/sysctl.d/50-coredump.conf
which configures
_kernel.core\_pattern_
accordingly. This file may be masked or overridden to use a different setting following normal
**sysctl.d**(5)
rules. If the sysctl configuration is modified, it must be updated in the kernel before it takes effect, see
**sysctl**(8)
and
**systemd-sysctl**(8).

In order to by used in the
**--backtrace**
mode, an appropriate backtrace handler must be installed on the sender side. For example, in case of
**python**(1), this means a
_sys.excepthook_
must installed, see
\m[blue]**systemd-coredump-python**\m[]\s-2\u[2]\d\s+2.

The behavior of
**systemd-coredump**
itself is configured through the configuration file
/etc/systemd/coredump.conf
and corresponding snippets
/etc/systemd/coredump.conf.d/*.conf, see
**coredump.conf**(5). A new instance of
**systemd-coredump**
is invoked upon receiving every core dump. Therefore, changes in these files will take effect the next time a core dump is received.

Resources used by core dump files are restricted in two ways. Parameters like maximum size of acquired core dumps and files can be set in files
/etc/systemd/coredump.conf
and snippets mentioned above. In addition the storage time of core dump files is restricted by
**systemd-tmpfiles**, corresponding settings are by default in
/usr/lib/tmpfiles.d/systemd.conf.

<a name="disabling-coredump-processing"></a>

### Disabling coredump processing


To disable potentially resource-intensive processing by
**systemd-coredump**, set

.if n \{.RS 4
.\}
    Storage=none
    ProcessSizeMax=0
.if n \{.RE
.\}

in
**coredump.conf**(5).

<a name="usage"></a>

# Usage


Data stored in the journal can be viewed with
**journalctl**(1)
as usual.
**coredumpctl**(1)
can be used to retrieve saved core dumps independent of their location, to display information and to process them e.g. by passing to the GNU debugger (gdb).

<a name="see-also"></a>

# See Also


**coredump.conf**(5),
**coredumpctl**(1),
**systemd-journald.service**(8),
**systemd-tmpfiles**(8),
**core**(5),
**sysctl.d**(5),
**systemd-sysctl.service**(8).

<a name="notes"></a>

# Notes


*  1.  
  Journal Export Format
      https://www.freedesktop.org/wiki/Software/systemd/export
*  2.  
  systemd-coredump-python
      https://github.com/keszybz/systemd-coredump-python
