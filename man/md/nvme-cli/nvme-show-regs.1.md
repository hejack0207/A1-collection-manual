# nvme\-id\-ns(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-show-regs - Reads and shows the defined NVMe controller registers for NVMe over PCIe or the controller properties for NVMe over Fabrics.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme show-regs <device>       [--human-readable | -H]
                                    [--output-format=<FMT> | -o <FMT>]

<a name="description"></a>

# Description


For the NVMe over PCIe device given, sends an identify namespace command and provides the result and returned structure. For the NVMe over Fabrics device given, sends a fabric command and provides the result and returned structure.

The &lt;device&gt; parameter is mandatory and must be the nvme admin character device (ex: /dev/nvme0). For NVMe over PCIe, the program uses knowledge of the sysfs layout to map the device to the pci resource stored there and mmaps the memory to get access to the registers. For NVMe over Fabrics, the programs sends a fabric command to get the properties of the target NVMe controller. Only the supported properties are displayed.

<a name="options"></a>

# Options


-H, --human-readable
Display registers or supported properties in human readable format.

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
  Show the NVMe over PCIe controller registers or the NVMe over Fabric controller properties in a binary format:

.if n \{.RS 4
.\}
    # nvme show-regs /dev/nvme0 -o binary
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Show the NVMe over PCIe controller registers or the NVMe over Fabric controller properties in a human readable format:

.if n \{.RS 4
.\}
    # nvme show-regs /dev/nvme0 -H
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Show the NVMe over PCIe controller registers or NVMe-oF controller properties in a json format:

.if n \{.RS 4
.\}
    # nvme show-regs /dev/nvme0 -o json
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
