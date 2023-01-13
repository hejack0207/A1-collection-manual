# rdma\-link(8) - rdma link configuration

iproute2, 06 Jul 2017

```

 .in +8 .ti -8 devlink [ OPTIONS ] link  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] | -d[etails] }
</synopsis>

<synopsis>
.ti -8 rdma link show [ DEV/PORT_INDEX ]
</synopsis>

<synopsis>
.ti -8 rdma link add NAME type TYPE netdev NETDEV
</synopsis>

<synopsis>
.ti -8 rdma link delete NAME
</synopsis>

<synopsis>
.ti -8 rdma link help
```


<a name="description"></a>

# Description


<a name="rdma-link-show-display-rdma-link-attributes"></a>

### rdma link show - display rdma link attributes



_DEV/PORT_INDEX_
- specifies the RDMA link to show.
If this argument is omitted all links are listed.


<a name="rdma-link-add-name-type-type-netdev-netdev-add-an-rdma-link-for-the-specified-type-to-the-network-device"></a>

### rdma link add NAME type TYPE netdev NETDEV - add an rdma link for the specified type to the network device


**NAME**
- specifies the new name of the rdma link to add

**TYPE**
- specifies which rdma type to use.  Link types:

.in +8
**rxe**
- Soft RoCE driver

**siw**
- Soft iWARP driver
.in -8

**NETDEV**
- specifies the network device to which the link is bound


<a name="rdma-link-delete-name-delete-an-rdma-link"></a>

### rdma link delete NAME - delete an rdma link


**NAME**
- specifies the name of the rdma link to delete



<a name="examples"></a>

# Examples


rdma link show
Shows the state of all rdma links on the system.

rdma link show mlx5_2/1
Shows the state of specified rdma link.

rdma link add rxe_eth0 type rxe netdev eth0
Adds a RXE link named rxe_eth0 to network device eth0

rdma link del rxe_eth0
Removes RXE link rxe_eth0



<a name="see-also"></a>

# See Also

**rdma**(8),
**rdma-dev**(8),
**rdma-resource**(8),
**rdma-statistic**(8),  


<a name="author"></a>

# Author

Leon Romanovsky &lt;[leonro@mellanox.com](mailto:leonro@mellanox.com)&gt;
