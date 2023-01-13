# alsaloop(1) - command\-line PCM loopback

5 Aug 2010

```
alsaloop [-option] [cmd]
```

<a name="description"></a>

# Description


**alsaloop** allows create a PCM loopback between a PCM capture device
and a PCM playback device.

**alsaloop** supports multiple soundcards, adaptive clock synchronization,
adaptive rate resampling using the samplerate library (if available in
the system). Also, mixer controls can be redirected from one card to
another (for example Master and PCM).


<a name="options"></a>

# Options



* _-h_ | _--help_  
  
  Prints the help information.
  
* _-g &lt;file&gt;_ | _--config=&lt;file&gt;_  
  
  Use given configuration file. The syntax of this file is simple: one line
  contains the command line options for one job. The '#' means comment and
  rest of line is ignored. Example:
  
    # First line - comment, second line - first job
    -C hw:1,0 -P hw:0,0 -t 50000 -T 1
    # Third line - comment, fourth line - second job
    -C hw:1,1 -P hw:0,1 -t 40000 -T 2
  
* _-d_ | _--daemonize_  
  
  Daemonize the main process and use syslog for messages.
  
* _-P &lt;device&gt;_ | _--pdevice=&lt;device&gt;_  
  
  Use given playback device.
  
* _-C &lt;device&gt;_ | _--cdevice=&lt;device&gt;_  
  
  Use given capture device.
  
* _-X &lt;device&gt;_ | _--pctl=&lt;device&gt;_  
  
  Use given CTL device for playback.
  
* _-Y &lt;device&gt;_ | _--cctl=&lt;device&gt;_  
  
  Use given CTL device for capture.
  
* _-l &lt;latency&gt;_ | _--latency=&lt;frames&gt;_  
  
  Requested latency in frames.
  
* _-t &lt;usec&gt;_ | _--tlatency=&lt;usec&gt;_  
  
  Requested latency in usec (1/1000000sec).
  
* _-f &lt;format&gt;_ | _--format=&lt;format&gt;_  
  
  Format specification (usually S16_LE S32_LE). Use -h to list all formats.
  Default format is S16_LE.
  
* _-c &lt;channels&gt;_ | _--channels=&lt;channels&gt;_  
  
  Channel count specification. Default value is 2.
  
* _-c &lt;rate&gt;_ | _--rate=&lt;rate&gt;_  
  
  Rate specification. Default value is 48000 (Hz).
  
* _-n_ | _--resample_  
  
  Allow rate resampling using alsa-lib.
  
* _-A &lt;converter&gt;_ | _--samplerate=&lt;converter&gt;_  
  
  Use libsamplerate and choose a converter:
  
    0 or sincbest     - best quality
    1 or sincmedium   - medium quality
    2 or sincfastest  - lowest quality
    3 or zerohold     - hold zero samples
    4 or linear       - worst quality - linear resampling
    5 or auto         - choose best method
  
* _-B &lt;size&gt;_ | _--buffer=&lt;size&gt;_  
  
  Buffer size in frames.
  
* _-E &lt;size&gt;_ | _--period=&lt;size&gt;_  
  
  Period size in frames.
  
* _-s &lt;secs&gt;_ | _--seconds=&lt;secs&gt;_  
  
  Duration of loop in seconds.
  
* _-b_ | _--nblock_  
  
  Non-block mode (very early process wakeup). Eats more CPU.
  
* _-S &lt;mode&gt;_ | _--sync=&lt;mode&gt;_  
  
  Sync mode specification for capture to playback stream:
    0 or none       - do not touch the stream
    1 or simple     - add or remove samples to keep
                      both streams synchronized
    2 or captshift  - use driver for the capture device
                      (if supported) to compensate
                      the rate shift
    3 or playshift  - use driver for the playback device
                      (if supported) to compensate
                      the rate shift
    4 or samplerate - use samplerate library to do rate resampling
    5 or auto       - automatically selects the best method
                      in this order: captshift, playshift,
                      samplerate, simple
  
* _-T &lt;num&gt;_ | _--thread=&lt;num&gt;_  
  
  Thread number (-1 means create a unique thread). All jobs with same
  thread numbers are run within one thread.
  
* _-m &lt;mixid&gt;_ | _--mixer=&lt;midid&gt;_  
  
  Redirect mixer control from the playback card to the capture card. Format of
  _mixid_ is SRCID(PLAYBACK)[@DSTID(PLAYBACK)]:
  
    "name='Master Playback Switch'@name='Another Switch'"
    "name='PCM Playback Volume'"
  
  Known attributes:
  
    name      - control ID name
    index     - control ID index
    device    - control ID device
    subdevice - control ID subdevice
    iface     - control ID interface
    numid     - control ID numid
  
* _-O &lt;ossmixid&gt;_ | _--ossmixer=&lt;midid&gt;_  
  
  Redirect mixer control from the OSS Mixer emulation layer (capture card)
  to the ALSA layer (capture card). Format of _ossmixid_ is
  ALSAID[,INDEX]@OSSID:
  
    "Master@VOLUME"
    "PCM,1@ALTPCM"
  
  Known OSS attributes:
  
    VOLUME, BASS, TREBLE, SYNTH, PCM, SPEAKER, LINE, MIC, CD, IMIX, ALTPCM,
    RECLEV, IGAIN, OGAIN, LINE1, LINE2, LINE3, DIGITAL1, DIGITAL2, DIGITAL3,
    PHONEIN, PHONEOUT, VIDEO, RADIO, MONITOR
  
* _-v_ | _--verbose_  
  
  Verbose mode. Use multiple times to increase verbosity.
  
  
* _-U_ | _--xrun_  
  
  Verbose xrun profiling.
  
* _-W &lt;timeout&gt;_ | _--wake=&lt;timeout&gt;_  
  
  Set process wake timeout.
  

<a name="examples"></a>

# Examples



* **alsaloop -C hw:0,0 -P hw:1,0 -t 50000**  
  

<a name="bugs"></a>

# Bugs

None known.

<a name="author"></a>

# Author

**alsaloop** is by Jaroslav Kysela &lt;[perex@perex.cz](mailto:perex@perex.cz)&gt;.
This document is by Jaroslav Kysela &lt;[perex@perex.cz](mailto:perex@perex.cz)&gt;.
