# ffcfstress(1) - constant force stress test for force-feedback devices

ffcfstress, March 8, 2009

```
ffcfstress [-d <device>] [-u <update rate>] [-f <frequency>] [-a <amplitude>] [-s <strength>] [-x <axis>] [-A] [-o]
```

<a name="description"></a>

# Description

ffcfstress stress tests constant non-enveloped forces on a force
feedback device.
It simulates a moving spring force by applying a frequently updated
constant force effect.

**Beware, the stress test may damage your device!**

<a name="options"></a>

# Options

At least one option is required.

* **-d** &lt;_device_&gt;  
  The device to test (by default _/dev/input/event0_).
* **-u** &lt;_update rate_&gt;  
  The update rate in Hz (25 by default).
* **-f** &lt;_frequency_&gt;  
  The spring center motion frequency in Hz (0.1 by default).
* **-a** &lt;_amplitude_&gt;  
  The spring center motion amplitude, between 0.0 and 1.0 (1.0 by
  default).
* **-s** &lt;_strength_&gt;  
  The spring strength factor (1.0 by default).
* **-x** &lt;_axis_&gt;  
  absolute axis to test (default: 0)  
  [0 = X, 1 = Y, 2 = Z, 3 = RX, 4 = RY, 5 = RZ, 6 = WHEEL]
* **-A**  
  switch off auto-centering
* **-o**  
  Dummy option, useful when all defaults should be used.

<a name="see-also"></a>

# See Also

**ffmvforce**(1), **fftest**(1), **jstest**(1).

<a name="author"></a>

# Author

**ffcfstress**
was written by Oliver Hamann.

This manual page was written by Stephen Kitt &lt;[steve@sk2.org](mailto:steve@sk2.org)&gt;, for the Debian
GNU/Linux system (but may be used by others).
It was last modified for
**ffcfstress**
dated February 15, 2002.

