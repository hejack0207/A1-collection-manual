# nvme\-wdc\-log\-page(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-log-page-directory - Retrieves the list of Log IDs supported by the drive

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc log-page-directory <device> [--output-format=<normal|json|binary> -o <normal|json|binary>]

<a name="description"></a>

# Description


For the NVMe device given, retrieves the log page directory which contains the list of log page IDs supported by the drive. The --output-format option will format the output as specified.

The &lt;device&gt; parameter is mandatory and must be the NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns the log page directory information, error code otherwise.

<a name="options"></a>

# Options


-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_,
_json_, or
_binary_. Only one output format can be used at a time. The default is normal.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  WDC log-page-directory example command :

.if n \{.RS 4
.\}
    # nvme wdc log-page-directory /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
