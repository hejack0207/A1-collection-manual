# beep(1) - beep the pc speaker any number of ways

Linux, 2020\-01\-01

```
beep [\|GLOBALS\|] [\|-f FREQ\|] [\|-l LEN\|] [\|-r REPEATS\|] [\|<-d|-D> DELAY\|] [\|-s\|] [\|-c\|]
beep [\|GLOBALS\|] <\|TONE_OPTIONS\|> [\|-n|--new\|] <\|TONE_OPTIONS\|>
beep <\|-h|--help\|>
beep <\|-v|-V|--version\|>
```




<a name="description"></a>

# Description


**beep** allows the user to control the PC speaker with precision, allowing different sounds to indicate different events.  While **beep** can be run quite happily on the command line, **beep**'s intended use is within shell/perl scripts, notifying the user when something interesting occurs.  Of course, it has no notion of what _IS_ interesting, but it is good at the notifying part.

All options have default values, meaning that just typing '**beep**' will work.  If an option is specified more than once on the command line, subsequent options override their predecessors.  So '**beep** -f 200 -f 300' will beep at 300Hz.

All durations are given in a unit of milliseconds, frequencies as Hertz, and the number of repeats is a dimensionless number.




<a name="options"></a>

# Options


<a name="global-options"></a>

### Global options


* **-e&nbsp;DEVICE**_,_**&nbsp;--device=**_DEVICE_  
  Explicitly set the device **beep** shall use to generate beep tones.  When not given a device explicitly, **beep** runs through an internal list of devices until one appears to work.
* **--debug**,&nbsp;**--verbose**  
  Make the **beep** program more verbose.

<a name="tone-options"></a>

### Tone options


* **-f&nbsp;**_FREQ_  
  Beep with a tone frequency of _FREQ_ Hz, where 0 &lt; _FREQ_ &lt; 20000.  As a general ballpark, the regular terminal beep is around 750Hz.  For backwards compatibility, you can give _FREQ_ as a floating point number, but **beep** will round that to integer values as the kernel APIs expect them.  Default value: 440 Hz.
* **-l&nbsp;**_LEN_  
  Beep for a tone length of _LEN_ milliseconds. Default value: 200 ms.
* **-r&nbsp;**_REPEATS_  
  Repeat the tone including delays _REPEATS_ times. Default value: 1 tone, not repeated.
* **-d&nbsp;**_DELAY&nbsp;|&nbsp;_**-D&nbsp;**_DELAY_  
  Specify a delay of _DELAY_ milliseconds between repetitions.  Small letter **-d** specifies that this delay should only occur _between_ beeps, that is, it should _not_ occur after the last repetition.  Capital letter **-D** specifies that the delay should occur after every repetition, _including_ after the last one.  Normally, **-d** is what you want, but if, for example, you are stringing several **beep** commands together to play the star wars anthem, you may want control over every delay. Default value: 100 ms delay between beeps with no delay after the last beep.
* **-n**,&nbsp;**--new**  
  The **--new** option allows you to chain multiple beeps together on a single command line.  Each time the **--new\FR is used, beep** starts treating all further arguments as though they were for a new beep.  So for example:
  
      **beep** -f 1000 -n -f 2000 -n -f 1500
  
  would produce a sequence of three beeps, the first with a frequency of 1000Hz (and otherwise default values), then a second beep with a frequency of 2000Hz (again, with things like delay and reps being set to their defaults), then a third beep, at 1500Hz.  This is different from specifying a **-r** value, since **-r** repeats the same beep multiple times, whereas **--new** allows you to specify different beeps.  After a **--new**, the new beep is created with all the default values, and any of these can be specified without altering values for preceding (or later) beeps.  See the **EXAMPLES** section if this managed to confuse you.
* **-s**,&nbsp;**-c**  
  Both the **-s** and the **-c** option put **beep** into input processing mode, reading from _stdin_ and copying all received data to _stdout_.  This makes it easy to slip **beep** into a text processing pipeline to acoustically monitor the data flow within that pipeline.  See the **EXAMPLES** section.
    * **-c**  
      Beep after every character received.
    * **-s**  
      Beep after every set of data received.  Usually, this means after newlines occur in text processing pipes.

In a sequence of notes specified with one or more occurrences of **-n** or **--new**, it only makes sense to have one single note marked with either **-s** or **-c** attached to it.  Then **beep** will beep all notes until it reaches that marked note, then repeat the marked note according to the input it receives, and once the input has reached EOF, **beep** will continue with the remainder of the note sequence.

The behaviour of **beep** with more than one note marked with **-s** or **-c** is undefined.

<a name="other-actions"></a>

### Other Actions

**-h**,&nbsp;**--help**
Display **beep** usage info and exit.

* **-v**,&nbsp;**-V**,&nbsp;**--version**  
  Display **beep** version information and exit.
  
  
  

<a name="exit-status"></a>

# Exit Status


When successful,
**beep**
returns with exit code 0.

Any non-0 exit code means
**beep**
has encountered an error and has bailed out.




<a name="environment"></a>

# Environment


* **BEEP_LOG_LEVEL**  
  When set to a number between -999 and 999,
  **BEEP_LOG_LEVEL**
  will be used as the default loglevel until overridden by a command line parameter.
  
  
  

<a name="files"></a>

# Files

The device files
**beep**
uses by default are the following:

    /dev/input/by-path/platform-pcspkr-event-spkr
    /dev/tty0
    /dev/vc/0




<a name="notes"></a>

# Notes


