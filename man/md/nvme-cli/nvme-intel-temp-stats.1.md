# nvme\-intel\-temp\-s(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-intel-temp-stats - Send NVMe SMART log page request, returns result and log

<a name="synopsis"></a>

# Synopsis

```


```
    nvme intel temp-stats <device> [--raw-binary | -b]

<a name="description"></a>

# Description


Retrieves the NVMe Intel Additional SMART log page from the device and provides the returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned smart log structure may be returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format or the raw buffer may be printed to stdout for another program to parse.

<a name="options"></a>

# Options


-b, --raw-binary
Print the raw temperature stats log buffer to stdout.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Print the temperature stats log page in a human readable format:

.if n \{.RS 4
.\}
    # nvme intel temp-stats /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Print the raw SMART log to a file:

.if n \{.RS 4
.\}
    # nvme intel temp-stats /dev/nvme0 --raw-binary > temp_stats_log.raw
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
