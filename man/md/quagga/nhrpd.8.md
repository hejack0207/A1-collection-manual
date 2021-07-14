# nhrp(8) - a Next Hop Routing Protocol routing engine for use with Quagga routing software.

Quagga NHRP daemon, 24 January 2017

```
nhrpd [ -dhv ] [ -f config-file ] [ -i pid-file ] [ -P port-number ] [ -A vty-address ] [ -u user ] [ -g group ]
```

<a name="description"></a>

# Description

**nhrpd**
is a routing component that works with the
**Quagga**
routing engine.

<a name="options"></a>

# Options

Options available for the
**nhrpd**
command:

* **-d**, **--daemon**  
  Runs in daemon mode, forking and exiting from tty.
* **-f**, **--config-file **_config-file_  
  Specifies the config file to use for startup. If not specified this
  option will likely default to **/usr/local/etc/nhrpd.conf**.
* **-g**, **--group **_group_  
  Specify the group to run as. Default is _quagga_.
* **-h**, **--help**  
  A brief message.
* **-i**, **--pid_file **_pid-file_  
  When nhrpd starts its process identifier is written to
  **pid-file**.  The init system uses the recorded PID to stop or
  restart nhrpd.  The likely default is **/var/run/nhrpd.pid**.
* **-P**, **--vty_port **_port-number_  
  Specify the port that the nhrpd VTY will listen on. This defaults to
  2608, as specified in **/etc/services**.
* **-A**, **--vty_addr **_vty-address_  
  Specify the address that the nhrpd VTY will listen on. Default is all
  interfaces.
* **-u**, **--user **_user_  
  Specify the user to run as. Default is _quagga_.
* **-v**, **--version**  
  Print the version and exit.

<a name="files"></a>

# Files


* **/usr/local/sbin/nhrpd**  
  The default location of the
  **nhrpd**
  binary.
* **/usr/local/etc/nhrpd.conf**  
  The default location of the
  **nhrpd**
  config file.
* **$(PWD)/nhrpd.log**  
  If the
  **nhrpd**
  process is config'd to output logs to a file, then you will find this
  file in the directory where you started **nhrpd**.

<a name="warning"></a>

# Warning

This man page is intended to be a quick reference for command line
options. The definitive document is the Info file **Quagga**.

<a name="diagnostics"></a>

# Diagnostics

The nhrpd process may log to standard output, to a VTY, to a log
file, or through syslog to the system logs. **nhrpd** supports many
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

**nhrpd**
eats bugs for breakfast. If you have food for the maintainers try
**http://bugzilla.quagga.net**

<a name="authors"></a>

# Authors

Timo Teräs &lt;[timo.teras@iki.fi](mailto:timo.teras@iki.fi)&gt;
