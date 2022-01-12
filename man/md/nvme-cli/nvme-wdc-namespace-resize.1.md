# nvme\-wdc\-namespace(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-namespace-resize - Resizes the devices namespace.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc namespace-resize <device> [--nsid=<NAMSPACE ID>, -n <NAMSPACE ID>] [--op_option=<OP OPTION>, -o <OP OPTION>]

<a name="description"></a>

# Description


For the NVMe device given, sends the WDC Vendor Specific Command that modifies the namespace size reported by the device.

The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

<a name="options"></a>

# Options


-n &lt;NAMSPACE ID&gt;, --namespace-id=&lt;NAMSPACE_ID&gt;
Namespace ID; ID of the namespace to resize

-o &lt;OP OPTION&gt;, --op-option=&lt;OP OPTION&gt;
Overprovisioning Option; defaults to 0xF

.if n \{.RS 4
.\}
    Valid Values:
    0x1 - 7% of Original TNVMCAP reported value
    0x2 - 28% of Original TNVMCAP reported value
    0x3 - 50% of Original TNVMCAP reported value
    0xF - 0% of Original TNVMCAP reported value (original config)
    All other values - reserved
.if n \{.RE
.\}

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Resizes namespace 1 to 50% of the orginal TNVMCAP reported value:

.if n \{.RS 4
.\}
    # nvme wdc namespace-resize /dev/nvme0 -n 1 -o 3
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Resizes namespace 2 to 7% of the orginal TNVMCAP reported value:

.if n \{.RS 4
.\}
    # nvme wdc namespace-resize /dev/nvme0 --namespace-id=2 --op-option=1
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
