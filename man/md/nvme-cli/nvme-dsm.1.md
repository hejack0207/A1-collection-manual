# nvme\-dsm(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-dsm - Send NVMe Data Set Management, return results

<a name="synopsis"></a>

# Synopsis

```


```
    nvme dsm <device>  [ --namespace-id=<nsid> | -n <nsid> ]
                            [ --ctx-attrs=<attribute-list,> | -a <attribute-list,> ]
                            [ --blocks=<nlb-list,> | -b <nlb-list,> ]
                            [ --slbs=<slba-list,> | -s <slba-list,> ]
                            [ --ad | -d ] [ --idw | -w ] [ --idr | -r ]
                            [ --cdw11=<cdw11> | -c <cdw11> ]

<a name="description"></a>

# Description


For the NVMe device given, sends an Data Set Management command and provides the result and returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1). If the character device is given, the --namespace-id\*(Aq option is mandatory, otherwise it will use the ns-id of the namespace for the block device you opened. For block devices, the ns-id used can be overridden with the same option.

You must specify at least one of the values for range list. If the range lists provided do not list the same number of elements, the default values for the remaining in the range will be set to 0.

The command dword 11 may be provided at the command line. For convenience, the current defined attributes (discard, integral read/write) for a data-set management have flags. If cdw11 is specified, this will override any settings from the flags may have provided.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Sends the command with the requested nsid. This is required for the character devices, or overrides the block nsid if given.

-a &lt;attribute-list,&gt;, --ctx-attrs=&lt;attribute-list&gt;
Comma separated list of the context attributes in each range

-b &lt;nlb-list,&gt;, --blocks=&lt;nlb-list,&gt;
Comma separated list of the number of blocks in each range

-s &lt;slba-list,&gt;, --slbs=&lt;slba-list,&gt;
Comma separated list of the starting block in each range

-d &lt;deallocate&gt;, --ad=&lt;deallocate&gt;
Attribute Deallocate.

-w &lt;write&gt;, --idw=&lt;write&gt;
Attribute Integral Dataset for Write.

-r &lt;read&gt;, --idr=&lt;read&gt;
Attribute Integral Dataset for Read.

-c &lt;cdw11&gt;, --cdw11=&lt;cdw11&gt;
All the command command dword 11 attributes. Use exclusive from specifying individual attributes

<a name="examples"></a>

# Examples


No examples yet

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
