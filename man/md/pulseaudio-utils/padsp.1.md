# padsp(1) - PulseAudio OSS Wrapper

Manuals, User

```
padsp [options] PROGRAM [ARGUMENTS ...]
</synopsis>

<synopsis>
padsp -h 
```

<a name="description"></a>

# Description

_padsp_ starts the specified program and redirects its access to OSS compatible audio devices (_/dev/dsp_ and auxiliary devices) to a PulseAudio sound server.

_padsp_ uses the $LD_PRELOAD environment variable that is interpreted by **ld.so(8)** and thus does not work for SUID binaries and statically built executables.

Equivalent to using _padsp_ is starting an application with $LD_PRELOAD set to _libpulsedsp.so_

<a name="options"></a>

# Options


* **-h | --help**  
  Show help.
* **-s** _SERVER_  
  Set the PulseAudio server to connect to.
* **-n** _NAME_  
  The client application name that shall be passed to the server when connecting.
* **-m** _NAME_  
  The stream name that shall be passed to the server when creating a stream.
* **-M**  
  Disable _/dev/mixer_ emulation.
* **-S**  
  Disable _/dev/sndstat_ emulation.
* **-D**  
  Disable _/dev/dsp_ emulation.
* **-d**  
  Enable debug output.

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**pulseaudio(1)**, **pasuspender(1)**, **ld.so(8)**
