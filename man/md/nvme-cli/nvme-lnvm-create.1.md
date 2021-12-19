# nvme\-lnvm\-create(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-lnvm-create - Instantiate a target on top of a LightNVM enabled device

<a name="synopsis"></a>

# Synopsis

```


```
    nvme lnvm-create [--device-name=<DEVICE> | -d <DEVICE>]
                            [--target-name=<TARGET> | -n <TARGET>]
                            [--target-type=<TARGETTYPE> | -t <TARGETTYPE>]
                            [--lun-begin <NUM> | -b <NUM>]
                            [--lun-end <NUM> | -e <NUM>]

<a name="description"></a>

# Description


Instantiate a target on top of a LightNVM enabled device. This exposes the physical for the user to use.

The target name is the name of which the media is exposed as in /dev/&lt;targetname&gt;

The target type is the target to be instantiated. Typically pblk or rrpc.

LUN begin and end defines the range of LUNs to use for a target instantiation.

<a name="options"></a>

# Options


--device-name=&lt;DEVICE&gt;, -d &lt;DEVICE&gt;
Device name to initialize.

--target-name=&lt;TARGET&gt;, -n &lt;TARGET&gt;
Target name of the device to initialize. For example: target0.

--target-type=&lt;TARGETTYPE&gt;, -t &lt;TARGETTYPE&gt;
Target type of the device to use. For example: pblk

--lun-begin &lt;NUM&gt;, -b &lt;NUM&gt;
Begin LUN id offset to use for target

--lun-end &lt;NUM&gt;, -e &lt;NUM&gt;
End LUN id offset to use for target

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Initialize nvme0n1 with pblk target with 64 LUNs.

.if n \{.RS 4
.\}
    # nvme lnvm-create -d nvme0n1 -t pblk -n target0 -b 0 -e 63
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
