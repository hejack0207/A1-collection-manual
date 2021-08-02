# captype(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

captype - Prints the types of capture files

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" capinfos <infile> ...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Captypes** is a program that opens one or more capture files and
prints the capture file type of each &lt;_infile_&gt;.

**Capinfos** is able to detect and read the same capture files that are
supported by **Wireshark**.
The input files don't need a specific filename extension; the file
format and an optional gzip compression will be automatically detected.
Near the beginning of the \s-1DESCRIPTION\s0 section of **wireshark**\|(1) or
&lt;https://www.wireshark.org/docs/man-pages/wireshark.html&gt;
is a detailed description of the way **Wireshark** handles this, which is
the same way **Capinfos** handles this.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pcap**\|(3), **wireshark**\|(1), **mergecap**\|(1), **editcap**\|(1), **tshark**\|(1),
**dumpcap**\|(1), **capinfos**\|(1), **pcap-filter**\|(7) or **tcpdump**\|(8)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Captype** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  -------- ------
  Ian Schorr           &lt;ian[AT]ianschorr.com&gt;


  Contributors
  ------------
  Gerald Combs         &lt;gerald[AT]wireshark.org&gt;
  Jim Young            &lt;jyoung[AT]gsu.edu&gt;
.Ve
