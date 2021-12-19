# nvme\-list(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-list - List all recognized NVMe devices

<a name="synopsis"></a>

# Synopsis

```


```
    nvme list [-o <fmt> | --output-format=<fmt>]

<a name="description"></a>

# Description


Scan the sysfs tree for NVM Express devices and return the /dev node for those devices as well as some pertinent information about them.

<a name="options"></a>

# Options


-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_
or
_json_. Only one output format can be used at a time.

-v, --verbose
Increase the information in the output, showing nvme subsystems, controllers and namespaces separately and how they’re realted to each other.

<a name="environment"></a>

# Environment


PCI_IDS_PATH - Full path of pci.ids file in case nvme could not find it in common locations.

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
