# nvme\-wdc\-get\-cras(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-get-crash-dump - Retrieve WDC devices crash dump.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc get-crash-dump <device> [--output-file=<FILE>, -o <FILE>]

<a name="description"></a>

# Description


For the NVMe device given, sends the WDC vendor unique crash dump request and saves the result to file. In current implementation crash dump is captured if it is present. On success it will save the dump in file with appropriate suffix. Note that this command will clear the available dump from the device on success.

The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

<a name="options"></a>

# Options


-o &lt;FILE&gt;, --output-file=&lt;FILE&gt;
Output file; defaults to device serial number followed by "crash_dump" suffix

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the crash dump from the device and saves to default file in current directory (e.g. STM00019F3F9crash_dump.bin):

.if n \{.RS 4
.\}
    # nvme wdc get-crash-dump /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the crash dump from the device and saves to defined file in current directory (e.g. testSTM00019F3F9crash_dump.bin):

.if n \{.RS 4
.\}
    # nvme wdc get-crash-dump /dev/nvme0 -o test
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the crash dump from the device and saves to defined file with pathname (e.g. /tmp/testSTM00019F3F9crash_dump.bin):

.if n \{.RS 4
.\}
    # nvme wdc get-crash-dump /dev/nvme0 -o /tmp/test
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
