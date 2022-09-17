# pasuspender(1) - Temporarily suspend PulseAudio

Manuals, User

```
pasuspender [options] -- PROGRAM [ARGUMENTS ...]
</synopsis>

<synopsis>
pasuspender --help
</synopsis>

<synopsis>
pasuspender --version 
```

<a name="description"></a>

# Description

_pasuspender_ is a tool that can be used to tell a local PulseAudio sound server to temporarily suspend access to the audio devices, to allow other applications access them directly. _pasuspender_ will suspend access to the audio devices, fork a child process, and when the child process terminates, resume access again.

Make sure to include **--** in your _pasuspender_ command line before passing the subprocess command line (as shown above). Otherwise _pasuspender_ itself might end up interpreting the command line switches and options you intended to pass to the subprocess.

<a name="options"></a>

# Options


* **-h | --help**  
  Show help.
* **--version**  
  Show version information.
* **-s | --server=**_SERVER_  
  Specify the sound server to connect to.

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**pulseaudio(1)**, **padsp(1)**, **pacmd(1)**, **pactl(1)**
