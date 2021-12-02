# nvme\-intel\-interna(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-intel-internal-log - Retrieve Intel devices internal log and save to file.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme intel internal-log *(Aq <device> [--log=<NUM>, -l <NUM>]
                    [--region=<NUM>, r <NUM>]
                    [--nlognum=<NUM>, m <NUM>]
                    [--namespace-id=<NUM>, -n <NUM>]
                    [--output-file=<FILE>, -o <FILE>]

<a name="description"></a>

# Description


For the NVMe device given, sends the Intel vendor unique device log request and saves the result to a file.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1). If using the character device, the namespace id parameter is mandatory.

This will only work on Intel devices supporting this feature which includes (but not limited to) all the Intel DC P3xxx family of controllers. Results for any other device are undefined.

<a name="options"></a>

# Options


-l &lt;NUM&gt;, --log=&lt;NUM&gt;
Log type: 0, 1, or 2 for nlog, event log, and assert log, respectively.

-n &lt;NUM&gt;, --namespace-id=&lt;NUM&gt;
Namespace to use.

-o &lt;FILE&gt;, --output-file=&lt;FILE&gt;
Output file; defaults to device name provided

-r &lt;NUM&gt;, --region=&lt;NUM&gt;
Select which core region to retrieve the log from. -1 for all available, if supported by the device.

-m &lt;NUM&gt;, --nlognum=&lt;NUM&gt;
When used with
_nlog_, this specifies which nlog to read. -1 for all, if supported by the device.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the nlog from the device and saves to default file:

.if n \{.RS 4
.\}
    # nvme intel internal-log /dev/nvme0 --namespace-id=1 --log=0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the event log from the device and saves to defined file:

.if n \{.RS 4
.\}
    # nvme intel internal-log /dev/nvme0 --namespace-id=1 --log=1 --output-file=MyAwesomeEventLog
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
