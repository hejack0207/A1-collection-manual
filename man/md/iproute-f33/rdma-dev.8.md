# rdma\-dev(8) - RDMA device configuration

iproute2, 06 Jul 2017

```

 .in +8 .ti -8 rdma [ OPTIONS ] dev  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] | -d[etails] }
</synopsis>

<synopsis>
.ti -8 rdma dev show [ DEV ]
</synopsis>

<synopsis>
.ti -8 rdma dev set [ DEV ] name NEWNAME
</synopsis>

<synopsis>
.ti -8 rdma dev set [ DEV ] netns NSNAME
</synopsis>

<synopsis>
.ti -8 rdma dev set [ DEV ] adaptive-moderation [on/off]
</synopsis>

<synopsis>
.ti -8 rdma dev help
```


<a name="description"></a>

# Description


<a name="rdma-dev-set-rename-rdma-device-or-set-network-namespace-or-set-rdma-device-adaptive-moderation"></a>

### rdma dev set - rename RDMA device or set network namespace or set RDMA device adaptive-moderation



<a name="rdma-dev-show-display-rdma-device-attributes"></a>

### rdma dev show - display RDMA device attributes



_DEV_
- specifies the RDMA device to show.
If this argument is omitted all devices are listed.


<a name="examples"></a>

# Examples


rdma dev
Shows the state of all RDMA devices on the system.

rdma dev show mlx5_3
Shows the state of specified RDMA device.

rdma dev set mlx5_3 name rdma_0
Renames the mlx5_3 device to rdma_0.

rdma dev set mlx5_3 netns foo
Changes the network namespace of RDMA device to foo where foo is
previously created using iproute2 ip command.

rdma dev set mlx5_3 adaptive-moderation [on/off]
Sets the state of adaptive interrupt moderation for the RDMA device.
This is a global setting for the RDMA device but the value is printed for each CQ individually because the state is constant from CQ allocation.



<a name="see-also"></a>

# See Also

**ip**(8),
**rdma**(8),
**rdma-link**(8),
**rdma-resource**(8),
**rdma-system**(8),
**rdma-statistic**(8),  


<a name="author"></a>

# Author

Leon Romanovsky &lt;[leonro@mellanox.com](mailto:leonro@mellanox.com)&gt;
