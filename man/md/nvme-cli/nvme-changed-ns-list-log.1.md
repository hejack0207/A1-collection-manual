# nvme\-changed\-ns\-l(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-changed-ns-list-log - Send NVMe Changed Namespace List log page request, returns result and log.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme changed-ns-list-log <device> [--raw-binary | -b]
                            [--output-format=<fmt> | -o <fmt>]

<a name="description"></a>

# Description


Retrieves the NVMe Changed Namespace List log page from an NVMe device and provides the returned structure.

The &lt;device&gt; parameter is mandatory and must be a NVMe character device (ex: /dev/nvme0).

On success, the returned Changed Namespace List log structure may be returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format or the raw buffer may be printed to stdout for another program to parse.

<a name="options"></a>

# Options


-b, --raw-binary
Print the raw Changed Namespace List log buffer to stdout.

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
  Print the Changed Namespace List Log page in a human readable format:

.if n \{.RS 4
.\}
    # nvme changed-ns-list-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Print the raw Changed Namespace List log to a file:

.if n \{.RS 4
.\}
    # nvme changed-ns-list-log /dev/nvme0 --raw-binary > log.raw
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
