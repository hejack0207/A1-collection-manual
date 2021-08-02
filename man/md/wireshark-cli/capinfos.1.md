# capinfos(1)

3.4.7, 2021-07-15

.if n .ad l
.nh

<a name="name"></a>

# Name

capinfos - Prints information about capture files

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" capinfos [&nbsp;-a&nbsp;] [&nbsp;-A&nbsp;] [&nbsp;-b&nbsp;] [&nbsp;-B&nbsp;] [&nbsp;-c&nbsp;] [&nbsp;-C&nbsp;] [&nbsp;-d&nbsp;] [&nbsp;-D&nbsp;] [&nbsp;-e&nbsp;] [&nbsp;-E&nbsp;] [&nbsp;-F&nbsp;] [&nbsp;-h&nbsp;] [&nbsp;-H&nbsp;] [&nbsp;-i&nbsp;] [&nbsp;-I&nbsp;] [&nbsp;-k&nbsp;] [&nbsp;-K&nbsp;] [&nbsp;-l&nbsp;] [&nbsp;-L&nbsp;] [&nbsp;-m&nbsp;] [&nbsp;-M&nbsp;] [&nbsp;-n&nbsp;] [&nbsp;-N&nbsp;] [&nbsp;-o&nbsp;] [&nbsp;-q&nbsp;] [&nbsp;-Q&nbsp;] [&nbsp;-r&nbsp;] [&nbsp;-R&nbsp;] [&nbsp;-s&nbsp;] [&nbsp;-S&nbsp;] [&nbsp;-t&nbsp;] [&nbsp;-T&nbsp;] [&nbsp;-u&nbsp;] [&nbsp;-v&nbsp;] [&nbsp;-x&nbsp;] [&nbsp;-y&nbsp;] [&nbsp;-z&nbsp;] <infile> ...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**Capinfos** is a program that reads one or more capture files and
returns some or all available statistics (infos) of each &lt;_infile_&gt;
in one of two types of output formats: long or table.

The long output is suitable for a human to read.  The table output
is useful for generating a report that can be easily imported into
a spreadsheet or database.

