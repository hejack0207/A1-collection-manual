# nvme\-ns\-descs(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-ns-descs - Send NVMe Identify for a list of Namespace Identification Descriptor structure, return result and structure

<a name="synopsis"></a>

# Synopsis

```


```
    nvme ns-descs <device> [--namespace-id=<nsid> | -n <nsid>]
                            [--raw-binary | -b]
                            [--output-format=<fmt> | -o <fmt>]

<a name="description"></a>

# Description


For the NVMe device given, sends an identify for a list of namespace identification descriptor structures command and provides the result and returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1). If the character device is given, the --namespace-id\*(Aq option is mandatory, otherwise it will use the ns-id of the namespace for the block device you opened. For block devices, the ns-id used can be overridden with the same option.

On success, the structure may be returned in one of several ways depending on the option flags; the structure may be parsed by the program or the raw buffer may be printed to stdout.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Retrieve the identify namespace identification descriptor structure for the given nsid. This is required for the character devices, or overrides the block nsid if given.

-b, --raw-binary
Print the raw buffer to stdout. Structure is not parsed by program.

-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_,
_json_, or
_binary_. Only one output format can be used at a time.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If using the character device or overriding namespace #2:

.if n \{.RS 4
.\}
    # nvme ns-descs /dev/nvme0 -n 1
    # nvme ns-descs /dev/nvme0n1 -n 2
    # nvme ns-descs /dev/nvme0 --namespace-id=1
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Have the program return the raw structure in binary:

.if n \{.RS 4
.\}
    # nvme ns-descs /dev/nvme0n1 --raw-binary > ns_descs.raw
    # nvme ns-descs /dev/nvme0n1 -b > ns_descs.raw
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
