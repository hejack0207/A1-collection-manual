# nvme\-wdc\-vs\-inter(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-vs-internal-log - Retrieve WDC devices internal firmware log and save to file.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc vs-internal-log <device> [--output-file=<FILE>, -o <FILE>] [--transfer-size=<SIZE>, -s <SIZE>]
        [--data-area=<DATA AREA>, -d <DATA_AREA>] [--file-size=<FILE SIZE>, -f <FILE SIZE>] [--offset=<OFFSET>, -e <OFFSET>]
        [--type=<TYPE>, -t <type>] [--verbose, -v]

<a name="description"></a>

# Description


For the NVMe device given, sends the WDC Vendor Specific Internal Log request and saves the result to a file.

The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

<a name="options"></a>

# Options


-o &lt;FILE&gt;, --output-file=&lt;FILE&gt;
Output file; defaults to device serial number followed by "_internal\_fw\_log_&lt;date&gt;_&lt;time&gt;.bin" suffix

-s &lt;SIZE&gt;, --transfer-size=&lt;SIZE&gt;
Transfer size; defaults to 0x10000 (65536 decimal) bytes

-d &lt;DATA AREA&gt;, --data-area=&lt;DATA AREA&gt;
DUI data area to retrieve. The DUI data areas from 1 to &lt;DATA AREA&gt; will be retrieved. This parameter is currently only supported on the SN340, SN640, and SN840 devices.

-f &lt;FILE SIZE&gt;, --file-size=&lt;FILE SIZE&gt;
Specifies the desired size of the data file starting at the passed in offset. This allows the user to retrieve the data in several smaller files of the passed in size. This parameter is currently only supported on the SN340 device.

-e &lt;OFFSET&gt;, --offset=&lt;OFFSET&gt;
Specifies the data offset at which to start retrieving the data. This parameter is used in combination with the file size parameter to retrieve the data in several smaller files. This parameter is currently only supported on the SN340 device.

-t &lt;TYPE&gt;, --type=&lt;TYPE&gt;
Specifies the telemetry type - NONE, HOST, or CONTROLLER. This parameter is used to get either the host generated or controller initiated telemetry log page. If not specified or none is specified, the command will return the default E6 log data. This parameter is currently only supported on the SN640 and SN840 devices.

-v &lt;VERBOSE&gt;, --verbose=&lt;VERBOSE&gt;
Provides additional debug messages for certain drives.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the internal firmware log from the device and saves to default file in current directory (e.g. STM00019F3F9_internal_fw_log_20171127_095704.bin):

.if n \{.RS 4
.\}
    # nvme wdc vs-internal-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the internal firmware log from the device and saves to defined file in current directory (e.g. test.bin):

.if n \{.RS 4
.\}
    # nvme wdc vs-internal-log /dev/nvme0 -o test.bin
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the internal firmware log from the device and saves to defined file with pathname (e.g. /tmp/test):

.if n \{.RS 4
.\}
    # nvme wdc vs-internal-log /dev/nvme0 -o /tmp/test
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the internal firmware log from the device transferring the data in 64k chunks and saves to default file in current directory (e.g. STM00019F3F9_internal_fw_log_20171127_100754.bin):

.if n \{.RS 4
.\}
    # nvme wdc vs-internal-log /dev/nvme0 -s 0x10000
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the internal firmware log from the device transferring the data in 16k chunks and saves to default file in current directory (e.g. STM00019F3F9_internal_fw_log_20171127_100950.bin):

.if n \{.RS 4
.\}
    # nvme wdc vs-internal-log /dev/nvme0 -s 16384
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the internal firmware log up to data area 3 from the device in 3 files of 0x1000000 bytes:

.if n \{.RS 4
.\}
    # nvme wdc vs-internal-log /dev/nvme0 -d 3 -f 0x1000000 -t 0x0000000 -o /tmp/sn340_dui_data_1.bin
    # nvme wdc vs-internal-log /dev/nvme0 -d 3 -f 0x1000000 -t 0x1000000 -o /tmp/sn340_dui_data_2.bin
    # nvme wdc vs-internal-log /dev/nvme0 -d 3 -f 0x1000000 -t 0x2000000 -o /tmp/sn340_dui_data_3.bin
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the host telemetry log page to data area 3 from the device and stores it in file host-telem-log-da3.bin:

.if n \{.RS 4
.\}
    # nvme wdc vs-internal-log /dev/nvme1 -t host -o host-telem-log-da3.bin -d 3
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the controller telemetry log page to data area 3 from the device and stores it in file ctlr-telem-log-da3.bin:

.if n \{.RS 4
.\}
    # nvme wdc vs-internal-log /dev/nvme1 -t controller -o ctlr-telem-log-da3.bin -d 3
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
