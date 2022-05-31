# pulseaudio(1) - The PulseAudio Sound System

Manuals, User

```
pulseaudio [options]
</synopsis>

<synopsis>
pulseaudio --help
</synopsis>

<synopsis>
pulseaudio --version
</synopsis>

<synopsis>
pulseaudio --dump-conf
</synopsis>

<synopsis>
pulseaudio --dump-modules
</synopsis>

<synopsis>
pulseaudio --dump-resample-methods
</synopsis>

<synopsis>
pulseaudio --cleanup-shm
</synopsis>

<synopsis>
pulseaudio --start
</synopsis>

<synopsis>
pulseaudio --kill
</synopsis>

<synopsis>
pulseaudio --check 
```

<a name="description"></a>

# Description

PulseAudio is a networked low-latency sound server for Linux, POSIX and Windows systems.

<a name="options"></a>

# Options


* **-h | --help**  
  Show help.
* **--version**  
  Show version information.
* **--dump-conf**  
  Load the daemon configuration file _daemon.conf_ (see below), parse remaining configuration options on the command line and dump the resulting daemon configuration, in a format that is compatible with _daemon.conf_.
* **--dump-modules**  
  List available loadable modules. Combine with **-v** for a more elaborate listing.
* **--dump-resample-methods**  
  List available audio resamplers.
* **--cleanup-shm**  
  Identify stale PulseAudio POSIX shared memory segments in _/dev/shm_ and remove them if possible. This is done implicitly whenever a new daemon starts up or a client tries to connect to a daemon. It should normally not be necessary to issue this command by hand. Only available on systems with POSIX shared memory segments implemented via a virtual file system mounted to _/dev/shm_ (e.g. Linux).
* **--start**  
  Start PulseAudio if it is not running yet. This is different from starting PulseAudio without **--start** which would fail if PA is already running. PulseAudio is guaranteed to be fully initialized when this call returns. Implies **--daemonize**.
* **-k | --kill**  
  Kill an already running PulseAudio daemon of the calling user (Equivalent to sending a SIGTERM).
* **--check**  
  Return 0 as return code when the PulseAudio daemon is already running for the calling user, or non-zero otherwise. Produces no output on the console except for errors to stderr.
* **--system**_[=BOOL]_  
  Run as system-wide instance instead of per-user. Please note that this disables certain features of PulseAudio and is generally not recommended unless the system knows no local users (e.g. is a thin client). This feature needs special configuration and a dedicated UNIX user set up. It is highly recommended to combine this with **--disallow-module-loading** (see below).
* **-D | --daemonize**_[=BOOL]_  
  Daemonize after startup, i.e. detach from the terminal. Note that when running as a systemd service you should use **--daemonize=no** for systemd notification to work. 
* **--fail**_[=BOOL]_  
  Fail startup when any of the commands specified in the startup script _default.pa_ (see below) fails.
* **--high-priority**_[=BOOL]_  
  Try to acquire a high Unix nice level. This will only succeed if the calling user has a non-zero RLIMIT_NICE resource limit set (on systems that support this), or we're called SUID root (see below), or we are configure to be run as system daemon (see _--system_ above). It is recommended to enable this, since it is only a negligible security risk (see below).
* **--realtime**_[=BOOL]_  
  Try to acquire a real-time scheduling for PulseAudio's I/O threads. This will only succeed if the calling user has a non-zero RLIMIT_RTPRIO resource limit set (on systems that support this), or we're called SUID root (see below), or we are configure to be run as system daemon (see _--system_ above). It is recommended to enable this only for trusted users, since it is a major security risk (see below).
* **--disallow-module-loading**_[=BOOL]_  
  Disallow module loading after startup. This is a security feature since it disallows additional module loading during runtime and on user request. It is highly recommended when _--system_ is used (see above). Note however, that this breaks certain features like automatic module loading on hot plug.
* **--disallow-exit**_[=BOOL]_  
  Disallow user requested exit
* **--exit-idle-time**_=SECS_  
  Terminate the daemon after the last client quit and this time in seconds passed. Use a negative value to disable this feature. Defaults to 20.
  
  When PulseAudio runs in the per-user mode and detects a login session, then any positive value will be reset to 0 so that PulseAudio will terminate immediately on logout. A positive value therefore has effect only in environments where there's no support for login session tracking. A negative value can still be used to disable any automatic exit.
  
  When PulseAudio runs in the system mode, automatic exit is always disabled, so this option does nothing.
