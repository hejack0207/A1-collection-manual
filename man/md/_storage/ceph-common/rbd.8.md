# rbd(8) - manage rados block device (RBD) images

dev, Apr 21, 2020

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

    rbd [ -c ceph.conf ] [ -m monaddr ] [--cluster cluster-name]
    [ -p | --pool pool ] [ command ... ]
```


```

<a name="description"></a>

# Description


**rbd** is a utility for manipulating rados block device (RBD) images,
used by the Linux rbd driver and the rbd storage driver for QEMU/KVM.
RBD images are simple block devices that are striped over objects and
stored in a RADOS object store. The size of the objects the image is
striped over must be a power of two.

<a name="options"></a>

# Options

.INDENT 0.0

* **-c ceph.conf, --conf ceph.conf**  
  Use ceph.conf configuration file instead of the default /etc/ceph/ceph.conf to
  determine monitor addresses during startup.
  .UNINDENT
  .INDENT 0.0
* **-m monaddress[:port]**  
  Connect to specified monitor (instead of looking through ceph.conf).
  .UNINDENT
  .INDENT 0.0
* **--cluster cluster-name**  
  Use different cluster name as compared to default cluster name _ceph_.
  .UNINDENT
  .INDENT 0.0
* **-p pool-name, --pool pool-name**  
  Interact with the given pool. Required by most commands.
  .UNINDENT
  .INDENT 0.0
* **--namespace namespace-name**  
  Use a pre-defined image namespace within a pool
  .UNINDENT
  .INDENT 0.0
* **--no-progress**  
  Do not output progress information (goes to standard error by
  default for some commands).
  .UNINDENT

<a name="parameters"></a>

# Parameters

.INDENT 0.0

* **--image-format format-id**  
  Specifies which object layout to use. The default is 2.
  .INDENT 7.0
* ·  
  format 1 - (deprecated) Use the original format for a new rbd image. This
  format is understood by all versions of librbd and the kernel rbd module,
  but does not support newer features like cloning.
* ·  
  format 2 - Use the second rbd format, which is supported by
  librbd and kernel since version 3.11 (except for striping). This adds
  support for cloning and is more easily extensible to allow more
  features in the future.
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **-s size-in-M/G/T, --size size-in-M/G/T**  
  Specifies the size of the new rbd image or the new size of the existing rbd
  image in M/G/T.  If no suffix is given, unit M is assumed.
  .UNINDENT
  .INDENT 0.0
* **--object-size size-in-B/K/M**  
  Specifies the object size in B/K/M.  Object size will be rounded up the
  nearest power of two; if no suffix is given, unit B is assumed.  The default
  object size is 4M, smallest is 4K and maximum is 32M.
  .UNINDENT
  .INDENT 0.0
* **--stripe-unit size-in-B/K/M**  
  Specifies the stripe unit size in B/K/M.  If no suffix is given, unit B is
  assumed.  See striping section (below) for more details.
  .UNINDENT
  .INDENT 0.0
* **--stripe-count num**  
  Specifies the number of objects to stripe over before looping back
  to the first object.  See striping section (below) for more details.
  .UNINDENT
  .INDENT 0.0
* **--snap snap**  
  Specifies the snapshot name for the specific operation.
  .UNINDENT
  .INDENT 0.0
* **--id username**  
  Specifies the username (without the **client.** prefix) to use with the map command.
  .UNINDENT
  .INDENT 0.0
* **--keyring filename**  
  Specifies a keyring file containing a secret for the specified user
  to use with the map command.  If not specified, the default keyring
  locations will be searched.
  .UNINDENT
  .INDENT 0.0
* **--keyfile filename**  
  Specifies a file containing the secret key of **--id user** to use with the map command.
  This option is overridden by **--keyring** if the latter is also specified.
  .UNINDENT
  .INDENT 0.0
* **--shared lock-tag**  
  Option for _lock add_ that allows multiple clients to lock the
  same image if they use the same tag. The tag is an arbitrary
  string. This is useful for situations where an image must
  be open from more than one client at once, like during
  live migration of a virtual machine, or for use underneath
  a clustered filesystem.
  .UNINDENT
  .INDENT 0.0
* **--format format**  
  Specifies output formatting (default: plain, json, xml)
  .UNINDENT
  .INDENT 0.0
