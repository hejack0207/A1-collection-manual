# nvme\-dera\-stat(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-dera-stat - Send NVMe Dera Device status and Additional SMART log page request, returns result and log

<a name="synopsis"></a>

# Synopsis

```


```
    nvme dera stat <device>

<a name="description"></a>

# Description


Retrieves the NVMe Dera Device status and Additional SMART log page from the device and provides the returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned status and smart log structure are printed in a readable format.

<a name="options"></a>

# Options


none

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Print the Dera Device status and Additional SMART log page in a human readable format:

.if n \{.RS 4
.\}
    # nvme dera stat /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
