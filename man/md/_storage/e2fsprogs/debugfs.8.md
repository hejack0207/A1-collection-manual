# debugfs(8) - ext2/ext3/ext4 file system debugger

E2fsprogs version 1.45.6, March 2020

```
debugfs [ -DVwcin ] [ -b blocksize ] [ -s superblock ] [ -f cmd_file ] [ -R request ] [ -d data_source_device ] [ -z undo_file ] [ device ]
```

<a name="description"></a>

# Description

The
**debugfs**
program is an interactive file system debugger. It can be used to
examine and change the state of an ext2, ext3, or ext4 file system.

_device_
is a block device (e.g., /dev/sdXX) or a file containing the file system.

<a name="options"></a>

# Options


* _-w_  
  Specifies that the file system should be opened in read-write mode.
  Without this option, the file system is opened in read-only mode.
* _-n_  
  Disables metadata checksum verification.  This should only be used if
  you believe the metadata to be correct despite the complaints of
  e2fsprogs.
* _-c_  
  Specifies that the file system should be opened in catastrophic mode, in
  which the inode and group bitmaps are not read initially.  This can be
  useful for filesystems with significant corruption, but because of this,
  catastrophic mode forces the filesystem to be opened read-only.
* _-i_  
  Specifies that
  _device_
  represents an ext2 image file created by the
  **e2image**
  program.  Since the ext2 image file only contains the superblock, block
  group descriptor, block and inode allocation bitmaps, and
  the inode table, many
  **debugfs**
  commands will not function properly.
  **Warning:**
  no safety checks are in place, and
  **debugfs**
  may fail in interesting ways if commands such as
  _ls_, _dump_, 
  etc. are tried without specifying the
  _data_source_device_
  using the
  _-d_
  option.
  **debugfs**
  is a debugging tool.  It has rough edges!
* _-d data_source_device_  
  Used with the
  _-i_
  option, specifies that
  _data_source_device_
  should be used when reading blocks not found in the ext2 image file.
  This includes data, directory, and indirect blocks.
* _-b blocksize_  
  Forces the use of the given block size (in bytes) for the file system,
  rather than detecting the correct block size automatically.  (This
  option is rarely needed; it is used primarily when the file system is
  extremely badly damaged/corrupted.)
* _-s superblock_  
  Causes the file system superblock to be read from the given block
  number, instead of using the primary superblock (located at an offset of
  1024 bytes from the beginning of the filesystem).  If you specify the
  _-s_
  option, you must also provide the blocksize of the filesystem via the
  _-b_
  option.   (This
  option is rarely needed; it is used primarily when the file system is
  extremely badly damaged/corrupted.)
* _-f cmd_file_  
  Causes
  **debugfs**
  to read in commands from
  _cmd_file_,
  and execute them.  When
  **debugfs**
  is finished executing those commands, it will exit.
* _-D_  
  Causes
  **debugfs**
  to open the device using Direct I/O, bypassing the buffer cache.  Note
  that some Linux devices, notably device mapper as of this writing, do
  not support Direct I/O.
* _-R request_  
  Causes
  **debugfs**
  to execute the single command
  _request_,
  and then exit.
* _-V_  
  print the version number of
  **debugfs**
  and exit.
* **-z**_ undo_file_  
  Before overwriting a file system block, write the old contents of the block to
  an undo file.  This undo file can be used with e2undo(8) to restore the old
  contents of the file system should something go wrong.  If the empty string is
  passed as the undo_file argument, the undo file will be written to a file named
  debugfs-_device_.e2undo in the directory specified via the
  _E2FSPROGS\_UNDO\_DIR_ environment variable.
  
  WARNING: The undo file cannot be used to recover from a power or system crash.

<a name="specifying-files"></a>

# Specifying Files

