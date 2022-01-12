# jscal(1) - joystick calibration and remapping program

jscal, Jul 11, 2010

```
jscal [options] <device-name>
```

<a name="description"></a>

# Description

**jscal**
calibrates joysticks and maps joystick axes and buttons.
Calibrating a joystick ensures the positions on the various axes are
correctly interpreted.
Mapping axes and buttons allows the meanings of the joystick's axes
and buttons to be redefined.

On Debian systems the calibration settings can be stored and later
applied automatically using the
**jscal-store**
command.

<a name="options"></a>

# Options


* **-c**, **--calibrate**  
  Calibrate the joystick.
* **-h**, **--help**  
  Print out a summary of available options.
* **-s**, **--set-correction** &lt;_nb\_axes_,_type_,_precision_,_coefficients_,...&gt;  
  Sets correction to specified values.
  For each axis, specify the correction type (0 for none, 1 for "broken
  line"), the precision, and if necessary the correction coefficients
  ("broken line" corrections take four coefficients).
* **-u**, **--set-mappings** &lt;_nb\_axes_,_axmap1_,_axmap2_,...,_nb\_buttons_,_btnmap1_,_btnmap2_,...&gt;  
  Sets axis and button mappings.
  _n\_of\_buttons_ can be set to 0 to remap axes only.
* **-t**, **--test-center**  
  Tests if the joystick is correctly calibrated.
  Returns 2 if the axes are not calibrated, 3 if buttons were pressed, 1
  if there was any other error, and 0 on success.
* **-V**, **--version**  
  Prints the version numbers of the running joystick driver and that
  which jscal was compiled for.
* **-p**, **--print-correction**  
  Prints the current correction settings.
  The format of the output is a jscal command line.
* **-q**, **--print-mappings**  
  Prints the current axis and button mappings.
  The format of the output is a jscal command line.

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

**ffset**(1), **jstest**(1), **jscal-store**(1).

<a name="authors"></a>

# Authors

**jscal**
was written by Vojtech Pavlik and improved by many others; see the
linuxconsole tools documentation for details.

This manual page was written by Stephen Kitt &lt;[steve@sk2.org](mailto:steve@sk2.org)&gt;, for the Debian
GNU/Linux system (but may be used by others).
