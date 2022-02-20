# dvbv5-zap(1) - DVBv5 tool for service tuning

DVBv5 Utils 1.16.7, Fri Oct 3 2014

```
dvbv5-zap [OPTION]... channel-name 
 dvbv5-zap [OPTION]... frequency-name (for monitor or all PIDs mode)
```

<a name="description"></a>

# Description

dvbv5-zap is a command line tuning tool for digital TV services that is
compliant with version 5 of the DVB API, and backward compatible with the
older v3 DVB API.

dvbv5-zap uses by default a new channel/service file format that it is
capable of supporting all types of Digital TV standards. It can also support
the legacy format used by the legacy dvb-apps.

The dvbv5-zap tool can be used on several different modes, depending
on the parameters used.

Please note that, in order to be able to use it in record mode, where both
the audio and video Packet IDs (PIDs) are output to a dvr record node,
the input file should contain the PIDs, e. g. they should have been produced
by a digital TV zap application like dvbv5-zap.

<a name="options"></a>

# Options


* **-c**, **--channels**= **channel-name-file**  
  Read channels list from 'file'.
  Defaults to **~/.tzap/channels.conf**.
* **-3**, **--dvbv3**  
  Force dvbv5-zap to use DVBv3 only.
  Useful to test if the legacy API support is working.
* **-a**, **--adapter**=_adapter#_  
  Use the given adapter. Default value: 0.
* **-A**, **--audio\_pid**=_audio\_pid#_  
  Select a different audio Packet ID (PID).
  The default is to use the first audio PID found at the **channel-name-file**.
* **-C**, **--cc**=_country\_code_  
  Set the default country to be used by the MPEG-TS parsers, in ISO 3166-1 two
  letter code. If not specified, the default charset is guessed from the
  locale environment variables.
* **-d**, **--demux**=_demux#_  
  Use the given demux. Default value: 0.
* **-f**, **--frontend**=_frontend#_  
  Use the given frontend. Default value: 0.
* **-I**, **--input-format**=_format_  
  Format of the input file. Please notice that caps is ignored. It can be:
    * _channel_         - for dvb-apps compatible channel file;  

_zap_             - for dvb-apps compatible zap file;

_dvbv5_ (default) - for the dvbv5 apps format.

* **-l**, **--lnbf**=_LNBf\_type_  
  Type of LNBf to use 'help' lists the available ones.
* **-L**, **--search**=_string_  
  Search/look for a string inside the traffic.
  Used only on monitor mode.
* **-m**, **--monitor**  
  Enable monitor mode. On this mode, it will monitor de DVB traffic for all
  Packet IDs (PIDs) received by the device, showing the Packet IDs (optionally
  filtered by a _string_), and presenting some traffic statistics:
  number of packets per second, number of Kbytes per second and total traffic.
  Those statistics are shown per PID and the total per MPEG-TS.
