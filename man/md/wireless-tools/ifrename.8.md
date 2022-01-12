# ifrename(8) - rename network interfaces based on various static criteria

wireless-tools, 26 February 2007

```
"ifrename [-c configfile] [-p] [-d] [-u] [-v] [-V] [-D]"
"ifrename [-c configfile] [-i interface] [-n newname]"
```




<a name="description"></a>

# Description

**Ifrename**
is a tool allowing you to assign a consistent name to each of your
network interface.

By default, interface names are dynamic, and each network interface is
assigned the first available name
(_eth0_, _eth1_...).
The order network interfaces are created may vary. For built-in
interfaces, the kernel boot time enumeration may vary. For removable
interface, the user may plug them in any order.

**Ifrename**
allow the user to decide what name a network interface will have.
**Ifrename**
can use a variety of
_selectors_
to specify how interface names match the network interfaces on the
system, the most common selector is the interface 
_MAC address_.

**Ifrename**
must be run before interfaces are brought up, which is why it's mostly
useful in various scripts (init, hotplug) but is seldom used directly
by the user. By default,
**ifrename**
renames all present system interfaces using mappings defined in
_/etc/iftab_.




<a name="parameters"></a>

# Parameters


* **-c **_configfile_  
  Set the configuration file to be used (by default 
  _/etc/iftab_).
  The configuration file define the mapping between selectors and
  interface names, and is described in
  _iftab_(5).  
  If
  _configfile_
  is "-", the configuration is read from stdin.
* **-p**  
  Probe (load) kernel modules before renaming interfaces. By default
  **ifrename**
  only check interfaces already loaded, and doesn't auto-load the
  required kernel modules. This option enables smooth integration with
  system not loading modules before calling
  **ifrename**.
* **-d**  
  Enable various
  **Debian**
  specific hacks. Combined with
  **-p**,
  only modules for interfaces specified in
  _/etc/network/interface_
  are loaded.
* **-i **_interface_  
  Only rename the specified
  _interface_
  as opposed to all interfaces on the system. The new interface name is
  printed.
* **-n **_newname_  
  When used with
  _-i_,
  specify the new name of the interface. The list of mappings from the
  configuration file is bypassed, the interface specified with
  _-i_
  is renamed directly to
  _newname_.
  The new name may be a wildcard containing a single '*'.  
  When used without 
  _-i_,
  rename interfaces by using only mappings that would rename them to
  _newname_.
  The new name may not be a wildcard. This use of ifrename is
  discouraged, because inefficient
  (_-n_ without _-i_).
  All the interfaces of the system need to be processed at each
  invocation, therefore in most case it is not faster than just letting
  ifrename renaming all of them (without both 
  _-n_ and _-i_).
* **-t**  
  Enable name takeover support. This allow interface name swapping
  between two or more interfaces.  
  Takeover enable an interface to 'steal' the name of another
  interface. This works only with kernel 2.6.X and if the other
  interface is down. Consequently, this is not compatible with
  Hotplug. The other interface is assigned a random name, but may be
  renamed later with 'ifrename'.  
  The number of takeovers is limited to avoid circular loops, and
  therefore some complex multi-way name swapping situations may not be
  fully processed.  
  In any case, name swapping and the use of this feature is discouraged,
  and you are invited to choose unique and unambiguous names for your
  interfaces...
* **-u**  
  Enable
  _udev_
  output mode. This enables proper integration of
  **ifrename**
  in the
  _udev_
  framework,
  **udevd**(8)
  will use
  **ifrename**
  to assign interface names present in
  _/etc/iftab_.
  In this mode the output of ifrename can be parsed
  directly by
  **udevd**(8)
  as an IMPORT action. This requires
  _udev_
  version 107 or later.
* **-D**  
  Dry-run mode. Ifrename won't change any interface, it will only print
  new interface name, if applicable, and return.  
  In dry-run mode, interface name wildcards are not resolved. New
  interface name is printed, even if it is the same as the old name.  
  Be also aware that some selectors can only be read by root, for
  example those based on
  **ethtool**),
  and will fail silently if run by a normal user. In other words,
  dry-run mode under a standard user may not give the expected result.
* **-V**  
  Verbose mode. Ifrename will display internal results of parsing its
  configuration file and querying the interfaces selectors. Combined
  with the
  _dry-run_
  option, this is a good way to debug complex configurations or trivial
  problems.
  
  
  

<a name="author"></a>

# Author

Jean Tourrilhes - [jt@hpl.hp](mailto:jt@hpl.hp).com




<a name="files"></a>

# Files

_/etc/iftab_




<a name="see-also"></a>

# See Also

**ifconfig**(8),
**ip**(8),
**iftab**(5).
