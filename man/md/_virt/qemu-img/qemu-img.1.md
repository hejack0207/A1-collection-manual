# qemu-img.1(1)

 , 2019-08-14

.if n .ad l
.nh

<a name="name"></a>

# Name

qemu-img - QEMU disk image utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" qemu-img [standard options] command [command options]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
qemu-img allows you to create, convert and modify images offline. It can handle
all image formats supported by \s-1QEMU.\s0

**Warning:** Never use qemu-img to modify images in use by a running virtual
machine or any other process; this may destroy the image. Also, be aware that
querying an image that is being modified by another process may encounter
inconsistent state.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
Standard options:

* **-h, --help**  
  .IX Item "-h, --help"
  Display this help and exit
* **-V, --version**  
  .IX Item "-V, --version"
  Display version information and exit
* **-T, --trace [[enable=]**_pattern_**][,events=**_file_**][,file=**_file_**]**  
  .IX Item "-T, --trace [[enable=]pattern][,events=file][,file=file]"
  Specify tracing options.
    * **[enable=]**_pattern_  
      .IX Item "[enable=]pattern"
      Immediately enable events matching _pattern_
      (either event name or a globbing pattern).  This option is only
      available if \s-1QEMU\s0 has been compiled with the _simple_, _log_
      or _ftrace_ tracing backend.  To specify multiple events or patterns,
      specify the **-trace** option multiple times.
      .Sp
      Use \f(CW`-trace help\*(C' to print a list of names of trace points.
    * **events=**_file_  
      .IX Item "events=file"
      Immediately enable events listed in _file_.
      The file must contain one event name (as listed in the _trace-events-all_
      file) per line; globbing patterns are accepted too.  This option is only
      available if \s-1QEMU\s0 has been compiled with the _simple_, _log_ or
      _ftrace_ tracing backend.
    * **file=**_file_  
      .IX Item "file=file"
      Log output traces to _file_.
      This option is only available if \s-1QEMU\s0 has been compiled with
      the _simple_ tracing backend.

The following commands are supported:

* **amend [--object** _objectdef_**] [--image-opts] [-p] [-q] [-f** _fmt_**] [-t** _cache_**] -o** _options_** **_filename_  
  .IX Item "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename"
* **bench [-c** _count_**] [-d** _depth_**] [-f** _fmt_**] [--flush-interval=**_flush\_interval_**] [-n] [--no-drain] [-o** _offset_**] [--pattern=**_pattern_**] [-q] [-s** _buffer\_size_**] [-S** _step\_size_**] [-t** _cache_**] [-w] [-U]** _filename_  
  .IX Item "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename"
* **check [--object** _objectdef_**] [--image-opts] [-q] [-f** _fmt_**] [--output=**_ofmt_**] [-r [leaks | all]] [-T** _src\_cache_**] [-U]** _filename_  
  .IX Item "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename"
* **commit [--object** _objectdef_**] [--image-opts] [-q] [-f** _fmt_**] [-t** _cache_**] [-b** _base_**] [-d] [-p]** _filename_  
  .IX Item "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename"
* **compare [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [-F** _fmt_**] [-T** _src\_cache_**] [-p] [-q] [-s] [-U]** _filename1_** **_filename2_  
  .IX Item "compare [--object objectdef] [--image-opts] [-f fmt] [-F fmt] [-T src_cache] [-p] [-q] [-s] [-U] filename1 filename2"
* **convert [--object** _objectdef_**] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f** _fmt_**] [-t** _cache_**] [-T** _src\_cache_**] [-O** _output\_fmt_**] [-B** _backing\_file_**] [-o** _options_**] [-l** _snapshot\_param_**] [-S** _sparse\_size_**] [-m** _num\_coroutines_**] [-W]** _filename_ **[**_filename2_ **[...]]** _output\_filename_  
  .IX Item "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename"
* **create [--object** _objectdef_**] [-q] [-f** _fmt_**] [-b** _backing\_file_**] [-F** _backing\_fmt_**] [-u] [-o** _options_**]** _filename_ **[**_size_**]**  
  .IX Item "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]"
* **dd [--image-opts] [-U] [-f** _fmt_**] [-O** _output\_fmt_**] [bs=**_block\_size_**] [count=**_blocks_**] [skip=**_blocks_**] if=**_input_ **of=**_output_  
  .IX Item "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output"
* **info [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [--output=**_ofmt_**] [--backing-chain] [-U]** _filename_  
  .IX Item "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [-U] filename"
* **map [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [--output=**_ofmt_**] [-U]** _filename_  
  .IX Item "map [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [-U] filename"
* **measure [--output=**_ofmt_**] [-O** _output\_fmt_**] [-o** _options_**] [--size** _N_ **| [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [-l** _snapshot\_param_**]** _filename_**]**  
  .IX Item "measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]"
* **snapshot [--object** _objectdef_**] [--image-opts] [-U] [-q] [-l | -a** _snapshot_ **| -c** _snapshot_ **| -d** _snapshot_**]** _filename_  
  .IX Item "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename"
* **rebase [--object** _objectdef_**] [--image-opts] [-U] [-q] [-f** _fmt_**] [-t** _cache_**] [-T** _src\_cache_**] [-p] [-u] -b** _backing\_file_ **[-F** _backing\_fmt_**]** _filename_  
  .IX Item "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename"
* **resize [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [--preallocation=**_prealloc_**] [-q] [--shrink]** _filename_ **[+ | -]**_size_  
  .IX Item "resize [--object objectdef] [--image-opts] [-f fmt] [--preallocation=prealloc] [-q] [--shrink] filename [+ | -]size"

Command parameters:

* _filename_  
  .IX Item "filename"
  is a disk image filename
* _fmt_  
  .IX Item "fmt"
  is the disk image format. It is guessed automatically in most cases. See below
  for a description of the supported disk formats.
* _size_  
  .IX Item "size"
  is the disk image size in bytes. Optional suffixes \f(CW`k\*(C' or \f(CW\*(C\`K\*(C'
  (kilobyte, 1024) \f(CW`M\*(C' (megabyte, 1024k) and \f(CW\*(C\`G\*(C' (gigabyte, 1024M)
  and T (terabyte, 1024G) are supported.  \f(CW`b\*(C' is ignored.
* _output\_filename_  
  .IX Item "output_filename"
  is the destination disk image filename
* _output\_fmt_  
  .IX Item "output_fmt"
  is the destination format
* _options_  
  .IX Item "options"
  is a comma separated list of format specific options in a
  name=value format. Use \f(CW`-o ?\*(C' for an overview of the options supported
  by the used format or see the format descriptions below for details.
* _snapshot\_param_  
  .IX Item "snapshot_param"
  is param used for internal snapshot, format is
  'snapshot.id=[\s-1ID\s0],snapshot.name=[\s-1NAME\s0]' or '[\s-1ID_OR_NAME\s0]'
* **--object** _objectdef_  
  .IX Item "--object objectdef"
  is a \s-1QEMU\s0 user creatable object definition. See the \f(CWqemu(1) manual
  page for a description of the object properties. The most common object
  type is a \f(CW`secret\*(C', which is used to supply passwords and/or encryption
  keys.
* **--image-opts**  
  .IX Item "--image-opts"
  Indicates that the source _filename_ parameter is to be interpreted as a
  full option string, not a plain filename. This parameter is mutually
  exclusive with the _-f_ parameter.
* **--target-image-opts**  
  .IX Item "--target-image-opts"
  Indicates that the _output\_filename_ parameter(s) are to be interpreted as
  a full option string, not a plain filename. This parameter is mutually
  exclusive with the _-O_ parameters. It is currently required to also use
  the _-n_ parameter to skip image creation. This restriction may be relaxed
  in a future release.
* **--force-share (-U)**  
  .IX Item "--force-share (-U)"
  If specified, \f(CW`qemu-img\*(C' will open the image in shared mode, allowing
  other \s-1QEMU\s0 processes to open it in write mode. For example, this can be used to
  get the image information (with 'info' subcommand) when the image is used by a
  running guest.  Note that this could produce inconsistent results because of
  concurrent metadata changes, etc. This option is only allowed when opening
  images in read-only mode.
* **--backing-chain**  
  .IX Item "--backing-chain"
  will enumerate information about backing files in a disk image chain. Refer
  below for further description.
* **-c**  
  .IX Item "-c"
  indicates that target image must be compressed (qcow format only)
* **-h**  
  .IX Item "-h"
  with or without a command shows help and lists the supported formats
* **-p**  
  .IX Item "-p"
  display progress bar (compare, convert and rebase commands only).
  If the _-p_ option is not used for a command that supports it, the
  progress is reported when the process receives a \f(CW`SIGUSR1\*(C' or
  \f(CW`SIGINFO\*(C' signal.
* **-q**  
  .IX Item "-q"
  Quiet mode - do not print any output (except errors). There's no progress bar
  in case both _-q_ and _-p_ options are used.
* **-S** _size_  
  .IX Item "-S size"
  indicates the consecutive number of bytes that must contain only zeros
  for qemu-img to create a sparse image during conversion. This value is rounded
  down to the nearest 512 bytes. You may use the common size suffixes like
  \f(CW`k\*(C' for kilobytes.
* **-t** _cache_  
  .IX Item "-t cache"
  specifies the cache mode that should be used with the (destination) file. See
  the documentation of the emulator's \f(CW`-drive cache=...\*(C' option for allowed
  values.
* **-T** _src\_cache_  
  .IX Item "-T src_cache"
  specifies the cache mode that should be used with the source file(s). See
  the documentation of the emulator's \f(CW`-drive cache=...\*(C' option for allowed
  values.

Parameters to snapshot subcommand:

* **snapshot**  
  .IX Item "snapshot"
  is the name of the snapshot to create, apply or delete
* **-a**  
  .IX Item "-a"
  applies a snapshot (revert disk to saved state)
* **-c**  
  .IX Item "-c"
  creates a snapshot
* **-d**  
  .IX Item "-d"
  deletes a snapshot
* **-l**  
  .IX Item "-l"
  lists all snapshots in the given image

Parameters to compare subcommand:

* **-f**  
  .IX Item "-f"
  First image format
* **-F**  
  .IX Item "-F"
  Second image format
* **-s**  
  .IX Item "-s"
  Strict mode - fail on different image size or sector allocation

Parameters to convert subcommand:

* **-n**  
  .IX Item "-n"
  Skip the creation of the target volume
* **-m**  
  .IX Item "-m"
  Number of parallel coroutines for the convert process
* **-W**  
  .IX Item "-W"
  Allow out-of-order writes to the destination. This option improves performance,
  but is only recommended for preallocated devices like host devices or other
  raw block devices.
* **-C**  
  .IX Item "-C"
  Try to use copy offloading to move data from source image to target. This may
  improve performance if the data is remote, such as with \s-1NFS\s0 or iSCSI backends,
  but will not automatically sparsify zero sectors, and may result in a fully
  allocated target image depending on the host support for getting allocation
  information.

Parameters to dd subcommand:

* **bs=**_block\_size_  
  .IX Item "bs=block_size"
  defines the block size
* **count=**_blocks_  
  .IX Item "count=blocks"
  sets the number of input blocks to copy
* **if=**_input_  
  .IX Item "if=input"
  sets the input file
* **of=**_output_  
  .IX Item "of=output"
  sets the output file
* **skip=**_blocks_  
  .IX Item "skip=blocks"
  sets the number of input blocks to skip

Command description:

* **amend [--object** _objectdef_**] [--image-opts] [-p] [-p] [-f** _fmt_**] [-t** _cache_**] -o** _options_** **_filename_  
  .IX Item "amend [--object objectdef] [--image-opts] [-p] [-p] [-f fmt] [-t cache] -o options filename"
  Amends the image format specific _options_ for the image file
  _filename_. Not all file formats support this operation.
* **bench [-c** _count_**] [-d** _depth_**] [-f** _fmt_**] [--flush-interval=**_flush\_interval_**] [-n] [--no-drain] [-o** _offset_**] [--pattern=**_pattern_**] [-q] [-s** _buffer\_size_**] [-S** _step\_size_**] [-t** _cache_**] [-w] [-U]** _filename_  
  .IX Item "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename"
  Run a simple sequential I/O benchmark on the specified image. If \f(CW`-w\*(C' is
  specified, a write test is performed, otherwise a read test is performed.
  .Sp
  A total number of _count_ I/O requests is performed, each _buffer\_size_
  bytes in size, and with _depth_ requests in parallel. The first request
  starts at the position given by _offset_, each following request increases
  the current position by _step\_size_. If _step\_size_ is not given,
  _buffer\_size_ is used for its value.
  .Sp
  If _flush\_interval_ is specified for a write test, the request queue is
  drained and a flush is issued before new writes are made whenever the number of
  remaining requests is a multiple of _flush\_interval_. If additionally
  \f(CW`--no-drain\*(C' is specified, a flush is issued without draining the request
  queue first.
  .Sp
  If \f(CW`-n\*(C' is specified, the native \s-1AIO\s0 backend is used if possible. On
  Linux, this option only works if \f(CW`-t none\*(C' or \f(CW\*(C\`-t directsync\*(C' is
  specified as well.
  .Sp
  For write tests, by default a buffer filled with zeros is written. This can be
  overridden with a pattern byte specified by _pattern_.
* **check [--object** _objectdef_**] [--image-opts] [-q] [-f** _fmt_**] [--output=**_ofmt_**] [-r [leaks | all]] [-T** _src\_cache_**] [-U]** _filename_  
  .IX Item "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename"
  Perform a consistency check on the disk image _filename_. The command can
  output in the format _ofmt_ which is either \f(CW`human\*(C' or \f(CW\*(C\`json\*(C'.
  .Sp
  If \f(CW`-r\*(C' is specified, qemu-img tries to repair any inconsistencies found
  during the check. \f(CW`-r leaks\*(C' repairs only cluster leaks, whereas
  \f(CW`-r all\*(C' fixes all kinds of errors, with a higher risk of choosing the
  wrong fix or hiding corruption that has already occurred.
  .Sp
  Only the formats \f(CW`qcow2\*(C', \f(CW\*(C\`qed\*(C' and \f(CW\*(C\`vdi\*(C' support
  consistency checks.
  .Sp
  In case the image does not have any inconsistencies, check exits with \f(CW0.
  Other exit codes indicate the kind of inconsistency found or if another error
  occurred. The following table summarizes all exit codes of the check subcommand:
    * **0**  
      .IX Item "0"
      Check completed, the image is (now) consistent
    * **1**  
      .IX Item "1"
      Check not completed because of internal errors
    * **2**  
      .IX Item "2"
      Check completed, image is corrupted
    * **3**  
      .IX Item "3"
      Check completed, image has leaked clusters, but is not corrupted
    * **63**  
      .IX Item "63"
      Checks are not supported by the image format
      .Sp
      If \f(CW`-r\*(C' is specified, exit codes representing the image state refer to the
      state after (the attempt at) repairing it. That is, a successful \f(CW`-r all\*(C'
      will yield the exit code 0, independently of the image state before.
* **commit [--object** _objectdef_**] [--image-opts] [-q] [-f** _fmt_**] [-t** _cache_**] [-b** _base_**] [-d] [-p]** _filename_  
  .IX Item "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache] [-b base] [-d] [-p] filename"
  Commit the changes recorded in _filename_ in its base image or backing file.
  If the backing file is smaller than the snapshot, then the backing file will be
  resized to be the same size as the snapshot.  If the snapshot is smaller than
  the backing file, the backing file will not be truncated.  If you want the
  backing file to match the size of the smaller snapshot, you can safely truncate
  it yourself once the commit operation successfully completes.
  .Sp
  The image _filename_ is emptied after the operation has succeeded. If you do
  not need _filename_ afterwards and intend to drop it, you may skip emptying
  _filename_ by specifying the \f(CW`-d\*(C' flag.
  .Sp
  If the backing chain of the given image file _filename_ has more than one
  layer, the backing file into which the changes will be committed may be
  specified as _base_ (which has to be part of _filename_'s backing
  chain). If _base_ is not specified, the immediate backing file of the top
  image (which is _filename_) will be used. Note that after a commit operation
  all images between _base_ and the top image will be invalid and may return
  garbage data when read. For this reason, \f(CW`-b\*(C' implies \f(CW\*(C\`-d\*(C' (so that
  the top image stays valid).
* **compare [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [-F** _fmt_**] [-T** _src\_cache_**] [-p] [-q] [-s] [-U]** _filename1_** **_filename2_  
  .IX Item "compare [--object objectdef] [--image-opts] [-f fmt] [-F fmt] [-T src_cache] [-p] [-q] [-s] [-U] filename1 filename2"
  Check if two images have the same content. You can compare images with
  different format or settings.
  .Sp
  The format is probed unless you specify it by _-f_ (used for
  _filename1_) and/or _-F_ (used for _filename2_) option.
  .Sp
  By default, images with different size are considered identical if the larger
  image contains only unallocated and/or zeroed sectors in the area after the end
  of the other image. In addition, if any sector is not allocated in one image
  and contains only zero bytes in the second one, it is evaluated as equal. You
  can use Strict mode by specifying the _-s_ option. When compare runs in
  Strict mode, it fails in case image size differs or a sector is allocated in
  one image and is not allocated in the second one.
  .Sp
  By default, compare prints out a result message. This message displays
  information that both images are same or the position of the first different
  byte. In addition, result message can report different image size in case
  Strict mode is used.
  .Sp
  Compare exits with \f(CW0 in case the images are equal and with \f(CW1
  in case the images differ. Other exit codes mean an error occurred during
  execution and standard error output should contain an error message.
  The following table sumarizes all exit codes of the compare subcommand:
    * **0**  
      .IX Item "0"
      Images are identical
    * **1**  
      .IX Item "1"
      Images differ
    * **2**  
      .IX Item "2"
      Error on opening an image
    * **3**  
      .IX Item "3"
      Error on checking a sector allocation
    * **4**  
      .IX Item "4"
      Error on reading data
* **convert [--object** _objectdef_**] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f** _fmt_**] [-t** _cache_**] [-T** _src\_cache_**] [-O** _output\_fmt_**] [-B** _backing\_file_**] [-o** _options_**] [-l** _snapshot\_param_**] [-S** _sparse\_size_**] [-m** _num\_coroutines_**] [-W]** _filename_ **[**_filename2_ **[...]]** _output\_filename_  
  .IX Item "convert [--object objectdef] [--image-opts] [--target-image-opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename"
  Convert the disk image _filename_ or a snapshot _snapshot\_param_
  to disk image _output\_filename_ using format _output\_fmt_. It can be optionally compressed (\f(CW`-c\*(C'
  option) or use any format specific options like encryption (\f(CW`-o\*(C' option).
  .Sp
  Only the formats \f(CW`qcow\*(C' and \f(CW\*(C\`qcow2\*(C' support compression. The
  compression is read-only. It means that if a compressed sector is
  rewritten, then it is rewritten as uncompressed data.
  .Sp
  Image conversion is also useful to get smaller image when using a
  growable format such as \f(CW`qcow\*(C': the empty sectors are detected and
  suppressed from the destination image.
  .Sp
  _sparse\_size_ indicates the consecutive number of bytes (defaults to 4k)
  that must contain only zeros for qemu-img to create a sparse image during
  conversion. If _sparse\_size_ is 0, the source will not be scanned for
  unallocated or zero sectors, and the destination image will always be
  fully allocated.
  .Sp
  You can use the _backing\_file_ option to force the output image to be
  created as a copy on write image of the specified base image; the
  _backing\_file_ should have the same content as the input's base image,
  however the path, image format, etc may differ.
  .Sp
  If a relative path name is given, the backing file is looked up relative to
  the directory containing _output\_filename_.
  .Sp
  If the \f(CW`-n\*(C' option is specified, the target volume creation will be
  skipped. This is useful for formats such as \f(CW`rbd\*(C' if the target
  volume has already been created with site specific options that cannot
  be supplied through qemu-img.
  .Sp
  Out of order writes can be enabled with \f(CW`-W\*(C' to improve performance.
  This is only recommended for preallocated devices like host devices or other
  raw block devices. Out of order write does not work in combination with
  creating compressed images.
  .Sp
  _num\_coroutines_ specifies how many coroutines work in parallel during
  the convert process (defaults to 8).
* **create [--object** _objectdef_**] [-q] [-f** _fmt_**] [-b** _backing\_file_**] [-F** _backing\_fmt_**] [-u] [-o** _options_**]** _filename_ **[**_size_**]**  
  .IX Item "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F backing_fmt] [-u] [-o options] filename [size]"
  Create the new disk image _filename_ of size _size_ and format
  _fmt_. Depending on the file format, you can add one or more _options_
  that enable additional features of this format.
  .Sp
  If the option _backing\_file_ is specified, then the image will record
  only the differences from _backing\_file_. No size needs to be specified in
  this case. _backing\_file_ will never be modified unless you use the
  \f(CW`commit\*(C' monitor command (or qemu-img commit).
  .Sp
  If a relative path name is given, the backing file is looked up relative to
  the directory containing _filename_.
  .Sp
  Note that a given backing file will be opened to check that it is valid. Use
  the \f(CW`-u\*(C' option to enable unsafe backing file mode, which means that the
  image will be created even if the associated backing file cannot be opened. A
  matching backing file must be created or additional options be used to make the
  backing file specification valid when you want to use an image created this
  way.
  .Sp
  The size can also be specified using the _size_ option with \f(CW`-o\*(C',
  it doesn't need to be specified separately in this case.
* **dd [--image-opts] [-U] [-f** _fmt_**] [-O** _output\_fmt_**] [bs=**_block\_size_**] [count=**_blocks_**] [skip=**_blocks_**] if=**_input_ **of=**_output_  
  .IX Item "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=block_size] [count=blocks] [skip=blocks] if=input of=output"
  Dd copies from _input_ file to _output_ file converting it from
  _fmt_ format to _output\_fmt_ format.
  .Sp
  The data is by default read and written using blocks of 512 bytes but can be
  modified by specifying _block\_size_. If count=_blocks_ is specified
  dd will stop reading input after reading _blocks_ input blocks.
  .Sp
  The size syntax is similar to **dd**\|(1)'s size syntax.
* **info [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [--output=**_ofmt_**] [--backing-chain] [-U]** _filename_  
  .IX Item "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [-U] filename"
  Give information about the disk image _filename_. Use it in
  particular to know the size reserved on disk which can be different
  from the displayed size. If \s-1VM\s0 snapshots are stored in the disk image,
  they are displayed too. The command can output in the format _ofmt_
  which is either \f(CW`human\*(C' or \f(CW\*(C\`json\*(C'.
  .Sp
  If a disk image has a backing file chain, information about each disk image in
  the chain can be recursively enumerated by using the option \f(CW`--backing-chain\*(C'.
  .Sp
  For instance, if you have an image chain like:
  .Sp
  .Vb 1
          base.qcow2 &lt;- snap1.qcow2 &lt;- snap2.qcow2
  .Ve
  .Sp
  To enumerate information about each disk image in the above chain, starting from top to base, do:
  .Sp
  .Vb 1
          qemu-img info --backing-chain snap2.qcow2
  .Ve
* **map [-f** _fmt_**] [--output=**_ofmt_**]** _filename_  
  .IX Item "map [-f fmt] [--output=ofmt] filename"
  Dump the metadata of image _filename_ and its backing file chain.
  In particular, this commands dumps the allocation state of every sector
  of _filename_, together with the topmost file that allocates it in
  the backing file chain.
  .Sp
  Two option formats are possible.  The default format (\f(CW`human\*(C')
  only dumps known-nonzero areas of the file.  Known-zero parts of the
  file are omitted altogether, and likewise for parts that are not allocated
  throughout the chain.  **qemu-img** output will identify a file
  from where the data can be read, and the offset in the file.  Each line
  will include four fields, the first three of which are hexadecimal
  numbers.  For example the first line of:
  .Sp
  .Vb 3
          Offset          Length          Mapped to       File
          0               0x20000         0x50000         /tmp/overlay.qcow2
          0x100000        0x10000         0x95380000      /tmp/backing.qcow2
  .Ve
  .Sp
  means that 0x20000 (131072) bytes starting at offset 0 in the image are
  available in /tmp/overlay.qcow2 (opened in \f(CW`raw\*(C' format) starting
  at offset 0x50000 (327680).  Data that is compressed, encrypted, or
  otherwise not available in raw format will cause an error if \f(CW`human\*(C'
  format is in use.  Note that file names can include newlines, thus it is
  not safe to parse this output format in scripts.
  .Sp
  The alternative format \f(CW`json\*(C' will return an array of dictionaries
  in \s-1JSON\s0 format.  It will include similar information in
  the \f(CW`start\*(C', \f(CW\*(C\`length\*(C', \f(CW\*(C\`offset\*(C' fields;
  it will also include other more specific information:
    * whether the sectors contain actual data or not (boolean field \f(CW`data\*(C';
      if false, the sectors are either unallocated or stored as optimized
      all-zero clusters);
    * whether the data is known to read as zero (boolean field \f(CW`zero\*(C');
    * in order to make the output shorter, the target file is expressed as
      a \f(CW`depth\*(C'; for example, a depth of 2 refers to the backing file
      of the backing file of _filename_.
      .Sp
      In \s-1JSON\s0 format, the \f(CW`offset\*(C' field is optional; it is absent in
      cases where \f(CW`human\*(C' format would omit the entry or exit with an error.
      If \f(CW`data\*(C' is false and the \f(CW\*(C\`offset\*(C' field is present, the
      corresponding sectors in the file are not yet in use, but they are
      preallocated.
      .Sp
      For more information, consult _include/block/block.h_ in \s-1QEMU\s0's
      source code.
* **measure [--output=**_ofmt_**] [-O** _output\_fmt_**] [-o** _options_**] [--size** _N_ **| [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [-l** _snapshot\_param_**]** _filename_**]**  
  .IX Item "measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]"
  Calculate the file size required for a new image.  This information can be used
  to size logical volumes or \s-1SAN\s0 LUNs appropriately for the image that will be
  placed in them.  The values reported are guaranteed to be large enough to fit
  the image.  The command can output in the format _ofmt_ which is either
  \f(CW`human\*(C' or \f(CW\*(C\`json\*(C'.
  .Sp
  If the size _N_ is given then act as if creating a new empty image file
  using **qemu-img create**.  If _filename_ is given then act as if
  converting an existing image file using **qemu-img convert**.  The format
  of the new file is given by _output\_fmt_ while the format of an existing
  file is given by _fmt_.
  .Sp
  A snapshot in an existing image can be specified using _snapshot\_param_.
  .Sp
  The following fields are reported:
  .Sp
  .Vb 2
          required size: 524288
          fully allocated size: 1074069504
  .Ve
  .Sp
  The \f(CW`required size\*(C' is the file size of the new image.  It may be smaller
  than the virtual disk size if the image format supports compact representation.
  .Sp
  The \f(CW`fully allocated size\*(C' is the file size of the new image once data has
  been written to all sectors.  This is the maximum size that the image file can
  occupy with the exception of internal snapshots, dirty bitmaps, vmstate data,
  and other advanced image format features.
* **snapshot [--object** _objectdef_**] [--image-opts] [-U] [-q] [-l | -a** _snapshot_ **| -c** _snapshot_ **| -d** _snapshot_**]** _filename_  
  .IX Item "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename"
  List, apply, create or delete snapshots in image _filename_.
* **rebase [--object** _objectdef_**] [--image-opts] [-U] [-q] [-f** _fmt_**] [-t** _cache_**] [-T** _src\_cache_**] [-p] [-u] -b** _backing\_file_ **[-F** _backing\_fmt_**]** _filename_  
  .IX Item "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename"
  Changes the backing file of an image. Only the formats \f(CW`qcow2\*(C' and
  \f(CW`qed\*(C' support changing the backing file.
  .Sp
  The backing file is changed to _backing\_file_ and (if the image format of
  _filename_ supports this) the backing file format is changed to
  _backing\_fmt_. If _backing\_file_ is specified as "" (the empty
  string), then the image is rebased onto no backing file (i.e. it will exist
  independently of any backing file).
  .Sp
  If a relative path name is given, the backing file is looked up relative to
  the directory containing _filename_.
  .Sp
  _cache_ specifies the cache mode to be used for _filename_, whereas
  _src\_cache_ specifies the cache mode for reading backing files.
  .Sp
  There are two different modes in which \f(CW`rebase\*(C' can operate:
    * **Safe mode**  
      .IX Item "Safe mode"
      This is the default mode and performs a real rebase operation. The new backing
      file may differ from the old one and qemu-img rebase will take care of keeping
      the guest-visible content of _filename_ unchanged.
      .Sp
      In order to achieve this, any clusters that differ between _backing\_file_
      and the old backing file of _filename_ are merged into _filename_
      before actually changing the backing file.
      .Sp
      Note that the safe mode is an expensive operation, comparable to converting
      an image. It only works if the old backing file still exists.
    * **Unsafe mode**  
      .IX Item "Unsafe mode"
      qemu-img uses the unsafe mode if \f(CW`-u\*(C' is specified. In this mode, only the
      backing file name and format of _filename_ is changed without any checks
      on the file contents. The user must take care of specifying the correct new
      backing file, or the guest-visible content of the image will be corrupted.
      .Sp
      This mode is useful for renaming or moving the backing file to somewhere else.
      It can be used without an accessible old backing file, i.e. you can use it to
      fix an image whose backing file has already been moved/renamed.
      .Sp
      You can use \f(CW`rebase\*(C' to perform a \*(L"diff\*(R" operation on two
      disk images.  This can be useful when you have copied or cloned
      a guest, and you want to get back to a thin image on top of a
      template or base image.
      .Sp
      Say that \f(CW`base.img\*(C' has been cloned as \f(CW\*(C\`modified.img\*(C' by
      copying it, and that the \f(CW`modified.img\*(C' guest has run so there
      are now some changes compared to \f(CW`base.img\*(C'.  To construct a thin
      image called \f(CW`diff.qcow2\*(C' that contains just the differences, do:
      .Sp
      .Vb 2
              qemu-img create -f qcow2 -b modified.img diff.qcow2
              qemu-img rebase -b base.img diff.qcow2
      .Ve
      .Sp
      At this point, \f(CW`modified.img\*(C' can be discarded, since
      \f(CW`base.img + diff.qcow2\*(C' contains the same information.
* **resize [--object** _objectdef_**] [--image-opts] [-f** _fmt_**] [--preallocation=**_prealloc_**] [-q] [--shrink]** _filename_ **[+ | -]**_size_  
  .IX Item "resize [--object objectdef] [--image-opts] [-f fmt] [--preallocation=prealloc] [-q] [--shrink] filename [+ | -]size"
  Change the disk image as if it had been created with _size_.
  .Sp
  Before using this command to shrink a disk image, you \s-1MUST\s0 use file system and
  partitioning tools inside the \s-1VM\s0 to reduce allocated file systems and partition
  sizes accordingly.  Failure to do so will result in data loss!
  .Sp
  When shrinking images, the \f(CW`--shrink\*(C' option must be given. This informs
  qemu-img that the user acknowledges all loss of data beyond the truncated
  image's end.
  .Sp
  After using this command to grow a disk image, you must use file system and
  partitioning tools inside the \s-1VM\s0 to actually begin using the new space on the
  device.
  .Sp
  When growing an image, the \f(CW`--preallocation\*(C' option may be used to specify
  how the additional image area should be allocated on the host.  See the format
  description in the \f(CW`NOTES\*(C' section which values are allowed.  Using this
  option may result in slightly more data being allocated than necessary.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
Supported image file formats:

* **raw**  
  .IX Item "raw"
  Raw disk image format (default). This format has the advantage of
  being simple and easily exportable to all other emulators. If your
  file system supports _holes_ (for example in ext2 or ext3 on
  Linux or \s-1NTFS\s0 on Windows), then only the written sectors will reserve
  space. Use \f(CW`qemu-img info\*(C' to know the real size used by the
  image or \f(CW`ls -ls\*(C' on Unix/Linux.
  .Sp
  Supported options:
      .ie n .IP """preallocation""" 4
      .el .IP "\f(CWpreallocation" 4
      .IX Item "preallocation"
      Preallocation mode (allowed values: \f(CW`off\*(C', \f(CW\*(C\`falloc\*(C', \f(CW\*(C\`full\*(C').
      \f(CW`falloc\*(C' mode preallocates space for image by calling **posix\_fallocate()**.
      \f(CW`full\*(C' mode preallocates space for image by writing zeros to underlying
      storage.
* **qcow2**  
  .IX Item "qcow2"
  \s-1QEMU\s0 image format, the most versatile format. Use it to have smaller
  images (useful if your filesystem does not supports holes, for example
  on Windows), optional \s-1AES\s0 encryption, zlib based compression and
  support of multiple \s-1VM\s0 snapshots.
  .Sp
  Supported options:
      .ie n .IP """compat""" 4
      .el .IP "\f(CWcompat" 4
      .IX Item "compat"
      Determines the qcow2 version to use. \f(CW`compat=0.10\*(C' uses the
      traditional image format that can be read by any \s-1QEMU\s0 since 0.10.
      \f(CW`compat=1.1\*(C' enables image format extensions that only \s-1QEMU 1.1\s0 and
      newer understand (this is the default). Amongst others, this includes zero
      clusters, which allow efficient copy-on-read for sparse images.
      .ie n .IP """backing_file""" 4
      .el .IP "\f(CWbacking\_file" 4
      .IX Item "backing_file"
      File name of a base image (see **create** subcommand)
      .ie n .IP """backing_fmt""" 4
      .el .IP "\f(CWbacking\_fmt" 4
      .IX Item "backing_fmt"
      Image format of the base image
      .ie n .IP """encryption""" 4
      .el .IP "\f(CWencryption" 4
      .IX Item "encryption"
      If this option is set to \f(CW`on\*(C', the image is encrypted with 128-bit AES-CBC.
      .Sp
      The use of encryption in qcow and qcow2 images is considered to be flawed by
      modern cryptography standards, suffering from a number of design problems:
        * The AES-CBC cipher is used with predictable initialization vectors based
          on the sector number. This makes it vulnerable to chosen plaintext attacks
          which can reveal the existence of encrypted data.
        * The user passphrase is directly used as the encryption key. A poorly
          chosen or short passphrase will compromise the security of the encryption.
        * In the event of the passphrase being compromised there is no way to
          change the passphrase to protect data in any qcow images. The files must
          be cloned, using a different encryption passphrase in the new file. The
          original file must then be securely erased using a program like shred,
          though even this is ineffective with many modern storage technologies.
        * Initialization vectors used to encrypt sectors are based on the
          guest virtual sector number, instead of the host physical sector. When
          a disk image has multiple internal snapshots this means that data in
          multiple physical sectors is encrypted with the same initialization
          vector. With the \s-1CBC\s0 mode, this opens the possibility of watermarking
          attacks if the attack can collect multiple sectors encrypted with the
          same \s-1IV\s0 and some predictable data. Having multiple qcow2 images with
          the same passphrase also exposes this weakness since the passphrase
          is directly used as the key.
          .Sp
          Use of qcow / qcow2 encryption is thus strongly discouraged. Users are
          recommended to use an alternative encryption technology such as the
          Linux dm-crypt / \s-1LUKS\s0 system.
      .ie n .IP """cluster_size""" 4
      .el .IP "\f(CWcluster\_size" 4
      .IX Item "cluster_size"
      Changes the qcow2 cluster size (must be between 512 and 2M). Smaller cluster
      sizes can improve the image file size whereas larger cluster sizes generally
      provide better performance.
      .ie n .IP """preallocation""" 4
      .el .IP "\f(CWpreallocation" 4
      .IX Item "preallocation"
      Preallocation mode (allowed values: \f(CW`off\*(C', \f(CW\*(C\`metadata\*(C', \f(CW\*(C\`falloc\*(C',
      \f(CW`full\*(C'). An image with preallocated metadata is initially larger but can
      improve performance when the image needs to grow. \f(CW`falloc\*(C' and \f(CW\*(C\`full\*(C'
      preallocations are like the same options of \f(CW`raw\*(C' format, but sets up
      metadata also.
      .ie n .IP """lazy_refcounts""" 4
      .el .IP "\f(CWlazy\_refcounts" 4
      .IX Item "lazy_refcounts"
      If this option is set to \f(CW`on\*(C', reference count updates are postponed with
      the goal of avoiding metadata I/O and improving performance. This is
      particularly interesting with **cache=writethrough** which doesn't batch
      metadata updates. The tradeoff is that after a host crash, the reference count
      tables must be rebuilt, i.e. on the next open an (automatic) \f(CW`qemu-img
      check -r all is required, which may take some time.
      .Sp
      This option can only be enabled if \f(CW`compat=1.1\*(C' is specified.
      .ie n .IP """nocow""" 4
      .el .IP "\f(CWnocow" 4
      .IX Item "nocow"
      If this option is set to \f(CW`on\*(C', it will turn off \s-1COW\s0 of the file. It's only
      valid on btrfs, no effect on other file systems.
      .Sp
      Btrfs has low performance when hosting a \s-1VM\s0 image file, even more when the guest
      on the \s-1VM\s0 also using btrfs as file system. Turning off \s-1COW\s0 is a way to mitigate
      this bad performance. Generally there are two ways to turn off \s-1COW\s0 on btrfs:
      a) Disable it by mounting with nodatacow, then all newly created files will be
      \s-1NOCOW.\s0 b) For an empty file, add the \s-1NOCOW\s0 file attribute. That's what this option
      does.
      .Sp
      Note: this option is only valid to new or empty files. If there is an existing
      file which is \s-1COW\s0 and has data blocks already, it couldn't be changed to \s-1NOCOW\s0
      by setting \f(CW`nocow=on\*(C'. One can issue \f(CW\*(C\`lsattr filename\*(C' to check if
      the \s-1NOCOW\s0 flag is set or not (Capital 'C' is \s-1NOCOW\s0 flag).
* **Other**  
  .IX Item "Other"
  \s-1QEMU\s0 also supports various other image file formats for compatibility with
  older \s-1QEMU\s0 versions or other hypervisors, including \s-1VMDK, VDI, VHD\s0 (vpc), \s-1VHDX,\s0
  qcow1 and \s-1QED.\s0 For a full list of supported formats see \f(CW`qemu-img --help\*(C'.
  For a more detailed description of these formats, see the \s-1QEMU\s0 Emulation User
  Documentation.
  .Sp
  The main purpose of the block drivers for these formats is image conversion.
  For running VMs, it is recommended to convert the disk images to either raw or
  qcow2 in order to achieve good performance.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
The \s-1HTML\s0 documentation of \s-1QEMU\s0 for more precise information and Linux
user mode emulator invocation.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Fabrice Bellard
