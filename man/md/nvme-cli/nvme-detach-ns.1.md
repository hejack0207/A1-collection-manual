# nvme\-detach\-ns(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-detach-ns - Send NVMe detach namespace, return result.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme detach-ns <device> [--namespace-id=<nsid> | -n <nsid>]
                            [--controllers=<ctrl-list,> | -c <ctrl-list,>

<a name="description"></a>

# Description


For the NVMe device given, sends the nvme namespace detach command for the provided namespace identifier, attaching to the provided list of controller identifiers.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
The namespace identifier to detach.

-c &lt;ctrl-list,&gt;, -controllers=&lt;ctrl-list,&gt;
The comma separated list of controller identifiers to detach the namespace from.

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
