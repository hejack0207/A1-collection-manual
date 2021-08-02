# cpupower\-frequency\-set(1)

"", 0.1


cpupower-frequency-set - A small tool which allows to modify cpufreq settings.

<a name="syntax"></a>

# Syntax

```

 cpupower [ -c cpu ] frequency-set [options]
```

<a name="description"></a>

# Description


cpupower frequency-set allows you to modify cpufreq settings without having to type e.g. "/sys/devices/system/cpu/cpu0/cpufreq/scaling_set_speed" all the time.

<a name="options"></a>

# Options



* **-d** **--min** &lt;FREQ&gt;  
  new minimum CPU frequency the governor may select.
* **-u** **--max** &lt;FREQ&gt;  
  new maximum CPU frequency the governor may select.
* **-g** **--governor** &lt;GOV&gt;  
  new cpufreq governor.
* **-f** **--freq** &lt;FREQ&gt;  
  specific frequency to be set. Requires userspace governor to be available and loaded.
* **-r** **--related**  
  modify all hardware-related CPUs at the same time
* 
<a name="remarks"></a>

# Remarks


By default values are applied on all cores. How to modify single core
configurations is described in the cpupower(1) manpage in the --cpu option section.

The -f FREQ, --freq FREQ parameter cannot be combined with any other parameter.

FREQuencies can be passed in Hz, kHz (default), MHz, GHz, or THz by postfixing the value with the wanted unit name, without any space (frequency in kHz =^ Hz * 0.001 =^ MHz * 1000 =^ GHz * 1000000).

On Linux kernels up to 2.6.29, the -r or --related parameter is ignored.

<a name="files-"></a>

# "Files" 

    /sys/devices/system/cpu/cpu*/cpufreq/  
    /proc/cpufreq (deprecated) 
    /proc/sys/cpu/ (deprecated)

<a name="authors"></a>

# Authors

    Dominik Brodowski <linux@brodo.de> - author 
    Mattia Dongili<malattia@gmail.com> - first autolibtoolization

<a name="see-also"></a>

# See Also


cpupower-frequency-info(1), cpupower(1)
