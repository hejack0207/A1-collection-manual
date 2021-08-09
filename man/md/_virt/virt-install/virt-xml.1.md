# virt-xml(1) - Edit libvirt XML using command line options.

"", ""

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

```

 virt-xml DOMAIN XML-ACTION XML-OPTION [OUTPUT-OPTION] [MISC-OPTIONS] ...
```

<a name="description"></a>

# Description


**virt-xml** is a command line tool for editing libvirt XML using explicit command line options. See the EXAMPLES section at the end of this document to jump right in.

Each **virt-xml** invocation requires 3 things: name of an existing domain to alter (or XML passed on stdin), an action to on the XML, and an XML change to make. actions are one of:
.INDENT 0.0

* ·  
  **--add-device**: Append a new device definition to the XML
* ·  
  **--remove-device**: Remove an existing device definition
* ·  
  **--edit**: Edit an existing XML block
* ·  
  **--build-xml**: Just build the requested XML block and print it. No domain or input are required here, but it's recommended to provide them, so virt-xml can fill in optimal defaults.
  .UNINDENT

An XML change is one instance of any of the XML options provided by virt-xml, for example --disk or --boot.

**virt-xml** only allows one action and XML pair per invocation. If you need to make multiple edits, invoke the command multiple times.

<a name="options"></a>

# Options

.INDENT 0.0

* <b>**-c** **--connect** URI</b>  
  Connect to a non-default hypervisor. See virt-install(1) for details
* <b>**domain**</b>  
  domain is the name, UUID, or ID of the existing VM. This can be omitted if
  using --build-xml, or if XML is passed on stdin.

When a domain is specified, the default output action is --define, even if the
VM is running. To update the running VM configuration, add the --update option
(but not all options/devices support updating the running VM configuration).

If XML is passed on stdin, the default output is --print-xml.
.UNINDENT

<a name="xml-actions"></a>

# Xml Actions

.INDENT 0.0

* <b>**--edit** [EDIT-OPTIONS]</b>  
  Edit the specified XML block. EDIT-OPTIONS tell **virt-xml** which block
  to edit. The type of XML that we are editing is decided by XML option that
  is passed to **virt-xml** . So if --disk is passed, EDIT-OPTIONS select
  which &lt;disk&gt; block to edit.

Certain XML options only ever map to a single XML block, like --cpu,
--security, --boot, --clock, and a few others. In those cases,
**virt-xml** will not complain if a corresponding XML block does not
already exist, it will create it for you.

Most XML options support a special value 'clearxml=yes'. When combined
with --edit, it will completely blank out the XML block being edited
before applying the requested changes. This allows completely rebuilding
an XML block. See EXAMPLES for some usage.

EDIT-OPTIONS examples:
.INDENT 7.0

* ·  
  .INDENT 2.0
* <b>**--edit**</b>  
  --edit without any options implies 'edit the first block'. So
  '--edit --disk DISK-OPTIONS' means 'edit the first &lt;disk&gt;'.

For the single XML block options mentioned above, plain
'--edit' without any options is what you always want to use.
.UNINDENT

* ·  
  .INDENT 2.0
* <b>**--edit** #</b>  
  Select the specified XML block number. So '--edit 2 --disk DISK-OPTS'
  means 'edit the second &lt;disk&gt;'. This option only really applies for
  device XML.
  .UNINDENT
* ·  
  .INDENT 2.0
* <b>**--edit** all</b>  
  Modify every XML block of the XML option type. So
  '--edit all --disk DISK-OPTS' means 'edit ever &lt;disk&gt; block'.
  This option only really applies for device XML.
  .UNINDENT
* ·  
  .INDENT 2.0
* <b>**--edit** DEVICE-OPTIONS</b>  
  Modify every XML block that matches the passed device options.
  The device options are in the same format as would be passed to
  the XML option.
  .UNINDENT
  .UNINDENT

So _--edit path=/tmp/foo --disk DISK-OPTS_ means 'edit every &lt;disk&gt; with
path /tmp/foo'. This option only really applies for device XML.

* <b>**--add-device**</b>  
  Append the specified XML options to the XML &lt;devices&gt; list. Example:
  '--add-device --disk DISK-OPTIONS' will create a new &lt;disk&gt; block and
  add it to the XML.

This option will error if specified with a non-device XML option
(see --edit section for a partial list).

* <b>**--remove-device**</b>  
  Remove the specified device from the XML. The device to remove is chosen
  by the XML option, which takes arguments in the same format as --edit.
  Examples:
  .INDENT 7.0
* ·  
  .INDENT 2.0
* <b>**--remove-device --disk 2**</b>  
  Remove the second disk device
  .UNINDENT
* ·  
  .INDENT 2.0
* <b>**--remove-device --network all**</b>  
  Remove all network devices
  .UNINDENT
* ·  
  .INDENT 2.0
* <b>**--remove-device --sound pcspk**</b>  
  Remove all sound devices with model='pcspk'
  .UNINDENT
  .UNINDENT

