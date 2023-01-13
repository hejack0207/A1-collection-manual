# devlink\-dpipe(8) - devlink dataplane pipeline visualization

iproute2, 4 Apr 2020

```

 .in +8 .ti -8 devlink [ OPTIONS ] dpipe { table | header } { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] }
</synopsis>

<synopsis>
.ti -8 devlink dpipe table show DEV [ name TABLE_NAME ]
</synopsis>

<synopsis>
.ti -8 devlink dpipe table set DEV name TABLE_NAME 
</synopsis>

<synopsis>
.ti -8 devlink dpipe table dump DEV name TABLE_NAME 
</synopsis>

<synopsis>
.ti -8 devlink dpipe header show DEV
</synopsis>

<synopsis>
.ti -8 devlink dpipe help
```


<a name="description"></a>

# Description


<a name="devlink-dpipe-table-show-display-devlink-dpipe-table-attributes"></a>

### devlink dpipe table show - display devlink dpipe table attributes



* **name**_ TABLE_NAME_  
  Specifies the table to operate on.
  

<a name="devlink-dpipe-table-set-set-devlink-dpipe-table-attributes"></a>

### devlink dpipe table set - set devlink dpipe table attributes



* **name**_ TABLE_NAME_  
  Specifies the table to operate on.
  

<a name="devlink-dpipe-table-dump-dump-devlink-dpipe-table-entries"></a>

### devlink dpipe table dump - dump devlink dpipe table entries



* **name**_ TABLE_NAME_  
  Specifies the table to operate on.
  

<a name="devlink-dpipe-header-show-display-devlink-dpipe-header-attributes"></a>

### devlink dpipe header show - display devlink dpipe header attributes



* **name**_ TABLE_NAME_  
  Specifies the table to operate on.
  

<a name="examples"></a>

# Examples


devlink dpipe table show pci/0000:01:00.0
Shows all dpipe tables on specified devlink device.

devlink dpipe table show pci/0000:01:00.0 name mlxsw_erif
Shows mlxsw_erif dpipe table on specified devlink device.

devlink dpipe table set pci/0000:01:00.0 name mlxsw_erif counters_enabled true
Turns on the counters on mlxsw_erif table.

devlink dpipe table dump pci/0000:01:00.0 name mlxsw_erif
Dumps content of mlxsw_erif table.

devlink dpipe header show pci/0000:01:00.0
Shows all dpipe headers on specified devlink device.


<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-dev**(8),
**devlink-monitor**(8),  


<a name="author"></a>

# Author

Jiri Pirko &lt;[jiri@mellanox.com](mailto:jiri@mellanox.com)&gt;
