# nvme\-wdc\-vs\-telem(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-vs-telemetry-controller-option - Disable/Enable the controller initiated option of the telemetry log page.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc vs-telemetry-controller-option <device> [--disable, -d] [--enable, -e]
        [--status, -s]

<a name="description"></a>

# Description


For the NVMe device given, sends the WDC Vendor Specific set feature command to disable, enable or get current status of the controller initiated option of the telemetry log page.

The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

<a name="options"></a>

# Options


-d, --disable
Disables the controller initiated option of the telemetry log page.

-e, --enable
Enables the controller initiated option of the telemetry log page.

-s, --status
Returns the current status (enabled or disabled) of the controller initiated option of the telemetry log page.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Disables the controller initiated option of the telemetry log page:

.if n \{.RS 4
.\}
    # nvme wdc vs-telemetry-controller-option /dev/nvme0 --disable
    # nvme wdc vs-telemetry-controller-option /dev/nvme0 -d
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Enables the controller initiated option of the telemetry log page:

.if n \{.RS 4
.\}
    # nvme wdc vs-telemetry-controller-option /dev/nvme0 --enable
    # nvme wdc vs-telemetry-controller-option /dev/nvme0 -e
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the current status (enabled or disabled) of the controller initiated option of the telemetry log page:

.if n \{.RS 4
.\}
    # nvme wdc vs-telemetry-controller-option /dev/nvme0 --status
    # nvme wdc vs-telemetry-controller-option /dev/nvme0 -s
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
