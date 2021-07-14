# is-is(8) - an IS-IS routing engine for use with Quagga routing software.

Quagga IS-IS daemon, 25 November 2004

```
isisd [ -dhv ] [ -f config-file ] [ -i pid-file ] [ -P port-number ] [ -A vty-address ] [ -u user ] [ -g group ]
```

<a name="description"></a>

# Description

**isisd**
is a routing component that works with the
**Quagga**
routing engine.

<a name="options"></a>

# Options

Options available for the
**isisd**
command:

* **-d**, **--daemon**  
  Runs in daemon mode, forking and exiting from tty.
* **-f**, **--config-file **_config-file_   
  Specifies the config file to use for startup. If not specified this
  option will likely default to **/usr/local/etc/isisd.conf**.
* **-g**, **--group **_group_  
  Specify the group to run as. Default is _quagga_.
* **-h**, **--help**  
  A brief message.
* **-i**, **--pid_file **_pid-file_  
  When isisd starts its process identifier is written to
  **pid-file**.  The init system uses the recorded PID to stop or
  restart isisd.  The likely default is **/var/run/isisd.pid**.
* **-P**, **--vty_port **_port-number_   
  Specify the port that the isisd VTY will listen on. This defaults to
  2608, as specified in **/etc/services**.
* **-A**, **--vty_addr **_vty-address_  
  Specify the address that the isisd VTY will listen on. Default is all
  interfaces.
* **-u**, **--user **_user_  
  Specify the user to run as. Default is _quagga_.
* **-v**, **--version**  
  Print the version and exit.

<a name="files"></a>

# Files


* **/usr/local/sbin/isisd**  
  The default location of the 
  **isisd**
  binary.
* **/usr/local/etc/isisd.conf**  
  The default location of the 
  **isisd**
  config file.
* **$(PWD)/isisd.log**  
  If the 
  **isisd**
  process is config'd to output logs to a file, then you will find this
  file in the directory where you started **isisd**.

<a name="warning"></a>

# Warning

This man page is intended to be a quick reference for command line
options. The definitive document is the Info file **Quagga**.

<a name="diagnostics"></a>

# Diagnostics

The isisd process may log to standard output, to a VTY, to a log
file, or through syslog to the system logs. **isisd** supports many
debugging options, see the Info file, or the source for details.

<a name="see-also"></a>

# See Also

**bgpd**(8),
**ripd**(8),
**ripngd**(8),
**ospfd**(8),
**ospf6d**(8),
**zebra**(8),
**vtysh**(1)

<a name="bugs"></a>

# Bugs

**isisd** is ALPHA quality at the moment and hasn't any way ready for
production use.

**isisd**
eats bugs for breakfast. If you have food for the maintainers try
**http://bugzilla.quagga.net**

<a name="authors"></a>

# Authors

See
**http://isisd.sourceforge.net**
or the Info file for an accurate list of authors.