Many
**debugfs**
commands take a
_filespec_
as an argument to specify an inode (as opposed to a pathname)
in the filesystem which is currently opened by
**debugfs**.
The
_filespec_
argument may be specified in two forms.  The first form is an inode
number surrounded by angle brackets, e.g.,
_&lt;2&gt;_.
The second form is a pathname; if the pathname is prefixed by a forward slash
('/'), then it is interpreted relative to the root of the filesystem
which is currently opened by
**debugfs**.
If not, the pathname is
interpreted relative to the current working directory as maintained by
**debugfs**.
This may be modified by using the
**debugfs**
command
_cd_.




<a name="commands"></a>

# Commands

This is a list of the commands which
**debugfs**
supports.

* **blocks**_ filespec_  
  Print the blocks used by the inode
  _filespec_
  to stdout.
* **bmap**_ [ -a ] filespec logical_block [physical_block]_  
  Print or set the physical block number corresponding to the logical block number
  _logical_block_
  in the inode
  _filespec_.
  If the
  _-a_
  flag is specified, try to allocate a block if necessary.
* **block_dump**_ '[ -x ] [-f filespec] block_num_  
  Dump the filesystem block given by
  _block_num_
  in hex and ASCII format to the console.  If the
  _-f_
  option is specified, the block number is relative to the start of the given
  **filespec**.
  If the
  _-x_
  option is specified, the block is interpreted as an extended attribute
  block and printed to show the structure of extended attribute data
  structures.
* **cat**_ filespec_  
  Dump the contents of the inode
  _filespec_
  to stdout.
* **cd**_ filespec_  
  Change the current working directory to
  _filespec_.
* **chroot**_ filespec_  
  Change the root directory to be the directory
  _filespec_.
* **close**_ [-a]_  
  Close the currently open file system.  If the
  _-a_
  option is specified, write out any changes to the superblock and block
  group descriptors to all of the backup superblocks, not just to the
  master superblock.
* **clri**_ filespec_  
  Clear the contents of the inode
  _filespec_.
* **copy_inode**_ source_inode destination_inode_  
  Copy the contents of the inode structure in
  _source_inode_
  and use it to overwrite the inode structure at
  _destination_inode_.
* **dirsearch**_ filespec filename_  
  Search the directory
  _filespec_
  for
  _filename_.
* **dirty**_ [-clean]_  
  Mark the filesystem as dirty, so that the superblocks will be written on exit.
  Additionally, clear the superblock's valid flag, or set it if
  _-clean_
  is specified.
* **dump**_ [-p] filespec out_file_  
  Dump the contents of the inode
  _filespec_
  to the output file
  _out_file_.
  If the
  _-p_
  option is given set the owner, group and permissions information on
  _out_file_
  to match
  _filespec_.
* **dump_mmp**_ [mmp_block]_  
  Display the multiple-mount protection (mmp) field values.  If
  _mmp_block_
  is specified then verify and dump the MMP values from the given block
  number, otherwise use the
  **s_mmp_block**
  field in the superblock to locate and use the existing MMP block.
* **dx_hash**_ [-h hash_alg] [-s hash_seed] filename_  
  Calculate the directory hash of
  _filename_.
  The hash algorithm specified with
  _-h_
  may be
  **legacy**,** half_md4**, or **tea**.
  The hash seed specified with
  _-s_
  must be in UUID format.
* **dump_extents**_ [-n] [-l] filespec_  
  Dump the the extent tree of the inode
  _filespec_.
  The
  _-n_
  flag will cause
  **dump_extents**
  to only display the interior nodes in the extent tree.   The
  _-l_
  flag will cause
  **dump_extents**
  to only display the leaf nodes in the extent tree.
* (Please note that the length and range of blocks for the last extent in
  an interior node is an estimate by the extents library functions, and is
  not stored in filesystem data structures.   Hence, the values displayed
  may not necessarily by accurate and does not indicate a problem or
  corruption in the file system.)
* **dump_unused**  
  Dump unused blocks which contain non-null bytes.
