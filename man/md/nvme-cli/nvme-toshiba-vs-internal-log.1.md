# nvme\-toshiba\-vs\-i(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-toshiba-vs-internal-log - Retrieve a Toshiba devices vendor specific internal log and either save to file or dump the contents.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme toshiba vs-internal-log *(Aq <device>
                    [--output-file=<FILE>, -o <FILE>] (optional)
                    [--saved-log, -s] (optional)

<a name="description"></a>

# Description


For the NVMe device given, sends the Toshiba internal device log request and either saves the result to a file or dumps the content to stdout.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

The log is associated with the controller rather than any namespaces.

Two logs exist, the current log and the previous log.

This will only work on Toshiba devices supporting this feature.

Note: The logs are quite large - typically 100’s of MB. This command can take several minutes to complete. A progress runner is included when data is written to file and a page count is included in the stdout dump.

<a name="options"></a>

# Options


-o &lt;FILE&gt;, --output-file=&lt;FILE&gt;
Output binary file. Defaults to text-formatted dump to stdout

-p, --prev-log
Use previous log contents. Defaults to the current log contents.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get the current log from the device and dump it to stdout:

.if n \{.RS 4
.\}
    # nvme toshiba internal-log /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Get the previous log from the device and save to a binary file:

.if n \{.RS 4
.\}
    # nvme toshiba internal-log /dev/nvme0 --output-file=log.bin --prev-log
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
