# rdma\-system(8) - RDMA subsystem configuration

iproute2, 06 Jul 2017

```

 .in +8 .ti -8 rdma [ OPTIONS ] sys  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] | -d[etails] }
</synopsis>

<synopsis>
.ti -8 rdma system show
</synopsis>

<synopsis>
.ti -8 rdma system set netns NEWMODE
</synopsis>

<synopsis>
.ti -8 rdma system help
```


<a name="description"></a>

# Description


<a name="rdma-system-set-set-rdma-subsystem-network-namespace-mode"></a>

### rdma system set - set RDMA subsystem network namespace mode



<a name="rdma-system-show-display-rdma-subsystem-network-namespace-mode"></a>

### rdma system show - display RDMA subsystem network namespace mode



_NEWMODE_
- specifies the RDMA subsystem mode. Either exclusive or shared.
When user wants to assign dedicated RDMA device to a particular
network namespace, exclusive mode should be set before creating
any network namespace. If there are active network namespaces and if
one or more RDMA devices exist, changing mode from shared to
exclusive returns error code EBUSY.

When RDMA subsystem is in shared mode, RDMA device is accessible in
all network namespace. When RDMA device isolation among multiple
network namespaces is not needed, shared mode can be used.

It is preferred to not change the subsystem mode when there is active
RDMA traffic running, even though it is supported.


<a name="examples"></a>

# Examples


rdma system show
Shows the state of RDMA subsystem network namespace mode on the system.

rdma system set netns exclusive
Sets the RDMA subsystem in network namespace exclusive mode. In this mode RDMA devices
are visible only in single network namespace.

rdma system set netns shared
Sets the RDMA subsystem in network namespace shared mode. In this mode RDMA devices
are shared among network namespaces.



<a name="see-also"></a>

# See Also

**rdma**(8),
**rdma-link**(8),
**rdma-resource**(8),
**network_namespaces**(7),
**namespaces**(7),  


<a name="author"></a>

# Author

Parav Pandit &lt;[parav@mellanox.com](mailto:parav@mellanox.com)&gt;
