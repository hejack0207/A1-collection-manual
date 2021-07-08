# sysctl(8) - configure kernel parameters at runtime

procps-ng, 2018-02-19

```
sysctl [options] [variable[=value]] [...]
sysctl -p [file or regexp] [...]
```

<a name="description"></a>

# Description

**sysctl**
is used to modify kernel parameters at runtime.  The parameters available
are those listed under /proc/sys/.  Procfs is required for
**sysctl**
support in Linux.  You can use
**sysctl**
to both read and write sysctl data.

<a name="parameters"></a>

# Parameters


* _variable_  
  The name of a key to read from.  An example is kernel.ostype.  The '/'
  separator is also accepted in place of a '.'.
* _variable_=_value_  
  To set a key, use the form
  _variable_=_value_
  where
  _variable_
  is the key and
  _value_
  is the value to set it to.  If the value contains quotes or characters
  which are parsed by the shell, you may need to enclose the value in double
  quotes.
* **-n**, **--values**  
  Use this option to disable printing of the key name when printing values.
* **-e**, **--ignore**  
  Use this option to ignore errors about unknown keys.
* **-N**, **--names**  
  Use this option to only print the names.  It may be useful with shells that
  have programmable completion.
* **-q**, **--quiet**  
  Use this option to not display the values set to stdout.
* **-w**, **--write**  
  Use this option when all arguments prescribe a key to be set.
* **-p**[_FILE_], **--load**[=_FILE_]  
  Load in sysctl settings from the file specified or /etc/sysctl.conf if none
  given.  Specifying - as filename means reading data from standard input.
  Using this option will mean arguments to
  **sysctl**
  are files, which are read in the order they are specified.
  The file argument may be specified as regular expression.
* **-a**, **--all**  
  Display all values currently available.
* **--deprecated**  
  Include deprecated parameters to
  **--all**
  values listing.
* **-b**, **--binary**  
  Print value without new line.
* **--system**  
  Load settings from all system configuration files. Files are read from
  directories in the following list in given order from top to bottom.
  Once a file of a given filename is loaded, any file of the same name
  in subsequent directories is ignored.  
  /run/sysctl.d/*.conf  
  /etc/sysctl.d/*.conf  
  /usr/local/lib/sysctl.d/*.conf  
  /usr/lib/sysctl.d/*.conf  
  /lib/sysctl.d/*.conf  
  /etc/sysctl.conf
* **-r**, **--pattern** _pattern_  
  Only apply settings that match
  _pattern_.
  The
  _pattern_
  uses extended regular expression syntax.
* **-A**  
  Alias of **-a**
* **-d**  
  Alias of **-h**
* **-f**  
  Alias of **-p**
* **-X**  
  Alias of **-a**
* **-o**  
  Does nothing, exists for BSD compatibility.
* **-x**  
  Does nothing, exists for BSD compatibility.
* **-h**, **--help**  
  Display help text and exit.
* **-V**, **--version**  
  Display version information and exit.

<a name="examples"></a>

# Examples

/sbin/sysctl -a  
/sbin/sysctl -n kernel.hostname  
/sbin/sysctl -w kernel.domainname="example.com"  
/sbin/sysctl -p/etc/sysctl.conf  
/sbin/sysctl -a --pattern forward  
/sbin/sysctl -a --pattern forward$  
/sbin/sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'  
/sbin/sysctl --system --pattern '^net.ipv6'

<a name="deprecated-parameters"></a>

# Deprecated Parameters

The
**base_reachable_time**
and
**retrans_time**
are deprecated.  The sysctl command does not allow changing values of these
parameters.  Users who insist to use deprecated kernel interfaces should push values
to /proc file system by other means.  For example:

echo 256 &gt; /proc/sys/net/ipv6/neigh/eth0/base_reachable_time

<a name="files"></a>

# Files

_/proc/sys_  
_/etc/sysctl.conf_

<a name="see-also"></a>

# See Also

**sysctl.conf**(5)
**regex**(7)

<a name="author"></a>

# Author

.UR [staikos@0wned.org](mailto:staikos@0wned.org)
George Staikos
.UE

<a name="reporting-bugs"></a>

# Reporting Bugs

Please send bug reports to
.UR procps@freelists.org
.UE
