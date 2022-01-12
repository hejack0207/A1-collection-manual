# tuned-main.conf(5) - TuneD global configuration file

Jaroslav Škarvada, 15 Oct 2013

```
/etc/tuned/tuned-main.conf
```

<a name="description"></a>

# Description

This man page documents format of the TuneD global configuration file.
The _tuned-main.conf_ file uses the ini-file format.



* **daemon=**_BOOL_  
  This defines whether TuneD will use daemon or not. It is boolean value.
  It can be **True** or **1** if the daemon is enabled and
  **False** or **0** if disabled. It is not recommended to disable
  daemon, because many functions will not work without daemon, e.g.
  there will be no D-Bus, no settings rollback, no hotplug support,
  no dynamic tuning, ...
  
* **dynamic_tuning=**_BOOL_  
  This defines whether the dynamic tuning is enabled. It is boolean value.
  It can be **True** or **1** if the dynamic tuning is enabled and
  **False** or **0** if disabled. In such case only the static tuning
  will be used. Please note if it is enabled here, it is still possible
  to individually disable it in plugins. It is only applicable if
  **daemon** is enabled.
  
* **sleep_interval=**_INT_  
  TuneD daemon is periodically waken after _INT_ seconds and checks
  for events. By default this is set to 1 second. If you have Python 2
  interpreter with applied patch from Red Hat Bugzilla #917709 this
  controls responsiveness time of TuneD to commands (i.e. if you
  request profile switch, it may take up to 1 second until TuneD reacts).
  Increase this number for higher responsiveness times and more power
  savings (due to lower number of wakeups). In case you have unpatched
  Python 2 interpreter, this settings will have no visible effect,
  because the interpreter will poll 20 times per second. It is only
  applicable if **daemon** is enabled.
  
* **update_interval=**_INT_  
  Update interval for dynamic tuning (in seconds). TuneD daemon is periodically
  waken after _INT_ seconds, updates its monitors, calculates new tuning
  parameters for enabled plugins and applies the changes. Plugins that have
  disabled dynamic tuning are not processed. By default the _INT_ is set
  to 10 seconds. TuneD daemon doesn't periodically wake if dynamic tuning is
  globally disabled (see **dynamic\_tuning**) or this setting set to 0.
  This must be multiple of **sleep\_interval**. It is only applicable if
  **daemon** is enabled.
  
* **recommend_command=**_BOOL_  
  This controls whether recommend functionality will be enabled or not. It is
  boolean value. It can be **True** or **1** if the recommend command is
  enabled and **False** or **0** if disabled. If disabled **recommend**
  command will be not available in CLI, TuneD will not parse _recommend.conf_
  and will return one hardcoded profile (by default **balanced**). It is only
  applicable if **daemon** is enabled. By default it's set to **True**.
  
* **reapply_sysctl=**_BOOL_  
  This controls whether to reapply sysctl settings from _/run/sysctl.d/*.conf_,
  _/etc/sysctl.d/*.conf_ and _/etc/sysctl.conf_ after TuneD sysctl
  settings are applied. These are locations supported by **sysctl --system**,
  excluding those that contain sysctl configuration files provided by system packages.
  So if **reapply\_sysctl** is set to **True** or **1**, TuneD sysctl settings
  will not override user-provided system sysctl settings. If set to **False** or
  **0**, TuneD sysctl settings will override system sysctl settings. By default
  it's set to **True**.
  
* **default_instance_priority=**_INT_  
  Default instance (unit) priority. By default it's **0**. Each unit has a
  priority which is by default preset to the _INT_. It can be overridden
  in the TuneD profile by the **priority** option. TuneD units are processed
  in order defined by their priorities, i.e. unit with the lowest number is
  processed as the first.
  

<a name="example"></a>

# Example

      no_daemon = 0
      dynamic_tuning = 1
      sleep_interval = 1
      update_interval = 10
      recommend_command = 0
      reapply_sysctl = 1
      default_instance_priority = 0


<a name="files"></a>

# Files

_/etc/tuned/tuned-main.conf_


<a name="see-also"></a>

# See Also


tuned(8)

<a name="author"></a>

# Author

Written by Jaroslav Škarvada &lt;[jskarvad@redhat.com](mailto:jskarvad@redhat.com)&gt;.

<a name="reporting-bugs"></a>

# Reporting Bugs

Report bugs to https://bugzilla.redhat.com/.