* **-o**, **--output**=_file_  
  Output filename. If specified, it will output the content of the MPEG-TS into
  the file with the first video PID and the first audio PID (or the one specified
  by _audio\_pid#_).
  Use **-o** - for directing the output to **stdout**.
* **-p**, **--pat**  
  Add PAT and PMT MPEG-TS tables to TS recording (implies **-r)**.
* **-P**, **--all-pids**  
  Don't filter any pids. Instead, outputs all of them.
* **-r**, **--record**  
  Sets up the /dev/dvb/adapter_adapter#_/dvr0 for MPEG-TS record.
* **-s**, **--silence**  
  Increases silence (can be used more than once).
* **-S**, **--sat\_number**=_satellite\_number_  
  Satellite number.
  Used only on satellite delivery systems.
  If not specified, disable DISEqC satellite switch.
* **-t**, **--timeout**=_seconds_  
  Amount of seconds to keep the tool running for zapping and for recording.
  Useful if you want to record a program that you know its duration.
* **-U**, **--freq\_bpf**=_frequency_  
  SCR/Unicable band-pass filter frequency to use, in kHz.
  Used only on satellite delivery systems.
* **-v**, **--verbose**  
  Be verbose. Useful to check if the MPEG-TS is happenning fine.
  This option can be used multiple times to increase verbosity.
* **-V**, **--video\_pid**=_video\_pid#_  
  video pid program to use (default 0)
* **-w**, **--lna**=_LNA_  
  Enable, disable or put LNA power in auto mode. Not all frontends support it.
  Valid values are:
    *  0 - disable  
    *  1 - enable  
    * -1 - auto  
* **-W**, **--wait**=_time_  
  Adds additional wait time for DISEqC command completion.
* **-x**, **--exit**  
  Exit after tuning.
* **-X**, **--low\_traffic**  
  Also shows DVB traffic with less then 1 packet per second.
  Used only in monitor mode.
* **-?**, **--help**  
  Outputs the usage help.
* **--usage**  
  Gives a short usage message.
* **--version**  
  Prints program version.

<a name="exit-status"></a>

# Exit Status

On success, it returns 0.

<a name="examples"></a>

# Examples


<a name="recording-a-channel"></a>

### Recording a channel


The typical use is to tune into a channel and put it into record mode:

    $ dvbv5-zap -c dvb_channel.conf 'music' -r
    using demux '/dev/dvb/adapter0/demux0'
    reading channels from file 'dvb_channel.conf'
    service has pid type 05: 204
    tuning to 573000000 Hz
    audio pid 104
    dvb_set_pesfilter 104
    Lock (0x1f) Quality= Good Signal= 100.00% C/N= -13.80dB UCB= 70 postBER= 3.14x10^-3 PER= 0
    DVR interface '/dev/dvb/adapter0/dvr0' can now be opened

The channel can be watched by playing the contents of the DVR interface,
with some player that recognizes the MPEG-TS format.

For example, this audio-only channel can be played with mplayer:

    $ mplayer -cache 800 /dev/dvb/adapter0/dvr0
    MPlayer SVN-r37077-4.8.2 (C) 2000-2014 MPlayer Team
    TS file format detected.
    NO VIDEO! AUDIO MPA(pid=104) NO SUBS (yet)!  PROGRAM N. 0
    ==================================================================
    Opening audio decoder: [mpg123] MPEG 1.0/2.0/2.5 layers I, II, III
    AUDIO: 48000 Hz, 2 ch, s16le, 192.0 kbit/12.50% (ratio: 24000->192000)
    Selected audio codec: [mpg123] afm: mpg123 (MPEG 1.0/2.0/2.5 layers I, II, III)
    ==================================================================
    AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
    Video: no video
    Starting playback...

<a name="monitoring-a-channel"></a>

### Monitoring a channel


The dvbv5-zap tool can also be used to monitor a DVB channel:

    $ dvbv5-zap -c dvb_channel.conf 573000000 -m
    using demux '/dev/dvb/adapter0/demux0'
    reading channels from file 'dvb_channel.conf'
    service has pid type 05:  204
    tuning to 573000000 Hz
    Lock   (0x1f) Quality= Good Signal= 100.00% C/N= -13.90dB UCB= 384 postBER= 96.8x10^-6 PER= 0
      dvb_set_pesfilter to 0x2000
    
    PID     FREQ    SPEED   TOTAL
    0000    9.88 p/s        14.5 Kbps       1 KB
    0001    1.98 p/s        2.9 Kbps        376 B
    0010    18.77 p/s       27.6 Kbps       3 KB
    0011    48.42 p/s       71.1 Kbps       8 KB
    0012    1455.53 p/s     2137.8 Kbps     270 KB
    .schar … ...
    …
    1fff    1033.60 p/s     1518.1 Kbps     192 KB
    TOT     25296.44 p/s    37154.2 Kbps    4700 KB
    
    Lock   (0x1f) Quality= Good Signal= 100.00% C/N= -13.90dB UCB= 384 postBER= 96.8x10^-6 PER= 0

<a name="bugs"></a>

# Bugs

Report bugs to **Linux Media Mailing List &lt;linux-media@vger.kernel.org&gt;**

<a name="copyright"></a>

# Copyright

Copyright (c) 2011-2014 by Mauro Carvalho Chehab.

License GPLv2: GNU GPL version 2 &lt;http://gnu.org/licenses/gpl.html&gt;.  
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
