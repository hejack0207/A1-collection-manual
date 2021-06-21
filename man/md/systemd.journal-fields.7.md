# systemd\&.journal\-fields(7)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.journal-fields - Special journal fields

<a name="description"></a>

# Description


Entries in the journal resemble an environment block in their syntax but with fields that can include binary data. Primarily, fields are formatted UTF-8 text strings, and binary formatting is used only where formatting as UTF-8 text strings makes little sense. New fields may freely be defined by applications, but a few fields have special meaning. All fields with special meanings are optional. In some cases, fields may appear more than once per entry.

<a name="user-journal-fields"></a>

# User Journal Fields


User fields are fields that are directly passed from clients and stored in the journal.

_MESSAGE=_
The human-readable message string for this entry. This is supposed to be the primary text shown to the user. It is usually not translated (but might be in some cases), and is not supposed to be parsed for metadata.

_MESSAGE\_ID=_
A 128-bit message identifier ID for recognizing certain message types, if this is desirable. This should contain a 128-bit ID formatted as a lower-case hexadecimal string, without any separating dashes or suchlike. This is recommended to be a UUID-compatible ID, but this is not enforced, and formatted differently. Developers can generate a new ID for this purpose with
**systemd-id128 new**.

_PRIORITY=_
A priority value between 0 ("emerg") and 7 ("debug") formatted as a decimal string. This field is compatible with syslogs priority concept.

_CODE\_FILE=_, _CODE\_LINE=_, _CODE\_FUNC=_
The code location generating this message, if known. Contains the source filename, the line number and the function name.

_ERRNO=_
The low-level Unix error number causing this entry, if any. Contains the numeric value of
**errno**(3)
formatted as a decimal string.

_SYSLOG\_FACILITY=_, _SYSLOG\_IDENTIFIER=_, _SYSLOG\_PID=_, _SYSLOG\_TIMESTAMP=_
Syslog compatibility fields containing the facility (formatted as decimal string), the identifier string (i.e. "tag"), the client PID, and the timestamp as specified in the original datagram. (Note that the tag is usually derived from glibcs
_program\_invocation\_short\_name_
variable, see
**program\_invocation\_short\_name**(3).)

_SYSLOG\_RAW=_
The original contents of the syslog line as received in the syslog datagram. This field is only included if the
_MESSAGE=_
field was modified compared to the original payload or the timestamp could not be located properly and is not included in
_SYSLOG\_TIMESTAMP=_. Message truncation occurs when when the message contains leading or trailing whitespace (trailing and leading whitespace is stripped), or it contains an embedded
**NUL**
byte (the
**NUL**
byte and anything after it is not included). Thus, the original syslog line is either stored as
_SYSLOG\_RAW=_
or it can be recreated based on the stored priority and facility, timestamp, identifier, and the message payload in
_MESSAGE=_.

<a name="trusted-journal-fields"></a>

# Trusted Journal Fields


Fields prefixed with an underscore are trusted fields, i.e. fields that are implicitly added by the journal and cannot be altered by client code.

_\_PID=_, _\_UID=_, _\_GID=_
The process, user, and group ID of the process the journal entry originates from formatted as a decimal string. Note that entries obtained via
"stdout"
or
"stderr"
of forked processes will contain credentials valid for a parent process (that initiated the connection to
**systemd-journald**).

_\_COMM=_, _\_EXE=_, _\_CMDLINE=_
The name, the executable path, and the command line of the process the journal entry originates from.

_\_CAP\_EFFECTIVE=_
The effective
**capabilities**(7)
of the process the journal entry originates from.

_\_AUDIT\_SESSION=_, _\_AUDIT\_LOGINUID=_
The session and login UID of the process the journal entry originates from, as maintained by the kernel audit subsystem.

_\_SYSTEMD\_CGROUP=_, _\_SYSTEMD\_SLICE=_, _\_SYSTEMD\_UNIT=_, _\_SYSTEMD\_USER\_UNIT=_, _\_SYSTEMD\_SESSION=_, _\_SYSTEMD\_OWNER\_UID=_
The control group path in the systemd hierarchy, the the systemd slice unit name, the systemd unit name, the unit name in the systemd user manager (if any), the systemd session ID (if any), and the owner UID of the systemd user unit or systemd session (if any) of the process the journal entry originates from.

_\_SELINUX\_CONTEXT=_
The SELinux security context (label) of the process the journal entry originates from.

_\_SOURCE\_REALTIME\_TIMESTAMP=_
The earliest trusted timestamp of the message, if any is known that is different from the reception time of the journal. This is the time in microseconds since the epoch UTC, formatted as a decimal string.

_\_BOOT\_ID=_
The kernel boot ID for the boot the message was generated in, formatted as a 128-bit hexadecimal string.

_\_MACHINE\_ID=_
The machine ID of the originating host, as available in
**machine-id**(5).

_\_SYSTEMD\_INVOCATION\_ID=_
The invocation ID for the runtime cycle of the unit the message was generated in, as available to processes of the unit in
_$INVOCATION\_ID_
(see
**systemd.exec**(5)).

_\_HOSTNAME=_
The name of the originating host.

_\_TRANSPORT=_
How the entry was received by the journal service. Valid transports are:

**audit**
for those read from the kernel audit subsystem

**driver**
for internally generated messages

**syslog**
for those received via the local syslog socket with the syslog protocol

**journal**
for those received via the native journal protocol

**stdout**
for those read from a services standard output or error output

**kernel**
for those read from the kernel

