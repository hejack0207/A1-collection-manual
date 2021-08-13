# mke2fs.conf(5) - Configuration file for mke2fs

E2fsprogs version 1.45.6, March 2020


<a name="description"></a>

# Description

_mke2fs.conf_
is the configuration file for
**mke2fs**(8).
It controls the default parameters used by
**mke2fs**(8)
when it is creating ext2, ext3, or ext4 filesystems.

The
_mke2fs.conf_
file uses an INI-style format.  Stanzas, or top-level sections, are
delimited by square braces: [ ].  Within each section, each line
defines a relation, which assigns tags to values, or to a subsection,
which contains further relations or subsections.

An example of the INI-style format used by this configuration file
follows below:

	[section1]  
		tag1 = value_a  
		tag1 = value_b  
		tag2 = value_c

	[section 2]  
		tag3 = {  
			subtag1 = subtag_value_a  
			subtag1 = subtag_value_b  
			subtag2 = subtag_value_c  
		}  
		tag1 = value_d  
		tag2 = value_e  
	}

Comments are delimited by a semicolon (';') or a hash ('#') character
at the beginning of the comment, and are terminated by the end of
line character.

Tags and values must be quoted using double quotes if they contain
spaces.  Within a quoted string, the standard backslash interpretations
apply: "\en" (for the newline character),
"\et" (for the tab character), "\eb" (for the backspace character),
and "\e\e" (for the backslash character).

