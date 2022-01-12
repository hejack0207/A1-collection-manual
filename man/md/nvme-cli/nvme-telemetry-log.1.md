# nvme\-telemetry\-log(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-telemetry-log - Retrieves a Telemetry Host-Initiated log page from an NVMe device

<a name="synopsis"></a>

# Synopsis

```


```
    nvme telemetry-log <device> [--output-file=<file> | -o <file>]
                          [--host-generate=<gen> | -g <gen>]

<a name="description"></a>

# Description


Retrieves an Telemetry Host-Initiated log page from an NVMe device and provides the returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the returned log structure will be in raw binary format _only_ with --output-file option which is mandatory.

<a name="options"></a>

# Options


-o &lt;file&gt;, --output-file=&lt;file&gt;
File name to which raw binary data will be saved to.

-g &lt;gen&gt;, --host-generate=&lt;gen&gt;
If set to 1, controller shall capture the Telemetry Host-Initiated data representing the internal state of the controller at the time the associated Get Log Page command is processed. If cleated to 0, controller shall
_not_
update this data.

-d &lt;da&gt;, --data-area=&lt;da&gt;
Retrieves the specific data area requested. Valid inputs are 1,2,3. If this option is not specified, the default value is 3, since that will always give the user all three data areas.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Retrieve Telemetry Host-Initiated data to telemetry_log.bin

.if n \{.RS 4
.\}
    # nvme telemetry-log /dev/nvme0 --output-file=telemetry_log.bin
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
