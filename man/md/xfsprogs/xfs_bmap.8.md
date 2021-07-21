# xfs_bmap(8) - print block mapping for an XFS file

```
xfs_bmap [ -adelpv ] [ -n num_extents ] file
xfs_bmap -V
```

<a name="description"></a>

# Description

**xfs_bmap**
prints the map of disk blocks used by files in an XFS filesystem.
The map lists each
_extent_
used by the file, as well as regions
in the file that do not have any corresponding blocks (holes).
Each line of the listings takes the following form:

_extent_: [_startoffset_.._endoffset_]: _startblock_.._endblock_

Holes are marked by replacing the
_startblock_.._endblock_ with _hole_.
All the file offsets and disk blocks are in units of 512-byte blocks,
no matter what the filesystem's block size is.


<a name="options"></a>

# Options


* **-a**  
  If this option is specified, information about the file's
  attribute fork is printed instead of the default data fork.
* **-d**  
  If portions of the file have been migrated offline by
  a DMAPI application, a DMAPI read event will be generated to
  bring those portions back online before the disk block map is
  printed.  However if the
  **-d**
  option is used, no DMAPI read event will be generated for a
  DMAPI file and offline portions will be reported as holes.
* **-e**  
  If this option is used,
  **xfs_bmap**
  obtains all delayed allocation extents, and does not flush dirty pages
  to disk before querying extent data. With the
  **-v**
  option, the
  _flags_
  column will show which extents have not yet been allocated.
* **-l**  
  If this option is used, then
* &lt;_nblocks_&gt;  blocks
* will be appended to each line.
  _nblocks_
  is the length of the extent described on the line in units of 512-byte blocks.
* This flag has no effect if the
  **-v**
  option is used.
* **-n**_ num_extents_  
  If this option is given,
  **xfs_bmap**
  will display at most
  _num_extents_
  extents. In the absence of
  **-n**, **xfs_bmap**
  will display all extents in the file.
* **-p**  
  If this option is used,
  **xfs_bmap**
  obtains all unwritten (preallocated) extents that do not contain written
  data. With the
  **-v**
  option, the
  _flags_
  column will show which extents are preallocated/unwritten.
* **-v**  
  Shows verbose information. When this flag is specified, additional AG
  specific information is appended to each line in the following form:
* _agno_ (_startagoffset_.._endagoffset_) _nblocks_ _flags_
* A second
  **-v**
  option will print out the
  _flags_
  legend.
* **-V**  
  Prints the version number and exits.

<a name="see-also"></a>

# See Also

**xfs_fsr**(8),
**xfs**(5).
