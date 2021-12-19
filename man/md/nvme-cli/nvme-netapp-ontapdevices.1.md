# nvme\-netapp\-ontapd(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-netapp-ontapdevices - Display information about ONTAP devices

<a name="synopsis"></a>

# Synopsis

```


```
    nvme netapp ontapdevices [-o <fmt> | --output-format=<fmt>]

<a name="description"></a>

# Description


Display information about ONTAP devices on the host. The ONTAP devices are identified using the Identify Controller data.

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
  Display information, in a column-based format, for ONTAP devices.

.if n \{.RS 4
.\}
    # nvme netapp ontapdevices -o column
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
