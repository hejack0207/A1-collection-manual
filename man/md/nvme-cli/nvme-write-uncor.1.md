# nvme\-uncor(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-write-uncor - Send an NVMe write uncorrectable command, return results

<a name="synopsis"></a>

# Synopsis

```


```
    nvme-write-uncorr <device> [--start-block=<slba> | -s <slba>]
                            [--block-count=<nlb> | -c <nlb>]
                            [--namespace-id=<nsid> | -n <nsid>]

<a name="description"></a>

# Description


The Write Uncorrectable command is used to invalidate a range of logical blocks.

<a name="options"></a>

# Options


--start-block=&lt;slba&gt;, -s &lt;slba&gt;
Start block.

--block-count=&lt;nlb&gt;, -c
Number of logical blocks to write uncorrectable.

--namespace-id=&lt;nsid&gt;, -n &lt;nsid&gt;
Namespace ID use in the command.

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
