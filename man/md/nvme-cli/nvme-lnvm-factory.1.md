# nvme\-lnvm\-factory(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-lnvm-factory - Factory reset a LightNVM device

<a name="synopsis"></a>

# Synopsis

```


```
    nvme lnvm-factory [--device-name=<DEVICE> | -d <DEVICE>]
                            [--erase-only-marked | -e]
                            [--clear-host-side-blks | -s]
                            [--clear-bb-blks | -b]

<a name="description"></a>

# Description


Instantiate a target on top of a LightNVM enabled device. This exposes the physical for the user to use.

<a name="options"></a>

# Options


--device-name=&lt;DEVICE&gt;, -d &lt;DEVICE&gt;
Device name to factory initialize

--erase-only-marked, -e
Erases only blocks that are marked in the bad block list

--clear-host-side-blks, -s
Remove host-side bad block marks. This clear the media manager registration

--clear-bb-blks, -b
Removes the grown bad block marks. Allowing them to be rediscovered.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Factory reset of device nvme0n1

.if n \{.RS 4
.\}
    # nvme lnvm-factory -d nvme0n1
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Complete factory reset of device nvme0n1

.if n \{.RS 4
.\}
    # nvme lnvm-factory -d nvme0n1 -s -b
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
