# cpupower(1) - Shows and sets processor power related values

"", 07/03/2011

```
cpupower [ -c cpulist ] <command> [ARGS]
</synopsis>

<synopsis>
cpupower -v|--version
</synopsis>

<synopsis>
cpupower -h|--help
```


<a name="description"></a>

# Description

**cpupower ** is a collection of tools to examine and tune power saving
related features of your processor.

The manpages of the commands (cpupower-&lt;command&gt;(1)) provide detailed
descriptions of supported features. Run **cpupower help** to get an overview
of supported commands.


<a name="options"></a>

# Options


--help, -h
Shows supported commands and general usage.

--cpu cpulist,  -c cpulist
Only show or set values for specific cores.
This option is not supported by all commands, details can be found in the
manpages of the commands.

Some commands access all cores (typically the *-set commands), some only
the first core (typically the *-info commands) by default.

The syntax for &lt;cpulist&gt; is based on how the kernel exports CPU bitmasks via
sysfs files. Some examples:

* Input  
  Equivalent to
* all  
  all cores
* 0-3  
  0,1,2,3
* 0-7:2  
  0,2,4,6
* 1,3,5-7  
  1,3,5,6,7
* 0-3:2,8-15:4  
  0,2,8,12	

--version,  -v
Print the package name and version number.


<a name="see-also"></a>

# See Also

cpupower-set(1), cpupower-info(1), cpupower-idle-info(1),
cpupower-idle-set(1), cpupower-frequency-set(1), cpupower-frequency-info(1),
cpupower-monitor(1), powertop(1)


<a name="authors"></a>

# Authors

    --perf-bias parts written by Len Brown <len.brown@intel.com>
    Thomas Renninger <trenn@suse.de>
