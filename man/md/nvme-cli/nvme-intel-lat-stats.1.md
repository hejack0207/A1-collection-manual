# nvme\-intel\-lat\-st(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-intel-lat-stats - Send NVMe Identify Controller, return result and structure

<a name="synopsis"></a>

# Synopsis

```


```
    nvme intel lat-stats <device> [--write | -w] [--raw-binary | -b]

<a name="description"></a>

# Description


For the NVMe device given, retrieves intel vendor specific latency statistics and provides the result and returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the structure may be returned in one of several ways depending on the option flags; the structure may be parsed by the program or the raw buffer may be printed to stdout.

<a name="options"></a>

# Options


-b, --raw-binary
Print the raw buffer to stdout. Structure is not parsed by program. This overrides the vendor specific and human readable options.

-w, --write
Get write statistics. Read statistics are returned by default.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get the read statistics

.if n \{.RS 4
.\}
    # nvme intel lat-stats /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get the write statistics

.if n \{.RS 4
.\}
    # nvme intel lat-stats /dev/nvme0 -w
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
