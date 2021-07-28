# cpupower-idle-set(1)

"", 0.1


cpupower-idle-set - Utility to set cpu idle state specific kernel options

<a name="syntax"></a>

# Syntax

```

 cpupower [ -c cpulist ] idle-info [options]
```

<a name="description"></a>

# Description


The cpupower idle-set subcommand allows to set cpu idle, also called cpu
sleep state, specific options offered by the kernel. One example is disabling
sleep states. This can be handy for power vs performance tuning.

<a name="options"></a>

# Options



* **-d** **--disable** &lt;STATE_NO&gt;  
  Disable a specific processor sleep state.
* **-e** **--enable** &lt;STATE_NO&gt;  
  Enable a specific processor sleep state.
* **-D** **--disable-by-latency** &lt;LATENCY&gt;  
  Disable all idle states with a equal or higher latency than &lt;LATENCY&gt;.
  
  Enable all idle states with a latency lower than &lt;LATENCY&gt;.
* **-E** **--enable-all**  
  Enable all idle states if not enabled already.
  

<a name="remarks"></a>

# Remarks


Cpuidle Governors Policy on Disabling Sleep States

Depending on the used  cpuidle governor, implementing the kernel policy
how to choose sleep states, subsequent sleep states on this core, might get
disabled as well.

There are two cpuidle governors ladder and menu. While the ladder
governor is always available, if CONFIG_CPU_IDLE is selected, the
menu governor additionally requires CONFIG_NO_HZ.

The behavior and the effect of the disable variable depends on the
implementation of a particular governor. In the ladder governor, for
example, it is not coherent, i.e. if one is disabling a light state,
then all deeper states are disabled as well. Likewise, if one enables a
deep state but a lighter state still is disabled, then this has no effect.

Disabling the Lightest Sleep State may not have any Affect

If criteria are not met to enter deeper sleep states and the lightest sleep
state is chosen when idle, the kernel may still enter this sleep state,
irrespective of whether it is disabled or not. This is also reflected in
the usage count of the disabled sleep state when using the cpupower idle-info
command.

Selecting specific CPU Cores

By default processor sleep states of all CPU cores are set. Please refer
to the cpupower(1) manpage in the --cpu option section how to disable
C-states of specific cores.

<a name="files"></a>

# Files

    /sys/devices/system/cpu/cpu*/cpuidle/state*
    /sys/devices/system/cpu/cpuidle/*

<a name="authors"></a>

# Authors

    Thomas Renninger <trenn@suse.de>

<a name="see-also"></a>

# See Also


cpupower(1), cpupower-monitor(1), cpupower-info(1), cpupower-set(1),
cpupower-idle-info(1)
