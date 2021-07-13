# qemu-qmp-ref.7(7)

 , 2019-08-14

.if n .ad l
.nh

<a name="name"></a>

# Name

qemu-qmp-ref - QEMU QMP Reference Manual

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"

<a name="introduction"></a>

### Introduction

.IX Subsection "Introduction"
This document describes all commands currently supported by \s-1QMP.\s0

Most of the time their usage is exactly the same as in the user Monitor, this
means that any other document which also describe commands (the manpage,
\s-1QEMU\s0's manual, etc) can and should be consulted.

\s-1QMP\s0 has two types of commands: regular and query commands. Regular commands
usually change the Virtual Machine's state someway, while query commands just
return information. The sections below are divided accordingly.

It's important to observe that all communication examples are formatted in
a reader-friendly way, so that they're easier to understand. However, in real
protocol usage, they're emitted as a single line.

Also, the following notation is used to denote data flow:

Example:

.Vb 1
        -&gt; data issued by the Client


        
        &lt;- Server data response
.Ve

Please, refer to the \s-1QMP\s0 specification (docs/interop/qmp-spec.txt) for
detailed information on the Server command and response formats.

<a name="stability-considerations"></a>

### Stability Considerations

.IX Subsection "Stability Considerations"
The current \s-1QMP\s0 command set (described in this file) may be useful for a
number of use cases, however it's limited and several commands have bad
defined semantics, specially with regard to command completion.

These problems are going to be solved incrementally in the next \s-1QEMU\s0 releases
and we're going to establish a deprecation policy for badly defined commands.

If you're planning to adopt \s-1QMP,\s0 please observe the following:

* 1.  
  The deprecation policy will take effect and be documented soon, please
  check the documentation of each used command as soon as a new release of
  \s-1QEMU\s0 is available
* 2.  
  \s-1DO NOT\s0 rely on anything which is not explicit documented
* 3.  
  Errors, in special, are not documented. Applications should \s-1NOT\s0 check
  for specific errors classes or data (it's strongly recommended to only
  check for the error\*(R" key)

<a name="common-data-types"></a>

### Common data types

.IX Subsection "Common data types"
**QapiErrorClass** (Enum)

\s-1QEMU\s0 error classes

**Values:**
.ie n .IP """GenericError""" 4
.el .IP "\f(CWGenericError" 4
.IX Item "GenericError"
this is used for errors that don't require a specific error
class. This should be the default case for most errors
.ie n .IP """CommandNotFound""" 4
.el .IP "\f(CWCommandNotFound" 4
.IX Item "CommandNotFound"
the requested command has not been found
.ie n .IP """DeviceNotActive""" 4
.el .IP "\f(CWDeviceNotActive" 4
.IX Item "DeviceNotActive"
a device has failed to be become active
.ie n .IP """DeviceNotFound""" 4
.el .IP "\f(CWDeviceNotFound" 4
.IX Item "DeviceNotFound"
the requested device has not been found
.ie n .IP """KVMMissingCap""" 4
.el .IP "\f(CWKVMMissingCap" 4
.IX Item "KVMMissingCap"
the requested operation can't be fulfilled because a
required \s-1KVM\s0 capability is missing

**Since:**
1.2

**IoOperationType** (Enum)

An enumeration of the I/O operation types

**Values:**
.ie n .IP """read""" 4
.el .IP "\f(CWread" 4
.IX Item "read"
read operation
.ie n .IP """write""" 4
.el .IP "\f(CWwrite" 4
.IX Item "write"
write operation

**Since:**
2.1

**OnOffAuto** (Enum)

An enumeration of three options: on, off, and auto

**Values:**
.ie n .IP """auto""" 4
.el .IP "\f(CWauto" 4
.IX Item "auto"
\s-1QEMU\s0 selects the value between on and off
.ie n .IP """on""" 4
.el .IP "\f(CWon" 4
.IX Item "on"
Enabled
.ie n .IP """off""" 4
.el .IP "\f(CWoff" 4
.IX Item "off"
Disabled

**Since:**
2.2

**OnOffSplit** (Enum)

An enumeration of three values: on, off, and split

**Values:**
.ie n .IP """on""" 4
.el .IP "\f(CWon" 4
.IX Item "on"
Enabled
.ie n .IP """off""" 4
.el .IP "\f(CWoff" 4
.IX Item "off"
Disabled
.ie n .IP """split""" 4
.el .IP "\f(CWsplit" 4
.IX Item "split"
Mixed

**Since:**
2.6

**String** (Object)

A fat type wrapping 'str', to be embedded in lists.

**Members:**
.ie n .IP """str: string""" 4
.el .IP "\f(CWstr: string" 4
.IX Item "str: string"
Not documented

**Since:**
1.2

**StrOrNull** (Alternate)

This is a string value or the explicit lack of a string (null
pointer in C).  Intended for cases when 'optional absent' already
has a different meaning.

**Members:**
.ie n .IP """s: string""" 4
.el .IP "\f(CWs: string" 4
.IX Item "s: string"
the string value
.ie n .IP """n: null""" 4
.el .IP "\f(CWn: null" 4
.IX Item "n: null"
no string value

**Since:**
2.10

**OffAutoPCIBAR** (Enum)

An enumeration of options for specifying a \s-1PCI BAR\s0

**Values:**
.ie n .IP """off""" 4
.el .IP "\f(CWoff" 4
.IX Item "off"
The specified feature is disabled
.ie n .IP """auto""" 4
.el .IP "\f(CWauto" 4
.IX Item "auto"
The \s-1PCI BAR\s0 for the feature is automatically selected
.ie n .IP """bar0""" 4
.el .IP "\f(CWbar0" 4
.IX Item "bar0"
\s-1PCI BAR0\s0 is used for the feature
.ie n .IP """bar1""" 4
.el .IP "\f(CWbar1" 4
.IX Item "bar1"
\s-1PCI BAR1\s0 is used for the feature
.ie n .IP """bar2""" 4
.el .IP "\f(CWbar2" 4
.IX Item "bar2"
\s-1PCI BAR2\s0 is used for the feature
.ie n .IP """bar3""" 4
.el .IP "\f(CWbar3" 4
.IX Item "bar3"
\s-1PCI BAR3\s0 is used for the feature
.ie n .IP """bar4""" 4
.el .IP "\f(CWbar4" 4
.IX Item "bar4"
\s-1PCI BAR4\s0 is used for the feature
.ie n .IP """bar5""" 4
.el .IP "\f(CWbar5" 4
.IX Item "bar5"
\s-1PCI BAR5\s0 is used for the feature

**Since:**
2.12

**SysEmuTarget** (Enum)

The comprehensive enumeration of \s-1QEMU\s0 system emulation (softmmu\*(R")
targets. Run ./configure --help\*(R" in the project root directory, and
look for the *-softmmu targets near the --target-list\*(R" option. The
individual target constants are not documented here, for the time
being.

**Values:**
.ie n .IP """aarch64""" 4
.el .IP "\f(CWaarch64" 4
.IX Item "aarch64"
Not documented
.ie n .IP """alpha""" 4
.el .IP "\f(CWalpha" 4
.IX Item "alpha"
Not documented
.ie n .IP """arm""" 4
.el .IP "\f(CWarm" 4
.IX Item "arm"
Not documented
.ie n .IP """cris""" 4
.el .IP "\f(CWcris" 4
.IX Item "cris"
Not documented
.ie n .IP """hppa""" 4
.el .IP "\f(CWhppa" 4
.IX Item "hppa"
Not documented
.ie n .IP """i386""" 4
.el .IP "\f(CWi386" 4
.IX Item "i386"
Not documented
.ie n .IP """lm32""" 4
.el .IP "\f(CWlm32" 4
.IX Item "lm32"
Not documented
.ie n .IP """m68k""" 4
.el .IP "\f(CWm68k" 4
.IX Item "m68k"
Not documented
.ie n .IP """microblaze""" 4
.el .IP "\f(CWmicroblaze" 4
.IX Item "microblaze"
Not documented
.ie n .IP """microblazeel""" 4
.el .IP "\f(CWmicroblazeel" 4
.IX Item "microblazeel"
Not documented
.ie n .IP """mips""" 4
.el .IP "\f(CWmips" 4
.IX Item "mips"
Not documented
.ie n .IP """mips64""" 4
.el .IP "\f(CWmips64" 4
.IX Item "mips64"
Not documented
.ie n .IP """mips64el""" 4
.el .IP "\f(CWmips64el" 4
.IX Item "mips64el"
Not documented
.ie n .IP """mipsel""" 4
.el .IP "\f(CWmipsel" 4
.IX Item "mipsel"
Not documented
.ie n .IP """moxie""" 4
.el .IP "\f(CWmoxie" 4
.IX Item "moxie"
Not documented
.ie n .IP """nios2""" 4
.el .IP "\f(CWnios2" 4
.IX Item "nios2"
Not documented
.ie n .IP """or1k""" 4
.el .IP "\f(CWor1k" 4
.IX Item "or1k"
Not documented
.ie n .IP """ppc""" 4
.el .IP "\f(CWppc" 4
.IX Item "ppc"
Not documented
.ie n .IP """ppc64""" 4
.el .IP "\f(CWppc64" 4
.IX Item "ppc64"
Not documented
.ie n .IP """riscv32""" 4
.el .IP "\f(CWriscv32" 4
.IX Item "riscv32"
Not documented
.ie n .IP """riscv64""" 4
.el .IP "\f(CWriscv64" 4
.IX Item "riscv64"
Not documented
.ie n .IP """s390x""" 4
.el .IP "\f(CWs390x" 4
.IX Item "s390x"
Not documented
.ie n .IP """sh4""" 4
.el .IP "\f(CWsh4" 4
.IX Item "sh4"
Not documented
.ie n .IP """sh4eb""" 4
.el .IP "\f(CWsh4eb" 4
.IX Item "sh4eb"
Not documented
.ie n .IP """sparc""" 4
.el .IP "\f(CWsparc" 4
.IX Item "sparc"
Not documented
.ie n .IP """sparc64""" 4
.el .IP "\f(CWsparc64" 4
.IX Item "sparc64"
Not documented
.ie n .IP """tricore""" 4
.el .IP "\f(CWtricore" 4
.IX Item "tricore"
Not documented
.ie n .IP """unicore32""" 4
.el .IP "\f(CWunicore32" 4
.IX Item "unicore32"
Not documented
.ie n .IP """x86_64""" 4
.el .IP "\f(CWx86\_64" 4
.IX Item "x86_64"
Not documented
.ie n .IP """xtensa""" 4
.el .IP "\f(CWxtensa" 4
.IX Item "xtensa"
Not documented
.ie n .IP """xtensaeb""" 4
.el .IP "\f(CWxtensaeb" 4
.IX Item "xtensaeb"
Not documented

**Notes:**
The resulting \s-1QMP\s0 strings can be appended to the qemu-system-\*(R"
prefix to produce the corresponding \s-1QEMU\s0 executable name. This
is true even for qemu-system-x86_64\*(R".

ppcemb: dropped in 3.1

**Since:**
3.0

<a name="socket-data-types"></a>

### Socket data types

.IX Subsection "Socket data types"
**NetworkAddressFamily** (Enum)

The network address family

**Values:**
.ie n .IP """ipv4""" 4
.el .IP "\f(CWipv4" 4
.IX Item "ipv4"
\s-1IPV4\s0 family
.ie n .IP """ipv6""" 4
.el .IP "\f(CWipv6" 4
.IX Item "ipv6"
\s-1IPV6\s0 family
.ie n .IP """unix""" 4
.el .IP "\f(CWunix" 4
.IX Item "unix"
unix socket
.ie n .IP """vsock""" 4
.el .IP "\f(CWvsock" 4
.IX Item "vsock"
vsock family (since 2.8)
.ie n .IP """unknown""" 4
.el .IP "\f(CWunknown" 4
.IX Item "unknown"
otherwise

**Since:**
2.1

**InetSocketAddressBase** (Object)

**Members:**
.ie n .IP """host: string""" 4
.el .IP "\f(CWhost: string" 4
.IX Item "host: string"
host part of the address
.ie n .IP """port: string""" 4
.el .IP "\f(CWport: string" 4
.IX Item "port: string"
port part of the address

**InetSocketAddress** (Object)

Captures a socket address or address range in the Internet namespace.

**Members:**
.ie n .IP """numeric: boolean"" (optional)" 4
.el .IP "\f(CWnumeric: boolean (optional)" 4
.IX Item "numeric: boolean (optional)"
true if the host/port are guaranteed to be numeric,
false if name resolution should be attempted. Defaults to false.
(Since 2.9)
.ie n .IP """to: int"" (optional)" 4
.el .IP "\f(CWto: int (optional)" 4
.IX Item "to: int (optional)"
If present, this is range of possible addresses, with port
between \f(CW`port\*(C' and \f(CW\*(C\`to\*(C'.
.ie n .IP """ipv4: boolean"" (optional)" 4
.el .IP "\f(CWipv4: boolean (optional)" 4
.IX Item "ipv4: boolean (optional)"
whether to accept IPv4 addresses, default try both IPv4 and IPv6
.ie n .IP """ipv6: boolean"" (optional)" 4
.el .IP "\f(CWipv6: boolean (optional)" 4
.IX Item "ipv6: boolean (optional)"
whether to accept IPv6 addresses, default try both IPv4 and IPv6
.ie n .IP "The members of ""InetSocketAddressBase""" 4
.el .IP "The members of \f(CWInetSocketAddressBase" 4
.IX Item "The members of InetSocketAddressBase"

**Since:**
1.3

**UnixSocketAddress** (Object)

Captures a socket address in the local (Unix socket\*(R") namespace.

**Members:**
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
filesystem path to use

**Since:**
1.3

**VsockSocketAddress** (Object)

Captures a socket address in the vsock namespace.

**Members:**
.ie n .IP """cid: string""" 4
.el .IP "\f(CWcid: string" 4
.IX Item "cid: string"
unique host identifier
.ie n .IP """port: string""" 4
.el .IP "\f(CWport: string" 4
.IX Item "port: string"
port

**Note:**
string types are used to allow for possible future hostname or
service resolution support.

**Since:**
2.8

**SocketAddressLegacy** (Object)

Captures the address of a socket, which could also be a named file descriptor

**Members:**
.ie n .IP """type""" 4
.el .IP "\f(CWtype" 4
.IX Item "type"
One of inet\*(R", \*(L"unix\*(R", \*(L"vsock\*(R", \*(L"fd\*(R"
.ie n .IP """data: InetSocketAddress"" when ""type"" is ""inet""" 4
.el .IP "\f(CWdata: InetSocketAddress when \f(CWtype is \`\`inet''" 4
.IX Item "data: InetSocketAddress when type is inet"
.ie n .IP """data: UnixSocketAddress"" when ""type"" is ""unix""" 4
.el .IP "\f(CWdata: UnixSocketAddress when \f(CWtype is \`\`unix''" 4
.IX Item "data: UnixSocketAddress when type is unix"
.ie n .IP """data: VsockSocketAddress"" when ""type"" is ""vsock""" 4
.el .IP "\f(CWdata: VsockSocketAddress when \f(CWtype is \`\`vsock''" 4
.IX Item "data: VsockSocketAddress when type is vsock"
.ie n .IP """data: String"" when ""type"" is ""fd""" 4
.el .IP "\f(CWdata: String when \f(CWtype is \`\`fd''" 4
.IX Item "data: String when type is fd"

**Note:**
This type is deprecated in favor of SocketAddress.  The
difference between SocketAddressLegacy and SocketAddress is that the
latter is a flat union rather than a simple union. Flat is nicer
because it avoids nesting on the wire, i.e. that form has fewer {}.

**Since:**
1.3

**SocketAddressType** (Enum)

Available SocketAddress types

**Values:**
.ie n .IP """inet""" 4
.el .IP "\f(CWinet" 4
.IX Item "inet"
Internet address
.ie n .IP """unix""" 4
.el .IP "\f(CWunix" 4
.IX Item "unix"
Unix domain socket
.ie n .IP """vsock""" 4
.el .IP "\f(CWvsock" 4
.IX Item "vsock"
\s-1VMCI\s0 address
.ie n .IP """fd""" 4
.el .IP "\f(CWfd" 4
.IX Item "fd"
decimal is for file descriptor number, otherwise a file descriptor name.
Named file descriptors are permitted in monitor commands, in combination
with the 'getfd' command. Decimal file descriptors are permitted at
startup or other contexts where no monitor context is active.

**Since:**
2.9

**SocketAddress** (Object)

Captures the address of a socket, which could also be a named file
descriptor

**Members:**
.ie n .IP """type: SocketAddressType""" 4
.el .IP "\f(CWtype: SocketAddressType" 4
.IX Item "type: SocketAddressType"
Transport type
.ie n .IP "The members of ""InetSocketAddress"" when ""type"" is ""inet""" 4
.el .IP "The members of \f(CWInetSocketAddress when \f(CWtype is \`\`inet''" 4
.IX Item "The members of InetSocketAddress when type is inet"
.ie n .IP "The members of ""UnixSocketAddress"" when ""type"" is ""unix""" 4
.el .IP "The members of \f(CWUnixSocketAddress when \f(CWtype is \`\`unix''" 4
.IX Item "The members of UnixSocketAddress when type is unix"
.ie n .IP "The members of ""VsockSocketAddress"" when ""type"" is ""vsock""" 4
.el .IP "The members of \f(CWVsockSocketAddress when \f(CWtype is \`\`vsock''" 4
.IX Item "The members of VsockSocketAddress when type is vsock"
.ie n .IP "The members of ""String"" when ""type"" is ""fd""" 4
.el .IP "The members of \f(CWString when \f(CWtype is \`\`fd''" 4
.IX Item "The members of String when type is fd"

**Since:**
2.9

<a name="s-1vms0-run-state"></a>

### \s-1VM\s0 run state

.IX Subsection "VM run state"
**RunState** (Enum)

An enumeration of \s-1VM\s0 run states.

**Values:**
.ie n .IP """debug""" 4
.el .IP "\f(CWdebug" 4
.IX Item "debug"
\s-1QEMU\s0 is running on a debugger
.ie n .IP """finish-migrate""" 4
.el .IP "\f(CWfinish-migrate" 4
.IX Item "finish-migrate"
guest is paused to finish the migration process
.ie n .IP """inmigrate""" 4
.el .IP "\f(CWinmigrate" 4
.IX Item "inmigrate"
guest is paused waiting for an incoming migration.  Note
that this state does not tell whether the machine will start at the
end of the migration.  This depends on the command-line -S option and
any invocation of 'stop' or 'cont' that has happened since \s-1QEMU\s0 was
started.
.ie n .IP """internal-error""" 4
.el .IP "\f(CWinternal-error" 4
.IX Item "internal-error"
An internal error that prevents further guest execution
has occurred
.ie n .IP """io-error""" 4
.el .IP "\f(CWio-error" 4
.IX Item "io-error"
the last \s-1IOP\s0 has failed and the device is configured to pause
on I/O errors
.ie n .IP """paused""" 4
.el .IP "\f(CWpaused" 4
.IX Item "paused"
guest has been paused via the 'stop' command
.ie n .IP """postmigrate""" 4
.el .IP "\f(CWpostmigrate" 4
.IX Item "postmigrate"
guest is paused following a successful 'migrate'
.ie n .IP """prelaunch""" 4
.el .IP "\f(CWprelaunch" 4
.IX Item "prelaunch"
\s-1QEMU\s0 was started with -S and guest has not started
.ie n .IP """restore-vm""" 4
.el .IP "\f(CWrestore-vm" 4
.IX Item "restore-vm"
guest is paused to restore \s-1VM\s0 state
.ie n .IP """running""" 4
.el .IP "\f(CWrunning" 4
.IX Item "running"
guest is actively running
.ie n .IP """save-vm""" 4
.el .IP "\f(CWsave-vm" 4
.IX Item "save-vm"
guest is paused to save the \s-1VM\s0 state
.ie n .IP """shutdown""" 4
.el .IP "\f(CWshutdown" 4
.IX Item "shutdown"
guest is shut down (and -no-shutdown is in use)
.ie n .IP """suspended""" 4
.el .IP "\f(CWsuspended" 4
.IX Item "suspended"
guest is suspended (\s-1ACPI S3\s0)
.ie n .IP """watchdog""" 4
.el .IP "\f(CWwatchdog" 4
.IX Item "watchdog"
the watchdog action is configured to pause and has been triggered
.ie n .IP """guest-panicked""" 4
.el .IP "\f(CWguest-panicked" 4
.IX Item "guest-panicked"
guest has been panicked as a result of guest \s-1OS\s0 panic
.ie n .IP """colo""" 4
.el .IP "\f(CWcolo" 4
.IX Item "colo"
guest is paused to save/restore \s-1VM\s0 state under colo checkpoint,
\s-1VM\s0 can not get into this state unless colo capability is enabled
for migration. (since 2.8)
.ie n .IP """preconfig""" 4
.el .IP "\f(CWpreconfig" 4
.IX Item "preconfig"
\s-1QEMU\s0 is paused before board specific init callback is executed.
The state is reachable only if the --preconfig \s-1CLI\s0 option is used.
(Since 3.0)

**StatusInfo** (Object)

Information about \s-1VCPU\s0 run state

**Members:**
.ie n .IP """running: boolean""" 4
.el .IP "\f(CWrunning: boolean" 4
.IX Item "running: boolean"
true if all VCPUs are runnable, false if not runnable
.ie n .IP """singlestep: boolean""" 4
.el .IP "\f(CWsinglestep: boolean" 4
.IX Item "singlestep: boolean"
true if VCPUs are in single-step mode
.ie n .IP """status: RunState""" 4
.el .IP "\f(CWstatus: RunState" 4
.IX Item "status: RunState"
the virtual machine \f(CW`RunState\*(C'

**Since:**
0.14.0

**Notes:**
\f(CW`singlestep\*(C' is enabled through the \s-1GDB\s0 stub

**query-status**  (Command)
Query the run status of all VCPUs

**Returns:**
\f(CW`StatusInfo\*(C' reflecting all VCPUs

**Since:**
0.14.0

**Example:**

.Vb 4
        -&gt; { "execute": "query-status" }
        &lt;- { "return": { "running": true,
                         "singlestep": false,
                         "status": "running" } }
.Ve

**\s-1SHUTDOWN\s0**  (Event)
Emitted when the virtual machine has shut down, indicating that qemu is
about to exit.

**Arguments:**
.ie n .IP """guest: boolean""" 4
.el .IP "\f(CWguest: boolean" 4
.IX Item "guest: boolean"
If true, the shutdown was triggered by a guest request (such as
a guest-initiated \s-1ACPI\s0 shutdown request or other hardware-specific action)
rather than a host request (such as sending qemu a \s-1SIGINT\s0). (since 2.10)

**Note:**
If the command-line option -no-shutdown\*(R" has been specified, qemu will
not exit, and a \s-1STOP\s0 event will eventually follow the \s-1SHUTDOWN\s0 event

**Since:**
0.12.0

**Example:**

.Vb 2
        &lt;- { "event": "SHUTDOWN", "data": { "guest": true },
             "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
.Ve

**\s-1POWERDOWN\s0**  (Event)
Emitted when the virtual machine is powered down through the power control
system, such as via \s-1ACPI.\s0

**Since:**
0.12.0

**Example:**

.Vb 2
        &lt;- { "event": "POWERDOWN",
             "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
.Ve

**\s-1RESET\s0**  (Event)
Emitted when the virtual machine is reset

**Arguments:**
.ie n .IP """guest: boolean""" 4
.el .IP "\f(CWguest: boolean" 4
.IX Item "guest: boolean"
If true, the reset was triggered by a guest request (such as
a guest-initiated \s-1ACPI\s0 reboot request or other hardware-specific action)
rather than a host request (such as the \s-1QMP\s0 command system_reset).
(since 2.10)

**Since:**
0.12.0

**Example:**

.Vb 2
        &lt;- { "event": "RESET", "data": { "guest": false },
             "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
.Ve

**\s-1STOP\s0**  (Event)
Emitted when the virtual machine is stopped

**Since:**
0.12.0

**Example:**

.Vb 2
        &lt;- { "event": "STOP",
             "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
.Ve

**\s-1RESUME\s0**  (Event)
Emitted when the virtual machine resumes execution

**Since:**
0.12.0

**Example:**

.Vb 2
        &lt;- { "event": "RESUME",
             "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
.Ve

**\s-1SUSPEND\s0**  (Event)
Emitted when guest enters a hardware suspension state, for example, S3 state,
which is sometimes called standby state

**Since:**
1.1

**Example:**

.Vb 2
        &lt;- { "event": "SUSPEND",
             "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
.Ve

**\s-1SUSPEND\_DISK\s0**  (Event)
Emitted when guest enters a hardware suspension state with data saved on
disk, for example, S4 state, which is sometimes called hibernate state

**Note:**
\s-1QEMU\s0 shuts down (similar to event \f(CW`SHUTDOWN\*(C') when entering this state

**Since:**
1.2

**Example:**

.Vb 2
        &lt;-   { "event": "SUSPEND_DISK",
               "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
.Ve

**\s-1WAKEUP\s0**  (Event)
Emitted when the guest has woken up from suspend state and is running

**Since:**
1.1

**Example:**

.Vb 2
        &lt;- { "event": "WAKEUP",
             "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
.Ve

**\s-1WATCHDOG\s0**  (Event)
Emitted when the watchdog device's timer is expired

**Arguments:**
.ie n .IP """action: WatchdogAction""" 4
.el .IP "\f(CWaction: WatchdogAction" 4
.IX Item "action: WatchdogAction"
action that has been taken

**Note:**
If action is reset\*(R", \*(L"shutdown\*(R", or \*(L"pause\*(R" the \s-1WATCHDOG\s0 event is
followed respectively by the \s-1RESET, SHUTDOWN,\s0 or \s-1STOP\s0 events

**Note:**
This event is rate-limited.

**Since:**
0.13.0

**Example:**

.Vb 3
        &lt;- { "event": "WATCHDOG",
             "data": { "action": "reset" },
             "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
.Ve

**WatchdogAction** (Enum)

An enumeration of the actions taken when the watchdog device's timer is
expired

**Values:**
.ie n .IP """reset""" 4
.el .IP "\f(CWreset" 4
.IX Item "reset"
system resets
.ie n .IP """shutdown""" 4
.el .IP "\f(CWshutdown" 4
.IX Item "shutdown"
system shutdown, note that it is similar to \f(CW`powerdown\*(C', which
tries to set to system status and notify guest
.ie n .IP """poweroff""" 4
.el .IP "\f(CWpoweroff" 4
.IX Item "poweroff"
system poweroff, the emulator program exits
.ie n .IP """pause""" 4
.el .IP "\f(CWpause" 4
.IX Item "pause"
system pauses, similar to \f(CW`stop\*(C'
.ie n .IP """debug""" 4
.el .IP "\f(CWdebug" 4
.IX Item "debug"
system enters debug state
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
nothing is done
.ie n .IP """inject-nmi""" 4
.el .IP "\f(CWinject-nmi" 4
.IX Item "inject-nmi"
a non-maskable interrupt is injected into the first \s-1VCPU\s0 (all
\s-1VCPUS\s0 on x86) (since 2.4)

**Since:**
2.1

**watchdog-set-action**  (Command)
Set watchdog action

**Arguments:**
.ie n .IP """action: WatchdogAction""" 4
.el .IP "\f(CWaction: WatchdogAction" 4
.IX Item "action: WatchdogAction"
Not documented

**Since:**
2.11

**\s-1GUEST\_PANICKED\s0**  (Event)
Emitted when guest \s-1OS\s0 panic is detected

**Arguments:**
.ie n .IP """action: GuestPanicAction""" 4
.el .IP "\f(CWaction: GuestPanicAction" 4
.IX Item "action: GuestPanicAction"
action that has been taken, currently always pause\*(R"
.ie n .IP """info: GuestPanicInformation"" (optional)" 4
.el .IP "\f(CWinfo: GuestPanicInformation (optional)" 4
.IX Item "info: GuestPanicInformation (optional)"
information about a panic (since 2.9)

**Since:**
1.5

**Example:**

.Vb 2
        &lt;- { "event": "GUEST_PANICKED",
             "data": { "action": "pause" } }
.Ve

**GuestPanicAction** (Enum)

An enumeration of the actions taken when guest \s-1OS\s0 panic is detected

**Values:**
.ie n .IP """pause""" 4
.el .IP "\f(CWpause" 4
.IX Item "pause"
system pauses
.ie n .IP """poweroff""" 4
.el .IP "\f(CWpoweroff" 4
.IX Item "poweroff"
Not documented

**Since:**
2.1 (poweroff since 2.8)

**GuestPanicInformationType** (Enum)

An enumeration of the guest panic information types

**Values:**
.ie n .IP """hyper-v""" 4
.el .IP "\f(CWhyper-v" 4
.IX Item "hyper-v"
hyper-v guest panic information type
.ie n .IP """s390""" 4
.el .IP "\f(CWs390" 4
.IX Item "s390"
s390 guest panic information type (Since: 2.12)

**Since:**
2.9

**GuestPanicInformation** (Object)

Information about a guest panic

**Members:**
.ie n .IP """type: GuestPanicInformationType""" 4
.el .IP "\f(CWtype: GuestPanicInformationType" 4
.IX Item "type: GuestPanicInformationType"
Crash type that defines the hypervisor specific information
.ie n .IP "The members of ""GuestPanicInformationHyperV"" when ""type"" is ""hyper-v""" 4
.el .IP "The members of \f(CWGuestPanicInformationHyperV when \f(CWtype is \`\`hyper-v''" 4
.IX Item "The members of GuestPanicInformationHyperV when type is hyper-v"
.ie n .IP "The members of ""GuestPanicInformationS390"" when ""type"" is ""s390""" 4
.el .IP "The members of \f(CWGuestPanicInformationS390 when \f(CWtype is \`\`s390''" 4
.IX Item "The members of GuestPanicInformationS390 when type is s390"

**Since:**
2.9

**GuestPanicInformationHyperV** (Object)

Hyper-V specific guest panic information (\s-1HV\s0 crash MSRs)

**Members:**
.ie n .IP """arg1: int""" 4
.el .IP "\f(CWarg1: int" 4
.IX Item "arg1: int"
Not documented
.ie n .IP """arg2: int""" 4
.el .IP "\f(CWarg2: int" 4
.IX Item "arg2: int"
Not documented
.ie n .IP """arg3: int""" 4
.el .IP "\f(CWarg3: int" 4
.IX Item "arg3: int"
Not documented
.ie n .IP """arg4: int""" 4
.el .IP "\f(CWarg4: int" 4
.IX Item "arg4: int"
Not documented
.ie n .IP """arg5: int""" 4
.el .IP "\f(CWarg5: int" 4
.IX Item "arg5: int"
Not documented

**Since:**
2.9

**S390CrashReason** (Enum)

Reason why the \s-1CPU\s0 is in a crashed state.

**Values:**
.ie n .IP """unknown""" 4
.el .IP "\f(CWunknown" 4
.IX Item "unknown"
no crash reason was set
.ie n .IP """disabled-wait""" 4
.el .IP "\f(CWdisabled-wait" 4
.IX Item "disabled-wait"
the \s-1CPU\s0 has entered a disabled wait state
.ie n .IP """extint-loop""" 4
.el .IP "\f(CWextint-loop" 4
.IX Item "extint-loop"
clock comparator or cpu timer interrupt with new \s-1PSW\s0 enabled
for external interrupts
.ie n .IP """pgmint-loop""" 4
.el .IP "\f(CWpgmint-loop" 4
.IX Item "pgmint-loop"
program interrupt with \s-1BAD\s0 new \s-1PSW\s0
.ie n .IP """opint-loop""" 4
.el .IP "\f(CWopint-loop" 4
.IX Item "opint-loop"
operation exception interrupt with invalid code at the program
interrupt new \s-1PSW\s0

**Since:**
2.12

**GuestPanicInformationS390** (Object)

S390 specific guest panic information (\s-1PSW\s0)

**Members:**
.ie n .IP """core: int""" 4
.el .IP "\f(CWcore: int" 4
.IX Item "core: int"
core id of the \s-1CPU\s0 that crashed
.ie n .IP """psw-mask: int""" 4
.el .IP "\f(CWpsw-mask: int" 4
.IX Item "psw-mask: int"
control fields of guest \s-1PSW\s0
.ie n .IP """psw-addr: int""" 4
.el .IP "\f(CWpsw-addr: int" 4
.IX Item "psw-addr: int"
guest instruction address
.ie n .IP """reason: S390CrashReason""" 4
.el .IP "\f(CWreason: S390CrashReason" 4
.IX Item "reason: S390CrashReason"
guest crash reason

**Since:**
2.12

<a name="cryptography"></a>

### Cryptography

.IX Subsection "Cryptography"
**QCryptoTLSCredsEndpoint** (Enum)

The type of network endpoint that will be using the credentials.
Most types of credential require different setup / structures
depending on whether they will be used in a server versus a
client.

**Values:**
.ie n .IP """client""" 4
.el .IP "\f(CWclient" 4
.IX Item "client"
the network endpoint is acting as the client
.ie n .IP """server""" 4
.el .IP "\f(CWserver" 4
.IX Item "server"
the network endpoint is acting as the server

**Since:**
2.5

**QCryptoSecretFormat** (Enum)

The data format that the secret is provided in

**Values:**
.ie n .IP """raw""" 4
.el .IP "\f(CWraw" 4
.IX Item "raw"
raw bytes. When encoded in \s-1JSON\s0 only valid \s-1UTF-8\s0 sequences can be used
.ie n .IP """base64""" 4
.el .IP "\f(CWbase64" 4
.IX Item "base64"
arbitrary base64 encoded binary data

**Since:**
2.6

**QCryptoHashAlgorithm** (Enum)

The supported algorithms for computing content digests

**Values:**
.ie n .IP """md5""" 4
.el .IP "\f(CWmd5" 4
.IX Item "md5"
\s-1MD5.\s0 Should not be used in any new code, legacy compat only
.ie n .IP """sha1""" 4
.el .IP "\f(CWsha1" 4
.IX Item "sha1"
\s-1SHA-1.\s0 Should not be used in any new code, legacy compat only
.ie n .IP """sha224""" 4
.el .IP "\f(CWsha224" 4
.IX Item "sha224"
\s-1SHA-224.\s0 (since 2.7)
.ie n .IP """sha256""" 4
.el .IP "\f(CWsha256" 4
.IX Item "sha256"
\s-1SHA-256.\s0 Current recommended strong hash.
.ie n .IP """sha384""" 4
.el .IP "\f(CWsha384" 4
.IX Item "sha384"
\s-1SHA-384.\s0 (since 2.7)
.ie n .IP """sha512""" 4
.el .IP "\f(CWsha512" 4
.IX Item "sha512"
\s-1SHA-512.\s0 (since 2.7)
.ie n .IP """ripemd160""" 4
.el .IP "\f(CWripemd160" 4
.IX Item "ripemd160"
\s-1RIPEMD-160.\s0 (since 2.7)

**Since:**
2.6

**QCryptoCipherAlgorithm** (Enum)

The supported algorithms for content encryption ciphers

**Values:**
.ie n .IP """aes-128""" 4
.el .IP "\f(CWaes-128" 4
.IX Item "aes-128"
\s-1AES\s0 with 128 bit / 16 byte keys
.ie n .IP """aes-192""" 4
.el .IP "\f(CWaes-192" 4
.IX Item "aes-192"
\s-1AES\s0 with 192 bit / 24 byte keys
.ie n .IP """aes-256""" 4
.el .IP "\f(CWaes-256" 4
.IX Item "aes-256"
\s-1AES\s0 with 256 bit / 32 byte keys
.ie n .IP """des-rfb""" 4
.el .IP "\f(CWdes-rfb" 4
.IX Item "des-rfb"
\s-1RFB\s0 specific variant of single \s-1DES.\s0 Do not use except in \s-1VNC.\s0
.ie n .IP """3des""" 4
.el .IP "\f(CW3des" 4
.IX Item "3des"
3DES(\s-1EDE\s0) with 192 bit / 24 byte keys (since 2.9)
.ie n .IP """cast5-128""" 4
.el .IP "\f(CWcast5-128" 4
.IX Item "cast5-128"
Cast5 with 128 bit / 16 byte keys
.ie n .IP """serpent-128""" 4
.el .IP "\f(CWserpent-128" 4
.IX Item "serpent-128"
Serpent with 128 bit / 16 byte keys
.ie n .IP """serpent-192""" 4
.el .IP "\f(CWserpent-192" 4
.IX Item "serpent-192"
Serpent with 192 bit / 24 byte keys
.ie n .IP """serpent-256""" 4
.el .IP "\f(CWserpent-256" 4
.IX Item "serpent-256"
Serpent with 256 bit / 32 byte keys
.ie n .IP """twofish-128""" 4
.el .IP "\f(CWtwofish-128" 4
.IX Item "twofish-128"
Twofish with 128 bit / 16 byte keys
.ie n .IP """twofish-192""" 4
.el .IP "\f(CWtwofish-192" 4
.IX Item "twofish-192"
Twofish with 192 bit / 24 byte keys
.ie n .IP """twofish-256""" 4
.el .IP "\f(CWtwofish-256" 4
.IX Item "twofish-256"
Twofish with 256 bit / 32 byte keys

**Since:**
2.6

**QCryptoCipherMode** (Enum)

The supported modes for content encryption ciphers

**Values:**
.ie n .IP """ecb""" 4
.el .IP "\f(CWecb" 4
.IX Item "ecb"
Electronic Code Book
.ie n .IP """cbc""" 4
.el .IP "\f(CWcbc" 4
.IX Item "cbc"
Cipher Block Chaining
.ie n .IP """xts""" 4
.el .IP "\f(CWxts" 4
.IX Item "xts"
\s-1XEX\s0 with tweaked code book and ciphertext stealing
.ie n .IP """ctr""" 4
.el .IP "\f(CWctr" 4
.IX Item "ctr"
Counter (Since 2.8)

**Since:**
2.6

**QCryptoIVGenAlgorithm** (Enum)

The supported algorithms for generating initialization
vectors for full disk encryption. The 'plain' generator
should not be used for disks with sector numbers larger
than 2^32, except where compatibility with pre-existing
Linux dm-crypt volumes is required.

**Values:**
.ie n .IP """plain""" 4
.el .IP "\f(CWplain" 4
.IX Item "plain"
64-bit sector number truncated to 32-bits
.ie n .IP """plain64""" 4
.el .IP "\f(CWplain64" 4
.IX Item "plain64"
64-bit sector number
.ie n .IP """essiv""" 4
.el .IP "\f(CWessiv" 4
.IX Item "essiv"
64-bit sector number encrypted with a hash of the encryption key

**Since:**
2.6

**QCryptoBlockFormat** (Enum)

The supported full disk encryption formats

**Values:**
.ie n .IP """qcow""" 4
.el .IP "\f(CWqcow" 4
.IX Item "qcow"
QCow/QCow2 built-in AES-CBC encryption. Use only
for liberating data from old images.
.ie n .IP """luks""" 4
.el .IP "\f(CWluks" 4
.IX Item "luks"
\s-1LUKS\s0 encryption format. Recommended for new images

**Since:**
2.6

**QCryptoBlockOptionsBase** (Object)

The common options that apply to all full disk
encryption formats

**Members:**
.ie n .IP """format: QCryptoBlockFormat""" 4
.el .IP "\f(CWformat: QCryptoBlockFormat" 4
.IX Item "format: QCryptoBlockFormat"
the encryption format

**Since:**
2.6

**QCryptoBlockOptionsQCow** (Object)

The options that apply to QCow/QCow2 AES-CBC encryption format

**Members:**
.ie n .IP """key-secret: string"" (optional)" 4
.el .IP "\f(CWkey-secret: string (optional)" 4
.IX Item "key-secret: string (optional)"
the \s-1ID\s0 of a QCryptoSecret object providing the
decryption key. Mandatory except when probing image for
metadata only.

**Since:**
2.6

**QCryptoBlockOptionsLUKS** (Object)

The options that apply to \s-1LUKS\s0 encryption format

**Members:**
.ie n .IP """key-secret: string"" (optional)" 4
.el .IP "\f(CWkey-secret: string (optional)" 4
.IX Item "key-secret: string (optional)"
the \s-1ID\s0 of a QCryptoSecret object providing the
decryption key. Mandatory except when probing image for
metadata only.

**Since:**
2.6

**QCryptoBlockCreateOptionsLUKS** (Object)

The options that apply to \s-1LUKS\s0 encryption format initialization

**Members:**
.ie n .IP """cipher-alg: QCryptoCipherAlgorithm"" (optional)" 4
.el .IP "\f(CWcipher-alg: QCryptoCipherAlgorithm (optional)" 4
.IX Item "cipher-alg: QCryptoCipherAlgorithm (optional)"
the cipher algorithm for data encryption
Currently defaults to 'aes'.
.ie n .IP """cipher-mode: QCryptoCipherMode"" (optional)" 4
.el .IP "\f(CWcipher-mode: QCryptoCipherMode (optional)" 4
.IX Item "cipher-mode: QCryptoCipherMode (optional)"
the cipher mode for data encryption
Currently defaults to 'cbc'
.ie n .IP """ivgen-alg: QCryptoIVGenAlgorithm"" (optional)" 4
.el .IP "\f(CWivgen-alg: QCryptoIVGenAlgorithm (optional)" 4
.IX Item "ivgen-alg: QCryptoIVGenAlgorithm (optional)"
the initialization vector generator
Currently defaults to 'essiv'
.ie n .IP """ivgen-hash-alg: QCryptoHashAlgorithm"" (optional)" 4
.el .IP "\f(CWivgen-hash-alg: QCryptoHashAlgorithm (optional)" 4
.IX Item "ivgen-hash-alg: QCryptoHashAlgorithm (optional)"
the initialization vector generator hash
Currently defaults to 'sha256'
.ie n .IP """hash-alg: QCryptoHashAlgorithm"" (optional)" 4
.el .IP "\f(CWhash-alg: QCryptoHashAlgorithm (optional)" 4
.IX Item "hash-alg: QCryptoHashAlgorithm (optional)"
the master key hash algorithm
Currently defaults to 'sha256'
.ie n .IP """iter-time: int"" (optional)" 4
.el .IP "\f(CWiter-time: int (optional)" 4
.IX Item "iter-time: int (optional)"
number of milliseconds to spend in
\s-1PBKDF\s0 passphrase processing. Currently defaults
to 2000. (since 2.8)
.ie n .IP "The members of ""QCryptoBlockOptionsLUKS""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsLUKS" 4
.IX Item "The members of QCryptoBlockOptionsLUKS"

**Since:**
2.6

**QCryptoBlockOpenOptions** (Object)

The options that are available for all encryption formats
when opening an existing volume

**Members:**
.ie n .IP "The members of ""QCryptoBlockOptionsBase""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsBase" 4
.IX Item "The members of QCryptoBlockOptionsBase"
.ie n .IP "The members of ""QCryptoBlockOptionsQCow"" when ""format"" is ""qcow""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsQCow when \f(CWformat is \`\`qcow''" 4
.IX Item "The members of QCryptoBlockOptionsQCow when format is qcow"
.ie n .IP "The members of ""QCryptoBlockOptionsLUKS"" when ""format"" is ""luks""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsLUKS when \f(CWformat is \`\`luks''" 4
.IX Item "The members of QCryptoBlockOptionsLUKS when format is luks"

**Since:**
2.6

**QCryptoBlockCreateOptions** (Object)

The options that are available for all encryption formats
when initializing a new volume

**Members:**
.ie n .IP "The members of ""QCryptoBlockOptionsBase""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsBase" 4
.IX Item "The members of QCryptoBlockOptionsBase"
.ie n .IP "The members of ""QCryptoBlockOptionsQCow"" when ""format"" is ""qcow""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsQCow when \f(CWformat is \`\`qcow''" 4
.IX Item "The members of QCryptoBlockOptionsQCow when format is qcow"
.ie n .IP "The members of ""QCryptoBlockCreateOptionsLUKS"" when ""format"" is ""luks""" 4
.el .IP "The members of \f(CWQCryptoBlockCreateOptionsLUKS when \f(CWformat is \`\`luks''" 4
.IX Item "The members of QCryptoBlockCreateOptionsLUKS when format is luks"

**Since:**
2.6

**QCryptoBlockInfoBase** (Object)

The common information that applies to all full disk
encryption formats

**Members:**
.ie n .IP """format: QCryptoBlockFormat""" 4
.el .IP "\f(CWformat: QCryptoBlockFormat" 4
.IX Item "format: QCryptoBlockFormat"
the encryption format

**Since:**
2.7

**QCryptoBlockInfoLUKSSlot** (Object)

Information about the \s-1LUKS\s0 block encryption key
slot options

**Members:**
.ie n .IP """active: boolean""" 4
.el .IP "\f(CWactive: boolean" 4
.IX Item "active: boolean"
whether the key slot is currently in use
.ie n .IP """key-offset: int""" 4
.el .IP "\f(CWkey-offset: int" 4
.IX Item "key-offset: int"
offset to the key material in bytes
.ie n .IP """iters: int"" (optional)" 4
.el .IP "\f(CWiters: int (optional)" 4
.IX Item "iters: int (optional)"
number of \s-1PBKDF2\s0 iterations for key material
.ie n .IP """stripes: int"" (optional)" 4
.el .IP "\f(CWstripes: int (optional)" 4
.IX Item "stripes: int (optional)"
number of stripes for splitting key material

**Since:**
2.7

**QCryptoBlockInfoLUKS** (Object)

Information about the \s-1LUKS\s0 block encryption options

**Members:**
.ie n .IP """cipher-alg: QCryptoCipherAlgorithm""" 4
.el .IP "\f(CWcipher-alg: QCryptoCipherAlgorithm" 4
.IX Item "cipher-alg: QCryptoCipherAlgorithm"
the cipher algorithm for data encryption
.ie n .IP """cipher-mode: QCryptoCipherMode""" 4
.el .IP "\f(CWcipher-mode: QCryptoCipherMode" 4
.IX Item "cipher-mode: QCryptoCipherMode"
the cipher mode for data encryption
.ie n .IP """ivgen-alg: QCryptoIVGenAlgorithm""" 4
.el .IP "\f(CWivgen-alg: QCryptoIVGenAlgorithm" 4
.IX Item "ivgen-alg: QCryptoIVGenAlgorithm"
the initialization vector generator
.ie n .IP """ivgen-hash-alg: QCryptoHashAlgorithm"" (optional)" 4
.el .IP "\f(CWivgen-hash-alg: QCryptoHashAlgorithm (optional)" 4
.IX Item "ivgen-hash-alg: QCryptoHashAlgorithm (optional)"
the initialization vector generator hash
.ie n .IP """hash-alg: QCryptoHashAlgorithm""" 4
.el .IP "\f(CWhash-alg: QCryptoHashAlgorithm" 4
.IX Item "hash-alg: QCryptoHashAlgorithm"
the master key hash algorithm
.ie n .IP """payload-offset: int""" 4
.el .IP "\f(CWpayload-offset: int" 4
.IX Item "payload-offset: int"
offset to the payload data in bytes
.ie n .IP """master-key-iters: int""" 4
.el .IP "\f(CWmaster-key-iters: int" 4
.IX Item "master-key-iters: int"
number of \s-1PBKDF2\s0 iterations for key material
.ie n .IP """uuid: string""" 4
.el .IP "\f(CWuuid: string" 4
.IX Item "uuid: string"
unique identifier for the volume
.ie n .IP """slots: array of QCryptoBlockInfoLUKSSlot""" 4
.el .IP "\f(CWslots: array of QCryptoBlockInfoLUKSSlot" 4
.IX Item "slots: array of QCryptoBlockInfoLUKSSlot"
information about each key slot

**Since:**
2.7

**QCryptoBlockInfo** (Object)

Information about the block encryption options

**Members:**
.ie n .IP "The members of ""QCryptoBlockInfoBase""" 4
.el .IP "The members of \f(CWQCryptoBlockInfoBase" 4
.IX Item "The members of QCryptoBlockInfoBase"
.ie n .IP "The members of ""QCryptoBlockInfoLUKS"" when ""format"" is ""luks""" 4
.el .IP "The members of \f(CWQCryptoBlockInfoLUKS when \f(CWformat is \`\`luks''" 4
.IX Item "The members of QCryptoBlockInfoLUKS when format is luks"

**Since:**
2.7

<a name="block-devices"></a>

### Block devices

.IX Subsection "Block devices"
_Block core (\s-1VM\s0 unrelated)_
.IX Subsection "Block core (VM unrelated)"

_Background jobs_
.IX Subsection "Background jobs"

**JobType** (Enum)

Type of a background job.

**Values:**
.ie n .IP """commit""" 4
.el .IP "\f(CWcommit" 4
.IX Item "commit"
block commit job type, see block-commit\*(R"
.ie n .IP """stream""" 4
.el .IP "\f(CWstream" 4
.IX Item "stream"
block stream job type, see block-stream\*(R"
.ie n .IP """mirror""" 4
.el .IP "\f(CWmirror" 4
.IX Item "mirror"
drive mirror job type, see drive-mirror\*(R"
.ie n .IP """backup""" 4
.el .IP "\f(CWbackup" 4
.IX Item "backup"
drive backup job type, see drive-backup\*(R"
.ie n .IP """create""" 4
.el .IP "\f(CWcreate" 4
.IX Item "create"
image creation job type, see blockdev-create\*(R" (since 3.0)

**Since:**
1.7

**JobStatus** (Enum)

Indicates the present state of a given job in its lifetime.

**Values:**
.ie n .IP """undefined""" 4
.el .IP "\f(CWundefined" 4
.IX Item "undefined"
Erroneous, default state. Should not ever be visible.
.ie n .IP """created""" 4
.el .IP "\f(CWcreated" 4
.IX Item "created"
The job has been created, but not yet started.
.ie n .IP """running""" 4
.el .IP "\f(CWrunning" 4
.IX Item "running"
The job is currently running.
.ie n .IP """paused""" 4
.el .IP "\f(CWpaused" 4
.IX Item "paused"
The job is running, but paused. The pause may be requested by
either the \s-1QMP\s0 user or by internal processes.
.ie n .IP """ready""" 4
.el .IP "\f(CWready" 4
.IX Item "ready"
The job is running, but is ready for the user to signal completion.
This is used for long-running jobs like mirror that are designed to
run indefinitely.
.ie n .IP """standby""" 4
.el .IP "\f(CWstandby" 4
.IX Item "standby"
The job is ready, but paused. This is nearly identical to \f(CW`paused\*(C'.
The job may return to \f(CW`ready\*(C' or otherwise be canceled.
.ie n .IP """waiting""" 4
.el .IP "\f(CWwaiting" 4
.IX Item "waiting"
The job is waiting for other jobs in the transaction to converge
to the waiting state. This status will likely not be visible for
the last job in a transaction.
.ie n .IP """pending""" 4
.el .IP "\f(CWpending" 4
.IX Item "pending"
The job has finished its work, but has finalization steps that it
needs to make prior to completing. These changes will require
manual intervention via \f(CW`job-finalize\*(C' if auto-finalize was set to
false. These pending changes may still fail.
.ie n .IP """aborting""" 4
.el .IP "\f(CWaborting" 4
.IX Item "aborting"
The job is in the process of being aborted, and will finish with
an error. The job will afterwards report that it is \f(CW`concluded\*(C'.
This status may not be visible to the management process.
.ie n .IP """concluded""" 4
.el .IP "\f(CWconcluded" 4
.IX Item "concluded"
The job has finished all work. If auto-dismiss was set to false,
the job will remain in the query list until it is dismissed via
\f(CW`job-dismiss\*(C'.
.ie n .IP """null""" 4
.el .IP "\f(CWnull" 4
.IX Item "null"
The job is in the process of being dismantled. This state should not
ever be visible externally.

**Since:**
2.12

**JobVerb** (Enum)

Represents command verbs that can be applied to a job.

**Values:**
.ie n .IP """cancel""" 4
.el .IP "\f(CWcancel" 4
.IX Item "cancel"
see \f(CW`job-cancel\*(C'
.ie n .IP """pause""" 4
.el .IP "\f(CWpause" 4
.IX Item "pause"
see \f(CW`job-pause\*(C'
.ie n .IP """resume""" 4
.el .IP "\f(CWresume" 4
.IX Item "resume"
see \f(CW`job-resume\*(C'
.ie n .IP """set-speed""" 4
.el .IP "\f(CWset-speed" 4
.IX Item "set-speed"
see \f(CW`block-job-set-speed\*(C'
.ie n .IP """complete""" 4
.el .IP "\f(CWcomplete" 4
.IX Item "complete"
see \f(CW`job-complete\*(C'
.ie n .IP """dismiss""" 4
.el .IP "\f(CWdismiss" 4
.IX Item "dismiss"
see \f(CW`job-dismiss\*(C'
.ie n .IP """finalize""" 4
.el .IP "\f(CWfinalize" 4
.IX Item "finalize"
see \f(CW`job-finalize\*(C'

**Since:**
2.12

**\s-1JOB\_STATUS\_CHANGE\s0**  (Event)
Emitted when a job transitions to a different status.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier
.ie n .IP """status: JobStatus""" 4
.el .IP "\f(CWstatus: JobStatus" 4
.IX Item "status: JobStatus"
The new job status

**Since:**
3.0

**job-pause**  (Command)
Pause an active job.

This command returns immediately after marking the active job for pausing.
Pausing an already paused job is an error.

The job will pause as soon as possible, which means transitioning into the
\s-1PAUSED\s0 state if it was \s-1RUNNING,\s0 or into \s-1STANDBY\s0 if it was \s-1READY.\s0 The
corresponding \s-1JOB_STATUS_CHANGE\s0 event will be emitted.

Cancelling a paused job automatically resumes it.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier.

**Since:**
3.0

**job-resume**  (Command)
Resume a paused job.

This command returns immediately after resuming a paused job. Resuming an
already running job is an error.

\f(CW`id\*(C' : The job identifier.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
Not documented

**Since:**
3.0

**job-cancel**  (Command)
Instruct an active background job to cancel at the next opportunity.
This command returns immediately after marking the active job for
cancellation.

The job will cancel as soon as possible and then emit a \s-1JOB_STATUS_CHANGE\s0
event. Usually, the status will change to \s-1ABORTING,\s0 but it is possible that
a job successfully completes (e.g. because it was almost done and there was
no opportunity to cancel earlier than completing the job) and transitions to
\s-1PENDING\s0 instead.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier.

**Since:**
3.0

**job-complete**  (Command)
Manually trigger completion of an active job in the \s-1READY\s0 state.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier.

**Since:**
3.0

**job-dismiss**  (Command)
Deletes a job that is in the \s-1CONCLUDED\s0 state. This command only needs to be
run explicitly for jobs that don't have automatic dismiss enabled.

This command will refuse to operate on any job that has not yet reached its
terminal state, \s-1JOB_STATUS_CONCLUDED.\s0 For jobs that make use of \s-1JOB_READY\s0
event, job-cancel or job-complete will still need to be used as appropriate.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier.

**Since:**
3.0

**job-finalize**  (Command)
Instructs all jobs in a transaction (or a single job if it is not part of any
transaction) to finalize any graph changes and do any necessary cleanup. This
command requires that all involved jobs are in the \s-1PENDING\s0 state.

For jobs in a transaction, instructing one job to finalize will force
\s-1ALL\s0 jobs in the transaction to finalize, so it is only necessary to instruct
a single member job to finalize.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The identifier of any job in the transaction, or of a job that is not
part of any transaction.

**Since:**
3.0

**JobInfo** (Object)

Information about a job.

**Members:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier
.ie n .IP """type: JobType""" 4
.el .IP "\f(CWtype: JobType" 4
.IX Item "type: JobType"
The kind of job that is being performed
.ie n .IP """status: JobStatus""" 4
.el .IP "\f(CWstatus: JobStatus" 4
.IX Item "status: JobStatus"
Current job state/status
.ie n .IP """current-progress: int""" 4
.el .IP "\f(CWcurrent-progress: int" 4
.IX Item "current-progress: int"
Progress made until now. The unit is arbitrary and the
value can only meaningfully be used for the ratio of
\f(CW`current-progress\*(C' to \f(CW\*(C\`total-progress\*(C'. The value is
monotonically increasing.
.ie n .IP """total-progress: int""" 4
.el .IP "\f(CWtotal-progress: int" 4
.IX Item "total-progress: int"
Estimated \f(CW`current-progress\*(C' value at the completion of
the job. This value can arbitrarily change while the
job is running, in both directions.
.ie n .IP """error: string"" (optional)" 4
.el .IP "\f(CWerror: string (optional)" 4
.IX Item "error: string (optional)"
If this field is present, the job failed; if it is
still missing in the \s-1CONCLUDED\s0 state, this indicates
successful completion.
.Sp
The value is a human-readable error message to describe
the reason for the job failure. It should not be parsed
by applications.

**Since:**
3.0

**query-jobs**  (Command)
Return information about jobs.

**Returns:**
a list with a \f(CW`JobInfo\*(C' for each active job

**Since:**
3.0

**SnapshotInfo** (Object)

**Members:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
unique snapshot id
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
user chosen name
.ie n .IP """vm-state-size: int""" 4
.el .IP "\f(CWvm-state-size: int" 4
.IX Item "vm-state-size: int"
size of the \s-1VM\s0 state
.ie n .IP """date-sec: int""" 4
.el .IP "\f(CWdate-sec: int" 4
.IX Item "date-sec: int"
\s-1UTC\s0 date of the snapshot in seconds
.ie n .IP """date-nsec: int""" 4
.el .IP "\f(CWdate-nsec: int" 4
.IX Item "date-nsec: int"
fractional part in nano seconds to be used with date-sec
.ie n .IP """vm-clock-sec: int""" 4
.el .IP "\f(CWvm-clock-sec: int" 4
.IX Item "vm-clock-sec: int"
\s-1VM\s0 clock relative to boot in seconds
.ie n .IP """vm-clock-nsec: int""" 4
.el .IP "\f(CWvm-clock-nsec: int" 4
.IX Item "vm-clock-nsec: int"
fractional part in nano seconds to be used with vm-clock-sec

**Since:**
1.3

**ImageInfoSpecificQCow2EncryptionBase** (Object)

**Members:**
.ie n .IP """format: BlockdevQcow2EncryptionFormat""" 4
.el .IP "\f(CWformat: BlockdevQcow2EncryptionFormat" 4
.IX Item "format: BlockdevQcow2EncryptionFormat"
The encryption format

**Since:**
2.10

**ImageInfoSpecificQCow2Encryption** (Object)

**Members:**
.ie n .IP "The members of ""ImageInfoSpecificQCow2EncryptionBase""" 4
.el .IP "The members of \f(CWImageInfoSpecificQCow2EncryptionBase" 4
.IX Item "The members of ImageInfoSpecificQCow2EncryptionBase"
.ie n .IP "The members of ""QCryptoBlockInfoLUKS"" when ""format"" is ""luks""" 4
.el .IP "The members of \f(CWQCryptoBlockInfoLUKS when \f(CWformat is \`\`luks''" 4
.IX Item "The members of QCryptoBlockInfoLUKS when format is luks"

**Since:**
2.10

**ImageInfoSpecificQCow2** (Object)

**Members:**
.ie n .IP """compat: string""" 4
.el .IP "\f(CWcompat: string" 4
.IX Item "compat: string"
compatibility level
.ie n .IP """lazy-refcounts: boolean"" (optional)" 4
.el .IP "\f(CWlazy-refcounts: boolean (optional)" 4
.IX Item "lazy-refcounts: boolean (optional)"
on or off; only valid for compat &gt;= 1.1
.ie n .IP """corrupt: boolean"" (optional)" 4
.el .IP "\f(CWcorrupt: boolean (optional)" 4
.IX Item "corrupt: boolean (optional)"
true if the image has been marked corrupt; only valid for
compat &gt;= 1.1 (since 2.2)
.ie n .IP """refcount-bits: int""" 4
.el .IP "\f(CWrefcount-bits: int" 4
.IX Item "refcount-bits: int"
width of a refcount entry in bits (since 2.3)
.ie n .IP """encrypt: ImageInfoSpecificQCow2Encryption"" (optional)" 4
.el .IP "\f(CWencrypt: ImageInfoSpecificQCow2Encryption (optional)" 4
.IX Item "encrypt: ImageInfoSpecificQCow2Encryption (optional)"
details about encryption parameters; only set if image
is encrypted (since 2.10)

**Since:**
1.7

**ImageInfoSpecificVmdk** (Object)

**Members:**
.ie n .IP """create-type: string""" 4
.el .IP "\f(CWcreate-type: string" 4
.IX Item "create-type: string"
The create type of \s-1VMDK\s0 image
.ie n .IP """cid: int""" 4
.el .IP "\f(CWcid: int" 4
.IX Item "cid: int"
Content id of image
.ie n .IP """parent-cid: int""" 4
.el .IP "\f(CWparent-cid: int" 4
.IX Item "parent-cid: int"
Parent \s-1VMDK\s0 image's cid
.ie n .IP """extents: array of ImageInfo""" 4
.el .IP "\f(CWextents: array of ImageInfo" 4
.IX Item "extents: array of ImageInfo"
List of extent files

**Since:**
1.7

**ImageInfoSpecific** (Object)

A discriminated record of image format specific information structures.

**Members:**
.ie n .IP """type""" 4
.el .IP "\f(CWtype" 4
.IX Item "type"
One of qcow2\*(R", \*(L"vmdk\*(R", \*(L"luks\*(R"
.ie n .IP """data: ImageInfoSpecificQCow2"" when ""type"" is ""qcow2""" 4
.el .IP "\f(CWdata: ImageInfoSpecificQCow2 when \f(CWtype is \`\`qcow2''" 4
.IX Item "data: ImageInfoSpecificQCow2 when type is qcow2"
.ie n .IP """data: ImageInfoSpecificVmdk"" when ""type"" is ""vmdk""" 4
.el .IP "\f(CWdata: ImageInfoSpecificVmdk when \f(CWtype is \`\`vmdk''" 4
.IX Item "data: ImageInfoSpecificVmdk when type is vmdk"
.ie n .IP """data: QCryptoBlockInfoLUKS"" when ""type"" is ""luks""" 4
.el .IP "\f(CWdata: QCryptoBlockInfoLUKS when \f(CWtype is \`\`luks''" 4
.IX Item "data: QCryptoBlockInfoLUKS when type is luks"

**Since:**
1.7

**ImageInfo** (Object)

Information about a \s-1QEMU\s0 image file

**Members:**
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
name of the image file
.ie n .IP """format: string""" 4
.el .IP "\f(CWformat: string" 4
.IX Item "format: string"
format of the image file
.ie n .IP """virtual-size: int""" 4
.el .IP "\f(CWvirtual-size: int" 4
.IX Item "virtual-size: int"
maximum capacity in bytes of the image
.ie n .IP """actual-size: int"" (optional)" 4
.el .IP "\f(CWactual-size: int (optional)" 4
.IX Item "actual-size: int (optional)"
actual size on disk in bytes of the image
.ie n .IP """dirty-flag: boolean"" (optional)" 4
.el .IP "\f(CWdirty-flag: boolean (optional)" 4
.IX Item "dirty-flag: boolean (optional)"
true if image is not cleanly closed
.ie n .IP """cluster-size: int"" (optional)" 4
.el .IP "\f(CWcluster-size: int (optional)" 4
.IX Item "cluster-size: int (optional)"
size of a cluster in bytes
.ie n .IP """encrypted: boolean"" (optional)" 4
.el .IP "\f(CWencrypted: boolean (optional)" 4
.IX Item "encrypted: boolean (optional)"
true if the image is encrypted
.ie n .IP """compressed: boolean"" (optional)" 4
.el .IP "\f(CWcompressed: boolean (optional)" 4
.IX Item "compressed: boolean (optional)"
true if the image is compressed (Since 1.7)
.ie n .IP """backing-filename: string"" (optional)" 4
.el .IP "\f(CWbacking-filename: string (optional)" 4
.IX Item "backing-filename: string (optional)"
name of the backing file
.ie n .IP """full-backing-filename: string"" (optional)" 4
.el .IP "\f(CWfull-backing-filename: string (optional)" 4
.IX Item "full-backing-filename: string (optional)"
full path of the backing file
.ie n .IP """backing-filename-format: string"" (optional)" 4
.el .IP "\f(CWbacking-filename-format: string (optional)" 4
.IX Item "backing-filename-format: string (optional)"
the format of the backing file
.ie n .IP """snapshots: array of SnapshotInfo"" (optional)" 4
.el .IP "\f(CWsnapshots: array of SnapshotInfo (optional)" 4
.IX Item "snapshots: array of SnapshotInfo (optional)"
list of \s-1VM\s0 snapshots
.ie n .IP """backing-image: ImageInfo"" (optional)" 4
.el .IP "\f(CWbacking-image: ImageInfo (optional)" 4
.IX Item "backing-image: ImageInfo (optional)"
info of the backing image (since 1.6)
.ie n .IP """format-specific: ImageInfoSpecific"" (optional)" 4
.el .IP "\f(CWformat-specific: ImageInfoSpecific (optional)" 4
.IX Item "format-specific: ImageInfoSpecific (optional)"
structure supplying additional format-specific
information (since 1.7)

**Since:**
1.3

**ImageCheck** (Object)

Information about a \s-1QEMU\s0 image file check

**Members:**
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
name of the image file checked
.ie n .IP """format: string""" 4
.el .IP "\f(CWformat: string" 4
.IX Item "format: string"
format of the image file checked
.ie n .IP """check-errors: int""" 4
.el .IP "\f(CWcheck-errors: int" 4
.IX Item "check-errors: int"
number of unexpected errors occurred during check
.ie n .IP """image-end-offset: int"" (optional)" 4
.el .IP "\f(CWimage-end-offset: int (optional)" 4
.IX Item "image-end-offset: int (optional)"
offset (in bytes) where the image ends, this
field is present if the driver for the image format
supports it
.ie n .IP """corruptions: int"" (optional)" 4
.el .IP "\f(CWcorruptions: int (optional)" 4
.IX Item "corruptions: int (optional)"
number of corruptions found during the check if any
.ie n .IP """leaks: int"" (optional)" 4
.el .IP "\f(CWleaks: int (optional)" 4
.IX Item "leaks: int (optional)"
number of leaks found during the check if any
.ie n .IP """corruptions-fixed: int"" (optional)" 4
.el .IP "\f(CWcorruptions-fixed: int (optional)" 4
.IX Item "corruptions-fixed: int (optional)"
number of corruptions fixed during the check
if any
.ie n .IP """leaks-fixed: int"" (optional)" 4
.el .IP "\f(CWleaks-fixed: int (optional)" 4
.IX Item "leaks-fixed: int (optional)"
number of leaks fixed during the check if any
.ie n .IP """total-clusters: int"" (optional)" 4
.el .IP "\f(CWtotal-clusters: int (optional)" 4
.IX Item "total-clusters: int (optional)"
total number of clusters, this field is present
if the driver for the image format supports it
.ie n .IP """allocated-clusters: int"" (optional)" 4
.el .IP "\f(CWallocated-clusters: int (optional)" 4
.IX Item "allocated-clusters: int (optional)"
total number of allocated clusters, this
field is present if the driver for the image format
supports it
.ie n .IP """fragmented-clusters: int"" (optional)" 4
.el .IP "\f(CWfragmented-clusters: int (optional)" 4
.IX Item "fragmented-clusters: int (optional)"
total number of fragmented clusters, this
field is present if the driver for the image format
supports it
.ie n .IP """compressed-clusters: int"" (optional)" 4
.el .IP "\f(CWcompressed-clusters: int (optional)" 4
.IX Item "compressed-clusters: int (optional)"
total number of compressed clusters, this
field is present if the driver for the image format
supports it

**Since:**
1.4

**MapEntry** (Object)

Mapping information from a virtual block range to a host file range

**Members:**
.ie n .IP """start: int""" 4
.el .IP "\f(CWstart: int" 4
.IX Item "start: int"
the start byte of the mapped virtual range
.ie n .IP """length: int""" 4
.el .IP "\f(CWlength: int" 4
.IX Item "length: int"
the number of bytes of the mapped virtual range
.ie n .IP """data: boolean""" 4
.el .IP "\f(CWdata: boolean" 4
.IX Item "data: boolean"
whether the mapped range has data
.ie n .IP """zero: boolean""" 4
.el .IP "\f(CWzero: boolean" 4
.IX Item "zero: boolean"
whether the virtual blocks are zeroed
.ie n .IP """depth: int""" 4
.el .IP "\f(CWdepth: int" 4
.IX Item "depth: int"
the depth of the mapping
.ie n .IP """offset: int"" (optional)" 4
.el .IP "\f(CWoffset: int (optional)" 4
.IX Item "offset: int (optional)"
the offset in file that the virtual sectors are mapped to
.ie n .IP """filename: string"" (optional)" 4
.el .IP "\f(CWfilename: string (optional)" 4
.IX Item "filename: string (optional)"
filename that is referred to by \f(CW`offset\*(C'

**Since:**
2.6

**BlockdevCacheInfo** (Object)

Cache mode information for a block device

**Members:**
.ie n .IP """writeback: boolean""" 4
.el .IP "\f(CWwriteback: boolean" 4
.IX Item "writeback: boolean"
true if writeback mode is enabled
.ie n .IP """direct: boolean""" 4
.el .IP "\f(CWdirect: boolean" 4
.IX Item "direct: boolean"
true if the host page cache is bypassed (O_DIRECT)
.ie n .IP """no-flush: boolean""" 4
.el .IP "\f(CWno-flush: boolean" 4
.IX Item "no-flush: boolean"
true if flush requests are ignored for the device

**Since:**
2.3

**BlockDeviceInfo** (Object)

Information about the backing device for a block device.

**Members:**
.ie n .IP """file: string""" 4
.el .IP "\f(CWfile: string" 4
.IX Item "file: string"
the filename of the backing device
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
the name of the block driver node (Since 2.0)
.ie n .IP """ro: boolean""" 4
.el .IP "\f(CWro: boolean" 4
.IX Item "ro: boolean"
true if the backing device was open read-only
.ie n .IP """drv: string""" 4
.el .IP "\f(CWdrv: string" 4
.IX Item "drv: string"
the name of the block format used to open the backing device. As of
0.14.0 this can be: 'blkdebug', 'bochs', 'cloop', 'cow', 'dmg',
'file', 'file', 'ftp', 'ftps', 'host_cdrom', 'host_device',
'http', 'https', 'luks', 'nbd', 'parallels', 'qcow',
'qcow2', 'raw', 'vdi', 'vmdk', 'vpc', 'vvfat'
2.2: 'archipelago' added, 'cow' dropped
2.3: 'host_floppy' deprecated
2.5: 'host_floppy' dropped
2.6: 'luks' added
2.8: 'replication' added, 'tftp' dropped
2.9: 'archipelago' dropped
.ie n .IP """backing_file: string"" (optional)" 4
.el .IP "\f(CWbacking_file: string (optional)" 4
.IX Item "backing_file: string (optional)"
the name of the backing file (for copy-on-write)
.ie n .IP """backing_file_depth: int""" 4
.el .IP "\f(CWbacking_file_depth: int" 4
.IX Item "backing_file_depth: int"
number of files in the backing file chain (since: 1.2)
.ie n .IP """encrypted: boolean""" 4
.el .IP "\f(CWencrypted: boolean" 4
.IX Item "encrypted: boolean"
true if the backing device is encrypted
.ie n .IP """encryption_key_missing: boolean""" 4
.el .IP "\f(CWencryption_key_missing: boolean" 4
.IX Item "encryption_key_missing: boolean"
Deprecated; always false
.ie n .IP """detect_zeroes: BlockdevDetectZeroesOptions""" 4
.el .IP "\f(CWdetect_zeroes: BlockdevDetectZeroesOptions" 4
.IX Item "detect_zeroes: BlockdevDetectZeroesOptions"
detect and optimize zero writes (Since 2.1)
.ie n .IP """bps: int""" 4
.el .IP "\f(CWbps: int" 4
.IX Item "bps: int"
total throughput limit in bytes per second is specified
.ie n .IP """bps_rd: int""" 4
.el .IP "\f(CWbps_rd: int" 4
.IX Item "bps_rd: int"
read throughput limit in bytes per second is specified
.ie n .IP """bps_wr: int""" 4
.el .IP "\f(CWbps_wr: int" 4
.IX Item "bps_wr: int"
write throughput limit in bytes per second is specified
.ie n .IP """iops: int""" 4
.el .IP "\f(CWiops: int" 4
.IX Item "iops: int"
total I/O operations per second is specified
.ie n .IP """iops_rd: int""" 4
.el .IP "\f(CWiops_rd: int" 4
.IX Item "iops_rd: int"
read I/O operations per second is specified
.ie n .IP """iops_wr: int""" 4
.el .IP "\f(CWiops_wr: int" 4
.IX Item "iops_wr: int"
write I/O operations per second is specified
.ie n .IP """image: ImageInfo""" 4
.el .IP "\f(CWimage: ImageInfo" 4
.IX Item "image: ImageInfo"
the info of image used (since: 1.6)
.ie n .IP """bps_max: int"" (optional)" 4
.el .IP "\f(CWbps_max: int (optional)" 4
.IX Item "bps_max: int (optional)"
total throughput limit during bursts,
in bytes (Since 1.7)
.ie n .IP """bps_rd_max: int"" (optional)" 4
.el .IP "\f(CWbps_rd_max: int (optional)" 4
.IX Item "bps_rd_max: int (optional)"
read throughput limit during bursts,
in bytes (Since 1.7)
.ie n .IP """bps_wr_max: int"" (optional)" 4
.el .IP "\f(CWbps_wr_max: int (optional)" 4
.IX Item "bps_wr_max: int (optional)"
write throughput limit during bursts,
in bytes (Since 1.7)
.ie n .IP """iops_max: int"" (optional)" 4
.el .IP "\f(CWiops_max: int (optional)" 4
.IX Item "iops_max: int (optional)"
total I/O operations per second during bursts,
in bytes (Since 1.7)
.ie n .IP """iops_rd_max: int"" (optional)" 4
.el .IP "\f(CWiops_rd_max: int (optional)" 4
.IX Item "iops_rd_max: int (optional)"
read I/O operations per second during bursts,
in bytes (Since 1.7)
.ie n .IP """iops_wr_max: int"" (optional)" 4
.el .IP "\f(CWiops_wr_max: int (optional)" 4
.IX Item "iops_wr_max: int (optional)"
write I/O operations per second during bursts,
in bytes (Since 1.7)
.ie n .IP """bps_max_length: int"" (optional)" 4
.el .IP "\f(CWbps_max_length: int (optional)" 4
.IX Item "bps_max_length: int (optional)"
maximum length of the \f(CW`bps\_max\*(C' burst
period, in seconds. (Since 2.6)
.ie n .IP """bps_rd_max_length: int"" (optional)" 4
.el .IP "\f(CWbps_rd_max_length: int (optional)" 4
.IX Item "bps_rd_max_length: int (optional)"
maximum length of the \f(CW`bps\_rd\_max\*(C'
burst period, in seconds. (Since 2.6)
.ie n .IP """bps_wr_max_length: int"" (optional)" 4
.el .IP "\f(CWbps_wr_max_length: int (optional)" 4
.IX Item "bps_wr_max_length: int (optional)"
maximum length of the \f(CW`bps\_wr\_max\*(C'
burst period, in seconds. (Since 2.6)
.ie n .IP """iops_max_length: int"" (optional)" 4
.el .IP "\f(CWiops_max_length: int (optional)" 4
.IX Item "iops_max_length: int (optional)"
maximum length of the \f(CW`iops\*(C' burst
period, in seconds. (Since 2.6)
.ie n .IP """iops_rd_max_length: int"" (optional)" 4
.el .IP "\f(CWiops_rd_max_length: int (optional)" 4
.IX Item "iops_rd_max_length: int (optional)"
maximum length of the \f(CW`iops\_rd\_max\*(C'
burst period, in seconds. (Since 2.6)
.ie n .IP """iops_wr_max_length: int"" (optional)" 4
.el .IP "\f(CWiops_wr_max_length: int (optional)" 4
.IX Item "iops_wr_max_length: int (optional)"
maximum length of the \f(CW`iops\_wr\_max\*(C'
burst period, in seconds. (Since 2.6)
.ie n .IP """iops_size: int"" (optional)" 4
.el .IP "\f(CWiops_size: int (optional)" 4
.IX Item "iops_size: int (optional)"
an I/O size in bytes (Since 1.7)
.ie n .IP """group: string"" (optional)" 4
.el .IP "\f(CWgroup: string (optional)" 4
.IX Item "group: string (optional)"
throttle group name (Since 2.4)
.ie n .IP """cache: BlockdevCacheInfo""" 4
.el .IP "\f(CWcache: BlockdevCacheInfo" 4
.IX Item "cache: BlockdevCacheInfo"
the cache mode used for the block device (since: 2.3)
.ie n .IP """write_threshold: int""" 4
.el .IP "\f(CWwrite_threshold: int" 4
.IX Item "write_threshold: int"
configured write threshold for the device.
0 if disabled. (Since 2.3)

**Since:**
0.14.0

**BlockDeviceIoStatus** (Enum)

An enumeration of block device I/O status.

**Values:**
.ie n .IP """ok""" 4
.el .IP "\f(CWok" 4
.IX Item "ok"
The last I/O operation has succeeded
.ie n .IP """failed""" 4
.el .IP "\f(CWfailed" 4
.IX Item "failed"
The last I/O operation has failed
.ie n .IP """nospace""" 4
.el .IP "\f(CWnospace" 4
.IX Item "nospace"
The last I/O operation has failed due to a no-space condition

**Since:**
1.0

**BlockDeviceMapEntry** (Object)

Entry in the metadata map of the device (returned by qemu-img map\*(R")

**Members:**
.ie n .IP """start: int""" 4
.el .IP "\f(CWstart: int" 4
.IX Item "start: int"
Offset in the image of the first byte described by this entry
(in bytes)
.ie n .IP """length: int""" 4
.el .IP "\f(CWlength: int" 4
.IX Item "length: int"
Length of the range described by this entry (in bytes)
.ie n .IP """depth: int""" 4
.el .IP "\f(CWdepth: int" 4
.IX Item "depth: int"
Number of layers (0 = top image, 1 = top image's backing file, etc.)
before reaching one for which the range is allocated.  The value is
in the range 0 to the depth of the image chain - 1.
.ie n .IP """zero: boolean""" 4
.el .IP "\f(CWzero: boolean" 4
.IX Item "zero: boolean"
the sectors in this range read as zeros
.ie n .IP """data: boolean""" 4
.el .IP "\f(CWdata: boolean" 4
.IX Item "data: boolean"
reading the image will actually read data from a file (in particular,
if \f(CW`offset\*(C' is present this means that the sectors are not simply
preallocated, but contain actual data in raw format)
.ie n .IP """offset: int"" (optional)" 4
.el .IP "\f(CWoffset: int (optional)" 4
.IX Item "offset: int (optional)"
if present, the image file stores the data for this range in
raw format at the given offset.

**Since:**
1.7

**DirtyBitmapStatus** (Enum)

An enumeration of possible states that a dirty bitmap can report to the user.

**Values:**
.ie n .IP """frozen""" 4
.el .IP "\f(CWfrozen" 4
.IX Item "frozen"
The bitmap is currently in-use by a backup operation or block job,
and is immutable.
.ie n .IP """disabled""" 4
.el .IP "\f(CWdisabled" 4
.IX Item "disabled"
The bitmap is currently in-use by an internal operation and is
read-only. It can still be deleted.
.ie n .IP """active""" 4
.el .IP "\f(CWactive" 4
.IX Item "active"
The bitmap is actively monitoring for new writes, and can be cleared,
deleted, or used for backup operations.
.ie n .IP """locked""" 4
.el .IP "\f(CWlocked" 4
.IX Item "locked"
The bitmap is currently in-use by some operation and can not be
cleared, deleted, or used for backup operations. (Since 2.12)

**Since:**
2.4

**BlockDirtyInfo** (Object)

Block dirty bitmap information.

**Members:**
.ie n .IP """name: string"" (optional)" 4
.el .IP "\f(CWname: string (optional)" 4
.IX Item "name: string (optional)"
the name of the dirty bitmap (Since 2.4)
.ie n .IP """count: int""" 4
.el .IP "\f(CWcount: int" 4
.IX Item "count: int"
number of dirty bytes according to the dirty bitmap
.ie n .IP """granularity: int""" 4
.el .IP "\f(CWgranularity: int" 4
.IX Item "granularity: int"
granularity of the dirty bitmap in bytes (since 1.4)
.ie n .IP """status: DirtyBitmapStatus""" 4
.el .IP "\f(CWstatus: DirtyBitmapStatus" 4
.IX Item "status: DirtyBitmapStatus"
current status of the dirty bitmap (since 2.4)

**Since:**
1.3

**BlockLatencyHistogramInfo** (Object)

Block latency histogram.

**Members:**
.ie n .IP """boundaries: array of int""" 4
.el .IP "\f(CWboundaries: array of int" 4
.IX Item "boundaries: array of int"
list of interval boundary values in nanoseconds, all greater
than zero and in ascending order.
For example, the list [10, 50, 100] produces the following
histogram intervals: [0, 10), [10, 50), [50, 100), [100, +inf).
.ie n .IP """bins: array of int""" 4
.el .IP "\f(CWbins: array of int" 4
.IX Item "bins: array of int"
list of io request counts corresponding to histogram intervals.
len(\f(CW`bins\*(C') = len(\f(CW\*(C\`boundaries\*(C') + 1
For the example above, \f(CW`bins\*(C' may be something like [3, 1, 5, 2],
and corresponding histogram looks like:
.Sp
5|           *
4|           *
3|         ** **
2|         ** **    *
1|    ** **       ** **
+------------------
10   50   100

**Since:**
2.12

**x-block-latency-histogram-set**  (Command)
Manage read, write and flush latency histograms for the device.

If only \f(CW`device\*(C' parameter is specified, remove all present latency histograms
for the device. Otherwise, add/reset some of (or all) latency histograms.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
device name to set latency histogram for.
.ie n .IP """boundaries: array of int"" (optional)" 4
.el .IP "\f(CWboundaries: array of int (optional)" 4
.IX Item "boundaries: array of int (optional)"
list of interval boundary values (see description in
BlockLatencyHistogramInfo definition). If specified, all
latency histograms are removed, and empty ones created for all
io types with intervals corresponding to \f(CW`boundaries\*(C' (except for
io types, for which specific boundaries are set through the
following parameters).
.ie n .IP """boundaries-read: array of int"" (optional)" 4
.el .IP "\f(CWboundaries-read: array of int (optional)" 4
.IX Item "boundaries-read: array of int (optional)"
list of interval boundary values for read latency
histogram. If specified, old read latency histogram is
removed, and empty one created with intervals
corresponding to \f(CW`boundaries-read\*(C'. The parameter has higher
priority then \f(CW`boundaries\*(C'.
.ie n .IP """boundaries-write: array of int"" (optional)" 4
.el .IP "\f(CWboundaries-write: array of int (optional)" 4
.IX Item "boundaries-write: array of int (optional)"
list of interval boundary values for write latency
histogram.
.ie n .IP """boundaries-flush: array of int"" (optional)" 4
.el .IP "\f(CWboundaries-flush: array of int (optional)" 4
.IX Item "boundaries-flush: array of int (optional)"
list of interval boundary values for flush latency
histogram.

**Returns:**
error if device is not found or any boundary arrays are invalid.

**Since:**
2.12

**Example:**

.Vb 2
        set new histograms for all io types with intervals
        [0, 10), [10, 50), [50, 100), [100, +inf):
        
        -&gt; { "execute": "block-latency-histogram-set",
             "arguments": { "device": "drive0",
                            "boundaries": [10, 50, 100] } }
        &lt;- { "return": {} }
.Ve

**Example:**

.Vb 2
        set new histogram only for write, other histograms will remain
        not changed (or not created):
        
        -&gt; { "execute": "block-latency-histogram-set",
             "arguments": { "device": "drive0",
                            "boundaries-write": [10, 50, 100] } }
        &lt;- { "return": {} }
.Ve

**Example:**

.Vb 3
        set new histograms with the following intervals:
          read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
          write: [0, 1000), [1000, 5000), [5000, +inf)
        
        -&gt; { "execute": "block-latency-histogram-set",
             "arguments": { "device": "drive0",
                            "boundaries": [10, 50, 100],
                            "boundaries-write": [1000, 5000] } }
        &lt;- { "return": {} }
.Ve

**Example:**

.Vb 1
        remove all latency histograms:
        
        -&gt; { "execute": "block-latency-histogram-set",
             "arguments": { "device": "drive0" } }
        &lt;- { "return": {} }
.Ve

**BlockInfo** (Object)

Block device information.  This structure describes a virtual device and
the backing device associated with it.

**Members:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The device name associated with the virtual device.
.ie n .IP """qdev: string"" (optional)" 4
.el .IP "\f(CWqdev: string (optional)" 4
.IX Item "qdev: string (optional)"
The qdev \s-1ID,\s0 or if no \s-1ID\s0 is assigned, the \s-1QOM\s0 path of the block
device. (since 2.10)
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
This field is returned only for compatibility reasons, it should
not be used (always returns 'unknown')
.ie n .IP """removable: boolean""" 4
.el .IP "\f(CWremovable: boolean" 4
.IX Item "removable: boolean"
True if the device supports removable media.
.ie n .IP """locked: boolean""" 4
.el .IP "\f(CWlocked: boolean" 4
.IX Item "locked: boolean"
True if the guest has locked this device from having its media
removed
.ie n .IP """tray_open: boolean"" (optional)" 4
.el .IP "\f(CWtray_open: boolean (optional)" 4
.IX Item "tray_open: boolean (optional)"
True if the device's tray is open
(only present if it has a tray)
.ie n .IP """dirty-bitmaps: array of BlockDirtyInfo"" (optional)" 4
.el .IP "\f(CWdirty-bitmaps: array of BlockDirtyInfo (optional)" 4
.IX Item "dirty-bitmaps: array of BlockDirtyInfo (optional)"
dirty bitmaps information (only present if the
driver has one or more dirty bitmaps) (Since 2.0)
.ie n .IP """io-status: BlockDeviceIoStatus"" (optional)" 4
.el .IP "\f(CWio-status: BlockDeviceIoStatus (optional)" 4
.IX Item "io-status: BlockDeviceIoStatus (optional)"
\f(CW`BlockDeviceIoStatus\*(C'. Only present if the device
supports it and the \s-1VM\s0 is configured to stop on errors
(supported device models: virtio-blk, \s-1IDE, SCSI\s0 except
scsi-generic)
.ie n .IP """inserted: BlockDeviceInfo"" (optional)" 4
.el .IP "\f(CWinserted: BlockDeviceInfo (optional)" 4
.IX Item "inserted: BlockDeviceInfo (optional)"
\f(CW`BlockDeviceInfo\*(C' describing the device if media is
present

**Since:**
0.14.0

**BlockMeasureInfo** (Object)

Image file size calculation information.  This structure describes the size
requirements for creating a new image file.

The size requirements depend on the new image file format.  File size always
equals virtual disk size for the 'raw' format, even for sparse \s-1POSIX\s0 files.
Compact formats such as 'qcow2' represent unallocated and zero regions
efficiently so file size may be smaller than virtual disk size.

The values are upper bounds that are guaranteed to fit the new image file.
Subsequent modification, such as internal snapshot or bitmap creation, may
require additional space and is not covered here.

**Members:**
.ie n .IP """required: int""" 4
.el .IP "\f(CWrequired: int" 4
.IX Item "required: int"
Size required for a new image file, in bytes.
.ie n .IP """fully-allocated: int""" 4
.el .IP "\f(CWfully-allocated: int" 4
.IX Item "fully-allocated: int"
Image file size, in bytes, once data has been written
to all sectors.

**Since:**
2.10

**query-block**  (Command)
Get a list of BlockInfo for all virtual block devices.

**Returns:**
a list of \f(CW`BlockInfo\*(C' describing each virtual block device. Filter
nodes that were created implicitly are skipped over.

**Since:**
0.14.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-block" }
        &lt;- {
              "return":[
                 {
                    "io-status": "ok",
                    "device":"ide0-hd0",
                    "locked":false,
                    "removable":false,
                    "inserted":{
                       "ro":false,
                       "drv":"qcow2",
                       "encrypted":false,
                       "file":"disks/test.qcow2",
                       "backing_file_depth":1,
                       "bps":1000000,
                       "bps_rd":0,
                       "bps_wr":0,
                       "iops":1000000,
                       "iops_rd":0,
                       "iops_wr":0,
                       "bps_max": 8000000,
                       "bps_rd_max": 0,
                       "bps_wr_max": 0,
                       "iops_max": 0,
                       "iops_rd_max": 0,
                       "iops_wr_max": 0,
                       "iops_size": 0,
                       "detect_zeroes": "on",
                       "write_threshold": 0,
                       "image":{
                          "filename":"disks/test.qcow2",
                          "format":"qcow2",
                          "virtual-size":2048000,
                          "backing_file":"base.qcow2",
                          "full-backing-filename":"disks/base.qcow2",
                          "backing-filename-format":"qcow2",
                          "snapshots":[
                             {
                                "id": "1",
                                "name": "snapshot1",
                                "vm-state-size": 0,
                                "date-sec": 10000200,
                                "date-nsec": 12,
                                "vm-clock-sec": 206,
                                "vm-clock-nsec": 30
                             }
                          ],
                          "backing-image":{
                              "filename":"disks/base.qcow2",
                              "format":"qcow2",
                              "virtual-size":2048000
                          }
                       }
                    },
                    "qdev": "ide_disk",
                    "type":"unknown"
                 },
                 {
                    "io-status": "ok",
                    "device":"ide1-cd0",
                    "locked":false,
                    "removable":true,
                    "qdev": "/machine/unattached/device[23]",
                    "tray_open": false,
                    "type":"unknown"
                 },
                 {
                    "device":"floppy0",
                    "locked":false,
                    "removable":true,
                    "qdev": "/machine/unattached/device[20]",
                    "type":"unknown"
                 },
                 {
                    "device":"sd0",
                    "locked":false,
                    "removable":true,
                    "type":"unknown"
                 }
              ]
           }
.Ve

**BlockDeviceTimedStats** (Object)

Statistics of a block device during a given interval of time.

**Members:**
.ie n .IP """interval_length: int""" 4
.el .IP "\f(CWinterval_length: int" 4
.IX Item "interval_length: int"
Interval used for calculating the statistics,
in seconds.
.ie n .IP """min_rd_latency_ns: int""" 4
.el .IP "\f(CWmin_rd_latency_ns: int" 4
.IX Item "min_rd_latency_ns: int"
Minimum latency of read operations in the
defined interval, in nanoseconds.
.ie n .IP """min_wr_latency_ns: int""" 4
.el .IP "\f(CWmin_wr_latency_ns: int" 4
.IX Item "min_wr_latency_ns: int"
Minimum latency of write operations in the
defined interval, in nanoseconds.
.ie n .IP """min_flush_latency_ns: int""" 4
.el .IP "\f(CWmin_flush_latency_ns: int" 4
.IX Item "min_flush_latency_ns: int"
Minimum latency of flush operations in the
defined interval, in nanoseconds.
.ie n .IP """max_rd_latency_ns: int""" 4
.el .IP "\f(CWmax_rd_latency_ns: int" 4
.IX Item "max_rd_latency_ns: int"
Maximum latency of read operations in the
defined interval, in nanoseconds.
.ie n .IP """max_wr_latency_ns: int""" 4
.el .IP "\f(CWmax_wr_latency_ns: int" 4
.IX Item "max_wr_latency_ns: int"
Maximum latency of write operations in the
defined interval, in nanoseconds.
.ie n .IP """max_flush_latency_ns: int""" 4
.el .IP "\f(CWmax_flush_latency_ns: int" 4
.IX Item "max_flush_latency_ns: int"
Maximum latency of flush operations in the
defined interval, in nanoseconds.
.ie n .IP """avg_rd_latency_ns: int""" 4
.el .IP "\f(CWavg_rd_latency_ns: int" 4
.IX Item "avg_rd_latency_ns: int"
Average latency of read operations in the
defined interval, in nanoseconds.
.ie n .IP """avg_wr_latency_ns: int""" 4
.el .IP "\f(CWavg_wr_latency_ns: int" 4
.IX Item "avg_wr_latency_ns: int"
Average latency of write operations in the
defined interval, in nanoseconds.
.ie n .IP """avg_flush_latency_ns: int""" 4
.el .IP "\f(CWavg_flush_latency_ns: int" 4
.IX Item "avg_flush_latency_ns: int"
Average latency of flush operations in the
defined interval, in nanoseconds.
.ie n .IP """avg_rd_queue_depth: number""" 4
.el .IP "\f(CWavg_rd_queue_depth: number" 4
.IX Item "avg_rd_queue_depth: number"
Average number of pending read operations
in the defined interval.
.ie n .IP """avg_wr_queue_depth: number""" 4
.el .IP "\f(CWavg_wr_queue_depth: number" 4
.IX Item "avg_wr_queue_depth: number"
Average number of pending write operations
in the defined interval.

**Since:**
2.5

**BlockDeviceStats** (Object)

Statistics of a virtual block device or a block backing device.

**Members:**
.ie n .IP """rd_bytes: int""" 4
.el .IP "\f(CWrd_bytes: int" 4
.IX Item "rd_bytes: int"
The number of bytes read by the device.
.ie n .IP """wr_bytes: int""" 4
.el .IP "\f(CWwr_bytes: int" 4
.IX Item "wr_bytes: int"
The number of bytes written by the device.
.ie n .IP """rd_operations: int""" 4
.el .IP "\f(CWrd_operations: int" 4
.IX Item "rd_operations: int"
The number of read operations performed by the device.
.ie n .IP """wr_operations: int""" 4
.el .IP "\f(CWwr_operations: int" 4
.IX Item "wr_operations: int"
The number of write operations performed by the device.
.ie n .IP """flush_operations: int""" 4
.el .IP "\f(CWflush_operations: int" 4
.IX Item "flush_operations: int"
The number of cache flush operations performed by the
device (since 0.15.0)
.ie n .IP """flush_total_time_ns: int""" 4
.el .IP "\f(CWflush_total_time_ns: int" 4
.IX Item "flush_total_time_ns: int"
Total time spend on cache flushes in nano-seconds
(since 0.15.0).
.ie n .IP """wr_total_time_ns: int""" 4
.el .IP "\f(CWwr_total_time_ns: int" 4
.IX Item "wr_total_time_ns: int"
Total time spend on writes in nano-seconds (since 0.15.0).
.ie n .IP """rd_total_time_ns: int""" 4
.el .IP "\f(CWrd_total_time_ns: int" 4
.IX Item "rd_total_time_ns: int"
Total_time_spend on reads in nano-seconds (since 0.15.0).
.ie n .IP """wr_highest_offset: int""" 4
.el .IP "\f(CWwr_highest_offset: int" 4
.IX Item "wr_highest_offset: int"
The offset after the greatest byte written to the
device.  The intended use of this information is for
growable sparse files (like qcow2) that are used on top
of a physical device.
.ie n .IP """rd_merged: int""" 4
.el .IP "\f(CWrd_merged: int" 4
.IX Item "rd_merged: int"
Number of read requests that have been merged into another
request (Since 2.3).
.ie n .IP """wr_merged: int""" 4
.el .IP "\f(CWwr_merged: int" 4
.IX Item "wr_merged: int"
Number of write requests that have been merged into another
request (Since 2.3).
.ie n .IP """idle_time_ns: int"" (optional)" 4
.el .IP "\f(CWidle_time_ns: int (optional)" 4
.IX Item "idle_time_ns: int (optional)"
Time since the last I/O operation, in
nanoseconds. If the field is absent it means that
there haven't been any operations yet (Since 2.5).
.ie n .IP """failed_rd_operations: int""" 4
.el .IP "\f(CWfailed_rd_operations: int" 4
.IX Item "failed_rd_operations: int"
The number of failed read operations
performed by the device (Since 2.5)
.ie n .IP """failed_wr_operations: int""" 4
.el .IP "\f(CWfailed_wr_operations: int" 4
.IX Item "failed_wr_operations: int"
The number of failed write operations
performed by the device (Since 2.5)
.ie n .IP """failed_flush_operations: int""" 4
.el .IP "\f(CWfailed_flush_operations: int" 4
.IX Item "failed_flush_operations: int"
The number of failed flush operations
performed by the device (Since 2.5)
.ie n .IP """invalid_rd_operations: int""" 4
.el .IP "\f(CWinvalid_rd_operations: int" 4
.IX Item "invalid_rd_operations: int"
The number of invalid read operations
performed by the device (Since 2.5)
.ie n .IP """invalid_wr_operations: int""" 4
.el .IP "\f(CWinvalid_wr_operations: int" 4
.IX Item "invalid_wr_operations: int"
The number of invalid write operations
performed by the device (Since 2.5)
.ie n .IP """invalid_flush_operations: int""" 4
.el .IP "\f(CWinvalid_flush_operations: int" 4
.IX Item "invalid_flush_operations: int"
The number of invalid flush operations
performed by the device (Since 2.5)
.ie n .IP """account_invalid: boolean""" 4
.el .IP "\f(CWaccount_invalid: boolean" 4
.IX Item "account_invalid: boolean"
Whether invalid operations are included in the
last access statistics (Since 2.5)
.ie n .IP """account_failed: boolean""" 4
.el .IP "\f(CWaccount_failed: boolean" 4
.IX Item "account_failed: boolean"
Whether failed operations are included in the
latency and last access statistics (Since 2.5)
.ie n .IP """timed_stats: array of BlockDeviceTimedStats""" 4
.el .IP "\f(CWtimed_stats: array of BlockDeviceTimedStats" 4
.IX Item "timed_stats: array of BlockDeviceTimedStats"
Statistics specific to the set of previously defined
intervals of time (Since 2.5)
.ie n .IP """x_rd_latency_histogram: BlockLatencyHistogramInfo"" (optional)" 4
.el .IP "\f(CWx_rd_latency_histogram: BlockLatencyHistogramInfo (optional)" 4
.IX Item "x_rd_latency_histogram: BlockLatencyHistogramInfo (optional)"
\f(CW`BlockLatencyHistogramInfo\*(C'. (Since 2.12)
.ie n .IP """x_wr_latency_histogram: BlockLatencyHistogramInfo"" (optional)" 4
.el .IP "\f(CWx_wr_latency_histogram: BlockLatencyHistogramInfo (optional)" 4
.IX Item "x_wr_latency_histogram: BlockLatencyHistogramInfo (optional)"
\f(CW`BlockLatencyHistogramInfo\*(C'. (Since 2.12)
.ie n .IP """x_flush_latency_histogram: BlockLatencyHistogramInfo"" (optional)" 4
.el .IP "\f(CWx_flush_latency_histogram: BlockLatencyHistogramInfo (optional)" 4
.IX Item "x_flush_latency_histogram: BlockLatencyHistogramInfo (optional)"
\f(CW`BlockLatencyHistogramInfo\*(C'. (Since 2.12)

**Since:**
0.14.0

**BlockStats** (Object)

Statistics of a virtual block device or a block backing device.

**Members:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
If the stats are for a virtual block device, the name
corresponding to the virtual block device.
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
The node name of the device. (Since 2.3)
.ie n .IP """qdev: string"" (optional)" 4
.el .IP "\f(CWqdev: string (optional)" 4
.IX Item "qdev: string (optional)"
The qdev \s-1ID,\s0 or if no \s-1ID\s0 is assigned, the \s-1QOM\s0 path of the block
device. (since 3.0)
.ie n .IP """stats: BlockDeviceStats""" 4
.el .IP "\f(CWstats: BlockDeviceStats" 4
.IX Item "stats: BlockDeviceStats"
A \f(CW`BlockDeviceStats\*(C' for the device.
.ie n .IP """parent: BlockStats"" (optional)" 4
.el .IP "\f(CWparent: BlockStats (optional)" 4
.IX Item "parent: BlockStats (optional)"
This describes the file block device if it has one.
Contains recursively the statistics of the underlying
protocol (e.g. the host file for a qcow2 image). If there is
no underlying protocol, this field is omitted
.ie n .IP """backing: BlockStats"" (optional)" 4
.el .IP "\f(CWbacking: BlockStats (optional)" 4
.IX Item "backing: BlockStats (optional)"
This describes the backing block device if it has one.
(Since 2.0)

**Since:**
0.14.0

**query-blockstats**  (Command)
Query the \f(CW`BlockStats\*(C' for all virtual block devices.

**Arguments:**
.ie n .IP """query-nodes: boolean"" (optional)" 4
.el .IP "\f(CWquery-nodes: boolean (optional)" 4
.IX Item "query-nodes: boolean (optional)"
If true, the command will query all the block nodes
that have a node name, in a list which will include parent\*(R"
information, but not backing\*(R".
If false or omitted, the behavior is as before - query all the
device backends, recursively including their parent\*(R" and
backing\*(R". Filter nodes that were created implicitly are
skipped over in this mode. (Since 2.3)

**Returns:**
A list of \f(CW`BlockStats\*(C' for each virtual block devices.

**Since:**
0.14.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-blockstats" }
        &lt;- {
              "return":[
                 {
                    "device":"ide0-hd0",
                    "parent":{
                       "stats":{
                          "wr_highest_offset":3686448128,
                          "wr_bytes":9786368,
                          "wr_operations":751,
                          "rd_bytes":122567168,
                          "rd_operations":36772
                          "wr_total_times_ns":313253456
                          "rd_total_times_ns":3465673657
                          "flush_total_times_ns":49653
                          "flush_operations":61,
                          "rd_merged":0,
                          "wr_merged":0,
                          "idle_time_ns":2953431879,
                          "account_invalid":true,
                          "account_failed":false
                       }
                    },
                    "stats":{
                       "wr_highest_offset":2821110784,
                       "wr_bytes":9786368,
                       "wr_operations":692,
                       "rd_bytes":122739200,
                       "rd_operations":36604
                       "flush_operations":51,
                       "wr_total_times_ns":313253456
                       "rd_total_times_ns":3465673657
                       "flush_total_times_ns":49653,
                       "rd_merged":0,
                       "wr_merged":0,
                       "idle_time_ns":2953431879,
                       "account_invalid":true,
                       "account_failed":false
                    },
                    "qdev": "/machine/unattached/device[23]"
                 },
                 {
                    "device":"ide1-cd0",
                    "stats":{
                       "wr_highest_offset":0,
                       "wr_bytes":0,
                       "wr_operations":0,
                       "rd_bytes":0,
                       "rd_operations":0
                       "flush_operations":0,
                       "wr_total_times_ns":0
                       "rd_total_times_ns":0
                       "flush_total_times_ns":0,
                       "rd_merged":0,
                       "wr_merged":0,
                       "account_invalid":false,
                       "account_failed":false
                    },
                    "qdev": "/machine/unattached/device[24]"
                 },
                 {
                    "device":"floppy0",
                    "stats":{
                       "wr_highest_offset":0,
                       "wr_bytes":0,
                       "wr_operations":0,
                       "rd_bytes":0,
                       "rd_operations":0
                       "flush_operations":0,
                       "wr_total_times_ns":0
                       "rd_total_times_ns":0
                       "flush_total_times_ns":0,
                       "rd_merged":0,
                       "wr_merged":0,
                       "account_invalid":false,
                       "account_failed":false
                    },
                    "qdev": "/machine/unattached/device[16]"
                 },
                 {
                    "device":"sd0",
                    "stats":{
                       "wr_highest_offset":0,
                       "wr_bytes":0,
                       "wr_operations":0,
                       "rd_bytes":0,
                       "rd_operations":0
                       "flush_operations":0,
                       "wr_total_times_ns":0
                       "rd_total_times_ns":0
                       "flush_total_times_ns":0,
                       "rd_merged":0,
                       "wr_merged":0,
                       "account_invalid":false,
                       "account_failed":false
                    }
                 }
              ]
           }
.Ve

**BlockdevOnError** (Enum)

An enumeration of possible behaviors for errors on I/O operations.
The exact meaning depends on whether the I/O was initiated by a guest
or by a block job

**Values:**
.ie n .IP """report""" 4
.el .IP "\f(CWreport" 4
.IX Item "report"
for guest operations, report the error to the guest;
for jobs, cancel the job
.ie n .IP """ignore""" 4
.el .IP "\f(CWignore" 4
.IX Item "ignore"
ignore the error, only report a \s-1QMP\s0 event (\s-1BLOCK_IO_ERROR\s0
or \s-1BLOCK_JOB_ERROR\s0)
.ie n .IP """enospc""" 4
.el .IP "\f(CWenospc" 4
.IX Item "enospc"
same as \f(CW`stop\*(C' on \s-1ENOSPC,\s0 same as \f(CW\*(C\`report\*(C' otherwise.
.ie n .IP """stop""" 4
.el .IP "\f(CWstop" 4
.IX Item "stop"
for guest operations, stop the virtual machine;
for jobs, pause the job
.ie n .IP """auto""" 4
.el .IP "\f(CWauto" 4
.IX Item "auto"
inherit the error handling policy of the backend (since: 2.7)

**Since:**
1.3

**MirrorSyncMode** (Enum)

An enumeration of possible behaviors for the initial synchronization
phase of storage mirroring.

**Values:**
.ie n .IP """top""" 4
.el .IP "\f(CWtop" 4
.IX Item "top"
copies data in the topmost image to the destination
.ie n .IP """full""" 4
.el .IP "\f(CWfull" 4
.IX Item "full"
copies data from all images to the destination
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
only copy data written from now on
.ie n .IP """incremental""" 4
.el .IP "\f(CWincremental" 4
.IX Item "incremental"
only copy data described by the dirty bitmap. Since: 2.4

**Since:**
1.3

**MirrorCopyMode** (Enum)

An enumeration whose values tell the mirror block job when to
trigger writes to the target.

**Values:**
.ie n .IP """background""" 4
.el .IP "\f(CWbackground" 4
.IX Item "background"
copy data in background only.
.ie n .IP """write-blocking""" 4
.el .IP "\f(CWwrite-blocking" 4
.IX Item "write-blocking"
when data is written to the source, write it
(synchronously) to the target as well.  In
addition, data is copied in background just like in
\f(CW`background\*(C' mode.

**Since:**
3.0

**BlockJobInfo** (Object)

Information about a long-running block device operation.

**Members:**
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
the job type ('stream' for image streaming)
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. Originally the device name but other
values are allowed since \s-1QEMU 2.7\s0
.ie n .IP """len: int""" 4
.el .IP "\f(CWlen: int" 4
.IX Item "len: int"
Estimated \f(CW`offset\*(C' value at the completion of the job. This value can
arbitrarily change while the job is running, in both directions.
.ie n .IP """offset: int""" 4
.el .IP "\f(CWoffset: int" 4
.IX Item "offset: int"
Progress made until now. The unit is arbitrary and the value can
only meaningfully be used for the ratio of \f(CW`offset\*(C' to \f(CW\*(C\`len\*(C'. The
value is monotonically increasing.
.ie n .IP """busy: boolean""" 4
.el .IP "\f(CWbusy: boolean" 4
.IX Item "busy: boolean"
false if the job is known to be in a quiescent state, with
no pending I/O.  Since 1.3.
.ie n .IP """paused: boolean""" 4
.el .IP "\f(CWpaused: boolean" 4
.IX Item "paused: boolean"
whether the job is paused or, if \f(CW`busy\*(C' is true, will
pause itself as soon as possible.  Since 1.3.
.ie n .IP """speed: int""" 4
.el .IP "\f(CWspeed: int" 4
.IX Item "speed: int"
the rate limit, bytes per second
.ie n .IP """io-status: BlockDeviceIoStatus""" 4
.el .IP "\f(CWio-status: BlockDeviceIoStatus" 4
.IX Item "io-status: BlockDeviceIoStatus"
the status of the job (since 1.3)
.ie n .IP """ready: boolean""" 4
.el .IP "\f(CWready: boolean" 4
.IX Item "ready: boolean"
true if the job may be completed (since 2.2)
.ie n .IP """status: JobStatus""" 4
.el .IP "\f(CWstatus: JobStatus" 4
.IX Item "status: JobStatus"
Current job state/status (since 2.12)
.ie n .IP """auto-finalize: boolean""" 4
.el .IP "\f(CWauto-finalize: boolean" 4
.IX Item "auto-finalize: boolean"
Job will finalize itself when \s-1PENDING,\s0 moving to
the \s-1CONCLUDED\s0 state. (since 2.12)
.ie n .IP """auto-dismiss: boolean""" 4
.el .IP "\f(CWauto-dismiss: boolean" 4
.IX Item "auto-dismiss: boolean"
Job will dismiss itself when \s-1CONCLUDED,\s0 moving to the \s-1NULL\s0
state and disappearing from the query list. (since 2.12)
.ie n .IP """error: string"" (optional)" 4
.el .IP "\f(CWerror: string (optional)" 4
.IX Item "error: string (optional)"
Error information if the job did not complete successfully.
Not set if the job completed successfully. (since 2.12.1)

**Since:**
1.1

**query-block-jobs**  (Command)
Return information about long-running block device operations.

**Returns:**
a list of \f(CW`BlockJobInfo\*(C' for each active block job

**Since:**
1.1

**block\_passwd**  (Command)
This command sets the password of a block device that has not been open
with a password and requires one.

This command is now obsolete and will always return an error since 2.10

**Arguments:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
Not documented
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
Not documented
.ie n .IP """password: string""" 4
.el .IP "\f(CWpassword: string" 4
.IX Item "password: string"
Not documented

**block\_resize**  (Command)
Resize a block image while a guest is running.

Either \f(CW`device\*(C' or \f(CW\*(C\`node-name\*(C' must be set but not both.

**Arguments:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
the name of the device to get the image resized
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
graph node name to get the image resized (Since 2.0)
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
new image size in bytes

**Returns:**
nothing on success
If \f(CW`device\*(C' is not a valid block device, DeviceNotFound

**Since:**
0.14.0

**Example:**

.Vb 3
        -&gt; { "execute": "block_resize",
             "arguments": { "device": "scratch", "size": 1073741824 } }
        &lt;- { "return": {} }
.Ve

**NewImageMode** (Enum)

An enumeration that tells \s-1QEMU\s0 how to set the backing file path in
a new image file.

**Values:**
.ie n .IP """existing""" 4
.el .IP "\f(CWexisting" 4
.IX Item "existing"
\s-1QEMU\s0 should look for an existing image file.
.ie n .IP """absolute-paths""" 4
.el .IP "\f(CWabsolute-paths" 4
.IX Item "absolute-paths"
\s-1QEMU\s0 should create a new image with absolute paths
for the backing file. If there is no backing file available, the new
image will not be backed either.

**Since:**
1.1

**BlockdevSnapshotSync** (Object)

Either \f(CW`device\*(C' or \f(CW\*(C\`node-name\*(C' must be set but not both.

**Members:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
the name of the device to generate the snapshot from.
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
graph node name to generate the snapshot from (Since 2.0)
.ie n .IP """snapshot-file: string""" 4
.el .IP "\f(CWsnapshot-file: string" 4
.IX Item "snapshot-file: string"
the target of the new image. If the file exists, or
if it is a device, the snapshot will be created in the existing
file/device. Otherwise, a new file will be created.
.ie n .IP """snapshot-node-name: string"" (optional)" 4
.el .IP "\f(CWsnapshot-node-name: string (optional)" 4
.IX Item "snapshot-node-name: string (optional)"
the graph node name of the new image (Since 2.0)
.ie n .IP """format: string"" (optional)" 4
.el .IP "\f(CWformat: string (optional)" 4
.IX Item "format: string (optional)"
the format of the snapshot image, default is 'qcow2'.
.ie n .IP """mode: NewImageMode"" (optional)" 4
.el .IP "\f(CWmode: NewImageMode (optional)" 4
.IX Item "mode: NewImageMode (optional)"
whether and how \s-1QEMU\s0 should create a new image, default is
'absolute-paths'.

**BlockdevSnapshot** (Object)

**Members:**
.ie n .IP """node: string""" 4
.el .IP "\f(CWnode: string" 4
.IX Item "node: string"
device or node name that will have a snapshot created.
.ie n .IP """overlay: string""" 4
.el .IP "\f(CWoverlay: string" 4
.IX Item "overlay: string"
reference to the existing block device that will become
the overlay of \f(CW`node\*(C', as part of creating the snapshot.
It must not have a current backing file (this can be
achieved by passing backing\*(R": null to blockdev-add).

**Since:**
2.5

**DriveBackup** (Object)

**Members:**
.ie n .IP """job-id: string"" (optional)" 4
.el .IP "\f(CWjob-id: string (optional)" 4
.IX Item "job-id: string (optional)"
identifier for the newly-created block job. If
omitted, the device name will be used. (Since 2.7)
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the device name or node-name of a root node which should be copied.
.ie n .IP """target: string""" 4
.el .IP "\f(CWtarget: string" 4
.IX Item "target: string"
the target of the new image. If the file exists, or if it
is a device, the existing file/device will be used as the new
destination.  If it does not exist, a new file will be created.
.ie n .IP """format: string"" (optional)" 4
.el .IP "\f(CWformat: string (optional)" 4
.IX Item "format: string (optional)"
the format of the new destination, default is to
probe if \f(CW`mode\*(C' is 'existing', else the format of the source
.ie n .IP """sync: MirrorSyncMode""" 4
.el .IP "\f(CWsync: MirrorSyncMode" 4
.IX Item "sync: MirrorSyncMode"
what parts of the disk image should be copied to the destination
(all the disk, only the sectors allocated in the topmost image, from a
dirty bitmap, or only new I/O).
.ie n .IP """mode: NewImageMode"" (optional)" 4
.el .IP "\f(CWmode: NewImageMode (optional)" 4
.IX Item "mode: NewImageMode (optional)"
whether and how \s-1QEMU\s0 should create a new image, default is
'absolute-paths'.
.ie n .IP """speed: int"" (optional)" 4
.el .IP "\f(CWspeed: int (optional)" 4
.IX Item "speed: int (optional)"
the maximum speed, in bytes per second
.ie n .IP """bitmap: string"" (optional)" 4
.el .IP "\f(CWbitmap: string (optional)" 4
.IX Item "bitmap: string (optional)"
the name of dirty bitmap if sync is incremental\*(R".
Must be present if sync is incremental\*(R", must \s-1NOT\s0 be present
otherwise. (Since 2.4)
.ie n .IP """compress: boolean"" (optional)" 4
.el .IP "\f(CWcompress: boolean (optional)" 4
.IX Item "compress: boolean (optional)"
true to compress data, if the target format supports it.
(default: false) (since 2.8)
.ie n .IP """on-source-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-source-error: BlockdevOnError (optional)" 4
.IX Item "on-source-error: BlockdevOnError (optional)"
the action to take on an error on the source,
default 'report'.  'stop' and 'enospc' can only be used
if the block device supports io-status (see BlockInfo).
.ie n .IP """on-target-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-target-error: BlockdevOnError (optional)" 4
.IX Item "on-target-error: BlockdevOnError (optional)"
the action to take on an error on the target,
default 'report' (no limitations, since this applies to
a different block device than \f(CW`device\*(C').
.ie n .IP """auto-finalize: boolean"" (optional)" 4
.el .IP "\f(CWauto-finalize: boolean (optional)" 4
.IX Item "auto-finalize: boolean (optional)"
When false, this job will wait in a \s-1PENDING\s0 state after it has
finished its work, waiting for \f(CW`block-job-finalize\*(C' before
making any block graph changes.
When true, this job will automatically
perform its abort or commit actions.
Defaults to true. (Since 2.12)
.ie n .IP """auto-dismiss: boolean"" (optional)" 4
.el .IP "\f(CWauto-dismiss: boolean (optional)" 4
.IX Item "auto-dismiss: boolean (optional)"
When false, this job will wait in a \s-1CONCLUDED\s0 state after it
has completely ceased all work, and awaits \f(CW`block-job-dismiss\*(C'.
When true, this job will automatically disappear from the query
list without user intervention.
Defaults to true. (Since 2.12)

**Note:**
\f(CW`on-source-error\*(C' and \f(CW\*(C\`on-target-error\*(C' only affect background
I/O.  If an error occurs during a guest write request, the device's
rerror/werror actions will be used.

**Since:**
1.6

**BlockdevBackup** (Object)

**Members:**
.ie n .IP """job-id: string"" (optional)" 4
.el .IP "\f(CWjob-id: string (optional)" 4
.IX Item "job-id: string (optional)"
identifier for the newly-created block job. If
omitted, the device name will be used. (Since 2.7)
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the device name or node-name of a root node which should be copied.
.ie n .IP """target: string""" 4
.el .IP "\f(CWtarget: string" 4
.IX Item "target: string"
the device name or node-name of the backup target node.
.ie n .IP """sync: MirrorSyncMode""" 4
.el .IP "\f(CWsync: MirrorSyncMode" 4
.IX Item "sync: MirrorSyncMode"
what parts of the disk image should be copied to the destination
(all the disk, only the sectors allocated in the topmost image, or
only new I/O).
.ie n .IP """speed: int"" (optional)" 4
.el .IP "\f(CWspeed: int (optional)" 4
.IX Item "speed: int (optional)"
the maximum speed, in bytes per second. The default is 0,
for unlimited.
.ie n .IP """bitmap: string"" (optional)" 4
.el .IP "\f(CWbitmap: string (optional)" 4
.IX Item "bitmap: string (optional)"
the name of dirty bitmap if sync is incremental\*(R".
Must be present if sync is incremental\*(R", must \s-1NOT\s0 be present
otherwise. (Since 3.1)
.ie n .IP """compress: boolean"" (optional)" 4
.el .IP "\f(CWcompress: boolean (optional)" 4
.IX Item "compress: boolean (optional)"
true to compress data, if the target format supports it.
(default: false) (since 2.8)
.ie n .IP """on-source-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-source-error: BlockdevOnError (optional)" 4
.IX Item "on-source-error: BlockdevOnError (optional)"
the action to take on an error on the source,
default 'report'.  'stop' and 'enospc' can only be used
if the block device supports io-status (see BlockInfo).
.ie n .IP """on-target-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-target-error: BlockdevOnError (optional)" 4
.IX Item "on-target-error: BlockdevOnError (optional)"
the action to take on an error on the target,
default 'report' (no limitations, since this applies to
a different block device than \f(CW`device\*(C').
.ie n .IP """auto-finalize: boolean"" (optional)" 4
.el .IP "\f(CWauto-finalize: boolean (optional)" 4
.IX Item "auto-finalize: boolean (optional)"
When false, this job will wait in a \s-1PENDING\s0 state after it has
finished its work, waiting for \f(CW`block-job-finalize\*(C' before
making any block graph changes.
When true, this job will automatically
perform its abort or commit actions.
Defaults to true. (Since 2.12)
.ie n .IP """auto-dismiss: boolean"" (optional)" 4
.el .IP "\f(CWauto-dismiss: boolean (optional)" 4
.IX Item "auto-dismiss: boolean (optional)"
When false, this job will wait in a \s-1CONCLUDED\s0 state after it
has completely ceased all work, and awaits \f(CW`block-job-dismiss\*(C'.
When true, this job will automatically disappear from the query
list without user intervention.
Defaults to true. (Since 2.12)

**Note:**
\f(CW`on-source-error\*(C' and \f(CW\*(C\`on-target-error\*(C' only affect background
I/O.  If an error occurs during a guest write request, the device's
rerror/werror actions will be used.

**Since:**
2.3

**blockdev-snapshot-sync**  (Command)
Generates a synchronous snapshot of a block device.

For the arguments, see the documentation of BlockdevSnapshotSync.

**Returns:**
nothing on success
If \f(CW`device\*(C' is not a valid block device, DeviceNotFound

**Since:**
0.14.0

**Example:**

.Vb 6
        -&gt; { "execute": "blockdev-snapshot-sync",
             "arguments": { "device": "ide-hd0",
                            "snapshot-file":
                            "/some/place/my-image",
                            "format": "qcow2" } }
        &lt;- { "return": {} }
.Ve

**blockdev-snapshot**  (Command)
Generates a snapshot of a block device.

Create a snapshot, by installing 'node' as the backing image of
'overlay'. Additionally, if 'node' is associated with a block
device, the block device changes to using 'overlay' as its new active
image.

For the arguments, see the documentation of BlockdevSnapshot.

**Since:**
2.5

**Example:**

.Vb 6
        -&gt; { "execute": "blockdev-add",
             "arguments": { "driver": "qcow2",
                            "node-name": "node1534",
                            "file": { "driver": "file",
                                      "filename": "hd1.qcow2" },
                            "backing": null } }
        
        &lt;- { "return": {} }
        
        -&gt; { "execute": "blockdev-snapshot",
             "arguments": { "node": "ide-hd0",
                            "overlay": "node1534" } }
        &lt;- { "return": {} }
.Ve

**change-backing-file**  (Command)
Change the backing file in the image file metadata.  This does not
cause \s-1QEMU\s0 to reopen the image file to reparse the backing filename
(it may, however, perform a reopen to change permissions from
r/o -&gt; r/w -&gt; r/o, if needed). The new backing file string is written
into the image file metadata, and the \s-1QEMU\s0 internal strings are
updated.

**Arguments:**
.ie n .IP """image-node-name: string""" 4
.el .IP "\f(CWimage-node-name: string" 4
.IX Item "image-node-name: string"
The name of the block driver state node of the
image to modify. The device\*(R" argument is used
to verify image-node-name\*(R" is in the chain
described by device\*(R".
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The device name or node-name of the root node that owns
image-node-name.
.ie n .IP """backing-file: string""" 4
.el .IP "\f(CWbacking-file: string" 4
.IX Item "backing-file: string"
The string to write as the backing file.  This
string is not validated, so care should be taken
when specifying the string or the image chain may
not be able to be reopened again.

**Returns:**
Nothing on success

If device\*(R" does not exist or cannot be determined, DeviceNotFound

**Since:**
2.1

**block-commit**  (Command)
Live commit of data from overlay image nodes into backing nodes - i.e.,
writes data between 'top' and 'base' into 'base'.

**Arguments:**
.ie n .IP """job-id: string"" (optional)" 4
.el .IP "\f(CWjob-id: string (optional)" 4
.IX Item "job-id: string (optional)"
identifier for the newly-created block job. If
omitted, the device name will be used. (Since 2.7)
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the device name or node-name of a root node
.ie n .IP """base-node: string"" (optional)" 4
.el .IP "\f(CWbase-node: string (optional)" 4
.IX Item "base-node: string (optional)"
The node name of the backing image to write data into.
If not specified, this is the deepest backing image.
(since: 3.1)
.ie n .IP """base: string"" (optional)" 4
.el .IP "\f(CWbase: string (optional)" 4
.IX Item "base: string (optional)"
Same as \f(CW`base-node\*(C', except that it is a file name rather than a node
name. This must be the exact filename string that was used to open the
node; other strings, even if addressing the same file, are not
accepted (deprecated, use \f(CW`base-node\*(C' instead)
.ie n .IP """top-node: string"" (optional)" 4
.el .IP "\f(CWtop-node: string (optional)" 4
.IX Item "top-node: string (optional)"
The node name of the backing image within the image chain
which contains the topmost data to be committed down. If
not specified, this is the active layer. (since: 3.1)
.ie n .IP """top: string"" (optional)" 4
.el .IP "\f(CWtop: string (optional)" 4
.IX Item "top: string (optional)"
Same as \f(CW`top-node\*(C', except that it is a file name rather than a node
name. This must be the exact filename string that was used to open the
node; other strings, even if addressing the same file, are not
accepted (deprecated, use \f(CW`base-node\*(C' instead)
.ie n .IP """backing-file: string"" (optional)" 4
.el .IP "\f(CWbacking-file: string (optional)" 4
.IX Item "backing-file: string (optional)"
The backing file string to write into the overlay
image of 'top'.  If 'top' is the active layer,
specifying a backing file string is an error. This
filename is not validated.
.Sp
If a pathname string is such that it cannot be
resolved by \s-1QEMU,\s0 that means that subsequent \s-1QMP\s0 or
\s-1HMP\s0 commands must use node-names for the image in
question, as filename lookup methods will fail.
.Sp
If not specified, \s-1QEMU\s0 will automatically determine
the backing file string to use, or error out if
there is no obvious choice. Care should be taken
when specifying the string, to specify a valid
filename or protocol.
(Since 2.1)
.Sp
If top == base, that is an error.
If top == active, the job will not be completed by itself,
user needs to complete the job with the block-job-complete
command after getting the ready event. (Since 2.0)
.Sp
If the base image is smaller than top, then the base image
will be resized to be the same size as top.  If top is
smaller than the base image, the base will not be
truncated.  If you want the base image size to match the
size of the smaller top, you can safely truncate it
yourself once the commit operation successfully completes.
.ie n .IP """speed: int"" (optional)" 4
.el .IP "\f(CWspeed: int (optional)" 4
.IX Item "speed: int (optional)"
the maximum speed, in bytes per second
.ie n .IP """filter-node-name: string"" (optional)" 4
.el .IP "\f(CWfilter-node-name: string (optional)" 4
.IX Item "filter-node-name: string (optional)"
the node name that should be assigned to the
filter driver that the commit job inserts into the graph
above \f(CW`top\*(C'. If this option is not given, a node name is
autogenerated. (Since: 2.9)
.ie n .IP """auto-finalize: boolean"" (optional)" 4
.el .IP "\f(CWauto-finalize: boolean (optional)" 4
.IX Item "auto-finalize: boolean (optional)"
When false, this job will wait in a \s-1PENDING\s0 state after it has
finished its work, waiting for \f(CW`block-job-finalize\*(C' before
making any block graph changes.
When true, this job will automatically
perform its abort or commit actions.
Defaults to true. (Since 3.1)
.ie n .IP """auto-dismiss: boolean"" (optional)" 4
.el .IP "\f(CWauto-dismiss: boolean (optional)" 4
.IX Item "auto-dismiss: boolean (optional)"
When false, this job will wait in a \s-1CONCLUDED\s0 state after it
has completely ceased all work, and awaits \f(CW`block-job-dismiss\*(C'.
When true, this job will automatically disappear from the query
list without user intervention.
Defaults to true. (Since 3.1)

**Returns:**
Nothing on success
If \f(CW`device\*(C' does not exist, DeviceNotFound
Any other error returns a GenericError.

**Since:**
1.3

**Example:**

.Vb 4
        -&gt; { "execute": "block-commit",
             "arguments": { "device": "virtio0",
                            "top": "/tmp/snap1.qcow2" } }
        &lt;- { "return": {} }
.Ve

**drive-backup**  (Command)
Start a point-in-time copy of a block device to a new destination.  The
status of ongoing drive-backup operations can be checked with
query-block-jobs where the BlockJobInfo.type field has the value 'backup'.
The operation can be stopped before it has completed using the
block-job-cancel command.

**Arguments:** the members of \f(CW`DriveBackup\*(C'

**Returns:**
nothing on success
If \f(CW`device\*(C' is not a valid block device, GenericError

**Since:**
1.6

**Example:**

.Vb 5
        -&gt; { "execute": "drive-backup",
             "arguments": { "device": "drive0",
                            "sync": "full",
                            "target": "backup.img" } }
        &lt;- { "return": {} }
.Ve

**blockdev-backup**  (Command)
Start a point-in-time copy of a block device to a new destination.  The
status of ongoing blockdev-backup operations can be checked with
query-block-jobs where the BlockJobInfo.type field has the value 'backup'.
The operation can be stopped before it has completed using the
block-job-cancel command.

**Arguments:** the members of \f(CW`BlockdevBackup\*(C'

**Returns:**
nothing on success
If \f(CW`device\*(C' is not a valid block device, DeviceNotFound

**Since:**
2.3

**Example:**

.Vb 5
        -&gt; { "execute": "blockdev-backup",
             "arguments": { "device": "src-id",
                            "sync": "full",
                            "target": "tgt-id" } }
        &lt;- { "return": {} }
.Ve

**query-named-block-nodes**  (Command)
Get the named block driver list

**Returns:**
the list of BlockDeviceInfo

**Since:**
2.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-named-block-nodes" }
        &lt;- { "return": [ { "ro":false,
                           "drv":"qcow2",
                           "encrypted":false,
                           "file":"disks/test.qcow2",
                           "node-name": "my-node",
                           "backing_file_depth":1,
                           "bps":1000000,
                           "bps_rd":0,
                           "bps_wr":0,
                           "iops":1000000,
                           "iops_rd":0,
                           "iops_wr":0,
                           "bps_max": 8000000,
                           "bps_rd_max": 0,
                           "bps_wr_max": 0,
                           "iops_max": 0,
                           "iops_rd_max": 0,
                           "iops_wr_max": 0,
                           "iops_size": 0,
                           "write_threshold": 0,
                           "image":{
                              "filename":"disks/test.qcow2",
                              "format":"qcow2",
                              "virtual-size":2048000,
                              "backing_file":"base.qcow2",
                              "full-backing-filename":"disks/base.qcow2",
                              "backing-filename-format":"qcow2",
                              "snapshots":[
                                 {
                                    "id": "1",
                                    "name": "snapshot1",
                                    "vm-state-size": 0,
                                    "date-sec": 10000200,
                                    "date-nsec": 12,
                                    "vm-clock-sec": 206,
                                    "vm-clock-nsec": 30
                                 }
                              ],
                              "backing-image":{
                                  "filename":"disks/base.qcow2",
                                  "format":"qcow2",
                                  "virtual-size":2048000
                              }
                           } } ] }
.Ve

**drive-mirror**  (Command)
Start mirroring a block device's writes to a new destination. target
specifies the target of the new image. If the file exists, or if it
is a device, it will be used as the new destination for writes. If
it does not exist, a new file will be created. format specifies the
format of the mirror image, default is to probe if mode='existing',
else the format of the source.

**Arguments:** the members of \f(CW`DriveMirror\*(C'

**Returns:**
nothing on success
If \f(CW`device\*(C' is not a valid block device, GenericError

**Since:**
1.3

**Example:**

.Vb 6
        -&gt; { "execute": "drive-mirror",
             "arguments": { "device": "ide-hd0",
                            "target": "/some/place/my-image",
                            "sync": "full",
                            "format": "qcow2" } }
        &lt;- { "return": {} }
.Ve

**DriveMirror** (Object)

A set of parameters describing drive mirror setup.

**Members:**
.ie n .IP """job-id: string"" (optional)" 4
.el .IP "\f(CWjob-id: string (optional)" 4
.IX Item "job-id: string (optional)"
identifier for the newly-created block job. If
omitted, the device name will be used. (Since 2.7)
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the device name or node-name of a root node whose writes should be
mirrored.
.ie n .IP """target: string""" 4
.el .IP "\f(CWtarget: string" 4
.IX Item "target: string"
the target of the new image. If the file exists, or if it
is a device, the existing file/device will be used as the new
destination.  If it does not exist, a new file will be created.
.ie n .IP """format: string"" (optional)" 4
.el .IP "\f(CWformat: string (optional)" 4
.IX Item "format: string (optional)"
the format of the new destination, default is to
probe if \f(CW`mode\*(C' is 'existing', else the format of the source
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
the new block driver state node name in the graph
(Since 2.1)
.ie n .IP """replaces: string"" (optional)" 4
.el .IP "\f(CWreplaces: string (optional)" 4
.IX Item "replaces: string (optional)"
with sync=full graph node name to be replaced by the new
image when a whole image copy is done. This can be used to repair
broken Quorum files. (Since 2.1)
.ie n .IP """mode: NewImageMode"" (optional)" 4
.el .IP "\f(CWmode: NewImageMode (optional)" 4
.IX Item "mode: NewImageMode (optional)"
whether and how \s-1QEMU\s0 should create a new image, default is
'absolute-paths'.
.ie n .IP """speed: int"" (optional)" 4
.el .IP "\f(CWspeed: int (optional)" 4
.IX Item "speed: int (optional)"
the maximum speed, in bytes per second
.ie n .IP """sync: MirrorSyncMode""" 4
.el .IP "\f(CWsync: MirrorSyncMode" 4
.IX Item "sync: MirrorSyncMode"
what parts of the disk image should be copied to the destination
(all the disk, only the sectors allocated in the topmost image, or
only new I/O).
.ie n .IP """granularity: int"" (optional)" 4
.el .IP "\f(CWgranularity: int (optional)" 4
.IX Item "granularity: int (optional)"
granularity of the dirty bitmap, default is 64K
if the image format doesn't have clusters, 4K if the clusters
are smaller than that, else the cluster size.  Must be a
power of 2 between 512 and 64M (since 1.4).
.ie n .IP """buf-size: int"" (optional)" 4
.el .IP "\f(CWbuf-size: int (optional)" 4
.IX Item "buf-size: int (optional)"
maximum amount of data in flight from source to
target (since 1.4).
.ie n .IP """on-source-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-source-error: BlockdevOnError (optional)" 4
.IX Item "on-source-error: BlockdevOnError (optional)"
the action to take on an error on the source,
default 'report'.  'stop' and 'enospc' can only be used
if the block device supports io-status (see BlockInfo).
.ie n .IP """on-target-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-target-error: BlockdevOnError (optional)" 4
.IX Item "on-target-error: BlockdevOnError (optional)"
the action to take on an error on the target,
default 'report' (no limitations, since this applies to
a different block device than \f(CW`device\*(C').
.ie n .IP """unmap: boolean"" (optional)" 4
.el .IP "\f(CWunmap: boolean (optional)" 4
.IX Item "unmap: boolean (optional)"
Whether to try to unmap target sectors where source has
only zero. If true, and target unallocated sectors will read as zero,
target image sectors will be unmapped; otherwise, zeroes will be
written. Both will result in identical contents.
Default is true. (Since 2.4)
.ie n .IP """copy-mode: MirrorCopyMode"" (optional)" 4
.el .IP "\f(CWcopy-mode: MirrorCopyMode (optional)" 4
.IX Item "copy-mode: MirrorCopyMode (optional)"
when to copy data to the destination; defaults to 'background'
(Since: 3.0)
.ie n .IP """auto-finalize: boolean"" (optional)" 4
.el .IP "\f(CWauto-finalize: boolean (optional)" 4
.IX Item "auto-finalize: boolean (optional)"
When false, this job will wait in a \s-1PENDING\s0 state after it has
finished its work, waiting for \f(CW`block-job-finalize\*(C' before
making any block graph changes.
When true, this job will automatically
perform its abort or commit actions.
Defaults to true. (Since 3.1)
.ie n .IP """auto-dismiss: boolean"" (optional)" 4
.el .IP "\f(CWauto-dismiss: boolean (optional)" 4
.IX Item "auto-dismiss: boolean (optional)"
When false, this job will wait in a \s-1CONCLUDED\s0 state after it
has completely ceased all work, and awaits \f(CW`block-job-dismiss\*(C'.
When true, this job will automatically disappear from the query
list without user intervention.
Defaults to true. (Since 3.1)

**Since:**
1.3

**BlockDirtyBitmap** (Object)

**Members:**
.ie n .IP """node: string""" 4
.el .IP "\f(CWnode: string" 4
.IX Item "node: string"
name of device/node which the bitmap is tracking
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
name of the dirty bitmap

**Since:**
2.4

**BlockDirtyBitmapAdd** (Object)

**Members:**
.ie n .IP """node: string""" 4
.el .IP "\f(CWnode: string" 4
.IX Item "node: string"
name of device/node which the bitmap is tracking
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
name of the dirty bitmap
.ie n .IP """granularity: int"" (optional)" 4
.el .IP "\f(CWgranularity: int (optional)" 4
.IX Item "granularity: int (optional)"
the bitmap granularity, default is 64k for
block-dirty-bitmap-add
.ie n .IP """persistent: boolean"" (optional)" 4
.el .IP "\f(CWpersistent: boolean (optional)" 4
.IX Item "persistent: boolean (optional)"
the bitmap is persistent, i.e. it will be saved to the
corresponding block device image file on its close. For now only
Qcow2 disks support persistent bitmaps. Default is false for
block-dirty-bitmap-add. (Since: 2.10)
.ie n .IP """autoload: boolean"" (optional)" 4
.el .IP "\f(CWautoload: boolean (optional)" 4
.IX Item "autoload: boolean (optional)"
ignored and deprecated since 2.12.
Currently, all dirty tracking bitmaps are loaded from Qcow2 on
open.
.ie n .IP """x-disabled: boolean"" (optional)" 4
.el .IP "\f(CWx-disabled: boolean (optional)" 4
.IX Item "x-disabled: boolean (optional)"
the bitmap is created in the disabled state, which means that
it will not track drive changes. The bitmap may be enabled with
x-block-dirty-bitmap-enable. Default is false. (Since: 3.0)

**Since:**
2.4

**BlockDirtyBitmapMerge** (Object)

**Members:**
.ie n .IP """node: string""" 4
.el .IP "\f(CWnode: string" 4
.IX Item "node: string"
name of device/node which the bitmap is tracking
.ie n .IP """dst_name: string""" 4
.el .IP "\f(CWdst_name: string" 4
.IX Item "dst_name: string"
name of the destination dirty bitmap
.ie n .IP """src_name: string""" 4
.el .IP "\f(CWsrc_name: string" 4
.IX Item "src_name: string"
name of the source dirty bitmap

**Since:**
3.0

**block-dirty-bitmap-add**  (Command)
Create a dirty bitmap with a name on the node, and start tracking the writes.

**Returns:**
nothing on success
If \f(CW`node\*(C' is not a valid block device or node, DeviceNotFound
If \f(CW`name\*(C' is already taken, GenericError with an explanation

**Since:**
2.4

**Example:**

.Vb 3
        -&gt; { "execute": "block-dirty-bitmap-add",
             "arguments": { "node": "drive0", "name": "bitmap0" } }
        &lt;- { "return": {} }
.Ve

**block-dirty-bitmap-remove**  (Command)
Stop write tracking and remove the dirty bitmap that was created
with block-dirty-bitmap-add. If the bitmap is persistent, remove it from its
storage too.

**Returns:**
nothing on success
If \f(CW`node\*(C' is not a valid block device or node, DeviceNotFound
If \f(CW`name\*(C' is not found, GenericError with an explanation
if \f(CW`name\*(C' is frozen by an operation, GenericError

**Since:**
2.4

**Example:**

.Vb 3
        -&gt; { "execute": "block-dirty-bitmap-remove",
             "arguments": { "node": "drive0", "name": "bitmap0" } }
        &lt;- { "return": {} }
.Ve

**block-dirty-bitmap-clear**  (Command)
Clear (reset) a dirty bitmap on the device, so that an incremental
backup from this point in time forward will only backup clusters
modified after this clear operation.

**Returns:**
nothing on success
If \f(CW`node\*(C' is not a valid block device, DeviceNotFound
If \f(CW`name\*(C' is not found, GenericError with an explanation

**Since:**
2.4

**Example:**

.Vb 3
        -&gt; { "execute": "block-dirty-bitmap-clear",
             "arguments": { "node": "drive0", "name": "bitmap0" } }
        &lt;- { "return": {} }
.Ve

**x-block-dirty-bitmap-enable**  (Command)
Enables a dirty bitmap so that it will begin tracking disk changes.

**Returns:**
nothing on success
If \f(CW`node\*(C' is not a valid block device, DeviceNotFound
If \f(CW`name\*(C' is not found, GenericError with an explanation

**Since:**
3.0

**Example:**

.Vb 3
        -&gt; { "execute": "x-block-dirty-bitmap-enable",
             "arguments": { "node": "drive0", "name": "bitmap0" } }
        &lt;- { "return": {} }
.Ve

**x-block-dirty-bitmap-disable**  (Command)
Disables a dirty bitmap so that it will stop tracking disk changes.

**Returns:**
nothing on success
If \f(CW`node\*(C' is not a valid block device, DeviceNotFound
If \f(CW`name\*(C' is not found, GenericError with an explanation

**Since:**
3.0

**Example:**

.Vb 3
        -&gt; { "execute": "x-block-dirty-bitmap-disable",
             "arguments": { "node": "drive0", "name": "bitmap0" } }
        &lt;- { "return": {} }
.Ve

**x-block-dirty-bitmap-merge**  (Command)
\s-1FIXME:\s0 Rename \f(CW`src\_name\*(C' and \f(CW\*(C\`dst\_name\*(C' to src-name and dst-name.

Merge \f(CW`src\_name\*(C' dirty bitmap to \f(CW\*(C\`dst\_name\*(C' dirty bitmap. \f(CW\*(C\`src\_name\*(C' dirty
bitmap is unchanged. On error, \f(CW`dst\_name\*(C' is unchanged.

**Returns:**
nothing on success
If \f(CW`node\*(C' is not a valid block device, DeviceNotFound
If \f(CW`dst\_name\*(C' or \f(CW\*(C\`src\_name\*(C' is not found, GenericError
If bitmaps has different sizes or granularities, GenericError

**Since:**
3.0

**Example:**

.Vb 4
        -&gt; { "execute": "x-block-dirty-bitmap-merge",
             "arguments": { "node": "drive0", "dst_name": "bitmap0",
                            "src_name": "bitmap1" } }
        &lt;- { "return": {} }
.Ve

**BlockDirtyBitmapSha256** (Object)

\s-1SHA256\s0 hash of dirty bitmap data

**Members:**
.ie n .IP """sha256: string""" 4
.el .IP "\f(CWsha256: string" 4
.IX Item "sha256: string"
\s-1ASCII\s0 representation of \s-1SHA256\s0 bitmap hash

**Since:**
2.10

**x-debug-block-dirty-bitmap-sha256**  (Command)
Get bitmap \s-1SHA256\s0

**Returns:**
BlockDirtyBitmapSha256 on success
If \f(CW`node\*(C' is not a valid block device, DeviceNotFound
If \f(CW`name\*(C' is not found or if hashing has failed, GenericError with an
explanation

**Since:**
2.10

**blockdev-mirror**  (Command)
Start mirroring a block device's writes to a new destination.

**Arguments:**
.ie n .IP """job-id: string"" (optional)" 4
.el .IP "\f(CWjob-id: string (optional)" 4
.IX Item "job-id: string (optional)"
identifier for the newly-created block job. If
omitted, the device name will be used. (Since 2.7)
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The device name or node-name of a root node whose writes should be
mirrored.
.ie n .IP """target: string""" 4
.el .IP "\f(CWtarget: string" 4
.IX Item "target: string"
the id or node-name of the block device to mirror to. This mustn't be
attached to guest.
.ie n .IP """replaces: string"" (optional)" 4
.el .IP "\f(CWreplaces: string (optional)" 4
.IX Item "replaces: string (optional)"
with sync=full graph node name to be replaced by the new
image when a whole image copy is done. This can be used to repair
broken Quorum files.
.ie n .IP """speed: int"" (optional)" 4
.el .IP "\f(CWspeed: int (optional)" 4
.IX Item "speed: int (optional)"
the maximum speed, in bytes per second
.ie n .IP """sync: MirrorSyncMode""" 4
.el .IP "\f(CWsync: MirrorSyncMode" 4
.IX Item "sync: MirrorSyncMode"
what parts of the disk image should be copied to the destination
(all the disk, only the sectors allocated in the topmost image, or
only new I/O).
.ie n .IP """granularity: int"" (optional)" 4
.el .IP "\f(CWgranularity: int (optional)" 4
.IX Item "granularity: int (optional)"
granularity of the dirty bitmap, default is 64K
if the image format doesn't have clusters, 4K if the clusters
are smaller than that, else the cluster size.  Must be a
power of 2 between 512 and 64M
.ie n .IP """buf-size: int"" (optional)" 4
.el .IP "\f(CWbuf-size: int (optional)" 4
.IX Item "buf-size: int (optional)"
maximum amount of data in flight from source to
target
.ie n .IP """on-source-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-source-error: BlockdevOnError (optional)" 4
.IX Item "on-source-error: BlockdevOnError (optional)"
the action to take on an error on the source,
default 'report'.  'stop' and 'enospc' can only be used
if the block device supports io-status (see BlockInfo).
.ie n .IP """on-target-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-target-error: BlockdevOnError (optional)" 4
.IX Item "on-target-error: BlockdevOnError (optional)"
the action to take on an error on the target,
default 'report' (no limitations, since this applies to
a different block device than \f(CW`device\*(C').
.ie n .IP """filter-node-name: string"" (optional)" 4
.el .IP "\f(CWfilter-node-name: string (optional)" 4
.IX Item "filter-node-name: string (optional)"
the node name that should be assigned to the
filter driver that the mirror job inserts into the graph
above \f(CW`device\*(C'. If this option is not given, a node name is
autogenerated. (Since: 2.9)
.ie n .IP """copy-mode: MirrorCopyMode"" (optional)" 4
.el .IP "\f(CWcopy-mode: MirrorCopyMode (optional)" 4
.IX Item "copy-mode: MirrorCopyMode (optional)"
when to copy data to the destination; defaults to 'background'
(Since: 3.0)
.ie n .IP """auto-finalize: boolean"" (optional)" 4
.el .IP "\f(CWauto-finalize: boolean (optional)" 4
.IX Item "auto-finalize: boolean (optional)"
When false, this job will wait in a \s-1PENDING\s0 state after it has
finished its work, waiting for \f(CW`block-job-finalize\*(C' before
making any block graph changes.
When true, this job will automatically
perform its abort or commit actions.
Defaults to true. (Since 3.1)
.ie n .IP """auto-dismiss: boolean"" (optional)" 4
.el .IP "\f(CWauto-dismiss: boolean (optional)" 4
.IX Item "auto-dismiss: boolean (optional)"
When false, this job will wait in a \s-1CONCLUDED\s0 state after it
has completely ceased all work, and awaits \f(CW`block-job-dismiss\*(C'.
When true, this job will automatically disappear from the query
list without user intervention.
Defaults to true. (Since 3.1)

**Returns:**
nothing on success.

**Since:**
2.6

**Example:**

.Vb 5
        -&gt; { "execute": "blockdev-mirror",
             "arguments": { "device": "ide-hd0",
                            "target": "target0",
                            "sync": "full" } }
        &lt;- { "return": {} }
.Ve

**block\_set\_io\_throttle**  (Command)
Change I/O throttle limits for a block drive.

Since \s-1QEMU 2.4,\s0 each device with I/O limits is member of a throttle
group.

If two or more devices are members of the same group, the limits
will apply to the combined I/O of the whole group in a round-robin
fashion. Therefore, setting new I/O limits to a device will affect
the whole group.

The name of the group can be specified using the 'group' parameter.
If the parameter is unset, it is assumed to be the current group of
that device. If it's not in any group yet, the name of the device
will be used as the name for its group.

The 'group' parameter can also be used to move a device to a
different group. In this case the limits specified in the parameters
will be applied to the new group only.

I/O limits can be disabled by setting all of them to 0. In this case
the device will be removed from its group and the rest of its
members will not be affected. The 'group' parameter is ignored.

**Arguments:** the members of \f(CW`BlockIOThrottle\*(C'

**Returns:**
Nothing on success
If \f(CW`device\*(C' is not a valid block device, DeviceNotFound

**Since:**
1.1

**Example:**

.Vb 10
        -&gt; { "execute": "block_set_io_throttle",
             "arguments": { "id": "virtio-blk-pci0/virtio-backend",
                            "bps": 0,
                            "bps_rd": 0,
                            "bps_wr": 0,
                            "iops": 512,
                            "iops_rd": 0,
                            "iops_wr": 0,
                            "bps_max": 0,
                            "bps_rd_max": 0,
                            "bps_wr_max": 0,
                            "iops_max": 0,
                            "iops_rd_max": 0,
                            "iops_wr_max": 0,
                            "bps_max_length": 0,
                            "iops_size": 0 } }
        &lt;- { "return": {} }
        
        -&gt; { "execute": "block_set_io_throttle",
             "arguments": { "id": "ide0-1-0",
                            "bps": 1000000,
                            "bps_rd": 0,
                            "bps_wr": 0,
                            "iops": 0,
                            "iops_rd": 0,
                            "iops_wr": 0,
                            "bps_max": 8000000,
                            "bps_rd_max": 0,
                            "bps_wr_max": 0,
                            "iops_max": 0,
                            "iops_rd_max": 0,
                            "iops_wr_max": 0,
                            "bps_max_length": 60,
                            "iops_size": 0 } }
        &lt;- { "return": {} }
.Ve

**BlockIOThrottle** (Object)

A set of parameters describing block throttling.

**Members:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
Block device name (deprecated, use \f(CW`id\*(C' instead)
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
The name or \s-1QOM\s0 path of the guest device (since: 2.8)
.ie n .IP """bps: int""" 4
.el .IP "\f(CWbps: int" 4
.IX Item "bps: int"
total throughput limit in bytes per second
.ie n .IP """bps_rd: int""" 4
.el .IP "\f(CWbps_rd: int" 4
.IX Item "bps_rd: int"
read throughput limit in bytes per second
.ie n .IP """bps_wr: int""" 4
.el .IP "\f(CWbps_wr: int" 4
.IX Item "bps_wr: int"
write throughput limit in bytes per second
.ie n .IP """iops: int""" 4
.el .IP "\f(CWiops: int" 4
.IX Item "iops: int"
total I/O operations per second
.ie n .IP """iops_rd: int""" 4
.el .IP "\f(CWiops_rd: int" 4
.IX Item "iops_rd: int"
read I/O operations per second
.ie n .IP """iops_wr: int""" 4
.el .IP "\f(CWiops_wr: int" 4
.IX Item "iops_wr: int"
write I/O operations per second
.ie n .IP """bps_max: int"" (optional)" 4
.el .IP "\f(CWbps_max: int (optional)" 4
.IX Item "bps_max: int (optional)"
total throughput limit during bursts,
in bytes (Since 1.7)
.ie n .IP """bps_rd_max: int"" (optional)" 4
.el .IP "\f(CWbps_rd_max: int (optional)" 4
.IX Item "bps_rd_max: int (optional)"
read throughput limit during bursts,
in bytes (Since 1.7)
.ie n .IP """bps_wr_max: int"" (optional)" 4
.el .IP "\f(CWbps_wr_max: int (optional)" 4
.IX Item "bps_wr_max: int (optional)"
write throughput limit during bursts,
in bytes (Since 1.7)
.ie n .IP """iops_max: int"" (optional)" 4
.el .IP "\f(CWiops_max: int (optional)" 4
.IX Item "iops_max: int (optional)"
total I/O operations per second during bursts,
in bytes (Since 1.7)
.ie n .IP """iops_rd_max: int"" (optional)" 4
.el .IP "\f(CWiops_rd_max: int (optional)" 4
.IX Item "iops_rd_max: int (optional)"
read I/O operations per second during bursts,
in bytes (Since 1.7)
.ie n .IP """iops_wr_max: int"" (optional)" 4
.el .IP "\f(CWiops_wr_max: int (optional)" 4
.IX Item "iops_wr_max: int (optional)"
write I/O operations per second during bursts,
in bytes (Since 1.7)
.ie n .IP """bps_max_length: int"" (optional)" 4
.el .IP "\f(CWbps_max_length: int (optional)" 4
.IX Item "bps_max_length: int (optional)"
maximum length of the \f(CW`bps\_max\*(C' burst
period, in seconds. It must only
be set if \f(CW`bps\_max\*(C' is set as well.
Defaults to 1. (Since 2.6)
.ie n .IP """bps_rd_max_length: int"" (optional)" 4
.el .IP "\f(CWbps_rd_max_length: int (optional)" 4
.IX Item "bps_rd_max_length: int (optional)"
maximum length of the \f(CW`bps\_rd\_max\*(C'
burst period, in seconds. It must only
be set if \f(CW`bps\_rd\_max\*(C' is set as well.
Defaults to 1. (Since 2.6)
.ie n .IP """bps_wr_max_length: int"" (optional)" 4
.el .IP "\f(CWbps_wr_max_length: int (optional)" 4
.IX Item "bps_wr_max_length: int (optional)"
maximum length of the \f(CW`bps\_wr\_max\*(C'
burst period, in seconds. It must only
be set if \f(CW`bps\_wr\_max\*(C' is set as well.
Defaults to 1. (Since 2.6)
.ie n .IP """iops_max_length: int"" (optional)" 4
.el .IP "\f(CWiops_max_length: int (optional)" 4
.IX Item "iops_max_length: int (optional)"
maximum length of the \f(CW`iops\*(C' burst
period, in seconds. It must only
be set if \f(CW`iops\_max\*(C' is set as well.
Defaults to 1. (Since 2.6)
.ie n .IP """iops_rd_max_length: int"" (optional)" 4
.el .IP "\f(CWiops_rd_max_length: int (optional)" 4
.IX Item "iops_rd_max_length: int (optional)"
maximum length of the \f(CW`iops\_rd\_max\*(C'
burst period, in seconds. It must only
be set if \f(CW`iops\_rd\_max\*(C' is set as well.
Defaults to 1. (Since 2.6)
.ie n .IP """iops_wr_max_length: int"" (optional)" 4
.el .IP "\f(CWiops_wr_max_length: int (optional)" 4
.IX Item "iops_wr_max_length: int (optional)"
maximum length of the \f(CW`iops\_wr\_max\*(C'
burst period, in seconds. It must only
be set if \f(CW`iops\_wr\_max\*(C' is set as well.
Defaults to 1. (Since 2.6)
.ie n .IP """iops_size: int"" (optional)" 4
.el .IP "\f(CWiops_size: int (optional)" 4
.IX Item "iops_size: int (optional)"
an I/O size in bytes (Since 1.7)
.ie n .IP """group: string"" (optional)" 4
.el .IP "\f(CWgroup: string (optional)" 4
.IX Item "group: string (optional)"
throttle group name (Since 2.4)

**Since:**
1.1

**ThrottleLimits** (Object)

Limit parameters for throttling.
Since some limit combinations are illegal, limits should always be set in one
transaction. All fields are optional. When setting limits, if a field is
missing the current value is not changed.

**Members:**
.ie n .IP """iops-total: int"" (optional)" 4
.el .IP "\f(CWiops-total: int (optional)" 4
.IX Item "iops-total: int (optional)"
limit total I/O operations per second
.ie n .IP """iops-total-max: int"" (optional)" 4
.el .IP "\f(CWiops-total-max: int (optional)" 4
.IX Item "iops-total-max: int (optional)"
I/O operations burst
.ie n .IP """iops-total-max-length: int"" (optional)" 4
.el .IP "\f(CWiops-total-max-length: int (optional)" 4
.IX Item "iops-total-max-length: int (optional)"
length of the iops-total-max burst period, in seconds
It must only be set if \f(CW`iops-total-max\*(C' is set as well.
.ie n .IP """iops-read: int"" (optional)" 4
.el .IP "\f(CWiops-read: int (optional)" 4
.IX Item "iops-read: int (optional)"
limit read operations per second
.ie n .IP """iops-read-max: int"" (optional)" 4
.el .IP "\f(CWiops-read-max: int (optional)" 4
.IX Item "iops-read-max: int (optional)"
I/O operations read burst
.ie n .IP """iops-read-max-length: int"" (optional)" 4
.el .IP "\f(CWiops-read-max-length: int (optional)" 4
.IX Item "iops-read-max-length: int (optional)"
length of the iops-read-max burst period, in seconds
It must only be set if \f(CW`iops-read-max\*(C' is set as well.
.ie n .IP """iops-write: int"" (optional)" 4
.el .IP "\f(CWiops-write: int (optional)" 4
.IX Item "iops-write: int (optional)"
limit write operations per second
.ie n .IP """iops-write-max: int"" (optional)" 4
.el .IP "\f(CWiops-write-max: int (optional)" 4
.IX Item "iops-write-max: int (optional)"
I/O operations write burst
.ie n .IP """iops-write-max-length: int"" (optional)" 4
.el .IP "\f(CWiops-write-max-length: int (optional)" 4
.IX Item "iops-write-max-length: int (optional)"
length of the iops-write-max burst period, in seconds
It must only be set if \f(CW`iops-write-max\*(C' is set as well.
.ie n .IP """bps-total: int"" (optional)" 4
.el .IP "\f(CWbps-total: int (optional)" 4
.IX Item "bps-total: int (optional)"
limit total bytes per second
.ie n .IP """bps-total-max: int"" (optional)" 4
.el .IP "\f(CWbps-total-max: int (optional)" 4
.IX Item "bps-total-max: int (optional)"
total bytes burst
.ie n .IP """bps-total-max-length: int"" (optional)" 4
.el .IP "\f(CWbps-total-max-length: int (optional)" 4
.IX Item "bps-total-max-length: int (optional)"
length of the bps-total-max burst period, in seconds.
It must only be set if \f(CW`bps-total-max\*(C' is set as well.
.ie n .IP """bps-read: int"" (optional)" 4
.el .IP "\f(CWbps-read: int (optional)" 4
.IX Item "bps-read: int (optional)"
limit read bytes per second
.ie n .IP """bps-read-max: int"" (optional)" 4
.el .IP "\f(CWbps-read-max: int (optional)" 4
.IX Item "bps-read-max: int (optional)"
total bytes read burst
.ie n .IP """bps-read-max-length: int"" (optional)" 4
.el .IP "\f(CWbps-read-max-length: int (optional)" 4
.IX Item "bps-read-max-length: int (optional)"
length of the bps-read-max burst period, in seconds
It must only be set if \f(CW`bps-read-max\*(C' is set as well.
.ie n .IP """bps-write: int"" (optional)" 4
.el .IP "\f(CWbps-write: int (optional)" 4
.IX Item "bps-write: int (optional)"
limit write bytes per second
.ie n .IP """bps-write-max: int"" (optional)" 4
.el .IP "\f(CWbps-write-max: int (optional)" 4
.IX Item "bps-write-max: int (optional)"
total bytes write burst
.ie n .IP """bps-write-max-length: int"" (optional)" 4
.el .IP "\f(CWbps-write-max-length: int (optional)" 4
.IX Item "bps-write-max-length: int (optional)"
length of the bps-write-max burst period, in seconds
It must only be set if \f(CW`bps-write-max\*(C' is set as well.
.ie n .IP """iops-size: int"" (optional)" 4
.el .IP "\f(CWiops-size: int (optional)" 4
.IX Item "iops-size: int (optional)"
when limiting by iops max size of an I/O in bytes

**Since:**
2.11

**block-stream**  (Command)
Copy data from a backing file into a block device.

The block streaming operation is performed in the background until the entire
backing file has been copied.  This command returns immediately once streaming
has started.  The status of ongoing block streaming operations can be checked
with query-block-jobs.  The operation can be stopped before it has completed
using the block-job-cancel command.

The node that receives the data is called the top image, can be located in
any part of the chain (but always above the base image; see below) and can be
specified using its device or node name. Earlier qemu versions only allowed
'device' to name the top level node; presence of the 'base-node' parameter
during introspection can be used as a witness of the enhanced semantics
of 'device'.

If a base file is specified then sectors are not copied from that base file and
its backing chain.  When streaming completes the image file will have the base
file as its backing file.  This can be used to stream a subset of the backing
file chain instead of flattening the entire image.

On successful completion the image file is updated to drop the backing file
and the \s-1BLOCK_JOB_COMPLETED\s0 event is emitted.

**Arguments:**
.ie n .IP """job-id: string"" (optional)" 4
.el .IP "\f(CWjob-id: string (optional)" 4
.IX Item "job-id: string (optional)"
identifier for the newly-created block job. If
omitted, the device name will be used. (Since 2.7)
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the device or node name of the top image
.ie n .IP """base: string"" (optional)" 4
.el .IP "\f(CWbase: string (optional)" 4
.IX Item "base: string (optional)"
the common backing file name.
It cannot be set if \f(CW`base-node\*(C' is also set.
.ie n .IP """base-node: string"" (optional)" 4
.el .IP "\f(CWbase-node: string (optional)" 4
.IX Item "base-node: string (optional)"
the node name of the backing file.
It cannot be set if \f(CW`base\*(C' is also set. (Since 2.8)
.ie n .IP """backing-file: string"" (optional)" 4
.el .IP "\f(CWbacking-file: string (optional)" 4
.IX Item "backing-file: string (optional)"
The backing file string to write into the top
image. This filename is not validated.
.Sp
If a pathname string is such that it cannot be
resolved by \s-1QEMU,\s0 that means that subsequent \s-1QMP\s0 or
\s-1HMP\s0 commands must use node-names for the image in
question, as filename lookup methods will fail.
.Sp
If not specified, \s-1QEMU\s0 will automatically determine
the backing file string to use, or error out if there
is no obvious choice.  Care should be taken when
specifying the string, to specify a valid filename or
protocol.
(Since 2.1)
.ie n .IP """speed: int"" (optional)" 4
.el .IP "\f(CWspeed: int (optional)" 4
.IX Item "speed: int (optional)"
the maximum speed, in bytes per second
.ie n .IP """on-error: BlockdevOnError"" (optional)" 4
.el .IP "\f(CWon-error: BlockdevOnError (optional)" 4
.IX Item "on-error: BlockdevOnError (optional)"
the action to take on an error (default report).
'stop' and 'enospc' can only be used if the block device
supports io-status (see BlockInfo).  Since 1.3.
.ie n .IP """auto-finalize: boolean"" (optional)" 4
.el .IP "\f(CWauto-finalize: boolean (optional)" 4
.IX Item "auto-finalize: boolean (optional)"
When false, this job will wait in a \s-1PENDING\s0 state after it has
finished its work, waiting for \f(CW`block-job-finalize\*(C' before
making any block graph changes.
When true, this job will automatically
perform its abort or commit actions.
Defaults to true. (Since 3.1)
.ie n .IP """auto-dismiss: boolean"" (optional)" 4
.el .IP "\f(CWauto-dismiss: boolean (optional)" 4
.IX Item "auto-dismiss: boolean (optional)"
When false, this job will wait in a \s-1CONCLUDED\s0 state after it
has completely ceased all work, and awaits \f(CW`block-job-dismiss\*(C'.
When true, this job will automatically disappear from the query
list without user intervention.
Defaults to true. (Since 3.1)

**Returns:**
Nothing on success. If \f(CW`device\*(C' does not exist, DeviceNotFound.

**Since:**
1.1

**Example:**

.Vb 4
        -&gt; { "execute": "block-stream",
             "arguments": { "device": "virtio0",
                            "base": "/tmp/master.qcow2" } }
        &lt;- { "return": {} }
.Ve

**block-job-set-speed**  (Command)
Set maximum speed for a background block operation.

This command can only be issued when there is an active block job.

Throttling can be disabled by setting the speed to 0.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. This used to be a device name (hence
the name of the parameter), but since \s-1QEMU 2.7\s0 it can have
other values.
.ie n .IP """speed: int""" 4
.el .IP "\f(CWspeed: int" 4
.IX Item "speed: int"
the maximum speed, in bytes per second, or 0 for unlimited.
Defaults to 0.

**Returns:**
Nothing on success
If no background operation is active on this device, DeviceNotActive

**Since:**
1.1

**block-job-cancel**  (Command)
Stop an active background block operation.

This command returns immediately after marking the active background block
operation for cancellation.  It is an error to call this command if no
operation is in progress.

The operation will cancel as soon as possible and then emit the
\s-1BLOCK_JOB_CANCELLED\s0 event.  Before that happens the job is still visible when
enumerated using query-block-jobs.

Note that if you issue 'block-job-cancel' after 'drive-mirror' has indicated
(via the event \s-1BLOCK_JOB_READY\s0) that the source and destination are
synchronized, then the event triggered by this command changes to
\s-1BLOCK_JOB_COMPLETED,\s0 to indicate that the mirroring has ended and the
destination now has a point-in-time copy tied to the time of the cancellation.

For streaming, the image file retains its backing file unless the streaming
operation happens to complete just as it is being cancelled.  A new streaming
operation can be started at a later time to finish copying all data from the
backing file.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. This used to be a device name (hence
the name of the parameter), but since \s-1QEMU 2.7\s0 it can have
other values.
.ie n .IP """force: boolean"" (optional)" 4
.el .IP "\f(CWforce: boolean (optional)" 4
.IX Item "force: boolean (optional)"
If true, and the job has already emitted the event \s-1BLOCK_JOB_READY,\s0
abandon the job immediately (even if it is paused) instead of waiting
for the destination to complete its final synchronization (since 1.3)

**Returns:**
Nothing on success
If no background operation is active on this device, DeviceNotActive

**Since:**
1.1

**block-job-pause**  (Command)
Pause an active background block operation.

This command returns immediately after marking the active background block
operation for pausing.  It is an error to call this command if no
operation is in progress or if the job is already paused.

The operation will pause as soon as possible.  No event is emitted when
the operation is actually paused.  Cancelling a paused job automatically
resumes it.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. This used to be a device name (hence
the name of the parameter), but since \s-1QEMU 2.7\s0 it can have
other values.

**Returns:**
Nothing on success
If no background operation is active on this device, DeviceNotActive

**Since:**
1.3

**block-job-resume**  (Command)
Resume an active background block operation.

This command returns immediately after resuming a paused background block
operation.  It is an error to call this command if no operation is in
progress or if the job is not paused.

This command also clears the error status of the job.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. This used to be a device name (hence
the name of the parameter), but since \s-1QEMU 2.7\s0 it can have
other values.

**Returns:**
Nothing on success
If no background operation is active on this device, DeviceNotActive

**Since:**
1.3

**block-job-complete**  (Command)
Manually trigger completion of an active background block operation.  This
is supported for drive mirroring, where it also switches the device to
write to the target path only.  The ability to complete is signaled with
a \s-1BLOCK_JOB_READY\s0 event.

This command completes an active background block operation synchronously.
The ordering of this command's return with the \s-1BLOCK_JOB_COMPLETED\s0 event
is not defined.  Note that if an I/O error occurs during the processing of
this command: 1) the command itself will fail; 2) the error will be processed
according to the rerror/werror arguments that were specified when starting
the operation.

A cancelled or paused job cannot be completed.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. This used to be a device name (hence
the name of the parameter), but since \s-1QEMU 2.7\s0 it can have
other values.

**Returns:**
Nothing on success
If no background operation is active on this device, DeviceNotActive

**Since:**
1.3

**block-job-dismiss**  (Command)
For jobs that have already concluded, remove them from the block-job-query
list. This command only needs to be run for jobs which were started with
\s-1QEMU 2.12+\s0 job lifetime management semantics.

This command will refuse to operate on any job that has not yet reached
its terminal state, \s-1JOB_STATUS_CONCLUDED.\s0 For jobs that make use of the
\s-1BLOCK_JOB_READY\s0 event, block-job-cancel or block-job-complete will still need
to be used as appropriate.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier.

**Returns:**
Nothing on success

**Since:**
2.12

**block-job-finalize**  (Command)
Once a job that has manual=true reaches the pending state, it can be
instructed to finalize any graph changes and do any necessary cleanup
via this command.
For jobs in a transaction, instructing one job to finalize will force
\s-1ALL\s0 jobs in the transaction to finalize, so it is only necessary to instruct
a single member job to finalize.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier.

**Returns:**
Nothing on success

**Since:**
2.12

**BlockdevDiscardOptions** (Enum)

Determines how to handle discard requests.

**Values:**
.ie n .IP """ignore""" 4
.el .IP "\f(CWignore" 4
.IX Item "ignore"
Ignore the request
.ie n .IP """unmap""" 4
.el .IP "\f(CWunmap" 4
.IX Item "unmap"
Forward as an unmap request

**Since:**
2.9

**BlockdevDetectZeroesOptions** (Enum)

Describes the operation mode for the automatic conversion of plain
zero writes by the \s-1OS\s0 to driver specific optimized zero write commands.

**Values:**
.ie n .IP """off""" 4
.el .IP "\f(CWoff" 4
.IX Item "off"
Disabled (default)
.ie n .IP """on""" 4
.el .IP "\f(CWon" 4
.IX Item "on"
Enabled
.ie n .IP """unmap""" 4
.el .IP "\f(CWunmap" 4
.IX Item "unmap"
Enabled and even try to unmap blocks if possible. This requires
also that \f(CW`BlockdevDiscardOptions\*(C' is set to unmap for this device.

**Since:**
2.1

**BlockdevAioOptions** (Enum)

Selects the \s-1AIO\s0 backend to handle I/O requests

**Values:**
.ie n .IP """threads""" 4
.el .IP "\f(CWthreads" 4
.IX Item "threads"
Use qemu's thread pool
.ie n .IP """native""" 4
.el .IP "\f(CWnative" 4
.IX Item "native"
Use native \s-1AIO\s0 backend (only Linux and Windows)

**Since:**
2.9

**BlockdevCacheOptions** (Object)

Includes cache-related options for block devices

**Members:**
.ie n .IP """direct: boolean"" (optional)" 4
.el .IP "\f(CWdirect: boolean (optional)" 4
.IX Item "direct: boolean (optional)"
enables use of O_DIRECT (bypass the host page cache;
default: false)
.ie n .IP """no-flush: boolean"" (optional)" 4
.el .IP "\f(CWno-flush: boolean (optional)" 4
.IX Item "no-flush: boolean (optional)"
ignore any flush requests for the device (default:
false)

**Since:**
2.9

**BlockdevDriver** (Enum)

Drivers that are supported in block device operations.

**Values:**
.ie n .IP """vxhs""" 4
.el .IP "\f(CWvxhs" 4
.IX Item "vxhs"
Since 2.10
.ie n .IP """throttle""" 4
.el .IP "\f(CWthrottle" 4
.IX Item "throttle"
Since 2.11
.ie n .IP """nvme""" 4
.el .IP "\f(CWnvme" 4
.IX Item "nvme"
Since 2.12
.ie n .IP """copy-on-read""" 4
.el .IP "\f(CWcopy-on-read" 4
.IX Item "copy-on-read"
Since 3.0
.ie n .IP """blklogwrites""" 4
.el .IP "\f(CWblklogwrites" 4
.IX Item "blklogwrites"
Since 3.0
.ie n .IP """blkdebug""" 4
.el .IP "\f(CWblkdebug" 4
.IX Item "blkdebug"
Not documented
.ie n .IP """blkverify""" 4
.el .IP "\f(CWblkverify" 4
.IX Item "blkverify"
Not documented
.ie n .IP """bochs""" 4
.el .IP "\f(CWbochs" 4
.IX Item "bochs"
Not documented
.ie n .IP """cloop""" 4
.el .IP "\f(CWcloop" 4
.IX Item "cloop"
Not documented
.ie n .IP """dmg""" 4
.el .IP "\f(CWdmg" 4
.IX Item "dmg"
Not documented
.ie n .IP """file""" 4
.el .IP "\f(CWfile" 4
.IX Item "file"
Not documented
.ie n .IP """ftp""" 4
.el .IP "\f(CWftp" 4
.IX Item "ftp"
Not documented
.ie n .IP """ftps""" 4
.el .IP "\f(CWftps" 4
.IX Item "ftps"
Not documented
.ie n .IP """gluster""" 4
.el .IP "\f(CWgluster" 4
.IX Item "gluster"
Not documented
.ie n .IP """host_cdrom""" 4
.el .IP "\f(CWhost\_cdrom" 4
.IX Item "host_cdrom"
Not documented
.ie n .IP """host_device""" 4
.el .IP "\f(CWhost\_device" 4
.IX Item "host_device"
Not documented
.ie n .IP """http""" 4
.el .IP "\f(CWhttp" 4
.IX Item "http"
Not documented
.ie n .IP """https""" 4
.el .IP "\f(CWhttps" 4
.IX Item "https"
Not documented
.ie n .IP """iscsi""" 4
.el .IP "\f(CWiscsi" 4
.IX Item "iscsi"
Not documented
.ie n .IP """luks""" 4
.el .IP "\f(CWluks" 4
.IX Item "luks"
Not documented
.ie n .IP """nbd""" 4
.el .IP "\f(CWnbd" 4
.IX Item "nbd"
Not documented
.ie n .IP """nfs""" 4
.el .IP "\f(CWnfs" 4
.IX Item "nfs"
Not documented
.ie n .IP """null-aio""" 4
.el .IP "\f(CWnull-aio" 4
.IX Item "null-aio"
Not documented
.ie n .IP """null-co""" 4
.el .IP "\f(CWnull-co" 4
.IX Item "null-co"
Not documented
.ie n .IP """parallels""" 4
.el .IP "\f(CWparallels" 4
.IX Item "parallels"
Not documented
.ie n .IP """qcow""" 4
.el .IP "\f(CWqcow" 4
.IX Item "qcow"
Not documented
.ie n .IP """qcow2""" 4
.el .IP "\f(CWqcow2" 4
.IX Item "qcow2"
Not documented
.ie n .IP """qed""" 4
.el .IP "\f(CWqed" 4
.IX Item "qed"
Not documented
.ie n .IP """quorum""" 4
.el .IP "\f(CWquorum" 4
.IX Item "quorum"
Not documented
.ie n .IP """raw""" 4
.el .IP "\f(CWraw" 4
.IX Item "raw"
Not documented
.ie n .IP """rbd""" 4
.el .IP "\f(CWrbd" 4
.IX Item "rbd"
Not documented
.ie n .IP """replication""" 4
.el .IP "\f(CWreplication" 4
.IX Item "replication"
Not documented
.ie n .IP """sheepdog""" 4
.el .IP "\f(CWsheepdog" 4
.IX Item "sheepdog"
Not documented
.ie n .IP """ssh""" 4
.el .IP "\f(CWssh" 4
.IX Item "ssh"
Not documented
.ie n .IP """vdi""" 4
.el .IP "\f(CWvdi" 4
.IX Item "vdi"
Not documented
.ie n .IP """vhdx""" 4
.el .IP "\f(CWvhdx" 4
.IX Item "vhdx"
Not documented
.ie n .IP """vmdk""" 4
.el .IP "\f(CWvmdk" 4
.IX Item "vmdk"
Not documented
.ie n .IP """vpc""" 4
.el .IP "\f(CWvpc" 4
.IX Item "vpc"
Not documented
.ie n .IP """vvfat""" 4
.el .IP "\f(CWvvfat" 4
.IX Item "vvfat"
Not documented

**Since:**
2.9

**BlockdevOptionsFile** (Object)

Driver specific block device options for the file backend.

**Members:**
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
path to the image file
.ie n .IP """pr-manager: string"" (optional)" 4
.el .IP "\f(CWpr-manager: string (optional)" 4
.IX Item "pr-manager: string (optional)"
the id for the object that will handle persistent reservations
for this device (default: none, forward the commands via \s-1SG_IO\s0;
since 2.11)
.ie n .IP """aio: BlockdevAioOptions"" (optional)" 4
.el .IP "\f(CWaio: BlockdevAioOptions (optional)" 4
.IX Item "aio: BlockdevAioOptions (optional)"
\s-1AIO\s0 backend (default: threads) (since: 2.8)
.ie n .IP """locking: OnOffAuto"" (optional)" 4
.el .IP "\f(CWlocking: OnOffAuto (optional)" 4
.IX Item "locking: OnOffAuto (optional)"
whether to enable file locking. If set to 'auto', only enable
when Open File Descriptor (\s-1OFD\s0) locking \s-1API\s0 is available
(default: auto, since 2.10)
.ie n .IP """x-check-cache-dropped: boolean"" (optional)" 4
.el .IP "\f(CWx-check-cache-dropped: boolean (optional)" 4
.IX Item "x-check-cache-dropped: boolean (optional)"
whether to check that page cache was dropped on live
migration.  May cause noticeable delays if the image
file is large, do not use in production.
(default: off) (since: 3.0)

**Since:**
2.9

**BlockdevOptionsNull** (Object)

Driver specific block device options for the null backend.

**Members:**
.ie n .IP """size: int"" (optional)" 4
.el .IP "\f(CWsize: int (optional)" 4
.IX Item "size: int (optional)"
size of the device in bytes.
.ie n .IP """latency-ns: int"" (optional)" 4
.el .IP "\f(CWlatency-ns: int (optional)" 4
.IX Item "latency-ns: int (optional)"
emulated latency (in nanoseconds) in processing
requests. Default to zero which completes requests immediately.
(Since 2.4)

**Since:**
2.9

**BlockdevOptionsNVMe** (Object)

Driver specific block device options for the NVMe backend.

**Members:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
controller address of the NVMe device.
.ie n .IP """namespace: int""" 4
.el .IP "\f(CWnamespace: int" 4
.IX Item "namespace: int"
namespace number of the device, starting from 1.

**Since:**
2.12

**BlockdevOptionsVVFAT** (Object)

Driver specific block device options for the vvfat protocol.

**Members:**
.ie n .IP """dir: string""" 4
.el .IP "\f(CWdir: string" 4
.IX Item "dir: string"
directory to be exported as \s-1FAT\s0 image
.ie n .IP """fat-type: int"" (optional)" 4
.el .IP "\f(CWfat-type: int (optional)" 4
.IX Item "fat-type: int (optional)"
\s-1FAT\s0 type: 12, 16 or 32
.ie n .IP """floppy: boolean"" (optional)" 4
.el .IP "\f(CWfloppy: boolean (optional)" 4
.IX Item "floppy: boolean (optional)"
whether to export a floppy image (true) or
partitioned hard disk (false; default)
.ie n .IP """label: string"" (optional)" 4
.el .IP "\f(CWlabel: string (optional)" 4
.IX Item "label: string (optional)"
set the volume label, limited to 11 bytes. \s-1FAT16\s0 and
\s-1FAT32\s0 traditionally have some restrictions on labels, which are
ignored by most operating systems. Defaults to \s-1QEMU VVFAT\*(R".\s0
(since 2.4)
.ie n .IP """rw: boolean"" (optional)" 4
.el .IP "\f(CWrw: boolean (optional)" 4
.IX Item "rw: boolean (optional)"
whether to allow write operations (default: false)

**Since:**
2.9

**BlockdevOptionsGenericFormat** (Object)

Driver specific block device options for image format that have no option
besides their data source.

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
reference to or definition of the data source block device

**Since:**
2.9

**BlockdevOptionsLUKS** (Object)

Driver specific block device options for \s-1LUKS.\s0

**Members:**
.ie n .IP """key-secret: string"" (optional)" 4
.el .IP "\f(CWkey-secret: string (optional)" 4
.IX Item "key-secret: string (optional)"
the \s-1ID\s0 of a QCryptoSecret object providing
the decryption key (since 2.6). Mandatory except when
doing a metadata-only probe of the image.
.ie n .IP "The members of ""BlockdevOptionsGenericFormat""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat" 4
.IX Item "The members of BlockdevOptionsGenericFormat"

**Since:**
2.9

**BlockdevOptionsGenericCOWFormat** (Object)

Driver specific block device options for image format that have no option
besides their data source and an optional backing file.

**Members:**
.ie n .IP """backing: BlockdevRefOrNull"" (optional)" 4
.el .IP "\f(CWbacking: BlockdevRefOrNull (optional)" 4
.IX Item "backing: BlockdevRefOrNull (optional)"
reference to or definition of the backing file block
device, null disables the backing file entirely.
Defaults to the backing file stored the image file.
.ie n .IP "The members of ""BlockdevOptionsGenericFormat""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat" 4
.IX Item "The members of BlockdevOptionsGenericFormat"

**Since:**
2.9

**Qcow2OverlapCheckMode** (Enum)

General overlap check modes.

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Do not perform any checks
.ie n .IP """constant""" 4
.el .IP "\f(CWconstant" 4
.IX Item "constant"
Perform only checks which can be done in constant time and
without reading anything from disk
.ie n .IP """cached""" 4
.el .IP "\f(CWcached" 4
.IX Item "cached"
Perform only checks which can be done without reading anything
from disk
.ie n .IP """all""" 4
.el .IP "\f(CWall" 4
.IX Item "all"
Perform all available overlap checks

**Since:**
2.9

**Qcow2OverlapCheckFlags** (Object)

Structure of flags for each metadata structure. Setting a field to 'true'
makes qemu guard that structure against unintended overwriting. The default
value is chosen according to the template given.

**Members:**
.ie n .IP """template: Qcow2OverlapCheckMode"" (optional)" 4
.el .IP "\f(CWtemplate: Qcow2OverlapCheckMode (optional)" 4
.IX Item "template: Qcow2OverlapCheckMode (optional)"
Specifies a template mode which can be adjusted using the other
flags, defaults to 'cached'
.ie n .IP """bitmap-directory: boolean"" (optional)" 4
.el .IP "\f(CWbitmap-directory: boolean (optional)" 4
.IX Item "bitmap-directory: boolean (optional)"
since 3.0
.ie n .IP """main-header: boolean"" (optional)" 4
.el .IP "\f(CWmain-header: boolean (optional)" 4
.IX Item "main-header: boolean (optional)"
Not documented
.ie n .IP """active-l1: boolean"" (optional)" 4
.el .IP "\f(CWactive-l1: boolean (optional)" 4
.IX Item "active-l1: boolean (optional)"
Not documented
.ie n .IP """active-l2: boolean"" (optional)" 4
.el .IP "\f(CWactive-l2: boolean (optional)" 4
.IX Item "active-l2: boolean (optional)"
Not documented
.ie n .IP """refcount-table: boolean"" (optional)" 4
.el .IP "\f(CWrefcount-table: boolean (optional)" 4
.IX Item "refcount-table: boolean (optional)"
Not documented
.ie n .IP """refcount-block: boolean"" (optional)" 4
.el .IP "\f(CWrefcount-block: boolean (optional)" 4
.IX Item "refcount-block: boolean (optional)"
Not documented
.ie n .IP """snapshot-table: boolean"" (optional)" 4
.el .IP "\f(CWsnapshot-table: boolean (optional)" 4
.IX Item "snapshot-table: boolean (optional)"
Not documented
.ie n .IP """inactive-l1: boolean"" (optional)" 4
.el .IP "\f(CWinactive-l1: boolean (optional)" 4
.IX Item "inactive-l1: boolean (optional)"
Not documented
.ie n .IP """inactive-l2: boolean"" (optional)" 4
.el .IP "\f(CWinactive-l2: boolean (optional)" 4
.IX Item "inactive-l2: boolean (optional)"
Not documented

**Since:**
2.9

**Qcow2OverlapChecks** (Alternate)

Specifies which metadata structures should be guarded against unintended
overwriting.

**Members:**
.ie n .IP """flags: Qcow2OverlapCheckFlags""" 4
.el .IP "\f(CWflags: Qcow2OverlapCheckFlags" 4
.IX Item "flags: Qcow2OverlapCheckFlags"
set of flags for separate specification of each metadata structure
type
.ie n .IP """mode: Qcow2OverlapCheckMode""" 4
.el .IP "\f(CWmode: Qcow2OverlapCheckMode" 4
.IX Item "mode: Qcow2OverlapCheckMode"
named mode which chooses a specific set of flags

**Since:**
2.9

**BlockdevQcowEncryptionFormat** (Enum)

**Values:**
.ie n .IP """aes""" 4
.el .IP "\f(CWaes" 4
.IX Item "aes"
AES-CBC with plain64 initialization vectors

**Since:**
2.10

**BlockdevQcowEncryption** (Object)

**Members:**
.ie n .IP """format: BlockdevQcowEncryptionFormat""" 4
.el .IP "\f(CWformat: BlockdevQcowEncryptionFormat" 4
.IX Item "format: BlockdevQcowEncryptionFormat"
Not documented
.ie n .IP "The members of ""QCryptoBlockOptionsQCow"" when ""format"" is ""aes""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsQCow when \f(CWformat is \`\`aes''" 4
.IX Item "The members of QCryptoBlockOptionsQCow when format is aes"

**Since:**
2.10

**BlockdevOptionsQcow** (Object)

Driver specific block device options for qcow.

**Members:**
.ie n .IP """encrypt: BlockdevQcowEncryption"" (optional)" 4
.el .IP "\f(CWencrypt: BlockdevQcowEncryption (optional)" 4
.IX Item "encrypt: BlockdevQcowEncryption (optional)"
Image decryption options. Mandatory for
encrypted images, except when doing a metadata-only
probe of the image.
.ie n .IP "The members of ""BlockdevOptionsGenericCOWFormat""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericCOWFormat" 4
.IX Item "The members of BlockdevOptionsGenericCOWFormat"

**Since:**
2.10

**BlockdevQcow2EncryptionFormat** (Enum)

**Values:**
.ie n .IP """aes""" 4
.el .IP "\f(CWaes" 4
.IX Item "aes"
AES-CBC with plain64 initialization venctors
.ie n .IP """luks""" 4
.el .IP "\f(CWluks" 4
.IX Item "luks"
Not documented

**Since:**
2.10

**BlockdevQcow2Encryption** (Object)

**Members:**
.ie n .IP """format: BlockdevQcow2EncryptionFormat""" 4
.el .IP "\f(CWformat: BlockdevQcow2EncryptionFormat" 4
.IX Item "format: BlockdevQcow2EncryptionFormat"
Not documented
.ie n .IP "The members of ""QCryptoBlockOptionsQCow"" when ""format"" is ""aes""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsQCow when \f(CWformat is \`\`aes''" 4
.IX Item "The members of QCryptoBlockOptionsQCow when format is aes"
.ie n .IP "The members of ""QCryptoBlockOptionsLUKS"" when ""format"" is ""luks""" 4
.el .IP "The members of \f(CWQCryptoBlockOptionsLUKS when \f(CWformat is \`\`luks''" 4
.IX Item "The members of QCryptoBlockOptionsLUKS when format is luks"

**Since:**
2.10

**BlockdevOptionsQcow2** (Object)

Driver specific block device options for qcow2.

**Members:**
.ie n .IP """lazy-refcounts: boolean"" (optional)" 4
.el .IP "\f(CWlazy-refcounts: boolean (optional)" 4
.IX Item "lazy-refcounts: boolean (optional)"
whether to enable the lazy refcounts
feature (default is taken from the image file)
.ie n .IP """pass-discard-request: boolean"" (optional)" 4
.el .IP "\f(CWpass-discard-request: boolean (optional)" 4
.IX Item "pass-discard-request: boolean (optional)"
whether discard requests to the qcow2
device should be forwarded to the data source
.ie n .IP """pass-discard-snapshot: boolean"" (optional)" 4
.el .IP "\f(CWpass-discard-snapshot: boolean (optional)" 4
.IX Item "pass-discard-snapshot: boolean (optional)"
whether discard requests for the data source
should be issued when a snapshot operation (e.g.
deleting a snapshot) frees clusters in the qcow2 file
.ie n .IP """pass-discard-other: boolean"" (optional)" 4
.el .IP "\f(CWpass-discard-other: boolean (optional)" 4
.IX Item "pass-discard-other: boolean (optional)"
whether discard requests for the data source
should be issued on other occasions where a cluster
gets freed
.ie n .IP """overlap-check: Qcow2OverlapChecks"" (optional)" 4
.el .IP "\f(CWoverlap-check: Qcow2OverlapChecks (optional)" 4
.IX Item "overlap-check: Qcow2OverlapChecks (optional)"
which overlap checks to perform for writes
to the image, defaults to 'cached' (since 2.2)
.ie n .IP """cache-size: int"" (optional)" 4
.el .IP "\f(CWcache-size: int (optional)" 4
.IX Item "cache-size: int (optional)"
the maximum total size of the L2 table and
refcount block caches in bytes (since 2.2)
.ie n .IP """l2-cache-size: int"" (optional)" 4
.el .IP "\f(CWl2-cache-size: int (optional)" 4
.IX Item "l2-cache-size: int (optional)"
the maximum size of the L2 table cache in
bytes (since 2.2)
.ie n .IP """l2-cache-entry-size: int"" (optional)" 4
.el .IP "\f(CWl2-cache-entry-size: int (optional)" 4
.IX Item "l2-cache-entry-size: int (optional)"
the size of each entry in the L2 cache in
bytes. It must be a power of two between 512
and the cluster size. The default value is
the cluster size (since 2.12)
.ie n .IP """refcount-cache-size: int"" (optional)" 4
.el .IP "\f(CWrefcount-cache-size: int (optional)" 4
.IX Item "refcount-cache-size: int (optional)"
the maximum size of the refcount block cache
in bytes (since 2.2)
.ie n .IP """cache-clean-interval: int"" (optional)" 4
.el .IP "\f(CWcache-clean-interval: int (optional)" 4
.IX Item "cache-clean-interval: int (optional)"
clean unused entries in the L2 and refcount
caches. The interval is in seconds. The default value
is 600 on supporting platforms, and 0 on other
platforms. 0 disables this feature. (since 2.5)
.ie n .IP """encrypt: BlockdevQcow2Encryption"" (optional)" 4
.el .IP "\f(CWencrypt: BlockdevQcow2Encryption (optional)" 4
.IX Item "encrypt: BlockdevQcow2Encryption (optional)"
Image decryption options. Mandatory for
encrypted images, except when doing a metadata-only
probe of the image. (since 2.10)
.ie n .IP "The members of ""BlockdevOptionsGenericCOWFormat""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericCOWFormat" 4
.IX Item "The members of BlockdevOptionsGenericCOWFormat"

**Since:**
2.9

**SshHostKeyCheckMode** (Enum)

\f(CW`none\*(C'             Don't check the host key at all
\f(CW`hash\*(C'             Compare the host key with a given hash
\f(CW`known\_hosts\*(C'      Check the host key against the known_hosts file

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Not documented
.ie n .IP """hash""" 4
.el .IP "\f(CWhash" 4
.IX Item "hash"
Not documented
.ie n .IP """known_hosts""" 4
.el .IP "\f(CWknown\_hosts" 4
.IX Item "known_hosts"
Not documented

**Since:**
2.12

**SshHostKeyCheckHashType** (Enum)

\f(CW`md5\*(C'              The given hash is an md5 hash
\f(CW`sha1\*(C'             The given hash is an sha1 hash

**Values:**
.ie n .IP """md5""" 4
.el .IP "\f(CWmd5" 4
.IX Item "md5"
Not documented
.ie n .IP """sha1""" 4
.el .IP "\f(CWsha1" 4
.IX Item "sha1"
Not documented

**Since:**
2.12

**SshHostKeyHash** (Object)

\f(CW`type\*(C'             The hash algorithm used for the hash
\f(CW`hash\*(C'             The expected hash value

**Members:**
.ie n .IP """type: SshHostKeyCheckHashType""" 4
.el .IP "\f(CWtype: SshHostKeyCheckHashType" 4
.IX Item "type: SshHostKeyCheckHashType"
Not documented
.ie n .IP """hash: string""" 4
.el .IP "\f(CWhash: string" 4
.IX Item "hash: string"
Not documented

**Since:**
2.12

**SshHostKeyCheck** (Object)

**Members:**
.ie n .IP """mode: SshHostKeyCheckMode""" 4
.el .IP "\f(CWmode: SshHostKeyCheckMode" 4
.IX Item "mode: SshHostKeyCheckMode"
Not documented
.ie n .IP "The members of ""SshHostKeyHash"" when ""mode"" is ""hash""" 4
.el .IP "The members of \f(CWSshHostKeyHash when \f(CWmode is \`\`hash''" 4
.IX Item "The members of SshHostKeyHash when mode is hash"

**Since:**
2.12

**BlockdevOptionsSsh** (Object)

**Members:**
.ie n .IP """server: InetSocketAddress""" 4
.el .IP "\f(CWserver: InetSocketAddress" 4
.IX Item "server: InetSocketAddress"
host address
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
path to the image on the host
.ie n .IP """user: string"" (optional)" 4
.el .IP "\f(CWuser: string (optional)" 4
.IX Item "user: string (optional)"
user as which to connect, defaults to current
local user name
.ie n .IP """host-key-check: SshHostKeyCheck"" (optional)" 4
.el .IP "\f(CWhost-key-check: SshHostKeyCheck (optional)" 4
.IX Item "host-key-check: SshHostKeyCheck (optional)"
Defines how and what to check the host key against
(default: known_hosts)

**Since:**
2.9

**BlkdebugEvent** (Enum)

Trigger events supported by blkdebug.

**Values:**
.ie n .IP """l1_shrink_write_table""" 4
.el .IP "\f(CWl1\_shrink\_write\_table" 4
.IX Item "l1_shrink_write_table"
write zeros to the l1 table to shrink image.
(since 2.11)
.ie n .IP """l1_shrink_free_l2_clusters""" 4
.el .IP "\f(CWl1\_shrink\_free\_l2\_clusters" 4
.IX Item "l1_shrink_free_l2_clusters"
discard the l2 tables. (since 2.11)
.ie n .IP """cor_write""" 4
.el .IP "\f(CWcor\_write" 4
.IX Item "cor_write"
a write due to copy-on-read (since 2.11)
.ie n .IP """l1_update""" 4
.el .IP "\f(CWl1\_update" 4
.IX Item "l1_update"
Not documented
.ie n .IP """l1_grow_alloc_table""" 4
.el .IP "\f(CWl1\_grow\_alloc\_table" 4
.IX Item "l1_grow_alloc_table"
Not documented
.ie n .IP """l1_grow_write_table""" 4
.el .IP "\f(CWl1\_grow\_write\_table" 4
.IX Item "l1_grow_write_table"
Not documented
.ie n .IP """l1_grow_activate_table""" 4
.el .IP "\f(CWl1\_grow\_activate\_table" 4
.IX Item "l1_grow_activate_table"
Not documented
.ie n .IP """l2_load""" 4
.el .IP "\f(CWl2\_load" 4
.IX Item "l2_load"
Not documented
.ie n .IP """l2_update""" 4
.el .IP "\f(CWl2\_update" 4
.IX Item "l2_update"
Not documented
.ie n .IP """l2_update_compressed""" 4
.el .IP "\f(CWl2\_update\_compressed" 4
.IX Item "l2_update_compressed"
Not documented
.ie n .IP """l2_alloc_cow_read""" 4
.el .IP "\f(CWl2\_alloc\_cow\_read" 4
.IX Item "l2_alloc_cow_read"
Not documented
.ie n .IP """l2_alloc_write""" 4
.el .IP "\f(CWl2\_alloc\_write" 4
.IX Item "l2_alloc_write"
Not documented
.ie n .IP """read_aio""" 4
.el .IP "\f(CWread\_aio" 4
.IX Item "read_aio"
Not documented
.ie n .IP """read_backing_aio""" 4
.el .IP "\f(CWread\_backing\_aio" 4
.IX Item "read_backing_aio"
Not documented
.ie n .IP """read_compressed""" 4
.el .IP "\f(CWread\_compressed" 4
.IX Item "read_compressed"
Not documented
.ie n .IP """write_aio""" 4
.el .IP "\f(CWwrite\_aio" 4
.IX Item "write_aio"
Not documented
.ie n .IP """write_compressed""" 4
.el .IP "\f(CWwrite\_compressed" 4
.IX Item "write_compressed"
Not documented
.ie n .IP """vmstate_load""" 4
.el .IP "\f(CWvmstate\_load" 4
.IX Item "vmstate_load"
Not documented
.ie n .IP """vmstate_save""" 4
.el .IP "\f(CWvmstate\_save" 4
.IX Item "vmstate_save"
Not documented
.ie n .IP """cow_read""" 4
.el .IP "\f(CWcow\_read" 4
.IX Item "cow_read"
Not documented
.ie n .IP """cow_write""" 4
.el .IP "\f(CWcow\_write" 4
.IX Item "cow_write"
Not documented
.ie n .IP """reftable_load""" 4
.el .IP "\f(CWreftable\_load" 4
.IX Item "reftable_load"
Not documented
.ie n .IP """reftable_grow""" 4
.el .IP "\f(CWreftable\_grow" 4
.IX Item "reftable_grow"
Not documented
.ie n .IP """reftable_update""" 4
.el .IP "\f(CWreftable\_update" 4
.IX Item "reftable_update"
Not documented
.ie n .IP """refblock_load""" 4
.el .IP "\f(CWrefblock\_load" 4
.IX Item "refblock_load"
Not documented
.ie n .IP """refblock_update""" 4
.el .IP "\f(CWrefblock\_update" 4
.IX Item "refblock_update"
Not documented
.ie n .IP """refblock_update_part""" 4
.el .IP "\f(CWrefblock\_update\_part" 4
.IX Item "refblock_update_part"
Not documented
.ie n .IP """refblock_alloc""" 4
.el .IP "\f(CWrefblock\_alloc" 4
.IX Item "refblock_alloc"
Not documented
.ie n .IP """refblock_alloc_hookup""" 4
.el .IP "\f(CWrefblock\_alloc\_hookup" 4
.IX Item "refblock_alloc_hookup"
Not documented
.ie n .IP """refblock_alloc_write""" 4
.el .IP "\f(CWrefblock\_alloc\_write" 4
.IX Item "refblock_alloc_write"
Not documented
.ie n .IP """refblock_alloc_write_blocks""" 4
.el .IP "\f(CWrefblock\_alloc\_write\_blocks" 4
.IX Item "refblock_alloc_write_blocks"
Not documented
.ie n .IP """refblock_alloc_write_table""" 4
.el .IP "\f(CWrefblock\_alloc\_write\_table" 4
.IX Item "refblock_alloc_write_table"
Not documented
.ie n .IP """refblock_alloc_switch_table""" 4
.el .IP "\f(CWrefblock\_alloc\_switch\_table" 4
.IX Item "refblock_alloc_switch_table"
Not documented
.ie n .IP """cluster_alloc""" 4
.el .IP "\f(CWcluster\_alloc" 4
.IX Item "cluster_alloc"
Not documented
.ie n .IP """cluster_alloc_bytes""" 4
.el .IP "\f(CWcluster\_alloc\_bytes" 4
.IX Item "cluster_alloc_bytes"
Not documented
.ie n .IP """cluster_free""" 4
.el .IP "\f(CWcluster\_free" 4
.IX Item "cluster_free"
Not documented
.ie n .IP """flush_to_os""" 4
.el .IP "\f(CWflush\_to\_os" 4
.IX Item "flush_to_os"
Not documented
.ie n .IP """flush_to_disk""" 4
.el .IP "\f(CWflush\_to\_disk" 4
.IX Item "flush_to_disk"
Not documented
.ie n .IP """pwritev_rmw_head""" 4
.el .IP "\f(CWpwritev\_rmw\_head" 4
.IX Item "pwritev_rmw_head"
Not documented
.ie n .IP """pwritev_rmw_after_head""" 4
.el .IP "\f(CWpwritev\_rmw\_after\_head" 4
.IX Item "pwritev_rmw_after_head"
Not documented
.ie n .IP """pwritev_rmw_tail""" 4
.el .IP "\f(CWpwritev\_rmw\_tail" 4
.IX Item "pwritev_rmw_tail"
Not documented
.ie n .IP """pwritev_rmw_after_tail""" 4
.el .IP "\f(CWpwritev\_rmw\_after\_tail" 4
.IX Item "pwritev_rmw_after_tail"
Not documented
.ie n .IP """pwritev""" 4
.el .IP "\f(CWpwritev" 4
.IX Item "pwritev"
Not documented
.ie n .IP """pwritev_zero""" 4
.el .IP "\f(CWpwritev\_zero" 4
.IX Item "pwritev_zero"
Not documented
.ie n .IP """pwritev_done""" 4
.el .IP "\f(CWpwritev\_done" 4
.IX Item "pwritev_done"
Not documented
.ie n .IP """empty_image_prepare""" 4
.el .IP "\f(CWempty\_image\_prepare" 4
.IX Item "empty_image_prepare"
Not documented

**Since:**
2.9

**BlkdebugInjectErrorOptions** (Object)

Describes a single error injection for blkdebug.

**Members:**
.ie n .IP """event: BlkdebugEvent""" 4
.el .IP "\f(CWevent: BlkdebugEvent" 4
.IX Item "event: BlkdebugEvent"
trigger event
.ie n .IP """state: int"" (optional)" 4
.el .IP "\f(CWstate: int (optional)" 4
.IX Item "state: int (optional)"
the state identifier blkdebug needs to be in to
actually trigger the event; defaults to any\*(R"
.ie n .IP """errno: int"" (optional)" 4
.el .IP "\f(CWerrno: int (optional)" 4
.IX Item "errno: int (optional)"
error identifier (errno) to be returned; defaults to
\s-1EIO\s0
.ie n .IP """sector: int"" (optional)" 4
.el .IP "\f(CWsector: int (optional)" 4
.IX Item "sector: int (optional)"
specifies the sector index which has to be affected
in order to actually trigger the event; defaults to any
sector
.ie n .IP """once: boolean"" (optional)" 4
.el .IP "\f(CWonce: boolean (optional)" 4
.IX Item "once: boolean (optional)"
disables further events after this one has been
triggered; defaults to false
.ie n .IP """immediately: boolean"" (optional)" 4
.el .IP "\f(CWimmediately: boolean (optional)" 4
.IX Item "immediately: boolean (optional)"
fail immediately; defaults to false

**Since:**
2.9

**BlkdebugSetStateOptions** (Object)

Describes a single state-change event for blkdebug.

**Members:**
.ie n .IP """event: BlkdebugEvent""" 4
.el .IP "\f(CWevent: BlkdebugEvent" 4
.IX Item "event: BlkdebugEvent"
trigger event
.ie n .IP """state: int"" (optional)" 4
.el .IP "\f(CWstate: int (optional)" 4
.IX Item "state: int (optional)"
the current state identifier blkdebug needs to be in;
defaults to any\*(R"
.ie n .IP """new_state: int""" 4
.el .IP "\f(CWnew_state: int" 4
.IX Item "new_state: int"
the state identifier blkdebug is supposed to assume if
this event is triggered

**Since:**
2.9

**BlockdevOptionsBlkdebug** (Object)

Driver specific block device options for blkdebug.

**Members:**
.ie n .IP """image: BlockdevRef""" 4
.el .IP "\f(CWimage: BlockdevRef" 4
.IX Item "image: BlockdevRef"
underlying raw block device (or image file)
.ie n .IP """config: string"" (optional)" 4
.el .IP "\f(CWconfig: string (optional)" 4
.IX Item "config: string (optional)"
filename of the configuration file
.ie n .IP """align: int"" (optional)" 4
.el .IP "\f(CWalign: int (optional)" 4
.IX Item "align: int (optional)"
required alignment for requests in bytes, must be
positive power of 2, or 0 for default
.ie n .IP """max-transfer: int"" (optional)" 4
.el .IP "\f(CWmax-transfer: int (optional)" 4
.IX Item "max-transfer: int (optional)"
maximum size for I/O transfers in bytes, must be
positive multiple of \f(CW`align\*(C' and of the underlying
file's request alignment (but need not be a power of
2), or 0 for default (since 2.10)
.ie n .IP """opt-write-zero: int"" (optional)" 4
.el .IP "\f(CWopt-write-zero: int (optional)" 4
.IX Item "opt-write-zero: int (optional)"
preferred alignment for write zero requests in bytes,
must be positive multiple of \f(CW`align\*(C' and of the
underlying file's request alignment (but need not be a
power of 2), or 0 for default (since 2.10)
.ie n .IP """max-write-zero: int"" (optional)" 4
.el .IP "\f(CWmax-write-zero: int (optional)" 4
.IX Item "max-write-zero: int (optional)"
maximum size for write zero requests in bytes, must be
positive multiple of \f(CW`align\*(C', of \f(CW\*(C\`opt-write-zero\*(C', and of
the underlying file's request alignment (but need not
be a power of 2), or 0 for default (since 2.10)
.ie n .IP """opt-discard: int"" (optional)" 4
.el .IP "\f(CWopt-discard: int (optional)" 4
.IX Item "opt-discard: int (optional)"
preferred alignment for discard requests in bytes, must
be positive multiple of \f(CW`align\*(C' and of the underlying
file's request alignment (but need not be a power of
2), or 0 for default (since 2.10)
.ie n .IP """max-discard: int"" (optional)" 4
.el .IP "\f(CWmax-discard: int (optional)" 4
.IX Item "max-discard: int (optional)"
maximum size for discard requests in bytes, must be
positive multiple of \f(CW`align\*(C', of \f(CW\*(C\`opt-discard\*(C', and of
the underlying file's request alignment (but need not
be a power of 2), or 0 for default (since 2.10)
.ie n .IP """inject-error: array of BlkdebugInjectErrorOptions"" (optional)" 4
.el .IP "\f(CWinject-error: array of BlkdebugInjectErrorOptions (optional)" 4
.IX Item "inject-error: array of BlkdebugInjectErrorOptions (optional)"
array of error injection descriptions
.ie n .IP """set-state: array of BlkdebugSetStateOptions"" (optional)" 4
.el .IP "\f(CWset-state: array of BlkdebugSetStateOptions (optional)" 4
.IX Item "set-state: array of BlkdebugSetStateOptions (optional)"
array of state-change descriptions

**Since:**
2.9

**BlockdevOptionsBlklogwrites** (Object)

Driver specific block device options for blklogwrites.

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
block device
.ie n .IP """log: BlockdevRef""" 4
.el .IP "\f(CWlog: BlockdevRef" 4
.IX Item "log: BlockdevRef"
block device used to log writes to \f(CW`file\*(C'
.ie n .IP """log-sector-size: int"" (optional)" 4
.el .IP "\f(CWlog-sector-size: int (optional)" 4
.IX Item "log-sector-size: int (optional)"
sector size used in logging writes to \f(CW`file\*(C', determines
granularity of offsets and sizes of writes (default: 512)
.ie n .IP """log-append: boolean"" (optional)" 4
.el .IP "\f(CWlog-append: boolean (optional)" 4
.IX Item "log-append: boolean (optional)"
append to an existing log (default: false)
.ie n .IP """log-super-update-interval: int"" (optional)" 4
.el .IP "\f(CWlog-super-update-interval: int (optional)" 4
.IX Item "log-super-update-interval: int (optional)"
interval of write requests after which the log
super block is updated to disk (default: 4096)

**Since:**
3.0

**BlockdevOptionsBlkverify** (Object)

Driver specific block device options for blkverify.

**Members:**
.ie n .IP """test: BlockdevRef""" 4
.el .IP "\f(CWtest: BlockdevRef" 4
.IX Item "test: BlockdevRef"
block device to be tested
.ie n .IP """raw: BlockdevRef""" 4
.el .IP "\f(CWraw: BlockdevRef" 4
.IX Item "raw: BlockdevRef"
raw image used for verification

**Since:**
2.9

**QuorumReadPattern** (Enum)

An enumeration of quorum read patterns.

**Values:**
.ie n .IP """quorum""" 4
.el .IP "\f(CWquorum" 4
.IX Item "quorum"
read all the children and do a quorum vote on reads
.ie n .IP """fifo""" 4
.el .IP "\f(CWfifo" 4
.IX Item "fifo"
read only from the first child that has not failed

**Since:**
2.9

**BlockdevOptionsQuorum** (Object)

Driver specific block device options for Quorum

**Members:**
.ie n .IP """blkverify: boolean"" (optional)" 4
.el .IP "\f(CWblkverify: boolean (optional)" 4
.IX Item "blkverify: boolean (optional)"
true if the driver must print content mismatch
set to false by default
.ie n .IP """children: array of BlockdevRef""" 4
.el .IP "\f(CWchildren: array of BlockdevRef" 4
.IX Item "children: array of BlockdevRef"
the children block devices to use
.ie n .IP """vote-threshold: int""" 4
.el .IP "\f(CWvote-threshold: int" 4
.IX Item "vote-threshold: int"
the vote limit under which a read will fail
.ie n .IP """rewrite-corrupted: boolean"" (optional)" 4
.el .IP "\f(CWrewrite-corrupted: boolean (optional)" 4
.IX Item "rewrite-corrupted: boolean (optional)"
rewrite corrupted data when quorum is reached
(Since 2.1)
.ie n .IP """read-pattern: QuorumReadPattern"" (optional)" 4
.el .IP "\f(CWread-pattern: QuorumReadPattern (optional)" 4
.IX Item "read-pattern: QuorumReadPattern (optional)"
choose read pattern and set to quorum by default
(Since 2.2)

**Since:**
2.9

**BlockdevOptionsGluster** (Object)

Driver specific block device options for Gluster

**Members:**
.ie n .IP """volume: string""" 4
.el .IP "\f(CWvolume: string" 4
.IX Item "volume: string"
name of gluster volume where \s-1VM\s0 image resides
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
absolute path to image file in gluster volume
.ie n .IP """server: array of SocketAddress""" 4
.el .IP "\f(CWserver: array of SocketAddress" 4
.IX Item "server: array of SocketAddress"
gluster servers description
.ie n .IP """debug: int"" (optional)" 4
.el .IP "\f(CWdebug: int (optional)" 4
.IX Item "debug: int (optional)"
libgfapi log level (default '4' which is Error)
(Since 2.8)
.ie n .IP """logfile: string"" (optional)" 4
.el .IP "\f(CWlogfile: string (optional)" 4
.IX Item "logfile: string (optional)"
libgfapi log file (default /dev/stderr) (Since 2.8)

**Since:**
2.9

**IscsiTransport** (Enum)

An enumeration of libiscsi transport types

**Values:**
.ie n .IP """tcp""" 4
.el .IP "\f(CWtcp" 4
.IX Item "tcp"
Not documented
.ie n .IP """iser""" 4
.el .IP "\f(CWiser" 4
.IX Item "iser"
Not documented

**Since:**
2.9

**IscsiHeaderDigest** (Enum)

An enumeration of header digests supported by libiscsi

**Values:**
.ie n .IP """crc32c""" 4
.el .IP "\f(CWcrc32c" 4
.IX Item "crc32c"
Not documented
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Not documented
.ie n .IP """crc32c-none""" 4
.el .IP "\f(CWcrc32c-none" 4
.IX Item "crc32c-none"
Not documented
.ie n .IP """none-crc32c""" 4
.el .IP "\f(CWnone-crc32c" 4
.IX Item "none-crc32c"
Not documented

**Since:**
2.9

**BlockdevOptionsIscsi** (Object)

**Members:**
.ie n .IP """transport: IscsiTransport""" 4
.el .IP "\f(CWtransport: IscsiTransport" 4
.IX Item "transport: IscsiTransport"
The iscsi transport type
.ie n .IP """portal: string""" 4
.el .IP "\f(CWportal: string" 4
.IX Item "portal: string"
The address of the iscsi portal
.ie n .IP """target: string""" 4
.el .IP "\f(CWtarget: string" 4
.IX Item "target: string"
The target iqn name
.ie n .IP """lun: int"" (optional)" 4
.el .IP "\f(CWlun: int (optional)" 4
.IX Item "lun: int (optional)"
\s-1LUN\s0 to connect to. Defaults to 0.
.ie n .IP """user: string"" (optional)" 4
.el .IP "\f(CWuser: string (optional)" 4
.IX Item "user: string (optional)"
User name to log in with. If omitted, no \s-1CHAP\s0
authentication is performed.
.ie n .IP """password-secret: string"" (optional)" 4
.el .IP "\f(CWpassword-secret: string (optional)" 4
.IX Item "password-secret: string (optional)"
The \s-1ID\s0 of a QCryptoSecret object providing
the password for the login. This option is required if
\f(CW`user\*(C' is specified.
.ie n .IP """initiator-name: string"" (optional)" 4
.el .IP "\f(CWinitiator-name: string (optional)" 4
.IX Item "initiator-name: string (optional)"
The iqn name we want to identify to the target
as. If this option is not specified, an initiator name is
generated automatically.
.ie n .IP """header-digest: IscsiHeaderDigest"" (optional)" 4
.el .IP "\f(CWheader-digest: IscsiHeaderDigest (optional)" 4
.IX Item "header-digest: IscsiHeaderDigest (optional)"
The desired header digest. Defaults to
none-crc32c.
.ie n .IP """timeout: int"" (optional)" 4
.el .IP "\f(CWtimeout: int (optional)" 4
.IX Item "timeout: int (optional)"
Timeout in seconds after which a request will
timeout. 0 means no timeout and is the default.

Driver specific block device options for iscsi

**Since:**
2.9

**RbdAuthMode** (Enum)

**Values:**
.ie n .IP """cephx""" 4
.el .IP "\f(CWcephx" 4
.IX Item "cephx"
Not documented
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Not documented

**Since:**
3.0

**BlockdevOptionsRbd** (Object)

**Members:**
.ie n .IP """pool: string""" 4
.el .IP "\f(CWpool: string" 4
.IX Item "pool: string"
Ceph pool name.
.ie n .IP """image: string""" 4
.el .IP "\f(CWimage: string" 4
.IX Item "image: string"
Image name in the Ceph pool.
.ie n .IP """conf: string"" (optional)" 4
.el .IP "\f(CWconf: string (optional)" 4
.IX Item "conf: string (optional)"
path to Ceph configuration file.  Values
in the configuration file will be overridden by
options specified via \s-1QAPI.\s0
.ie n .IP """snapshot: string"" (optional)" 4
.el .IP "\f(CWsnapshot: string (optional)" 4
.IX Item "snapshot: string (optional)"
Ceph snapshot name.
.ie n .IP """user: string"" (optional)" 4
.el .IP "\f(CWuser: string (optional)" 4
.IX Item "user: string (optional)"
Ceph id name.
.ie n .IP """auth-client-required: array of RbdAuthMode"" (optional)" 4
.el .IP "\f(CWauth-client-required: array of RbdAuthMode (optional)" 4
.IX Item "auth-client-required: array of RbdAuthMode (optional)"
Acceptable authentication modes.
This maps to Ceph configuration option
auth_client_required\*(R".  (Since 3.0)
.ie n .IP """key-secret: string"" (optional)" 4
.el .IP "\f(CWkey-secret: string (optional)" 4
.IX Item "key-secret: string (optional)"
\s-1ID\s0 of a QCryptoSecret object providing a key
for cephx authentication.
This maps to Ceph configuration option
key\*(R".  (Since 3.0)
.ie n .IP """server: array of InetSocketAddressBase"" (optional)" 4
.el .IP "\f(CWserver: array of InetSocketAddressBase (optional)" 4
.IX Item "server: array of InetSocketAddressBase (optional)"
Monitor host address and port.  This maps
to the mon_host\*(R" Ceph option.

**Since:**
2.9

**BlockdevOptionsSheepdog** (Object)

Driver specific block device options for sheepdog

**Members:**
.ie n .IP """vdi: string""" 4
.el .IP "\f(CWvdi: string" 4
.IX Item "vdi: string"
Virtual disk image name
.ie n .IP """server: SocketAddress""" 4
.el .IP "\f(CWserver: SocketAddress" 4
.IX Item "server: SocketAddress"
The Sheepdog server to connect to
.ie n .IP """snap-id: int"" (optional)" 4
.el .IP "\f(CWsnap-id: int (optional)" 4
.IX Item "snap-id: int (optional)"
Snapshot \s-1ID\s0
.ie n .IP """tag: string"" (optional)" 4
.el .IP "\f(CWtag: string (optional)" 4
.IX Item "tag: string (optional)"
Snapshot tag name

Only one of \f(CW`snap-id\*(C' and \f(CW\*(C\`tag\*(C' may be present.

**Since:**
2.9

**ReplicationMode** (Enum)

An enumeration of replication modes.

**Values:**
.ie n .IP """primary""" 4
.el .IP "\f(CWprimary" 4
.IX Item "primary"
Primary mode, the vm's state will be sent to secondary \s-1QEMU.\s0
.ie n .IP """secondary""" 4
.el .IP "\f(CWsecondary" 4
.IX Item "secondary"
Secondary mode, receive the vm's state from primary \s-1QEMU.\s0

**Since:**
2.9

**BlockdevOptionsReplication** (Object)

Driver specific block device options for replication

**Members:**
.ie n .IP """mode: ReplicationMode""" 4
.el .IP "\f(CWmode: ReplicationMode" 4
.IX Item "mode: ReplicationMode"
the replication mode
.ie n .IP """top-id: string"" (optional)" 4
.el .IP "\f(CWtop-id: string (optional)" 4
.IX Item "top-id: string (optional)"
In secondary mode, node name or device \s-1ID\s0 of the root
node who owns the replication node chain. Must not be given in
primary mode.
.ie n .IP "The members of ""BlockdevOptionsGenericFormat""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat" 4
.IX Item "The members of BlockdevOptionsGenericFormat"

**Since:**
2.9

**NFSTransport** (Enum)

An enumeration of \s-1NFS\s0 transport types

**Values:**
.ie n .IP """inet""" 4
.el .IP "\f(CWinet" 4
.IX Item "inet"
\s-1TCP\s0 transport

**Since:**
2.9

**NFSServer** (Object)

Captures the address of the socket

**Members:**
.ie n .IP """type: NFSTransport""" 4
.el .IP "\f(CWtype: NFSTransport" 4
.IX Item "type: NFSTransport"
transport type used for \s-1NFS\s0 (only \s-1TCP\s0 supported)
.ie n .IP """host: string""" 4
.el .IP "\f(CWhost: string" 4
.IX Item "host: string"
host address for \s-1NFS\s0 server

**Since:**
2.9

**BlockdevOptionsNfs** (Object)

Driver specific block device option for \s-1NFS\s0

**Members:**
.ie n .IP """server: NFSServer""" 4
.el .IP "\f(CWserver: NFSServer" 4
.IX Item "server: NFSServer"
host address
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
path of the image on the host
.ie n .IP """user: int"" (optional)" 4
.el .IP "\f(CWuser: int (optional)" 4
.IX Item "user: int (optional)"
\s-1UID\s0 value to use when talking to the
server (defaults to 65534 on Windows and **getuid()**
on unix)
.ie n .IP """group: int"" (optional)" 4
.el .IP "\f(CWgroup: int (optional)" 4
.IX Item "group: int (optional)"
\s-1GID\s0 value to use when talking to the
server (defaults to 65534 on Windows and **getgid()**
in unix)
.ie n .IP """tcp-syn-count: int"" (optional)" 4
.el .IP "\f(CWtcp-syn-count: int (optional)" 4
.IX Item "tcp-syn-count: int (optional)"
number of SYNs during the session
establishment (defaults to libnfs default)
.ie n .IP """readahead-size: int"" (optional)" 4
.el .IP "\f(CWreadahead-size: int (optional)" 4
.IX Item "readahead-size: int (optional)"
set the readahead size in bytes (defaults
to libnfs default)
.ie n .IP """page-cache-size: int"" (optional)" 4
.el .IP "\f(CWpage-cache-size: int (optional)" 4
.IX Item "page-cache-size: int (optional)"
set the pagecache size in bytes (defaults
to libnfs default)
.ie n .IP """debug: int"" (optional)" 4
.el .IP "\f(CWdebug: int (optional)" 4
.IX Item "debug: int (optional)"
set the \s-1NFS\s0 debug level (max 2) (defaults
to libnfs default)

**Since:**
2.9

**BlockdevOptionsCurlBase** (Object)

Driver specific block device options shared by all protocols supported by the
curl backend.

**Members:**
.ie n .IP """url: string""" 4
.el .IP "\f(CWurl: string" 4
.IX Item "url: string"
\s-1URL\s0 of the image file
.ie n .IP """readahead: int"" (optional)" 4
.el .IP "\f(CWreadahead: int (optional)" 4
.IX Item "readahead: int (optional)"
Size of the read-ahead cache; must be a multiple of
512 (defaults to 256 kB)
.ie n .IP """timeout: int"" (optional)" 4
.el .IP "\f(CWtimeout: int (optional)" 4
.IX Item "timeout: int (optional)"
Timeout for connections, in seconds (defaults to 5)
.ie n .IP """username: string"" (optional)" 4
.el .IP "\f(CWusername: string (optional)" 4
.IX Item "username: string (optional)"
Username for authentication (defaults to none)
.ie n .IP """password-secret: string"" (optional)" 4
.el .IP "\f(CWpassword-secret: string (optional)" 4
.IX Item "password-secret: string (optional)"
\s-1ID\s0 of a QCryptoSecret object providing a password
for authentication (defaults to no password)
.ie n .IP """proxy-username: string"" (optional)" 4
.el .IP "\f(CWproxy-username: string (optional)" 4
.IX Item "proxy-username: string (optional)"
Username for proxy authentication (defaults to none)
.ie n .IP """proxy-password-secret: string"" (optional)" 4
.el .IP "\f(CWproxy-password-secret: string (optional)" 4
.IX Item "proxy-password-secret: string (optional)"
\s-1ID\s0 of a QCryptoSecret object providing a password
for proxy authentication (defaults to no password)

**Since:**
2.9

**BlockdevOptionsCurlHttp** (Object)

Driver specific block device options for \s-1HTTP\s0 connections over the curl
backend.  URLs must start with http://\*(R".

**Members:**
.ie n .IP """cookie: string"" (optional)" 4
.el .IP "\f(CWcookie: string (optional)" 4
.IX Item "cookie: string (optional)"
List of cookies to set; format is
name1=content1; name2=content2;\*(R" as explained by
\s-1**CURLOPT\_COOKIE\s0**\|(3). Defaults to no cookies.
.ie n .IP """cookie-secret: string"" (optional)" 4
.el .IP "\f(CWcookie-secret: string (optional)" 4
.IX Item "cookie-secret: string (optional)"
\s-1ID\s0 of a QCryptoSecret object providing the cookie data in a
secure way. See \f(CW`cookie\*(C' for the format. (since 2.10)
.ie n .IP "The members of ""BlockdevOptionsCurlBase""" 4
.el .IP "The members of \f(CWBlockdevOptionsCurlBase" 4
.IX Item "The members of BlockdevOptionsCurlBase"

**Since:**
2.9

**BlockdevOptionsCurlHttps** (Object)

Driver specific block device options for \s-1HTTPS\s0 connections over the curl
backend.  URLs must start with https://\*(R".

**Members:**
.ie n .IP """cookie: string"" (optional)" 4
.el .IP "\f(CWcookie: string (optional)" 4
.IX Item "cookie: string (optional)"
List of cookies to set; format is
name1=content1; name2=content2;\*(R" as explained by
\s-1**CURLOPT\_COOKIE\s0**\|(3). Defaults to no cookies.
.ie n .IP """sslverify: boolean"" (optional)" 4
.el .IP "\f(CWsslverify: boolean (optional)" 4
.IX Item "sslverify: boolean (optional)"
Whether to verify the \s-1SSL\s0 certificate's validity (defaults to
true)
.ie n .IP """cookie-secret: string"" (optional)" 4
.el .IP "\f(CWcookie-secret: string (optional)" 4
.IX Item "cookie-secret: string (optional)"
\s-1ID\s0 of a QCryptoSecret object providing the cookie data in a
secure way. See \f(CW`cookie\*(C' for the format. (since 2.10)
.ie n .IP "The members of ""BlockdevOptionsCurlBase""" 4
.el .IP "The members of \f(CWBlockdevOptionsCurlBase" 4
.IX Item "The members of BlockdevOptionsCurlBase"

**Since:**
2.9

**BlockdevOptionsCurlFtp** (Object)

Driver specific block device options for \s-1FTP\s0 connections over the curl
backend.  URLs must start with ftp://\*(R".

**Members:**
.ie n .IP "The members of ""BlockdevOptionsCurlBase""" 4
.el .IP "The members of \f(CWBlockdevOptionsCurlBase" 4
.IX Item "The members of BlockdevOptionsCurlBase"

**Since:**
2.9

**BlockdevOptionsCurlFtps** (Object)

Driver specific block device options for \s-1FTPS\s0 connections over the curl
backend.  URLs must start with ftps://\*(R".

**Members:**
.ie n .IP """sslverify: boolean"" (optional)" 4
.el .IP "\f(CWsslverify: boolean (optional)" 4
.IX Item "sslverify: boolean (optional)"
Whether to verify the \s-1SSL\s0 certificate's validity (defaults to
true)
.ie n .IP "The members of ""BlockdevOptionsCurlBase""" 4
.el .IP "The members of \f(CWBlockdevOptionsCurlBase" 4
.IX Item "The members of BlockdevOptionsCurlBase"

**Since:**
2.9

**BlockdevOptionsNbd** (Object)

Driver specific block device options for \s-1NBD.\s0

**Members:**
.ie n .IP """server: SocketAddress""" 4
.el .IP "\f(CWserver: SocketAddress" 4
.IX Item "server: SocketAddress"
\s-1NBD\s0 server address
.ie n .IP """export: string"" (optional)" 4
.el .IP "\f(CWexport: string (optional)" 4
.IX Item "export: string (optional)"
export name
.ie n .IP """tls-creds: string"" (optional)" 4
.el .IP "\f(CWtls-creds: string (optional)" 4
.IX Item "tls-creds: string (optional)"
\s-1TLS\s0 credentials \s-1ID\s0
.ie n .IP """x-dirty-bitmap: string"" (optional)" 4
.el .IP "\f(CWx-dirty-bitmap: string (optional)" 4
.IX Item "x-dirty-bitmap: string (optional)"
A qemu:dirty-bitmap:NAME\*(R" string to query in place of
traditional base:allocation\*(R" block status (see
\s-1NBD_OPT_LIST_META_CONTEXT\s0 in the \s-1NBD\s0 protocol) (since 3.0)

**Since:**
2.9

**BlockdevOptionsRaw** (Object)

Driver specific block device options for the raw driver.

**Members:**
.ie n .IP """offset: int"" (optional)" 4
.el .IP "\f(CWoffset: int (optional)" 4
.IX Item "offset: int (optional)"
position where the block device starts
.ie n .IP """size: int"" (optional)" 4
.el .IP "\f(CWsize: int (optional)" 4
.IX Item "size: int (optional)"
the assumed size of the device
.ie n .IP "The members of ""BlockdevOptionsGenericFormat""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat" 4
.IX Item "The members of BlockdevOptionsGenericFormat"

**Since:**
2.9

**BlockdevOptionsVxHS** (Object)

Driver specific block device options for VxHS

**Members:**
.ie n .IP """vdisk-id: string""" 4
.el .IP "\f(CWvdisk-id: string" 4
.IX Item "vdisk-id: string"
\s-1UUID\s0 of VxHS volume
.ie n .IP """server: InetSocketAddressBase""" 4
.el .IP "\f(CWserver: InetSocketAddressBase" 4
.IX Item "server: InetSocketAddressBase"
vxhs server \s-1IP,\s0 port
.ie n .IP """tls-creds: string"" (optional)" 4
.el .IP "\f(CWtls-creds: string (optional)" 4
.IX Item "tls-creds: string (optional)"
\s-1TLS\s0 credentials \s-1ID\s0

**Since:**
2.10

**BlockdevOptionsThrottle** (Object)

Driver specific block device options for the throttle driver

**Members:**
.ie n .IP """throttle-group: string""" 4
.el .IP "\f(CWthrottle-group: string" 4
.IX Item "throttle-group: string"
the name of the throttle-group object to use. It
must already exist.
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
reference to or definition of the data source block device

**Since:**
2.11

**BlockdevOptions** (Object)

Options for creating a block device.  Many options are available for all
block devices, independent of the block driver:

**Members:**
.ie n .IP """driver: BlockdevDriver""" 4
.el .IP "\f(CWdriver: BlockdevDriver" 4
.IX Item "driver: BlockdevDriver"
block driver name
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
the node name of the new node (Since 2.0).
This option is required on the top level of blockdev-add.
Valid node names start with an alphabetic character and may
contain only alphanumeric characters, '-', '.' and '_'. Their
maximum length is 31 characters.
.ie n .IP """discard: BlockdevDiscardOptions"" (optional)" 4
.el .IP "\f(CWdiscard: BlockdevDiscardOptions (optional)" 4
.IX Item "discard: BlockdevDiscardOptions (optional)"
discard-related options (default: ignore)
.ie n .IP """cache: BlockdevCacheOptions"" (optional)" 4
.el .IP "\f(CWcache: BlockdevCacheOptions (optional)" 4
.IX Item "cache: BlockdevCacheOptions (optional)"
cache-related options
.ie n .IP """read-only: boolean"" (optional)" 4
.el .IP "\f(CWread-only: boolean (optional)" 4
.IX Item "read-only: boolean (optional)"
whether the block device should be read-only (default: false).
Note that some block drivers support only read-only access,
either generally or in certain configurations. In this case,
the default value does not work and the option must be
specified explicitly.
.ie n .IP """auto-read-only: boolean"" (optional)" 4
.el .IP "\f(CWauto-read-only: boolean (optional)" 4
.IX Item "auto-read-only: boolean (optional)"
if true and \f(CW`read-only\*(C' is false, \s-1QEMU\s0 may automatically
decide not to open the image read-write as requested, but
fall back to read-only instead (and switch between the modes
later), e.g. depending on whether the image file is writable
or whether a writing user is attached to the node
(default: false, since 3.1)
.ie n .IP """detect-zeroes: BlockdevDetectZeroesOptions"" (optional)" 4
.el .IP "\f(CWdetect-zeroes: BlockdevDetectZeroesOptions (optional)" 4
.IX Item "detect-zeroes: BlockdevDetectZeroesOptions (optional)"
detect and optimize zero writes (Since 2.1)
(default: off)
.ie n .IP """force-share: boolean"" (optional)" 4
.el .IP "\f(CWforce-share: boolean (optional)" 4
.IX Item "force-share: boolean (optional)"
force share all permission on added nodes.
Requires read-only=true. (Since 2.10)
.ie n .IP "The members of ""BlockdevOptionsBlkdebug"" when ""driver"" is ""blkdebug""" 4
.el .IP "The members of \f(CWBlockdevOptionsBlkdebug when \f(CWdriver is \`\`blkdebug''" 4
.IX Item "The members of BlockdevOptionsBlkdebug when driver is blkdebug"
.ie n .IP "The members of ""BlockdevOptionsBlklogwrites"" when ""driver"" is ""blklogwrites""" 4
.el .IP "The members of \f(CWBlockdevOptionsBlklogwrites when \f(CWdriver is \`\`blklogwrites''" 4
.IX Item "The members of BlockdevOptionsBlklogwrites when driver is blklogwrites"
.ie n .IP "The members of ""BlockdevOptionsBlkverify"" when ""driver"" is ""blkverify""" 4
.el .IP "The members of \f(CWBlockdevOptionsBlkverify when \f(CWdriver is \`\`blkverify''" 4
.IX Item "The members of BlockdevOptionsBlkverify when driver is blkverify"
.ie n .IP "The members of ""BlockdevOptionsGenericFormat"" when ""driver"" is ""bochs""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat when \f(CWdriver is \`\`bochs''" 4
.IX Item "The members of BlockdevOptionsGenericFormat when driver is bochs"
.ie n .IP "The members of ""BlockdevOptionsGenericFormat"" when ""driver"" is ""cloop""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat when \f(CWdriver is \`\`cloop''" 4
.IX Item "The members of BlockdevOptionsGenericFormat when driver is cloop"
.ie n .IP "The members of ""BlockdevOptionsGenericFormat"" when ""driver"" is ""copy-on-read""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat when \f(CWdriver is \`\`copy-on-read''" 4
.IX Item "The members of BlockdevOptionsGenericFormat when driver is copy-on-read"
.ie n .IP "The members of ""BlockdevOptionsGenericFormat"" when ""driver"" is ""dmg""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat when \f(CWdriver is \`\`dmg''" 4
.IX Item "The members of BlockdevOptionsGenericFormat when driver is dmg"
.ie n .IP "The members of ""BlockdevOptionsFile"" when ""driver"" is ""file""" 4
.el .IP "The members of \f(CWBlockdevOptionsFile when \f(CWdriver is \`\`file''" 4
.IX Item "The members of BlockdevOptionsFile when driver is file"
.ie n .IP "The members of ""BlockdevOptionsCurlFtp"" when ""driver"" is ""ftp""" 4
.el .IP "The members of \f(CWBlockdevOptionsCurlFtp when \f(CWdriver is \`\`ftp''" 4
.IX Item "The members of BlockdevOptionsCurlFtp when driver is ftp"
.ie n .IP "The members of ""BlockdevOptionsCurlFtps"" when ""driver"" is ""ftps""" 4
.el .IP "The members of \f(CWBlockdevOptionsCurlFtps when \f(CWdriver is \`\`ftps''" 4
.IX Item "The members of BlockdevOptionsCurlFtps when driver is ftps"
.ie n .IP "The members of ""BlockdevOptionsGluster"" when ""driver"" is ""gluster""" 4
.el .IP "The members of \f(CWBlockdevOptionsGluster when \f(CWdriver is \`\`gluster''" 4
.IX Item "The members of BlockdevOptionsGluster when driver is gluster"
.ie n .IP "The members of ""BlockdevOptionsFile"" when ""driver"" is ""host_cdrom""" 4
.el .IP "The members of \f(CWBlockdevOptionsFile when \f(CWdriver is \`\`host_cdrom''" 4
.IX Item "The members of BlockdevOptionsFile when driver is host_cdrom"
.ie n .IP "The members of ""BlockdevOptionsFile"" when ""driver"" is ""host_device""" 4
.el .IP "The members of \f(CWBlockdevOptionsFile when \f(CWdriver is \`\`host_device''" 4
.IX Item "The members of BlockdevOptionsFile when driver is host_device"
.ie n .IP "The members of ""BlockdevOptionsCurlHttp"" when ""driver"" is ""http""" 4
.el .IP "The members of \f(CWBlockdevOptionsCurlHttp when \f(CWdriver is \`\`http''" 4
.IX Item "The members of BlockdevOptionsCurlHttp when driver is http"
.ie n .IP "The members of ""BlockdevOptionsCurlHttps"" when ""driver"" is ""https""" 4
.el .IP "The members of \f(CWBlockdevOptionsCurlHttps when \f(CWdriver is \`\`https''" 4
.IX Item "The members of BlockdevOptionsCurlHttps when driver is https"
.ie n .IP "The members of ""BlockdevOptionsIscsi"" when ""driver"" is ""iscsi""" 4
.el .IP "The members of \f(CWBlockdevOptionsIscsi when \f(CWdriver is \`\`iscsi''" 4
.IX Item "The members of BlockdevOptionsIscsi when driver is iscsi"
.ie n .IP "The members of ""BlockdevOptionsLUKS"" when ""driver"" is ""luks""" 4
.el .IP "The members of \f(CWBlockdevOptionsLUKS when \f(CWdriver is \`\`luks''" 4
.IX Item "The members of BlockdevOptionsLUKS when driver is luks"
.ie n .IP "The members of ""BlockdevOptionsNbd"" when ""driver"" is ""nbd""" 4
.el .IP "The members of \f(CWBlockdevOptionsNbd when \f(CWdriver is \`\`nbd''" 4
.IX Item "The members of BlockdevOptionsNbd when driver is nbd"
.ie n .IP "The members of ""BlockdevOptionsNfs"" when ""driver"" is ""nfs""" 4
.el .IP "The members of \f(CWBlockdevOptionsNfs when \f(CWdriver is \`\`nfs''" 4
.IX Item "The members of BlockdevOptionsNfs when driver is nfs"
.ie n .IP "The members of ""BlockdevOptionsNull"" when ""driver"" is ""null-aio""" 4
.el .IP "The members of \f(CWBlockdevOptionsNull when \f(CWdriver is \`\`null-aio''" 4
.IX Item "The members of BlockdevOptionsNull when driver is null-aio"
.ie n .IP "The members of ""BlockdevOptionsNull"" when ""driver"" is ""null-co""" 4
.el .IP "The members of \f(CWBlockdevOptionsNull when \f(CWdriver is \`\`null-co''" 4
.IX Item "The members of BlockdevOptionsNull when driver is null-co"
.ie n .IP "The members of ""BlockdevOptionsNVMe"" when ""driver"" is ""nvme""" 4
.el .IP "The members of \f(CWBlockdevOptionsNVMe when \f(CWdriver is \`\`nvme''" 4
.IX Item "The members of BlockdevOptionsNVMe when driver is nvme"
.ie n .IP "The members of ""BlockdevOptionsGenericFormat"" when ""driver"" is ""parallels""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat when \f(CWdriver is \`\`parallels''" 4
.IX Item "The members of BlockdevOptionsGenericFormat when driver is parallels"
.ie n .IP "The members of ""BlockdevOptionsQcow2"" when ""driver"" is ""qcow2""" 4
.el .IP "The members of \f(CWBlockdevOptionsQcow2 when \f(CWdriver is \`\`qcow2''" 4
.IX Item "The members of BlockdevOptionsQcow2 when driver is qcow2"
.ie n .IP "The members of ""BlockdevOptionsQcow"" when ""driver"" is ""qcow""" 4
.el .IP "The members of \f(CWBlockdevOptionsQcow when \f(CWdriver is \`\`qcow''" 4
.IX Item "The members of BlockdevOptionsQcow when driver is qcow"
.ie n .IP "The members of ""BlockdevOptionsGenericCOWFormat"" when ""driver"" is ""qed""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericCOWFormat when \f(CWdriver is \`\`qed''" 4
.IX Item "The members of BlockdevOptionsGenericCOWFormat when driver is qed"
.ie n .IP "The members of ""BlockdevOptionsQuorum"" when ""driver"" is ""quorum""" 4
.el .IP "The members of \f(CWBlockdevOptionsQuorum when \f(CWdriver is \`\`quorum''" 4
.IX Item "The members of BlockdevOptionsQuorum when driver is quorum"
.ie n .IP "The members of ""BlockdevOptionsRaw"" when ""driver"" is ""raw""" 4
.el .IP "The members of \f(CWBlockdevOptionsRaw when \f(CWdriver is \`\`raw''" 4
.IX Item "The members of BlockdevOptionsRaw when driver is raw"
.ie n .IP "The members of ""BlockdevOptionsRbd"" when ""driver"" is ""rbd""" 4
.el .IP "The members of \f(CWBlockdevOptionsRbd when \f(CWdriver is \`\`rbd''" 4
.IX Item "The members of BlockdevOptionsRbd when driver is rbd"
.ie n .IP "The members of ""BlockdevOptionsReplication"" when ""driver"" is ""replication""" 4
.el .IP "The members of \f(CWBlockdevOptionsReplication when \f(CWdriver is \`\`replication''" 4
.IX Item "The members of BlockdevOptionsReplication when driver is replication"
.ie n .IP "The members of ""BlockdevOptionsSheepdog"" when ""driver"" is ""sheepdog""" 4
.el .IP "The members of \f(CWBlockdevOptionsSheepdog when \f(CWdriver is \`\`sheepdog''" 4
.IX Item "The members of BlockdevOptionsSheepdog when driver is sheepdog"
.ie n .IP "The members of ""BlockdevOptionsSsh"" when ""driver"" is ""ssh""" 4
.el .IP "The members of \f(CWBlockdevOptionsSsh when \f(CWdriver is \`\`ssh''" 4
.IX Item "The members of BlockdevOptionsSsh when driver is ssh"
.ie n .IP "The members of ""BlockdevOptionsThrottle"" when ""driver"" is ""throttle""" 4
.el .IP "The members of \f(CWBlockdevOptionsThrottle when \f(CWdriver is \`\`throttle''" 4
.IX Item "The members of BlockdevOptionsThrottle when driver is throttle"
.ie n .IP "The members of ""BlockdevOptionsGenericFormat"" when ""driver"" is ""vdi""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat when \f(CWdriver is \`\`vdi''" 4
.IX Item "The members of BlockdevOptionsGenericFormat when driver is vdi"
.ie n .IP "The members of ""BlockdevOptionsGenericFormat"" when ""driver"" is ""vhdx""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat when \f(CWdriver is \`\`vhdx''" 4
.IX Item "The members of BlockdevOptionsGenericFormat when driver is vhdx"
.ie n .IP "The members of ""BlockdevOptionsGenericCOWFormat"" when ""driver"" is ""vmdk""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericCOWFormat when \f(CWdriver is \`\`vmdk''" 4
.IX Item "The members of BlockdevOptionsGenericCOWFormat when driver is vmdk"
.ie n .IP "The members of ""BlockdevOptionsGenericFormat"" when ""driver"" is ""vpc""" 4
.el .IP "The members of \f(CWBlockdevOptionsGenericFormat when \f(CWdriver is \`\`vpc''" 4
.IX Item "The members of BlockdevOptionsGenericFormat when driver is vpc"
.ie n .IP "The members of ""BlockdevOptionsVVFAT"" when ""driver"" is ""vvfat""" 4
.el .IP "The members of \f(CWBlockdevOptionsVVFAT when \f(CWdriver is \`\`vvfat''" 4
.IX Item "The members of BlockdevOptionsVVFAT when driver is vvfat"
.ie n .IP "The members of ""BlockdevOptionsVxHS"" when ""driver"" is ""vxhs""" 4
.el .IP "The members of \f(CWBlockdevOptionsVxHS when \f(CWdriver is \`\`vxhs''" 4
.IX Item "The members of BlockdevOptionsVxHS when driver is vxhs"

Remaining options are determined by the block driver.

**Since:**
2.9

**BlockdevRef** (Alternate)

Reference to a block device.

**Members:**
.ie n .IP """definition: BlockdevOptions""" 4
.el .IP "\f(CWdefinition: BlockdevOptions" 4
.IX Item "definition: BlockdevOptions"
defines a new block device inline
.ie n .IP """reference: string""" 4
.el .IP "\f(CWreference: string" 4
.IX Item "reference: string"
references the \s-1ID\s0 of an existing block device

**Since:**
2.9

**BlockdevRefOrNull** (Alternate)

Reference to a block device.

**Members:**
.ie n .IP """definition: BlockdevOptions""" 4
.el .IP "\f(CWdefinition: BlockdevOptions" 4
.IX Item "definition: BlockdevOptions"
defines a new block device inline
.ie n .IP """reference: string""" 4
.el .IP "\f(CWreference: string" 4
.IX Item "reference: string"
references the \s-1ID\s0 of an existing block device.
An empty string means that no block device should
be referenced.  Deprecated; use null instead.
.ie n .IP """null: null""" 4
.el .IP "\f(CWnull: null" 4
.IX Item "null: null"
No block device should be referenced (since 2.10)

**Since:**
2.9

**blockdev-add**  (Command)
Creates a new block device. If the \f(CW`id\*(C' option is given at the top level, a
BlockBackend will be created; otherwise, \f(CW`node-name\*(C' is mandatory at the top
level and no BlockBackend will be created.

**Arguments:** the members of \f(CW`BlockdevOptions\*(C'

**Since:**
2.9

**Example:**

.Vb 12
        1.
        -&gt; { "execute": "blockdev-add",
             "arguments": {
                  "driver": "qcow2",
                  "node-name": "test1",
                  "file": {
                      "driver": "file",
                      "filename": "test.qcow2"
                   }
              }
            }
        &lt;- { "return": {} }
        
        2.
        -&gt; { "execute": "blockdev-add",
             "arguments": {
                  "driver": "qcow2",
                  "node-name": "node0",
                  "discard": "unmap",
                  "cache": {
                     "direct": true
                   },
                   "file": {
                     "driver": "file",
                     "filename": "/tmp/test.qcow2"
                   },
                   "backing": {
                      "driver": "raw",
                      "file": {
                         "driver": "file",
                         "filename": "/dev/fdset/4"
                       }
                   }
               }
             }
        
        &lt;- { "return": {} }
.Ve

**blockdev-del**  (Command)
Deletes a block device that has been added using blockdev-add.
The command will fail if the node is attached to a device or is
otherwise being used.

**Arguments:**
.ie n .IP """node-name: string""" 4
.el .IP "\f(CWnode-name: string" 4
.IX Item "node-name: string"
Name of the graph node to delete.

**Since:**
2.9

**Example:**

.Vb 11
        -&gt; { "execute": "blockdev-add",
             "arguments": {
                  "driver": "qcow2",
                  "node-name": "node0",
                  "file": {
                      "driver": "file",
                      "filename": "test.qcow2"
                  }
             }
           }
        &lt;- { "return": {} }
        
        -&gt; { "execute": "blockdev-del",
             "arguments": { "node-name": "node0" }
           }
        &lt;- { "return": {} }
.Ve

**BlockdevCreateOptionsFile** (Object)

Driver specific image creation options for file.

\f(CW`filename\*(C'         Filename for the new image file
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`preallocation\*(C'    Preallocation mode for the new image (default: off)
\f(CW`nocow\*(C'            Turn off copy-on-write (valid only on btrfs; default: off)

**Members:**
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """preallocation: PreallocMode"" (optional)" 4
.el .IP "\f(CWpreallocation: PreallocMode (optional)" 4
.IX Item "preallocation: PreallocMode (optional)"
Not documented
.ie n .IP """nocow: boolean"" (optional)" 4
.el .IP "\f(CWnocow: boolean (optional)" 4
.IX Item "nocow: boolean (optional)"
Not documented

**Since:**
2.12

**BlockdevCreateOptionsGluster** (Object)

Driver specific image creation options for gluster.

\f(CW`location\*(C'         Where to store the new image file
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`preallocation\*(C'    Preallocation mode for the new image (default: off)

**Members:**
.ie n .IP """location: BlockdevOptionsGluster""" 4
.el .IP "\f(CWlocation: BlockdevOptionsGluster" 4
.IX Item "location: BlockdevOptionsGluster"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """preallocation: PreallocMode"" (optional)" 4
.el .IP "\f(CWpreallocation: PreallocMode (optional)" 4
.IX Item "preallocation: PreallocMode (optional)"
Not documented

**Since:**
2.12

**BlockdevCreateOptionsLUKS** (Object)

Driver specific image creation options for \s-1LUKS.\s0

\f(CW`file\*(C'             Node to create the image format on
\f(CW`size\*(C'             Size of the virtual disk in bytes

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP "The members of ""QCryptoBlockCreateOptionsLUKS""" 4
.el .IP "The members of \f(CWQCryptoBlockCreateOptionsLUKS" 4
.IX Item "The members of QCryptoBlockCreateOptionsLUKS"

**Since:**
2.12

**BlockdevCreateOptionsNfs** (Object)

Driver specific image creation options for \s-1NFS.\s0

\f(CW`location\*(C'         Where to store the new image file
\f(CW`size\*(C'             Size of the virtual disk in bytes

**Members:**
.ie n .IP """location: BlockdevOptionsNfs""" 4
.el .IP "\f(CWlocation: BlockdevOptionsNfs" 4
.IX Item "location: BlockdevOptionsNfs"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented

**Since:**
2.12

**BlockdevCreateOptionsParallels** (Object)

Driver specific image creation options for parallels.

\f(CW`file\*(C'             Node to create the image format on
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`cluster-size\*(C'     Cluster size in bytes (default: 1 \s-1MB\s0)

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """cluster-size: int"" (optional)" 4
.el .IP "\f(CWcluster-size: int (optional)" 4
.IX Item "cluster-size: int (optional)"
Not documented

**Since:**
2.12

**BlockdevCreateOptionsQcow** (Object)

Driver specific image creation options for qcow.

\f(CW`file\*(C'             Node to create the image format on
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`backing-file\*(C'     File name of the backing file if a backing file
should be used
\f(CW`encrypt\*(C'          Encryption options if the image should be encrypted

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """backing-file: string"" (optional)" 4
.el .IP "\f(CWbacking-file: string (optional)" 4
.IX Item "backing-file: string (optional)"
Not documented
.ie n .IP """encrypt: QCryptoBlockCreateOptions"" (optional)" 4
.el .IP "\f(CWencrypt: QCryptoBlockCreateOptions (optional)" 4
.IX Item "encrypt: QCryptoBlockCreateOptions (optional)"
Not documented

**Since:**
2.12

**BlockdevQcow2Version** (Enum)

**Values:**
.ie n .IP """v2""" 4
.el .IP "\f(CWv2" 4
.IX Item "v2"
The original \s-1QCOW2\s0 format as introduced in qemu 0.10 (version 2)
.ie n .IP """v3""" 4
.el .IP "\f(CWv3" 4
.IX Item "v3"
The extended \s-1QCOW2\s0 format as introduced in qemu 1.1 (version 3)

**Since:**
2.12

**BlockdevCreateOptionsQcow2** (Object)

Driver specific image creation options for qcow2.

\f(CW`file\*(C'             Node to create the image format on
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`version\*(C'          Compatibility level (default: v3)
\f(CW`backing-file\*(C'     File name of the backing file if a backing file
should be used
\f(CW`backing-fmt\*(C'      Name of the block driver to use for the backing file
\f(CW`encrypt\*(C'          Encryption options if the image should be encrypted
\f(CW`cluster-size\*(C'     qcow2 cluster size in bytes (default: 65536)
\f(CW`preallocation\*(C'    Preallocation mode for the new image (default: off)
\f(CW`lazy-refcounts\*(C'   True if refcounts may be updated lazily (default: off)
\f(CW`refcount-bits\*(C'    Width of reference counts in bits (default: 16)

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """version: BlockdevQcow2Version"" (optional)" 4
.el .IP "\f(CWversion: BlockdevQcow2Version (optional)" 4
.IX Item "version: BlockdevQcow2Version (optional)"
Not documented
.ie n .IP """backing-file: string"" (optional)" 4
.el .IP "\f(CWbacking-file: string (optional)" 4
.IX Item "backing-file: string (optional)"
Not documented
.ie n .IP """backing-fmt: BlockdevDriver"" (optional)" 4
.el .IP "\f(CWbacking-fmt: BlockdevDriver (optional)" 4
.IX Item "backing-fmt: BlockdevDriver (optional)"
Not documented
.ie n .IP """encrypt: QCryptoBlockCreateOptions"" (optional)" 4
.el .IP "\f(CWencrypt: QCryptoBlockCreateOptions (optional)" 4
.IX Item "encrypt: QCryptoBlockCreateOptions (optional)"
Not documented
.ie n .IP """cluster-size: int"" (optional)" 4
.el .IP "\f(CWcluster-size: int (optional)" 4
.IX Item "cluster-size: int (optional)"
Not documented
.ie n .IP """preallocation: PreallocMode"" (optional)" 4
.el .IP "\f(CWpreallocation: PreallocMode (optional)" 4
.IX Item "preallocation: PreallocMode (optional)"
Not documented
.ie n .IP """lazy-refcounts: boolean"" (optional)" 4
.el .IP "\f(CWlazy-refcounts: boolean (optional)" 4
.IX Item "lazy-refcounts: boolean (optional)"
Not documented
.ie n .IP """refcount-bits: int"" (optional)" 4
.el .IP "\f(CWrefcount-bits: int (optional)" 4
.IX Item "refcount-bits: int (optional)"
Not documented

**Since:**
2.12

**BlockdevCreateOptionsQed** (Object)

Driver specific image creation options for qed.

\f(CW`file\*(C'             Node to create the image format on
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`backing-file\*(C'     File name of the backing file if a backing file
should be used
\f(CW`backing-fmt\*(C'      Name of the block driver to use for the backing file
\f(CW`cluster-size\*(C'     Cluster size in bytes (default: 65536)
\f(CW`table-size\*(C'       L1/L2 table size (in clusters)

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """backing-file: string"" (optional)" 4
.el .IP "\f(CWbacking-file: string (optional)" 4
.IX Item "backing-file: string (optional)"
Not documented
.ie n .IP """backing-fmt: BlockdevDriver"" (optional)" 4
.el .IP "\f(CWbacking-fmt: BlockdevDriver (optional)" 4
.IX Item "backing-fmt: BlockdevDriver (optional)"
Not documented
.ie n .IP """cluster-size: int"" (optional)" 4
.el .IP "\f(CWcluster-size: int (optional)" 4
.IX Item "cluster-size: int (optional)"
Not documented
.ie n .IP """table-size: int"" (optional)" 4
.el .IP "\f(CWtable-size: int (optional)" 4
.IX Item "table-size: int (optional)"
Not documented

**Since:**
2.12

**BlockdevCreateOptionsRbd** (Object)

Driver specific image creation options for rbd/Ceph.

\f(CW`location\*(C'         Where to store the new image file. This location cannot
point to a snapshot.
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`cluster-size\*(C'     \s-1RBD\s0 object size

**Members:**
.ie n .IP """location: BlockdevOptionsRbd""" 4
.el .IP "\f(CWlocation: BlockdevOptionsRbd" 4
.IX Item "location: BlockdevOptionsRbd"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """cluster-size: int"" (optional)" 4
.el .IP "\f(CWcluster-size: int (optional)" 4
.IX Item "cluster-size: int (optional)"
Not documented

**Since:**
2.12

**SheepdogRedundancyType** (Enum)

\f(CW`full\*(C'             Create a fully replicated vdi with x copies
\f(CW`erasure-coded\*(C'    Create an erasure coded vdi with x data strips and
y parity strips

**Values:**
.ie n .IP """full""" 4
.el .IP "\f(CWfull" 4
.IX Item "full"
Not documented
.ie n .IP """erasure-coded""" 4
.el .IP "\f(CWerasure-coded" 4
.IX Item "erasure-coded"
Not documented

**Since:**
2.12

**SheepdogRedundancyFull** (Object)

\f(CW`copies\*(C'           Number of copies to use (between 1 and 31)

**Members:**
.ie n .IP """copies: int""" 4
.el .IP "\f(CWcopies: int" 4
.IX Item "copies: int"
Not documented

**Since:**
2.12

**SheepdogRedundancyErasureCoded** (Object)

\f(CW`data-strips\*(C'      Number of data strips to use (one of {2,4,8,16})
\f(CW`parity-strips\*(C'    Number of parity strips to use (between 1 and 15)

**Members:**
.ie n .IP """data-strips: int""" 4
.el .IP "\f(CWdata-strips: int" 4
.IX Item "data-strips: int"
Not documented
.ie n .IP """parity-strips: int""" 4
.el .IP "\f(CWparity-strips: int" 4
.IX Item "parity-strips: int"
Not documented

**Since:**
2.12

**SheepdogRedundancy** (Object)

**Members:**
.ie n .IP """type: SheepdogRedundancyType""" 4
.el .IP "\f(CWtype: SheepdogRedundancyType" 4
.IX Item "type: SheepdogRedundancyType"
Not documented
.ie n .IP "The members of ""SheepdogRedundancyFull"" when ""type"" is ""full""" 4
.el .IP "The members of \f(CWSheepdogRedundancyFull when \f(CWtype is \`\`full''" 4
.IX Item "The members of SheepdogRedundancyFull when type is full"
.ie n .IP "The members of ""SheepdogRedundancyErasureCoded"" when ""type"" is ""erasure-coded""" 4
.el .IP "The members of \f(CWSheepdogRedundancyErasureCoded when \f(CWtype is \`\`erasure-coded''" 4
.IX Item "The members of SheepdogRedundancyErasureCoded when type is erasure-coded"

**Since:**
2.12

**BlockdevCreateOptionsSheepdog** (Object)

Driver specific image creation options for Sheepdog.

\f(CW`location\*(C'         Where to store the new image file
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`backing-file\*(C'     File name of a base image
\f(CW`preallocation\*(C'    Preallocation mode (allowed values: off, full)
\f(CW`redundancy\*(C'       Redundancy of the image
\f(CW`object-size\*(C'      Object size of the image

**Members:**
.ie n .IP """location: BlockdevOptionsSheepdog""" 4
.el .IP "\f(CWlocation: BlockdevOptionsSheepdog" 4
.IX Item "location: BlockdevOptionsSheepdog"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """backing-file: string"" (optional)" 4
.el .IP "\f(CWbacking-file: string (optional)" 4
.IX Item "backing-file: string (optional)"
Not documented
.ie n .IP """preallocation: PreallocMode"" (optional)" 4
.el .IP "\f(CWpreallocation: PreallocMode (optional)" 4
.IX Item "preallocation: PreallocMode (optional)"
Not documented
.ie n .IP """redundancy: SheepdogRedundancy"" (optional)" 4
.el .IP "\f(CWredundancy: SheepdogRedundancy (optional)" 4
.IX Item "redundancy: SheepdogRedundancy (optional)"
Not documented
.ie n .IP """object-size: int"" (optional)" 4
.el .IP "\f(CWobject-size: int (optional)" 4
.IX Item "object-size: int (optional)"
Not documented

**Since:**
2.12

**BlockdevCreateOptionsSsh** (Object)

Driver specific image creation options for \s-1SSH.\s0

\f(CW`location\*(C'         Where to store the new image file
\f(CW`size\*(C'             Size of the virtual disk in bytes

**Members:**
.ie n .IP """location: BlockdevOptionsSsh""" 4
.el .IP "\f(CWlocation: BlockdevOptionsSsh" 4
.IX Item "location: BlockdevOptionsSsh"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented

**Since:**
2.12

**BlockdevCreateOptionsVdi** (Object)

Driver specific image creation options for \s-1VDI.\s0

\f(CW`file\*(C'             Node to create the image format on
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`preallocation\*(C'    Preallocation mode for the new image (allowed values: off,
metadata; default: off)

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """preallocation: PreallocMode"" (optional)" 4
.el .IP "\f(CWpreallocation: PreallocMode (optional)" 4
.IX Item "preallocation: PreallocMode (optional)"
Not documented

**Since:**
2.12

**BlockdevVhdxSubformat** (Enum)

**Values:**
.ie n .IP """dynamic""" 4
.el .IP "\f(CWdynamic" 4
.IX Item "dynamic"
Growing image file
.ie n .IP """fixed""" 4
.el .IP "\f(CWfixed" 4
.IX Item "fixed"
Preallocated fixed-size image file

**Since:**
2.12

**BlockdevCreateOptionsVhdx** (Object)

Driver specific image creation options for vhdx.

\f(CW`file\*(C'             Node to create the image format on
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`log-size\*(C'         Log size in bytes, must be a multiple of 1 \s-1MB\s0
(default: 1 \s-1MB\s0)
\f(CW`block-size\*(C'       Block size in bytes, must be a multiple of 1 \s-1MB\s0 and not
larger than 256 \s-1MB\s0 (default: automatically choose a block
size depending on the image size)
\f(CW`subformat\*(C'        vhdx subformat (default: dynamic)
\f(CW`block-state-zero\*(C' Force use of payload blocks of type '\s-1ZERO\s0'. Non-standard,
but default.  Do not set to 'off' when using 'qemu-img
convert' with subformat=dynamic.

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """log-size: int"" (optional)" 4
.el .IP "\f(CWlog-size: int (optional)" 4
.IX Item "log-size: int (optional)"
Not documented
.ie n .IP """block-size: int"" (optional)" 4
.el .IP "\f(CWblock-size: int (optional)" 4
.IX Item "block-size: int (optional)"
Not documented
.ie n .IP """subformat: BlockdevVhdxSubformat"" (optional)" 4
.el .IP "\f(CWsubformat: BlockdevVhdxSubformat (optional)" 4
.IX Item "subformat: BlockdevVhdxSubformat (optional)"
Not documented
.ie n .IP """block-state-zero: boolean"" (optional)" 4
.el .IP "\f(CWblock-state-zero: boolean (optional)" 4
.IX Item "block-state-zero: boolean (optional)"
Not documented

**Since:**
2.12

**BlockdevVpcSubformat** (Enum)

**Values:**
.ie n .IP """dynamic""" 4
.el .IP "\f(CWdynamic" 4
.IX Item "dynamic"
Growing image file
.ie n .IP """fixed""" 4
.el .IP "\f(CWfixed" 4
.IX Item "fixed"
Preallocated fixed-size image file

**Since:**
2.12

**BlockdevCreateOptionsVpc** (Object)

Driver specific image creation options for vpc (\s-1VHD\s0).

\f(CW`file\*(C'             Node to create the image format on
\f(CW`size\*(C'             Size of the virtual disk in bytes
\f(CW`subformat\*(C'        vhdx subformat (default: dynamic)
\f(CW`force-size\*(C'       Force use of the exact byte size instead of rounding to the
next size that can be represented in \s-1CHS\s0 geometry
(default: false)

**Members:**
.ie n .IP """file: BlockdevRef""" 4
.el .IP "\f(CWfile: BlockdevRef" 4
.IX Item "file: BlockdevRef"
Not documented
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
Not documented
.ie n .IP """subformat: BlockdevVpcSubformat"" (optional)" 4
.el .IP "\f(CWsubformat: BlockdevVpcSubformat (optional)" 4
.IX Item "subformat: BlockdevVpcSubformat (optional)"
Not documented
.ie n .IP """force-size: boolean"" (optional)" 4
.el .IP "\f(CWforce-size: boolean (optional)" 4
.IX Item "force-size: boolean (optional)"
Not documented

**Since:**
2.12

**BlockdevCreateOptions** (Object)

Options for creating an image format on a given node.

\f(CW`driver\*(C'           block driver to create the image format

**Members:**
.ie n .IP """driver: BlockdevDriver""" 4
.el .IP "\f(CWdriver: BlockdevDriver" 4
.IX Item "driver: BlockdevDriver"
Not documented
.ie n .IP "The members of ""BlockdevCreateOptionsFile"" when ""driver"" is ""file""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsFile when \f(CWdriver is \`\`file''" 4
.IX Item "The members of BlockdevCreateOptionsFile when driver is file"
.ie n .IP "The members of ""BlockdevCreateOptionsGluster"" when ""driver"" is ""gluster""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsGluster when \f(CWdriver is \`\`gluster''" 4
.IX Item "The members of BlockdevCreateOptionsGluster when driver is gluster"
.ie n .IP "The members of ""BlockdevCreateOptionsLUKS"" when ""driver"" is ""luks""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsLUKS when \f(CWdriver is \`\`luks''" 4
.IX Item "The members of BlockdevCreateOptionsLUKS when driver is luks"
.ie n .IP "The members of ""BlockdevCreateOptionsNfs"" when ""driver"" is ""nfs""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsNfs when \f(CWdriver is \`\`nfs''" 4
.IX Item "The members of BlockdevCreateOptionsNfs when driver is nfs"
.ie n .IP "The members of ""BlockdevCreateOptionsParallels"" when ""driver"" is ""parallels""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsParallels when \f(CWdriver is \`\`parallels''" 4
.IX Item "The members of BlockdevCreateOptionsParallels when driver is parallels"
.ie n .IP "The members of ""BlockdevCreateOptionsQcow"" when ""driver"" is ""qcow""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsQcow when \f(CWdriver is \`\`qcow''" 4
.IX Item "The members of BlockdevCreateOptionsQcow when driver is qcow"
.ie n .IP "The members of ""BlockdevCreateOptionsQcow2"" when ""driver"" is ""qcow2""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsQcow2 when \f(CWdriver is \`\`qcow2''" 4
.IX Item "The members of BlockdevCreateOptionsQcow2 when driver is qcow2"
.ie n .IP "The members of ""BlockdevCreateOptionsQed"" when ""driver"" is ""qed""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsQed when \f(CWdriver is \`\`qed''" 4
.IX Item "The members of BlockdevCreateOptionsQed when driver is qed"
.ie n .IP "The members of ""BlockdevCreateOptionsRbd"" when ""driver"" is ""rbd""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsRbd when \f(CWdriver is \`\`rbd''" 4
.IX Item "The members of BlockdevCreateOptionsRbd when driver is rbd"
.ie n .IP "The members of ""BlockdevCreateOptionsSheepdog"" when ""driver"" is ""sheepdog""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsSheepdog when \f(CWdriver is \`\`sheepdog''" 4
.IX Item "The members of BlockdevCreateOptionsSheepdog when driver is sheepdog"
.ie n .IP "The members of ""BlockdevCreateOptionsSsh"" when ""driver"" is ""ssh""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsSsh when \f(CWdriver is \`\`ssh''" 4
.IX Item "The members of BlockdevCreateOptionsSsh when driver is ssh"
.ie n .IP "The members of ""BlockdevCreateOptionsVdi"" when ""driver"" is ""vdi""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsVdi when \f(CWdriver is \`\`vdi''" 4
.IX Item "The members of BlockdevCreateOptionsVdi when driver is vdi"
.ie n .IP "The members of ""BlockdevCreateOptionsVhdx"" when ""driver"" is ""vhdx""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsVhdx when \f(CWdriver is \`\`vhdx''" 4
.IX Item "The members of BlockdevCreateOptionsVhdx when driver is vhdx"
.ie n .IP "The members of ""BlockdevCreateOptionsVpc"" when ""driver"" is ""vpc""" 4
.el .IP "The members of \f(CWBlockdevCreateOptionsVpc when \f(CWdriver is \`\`vpc''" 4
.IX Item "The members of BlockdevCreateOptionsVpc when driver is vpc"

**Since:**
2.12

**blockdev-create**  (Command)
Starts a job to create an image format on a given node. The job is
automatically finalized, but a manual job-dismiss is required.

**Arguments:**
.ie n .IP """job-id: string""" 4
.el .IP "\f(CWjob-id: string" 4
.IX Item "job-id: string"
Identifier for the newly created job.
.ie n .IP """options: BlockdevCreateOptions""" 4
.el .IP "\f(CWoptions: BlockdevCreateOptions" 4
.IX Item "options: BlockdevCreateOptions"
Options for the image creation.

**Since:**
3.0

**blockdev-open-tray**  (Command)
Opens a block device's tray. If there is a block driver state tree inserted as
a medium, it will become inaccessible to the guest (but it will remain
associated to the block device, so closing the tray will make it accessible
again).

If the tray was already open before, this will be a no-op.

Once the tray opens, a \s-1DEVICE_TRAY_MOVED\s0 event is emitted. There are cases in
which no such event will be generated, these include:

* if the guest has locked the tray, \f(CW`force\*(C' is false and the guest does not
  respond to the eject request
* if the BlockBackend denoted by \f(CW`device\*(C' does not have a guest device attached
  to it
* if the guest device does not have an actual tray

**Arguments:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
Block device name (deprecated, use \f(CW`id\*(C' instead)
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
The name or \s-1QOM\s0 path of the guest device (since: 2.8)
.ie n .IP """force: boolean"" (optional)" 4
.el .IP "\f(CWforce: boolean (optional)" 4
.IX Item "force: boolean (optional)"
if false (the default), an eject request will be sent to
the guest if it has locked the tray (and the tray will not be opened
immediately); if true, the tray will be opened regardless of whether
it is locked

**Since:**
2.5

**Example:**

.Vb 2
        -&gt; { "execute": "blockdev-open-tray",
             "arguments": { "id": "ide0-1-0" } }
        
        &lt;- { "timestamp": { "seconds": 1418751016,
                            "microseconds": 716996 },
             "event": "DEVICE_TRAY_MOVED",
             "data": { "device": "ide1-cd0",
                       "id": "ide0-1-0",
                       "tray-open": true } }
        
        &lt;- { "return": {} }
.Ve

**blockdev-close-tray**  (Command)
Closes a block device's tray. If there is a block driver state tree associated
with the block device (which is currently ejected), that tree will be loaded
as the medium.

If the tray was already closed before, this will be a no-op.

**Arguments:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
Block device name (deprecated, use \f(CW`id\*(C' instead)
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
The name or \s-1QOM\s0 path of the guest device (since: 2.8)

**Since:**
2.5

**Example:**

.Vb 2
        -&gt; { "execute": "blockdev-close-tray",
             "arguments": { "id": "ide0-1-0" } }
        
        &lt;- { "timestamp": { "seconds": 1418751345,
                            "microseconds": 272147 },
             "event": "DEVICE_TRAY_MOVED",
             "data": { "device": "ide1-cd0",
                       "id": "ide0-1-0",
                       "tray-open": false } }
        
        &lt;- { "return": {} }
.Ve

**blockdev-remove-medium**  (Command)
Removes a medium (a block driver state tree) from a block device. That block
device's tray must currently be open (unless there is no attached guest
device).

If the tray is open and there is no medium inserted, this will be a no-op.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The name or \s-1QOM\s0 path of the guest device

**Since:**
2.12

**Example:**

.Vb 2
        -&gt; { "execute": "blockdev-remove-medium",
             "arguments": { "id": "ide0-1-0" } }
        
        &lt;- { "error": { "class": "GenericError",
                        "desc": "Tray of device ide0-1-0\*(Aq is not open" } }
        
        -&gt; { "execute": "blockdev-open-tray",
             "arguments": { "id": "ide0-1-0" } }
        
        &lt;- { "timestamp": { "seconds": 1418751627,
                            "microseconds": 549958 },
             "event": "DEVICE_TRAY_MOVED",
             "data": { "device": "ide1-cd0",
                       "id": "ide0-1-0",
                       "tray-open": true } }
        
        &lt;- { "return": {} }
        
        -&gt; { "execute": "blockdev-remove-medium",
             "arguments": { "id": "ide0-1-0" } }
        
        &lt;- { "return": {} }
.Ve

**blockdev-insert-medium**  (Command)
Inserts a medium (a block driver state tree) into a block device. That block
device's tray must currently be open (unless there is no attached guest
device) and there must be no medium inserted already.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The name or \s-1QOM\s0 path of the guest device
.ie n .IP """node-name: string""" 4
.el .IP "\f(CWnode-name: string" 4
.IX Item "node-name: string"
name of a node in the block driver state graph

**Since:**
2.12

**Example:**

.Vb 7
        -&gt; { "execute": "blockdev-add",
             "arguments": {
                 "node-name": "node0",
                 "driver": "raw",
                 "file": { "driver": "file",
                           "filename": "fedora.iso" } } }
        &lt;- { "return": {} }
        
        -&gt; { "execute": "blockdev-insert-medium",
             "arguments": { "id": "ide0-1-0",
                            "node-name": "node0" } }
        
        &lt;- { "return": {} }
.Ve

**BlockdevChangeReadOnlyMode** (Enum)

Specifies the new read-only mode of a block device subject to the
\f(CW`blockdev-change-medium\*(C' command.

**Values:**
.ie n .IP """retain""" 4
.el .IP "\f(CWretain" 4
.IX Item "retain"
Retains the current read-only mode
.ie n .IP """read-only""" 4
.el .IP "\f(CWread-only" 4
.IX Item "read-only"
Makes the device read-only
.ie n .IP """read-write""" 4
.el .IP "\f(CWread-write" 4
.IX Item "read-write"
Makes the device writable

**Since:**
2.3

**blockdev-change-medium**  (Command)
Changes the medium inserted into a block device by ejecting the current medium
and loading a new image file which is inserted as the new medium (this command
combines blockdev-open-tray, blockdev-remove-medium, blockdev-insert-medium
and blockdev-close-tray).

**Arguments:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
Block device name (deprecated, use \f(CW`id\*(C' instead)
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
The name or \s-1QOM\s0 path of the guest device
(since: 2.8)
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
filename of the new image to be loaded
.ie n .IP """format: string"" (optional)" 4
.el .IP "\f(CWformat: string (optional)" 4
.IX Item "format: string (optional)"
format to open the new image with (defaults to
the probed format)
.ie n .IP """read-only-mode: BlockdevChangeReadOnlyMode"" (optional)" 4
.el .IP "\f(CWread-only-mode: BlockdevChangeReadOnlyMode (optional)" 4
.IX Item "read-only-mode: BlockdevChangeReadOnlyMode (optional)"
change the read-only mode of the device; defaults
to 'retain'

**Since:**
2.5

**Examples:**

.Vb 1
        1. Change a removable medium
        
        -&gt; { "execute": "blockdev-change-medium",
             "arguments": { "id": "ide0-1-0",
                            "filename": "/srv/images/Fedora-12-x86_64-DVD.iso",
                            "format": "raw" } }
        &lt;- { "return": {} }
        
        2. Load a read-only medium into a writable drive
        
        -&gt; { "execute": "blockdev-change-medium",
             "arguments": { "id": "floppyA",
                            "filename": "/srv/images/ro.img",
                            "format": "raw",
                            "read-only-mode": "retain" } }
        
        &lt;- { "error":
             { "class": "GenericError",
               "desc": "Could not open /srv/images/ro.img\*(Aq: Permission denied" } }
        
        -&gt; { "execute": "blockdev-change-medium",
             "arguments": { "id": "floppyA",
                            "filename": "/srv/images/ro.img",
                            "format": "raw",
                            "read-only-mode": "read-only" } }
        
        &lt;- { "return": {} }
.Ve

**BlockErrorAction** (Enum)

An enumeration of action that has been taken when a \s-1DISK I/O\s0 occurs

**Values:**
.ie n .IP """ignore""" 4
.el .IP "\f(CWignore" 4
.IX Item "ignore"
error has been ignored
.ie n .IP """report""" 4
.el .IP "\f(CWreport" 4
.IX Item "report"
error has been reported to the device
.ie n .IP """stop""" 4
.el .IP "\f(CWstop" 4
.IX Item "stop"
error caused \s-1VM\s0 to be stopped

**Since:**
2.1

**\s-1BLOCK\_IMAGE\_CORRUPTED\s0**  (Event)
Emitted when a disk image is being marked corrupt. The image can be
identified by its device or node name. The 'device' field is always
present for compatibility reasons, but it can be empty ("") if the
image does not have a device name associated.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
device name. This is always present for compatibility
reasons, but it can be empty ("") if the image does not
have a device name associated.
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
node name (Since: 2.4)
.ie n .IP """msg: string""" 4
.el .IP "\f(CWmsg: string" 4
.IX Item "msg: string"
informative message for human consumption, such as the kind of
corruption being detected. It should not be parsed by machine as it is
not guaranteed to be stable
.ie n .IP """offset: int"" (optional)" 4
.el .IP "\f(CWoffset: int (optional)" 4
.IX Item "offset: int (optional)"
if the corruption resulted from an image access, this is
the host's access offset into the image
.ie n .IP """size: int"" (optional)" 4
.el .IP "\f(CWsize: int (optional)" 4
.IX Item "size: int (optional)"
if the corruption resulted from an image access, this is
the access size
.ie n .IP """fatal: boolean""" 4
.el .IP "\f(CWfatal: boolean" 4
.IX Item "fatal: boolean"
if set, the image is marked corrupt and therefore unusable after this
event and must be repaired (Since 2.2; before, every
\s-1BLOCK_IMAGE_CORRUPTED\s0 event was fatal)

**Note:**
If action is stop\*(R", a \s-1STOP\s0 event will eventually follow the
\s-1BLOCK_IO_ERROR\s0 event.

**Example:**

.Vb 5
        &lt;- { "event": "BLOCK_IMAGE_CORRUPTED",
             "data": { "device": "ide0-hd0", "node-name": "node0",
                       "msg": "Prevented active L1 table overwrite", "offset": 196608,
                       "size": 65536 },
             "timestamp": { "seconds": 1378126126, "microseconds": 966463 } }
.Ve

**Since:**
1.7

**\s-1BLOCK\_IO\_ERROR\s0**  (Event)
Emitted when a disk I/O error occurs

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
device name. This is always present for compatibility
reasons, but it can be empty ("") if the image does not
have a device name associated.
.ie n .IP """node-name: string"" (optional)" 4
.el .IP "\f(CWnode-name: string (optional)" 4
.IX Item "node-name: string (optional)"
node name. Note that errors may be reported for the root node
that is directly attached to a guest device rather than for the
node where the error occurred. The node name is not present if
the drive is empty. (Since: 2.8)
.ie n .IP """operation: IoOperationType""" 4
.el .IP "\f(CWoperation: IoOperationType" 4
.IX Item "operation: IoOperationType"
I/O operation
.ie n .IP """action: BlockErrorAction""" 4
.el .IP "\f(CWaction: BlockErrorAction" 4
.IX Item "action: BlockErrorAction"
action that has been taken
.ie n .IP """nospace: boolean"" (optional)" 4
.el .IP "\f(CWnospace: boolean (optional)" 4
.IX Item "nospace: boolean (optional)"
true if I/O error was caused due to a no-space
condition. This key is only present if query-block's
io-status is present, please see query-block documentation
for more information (since: 2.2)
.ie n .IP """reason: string""" 4
.el .IP "\f(CWreason: string" 4
.IX Item "reason: string"
human readable string describing the error cause.
(This field is a debugging aid for humans, it should not
be parsed by applications) (since: 2.2)

**Note:**
If action is stop\*(R", a \s-1STOP\s0 event will eventually follow the
\s-1BLOCK_IO_ERROR\s0 event

**Since:**
0.13.0

**Example:**

.Vb 6
        &lt;- { "event": "BLOCK_IO_ERROR",
             "data": { "device": "ide0-hd1",
                       "node-name": "#block212",
                       "operation": "write",
                       "action": "stop" },
             "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
.Ve

**\s-1BLOCK\_JOB\_COMPLETED\s0**  (Event)
Emitted when a block job has completed

**Arguments:**
.ie n .IP """type: JobType""" 4
.el .IP "\f(CWtype: JobType" 4
.IX Item "type: JobType"
job type
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. Originally the device name but other
values are allowed since \s-1QEMU 2.7\s0
.ie n .IP """len: int""" 4
.el .IP "\f(CWlen: int" 4
.IX Item "len: int"
maximum progress value
.ie n .IP """offset: int""" 4
.el .IP "\f(CWoffset: int" 4
.IX Item "offset: int"
current progress value. On success this is equal to len.
On failure this is less than len
.ie n .IP """speed: int""" 4
.el .IP "\f(CWspeed: int" 4
.IX Item "speed: int"
rate limit, bytes per second
.ie n .IP """error: string"" (optional)" 4
.el .IP "\f(CWerror: string (optional)" 4
.IX Item "error: string (optional)"
error message. Only present on failure. This field
contains a human-readable error message. There are no semantics
other than that streaming has failed and clients should not try to
interpret the error string

**Since:**
1.1

**Example:**

.Vb 5
        &lt;- { "event": "BLOCK_JOB_COMPLETED",
             "data": { "type": "stream", "device": "virtio-disk0",
                       "len": 10737418240, "offset": 10737418240,
                       "speed": 0 },
             "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
.Ve

**\s-1BLOCK\_JOB\_CANCELLED\s0**  (Event)
Emitted when a block job has been cancelled

**Arguments:**
.ie n .IP """type: JobType""" 4
.el .IP "\f(CWtype: JobType" 4
.IX Item "type: JobType"
job type
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. Originally the device name but other
values are allowed since \s-1QEMU 2.7\s0
.ie n .IP """len: int""" 4
.el .IP "\f(CWlen: int" 4
.IX Item "len: int"
maximum progress value
.ie n .IP """offset: int""" 4
.el .IP "\f(CWoffset: int" 4
.IX Item "offset: int"
current progress value. On success this is equal to len.
On failure this is less than len
.ie n .IP """speed: int""" 4
.el .IP "\f(CWspeed: int" 4
.IX Item "speed: int"
rate limit, bytes per second

**Since:**
1.1

**Example:**

.Vb 5
        &lt;- { "event": "BLOCK_JOB_CANCELLED",
             "data": { "type": "stream", "device": "virtio-disk0",
                       "len": 10737418240, "offset": 134217728,
                       "speed": 0 },
             "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
.Ve

**\s-1BLOCK\_JOB\_ERROR\s0**  (Event)
Emitted when a block job encounters an error

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. Originally the device name but other
values are allowed since \s-1QEMU 2.7\s0
.ie n .IP """operation: IoOperationType""" 4
.el .IP "\f(CWoperation: IoOperationType" 4
.IX Item "operation: IoOperationType"
I/O operation
.ie n .IP """action: BlockErrorAction""" 4
.el .IP "\f(CWaction: BlockErrorAction" 4
.IX Item "action: BlockErrorAction"
action that has been taken

**Since:**
1.3

**Example:**

.Vb 5
        &lt;- { "event": "BLOCK_JOB_ERROR",
             "data": { "device": "ide0-hd1",
                       "operation": "write",
                       "action": "stop" },
             "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
.Ve

**\s-1BLOCK\_JOB\_READY\s0**  (Event)
Emitted when a block job is ready to complete

**Arguments:**
.ie n .IP """type: JobType""" 4
.el .IP "\f(CWtype: JobType" 4
.IX Item "type: JobType"
job type
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The job identifier. Originally the device name but other
values are allowed since \s-1QEMU 2.7\s0
.ie n .IP """len: int""" 4
.el .IP "\f(CWlen: int" 4
.IX Item "len: int"
maximum progress value
.ie n .IP """offset: int""" 4
.el .IP "\f(CWoffset: int" 4
.IX Item "offset: int"
current progress value. On success this is equal to len.
On failure this is less than len
.ie n .IP """speed: int""" 4
.el .IP "\f(CWspeed: int" 4
.IX Item "speed: int"
rate limit, bytes per second

**Note:**
The ready to complete\*(R" status is always reset by a \f(CW\*(C\`BLOCK\_JOB\_ERROR\*(C'
event

**Since:**
1.3

**Example:**

.Vb 4
        &lt;- { "event": "BLOCK_JOB_READY",
             "data": { "device": "drive0", "type": "mirror", "speed": 0,
                       "len": 2097152, "offset": 2097152 }
             "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
.Ve

**\s-1BLOCK\_JOB\_PENDING\s0**  (Event)
Emitted when a block job is awaiting explicit authorization to finalize graph
changes via \f(CW`block-job-finalize\*(C'. If this job is part of a transaction, it will
not emit this event until the transaction has converged first.

**Arguments:**
.ie n .IP """type: JobType""" 4
.el .IP "\f(CWtype: JobType" 4
.IX Item "type: JobType"
job type
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The job identifier.

**Since:**
2.12

**Example:**

.Vb 3
        &lt;- { "event": "BLOCK_JOB_WAITING",
             "data": { "device": "drive0", "type": "mirror" },
             "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
.Ve

**PreallocMode** (Enum)

Preallocation mode of \s-1QEMU\s0 image file

**Values:**
.ie n .IP """off""" 4
.el .IP "\f(CWoff" 4
.IX Item "off"
no preallocation
.ie n .IP """metadata""" 4
.el .IP "\f(CWmetadata" 4
.IX Item "metadata"
preallocate only for metadata
.ie n .IP """falloc""" 4
.el .IP "\f(CWfalloc" 4
.IX Item "falloc"
like \f(CW`full\*(C' preallocation but allocate disk space by
**posix\_fallocate()** rather than writing zeros.
.ie n .IP """full""" 4
.el .IP "\f(CWfull" 4
.IX Item "full"
preallocate all data by writing zeros to device to ensure disk
space is really available. \f(CW`full\*(C' preallocation also sets up
metadata correctly.

**Since:**
2.2

**\s-1BLOCK\_WRITE\_THRESHOLD\s0**  (Event)
Emitted when writes on block device reaches or exceeds the
configured write threshold. For thin-provisioned devices, this
means the device should be extended to avoid pausing for
disk exhaustion.
The event is one shot. Once triggered, it needs to be
re-registered with another block-set-write-threshold command.

**Arguments:**
.ie n .IP """node-name: string""" 4
.el .IP "\f(CWnode-name: string" 4
.IX Item "node-name: string"
graph node name on which the threshold was exceeded.
.ie n .IP """amount-exceeded: int""" 4
.el .IP "\f(CWamount-exceeded: int" 4
.IX Item "amount-exceeded: int"
amount of data which exceeded the threshold, in bytes.
.ie n .IP """write-threshold: int""" 4
.el .IP "\f(CWwrite-threshold: int" 4
.IX Item "write-threshold: int"
last configured threshold, in bytes.

**Since:**
2.3

**block-set-write-threshold**  (Command)
Change the write threshold for a block drive. An event will be
delivered if a write to this block drive crosses the configured
threshold.  The threshold is an offset, thus must be
non-negative. Default is no write threshold. Setting the threshold
to zero disables it.

This is useful to transparently resize thin-provisioned drives without
the guest \s-1OS\s0 noticing.

**Arguments:**
.ie n .IP """node-name: string""" 4
.el .IP "\f(CWnode-name: string" 4
.IX Item "node-name: string"
graph node name on which the threshold must be set.
.ie n .IP """write-threshold: int""" 4
.el .IP "\f(CWwrite-threshold: int" 4
.IX Item "write-threshold: int"
configured threshold for the block device, bytes.
Use 0 to disable the threshold.

**Since:**
2.3

**Example:**

.Vb 4
        -&gt; { "execute": "block-set-write-threshold",
             "arguments": { "node-name": "mydev",
                            "write-threshold": 17179869184 } }
        &lt;- { "return": {} }
.Ve

**x-blockdev-change**  (Command)
Dynamically reconfigure the block driver state graph. It can be used
to add, remove, insert or replace a graph node. Currently only the
Quorum driver implements this feature to add or remove its child. This
is useful to fix a broken quorum child.

If \f(CW`node\*(C' is specified, it will be inserted under \f(CW\*(C\`parent\*(C'. \f(CW\*(C\`child\*(C'
may not be specified in this case. If both \f(CW`parent\*(C' and \f(CW\*(C\`child\*(C' are
specified but \f(CW`node\*(C' is not, \f(CW\*(C\`child\*(C' will be detached from \f(CW\*(C\`parent\*(C'.

**Arguments:**
.ie n .IP """parent: string""" 4
.el .IP "\f(CWparent: string" 4
.IX Item "parent: string"
the id or name of the parent node.
.ie n .IP """child: string"" (optional)" 4
.el .IP "\f(CWchild: string (optional)" 4
.IX Item "child: string (optional)"
the name of a child under the given parent node.
.ie n .IP """node: string"" (optional)" 4
.el .IP "\f(CWnode: string (optional)" 4
.IX Item "node: string (optional)"
the name of the node that will be added.

**Note:**
this command is experimental, and its \s-1API\s0 is not stable. It
does not support all kinds of operations, all kinds of children, nor
all block drivers.

\s-1FIXME\s0 Removing children from a quorum node means introducing gaps in the
child indices. This cannot be represented in the 'children' list of
BlockdevOptionsQuorum, as returned by .**bdrv\_refresh\_filename()**.

Warning: The data in a new quorum child \s-1MUST\s0 be consistent with that of
the rest of the array.

**Since:**
2.7

**Example:**

.Vb 12
        1. Add a new node to a quorum
        -&gt; { "execute": "blockdev-add",
             "arguments": {
                 "driver": "raw",
                 "node-name": "new_node",
                 "file": { "driver": "file",
                           "filename": "test.raw" } } }
        &lt;- { "return": {} }
        -&gt; { "execute": "x-blockdev-change",
             "arguments": { "parent": "disk1",
                            "node": "new_node" } }
        &lt;- { "return": {} }
        
        2. Delete a quorums node
        -&gt; { "execute": "x-blockdev-change",
             "arguments": { "parent": "disk1",
                            "child": "children.1" } }
        &lt;- { "return": {} }
.Ve

**x-blockdev-set-iothread**  (Command)
Move \f(CW`node\*(C' and its children into the \f(CW\*(C\`iothread\*(C'.  If \f(CW\*(C\`iothread\*(C' is null then
move \f(CW`node\*(C' and its children into the main loop.

The node must not be attached to a BlockBackend.

**Arguments:**
.ie n .IP """node-name: string""" 4
.el .IP "\f(CWnode-name: string" 4
.IX Item "node-name: string"
the name of the block driver node
.ie n .IP """iothread: StrOrNull""" 4
.el .IP "\f(CWiothread: StrOrNull" 4
.IX Item "iothread: StrOrNull"
the name of the IOThread object or null for the main loop
.ie n .IP """force: boolean"" (optional)" 4
.el .IP "\f(CWforce: boolean (optional)" 4
.IX Item "force: boolean (optional)"
true if the node and its children should be moved when a BlockBackend
is already attached

**Note:**
this command is experimental and intended for test cases that need
control over IOThreads only.

**Since:**
2.12

**Example:**

.Vb 5
        1. Move a node into an IOThread
        -&gt; { "execute": "x-blockdev-set-iothread",
             "arguments": { "node-name": "disk1",
                            "iothread": "iothread0" } }
        &lt;- { "return": {} }
        
        2. Move a node into the main loop
        -&gt; { "execute": "x-blockdev-set-iothread",
             "arguments": { "node-name": "disk1",
                            "iothread": null } }
        &lt;- { "return": {} }
.Ve

_Additional block stuff (\s-1VM\s0 related)_
.IX Subsection "Additional block stuff (VM related)"

**BiosAtaTranslation** (Enum)

Policy that \s-1BIOS\s0 should use to interpret cylinder/head/sector
addresses.  Note that Bochs \s-1BIOS\s0 and SeaBIOS will not actually
translate logical \s-1CHS\s0 to physical; instead, they will use logical
block addressing.

**Values:**
.ie n .IP """auto""" 4
.el .IP "\f(CWauto" 4
.IX Item "auto"
If cylinder/heads/sizes are passed, choose between none and \s-1LBA\s0
depending on the size of the disk.  If they are not passed,
choose none if \s-1QEMU\s0 can guess that the disk had 16 or fewer
heads, large if \s-1QEMU\s0 can guess that the disk had 131072 or
fewer tracks across all heads (i.e. cylinders*heads&lt;131072),
otherwise \s-1LBA.\s0
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
The physical disk geometry is equal to the logical geometry.
.ie n .IP """lba""" 4
.el .IP "\f(CWlba" 4
.IX Item "lba"
Assume 63 sectors per track and one of 16, 32, 64, 128 or 255
heads (if fewer than 255 are enough to cover the whole disk
with 1024 cylinders/head).  The number of cylinders/head is
then computed based on the number of sectors and heads.
.ie n .IP """large""" 4
.el .IP "\f(CWlarge" 4
.IX Item "large"
The number of cylinders per head is scaled down to 1024
by correspondingly scaling up the number of heads.
.ie n .IP """rechs""" 4
.el .IP "\f(CWrechs" 4
.IX Item "rechs"
Same as \f(CW`large\*(C', but first convert a 16-head geometry to
15-head, by proportionally scaling up the number of
cylinders/head.

**Since:**
2.0

**FloppyDriveType** (Enum)

Type of Floppy drive to be emulated by the Floppy Disk Controller.

**Values:**
.ie n .IP "144" 4
.el .IP "\f(CW144" 4
.IX Item "144"
1.44MB 3.5" drive
.ie n .IP "288" 4
.el .IP "\f(CW288" 4
.IX Item "288"
2.88MB 3.5" drive
.ie n .IP "120" 4
.el .IP "\f(CW120" 4
.IX Item "120"
1.2MB 5.25" drive
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
No drive connected
.ie n .IP """auto""" 4
.el .IP "\f(CWauto" 4
.IX Item "auto"
Automatically determined by inserted media at boot

**Since:**
2.6

**BlockdevSnapshotInternal** (Object)

**Members:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the device name or node-name of a root node to generate the snapshot
from
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the name of the internal snapshot to be created

**Notes:**
In transaction, if \f(CW`name\*(C' is empty, or any snapshot matching \f(CW\*(C\`name\*(C'
exists, the operation will fail. Only some image formats support it,
for example, qcow2, rbd, and sheepdog.

**Since:**
1.7

**PRManagerInfo** (Object)

Information about a persistent reservation manager

**Members:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the identifier of the persistent reservation manager
.ie n .IP """connected: boolean""" 4
.el .IP "\f(CWconnected: boolean" 4
.IX Item "connected: boolean"
true if the persistent reservation manager is connected to
the underlying storage or helper

**Since:**
3.0

**query-pr-managers**  (Command)
Returns a list of information about each persistent reservation manager.

**Returns:**
a list of \f(CW`PRManagerInfo\*(C' for each persistent reservation manager

**Since:**
3.0

**blockdev-snapshot-internal-sync**  (Command)
Synchronously take an internal snapshot of a block device, when the
format of the image used supports it. If the name is an empty
string, or a snapshot with name already exists, the operation will
fail.

For the arguments, see the documentation of BlockdevSnapshotInternal.

**Returns:**
nothing on success

If \f(CW`device\*(C' is not a valid block device, GenericError

If any snapshot matching \f(CW`name\*(C' exists, or \f(CW\*(C\`name\*(C' is empty,
GenericError

If the format of the image used does not support it,
BlockFormatFeatureNotSupported

**Since:**
1.7

**Example:**

.Vb 5
        -&gt; { "execute": "blockdev-snapshot-internal-sync",
             "arguments": { "device": "ide-hd0",
                            "name": "snapshot0" }
           }
        &lt;- { "return": {} }
.Ve

**blockdev-snapshot-delete-internal-sync**  (Command)
Synchronously delete an internal snapshot of a block device, when the format
of the image used support it. The snapshot is identified by name or id or
both. One of the name or id is required. Return SnapshotInfo for the
successfully deleted snapshot.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the device name or node-name of a root node to delete the snapshot
from
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
optional the snapshot's \s-1ID\s0 to be deleted
.ie n .IP """name: string"" (optional)" 4
.el .IP "\f(CWname: string (optional)" 4
.IX Item "name: string (optional)"
optional the snapshot's name to be deleted

**Returns:**
SnapshotInfo on success
If \f(CW`device\*(C' is not a valid block device, GenericError
If snapshot not found, GenericError
If the format of the image used does not support it,
BlockFormatFeatureNotSupported
If \f(CW`id\*(C' and \f(CW\*(C\`name\*(C' are both not specified, GenericError

**Since:**
1.7

**Example:**

.Vb 10
        -&gt; { "execute": "blockdev-snapshot-delete-internal-sync",
             "arguments": { "device": "ide-hd0",
                            "name": "snapshot0" }
           }
        &lt;- { "return": {
                           "id": "1",
                           "name": "snapshot0",
                           "vm-state-size": 0,
                           "date-sec": 1000012,
                           "date-nsec": 10,
                           "vm-clock-sec": 100,
                           "vm-clock-nsec": 20
             }
           }
.Ve

**eject**  (Command)
Ejects a device from a removable drive.

**Arguments:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
Block device name (deprecated, use \f(CW`id\*(C' instead)
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
The name or \s-1QOM\s0 path of the guest device (since: 2.8)
.ie n .IP """force: boolean"" (optional)" 4
.el .IP "\f(CWforce: boolean (optional)" 4
.IX Item "force: boolean (optional)"
If true, eject regardless of whether the drive is locked.
If not specified, the default value is false.

**Returns:**
Nothing on success

If \f(CW`device\*(C' is not a valid block device, DeviceNotFound

**Notes:**
Ejecting a device with no media results in success

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "eject", "arguments": { "id": "ide1-0-1" } }
        &lt;- { "return": {} }
.Ve

**nbd-server-start**  (Command)
Start an \s-1NBD\s0 server listening on the given host and port.  Block
devices can then be exported using \f(CW`nbd-server-add\*(C'.  The \s-1NBD\s0
server will present them as named exports; for example, another
\s-1QEMU\s0 instance could refer to them as nbd:HOST:PORT:exportname=NAME\*(R".

**Arguments:**
.ie n .IP """addr: SocketAddressLegacy""" 4
.el .IP "\f(CWaddr: SocketAddressLegacy" 4
.IX Item "addr: SocketAddressLegacy"
Address on which to listen.
.ie n .IP """tls-creds: string"" (optional)" 4
.el .IP "\f(CWtls-creds: string (optional)" 4
.IX Item "tls-creds: string (optional)"
(optional) \s-1ID\s0 of the \s-1TLS\s0 credentials object. Since 2.6

**Returns:**
error if the server is already running.

**Since:**
1.3.0

**nbd-server-add**  (Command)
Export a block node to \s-1QEMU\s0's embedded \s-1NBD\s0 server.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The device name or node name of the node to be exported
.ie n .IP """name: string"" (optional)" 4
.el .IP "\f(CWname: string (optional)" 4
.IX Item "name: string (optional)"
Export name. If unspecified, the \f(CW`device\*(C' parameter is used as the
export name. (Since 2.12)
.ie n .IP """writable: boolean"" (optional)" 4
.el .IP "\f(CWwritable: boolean (optional)" 4
.IX Item "writable: boolean (optional)"
Whether clients should be able to write to the device via the
\s-1NBD\s0 connection (default false).

**Returns:**
error if the server is not running, or export with the same name
already exists.

**Since:**
1.3.0

**NbdServerRemoveMode** (Enum)

Mode for removing an \s-1NBD\s0 export.

**Values:**
.ie n .IP """safe""" 4
.el .IP "\f(CWsafe" 4
.IX Item "safe"
Remove export if there are no existing connections, fail otherwise.
.ie n .IP """hard""" 4
.el .IP "\f(CWhard" 4
.IX Item "hard"
Drop all connections immediately and remove export.

Potential additional modes to be added in the future:

hide: Just hide export from new clients, leave existing connections as is.
Remove export after all clients are disconnected.

soft: Hide export from new clients, answer with \s-1ESHUTDOWN\s0 for all further
requests from existing clients.

**Since:**
2.12

**nbd-server-remove**  (Command)
Remove \s-1NBD\s0 export by name.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
Export name.
.ie n .IP """mode: NbdServerRemoveMode"" (optional)" 4
.el .IP "\f(CWmode: NbdServerRemoveMode (optional)" 4
.IX Item "mode: NbdServerRemoveMode (optional)"
Mode of command operation. See \f(CW`NbdServerRemoveMode\*(C' description.
Default is 'safe'.

**Returns:**
error if

* the server is not running
* export is not found
* mode is 'safe' and there are existing connections

**Since:**
2.12

**x-nbd-server-add-bitmap**  (Command)
Expose a dirty bitmap associated with the selected export. The bitmap search
starts at the device attached to the export, and includes all backing files.
The exported bitmap is then locked until the \s-1NBD\s0 export is removed.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
Export name.
.ie n .IP """bitmap: string""" 4
.el .IP "\f(CWbitmap: string" 4
.IX Item "bitmap: string"
Bitmap name to search for.
.ie n .IP """bitmap-export-name: string"" (optional)" 4
.el .IP "\f(CWbitmap-export-name: string (optional)" 4
.IX Item "bitmap-export-name: string (optional)"
How the bitmap will be seen by nbd clients
(default \f(CW`bitmap\*(C')

**Note:**
the client must use \s-1NBD_OPT_SET_META_CONTEXT\s0 with a query of
qemu:dirty-bitmap:NAME\*(R" (where \s-1NAME\s0 matches \f(CW\*(C\`bitmap-export-name\*(C') to access
the exposed bitmap.

**Since:**
3.0

**nbd-server-stop**  (Command)
Stop \s-1QEMU\s0's embedded \s-1NBD\s0 server, and unregister all devices previously
added via \f(CW`nbd-server-add\*(C'.

**Since:**
1.3.0

**\s-1DEVICE\_TRAY\_MOVED\s0**  (Event)
Emitted whenever the tray of a removable device is moved by the guest or by
\s-1HMP/QMP\s0 commands

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
Block device name. This is always present for compatibility
reasons, but it can be empty ("") if the image does not
have a device name associated.
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The name or \s-1QOM\s0 path of the guest device (since 2.8)
.ie n .IP """tray-open: boolean""" 4
.el .IP "\f(CWtray-open: boolean" 4
.IX Item "tray-open: boolean"
true if the tray has been opened or false if it has been closed

**Since:**
1.1

**Example:**

.Vb 6
        &lt;- { "event": "DEVICE_TRAY_MOVED",
             "data": { "device": "ide1-cd0",
                       "id": "/machine/unattached/device[22]",
                       "tray-open": true
             },
             "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
.Ve

**\s-1PR\_MANAGER\_STATUS\_CHANGED\s0**  (Event)
Emitted whenever the connected status of a persistent reservation
manager changes.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The id of the \s-1PR\s0 manager object
.ie n .IP """connected: boolean""" 4
.el .IP "\f(CWconnected: boolean" 4
.IX Item "connected: boolean"
true if the \s-1PR\s0 manager is connected to a backend

**Since:**
3.0

**Example:**

.Vb 5
        &lt;- { "event": "PR_MANAGER_STATUS_CHANGED",
             "data": { "id": "pr-helper0",
                       "connected": true
             },
             "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
.Ve

**QuorumOpType** (Enum)

An enumeration of the quorum operation types

**Values:**
.ie n .IP """read""" 4
.el .IP "\f(CWread" 4
.IX Item "read"
read operation
.ie n .IP """write""" 4
.el .IP "\f(CWwrite" 4
.IX Item "write"
write operation
.ie n .IP """flush""" 4
.el .IP "\f(CWflush" 4
.IX Item "flush"
flush operation

**Since:**
2.6

**\s-1QUORUM\_FAILURE\s0**  (Event)
Emitted by the Quorum block driver if it fails to establish a quorum

**Arguments:**
.ie n .IP """reference: string""" 4
.el .IP "\f(CWreference: string" 4
.IX Item "reference: string"
device name if defined else node name
.ie n .IP """sector-num: int""" 4
.el .IP "\f(CWsector-num: int" 4
.IX Item "sector-num: int"
number of the first sector of the failed read operation
.ie n .IP """sectors-count: int""" 4
.el .IP "\f(CWsectors-count: int" 4
.IX Item "sectors-count: int"
failed read operation sector count

**Note:**
This event is rate-limited.

**Since:**
2.0

**Example:**

.Vb 3
        &lt;- { "event": "QUORUM_FAILURE",
             "data": { "reference": "usr1", "sector-num": 345435, "sectors-count": 5 },
             "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
.Ve

**\s-1QUORUM\_REPORT\_BAD\s0**  (Event)
Emitted to report a corruption of a Quorum file

**Arguments:**
.ie n .IP """type: QuorumOpType""" 4
.el .IP "\f(CWtype: QuorumOpType" 4
.IX Item "type: QuorumOpType"
quorum operation type (Since 2.6)
.ie n .IP """error: string"" (optional)" 4
.el .IP "\f(CWerror: string (optional)" 4
.IX Item "error: string (optional)"
error message. Only present on failure. This field
contains a human-readable error message. There are no semantics other
than that the block layer reported an error and clients should not
try to interpret the error string.
.ie n .IP """node-name: string""" 4
.el .IP "\f(CWnode-name: string" 4
.IX Item "node-name: string"
the graph node name of the block driver state
.ie n .IP """sector-num: int""" 4
.el .IP "\f(CWsector-num: int" 4
.IX Item "sector-num: int"
number of the first sector of the failed read operation
.ie n .IP """sectors-count: int""" 4
.el .IP "\f(CWsectors-count: int" 4
.IX Item "sectors-count: int"
failed read operation sector count

**Note:**
This event is rate-limited.

**Since:**
2.0

**Example:**

.Vb 1
        1. Read operation
        
        { "event": "QUORUM_REPORT_BAD",
             "data": { "node-name": "node0", "sector-num": 345435, "sectors-count": 5,
                       "type": "read" },
             "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
        
        2. Flush operation
        
        { "event": "QUORUM_REPORT_BAD",
             "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2097120,
                       "type": "flush", "error": "Broken pipe" },
             "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
.Ve

<a name="character-devices"></a>

### Character devices

.IX Subsection "Character devices"
**ChardevInfo** (Object)

Information about a character device.

**Members:**
.ie n .IP """label: string""" 4
.el .IP "\f(CWlabel: string" 4
.IX Item "label: string"
the label of the character device
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
the filename of the character device
.ie n .IP """frontend-open: boolean""" 4
.el .IP "\f(CWfrontend-open: boolean" 4
.IX Item "frontend-open: boolean"
shows whether the frontend device attached to this backend
(eg. with the chardev=... option) is in open or closed state
(since 2.1)

**Notes:**
\f(CW`filename\*(C' is encoded using the \s-1QEMU\s0 command line character device
encoding.  See the \s-1QEMU\s0 man page for details.

**Since:**
0.14.0

**query-chardev**  (Command)
Returns information about current character devices.

**Returns:**
a list of \f(CW`ChardevInfo\*(C'

**Since:**
0.14.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-chardev" }
        &lt;- {
              "return": [
                 {
                    "label": "charchannel0",
                    "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.agent,server",
                    "frontend-open": false
                 },
                 {
                    "label": "charmonitor",
                    "filename": "unix:/var/lib/libvirt/qemu/seabios.rhel6.monitor,server",
                    "frontend-open": true
                 },
                 {
                    "label": "charserial0",
                    "filename": "pty:/dev/pts/2",
                    "frontend-open": true
                 }
              ]
           }
.Ve

**ChardevBackendInfo** (Object)

Information about a character device backend

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
The backend name

**Since:**
2.0

**query-chardev-backends**  (Command)
Returns information about character device backends.

**Returns:**
a list of \f(CW`ChardevBackendInfo\*(C'

**Since:**
2.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-chardev-backends" }
        &lt;- {
              "return":[
                 {
                    "name":"udp"
                 },
                 {
                    "name":"tcp"
                 },
                 {
                    "name":"unix"
                 },
                 {
                    "name":"spiceport"
                 }
              ]
           }
.Ve

**DataFormat** (Enum)

An enumeration of data format.

**Values:**
.ie n .IP """utf8""" 4
.el .IP "\f(CWutf8" 4
.IX Item "utf8"
Data is a \s-1UTF-8\s0 string (\s-1RFC 3629\s0)
.ie n .IP """base64""" 4
.el .IP "\f(CWbase64" 4
.IX Item "base64"
Data is Base64 encoded binary (\s-1RFC 3548\s0)

**Since:**
1.4

**ringbuf-write**  (Command)
Write to a ring buffer character device.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the ring buffer character device name
.ie n .IP """data: string""" 4
.el .IP "\f(CWdata: string" 4
.IX Item "data: string"
data to write
.ie n .IP """format: DataFormat"" (optional)" 4
.el .IP "\f(CWformat: DataFormat (optional)" 4
.IX Item "format: DataFormat (optional)"
data encoding (default 'utf8').

* base64: data must be base64 encoded text.  Its binary
  decoding gets written.
* utf8: data's \s-1UTF-8\s0 encoding is written
* data itself is always Unicode regardless of format, like
  any other string.

**Returns:**
Nothing on success

**Since:**
1.4

**Example:**

.Vb 5
        -&gt; { "execute": "ringbuf-write",
             "arguments": { "device": "foo",
                            "data": "abcdefgh",
                            "format": "utf8" } }
        &lt;- { "return": {} }
.Ve

**ringbuf-read**  (Command)
Read from a ring buffer character device.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
the ring buffer character device name
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
how many bytes to read at most
.ie n .IP """format: DataFormat"" (optional)" 4
.el .IP "\f(CWformat: DataFormat (optional)" 4
.IX Item "format: DataFormat (optional)"
data encoding (default 'utf8').

* base64: the data read is returned in base64 encoding.
* utf8: the data read is interpreted as \s-1UTF-8.\s0
  Bug: can screw up when the buffer contains invalid \s-1UTF-8\s0
  sequences, \s-1NUL\s0 characters, after the ring buffer lost
  data, and when reading stops because the size limit is
  reached.
* The return value is always Unicode regardless of format,
  like any other string.

**Returns:**
data read from the device

**Since:**
1.4

**Example:**

.Vb 5
        -&gt; { "execute": "ringbuf-read",
             "arguments": { "device": "foo",
                            "size": 1000,
                            "format": "utf8" } }
        &lt;- { "return": "abcdefgh" }
.Ve

**ChardevCommon** (Object)

Configuration shared across all chardev backends

**Members:**
.ie n .IP """logfile: string"" (optional)" 4
.el .IP "\f(CWlogfile: string (optional)" 4
.IX Item "logfile: string (optional)"
The name of a logfile to save output
.ie n .IP """logappend: boolean"" (optional)" 4
.el .IP "\f(CWlogappend: boolean (optional)" 4
.IX Item "logappend: boolean (optional)"
true to append instead of truncate
(default to false to truncate)

**Since:**
2.6

**ChardevFile** (Object)

Configuration info for file chardevs.

**Members:**
.ie n .IP """in: string"" (optional)" 4
.el .IP "\f(CWin: string (optional)" 4
.IX Item "in: string (optional)"
The name of the input file
.ie n .IP """out: string""" 4
.el .IP "\f(CWout: string" 4
.IX Item "out: string"
The name of the output file
.ie n .IP """append: boolean"" (optional)" 4
.el .IP "\f(CWappend: boolean (optional)" 4
.IX Item "append: boolean (optional)"
Open the file in append mode (default false to
truncate) (Since 2.6)
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.4

**ChardevHostdev** (Object)

Configuration info for device and pipe chardevs.

**Members:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
The name of the special file for the device,
i.e. /dev/ttyS0 on Unix or \s-1COM1:\s0 on Windows
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.4

**ChardevSocket** (Object)

Configuration info for (stream) socket chardevs.

**Members:**
.ie n .IP """addr: SocketAddressLegacy""" 4
.el .IP "\f(CWaddr: SocketAddressLegacy" 4
.IX Item "addr: SocketAddressLegacy"
socket address to listen on (server=true)
or connect to (server=false)
.ie n .IP """tls-creds: string"" (optional)" 4
.el .IP "\f(CWtls-creds: string (optional)" 4
.IX Item "tls-creds: string (optional)"
the \s-1ID\s0 of the \s-1TLS\s0 credentials object (since 2.6)
.ie n .IP """server: boolean"" (optional)" 4
.el .IP "\f(CWserver: boolean (optional)" 4
.IX Item "server: boolean (optional)"
create server socket (default: true)
.ie n .IP """wait: boolean"" (optional)" 4
.el .IP "\f(CWwait: boolean (optional)" 4
.IX Item "wait: boolean (optional)"
wait for incoming connection on server
sockets (default: false).
.ie n .IP """nodelay: boolean"" (optional)" 4
.el .IP "\f(CWnodelay: boolean (optional)" 4
.IX Item "nodelay: boolean (optional)"
set \s-1TCP_NODELAY\s0 socket option (default: false)
.ie n .IP """telnet: boolean"" (optional)" 4
.el .IP "\f(CWtelnet: boolean (optional)" 4
.IX Item "telnet: boolean (optional)"
enable telnet protocol on server
sockets (default: false)
.ie n .IP """tn3270: boolean"" (optional)" 4
.el .IP "\f(CWtn3270: boolean (optional)" 4
.IX Item "tn3270: boolean (optional)"
enable tn3270 protocol on server
sockets (default: false) (Since: 2.10)
.ie n .IP """websocket: boolean"" (optional)" 4
.el .IP "\f(CWwebsocket: boolean (optional)" 4
.IX Item "websocket: boolean (optional)"
enable websocket protocol on server
sockets (default: false) (Since: 3.1)
.ie n .IP """reconnect: int"" (optional)" 4
.el .IP "\f(CWreconnect: int (optional)" 4
.IX Item "reconnect: int (optional)"
For a client socket, if a socket is disconnected,
then attempt a reconnect after the given number of seconds.
Setting this to zero disables this function. (default: 0)
(Since: 2.2)
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.4

**ChardevUdp** (Object)

Configuration info for datagram socket chardevs.

**Members:**
.ie n .IP """remote: SocketAddressLegacy""" 4
.el .IP "\f(CWremote: SocketAddressLegacy" 4
.IX Item "remote: SocketAddressLegacy"
remote address
.ie n .IP """local: SocketAddressLegacy"" (optional)" 4
.el .IP "\f(CWlocal: SocketAddressLegacy (optional)" 4
.IX Item "local: SocketAddressLegacy (optional)"
local address
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.5

**ChardevMux** (Object)

Configuration info for mux chardevs.

**Members:**
.ie n .IP """chardev: string""" 4
.el .IP "\f(CWchardev: string" 4
.IX Item "chardev: string"
name of the base chardev.
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.5

**ChardevStdio** (Object)

Configuration info for stdio chardevs.

**Members:**
.ie n .IP """signal: boolean"" (optional)" 4
.el .IP "\f(CWsignal: boolean (optional)" 4
.IX Item "signal: boolean (optional)"
Allow signals (such as \s-1SIGINT\s0 triggered by ^C)
be delivered to qemu.  Default: true in -nographic mode,
false otherwise.
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.5

**ChardevSpiceChannel** (Object)

Configuration info for spice vm channel chardevs.

**Members:**
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
kind of channel (for example vdagent).
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.5

**ChardevSpicePort** (Object)

Configuration info for spice port chardevs.

**Members:**
.ie n .IP """fqdn: string""" 4
.el .IP "\f(CWfqdn: string" 4
.IX Item "fqdn: string"
name of the channel (see docs/spice-port-fqdn.txt)
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.5

**ChardevVC** (Object)

Configuration info for virtual console chardevs.

**Members:**
.ie n .IP """width: int"" (optional)" 4
.el .IP "\f(CWwidth: int (optional)" 4
.IX Item "width: int (optional)"
console width,  in pixels
.ie n .IP """height: int"" (optional)" 4
.el .IP "\f(CWheight: int (optional)" 4
.IX Item "height: int (optional)"
console height, in pixels
.ie n .IP """cols: int"" (optional)" 4
.el .IP "\f(CWcols: int (optional)" 4
.IX Item "cols: int (optional)"
console width,  in chars
.ie n .IP """rows: int"" (optional)" 4
.el .IP "\f(CWrows: int (optional)" 4
.IX Item "rows: int (optional)"
console height, in chars
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.5

**ChardevRingbuf** (Object)

Configuration info for ring buffer chardevs.

**Members:**
.ie n .IP """size: int"" (optional)" 4
.el .IP "\f(CWsize: int (optional)" 4
.IX Item "size: int (optional)"
ring buffer size, must be power of two, default is 65536
.ie n .IP "The members of ""ChardevCommon""" 4
.el .IP "The members of \f(CWChardevCommon" 4
.IX Item "The members of ChardevCommon"

**Since:**
1.5

**ChardevBackend** (Object)

Configuration info for the new chardev backend.

**Members:**
.ie n .IP """type""" 4
.el .IP "\f(CWtype" 4
.IX Item "type"
One of file\*(R", \*(L"serial\*(R", \*(L"parallel\*(R", \*(L"pipe\*(R", \*(L"socket\*(R", \*(L"udp\*(R", \*(L"pty\*(R", \*(L"null\*(R", \*(L"mux\*(R", \*(L"msmouse\*(R", \*(L"wctablet\*(R", \*(L"braille\*(R", \*(L"testdev\*(R", \*(L"stdio\*(R", \*(L"console\*(R", \*(L"spicevmc\*(R", \*(L"spiceport\*(R", \*(L"vc\*(R", \*(L"ringbuf\*(R", \*(L"memory\*(R"
.ie n .IP """data: ChardevFile"" when ""type"" is ""file""" 4
.el .IP "\f(CWdata: ChardevFile when \f(CWtype is \`\`file''" 4
.IX Item "data: ChardevFile when type is file"
.ie n .IP """data: ChardevHostdev"" when ""type"" is ""serial""" 4
.el .IP "\f(CWdata: ChardevHostdev when \f(CWtype is \`\`serial''" 4
.IX Item "data: ChardevHostdev when type is serial"
.ie n .IP """data: ChardevHostdev"" when ""type"" is ""parallel""" 4
.el .IP "\f(CWdata: ChardevHostdev when \f(CWtype is \`\`parallel''" 4
.IX Item "data: ChardevHostdev when type is parallel"
.ie n .IP """data: ChardevHostdev"" when ""type"" is ""pipe""" 4
.el .IP "\f(CWdata: ChardevHostdev when \f(CWtype is \`\`pipe''" 4
.IX Item "data: ChardevHostdev when type is pipe"
.ie n .IP """data: ChardevSocket"" when ""type"" is ""socket""" 4
.el .IP "\f(CWdata: ChardevSocket when \f(CWtype is \`\`socket''" 4
.IX Item "data: ChardevSocket when type is socket"
.ie n .IP """data: ChardevUdp"" when ""type"" is ""udp""" 4
.el .IP "\f(CWdata: ChardevUdp when \f(CWtype is \`\`udp''" 4
.IX Item "data: ChardevUdp when type is udp"
.ie n .IP """data: ChardevCommon"" when ""type"" is ""pty""" 4
.el .IP "\f(CWdata: ChardevCommon when \f(CWtype is \`\`pty''" 4
.IX Item "data: ChardevCommon when type is pty"
.ie n .IP """data: ChardevCommon"" when ""type"" is ""null""" 4
.el .IP "\f(CWdata: ChardevCommon when \f(CWtype is \`\`null''" 4
.IX Item "data: ChardevCommon when type is null"
.ie n .IP """data: ChardevMux"" when ""type"" is ""mux""" 4
.el .IP "\f(CWdata: ChardevMux when \f(CWtype is \`\`mux''" 4
.IX Item "data: ChardevMux when type is mux"
.ie n .IP """data: ChardevCommon"" when ""type"" is ""msmouse""" 4
.el .IP "\f(CWdata: ChardevCommon when \f(CWtype is \`\`msmouse''" 4
.IX Item "data: ChardevCommon when type is msmouse"
.ie n .IP """data: ChardevCommon"" when ""type"" is ""wctablet""" 4
.el .IP "\f(CWdata: ChardevCommon when \f(CWtype is \`\`wctablet''" 4
.IX Item "data: ChardevCommon when type is wctablet"
.ie n .IP """data: ChardevCommon"" when ""type"" is ""braille""" 4
.el .IP "\f(CWdata: ChardevCommon when \f(CWtype is \`\`braille''" 4
.IX Item "data: ChardevCommon when type is braille"
.ie n .IP """data: ChardevCommon"" when ""type"" is ""testdev""" 4
.el .IP "\f(CWdata: ChardevCommon when \f(CWtype is \`\`testdev''" 4
.IX Item "data: ChardevCommon when type is testdev"
.ie n .IP """data: ChardevStdio"" when ""type"" is ""stdio""" 4
.el .IP "\f(CWdata: ChardevStdio when \f(CWtype is \`\`stdio''" 4
.IX Item "data: ChardevStdio when type is stdio"
.ie n .IP """data: ChardevCommon"" when ""type"" is ""console""" 4
.el .IP "\f(CWdata: ChardevCommon when \f(CWtype is \`\`console''" 4
.IX Item "data: ChardevCommon when type is console"
.ie n .IP """data: ChardevSpiceChannel"" when ""type"" is ""spicevmc""" 4
.el .IP "\f(CWdata: ChardevSpiceChannel when \f(CWtype is \`\`spicevmc''" 4
.IX Item "data: ChardevSpiceChannel when type is spicevmc"
.ie n .IP """data: ChardevSpicePort"" when ""type"" is ""spiceport""" 4
.el .IP "\f(CWdata: ChardevSpicePort when \f(CWtype is \`\`spiceport''" 4
.IX Item "data: ChardevSpicePort when type is spiceport"
.ie n .IP """data: ChardevVC"" when ""type"" is ""vc""" 4
.el .IP "\f(CWdata: ChardevVC when \f(CWtype is \`\`vc''" 4
.IX Item "data: ChardevVC when type is vc"
.ie n .IP """data: ChardevRingbuf"" when ""type"" is ""ringbuf""" 4
.el .IP "\f(CWdata: ChardevRingbuf when \f(CWtype is \`\`ringbuf''" 4
.IX Item "data: ChardevRingbuf when type is ringbuf"
.ie n .IP """data: ChardevRingbuf"" when ""type"" is ""memory""" 4
.el .IP "\f(CWdata: ChardevRingbuf when \f(CWtype is \`\`memory''" 4
.IX Item "data: ChardevRingbuf when type is memory"

**Since:**
1.4 (testdev since 2.2, wctablet since 2.9)

**ChardevReturn** (Object)

Return info about the chardev backend just created.

**Members:**
.ie n .IP """pty: string"" (optional)" 4
.el .IP "\f(CWpty: string (optional)" 4
.IX Item "pty: string (optional)"
name of the slave pseudoterminal device, present if
and only if a chardev of type 'pty' was created

**Since:**
1.4

**chardev-add**  (Command)
Add a character device backend

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the chardev's \s-1ID,\s0 must be unique
.ie n .IP """backend: ChardevBackend""" 4
.el .IP "\f(CWbackend: ChardevBackend" 4
.IX Item "backend: ChardevBackend"
backend type and parameters

**Returns:**
ChardevReturn.

**Since:**
1.4

**Example:**

.Vb 4
        -&gt; { "execute" : "chardev-add",
             "arguments" : { "id" : "foo",
                             "backend" : { "type" : "null", "data" : {} } } }
        &lt;- { "return": {} }
        
        -&gt; { "execute" : "chardev-add",
             "arguments" : { "id" : "bar",
                             "backend" : { "type" : "file",
                                           "data" : { "out" : "/tmp/bar.log" } } } }
        &lt;- { "return": {} }
        
        -&gt; { "execute" : "chardev-add",
             "arguments" : { "id" : "baz",
                             "backend" : { "type" : "pty", "data" : {} } } }
        &lt;- { "return": { "pty" : "/dev/pty/42" } }
.Ve

**chardev-change**  (Command)
Change a character device backend

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the chardev's \s-1ID,\s0 must exist
.ie n .IP """backend: ChardevBackend""" 4
.el .IP "\f(CWbackend: ChardevBackend" 4
.IX Item "backend: ChardevBackend"
new backend type and parameters

**Returns:**
ChardevReturn.

**Since:**
2.10

**Example:**

.Vb 4
        -&gt; { "execute" : "chardev-change",
             "arguments" : { "id" : "baz",
                             "backend" : { "type" : "pty", "data" : {} } } }
        &lt;- { "return": { "pty" : "/dev/pty/42" } }
        
        -&gt; {"execute" : "chardev-change",
            "arguments" : {
                "id" : "charchannel2",
                "backend" : {
                    "type" : "socket",
                    "data" : {
                        "addr" : {
                            "type" : "unix" ,
                            "data" : {
                                "path" : "/tmp/charchannel2.socket"
                            }
                         },
                         "server" : true,
                         "wait" : false }}}}
        &lt;- {"return": {}}
.Ve

**chardev-remove**  (Command)
Remove a character device backend

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the chardev's \s-1ID,\s0 must exist and not be in use

**Returns:**
Nothing on success

**Since:**
1.4

**Example:**

.Vb 2
        -&gt; { "execute": "chardev-remove", "arguments": { "id" : "foo" } }
        &lt;- { "return": {} }
.Ve

**chardev-send-break**  (Command)
Send a break to a character device

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the chardev's \s-1ID,\s0 must exist

**Returns:**
Nothing on success

**Since:**
2.10

**Example:**

.Vb 2
        -&gt; { "execute": "chardev-send-break", "arguments": { "id" : "foo" } }
        &lt;- { "return": {} }
.Ve

**\s-1VSERPORT\_CHANGE\s0**  (Event)
Emitted when the guest opens or closes a virtio-serial port.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
device identifier of the virtio-serial port
.ie n .IP """open: boolean""" 4
.el .IP "\f(CWopen: boolean" 4
.IX Item "open: boolean"
true if the guest has opened the virtio-serial port

**Since:**
2.1

**Example:**

.Vb 3
        &lt;- { "event": "VSERPORT_CHANGE",
             "data": { "id": "channel0", "open": true },
             "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
.Ve

<a name="net-devices"></a>

### Net devices

.IX Subsection "Net devices"
**set\_link**  (Command)
Sets the link status of a virtual network adapter.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the device name of the virtual network adapter
.ie n .IP """up: boolean""" 4
.el .IP "\f(CWup: boolean" 4
.IX Item "up: boolean"
true to set the link status to be up

**Returns:**
Nothing on success
If \f(CW`name\*(C' is not a valid network device, DeviceNotFound

**Since:**
0.14.0

**Notes:**
Not all network adapters support setting link status.  This command
will succeed even if the network adapter does not support link status
notification.

**Example:**

.Vb 3
        -&gt; { "execute": "set_link",
             "arguments": { "name": "e1000.0", "up": false } }
        &lt;- { "return": {} }
.Ve

**netdev\_add**  (Command)
Add a network backend.

**Arguments:**
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
the type of network backend. Possible values are listed in
NetClientDriver (excluding 'none' and 'nic')
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the name of the new network backend

Additional arguments depend on the type.

**\s-1TODO:\s0**
This command effectively bypasses \s-1QAPI\s0 completely due to its
additional arguments\*(R" business.  It shouldn't have been added to
the schema in this form.  It should be qapified properly, or
replaced by a properly qapified command.

**Since:**
0.14.0

**Returns:**
Nothing on success
If \f(CW`type\*(C' is not a valid network backend, DeviceNotFound

**Example:**

.Vb 4
        -&gt; { "execute": "netdev_add",
             "arguments": { "type": "user", "id": "netdev1",
                            "dnssearch": "example.org" } }
        &lt;- { "return": {} }
.Ve

**netdev\_del**  (Command)
Remove a network backend.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the name of the network backend to remove

**Returns:**
Nothing on success
If \f(CW`id\*(C' is not a valid network backend, DeviceNotFound

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "netdev_del", "arguments": { "id": "netdev1" } }
        &lt;- { "return": {} }
.Ve

**NetLegacyNicOptions** (Object)

Create a new Network Interface Card.

**Members:**
.ie n .IP """netdev: string"" (optional)" 4
.el .IP "\f(CWnetdev: string (optional)" 4
.IX Item "netdev: string (optional)"
id of -netdev to connect to
.ie n .IP """macaddr: string"" (optional)" 4
.el .IP "\f(CWmacaddr: string (optional)" 4
.IX Item "macaddr: string (optional)"
\s-1MAC\s0 address
.ie n .IP """model: string"" (optional)" 4
.el .IP "\f(CWmodel: string (optional)" 4
.IX Item "model: string (optional)"
device model (e1000, rtl8139, virtio etc.)
.ie n .IP """addr: string"" (optional)" 4
.el .IP "\f(CWaddr: string (optional)" 4
.IX Item "addr: string (optional)"
\s-1PCI\s0 device address
.ie n .IP """vectors: int"" (optional)" 4
.el .IP "\f(CWvectors: int (optional)" 4
.IX Item "vectors: int (optional)"
number of MSI-x vectors, 0 to disable MSI-X

**Since:**
1.2

**NetdevUserOptions** (Object)

Use the user mode network stack which requires no administrator privilege to
run.

**Members:**
.ie n .IP """hostname: string"" (optional)" 4
.el .IP "\f(CWhostname: string (optional)" 4
.IX Item "hostname: string (optional)"
client hostname reported by the builtin \s-1DHCP\s0 server
.ie n .IP """restrict: boolean"" (optional)" 4
.el .IP "\f(CWrestrict: boolean (optional)" 4
.IX Item "restrict: boolean (optional)"
isolate the guest from the host
.ie n .IP """ipv4: boolean"" (optional)" 4
.el .IP "\f(CWipv4: boolean (optional)" 4
.IX Item "ipv4: boolean (optional)"
whether to support IPv4, default true for enabled
(since 2.6)
.ie n .IP """ipv6: boolean"" (optional)" 4
.el .IP "\f(CWipv6: boolean (optional)" 4
.IX Item "ipv6: boolean (optional)"
whether to support IPv6, default true for enabled
(since 2.6)
.ie n .IP """ip: string"" (optional)" 4
.el .IP "\f(CWip: string (optional)" 4
.IX Item "ip: string (optional)"
legacy parameter, use net= instead
.ie n .IP """net: string"" (optional)" 4
.el .IP "\f(CWnet: string (optional)" 4
.IX Item "net: string (optional)"
\s-1IP\s0 network address that the guest will see, in the
form addr[/netmask] The netmask is optional, and can be
either in the form a.b.c.d or as a number of valid top-most
bits. Default is 10.0.2.0/24.
.ie n .IP """host: string"" (optional)" 4
.el .IP "\f(CWhost: string (optional)" 4
.IX Item "host: string (optional)"
guest-visible address of the host
.ie n .IP """tftp: string"" (optional)" 4
.el .IP "\f(CWtftp: string (optional)" 4
.IX Item "tftp: string (optional)"
root directory of the built-in \s-1TFTP\s0 server
.ie n .IP """bootfile: string"" (optional)" 4
.el .IP "\f(CWbootfile: string (optional)" 4
.IX Item "bootfile: string (optional)"
\s-1BOOTP\s0 filename, for use with tftp=
.ie n .IP """dhcpstart: string"" (optional)" 4
.el .IP "\f(CWdhcpstart: string (optional)" 4
.IX Item "dhcpstart: string (optional)"
the first of the 16 IPs the built-in \s-1DHCP\s0 server can
assign
.ie n .IP """dns: string"" (optional)" 4
.el .IP "\f(CWdns: string (optional)" 4
.IX Item "dns: string (optional)"
guest-visible address of the virtual nameserver
.ie n .IP """dnssearch: array of String"" (optional)" 4
.el .IP "\f(CWdnssearch: array of String (optional)" 4
.IX Item "dnssearch: array of String (optional)"
list of \s-1DNS\s0 suffixes to search, passed as \s-1DHCP\s0 option
to the guest
.ie n .IP """domainname: string"" (optional)" 4
.el .IP "\f(CWdomainname: string (optional)" 4
.IX Item "domainname: string (optional)"
guest-visible domain name of the virtual nameserver
(since 3.0)
.ie n .IP """ipv6-prefix: string"" (optional)" 4
.el .IP "\f(CWipv6-prefix: string (optional)" 4
.IX Item "ipv6-prefix: string (optional)"
IPv6 network prefix (default is fec0::) (since
2.6). The network prefix is given in the usual
hexadecimal IPv6 address notation.
.ie n .IP """ipv6-prefixlen: int"" (optional)" 4
.el .IP "\f(CWipv6-prefixlen: int (optional)" 4
.IX Item "ipv6-prefixlen: int (optional)"
IPv6 network prefix length (default is 64)
(since 2.6)
.ie n .IP """ipv6-host: string"" (optional)" 4
.el .IP "\f(CWipv6-host: string (optional)" 4
.IX Item "ipv6-host: string (optional)"
guest-visible IPv6 address of the host (since 2.6)
.ie n .IP """ipv6-dns: string"" (optional)" 4
.el .IP "\f(CWipv6-dns: string (optional)" 4
.IX Item "ipv6-dns: string (optional)"
guest-visible IPv6 address of the virtual
nameserver (since 2.6)
.ie n .IP """smb: string"" (optional)" 4
.el .IP "\f(CWsmb: string (optional)" 4
.IX Item "smb: string (optional)"
root directory of the built-in \s-1SMB\s0 server
.ie n .IP """smbserver: string"" (optional)" 4
.el .IP "\f(CWsmbserver: string (optional)" 4
.IX Item "smbserver: string (optional)"
\s-1IP\s0 address of the built-in \s-1SMB\s0 server
.ie n .IP """hostfwd: array of String"" (optional)" 4
.el .IP "\f(CWhostfwd: array of String (optional)" 4
.IX Item "hostfwd: array of String (optional)"
redirect incoming \s-1TCP\s0 or \s-1UDP\s0 host connections to guest
endpoints
.ie n .IP """guestfwd: array of String"" (optional)" 4
.el .IP "\f(CWguestfwd: array of String (optional)" 4
.IX Item "guestfwd: array of String (optional)"
forward guest \s-1TCP\s0 connections
.ie n .IP """tftp-server-name: string"" (optional)" 4
.el .IP "\f(CWtftp-server-name: string (optional)" 4
.IX Item "tftp-server-name: string (optional)"
\s-1RFC2132 TFTP\s0 server name\*(R" string (Since 3.1)

**Since:**
1.2

**NetdevTapOptions** (Object)

Used to configure a host \s-1TAP\s0 network interface backend.

**Members:**
.ie n .IP """ifname: string"" (optional)" 4
.el .IP "\f(CWifname: string (optional)" 4
.IX Item "ifname: string (optional)"
interface name
.ie n .IP """fd: string"" (optional)" 4
.el .IP "\f(CWfd: string (optional)" 4
.IX Item "fd: string (optional)"
file descriptor of an already opened tap
.ie n .IP """fds: string"" (optional)" 4
.el .IP "\f(CWfds: string (optional)" 4
.IX Item "fds: string (optional)"
multiple file descriptors of already opened multiqueue capable
tap
.ie n .IP """script: string"" (optional)" 4
.el .IP "\f(CWscript: string (optional)" 4
.IX Item "script: string (optional)"
script to initialize the interface
.ie n .IP """downscript: string"" (optional)" 4
.el .IP "\f(CWdownscript: string (optional)" 4
.IX Item "downscript: string (optional)"
script to shut down the interface
.ie n .IP """br: string"" (optional)" 4
.el .IP "\f(CWbr: string (optional)" 4
.IX Item "br: string (optional)"
bridge name (since 2.8)
.ie n .IP """helper: string"" (optional)" 4
.el .IP "\f(CWhelper: string (optional)" 4
.IX Item "helper: string (optional)"
command to execute to configure bridge
.ie n .IP """sndbuf: int"" (optional)" 4
.el .IP "\f(CWsndbuf: int (optional)" 4
.IX Item "sndbuf: int (optional)"
send buffer limit. Understands [TGMKkb] suffixes.
.ie n .IP """vnet_hdr: boolean"" (optional)" 4
.el .IP "\f(CWvnet_hdr: boolean (optional)" 4
.IX Item "vnet_hdr: boolean (optional)"
enable the \s-1IFF_VNET_HDR\s0 flag on the tap interface
.ie n .IP """vhost: boolean"" (optional)" 4
.el .IP "\f(CWvhost: boolean (optional)" 4
.IX Item "vhost: boolean (optional)"
enable vhost-net network accelerator
.ie n .IP """vhostfd: string"" (optional)" 4
.el .IP "\f(CWvhostfd: string (optional)" 4
.IX Item "vhostfd: string (optional)"
file descriptor of an already opened vhost net device
.ie n .IP """vhostfds: string"" (optional)" 4
.el .IP "\f(CWvhostfds: string (optional)" 4
.IX Item "vhostfds: string (optional)"
file descriptors of multiple already opened vhost net
devices
.ie n .IP """vhostforce: boolean"" (optional)" 4
.el .IP "\f(CWvhostforce: boolean (optional)" 4
.IX Item "vhostforce: boolean (optional)"
vhost on for non-MSIX virtio guests
.ie n .IP """queues: int"" (optional)" 4
.el .IP "\f(CWqueues: int (optional)" 4
.IX Item "queues: int (optional)"
number of queues to be created for multiqueue capable tap
.ie n .IP """poll-us: int"" (optional)" 4
.el .IP "\f(CWpoll-us: int (optional)" 4
.IX Item "poll-us: int (optional)"
maximum number of microseconds that could
be spent on busy polling for tap (since 2.7)

**Since:**
1.2

**NetdevSocketOptions** (Object)

Socket netdevs are used to establish a network connection to another
\s-1QEMU\s0 virtual machine via a \s-1TCP\s0 socket.

**Members:**
.ie n .IP """fd: string"" (optional)" 4
.el .IP "\f(CWfd: string (optional)" 4
.IX Item "fd: string (optional)"
file descriptor of an already opened socket
.ie n .IP """listen: string"" (optional)" 4
.el .IP "\f(CWlisten: string (optional)" 4
.IX Item "listen: string (optional)"
port number, and optional hostname, to listen on
.ie n .IP """connect: string"" (optional)" 4
.el .IP "\f(CWconnect: string (optional)" 4
.IX Item "connect: string (optional)"
port number, and optional hostname, to connect to
.ie n .IP """mcast: string"" (optional)" 4
.el .IP "\f(CWmcast: string (optional)" 4
.IX Item "mcast: string (optional)"
\s-1UDP\s0 multicast address and port number
.ie n .IP """localaddr: string"" (optional)" 4
.el .IP "\f(CWlocaladdr: string (optional)" 4
.IX Item "localaddr: string (optional)"
source address and port for multicast and udp packets
.ie n .IP """udp: string"" (optional)" 4
.el .IP "\f(CWudp: string (optional)" 4
.IX Item "udp: string (optional)"
\s-1UDP\s0 unicast address and port number

**Since:**
1.2

**NetdevL2TPv3Options** (Object)

Configure an Ethernet over L2TPv3 tunnel.

**Members:**
.ie n .IP """src: string""" 4
.el .IP "\f(CWsrc: string" 4
.IX Item "src: string"
source address
.ie n .IP """dst: string""" 4
.el .IP "\f(CWdst: string" 4
.IX Item "dst: string"
destination address
.ie n .IP """srcport: string"" (optional)" 4
.el .IP "\f(CWsrcport: string (optional)" 4
.IX Item "srcport: string (optional)"
source port - mandatory for udp, optional for ip
.ie n .IP """dstport: string"" (optional)" 4
.el .IP "\f(CWdstport: string (optional)" 4
.IX Item "dstport: string (optional)"
destination port - mandatory for udp, optional for ip
.ie n .IP """ipv6: boolean"" (optional)" 4
.el .IP "\f(CWipv6: boolean (optional)" 4
.IX Item "ipv6: boolean (optional)"
force the use of ipv6
.ie n .IP """udp: boolean"" (optional)" 4
.el .IP "\f(CWudp: boolean (optional)" 4
.IX Item "udp: boolean (optional)"
use the udp version of l2tpv3 encapsulation
.ie n .IP """cookie64: boolean"" (optional)" 4
.el .IP "\f(CWcookie64: boolean (optional)" 4
.IX Item "cookie64: boolean (optional)"
use 64 bit coookies
.ie n .IP """counter: boolean"" (optional)" 4
.el .IP "\f(CWcounter: boolean (optional)" 4
.IX Item "counter: boolean (optional)"
have sequence counter
.ie n .IP """pincounter: boolean"" (optional)" 4
.el .IP "\f(CWpincounter: boolean (optional)" 4
.IX Item "pincounter: boolean (optional)"
pin sequence counter to zero -
workaround for buggy implementations or
networks with packet reorder
.ie n .IP """txcookie: int"" (optional)" 4
.el .IP "\f(CWtxcookie: int (optional)" 4
.IX Item "txcookie: int (optional)"
32 or 64 bit transmit cookie
.ie n .IP """rxcookie: int"" (optional)" 4
.el .IP "\f(CWrxcookie: int (optional)" 4
.IX Item "rxcookie: int (optional)"
32 or 64 bit receive cookie
.ie n .IP """txsession: int""" 4
.el .IP "\f(CWtxsession: int" 4
.IX Item "txsession: int"
32 bit transmit session
.ie n .IP """rxsession: int"" (optional)" 4
.el .IP "\f(CWrxsession: int (optional)" 4
.IX Item "rxsession: int (optional)"
32 bit receive session - if not specified
set to the same value as transmit
.ie n .IP """offset: int"" (optional)" 4
.el .IP "\f(CWoffset: int (optional)" 4
.IX Item "offset: int (optional)"
additional offset - allows the insertion of
additional application-specific data before the packet payload

**Since:**
2.1

**NetdevVdeOptions** (Object)

Connect to a vde switch running on the host.

**Members:**
.ie n .IP """sock: string"" (optional)" 4
.el .IP "\f(CWsock: string (optional)" 4
.IX Item "sock: string (optional)"
socket path
.ie n .IP """port: int"" (optional)" 4
.el .IP "\f(CWport: int (optional)" 4
.IX Item "port: int (optional)"
port number
.ie n .IP """group: string"" (optional)" 4
.el .IP "\f(CWgroup: string (optional)" 4
.IX Item "group: string (optional)"
group owner of socket
.ie n .IP """mode: int"" (optional)" 4
.el .IP "\f(CWmode: int (optional)" 4
.IX Item "mode: int (optional)"
permissions for socket

**Since:**
1.2

**NetdevBridgeOptions** (Object)

Connect a host \s-1TAP\s0 network interface to a host bridge device.

**Members:**
.ie n .IP """br: string"" (optional)" 4
.el .IP "\f(CWbr: string (optional)" 4
.IX Item "br: string (optional)"
bridge name
.ie n .IP """helper: string"" (optional)" 4
.el .IP "\f(CWhelper: string (optional)" 4
.IX Item "helper: string (optional)"
command to execute to configure bridge

**Since:**
1.2

**NetdevHubPortOptions** (Object)

Connect two or more net clients through a software hub.

**Members:**
.ie n .IP """hubid: int""" 4
.el .IP "\f(CWhubid: int" 4
.IX Item "hubid: int"
hub identifier number
.ie n .IP """netdev: string"" (optional)" 4
.el .IP "\f(CWnetdev: string (optional)" 4
.IX Item "netdev: string (optional)"
used to connect hub to a netdev instead of a device (since 2.12)

**Since:**
1.2

**NetdevNetmapOptions** (Object)

Connect a client to a netmap-enabled \s-1NIC\s0 or to a \s-1VALE\s0 switch port

**Members:**
.ie n .IP """ifname: string""" 4
.el .IP "\f(CWifname: string" 4
.IX Item "ifname: string"
Either the name of an existing network interface supported by
netmap, or the name of a \s-1VALE\s0 port (created on the fly).
A \s-1VALE\s0 port name is in the form 'valeXXX:YYY', where \s-1XXX\s0 and
\s-1YYY\s0 are non-negative integers. \s-1XXX\s0 identifies a switch and
\s-1YYY\s0 identifies a port of the switch. \s-1VALE\s0 ports having the
same \s-1XXX\s0 are therefore connected to the same switch.
.ie n .IP """devname: string"" (optional)" 4
.el .IP "\f(CWdevname: string (optional)" 4
.IX Item "devname: string (optional)"
path of the netmap device (default: '/dev/netmap').

**Since:**
2.0

**NetdevVhostUserOptions** (Object)

Vhost-user network backend

**Members:**
.ie n .IP """chardev: string""" 4
.el .IP "\f(CWchardev: string" 4
.IX Item "chardev: string"
name of a unix socket chardev
.ie n .IP """vhostforce: boolean"" (optional)" 4
.el .IP "\f(CWvhostforce: boolean (optional)" 4
.IX Item "vhostforce: boolean (optional)"
vhost on for non-MSIX virtio guests (default: false).
.ie n .IP """queues: int"" (optional)" 4
.el .IP "\f(CWqueues: int (optional)" 4
.IX Item "queues: int (optional)"
number of queues to be created for multiqueue vhost-user
(default: 1) (Since 2.5)

**Since:**
2.1

**NetClientDriver** (Enum)

Available netdev drivers.

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Not documented
.ie n .IP """nic""" 4
.el .IP "\f(CWnic" 4
.IX Item "nic"
Not documented
.ie n .IP """user""" 4
.el .IP "\f(CWuser" 4
.IX Item "user"
Not documented
.ie n .IP """tap""" 4
.el .IP "\f(CWtap" 4
.IX Item "tap"
Not documented
.ie n .IP """l2tpv3""" 4
.el .IP "\f(CWl2tpv3" 4
.IX Item "l2tpv3"
Not documented
.ie n .IP """socket""" 4
.el .IP "\f(CWsocket" 4
.IX Item "socket"
Not documented
.ie n .IP """vde""" 4
.el .IP "\f(CWvde" 4
.IX Item "vde"
Not documented
.ie n .IP """bridge""" 4
.el .IP "\f(CWbridge" 4
.IX Item "bridge"
Not documented
.ie n .IP """hubport""" 4
.el .IP "\f(CWhubport" 4
.IX Item "hubport"
Not documented
.ie n .IP """netmap""" 4
.el .IP "\f(CWnetmap" 4
.IX Item "netmap"
Not documented
.ie n .IP """vhost-user""" 4
.el .IP "\f(CWvhost-user" 4
.IX Item "vhost-user"
Not documented

**Since:**
2.7

'dump': dropped in 2.12

**Netdev** (Object)

Captures the configuration of a network device.

**Members:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
identifier for monitor commands.
.ie n .IP """type: NetClientDriver""" 4
.el .IP "\f(CWtype: NetClientDriver" 4
.IX Item "type: NetClientDriver"
Specify the driver used for interpreting remaining arguments.
.ie n .IP "The members of ""NetLegacyNicOptions"" when ""type"" is ""nic""" 4
.el .IP "The members of \f(CWNetLegacyNicOptions when \f(CWtype is \`\`nic''" 4
.IX Item "The members of NetLegacyNicOptions when type is nic"
.ie n .IP "The members of ""NetdevUserOptions"" when ""type"" is ""user""" 4
.el .IP "The members of \f(CWNetdevUserOptions when \f(CWtype is \`\`user''" 4
.IX Item "The members of NetdevUserOptions when type is user"
.ie n .IP "The members of ""NetdevTapOptions"" when ""type"" is ""tap""" 4
.el .IP "The members of \f(CWNetdevTapOptions when \f(CWtype is \`\`tap''" 4
.IX Item "The members of NetdevTapOptions when type is tap"
.ie n .IP "The members of ""NetdevL2TPv3Options"" when ""type"" is ""l2tpv3""" 4
.el .IP "The members of \f(CWNetdevL2TPv3Options when \f(CWtype is \`\`l2tpv3''" 4
.IX Item "The members of NetdevL2TPv3Options when type is l2tpv3"
.ie n .IP "The members of ""NetdevSocketOptions"" when ""type"" is ""socket""" 4
.el .IP "The members of \f(CWNetdevSocketOptions when \f(CWtype is \`\`socket''" 4
.IX Item "The members of NetdevSocketOptions when type is socket"
.ie n .IP "The members of ""NetdevVdeOptions"" when ""type"" is ""vde""" 4
.el .IP "The members of \f(CWNetdevVdeOptions when \f(CWtype is \`\`vde''" 4
.IX Item "The members of NetdevVdeOptions when type is vde"
.ie n .IP "The members of ""NetdevBridgeOptions"" when ""type"" is ""bridge""" 4
.el .IP "The members of \f(CWNetdevBridgeOptions when \f(CWtype is \`\`bridge''" 4
.IX Item "The members of NetdevBridgeOptions when type is bridge"
.ie n .IP "The members of ""NetdevHubPortOptions"" when ""type"" is ""hubport""" 4
.el .IP "The members of \f(CWNetdevHubPortOptions when \f(CWtype is \`\`hubport''" 4
.IX Item "The members of NetdevHubPortOptions when type is hubport"
.ie n .IP "The members of ""NetdevNetmapOptions"" when ""type"" is ""netmap""" 4
.el .IP "The members of \f(CWNetdevNetmapOptions when \f(CWtype is \`\`netmap''" 4
.IX Item "The members of NetdevNetmapOptions when type is netmap"
.ie n .IP "The members of ""NetdevVhostUserOptions"" when ""type"" is ""vhost-user""" 4
.el .IP "The members of \f(CWNetdevVhostUserOptions when \f(CWtype is \`\`vhost-user''" 4
.IX Item "The members of NetdevVhostUserOptions when type is vhost-user"

**Since:**
1.2

'l2tpv3' - since 2.1

**NetLegacy** (Object)

Captures the configuration of a network device; legacy.

**Members:**
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
identifier for monitor commands
.ie n .IP """name: string"" (optional)" 4
.el .IP "\f(CWname: string (optional)" 4
.IX Item "name: string (optional)"
identifier for monitor commands, ignored if \f(CW`id\*(C' is present
.ie n .IP """opts: NetLegacyOptions""" 4
.el .IP "\f(CWopts: NetLegacyOptions" 4
.IX Item "opts: NetLegacyOptions"
device type specific properties (legacy)

**Since:**
1.2

'vlan': dropped in 3.0

**NetLegacyOptionsType** (Enum)

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Not documented
.ie n .IP """nic""" 4
.el .IP "\f(CWnic" 4
.IX Item "nic"
Not documented
.ie n .IP """user""" 4
.el .IP "\f(CWuser" 4
.IX Item "user"
Not documented
.ie n .IP """tap""" 4
.el .IP "\f(CWtap" 4
.IX Item "tap"
Not documented
.ie n .IP """l2tpv3""" 4
.el .IP "\f(CWl2tpv3" 4
.IX Item "l2tpv3"
Not documented
.ie n .IP """socket""" 4
.el .IP "\f(CWsocket" 4
.IX Item "socket"
Not documented
.ie n .IP """vde""" 4
.el .IP "\f(CWvde" 4
.IX Item "vde"
Not documented
.ie n .IP """bridge""" 4
.el .IP "\f(CWbridge" 4
.IX Item "bridge"
Not documented
.ie n .IP """netmap""" 4
.el .IP "\f(CWnetmap" 4
.IX Item "netmap"
Not documented
.ie n .IP """vhost-user""" 4
.el .IP "\f(CWvhost-user" 4
.IX Item "vhost-user"
Not documented

**Since:**
1.2

**NetLegacyOptions** (Object)

Like Netdev, but for use only by the legacy command line options

**Members:**
.ie n .IP """type: NetLegacyOptionsType""" 4
.el .IP "\f(CWtype: NetLegacyOptionsType" 4
.IX Item "type: NetLegacyOptionsType"
Not documented
.ie n .IP "The members of ""NetLegacyNicOptions"" when ""type"" is ""nic""" 4
.el .IP "The members of \f(CWNetLegacyNicOptions when \f(CWtype is \`\`nic''" 4
.IX Item "The members of NetLegacyNicOptions when type is nic"
.ie n .IP "The members of ""NetdevUserOptions"" when ""type"" is ""user""" 4
.el .IP "The members of \f(CWNetdevUserOptions when \f(CWtype is \`\`user''" 4
.IX Item "The members of NetdevUserOptions when type is user"
.ie n .IP "The members of ""NetdevTapOptions"" when ""type"" is ""tap""" 4
.el .IP "The members of \f(CWNetdevTapOptions when \f(CWtype is \`\`tap''" 4
.IX Item "The members of NetdevTapOptions when type is tap"
.ie n .IP "The members of ""NetdevL2TPv3Options"" when ""type"" is ""l2tpv3""" 4
.el .IP "The members of \f(CWNetdevL2TPv3Options when \f(CWtype is \`\`l2tpv3''" 4
.IX Item "The members of NetdevL2TPv3Options when type is l2tpv3"
.ie n .IP "The members of ""NetdevSocketOptions"" when ""type"" is ""socket""" 4
.el .IP "The members of \f(CWNetdevSocketOptions when \f(CWtype is \`\`socket''" 4
.IX Item "The members of NetdevSocketOptions when type is socket"
.ie n .IP "The members of ""NetdevVdeOptions"" when ""type"" is ""vde""" 4
.el .IP "The members of \f(CWNetdevVdeOptions when \f(CWtype is \`\`vde''" 4
.IX Item "The members of NetdevVdeOptions when type is vde"
.ie n .IP "The members of ""NetdevBridgeOptions"" when ""type"" is ""bridge""" 4
.el .IP "The members of \f(CWNetdevBridgeOptions when \f(CWtype is \`\`bridge''" 4
.IX Item "The members of NetdevBridgeOptions when type is bridge"
.ie n .IP "The members of ""NetdevNetmapOptions"" when ""type"" is ""netmap""" 4
.el .IP "The members of \f(CWNetdevNetmapOptions when \f(CWtype is \`\`netmap''" 4
.IX Item "The members of NetdevNetmapOptions when type is netmap"
.ie n .IP "The members of ""NetdevVhostUserOptions"" when ""type"" is ""vhost-user""" 4
.el .IP "The members of \f(CWNetdevVhostUserOptions when \f(CWtype is \`\`vhost-user''" 4
.IX Item "The members of NetdevVhostUserOptions when type is vhost-user"

**Since:**
1.2

**NetFilterDirection** (Enum)

Indicates whether a netfilter is attached to a netdev's transmit queue or
receive queue or both.

**Values:**
.ie n .IP """all""" 4
.el .IP "\f(CWall" 4
.IX Item "all"
the filter is attached both to the receive and the transmit
queue of the netdev (default).
.ie n .IP """rx""" 4
.el .IP "\f(CWrx" 4
.IX Item "rx"
the filter is attached to the receive queue of the netdev,
where it will receive packets sent to the netdev.
.ie n .IP """tx""" 4
.el .IP "\f(CWtx" 4
.IX Item "tx"
the filter is attached to the transmit queue of the netdev,
where it will receive packets sent by the netdev.

**Since:**
2.5

**RxState** (Enum)

Packets receiving state

**Values:**
.ie n .IP """normal""" 4
.el .IP "\f(CWnormal" 4
.IX Item "normal"
filter assigned packets according to the mac-table
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
don't receive any assigned packet
.ie n .IP """all""" 4
.el .IP "\f(CWall" 4
.IX Item "all"
receive all assigned packets

**Since:**
1.6

**RxFilterInfo** (Object)

Rx-filter information for a \s-1NIC.\s0

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
net client name
.ie n .IP """promiscuous: boolean""" 4
.el .IP "\f(CWpromiscuous: boolean" 4
.IX Item "promiscuous: boolean"
whether promiscuous mode is enabled
.ie n .IP """multicast: RxState""" 4
.el .IP "\f(CWmulticast: RxState" 4
.IX Item "multicast: RxState"
multicast receive state
.ie n .IP """unicast: RxState""" 4
.el .IP "\f(CWunicast: RxState" 4
.IX Item "unicast: RxState"
unicast receive state
.ie n .IP """vlan: RxState""" 4
.el .IP "\f(CWvlan: RxState" 4
.IX Item "vlan: RxState"
vlan receive state (Since 2.0)
.ie n .IP """broadcast-allowed: boolean""" 4
.el .IP "\f(CWbroadcast-allowed: boolean" 4
.IX Item "broadcast-allowed: boolean"
whether to receive broadcast
.ie n .IP """multicast-overflow: boolean""" 4
.el .IP "\f(CWmulticast-overflow: boolean" 4
.IX Item "multicast-overflow: boolean"
multicast table is overflowed or not
.ie n .IP """unicast-overflow: boolean""" 4
.el .IP "\f(CWunicast-overflow: boolean" 4
.IX Item "unicast-overflow: boolean"
unicast table is overflowed or not
.ie n .IP """main-mac: string""" 4
.el .IP "\f(CWmain-mac: string" 4
.IX Item "main-mac: string"
the main macaddr string
.ie n .IP """vlan-table: array of int""" 4
.el .IP "\f(CWvlan-table: array of int" 4
.IX Item "vlan-table: array of int"
a list of active vlan id
.ie n .IP """unicast-table: array of string""" 4
.el .IP "\f(CWunicast-table: array of string" 4
.IX Item "unicast-table: array of string"
a list of unicast macaddr string
.ie n .IP """multicast-table: array of string""" 4
.el .IP "\f(CWmulticast-table: array of string" 4
.IX Item "multicast-table: array of string"
a list of multicast macaddr string

**Since:**
1.6

**query-rx-filter**  (Command)
Return rx-filter information for all NICs (or for the given \s-1NIC\s0).

**Arguments:**
.ie n .IP """name: string"" (optional)" 4
.el .IP "\f(CWname: string (optional)" 4
.IX Item "name: string (optional)"
net client name

**Returns:**
list of \f(CW`RxFilterInfo\*(C' for all NICs (or for the given \s-1NIC\s0).
Returns an error if the given \f(CW`name\*(C' doesn't exist, or given
\s-1NIC\s0 doesn't support rx-filter querying, or given net client
isn't a \s-1NIC.\s0

**Since:**
1.6

**Example:**

.Vb 10
        -&gt; { "execute": "query-rx-filter", "arguments": { "name": "vnet0" } }
        &lt;- { "return": [
                {
                    "promiscuous": true,
                    "name": "vnet0",
                    "main-mac": "52:54:00:12:34:56",
                    "unicast": "normal",
                    "vlan": "normal",
                    "vlan-table": [
                        4,
                        0
                    ],
                    "unicast-table": [
                    ],
                    "multicast": "normal",
                    "multicast-overflow": false,
                    "unicast-overflow": false,
                    "multicast-table": [
                        "01:00:5e:00:00:01",
                        "33:33:00:00:00:01",
                        "33:33:ff:12:34:56"
                    ],
                    "broadcast-allowed": false
                }
              ]
           }
.Ve

**\s-1NIC\_RX\_FILTER\_CHANGED\s0**  (Event)
Emitted once until the 'query-rx-filter' command is executed, the first event
will always be emitted

**Arguments:**
.ie n .IP """name: string"" (optional)" 4
.el .IP "\f(CWname: string (optional)" 4
.IX Item "name: string (optional)"
net client name
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
device path

**Since:**
1.6

**Example:**

.Vb 5
        &lt;- { "event": "NIC_RX_FILTER_CHANGED",
             "data": { "name": "vnet0",
                       "path": "/machine/peripheral/vnet0/virtio-backend" },
             "timestamp": { "seconds": 1368697518, "microseconds": 326866 } }
           }
.Ve

<a name="rocker-switch-device"></a>

### Rocker switch device

.IX Subsection "Rocker switch device"
**RockerSwitch** (Object)

Rocker switch information.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
switch name
.ie n .IP """id: int""" 4
.el .IP "\f(CWid: int" 4
.IX Item "id: int"
switch \s-1ID\s0
.ie n .IP """ports: int""" 4
.el .IP "\f(CWports: int" 4
.IX Item "ports: int"
number of front-panel ports

**Since:**
2.4

**query-rocker**  (Command)
Return rocker switch information.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
Not documented

**Returns:**
\f(CW`Rocker\*(C' information

**Since:**
2.4

**Example:**

.Vb 2
        -&gt; { "execute": "query-rocker", "arguments": { "name": "sw1" } }
        &lt;- { "return": {"name": "sw1", "ports": 2, "id": 1327446905938}}
.Ve

**RockerPortDuplex** (Enum)

An eumeration of port duplex states.

**Values:**
.ie n .IP """half""" 4
.el .IP "\f(CWhalf" 4
.IX Item "half"
half duplex
.ie n .IP """full""" 4
.el .IP "\f(CWfull" 4
.IX Item "full"
full duplex

**Since:**
2.4

**RockerPortAutoneg** (Enum)

An eumeration of port autoneg states.

**Values:**
.ie n .IP """off""" 4
.el .IP "\f(CWoff" 4
.IX Item "off"
autoneg is off
.ie n .IP """on""" 4
.el .IP "\f(CWon" 4
.IX Item "on"
autoneg is on

**Since:**
2.4

**RockerPort** (Object)

Rocker switch port information.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
port name
.ie n .IP """enabled: boolean""" 4
.el .IP "\f(CWenabled: boolean" 4
.IX Item "enabled: boolean"
port is enabled for I/O
.ie n .IP """link-up: boolean""" 4
.el .IP "\f(CWlink-up: boolean" 4
.IX Item "link-up: boolean"
physical link is \s-1UP\s0 on port
.ie n .IP """speed: int""" 4
.el .IP "\f(CWspeed: int" 4
.IX Item "speed: int"
port link speed in Mbps
.ie n .IP """duplex: RockerPortDuplex""" 4
.el .IP "\f(CWduplex: RockerPortDuplex" 4
.IX Item "duplex: RockerPortDuplex"
port link duplex
.ie n .IP """autoneg: RockerPortAutoneg""" 4
.el .IP "\f(CWautoneg: RockerPortAutoneg" 4
.IX Item "autoneg: RockerPortAutoneg"
port link autoneg

**Since:**
2.4

**query-rocker-ports**  (Command)
Return rocker switch port information.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
Not documented

**Returns:**
a list of \f(CW`RockerPort\*(C' information

**Since:**
2.4

**Example:**

.Vb 6
        -&gt; { "execute": "query-rocker-ports", "arguments": { "name": "sw1" } }
        &lt;- { "return": [ {"duplex": "full", "enabled": true, "name": "sw1.1",
                          "autoneg": "off", "link-up": true, "speed": 10000},
                         {"duplex": "full", "enabled": true, "name": "sw1.2",
                          "autoneg": "off", "link-up": true, "speed": 10000}
           ]}
.Ve

**RockerOfDpaFlowKey** (Object)

Rocker switch OF-DPA flow key

**Members:**
.ie n .IP """priority: int""" 4
.el .IP "\f(CWpriority: int" 4
.IX Item "priority: int"
key priority, 0 being lowest priority
.ie n .IP """tbl-id: int""" 4
.el .IP "\f(CWtbl-id: int" 4
.IX Item "tbl-id: int"
flow table \s-1ID\s0
.ie n .IP """in-pport: int"" (optional)" 4
.el .IP "\f(CWin-pport: int (optional)" 4
.IX Item "in-pport: int (optional)"
physical input port
.ie n .IP """tunnel-id: int"" (optional)" 4
.el .IP "\f(CWtunnel-id: int (optional)" 4
.IX Item "tunnel-id: int (optional)"
tunnel \s-1ID\s0
.ie n .IP """vlan-id: int"" (optional)" 4
.el .IP "\f(CWvlan-id: int (optional)" 4
.IX Item "vlan-id: int (optional)"
\s-1VLAN ID\s0
.ie n .IP """eth-type: int"" (optional)" 4
.el .IP "\f(CWeth-type: int (optional)" 4
.IX Item "eth-type: int (optional)"
Ethernet header type
.ie n .IP """eth-src: string"" (optional)" 4
.el .IP "\f(CWeth-src: string (optional)" 4
.IX Item "eth-src: string (optional)"
Ethernet header source \s-1MAC\s0 address
.ie n .IP """eth-dst: string"" (optional)" 4
.el .IP "\f(CWeth-dst: string (optional)" 4
.IX Item "eth-dst: string (optional)"
Ethernet header destination \s-1MAC\s0 address
.ie n .IP """ip-proto: int"" (optional)" 4
.el .IP "\f(CWip-proto: int (optional)" 4
.IX Item "ip-proto: int (optional)"
\s-1IP\s0 Header protocol field
.ie n .IP """ip-tos: int"" (optional)" 4
.el .IP "\f(CWip-tos: int (optional)" 4
.IX Item "ip-tos: int (optional)"
\s-1IP\s0 header \s-1TOS\s0 field
.ie n .IP """ip-dst: string"" (optional)" 4
.el .IP "\f(CWip-dst: string (optional)" 4
.IX Item "ip-dst: string (optional)"
\s-1IP\s0 header destination address

**Note:**
optional members may or may not appear in the flow key
depending if they're relevant to the flow key.

**Since:**
2.4

**RockerOfDpaFlowMask** (Object)

Rocker switch OF-DPA flow mask

**Members:**
.ie n .IP """in-pport: int"" (optional)" 4
.el .IP "\f(CWin-pport: int (optional)" 4
.IX Item "in-pport: int (optional)"
physical input port
.ie n .IP """tunnel-id: int"" (optional)" 4
.el .IP "\f(CWtunnel-id: int (optional)" 4
.IX Item "tunnel-id: int (optional)"
tunnel \s-1ID\s0
.ie n .IP """vlan-id: int"" (optional)" 4
.el .IP "\f(CWvlan-id: int (optional)" 4
.IX Item "vlan-id: int (optional)"
\s-1VLAN ID\s0
.ie n .IP """eth-src: string"" (optional)" 4
.el .IP "\f(CWeth-src: string (optional)" 4
.IX Item "eth-src: string (optional)"
Ethernet header source \s-1MAC\s0 address
.ie n .IP """eth-dst: string"" (optional)" 4
.el .IP "\f(CWeth-dst: string (optional)" 4
.IX Item "eth-dst: string (optional)"
Ethernet header destination \s-1MAC\s0 address
.ie n .IP """ip-proto: int"" (optional)" 4
.el .IP "\f(CWip-proto: int (optional)" 4
.IX Item "ip-proto: int (optional)"
\s-1IP\s0 Header protocol field
.ie n .IP """ip-tos: int"" (optional)" 4
.el .IP "\f(CWip-tos: int (optional)" 4
.IX Item "ip-tos: int (optional)"
\s-1IP\s0 header \s-1TOS\s0 field

**Note:**
optional members may or may not appear in the flow mask
depending if they're relevant to the flow mask.

**Since:**
2.4

**RockerOfDpaFlowAction** (Object)

Rocker switch OF-DPA flow action

**Members:**
.ie n .IP """goto-tbl: int"" (optional)" 4
.el .IP "\f(CWgoto-tbl: int (optional)" 4
.IX Item "goto-tbl: int (optional)"
next table \s-1ID\s0
.ie n .IP """group-id: int"" (optional)" 4
.el .IP "\f(CWgroup-id: int (optional)" 4
.IX Item "group-id: int (optional)"
group \s-1ID\s0
.ie n .IP """tunnel-lport: int"" (optional)" 4
.el .IP "\f(CWtunnel-lport: int (optional)" 4
.IX Item "tunnel-lport: int (optional)"
tunnel logical port \s-1ID\s0
.ie n .IP """vlan-id: int"" (optional)" 4
.el .IP "\f(CWvlan-id: int (optional)" 4
.IX Item "vlan-id: int (optional)"
\s-1VLAN ID\s0
.ie n .IP """new-vlan-id: int"" (optional)" 4
.el .IP "\f(CWnew-vlan-id: int (optional)" 4
.IX Item "new-vlan-id: int (optional)"
new \s-1VLAN ID\s0
.ie n .IP """out-pport: int"" (optional)" 4
.el .IP "\f(CWout-pport: int (optional)" 4
.IX Item "out-pport: int (optional)"
physical output port

**Note:**
optional members may or may not appear in the flow action
depending if they're relevant to the flow action.

**Since:**
2.4

**RockerOfDpaFlow** (Object)

Rocker switch OF-DPA flow

**Members:**
.ie n .IP """cookie: int""" 4
.el .IP "\f(CWcookie: int" 4
.IX Item "cookie: int"
flow unique cookie \s-1ID\s0
.ie n .IP """hits: int""" 4
.el .IP "\f(CWhits: int" 4
.IX Item "hits: int"
count of matches (hits) on flow
.ie n .IP """key: RockerOfDpaFlowKey""" 4
.el .IP "\f(CWkey: RockerOfDpaFlowKey" 4
.IX Item "key: RockerOfDpaFlowKey"
flow key
.ie n .IP """mask: RockerOfDpaFlowMask""" 4
.el .IP "\f(CWmask: RockerOfDpaFlowMask" 4
.IX Item "mask: RockerOfDpaFlowMask"
flow mask
.ie n .IP """action: RockerOfDpaFlowAction""" 4
.el .IP "\f(CWaction: RockerOfDpaFlowAction" 4
.IX Item "action: RockerOfDpaFlowAction"
flow action

**Since:**
2.4

**query-rocker-of-dpa-flows**  (Command)
Return rocker OF-DPA flow information.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
switch name
.ie n .IP """tbl-id: int"" (optional)" 4
.el .IP "\f(CWtbl-id: int (optional)" 4
.IX Item "tbl-id: int (optional)"
flow table \s-1ID.\s0  If tbl-id is not specified, returns
flow information for all tables.

**Returns:**
rocker OF-DPA flow information

**Since:**
2.4

**Example:**

.Vb 10
        -&gt; { "execute": "query-rocker-of-dpa-flows",
             "arguments": { "name": "sw1" } }
        &lt;- { "return": [ {"key": {"in-pport": 0, "priority": 1, "tbl-id": 0},
                          "hits": 138,
                          "cookie": 0,
                          "action": {"goto-tbl": 10},
                          "mask": {"in-pport": 4294901760}
                         },
                         {...more...},
           ]}
.Ve

**RockerOfDpaGroup** (Object)

Rocker switch OF-DPA group

**Members:**
.ie n .IP """id: int""" 4
.el .IP "\f(CWid: int" 4
.IX Item "id: int"
group unique \s-1ID\s0
.ie n .IP """type: int""" 4
.el .IP "\f(CWtype: int" 4
.IX Item "type: int"
group type
.ie n .IP """vlan-id: int"" (optional)" 4
.el .IP "\f(CWvlan-id: int (optional)" 4
.IX Item "vlan-id: int (optional)"
\s-1VLAN ID\s0
.ie n .IP """pport: int"" (optional)" 4
.el .IP "\f(CWpport: int (optional)" 4
.IX Item "pport: int (optional)"
physical port number
.ie n .IP """index: int"" (optional)" 4
.el .IP "\f(CWindex: int (optional)" 4
.IX Item "index: int (optional)"
group index, unique with group type
.ie n .IP """out-pport: int"" (optional)" 4
.el .IP "\f(CWout-pport: int (optional)" 4
.IX Item "out-pport: int (optional)"
output physical port number
.ie n .IP """group-id: int"" (optional)" 4
.el .IP "\f(CWgroup-id: int (optional)" 4
.IX Item "group-id: int (optional)"
next group \s-1ID\s0
.ie n .IP """set-vlan-id: int"" (optional)" 4
.el .IP "\f(CWset-vlan-id: int (optional)" 4
.IX Item "set-vlan-id: int (optional)"
\s-1VLAN ID\s0 to set
.ie n .IP """pop-vlan: int"" (optional)" 4
.el .IP "\f(CWpop-vlan: int (optional)" 4
.IX Item "pop-vlan: int (optional)"
pop \s-1VLAN\s0 headr from packet
.ie n .IP """group-ids: array of int"" (optional)" 4
.el .IP "\f(CWgroup-ids: array of int (optional)" 4
.IX Item "group-ids: array of int (optional)"
list of next group IDs
.ie n .IP """set-eth-src: string"" (optional)" 4
.el .IP "\f(CWset-eth-src: string (optional)" 4
.IX Item "set-eth-src: string (optional)"
set source \s-1MAC\s0 address in Ethernet header
.ie n .IP """set-eth-dst: string"" (optional)" 4
.el .IP "\f(CWset-eth-dst: string (optional)" 4
.IX Item "set-eth-dst: string (optional)"
set destination \s-1MAC\s0 address in Ethernet header
.ie n .IP """ttl-check: int"" (optional)" 4
.el .IP "\f(CWttl-check: int (optional)" 4
.IX Item "ttl-check: int (optional)"
perform \s-1TTL\s0 check

**Note:**
optional members may or may not appear in the group depending
if they're relevant to the group type.

**Since:**
2.4

**query-rocker-of-dpa-groups**  (Command)
Return rocker OF-DPA group information.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
switch name
.ie n .IP """type: int"" (optional)" 4
.el .IP "\f(CWtype: int (optional)" 4
.IX Item "type: int (optional)"
group type.  If type is not specified, returns
group information for all group types.

**Returns:**
rocker OF-DPA group information

**Since:**
2.4

**Example:**

.Vb 10
        -&gt; { "execute": "query-rocker-of-dpa-groups",
             "arguments": { "name": "sw1" } }
        &lt;- { "return": [ {"type": 0, "out-pport": 2,
                          "pport": 2, "vlan-id": 3841,
                          "pop-vlan": 1, "id": 251723778},
                         {"type": 0, "out-pport": 0,
                          "pport": 0, "vlan-id": 3841,
                          "pop-vlan": 1, "id": 251723776},
                         {"type": 0, "out-pport": 1,
                          "pport": 1, "vlan-id": 3840,
                          "pop-vlan": 1, "id": 251658241},
                         {"type": 0, "out-pport": 0,
                          "pport": 0, "vlan-id": 3840,
                          "pop-vlan": 1, "id": 251658240}
           ]}
.Ve

<a name="s-1tpms0-trusted-platform-module-devices"></a>

### \s-1TPM\s0 (trusted platform module) devices

.IX Subsection "TPM (trusted platform module) devices"
**TpmModel** (Enum)

An enumeration of \s-1TPM\s0 models

**Values:**
.ie n .IP """tpm-tis""" 4
.el .IP "\f(CWtpm-tis" 4
.IX Item "tpm-tis"
\s-1TPM TIS\s0 model
.ie n .IP """tpm-crb""" 4
.el .IP "\f(CWtpm-crb" 4
.IX Item "tpm-crb"
\s-1TPM CRB\s0 model (since 2.12)

**Since:**
1.5

**query-tpm-models**  (Command)
Return a list of supported \s-1TPM\s0 models

**Returns:**
a list of TpmModel

**Since:**
1.5

**Example:**

.Vb 2
        -&gt; { "execute": "query-tpm-models" }
        &lt;- { "return": [ "tpm-tis", "tpm-crb" ] }
.Ve

**TpmType** (Enum)

An enumeration of \s-1TPM\s0 types

**Values:**
.ie n .IP """passthrough""" 4
.el .IP "\f(CWpassthrough" 4
.IX Item "passthrough"
\s-1TPM\s0 passthrough type
.ie n .IP """emulator""" 4
.el .IP "\f(CWemulator" 4
.IX Item "emulator"
Software Emulator \s-1TPM\s0 type
Since: 2.11

**Since:**
1.5

**query-tpm-types**  (Command)
Return a list of supported \s-1TPM\s0 types

**Returns:**
a list of TpmType

**Since:**
1.5

**Example:**

.Vb 2
        -&gt; { "execute": "query-tpm-types" }
        &lt;- { "return": [ "passthrough", "emulator" ] }
.Ve

**TPMPassthroughOptions** (Object)

Information about the \s-1TPM\s0 passthrough type

**Members:**
.ie n .IP """path: string"" (optional)" 4
.el .IP "\f(CWpath: string (optional)" 4
.IX Item "path: string (optional)"
string describing the path used for accessing the \s-1TPM\s0 device
.ie n .IP """cancel-path: string"" (optional)" 4
.el .IP "\f(CWcancel-path: string (optional)" 4
.IX Item "cancel-path: string (optional)"
string showing the \s-1TPM\s0's sysfs cancel file
for cancellation of \s-1TPM\s0 commands while they are executing

**Since:**
1.5

**TPMEmulatorOptions** (Object)

Information about the \s-1TPM\s0 emulator type

**Members:**
.ie n .IP """chardev: string""" 4
.el .IP "\f(CWchardev: string" 4
.IX Item "chardev: string"
Name of a unix socket chardev

**Since:**
2.11

**TpmTypeOptions** (Object)

A union referencing different \s-1TPM\s0 backend types' configuration options

**Members:**
.ie n .IP """type""" 4
.el .IP "\f(CWtype" 4
.IX Item "type"
'passthrough' The configuration options for the \s-1TPM\s0 passthrough type
'emulator' The configuration options for \s-1TPM\s0 emulator backend type
.ie n .IP """data: TPMPassthroughOptions"" when ""type"" is ""passthrough""" 4
.el .IP "\f(CWdata: TPMPassthroughOptions when \f(CWtype is \`\`passthrough''" 4
.IX Item "data: TPMPassthroughOptions when type is passthrough"
.ie n .IP """data: TPMEmulatorOptions"" when ""type"" is ""emulator""" 4
.el .IP "\f(CWdata: TPMEmulatorOptions when \f(CWtype is \`\`emulator''" 4
.IX Item "data: TPMEmulatorOptions when type is emulator"

**Since:**
1.5

**TPMInfo** (Object)

Information about the \s-1TPM\s0

**Members:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
The Id of the \s-1TPM\s0
.ie n .IP """model: TpmModel""" 4
.el .IP "\f(CWmodel: TpmModel" 4
.IX Item "model: TpmModel"
The \s-1TPM\s0 frontend model
.ie n .IP """options: TpmTypeOptions""" 4
.el .IP "\f(CWoptions: TpmTypeOptions" 4
.IX Item "options: TpmTypeOptions"
The \s-1TPM\s0 (backend) type configuration options

**Since:**
1.5

**query-tpm**  (Command)
Return information about the \s-1TPM\s0 device

**Returns:**
\f(CW`TPMInfo\*(C' on success

**Since:**
1.5

**Example:**

.Vb 10
        -&gt; { "execute": "query-tpm" }
        &lt;- { "return":
             [
               { "model": "tpm-tis",
                 "options":
                   { "type": "passthrough",
                     "data":
                       { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
                         "path": "/dev/tpm0"
                       }
                   },
                 "id": "tpm0"
               }
             ]
           }
.Ve

<a name="remote-desktop"></a>

### Remote desktop

.IX Subsection "Remote desktop"
**set\_password**  (Command)
Sets the password of a remote display session.

**Arguments:**
.ie n .IP """protocol: string""" 4
.el .IP "\f(CWprotocol: string" 4
.IX Item "protocol: string"
\`vnc' to modify the \s-1VNC\s0 server password
\`spice' to modify the Spice server password
.ie n .IP """password: string""" 4
.el .IP "\f(CWpassword: string" 4
.IX Item "password: string"
the new password
.ie n .IP """connected: string"" (optional)" 4
.el .IP "\f(CWconnected: string (optional)" 4
.IX Item "connected: string (optional)"
how to handle existing clients when changing the
password.  If nothing is specified, defaults to \`keep'
\`fail' to fail the command if clients are connected
\`disconnect' to disconnect existing clients
\`keep' to maintain existing clients

**Returns:**
Nothing on success
If Spice is not enabled, DeviceNotFound

**Since:**
0.14.0

**Example:**

.Vb 3
        -&gt; { "execute": "set_password", "arguments": { "protocol": "vnc",
                                                       "password": "secret" } }
        &lt;- { "return": {} }
.Ve

**expire\_password**  (Command)
Expire the password of a remote display server.

**Arguments:**
.ie n .IP """protocol: string""" 4
.el .IP "\f(CWprotocol: string" 4
.IX Item "protocol: string"
the name of the remote display protocol \`vnc' or \`spice'
.ie n .IP """time: string""" 4
.el .IP "\f(CWtime: string" 4
.IX Item "time: string"
when to expire the password.
\`now' to expire the password immediately
\`never' to cancel password expiration
\`+INT' where \s-1INT\s0 is the number of seconds from now (integer)
\`\s-1INT\s0' where \s-1INT\s0 is the absolute time in seconds

**Returns:**
Nothing on success
If \f(CW`protocol\*(C' is \`spice' and Spice is not active, DeviceNotFound

**Since:**
0.14.0

**Notes:**
Time is relative to the server and currently there is no way to
coordinate server time with client time.  It is not recommended to
use the absolute time version of the \f(CW`time\*(C' parameter unless you're
sure you are on the same machine as the \s-1QEMU\s0 instance.

**Example:**

.Vb 3
        -&gt; { "execute": "expire_password", "arguments": { "protocol": "vnc",
                                                          "time": "+60" } }
        &lt;- { "return": {} }
.Ve

**screendump**  (Command)
Write a \s-1PPM\s0 of the \s-1VGA\s0 screen to a file.

**Arguments:**
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
the path of a new \s-1PPM\s0 file to store the image
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
\s-1ID\s0 of the display device that should be dumped. If this parameter
is missing, the primary display will be used. (Since 2.12)
.ie n .IP """head: int"" (optional)" 4
.el .IP "\f(CWhead: int (optional)" 4
.IX Item "head: int (optional)"
head to use in case the device supports multiple heads. If this
parameter is missing, head #0 will be used. Also note that the head
can only be specified in conjunction with the device \s-1ID.\s0 (Since 2.12)

**Returns:**
Nothing on success

**Since:**
0.14.0

**Example:**

.Vb 3
        -&gt; { "execute": "screendump",
             "arguments": { "filename": "/tmp/image" } }
        &lt;- { "return": {} }
.Ve

_Spice_
.IX Subsection "Spice"

**SpiceBasicInfo** (Object)

The basic information for \s-1SPICE\s0 network connection

**Members:**
.ie n .IP """host: string""" 4
.el .IP "\f(CWhost: string" 4
.IX Item "host: string"
\s-1IP\s0 address
.ie n .IP """port: string""" 4
.el .IP "\f(CWport: string" 4
.IX Item "port: string"
port number
.ie n .IP """family: NetworkAddressFamily""" 4
.el .IP "\f(CWfamily: NetworkAddressFamily" 4
.IX Item "family: NetworkAddressFamily"
address family

**Since:**
2.1

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**SpiceServerInfo** (Object)

Information about a \s-1SPICE\s0 server

**Members:**
.ie n .IP """auth: string"" (optional)" 4
.el .IP "\f(CWauth: string (optional)" 4
.IX Item "auth: string (optional)"
authentication method
.ie n .IP "The members of ""SpiceBasicInfo""" 4
.el .IP "The members of \f(CWSpiceBasicInfo" 4
.IX Item "The members of SpiceBasicInfo"

**Since:**
2.1

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**SpiceChannel** (Object)

Information about a \s-1SPICE\s0 client channel.

**Members:**
.ie n .IP """connection-id: int""" 4
.el .IP "\f(CWconnection-id: int" 4
.IX Item "connection-id: int"
\s-1SPICE\s0 connection id number.  All channels with the same id
belong to the same \s-1SPICE\s0 session.
.ie n .IP """channel-type: int""" 4
.el .IP "\f(CWchannel-type: int" 4
.IX Item "channel-type: int"
\s-1SPICE\s0 channel type number.  1\*(R" is the main control
channel, filter for this one if you want to track spice
sessions only
.ie n .IP """channel-id: int""" 4
.el .IP "\f(CWchannel-id: int" 4
.IX Item "channel-id: int"
\s-1SPICE\s0 channel \s-1ID\s0 number.  Usually 0\*(R", might be different when
multiple channels of the same type exist, such as multiple
display channels in a multihead setup
.ie n .IP """tls: boolean""" 4
.el .IP "\f(CWtls: boolean" 4
.IX Item "tls: boolean"
true if the channel is encrypted, false otherwise.
.ie n .IP "The members of ""SpiceBasicInfo""" 4
.el .IP "The members of \f(CWSpiceBasicInfo" 4
.IX Item "The members of SpiceBasicInfo"

**Since:**
0.14.0

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**SpiceQueryMouseMode** (Enum)

An enumeration of Spice mouse states.

**Values:**
.ie n .IP """client""" 4
.el .IP "\f(CWclient" 4
.IX Item "client"
Mouse cursor position is determined by the client.
.ie n .IP """server""" 4
.el .IP "\f(CWserver" 4
.IX Item "server"
Mouse cursor position is determined by the server.
.ie n .IP """unknown""" 4
.el .IP "\f(CWunknown" 4
.IX Item "unknown"
No information is available about mouse mode used by
the spice server.

**Note:**
spice/enums.h has a SpiceMouseMode already, hence the name.

**Since:**
1.1

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**SpiceInfo** (Object)

Information about the \s-1SPICE\s0 session.

**Members:**
.ie n .IP """enabled: boolean""" 4
.el .IP "\f(CWenabled: boolean" 4
.IX Item "enabled: boolean"
true if the \s-1SPICE\s0 server is enabled, false otherwise
.ie n .IP """migrated: boolean""" 4
.el .IP "\f(CWmigrated: boolean" 4
.IX Item "migrated: boolean"
true if the last guest migration completed and spice
migration had completed as well. false otherwise. (since 1.4)
.ie n .IP """host: string"" (optional)" 4
.el .IP "\f(CWhost: string (optional)" 4
.IX Item "host: string (optional)"
The hostname the \s-1SPICE\s0 server is bound to.  This depends on
the name resolution on the host and may be an \s-1IP\s0 address.
.ie n .IP """port: int"" (optional)" 4
.el .IP "\f(CWport: int (optional)" 4
.IX Item "port: int (optional)"
The \s-1SPICE\s0 server's port number.
.ie n .IP """compiled-version: string"" (optional)" 4
.el .IP "\f(CWcompiled-version: string (optional)" 4
.IX Item "compiled-version: string (optional)"
\s-1SPICE\s0 server version.
.ie n .IP """tls-port: int"" (optional)" 4
.el .IP "\f(CWtls-port: int (optional)" 4
.IX Item "tls-port: int (optional)"
The \s-1SPICE\s0 server's \s-1TLS\s0 port number.
.ie n .IP """auth: string"" (optional)" 4
.el .IP "\f(CWauth: string (optional)" 4
.IX Item "auth: string (optional)"
the current authentication type used by the server
'none'  if no authentication is being used
'spice' uses \s-1SASL\s0 or direct \s-1TLS\s0 authentication, depending on command
line options
.ie n .IP """mouse-mode: SpiceQueryMouseMode""" 4
.el .IP "\f(CWmouse-mode: SpiceQueryMouseMode" 4
.IX Item "mouse-mode: SpiceQueryMouseMode"
The mode in which the mouse cursor is displayed currently. Can
be determined by the client or the server, or unknown if spice
server doesn't provide this information. (since: 1.1)
.ie n .IP """channels: array of SpiceChannel"" (optional)" 4
.el .IP "\f(CWchannels: array of SpiceChannel (optional)" 4
.IX Item "channels: array of SpiceChannel (optional)"
a list of \f(CW`SpiceChannel\*(C' for each active spice channel

**Since:**
0.14.0

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**query-spice**  (Command)
Returns information about the current \s-1SPICE\s0 server

**Returns:**
\f(CW`SpiceInfo\*(C'

**Since:**
0.14.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-spice" }
        &lt;- { "return": {
                 "enabled": true,
                 "auth": "spice",
                 "port": 5920,
                 "tls-port": 5921,
                 "host": "0.0.0.0",
                 "channels": [
                    {
                       "port": "54924",
                       "family": "ipv4",
                       "channel-type": 1,
                       "connection-id": 1804289383,
                       "host": "127.0.0.1",
                       "channel-id": 0,
                       "tls": true
                    },
                    {
                       "port": "36710",
                       "family": "ipv4",
                       "channel-type": 4,
                       "connection-id": 1804289383,
                       "host": "127.0.0.1",
                       "channel-id": 0,
                       "tls": false
                    },
                    [ ... more channels follow ... ]
                 ]
              }
           }
.Ve

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**\s-1SPICE\_CONNECTED\s0**  (Event)
Emitted when a \s-1SPICE\s0 client establishes a connection

**Arguments:**
.ie n .IP """server: SpiceBasicInfo""" 4
.el .IP "\f(CWserver: SpiceBasicInfo" 4
.IX Item "server: SpiceBasicInfo"
server information
.ie n .IP """client: SpiceBasicInfo""" 4
.el .IP "\f(CWclient: SpiceBasicInfo" 4
.IX Item "client: SpiceBasicInfo"
client information

**Since:**
0.14.0

**Example:**

.Vb 6
        &lt;- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
             "event": "SPICE_CONNECTED",
             "data": {
               "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
               "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
           }}
.Ve

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**\s-1SPICE\_INITIALIZED\s0**  (Event)
Emitted after initial handshake and authentication takes place (if any)
and the \s-1SPICE\s0 channel is up and running

**Arguments:**
.ie n .IP """server: SpiceServerInfo""" 4
.el .IP "\f(CWserver: SpiceServerInfo" 4
.IX Item "server: SpiceServerInfo"
server information
.ie n .IP """client: SpiceChannel""" 4
.el .IP "\f(CWclient: SpiceChannel" 4
.IX Item "client: SpiceChannel"
client information

**Since:**
0.14.0

**Example:**

.Vb 8
        &lt;- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
             "event": "SPICE_INITIALIZED",
             "data": {"server": {"auth": "spice", "port": "5921",
                                 "family": "ipv4", "host": "127.0.0.1"},
                      "client": {"port": "49004", "family": "ipv4", "channel-type": 3,
                                 "connection-id": 1804289383, "host": "127.0.0.1",
                                 "channel-id": 0, "tls": true}
           }}
.Ve

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**\s-1SPICE\_DISCONNECTED\s0**  (Event)
Emitted when the \s-1SPICE\s0 connection is closed

**Arguments:**
.ie n .IP """server: SpiceBasicInfo""" 4
.el .IP "\f(CWserver: SpiceBasicInfo" 4
.IX Item "server: SpiceBasicInfo"
server information
.ie n .IP """client: SpiceBasicInfo""" 4
.el .IP "\f(CWclient: SpiceBasicInfo" 4
.IX Item "client: SpiceBasicInfo"
client information

**Since:**
0.14.0

**Example:**

.Vb 6
        &lt;- { "timestamp": {"seconds": 1290688046, "microseconds": 388707},
             "event": "SPICE_DISCONNECTED",
             "data": {
               "server": { "port": "5920", "family": "ipv4", "host": "127.0.0.1"},
               "client": {"port": "52873", "family": "ipv4", "host": "127.0.0.1"}
           }}
.Ve

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

**\s-1SPICE\_MIGRATE\_COMPLETED\s0**  (Event)
Emitted when \s-1SPICE\s0 migration has completed

**Since:**
1.3

**Example:**

.Vb 2
        &lt;- { "timestamp": {"seconds": 1290688046, "microseconds": 417172},
             "event": "SPICE_MIGRATE_COMPLETED" }
.Ve

**If:** \f(CW`defined(CONFIG\_SPICE)\*(C'

_\s-1VNC\s0_
.IX Subsection "VNC"

**VncBasicInfo** (Object)

The basic information for vnc network connection

**Members:**
.ie n .IP """host: string""" 4
.el .IP "\f(CWhost: string" 4
.IX Item "host: string"
\s-1IP\s0 address
.ie n .IP """service: string""" 4
.el .IP "\f(CWservice: string" 4
.IX Item "service: string"
The service name of the vnc port. This may depend on the host
system's service database so symbolic names should not be relied
on.
.ie n .IP """family: NetworkAddressFamily""" 4
.el .IP "\f(CWfamily: NetworkAddressFamily" 4
.IX Item "family: NetworkAddressFamily"
address family
.ie n .IP """websocket: boolean""" 4
.el .IP "\f(CWwebsocket: boolean" 4
.IX Item "websocket: boolean"
true in case the socket is a websocket (since 2.3).

**Since:**
2.1

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**VncServerInfo** (Object)

The network connection information for server

**Members:**
.ie n .IP """auth: string"" (optional)" 4
.el .IP "\f(CWauth: string (optional)" 4
.IX Item "auth: string (optional)"
authentication method used for
the plain (non-websocket) \s-1VNC\s0 server
.ie n .IP "The members of ""VncBasicInfo""" 4
.el .IP "The members of \f(CWVncBasicInfo" 4
.IX Item "The members of VncBasicInfo"

**Since:**
2.1

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**VncClientInfo** (Object)

Information about a connected \s-1VNC\s0 client.

**Members:**
.ie n .IP """x509_dname: string"" (optional)" 4
.el .IP "\f(CWx509_dname: string (optional)" 4
.IX Item "x509_dname: string (optional)"
If x509 authentication is in use, the Distinguished
Name of the client.
.ie n .IP """sasl_username: string"" (optional)" 4
.el .IP "\f(CWsasl_username: string (optional)" 4
.IX Item "sasl_username: string (optional)"
If \s-1SASL\s0 authentication is in use, the \s-1SASL\s0 username
used for authentication.
.ie n .IP "The members of ""VncBasicInfo""" 4
.el .IP "The members of \f(CWVncBasicInfo" 4
.IX Item "The members of VncBasicInfo"

**Since:**
0.14.0

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**VncInfo** (Object)

Information about the \s-1VNC\s0 session.

**Members:**
.ie n .IP """enabled: boolean""" 4
.el .IP "\f(CWenabled: boolean" 4
.IX Item "enabled: boolean"
true if the \s-1VNC\s0 server is enabled, false otherwise
.ie n .IP """host: string"" (optional)" 4
.el .IP "\f(CWhost: string (optional)" 4
.IX Item "host: string (optional)"
The hostname the \s-1VNC\s0 server is bound to.  This depends on
the name resolution on the host and may be an \s-1IP\s0 address.
.ie n .IP """family: NetworkAddressFamily"" (optional)" 4
.el .IP "\f(CWfamily: NetworkAddressFamily (optional)" 4
.IX Item "family: NetworkAddressFamily (optional)"
'ipv6' if the host is listening for IPv6 connections
'ipv4' if the host is listening for IPv4 connections
'unix' if the host is listening on a unix domain socket
'unknown' otherwise
.ie n .IP """service: string"" (optional)" 4
.el .IP "\f(CWservice: string (optional)" 4
.IX Item "service: string (optional)"
The service name of the server's port.  This may depends
on the host system's service database so symbolic names should not
be relied on.
.ie n .IP """auth: string"" (optional)" 4
.el .IP "\f(CWauth: string (optional)" 4
.IX Item "auth: string (optional)"
the current authentication type used by the server
'none' if no authentication is being used
'vnc' if \s-1VNC\s0 authentication is being used
'vencrypt+plain' if VEncrypt is used with plain text authentication
'vencrypt+tls+none' if VEncrypt is used with \s-1TLS\s0 and no authentication
'vencrypt+tls+vnc' if VEncrypt is used with \s-1TLS\s0 and \s-1VNC\s0 authentication
'vencrypt+tls+plain' if VEncrypt is used with \s-1TLS\s0 and plain text auth
'vencrypt+x509+none' if VEncrypt is used with x509 and no auth
'vencrypt+x509+vnc' if VEncrypt is used with x509 and \s-1VNC\s0 auth
'vencrypt+x509+plain' if VEncrypt is used with x509 and plain text auth
'vencrypt+tls+sasl' if VEncrypt is used with \s-1TLS\s0 and \s-1SASL\s0 auth
'vencrypt+x509+sasl' if VEncrypt is used with x509 and \s-1SASL\s0 auth
.ie n .IP """clients: array of VncClientInfo"" (optional)" 4
.el .IP "\f(CWclients: array of VncClientInfo (optional)" 4
.IX Item "clients: array of VncClientInfo (optional)"
a list of \f(CW`VncClientInfo\*(C' of all currently connected clients

**Since:**
0.14.0

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**VncPrimaryAuth** (Enum)

vnc primary authentication method.

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Not documented
.ie n .IP """vnc""" 4
.el .IP "\f(CWvnc" 4
.IX Item "vnc"
Not documented
.ie n .IP """ra2""" 4
.el .IP "\f(CWra2" 4
.IX Item "ra2"
Not documented
.ie n .IP """ra2ne""" 4
.el .IP "\f(CWra2ne" 4
.IX Item "ra2ne"
Not documented
.ie n .IP """tight""" 4
.el .IP "\f(CWtight" 4
.IX Item "tight"
Not documented
.ie n .IP """ultra""" 4
.el .IP "\f(CWultra" 4
.IX Item "ultra"
Not documented
.ie n .IP """tls""" 4
.el .IP "\f(CWtls" 4
.IX Item "tls"
Not documented
.ie n .IP """vencrypt""" 4
.el .IP "\f(CWvencrypt" 4
.IX Item "vencrypt"
Not documented
.ie n .IP """sasl""" 4
.el .IP "\f(CWsasl" 4
.IX Item "sasl"
Not documented

**Since:**
2.3

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**VncVencryptSubAuth** (Enum)

vnc sub authentication method with vencrypt.

**Values:**
.ie n .IP """plain""" 4
.el .IP "\f(CWplain" 4
.IX Item "plain"
Not documented
.ie n .IP """tls-none""" 4
.el .IP "\f(CWtls-none" 4
.IX Item "tls-none"
Not documented
.ie n .IP """x509-none""" 4
.el .IP "\f(CWx509-none" 4
.IX Item "x509-none"
Not documented
.ie n .IP """tls-vnc""" 4
.el .IP "\f(CWtls-vnc" 4
.IX Item "tls-vnc"
Not documented
.ie n .IP """x509-vnc""" 4
.el .IP "\f(CWx509-vnc" 4
.IX Item "x509-vnc"
Not documented
.ie n .IP """tls-plain""" 4
.el .IP "\f(CWtls-plain" 4
.IX Item "tls-plain"
Not documented
.ie n .IP """x509-plain""" 4
.el .IP "\f(CWx509-plain" 4
.IX Item "x509-plain"
Not documented
.ie n .IP """tls-sasl""" 4
.el .IP "\f(CWtls-sasl" 4
.IX Item "tls-sasl"
Not documented
.ie n .IP """x509-sasl""" 4
.el .IP "\f(CWx509-sasl" 4
.IX Item "x509-sasl"
Not documented

**Since:**
2.3

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**VncServerInfo2** (Object)

The network connection information for server

**Members:**
.ie n .IP """auth: VncPrimaryAuth""" 4
.el .IP "\f(CWauth: VncPrimaryAuth" 4
.IX Item "auth: VncPrimaryAuth"
The current authentication type used by the servers
.ie n .IP """vencrypt: VncVencryptSubAuth"" (optional)" 4
.el .IP "\f(CWvencrypt: VncVencryptSubAuth (optional)" 4
.IX Item "vencrypt: VncVencryptSubAuth (optional)"
The vencrypt sub authentication type used by the
servers, only specified in case auth == vencrypt.
.ie n .IP "The members of ""VncBasicInfo""" 4
.el .IP "The members of \f(CWVncBasicInfo" 4
.IX Item "The members of VncBasicInfo"

**Since:**
2.9

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**VncInfo2** (Object)

Information about a vnc server

**Members:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
vnc server name.
.ie n .IP """server: array of VncServerInfo2""" 4
.el .IP "\f(CWserver: array of VncServerInfo2" 4
.IX Item "server: array of VncServerInfo2"
A list of \f(CW`VncBasincInfo\*(C' describing all listening sockets.
The list can be empty (in case the vnc server is disabled).
It also may have multiple entries: normal + websocket,
possibly also ipv4 + ipv6 in the future.
.ie n .IP """clients: array of VncClientInfo""" 4
.el .IP "\f(CWclients: array of VncClientInfo" 4
.IX Item "clients: array of VncClientInfo"
A list of \f(CW`VncClientInfo\*(C' of all currently connected clients.
The list can be empty, for obvious reasons.
.ie n .IP """auth: VncPrimaryAuth""" 4
.el .IP "\f(CWauth: VncPrimaryAuth" 4
.IX Item "auth: VncPrimaryAuth"
The current authentication type used by the non-websockets servers
.ie n .IP """vencrypt: VncVencryptSubAuth"" (optional)" 4
.el .IP "\f(CWvencrypt: VncVencryptSubAuth (optional)" 4
.IX Item "vencrypt: VncVencryptSubAuth (optional)"
The vencrypt authentication type used by the servers,
only specified in case auth == vencrypt.
.ie n .IP """display: string"" (optional)" 4
.el .IP "\f(CWdisplay: string (optional)" 4
.IX Item "display: string (optional)"
The display device the vnc server is linked to.

**Since:**
2.3

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**query-vnc**  (Command)
Returns information about the current \s-1VNC\s0 server

**Returns:**
\f(CW`VncInfo\*(C'

**Since:**
0.14.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-vnc" }
        &lt;- { "return": {
                 "enabled":true,
                 "host":"0.0.0.0",
                 "service":"50402",
                 "auth":"vnc",
                 "family":"ipv4",
                 "clients":[
                    {
                       "host":"127.0.0.1",
                       "service":"50401",
                       "family":"ipv4"
                    }
                 ]
              }
           }
.Ve

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**query-vnc-servers**  (Command)
Returns a list of vnc servers.  The list can be empty.

**Returns:**
a list of \f(CW`VncInfo2\*(C'

**Since:**
2.3

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**change-vnc-password**  (Command)
Change the \s-1VNC\s0 server password.

**Arguments:**
.ie n .IP """password: string""" 4
.el .IP "\f(CWpassword: string" 4
.IX Item "password: string"
the new password to use with \s-1VNC\s0 authentication

**Since:**
1.1

**Notes:**
An empty password in this command will set the password to the empty
string.  Existing clients are unaffected by executing this command.

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**\s-1VNC\_CONNECTED\s0**  (Event)
Emitted when a \s-1VNC\s0 client establishes a connection

**Arguments:**
.ie n .IP """server: VncServerInfo""" 4
.el .IP "\f(CWserver: VncServerInfo" 4
.IX Item "server: VncServerInfo"
server information
.ie n .IP """client: VncBasicInfo""" 4
.el .IP "\f(CWclient: VncBasicInfo" 4
.IX Item "client: VncBasicInfo"
client information

**Note:**
This event is emitted before any authentication takes place, thus
the authentication \s-1ID\s0 is not provided

**Since:**
0.13.0

**Example:**

.Vb 7
        &lt;- { "event": "VNC_CONNECTED",
             "data": {
                   "server": { "auth": "sasl", "family": "ipv4",
                               "service": "5901", "host": "0.0.0.0" },
                   "client": { "family": "ipv4", "service": "58425",
                               "host": "127.0.0.1" } },
             "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
.Ve

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**\s-1VNC\_INITIALIZED\s0**  (Event)
Emitted after authentication takes place (if any) and the \s-1VNC\s0 session is
made active

**Arguments:**
.ie n .IP """server: VncServerInfo""" 4
.el .IP "\f(CWserver: VncServerInfo" 4
.IX Item "server: VncServerInfo"
server information
.ie n .IP """client: VncClientInfo""" 4
.el .IP "\f(CWclient: VncClientInfo" 4
.IX Item "client: VncClientInfo"
client information

**Since:**
0.13.0

**Example:**

.Vb 7
        &lt;-  { "event": "VNC_INITIALIZED",
              "data": {
                   "server": { "auth": "sasl", "family": "ipv4",
                               "service": "5901", "host": "0.0.0.0"},
                   "client": { "family": "ipv4", "service": "46089",
                               "host": "127.0.0.1", "sasl_username": "luiz" } },
              "timestamp": { "seconds": 1263475302, "microseconds": 150772 } }
.Ve

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

**\s-1VNC\_DISCONNECTED\s0**  (Event)
Emitted when the connection is closed

**Arguments:**
.ie n .IP """server: VncServerInfo""" 4
.el .IP "\f(CWserver: VncServerInfo" 4
.IX Item "server: VncServerInfo"
server information
.ie n .IP """client: VncClientInfo""" 4
.el .IP "\f(CWclient: VncClientInfo" 4
.IX Item "client: VncClientInfo"
client information

**Since:**
0.13.0

**Example:**

.Vb 7
        &lt;- { "event": "VNC_DISCONNECTED",
             "data": {
                   "server": { "auth": "sasl", "family": "ipv4",
                               "service": "5901", "host": "0.0.0.0" },
                   "client": { "family": "ipv4", "service": "58425",
                               "host": "127.0.0.1", "sasl_username": "luiz" } },
             "timestamp": { "seconds": 1262976601, "microseconds": 975795 } }
.Ve

**If:** \f(CW`defined(CONFIG\_VNC)\*(C'

<a name="input"></a>

### Input

.IX Subsection "Input"
**MouseInfo** (Object)

Information about a mouse device.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the name of the mouse device
.ie n .IP """index: int""" 4
.el .IP "\f(CWindex: int" 4
.IX Item "index: int"
the index of the mouse device
.ie n .IP """current: boolean""" 4
.el .IP "\f(CWcurrent: boolean" 4
.IX Item "current: boolean"
true if this device is currently receiving mouse events
.ie n .IP """absolute: boolean""" 4
.el .IP "\f(CWabsolute: boolean" 4
.IX Item "absolute: boolean"
true if this device supports absolute coordinates as input

**Since:**
0.14.0

**query-mice**  (Command)
Returns information about each active mouse device

**Returns:**
a list of \f(CW`MouseInfo\*(C' for each device

**Since:**
0.14.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-mice" }
        &lt;- { "return": [
                 {
                    "name":"QEMU Microsoft Mouse",
                    "index":0,
                    "current":false,
                    "absolute":false
                 },
                 {
                    "name":"QEMU PS/2 Mouse",
                    "index":1,
                    "current":true,
                    "absolute":true
                 }
              ]
           }
.Ve

**QKeyCode** (Enum)

An enumeration of key name.

This is used by the \f(CW`send-key\*(C' command.

**Values:**
.ie n .IP """unmapped""" 4
.el .IP "\f(CWunmapped" 4
.IX Item "unmapped"
since 2.0
.ie n .IP """pause""" 4
.el .IP "\f(CWpause" 4
.IX Item "pause"
since 2.0
.ie n .IP """ro""" 4
.el .IP "\f(CWro" 4
.IX Item "ro"
since 2.4
.ie n .IP """kp_comma""" 4
.el .IP "\f(CWkp\_comma" 4
.IX Item "kp_comma"
since 2.4
.ie n .IP """kp_equals""" 4
.el .IP "\f(CWkp\_equals" 4
.IX Item "kp_equals"
since 2.6
.ie n .IP """power""" 4
.el .IP "\f(CWpower" 4
.IX Item "power"
since 2.6
.ie n .IP """hiragana""" 4
.el .IP "\f(CWhiragana" 4
.IX Item "hiragana"
since 2.9
.ie n .IP """henkan""" 4
.el .IP "\f(CWhenkan" 4
.IX Item "henkan"
since 2.9
.ie n .IP """yen""" 4
.el .IP "\f(CWyen" 4
.IX Item "yen"
since 2.9
.ie n .IP """sleep""" 4
.el .IP "\f(CWsleep" 4
.IX Item "sleep"
since 2.10
.ie n .IP """wake""" 4
.el .IP "\f(CWwake" 4
.IX Item "wake"
since 2.10
.ie n .IP """audionext""" 4
.el .IP "\f(CWaudionext" 4
.IX Item "audionext"
since 2.10
.ie n .IP """audioprev""" 4
.el .IP "\f(CWaudioprev" 4
.IX Item "audioprev"
since 2.10
.ie n .IP """audiostop""" 4
.el .IP "\f(CWaudiostop" 4
.IX Item "audiostop"
since 2.10
.ie n .IP """audioplay""" 4
.el .IP "\f(CWaudioplay" 4
.IX Item "audioplay"
since 2.10
.ie n .IP """audiomute""" 4
.el .IP "\f(CWaudiomute" 4
.IX Item "audiomute"
since 2.10
.ie n .IP """volumeup""" 4
.el .IP "\f(CWvolumeup" 4
.IX Item "volumeup"
since 2.10
.ie n .IP """volumedown""" 4
.el .IP "\f(CWvolumedown" 4
.IX Item "volumedown"
since 2.10
.ie n .IP """mediaselect""" 4
.el .IP "\f(CWmediaselect" 4
.IX Item "mediaselect"
since 2.10
.ie n .IP """mail""" 4
.el .IP "\f(CWmail" 4
.IX Item "mail"
since 2.10
.ie n .IP """calculator""" 4
.el .IP "\f(CWcalculator" 4
.IX Item "calculator"
since 2.10
.ie n .IP """computer""" 4
.el .IP "\f(CWcomputer" 4
.IX Item "computer"
since 2.10
.ie n .IP """ac_home""" 4
.el .IP "\f(CWac\_home" 4
.IX Item "ac_home"
since 2.10
.ie n .IP """ac_back""" 4
.el .IP "\f(CWac\_back" 4
.IX Item "ac_back"
since 2.10
.ie n .IP """ac_forward""" 4
.el .IP "\f(CWac\_forward" 4
.IX Item "ac_forward"
since 2.10
.ie n .IP """ac_refresh""" 4
.el .IP "\f(CWac\_refresh" 4
.IX Item "ac_refresh"
since 2.10
.ie n .IP """ac_bookmarks""" 4
.el .IP "\f(CWac\_bookmarks" 4
.IX Item "ac_bookmarks"
since 2.10
altgr, altgr_r: dropped in 2.10
.ie n .IP """muhenkan""" 4
.el .IP "\f(CWmuhenkan" 4
.IX Item "muhenkan"
since 2.12
.ie n .IP """katakanahiragana""" 4
.el .IP "\f(CWkatakanahiragana" 4
.IX Item "katakanahiragana"
since 2.12
.ie n .IP """shift""" 4
.el .IP "\f(CWshift" 4
.IX Item "shift"
Not documented
.ie n .IP """shift_r""" 4
.el .IP "\f(CWshift\_r" 4
.IX Item "shift_r"
Not documented
.ie n .IP """alt""" 4
.el .IP "\f(CWalt" 4
.IX Item "alt"
Not documented
.ie n .IP """alt_r""" 4
.el .IP "\f(CWalt\_r" 4
.IX Item "alt_r"
Not documented
.ie n .IP """ctrl""" 4
.el .IP "\f(CWctrl" 4
.IX Item "ctrl"
Not documented
.ie n .IP """ctrl_r""" 4
.el .IP "\f(CWctrl\_r" 4
.IX Item "ctrl_r"
Not documented
.ie n .IP """menu""" 4
.el .IP "\f(CWmenu" 4
.IX Item "menu"
Not documented
.ie n .IP """esc""" 4
.el .IP "\f(CWesc" 4
.IX Item "esc"
Not documented
.ie n .IP "1" 4
.el .IP "\f(CW1" 4
.IX Item "1"
Not documented
.ie n .IP "2" 4
.el .IP "\f(CW2" 4
.IX Item "2"
Not documented
.ie n .IP "3" 4
.el .IP "\f(CW3" 4
.IX Item "3"
Not documented
.ie n .IP "4" 4
.el .IP "\f(CW4" 4
.IX Item "4"
Not documented
.ie n .IP "5" 4
.el .IP "\f(CW5" 4
.IX Item "5"
Not documented
.ie n .IP "6" 4
.el .IP "\f(CW6" 4
.IX Item "6"
Not documented
.ie n .IP "7" 4
.el .IP "\f(CW7" 4
.IX Item "7"
Not documented
.ie n .IP "8" 4
.el .IP "\f(CW8" 4
.IX Item "8"
Not documented
.ie n .IP "9" 4
.el .IP "\f(CW9" 4
.IX Item "9"
Not documented
.ie n .IP "0" 4
.el .IP "\f(CW0" 4
.IX Item "0"
Not documented
.ie n .IP """minus""" 4
.el .IP "\f(CWminus" 4
.IX Item "minus"
Not documented
.ie n .IP """equal""" 4
.el .IP "\f(CWequal" 4
.IX Item "equal"
Not documented
.ie n .IP """backspace""" 4
.el .IP "\f(CWbackspace" 4
.IX Item "backspace"
Not documented
.ie n .IP """tab""" 4
.el .IP "\f(CWtab" 4
.IX Item "tab"
Not documented
.ie n .IP """q""" 4
.el .IP "\f(CWq" 4
.IX Item "q"
Not documented
.ie n .IP """w""" 4
.el .IP "\f(CWw" 4
.IX Item "w"
Not documented
.ie n .IP """e""" 4
.el .IP "\f(CWe" 4
.IX Item "e"
Not documented
.ie n .IP """r""" 4
.el .IP "\f(CWr" 4
.IX Item "r"
Not documented
.ie n .IP """t""" 4
.el .IP "\f(CWt" 4
.IX Item "t"
Not documented
.ie n .IP """y""" 4
.el .IP "\f(CWy" 4
.IX Item "y"
Not documented
.ie n .IP """u""" 4
.el .IP "\f(CWu" 4
.IX Item "u"
Not documented
.ie n .IP """i""" 4
.el .IP "\f(CWi" 4
.IX Item "i"
Not documented
.ie n .IP """o""" 4
.el .IP "\f(CWo" 4
.IX Item "o"
Not documented
.ie n .IP """p""" 4
.el .IP "\f(CWp" 4
.IX Item "p"
Not documented
.ie n .IP """bracket_left""" 4
.el .IP "\f(CWbracket\_left" 4
.IX Item "bracket_left"
Not documented
.ie n .IP """bracket_right""" 4
.el .IP "\f(CWbracket\_right" 4
.IX Item "bracket_right"
Not documented
.ie n .IP """ret""" 4
.el .IP "\f(CWret" 4
.IX Item "ret"
Not documented
.ie n .IP """a""" 4
.el .IP "\f(CWa" 4
.IX Item "a"
Not documented
.ie n .IP """s""" 4
.el .IP "\f(CWs" 4
.IX Item "s"
Not documented
.ie n .IP """d""" 4
.el .IP "\f(CWd" 4
.IX Item "d"
Not documented
.ie n .IP """f""" 4
.el .IP "\f(CWf" 4
.IX Item "f"
Not documented
.ie n .IP """g""" 4
.el .IP "\f(CWg" 4
.IX Item "g"
Not documented
.ie n .IP """h""" 4
.el .IP "\f(CWh" 4
.IX Item "h"
Not documented
.ie n .IP """j""" 4
.el .IP "\f(CWj" 4
.IX Item "j"
Not documented
.ie n .IP """k""" 4
.el .IP "\f(CWk" 4
.IX Item "k"
Not documented
.ie n .IP """l""" 4
.el .IP "\f(CWl" 4
.IX Item "l"
Not documented
.ie n .IP """semicolon""" 4
.el .IP "\f(CWsemicolon" 4
.IX Item "semicolon"
Not documented
.ie n .IP """apostrophe""" 4
.el .IP "\f(CWapostrophe" 4
.IX Item "apostrophe"
Not documented
.ie n .IP """grave_accent""" 4
.el .IP "\f(CWgrave\_accent" 4
.IX Item "grave_accent"
Not documented
.ie n .IP """backslash""" 4
.el .IP "\f(CWbackslash" 4
.IX Item "backslash"
Not documented
.ie n .IP """z""" 4
.el .IP "\f(CWz" 4
.IX Item "z"
Not documented
.ie n .IP """x""" 4
.el .IP "\f(CWx" 4
.IX Item "x"
Not documented
.ie n .IP """c""" 4
.el .IP "\f(CWc" 4
.IX Item "c"
Not documented
.ie n .IP """v""" 4
.el .IP "\f(CWv" 4
.IX Item "v"
Not documented
.ie n .IP """b""" 4
.el .IP "\f(CWb" 4
.IX Item "b"
Not documented
.ie n .IP """n""" 4
.el .IP "\f(CWn" 4
.IX Item "n"
Not documented
.ie n .IP """m""" 4
.el .IP "\f(CWm" 4
.IX Item "m"
Not documented
.ie n .IP """comma""" 4
.el .IP "\f(CWcomma" 4
.IX Item "comma"
Not documented
.ie n .IP """dot""" 4
.el .IP "\f(CWdot" 4
.IX Item "dot"
Not documented
.ie n .IP """slash""" 4
.el .IP "\f(CWslash" 4
.IX Item "slash"
Not documented
.ie n .IP """asterisk""" 4
.el .IP "\f(CWasterisk" 4
.IX Item "asterisk"
Not documented
.ie n .IP """spc""" 4
.el .IP "\f(CWspc" 4
.IX Item "spc"
Not documented
.ie n .IP """caps_lock""" 4
.el .IP "\f(CWcaps\_lock" 4
.IX Item "caps_lock"
Not documented
.ie n .IP """f1""" 4
.el .IP "\f(CWf1" 4
.IX Item "f1"
Not documented
.ie n .IP """f2""" 4
.el .IP "\f(CWf2" 4
.IX Item "f2"
Not documented
.ie n .IP """f3""" 4
.el .IP "\f(CWf3" 4
.IX Item "f3"
Not documented
.ie n .IP """f4""" 4
.el .IP "\f(CWf4" 4
.IX Item "f4"
Not documented
.ie n .IP """f5""" 4
.el .IP "\f(CWf5" 4
.IX Item "f5"
Not documented
.ie n .IP """f6""" 4
.el .IP "\f(CWf6" 4
.IX Item "f6"
Not documented
.ie n .IP """f7""" 4
.el .IP "\f(CWf7" 4
.IX Item "f7"
Not documented
.ie n .IP """f8""" 4
.el .IP "\f(CWf8" 4
.IX Item "f8"
Not documented
.ie n .IP """f9""" 4
.el .IP "\f(CWf9" 4
.IX Item "f9"
Not documented
.ie n .IP """f10""" 4
.el .IP "\f(CWf10" 4
.IX Item "f10"
Not documented
.ie n .IP """num_lock""" 4
.el .IP "\f(CWnum\_lock" 4
.IX Item "num_lock"
Not documented
.ie n .IP """scroll_lock""" 4
.el .IP "\f(CWscroll\_lock" 4
.IX Item "scroll_lock"
Not documented
.ie n .IP """kp_divide""" 4
.el .IP "\f(CWkp\_divide" 4
.IX Item "kp_divide"
Not documented
.ie n .IP """kp_multiply""" 4
.el .IP "\f(CWkp\_multiply" 4
.IX Item "kp_multiply"
Not documented
.ie n .IP """kp_subtract""" 4
.el .IP "\f(CWkp\_subtract" 4
.IX Item "kp_subtract"
Not documented
.ie n .IP """kp_add""" 4
.el .IP "\f(CWkp\_add" 4
.IX Item "kp_add"
Not documented
.ie n .IP """kp_enter""" 4
.el .IP "\f(CWkp\_enter" 4
.IX Item "kp_enter"
Not documented
.ie n .IP """kp_decimal""" 4
.el .IP "\f(CWkp\_decimal" 4
.IX Item "kp_decimal"
Not documented
.ie n .IP """sysrq""" 4
.el .IP "\f(CWsysrq" 4
.IX Item "sysrq"
Not documented
.ie n .IP """kp_0""" 4
.el .IP "\f(CWkp\_0" 4
.IX Item "kp_0"
Not documented
.ie n .IP """kp_1""" 4
.el .IP "\f(CWkp\_1" 4
.IX Item "kp_1"
Not documented
.ie n .IP """kp_2""" 4
.el .IP "\f(CWkp\_2" 4
.IX Item "kp_2"
Not documented
.ie n .IP """kp_3""" 4
.el .IP "\f(CWkp\_3" 4
.IX Item "kp_3"
Not documented
.ie n .IP """kp_4""" 4
.el .IP "\f(CWkp\_4" 4
.IX Item "kp_4"
Not documented
.ie n .IP """kp_5""" 4
.el .IP "\f(CWkp\_5" 4
.IX Item "kp_5"
Not documented
.ie n .IP """kp_6""" 4
.el .IP "\f(CWkp\_6" 4
.IX Item "kp_6"
Not documented
.ie n .IP """kp_7""" 4
.el .IP "\f(CWkp\_7" 4
.IX Item "kp_7"
Not documented
.ie n .IP """kp_8""" 4
.el .IP "\f(CWkp\_8" 4
.IX Item "kp_8"
Not documented
.ie n .IP """kp_9""" 4
.el .IP "\f(CWkp\_9" 4
.IX Item "kp_9"
Not documented
.ie n .IP """less""" 4
.el .IP "\f(CWless" 4
.IX Item "less"
Not documented
.ie n .IP """f11""" 4
.el .IP "\f(CWf11" 4
.IX Item "f11"
Not documented
.ie n .IP """f12""" 4
.el .IP "\f(CWf12" 4
.IX Item "f12"
Not documented
.ie n .IP """print""" 4
.el .IP "\f(CWprint" 4
.IX Item "print"
Not documented
.ie n .IP """home""" 4
.el .IP "\f(CWhome" 4
.IX Item "home"
Not documented
.ie n .IP """pgup""" 4
.el .IP "\f(CWpgup" 4
.IX Item "pgup"
Not documented
.ie n .IP """pgdn""" 4
.el .IP "\f(CWpgdn" 4
.IX Item "pgdn"
Not documented
.ie n .IP """end""" 4
.el .IP "\f(CWend" 4
.IX Item "end"
Not documented
.ie n .IP """left""" 4
.el .IP "\f(CWleft" 4
.IX Item "left"
Not documented
.ie n .IP """up""" 4
.el .IP "\f(CWup" 4
.IX Item "up"
Not documented
.ie n .IP """down""" 4
.el .IP "\f(CWdown" 4
.IX Item "down"
Not documented
.ie n .IP """right""" 4
.el .IP "\f(CWright" 4
.IX Item "right"
Not documented
.ie n .IP """insert""" 4
.el .IP "\f(CWinsert" 4
.IX Item "insert"
Not documented
.ie n .IP """delete""" 4
.el .IP "\f(CWdelete" 4
.IX Item "delete"
Not documented
.ie n .IP """stop""" 4
.el .IP "\f(CWstop" 4
.IX Item "stop"
Not documented
.ie n .IP """again""" 4
.el .IP "\f(CWagain" 4
.IX Item "again"
Not documented
.ie n .IP """props""" 4
.el .IP "\f(CWprops" 4
.IX Item "props"
Not documented
.ie n .IP """undo""" 4
.el .IP "\f(CWundo" 4
.IX Item "undo"
Not documented
.ie n .IP """front""" 4
.el .IP "\f(CWfront" 4
.IX Item "front"
Not documented
.ie n .IP """copy""" 4
.el .IP "\f(CWcopy" 4
.IX Item "copy"
Not documented
.ie n .IP """open""" 4
.el .IP "\f(CWopen" 4
.IX Item "open"
Not documented
.ie n .IP """paste""" 4
.el .IP "\f(CWpaste" 4
.IX Item "paste"
Not documented
.ie n .IP """find""" 4
.el .IP "\f(CWfind" 4
.IX Item "find"
Not documented
.ie n .IP """cut""" 4
.el .IP "\f(CWcut" 4
.IX Item "cut"
Not documented
.ie n .IP """lf""" 4
.el .IP "\f(CWlf" 4
.IX Item "lf"
Not documented
.ie n .IP """help""" 4
.el .IP "\f(CWhelp" 4
.IX Item "help"
Not documented
.ie n .IP """meta_l""" 4
.el .IP "\f(CWmeta\_l" 4
.IX Item "meta_l"
Not documented
.ie n .IP """meta_r""" 4
.el .IP "\f(CWmeta\_r" 4
.IX Item "meta_r"
Not documented
.ie n .IP """compose""" 4
.el .IP "\f(CWcompose" 4
.IX Item "compose"
Not documented

'sysrq' was mistakenly added to hack around the fact that
the ps2 driver was not generating correct scancodes sequences
when 'alt+print' was pressed. This flaw is now fixed and the
'sysrq' key serves no further purpose. Any further use of
'sysrq' will be transparently changed to 'print', so they
are effectively synonyms.

**Since:**
1.3.0

**KeyValue** (Object)

Represents a keyboard key.

**Members:**
.ie n .IP """type""" 4
.el .IP "\f(CWtype" 4
.IX Item "type"
One of number\*(R", \*(L"qcode\*(R"
.ie n .IP """data: int"" when ""type"" is ""number""" 4
.el .IP "\f(CWdata: int when \f(CWtype is \`\`number''" 4
.IX Item "data: int when type is number"
.ie n .IP """data: QKeyCode"" when ""type"" is ""qcode""" 4
.el .IP "\f(CWdata: QKeyCode when \f(CWtype is \`\`qcode''" 4
.IX Item "data: QKeyCode when type is qcode"

**Since:**
1.3.0

**send-key**  (Command)
Send keys to guest.

**Arguments:**
.ie n .IP """keys: array of KeyValue""" 4
.el .IP "\f(CWkeys: array of KeyValue" 4
.IX Item "keys: array of KeyValue"
An array of \f(CW`KeyValue\*(C' elements. All \f(CW\*(C\`KeyValues\*(C' in this array are
simultaneously sent to the guest. A \f(CW`KeyValue\*(C'.number value is sent
directly to the guest, while \f(CW`KeyValue\*(C'.qcode must be a valid
\f(CW`QKeyCode\*(C' value
.ie n .IP """hold-time: int"" (optional)" 4
.el .IP "\f(CWhold-time: int (optional)" 4
.IX Item "hold-time: int (optional)"
time to delay key up events, milliseconds. Defaults
to 100

**Returns:**
Nothing on success
If key is unknown or redundant, InvalidParameter

**Since:**
1.3.0

**Example:**

.Vb 5
        -&gt; { "execute": "send-key",
             "arguments": { "keys": [ { "type": "qcode", "data": "ctrl" },
                                      { "type": "qcode", "data": "alt" },
                                      { "type": "qcode", "data": "delete" } ] } }
        &lt;- { "return": {} }
.Ve

**InputButton** (Enum)

Button of a pointer input device (mouse, tablet).

**Values:**
.ie n .IP """side""" 4
.el .IP "\f(CWside" 4
.IX Item "side"
front side button of a 5-button mouse (since 2.9)
.ie n .IP """extra""" 4
.el .IP "\f(CWextra" 4
.IX Item "extra"
rear side button of a 5-button mouse (since 2.9)
.ie n .IP """left""" 4
.el .IP "\f(CWleft" 4
.IX Item "left"
Not documented
.ie n .IP """middle""" 4
.el .IP "\f(CWmiddle" 4
.IX Item "middle"
Not documented
.ie n .IP """right""" 4
.el .IP "\f(CWright" 4
.IX Item "right"
Not documented
.ie n .IP """wheel-up""" 4
.el .IP "\f(CWwheel-up" 4
.IX Item "wheel-up"
Not documented
.ie n .IP """wheel-down""" 4
.el .IP "\f(CWwheel-down" 4
.IX Item "wheel-down"
Not documented

**Since:**
2.0

**InputAxis** (Enum)

Position axis of a pointer input device (mouse, tablet).

**Values:**
.ie n .IP """x""" 4
.el .IP "\f(CWx" 4
.IX Item "x"
Not documented
.ie n .IP """y""" 4
.el .IP "\f(CWy" 4
.IX Item "y"
Not documented

**Since:**
2.0

**InputKeyEvent** (Object)

Keyboard input event.

**Members:**
.ie n .IP """key: KeyValue""" 4
.el .IP "\f(CWkey: KeyValue" 4
.IX Item "key: KeyValue"
Which key this event is for.
.ie n .IP """down: boolean""" 4
.el .IP "\f(CWdown: boolean" 4
.IX Item "down: boolean"
True for key-down and false for key-up events.

**Since:**
2.0

**InputBtnEvent** (Object)

Pointer button input event.

**Members:**
.ie n .IP """button: InputButton""" 4
.el .IP "\f(CWbutton: InputButton" 4
.IX Item "button: InputButton"
Which button this event is for.
.ie n .IP """down: boolean""" 4
.el .IP "\f(CWdown: boolean" 4
.IX Item "down: boolean"
True for key-down and false for key-up events.

**Since:**
2.0

**InputMoveEvent** (Object)

Pointer motion input event.

**Members:**
.ie n .IP """axis: InputAxis""" 4
.el .IP "\f(CWaxis: InputAxis" 4
.IX Item "axis: InputAxis"
Which axis is referenced by \f(CW`value\*(C'.
.ie n .IP """value: int""" 4
.el .IP "\f(CWvalue: int" 4
.IX Item "value: int"
Pointer position.  For absolute coordinates the
valid range is 0 -&gt; 0x7ffff

**Since:**
2.0

**InputEvent** (Object)

Input event union.

**Members:**
.ie n .IP """type""" 4
.el .IP "\f(CWtype" 4
.IX Item "type"
the input type, one of:

* 'key': Input event of Keyboard
* 'btn': Input event of pointer buttons
* 'rel': Input event of relative pointer motion
* 'abs': Input event of absolute pointer motion
.ie n .IP """data: InputKeyEvent"" when ""type"" is ""key""" 4
.el .IP "\f(CWdata: InputKeyEvent when \f(CWtype is \`\`key''" 4
.IX Item "data: InputKeyEvent when type is key"
.ie n .IP """data: InputBtnEvent"" when ""type"" is ""btn""" 4
.el .IP "\f(CWdata: InputBtnEvent when \f(CWtype is \`\`btn''" 4
.IX Item "data: InputBtnEvent when type is btn"
.ie n .IP """data: InputMoveEvent"" when ""type"" is ""rel""" 4
.el .IP "\f(CWdata: InputMoveEvent when \f(CWtype is \`\`rel''" 4
.IX Item "data: InputMoveEvent when type is rel"
.ie n .IP """data: InputMoveEvent"" when ""type"" is ""abs""" 4
.el .IP "\f(CWdata: InputMoveEvent when \f(CWtype is \`\`abs''" 4
.IX Item "data: InputMoveEvent when type is abs"

**Since:**
2.0

**input-send-event**  (Command)
Send input event(s) to guest.

**Arguments:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
display device to send event(s) to.
.ie n .IP """head: int"" (optional)" 4
.el .IP "\f(CWhead: int (optional)" 4
.IX Item "head: int (optional)"
head to send event(s) to, in case the
display device supports multiple scanouts.
.ie n .IP """events: array of InputEvent""" 4
.el .IP "\f(CWevents: array of InputEvent" 4
.IX Item "events: array of InputEvent"
List of InputEvent union.

**Returns:**
Nothing on success.

The \f(CW`device\*(C' and \f(CW\*(C\`head\*(C' parameters can be used to send the input event
to specific input devices in case (a) multiple input devices of the
same kind are added to the virtual machine and (b) you have
configured input routing (see docs/multiseat.txt) for those input
devices.  The parameters work exactly like the device and head
properties of input devices.  If \f(CW`device\*(C' is missing, only devices
that have no input routing config are admissible.  If \f(CW`device\*(C' is
specified, both input devices with and without input routing config
are admissible, but devices with input routing config take
precedence.

**Since:**
2.6

**Note:**
The consoles are visible in the qom tree, under
/backend/console[$index]. They have a device link and head property,
so it is possible to map which console belongs to which device and
display.

**Example:**

.Vb 1
        1. Press left mouse button.
        
        -&gt; { "execute": "input-send-event",
            "arguments": { "device": "video0",
                           "events": [ { "type": "btn",
                           "data" : { "down": true, "button": "left" } } ] } }
        &lt;- { "return": {} }
        
        -&gt; { "execute": "input-send-event",
            "arguments": { "device": "video0",
                           "events": [ { "type": "btn",
                           "data" : { "down": false, "button": "left" } } ] } }
        &lt;- { "return": {} }
        
        2. Press ctrl-alt-del.
        
        -&gt; { "execute": "input-send-event",
             "arguments": { "events": [
                { "type": "key", "data" : { "down": true,
                  "key": {"type": "qcode", "data": "ctrl" } } },
                { "type": "key", "data" : { "down": true,
                  "key": {"type": "qcode", "data": "alt" } } },
                { "type": "key", "data" : { "down": true,
                  "key": {"type": "qcode", "data": "delete" } } } ] } }
        &lt;- { "return": {} }
        
        3. Move mouse pointer to absolute coordinates (20000, 400).
        
        -&gt; { "execute": "input-send-event" ,
          "arguments": { "events": [
                       { "type": "abs", "data" : { "axis": "x", "value" : 20000 } },
                       { "type": "abs", "data" : { "axis": "y", "value" : 400 } } ] } }
        &lt;- { "return": {} }
.Ve

**DisplayGTK** (Object)

\s-1GTK\s0 display options.

**Members:**
.ie n .IP """grab-on-hover: boolean"" (optional)" 4
.el .IP "\f(CWgrab-on-hover: boolean (optional)" 4
.IX Item "grab-on-hover: boolean (optional)"
Grab keyboard input on mouse hover.
.ie n .IP """zoom-to-fit: boolean"" (optional)" 4
.el .IP "\f(CWzoom-to-fit: boolean (optional)" 4
.IX Item "zoom-to-fit: boolean (optional)"
Zoom guest display to fit into the host window.  When
turned off the host window will be resized instead.
In case the display device can notify the guest on
window resizes (virtio-gpu) this will default to on\*(R",
assuming the guest will resize the display to match
the window size then.  Otherwise it defaults to off\*(R".
Since 3.1

**Since:**
2.12

**DisplayEGLHeadless** (Object)

\s-1EGL\s0 headless display options.

**Members:**
.ie n .IP """rendernode: string"" (optional)" 4
.el .IP "\f(CWrendernode: string (optional)" 4
.IX Item "rendernode: string (optional)"
Which \s-1DRM\s0 render node should be used. Default is the first
available node on the host.

**Since:**
3.1

**DisplayGLMode** (Enum)

Display OpenGL mode.

**Values:**
.ie n .IP """off""" 4
.el .IP "\f(CWoff" 4
.IX Item "off"
Disable OpenGL (default).
.ie n .IP """on""" 4
.el .IP "\f(CWon" 4
.IX Item "on"
Use OpenGL, pick context type automatically.
Would better be named 'auto' but is called 'on' for backward
compatibility with bool type.
.ie n .IP """core""" 4
.el .IP "\f(CWcore" 4
.IX Item "core"
Use OpenGL with Core (desktop) Context.
.ie n .IP """es""" 4
.el .IP "\f(CWes" 4
.IX Item "es"
Use OpenGL with \s-1ES\s0 (embedded systems) Context.

**Since:**
3.0

**DisplayType** (Enum)

Display (user interface) type.

**Values:**
.ie n .IP """default""" 4
.el .IP "\f(CWdefault" 4
.IX Item "default"
Not documented
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Not documented
.ie n .IP """gtk""" 4
.el .IP "\f(CWgtk" 4
.IX Item "gtk"
Not documented
.ie n .IP """sdl""" 4
.el .IP "\f(CWsdl" 4
.IX Item "sdl"
Not documented
.ie n .IP """egl-headless""" 4
.el .IP "\f(CWegl-headless" 4
.IX Item "egl-headless"
Not documented
.ie n .IP """curses""" 4
.el .IP "\f(CWcurses" 4
.IX Item "curses"
Not documented
.ie n .IP """cocoa""" 4
.el .IP "\f(CWcocoa" 4
.IX Item "cocoa"
Not documented

**Since:**
2.12

**DisplayOptions** (Object)

Display (user interface) options.

**Members:**
.ie n .IP """type: DisplayType""" 4
.el .IP "\f(CWtype: DisplayType" 4
.IX Item "type: DisplayType"
Which DisplayType qemu should use.
.ie n .IP """full-screen: boolean"" (optional)" 4
.el .IP "\f(CWfull-screen: boolean (optional)" 4
.IX Item "full-screen: boolean (optional)"
Start user interface in fullscreen mode (default: off).
.ie n .IP """window-close: boolean"" (optional)" 4
.el .IP "\f(CWwindow-close: boolean (optional)" 4
.IX Item "window-close: boolean (optional)"
Allow to quit qemu with window close button (default: on).
.ie n .IP """gl: DisplayGLMode"" (optional)" 4
.el .IP "\f(CWgl: DisplayGLMode (optional)" 4
.IX Item "gl: DisplayGLMode (optional)"
Enable OpenGL support (default: off).
.ie n .IP "The members of ""DisplayGTK"" when ""type"" is ""gtk""" 4
.el .IP "The members of \f(CWDisplayGTK when \f(CWtype is \`\`gtk''" 4
.IX Item "The members of DisplayGTK when type is gtk"
.ie n .IP "The members of ""DisplayEGLHeadless"" when ""type"" is ""egl-headless""" 4
.el .IP "The members of \f(CWDisplayEGLHeadless when \f(CWtype is \`\`egl-headless''" 4
.IX Item "The members of DisplayEGLHeadless when type is egl-headless"

**Since:**
2.12

**query-display-options**  (Command)
Returns information about display configuration

**Returns:**
\f(CW`DisplayOptions\*(C'

**Since:**
3.1

<a name="migration"></a>

### Migration

.IX Subsection "Migration"
**MigrationStats** (Object)

Detailed migration status.

**Members:**
.ie n .IP """transferred: int""" 4
.el .IP "\f(CWtransferred: int" 4
.IX Item "transferred: int"
amount of bytes already transferred to the target \s-1VM\s0
.ie n .IP """remaining: int""" 4
.el .IP "\f(CWremaining: int" 4
.IX Item "remaining: int"
amount of bytes remaining to be transferred to the target \s-1VM\s0
.ie n .IP """total: int""" 4
.el .IP "\f(CWtotal: int" 4
.IX Item "total: int"
total amount of bytes involved in the migration process
.ie n .IP """duplicate: int""" 4
.el .IP "\f(CWduplicate: int" 4
.IX Item "duplicate: int"
number of duplicate (zero) pages (since 1.2)
.ie n .IP """skipped: int""" 4
.el .IP "\f(CWskipped: int" 4
.IX Item "skipped: int"
number of skipped zero pages (since 1.5)
.ie n .IP """normal: int""" 4
.el .IP "\f(CWnormal: int" 4
.IX Item "normal: int"
number of normal pages (since 1.2)
.ie n .IP """normal-bytes: int""" 4
.el .IP "\f(CWnormal-bytes: int" 4
.IX Item "normal-bytes: int"
number of normal bytes sent (since 1.2)
.ie n .IP """dirty-pages-rate: int""" 4
.el .IP "\f(CWdirty-pages-rate: int" 4
.IX Item "dirty-pages-rate: int"
number of pages dirtied by second by the
guest (since 1.3)
.ie n .IP """mbps: number""" 4
.el .IP "\f(CWmbps: number" 4
.IX Item "mbps: number"
throughput in megabits/sec. (since 1.6)
.ie n .IP """dirty-sync-count: int""" 4
.el .IP "\f(CWdirty-sync-count: int" 4
.IX Item "dirty-sync-count: int"
number of times that dirty ram was synchronized (since 2.1)
.ie n .IP """postcopy-requests: int""" 4
.el .IP "\f(CWpostcopy-requests: int" 4
.IX Item "postcopy-requests: int"
The number of page requests received from the destination
(since 2.7)
.ie n .IP """page-size: int""" 4
.el .IP "\f(CWpage-size: int" 4
.IX Item "page-size: int"
The number of bytes per page for the various page-based
statistics (since 2.10)
.ie n .IP """multifd-bytes: int""" 4
.el .IP "\f(CWmultifd-bytes: int" 4
.IX Item "multifd-bytes: int"
The number of bytes sent through multifd (since 3.0)

**Since:**
0.14.0

**XBZRLECacheStats** (Object)

Detailed \s-1XBZRLE\s0 migration cache statistics

**Members:**
.ie n .IP """cache-size: int""" 4
.el .IP "\f(CWcache-size: int" 4
.IX Item "cache-size: int"
\s-1XBZRLE\s0 cache size
.ie n .IP """bytes: int""" 4
.el .IP "\f(CWbytes: int" 4
.IX Item "bytes: int"
amount of bytes already transferred to the target \s-1VM\s0
.ie n .IP """pages: int""" 4
.el .IP "\f(CWpages: int" 4
.IX Item "pages: int"
amount of pages transferred to the target \s-1VM\s0
.ie n .IP """cache-miss: int""" 4
.el .IP "\f(CWcache-miss: int" 4
.IX Item "cache-miss: int"
number of cache miss
.ie n .IP """cache-miss-rate: number""" 4
.el .IP "\f(CWcache-miss-rate: number" 4
.IX Item "cache-miss-rate: number"
rate of cache miss (since 2.1)
.ie n .IP """overflow: int""" 4
.el .IP "\f(CWoverflow: int" 4
.IX Item "overflow: int"
number of overflows

**Since:**
1.2

**CompressionStats** (Object)

Detailed migration compression statistics

**Members:**
.ie n .IP """pages: int""" 4
.el .IP "\f(CWpages: int" 4
.IX Item "pages: int"
amount of pages compressed and transferred to the target \s-1VM\s0
.ie n .IP """busy: int""" 4
.el .IP "\f(CWbusy: int" 4
.IX Item "busy: int"
count of times that no free thread was available to compress data
.ie n .IP """busy-rate: number""" 4
.el .IP "\f(CWbusy-rate: number" 4
.IX Item "busy-rate: number"
rate of thread busy
.ie n .IP """compressed-size: int""" 4
.el .IP "\f(CWcompressed-size: int" 4
.IX Item "compressed-size: int"
amount of bytes after compression
.ie n .IP """compression-rate: number""" 4
.el .IP "\f(CWcompression-rate: number" 4
.IX Item "compression-rate: number"
rate of compressed size

**Since:**
3.1

**MigrationStatus** (Enum)

An enumeration of migration status.

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
no migration has ever happened.
.ie n .IP """setup""" 4
.el .IP "\f(CWsetup" 4
.IX Item "setup"
migration process has been initiated.
.ie n .IP """cancelling""" 4
.el .IP "\f(CWcancelling" 4
.IX Item "cancelling"
in the process of cancelling migration.
.ie n .IP """cancelled""" 4
.el .IP "\f(CWcancelled" 4
.IX Item "cancelled"
cancelling migration is finished.
.ie n .IP """active""" 4
.el .IP "\f(CWactive" 4
.IX Item "active"
in the process of doing migration.
.ie n .IP """postcopy-active""" 4
.el .IP "\f(CWpostcopy-active" 4
.IX Item "postcopy-active"
like active, but now in postcopy mode. (since 2.5)
.ie n .IP """postcopy-paused""" 4
.el .IP "\f(CWpostcopy-paused" 4
.IX Item "postcopy-paused"
during postcopy but paused. (since 3.0)
.ie n .IP """postcopy-recover""" 4
.el .IP "\f(CWpostcopy-recover" 4
.IX Item "postcopy-recover"
trying to recover from a paused postcopy. (since 3.0)
.ie n .IP """completed""" 4
.el .IP "\f(CWcompleted" 4
.IX Item "completed"
migration is finished.
.ie n .IP """failed""" 4
.el .IP "\f(CWfailed" 4
.IX Item "failed"
some error occurred during migration process.
.ie n .IP """colo""" 4
.el .IP "\f(CWcolo" 4
.IX Item "colo"
\s-1VM\s0 is in the process of fault tolerance, \s-1VM\s0 can not get into this
state unless colo capability is enabled for migration. (since 2.8)
.ie n .IP """pre-switchover""" 4
.el .IP "\f(CWpre-switchover" 4
.IX Item "pre-switchover"
Paused before device serialisation. (since 2.11)
.ie n .IP """device""" 4
.el .IP "\f(CWdevice" 4
.IX Item "device"
During device serialisation when pause-before-switchover is enabled
(since 2.11)

**Since:**
2.3

**MigrationInfo** (Object)

Information about current migration process.

**Members:**
.ie n .IP """status: MigrationStatus"" (optional)" 4
.el .IP "\f(CWstatus: MigrationStatus (optional)" 4
.IX Item "status: MigrationStatus (optional)"
\f(CW`MigrationStatus\*(C' describing the current migration status.
If this field is not returned, no migration process
has been initiated
.ie n .IP """ram: MigrationStats"" (optional)" 4
.el .IP "\f(CWram: MigrationStats (optional)" 4
.IX Item "ram: MigrationStats (optional)"
\f(CW`MigrationStats\*(C' containing detailed migration
status, only returned if status is 'active' or
'completed'(since 1.2)
.ie n .IP """disk: MigrationStats"" (optional)" 4
.el .IP "\f(CWdisk: MigrationStats (optional)" 4
.IX Item "disk: MigrationStats (optional)"
\f(CW`MigrationStats\*(C' containing detailed disk migration
status, only returned if status is 'active' and it is a block
migration
.ie n .IP """xbzrle-cache: XBZRLECacheStats"" (optional)" 4
.el .IP "\f(CWxbzrle-cache: XBZRLECacheStats (optional)" 4
.IX Item "xbzrle-cache: XBZRLECacheStats (optional)"
\f(CW`XBZRLECacheStats\*(C' containing detailed \s-1XBZRLE\s0
migration statistics, only returned if \s-1XBZRLE\s0 feature is on and
status is 'active' or 'completed' (since 1.2)
.ie n .IP """total-time: int"" (optional)" 4
.el .IP "\f(CWtotal-time: int (optional)" 4
.IX Item "total-time: int (optional)"
total amount of milliseconds since migration started.
If migration has ended, it returns the total migration
time. (since 1.2)
.ie n .IP """downtime: int"" (optional)" 4
.el .IP "\f(CWdowntime: int (optional)" 4
.IX Item "downtime: int (optional)"
only present when migration finishes correctly
total downtime in milliseconds for the guest.
(since 1.3)
.ie n .IP """expected-downtime: int"" (optional)" 4
.el .IP "\f(CWexpected-downtime: int (optional)" 4
.IX Item "expected-downtime: int (optional)"
only present while migration is active
expected downtime in milliseconds for the guest in last walk
of the dirty bitmap. (since 1.3)
.ie n .IP """setup-time: int"" (optional)" 4
.el .IP "\f(CWsetup-time: int (optional)" 4
.IX Item "setup-time: int (optional)"
amount of setup time in milliseconds _before_ the
iterations begin but _after_ the \s-1QMP\s0 command is issued. This is designed
to provide an accounting of any activities (such as \s-1RDMA\s0 pinning) which
may be expensive, but do not actually occur during the iterative
migration rounds themselves. (since 1.6)
.ie n .IP """cpu-throttle-percentage: int"" (optional)" 4
.el .IP "\f(CWcpu-throttle-percentage: int (optional)" 4
.IX Item "cpu-throttle-percentage: int (optional)"
percentage of time guest cpus are being
throttled during auto-converge. This is only present when auto-converge
has started throttling guest cpus. (Since 2.7)
.ie n .IP """error-desc: string"" (optional)" 4
.el .IP "\f(CWerror-desc: string (optional)" 4
.IX Item "error-desc: string (optional)"
the human readable error description string, when
\f(CW`status\*(C' is 'failed'. Clients should not attempt to parse the
error strings. (Since 2.7)
.ie n .IP """postcopy-blocktime: int"" (optional)" 4
.el .IP "\f(CWpostcopy-blocktime: int (optional)" 4
.IX Item "postcopy-blocktime: int (optional)"
total time when all vCPU were blocked during postcopy
live migration. This is only present when the postcopy-blocktime
migration capability is enabled. (Since 3.0)
.ie n .IP """postcopy-vcpu-blocktime: array of int"" (optional)" 4
.el .IP "\f(CWpostcopy-vcpu-blocktime: array of int (optional)" 4
.IX Item "postcopy-vcpu-blocktime: array of int (optional)"
list of the postcopy blocktime per vCPU.  This is
only present when the postcopy-blocktime migration capability
is enabled. (Since 3.0)
.ie n .IP """compression: CompressionStats"" (optional)" 4
.el .IP "\f(CWcompression: CompressionStats (optional)" 4
.IX Item "compression: CompressionStats (optional)"
migration compression statistics, only returned if compression
feature is on and status is 'active' or 'completed' (Since 3.1)

**Since:**
0.14.0

**query-migrate**  (Command)
Returns information about current migration process. If migration
is active there will be another json-object with \s-1RAM\s0 migration
status and if block migration is active another one with block
migration status.

**Returns:**
\f(CW`MigrationInfo\*(C'

**Since:**
0.14.0

**Example:**

.Vb 1
        1. Before the first migration
        
        -&gt; { "execute": "query-migrate" }
        &lt;- { "return": {} }
        
        2. Migration is done and has succeeded
        
        -&gt; { "execute": "query-migrate" }
        &lt;- { "return": {
                "status": "completed",
                "total-time":12345,
                "setup-time":12345,
                "downtime":12345,
                "ram":{
                  "transferred":123,
                  "remaining":123,
                  "total":246,
                  "duplicate":123,
                  "normal":123,
                  "normal-bytes":123456,
                  "dirty-sync-count":15
                }
             }
           }
        
        3. Migration is done and has failed
        
        -&gt; { "execute": "query-migrate" }
        &lt;- { "return": { "status": "failed" } }
        
        4. Migration is being performed and is not a block migration:
        
        -&gt; { "execute": "query-migrate" }
        &lt;- {
              "return":{
                 "status":"active",
                 "total-time":12345,
                 "setup-time":12345,
                 "expected-downtime":12345,
                 "ram":{
                    "transferred":123,
                    "remaining":123,
                    "total":246,
                    "duplicate":123,
                    "normal":123,
                    "normal-bytes":123456,
                    "dirty-sync-count":15
                 }
              }
           }
        
        5. Migration is being performed and is a block migration:
        
        -&gt; { "execute": "query-migrate" }
        &lt;- {
              "return":{
                 "status":"active",
                 "total-time":12345,
                 "setup-time":12345,
                 "expected-downtime":12345,
                 "ram":{
                    "total":1057024,
                    "remaining":1053304,
                    "transferred":3720,
                    "duplicate":123,
                    "normal":123,
                    "normal-bytes":123456,
                    "dirty-sync-count":15
                 },
                 "disk":{
                    "total":20971520,
                    "remaining":20880384,
                    "transferred":91136
                 }
              }
           }
        
        6. Migration is being performed and XBZRLE is active:
        
        -&gt; { "execute": "query-migrate" }
        &lt;- {
              "return":{
                 "status":"active",
                 "total-time":12345,
                 "setup-time":12345,
                 "expected-downtime":12345,
                 "ram":{
                    "total":1057024,
                    "remaining":1053304,
                    "transferred":3720,
                    "duplicate":10,
                    "normal":3333,
                    "normal-bytes":3412992,
                    "dirty-sync-count":15
                 },
                 "xbzrle-cache":{
                    "cache-size":67108864,
                    "bytes":20971520,
                    "pages":2444343,
                    "cache-miss":2244,
                    "cache-miss-rate":0.123,
                    "overflow":34434
                 }
              }
           }
.Ve

**MigrationCapability** (Enum)

Migration capabilities enumeration

**Values:**
.ie n .IP """xbzrle""" 4
.el .IP "\f(CWxbzrle" 4
.IX Item "xbzrle"
Migration supports xbzrle (Xor Based Zero Run Length Encoding).
This feature allows us to minimize migration traffic for certain work
loads, by sending compressed difference of the pages
.ie n .IP """rdma-pin-all""" 4
.el .IP "\f(CWrdma-pin-all" 4
.IX Item "rdma-pin-all"
Controls whether or not the entire \s-1VM\s0 memory footprint is
**mlock()**'d on demand or all at once. Refer to docs/rdma.txt for usage.
Disabled by default. (since 2.0)
.ie n .IP """zero-blocks""" 4
.el .IP "\f(CWzero-blocks" 4
.IX Item "zero-blocks"
During storage migration encode blocks of zeroes efficiently. This
essentially saves 1MB of zeroes per block on the wire. Enabling requires
source and target \s-1VM\s0 to support this feature. To enable it is sufficient
to enable the capability on the source \s-1VM.\s0 The feature is disabled by
default. (since 1.6)
.ie n .IP """compress""" 4
.el .IP "\f(CWcompress" 4
.IX Item "compress"
Use multiple compression threads to accelerate live migration.
This feature can help to reduce the migration traffic, by sending
compressed pages. Please note that if compress and xbzrle are both
on, compress only takes effect in the ram bulk stage, after that,
it will be disabled and only xbzrle takes effect, this can help to
minimize migration traffic. The feature is disabled by default.
(since 2.4 )
.ie n .IP """events""" 4
.el .IP "\f(CWevents" 4
.IX Item "events"
generate events for each migration state change
(since 2.4 )
.ie n .IP """auto-converge""" 4
.el .IP "\f(CWauto-converge" 4
.IX Item "auto-converge"
If enabled, \s-1QEMU\s0 will automatically throttle down the guest
to speed up convergence of \s-1RAM\s0 migration. (since 1.6)
.ie n .IP """postcopy-ram""" 4
.el .IP "\f(CWpostcopy-ram" 4
.IX Item "postcopy-ram"
Start executing on the migration target before all of \s-1RAM\s0 has
been migrated, pulling the remaining pages along as needed. The
capacity must have the same setting on both source and target
or migration will not even start. \s-1NOTE:\s0 If the migration fails during
postcopy the \s-1VM\s0 will fail.  (since 2.6)
.ie n .IP """x-colo""" 4
.el .IP "\f(CWx-colo" 4
.IX Item "x-colo"
If enabled, migration will never end, and the state of the \s-1VM\s0 on the
primary side will be migrated continuously to the \s-1VM\s0 on secondary
side, this process is called COarse-Grain LOck Stepping (\s-1COLO\s0) for
Non-stop Service. (since 2.8)
.ie n .IP """release-ram""" 4
.el .IP "\f(CWrelease-ram" 4
.IX Item "release-ram"
if enabled, qemu will free the migrated ram pages on the source
during postcopy-ram migration. (since 2.9)
.ie n .IP """block""" 4
.el .IP "\f(CWblock" 4
.IX Item "block"
If enabled, \s-1QEMU\s0 will also migrate the contents of all block
devices.  Default is disabled.  A possible alternative uses
mirror jobs to a builtin \s-1NBD\s0 server on the destination, which
offers more flexibility.
(Since 2.10)
.ie n .IP """return-path""" 4
.el .IP "\f(CWreturn-path" 4
.IX Item "return-path"
If enabled, migration will use the return path even
for precopy. (since 2.10)
.ie n .IP """pause-before-switchover""" 4
.el .IP "\f(CWpause-before-switchover" 4
.IX Item "pause-before-switchover"
Pause outgoing migration before serialising device
state and before disabling block \s-1IO\s0 (since 2.11)
.ie n .IP """x-multifd""" 4
.el .IP "\f(CWx-multifd" 4
.IX Item "x-multifd"
Use more than one fd for migration (since 2.11)
.ie n .IP """dirty-bitmaps""" 4
.el .IP "\f(CWdirty-bitmaps" 4
.IX Item "dirty-bitmaps"
If enabled, \s-1QEMU\s0 will migrate named dirty bitmaps.
(since 2.12)
.ie n .IP """postcopy-blocktime""" 4
.el .IP "\f(CWpostcopy-blocktime" 4
.IX Item "postcopy-blocktime"
Calculate downtime for postcopy live migration
(since 3.0)
.ie n .IP """late-block-activate""" 4
.el .IP "\f(CWlate-block-activate" 4
.IX Item "late-block-activate"
If enabled, the destination will not activate block
devices (and thus take locks) immediately at the end of migration.
(since 3.0)

**Since:**
1.2

**MigrationCapabilityStatus** (Object)

Migration capability information

**Members:**
.ie n .IP """capability: MigrationCapability""" 4
.el .IP "\f(CWcapability: MigrationCapability" 4
.IX Item "capability: MigrationCapability"
capability enum
.ie n .IP """state: boolean""" 4
.el .IP "\f(CWstate: boolean" 4
.IX Item "state: boolean"
capability state bool

**Since:**
1.2

**migrate-set-capabilities**  (Command)
Enable/Disable the following migration capabilities (like xbzrle)

**Arguments:**
.ie n .IP """capabilities: array of MigrationCapabilityStatus""" 4
.el .IP "\f(CWcapabilities: array of MigrationCapabilityStatus" 4
.IX Item "capabilities: array of MigrationCapabilityStatus"
json array of capability modifications to make

**Since:**
1.2

**Example:**

.Vb 2
        -&gt; { "execute": "migrate-set-capabilities" , "arguments":
             { "capabilities": [ { "capability": "xbzrle", "state": true } ] } }
.Ve

**query-migrate-capabilities**  (Command)
Returns information about the current migration capabilities status

**Returns:**
\f(CW`MigrationCapabilitiesStatus\*(C'

**Since:**
1.2

**Example:**

.Vb 11
        -&gt; { "execute": "query-migrate-capabilities" }
        &lt;- { "return": [
              {"state": false, "capability": "xbzrle"},
              {"state": false, "capability": "rdma-pin-all"},
              {"state": false, "capability": "auto-converge"},
              {"state": false, "capability": "zero-blocks"},
              {"state": false, "capability": "compress"},
              {"state": true, "capability": "events"},
              {"state": false, "capability": "postcopy-ram"},
              {"state": false, "capability": "x-colo"}
           ]}
.Ve

**MigrationParameter** (Enum)

Migration parameters enumeration

**Values:**
.ie n .IP """compress-level""" 4
.el .IP "\f(CWcompress-level" 4
.IX Item "compress-level"
Set the compression level to be used in live migration,
the compression level is an integer between 0 and 9, where 0 means
no compression, 1 means the best compression speed, and 9 means best
compression ratio which will consume more \s-1CPU.\s0
.ie n .IP """compress-threads""" 4
.el .IP "\f(CWcompress-threads" 4
.IX Item "compress-threads"
Set compression thread count to be used in live migration,
the compression thread count is an integer between 1 and 255.
.ie n .IP """compress-wait-thread""" 4
.el .IP "\f(CWcompress-wait-thread" 4
.IX Item "compress-wait-thread"
Controls behavior when all compression threads are
currently busy. If true (default), wait for a free
compression thread to become available; otherwise,
send the page uncompressed. (Since 3.1)
.ie n .IP """decompress-threads""" 4
.el .IP "\f(CWdecompress-threads" 4
.IX Item "decompress-threads"
Set decompression thread count to be used in live
migration, the decompression thread count is an integer between 1
and 255. Usually, decompression is at least 4 times as fast as
compression, so set the decompress-threads to the number about 1/4
of compress-threads is adequate.
.ie n .IP """cpu-throttle-initial""" 4
.el .IP "\f(CWcpu-throttle-initial" 4
.IX Item "cpu-throttle-initial"
Initial percentage of time guest cpus are throttled
when migration auto-converge is activated. The
default value is 20. (Since 2.7)
.ie n .IP """cpu-throttle-increment""" 4
.el .IP "\f(CWcpu-throttle-increment" 4
.IX Item "cpu-throttle-increment"
throttle percentage increase each time
auto-converge detects that migration is not making
progress. The default value is 10. (Since 2.7)
.ie n .IP """tls-creds""" 4
.el .IP "\f(CWtls-creds" 4
.IX Item "tls-creds"
\s-1ID\s0 of the 'tls-creds' object that provides credentials for
establishing a \s-1TLS\s0 connection over the migration data channel.
On the outgoing side of the migration, the credentials must
be for a 'client' endpoint, while for the incoming side the
credentials must be for a 'server' endpoint. Setting this
will enable \s-1TLS\s0 for all migrations. The default is unset,
resulting in unsecured migration at the \s-1QEMU\s0 level. (Since 2.7)
.ie n .IP """tls-hostname""" 4
.el .IP "\f(CWtls-hostname" 4
.IX Item "tls-hostname"
hostname of the target host for the migration. This is
required when using x509 based \s-1TLS\s0 credentials and the
migration \s-1URI\s0 does not already include a hostname. For
example if using fd: or exec: based migration, the
hostname must be provided so that the server's x509
certificate identity can be validated. (Since 2.7)
.ie n .IP """max-bandwidth""" 4
.el .IP "\f(CWmax-bandwidth" 4
.IX Item "max-bandwidth"
to set maximum speed for migration. maximum speed in
bytes per second. (Since 2.8)
.ie n .IP """downtime-limit""" 4
.el .IP "\f(CWdowntime-limit" 4
.IX Item "downtime-limit"
set maximum tolerated downtime for migration. maximum
downtime in milliseconds (Since 2.8)
.ie n .IP """x-checkpoint-delay""" 4
.el .IP "\f(CWx-checkpoint-delay" 4
.IX Item "x-checkpoint-delay"
The delay time (in ms) between two \s-1COLO\s0 checkpoints in
periodic mode. (Since 2.8)
.ie n .IP """block-incremental""" 4
.el .IP "\f(CWblock-incremental" 4
.IX Item "block-incremental"
Affects how much storage is migrated when the
block migration capability is enabled.  When false, the entire
storage backing chain is migrated into a flattened image at
the destination; when true, only the active qcow2 layer is
migrated and the destination must already have access to the
same backing chain as was used on the source.  (since 2.10)
.ie n .IP """x-multifd-channels""" 4
.el .IP "\f(CWx-multifd-channels" 4
.IX Item "x-multifd-channels"
Number of channels used to migrate data in
parallel. This is the same number that the
number of sockets used for migration.  The
default value is 2 (since 2.11)
.ie n .IP """x-multifd-page-count""" 4
.el .IP "\f(CWx-multifd-page-count" 4
.IX Item "x-multifd-page-count"
Number of pages sent together to a thread.
The default value is 16 (since 2.11)
.ie n .IP """xbzrle-cache-size""" 4
.el .IP "\f(CWxbzrle-cache-size" 4
.IX Item "xbzrle-cache-size"
cache size to be used by \s-1XBZRLE\s0 migration.  It
needs to be a multiple of the target page size
and a power of 2
(Since 2.11)
.ie n .IP """max-postcopy-bandwidth""" 4
.el .IP "\f(CWmax-postcopy-bandwidth" 4
.IX Item "max-postcopy-bandwidth"
Background transfer bandwidth during postcopy.
Defaults to 0 (unlimited).  In bytes per second.
(Since 3.0)
.ie n .IP """max-cpu-throttle""" 4
.el .IP "\f(CWmax-cpu-throttle" 4
.IX Item "max-cpu-throttle"
maximum cpu throttle percentage.
Defaults to 99. (Since 3.1)

**Since:**
2.4

**MigrateSetParameters** (Object)

**Members:**
.ie n .IP """compress-level: int"" (optional)" 4
.el .IP "\f(CWcompress-level: int (optional)" 4
.IX Item "compress-level: int (optional)"
compression level
.ie n .IP """compress-threads: int"" (optional)" 4
.el .IP "\f(CWcompress-threads: int (optional)" 4
.IX Item "compress-threads: int (optional)"
compression thread count
.ie n .IP """compress-wait-thread: boolean"" (optional)" 4
.el .IP "\f(CWcompress-wait-thread: boolean (optional)" 4
.IX Item "compress-wait-thread: boolean (optional)"
Controls behavior when all compression threads are
currently busy. If true (default), wait for a free
compression thread to become available; otherwise,
send the page uncompressed. (Since 3.1)
.ie n .IP """decompress-threads: int"" (optional)" 4
.el .IP "\f(CWdecompress-threads: int (optional)" 4
.IX Item "decompress-threads: int (optional)"
decompression thread count
.ie n .IP """cpu-throttle-initial: int"" (optional)" 4
.el .IP "\f(CWcpu-throttle-initial: int (optional)" 4
.IX Item "cpu-throttle-initial: int (optional)"
Initial percentage of time guest cpus are
throttled when migration auto-converge is activated.
The default value is 20. (Since 2.7)
.ie n .IP """cpu-throttle-increment: int"" (optional)" 4
.el .IP "\f(CWcpu-throttle-increment: int (optional)" 4
.IX Item "cpu-throttle-increment: int (optional)"
throttle percentage increase each time
auto-converge detects that migration is not making
progress. The default value is 10. (Since 2.7)
.ie n .IP """tls-creds: StrOrNull"" (optional)" 4
.el .IP "\f(CWtls-creds: StrOrNull (optional)" 4
.IX Item "tls-creds: StrOrNull (optional)"
\s-1ID\s0 of the 'tls-creds' object that provides credentials
for establishing a \s-1TLS\s0 connection over the migration data
channel. On the outgoing side of the migration, the credentials
must be for a 'client' endpoint, while for the incoming side the
credentials must be for a 'server' endpoint. Setting this
to a non-empty string enables \s-1TLS\s0 for all migrations.
An empty string means that \s-1QEMU\s0 will use plain text mode for
migration, rather than \s-1TLS\s0 (Since 2.9)
Previously (since 2.7), this was reported by omitting
tls-creds instead.
.ie n .IP """tls-hostname: StrOrNull"" (optional)" 4
.el .IP "\f(CWtls-hostname: StrOrNull (optional)" 4
.IX Item "tls-hostname: StrOrNull (optional)"
hostname of the target host for the migration. This
is required when using x509 based \s-1TLS\s0 credentials and the
migration \s-1URI\s0 does not already include a hostname. For
example if using fd: or exec: based migration, the
hostname must be provided so that the server's x509
certificate identity can be validated. (Since 2.7)
An empty string means that \s-1QEMU\s0 will use the hostname
associated with the migration \s-1URI,\s0 if any. (Since 2.9)
Previously (since 2.7), this was reported by omitting
tls-hostname instead.
.ie n .IP """max-bandwidth: int"" (optional)" 4
.el .IP "\f(CWmax-bandwidth: int (optional)" 4
.IX Item "max-bandwidth: int (optional)"
to set maximum speed for migration. maximum speed in
bytes per second. (Since 2.8)
.ie n .IP """downtime-limit: int"" (optional)" 4
.el .IP "\f(CWdowntime-limit: int (optional)" 4
.IX Item "downtime-limit: int (optional)"
set maximum tolerated downtime for migration. maximum
downtime in milliseconds (Since 2.8)
.ie n .IP """x-checkpoint-delay: int"" (optional)" 4
.el .IP "\f(CWx-checkpoint-delay: int (optional)" 4
.IX Item "x-checkpoint-delay: int (optional)"
the delay time between two \s-1COLO\s0 checkpoints. (Since 2.8)
.ie n .IP """block-incremental: boolean"" (optional)" 4
.el .IP "\f(CWblock-incremental: boolean (optional)" 4
.IX Item "block-incremental: boolean (optional)"
Affects how much storage is migrated when the
block migration capability is enabled.  When false, the entire
storage backing chain is migrated into a flattened image at
the destination; when true, only the active qcow2 layer is
migrated and the destination must already have access to the
same backing chain as was used on the source.  (since 2.10)
.ie n .IP """x-multifd-channels: int"" (optional)" 4
.el .IP "\f(CWx-multifd-channels: int (optional)" 4
.IX Item "x-multifd-channels: int (optional)"
Number of channels used to migrate data in
parallel. This is the same number that the
number of sockets used for migration.  The
default value is 2 (since 2.11)
.ie n .IP """x-multifd-page-count: int"" (optional)" 4
.el .IP "\f(CWx-multifd-page-count: int (optional)" 4
.IX Item "x-multifd-page-count: int (optional)"
Number of pages sent together to a thread.
The default value is 16 (since 2.11)
.ie n .IP """xbzrle-cache-size: int"" (optional)" 4
.el .IP "\f(CWxbzrle-cache-size: int (optional)" 4
.IX Item "xbzrle-cache-size: int (optional)"
cache size to be used by \s-1XBZRLE\s0 migration.  It
needs to be a multiple of the target page size
and a power of 2
(Since 2.11)
.ie n .IP """max-postcopy-bandwidth: int"" (optional)" 4
.el .IP "\f(CWmax-postcopy-bandwidth: int (optional)" 4
.IX Item "max-postcopy-bandwidth: int (optional)"
Background transfer bandwidth during postcopy.
Defaults to 0 (unlimited).  In bytes per second.
(Since 3.0)
.ie n .IP """max-cpu-throttle: int"" (optional)" 4
.el .IP "\f(CWmax-cpu-throttle: int (optional)" 4
.IX Item "max-cpu-throttle: int (optional)"
maximum cpu throttle percentage.
The default value is 99. (Since 3.1)

**Since:**
2.4

**migrate-set-parameters**  (Command)
Set various migration parameters.

**Arguments:** the members of \f(CW`MigrateSetParameters\*(C'

**Since:**
2.4

**Example:**

.Vb 2
        -&gt; { "execute": "migrate-set-parameters" ,
             "arguments": { "compress-level": 1 } }
.Ve

**MigrationParameters** (Object)

The optional members aren't actually optional.

**Members:**
.ie n .IP """compress-level: int"" (optional)" 4
.el .IP "\f(CWcompress-level: int (optional)" 4
.IX Item "compress-level: int (optional)"
compression level
.ie n .IP """compress-threads: int"" (optional)" 4
.el .IP "\f(CWcompress-threads: int (optional)" 4
.IX Item "compress-threads: int (optional)"
compression thread count
.ie n .IP """compress-wait-thread: boolean"" (optional)" 4
.el .IP "\f(CWcompress-wait-thread: boolean (optional)" 4
.IX Item "compress-wait-thread: boolean (optional)"
Controls behavior when all compression threads are
currently busy. If true (default), wait for a free
compression thread to become available; otherwise,
send the page uncompressed. (Since 3.1)
.ie n .IP """decompress-threads: int"" (optional)" 4
.el .IP "\f(CWdecompress-threads: int (optional)" 4
.IX Item "decompress-threads: int (optional)"
decompression thread count
.ie n .IP """cpu-throttle-initial: int"" (optional)" 4
.el .IP "\f(CWcpu-throttle-initial: int (optional)" 4
.IX Item "cpu-throttle-initial: int (optional)"
Initial percentage of time guest cpus are
throttled when migration auto-converge is activated.
(Since 2.7)
.ie n .IP """cpu-throttle-increment: int"" (optional)" 4
.el .IP "\f(CWcpu-throttle-increment: int (optional)" 4
.IX Item "cpu-throttle-increment: int (optional)"
throttle percentage increase each time
auto-converge detects that migration is not making
progress. (Since 2.7)
.ie n .IP """tls-creds: string"" (optional)" 4
.el .IP "\f(CWtls-creds: string (optional)" 4
.IX Item "tls-creds: string (optional)"
\s-1ID\s0 of the 'tls-creds' object that provides credentials
for establishing a \s-1TLS\s0 connection over the migration data
channel. On the outgoing side of the migration, the credentials
must be for a 'client' endpoint, while for the incoming side the
credentials must be for a 'server' endpoint.
An empty string means that \s-1QEMU\s0 will use plain text mode for
migration, rather than \s-1TLS\s0 (Since 2.7)
Note: 2.8 reports this by omitting tls-creds instead.
.ie n .IP """tls-hostname: string"" (optional)" 4
.el .IP "\f(CWtls-hostname: string (optional)" 4
.IX Item "tls-hostname: string (optional)"
hostname of the target host for the migration. This
is required when using x509 based \s-1TLS\s0 credentials and the
migration \s-1URI\s0 does not already include a hostname. For
example if using fd: or exec: based migration, the
hostname must be provided so that the server's x509
certificate identity can be validated. (Since 2.7)
An empty string means that \s-1QEMU\s0 will use the hostname
associated with the migration \s-1URI,\s0 if any. (Since 2.9)
Note: 2.8 reports this by omitting tls-hostname instead.
.ie n .IP """max-bandwidth: int"" (optional)" 4
.el .IP "\f(CWmax-bandwidth: int (optional)" 4
.IX Item "max-bandwidth: int (optional)"
to set maximum speed for migration. maximum speed in
bytes per second. (Since 2.8)
.ie n .IP """downtime-limit: int"" (optional)" 4
.el .IP "\f(CWdowntime-limit: int (optional)" 4
.IX Item "downtime-limit: int (optional)"
set maximum tolerated downtime for migration. maximum
downtime in milliseconds (Since 2.8)
.ie n .IP """x-checkpoint-delay: int"" (optional)" 4
.el .IP "\f(CWx-checkpoint-delay: int (optional)" 4
.IX Item "x-checkpoint-delay: int (optional)"
the delay time between two \s-1COLO\s0 checkpoints. (Since 2.8)
.ie n .IP """block-incremental: boolean"" (optional)" 4
.el .IP "\f(CWblock-incremental: boolean (optional)" 4
.IX Item "block-incremental: boolean (optional)"
Affects how much storage is migrated when the
block migration capability is enabled.  When false, the entire
storage backing chain is migrated into a flattened image at
the destination; when true, only the active qcow2 layer is
migrated and the destination must already have access to the
same backing chain as was used on the source.  (since 2.10)
.ie n .IP """x-multifd-channels: int"" (optional)" 4
.el .IP "\f(CWx-multifd-channels: int (optional)" 4
.IX Item "x-multifd-channels: int (optional)"
Number of channels used to migrate data in
parallel. This is the same number that the
number of sockets used for migration.
The default value is 2 (since 2.11)
.ie n .IP """x-multifd-page-count: int"" (optional)" 4
.el .IP "\f(CWx-multifd-page-count: int (optional)" 4
.IX Item "x-multifd-page-count: int (optional)"
Number of pages sent together to a thread.
The default value is 16 (since 2.11)
.ie n .IP """xbzrle-cache-size: int"" (optional)" 4
.el .IP "\f(CWxbzrle-cache-size: int (optional)" 4
.IX Item "xbzrle-cache-size: int (optional)"
cache size to be used by \s-1XBZRLE\s0 migration.  It
needs to be a multiple of the target page size
and a power of 2
(Since 2.11)
.ie n .IP """max-postcopy-bandwidth: int"" (optional)" 4
.el .IP "\f(CWmax-postcopy-bandwidth: int (optional)" 4
.IX Item "max-postcopy-bandwidth: int (optional)"
Background transfer bandwidth during postcopy.
Defaults to 0 (unlimited).  In bytes per second.
(Since 3.0)
.ie n .IP """max-cpu-throttle: int"" (optional)" 4
.el .IP "\f(CWmax-cpu-throttle: int (optional)" 4
.IX Item "max-cpu-throttle: int (optional)"
maximum cpu throttle percentage.
Defaults to 99.
(Since 3.1)

**Since:**
2.4

**query-migrate-parameters**  (Command)
Returns information about the current migration parameters

**Returns:**
\f(CW`MigrationParameters\*(C'

**Since:**
2.4

**Example:**

.Vb 11
        -&gt; { "execute": "query-migrate-parameters" }
        &lt;- { "return": {
                 "decompress-threads": 2,
                 "cpu-throttle-increment": 10,
                 "compress-threads": 8,
                 "compress-level": 1,
                 "cpu-throttle-initial": 20,
                 "max-bandwidth": 33554432,
                 "downtime-limit": 300
              }
           }
.Ve

**client\_migrate\_info**  (Command)
Set migration information for remote display.  This makes the server
ask the client to automatically reconnect using the new parameters
once migration finished successfully.  Only implemented for \s-1SPICE.\s0

**Arguments:**
.ie n .IP """protocol: string""" 4
.el .IP "\f(CWprotocol: string" 4
.IX Item "protocol: string"
must be spice\*(R"
.ie n .IP """hostname: string""" 4
.el .IP "\f(CWhostname: string" 4
.IX Item "hostname: string"
migration target hostname
.ie n .IP """port: int"" (optional)" 4
.el .IP "\f(CWport: int (optional)" 4
.IX Item "port: int (optional)"
spice tcp port for plaintext channels
.ie n .IP """tls-port: int"" (optional)" 4
.el .IP "\f(CWtls-port: int (optional)" 4
.IX Item "tls-port: int (optional)"
spice tcp port for tls-secured channels
.ie n .IP """cert-subject: string"" (optional)" 4
.el .IP "\f(CWcert-subject: string (optional)" 4
.IX Item "cert-subject: string (optional)"
server certificate subject

**Since:**
0.14.0

**Example:**

.Vb 5
        -&gt; { "execute": "client_migrate_info",
             "arguments": { "protocol": "spice",
                            "hostname": "virt42.lab.kraxel.org",
                            "port": 1234 } }
        &lt;- { "return": {} }
.Ve

**migrate-start-postcopy**  (Command)
Followup to a migration command to switch the migration to postcopy mode.
The postcopy-ram capability must be set on both source and destination
before the original migration command.

**Since:**
2.5

**Example:**

.Vb 2
        -&gt; { "execute": "migrate-start-postcopy" }
        &lt;- { "return": {} }
.Ve

**\s-1MIGRATION\s0**  (Event)
Emitted when a migration event happens

**Arguments:**
.ie n .IP """status: MigrationStatus""" 4
.el .IP "\f(CWstatus: MigrationStatus" 4
.IX Item "status: MigrationStatus"
\f(CW`MigrationStatus\*(C' describing the current migration status.

**Since:**
2.4

**Example:**

.Vb 3
        &lt;- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
            "event": "MIGRATION",
            "data": {"status": "completed"} }
.Ve

**\s-1MIGRATION\_PASS\s0**  (Event)
Emitted from the source side of a migration at the start of each pass
(when it syncs the dirty bitmap)

**Arguments:**
.ie n .IP """pass: int""" 4
.el .IP "\f(CWpass: int" 4
.IX Item "pass: int"
An incrementing count (starting at 1 on the first pass)

**Since:**
2.6

**Example:**

.Vb 2
        { "timestamp": {"seconds": 1449669631, "microseconds": 239225},
          "event": "MIGRATION_PASS", "data": {"pass": 2} }
.Ve

**COLOMessage** (Enum)

The message transmission between Primary side and Secondary side.

**Values:**
.ie n .IP """checkpoint-ready""" 4
.el .IP "\f(CWcheckpoint-ready" 4
.IX Item "checkpoint-ready"
Secondary \s-1VM\s0 (\s-1SVM\s0) is ready for checkpointing
.ie n .IP """checkpoint-request""" 4
.el .IP "\f(CWcheckpoint-request" 4
.IX Item "checkpoint-request"
Primary \s-1VM\s0 (\s-1PVM\s0) tells \s-1SVM\s0 to prepare for checkpointing
.ie n .IP """checkpoint-reply""" 4
.el .IP "\f(CWcheckpoint-reply" 4
.IX Item "checkpoint-reply"
\s-1SVM\s0 gets \s-1PVM\s0's checkpoint request
.ie n .IP """vmstate-send""" 4
.el .IP "\f(CWvmstate-send" 4
.IX Item "vmstate-send"
\s-1VM\s0's state will be sent by \s-1PVM.\s0
.ie n .IP """vmstate-size""" 4
.el .IP "\f(CWvmstate-size" 4
.IX Item "vmstate-size"
The total size of VMstate.
.ie n .IP """vmstate-received""" 4
.el .IP "\f(CWvmstate-received" 4
.IX Item "vmstate-received"
\s-1VM\s0's state has been received by \s-1SVM.\s0
.ie n .IP """vmstate-loaded""" 4
.el .IP "\f(CWvmstate-loaded" 4
.IX Item "vmstate-loaded"
\s-1VM\s0's state has been loaded by \s-1SVM.\s0

**Since:**
2.8

**COLOMode** (Enum)

The \s-1COLO\s0 current mode.

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
\s-1COLO\s0 is disabled.
.ie n .IP """primary""" 4
.el .IP "\f(CWprimary" 4
.IX Item "primary"
\s-1COLO\s0 node in primary side.
.ie n .IP """secondary""" 4
.el .IP "\f(CWsecondary" 4
.IX Item "secondary"
\s-1COLO\s0 node in slave side.

**Since:**
2.8

**FailoverStatus** (Enum)

An enumeration of \s-1COLO\s0 failover status

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
no failover has ever happened
.ie n .IP """require""" 4
.el .IP "\f(CWrequire" 4
.IX Item "require"
got failover requirement but not handled
.ie n .IP """active""" 4
.el .IP "\f(CWactive" 4
.IX Item "active"
in the process of doing failover
.ie n .IP """completed""" 4
.el .IP "\f(CWcompleted" 4
.IX Item "completed"
finish the process of failover
.ie n .IP """relaunch""" 4
.el .IP "\f(CWrelaunch" 4
.IX Item "relaunch"
restart the failover process, from 'none' -&gt; 'completed' (Since 2.9)

**Since:**
2.8

**\s-1COLO\_EXIT\s0**  (Event)
Emitted when \s-1VM\s0 finishes \s-1COLO\s0 mode due to some errors happening or
at the request of users.

**Arguments:**
.ie n .IP """mode: COLOMode""" 4
.el .IP "\f(CWmode: COLOMode" 4
.IX Item "mode: COLOMode"
report \s-1COLO\s0 mode when \s-1COLO\s0 exited.
.ie n .IP """reason: COLOExitReason""" 4
.el .IP "\f(CWreason: COLOExitReason" 4
.IX Item "reason: COLOExitReason"
describes the reason for the \s-1COLO\s0 exit.

**Since:**
3.1

**Example:**

.Vb 2
        &lt;- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
             "event": "COLO_EXIT", "data": {"mode": "primary", "reason": "request" } }
.Ve

**COLOExitReason** (Enum)

The reason for a \s-1COLO\s0 exit

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
no failover has ever happened. This can't occur in the
\s-1COLO_EXIT\s0 event, only in the result of query-colo-status.
.ie n .IP """request""" 4
.el .IP "\f(CWrequest" 4
.IX Item "request"
\s-1COLO\s0 exit is due to an external request
.ie n .IP """error""" 4
.el .IP "\f(CWerror" 4
.IX Item "error"
\s-1COLO\s0 exit is due to an internal error

**Since:**
3.1

**x-colo-lost-heartbeat**  (Command)
Tell qemu that heartbeat is lost, request it to do takeover procedures.
If this command is sent to the \s-1PVM,\s0 the Primary side will exit \s-1COLO\s0 mode.
If sent to the Secondary, the Secondary side will run failover work,
then takes over server operation to become the service \s-1VM.\s0

**Since:**
2.8

**Example:**

.Vb 2
        -&gt; { "execute": "x-colo-lost-heartbeat" }
        &lt;- { "return": {} }
.Ve

**migrate\_cancel**  (Command)
Cancel the current executing migration process.

**Returns:**
nothing on success

**Notes:**
This command succeeds even if there is no migration process running.

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "migrate_cancel" }
        &lt;- { "return": {} }
.Ve

**migrate-continue**  (Command)
Continue migration when it's in a paused state.

**Arguments:**
.ie n .IP """state: MigrationStatus""" 4
.el .IP "\f(CWstate: MigrationStatus" 4
.IX Item "state: MigrationStatus"
The state the migration is currently expected to be in

**Returns:**
nothing on success

**Since:**
2.11

**Example:**

.Vb 3
        -&gt; { "execute": "migrate-continue" , "arguments":
             { "state": "pre-switchover" } }
        &lt;- { "return": {} }
.Ve

**migrate\_set\_downtime**  (Command)
Set maximum tolerated downtime for migration.

**Arguments:**
.ie n .IP """value: number""" 4
.el .IP "\f(CWvalue: number" 4
.IX Item "value: number"
maximum downtime in seconds

**Returns:**
nothing on success

**Notes:**
This command is deprecated in favor of 'migrate-set-parameters'

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "migrate_set_downtime", "arguments": { "value": 0.1 } }
        &lt;- { "return": {} }
.Ve

**migrate\_set\_speed**  (Command)
Set maximum speed for migration.

**Arguments:**
.ie n .IP """value: int""" 4
.el .IP "\f(CWvalue: int" 4
.IX Item "value: int"
maximum speed in bytes per second.

**Returns:**
nothing on success

**Notes:**
This command is deprecated in favor of 'migrate-set-parameters'

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "migrate_set_speed", "arguments": { "value": 1024 } }
        &lt;- { "return": {} }
.Ve

**migrate-set-cache-size**  (Command)
Set cache size to be used by \s-1XBZRLE\s0 migration

**Arguments:**
.ie n .IP """value: int""" 4
.el .IP "\f(CWvalue: int" 4
.IX Item "value: int"
cache size in bytes

The size will be rounded down to the nearest power of 2.
The cache size can be modified before and during ongoing migration

**Returns:**
nothing on success

**Notes:**
This command is deprecated in favor of 'migrate-set-parameters'

**Since:**
1.2

**Example:**

.Vb 3
        -&gt; { "execute": "migrate-set-cache-size",
             "arguments": { "value": 536870912 } }
        &lt;- { "return": {} }
.Ve

**query-migrate-cache-size**  (Command)
Query migration \s-1XBZRLE\s0 cache size

**Returns:**
\s-1XBZRLE\s0 cache size in bytes

**Notes:**
This command is deprecated in favor of 'query-migrate-parameters'

**Since:**
1.2

**Example:**

.Vb 2
        -&gt; { "execute": "query-migrate-cache-size" }
        &lt;- { "return": 67108864 }
.Ve

**migrate**  (Command)
Migrates the current running guest to another Virtual Machine.

**Arguments:**
.ie n .IP """uri: string""" 4
.el .IP "\f(CWuri: string" 4
.IX Item "uri: string"
the Uniform Resource Identifier of the destination \s-1VM\s0
.ie n .IP """blk: boolean"" (optional)" 4
.el .IP "\f(CWblk: boolean (optional)" 4
.IX Item "blk: boolean (optional)"
do block migration (full disk copy)
.ie n .IP """inc: boolean"" (optional)" 4
.el .IP "\f(CWinc: boolean (optional)" 4
.IX Item "inc: boolean (optional)"
incremental disk copy migration
.ie n .IP """detach: boolean"" (optional)" 4
.el .IP "\f(CWdetach: boolean (optional)" 4
.IX Item "detach: boolean (optional)"
this argument exists only for compatibility reasons and
is ignored by \s-1QEMU\s0
.ie n .IP """resume: boolean"" (optional)" 4
.el .IP "\f(CWresume: boolean (optional)" 4
.IX Item "resume: boolean (optional)"
resume one paused migration, default off\*(R". (since 3.0)

**Returns:**
nothing on success

**Since:**
0.14.0

**Notes:**

* 1.  
  The 'query-migrate' command should be used to check migration's progress
  and final result (this information is provided by the 'status' member)
* 2.  
  All boolean arguments default to false
* 3.  
  The user Monitor's detach\*(R" argument is invalid in \s-1QMP\s0 and should not
  be used

**Example:**

.Vb 2
        -&gt; { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
        &lt;- { "return": {} }
.Ve

**migrate-incoming**  (Command)
Start an incoming migration, the qemu must have been started
with -incoming defer

**Arguments:**
.ie n .IP """uri: string""" 4
.el .IP "\f(CWuri: string" 4
.IX Item "uri: string"
The Uniform Resource Identifier identifying the source or
address to listen on

**Returns:**
nothing on success

**Since:**
2.3

**Notes:**

* 1.  
  It's a bad idea to use a string for the uri, but it needs to stay
  compatible with -incoming and the format of the uri is already exposed
  above libvirt.
* 2.  
  \s-1QEMU\s0 must be started with -incoming defer to allow migrate-incoming to
  be used.
* 3.  
  The uri format is the same as for -incoming

**Example:**

.Vb 3
        -&gt; { "execute": "migrate-incoming",
             "arguments": { "uri": "tcp::4446" } }
        &lt;- { "return": {} }
.Ve

**xen-save-devices-state**  (Command)
Save the state of all devices to file. The \s-1RAM\s0 and the block devices
of the \s-1VM\s0 are not saved by this command.

**Arguments:**
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
the file to save the state of the devices to as binary
data. See xen-save-devices-state.txt for a description of the binary
format.
.ie n .IP """live: boolean"" (optional)" 4
.el .IP "\f(CWlive: boolean (optional)" 4
.IX Item "live: boolean (optional)"
Optional argument to ask \s-1QEMU\s0 to treat this command as part of a live
migration. Default to true. (since 2.11)

**Returns:**
Nothing on success

**Since:**
1.1

**Example:**

.Vb 3
        -&gt; { "execute": "xen-save-devices-state",
             "arguments": { "filename": "/tmp/save" } }
        &lt;- { "return": {} }
.Ve

**xen-set-replication**  (Command)
Enable or disable replication.

**Arguments:**
.ie n .IP """enable: boolean""" 4
.el .IP "\f(CWenable: boolean" 4
.IX Item "enable: boolean"
true to enable, false to disable.
.ie n .IP """primary: boolean""" 4
.el .IP "\f(CWprimary: boolean" 4
.IX Item "primary: boolean"
true for primary or false for secondary.
.ie n .IP """failover: boolean"" (optional)" 4
.el .IP "\f(CWfailover: boolean (optional)" 4
.IX Item "failover: boolean (optional)"
true to do failover, false to stop. but cannot be
specified if 'enable' is true. default value is false.

**Returns:**
nothing.

**Example:**

.Vb 3
        -&gt; { "execute": "xen-set-replication",
             "arguments": {"enable": true, "primary": false} }
        &lt;- { "return": {} }
.Ve

**Since:**
2.9

**ReplicationStatus** (Object)

The result format for 'query-xen-replication-status'.

**Members:**
.ie n .IP """error: boolean""" 4
.el .IP "\f(CWerror: boolean" 4
.IX Item "error: boolean"
true if an error happened, false if replication is normal.
.ie n .IP """desc: string"" (optional)" 4
.el .IP "\f(CWdesc: string (optional)" 4
.IX Item "desc: string (optional)"
the human readable error description string, when
\f(CW`error\*(C' is 'true'.

**Since:**
2.9

**query-xen-replication-status**  (Command)
Query replication status while the vm is running.

**Returns:**
A \f(CW`ReplicationResult\*(C' object showing the status.

**Example:**

.Vb 2
        -&gt; { "execute": "query-xen-replication-status" }
        &lt;- { "return": { "error": false } }
.Ve

**Since:**
2.9

**xen-colo-do-checkpoint**  (Command)
Xen uses this command to notify replication to trigger a checkpoint.

**Returns:**
nothing.

**Example:**

.Vb 2
        -&gt; { "execute": "xen-colo-do-checkpoint" }
        &lt;- { "return": {} }
.Ve

**Since:**
2.9

**COLOStatus** (Object)

The result format for 'query-colo-status'.

**Members:**
.ie n .IP """mode: COLOMode""" 4
.el .IP "\f(CWmode: COLOMode" 4
.IX Item "mode: COLOMode"
\s-1COLO\s0 running mode. If \s-1COLO\s0 is running, this field will return
'primary' or 'secondary'.
.ie n .IP """reason: COLOExitReason""" 4
.el .IP "\f(CWreason: COLOExitReason" 4
.IX Item "reason: COLOExitReason"
describes the reason for the \s-1COLO\s0 exit.

**Since:**
3.1

**query-colo-status**  (Command)
Query \s-1COLO\s0 status while the vm is running.

**Returns:**
A \f(CW`COLOStatus\*(C' object showing the status.

**Example:**

.Vb 2
        -&gt; { "execute": "query-colo-status" }
        &lt;- { "return": { "mode": "primary", "active": true, "reason": "request" } }
.Ve

**Since:**
3.1

**migrate-recover**  (Command)
Provide a recovery migration stream \s-1URI.\s0

**Arguments:**
.ie n .IP """uri: string""" 4
.el .IP "\f(CWuri: string" 4
.IX Item "uri: string"
the \s-1URI\s0 to be used for the recovery of migration stream.

**Returns:**
nothing.

**Example:**

.Vb 3
        -&gt; { "execute": "migrate-recover",
             "arguments": { "uri": "tcp:192.168.1.200:12345" } }
        &lt;- { "return": {} }
.Ve

**Since:**
3.0

**migrate-pause**  (Command)
Pause a migration.  Currently it only supports postcopy.

**Returns:**
nothing.

**Example:**

.Vb 2
        -&gt; { "execute": "migrate-pause" }
        &lt;- { "return": {} }
.Ve

**Since:**
3.0

<a name="transactions"></a>

### Transactions

.IX Subsection "Transactions"
**Abort** (Object)

This action can be used to test transaction failure.

**Since:**
1.6

**ActionCompletionMode** (Enum)

An enumeration of Transactional completion modes.

**Values:**
.ie n .IP """individual""" 4
.el .IP "\f(CWindividual" 4
.IX Item "individual"
Do not attempt to cancel any other Actions if any Actions fail
after the Transaction request succeeds. All Actions that
can complete successfully will do so without waiting on others.
This is the default.
.ie n .IP """grouped""" 4
.el .IP "\f(CWgrouped" 4
.IX Item "grouped"
If any Action fails after the Transaction succeeds, cancel all
Actions. Actions do not complete until all Actions are ready to
complete. May be rejected by Actions that do not support this
completion mode.

**Since:**
2.5

**TransactionAction** (Object)

A discriminated record of operations that can be performed with
\f(CW`transaction\*(C'. Action \f(CW\*(C\`type\*(C' can be:

* \f(CW`abort\*(C': since 1.6
* \f(CW`block-dirty-bitmap-add\*(C': since 2.5
* \f(CW`block-dirty-bitmap-clear\*(C': since 2.5
* \f(CW`x-block-dirty-bitmap-enable\*(C': since 3.0
* \f(CW`x-block-dirty-bitmap-disable\*(C': since 3.0
* \f(CW`x-block-dirty-bitmap-merge\*(C': since 3.1
* \f(CW`blockdev-backup\*(C': since 2.3
* \f(CW`blockdev-snapshot\*(C': since 2.5
* \f(CW`blockdev-snapshot-internal-sync\*(C': since 1.7
* \f(CW`blockdev-snapshot-sync\*(C': since 1.1
* \f(CW`drive-backup\*(C': since 1.6

**Members:**
.ie n .IP """type""" 4
.el .IP "\f(CWtype" 4
.IX Item "type"
One of abort\*(R", \*(L"block-dirty-bitmap-add\*(R", \*(L"block-dirty-bitmap-clear\*(R", \*(L"x-block-dirty-bitmap-enable\*(R", \*(L"x-block-dirty-bitmap-disable\*(R", \*(L"x-block-dirty-bitmap-merge\*(R", \*(L"blockdev-backup\*(R", \*(L"blockdev-snapshot\*(R", \*(L"blockdev-snapshot-internal-sync\*(R", \*(L"blockdev-snapshot-sync\*(R", \*(L"drive-backup\*(R"
.ie n .IP """data: Abort"" when ""type"" is ""abort""" 4
.el .IP "\f(CWdata: Abort when \f(CWtype is \`\`abort''" 4
.IX Item "data: Abort when type is abort"
.ie n .IP """data: BlockDirtyBitmapAdd"" when ""type"" is ""block-dirty-bitmap-add""" 4
.el .IP "\f(CWdata: BlockDirtyBitmapAdd when \f(CWtype is \`\`block-dirty-bitmap-add''" 4
.IX Item "data: BlockDirtyBitmapAdd when type is block-dirty-bitmap-add"
.ie n .IP """data: BlockDirtyBitmap"" when ""type"" is ""block-dirty-bitmap-clear""" 4
.el .IP "\f(CWdata: BlockDirtyBitmap when \f(CWtype is \`\`block-dirty-bitmap-clear''" 4
.IX Item "data: BlockDirtyBitmap when type is block-dirty-bitmap-clear"
.ie n .IP """data: BlockDirtyBitmap"" when ""type"" is ""x-block-dirty-bitmap-enable""" 4
.el .IP "\f(CWdata: BlockDirtyBitmap when \f(CWtype is \`\`x-block-dirty-bitmap-enable''" 4
.IX Item "data: BlockDirtyBitmap when type is x-block-dirty-bitmap-enable"
.ie n .IP """data: BlockDirtyBitmap"" when ""type"" is ""x-block-dirty-bitmap-disable""" 4
.el .IP "\f(CWdata: BlockDirtyBitmap when \f(CWtype is \`\`x-block-dirty-bitmap-disable''" 4
.IX Item "data: BlockDirtyBitmap when type is x-block-dirty-bitmap-disable"
.ie n .IP """data: BlockDirtyBitmapMerge"" when ""type"" is ""x-block-dirty-bitmap-merge""" 4
.el .IP "\f(CWdata: BlockDirtyBitmapMerge when \f(CWtype is \`\`x-block-dirty-bitmap-merge''" 4
.IX Item "data: BlockDirtyBitmapMerge when type is x-block-dirty-bitmap-merge"
.ie n .IP """data: BlockdevBackup"" when ""type"" is ""blockdev-backup""" 4
.el .IP "\f(CWdata: BlockdevBackup when \f(CWtype is \`\`blockdev-backup''" 4
.IX Item "data: BlockdevBackup when type is blockdev-backup"
.ie n .IP """data: BlockdevSnapshot"" when ""type"" is ""blockdev-snapshot""" 4
.el .IP "\f(CWdata: BlockdevSnapshot when \f(CWtype is \`\`blockdev-snapshot''" 4
.IX Item "data: BlockdevSnapshot when type is blockdev-snapshot"
.ie n .IP """data: BlockdevSnapshotInternal"" when ""type"" is ""blockdev-snapshot-internal-sync""" 4
.el .IP "\f(CWdata: BlockdevSnapshotInternal when \f(CWtype is \`\`blockdev-snapshot-internal-sync''" 4
.IX Item "data: BlockdevSnapshotInternal when type is blockdev-snapshot-internal-sync"
.ie n .IP """data: BlockdevSnapshotSync"" when ""type"" is ""blockdev-snapshot-sync""" 4
.el .IP "\f(CWdata: BlockdevSnapshotSync when \f(CWtype is \`\`blockdev-snapshot-sync''" 4
.IX Item "data: BlockdevSnapshotSync when type is blockdev-snapshot-sync"
.ie n .IP """data: DriveBackup"" when ""type"" is ""drive-backup""" 4
.el .IP "\f(CWdata: DriveBackup when \f(CWtype is \`\`drive-backup''" 4
.IX Item "data: DriveBackup when type is drive-backup"

**Since:**
1.1

**TransactionProperties** (Object)

Optional arguments to modify the behavior of a Transaction.

**Members:**
.ie n .IP """completion-mode: ActionCompletionMode"" (optional)" 4
.el .IP "\f(CWcompletion-mode: ActionCompletionMode (optional)" 4
.IX Item "completion-mode: ActionCompletionMode (optional)"
Controls how jobs launched asynchronously by
Actions will complete or fail as a group.
See \f(CW`ActionCompletionMode\*(C' for details.

**Since:**
2.5

**transaction**  (Command)
Executes a number of transactionable \s-1QMP\s0 commands atomically. If any
operation fails, then the entire set of actions will be abandoned and the
appropriate error returned.

For external snapshots, the dictionary contains the device, the file to use for
the new snapshot, and the format.  The default format, if not specified, is
qcow2.

Each new snapshot defaults to being created by \s-1QEMU\s0 (wiping any
contents if the file already exists), but it is also possible to reuse
an externally-created file.  In the latter case, you should ensure that
the new image file has the same contents as the current one; \s-1QEMU\s0 cannot
perform any meaningful check.  Typically this is achieved by using the
current image file as the backing file for the new image.

On failure, the original disks pre-snapshot attempt will be used.

For internal snapshots, the dictionary contains the device and the snapshot's
name.  If an internal snapshot matching name already exists, the request will
be rejected.  Only some image formats support it, for example, qcow2, rbd,
and sheepdog.

On failure, qemu will try delete the newly created internal snapshot in the
transaction.  When an I/O error occurs during deletion, the user needs to fix
it later with qemu-img or other command.

**Arguments:**
.ie n .IP """actions: array of TransactionAction""" 4
.el .IP "\f(CWactions: array of TransactionAction" 4
.IX Item "actions: array of TransactionAction"
List of \f(CW`TransactionAction\*(C';
information needed for the respective operations.
.ie n .IP """properties: TransactionProperties"" (optional)" 4
.el .IP "\f(CWproperties: TransactionProperties (optional)" 4
.IX Item "properties: TransactionProperties (optional)"
structure of additional options to control the
execution of the transaction. See \f(CW`TransactionProperties\*(C'
for additional detail.

**Returns:**
nothing on success

Errors depend on the operations of the transaction

**Note:**
The transaction aborts on the first failure.  Therefore, there will be
information on only one failed operation returned in an error condition, and
subsequent actions will not have been attempted.

**Since:**
1.1

**Example:**

.Vb 10
        -&gt; { "execute": "transaction",
             "arguments": { "actions": [
                 { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd0",
                                             "snapshot-file": "/some/place/my-image",
                                             "format": "qcow2" } },
                 { "type": "blockdev-snapshot-sync", "data" : { "node-name": "myfile",
                                             "snapshot-file": "/some/place/my-image2",
                                             "snapshot-node-name": "node3432",
                                             "mode": "existing",
                                             "format": "qcow2" } },
                 { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd1",
                                             "snapshot-file": "/some/place/my-image2",
                                             "mode": "existing",
                                             "format": "qcow2" } },
                 { "type": "blockdev-snapshot-internal-sync", "data" : {
                                             "device": "ide-hd2",
                                             "name": "snapshot0" } } ] } }
        &lt;- { "return": {} }
.Ve

<a name="tracing"></a>

### Tracing

.IX Subsection "Tracing"
**TraceEventState** (Enum)

State of a tracing event.

**Values:**
.ie n .IP """unavailable""" 4
.el .IP "\f(CWunavailable" 4
.IX Item "unavailable"
The event is statically disabled.
.ie n .IP """disabled""" 4
.el .IP "\f(CWdisabled" 4
.IX Item "disabled"
The event is dynamically disabled.
.ie n .IP """enabled""" 4
.el .IP "\f(CWenabled" 4
.IX Item "enabled"
The event is dynamically enabled.

**Since:**
2.2

**TraceEventInfo** (Object)

Information of a tracing event.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
Event name.
.ie n .IP """state: TraceEventState""" 4
.el .IP "\f(CWstate: TraceEventState" 4
.IX Item "state: TraceEventState"
Tracing state.
.ie n .IP """vcpu: boolean""" 4
.el .IP "\f(CWvcpu: boolean" 4
.IX Item "vcpu: boolean"
Whether this is a per-vCPU event (since 2.7).

An event is per-vCPU if it has the vcpu\*(R" property in the \*(L"trace-events\*(R"
files.

**Since:**
2.2

**trace-event-get-state**  (Command)
Query the state of events.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
Event name pattern (case-sensitive glob).
.ie n .IP """vcpu: int"" (optional)" 4
.el .IP "\f(CWvcpu: int (optional)" 4
.IX Item "vcpu: int (optional)"
The vCPU to query (any by default; since 2.7).

**Returns:**
a list of \f(CW`TraceEventInfo\*(C' for the matching events

An event is returned if:

* its name matches the \f(CW`name\*(C' pattern, and
* if \f(CW`vcpu\*(C' is given, the event has the \*(L"vcpu\*(R" property.

Therefore, if \f(CW`vcpu\*(C' is given, the operation will only match per-vCPU events,
returning their state on the specified vCPU. Special case: if \f(CW`name\*(C' is an
exact match, \f(CW`vcpu\*(C' is given and the event does not have the \*(L"vcpu\*(R" property,
an error is returned.

**Since:**
2.2

**Example:**

.Vb 3
        -&gt; { "execute": "trace-event-get-state",
             "arguments": { "name": "qemu_memalign" } }
        &lt;- { "return": [ { "name": "qemu_memalign", "state": "disabled" } ] }
.Ve

**trace-event-set-state**  (Command)
Set the dynamic tracing state of events.

**Arguments:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
Event name pattern (case-sensitive glob).
.ie n .IP """enable: boolean""" 4
.el .IP "\f(CWenable: boolean" 4
.IX Item "enable: boolean"
Whether to enable tracing.
.ie n .IP """ignore-unavailable: boolean"" (optional)" 4
.el .IP "\f(CWignore-unavailable: boolean (optional)" 4
.IX Item "ignore-unavailable: boolean (optional)"
Do not match unavailable events with \f(CW`name\*(C'.
.ie n .IP """vcpu: int"" (optional)" 4
.el .IP "\f(CWvcpu: int (optional)" 4
.IX Item "vcpu: int (optional)"
The vCPU to act upon (all by default; since 2.7).

An event's state is modified if:

* its name matches the \f(CW`name\*(C' pattern, and
* if \f(CW`vcpu\*(C' is given, the event has the \*(L"vcpu\*(R" property.

Therefore, if \f(CW`vcpu\*(C' is given, the operation will only match per-vCPU events,
setting their state on the specified vCPU. Special case: if \f(CW`name\*(C' is an exact
match, \f(CW`vcpu\*(C' is given and the event does not have the \*(L"vcpu\*(R" property, an
error is returned.

**Since:**
2.2

**Example:**

.Vb 3
        -&gt; { "execute": "trace-event-set-state",
             "arguments": { "name": "qemu_memalign", "enable": "true" } }
        &lt;- { "return": {} }
.Ve

<a name="s-1qmps0-introspection"></a>

### \s-1QMP\s0 introspection

.IX Subsection "QMP introspection"
**query-qmp-schema**  (Command)
Command query-qmp-schema exposes the \s-1QMP\s0 wire \s-1ABI\s0 as an array of
SchemaInfo.  This lets \s-1QMP\s0 clients figure out what commands and
events are available in this \s-1QEMU,\s0 and their parameters and results.

However, the SchemaInfo can't reflect all the rules and restrictions
that apply to \s-1QMP.\s0  It's interface introspection (figuring out
what's there), not interface specification.  The specification is in
the \s-1QAPI\s0 schema.

Furthermore, while we strive to keep the \s-1QMP\s0 wire format
backwards-compatible across qemu versions, the introspection output
is not guaranteed to have the same stability.  For example, one
version of qemu may list an object member as an optional
non-variant, while another lists the same member only through the
object's variants; or the type of a member may change from a generic
string into a specific enum or from one specific type into an
alternate that includes the original type alongside something else.

**Returns:**
array of \f(CW`SchemaInfo\*(C', where each element describes an
entity in the \s-1ABI:\s0 command, event, type, ...

The order of the various SchemaInfo is unspecified; however, all
names are guaranteed to be unique (no name will be duplicated with
different meta-types).

**Note:**
the \s-1QAPI\s0 schema is also used to help define **internal**
interfaces, by defining \s-1QAPI\s0 types.  These are not part of the \s-1QMP\s0
wire \s-1ABI,\s0 and therefore not returned by this command.

**Since:**
2.5

**SchemaMetaType** (Enum)

This is a \f(CW`SchemaInfo\*(C''s meta type, i.e. the kind of entity it
describes.

**Values:**
.ie n .IP """builtin""" 4
.el .IP "\f(CWbuiltin" 4
.IX Item "builtin"
a predefined type such as 'int' or 'bool'.
.ie n .IP """enum""" 4
.el .IP "\f(CWenum" 4
.IX Item "enum"
an enumeration type
.ie n .IP """array""" 4
.el .IP "\f(CWarray" 4
.IX Item "array"
an array type
.ie n .IP """object""" 4
.el .IP "\f(CWobject" 4
.IX Item "object"
an object type (struct or union)
.ie n .IP """alternate""" 4
.el .IP "\f(CWalternate" 4
.IX Item "alternate"
an alternate type
.ie n .IP """command""" 4
.el .IP "\f(CWcommand" 4
.IX Item "command"
a \s-1QMP\s0 command
.ie n .IP """event""" 4
.el .IP "\f(CWevent" 4
.IX Item "event"
a \s-1QMP\s0 event

**Since:**
2.5

**SchemaInfo** (Object)

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the entity's name, inherited from \f(CW`base\*(C'.
The SchemaInfo is always referenced by this name.
Commands and events have the name defined in the \s-1QAPI\s0 schema.
Unlike command and event names, type names are not part of
the wire \s-1ABI.\s0  Consequently, type names are meaningless
strings here, although they are still guaranteed unique
regardless of \f(CW`meta-type\*(C'.
.ie n .IP """meta-type: SchemaMetaType""" 4
.el .IP "\f(CWmeta-type: SchemaMetaType" 4
.IX Item "meta-type: SchemaMetaType"
the entity's meta type, inherited from \f(CW`base\*(C'.
.ie n .IP "The members of ""SchemaInfoBuiltin"" when ""meta-type"" is ""builtin""" 4
.el .IP "The members of \f(CWSchemaInfoBuiltin when \f(CWmeta-type is \`\`builtin''" 4
.IX Item "The members of SchemaInfoBuiltin when meta-type is builtin"
.ie n .IP "The members of ""SchemaInfoEnum"" when ""meta-type"" is ""enum""" 4
.el .IP "The members of \f(CWSchemaInfoEnum when \f(CWmeta-type is \`\`enum''" 4
.IX Item "The members of SchemaInfoEnum when meta-type is enum"
.ie n .IP "The members of ""SchemaInfoArray"" when ""meta-type"" is ""array""" 4
.el .IP "The members of \f(CWSchemaInfoArray when \f(CWmeta-type is \`\`array''" 4
.IX Item "The members of SchemaInfoArray when meta-type is array"
.ie n .IP "The members of ""SchemaInfoObject"" when ""meta-type"" is ""object""" 4
.el .IP "The members of \f(CWSchemaInfoObject when \f(CWmeta-type is \`\`object''" 4
.IX Item "The members of SchemaInfoObject when meta-type is object"
.ie n .IP "The members of ""SchemaInfoAlternate"" when ""meta-type"" is ""alternate""" 4
.el .IP "The members of \f(CWSchemaInfoAlternate when \f(CWmeta-type is \`\`alternate''" 4
.IX Item "The members of SchemaInfoAlternate when meta-type is alternate"
.ie n .IP "The members of ""SchemaInfoCommand"" when ""meta-type"" is ""command""" 4
.el .IP "The members of \f(CWSchemaInfoCommand when \f(CWmeta-type is \`\`command''" 4
.IX Item "The members of SchemaInfoCommand when meta-type is command"
.ie n .IP "The members of ""SchemaInfoEvent"" when ""meta-type"" is ""event""" 4
.el .IP "The members of \f(CWSchemaInfoEvent when \f(CWmeta-type is \`\`event''" 4
.IX Item "The members of SchemaInfoEvent when meta-type is event"

Additional members depend on the value of \f(CW`meta-type\*(C'.

**Since:**
2.5

**SchemaInfoBuiltin** (Object)

Additional SchemaInfo members for meta-type 'builtin'.

**Members:**
.ie n .IP """json-type: JSONType""" 4
.el .IP "\f(CWjson-type: JSONType" 4
.IX Item "json-type: JSONType"
the \s-1JSON\s0 type used for this type on the wire.

**Since:**
2.5

**JSONType** (Enum)

The four primitive and two structured types according to \s-1RFC 8259\s0
section 1, plus 'int' (split off 'number'), plus the obvious top
type 'value'.

**Values:**
.ie n .IP """string""" 4
.el .IP "\f(CWstring" 4
.IX Item "string"
Not documented
.ie n .IP """number""" 4
.el .IP "\f(CWnumber" 4
.IX Item "number"
Not documented
.ie n .IP """int""" 4
.el .IP "\f(CWint" 4
.IX Item "int"
Not documented
.ie n .IP """boolean""" 4
.el .IP "\f(CWboolean" 4
.IX Item "boolean"
Not documented
.ie n .IP """null""" 4
.el .IP "\f(CWnull" 4
.IX Item "null"
Not documented
.ie n .IP """object""" 4
.el .IP "\f(CWobject" 4
.IX Item "object"
Not documented
.ie n .IP """array""" 4
.el .IP "\f(CWarray" 4
.IX Item "array"
Not documented
.ie n .IP """value""" 4
.el .IP "\f(CWvalue" 4
.IX Item "value"
Not documented

**Since:**
2.5

**SchemaInfoEnum** (Object)

Additional SchemaInfo members for meta-type 'enum'.

**Members:**
.ie n .IP """values: array of string""" 4
.el .IP "\f(CWvalues: array of string" 4
.IX Item "values: array of string"
the enumeration type's values, in no particular order.

Values of this type are \s-1JSON\s0 string on the wire.

**Since:**
2.5

**SchemaInfoArray** (Object)

Additional SchemaInfo members for meta-type 'array'.

**Members:**
.ie n .IP """element-type: string""" 4
.el .IP "\f(CWelement-type: string" 4
.IX Item "element-type: string"
the array type's element type.

Values of this type are \s-1JSON\s0 array on the wire.

**Since:**
2.5

**SchemaInfoObject** (Object)

Additional SchemaInfo members for meta-type 'object'.

**Members:**
.ie n .IP """members: array of SchemaInfoObjectMember""" 4
.el .IP "\f(CWmembers: array of SchemaInfoObjectMember" 4
.IX Item "members: array of SchemaInfoObjectMember"
the object type's (non-variant) members, in no particular order.
.ie n .IP """tag: string"" (optional)" 4
.el .IP "\f(CWtag: string (optional)" 4
.IX Item "tag: string (optional)"
the name of the member serving as type tag.
An element of \f(CW`members\*(C' with this name must exist.
.ie n .IP """variants: array of SchemaInfoObjectVariant"" (optional)" 4
.el .IP "\f(CWvariants: array of SchemaInfoObjectVariant (optional)" 4
.IX Item "variants: array of SchemaInfoObjectVariant (optional)"
variant members, i.e. additional members that
depend on the type tag's value.  Present exactly when
\f(CW`tag\*(C' is present.  The variants are in no particular order,
and may even differ from the order of the values of the
enum type of the \f(CW`tag\*(C'.

Values of this type are \s-1JSON\s0 object on the wire.

**Since:**
2.5

**SchemaInfoObjectMember** (Object)

An object member.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the member's name, as defined in the \s-1QAPI\s0 schema.
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
the name of the member's type.
.ie n .IP """default: value"" (optional)" 4
.el .IP "\f(CWdefault: value (optional)" 4
.IX Item "default: value (optional)"
default when used as command parameter.
If absent, the parameter is mandatory.
If present, the value must be null.  The parameter is
optional, and behavior when it's missing is not specified
here.
Future extension: if present and non-null, the parameter
is optional, and defaults to this value.

**Since:**
2.5

**SchemaInfoObjectVariant** (Object)

The variant members for a value of the type tag.

**Members:**
.ie n .IP """case: string""" 4
.el .IP "\f(CWcase: string" 4
.IX Item "case: string"
a value of the type tag.
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
the name of the object type that provides the variant members
when the type tag has value \f(CW`case\*(C'.

**Since:**
2.5

**SchemaInfoAlternate** (Object)

Additional SchemaInfo members for meta-type 'alternate'.

**Members:**
.ie n .IP """members: array of SchemaInfoAlternateMember""" 4
.el .IP "\f(CWmembers: array of SchemaInfoAlternateMember" 4
.IX Item "members: array of SchemaInfoAlternateMember"
the alternate type's members, in no particular order.
The members' wire encoding is distinct, see
docs/devel/qapi-code-gen.txt section Alternate types.

On the wire, this can be any of the members.

**Since:**
2.5

**SchemaInfoAlternateMember** (Object)

An alternate member.

**Members:**
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
the name of the member's type.

**Since:**
2.5

**SchemaInfoCommand** (Object)

Additional SchemaInfo members for meta-type 'command'.

**Members:**
.ie n .IP """arg-type: string""" 4
.el .IP "\f(CWarg-type: string" 4
.IX Item "arg-type: string"
the name of the object type that provides the command's
parameters.
.ie n .IP """ret-type: string""" 4
.el .IP "\f(CWret-type: string" 4
.IX Item "ret-type: string"
the name of the command's result type.
.ie n .IP """allow-oob: boolean"" (optional)" 4
.el .IP "\f(CWallow-oob: boolean (optional)" 4
.IX Item "allow-oob: boolean (optional)"
whether the command allows out-of-band execution,
defaults to false (Since: 2.12)

**\s-1TODO:\s0**
\f(CW`success-response\*(C' (currently irrelevant, because it's \s-1QGA,\s0 not \s-1QMP\s0)

**Since:**
2.5

**SchemaInfoEvent** (Object)

Additional SchemaInfo members for meta-type 'event'.

**Members:**
.ie n .IP """arg-type: string""" 4
.el .IP "\f(CWarg-type: string" 4
.IX Item "arg-type: string"
the name of the object type that provides the event's
parameters.

**Since:**
2.5

<a name="miscellanea"></a>

### Miscellanea

.IX Subsection "Miscellanea"
**qmp\_capabilities**  (Command)
Enable \s-1QMP\s0 capabilities.

Arguments:

**Arguments:**
.ie n .IP """enable: array of QMPCapability"" (optional)" 4
.el .IP "\f(CWenable: array of QMPCapability (optional)" 4
.IX Item "enable: array of QMPCapability (optional)"
An optional list of QMPCapability values to enable.  The
client must not enable any capability that is not
mentioned in the \s-1QMP\s0 greeting message.  If the field is not
provided, it means no \s-1QMP\s0 capabilities will be enabled.
(since 2.12)

**Example:**

.Vb 3
        -&gt; { "execute": "qmp_capabilities",
             "arguments": { "enable": [ "oob" ] } }
        &lt;- { "return": {} }
.Ve

**Notes:**
This command is valid exactly when first connecting: it must be
issued before any other command will be accepted, and will fail once the
monitor is accepting other commands. (see qemu docs/interop/qmp-spec.txt)

The \s-1QMP\s0 client needs to explicitly enable \s-1QMP\s0 capabilities, otherwise
all the \s-1QMP\s0 capabilities will be turned off by default.

**Since:**
0.13

**QMPCapability** (Enum)

Enumeration of capabilities to be advertised during initial client
connection, used for agreeing on particular \s-1QMP\s0 extension behaviors.

**Values:**
.ie n .IP """oob""" 4
.el .IP "\f(CWoob" 4
.IX Item "oob"
\s-1QMP\s0 ability to support out-of-band requests.
(Please refer to qmp-spec.txt for more information on \s-1OOB\s0)

**Since:**
2.12

**VersionTriple** (Object)

A three-part version number.

**Members:**
.ie n .IP """major: int""" 4
.el .IP "\f(CWmajor: int" 4
.IX Item "major: int"
The major version number.
.ie n .IP """minor: int""" 4
.el .IP "\f(CWminor: int" 4
.IX Item "minor: int"
The minor version number.
.ie n .IP """micro: int""" 4
.el .IP "\f(CWmicro: int" 4
.IX Item "micro: int"
The micro version number.

**Since:**
2.4

**VersionInfo** (Object)

A description of \s-1QEMU\s0's version.

**Members:**
.ie n .IP """qemu: VersionTriple""" 4
.el .IP "\f(CWqemu: VersionTriple" 4
.IX Item "qemu: VersionTriple"
The version of \s-1QEMU.\s0  By current convention, a micro
version of 50 signifies a development branch.  A micro version
greater than or equal to 90 signifies a release candidate for
the next minor version.  A micro version of less than 50
signifies a stable release.
.ie n .IP """package: string""" 4
.el .IP "\f(CWpackage: string" 4
.IX Item "package: string"
\s-1QEMU\s0 will always set this field to an empty string.  Downstream
versions of \s-1QEMU\s0 should set this to a non-empty string.  The
exact format depends on the downstream however it highly
recommended that a unique name is used.

**Since:**
0.14.0

**query-version**  (Command)
Returns the current version of \s-1QEMU.\s0

**Returns:**
A \f(CW`VersionInfo\*(C' object describing the current version of \s-1QEMU.\s0

**Since:**
0.14.0

**Example:**

.Vb 11
        -&gt; { "execute": "query-version" }
        &lt;- {
              "return":{
                 "qemu":{
                    "major":0,
                    "minor":11,
                    "micro":5
                 },
                 "package":""
              }
           }
.Ve

**CommandInfo** (Object)

Information about a \s-1QMP\s0 command

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
The command name

**Since:**
0.14.0

**query-commands**  (Command)
Return a list of supported \s-1QMP\s0 commands by this server

**Returns:**
A list of \f(CW`CommandInfo\*(C' for all supported commands

**Since:**
0.14.0

**Example:**

.Vb 11
        -&gt; { "execute": "query-commands" }
        &lt;- {
             "return":[
                {
                   "name":"query-balloon"
                },
                {
                   "name":"system_powerdown"
                }
             ]
           }
.Ve

**Note:**
This example has been shortened as the real response is too long.

**LostTickPolicy** (Enum)

Policy for handling lost ticks in timer devices.

**Values:**
.ie n .IP """discard""" 4
.el .IP "\f(CWdiscard" 4
.IX Item "discard"
throw away the missed tick(s) and continue with future injection
normally.  Guest time may be delayed, unless the \s-1OS\s0 has explicit
handling of lost ticks
.ie n .IP """delay""" 4
.el .IP "\f(CWdelay" 4
.IX Item "delay"
continue to deliver ticks at the normal rate.  Guest time will be
delayed due to the late tick
.ie n .IP """merge""" 4
.el .IP "\f(CWmerge" 4
.IX Item "merge"
merge the missed tick(s) into one tick and inject.  Guest time
may be delayed, depending on how the \s-1OS\s0 reacts to the merging
of ticks
.ie n .IP """slew""" 4
.el .IP "\f(CWslew" 4
.IX Item "slew"
deliver ticks at a higher rate to catch up with the missed tick. The
guest time should not be delayed once catchup is complete.

**Since:**
2.0

**add\_client**  (Command)
Allow client connections for \s-1VNC,\s0 Spice and socket based
character devices to be passed in to \s-1QEMU\s0 via \s-1SCM_RIGHTS.\s0

**Arguments:**
.ie n .IP """protocol: string""" 4
.el .IP "\f(CWprotocol: string" 4
.IX Item "protocol: string"
protocol name. Valid names are vnc\*(R", \*(L"spice\*(R" or the
name of a character device (eg. from -chardev id=XXXX)
.ie n .IP """fdname: string""" 4
.el .IP "\f(CWfdname: string" 4
.IX Item "fdname: string"
file descriptor name previously passed via 'getfd' command
.ie n .IP """skipauth: boolean"" (optional)" 4
.el .IP "\f(CWskipauth: boolean (optional)" 4
.IX Item "skipauth: boolean (optional)"
whether to skip authentication. Only applies
to vnc\*(R" and \*(L"spice\*(R" protocols
.ie n .IP """tls: boolean"" (optional)" 4
.el .IP "\f(CWtls: boolean (optional)" 4
.IX Item "tls: boolean (optional)"
whether to perform \s-1TLS.\s0 Only applies to the spice\*(R"
protocol

**Returns:**
nothing on success.

**Since:**
0.14.0

**Example:**

.Vb 3
        -&gt; { "execute": "add_client", "arguments": { "protocol": "vnc",
                                                     "fdname": "myclient" } }
        &lt;- { "return": {} }
.Ve

**NameInfo** (Object)

Guest name information.

**Members:**
.ie n .IP """name: string"" (optional)" 4
.el .IP "\f(CWname: string (optional)" 4
.IX Item "name: string (optional)"
The name of the guest

**Since:**
0.14.0

**query-name**  (Command)
Return the name information of a guest.

**Returns:**
\f(CW`NameInfo\*(C' of the guest

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "query-name" }
        &lt;- { "return": { "name": "qemu-name" } }
.Ve

**KvmInfo** (Object)

Information about support for \s-1KVM\s0 acceleration

**Members:**
.ie n .IP """enabled: boolean""" 4
.el .IP "\f(CWenabled: boolean" 4
.IX Item "enabled: boolean"
true if \s-1KVM\s0 acceleration is active
.ie n .IP """present: boolean""" 4
.el .IP "\f(CWpresent: boolean" 4
.IX Item "present: boolean"
true if \s-1KVM\s0 acceleration is built into this executable

**Since:**
0.14.0

**query-kvm**  (Command)
Returns information about \s-1KVM\s0 acceleration

**Returns:**
\f(CW`KvmInfo\*(C'

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "query-kvm" }
        &lt;- { "return": { "enabled": true, "present": true } }
.Ve

**UuidInfo** (Object)

Guest \s-1UUID\s0 information (Universally Unique Identifier).

**Members:**
.ie n .IP """UUID: string""" 4
.el .IP "\f(CWUUID: string" 4
.IX Item "UUID: string"
the \s-1UUID\s0 of the guest

**Since:**
0.14.0

**Notes:**
If no \s-1UUID\s0 was specified for the guest, a null \s-1UUID\s0 is returned.

**query-uuid**  (Command)
Query the guest \s-1UUID\s0 information.

**Returns:**
The \f(CW`UuidInfo\*(C' for the guest

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "query-uuid" }
        &lt;- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
.Ve

**EventInfo** (Object)

Information about a \s-1QMP\s0 event

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
The event name

**Since:**
1.2.0

**query-events**  (Command)
Return a list of supported \s-1QMP\s0 events by this server

**Returns:**
A list of \f(CW`EventInfo\*(C' for all supported events

**Since:**
1.2.0

**Example:**

.Vb 11
        -&gt; { "execute": "query-events" }
        &lt;- {
             "return": [
                 {
                    "name":"SHUTDOWN"
                 },
                 {
                    "name":"RESET"
                 }
              ]
           }
.Ve

**Note:**
This example has been shortened as the real response is too long.

**CpuInfoArch** (Enum)

An enumeration of cpu types that enable additional information during
\f(CW`query-cpus\*(C' and \f(CW\*(C\`query-cpus-fast\*(C'.

**Values:**
.ie n .IP """s390""" 4
.el .IP "\f(CWs390" 4
.IX Item "s390"
since 2.12
.ie n .IP """riscv""" 4
.el .IP "\f(CWriscv" 4
.IX Item "riscv"
since 2.12
.ie n .IP """x86""" 4
.el .IP "\f(CWx86" 4
.IX Item "x86"
Not documented
.ie n .IP """sparc""" 4
.el .IP "\f(CWsparc" 4
.IX Item "sparc"
Not documented
.ie n .IP """ppc""" 4
.el .IP "\f(CWppc" 4
.IX Item "ppc"
Not documented
.ie n .IP """mips""" 4
.el .IP "\f(CWmips" 4
.IX Item "mips"
Not documented
.ie n .IP """tricore""" 4
.el .IP "\f(CWtricore" 4
.IX Item "tricore"
Not documented
.ie n .IP """other""" 4
.el .IP "\f(CWother" 4
.IX Item "other"
Not documented

**Since:**
2.6

**CpuInfo** (Object)

Information about a virtual \s-1CPU\s0

**Members:**
.ie n .IP """CPU: int""" 4
.el .IP "\f(CWCPU: int" 4
.IX Item "CPU: int"
the index of the virtual \s-1CPU\s0
.ie n .IP """current: boolean""" 4
.el .IP "\f(CWcurrent: boolean" 4
.IX Item "current: boolean"
this only exists for backwards compatibility and should be ignored
.ie n .IP """halted: boolean""" 4
.el .IP "\f(CWhalted: boolean" 4
.IX Item "halted: boolean"
true if the virtual \s-1CPU\s0 is in the halt state.  Halt usually refers
to a processor specific low power mode.
.ie n .IP """qom_path: string""" 4
.el .IP "\f(CWqom_path: string" 4
.IX Item "qom_path: string"
path to the \s-1CPU\s0 object in the \s-1QOM\s0 tree (since 2.4)
.ie n .IP """thread_id: int""" 4
.el .IP "\f(CWthread_id: int" 4
.IX Item "thread_id: int"
\s-1ID\s0 of the underlying host thread
.ie n .IP """props: CpuInstanceProperties"" (optional)" 4
.el .IP "\f(CWprops: CpuInstanceProperties (optional)" 4
.IX Item "props: CpuInstanceProperties (optional)"
properties describing to which node/socket/core/thread
virtual \s-1CPU\s0 belongs to, provided if supported by board (since 2.10)
.ie n .IP """arch: CpuInfoArch""" 4
.el .IP "\f(CWarch: CpuInfoArch" 4
.IX Item "arch: CpuInfoArch"
architecture of the cpu, which determines which additional fields
will be listed (since 2.6)
.ie n .IP "The members of ""CpuInfoX86"" when ""arch"" is ""x86""" 4
.el .IP "The members of \f(CWCpuInfoX86 when \f(CWarch is \`\`x86''" 4
.IX Item "The members of CpuInfoX86 when arch is x86"
.ie n .IP "The members of ""CpuInfoSPARC"" when ""arch"" is ""sparc""" 4
.el .IP "The members of \f(CWCpuInfoSPARC when \f(CWarch is \`\`sparc''" 4
.IX Item "The members of CpuInfoSPARC when arch is sparc"
.ie n .IP "The members of ""CpuInfoPPC"" when ""arch"" is ""ppc""" 4
.el .IP "The members of \f(CWCpuInfoPPC when \f(CWarch is \`\`ppc''" 4
.IX Item "The members of CpuInfoPPC when arch is ppc"
.ie n .IP "The members of ""CpuInfoMIPS"" when ""arch"" is ""mips""" 4
.el .IP "The members of \f(CWCpuInfoMIPS when \f(CWarch is \`\`mips''" 4
.IX Item "The members of CpuInfoMIPS when arch is mips"
.ie n .IP "The members of ""CpuInfoTricore"" when ""arch"" is ""tricore""" 4
.el .IP "The members of \f(CWCpuInfoTricore when \f(CWarch is \`\`tricore''" 4
.IX Item "The members of CpuInfoTricore when arch is tricore"
.ie n .IP "The members of ""CpuInfoS390"" when ""arch"" is ""s390""" 4
.el .IP "The members of \f(CWCpuInfoS390 when \f(CWarch is \`\`s390''" 4
.IX Item "The members of CpuInfoS390 when arch is s390"
.ie n .IP "The members of ""CpuInfoRISCV"" when ""arch"" is ""riscv""" 4
.el .IP "The members of \f(CWCpuInfoRISCV when \f(CWarch is \`\`riscv''" 4
.IX Item "The members of CpuInfoRISCV when arch is riscv"

**Since:**
0.14.0

**Notes:**
\f(CW`halted\*(C' is a transient state that changes frequently.  By the time the
data is sent to the client, the guest may no longer be halted.

**CpuInfoX86** (Object)

Additional information about a virtual i386 or x86_64 \s-1CPU\s0

**Members:**
.ie n .IP """pc: int""" 4
.el .IP "\f(CWpc: int" 4
.IX Item "pc: int"
the 64-bit instruction pointer

**Since:**
2.6

**CpuInfoSPARC** (Object)

Additional information about a virtual \s-1SPARC CPU\s0

**Members:**
.ie n .IP """pc: int""" 4
.el .IP "\f(CWpc: int" 4
.IX Item "pc: int"
the \s-1PC\s0 component of the instruction pointer
.ie n .IP """npc: int""" 4
.el .IP "\f(CWnpc: int" 4
.IX Item "npc: int"
the \s-1NPC\s0 component of the instruction pointer

**Since:**
2.6

**CpuInfoPPC** (Object)

Additional information about a virtual \s-1PPC CPU\s0

**Members:**
.ie n .IP """nip: int""" 4
.el .IP "\f(CWnip: int" 4
.IX Item "nip: int"
the instruction pointer

**Since:**
2.6

**CpuInfoMIPS** (Object)

Additional information about a virtual \s-1MIPS CPU\s0

**Members:**
.ie n .IP """PC: int""" 4
.el .IP "\f(CWPC: int" 4
.IX Item "PC: int"
the instruction pointer

**Since:**
2.6

**CpuInfoTricore** (Object)

Additional information about a virtual Tricore \s-1CPU\s0

**Members:**
.ie n .IP """PC: int""" 4
.el .IP "\f(CWPC: int" 4
.IX Item "PC: int"
the instruction pointer

**Since:**
2.6

**CpuInfoRISCV** (Object)

Additional information about a virtual \s-1RISCV CPU\s0

**Members:**
.ie n .IP """pc: int""" 4
.el .IP "\f(CWpc: int" 4
.IX Item "pc: int"
the instruction pointer

Since 2.12

**CpuS390State** (Enum)

An enumeration of cpu states that can be assumed by a virtual
S390 \s-1CPU\s0

**Values:**
.ie n .IP """uninitialized""" 4
.el .IP "\f(CWuninitialized" 4
.IX Item "uninitialized"
Not documented
.ie n .IP """stopped""" 4
.el .IP "\f(CWstopped" 4
.IX Item "stopped"
Not documented
.ie n .IP """check-stop""" 4
.el .IP "\f(CWcheck-stop" 4
.IX Item "check-stop"
Not documented
.ie n .IP """operating""" 4
.el .IP "\f(CWoperating" 4
.IX Item "operating"
Not documented
.ie n .IP """load""" 4
.el .IP "\f(CWload" 4
.IX Item "load"
Not documented

**Since:**
2.12

**CpuInfoS390** (Object)

Additional information about a virtual S390 \s-1CPU\s0

**Members:**
.ie n .IP """cpu-state: CpuS390State""" 4
.el .IP "\f(CWcpu-state: CpuS390State" 4
.IX Item "cpu-state: CpuS390State"
the virtual \s-1CPU\s0's state

**Since:**
2.12

**query-cpus**  (Command)
Returns a list of information about each virtual \s-1CPU.\s0

This command causes vCPU threads to exit to userspace, which causes
a small interruption to guest \s-1CPU\s0 execution. This will have a negative
impact on realtime guests and other latency sensitive guest workloads.
It is recommended to use \f(CW`query-cpus-fast\*(C' instead of this command to
avoid the vCPU interruption.

**Returns:**
a list of \f(CW`CpuInfo\*(C' for each virtual \s-1CPU\s0

**Since:**
0.14.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-cpus" }
        &lt;- { "return": [
                 {
                    "CPU":0,
                    "current":true,
                    "halted":false,
                    "qom_path":"/machine/unattached/device[0]",
                    "arch":"x86",
                    "pc":3227107138,
                    "thread_id":3134
                 },
                 {
                    "CPU":1,
                    "current":false,
                    "halted":true,
                    "qom_path":"/machine/unattached/device[2]",
                    "arch":"x86",
                    "pc":7108165,
                    "thread_id":3135
                 }
              ]
           }
.Ve

**Notes:**
This interface is deprecated (since 2.12.0), and it is strongly
recommended that you avoid using it. Use \f(CW`query-cpus-fast\*(C' to
obtain information about virtual CPUs.

**CpuInfoFast** (Object)

Information about a virtual \s-1CPU\s0

**Members:**
.ie n .IP """cpu-index: int""" 4
.el .IP "\f(CWcpu-index: int" 4
.IX Item "cpu-index: int"
index of the virtual \s-1CPU\s0
.ie n .IP """qom-path: string""" 4
.el .IP "\f(CWqom-path: string" 4
.IX Item "qom-path: string"
path to the \s-1CPU\s0 object in the \s-1QOM\s0 tree
.ie n .IP """thread-id: int""" 4
.el .IP "\f(CWthread-id: int" 4
.IX Item "thread-id: int"
\s-1ID\s0 of the underlying host thread
.ie n .IP """props: CpuInstanceProperties"" (optional)" 4
.el .IP "\f(CWprops: CpuInstanceProperties (optional)" 4
.IX Item "props: CpuInstanceProperties (optional)"
properties describing to which node/socket/core/thread
virtual \s-1CPU\s0 belongs to, provided if supported by board
.ie n .IP """arch: CpuInfoArch""" 4
.el .IP "\f(CWarch: CpuInfoArch" 4
.IX Item "arch: CpuInfoArch"
base architecture of the cpu; deprecated since 3.0.0 in favor
of \f(CW`target\*(C'
.ie n .IP """target: SysEmuTarget""" 4
.el .IP "\f(CWtarget: SysEmuTarget" 4
.IX Item "target: SysEmuTarget"
the \s-1QEMU\s0 system emulation target, which determines which
additional fields will be listed (since 3.0)
.ie n .IP "The members of ""CpuInfoS390"" when ""target"" is ""s390x""" 4
.el .IP "The members of \f(CWCpuInfoS390 when \f(CWtarget is \`\`s390x''" 4
.IX Item "The members of CpuInfoS390 when target is s390x"

**Since:**
2.12

**query-cpus-fast**  (Command)
Returns information about all virtual CPUs. This command does not
incur a performance penalty and should be used in production
instead of query-cpus.

**Returns:**
list of \f(CW`CpuInfoFast\*(C'

**Since:**
2.12

**Example:**

.Vb 10
        -&gt; { "execute": "query-cpus-fast" }
        &lt;- { "return": [
                {
                    "thread-id": 25627,
                    "props": {
                        "core-id": 0,
                        "thread-id": 0,
                        "socket-id": 0
                    },
                    "qom-path": "/machine/unattached/device[0]",
                    "arch":"x86",
                    "target":"x86_64",
                    "cpu-index": 0
                },
                {
                    "thread-id": 25628,
                    "props": {
                        "core-id": 0,
                        "thread-id": 0,
                        "socket-id": 1
                    },
                    "qom-path": "/machine/unattached/device[2]",
                    "arch":"x86",
                    "target":"x86_64",
                    "cpu-index": 1
                }
            ]
        }
.Ve

**IOThreadInfo** (Object)

Information about an iothread

**Members:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the identifier of the iothread
.ie n .IP """thread-id: int""" 4
.el .IP "\f(CWthread-id: int" 4
.IX Item "thread-id: int"
\s-1ID\s0 of the underlying host thread
.ie n .IP """poll-max-ns: int""" 4
.el .IP "\f(CWpoll-max-ns: int" 4
.IX Item "poll-max-ns: int"
maximum polling time in ns, 0 means polling is disabled
(since 2.9)
.ie n .IP """poll-grow: int""" 4
.el .IP "\f(CWpoll-grow: int" 4
.IX Item "poll-grow: int"
how many ns will be added to polling time, 0 means that it's not
configured (since 2.9)
.ie n .IP """poll-shrink: int""" 4
.el .IP "\f(CWpoll-shrink: int" 4
.IX Item "poll-shrink: int"
how many ns will be removed from polling time, 0 means that
it's not configured (since 2.9)

**Since:**
2.0

**query-iothreads**  (Command)
Returns a list of information about each iothread.

**Note:**
this list excludes the \s-1QEMU\s0 main loop thread, which is not declared
using the -object iothread command-line option.  It is always the main thread
of the process.

**Returns:**
a list of \f(CW`IOThreadInfo\*(C' for each iothread

**Since:**
2.0

**Example:**

.Vb 12
        -&gt; { "execute": "query-iothreads" }
        &lt;- { "return": [
                 {
                    "id":"iothread0",
                    "thread-id":3134
                 },
                 {
                    "id":"iothread1",
                    "thread-id":3135
                 }
              ]
           }
.Ve

**BalloonInfo** (Object)

Information about the guest balloon device.

**Members:**
.ie n .IP """actual: int""" 4
.el .IP "\f(CWactual: int" 4
.IX Item "actual: int"
the number of bytes the balloon currently contains

**Since:**
0.14.0

**query-balloon**  (Command)
Return information about the balloon device.

**Returns:**
\f(CW`BalloonInfo\*(C' on success

If the balloon driver is enabled but not functional because the \s-1KVM\s0
kernel module cannot support it, KvmMissingCap

If no balloon device is present, DeviceNotActive

**Since:**
0.14.0

**Example:**

.Vb 5
        -&gt; { "execute": "query-balloon" }
        &lt;- { "return": {
                 "actual": 1073741824,
              }
           }
.Ve

**\s-1BALLOON\_CHANGE\s0**  (Event)
Emitted when the guest changes the actual \s-1BALLOON\s0 level. This value is
equivalent to the \f(CW`actual\*(C' field return by the 'query-balloon' command

**Arguments:**
.ie n .IP """actual: int""" 4
.el .IP "\f(CWactual: int" 4
.IX Item "actual: int"
actual level of the guest memory balloon in bytes

**Note:**
this event is rate-limited.

**Since:**
1.2

**Example:**

.Vb 3
        &lt;- { "event": "BALLOON_CHANGE",
             "data": { "actual": 944766976 },
             "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
.Ve

**PciMemoryRange** (Object)

A \s-1PCI\s0 device memory region

**Members:**
.ie n .IP """base: int""" 4
.el .IP "\f(CWbase: int" 4
.IX Item "base: int"
the starting address (guest physical)
.ie n .IP """limit: int""" 4
.el .IP "\f(CWlimit: int" 4
.IX Item "limit: int"
the ending address (guest physical)

**Since:**
0.14.0

**PciMemoryRegion** (Object)

Information about a \s-1PCI\s0 device I/O region.

**Members:**
.ie n .IP """bar: int""" 4
.el .IP "\f(CWbar: int" 4
.IX Item "bar: int"
the index of the Base Address Register for this region
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
'io' if the region is a \s-1PIO\s0 region
'memory' if the region is a \s-1MMIO\s0 region
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
memory size
.ie n .IP """prefetch: boolean"" (optional)" 4
.el .IP "\f(CWprefetch: boolean (optional)" 4
.IX Item "prefetch: boolean (optional)"
if \f(CW`type\*(C' is 'memory', true if the memory is prefetchable
.ie n .IP """mem_type_64: boolean"" (optional)" 4
.el .IP "\f(CWmem_type_64: boolean (optional)" 4
.IX Item "mem_type_64: boolean (optional)"
if \f(CW`type\*(C' is 'memory', true if the \s-1BAR\s0 is 64-bit
.ie n .IP """address: int""" 4
.el .IP "\f(CWaddress: int" 4
.IX Item "address: int"
Not documented

**Since:**
0.14.0

**PciBusInfo** (Object)

Information about a bus of a \s-1PCI\s0 Bridge device

**Members:**
.ie n .IP """number: int""" 4
.el .IP "\f(CWnumber: int" 4
.IX Item "number: int"
primary bus interface number.  This should be the number of the
bus the device resides on.
.ie n .IP """secondary: int""" 4
.el .IP "\f(CWsecondary: int" 4
.IX Item "secondary: int"
secondary bus interface number.  This is the number of the
main bus for the bridge
.ie n .IP """subordinate: int""" 4
.el .IP "\f(CWsubordinate: int" 4
.IX Item "subordinate: int"
This is the highest number bus that resides below the
bridge.
.ie n .IP """io_range: PciMemoryRange""" 4
.el .IP "\f(CWio_range: PciMemoryRange" 4
.IX Item "io_range: PciMemoryRange"
The \s-1PIO\s0 range for all devices on this bridge
.ie n .IP """memory_range: PciMemoryRange""" 4
.el .IP "\f(CWmemory_range: PciMemoryRange" 4
.IX Item "memory_range: PciMemoryRange"
The \s-1MMIO\s0 range for all devices on this bridge
.ie n .IP """prefetchable_range: PciMemoryRange""" 4
.el .IP "\f(CWprefetchable_range: PciMemoryRange" 4
.IX Item "prefetchable_range: PciMemoryRange"
The range of prefetchable \s-1MMIO\s0 for all devices on
this bridge

**Since:**
2.4

**PciBridgeInfo** (Object)

Information about a \s-1PCI\s0 Bridge device

**Members:**
.ie n .IP """bus: PciBusInfo""" 4
.el .IP "\f(CWbus: PciBusInfo" 4
.IX Item "bus: PciBusInfo"
information about the bus the device resides on
.ie n .IP """devices: array of PciDeviceInfo"" (optional)" 4
.el .IP "\f(CWdevices: array of PciDeviceInfo (optional)" 4
.IX Item "devices: array of PciDeviceInfo (optional)"
a list of \f(CW`PciDeviceInfo\*(C' for each device on this bridge

**Since:**
0.14.0

**PciDeviceClass** (Object)

Information about the Class of a \s-1PCI\s0 device

**Members:**
.ie n .IP """desc: string"" (optional)" 4
.el .IP "\f(CWdesc: string (optional)" 4
.IX Item "desc: string (optional)"
a string description of the device's class
.ie n .IP """class: int""" 4
.el .IP "\f(CWclass: int" 4
.IX Item "class: int"
the class code of the device

**Since:**
2.4

**PciDeviceId** (Object)

Information about the Id of a \s-1PCI\s0 device

**Members:**
.ie n .IP """device: int""" 4
.el .IP "\f(CWdevice: int" 4
.IX Item "device: int"
the \s-1PCI\s0 device id
.ie n .IP """vendor: int""" 4
.el .IP "\f(CWvendor: int" 4
.IX Item "vendor: int"
the \s-1PCI\s0 vendor id
.ie n .IP """subsystem: int"" (optional)" 4
.el .IP "\f(CWsubsystem: int (optional)" 4
.IX Item "subsystem: int (optional)"
the \s-1PCI\s0 subsystem id (since 3.1)
.ie n .IP """subsystem-vendor: int"" (optional)" 4
.el .IP "\f(CWsubsystem-vendor: int (optional)" 4
.IX Item "subsystem-vendor: int (optional)"
the \s-1PCI\s0 subsystem vendor id (since 3.1)

**Since:**
2.4

**PciDeviceInfo** (Object)

Information about a \s-1PCI\s0 device

**Members:**
.ie n .IP """bus: int""" 4
.el .IP "\f(CWbus: int" 4
.IX Item "bus: int"
the bus number of the device
.ie n .IP """slot: int""" 4
.el .IP "\f(CWslot: int" 4
.IX Item "slot: int"
the slot the device is located in
.ie n .IP """function: int""" 4
.el .IP "\f(CWfunction: int" 4
.IX Item "function: int"
the function of the slot used by the device
.ie n .IP """class_info: PciDeviceClass""" 4
.el .IP "\f(CWclass_info: PciDeviceClass" 4
.IX Item "class_info: PciDeviceClass"
the class of the device
.ie n .IP """id: PciDeviceId""" 4
.el .IP "\f(CWid: PciDeviceId" 4
.IX Item "id: PciDeviceId"
the \s-1PCI\s0 device id
.ie n .IP """irq: int"" (optional)" 4
.el .IP "\f(CWirq: int (optional)" 4
.IX Item "irq: int (optional)"
if an \s-1IRQ\s0 is assigned to the device, the \s-1IRQ\s0 number
.ie n .IP """qdev_id: string""" 4
.el .IP "\f(CWqdev_id: string" 4
.IX Item "qdev_id: string"
the device name of the \s-1PCI\s0 device
.ie n .IP """pci_bridge: PciBridgeInfo"" (optional)" 4
.el .IP "\f(CWpci_bridge: PciBridgeInfo (optional)" 4
.IX Item "pci_bridge: PciBridgeInfo (optional)"
if the device is a \s-1PCI\s0 bridge, the bridge information
.ie n .IP """regions: array of PciMemoryRegion""" 4
.el .IP "\f(CWregions: array of PciMemoryRegion" 4
.IX Item "regions: array of PciMemoryRegion"
a list of the \s-1PCI I/O\s0 regions associated with the device

**Notes:**
the contents of \f(CW`class\_info\*(C'.desc are not stable and should only be
treated as informational.

**Since:**
0.14.0

**PciInfo** (Object)

Information about a \s-1PCI\s0 bus

**Members:**
.ie n .IP """bus: int""" 4
.el .IP "\f(CWbus: int" 4
.IX Item "bus: int"
the bus index
.ie n .IP """devices: array of PciDeviceInfo""" 4
.el .IP "\f(CWdevices: array of PciDeviceInfo" 4
.IX Item "devices: array of PciDeviceInfo"
a list of devices on this bus

**Since:**
0.14.0

**query-pci**  (Command)
Return information about the \s-1PCI\s0 bus topology of the guest.

**Returns:**
a list of \f(CW`PciInfo\*(C' for each \s-1PCI\s0 bus. Each bus is
represented by a json-object, which has a key with a json-array of
all \s-1PCI\s0 devices attached to it. Each device is represented by a
json-object.

**Since:**
0.14.0

**Example:**

.Vb 10
        -&gt; { "execute": "query-pci" }
        &lt;- { "return": [
                 {
                    "bus": 0,
                    "devices": [
                       {
                          "bus": 0,
                          "qdev_id": "",
                          "slot": 0,
                          "class_info": {
                             "class": 1536,
                             "desc": "Host bridge"
                          },
                          "id": {
                             "device": 32902,
                             "vendor": 4663
                          },
                          "function": 0,
                          "regions": [
                          ]
                       },
                       {
                          "bus": 0,
                          "qdev_id": "",
                          "slot": 1,
                          "class_info": {
                             "class": 1537,
                             "desc": "ISA bridge"
                          },
                          "id": {
                             "device": 32902,
                             "vendor": 28672
                          },
                          "function": 0,
                          "regions": [
                          ]
                       },
                       {
                          "bus": 0,
                          "qdev_id": "",
                          "slot": 1,
                          "class_info": {
                             "class": 257,
                             "desc": "IDE controller"
                          },
                          "id": {
                             "device": 32902,
                             "vendor": 28688
                          },
                          "function": 1,
                          "regions": [
                             {
                                "bar": 4,
                                "size": 16,
                                "address": 49152,
                                "type": "io"
                             }
                          ]
                       },
                       {
                          "bus": 0,
                          "qdev_id": "",
                          "slot": 2,
                          "class_info": {
                             "class": 768,
                             "desc": "VGA controller"
                          },
                          "id": {
                             "device": 4115,
                             "vendor": 184
                          },
                          "function": 0,
                          "regions": [
                             {
                                "prefetch": true,
                                "mem_type_64": false,
                                "bar": 0,
                                "size": 33554432,
                                "address": 4026531840,
                                "type": "memory"
                             },
                             {
                                "prefetch": false,
                                "mem_type_64": false,
                                "bar": 1,
                                "size": 4096,
                                "address": 4060086272,
                                "type": "memory"
                             },
                             {
                                "prefetch": false,
                                "mem_type_64": false,
                                "bar": 6,
                                "size": 65536,
                                "address": -1,
                                "type": "memory"
                             }
                          ]
                       },
                       {
                          "bus": 0,
                          "qdev_id": "",
                          "irq": 11,
                          "slot": 4,
                          "class_info": {
                             "class": 1280,
                             "desc": "RAM controller"
                          },
                          "id": {
                             "device": 6900,
                             "vendor": 4098
                          },
                          "function": 0,
                          "regions": [
                             {
                                "bar": 0,
                                "size": 32,
                                "address": 49280,
                                "type": "io"
                             }
                          ]
                       }
                    ]
                 }
              ]
           }
.Ve

**Note:**
This example has been shortened as the real response is too long.

**quit**  (Command)
This command will cause the \s-1QEMU\s0 process to exit gracefully.  While every
attempt is made to send the \s-1QMP\s0 response before terminating, this is not
guaranteed.  When using this interface, a premature \s-1EOF\s0 would not be
unexpected.

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "quit" }
        &lt;- { "return": {} }
.Ve

**stop**  (Command)
Stop all guest \s-1VCPU\s0 execution.

**Since:**
0.14.0

**Notes:**
This function will succeed even if the guest is already in the stopped
state.  In inmigrate\*(R" state, it will ensure that the guest
remains paused once migration finishes, as if the -S option was
passed on the command line.

**Example:**

.Vb 2
        -&gt; { "execute": "stop" }
        &lt;- { "return": {} }
.Ve

**system\_reset**  (Command)
Performs a hard reset of a guest.

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "system_reset" }
        &lt;- { "return": {} }
.Ve

**system\_powerdown**  (Command)
Requests that a guest perform a powerdown operation.

**Since:**
0.14.0

**Notes:**
A guest may or may not respond to this command.  This command
returning does not indicate that a guest has accepted the request or
that it has shut down.  Many guests will respond to this command by
prompting the user in some way.

**Example:**

.Vb 2
        -&gt; { "execute": "system_powerdown" }
        &lt;- { "return": {} }
.Ve

**cpu-add**  (Command)
Adds \s-1CPU\s0 with specified \s-1ID\s0

**Arguments:**
.ie n .IP """id: int""" 4
.el .IP "\f(CWid: int" 4
.IX Item "id: int"
\s-1ID\s0 of \s-1CPU\s0 to be created, valid values [0..max_cpus)

**Returns:**
Nothing on success

**Since:**
1.5

**Example:**

.Vb 2
        -&gt; { "execute": "cpu-add", "arguments": { "id": 2 } }
        &lt;- { "return": {} }
.Ve

**memsave**  (Command)
Save a portion of guest memory to a file.

**Arguments:**
.ie n .IP """val: int""" 4
.el .IP "\f(CWval: int" 4
.IX Item "val: int"
the virtual address of the guest to start from
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
the size of memory region to save
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
the file to save the memory to as binary data
.ie n .IP """cpu-index: int"" (optional)" 4
.el .IP "\f(CWcpu-index: int (optional)" 4
.IX Item "cpu-index: int (optional)"
the index of the virtual \s-1CPU\s0 to use for translating the
virtual address (defaults to \s-1CPU 0\s0)

**Returns:**
Nothing on success

**Since:**
0.14.0

**Notes:**
Errors were not reliably returned until 1.1

**Example:**

.Vb 5
        -&gt; { "execute": "memsave",
             "arguments": { "val": 10,
                            "size": 100,
                            "filename": "/tmp/virtual-mem-dump" } }
        &lt;- { "return": {} }
.Ve

**pmemsave**  (Command)
Save a portion of guest physical memory to a file.

**Arguments:**
.ie n .IP """val: int""" 4
.el .IP "\f(CWval: int" 4
.IX Item "val: int"
the physical address of the guest to start from
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
the size of memory region to save
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
the file to save the memory to as binary data

**Returns:**
Nothing on success

**Since:**
0.14.0

**Notes:**
Errors were not reliably returned until 1.1

**Example:**

.Vb 5
        -&gt; { "execute": "pmemsave",
             "arguments": { "val": 10,
                            "size": 100,
                            "filename": "/tmp/physical-mem-dump" } }
        &lt;- { "return": {} }
.Ve

**cont**  (Command)
Resume guest \s-1VCPU\s0 execution.

**Since:**
0.14.0

**Returns:**
If successful, nothing

**Notes:**
This command will succeed if the guest is currently running.  It
will also succeed if the guest is in the inmigrate\*(R" state; in
this case, the effect of the command is to make sure the guest
starts once migration finishes, removing the effect of the -S
command line option if it was passed.

**Example:**

.Vb 2
        -&gt; { "execute": "cont" }
        &lt;- { "return": {} }
.Ve

**x-exit-preconfig**  (Command)
Exit from preconfig\*(R" state

This command makes \s-1QEMU\s0 exit the preconfig state and proceed with
\s-1VM\s0 initialization using configuration data provided on the command line
and via the \s-1QMP\s0 monitor during the preconfig state. The command is only
available during the preconfig state (i.e. when the --preconfig command
line option was in use).

Since 3.0

**Returns:**
nothing

**Example:**

.Vb 2
        -&gt; { "execute": "x-exit-preconfig" }
        &lt;- { "return": {} }
.Ve

**system\_wakeup**  (Command)
Wakeup guest from suspend.  Does nothing in case the guest isn't suspended.

**Since:**
1.1

**Returns:**
nothing.

**Example:**

.Vb 2
        -&gt; { "execute": "system_wakeup" }
        &lt;- { "return": {} }
.Ve

**inject-nmi**  (Command)
Injects a Non-Maskable Interrupt into the default \s-1CPU\s0 (x86/s390) or all CPUs (ppc64).
The command fails when the guest doesn't support injecting.

**Returns:**
If successful, nothing

**Since:**
0.14.0

**Note:**
prior to 2.1, this command was only supported for x86 and s390 VMs

**Example:**

.Vb 2
        -&gt; { "execute": "inject-nmi" }
        &lt;- { "return": {} }
.Ve

**balloon**  (Command)
Request the balloon driver to change its balloon size.

**Arguments:**
.ie n .IP """value: int""" 4
.el .IP "\f(CWvalue: int" 4
.IX Item "value: int"
the target size of the balloon in bytes

**Returns:**
Nothing on success
If the balloon driver is enabled but not functional because the \s-1KVM\s0
kernel module cannot support it, KvmMissingCap
If no balloon device is present, DeviceNotActive

**Notes:**
This command just issues a request to the guest.  When it returns,
the balloon size may not have changed.  A guest can change the balloon
size independent of this command.

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "balloon", "arguments": { "value": 536870912 } }
        &lt;- { "return": {} }
.Ve

**human-monitor-command**  (Command)
Execute a command on the human monitor and return the output.

**Arguments:**
.ie n .IP """command-line: string""" 4
.el .IP "\f(CWcommand-line: string" 4
.IX Item "command-line: string"
the command to execute in the human monitor
.ie n .IP """cpu-index: int"" (optional)" 4
.el .IP "\f(CWcpu-index: int (optional)" 4
.IX Item "cpu-index: int (optional)"
The \s-1CPU\s0 to use for commands that require an implicit \s-1CPU\s0

**Returns:**
the output of the command as a string

**Since:**
0.14.0

**Notes:**
This command only exists as a stop-gap.  Its use is highly
discouraged.  The semantics of this command are not
guaranteed: this means that command names, arguments and
responses can change or be removed at \s-1ANY\s0 time.  Applications
that rely on long term stability guarantees should \s-1NOT\s0
use this command.

Known limitations:

* ·  
  This command is stateless, this means that commands that depend
  on state information (such as getfd) might not work
* ·  
  Commands that prompt the user for data don't currently work

**Example:**

.Vb 3
        -&gt; { "execute": "human-monitor-command",
             "arguments": { "command-line": "info kvm" } }
        &lt;- { "return": "kvm support: enabled\er\en" }
.Ve

**ObjectPropertyInfo** (Object)

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the name of the property
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
the type of the property.  This will typically come in one of four
forms:
.Sp
1) A primitive type such as 'u8', 'u16', 'bool', 'str', or 'double'.
These types are mapped to the appropriate \s-1JSON\s0 type.
.Sp
2) A child type in the form 'child&lt;subtype&gt;' where subtype is a qdev
device type name.  Child properties create the composition tree.
.Sp
3) A link type in the form 'link&lt;subtype&gt;' where subtype is a qdev
device type name.  Link properties form the device model graph.
.ie n .IP """description: string"" (optional)" 4
.el .IP "\f(CWdescription: string (optional)" 4
.IX Item "description: string (optional)"
if specified, the description of the property.

**Since:**
1.2

**qom-list**  (Command)
This command will list any properties of a object given a path in the object
model.

**Arguments:**
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
the path within the object model.  See \f(CW`qom-get\*(C' for a description of
this parameter.

**Returns:**
a list of \f(CW`ObjectPropertyInfo\*(C' that describe the properties of the
object.

**Since:**
1.2

**qom-get**  (Command)
This command will get a property from a object model path and return the
value.

**Arguments:**
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
The path within the object model.  There are two forms of supported
pathsabsolute and partial paths.
.Sp
Absolute paths are derived from the root object and can follow child&lt;&gt;
or link&lt;&gt; properties.  Since they can follow link&lt;&gt; properties, they
can be arbitrarily long.  Absolute paths look like absolute filenames
and are prefixed  with a leading slash.
.Sp
Partial paths look like relative filenames.  They do not begin
with a prefix.  The matching rules for partial paths are subtle but
designed to make specifying objects easy.  At each level of the
composition tree, the partial path is matched as an absolute path.
The first match is not returned.  At least two matches are searched
for.  A successful result is only returned if only one match is
found.  If more than one match is found, a flag is return to
indicate that the match was ambiguous.
.ie n .IP """property: string""" 4
.el .IP "\f(CWproperty: string" 4
.IX Item "property: string"
The property name to read

**Returns:**
The property value.  The type depends on the property
type. child&lt;&gt; and link&lt;&gt; properties are returned as #str
pathnames.  All integer property types (u8, u16, etc) are
returned as #int.

**Since:**
1.2

**qom-set**  (Command)
This command will set a property from a object model path.

**Arguments:**
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
see \f(CW`qom-get\*(C' for a description of this parameter
.ie n .IP """property: string""" 4
.el .IP "\f(CWproperty: string" 4
.IX Item "property: string"
the property name to set
.ie n .IP """value: value""" 4
.el .IP "\f(CWvalue: value" 4
.IX Item "value: value"
a value who's type is appropriate for the property type.  See \f(CW`qom-get\*(C'
for a description of type mapping.

**Since:**
1.2

**change**  (Command)
This command is multiple commands multiplexed together.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
This is normally the name of a block device but it may also be 'vnc'.
when it's 'vnc', then sub command depends on \f(CW`target\*(C'
.ie n .IP """target: string""" 4
.el .IP "\f(CWtarget: string" 4
.IX Item "target: string"
If \f(CW`device\*(C' is a block device, then this is the new filename.
If \f(CW`device\*(C' is 'vnc', then if the value 'password' selects the vnc
change password command.   Otherwise, this specifies a new server \s-1URI\s0
address to listen to for \s-1VNC\s0 connections.
.ie n .IP """arg: string"" (optional)" 4
.el .IP "\f(CWarg: string (optional)" 4
.IX Item "arg: string (optional)"
If \f(CW`device\*(C' is a block device, then this is an optional format to open
the device with.
If \f(CW`device\*(C' is 'vnc' and \f(CW\*(C\`target\*(C' is 'password', this is the new \s-1VNC\s0
password to set.  See change-vnc-password for additional notes.

**Returns:**
Nothing on success.
If \f(CW`device\*(C' is not a valid block device, DeviceNotFound

**Notes:**
This interface is deprecated, and it is strongly recommended that you
avoid using it.  For changing block devices, use
blockdev-change-medium; for changing \s-1VNC\s0 parameters, use
change-vnc-password.

**Since:**
0.14.0

**Example:**

.Vb 1
        1. Change a removable medium
        
        -&gt; { "execute": "change",
             "arguments": { "device": "ide1-cd0",
                            "target": "/srv/images/Fedora-12-x86_64-DVD.iso" } }
        &lt;- { "return": {} }
        
        2. Change VNC password
        
        -&gt; { "execute": "change",
             "arguments": { "device": "vnc", "target": "password",
                            "arg": "foobar1" } }
        &lt;- { "return": {} }
.Ve

**ObjectTypeInfo** (Object)

This structure describes a search result from \f(CW`qom-list-types\*(C'

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the type name found in the search
.ie n .IP """abstract: boolean"" (optional)" 4
.el .IP "\f(CWabstract: boolean (optional)" 4
.IX Item "abstract: boolean (optional)"
the type is abstract and can't be directly instantiated.
Omitted if false. (since 2.10)
.ie n .IP """parent: string"" (optional)" 4
.el .IP "\f(CWparent: string (optional)" 4
.IX Item "parent: string (optional)"
Name of parent type, if any (since 2.10)

**Since:**
1.1

**qom-list-types**  (Command)
This command will return a list of types given search parameters

**Arguments:**
.ie n .IP """implements: string"" (optional)" 4
.el .IP "\f(CWimplements: string (optional)" 4
.IX Item "implements: string (optional)"
if specified, only return types that implement this type name
.ie n .IP """abstract: boolean"" (optional)" 4
.el .IP "\f(CWabstract: boolean (optional)" 4
.IX Item "abstract: boolean (optional)"
if true, include abstract types in the results

**Returns:**
a list of \f(CW`ObjectTypeInfo\*(C' or an empty list if no results are found

**Since:**
1.1

**device-list-properties**  (Command)
List properties associated with a device.

**Arguments:**
.ie n .IP """typename: string""" 4
.el .IP "\f(CWtypename: string" 4
.IX Item "typename: string"
the type name of a device

**Returns:**
a list of ObjectPropertyInfo describing a devices properties

**Note:**
objects can create properties at runtime, for example to describe
links between different devices and/or objects. These properties
are not included in the output of this command.

**Since:**
1.2

**qom-list-properties**  (Command)
List properties associated with a \s-1QOM\s0 object.

**Arguments:**
.ie n .IP """typename: string""" 4
.el .IP "\f(CWtypename: string" 4
.IX Item "typename: string"
the type name of an object

**Note:**
objects can create properties at runtime, for example to describe
links between different devices and/or objects. These properties
are not included in the output of this command.

**Returns:**
a list of ObjectPropertyInfo describing object properties

**Since:**
2.12

**xen-set-global-dirty-log**  (Command)
Enable or disable the global dirty log mode.

**Arguments:**
.ie n .IP """enable: boolean""" 4
.el .IP "\f(CWenable: boolean" 4
.IX Item "enable: boolean"
true to enable, false to disable.

**Returns:**
nothing

**Since:**
1.3

**Example:**

.Vb 3
        -&gt; { "execute": "xen-set-global-dirty-log",
             "arguments": { "enable": true } }
        &lt;- { "return": {} }
.Ve

**device\_add**  (Command)

**Arguments:**
.ie n .IP """driver: string""" 4
.el .IP "\f(CWdriver: string" 4
.IX Item "driver: string"
the name of the new device's driver
.ie n .IP """bus: string"" (optional)" 4
.el .IP "\f(CWbus: string (optional)" 4
.IX Item "bus: string (optional)"
the device's parent bus (device tree path)
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
the device's \s-1ID,\s0 must be unique

Additional arguments depend on the type.

Add a device.

**Notes:**

* 1.  
  For detailed information about this command, please refer to the
  'docs/qdev-device-use.txt' file.
* 2.  
  It's possible to list device properties by running \s-1QEMU\s0 with the
  -device \s-1DEVICE\s0,help\*(R" command-line argument, where \s-1DEVICE\s0 is the
  device's name

**Example:**

.Vb 5
        -&gt; { "execute": "device_add",
             "arguments": { "driver": "e1000", "id": "net1",
                            "bus": "pci.0",
                            "mac": "52:54:00:12:34:56" } }
        &lt;- { "return": {} }
.Ve

**\s-1TODO:\s0**
This command effectively bypasses \s-1QAPI\s0 completely due to its
additional arguments\*(R" business.  It shouldn't have been added to
the schema in this form.  It should be qapified properly, or
replaced by a properly qapified command.

**Since:**
0.13

**device\_del**  (Command)
Remove a device from a guest

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the device's \s-1ID\s0 or \s-1QOM\s0 path

**Returns:**
Nothing on success
If \f(CW`id\*(C' is not a valid device, DeviceNotFound

**Notes:**
When this command completes, the device may not be removed from the
guest.  Hot removal is an operation that requires guest cooperation.
This command merely requests that the guest begin the hot removal
process.  Completion of the device removal process is signaled with a
\s-1DEVICE_DELETED\s0 event. Guest reset will automatically complete removal
for all devices.

**Since:**
0.14.0

**Example:**

.Vb 3
        -&gt; { "execute": "device_del",
             "arguments": { "id": "net1" } }
        &lt;- { "return": {} }
        
        -&gt; { "execute": "device_del",
             "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
        &lt;- { "return": {} }
.Ve

**\s-1DEVICE\_DELETED\s0**  (Event)
Emitted whenever the device removal completion is acknowledged by the guest.
At this point, it's safe to reuse the specified device \s-1ID.\s0 Device removal can
be initiated by the guest or by \s-1HMP/QMP\s0 commands.

**Arguments:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
device name
.ie n .IP """path: string""" 4
.el .IP "\f(CWpath: string" 4
.IX Item "path: string"
device path

**Since:**
1.5

**Example:**

.Vb 4
        &lt;- { "event": "DEVICE_DELETED",
             "data": { "device": "virtio-net-pci-0",
                       "path": "/machine/peripheral/virtio-net-pci-0" },
             "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
.Ve

**DumpGuestMemoryFormat** (Enum)

An enumeration of guest-memory-dump's format.

**Values:**
.ie n .IP """elf""" 4
.el .IP "\f(CWelf" 4
.IX Item "elf"
elf format
.ie n .IP """kdump-zlib""" 4
.el .IP "\f(CWkdump-zlib" 4
.IX Item "kdump-zlib"
kdump-compressed format with zlib-compressed
.ie n .IP """kdump-lzo""" 4
.el .IP "\f(CWkdump-lzo" 4
.IX Item "kdump-lzo"
kdump-compressed format with lzo-compressed
.ie n .IP """kdump-snappy""" 4
.el .IP "\f(CWkdump-snappy" 4
.IX Item "kdump-snappy"
kdump-compressed format with snappy-compressed
.ie n .IP """win-dmp""" 4
.el .IP "\f(CWwin-dmp" 4
.IX Item "win-dmp"
Windows full crashdump format,
can be used instead of \s-1ELF\s0 converting (since 2.13)

**Since:**
2.0

**dump-guest-memory**  (Command)
Dump guest's memory to vmcore. It is a synchronous operation that can take
very long depending on the amount of guest memory.

**Arguments:**
.ie n .IP """paging: boolean""" 4
.el .IP "\f(CWpaging: boolean" 4
.IX Item "paging: boolean"
if true, do paging to get guest's memory mapping. This allows
using gdb to process the core file.
.Sp
\s-1IMPORTANT:\s0 this option can make \s-1QEMU\s0 allocate several gigabytes
of \s-1RAM.\s0 This can happen for a large guest, or a
malicious guest pretending to be large.
.Sp
Also, paging=true has the following limitations:

* 1.  
  The guest may be in a catastrophic state or can have corrupted
  memory, which cannot be trusted
* 2.  
  The guest can be in real-mode even if paging is enabled. For
  example, the guest uses \s-1ACPI\s0 to sleep, and \s-1ACPI\s0 sleep state
  goes in real-mode
* 3.  
  Currently only supported on i386 and x86_64.
.ie n .IP """protocol: string""" 4
.el .IP "\f(CWprotocol: string" 4
.IX Item "protocol: string"
the filename or file descriptor of the vmcore. The supported
protocols are:

* 1.  
  file: the protocol starts with file:\*(R", and the following
  string is the file's path.
* 2.  
  fd: the protocol starts with fd:\*(R", and the following string
  is the fd's name.
.ie n .IP """detach: boolean"" (optional)" 4
.el .IP "\f(CWdetach: boolean (optional)" 4
.IX Item "detach: boolean (optional)"
if true, \s-1QMP\s0 will return immediately rather than
waiting for the dump to finish. The user can track progress
using query-dump\*(R". (since 2.6).
.ie n .IP """begin: int"" (optional)" 4
.el .IP "\f(CWbegin: int (optional)" 4
.IX Item "begin: int (optional)"
if specified, the starting physical address.
.ie n .IP """length: int"" (optional)" 4
.el .IP "\f(CWlength: int (optional)" 4
.IX Item "length: int (optional)"
if specified, the memory size, in bytes. If you don't
want to dump all guest's memory, please specify the start \f(CW`begin\*(C'
and \f(CW`length\*(C'
.ie n .IP """format: DumpGuestMemoryFormat"" (optional)" 4
.el .IP "\f(CWformat: DumpGuestMemoryFormat (optional)" 4
.IX Item "format: DumpGuestMemoryFormat (optional)"
if specified, the format of guest memory dump. But non-elf
format is conflict with paging and filter, ie. \f(CW`paging\*(C', \f(CW\*(C\`begin\*(C' and
\f(CW`length\*(C' is not allowed to be specified with non-elf \f(CW\*(C\`format\*(C' at the
same time (since 2.0)

**Note:**
All boolean arguments default to false

**Returns:**
nothing on success

**Since:**
1.2

**Example:**

.Vb 3
        -&gt; { "execute": "dump-guest-memory",
             "arguments": { "protocol": "fd:dump" } }
        &lt;- { "return": {} }
.Ve

**DumpStatus** (Enum)

Describe the status of a long-running background guest memory dump.

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
no dump-guest-memory has started yet.
.ie n .IP """active""" 4
.el .IP "\f(CWactive" 4
.IX Item "active"
there is one dump running in background.
.ie n .IP """completed""" 4
.el .IP "\f(CWcompleted" 4
.IX Item "completed"
the last dump has finished successfully.
.ie n .IP """failed""" 4
.el .IP "\f(CWfailed" 4
.IX Item "failed"
the last dump has failed.

**Since:**
2.6

**DumpQueryResult** (Object)

The result format for 'query-dump'.

**Members:**
.ie n .IP """status: DumpStatus""" 4
.el .IP "\f(CWstatus: DumpStatus" 4
.IX Item "status: DumpStatus"
enum of \f(CW`DumpStatus\*(C', which shows current dump status
.ie n .IP """completed: int""" 4
.el .IP "\f(CWcompleted: int" 4
.IX Item "completed: int"
bytes written in latest dump (uncompressed)
.ie n .IP """total: int""" 4
.el .IP "\f(CWtotal: int" 4
.IX Item "total: int"
total bytes to be written in latest dump (uncompressed)

**Since:**
2.6

**query-dump**  (Command)
Query latest dump status.

**Returns:**
A \f(CW`DumpStatus\*(C' object showing the dump status.

**Since:**
2.6

**Example:**

.Vb 3
        -&gt; { "execute": "query-dump" }
        &lt;- { "return": { "status": "active", "completed": 1024000,
                         "total": 2048000 } }
.Ve

**\s-1DUMP\_COMPLETED\s0**  (Event)
Emitted when background dump has completed

**Arguments:**
.ie n .IP """result: DumpQueryResult""" 4
.el .IP "\f(CWresult: DumpQueryResult" 4
.IX Item "result: DumpQueryResult"
final dump status
.ie n .IP """error: string"" (optional)" 4
.el .IP "\f(CWerror: string (optional)" 4
.IX Item "error: string (optional)"
human-readable error string that provides
hint on why dump failed. Only presents on failure. The
user should not try to interpret the error string.

**Since:**
2.6

**Example:**

.Vb 3
        { "event": "DUMP_COMPLETED",
          "data": {"result": {"total": 1090650112, "status": "completed",
                              "completed": 1090650112} } }
.Ve

**DumpGuestMemoryCapability** (Object)

A list of the available formats for dump-guest-memory

**Members:**
.ie n .IP """formats: array of DumpGuestMemoryFormat""" 4
.el .IP "\f(CWformats: array of DumpGuestMemoryFormat" 4
.IX Item "formats: array of DumpGuestMemoryFormat"
Not documented

**Since:**
2.0

**query-dump-guest-memory-capability**  (Command)
Returns the available formats for dump-guest-memory

**Returns:**
A \f(CW`DumpGuestMemoryCapability\*(C' object listing available formats for
dump-guest-memory

**Since:**
2.0

**Example:**

.Vb 3
        -&gt; { "execute": "query-dump-guest-memory-capability" }
        &lt;- { "return": { "formats":
                         ["elf", "kdump-zlib", "kdump-lzo", "kdump-snappy"] }
.Ve

**dump-skeys**  (Command)
Dump guest's storage keys

**Arguments:**
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
the path to the file to dump to

This command is only supported on s390 architecture.

**Since:**
2.5

**Example:**

.Vb 3
        -&gt; { "execute": "dump-skeys",
             "arguments": { "filename": "/tmp/skeys" } }
        &lt;- { "return": {} }
.Ve

**object-add**  (Command)
Create a \s-1QOM\s0 object.

**Arguments:**
.ie n .IP """qom-type: string""" 4
.el .IP "\f(CWqom-type: string" 4
.IX Item "qom-type: string"
the class name for the object to be created
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the name of the new object
.ie n .IP """props: value"" (optional)" 4
.el .IP "\f(CWprops: value (optional)" 4
.IX Item "props: value (optional)"
a dictionary of properties to be passed to the backend

**Returns:**
Nothing on success
Error if \f(CW`qom-type\*(C' is not a valid class name

**Since:**
2.0

**Example:**

.Vb 4
        -&gt; { "execute": "object-add",
             "arguments": { "qom-type": "rng-random", "id": "rng1",
                            "props": { "filename": "/dev/hwrng" } } }
        &lt;- { "return": {} }
.Ve

**object-del**  (Command)
Remove a \s-1QOM\s0 object.

**Arguments:**
.ie n .IP """id: string""" 4
.el .IP "\f(CWid: string" 4
.IX Item "id: string"
the name of the \s-1QOM\s0 object to remove

**Returns:**
Nothing on success
Error if \f(CW`id\*(C' is not a valid id for a \s-1QOM\s0 object

**Since:**
2.0

**Example:**

.Vb 2
        -&gt; { "execute": "object-del", "arguments": { "id": "rng1" } }
        &lt;- { "return": {} }
.Ve

**getfd**  (Command)
Receive a file descriptor via \s-1SCM\s0 rights and assign it a name

**Arguments:**
.ie n .IP """fdname: string""" 4
.el .IP "\f(CWfdname: string" 4
.IX Item "fdname: string"
file descriptor name

**Returns:**
Nothing on success

**Since:**
0.14.0

**Notes:**
If \f(CW`fdname\*(C' already exists, the file descriptor assigned to
it will be closed and replaced by the received file
descriptor.

The 'closefd' command can be used to explicitly close the
file descriptor when it is no longer needed.

**Example:**

.Vb 2
        -&gt; { "execute": "getfd", "arguments": { "fdname": "fd1" } }
        &lt;- { "return": {} }
.Ve

**closefd**  (Command)
Close a file descriptor previously passed via \s-1SCM\s0 rights

**Arguments:**
.ie n .IP """fdname: string""" 4
.el .IP "\f(CWfdname: string" 4
.IX Item "fdname: string"
file descriptor name

**Returns:**
Nothing on success

**Since:**
0.14.0

**Example:**

.Vb 2
        -&gt; { "execute": "closefd", "arguments": { "fdname": "fd1" } }
        &lt;- { "return": {} }
.Ve

**MachineInfo** (Object)

Information describing a machine.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the name of the machine
.ie n .IP """alias: string"" (optional)" 4
.el .IP "\f(CWalias: string (optional)" 4
.IX Item "alias: string (optional)"
an alias for the machine name
.ie n .IP """is-default: boolean"" (optional)" 4
.el .IP "\f(CWis-default: boolean (optional)" 4
.IX Item "is-default: boolean (optional)"
whether the machine is default
.ie n .IP """cpu-max: int""" 4
.el .IP "\f(CWcpu-max: int" 4
.IX Item "cpu-max: int"
maximum number of CPUs supported by the machine type
(since 1.5.0)
.ie n .IP """hotpluggable-cpus: boolean""" 4
.el .IP "\f(CWhotpluggable-cpus: boolean" 4
.IX Item "hotpluggable-cpus: boolean"
cpu hotplug via -device is supported (since 2.7.0)

**Since:**
1.2.0

**query-machines**  (Command)
Return a list of supported machines

**Returns:**
a list of MachineInfo

**Since:**
1.2.0

**CpuDefinitionInfo** (Object)

Virtual \s-1CPU\s0 definition.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the name of the \s-1CPU\s0 definition
.ie n .IP """migration-safe: boolean"" (optional)" 4
.el .IP "\f(CWmigration-safe: boolean (optional)" 4
.IX Item "migration-safe: boolean (optional)"
whether a \s-1CPU\s0 definition can be safely used for
migration in combination with a \s-1QEMU\s0 compatibility machine
when migrating between different \s-1QEMU\s0 versions and between
hosts with different sets of (hardware or software)
capabilities. If not provided, information is not available
and callers should not assume the \s-1CPU\s0 definition to be
migration-safe. (since 2.8)
.ie n .IP """static: boolean""" 4
.el .IP "\f(CWstatic: boolean" 4
.IX Item "static: boolean"
whether a \s-1CPU\s0 definition is static and will not change depending on
\s-1QEMU\s0 version, machine type, machine options and accelerator options.
A static model is always migration-safe. (since 2.8)
.ie n .IP """unavailable-features: array of string"" (optional)" 4
.el .IP "\f(CWunavailable-features: array of string (optional)" 4
.IX Item "unavailable-features: array of string (optional)"
List of properties that prevent
the \s-1CPU\s0 model from running in the current
host. (since 2.8)
.ie n .IP """typename: string""" 4
.el .IP "\f(CWtypename: string" 4
.IX Item "typename: string"
Type name that can be used as argument to \f(CW`device-list-properties\*(C',
to introspect properties configurable using -cpu or -global.
(since 2.9)

\f(CW`unavailable-features\*(C' is a list of \s-1QOM\s0 property names that
represent \s-1CPU\s0 model attributes that prevent the \s-1CPU\s0 from running.
If the \s-1QOM\s0 property is read-only, that means there's no known
way to make the \s-1CPU\s0 model run in the current host. Implementations
that choose not to provide specific information return the
property name type\*(R".
If the property is read-write, it means that it \s-1MAY\s0 be possible
to run the \s-1CPU\s0 model in the current host if that property is
changed. Management software can use it as hints to suggest or
choose an alternative for the user, or just to generate meaningful
error messages explaining why the \s-1CPU\s0 model can't be used.
If \f(CW`unavailable-features\*(C' is an empty list, the \s-1CPU\s0 model is
runnable using the current host and machine-type.
If \f(CW`unavailable-features\*(C' is not present, runnability
information for the \s-1CPU\s0 is not available.

**Since:**
1.2.0

**MemoryInfo** (Object)

Actual memory information in bytes.

**Members:**
.ie n .IP """base-memory: int""" 4
.el .IP "\f(CWbase-memory: int" 4
.IX Item "base-memory: int"
size of base\*(R" memory specified with command line
option -m.
.ie n .IP """plugged-memory: int"" (optional)" 4
.el .IP "\f(CWplugged-memory: int (optional)" 4
.IX Item "plugged-memory: int (optional)"
size of memory that can be hot-unplugged. This field
is omitted if target doesn't support memory hotplug
(i.e. \s-1CONFIG_MEM_DEVICE\s0 not defined at build time).

**Since:**
2.11.0

**query-memory-size-summary**  (Command)
Return the amount of initially allocated and present hotpluggable (if
enabled) memory in bytes.

**Example:**

.Vb 2
        -&gt; { "execute": "query-memory-size-summary" }
        &lt;- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
.Ve

**Since:**
2.11.0

**query-cpu-definitions**  (Command)
Return a list of supported virtual \s-1CPU\s0 definitions

**Returns:**
a list of CpuDefInfo

**Since:**
1.2.0

**CpuModelInfo** (Object)

Virtual \s-1CPU\s0 model.

A \s-1CPU\s0 model consists of the name of a \s-1CPU\s0 definition, to which
delta changes are applied (e.g. features added/removed). Most magic values
that an architecture might require should be hidden behind the name.
However, if required, architectures can expose relevant properties.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
the name of the \s-1CPU\s0 definition the model is based on
.ie n .IP """props: value"" (optional)" 4
.el .IP "\f(CWprops: value (optional)" 4
.IX Item "props: value (optional)"
a dictionary of \s-1QOM\s0 properties to be applied

**Since:**
2.8.0

**CpuModelExpansionType** (Enum)

An enumeration of \s-1CPU\s0 model expansion types.

**Values:**
.ie n .IP """static""" 4
.el .IP "\f(CWstatic" 4
.IX Item "static"
Expand to a static \s-1CPU\s0 model, a combination of a static base
model name and property delta changes. As the static base model will
never change, the expanded \s-1CPU\s0 model will be the same, independent of
\s-1QEMU\s0 version, machine type, machine options, and accelerator options.
Therefore, the resulting model can be used by tooling without having
to specify a compatibility machine - e.g. when displaying the host\*(R"
model. The \f(CW`static\*(C' \s-1CPU\s0 models are migration-safe.
.ie n .IP """full""" 4
.el .IP "\f(CWfull" 4
.IX Item "full"
Expand all properties. The produced model is not guaranteed to be
migration-safe, but allows tooling to get an insight and work with
model details.

**Note:**
When a non-migration-safe \s-1CPU\s0 model is expanded in static mode, some
features enabled by the \s-1CPU\s0 model may be omitted, because they can't be
implemented by a static \s-1CPU\s0 model definition (e.g. cache info passthrough and
\s-1PMU\s0 passthrough in x86). If you need an accurate representation of the
features enabled by a non-migration-safe \s-1CPU\s0 model, use \f(CW`full\*(C'. If you need a
static representation that will keep \s-1ABI\s0 compatibility even when changing \s-1QEMU\s0
version or machine-type, use \f(CW`static\*(C' (but keep in mind that some features may
be omitted).

**Since:**
2.8.0

**CpuModelExpansionInfo** (Object)

The result of a cpu model expansion.

**Members:**
.ie n .IP """model: CpuModelInfo""" 4
.el .IP "\f(CWmodel: CpuModelInfo" 4
.IX Item "model: CpuModelInfo"
the expanded CpuModelInfo.

**Since:**
2.8.0

**query-cpu-model-expansion**  (Command)
Expands a given \s-1CPU\s0 model (or a combination of \s-1CPU\s0 model + additional options)
to different granularities, allowing tooling to get an understanding what a
specific \s-1CPU\s0 model looks like in \s-1QEMU\s0 under a certain configuration.

This interface can be used to query the host\*(R" \s-1CPU\s0 model.

The data returned by this command may be affected by:

* ·  
  \s-1QEMU\s0 version: \s-1CPU\s0 models may look different depending on the \s-1QEMU\s0 version.
  (Except for \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  machine-type: \s-1CPU\s0 model  may look different depending on the machine-type.
  (Except for \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  machine options (including accelerator): in some architectures, \s-1CPU\s0 models
  may look different depending on machine and accelerator options. (Except for
  \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  -cpu\*(R" arguments and global properties: arguments to the -cpu option and
  global properties may affect expansion of \s-1CPU\s0 models. Using
  query-cpu-model-expansion while using these is not advised.

Some architectures may not support all expansion types. s390x supports
full\*(R" and \*(L"static\*(R".

**Arguments:**
.ie n .IP """type: CpuModelExpansionType""" 4
.el .IP "\f(CWtype: CpuModelExpansionType" 4
.IX Item "type: CpuModelExpansionType"
Not documented
.ie n .IP """model: CpuModelInfo""" 4
.el .IP "\f(CWmodel: CpuModelInfo" 4
.IX Item "model: CpuModelInfo"
Not documented

**Returns:**
a CpuModelExpansionInfo. Returns an error if expanding \s-1CPU\s0 models is
not supported, if the model cannot be expanded, if the model contains
an unknown \s-1CPU\s0 definition name, unknown properties or properties
with a wrong type. Also returns an error if an expansion type is
not supported.

**Since:**
2.8.0

**CpuModelCompareResult** (Enum)

An enumeration of \s-1CPU\s0 model comparison results. The result is usually
calculated using e.g. \s-1CPU\s0 features or \s-1CPU\s0 generations.

**Values:**
.ie n .IP """incompatible""" 4
.el .IP "\f(CWincompatible" 4
.IX Item "incompatible"
If model A is incompatible to model B, model A is not
guaranteed to run where model B runs and the other way around.
.ie n .IP """identical""" 4
.el .IP "\f(CWidentical" 4
.IX Item "identical"
If model A is identical to model B, model A is guaranteed to run
where model B runs and the other way around.
.ie n .IP """superset""" 4
.el .IP "\f(CWsuperset" 4
.IX Item "superset"
If model A is a superset of model B, model B is guaranteed to run
where model A runs. There are no guarantees about the other way.
.ie n .IP """subset""" 4
.el .IP "\f(CWsubset" 4
.IX Item "subset"
If model A is a subset of model B, model A is guaranteed to run
where model B runs. There are no guarantees about the other way.

**Since:**
2.8.0

**CpuModelCompareInfo** (Object)

The result of a \s-1CPU\s0 model comparison.

**Members:**
.ie n .IP """result: CpuModelCompareResult""" 4
.el .IP "\f(CWresult: CpuModelCompareResult" 4
.IX Item "result: CpuModelCompareResult"
The result of the compare operation.
.ie n .IP """responsible-properties: array of string""" 4
.el .IP "\f(CWresponsible-properties: array of string" 4
.IX Item "responsible-properties: array of string"
List of properties that led to the comparison result
not being identical.

\f(CW`responsible-properties\*(C' is a list of \s-1QOM\s0 property names that led to
both CPUs not being detected as identical. For identical models, this
list is empty.
If a \s-1QOM\s0 property is read-only, that means there's no known way to make the
\s-1CPU\s0 models identical. If the special property name type\*(R" is included, the
models are by definition not identical and cannot be made identical.

**Since:**
2.8.0

**query-cpu-model-comparison**  (Command)
Compares two \s-1CPU\s0 models, returning how they compare in a specific
configuration. The results indicates how both models compare regarding
runnability. This result can be used by tooling to make decisions if a
certain \s-1CPU\s0 model will run in a certain configuration or if a compatible
\s-1CPU\s0 model has to be created by baselining.

Usually, a \s-1CPU\s0 model is compared against the maximum possible \s-1CPU\s0 model
of a certain configuration (e.g. the host\*(R" model for \s-1KVM\s0). If that \s-1CPU\s0
model is identical or a subset, it will run in that configuration.

The result returned by this command may be affected by:

* ·  
  \s-1QEMU\s0 version: \s-1CPU\s0 models may look different depending on the \s-1QEMU\s0 version.
  (Except for \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  machine-type: \s-1CPU\s0 model may look different depending on the machine-type.
  (Except for \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  machine options (including accelerator): in some architectures, \s-1CPU\s0 models
  may look different depending on machine and accelerator options. (Except for
  \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  -cpu\*(R" arguments and global properties: arguments to the -cpu option and
  global properties may affect expansion of \s-1CPU\s0 models. Using
  query-cpu-model-expansion while using these is not advised.

Some architectures may not support comparing \s-1CPU\s0 models. s390x supports
comparing \s-1CPU\s0 models.

**Arguments:**
.ie n .IP """modela: CpuModelInfo""" 4
.el .IP "\f(CWmodela: CpuModelInfo" 4
.IX Item "modela: CpuModelInfo"
Not documented
.ie n .IP """modelb: CpuModelInfo""" 4
.el .IP "\f(CWmodelb: CpuModelInfo" 4
.IX Item "modelb: CpuModelInfo"
Not documented

**Returns:**
a CpuModelBaselineInfo. Returns an error if comparing \s-1CPU\s0 models is
not supported, if a model cannot be used, if a model contains
an unknown cpu definition name, unknown properties or properties
with wrong types.

**Since:**
2.8.0

**CpuModelBaselineInfo** (Object)

The result of a \s-1CPU\s0 model baseline.

**Members:**
.ie n .IP """model: CpuModelInfo""" 4
.el .IP "\f(CWmodel: CpuModelInfo" 4
.IX Item "model: CpuModelInfo"
the baselined CpuModelInfo.

**Since:**
2.8.0

**query-cpu-model-baseline**  (Command)
Baseline two \s-1CPU\s0 models, creating a compatible third model. The created
model will always be a static, migration-safe \s-1CPU\s0 model (see static\*(R"
\s-1CPU\s0 model expansion for details).

This interface can be used by tooling to create a compatible \s-1CPU\s0 model out
two \s-1CPU\s0 models. The created \s-1CPU\s0 model will be identical to or a subset of
both \s-1CPU\s0 models when comparing them. Therefore, the created \s-1CPU\s0 model is
guaranteed to run where the given \s-1CPU\s0 models run.

The result returned by this command may be affected by:

* ·  
  \s-1QEMU\s0 version: \s-1CPU\s0 models may look different depending on the \s-1QEMU\s0 version.
  (Except for \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  machine-type: \s-1CPU\s0 model may look different depending on the machine-type.
  (Except for \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  machine options (including accelerator): in some architectures, \s-1CPU\s0 models
  may look different depending on machine and accelerator options. (Except for
  \s-1CPU\s0 models reported as static\*(R" in query-cpu-definitions.)
* ·  
  -cpu\*(R" arguments and global properties: arguments to the -cpu option and
  global properties may affect expansion of \s-1CPU\s0 models. Using
  query-cpu-model-expansion while using these is not advised.

Some architectures may not support baselining \s-1CPU\s0 models. s390x supports
baselining \s-1CPU\s0 models.

**Arguments:**
.ie n .IP """modela: CpuModelInfo""" 4
.el .IP "\f(CWmodela: CpuModelInfo" 4
.IX Item "modela: CpuModelInfo"
Not documented
.ie n .IP """modelb: CpuModelInfo""" 4
.el .IP "\f(CWmodelb: CpuModelInfo" 4
.IX Item "modelb: CpuModelInfo"
Not documented

**Returns:**
a CpuModelBaselineInfo. Returns an error if baselining \s-1CPU\s0 models is
not supported, if a model cannot be used, if a model contains
an unknown cpu definition name, unknown properties or properties
with wrong types.

**Since:**
2.8.0

**AddfdInfo** (Object)

Information about a file descriptor that was added to an fd set.

**Members:**
.ie n .IP """fdset-id: int""" 4
.el .IP "\f(CWfdset-id: int" 4
.IX Item "fdset-id: int"
The \s-1ID\s0 of the fd set that \f(CW`fd\*(C' was added to.
.ie n .IP """fd: int""" 4
.el .IP "\f(CWfd: int" 4
.IX Item "fd: int"
The file descriptor that was received via \s-1SCM\s0 rights and
added to the fd set.

**Since:**
1.2.0

**add-fd**  (Command)
Add a file descriptor, that was passed via \s-1SCM\s0 rights, to an fd set.

**Arguments:**
.ie n .IP """fdset-id: int"" (optional)" 4
.el .IP "\f(CWfdset-id: int (optional)" 4
.IX Item "fdset-id: int (optional)"
The \s-1ID\s0 of the fd set to add the file descriptor to.
.ie n .IP """opaque: string"" (optional)" 4
.el .IP "\f(CWopaque: string (optional)" 4
.IX Item "opaque: string (optional)"
A free-form string that can be used to describe the fd.

**Returns:**
\f(CW`AddfdInfo\*(C' on success

If file descriptor was not received, FdNotSupplied

If \f(CW`fdset-id\*(C' is a negative value, InvalidParameterValue

**Notes:**
The list of fd sets is shared by all monitor connections.

If \f(CW`fdset-id\*(C' is not specified, a new fd set will be created.

**Since:**
1.2.0

**Example:**

.Vb 2
        -&gt; { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
        &lt;- { "return": { "fdset-id": 1, "fd": 3 } }
.Ve

**remove-fd**  (Command)
Remove a file descriptor from an fd set.

**Arguments:**
.ie n .IP """fdset-id: int""" 4
.el .IP "\f(CWfdset-id: int" 4
.IX Item "fdset-id: int"
The \s-1ID\s0 of the fd set that the file descriptor belongs to.
.ie n .IP """fd: int"" (optional)" 4
.el .IP "\f(CWfd: int (optional)" 4
.IX Item "fd: int (optional)"
The file descriptor that is to be removed.

**Returns:**
Nothing on success
If \f(CW`fdset-id\*(C' or \f(CW\*(C\`fd\*(C' is not found, FdNotFound

**Since:**
1.2.0

**Notes:**
The list of fd sets is shared by all monitor connections.

If \f(CW`fd\*(C' is not specified, all file descriptors in \f(CW\*(C\`fdset-id\*(C'
will be removed.

**Example:**

.Vb 2
        -&gt; { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
        &lt;- { "return": {} }
.Ve

**FdsetFdInfo** (Object)

Information about a file descriptor that belongs to an fd set.

**Members:**
.ie n .IP """fd: int""" 4
.el .IP "\f(CWfd: int" 4
.IX Item "fd: int"
The file descriptor value.
.ie n .IP """opaque: string"" (optional)" 4
.el .IP "\f(CWopaque: string (optional)" 4
.IX Item "opaque: string (optional)"
A free-form string that can be used to describe the fd.

**Since:**
1.2.0

**FdsetInfo** (Object)

Information about an fd set.

**Members:**
.ie n .IP """fdset-id: int""" 4
.el .IP "\f(CWfdset-id: int" 4
.IX Item "fdset-id: int"
The \s-1ID\s0 of the fd set.
.ie n .IP """fds: array of FdsetFdInfo""" 4
.el .IP "\f(CWfds: array of FdsetFdInfo" 4
.IX Item "fds: array of FdsetFdInfo"
A list of file descriptors that belong to this fd set.

**Since:**
1.2.0

**query-fdsets**  (Command)
Return information describing all fd sets.

**Returns:**
A list of \f(CW`FdsetInfo\*(C'

**Since:**
1.2.0

**Note:**
The list of fd sets is shared by all monitor connections.

**Example:**

.Vb 10
        -&gt; { "execute": "query-fdsets" }
        &lt;- { "return": [
               {
                 "fds": [
                   {
                     "fd": 30,
                     "opaque": "rdonly:/path/to/file"
                   },
                   {
                     "fd": 24,
                     "opaque": "rdwr:/path/to/file"
                   }
                 ],
                 "fdset-id": 1
               },
               {
                 "fds": [
                   {
                     "fd": 28
                   },
                   {
                     "fd": 29
                   }
                 ],
                 "fdset-id": 0
               }
             ]
           }
.Ve

**TargetInfo** (Object)

Information describing the \s-1QEMU\s0 target.

**Members:**
.ie n .IP """arch: SysEmuTarget""" 4
.el .IP "\f(CWarch: SysEmuTarget" 4
.IX Item "arch: SysEmuTarget"
the target architecture

**Since:**
1.2.0

**query-target**  (Command)
Return information about the target for this \s-1QEMU\s0

**Returns:**
TargetInfo

**Since:**
1.2.0

**AcpiTableOptions** (Object)

Specify an \s-1ACPI\s0 table on the command line to load.

At most one of \f(CW`file\*(C' and \f(CW\*(C\`data\*(C' can be specified. The list of files specified
by any one of them is loaded and concatenated in order. If both are omitted,
\f(CW`data\*(C' is implied.

Other fields / optargs can be used to override fields of the generic \s-1ACPI\s0
table header; refer to the \s-1ACPI\s0 specification 5.0, section 5.2.6 System
Description Table Header. If a header field is not overridden, then the
corresponding value from the concatenated blob is used (in case of \f(CW`file\*(C'), or
it is filled in with a hard-coded value (in case of \f(CW`data\*(C').

String fields are copied into the matching \s-1ACPI\s0 member from lowest address
upwards, and silently truncated / NUL-padded to length.

**Members:**
.ie n .IP """sig: string"" (optional)" 4
.el .IP "\f(CWsig: string (optional)" 4
.IX Item "sig: string (optional)"
table signature / identifier (4 bytes)
.ie n .IP """rev: int"" (optional)" 4
.el .IP "\f(CWrev: int (optional)" 4
.IX Item "rev: int (optional)"
table revision number (dependent on signature, 1 byte)
.ie n .IP """oem_id: string"" (optional)" 4
.el .IP "\f(CWoem_id: string (optional)" 4
.IX Item "oem_id: string (optional)"
\s-1OEM\s0 identifier (6 bytes)
.ie n .IP """oem_table_id: string"" (optional)" 4
.el .IP "\f(CWoem_table_id: string (optional)" 4
.IX Item "oem_table_id: string (optional)"
\s-1OEM\s0 table identifier (8 bytes)
.ie n .IP """oem_rev: int"" (optional)" 4
.el .IP "\f(CWoem_rev: int (optional)" 4
.IX Item "oem_rev: int (optional)"
OEM-supplied revision number (4 bytes)
.ie n .IP """asl_compiler_id: string"" (optional)" 4
.el .IP "\f(CWasl_compiler_id: string (optional)" 4
.IX Item "asl_compiler_id: string (optional)"
identifier of the utility that created the table
(4 bytes)
.ie n .IP """asl_compiler_rev: int"" (optional)" 4
.el .IP "\f(CWasl_compiler_rev: int (optional)" 4
.IX Item "asl_compiler_rev: int (optional)"
revision number of the utility that created the
table (4 bytes)
.ie n .IP """file: string"" (optional)" 4
.el .IP "\f(CWfile: string (optional)" 4
.IX Item "file: string (optional)"
colon (:) separated list of pathnames to load and
concatenate as table data. The resultant binary blob is expected to
have an \s-1ACPI\s0 table header. At least one file is required. This field
excludes \f(CW`data\*(C'.
.ie n .IP """data: string"" (optional)" 4
.el .IP "\f(CWdata: string (optional)" 4
.IX Item "data: string (optional)"
colon (:) separated list of pathnames to load and
concatenate as table data. The resultant binary blob must not have an
\s-1ACPI\s0 table header. At least one file is required. This field excludes
\f(CW`file\*(C'.

**Since:**
1.5

**CommandLineParameterType** (Enum)

Possible types for an option parameter.

**Values:**
.ie n .IP """string""" 4
.el .IP "\f(CWstring" 4
.IX Item "string"
accepts a character string
.ie n .IP """boolean""" 4
.el .IP "\f(CWboolean" 4
.IX Item "boolean"
accepts on\*(R" or \*(L"off\*(R"
.ie n .IP """number""" 4
.el .IP "\f(CWnumber" 4
.IX Item "number"
accepts a number
.ie n .IP """size""" 4
.el .IP "\f(CWsize" 4
.IX Item "size"
accepts a number followed by an optional suffix (K)ilo,
(M)ega, (G)iga, (T)era

**Since:**
1.5

**CommandLineParameterInfo** (Object)

Details about a single parameter of a command line option.

**Members:**
.ie n .IP """name: string""" 4
.el .IP "\f(CWname: string" 4
.IX Item "name: string"
parameter name
.ie n .IP """type: CommandLineParameterType""" 4
.el .IP "\f(CWtype: CommandLineParameterType" 4
.IX Item "type: CommandLineParameterType"
parameter \f(CW`CommandLineParameterType\*(C'
.ie n .IP """help: string"" (optional)" 4
.el .IP "\f(CWhelp: string (optional)" 4
.IX Item "help: string (optional)"
human readable text string, not suitable for parsing.
.ie n .IP """default: string"" (optional)" 4
.el .IP "\f(CWdefault: string (optional)" 4
.IX Item "default: string (optional)"
default value string (since 2.1)

**Since:**
1.5

**CommandLineOptionInfo** (Object)

Details about a command line option, including its list of parameter details

**Members:**
.ie n .IP """option: string""" 4
.el .IP "\f(CWoption: string" 4
.IX Item "option: string"
option name
.ie n .IP """parameters: array of CommandLineParameterInfo""" 4
.el .IP "\f(CWparameters: array of CommandLineParameterInfo" 4
.IX Item "parameters: array of CommandLineParameterInfo"
an array of \f(CW`CommandLineParameterInfo\*(C'

**Since:**
1.5

**query-command-line-options**  (Command)
Query command line option schema.

**Arguments:**
.ie n .IP """option: string"" (optional)" 4
.el .IP "\f(CWoption: string (optional)" 4
.IX Item "option: string (optional)"
option name

**Returns:**
list of \f(CW`CommandLineOptionInfo\*(C' for all options (or for the given
\f(CW`option\*(C').  Returns an error if the given \f(CW\*(C\`option\*(C' doesn't exist.

**Since:**
1.5

**Example:**

.Vb 10
        -&gt; { "execute": "query-command-line-options",
             "arguments": { "option": "option-rom" } }
        &lt;- { "return": [
                {
                    "parameters": [
                        {
                            "name": "romfile",
                            "type": "string"
                        },
                        {
                            "name": "bootindex",
                            "type": "number"
                        }
                    ],
                    "option": "option-rom"
                }
             ]
           }
.Ve

**X86CPURegister32** (Enum)

A X86 32-bit register

**Values:**
.ie n .IP """EAX""" 4
.el .IP "\f(CWEAX" 4
.IX Item "EAX"
Not documented
.ie n .IP """EBX""" 4
.el .IP "\f(CWEBX" 4
.IX Item "EBX"
Not documented
.ie n .IP """ECX""" 4
.el .IP "\f(CWECX" 4
.IX Item "ECX"
Not documented
.ie n .IP """EDX""" 4
.el .IP "\f(CWEDX" 4
.IX Item "EDX"
Not documented
.ie n .IP """ESP""" 4
.el .IP "\f(CWESP" 4
.IX Item "ESP"
Not documented
.ie n .IP """EBP""" 4
.el .IP "\f(CWEBP" 4
.IX Item "EBP"
Not documented
.ie n .IP """ESI""" 4
.el .IP "\f(CWESI" 4
.IX Item "ESI"
Not documented
.ie n .IP """EDI""" 4
.el .IP "\f(CWEDI" 4
.IX Item "EDI"
Not documented

**Since:**
1.5

**X86CPUFeatureWordInfo** (Object)

Information about a X86 \s-1CPU\s0 feature word

**Members:**
.ie n .IP """cpuid-input-eax: int""" 4
.el .IP "\f(CWcpuid-input-eax: int" 4
.IX Item "cpuid-input-eax: int"
Input \s-1EAX\s0 value for \s-1CPUID\s0 instruction for that feature word
.ie n .IP """cpuid-input-ecx: int"" (optional)" 4
.el .IP "\f(CWcpuid-input-ecx: int (optional)" 4
.IX Item "cpuid-input-ecx: int (optional)"
Input \s-1ECX\s0 value for \s-1CPUID\s0 instruction for that
feature word
.ie n .IP """cpuid-register: X86CPURegister32""" 4
.el .IP "\f(CWcpuid-register: X86CPURegister32" 4
.IX Item "cpuid-register: X86CPURegister32"
Output register containing the feature bits
.ie n .IP """features: int""" 4
.el .IP "\f(CWfeatures: int" 4
.IX Item "features: int"
value of output register, containing the feature bits

**Since:**
1.5

**DummyForceArrays** (Object)

Not used by \s-1QMP\s0; hack to let us use X86CPUFeatureWordInfoList internally

**Members:**
.ie n .IP """unused: array of X86CPUFeatureWordInfo""" 4
.el .IP "\f(CWunused: array of X86CPUFeatureWordInfo" 4
.IX Item "unused: array of X86CPUFeatureWordInfo"
Not documented

**Since:**
2.5

**NumaOptionsType** (Enum)

**Values:**
.ie n .IP """node""" 4
.el .IP "\f(CWnode" 4
.IX Item "node"
\s-1NUMA\s0 nodes configuration
.ie n .IP """dist""" 4
.el .IP "\f(CWdist" 4
.IX Item "dist"
\s-1NUMA\s0 distance configuration (since 2.10)
.ie n .IP """cpu""" 4
.el .IP "\f(CWcpu" 4
.IX Item "cpu"
property based \s-1CPU\s0(s) to node mapping (Since: 2.10)

**Since:**
2.1

**NumaOptions** (Object)

A discriminated record of \s-1NUMA\s0 options. (for OptsVisitor)

**Members:**
.ie n .IP """type: NumaOptionsType""" 4
.el .IP "\f(CWtype: NumaOptionsType" 4
.IX Item "type: NumaOptionsType"
Not documented
.ie n .IP "The members of ""NumaNodeOptions"" when ""type"" is ""node""" 4
.el .IP "The members of \f(CWNumaNodeOptions when \f(CWtype is \`\`node''" 4
.IX Item "The members of NumaNodeOptions when type is node"
.ie n .IP "The members of ""NumaDistOptions"" when ""type"" is ""dist""" 4
.el .IP "The members of \f(CWNumaDistOptions when \f(CWtype is \`\`dist''" 4
.IX Item "The members of NumaDistOptions when type is dist"
.ie n .IP "The members of ""NumaCpuOptions"" when ""type"" is ""cpu""" 4
.el .IP "The members of \f(CWNumaCpuOptions when \f(CWtype is \`\`cpu''" 4
.IX Item "The members of NumaCpuOptions when type is cpu"

**Since:**
2.1

**NumaNodeOptions** (Object)

Create a guest \s-1NUMA\s0 node. (for OptsVisitor)

**Members:**
.ie n .IP """nodeid: int"" (optional)" 4
.el .IP "\f(CWnodeid: int (optional)" 4
.IX Item "nodeid: int (optional)"
\s-1NUMA\s0 node \s-1ID\s0 (increase by 1 from 0 if omitted)
.ie n .IP """cpus: array of int"" (optional)" 4
.el .IP "\f(CWcpus: array of int (optional)" 4
.IX Item "cpus: array of int (optional)"
VCPUs belonging to this node (assign \s-1VCPUS\s0 round-robin
if omitted)
.ie n .IP """mem: int"" (optional)" 4
.el .IP "\f(CWmem: int (optional)" 4
.IX Item "mem: int (optional)"
memory size of this node; mutually exclusive with \f(CW`memdev\*(C'.
Equally divide total memory among nodes if both \f(CW`mem\*(C' and \f(CW\*(C\`memdev\*(C' are
omitted.
.ie n .IP """memdev: string"" (optional)" 4
.el .IP "\f(CWmemdev: string (optional)" 4
.IX Item "memdev: string (optional)"
memory backend object.  If specified for one node,
it must be specified for all nodes.

**Since:**
2.1

**NumaDistOptions** (Object)

Set the distance between 2 \s-1NUMA\s0 nodes.

**Members:**
.ie n .IP """src: int""" 4
.el .IP "\f(CWsrc: int" 4
.IX Item "src: int"
source \s-1NUMA\s0 node.
.ie n .IP """dst: int""" 4
.el .IP "\f(CWdst: int" 4
.IX Item "dst: int"
destination \s-1NUMA\s0 node.
.ie n .IP """val: int""" 4
.el .IP "\f(CWval: int" 4
.IX Item "val: int"
\s-1NUMA\s0 distance from source node to destination node.
When a node is unreachable from another node, set the distance
between them to 255.

**Since:**
2.10

**NumaCpuOptions** (Object)

Option -numa cpu\*(R" overrides default cpu to node mapping.
It accepts the same set of cpu properties as returned by
query-hotpluggable-cpus[].props, where node-id could be used to
override default node mapping.

**Members:**
.ie n .IP "The members of ""CpuInstanceProperties""" 4
.el .IP "The members of \f(CWCpuInstanceProperties" 4
.IX Item "The members of CpuInstanceProperties"

**Since:**
2.10

**HostMemPolicy** (Enum)

Host memory policy types

**Values:**
.ie n .IP """default""" 4
.el .IP "\f(CWdefault" 4
.IX Item "default"
restore default policy, remove any nondefault policy
.ie n .IP """preferred""" 4
.el .IP "\f(CWpreferred" 4
.IX Item "preferred"
set the preferred host nodes for allocation
.ie n .IP """bind""" 4
.el .IP "\f(CWbind" 4
.IX Item "bind"
a strict policy that restricts memory allocation to the
host nodes specified
.ie n .IP """interleave""" 4
.el .IP "\f(CWinterleave" 4
.IX Item "interleave"
memory allocations are interleaved across the set
of host nodes specified

**Since:**
2.1

**Memdev** (Object)

Information about memory backend

**Members:**
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
backend's \s-1ID\s0 if backend has 'id' property (since 2.9)
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
memory backend size
.ie n .IP """merge: boolean""" 4
.el .IP "\f(CWmerge: boolean" 4
.IX Item "merge: boolean"
enables or disables memory merge support
.ie n .IP """dump: boolean""" 4
.el .IP "\f(CWdump: boolean" 4
.IX Item "dump: boolean"
includes memory backend's memory in a core dump or not
.ie n .IP """prealloc: boolean""" 4
.el .IP "\f(CWprealloc: boolean" 4
.IX Item "prealloc: boolean"
enables or disables memory preallocation
.ie n .IP """host-nodes: array of int""" 4
.el .IP "\f(CWhost-nodes: array of int" 4
.IX Item "host-nodes: array of int"
host nodes for its memory policy
.ie n .IP """policy: HostMemPolicy""" 4
.el .IP "\f(CWpolicy: HostMemPolicy" 4
.IX Item "policy: HostMemPolicy"
memory policy of memory backend

**Since:**
2.1

**query-memdev**  (Command)
Returns information for all memory backends.

**Returns:**
a list of \f(CW`Memdev\*(C'.

**Since:**
2.1

**Example:**

.Vb 10
        -&gt; { "execute": "query-memdev" }
        &lt;- { "return": [
               {
                 "id": "mem1",
                 "size": 536870912,
                 "merge": false,
                 "dump": true,
                 "prealloc": false,
                 "host-nodes": [0, 1],
                 "policy": "bind"
               },
               {
                 "size": 536870912,
                 "merge": false,
                 "dump": true,
                 "prealloc": true,
                 "host-nodes": [2, 3],
                 "policy": "preferred"
               }
             ]
           }
.Ve

**PCDIMMDeviceInfo** (Object)

PCDIMMDevice state information

**Members:**
.ie n .IP """id: string"" (optional)" 4
.el .IP "\f(CWid: string (optional)" 4
.IX Item "id: string (optional)"
device's \s-1ID\s0
.ie n .IP """addr: int""" 4
.el .IP "\f(CWaddr: int" 4
.IX Item "addr: int"
physical address, where device is mapped
.ie n .IP """size: int""" 4
.el .IP "\f(CWsize: int" 4
.IX Item "size: int"
size of memory that the device provides
.ie n .IP """slot: int""" 4
.el .IP "\f(CWslot: int" 4
.IX Item "slot: int"
slot number at which device is plugged in
.ie n .IP """node: int""" 4
.el .IP "\f(CWnode: int" 4
.IX Item "node: int"
\s-1NUMA\s0 node number where device is plugged in
.ie n .IP """memdev: string""" 4
.el .IP "\f(CWmemdev: string" 4
.IX Item "memdev: string"
memory backend linked with device
.ie n .IP """hotplugged: boolean""" 4
.el .IP "\f(CWhotplugged: boolean" 4
.IX Item "hotplugged: boolean"
true if device was hotplugged
.ie n .IP """hotpluggable: boolean""" 4
.el .IP "\f(CWhotpluggable: boolean" 4
.IX Item "hotpluggable: boolean"
true if device if could be added/removed while machine is running

**Since:**
2.1

**MemoryDeviceInfo** (Object)

Union containing information about a memory device

**Members:**
.ie n .IP """type""" 4
.el .IP "\f(CWtype" 4
.IX Item "type"
One of dimm\*(R", \*(L"nvdimm\*(R"
.ie n .IP """data: PCDIMMDeviceInfo"" when ""type"" is ""dimm""" 4
.el .IP "\f(CWdata: PCDIMMDeviceInfo when \f(CWtype is \`\`dimm''" 4
.IX Item "data: PCDIMMDeviceInfo when type is dimm"
.ie n .IP """data: PCDIMMDeviceInfo"" when ""type"" is ""nvdimm""" 4
.el .IP "\f(CWdata: PCDIMMDeviceInfo when \f(CWtype is \`\`nvdimm''" 4
.IX Item "data: PCDIMMDeviceInfo when type is nvdimm"

**Since:**
2.1

**query-memory-devices**  (Command)
Lists available memory devices and their state

**Since:**
2.1

**Example:**

.Vb 12
        -&gt; { "execute": "query-memory-devices" }
        &lt;- { "return": [ { "data":
                              { "addr": 5368709120,
                                "hotpluggable": true,
                                "hotplugged": true,
                                "id": "d1",
                                "memdev": "/objects/memX",
                                "node": 0,
                                "size": 1073741824,
                                "slot": 0},
                           "type": "dimm"
                         } ] }
.Ve

**\s-1MEM\_UNPLUG\_ERROR\s0**  (Event)
Emitted when memory hot unplug error occurs.

**Arguments:**
.ie n .IP """device: string""" 4
.el .IP "\f(CWdevice: string" 4
.IX Item "device: string"
device name
.ie n .IP """msg: string""" 4
.el .IP "\f(CWmsg: string" 4
.IX Item "msg: string"
Informative message

**Since:**
2.4

**Example:**

.Vb 5
        &lt;- { "event": "MEM_UNPLUG_ERROR"
             "data": { "device": "dimm1",
                       "msg": "acpi: device unplug for unsupported device"
             },
             "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
.Ve

**ACPISlotType** (Enum)

**Values:**
.ie n .IP """DIMM""" 4
.el .IP "\f(CWDIMM" 4
.IX Item "DIMM"
memory slot
.ie n .IP """CPU""" 4
.el .IP "\f(CWCPU" 4
.IX Item "CPU"
logical \s-1CPU\s0 slot (since 2.7)

**ACPIOSTInfo** (Object)

\s-1OSPM\s0 Status Indication for a device
For description of possible values of \f(CW`source\*(C' and \f(CW\*(C\`status\*(C' fields
see _OST (\s-1OSPM\s0 Status Indication)\*(R" chapter of \s-1ACPI5.0\s0 spec.

**Members:**
.ie n .IP """device: string"" (optional)" 4
.el .IP "\f(CWdevice: string (optional)" 4
.IX Item "device: string (optional)"
device \s-1ID\s0 associated with slot
.ie n .IP """slot: string""" 4
.el .IP "\f(CWslot: string" 4
.IX Item "slot: string"
slot \s-1ID,\s0 unique per slot of a given \f(CW`slot-type\*(C'
.ie n .IP """slot-type: ACPISlotType""" 4
.el .IP "\f(CWslot-type: ACPISlotType" 4
.IX Item "slot-type: ACPISlotType"
type of the slot
.ie n .IP """source: int""" 4
.el .IP "\f(CWsource: int" 4
.IX Item "source: int"
an integer containing the source event
.ie n .IP """status: int""" 4
.el .IP "\f(CWstatus: int" 4
.IX Item "status: int"
an integer containing the status code

**Since:**
2.1

**query-acpi-ospm-status**  (Command)
Return a list of ACPIOSTInfo for devices that support status
reporting via \s-1ACPI _OST\s0 method.

**Since:**
2.1

**Example:**

.Vb 6
        -&gt; { "execute": "query-acpi-ospm-status" }
        &lt;- { "return": [ { "device": "d1", "slot": "0", "slot-type": "DIMM", "source": 1, "status": 0},
                         { "slot": "1", "slot-type": "DIMM", "source": 0, "status": 0},
                         { "slot": "2", "slot-type": "DIMM", "source": 0, "status": 0},
                         { "slot": "3", "slot-type": "DIMM", "source": 0, "status": 0}
           ]}
.Ve

**\s-1ACPI\_DEVICE\_OST\s0**  (Event)
Emitted when guest executes \s-1ACPI _OST\s0 method.

**Arguments:**
.ie n .IP """info: ACPIOSTInfo""" 4
.el .IP "\f(CWinfo: ACPIOSTInfo" 4
.IX Item "info: ACPIOSTInfo"
\s-1OSPM\s0 Status Indication

**Since:**
2.1

**Example:**

.Vb 3
        &lt;- { "event": "ACPI_DEVICE_OST",
             "data": { "device": "d1", "slot": "0",
                       "slot-type": "DIMM", "source": 1, "status": 0 } }
.Ve

**rtc-reset-reinjection**  (Command)
This command will reset the \s-1RTC\s0 interrupt reinjection backlog.
Can be used if another mechanism to synchronize guest time
is in effect, for example \s-1QEMU\s0 guest agent's guest-set-time
command.

**Since:**
2.1

**Example:**

.Vb 2
        -&gt; { "execute": "rtc-reset-reinjection" }
        &lt;- { "return": {} }
.Ve

**\s-1RTC\_CHANGE\s0**  (Event)
Emitted when the guest changes the \s-1RTC\s0 time.

**Arguments:**
.ie n .IP """offset: int""" 4
.el .IP "\f(CWoffset: int" 4
.IX Item "offset: int"
offset between base \s-1RTC\s0 clock (as specified by -rtc base), and
new \s-1RTC\s0 clock value. Note that value will be different depending
on clock chosen to drive \s-1RTC\s0 (specified by -rtc clock).

**Note:**
This event is rate-limited.

**Since:**
0.13.0

**Example:**

.Vb 3
        &lt;-   { "event": "RTC_CHANGE",
               "data": { "offset": 78 },
               "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
.Ve

**ReplayMode** (Enum)

Mode of the replay subsystem.

**Values:**
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
normal execution mode. Replay or record are not enabled.
.ie n .IP """record""" 4
.el .IP "\f(CWrecord" 4
.IX Item "record"
record mode. All non-deterministic data is written into the
replay log.
.ie n .IP """play""" 4
.el .IP "\f(CWplay" 4
.IX Item "play"
replay mode. Non-deterministic data required for system execution
is read from the log.

**Since:**
2.5

**xen-load-devices-state**  (Command)
Load the state of all devices from file. The \s-1RAM\s0 and the block devices
of the \s-1VM\s0 are not loaded by this command.

**Arguments:**
.ie n .IP """filename: string""" 4
.el .IP "\f(CWfilename: string" 4
.IX Item "filename: string"
the file to load the state of the devices from as binary
data. See xen-save-devices-state.txt for a description of the binary
format.

**Since:**
2.7

**Example:**

.Vb 3
        -&gt; { "execute": "xen-load-devices-state",
             "arguments": { "filename": "/tmp/resume" } }
        &lt;- { "return": {} }
.Ve

**GICCapability** (Object)

The struct describes capability for a specific \s-1GIC\s0 (Generic
Interrupt Controller) version. These bits are not only decided by
\s-1QEMU/KVM\s0 software version, but also decided by the hardware that
the program is running upon.

**Members:**
.ie n .IP """version: int""" 4
.el .IP "\f(CWversion: int" 4
.IX Item "version: int"
version of \s-1GIC\s0 to be described. Currently, only 2 and 3
are supported.
.ie n .IP """emulated: boolean""" 4
.el .IP "\f(CWemulated: boolean" 4
.IX Item "emulated: boolean"
whether current QEMU/hardware supports emulated \s-1GIC\s0
device in user space.
.ie n .IP """kernel: boolean""" 4
.el .IP "\f(CWkernel: boolean" 4
.IX Item "kernel: boolean"
whether current QEMU/hardware supports hardware
accelerated \s-1GIC\s0 device in kernel.

**Since:**
2.6

**query-gic-capabilities**  (Command)
This command is ARM-only. It will return a list of GICCapability
objects that describe its capability bits.

**Returns:**
a list of GICCapability objects.

**Since:**
2.6

**Example:**

.Vb 3
        -&gt; { "execute": "query-gic-capabilities" }
        &lt;- { "return": [{ "version": 2, "emulated": true, "kernel": false },
                        { "version": 3, "emulated": false, "kernel": true } ] }
.Ve

**CpuInstanceProperties** (Object)

List of properties to be used for hotplugging a \s-1CPU\s0 instance,
it should be passed by management with device_add command when
a \s-1CPU\s0 is being hotplugged.

**Members:**
.ie n .IP """node-id: int"" (optional)" 4
.el .IP "\f(CWnode-id: int (optional)" 4
.IX Item "node-id: int (optional)"
\s-1NUMA\s0 node \s-1ID\s0 the \s-1CPU\s0 belongs to
.ie n .IP """socket-id: int"" (optional)" 4
.el .IP "\f(CWsocket-id: int (optional)" 4
.IX Item "socket-id: int (optional)"
socket number within node/board the \s-1CPU\s0 belongs to
.ie n .IP """core-id: int"" (optional)" 4
.el .IP "\f(CWcore-id: int (optional)" 4
.IX Item "core-id: int (optional)"
core number within socket the \s-1CPU\s0 belongs to
.ie n .IP """thread-id: int"" (optional)" 4
.el .IP "\f(CWthread-id: int (optional)" 4
.IX Item "thread-id: int (optional)"
thread number within core the \s-1CPU\s0 belongs to

**Note:**
currently there are 4 properties that could be present
but management should be prepared to pass through other
properties with device_add command to allow for future
interface extension. This also requires the filed names to be kept in
sync with the properties passed to -device/device_add.

**Since:**
2.7

**HotpluggableCPU** (Object)

**Members:**
.ie n .IP """type: string""" 4
.el .IP "\f(CWtype: string" 4
.IX Item "type: string"
\s-1CPU\s0 object type for usage with device_add command
.ie n .IP """props: CpuInstanceProperties""" 4
.el .IP "\f(CWprops: CpuInstanceProperties" 4
.IX Item "props: CpuInstanceProperties"
list of properties to be used for hotplugging \s-1CPU\s0
.ie n .IP """vcpus-count: int""" 4
.el .IP "\f(CWvcpus-count: int" 4
.IX Item "vcpus-count: int"
number of logical \s-1VCPU\s0 threads \f(CW`HotpluggableCPU\*(C' provides
.ie n .IP """qom-path: string"" (optional)" 4
.el .IP "\f(CWqom-path: string (optional)" 4
.IX Item "qom-path: string (optional)"
link to existing \s-1CPU\s0 object if \s-1CPU\s0 is present or
omitted if \s-1CPU\s0 is not present.

**Since:**
2.7

**query-hotpluggable-cpus**  (Command)

**Returns:**
a list of HotpluggableCPU objects.

**Since:**
2.7

**Example:**

.Vb 1
        For pseries machine type started with -smp 2,cores=2,maxcpus=4 -cpu POWER8:
        
        -&gt; { "execute": "query-hotpluggable-cpus" }
        &lt;- {"return": [
             { "props": { "core": 8 }, "type": "POWER8-spapr-cpu-core",
               "vcpus-count": 1 },
             { "props": { "core": 0 }, "type": "POWER8-spapr-cpu-core",
               "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
           ]}
        
        For pc machine type started with -smp 1,maxcpus=2:
        
        -&gt; { "execute": "query-hotpluggable-cpus" }
        &lt;- {"return": [
             {
                "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
                "props": {"core-id": 0, "socket-id": 1, "thread-id": 0}
             },
             {
                "qom-path": "/machine/unattached/device[0]",
                "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
                "props": {"core-id": 0, "socket-id": 0, "thread-id": 0}
             }
           ]}
        
        For s390x-virtio-ccw machine type started with -smp 1,maxcpus=2 -cpu qemu
        (Since: 2.11):
        
        -&gt; { "execute": "query-hotpluggable-cpus" }
        &lt;- {"return": [
             {
                "type": "qemu-s390x-cpu", "vcpus-count": 1,
                "props": { "core-id": 1 }
             },
             {
                "qom-path": "/machine/unattached/device[0]",
                "type": "qemu-s390x-cpu", "vcpus-count": 1,
                "props": { "core-id": 0 }
             }
           ]}
.Ve

**GuidInfo** (Object)

\s-1GUID\s0 information.

**Members:**
.ie n .IP """guid: string""" 4
.el .IP "\f(CWguid: string" 4
.IX Item "guid: string"
the globally unique identifier

**Since:**
2.9

**query-vm-generation-id**  (Command)
Show Virtual Machine Generation \s-1ID\s0

**Since:**
2.9

**SevState** (Enum)

An enumeration of \s-1SEV\s0 state information used during \f(CW`query-sev\*(C'.

**Values:**
.ie n .IP """uninit""" 4
.el .IP "\f(CWuninit" 4
.IX Item "uninit"
The guest is uninitialized.
.ie n .IP """launch-update""" 4
.el .IP "\f(CWlaunch-update" 4
.IX Item "launch-update"
The guest is currently being launched; plaintext data and
register state is being imported.
.ie n .IP """launch-secret""" 4
.el .IP "\f(CWlaunch-secret" 4
.IX Item "launch-secret"
The guest is currently being launched; ciphertext data
is being imported.
.ie n .IP """running""" 4
.el .IP "\f(CWrunning" 4
.IX Item "running"
The guest is fully launched or migrated in.
.ie n .IP """send-update""" 4
.el .IP "\f(CWsend-update" 4
.IX Item "send-update"
The guest is currently being migrated out to another machine.
.ie n .IP """receive-update""" 4
.el .IP "\f(CWreceive-update" 4
.IX Item "receive-update"
The guest is currently being migrated from another machine.

**Since:**
2.12

**SevInfo** (Object)

Information about Secure Encrypted Virtualization (\s-1SEV\s0) support

**Members:**
.ie n .IP """enabled: boolean""" 4
.el .IP "\f(CWenabled: boolean" 4
.IX Item "enabled: boolean"
true if \s-1SEV\s0 is active
.ie n .IP """api-major: int""" 4
.el .IP "\f(CWapi-major: int" 4
.IX Item "api-major: int"
\s-1SEV API\s0 major version
.ie n .IP """api-minor: int""" 4
.el .IP "\f(CWapi-minor: int" 4
.IX Item "api-minor: int"
\s-1SEV API\s0 minor version
.ie n .IP """build-id: int""" 4
.el .IP "\f(CWbuild-id: int" 4
.IX Item "build-id: int"
\s-1SEV FW\s0 build id
.ie n .IP """policy: int""" 4
.el .IP "\f(CWpolicy: int" 4
.IX Item "policy: int"
\s-1SEV\s0 policy value
.ie n .IP """state: SevState""" 4
.el .IP "\f(CWstate: SevState" 4
.IX Item "state: SevState"
\s-1SEV\s0 guest state
.ie n .IP """handle: int""" 4
.el .IP "\f(CWhandle: int" 4
.IX Item "handle: int"
\s-1SEV\s0 firmware handle

**Since:**
2.12

**query-sev**  (Command)
Returns information about \s-1SEV\s0

**Returns:**
\f(CW`SevInfo\*(C'

**Since:**
2.12

**Example:**

.Vb 4
        -&gt; { "execute": "query-sev" }
        &lt;- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
                         "build-id" : 0, "policy" : 0, "state" : "running",
                         "handle" : 1 } }
.Ve

**SevLaunchMeasureInfo** (Object)

\s-1SEV\s0 Guest Launch measurement information

**Members:**
.ie n .IP """data: string""" 4
.el .IP "\f(CWdata: string" 4
.IX Item "data: string"
the measurement value encoded in base64

**Since:**
2.12

**query-sev-launch-measure**  (Command)
Query the \s-1SEV\s0 guest launch information.

**Returns:**
The \f(CW`SevLaunchMeasureInfo\*(C' for the guest

**Since:**
2.12

**Example:**

.Vb 2
        -&gt; { "execute": "query-sev-launch-measure" }
        &lt;- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
.Ve

**SevCapability** (Object)

The struct describes capability for a Secure Encrypted Virtualization
feature.

**Members:**
.ie n .IP """pdh: string""" 4
.el .IP "\f(CWpdh: string" 4
.IX Item "pdh: string"
Platform Diffie-Hellman key (base64 encoded)
.ie n .IP """cert-chain: string""" 4
.el .IP "\f(CWcert-chain: string" 4
.IX Item "cert-chain: string"
\s-1PDH\s0 certificate chain (base64 encoded)
.ie n .IP """cbitpos: int""" 4
.el .IP "\f(CWcbitpos: int" 4
.IX Item "cbitpos: int"
C-bit location in page table entry
.ie n .IP """reduced-phys-bits: int""" 4
.el .IP "\f(CWreduced-phys-bits: int" 4
.IX Item "reduced-phys-bits: int"
Number of physical Address bit reduction when \s-1SEV\s0 is
enabled

**Since:**
2.12

**query-sev-capabilities**  (Command)
This command is used to get the \s-1SEV\s0 capabilities, and is supported on \s-1AMD
X86\s0 platforms only.

**Returns:**
SevCapability objects.

**Since:**
2.12

**Example:**

.Vb 3
        -&gt; { "execute": "query-sev-capabilities" }
        &lt;- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
                         "cbitpos": 47, "reduced-phys-bits": 5}}
.Ve

**CommandDropReason** (Enum)

Reasons that caused one command to be dropped.

**Values:**
.ie n .IP """queue-full""" 4
.el .IP "\f(CWqueue-full" 4
.IX Item "queue-full"
the command queue is full. This can only occur when
the client sends a new non-oob command before the
response to the previous non-oob command has been
received.

**Since:**
2.12

**\s-1COMMAND\_DROPPED\s0**  (Event)
Emitted when a command is dropped due to some reason.  Commands can
only be dropped when the oob capability is enabled.

**Arguments:**
.ie n .IP """id: value""" 4
.el .IP "\f(CWid: value" 4
.IX Item "id: value"
The dropped command's id\*(R" field.
\s-1FIXME\s0 Broken by design.  Events are broadcast to all monitors.  If
another monitor's client has a command with the same \s-1ID\s0 in flight,
the event will incorrectly claim that command was dropped.
.ie n .IP """reason: CommandDropReason""" 4
.el .IP "\f(CWreason: CommandDropReason" 4
.IX Item "reason: CommandDropReason"
The reason why the command is dropped.

**Since:**
2.12

**Example:**

.Vb 3
        { "event": "COMMAND_DROPPED",
          "data": {"result": {"id": "libvirt-102",
                              "reason": "queue-full" } } }
.Ve

**set-numa-node**  (Command)
Runtime equivalent of '-numa' \s-1CLI\s0 option, available at
preconfigure stage to configure numa mapping before initializing
machine.

Since 3.0

**Arguments:** the members of \f(CW`NumaOptions\*(C'
