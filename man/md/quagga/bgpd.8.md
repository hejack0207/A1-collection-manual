# bgpd(8) - a BGPv4, BGPv4\+, BGPv4\- routing engine for use with Quagga routing

Quagga BGPD daemon, 25 November 2004

software


<a name="synopsis"></a>

# Synopsis

```
bgpd [ -dhrSv ] [ -f config-file ] [ -i pid-file ] [ -p bgp-port-number ] [ -P port-number ] [ -A vty-address ] [ -u user ] [ -g group ]
```

<a name="description"></a>

# Description

**bgpd**
is a routing component that works with the 
**Quagga**
routing engine.

<a name="options"></a>

# Options

Options available for the
**bgpd**
command:

* **-d**, **--daemon**  
  Runs in daemon mode, forking and exiting from tty.
* **-f**, **--config-file **_config-file_   
  Specifies the config file to use for startup. If not specified this
  option will likely default to **/usr/local/etc/bgpd.conf**.
* **-g**, **--group **_group_  
  Specify the group to run as. Default is _quagga_.
* **-h**, **--help**  
  A brief message.
* **-i**, **--pid_file **_pid-file_  
  When bgpd starts its process identifier is written to
  **pid-file**.  The init system uses the recorded PID to stop or
  restart bgpd.  The likely default is **/var/run/bgpd.pid**.
* **-p**, **--bgp_port **_bgp-port-number_  
  Set the port that bgpd will listen to for bgp data.  
* **-P**, **--vty_port **_port-number_   
  Specify the port that the bgpd VTY will listen on. This defaults to
  2605, as specified in _/etc/services_.
* **-A**, **--vty_addr **_vty-address_  
  Specify the address that the bgpd VTY will listen on. Default is all
  interfaces.
* **-u**, **--user **_user_  
  Specify the user to run as. Default is _quagga_.
* **-r**, **--retain**   
  When the program terminates, retain routes added by **bgpd**.
* **-S**, **--skip\_runas**   
  Skip setting the process effective user and group.
* **-v**, **--version**  
  Print the version and exit.

<a name="files"></a>

# Files


* **/usr/local/sbin/bgpd**  
  The default location of the 
  **bgpd**
  binary.
* **/usr/local/etc/bgpd.conf**  
  The default location of the 
  **bgpd**
  config file.
* **$(PWD)/bgpd.log**  
  If the 
  **bgpd**
  process is config'd to output logs to a file, then you will find this
  file in the directory where you started **bgpd**.

<a name="warning"></a>

# Warning

This man page is intended to be a quick reference for command line
options. The definitive document is the Info file **Quagga**.

<a name="diagnostics"></a>

# Diagnostics

The bgpd process may log to standard output, to a VTY, to a log
file, or through syslog to the system logs. **bgpd** supports many
debugging options, see the Info file, or the source for details.

<a name="see-also"></a>

# See Also

**ripd**(8),
**ripngd**(8),
**ospfd**(8),
**ospf6d**(8),
**isisd**(8),
**nhrpd**(8),
**zebra**(8),
**vtysh**(1)

<a name="bugs"></a>

# Bugs

**bgpd**
eats bugs for breakfast. If you have food for the maintainers try 
**http://bugzilla.quagga.net**

<a name="authors"></a>

# Authors

See
**http://www.zebra.org**
and
**http://www.quagga.net**
or the Info file for an accurate list of authors.

