# nvme\-transcend\-hea(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-transcend-healthvalue - Use NVMe SMART table to analyse the health value of Transcend device.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme transcned healthvalue <device>

<a name="description"></a>

# Description


Retrieves the NVMe Device SMART log page from the Transcend device and evaluate health status of Transcend device.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned value would print health percentage value.

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
  Print the Transcend Device health value in a human readable format:

.if n \{.RS 4
.\}
    # nvme transcned healthvalue /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