* **--pretty-format**  
  Make json or xml formatted output more human-readable.
  .UNINDENT
  .INDENT 0.0
* **-o krbd-options, --options krbd-options**  
  Specifies which options to use when mapping or unmapping an image via the
  rbd kernel driver.  krbd-options is a comma-separated list of options
  (similar to mount(8) mount options).  See kernel rbd (krbd) options section
  below for more details.
  .UNINDENT
  .INDENT 0.0
* **--read-only**  
  Map the image read-only.  Equivalent to -o ro.
  .UNINDENT
  .INDENT 0.0
* **--image-feature feature-name**  
  Specifies which RBD format 2 feature should be enabled when creating
  an image. Multiple features can be enabled by repeating this option
  multiple times. The following features are supported:
  .INDENT 7.0
* ·  
  layering: layering support
* ·  
  striping: striping v2 support
* ·  
  exclusive-lock: exclusive locking support
* ·  
  object-map: object map support (requires exclusive-lock)
* ·  
  fast-diff: fast diff calculations (requires object-map)
* ·  
  deep-flatten: snapshot flatten support
* ·  
  journaling: journaled IO support (requires exclusive-lock)
* ·  
  data-pool: erasure coded pool support
  .UNINDENT
  .UNINDENT
  .INDENT 0.0
* **--image-shared**  
  Specifies that the image will be used concurrently by multiple clients.
  This will disable features that are dependent upon exclusive ownership
  of the image.
  .UNINDENT
  .INDENT 0.0
* **--whole-object**  
  Specifies that the diff should be limited to the extents of a full object
  instead of showing intra-object deltas. When the object map feature is
  enabled on an image, limiting the diff to the object extents will
  dramatically improve performance since the differences can be computed
  by examining the in-memory object map instead of querying RADOS for each
  object within the image.
  .UNINDENT
  .INDENT 0.0
* **--limit**  
  Specifies the limit for the number of snapshots permitted.
  .UNINDENT

<a name="commands"></a>

# Commands

.INDENT 0.0

* **bench** --io-type &lt;read | write | readwrite | rw&gt; [--io-size _size-in-B/K/M/G/T_] [--io-threads _num-ios-in-flight_] [--io-total _size-in-B/K/M/G/T_] [--io-pattern seq | rand] [--rw-mix-read _read proportion in readwrite_] _image-spec_  
  Generate a series of IOs to the image and measure the IO throughput and
  latency.  If no suffix is given, unit B is assumed for both --io-size and
  --io-total.  Defaults are: --io-size 4096, --io-threads 16, --io-total 1G,
  --io-pattern seq, --rw-mix-read 50.
* **children** _snap-spec_  
  List the clones of the image at the given snapshot. This checks
  every pool, and outputs the resulting poolname/imagename.

This requires image format 2.

* **clone** [--object-size _size-in-B/K/M_] [--stripe-unit _size-in-B/K/M_ --stripe-count _num_] [--image-feature _feature-name_] [--image-shared] _parent-snap-spec_ _child-image-spec_  
  Will create a clone (copy-on-write child) of the parent snapshot.
  Object size will be identical to that of the parent image unless
  specified. Size will be the same as the parent snapshot. The --stripe-unit
  and --stripe-count arguments are optional, but must be used together.

The parent snapshot must be protected (see _rbd snap protect_).
This requires image format 2.

* **config global get** _config-entity_ _key_  
  Get a global-level configuration override.
* **config global list** [--format plain | json | xml] [--pretty-format] _config-entity_  
  List global-level configuration overrides.
* **config global set** _config-entity_ _key_ _value_  
  Set a global-level configuration override.
* **config global remove** _config-entity_ _key_  
  Remove a global-level configuration override.
* **config image get** _image-spec_ _key_  
  Get an image-level configuration override.
* **config image list** [--format plain | json | xml] [--pretty-format] _image-spec_  
  List image-level configuration overrides.
* **config image set** _image-spec_ _key_ _value_  
  Set an image-level configuration override.
* **config image remove** _image-spec_ _key_  
  Remove an image-level configuration override.
* **config pool get** _pool-name_ _key_  
  Get a pool-level configuration override.
