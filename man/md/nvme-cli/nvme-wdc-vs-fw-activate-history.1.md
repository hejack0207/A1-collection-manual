# nvme\-wdc\-vs\-fw\-a(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-vs-fw-activate-history - Execute NVMe WDC vs-fw-activate-history Vendor Unique Command, return result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc vs-fw-activate-history <device> [--output-format=<normal|json> -o <normal|json>]

<a name="description"></a>

# Description


For the NVMe device given, read a Vendor Unique WDC log page that returns the firmware actiation history.

The &lt;device&gt; parameter is mandatory and must be the NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns 0, error code otherwise.

<a name="options"></a>

# Options


-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_, or
_json_. Only one output format can be used at a time. Default is normal.

<a name="firmware-activate-history-log-page-data-output-explanation"></a>

# Firmware Activate History Log Page Data Output Explanation

.TS
allbox tab(:);
ltB ltB.
T{
Field
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**Entry Number**
T}:T{

The number of fw activate entry. The most recent 20 entries will be displayed.
T}
T{

**Power on Hour**
T}:T{

The time since the power on in hours:minutes:seconds.
T}
T{

**Power Cycle Count**
T}:T{

The power cycle count that the firmware activation occurred.
T}
T{

**Current Firmware**
T}:T{

The firmware level currently running on the SSD before the activation took place.
T}
T{

**New Firmware**
T}:T{

The new firmware level running on the SSD after the activation took place.
T}
T{

**Slot Number**
T}:T{

The slot tht the firmware is being activated from.
T}
T{

**Commit Action Type**
T}:T{

The commit action type associated with the firmware activation event
T}
T{

**Result**
T}:T{

The result of the firmware activation event. The ouput shall be in the format: Pass or Failed + error code
T}
.TE


<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program issue WDC vs-fw-activate-history Vendor Unique Command :

.if n \{.RS 4
.\}
    # nvme wdc vs-fw-activate-history /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
