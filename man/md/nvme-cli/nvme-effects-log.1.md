# nvme\-effects\-log(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-effects-log - Send NVMe Command Effects log page request, returns result and log

<a name="synopsis"></a>

# Synopsis

```


```
    nvme effects-log <device> [--output-format=<fmt> | -o <fmt>]
                                [--human-readable | -H]
                                [--raw-binary | -b]

<a name="description"></a>

# Description


Retrieves the NVMe Command Effects log page from an NVMe device and provides the returned structure.

The &lt;device&gt; parameter is mandatory and should be the NVMe character device (ex: /dev/nvme0).

On success, the returned command effects log structure will be printed for each command that is supported.

<a name="options"></a>

# Options


-o &lt;format&gt;, --output-format=&lt;format&gt;
This option will set the reporting format to normal, json, or binary. Only one output format can be used at a time.

-H, --human-readable
This option will parse and format many of the bit fields into a human-readable format.

-b, --raw-binary
This option will print the raw buffer to stdout. Structure is not parsed by program. This overrides the human-readable option.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Print the effects log page in a human readable format:

.if n \{.RS 4
.\}
    # nvme effects-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Have the program return the raw structure in binary:

.if n \{.RS 4
.\}
    # nvme effects-log /dev/nvme0 --raw-binary > effects_log.raw
    # nvme effects-log /dev/nvme0 -b > effects_log.raw
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
