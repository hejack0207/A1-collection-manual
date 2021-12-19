# nvme\-attach\-ns(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-attach-ns - Send NVMe attach namespace, return result.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme attach-ns <device> [--namespace-id=<nsid> | -n <nsid>]
                            [--controllers=<ctrl-list,> | -c <ctrl-list,>]

<a name="description"></a>

# Description


For the NVMe device given, sends the nvme namespace attach command for the provided namespace identifier, attaching to the provided list of controller identifiers.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
The namespace identifier to attach.

-c &lt;ctrl-list,&gt;, -controllers=&lt;ctrl-list,&gt;
The comma separated list of controller identifiers to attach the namesapce too.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    Attach namspace to the controller:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    # nvme attach-ns /dev/nvme1  -n 0x2 -c 0x21
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
