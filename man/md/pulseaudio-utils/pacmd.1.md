# pacmd(1) - Reconfigure a PulseAudio sound server during runtime

Manuals, User

```
pacmd
</synopsis>

<synopsis>
pacmd --help
</synopsis>

<synopsis>
pacmd --version 
```

<a name="description"></a>

# Description

This tool can be used to introspect or reconfigure a running PulseAudio sound server during runtime. It connects to the sound server and offers a simple live shell that can be used to enter the commands also understood in the _default.pa_ configuration scripts.

To exit the live shell, use ctrl+d. Note that the 'exit' command inside the shell will tell the PulseAudio daemon itself to shutdown!

If any arguments are passed on the command line, they will be passed into the live shell which will process the command and exit.

<a name="options"></a>

# Options


* **-h | --help**  
  Show help.
* **--version**  
  Show version information.

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**pulse-cli-syntax(5)**, **pulseaudio(1)**, **pactl(1)**, **default.pa(5)**
