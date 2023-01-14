# devlink\-region(8) - devlink address region access

iproute2, 10 Jan 2018

```

 .in +8 .ti -8 devlink [ OPTIONS ] region  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] | -n[no-nice-names] }
</synopsis>

<synopsis>
.ti -8 devlink region show [ DEV/REGION ]
</synopsis>

<synopsis>
.ti -8 devlink region del ""DEV/REGION"" snapshot ""SNAPSHOT_ID""
</synopsis>

<synopsis>
.ti -8 devlink region dump ""DEV/REGION"" snapshot ""SNAPSHOT_ID""
</synopsis>

<synopsis>
.ti -8 devlink region read ""DEV/REGION"" [  snapshot ""SNAPSHOT_ID"" ] address ""ADDRESS length ""LENGTH""
</synopsis>

<synopsis>
.ti -8 devlink region help
```


<a name="description"></a>

# Description


<a name="devlink-region-show-show-all-supported-address-regions-names-snapshots-and-sizes"></a>

### devlink region show - Show all supported address regions names, snapshots and sizes



_DEV/REGION_
- specifies the devlink device and address-region to query.


<a name="devlink-region-del-delete-a-snapshot-specified-by-address-region-name-and-snapshot-id"></a>

### devlink region del - Delete a snapshot specified by address-region name and snapshot ID



_DEV/REGION_
- specifies the devlink device and address-region to delete the snapshot from


snapshot
_SNAPSHOT_ID_
- specifies the snapshot ID to delete


<a name="devlink-region-dump-dump-all-the-available-data-from-a-region-or-from-snapshot-of-a-region"></a>

### devlink region dump - Dump all the available data from a region or from snapshot of a region



_DEV/REGION_
- specifies the device and address-region to dump from.


snapshot
_SNAPSHOT_ID_
- specifies the snapshot-id of the region to dump.


<a name="devlink-region-read-read-from-a-specific-region-address-for-a-given-length"></a>

### devlink region read - Read from a specific region address for a given length



_DEV/REGION_
- specifies the device and address-region to read from.


snapshot
_SNAPSHOT_ID_
- specifies the snapshot-id of the region to read.


address
_ADDRESS_
- specifies the address to read from.


length
_LENGTH_
- specifies the length of data to read.


<a name="examples"></a>

# Examples


devlink region show
List available address regions and snapshot.

devlink region del pci/0000:00:05.0/cr-space snapshot 1
Delete snapshot id 1 from cr-space address region from device pci/0000:00:05.0.

devlink region dump pci/0000:00:05.0/cr-space snapshot 1
Dump the snapshot taken from cr-space address region with ID 1

devlink region read pci/0000:00:05.0/cr-space snapshot 1 address 0x10 legth 16
Read from address 0x10, 16 Bytes of snapshot ID 1 taken from cr-space address region


<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-dev**(8),
**devlink-port**(8),
**devlink-monitor**(8),  


<a name="author"></a>

# Author

Alex Vesker &lt;[valex@mellanox.com](mailto:valex@mellanox.com)&gt;
