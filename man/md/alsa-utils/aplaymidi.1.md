# aplaymidi(1) - play Standard MIDI Files

2 Nov 2011

```
aplaymidi -p client:port[,...] [-d delay] midifile ...
```


<a name="description"></a>

# Description

**aplaymidi**
is a command-line utility that plays the specified MIDI file(s) to one
or more ALSA sequencer ports.


<a name="options"></a>

# Options



* _-h, --help_  
  Prints a list of options.
  
* _-V, --version_  
  Prints the current version.
  
* _-l, --list_  
  Prints a list of possible output ports.
  
* _-p, --port=client:port,..._  
  Sets the sequencer port(s) to which the events in the MIDI file(s) are
  sent.
  
  A client can be specified by its number, its name, or a prefix of its
  name. A port is specified by its number; for port 0 of a client, the
  ":0" part of the port specification can be omitted.
  
  Multiple ports can be specified to allow playback of MIDI file(s) that
  contain events for multiple devices (ports), as specified by "Port
  Number" meta events.
  
  For compatibility with
  **pmidi(1),**
  the port specification is taken from the
  _ALSA_OUTPUT_PORTS_
  environment variable if none is given on the command line.
  
* _-d, --delay=seconds_  
  Specifies how long to wait after the end of each MIDI file,
  to allow the last notes to die away.
  

<a name="bugs"></a>

# Bugs

**aplaymidi**
handles "Port Number" meta events, but not "Port Name" meta events.


<a name="see-also"></a>

# See Also

pmidi(1)  
playmidi(1)


<a name="author"></a>

# Author

Clemens Ladisch &lt;[clemens@ladisch.de](mailto:clemens@ladisch.de)&gt;
