# cpupower\-frequency\-info(1)

"", 0.1


cpupower-frequency-info - Utility to retrieve cpufreq kernel information

<a name="syntax"></a>

# Syntax

```

 cpupower [ -c cpulist ] frequency-info [options]
```

<a name="description"></a>

# Description


A small tool which prints out cpufreq information helpful to developers and interested users.

<a name="options"></a>

# Options



* **-e** **--debug**  
  Prints out debug information.
* **-f** **--freq**  
  Get frequency the CPU currently runs at, according to the cpufreq core.
* **-w** **--hwfreq**  
  Get frequency the CPU currently runs at, by reading it from hardware (only available to root).
* **-l** **--hwlimits**  
  Determine the minimum and maximum CPU frequency allowed.
* **-d** **--driver**  
  Determines the used cpufreq kernel driver.
* **-p** **--policy**  
  Gets the currently used cpufreq policy.
* **-g** **--governors**  
  Determines available cpufreq governors.
* **-a** **--related-cpus**  
  Determines which CPUs run at the same hardware frequency.
* **-a** **--affected-cpus**  
  Determines which CPUs need to have their frequency coordinated by software.
* **-s** **--stats**  
  Shows cpufreq statistics if available.
* **-y** **--latency**  
  Determines the maximum latency on CPU frequency changes.
* **-o** **--proc**  
  Prints out information like provided by the /proc/cpufreq interface in 2.4. and early 2.6. kernels.
* **-m** **--human**  
  human-readable output for the -f, -w, -s and -y parameters.
* **-n** **--no-rounding**  
  Output frequencies and latencies without rounding off values.
* 
<a name="remarks"></a>

# Remarks


By default only values of core zero are displayed. How to display settings of
other cores is described in the cpupower(1) manpage in the --cpu option section.

You can't specify more than one of the output specific options -o -e -a -g -p -d -l -w -f -y.

You also can't specify the -o option combined with the -c option.

<a name="files"></a>

# Files

    /sys/devices/system/cpu/cpu*/cpufreq/  
    /proc/cpufreq (deprecated) 
    /proc/sys/cpu/ (deprecated)

<a name="authors"></a>

# Authors

    Dominik Brodowski <linux@brodo.de> - author 
    Mattia Dongili<malattia@gmail.com> - first autolibtoolization

<a name="see-also"></a>

# See Also


cpupower-frequency-set(1), cpupower(1)
