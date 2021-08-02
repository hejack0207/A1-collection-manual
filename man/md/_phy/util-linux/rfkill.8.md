# rfkill(8) - tool for enabling and disabling wireless devices

util-linux, 2017-07-06

```
rfkill [options] [command] [id|type&nbsp;...]
```


<a name="description"></a>

# Description

**rfkill**
lists, enabling and disabling wireless devices.

The command "list" output format is deprecated and maintained for backward
compatibility only. The new output format is the default when no command is
specified or when the option **--output** is used.

The default output is subject to change.  So whenever possible, you should
avoid using default outputs in your scripts.  Always explicitly define expected
columns by using the **--output** option together with a columns list in
environments where a stable output is required.



<a name="options"></a>

# Options


* **-J**, **--json**  
  Use JSON output format.
* **-n**, **--noheadings**  
  Do not print a header line.
* **-o**, **--output**  
  Specify which output columns to print.  Use --help to get a list of
  available columns.
* **--output-all**  
  Output all available columns.
* **-r**, **--raw**  
  Use the raw output format.
* **--help**  
  Display help text and exit.
* **--version**  
  Display version information and exit.

<a name="commands"></a>

# Commands


* **help**  
  Display help text and exit.
* **event**  
  Listen for rfkill events and display them on stdout.
* **list **[_id_|_type_ ...]  
  List the current state of all available devices.  The command output format is deprecated, see the section DESCRIPTION.
  It is a good idea to check with
  **list**
  command
  _id_ or _type_
  scope is appropriate before setting
  **block** or **unblock**.
  Special
  _all_
  type string will match everything.  Use of multiple
  _id_ or _type_
  arguments is supported.
* **block id**|**type** [...]  
  Disable the corresponding device.
* **unblock id**|**type** [...]  
  Enable the corresponding device.  If the device is hard-blocked, for example
  via a hardware switch, it will remain unavailable though it is now
  soft-unblocked.

<a name="examples"></a>

# Examples

rfkill --output ID,TYPE  
rfkill block all  
rfkill unblock wlan  
rfkill block bluetooth uwb wimax wwan gps fm nfc

<a name="authors"></a>

# Authors

**rfkill**
was originally written by
.MT johannes@​sipsolutions.​net
Johannes Berg
.ME
and
.MT marcel@​holtmann.​org
Marcel Holtmann
.ME .
The code has been later modified by
.MT kerolasa@​iki.​fi
Sami Kerola
.ME
and
.MT kzak@​redhat.​com
Karel Zak
.ME
for util-linux project.

This manual page was written by
.MT linux@​youmustbejoking.​demon.​co.uk
Darren Salt
.ME ,
for the Debian project (and may be used by others).

<a name="see-also"></a>

# See Also

**powertop**(8),
**systemd-rfkill**(8),
[Linux kernel documentation](https://​git.​kernel.​org/​pub/​scm/​linux/​kernel/​git/​torvalds/​linux.git/​tree/​Documentation/​rfkill.txt)

<a name="availability"></a>

# Availability

The rfkill command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
