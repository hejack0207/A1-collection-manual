# dbus\-monitor(1)

D\-Bus 1\&.12\&.20, 07/27/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dbus-monitor - debug probe to print message bus messages

<a name="synopsis"></a>

# Synopsis

```
.HP \w'dbus-monitor&nbsp;'u dbus-monitor [--system | --session | --address&nbsp;ADDRESS] [--profile | --monitor | --pcap | --binary] [watch&nbsp;expressions]

```


<a name="description"></a>

# Description


The
**dbus-monitor**
command is used to monitor messages going through a D-Bus message bus. See
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[]
for more information about the big picture.

There are two well-known message buses: the systemwide message bus (installed on many systems as the "messagebus" service) and the per-user-login-session message bus (started each time a user logs in). The --system and --session options direct
**dbus-monitor**
to monitor the system or session buses respectively. If neither is specified,
**dbus-monitor**
monitors the session bus.

**dbus-monitor**
has two different text output modes: the classic\*(Aq-style monitoring mode, and profiling mode. The profiling format is a compact format with a single line per message and microsecond-resolution timing information. The --profile and --monitor options select the profiling and monitoring output format respectively.

**dbus-monitor**
also has two binary output modes. The binary mode, selected by
--binary, outputs the entire binary message stream (without the initial authentication handshake). The PCAP mode, selected by
--pcap, adds a PCAP file header to the beginning of the output, and prepends a PCAP message header to each message; this produces a binary file that can be read by, for instance, Wireshark.

If no mode is specified,
**dbus-monitor**
uses the monitoring output format.

In order to get
**dbus-monitor**
to see the messages you are interested in, you should specify a set of watch expressions as you would expect to be passed to the
_dbus\_bus\_add\_match_
function.

The message bus configuration may keep
**dbus-monitor**
from seeing all messages, especially if you run the monitor as a non-root user.

<a name="options"></a>

# Options


**--system**
Monitor the system message bus.

**--session**
Monitor the session message bus. (This is the default.)

**--address ADDRESS**
Monitor an arbitrary message bus given at ADDRESS.

**--profile**
Use the profiling output format.

**--monitor**
Use the monitoring output format. (This is the default.)

<a name="example"></a>

# Example


Here is an example of using dbus-monitor to watch for the gnome typing monitor to say things

.if n \{.RS 4
.\}
    
      dbus-monitor "type=signal*(Aq,sender=*(Aqorg.gnome.TypingMonitor*(Aq,interface=*(Aqorg.gnome.TypingMonitor*(Aq"
    
.if n \{.RE
.\}

<a name="author"></a>

# Author


dbus-monitor was written by Philip Blundell. The profiling output mode was added by Olli Salli.

<a name="bugs"></a>

# Bugs


Please send bug reports to the D-Bus mailing list or bug tracker, see
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[]