* **--scache-idle-time**_=SECS_  
  Unload autoloaded samples from the cache when they haven't been used for the specified number of seconds.
* **--log-level**_[=LEVEL]_  
  If an argument is passed, set the log level to the specified value, otherwise increase the configured verbosity level by one. The log levels are numerical from 0 to 4, corresponding to _error_, _warn_, _notice_, _info_, _debug_. Default log level is _notice_, i.e. all log messages with lower log levels are printed: _error_, _warn_, _notice_.
* **-v | --verbose**  
  Increase the configured verbosity level by one (see **--log-level** above). Specify multiple times to increase log level multiple times.
* **--log-target**_={auto,syslog,journal,stderr,file:PATH,newfile:PATH}_  
  Specify the log target. If set to _auto_ (which is the default), then logging is directed to syslog when **--daemonize** is passed, otherwise to STDERR. If set to _journal_ logging is directed to the systemd journal. If set to _file:PATH_, logging is directed to the file indicated by PATH. _newfile:PATH_ is otherwise the same as file:PATH, but existing files are never overwritten. If the specified file already exists, a suffix is added to the file name to avoid overwriting.
* **--log-meta**_[=BOOL]_  
  Show source code location in log messages.
* **--log-time**_[=BOOL]_  
  Show timestamps in log messages.
* **--log-backtrace**_=FRAMES_  
  When FRAMES is greater than 0, log for each message a stack trace up to the number of specified stack frames.
* **-p | --dl-search-path**_=PATH_  
  Set the search path for dynamic shared objects (plugins).
* **--resample-method**_=METHOD_  
  Use the specified resampler by default (See **--dump-resample-methods** above for possible values).
* **--use-pid-file**_[=BOOL]_  
  Create a PID file. If this options is disabled it is possible to run multiple sound servers per user.
* **--no-cpu-limit**_[=BOOL]_  
  Do not install CPU load limiter on platforms that support it. By default, PulseAudio will terminate itself when it notices that it takes up too much CPU time. This is useful as a protection against system lockups when real-time scheduling is used (see below). Disabling this mechanism is useful when debugging PulseAudio with tools like **valgrind(1)** which slow down execution.
* **--disable-shm**_[=BOOL]_  
  PulseAudio clients and the server can exchange audio data via POSIX or memfd shared memory segments (on systems that support this). If disabled PulseAudio will communicate exclusively over sockets. Please note that data transfer via shared memory segments is always disabled when PulseAudio is running with **--system** enabled (see above).
* **--enable-memfd**_[=BOOL]_  
  PulseAudio clients and the server can exchange audio data via memfds - the anonymous Linux Kernel shared memory mechanism (on kernels that support this). If disabled PulseAudio will communicate via POSIX shared memory.
* **-L | --load**_="MODULE ARGUMENTS"_  
  Load the specified plugin module with the specified arguments.
* **-F | --file**_=FILENAME_  
  Run the specified script on startup. May be specified multiple times to specify multiple scripts to be run in order. Combine with **-n** to disable loading of the default script _default.pa_ (see below).
* **-C**  
  Open a command interpreter on STDIN/STDOUT after startup. This may be used to configure PulseAudio dynamically during runtime. Equivalent to **--load**_=module-cli_.
* **-n**  
  Don't load default script file _default.pa_ (see below) on startup. Useful in conjunction with **-C** or **--file**.

<a name="files"></a>

# Files

_~/.config/pulse/daemon.conf_, _/etc/pulse/daemon.conf_: configuration settings for the PulseAudio daemon. If the version in the user's home directory does not exist the global configuration file is loaded. See **pulse-daemon.conf(5)** for more information.

_~/.config/pulse/default.pa_, _/etc/pulse/default.pa_: the default configuration script to execute when the PulseAudio daemon is started. If the version in the user's home directory does not exist the global configuration script is loaded. See **default.pa(5)** for more information.

_~/.config/pulse/client.conf_, _/etc/pulse/client.conf_: configuration settings for PulseAudio client applications. If the version in the user's home directory does not exist the global configuration file is loaded. See **pulse-client.conf(5)** for more information.

<a name="signals"></a>

# Signals

_SIGINT, SIGTERM_: the PulseAudio daemon will shut down (Same as **--kill**).

_SIGHUP_: dump a long status report to STDOUT or syslog, depending on the configuration.

_SIGUSR1_: load module-cli, allowing runtime reconfiguration via STDIN/STDOUT.

