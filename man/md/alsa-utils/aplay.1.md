# aplay(1) - command\-line sound recorder and player for ALSA 

1 January 2010

soundcard driver

<a name="synopsis"></a>

# Synopsis

```
arecord [flags] [filename]
aplay [flags] [filename [filename]] ...
```


<a name="description"></a>

# Description

**arecord** is a command-line soundfile recorder for the ALSA soundcard
driver. It supports several file formats and multiple soundcards with
multiple devices. If recording with interleaved mode samples the file is
automatically split before the 2GB filesize.

**aplay** is much the same, only it plays instead of recording. For
supported soundfile formats, the sampling rate, bit depth, and so
forth can be automatically determined from the soundfile header.

If filename is not specified, the standard output or input is used. The **aplay** utility accepts multiple filenames.


<a name="options"></a>

# Options


* _-h, --help_  
  Help: show syntax.
* _--version_  
  Print current version.
* _-l, --list-devices_  
  List all soundcards and digital audio devices
* _-L, --list-pcms_  
  List all PCMs defined
* _-D, --device=NAME_  
  Select PCM by name
* _-q --quiet_  
  Quiet mode. Suppress messages (not sound :))
* _-t, --file-type TYPE_  
  File type (voc, wav, raw or au).
  If this parameter is omitted the WAVE format is used.
* _-c, --channels=#_  
  The number of channels.
  The default is one channel.
  Valid values are 1 through 32.
* _-f --format=FORMAT_  
  Sample format  
  Recognized sample formats are: S8 U8 S16_LE S16_BE U16_LE U16_BE S24_LE
  S24_BE U24_LE U24_BE S32_LE S32_BE U32_LE U32_BE FLOAT_LE FLOAT_BE
  FLOAT64_LE FLOAT64_BE IEC958_SUBFRAME_LE IEC958_SUBFRAME_BE MU_LAW
  A_LAW IMA_ADPCM MPEG GSM SPECIAL S24_3LE S24_3BE U24_3LE U24_3BE S20_3LE
  S20_3BE U20_3LE U20_3BE S18_3LE S18_3BE U18_3LE  
  Some of these may not be available on selected hardware  
  The available format shortcuts are:
    -f cd (16 bit little endian, 44100, stereo) [-f S16_LE -c2 -r44100]
    -f cdr (16 bit big endian, 44100, stereo) [-f S16_BE -c2 -f44100]
    -f dat (16 bit little endian, 48000, stereo) [-f S16_LE -c2 -r48000]
  If no format is given U8 is used.
* _-r, --rate=#&lt;Hz&gt;_  
  Sampling rate in Hertz. The default rate is 8000 Hertz.
  If the value specified is less than 300, it is taken as the rate in kilohertz.
  Valid values are 2000 through 192000 Hertz.
* _-d, --duration=#_  
  Interrupt after # seconds.
  A value of zero means infinity.
  The default is zero, so if this option is omitted then the record/playback process will run until it is killed.
  Either '-d' or '-s' option is available exclusively.
* _-s, --samples=#_  
  Interrupt after tranmission of # PCM frames.
  A value of zero means infinity.
  The default is zero, so if this options is omitted then the record/playback process will run until it is killed.
  Either '-d' or '-s' option is available exclusively.
* _-M, --mmap_              
  Use memory-mapped (mmap) I/O mode for the audio stream.
  If this option is not set, the read/write I/O mode will be used.
* _-N, --nonblock_            
  Open the audio device in non-blocking mode. If the device is busy the program will exit immediately.
  If this option is not set the program will block until the audio device is available again.
* _-F, --period-time=#_       
  Distance between interrupts is # microseconds.
  If no period time and no period size is given then a quarter of the buffer time is set.
* _-B, --buffer-time=#_       
  Buffer duration is # microseconds
  If no buffer time and no buffer size is given then the maximal allowed buffer time but not more than 500ms is set.
* _--period-size=#_       
  Distance between interrupts is # frames
  If no period size and no period time is given then a quarter of the buffer size is set.
* _--buffer-size=#_       
  Buffer duration is # frames
  If no buffer time and no buffer size is given then the maximal allowed buffer time but not more than 500ms is set.
* _-A, --avail-min=#_         
  Min available space for wakeup is # microseconds
* _-R, --start-delay=#_       
  Delay for automatic PCM start is # microseconds 
  (relative to buffer size if &lt;= 0)
* _-T, --stop-delay=#_        
  Delay for automatic PCM stop is # microseconds from xrun
* _-v, --verbose_             
  Show PCM structure and setup.
  This option is accumulative.  The VU meter is displayed when this
  is given twice or three times.
* _-V, --vumeter=TYPE_  
  Specifies the VU-meter type, either _stereo_ or _mono_.
  The stereo VU-meter is available only for 2-channel stereo samples
  with interleaved format.
