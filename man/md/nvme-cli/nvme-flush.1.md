# nvme\-flush(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-flush - Flush command.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme flush <device> [--namespace-id=<nsid> | -n <nsid>]

<a name="description"></a>

# Description


The Flush command shall commit data and metadata associated with the specified namespace(s) to nonvolatile media. The flush applies to all commands completed prior to the submission of the Flush command. The controller may also flush additional data and/or metadata from any namespace.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Specify the optional namespace id for this command. Defaults to 0xffffffff, indicating flush for all namespaces.

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
