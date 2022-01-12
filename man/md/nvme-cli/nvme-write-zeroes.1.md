# nvme\-zeroes(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-write-zeroes - Send an NVMe write zeroes command, return results

<a name="synopsis"></a>

# Synopsis

```


```
    nvme-write-zeroes <device> [--start-block=<slba> | -s <slba>]
                            [--block-count=<nlb> | -c <nlb>]
                            [--ref-tag=<reftag> | -r <reftag>]
                            [--prinfo=<prinfo> | -p <prinfo>]
                            [--app-tag-mask=<appmask> | -m <appmask>]
                            [--app-tag=<apptag> | -a <apptag>]
                            [--deac | -d]
                            [--limited-retry | -l]
                            [--force-unit-access | -f]
                            [--namespace-id=<nsid> | -n <nsid>]

<a name="description"></a>

# Description


The Write Zeroes command is used to set a range of logical blocks to 0.

<a name="options"></a>

# Options


--start-block=&lt;slba&gt;, -s &lt;slba&gt;
Start block.

--block-count=&lt;nlb&gt;, -c &lt;nlb&gt;
Number of logical blocks to write zeroes.

--prinfo=&lt;prinfo&gt;, -p &lt;prinfo&gt;
Protection Information field definition.
.TS
allbox tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{
Bit
T}:T{
Description
T}
T{
3
T}:T{
PRACT: Protection Information Action. When set to 1, PI is stripped/inserted on read/write when the block format’s metadata size is 8. When set to 0, metadata is passes.
T}
T{
2:0
T}:T{
PRCHK: Protection Information Check:
T}
T{
2
T}:T{
Set to 1 enables checking the guard tag
T}
T{
1
T}:T{
Set to 1 enables checking the application tag
T}
T{
0
T}:T{
Set to 1 enables checking the reference tag
T}
.TE


--ref-tag=&lt;reftag&gt;, -r &lt;reftag&gt;
Optional reftag when used with protection information.

--app-tag-mask=&lt;appmask&gt;, -m &lt;appmask&gt;
Optional application tag mask when used with protection information.

--app-tag=&lt;apptag&gt;, -a &lt;apptag&gt;
Optional application tag when used with protection information.

--limited-retry, -l
Sets the limited retry flag.

--deac, -d
Sets the DEAC bit, requesting controller deallocate the logical blocks.

--force-unit-access, -f
Set the force-unit access flag.

--namespace-id=&lt;nsid&gt;, -n &lt;nsid&gt;
Namespace ID use in the command.

EXAMPLES EXAMPLES

.if n \{.RS 4
.\}
    No examples yet.
    
    NVME
.if n \{.RE
.\}

Part of the nvme-user suite
