# nvme\-subsystem\-res(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-subsystem-reset - Reset the nvme subsystem.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme subsystem-reset <device>

<a name="description"></a>

# Description


Requests NVMe subsystem reset. The &lt;device&gt; param is mandatory and must be an NVMe character device (ex: /dev/nvme0).

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
  Resets the subsystem.

.if n \{.RS 4
.\}
    # nvme subsystem-reset /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
