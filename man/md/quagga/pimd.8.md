# pim(8) - a PIM routing for use with Quagga Routing Suite.

Quagga PIM daemon, 10 December 2008

```
pimd [ -dhvZ ] [ -f config-file ] [ -i pid-file ] [ -z path ] [ -P port-number ] [ -A vty-address ] [ -u user ] [ -g group ]
```

<a name="description"></a>

# Description

**pimd**
is a protocol-independent multicast component that works with the
**Quagga**
Routing Suite.

<a name="options"></a>

# Options

Options available for the
**pimd**
command:

* **-d**, **--daemon**  
  Runs in daemon mode, forking and exiting from tty.
* **-f**, **--config-file **_config-file_   
  Specifies the config file to use for startup. If not specified this
  option will likely default to **/usr/local/etc/pimd.conf**.
* **-g**, **--group **_group_  
  Specify the group to run as. Default is _quagga_.
* **-h**, **--help**  
  A brief message.
* **-i**, **--pid_file **_pid-file_  
  When pimd starts its process identifier is written to
  **pid-file**.  The init system uses the recorded PID to stop or
  restart pimd.  The likely default is **/var/run/pimd.pid**.
* **-z**, **--socket **_path_  
  Specify the socket path for contacting the zebra daemon.
  The likely default is **/var/run/zserv.api**.
* **-P**, **--vty_port **_port-number_   
  Specify the port that the pimd VTY will listen on. This defaults to
  2611, as specified in **/etc/services**.
* **-A**, **--vty_addr **_vty-address_  
  Specify the address that the pimd VTY will listen on. Default is all
  interfaces.
* **-u**, **--user **_user_  
  Specify the user to run as. Default is _quagga_.
* **-v**, **--version**  
  Print the version and exit.
* **-Z**, **--debug\_zclient**  
  Enable logging information for zclient debugging.

<a name="files"></a>

# Files


* **/usr/local/sbin/pimd**  
  The default location of the 
  **pimd**
  binary.
* **/usr/local/etc/pimd.conf**  
  The default location of the 
  **pimd**
  config file.
* **/var/run/pimd.pid**  
  The default location of the 
  **pimd**
  pid file.
* **/var/run/zserv.api**  
  The default location of the 
  **zebra**
  unix socket file.
* **$(PWD)/pimd.log**  
  If the 
  **pimd**
  process is config'd to output logs to a file, then you will find this
  file in the directory where you started **pimd**.

<a name="warning"></a>

# Warning

This man page is intended to be a quick reference for command line
options.

<a name="diagnostics"></a>

# Diagnostics

The pimd process may log to standard output, to a VTY, to a log
file, or through syslog to the system logs.

<a name="see-also"></a>

# See Also

**zebra**(8),
**vtysh**(1)

<a name="bugs"></a>

# Bugs

**pimd** is in early development at the moment and is not ready for
production use.

**pimd**
eats bugs for breakfast. If you have food for the maintainers try
**https://github.com/udhos/qpimd**

<a name="authors"></a>

# Authors

See
**https://github.com/udhos/qpimd**
for an accurate list of authors.

