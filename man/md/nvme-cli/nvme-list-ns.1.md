# nvme\-id\-ns(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-list-ns - Send NVMe Identify List Namespaces, return result and structure

<a name="synopsis"></a>

# Synopsis

```


```
    nvme list-ns <device> [--namespace-id=<nsid> | -n <nsid>]
                            [--all | -a]

<a name="description"></a>

# Description


For the NVMe device given, sends an identify command for namespace list and provides the result and returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1). If the starting namespace in the list always begins with 0 unless the --namespace-id\*(Aq option is given to override.

On success, the namespace array is printed for each index and nsid for a valid nsid.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Retrieve the identify list structure starting with the given nsid.

-a, --all
Retrieve the identify list structure for all namespaces in the subsystem, whether attached or inactive.

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
