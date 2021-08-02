# reordercap(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

reordercap - Reorder input file by timestamp into output file

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" reordercap [&nbsp;-n&nbsp;] [&nbsp;-v&nbsp;] <infile> <outfile>
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Reordercap** is a program that reads an input capture file and rewrites the
frames to an output capture file, but with the frames sorted by increasing
timestamp.

This functionality may be useful when capture files have been created by
combining frames from more than one well-synchronised source, but the
frames have not been combined in strict time order.

**Reordercap** writes the output capture file in the same format as the input
capture file.

**Reordercap** is able to detect, read and write the same capture files that
are supported by **Wireshark**.
The input file doesn't need a specific filename extension; the file
format and an optional gzip compression will be detected automatically.
Near the beginning of the \s-1DESCRIPTION\s0 section of **wireshark**\|(1) or
&lt;https://www.wireshark.org/docs/man-pages/wireshark.html&gt;
is a detailed description of the way **Wireshark** handles this, which is
the same way **reordercap** handles this.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -n  
  .IX Item "-n"
  When the **-n** option is used, **reordercap** will not write out the output
  file if it finds that the input file is already in order.
* -v  
  .IX Item "-v"
  Print the version and exit.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pcap**\|(3), **wireshark**\|(1), **tshark**\|(1), **dumpcap**\|(1), **editcap**\|(1), **mergecap**\|(1),
**text2pcap**\|(1), **pcap-filter**\|(7) or **tcpdump**\|(8)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Reordercap** is part of the **Wireshark** distribution.  The latest version
of **Wireshark** can be found at &lt;https://www.wireshark.org&gt;.

It may make sense to move this functionality into **editcap**, or perhaps
**mergecap**, in which case **reordercap** could be retired.

\s-1HTML\s0 versions of the Wireshark project man pages are available at:
&lt;https://www.wireshark.org/docs/man-pages&gt;.

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
.Vb 3
  Original Author
  -------- ------
  Martin Mathieson             &lt;martin.r.mathieson[AT]googlemail.com&gt;
.Ve
