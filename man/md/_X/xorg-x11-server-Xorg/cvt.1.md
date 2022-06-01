# cvt(1) - calculate VESA CVT mode lines

X Version 11, xorg-server 1.20.11

```
cvt [-v|--verbose] [-r|--reduced] h-resolution v-resolution [refresh]
```

<a name="description"></a>

# Description

_Cvt_
is a utility for calculating VESA Coordinated Video Timing modes.  Given the
desired horizontal and vertical resolutions, a modeline adhering to the CVT
standard is printed. This modeline can be included in Xorg
**xorg.conf(5)**


<a name="options"></a>

# Options


* **refresh**  
  Provide a vertical refresh rate in Hz.  The CVT standard prefers either 50.0,
  60.0, 75.0 or 85.0Hz.  The default is 60.0Hz.
* **-v**|**--verbose**  
  Warn verbosely when a given mode does not completely correspond with CVT
  standards.
* **-r**|**--reduced**  
  Create a mode with reduced blanking.  This allows for higher frequency signals,
  with a lower or equal dotclock. Not for Cathode Ray Tube based displays though.
  

<a name="see-also"></a>

# See Also

xorg.conf(5), gtf(1)

<a name="author"></a>

# Author

Luc Verhaegen.

This program is based on the Coordinated Video Timing sample
implementation written by Graham Loveridge. This file is publicly
available at &lt;http://www.vesa.org/Public/CVT/CVTd6r1.xls&gt;. CVT is a
VESA trademark.
