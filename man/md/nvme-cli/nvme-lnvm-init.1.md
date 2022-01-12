# nvme\-lnvm\-init(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-lnvm-init - Initialize LightNVM device with media manager

<a name="synopsis"></a>

# Synopsis

```


```
    nvme lnvm-init [--device-name=<DEVICE> | -d <DEVICE>]
                            [--mediamgr-name | -m]

<a name="description"></a>

# Description


Initialize LightNVM device. A LightNVM/Open-Channel SSD must have a media manager associated before it can be exposed to the user. The default is to initialize the general media manager on top of the device.

<a name="options"></a>

# Options


--device-name=&lt;DEVICE&gt;, -d &lt;DEVICE&gt;
Device name to initialize.

--mediamgr-name=&lt;MediaMgr&gt;, -m &lt;MediaMgr&gt;
Media Manager name to use for initialization.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Initialize nvme0n1

.if n \{.RS 4
.\}
    # nvme lnvm-init -d nvme0n1
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Initialize nvme0n1 with gennvm media manager (default media manager)

.if n \{.RS 4
.\}
    # nvme lnvm-init -d nvme0n1 -m gennvm
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