This option will error if specified with a non-device XML option
(see --edit isection for a partial list).

* <b>**--build-xml**</b>  
  Just build the specified XML, and print it to stdout. No input domain or
  input XML is required. Example: '--build-xml --disk DISK-OPTIONS' will
  just print the new &lt;disk&gt; device.

However if the generated XML is targeted for a specific domain, it's
recommended to pass it to virt-xml, so the tool can set optimal defaults.

This option will error if specified with an XML option that does not map
cleanly to a specific XML block, like --vcpus or --memory.
.UNINDENT

<a name="output-options"></a>

# Output Options


These options decide what action to take after altering the XML. In the common case these do not need to be specified, as 'XML actions' will imply a default output action, described in detail above. These are only needed if you want to modify the default output.
.INDENT 0.0

* <b>**--update**</b>  
  If the specified domain is running, attempt to alter the running VM configuration. If combined with --edit, this is an update operation. If combined with --add-device, this is a device hotplug. If combined with --remove-device, this is a device hotunplug.

Keep in mind, most XML properties and devices do not support live update operations, so don't expect it to succeed in all cases.

By default this also implies **--define**.

* <b>**--define**</b>  
  Define the requested XML change. This is typically the default if no output option is specified, but if a --print option is specified, --define is required to force the change.
* <b>**--no-define**</b>  
  Explicitly do not define the XML. For example if you only want to alter the runtime state of a VM, combine this with **--update**.
* <b>**--start**</b>  
  Start the VM after performing the requeseted changes. If combined with --no-define, this will create transient VM boot with the requested changes.
* <b>**--print-diff**</b>  
  Print the generated XML change in unified diff format. If only this output option is specified, all other output options are disabled and no persistent change is made.
* <b>**--print-xml**</b>  
  Print the generated XML in its entirety. If only this output option is specified, all other output options are disabled and no persistent change is made.
* <b>**--confirm**</b>  
  Before defining or updating the domain, show the generated XML diff and interactively request confirmation.
  .UNINDENT

<a name="guest-os-options"></a>

# Guest Os Options

.INDENT 0.0

* <b>**--os-variant**, **--osinfo** OS_VARIANT</b>  
  Optimize the guest configuration for a specific operating system (ex.
  'fedora29', 'rhel7', 'win10'). While not required, specifying this
  options is HIGHLY RECOMMENDED, as it can greatly increase performance
  by specifying virtio among other guest tweaks.

If the guest has been installed using virt-manager version 2.0.0 or newer,
providing this information should not be necessary, as the OS variant will
have been stored in the guest configuration during installation and virt-xml
will retrieve it from there automatically.

Use the command "osinfo-query os" to get the list of the accepted OS
variants.

See virt-install(1) documentation for more details about **--os-variant**
.UNINDENT

<a name="xml-options"></a>

# Xml Options

.INDENT 0.0

* ·  
  **--disk**
* ·  
  **--network**
* ·  
  **--graphics**
* ·  
  **--metadata**
* ·  
  **--memory**
* ·  
  **--vcpus**
* ·  
  **--cpu**
* ·  
  **--iothreads**
* ·  
  **--seclabel**
* ·  
  **--keywrap**
* ·  
  **--cputune**
* ·  
  **--numatune**
* ·  
  **--memtune**
* ·  
  **--blkiotune**
* ·  
  **--memorybacking**
* ·  
  **--features**
* ·  
  **--clock**
* ·  
  **--pm**
* ·  
  **--events**
* ·  
  **--resources**
* ·  
  **--sysinfo**
* ·  
  **--xml**
* ·  
  **--qemu-commandline**
* ·  
  **--launchSecurity**
* ·  
  **--boot**
* ·  
  **--idmap**
* ·  
  **--controller**
* ·  
  **--input**
* ·  
  **--serial**
* ·  
  **--parallel**
* ·  
  **--channel**
* ·  
  **--console**
* ·  
  **--hostdev**
* ·  
  **--filesystem**
* ·  
  **--sound**
* ·  
  **--watchdog**
* ·  
  **--video**
* ·  
  **--smartcard**
* ·  
  **--redirdev**
* ·  
  **--memballoon**
* ·  
  **--tpm**
* ·  
  **--rng**
* ·  
  **--panic**
* ·  
  **--memdev**
  .UNINDENT

These options alter the XML for a single class of XML elements. More complete documentation is found in virt-install(1).

Generally these options map pretty straightforwardly to the libvirt XML, documented at _https://libvirt.org/formatdomain.html_

Option strings are in the format of: --option opt=val,opt2=val2,...  example: --disk path=/tmp/foo,shareable=on. Properties can be used with '--option opt=,', so to clear a disks cache setting you could use '--disk cache=,'

For any option, use --option=? to see a list of all available sub options, example: --disk=?  or  --boot=?

--help output also lists a few general examples. See the EXAMPLES section below for some common examples.

<a name="miscellaneous-options"></a>

