# rdma\-resource(8) - rdma resource configuration

iproute2, 26 Dec 2017

```

 .in +8 .ti -8 rdma [ OPTIONS ] RESOURCE { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 RESOURCE := {  cm_id | cq | mr | pd | qp } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -j[son] | -d[etails] }
</synopsis>

<synopsis>
.ti -8 rdma resource show [ DEV/PORT_INDEX ]
</synopsis>

<synopsis>
.ti -8 rdma resource help
```


<a name="description"></a>

# Description


<a name="rdma-resource-show-display-rdma-resource-tracking-information"></a>

### rdma resource show - display rdma resource tracking information



_DEV/PORT_INDEX_
- specifies the RDMA link to show.
If this argument is omitted all links are listed.


<a name="examples"></a>

# Examples


rdma resource show
Shows summary for all devices on the system.

rdma resource show mlx5_2
Shows the state of specified rdma device.

rdma res show qp link mlx5_4
Get all QPs for the specific device.

rdma res show qp link mlx5_4/1
Get QPs of specific port.

rdma res show qp link mlx5_4/0
Provide illegal port number (0 is illegal).

rdma res show qp link mlx5_4/-
Get QPs which have not assigned port yet.

rdma res show qp link mlx5_4/- -d
Detailed view.

rdma res show qp link mlx5_4/- -dd
Detailed view including driver-specific details.

rdma res show qp link mlx5_4/1 lqpn 0-6
Limit to specific Local QPNs.

rdma resource show cm_id dst-port 7174
Show CM_IDs with destination ip port of 7174.

rdma resource show cm_id src-addr 172.16.0.100
Show CM_IDs bound to local ip address 172.16.0.100

rdma resource show cq pid 30489
Show CQs belonging to pid 30489



<a name="see-also"></a>

# See Also

**rdma**(8),
**rdma-dev**(8),
**rdma-link**(8),
**rdma-statistic**(8),  


<a name="author"></a>

# Author

Leon Romanovsky &lt;[leonro@mellanox.com](mailto:leonro@mellanox.com)&gt;
