# rtacct(8) - network statistics tools.

27 June, 2007

```
Usage: nstat [ -h?vVzrnasd:t:jp ] [ PATTERN [ PATTERN ] ]
Usage: rtacct [ -h?vVzrnasd:t: ] [ ListOfRealms ]
```


<a name="description"></a>

# Description

**nstat**
and
**rtacct**
are simple tools to monitor kernel snmp counters and network interface statistics.

**nstat**
can filter kernel snmp counters by name with one or several specified wildcards. Wildcards are case-insensitive and can include special symbols
**?**
and
<b>*</b>


<a name="options"></a>

# Options

**-h, --help**
Print help

* **-V, --version**  
  Print version
* **-z, --zeros**  
  Dump zero counters too. By default they are not shown.
* **-r, --reset**  
  Reset history.
* **-n, --nooutput**  
  Do not display anything, only update history.
* **-a, --ignore**  
  Dump absolute values of counters. The default is to calculate increments since the previous use.
* **-s, --noupdate**  
  Do not update history, so that the next time you will see counters including values accumulated to the moment of this measurement too.
* **-j, --json**  
  Display results in JSON format.
* **-p, --pretty**  
  When combined with
  **--json**,
  pretty print the output.
* **-d, --scan &lt;INTERVAL&gt;**  
  Run in daemon mode collecting statistics. &lt;INTERVAL&gt; is interval between measurements in seconds.
* **-t, --interval &lt;INTERVAL&gt;**  
  Time interval to average rates. Default value is 60 seconds.
  

<a name="see-also"></a>

# See Also

lnstat(8)