# Miscellaneous Options

.INDENT 0.0

* <b>**-h**, **--help**</b>  
  Show the help message and exit
* <b>**--version**</b>  
  Show program's version number and exit
* <b>**-q**, **--quiet**</b>  
  Avoid verbose output.
* <b>**-d**, **--debug**</b>  
  Print debugging information
  .UNINDENT

<a name="examples"></a>

# Examples


See a list of all suboptions that --disk and --network take
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml --disk=? --network=?
    .ft P
.UNINDENT
.UNINDENT

Change the &lt;description&gt; of domain 'EXAMPLE':
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml EXAMPLE --edit --metadata description="my new description"
    .ft P
.UNINDENT
.UNINDENT

# Enable the boot device menu for domain 'EXAMPLE':
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml EXAMPLE --edit --boot menu=on
    .ft P
.UNINDENT
.UNINDENT

Clear the previous &lt;cpu&gt; definition of domain 'winxp', change it to 'host-model', but interactively confirm the diff before saving:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml winxp --edit --cpu host-model,clearxml=yes --confirm
    .ft P
.UNINDENT
.UNINDENT

Change the second sound card to model=ich6 on 'fedora19', but only output the diff:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml fedora19 --edit 2 --sound model=ich6 --print-diff
    .ft P
.UNINDENT
.UNINDENT

Update the every graphics device password to 'foo' of the running VM 'rhel6':
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml rhel6 --edit all --graphics password=foo --update
    .ft P
.UNINDENT
.UNINDENT

Remove the disk path from disk device hdc:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml rhel6 --edit target=hdc --disk path=
    .ft P
.UNINDENT
.UNINDENT

Change all disk devices of type 'disk' to use cache=none, using XML from stdin, printing the new XML to stdout.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # cat <xmlfile> | virt-xml --edit device=disk --disk cache=none
    .ft P
.UNINDENT
.UNINDENT

Change disk 'hda' IO to native and use startup policy as 'optional'.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml fedora20 --edit target=hda e
               --disk io=native,startup_policy=optional
    .ft P
.UNINDENT
.UNINDENT

Change all host devices to use driver_name=vfio for VM 'fedora20' on the remote connection
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml --connect qemu+ssh://remotehost/system e
               fedora20 --edit all --hostdev driver_name=vfio
    .ft P
.UNINDENT
.UNINDENT

Hotplug host USB device 001.003 to running domain 'fedora19':
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml fedora19 --update --add-device --hostdev 001.003
    .ft P
.UNINDENT
.UNINDENT

Add a spicevmc channel to the domain 'winxp', that will be available after the next VM shutdown.
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml winxp --add-device --channel spicevmc
    .ft P
.UNINDENT
.UNINDENT

Create a 10G qcow2 disk image and attach it to 'fedora18' for the next VM startup:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml fedora18 --add-device e
      --disk /var/lib/libvirt/images/newimage.qcow2,format=qcow2,size=10
    .ft P
.UNINDENT
.UNINDENT

Same as above, but ensure the disk is attached to the most appropriate bus
for the guest OS by providing information about it on the command line:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml fedora18 --os-variant fedora18 --add-device e
      --disk /var/lib/libvirt/images/newimage.qcow2,format=qcow2,size=10
    .ft P
.UNINDENT
.UNINDENT

Hotunplug the disk vdb from the running domain 'rhel7':
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml rhel7 --update --remove-device --disk target=vdb
    .ft P
.UNINDENT
.UNINDENT

Remove all graphics devices from the VM 'rhel7' after the next shutdown:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml rhel7 --remove-device --graphics all
    .ft P
.UNINDENT
.UNINDENT

Generate XML for a virtio console device and print it to stdout:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml --build-xml --console pty,target_type=virtio
    .ft P
.UNINDENT
.UNINDENT

Add qemu command line passthrough:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml f25 --edit --confirm --qemu-commandline="-device FOO"
    .ft P
.UNINDENT
.UNINDENT

Use boot device 'network' for a single transient boot:
.INDENT 0.0
.INDENT 3.5

    .ft C
    # virt-xml myvm --no-define --start --edit --boot network
    .ft P
.UNINDENT
.UNINDENT

<a name="caveats"></a>

# Caveats


Virtualization hosts supported by libvirt may not permit all changes that might seem possible. Some edits made to a VM's definition may be ignored. For instance, QEMU does not allow the removal of certain devices once they've been defined.

<a name="bugs"></a>

# Bugs


Please see _https://virt-manager.org/bugs_

<a name="copyright"></a>

# Copyright


Copyright (C) Red Hat, Inc, and various contributors.
This is free software. You may redistribute copies of it under the terms
of the GNU General Public License _https://www.gnu.org/licenses/gpl.html_.
There is NO WARRANTY, to the extent permitted by law.

<a name="see-also"></a>

# See Also


virt-install(1), the project website _https://virt-manager.org_

