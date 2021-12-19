# nvme\-dir\-receive(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-dir-receive - Send a directive receive command, returns applicable results

<a name="synopsis"></a>

# Synopsis

```


```
    nvme dir-receive <device> [--namespace-id=<nsid> | -n <nsid>]
                              [--data-len=<data-len> | -l <data-len>]
                              [--dir-type=<dtype> | -D <dtype>]
                              [--dir-spec=<dspec> | -S <dspec>]
                              [--dir-oper=<doper> | -O <doper>]
                              [--req-resource=<nsr> | -r <nsr>]
                              [--human-readable | -H]
                              [--raw-binary | -b]

<a name="description"></a>

# Description


Submits an NVMe Directive Receive admin command and returns the applicable results. This may be the combination of directive type, and operation, as well as number of requested resource if specific operation needs it.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned directive’s parameter structure (if applicable) is returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format if it is a known structure, displayed in hex, or the raw buffer may be printed to stdout for another program to parse.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Retrieve the feature for the given nsid. This is optional and most features do not use this value.

-D &lt;dtype&gt;, --dir-type=&lt;dtype&gt;
Directive type

-S &lt;dspec&gt;, --dir-spec=&lt;dspec&gt;
Directive specific

-O &lt;doper&gt;, --dir-oper=&lt;doper&gt;
Directive operation

-r &lt;nsr&gt;, --req-resource=&lt;nsr&gt;
Directive requested resource count

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

-b, --raw-binary
Print the raw receive buffer to stdout if the command returns a structure.

-H, --human-readable
Print the decoded receive buffer to stdout if the command returns a structure.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Identify directive type supported :

.if n \{.RS 4
.\}
    # nvme dir-receive /dev/nvme0 --dir-type 0 --dir-oper 1 --human-readable
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get stream directive parameters :

.if n \{.RS 4
.\}
    # nvme dir-receive /dev/nvme0 --dir-type 1 --dir-oper 1 --human-readable
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Allocate 3 streams for namespace 1

.if n \{.RS 4
.\}
    # nvme dir-receive /dev/nvme0n1 --dir-type 1 --dir-oper 3 --req-resource 3 --human-readable
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get streams directive status :

.if n \{.RS 4
.\}
    # nvme dir-receive /dev/nvme0 --dir-type 1 --dir-oper 2 --human-readable
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
