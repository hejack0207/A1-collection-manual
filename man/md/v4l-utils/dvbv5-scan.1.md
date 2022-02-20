# dvbv5-scan(1) - DVBv5 tool for frequency scanning

DVBv5 Utils 1.16.7, Fri Oct 3 2014

```
dvbv5-scan [OPTION]... initial-file
```

<a name="description"></a>

# Description

dvbv5-scan is a command line frequency scanning tool for digital TV services
that is compliant with version 5 of the DVB API, and backward compatible with
the older v3 DVB API.

dvbv5-scan uses by default the new channel/service file format that it is
capable of supporting all types of Digital TV standards. It can also support
the legacy format used by the legacy dvb-apps.

A single physical channel (also called as transponder) may have several virtual
channels inside it, encapsulated via a MPEG Transport stream.

Those virtual channels are called as 'service' at the MPEG-TS terminology, and
may have one or more audio, video and other types of elements inside it.

The dvbv5-scan goal is to scan for a list of physical channels/transponders
and identify there the MPEG-TS services available.

The dvbv5-scan tool is smart enough to retrieve the information at the
MPEG-TS Network Information Table (NIT) about other channels available
on the stream.

<a name="options"></a>

# Options


* The following options are valid:  
* **-3**, **--dvbv3**  
  Force dvbv5-scan to use DVBv3 only.
* **-a**, **--adapter**=_adapter#_  
  Use the given adapter. Default value: 0.
* **-C**, **--cc**=_country\_code_  
  Set the default country to be used by the MPEG-TS parsers, in ISO 3166-1 two
  letter code. If not specified, the default charset is guessed from the
  locale environment variables.
* **-d**, **--demux**=_demux#_  
  Use the given demux. Default value: 0.
* **-f**, **--frontend**=_frontend#_  
  Use the given frontend. Default value: 0.
* **-F**, **--file-freqs-only**  
  Don't use the other frequencies discovered during scan. By default, dvbv5-scan
  will find new transponder/physical channels and add them at the internal
  frequency table it uses for scan. This option disables such feature.
* **-G**, **--get\_frontend**  
  Use data from get_frontend on the output file. By default, dvbv5-scan will
  repeat the same network parameters as found at the scan file. This should
  work fine if the output file will be used by the same frontend. However, if
  you intend to use the generated file on another frontend, or wants a faster
  tuner, this option can be used to store the actual detected parameters, instead
  of the ones that came from the source channel file.
* **-I**, **--input-format**=_format_  
  Format of the input file. Please notice that caps is ignored. It can be:
    * _channel_         - for dvb-apps compatible channel file;  

_zap_             - for dvb-apps compatible zap file;

_dvbv5_ (default) - for the dvbv5 apps format.

* **-l**, **--lnbf**=_LNBf\_type_  
  Type of LNBf to use 'help' lists the available ones.
* **-N**, **--nit**  
  Use data from NIT table on the output file. By default, dvbv5-scan will
  repeat the same network parameters as found at the scan file. This should
  work fine if the output file will be used by the same frontend. However, if
  you intend to use the generated file on another frontend, or wants a faster
  tuner, this option can be used to store the parameters that are announced
  by the broadcaster via the MPEG-TS Network Information Table (NIT), instead
  of the ones that came from the source channel file.
* **-o**, **--output**=_file_  
  output filename (default: **dvb\_channel.conf**)
* **-O**, **--output-format**=_format_  
  Output format:
    * _channel_         - for dvb-apps compatible channel file;  

_zap_             - for dvb-apps compatible zap file;

_vdr_             - for vdr compatible zap file;

_dvbv5_ (default) - for the dvbv5 apps format.

* **-p**, **--parse-other-nit**  
  Parse the other NIT/SDT tables that could be found mainly on some DVB-C
  carriers.
* **-S**, **--sat\_number**=_satellite\_number_  
  Satellite number.
  Used only on satellite delivery systems.
  If not specified, disable DISEqC satellite switch.
* **-T**, **--timeout-multiply**=_factor_  
  Multiply the scan lock wait time and MPEG-TS table parsing by this factor.
* **-U**, **--freq\_bpf**=_frequency_  
  SCR/Unicable band-pass filter frequency to use, in kHz.
  Used only on satellite delivery systems.
* **-v**, **--verbose**  
  Be (very) verbose. Useful to check if the MPEG-TS is happenning fine.
  This option can be used multiple times to increase verbosity.
* **-w**, **--lna**=_LNA_  
  Enable, disable or put LNA power in auto mode. Not all frontends support it.
  Valid values are:
    *  0 - disable  
    *  1 - enable  
    * -1 - auto  
* **-W**, **--wait**=_time_  
  Adds additional wait time for DISEqC command completion.
* **-?**, **--help**  
  Outputs the usage help.
* **--usage**  
  Gives a short usage message.
* **-V**, **--version**  
  Prints the program version.

Mandatory or optional arguments to long options are also mandatory or
optional for any corresponding short options.

<a name="note"></a>

### NOTE

If both **--nit** and **--get\_frontend** options are used at the
same time, the **--nit** parameters will be applied after the ones that
the frontend detected.

<a name="exit-status"></a>

# Exit Status

On success, it returns 0.

<a name="example"></a>

# Example


    .schar … ...
    $ dvbv5-scan /usr/share/dvbv5/dvb-c/the-brownfox
    
    Scanning frequency #1 573000000
    Lock   (0x1f) Quality= Good Signal= 100.00% C/N= -13.80dB UCB= 0 postBER= 3.14x10^-3 PER= 0
    Service The, provider (null): digital television
    Service Quick, provider BrownFox: digital television
    Service Brown, provider (null): digital television
    Service Jumps, provider (null): digital television
    …
    Service Dog, provider (null): digital television
    New transponder/channel found: #2: 579000000
    …
    New transponder/channel found: #39: 507000000

The scan process will then scan the other 38 discovered new transponders,
and generate a dvb_channel.conf with several entries with will have not only
the physical channel/transponder info, but also the Service ID, and the
corresponding audio/video/other program IDs (PID), like:

    [Quick]
            SERVICE_ID = 5
            VIDEO_PID = 288
            AUDIO_PID = 289
            FREQUENCY = 573000000
            MODULATION = QAM/256
            INVERSION = OFF
            SYMBOL_RATE = 5247500
            INNER_FEC = NONE
            DELIVERY_SYSTEM = DVBC/ANNEX_A

<a name="bugs"></a>

# Bugs

Report bugs to **Linux Media Mailing List &lt;linux-media@vger.kernel.org&gt;**

<a name="copyright"></a>

# Copyright

Copyright (c) 2011-2014 by Mauro Carvalho Chehab.

License GPLv2: GNU GPL version 2 &lt;http://gnu.org/licenses/gpl.html&gt;.  
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
