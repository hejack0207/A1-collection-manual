# nvme\-error\-log(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-error-log - Send NVME Error log page request, return result and log

<a name="synopsis"></a>

# Synopsis

```


```
    nvme error-log <device>  [--log-entries=<entries> | -e <entries>]
                             [--raw-binary | -b]
                             [--output-format=<fmt> | -o <fmt>]

<a name="description"></a>

# Description


Retrieves NVMe Error log page from an NVMe device and provides the returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned error log structure may be returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format or the raw buffer may be printed to stdout for another program to parse.

<a name="options"></a>

# Options


-e &lt;entries&gt;, --log-entries=&lt;entries&gt;
Specifies how many log entries the program should request from the device. This must be at least one, and shouldn’t exceed the device’s capabilities. Defaults to 64 log entries.

-b, --raw-binary
Print the raw error log buffer to stdout.

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
  Get the error log and print it in a human readable format:

.if n \{.RS 4
.\}
    # nvme error-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Print the raw output to a file:

.if n \{.RS 4
.\}
    # nvme error-log /dev/nvme0 --raw-binary > error_log.raw
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
