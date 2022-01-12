# jscal-restore(1) - restores joystick calibration

jscal-restore, May 25, 2011

```
jscal-restore <device-name>
```

<a name="description"></a>

# Description

**jscal-restore**
restores the calibration and mapping information for the given
joystick device, previously stored by the
**jscal-store**
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

**jscal**(1), **jscal-store**(1).

<a name="author"></a>

# Author

**jscal-restore**
was written by Stephen Kitt.
