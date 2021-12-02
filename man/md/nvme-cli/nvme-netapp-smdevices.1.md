# nvme\-netapp\-smdevi(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-netapp-smdevices - Display information for each NVMe path to an E-Series volume

<a name="synopsis"></a>

# Synopsis

```


```
    nvme netapp smdevices [-o <fmt> | --output-format=<fmt>]

<a name="description"></a>

# Description


Display vendor-specific information for each NVMe path to an E-Series namespace currently connected to the host. The E-Series paths are identified from the NVMe nodes in /dev by sending an Identify Controller.

<a name="options"></a>

# Options


-o &lt;fmt&gt;, --output-format=&lt;fmt&gt;
Set the reporting format to
_normal_
(default),
_column_, or
_json_. Only one output format can be used at a time.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Display information, in a column-based format, for each path to an E-Series namespace.

.if n \{.RS 4
.\}
    # nvme netapp smdevices -o column
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
