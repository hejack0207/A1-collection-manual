# nvme\-wdc\-clear\-pc(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-clear-pcie-correctable-errors - Clears the pcie correctable errors field returned in the smart-log-add command.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc clear-pcie-correctable-errors <device>

<a name="description"></a>

# Description


For the NVMe device given, sends the wdc vendor unique clear pcie correctable errors command.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

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
  Clears the PCIe Correctable Error Count field returned in the smart-log-add command:

.if n \{.RS 4
.\}
    # nvme wdc clear-pcie-correctable-errors /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
