# qemu-ga-ref.7(7)

 , 2019-08-14

.if n .ad l
.nh

<a name="name"></a>

# Name

qemu-ga-ref - QEMU Guest Agent Protocol Reference

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
General note concerning the use of guest agent interfaces:

unsupported\*(R" is a higher-level error than the errors that individual
commands might document. The caller should always be prepared to receive
\s-1QERR_UNSUPPORTED,\s0 even if the given command doesn't specify it, or doesn't
document any failure mode at all.

**guest-sync-delimited**  (Command)
Echo back a unique integer value, and prepend to response a
leading sentinel byte (0xFF) the client can check scan for.

This is used by clients talking to the guest agent over the
wire to ensure the stream is in sync and doesn't contain stale
data from previous client. It must be issued upon initial
connection, and after any client-side timeouts (including
timeouts on receiving a response to this command).

After issuing this request, all guest agent responses should be
ignored until the response containing the unique integer value
the client passed in is returned. Receival of the 0xFF sentinel
byte must be handled as an indication that the client's
lexer/tokenizer/parser state should be flushed/reset in
preparation for reliably receiving the subsequent response. As
an optimization, clients may opt to ignore all data until a
sentinel value is receiving to avoid unnecessary processing of
stale data.

Similarly, clients should also precede this **request**
with a 0xFF byte to make sure the guest agent flushes any
partially read \s-1JSON\s0 data from a previous client connection.

**Arguments:**
.ie n .IP """id: int""" 4
.el .IP "\f(CWid: int" 4
.IX Item "id: int"
randomly generated 64-bit integer

**Returns:**
The unique integer id passed in by the client

**Since:**
1.1

**guest-sync**  (Command)
Echo back a unique integer value

This is used by clients talking to the guest agent over the
wire to ensure the stream is in sync and doesn't contain stale
data from previous client. All guest agent responses should be
ignored until the provided unique integer value is returned,
and it is up to the client to handle stale whole or
partially-delivered \s-1JSON\s0 text in such a way that this response
can be obtained.

In cases where a partial stale response was previously
received by the client, this cannot always be done reliably.
One particular scenario being if qemu-ga responses are fed
character-by-character into a \s-1JSON\s0 parser. In these situations,
using guest-sync-delimited may be optimal.

For clients that fetch responses line by line and convert them
to \s-1JSON\s0 objects, guest-sync should be sufficient, but note that
in cases where the channel is dirty some attempts at parsing the
response may result in a parser error.

Such clients should also precede this command
with a 0xFF byte to make sure the guest agent flushes any
partially read \s-1JSON\s0 data from a previous session.

**Arguments:**
.ie n .IP """id: int""" 4
.el .IP "\f(CWid: int" 4
.IX Item "id: int"
randomly generated 64-bit integer

**Returns:**
The unique integer id passed in by the client

**Since:**
0.15.0

**guest-ping**  (Command)
Ping the guest agent, a non-error return implies success

**Since:**
0.15.0

**guest-get-time**  (Command)
Get the information about guest's System Time relative to
the Epoch of 1970-01-01 in \s-1UTC.\s0

**Returns:**
Time in nanoseconds.

**Since:**
1.5

**guest-set-time**  (Command)
Set guest time.

When a guest is paused or migrated to a file then loaded
from that file, the guest \s-1OS\s0 has no idea that there
was a big gap in the time. Depending on how long the
gap was, \s-1NTP\s0 might not be able to resynchronize the
guest.

This command tries to set guest's System Time to the
given value, then sets the Hardware Clock (\s-1RTC\s0) to the
current System Time. This will make it easier for a guest
to resynchronize without waiting for \s-1NTP.\s0 If no \f(CW`time\*(C' is
specified, then the time to set is read from \s-1RTC.\s0 However,
this may not be supported on all platforms (i.e. Windows).
If that's the case users are advised to always pass a
value.

**Arguments:**
.ie n .IP """time: int"" (optional)" 4
.el .IP "\f(CWtime: int (optional)" 4
.IX Item "time: int (optional)"
time of nanoseconds, relative to the Epoch
of 1970-01-01 in \s-1UTC.\s0

**Returns:**
Nothing on success.

**Since:**
1.5

**GuestAgentCommandInfo** (Object)

Information about guest agent commands.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
name of the command
.ie n .IP """enabled: boolean""" 4
.el .IP "\f(CWenabled: boolean" 4
.IX Item "enabled: boolean"
whether command is currently enabled by guest admin
.ie n .IP """success-response: boolean""" 4
.el .IP "\f(CWsuccess-response: boolean" 4
.IX Item "success-response: boolean"
whether command returns a response on success
(since 1.7)

**Since:**
1.1.0

**GuestAgentInfo** (Object)

Information about guest agent.

**Members:**
.ie n .IP """version: string""" 4
.el .IP "\f(CWversion: string" 4
.IX Item "version: string"
guest agent version
.ie n .IP """supported_commands: array of GuestAgentCommandInfo""" 4
.el .IP "\f(CWsupported_commands: array of GuestAgentCommandInfo" 4
.IX Item "supported_commands: array of GuestAgentCommandInfo"
Information about guest agent commands

**Since:**
0.15.0

**guest-info**  (Command)
Get some information about the guest agent.

**Returns:**
\f(CW`GuestAgentInfo\*(C'

**Since:**
0.15.0

**guest-shutdown**  (Command)
Initiate guest-activated shutdown. Note: this is an asynchronous
shutdown request, with no guarantee of successful shutdown.

**Arguments:**
.ie n .IP """mode: string"" (optional)" 4
.el .IP "\f(CWmode: string (optional)" 4
.IX Item "mode: string (optional)"
halt\*(R", \*(L"powerdown\*(R" (default), or \*(L"reboot\*(R"

This command does \s-1NOT\s0 return a response on success. Success condition
is indicated by the \s-1VM\s0 exiting with a zero exit status or, when
running with --no-shutdown, by issuing the query-status \s-1QMP\s0 command
to confirm the \s-1VM\s0 status is shutdown\*(R".

**Since:**
0.15.0

**guest-file-open**  (Command)
Open a file in the guest and retrieve a file handle for it

**Arguments:**
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
Full path to the file in the guest to open.
.ie n .IP """mode: string"" (optional)" 4
.el .IP "\f(CWmode: string (optional)" 4
.IX Item "mode: string (optional)"
open mode, as per **fopen()**, r\*(R" is the default.

**Returns:**
Guest file handle on success.

**Since:**
0.15.0

**guest-file-close**  (Command)
Close an open file in the guest

**Arguments:**
.ie n .IP """handle: int""" 4
.el .IP "\f(CWhandle: int" 4
.IX Item "handle: int"
filehandle returned by guest-file-open

**Returns:**
Nothing on success.

**Since:**
0.15.0

**GuestFileRead** (Object)

Result of guest agent file-read operation

**Members:**
.ie n .IP """count: int""" 4
.el .IP "\f(CWcount: int" 4
.IX Item "count: int"
number of bytes read (note: count is **before**
base64-encoding is applied)
.ie n .IP """buf-b64: string""" 4
.el .IP "\f(CWbuf-b64: string" 4
.IX Item "buf-b64: string"
base64-encoded bytes read
.ie n .IP """eof: boolean""" 4
.el .IP "\f(CWeof: boolean" 4
.IX Item "eof: boolean"
whether \s-1EOF\s0 was encountered during read operation.

**Since:**
0.15.0

**guest-file-read**  (Command)
Read from an open file in the guest. Data will be base64-encoded

**Arguments:**
.ie n .IP """handle: int""" 4
.el .IP "\f(CWhandle: int" 4
.IX Item "handle: int"
filehandle returned by guest-file-open
.ie n .IP """count: int"" (optional)" 4
.el .IP "\f(CWcount: int (optional)" 4
.IX Item "count: int (optional)"
maximum number of bytes to read (default is 4KB)

**Returns:**
\f(CW`GuestFileRead\*(C' on success.

**Since:**
0.15.0

**GuestFileWrite** (Object)

Result of guest agent file-write operation

**Members:**
.ie n .IP """count: int""" 4
.el .IP "\f(CWcount: int" 4
.IX Item "count: int"
number of bytes written (note: count is actual bytes
written, after base64-decoding of provided buffer)
.ie n .IP """eof: boolean""" 4
.el .IP "\f(CWeof: boolean" 4
.IX Item "eof: boolean"
whether \s-1EOF\s0 was encountered during write operation.

**Since:**
0.15.0

**guest-file-write**  (Command)
Write to an open file in the guest.

**Arguments:**
.ie n .IP """handle: int""" 4
.el .IP "\f(CWhandle: int" 4
.IX Item "handle: int"
filehandle returned by guest-file-open
.ie n .IP """buf-b64: string""" 4
.el .IP "\f(CWbuf-b64: string" 4
.IX Item "buf-b64: string"
base64-encoded string representing data to be written
.ie n .IP """count: int"" (optional)" 4
.el .IP "\f(CWcount: int (optional)" 4
.IX Item "count: int (optional)"
bytes to write (actual bytes, after base64-decode),
default is all content in buf-b64 buffer after base64 decoding

**Returns:**
\f(CW`GuestFileWrite\*(C' on success.

**Since:**
0.15.0

**GuestFileSeek** (Object)

Result of guest agent file-seek operation

**Members:**
.ie n .IP """position: int""" 4
.el .IP "\f(CWposition: int" 4
.IX Item "position: int"
current file position
.ie n .IP """eof: boolean""" 4
.el .IP "\f(CWeof: boolean" 4
.IX Item "eof: boolean"
whether \s-1EOF\s0 was encountered during file seek

**Since:**
0.15.0

**QGASeek** (Enum)

Symbolic names for use in \f(CW`guest-file-seek\*(C'

**Values:**
.ie n .IP """set""" 4
.el .IP "\f(CWset" 4
.IX Item "set"
Set to the specified offset (same effect as 'whence':0)
.ie n .IP """cur""" 4
.el .IP "\f(CWcur" 4
.IX Item "cur"
Add offset to the current location (same effect as 'whence':1)
.ie n .IP """end""" 4
.el .IP "\f(CWend" 4
.IX Item "end"
Add offset to the end of the file (same effect as 'whence':2)

**Since:**
2.6

**GuestFileWhence** (Alternate)

Controls the meaning of offset to \f(CW`guest-file-seek\*(C'.

**Members:**
.ie n .IP """value: int""" 4
.el .IP "\f(CWvalue: int" 4
.IX Item "value: int"
Integral value (0 for set, 1 for cur, 2 for end), available
for historical reasons, and might differ from the host's or
guest's SEEK_* values (since: 0.15)
.ie n .IP """name: QGASeek""" 4
.el .IP "\f(CWname: QGASeek" 4
.IX Item "name: QGASeek"
Symbolic name, and preferred interface

**Since:**
2.6

**guest-file-seek**  (Command)
Seek to a position in the file, as with **fseek()**, and return the
current file position afterward. Also encapsulates **ftell()**'s
functionality, with offset=0 and whence=1.

**Arguments:**
.ie n .IP """handle: int""" 4
.el .IP "\f(CWhandle: int" 4
.IX Item "handle: int"
filehandle returned by guest-file-open
.ie n .IP """offset: int""" 4
.el .IP "\f(CWoffset: int" 4
.IX Item "offset: int"
bytes to skip over in the file stream
.ie n .IP """whence: GuestFileWhence""" 4
.el .IP "\f(CWwhence: GuestFileWhence" 4
.IX Item "whence: GuestFileWhence"
Symbolic or numeric code for interpreting offset

**Returns:**
\f(CW`GuestFileSeek\*(C' on success.

**Since:**
0.15.0

**guest-file-flush**  (Command)
Write file changes bufferred in userspace to disk/kernel buffers

**Arguments:**
.ie n .IP """handle: int""" 4
.el .IP "\f(CWhandle: int" 4
.IX Item "handle: int"
filehandle returned by guest-file-open

**Returns:**
Nothing on success.

**Since:**
0.15.0

**GuestFsfreezeStatus** (Enum)

An enumeration of filesystem freeze states

**Values:**
.ie n .IP """thawed""" 4
.el .IP "\f(CWthawed" 4
.IX Item "thawed"
filesystems thawed/unfrozen
.ie n .IP """frozen""" 4
.el .IP "\f(CWfrozen" 4
.IX Item "frozen"
all non-network guest filesystems frozen

**Since:**
0.15.0

**guest-fsfreeze-status**  (Command)
Get guest fsfreeze state. error state indicates

**Returns:**
GuestFsfreezeStatus (thawed\*(R", \*(L"frozen\*(R", etc., as defined below)

**Note:**
This may fail to properly report the current state as a result of
some other guest processes having issued an fs freeze/thaw.

**Since:**
0.15.0

**guest-fsfreeze-freeze**  (Command)
Sync and freeze all freezable, local guest filesystems. If this
command succeeded, you may call \f(CW`guest-fsfreeze-thaw\*(C' later to
unfreeze.

**Note:**
On Windows, the command is implemented with the help of a
Volume Shadow-copy Service \s-1DLL\s0 helper. The frozen state is limited
for up to 10 seconds by \s-1VSS.\s0

**Returns:**
Number of file systems currently frozen. On error, all filesystems
will be thawed. If no filesystems are frozen as a result of this call,
then \f(CW`guest-fsfreeze-status\*(C' will remain \*(L"thawed\*(R" and calling
\f(CW`guest-fsfreeze-thaw\*(C' is not necessary.

**Since:**
0.15.0

**guest-fsfreeze-freeze-list**  (Command)
Sync and freeze specified guest filesystems.
See also \f(CW`guest-fsfreeze-freeze\*(C'.

**Arguments:**
.ie n .IP """mountpoints: array of string"" (optional)" 4
.el .IP "\f(CWmountpoints: array of string (optional)" 4
.IX Item "mountpoints: array of string (optional)"
an array of mountpoints of filesystems to be frozen.
If omitted, every mounted filesystem is frozen.
Invalid mount points are ignored.

**Returns:**
Number of file systems currently frozen. On error, all filesystems
will be thawed.

**Since:**
2.2

**guest-fsfreeze-thaw**  (Command)
Unfreeze all frozen guest filesystems

**Returns:**
Number of file systems thawed by this call

**Note:**
if return value does not match the previous call to
guest-fsfreeze-freeze, this likely means some freezable
filesystems were unfrozen before this call, and that the
filesystem state may have changed before issuing this
command.

**Since:**
0.15.0

**GuestFilesystemTrimResult** (Object)

**Members:**
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
path that was trimmed
.ie n .IP """error: string"" (optional)" 4
.el .IP "\f(CWerror: string (optional)" 4
.IX Item "error: string (optional)"
an error message when trim failed
.ie n .IP """trimmed: int"" (optional)" 4
.el .IP "\f(CWtrimmed: int (optional)" 4
.IX Item "trimmed: int (optional)"
bytes trimmed for this path
.ie n .IP """minimum: int"" (optional)" 4
.el .IP "\f(CWminimum: int (optional)" 4
.IX Item "minimum: int (optional)"
reported effective minimum for this path

**Since:**
2.4

**GuestFilesystemTrimResponse** (Object)

**Members:**
.ie n .IP """paths: array of GuestFilesystemTrimResult""" 4
.el .IP "\f(CWpaths: array of GuestFilesystemTrimResult" 4
.IX Item "paths: array of GuestFilesystemTrimResult"
list of \f(CW`GuestFilesystemTrimResult\*(C' per path that was trimmed

**Since:**
2.4

**guest-fstrim**  (Command)
Discard (or trim\*(R") blocks which are not in use by the filesystem.

**Arguments:**
.ie n .IP """minimum: int"" (optional)" 4
.el .IP "\f(CWminimum: int (optional)" 4
.IX Item "minimum: int (optional)"
Minimum contiguous free range to discard, in bytes. Free ranges
smaller than this may be ignored (this is a hint and the guest
may not respect it).  By increasing this value, the fstrim
operation will complete more quickly for filesystems with badly
fragmented free space, although not all blocks will be discarded.
The default value is zero, meaning discard every free block\*(R".

**Returns:**
A \f(CW`GuestFilesystemTrimResponse\*(C' which contains the
status of all trimmed paths. (since 2.4)

**Since:**
1.2

**guest-suspend-disk**  (Command)
Suspend guest to disk.

This command attempts to suspend the guest using three strategies, in this
order:

* systemd hibernate
* pm-utils (via pm-hibernate)
* manual write into sysfs

This command does \s-1NOT\s0 return a response on success. There is a high chance
the command succeeded if the \s-1VM\s0 exits with a zero exit status or, when
running with --no-shutdown, by issuing the query-status \s-1QMP\s0 command to
to confirm the \s-1VM\s0 status is shutdown\*(R". However, the \s-1VM\s0 could also exit
(or set its status to shutdown\*(R") due to other reasons.

The following errors may be returned:
If suspend to disk is not supported, Unsupported

**Notes:**
It's strongly recommended to issue the guest-sync command before
sending commands when the guest resumes

**Since:**
1.1

**guest-suspend-ram**  (Command)
Suspend guest to ram.

This command attempts to suspend the guest using three strategies, in this
order:

* systemd suspend
* pm-utils (via pm-suspend)
* manual write into sysfs

\s-1IMPORTANT:\s0 guest-suspend-ram requires \s-1QEMU\s0 to support the 'system_wakeup'
command.  Thus, it's **required** to query \s-1QEMU\s0 for the presence of the
'system_wakeup' command before issuing guest-suspend-ram.

This command does \s-1NOT\s0 return a response on success. There are two options
to check for success:

* 1.  
  Wait for the \s-1SUSPEND QMP\s0 event from \s-1QEMU\s0
* 2.  
  Issue the query-status \s-1QMP\s0 command to confirm the \s-1VM\s0 status is
  suspended\*(R"

The following errors may be returned:
If suspend to ram is not supported, Unsupported

**Notes:**
It's strongly recommended to issue the guest-sync command before
sending commands when the guest resumes

**Since:**
1.1

**guest-suspend-hybrid**  (Command)
Save guest state to disk and suspend to ram.

This command attempts to suspend the guest by executing, in this order:

* systemd hybrid-sleep
* pm-utils (via pm-suspend-hybrid)

\s-1IMPORTANT:\s0 guest-suspend-hybrid requires \s-1QEMU\s0 to support the 'system_wakeup'
command.  Thus, it's **required** to query \s-1QEMU\s0 for the presence of the
'system_wakeup' command before issuing guest-suspend-hybrid.

This command does \s-1NOT\s0 return a response on success. There are two options
to check for success:

* 1.  
  Wait for the \s-1SUSPEND QMP\s0 event from \s-1QEMU\s0
* 2.  
  Issue the query-status \s-1QMP\s0 command to confirm the \s-1VM\s0 status is
  suspended\*(R"

The following errors may be returned:
If hybrid suspend is not supported, Unsupported

**Notes:**
It's strongly recommended to issue the guest-sync command before
sending commands when the guest resumes

**Since:**
1.1

**GuestIpAddressType** (Enum)

An enumeration of supported \s-1IP\s0 address types

**Values:**
.ie n .IP """ipv4""" 4
.el .IP "\f(CWipv4" 4
.IX Item "ipv4"
\s-1IP\s0 version 4
.ie n .IP """ipv6""" 4
.el .IP "\f(CWipv6" 4
.IX Item "ipv6"
\s-1IP\s0 version 6

**Since:**
1.1

**GuestIpAddress** (Object)

**Members:**
.ie n .IP """ip-address: string""" 4
.el .IP "\f(CWip-address: string" 4
.IX Item "ip-address: string"
\s-1IP\s0 address
.ie n .IP """ip-address-type: GuestIpAddressType""" 4
.el .IP "\f(CWip-address-type: GuestIpAddressType" 4
.IX Item "ip-address-type: GuestIpAddressType"
Type of \f(CW`ip-address\*(C' (e.g. ipv4, ipv6)
.ie n .IP """prefix: int""" 4
.el .IP "\f(CWprefix: int" 4
.IX Item "prefix: int"
Network prefix length of \f(CW`ip-address\*(C'

**Since:**
1.1

**GuestNetworkInterfaceStat** (Object)

**Members:**
.ie n .IP """rx-bytes: int""" 4
.el .IP "\f(CWrx-bytes: int" 4
.IX Item "rx-bytes: int"
total bytes received
.ie n .IP """rx-packets: int""" 4
.el .IP "\f(CWrx-packets: int" 4
.IX Item "rx-packets: int"
total packets received
.ie n .IP """rx-errs: int""" 4
.el .IP "\f(CWrx-errs: int" 4
.IX Item "rx-errs: int"
bad packets received
.ie n .IP """rx-dropped: int""" 4
.el .IP "\f(CWrx-dropped: int" 4
.IX Item "rx-dropped: int"
receiver dropped packets
.ie n .IP """tx-bytes: int""" 4
.el .IP "\f(CWtx-bytes: int" 4
.IX Item "tx-bytes: int"
total bytes transmitted
.ie n .IP """tx-packets: int""" 4
.el .IP "\f(CWtx-packets: int" 4
.IX Item "tx-packets: int"
total packets transmitted
.ie n .IP """tx-errs: int""" 4
.el .IP "\f(CWtx-errs: int" 4
.IX Item "tx-errs: int"
packet transmit problems
.ie n .IP """tx-dropped: int""" 4
.el .IP "\f(CWtx-dropped: int" 4
.IX Item "tx-dropped: int"
dropped packets transmitted

**Since:**
2.11

**GuestNetworkInterface** (Object)

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
The name of interface for which info are being delivered
.ie n .IP """hardware-address: string"" (optional)" 4
.el .IP "\f(CWhardware-address: string (optional)" 4
.IX Item "hardware-address: string (optional)"
Hardware address of \f(CW`name\*(C'
.ie n .IP """ip-addresses: array of GuestIpAddress"" (optional)" 4
.el .IP "\f(CWip-addresses: array of GuestIpAddress (optional)" 4
.IX Item "ip-addresses: array of GuestIpAddress (optional)"
List of addresses assigned to \f(CW`name\*(C'
.ie n .IP """statistics: GuestNetworkInterfaceStat"" (optional)" 4
.el .IP "\f(CWstatistics: GuestNetworkInterfaceStat (optional)" 4
.IX Item "statistics: GuestNetworkInterfaceStat (optional)"
various statistic counters related to \f(CW`name\*(C'
(since 2.11)

**Since:**
1.1

**guest-network-get-interfaces**  (Command)
Get list of guest \s-1IP\s0 addresses, \s-1MAC\s0 addresses
and netmasks.

**Returns:**
List of GuestNetworkInfo on success.

**Since:**
1.1

**GuestLogicalProcessor** (Object)

**Members:**
.ie n .IP """logical-id: int""" 4
.el .IP "\f(CWlogical-id: int" 4
.IX Item "logical-id: int"
Arbitrary guest-specific unique identifier of the \s-1VCPU.\s0
.ie n .IP """online: boolean""" 4
.el .IP "\f(CWonline: boolean" 4
.IX Item "online: boolean"
Whether the \s-1VCPU\s0 is enabled.
.ie n .IP """can-offline: boolean"" (optional)" 4
.el .IP "\f(CWcan-offline: boolean (optional)" 4
.IX Item "can-offline: boolean (optional)"
Whether offlining the \s-1VCPU\s0 is possible. This member
is always filled in by the guest agent when the structure is
returned, and always ignored on input (hence it can be omitted
then).

**Since:**
1.5

**guest-get-vcpus**  (Command)
Retrieve the list of the guest's logical processors.

This is a read-only operation.

**Returns:**
The list of all VCPUs the guest knows about. Each \s-1VCPU\s0 is put on the
list exactly once, but their order is unspecified.

**Since:**
1.5

**guest-set-vcpus**  (Command)
Attempt to reconfigure (currently: enable/disable) logical processors inside
the guest.

The input list is processed node by node in order. In each node \f(CW`logical-id\*(C'
is used to look up the guest \s-1VCPU,\s0 for which \f(CW`online\*(C' specifies the requested
state. The set of distinct \f(CW`logical-id\*(C''s is only required to be a subset of
the guest-supported identifiers. There's no restriction on list length or on
repeating the same \f(CW`logical-id\*(C' (with possibly different \f(CW\*(C\`online\*(C' field).
Preferably the input list should describe a modified subset of
\f(CW`guest-get-vcpus\*(C'' return value.

**Arguments:**
.ie n .IP """vcpus: array of GuestLogicalProcessor""" 4
.el .IP "\f(CWvcpus: array of GuestLogicalProcessor" 4
.IX Item "vcpus: array of GuestLogicalProcessor"
Not documented

**Returns:**
The length of the initial sublist that has been successfully
processed. The guest agent maximizes this value. Possible cases:

* 0:              if the \f(CW`vcpus\*(C' list was empty on input. Guest state
  has not been changed. Otherwise,
* Error:          processing the first node of \f(CW`vcpus\*(C' failed for the
  reason returned. Guest state has not been changed.
  Otherwise,
* &lt; length(\f(CW`vcpus\*(C'): more than zero initial nodes have been processed,
  but not the entire \f(CW`vcpus\*(C' list. Guest state has
  changed accordingly. To retrieve the error
  (assuming it persists), repeat the call with the
  successfully processed initial sublist removed.
  Otherwise,
* length(\f(CW`vcpus\*(C'): call successful.

**Since:**
1.5

**GuestDiskBusType** (Enum)

An enumeration of bus type of disks

**Values:**
.ie n .IP """ide""" 4
.el .IP "\f(CWide" 4
.IX Item "ide"
\s-1IDE\s0 disks
.ie n .IP """fdc""" 4
.el .IP "\f(CWfdc" 4
.IX Item "fdc"
floppy disks
.ie n .IP """scsi""" 4
.el .IP "\f(CWscsi" 4
.IX Item "scsi"
\s-1SCSI\s0 disks
.ie n .IP """virtio""" 4
.el .IP "\f(CWvirtio" 4
.IX Item "virtio"
virtio disks
.ie n .IP """xen""" 4
.el .IP "\f(CWxen" 4
.IX Item "xen"
Xen disks
.ie n .IP """usb""" 4
.el .IP "\f(CWusb" 4
.IX Item "usb"
\s-1USB\s0 disks
.ie n .IP """uml""" 4
.el .IP "\f(CWuml" 4
.IX Item "uml"
\s-1UML\s0 disks
.ie n .IP """sata""" 4
.el .IP "\f(CWsata" 4
.IX Item "sata"
\s-1SATA\s0 disks
.ie n .IP """sd""" 4
.el .IP "\f(CWsd" 4
.IX Item "sd"
\s-1SD\s0 cards
.ie n .IP """unknown""" 4
.el .IP "\f(CWunknown" 4
.IX Item "unknown"
Unknown bus type
.ie n .IP """ieee1394""" 4
.el .IP "\f(CWieee1394" 4
.IX Item "ieee1394"
Win \s-1IEEE 1394\s0 bus type
.ie n .IP """ssa""" 4
.el .IP "\f(CWssa" 4
.IX Item "ssa"
Win \s-1SSA\s0 bus type
.ie n .IP """fibre""" 4
.el .IP "\f(CWfibre" 4
.IX Item "fibre"
Win fiber channel bus type
.ie n .IP """raid""" 4
.el .IP "\f(CWraid" 4
.IX Item "raid"
Win \s-1RAID\s0 bus type
.ie n .IP """iscsi""" 4
.el .IP "\f(CWiscsi" 4
.IX Item "iscsi"
Win iScsi bus type
.ie n .IP """sas""" 4
.el .IP "\f(CWsas" 4
.IX Item "sas"
Win serial-attaches \s-1SCSI\s0 bus type
.ie n .IP """mmc""" 4
.el .IP "\f(CWmmc" 4
.IX Item "mmc"
Win multimedia card (\s-1MMC\s0) bus type
.ie n .IP """virtual""" 4
.el .IP "\f(CWvirtual" 4
.IX Item "virtual"
Win virtual bus type
\f(CW`file-backed\*(C' virtual: Win file-backed bus type
.ie n .IP """file-backed-virtual""" 4
.el .IP "\f(CWfile-backed-virtual" 4
.IX Item "file-backed-virtual"
Not documented

**Since:**
2.2; 'Unknown' and all entries below since 2.4

**GuestPCIAddress** (Object)

**Members:**
.ie n .IP """domain: int""" 4
.el .IP "\f(CWdomain: int" 4
.IX Item "domain: int"
domain id
.ie n .IP """bus: int""" 4
.el .IP "\f(CWbus: int" 4
.IX Item "bus: int"
bus id
.ie n .IP """slot: int""" 4
.el .IP "\f(CWslot: int" 4
.IX Item "slot: int"
slot id
.ie n .IP """function: int""" 4
.el .IP "\f(CWfunction: int" 4
.IX Item "function: int"
function id

**Since:**
2.2

**GuestDiskAddress** (Object)

**Members:**
.ie n .IP """pci-controller: GuestPCIAddress""" 4
.el .IP "\f(CWpci-controller: GuestPCIAddress" 4
.IX Item "pci-controller: GuestPCIAddress"
controller's \s-1PCI\s0 address
.ie n .IP """bus-type: GuestDiskBusType""" 4
.el .IP "\f(CWbus-type: GuestDiskBusType" 4
.IX Item "bus-type: GuestDiskBusType"
bus type
.ie n .IP """bus: int""" 4
.el .IP "\f(CWbus: int" 4
.IX Item "bus: int"
bus id
.ie n .IP """target: int""" 4
.el .IP "\f(CWtarget: int" 4
.IX Item "target: int"
target id
.ie n .IP """unit: int""" 4
.el .IP "\f(CWunit: int" 4
.IX Item "unit: int"
unit id
.ie n .IP """serial: string"" (optional)" 4
.el .IP "\f(CWserial: string (optional)" 4
.IX Item "serial: string (optional)"
serial number (since: 3.1)
.ie n .IP """dev: string"" (optional)" 4
.el .IP "\f(CWdev: string (optional)" 4
.IX Item "dev: string (optional)"
device node (\s-1POSIX\s0) or device \s-1UNC\s0 (Windows) (since: 3.1)

**Since:**
2.2

**GuestFilesystemInfo** (Object)

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
disk name
.ie n .IP """mountpoint: string""" 4
.el .IP "\f(CWmountpoint: string" 4
.IX Item "mountpoint: string"
mount point path
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
file system type string
.ie n .IP """used-bytes: int"" (optional)" 4
.el .IP "\f(CWused-bytes: int (optional)" 4
.IX Item "used-bytes: int (optional)"
file system used bytes (since 3.0)
.ie n .IP """total-bytes: int"" (optional)" 4
.el .IP "\f(CWtotal-bytes: int (optional)" 4
.IX Item "total-bytes: int (optional)"
non-root file system total bytes (since 3.0)
.ie n .IP """disk: array of GuestDiskAddress""" 4
.el .IP "\f(CWdisk: array of GuestDiskAddress" 4
.IX Item "disk: array of GuestDiskAddress"
an array of disk hardware information that the volume lies on,
which may be empty if the disk type is not supported

**Since:**
2.2

**guest-get-fsinfo**  (Command)

**Returns:**
The list of filesystems information mounted in the guest.
The returned mountpoints may be specified to
\f(CW`guest-fsfreeze-freeze-list\*(C'.
Network filesystems (such as \s-1CIFS\s0 and \s-1NFS\s0) are not listed.

**Since:**
2.2

**guest-set-user-password**  (Command)

**Arguments:**
.ie n .IP """username: string""" 4
.el .IP "\f(CWusername: string" 4
.IX Item "username: string"
the user account whose password to change
.ie n .IP """password: string""" 4
.el .IP "\f(CWpassword: string" 4
.IX Item "password: string"
the new password entry string, base64 encoded
.ie n .IP """crypted: boolean""" 4
.el .IP "\f(CWcrypted: boolean" 4
.IX Item "crypted: boolean"
true if password is already **crypt()**d, false if raw

If the \f(CW`crypted\*(C' flag is true, it is the caller's responsibility
to ensure the correct **crypt()** encryption scheme is used. This
command does not attempt to interpret or report on the encryption
scheme. Refer to the documentation of the guest operating system
in question to determine what is supported.

Not all guest operating systems will support use of the
\f(CW`crypted\*(C' flag, as they may require the clear-text password

The \f(CW`password\*(C' parameter must always be base64 encoded before
transmission, even if already **crypt()**d, to ensure it is 8-bit
safe when passed as \s-1JSON.\s0

**Returns:**
Nothing on success.

**Since:**
2.3

**GuestMemoryBlock** (Object)

**Members:**
.ie n .IP """phys-index: int""" 4
.el .IP "\f(CWphys-index: int" 4
.IX Item "phys-index: int"
Arbitrary guest-specific unique identifier of the \s-1MEMORY BLOCK.\s0
.ie n .IP """online: boolean""" 4
.el .IP "\f(CWonline: boolean" 4
.IX Item "online: boolean"
Whether the \s-1MEMORY BLOCK\s0 is enabled in guest.
.ie n .IP """can-offline: boolean"" (optional)" 4
.el .IP "\f(CWcan-offline: boolean (optional)" 4
.IX Item "can-offline: boolean (optional)"
Whether offlining the \s-1MEMORY BLOCK\s0 is possible.
This member is always filled in by the guest agent when the
structure is returned, and always ignored on input (hence it
can be omitted then).

**Since:**
2.3

**guest-get-memory-blocks**  (Command)
Retrieve the list of the guest's memory blocks.

This is a read-only operation.

**Returns:**
The list of all memory blocks the guest knows about.
Each memory block is put on the list exactly once, but their order
is unspecified.

**Since:**
2.3

**GuestMemoryBlockResponseType** (Enum)

An enumeration of memory block operation result.

**Values:**
.ie n .IP """success""" 4
.el .IP "\f(CWsuccess" 4
.IX Item "success"
the operation of online/offline memory block is successful.
.ie n .IP """not-found""" 4
.el .IP "\f(CWnot-found" 4
.IX Item "not-found"
can't find the corresponding memoryXXX directory in sysfs.
.ie n .IP """operation-not-supported""" 4
.el .IP "\f(CWoperation-not-supported" 4
.IX Item "operation-not-supported"
for some old kernels, it does not support
online or offline memory block.
.ie n .IP """operation-failed""" 4
.el .IP "\f(CWoperation-failed" 4
.IX Item "operation-failed"
the operation of online/offline memory block fails,
because of some errors happen.

**Since:**
2.3

**GuestMemoryBlockResponse** (Object)

**Members:**
.ie n .IP """phys-index: int""" 4
.el .IP "\f(CWphys-index: int" 4
.IX Item "phys-index: int"
same with the 'phys-index' member of \f(CW`GuestMemoryBlock\*(C'.
.ie n .IP """response: GuestMemoryBlockResponseType""" 4
.el .IP "\f(CWresponse: GuestMemoryBlockResponseType" 4
.IX Item "response: GuestMemoryBlockResponseType"
the result of memory block operation.
.ie n .IP """error-code: int"" (optional)" 4
.el .IP "\f(CWerror-code: int (optional)" 4
.IX Item "error-code: int (optional)"
the error number.
When memory block operation fails, we assign the value of
'errno' to this member, it indicates what goes wrong.
When the operation succeeds, it will be omitted.

**Since:**
2.3

**guest-set-memory-blocks**  (Command)
Attempt to reconfigure (currently: enable/disable) state of memory blocks
inside the guest.

The input list is processed node by node in order. In each node \f(CW`phys-index\*(C'
is used to look up the guest \s-1MEMORY BLOCK,\s0 for which \f(CW`online\*(C' specifies the
requested state. The set of distinct \f(CW`phys-index\*(C''s is only required to be a
subset of the guest-supported identifiers. There's no restriction on list
length or on repeating the same \f(CW`phys-index\*(C' (with possibly different \f(CW\*(C\`online\*(C'
field).
Preferably the input list should describe a modified subset of
\f(CW`guest-get-memory-blocks\*(C'' return value.

**Arguments:**
.ie n .IP """mem-blks: array of GuestMemoryBlock""" 4
.el .IP "\f(CWmem-blks: array of GuestMemoryBlock" 4
.IX Item "mem-blks: array of GuestMemoryBlock"
Not documented

**Returns:**
The operation results, it is a list of \f(CW`GuestMemoryBlockResponse\*(C',
which is corresponding to the input list.

Note: it will return \s-1NULL\s0 if the \f(CW`mem-blks\*(C' list was empty on input,
or there is an error, and in this case, guest state will not be
changed.

**Since:**
2.3

**GuestMemoryBlockInfo** (Object)

**Members:**
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
the size (in bytes) of the guest memory blocks,
which are the minimal units of memory block online/offline
operations (also called Logical Memory Hotplug).

**Since:**
2.3

**guest-get-memory-block-info**  (Command)
Get information relating to guest memory blocks.

**Returns:**
\f(CW`GuestMemoryBlockInfo\*(C'

**Since:**
2.3

**GuestExecStatus** (Object)

**Members:**
.ie n .IP """exited: boolean""" 4
.el .IP "\f(CWexited: boolean" 4
.IX Item "exited: boolean"
true if process has already terminated.
.ie n .IP """exitcode: int"" (optional)" 4
.el .IP "\f(CWexitcode: int (optional)" 4
.IX Item "exitcode: int (optional)"
process exit code if it was normally terminated.
.ie n .IP """signal: int"" (optional)" 4
.el .IP "\f(CWsignal: int (optional)" 4
.IX Item "signal: int (optional)"
signal number (linux) or unhandled exception code
(windows) if the process was abnormally terminated.
.ie n .IP """out-data: string"" (optional)" 4
.el .IP "\f(CWout-data: string (optional)" 4
.IX Item "out-data: string (optional)"
base64-encoded stdout of the process
.ie n .IP """err-data: string"" (optional)" 4
.el .IP "\f(CWerr-data: string (optional)" 4
.IX Item "err-data: string (optional)"
base64-encoded stderr of the process
Note: \f(CW`out-data\*(C' and \f(CW\*(C\`err-data\*(C' are present only
if 'capture-output' was specified for 'guest-exec'
.ie n .IP """out-truncated: boolean"" (optional)" 4
.el .IP "\f(CWout-truncated: boolean (optional)" 4
.IX Item "out-truncated: boolean (optional)"
true if stdout was not fully captured
due to size limitation.
.ie n .IP """err-truncated: boolean"" (optional)" 4
.el .IP "\f(CWerr-truncated: boolean (optional)" 4
.IX Item "err-truncated: boolean (optional)"
true if stderr was not fully captured
due to size limitation.

**Since:**
2.5

**guest-exec-status**  (Command)
Check status of process associated with \s-1PID\s0 retrieved via guest-exec.
Reap the process and associated metadata if it has exited.

**Arguments:**
.ie n .IP """pid: int""" 4
.el .IP "\f(CWpid: int" 4
.IX Item "pid: int"
pid returned from guest-exec

**Returns:**
GuestExecStatus on success.

**Since:**
2.5

**GuestExec** (Object)

**Members:**
.ie n .IP """pid: int""" 4
.el .IP "\f(CWpid: int" 4
.IX Item "pid: int"
pid of child process in guest \s-1OS\s0

**Since:**
2.5

**guest-exec**  (Command)
Execute a command in the guest

**Arguments:**
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
path or executable name to execute
.ie n .IP """arg: array of string"" (optional)" 4
.el .IP "\f(CWarg: array of string (optional)" 4
.IX Item "arg: array of string (optional)"
argument list to pass to executable
.ie n .IP """env: array of string"" (optional)" 4
.el .IP "\f(CWenv: array of string (optional)" 4
.IX Item "env: array of string (optional)"
environment variables to pass to executable
.ie n .IP """input-data: string"" (optional)" 4
.el .IP "\f(CWinput-data: string (optional)" 4
.IX Item "input-data: string (optional)"
data to be passed to process stdin (base64 encoded)
.ie n .IP """capture-output: boolean"" (optional)" 4
.el .IP "\f(CWcapture-output: boolean (optional)" 4
.IX Item "capture-output: boolean (optional)"
bool flag to enable capture of
stdout/stderr of running process. defaults to false.

**Returns:**
\s-1PID\s0 on success.

**Since:**
2.5

**GuestHostName** (Object)

**Members:**
.ie n .IP """host-name: string""" 4
.el .IP "\f(CWhost-name: string" 4
.IX Item "host-name: string"
Fully qualified domain name of the guest \s-1OS\s0

**Since:**
2.10

**guest-get-host-name**  (Command)
Return a name for the machine.

The returned name is not necessarily a fully-qualified domain name, or even
present in \s-1DNS\s0 or some other name service at all. It need not even be unique
on your local network or site, but usually it is.

**Returns:**
the host name of the machine on success

**Since:**
2.10

**GuestUser** (Object)

**Members:**
.ie n .IP """user: string""" 4
.el .IP "\f(CWuser: string" 4
.IX Item "user: string"
Username
.ie n .IP """domain: string"" (optional)" 4
.el .IP "\f(CWdomain: string (optional)" 4
.IX Item "domain: string (optional)"
Logon domain (windows only)
.ie n .IP """login-time: number""" 4
.el .IP "\f(CWlogin-time: number" 4
.IX Item "login-time: number"
Time of login of this user on the computer. If multiple
instances of the user are logged in, the earliest login time is
reported. The value is in fractional seconds since epoch time.

**Since:**
2.10

**guest-get-users**  (Command)
Retrieves a list of currently active users on the \s-1VM.\s0

**Returns:**
A unique list of users.

**Since:**
2.10

**GuestTimezone** (Object)

**Members:**
.ie n .IP """zone: string"" (optional)" 4
.el .IP "\f(CWzone: string (optional)" 4
.IX Item "zone: string (optional)"
Timezone name. These values may differ depending on guest/OS and
should only be used for informational purposes.
.ie n .IP """offset: int""" 4
.el .IP "\f(CWoffset: int" 4
.IX Item "offset: int"
Offset to \s-1UTC\s0 in seconds, negative numbers for time zones west of
\s-1GMT,\s0 positive numbers for east

**Since:**
2.10

**guest-get-timezone**  (Command)
Retrieves the timezone information from the guest.

**Returns:**
A GuestTimezone dictionary.

**Since:**
2.10

**GuestOSInfo** (Object)

**Members:**
.ie n .IP """kernel-release: string"" (optional)" 4
.el .IP "\f(CWkernel-release: string (optional)" 4
.IX Item "kernel-release: string (optional)"

* ·  
  \s-1POSIX:\s0 release field returned by **uname**\|(2)
* ·  
  Windows: build number of the \s-1OS\s0
.ie n .IP """kernel-version: string"" (optional)" 4
.el .IP "\f(CWkernel-version: string (optional)" 4
.IX Item "kernel-version: string (optional)"

* ·  
  \s-1POSIX:\s0 version field returned by **uname**\|(2)
* ·  
  Windows: version number of the \s-1OS\s0
.ie n .IP """machine: string"" (optional)" 4
.el .IP "\f(CWmachine: string (optional)" 4
.IX Item "machine: string (optional)"

* ·  
  \s-1POSIX:\s0 machine field returned by **uname**\|(2)
* ·  
  Windows: one of x86, x86_64, arm, ia64
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"

* ·  
  \s-1POSIX:\s0 as defined by **os-release**\|(5)
* ·  
  Windows: contains string mswindows\*(R"
.ie n .IP """name: string"" (optional)" 4
.el .IP "\f(CWname: string (optional)" 4
.IX Item "name: string (optional)"

* ·  
  \s-1POSIX:\s0 as defined by **os-release**\|(5)
* ·  
  Windows: contains string Microsoft Windows\*(R"
.ie n .IP """pretty-name: string"" (optional)" 4
.el .IP "\f(CWpretty-name: string (optional)" 4
.IX Item "pretty-name: string (optional)"

* ·  
  \s-1POSIX:\s0 as defined by **os-release**\|(5)
* ·  
  Windows: product name, e.g. Microsoft Windows 10 Enterprise\*(R"
.ie n .IP """version: string"" (optional)" 4
.el .IP "\f(CWversion: string (optional)" 4
.IX Item "version: string (optional)"

* ·  
  \s-1POSIX:\s0 as defined by **os-release**\|(5)
* ·  
  Windows: long version string, e.g. Microsoft Windows Server 2008\*(R"
.ie n .IP """version-id: string"" (optional)" 4
.el .IP "\f(CWversion-id: string (optional)" 4
.IX Item "version-id: string (optional)"

* ·  
  \s-1POSIX:\s0 as defined by **os-release**\|(5)
* ·  
  Windows: short version identifier, e.g. 7\*(R" or \*(L"20012r2\*(R"
.ie n .IP """variant: string"" (optional)" 4
.el .IP "\f(CWvariant: string (optional)" 4
.IX Item "variant: string (optional)"

* ·  
  \s-1POSIX:\s0 as defined by **os-release**\|(5)
* ·  
  Windows: contains string server\*(R" or \*(L"client\*(R"
.ie n .IP """variant-id: string"" (optional)" 4
.el .IP "\f(CWvariant-id: string (optional)" 4
.IX Item "variant-id: string (optional)"

* ·  
  \s-1POSIX:\s0 as defined by **os-release**\|(5)
* ·  
  Windows: contains string server\*(R" or \*(L"client\*(R"

**Notes:**
On \s-1POSIX\s0 systems the fields \f(CW`id\*(C', \f(CW\*(C\`name\*(C', \f(CW\*(C\`pretty-name\*(C', \f(CW\*(C\`version\*(C', \f(CW\*(C\`version-id\*(C',
\f(CW`variant\*(C' and \f(CW\*(C\`variant-id\*(C' follow the definition specified in **os-release**\|(5).
Refer to the manual page for exact description of the fields. Their values
are taken from the os-release file. If the file is not present in the system,
or the values are not present in the file, the fields are not included.

On Windows the values are filled from information gathered from the system.

**Since:**
2.10

**guest-get-osinfo**  (Command)
Retrieve guest operating system information

**Returns:**
\f(CW`GuestOSInfo\*(C'

**Since:**
2.10
