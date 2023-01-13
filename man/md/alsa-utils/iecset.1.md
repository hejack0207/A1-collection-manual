# iecset(1) - Set or dump IEC958 status bits

23 Oct 2003

```
iecset [options] [cmd arg...]
```


<a name="description"></a>

# Description

**iecset** is a small utility to set or dump the IEC958 (or so-called
"S/PDIF") status bits of the specified sound card via ALSA control API.

When **iecset** is started without arguments except for options,
it will show the current IEC958 status in a human-readable form.
When the commands are given in the arguments, they are parsed
and the IEC958 status bits are updated.  The resultant status is
shown as well.

The commands consist of the command directive and the argument.
As the boolean argument, _yes_, _no_, _true_, _false_,
or a digit number is allowed.


<a name="examples"></a>

# Examples


* **iecset&nbsp;-Dhw:1**  
  Displays the current IEC958 status bits on the second card.
  This is equivalent with _-c 1_.
* **iecset&nbsp;-x**  
  Displays the current IEC958 status bits in a style of the arguments
  for the PCM stream.  The output string can be passed to the _iec958_
  (or _spdif_) PCM type as the optional argument.
* **iecset&nbsp;pro&nbsp;off&nbsp;audio&nbsp;off**  
  Sets the current status to the consumer-mode and turns on the
  non-audio bit.  The modified status will be shown, too.
  

<a name="options"></a>

# Options


* _-D_ device  
  Specifies the device name of the control to open
* _-c_ card  
  Specifies the card index to open.  Equivalent with _-Dhw:x_.
* _-n_ index  
  Specifies the IEC958 control element index, in case you have multiple
  IEC958 devices and need to choose one of them.
* _-x_  
  Dumps the status in the form of AESx bytes.
* _-i_  
  Reads the command sequences from stdin.
  Each line has single command.
  

<a name="commands"></a>

# Commands


* _professional_ &lt;bool&gt;  
  The professional mode (true) or consumer mode (false).
  
* _audio_ &lt;bool&gt;  
  The audio mode (true) or non-audio mode (false).
  
* _rate_ &lt;int&gt;  
  The sample rate in Hz.
  
* _emphasis_ &lt;int&gt;  
  The emphasis: 0 = none, 1 = 50/15us, 2 = CCITT.
  
* _lock_ &lt;bool&gt;  
  Rate lock: locked (true), unlocked (false).
  This command is for the professional mode only.
  
* _sbits_ &lt;int&gt;  
  Sample bits:  2 = 20bit, 4 = 24bit, 6 = undefined.
  This command is for the professional mode only.
  
* _wordlength_ &lt;int&gt;  
  Wordlength: 0 = No, 2 = 22-18 bit, 4 = 23-19 bit, 5 = 24-20 bit, 6 = 20-16 bit.
  This command is for the professional mode only.
  
* _category_ &lt;int&gt;  
  Category: the value is from 0 to 0x7f.
  This command is for the consumer mode only.
  
* _copyright_ &lt;bool&gt;  
  Copyright: copyrighted (true), non-copyrighted (false).
  This command is for the consumer mode only.
  
* _original_ &lt;boo&gt;  
  Original flag: original (true), 1st generation (false).
  This command is for the consumer mode only.
  

<a name="author"></a>

# Author

Takashi Iwai &lt;[tiwai@suse.de](mailto:tiwai@suse.de)&gt;
