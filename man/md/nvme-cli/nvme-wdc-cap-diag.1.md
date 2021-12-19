# nvme\-wdc\-cap\-diag(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-cap-diag - Retrieve WDC devices diagnostic log and save to file.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc cap-diag <device> [--output-file=<FILE>, -o <FILE>] [--transfer-size=<SIZE>, -s <SIZE>]

<a name="description"></a>

# Description


For the NVMe device given, sends the WDC Vendor Unique Capture-Diagnostics request and saves the result to a file.

The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

<a name="options"></a>

# Options


-o &lt;FILE&gt;, --output-file=&lt;FILE&gt;
Output file; defaults to device serial number followed by "cap_diag" suffix

-s &lt;SIZE&gt;, --transfer-size=&lt;SIZE&gt;
Transfer size; defaults to 0x10000 (65536 decimal) bytes

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the capture diagnostics log from the device and saves to default file in current directory (e.g. STM00019F3F9cap_diag.bin):

.if n \{.RS 4
.\}
    # nvme wdc cap-diag /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the capture diagnostics log from the device and saves to defined file in current directory (e.g. testSTM00019F3F9cap_diag.bin):

.if n \{.RS 4
.\}
    # nvme wdc cap-diag /dev/nvme0 -o test
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the capture diagnostics log from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9cap_diag.bin):

.if n \{.RS 4
.\}
    # nvme wdc cap-diag /dev/nvme0 -o /tmp/test
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the capture diagnostics log from the device transferring the data in 64k chunks and saves to default file in current directory (e.g. STM00019F3F9internal_fw_log.bin):

.if n \{.RS 4
.\}
    # nvme wdc cap-diag /dev/nvme0 -s 0x10000
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the capture diagnostics log from the device transferring the data in 16k chunks and saves to default file in current directory (e.g. STM00019F3F9internal_fw_log.bin):

.if n \{.RS 4
.\}
    # nvme wdc cap-diag /dev/nvme0 -s 16384
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
