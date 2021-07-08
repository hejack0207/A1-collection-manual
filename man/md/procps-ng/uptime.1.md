# uptime(1) - Tell how long the system has been running.

procps-ng, December 2012

```
uptime [options]
```

<a name="description"></a>

# Description

**uptime**
gives a one line display of the following information.  The current time, how
long the system has been running, how many users are currently logged on, and
the system load averages for the past 1, 5, and 15 minutes.

This is the same information contained in the header line displayed by
**w**(1).

System load averages is the average number of processes that are either in a
runnable or uninterruptable state.  A process in a runnable state is either
using the CPU or waiting to use the CPU.  A process in uninterruptable state
is waiting for some I/O access, eg waiting for disk.  The averages are taken
over the three time intervals.  Load averages are not normalized for the
number of CPUs in a system, so a load average of 1 means a single CPU system
is loaded all the time while on a 4 CPU system it means it was idle 75% of
the time.

<a name="options"></a>

# Options


* **-p**, **--pretty**  
  show uptime in pretty format
* **-h**, **--help**  
  display this help text
* **-s**, **--since**  
  system up since, in yyyy-mm-dd HH:MM:SS format
* **-V**, **--version**  
  display version information and exit

<a name="files"></a>

# Files


* _/var/run/utmp_  
  information about who is currently logged on
* _/proc_  
  process information

<a name="authors"></a>

# Authors

**uptime**
was written by
.UR greenfie@gauss.​rutgers.​edu
Larry Greenfield
.UE
and
.UR johnsonm@sunsite.​unc.​edu
Michael K. Johnson
.UE

<a name="see-also"></a>

# See Also

**ps**(1),
**top**(1),
**utmp**(5),
**w**(1)

<a name="reporting-bugs"></a>

# Reporting Bugs

Please send bug reports to
.UR procps@freelists.org
.UE