The user specifies what type of output (long or table) and which
statistics to display by specifying flags (options) that corresponding
to the report type and desired infos.  If no options are specified,
**Capinfos** will report all statistics available in long\*(R" format.

Options are processed from left to right order with later options
superseding or adding to earlier options.

**Capinfos** is able to detect and read the same capture files that are
supported by **Wireshark**.
The input files don't need a specific filename extension; the file
format and an optional gzip compression will be automatically detected.
Near the beginning of the \s-1DESCRIPTION\s0 section of **wireshark**\|(1) or
&lt;https://www.wireshark.org/docs/man-pages/wireshark.html&gt;
is a detailed description of the way **Wireshark** handles this, which is
the same way **Capinfos** handles this.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* -a  
  .IX Item "-a"
  Displays the start time of the capture.  **Capinfos** considers
  the earliest timestamp seen to be the start time, so the
  first packet in the capture is not necessarily the earliest -
  if packets exist out-of-order\*(R", time-wise, in the capture,
  **Capinfos** detects this.
* -A  
  .IX Item "-A"
  Generate all infos. By default capinfos will display
  all infos values for each input file, but enabling
  any of the individual display infos options will
  disable the generate all option.
* -b  
  .IX Item "-b"
  Separate infos with \s-1ASCII SPACE\s0 (0x20) characters.
  This option is only useful when generating a table
  style report (-T).  The various info values will be
  separated (delimited) from one another with a single
  \s-1ASCII SPACE\s0 character.
  .Sp
  \s-1NOTE:\s0 Since some of the header labels as well as some
  of the value fields contain \s-1SPACE\s0 characters.  This
  option is of limited value unless one of the quoting
  options (-q or -Q) is also specified.
* -B  
  .IX Item "-B"
  Separate the infos with \s-1ASCII TAB\s0 characters.
  This option is only useful when generating a table
  style report (-T).  The various info values will be
  separated (delimited) from one another with a single
  \s-1ASCII TAB\s0 character.  The \s-1TAB\s0 character is the default
  delimiter when -T style report is enabled.
* -c  
  .IX Item "-c"
  Displays the number of packets in the capture file.
* -C  
  .IX Item "-C"
  Cancel processing any additional files if and
  when capinfos fails to open an input file
  or gets an error reading an input file.
  By default capinfos will continue processing files
  even if it gets an error opening or reading a file.
  .Sp
  Note: An error message will be written to stderr
  whenever capinfos fails to open a file or gets
  an error reading from a file regardless whether
  the -C option is specified or not.
  Upon exit, capinfos will return an error status
  if any errors occurred during processing.
* -d  
  .IX Item "-d"
  Displays the total length of all packets in the file, in
  bytes.  This counts the size of the packets as they appeared
  in their original form, not as they appear in this file.
  For example, if a packet was originally 1514 bytes and only
  256 of those bytes were saved to the capture file (if packets
  were captured with a snaplen or other slicing option),
  **Capinfos** will consider the packet to have been 1514 bytes.
* -D  
  .IX Item "-D"
  Displays a count of the number of decryption secrets in the file.
* -e  
  .IX Item "-e"
  Displays the end time of the capture.  **Capinfos** considers
  the latest timestamp seen to be the end time, so the
  last packet in the capture is not necessarily the latest -
  if packets exist out-of-order\*(R", time-wise, in the capture,
  **Capinfos** detects this.
* -E  
  .IX Item "-E"
  Displays the per-file encapsulation of the capture file.
* -F  
  .IX Item "-F"
  Displays additional capture file information.
* -h  
  .IX Item "-h"
  Prints the help listing and exits.
* -H  
  .IX Item "-H"
  Displays the \s-1SHA256, RIPEMD160,\s0 and \s-1SHA1\s0 hashes for the file.
  \s-1SHA1\s0 output may be removed in the future.
* -i  
  .IX Item "-i"
  Displays the average data rate, in bits/sec
* -I  
  .IX Item "-I"
  Displays detailed capture file interface information. This information
  is not available in table format.
* -k  
  .IX Item "-k"
  Displays the capture comment. For pcapng files, this is the comment from the
  section header block.
* -K  
  .IX Item "-K"
  Use this option to suppress printing capture comments.  By default capture
  comments are enabled.  Capture comments are relatively freeform and might
  contain embedded new-line characters and/or other delimiting characters
  making it harder for a human or machine to easily parse the capinfos output.
  Excluding capture comments can aid in post-processing of output.
* -l  
  .IX Item "-l"
  Display the snaplen (if any) for a file.
  snaplen (if available) is determined from the capture file header
  and by looking for truncated records in the capture file.
* -L  
  .IX Item "-L"
  Generate long report.  Capinfos can generate two
  different styles of reports.  The long\*(R" report is
  the default style of output and is suitable for a
  human to use.
* -m  
  .IX Item "-m"
  Separate the infos with comma (,) characters.  This option
  is only useful when generating a table style report (-T).
  The various info values will be separated (delimited)
  from one another with a single comma ,\*(R" character.
* -M  
  .IX Item "-M"
  Print raw (machine readable) numeric values in long reports.
  By default capinfos prints human-readable values with \s-1SI\s0
  suffixes. Table reports (-T) always print raw values.
* -n  
  .IX Item "-n"
  Displays a count of the number of resolved IPv4 addresses and a count of
  the number of resolved IPv6 addresses in the file.
* -N  
  .IX Item "-N"
  Do not quote the infos.  This option is only useful
  when generating a table style report (-T).  Excluding
  any quoting characters around the various values and
  using a \s-1TAB\s0 delimiter produces a very clean\*(R" table
  report that is easily parsed with \s-1CLI\s0 tools.  By
  default infos are **\s-1NOT\s0** quoted.
* -o  
  .IX Item "-o"
  Displays True\*(R" if packets exist in strict chronological order
  or False\*(R" if one or more packets in the capture exists
  out-of-order\*(R" time-wise.
* -q  
  .IX Item "-q"
  Quote infos with single quotes ('). This option is
  only useful when generating a table style report (-T).
  When this option is enabled, each value will be
  encapsulated within a pair of single quote (')
  characters.  This option (when used  with the -m
  option) is useful for generating one type of \s-1CSV\s0
  style file report.
* -Q  
  .IX Item "-Q"
  Quote infos with double quotes ().  This option is
  only useful when generating a table style report (-T).
  When this option is enabled, each value will be
  encapsulated within a pair of double quote ()
  characters.  This option (when used with the -m
  option) is useful for generating the most common
  type of \s-1CSV\s0 style file report.
* -r  
  .IX Item "-r"
  Do not generate header record.  This option is only
  useful when generating a table style report (-T).
  If this option is specified then **no** header record will be
  generated within the table report.
* -R  
  .IX Item "-R"
  Generate header record.  This option is only useful
  when generating a table style report (-T).  A header
  is generated by default.  A header record (if generated)
  is the first line of data reported and includes labels
  for all the columns included within the table report.
* -s  
  .IX Item "-s"
  Displays the size of the file, in bytes.  This reports
  the size of the capture file itself.
* -S  
  .IX Item "-S"
  Display the start and end times as seconds since January
  1, 1970. Handy for synchronizing dumps using **editcap -t**.
* -t  
  .IX Item "-t"
  Displays the capture type of the capture file.
* -T  
  .IX Item "-T"
  Generate a table report. A table report is a text file
  that is suitable for importing into a spreadsheet or
  database.  Capinfos can build a tab delimited text file
  (the default) or several variations on Comma-separated
  values (\s-1CSV\s0) files.
* -u  
  .IX Item "-u"
  Displays the capture duration, in seconds.  This is the
  difference in time between the earliest packet seen and
  latest packet seen.
* -v  
  .IX Item "-v"
  Displays the tool's version and exits.
* -x  
  .IX Item "-x"
  Displays the average packet rate, in packets/sec
* -y  
  .IX Item "-y"
  Displays the average data rate, in bytes/sec
* -z  
  .IX Item "-z"
  Displays the average packet size, in bytes

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To see a description of the capinfos options use:

.Vb 1
    capinfos -h
.Ve

To generate a long form report for the capture file
mycapture.pcap use:

.Vb 1
    capinfos mycapture.pcap
.Ve

To generate a \s-1TAB\s0 delimited table form report for the capture
file mycapture.pcap use:

.Vb 1
    capinfos -T mycapture.pcap
.Ve

To generate a \s-1CSV\s0 style table form report for the capture
file mycapture.pcap use:

.Vb 1
    capinfos -T -m -Q mycapture.pcap
.Ve

or

.Vb 1
    capinfos -TmQ mycapture.pcap
.Ve

To generate a \s-1TAB\s0 delimited table style report with just the
filenames, capture type, capture encapsulation type and packet
count for all the pcap files in the current directory use:

.Vb 1
    capinfos -T -t -E -c *.pcap
.Ve

or

.Vb 1
    capinfos -TtEs *.pcap
.Ve

Note: The ability to use of filename globbing characters are
a feature of *nix style command shells.

To generate a \s-1CSV\s0 delimited table style report of all infos
for all pcap files in the current directory and write it to
a text file called mycaptures.csv use:

.Vb 1
    capinfos -TmQ *.pcap &gt;mycaptures.csv
.Ve

The resulting mycaptures.csv file can be easily imported
into spreadsheet applications.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pcap**\|(3), **wireshark**\|(1), **mergecap**\|(1), **editcap**\|(1), **tshark**\|(1),
**dumpcap**\|(1), **pcap-filter**\|(7) or **tcpdump**\|(8)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**Capinfos** is part of the **Wireshark** distribution.  The latest version
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
