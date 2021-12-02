# nvme\-wdc\-drive\-lo(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-drive-log - Retrieve WDC devices drive log and save to file.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc drive-log <device> [--output-file=<FILE>, -o <FILE>]

<a name="description"></a>

# Description


For the NVMe device given, sends the wdc vendor unique drive log request and saves the result to a file.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

<a name="options"></a>

# Options


-o &lt;FILE&gt;, --output-file=&lt;FILE&gt;
Output file; defaults to device serial number followed by "drive_log" suffix

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the drive log from the device and saves to default file in current directory (e.g. STM00019F3F9drive_log.bin):

.if n \{.RS 4
.\}
    # nvme wdc drive-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the drive log from the device and saves to defined file in current directory (e.g. testSTM00019F3F9drive_log.bin):

.if n \{.RS 4
.\}
    # nvme wdc drive-log /dev/nvme0 -o test
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the drive log from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9drive_log.bin):

.if n \{.RS 4
.\}
    # nvme wdc drive-log /dev/nvme0 -o /tmp/test
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