* **ea_get**_ [-f outfile]|[-xVC] [-r] filespec attr_name_  
  Retrieve the value of the extended attribute
  _attr_name_
  in the file
  _filespec_
  and write it either to stdout or to _outfile_.
* **ea_list**_filespec_  
  List the extended attributes associated with the file
  _filespec_
  to standard output.
* **ea_set**_[-f_**infile]**_[-r]_**filespec**_attr_name_**attr_value**  
  Set the value of the extended attribute
  _attr_name_
  in the file
  _filespec_
  to the string value
  _attr_value_
  or read it from _infile_.
* **ea_rm**_filespec_**attr_names...**  
  Remove the extended attribute
  _attr_name_
  from the file _filespec_.
* **expand_dir**_ filespec_  
  Expand the directory
  _filespec_.
* **fallocate**_filespec_**start_block**_[end_block]_  
  Allocate and map uninitialized blocks into _filespec_ between
  logical block _start\_block_ and _end\_block_, inclusive.  If
  _end\_block_ is not supplied, this function maps until it runs out
  of free disk blocks or the maximum file size is reached.  Existing
  mappings are left alone.
* **feature**_ [fs_feature] [-fs_feature] ..._  
  Set or clear various filesystem features in the superblock.  After setting
  or clearing any filesystem features that were requested, print the current
  state of the filesystem feature set.
* **filefrag**_ [-dvr] filespec_  
  Print the number of contiguous extents in
  _filespec_.
  If
  _filespec_
  is a directory and the
  _-d_
  option is not specified,
  _filefrag_
  will print the number of contiguous extents for each file in
  the directory.  The
  _-v_
  option will cause
  _filefrag_
  print a tabular listing of the contiguous extents in the
  file.  The
  _-r_
  option will cause
  _filefrag_
  to do a recursive listing of the directory.
* **find_free_block**_ [count [goal]]_  
  Find the first
  _count_
  free blocks, starting from
  _goal_
  and allocate it.  Also available as
  **ffb**.
* **find_free_inode**_ [dir [mode]]_  
  Find a free inode and allocate it.  If present,
  _dir_
  specifies the inode number of the directory
  which the inode is to be located.  The second
  optional argument
  _mode_
  specifies the permissions of the new inode.  (If the directory bit is set
  on the mode, the allocation routine will function differently.)  Also
  available as
  **ffi**.
* **freeb**_ block [count]_  
  Mark the block number
  _block_
  as not allocated.
  If the optional argument
  _count_
  is present, then
  _count_
  blocks starting at block number
  _block_
  will be marked as not allocated.
* **freefrag**_ [-c chunk_kb]_  
  Report free space fragmentation on the currently open file system.
  If the
  _-c_
  option is specified then the filefrag command will print how many free
  chunks of size
  _chunk_kb_
  can be found in the file system.  The chunk size must be a power of two
  and be larger than the file system block size.
* **freei**_ filespec [num]_  
  Free the inode specified by
  _filespec_.
  If
  _num_
  is specified, also clear num-1 inodes after the specified inode.
* **get_quota**_ quota_type id_  
  Display quota information for given quota type (user, group, or project) and ID.
* **help**  
  Print a list of commands understood by
  **debugfs**.
* **htree_dump**_ filespec_  
  Dump the hash-indexed directory
  _filespec_,
  showing its tree structure.
* **icheck**_ block ..._  
  Print a listing of the inodes which use the one or more blocks specified
  on the command line.
* **inode_dump**_ [-b]|[-e]|[-x] filespec_  
  Print the contents of the inode data structure in hex and ASCII format.
  The
  _-b_
  option causes the command to only dump the contents of the
  **i_blocks**
  array.  The
  _-e_
  option causes the command to only dump the contents of the extra inode
  space, which is used to store in-line extended attributes. The
  _-x_
  option causes the command to dump the extra inode space interpreted and
  extended attributes.  This is useful to debug corrupted inodes
  containing extended attributes.
