# ffset(1) - set force-feedback device parameters

ffset, March 8, 2009

```
ffset <device> [-g <gain>] [-a <autocenter strength>]
```

<a name="description"></a>

# Description

ffset sets the gain and autocenter strength of a force-feedback
device.

<a name="options"></a>

# Options


* &lt;_device_&gt;  
  The device to configure.
* **-g** &lt;_gain_&gt;  
  The gain (0-100).
* **-a** &lt;_autocenter strength_&gt;  
  The autocenter strength (0-100).

<a name="see-also"></a>

# See Also

**ffcfstress**(1), **ffmvforce**(1), **fftest**(1), **jscal**(1), **jstest**(1).

<a name="author"></a>

# Author

**ffset**
was written by Johann Deneux.

This manual page was written by Stephen Kitt &lt;[steve@sk2.org](mailto:steve@sk2.org)&gt;, for the
Debian GNU/Linux system (but may be used by others).
It was last modified for
**ffmvforce**
dated May 30, 2001.
