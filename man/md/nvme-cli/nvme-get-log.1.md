# nvme\-get\-log(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-get-log - Retrieves a log page from an NVMe device

<a name="synopsis"></a>

# Synopsis

```


```
    nvme get-log <device> [--log-id=<log-id> | -i <log-id>]
                          [--log-len=<log-len> | -l <log-len>]
                          [--aen=<aen> | -a <aen>]
                          [--namespace-id=<nsid> | -n <nsid>]
                          [--raw-binary | -b]
                          [--lpo=<offset> | -o <offset>]
                          [--lsp=<field> | -s <field>]
                          [--rae | -r]

<a name="description"></a>

# Description


Retrieves an arbitrary NVMe log page from an NVMe device and provides the returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned log structure may be returned in one of several ways depending on the option flags; the structure may be displayed in hex by the program or the raw buffer may be printed to stdout for another program to parse.

<a name="options"></a>

# Options


-l &lt;log-len&gt;, --log-len=&lt;log-len&gt;
Allocates a buffer of &lt;log-len&gt; bytes size and requests this many bytes be returned in the constructed NVMe command. This param is mandatory.

-i &lt;log-id&gt;, --log-id=&lt;log-id&gt;
Sets the commands requested log-id to &lt;log-id&gt;. Defaults to 0.

-a &lt;aen&gt;, --aen=&lt;aen&gt;
Convenience field for extracting log information based on an asynchronous event notification result. This will override log-id and log-len, if set.

-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Sets the command’s nsid value to the given nsid. Defaults to 0xffffffff if not given. This option may not affect anything depending on the log page, which may or may not be specific to a namespace.

-b, --raw-binary
Print the raw log buffer to stdout.

-o &lt;offset&gt;, --lpo=&lt;offset&gt;
The log page offset specifies the location within a log page to start returning data from. It’s Dword-aligned and 64-bits.

-s &lt;field&gt;, --lsp=&lt;field&gt;
The log specified field of LID.

-r, --rae
Retain an Asynchronous Event.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get 512 bytes from log page 2

.if n \{.RS 4
.\}
    # nvme get-log /dev/nvme0 --log-id=2 --log-len=512
.if n \{.RE
.\}

The above example will get log page 2 (SMART), and request 512 bytes. On success, the returned log will be dumped in hex and not interpreted by the program.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Have the program return the raw log page in binary:

.if n \{.RS 4
.\}
    # nvme get-log /dev/nvme0 -log-id=2 --log-len=512 --raw-binary > log_page_2.raw
    # nvme get-log /dev/nvme0 -i 2 -l 512 -b > log_page_2.raw
.if n \{.RE
.\}

It is not a good idea to not redirect stdout when using this mode.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
