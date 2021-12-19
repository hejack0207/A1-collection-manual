# nvme\-compare(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-compare - Send an NVMe Compare command, provide results

<a name="synopsis"></a>

# Synopsis

```


```
    nvme-compare <device> [--start-block=<slba> | -s <slba>]
                            [--block-count=<nlb> | -c <nlb>]
                            [--data-size=<size> | -z <size>]
                            [--metadata-size=<metasize> | -y <metasize>]
                            [--ref-tag=<reftag> | -r <reftag>]
                            [--data=<data-file> | -d <data-file>]
                            [--metadata=<meta> | -M <meta>]
                            [--prinfo=<prinfo> | -p <prinfo>]
                            [--app-tag-mask=<appmask> | -m <appmask>]
                            [--app-tag=<apptag> | -a <apptag>]
                            [--limited-retry | -l]
                            [--force-unit-access | -f]
                            [--dir-type=<type> | -T <type>]
                            [--dir-spec=<spec> | -S <spec>]
                            [--dsm=<dsm> | -D <dsm>]
                            [--show-command | -v]
                            [--dry-run | -w]
                            [--latency | -t]

<a name="description"></a>

# Description


The Compare command reads the logical blocks specified by the command from the medium and compares the data read to a comparison data buffer transferred as part of the command. If the data read from the controller and the comparison data buffer are equivalent with no miscompares, then the command completes successfully. If there is any miscompare, the command completes with an error of Compare Failure. If metadata is provided, then a comparison is also performed for the metadata.

<a name="options"></a>

# Options


-s &lt;slba&gt;, --start-block=&lt;slba&gt;
64-bit address of the first block to access.

-c &lt;nlb&gt;, --block-count=&lt;nlb&gt;
Number of blocks to be accessed (zero-based).

-z &lt;size&gt;, --data-size=&lt;size&gt;
Size of data to be compared in bytes.

-y &lt;metasize&gt;, --metadata-size=&lt;metasize&gt;
Size of metadata to be trasnferred in bytes.

-r &lt;reftag&gt;, --ref-tag=&lt;regtag&gt;
Reference Tag for Protection Information

-d &lt;data-file&gt;, --data=&lt;data-file&gt;
Data file.

-M &lt;meta&gt;, --metadata=&lt;meta&gt;
Metadata file.

-p &lt;prinfo&gt;, --prinfo=&lt;prinfo&gt;
Protection Information and check field.

+
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


-m &lt;appmask&gt;, --app-tag-mask=&lt;appmask&gt;
App Tag Mask for Protection Information

-a &lt;apptag&gt;, --app-tag=&lt;apptag&gt;
App Tag for Protection Information

-l, --limited-retry
Number of limited attempts to media.

-f, --force-unit-access
FUA option to guarantee that data is stored to media.

-T &lt;type&gt;, --dir-type=&lt;type&gt;
Optional directive type. The nvme-cli only enforces the value be in the defined range for the directive type, though the NVMe specifcation (1.3a) defines only one directive, 01h, for write stream idenfiers.

-S &lt;spec&gt;, --dir-spec=&lt;spec&gt;
Optional field for directive specifics. When used with write streams, this value is defined to be the write stream identifier. The nvme-cli will not validate the stream requested is within the controller’s capabilities.

-D &lt;dsm&gt;, --dsm=&lt;dsm&gt;
The optional data set management attributes for this command. The argument for this is the lower 16 bits of the DSM field in a write command; the upper 16 bits of the field come from the directive specific field, if used. This may be used to set attributes for the LBAs being written, like access frequency, type, latency, among other things, as well as yet to be defined types. Please consult the NVMe specification for detailed breakdown of how to use this field.

-v, --show-cmd
Print out the command to be sent.

-w, --dry-run
Do not actually send the command. If want to use --dry-run option, --show-cmd option
_must_
be set. Otherwise --dry-run option will be
_ignored_.

-t, --latency
Print out the latency the IOCTL took (in us).

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