* **imap**_ filespec_  
  Print the location of the inode data structure (in the inode table)
  of the inode
  _filespec_.
* **init_filesys**_ device blocksize_  
  Create an ext2 file system on
  _device_
  with device size
  _blocksize_.
  Note that this does not fully initialize all of the data structures;
  to do this, use the
  **mke2fs**(8)
  program.  This is just a call to the low-level library, which sets up
  the superblock and block descriptors.
* **journal_close**  
  Close the open journal.
* **journal_open**_[-c]_**[-v**_ver]_**[-f**_ext_jnl]_  
  Opens the journal for reading and writing.  Journal checksumming can
  be enabled by supplying _-c_; checksum formats 2 and 3 can be
  selected with the _-v_ option.  An external journal can be loaded
  from _ext\_jnl_.
* **journal_run**  
  Replay all transactions in the open journal.
* **journal_write**_[-b_**blocks]**_[-r_**revoke]**_[-c]_**file**  
  Write a transaction to the open journal.  The list of blocks to write
  should be supplied as a comma-separated list in _blocks_; the
  blocks themselves should be readable from _file_.  A list of
  blocks to revoke can be supplied as a comma-separated list in
  _revoke_.  By default, a commit record is written at the end; the
  _-c_ switch writes an uncommitted transaction.
* **kill_file**_ filespec_  
  Deallocate the inode
  _filespec_
  and its blocks.  Note that this does not remove any directory
  entries (if any) to this inode.  See the
  **rm**(1)
  command if you wish to unlink a file.
* **lcd**_ directory_  
  Change the current working directory of the
  **debugfs**
  process to
  _directory_
  on the native filesystem.
* **list_quota**_ quota_type_  
  Display quota information for given quota type (user, group, or project).
* **ln**_ filespec dest_file_  
  Create a link named
  _dest_file_
  which is a hard link to
  _filespec_.
  Note this does not adjust the inode reference counts.
* **logdump**_ [-acsOS] [-b block] [-i filespec] [-f journal_file] [output_file]_  
  Dump the contents of the ext3 journal.  By default, dump the journal inode as
  specified in the superblock.  However, this can be overridden with the
  _-i_
  option, which dumps the journal from the internal inode given by
  _filespec_.
  A regular file containing journal data can be specified using the
  _-f_
  option.  Finally, the
  _-s_
  option utilizes the backup information in the superblock to locate the
  journal.
* The
  _-S_
  option causes
  **logdump**
  to print the contents of the journal superblock.
* The
  _-a_
  option causes the
  **logdump**
  program to print the contents of all of the descriptor blocks.
  The
  _-b_
  option causes
  **logdump**
  to print all journal records that refer to the specified block.
  The
  _-c_
  option will print out the contents of all of the data blocks selected by
  the
  _-a_
  and
  _-b_
  options.
* The
  _-O_
  option causes logdump to display old (checkpointed) journal entries.
  This can be used to try to track down journal problems even after the
  journal has been replayed.
* **ls**_ [-l] [-c] [-d] [-p] [-r] filespec_  
  Print a listing of the files in the directory
  _filespec_.
  The
  _-c_
  flag causes directory block checksums (if present) to be displayed.
  The
  _-d_
  flag will list deleted entries in the directory.
  The
  _-l_
  flag will list files using a more verbose format.
  The
  _-p_
  flag will list the files in a format which is more easily parsable by
  scripts, as well as making it more clear when there are spaces or other
  non-printing characters at the end of filenames.
  The
  _-r_
  flag will force the printing of the filename, even if it is encrypted.
* **list_deleted_inodes**_ [limit]_  
  List deleted inodes, optionally limited to those deleted within
  _limit_
  seconds ago.  Also available as
  **lsdel**.
* This command was useful for recovering from accidental file deletions
  for ext2 file systems.  Unfortunately, it is not useful for this purpose
  if the files were deleted using ext3 or ext4, since the inode's
  data blocks are no longer available after the inode is released.
