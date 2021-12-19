# nvme\-id\-ns(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-delete-ns - Send NVMe Namespace Management delete namespace command, return result.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme delete-ns <device> [--namespace-id=<nsid> | -n <nsid>]

<a name="description"></a>

# Description


For the NVMe device given, sends an nvme namespace management command to delete the requested namespace and provides the result.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1). The --namespace-id\*(Aq option is mandatory.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
The namespace identifier to delete.

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
