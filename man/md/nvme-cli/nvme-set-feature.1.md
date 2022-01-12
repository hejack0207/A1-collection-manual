# nvme\-set\-feature(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-set-feature - Sets an NVMe feature, returns applicable results

<a name="synopsis"></a>

# Synopsis

```


```
    nvme set-feature <device> [--namespace-id=<nsid> | -n <nsid>]
                              [--feature-id=<fid> | -f <fid>] [--value=<value> | -v <value>]
                              [--data-len=<data-len> | -l <data-len>]
                              [--data=<data-file> | -d <data-file>]
                              [--save| -s]

<a name="description"></a>

# Description


Submits an NVMe Set Feature admin command and returns the applicable results. This may be the feature’s value, or may also include a feature structure if the feature requires it (ex: LBA Range Type).

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the value sent to the device is displayed

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Sets the feature for the given nsid. This is optional and most features do not use this value.

-f &lt;fid&gt;, --feature-id=&lt;fid&gt;
The feature id to send with the command. Value provided should be in hex.

-l &lt;data-len&gt;, --data-len=&lt;data-len&gt;
The data length for the buffer submitted for this feature. Most known features do not use this value. The exceptions are LBA Range Type and host identifier.

-d &lt;data-file&gt;, --data=&lt;data-file&gt;
The data file for the buffer submitted for this feature. Most known features do not use this value. The exceptions is LBA Range Type and host identifier. This defaults to STDIN so files and echo can be piped.

-v &lt;value&gt;, --value=&lt;value&gt;
The value for command dword 11, the value you want to set the feature to.

-s, --save
Save the attribute so that it persists through all power states and resets.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Sets the Power State (PS) to 1 in feature id 2:

.if n \{.RS 4
.\}
    # nvme set-feature /dev/nvme0 -f 2 /dev/nvme0n1 -v 0x1
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Sets the host id to the ascii string.

.if n \{.RS 4
.\}
    # echo "abcdefgh" | nvme set-feature /dev/nvme0 -f 0x81 -l 8
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
