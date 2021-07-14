# zebra(8) - a routing manager for use with associated Quagga components.

Zebra daemon, 25 November 2004

```
zebra [ -bdhklrv ] [ -f config-file ] [ -i pid-file ] [ -P port-number ] [ -A vty-address ] [ -u user ] [ -g group ]
```

<a name="description"></a>

# Description

**zebra**
is a routing manager that implements the 
**zebra**
route engine.
**zebra**
supports RIPv1, RIPv2, RIPng, OSPF, OSPF6, IS-IS, BGP4+, and BGP4-.

<a name="options"></a>

# Options

Options available for the
**zebra**
command:

* **-b**, **--batch**  
  Runs in batch mode, **zebra** parses its config and exits.
* **-d**, **--daemon**  
  Runs in daemon mode, forking and exiting from tty.
* **-f**, **--config-file **_config-file_  
  Specifies the config file to use for startup. If not specified this
  option will likely default to **/usr/local/etc/zebra.conf**.
* **-g**, **--group **_group_  
  Specify the group to run as. Default is _quagga_.
* **-h**, **--help**  
  A brief message.
* **-i**, **--pid_file **_pid-file_  
  When zebra starts its process identifier is written to
  **pid-file**.  The init system uses the recorded PID to stop or
  restart zebra.  The likely default is **/var/run/zebra.pid**.
* **-k**, **--keep\_kernel**  
  On startup, don't delete self inserted routes.
* **-P**, **--vty_port **_port-number_   
  Specify the port that the zebra VTY will listen on. This defaults to
  2601, as specified in **/etc/services**.
* **-A**, **--vty_addr **_vty-address_  
  Specify the address that the zebra VTY will listen on. Default is all
  interfaces.
* **-u**, **--user **_user_  
  Specify the user to run as. Default is _quagga_.
* **-r**, **--retain**   
  When the program terminates, retain routes added by **zebra**.
* **-s**, **--nl-bufsize **_netlink-buffer-size_  
  Set netlink receive buffer size. There are cases where zebra daemon can't
  handle flood of netlink messages from kernel. If you ever see "recvmsg overrun"
  messages in zebra log, you are in trouble.
  
  Solution is to increase receive buffer of netlink socket. Note that kernel
  &lt; 2.6.14 doesn't allow increasing it over the maximum value defined in
  _/proc/sys/net/core/rmem\_max_. If you want to do it, you have to increase
  maximum before starting zebra.
  
  Note that this affects Linux only.
* **-v**, **--version**  
  Print the version and exit.

<a name="files"></a>

# Files


* **/usr/local/sbin/zebra**  
  The default location of the 
  **zebra**
  binary.
* **/usr/local/etc/zebra.conf**  
  The default location of the 
  **zebra**
  config file.
* **$(PWD)/zebra.log**  
  If the 
  **zebra**
  process is config'd to output logs to a file, then you will find this
  file in the directory where you started **zebra**.

<a name="warning"></a>

# Warning

This man page is intended to be a quick reference for command line
options. The definitive document is the Info file **Quagga**.

<a name="diagnostics"></a>

# Diagnostics

The zebra process may log to standard output, to a VTY, to a log
file, or through syslog to the system logs. **zebra** supports many
debugging options, see the Info file, or the source for details.

<a name="see-also"></a>

# See Also

**bgpd**(8),
**ripd**(8),
**ripngd**(8),
**ospfd**(8),
**ospf6d**(8),
**isisd**(8),
**nhrpd**(8),
**vtysh**(1)

<a name="bugs"></a>

# Bugs

**zebra**
eats bugs for breakfast. If you have food for the maintainers try
**http://bugzilla.quagga.net**

<a name="authors"></a>

# Authors

See
**http://www.zebra.org**
and
**http://www.quagga.net**
or the Info file for an accurate list of authors.

