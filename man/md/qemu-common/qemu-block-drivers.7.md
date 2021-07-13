# qemu-block-drivers.7(7)

 , 2019-08-14

.if n .ad l
.nh

<a name="name"></a>

# Name

qemu-block-drivers - QEMU block drivers reference

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" \s-1QEMU\s0 block driver reference manual
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
_Disk image file formats_
.IX Subsection "Disk image file formats"

\s-1QEMU\s0 supports many image file formats that can be used with VMs as well as with
any of the tools (like \f(CW`qemu-img\*(C'). This includes the preferred formats
raw and qcow2 as well as formats that are supported for compatibility with
older \s-1QEMU\s0 versions or other hypervisors.

Depending on the image format, different options can be passed to
\f(CW`qemu-img create\*(C' and \f(CW\*(C\`qemu-img convert\*(C' using the \f(CW\*(C\`-o\*(C' option.
This section describes each format and the options that are supported for it.

* **raw**  
  .IX Item "raw"
  Raw disk image format. This format has the advantage of
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
  on Windows), zlib based compression and support of multiple \s-1VM\s0
  snapshots.
  .Sp
  Supported options:
      .ie n .IP """compat""" 4
      .el .IP "\f(CWcompat" 4
      .IX Item "compat"
      Determines the qcow2 version to use. \f(CW`compat=0.10\*(C' uses the
      traditional image format that can be read by any \s-1QEMU\s0 since 0.10.
      \f(CW`compat=1.1\*(C' enables image format extensions that only \s-1QEMU 1.1\s0 and
      newer understand (this is the default). Amongst others, this includes
      zero clusters, which allow efficient copy-on-read for sparse images.
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
      This option is deprecated and equivalent to \f(CW`encrypt.format=aes\*(C'
      .ie n .IP """encrypt.format""" 4
      .el .IP "\f(CWencrypt.format" 4
      .IX Item "encrypt.format"
      If this is set to \f(CW`luks\*(C', it requests that the qcow2 payload (not
      qcow2 header) be encrypted using the \s-1LUKS\s0 format. The passphrase to
      use to unlock the \s-1LUKS\s0 key slot is given by the \f(CW`encrypt.key-secret\*(C'
      parameter. \s-1LUKS\s0 encryption parameters can be tuned with the other
      \f(CW`encrypt.*\*(C' parameters.
      .Sp
      If this is set to \f(CW`aes\*(C', the image is encrypted with 128-bit AES-CBC.
      The encryption key is given by the \f(CW`encrypt.key-secret\*(C' parameter.
      This encryption format is considered to be flawed by modern cryptography
      standards, suffering from a number of design problems:
        * -&lt;The AES-CBC cipher is used with predictable initialization vectors based&gt;  
          .IX Item "-&lt;The AES-CBC cipher is used with predictable initialization vectors based&gt;"
          on the sector number. This makes it vulnerable to chosen plaintext attacks
          which can reveal the existence of encrypted data.
        * -&lt;The user passphrase is directly used as the encryption key. A poorly&gt;  
          .IX Item "-&lt;The user passphrase is directly used as the encryption key. A poorly&gt;"
          chosen or short passphrase will compromise the security of the encryption.
        * -&lt;In the event of the passphrase being compromised there is no way to&gt;  
          .IX Item "-&lt;In the event of the passphrase being compromised there is no way to&gt;"
          change the passphrase to protect data in any qcow images. The files must
          be cloned, using a different encryption passphrase in the new file. The
          original file must then be securely erased using a program like shred,
          though even this is ineffective with many modern storage technologies.
          .Sp
          The use of this is no longer supported in system emulators. Support only
          remains in the command line utilities, for the purposes of data liberation
          and interoperability with old versions of \s-1QEMU.\s0 The \f(CW`luks\*(C' format
          should be used instead.
      .ie n .IP """encrypt.key-secret""" 4
      .el .IP "\f(CWencrypt.key-secret" 4
      .IX Item "encrypt.key-secret"
      Provides the \s-1ID\s0 of a \f(CW`secret\*(C' object that contains the passphrase
      (\f(CW`encrypt.format=luks\*(C') or encryption key (\f(CW\*(C\`encrypt.format=aes\*(C').
      .ie n .IP """encrypt.cipher-alg""" 4
      .el .IP "\f(CWencrypt.cipher-alg" 4
      .IX Item "encrypt.cipher-alg"
      Name of the cipher algorithm and key length. Currently defaults
      to \f(CW`aes-256\*(C'. Only used when \f(CW\*(C\`encrypt.format=luks\*(C'.
      .ie n .IP """encrypt.cipher-mode""" 4
      .el .IP "\f(CWencrypt.cipher-mode" 4
      .IX Item "encrypt.cipher-mode"
      Name of the encryption mode to use. Currently defaults to \f(CW`xts\*(C'.
      Only used when \f(CW`encrypt.format=luks\*(C'.
      .ie n .IP """encrypt.ivgen-alg""" 4
      .el .IP "\f(CWencrypt.ivgen-alg" 4
      .IX Item "encrypt.ivgen-alg"
      Name of the initialization vector generator algorithm. Currently defaults
      to \f(CW`plain64\*(C'. Only used when \f(CW\*(C\`encrypt.format=luks\*(C'.
      .ie n .IP """encrypt.ivgen-hash-alg""" 4
      .el .IP "\f(CWencrypt.ivgen-hash-alg" 4
      .IX Item "encrypt.ivgen-hash-alg"
      Name of the hash algorithm to use with the initialization vector generator
      (if required). Defaults to \f(CW`sha256\*(C'. Only used when \f(CW\*(C\`encrypt.format=luks\*(C'.
      .ie n .IP """encrypt.hash-alg""" 4
      .el .IP "\f(CWencrypt.hash-alg" 4
      .IX Item "encrypt.hash-alg"
      Name of the hash algorithm to use for \s-1PBKDF\s0 algorithm
      Defaults to \f(CW`sha256\*(C'. Only used when \f(CW\*(C\`encrypt.format=luks\*(C'.
      .ie n .IP """encrypt.iter-time""" 4
      .el .IP "\f(CWencrypt.iter-time" 4
      .IX Item "encrypt.iter-time"
      Amount of time, in milliseconds, to use for \s-1PBKDF\s0 algorithm per key slot.
      Defaults to \f(CW2000. Only used when \f(CW`encrypt.format=luks\*(C'.
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
* **qed**  
  .IX Item "qed"
  Old \s-1QEMU\s0 image format with support for backing files and compact image files
  (when your filesystem or transport medium does not support holes).
  .Sp
  When converting \s-1QED\s0 images to qcow2, you might want to consider using the
  \f(CW`lazy\_refcounts=on\*(C' option to get a more QED-like behaviour.
  .Sp
  Supported options:
      .ie n .IP """backing_file""" 4
      .el .IP "\f(CWbacking\_file" 4
      .IX Item "backing_file"
      File name of a base image (see **create** subcommand).
      .ie n .IP """backing_fmt""" 4
      .el .IP "\f(CWbacking\_fmt" 4
      .IX Item "backing_fmt"
      Image file format of backing file (optional).  Useful if the format cannot be
      autodetected because it has no header, like some vhd/vpc files.
      .ie n .IP """cluster_size""" 4
      .el .IP "\f(CWcluster\_size" 4
      .IX Item "cluster_size"
      Changes the cluster size (must be power-of-2 between 4K and 64K). Smaller
      cluster sizes can improve the image file size whereas larger cluster sizes
      generally provide better performance.
      .ie n .IP """table_size""" 4
      .el .IP "\f(CWtable\_size" 4
      .IX Item "table_size"
      Changes the number of clusters per L1/L2 table (must be power-of-2 between 1
      and 16).  There is normally no need to change this value but this option can be
      used for performance benchmarking.
* **qcow**  
  .IX Item "qcow"
  Old \s-1QEMU\s0 image format with support for backing files, compact image files,
  encryption and compression.
  .Sp
  Supported options:
      .ie n .IP """backing_file""" 4
      .el .IP "\f(CWbacking\_file" 4
      .IX Item "backing_file"
      File name of a base image (see **create** subcommand)
      .ie n .IP """encryption""" 4
      .el .IP "\f(CWencryption" 4
      .IX Item "encryption"
      This option is deprecated and equivalent to \f(CW`encrypt.format=aes\*(C'
      .ie n .IP """encrypt.format""" 4
      .el .IP "\f(CWencrypt.format" 4
      .IX Item "encrypt.format"
      If this is set to \f(CW`aes\*(C', the image is encrypted with 128-bit AES-CBC.
      The encryption key is given by the \f(CW`encrypt.key-secret\*(C' parameter.
      This encryption format is considered to be flawed by modern cryptography
      standards, suffering from a number of design problems enumerated previously
      against the \f(CW`qcow2\*(C' image format.
      .Sp
      The use of this is no longer supported in system emulators. Support only
      remains in the command line utilities, for the purposes of data liberation
      and interoperability with old versions of \s-1QEMU.\s0
      .Sp
      Users requiring native encryption should use the \f(CW`qcow2\*(C' format
      instead with \f(CW`encrypt.format=luks\*(C'.
      .ie n .IP """encrypt.key-secret""" 4
      .el .IP "\f(CWencrypt.key-secret" 4
      .IX Item "encrypt.key-secret"
      Provides the \s-1ID\s0 of a \f(CW`secret\*(C' object that contains the encryption
      key (\f(CW`encrypt.format=aes\*(C').
* **luks**  
  .IX Item "luks"
  \s-1LUKS\s0 v1 encryption format, compatible with Linux dm-crypt/cryptsetup
  .Sp
  Supported options:
      .ie n .IP """key-secret""" 4
      .el .IP "\f(CWkey-secret" 4
      .IX Item "key-secret"
      Provides the \s-1ID\s0 of a \f(CW`secret\*(C' object that contains the passphrase.
      .ie n .IP """cipher-alg""" 4
      .el .IP "\f(CWcipher-alg" 4
      .IX Item "cipher-alg"
      Name of the cipher algorithm and key length. Currently defaults
      to \f(CW`aes-256\*(C'.
      .ie n .IP """cipher-mode""" 4
      .el .IP "\f(CWcipher-mode" 4
      .IX Item "cipher-mode"
      Name of the encryption mode to use. Currently defaults to \f(CW`xts\*(C'.
      .ie n .IP """ivgen-alg""" 4
      .el .IP "\f(CWivgen-alg" 4
      .IX Item "ivgen-alg"
      Name of the initialization vector generator algorithm. Currently defaults
      to \f(CW`plain64\*(C'.
      .ie n .IP """ivgen-hash-alg""" 4
      .el .IP "\f(CWivgen-hash-alg" 4
      .IX Item "ivgen-hash-alg"
      Name of the hash algorithm to use with the initialization vector generator
      (if required). Defaults to \f(CW`sha256\*(C'.
      .ie n .IP """hash-alg""" 4
      .el .IP "\f(CWhash-alg" 4
      .IX Item "hash-alg"
      Name of the hash algorithm to use for \s-1PBKDF\s0 algorithm
      Defaults to \f(CW`sha256\*(C'.
      .ie n .IP """iter-time""" 4
      .el .IP "\f(CWiter-time" 4
      .IX Item "iter-time"
      Amount of time, in milliseconds, to use for \s-1PBKDF\s0 algorithm per key slot.
      Defaults to \f(CW2000.
* **vdi**  
  .IX Item "vdi"
  VirtualBox 1.1 compatible image format.
  Supported options:
      .ie n .IP """static""" 4
      .el .IP "\f(CWstatic" 4
      .IX Item "static"
      If this option is set to \f(CW`on\*(C', the image is created with metadata
      preallocation.
* **vmdk**  
  .IX Item "vmdk"
  VMware 3 and 4 compatible image format.
  .Sp
  Supported options:
      .ie n .IP """backing_file""" 4
      .el .IP "\f(CWbacking\_file" 4
      .IX Item "backing_file"
      File name of a base image (see **create** subcommand).
      .ie n .IP """compat6""" 4
      .el .IP "\f(CWcompat6" 4
      .IX Item "compat6"
      Create a \s-1VMDK\s0 version 6 image (instead of version 4)
      .ie n .IP """hwversion""" 4
      .el .IP "\f(CWhwversion" 4
      .IX Item "hwversion"
      Specify vmdk virtual hardware version. Compat6 flag cannot be enabled
      if hwversion is specified.
      .ie n .IP """subformat""" 4
      .el .IP "\f(CWsubformat" 4
      .IX Item "subformat"
      Specifies which \s-1VMDK\s0 subformat to use. Valid options are
      \f(CW`monolithicSparse\*(C' (default),
      \f(CW`monolithicFlat\*(C',
      \f(CW`twoGbMaxExtentSparse\*(C',
      \f(CW`twoGbMaxExtentFlat\*(C' and
      \f(CW`streamOptimized\*(C'.
* **vpc**  
  .IX Item "vpc"
  VirtualPC compatible image format (\s-1VHD\s0).
  Supported options:
      .ie n .IP """subformat""" 4
      .el .IP "\f(CWsubformat" 4
      .IX Item "subformat"
      Specifies which \s-1VHD\s0 subformat to use. Valid options are
      \f(CW`dynamic\*(C' (default) and \f(CW\*(C\`fixed\*(C'.
* **\s-1VHDX\s0**  
  .IX Item "VHDX"
  Hyper-V compatible image format (\s-1VHDX\s0).
  Supported options:
      .ie n .IP """subformat""" 4
      .el .IP "\f(CWsubformat" 4
      .IX Item "subformat"
      Specifies which \s-1VHDX\s0 subformat to use. Valid options are
      \f(CW`dynamic\*(C' (default) and \f(CW\*(C\`fixed\*(C'.
      .ie n .IP """block_state_zero""" 4
      .el .IP "\f(CWblock\_state\_zero" 4
      .IX Item "block_state_zero"
      Force use of payload blocks of type '\s-1ZERO\s0'.  Can be set to \f(CW`on\*(C' (default)
      or \f(CW`off\*(C'.  When set to \f(CW\*(C\`off\*(C', new blocks will be created as
      \f(CW`PAYLOAD\_BLOCK\_NOT\_PRESENT\*(C', which means parsers are free to return
      arbitrary data for those blocks.  Do not set to \f(CW`off\*(C' when using
      \f(CW`qemu-img convert\*(C' with \f(CW\*(C\`subformat=dynamic\*(C'.
      .ie n .IP """block_size""" 4
      .el .IP "\f(CWblock\_size" 4
      .IX Item "block_size"
      Block size; min 1 \s-1MB,\s0 max 256 \s-1MB.\s0  0 means auto-calculate based on image size.
      .ie n .IP """log_size""" 4
      .el .IP "\f(CWlog\_size" 4
      .IX Item "log_size"
      Log size; min 1 \s-1MB.\s0

Read-only formats
.IX Subsection "Read-only formats"

More disk image file formats are supported in a read-only mode.

* **bochs**  
  .IX Item "bochs"
  Bochs images of \f(CW`growing\*(C' type.
* **cloop**  
  .IX Item "cloop"
  Linux Compressed Loop image, useful only to reuse directly compressed
  CD-ROM images present for example in the Knoppix CD-ROMs.
* **dmg**  
  .IX Item "dmg"
  Apple disk image.
* **parallels**  
  .IX Item "parallels"
  Parallels disk image format.

_Using host drives_
.IX Subsection "Using host drives"

In addition to disk image files, \s-1QEMU\s0 can directly access host
devices. We describe here the usage for \s-1QEMU\s0 version &gt;= 0.8.3.

Linux
.IX Subsection "Linux"

On Linux, you can directly use the host device filename instead of a
disk image filename provided you have enough privileges to access
it. For example, use _/dev/cdrom_ to access to the \s-1CDROM.\s0
.ie n .IP """CD""" 4
.el .IP "\f(CWCD" 4
.IX Item "CD"
You can specify a \s-1CDROM\s0 device even if no \s-1CDROM\s0 is loaded. \s-1QEMU\s0 has
specific code to detect \s-1CDROM\s0 insertion or removal. \s-1CDROM\s0 ejection by
the guest \s-1OS\s0 is supported. Currently only data CDs are supported.
.ie n .IP """Floppy""" 4
.el .IP "\f(CWFloppy" 4
.IX Item "Floppy"
You can specify a floppy device even if no floppy is loaded. Floppy
removal is currently not detected accurately (if you change floppy
without doing floppy access while the floppy is not loaded, the guest
\s-1OS\s0 will think that the same floppy is loaded).
Use of the host's floppy device is deprecated, and support for it will
be removed in a future release.
.ie n .IP """Hard disks""" 4
.el .IP "\f(CWHard disks" 4
.IX Item "Hard disks"
Hard disks can be used. Normally you must specify the whole disk
(_/dev/hdb_ instead of _/dev/hdb1_) so that the guest \s-1OS\s0 can
see it as a partitioned disk. \s-1WARNING:\s0 unless you know what you do, it
is better to only make READ-ONLY accesses to the hard disk otherwise
you may corrupt your host data (use the **-snapshot** command
line option or modify the device permissions accordingly).

Windows
.IX Subsection "Windows"
.ie n .IP """CD""" 4
.el .IP "\f(CWCD" 4
.IX Item "CD"
The preferred syntax is the drive letter (e.g. _d:_). The
alternate syntax _\e\e.\ed:_ is supported. _/dev/cdrom_ is
supported as an alias to the first \s-1CDROM\s0 drive.
.Sp
Currently there is no specific code to handle removable media, so it
is better to use the \f(CW`change\*(C' or \f(CW\*(C\`eject\*(C' monitor commands to
change or eject media.
.ie n .IP """Hard disks""" 4
.el .IP "\f(CWHard disks" 4
.IX Item "Hard disks"
Hard disks can be used with the syntax: _\e\e.\ePhysicalDriveN_
where _N_ is the drive number (0 is the first hard disk).
.Sp
\s-1WARNING:\s0 unless you know what you do, it is better to only make
READ-ONLY accesses to the hard disk otherwise you may corrupt your
host data (use the **-snapshot** command line so that the
modifications are written in a temporary file).

Mac \s-1OS X\s0
.IX Subsection "Mac OS X"

_/dev/cdrom_ is an alias to the first \s-1CDROM.\s0

Currently there is no specific code to handle removable media, so it
is better to use the \f(CW`change\*(C' or \f(CW\*(C\`eject\*(C' monitor commands to
change or eject media.

_Virtual \s-1FAT\s0 disk images_
.IX Subsection "Virtual FAT disk images"

\s-1QEMU\s0 can automatically create a virtual \s-1FAT\s0 disk image from a
directory tree. In order to use it, just type:

.Vb 1
        qemu-system-i386 linux.img -hdb fat:/my_directory
.Ve

Then you access access to all the files in the _/my\_directory_
directory without having to copy them in a disk image or to export
them via \s-1SAMBA\s0 or \s-1NFS.\s0 The default access is _read-only_.

Floppies can be emulated with the \f(CW`:floppy:\*(C' option:

.Vb 1
        qemu-system-i386 linux.img -fda fat:floppy:/my_directory
.Ve

A read/write support is available for testing (beta stage) with the
\f(CW`:rw:\*(C' option:

.Vb 1
        qemu-system-i386 linux.img -fda fat:floppy:rw:/my_directory
.Ve

What you should _never_ do:

* *&lt;use non-ASCII filenames ;&gt;  
  .IX Item "*&lt;use non-ASCII filenames ;&gt;"
  .ie n .IP "*&lt;use ""-snapshot"" together with "":rw:"" ;&gt;" 4
  .el .IP "*&lt;use \`\`-snapshot'' together with \`\`:rw:'' ;&gt;" 4
  .IX Item "*&lt;use -snapshot together with :rw: ;&gt;"
* *&lt;expect it to work when loadvm'ing ;&gt;  
  .IX Item "*&lt;expect it to work when loadvm'ing ;&gt;"
* *&lt;write to the \s-1FAT\s0 directory on the host system while accessing it with the guest system.&gt;  
  .IX Item "*&lt;write to the FAT directory on the host system while accessing it with the guest system.&gt;"

_\s-1NBD\s0 access_
.IX Subsection "NBD access"

\s-1QEMU\s0 can access directly to block device exported using the Network Block Device
protocol.

.Vb 1
        qemu-system-i386 linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
.Ve

If the \s-1NBD\s0 server is located on the same host, you can use an unix socket instead
of an inet socket:

.Vb 1
        qemu-system-i386 linux.img -hdb nbd+unix://?socket=/tmp/my_socket
.Ve

In this case, the block device must be exported using qemu-nbd:

.Vb 1
        qemu-nbd --socket=/tmp/my_socket my_disk.qcow2
.Ve

The use of qemu-nbd allows sharing of a disk between several guests:

.Vb 1
        qemu-nbd --socket=/tmp/my_socket --share=2 my_disk.qcow2
.Ve

and then you can use it with two guests:

.Vb 2
        qemu-system-i386 linux1.img -hdb nbd+unix://?socket=/tmp/my_socket
        qemu-system-i386 linux2.img -hdb nbd+unix://?socket=/tmp/my_socket
.Ve

If the nbd-server uses named exports (supported since \s-1NBD 2.9.18,\s0 or with \s-1QEMU\s0's
own embedded \s-1NBD\s0 server), you must specify an export name in the \s-1URI:\s0

.Vb 2
        qemu-system-i386 -cdrom nbd://localhost/debian-500-ppc-netinst
        qemu-system-i386 -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
.Ve

The \s-1URI\s0 syntax for \s-1NBD\s0 is supported since \s-1QEMU 1.3.\s0  An alternative syntax is
also available.  Here are some example of the older syntax:

.Vb 3
        qemu-system-i386 linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
        qemu-system-i386 linux2.img -hdb nbd:unix:/tmp/my_socket
        qemu-system-i386 -cdrom nbd:localhost:10809:exportname=debian-500-ppc-netinst
.Ve

_Sheepdog disk images_
.IX Subsection "Sheepdog disk images"

Sheepdog is a distributed storage system for \s-1QEMU.\s0  It provides highly
available block level storage volumes that can be attached to
QEMU-based virtual machines.

You can create a Sheepdog disk image with the command:

.Vb 1
        qemu-img create sheepdog:///&lt;image&gt; &lt;size&gt;
.Ve

where _image_ is the Sheepdog image name and _size_ is its
size.

To import the existing _filename_ to Sheepdog, you can use a
convert command.

.Vb 1
        qemu-img convert &lt;filename&gt; sheepdog:///&lt;image&gt;
.Ve

You can boot from the Sheepdog disk image with the command:

.Vb 1
        qemu-system-i386 sheepdog:///&lt;image&gt;
.Ve

You can also create a snapshot of the Sheepdog image like qcow2.

.Vb 1
        qemu-img snapshot -c &lt;tag&gt; sheepdog:///&lt;image&gt;
.Ve

where _tag_ is a tag name of the newly created snapshot.

To boot from the Sheepdog snapshot, specify the tag name of the
snapshot.

.Vb 1
        qemu-system-i386 sheepdog:///&lt;image&gt;#&lt;tag&gt;
.Ve

You can create a cloned image from the existing snapshot.

.Vb 1
        qemu-img create -b sheepdog:///&lt;base&gt;#&lt;tag&gt; sheepdog:///&lt;image&gt;
.Ve

where _base_ is an image name of the source snapshot and _tag_
is its tag name.

You can use an unix socket instead of an inet socket:

.Vb 1
        qemu-system-i386 sheepdog+unix:///&lt;image&gt;?socket=&lt;path&gt;
.Ve

If the Sheepdog daemon doesn't run on the local host, you need to
specify one of the Sheepdog servers to connect to.

.Vb 2
        qemu-img create sheepdog://&lt;hostname&gt;:&lt;port&gt;/&lt;image&gt; &lt;size&gt;
        qemu-system-i386 sheepdog://&lt;hostname&gt;:&lt;port&gt;/&lt;image&gt;
.Ve

_iSCSI LUNs_
.IX Subsection "iSCSI LUNs"

iSCSI is a popular protocol used to access \s-1SCSI\s0 devices across a computer
network.

There are two different ways iSCSI devices can be used by \s-1QEMU.\s0

The first method is to mount the iSCSI \s-1LUN\s0 on the host, and make it appear as
any other ordinary \s-1SCSI\s0 device on the host and then to access this device as a
/dev/sd device from \s-1QEMU.\s0 How to do this differs between host OSes.

The second method involves using the iSCSI initiator that is built into
\s-1QEMU.\s0 This provides a mechanism that works the same way regardless of which
host \s-1OS\s0 you are running \s-1QEMU\s0 on. This section will describe this second method
of using iSCSI together with \s-1QEMU.\s0

In \s-1QEMU,\s0 iSCSI devices are described using special iSCSI URLs

.Vb 2
        URL syntax:
        iscsi://[&lt;username&gt;[%&lt;password&gt;]@]&lt;host&gt;[:&lt;port&gt;]/&lt;target-iqn-name&gt;/&lt;lun&gt;
.Ve

Username and password are optional and only used if your target is set up
using \s-1CHAP\s0 authentication for access control.
Alternatively the username and password can also be set via environment
variables to have these not show up in the process list

.Vb 3
        export LIBISCSI_CHAP_USERNAME=&lt;username&gt;
        export LIBISCSI_CHAP_PASSWORD=&lt;password&gt;
        iscsi://&lt;host&gt;/&lt;target-iqn-name&gt;/&lt;lun&gt;
.Ve

Various session related parameters can be set via special options, either
in a configuration file provided via '-readconfig' or directly on the
command line.

If the initiator-name is not specified qemu will use a default name
of 'iqn.2008-11.org.linux-kvm[:&lt;uuid&gt;'] where &lt;uuid&gt; is the \s-1UUID\s0 of the
virtual machine. If the \s-1UUID\s0 is not specified qemu will use
'iqn.2008-11.org.linux-kvm[:&lt;name&gt;'] where &lt;name&gt; is the name of the
virtual machine.

.Vb 2
        Setting a specific initiator name to use when logging in to the target
        -iscsi initiator-name=iqn.qemu.test:my-initiator


        
        Controlling which type of header digest to negotiate with the target
        -iscsi header-digest=CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
.Ve

These can also be set via a configuration file

.Vb 6
        [iscsi]
          user = "CHAP username"
          password = "CHAP password"
          initiator-name = "iqn.qemu.test:my-initiator"
          # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
          header-digest = "CRC32C"
.Ve

Setting the target name allows different options for different targets

.Vb 6
        [iscsi "iqn.target.name"]
          user = "CHAP username"
          password = "CHAP password"
          initiator-name = "iqn.qemu.test:my-initiator"
          # header digest is one of CRC32C|CRC32C-NONE|NONE-CRC32C|NONE
          header-digest = "CRC32C"
.Ve

Howto use a configuration file to set iSCSI configuration options:

.Vb 7
        cat &gt;iscsi.conf &lt;&lt;EOF
        [iscsi]
          user = "me"
          password = "my password"
          initiator-name = "iqn.qemu.test:my-initiator"
          header-digest = "CRC32C"
        EOF
        
        qemu-system-i386 -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \e
            -readconfig iscsi.conf
.Ve

Howto set up a simple iSCSI target on loopback and accessing it via \s-1QEMU:\s0

.Vb 3
        This example shows how to set up an iSCSI target with one CDROM and one DISK
        using the Linux STGT software target. This target is available on Red Hat based
        systems as the package scsi-target-utils\*(Aq.
        
        tgtd --iscsi portal=127.0.0.1:3260
        tgtadm --lld iscsi --op new --mode target --tid 1 -T iqn.qemu.test
        tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1 \e
            -b /IMAGES/disk.img --device-type=disk
        tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2 \e
            -b /IMAGES/cd.iso --device-type=cd
        tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
        
        qemu-system-i386 -iscsi initiator-name=iqn.qemu.test:my-initiator \e
            -boot d -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \e
            -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
.Ve

_GlusterFS disk images_
.IX Subsection "GlusterFS disk images"

GlusterFS is a user space distributed file system.

You can boot from the GlusterFS disk image with the command:

.Vb 3
        URI:
        qemu-system-x86_64 -drive file=gluster[+&lt;type&gt;]://[&lt;host&gt;[:&lt;port&gt;]]/&lt;volume&gt;/&lt;path&gt;
                                       [?socket=...][,file.debug=9][,file.logfile=...]
        
        JSON:
        qemu-system-x86_64 json:{"driver":"qcow2",
                                   "file":{"driver":"gluster",
                                            "volume":"testvol","path":"a.img","debug":9,"logfile":"...",
                                            "server":[{"type":"tcp","host":"...","port":"..."},
                                                      {"type":"unix","socket":"..."}]}}
.Ve

_gluster_ is the protocol.

_type_ specifies the transport type used to connect to gluster
management daemon (glusterd). Valid transport types are
tcp and unix. In the \s-1URI\s0 form, if a transport type isn't specified,
then tcp type is assumed.

_host_ specifies the server where the volume file specification for
the given volume resides. This can be either a hostname or an ipv4 address.
If transport type is unix, then _host_ field should not be specified.
Instead _socket_ field needs to be populated with the path to unix domain
socket.

_port_ is the port number on which glusterd is listening. This is optional
and if not specified, it defaults to port 24007. If the transport type is unix,
then _port_ should not be specified.

_volume_ is the name of the gluster volume which contains the disk image.

_path_ is the path to the actual disk image that resides on gluster volume.

_debug_ is the logging level of the gluster protocol driver. Debug levels
are 0-9, with 9 being the most verbose, and 0 representing no debugging output.
The default level is 4. The current logging levels defined in the gluster source
are 0 - None, 1 - Emergency, 2 - Alert, 3 - Critical, 4 - Error, 5 - Warning,
6 - Notice, 7 - Info, 8 - Debug, 9 - Trace

_logfile_ is a commandline option to mention log file path which helps in
logging to the specified file and also help in persisting the gfapi logs. The
default is stderr.

You can create a GlusterFS disk image with the command:

.Vb 1
        qemu-img create gluster://&lt;host&gt;/&lt;volume&gt;/&lt;path&gt; &lt;size&gt;
.Ve

Examples

.Vb 10
        qemu-system-x86_64 -drive file=gluster://1.2.3.4/testvol/a.img
        qemu-system-x86_64 -drive file=gluster+tcp://1.2.3.4/testvol/a.img
        qemu-system-x86_64 -drive file=gluster+tcp://1.2.3.4:24007/testvol/dir/a.img
        qemu-system-x86_64 -drive file=gluster+tcp://[1:2:3:4:5:6:7:8]/testvol/dir/a.img
        qemu-system-x86_64 -drive file=gluster+tcp://[1:2:3:4:5:6:7:8]:24007/testvol/dir/a.img
        qemu-system-x86_64 -drive file=gluster+tcp://server.domain.com:24007/testvol/dir/a.img
        qemu-system-x86_64 -drive file=gluster+unix:///testvol/dir/a.img?socket=/tmp/glusterd.socket
        qemu-system-x86_64 -drive file=gluster+rdma://1.2.3.4:24007/testvol/a.img
        qemu-system-x86_64 -drive file=gluster://1.2.3.4/testvol/a.img,file.debug=9,file.logfile=/var/log/qemu-gluster.log
        qemu-system-x86_64 json:{"driver":"qcow2",
                                   "file":{"driver":"gluster",
                                            "volume":"testvol","path":"a.img",
                                            "debug":9,"logfile":"/var/log/qemu-gluster.log",
                                            "server":[{"type":"tcp","host":"1.2.3.4","port":24007},
                                                      {"type":"unix","socket":"/var/run/glusterd.socket"}]}}
        qemu-system-x86_64 -drive driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
                                               file.debug=9,file.logfile=/var/log/qemu-gluster.log,
                                               file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
                                               file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
.Ve

_Secure Shell (ssh) disk images_
.IX Subsection "Secure Shell (ssh) disk images"

You can access disk images located on a remote ssh server
by using the ssh protocol:

.Vb 1
        qemu-system-x86_64 -drive file=ssh://[&lt;user&gt;@]&lt;server&gt;[:&lt;port&gt;]/&lt;path&gt;[?host_key_check=&lt;host_key_check&gt;]
.Ve

Alternative syntax using properties:

.Vb 1
        qemu-system-x86_64 -drive file.driver=ssh[,file.user=&lt;user&gt;],file.host=&lt;server&gt;[,file.port=&lt;port&gt;],file.path=&lt;path&gt;[,file.host_key_check=&lt;host_key_check&gt;]
.Ve

_ssh_ is the protocol.

_user_ is the remote user.  If not specified, then the local
username is tried.

_server_ specifies the remote ssh server.  Any ssh server can be
used, but it must implement the sftp-server protocol.  Most Unix/Linux
systems should work without requiring any extra configuration.

_port_ is the port number on which sshd is listening.  By default
the standard ssh port (22) is used.

_path_ is the path to the disk image.

The optional _host\_key\_check_ parameter controls how the remote
host's key is checked.  The default is \f(CW`yes\*(C' which means to use
the local _.ssh/known\_hosts_ file.  Setting this to \f(CW`no\*(C'
turns off known-hosts checking.  Or you can check that the host key
matches a specific fingerprint:
\f(CW`host\_key\_check=md5:78:45:8e:14:57:4f:d5:45:83:0a:0e:f3:49:82:c9:c8\*(C'
(\f(CW`sha1:\*(C' can also be used as a prefix, but note that OpenSSH
tools only use \s-1MD5\s0 to print fingerprints).

Currently authentication must be done using ssh-agent.  Other
authentication methods may be supported in future.

Note: Many ssh servers do not support an \f(CW`fsync\*(C'-style operation.
The ssh driver cannot guarantee that disk flush requests are
obeyed, and this causes a risk of disk corruption if the remote
server or network goes down during writes.  The driver will
print a warning when \f(CW`fsync\*(C' is not supported:

warning: ssh server \f(CW`ssh.example.com:22\*(C' does not support fsync

With sufficiently new versions of libssh2 and OpenSSH, \f(CW`fsync\*(C' is
supported.

_NVMe disk images_
.IX Subsection "NVMe disk images"

\s-1NVM\s0 Express (NVMe) storage controllers can be accessed directly by a userspace
driver in \s-1QEMU.\s0  This bypasses the host kernel file system and block layers
while retaining \s-1QEMU\s0 block layer functionalities, such as block jobs, I/O
throttling, image formats, etc.  Disk I/O performance is typically higher than
with \f(CW`-drive file=/dev/sda\*(C' using either thread pool or linux-aio.

The controller will be exclusively used by the \s-1QEMU\s0 process once started. To be
able to share storage between multiple VMs and other applications on the host,
please use the file based protocols.

Before starting \s-1QEMU,\s0 bind the host NVMe controller to the host vfio-pci
driver.  For example:

.Vb 5
        # modprobe vfio-pci
        # lspci -n -s 0000:06:0d.0
        06:0d.0 0401: 1102:0002 (rev 08)
        # echo 0000:06:0d.0 &gt; /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
        # echo 1102 0002 &gt; /sys/bus/pci/drivers/vfio-pci/new_id
        
        # qemu-system-x86_64 -drive file=nvme://&lt;host&gt;:&lt;bus&gt;:&lt;slot&gt;.&lt;func&gt;/&lt;namespace&gt;
.Ve

Alternative syntax using properties:

.Vb 1
        qemu-system-x86_64 -drive file.driver=nvme,file.device=&lt;host&gt;:&lt;bus&gt;:&lt;slot&gt;.&lt;func&gt;,file.namespace=&lt;namespace&gt;
.Ve

_host_:_bus_:_slot_._func_ is the NVMe controller's \s-1PCI\s0 device
address on the host.

_namespace_ is the NVMe namespace number, starting from 1.

_Disk image file locking_
.IX Subsection "Disk image file locking"

By default, \s-1QEMU\s0 tries to protect image files from unexpected concurrent
access, as long as it's supported by the block protocol driver and host
operating system. If multiple \s-1QEMU\s0 processes (including \s-1QEMU\s0 emulators and
utilities) try to open the same image with conflicting accessing modes, all but
the first one will get an error.

This feature is currently supported by the file protocol on Linux with the Open
File Descriptor (\s-1OFD\s0) locking \s-1API,\s0 and can be configured to fall back to \s-1POSIX\s0
locking if the \s-1POSIX\s0 host doesn't support Linux \s-1OFD\s0 locking.

To explicitly enable image locking, specify locking=on\*(R" in the file protocol
driver options. If \s-1OFD\s0 locking is not possible, a warning will be printed and
the \s-1POSIX\s0 locking \s-1API\s0 will be used. In this case there is a risk that the lock
will get silently lost when doing hot plugging and block jobs, due to the
shortcomings of the \s-1POSIX\s0 locking \s-1API.\s0

\s-1QEMU\s0 transparently handles lock handover during shared storage migration.  For
shared virtual disk images between multiple VMs, the share-rw\*(R" device option
should be used.

By default, the guest has exclusive write access to its disk image. If the
guest can safely share the disk image with other writers the \f(CW`-device
...,share-rw=on parameter can be used.  This is only safe if the guest is
running software, such as a cluster file system, that coordinates disk accesses
to avoid corruption.

Note that share-rw=on only declares the guest's ability to share the disk.
Some \s-1QEMU\s0 features, such as image file formats, require exclusive write access
to the disk image and this is unaffected by the share-rw=on option.

Alternatively, locking can be fully disabled by locking=off\*(R" block device
option. In the command line, the option is usually in the form of
file.locking=off\*(R" as the protocol driver is normally placed as a \*(L"file\*(R" child
under a format driver. For example:

\f(CW`-blockdev driver=qcow2,file.filename=/path/to/image,file.locking=off,file.driver=file\*(C'

To check if image locking is active, check the output of the lslocks\*(R" command
on host and see if there are locks held by the \s-1QEMU\s0 process on the image file.
More than one byte could be locked by the \s-1QEMU\s0 instance, each byte of which
reflects a particular permission that is acquired or protected by the running
block driver.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
The \s-1HTML\s0 documentation of \s-1QEMU\s0 for more precise information and Linux
user mode emulator invocation.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Fabrice Bellard and the \s-1QEMU\s0 Project developers