<a name="devices-and-permissions"></a>

### Devices and Permissions


When you run **beep** without explicitly giving a device to use, **beep** tries opening the following devices in sequence until one succeeds:

* **/dev/input/by-path/platform-pcspkr-event-spkr**  
  Uses the evdev API, and system administrator can allow access to any set of users and groups using the normal file permissions.
* **/dev/tty0**  
  Uses the console API, and the kernel insists you are root or own the TTY.
* **/dev/vc/0**  
  Uses the console API, and the kernel insists you are root or own the TTY.

**beep**
does not support running as setuid root or via
**sudo**(1)**.**

For non-root uses, the system administrator can set up a
**udev**(7)
rule to allow write access to
**/dev/input/by-path/platform-pcspkr-event-spkr**
for certain users and/or user groups. For details, see the
**beep**
**/usr/share/doc/beep/PERMISSIONS.md**
file.


<a name="apis"></a>

### APIs


* evdev  
  Uses the input event device driver, which means running
  **write**(2)
  on
  **/dev/input/by-path/platform-pcspkr-event-spkr**.
* The permissions to this device file can be set up such that beep can be run by any non-root user the system administrator wants to.
* Opening this device takes on the order of magnitude of 20ms in the Linux kernel for every time you start the
  **beep**
  command. Therefore, if you need to play multiple notes in a rhythmical sequence for a melody, use one
  **beep**
  command invocation with multiple notes, not several
  **beep**
  invocations playing one note each.
* console  
  Uses the ancient console API, which means running the
  **KIOCSOUND**
  **ioctl**(2)
  on a tty device like
  **/dev/tty0&nbsp;**or&nbsp;**/dev/vc/0.**
* This requires being root, unless the non-root user happens be logged into the virtual console and be using that specific virtual console device like e.g. **/dev/tty4**. This makes the console driver useless for non-root users logged in via ssh, and often X11 or Wayland.
* Use the evdev API instead.
  

<a name="concurrent-invocations"></a>

### Concurrent Invocations

Concurrent invocations of **beep** are not supported. There is only one tone generator in the PC hardware, and we do not manage access to that shared resource in any way.  So if a first
**beep -f 1000 -l 10000**
process starts a long 10 second beep with 1000Hz, and 2 seconds later a second quick
**beep -f 2050 -l 100**
with 2050Hz comes in, you will hear that 2050Hz beep for 100ms, and then silence as the quick beep silences the tone generator. Now you will not hear that the first **beep** process is still running after having waited for the first 2100ms of its 10000ms. You will also not hear that the first **beep** process will silence the already silent speaker 7900ms later, i.e. 10000ms after the first **beep** started.


<a name="sound-volume"></a>

### Sound Volume


The PC speaker hardware has no way to explicitly set the volume of a beep.

If you have a
_standalone PC_,
however, chances are you have a piezo beeper connected to the mainboard.  If you prioritize a loud beep over a certain frequency beep, you can choose to beep at a frequency close to the resonance frequency of the piezo beeper.  Typical piezo beepers have a resonance frequency around 2000Hz, so you can test frequencies around that range.  The author's piezo beeper is the loudest at about 2050Hz.

If you have a
_PC laptop_,
chances are that your laptop will not have a piezo beeper hardware inside and that it will route the output of the pcspkr circuit to the laptop's internal speakers via the sound card mixer.  In that case, you can and/or must change the mixer level for the beeper using a sound card mixer application.


<a name="frequency-table"></a>

### Frequency Table


This frequency table might come in handy for translating musical notes to frequencies.  The frequencies are rounded to integer numbers as the kernel driver only works with integers.  The column for
**octave 4**
is the octave of middle C.


.TS
center box;
Cb | Cb s  s  s
Cb | Cb Cb Cb Cb
-  | -  -  -  -
C  | N  N  N  N.
note	octave
name	3	4	5	6	
C	131	262	523	1047	
C#	139	277	554	1109	
D	147	294	587	1175	
D#	156	311	622	1245	
E	165	330	659	1319	
F	175	349	698	1397	
F#	185	370	740	1480	
G	196	392	784	1568	
G#	208	415	831	1661	
A	220	440	880	1760	
A#	233	466	932	1865	
B	247	494	988	1976	
C	262	523	1047	2093	
.TE




<a name="bugs"></a>

# Bugs

Report bugs to
[](https://github.com/spkr-beep/beep/issues).




<a name="examples"></a>

# Examples


At its simplest (yet still effective)

    **beep**


A more interesting standalone setup

    **beep** -f 300.7 -r 2 -d 100 -l 400


As part of a log watching pipeline

    tail -f /var/log/xferlog | grep 'passwd' | **beep** -f 1000 -r 5 -s


When using -c mode, I recommend using a short -D, and a shorter -l, so that the beeps do not blur together.  Something like this will get you a cheesy 1970's style beep-as-you-type-each-letter effect

    cat file | **beep** -c -f 400 -D 50 -l 10


A highly contrived example of -n/--new usage

    **beep** -f 1000 -r 2 -n -r 5 -l 10 --new

will produce first two 1000Hz beeps, then 5 beeps at the default tone, but only 10ms long each, followed by a third beep using all the default settings (since none are specified).






<a name="see-also"></a>

# See Also


**/usr/share/doc/beep/README.fedora**,
**/usr/share/doc/beep/README.md**,
**/usr/share/doc/beep/PERMISSIONS.md**,
.UR "https://github.com/spkr-beep/beep"
.UE
