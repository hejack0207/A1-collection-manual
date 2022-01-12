# nvme\-id\-ns(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-list-ctrl - Send NVMe Identify List Controllers, return result and structure

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    nvme list-ctrl <device> [--cntid=<cntid> | -c <cntid>]
                            [--namespace-id=<nsid> | -n <nsid>]
    DESCRIPTION
<synopsis>


</synopsis>
    For the NVMe device given, sends an identify command for controller list
    and provides the result and returned structure. This uses either mode
    12h or 13h depending on the requested namespace identifier.
    
    The <device> parameter is mandatory and may be either the NVMe character
    device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).
    The starting controller in the list always begins with 0 unless the
    `--cntid*(Aq` option is given to override.
    
    On success, the controller array is printed for each index and controller
    identifier.
    
    OPTIONS
<synopsis>

 -c <cntid>, --cntid=<cntid> .RS 4 Retrieve the identify list structure starting with the given controller id. .RE 
 -n <nsid>, --namespace-id=<nsid> .RS 4 If provided, will request the controllers attached to the specified namespace. If no namespace is given, or set to 0, the command requests the controller list for the entire subsystem, whether or not they are attached to namespace(s). .RE
```

<a name="examples"></a>

# Examples


No examples yet.

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
