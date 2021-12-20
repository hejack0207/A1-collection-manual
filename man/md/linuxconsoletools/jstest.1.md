# jstest(1) - joystick test program

jstest, April 21, 2009

```
jstest [--normal] [--old] [--event] [--nonblock] [--select] <device-name>
```

<a name="description"></a>

# Description

**jstest** can be used to test all the features of the Linux
joystick API, including non-blocking and **select**(2) access, as
well as version 0.x compatibility mode.

It is also intended to serve as an example implementation for those
who wish to learn how to write their own joystick using applications.

<a name="options"></a>

# Options


* **--normal**  
  One-line mode showing immediate status.
* **--old**  
  Same as --normal, using 0.x interface.
* **--event**  
  Prints events as they come in.
* **--nonblock**  
  Same as --event, in nonblocking mode.
* **--select**  
  Same as --event, using **select**(2) call.

<a name="see-also"></a>

# See Also

**fftest**(1), **jscal**(1).

<a name="author"></a>

# Author

**jstest**
was written by Vojtech Pavlik.

This manual page was written by Stephen Kitt &lt;[steve@sk2.org](mailto:steve@sk2.org)&gt;, for the Debian
GNU/Linux system (but may be used by others).
