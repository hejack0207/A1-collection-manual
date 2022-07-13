# i3\-msg(1)

i3 4\&.18\&.1, 04/23/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

i3-msg - send messages to i3 window manager

<a name="synopsis"></a>

# Synopsis

```

 i3-msg [-q] [-v] [-h] [-s socket] [-t type] [message]
```

<a name="options"></a>

# Options


**-q, --quiet**
Only send ipc message and suppress the output of the response.

**-v, --version**
Display version number and exit.

**-h, --help**
Display a short help-message and exit.

**-s, --socket** _sock\_path_
i3-msg will use the environment variable I3SOCK or the socket path given here. If both fail, it will try to get the socket information from the root window and then try /tmp/i3-ipc.sock before exiting with an error.

**-t** _type_
Send ipc message, see below. This option defaults to "command".

**-m**, **--monitor**
Instead of exiting right after receiving the first subscribed event, wait indefinitely for all of them. Can only be used with "-t subscribe". See the "subscribe" IPC message type below for details.

**message**
Send ipc message, see below.

<a name="ipc-message-types"></a>

# Ipc Message Types


command
The payload of the message is a command for i3 (like the commands you can bind to keys in the configuration file) and will be executed directly after receiving it.

get_workspaces
Gets the current workspaces. The reply will be a JSON-encoded list of workspaces.

get_outputs
Gets the current outputs. The reply will be a JSON-encoded list of outputs (see the reply section of docs/ipc, e.g. at
\m[blue]**https://i3wm.org/docs/ipc.html#\_receiving\_replies\_from\_i3**\m[]).

get_tree
Gets the layout tree. i3 uses a tree as data structure which includes every container. The reply will be the JSON-encoded tree.

get_marks
Gets a list of marks (identifiers for containers to easily jump to them later). The reply will be a JSON-encoded list of window marks.

get_bar_config
Gets the configuration (as JSON map) of the workspace bar with the given ID. If no ID is provided, an array with all configured bar IDs is returned instead.

get_binding_modes
Gets a list of configured binding modes.

get_version
Gets the version of i3. The reply will be a JSON-encoded dictionary with the major, minor, patch and human-readable version.

get_config
Gets the currently loaded i3 configuration.

send_tick
Sends a tick to all IPC connections which subscribe to tick events.

subscribe
The payload of the message describes the events to subscribe to. Upon reception, each event will be dumped as a JSON-encoded object. See the -m option for continuous monitoring.

<a name="description"></a>

# Description


i3-msg is a sample implementation for a client using the unix socket IPC interface to i3.

<a name="exit-status"></a>

### Exit status:


0: if OK, 1: if invalid syntax or unable to connect to ipc-socket 2: if i3 returned an error processing your command(s)

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    # Use 1-px border for current client
    i3-msg "border 1pixel"
    
    # You can leave out the quotes
    i3-msg border normal
    
    # Dump the layout tree
    i3-msg -t get_tree
    
    # Monitor window changes
    i3-msg -t subscribe -m [ "window" ]*(Aq
.if n \{.RE
.\}

<a name="environment"></a>

# Environment


<a name="i3sock"></a>

### I3SOCK


If no ipc-socket is specified on the commandline, this variable is used to determine the path, at which the unix domain socket is expected, on which to connect to i3.

<a name="see-also"></a>

# See Also


i3(1)

<a name="author"></a>

# Author


Michael Stapelberg and contributors
