# amixer(1) - command-line mixer for ALSA soundcard driver

11 Aug 2000

```
amixer [-option] [cmd]
```

<a name="description"></a>

# Description

**amixer** allows command-line control of the mixer for the ALSA
soundcard driver.
**amixer** supports multiple soundcards.

**amixer** with no arguments will display the current mixer settings
for the default soundcard and device. This is a good way to see a list
of the simple mixer controls you can use.


<a name="commands"></a>

# Commands



* _help_  
  Shows syntax.
  
* _info_  
  Shows the information about a mixer device.
  
* _scontrols_  
  Shows a complete list of simple mixer controls.
  
* _scontents_  
  Shows a complete list of simple mixer controls with their contents.
  
* _set_ or _sset_ &lt;_SCONTROL_&gt; &lt;_PARAMETER_&gt; ...  
  Sets the simple mixer control contents. The parameter can be the volume
  either as a percentage from 0% to 100% with _%_ suffix,
  a dB gain with _dB_ suffix (like -12.5dB), or an exact hardware value.
  The dB gain can be used only for the mixer elements with available
  dB information.
  When plus(+) or minus(-) letter is appended after
  volume value, the volume is incremented or decremented from the current
  value, respectively.
  
  The parameters _cap, nocap, mute, unmute, toggle_ are used to
  change capture (recording) and muting for the group specified.
  
  The optional modifiers can be put as extra parameters to specify
  the stream direction or channels to apply.
  The modifiers _playback_ and _capture_ specify the stream,
  and the modifiers _front, rear, center, woofer_ are used to specify
  channels to be changed. 
  
  A simple mixer control must be specified. Only one device can be controlled
  at a time.
  
* _get_ or _sget_ &lt;_SCONTROL_&gt;  
  Shows the simple mixer control contents.
  
  A simple mixer control must be specified. Only one device can be controlled
  at a time.
  
* _controls_  
  Shows a complete list of card controls.
  
* _contents_  
  Shows a complete list of card controls with their contents.
  
* _cset_ &lt;_CONTROL_&gt; &lt;_PARAMETER_&gt; ...  
  Sets the card control contents. The identifier has these components: iface,
  name, index, device, subdevice, numid. The next argument specifies the value
  of control.
  
* _cget_ &lt;_CONTROL_&gt;  
  Shows the card control contents. The identifier has same syntax as for
  the _cset_ command.
  

<a name="options"></a>

# Options



* _-c_ card  
  
  Select the card number to control. The device name created from this
  parameter has syntax 'hw:N' where N is specified card number.
  
* _-D_ device  
  
  Select the device name to control. The default control name is 'default'.
  
* _-s_ | _--stdin_  
  
  Read from stdin and execute the command on each line sequentially.
  When this option is given, the command in command-line arguments is ignored.
  
  Only sset and cset are accepted.  Other commands are ignored.
  The commands to unmatched ids are ignored without errors too.
  
* _-h_   
  Help: show syntax.
  
* _-q_  
  Quiet mode. Do not show results of changes.
  
* _-R_   
  Use the raw value for evaluating the percentage representation.
  This is the default mode.
  
* _-M_   
  Use the mapped volume for evaluating the percentage representation
  like **alsamixer**, to be more natural for human ear.
  

<a name="examples"></a>

# Examples



* **amixer -c 1 sset Line,0 80%,40% unmute cap**  
  will set the second soundcard's left line input volume to 80% and
  right line input to 40%, unmute it, and select it as a source for
  capture (recording).
  
* **amixer -c 1 -- sset Master playback -20dB**  
  will set the master volume of the second card to -20dB.  If the master
  has multiple channels, all channels are set to the same value.
  
* **amixer -c 1 set PCM 2dB+**  
  will increase the PCM volume of the second card with 2dB.  When both
  playback and capture volumes exist, this is applied to both volumes.
  
* **amixer -c 2 cset iface=MIXER,name='Line Playback Volume",index=1 40%**  
  will set the third soundcard's second line playback volume(s) to 40%
  
* **amixer -c 2 cset numid=34 40%**  
  will set the 34th soundcard element to 40%
  

<a name="see-also"></a>

# See Also


alsamixer(1)



<a name="bugs-"></a>

# Bugs 

None known.


<a name="author"></a>

# Author

**amixer** is by Jaroslav Kysela &lt;[perex@perex.cz](mailto:perex@perex.cz)&gt;.
This document is by Paul Winkler &lt;[zarmzarm@erols.com](mailto:zarmzarm@erols.com)&gt; and Jaroslav Kysela &lt;perex@perex.cz&gt;.