* **config pool list** [--format plain | json | xml] [--pretty-format] _pool-name_  
  List pool-level configuration overrides.
* **config pool set** _pool-name_ _key_ _value_  
  Set a pool-level configuration override.
* **config pool remove** _pool-name_ _key_  
  Remove a pool-level configuration override.
* **cp** (_src-image-spec_ | _src-snap-spec_) _dest-image-spec_  
  Copy the content of a src-image into the newly created dest-image.
  dest-image will have the same size, object size, and image format as src-image.
* **create** (-s | --size _size-in-M/G/T_) [--image-format _format-id_] [--object-size _size-in-B/K/M_] [--stripe-unit _size-in-B/K/M_ --stripe-count _num_] [--thick-provision] [--no-progress] [--image-feature _feature-name_]... [--image-shared] _image-spec_  
  Will create a new rbd image. You must also specify the size via --size.  The
  --stripe-unit and --stripe-count arguments are optional, but must be used together.
  If the --thick-provision is enabled, it will fully allocate storage for
  the image at creation time. It will take a long time to do.
  Note: thick provisioning requires zeroing the contents of the entire image.
* **deep cp** (_src-image-spec_ | _src-snap-spec_) _dest-image-spec_  
  Deep copy the content of a src-image into the newly created dest-image.
  Dest-image will have the same size, object size, image format, and snapshots as src-image.
* **device list** [-t | --device-type _device-type_] [--format plain | json | xml] --pretty-format  
  Show the rbd images that are mapped via the rbd kernel module
  (default) or other supported device.
* **device map** [-t | --device-type _device-type_] [--read-only] [--exclusive] [-o | --options _device-options_] _image-spec_ | _snap-spec_  
  Map the specified image to a block device via the rbd kernel module
  (default) or other supported device (_nbd_ on Linux or _ggate_ on
  FreeBSD).

The --options argument is a comma separated list of device type
specific options (opt1,opt2=val,...).

* **device unmap** [-t | --device-type _device-type_] [-o | --options _device-options_] _image-spec_ | _snap-spec_ | _device-path_  
  Unmap the block device that was mapped via the rbd kernel module
  (default) or other supported device.

The --options argument is a comma separated list of device type
specific options (opt1,opt2=val,...).

* **diff** [--from-snap _snap-name_] [--whole-object] _image-spec_ | _snap-spec_  
  Dump a list of byte extents in the image that have changed since the specified start
  snapshot, or since the image was created.  Each output line includes the starting offset
  (in bytes), the length of the region (in bytes), and either 'zero' or 'data' to indicate
  whether the region is known to be zeros or may contain other data.
* **du** [-p | --pool _pool-name_] [_image-spec_ | _snap-spec_]  
  Will calculate the provisioned and actual disk usage of all images and
  associated snapshots within the specified pool.  It can also be used against
  individual images and snapshots.

If the RBD fast-diff feature is not enabled on images, this operation will
require querying the OSDs for every potential object within the image.

* **export** [--export-format _format (1 or 2)_] (_image-spec_ | _snap-spec_) [_dest-path_]  
  Export image to dest path (use - for stdout).
  The --export-format accepts '1' or '2' currently. Format 2 allow us to export not only the content
  of image, but also the snapshots and other properties, such as image_order, features.
* **export-diff** [--from-snap _snap-name_] [--whole-object] (_image-spec_ | _snap-spec_) _dest-path_  
  Export an incremental diff for an image to dest path (use - for stdout).  If
  an initial snapshot is specified, only changes since that snapshot are included; otherwise,
  any regions of the image that contain data are included.  The end snapshot is specified
  using the standard --snap option or @snap syntax (see below).  The image diff format includes
  metadata about image size changes, and the start and end snapshots.  It efficiently represents
  discarded or 'zero' regions of the image.
* **feature disable** _image-spec_ _feature-name_...  
  Disable the specified feature on the specified image. Multiple features can
  be specified.
* **feature enable** _image-spec_ _feature-name_...  
  Enable the specified feature on the specified image. Multiple features can
  be specified.
* **flatten** _image-spec_  
  If image is a clone, copy all shared blocks from the parent snapshot and
  make the child independent of the parent, severing the link between
  parent snap and child.  The parent snapshot can be unprotected and
  deleted if it has no further dependent clones.

