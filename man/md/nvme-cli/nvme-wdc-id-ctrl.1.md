# nvme\-wdc\-id\-ctrl(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-id-ctrl - Send NVMe Identify Controller, return result and structure

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc id-ctrl <device> [-v | --vendor-specific] [-b | --raw-binary]
                            [-H | --human-readable]
                            [-o <fmt> | --output-format=<fmt>]

<a name="description"></a>

# Description


For the NVMe device given, sends an identify controller command and provides the result and returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success, the structure may be returned in one of several ways depending on the option flags; the structure may be parsed by the program or the raw buffer may be printed to stdout.

If having the program decode the output for readability, this version will decode WDC vendor unique portions of the structure.

<a name="options"></a>

# Options


-b, --raw-binary
Print the raw buffer to stdout. Structure is not parsed by program. This overrides the vendor specific and human readable options.

-v, --vendor-specific
In addition to parsing known fields, this option will dump the vendor specific region of the structure in hex with ascii interpretation.

-H, --human-readable
This option will parse and format many of the bit fields into human-readable formats.

-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_,
_json_, or
_binary_. Only one output format can be used at a time.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program interpret the returned buffer and display the known fields in a human readable format:

.if n \{.RS 4
.\}
    # nvme wdc id-ctrl /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
