# tcpslice(8) - extract pieces of and/or merge together tcpdump files

```
.na tcpslice [ -DdlRrt ] [ -w file ]
.ti +9 [ start-time [ end-time ] ] file ...

```

<a name="description"></a>

# Description


_Tcpslice_
is a program for extracting portions of packet-trace files generated using
_tcpdump(l)_'s
**-w**
flag.
It can also be used to merge together several such files, as discussed
below.

The basic operation of
_tcpslice_
is to copy to
_stdout_
all packets from its input file(s) whose timestamps fall
within a given range.  The starting and ending times of the range
may be specified on the command line.  All ranges are inclusive.
The starting time defaults
to the earliest time of the first packet in
any of the input files; we call
this the
_first time._
The ending time defaults to ten years after the starting time.
Thus, the command
_tcpslice trace-file_
simply copies
_trace-file_
to _stdout_ (assuming the file does not include more than
ten years' worth of data).

There are a number of ways to specify times.  The first is using
Unix timestamps of the form
_sssssssss.uuuuuu_
(this is the format specified by _tcpdump_'s
**-tt**
flag).
For example,
**654321098.7654**
specifies 38 seconds and 765,400 microseconds
after 8:51PM PDT, Sept. 25, 1990.

All examples in this manual are given
for PDT times, but when displaying times and interpreting times symbolically
as discussed below,
_tcpslice_
uses the local timezone, regardless of the timezone in which the _tcpdump_
file was generated.  The daylight-savings setting used is that which is
appropriate for the local timezone at the date in question.  For example,
times associated with summer months will usually include daylight-savings
effects, and those with winter months will not.

Times may also be specified relative
to either the
_first time_
(when specifying a starting time)
or the starting time (when specifying an ending time)
by preceding a numeric value in seconds with a \`+'.
For example, a starting time of
**+200**
indicates 200 seconds after the
_first time,_
and the two arguments
**+200 +300**
indicate from 200 seconds after the
_first time_
through 500 seconds after the
_first time._

Times may also be specified in terms of years (y), months (m), days (d),
hours (h), minutes (m), seconds (s), and microseconds(u).  For example,
the Unix timestamp 654321098.7654 discussed above could also be expressed
as
**1990y9m25d20h51m38s765400u.**
2 or 4 digit years may be used; 2 digits can specify years from 1970 to
2069.

When specifying times using this style, fields that are omitted default
as follows.  If the omitted field is a unit
_greater_
than that of the first specified field, then its value defaults to
the corresponding value taken from either
_first time_
(if the starting time is being specified) or the starting time
(if the ending time is being specified).
If the omitted field is a unit
_less_
than that of the first specified field, then it defaults to zero.
For example, suppose that the input file has a
_first time_
of the Unix timestamp mentioned above, i.e., 38 seconds and 765,400 microseconds
after 8:51PM PDT, Sept. 25, 1990.  To specify 9:36PM PDT (exactly) on the
same date we could use
**21h36m.**
To specify a range from 9:36PM PDT through 1:54AM PDT the next day we
could use
**21h36m 26d1h54m.**

Relative times can also be specified when using the
_ymdhmsu_
format.  Omitted fields then default to 0 if the unit of the field is
_greater_
than that of the first specified field, and to the corresponding value
taken from either the
_first time_
or the starting time if the omitted field's unit is
_less_
than that of the first specified field.  Given a
_first time_
of the Unix timestamp mentioned above,
**22h +1h10m**
specifies a range from 10:00PM PDT on that date through 11:10PM PDT, and
**+1h +1h10m**
specifies a range from 38.7654 seconds after 9:51PM PDT through 38.7654
seconds after 11:01PM PDT.  The first hour of the file could be extracted
using
**+0 +1h.**

Note that with the
_ymdhmsu_
format there is an ambiguity between using
_m_
for \`month' or for \`minute'.  The ambiguity is resolved as follows: if an
_m_
field is followed by a
_d_
field then it is interpreted as specifying months; otherwise it
specifies minutes.

If more than one input file is specified then
_tcpslice_
merges the packets from the various input files into the single
output file.  Normally, this merge is done based on the
value of the timestamps in the packets in the individual files.
(Tcpslice assumes that
_within_
each input file, packets are in timestamp order.)
If the
**-l**
option is used, the value used for ordering is the timestamp of
a given packet minus the timestamp of the first packet in the
input file in which the given packet occurs.

When merging files, by default
_tcpslice_
will discard any
_duplicate_
packet it finds in more than one file.  A duplicate is a packet
that has an identical timestamp (either relative or absolute) and
identical packet contents (for as much as was captured) as another
packet previously seen in a different file.  Note that it is possible
for the network to generate true replicates of packets, and for
systems that can return the same timestamp for multiple packets,
these can be mistaken for duplicates and discarded.  Accordingly,
_tcpslice_
will not discard duplicates in the same trace file.  In addition,
you can use the
**-D**
option to suppress any discarding of duplicates.

A different issue arises if a file contains timestamps that skip
backwards.
_tcpslice_
will include these in the output, even if they precede the minimum
time requested.  There should probably be an option to suppress these.

Another problem relating to backwards timestamps is that
_tcpslice_
uses random access to seek through a file looking for packets
corresponding to the desired range of time.  While doing so leads
to a major performance benefit for very large trace files, it also
means that in the presence of backwards timestamps
.I
tcpslice
can fail to find the true earliest occurrence of a packet matching
the time interval criteria.  There should probably be an option
to specify not to use random access but just read the file linearly.

<a name="options"></a>

# Options


If any of
**-R,**
**-r**
or
**-t**
are specified then
_tcpslice_
reports the timestamps of the first and last packets in each input file
and exits.  Only one of these three options may be specified.

* **-D**  
  Do not discard duplicate packets seen when merging multiple trace files.
* **-d**  
  Dump the start and end times specified by the given range and
  exit.  This option is useful for checking that the given range actually
  specifies the times you think it does.  If one of
  **-R,**
  **-r**
  or
  **-t**
  has been specified then the times are dumped in the corresponding
  format; otherwise, raw format (** -R**) is used.
* **-l**  
  When merging more than one file, merge on the basis of
  relative time, rather than absolute time.
  Normally, when merging
  files is done, packets are merged based on absolute timestamps.  With
  **-l**
  packets are merged based on the relative time between
  the start of the file in which the packet is found and the timestamp
  of the packet itself.
  The timestamp of packets in the output file is calculated
  as the relative time for the packet within its file plus
  _first time._
* **-R**  
  Dump the timestamps of the first and last packets in each input file
  as raw timestamps (i.e., in the form _ sssssssss.uuuuuu_).
* **-r**  
  Same as
  **-R**
  except the timestamps are dumped in human-readable format, similar
  to that used by _ date(1)_.
* **-t**  
  Same as
  **-R**
  except the timestamps are dumped in
  _tcpslice_
  format, i.e., in the
  _ymdhmsu_
  format discussed above.
* **-w**  
  Direct the output to _file_ rather than _stdout_.

<a name="see-also"></a>

# See Also

tcpdump(l)

<a name="author"></a>

# Author

Vern Paxson, of
Lawrence Berkeley Laboratory, University of California, Berkeley, CA.

The current version is available via anonymous ftp:

_ftp://ftp.ee.lbl.gov/tcpslice.tar.Z_

<a name="bugs"></a>

# Bugs

Please send bug reports to tcpslice@ee.lbl.gov.

An input filename that beings with a digit or a \`+' can be confused
with a start/end time.  Such filenames can be specified with a
leading \`./'; for example, specify the file \`04Jul76.trace' as
\`./04Jul76.trace'.

_tcpslice_
cannot read its input from _stdin_, since it uses random-access
to rummage through its input files.

_tcpslice_
refuses to write to its output if it is a terminal
(as indicated by _isatty(3)_).  This is not a bug but a feature,
to prevent it from spraying binary data to the user's terminal.
Note that this means you must either redirect _stdout_ or specify an
output file via **-w**.

_tcpslice_
will not work properly on _tcpdump_ files spanning more than one year;
with files containing portions of packets whose original length was
more than 65,535 bytes; nor with files containing fewer than two packets.
Such files result in
the error message: \`couldn't find final packet in file'.  These problems
are due to the interpolation scheme used by
_tcpslice_
to greatly speed up its processing when dealing with large trace files.
Note that
_tcpslice_
can efficiently extract slices from the middle of trace files of any
size, and can also work with truncated trace files (i.e., the final packet
in the file is only partially present, typically due to _tcpdump_
being ungracefully killed).

Adding
**-l**
has broken some compatibility with older versions, since
_tcpslice_
now merges its input files, rather than (approximately) concatenating
them together as it did previously.

It would sometimes be convenient if you could specify a clock offset
to use with the
**-l**
option.

It would be nice if
_tcpslice_
supported more general editing of trace files.
