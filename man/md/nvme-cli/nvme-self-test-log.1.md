# nvme\-self\-test\-lo(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-self-test-log - Retrieve the log information initited by device-self-test and display it

<a name="synopsis"></a>

# Synopsis

```


```
    nvme self-test-log <device> [--output-format=<FMT> | -o <FMT>]

<a name="description"></a>

# Description


Retrieves the log pages from an NVMe device corresponding to the requested self-test by the user and provides 20-most recent result returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned log structure may be returned in one of several ways depending on the option flags; the structure may parsed by the program and printed in a readable format or the raw buffer or the json format.

By default the log is printed out in the normal readable format.

<a name="option"></a>

# Option


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
  Get the self-test-log and print it in a human readable format:

.if n \{.RS 4
.\}
    # nvme self-test-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Print the raw output to a file:

.if n \{.RS 4
.\}
    # nvme self-test-log /dev/nvme0 -o "binary"
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get the self-test-log and print it in a json format:

.if n \{.RS 4
.\}
    # nvme self-test-log /dev/nvme0 -o "json"
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
