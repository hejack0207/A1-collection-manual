# nvme\-toshiba\-vs\-s(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-toshiba-vs-smart-add-log - Retrieve a Toshiba devices vendor specific extended SMART log page contents and either save to file or dump the contents.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme toshiba vs-smart-add-log *(Aq <device> [--log=<NUM>, -l <NUM>]
                    [--namespace-id=<NUM>, -n <NUM>]
                    [--output-file=<FILE>, -o <FILE>]

<a name="description"></a>

# Description


For the NVMe device given, sends the Toshiba vendor log request and either saves the result to a file or dumps the content to stdout.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

The log contents may be associated with the controller, in which case the namespace parameter is ignored.

Two logs exist, page 0xC0 (log page directory) and page 0xCA (vendor log page)

This will only work on Toshiba devices supporting this feature.

<a name="options"></a>

# Options


-l &lt;NUM&gt;, --log=&lt;NUM&gt;
Log page: 0xC0 or 0xCA (defaults to 0xCA)

-n &lt;NUM&gt;, --namespace-id=&lt;NUM&gt;, -o &lt;FILE&gt;, --output-file=&lt;FILE&gt;
Output binary file. Defaults to text-formatted dump to stdout

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get the current log from the device and dumps it to stdout:

.if n \{.RS 4
.\}
    # nvme toshiba vs-smart-add-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get the contents of log page 0xC0 from the device and save to a binary file:

.if n \{.RS 4
.\}
    # nvme toshiba vs-smart-add-log /dev/nvme0 --output-file=log.bin --log=0xC0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
