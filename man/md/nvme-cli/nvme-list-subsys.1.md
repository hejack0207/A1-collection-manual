# nvme\-list\-subsys(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-list-subsys - List all NVMe subsystems

<a name="synopsis"></a>

# Synopsis

```


```
    nvme list-subsys [-o <fmt> | --output-format=<fmt>] <device>

<a name="description"></a>

# Description


Scan the sysfs tree for NVM Express subsystems and return the controllers for those subsystems as well as some pertinent information about them. If a device is given, print out only the values for the controllers and subsystems leading to the device.

<a name="options"></a>

# Options


-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_
or
_json_. Only one output format can be used at a time.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    m[blue]root@hostm[]s-2u[1]ds+2# nvme list-subsys
    nvme-subsys0 - NQN=nvmf-test
    e
     +- nvme0 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1
     +- nvme1 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2
    nvme-subsys1 - NQN=nvmf-test2
    e
     +- nvme2 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2
     +- nvme3 rdma traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    m[blue]root@hostm[]s-2u[1]ds+2# nvme list-subsys -o json
    {
      "Subsystems" : [
        {
          "Name" : "nvme-subsys0",
          "NQN" : "nvmf-test"
        },
        {
          "Paths" : [
            {
              "Name" : "nvme0",
              "Transport" : "rdma",
              "Address" : "traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1"
            },
            {
              "Name" : "nvme1",
              "Transport" : "rdma",
              "Address" : "traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2"
            }
          ]
        },
        {
          "Name" : "nvme-subsys1",
          "NQN" : "nvmf-test2"
        },
        {
          "Paths" : [
            {
              "Name" : "nvme2",
              "Transport" : "rdma",
              "Address" : "traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.2"
            },
            {
              "Name" : "nvme3",
              "Transport" : "rdma",
              "Address" : "traddr=1.1.1.3 trsvcid=4420 host_traddr=1.1.1.1"
            }
          ]
        }
      ]
    }
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite

<a name="notes"></a>

# Notes


*  1.  
  root@host
      mailto:root@host
