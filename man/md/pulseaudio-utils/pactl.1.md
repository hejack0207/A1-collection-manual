# pactl(1) - Control a running PulseAudio sound server

Manuals, User

```
pactl [options] COMMAND [ARGS ...]
</synopsis>

<synopsis>
pactl --help
</synopsis>

<synopsis>
pactl --version 
```

<a name="description"></a>

# Description

_pactl_ can be used to issue control commands to the PulseAudio sound server.

_pactl_ only exposes a subset of the available operations. For the full set use the **pacmd(1)**.

<a name="options"></a>

# Options


* **-h | --help**  
  Show help.
* **--version**  
  Show version information.
* **-s | --server**_=SERVER_  
  Choose the server to connect to.
* **-n | --client-name**_=NAME_  
  Specify the client name _pactl_ shall pass to the server when connecting.

<a name="commands"></a>

# Commands


* **stat**  
  Dump a few statistics about the memory usage of the PulseAudio daemon.
* **info**  
  Dump some info about the PulseAudio daemon.
* **list** [_short_] [_TYPE_]  
  Dump all currently loaded modules, available sinks, sources, streams, etc. _TYPE_ must be one of: modules, sinks, sources, sink-inputs, source-outputs, clients, samples, cards. If not specified, all info is listed. If short is given, output is in a tabular format, for easy parsing by scripts.
* **exit**  
  Asks the PulseAudio server to terminate.
* **upload-sample** _FILENAME_ [_NAME_]  
  Upload a sound from the specified audio file into the sample cache. The file types supported are those understood by _libsndfile_. The sample in the cache is named after the audio file, unless the name is explicitly specified.
* **play-sample** _NAME_ [_SINK_]  
  Play the specified sample from the sample cache. It is played on the default sink, unless the symbolic name or the numerical index of the sink to play it on is specified.
* **remove-sample** _NAME_  
  Remove the specified sample from the sample cache.
* **load-module** _NAME_ [_ARGUMENTS ..._]  
  Load the specified module with the specified arguments into the running sound server. Prints the numeric index of the module just loaded to STDOUT. You can use it to unload the module later.
* **unload-module** _ID|NAME_  
  Unload the module instance identified by the specified numeric index or unload all modules by the specified name.
* **move-sink-input** _ID_ _SINK_  
  Move the specified playback stream (identified by its numerical index) to the specified sink (identified by its symbolic name or numerical index).
* **move-source-output** _ID_ _SOURCE_  
  Move the specified recording stream (identified by its numerical index) to the specified source (identified by its symbolic name or numerical index).
* **suspend-sink** _SINK_ _true|false_  
  Suspend or resume the specified sink (which may be specified either by its name or index), depending whether true (suspend) or false (resume) is passed as last argument. Suspending a sink will pause all playback. Depending on the module implementing the sink this might have the effect that the underlying device is closed, making it available for other applications to use. The exact behaviour depends on the module. 
* **suspend-source** _SOURCE_ _true|false_  
  Suspend or resume the specified source (which may be specified either by its name or index), depending whether true (suspend) or false (resume) is passed as last argument. Suspending a source will pause all capturing. Depending on the module implementing the source this might have the effect that the underlying device is closed, making it available for other applications to use. The exact behaviour depends on the module. 
* **set-card-profile** _CARD_ _PROFILE_  
  Set the specified card (identified by its symbolic name or numerical index) to the specified profile (identified by its symbolic name).
* **set-default-sink** _SINK_  
  Make the specified sink (identified by its symbolic name) the default sink.
* **set-sink-port** _SINK_ _PORT_  
  Set the specified sink (identified by its symbolic name or numerical index) to the specified port (identified by its symbolic name).
* **set-default-source** _SOURCE_  
  Make the specified source (identified by its symbolic name) the default source.
* **set-source-port** _SOURCE_ _PORT_  
  Set the specified source (identified by its symbolic name or numerical index) to the specified port (identified by its symbolic name).
* **set-port-latency-offset** _CARD_ _PORT_ _OFFSET_  
  Set a latency offset to a specified port (identified by its symbolic name) that belongs to a card (identified by its symbolic name or numerical index). _OFFSET_ is a number which represents the latency offset in microseconds
* **set-sink-volume** _SINK_ _VOLUME [VOLUME ...]_  
  Set the volume of the specified sink (identified by its symbolic name or numerical index). _VOLUME_ can be specified as an integer (e.g. 2000, 16384), a linear factor (e.g. 0.4, 1.100), a percentage (e.g. 10%, 100%) or a decibel value (e.g. 0dB, 20dB). If the volume specification start with a + or - the volume adjustment will be relative to the current sink volume. A single volume value affects all channels; if multiple volume values are given their number has to match the sink's number of channels.
* **set-source-volume** _SOURCE_ _VOLUME [VOLUME ...]_  
  Set the volume of the specified source (identified by its symbolic name or numerical index). _VOLUME_ can be specified as an integer (e.g. 2000, 16384), a linear factor (e.g. 0.4, 1.100), a percentage (e.g. 10%, 100%) or a decibel value (e.g. 0dB, 20dB). If the volume specification start with a + or - the volume adjustment will be relative to the current source volume. A single volume value affects all channels; if multiple volume values are given their number has to match the source's number of channels.
* **set-sink-input-volume** _INPUT_ _VOLUME [VOLUME ...]_  
  Set the volume of the specified sink input (identified by its numerical index). _VOLUME_ can be specified as an integer (e.g. 2000, 16384), a linear factor (e.g. 0.4, 1.100), a percentage (e.g. 10%, 100%) or a decibel value (e.g. 0dB, 20dB). If the volume specification start with a + or - the volume adjustment will be relative to the current sink input volume. A single volume value affects all channels; if multiple volume values are given their number has to match the sink input's number of channels.
* **set-source-output-volume** _OUTPUT_ _VOLUME [VOLUME ...]_  
  Set the volume of the specified source output (identified by its numerical index). _VOLUME_ can be specified as an integer (e.g. 2000, 16384), a linear factor (e.g. 0.4, 1.100), a percentage (e.g. 10%, 100%) or a decibel value (e.g. 0dB, 20dB). If the volume specification start with a + or - the volume adjustment will be relative to the current source output volume. A single volume value affects all channels; if multiple volume values are given their number has to match the source output's number of channels.
* **set-sink-mute** _SINK_ _1|0|toggle_  
  Set the mute status of the specified sink (identified by its symbolic name or numerical index).
* **set-source-mute** _SOURCE_ _1|0|toggle_  
  Set the mute status of the specified source (identified by its symbolic name or numerical index).
* **set-sink-input-mute** _INPUT_ _1|0|toggle_  
  Set the mute status of the specified sink input (identified by its numerical index).
* **set-source-output-mute** _OUTPUT_ _1|0|toggle_  
  Set the mute status of the specified source output (identified by its numerical index).
* **set-sink-formats** _SINK_ _FORMATS_  
  Set the supported formats of the specified sink (identified by its numerical index) if supported by the sink. _FORMATS_ is specified as a semi-colon (;) separated list of formats in the form 'encoding[, key1=value1, key2=value2, ...]' (for example, AC3 at 32000, 44100 and 48000 Hz would be specified as 'ac3-iec61937, format.rate = "[ 32000, 44100, 48000 ]"'). 
* **subscribe**  
  Subscribe to events, pactl does not exit by itself, but keeps waiting for new events.

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**pulseaudio(1)**, **pacmd(1)**
