# nvme\-wdc\-clear\-fw(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-clear-fw-activate-history - Clears the firmware activate history table.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc clear-fw-activate-history <device>

<a name="description"></a>

# Description


For the NVMe device given, sends the wdc vendor unique clear fw activate history command.

The &lt;device&gt; parameter is mandatory and must be the NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

<a name="options"></a>

# Options


None

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Clears the firmware activate history table:

.if n \{.RS 4
.\}
    # nvme wdc clear-fw-activate-history /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
