# nvme\-resv\-report(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-resv-report - Send NVMe Reservation Report, parse the result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme resv-report <device> [--namespace-id=<nsid> | -n <nsid>]
                            [--numd=<num-dwords> | -d <num-dwords>]
                            [--cdw11=<cdw11> | -c <cdw11>]
                            [--raw-binary | -b]
                            [--output-format=<fmt> | -o <fmt>]

<a name="description"></a>

# Description


The Reservation Report command returns a Reservation Status data structure to host memory that describes the registration and reservation status of a namespace.

The size of the Reservation Status data structure is a function of the number of controllers in the NVM Subsystem that are associated with hosts that are registrants of the namespace (i.e., there is a Registered Controller data structure for each such controller).

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Retrieve the reservation report structure for the given nsid. This is required for the character devices, or overrides the block nsid if given.

-d &lt;num-dwords&gt;, --numd=&lt;num-dwords&gt;
Specify the number of Dwords of the Reservation Status structure to transfer. Defaults to 4k.

-c &lt;cdw11&gt;, --cdw11=&lt;cdw11&gt;
The value for command dword 11. Setting bit 0 specifies that the controller returns the Extended Data Structure.

-b, --raw-binary
Print the raw buffer to stdout. Structure is not parsed by program.

-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_,
_json_, or
_binary_. Only one output format can be used at a time.

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
