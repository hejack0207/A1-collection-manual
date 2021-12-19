# nvme\-wdc\-vs\-error(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-vs-error-reason-identifier - Retrieve WDC devices telemetry log error reason identifier field

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc vs-error-reason-identifier <device> [--log-id=<NUM>, -i <NUM>] [--file=<FILE>, -o <FILE>]

<a name="description"></a>

# Description


For the NVMe device given, retrieve the telemetry log error reason id field for either the host generated or controller initiated log. The controller initiated telemetry log page option must be enabled to retrieve the error reason id for that log page id.

The &lt;device&gt; parameter is mandatory and must be the NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns 0, error code otherwise.

<a name="options"></a>

# Options


-i &lt;id&gt;, --log-id=&lt;id&gt;
Specifies the telemetry log id of the error reason identifier to retrieve. Use id 7 for the host generated log page. Use id 8 for the controller initiated log page. The default is 7/host generated

-o &lt;FILE&gt;, --output-file=&lt;FILE&gt;
Output file; defaults to "&lt;device serial number&gt;_error_reason_identifier_host_&lt;date&gt;_&lt;time&gt;.bin" for the host generated log or "&lt;device serial number&gt;_error_reason_identifier_ctlr_&lt;date&gt;_&lt;time&gt;.bin" for the controller initiated log.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Retrieves the host generated error reason identifier field and save it in file host_gen_error_reason_id.bin.

.if n \{.RS 4
.\}
    # nvme wdc vs-error-reason-identifier /dev/nvme0 -i 7 -o host_gen_error_reason_id.bin
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Retrieves the controller initiated error reason identifier field and save it in file ctlr_init_error_reason_id.bin.

.if n \{.RS 4
.\}
    # nvme wdc vs-error-reason-identifier /dev/nvme0 -i 8 -o ctlr_init_error_reason_id.bin
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
