# nvme\-fw\-download(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-fw-download - Download all or a portion of an nvme firmware image.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme fw-download <device> [--fw=<firmware-file> | -f <firmware-file>]
                        [--xfer=<transfer-size> | -x <transfer-size>]
                        [--offset=<offset> | -o <offset>]

<a name="description"></a>

# Description


The Firmware Image Download command is used to download all or a portion of the firmware image for a future update to the controller. The Firmware Image Download command may be submitted while other commands on the Admin Submission Queue or I/O Submission Queues are outstanding. The Firmware Image Download command copies the new firmware image (in whole or in part) to the controller.

The firmware image may be constructed of multiple pieces that are individually downloaded with separate Firmware Image Download commands. Each Firmware Image Download command includes a Dword Offset and Number of Dwords that specify a Dword range. The host software shall ensure that firmware pieces do not have Dword ranges that overlap. Firmware portions may be submitted out of order to the controller.

The new firmware image is not applied as part of the Firmware Image Download command. It is applied following a reset, where the image to apply and the firmware slot it should be committed to is specified with the Firmware Commit command (nvme fw-commit &lt;args&gt;).

<a name="options"></a>

# Options


-f &lt;firmware-file&gt;, --fw=&lt;firmeware-file&gt;
Required argument. This specifies the path to the device’s firmware file on your system that will be read by the program and sent to the device.

-x &lt;transfer-size&gt;, --xfer=&lt;transfer-size&gt;
This specifies the size to split each transfer. This is useful if the device has a max transfer size requirement for firmware. It defaults to 4k.

-o &lt;offset&gt;, --offset=&lt;offset&gt;
This specifies the starting offset in dwords. This is really only useful if your firmware is split in multiple files; otherwise the offset starts at zero and automatically adjusts based on the
_xfer_
size given.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Transfer a firmware size 128KiB at a time:

.if n \{.RS 4
.\}
    # nvme fw-download /dev/nvme0 --fw=/path/to/nvme.fw --xfer=0x20000
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
