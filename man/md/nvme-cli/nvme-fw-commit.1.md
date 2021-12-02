# nvme\-fw\-commit(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-fw-commit - Used to verify and commit a firmware image.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme fw-commit <device> [--slot=<slot> | -s <slot>]
                        [--action=<action> | -a <action>]
                        [--bpid=<boot-partid> | -b <boot-partid> ]

<a name="description"></a>

# Description


For the NVMe device given, send an nvme Firmware Commit admin command and provides the results.

The Firmware Commit command is used to verify that a valid firmware image has been downloaded and to commit that revision to a specific firmware slot. The host may select the firmware image to commit on the next controller reset (CC.EN transitions from ‘1’ to ‘0’, a PCI function level reset, and/or other Controller or NVM Subsystem Reset) as part of this command. The currently executing firmware revision may be determined from the Firmware Revision field of the Identify Controller data structure as indicated in the Firmware Slot Information log page.

No further action is automatically taken to reset the device, which is usually required to complete the activation process. If your kernel and driver are recent enough, you can commit the firmware by issuing a reset through Linux sysfs, for example:

.if n \{.RS 4
.\}
     # echo 1 > /sys/class/nvme/nvme0/device/reset
.if n \{.RE
.\}

If your kernel is not recent enough, you will need to remove and add the device some other way.

<a name="options"></a>

# Options


-a &lt;action&gt;, --action=&lt;action&gt;
Commit Action: This field specifies the action that is taken on the image downloaded with the Firmware Image Download command or on a previously downloaded and placed image.
.TS
allbox tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{
Value
T}:T{
Definition
T}
T{
0
T}:T{
Downloaded image replaces the image indicated by the Firmware Slot field. This image is not activated.
T}
T{
1
T}:T{
Downloaded image replaces the image indicated by the Firmware Slot field. This image is activated at the next reset.
T}
T{
2
T}:T{
The image indicated by the Firmware Slot field is activated at the next reset.
T}
T{
3
T}:T{
The image specified by the Firmware Slot field is requested to be activated immediately without reset.
T}
T{
6
T}:T{
Downloaded image replaces the Boot Partition specified by the Boot Partition ID field.
T}
T{
7
T}:T{
Mark the Boot Partition specified in the BPID field as active and update BPINFO.ABPID.
T}
.TE


-s &lt;slot&gt;, --slot=&lt;slot&gt;
Firmware Slot: Specifies the firmware slot that shall be used for the Commit Action, if applicable. If the value specified is 0h, then the controller shall choose the firmware slot (slot 1 – 7) to use for the operation.

--bpid=&lt;boot-partid&gt;, -b &lt;boot-partid&gt;
Specifiies the Boot partition that shall be used for the Commit Action, if applicable (default: 0)

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  commit the last downloaded fw to slot 1.

.if n \{.RS 4
.\}
    # nvme fw-commit /dev/nvme0 --slot=1 --action=2
.if n \{.RE
.\}

<a name="alias"></a>

# Alias


fw-activate

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
