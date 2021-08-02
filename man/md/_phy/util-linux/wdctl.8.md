# wdctl(8) - show hardware watchdog status

util-linux, July 2014

```
wdctl [options] [device...]
```

<a name="description"></a>

# Description

Show hardware watchdog status.  The default device is
_/dev/watchdog_.
If more than one device is specified then the output is separated by
one blank line.

Note that the number of supported watchdog features is hardware specific.

<a name="options"></a>

# Options


* **-f**,** --flags **list  
  Print only the specified flags.
* **-F**,** --noflags**  
  Do not print information about flags.
* **-I**,** --noident**  
  Do not print watchdog identity information.
* **-n**,** --noheadings**  
  Do not print a header line for flags table.
* **-o**, **--output list**  
  Define the output columns to use in table of watchdog flags.  If no
  output arrangement is specified, then a default set is used.  Use
  **--help**
  to get list of all supported columns.
* **-O**,** --oneline**  
  Print all wanted information on one line in key="value" output format.
* **-r**,** --raw**  
  Use the raw output format.
* **-s**,** -settimeout **seconds  
  Set the watchdog timeout in seconds.
* **-T**,** --notimeouts**  
  Do not print watchdog timeouts.
* **-x**, **--flags-only**  
  Same as **-I -T**.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="authors"></a>

# Authors

.MT kzak@​redhat​.com
Karel Zak
.ME  
.MT lennart@​poettering​.net
Lennart Poettering
.ME

<a name="availability"></a>

# Availability

The
**wdctl**
command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
