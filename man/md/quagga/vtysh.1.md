# vtysh(1) - a integrated shell for Quagga routing software

Quagga VTY shell, 27 July 2006

```
vtysh [ -b ]
vtysh [ -E ] [ -d daemon ] ] [ -c command ]
```

<a name="description"></a>

# Description

**vtysh**
is a integrated shell for
**Quagga**
routing engine.

<a name="options"></a>

# Options

Options available for the
**vtysh**
command:

* **-b, --boot**  
  Execute boot startup configuration. It makes sense only if integrated config
  file is in use (not default in Quagga). See Info file **Quagga** for more
  info.
* **-c, --command command**  
  Specify command to be executed under batch mode. It behaves like -c option in
  any other shell -
  _command_
  is executed and
  **vtysh**
  exits.
  
  It's useful for gathering info from Quagga routing software or reconfiguring
  daemons from inside shell scripts, etc.
  Note that multiple commands may be executed by using more than one
  -c option and/or embedding linefeed characters inside the
  _command_
  string.
* **-d, --daemon daemon\_name**  
  Specify which daemon to connect to.  By default,
  **vtysh**
  attempts to connect to all Quagga daemons running on the system.  With this
  flag, one can specify a single daemon to connect to instead.  For example,
  specifying '-d ospfd' will connect only to ospfd.  This can be particularly
  useful inside scripts with -c where the command is targeted for a single daemon.
* **-e, --execute command**  
  Alias for -c. It's here only for compatibility with Zebra routing software and
  older Quagga versions. This will be removed in future.
* **-E, --echo**  
  When the -c option is being used, this flag will cause the standard
  **vtysh**
  prompt and command to be echoed prior to displaying the results.
  This is particularly useful to separate the results
  when executing multiple commands.
* **-h, --help**  
  Display a usage message on standard output and exit.

<a name="environment-variables"></a>

# Environment Variables


* **VTYSH\_PAGER**  
  This should be the name of the pager to use. Default is **more**.

<a name="files"></a>

# Files


* **/usr/local/etc/vtysh.conf**  
  The default location of the 
  **vtysh**
  config file.
* **/usr/local/etc/Quagga.conf**  
  The default location of the integrated Quagga routing engine config file
  if integrated config file is in use (not default).
* **${HOME}/.history_quagga**  
  Location of history of commands entered via cli

<a name="warning"></a>

# Warning

This man page is intended to be a quick reference for command line
options. The definitive document is the Info file **Quagga**.

<a name="see-also"></a>

# See Also

**bgpd**(8),
**ripd**(8),
**ripngd**(8),
**ospfd**(8),
**ospf6d**(8),
**isisd**(8),
**zebra**(8)

<a name="bugs"></a>

# Bugs

**vtysh**
eats bugs for breakfast. If you have food for the maintainers try 
**http://bugzilla.quagga.net**

<a name="authors"></a>

# Authors

See
**http://www.zebra.org**
and
**http://www.quagga.net**
or the Info file for an accurate list of authors.

