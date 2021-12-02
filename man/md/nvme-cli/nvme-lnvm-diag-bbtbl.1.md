# nvme\-lnvm\-diag\-bb(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-lnvm-diag-bbtbl - Diagnose the bad block table

<a name="synopsis"></a>

# Synopsis

```


```
    nvme lnvm-diag-bbtbl [--namespace-id=<NUM> | -n <NUM>]
                            [--channel-id=<CHID> | -c <CHID>]
                            [--lun-id=<LUNID> | -l <LUNID>]
                            [--raw-binary | -b]

<a name="description"></a>

# Description


Retrieve the bad block table for a given channel and lun.

The statistics will be shown in the default case, and the actual output bad block information can be retrieved when --raw-binary is passed.

The raw binary output follows this format:

Channel 0, LUN0 (Dual plane flash)

Byte 0 \(-&gt; Plane 0, Block 0 Byte 1 \(-&gt; Plane 1, Block 0 Byte 2 \(-&gt; Plane 0, Block 1 ...

<a name="options"></a>

# Options


--namespace-id=&lt;NUM&gt;, -n &lt;NUM&gt;
Namespace id to use

--channel-id=&lt;NUM&gt;, -c
Channel id

--lun-id=&lt;NUM&gt;, -l
LUN id

--raw-binary, -b
Returns the bad block table in binary form without statistics.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Retrieve bad block table statistics for physical device nvme0, channel 0, and lun 0:

.if n \{.RS 4
.\}
    # nvme lnvm-diag-bbtbl /dev/nvme0 -c 0 -n 0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Display the bad block table in raw form without statistics for same query:

.if n \{.RS 4
.\}
    # nvme lnvm-diag-bbtbl /dev/nvme0 -c 0 -n 0 -b | hexdump
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