* _-I, --separate-channels_   
  One file for each channel.  This option disables max-file-time
  and use-strftime, and ignores SIGUSR1.  The stereo VU meter is
  not available with separate channels.
* _-P_  
  Playback.  This is the default if the program is invoked
  by typing aplay.
* _-C_  
  Record.  This is the default if the program is invoked
  by typing arecord.
* _-i, --interactive_  
  Allow interactive operation via stdin.
  Currently only pause/resume via space or enter key is implemented.
* _-m, --chmap=ch1,ch2,..._  
  Give the channel map to override or follow.  Pass channel position
  strings like _FL_, _FR_, etc.
  
  If a device supports the override of the channel map, **aplay**
  tries to pass the given channel map.
  If it doesn't support the channel map override but still it provides
  the channel map information, **aplay** tries to rearrange the
  channel order in the buffer to match with the returned channel map
  from the device.
* _--disable-resample_  
  Disable automatic rate resample.
* _--disable-channels_  
  Disable automatic channel conversions.
* _--disable-format_  
  Disable automatic format conversions.
* _--disable-softvol_  
  Disable software volume control (softvol).
* _--test-position_  
  Test ring buffer position.
* _--test-coef=&lt;coef&gt;_  
  Test coefficient for ring buffer position; default is 8.
  Expression for validation is: coef * (buffer_size / 2).
  Minimum value is 1.
* _--test-nowait_  
  Do not wait for the ring buffer - eats the whole CPU.
* _--max-file-time_  
  While recording, when the output file has been accumulating
  sound for this long,
  close it and open a new output file.  Default is the maximum
  size supported by the file format: 2 GiB for WAV files.
  This option has no effect if  --separate-channels is
  specified.
* _--process-id-file &lt;file name&gt;_  
  aplay writes its process ID here, so other programs can
  send signals to it.
* _--use-strftime_  
  When recording, interpret %-codes in the file name parameter using
  the strftime facility whenever the output file is opened.  The
  important strftime codes are: %Y is the year, %m month, %d day of
  the month, %H hour, %M minute and %S second.  In addition, %v is
  the file number, starting at 1.  When this option is specified,
  intermediate directories for the output file are created automatically.
  This option has no effect if --separate-channels is specified.
* _--dump-hw-params_  
  Dump hw_params of the device preconfigured status to stderr. The dump
  lists capabilities of the selected device such as supported formats,
  sampling rates, numbers of channels, period and buffer bytes/sizes/times.
  For raw device hw:X this option basically lists hardware capabilities of
  the soundcard.
* _--fatal-errors_  
  Disables recovery attempts when errors (e.g. xrun) are encountered; the
  aplay process instead aborts immediately.
  

<a name="signals"></a>

# Signals

When recording, SIGINT, SIGTERM and SIGABRT will close the output 
file and exit.  SIGUSR1 will close the output file, open a new one,
and continue recording.  However, SIGUSR1 does not work with
--separate-channels.


<a name="examples"></a>

# Examples



* **aplay -c 1 -t raw -r 22050 -f mu_law foobar**  
  will play the raw file "foobar" as a
  22050-Hz, mono, 8-bit, Mu-Law .au file. 
  
* **arecord -d 10 -f cd -t wav -D copy foobar.wav**  
  will record foobar.wav as a 10-second, CD-quality wave file, using the
  PCM "copy" (which might be defined in the user's .asoundrc file as:
    pcm.copy {
      type plug
      slave {
        pcm hw
      }
      route_policy copy
    }
  
* **arecord -t wav --max-file-time 30 mon.wav**  
  Record from the default audio source in monaural, 8,000 samples
  per second, 8 bits per sample.  Start a new file every
  30 seconds.  File names are mon-nn.wav, where nn increases
  from 01.  The file after mon-99.wav is mon-100.wav.
  
* **arecord -f cd -t wav --max-file-time 3600 --use-strftime %Y/%m/%d/listen-%H-%M-%v.wav**  
  Record in stereo from the default audio source.  Create a new file
  every hour.  The files are placed in directories based on their start dates
  and have names which include their start times and file numbers.
  

<a name="see-also"></a>

# See Also


alsamixer(1),
amixer(1)



<a name="bugs-"></a>

# Bugs 

Note that .aiff files are not currently supported.


<a name="author"></a>

# Author

**arecord** and **aplay** are by Jaroslav Kysela &lt;[perex@perex.cz](mailto:perex@perex.cz)&gt;
This document is by Paul Winkler &lt;[zarmzarm@erols.com](mailto:zarmzarm@erols.com)&gt;.
Updated for Alsa 0.9 by James Tappin &lt;[james@xena.uklinux](mailto:james@xena.uklinux).net&gt;

