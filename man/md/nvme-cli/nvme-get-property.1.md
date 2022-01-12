# nvme\-get\-property(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-get-property - Reads and shows the defined NVMe controller property for NVMe over Fabric

<a name="synopsis"></a>

# Synopsis

```


```
    nvme get-property <device> [--offset=<offset> | -o <offset>]
                                    [--human-readable | -H ]

<a name="description"></a>

# Description


Reads and shows the defined NVMe controller property for NVMe over Fabric.

<a name="options"></a>

# Options


-o, --offset
The offset of the property. One of CAP=0x0, VS=0x8, CC=0x14, CSTS=0x1c, NSSR=0x20

-H
--human-readable: Show the fields packed in the property

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The following will run the get-property command with offset 0

.if n \{.RS 4
.\}
    # nvme get-property /dev/nvme0 --offset=0x0 --human-readable
.if n \{.RE
.\}

<a name="bugs"></a>

# Bugs


Currently the CAP value is truncated to 32 bits due to a limitation in the ioctl interface.

In a recent enough kernel, the 64 bit value is shown in kernel traces.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  First enable traces by this command

.if n \{.RS 4
.\}
    # echo 1 > /sys/kernel/debug/tracing/events/nvme/enable
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Then look for NVMe Fabrics command (0x7f) at trace

.if n \{.RS 4
.\}
    /sys/kernel/debug/tracing/trace
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
