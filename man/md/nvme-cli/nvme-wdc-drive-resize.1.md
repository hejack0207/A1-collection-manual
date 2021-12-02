# nvme\-wdc\-drive\-re(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-drive-resize - Send NVMe WDC Resize Vendor Unique Command, return result.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc drive-resize <device> [--size=<sz> | -s <sz>]

<a name="description"></a>

# Description


For the NVMe device given, sends a Vendor Unique WDC Resize command.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns 0, error code otherwise.

<a name="options"></a>

# Options


-s &lt;sz&gt;, --size=&lt;sz&gt;
The new size (in GB) to resize the drive to.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program issue WDC Resize Vendor Unique Command :

.if n \{.RS 4
.\}
    # nvme wdc drive-resize /dev/nvme0n1 --size=100
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
