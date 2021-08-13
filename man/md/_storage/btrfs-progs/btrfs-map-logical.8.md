# btrfs\-map\-logical(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-map-logical - map btrfs logical extent to physical extent

<a name="synopsis"></a>

# Synopsis

```

 btrfs-map-logical <options> <device>
```

<a name="description"></a>

# Description


**btrfs-map-logical** can be used to find out what the physical offsets are on the mirrors, the result is dumped to stdout by default.

Mainly used for debug purpose.

<a name="options"></a>

# Options


-l|--logical _&lt;logical\_num&gt;_
Logical extent to map.

-c|--copy _&lt;copy&gt;_
Copy of the extent to read(usually 1 or 2).

-o|--output _&lt;filename&gt;_
Output file to hold the extent.

-b|--bytes _&lt;bytes&gt;_
Number of bytes to read.

<a name="exit-status"></a>

# Exit Status


**btrfs-map-logical** will return 0 if no error happened. If any problems happened, 1 will be returned.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8)