Some relations expect a boolean value.  The parser is quite liberal on
recognizing \`\`yes'', '\`y'', \`\`true'', \`\`t'', \`\`1'', \`\`on'', etc. as a
boolean true value, and \`\`no'', \`\`n'', \`\`false'', \`\`nil'', \`\`0'',
\`\`off'' as a boolean false value.

The following stanzas are used in the
_mke2fs.conf_
file.  They will be described in more detail in future sections of this
document.

* _[options]_  
  Contains relations which influence how mke2fs behaves.
* _[defaults]_  
  Contains relations which define the default parameters
  used by
  **mke2fs**(8).
  In general, these defaults may be overridden by a definition in the
  **fs_types**
  stanza, or by a command-line option provided by the user.
* _[fs_types]_  
  Contains relations which define defaults that should be used for specific
  file system and usage types.  The file system type and usage type can be
  specified explicitly using
  the
  **-t**and**-T**
  options to
  **mke2fs**(8),
  respectively.
* _[devices]_  
  Contains relations which define defaults for specific devices.

<a name="the-options-stanza"></a>

# The [Options] Stanza

The following relations are defined in the
_[options]_
stanza.

* _proceed_delay_  
  If this relation is set to a positive integer, then mke2fs will
  wait
  _proceed_delay_
  seconds after asking the user for permission to proceed and
  then continue, even if the
  user has not answered the question.  Defaults to 0, which means to wait
  until the user answers the question one way or another.
* _sync_kludge_  
  If this relation is set to a positive integer, then while writing the
  inode table, mke2fs will request the operating system flush out pending
  writes to initialize the inode table every
  _sync_kludge_
  block groups.   This is needed to work around buggy kernels that don't
  handle writeback throttling correctly.

<a name="the-defaults-stanza"></a>

# The [Defaults] Stanza

The following relations are defined in the
_[defaults]_
stanza.

* _fs_type_  
  This relation specifies the default filesystem type if the user does not
  specify it via the
  **-t**
  option, or if
  **mke2fs**
  is not started using a program name of the form
  **mkfs.**_fs-type._
  If both the user and the
  **mke2fs.conf**
  file do not specify a default filesystem type, mke2fs will use a
  default filesystem type of
  _ext3_
  if a journal was requested via a command-line option, or
  _ext2_
  if not.
* _undo_dir_  
  This relation specifies the directory where the undo file should be
  stored.  It can be overridden via the
  **E2FSPROGS_UNDO_DIR**
  environment variable.  If the directory location is set to the value
  _none_,
  **mke2fs**
  will not create an undo file.

In addition, any tags that can be specified in a per-file system tags
subsection as defined below (e.g.,
_blocksize_,
_hash_alg_,
_inode_ratio_,
_inode_size_,
_reserved_ratio_,
etc.) can also be specified in the
_defaults_
stanza to specify the default value to be used if the user does not
specify one on the command line, and the filesystem-type
specific section of the configuration file does not specify a default value.

<a name="the-fs_types-stanza"></a>

# The [Fs_types] Stanza

Each tag in the
_[fs_types]_
stanza names a filesystem type or usage type which can be specified via the
**-t**
or
**-T**
options to
**mke2fs**(8),
respectively.

The
**mke2fs**
program constructs a list of fs_types by concatenating the filesystem
type (i.e., ext2, ext3, etc.) with the usage type list.  For most
configuration options,
**mke2fs**
will look for a subsection in the
_[fs_types]_
stanza corresponding with each entry in the constructed list, with later
entries overriding earlier filesystem or usage types.
For
example, consider the following
**mke2fs.conf**
fragment:

[defaults]  
	base_features = sparse_super,filetype,resize_inode,dir_index  
	blocksize = 4096  
	inode_size = 256  
	inode_ratio = 16384  
  
[fs_types]  
	ext3 = {  
		features = has_journal  
	}  
	ext4 = {  
		features = extents,flex_bg  
		inode_size = 256  
	}  
	small = {  
		blocksize = 1024  
		inode_ratio = 4096  
	}  
	floppy = {  
		features = ^resize_inode  
		blocksize = 1024  
		inode_size = 128  
	}

If mke2fs started with a program name of
**mke2fs.ext4**,
then the filesystem type of ext4 will be used.  If the filesystem is
smaller than 3 megabytes, and no usage type is specified, then
**mke2fs**
will use a default
usage type of
_floppy_.
This results in an fs_types list of "ext4, floppy".   Both the ext4
subsection and the floppy subsection define an
_inode_size_
relation, but since the later entries in the fs_types list supersede
earlier ones, the configuration parameter for fs_types.floppy.inode_size
will be used, so the filesystem  will have an inode size of 128.

The exception to this resolution is the
_features_
tag, which specifies a set of changes to the features used by the
filesystem, and which is cumulative.  So in the above example, first
the configuration relation defaults.base_features would enable an
initial feature set with the sparse_super, filetype, resize_inode, and
dir_index features enabled.  Then configuration relation
fs_types.ext4.features would enable the extents and flex_bg
features, and finally the configuration relation
fs_types.floppy.features would remove
the resize_inode feature, resulting in a filesystem feature set
consisting of the sparse_super, filetype, dir_index,
extents_and flex_bg features.

For each filesystem type, the following tags may be used in that
fs_type's subsection.   These tags may also be used in the
_default_
section:

* _base_features_  
  This relation specifies the features which are initially enabled for this
  filesystem type.  Only one
  _base_features_
  will be used, so if there are multiple entries in the fs_types list
  whose subsections define the
  _base_features_
  relation, only the last will be used by
  **mke2fs**(8).
* _enable_periodic_fsck_  
  This boolean relation specifies whether periodic filesystem checks should be
  enforced at boot time.  If set to true, checks will be forced every
  180 days, or after a random number of mounts.  These values may
  be changed later via the
  **-i**
  and
  **-c**
  command-line options to
  **tune2fs**(8).
* _errors_  
  Change the behavior of the kernel code when errors are detected.
  In all cases, a filesystem error will cause
  **e2fsck**(8)
  to check the filesystem on the next boot.
  _errors_
  can be one of the following:
    * **continue**  
      Continue normal execution.
    * **remount-ro**  
      Remount filesystem read-only.
    * **panic**  
      Cause a kernel panic.
* _features_  
  This relation specifies a comma-separated list of features edit
  requests which modify the feature set
  used by the newly constructed filesystem.  The syntax is the same as the
  **-O**
  command-line option to
  **mke2fs**(8);
  that is, a feature can be prefixed by a caret ('^') symbol to disable
  a named feature.  Each
  _feature_
  relation specified in the fs_types list will be applied in the order
  found in the fs_types list.
* _force_undo_  
  This boolean relation, if set to a value of true, forces
  **mke2fs**
  to always try to create an undo file, even if the undo file might be
  huge and it might extend the time to create the filesystem image
  because the inode table isn't being initialized lazily.
* _default_features_  
  This relation specifies set of features which should be enabled or
  disabled after applying the features listed in the
  _base_features_
  and
  _features_
  relations.  It may be overridden by the
  **-O**
  command-line option to
  **mke2fs**(8).
* _auto_64-bit_support_  
  This relation is a boolean which specifies whether
  **mke2fs**(8)
  should automatically add the 64bit feature if the number of blocks for
  the file system requires this feature to be enabled.  The resize_inode
  feature is also automatically disabled since it doesn't support 64-bit
  block numbers.
* _default_mntopts_  
  This relation specifies the set of mount options which should be enabled
  by default.  These may be changed at a later time with the
  **-o**
  command-line option to
  **tune2fs**(8).
* _blocksize_  
  This relation specifies the default blocksize if the user does not
  specify a blocksize on the command line.
* _lazy_itable_init_  
  This boolean relation specifies whether the inode table should
  be lazily initialized.  It only has meaning if the uninit_bg feature is
  enabled.  If lazy_itable_init is true and the uninit_bg feature is
  enabled,  the inode table will
  not be fully initialized by
  **mke2fs**(8).
  This speeds up filesystem
  initialization noticeably, but it requires the kernel to finish
  initializing the filesystem in the background when the filesystem is
  first mounted.
* _lazy_journal_init_  
  This boolean relation specifies whether the journal inode should be
  lazily initialized. It only has meaning if the has_journal feature is
  enabled. If lazy_journal_init is true, the journal inode will not be
  fully zeroed out by
  **mke2fs**.
  This speeds up filesystem initialization noticeably, but carries some
  small risk if the system crashes before the journal has been overwritten
  entirely one time.
* _journal_location_  
  This relation specifies the location of the journal.
* _num_backup_sb_  
  This relation indicates whether file systems with the
  **sparse_super2**
  feature enabled should be created with 0, 1, or 2 backup superblocks.
* _packed_meta_blocks_  
  This boolean relation specifies whether the allocation bitmaps, inode
  table, and journal should be located at the beginning of the file system.
* _inode_ratio_  
  This relation specifies the default inode ratio if the user does not
  specify one on the command line.
* _inode_size_  
  This relation specifies the default inode size if the user does not
  specify one on the command line.
* _reserved_ratio_  
  This relation specifies the default percentage of filesystem blocks
  reserved for the super-user, if the user does not specify one on the command
  line.
* _hash_alg_  
  This relation specifies the default hash algorithm used for the
  new filesystems with hashed b-tree directories.  Valid algorithms
  accepted are:
  _legacy_,
  _half_md4_,
  and
  _tea_.
* _flex_bg_size_  
  This relation specifies the number of block groups that will be packed
  together to create one large virtual block group on an ext4 filesystem.
  This improves meta-data locality and performance on meta-data heavy
  workloads.  The number of groups must be a power of 2 and may only be
  specified if the flex_bg filesystem feature is enabled.
* _options_  
  This relation specifies additional extended options which should be
  treated by
  **mke2fs**(8)
  as if they were prepended to the argument of the
  **-E**
  option.  This can be used to configure the default extended options used
  by
  **mke2fs**(8)
  on a per-filesystem type basis.
* _discard_  
  This boolean relation specifies whether the
  **mke2fs**(8)
  should attempt to discard device prior to filesystem creation.
* _cluster_size_  
  This relation specifies the default cluster size if the bigalloc file
  system feature is enabled.  It can be overridden via the
  **-C**
  command line option to
  **mke2fs**(8)
* _make_hugefiles_  
  This boolean relation enables the creation of pre-allocated files as
  part of formatting the file system.  The extent tree blocks for these
  pre-allocated files will be placed near the beginning of the file
  system, so that if all of the other metadata blocks are also configured
  to be placed near the beginning of the file system (by disabling the
  backup superblocks, using the packed_meta_blocks option, etc.), the data
  blocks of the pre-allocated files will be contiguous.
* _hugefiles_dir_  
  This relation specifies the directory where huge files are created,
  relative to the filesystem root.
* _hugefiles_uid_  
  This relation controls the user ownership for all of the files and
  directories created by the
  _make_hugefiles_
  feature.
* _hugefiles_gid_  
  This relation controls the group ownership for all of the files and
  directories created by the
  _make_hugefiles_
  feature.
* _hugefiles_umask_  
  This relation specifies the umask used when creating the files and
  directories by the
  _make_hugefiles_
  feature.
* _num_hugefiles_  
  This relation specifies the number of huge files to be created.  If this
  relation is not specified, or is set to zero, and the
  _hugefiles_size_
  relation is non-zero, then
  _make_hugefiles_
  will create as many huge files as can fit to fill the entire file system.
* _hugefiles_slack_  
  This relation specifies how much space should be reserved for other
  files.
* _hugefiles_size_  
  This relation specifies the size of the huge files.  If this relation is
  not specified, the default is to fill the entire file system.
* _hugefiles_align_  
  This relation specifies the alignment for the start block of the huge
  files.  It also forces the size of huge files to be a multiple of the
  requested alignment.  If this relation is not specified, no alignment
  requirement will be imposed on the huge files.
* _hugefiles_align_disk_  
  This relations specifies whether the alignment should be relative to the
  beginning of the hard drive (assuming that the starting offset of the
  partition is available to mke2fs).  The default value is false, which
  will cause hugefile alignment to be relative to the beginning of the
  file system.
* _hugefiles_name_  
  This relation specifies the base file name for the huge files.
* _hugefiles_digits_  
  This relation specifies the (zero-padded) width of the field for the
  huge file number.
* _zero_hugefiles_  
  This boolean relation specifies whether or not zero blocks will be
  written to the hugefiles while
  **mke2fs**(8)
  is creating them.  By default, zero blocks will be written to the huge
  files to avoid stale data from being made available to potentially
  untrusted user programs, unless the device supports a discard/trim
  operation which will take care of zeroing the device blocks.  By setting
  _zero_hugefiles_
  to false, this step will always be skipped, which can be useful if it is
  known that the disk has been previously erased, or if the user programs
  that will have access to the huge files are trusted to not reveal stale
  data.
* _encoding_  
  This relation defines the file name encoding to be used if the casefold
  feature is enabled.   Currently the only valid encoding is utf8-12.1 or
  utf8, which requests the most recent Unicode version; since 12.1 is the only
  available Unicode version, utf8 and utf8-12.1 have the same result.
  _encoding_flags_
  This relation defines encoding-specific flags.  For utf8 encodings, the
  only available flag is strict, which will cause attempts to create file
  names containing invalid Unicode characters to be rejected by the
  kernel.  Strict mode is not enabled by default.

<a name="the-devices-stanza"></a>

# The [Devices] Stanza

Each tag in the
_[devices]_
stanza names device name so that per-device defaults can be specified.

* _fs_type_  
  This relation specifies the default parameter for the
  **-t**
  option, if this option isn't specified on the command line.
* _usage_types_  
  This relation specifies the default parameter for the
  **-T**
  option, if this option isn't specified on the command line.

<a name="files"></a>

# Files


* _/etc/mke2fs.conf_  
  The configuration file for
  **mke2fs**(8).

<a name="see-also"></a>

# See Also

**mke2fs**(8)
