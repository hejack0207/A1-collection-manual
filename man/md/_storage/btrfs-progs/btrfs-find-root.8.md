# btrfs\-find\-root(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-find-root - filter to find btrfs root

<a name="synopsis"></a>

# Synopsis

```

 btrfs-find-root [options] <device>
```

<a name="description"></a>

# Description


**btrfs-find-root** is used to find the satisfied root, you can filter by root tree’s objectid, generation, level.

<a name="options"></a>

# Options


-a
Search through all metadata extents, even the root has been already found.

-g _&lt;generation&gt;_
Filter root tree by it’s original transaction id, tree root’s generation in default.

-o _&lt;objectid&gt;_
Filter root tree by it’s objectid,tree root’s objectid in default.

-l _&lt;level&gt;_
Filter root tree by B-+ tree’s level, level 0 in default.

<a name="exit-status"></a>

# Exit Status


**btrfs-find-root** will return 0 if no error happened. If any problems happened, 1 will be returned.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8)
