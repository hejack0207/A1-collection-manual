# nvme\-wdc\-purge\-mo(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-purge-monitor - Send NVMe WDC Purge-Monitor Vendor Unique Command, return result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc purge-monitor <device>

<a name="description"></a>

# Description


For the NVMe device given, send a Vendor Unique WDC Purge-Monitor command and provide the status of the purge command.

Expected status and description :-
.TS
allbox tab(:);
ltB ltB.
T{
Status Code
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

0x00
T}:T{

Purge State Idle.
T}
T{

0x01
T}:T{

Purge State Done.
T}
T{

0x02
T}:T{

Purge State Busy.
T}
T{

0x03
T}:T{

Purge State Error : Purge operation resulted in error, power cycle required.
T}
T{

0x04
T}:T{

Purge State Error : Purge operation interrupted by power cycle or reset.
T}
.TE


The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns 0, error code otherwise.

<a name="options"></a>

# Options


No options yet.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program issue WDC Purge-Monitor Vendor Unique Command :

.if n \{.RS 4
.\}
    # nvme wdc purge-monitor /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
