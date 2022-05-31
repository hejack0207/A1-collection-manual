# default.pa(5) - PulseAudio Sound Server Startup Script

Manuals, User

```
~/.config/pulse/default.pa
</synopsis>

<synopsis>
/etc/pulse/default.pa
</synopsis>

<synopsis>
/etc/pulse/system.pa 
```

<a name="description"></a>

# Description

The PulseAudio sound server interprets a configuration script on startup, which is mainly used to define the set of modules to load. When PulseAudio runs in the per-user mode and _~/.config/pulse/default.pa_ exists, that file is used. When PulseAudio runs in the per-user mode and that file doesn't exist, _/etc/pulse/default.pa_ is used. When PulseAudio runs as a system service, _/etc/pulse/system.pa_ is used.

The script should contain directives in the PulseAudio CLI language, as documented in **pulse-cli-syntax(5)**.

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**pulse-cli-syntax(5)**, **pulse-daemon.conf(5)**, **pulseaudio(1)**, **pacmd(1)**
