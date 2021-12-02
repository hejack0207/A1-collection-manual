# nvme\-id\-nvmset(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-id-nvmset - Send NVMe Identify NVM Set List, return result and structure

<a name="synopsis"></a>

# Synopsis

```


```
    nvme id-nvmset <device> [-i <id> | --nvmset_id=<id> ]
                            [-o <fmt> | --output-format=<fmt>]

<a name="description"></a>

# Description


For the NVMe device given, sends an identify NVM set list command and provides the result and returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the structure may be returned in one of several ways depending on the option flags; the structure may be parsed by the program or the raw buffer may be printed to stdout.

<a name="options"></a>

# Options


-i &lt;id&gt;, --nvmset_id=&lt;id&gt;
This field specifies the identifier of the NVM Set. If given, NVM set identifier whose entry is to be in result data will be greater than or equal to this value.

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
  Has the program interpret the returned buffer and display the known fields in a human readable format:

.if n \{.RS 4
.\}
    # nvme id-nvmset /dev/nvme0
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
    # nvme id-nvmset /dev/nvme0 --output-format=binary > id_nvmset.raw
    # nvme id-nvmset /dev/nvme0 -o binary > id_nvmset.raw
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Alternatively you may want to send the data to another program that can parse the raw buffer.

.if n \{.RS 4
.\}
    # nvme id-nvmset /dev/nvme0 -o binary | nvme_parse_id_nvmset
.if n \{.RE
.\}

The parse program in the above example can be a program that shows the structure in a way you like. The following program is such an example that will parse it and can accept the output through a pipe,
|\*(Aq, as shown in the above example, or you can
cat\*(Aq
a saved output buffer to it.

.if n \{.RS 4
.\}
    NVME
.if n \{.RE
.\}

Part of the nvme-user suite
