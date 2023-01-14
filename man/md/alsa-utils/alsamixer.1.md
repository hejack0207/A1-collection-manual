# alsamixer(1) - soundcard mixer for ALSA soundcard driver, with ncurses interface

22 May 2009

```
alsamixer [options]
```


<a name="description"></a>

# Description

**alsamixer** is an ncurses mixer program for use with the ALSA
soundcard drivers. It supports multiple soundcards with multiple devices.


<a name="options"></a>

# Options



* _-h, --help_  
  Help: show available flags.
  
* _-c, --card_ &lt;card number or identification&gt;  
  Select the soundcard to use, if you have more than one. Cards are
  numbered from 0 (the default).
  
* _-D, --device_ &lt;device identification&gt;  
  Select the mixer device to control.
  
* _-V, --view_ &lt;mode&gt;  
  Select the starting view mode, either _playback_, _capture_ or _all_.
  
* _-g, --no-color_  
  Toggle the using of colors.
  

<a name="mixer-views"></a>

# Mixer Views


The top-left corner of **alsamixer** is the are to show some basic
information: the card name, the mixer chip name, the current view
mode and the currently selected mixer item.
When the mixer item is switched off, _[Off]_ is displayed in its
name.

Volume bars are located below the basic information area.  You can
scroll left/right when all controls can't be put in a single screen.
The name of each control is shown in the bottom below the volume bars.
The currently selected item is drawn in red and/of emphasized.

Each mixer control with volume capability shows a box and the current
volume filled in that box.  The volume percentages are displayed below
the volume bar for left and right channels.  For a mono control, only
one value is shown there.

When a mixer control is turned off, _M_ (mute) appears below the
volume bar.  When it's turned on, _O_ in green appears instead.
You can toggle the switch via _m_ key.

When a mixer control has capture capability, the capture flag appears
below the volume bar, too.  When the capture is turned off,
------- is shown.  _CAPTURE_ in red appears when the
capture switch is turned on.  In addition, _L_ and _R_ letters
appear in left and right side to indicate that left and the right
channels are turned on.

Some controls have the enumeration list, and don't show boxes but only
texts which indicate the currently active item.  You can change the
item via up/down keys.


<a name="view-modes"></a>

# View Modes

**alsamixer** has three view modes: playback, capture and all.
In the playback view, only the controls related with playback are shown.
Similarly, only the controls for capture (recording) are shown in the capture
view.  The all view mode shows all controls.  The current view mode is displayed
in the top-left position together with the mixer name, etc.

The default view mode is the playback view.  You can change it via 
_-V_ option.

Each view mode can be switched via keyboard commands, too.
See the next section.


<a name="keyboard-commands"></a>

# Keyboard Commands

**alsamixer** recognizes the following keyboard commands to control the soundcard. 
Commands shown here in upper case can also be given in lower case.
To be reminded of these keystrokes, hit the _h_ key.

.SS
General Controls

The _Left_ and _right arrow_ keys are used to select the
channel (or device, depending on your preferred terminology). You can
also use _n_ ("next") and _p_ ("previous").

The _Up_ and _Down Arrows_ control the volume for the
currently selected device. You can also use _+_ or _-_ for the
same purpose. Both the left and right signals are affected. For
independent left and right control, see below.
 
The _B_ or _=_ key adjusts the balance of volumes on left and
right channels.

_M_ toggles muting for the current channel (both left and right).
If the hardware supports it, you can
mute left and right independently by using _,_ (or _&lt;_) and
_._ (or _&gt;_) respectively.

_SPACE_ enables recording for the current channel. If any other
channels have recording enabled, they will have their recording function
disabled first. This only works for valid input channels, of course.

_L_ re-draws the screen.

.SS
View Mode Controls
Function keys are used to change view modes.
You can switch to the help mode and the proc info mode via _F1_ and
_F2_ keys, respectively.
On terminals that can't use function keys like gnome-terminal, _?_ and
_/_ keys can be used alternatively for help and proc modes.

_F3_, _F4_ and _F5_ keys are used to switch to playback, capture
and all view mode, respectively.  _TAB_ key toggles the
current view mode circularly.

.SS
Quick Volume Changes

_PageUp_ increases volume by 5.

_PageDown_ decreases volume by 5.

_End_ sets volume to 0.

You can also control left & right levels for the current channel
independently, as follows:

[_Q_ | _W_ | _E_ ]  -- turn UP [ left | both | right ]

[_Z_ | _X_ | _C_ ] -- turn DOWN [ left | both | right ]   

If the currently selected mixer channel is not a stereo channel, then
all UP keys will work like _W_, and all DOWN keys will work like _X_.

The number keys from _0_ to _9_ are to change the absolute volume
quickly.  They correspond to 0 to 90% volume.

.SS
Selecting the Sound Card

You can select another sound card by pressing the _F6_ or _S_ keys.
This will show a list of available sound cards to choose from,
and an entry to enter the mixer device name by hand.

.SS
Exiting

Quit the program with _ALT Q_, or by hitting _ESC_.
Please note that you might need to hit _ESC_ twice on some terminals
since it's regarded as a prefix key.


<a name="volume-mapping"></a>

# Volume Mapping

In **alsamixer**, the volume is mapped to a value that is more natural
for a human ear.  The mapping is designed so that the position in the
interval is proportional to the volume as a human ear would perceive
it, i.e. the position is the cubic root of the linear sample
multiplication factor.  For controls with a small range (24 dB or
less), the mapping is linear in the dB values so that each step has
the same size visually.

Only for controls without dB information, a linear mapping of the
hardware volume register values is used (this is the same algorithm as
used in the old **alsamixer**).


<a name="see-also"></a>

# See Also


amixer(1),
aplay(1),
arecord(1)



<a name="bugs-"></a>

# Bugs 

Some terminal emulators (e.g. **nxterm**) may not
work quite right with ncurses, but that's their own damn
fault. Plain old **xterm** seems to be fine.


<a name="author"></a>

# Author

**alsamixer**
has been written by Tim Janik and
been further improved by Jaroslav Kysela &lt;[perex@perex.cz](mailto:perex@perex.cz)&gt;
and Clemens Ladisch &lt;[clemens@ladisch.de](mailto:clemens@ladisch.de)&gt;.

This manual page was provided by Paul Winkler &lt;[zarmzarm@erols.com](mailto:zarmzarm@erols.com)&gt;.