This requires image format 2.

* **group create** _group-spec_  
  Create a group.
* **group image add** _group-spec_ _image-spec_  
  Add an image to a group.
* **group image list** _group-spec_  
  List images in a group.
* **group image remove** _group-spec_ _image-spec_  
  Remove an image from a group.
* **group ls** [-p | --pool _pool-name_]  
  List rbd groups.
* **group rename** _src-group-spec_ _dest-group-spec_  
  Rename a group.  Note: rename across pools is not supported.
* **group rm** _group-spec_  
  Delete a group.
* **group snap create** _group-snap-spec_  
  Make a snapshot of a group.
* **group snap list** _group-spec_  
  List snapshots of a group.
* **group snap rm** _group-snap-spec_  
  Remove a snapshot from a group.
* **group snap rename** _group-snap-spec_ _snap-name_  
  Rename group's snapshot.
* **group snap rollback** _group-snap-spec_  
  Rollback group to snapshot.
* **image-meta get** _image-spec_ _key_  
  Get metadata value with the key.
* **image-meta list** _image-spec_  
  Show metadata held on the image. The first column is the key
  and the second column is the value.
* **image-meta remove** _image-spec_ _key_  
  Remove metadata key with the value.
* **image-meta set** _image-spec_ _key_ _value_  
  Set metadata key with the value. They will displayed in _image-meta list_.
* **import** [--export-format _format (1 or 2)_] [--image-format _format-id_] [--object-size _size-in-B/K/M_] [--stripe-unit _size-in-B/K/M_ --stripe-count _num_] [--image-feature _feature-name_]... [--image-shared] _src-path_ [_image-spec_]  
  Create a new image and imports its data from path (use - for
  stdin).  The import operation will try to create sparse rbd images
  if possible.  For import from stdin, the sparsification unit is
  the data block size of the destination image (object size).

The --stripe-unit and --stripe-count arguments are optional, but must be
used together.

The --export-format accepts '1' or '2' currently. Format 2 allow us to import not only the content
of image, but also the snapshots and other properties, such as image_order, features.

* **import-diff** _src-path_ _image-spec_  
  Import an incremental diff of an image and applies it to the current image.  If the diff
  was generated relative to a start snapshot, we verify that snapshot already exists before
  continuing.  If there was an end snapshot we verify it does not already exist before
  applying the changes, and create the snapshot when we are done.
* **info** _image-spec_ | _snap-spec_  
  Will dump information (such as size and object size) about a specific rbd image.
  If image is a clone, information about its parent is also displayed.
  If a snapshot is specified, whether it is protected is shown as well.
* **journal client disconnect** _journal-spec_  
  Flag image journal client as disconnected.
* **journal export** [--verbose] [--no-error] _src-journal-spec_ _path-name_  
  Export image journal to path (use - for stdout). It can be make a backup
  of the image journal especially before attempting dangerous operations.

Note that this command may not always work if the journal is badly corrupted.

* **journal import** [--verbose] [--no-error] _path-name_ _dest-journal-spec_  
  Import image journal from path (use - for stdin).
* **journal info** _journal-spec_  
  Show information about image journal.
* **journal inspect** [--verbose] _journal-spec_  
  Inspect and report image journal for structural errors.
* **journal reset** _journal-spec_  
  Reset image journal.
* **journal status** _journal-spec_  
  Show status of image journal.
* **lock add** [--shared _lock-tag_] _image-spec_ _lock-id_  
  Lock an image. The lock-id is an arbitrary name for the user's
  convenience. By default, this is an exclusive lock, meaning it
  will fail if the image is already locked. The --shared option
  changes this behavior. Note that locking does not affect
  any operation other than adding a lock. It does not
  protect an image from being deleted.
* **lock ls** _image-spec_  
  Show locks held on the image. The first column is the locker
  to use with the _lock remove_ command.
* **lock rm** _image-spec_ _lock-id_ _locker_  
  Release a lock on an image. The lock id and locker are
  as output by lock ls.
* **ls** [-l | --long] [_pool-name_]  
  Will list all rbd images listed in the rbd_directory object.  With
  -l, also show snapshots, and use longer-format output including
  size, parent (if clone), format, etc.
