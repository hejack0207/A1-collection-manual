# speaker\-test(1) - command\-line speaker test tone generator for ALSA

speaker\-test, April 2nd, 2011

```
speaker-test [-options]
```


<a name="description"></a>

# Description

**speaker-test** generates a tone that can be used to test the speakers of a computer.

**speaker-test** by default will test the _default_ device. If you
want to test another sound device you will have first to get a list of
all of the sound cards in your system and the devices associated with
those cards. Notice that there might be for example, one device for
analog sound, one for digital sound and one for HDMI sound.
To get the list of available cards and devices you can run **aplay -L**.



    $ aplay -L
    null
        Discard all samples (playback) or generate zero samples (capture)
    default:CARD=ICH5
        Intel ICH5, Intel ICH5
        Default Audio Device
    front:CARD=ICH5,DEV=0
        Intel ICH5, Intel ICH5
        Front speakers
    surround40:CARD=ICH5,DEV=0
        Intel ICH5, Intel ICH5
        4.0 Surround output to Front and Rear speakers
    (...)


in the above example, there are four devices listed: null, default, front
and surround40. So, if you want to test the last device you can
run **speaker-test -Dsurround40:ICH5 -c 6**. The **-c** option will
indicate that the six audio channels in the device have to be tested.






<a name="options"></a>

# Options



* **-c** | **--channels** _NUM_  
  _NUM_ channels in stream
  
* **-D** | **--device** _NAME_  
  PCM device name _NAME_
  
* **-f** | **--frequency** _FREQ_  
  sine wave of _FREQ_ Hz
  
* **--help**  
  Print usage help
  
* **-b** | **--buffer** _TIME_  
  Use buffer size of _TIME_ microseconds.
  When 0 is given, use the maximal buffer size.
  The default value is 0.
  
* **-p** | **--period** _TIME_  
  Use period size of _TIME_ microseconds.
  When 0 is given, the periods given by **-P** option is used.
  The default value is 0.
  
* **-P** | **--nperiods** _PERIODS_  
  Use number of periods.  The default value is 4.
  
* **-r** | **--rate** _RATE_  
  stream of _RATE_ Hz
  
* **-t** | **--test** **pink**|**sine**|**wav**  
  **-t pink** means use pink noise (default).
  
  Pink noise is perceptually uniform noise -- that is, it sounds like every frequency at once.  If you can hear any tone it may indicate resonances in your speaker system or room.
  
  **-t sine** means to use sine wave.
  
  **-t wav** means to play WAV files, either pre-defined files or given via **-w** option.
  
  You can pass the number from 1 to 3 as a backward compatibility.
  
* **-l** | **--nloops** _COUNT_  
  
  Specifies the number of loops.  Zero means to run infinitely.
  
  When **-s** option below with a valid channel is given, **speaker-test** will perform
  always a single-shot without looping.
  
* **-s** | **--speaker** _CHANNEL_  
  Do a single-shot speaker test for the given channel.  The channel number starts from 1.
  The channel number corresponds to left, right, rear-left, rear-right, center, LFE,
  side-left, side-right, and so on.
  
  For example, when 1 is passed, it tests the left channel only once rather than both channels
  with looping.
  
* **-w** | **--wavfile** _FILE_  
  Use the given WAV file for the playback instead of pre-defined WAV files.
  
* **-W** | **--wavdir** _DIRECTORY_  
  Specify the directory containing WAV files for playback.
  The default path is _/usr/share/sounds/alsa_.
  
* **-m** | **--chmap** _MAP_  
  Pass the channel map to override.
  If the playback in a specific channel order or channel positions is
  required, pass the channel position strings to this option.
  
* **-X** | **--force-frequency**  
  Allow supplied _FREQ_ to be outside the default range of 30-8000Hz. A minimum of 1Hz is still enforced.
  

<a name="usage-examples"></a>

# Usage Examples


Produce stereo sound from one stereo jack:
.EX
  speaker-test -Dplug:front -c2
.EE

Produce 4 speaker sound from two stereo jacks:
.EX
  speaker-test -Dplug:surround40 -c4
.EE

Produce 5.1 speaker sound from three stereo jacks:
.EX
  speaker-test -Dplug:surround51 -c6
.EE

To send a nice low 75Hz tone to the Woofer and then exit without touching any other speakers:
.EX
  speaker-test -Dplug:surround51 -c6 -s1 -f75
.EE

To do a 2-speaker test using the spdif (coax or optical) output:
.EX
  speaker-test -Dplug:spdif -c2
.EE

Play in the order of front-right and front-left from the front PCM
.EX
  speaker-test -Dplug:front -c2 -mFR,FL
.EE


<a name="see-also"></a>

# See Also

**aplay(1)**


<a name="author"></a>

# Author

The speaker-test program was written by James Courtier-Dutton.
Pink noise support was added by Nathan Hurst.
Further extensions by Takashi Iwai.
