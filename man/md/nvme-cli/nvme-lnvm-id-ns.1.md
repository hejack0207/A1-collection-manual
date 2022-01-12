# nvme\-lnvm\-id\-ns(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-lnvm-id-ns - Identify Geometry for LightNVM NVMe device

<a name="synopsis"></a>

# Synopsis

```


```
    nvme lnvm-id-ns <device> [--namespace-id=<nsid> | -n <nsid>]
                            [--force | -f]
                            [--raw-binary | -b]
                            [--human-readable | -H]

<a name="description"></a>

# Description


Send an Identify Geometry command to the given LightNVM device, returns properties of the specified namespace in either human-readable or binary format.

<a name="options"></a>

# Options


--namespace-id=&lt;nsid&gt;, -n &lt;nsid&gt;
Retrieve the geometry from the selected namespace.

--force, -f
Try to read the data and assume it is a LightNVM device

--raw-binary, -b
Output the raw output

--human-readable, -H
Output the status in human readable format

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Retrieve the geometry from nvme0

.if n \{.RS 4
.\}
    # nvme lnvm-id-ns /dev/nvme0 -n 1
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
