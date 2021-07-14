# ripngd(8) - a RIPNG routing engine for use with Quagga routing software.

Quagga RIPNG daemon, 25 November 2004

```
ripngd [ -dhlrv ] [ -f config-file ] [ -i pid-file ] [ -P port-number ] [ -A vty-address ] [ -u user ] [ -g group ]
```

<a name="description"></a>

# Description

**ripngd**
is a routing component that works with the
**Quagga**
routing engine.

<a name="options"></a>

# Options

Options available for the
**ripngd**
command:

<a name="options"></a>

# Options


* **-d**, **--daemon**  
  Runs in daemon mode, forking and exiting from tty.
* **-f**, **--config-file **_config-file_   
  Specifies the config file to use for startup. If not specified this
  option will likely default to **/usr/local/etc/ripngd.conf**.
* **-g**, **--group **_group_  
  Specify the group to run as. Default is _quagga_.
* **-h**, **--help**  
  A brief message.
* **-i**, **--pid_file **_pid-file_  
  When ripngd starts its process identifier is written to
  **pid-file**.  The init system uses the recorded PID to stop or
  restart ripngd.  The likely default is **/var/run/ripngd.pid**.
* **-P**, **--vty_port **_port-number_   
  Specify the port that the ripngd VTY will listen on. This defaults to
  2603, as specified in **/etc/services**.
* **-A**, **--vty_addr **_vty-address_  
  Specify the address that the ripngd VTY will listen on. Default is all
  interfaces.
* **-u**, **--user **_user_  
  Specify the user to run as. Default is _quagga_.
* **-r**, **--retain**   
  When the program terminates, retain routes added by **ripd**.
* **-v**, **--version**  
  Print the version and exit.

<a name="files"></a>

# Files


* **/usr/local/sbin/ripngd**  
  The default location of the 
  **ripngd**
  binary.
* **/usr/local/etc/ripngd.conf**  
  The default location of the 
  **ripngd**
  config file.
* **$(PWD)/ripngd.log**  
  If the 
  **ripngd**
  process is config'd to output logs to a file, then you will find this
  file in the directory where you started **ripngd**.

<a name="warning"></a>

# Warning

This man page is intended to be a quick reference for command line
options. The definitive document is the Info file **Quagga**.

<a name="diagnostics"></a>

# Diagnostics

The ripngd process may log to standard output, to a VTY, to a log
file, or through syslog to the system logs. **ripngd** supports many
debugging options, see the Info file, or the source for details.

<a name="see-also"></a>

# See Also

**bgpd**(8),
**ripd**(8),
**ospfd**(8),
**ospf6d**(8),
**isisd**(8),
**zebra**(8),
**vtysh**(1)

<a name="bugs"></a>

# Bugs

**ripngd**
eats bugs for breakfast. If you have food for the maintainers try
**http://bugzilla.quagga.net**

<a name="authors"></a>

# Authors

See
**http://www.zebra.org**
and
**http://www.quagga.net**
or the Info file for an accurate list of authors.

