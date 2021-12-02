# nvme\-list(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-huawei-list - List all recognized Huawei NVMe devices

<a name="synopsis"></a>

# Synopsis

```


```
    nvme huawei list [-o <fmt> | --output-format=<fmt>]

<a name="description"></a>

# Description


Scan the sysfs tree for NVM Express devices and return the /dev node for those Huawei devices as well as some pertinent information about them.

<a name="options"></a>

# Options


-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_
or
_json_. Only one output format can be used at a time.

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