_\_STREAM\_ID=_
Only applies to
"_TRANSPORT=stdout"
records: specifies a randomized 128bit ID assigned to the stream connection when it was first created. This ID is useful to reconstruct individual log streams from the log records: all log records carrying the same stream ID originate from the same stream.

_\_LINE\_BREAK=_
Only applies to
"_TRANSPORT=stdout"
records: indicates that the log message in the standard output/error stream was not terminated with a normal newline character ("\en", i.e. ASCII 10). Specifically, when set this field is one of
**nul**
(in case the line was terminated by a NUL byte),
**line-max**
(in case the maximum log line length was reached, as configured with
_LineMax=_
in
**journald.conf**(5)) or
**eof**
(if this was the last log record of a stream and the stream ended without a final newline character). Note that this record is not generated when a normal newline character was used for marking the log line end.

<a name="kernel-journal-fields"></a>

# Kernel Journal Fields


Kernel fields are fields that are used by messages originating in the kernel and stored in the journal.

_\_KERNEL\_DEVICE=_
The kernel device name. If the entry is associated to a block device, the major and minor of the device node, separated by
":"
and prefixed by
"b". Similar for character devices but prefixed by
"c". For network devices, this is the interface index prefixed by
"n". For all other devices, this is the subsystem name prefixed by
"+", followed by
":", followed by the kernel device name.

_\_KERNEL\_SUBSYSTEM=_
The kernel subsystem name.

_\_UDEV\_SYSNAME=_
The kernel device name as it shows up in the device tree below
/sys.

_\_UDEV\_DEVNODE=_
The device node path of this device in
/dev.

_\_UDEV\_DEVLINK=_
Additional symlink names pointing to the device node in
/dev. This field is frequently set more than once per entry.

<a name="fields-to-log-on-behalf-of-a-different-program"></a>

# Fields to Log on Behalf of a Different Program


Fields in this section are used by programs to specify that they are logging on behalf of another program or unit.

Fields used by the
**systemd-coredump**
coredump kernel helper:

_COREDUMP\_UNIT=_, _COREDUMP\_USER\_UNIT=_
Used to annotate messages containing coredumps from system and session units. See
**coredumpctl**(1).

Privileged programs (currently UID 0) may attach
_OBJECT\_PID=_
to a message. This will instruct
**systemd-journald**
to attach additional fields on behalf of the caller:

_OBJECT\_PID=__PID_
PID of the program that this message pertains to.

_OBJECT\_UID=_, _OBJECT\_GID=_, _OBJECT\_COMM=_, _OBJECT\_EXE=_, _OBJECT\_CMDLINE=_, _OBJECT\_AUDIT\_SESSION=_, _OBJECT\_AUDIT\_LOGINUID=_, _OBJECT\_SYSTEMD\_CGROUP=_, _OBJECT\_SYSTEMD\_SESSION=_, _OBJECT\_SYSTEMD\_OWNER\_UID=_, _OBJECT\_SYSTEMD\_UNIT=_, _OBJECT\_SYSTEMD\_USER\_UNIT=_
These are additional fields added automatically by
**systemd-journald**. Their meaning is the same as
_\_UID=_,
_\_GID=_,
_\_COMM=_,
_\_EXE=_,
_\_CMDLINE=_,
_\_AUDIT\_SESSION=_,
_\_AUDIT\_LOGINUID=_,
_\_SYSTEMD\_CGROUP=_,
_\_SYSTEMD\_SESSION=_,
_\_SYSTEMD\_UNIT=_,
_\_SYSTEMD\_USER\_UNIT=_, and
_\_SYSTEMD\_OWNER\_UID=_
as described above, except that the process identified by
_PID_
is described, instead of the process which logged the message.

<a name="address-fields"></a>

# Address Fields


During serialization into external formats, such as the
\m[blue]**Journal Export Format**\m[]\s-2\u[1]\d\s+2
or the
\m[blue]**Journal JSON Format**\m[]\s-2\u[2]\d\s+2, the addresses of journal entries are serialized into fields prefixed with double underscores. Note that these are not proper fields when stored in the journal but for addressing metadata of entries. They cannot be written as part of structured log entries via calls such as
**sd\_journal\_send**(3). They may also not be used as matches for
**sd\_journal\_add\_match**(3)

_\_\_CURSOR=_
The cursor for the entry. A cursor is an opaque text string that uniquely describes the position of an entry in the journal and is portable across machines, platforms and journal files.

_\_\_REALTIME\_TIMESTAMP=_
The wallclock time (**CLOCK\_REALTIME**) at the point in time the entry was received by the journal, in microseconds since the epoch UTC, formatted as a decimal string. This has different properties from
"_SOURCE_REALTIME_TIMESTAMP=", as it is usually a bit later but more likely to be monotonic.

_\_\_MONOTONIC\_TIMESTAMP=_
The monotonic time (**CLOCK\_MONOTONIC**) at the point in time the entry was received by the journal in microseconds, formatted as a decimal string. To be useful as an address for the entry, this should be combined with the boot ID in
"_BOOT_ID=".

<a name="see-also"></a>

# See Also


**systemd**(1),
**journalctl**(1),
**journald.conf**(5),
**sd-journal**(3),
**coredumpctl**(1),
**systemd.directives**(7)

<a name="notes"></a>

# Notes


*  1.  
  Journal Export Format
      https://www.freedesktop.org/wiki/Software/systemd/export
*  2.  
  Journal JSON Format
      https://www.freedesktop.org/wiki/Software/systemd/json
