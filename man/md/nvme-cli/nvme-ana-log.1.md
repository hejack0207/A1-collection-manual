# nvme\-ana\-log(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-ana-log - Send NVMe ANA log page request, returns result and log

<a name="synopsis"></a>

# Synopsis

```


```
    nvme ana-log <device> [-o <fmt> | --output-format=<fmt>]

<a name="description"></a>

# Description


Retrieves the NVMe Asymmetric Namespace Access log page from an NVMe device and provides the returned structure.

The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).

On success, the returned ANA log structure may be returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format or the raw buffer may be printed to stdout for another program to parse.

<a name="options"></a>

# Options


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
  Print the ANA log page in a human readable format:

.if n \{.RS 4
.\}
    # nvme ana-log /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
