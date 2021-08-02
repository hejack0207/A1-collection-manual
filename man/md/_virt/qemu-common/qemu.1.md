# qemu.1(1)

 , 2019-08-14

.if n .ad l
.nh

<a name="name"></a>

# Name

qemu-doc - QEMU version 3.1.1 User Documentation

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" qemu-system-i386 [options] [disk_image]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The \s-1QEMU PC\s0 System emulator simulates the
following peripherals:

* i440FX host \s-1PCI\s0 bridge and \s-1PIIX3 PCI\s0 to \s-1ISA\s0 bridge
* Cirrus \s-1CLGD 5446 PCI VGA\s0 card or dummy \s-1VGA\s0 card with Bochs \s-1VESA\s0
  extensions (hardware level, including all non standard modes).
* \s-1PS/2\s0 mouse and keyboard
* 2 \s-1PCI IDE\s0 interfaces with hard disk and CD-ROM support
* Floppy disk
* \s-1PCI\s0 and \s-1ISA\s0 network adapters
* Serial ports
* \s-1IPMI BMC,\s0 either and internal or external one
* Creative SoundBlaster 16 sound card
* \s-1ENSONIQ\s0 AudioPCI \s-1ES1370\s0 sound card
* Intel 82801AA \s-1AC97\s0 Audio compatible sound card
* Intel \s-1HD\s0 Audio Controller and \s-1HDA\s0 codec
* Adlib (\s-1OPL2\s0) - Yamaha \s-1YM3812\s0 compatible chip
* Gravis Ultrasound \s-1GF1\s0 sound card
* \s-1CS4231A\s0 compatible sound card
* \s-1PCI UHCI, OHCI, EHCI\s0 or \s-1XHCI USB\s0 controller and a virtual \s-1USB-1.1\s0 hub.

\s-1SMP\s0 is supported with up to 255 CPUs.

\s-1QEMU\s0 uses the \s-1PC BIOS\s0 from the Seabios project and the Plex86/Bochs \s-1LGPL
VGA BIOS.\s0

\s-1QEMU\s0 uses \s-1YM3812\s0 emulation by Tatsuyuki Satoh.