* **merge-diff** _first-diff-path_ _second-diff-path_ _merged-diff-path_  
  Merge two continuous incremental diffs of an image into one single diff. The
  first diff's end snapshot must be equal with the second diff's start snapshot.
  The first diff could be - for stdin, and merged diff could be - for stdout, which
  enables multiple diff files to be merged using something like
  'rbd merge-diff first second - | rbd merge-diff - third result'. Note this command
  currently only support the source incremental diff with stripe_count == 1
* **migration abort** _image-spec_  
  Cancel image migration. This step may be run after successful or
  failed migration prepare or migration execute steps and returns the
  image to its initial (before migration) state. All modifications to
  the destination image are lost.
* **migration commit** _image-spec_  
  Commit image migration. This step is run after a successful migration
  prepare and migration execute steps and removes the source image data.
* **migration execute** _image-spec_  
  Execute image migration. This step is run after a successful migration
  prepare step and copies image data to the destination.
* **migration prepare** [--order _order_] [--object-size _object-size_] [--image-feature _image-feature_] [--image-shared] [--stripe-unit _stripe-unit_] [--stripe-count _stripe-count_] [--data-pool _data-pool_] _src-image-spec_ [_dest-image-spec_]  
  Prepare image migration. This is the first step when migrating an
  image, i.e. changing the image location, format or other
  parameters that can't be changed dynamically. The destination can
  match the source, and in this case _dest-image-spec_ can be omitted.
  After this step the source image is set as a parent of the
  destination image, and the image is accessible in copy-on-write mode
  by its destination spec.
* **mirror image demote** _image-spec_  
  Demote a primary image to non-primary for RBD mirroring.
* **mirror image disable** [--force] _image-spec_  
  Disable RBD mirroring for an image. If the mirroring is
  configured in **image** mode for the image's pool, then it
  can be explicitly disabled mirroring for each image within
  the pool.
* **mirror image enable** _image-spec_  
  Enable RBD mirroring for an image. If the mirroring is
  configured in **image** mode for the image's pool, then it
  can be explicitly enabled mirroring for each image within
  the pool.

This requires the RBD journaling feature is enabled.

* **mirror image promote** [--force] _image-spec_  
  Promote a non-primary image to primary for RBD mirroring.
* **mirror image resync** _image-spec_  
  Force resync to primary image for RBD mirroring.
* **mirror image status** _image-spec_  
  Show RBD mirroring status for an image.
* **mirror pool demote** [_pool-name_]  
  Demote all primary images within a pool to non-primary.
  Every mirroring enabled image will demoted in the pool.
* **mirror pool disable** [_pool-name_]  
  Disable RBD mirroring by default within a pool. When mirroring
  is disabled on a pool in this way, mirroring will also be
  disabled on any images (within the pool) for which mirroring
  was enabled explicitly.
* **mirror pool enable** [_pool-name_] _mode_  
  Enable RBD mirroring by default within a pool.
  The mirroring mode can either be **pool** or **image**.
  If configured in **pool** mode, all images in the pool
  with the journaling feature enabled are mirrored.
  If configured in **image** mode, mirroring needs to be
  explicitly enabled (by **mirror image enable** command)
  on each image.
* **mirror pool info** [_pool-name_]  
  Show information about the pool mirroring configuration.
  It includes mirroring mode, peer UUID, remote cluster name,
  and remote client name.
* **mirror pool peer add** [_pool-name_] _remote-cluster-spec_  
  Add a mirroring peer to a pool.
  _remote-cluster-spec_ is [_remote client name_@]_remote cluster name_.

The default for _remote client name_ is "client.admin".

This requires mirroring mode is enabled.

* **mirror pool peer remove** [_pool-name_] _uuid_  
  Remove a mirroring peer from a pool. The peer uuid is available
  from **mirror pool info** command.
* **mirror pool peer set** [_pool-name_] _uuid_ _key_ _value_  
  Update mirroring peer settings.
  The key can be either **client** or **cluster**, and the value
  is corresponding to remote client name or remote cluster name.
* **mirror pool promote** [--force] [_pool-name_]  
  Promote all non-primary images within a pool to primary.
  Every mirroring enabled image will promoted in the pool.
