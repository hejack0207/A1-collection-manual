# uuidparse(1) - a utility to parse unique identifiers

util-linux, 2017-06-18

```
uuidparse [options] uuid
```

<a name="description"></a>

# Description

This command will parse unique identifier inputs from either command line
arguments or standard input.  The inputs are white-space separated.

<a name="output"></a>

# Output


<a name="variants"></a>

### Variants

.nr WI \n(.lu-\n(.iu-\w'Microsoft'u-3n
.TS
tab(:);
l lw(\n(WIu).
NCS:T{
Network Computing System identifier.  These were the original UUIDs.
T}
DCE:T{
The Open Software Foundation's (OSF) Distributed Computing Environment UUIDs.
T}
Microsoft:T{
Microsoft Windows platform globally unique identifier (GUID).
T}
other:T{
Unknown variant.  Usually invalid input data.
T}
.TE

<a name="types"></a>

### Types

.TS
tab(:);
l l.
nil:Special type for zero in type file.
time-based:The DCE time based.
DCE:The DCE time and MAC Address.
name-based:RFC 4122 md5sum hash.
random:RFC 4122 random.
sha1-based:RFC 4122 sha-1 hash.
unknown:Unknown type.  Usually invalid input data.
.TE

<a name="options"></a>

# Options


* **-J**, **--json**  
  Use JSON output format.
* **-n**, **--noheadings**  
  Do not print a header line.
* **-o**, **--output**  
  Specify which output columns to print.  Use --help to get a list of all
  supported columns.
* **-r**, **--raw**  
  Use the raw output format.
* **-V**, **--version**  
  Display version information and exit.
* **-h**, **--help**  
  Display help text and exit.

<a name="authors"></a>

# Authors

.MT [kerolasa@iki.fi](mailto:kerolasa@iki.fi)
Sami Kerola
.ME

<a name="see-also"></a>

# See Also

**uuidgen**(1),
**libuuid**(3),
[RFC 4122](https://​tools.ietf.org​/html​/rfc4122)

<a name="availability"></a>

# Availability

The example command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
