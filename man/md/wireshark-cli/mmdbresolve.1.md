# mmdbresolve(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

mmdbresolve - Read IPv4 and IPv6 addresses and print their IP geolocation information.

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" mmdbresolve -f&nbsp;<dbfile> [&nbsp;-f&nbsp;<dbfile>&nbsp;] ...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**mmdbresolve** reads IPv4 and IPv6 addresses on stdin and prints their \s-1IP\s0 geolocation information
on stdout. Each input line must contain exactly one address. Output is in \s-1INI\s0 format, with a section
delimiter named after the query address followed by a set of key: value\*(R" pairs. A comment
beginning with # End\*(R" is appended to each section.

At startup an [init]\*(R" section is printed that shows the status of each datbase and of mmdbresolve
itself.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -f  
  .IX Item "-f"
  Path to a MaxMind Database file. Multiple databases may be specified.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To resolve a single address:

.Vb 1
    echo 4.4.4.4 | mmdbresolve -f /usr/share/GeoIP/GeoLite2-City.mmdb

  Example output:
[init]
db.0.path: /usr/share/GeoIP/GeoLite2-City.mmdb
db.0.status: OK
mmdbresolve.status: true
# End init
[4.4.4.4]
# GeoLite2-City
country.iso_code: US
country.names.en: United States
location.latitude: 37.751000
location.longitude: -97.822000
# End 4.4.4.4
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**wireshark**\|(1), **tshark**\|(1)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**mmdbresolve** is part of the **Wireshark** distribution. The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  ---------------
  Gerald Combs            &lt;gerald[AT]wireshark.org&gt;
.Ve