* **mirror pool status** [--verbose] [_pool-name_]  
  Show status for all mirrored images in the pool.
  With --verbose, also show additionally output status
  details for every mirroring image in the pool.
* **mv** _src-image-spec_ _dest-image-spec_  
  Rename an image.  Note: rename across pools is not supported.
* **namespace create** _pool-name_/_namespace-name_  
  Create a new image namespace within the pool.
* **namespace list** _pool-name_  
  List image namespaces defined within the pool.
* **namespace remove** _pool-name_/_namespace-name_  
  Remove an empty image namespace from the pool.
* **object-map check** _image-spec_ | _snap-spec_  
  Verify the object map is correct.
* **object-map rebuild** _image-spec_ | _snap-spec_  
  Rebuild an invalid object map for the specified image. An image snapshot can be
  specified to rebuild an invalid object map for a snapshot.
* **pool init** [_pool-name_] [--force]  
  Initialize pool for use by RBD. Newly created pools must initialized
  prior to use.
* **resize** (-s | --size _size-in-M/G/T_) [--allow-shrink] _image-spec_  
  Resize rbd image. The size parameter also needs to be specified.
  The --allow-shrink option lets the size be reduced.
* **rm** _image-spec_  
  Delete an rbd image (including all data blocks). If the image has
  snapshots, this fails and nothing is deleted.
* **snap create** _snap-spec_  
  Create a new snapshot. Requires the snapshot name parameter specified.
* **snap limit clear** _image-spec_  
  Remove any previously set limit on the number of snapshots allowed on
  an image.
* **snap limit set** [--limit] _limit_ _image-spec_  
  Set a limit for the number of snapshots allowed on an image.
* **snap ls** _image-spec_  
  Dump the list of snapshots inside a specific image.
* **snap protect** _snap-spec_  
  Protect a snapshot from deletion, so that clones can be made of it
  (see _rbd clone_).  Snapshots must be protected before clones are made;
  protection implies that there exist dependent cloned children that
  refer to this snapshot.  _rbd clone_ will fail on a nonprotected
  snapshot.

This requires image format 2.

* **snap purge** _image-spec_  
  Remove all unprotected snapshots from an image.
* **snap rename** _src-snap-spec_ _dest-snap-spec_  
  Rename a snapshot. Note: rename across pools and images is not supported.
* **snap rm** [--force] _snap-spec_  
  Remove the specified snapshot.
* **snap rollback** _snap-spec_  
  Rollback image content to snapshot. This will iterate through the entire blocks
  array and update the data head content to the snapshotted version.
* **snap unprotect** _snap-spec_  
  Unprotect a snapshot from deletion (undo _snap protect_).  If cloned
  children remain, _snap unprotect_ fails.  (Note that clones may exist
  in different pools than the parent snapshot.)

This requires image format 2.

* **sparsify** [--sparse-size _sparse-size_] _image-spec_  
  Reclaim space for zeroed image extents. The default sparse size is
  4096 bytes and can be changed via --sparse-size option with the
  following restrictions: it should be power of two, not less than
  4096, and not larger image object size.
* **status** _image-spec_  
  Show the status of the image, including which clients have it open.
* **trash ls** [_pool-name_]  
  List all entries from trash.
* **trash mv** _image-spec_  
  Move an image to the trash. Images, even ones actively in-use by
  clones, can be moved to the trash and deleted at a later time.
* **trash purge** [_pool-name_]  
  Remove all expired images from trash.
* **trash restore** _image-id_  
  Restore an image from trash.
* **trash rm** _image-id_  
  Delete an image from trash. If image deferment time has not expired
  you can not removed it unless use force. But an actively in-use by clones
  or has snapshots can not be removed.
* **watch** _image-spec_  
  Watch events on image.
  .UNINDENT

<a name="image-snap-group-and-journal-specs"></a>

# Image, Snap, Group and Journal Specs

    image-spec      is [pool-name/[namespace-name/]]image-name
    snap-spec       is [pool-name/[namespace-name/]]image-name@snap-name
    group-spec      is [pool-name/[namespace-name/]]group-name
    group-snap-spec is [pool-name/[namespace-name/]]group-name@snap-name
    journal-spec    is [pool-name/[namespace-name/]]journal-name