* **modify_inode**_ filespec_  
  Modify the contents of the inode structure in the inode
  _filespec_.
  Also available as
  **mi**.
* **mkdir**_ filespec_  
  Make a directory.
* **mknod**_ filespec [p|[[c|b] major minor]]_  
  Create a special device file (a named pipe, character or block device).
  If a character or block device is to be made, the
  _major_
  and
  _minor_
  device numbers must be specified.
* **ncheck**_ [-c] inode_num ..._  
  Take the requested list of inode numbers, and print a listing of pathnames
  to those inodes.  The
  _-c_
  flag will enable checking the file type information in the directory
  entry to make sure it matches the inode's type.
* **open**_ [-weficD] [-b blocksize] [-d image_filename] [-s superblock] [-z undo_file] device_  
  Open a filesystem for editing.  The
  _-f_
  flag forces the filesystem to be opened even if there are some unknown
  or incompatible filesystem features which would normally
  prevent the filesystem from being opened.  The
  _-e_
  flag causes the filesystem to be opened in exclusive mode.  The
  _-b_, _-c_, _-d_, _-i_, _-s_, _-w_, and _-D_
  options behave the same as the command-line options to
  **debugfs**.
* **punch**_ filespec start_blk [end_blk]_  
  Delete the blocks in the inode ranging from
  _start_blk_
  to
  _end_blk_.
  If
  _end_blk_
  is omitted then this command will function as a truncate command; that
  is, all of the blocks starting at
  _start_blk_
  through to the end of the file will be deallocated.
* **symlink**_ filespec target_  
  Make a symbolic link.
* **pwd**  
  Print the current working directory.
* **quit**  
  Quit
  **debugfs**
* **rdump**_ directory[...] destination_  
  Recursively dump
  _directory_,
  or multiple
  _directories_,
  and all its contents (including regular files, symbolic links, and other
  directories) into the named
  _destination_,
  which should be an existing directory on the native filesystem.
* **rm**_ pathname_  
  Unlink
  _pathname_.
  If this causes the inode pointed to by
  _pathname_
  to have no other references, deallocate the file.  This command functions
  as the unlink() system call.
  .I
* **rmdir**_ filespec_  
  Remove the directory
  _filespec_.
* **setb**_ block [count]_  
  Mark the block number
  _block_
  as allocated.
  If the optional argument
  _count_
  is present, then
  _count_
  blocks starting at block number
  _block_
  will be marked as allocated.
* **set_block_group**_ bgnum field value_  
  Modify the block group descriptor specified by
  _bgnum_
  so that the block group descriptor field
  _field_
  has value
  _value_.
  Also available as
  **set_bg**.
* **set_current_time**_ time_  
  Set current time in seconds since Unix epoch to use when setting filesystem
  fields.
* **seti**_ filespec [num]_  
  Mark inode
  _filespec_
  as in use in the inode bitmap.  If
  _num_
  is specified, also set num-1 inodes after the specified inode.
* **set_inode_field**_ filespec field value_  
  Modify the inode specified by
  _filespec_
  so that the inode field
  _field_
  has value
  _value._
  The list of valid inode fields which can be set via this command
  can be displayed by using the command:
  **set_inode_field -l**
  Also available as
  **sif**.
* **set_mmp_value**_ field value_  
  Modify the multiple-mount protection (MMP) data so that the MMP field
  _field_
  has value
  _value._
  The list of valid MMP fields which can be set via this command
  can be displayed by using the command:
  **set_mmp_value -l**
  Also available as
  **smmp**.
* **set_super_value**_ field value_  
  Set the superblock field
  _field_
  to
  _value._
  The list of valid superblock fields which can be set via this command
  can be displayed by using the command:
  **set_super_value -l**
  Also available as
  **ssv**.
