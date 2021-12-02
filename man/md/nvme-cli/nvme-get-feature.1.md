# nvme\-get\-feature(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-get-feature - Gets an NVMe feature, returns applicable results

<a name="synopsis"></a>

# Synopsis

```


```
    nvme get-feature <device> [--namespace-id=<nsid> | -n <nsid>]
                              [--feature-id=<fid> | -f <fid>] [--cdw11=<cdw11>]
                              [--data-len=<data-len> | -l <data-len>]
                              [--sel=<select> | -s <select>]
                              [--raw-binary | -b]
                              [--human-readable | -H]

<a name="description"></a>

# Description


Submits an NVMe Get Feature admin command and returns the applicable results. This may be the feature’s value, or may also include a feature structure if the feature requires it (ex: LBA Range Type).

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned feature’s structure (if applicable) may be returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format if it is a known structure, displayed in hex, or the raw buffer may be printed to stdout for another program to parse.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Retrieve the feature for the given nsid. This is optional and most features do not use this value.

-f &lt;fid&gt;, --feature-id=&lt;fid&gt;
The feature id to send with the command. Value provided should be in hex.

-s &lt;select&gt;, --sel=&lt;select&gt;
Select (SEL): This field specifies which value of the attributes to return in the provided data:
.TS
allbox tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{
Select
T}:T{
Description
T}
T{
0
T}:T{
Current
T}
T{
1
T}:T{
Default
T}
T{
2
T}:T{
Saved
T}
T{
3
T}:T{
Supported capabilities
T}
T{
4–7
T}:T{
Reserved
T}
.TE


-l &lt;data-len&gt;, --data-len=&lt;data-len&gt;
The data length for the buffer returned for this feature. Most known features do not use this value. The exception is LBA Range Type

--cdw11=&lt;cdw11&gt;
The value for command dword 11, if applicable.

-b, --raw-binary
Print the raw feature buffer to stdout if the feature returns a structure.

-H, --human-readable
This option will parse and format many of the bit fields into human-readable formats.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Retrieves the feature for Number of Queues, or feature id 7:

.if n \{.RS 4
.\}
    # nvme get-feature /dev/nvme0 -f 7
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The following retrieves the feature for the LBA Range Type, which implicitly requires a buffer and will be printed to the screen in human readable format:

.if n \{.RS 4
.\}
    # nvme get-feature /dev/nvme0 -f 3
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Retrieves the feature for the some vendor specific feature and specifically requesting a buffer be allocate for this feature, which will be displayed to the user in as a hex dump:

.if n \{.RS 4
.\}
    # nvme get-feature /dev/nvme0 -f 0xc0 -l 512
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The following retrieves the feature for the LBA Range Type, which implicitly requires a buffer and will be saved to a file in its raw format:

.if n \{.RS 4
.\}
    # nvme get-feature /dev/nvme0 -f 3 --raw-binary > lba_range.raw
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