The default for _pool-name_ is "rbd" and _namespace-name_ is "". If an image
name contains a slash character ('/'), _pool-name_ is required.

The _journal-name_ is _image-id_.

You may specify each name individually, using --pool, --namespace, --image, and
--snap options, but this is discouraged in favor of the above spec syntax.

<a name="striping"></a>

# Striping


RBD images are striped over many objects, which are then stored by the
Ceph distributed object store (RADOS).  As a result, read and write
requests for the image are distributed across many nodes in the
cluster, generally preventing any single node from becoming a
bottleneck when individual images get large or busy.

The striping is controlled by three parameters:
.INDENT 0.0

* **object-size**  
  The size of objects we stripe over is a power of two. It will be rounded up the nearest power of two.
  The default object size is 4 MB, smallest is 4K and maximum is 32M.
  .UNINDENT
  .INDENT 0.0
* **stripe_unit**  
  Each [_stripe\_unit_] contiguous bytes are stored adjacently in the same object, before we move on
  to the next object.
  .UNINDENT
  .INDENT 0.0
* **stripe_count**  
  After we write [_stripe\_unit_] bytes to [_stripe\_count_] objects, we loop back to the initial object
  and write another stripe, until the object reaches its maximum size.  At that point,
  we move on to the next [_stripe\_count_] objects.
  .UNINDENT

By default, [_stripe\_unit_] is the same as the object size and [_stripe\_count_] is 1.  Specifying a different
[_stripe\_unit_] requires that the STRIPINGV2 feature be supported (added in Ceph v0.53) and format 2 images be
used.

<a name="kernel-rbd-krbd-options"></a>

# Kernel Rbd (Krbd) Options


Most of these options are useful mainly for debugging and benchmarking.  The
default values are set in the kernel and may therefore depend on the version of
the running kernel.

Per client instance _rbd device map_ options:
.INDENT 0.0

* ·  
  fsid=aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee - FSID that should be assumed by
  the client.
* ·  
  ip=a.b.c.d[:p] - IP and, optionally, port the client should use.
* ·  
  share - Enable sharing of client instances with other mappings (default).
* ·  
  noshare - Disable sharing of client instances with other mappings.
* ·  
  crc - Enable CRC32C checksumming for data writes (default).
* ·  
  nocrc - Disable CRC32C checksumming for data writes.
* ·  
  cephx_require_signatures - Require cephx message signing (since 3.19,
  default).
* ·  
  nocephx_require_signatures - Don't require cephx message signing (since
  3.19).
* ·  
  tcp_nodelay - Disable Nagle's algorithm on client sockets (since 4.0,
  default).
* ·  
  notcp_nodelay - Enable Nagle's algorithm on client sockets (since 4.0).
* ·  
  cephx_sign_messages - Enable message signing (since 4.4, default).
* ·  
  nocephx_sign_messages - Disable message signing (since 4.4).
* ·  
  mount_timeout=x - A timeout on various steps in _rbd device map_ and
  _rbd device unmap_ sequences (default is 60 seconds).  In particular,
  since 4.2 this can be used to ensure that _rbd device unmap_ eventually
  times out when there is no network connection to a cluster.
* ·  
  osdkeepalive=x - OSD keepalive timeout (default is 5 seconds).
* ·  
  osd_idle_ttl=x - OSD idle TTL (default is 60 seconds).
  .UNINDENT

Per mapping (block device) _rbd device map_ options:
.INDENT 0.0

* ·  
  rw - Map the image read-write (default).
* ·  
  ro - Map the image read-only.  Equivalent to --read-only.
* ·  
  queue_depth=x - queue depth (since 4.2, default is 128 requests).
* ·  
  lock_on_read - Acquire exclusive lock on reads, in addition to writes and
  discards (since 4.9).
* ·  
  exclusive - Disable automatic exclusive lock transitions (since 4.12).
* ·  
  lock_timeout=x - A timeout on waiting for the acquisition of exclusive lock
  (since 4.17, default is 0 seconds, meaning no timeout).
* ·  
  notrim - Turn off discard and write zeroes offload support to avoid
  deprovisioning a fully provisioned image (since 4.17). When enabled, discard
  requests will fail with -EOPNOTSUPP, write zeroes requests will fall back to
  manually zeroing.
