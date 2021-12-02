# nvme\-wdc\-purge(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-purge - Send NVMe WDC Purge Vendor Unique Command, return result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc purge <device>

<a name="description"></a>

# Description


For the NVMe device given, sends a Vendor Unique WDC Purge command and provides the result.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns 0, error code otherwise.

<a name="options"></a>

# Options


No options yet.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program issue WDC Purge Vendor Unique Command :

.if n \{.RS 4
.\}
    # nvme wdc purge /dev/nvme0n1
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
