# amidi(1) - read from and write to ALSA RawMIDI ports

30 Aug 2016

```
amidi [-p port] [-s file | -S data] [-r file] [-d] [-t seconds] [-a]
```


<a name="description"></a>

# Description

**amidi**
is a command-line utility which allows one to receive and send
SysEx (system exclusive) data from/to external MIDI devices.
It can also send any other MIDI commands.

**amidi**
handles only files containing raw MIDI commands, without timing
information.
**amidi**
does not support Standard MIDI (.mid) files, but
**aplaymidi(1)**
and
**arecordmidi(1)**
do.


<a name="options"></a>

# Options


Use the
_-h,_
_-V,_
_-l,_
or
_-L_
options to display information;
or use at least one of the
_-s,_
_-r,_
_-S,_
or
_-d_
options to specify what data to send or receive.


* _-h, --help_  
  Help: prints a list of options.
  
* _-V, --version_  
  Prints the current version.
  
* _-l, --list-devices_  
  Prints a list of all hardware MIDI ports.
  
* _-L, --list-rawmidis_  
  Prints all RawMIDI definitions.
  (used when debugging configuration files)
  
* _-p, --port=name_  
  Sets the name of the ALSA RawMIDI port to use.
  If this is not specified,
  **amidi**
  uses the default port defined in the configuration file
  (the default for this is port 0 on card 0, which may not exist).
  
* _-s, --send=filename_  
  Sends the contents of the specified file to the MIDI port.
  The file must contain raw MIDI commands (e.g. a .syx file);
  for Standard MIDI (.mid) files, use
  **aplaymidi(1).**
  
* _-r, --receive=filename_  
  Writes data received from the MIDI port into the specified file.
  The file will contain raw MIDI commands (such as in a .syx file);
  to record a Standard MIDI (.mid) file, use
  **arecordmidi(1).**
  
  **amidi**
  will filter out any Active Sensing and Clock bytes (FEh, F8h), unless the
  _-a_
  or
  _-c_
  options have been given.
  
* _-S, --send-hex="..."_  
  Sends the bytes specified as hexadecimal numbers to the MIDI port.
  
* _-d, --dump_  
  Prints data received from the MIDI port as hexadecimal bytes.
  Active Sensing and Clock bytes (FEh, F8h) will not be shown, unless the
  _-a_
  or
  _-c_
  options have been given.
  
  This option is useful for debugging.
  
* _-t, --timeout=seconds_  
  Stops receiving data when no data has been received for the specified
  amount of time.
  
  If this option has not been given, you must press Ctrl+C (or kill
  **amidi)**
  to stop receiving data.
  
* _-a, --active-sensing_  
  Does not ignore Active Sensing bytes (FEh) when saving or printing
  received MIDI commands.
  
* _-c, --clock_  
  Does not ignore Clock bytes (F8h) when saving or printing received
  MIDI commands.
  
* _-i, --sysex-interval=mseconds_  
  Adds a delay in between each SysEx message sent to a device. It is
  useful when sending firmware updates via SysEx messages to a remote
  device.
  

<a name="examples"></a>

# Examples



* **amidi -p hw:0 -s my_settings.syx**  
  will send the MIDI commands in
  _my_settings.syx_
  to port
  _hw:0._
  
* **amidi -p hw:1,0,0 -s firmware.syx -i 100**  
  will send the MIDI commands in
  _firmware.syx_
  to port
  _hw:1,0,0_
  with 100 milliseconds delay in between each SysEx message.
  
* **amidi -S 'F0 43 10 4C 00 00 7E 00 F7'**  
  sends an XG Reset to the default port.
  
* **amidi -p hw:1,2 -S F0411042110C000000000074F7 -r dump.syx -t 1**  
  sends a “Parameter Dump Request” to a GS device, saves the received
  parameter data to the file
  _dump.syx,_
  and stops after the device has finished sending data
  (when no data has been received for one second).
  
* **amidi -p virtual -d**  
  creates a virtual RawMIDI port and prints all data sent to this port.
  

<a name="files"></a>

# Files

_/usr/share/alsa/alsa.conf_
default rawmidi definitions  
_/etc/asound.conf_
system-wide rawmidi definitions  
_~/.asoundrc_
user specific rawmidi definitions


<a name="see-also"></a>

# See Also

aplaymidi(1)  
arecordmidi(1)


<a name="author"></a>

# Author

Clemens Ladisch &lt;[clemens@ladisch.de](mailto:clemens@ladisch.de)&gt;
