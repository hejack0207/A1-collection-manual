# nvme\-get\-ns\-id(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-get-ns-id - Retrieves the namespace ID for an NVMe block device

<a name="synopsis"></a>

# Synopsis

```


```
    nvme get-ns-id <device>

<a name="description"></a>

# Description


Retrieves the namespace ID for an NVMe block device. The &lt;device&gt; param is mandatory and must be an NVMe block device (ex: /dev/nvme0n1).

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
  Shows the namespace id for the given block device:

.if n \{.RS 4
.\}
    # nvme get-ns-id /dev/nvme0n1
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
