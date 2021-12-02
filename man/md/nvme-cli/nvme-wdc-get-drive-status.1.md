# nvme\-wdc\-get\-driv(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-get-drive-status - Send the NVMe WDC get-drive-status command, return result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc get-drive-status <device>

<a name="description"></a>

# Description


For the NVMe device given, send the unique WDC get-drive-status command and provide the additional drive status information.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns 0, error code otherwise.

<a name="output-explanation"></a>

# Output Explanation

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
lt lt.
T{

**Percent Life Used.**
T}:T{

The percentage of drive function used.
T}
T{

**EOL (End of Life) Status**
T}:T{

The 3 possible states are : Normal, Read Only, or End of Life.
T}
T{

**Assert Dump Status**
T}:T{

The 2 possible states are : Present or Not Present.
T}
T{

**Thermal Throttling Status**
T}:T{

The 3 possible states are : Off, On, or Unavaiable.
T}
T{

**Format Corrupt Reason**
T}:T{

The 3 possible states are : Not Corrupted, Corrupt due to FW Assert, or Corrupt for Unknown Reason.
T}
.TE


<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program issue WDC get-drive-status command :

.if n \{.RS 4
.\}
    # nvme wdc get-drive-status /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
