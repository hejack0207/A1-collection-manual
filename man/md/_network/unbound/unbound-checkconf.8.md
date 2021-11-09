# unbound-checkconf(8)

NLnet Labs, Feb  9, 2021

unbound-checkconf
- Check unbound configuration file for errors.

<a name="synopsis"></a>

# Synopsis

```
unbound-checkconf [-h] [-f] [-o option] [cfgfile]
```

<a name="description"></a>

# Description

**Unbound-checkconf**
checks the configuration file for the
_unbound_(8)
DNS resolver for syntax and other errors. 
The config file syntax is described in 
_unbound.conf_(5).

The available options are:

* **-h**  
  Show the version and commandline option help.
* **-f**  
  Print full pathname, with chroot applied to it.  Use with the -o option.
* **-o option**  
  If given, after checking the config file the value of this option is 
  printed to stdout.  For "" (disabled) options an empty line is printed.
* _cfgfile_  
  The config file to read with settings for unbound. It is checked.
  If omitted, the config file at the default location is checked.

<a name="exit-code"></a>

# Exit Code

The unbound-checkconf program exits with status code 1 on error, 
0 for a correct config file.

<a name="files"></a>

# Files


* _/etc/unbound/unbound.conf_  
  unbound configuration file.

<a name="see-also"></a>

# See Also

_unbound.conf_(5), 
_unbound_(8).