\s-1QEMU\s0 uses \s-1GUS\s0 emulation (\s-1GUSEMU32\s0 &lt;**http://www.deinmeister.de/gusemu/**&gt;)
by Tibor \s-1TS\*(R"\s0 Schütz.

Note that, by default, \s-1GUS\s0 shares \s-1**IRQ\s0**\|(7) with parallel ports and so
\s-1QEMU\s0 must be told to not have parallel ports to have working \s-1GUS.\s0

.Vb 1
        qemu-system-i386 dos.img -soundhw gus -parallel none
.Ve

Alternatively:

.Vb 1
        qemu-system-i386 dos.img -device gus,irq=5
.Ve

Or some other unclaimed \s-1IRQ.\s0

\s-1CS4231A\s0 is the chip used in Windows Sound System and \s-1GUSMAX\s0 products

<a name="options"></a>

# Options

.IX Header "OPTIONS"
_disk\_image_ is a raw hard disk image for \s-1IDE\s0 hard disk 0. Some
targets do not need a disk image.

_Standard options_
.IX Subsection "Standard options"

* **-h**  
  .IX Item "-h"
  Display help and exit
* **-version**  
  .IX Item "-version"
  Display version information and exit
* **-machine [type=]**_name_**[,prop=**_value_**[,...]]**  
  .IX Item "-machine [type=]name[,prop=value[,...]]"
  Select the emulated machine by _name_. Use \f(CW`-machine help\*(C' to list
  available machines.
  .Sp
  For architectures which aim to support live migration compatibility
  across releases, each release will introduce a new versioned machine
  type. For example, the 2.8.0 release introduced machine types
  pc-i440fx-2.8\*(R" and \*(L"pc-q35-2.8\*(R" for the x86_64/i686 architectures.
  .Sp
  To allow live migration of guests from \s-1QEMU\s0 version 2.8.0, to \s-1QEMU\s0
  version 2.9.0, the 2.9.0 version must support the pc-i440fx-2.8\*(R"
  and pc-q35-2.8\*(R" machines too. To allow users live migrating VMs
  to skip multiple intermediate releases when upgrading, new releases
  of \s-1QEMU\s0 will support machine types from many previous versions.
  .Sp
  Supported machine properties are:
    * **accel=**_accels1_**[:**_accels2_**[:...]]**  
      .IX Item "accel=accels1[:accels2[:...]]"
      This is used to enable an accelerator. Depending on the target architecture,
      kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
      more than one accelerator specified, the next one is used if the previous one
      fails to initialize.
    * **kernel\_irqchip=on|off**  
      .IX Item "kernel_irqchip=on|off"
      Controls in-kernel irqchip support for the chosen accelerator when available.
    * **gfx\_passthru=on|off**  
      .IX Item "gfx_passthru=on|off"
      Enables \s-1IGD GFX\s0 passthrough support for the chosen machine when available.
    * **vmport=on|off|auto**  
      .IX Item "vmport=on|off|auto"
      Enables emulation of VMWare \s-1IO\s0 port, for vmmouse etc. auto says to select the
      value based on accel. For accel=xen the default is off otherwise the default
      is on.
    * **kvm\_shadow\_mem=size**  
      .IX Item "kvm_shadow_mem=size"
      Defines the size of the \s-1KVM\s0 shadow \s-1MMU.\s0
    * **dump-guest-core=on|off**  
      .IX Item "dump-guest-core=on|off"
      Include guest memory in a core dump. The default is on.
    * **mem-merge=on|off**  
      .IX Item "mem-merge=on|off"
      Enables or disables memory merge support. This feature, when supported by
      the host, de-duplicates identical memory pages among VMs instances
      (enabled by default).
    * **aes-key-wrap=on|off**  
      .IX Item "aes-key-wrap=on|off"
      Enables or disables \s-1AES\s0 key wrapping support on s390-ccw hosts. This feature
      controls whether \s-1AES\s0 wrapping keys will be created to allow
      execution of \s-1AES\s0 cryptographic functions.  The default is on.
    * **dea-key-wrap=on|off**  
      .IX Item "dea-key-wrap=on|off"
      Enables or disables \s-1DEA\s0 key wrapping support on s390-ccw hosts. This feature
      controls whether \s-1DEA\s0 wrapping keys will be created to allow
      execution of \s-1DEA\s0 cryptographic functions.  The default is on.
    * **nvdimm=on|off**  
      .IX Item "nvdimm=on|off"
      Enables or disables \s-1NVDIMM\s0 support. The default is off.
    * **enforce-config-section=on|off**  
      .IX Item "enforce-config-section=on|off"
      If **enforce-config-section** is set to _on_, force migration
      code to send configuration section even if the machine-type sets the
      **migration.send-configuration** property to _off_.
      \s-1NOTE:\s0 this parameter is deprecated. Please use **-global**
      **migration.send-configuration**=_on|off_ instead.
    * **memory-encryption=**  
      .IX Item "memory-encryption="
      Memory encryption object to use. The default is none.
* **-cpu** _model_  
  .IX Item "-cpu model"
  Select \s-1CPU\s0 model (\f(CW`-cpu help\*(C' for list and additional feature selection)
* **-accel** _name_**[,prop=**_value_**[,...]]**  
  .IX Item "-accel name[,prop=value[,...]]"
  This is used to enable an accelerator. Depending on the target architecture,
  kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
  more than one accelerator specified, the next one is used if the previous one
  fails to initialize.
    * **thread=single|multi**  
      .IX Item "thread=single|multi"
      Controls number of \s-1TCG\s0 threads. When the \s-1TCG\s0 is multi-threaded there will be one
      thread per vCPU therefor taking advantage of additional host cores. The default
      is to enable multi-threading where both the back-end and front-ends support it and
      no incompatible \s-1TCG\s0 features have been enabled (e.g. icount/replay).
* **-smp [cpus=]**_n_**[,cores=**_cores_**][,threads=**_threads_**][,sockets=**_sockets_**][,maxcpus=**_maxcpus_**]**  
  .IX Item "-smp [cpus=]n[,cores=cores][,threads=threads][,sockets=sockets][,maxcpus=maxcpus]"
  Simulate an \s-1SMP\s0 system with _n_ CPUs. On the \s-1PC\s0 target, up to 255
  CPUs are supported. On Sparc32 target, Linux limits the number of usable CPUs
  to 4.
  For the \s-1PC\s0 target, the number of _cores_ per socket, the number
  of _threads_ per cores and the total number of _sockets_ can be
  specified. Missing values will be computed. If any on the three values is
  given, the total number of CPUs _n_ can be omitted. _maxcpus_
  specifies the maximum number of hotpluggable CPUs.
* **-numa node[,mem=**_size_**][,cpus=**_firstcpu_**[-**_lastcpu_**]][,nodeid=**_node_**]**  
  .IX Item "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]"
* **-numa node[,memdev=**_id_**][,cpus=**_firstcpu_**[-**_lastcpu_**]][,nodeid=**_node_**]**  
  .IX Item "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]"
* **-numa dist,src=**_source_**,dst=**_destination_**,val=**_distance_  
  .IX Item "-numa dist,src=source,dst=destination,val=distance"
* **-numa cpu,node-id=**_node_**[,socket-id=**_x_**][,core-id=**_y_**][,thread-id=**_z_**]**  
  .IX Item "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]"
  Define a \s-1NUMA\s0 node and assign \s-1RAM\s0 and VCPUs to it.
  Set the \s-1NUMA\s0 distance from a source node to a destination node.
  .Sp
  Legacy \s-1VCPU\s0 assignment uses **cpus** option where
  _firstcpu_ and _lastcpu_ are \s-1CPU\s0 indexes. Each
  **cpus** option represent a contiguous range of \s-1CPU\s0 indexes
  (or a single \s-1VCPU\s0 if _lastcpu_ is omitted). A non-contiguous
  set of VCPUs can be represented by providing multiple **cpus**
  options. If **cpus** is omitted on all nodes, VCPUs are automatically
  split between them.
  .Sp
  For example, the following option assigns VCPUs 0, 1, 2 and 5 to
  a \s-1NUMA\s0 node:
  .Sp
  .Vb 1
          -numa node,cpus=0-2,cpus=5
  .Ve
  .Sp
  **cpu** option is a new alternative to **cpus** option
  which uses **socket-id|core-id|thread-id** properties to assign
  \s-1CPU\s0 objects to a _node_ using topology layout properties of \s-1CPU.\s0
  The set of properties is machine specific, and depends on used
  machine type/**smp** options. It could be queried with
  **hotpluggable-cpus** monitor command.
  **node-id** property specifies _node_ to which \s-1CPU\s0 object
  will be assigned, it's required for _node_ to be declared
  with **node** option before it's used with **cpu** option.
  .Sp
  For example:
  .Sp
  .Vb 4
          -M pc \e
          -smp 1,sockets=2,maxcpus=2 \e
          -numa node,nodeid=0 -numa node,nodeid=1 \e
          -numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
  .Ve
  .Sp
  **mem** assigns a given \s-1RAM\s0 amount to a node. **memdev**
  assigns \s-1RAM\s0 from a given memory backend device to a node. If
  **mem** and **memdev** are omitted in all nodes, \s-1RAM\s0 is
  split equally between them.
  .Sp
  **mem** and **memdev** are mutually exclusive. Furthermore,
  if one node uses **memdev**, all of them have to use it.
  .Sp
  _source_ and _destination_ are \s-1NUMA\s0 node IDs.
  _distance_ is the \s-1NUMA\s0 distance from _source_ to _destination_.
  The distance from a node to itself is always 10. If any pair of nodes is
  given a distance, then all pairs must be given distances. Although, when
  distances are only given in one direction for each pair of nodes, then
  the distances in the opposite directions are assumed to be the same. If,
  however, an asymmetrical pair of distances is given for even one node
  pair, then all node pairs must be provided distance values for both
  directions, even when they are symmetrical. When a node is unreachable
  from another node, set the pair's distance to 255.
  .Sp
  Note that the -**numa** option doesn't allocate any of the
  specified resources, it just assigns existing resources to \s-1NUMA\s0
  nodes. This means that one still has to use the **-m**,
  **-smp** options to allocate \s-1RAM\s0 and VCPUs respectively.
* **-add-fd fd=**_fd_**,set=**_set_**[,opaque=**_opaque_**]**  
  .IX Item "-add-fd fd=fd,set=set[,opaque=opaque]"
  Add a file descriptor to an fd set.  Valid options are:
    * **fd=**_fd_  
      .IX Item "fd=fd"
      This option defines the file descriptor of which a duplicate is added to fd set.
      The file descriptor cannot be stdin, stdout, or stderr.
    * **set=**_set_  
      .IX Item "set=set"
      This option defines the \s-1ID\s0 of the fd set to add the file descriptor to.
    * **opaque=**_opaque_  
      .IX Item "opaque=opaque"
      This option defines a free-form string that can be used to describe _fd_.
      .Sp
      You can open an image using pre-opened file descriptors from an fd set:
      .Sp
      .Vb 4
              qemu-system-i386
              -add-fd fd=3,set=2,opaque="rdwr:/path/to/file"
              -add-fd fd=4,set=2,opaque="rdonly:/path/to/file"
              -drive file=/dev/fdset/2,index=0,media=disk
      .Ve
* **-set** _group_**.**_id_**.**_arg_**=**_value_  
  .IX Item "-set group.id.arg=value"
  Set parameter _arg_ for item _id_ of type _group_
* **-global** _driver_**.**_prop_**=**_value_  
  .IX Item "-global driver.prop=value"
* **-global driver=**_driver_**,property=**_property_**,value=**_value_  
  .IX Item "-global driver=driver,property=property,value=value"
  Set default value of _driver_'s property _prop_ to _value_, e.g.:
  .Sp
  .Vb 1
          qemu-system-i386 -global ide-hd.physical_block_size=4096 disk-image.img
  .Ve
  .Sp
  In particular, you can use this to set driver properties for devices which are
  created automatically by the machine model. To create a device which is not
  created automatically and set properties on it, use -**device**.
  .Sp
  -global _driver_._prop_=_value_ is shorthand for -global
  driver=_driver_,property=_prop_,value=_value_.  The
  longhand syntax works even when _driver_ contains a dot.
* **-boot [order=**_drives_**][,once=**_drives_**][,menu=on|off][,splash=**_sp\_name_**][,splash-time=**_sp\_time_**][,reboot-timeout=**_rb\_timeout_**][,strict=on|off]**  
  .IX Item "-boot [order=drives][,once=drives][,menu=on|off][,splash=sp_name][,splash-time=sp_time][,reboot-timeout=rb_timeout][,strict=on|off]"
  Specify boot order _drives_ as a string of drive letters. Valid
  drive letters depend on the target architecture. The x86 \s-1PC\s0 uses: a, b
  (floppy 1 and 2), c (first hard disk), d (first CD-ROM), n-p (Etherboot
  from network adapter 1-4), hard disk boot is the default. To apply a
  particular boot order only on the first startup, specify it via
  **once**. Note that the **order** or **once** parameter
  should not be used together with the **bootindex** property of
  devices, since the firmware implementations normally do not support both
  at the same time.
  .Sp
  Interactive boot menus/prompts can be enabled via **menu=on** as far
  as firmware/BIOS supports them. The default is non-interactive boot.
  .Sp
  A splash picture could be passed to bios, enabling user to show it as logo,
  when option splash=_sp\_name_ is given and menu=on, If firmware/BIOS
  supports them. Currently Seabios for X86 system support it.
  limitation: The splash file could be a jpeg file or a \s-1BMP\s0 file in 24 \s-1BPP\s0
  format(true color). The resolution should be supported by the \s-1SVGA\s0 mode, so
  the recommended is 320x240, 640x480, 800x640.
  .Sp
  A timeout could be passed to bios, guest will pause for _rb\_timeout_ ms
  when boot failed, then reboot. If _rb\_timeout_ is '-1', guest will not
  reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
  system support it.
  .Sp
  Do strict boot via **strict=on** as far as firmware/BIOS
  supports it. This only effects when boot priority is changed by
  bootindex options. The default is non-strict boot.
  .Sp
  .Vb 6
          # try to boot from network first, then from hard disk
          qemu-system-i386 -boot order=nc
          # boot from CD-ROM first, switch back to default order after reboot
          qemu-system-i386 -boot once=d
          # boot with a splash picture for 5 seconds.
          qemu-system-i386 -boot menu=on,splash=/root/boot.bmp,splash-time=5000
  .Ve
  .Sp
  Note: The legacy format '-boot _drives_' is still supported but its
  use is discouraged as it may be removed from future versions.
* **-m [size=]**_megs_**[,slots=n,maxmem=size]**  
  .IX Item "-m [size=]megs[,slots=n,maxmem=size]"
  Sets guest startup \s-1RAM\s0 size to _megs_ megabytes. Default is 128 MiB.
  Optionally, a suffix of M\*(R" or \*(L"G\*(R" can be used to signify a value in
  megabytes or gigabytes respectively. Optional pair _slots_, _maxmem_
  could be used to set amount of hotpluggable memory slots and maximum amount of
  memory. Note that _maxmem_ must be aligned to the page size.
  .Sp
  For example, the following command-line sets the guest startup \s-1RAM\s0 size to
  1GB, creates 3 slots to hotplug additional memory and sets the maximum
  memory the guest can reach to 4GB:
  .Sp
  .Vb 1
          qemu-system-x86_64 -m 1G,slots=3,maxmem=4G
  .Ve
  .Sp
  If _slots_ and _maxmem_ are not specified, memory hotplug won't
  be enabled and the guest startup \s-1RAM\s0 will never increase.
* **-mem-path** _path_  
  .IX Item "-mem-path path"
  Allocate guest \s-1RAM\s0 from a temporarily created file in _path_.
* **-mem-prealloc**  
  .IX Item "-mem-prealloc"
  Preallocate memory when using -mem-path.
* **-k** _language_  
  .IX Item "-k language"
  Use keyboard layout _language_ (for example \f(CW`fr\*(C' for
  French). This option is only needed where it is not easy to get raw \s-1PC\s0
  keycodes (e.g. on Macs, with some X11 servers or with a \s-1VNC\s0 or curses
  display). You don't normally need to use it on PC/Linux or PC/Windows
  hosts.
  .Sp
  The available layouts are:
  .Sp
  .Vb 3
          ar  de-ch  es  fo     fr-ca  hu  ja  mk     no  pt-br  sv
          da  en-gb  et  fr     fr-ch  is  lt  nl     pl  ru     th
          de  en-us  fi  fr-be  hr     it  lv  nl-be  pt  sl     tr
  .Ve
  .Sp
  The default is \f(CW`en-us\*(C'.
* **-audio-help**  
  .IX Item "-audio-help"
  Will show the audio subsystem help: list of drivers, tunable
  parameters.
* **-soundhw** _card1_**[,**_card2_**,...] or -soundhw all**  
  .IX Item "-soundhw card1[,card2,...] or -soundhw all"
  Enable audio and selected sound hardware. Use 'help' to print all
  available sound hardware.
  .Sp
  .Vb 6
          qemu-system-i386 -soundhw sb16,adlib disk.img
          qemu-system-i386 -soundhw es1370 disk.img
          qemu-system-i386 -soundhw ac97 disk.img
          qemu-system-i386 -soundhw hda disk.img
          qemu-system-i386 -soundhw all disk.img
          qemu-system-i386 -soundhw help
  .Ve
  .Sp
  Note that Linux's i810_audio \s-1OSS\s0 kernel (for \s-1AC97\s0) module might
  require manually specifying clocking.
  .Sp
  .Vb 1
          modprobe i810_audio clocking=48000
  .Ve
* **-device** _driver_**[,**_prop_**[=**_value_**][,...]]**  
  .IX Item "-device driver[,prop[=value][,...]]"
  Add device _driver_.  _prop_=_value_ sets driver
  properties.  Valid properties depend on the driver.  To get help on
  possible drivers and properties, use \f(CW`-device help\*(C' and
  \f(CW`-device \f(CIdriver\f(CW,help\*(C'.
  .Sp
  Some drivers are:
* **-device ipmi-bmc-sim,id=**_id_**[,slave\_addr=**_val_**][,sdrfile=**_file_**][,furareasize=**_val_**][,furdatafile=**_file_**]**  
  .IX Item "-device ipmi-bmc-sim,id=id[,slave_addr=val][,sdrfile=file][,furareasize=val][,furdatafile=file]"
  Add an \s-1IPMI BMC.\s0  This is a simulation of a hardware management
  interface processor that normally sits on a system.  It provides
  a watchdog and the ability to reset and power control the system.
  You need to connect this to an \s-1IPMI\s0 interface to make it useful
  .Sp
  The \s-1IPMI\s0 slave address to use for the \s-1BMC.\s0  The default is 0x20.
  This address is the \s-1BMC\s0's address on the I2C network of management
  controllers.  If you don't know what this means, it is safe to ignore
  it.
    * **bmc=**_id_  
      .IX Item "bmc=id"
      The \s-1BMC\s0 to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
    * **slave\_addr=**_val_  
      .IX Item "slave_addr=val"
      Define slave address to use for the \s-1BMC.\s0  The default is 0x20.
    * **sdrfile=**_file_  
      .IX Item "sdrfile=file"
      file containing raw Sensor Data Records (\s-1SDR\s0) data. The default is none.
    * **fruareasize=**_val_  
      .IX Item "fruareasize=val"
      size of a Field Replaceable Unit (\s-1FRU\s0) area.  The default is 1024.
    * **frudatafile=**_file_  
      .IX Item "frudatafile=file"
      file containing raw Field Replaceable Unit (\s-1FRU\s0) inventory data. The default is none.
* **-device ipmi-bmc-extern,id=**_id_**,chardev=**_id_**[,slave\_addr=**_val_**]**  
  .IX Item "-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val]"
  Add a connection to an external \s-1IPMI BMC\s0 simulator.  Instead of
  locally emulating the \s-1BMC\s0 like the above item, instead connect
  to an external entity that provides the \s-1IPMI\s0 services.
  .Sp
  A connection is made to an external \s-1BMC\s0 simulator.  If you do this, it
  is strongly recommended that you use the reconnect=\*(R" chardev option
  to reconnect to the simulator if the connection is lost.  Note that if
  this is not used carefully, it can be a security issue, as the
  interface has the ability to send resets, NMIs, and power off the \s-1VM.\s0
  It's best if \s-1QEMU\s0 makes a connection to an external simulator running
  on a secure port on localhost, so neither the simulator nor \s-1QEMU\s0 is
  exposed to any outside network.
  .Sp
  See the lanserv/README.vm\*(R" file in the OpenIPMI library for more
  details on the external interface.
* **-device isa-ipmi-kcs,bmc=**_id_**[,ioport=**_val_**][,irq=**_val_**]**  
  .IX Item "-device isa-ipmi-kcs,bmc=id[,ioport=val][,irq=val]"
  Add a \s-1KCS IPMI\s0 interafce on the \s-1ISA\s0 bus.  This also adds a
  corresponding \s-1ACPI\s0 and \s-1SMBIOS\s0 entries, if appropriate.
    * **bmc=**_id_  
      .IX Item "bmc=id"
      The \s-1BMC\s0 to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
    * **ioport=**_val_  
      .IX Item "ioport=val"
      Define the I/O address of the interface.  The default is 0xca0 for \s-1KCS.\s0
    * **irq=**_val_  
      .IX Item "irq=val"
      Define the interrupt to use.  The default is 5.  To disable interrupts,
      set this to 0.
* **-device isa-ipmi-bt,bmc=**_id_**[,ioport=**_val_**][,irq=**_val_**]**  
  .IX Item "-device isa-ipmi-bt,bmc=id[,ioport=val][,irq=val]"
  Like the \s-1KCS\s0 interface, but defines a \s-1BT\s0 interface.  The default port is
  0xe4 and the default interrupt is 5.
* **-name** _name_  
  .IX Item "-name name"
  Sets the _name_ of the guest.
  This name will be displayed in the \s-1SDL\s0 window caption.
  The _name_ will also be used for the \s-1VNC\s0 server.
  Also optionally set the top visible process name in Linux.
  Naming of individual threads can also be enabled on Linux to aid debugging.
* **-uuid** _uuid_  
  .IX Item "-uuid uuid"
  Set system \s-1UUID.\s0

_Block device options_
.IX Subsection "Block device options"

* **-fda** _file_  
  .IX Item "-fda file"
* **-fdb** _file_  
  .IX Item "-fdb file"
  Use _file_ as floppy disk 0/1 image.
* **-hda** _file_  
  .IX Item "-hda file"
* **-hdb** _file_  
  .IX Item "-hdb file"
* **-hdc** _file_  
  .IX Item "-hdc file"
* **-hdd** _file_  
  .IX Item "-hdd file"
  Use _file_ as hard disk 0, 1, 2 or 3 image.
* **-cdrom** _file_  
  .IX Item "-cdrom file"
  Use _file_ as CD-ROM image (you cannot use **-hdc** and
  **-cdrom** at the same time). You can use the host CD-ROM by
  using _/dev/cdrom_ as filename.
* **-blockdev** _option_**[,**_option_**[,**_option_**[,...]]]**  
  .IX Item "-blockdev option[,option[,option[,...]]]"
  Define a new block driver node. Some of the options apply to all block drivers,
  other options are only accepted for a specific block driver. See below for a
  list of generic options and options for the most common block drivers.
  .Sp
  Options that expect a reference to another node (e.g. \f(CW`file\*(C') can be
  given in two ways. Either you specify the node name of an already existing node
  (file=_node-name_), or you define a new node inline, adding options
  for the referenced node after a dot (file.filename=_path_,file.aio=native).
  .Sp
  A block driver node created with **-blockdev** can be used for a guest
  device by specifying its node name for the \f(CW`drive\*(C' property in a
  **-device** argument that defines a block device.
    * **Valid options for any block driver node:**  
      .IX Item "Valid options for any block driver node:"
          .ie n .IP """driver""" 4
          .el .IP "\f(CWdriver" 4
          .IX Item "driver"
          Specifies the block driver to use for the given node.
          .ie n .IP """node-name""" 4
          .el .IP "\f(CWnode-name" 4
          .IX Item "node-name"
          This defines the name of the block driver node by which it will be referenced
          later. The name must be unique, i.e. it must not match the name of a different
          block driver node, or (if you use **-drive** as well) the \s-1ID\s0 of a drive.
          .Sp
          If no node name is specified, it is automatically generated. The generated node
          name is not intended to be predictable and changes between \s-1QEMU\s0 invocations.
          For the top level, an explicit node name must be specified.
          .ie n .IP """read-only""" 4
          .el .IP "\f(CWread-only" 4
          .IX Item "read-only"
          Open the node read-only. Guest write attempts will fail.
          .ie n .IP """cache.direct""" 4
          .el .IP "\f(CWcache.direct" 4
          .IX Item "cache.direct"
          The host page cache can be avoided with **cache.direct=on**. This will
          attempt to do disk \s-1IO\s0 directly to the guest's memory. \s-1QEMU\s0 may still perform an
          internal copy of the data.
          .ie n .IP """cache.no-flush""" 4
          .el .IP "\f(CWcache.no-flush" 4
          .IX Item "cache.no-flush"
          In case you don't care about data integrity over host failures, you can use
          **cache.no-flush=on**. This option tells \s-1QEMU\s0 that it never needs to write
          any data to the disk but can instead keep things in cache. If anything goes
          wrong, like your host losing power, the disk storage getting disconnected
          accidentally, etc. your image will most probably be rendered unusable.
          .ie n .IP """discard=_discard_""" 4
          .el .IP "\f(CWdiscard=\f(CIdiscard\f(CW" 4
          .IX Item "discard=discard"
          _discard_ is one of ignore\*(R" (or \*(L"off\*(R") or \*(L"unmap\*(R" (or \*(L"on\*(R") and controls
          whether \f(CW`discard\*(C' (also known as \f(CW\*(C\`trim\*(C' or \f(CW\*(C\`unmap\*(C') requests are
          ignored or passed to the filesystem. Some machine types may not support
          discard requests.
          .ie n .IP """detect-zeroes=_detect-zeroes_""" 4
          .el .IP "\f(CWdetect-zeroes=\f(CIdetect-zeroes\f(CW" 4
          .IX Item "detect-zeroes=detect-zeroes"
          _detect-zeroes_ is off\*(R", \*(L"on\*(R" or \*(L"unmap\*(R" and enables the automatic
          conversion of plain zero writes by the \s-1OS\s0 to driver specific optimized
          zero write commands. You may even choose unmap\*(R" if _discard_ is set
          to unmap\*(R" to allow a zero write to be converted to an \f(CW\*(C\`unmap\*(C' operation.
      .ie n .IP "**Driver-specific options for \f(CB""file""**" 4
      .el .IP "**Driver-specific options for \f(CBfile**" 4
      .IX Item "Driver-specific options for file"
      This is the protocol-level block driver for accessing regular files.
          .ie n .IP """filename""" 4
          .el .IP "\f(CWfilename" 4
          .IX Item "filename"
          The path to the image file in the local filesystem
          .ie n .IP """aio""" 4
          .el .IP "\f(CWaio" 4
          .IX Item "aio"
          Specifies the \s-1AIO\s0 backend (threads/native, default: threads)
          .ie n .IP """locking""" 4
          .el .IP "\f(CWlocking" 4
          .IX Item "locking"
          Specifies whether the image file is protected with Linux \s-1OFD / POSIX\s0 locks. The
          default is to use the Linux Open File Descriptor \s-1API\s0 if available, otherwise no
          lock is applied.  (auto/on/off, default: auto)
          .Sp
          Example:
          .Sp
          .Vb 1
                  -blockdev driver=file,node-name=disk,filename=disk.img
          .Ve
      .ie n .IP "**Driver-specific options for \f(CB""raw""**" 4
      .el .IP "**Driver-specific options for \f(CBraw**" 4
      .IX Item "Driver-specific options for raw"
      This is the image format block driver for raw images. It is usually
      stacked on top of a protocol level block driver such as \f(CW`file\*(C'.
          .ie n .IP """file""" 4
          .el .IP "\f(CWfile" 4
          .IX Item "file"
          Reference to or definition of the data source block driver node
          (e.g. a \f(CW`file\*(C' driver node)
          .Sp
          Example 1:
          .Sp
          .Vb 2
                  -blockdev driver=file,node-name=disk_file,filename=disk.img
                  -blockdev driver=raw,node-name=disk,file=disk_file
          .Ve
          .Sp
          Example 2:
          .Sp
          .Vb 1
                  -blockdev driver=raw,node-name=disk,file.driver=file,file.filename=disk.img
          .Ve
      .ie n .IP "**Driver-specific options for \f(CB""qcow2""**" 4
      .el .IP "**Driver-specific options for \f(CBqcow2**" 4
      .IX Item "Driver-specific options for qcow2"
      This is the image format block driver for qcow2 images. It is usually
      stacked on top of a protocol level block driver such as \f(CW`file\*(C'.
          .ie n .IP """file""" 4
          .el .IP "\f(CWfile" 4
          .IX Item "file"
          Reference to or definition of the data source block driver node
          (e.g. a \f(CW`file\*(C' driver node)
          .ie n .IP """backing""" 4
          .el .IP "\f(CWbacking" 4
          .IX Item "backing"
          Reference to or definition of the backing file block device (default is taken
          from the image file). It is allowed to pass \f(CW`null\*(C' here in order to disable
          the default backing file.
          .ie n .IP """lazy-refcounts""" 4
          .el .IP "\f(CWlazy-refcounts" 4
          .IX Item "lazy-refcounts"
          Whether to enable the lazy refcounts feature (on/off; default is taken from the
          image file)
          .ie n .IP """cache-size""" 4
          .el .IP "\f(CWcache-size" 4
          .IX Item "cache-size"
          The maximum total size of the L2 table and refcount block caches in bytes
          (default: the sum of l2-cache-size and refcount-cache-size)
          .ie n .IP """l2-cache-size""" 4
          .el .IP "\f(CWl2-cache-size" 4
          .IX Item "l2-cache-size"
          The maximum size of the L2 table cache in bytes
          (default: if cache-size is not specified - 32M on Linux platforms, and 8M on
          non-Linux platforms; otherwise, as large as possible within the cache-size,
          while permitting the requested or the minimal refcount cache size)
          .ie n .IP """refcount-cache-size""" 4
          .el .IP "\f(CWrefcount-cache-size" 4
          .IX Item "refcount-cache-size"
          The maximum size of the refcount block cache in bytes
          (default: 4 times the cluster size; or if cache-size is specified, the part of
          it which is not used for the L2 cache)
          .ie n .IP """cache-clean-interval""" 4
          .el .IP "\f(CWcache-clean-interval" 4
          .IX Item "cache-clean-interval"
          Clean unused entries in the L2 and refcount caches. The interval is in seconds.
          The default value is 600 on supporting platforms, and 0 on other platforms.
          Setting it to 0 disables this feature.
          .ie n .IP """pass-discard-request""" 4
          .el .IP "\f(CWpass-discard-request" 4
          .IX Item "pass-discard-request"
          Whether discard requests to the qcow2 device should be forwarded to the data
          source (on/off; default: on if discard=unmap is specified, off otherwise)
          .ie n .IP """pass-discard-snapshot""" 4
          .el .IP "\f(CWpass-discard-snapshot" 4
          .IX Item "pass-discard-snapshot"
          Whether discard requests for the data source should be issued when a snapshot
          operation (e.g. deleting a snapshot) frees clusters in the qcow2 file (on/off;
          default: on)
          .ie n .IP """pass-discard-other""" 4
          .el .IP "\f(CWpass-discard-other" 4
          .IX Item "pass-discard-other"
          Whether discard requests for the data source should be issued on other
          occasions where a cluster gets freed (on/off; default: off)
          .ie n .IP """overlap-check""" 4
          .el .IP "\f(CWoverlap-check" 4
          .IX Item "overlap-check"
          Which overlap checks to perform for writes to the image
          (none/constant/cached/all; default: cached). For details or finer
          granularity control refer to the \s-1QAPI\s0 documentation of \f(CW`blockdev-add\*(C'.
          .Sp
          Example 1:
          .Sp
          .Vb 2
                  -blockdev driver=file,node-name=my_file,filename=/tmp/disk.qcow2
                  -blockdev driver=qcow2,node-name=hda,file=my_file,overlap-check=none,cache-size=16777216
          .Ve
          .Sp
          Example 2:
          .Sp
          .Vb 1
                  -blockdev driver=qcow2,node-name=disk,file.driver=http,file.filename=http://example.com/image.qcow2
          .Ve
    * **Driver-specific options for other drivers**  
      .IX Item "Driver-specific options for other drivers"
      Please refer to the \s-1QAPI\s0 documentation of the \f(CW`blockdev-add\*(C' \s-1QMP\s0 command.
* **-drive** _option_**[,**_option_**[,**_option_**[,...]]]**  
  .IX Item "-drive option[,option[,option[,...]]]"
  Define a new drive. This includes creating a block driver node (the backend) as
  well as a guest device, and is mostly a shortcut for defining the corresponding
  **-blockdev** and **-device** options.
  .Sp
  **-drive** accepts all options that are accepted by **-blockdev**. In
  addition, it knows the following options:
    * **file=**_file_  
      .IX Item "file=file"
      This option defines which disk image to use with
      this drive. If the filename contains comma, you must double it
      (for instance, file=my,,file\*(R" to use file \*(L"my,file\*(R").
      .Sp
      Special files such as iSCSI devices can be specified using protocol
      specific URLs. See the section for Device \s-1URL\s0 Syntax\*(R" for more information.
    * **if=**_interface_  
      .IX Item "if=interface"
      This option defines on which type on interface the drive is connected.
      Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio, none.
    * **bus=**_bus_**,unit=**_unit_  
      .IX Item "bus=bus,unit=unit"
      These options define where is connected the drive by defining the bus number and
      the unit id.
    * **index=**_index_  
      .IX Item "index=index"
      This option defines where is connected the drive by using an index in the list
      of available connectors of a given interface type.
    * **media=**_media_  
      .IX Item "media=media"
      This option defines the type of the media: disk or cdrom.
    * **snapshot=**_snapshot_  
      .IX Item "snapshot=snapshot"
      _snapshot_ is on\*(R" or \*(L"off\*(R" and controls snapshot mode for the given drive
      (see **-snapshot**).
    * **cache=**_cache_  
      .IX Item "cache=cache"
      _cache_ is none\*(R", \*(L"writeback\*(R", \*(L"unsafe\*(R", \*(L"directsync\*(R" or \*(L"writethrough\*(R"
      and controls how the host cache is used to access block data. This is a
      shortcut that sets the **cache.direct** and **cache.no-flush**
      options (as in **-blockdev**), and additionally **cache.writeback**,
      which provides a default for the **write-cache** option of block guest
      devices (as in **-device**). The modes correspond to the following
      settings:
      .Sp
      .Vb 7
                           │ cache.writeback   cache.direct   cache.no-flush
              ─────────────┼─────────────────────────────────────────────────
              writeback    │ on                off            off
              none         │ on                on             off
              writethrough │ off               off            off
              directsync   │ off               on             off
              unsafe       │ on                off            on
      .Ve
      .Sp
      The default mode is **cache=writeback**.
    * **aio=**_aio_  
      .IX Item "aio=aio"
      _aio_ is threads\*(R", or \*(L"native\*(R" and selects between pthread based disk I/O and native Linux \s-1AIO.\s0
    * **format=**_format_  
      .IX Item "format=format"
      Specify which disk _format_ will be used rather than detecting
      the format.  Can be used to specify format=raw to avoid interpreting
      an untrusted format header.
    * **werror=**_action_**,rerror=**_action_  
      .IX Item "werror=action,rerror=action"
      Specify which _action_ to take on write and read errors. Valid actions are:
      ignore\*(R" (ignore the error and try to continue), \*(L"stop\*(R" (pause \s-1QEMU\s0),
      report\*(R" (report the error to the guest), \*(L"enospc\*(R" (pause \s-1QEMU\s0 only if the
      host disk is full; report the error to the guest otherwise).
      The default setting is **werror=enospc** and **rerror=report**.
    * **copy-on-read=**_copy-on-read_  
      .IX Item "copy-on-read=copy-on-read"
      _copy-on-read_ is on\*(R" or \*(L"off\*(R" and enables whether to copy read backing
      file sectors into the image file.
    * **bps=**_b_**,bps\_rd=**_r_**,bps\_wr=**_w_  
      .IX Item "bps=b,bps_rd=r,bps_wr=w"
      Specify bandwidth throttling limits in bytes per second, either for all request
      types or for reads or writes only.  Small values can lead to timeouts or hangs
      inside the guest.  A safe minimum for disks is 2 MB/s.
    * **bps\_max=**_bm_**,bps\_rd\_max=**_rm_**,bps\_wr\_max=**_wm_  
      .IX Item "bps_max=bm,bps_rd_max=rm,bps_wr_max=wm"
      Specify bursts in bytes per second, either for all request types or for reads
      or writes only.  Bursts allow the guest I/O to spike above the limit
      temporarily.
    * **iops=**_i_**,iops\_rd=**_r_**,iops\_wr=**_w_  
      .IX Item "iops=i,iops_rd=r,iops_wr=w"
      Specify request rate limits in requests per second, either for all request
      types or for reads or writes only.
    * **iops\_max=**_bm_**,iops\_rd\_max=**_rm_**,iops\_wr\_max=**_wm_  
      .IX Item "iops_max=bm,iops_rd_max=rm,iops_wr_max=wm"
      Specify bursts in requests per second, either for all request types or for reads
      or writes only.  Bursts allow the guest I/O to spike above the limit
      temporarily.
    * **iops\_size=**_is_  
      .IX Item "iops_size=is"
      Let every _is_ bytes of a request count as a new request for iops
      throttling purposes.  Use this option to prevent guests from circumventing iops
      limits by sending fewer but larger requests.
    * **group=**_g_  
      .IX Item "group=g"
      Join a throttling quota group with given name _g_.  All drives that are
      members of the same group are accounted for together.  Use this option to
      prevent guests from circumventing throttling limits by using many small disks
      instead of a single larger disk.
      .Sp
      By default, the **cache.writeback=on** mode is used. It will report data
      writes as completed as soon as the data is present in the host page cache.
      This is safe as long as your guest \s-1OS\s0 makes sure to correctly flush disk caches
      where needed. If your guest \s-1OS\s0 does not handle volatile disk write caches
      correctly and your host crashes or loses power, then the guest may experience
      data corruption.
      .Sp
      For such guests, you should consider using **cache.writeback=off**. This
      means that the host page cache will be used to read and write data, but write
      notification will be sent to the guest only after \s-1QEMU\s0 has made sure to flush
      each write to the disk. Be aware that this has a major impact on performance.
      .Sp
      When using the **-snapshot** option, unsafe caching is always used.
      .Sp
      Copy-on-read avoids accessing the same backing file sectors repeatedly and is
      useful when the backing file is over a slow network.  By default copy-on-read
      is off.
      .Sp
      Instead of **-cdrom** you can use:
      .Sp
      .Vb 1
              qemu-system-i386 -drive file=file,index=2,media=cdrom
      .Ve
      .Sp
      Instead of **-hda**, **-hdb**, **-hdc**, **-hdd**, you can
      use:
      .Sp
      .Vb 4
              qemu-system-i386 -drive file=file,index=0,media=disk
              qemu-system-i386 -drive file=file,index=1,media=disk
              qemu-system-i386 -drive file=file,index=2,media=disk
              qemu-system-i386 -drive file=file,index=3,media=disk
      .Ve
      .Sp
      You can open an image using pre-opened file descriptors from an fd set:
      .Sp
      .Vb 4
              qemu-system-i386
              -add-fd fd=3,set=2,opaque="rdwr:/path/to/file"
              -add-fd fd=4,set=2,opaque="rdonly:/path/to/file"
              -drive file=/dev/fdset/2,index=0,media=disk
      .Ve
      .Sp
      You can connect a \s-1CDROM\s0 to the slave of ide0:
      .Sp
      .Vb 1
              qemu-system-i386 -drive file=file,if=ide,index=1,media=cdrom
      .Ve
      .Sp
      If you don't specify the file=\*(R" argument, you define an empty drive:
      .Sp
      .Vb 1
              qemu-system-i386 -drive if=ide,index=1,media=cdrom
      .Ve
      .Sp
      Instead of **-fda**, **-fdb**, you can use:
      .Sp
      .Vb 2
              qemu-system-i386 -drive file=file,index=0,if=floppy
              qemu-system-i386 -drive file=file,index=1,if=floppy
      .Ve
      .Sp
      By default, _interface_ is ide\*(R" and _index_ is automatically
      incremented:
      .Sp
      .Vb 1
              qemu-system-i386 -drive file=a -drive file=b"
      .Ve
      .Sp
      is interpreted like:
      .Sp
      .Vb 1
              qemu-system-i386 -hda a -hdb b
      .Ve
* **-mtdblock** _file_  
  .IX Item "-mtdblock file"
  Use _file_ as on-board Flash memory image.
* **-sd** _file_  
  .IX Item "-sd file"
  Use _file_ as SecureDigital card image.
* **-pflash** _file_  
  .IX Item "-pflash file"
  Use _file_ as a parallel flash image.
* **-snapshot**  
  .IX Item "-snapshot"
  Write to temporary files instead of disk image files. In this case,
  the raw disk image you use is not written back. You can however force
  the write back by pressing **C-a s**.
* **-fsdev** _fsdriver_**,id=**_id_**,path=**_path_**,[security\_model=**_security\_model_**][,writeout=**_writeout_**][,readonly][,socket=**_socket_**|sock\_fd=**_sock\_fd_**][,fmode=**_fmode_**][,dmode=**_dmode_**]**  
  .IX Item "-fsdev fsdriver,id=id,path=path,[security_model=security_model][,writeout=writeout][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]"
  Define a new file system device. Valid options are:
    * _fsdriver_  
      .IX Item "fsdriver"
      This option specifies the fs driver backend to use.
      Currently local\*(R", \*(L"handle\*(R" and \*(L"proxy\*(R" file system drivers are supported.
    * **id=**_id_  
      .IX Item "id=id"
      Specifies identifier for this device
    * **path=**_path_  
      .IX Item "path=path"
      Specifies the export path for the file system device. Files under
      this path will be available to the 9p client on the guest.
    * **security\_model=**_security\_model_  
      .IX Item "security_model=security_model"
      Specifies the security model to be used for this export path.
      Supported security models are passthrough\*(R", \*(L"mapped-xattr\*(R", \*(L"mapped-file\*(R" and \*(L"none\*(R".
      In passthrough\*(R" security model, files are stored using the same
      credentials as they are created on the guest. This requires \s-1QEMU\s0
      to run as root. In mapped-xattr\*(R" security model, some of the file
      attributes like uid, gid, mode bits and link target are stored as
      file attributes. For mapped-file\*(R" these attributes are stored in the
      hidden .virtfs_metadata directory. Directories exported by this security model cannot
      interact with other unix tools. none\*(R" security model is same as
      passthrough except the sever won't report failures if it fails to
      set file attributes like ownership. Security model is mandatory
      only for local fsdriver. Other fsdrivers (like handle, proxy) don't take
      security model as a parameter.
    * **writeout=**_writeout_  
      .IX Item "writeout=writeout"
      This is an optional argument. The only supported value is immediate\*(R".
      This means that host page cache will be used to read and write data but
      write notification will be sent to the guest only when the data has been
      reported as written by the storage subsystem.
    * **readonly**  
      .IX Item "readonly"
      Enables exporting 9p share as a readonly mount for guests. By default
      read-write access is given.
    * **socket=**_socket_  
      .IX Item "socket=socket"
      Enables proxy filesystem driver to use passed socket file for communicating
      with virtfs-proxy-helper
    * **sock\_fd=**_sock\_fd_  
      .IX Item "sock_fd=sock_fd"
      Enables proxy filesystem driver to use passed socket descriptor for
      communicating with virtfs-proxy-helper. Usually a helper like libvirt
      will create socketpair and pass one of the fds as sock_fd
    * **fmode=**_fmode_  
      .IX Item "fmode=fmode"
      Specifies the default mode for newly created files on the host. Works only
      with security models mapped-xattr\*(R" and \*(L"mapped-file\*(R".
    * **dmode=**_dmode_  
      .IX Item "dmode=dmode"
      Specifies the default mode for newly created directories on the host. Works
      only with security models mapped-xattr\*(R" and \*(L"mapped-file\*(R".
      .Sp
      -fsdev option is used along with -device driver virtio-9p-pci\*(R".
* **-device virtio-9p-pci,fsdev=**_id_**,mount\_tag=**_mount\_tag_  
  .IX Item "-device virtio-9p-pci,fsdev=id,mount_tag=mount_tag"
  Options for virtio-9p-pci driver are:
    * **fsdev=**_id_  
      .IX Item "fsdev=id"
      Specifies the id value specified along with -fsdev option
    * **mount\_tag=**_mount\_tag_  
      .IX Item "mount_tag=mount_tag"
      Specifies the tag name to be used by the guest to mount this export point
* **-virtfs** _fsdriver_**[,path=**_path_**],mount\_tag=**_mount\_tag_**[,security\_model=**_security\_model_**][,writeout=**_writeout_**][,readonly][,socket=**_socket_**|sock\_fd=**_sock\_fd_**][,fmode=**_fmode_**][,dmode=**_dmode_**]**  
  .IX Item "-virtfs fsdriver[,path=path],mount_tag=mount_tag[,security_model=security_model][,writeout=writeout][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]"
  The general form of a Virtual File system pass-through options are:
    * _fsdriver_  
      .IX Item "fsdriver"
      This option specifies the fs driver backend to use.
      Currently local\*(R", \*(L"handle\*(R" and \*(L"proxy\*(R" file system drivers are supported.
    * **id=**_id_  
      .IX Item "id=id"
      Specifies identifier for this device
    * **path=**_path_  
      .IX Item "path=path"
      Specifies the export path for the file system device. Files under
      this path will be available to the 9p client on the guest.
    * **security\_model=**_security\_model_  
      .IX Item "security_model=security_model"
      Specifies the security model to be used for this export path.
      Supported security models are passthrough\*(R", \*(L"mapped-xattr\*(R", \*(L"mapped-file\*(R" and \*(L"none\*(R".
      In passthrough\*(R" security model, files are stored using the same
      credentials as they are created on the guest. This requires \s-1QEMU\s0
      to run as root. In mapped-xattr\*(R" security model, some of the file
      attributes like uid, gid, mode bits and link target are stored as
      file attributes. For mapped-file\*(R" these attributes are stored in the
      hidden .virtfs_metadata directory. Directories exported by this security model cannot
      interact with other unix tools. none\*(R" security model is same as
      passthrough except the sever won't report failures if it fails to
      set file attributes like ownership. Security model is mandatory only
      for local fsdriver. Other fsdrivers (like handle, proxy) don't take security
      model as a parameter.
    * **writeout=**_writeout_  
      .IX Item "writeout=writeout"
      This is an optional argument. The only supported value is immediate\*(R".
      This means that host page cache will be used to read and write data but
      write notification will be sent to the guest only when the data has been
      reported as written by the storage subsystem.
    * **readonly**  
      .IX Item "readonly"
      Enables exporting 9p share as a readonly mount for guests. By default
      read-write access is given.
    * **socket=**_socket_  
      .IX Item "socket=socket"
      Enables proxy filesystem driver to use passed socket file for
      communicating with virtfs-proxy-helper. Usually a helper like libvirt
      will create socketpair and pass one of the fds as sock_fd
    * **sock\_fd**  
      .IX Item "sock_fd"
      Enables proxy filesystem driver to use passed 'sock_fd' as the socket
      descriptor for interfacing with virtfs-proxy-helper
    * **fmode=**_fmode_  
      .IX Item "fmode=fmode"
      Specifies the default mode for newly created files on the host. Works only
      with security models mapped-xattr\*(R" and \*(L"mapped-file\*(R".
    * **dmode=**_dmode_  
      .IX Item "dmode=dmode"
      Specifies the default mode for newly created directories on the host. Works
      only with security models mapped-xattr\*(R" and \*(L"mapped-file\*(R".
* **-virtfs\_synth**  
  .IX Item "-virtfs_synth"
  Create synthetic file system image
* **-iscsi**  
  .IX Item "-iscsi"
  Configure iSCSI session parameters.

_\s-1USB\s0 options_
.IX Subsection "USB options"

* **-usb**  
  .IX Item "-usb"
  Enable the \s-1USB\s0 driver (if it is not used by default yet).
* **-usbdevice** _devname_  
  .IX Item "-usbdevice devname"
  Add the \s-1USB\s0 device _devname_. Note that this option is deprecated,
  please use \f(CW`-device usb-...\*(C' instead.
    * **mouse**  
      .IX Item "mouse"
      Virtual Mouse. This will override the \s-1PS/2\s0 mouse emulation when activated.
    * **tablet**  
      .IX Item "tablet"
      Pointer device that uses absolute coordinates (like a touchscreen). This
      means \s-1QEMU\s0 is able to report the mouse position without having to grab the
      mouse. Also overrides the \s-1PS/2\s0 mouse emulation when activated.
    * **braille**  
      .IX Item "braille"
      Braille device.  This will use BrlAPI to display the braille output on a real
      or fake device.

_Display options_
.IX Subsection "Display options"

* **-display** _type_  
  .IX Item "-display type"
  Select type of display to use. This option is a replacement for the
  old style -sdl/-curses/... options. Valid values for _type_ are
    * **sdl**  
      .IX Item "sdl"
      Display video output via \s-1SDL\s0 (usually in a separate graphics
      window; see the \s-1SDL\s0 documentation for other possibilities).
    * **curses**  
      .IX Item "curses"
      Display video output via curses. For graphics device models which
      support a text mode, \s-1QEMU\s0 can display this output using a
      curses/ncurses interface. Nothing is displayed when the graphics
      device is in graphical mode or if the graphics device does not support
      a text mode. Generally only the \s-1VGA\s0 device models support text mode.
    * **none**  
      .IX Item "none"
      Do not display video output. The guest will still see an emulated
      graphics card, but its output will not be displayed to the \s-1QEMU\s0
      user. This option differs from the -nographic option in that it
      only affects what is done with video output; -nographic also changes
      the destination of the serial and parallel port data.
    * **gtk**  
      .IX Item "gtk"
      Display video output in a \s-1GTK\s0 window. This interface provides drop-down
      menus and other \s-1UI\s0 elements to configure and control the \s-1VM\s0 during
      runtime.
    * **vnc**  
      .IX Item "vnc"
      Start a \s-1VNC\s0 server on display &lt;arg&gt;
    * **egl-headless**  
      .IX Item "egl-headless"
      Offload all OpenGL operations to a local \s-1DRI\s0 device. For any graphical display,
      this display needs to be paired with either \s-1VNC\s0 or \s-1SPICE\s0 displays.
* **-nographic**  
  .IX Item "-nographic"
  Normally, if \s-1QEMU\s0 is compiled with graphical window support, it displays
  output such as guest graphics, guest console, and the \s-1QEMU\s0 monitor in a
  window. With this option, you can totally disable graphical output so
  that \s-1QEMU\s0 is a simple command line application. The emulated serial port
  is redirected on the console and muxed with the monitor (unless
  redirected elsewhere explicitly). Therefore, you can still use \s-1QEMU\s0 to
  debug a Linux kernel with a serial console. Use **C-a h** for help on
  switching between the console and monitor.
* **-curses**  
  .IX Item "-curses"
  Normally, if \s-1QEMU\s0 is compiled with graphical window support, it displays
  output such as guest graphics, guest console, and the \s-1QEMU\s0 monitor in a
  window. With this option, \s-1QEMU\s0 can display the \s-1VGA\s0 output when in text
  mode using a curses/ncurses interface. Nothing is displayed in graphical
  mode.
* **-no-frame**  
  .IX Item "-no-frame"
  Do not use decorations for \s-1SDL\s0 windows and start them using the whole
  available screen space. This makes the using \s-1QEMU\s0 in a dedicated desktop
  workspace more convenient.
* **-alt-grab**  
  .IX Item "-alt-grab"
  Use Ctrl-Alt-Shift to grab mouse (instead of Ctrl-Alt). Note that this also
  affects the special keys (for fullscreen, monitor-mode switching, etc).
* **-ctrl-grab**  
  .IX Item "-ctrl-grab"
  Use Right-Ctrl to grab mouse (instead of Ctrl-Alt). Note that this also
  affects the special keys (for fullscreen, monitor-mode switching, etc).
* **-no-quit**  
  .IX Item "-no-quit"
  Disable \s-1SDL\s0 window close capability.
* **-sdl**  
  .IX Item "-sdl"
  Enable \s-1SDL.\s0
* **-spice** _option_**[,**_option_**[,...]]**  
  .IX Item "-spice option[,option[,...]]"
  Enable the spice remote desktop protocol. Valid options are
    * **port=&lt;nr&gt;**  
      .IX Item "port=&lt;nr&gt;"
      Set the \s-1TCP\s0 port spice is listening on for plaintext channels.
    * **addr=&lt;addr&gt;**  
      .IX Item "addr=&lt;addr&gt;"
      Set the \s-1IP\s0 address spice is listening on.  Default is any address.
    * **ipv4**  
      .IX Item "ipv4"
    * **ipv6**  
      .IX Item "ipv6"
    * **unix**  
      .IX Item "unix"
      Force using the specified \s-1IP\s0 version.
    * **password=&lt;secret&gt;**  
      .IX Item "password=&lt;secret&gt;"
      Set the password you need to authenticate.
    * **sasl**  
      .IX Item "sasl"
      Require that the client use \s-1SASL\s0 to authenticate with the spice.
      The exact choice of authentication method used is controlled from the
      system / user's \s-1SASL\s0 configuration file for the 'qemu' service. This
      is typically found in /etc/sasl2/qemu.conf. If running \s-1QEMU\s0 as an
      unprivileged user, an environment variable \s-1SASL_CONF_PATH\s0 can be used
      to make it search alternate locations for the service config.
      While some \s-1SASL\s0 auth methods can also provide data encryption (eg \s-1GSSAPI\s0),
      it is recommended that \s-1SASL\s0 always be combined with the 'tls' and
      'x509' settings to enable use of \s-1SSL\s0 and server certificates. This
      ensures a data encryption preventing compromise of authentication
      credentials.
    * **disable-ticketing**  
      .IX Item "disable-ticketing"
      Allow client connects without authentication.
    * **disable-copy-paste**  
      .IX Item "disable-copy-paste"
      Disable copy paste between the client and the guest.
    * **disable-agent-file-xfer**  
      .IX Item "disable-agent-file-xfer"
      Disable spice-vdagent based file-xfer between the client and the guest.
    * **tls-port=&lt;nr&gt;**  
      .IX Item "tls-port=&lt;nr&gt;"
      Set the \s-1TCP\s0 port spice is listening on for encrypted channels.
    * **x509-dir=&lt;dir&gt;**  
      .IX Item "x509-dir=&lt;dir&gt;"
      Set the x509 file directory. Expects same filenames as -vnc \f(CW$display,x509=$dir
    * **x509-key-file=&lt;file&gt;**  
      .IX Item "x509-key-file=&lt;file&gt;"
    * **x509-key-password=&lt;file&gt;**  
      .IX Item "x509-key-password=&lt;file&gt;"
    * **x509-cert-file=&lt;file&gt;**  
      .IX Item "x509-cert-file=&lt;file&gt;"
    * **x509-cacert-file=&lt;file&gt;**  
      .IX Item "x509-cacert-file=&lt;file&gt;"
    * **x509-dh-key-file=&lt;file&gt;**  
      .IX Item "x509-dh-key-file=&lt;file&gt;"
      The x509 file names can also be configured individually.
    * **tls-ciphers=&lt;list&gt;**  
      .IX Item "tls-ciphers=&lt;list&gt;"
      Specify which ciphers to use.
    * **tls-channel=[main|display|cursor|inputs|record|playback]**  
      .IX Item "tls-channel=[main|display|cursor|inputs|record|playback]"
    * **plaintext-channel=[main|display|cursor|inputs|record|playback]**  
      .IX Item "plaintext-channel=[main|display|cursor|inputs|record|playback]"
      Force specific channel to be used with or without \s-1TLS\s0 encryption.  The
      options can be specified multiple times to configure multiple
      channels.  The special name default\*(R" can be used to set the default
      mode.  For channels which are not explicitly forced into one mode the
      spice client is allowed to pick tls/plaintext as he pleases.
    * **image-compression=[auto\_glz|auto\_lz|quic|glz|lz|off]**  
      .IX Item "image-compression=[auto_glz|auto_lz|quic|glz|lz|off]"
      Configure image compression (lossless).
      Default is auto_glz.
    * **jpeg-wan-compression=[auto|never|always]**  
      .IX Item "jpeg-wan-compression=[auto|never|always]"
    * **zlib-glz-wan-compression=[auto|never|always]**  
      .IX Item "zlib-glz-wan-compression=[auto|never|always]"
      Configure wan image compression (lossy for slow links).
      Default is auto.
    * **streaming-video=[off|all|filter]**  
      .IX Item "streaming-video=[off|all|filter]"
      Configure video stream detection.  Default is off.
    * **agent-mouse=[on|off]**  
      .IX Item "agent-mouse=[on|off]"
      Enable/disable passing mouse events via vdagent.  Default is on.
    * **playback-compression=[on|off]**  
      .IX Item "playback-compression=[on|off]"
      Enable/disable audio stream compression (using celt 0.5.1).  Default is on.
    * **seamless-migration=[on|off]**  
      .IX Item "seamless-migration=[on|off]"
      Enable/disable spice seamless migration. Default is off.
    * **gl=[on|off]**  
      .IX Item "gl=[on|off]"
      Enable/disable OpenGL context. Default is off.
    * **rendernode=&lt;file&gt;**  
      .IX Item "rendernode=&lt;file&gt;"
      \s-1DRM\s0 render node for OpenGL rendering. If not specified, it will pick
      the first available. (Since 2.9)
* **-portrait**  
  .IX Item "-portrait"
  Rotate graphical output 90 deg left (only \s-1PXA LCD\s0).
* **-rotate** _deg_  
  .IX Item "-rotate deg"
  Rotate graphical output some deg left (only \s-1PXA LCD\s0).
* **-vga** _type_  
  .IX Item "-vga type"
  Select type of \s-1VGA\s0 card to emulate. Valid values for _type_ are
    * **cirrus**  
      .IX Item "cirrus"
      Cirrus Logic \s-1GD5446\s0 Video card. All Windows versions starting from
      Windows 95 should recognize and use this graphic card. For optimal
      performances, use 16 bit color depth in the guest and the host \s-1OS.\s0
      (This card was the default before \s-1QEMU 2.2\s0)
    * **std**  
      .IX Item "std"
      Standard \s-1VGA\s0 card with Bochs \s-1VBE\s0 extensions.  If your guest \s-1OS\s0
      supports the \s-1VESA 2.0 VBE\s0 extensions (e.g. Windows \s-1XP\s0) and if you want
      to use high resolution modes (&gt;= 1280x1024x16) then you should use
      this option. (This card is the default since \s-1QEMU 2.2\s0)
    * **vmware**  
      .IX Item "vmware"
      VMWare SVGA-II compatible adapter. Use it if you have sufficiently
      recent XFree86/XOrg server or Windows guest with a driver for this
      card.
    * **qxl**  
      .IX Item "qxl"
      \s-1QXL\s0 paravirtual graphic card.  It is \s-1VGA\s0 compatible (including \s-1VESA
      2.0 VBE\s0 support).  Works best with qxl guest drivers installed though.
      Recommended choice when using the spice protocol.
    * **tcx**  
      .IX Item "tcx"
      (sun4m only) Sun \s-1TCX\s0 framebuffer. This is the default framebuffer for
      sun4m machines and offers both 8-bit and 24-bit colour depths at a
      fixed resolution of 1024x768.
    * **cg3**  
      .IX Item "cg3"
      (sun4m only) Sun cgthree framebuffer. This is a simple 8-bit framebuffer
      for sun4m machines available in both 1024x768 (OpenBIOS) and 1152x900 (\s-1OBP\s0)
      resolutions aimed at people wishing to run older Solaris versions.
    * **virtio**  
      .IX Item "virtio"
      Virtio \s-1VGA\s0 card.
    * **none**  
      .IX Item "none"
      Disable \s-1VGA\s0 card.
* **-full-screen**  
  .IX Item "-full-screen"
  Start in full screen.
* **-g** _width_**x**_height_**[x**_depth_**]**  
  .IX Item "-g widthxheight[xdepth]"
  Set the initial graphical resolution and depth (\s-1PPC, SPARC\s0 only).
* **-vnc** _display_**[,**_option_**[,**_option_**[,...]]]**  
  .IX Item "-vnc display[,option[,option[,...]]]"
  Normally, if \s-1QEMU\s0 is compiled with graphical window support, it displays
  output such as guest graphics, guest console, and the \s-1QEMU\s0 monitor in a
  window. With this option, you can have \s-1QEMU\s0 listen on \s-1VNC\s0 display
  _display_ and redirect the \s-1VGA\s0 display over the \s-1VNC\s0 session. It is
  very useful to enable the usb tablet device when using this option
  (option **-device usb-tablet**). When using the \s-1VNC\s0 display, you
  must use the **-k** parameter to set the keyboard layout if you are
  not using en-us. Valid syntax for the _display_ is
    * **to=**_L_  
      .IX Item "to=L"
      With this option, \s-1QEMU\s0 will try next available \s-1VNC\s0 _display_s, until the
      number _L_, if the origianlly defined "-vnc _display_" is not
      available, e.g. port 5900+_display_ is already used by another
      application. By default, to=0.
    * _host_**:**_d_  
      .IX Item "host:d"
      \s-1TCP\s0 connections will only be allowed from _host_ on display _d_.
      By convention the \s-1TCP\s0 port is 5900+_d_. Optionally, _host_ can
      be omitted in which case the server will accept connections from any host.
    * **unix:**_path_  
      .IX Item "unix:path"
      Connections will be allowed over \s-1UNIX\s0 domain sockets where _path_ is the
      location of a unix socket to listen for connections on.
    * **none**  
      .IX Item "none"
      \s-1VNC\s0 is initialized but not started. The monitor \f(CW`change\*(C' command
      can be used to later start the \s-1VNC\s0 server.
      .Sp
      Following the _display_ value there may be one or more _option_ flags
      separated by commas. Valid options are
    * **reverse**  
      .IX Item "reverse"
      Connect to a listening \s-1VNC\s0 client via a reverse\*(R" connection. The
      client is specified by the _display_. For reverse network
      connections (_host_:_d_,\f(CW`reverse\*(C'), the _d_ argument
      is a \s-1TCP\s0 port number, not a display number.
    * **websocket**  
      .IX Item "websocket"
      Opens an additional \s-1TCP\s0 listening port dedicated to \s-1VNC\s0 Websocket connections.
      If a bare _websocket_ option is given, the Websocket port is
      5700+_display_. An alternative port can be specified with the
      syntax \f(CW`websocket\*(C'=_port_.
      .Sp
      If _host_ is specified connections will only be allowed from this host.
      It is possible to control the websocket listen address independently, using
      the syntax \f(CW`websocket\*(C'=_host_:_port_.
      .Sp
      If no \s-1TLS\s0 credentials are provided, the websocket connection runs in
      unencrypted mode. If \s-1TLS\s0 credentials are provided, the websocket connection
      requires encrypted client connections.
    * **password**  
      .IX Item "password"
      Require that password based authentication is used for client connections.
      .Sp
      The password must be set separately using the \f(CW`set\_password\*(C' command in
      the **pcsys\_monitor**. The syntax to change your password is:
      \f(CW`set_password &lt;protocol&gt; &lt;password&gt;\*(C' where &lt;protocol&gt; could be either
      vnc\*(R" or \*(L"spice\*(R".
      .Sp
      If you would like to change &lt;protocol&gt; password expiration, you should use
      \f(CW`expire_password &lt;protocol&gt; &lt;expiration-time&gt;\*(C' where expiration time could
      be one of the following options: now, never, +seconds or \s-1UNIX\s0 time of
      expiration, e.g. +60 to make password expire in 60 seconds, or 1335196800
      to make password expire on Mon Apr 23 12:00:00 \s-1EDT 2012\*(R"\s0 (\s-1UNIX\s0 time for this
      date and time).
      .Sp
      You can also use keywords now\*(R" or \*(L"never\*(R" for the expiration time to
      allow &lt;protocol&gt; password to expire immediately or never expire.
    * **tls-creds=**_\s-1ID\s0_  
      .IX Item "tls-creds=ID"
      Provides the \s-1ID\s0 of a set of \s-1TLS\s0 credentials to use to secure the
      \s-1VNC\s0 server. They will apply to both the normal \s-1VNC\s0 server socket
      and the websocket socket (if enabled). Setting \s-1TLS\s0 credentials
      will cause the \s-1VNC\s0 server socket to enable the VeNCrypt auth
      mechanism.  The credentials should have been previously created
      using the **-object tls-creds** argument.
    * **sasl**  
      .IX Item "sasl"
      Require that the client use \s-1SASL\s0 to authenticate with the \s-1VNC\s0 server.
      The exact choice of authentication method used is controlled from the
      system / user's \s-1SASL\s0 configuration file for the 'qemu' service. This
      is typically found in /etc/sasl2/qemu.conf. If running \s-1QEMU\s0 as an
      unprivileged user, an environment variable \s-1SASL_CONF_PATH\s0 can be used
      to make it search alternate locations for the service config.
      While some \s-1SASL\s0 auth methods can also provide data encryption (eg \s-1GSSAPI\s0),
      it is recommended that \s-1SASL\s0 always be combined with the 'tls' and
      'x509' settings to enable use of \s-1SSL\s0 and server certificates. This
      ensures a data encryption preventing compromise of authentication
      credentials. See the **vnc\_security** section for details on using
      \s-1SASL\s0 authentication.
    * **acl**  
      .IX Item "acl"
      Turn on access control lists for checking of the x509 client certificate
      and \s-1SASL\s0 party. For x509 certs, the \s-1ACL\s0 check is made against the
      certificate's distinguished name. This is something that looks like
      \f(CW`C=GB,O=ACME,L=Boston,CN=bob\*(C'. For \s-1SASL\s0 party, the \s-1ACL\s0 check is
      made against the username, which depending on the \s-1SASL\s0 plugin, may
      include a realm component, eg \f(CW`bob\*(C' or \f(CW\*(C\`bob@EXAMPLE.COM\*(C'.
      When the **acl** flag is set, the initial access list will be
      empty, with a \f(CW`deny\*(C' policy. Thus no one will be allowed to
      use the \s-1VNC\s0 server until the ACLs have been loaded. This can be
      achieved using the \f(CW`acl\*(C' monitor command.
    * **lossy**  
      .IX Item "lossy"
      Enable lossy compression methods (gradient, \s-1JPEG, ...\s0). If this
      option is set, \s-1VNC\s0 client may receive lossy framebuffer updates
      depending on its encoding settings. Enabling this option can save
      a lot of bandwidth at the expense of quality.
    * **non-adaptive**  
      .IX Item "non-adaptive"
      Disable adaptive encodings. Adaptive encodings are enabled by default.
      An adaptive encoding will try to detect frequently updated screen regions,
      and send updates in these regions using a lossy encoding (like \s-1JPEG\s0).
      This can be really helpful to save bandwidth when playing videos. Disabling
      adaptive encodings restores the original static behavior of encodings
      like Tight.
    * **share=[allow-exclusive|force-shared|ignore]**  
      .IX Item "share=[allow-exclusive|force-shared|ignore]"
      Set display sharing policy.  'allow-exclusive' allows clients to ask
      for exclusive access.  As suggested by the rfb spec this is
      implemented by dropping other connections.  Connecting multiple
      clients in parallel requires all clients asking for a shared session
      (vncviewer: -shared switch).  This is the default.  'force-shared'
      disables exclusive client access.  Useful for shared desktop sessions,
      where you don't want someone forgetting specify -shared disconnect
      everybody else.  'ignore' completely ignores the shared flag and
      allows everybody connect unconditionally.  Doesn't conform to the rfb
      spec but is traditional \s-1QEMU\s0 behavior.
    * **key-delay-ms**  
      .IX Item "key-delay-ms"
      Set keyboard delay, for key down and key up events, in milliseconds.
      Default is 10.  Keyboards are low-bandwidth devices, so this slowdown
      can help the device and guest to keep up and not lose events in case
      events are arriving in bulk.  Possible causes for the latter are flaky
      network connections, or scripts for automated testing.

_i386 target only_
.IX Subsection "i386 target only"

* **-win2k-hack**  
  .IX Item "-win2k-hack"
  Use it when installing Windows 2000 to avoid a disk full bug. After
  Windows 2000 is installed, you no longer need this option (this option
  slows down the \s-1IDE\s0 transfers).
* **-no-fd-bootchk**  
  .IX Item "-no-fd-bootchk"
  Disable boot signature checking for floppy disks in \s-1BIOS.\s0 May
  be needed to boot from old floppy disks.
* **-no-acpi**  
  .IX Item "-no-acpi"
  Disable \s-1ACPI\s0 (Advanced Configuration and Power Interface) support. Use
  it if your guest \s-1OS\s0 complains about \s-1ACPI\s0 problems (\s-1PC\s0 target machine
  only).
* **-no-hpet**  
  .IX Item "-no-hpet"
  Disable \s-1HPET\s0 support.
* **-acpitable [sig=**_str_**][,rev=**_n_**][,oem\_id=**_str_**][,oem\_table\_id=**_str_**][,oem\_rev=**_n_**] [,asl\_compiler\_id=**_str_**][,asl\_compiler\_rev=**_n_**][,data=**_file1_**[:**_file2_**]...]**  
  .IX Item "-acpitable [sig=str][,rev=n][,oem_id=str][,oem_table_id=str][,oem_rev=n] [,asl_compiler_id=str][,asl_compiler_rev=n][,data=file1[:file2]...]"
  Add \s-1ACPI\s0 table with specified header fields and context from specified files.
  For file=, take whole \s-1ACPI\s0 table from the specified files, including all
  \s-1ACPI\s0 headers (possible overridden by other options).
  For data=, only data
  portion of the table is used, all header information is specified in the
  command line.
  If a \s-1SLIC\s0 table is supplied to \s-1QEMU,\s0 then the \s-1SLIC\s0's oem_id and oem_table_id
  fields will override the same in the \s-1RSDT\s0 and the \s-1FADT\s0 (a.k.a. \s-1FACP\s0), in order
  to ensure the field matches required by the Microsoft \s-1SLIC\s0 spec and the \s-1ACPI\s0
  spec.
* **-smbios file=**_binary_  
  .IX Item "-smbios file=binary"
  Load \s-1SMBIOS\s0 entry from binary file.
* **-smbios type=0[,vendor=**_str_**][,version=**_str_**][,date=**_str_**][,release=**_\f(CI%d.%d_**][,uefi=on|off]**  
  .IX Item "-smbios type=0[,vendor=str][,version=str][,date=str][,release=%d.%d][,uefi=on|off]"
  Specify \s-1SMBIOS\s0 type 0 fields
* **-smbios type=1[,manufacturer=**_str_**][,product=**_str_**][,version=**_str_**][,serial=**_str_**][,uuid=**_uuid_**][,sku=**_str_**][,family=**_str_**]**  
  .IX Item "-smbios type=1[,manufacturer=str][,product=str][,version=str][,serial=str][,uuid=uuid][,sku=str][,family=str]"
  Specify \s-1SMBIOS\s0 type 1 fields
* **-smbios type=2[,manufacturer=**_str_**][,product=**_str_**][,version=**_str_**][,serial=**_str_**][,asset=**_str_**][,location=**_str_**][,family=**_str_**]**  
  .IX Item "-smbios type=2[,manufacturer=str][,product=str][,version=str][,serial=str][,asset=str][,location=str][,family=str]"
  Specify \s-1SMBIOS\s0 type 2 fields
* **-smbios type=3[,manufacturer=**_str_**][,version=**_str_**][,serial=**_str_**][,asset=**_str_**][,sku=**_str_**]**  
  .IX Item "-smbios type=3[,manufacturer=str][,version=str][,serial=str][,asset=str][,sku=str]"
  Specify \s-1SMBIOS\s0 type 3 fields
* **-smbios type=4[,sock\_pfx=**_str_**][,manufacturer=**_str_**][,version=**_str_**][,serial=**_str_**][,asset=**_str_**][,part=**_str_**]**  
  .IX Item "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str]"
  Specify \s-1SMBIOS\s0 type 4 fields
* **-smbios type=17[,loc\_pfx=**_str_**][,bank=**_str_**][,manufacturer=**_str_**][,serial=**_str_**][,asset=**_str_**][,part=**_str_**][,speed=**_\f(CI%d_**]**  
  .IX Item "-smbios type=17[,loc_pfx=str][,bank=str][,manufacturer=str][,serial=str][,asset=str][,part=str][,speed=%d]"
  Specify \s-1SMBIOS\s0 type 17 fields

_Network options_
.IX Subsection "Network options"

* **-nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=macaddr][,model=mn]**  
  .IX Item "-nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=macaddr][,model=mn]"
  This option is a shortcut for configuring both the on-board (default) guest
  \s-1NIC\s0 hardware and the host network backend in one go. The host backend options
  are the same as with the corresponding **-netdev** options below.
  The guest \s-1NIC\s0 model can be set with **model=**_modelname_.
  Use **model=help** to list the available device types.
  The hardware \s-1MAC\s0 address can be set with **mac=**_macaddr_.
  .Sp
  The following two example do exactly the same, to show how **-nic** can
  be used to shorten the command line length (note that the e1000 is the default
  on i386, so the **model=e1000** parameter could even be omitted here, too):
  .Sp
  .Vb 2
          qemu-system-i386 -netdev user,id=n1,ipv6=off -device e1000,netdev=n1,mac=52:54:98:76:54:32
          qemu-system-i386 -nic user,ipv6=off,model=e1000,mac=52:54:98:76:54:32
  .Ve
* **-nic none**  
  .IX Item "-nic none"
  Indicate that no network devices should be configured. It is used to override
  the default configuration (default \s-1NIC\s0 with user\*(R" host network backend)
  which is activated if no other networking options are provided.
* **-netdev user,id=**_id_**[,**_option_**][,**_option_**][,...]**  
  .IX Item "-netdev user,id=id[,option][,option][,...]"
  Configure user mode host network backend which requires no administrator
  privilege to run. Valid options are:
    * **id=**_id_  
      .IX Item "id=id"
      Assign symbolic name for use in monitor commands.
    * **ipv4=on|off and ipv6=on|off**  
      .IX Item "ipv4=on|off and ipv6=on|off"
      Specify that either IPv4 or IPv6 must be enabled. If neither is specified
      both protocols are enabled.
    * **net=**_addr_**[/**_mask_**]**  
      .IX Item "net=addr[/mask]"
      Set \s-1IP\s0 network address the guest will see. Optionally specify the netmask,
      either in the form a.b.c.d or as number of valid top-most bits. Default is
      10.0.2.0/24.
    * **host=**_addr_  
      .IX Item "host=addr"
      Specify the guest-visible address of the host. Default is the 2nd \s-1IP\s0 in the
      guest network, i.e. x.x.x.2.
    * **ipv6-net=**_addr_**[/**_int_**]**  
      .IX Item "ipv6-net=addr[/int]"
      Set IPv6 network address the guest will see (default is fec0::/64). The
      network prefix is given in the usual hexadecimal IPv6 address
      notation. The prefix size is optional, and is given as the number of
      valid top-most bits (default is 64).
    * **ipv6-host=**_addr_  
      .IX Item "ipv6-host=addr"
      Specify the guest-visible IPv6 address of the host. Default is the 2nd IPv6 in
      the guest network, i.e. xxxx::2.
    * **restrict=on|off**  
      .IX Item "restrict=on|off"
      If this option is enabled, the guest will be isolated, i.e. it will not be
      able to contact the host and no guest \s-1IP\s0 packets will be routed over the host
      to the outside. This option does not affect any explicitly set forwarding rules.
    * **hostname=**_name_  
      .IX Item "hostname=name"
      Specifies the client hostname reported by the built-in \s-1DHCP\s0 server.
    * **dhcpstart=**_addr_  
      .IX Item "dhcpstart=addr"
      Specify the first of the 16 IPs the built-in \s-1DHCP\s0 server can assign. Default
      is the 15th to 31st \s-1IP\s0 in the guest network, i.e. x.x.x.15 to x.x.x.31.
    * **dns=**_addr_  
      .IX Item "dns=addr"
      Specify the guest-visible address of the virtual nameserver. The address must
      be different from the host address. Default is the 3rd \s-1IP\s0 in the guest network,
      i.e. x.x.x.3.
    * **ipv6-dns=**_addr_  
      .IX Item "ipv6-dns=addr"
      Specify the guest-visible address of the IPv6 virtual nameserver. The address
      must be different from the host address. Default is the 3rd \s-1IP\s0 in the guest
      network, i.e. xxxx::3.
    * **dnssearch=**_domain_  
      .IX Item "dnssearch=domain"
      Provides an entry for the domain-search list sent by the built-in
      \s-1DHCP\s0 server. More than one domain suffix can be transmitted by specifying
      this option multiple times. If supported, this will cause the guest to
      automatically try to append the given domain suffix(es) in case a domain name
      can not be resolved.
      .Sp
      Example:
      .Sp
      .Vb 1
              qemu-system-i386 -nic user,dnssearch=mgmt.example.org,dnssearch=example.org
      .Ve
    * **domainname=**_domain_  
      .IX Item "domainname=domain"
      Specifies the client domain name reported by the built-in \s-1DHCP\s0 server.
    * **tftp=**_dir_  
      .IX Item "tftp=dir"
      When using the user mode network stack, activate a built-in \s-1TFTP\s0
      server. The files in _dir_ will be exposed as the root of a \s-1TFTP\s0 server.
      The \s-1TFTP\s0 client on the guest must be configured in binary mode (use the command
      \f(CW`bin\*(C' of the Unix \s-1TFTP\s0 client).
    * **tftp-server-name=**_name_  
      .IX Item "tftp-server-name=name"
      In \s-1BOOTP\s0 reply, broadcast _name_ as the \s-1TFTP\s0 server name\*(R" (\s-1RFC2132\s0 option
      66). This can be used to advise the guest to load boot files or configurations
      from a different server than the host address.
    * **bootfile=**_file_  
      .IX Item "bootfile=file"
      When using the user mode network stack, broadcast _file_ as the \s-1BOOTP\s0
      filename. In conjunction with **tftp**, this can be used to network boot
      a guest from a local directory.
      .Sp
      Example (using pxelinux):
      .Sp
      .Vb 2
              qemu-system-i386 -hda linux.img -boot n -device e1000,netdev=n1 \e
              -netdev user,id=n1,tftp=/path/to/tftp/files,bootfile=/pxelinux.0
      .Ve
    * **smb=**_dir_**[,smbserver=**_addr_**]**  
      .IX Item "smb=dir[,smbserver=addr]"
      When using the user mode network stack, activate a built-in \s-1SMB\s0
      server so that Windows OSes can access to the host files in _dir_
      transparently. The \s-1IP\s0 address of the \s-1SMB\s0 server can be set to _addr_. By
      default the 4th \s-1IP\s0 in the guest network is used, i.e. x.x.x.4.
      .Sp
      In the guest Windows \s-1OS,\s0 the line:
      .Sp
      .Vb 1
              10.0.2.4 smbserver
      .Ve
      .Sp
      must be added in the file _C:\eWINDOWS\eLMHOSTS_ (for windows 9x/Me)
      or _C:\eWINNT\eSYSTEM32\eDRIVERS\eETC\eLMHOSTS_ (Windows \s-1NT/2000\s0).
      .Sp
      Then _dir_ can be accessed in _\e\esmbserver\eqemu_.
      .Sp
      Note that a \s-1SAMBA\s0 server must be installed on the host \s-1OS.\s0
    * **hostfwd=[tcp|udp]:[**_hostaddr_**]:**_hostport_**-[**_guestaddr_**]:**_guestport_  
      .IX Item "hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport"
      Redirect incoming \s-1TCP\s0 or \s-1UDP\s0 connections to the host port _hostport_ to
      the guest \s-1IP\s0 address _guestaddr_ on guest port _guestport_. If
      _guestaddr_ is not specified, its value is x.x.x.15 (default first address
      given by the built-in \s-1DHCP\s0 server). By specifying _hostaddr_, the rule can
      be bound to a specific host interface. If no connection type is set, \s-1TCP\s0 is
      used. This option can be given multiple times.
      .Sp
      For example, to redirect host X11 connection from screen 1 to guest
      screen 0, use the following:
      .Sp
      .Vb 4
              # on the host
              qemu-system-i386 -nic user,hostfwd=tcp:127.0.0.1:6001-:6000
              # this host xterm should open in the guest X11 server
              xterm -display :1
      .Ve
      .Sp
      To redirect telnet connections from host port 5555 to telnet port on
      the guest, use the following:
      .Sp
      .Vb 3
              # on the host
              qemu-system-i386 -nic user,hostfwd=tcp::5555-:23
              telnet localhost 5555
      .Ve
      .Sp
      Then when you use on the host \f(CW`telnet localhost 5555\*(C', you
      connect to the guest telnet server.
    * **guestfwd=[tcp]:**_server_**:**_port_**-**_dev_  
      .IX Item "guestfwd=[tcp]:server:port-dev"
    * **guestfwd=[tcp]:**_server_**:**_port_**-**_cmd:command_  
      .IX Item "guestfwd=[tcp]:server:port-cmd:command"
      Forward guest \s-1TCP\s0 connections to the \s-1IP\s0 address _server_ on port _port_
      to the character device _dev_ or to a program executed by _cmd:command_
      which gets spawned for each connection. This option can be given multiple times.
      .Sp
      You can either use a chardev directly and have that one used throughout \s-1QEMU\s0's
      lifetime, like in the following example:
      .Sp
      .Vb 3
              # open 10.10.1.1:4321 on bootup, connect 10.0.2.100:1234 to it whenever
              # the guest accesses it
              qemu-system-i386 -nic user,guestfwd=tcp:10.0.2.100:1234-tcp:10.10.1.1:4321
      .Ve
      .Sp
      Or you can execute a command on every \s-1TCP\s0 connection established by the guest,
      so that \s-1QEMU\s0 behaves similar to an inetd process for that virtual server:
      .Sp
      .Vb 3
              # call "netcat 10.10.1.1 4321" on every TCP connection to 10.0.2.100:1234
              # and connect the TCP stream to its stdin/stdout
              qemu-system-i386 -nic  user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321\*(Aq
      .Ve
* **-netdev tap,id=**_id_**[,fd=**_h_**][,ifname=**_name_**][,script=**_file_**][,downscript=**_dfile_**][,br=**_bridge_**][,helper=**_helper_**]**  
  .IX Item "-netdev tap,id=id[,fd=h][,ifname=name][,script=file][,downscript=dfile][,br=bridge][,helper=helper]"
  Configure a host \s-1TAP\s0 network backend with \s-1ID\s0 _id_.
  .Sp
  Use the network script _file_ to configure it and the network script
  _dfile_ to deconfigure it. If _name_ is not provided, the \s-1OS\s0
  automatically provides one. The default network configure script is
  _/etc/qemu-ifup_ and the default network deconfigure script is
  _/etc/qemu-ifdown_. Use **script=no** or **downscript=no**
  to disable script execution.
  .Sp
  If running \s-1QEMU\s0 as an unprivileged user, use the network helper
  _helper_ to configure the \s-1TAP\s0 interface and attach it to the bridge.
  The default network helper executable is _/path/to/qemu-bridge-helper_
  and the default bridge device is _br0_.
  .Sp
  **fd**=_h_ can be used to specify the handle of an already
  opened host \s-1TAP\s0 interface.
  .Sp
  Examples:
  .Sp
  .Vb 2
          #launch a QEMU instance with the default network script
          qemu-system-i386 linux.img -nic tap
  
  
          
          #launch a QEMU instance with two NICs, each one connected
          #to a TAP device
          qemu-system-i386 linux.img \e
          -netdev tap,id=nd0,ifname=tap0 -device e1000,netdev=nd0 \e
          -netdev tap,id=nd1,ifname=tap1 -device rtl8139,netdev=nd1
  
  
          
          #launch a QEMU instance with the default network helper to
          #connect a TAP device to bridge br0
          qemu-system-i386 linux.img -device virtio-net-pci,netdev=n1 \e
          -netdev tap,id=n1,"helper=/path/to/qemu-bridge-helper"
  .Ve
* **-netdev bridge,id=**_id_**[,br=**_bridge_**][,helper=**_helper_**]**  
  .IX Item "-netdev bridge,id=id[,br=bridge][,helper=helper]"
  Connect a host \s-1TAP\s0 network interface to a host bridge device.
  .Sp
  Use the network helper _helper_ to configure the \s-1TAP\s0 interface and
  attach it to the bridge. The default network helper executable is
  _/path/to/qemu-bridge-helper_ and the default bridge
  device is _br0_.
  .Sp
  Examples:
  .Sp
  .Vb 3
          #launch a QEMU instance with the default network helper to
          #connect a TAP device to bridge br0
          qemu-system-i386 linux.img -netdev bridge,id=n1 -device virtio-net,netdev=n1
  
  
          
          #launch a QEMU instance with the default network helper to
          #connect a TAP device to bridge qemubr0
          qemu-system-i386 linux.img -netdev bridge,br=qemubr0,id=n1 -device virtio-net,netdev=n1
  .Ve
* **-netdev socket,id=**_id_**[,fd=**_h_**][,listen=[**_host_**]:**_port_**][,connect=**_host_**:**_port_**]**  
  .IX Item "-netdev socket,id=id[,fd=h][,listen=[host]:port][,connect=host:port]"
  This host network backend can be used to connect the guest's network to
  another \s-1QEMU\s0 virtual machine using a \s-1TCP\s0 socket connection. If **listen**
  is specified, \s-1QEMU\s0 waits for incoming connections on _port_
  (_host_ is optional). **connect** is used to connect to
  another \s-1QEMU\s0 instance using the **listen** option. **fd**=_h_
  specifies an already opened \s-1TCP\s0 socket.
  .Sp
  Example:
  .Sp
  .Vb 8
          # launch a first QEMU instance
          qemu-system-i386 linux.img \e
          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \e
          -netdev socket,id=n1,listen=:1234
          # connect the network of this instance to the network of the first instance
          qemu-system-i386 linux.img \e
          -device e1000,netdev=n2,mac=52:54:00:12:34:57 \e
          -netdev socket,id=n2,connect=127.0.0.1:1234
  .Ve
* **-netdev socket,id=**_id_**[,fd=**_h_**][,mcast=**_maddr_**:**_port_**[,localaddr=**_addr_**]]**  
  .IX Item "-netdev socket,id=id[,fd=h][,mcast=maddr:port[,localaddr=addr]]"
  Configure a socket host network backend to share the guest's network traffic
  with another \s-1QEMU\s0 virtual machines using a \s-1UDP\s0 multicast socket, effectively
  making a bus for every \s-1QEMU\s0 with same multicast address _maddr_ and _port_.
  \s-1NOTES:\s0
    * 1.  
      Several \s-1QEMU\s0 can be running on different hosts and share same bus (assuming
      correct multicast setup for these hosts).
    * 2.  
      mcast support is compatible with User Mode Linux (argument **eth**_N_**=mcast**), see
      &lt;**http://user-mode-linux.sf.net**&gt;.
    * 3.  
      Use **fd=h** to specify an already opened \s-1UDP\s0 multicast socket.
      .Sp
      Example:
      .Sp
      .Vb 12
              # launch one QEMU instance
              qemu-system-i386 linux.img \e
              -device e1000,netdev=n1,mac=52:54:00:12:34:56 \e
              -netdev socket,id=n1,mcast=230.0.0.1:1234
              # launch another QEMU instance on same "bus"
              qemu-system-i386 linux.img \e
              -device e1000,netdev=n2,mac=52:54:00:12:34:57 \e
              -netdev socket,id=n2,mcast=230.0.0.1:1234
              # launch yet another QEMU instance on same "bus"
              qemu-system-i386 linux.img \e
              -device e1000,netdev=n3,mac=52:54:00:12:34:58 \e
              -netdev socket,id=n3,mcast=230.0.0.1:1234
      .Ve
      .Sp
      Example (User Mode Linux compat.):
      .Sp
      .Vb 6
              # launch QEMU instance (note mcast address selected is UMLs default)
              qemu-system-i386 linux.img \e
              -device e1000,netdev=n1,mac=52:54:00:12:34:56 \e
              -netdev socket,id=n1,mcast=239.192.168.1:1102
              # launch UML
              /path/to/linux ubd0=/path/to/root_fs eth0=mcast
      .Ve
      .Sp
      Example (send packets from host's 1.2.3.4):
      .Sp
      .Vb 3
              qemu-system-i386 linux.img \e
              -device e1000,netdev=n1,mac=52:54:00:12:34:56 \e
              -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
      .Ve
* **-netdev l2tpv3,id=**_id_**,src=**_srcaddr_**,dst=**_dstaddr_**[,srcport=**_srcport_**][,dstport=**_dstport_**],txsession=**_txsession_**[,rxsession=**_rxsession_**][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=**_txcookie_**][,rxcookie=**_rxcookie_**][,offset=**_offset_**]**  
  .IX Item "-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]"
  Configure a L2TPv3 pseudowire host network backend. L2TPv3 (\s-1RFC3391\s0) is a
  popular protocol to transport Ethernet (and other Layer 2) data frames between
  two systems. It is present in routers, firewalls and the Linux kernel
  (from version 3.3 onwards).
  .Sp
  This transport allows a \s-1VM\s0 to communicate to another \s-1VM,\s0 router or firewall directly.
    * **src=**_srcaddr_  
      .IX Item "src=srcaddr"
      source address (mandatory)
    * **dst=**_dstaddr_  
      .IX Item "dst=dstaddr"
      destination address (mandatory)
    * **udp**  
      .IX Item "udp"
      select udp encapsulation (default is ip).
    * **srcport=**_srcport_  
      .IX Item "srcport=srcport"
      source udp port.
    * **dstport=**_dstport_  
      .IX Item "dstport=dstport"
      destination udp port.
    * **ipv6**  
      .IX Item "ipv6"
      force v6, otherwise defaults to v4.
    * **rxcookie=**_rxcookie_  
      .IX Item "rxcookie=rxcookie"
    * **txcookie=**_txcookie_  
      .IX Item "txcookie=txcookie"
      Cookies are a weak form of security in the l2tpv3 specification.
      Their function is mostly to prevent misconfiguration. By default they are 32
      bit.
    * **cookie64**  
      .IX Item "cookie64"
      Set cookie size to 64 bit instead of the default 32
    * **counter=off**  
      .IX Item "counter=off"
      Force a 'cut-down' L2TPv3 with no counter as in
      draft-mkonstan-l2tpext-keyed-ipv6-tunnel-00
    * **pincounter=on**  
      .IX Item "pincounter=on"
      Work around broken counter handling in peer. This may also help on
      networks which have packet reorder.
    * **offset=**_offset_  
      .IX Item "offset=offset"
      Add an extra offset between header and data
      .Sp
      For example, to attach a \s-1VM\s0 running on host 4.3.2.1 via L2TPv3 to the bridge br-lan
      on the remote Linux host 1.2.3.4:
      .Sp
      .Vb 9
              # Setup tunnel on linux host using raw ip as encapsulation
              # on 1.2.3.4
              ip l2tp add tunnel remote 4.3.2.1 local 1.2.3.4 tunnel_id 1 peer_tunnel_id 1 \e
              encap udp udp_sport 16384 udp_dport 16384
              ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \e
              0xFFFFFFFF peer_session_id 0xFFFFFFFF
              ifconfig vmtunnel0 mtu 1500
              ifconfig vmtunnel0 up
              brctl addif br-lan vmtunnel0
              
              
              # on 4.3.2.1
              # launch QEMU instance - if your network has reorder or is very lossy add ,pincounter
              
              qemu-system-i386 linux.img -device e1000,netdev=n1 \e
              -netdev l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
      .Ve
* **-netdev vde,id=**_id_**[,sock=**_socketpath_**][,port=**_n_**][,group=**_groupname_**][,mode=**_octalmode_**]**  
  .IX Item "-netdev vde,id=id[,sock=socketpath][,port=n][,group=groupname][,mode=octalmode]"
  Configure \s-1VDE\s0 backend to connect to \s-1PORT\s0 _n_ of a vde switch running on host and
  listening for incoming connections on _socketpath_. Use \s-1GROUP\s0 _groupname_
  and \s-1MODE\s0 _octalmode_ to change default ownership and permissions for
  communication port. This option is only available if \s-1QEMU\s0 has been compiled
  with vde support enabled.
  .Sp
  Example:
  .Sp
  .Vb 4
          # launch vde switch
          vde_switch -F -sock /tmp/myswitch
          # launch QEMU instance
          qemu-system-i386 linux.img -nic vde,sock=/tmp/myswitch
  .Ve
* **-netdev vhost-user,chardev=**_id_**[,vhostforce=on|off][,queues=n]**  
  .IX Item "-netdev vhost-user,chardev=id[,vhostforce=on|off][,queues=n]"
  Establish a vhost-user netdev, backed by a chardev _id_. The chardev should
  be a unix domain socket backed one. The vhost-user uses a specifically defined
  protocol to pass vhost ioctl replacement messages to an application on the other
  end of the socket. On non-MSIX guests, the feature can be forced with
  _vhostforce_. Use 'queues=_n_' to specify the number of queues to
  be created for multiqueue vhost-user.
  .Sp
  Example:
  .Sp
  .Vb 5
          qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,share=on \e
          -numa node,memdev=mem \e
          -chardev socket,id=chr0,path=/path/to/socket \e
          -netdev type=vhost-user,id=net0,chardev=chr0 \e
          -device virtio-net-pci,netdev=net0
  .Ve
* **-netdev hubport,id=**_id_**,hubid=**_hubid_**[,netdev=**_nd_**]**  
  .IX Item "-netdev hubport,id=id,hubid=hubid[,netdev=nd]"
  Create a hub port on the emulated hub with \s-1ID\s0 _hubid_.
  .Sp
  The hubport netdev lets you connect a \s-1NIC\s0 to a \s-1QEMU\s0 emulated hub instead of a
  single netdev. Alternatively, you can also connect the hubport to another
  netdev with \s-1ID\s0 _nd_ by using the **netdev=**_nd_ option.
* **-net nic[,netdev=**_nd_**][,macaddr=**_mac_**][,model=**_type_**] [,name=**_name_**][,addr=**_addr_**][,vectors=**_v_**]**  
  .IX Item "-net nic[,netdev=nd][,macaddr=mac][,model=type] [,name=name][,addr=addr][,vectors=v]"
  Legacy option to configure or create an on-board (or machine default) Network
  Interface Card(\s-1NIC\s0) and connect it either to the emulated hub with \s-1ID 0\s0 (i.e.
  the default hub), or to the netdev _nd_.
  The \s-1NIC\s0 is an e1000 by default on the \s-1PC\s0 target. Optionally, the \s-1MAC\s0 address
  can be changed to _mac_, the device address set to _addr_ (\s-1PCI\s0 cards
  only), and a _name_ can be assigned for use in monitor commands.
  Optionally, for \s-1PCI\s0 cards, you can specify the number _v_ of MSI-X vectors
  that the card should have; this option currently only affects virtio cards; set
  _v_ = 0 to disable MSI-X. If no **-net** option is specified, a single
  \s-1NIC\s0 is created.  \s-1QEMU\s0 can emulate several different models of network card.
  Use \f(CW`-net nic,model=help\*(C' for a list of available devices for your target.
* **-net user|tap|bridge|socket|l2tpv3|vde[,...][,name=**_name_**]**  
  .IX Item "-net user|tap|bridge|socket|l2tpv3|vde[,...][,name=name]"
  Configure a host network backend (with the options corresponding to the same
  **-netdev** option) and connect it to the emulated hub 0 (the default
  hub). Use _name_ to specify the name of the hub port.

_Character device options_
.IX Subsection "Character device options"

The general form of a character device option is:

* **-chardev** _backend_**,id=**_id_**[,mux=on|off][,**_options_**]**  
  .IX Item "-chardev backend,id=id[,mux=on|off][,options]"
  Backend is one of:
  **null**,
  **socket**,
  **udp**,
  **msmouse**,
  **vc**,
  **ringbuf**,
  **file**,
  **pipe**,
  **console**,
  **serial**,
  **pty**,
  **stdio**,
  **braille**,
  **tty**,
  **parallel**,
  **parport**,
  **spicevmc**,
  **spiceport**.
  The specific backend will determine the applicable options.
  .Sp
  Use \f(CW`-chardev help\*(C' to print all available chardev backend types.
  .Sp
  All devices must have an id, which can be any string up to 127 characters long.
  It is used to uniquely identify this device in other command line directives.
  .Sp
  A character device may be used in multiplexing mode by multiple front-ends.
  Specify **mux=on** to enable this mode.
  A multiplexer is a 1:N\*(R" device, and here the \*(L"1\*(R" end is your specified chardev
  backend, and the N\*(R" end is the various parts of \s-1QEMU\s0 that can talk to a chardev.
  If you create a chardev with **id=myid** and **mux=on**, \s-1QEMU\s0 will
  create a multiplexer with your specified \s-1ID,\s0 and you can then configure multiple
  front ends to use that chardev \s-1ID\s0 for their input/output. Up to four different
  front ends can be connected to a single multiplexed chardev. (Without
  multiplexing enabled, a chardev can only be used by a single front end.)
  For instance you could use this to allow a single stdio chardev to be used by
  two serial ports and the \s-1QEMU\s0 monitor:
  .Sp
  .Vb 4
          -chardev stdio,mux=on,id=char0 \e
          -mon chardev=char0,mode=readline \e
          -serial chardev:char0 \e
          -serial chardev:char0
  .Ve
  .Sp
  You can have more than one multiplexer in a system configuration; for instance
  you could have a \s-1TCP\s0 port multiplexed between \s-1UART 0\s0 and \s-1UART 1,\s0 and stdio
  multiplexed between the \s-1QEMU\s0 monitor and a parallel port:
  .Sp
  .Vb 6
          -chardev stdio,mux=on,id=char0 \e
          -mon chardev=char0,mode=readline \e
          -parallel chardev:char0 \e
          -chardev tcp,...,mux=on,id=char1 \e
          -serial chardev:char1 \e
          -serial chardev:char1
  .Ve
  .Sp
  When you're using a multiplexed character device, some escape sequences are
  interpreted in the input.
  .Sp
  Note that some other command line options may implicitly create multiplexed
  character backends; for instance **-serial mon:stdio** creates a
  multiplexed stdio backend connected to the serial port and the \s-1QEMU\s0 monitor,
  and **-nographic** also multiplexes the console and the monitor to
  stdio.
  .Sp
  There is currently no support for multiplexing in the other direction
  (where a single \s-1QEMU\s0 front end takes input and output from multiple chardevs).
  .Sp
  Every backend supports the **logfile** option, which supplies the path
  to a file to record all data transmitted via the backend. The **logappend**
  option controls whether the log file will be truncated or appended to when
  opened.

The available backends are:

* **-chardev null,id=**_id_  
  .IX Item "-chardev null,id=id"
  A void device. This device will not emit any data, and will drop any data it
  receives. The null backend does not take any options.
* **-chardev socket,id=**_id_**[,**_\s-1TCP\s0 options_ **or** _unix options_**][,server][,nowait][,telnet][,websocket][,reconnect=**_seconds_**][,tls-creds=**_id_**]**  
  .IX Item "-chardev socket,id=id[,TCP options or unix options][,server][,nowait][,telnet][,websocket][,reconnect=seconds][,tls-creds=id]"
  Create a two-way stream socket, which can be either a \s-1TCP\s0 or a unix socket. A
  unix socket will be created if **path** is specified. Behaviour is
  undefined if \s-1TCP\s0 options are specified for a unix socket.
  .Sp
  **server** specifies that the socket shall be a listening socket.
  .Sp
  **nowait** specifies that \s-1QEMU\s0 should not block waiting for a client to
  connect to a listening socket.
  .Sp
  **telnet** specifies that traffic on the socket should interpret telnet
  escape sequences.
  .Sp
  **websocket** specifies that the socket uses WebSocket protocol for
  communication.
  .Sp
  **reconnect** sets the timeout for reconnecting on non-server sockets when
  the remote end goes away.  qemu will delay this many seconds and then attempt
  to reconnect.  Zero disables reconnecting, and is the default.
  .Sp
  **tls-creds** requests enablement of the \s-1TLS\s0 protocol for encryption,
  and specifies the id of the \s-1TLS\s0 credentials to use for the handshake. The
  credentials must be previously created with the **-object tls-creds**
  argument.
  .Sp
  \s-1TCP\s0 and unix socket options are given below:
    * **\s-1TCP\s0 options: port=**_port_**[,host=**_host_**][,to=**_to_**][,ipv4][,ipv6][,nodelay]**  
      .IX Item "TCP options: port=port[,host=host][,to=to][,ipv4][,ipv6][,nodelay]"
      **host** for a listening socket specifies the local address to be bound.
      For a connecting socket species the remote host to connect to. **host** is
      optional for listening sockets. If not specified it defaults to \f(CW0.0.0.0.
      .Sp
      **port** for a listening socket specifies the local port to be bound. For a
      connecting socket specifies the port on the remote host to connect to.
      **port** can be given as either a port number or a service name.
      **port** is required.
      .Sp
      **to** is only relevant to listening sockets. If it is specified, and
      **port** cannot be bound, \s-1QEMU\s0 will attempt to bind to subsequent ports up
      to and including **to** until it succeeds. **to** must be specified
      as a port number.
      .Sp
      **ipv4** and **ipv6** specify that either IPv4 or IPv6 must be used.
      If neither is specified the socket may use either protocol.
      .Sp
      **nodelay** disables the Nagle algorithm.
    * **unix options: path=**_path_  
      .IX Item "unix options: path=path"
      **path** specifies the local path of the unix socket. **path** is
      required.
* **-chardev udp,id=**_id_**[,host=**_host_**],port=**_port_**[,localaddr=**_localaddr_**][,localport=**_localport_**][,ipv4][,ipv6]**  
  .IX Item "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr][,localport=localport][,ipv4][,ipv6]"
  Sends all traffic from the guest to a remote host over \s-1UDP.\s0
  .Sp
  **host** specifies the remote host to connect to. If not specified it
  defaults to \f(CW`localhost\*(C'.
  .Sp
  **port** specifies the port on the remote host to connect to. **port**
  is required.
  .Sp
  **localaddr** specifies the local address to bind to. If not specified it
  defaults to \f(CW0.0.0.0.
  .Sp
  **localport** specifies the local port to bind to. If not specified any
  available local port will be used.
  .Sp
  **ipv4** and **ipv6** specify that either IPv4 or IPv6 must be used.
  If neither is specified the device may use either protocol.
* **-chardev msmouse,id=**_id_  
  .IX Item "-chardev msmouse,id=id"
  Forward \s-1QEMU\s0's emulated msmouse events to the guest. **msmouse** does not
  take any options.
* **-chardev vc,id=**_id_**[[,width=**_width_**][,height=**_height_**]][[,cols=**_cols_**][,rows=**_rows_**]]**  
  .IX Item "-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]"
  Connect to a \s-1QEMU\s0 text console. **vc** may optionally be given a specific
  size.
  .Sp
  **width** and **height** specify the width and height respectively of
  the console, in pixels.
  .Sp
  **cols** and **rows** specify that the console be sized to fit a text
  console with the given dimensions.
* **-chardev ringbuf,id=**_id_**[,size=**_size_**]**  
  .IX Item "-chardev ringbuf,id=id[,size=size]"
  Create a ring buffer with fixed size **size**.
  _size_ must be a power of two and defaults to \f(CW`64K\*(C'.
* **-chardev file,id=**_id_**,path=**_path_  
  .IX Item "-chardev file,id=id,path=path"
  Log all traffic received from the guest to a file.
  .Sp
  **path** specifies the path of the file to be opened. This file will be
  created if it does not already exist, and overwritten if it does. **path**
  is required.
* **-chardev pipe,id=**_id_**,path=**_path_  
  .IX Item "-chardev pipe,id=id,path=path"
  Create a two-way connection to the guest. The behaviour differs slightly between
  Windows hosts and other hosts:
  .Sp
  On Windows, a single duplex pipe will be created at
  _\e\e.pipe\e\f(BIpath_.
  .Sp
  On other hosts, 2 pipes will be created called _\f(BIpath.in_ and
  _\f(BIpath.out_. Data written to _\f(BIpath.in_ will be
  received by the guest. Data written by the guest can be read from
  _\f(BIpath.out_. \s-1QEMU\s0 will not create these fifos, and requires them to
  be present.
  .Sp
  **path** forms part of the pipe path as described above. **path** is
  required.
* **-chardev console,id=**_id_  
  .IX Item "-chardev console,id=id"
  Send traffic from the guest to \s-1QEMU\s0's standard output. **console** does not
  take any options.
  .Sp
  **console** is only available on Windows hosts.
* **-chardev serial,id=**_id_**,path=****path**  
  .IX Item "-chardev serial,id=id,path=path"
  Send traffic from the guest to a serial device on the host.
  .Sp
  On Unix hosts serial will actually accept any tty device,
  not only serial lines.
  .Sp
  **path** specifies the name of the serial device to open.
* **-chardev pty,id=**_id_  
  .IX Item "-chardev pty,id=id"
  Create a new pseudo-terminal on the host and connect to it. **pty** does
  not take any options.
  .Sp
  **pty** is not available on Windows hosts.
* **-chardev stdio,id=**_id_**[,signal=on|off]**  
  .IX Item "-chardev stdio,id=id[,signal=on|off]"
  Connect to standard input and standard output of the \s-1QEMU\s0 process.
  .Sp
  **signal** controls if signals are enabled on the terminal, that includes
  exiting \s-1QEMU\s0 with the key sequence **Control-c**. This option is enabled by
  default, use **signal=off** to disable it.
* **-chardev braille,id=**_id_  
  .IX Item "-chardev braille,id=id"
  Connect to a local BrlAPI server. **braille** does not take any options.
* **-chardev tty,id=**_id_**,path=**_path_  
  .IX Item "-chardev tty,id=id,path=path"
  **tty** is only available on Linux, Sun, FreeBSD, NetBSD, OpenBSD and
  DragonFlyBSD hosts.  It is an alias for **serial**.
  .Sp
  **path** specifies the path to the tty. **path** is required.
* **-chardev parallel,id=**_id_**,path=**_path_  
  .IX Item "-chardev parallel,id=id,path=path"
* **-chardev parport,id=**_id_**,path=**_path_  
  .IX Item "-chardev parport,id=id,path=path"
  **parallel** is only available on Linux, FreeBSD and DragonFlyBSD hosts.
  .Sp
  Connect to a local parallel port.
  .Sp
  **path** specifies the path to the parallel port device. **path** is
  required.
* **-chardev spicevmc,id=**_id_**,debug=**_debug_**,name=**_name_  
  .IX Item "-chardev spicevmc,id=id,debug=debug,name=name"
  **spicevmc** is only available when spice support is built in.
  .Sp
  **debug** debug level for spicevmc
  .Sp
  **name** name of spice channel to connect to
  .Sp
  Connect to a spice virtual machine channel, such as vdiport.
* **-chardev spiceport,id=**_id_**,debug=**_debug_**,name=**_name_  
  .IX Item "-chardev spiceport,id=id,debug=debug,name=name"
  **spiceport** is only available when spice support is built in.
  .Sp
  **debug** debug level for spicevmc
  .Sp
  **name** name of spice port to connect to
  .Sp
  Connect to a spice port, allowing a Spice client to handle the traffic
  identified by a name (preferably a fqdn).

_Bluetooth(R) options_
.IX Subsection "Bluetooth(R) options"

* **-bt hci[...]**  
  .IX Item "-bt hci[...]"
  Defines the function of the corresponding Bluetooth \s-1HCI.\s0  -bt options
  are matched with the HCIs present in the chosen machine type.  For
  example when emulating a machine with only one \s-1HCI\s0 built into it, only
  the first \f(CW`-bt hci[...]\*(C' option is valid and defines the \s-1HCI\s0's
  logic.  The Transport Layer is decided by the machine type.  Currently
  the machines \f(CW`n800\*(C' and \f(CW\*(C\`n810\*(C' have one \s-1HCI\s0 and all other
  machines have none.
  .Sp
  Note: This option and the whole bluetooth subsystem is considered as deprecated.
  If you still use it, please send a mail to &lt;**qemu-devel@nongnu.org**&gt; where
  you describe your usecase.
  .Sp
  The following three types are recognized:
    * **-bt hci,null**  
      .IX Item "-bt hci,null"
      (default) The corresponding Bluetooth \s-1HCI\s0 assumes no internal logic
      and will not respond to any \s-1HCI\s0 commands or emit events.
    * **-bt hci,host[:**_id_**]**  
      .IX Item "-bt hci,host[:id]"
      (\f(CW`bluez\*(C' only) The corresponding \s-1HCI\s0 passes commands / events
      to / from the physical \s-1HCI\s0 identified by the name _id_ (default:
      \f(CW`hci0\*(C') on the computer running \s-1QEMU.\s0  Only available on \f(CW\*(C\`bluez\*(C'
      capable systems like Linux.
    * **-bt hci[,vlan=**_n_**]**  
      .IX Item "-bt hci[,vlan=n]"
      Add a virtual, standard \s-1HCI\s0 that will participate in the Bluetooth
      scatternet _n_ (default \f(CW0).  Similarly to **-net**
      VLANs, devices inside a bluetooth network _n_ can only communicate
      with other devices in the same network (scatternet).
* **-bt vhci[,vlan=**_n_**]**  
  .IX Item "-bt vhci[,vlan=n]"
  (Linux-host only) Create a \s-1HCI\s0 in scatternet _n_ (default 0) attached
  to the host bluetooth stack instead of to the emulated target.  This
  allows the host and target machines to participate in a common scatternet
  and communicate.  Requires the Linux \f(CW`vhci\*(C' driver installed.  Can
  be used as following:
  .Sp
  .Vb 1
          qemu-system-i386 [...OPTIONS...] -bt hci,vlan=5 -bt vhci,vlan=5
  .Ve
* **-bt device:**_dev_**[,vlan=**_n_**]**  
  .IX Item "-bt device:dev[,vlan=n]"
  Emulate a bluetooth device _dev_ and place it in network _n_
  (default \f(CW0).  \s-1QEMU\s0 can only emulate one type of bluetooth devices
  currently:
    * **keyboard**  
      .IX Item "keyboard"
      Virtual wireless keyboard implementing the \s-1HIDP\s0 bluetooth profile.

_\s-1TPM\s0 device options_
.IX Subsection "TPM device options"

The general form of a \s-1TPM\s0 device option is:

* **-tpmdev** _backend_**,id=**_id_**[,**_options_**]**  
  .IX Item "-tpmdev backend,id=id[,options]"
  The specific backend type will determine the applicable options.
  The \f(CW`-tpmdev\*(C' option creates the \s-1TPM\s0 backend and requires a
  \f(CW`-device\*(C' option that specifies the \s-1TPM\s0 frontend interface model.
  .Sp
  Use \f(CW`-tpmdev help\*(C' to print all available \s-1TPM\s0 backend types.

The available backends are:

* **-tpmdev passthrough,id=**_id_**,path=**_path_**,cancel-path=**_cancel-path_  
  .IX Item "-tpmdev passthrough,id=id,path=path,cancel-path=cancel-path"
  (Linux-host only) Enable access to the host's \s-1TPM\s0 using the passthrough
  driver.
  .Sp
  **path** specifies the path to the host's \s-1TPM\s0 device, i.e., on
  a Linux host this would be \f(CW`/dev/tpm0\*(C'.
  **path** is optional and by default \f(CW`/dev/tpm0\*(C' is used.
  .Sp
  **cancel-path** specifies the path to the host \s-1TPM\s0 device's sysfs
  entry allowing for cancellation of an ongoing \s-1TPM\s0 command.
  **cancel-path** is optional and by default \s-1QEMU\s0 will search for the
  sysfs entry to use.
  .Sp
  Some notes about using the host's \s-1TPM\s0 with the passthrough driver:
  .Sp
  The \s-1TPM\s0 device accessed by the passthrough driver must not be
  used by any other application on the host.
  .Sp
  Since the host's firmware (\s-1BIOS/UEFI\s0) has already initialized the \s-1TPM,\s0
  the \s-1VM\s0's firmware (\s-1BIOS/UEFI\s0) will not be able to initialize the
  \s-1TPM\s0 again and may therefore not show a TPM-specific menu that would
  otherwise allow the user to configure the \s-1TPM,\s0 e.g., allow the user to
  enable/disable or activate/deactivate the \s-1TPM.\s0
  Further, if \s-1TPM\s0 ownership is released from within a \s-1VM\s0 then the host's \s-1TPM\s0
  will get disabled and deactivated. To enable and activate the
  \s-1TPM\s0 again afterwards, the host has to be rebooted and the user is
  required to enter the firmware's menu to enable and activate the \s-1TPM.\s0
  If the \s-1TPM\s0 is left disabled and/or deactivated most \s-1TPM\s0 commands will fail.
  .Sp
  To create a passthrough \s-1TPM\s0 use the following two options:
  .Sp
  .Vb 1
          -tpmdev passthrough,id=tpm0 -device tpm-tis,tpmdev=tpm0
  .Ve
  .Sp
  Note that the \f(CW`-tpmdev\*(C' id is \f(CW\*(C\`tpm0\*(C' and is referenced by
  \f(CW`tpmdev=tpm0\*(C' in the device option.
* **-tpmdev emulator,id=**_id_**,chardev=**_dev_  
  .IX Item "-tpmdev emulator,id=id,chardev=dev"
  (Linux-host only) Enable access to a \s-1TPM\s0 emulator using Unix domain socket based
  chardev backend.
  .Sp
  **chardev** specifies the unique \s-1ID\s0 of a character device backend that provides connection to the software \s-1TPM\s0 server.
  .Sp
  To create a \s-1TPM\s0 emulator backend device with chardev socket backend:
  .Sp
  .Vb 1
          -chardev socket,id=chrtpm,path=/tmp/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0
  .Ve

_Linux/Multiboot boot specific_
.IX Subsection "Linux/Multiboot boot specific"

When using these options, you can use a given Linux or Multiboot
kernel without installing it in the disk image. It can be useful
for easier testing of various kernels.

* **-kernel** _bzImage_  
  .IX Item "-kernel bzImage"
  Use _bzImage_ as kernel image. The kernel can be either a Linux kernel
  or in multiboot format.
* **-append** _cmdline_  
  .IX Item "-append cmdline"
  Use _cmdline_ as kernel command line
* **-initrd** _file_  
  .IX Item "-initrd file"
  Use _file_ as initial ram disk.
  .ie n .IP "**-initrd ""**_file1_ **arg=foo,**_file2_**""**" 4
  .el .IP "**-initrd \`\`**_file1_ **arg=foo,**_file2_**''**" 4
  .IX Item "-initrd ""file1 arg=foo,file2"""
  This syntax is only available with multiboot.
  .Sp
  Use _file1_ and _file2_ as modules and pass arg=foo as parameter to the
  first module.
* **-dtb** _file_  
  .IX Item "-dtb file"
  Use _file_ as a device tree binary (dtb) image and pass it to the kernel
  on boot.

_Debug/Expert options_
.IX Subsection "Debug/Expert options"

* **-fw_cfg [name=]**_name_**,file=**_file_  
  .IX Item "-fw_cfg [name=]name,file=file"
  Add named fw_cfg entry with contents from file _file_.
* **-fw_cfg [name=]**_name_**,string=**_str_  
  .IX Item "-fw_cfg [name=]name,string=str"
  Add named fw_cfg entry with contents from string _str_.
  .Sp
  The terminating \s-1NUL\s0 character of the contents of _str_ will not be
  included as part of the fw_cfg item data. To insert contents with
  embedded \s-1NUL\s0 characters, you have to use the _file_ parameter.
  .Sp
  The fw_cfg entries are passed by \s-1QEMU\s0 through to the guest.
  .Sp
  Example:
  .Sp
  .Vb 1
          -fw_cfg name=opt/com.mycompany/blob,file=./my_blob.bin
  .Ve
  .Sp
  creates an fw_cfg entry named opt/com.mycompany/blob with contents
  from ./my_blob.bin.
* **-serial** _dev_  
  .IX Item "-serial dev"
  Redirect the virtual serial port to host character device
  _dev_. The default device is \f(CW`vc\*(C' in graphical mode and
  \f(CW`stdio\*(C' in non graphical mode.
  .Sp
  This option can be used several times to simulate up to 4 serial
  ports.
  .Sp
  Use \f(CW`-serial none\*(C' to disable all serial ports.
  .Sp
  Available character devices are:
    * **vc[:**_W_**x**_H_**]**  
      .IX Item "vc[:WxH]"
      Virtual console. Optionally, a width and height can be given in pixel with
      .Sp
      .Vb 1
              vc:800x600
      .Ve
      .Sp
      It is also possible to specify width or height in characters:
      .Sp
      .Vb 1
              vc:80Cx24C
      .Ve
    * **pty**  
      .IX Item "pty"
      [Linux only] Pseudo \s-1TTY\s0 (a new \s-1PTY\s0 is automatically allocated)
    * **none**  
      .IX Item "none"
      No device is allocated.
    * **null**  
      .IX Item "null"
      void device
    * **chardev:**_id_  
      .IX Item "chardev:id"
      Use a named character device defined with the \f(CW`-chardev\*(C' option.
    * **/dev/XXX**  
      .IX Item "/dev/XXX"
      [Linux only] Use host tty, e.g. _/dev/ttyS0_. The host serial port
      parameters are set according to the emulated ones.
    * **/dev/parport**_N_  
      .IX Item "/dev/parportN"
      [Linux only, parallel port only] Use host parallel port
      _N_. Currently \s-1SPP\s0 and \s-1EPP\s0 parallel port features can be used.
    * **file:**_filename_  
      .IX Item "file:filename"
      Write output to _filename_. No character can be read.
    * **stdio**  
      .IX Item "stdio"
      [Unix only] standard input/output
    * **pipe:**_filename_  
      .IX Item "pipe:filename"
      name pipe _filename_
    * **\s-1COM\s0**_n_  
      .IX Item "COMn"
      [Windows only] Use host serial port _n_
    * **udp:[**_remote\_host_**]:**_remote\_port_**[@[**_src\_ip_**]:**_src\_port_**]**  
      .IX Item "udp:[remote_host]:remote_port[@[src_ip]:src_port]"
      This implements \s-1UDP\s0 Net Console.
      When _remote\_host_ or _src\_ip_ are not specified
      they default to \f(CW0.0.0.0.
      When not using a specified _src\_port_ a random port is automatically chosen.
      .Sp
      If you just want a simple readonly console you can use \f(CW`netcat\*(C' or
      \f(CW`nc\*(C', by starting \s-1QEMU\s0 with: \f(CW\*(C\`-serial udp::4555\*(C' and nc as:
      \f(CW`nc -u -l -p 4555\*(C'. Any time \s-1QEMU\s0 writes something to that port it
      will appear in the netconsole session.
      .Sp
      If you plan to send characters back via netconsole or you want to stop
      and start \s-1QEMU\s0 a lot of times, you should have \s-1QEMU\s0 use the same
      source port each time by using something like \f(CW`-serial
      udp::4555@4556 to \s-1QEMU.\s0 Another approach is to use a patched
      version of netcat which can listen to a \s-1TCP\s0 port and send and receive
      characters via udp.  If you have a patched version of netcat which
      activates telnet remote echo and single char transfer, then you can
      use the following options to set up a netcat redirector to allow
      telnet on port 5555 to access the \s-1QEMU\s0 port.
          .ie n .IP """QEMU Options:""" 4
          .el .IP "\f(CWQEMU Options:" 4
          .IX Item "QEMU Options:"
          -serial udp::4555@4556
          .ie n .IP """netcat options:""" 4
          .el .IP "\f(CWnetcat options:" 4
          .IX Item "netcat options:"
          -u -P 4555 -L 0.0.0.0:4556 -t -p 5555 -I -T
          .ie n .IP """telnet options:""" 4
          .el .IP "\f(CWtelnet options:" 4
          .IX Item "telnet options:"
          localhost 5555
    * **tcp:[**_host_**]:**_port_**[,**_server_**][,nowait][,nodelay][,reconnect=**_seconds_**]**  
      .IX Item "tcp:[host]:port[,server][,nowait][,nodelay][,reconnect=seconds]"
      The \s-1TCP\s0 Net Console has two modes of operation.  It can send the serial
      I/O to a location or wait for a connection from a location.  By default
      the \s-1TCP\s0 Net Console is sent to _host_ at the _port_.  If you use
      the _server_ option \s-1QEMU\s0 will wait for a client socket application
      to connect to the port before continuing, unless the \f(CW`nowait\*(C'
      option was specified.  The \f(CW`nodelay\*(C' option disables the Nagle buffering
      algorithm.  The \f(CW`reconnect\*(C' option only applies if _noserver_ is
      set, if the connection goes down it will attempt to reconnect at the
      given interval.  If _host_ is omitted, 0.0.0.0 is assumed. Only
      one \s-1TCP\s0 connection at a time is accepted. You can use \f(CW`telnet\*(C' to
      connect to the corresponding character device.
          .ie n .IP """Example to send tcp console to 192.168.0.2 port 4444""" 4
          .el .IP "\f(CWExample to send tcp console to 192.168.0.2 port 4444" 4
          .IX Item "Example to send tcp console to 192.168.0.2 port 4444"
          -serial tcp:192.168.0.2:4444
          .ie n .IP """Example to listen and wait on port 4444 for connection""" 4
          .el .IP "\f(CWExample to listen and wait on port 4444 for connection" 4
          .IX Item "Example to listen and wait on port 4444 for connection"
          -serial tcp::4444,server
          .ie n .IP """Example to not wait and listen on ip 192.168.0.100 port 4444""" 4
          .el .IP "\f(CWExample to not wait and listen on ip 192.168.0.100 port 4444" 4
          .IX Item "Example to not wait and listen on ip 192.168.0.100 port 4444"
          -serial tcp:192.168.0.100:4444,server,nowait
    * **telnet:**_host_**:**_port_**[,server][,nowait][,nodelay]**  
      .IX Item "telnet:host:port[,server][,nowait][,nodelay]"
      The telnet protocol is used instead of raw tcp sockets.  The options
      work the same as if you had specified \f(CW`-serial tcp\*(C'.  The
      difference is that the port acts like a telnet server or client using
      telnet option negotiation.  This will also allow you to send the
      \s-1MAGIC_SYSRQ\s0 sequence if you use a telnet that supports sending the break
      sequence.  Typically in unix telnet you do it with Control-] and then
      type send break\*(R" followed by pressing the enter key.
    * **websocket:**_host_**:**_port_**,server[,nowait][,nodelay]**  
      .IX Item "websocket:host:port,server[,nowait][,nodelay]"
      The WebSocket protocol is used instead of raw tcp socket. The port acts as
      a WebSocket server. Client mode is not supported.
    * **unix:**_path_**[,server][,nowait][,reconnect=**_seconds_**]**  
      .IX Item "unix:path[,server][,nowait][,reconnect=seconds]"
      A unix domain socket is used instead of a tcp socket.  The option works the
      same as if you had specified \f(CW`-serial tcp\*(C' except the unix domain socket
      _path_ is used for connections.
    * **mon:**_dev\_string_  
      .IX Item "mon:dev_string"
      This is a special option to allow the monitor to be multiplexed onto
      another serial port.  The monitor is accessed with key sequence of
      **Control-a** and then pressing **c**.
      _dev\_string_ should be any one of the serial devices specified
      above.  An example to multiplex the monitor onto a telnet server
      listening on port 4444 would be:
          .ie n .IP """-serial mon:telnet::4444,server,nowait""" 4
          .el .IP "\f(CW-serial mon:telnet::4444,server,nowait" 4
          .IX Item "-serial mon:telnet::4444,server,nowait"
          .Sp
          When the monitor is multiplexed to stdio in this way, Ctrl+C will not terminate
          \s-1QEMU\s0 any more but will be passed to the guest instead.
    * **braille**  
      .IX Item "braille"
      Braille device.  This will use BrlAPI to display the braille output on a real
      or fake device.
    * **msmouse**  
      .IX Item "msmouse"
      Three button serial mouse. Configure the guest to use Microsoft protocol.
* **-parallel** _dev_  
  .IX Item "-parallel dev"
  Redirect the virtual parallel port to host device _dev_ (same
  devices as the serial port). On Linux hosts, _/dev/parportN_ can
  be used to use hardware devices connected on the corresponding host
  parallel port.
  .Sp
  This option can be used several times to simulate up to 3 parallel
  ports.
  .Sp
  Use \f(CW`-parallel none\*(C' to disable all parallel ports.
* **-monitor** _dev_  
  .IX Item "-monitor dev"
  Redirect the monitor to host device _dev_ (same devices as the
  serial port).
  The default device is \f(CW`vc\*(C' in graphical mode and \f(CW\*(C\`stdio\*(C' in
  non graphical mode.
  Use \f(CW`-monitor none\*(C' to disable the default monitor.
* **-qmp** _dev_  
  .IX Item "-qmp dev"
  Like -monitor but opens in 'control' mode.
* **-qmp-pretty** _dev_  
  .IX Item "-qmp-pretty dev"
  Like -qmp but uses pretty \s-1JSON\s0 formatting.
* **-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]**  
  .IX Item "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]"
  Setup monitor on chardev _name_. \f(CW`pretty\*(C' turns on \s-1JSON\s0 pretty printing
  easing human reading and debugging.
* **-debugcon** _dev_  
  .IX Item "-debugcon dev"
  Redirect the debug console to host device _dev_ (same devices as the
  serial port).  The debug console is an I/O port which is typically port
  0xe9; writing to that I/O port sends output to this device.
  The default device is \f(CW`vc\*(C' in graphical mode and \f(CW\*(C\`stdio\*(C' in
  non graphical mode.
* **-pidfile** _file_  
  .IX Item "-pidfile file"
  Store the \s-1QEMU\s0 process \s-1PID\s0 in _file_. It is useful if you launch \s-1QEMU\s0
  from a script.
* **-singlestep**  
  .IX Item "-singlestep"
  Run the emulation in single step mode.
* **--preconfig**  
  .IX Item "--preconfig"
  Pause \s-1QEMU\s0 for interactive configuration before the machine is created,
  which allows querying and configuring properties that will affect
  machine initialization.  Use \s-1QMP\s0 command 'x-exit-preconfig' to exit
  the preconfig state and move to the next state (i.e. run guest if -S
  isn't used or pause the second time if -S is used).  This option is
  experimental.
* **-S**  
  .IX Item "-S"
  Do not start \s-1CPU\s0 at startup (you must type 'c' in the monitor).
* **-realtime mlock=on|off**  
  .IX Item "-realtime mlock=on|off"
  Run qemu with realtime features.
  mlocking qemu and guest memory can be enabled via **mlock=on**
  (enabled by default).
* **-overcommit mem-lock=on|off**  
  .IX Item "-overcommit mem-lock=on|off"
* **-overcommit cpu-pm=on|off**  
  .IX Item "-overcommit cpu-pm=on|off"
  Run qemu with hints about host resource overcommit. The default is
  to assume that host overcommits all resources.
  .Sp
  Locking qemu and guest memory can be enabled via **mem-lock=on** (disabled
  by default).  This works when host memory is not overcommitted and reduces the
  worst-case latency for guest.  This is equivalent to **realtime**.
  .Sp
  Guest ability to manage power state of host cpus (increasing latency for other
  processes on the same host cpu, but decreasing latency for guest) can be
  enabled via **cpu-pm=on** (disabled by default).  This works best when
  host \s-1CPU\s0 is not overcommitted. When used, host estimates of \s-1CPU\s0 cycle and power
  utilization will be incorrect, not taking into account guest idle time.
* **-gdb** _dev_  
  .IX Item "-gdb dev"
  Wait for gdb connection on device _dev_. Typical
  connections will likely be TCP-based, but also \s-1UDP,\s0 pseudo \s-1TTY,\s0 or even
  stdio are reasonable use case. The latter is allowing to start \s-1QEMU\s0 from
  within gdb and establish the connection via a pipe:
  .Sp
  .Vb 1
          (gdb) target remote | exec qemu-system-i386 -gdb stdio ...
  .Ve
* **-s**  
  .IX Item "-s"
  Shorthand for -gdb tcp::1234, i.e. open a gdbserver on \s-1TCP\s0 port 1234.
* **-d** _item1_**[,...]**  
  .IX Item "-d item1[,...]"
  Enable logging of specified items. Use '-d help' for a list of log items.
* **-D** _logfile_  
  .IX Item "-D logfile"
  Output log in _logfile_ instead of to stderr
* **-dfilter** _range1_**[,...]**  
  .IX Item "-dfilter range1[,...]"
  Filter debug output to that relevant to a range of target addresses. The filter
  spec can be either _start_+_size_, _start_-_size_ or
  _start_.._end_ where _start_ _end_ and _size_ are the
  addresses and sizes required. For example:
  .Sp
  .Vb 1
          -dfilter 0x8000..0x8fff,0xffffffc000080000+0x200,0xffffffc000060000-0x1000
  .Ve
  .Sp
  Will dump output for any code in the 0x1000 sized block starting at 0x8000 and
  the 0x200 sized block starting at 0xffffffc000080000 and another 0x1000 sized
  block starting at 0xffffffc00005f000.
* **-L**  _path_  
  .IX Item "-L path"
  Set the directory for the \s-1BIOS, VGA BIOS\s0 and keymaps.
  .Sp
  To list all the data directories, use \f(CW`-L help\*(C'.
* **-bios** _file_  
  .IX Item "-bios file"
  Set the filename for the \s-1BIOS.\s0
* **-enable-kvm**  
  .IX Item "-enable-kvm"
  Enable \s-1KVM\s0 full virtualization support. This option is only available
  if \s-1KVM\s0 support is enabled when compiling.
* **-enable-hax**  
  .IX Item "-enable-hax"
  Enable \s-1HAX\s0 (Hardware-based Acceleration eXecution) support. This option
  is only available if \s-1HAX\s0 support is enabled when compiling. \s-1HAX\s0 is only
  applicable to \s-1MAC\s0 and Windows platform, and thus does not conflict with
  \s-1KVM.\s0 This option is deprecated, use **-accel hax** instead.
* **-xen-domid** _id_  
  .IX Item "-xen-domid id"
  Specify xen guest domain _id_ (\s-1XEN\s0 only).
* **-xen-create**  
  .IX Item "-xen-create"
  Create domain using xen hypercalls, bypassing xend.
  Warning: should not be used when xend is in use (\s-1XEN\s0 only).
* **-xen-attach**  
  .IX Item "-xen-attach"
  Attach to existing xen domain.
  xend will use this when starting \s-1QEMU\s0 (\s-1XEN\s0 only).
  Restrict set of available xen operations to specified domain id (\s-1XEN\s0 only).
* **-no-reboot**  
  .IX Item "-no-reboot"
  Exit instead of rebooting.
* **-no-shutdown**  
  .IX Item "-no-shutdown"
  Don't exit \s-1QEMU\s0 on guest shutdown, but instead only stop the emulation.
  This allows for instance switching to monitor to commit changes to the
  disk image.
* **-loadvm** _file_  
  .IX Item "-loadvm file"
  Start right away with a saved state (\f(CW`loadvm\*(C' in monitor)
* **-daemonize**  
  .IX Item "-daemonize"
  Daemonize the \s-1QEMU\s0 process after initialization.  \s-1QEMU\s0 will not detach from
  standard \s-1IO\s0 until it is ready to receive connections on any of its devices.
  This option is a useful way for external programs to launch \s-1QEMU\s0 without having
  to cope with initialization race conditions.
* **-option-rom** _file_  
  .IX Item "-option-rom file"
  Load the contents of _file_ as an option \s-1ROM.\s0
  This option is useful to load things like EtherBoot.
* **-rtc [base=utc|localtime|**_datetime_**][,clock=host|rt|vm][,driftfix=none|slew]**  
  .IX Item "-rtc [base=utc|localtime|datetime][,clock=host|rt|vm][,driftfix=none|slew]"
  Specify **base** as \f(CW`utc\*(C' or \f(CW\*(C\`localtime\*(C' to let the \s-1RTC\s0 start at the current
  \s-1UTC\s0 or local time, respectively. \f(CW`localtime\*(C' is required for correct date in
  MS-DOS or Windows. To start at a specific point in time, provide _datetime_ in the
  format \f(CW`2006-06-17T16:01:21\*(C' or \f(CW\*(C\`2006-06-17\*(C'. The default base is \s-1UTC.\s0
  .Sp
  By default the \s-1RTC\s0 is driven by the host system time. This allows using of the
  \s-1RTC\s0 as accurate reference clock inside the guest, specifically if the host
  time is smoothly following an accurate external reference clock, e.g. via \s-1NTP.\s0
  If you want to isolate the guest time from the host, you can set **clock**
  to \f(CW`rt\*(C' instead, which provides a host monotonic clock if host support it.
  To even prevent the \s-1RTC\s0 from progressing during suspension, you can set **clock**
  to \f(CW`vm\*(C' (virtual clock). **clock=vm** is recommended especially in
  icount mode in order to preserve determinism; however, note that in icount mode
  the speed of the virtual clock is variable and can in general differ from the
  host clock.
  .Sp
  Enable **driftfix** (i386 targets only) if you experience time drift problems,
  specifically with Windows' \s-1ACPI HAL.\s0 This option will try to figure out how
  many timer interrupts were not processed by the Windows guest and will
  re-inject them.
* **-icount [shift=**_N_**|auto][,rr=record|replay,rrfile=**_filename_**,rrsnapshot=**_snapshot_**]**  
  .IX Item "-icount [shift=N|auto][,rr=record|replay,rrfile=filename,rrsnapshot=snapshot]"
  Enable virtual instruction counter.  The virtual cpu will execute one
  instruction every 2^_N_ ns of virtual time.  If \f(CW`auto\*(C' is specified
  then the virtual cpu speed will be automatically adjusted to keep virtual
  time within a few seconds of real time.
  .Sp
  When the virtual cpu is sleeping, the virtual time will advance at default
  speed unless **sleep=on|off** is specified.
  With **sleep=on|off**, the virtual time will jump to the next timer deadline
  instantly whenever the virtual cpu goes to sleep mode and will not advance
  if no timer is enabled. This behavior give deterministic execution times from
  the guest point of view.
  .Sp
  Note that while this option can give deterministic behavior, it does not
  provide cycle accurate emulation.  Modern CPUs contain superscalar out of
  order cores with complex cache hierarchies.  The number of instructions
  executed often has little or no correlation with actual performance.
  .Sp
  **align=on** will activate the delay algorithm which will try
  to synchronise the host clock and the virtual clock. The goal is to
  have a guest running at the real frequency imposed by the shift option.
  Whenever the guest clock is behind the host clock and if
  **align=on** is specified then we print a message to the user
  to inform about the delay.
  Currently this option does not work when **shift** is \f(CW`auto\*(C'.
  Note: The sync algorithm will work for those shift values for which
  the guest clock runs ahead of the host clock. Typically this happens
  when the shift value is high (how high depends on the host machine).
  .Sp
  When **rr** option is specified deterministic record/replay is enabled.
  Replay log is written into _filename_ file in record mode and
  read from this file in replay mode.
  .Sp
  Option rrsnapshot is used to create new vm snapshot named _snapshot_
  at the start of execution recording. In replay mode this option is used
  to load the initial \s-1VM\s0 state.
* **-watchdog** _model_  
  .IX Item "-watchdog model"
  Create a virtual hardware watchdog device.  Once enabled (by a guest
  action), the watchdog must be periodically polled by an agent inside
  the guest or else the guest will be restarted. Choose a model for
  which your guest has drivers.
  .Sp
  The _model_ is the model of hardware watchdog to emulate. Use
  \f(CW`-watchdog help\*(C' to list available hardware models. Only one
  watchdog can be enabled for a guest.
  .Sp
  The following models may be available:
    * **ib700**  
      .IX Item "ib700"
      iBASE 700 is a very simple \s-1ISA\s0 watchdog with a single timer.
    * **i6300esb**  
      .IX Item "i6300esb"
      Intel 6300ESB I/O controller hub is a much more featureful PCI-based
      dual-timer watchdog.
    * **diag288**  
      .IX Item "diag288"
      A virtual watchdog for s390x backed by the diagnose 288 hypercall
      (currently \s-1KVM\s0 only).
* **-watchdog-action** _action_  
  .IX Item "-watchdog-action action"
  The _action_ controls what \s-1QEMU\s0 will do when the watchdog timer
  expires.
  The default is
  \f(CW`reset\*(C' (forcefully reset the guest).
  Other possible actions are:
  \f(CW`shutdown\*(C' (attempt to gracefully shutdown the guest),
  \f(CW`poweroff\*(C' (forcefully poweroff the guest),
  \f(CW`inject-nmi\*(C' (inject a \s-1NMI\s0 into the guest),
  \f(CW`pause\*(C' (pause the guest),
  \f(CW`debug\*(C' (print a debug message and continue), or
  \f(CW`none\*(C' (do nothing).
  .Sp
  Note that the \f(CW`shutdown\*(C' action requires that the guest responds
  to \s-1ACPI\s0 signals, which it may not be able to do in the sort of
  situations where the watchdog would have expired, and thus
  \f(CW`-watchdog-action shutdown\*(C' is not recommended for production use.
  .Sp
  Examples:
      .ie n .IP """-watchdog i6300esb -watchdog-action pause""" 4
      .el .IP "\f(CW-watchdog i6300esb -watchdog-action pause" 4
      .IX Item "-watchdog i6300esb -watchdog-action pause"
      .ie n .IP """-watchdog ib700""" 4
      .el .IP "\f(CW-watchdog ib700" 4
      .IX Item "-watchdog ib700"
* **-echr** _numeric\_ascii\_value_  
  .IX Item "-echr numeric_ascii_value"
  Change the escape character used for switching to the monitor when using
  monitor and serial sharing.  The default is \f(CW0x01 when using the
  \f(CW`-nographic\*(C' option.  \f(CW0x01 is equal to pressing
  \f(CW`Control-a\*(C'.  You can select a different character from the ascii
  control keys where 1 through 26 map to Control-a through Control-z.  For
  instance you could use the either of the following to change the escape
  character to Control-t.
      .ie n .IP """-echr 0x14""" 4
      .el .IP "\f(CW-echr 0x14" 4
      .IX Item "-echr 0x14"
      .ie n .IP """-echr 20""" 4
      .el .IP "\f(CW-echr 20" 4
      .IX Item "-echr 20"
* **-virtioconsole** _c_  
  .IX Item "-virtioconsole c"
  Set virtio console.
  This option is deprecated, please use **-device virtconsole** instead.
* **-show-cursor**  
  .IX Item "-show-cursor"
  Show cursor.
* **-tb-size** _n_  
  .IX Item "-tb-size n"
  Set \s-1TB\s0 size.
* **-incoming tcp:[**_host_**]:**_port_**[,to=**_maxport_**][,ipv4][,ipv6]**  
  .IX Item "-incoming tcp:[host]:port[,to=maxport][,ipv4][,ipv6]"
* **-incoming rdma:**_host_**:**_port_**[,ipv4][,ipv6]**  
  .IX Item "-incoming rdma:host:port[,ipv4][,ipv6]"
  Prepare for incoming migration, listen on a given tcp port.
* **-incoming unix:**_socketpath_  
  .IX Item "-incoming unix:socketpath"
  Prepare for incoming migration, listen on a given unix socket.
* **-incoming fd:**_fd_  
  .IX Item "-incoming fd:fd"
  Accept incoming migration from a given filedescriptor.
* **-incoming exec:**_cmdline_  
  .IX Item "-incoming exec:cmdline"
  Accept incoming migration as an output from specified external command.
* **-incoming defer**  
  .IX Item "-incoming defer"
  Wait for the \s-1URI\s0 to be specified via migrate_incoming.  The monitor can
  be used to change settings (such as migration parameters) prior to issuing
  the migrate_incoming to allow the migration to begin.
* **-only-migratable**  
  .IX Item "-only-migratable"
  Only allow migratable devices. Devices will not be allowed to enter an
  unmigratable state.
* **-nodefaults**  
  .IX Item "-nodefaults"
  Don't create default devices. Normally, \s-1QEMU\s0 sets the default devices like serial
  port, parallel port, virtual console, monitor device, \s-1VGA\s0 adapter, floppy and
  CD-ROM drive and others. The \f(CW`-nodefaults\*(C' option will disable all those
  default devices.
* **-chroot** _dir_  
  .IX Item "-chroot dir"
  Immediately before starting guest execution, chroot to the specified
  directory.  Especially useful in combination with -runas.
* **-runas** _user_  
  .IX Item "-runas user"
  Immediately before starting guest execution, drop root privileges, switching
  to the specified user.
* **-prom-env** _variable_**=**_value_  
  .IX Item "-prom-env variable=value"
  Set OpenBIOS nvram _variable_ to given _value_ (\s-1PPC, SPARC\s0 only).
* **-semihosting**  
  .IX Item "-semihosting"
  Enable semihosting mode (\s-1ARM, M68K,\s0 Xtensa, \s-1MIPS\s0 only).
* **-semihosting-config [enable=on|off][,target=native|gdb|auto][,arg=str[,...]]**  
  .IX Item "-semihosting-config [enable=on|off][,target=native|gdb|auto][,arg=str[,...]]"
  Enable and configure semihosting (\s-1ARM, M68K,\s0 Xtensa, \s-1MIPS\s0 only).
      .ie n .IP "**target=\f(CB""native|gdb|auto""**" 4
      .el .IP "**target=\f(CBnative|gdb|auto**" 4
      .IX Item "target=native|gdb|auto"
      Defines where the semihosting calls will be addressed, to \s-1QEMU\s0 (\f(CW`native\*(C')
      or to \s-1GDB\s0 (\f(CW`gdb\*(C'). The default is \f(CW\*(C\`auto\*(C', which means \f(CW\*(C\`gdb\*(C'
      during debug sessions and \f(CW`native\*(C' otherwise.
    * **arg=**_str1_**,arg=**_str2_**,...**  
      .IX Item "arg=str1,arg=str2,..."
      Allows the user to pass input arguments, and can be used multiple times to build
      up a list. The old-style \f(CW`-kernel\*(C'/\f(CW\*(C\`-append\*(C' method of passing a
      command line is still supported for backward compatibility. If both the
      \f(CW`--semihosting-config arg\*(C' and the \f(CW\*(C\`-kernel\*(C'/\f(CW\*(C\`-append\*(C' are
      specified, the former is passed to semihosting as it always takes precedence.
* **-old-param**  
  .IX Item "-old-param"
  Old param mode (\s-1ARM\s0 only).
* **-sandbox** _arg_**[,obsolete=**_string_**][,elevateprivileges=**_string_**][,spawn=**_string_**][,resourcecontrol=**_string_**]**  
  .IX Item "-sandbox arg[,obsolete=string][,elevateprivileges=string][,spawn=string][,resourcecontrol=string]"
  Enable Seccomp mode 2 system call filter. 'on' will enable syscall filtering and 'off' will
  disable it.  The default is 'off'.
    * **obsolete=**_string_  
      .IX Item "obsolete=string"
      Enable Obsolete system calls
    * **elevateprivileges=**_string_  
      .IX Item "elevateprivileges=string"
      Disable set*uid|gid system calls
    * **spawn=**_string_  
      .IX Item "spawn=string"
      Disable *fork and execve
    * **resourcecontrol=**_string_  
      .IX Item "resourcecontrol=string"
      Disable process affinity and schedular priority
* **-readconfig** _file_  
  .IX Item "-readconfig file"
  Read device configuration from _file_. This approach is useful when you want to spawn
  \s-1QEMU\s0 process with many command line options but you don't want to exceed the command line
  character limit.
* **-writeconfig** _file_  
  .IX Item "-writeconfig file"
  Write device configuration to _file_. The _file_ can be either filename to save
  command line and device configuration into file or dash \f(CW`-\*(C') character to print the
  output to stdout. This can be later used as input file for \f(CW`-readconfig\*(C' option.
* **-no-user-config**  
  .IX Item "-no-user-config"
  The \f(CW`-no-user-config\*(C' option makes \s-1QEMU\s0 not load any of the user-provided
  config files on _sysconfdir_.
* **-trace [[enable=]**_pattern_**][,events=**_file_**][,file=**_file_**]**  
  .IX Item "-trace [[enable=]pattern][,events=file][,file=file]"
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
* **-enable-fips**  
  .IX Item "-enable-fips"
  Enable \s-1FIPS 140-2\s0 compliance mode.
* **-msg timestamp[=on|off]**  
  .IX Item "-msg timestamp[=on|off]"
  prepend a timestamp to each log message.(default:on)
* **-dump-vmstate** _file_  
  .IX Item "-dump-vmstate file"
  Dump json-encoded vmstate information for current machine type to file
  in _file_
* **-enable-sync-profile**  
  .IX Item "-enable-sync-profile"
  Enable synchronization profiling.

_Generic object creation_
.IX Subsection "Generic object creation"

* **-object** _typename_**[,**_prop1_**=**_value1_**,...]**  
  .IX Item "-object typename[,prop1=value1,...]"
  Create a new object of type _typename_ setting properties
  in the order they are specified.  Note that the 'id'
  property must be set.  These objects are placed in the
  '/objects' path.
    * **-object memory-backend-file,id=**_id_**,size=**_size_**,mem-path=**_dir_**,share=**_on|off_**,discard-data=**_on|off_**,merge=**_on|off_**,dump=**_on|off_**,prealloc=**_on|off_**,host-nodes=**_host-nodes_**,policy=**_default|preferred|bind|interleave_**,align=**_align_  
      .IX Item "-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align"
      Creates a memory file backend object, which can be used to back
      the guest \s-1RAM\s0 with huge pages.
      .Sp
      The **id** parameter is a unique \s-1ID\s0 that will be used to reference this
      memory region when configuring the **-numa** argument.
      .Sp
      The **size** option provides the size of the memory region, and accepts
      common suffixes, eg **500M**.
      .Sp
      The **mem-path** provides the path to either a shared memory or huge page
      filesystem mount.
      .Sp
      The **share** boolean option determines whether the memory
      region is marked as private to \s-1QEMU,\s0 or shared. The latter allows
      a co-operating external process to access the \s-1QEMU\s0 memory region.
      .Sp
      The **share** is also required for pvrdma devices due to
      limitations in the \s-1RDMA API\s0 provided by Linux.
      .Sp
      Setting share=on might affect the ability to configure \s-1NUMA\s0
      bindings for the memory backend under some circumstances, see
      Documentation/vm/numa_memory_policy.txt on the Linux kernel
      source tree for additional details.
      .Sp
      Setting the **discard-data** boolean option to _on_
      indicates that file contents can be destroyed when \s-1QEMU\s0 exits,
      to avoid unnecessarily flushing data to the backing file.  Note
      that **discard-data** is only an optimization, and \s-1QEMU\s0
      might not discard file contents if it aborts unexpectedly or is
      terminated using \s-1SIGKILL.\s0
      .Sp
      The **merge** boolean option enables memory merge, also known as
      \s-1MADV_MERGEABLE,\s0 so that Kernel Samepage Merging will consider the pages for
      memory deduplication.
      .Sp
      Setting the **dump** boolean option to _off_ excludes the memory from
      core dumps. This feature is also known as \s-1MADV_DONTDUMP.\s0
      .Sp
      The **prealloc** boolean option enables memory preallocation.
      .Sp
      The **host-nodes** option binds the memory range to a list of \s-1NUMA\s0 host
      nodes.
      .Sp
      The **policy** option sets the \s-1NUMA\s0 policy to one of the following values:
        * _default_  
          .IX Item "default"
          default host policy
        * _preferred_  
          .IX Item "preferred"
          prefer the given host node list for allocation
        * _bind_  
          .IX Item "bind"
          restrict memory allocation to the given host node list
        * _interleave_  
          .IX Item "interleave"
          interleave memory allocations across the given host node list
          .Sp
          The **align** option specifies the base address alignment when
          \s-1QEMU\s0 **mmap**\|(2) **mem-path**, and accepts common suffixes, eg
          **2M**. Some backend store specified by **mem-path**
          requires an alignment different than the default one used by \s-1QEMU,\s0 eg
          the device \s-1DAX\s0 /dev/dax0.0 requires 2M alignment rather than 4K. In
          such cases, users can specify the required alignment via this option.
          .Sp
          The **pmem** option specifies whether the backing file specified
          by **mem-path** is in host persistent memory that can be accessed
          using the \s-1SNIA NVM\s0 programming model (e.g. Intel \s-1NVDIMM\s0).
          If **pmem** is set to 'on', \s-1QEMU\s0 will take necessary operations to
          guarantee the persistence of its own writes to **mem-path**
          (e.g. in vNVDIMM label emulation and live migration).
    * **-object memory-backend-ram,id=**_id_**,merge=**_on|off_**,dump=**_on|off_**,share=**_on|off_**,prealloc=**_on|off_**,size=**_size_**,host-nodes=**_host-nodes_**,policy=**_default|preferred|bind|interleave_  
      .IX Item "-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave"
      Creates a memory backend object, which can be used to back the guest \s-1RAM.\s0
      Memory backend objects offer more control than the **-m** option that is
      traditionally used to define guest \s-1RAM.\s0 Please refer to
      **memory-backend-file** for a description of the options.
    * **-object memory-backend-memfd,id=**_id_**,merge=**_on|off_**,dump=**_on|off_**,share=**_on|off_**,prealloc=**_on|off_**,size=**_size_**,host-nodes=**_host-nodes_**,policy=**_default|preferred|bind|interleave_**,seal=**_on|off_**,hugetlb=**_on|off_**,hugetlbsize=**_size_  
      .IX Item "-object memory-backend-memfd,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave,seal=on|off,hugetlb=on|off,hugetlbsize=size"
      Creates an anonymous memory file backend object, which allows \s-1QEMU\s0 to
      share the memory with an external process (e.g. when using
      vhost-user). The memory is allocated with memfd and optional
      sealing. (Linux only)
      .Sp
      The **seal** option creates a sealed-file, that will block
      further resizing the memory ('on' by default).
      .Sp
      The **hugetlb** option specify the file to be created resides in
      the hugetlbfs filesystem (since Linux 4.14).  Used in conjunction with
      the **hugetlb** option, the **hugetlbsize** option specify
      the hugetlb page size on systems that support multiple hugetlb page
      sizes (it must be a power of 2 value supported by the system).
      .Sp
      In some versions of Linux, the **hugetlb** option is incompatible
      with the **seal** option (requires at least Linux 4.16).
      .Sp
      Please refer to **memory-backend-file** for a description of the
      other options.
      .Sp
      The **share** boolean option is _on_ by default with memfd.
    * **-object rng-random,id=**_id_**,filename=**_/dev/random_  
      .IX Item "-object rng-random,id=id,filename=/dev/random"
      Creates a random number generator backend which obtains entropy from
      a device on the host. The **id** parameter is a unique \s-1ID\s0 that
      will be used to reference this entropy backend from the **virtio-rng**
      device. The **filename** parameter specifies which file to obtain
      entropy from and if omitted defaults to **/dev/random**.
    * **-object rng-egd,id=**_id_**,chardev=**_chardevid_  
      .IX Item "-object rng-egd,id=id,chardev=chardevid"
      Creates a random number generator backend which obtains entropy from
      an external daemon running on the host. The **id** parameter is
      a unique \s-1ID\s0 that will be used to reference this entropy backend from
      the **virtio-rng** device. The **chardev** parameter is
      the unique \s-1ID\s0 of a character device backend that provides the connection
      to the \s-1RNG\s0 daemon.
    * **-object tls-creds-anon,id=**_id_**,endpoint=**_endpoint_**,dir=**_/path/to/cred/dir_**,verify-peer=**_on|off_  
      .IX Item "-object tls-creds-anon,id=id,endpoint=endpoint,dir=/path/to/cred/dir,verify-peer=on|off"
      Creates a \s-1TLS\s0 anonymous credentials object, which can be used to provide
      \s-1TLS\s0 support on network backends. The **id** parameter is a unique
      \s-1ID\s0 which network backends will use to access the credentials. The
      **endpoint** is either **server** or **client** depending
      on whether the \s-1QEMU\s0 network backend that uses the credentials will be
      acting as a client or as a server. If **verify-peer** is enabled
      (the default) then once the handshake is completed, the peer credentials
      will be verified, though this is a no-op for anonymous credentials.
      .Sp
      The _dir_ parameter tells \s-1QEMU\s0 where to find the credential
      files. For server endpoints, this directory may contain a file
      _dh-params.pem_ providing diffie-hellman parameters to use
      for the \s-1TLS\s0 server. If the file is missing, \s-1QEMU\s0 will generate
      a set of \s-1DH\s0 parameters at startup. This is a computationally
      expensive operation that consumes random pool entropy, so it is
      recommended that a persistent set of parameters be generated
      upfront and saved.
    * **-object tls-creds-psk,id=**_id_**,endpoint=**_endpoint_**,dir=**_/path/to/keys/dir_**[,username=**_username_**]**  
      .IX Item "-object tls-creds-psk,id=id,endpoint=endpoint,dir=/path/to/keys/dir[,username=username]"
      Creates a \s-1TLS\s0 Pre-Shared Keys (\s-1PSK\s0) credentials object, which can be used to provide
      \s-1TLS\s0 support on network backends. The **id** parameter is a unique
      \s-1ID\s0 which network backends will use to access the credentials. The
      **endpoint** is either **server** or **client** depending
      on whether the \s-1QEMU\s0 network backend that uses the credentials will be
      acting as a client or as a server. For clients only, **username**
      is the username which will be sent to the server.  If omitted
      it defaults to qemu\*(R".
      .Sp
      The _dir_ parameter tells \s-1QEMU\s0 where to find the keys file.
      It is called "_dir_/keys.psk and contains \*(R"username:key"
      pairs.  This file can most easily be created using the GnuTLS
      \f(CW`psktool\*(C' program.
      .Sp
      For server endpoints, _dir_ may also contain a file
      _dh-params.pem_ providing diffie-hellman parameters to use
      for the \s-1TLS\s0 server. If the file is missing, \s-1QEMU\s0 will generate
      a set of \s-1DH\s0 parameters at startup. This is a computationally
      expensive operation that consumes random pool entropy, so it is
      recommended that a persistent set of parameters be generated
      up front and saved.
    * **-object tls-creds-x509,id=**_id_**,endpoint=**_endpoint_**,dir=**_/path/to/cred/dir_**,priority=**_priority_**,verify-peer=**_on|off_**,passwordid=**_id_  
      .IX Item "-object tls-creds-x509,id=id,endpoint=endpoint,dir=/path/to/cred/dir,priority=priority,verify-peer=on|off,passwordid=id"
      Creates a \s-1TLS\s0 anonymous credentials object, which can be used to provide
      \s-1TLS\s0 support on network backends. The **id** parameter is a unique
      \s-1ID\s0 which network backends will use to access the credentials. The
      **endpoint** is either **server** or **client** depending
      on whether the \s-1QEMU\s0 network backend that uses the credentials will be
      acting as a client or as a server. If **verify-peer** is enabled
      (the default) then once the handshake is completed, the peer credentials
      will be verified. With x509 certificates, this implies that the clients
      must be provided with valid client certificates too.
      .Sp
      The _dir_ parameter tells \s-1QEMU\s0 where to find the credential
      files. For server endpoints, this directory may contain a file
      _dh-params.pem_ providing diffie-hellman parameters to use
      for the \s-1TLS\s0 server. If the file is missing, \s-1QEMU\s0 will generate
      a set of \s-1DH\s0 parameters at startup. This is a computationally
      expensive operation that consumes random pool entropy, so it is
      recommended that a persistent set of parameters be generated
      upfront and saved.
      .Sp
      For x509 certificate credentials the directory will contain further files
      providing the x509 certificates. The certificates must be stored
      in \s-1PEM\s0 format, in filenames _ca-cert.pem_, _ca-crl.pem_ (optional),
      _server-cert.pem_ (only servers), _server-key.pem_ (only servers),
      _client-cert.pem_ (only clients), and _client-key.pem_ (only clients).
      .Sp
      For the _server-key.pem_ and _client-key.pem_ files which
      contain sensitive private keys, it is possible to use an encrypted
      version by providing the _passwordid_ parameter. This provides
      the \s-1ID\s0 of a previously created \f(CW`secret\*(C' object containing the
      password for decryption.
      .Sp
      The _priority_ parameter allows to override the global default
      priority used by gnutls. This can be useful if the system administrator
      needs to use a weaker set of crypto priorities for \s-1QEMU\s0 without
      potentially forcing the weakness onto all applications. Or conversely
      if one wants wants a stronger default for \s-1QEMU\s0 than for all other
      applications, they can do this through this parameter. Its format is
      a gnutls priority string as described at
      &lt;**https://gnutls.org/manual/html\_node/Priority-Strings.html**&gt;.
    * **-object filter-buffer,id=**_id_**,netdev=**_netdevid_**,interval=**_t_**[,queue=**_all|rx|tx_**][,status=**_on|off_**]**  
      .IX Item "-object filter-buffer,id=id,netdev=netdevid,interval=t[,queue=all|rx|tx][,status=on|off]"
      Interval _t_ can't be 0, this filter batches the packet delivery: all
      packets arriving in a given interval on netdev _netdevid_ are delayed
      until the end of the interval. Interval is in microseconds.
      **status** is optional that indicate whether the netfilter is
      on (enabled) or off (disabled), the default status for netfilter will be 'on'.
      .Sp
      queue _all|rx|tx_ is an option that can be applied to any netfilter.
      .Sp
      **all**: the filter is attached both to the receive and the transmit
      queue of the netdev (default).
      .Sp
      **rx**: the filter is attached to the receive queue of the netdev,
      where it will receive packets sent to the netdev.
      .Sp
      **tx**: the filter is attached to the transmit queue of the netdev,
      where it will receive packets sent by the netdev.
    * **-object filter-mirror,id=**_id_**,netdev=**_netdevid_**,outdev=**_chardevid_**,queue=**_all|rx|tx_**[,vnet\_hdr\_support]**  
      .IX Item "-object filter-mirror,id=id,netdev=netdevid,outdev=chardevid,queue=all|rx|tx[,vnet_hdr_support]"
      filter-mirror on netdev _netdevid_,mirror net packet to chardev_chardevid_, if it has the vnet_hdr_support flag, filter-mirror will mirror packet with vnet_hdr_len.
    * **-object filter-redirector,id=**_id_**,netdev=**_netdevid_**,indev=**_chardevid_**,outdev=**_chardevid_**,queue=**_all|rx|tx_**[,vnet\_hdr\_support]**  
      .IX Item "-object filter-redirector,id=id,netdev=netdevid,indev=chardevid,outdev=chardevid,queue=all|rx|tx[,vnet_hdr_support]"
      filter-redirector on netdev _netdevid_,redirect filter's net packet to chardev
      _chardevid_,and redirect indev's packet to filter.if it has the vnet_hdr_support flag,
      filter-redirector will redirect packet with vnet_hdr_len.
      Create a filter-redirector we need to differ outdev id from indev id, id can not
      be the same. we can just use indev or outdev, but at least one of indev or outdev
      need to be specified.
    * **-object filter-rewriter,id=**_id_**,netdev=**_netdevid_**,queue=**_all|rx|tx_**,[vnet\_hdr\_support]**  
      .IX Item "-object filter-rewriter,id=id,netdev=netdevid,queue=all|rx|tx,[vnet_hdr_support]"
      Filter-rewriter is a part of \s-1COLO\s0 project.It will rewrite tcp packet to
      secondary from primary to keep secondary tcp connection,and rewrite
      tcp packet to primary from secondary make tcp packet can be handled by
      client.if it has the vnet_hdr_support flag, we can parse packet with vnet header.
      .Sp
      usage:
      colo secondary:
      -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0
      -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1
      -object filter-rewriter,id=rew0,netdev=hn0,queue=all
    * **-object filter-dump,id=**_id_**,netdev=**_dev_**[,file=**_filename_**][,maxlen=**_len_**]**  
      .IX Item "-object filter-dump,id=id,netdev=dev[,file=filename][,maxlen=len]"
      Dump the network traffic on netdev _dev_ to the file specified by
      _filename_. At most _len_ bytes (64k by default) per packet are stored.
      The file format is libpcap, so it can be analyzed with tools such as tcpdump
      or Wireshark.
    * **-object colo-compare,id=**_id_**,primary\_in=**_chardevid_**,secondary\_in=**_chardevid_**,outdev=**_chardevid_**[,vnet\_hdr\_support]**  
      .IX Item "-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid[,vnet_hdr_support]"
      Colo-compare gets packet from primary\_in_chardevid_ and secondary\_in_chardevid_, than compare primary packet with
      secondary packet. If the packets are same, we will output primary
      packet to outdev_chardevid_, else we will notify colo-frame
      do checkpoint and send primary packet to outdev_chardevid_.
      if it has the vnet_hdr_support flag, colo compare will send/recv packet with vnet_hdr_len.
      .Sp
      we must use it with the help of filter-mirror and filter-redirector.
      .Sp
      .Vb 10
              primary:
              -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
              -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
              -chardev socket,id=mirror0,host=3.3.3.3,port=9003,server,nowait
              -chardev socket,id=compare1,host=3.3.3.3,port=9004,server,nowait
              -chardev socket,id=compare0,host=3.3.3.3,port=9001,server,nowait
              -chardev socket,id=compare0-0,host=3.3.3.3,port=9001
              -chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
              -chardev socket,id=compare_out0,host=3.3.3.3,port=9005
              -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0
              -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out
              -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0
              -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0
              
              secondary:
              -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
              -device e1000,netdev=hn0,mac=52:a4:00:12:78:66
              -chardev socket,id=red0,host=3.3.3.3,port=9003
              -chardev socket,id=red1,host=3.3.3.3,port=9004
              -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0
              -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1
      .Ve
      .Sp
      If you want to know the detail of above command line, you can read
      the colo-compare git log.
    * **-object cryptodev-backend-builtin,id=**_id_**[,queues=**_queues_**]**  
      .IX Item "-object cryptodev-backend-builtin,id=id[,queues=queues]"
      Creates a cryptodev backend which executes crypto opreation from
      the \s-1QEMU\s0 cipher \s-1APIS.\s0 The _id_ parameter is
      a unique \s-1ID\s0 that will be used to reference this cryptodev backend from
      the **virtio-crypto** device. The _queues_ parameter is optional,
      which specify the queue number of cryptodev backend, the default of
      _queues_ is 1.
      .Sp
      .Vb 5
              # qemu-system-x86_64 \e
              [...] \e
              -object cryptodev-backend-builtin,id=cryptodev0 \e
              -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \e
              [...]
      .Ve
    * **-object cryptodev-vhost-user,id=**_id_**,chardev=**_chardevid_**[,queues=**_queues_**]**  
      .IX Item "-object cryptodev-vhost-user,id=id,chardev=chardevid[,queues=queues]"
      Creates a vhost-user cryptodev backend, backed by a chardev _chardevid_.
      The _id_ parameter is a unique \s-1ID\s0 that will be used to reference this
      cryptodev backend from the **virtio-crypto** device.
      The chardev should be a unix domain socket backed one. The vhost-user uses
      a specifically defined protocol to pass vhost ioctl replacement messages
      to an application on the other end of the socket.
      The _queues_ parameter is optional, which specify the queue number
      of cryptodev backend for multiqueue vhost-user, the default of _queues_ is 1.
      .Sp
      .Vb 6
              # qemu-system-x86_64 \e
              [...] \e
              -chardev socket,id=chardev0,path=/path/to/socket \e
              -object cryptodev-vhost-user,id=cryptodev0,chardev=chardev0 \e
              -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \e
              [...]
      .Ve
    * **-object secret,id=**_id_**,data=**_string_**,format=**_raw|base64_**[,keyid=**_secretid_**,iv=**_string_**]**  
      .IX Item "-object secret,id=id,data=string,format=raw|base64[,keyid=secretid,iv=string]"
    * **-object secret,id=**_id_**,file=**_filename_**,format=**_raw|base64_**[,keyid=**_secretid_**,iv=**_string_**]**  
      .IX Item "-object secret,id=id,file=filename,format=raw|base64[,keyid=secretid,iv=string]"
      Defines a secret to store a password, encryption key, or some other sensitive
      data. The sensitive data can either be passed directly via the _data_
      parameter, or indirectly via the _file_ parameter. Using the _data_
      parameter is insecure unless the sensitive data is encrypted.
      .Sp
      The sensitive data can be provided in raw format (the default), or base64.
      When encoded as \s-1JSON,\s0 the raw format only supports valid \s-1UTF-8\s0 characters,
      so base64 is recommended for sending binary data. \s-1QEMU\s0 will convert from
      which ever format is provided to the format it needs internally. eg, an
      \s-1RBD\s0 password can be provided in raw format, even though it will be base64
      encoded when passed onto the \s-1RBD\s0 sever.
      .Sp
      For added protection, it is possible to encrypt the data associated with
      a secret using the \s-1AES-256-CBC\s0 cipher. Use of encryption is indicated
      by providing the _keyid_ and _iv_ parameters. The _keyid_
      parameter provides the \s-1ID\s0 of a previously defined secret that contains
      the \s-1AES-256\s0 decryption key. This key should be 32-bytes long and be
      base64 encoded. The _iv_ parameter provides the random initialization
      vector used for encryption of this particular secret and should be a
      base64 encrypted string of the 16-byte \s-1IV.\s0
      .Sp
      The simplest (insecure) usage is to provide the secret inline
      .Sp
      .Vb 1
              # $QEMU -object secret,id=sec0,data=letmein,format=raw
      .Ve
      .Sp
      The simplest secure usage is to provide the secret via a file
      .Sp
      # printf letmein\*(R" &gt; mypasswd.txt
      # \f(CW$QEMU -object secret,id=sec0,file=mypasswd.txt,format=raw
      .Sp
      For greater security, \s-1AES-256-CBC\s0 should be used. To illustrate usage,
      consider the openssl command line tool which can encrypt the data. Note
      that when encrypting, the plaintext must be padded to the cipher block
      size (32 bytes) using the standard PKCS#5/6 compatible padding algorithm.
      .Sp
      First a master key needs to be created in base64 encoding:
      .Sp
      .Vb 2
              # openssl rand -base64 32 &gt; key.b64
              # KEY=$(base64 -d key.b64 | hexdump  -v -e /1 "%02X"\*(Aq)
      .Ve
      .Sp
      Each secret to be encrypted needs to have a random initialization vector
      generated. These do not need to be kept secret
      .Sp
      .Vb 2
              # openssl rand -base64 16 &gt; iv.b64
              # IV=$(base64 -d iv.b64 | hexdump  -v -e /1 "%02X"\*(Aq)
      .Ve
      .Sp
      The secret to be defined can now be encrypted, in this case we're
      telling openssl to base64 encode the result, but it could be left
      as raw bytes if desired.
      .Sp
      .Vb 2
              # SECRET=$(printf "letmein" |
              openssl enc -aes-256-cbc -a -K $KEY -iv $IV)
      .Ve
      .Sp
      When launching \s-1QEMU,\s0 create a master secret pointing to \f(CW`key.b64\*(C'
      and specify that to be used to decrypt the user password. Pass the
      contents of \f(CW`iv.b64\*(C' to the second secret
      .Sp
      .Vb 4
              # $QEMU \e
              -object secret,id=secmaster0,format=base64,file=key.b64 \e
              -object secret,id=sec0,keyid=secmaster0,format=base64,\e
              data=$SECRET,iv=$(&lt;iv.b64)
      .Ve
    * **-object sev-guest,id=**_id_**,cbitpos=**_cbitpos_**,reduced-phys-bits=**_val_**,[sev-device=**_string_**,policy=**_policy_**,handle=**_handle_**,dh-cert-file=**_file_**,session-file=**_file_**]**  
      .IX Item "-object sev-guest,id=id,cbitpos=cbitpos,reduced-phys-bits=val,[sev-device=string,policy=policy,handle=handle,dh-cert-file=file,session-file=file]"
      Create a Secure Encrypted Virtualization (\s-1SEV\s0) guest object, which can be used
      to provide the guest memory encryption support on \s-1AMD\s0 processors.
      .Sp
      When memory encryption is enabled, one of the physical address bit (aka the
      C-bit) is utilized to mark if a memory page is protected. The **cbitpos**
      is used to provide the C-bit position. The C-bit position is Host family dependent
      hence user must provide this value. On \s-1EPYC,\s0 the value should be 47.
      .Sp
      When memory encryption is enabled, we loose certain bits in physical address space.
      The **reduced-phys-bits** is used to provide the number of bits we loose in
      physical address space. Similar to C-bit, the value is Host family dependent.
      On \s-1EPYC,\s0 the value should be 5.
      .Sp
      The **sev-device** provides the device file to use for communicating with
      the \s-1SEV\s0 firmware running inside \s-1AMD\s0 Secure Processor. The default device is
      '/dev/sev'. If hardware supports memory encryption then /dev/sev devices are
      created by \s-1CCP\s0 driver.
      .Sp
      The **policy** provides the guest policy to be enforced by the \s-1SEV\s0 firmware
      and restrict what configuration and operational commands can be performed on this
      guest by the hypervisor. The policy should be provided by the guest owner and is
      bound to the guest and cannot be changed throughout the lifetime of the guest.
      The default is 0.
      .Sp
      If guest **policy** allows sharing the key with another \s-1SEV\s0 guest then
      **handle** can be use to provide handle of the guest from which to share
      the key.
      .Sp
      The **dh-cert-file** and **session-file** provides the guest owner's
      Public Diffie-Hillman key defined in \s-1SEV\s0 spec. The \s-1PDH\s0 and session parameters
      are used for establishing a cryptographic session with the guest owner to
      negotiate keys used for attestation. The file must be encoded in base64.
      .Sp
      e.g to launch a \s-1SEV\s0 guest
      .Sp
      .Vb 5
              # $QEMU \e
              ......
              -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=5 \e
              -machine ...,memory-encryption=sev0
              .....
      .Ve

During the graphical emulation, you can use special key combinations to change
modes. The default key mappings are shown below, but if you use \f(CW`-alt-grab\*(C'
then the modifier is Ctrl-Alt-Shift (instead of Ctrl-Alt) and if you use
\f(CW`-ctrl-grab\*(C' then the modifier is the right Ctrl key (instead of Ctrl-Alt):

* **Ctrl-Alt-f**  
  .IX Item "Ctrl-Alt-f"
  Toggle full screen
* **Ctrl-Alt-+**  
  .IX Item "Ctrl-Alt-+"
  Enlarge the screen
* **Ctrl-Alt**  
  .IX Item "Ctrl-Alt"
  Shrink the screen
* **Ctrl-Alt-u**  
  .IX Item "Ctrl-Alt-u"
  Restore the screen's un-scaled dimensions
* **Ctrl-Alt-n**  
  .IX Item "Ctrl-Alt-n"
  Switch to virtual console 'n'. Standard console mappings are:
    * _1_  
      .IX Item "1"
      Target system display
    * _2_  
      .IX Item "2"
      Monitor
    * _3_  
      .IX Item "3"
      Serial port
* **Ctrl-Alt**  
  .IX Item "Ctrl-Alt"
  Toggle mouse and keyboard grab.

In the virtual consoles, you can use **Ctrl-Up**, **Ctrl-Down**,
**Ctrl-PageUp** and **Ctrl-PageDown** to move in the back log.

During emulation, if you are using a character backend multiplexer
(which is the default if you are using **-nographic**) then
several commands are available via an escape sequence. These
key sequences all start with an escape character, which is **Ctrl-a**
by default, but can be changed with **-echr**. The list below assumes
you're using the default.

* **Ctrl-a h**  
  .IX Item "Ctrl-a h"
  Print this help
* **Ctrl-a x**  
  .IX Item "Ctrl-a x"
  Exit emulator
* **Ctrl-a s**  
  .IX Item "Ctrl-a s"
  Save disk data back to file (if -snapshot)
* **Ctrl-a t**  
  .IX Item "Ctrl-a t"
  Toggle console timestamps
* **Ctrl-a b**  
  .IX Item "Ctrl-a b"
  Send break (magic sysrq in Linux)
* **Ctrl-a c**  
  .IX Item "Ctrl-a c"
  Rotate between the frontends connected to the multiplexer (usually
  this switches between the monitor and the console)
* **Ctrl-a Ctrl-a**  
  .IX Item "Ctrl-a Ctrl-a"
  Send the escape character to the frontend

The following options are specific to the PowerPC emulation:

* **-g** _W_**x**_H_**[x**_\s-1DEPTH\s0_**]**  
  .IX Item "-g WxH[xDEPTH]"
  Set the initial \s-1VGA\s0 graphic mode. The default is 800x600x32.
* **-prom-env** _string_  
  .IX Item "-prom-env string"
  Set OpenBIOS variables in \s-1NVRAM,\s0 for example:
  .Sp
  .Vb 3
          qemu-system-ppc -prom-env auto-boot?=false\*(Aq \e
           -prom-env boot-device=hd:2,\eyaboot\*(Aq \e
           -prom-env boot-args=conf=hd:2,\eyaboot.conf\*(Aq
  .Ve
  .Sp
  These variables are not used by Open Hack'Ware.

The following options are specific to the Sparc32 emulation:

* **-g** _W_**x**_H_**x[x**_\s-1DEPTH\s0_**]**  
  .IX Item "-g WxHx[xDEPTH]"
  Set the initial graphics mode. For \s-1TCX,\s0 the default is 1024x768x8 with the
  option of 1024x768x24. For cgthree, the default is 1024x768x8 with the option
  of 1152x900x8 for people who wish to use \s-1OBP.\s0
* **-prom-env** _string_  
  .IX Item "-prom-env string"
  Set OpenBIOS variables in \s-1NVRAM,\s0 for example:
  .Sp
  .Vb 2
          qemu-system-sparc -prom-env auto-boot?=false\*(Aq \e
           -prom-env boot-device=sd(0,2,0):d\*(Aq -prom-env \*(Aqboot-args=linux single\*(Aq
  .Ve
* **-M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPARCbook]**  
  .IX Item "-M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPARCbook]"
  Set the emulated machine type. Default is \s-1SS-5.\s0

The following options are specific to the Sparc64 emulation:

* **-prom-env** _string_  
  .IX Item "-prom-env string"
  Set OpenBIOS variables in \s-1NVRAM,\s0 for example:
  .Sp
  .Vb 1
          qemu-system-sparc64 -prom-env auto-boot?=false\*(Aq
  .Ve
* **-M [sun4u|sun4v|niagara]**  
  .IX Item "-M [sun4u|sun4v|niagara]"
  Set the emulated machine type. The default is sun4u.

The following options are specific to the \s-1ARM\s0 emulation:

* **-semihosting**  
  .IX Item "-semihosting"
  Enable semihosting syscall emulation.
  .Sp
  On \s-1ARM\s0 this implements the Angel\*(R" interface.
  .Sp
  Note that this allows guest direct access to the host filesystem,
  so should only be used with trusted guest \s-1OS.\s0

The following options are specific to the ColdFire emulation:

* **-semihosting**  
  .IX Item "-semihosting"
  Enable semihosting syscall emulation.
  .Sp
  On M68K this implements the ColdFire \s-1GDB\*(R"\s0 interface used by libgloss.
  .Sp
  Note that this allows guest direct access to the host filesystem,
  so should only be used with trusted guest \s-1OS.\s0

The following options are specific to the Xtensa emulation:

* **-semihosting**  
  .IX Item "-semihosting"
  Enable semihosting syscall emulation.
  .Sp
  Xtensa semihosting provides basic file \s-1IO\s0 calls, such as open/read/write/seek/select.
  Tensilica baremetal libc for \s-1ISS\s0 and linux platform sim\*(R" use this interface.
  .Sp
  Note that this allows guest direct access to the host filesystem,
  so should only be used with trusted guest \s-1OS.\s0

<a name="notes"></a>

# Notes

.IX Header "NOTES"
In addition to using normal file images for the emulated storage devices,
\s-1QEMU\s0 can also use networked resources such as iSCSI devices. These are
specified using a special \s-1URL\s0 syntax.

* **iSCSI**  
  .IX Item "iSCSI"
  iSCSI support allows \s-1QEMU\s0 to access iSCSI resources directly and use as
  images for the guest storage. Both disk and cdrom images are supported.
  .Sp
  Syntax for specifying iSCSI LUNs is
  iscsi://&lt;target-ip&gt;[:&lt;port&gt;]/&lt;target-iqn&gt;/&lt;lun&gt;\*(R"
  .Sp
  By default qemu will use the iSCSI initiator-name
  'iqn.2008-11.org.linux-kvm[:&lt;name&gt;]' but this can also be set from the command
  line or a configuration file.
  .Sp
  Since version Qemu 2.4 it is possible to specify a iSCSI request timeout to detect
  stalled requests and force a reestablishment of the session. The timeout
  is specified in seconds. The default is 0 which means no timeout. Libiscsi
  1.15.0 or greater is required for this feature.
  .Sp
  Example (without authentication):
  .Sp
  .Vb 3
          qemu-system-i386 -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \e
                           -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \e
                           -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
  .Ve
  .Sp
  Example (\s-1CHAP\s0 username/password via \s-1URL\s0):
  .Sp
  .Vb 1
          qemu-system-i386 -drive file=iscsi://user%password@192.0.2.1/iqn.2001-04.com.example/1
  .Ve
  .Sp
  Example (\s-1CHAP\s0 username/password via environment variables):
  .Sp
  .Vb 3
          LIBISCSI_CHAP_USERNAME="user" \e
          LIBISCSI_CHAP_PASSWORD="password" \e
          qemu-system-i386 -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
  .Ve
* **\s-1NBD\s0**  
  .IX Item "NBD"
  \s-1QEMU\s0 supports \s-1NBD\s0 (Network Block Devices) both using \s-1TCP\s0 protocol as well
  as Unix Domain Sockets.
  .Sp
  Syntax for specifying a \s-1NBD\s0 device using \s-1TCP\s0
  nbd:&lt;server-ip&gt;:&lt;port&gt;[:exportname=&lt;export&gt;]\*(R"
  .Sp
  Syntax for specifying a \s-1NBD\s0 device using Unix Domain Sockets
  nbd:unix:&lt;domain-socket&gt;[:exportname=&lt;export&gt;]\*(R"
  .Sp
  Example for \s-1TCP\s0
  .Sp
  .Vb 1
          qemu-system-i386 --drive file=nbd:192.0.2.1:30000
  .Ve
  .Sp
  Example for Unix Domain Sockets
  .Sp
  .Vb 1
          qemu-system-i386 --drive file=nbd:unix:/tmp/nbd-socket
  .Ve
* **\s-1SSH\s0**  
  .IX Item "SSH"
  \s-1QEMU\s0 supports \s-1SSH\s0 (Secure Shell) access to remote disks.
  .Sp
  Examples:
  .Sp
  .Vb 2
          qemu-system-i386 -drive file=ssh://user@host/path/to/disk.img
          qemu-system-i386 -drive file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
  .Ve
  .Sp
  Currently authentication must be done using ssh-agent.  Other
  authentication methods may be supported in future.
* **Sheepdog**  
  .IX Item "Sheepdog"
  Sheepdog is a distributed storage system for \s-1QEMU.
  QEMU\s0 supports using either local sheepdog devices or remote networked
  devices.
  .Sp
  Syntax for specifying a sheepdog device
  .Sp
  .Vb 1
          sheepdog[+tcp|+unix]://[host:port]/vdiname[?socket=path][#snapid|#tag]
  .Ve
  .Sp
  Example
  .Sp
  .Vb 1
          qemu-system-i386 --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
  .Ve
  .Sp
  See also &lt;**https://sheepdog.github.io/sheepdog/**&gt;.
* **GlusterFS**  
  .IX Item "GlusterFS"
  GlusterFS is a user space distributed file system.
  \s-1QEMU\s0 supports the use of GlusterFS volumes for hosting \s-1VM\s0 disk images using
  \s-1TCP,\s0 Unix Domain Sockets and \s-1RDMA\s0 transport protocols.
  .Sp
  Syntax for specifying a \s-1VM\s0 disk image on GlusterFS volume is
  .Sp
  .Vb 2
          URI:
          gluster[+type]://[host[:port]]/volume/path[?socket=...][,debug=N][,logfile=...]
          
          JSON:
          json:{"driver":"qcow2","file":{"driver":"gluster","volume":"testvol","path":"a.img","debug":N,"logfile":"...",
                                           "server":[{"type":"tcp","host":"...","port":"..."},
                                                     {"type":"unix","socket":"..."}]}}
  .Ve
  .Sp
  Example
  .Sp
  .Vb 3
          URI:
          qemu-system-x86_64 --drive file=gluster://192.0.2.1/testvol/a.img,
                                         file.debug=9,file.logfile=/var/log/qemu-gluster.log
          
          JSON:
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
  .Sp
  See also &lt;**http://www.gluster.org**&gt;.
* **\s-1HTTP/HTTPS/FTP/FTPS\s0**  
  .IX Item "HTTP/HTTPS/FTP/FTPS"
  \s-1QEMU\s0 supports read-only access to files accessed over http(s) and ftp(s).
  .Sp
  Syntax using a single filename:
  .Sp
  .Vb 1
          &lt;protocol&gt;://[&lt;username&gt;[:&lt;password&gt;]@]&lt;host&gt;/&lt;path&gt;
  .Ve
  .Sp
  where:
    * **protocol**  
      .IX Item "protocol"
      'http', 'https', 'ftp', or 'ftps'.
    * **username**  
      .IX Item "username"
      Optional username for authentication to the remote server.
    * **password**  
      .IX Item "password"
      Optional password for authentication to the remote server.
    * **host**  
      .IX Item "host"
      Address of the remote server.
    * **path**  
      .IX Item "path"
      Path on the remote server, including any query string.
      .Sp
      The following options are also supported:
    * **url**  
      .IX Item "url"
      The full \s-1URL\s0 when passing options to the driver explicitly.
    * **readahead**  
      .IX Item "readahead"
      The amount of data to read ahead with each range request to the remote server.
      This value may optionally have the suffix 'T', 'G', 'M', 'K', 'k' or 'b'. If it
      does not have a suffix, it will be assumed to be in bytes. The value must be a
      multiple of 512 bytes. It defaults to 256k.
    * **sslverify**  
      .IX Item "sslverify"
      Whether to verify the remote server's certificate when connecting over \s-1SSL.\s0 It
      can have the value 'on' or 'off'. It defaults to 'on'.
    * **cookie**  
      .IX Item "cookie"
      Send this cookie (it can also be a list of cookies separated by ';') with
      each outgoing request.  Only supported when using protocols such as \s-1HTTP\s0
      which support cookies, otherwise ignored.
    * **timeout**  
      .IX Item "timeout"
      Set the timeout in seconds of the \s-1CURL\s0 connection. This timeout is the time
      that \s-1CURL\s0 waits for a response from the remote server to get the size of the
      image to be downloaded. If not set, the default timeout of 5 seconds is used.
      .Sp
      Note that when passing options to qemu explicitly, **driver** is the value
      of &lt;protocol&gt;.
      .Sp
      Example: boot from a remote Fedora 20 live \s-1ISO\s0 image
      .Sp
      .Vb 1
              qemu-system-x86_64 --drive media=cdrom,file=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
              
              qemu-system-x86_64 --drive media=cdrom,file.driver=http,file.url=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
      .Ve
      .Sp
      Example: boot from a remote Fedora 20 cloud image using a local overlay for
      writes, copy-on-read, and a readahead of 64k
      .Sp
      .Vb 1
              qemu-img create -f qcow2 -o backing_file=json:{"file.driver":"http",, "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",, "file.readahead":"64k"}\*(Aq /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
              
              qemu-system-x86_64 -drive file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
      .Ve
      .Sp
      Example: boot from an image stored on a VMware vSphere server with a self-signed
      certificate using a local overlay for writes, a readahead of 64k and a timeout
      of 10 seconds.
      .Sp
      .Vb 1
              qemu-img create -f qcow2 -o backing_file=json:{"file.driver":"https",, "file.url":"https://user:password@vsphere.example.com/folder/test/test-flat.vmdk?dcPath=Datacenter&dsName=datastore1",, "file.sslverify":"off",, "file.readahead":"64k",, "file.timeout":10}\*(Aq /tmp/test.qcow2
              
              qemu-system-x86_64 -drive file=/tmp/test.qcow2
      .Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
The \s-1HTML\s0 documentation of \s-1QEMU\s0 for more precise information and Linux
user mode emulator invocation.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Fabrice Bellard
