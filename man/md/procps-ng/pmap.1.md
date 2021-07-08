# pmap(1) - report memory map of a process

procps-ng, September 2012

```
pmap [options] pid [...]
```

<a name="description"></a>

# Description

The pmap command reports the memory map of a process or processes.

<a name="options"></a>

# Options


* **-x**, **--extended**  
  Show the extended format.
* **-d**, **--device**  
  Show the device format.
* **-q**, **--quiet**  
  Do not display some header or footer lines.
* **-A**, **--range** _low_,_high_  
  Limit results to the given range to
  _low_
  and
  _high_
  address range.  Notice that the low and high arguments are single string
  separated with comma.
* **-X**  
  Show even more details than the **-x** option. WARNING: format changes
  according to _/proc/PID/smaps_
* **-XX**  
  Show everything the kernel provides
* **-p**, **--show-path**  
  Show full path to files in the mapping column
* **-c**, **--read-rc**  
  Read the default configuration
* **-C**, **--read-rc-from** _file_  
  Read the configuration from _file_
* **-n**, **--create-rc**  
  Create new default configuration
* **-N**, **--create-rc-to** _file_  
  Create new configuration to _file_
* **-h**, **--help**  
  Display help text and exit.
* **-V**, **--version**  
  Display version information and exit.

<a name="exit-status"></a>

# Exit Status



* **0**
  Success.
* **1**
  Failure.
* **42**
  Did not find all processes asked for.

<a name="see-also"></a>

# See Also

**ps**(1),
**pgrep**(1)

<a name="standards"></a>

# Standards

No standards apply, but pmap looks an awful lot like a SunOS command.

<a name="reporting-bugs"></a>

# Reporting Bugs

Please send bug reports to
.UR procps@freelists.org
.UE
