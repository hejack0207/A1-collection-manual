# ifstat(8) - handy utility to read network interface statistics

iproute2, 28 Oct 2015

```
.in +8 .ti -8 ifstat [  OPTIONS ] [ INTERFACE_LIST ]
</synopsis>

<synopsis>
.ti -8 INTERFACE_LIST := INTERFACE_LIST | interface
```

<a name="description"></a>

# Description

**ifstat** neatly prints out network interface statistics.
The utility keeps records of the previous data displayed in history files and
by default only shows difference between the last and the current call.
Location of the history files defaults to /tmp/.ifstat.u$UID but may be
overridden with the IFSTAT_HISTORY environment variable. Similarly, the default
location for xstat (extended stats) is /tmp/.&lt;xstat name&gt;_ifstat.u$UID.

<a name="options"></a>

# Options


* **-h, --help**  
  Show summary of options.
* **-V, --version**  
  Show version of program.
* **-a, --ignore**  
  Ignore the history file.
* **-d, --scan=SECS**  
  Sample statistics every SECS second.
* **-e, --errors**  
  Show errors.
* **-n, --nooutput**  
  Don't display any output.  Update the history file only.
* **-r, --reset**  
  Reset history.
* **-s, --noupdate**  
  Don't update the history file.
* **-t, --interval=SECS**  
  Report average over the last SECS seconds.
* **-z, --zeros**  
  Show entries with zero activity.
* **-j, --json**  
  Display results in JSON format
* **-p, --pretty**  
  If combined with
  **--json**,
  pretty print the output.
* **-x, --extended=TYPE**  
  Show extended stats of TYPE. Supported types are:
  
  .in +8
  **cpu_hits**
  - Counts only packets that went via the CPU.
  .in -8
  

<a name="environment"></a>

# Environment


* **IFSTAT_HISTORY**  
  If set, it's value is interpreted as alternate history file path.

<a name="see-also"></a>

# See Also

**ip**(8)  

<a name="author"></a>

# Author

ifstat was written by Alexey Kuznetsov &lt;[kuznet@ms2.inr](mailto:kuznet@ms2.inr).ac.ru&gt;.

This manual page was written by Petr Sabata &lt;[contyk@redhat.com](mailto:contyk@redhat.com)&gt;.
