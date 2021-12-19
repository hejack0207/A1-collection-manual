# nvme\-wdc\-clear\-as(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-clear-assert-dump - Clears the assert dump (if present).

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc clear-assert-dump <device>

<a name="description"></a>

# Description


For the NVMe device given, sends the wdc vendor unique clear assert dump command.

The &lt;device&gt; parameter is mandatory and must be the NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. The command will not be executed on devices that don’t support it.

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
  Clears the assert dump (if present):

.if n \{.RS 4
.\}
    # nvme wdc clear-assert-dump /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
