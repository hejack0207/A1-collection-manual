# alsactl(1) - advanced controls for ALSA soundcard driver

07 May 2014

```
alsactl [options] [store|restore|init] <card # or id or device>
</synopsis>

<synopsis>
alsactl monitor <card # or id>
```


<a name="description"></a>

# Description

**alsactl** is used to control advanced settings for the ALSA
soundcard drivers. It supports multiple soundcards. If your card has
features that you can't seem to control from a mixer application,
you have come to the right place.


<a name="commands"></a>

# Commands


_store_ saves the current driver state for the selected soundcard
to the configuration file.

_restore_ loads driver state for the selected soundcard from the
configuration file. If restoring fails (eventually partly), the init
action is called.

_nrestore_ is like _restore_, but it notifies also the daemon
to do new rescan for available soundcards.

_init_ tries to initialize all devices to a default state. If device
is not known, error code 99 is returned.

_daemon_ manages to save periodically the sound state.

_rdaemon_ like _daemon_ but restore the sound state at first.

_kill_ notifies the daemon to do the specified operation (quit,
rescan, save_and_quit).

_monitor_ is for monitoring the events received from the given
control device.

If no soundcards are specified, setup for all cards will be saved,
loaded or monitored.


<a name="options"></a>

# Options



* _-h, --help_   
  Help: show available flags and commands.
  
* _-d, --debug_  
  Use debug mode: a bit more verbose.
  
* _-v, --version_  
  Print alsactl version number.
  
* _-f, --file_  
  Select the configuration file to use. The default is /var/lib/alsa/asound.state.
  
* _-l, --lock_  
  Use the file locking to serialize the concurrent access to the state file (this
  option is default for the global state file).
  
* _-L, --no-lock_  
  Do not use the file locking to serialize the concurrent access to the state
  file (including the global state file).
  
* _-O, --lock-state-file_  
  Select the state lock file path.
  
* _-F, --force_  
  Used with restore command.  Try to restore the matching control elements
  as much as possible.  This option is set as default now.
  
* _-g, --ignore_  
  Used with store and restore commands. Do not show 'No soundcards found'
  and do not set an error exit code when soundcards are not installed.
  
* _-P, --pedantic_  
  Used with restore command.  Don't restore mismatching control elements.
  This option was the old default behavior.
  
* _-I, --no-init-fallback_  
  Don't initialize cards if restore fails.  Since version 1.0.18,
  **alsactl** tries to initialize the card with the restore operation
  as default.  But this can cause incompatibility with the older version.
  The caller may expect that the state won't be touched if no state file
  exists.  This option takes the restore behavior back to the older
  version by suppressing the initialization.
  
* _-r, --runstate_  
  Save restore and init state to this file. The file will contain only errors.
  Errors are appended with the soundcard id to the end of file.
  
* _-R, --remove_  
  Remove runstate file at first.
  
* _-E, --env_ #=#  
  Set environment variable (useful for init action or you may override
  ALSA_CONFIG_PATH to read different or optimized configuration - may be
  useful for "boot" scripts).
  
* _-i, --initfile_  
  The configuration file for init. By default, PREFIX/share/alsa/init/00main
  is used.
  
* _-p, --period_  
  The store period in seconds for the daemon command.
  
* _-e, --pid-file_  
  The pathname to store the process-id file in the HDB UUCP format (ASCII).
  
* _-b, --background_  
  Run the task in background.
  
* _-s, --syslog_  
  Use syslog for messages.
  
* _-n, --nice_  
  Set the process priority (see 'man nice')
  
* _-c, --sched-idle_  
  Set the process scheduling policy to idle (SCHED_IDLE).
  
* _-D, --ucm-defaults_  
  Execute also the 'defaults' section from the UCM configuration. The standard
  behaviour is to execute only 'once' section.
  

<a name="files"></a>

# Files

_/var/lib/alsa/asound.state_ (or whatever file you specify with the
**-f** flag) is used to store current settings for your
soundcards. The settings include all the usual soundcard mixer
settings.  More importantly, alsactl is
capable of controlling other card-specific features that mixer apps
usually don't know about.

The configuration file is generated automatically by running
**alsactl store**. Editing the configuration file by hand may be
necessary for some soundcard features (e.g. enabling/disabling
automatic mic gain, digital output, joystick/game ports, some future MIDI
routing options, etc).


<a name="see-also"></a>

# See Also


amixer(1),
alsamixer(1),
aplay(1),
alsactl_init(7)



<a name="bugs-"></a>

# Bugs 

None known.


<a name="author"></a>

# Author

**alsactl** is by Jaroslav Kysela &lt;[perex@perex.cz](mailto:perex@perex.cz)&gt; and Abramo Bagnara
&lt;[abramo@alsa-project.org](mailto:abramo@alsa-project.org)&gt;. This document is by Paul Winkler &lt;zarmzarm@erols.com&gt;.
