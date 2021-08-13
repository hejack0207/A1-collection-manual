# e2label(8) - Change the label on an ext2/ext3/ext4 filesystem

E2fsprogs version 1.45.6, March 2020

```
e2label device [ volume-label ]
```

<a name="description"></a>

# Description

**e2label**
will display or change the volume label on the ext2, ext3, or ext4
filesystem located on
_device._

If the optional argument
_volume-label_
is not present,
**e2label**
will simply display the current volume label.

If the optional argument
_volume-label_
is present, then
**e2label**
will set the volume label to be
_volume-label_.
Ext2 volume labels can be at most 16 characters long; if
_volume-label_
is longer than 16 characters,
**e2label**
will truncate it and print a warning message.

It is also possible to set the volume label using the
**-L**
option of
**tune2fs**(8).


<a name="author"></a>

# Author

**e2label**
was written by Theodore Ts'o ([tytso@mit.edu](mailto:tytso@mit.edu)).

<a name="availability"></a>

# Availability

**e2label**
is part of the e2fsprogs package and is available from
http://e2fsprogs.sourceforge.net.

<a name="see-also"></a>

# See Also

**mke2fs**(8),
**tune2fs**(8)

