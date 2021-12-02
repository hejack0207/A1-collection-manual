# nvme\-create\-ns(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-create-ns - Send NVMe Namespace management command to create namespace, returns results.

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    nvme create-ns <device> [--nsze=<nsze> | -s <nsze>]
                            [--ncap=<ncap> | -c <ncap>]
                            [--flbas=<flbas> | -f <flbas>]
                            [--dps=<dps> | -d <dps>]
                            [--nmic=<nmic> | -m <nmic>]
                            [--anagrp-id=<anagrpid> | -a <anagrpid>]
                            [--nvmset-id=<nvmsetid> | -i <nvmsetid>]
                            [--block-size=<block-size> | -b <block-size>]
                            [--timeout=<timeout> | -t <timeout>]
    DESCRIPTION
<synopsis>


</synopsis>
    For the NVMe device given, sends a namespace management command to create
    the namespace with the requested settings. On success, the namespace
    identifier assigned by the controller is returned.
    
    The <device> parameter is mandatory and may be either the NVMe character
    device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
    
    OPTIONS
<synopsis>

 -s, --nsze .RS 4 The namespace size. .RE 
 -c, --ncap .RS 4 The namespace capacity. .RE 
 -f, --flbas .RS 4 The namespace formatted logical block size setting. Conflicts with --block-size argument. .RE 
 -d, --dps .RS 4 The data protection settings. .RE 
 -m, --nmic .RS 4 Namespace multipath and sharing capabilities. .RE 
 -a, --anagrp-id .RS 4 ANA Gorup Identifier. If this value is 0h specifies that the controller determines the value to use .RE 
 -i <nvmsetid>, --nvmset-id=<nvmsetid> .RS 4 This field specifies the identifier of the NVM Set. .RE 
 -b, --block-size .RS 4 Target block size the new namespace should be formatted as. Potential FLBAS values will be values will be scanned and the lowest numbered will be selected for the create-ns operation. Conflicts with --flbas argument. .RE
```

<a name="examples"></a>

# Examples


No examples provided yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