* **show_debugfs_params**  
  Display
  **debugfs**
  parameters such as information about currently opened filesystem.
* **show_super_stats**_ [-h]_  
  List the contents of the super block and the block group descriptors.  If the
  _-h_
  flag is given, only print out the superblock contents. Also available as
  **stats**.
* **stat**_ filespec_  
  Display the contents of the inode structure of the inode
  _filespec_.
* **supported_features**  
  Display filesystem features supported by this version of
  **debugfs**.
* **testb**_ block [count]_  
  Test if the block number
  _block_
  is marked as allocated in the block bitmap.
  If the optional argument
  _count_
  is present, then
  _count_
  blocks starting at block number
  _block_
  will be tested.
* **testi**_ filespec_  
  Test if the inode
  _filespec_
  is marked as allocated in the inode bitmap.
* **undel**_ &lt;inode_number&gt; [pathname]_  
  Undelete the specified inode number (which must be surrounded by angle
  brackets) so that it and its blocks are marked in use, and optionally
  link the recovered inode to the specified pathname.  The
  **e2fsck**
  command should always be run after using the
  **undel**
  command to recover deleted files.
* Note that if you are recovering a large number of deleted files, linking
  the inode to a directory may require the directory to be expanded, which
  could allocate a block that had been used by one of the
  yet-to-be-undeleted files.  So it is safer to undelete all of the
  inodes without specifying a destination pathname, and then in a separate
  pass, use the debugfs
  **link**
  command to link the inode to the destination pathname, or use
  **e2fsck**
  to check the filesystem and link all of the recovered inodes to the
  lost+found directory.
* **unlink**_ pathname_  
  Remove the link specified by
  _pathname_
  to an inode.  Note this does not adjust the inode reference counts.
* **write**_ source_file out_file_  
  Copy the contents of
  _source_file_
  into a newly-created file in the filesystem named
  _out_file_.
* **zap_block**_ [-f filespec] [-o offset] [-l length] [-p pattern] block_num_  
  Overwrite the block specified by
  _block_num_
  with zero (NUL) bytes, or if
  _-p_
  is given use the byte specified by
  _pattern_.
  If
  _-f_
  is given then
  _block_num_
  is relative to the start of the file given by
  _filespec_.
  The
  _-o_
  and
  _-l_
  options limit the range of bytes to zap to the specified
  _offset_
  and
  _length_
  relative to the start of the block.
* **zap_block**_ [-f filespec] [-b bit] block_num_  
  Bit-flip portions of the physical
  _block_num_.
  If
  _-f_
  is given, then
  _block_num_
  is a logical block relative to the start of
  _filespec_.

<a name="environment-variables"></a>

# Environment Variables


* **DEBUGFS_PAGER, PAGER**  
  The
  **debugfs**
  program always pipes the output of the some commands through a
  pager program.  These commands include:
  _show_super_stats_ (_stats_),
  _list_directory_ (_ls_),
  _show_inode_info_ (_stat_),
  _list_deleted_inodes_ (_lsdel_),
  and
  _htree_dump_.
  The specific pager can explicitly specified by the
  **DEBUGFS_PAGER**
  environment variable, and if it is not set, by the
  **PAGER**
  environment variable.
* Note that since a pager is always used, the
  **less**(1)
  pager is not particularly appropriate, since it clears the screen before
  displaying the output of the command and clears the output the screen
  when the pager is exited.  Many users prefer to use the
  **less**(1)
  pager for most purposes, which is why the
  **DEBUGFS_PAGER**
  environment variable is available to override the more general
  **PAGER**
  environment variable.

<a name="author"></a>

# Author

**debugfs**
was written by Theodore Ts'o &lt;[tytso@mit.edu](mailto:tytso@mit.edu)&gt;.

<a name="see-also"></a>

# See Also

**dumpe2fs**(8),
**tune2fs**(8),
**e2fsck**(8),
**mke2fs**(8),
**ext4**(5)