_SIGUSR2_: load module-cli-protocol-unix, allowing runtime reconfiguration via a AF_UNIX socket. See **pacmd(1)** for more information.

<a name="unix-groups-and-users"></a>

# Unix Groups and Users

Group _pulse-rt_: if the PulseAudio binary is marked SUID root, then membership of the calling user in this group decides whether real-time and/or high-priority scheduling is enabled. Please note that enabling real-time scheduling is a security risk (see below).

Group _pulse-access_: if PulseAudio is running as a system daemon (see **--system** above) access is granted to members of this group when they connect via AF_UNIX sockets. If PulseAudio is running as a user daemon this group has no meaning.

User _pulse_, group _pulse_: if PulseAudio is running as a system daemon (see **--system** above) and is started as root the daemon will drop privileges and become a normal user process using this user and group. If PulseAudio is running as a user daemon this user and group has no meaning.

<a name="real-time-and-high-priority-scheduling"></a>

# Real-Time and High-Priority Scheduling

To minimize the risk of drop-outs during playback it is recommended to run PulseAudio with real-time scheduling if the underlying platform supports it. This decouples the scheduling latency of the PulseAudio daemon from the system load and is thus the best way to make sure that PulseAudio always gets CPU time when it needs it to refill the hardware playback buffers. Unfortunately this is a security risk on most systems, since PulseAudio runs as user process, and giving realtime scheduling privileges to a user process always comes with the risk that the user misuses it to lock up the system -- which is possible since making a process real-time effectively disables preemption.

To minimize the risk PulseAudio by default does not enable real-time scheduling. It is however recommended to enable it on trusted systems. To do that start PulseAudio with **--realtime** (see above) or enabled the appropriate option in _daemon.conf_. Since acquiring realtime scheduling is a privileged operation on most systems, some special changes to the system configuration need to be made to allow them to the calling user. Two options are available:

On newer Linux systems the system resource limit RLIMIT_RTPRIO (see **setrlimit(2)** for more information) can be used to allow specific users to acquire real-time scheduling. This can be configured in _/etc/security/limits.conf_, a resource limit of 9 is recommended.

Alternatively, the SUID root bit can be set for the PulseAudio binary. Then, the daemon will drop root privileges immediately on startup, however retain the CAP_NICE capability (on systems that support it), but only if the calling user is a member of the _pulse-rt_ group (see above). For all other users all capabilities are dropped immediately. The advantage of this solution is that the real-time privileges are only granted to the PulseAudio daemon -- not to all the user's processes.

Alternatively, if the risk of locking up the machine is considered too big to enable real-time scheduling, high-priority scheduling can be enabled instead (i.e. negative nice level). This can be enabled by passing **--high-priority** (see above) when starting PulseAudio and may also be enabled with the appropriate option in _daemon.conf_. Negative nice levels can only be enabled when the appropriate resource limit RLIMIT_NICE is set (see **setrlimit(2)** for more information), possibly configured in _/etc/security/limits.conf_. A resource limit of 31 (corresponding with nice level -11) is recommended.

<a name="environment-variables"></a>

# Environment Variables

The PulseAudio client libraries check for the existence of the following environment variables and change their local configuration accordingly:

_$PULSE\_SERVER_: the server string specifying the server to connect to when a client asks for a sound server connection and doesn't explicitly ask for a specific server. The server string is a list of server addresses separated by whitespace which are tried in turn. A server address consists of an optional address type specifier (unix:, tcp:, tcp4:, tcp6:), followed by a path or host address. A host address may include an optional port number. A server address may be prefixed by a string enclosed in {}. In this case the following server address is ignored unless the prefix string equals the local hostname or the machine id (/etc/machine-id).

_$PULSE\_SINK_: the symbolic name of the sink to connect to when a client creates a playback stream and doesn't explicitly ask for a specific sink.

_$PULSE\_SOURCE_: the symbolic name of the source to connect to when a client creates a record stream and doesn't explicitly ask for a specific source.

_$PULSE\_BINARY_: path of PulseAudio executable to run when server auto-spawning is used.

_$PULSE\_CLIENTCONFIG_: path of file that shall be read instead of _client.conf_ (see above) for client configuration.

_$PULSE\_COOKIE_: path of file that contains the PulseAudio authentication cookie. Defaults to _~/.config/pulse/cookie_.

These environment settings take precedence -- if set -- over the configuration settings from _client.conf_ (see above).

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**pulse-daemon.conf(5)**, **default.pa(5)**, **pulse-client.conf(5)**, **pacmd(1)**
