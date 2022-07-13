# pulse-cli-syntax(5) - PulseAudio Command Line Interface Syntax

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

PulseAudio provides a simple command line language used by configuration scripts, the pacmd interactive shell, and the modules module-cli and module-cli-protocol-{unix,tcp}. Empty lines and lines beginning with a hashmark (#) are silently ignored. Several commands are supported. 

Note that any boolean arguments can be given positively as '1', 't', 'y', 'true', 'yes' or 'on'. Likewise, negative values can be given as '0', 'f', 'n', 'false', 'no' or 'off'. Case is ignored. 

<a name="general-commands"></a>

# General Commands


* **help**  
  Show a quick help on the commands available.

<a name="status-commands"></a>

# Status Commands


* **list-modules**  
  Show all currently loaded modules with their arguments.
* **list-cards**  
  Show all currently registered cards
* **list-sinks** or **list-sources**  
  Show all currently registered sinks (resp. sources).
* **list-clients**  
  Show all currently active clients.
* **list-sink-inputs** or **list-source-outputs**  
  Show all currently active inputs to sinks a.k.a. playback streams (resp. outputs of sources a.k.a. recording streams).
* **stat**  
  Show some simple statistics about the allocated memory blocks and the space used by them.
* **info** or **ls** or **list**  
  A combination of all status commands described above (all three commands are synonyms).

<a name="module-management"></a>

# Module Management


* **load-module** _name_ [_arguments..._]  
  Load a module specified by its name and arguments. For most modules it is OK to be loaded more than once.
* **unload-module** _index|name_  
  Unload a module, specified either by its index in the module list or its name.
* **describe-module** _name_  
  Give information about a module specified by its name.

<a name="volume-commands"></a>

# Volume Commands


* **set-sink-volume|set-source-volume** _index|name_ _volume_  
  Set the volume of the specified sink (resp. source). You may specify the sink (resp. source) either by its index in the sink/source list or by its name. The volume should be an integer value greater or equal than 0 (muted). Volume 65536 (0x10000) is 'normal' volume a.k.a. 100%. Values greater than this amplify the audio signal (with clipping).
* **set-sink-mute|set-source-mute** _index|name_ _boolean_  
  Mute or unmute the specified sink (resp. source). You may specify the sink (resp. source) either by its index or by its name. The mute value is either 0 (not muted) or 1 (muted).
* **set-sink-input-volume|set-source-output-volume** _index_ _volume_  
  Set the volume of a sink input (resp. source output) specified by its index. The same volume rules apply as with set-sink-volume.
* **set-sink-input-mute|set-source-output-mute** _index_ _boolean_  
  Mute or unmute a sink input (resp. source output) specified by its index. The same mute rules apply as with set-sink-mute.

<a name="configuration-commands"></a>

# Configuration Commands


* **set-default-sink|set-default-source** _index|name_  
  Make a sink (resp. source) the default. You may specify the sink (resp. source) by its index in the sink (resp. source) list or by its name.
  
  Note that defaults may be overridden by various policy modules or by specific stream configurations.
* **set-card-profile** _index|name_ _profile-name_  
  Change the profile of a card.
* **set-sink-port|set-source-port** _index|name_ _port-name_  
  Change the profile of a sink (resp. source).
* **set-port-latency-offset** _card-index|card-name_ _port-name_ _offset_  
  Change the latency offset of a port belonging to the specified card
* **suspend-sink|suspend-source** _name|index_ _true|false_  
  Suspend or resume the specified sink or source (which may be specified either by its name or index), depending whether true (suspend) or false (resume) is passed as last argument. Suspending a sink will pause all playback and suspending a source will pause all capturing. Depending on the module implementing the sink or source this might have the effect that the underlying device is closed, making it available for other applications to use. The exact behaviour depends on the module. 
* **suspend** _boolean_  
  Suspend all sinks and sources.

<a name="moving-streams"></a>

# Moving Streams


* **move-sink-input|move-source-output** _index_ _sink-index|sink-name_  
  Move sink input (resp. source output) to another sink (resp. source).

<a name="property-lists"></a>

# Property Lists


* **update-sink-proplist|update-source-proplist** _index|name_ _properties_  
  Update the properties of a sink (resp. source) specified by name or index. The property is specified as e.g. device.description="My Preferred Name"
* **update-sink-input-proplist|update-source-output-proplist** _index_ _properties_  
  Update the properties of a sink input (resp. source output) specified by index. The properties are specified as above.

<a name="sample-cache"></a>

# Sample Cache


* **list-samples**  
  Lists the contents of the sample cache.
* **play-sample** _name_ _sink-index|sink-name_  
  Play a sample cache entry to a sink.
* **remove-sample** _name_  
  Remove an entry from the sample cache.
* **load-sample** _name_ _filename_  
  Load an audio file to the sample cache.
* **load-sample-lazy** _name_ _filename_  
  Create a new entry in the sample cache, but don't load the sample immediately. The sample is loaded only when it is first used. After a certain idle time it is freed again.
* **load-sample-dir-lazy** _path_  
  Load all entries in the specified directory into the sample cache as lazy entries. A shell globbing expression (e.g. *.wav) may be appended to the path of the directory to add.

<a name="killing-clientsstreams"></a>

# Killing Clients/Streams


* **kill-client** _index_  
  Remove a client forcibly from the server. There is no protection against the client reconnecting immediately.
* **kill-sink-input|kill-source-output** _index_  
  Remove a sink input (resp. source output) forcibly from the server. This will not remove the owning client or any other streams opened by the same client from the server.

<a name="log-commands"></a>

# Log Commands


* **set-log-level** _numeric-level_  
  Change the log level.
* **set-log-meta** _boolean_  
  Show source code location in log messages.
* **set-log-target** _target_  
  Change the log target (null, auto, journal, syslog, stderr, file:PATH, newfile:PATH).
* **set-log-time** _boolean_  
  Show timestamps in log messages.
* **set-log-backtrace** _num-frames_  
  Show backtrace in log messages.

<a name="miscellaneous-commands"></a>

# Miscellaneous Commands


* **play-file** _filename_ _sink-index|sink-name_  
  Play an audio file to a sink.
* **dump**  
  Dump the daemon's current configuration in CLI commands.
* **dump-volumes**  
  Debug: Shows the current state of all volumes.
* **shared**  
  Debug: Show shared properties.
* **exit**  
  Terminate the daemon. If you want to terminate a CLI connection ("log out") you might want to use ctrl+d

<a name="meta-commands"></a>

# Meta Commands

In addition to the commands described above there are a few meta directives supported by the command line interpreter. 

* **.include** _filename|folder_  
  Executes the commands from the specified script file or in all of the *.pa files within the folder.
* **.fail** and **.nofail**  
  Enable (resp. disable) that following failing commands will cancel the execution of the current script file. This is ignored when used on the interactive command line.
* **.ifexists** _filename_  
  Execute the subsequent block of commands only if the specified file exists. Typically _filename_ indicates a module. Relative paths are resolved using the module directory as the base. By using an absolute path, the existance of other files can be checked as well.
* **.else** and **.endif**  
  A block of commands is delimited by an **.else** or **.endif** meta command. Nesting conditional commands is not supported.

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**default.pa(5)**, **pacmd(1)**, **pulseaudio(1)**
