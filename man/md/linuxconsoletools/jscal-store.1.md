# jscal-store(1) - stores joystick calibration

jscal-store, April 7, 2010

```
jscal-store <device-name>
```

<a name="description"></a>

# Description

**jscal-store**
stores the calibration and mapping information for the given joystick
device. This information can later be restored using the
**jscal-restore**
command.

An appropriate rule can be set up with udev so that any stored
calibration settings are restored when the relevant device is
connected. Some distributions (at least Debian, Ubuntu and Slackware)
provide joystick packages which install such rules automatically.

<a name="files"></a>

# Files


* /var/lib/joystick/joystick.state  
  File used to store the calibration settings.

<a name="see-also"></a>

# See Also

**jscal**(1), **jscal-restore**(1).

<a name="author"></a>

# Author

**jscal-store**
was written by Stephen Kitt.
