# tload(1) - graphic representation of system load average

procps-ng, June 2011

```
tload [options] [tty]
```

<a name="description"></a>

# Description

**tload**
prints a graph of the current system load average to the specified
_tty_
(or the tty of the tload process if none is specified).

<a name="options"></a>

# Options


* **-s**, **--scale** _number_  
  The scale option allows a vertical scale to be specified for the display (in
  characters between graph ticks); thus, a smaller value represents a larger
  scale, and vice versa.
* **-d**, **--delay** _seconds_  
  The delay sets the delay between graph updates in
  _seconds_.
* **-h**, **--help**  
  Display this help text.
* **-V**, **--version**  
  Display version information and exit.


<a name="files"></a>

# Files

_/proc/loadavg_
load average information

<a name="see-also"></a>

# See Also

**ps**(1),
**top**(1),
**uptime**(1),
**w**(1)

<a name="bugs"></a>

# Bugs

The
**-d**_ delay_
option sets the time argument for an
**alarm**(2);
if -d 0 is specified, the alarm is set to 0, which will never send the
**SIGALRM**
and update the display.

<a name="authors"></a>

# Authors

Branko Lankester,
.UR david@​ods.​com
David Engel
.UE , and
.UR johnsonm@​redhat.​com
Michael K. Johnson
.UE .

<a name="reporting-bugs"></a>

# Reporting Bugs

Please send bug reports to
.UR procps@freelists.org
.UE
