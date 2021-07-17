# lvmconf(8) - LVM configuration modifier

Red Hat, Inc, LVM TOOLS 2.02.183(2) (2018-12-07)

```
lvmconf [--disable-cluster] [--enable-cluster] [--enable-halvm] [--disable-halvm] [--file <configfile>] [--lockinglib <lib>] [--lockinglibdir <dir>] [--services] [--mirrorservice] [--startstopservices]
```


<a name="description"></a>

# Description

lvmconf is a script that modifies the locking configuration in
an lvm configuration file. See **lvm.conf**(5). In addition
to that, it can also set Systemd or SysV services according to
changes in the lvm configuration if needed.


<a name="options"></a>

# Options


* **--disable-cluster**  
  Set **locking\_type** to the default non-clustered type. Also reset
  lvmetad use to its default.
* **--enable-cluster**  
  Set **locking\_type** to the default clustered type on this system.
  Also disable lvmetad use as it is not yet supported in clustered environment.
* **--disable-halvm**  
  Set **locking\_type** to the default non-clustered type. Also reset
  lvmetad use to its default.
* **--enable-halvm**  
  Set **locking\_type** suitable for HA LVM use.
  Also disable lvmetad use as it is not yet supported in HA LVM environment.
* **--file** &lt;**configfile**&gt;  
  Apply the changes to _configfile_ instead of the default
  _/etc/lvm/lvm.conf_.
* **--lockinglib** &lt;**lib**&gt;  
  Set external **locking\_library** locking library to load if an external locking type is used.
* **--lockinglibdir** &lt;**dir**&gt;  
* **--services**  
  In addition to setting the lvm configuration, also enable or disable related Systemd or SysV
  clvmd and lvmetad services. This script does not configure services provided by cluster resource
  agents.
* **--mirrorservice**  
  Also enable or disable optional cmirrord service when handling services (applicable only with --services).
* **--startstopservices**  
  In addition to enabling or disabling related services, start or stop them immediately
  (applicable only with --services).

<a name="files"></a>

# Files

_/etc/lvm/lvm.conf_


<a name="see-also"></a>

# See Also

**lvm**(8),
**lvm.conf**(5)