* ·  
  abort_on_full - Fail write requests with -ENOSPC when the cluster is full or
  the data pool reaches its quota (since 5.0).  The default behaviour is to
  block until the full condition is cleared.
* ·  
  alloc_size - Minimum allocation unit of the underlying OSD object store
  backend (since 5.1, default is 64K bytes).  This is used to round off and
  drop discards that are too small.  For bluestore, the recommended setting is
  bluestore_min_alloc_size (typically 64K for hard disk drives and 16K for
  solid-state drives).  For filestore with filestore_punch_hole = false, the
  recommended setting is image object size (typically 4M).
  .UNINDENT

_rbd device unmap_ options:
.INDENT 0.0

* ·  
  force - Force the unmapping of a block device that is open (since 4.9).  The
  driver will wait for running requests to complete and then unmap; requests
  sent to the driver after initiating the unmap will be failed.
  .UNINDENT

<a name="examples"></a>

# Examples


To create a new rbd image that is 100 GB:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd create mypool/myimage --size 102400
    .ft P
.UNINDENT
.UNINDENT

To use a non-default object size (8 MB):
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd create mypool/myimage --size 102400 --object-size 8M
    .ft P
.UNINDENT
.UNINDENT

To delete an rbd image (be careful!):
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd rm mypool/myimage
    .ft P
.UNINDENT
.UNINDENT

To create a new snapshot:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd snap create mypool/myimage@mysnap
    .ft P
.UNINDENT
.UNINDENT

To create a copy-on-write clone of a protected snapshot:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd clone mypool/myimage@mysnap otherpool/cloneimage
    .ft P
.UNINDENT
.UNINDENT

To see which clones of a snapshot exist:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd children mypool/myimage@mysnap
    .ft P
.UNINDENT
.UNINDENT

To delete a snapshot:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd snap rm mypool/myimage@mysnap
    .ft P
.UNINDENT
.UNINDENT

To map an image via the kernel with cephx enabled:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd device map mypool/myimage --id admin --keyfile secretfile
    .ft P
.UNINDENT
.UNINDENT

To map an image via the kernel with different cluster name other than default _ceph_:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd device map mypool/myimage --cluster cluster-name
    .ft P
.UNINDENT
.UNINDENT

To unmap an image:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd device unmap /dev/rbd0
    .ft P
.UNINDENT
.UNINDENT

To create an image and a clone from it:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd import --image-format 2 image mypool/parent
    rbd snap create mypool/parent@snap
    rbd snap protect mypool/parent@snap
    rbd clone mypool/parent@snap otherpool/child
    .ft P
.UNINDENT
.UNINDENT

To create an image with a smaller stripe_unit (to better distribute small writes in some workloads):
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd create mypool/myimage --size 102400 --stripe-unit 65536B --stripe-count 16
    .ft P
.UNINDENT
.UNINDENT

To change an image from one image format to another, export it and then
import it as the desired image format:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd export mypool/myimage@snap /tmp/img
    rbd import --image-format 2 /tmp/img mypool/myimage2
    .ft P
.UNINDENT
.UNINDENT

To lock an image for exclusive use:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd lock add mypool/myimage mylockid
    .ft P
.UNINDENT
.UNINDENT

To release a lock:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd lock remove mypool/myimage mylockid client.2485
    .ft P
.UNINDENT
.UNINDENT

To list images from trash:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd trash ls mypool
    .ft P
.UNINDENT
.UNINDENT

To defer delete an image (use _--expires-at_ to set expiration time, default is now):
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd trash mv mypool/myimage --expires-at "tomorrow"
    .ft P
.UNINDENT
.UNINDENT

To delete an image from trash (be careful!):
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd trash rm mypool/myimage-id
    .ft P
.UNINDENT
.UNINDENT

To force delete an image from trash (be careful!):
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd trash rm mypool/myimage-id  --force
    .ft P
.UNINDENT
.UNINDENT

To restore an image from trash:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd trash restore mypool/myimage-id
    .ft P
.UNINDENT
.UNINDENT

To restore an image from trash and rename it:
.INDENT 0.0
.INDENT 3.5

    .ft C
    rbd trash restore mypool/myimage-id --image mynewimage
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**rbd** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph(8),
rados(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

