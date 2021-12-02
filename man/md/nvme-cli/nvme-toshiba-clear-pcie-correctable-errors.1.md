# nvme\-toshiba\-clear(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-toshiba-clear-pcie-correctable-errors - Reset the PCIe correctable errors count to zero.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme toshiba clear-pcie-correctable-errors *(Aq <device>

<a name="description"></a>

# Description


For the NVMe device given, sends the Toshiba clear PCIe correctable errors request.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Clear the PCIe correctable errors count:

.if n \{.RS 4
.\}
    # nvme toshiba clear-pcie-correctable-errors /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
