# nvme\-transcend\-bad(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-transcend-badblock - Retrieve Transcend NVMe devices bad blocks.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme transcend badblock <device>

<a name="description"></a>

# Description


For the NVMe device given, sends the Transcend vendor command and return the bad block of the device.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned value would print the amount of bad blocks.

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
  Print the Transcend device’s bad blocks in a human readable format:

.if n \{.RS 4
.\}
    # nvme transcend badblock /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
