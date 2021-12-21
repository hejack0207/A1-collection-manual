# evdev-joystick(1) - joystick calibration program

evdev-joystick, Apr 19, 2016

```
evdev-joystick --help
evdev-joystick --listdevs
evdev-joystick --showcal <device-path>
evdev-joystick --evdev device-path> [--axis <axis>] [--minimum <value>] [--maximum <value>] [--deadzone <value>] [--fuzz <value>]
```

<a name="description"></a>

# Description

**evdev-joystick**
calibrates joysticks.
Calibrating a joystick ensures the positions on the various axes are
correctly interpreted.

<a name="options"></a>

# Options


* **--h**, **--help**  
  Print out a summary of available options.
* **--l**, **--listdevs**  
  List all joystick devices found.
* **--s**, **--showcal** &lt;**_device-path_**&gt;  
  Show the current calibration for the specified _device_.
* **--e**, **--evdev** &lt;**_device-path_**&gt;  
  Specify the joystick _device_ to modify.
* **--a**, **--axis** &lt;**_axis_**&gt;  
  Specify the _axis_ to modify (by default, all axes are
  calibrated).
* **--m**, **--minimum** &lt;**_value_**&gt;  
  Change the minimum for the current joystick.
* **--M**, **--maximum** &lt;**_value_**&gt;  
  Change the maximum for the current joystick.
* **--d**, **--deadzone** &lt;**_value_**&gt;  
  Change the deadzone for the current joystick.
* **--f**, **--fuzz** &lt;**_value_**&gt;  
  Change the fuzz for the current joystick.

<a name="calibration"></a>

# Calibration

Using the Linux input system, joysticks are expected to produce values
between -32767 and 32767 for axes, with 0 meaning the joystick is
centred.
Thus, full-left should produce -32767 on the X axis, full-right
32767 on the X axis, full-forward -32767 on the Y axis, and so on.

Many joysticks and gamepads (especially older ones) are slightly
mis-aligned; as a result they may not use the full range of values
(for the extremes of the axes), or more annoyingly they may not give 0
when centred.
Calibrating a joystick provides the kernel with information on a
joystick's real behaviour, which allows the kernel to correct various
joysticks' deficiencies and produce consistent output as far as
joystick-using software is concerned.

**jstest**(1) is useful to determine whether a joystick is
calibrated: when run, it should produce all 0s when the joystick is at
rest, and each axis should be able to produce the values -32767 and
32767.
Analog joysticks should produce values in between 0 and the extremes,
but this is not necessary; digital directional pads work fine with
only the three values.

<a name="see-also"></a>

# See Also

**ffset**(1), **jstest**(1).

<a name="authors"></a>

# Authors

**evdev-joystick**
was written by Stephen Anthony, based on VDrift's G25manage tool.

This manual page was written by Stephen Kitt &lt;[steve@sk2.org](mailto:steve@sk2.org)&gt;.
