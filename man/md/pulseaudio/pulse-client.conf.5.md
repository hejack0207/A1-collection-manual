# pulse-client.conf(5) - PulseAudio client configuration file

Manuals, User

```
~/.config/pulse/client.conf
</synopsis>

<synopsis>
~/.config/pulse/client.conf.d/*.conf
</synopsis>

<synopsis>
/etc/pulse/client.conf
</synopsis>

<synopsis>
/etc/pulse/client.conf.d/*.conf 
```

<a name="description"></a>

# Description

The PulseAudio client library reads configuration directives from a configuration file on startup. If the per-user file _~/.config/pulse/client.conf_ exists, it is used, otherwise the system configuration file _/etc/pulse/client.conf_ is used. In addition to those main files, configuration directives can also be put in files under directories _~/.config/pulse/client.conf.d/_ and _/etc/pulse/client.conf.d/_. Those files have to have the .conf file name extension, but otherwise the file names can be chosen freely. The files under client.conf.d are processed in alphabetical order. In case the same option is set in multiple files, the last file to set an option overrides earlier files. The main client.conf file is processed first, so options set in files under client.conf.d override the main file.

The configuration file is a simple collection of variable declarations. If the configuration file parser encounters either ; or # it ignores the rest of the line until its end.

For the settings that take a boolean argument the values **true**, **yes**, **on** and **1** are equivalent, resp. **false**, **no**, **off**, **0**.

<a name="directives"></a>

# Directives


* **default-sink=** The default sink to connect to. If specified overwrites the setting in the daemon. The environment variable **$PULSE\_SINK** however takes precedence.  
* **default-source=** The default source to connect to. If specified overwrites the setting in the daemon. The environment variable **$PULSE\_SOURCE** however takes precedence.  
* **default-server=** The default sever to connect to. The environment variable **$PULSE\_SERVER** takes precedence.  
* **autospawn=** Autospawn a PulseAudio daemon when needed. Takes a boolean value, defaults to **yes**.  
* **daemon-binary=** Path to the PulseAudio daemon to run when autospawning. Defaults to a path configured at compile time.  
* **extra-arguments=** Extra arguments to pass to the PulseAudio daemon when autospawning. Defaults to **--log-target=syslog**  
* **cookie-file=** Specify the path to the PulseAudio authentication cookie. Defaults to _~/.config/pulse/cookie_.  
* **enable-shm=** Enable data transfer via POSIX or memfd shared memory. Takes a boolean argument, defaults to **yes**. If set to **no**, communication with the server will be exclusively done through data-copy over sockets.  
* **enable-memfd=**. Enable data transfer via memfd shared memory. Takes a boolean argument, defaults to **yes**.  
* **shm-size-bytes=** Sets the shared memory segment size for clients, in bytes. If left unspecified or is set to 0 it will default to some system-specific default, usually 64 MiB. Please note that usually there is no need to change this value, unless you are running an OS kernel that does not do memory overcommit.  
* **auto-connect-localhost=** Automatically try to connect to localhost via IP. Enabling this is a potential security hole since connections are only authenticated one-way and a rogue server might hence fool a client into sending it its private (e.g. VoIP call) data. This was enabled by default on PulseAudio version 0.9.21 and older. Defaults to **no**.  
* **auto-connect-display=** Automatically try to connect to the host X11's $DISPLAY variable is set to. The same security issues apply as to **auto-connect-localhost=**. Defaults to **no**.  

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**pulse-daemon.conf(5)**, **pulseaudio(1)**
