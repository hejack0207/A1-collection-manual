# ospf6d(8) - an OSPFv3 routing engine for use with Quagga routing software.

Quagga OSPFv3 daemon, 25 November 2004

```
ospf6d [ -dhv ] [ -f config-file ] [ -i pid-file ] [ -P port-number ] [ -A vty-address ] [ -u user ] [ -g group ]
```

<a name="description"></a>

# Description

**ospf6d**
is a routing component that works with the
**Quagga**
routing engine.

<a name="options"></a>

# Options

Options available for the
**ospf6d**
command:

<a name="options"></a>

# Options


* **-d**, **--daemon**  
  Runs in daemon mode, forking and exiting from tty.
* **-f**, **--config-file **_config-file_   
  Specifies the config file to use for startup. If not specified this
  option will likely default to **/usr/local/etc/ospf6d.conf**.
* **-g**, **--group **_group_  
  Specify the group to run as. Default is _quagga_.
* **-h**, **--help**  
  A brief message.
* **-i**, **--pid_file **_pid-file_  
  When ospf6d starts its process identifier is written to
  **pid-file**.  The init system uses the recorded PID to stop or
  restart ospf6d.  The likely default is **/var/run/ospf6d.pid**.
* **-P**, **--vty_port **_port-number_   
  Specify the port that the ospf6d VTY will listen on. This defaults to
  2606, as specified in **/etc/services**.
* **-A**, **--vty_addr **_vty-address_  
  Specify the address that the ospf6d VTY will listen on. Default is all
  interfaces.
* **-u**, **--user **_user_  
  Specify the user to run as. Default is _quagga_.
* **-v**, **--version**  
  Print the version and exit.

<a name="files"></a>

# Files


* **/usr/local/sbin/ospf6d**  
  The default location of the 
  **ospf6d**
  binary.
* **/usr/local/etc/ospf6d.conf**  
  The default location of the 
  **ospf6d**
  config file.
* **$(PWD)/ospf6d.log**  
  If the 
  **ospf6d**
  process is config'd to output logs to a file, then you will find this
  file in the directory where you started **ospf6d**.

<a name="warning"></a>

# Warning

This man page is intended to be a quick reference for command line
options. The definitive document is the Info file **Quagga**.

<a name="diagnostics"></a>

# Diagnostics

The ospf6d process may log to standard output, to a VTY, to a log
file, or through syslog to the system logs. **ospf6d** supports many
debugging options, see the Info file, or the source for details.

<a name="see-also"></a>

# See Also

**bgpd**(8),
**ripd**(8),
**ripngd**(8),
**ospfd**(8),
**isisd**(8),
**zebra**(8),
**vtysh**(1)

<a name="bugs"></a>

# Bugs

**ospf6d**
eats bugs for breakfast. If you have food for the maintainers try
**http://bugzilla.quagga.net**

<a name="authors"></a>

# Authors

See
**http://www.zebra.org**
and
**http://www.quagga.net**
or the Info file for an accurate list of authors.

