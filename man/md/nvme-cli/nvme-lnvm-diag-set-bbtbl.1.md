# nvme\-lnvm\-diag\-se(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-lnvm-diag-set-bbtbl - Set a block state in the bad block table

<a name="synopsis"></a>

# Synopsis

```


```
    nvme lnvm-diag-set-bbtbl [--namespace-id=<NUM> | -n <NUM>]
                            [--channel-id=<CHID> | -c <CHID>]
                            [--lun-id=<LUNID> | -l <LUNID>]
                            [--plane-id=<PLANEID> | -p <PLANEID>]
                            [--block-id=<BLKID> | -b <BLKID>]
                            [--value=<NUM> | -v <NUM>]

<a name="description"></a>

# Description


Set the bad block table for a given channel, lun, plane and block with value v.

For each block available, the status byte is read as follows:

0: Good block 1: Bad block 2: Grown bad block 4: Device reserved block 8: Host-side reserved block 16: Media managed reserved block

<a name="options"></a>

# Options


--namespace-id=&lt;NUM&gt;, -n &lt;NUM&gt;
Namespace id to use

--channel-id, -c
Channel id

--lun-id, -l
LUN id

--plane-id, -p
Plane id

--block-id, -b
Block id

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Set channel 0, lun 0, plane 0, block 10 to bad block value 2 (grown bad) on physical device /dev/nvme0

.if n \{.RS 4
.\}
    # nvme lnvm-diag-set-bbtbl /dev/nvme0 -c 0 -l 0 -p 0 -b 10 -v 2
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
