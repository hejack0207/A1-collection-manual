# nvme\-write(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-write - Send an NVMe write command, provide results

<a name="synopsis"></a>

# Synopsis

```


```
    nvme-write <device> [--start-block=<slba> | -s <slba>]
                            [--block-count=<nlb> | -c <nlb>]
                            [--data-size=<size> | -z <size>]
                            [--metadata-size=<size> | -y <size>]
                            [--ref-tag=<reftag> | -r <reftag>]
                            [--data=<data-file> | -d <data-file>]
                            [--metadata=<metadata-file> | -M <metadata-file>]
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


The Write command writes the logical blocks specified by the command to the medium from the data data buffer provided. Will use stdin by default if you don’t provide a file.

<a name="options"></a>

# Options


--start-block=&lt;slba&gt;, -s &lt;slba&gt;
Start block.

--block-count, -c
The number of blocks to transfer. This is a zeroes based value to align with the kernel’s use of this field. (ie. 0 means transfer 1 block).

--data-size=&lt;size&gt;, -z &lt;size&gt;
Size of data, in bytes.

--metadata-size=&lt;size&gt;, -y &lt;size&gt;
Size of metadata in bytes.

--data=&lt;data-file&gt;, -d &lt;data-file&gt;
Data file. If none provided, contents are sent from STDIN.

--metadata=&lt;metadata-file&gt;, -M &lt;metadata-file&gt;
Metadata file, if necessary.

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

--force-unit-access, -f
Set the force-unit access flag.

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
