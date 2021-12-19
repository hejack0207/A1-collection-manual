# nvme\-endurance\-log(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-endurance-log - Send NVMe Endurance log page request, returns result and log

<a name="synopsis"></a>

# Synopsis

```


```
    nvme endurance-log <device> [--group-id=<group> | -g <group>]
                            [--output-format=<fmt> | -o <fmt>]

<a name="description"></a>

# Description


Retrieves the NVMe Endurance log page from an NVMe device and provides the returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned endurance log structure may be returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format, the raw buffer may be printed to stdout for another program to parse, or reported in json format.

<a name="options"></a>

# Options


-g &lt;group&gt;, --group-id=&lt;group&gt;
The endurance group identifier.

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
  Print the Endurance log page in a human readable format:

.if n \{.RS 4
.\}
    # nvme endurance-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Print the raw Endurance log to a file:

.if n \{.RS 4
.\}
    # nvme endurance-log /dev/nvme0 --output=binary > endurance_log.raw
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
