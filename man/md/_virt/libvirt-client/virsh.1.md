# virsh(1) - management user interface

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

 virsh [OPTION]... [COMMAND_STRING] 
 virsh [OPTION]... COMMAND [ARG]...
```

<a name="description"></a>

# Description


The **virsh** program is the main interface for managing virsh guest
domains. The program can be used to create, pause, and shutdown
domains. It can also be used to list current domains. Libvirt is a C
toolkit to interact with the virtualization capabilities of recent
versions of Linux (and other OSes). It is free software available
under the GNU Lesser General Public License. Virtualization of the
Linux Operating System means the ability to run multiple instances of
Operating Systems concurrently on a single hardware system where the
basic resources are driven by a Linux instance. The library aims at
providing a long term stable C API.  It currently supports Xen, QEMU,
KVM, LXC, OpenVZ, VirtualBox and VMware ESX.

The basic structure of most virsh usage is:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh [OPTION]... <command> <domain> [ARG]...
    .ft P
.UNINDENT
.UNINDENT

Where _command_ is one of the commands listed below; _domain_ is the
numeric domain id, or the domain name, or the domain UUID; and _ARGS_
are command specific options.  There are a few exceptions to this rule
in the cases where the command in question acts on all domains, the
entire machine, or directly on the xen hypervisor.  Those exceptions
will be clear for each of those commands.  Note: it is permissible to
give numeric names to domains, however, doing so will result in a
domain that can only be identified by domain id. In other words, if a
numeric value is supplied it will be interpreted as a domain id, not
as a name. Any _command_ starting with **#** is treated as a comment
and silently ignored, all other unrecognized _commands_ are diagnosed.

The **virsh** program can be used either to run one _COMMAND_ by giving the
command and its arguments on the shell command line, or a _COMMAND\_STRING_
which is a single shell argument consisting of multiple _COMMAND_ actions
and their arguments joined with whitespace and separated by semicolons or
newlines between commands, where unquoted backslash-newline pairs are
elided.  Within _COMMAND\_STRING_, virsh understands the
same single, double, and backslash escapes as the shell, although you must
add another layer of shell escaping in creating the single shell argument,
and any word starting with unquoted _#_ begins a comment that ends at newline.
If no command is given in the command line, **virsh** will then start a minimal
interpreter waiting for your commands, and the **quit** command will then exit
the program.

The **virsh** program understands the following _OPTIONS_.

**-c**, **--connect** _URI_

Connect to the specified _URI_, as if by the **connect** command,
instead of the default connection.

**-d**, **--debug** _LEVEL_

Enable debug messages at integer _LEVEL_ and above.  _LEVEL_ can
range from 0 to 4 (default).  See the documentation of **VIRSH\_DEBUG**
environment variable below for the description of each _LEVEL_.
.INDENT 0.0

* ·  
  **-e**, **--escape** _string_
  .UNINDENT

Set alternative escape sequence for _console_ command. By default,
telnet's **^]** is used. Allowed characters when using hat notation are:
alphabetic character, @, [, ], , ^, _.
.INDENT 0.0

* ·  
  **-h**, **--help**
  .UNINDENT

Ignore all other arguments, and behave as if the **help** command were
given instead.
.INDENT 0.0

* ·  
  **-k**, **--keepalive-interval** _INTERVAL_
  .UNINDENT

Set an _INTERVAL_ (in seconds) for sending keepalive messages to
check whether connection to the server is still alive.  Setting the
interval to 0 disables client keepalive mechanism.
.INDENT 0.0

* ·  
  **-K**, **--keepalive-count** _COUNT_
  .UNINDENT

Set a number of times keepalive message can be sent without getting an
answer from the server without marking the connection dead.  There is
no effect to this setting in case the _INTERVAL_ is set to 0.
.INDENT 0.0

* ·  
  **-l**, **--log** _FILE_
  .UNINDENT

Output logging details to _FILE_.
.INDENT 0.0

* ·  
  **-q**, **--quiet**
  .UNINDENT

Avoid extra informational messages.
.INDENT 0.0

* ·  
  **-r**, **--readonly**
  .UNINDENT

Make the initial connection read-only, as if by the _--readonly_
option of the **connect** command.
.INDENT 0.0

* ·  
  **-t**, **--timing**
  .UNINDENT

Output elapsed time information for each command.
.INDENT 0.0

* ·  
  **-v**, **--version[=short]**
  .UNINDENT

Ignore all other arguments, and prints the version of the libvirt library
virsh is coming from
.INDENT 0.0

* ·  
  **-V**, **--version=long**
  .UNINDENT

Ignore all other arguments, and prints the version of the libvirt library
virsh is coming from and which options and driver are compiled in.

<a name="notes"></a>

# Notes


Most **virsh** operations rely upon the libvirt library being able to
connect to an already running libvirtd service.  This can usually be
done using the command **service libvirtd start**.

Most **virsh** commands require root privileges to run due to the
communications channels used to talk to the hypervisor.  Running as
non root will return an error.

Most **virsh** commands act synchronously, except maybe shutdown,
setvcpus and setmem. In those cases the fact that the **virsh**
program returned, may not mean the action is complete and you
must poll periodically to detect that the guest completed the
operation.

**virsh** strives for backward compatibility.  Although the **help**
command only lists the preferred usage of a command, if an older
version of **virsh** supported an alternate spelling of a command or
option (such as _--tunnelled_ instead of _--tunneled_), then
scripts using that older spelling will continue to work.

Several **virsh** commands take an optionally scaled integer; if no
scale is provided, then the default is listed in the command (for
historical reasons, some commands default to bytes, while other
commands default to kibibytes).  The following case-insensitive
suffixes can be used to select a specific scale:
.INDENT 0.0
.INDENT 3.5

    .ft C
    b, byte  byte      1
    KB       kilobyte  1,000
    k, KiB   kibibyte  1,024
    MB       megabyte  1,000,000
    M, MiB   mebibyte  1,048,576
    GB       gigabyte  1,000,000,000
    G, GiB   gibibyte  1,073,741,824
    TB       terabyte  1,000,000,000,000
    T, TiB   tebibyte  1,099,511,627,776
    PB       petabyte  1,000,000,000,000,000
    P, PiB   pebibyte  1,125,899,906,842,624
    EB       exabyte   1,000,000,000,000,000,000
    E, EiB   exbibyte  1,152,921,504,606,846,976
    .ft P
.UNINDENT
.UNINDENT

<a name="generic-commands"></a>

# Generic Commands


The following commands are generic i.e. not specific to a domain.

<a name="help"></a>

### help


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    help [command-or-group]
    .ft P
.UNINDENT
.UNINDENT

This lists each of the virsh commands.  When used without options, all
commands are listed, one per line, grouped into related categories,
displaying the keyword for each group.

To display only commands for a specific group, give the keyword for that
group as an option.  For example:

**Example 1:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh # help host
    
    Host and Hypervisor (help keyword 'host'):
        capabilities                   capabilities
        cpu-models                     show the CPU models for an architecture
        connect                        (re)connect to hypervisor
        freecell                       NUMA free memory
        hostname                       print the hypervisor hostname
        qemu-attach                    Attach to existing QEMU process
        qemu-monitor-command           QEMU Monitor Command
        qemu-agent-command             QEMU Guest Agent Command
        sysinfo                        print the hypervisor sysinfo
        uri                            print the hypervisor canonical URI
    .ft P
.UNINDENT
.UNINDENT

To display detailed information for a specific command, give its name as the
option instead.  For example:

**Example 2:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh # help list
      NAME
        list - list domains
    
      SYNOPSIS
        list [--inactive] [--all]
    
      DESCRIPTION
        Returns list of domains.
    
      OPTIONS
        --inactive       list inactive domains
        --all            list inactive & active domains
    .ft P
.UNINDENT
.UNINDENT

<a name="quit-exit"></a>

### quit, exit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    quit
    exit
    .ft P
.UNINDENT
.UNINDENT

quit this interactive terminal

<a name="version"></a>

### version


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    version [--daemon]
    .ft P
.UNINDENT
.UNINDENT

Will print out the major version info about what this built from.
If _--daemon_ is specified then the version of the libvirt daemon
is included in the output.

**Example:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ virsh version
    Compiled against library: libvirt 1.2.3
    Using library: libvirt 1.2.3
    Using API: QEMU 1.2.3
    Running hypervisor: QEMU 2.0.50
    
    $ virsh version --daemon
    Compiled against library: libvirt 1.2.3
    Using library: libvirt 1.2.3
    Using API: QEMU 1.2.3
    Running hypervisor: QEMU 2.0.50
    Running against daemon: 1.2.6
    .ft P
.UNINDENT
.UNINDENT

<a name="cd"></a>

### cd


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    cd [directory]
    .ft P
.UNINDENT
.UNINDENT

Will change current directory to _directory_.  The default directory
for the **cd** command is the home directory or, if there is no _HOME_
variable in the environment, the root directory.

This command is only available in interactive mode.

<a name="pwd"></a>

### pwd


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pwd
    .ft P
.UNINDENT
.UNINDENT

Will print the current directory.

<a name="connect"></a>

### connect


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    connect [URI] [--readonly]
    .ft P
.UNINDENT
.UNINDENT

(Re)-Connect to the hypervisor. When the shell is first started, this
is automatically run with the _URI_ parameter requested by the **-c**
option on the command line. The _URI_ parameter specifies how to
connect to the hypervisor. The URI docs
_https://libvirt.org/uri.html_ list the
values supported, but the most common are:
.INDENT 0.0

* ·  
  xen:///system

this is used to connect to the local Xen hypervisor

* ·  
  qemu:///system

connect locally as root to the daemon supervising QEMU and KVM domains

* ·  
  qemu:///session

connect locally as a normal user to his own set of QEMU and KVM domains

* ·  
  lxc:///system

connect to a local linux container
.UNINDENT

To find the currently used URI, check the _uri_ command documented below.

For remote access see the URI docs
_https://libvirt.org/uri.html_ on how
to make URIs. The _--readonly_ option allows for read-only connection

<a name="uri"></a>

### uri


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    uri
    .ft P
.UNINDENT
.UNINDENT

Prints the hypervisor canonical URI, can be useful in shell mode.

<a name="hostname"></a>

### hostname


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    hostname
    .ft P
.UNINDENT
.UNINDENT

Print the hypervisor hostname.

<a name="sysinfo"></a>

### sysinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    sysinfo
    .ft P
.UNINDENT
.UNINDENT

Print the XML representation of the hypervisor sysinfo, if available.

<a name="nodeinfo"></a>

### nodeinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodeinfo
    .ft P
.UNINDENT
.UNINDENT

Returns basic information about the node, like number and type of CPU,
and size of the physical memory. The output corresponds to virNodeInfo
structure. Specifically, the "CPU socket(s)" field means number of CPU
sockets per NUMA cell. The information libvirt displays is dependent
upon what each architecture may provide.

<a name="nodecpumap"></a>

### nodecpumap


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodecpumap [--pretty]
    .ft P
.UNINDENT
.UNINDENT

Displays the node's total number of CPUs, the number of online CPUs
and the list of online CPUs.

With _--pretty_ the online CPUs are printed as a range instead of a list.

<a name="nodecpustats"></a>

### nodecpustats


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodecpustats [cpu] [--percent]
    .ft P
.UNINDENT
.UNINDENT

Returns cpu stats of the node.
If _cpu_ is specified, this will print the specified cpu statistics only.
If _--percent_ is specified, this will print the percentage of each kind
of cpu statistics during 1 second.

<a name="nodememstats"></a>

### nodememstats


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodememstats [cell]
    .ft P
.UNINDENT
.UNINDENT

Returns memory stats of the node.
If _cell_ is specified, this will print the specified cell statistics only.

<a name="nodesuspend"></a>

### nodesuspend


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodesuspend [target] [duration]
    .ft P
.UNINDENT
.UNINDENT

Puts the node (host machine) into a system-wide sleep state and schedule
the node's Real-Time-Clock interrupt to resume the node after the time
duration specified by _duration_ is out.
_target_ specifies the state to which the host will be suspended to, it
can be "mem" (suspend to RAM), "disk" (suspend to disk), or "hybrid"
(suspend to both RAM and disk).  _duration_ specifies the time duration
in seconds for which the host has to be suspended, it should be at least
60 seconds.

<a name="node"></a>

### node


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    node-memory-tune [shm-pages-to-scan] [shm-sleep-millisecs] [shm-merge-across-nodes]
    .ft P
.UNINDENT
.UNINDENT

Allows you to display or set the node memory parameters.
_shm-pages-to-scan_ can be used to set the number of pages to scan
before the shared memory service goes to sleep; _shm-sleep-millisecs_
can be used to set the number of millisecs the shared memory service should
sleep before next scan; _shm-merge-across-nodes_ specifies if pages from
different numa nodes can be merged. When set to 0, only pages which physically
reside in the memory area of same NUMA node can be merged. When set to 1,
pages from all nodes can be merged. Default to 1.

**Note**: Currently the "shared memory service" only means KSM (Kernel Samepage
Merging).

<a name="capabilities"></a>

### capabilities


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    capabilities
    .ft P
.UNINDENT
.UNINDENT

Print an XML document describing the capabilities of the hypervisor
we are currently connected to. This includes a section on the host
capabilities in terms of CPU and features, and a set of description
for each kind of guest which can be virtualized. For a more complete
description see:

_https://libvirt.org/formatcaps.html_

The XML also show the NUMA topology information if available.

<a name="domcapabilities"></a>

### domcapabilities


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domcapabilities [virttype] [emulatorbin] [arch] [machine]
    .ft P
.UNINDENT
.UNINDENT

Print an XML document describing the domain capabilities for the
hypervisor we are connected to using information either sourced from an
existing domain or taken from the **virsh capabilities** output. This may
be useful if you intend to create a new domain and are curious if for
instance it could make use of VFIO by creating a domain for the
hypervisor with a specific emulator and architecture.

Each hypervisor will have different requirements regarding which options
are required and which are optional. A hypervisor can support providing
a default value for any of the options.

The _virttype_ option specifies the virtualization type used. The value
to be used is either from the 'type' attribute of the &lt;domain/&gt; top
level element from the domain XML or the 'type' attribute found within
each &lt;guest/&gt; element from the **virsh capabilities** output.  The
_emulatorbin_ option specifies the path to the emulator. The value to
be used is either the &lt;emulator&gt; element in the domain XML or the
**virsh capabilities** output. The _arch_ option specifies the
architecture to be used for the domain. The value to be used is either
the "arch" attribute from the domain's XML &lt;os/&gt; element and &lt;type/&gt;
subelement or the "name" attribute of an &lt;arch/&gt; element from the
**virsh capabililites** output. The _machine_ specifies the machine type
for the emulator. The value to be used is either the "machine" attribute
from the domain's XML &lt;os/&gt; element and &lt;type/&gt; subelement or one from a
list of machines from the **virsh capabilities** output for a specific
architecture and domain type.

For the QEMU hypervisor, a _virttype_ of either 'qemu' or 'kvm' must be
supplied along with either the _emulatorbin_ or _arch_ in order to
generate output for the default _machine_.  Supplying a _machine_
value will generate output for the specific machine.

<a name="pool-capabilities"></a>

### pool\-capabilities


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-capabilities
    .ft P
.UNINDENT
.UNINDENT

Print an XML document describing the storage pool capabilities for the
connected storage driver. This may be useful if you intend to create a
new storage pool and need to know the available pool types and supported
storage pool source and target volume formats as well as the required
source elements to create the pool.

<a name="inject"></a>

### inject


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    inject-nmi domain
    .ft P
.UNINDENT
.UNINDENT

Inject NMI to the guest.

<a name="list"></a>

### list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    list [--inactive | --all]
         [--managed-save] [--title]
         { [--table] | --name | --uuid }
         [--persistent] [--transient]
         [--with-managed-save] [--without-managed-save]
         [--autostart] [--no-autostart]
         [--with-snapshot] [--without-snapshot]
         [--with-checkpoint] [--without-checkpoint]
         [--state-running] [--state-paused]
         [--state-shutoff] [--state-other]
    .ft P
.UNINDENT
.UNINDENT

Prints information about existing domains.  If no options are
specified it prints out information about running domains.

**Example 1:**

An example format for the list is as follows:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ``virsh`` list
      Id    Name                           State
    ----------------------------------------------------
      0     Domain-0                       running
      2     fedora                         paused
    .ft P
.UNINDENT
.UNINDENT

Name is the name of the domain.  ID the domain numeric id.
State is the run state (see below).

**STATES**

The State field lists what state each domain is currently in. A domain
can be in one of the following possible states:
.INDENT 0.0

* ·  
  **running**

The domain is currently running on a CPU

* ·  
  **idle**

The domain is idle, and not running or runnable.  This can be caused
because the domain is waiting on IO (a traditional wait state) or has
gone to sleep because there was nothing else for it to do.

* ·  
  **paused**

The domain has been paused, usually occurring through the administrator
running **virsh suspend**.  When in a paused state the domain will still
consume allocated resources like memory, but will not be eligible for
scheduling by the hypervisor.

* ·  
  **in shutdown**

The domain is in the process of shutting down, i.e. the guest operating system
has been notified and should be in the process of stopping its operations
gracefully.

* ·  
  **shut off**

The domain is not running.  Usually this indicates the domain has been
shut down completely, or has not been started.

* ·  
  **crashed**

The domain has crashed, which is always a violent ending.  Usually
this state can only occur if the domain has been configured not to
restart on crash.

* ·  
  **pmsuspended**

The domain has been suspended by guest power management, e.g. entered
into s3 state.
.UNINDENT

Normally only active domains are listed. To list inactive domains specify
_--inactive_ or _--all_ to list both active and inactive domains.

**Filtering**

To further filter the list of domains you may specify one or more of filtering
flags supported by the **list** command. These flags are grouped by function.
Specifying one or more flags from a group enables the filter group. Note that
some combinations of flags may yield no results. Supported filtering flags and
groups:

<a name="persistence"></a>

### Persistence


Flag _--persistent_ is used to include persistent domains in the returned
list. To include transient domains specify _--transient_.

<a name="existence-of-managed-save-image"></a>

### Existence of managed save image


To list domains having a managed save image specify flag
_--with-managed-save_. For domains that don't have a managed save image
specify _--without-managed-save_.

<a name="domain-state"></a>

### Domain state


The following filter flags select a domain by its state:
_--state-running_ for running domains, _--state-paused_  for paused domains,
_--state-shutoff_ for turned off domains and _--state-other_ for all
other states as a fallback.

<a name="autostarting-domains"></a>

### Autostarting domains


To list autostarting domains use the flag _--autostart_. To list domains with
this feature disabled use _--no-autostart_.

<a name="snapshot-existence"></a>

### Snapshot existence


Domains that have snapshot images can be listed using flag _--with-snapshot_,
domains without a snapshot _--without-snapshot_.

<a name="checkpoint-existence"></a>

### Checkpoint existence


Domains that have checkpoints can be listed using flag _--with-checkpoint_,
domains without a checkpoint _--without-checkpoint_.

When talking to older servers, this command is forced to use a series of API
calls with an inherent race, where a domain might not be listed or might appear
more than once if it changed state between calls while the list was being
collected.  Newer servers do not have this problem.

If _--managed-save_ is specified, then domains that have managed save state
(only possible if they are in the **shut off** state, so you need to specify
_--inactive_ or _--all_ to actually list them) will instead show as **saved**
in the listing. This flag is usable only with the default _--table_ output.
Note that this flag does not filter the list of domains.

If _--name_ is specified, domain names are printed instead of the table
formatted one per line. If _--uuid_ is specified domain's UUID's are printed
instead of names. Flag _--table_ specifies that the legacy table-formatted
output should be used. This is the default.

If both _--name_ and _--uuid_ are specified, domain UUID's and names
are printed side by side without any header. Flag _--table_ specifies
that the legacy table-formatted output should be used. This is the
default if neither _--name_ nor _--uuid_ are specified. Option
_--table_ is mutually exclusive with options _--uuid_ and _--name_.

If _--title_ is specified, then the short domain description (title) is
printed in an extra column. This flag is usable only with the default
_--table_ output.

**Example 2:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ virsh list --title
      Id    Name        State      Title
     -------------------------------------------
      0     Domain-0    running    Mailserver 1
      2     fedora      paused
    .ft P
.UNINDENT
.UNINDENT

<a name="freecell"></a>

### freecell


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    freecell [{ [--cellno] cellno | --all }]
    .ft P
.UNINDENT
.UNINDENT

Prints the available amount of memory on the machine or within a NUMA
cell.  The freecell command can provide one of three different
displays of available memory on the machine depending on the options
specified.  With no options, it displays the total free memory on the
machine.  With the --all option, it displays the free memory in each
cell and the total free memory on the machine.  Finally, with a
numeric argument or with --cellno plus a cell number it will display
the free memory for the specified cell only.

<a name="freepages"></a>

### freepages


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    freepages [{ [--cellno] cellno [--pagesize] pagesize |     --all }]
    .ft P
.UNINDENT
.UNINDENT

Prints the available amount of pages within a NUMA cell. _cellno_ refers
to the NUMA cell you're interested in. _pagesize_ is a scaled integer (see
**NOTES** above).  Alternatively, if _--all_ is used, info on each possible
combination of NUMA cell and page size is printed out.

<a name="allocpages"></a>

### allocpages


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    allocpages [--pagesize] pagesize [--pagecount] pagecount [[--cellno] cellno] [--add] [--all]
    .ft P
.UNINDENT
.UNINDENT

Change the size of pages pool of _pagesize_ on the host. If
_--add_ is specified, then _pagecount_ pages are added into the
pool. However, if _--add_ wasn't specified, then the
_pagecount_ is taken as the new absolute size of the pool (this
may be used to free some pages and size the pool down). The
_cellno_ modifier can be used to narrow the modification down to
a single host NUMA cell. On the other end of spectrum lies
_--all_ which executes the modification on all NUMA cells.

<a name="cpu-baseline"></a>

### cpu\-baseline


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    cpu-baseline FILE [--features] [--migratable]
    .ft P
.UNINDENT
.UNINDENT

Compute baseline CPU which will be supported by all host CPUs given in &lt;file&gt;.
(See **hypervisor-cpu-baseline** command to get a CPU which can be provided by a
specific hypervisor.) The list of host CPUs is built by extracting all &lt;cpu&gt;
elements from the &lt;file&gt;. Thus, the &lt;file&gt; can contain either a set of &lt;cpu&gt;
elements separated by new lines or even a set of complete &lt;capabilities&gt;
elements printed by **capabilities** command.  If _--features_ is specified,
then the resulting XML description will explicitly include all features that
make up the CPU, without this option features that are part of the CPU model
will not be listed in the XML description.   If _--migratable_ is specified,
features that block migration will not be included in the resulting CPU.

<a name="cpu-compare"></a>

### cpu\-compare


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    cpu-compare FILE [--error]
    .ft P
.UNINDENT
.UNINDENT

Compare CPU definition from XML &lt;file&gt; with host CPU. (See
**hypervisor-cpu-compare** command for comparing the CPU definition with the CPU
which a specific hypervisor is able to provide on the host.) The XML &lt;file&gt; may
contain either host or guest CPU definition. The host CPU definition is the
&lt;cpu&gt; element and its contents as printed by **capabilities** command. The
guest CPU definition is the &lt;cpu&gt; element and its contents from domain XML
definition or the CPU definition created from the host CPU model found in
domain capabilities XML (printed by **domcapabilities** command). In
addition to the &lt;cpu&gt; element itself, this command accepts
full domain XML, capabilities XML, or domain capabilities XML containing
the CPU definition. For more information on guest CPU definition see:
_https://libvirt.org/formatdomain.html#elementsCPU_. If _--error_ is
specified, the command will return an error when the given CPU is
incompatible with host CPU and a message providing more details about the
incompatibility will be printed out.

<a name="cpu-models"></a>

### cpu\-models


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    cpu-models arch
    .ft P
.UNINDENT
.UNINDENT

Print the list of CPU models known by libvirt for the specified architecture.
Whether a specific hypervisor is able to create a domain which uses any of
the printed CPU models is a separate question which can be answered by
looking at the domain capabilities XML returned by **domcapabilities** command.
Moreover, for some architectures libvirt does not know any CPU models and
the usable CPU models are only limited by the hypervisor. This command will
print that all CPU models are accepted for these architectures and the actual
list of supported CPU models can be checked in the domain capabilities XML.

<a name="echo"></a>

### echo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    echo [--shell] [--xml] [err...] [arg...]
    .ft P
.UNINDENT
.UNINDENT

Echo back each _arg_, separated by space.  If _--shell_ is
specified, then the output will be single-quoted where needed, so that
it is suitable for reuse in a shell context.  If _--xml_ is
specified, then the output will be escaped for use in XML.
If _--err_ is specified, prefix **"error: "** and output to stderr
instead of stdout.

<a name="hypervisor-cpu-compare"></a>

### hypervisor\-cpu\-compare


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    hypervisor-cpu-compare FILE [virttype] [emulator] [arch] [machine] [--error]
    .ft P
.UNINDENT
.UNINDENT

Compare CPU definition from XML &lt;file&gt; with the CPU the hypervisor is able to
provide on the host. (This is different from **cpu-compare** which compares the
CPU definition with the host CPU without considering any specific hypervisor
and its abilities.)

The XML _FILE_ may contain either a host or guest CPU definition. The host CPU
definition is the &lt;cpu&gt; element and its contents as printed by the
**capabilities** command. The guest CPU definition is the &lt;cpu&gt; element and its
contents from the domain XML definition or the CPU definition created from the
host CPU model found in the domain capabilities XML (printed by the
**domcapabilities** command). In addition to the &lt;cpu&gt; element itself, this
command accepts full domain XML, capabilities XML, or domain capabilities XML
containing the CPU definition. For more information on guest CPU definition
see: _https://libvirt.org/formatdomain.html#elementsCPU_.

The _virttype_ option specifies the virtualization type (usable in the 'type'
attribute of the &lt;domain&gt; top level element from the domain XML). _emulator_
specifies the path to the emulator, _arch_ specifies the CPU architecture, and
_machine_ specifies the machine type. If _--error_ is specified, the command
will return an error when the given CPU is incompatible with the host CPU and a
message providing more details about the incompatibility will be printed out.

<a name="hypervisor-cpu-baseline"></a>

### hypervisor\-cpu\-baseline


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    hypervisor-cpu-baseline FILE [virttype] [emulator] [arch] [machine] [--features] [--migratable]
    .ft P
.UNINDENT
.UNINDENT

Compute a baseline CPU which will be compatible with all CPUs defined in an XML
_file_ and with the CPU the hypervisor is able to provide on the host. (This
is different from **cpu-baseline** which does not consider any hypervisor
abilities when computing the baseline CPU.)

The XML _FILE_ may contain either host or guest CPU definitions describing the
host CPU model. The host CPU definition is the &lt;cpu&gt; element and its contents
as printed by **capabilities** command. The guest CPU definition may be created
from the host CPU model found in domain capabilities XML (printed by
**domcapabilities** command). In addition to the &lt;cpu&gt; elements, this command
accepts full capabilities XMLs, or domain capabilities XMLs containing the CPU
definitions. For best results, use only the CPU definitions from domain
capabilities.

When _FILE_ contains only a single CPU definition, the command will print the
same CPU with restrictions imposed by the capabilities of the hypervisor.
Specifically, running th **virsh hypervisor-cpu-baseline** command with no
additional options on the result of **virsh domcapabilities** will transform the
host CPU model from domain capabilities XML to a form directly usable in domain
XML.

The _virttype_ option specifies the virtualization type (usable in the 'type'
attribute of the &lt;domain&gt; top level element from the domain XML). _emulator_
specifies the path to the emulator, _arch_ specifies the CPU architecture, and
_machine_ specifies the machine type. If _--features_ is specified, then the
resulting XML description will explicitly include all features that make up the
CPU, without this option features that are part of the CPU model will not be
listed in the XML description. If _--migratable_ is specified, features that
block migration will not be included in the resulting CPU.

<a name="domain-commands"></a>

# Domain Commands


The following commands manipulate domains directly, as stated
previously most commands take domain as the first parameter. The
_domain_ can be specified as a short integer, a name or a full UUID.

<a name="autostart"></a>

### autostart


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    autostart [--disable] domain
    .ft P
.UNINDENT
.UNINDENT

Configure a domain to be automatically started at boot.

The option _--disable_ disables autostarting.

<a name="blkdeviotune"></a>

### blkdeviotune


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    blkdeviotune domain device [[--config] [--live] | [--current]]
       [[total-bytes-sec] | [read-bytes-sec] [write-bytes-sec]]
       [[total-iops-sec] | [read-iops-sec] [write-iops-sec]]
       [[total-bytes-sec-max] | [read-bytes-sec-max] [write-bytes-sec-max]]
       [[total-iops-sec-max] | [read-iops-sec-max] [write-iops-sec-max]]
       [[total-bytes-sec-max-length] |
        [read-bytes-sec-max-length] [write-bytes-sec-max-length]]
       [[total-iops-sec-max-length] |
        [read-iops-sec-max-length] [write-iops-sec-max-length]]
       [size-iops-sec] [group-name]
    .ft P
.UNINDENT
.UNINDENT

Set or query the block disk io parameters for a block device of _domain_.
_device_ specifies a unique target name (&lt;target dev='name'/&gt;) or source
file (&lt;source file='name'/&gt;) for one of the disk devices attached to
_domain_ (see also **domblklist** for listing these names).

If no limit is specified, it will query current I/O limits setting.
Otherwise, alter the limits with these flags:
_--total-bytes-sec_ specifies total throughput limit as a scaled integer, the
default being bytes per second if no suffix is specified.
_--read-bytes-sec_ specifies read throughput limit as a scaled integer, the
default being bytes per second if no suffix is specified.
_--write-bytes-sec_ specifies write throughput limit as a scaled integer, the
default being bytes per second if no suffix is specified.
_--total-iops-sec_ specifies total I/O operations limit per second.
_--read-iops-sec_ specifies read I/O operations limit per second.
_--write-iops-sec_ specifies write I/O operations limit per second.
_--total-bytes-sec-max_ specifies maximum total throughput limit as a scaled
integer, the default being bytes per second if no suffix is specified
_--read-bytes-sec-max_ specifies maximum read throughput limit as a scaled
integer, the default being bytes per second if no suffix is specified.
_--write-bytes-sec-max_ specifies maximum write throughput limit as a scaled
integer, the default being bytes per second if no suffix is specified.
_--total-iops-sec-max_ specifies maximum total I/O operations limit per second.
_--read-iops-sec-max_ specifies maximum read I/O operations limit per second.
_--write-iops-sec-max_ specifies maximum write I/O operations limit per second.
_--total-bytes-sec-max-length_ specifies duration in seconds to allow maximum
total throughput limit.
_--read-bytes-sec-max-length_ specifies duration in seconds to allow maximum
read throughput limit.
_--write-bytes-sec-max-length_ specifies duration in seconds to allow maximum
write throughput limit.
_--total-iops-sec-max-length_ specifies duration in seconds to allow maximum
total I/O operations limit.
_--read-iops-sec-max-length_ specifies duration in seconds to allow maximum
read I/O operations limit.
_--write-iops-sec-max-length_ specifies duration in seconds to allow maximum
write I/O operations limit.
_--size-iops-sec_ specifies size I/O operations limit per second.
_--group-name_ specifies group name to share I/O quota between multiple drives.
For a QEMU domain, if no name is provided, then the default is to have a single
group for each _device_.

Older versions of virsh only accepted these options with underscore
instead of dash, as in _--total\_bytes\_sec_.

Bytes and iops values are independent, but setting only one value (such
as --read-bytes-sec) resets the other two in that category to unlimited.
An explicit 0 also clears any limit.  A non-zero value for a given total
cannot be mixed with non-zero values for read or write.

It is up to the hypervisor to determine how to handle the length values.
For the QEMU hypervisor, if an I/O limit value or maximum value is set,
then the default value of 1 second will be displayed. Supplying a 0 will
reset the value back to the default.

If _--live_ is specified, affect a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
When setting the disk io parameters both _--live_ and _--config_ flags may be
given, but _--current_ is exclusive. For querying only one of _--live_,
_--config_ or _--current_ can be specified. If no flag is specified, behavior
is different depending on hypervisor.

<a name="blkiotune"></a>

### blkiotune


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    blkiotune domain [--weight weight] [--device-weights device-weights]
       [--device-read-iops-sec device-read-iops-sec]
       [--device-write-iops-sec device-write-iops-sec]
       [--device-read-bytes-sec device-read-bytes-sec]
       [--device-write-bytes-sec device-write-bytes-sec]
       [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Display or set the blkio parameters. QEMU/KVM supports _--weight_.
_--weight_ is in range [100, 1000]. After kernel 2.6.39, the value
could be in the range [10, 1000].

**device-weights** is a single string listing one or more device/weight
pairs, in the format of /path/to/device,weight,/path/to/device,weight.
Each weight is in the range [100, 1000], [10, 1000] after kernel 2.6.39,
or the value 0 to remove that device from per-device listings.
Only the devices listed in the string are modified;
any existing per-device weights for other devices remain unchanged.

**device-read-iops-sec** is a single string listing one or more device/read_iops_sec
pairs, int the format of /path/to/device,read_iops_sec,/path/to/device,read_iops_sec.
Each read_iops_sec is a number which type is unsigned int, value 0 to remove that
device from per-device listing.
Only the devices listed in the string are modified;
any existing per-device read_iops_sec for other devices remain unchanged.

**device-write-iops-sec** is a single string listing one or more device/write_iops_sec
pairs, int the format of /path/to/device,write_iops_sec,/path/to/device,write_iops_sec.
Each write_iops_sec is a number which type is unsigned int, value 0 to remove that
device from per-device listing.
Only the devices listed in the string are modified;
any existing per-device write_iops_sec for other devices remain unchanged.

**device-read-bytes-sec** is a single string listing one or more device/read_bytes_sec
pairs, int the format of /path/to/device,read_bytes_sec,/path/to/device,read_bytes_sec.
Each read_bytes_sec is a number which type is unsigned long long, value 0 to remove
that device from per-device listing.
Only the devices listed in the string are modified;
any existing per-device read_bytes_sec for other devices remain unchanged.

**device-write-bytes-sec** is a single string listing one or more device/write_bytes_sec
pairs, int the format of /path/to/device,write_bytes_sec,/path/to/device,write_bytes_sec.
Each write_bytes_sec is a number which type is unsigned long long, value 0 to remove
that device from per-device listing.
Only the devices listed in the string are modified;
any existing per-device write_bytes_sec for other devices remain unchanged.

If _--live_ is specified, affect a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. If no flag is specified, behavior is different depending
on hypervisor.

<a name="blockcommit"></a>

### blockcommit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    blockcommit domain path [bandwidth] [--bytes] [base]
       [--shallow] [top] [--delete] [--keep-relative]
       [--wait [--async] [--verbose]] [--timeout seconds]
       [--active] [{--pivot | --keep-overlay}]
    .ft P
.UNINDENT
.UNINDENT

Reduce the length of a backing image chain, by committing changes at the
top of the chain (snapshot or delta files) into backing images.  By
default, this command attempts to flatten the entire chain.  If _base_
and/or _top_ are specified as files within the backing chain, then the
operation is constrained to committing just that portion of the chain;
_--shallow_ can be used instead of _base_ to specify the immediate
backing file of the resulting top image to be committed.  The files
being committed are rendered invalid, possibly as soon as the operation
starts; using the _--delete_ flag will attempt to remove these invalidated
files at the successful completion of the commit operation. When the
_--keep-relative_ flag is used, the backing file paths will be kept relative.

When _top_ is omitted or specified as the active image, it is also
possible to specify _--active_ to trigger a two-phase active commit. In
the first phase, _top_ is copied into _base_ and the job can only be
canceled, with top still containing data not yet in base. In the second
phase, _top_ and _base_ remain identical until a call to **blockjob**
with the _--abort_ flag (keeping top as the active image that tracks
changes from that point in time) or the _--pivot_ flag (making base
the new active image and invalidating top).

By default, this command returns as soon as possible, and data for
the entire disk is committed in the background; the progress of the
operation can be checked with **blockjob**.  However, if _--wait_ is
specified, then this command will block until the operation completes
(or for _--active_, enters the second phase), or until the operation
is canceled because the optional _timeout_ in seconds elapses
or SIGINT is sent (usually with **Ctrl-C**).  Using _--verbose_ along
with _--wait_ will produce periodic status updates.  If job cancellation
is triggered, _--async_ will return control to the user as fast as
possible, otherwise the command may continue to block a little while
longer until the job is done cleaning up.  Using _--pivot_ is shorthand
for combining _--active_ _--wait_ with an automatic **blockjob**
_--pivot_; and using _--keep-overlay_ is shorthand for combining
_--active_ _--wait_ with an automatic **blockjob** _--abort_.

_path_ specifies fully-qualified path of the disk; it corresponds
to a unique target name (&lt;target dev='name'/&gt;) or source file (&lt;source
file='name'/&gt;) for one of the disk devices attached to _domain_ (see
also **domblklist** for listing these names).
_bandwidth_ specifies copying bandwidth limit in MiB/s, although for
QEMU, it may be non-zero only for an online domain. For further information
on the _bandwidth_ argument see the corresponding section for the **blockjob**
command.

<a name="blockcopy"></a>

### blockcopy


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    blockcopy domain path { dest [format] [--blockdev] | --xml file }
       [--shallow] [--reuse-external] [bandwidth]
       [--wait [--async] [--verbose]] [{--pivot | --finish}]
       [--timeout seconds] [granularity] [buf-size] [--bytes]
       [--transient-job]
    .ft P
.UNINDENT
.UNINDENT

Copy a disk backing image chain to a destination.  Either _dest_ as
the destination file name, or _--xml_ with the name of an XML file containing
a top-level &lt;disk&gt; element describing the destination, must be present.
Additionally, if _dest_ is given, _format_ should be specified to declare
the format of the destination (if _format_ is omitted, then libvirt
will reuse the format of the source, or with _--reuse-external_ will
be forced to probe the destination format, which could be a potential
security hole).  The command supports _--raw_ as a boolean flag synonym for
_--format=raw_.  When using _dest_, the destination is treated as a regular
file unless _--blockdev_ is used to signal that it is a block device. By
default, this command flattens the entire chain; but if _--shallow_ is
specified, the copy shares the backing chain.

If _--reuse-external_ is specified, then the destination must exist and have
sufficient space to hold the copy. If _--shallow_ is used in
conjunction with _--reuse-external_ then the pre-created image must have
guest visible contents identical to guest visible contents of the backing
file of the original image. This may be used to modify the backing file
names on the destination.

By default, the copy job runs in the background, and consists of two
phases.  Initially, the job must copy all data from the source, and
during this phase, the job can only be canceled to revert back to the
source disk, with no guarantees about the destination.  After this phase
completes, both the source and the destination remain mirrored until a
call to **blockjob** with the _--abort_ and _--pivot_ flags pivots over
to the copy, or a call without _--pivot_ leaves the destination as a
faithful copy of that point in time.  However, if _--wait_ is specified,
then this command will block until the mirroring phase begins, or cancel
the operation if the optional _timeout_ in seconds elapses or SIGINT is
sent (usually with **Ctrl-C**).  Using _--verbose_ along with _--wait_
will produce periodic status updates.  Using _--pivot_ (similar to
**blockjob** _--pivot_) or _--finish_ (similar to **blockjob** _--abort_)
implies _--wait_, and will additionally end the job cleanly rather than
leaving things in the mirroring phase.  If job cancellation is triggered
by timeout or by _--finish_, _--async_ will return control to the user
as fast as possible, otherwise the command may continue to block a little
while longer until the job has actually cancelled.

_path_ specifies fully-qualified path of the disk.
_bandwidth_ specifies copying bandwidth limit in MiB/s. Specifying a negative
value is interpreted as an unsigned long long value that might be essentially
unlimited, but more likely would overflow; it is safer to use 0 for that
purpose. For further information on the _bandwidth_ argument see the
corresponding section for the **blockjob** command.
Specifying _granularity_ allows fine-tuning of the granularity that will be
copied when a dirty region is detected; larger values trigger less
I/O overhead but may end up copying more data overall (the default value is
usually correct); hypervisors may restrict this to be a power of two or fall
within a certain range. Specifying _buf-size_ will control how much data can
be simultaneously in-flight during the copy; larger values use more memory but
may allow faster completion (the default value is usually correct).

_--transient-job_ allows specifying that the user does not require the job to
be recovered if the VM crashes or is turned off before the job completes. This
flag removes the restriction of copy jobs to transient domains if that
restriction is applied by the hypervisor.

<a name="blockjob"></a>

### blockjob


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    blockjob domain path { [--abort] [--async] [--pivot] |
       [--info] [--raw] [--bytes] | [bandwidth] }
    .ft P
.UNINDENT
.UNINDENT

Manage active block operations.  There are three mutually-exclusive modes:
_--info_, _bandwidth_, and _--abort_.  _--async_ and _--pivot_ imply
abort mode; _--raw_ implies info mode; and if no mode was given, _--info_
mode is assumed.

_path_ specifies fully-qualified path of the disk; it corresponds
to a unique target name (&lt;target dev='name'/&gt;) or source file (&lt;source
file='name'/&gt;) for one of the disk devices attached to _domain_ (see
also **domblklist** for listing these names).

In _--abort_ mode, the active job on the specified disk will
be aborted.  If _--async_ is also specified, this command will return
immediately, rather than waiting for the cancellation to complete.  If
_--pivot_ is specified, this requests that an active copy or active
commit job be pivoted over to the new image.

In _--info_ mode, the active job information on the specified
disk will be printed.  By default, the output is a single human-readable
summary line; this format may change in future versions.  Adding
_--raw_ lists each field of the struct, in a stable format.  If the
_--bytes_ flag is set, then the command errors out if the server could
not supply bytes/s resolution; when omitting the flag, raw output is
listed in MiB/s and human-readable output automatically selects the
best resolution supported by the server.

_bandwidth_ can be used to set bandwidth limit for the active job in MiB/s.
If _--bytes_ is specified then the bandwidth value is interpreted in
bytes/s. Specifying a negative value is interpreted as an unsigned long
value or essentially unlimited. The hypervisor can choose whether to
reject the value or convert it to the maximum value allowed. Optionally a
scaled positive number may be used as bandwidth (see **NOTES** above). Using
_--bytes_ with a scaled value permits a finer granularity to be selected.
A scaled value used without _--bytes_ will be rounded down to MiB/s. Note
that the _--bytes_ may be unsupported by the hypervisor.

Note that the progress reported for blockjobs corresponding to a pull-mode
backup don't report progress of the backup but rather usage of temporary
space required for the backup.

<a name="blockpull"></a>

### blockpull


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    blockpull domain path [bandwidth] [--bytes] [base]
       [--wait [--verbose] [--timeout seconds] [--async]]
       [--keep-relative]
    .ft P
.UNINDENT
.UNINDENT

Populate a disk from its backing image chain. By default, this command
flattens the entire chain; but if _base_ is specified, containing the
name of one of the backing files in the chain, then that file becomes
the new backing file and only the intermediate portion of the chain is
pulled.  Once all requested data from the backing image chain has been
pulled, the disk no longer depends on that portion of the backing chain.

By default, this command returns as soon as possible, and data for
the entire disk is pulled in the background; the progress of the
operation can be checked with **blockjob**.  However, if _--wait_ is
specified, then this command will block until the operation completes,
or cancel the operation if the optional _timeout_ in seconds elapses
or SIGINT is sent (usually with **Ctrl-C**).  Using _--verbose_ along
with _--wait_ will produce periodic status updates.  If job cancellation
is triggered, _--async_ will return control to the user as fast as
possible, otherwise the command may continue to block a little while
longer until the job is done cleaning up.

Using the _--keep-relative_ flag will keep the backing chain names
relative.

_path_ specifies fully-qualified path of the disk; it corresponds
to a unique target name (&lt;target dev='name'/&gt;) or source file (&lt;source
file='name'/&gt;) for one of the disk devices attached to _domain_ (see
also **domblklist** for listing these names).
_bandwidth_ specifies copying bandwidth limit in MiB/s. For further information
on the _bandwidth_ argument see the corresponding section for the **blockjob**
command.

<a name="blockresize"></a>

### blockresize


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    blockresize domain path size
    .ft P
.UNINDENT
.UNINDENT

Resize a block device of domain while the domain is running, _path_
specifies the absolute path of the block device; it corresponds
to a unique target name (&lt;target dev='name'/&gt;) or source file (&lt;source
file='name'/&gt;) for one of the disk devices attached to _domain_ (see
also **domblklist** for listing these names).

_size_ is a scaled integer (see **NOTES** above) which defaults to KiB
(blocks of 1024 bytes) if there is no suffix.  You must use a suffix of
"B" to get bytes (note that for historical reasons, this differs from
**vol-resize** which defaults to bytes without a suffix).

<a name="console"></a>

### console


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    console domain [devname] [--safe] [--force]
    .ft P
.UNINDENT
.UNINDENT

Connect the virtual serial console for the guest. The optional
_devname_ parameter refers to the device alias of an alternate
console, serial or parallel device configured for the guest.
If omitted, the primary console will be opened.

If the flag _--safe_ is specified, the connection is only attempted
if the driver supports safe console handling. This flag specifies that
the server has to ensure exclusive access to console devices. Optionally
the _--force_ flag may be specified, requesting to disconnect any existing
sessions, such as in a case of a broken connection.

<a name="cpu-stats"></a>

### cpu\-stats


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    cpu-stats domain [--total] [start] [count]
    .ft P
.UNINDENT
.UNINDENT

Provide cpu statistics information of a domain. The domain should
be running. Default it shows stats for all CPUs, and a total. Use
_--total_ for only the total stats, _start_ for only the per-cpu
stats of the CPUs from _start_, _count_ for only _count_ CPUs'
stats.

<a name="create"></a>

### create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    create FILE [--console] [--paused] [--autodestroy]
       [--pass-fds N,M,...] [--validate]
    .ft P
.UNINDENT
.UNINDENT

Create a domain from an XML &lt;file&gt;. Optionally, _--validate_ option can be
passed to validate the format of the input XML file against an internal RNG
schema (identical to using virt-xml-validate(1) tool). Domains created using
this command are going to be either transient (temporary ones that will vanish
once destroyed) or existing persistent domains that will run with one-time use
configuration, leaving the persistent XML untouched (this can come handy during
an automated testing of various configurations all based on the original XML).
See the example below for usage demonstration.

The domain will be paused if the _--paused_ option is used
and supported by the driver; otherwise it will be running. If _--console_ is
requested, attach to the console after creation.
If _--autodestroy_ is requested, then the guest will be automatically
destroyed when virsh closes its connection to libvirt, or otherwise
exits.

If _--pass-fds_ is specified, the argument is a comma separated list
of open file descriptors which should be pass on into the guest. The
file descriptors will be re-numbered in the guest, starting from 3. This
is only supported with container based virtualization.

**Example:**
.INDENT 0.0

* 1.  
  prepare a template from an existing domain (skip directly to 3a if writing
  one from scratch)
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    # virsh dumpxml <domain> > domain.xml
    .ft P
.UNINDENT
.UNINDENT

* 2.  
  edit the template using an editor of your choice and:
  .INDENT 3.0
* a.  
  DO CHANGE! &lt;name&gt; and &lt;uuid&gt; (&lt;uuid&gt; can also be removed), or
* b.  
  DON'T CHANGE! either &lt;name&gt; or &lt;uuid&gt;
  .UNINDENT
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    # $EDITOR domain.xml
    .ft P
.UNINDENT
.UNINDENT

* 3.  
  create a domain from domain.xml, depending on whether following 2a or 2b
  respectively:
  .INDENT 3.0
* a.  
  the domain is going to be transient
* b.  
  an existing persistent domain will run with a modified one-time
  configuration
  .UNINDENT
  .INDENT 3.0
  .INDENT 3.5

    .ft C
    # virsh create domain.xml
    .ft P
.UNINDENT
.UNINDENT
.UNINDENT

<a name="define"></a>

### define


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    define FILE [--validate]
    .ft P
.UNINDENT
.UNINDENT

Define a domain from an XML &lt;file&gt;. Optionally, the format of the input XML
file can be validated against an internal RNG schema with _--validate_
(identical to using virt-xml-validate(1) tool). The domain definition is
registered but not started.  If domain is already running, the changes will take
effect on the next boot.

<a name="desc"></a>

### desc


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    desc domain [[--live] [--config] |
       [--current]] [--title] [--edit] [--new-desc
       New description or title message]
    .ft P
.UNINDENT
.UNINDENT

Show or modify description and title of a domain. These values are user
fields that allow storing arbitrary textual data to allow easy
identification of domains. Title should be short, although it's not enforced.
(See also **metadata** that works with XML based domain metadata.)

Flags _--live_ or _--config_ select whether this command works on live
or persistent definitions of the domain. If both _--live_ and _--config_
are specified, the _--config_ option takes precedence on getting the current
description and both live configuration and config are updated while setting
the description. _--current_ is exclusive and implied if none of these was
specified.

Flag _--edit_ specifies that an editor with the contents of current
description or title should be opened and the contents saved back afterwards.

Flag _--title_ selects operation on the title field instead of description.

If neither of _--edit_ and _--new-desc_ are specified the note or description
is displayed instead of being modified.

<a name="destroy"></a>

### destroy


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    destroy domain [--graceful]
    .ft P
.UNINDENT
.UNINDENT

Immediately terminate the domain _domain_.  This doesn't give the domain
OS any chance to react, and it's the equivalent of ripping the power
cord out on a physical machine.  In most cases you will want to use
the **shutdown** command instead.  However, this does not delete any
storage volumes used by the guest, and if the domain is persistent, it
can be restarted later.

If _domain_ is transient, then the metadata of any snapshots will
be lost once the guest stops running, but the snapshot contents still
exist, and a new domain with the same name and UUID can restore the
snapshot metadata with **snapshot-create**.  Similarly, the metadata of
any checkpoints will be lost, but can be restored with **checkpoint-create**.

If _--graceful_ is specified, don't resort to extreme measures
(e.g. SIGKILL) when the guest doesn't stop after a reasonable timeout;
return an error instead.

<a name="domblkerror"></a>

### domblkerror


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domblkerror domain
    .ft P
.UNINDENT
.UNINDENT

Show errors on block devices.  This command usually comes handy when
**domstate** command says that a domain was paused due to I/O error.
The **domblkerror** command lists all block devices in error state and
the error seen on each of them.

<a name="domblkinfo"></a>

### domblkinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domblkinfo domain [block-device --all] [--human]
    .ft P
.UNINDENT
.UNINDENT

Get block device size info for a domain.  A _block-device_ corresponds
to a unique target name (&lt;target dev='name'/&gt;) or source file (&lt;source
file='name'/&gt;) for one of the disk devices attached to _domain_ (see
also **domblklist** for listing these names). If _--human_ is set, the
output will have a human readable output.
If _--all_ is set, the output will be a table showing all block devices
size info associated with _domain_.
The _--all_ option takes precedence of the others.

<a name="domblklist"></a>

### domblklist


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domblklist domain [--inactive] [--details]
    .ft P
.UNINDENT
.UNINDENT

Print a table showing the brief information of all block devices
associated with _domain_. If _--inactive_ is specified, query the
block devices that will be used on the next boot, rather than those
currently in use by a running domain. If _--details_ is specified,
disk type and device value will also be printed. Other contexts
that require a block device name (such as _domblkinfo_ or
_snapshot-create_ for disk snapshots) will accept either target
or unique source names printed by this command.

<a name="domblkstat"></a>

### domblkstat


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domblkstat domain [block-device] [--human]
    .ft P
.UNINDENT
.UNINDENT

Get device block stats for a running domain.  A _block-device_ corresponds
to a unique target name (&lt;target dev='name'/&gt;) or source file (&lt;source
file='name'/&gt;) for one of the disk devices attached to _domain_ (see
also **domblklist** for listing these names). On a LXC or QEMU domain,
omitting the _block-device_ yields device block stats summarily for the
entire domain.

Use _--human_ for a more human readable output.

Availability of these fields depends on hypervisor. Unsupported fields are
missing from the output. Other fields may appear if communicating with a newer
version of libvirtd.

Explanation of fields (fields appear in the following order):
.INDENT 0.0

* ·  
  rd_req            - count of read operations
* ·  
  rd_bytes          - count of read bytes
* ·  
  wr_req            - count of write operations
* ·  
  wr_bytes          - count of written bytes
* ·  
  errs              - error count
* ·  
  flush_operations  - count of flush operations
* ·  
  rd_total_times    - total time read operations took (ns)
* ·  
  wr_total_times    - total time write operations took (ns)
* ·  
  flush_total_times - total time flush operations took (ns)
* ·  
  &lt;-- other fields provided by hypervisor --&gt;
  .UNINDENT

<a name="domblkthreshold"></a>

### domblkthreshold


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domblkthreshold domain dev threshold
    .ft P
.UNINDENT
.UNINDENT

Set the threshold value for delivering the block-threshold event. _dev_
specifies the disk device target or backing chain element of given device using
the 'target[1]' syntax. _threshold_ is a scaled value of the offset. If the
block device should write beyond that offset the event will be delivered.

<a name="domcontrol"></a>

### domcontrol


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domcontrol domain
    .ft P
.UNINDENT
.UNINDENT

Returns state of an interface to VMM used to control a domain.  For
states other than "ok" or "error" the command also prints number of
seconds elapsed since the control interface entered its current state.

<a name="domdisplay"></a>

### domdisplay


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domdisplay domain [--include-password] [[--type] type] [--all]
    .ft P
.UNINDENT
.UNINDENT

Output a URI which can be used to connect to the graphical display of the
domain via VNC, SPICE or RDP.  The particular graphical display type can
be selected using the **type** parameter (e.g. "vnc", "spice", "rdp").  If
_--include-password_ is specified, the SPICE channel password will be
included in the URI. If _--all_ is specified, then all show all possible
graphical displays, for a VM could have more than one graphical displays.

<a name="domfsfreeze"></a>

### domfsfreeze


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domfsfreeze domain [[--mountpoint] mountpoint...]
    .ft P
.UNINDENT
.UNINDENT

Freeze mounted filesystems within a running domain to prepare for consistent
snapshots.

The _--mountpoint_ option takes a parameter **mountpoint**, which is a
mount point path of the filesystem to be frozen. This option can occur
multiple times. If this is not specified, every mounted filesystem is frozen.

Note: **snapshot-create** command has a _--quiesce_ option to freeze
and thaw the filesystems automatically to keep snapshots consistent.
**domfsfreeze** command is only needed when a user wants to utilize the
native snapshot features of storage devices not supported by libvirt.

<a name="domfsinfo"></a>

### domfsinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domfsinfo domain
    .ft P
.UNINDENT
.UNINDENT

Show a list of mounted filesystems within the running domain. The list contains
mountpoints, names of a mounted device in the guest, filesystem types, and
unique target names used in the domain XML (&lt;target dev='name'/&gt;).

Note that this command requires a guest agent configured and running in the
domain's guest OS.

<a name="domfsthaw"></a>

### domfsthaw


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domfsthaw domain [[--mountpoint] mountpoint...]
    .ft P
.UNINDENT
.UNINDENT

Thaw mounted filesystems within a running domain, which have been frozen by
domfsfreeze command.

The _--mountpoint_ option takes a parameter **mountpoint**, which is a
mount point path of the filesystem to be thawed. This option can occur
multiple times. If this is not specified, every mounted filesystem is thawed.

<a name="domfstrim"></a>

### domfstrim


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domfstrim domain [--minimum bytes] [--mountpoint mountPoint]
    .ft P
.UNINDENT
.UNINDENT

Issue a fstrim command on all mounted filesystems within a running
domain. It discards blocks which are not in use by the filesystem.
If _--minimum_ **bytes** is specified, it tells guest kernel length
of contiguous free range. Smaller than this may be ignored (this is
a hint and the guest may not respect it). By increasing this value,
the fstrim operation will complete more quickly for filesystems
with badly fragmented free space, although not all blocks will
be discarded.  The default value is zero, meaning "discard
every free block". Moreover, if a user wants to trim only one mount
point, it can be specified via optional _--mountpoint_ parameter.

<a name="domhostname"></a>

### domhostname


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domhostname domain [--source lease|agent]
    .ft P
.UNINDENT
.UNINDENT

Returns the hostname of a domain, if the hypervisor makes it available.

The _--source_ argument specifies what data source to use for the
hostnames, currently 'lease' to read DHCP leases or 'agent' to query
the guest OS via an agent. If unspecified, driver returns the default
method available (some drivers support only one type of source).

<a name="domid"></a>

### domid


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domid domain-name-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Convert a domain name (or UUID) to a domain id

<a name="domif-getlink"></a>

### domif\-getlink


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domif-getlink domain interface-device [--config]
    .ft P
.UNINDENT
.UNINDENT

Query link state of the domain's virtual interface. If _--config_
is specified, query the persistent configuration, for compatibility
purposes, _--persistent_ is alias of _--config_.

_interface-device_ can be the interface's target name or the MAC address.

<a name="domif-setlink"></a>

### domif\-setlink


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domif-setlink domain interface-device state [--config]
    .ft P
.UNINDENT
.UNINDENT

Modify link state of the domain's virtual interface. Possible values for
state are "up" and "down". If _--config_ is specified, only the persistent
configuration of the domain is modified, for compatibility purposes,
_--persistent_ is alias of _--config_.
_interface-device_ can be the interface's target name or the MAC address.

<a name="domifaddr"></a>

### domifaddr


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domifaddr domain [interface] [--full]
       [--source lease|agent|arp]
    .ft P
.UNINDENT
.UNINDENT

Get a list of interfaces of a running domain along with their IP and MAC
addresses, or limited output just for one interface if _interface_ is
specified. Note that _interface_ can be driver dependent, it can be the name
within guest OS or the name you would see in domain XML. Moreover, the whole
command may require a guest agent to be configured for the queried domain under
some hypervisors, notably QEMU.

If _--full_ is specified, the interface name and MAC address is always
displayed when the interface has multiple IP addresses or aliases; otherwise,
only the interface name and MAC address is displayed for the first name and
MAC address with "-" for the others using the same name and MAC address.

The _--source_ argument specifies what data source to use for the
addresses, currently 'lease' to read DHCP leases, 'agent' to query
the guest OS via an agent, or 'arp' to get IP from host's arp tables.
If unspecified, 'lease' is the default.

<a name="backup-begin"></a>

### backup\-begin


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    backup-begin domain [backupxml] [checkpointxml] [--reuse-external]
    .ft P
.UNINDENT
.UNINDENT

Begin a new backup job. If _backupxml_ is omitted, this defaults to a full
backup using a push model to filenames generated by libvirt; supplying XML
allows fine-tuning such as requesting an incremental backup relative to an
earlier checkpoint, controlling which disks participate or which
filenames are involved, or requesting the use of a pull model backup.
The _backup-dumpxml_ command shows any resulting values assigned by
libvirt. For more information on backup XML, see:
_https://libvirt.org/formatbackup.html_

If _--reuse-external_ is used it instructs libvirt to reuse temporary
and output files provided by the user in _backupxml_.

If _checkpointxml_ is specified, a second file with a top-level
element of _domaincheckpoint_ is used to create a simultaneous
checkpoint, for doing a later incremental backup relative to the time
the backup was created. See _checkpoint-create_ for more details on
checkpoints.

This command returns as soon as possible, and the backup job runs in
the background; the progress of a push model backup can be checked
with _domjobinfo_ or by waiting for an event with _event_ (the
progress of a pull model backup is under the control of whatever third
party connects to the NBD export). The job is ended with _domjobabort_.

<a name="backup-dumpxml"></a>

### backup\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    backup-dumpxml domain
    .ft P
.UNINDENT
.UNINDENT

Output XML describing the current backup job.

<a name="domiflist"></a>

### domiflist


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domiflist domain [--inactive]
    .ft P
.UNINDENT
.UNINDENT

Print a table showing the brief information of all virtual interfaces
associated with _domain_. If _--inactive_ is specified, query the
virtual interfaces that will be used on the next boot, rather than those
currently in use by a running domain. Other contexts that require a MAC
address of virtual interface (such as _detach-interface_ or
_domif-setlink_) will accept the MAC address printed by this command.

<a name="domifstat"></a>

### domifstat


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domifstat domain interface-device
    .ft P
.UNINDENT
.UNINDENT

Get network interface stats for a running domain. The network
interface stats are only available for interfaces that have a
physical source interface. This does not include, for example, a
'user' interface type since it is a virtual LAN with NAT to the
outside world. _interface-device_ can be the interface target by
name or MAC address.

<a name="domiftune"></a>

### domiftune


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domiftune domain interface-device [[--config] [--live] | [--current]]
       [*--inbound average,peak,burst,floor*]
       [*--outbound average,peak,burst*]
    .ft P
.UNINDENT
.UNINDENT

Set or query the domain's network interface's bandwidth parameters.
_interface-device_ can be the interface's target name (&lt;target dev='name'/&gt;),
or the MAC address.

If no _--inbound_ or _--outbound_ is specified, this command will
query and show the bandwidth settings. Otherwise, it will set the
inbound or outbound bandwidth. _average,peak,burst,floor_ is the same as
in command _attach-interface_.  Values for _average_, _peak_ and _floor_
are expressed in kilobytes per second, while _burst_ is expressed in kilobytes
in a single burst at _peak_ speed as described in the Network XML
documentation at _https://libvirt.org/formatnetwork.html#elementQoS_.

To clear inbound or outbound settings, use _--inbound_ or _--outbound_
respectfully with average value of zero.

If _--live_ is specified, affect a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. If no flag is specified, behavior is different depending
on hypervisor.

<a name="dominfo"></a>

### dominfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    dominfo domain
    .ft P
.UNINDENT
.UNINDENT

Returns basic information about the domain.

<a name="domjobabort"></a>

### domjobabort


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domjobabort domain
    .ft P
.UNINDENT
.UNINDENT

Abort the currently running domain job.

<a name="domjobinfo"></a>

### domjobinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domjobinfo domain [--completed [--keep-completed]] [--anystats] [--rawstats]
    .ft P
.UNINDENT
.UNINDENT

Returns information about jobs running on a domain. _--completed_ tells
virsh to return information about a recently finished job. Statistics of
a completed job are automatically destroyed once read (unless
_--keep-completed_ is used) or when libvirtd is restarted.

Normally only statistics for running and successful completed jobs are printed.
_--anystats_ can be used to also display statistics for failed jobs.

In case _--rawstats_ is used, all fields are printed as received from the
server without any attempts to interpret the data. The "Job type:" field is
special, since it's reported by the API and not part of stats.

Note that time information returned for completed
migrations may be completely irrelevant unless both source and
destination hosts have synchronized time (i.e., NTP daemon is running
on both of them).

<a name="dommemstat"></a>

### dommemstat


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    dommemstat domain [--period seconds] [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Get memory stats for a running domain.

Availability of these fields depends on hypervisor. Unsupported fields are
missing from the output. Other fields may appear if communicating with a newer
version of libvirtd.

Explanation of fields:
.INDENT 0.0

* ·  
  **swap\_in**           - The amount of data read from swap space (in KiB)
* ·  
  **swap\_out**          - The amount of memory written out to swap space (in KiB)
* ·  
  **major\_fault**       - The number of page faults where disk IO was required
* ·  
  **minor\_fault**       - The number of other page faults
* ·  
  **unused**            - The amount of memory left unused by the system (in KiB)
* ·  
  **available**         - The amount of usable memory as seen by the domain (in KiB)
* ·  
  **actual**            - Current balloon value (in KiB)
* ·  
  **rss**               - Resident Set Size of the running domain's process (in KiB)
* ·  
  **usable**            - The amount of memory which can be reclaimed by balloon
  without causing host swapping (in KiB)
* ·  
  **last-update**       - Timestamp of the last update of statistics (in seconds)
* ·  
  **disk\_caches**       - The amount of memory that can be reclaimed without
  additional I/O, typically disk caches (in KiB)
* ·  
  **hugetlb\_pgalloc**   - The number of successful huge page allocations initiated
  from within the domain
* ·  
  **hugetlb\_pgfail**    - The number of failed huge page allocations initiated from
  within the domain
  .UNINDENT

For QEMU/KVM with a memory balloon, setting the optional _--period_ to a
value larger than 0 in seconds will allow the balloon driver to return
additional statistics which will be displayed by subsequent **dommemstat**
commands. Setting the _--period_ to 0 will stop the balloon driver collection,
but does not clear the statistics in the balloon driver. Requires at least
QEMU/KVM 1.5 to be running on the host.

The _--live_, _--config_, and _--current_ flags are only valid when using
the _--period_ option in order to set the collection period for the balloon
driver. If _--live_ is specified, only the running guest collection period
is affected. If _--config_ is specified, affect the next boot of a persistent
guest. If _--current_ is specified, affect the current guest state.

Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. If no flag is specified, behavior is different depending
on the guest state.

<a name="domname"></a>

### domname


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domname domain-id-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Convert a domain Id (or UUID) to domain name

<a name="dompmsuspend"></a>

### dompmsuspend


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    dompmsuspend domain target [--duration]
    .ft P
.UNINDENT
.UNINDENT

Suspend a running domain into one of these states (possible _target_
values):
.INDENT 0.0

* ·  
  **mem** - equivalent of S3 ACPI state
* ·  
  **disk** - equivalent of S4 ACPI state
* ·  
  **hybrid** - RAM is saved to disk but not powered off
  .UNINDENT

The _--duration_ argument specifies number of seconds before the domain is
woken up after it was suspended (see also **dompmwakeup**). Default is 0 for
unlimited suspend time. (This feature isn't currently supported by any
hypervisor driver and 0 should be used.).

Note that this command requires a guest agent configured and running in the
domain's guest OS.

Beware that at least for QEMU, the domain's process will be terminated when
target disk is used and a new process will be launched when libvirt is asked
to wake up the domain. As a result of this, any runtime changes, such as
device hotplug or memory settings, are lost unless such changes were made
with _--config_ flag.

<a name="dompmwakeup"></a>

### dompmwakeup


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    dompmwakeup domain
    .ft P
.UNINDENT
.UNINDENT

Wakeup a domain from pmsuspended state (either suspended by dompmsuspend or
from the guest itself). Injects a wakeup into the guest that is in pmsuspended
state, rather than waiting for the previously requested duration (if any) to
elapse. This operation doesn't not necessarily fail if the domain is running.

<a name="domrename"></a>

### domrename


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domrename domain new-name
    .ft P
.UNINDENT
.UNINDENT

Rename a domain. This command changes current domain name to the new name
specified in the second argument.

**Note**: Domain must be inactive and without snapshots or checkpoints.

<a name="domstate"></a>

### domstate


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domstate domain [--reason]
    .ft P
.UNINDENT
.UNINDENT

Returns state about a domain.  _--reason_ tells virsh to also print
reason for the state.

<a name="domstats"></a>

### domstats


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domstats [--raw] [--enforce] [--backing] [--nowait] [--state]
       [--cpu-total] [--balloon] [--vcpu] [--interface]
       [--block] [--perf] [--iothread] [--memory]
       [[--list-active] [--list-inactive]
        [--list-persistent] [--list-transient] [--list-running]y
        [--list-paused] [--list-shutoff] [--list-other]] | [domain ...]
    .ft P
.UNINDENT
.UNINDENT

Get statistics for multiple or all domains. Without any argument this
command prints all available statistics for all domains.

The list of domains to gather stats for can be either limited by listing
the domains as a space separated list, or by specifying one of the
filtering flags _--list-NNN_. (The approaches can't be combined.)

By default some of the returned fields may be converted to more
human friendly values by a set of pretty-printers. To suppress this
behavior use the _--raw_ flag.

The individual statistics groups are selectable via specific flags. By
default all supported statistics groups are returned. Supported
statistics groups flags are: _--state_, _--cpu-total_, _--balloon_,
_--vcpu_, _--interface_, _--block_, _--perf_, _--iothread_, _--memory_.

Note that - depending on the hypervisor type and version or the domain state
- not all of the following statistics may be returned.

When selecting the _--state_ group the following fields are returned:
.INDENT 0.0

* ·  
  **state.state** - state of the VM, returned as number from
  virDomainState enum
* ·  
  **state.reason** - reason for entering given state, returned
  as int from virDomain*Reason enum corresponding
  to given state
  .UNINDENT

_--cpu-total_ returns:
.INDENT 0.0

* ·  
  **cpu.time** - total cpu time spent for this domain in nanoseconds
* ·  
  **cpu.user** - user cpu time spent in nanoseconds
* ·  
  **cpu.system** - system cpu time spent in nanoseconds
* ·  
  **cpu.cache.monitor.count** - the number of cache monitors for this
  domain
* ·  
  **cpu.cache.monitor.&lt;num&gt;.name** - the name of cache monitor &lt;num&gt;
* ·  
  **cpu.cache.monitor.&lt;num&gt;.vcpus** - vcpu list of cache monitor &lt;num&gt;
* ·  
  **cpu.cache.monitor.&lt;num&gt;.bank.count** - the number of cache banks
  in cache monitor &lt;num&gt;
* ·  
  **cpu.cache.monitor.&lt;num&gt;.bank.&lt;index&gt;.id** - host allocated cache id
  for bank &lt;index&gt; in cache monitor &lt;num&gt;
* ·  
  **cpu.cache.monitor.&lt;num&gt;.bank.&lt;index&gt;.bytes** - the number of bytes
  of last level cache that the domain is using on cache bank &lt;index&gt;
  .UNINDENT

_--balloon_ returns:
.INDENT 0.0

* ·  
  **balloon.current** - the memory in KiB currently used
* ·  
  **balloon.maximum** - the maximum memory in KiB allowed
* ·  
  **balloon.swap\_in** - the amount of data read from swap space (in KiB)
* ·  
  **balloon.swap\_out** - the amount of memory written out to swap
  space (in KiB)
* ·  
  **balloon.major\_fault** - the number of page faults when disk IO
  was required
* ·  
  **balloon.minor\_fault** - the number of other page faults
* ·  
  **balloon.unused** - the amount of memory left unused by the
  system (in KiB)
* ·  
  **balloon.available** - the amount of usable memory as seen by
  the domain (in KiB)
* ·  
  **balloon.rss** - Resident Set Size of running domain's process
  (in KiB)
* ·  
  **balloon.usable** - the amount of memory which can be reclaimed by
  balloon without causing host swapping (in KiB)
* ·  
  **balloon.last-update** - timestamp of the last update of statistics
  (in seconds)
* ·  
  **balloon.disk\_caches** - the amount of memory that can be reclaimed
  without additional I/O, typically disk (in KiB)
* ·  
  **balloon.hugetlb\_pgalloc** - the number of successful huge page allocations
  from inside the domain via virtio balloon
* ·  
  **balloon.hugetlb\_pgfail** - the number of failed huge page allocations
  from inside the domain via virtio balloon
  .UNINDENT

_--vcpu_ returns:
.INDENT 0.0

* ·  
  **vcpu.current** - current number of online virtual CPUs
* ·  
  **vcpu.maximum** - maximum number of online virtual CPUs
* ·  
  **vcpu.&lt;num&gt;.state** - state of the virtual CPU &lt;num&gt;, as
  number from virVcpuState enum
* ·  
  **vcpu.&lt;num&gt;.time** - virtual cpu time spent by virtual
  CPU &lt;num&gt; (in microseconds)
* ·  
  **vcpu.&lt;num&gt;.wait** - virtual cpu time spent by virtual
  CPU &lt;num&gt; waiting on I/O (in microseconds)
* ·  
  **vcpu.&lt;num&gt;.halted** - virtual CPU &lt;num&gt; is halted: yes or
  no (may indicate the processor is idle or even disabled,
  depending on the architecture)
  .UNINDENT

_--interface_ returns:
.INDENT 0.0

* ·  
  **net.count** - number of network interfaces on this domain
* ·  
  **net.&lt;num&gt;.name** - name of the interface &lt;num&gt;
* ·  
  **net.&lt;num&gt;.rx.bytes** - number of bytes received
* ·  
  **net.&lt;num&gt;.rx.pkts** - number of packets received
* ·  
  **net.&lt;num&gt;.rx.errs** - number of receive errors
* ·  
  **net.&lt;num&gt;.rx.drop** - number of receive packets dropped
* ·  
  **net.&lt;num&gt;.tx.bytes** - number of bytes transmitted
* ·  
  **net.&lt;num&gt;.tx.pkts** - number of packets transmitted
* ·  
  **net.&lt;num&gt;.tx.errs** - number of transmission errors
* ·  
  **net.&lt;num&gt;.tx.drop** - number of transmit packets dropped
  .UNINDENT

_--perf_ returns the statistics of all enabled perf events:
.INDENT 0.0

* ·  
  **perf.cmt** - the cache usage in Byte currently used
* ·  
  **perf.mbmt** - total system bandwidth from one level of cache
* ·  
  **perf.mbml** - bandwidth of memory traffic for a memory controller
* ·  
  **perf.cpu\_cycles** - the count of cpu cycles (total/elapsed)
* ·  
  **perf.instructions** - the count of instructions
* ·  
  **perf.cache\_references** - the count of cache hits
* ·  
  **perf.cache\_misses** - the count of caches misses
* ·  
  **perf.branch\_instructions** - the count of branch instructions
* ·  
  **perf.branch\_misses** - the count of branch misses
* ·  
  **perf.bus\_cycles** - the count of bus cycles
* ·  
  **perf.stalled\_cycles\_frontend** - the count of stalled frontend
  cpu cycles
* ·  
  **perf.stalled\_cycles\_backend** - the count of stalled backend
  cpu cycles
* ·  
  **perf.ref\_cpu\_cycles** - the count of ref cpu cycles
* ·  
  **perf.cpu\_clock** - the count of cpu clock time
* ·  
  **perf.task\_clock** - the count of task clock time
* ·  
  **perf.page\_faults** - the count of page faults
* ·  
  **perf.context\_switches** - the count of context switches
* ·  
  **perf.cpu\_migrations** - the count of cpu migrations
* ·  
  **perf.page\_faults\_min** - the count of minor page faults
* ·  
  **perf.page\_faults\_maj** - the count of major page faults
* ·  
  **perf.alignment\_faults** - the count of alignment faults
* ·  
  **perf.emulation\_faults** - the count of emulation faults
  .UNINDENT

See the **perf** command for more details about each event.

_--block_ returns information about disks associated with each
domain.  Using the _--backing_ flag extends this information to
cover all resources in the backing chain, rather than the default
of limiting information to the active layer for each guest disk.
Information listed includes:
.INDENT 0.0

* ·  
  **block.count** - number of block devices being listed
* ·  
  **block.&lt;num&gt;.name** - name of the target of the block
  device &lt;num&gt; (the same name for multiple entries if _--backing_
  is present)
* ·  
  **block.&lt;num&gt;.backingIndex** - when _--backing_ is present,
  matches up with the &lt;backingStore&gt; index listed in domain XML for
  backing files
* ·  
  **block.&lt;num&gt;.path** - file source of block device &lt;num&gt;, if
  it is a local file or block device
* ·  
  **block.&lt;num&gt;.rd.reqs** - number of read requests
* ·  
  **block.&lt;num&gt;.rd.bytes** - number of read bytes
* ·  
  **block.&lt;num&gt;.rd.times** - total time (ns) spent on reads
* ·  
  **block.&lt;num&gt;.wr.reqs** - number of write requests
* ·  
  **block.&lt;num&gt;.wr.bytes** - number of written bytes
* ·  
  **block.&lt;num&gt;.wr.times** - total time (ns) spent on writes
* ·  
  **block.&lt;num&gt;.fl.reqs** - total flush requests
* ·  
  **block.&lt;num&gt;.fl.times** - total time (ns) spent on cache flushing
* ·  
  **block.&lt;num&gt;.errors** - Xen only: the 'oo_req' value
* ·  
  **block.&lt;num&gt;.allocation** - offset of highest written sector in bytes
* ·  
  **block.&lt;num&gt;.capacity** - logical size of source file in bytes
* ·  
  **block.&lt;num&gt;.physical** - physical size of source file in bytes
* ·  
  **block.&lt;num&gt;.threshold** - threshold (in bytes) for delivering the
  VIR_DOMAIN_EVENT_ID_BLOCK_THRESHOLD event. See domblkthreshold.
  .UNINDENT

_--iothread_ returns information about IOThreads on the running guest
if supported by the hypervisor.

The "poll-max-ns" for each thread is the maximum nanoseconds to allow
each polling interval to occur. A polling interval is a period of time
allowed for a thread to process data before being the guest gives up
its CPU quantum back to the host. A value set too small will not allow
the IOThread to run long enough on a CPU to process data. A value set
too high will consume too much CPU time per IOThread failing to allow
other threads running on the CPU to get time. The polling interval is
not available for statistical purposes.
.INDENT 0.0

* ·  
  .INDENT 2.0
* <b>**iothread.count** - maximum number of IOThreads in the subsequent list</b>  
  as unsigned int. Each IOThread in the list will
  will use it's iothread_id value as the &lt;id&gt;. There
  may be fewer &lt;id&gt; entries than the iothread.count
  value if the polling values are not supported.
  .UNINDENT
* ·  
  **iothread.&lt;id&gt;.poll-max-ns** - maximum polling time in nanoseconds used
  by the &lt;id&gt; IOThread. A value of 0 (zero) indicates polling is disabled.
* ·  
  **iothread.&lt;id&gt;.poll-grow** - polling time grow value. A value of 0 (zero)
  growth is managed by the hypervisor.
* ·  
  **iothread.&lt;id&gt;.poll-shrink** - polling time shrink value. A value of
  (zero) indicates shrink is managed by hypervisor.
  .UNINDENT

_--memory_ returns:
.INDENT 0.0

* ·  
  **memory.bandwidth.monitor.count** - the number of memory bandwidth
  monitors for this domain
* ·  
  **memory.bandwidth.monitor.&lt;num&gt;.name**  - the name of monitor &lt;num&gt;
* ·  
  **memory.bandwidth.monitor.&lt;num&gt;.vcpus** - the vcpu list of monitor &lt;num&gt;
* ·  
  .INDENT 2.0
* <b>**memory.bandwidth.monitor.&lt;num&gt;.node.count** - the number of memory</b>  
  controller in monitor &lt;num&gt;
  .UNINDENT
* ·  
  **memory.bandwidth.monitor.&lt;num&gt;.node.&lt;index&gt;.id** - host allocated memory
  controller id for controller &lt;index&gt; of monitor &lt;num&gt;
* ·  
  **memory.bandwidth.monitor.&lt;num&gt;.node.&lt;index&gt;.bytes.local** - the accumulative
  bytes consumed by @vcpus that passing through the memory controller in the
  same processor that the scheduled host CPU belongs to.
* ·  
  **memory.bandwidth.monitor.&lt;num&gt;.node.&lt;index&gt;.bytes.total** - the total
  bytes consumed by @vcpus that passing through all memory controllers, either
  local or remote controller.
  .UNINDENT

Selecting a specific statistics groups doesn't guarantee that the
daemon supports the selected group of stats. Flag _--enforce_
forces the command to fail if the daemon doesn't support the
selected group.

When collecting stats libvirtd may wait for some time if there's
already another job running on given domain for it to finish.
This may cause unnecessary delay in delivering stats. Using
_--nowait_ suppresses this behaviour. On the other hand
some statistics might be missing for such domain.

<a name="domtime"></a>

### domtime


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domtime domain { [--now] [--pretty] [--sync] [--time time] }
    .ft P
.UNINDENT
.UNINDENT

Gets or sets the domain's system time. When run without any arguments
(but _domain_), the current domain's system time is printed out. The
_--pretty_ modifier can be used to print the time in more human
readable form.

When _--time_ **time** is specified, the domain's time is
not gotten but set instead. The _--now_ modifier acts like if it was
an alias for _--time_ **$now**, which means it sets the time that is
currently on the host virsh is running at. In both cases (setting and
getting), time is in seconds relative to Epoch of 1970-01-01 in UTC.
The _--sync_ modifies the set behavior a bit: The time passed is
ignored, but the time to set is read from domain's RTC instead. Please
note, that some hypervisors may require a guest agent to be configured
in order to get or set the guest time.

<a name="domuuid"></a>

### domuuid


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domuuid domain-name-or-id
    .ft P
.UNINDENT
.UNINDENT

Convert a domain name or id to domain UUID

<a name="domxml-from-native"></a>

### domxml\-from\-native


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domxml-from-native format config
    .ft P
.UNINDENT
.UNINDENT

Convert the file _config_ in the native guest configuration format
named by _format_ to a domain XML format. For QEMU/KVM hypervisor,
the _format_ argument must be **qemu-argv**. For Xen hypervisor, the
_format_ argument may be **xen-xm**, **xen-xl**, or **xen-sxpr**. For
LXC hypervisor, the _format_ argument must be **lxc-tools**. For
VMware/ESX hypervisor, the _format_ argument must be **vmware-vmx**.
For the Bhyve hypervisor, the _format_ argument must be **bhyve-argv**.

<a name="domxml-to-native"></a>

### domxml\-to\-native


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    domxml-to-native format { [--xml] xml | --domain domain-name-or-id-or-uuid }
    .ft P
.UNINDENT
.UNINDENT

Convert the file _xml_ into domain XML format or convert an existing
_--domain_ to the native guest configuration format named by _format_.
The _xml_ and _--domain_ arguments are mutually exclusive. For the types
of _format_ argument, refer to **domxml-from-native**.

<a name="dump"></a>

### dump


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    dump domain corefilepath [--bypass-cache]
       { [--live] | [--crash] | [--reset] }
       [--verbose] [--memory-only] [--format string]
    .ft P
.UNINDENT
.UNINDENT

Dumps the core of a domain to a file for analysis.
If _--live_ is specified, the domain continues to run until the core
dump is complete, rather than pausing up front.
If _--crash_ is specified, the domain is halted with a crashed status,
rather than merely left in a paused state.
If _--reset_ is specified, the domain is reset after successful dump.
Note, these three switches are mutually exclusive.
If _--bypass-cache_ is specified, the save will avoid the file system
cache, although this may slow down the operation.
If _--memory-only_ is specified, the file is elf file, and will only
include domain's memory and cpu common register value. It is very
useful if the domain uses host devices directly.
_--format_ _string_ is used to specify the format of 'memory-only'
dump, and _string_ can be one of them: elf, kdump-zlib(kdump-compressed
format with zlib-compressed), kdump-lzo(kdump-compressed format with
lzo-compressed), kdump-snappy(kdump-compressed format with snappy-compressed).

The progress may be monitored using **domjobinfo** virsh command and canceled
with **domjobabort** command (sent by another virsh instance). Another option
is to send SIGINT (usually with **Ctrl-C**) to the virsh process running
**dump** command. _--verbose_ displays the progress of dump.

NOTE: Some hypervisors may require the user to manually ensure proper
permissions on file and path specified by argument _corefilepath_.

NOTE: Crash dump in a old kvmdump format is being obsolete and cannot be loaded
and processed by crash utility since its version 6.1.0. A --memory-only option
is required in order to produce valid ELF file which can be later processed by
the crash utility.

<a name="dumpxml"></a>

### dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    dumpxml domain [--inactive] [--security-info] [--update-cpu] [--migratable]
    .ft P
.UNINDENT
.UNINDENT

Output the domain information as an XML dump to stdout, this format can be used
by the **create** command. Additional options affecting the XML dump may be
used. _--inactive_ tells virsh to dump domain configuration that will be used
on next start of the domain as opposed to the current domain configuration.
Using _--security-info_ will also include security sensitive information
in the XML dump. _--update-cpu_ updates domain CPU requirements according to
host CPU. With _--migratable_ one can request an XML that is suitable for
migrations, i.e., compatible with older libvirt releases and possibly amended
with internal run-time options. This option may automatically enable other
options (_--update-cpu_, _--security-info_, ...) as necessary.

<a name="edit"></a>

### edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    edit domain
    .ft P
.UNINDENT
.UNINDENT

Edit the XML configuration file for a domain, which will affect the
next boot of the guest.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh dumpxml --inactive --security-info domain > domain.xml
    vi domain.xml (or make changes with your other text editor)
    virsh define domain.xml
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

<a name="emulatorpin"></a>

### emulatorpin


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    emulatorpin domain [cpulist] [[--live] [--config]  | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Query or change the pinning of domain's emulator threads to host physical
CPUs.

See **vcpupin** for _cpulist_.

If _--live_ is specified, affect a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
Both _--live_ and _--config_ flags may be given if _cpulist_ is present,
but _--current_ is exclusive.
If no flag is specified, behavior is different depending on hypervisor.

<a name="event"></a>

### event


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    event {[domain] { event | --all } [--loop] [--timeout seconds] [--timestamp] | --list}
    .ft P
.UNINDENT
.UNINDENT

Wait for a class of domain events to occur, and print appropriate details
of events as they happen.  The events can optionally be filtered by
_domain_.  Using _--list_ as the only argument will provide a list
of possible _event_ values known by this client, although the connection
might not allow registering for all these events.  It is also possible
to use _--all_ instead of _event_ to register for all possible event
types at once.

By default, this command is one-shot, and returns success once an event
occurs; you can send SIGINT (usually via **Ctrl-C**) to quit immediately.
If _--timeout_ is specified, the command gives up waiting for events
after _seconds_ have elapsed.   With _--loop_, the command prints all
events until a timeout or interrupt key.

When _--timestamp_ is used, a human-readable timestamp will be printed
before the event.

<a name="guest"></a>

### guest


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    guest-agent-timeout domain --timeout value
    .ft P
.UNINDENT
.UNINDENT

Set how long to wait for a response from guest agent commands. By default,
agent commands block forever waiting for a response. **value** must be a
positive value (wait for given amount of seconds) or one of the following
values:
.INDENT 0.0

* ·  
  -2 - block forever waiting for a result,
* ·  
  -1 - reset timeout to the default value,
* ·  
  0 - do not wait at all,
  .UNINDENT

<a name="guestinfo"></a>

### guestinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    guestinfo domain [--user] [--os] [--timezone] [--hostname] [--filesystem]
    .ft P
.UNINDENT
.UNINDENT

Print information about the guest from the point of view of the guest agent.
Note that this command requires a guest agent to be configured and running in
the domain's guest OS.

When run without any arguments, this command prints all information types that
are supported by the guest agent. You can limit the types of information that
are returned by specifying one or more flags.  If a requested information
type is not supported, the processes will provide an exit code of 1.
Available information types flags are _--user_, _--os_,
_--timezone_, _--hostname_, and _--filesystem_.

Note that depending on the hypervisor type and the version of the guest agent
running within the domain, not all of the following information may be
returned.

When selecting the _--user_ information type, the following fields may be
returned:
.INDENT 0.0

* ·  
  **user.count** - the number of active users on this domain
* ·  
  **user.&lt;num&gt;.name** - username of user &lt;num&gt;
* ·  
  **user.&lt;num&gt;.domain** - domain of the user &lt;num&gt; (may only be present on certain
  guets types)
* ·  
  **user.&lt;num&gt;.login-time** - the login time of user &lt;num&gt; in milliseconds since
  the epoch
  .UNINDENT

_--os_ returns:
.INDENT 0.0

* ·  
  **os.id** - a string identifying the operating system
* ·  
  **os.name** - the name of the operating system
* ·  
  **os.pretty-name** - a pretty name for the operating system
* ·  
  **os.version** - the version of the operating system
* ·  
  **os.version-id** - the version id of the operating system
* ·  
  **os.kernel-release** - the release of the operating system kernel
* ·  
  **os.kernel-version** - the version of the operating system kernel
* ·  
  **os.machine** - the machine hardware name
* ·  
  **os.variant** - a specific variant or edition of the operating system
* ·  
  **os.variant-id** - the id for a specific variant or edition of the operating
  system
  .UNINDENT

_--timezone_ returns:
.INDENT 0.0

* ·  
  **timezone.name** - the name of the timezone
* ·  
  **timezone.offset** - the offset to UTC in seconds
  .UNINDENT

_--hostname_ returns:
.INDENT 0.0

* ·  
  **hostname** - the hostname of the domain
  .UNINDENT

_--filesystem_ returns:
.INDENT 0.0

* ·  
  **fs.count** - the number of filesystems defined on this domain
* ·  
  **fs.&lt;num&gt;.mountpoint** - the path to the mount point for filesystem &lt;num&gt;
* ·  
  **fs.&lt;num&gt;.name** - device name in the guest (e.g. **sda1**) for filesystem &lt;num&gt;
* ·  
  **fs.&lt;num&gt;.fstype** - the type of filesystem &lt;num&gt;
* ·  
  **fs.&lt;num&gt;.total-bytes** - the total size of filesystem &lt;num&gt;
* ·  
  **fs.&lt;num&gt;.used-bytes** - the number of bytes used in filesystem &lt;num&gt;
* ·  
  **fs.&lt;num&gt;.disk.count** - the number of disks targeted by filesystem &lt;num&gt;
* ·  
  **fs.&lt;num&gt;.disk.&lt;num&gt;.alias** - the device alias of disk &lt;num&gt; (e.g. sda)
* ·  
  **fs.&lt;num&gt;.disk.&lt;num&gt;.serial** - the serial number of disk &lt;num&gt;
* ·  
  **fs.&lt;num&gt;.disk.&lt;num&gt;.device** - the device node of disk &lt;num&gt;
  .UNINDENT

<a name="guestvcpus"></a>

### guestvcpus


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    guestvcpus domain [[--enable] | [--disable]] [cpulist]
    .ft P
.UNINDENT
.UNINDENT

Query or change state of vCPUs from guest's point of view using the guest agent.
When invoked without _cpulist_ the guest is queried for available guest vCPUs,
their state and possibility to be offlined.

If _cpulist_ is provided then one of _--enable_ or _--disable_ must be
provided too. The desired operation is then executed on the domain.

See **vcpupin** for information on _cpulist_.

<a name="iothreadadd"></a>

### iothreadadd


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iothreadadd domain iothread_id [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Add a new IOThread to the domain using the specified _iothread\_id_.
If the _iothread\_id_ already exists, the command will fail. The
_iothread\_id_ must be greater than zero.

If _--live_ is specified, affect a running guest. If the guest is not
running an error is returned.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified or _--live_ and _--config_ are not specified,
affect the current guest state.

<a name="iothreaddel"></a>

### iothreaddel


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iothreaddel domain iothread_id [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Delete an IOThread from the domain using the specified _iothread\_id_.
If an IOThread is currently assigned to a disk resource such as via the
**attach-disk** command, then the attempt to remove the IOThread will fail.
If the _iothread\_id_ does not exist an error will occur.

If _--live_ is specified, affect a running guest. If the guest is not
running an error is returned.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified or _--live_ and _--config_ are not specified,
affect the current guest state.

<a name="iothreadinfo"></a>

### iothreadinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iothreadinfo domain [[--live] [--config] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Display basic domain IOThreads information including the IOThread ID and
the CPU Affinity for each IOThread.

If _--live_ is specified, get the IOThreads data from the running guest. If
the guest is not running, an error is returned.
If _--config_ is specified, get the IOThreads data from the next boot of
a persistent guest.
If _--current_ is specified or _--live_ and _--config_ are not specified,
then get the IOThread data based on the current guest state.

<a name="iothreadpin"></a>

### iothreadpin


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iothreadpin domain iothread cpulist [[--live] [--config] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Change the pinning of a domain IOThread to host physical CPUs. In order
to retrieve a list of all IOThreads, use **iothreadinfo**. To pin an
_iothread_ specify the _cpulist_ desired for the IOThread ID as listed
in the **iothreadinfo** output.

_cpulist_ is a list of physical CPU numbers. Its syntax is a comma
separated list and a special markup using '-' and '^' (ex. '0-4', '0-3,^2') can
also be allowed. The '-' denotes the range and the '^' denotes exclusive.
If you want to reset iothreadpin setting, that is, to pin an _iothread_
to all physical cpus, simply specify 'r' as a _cpulist_.

If _--live_ is specified, affect a running guest. If the guest is not running,
an error is returned.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified or _--live_ and _--config_ are not specified,
affect the current guest state.
Both _--live_ and _--config_ flags may be given if _cpulist_ is present,
but _--current_ is exclusive.
If no flag is specified, behavior is different depending on hypervisor.

**Note**: The expression is sequentially evaluated, so "0-15,^8" is
identical to "9-14,0-7,15" but not identical to "^8,0-15".

<a name="iothreadset"></a>

### iothreadset


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iothreadset domain iothread_id [[--poll-max-ns ns] [--poll-grow factor]
       [--poll-shrink divisor]]
       [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Modifies an existing iothread of the domain using the specified
_iothread\_id_. The _--poll-max-ns_ provides the maximum polling
interval to be allowed for an IOThread in ns. If a 0 (zero) is provided,
then polling for the IOThread is disabled.  The _--poll-grow_ is the
factor by which the current polling time will be adjusted in order to
reach the maximum polling time. If a 0 (zero) is provided, then the
default factor will be used. The _--poll-shrink_ is the quotient
by which the current polling time will be reduced in order to get
below the maximum polling interval. If a 0 (zero) is provided, then
the default quotient will be used. The polling values are purely dynamic
for a running guest. Saving, destroying, stopping, etc. the guest will
result in the polling values returning to hypervisor defaults at the
next start, restore, etc.

If _--live_ is specified, affect a running guest. If the guest is not
running an error is returned.
If _--current_ is specified or _--live_ is not specified, then handle
as if _--live_ was specified.

<a name="managedsave"></a>

### managedsave


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    managedsave domain [--bypass-cache] [{--running | --paused}] [--verbose]
    .ft P
.UNINDENT
.UNINDENT

Save and destroy (stop) a running domain, so it can be restarted from the same
state at a later time.  When the virsh **start** command is next run for
the domain, it will automatically be started from this saved state.
If _--bypass-cache_ is specified, the save will avoid the file system
cache, although this may slow down the operation.

The progress may be monitored using **domjobinfo** virsh command and canceled
with **domjobabort** command (sent by another virsh instance). Another option
is to send SIGINT (usually with **Ctrl-C**) to the virsh process running
**managedsave** command. _--verbose_ displays the progress of save.

Normally, starting a managed save will decide between running or paused
based on the state the domain was in when the save was done; passing
either the _--running_ or _--paused_ flag will allow overriding which
state the **start** should use.

The **dominfo** command can be used to query whether a domain currently
has any managed save image.

<a name="managedsave-define"></a>

### managedsave\-define


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    managedsave-define domain xml [{--running | --paused}]
    .ft P
.UNINDENT
.UNINDENT

Update the domain XML that will be used when _domain_ is later
started. The _xml_ argument must be a file name containing
the alternative XML, with changes only in the host-specific portions of
the domain XML. For example, it can be used to change disk file paths.

The managed save image records whether the domain should be started to a
running or paused state.  Normally, this command does not alter the
recorded state; passing either the _--running_ or _--paused_ flag
will allow overriding which state the **start** should use.

<a name="managedsave-dumpxml"></a>

### managedsave\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    managedsave-dumpxml domain [--security-info]
    .ft P
.UNINDENT
.UNINDENT

Extract the domain XML that was in effect at the time the saved state
file _file_ was created with the **managedsave** command.  Using
_--security-info_ will also include security sensitive information.

<a name="managedsave-edit"></a>

### managedsave\-edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    managedsave-edit domain [{--running | --paused}]
    .ft P
.UNINDENT
.UNINDENT

Edit the XML configuration associated with a saved state file of a
_domain_ was created by the **managedsave** command.

The managed save image records whether the domain should be started to a
running or paused state.  Normally, this command does not alter the
recorded state; passing either the _--running_ or _--paused_ flag
will allow overriding which state the **restore** should use.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh managedsave-dumpxml domain-name > state-file.xml
    vi state-file.xml (or make changes with your other text editor)
    virsh managedsave-define domain-name state-file-xml
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

<a name="managedsave-remove"></a>

### managedsave\-remove


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    managedsave-remove domain
    .ft P
.UNINDENT
.UNINDENT

Remove the **managedsave** state file for a domain, if it exists.  This
ensures the domain will do a full boot the next time it is started.

<a name="maxvcpus"></a>

### maxvcpus


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    maxvcpus [type]
    .ft P
.UNINDENT
.UNINDENT

Provide the maximum number of virtual CPUs supported for a guest VM on
this connection.  If provided, the _type_ parameter must be a valid
type attribute for the &lt;domain&gt; element of XML.

<a name="memtune"></a>

### memtune


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    memtune domain [--hard-limit size] [--soft-limit size] [--swap-hard-limit size]
       [--min-guarantee size] [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Allows you to display or set the domain memory parameters. Without
flags, the current settings are displayed; with a flag, the
appropriate limit is adjusted if supported by the hypervisor.  LXC and
QEMU/KVM support _--hard-limit_, _--soft-limit_, and _--swap-hard-limit_.
_--min-guarantee_ is supported only by ESX hypervisor.  Each of these
limits are scaled integers (see **NOTES** above), with a default of
kibibytes (blocks of 1024 bytes) if no suffix is present. Libvirt rounds
up to the nearest kibibyte.  Some hypervisors require a larger granularity
than KiB, and requests that are not an even multiple will be rounded up.
For example, vSphere/ESX rounds the parameter up to mebibytes (1024 kibibytes).

If _--live_ is specified, affect a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. If no flag is specified, behavior is different depending
on hypervisor.

For QEMU/KVM, the parameters are applied to the QEMU process as a whole.
Thus, when counting them, one needs to add up guest RAM, guest video RAM, and
some memory overhead of QEMU itself.  The last piece is hard to determine so
one needs guess and try.

For LXC, the displayed hard_limit value is the current memory setting
from the XML or the results from a **virsh setmem** command.
.INDENT 0.0

* ·  
  _--hard-limit_

The maximum memory the guest can use.

* ·  
  _--soft-limit_

The memory limit to enforce during memory contention.

* ·  
  _--swap-hard-limit_

The maximum memory plus swap the guest can use.  This has to be more
than hard-limit value provided.

* ·  
  _--min-guarantee_

The guaranteed minimum memory allocation for the guest.
.UNINDENT

Specifying -1 as a value for these limits is interpreted as unlimited.

<a name="metadata"></a>

### metadata


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    metadata domain [[--live] [--config] | [--current]]
       [--edit] [uri] [key] [set] [--remove]
    .ft P
.UNINDENT
.UNINDENT

Show or modify custom XML metadata of a domain. The metadata is a user
defined XML that allows storing arbitrary XML data in the domain definition.
Multiple separate custom metadata pieces can be stored in the domain XML.
The pieces are identified by a private XML namespace provided via the
_uri_ argument. (See also **desc** that works with textual metadata of
a domain.)

Flags _--live_ or _--config_ select whether this command works on live
or persistent definitions of the domain. If both _--live_ and _--config_
are specified, the _--config_ option takes precedence on getting the current
description and both live configuration and config are updated while setting
the description. _--current_ is exclusive and implied if none of these was
specified.

Flag _--remove_ specifies that the metadata element specified by the _uri_
argument should be removed rather than updated.

Flag _--edit_ specifies that an editor with the metadata identified by the
_uri_ argument should be opened and the contents saved back afterwards.
Otherwise the new contents can be provided via the _set_ argument.

When setting metadata via _--edit_ or _set_ the _key_ argument must be
specified and is used to prefix the custom elements to bind them
to the private namespace.

If neither of _--edit_ and _set_ are specified the XML metadata corresponding
to the _uri_ namespace is displayed instead of being modified.

<a name="migrate"></a>

### migrate


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    migrate [--live] [--offline] [--direct] [--p2p [--tunnelled]]
       [--persistent] [--undefinesource] [--suspend] [--copy-storage-all]
       [--copy-storage-inc] [--change-protection] [--unsafe] [--verbose]
       [--rdma-pin-all] [--abort-on-error] [--postcopy] [--postcopy-after-precopy]
       domain desturi [migrateuri] [graphicsuri] [listen-address] [dname]
       [--timeout seconds [--timeout-suspend | --timeout-postcopy]]
       [--xml file] [--migrate-disks disk-list] [--disks-port port]
       [--compressed] [--comp-methods method-list]
       [--comp-mt-level] [--comp-mt-threads] [--comp-mt-dthreads]
       [--comp-xbzrle-cache] [--auto-converge] [auto-converge-initial]
       [auto-converge-increment] [--persistent-xml file] [--tls]
       [--postcopy-bandwidth bandwidth]
       [--parallel [--parallel-connections connections]]
       [--bandwidth bandwidth] [--tls-destination hostname]
    .ft P
.UNINDENT
.UNINDENT

Migrate domain to another host.  Add _--live_ for live migration; &lt;--p2p&gt;
for peer-2-peer migration; _--direct_ for direct migration; or _--tunnelled_
for tunnelled migration.  _--offline_ migrates domain definition without
starting the domain on destination and without stopping it on source host.
Offline migration may be used with inactive domains and it must be used with
_--persistent_ option.  _--persistent_ leaves the domain persistent on
destination host, _--undefinesource_ undefines the domain on the source host,
and _--suspend_ leaves the domain paused on the destination host.
_--copy-storage-all_ indicates migration with non-shared storage with full
disk copy, _--copy-storage-inc_ indicates migration with non-shared storage
with incremental copy (same base image shared between source and destination).
In both cases the disk images have to exist on destination host, the
_--copy-storage-..._ options only tell libvirt to transfer data from the
images on source host to the images found at the same place on the destination
host. By default only non-shared non-readonly images are transferred. Use
_--migrate-disks_ to explicitly specify a list of disk targets to
transfer via the comma separated **disk-list** argument. _--change-protection_
enforces that no incompatible configuration changes will be made to the domain
while the migration is underway; this flag is implicitly enabled when supported
by the hypervisor, but can be explicitly used to reject the migration if the
hypervisor lacks change protection support.  _--verbose_ displays the progress
of migration.  _--abort-on-error_ cancels
the migration if a soft error (for example I/O error) happens during the
migration. _--postcopy_ enables post-copy logic in migration, but does not
actually start post-copy, i.e., migration is started in pre-copy mode.
Once migration is running, the user may switch to post-copy using the
**migrate-postcopy** command sent from another virsh instance or use
_--postcopy-after-precopy_ along with _--postcopy_ to let libvirt
automatically switch to post-copy after the first pass of pre-copy is finished.
The maximum bandwidth consumed during the post-copy phase may be limited using
_--postcopy-bandwidth_. The maximum bandwidth consumed during the pre-copy phase
may be limited using _--bandwidth_.

_--auto-converge_ forces convergence during live migration. The initial
guest CPU throttling rate can be set with _auto-converge-initial_. If the
initial throttling rate is not enough to ensure convergence, the rate is
periodically increased by _auto-converge-increment_.

_--rdma-pin-all_ can be used with RDMA migration (i.e., when _migrateuri_
starts with rdma://) to tell the hypervisor to pin all domain's memory at once
before migration starts rather than letting it pin memory pages as needed. For
QEMU/KVM this requires hard_limit memory tuning element (in the domain XML) to
be used and set to the maximum memory configured for the domain plus any memory
consumed by the QEMU process itself. Beware of setting the memory limit too
high (and thus allowing the domain to lock most of the host's memory). Doing so
may be dangerous to both the domain and the host itself since the host's kernel
may run out of memory.

**Note**: Individual hypervisors usually do not support all possible types of
migration. For example, QEMU does not support direct migration.

In some cases libvirt may refuse to migrate the domain because doing so may
lead to potential problems such as data corruption, and thus the migration is
considered unsafe. For QEMU domain, this may happen if the domain uses disks
without explicitly setting cache mode to "none". Migrating such domains is
unsafe unless the disk images are stored on coherent clustered filesystem,
such as GFS2 or GPFS. If you are sure the migration is safe or you just do not
care, use _--unsafe_ to force the migration.

_dname_ is used for renaming the domain to new name during migration, which
also usually can be omitted.  Likewise, _--xml_ **file** is usually
omitted, but can be used to supply an alternative XML file for use on
the destination to supply a larger set of changes to any host-specific
portions of the domain XML, such as accounting for naming differences
between source and destination in accessing underlying storage.
If _--persistent_ is enabled, _--persistent-xml_ **file** can be used to
supply an alternative XML file which will be used as the persistent domain
definition on the destination host.

_--timeout_ **seconds** tells virsh to run a specified action when live
migration exceeds that many seconds.  It can only be used with _--live_.
If _--timeout-suspend_ is specified, the domain will be suspended after
the timeout and the migration will complete offline; this is the default
if no --timeout-\e\`\` option is specified on the command line.  When
*--timeout-postcopy is used, virsh will switch migration from pre-copy
to post-copy upon timeout; migration has to be started with _--postcopy_
option for this to work.

_--compressed_ activates compression, the compression method is chosen
with _--comp-methods_. Supported methods are "mt" and "xbzrle" and
can be used in any combination. When no methods are specified, a hypervisor
default methods will be used. QEMU defaults to "xbzrle". Compression methods
can be tuned further. _--comp-mt-level_ sets compression level.
Values are in range from 0 to 9, where 1 is maximum speed and 9 is maximum
compression. _--comp-mt-threads_ and _--comp-mt-dthreads_ set the number
of compress threads on source and the number of decompress threads on target
respectively. _--comp-xbzrle-cache_ sets size of page cache in bytes.

Providing _--tls_ causes the migration to use the host configured TLS setup
(see migrate_tls_x509_cert_dir in /etc/libvirt/qemu.conf) in order to perform
the migration of the domain. Usage requires proper TLS setup for both source
and target. Normally the TLS certificate from the destination host must match
+the host's name for TLS verification to succeed. When the certificate does not
+match the destination hostname and the expected certificate's hostname is
+known, _--tls-destination_ can be used to pass the expected _hostname_ when
+starting the migration.

_--parallel_ option will cause migration data to be sent over multiple
parallel connections. The number of such connections can be set using
_--parallel-connections_. Parallel connections may help with saturating the
network link between the source and the target and thus speeding up the
migration.

Running migration can be canceled by interrupting virsh (usually using
**Ctrl-C**) or by **domjobabort** command sent from another virsh instance.

The _desturi_ and _migrateuri_ parameters can be used to control which
destination the migration uses.  _desturi_ is important for managed
migration, but unused for direct migration; _migrateuri_ is required
for direct migration, but can usually be automatically determined for
managed migration.

**Note**: The _desturi_ parameter for normal migration and peer2peer migration
has different semantics:
.INDENT 0.0

* ·  
  normal migration: the _desturi_ is an address of the target host as seen from the client machine.
* ·  
  peer2peer migration: the _desturi_ is an address of the target host as seen from the source machine.
  .UNINDENT

When _migrateuri_ is not specified, libvirt will automatically determine the
hypervisor specific URI.  Some hypervisors, including QEMU, have an optional
"migration_host" configuration parameter (useful when the host has multiple
network interfaces).  If this is unspecified, libvirt determines a name
by looking up the target host's configured hostname.

There are a few scenarios where specifying _migrateuri_ may help:
.INDENT 0.0

* ·  
  The configured hostname is incorrect, or DNS is broken.
  If a host has a hostname which will not resolve to match one of its public IP addresses, then
  libvirt will generate an incorrect URI.  In this case _migrateuri_ should be
  explicitly specified, using an IP address, or a correct hostname.
* ·  
  The host has multiple network interfaces.  If a host has multiple network
  interfaces, it might be desirable for the migration data stream to be sent over
  a specific interface for either security or performance reasons.  In this case
  _migrateuri_ should be explicitly specified, using an IP address associated
  with the network to be used.
* ·  
  The firewall restricts what ports are available.  When libvirt generates a
  migration URI, it will pick a port number using hypervisor specific rules.
  Some hypervisors only require a single port to be open in the firewalls, while
  others require a whole range of port numbers.  In the latter case _migrateuri_
  might be specified to choose a specific port number outside the default range in
  order to comply with local firewall policies.
  .UNINDENT

See _https://libvirt.org/migration.html#uris_ for more details on
migration URIs.

Optional _graphicsuri_ overrides connection parameters used for automatically
reconnecting a graphical clients at the end of migration. If omitted, libvirt
will compute the parameters based on target host IP address. In case the
client does not have a direct access to the network virtualization hosts are
connected to and needs to connect through a proxy, _graphicsuri_ may be used
to specify the address the client should connect to. The URI is formed as
follows:
.INDENT 0.0
.INDENT 3.5

    .ft C
    protocol://hostname[:port]/[?parameters]
    .ft P
.UNINDENT
.UNINDENT

where protocol is either "spice" or "vnc" and parameters is a list of protocol
specific parameters separated by '&'. Currently recognized parameters are
"tlsPort" and "tlsSubject". For example,
.INDENT 0.0
.INDENT 3.5

    .ft C
    spice://target.host.com:1234/?tlsPort=4567
    .ft P
.UNINDENT
.UNINDENT

Optional _listen-address_ sets the listen address that hypervisor on the
destination side should bind to for incoming migration. Both IPv4 and IPv6
addresses are accepted as well as hostnames (the resolving is done on
destination). Some hypervisors do not support this feature and will return an
error if this parameter is used.

Optional _disks-port_ sets the port that hypervisor on destination side should
bind to for incoming disks traffic. Currently it is supported only by QEMU.

<a name="migrate-compcache"></a>

### migrate\-compcache


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    migrate-compcache domain [--size bytes]
    .ft P
.UNINDENT
.UNINDENT

Sets and/or gets size of the cache (in bytes) used for compressing repeatedly
transferred memory pages during live migration. When called without _size_,
the command just prints current size of the compression cache. When _size_
is specified, the hypervisor is asked to change compression cache to _size_
bytes and then the current size is printed (the result may differ from the
requested size due to rounding done by the hypervisor). The _size_ option
is supposed to be used while the domain is being live-migrated as a reaction
to migration progress and increasing number of compression cache misses
obtained from domjobinfo.

<a name="migrate-getmaxdowntime"></a>

### migrate\-getmaxdowntime


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    migrate-getmaxdowntime domain
    .ft P
.UNINDENT
.UNINDENT

Get the maximum tolerable downtime for a domain which is being live-migrated to
another host.  This is the number of milliseconds the guest is allowed
to be down at the end of live migration.

<a name="migrate-getspeed"></a>

### migrate\-getspeed


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    migrate-getspeed domain [--postcopy]
    .ft P
.UNINDENT
.UNINDENT

Get the maximum migration bandwidth (in MiB/s) for a domain. If the
_--postcopy_ option is specified, the command will get the maximum bandwidth
allowed during a post-copy migration phase.

<a name="migrate-postcopy"></a>

### migrate\-postcopy


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    migrate-postcopy domain
    .ft P
.UNINDENT
.UNINDENT

Switch the current migration from pre-copy to post-copy. This is only
supported for a migration started with _--postcopy_ option.

<a name="migrate-setmaxdowntime"></a>

### migrate\-setmaxdowntime


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    migrate-setmaxdowntime domain downtime
    .ft P
.UNINDENT
.UNINDENT

Set maximum tolerable downtime for a domain which is being live-migrated to
another host.  The _downtime_ is a number of milliseconds the guest is allowed
to be down at the end of live migration.

<a name="migrate-setspeed"></a>

### migrate\-setspeed


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    migrate-setspeed domain bandwidth [--postcopy]
    .ft P
.UNINDENT
.UNINDENT

Set the maximum migration bandwidth (in MiB/s) for a domain which is being
migrated to another host. _bandwidth_ is interpreted as an unsigned long
long value. Specifying a negative value results in an essentially unlimited
value being provided to the hypervisor. The hypervisor can choose whether to
reject the value or convert it to the maximum value allowed. If the
_--postcopy_ option is specified, the command will set the maximum bandwidth
allowed during a post-copy migration phase.

<a name="numatune"></a>

### numatune


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    numatune domain [--mode mode] [--nodeset nodeset]
       [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Set or get a domain's numa parameters, corresponding to the &lt;numatune&gt;
element of domain XML.  Without flags, the current settings are
displayed.

_mode_ can be one of \`strict', \`interleave' and \`preferred' or any
valid number from the virDomainNumatuneMemMode enum in case the daemon
supports it.  For a running domain, the mode can't be changed, and the
nodeset can be changed only if the domain was started with a mode of
\`strict'.

_nodeset_ is a list of numa nodes used by the host for running the domain.
Its syntax is a comma separated list, with '-' for ranges and '^' for
excluding a node.

If _--live_ is specified, set scheduler information of a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.

For running guests in Linux hosts, the changes made in the domain's
numa parameters does not imply that the guest memory will be moved to a
different nodeset immediately. The memory migration depends on the
guest activity, and the memory of an idle guest will remain in its
previous nodeset for longer. The presence of VFIO devices will also
lock parts of the guest memory in the same nodeset used to start the
guest, regardless of nodeset changes.

<a name="perf"></a>

### perf


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    perf domain [--enable eventSpec] [--disable eventSpec]
       [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Get the current perf events setting or enable/disable specific perf
events for a guest domain.

Perf is a performance analyzing tool in Linux, and it can instrument
CPU performance counters, tracepoints, kprobes, and uprobes (dynamic
tracing). Perf supports a list of measurable events, and can measure
events coming from different sources. For instance, some event are
pure kernel counters, in this case they are called software events,
including context-switches, minor-faults, etc.. Now dozens of events
from different sources can be supported by perf.

Currently only QEMU/KVM supports this command. The _--enable_ and _--disable_
option combined with **eventSpec** can be used to enable or disable specific
performance event. **eventSpec** is a string list of one or more events
separated by commas. Valid event names are as follows:

**Valid perf event names**
.INDENT 0.0

* ·  
  **cmt** - A PQos (Platform Qos) feature to monitor the
  usage of cache by applications running on the platform.
* ·  
  **mbmt** - Provides a way to monitor the total system
  memory bandwidth between one level of cache and another.
* ·  
  **mbml** - Provides a way to limit the amount of data
  (bytes/s) send through the memory controller on the socket.
* ·  
  **cache\_misses** - Provides the count of cache misses by
  applications running on the platform.
* ·  
  **cache\_references** - Provides the count of cache hits by
  applications running on th e platform.
* ·  
  **instructions** - Provides the count of instructions executed
  by applications running on the platform.
* ·  
  **cpu\_cycles** - Provides the count of cpu cycles
  (total/elapsed). May be used with instructions in order to get
  a cycles per instruction.
* ·  
  **branch\_instructions** - Provides the count of branch instructions
  executed by applications running on the platform.
* ·  
  **branch\_misses** - Provides the count of branch misses executed
  by applications running on the platform.
* ·  
  **bus\_cycles** - Provides the count of bus cycles executed
  by applications running on the platform.
* ·  
  **stalled\_cycles\_frontend** - Provides the count of stalled cpu
  cycles in the frontend of the instruction processor pipeline by
  applications running on the platform.
* ·  
  **stalled\_cycles\_backend** - Provides the count of stalled cpu
  cycles in the backend of the instruction processor pipeline by
  applications running on the platform.
* ·  
  **ref\_cpu\_cycles** -  Provides the count of total cpu cycles
  not affected by CPU frequency scaling by applications running
  on the platform.
* ·  
  **cpu\_clock** - Provides the cpu clock time consumed by
  applications running on the platform.
* ·  
  **task\_clock** - Provides the task clock time consumed by
  applications running on the platform.
* ·  
  **page\_faults** - Provides the count of page faults by
  applications running on the platform.
* ·  
  **context\_switches** - Provides the count of context switches
  by applications running on the platform.
* ·  
  **cpu\_migrations** - Provides the count cpu migrations by
  applications running on the platform.
* ·  
  **page\_faults\_min** - Provides the count minor page faults
  by applications running on the platform.
* ·  
  **page\_faults\_maj** - Provides the count major page faults
  by applications running on the platform.
* ·  
  **alignment\_faults** - Provides the count alignment faults
  by applications running on the platform.
* ·  
  **emulation\_faults** - Provides the count emulation faults
  by applications running on the platform.
  .UNINDENT

**Note**: The statistics can be retrieved using the **domstats** command using
the _--perf_ flag.

If _--live_ is specified, affect a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. If no flag is specified, behavior is different depending
on hypervisor.

<a name="reboot"></a>

### reboot


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    reboot domain [--mode MODE-LIST]
    .ft P
.UNINDENT
.UNINDENT

Reboot a domain.  This acts just as if the domain had the **reboot**
command run from the console.  The command returns as soon as it has
executed the reboot action, which may be significantly before the
domain actually reboots.

The exact behavior of a domain when it reboots is set by the
_on\_reboot_ parameter in the domain's XML definition.

By default the hypervisor will try to pick a suitable shutdown
method. To specify an alternative method, the _--mode_ parameter
can specify a comma separated list which includes **acpi**, **agent**,
**initctl**, **signal** and **paravirt**. The order in which drivers will
try each mode is undefined, and not related to the order specified to virsh.
For strict control over ordering, use a single mode at a time and
repeat the command.

<a name="reset"></a>

### reset


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    reset domain
    .ft P
.UNINDENT
.UNINDENT

Reset a domain immediately without any guest shutdown. **reset**
emulates the power reset button on a machine, where all guest
hardware sees the RST line set and reinitializes internal state.

**Note**: Reset without any guest OS shutdown risks data loss.

<a name="restore"></a>

### restore


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    restore state-file [--bypass-cache] [--xml file]
       [{--running | --paused}]
    .ft P
.UNINDENT
.UNINDENT

Restores a domain from a **virsh save** state file. See _save_ for more info.

If _--bypass-cache_ is specified, the restore will avoid the file system
cache, although this may slow down the operation.

_--xml_ **file** is usually omitted, but can be used to supply an
alternative XML file for use on the restored guest with changes only
in the host-specific portions of the domain XML.  For example, it can
be used to account for file naming differences in underlying storage
due to disk snapshots taken after the guest was saved.

Normally, restoring a saved image will use the state recorded in the
save image to decide between running or paused; passing either the
_--running_ or _--paused_ flag will allow overriding which state the
domain should be started in.

**Note**: To avoid corrupting file system contents within the domain, you
should not reuse the saved state file for a second **restore** unless you
have also reverted all storage volumes back to the same contents as when
the state file was created.

<a name="resume"></a>

### resume


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    resume domain
    .ft P
.UNINDENT
.UNINDENT

Moves a domain out of the suspended state.  This will allow a previously
suspended domain to now be eligible for scheduling by the underlying
hypervisor.

<a name="save"></a>

### save


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    save domain state-file [--bypass-cache] [--xml file]
       [{--running | --paused}] [--verbose]
    .ft P
.UNINDENT
.UNINDENT

Saves a running domain (RAM, but not disk state) to a state file so that
it can be restored
later.  Once saved, the domain will no longer be running on the
system, thus the memory allocated for the domain will be free for
other domains to use.  **virsh restore** restores from this state file.
If _--bypass-cache_ is specified, the save will avoid the file system
cache, although this may slow down the operation.

The progress may be monitored using **domjobinfo** virsh command and canceled
with **domjobabort** command (sent by another virsh instance). Another option
is to send SIGINT (usually with **Ctrl-C**) to the virsh process running
**save** command. _--verbose_ displays the progress of save.

This is roughly equivalent to doing a hibernate on a running computer,
with all the same limitations.  Open network connections may be
severed upon restore, as TCP timeouts may have expired.

_--xml_ **file** is usually omitted, but can be used to supply an
alternative XML file for use on the restored guest with changes only
in the host-specific portions of the domain XML.  For example, it can
be used to account for file naming differences that are planned to
be made via disk snapshots of underlying storage after the guest is saved.

Normally, restoring a saved image will decide between running or paused
based on the state the domain was in when the save was done; passing
either the _--running_ or _--paused_ flag will allow overriding which
state the **restore** should use.

Domain saved state files assume that disk images will be unchanged
between the creation and restore point.  For a more complete system
restore point, where the disk state is saved alongside the memory
state, see the **snapshot** family of commands.

<a name="save-image-define"></a>

### save\-image\-define


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    save-image-define file xml [{--running | --paused}]
    .ft P
.UNINDENT
.UNINDENT

Update the domain XML that will be used when _file_ is later
used in the **restore** command.  The _xml_ argument must be a file
name containing the alternative XML, with changes only in the
host-specific portions of the domain XML.  For example, it can
be used to account for file naming differences resulting from creating
disk snapshots of underlying storage after the guest was saved.

The save image records whether the domain should be restored to a
running or paused state.  Normally, this command does not alter the
recorded state; passing either the _--running_ or _--paused_ flag
will allow overriding which state the **restore** should use.

<a name="save-image-dumpxml"></a>

### save\-image\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    save-image-dumpxml file [--security-info]
    .ft P
.UNINDENT
.UNINDENT

Extract the domain XML that was in effect at the time the saved state
file _file_ was created with the **save** command.  Using
_--security-info_ will also include security sensitive information.

<a name="save-image-edit"></a>

### save\-image\-edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    save-image-edit file [{--running | --paused}]
    .ft P
.UNINDENT
.UNINDENT

Edit the XML configuration associated with a saved state file _file_
created by the **save** command.

The save image records whether the domain should be restored to a
running or paused state.  Normally, this command does not alter the
recorded state; passing either the _--running_ or _--paused_ flag
will allow overriding which state the **restore** should use.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh save-image-dumpxml state-file > state-file.xml
    vi state-file.xml (or make changes with your other text editor)
    virsh save-image-define state-file state-file-xml
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

<a name="schedinfo"></a>

### schedinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    schedinfo domain [[--config] [--live] | [--current]] [[--set] parameter=value]...
    schedinfo [--weight number] [--cap number] domain
    .ft P
.UNINDENT
.UNINDENT

Allows you to show (and set) the domain scheduler parameters. The parameters
available for each hypervisor are:

LXC (posix scheduler) : cpu_shares, vcpu_period, vcpu_quota

QEMU/KVM (posix scheduler): cpu_shares, vcpu_period, vcpu_quota,
emulator_period, emulator_quota, iothread_quota, iothread_period

Xen (credit scheduler): weight, cap

ESX (allocation scheduler): reservation, limit, shares

If _--live_ is specified, set scheduler information of a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.

**Note**: The cpu_shares parameter has a valid value range of 0-262144; Negative
values are wrapped to positive, and larger values are capped at the maximum.
Therefore, -1 is a useful shorthand for 262144. On the Linux kernel, the
values 0 and 1 are automatically converted to a minimal value of 2.

**Note**: The weight and cap parameters are defined only for the
XEN_CREDIT scheduler.

**Note**: The vcpu_period, emulator_period, and iothread_period parameters
have a valid value range of 1000-1000000 or 0, and the vcpu_quota,
emulator_quota, and iothread_quota parameters have a valid value range of
1000-18446744073709551 or less than 0. The value 0 for
either parameter is the same as not specifying that parameter.

<a name="screenshot"></a>

### screenshot


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    screenshot domain [imagefilepath] [--screen screenID]
    .ft P
.UNINDENT
.UNINDENT

Takes a screenshot of a current domain console and stores it into a file.
Optionally, if the hypervisor supports more displays for a domain, _screenID_
allows specifying which screen will be captured. It is the sequential number
of screen. In case of multiple graphics cards, heads are enumerated before
devices, e.g. having two graphics cards, both with four heads, screen ID 5
addresses the second head on the second card.

<a name="send-key"></a>

### send\-key


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    send-key domain [--codeset codeset] [--holdtime holdtime] keycode...
    .ft P
.UNINDENT
.UNINDENT

Parse the _keycode_ sequence as keystrokes to send to _domain_.
Each _keycode_ can either be a numeric value or a symbolic name from
the corresponding codeset.  If _--holdtime_ is given, each keystroke
will be held for that many milliseconds.  The default codeset is
**linux**, but use of the _--codeset_ option allows other codesets to
be chosen.

If multiple keycodes are specified, they are all sent simultaneously
to the guest, and they may be received in random order. If you need
distinct keypresses, you must use multiple send-key invocations.
.INDENT 0.0

* ·  
  **linux**

The numeric values are those defined by the Linux generic input
event subsystem. The symbolic names match the corresponding
Linux key constant macro names.

See virkeycode-linux(7) and virkeyname-linux(7)

* ·  
  **xt**

The numeric values are those defined by the original XT keyboard
controller. No symbolic names are provided

See virkeycode-xt(7)

* ·  
  **atset1**

The numeric values are those defined by the AT keyboard controller,
set 1 (aka XT compatible set). Extended keycoes from **atset1**
may differ from extended keycodes in the **xt** codeset. No symbolic
names are provided

See virkeycode-atset1(7)

* ·  
  **atset2**

The numeric values are those defined by the AT keyboard controller,
set 2. No symbolic names are provided

See virkeycode-atset2(7)

* ·  
  **atset3**

The numeric values are those defined by the AT keyboard controller,
set 3 (aka PS/2 compatible set). No symbolic names are provided

See virkeycode-atset3(7)

* ·  
  **os\_x**

The numeric values are those defined by the macOS keyboard input
subsystem. The symbolic names match the corresponding macOS key
constant macro names

See virkeycode-osx(7) and virkeyname-osx(7)

* ·  
  **xt\_kbd**

The numeric values are those defined by the Linux KBD device.
These are a variant on the original XT codeset, but often with
different encoding for extended keycodes. No symbolic names are
provided.

See virkeycode-xtkbd(7)

* ·  
  **win32**

The numeric values are those defined by the Win32 keyboard input
subsystem. The symbolic names match the corresponding Win32 key
constant macro names

See virkeycode-win32(7) and virkeyname-win32(7)

* ·  
  **usb**

The numeric values are those defined by the USB HID specification
for keyboard input. No symbolic names are provided

See virkeycode-usb(7)

* ·  
  **qnum**

The numeric values are those defined by the QNUM extension for sending
raw keycodes. These are a variant on the XT codeset, but extended
keycodes have the low bit of the second byte set, instead of the high
bit of the first byte. No symbolic names are provided.

See virkeycode-qnum(7)
.UNINDENT

**Examples:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    # send three strokes 'k', 'e', 'y', using xt codeset. these
    # are all pressed simultaneously and may be received by the guest
    # in random order
    virsh send-key dom --codeset xt 37 18 21
    
    # send one stroke 'right-ctrl+C'
    virsh send-key dom KEY_RIGHTCTRL KEY_C
    
    # send a tab, held for 1 second
    virsh send-key --holdtime 1000 0xf
    .ft P
.UNINDENT
.UNINDENT

<a name="send-process-signal"></a>

### send\-process\-signal


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    send-process-signal domain-id pid signame
    .ft P
.UNINDENT
.UNINDENT

Send a signal _signame_ to the process identified by _pid_ running in
the virtual domain _domain-id_. The _pid_ is a process ID in the virtual
domain namespace.

The _signame_ argument may be either an integer signal constant number,
or one of the symbolic names:
.INDENT 0.0
.INDENT 3.5

    .ft C
    "nop", "hup", "int", "quit", "ill",
    "trap", "abrt", "bus", "fpe", "kill",
    "usr1", "segv", "usr2", "pipe", "alrm",
    "term", "stkflt", "chld", "cont", "stop",
    "tstp", "ttin", "ttou", "urg", "xcpu",
    "xfsz", "vtalrm", "prof", "winch", "poll",
    "pwr", "sys", "rt0", "rt1", "rt2", "rt3",
    "rt4", "rt5", "rt6", "rt7", "rt8", "rt9",
    "rt10", "rt11", "rt12", "rt13", "rt14", "rt15",
    "rt16", "rt17", "rt18", "rt19", "rt20", "rt21",
    "rt22", "rt23", "rt24", "rt25", "rt26", "rt27",
    "rt28", "rt29", "rt30", "rt31", "rt32"
    .ft P
.UNINDENT
.UNINDENT

The symbol name may optionally be prefixed with **sig** or **sig\_** and
may be in uppercase or lowercase.

**Examples:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh send-process-signal myguest 1 15
    virsh send-process-signal myguest 1 term
    virsh send-process-signal myguest 1 sigterm
    virsh send-process-signal myguest 1 SIG_HUP
    .ft P
.UNINDENT
.UNINDENT

<a name="set-lifecycle-action"></a>

### set\-lifecycle\-action


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    set-lifecycle-action domain type action
       [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Set the lifecycle _action_ for specified lifecycle _type_.
The valid types are "poweroff", "reboot" and "crash", and for each of
them valid _action_ is one of "destroy", "restart", "rename-restart",
"preserve".  For _type_ "crash", additional actions "coredump-destroy"
and "coredump-restart" are supported.

<a name="set-user-password"></a>

### set\-user\-password


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    set-user-password domain user password [--encrypted]
    .ft P
.UNINDENT
.UNINDENT

Set the password for the _user_ account in the guest domain.

If _--encrypted_ is specified, the password is assumed to be already
encrypted by the method required by the guest OS.

For QEMU/KVM, this requires the guest agent to be configured
and running.

<a name="setmaxmem"></a>

### setmaxmem


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    setmaxmem domain size [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Change the maximum memory allocation limit for a guest domain.
If _--live_ is specified, affect a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. If no flag is specified, behavior is different depending
on hypervisor.

Some hypervisors such as QEMU/KVM don't support live changes (especially
increasing) of the maximum memory limit.  Even persistent configuration changes
might not be performed with some hypervisors/configuration (e.g. on NUMA enabled
domains on QEMU).  For complex configuration changes use command **edit**
instead).

_size_ is a scaled integer (see **NOTES** above); it defaults to kibibytes
(blocks of 1024 bytes) unless you provide a suffix (and the older option
name _--kilobytes_ is available as a deprecated synonym) .  Libvirt rounds
up to the nearest kibibyte.  Some hypervisors require a larger granularity
than KiB, and requests that are not an even multiple will be rounded up.
For example, vSphere/ESX rounds the parameter up to mebibytes (1024 kibibytes).

<a name="setmem"></a>

### setmem


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    setmem domain size [[--config] [--live] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Change the memory allocation for a guest domain.
If _--live_ is specified, perform a memory balloon of a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. If no flag is specified, behavior is different depending
on hypervisor.

_size_ is a scaled integer (see **NOTES** above); it defaults to kibibytes
(blocks of 1024 bytes) unless you provide a suffix (and the older option
name _--kilobytes_ is available as a deprecated synonym) .  Libvirt rounds
up to the nearest kibibyte.  Some hypervisors require a larger granularity
than KiB, and requests that are not an even multiple will be rounded up.
For example, vSphere/ESX rounds the parameter up to mebibytes (1024 kibibytes).

For Xen, you can only adjust the memory of a running domain if the domain is
paravirtualized or running the PV balloon driver.

For LXC, the value being set is the cgroups value for limit_in_bytes or the
maximum amount of user memory (including file cache). When viewing memory
inside the container, this is the /proc/meminfo "MemTotal" value. When viewing
the value from the host, use the **virsh memtune** command. In order to view
the current memory in use and the maximum value allowed to set memory, use
the **virsh dominfo** command.

<a name="setvcpus"></a>

### setvcpus


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    setvcpus domain count [--maximum] [[--config] [--live] | [--current]] [--guest] [--hotpluggable]
    .ft P
.UNINDENT
.UNINDENT

Change the number of virtual CPUs active in a guest domain.  By default,
this command works on active guest domains.  To change the settings for an
inactive guest domain, use the _--config_ flag.

The _count_ value may be limited by host, hypervisor, or a limit coming
from the original description of the guest domain. For Xen, you can only
adjust the virtual CPUs of a running domain if the domain is paravirtualized.

If the _--config_ flag is specified, the change is made to the stored XML
configuration for the guest domain, and will only take effect when the guest
domain is next started.

If _--live_ is specified, the guest domain must be active, and the change
takes place immediately.  Both the _--config_ and _--live_ flags may be
specified together if supported by the hypervisor.  If this command is run
before the guest has finished booting, the guest may fail to process
the change.

If _--current_ is specified, affect the current guest state.

When no flags are given, the _--live_
flag is assumed and the guest domain must be active.  In this situation it
is up to the hypervisor whether the _--config_ flag is also assumed, and
therefore whether the XML configuration is adjusted to make the change
persistent.

If _--guest_ is specified, then the count of cpus is modified in the guest
instead of the hypervisor. This flag is usable only for live domains
and may require guest agent to be configured in the guest.

To allow adding vcpus to persistent definitions that can be later hotunplugged
after the domain is booted it is necessary to specify the _--hotpluggable_
flag. Vcpus added to live domains supporting vcpu unplug are automatically
marked as hotpluggable.

The _--maximum_ flag controls the maximum number of virtual cpus that can
be hot-plugged the next time the domain is booted.  As such, it must only be
used with the _--config_ flag, and not with the _--live_ or the _--current_
flag. Note that it may not be possible to change the maximum vcpu count if
the processor topology is specified for the guest.

<a name="setvcpu"></a>

### setvcpu


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    setvcpu domain vcpulist [--enable] | [--disable]
       [[--live] [--config] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Change state of individual vCPUs using hot(un)plug mechanism.

See **vcpupin** for information on format of _vcpulist_. Hypervisor drivers may
require that _vcpulist_ contains exactly vCPUs belonging to one hotpluggable
entity. This is usually just a single vCPU but certain architectures such as
ppc64 require a full core to be specified at once.

Note that hypervisors may refuse to disable certain vcpus such as vcpu 0 or
others.

If _--live_ is specified, affect a running domain.
If _--config_ is specified, affect the next startup of a persistent domain.
If _--current_ is specified, affect the current domain state. This is the
default. Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive.

<a name="shutdown"></a>

### shutdown


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    shutdown domain [--mode MODE-LIST]
    .ft P
.UNINDENT
.UNINDENT

Gracefully shuts down a domain.  This coordinates with the domain OS
to perform graceful shutdown, so there is no guarantee that it will
succeed, and may take a variable length of time depending on what
services must be shutdown in the domain.

The exact behavior of a domain when it shuts down is set by the
_on\_poweroff_ parameter in the domain's XML definition.

If _domain_ is transient, then the metadata of any snapshots and
checkpoints will be lost once the guest stops running, but the underlying
contents still exist, and a new domain with the same name and UUID can
restore the snapshot metadata with **snapshot-create**, and the checkpoint
metadata with **checkpoint-create**.

By default the hypervisor will try to pick a suitable shutdown
method. To specify an alternative method, the _--mode_ parameter
can specify a comma separated list which includes **acpi**, **agent**,
**initctl**, **signal** and **paravirt**. The order in which drivers will
try each mode is undefined, and not related to the order specified to virsh.
For strict control over ordering, use a single mode at a time and
repeat the command.

<a name="start"></a>

### start


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    start domain-name-or-uuid [--console] [--paused]
       [--autodestroy] [--bypass-cache] [--force-boot]
       [--pass-fds N,M,...]
    .ft P
.UNINDENT
.UNINDENT

Start a (previously defined) inactive domain, either from the last
**managedsave** state, or via a fresh boot if no managedsave state is
present.  The domain will be paused if the _--paused_ option is
used and supported by the driver; otherwise it will be running.
If _--console_ is requested, attach to the console after creation.
If _--autodestroy_ is requested, then the guest will be automatically
destroyed when virsh closes its connection to libvirt, or otherwise
exits.  If _--bypass-cache_ is specified, and managedsave state exists,
the restore will avoid the file system cache, although this may slow
down the operation.  If _--force-boot_ is specified, then any
managedsave state is discarded and a fresh boot occurs.

If _--pass-fds_ is specified, the argument is a comma separated list
of open file descriptors which should be pass on into the guest. The
file descriptors will be re-numbered in the guest, starting from 3. This
is only supported with container based virtualization.

<a name="suspend"></a>

### suspend


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    suspend domain
    .ft P
.UNINDENT
.UNINDENT

Suspend a running domain. It is kept in memory but won't be scheduled
anymore.

<a name="ttyconsole"></a>

### ttyconsole


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    ttyconsole domain
    .ft P
.UNINDENT
.UNINDENT

Output the device used for the TTY console of the domain. If the information
is not available the processes will provide an exit code of 1.

<a name="undefine"></a>

### undefine


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    undefine domain [--managed-save] [--snapshots-metadata]
       [--checkpoints-metadata] [--nvram] [--keep-nvram]
       [ {--storage volumes | --remove-all-storage
          [--delete-storage-volume-snapshots]} --wipe-storage]
    .ft P
.UNINDENT
.UNINDENT

Undefine a domain. If the domain is running, this converts it to a
transient domain, without stopping it. If the domain is inactive,
the domain configuration is removed.

The _--managed-save_ flag guarantees that any managed save image (see
the **managedsave** command) is also cleaned up.  Without the flag, attempts
to undefine a domain with a managed save image will fail.

The _--snapshots-metadata_ flag guarantees that any snapshots (see the
**snapshot-list** command) are also cleaned up when undefining an inactive
domain.  Without the flag, attempts to undefine an inactive domain with
snapshot metadata will fail.  If the domain is active, this flag is
ignored.

The _--checkpoints-metadata_ flag guarantees that any checkpoints (see the
**checkpoint-list** command) are also cleaned up when undefining an inactive
domain.  Without the flag, attempts to undefine an inactive domain with
checkpoint metadata will fail.  If the domain is active, this flag is
ignored.

_--nvram_ and _--keep-nvram_ specify accordingly to delete or keep nvram
(/domain/os/nvram/) file. If the domain has an nvram file and the flags are
omitted, the undefine will fail.

The _--storage_ flag takes a parameter **volumes**, which is a comma separated
list of volume target names or source paths of storage volumes to be removed
along with the undefined domain. Volumes can be undefined and thus removed only
on inactive domains. Volume deletion is only attempted after the domain is
undefined; if not all of the requested volumes could be deleted, the
error message indicates what still remains behind. If a volume path is not
found in the domain definition, it's treated as if the volume was successfully
deleted. Only volumes managed by libvirt in storage pools can be removed this
way.
(See **domblklist** for list of target names associated to a domain).
Example: --storage vda,/path/to/storage.img

The _--remove-all-storage_ flag specifies that all of the domain's storage
volumes should be deleted.

The _--delete-storage-volume-snapshots_ (previously _--delete-snapshots_)
flag specifies that any snapshots associated with
the storage volume should be deleted as well. Requires the
_--remove-all-storage_ flag to be provided. Not all storage drivers
support this option, presently only rbd. Using this when also removing volumes
handled by a storage driver which does not support the flag will result in
failure.

The flag _--wipe-storage_ specifies that the storage volumes should be
wiped before removal.

NOTE: For an inactive domain, the domain name or UUID must be used as the
_domain_.

<a name="vcpucount"></a>

### vcpucount


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vcpucount domain  [{--maximum | --active}
       {--config | --live | --current}] [--guest]
    .ft P
.UNINDENT
.UNINDENT

Print information about the virtual cpu counts of the given
_domain_.  If no flags are specified, all possible counts are
listed in a table; otherwise, the output is limited to just the
numeric value requested.  For historical reasons, the table
lists the label "current" on the rows that can be queried in isolation
via the _--active_ flag, rather than relating to the _--current_ flag.

_--maximum_ requests information on the maximum cap of vcpus that a
domain can add via **setvcpus**, while _--active_ shows the current
usage; these two flags cannot both be specified.  _--config_
requires a persistent domain and requests information regarding the next
time the domain will be booted, _--live_ requires a running domain and
lists current values, and _--current_ queries according to the current
state of the domain (corresponding to _--live_ if running, or
_--config_ if inactive); these three flags are mutually exclusive.

If _--guest_ is specified, then the count of cpus is reported from
the perspective of the guest. This flag is usable only for live domains
and may require guest agent to be configured in the guest.

<a name="vcpuinfo"></a>

### vcpuinfo


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vcpuinfo domain [--pretty]
    .ft P
.UNINDENT
.UNINDENT

Returns basic information about the domain virtual CPUs, like the number of
vCPUs, the running time, the affinity to physical processors.

With _--pretty_, cpu affinities are shown as ranges.

**Example:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ virsh vcpuinfo fedora
    VCPU:           0
    CPU:            0
    State:          running
    CPU time:       7,0s
    CPU Affinity:   yyyy
    
    VCPU:           1
    CPU:            1
    State:          running
    CPU time:       0,7s
    CPU Affinity:   yyyy
    .ft P
.UNINDENT
.UNINDENT

**STATES**

The State field displays the current operating state of a virtual CPU
.INDENT 0.0

* ·  
  **offline**

The virtual CPU is offline and not usable by the domain.
This state is not supported by all hypervisors.

* ·  
  **running**

The virtual CPU is available to the domain and is operating.

* ·  
  **blocked**

The virtual CPU is available to the domain but is waiting for a resource.
This state is not supported by all hypervisors, in which case _running_
may be reported instead.

* ·  
  **no state**

The virtual CPU state could not be determined. This could happen if
the hypervisor is newer than virsh.

* ·  
  **N/A**

There's no information about the virtual CPU state available. This can
be the case if the domain is not running or the hypervisor does
not report the virtual CPU state.
.UNINDENT

<a name="vcpupin"></a>

### vcpupin


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vcpupin domain [vcpu] [cpulist] [[--live] [--config] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Query or change the pinning of domain VCPUs to host physical CPUs.  To
pin a single _vcpu_, specify _cpulist_; otherwise, you can query one
_vcpu_ or omit _vcpu_ to list all at once.

_cpulist_ is a list of physical CPU numbers. Its syntax is a comma
separated list and a special markup using '-' and '^' (ex. '0-4', '0-3,^2') can
also be allowed. The '-' denotes the range and the '^' denotes exclusive.
For pinning the _vcpu_ to all physical cpus specify 'r' as a _cpulist_.
If _--live_ is specified, affect a running guest.
If _--config_ is specified, affect the next boot of a persistent guest.
If _--current_ is specified, affect the current guest state.
Both _--live_ and _--config_ flags may be given if _cpulist_ is present,
but _--current_ is exclusive.
If no flag is specified, behavior is different depending on hypervisor.

**Note**: The expression is sequentially evaluated, so "0-15,^8" is
identical to "9-14,0-7,15" but not identical to "^8,0-15".

<a name="vncdisplay"></a>

### vncdisplay


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vncdisplay domain
    .ft P
.UNINDENT
.UNINDENT

Output the IP address and port number for the VNC display. If the information
is not available the processes will provide an exit code of 1.

<a name="device-commands"></a>

# Device Commands


The following commands manipulate devices associated to domains.
The _domain_ can be specified as a short integer, a name or a full UUID.
To better understand the values allowed as options for the command
reading the documentation at _https://libvirt.org/formatdomain.html_ on the
format of the device sections to get the most accurate set of accepted values.

<a name="attach-device"></a>

### attach\-device


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    attach-device domain FILE [[[--live] [--config] | [--current]] | [--persistent]]
    .ft P
.UNINDENT
.UNINDENT

Attach a device to the domain, using a device definition in an XML
file using a device definition element such as &lt;disk&gt; or &lt;interface&gt;
as the top-level element.  See the documentation at
_https://libvirt.org/formatdomain.html#elementsDevices_ to learn about
libvirt XML format for a device.  If _--config_ is specified the
command alters the persistent domain configuration with the device
attach taking effect the next time libvirt starts the domain.
For cdrom and floppy devices, this command only replaces the media
within an existing device; consider using **update-device** for this
usage.  For passthrough host devices, see also **nodedev-detach**,
needed if the PCI device does not use managed mode.

If _--live_ is specified, affect a running domain.
If _--config_ is specified, affect the next startup of a persistent domain.
If _--current_ is specified, affect the current domain state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. When no flag is specified legacy API is used whose behavior depends
on the hypervisor driver.

For compatibility purposes, _--persistent_ behaves like _--config_ for
an offline domain, and like _--live_ _--config_ for a running domain.

**Note**: using of partial device definition XML files may lead to unexpected
results as some fields may be autogenerated and thus match devices other than
expected.

<a name="attach-disk"></a>

### attach\-disk


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    attach-disk domain source target [[[--live] [--config] |
       [--current]] | [--persistent]] [--targetbus bus]
       [--driver driver] [--subdriver subdriver] [--iothread iothread]
       [--cache cache] [--io io] [--type type] [--alias alias]
       [--mode mode] [--sourcetype sourcetype] [--serial serial]
       [--wwn wwn] [--rawio] [--address address] [--multifunction]
       [--print-xml]
    .ft P
.UNINDENT
.UNINDENT

Attach a new disk device to the domain.
_source_ is path for the files and devices. _target_ controls the bus or
device under which the disk is exposed to the guest OS. It indicates the
"logical" device name; the optional _targetbus_ attribute specifies the type
of disk device to emulate; possible values are driver specific, with typical
values being _ide_, _scsi_, _virtio_, _xen_, _usb_, _sata_, or _sd_, if
omitted, the bus type is inferred from the style of the device name (e.g.  a
device named 'sda' will typically be exported using a SCSI bus).  _driver_ can
be _file_, _tap_ or _phy_ for the Xen
hypervisor depending on the kind of access; or _qemu_ for the QEMU emulator.
Further details to the driver can be passed using _subdriver_. For Xen
_subdriver_ can be _aio_, while for QEMU subdriver should match the format
of the disk source, such as _raw_ or _qcow2_.  Hypervisor default will be
used if _subdriver_ is not specified.  However, the default may not be
correct, esp. for QEMU as for security reasons it is configured not to detect
disk formats.  _type_ can indicate _lun_, _cdrom_ or _floppy_ as
alternative to the disk default, although this use only replaces the media
within the existing virtual cdrom or floppy device; consider using
**update-device** for this usage instead.
_alias_ can set user supplied alias.
_mode_ can specify the two specific mode _readonly_ or _shareable_.
_sourcetype_ can indicate the type of source (block|file)
_cache_ can be one of "default", "none", "writethrough", "writeback",
"directsync" or "unsafe".
_io_ controls specific policies on I/O; QEMU guests support "threads" and "native".
_iothread_ is the number within the range of domain IOThreads to which
this disk may be attached (QEMU only).
_serial_ is the serial of disk device. _wwn_ is the wwn of disk device.
_rawio_ indicates the disk needs rawio capability.
_address_ is the address of disk device in the form of
pci:domain.bus.slot.function, scsi:controller.bus.unit,
ide:controller.bus.unit, usb:bus.port, sata:controller.bus.unit or
ccw:cssid.ssid.devno. Virtio-ccw devices must have their cssid set to 0xfe.
_multifunction_ indicates specified pci address is a multifunction pci device
address.

If _--print-xml_ is specified, then the XML of the disk that would be attached
is printed instead.

If _--live_ is specified, affect a running domain.
If _--config_ is specified, affect the next startup of a persistent domain.
If _--current_ is specified, affect the current domain state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. When no flag is specified legacy API is used whose behavior depends
on the hypervisor driver.

For compatibility purposes, _--persistent_ behaves like _--config_ for
an offline domain, and like _--live_ _--config_ for a running domain.
Likewise, _--shareable_ is an alias for _--mode shareable_.

<a name="attach-interface"></a>

### attach\-interface


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    attach-interface domain type source [[[--live]
       [--config] | [--current]] | [--persistent]]
       [--target target] [--mac mac] [--script script] [--model model]
       [--inbound average,peak,burst,floor] [--outbound average,peak,burst]
       [--alias alias] [--managed] [--print-xml]
    .ft P
.UNINDENT
.UNINDENT

Attach a new network interface to the domain.

**type** can be one of the:

_network_ to indicate connection via a libvirt virtual network,

_bridge_ to indicate connection via a bridge device on the host,

_direct_ to indicate connection directly to one of the host's network
interfaces or bridges,

_hostdev_ to indicate connection using a passthrough of PCI device
on the host.

**source** indicates the source of the connection.  The source depends
on the type of the interface:

_network_ name of the virtual network,

_bridge_ the name of the bridge device,

_direct_ the name of the host's interface or bridge,

_hostdev_ the PCI address of the host's interface formatted
as domain:bus:slot.function.

**--target** is used to specify the tap/macvtap device to be used to
connect the domain to the source.  Names starting with 'vnet' are
considered as auto-generated and are blanked out/regenerated each
time the interface is attached.

**--mac** specifies the MAC address of the network interface; if a MAC
address is not given, a new address will be automatically generated
(and stored in the persistent configuration if "--config" is given on
the command line).

**--script** is used to specify a path to a custom script to be called
while attaching to a bridge - this will be called instead of the default
script not in addition to it.  This is valid only for interfaces of
_bridge_ type and only for Xen domains.

**--model** specifies the network device model to be presented to the
domain.

**alias** can set user supplied alias.

**--inbound** and **--outbound** control the bandwidth of the
interface.  At least one from the _average_, _floor_ pair must be
specified.  The other two _peak_ and _burst_ are optional, so
"average,peak", "average,,burst", "average,,,floor", "average" and
",,,floor" are also legal.  Values for _average_, _floor_ and _peak_
are expressed in kilobytes per second, while _burst_ is expressed in
kilobytes in a single burst at _peak_ speed as described in the
Network XML documentation at
_https://libvirt.org/formatnetwork.html#elementQoS_.

**--managed** is usable only for _hostdev_ type and tells libvirt
that the interface should be managed, which means detached and reattached
from/to the host by libvirt.

If **--print-xml** is specified, then the XML of the interface that would be
attached is printed instead.

If **--live** is specified, affect a running domain.
If **--config** is specified, affect the next startup of a persistent domain.
If **--current** is specified, affect the current domain state.
Both **--live** and **--config** flags may be given, but **--current** is
exclusive.  When no flag is specified legacy API is used whose behavior
depends on the hypervisor driver.

For compatibility purposes, **--persistent** behaves like **--config** for
an offline domain, and like **--live** **--config** for a running domain.

**Note**: the optional target value is the name of a device to be created
as the back-end on the node.  If not provided a device named "vnetN" or "vifN"
will be created automatically.

<a name="detach-device"></a>

### detach\-device


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    detach-device domain FILE [[[--live] [--config] |
       [--current]] | [--persistent]]
    .ft P
.UNINDENT
.UNINDENT

Detach a device from the domain, takes the same kind of XML descriptions
as command **attach-device**.
For passthrough host devices, see also **nodedev-reattach**, needed if
the device does not use managed mode.

**Note**: The supplied XML description of the device should be as specific
as its definition in the domain XML. The set of attributes used
to match the device are internal to the drivers. Using a partial definition,
or attempting to detach a device that is not present in the domain XML,
but shares some specific attributes with one that is present,
may lead to unexpected results.

**Quirk**: Device unplug is asynchronous in most cases and requires guest
cooperation. This means that it's up to the discretion of the guest to disallow
or delay the unplug arbitrarily. As the libvirt API used in this command was
designed as synchronous it returns success after some timeout even if the device
was not unplugged yet to allow further interactions with the domain e.g. if the
guest is unresponsive. Callers which need to make sure that the
device was unplugged can use libvirt events (see virsh event) to be notified
when the device is removed. Note that the event may arrive before the command
returns.

If _--live_ is specified, affect a running domain.
If _--config_ is specified, affect the next startup of a persistent domain.
If _--current_ is specified, affect the current domain state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. When no flag is specified legacy API is used whose behavior depends
on the hypervisor driver.

For compatibility purposes, _--persistent_ behaves like _--config_ for
an offline domain, and like _--live_ _--config_ for a running domain.

Note that older versions of virsh used _--config_ as an alias for
_--persistent_.

<a name="detach-device-alias"></a>

### detach\-device\-alias


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    detach-device-alias domain alias [[[--live] [--config] | [--current]]]]
    .ft P
.UNINDENT
.UNINDENT

Detach a device with given _alias_ from the _domain_. This command returns
successfully after the unplug request was sent to the hypervisor. The actual
removal of the device is notified asynchronously via libvirt events
(see virsh event).

If _--live_ is specified, affect a running domain.
If _--config_ is specified, affect the next startup of a persistent domain.
If _--current_ is specified, affect the current domain state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive.

<a name="detach-disk"></a>

### detach\-disk


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    detach-disk domain target [[[--live] [--config] |
       [--current]] | [--persistent]] [--print-xml]
    .ft P
.UNINDENT
.UNINDENT

Detach a disk device from a domain. The _target_ is the device as seen
from the domain.

If _--live_ is specified, affect a running domain.
If _--config_ is specified, affect the next startup of a persistent domain.
If _--current_ is specified, affect the current domain state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. When no flag is specified legacy API is used whose behavior depends
on the hypervisor driver.

For compatibility purposes, _--persistent_ behaves like _--config_ for
an offline domain, and like _--live_ _--config_ for a running domain.

Note that older versions of virsh used _--config_ as an alias for
_--persistent_.

If **--print-xml** is specified, then the XML which would be used to detach the
disk is printed instead.

Please see documentation for **detach-device** for known quirks.

<a name="detach-interface"></a>

### detach\-interface


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    detach-interface domain type [--mac mac]
       [[[--live] [--config] | [--current]] | [--persistent]]
    .ft P
.UNINDENT
.UNINDENT

Detach a network interface from a domain.
_type_ can be either _network_ to indicate a physical network device or
_bridge_ to indicate a bridge to a device. It is recommended to use the
_mac_ option to distinguish between the interfaces if more than one are
present on the domain.

If _--live_ is specified, affect a running domain.
If _--config_ is specified, affect the next startup of a persistent domain.
If _--current_ is specified, affect the current domain state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. When no flag is specified legacy API is used whose behavior depends
on the hypervisor driver.

For compatibility purposes, _--persistent_ behaves like _--config_ for
an offline domain, and like _--live_ _--config_ for a running domain.

Note that older versions of virsh used _--config_ as an alias for
_--persistent_.

Please see documentation for **detach-device** for known quirks.

<a name="update-device"></a>

### update\-device


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    update-device domain file [--force] [[[--live]
       [--config] | [--current]] | [--persistent]]
    .ft P
.UNINDENT
.UNINDENT

Update the characteristics of a device associated with _domain_,
based on the device definition in an XML _file_.  The _--force_ option
can be used to force device update, e.g., to eject a CD-ROM even if it is
locked/mounted in the domain. See the documentation at
_https://libvirt.org/formatdomain.html#elementsDevices_ to learn about
libvirt XML format for a device.

If _--live_ is specified, affect a running domain.
If _--config_ is specified, affect the next startup of a persistent domain.
If _--current_ is specified, affect the current domain state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. Not specifying any flag is the same as specifying _--current_.

For compatibility purposes, _--persistent_ behaves like _--config_ for
an offline domain, and like _--live_ _--config_ for a running domain.

Note that older versions of virsh used _--config_ as an alias for
_--persistent_.

**Note**: using of partial device definition XML files may lead to unexpected
results as some fields may be autogenerated and thus match devices other than
expected.

<a name="change-media"></a>

### change\-media


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    change-media domain path [--eject] [--insert]
       [--update] [source] [--force] [[--live] [--config] |
       [--current]] [--print-xml] [--block]
    .ft P
.UNINDENT
.UNINDENT

Change media of CDROM or floppy drive. _path_ can be the fully-qualified path
or the unique target name (&lt;target dev='hdc'&gt;) of the disk device. _source_
specifies the path of the media to be inserted or updated. The _--block_ flag
allows setting the backing type in case a block device is used as media for the
CDROM or floppy drive instead of a file.

_--eject_ indicates the media will be ejected.
_--insert_ indicates the media will be inserted. _source_ must be specified.
If the device has source (e.g. &lt;source file='media'&gt;), and _source_ is not
specified, _--update_ is equal to _--eject_. If the device has no source,
and _source_ is specified, _--update_ is equal to _--insert_. If the device
has source, and _source_ is specified, _--update_ behaves like combination
of _--eject_ and _--insert_.
If none of _--eject_, _--insert_, and _--update_ is specified, _--update_
is used by default.
The _--force_ option can be used to force media changing.
If _--live_ is specified, alter live configuration of running guest.
If _--config_ is specified, alter persistent configuration, effect observed
on next boot.
_--current_ can be either or both of _live_ and _config_, depends on
the hypervisor's implementation.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. If no flag is specified, behavior is different depending
on hypervisor.
If _--print-xml_ is specified, the XML that would be used to change media is
printed instead of changing the media.

<a name="nodedev-commands"></a>

# Nodedev Commands


The following commands manipulate host devices that are intended to be
passed through to guest domains via &lt;hostdev&gt; elements in a domain's
&lt;devices&gt; section.  A node device key is generally specified by the bus
name followed by its address, using underscores between all components,
such as pci_0000_00_02_1, usb_1_5_3, or net_eth1_00_27_13_6a_fe_00.
The **nodedev-list** gives the full list of host devices that are known
to libvirt, although this includes devices that cannot be assigned to
a guest (for example, attempting to detach the PCI device that controls
the host's hard disk controller where the guest's disk images live could
cause the host system to lock up or reboot).

For more information on node device definition see:
_https://libvirt.org/formatnode.html_.

Passthrough devices cannot be simultaneously used by the host and its
guest domains, nor by multiple active guests at once.  If the
&lt;hostdev&gt; description of a PCI device includes the attribute **managed='yes'**,
and the hypervisor driver supports it, then the device is in managed mode, and
attempts to use that passthrough device in an active guest will
automatically behave as if **nodedev-detach** (guest start, device
hot-plug) and **nodedev-reattach** (guest stop, device hot-unplug) were
called at the right points.  If a PCI device is not marked as managed,
then it must manually be detached before guests can use it, and manually
reattached to be returned to the host.  Also, if a device is manually detached,
then the host does not regain control of the device without a matching
reattach, even if the guests use the device in managed mode.

<a name="nodedev-create"></a>

### nodedev\-create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodedev-create FILE
    .ft P
.UNINDENT
.UNINDENT

Create a device on the host node that can then be assigned to virtual
machines. Normally, libvirt is able to automatically determine which
host nodes are available for use, but this allows registration of
host hardware that libvirt did not automatically detect.  _file_
contains xml for a top-level &lt;device&gt; description of a node device.

<a name="nodedev-destroy"></a>

### nodedev\-destroy


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodedev-destroy device
    .ft P
.UNINDENT
.UNINDENT

Destroy (stop) a device on the host. _device_ can be either device
name or wwn pair in "wwnn,wwpn" format (only works for vHBA currently).
Note that this makes libvirt quit managing a host device, and may even
make that device unusable by the rest of the physical host until a reboot.

<a name="nodedev-detach"></a>

### nodedev\-detach


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodedev-detach nodedev [--driver backend_driver]
    .ft P
.UNINDENT
.UNINDENT

Detach _nodedev_ from the host, so that it can safely be used by
guests via &lt;hostdev&gt; passthrough.  This is reversed with
**nodedev-reattach**, and is done automatically for managed devices.

Different backend drivers expect the device to be bound to different
dummy devices. For example, QEMU's "kvm" backend driver (the default)
expects the device to be bound to pci-stub, but its "vfio" backend
driver expects the device to be bound to vfio-pci. The _--driver_
parameter can be used to specify the desired backend driver.

<a name="nodedev-dumpxml"></a>

### nodedev\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodedev-dumpxml device
    .ft P
.UNINDENT
.UNINDENT

Dump a &lt;device&gt; XML representation for the given node device, including
such information as the device name, which bus owns the device, the
vendor and product id, and any capabilities of the device usable by
libvirt (such as whether device reset is supported). _device_ can
be either device name or wwn pair in "wwnn,wwpn" format (only works
for HBA).

<a name="nodedev-list"></a>

### nodedev\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodedev-list cap --tree
    .ft P
.UNINDENT
.UNINDENT

List all of the devices available on the node that are known by libvirt.
_cap_ is used to filter the list by capability types, the types must be
separated by comma, e.g. --cap pci,scsi. Valid capability types include
'system', 'pci', 'usb_device', 'usb', 'net', 'scsi_host', 'scsi_target',
'scsi', 'storage', 'fc_host', 'vports', 'scsi_generic', 'drm', 'mdev',
'mdev_types', 'ccw'.
If _--tree_ is used, the output is formatted in a tree representing parents of each
node.  _cap_ and _--tree_ are mutually exclusive.

<a name="nodedev-reattach"></a>

### nodedev\-reattach


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodedev-reattach nodedev
    .ft P
.UNINDENT
.UNINDENT

Declare that _nodedev_ is no longer in use by any guests, and that
the host can resume normal use of the device.  This is done
automatically for PCI devices in managed mode and USB devices, but
must be done explicitly to match any explicit **nodedev-detach**.

<a name="nodedev-reset"></a>

### nodedev\-reset


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodedev-reset nodedev
    .ft P
.UNINDENT
.UNINDENT

Trigger a device reset for _nodedev_, useful prior to transferring
a node device between guest passthrough or the host.  Libvirt will
often do this action implicitly when required, but this command
allows an explicit reset when needed.

<a name="nodedev-event"></a>

### nodedev\-event


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nodedev-event {[nodedev] event [--loop] [--timeout seconds] [--timestamp] | --list}
    .ft P
.UNINDENT
.UNINDENT

Wait for a class of node device events to occur, and print appropriate
details of events as they happen.  The events can optionally be filtered
by _nodedev_.  Using _--list_ as the only argument will provide a list
of possible _event_ values known by this client, although the connection
might not allow registering for all these events.

By default, this command is one-shot, and returns success once an event
occurs; you can send SIGINT (usually via **Ctrl-C**) to quit immediately.
If _--timeout_ is specified, the command gives up waiting for events
after _seconds_ have elapsed.   With _--loop_, the command prints all
events until a timeout or interrupt key.

When _--timestamp_ is used, a human-readable timestamp will be printed
before the event.

<a name="virtual-network-commands"></a>

# Virtual Network Commands


The following commands manipulate networks. Libvirt has the capability to
define virtual networks which can then be used by domains and linked to
actual network devices. For more detailed information about this feature
see the documentation at _https://libvirt.org/formatnetwork.html_ . Many
of the commands for virtual networks are similar to the ones used for domains,
but the way to name a virtual network is either by its name or UUID.

<a name="net-autostart"></a>

### net\-autostart


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-autostart network [--disable]
    .ft P
.UNINDENT
.UNINDENT

Configure a virtual network to be automatically started at boot.
The _--disable_ option disable autostarting.

<a name="net-create"></a>

### net\-create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-create file
    .ft P
.UNINDENT
.UNINDENT

Create a transient (temporary) virtual network from an
XML _file_ and instantiate (start) the network.
See the documentation at _https://libvirt.org/formatnetwork.html_
to get a description of the XML network format used by libvirt.

<a name="net-define"></a>

### net\-define


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-define file
    .ft P
.UNINDENT
.UNINDENT

Define an inactive persistent virtual network or modify an existing persistent
one from the XML _file_.

<a name="net-destroy"></a>

### net\-destroy


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-destroy network
    .ft P
.UNINDENT
.UNINDENT

Destroy (stop) a given transient or persistent virtual network
specified by its name or UUID. This takes effect immediately.

<a name="net-dumpxml"></a>

### net\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-dumpxml network [--inactive]
    .ft P
.UNINDENT
.UNINDENT

Output the virtual network information as an XML dump to stdout.
If _--inactive_ is specified, then physical functions are not
expanded into their associated virtual functions.

<a name="net-edit"></a>

### net\-edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-edit network
    .ft P
.UNINDENT
.UNINDENT

Edit the XML configuration file for a network.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh net-dumpxml --inactive network > network.xml
    vi network.xml (or make changes with your other text editor)
    virsh net-define network.xml
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

<a name="net-event"></a>

### net\-event


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-event {[network] event [--loop] [--timeout seconds] [--timestamp] | --list}
    .ft P
.UNINDENT
.UNINDENT

Wait for a class of network events to occur, and print appropriate details
of events as they happen.  The events can optionally be filtered by
_network_.  Using _--list_ as the only argument will provide a list
of possible _event_ values known by this client, although the connection
might not allow registering for all these events.

By default, this command is one-shot, and returns success once an event
occurs; you can send SIGINT (usually via **Ctrl-C**) to quit immediately.
If _--timeout_ is specified, the command gives up waiting for events
after _seconds_ have elapsed.   With _--loop_, the command prints all
events until a timeout or interrupt key.

When _--timestamp_ is used, a human-readable timestamp will be printed
before the event.

<a name="net-info"></a>

### net\-info


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-info network
    .ft P
.UNINDENT
.UNINDENT

Returns basic information about the _network_ object.

<a name="net-list"></a>

### net\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-list [--inactive | --all]
       { [--table] | --name | --uuid }
       [--persistent] [<--transient>]
       [--autostart] [<--no-autostart>]
    .ft P
.UNINDENT
.UNINDENT

Returns the list of active networks, if _--all_ is specified this will also
include defined but inactive networks, if _--inactive_ is specified only the
inactive ones will be listed. You may also want to filter the returned networks
by _--persistent_ to list the persistent ones, _--transient_ to list the
transient ones, _--autostart_ to list the ones with autostart enabled, and
_--no-autostart_ to list the ones with autostart disabled.

If _--name_ is specified, network names are printed instead of the table
formatted one per line. If _--uuid_ is specified network's UUID's are printed
instead of names. Flag _--table_ specifies that the legacy table-formatted
output should be used. This is the default. All of these are mutually
exclusive.

NOTE: When talking to older servers, this command is forced to use a series of
API calls with an inherent race, where a pool might not be listed or might appear
more than once if it changed state between calls while the list was being
collected.  Newer servers do not have this problem.

<a name="net-name"></a>

### net\-name


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-name network-UUID
    .ft P
.UNINDENT
.UNINDENT

Convert a network UUID to network name.

<a name="net-start"></a>

### net\-start


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-start network
    .ft P
.UNINDENT
.UNINDENT

Start a (previously defined) inactive network.

<a name="net-undefine"></a>

### net\-undefine


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-undefine network
    .ft P
.UNINDENT
.UNINDENT

Undefine the configuration for a persistent network. If the network is active,
make it transient.

<a name="net-uuid"></a>

### net\-uuid


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-uuid network-name
    .ft P
.UNINDENT
.UNINDENT

Convert a network name to network UUID.

<a name="net-update"></a>

### net\-update


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-update network command section xml
       [--parent-index index] [[--live] [--config] | [--current]]
    .ft P
.UNINDENT
.UNINDENT

Update the given section of an existing network definition, with the
changes optionally taking effect immediately, without needing to
destroy and re-start the network.

_command_ is one of "add-first", "add-last", "add" (a synonym for
add-last), "delete", or "modify".

_section_ is one of "bridge", "domain", "ip", "ip-dhcp-host",
"ip-dhcp-range", "forward", "forward-interface", "forward-pf",
"portgroup", "dns-host", "dns-txt", or "dns-srv", each section being
named by a concatenation of the xml element hierarchy leading to the
element being changed. For example, "ip-dhcp-host" will change a
&lt;host&gt; element that is contained inside a &lt;dhcp&gt; element inside an
&lt;ip&gt; element of the network.

_xml_ is either the text of a complete xml element of the type being
changed (e.g. "&lt;host mac="00:11:22:33:44:55' ip='1.2.3.4'/&gt;", or the
name of a file that contains a complete xml element. Disambiguation is
done by looking at the first character of the provided text - if the
first character is "&lt;", it is xml text, if the first character is not
"&lt;", it is the name of a file that contains the xml text to be used.

The _--parent-index_ option is used to specify which of several
parent elements the requested element is in (0-based). For example, a
dhcp &lt;host&gt; element could be in any one of multiple &lt;ip&gt; elements in
the network; if a parent-index isn't provided, the "most appropriate"
&lt;ip&gt; element will be selected (usually the only one that already has a
&lt;dhcp&gt; element), but if _--parent-index_ is given, that particular
instance of &lt;ip&gt; will get the modification.

If _--live_ is specified, affect a running network.
If _--config_ is specified, affect the next startup of a persistent network.
If _--current_ is specified, affect the current network state.
Both _--live_ and _--config_ flags may be given, but _--current_ is
exclusive. Not specifying any flag is the same as specifying _--current_.

<a name="net-dhcp-leases"></a>

### net\-dhcp\-leases


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-dhcp-leases network [mac]
    .ft P
.UNINDENT
.UNINDENT

Get a list of dhcp leases for all network interfaces connected to the given
virtual _network_ or limited output just for one interface if _mac_ is
specified.

<a name="network-port-commands"></a>

# Network Port Commands


The following commands manipulate network ports. Libvirt virtual networks
have ports created when a virtual machine has a virtual network interface
added. In general there should be no need to use any of the commands
here, since the hypervisor drivers run these commands are the right
point in a virtual machine's lifecycle. They can be useful for debugging
problems and / or recovering from bugs / stale state.

<a name="net-port-list"></a>

### net\-port\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-port-list { [--table] | --uuid } network
    .ft P
.UNINDENT
.UNINDENT

List all network ports recorded against the network.

If _--uuid_ is specified network ports' UUID's are printed
instead of a table. Flag _--table_ specifies that the legacy
table-formatted output should be used. This is the default.
All of these are mutually exclusive.

<a name="net-port-create"></a>

### net\-port\-create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-port-create network file
    .ft P
.UNINDENT
.UNINDENT

Allocate a new network port reserving resources based on the
port description.

<a name="net-port-dumpxml"></a>

### net\-port\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-port-dumpxml network port
    .ft P
.UNINDENT
.UNINDENT

Output the network port information as an XML dump to stdout.

<a name="net-port-delete"></a>

### net\-port\-delete


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    net-port-delete network port
    .ft P
.UNINDENT
.UNINDENT

Delete record of the network port and release its resources

<a name="interface-commands"></a>

# Interface Commands


The following commands manipulate host interfaces.  Often, these host
interfaces can then be used by name within domain &lt;interface&gt; elements
(such as a system-created bridge interface), but there is no
requirement that host interfaces be tied to any particular guest
configuration XML at all.

Many of the commands for host interfaces are similar to the ones used
for domains, and the way to name an interface is either by its name or
its MAC address.  However, using a MAC address for an _iface_
argument only works when that address is unique (if an interface and a
bridge share the same MAC address, which is often the case, then using
that MAC address results in an error due to ambiguity, and you must
resort to a name instead).

<a name="iface-bridge"></a>

### iface\-bridge


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-bridge interface bridge [--no-stp] [delay] [--no-start]
    .ft P
.UNINDENT
.UNINDENT

Create a bridge device named _bridge_, and attach the existing
network device _interface_ to the new bridge.  The new bridge
defaults to starting immediately, with STP enabled and a delay of 0;
these settings can be altered with _--no-stp_, _--no-start_, and an
integer number of seconds for _delay_. All IP address configuration
of _interface_ will be moved to the new bridge device.

See also **iface-unbridge** for undoing this operation.

<a name="iface-define"></a>

### iface\-define


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-define file
    .ft P
.UNINDENT
.UNINDENT

Define an inactive persistent physical host interface or modify an existing
persistent one from the XML _file_.

<a name="iface-destroy"></a>

### iface\-destroy


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-destroy interface
    .ft P
.UNINDENT
.UNINDENT

Destroy (stop) a given host interface, such as by running "if-down" to
disable that interface from active use. This takes effect immediately.

<a name="iface-dumpxml"></a>

### iface\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-dumpxml interface [--inactive]
    .ft P
.UNINDENT
.UNINDENT

Output the host interface information as an XML dump to stdout.  If
_--inactive_ is specified, then the output reflects the persistent
state of the interface that will be used the next time it is started.

<a name="iface-edit"></a>

### iface\-edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-edit interface
    .ft P
.UNINDENT
.UNINDENT

Edit the XML configuration file for a host interface.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh iface-dumpxml iface > iface.xml
    vi iface.xml (or make changes with your other text editor)
    virsh iface-define iface.xml
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

<a name="iface-list"></a>

### iface\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-list [--inactive | --all]
    .ft P
.UNINDENT
.UNINDENT

Returns the list of active host interfaces.  If _--all_ is specified
this will also include defined but inactive interfaces.  If
_--inactive_ is specified only the inactive ones will be listed.

<a name="iface-name"></a>

### iface\-name


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-name interface
    .ft P
.UNINDENT
.UNINDENT

Convert a host interface MAC to interface name, if the MAC address is unique
among the host's interfaces.

_interface_ specifies the interface MAC address.

<a name="iface-mac"></a>

### iface\-mac


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-mac interface
    .ft P
.UNINDENT
.UNINDENT

Convert a host interface name to MAC address.

_interface_ specifies the interface name.

<a name="iface-start"></a>

### iface\-start


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-start interface
    .ft P
.UNINDENT
.UNINDENT

Start a (previously defined) host interface, such as by running "if-up".

<a name="iface-unbridge"></a>

### iface\-unbridge


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-unbridge bridge [--no-start]
    .ft P
.UNINDENT
.UNINDENT

Tear down a bridge device named _bridge_, releasing its underlying
interface back to normal usage, and moving all IP address
configuration from the bridge device to the underlying device.  The
underlying interface is restarted unless _--no-start_ is present;
this flag is present for symmetry, but generally not recommended.

See also **iface-bridge** for creating a bridge.

<a name="iface-undefine"></a>

### iface\-undefine


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-undefine interface
    .ft P
.UNINDENT
.UNINDENT

Undefine the configuration for an inactive host interface.

<a name="iface-begin"></a>

### iface\-begin


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-begin
    .ft P
.UNINDENT
.UNINDENT

Create a snapshot of current host interface settings, which can later
be committed (_iface-commit_) or restored (_iface-rollback_).  If a
snapshot already exists, then this command will fail until the
previous snapshot has been committed or restored.  Undefined behavior
results if any external changes are made to host interfaces outside of
the libvirt API between the beginning of a snapshot and its eventual
commit or rollback.

<a name="iface-commit"></a>

### iface\-commit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-commit
    .ft P
.UNINDENT
.UNINDENT

Declare all changes since the last _iface-begin_ as working, and
delete the rollback point.  If no interface snapshot has already been
started, then this command will fail.

<a name="iface-rollback"></a>

### iface\-rollback


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    iface-rollback
    .ft P
.UNINDENT
.UNINDENT

Revert all host interface settings back to the state recorded in the
last _iface-begin_.  If no interface snapshot has already been
started, then this command will fail.  Rebooting the host also serves
as an implicit rollback point.

<a name="storage-pool-commands"></a>

# Storage Pool Commands


The following commands manipulate storage pools. Libvirt has the
capability to manage various storage solutions, including files, raw
partitions, and domain-specific formats, used to provide the storage
volumes visible as devices within virtual machines. For more detailed
information about this feature, see the documentation at
_https://libvirt.org/formatstorage.html_ . Many of the commands for
pools are similar to the ones used for domains.

<a name="find-storage-pool-sources"></a>

### find\-storage\-pool\-sources


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    find-storage-pool-sources type [srcSpec]
    .ft P
.UNINDENT
.UNINDENT

Returns XML describing all possible available storage pool sources that
could be used to create or define a storage pool of a given _type_. If
_srcSpec_ is provided, it is a file that contains XML to further restrict
the query for pools.

Not all storage pools support discovery in this manner. Furthermore, for
those that do support discovery, only specific XML elements are required
in order to return valid data, while other elements and even attributes
of some elements are ignored since they are not necessary to find the pool
based on the search criteria. The following lists the supported _type_
options and the expected minimal XML elements used to perform the search.

For a "netfs" or "gluster" pool, the minimal expected XML required is the
&lt;host&gt; element with a "name" attribute describing the IP address or hostname
to be used to find the pool. The "port" attribute will be ignored as will
any other provided XML elements in _srcSpec_.

For a "logical" pool, the contents of the _srcSpec_ file are ignored,
although if provided the file must at least exist.

For an "iscsi" or "iscsi-direct" pool,
the minimal expect XML required is the &lt;host&gt; element
with a "name" attribute describing the IP address or hostname to be used to
find the pool (the iSCSI server address). Optionally, the "port" attribute
may be provided, although it will default to 3260. Optionally, an &lt;initiator&gt;
XML element with a "name" attribute may be provided to further restrict the
iSCSI target search to a specific initiator for multi-iqn iSCSI storage pools.

<a name="find-pool-sources-as"></a>

### find\-pool\-sources\-as


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    find-storage-pool-sources-as type [host] [port] [initiator]
    .ft P
.UNINDENT
.UNINDENT

Rather than providing _srcSpec_ XML file for **find-storage-pool-sources**
use this command option in order to have virsh generate the query XML file
using the optional arguments. The command will return the same output
XML as **find-storage-pool-sources**.

Use _host_ to describe a specific host to use for networked storage, such
as netfs, gluster, and iscsi _type_ pools.

Use _port_ to further restrict which networked port to utilize for the
connection if required by the specific storage backend, such as iscsi.

Use _initiator_ to further restrict the iscsi _type_ pool searches to
specific target initiators.

<a name="pool-autostart"></a>

### pool\-autostart


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-autostart pool-or-uuid [--disable]
    .ft P
.UNINDENT
.UNINDENT

Configure whether _pool_ should automatically start at boot.

<a name="pool-build"></a>

### pool\-build


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-build pool-or-uuid [--overwrite] [--no-overwrite]
    .ft P
.UNINDENT
.UNINDENT

Build a given pool.

Options _--overwrite_ and _--no-overwrite_ can only be used for
**pool-build** a filesystem, disk, or logical pool.

For a file system pool if neither flag is specified, then **pool-build**
just makes the target path directory and no attempt to run mkfs on the
target volume device. If _--no-overwrite_ is specified, it probes to
determine if a filesystem already exists on the target device, returning
an error if one exists or using mkfs to format the target device if not.
If _--overwrite_ is specified, mkfs is always executed and any existing
data on the target device is overwritten unconditionally.

For a disk pool, if neither of them is specified or _--no-overwrite_
is specified, **pool-build** will check the target volume device for
existing filesystems or partitions before attempting to write a new
label on the target volume device. If the target volume device already
has a label, the command will fail. If _--overwrite_ is specified,
then no check will be made on the target volume device prior to writing
a new label. Writing of the label uses the pool source format type
or "dos" if not specified.

For a logical pool, if neither of them is specified or _--no-overwrite_
is specified, **pool-build** will check the target volume devices for
existing filesystems or partitions before attempting to initialize
and format each device for usage by the logical pool. If any target
volume device already has a label, the command will fail. If
_--overwrite_ is specified, then no check will be made on the target
volume devices prior to initializing and formatting each device. Once
all the target volume devices are properly formatted via pvcreate,
the volume group will be created using all the devices.

<a name="pool-create"></a>

### pool\-create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-create file [--build] [[--overwrite] | [--no-overwrite]]
    .ft P
.UNINDENT
.UNINDENT

Create and start a pool object from the XML _file_.

[_--build_] [[_--overwrite_] | [_--no-overwrite_]] perform a
**pool-build** after creation in order to remove the need for a
follow-up command to build the pool. The _--overwrite_ and
_--no-overwrite_ flags follow the same rules as **pool-build**. If
just _--build_ is provided, then **pool-build** is called with no flags.

<a name="pool-create-as"></a>

### pool\-create\-as


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-create-as name type
       [--source-host hostname] [--source-path path] [--source-dev path]
       [--source-name name] [--target path] [--source-format format]
       [--auth-type authtype --auth-username username
       [--secret-usage usage | --secret-uuid uuid]]
       [--source-protocol-ver ver]
       [[--adapter-name name] | [--adapter-wwnn wwnn --adapter-wwpn wwpn]
       [--adapter-parent parent |
       --adapter-parent-wwnn parent_wwnn adapter-parent-wwpn parent_wwpn |
       --adapter-parent-fabric-wwn parent_fabric_wwn]]
       [--build] [[--overwrite] | [--no-overwrite]] [--print-xml]
    .ft P
.UNINDENT
.UNINDENT

Create and start a pool object _name_ from the raw parameters.  If
_--print-xml_ is specified, then print the XML of the pool object
without creating the pool.  Otherwise, the pool has the specified
_type_. When using **pool-create-as** for a pool of _type_ "disk",
the existing partitions found on the _--source-dev path_ will be used
to populate the disk pool. Therefore, it is suggested to use
**pool-define-as** and **pool-build** with the _--overwrite_ in order
to properly initialize the disk pool.

[_--source-host hostname_] provides the source hostname for pools backed
by storage from a remote server (pool types netfs, iscsi, rbd, sheepdog,
gluster).

[_--source-path path_] provides the source directory path for pools backed
by directories (pool type dir).

[_--source-dev path_] provides the source path for pools backed by physical
devices (pool types fs, logical, disk, iscsi, zfs).

[_--source-name name_] provides the source name for pools backed by storage
from a named element (pool types logical, rbd, sheepdog, gluster).

[_--target path_] is the path for the mapping of the storage pool into
the host file system.

[_--source-format format_] provides information about the format of the
pool (pool types fs, netfs, disk, logical).

[_--auth-type authtype_ _--auth-username username_
[_--secret-usage usage_ | _--secret-uuid uuid_]]
provides the elements required to generate authentication credentials for
the storage pool. The _authtype_ is either chap for iscsi _type_ pools or
ceph for rbd _type_ pools. Either the secret _usage_ or _uuid_ value may
be provided, but not both.

[_--source-protocol-ver ver_] provides the NFS protocol version number used
to contact the server's NFS service via nfs mount option 'nfsvers=n'. It is
expect the _ver_ value is an unsigned integer.

[_--adapter-name name_] defines the scsi_hostN adapter name to be used for
the scsi_host adapter type pool.

[_--adapter-wwnn wwnn_ _--adapter-wwpn wwpn_ [_--adapter-parent parent_ |
_--adapter-parent-wwnn parent\_wwnn_ _adapter-parent-wwpn parent\_wwpn_ |
_--adapter-parent-fabric-wwn parent\_fabric\_wwn_]]
defines the wwnn and wwpn to be used for the fc_host adapter type pool.
Optionally provide the parent scsi_hostN node device to be used for the
vHBA either by parent name, parent_wwnn and parent_wwpn, or parent_fabric_wwn.
The parent name could change between reboots if the hardware environment
changes, so providing the parent_wwnn and parent_wwpn ensure usage of the
same physical HBA even if the scsi_hostN node device changes. Usage of the
parent_fabric_wwn allows a bit more flexibility to choose an HBA on the
same storage fabric in order to define the pool.

[_--build_] [[_--overwrite_] | [_--no-overwrite_]] perform a
**pool-build** after creation in order to remove the need for a
follow-up command to build the pool. The _--overwrite_ and
_--no-overwrite_ flags follow the same rules as **pool-build**. If
just _--build_ is provided, then **pool-build** is called with no flags.

For a "logical" pool only [_--name_] needs to be provided. The
[_--source-name_] if provided must match the Volume Group name.
If not provided, one will be generated using the [_--name_]. If
provided the [_--target_] is ignored and a target source is generated
using the [_--source-name_] (or as generated from the [_--name_]).

<a name="pool-define"></a>

### pool\-define


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-define file
    .ft P
.UNINDENT
.UNINDENT

Define an inactive persistent storage pool or modify an existing persistent one
from the XML _file_.

<a name="pool-define-as"></a>

### pool\-define\-as


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-define-as name type
       [--source-host hostname] [--source-path path] [--source-dev path]
       [*--source-name name*] [*--target path*] [*--source-format format*]
       [*--auth-type authtype* *--auth-username username*
       [*--secret-usage usage* | *--secret-uuid uuid*]]
       [*--source-protocol-ver ver*]
       [[*--adapter-name name*] | [*--adapter-wwnn* *--adapter-wwpn*]
       [*--adapter-parent parent*]] [*--print-xml*]
    .ft P
.UNINDENT
.UNINDENT

Create, but do not start, a pool object _name_ from the raw parameters.  If
_--print-xml_ is specified, then print the XML of the pool object
without defining the pool.  Otherwise, the pool has the specified
_type_.

Use the same arguments as **pool-create-as**, except for the _--build_,
_--overwrite_, and _--no-overwrite_ options.

<a name="pool-destroy"></a>

### pool\-destroy


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-destroy pool-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Destroy (stop) a given _pool_ object. Libvirt will no longer manage the
storage described by the pool object, but the raw data contained in
the pool is not changed, and can be later recovered with
**pool-create**.

<a name="pool-delete"></a>

### pool\-delete


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-delete pool-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Destroy the resources used by a given _pool_ object. This operation
is non-recoverable.  The _pool_ object will still exist after this
command, ready for the creation of new storage volumes.

<a name="pool-dumpxml"></a>

### pool\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-dumpxml [--inactive] pool-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Returns the XML information about the _pool_ object.
_--inactive_ tells virsh to dump pool configuration that will be used
on next start of the pool as opposed to the current pool configuration.

<a name="pool-edit"></a>

### pool\-edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-edit pool-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Edit the XML configuration file for a storage pool.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh pool-dumpxml pool > pool.xml
    vi pool.xml (or make changes with your other text editor)
    virsh pool-define pool.xml
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

<a name="pool-info"></a>

### pool\-info


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-info [--bytes] pool-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Returns basic information about the _pool_ object. If _--bytes_ is specified the sizes
of basic info are not converted to human friendly units.

<a name="pool-list"></a>

### pool\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-list [--inactive] [--all]
       [--persistent] [--transient]
       [--autostart] [--no-autostart]
       [[--details] [--uuid]
       [--name] [<type>]
    .ft P
.UNINDENT
.UNINDENT

List pool objects known to libvirt.  By default, only active pools
are listed; _--inactive_ lists just the inactive pools, and _--all_
lists all pools.

In addition, there are several sets of filtering flags. _--persistent_ is to
list the persistent pools, _--transient_ is to list the transient pools.
_--autostart_ lists the autostarting pools, _--no-autostart_ lists the pools
with autostarting disabled. If _--uuid_ is specified only pool's UUIDs are printed.
If _--name_ is specified only pool's names are printed. If both _--name_
and _--uuid_ are specified, pool's UUID and names are printed side by side
without any header. Option _--details_ is mutually exclusive with options
_--uuid_ and _--name_.

You may also want to list pools with specified types using _type_, the
pool types must be separated by comma, e.g. --type dir,disk. The valid pool
types include 'dir', 'fs', 'netfs', 'logical', 'disk', 'iscsi', 'scsi',
'mpath', 'rbd', 'sheepdog', 'gluster', 'zfs', 'vstorage' and 'iscsi-direct'.

The _--details_ option instructs virsh to additionally
display pool persistence and capacity related information where available.

NOTE: When talking to older servers, this command is forced to use a series of
API calls with an inherent race, where a pool might not be listed or might appear
more than once if it changed state between calls while the list was being
collected.  Newer servers do not have this problem.

<a name="pool-name"></a>

### pool\-name


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-name uuid
    .ft P
.UNINDENT
.UNINDENT

Convert the _uuid_ to a pool name.

<a name="pool-refresh"></a>

### pool\-refresh


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-refresh pool-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Refresh the list of volumes contained in _pool_.

<a name="pool-start"></a>

### pool\-start


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-start pool-or-uuid [--build] [[--overwrite] | [--no-overwrite]]
    .ft P
.UNINDENT
.UNINDENT

Start the storage _pool_, which is previously defined but inactive.

[_--build_] [[_--overwrite_] | [_--no-overwrite_]] perform a
**pool-build** prior to **pool-start** to ensure the pool environment is
in an expected state rather than needing to run the build command prior
to startup. The _--overwrite_ and _--no-overwrite_ flags follow the
same rules as **pool-build**. If just _--build_ is provided, then
**pool-build** is called with no flags.

**Note**: A storage pool that relies on remote resources such as an
"iscsi" or a (v)HBA backed "scsi" pool may need to be refreshed multiple
times in order to have all the volumes detected (see **pool-refresh**).
This is because the corresponding volume devices may not be present in
the host's filesystem during the initial pool startup or the current
refresh attempt. The number of refresh retries is dependent upon the
network connection and the time the host takes to export the
corresponding devices.

<a name="pool-undefine"></a>

### pool\-undefine


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-undefine pool-or-uuid
    .ft P
.UNINDENT
.UNINDENT

Undefine the configuration for an inactive _pool_.

<a name="pool-uuid"></a>

### pool\-uuid


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-uuid pool
    .ft P
.UNINDENT
.UNINDENT

Returns the UUID of the named _pool_.

<a name="pool-event"></a>

### pool\-event


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    pool-event {[pool] event [--loop] [--timeout seconds] [--timestamp] | --list}
    .ft P
.UNINDENT
.UNINDENT

Wait for a class of storage pool events to occur, and print appropriate
details of events as they happen.  The events can optionally be filtered
by _pool_.  Using _--list_ as the only argument will provide a list
of possible _event_ values known by this client, although the connection
might not allow registering for all these events.

By default, this command is one-shot, and returns success once an event
occurs; you can send SIGINT (usually via **Ctrl-C**) to quit immediately.
If _--timeout_ is specified, the command gives up waiting for events
after _seconds_ have elapsed.   With _--loop_, the command prints all
events until a timeout or interrupt key.

When _--timestamp_ is used, a human-readable timestamp will be printed
before the event.

<a name="volume-commands"></a>

# Volume Commands


<a name="vol-create"></a>

### vol\-create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-create pool-or-uuid FILE [--prealloc-metadata]
    .ft P
.UNINDENT
.UNINDENT

Create a volume from an XML &lt;file&gt;.

_pool-or-uuid_ is the name or UUID of the storage pool to create the volume in.

_FILE_ is the XML &lt;file&gt; with the volume definition. An easy way to create the
XML &lt;file&gt; is to use the **vol-dumpxml** command to obtain the definition of a
pre-existing volume.

[_--prealloc-metadata_] preallocate metadata (for qcow2 images which don't
support full allocation). This option creates a sparse image file with metadata,
resulting in higher performance compared to images with no preallocation and
only slightly higher initial disk space usage.

**Example:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh vol-dumpxml --pool storagepool1 appvolume1 > newvolume.xml
    vi newvolume.xml (or make changes with your other text editor)
    virsh vol-create differentstoragepool newvolume.xml
    .ft P
.UNINDENT
.UNINDENT

<a name="vol-create-from"></a>

### vol\-create\-from


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-create-from pool-or-uuid FILE vol-name-or-key-or-path
       [--inputpool pool-or-uuid]  [--prealloc-metadata] [--reflink]
    .ft P
.UNINDENT
.UNINDENT

Create a volume, using another volume as input.

_pool-or-uuid_ is the name or UUID of the storage pool to create the volume in.

_FILE_ is the XML &lt;file&gt; with the volume definition.

_vol-name-or-key-or-path_ is the name or key or path of the source volume.

_--inputpool_ _pool-or-uuid_ is the name or uuid of the storage pool the
source volume is in.

[_--prealloc-metadata_] preallocate metadata (for qcow2 images which don't
support full allocation). This option creates a sparse image file with metadata,
resulting in higher performance compared to images with no preallocation and
only slightly higher initial disk space usage.

When _--reflink_ is specified, perform a COW lightweight copy,
where the data blocks are copied only when modified.
If this is not possible, the copy fails.

<a name="vol-create-as"></a>

### vol\-create\-as


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-create-as pool-or-uuid name capacity [--allocation size] [--format string]
       [--backing-vol vol-name-or-key-or-path]
       [--backing-vol-format string] [--prealloc-metadata] [--print-xml]
    .ft P
.UNINDENT
.UNINDENT

Create a volume from a set of arguments unless _--print-xml_ is specified, in
which case just the XML of the volume object is printed out without any actual
object creation.

_pool-or-uuid_ is the name or UUID of the storage pool to create the volume
in.

_name_ is the name of the new volume. For a disk pool, this must match the
partition name as determined from the pool's source device path and the next
available partition. For example, a source device path of /dev/sdb and there
are no partitions on the disk, then the name must be sdb1 with the next
name being sdb2 and so on.

_capacity_ is the size of the volume to be created, as a scaled integer
(see **NOTES** above), defaulting to bytes if there is no suffix.

_--allocation_ _size_ is the initial size to be allocated in the volume,
also as a scaled integer defaulting to bytes.

_--format_ _string_ is used in file based storage pools to specify the volume
file format to use; raw, bochs, qcow, qcow2, vmdk, qed. Use extended for disk
storage pools in order to create an extended partition (other values are
validity checked but not preserved when libvirtd is restarted or the pool
is refreshed).

_--backing-vol_ _vol-name-or-key-or-path_ is the source backing
volume to be used if taking a snapshot of an existing volume.

_--backing-vol-format_ _string_ is the format of the snapshot backing volume;
raw, bochs, qcow, qcow2, qed, vmdk, host_device. These are, however, meant for
file based storage pools.

[_--prealloc-metadata_] preallocate metadata (for qcow2 images which don't
support full allocation). This option creates a sparse image file with metadata,
resulting in higher performance compared to images with no preallocation and
only slightly higher initial disk space usage.

<a name="vol-clone"></a>

### vol\-clone


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-clone vol-name-or-key-or-path name
       [--pool pool-or-uuid] [--prealloc-metadata] [--reflink]
    .ft P
.UNINDENT
.UNINDENT

Clone an existing volume within the parent pool.  Less powerful,
but easier to type, version of **vol-create-from**.

_vol-name-or-key-or-path_ is the name or key or path of the source volume.

_name_ is the name of the new volume.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool
that contains the source volume and will contain the new volume.
If the source volume name is provided instead of the key or path, then
providing the pool is necessary to find the volume to be cloned; otherwise,
the first volume found by the key or path will be used.

[_--prealloc-metadata_] preallocate metadata (for qcow2 images which don't
support full allocation). This option creates a sparse image file with metadata,
resulting in higher performance compared to images with no preallocation and
only slightly higher initial disk space usage.

When _--reflink_ is specified, perform a COW lightweight copy,
where the data blocks are copied only when modified.
If this is not possible, the copy fails.

<a name="vol-delete"></a>

### vol\-delete


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-delete vol-name-or-key-or-path [--pool pool-or-uuid] [--delete-snapshots]
    .ft P
.UNINDENT
.UNINDENT

Delete a given volume.

_vol-name-or-key-or-path_ is the volume name or key or path of the volume
to delete.

[_--pool_ _pool-or-uuid_] is the name or UUID of the storage pool the volume
is in. If the volume name is provided instead of the key or path, then
providing the pool is necessary to find the volume to be deleted; otherwise,
the first volume found by the key or path will be used.

The _--delete-snapshots_ flag specifies that any snapshots associated with
the storage volume should be deleted as well. Not all storage drivers
support this option, presently only rbd.

<a name="vol-upload"></a>

### vol\-upload


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-upload vol-name-or-key-or-path local-file
       [--pool pool-or-uuid] [--offset bytes]
       [--length bytes] [--sparse]
    .ft P
.UNINDENT
.UNINDENT

Upload the contents of _local-file_ to a storage volume.

_vol-name-or-key-or-path_ is the name or key or path of the volume where the
_local-file_ will be uploaded.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool the volume
is in. If the volume name is provided instead of the key or path, then
providing the pool is necessary to find the volume to be uploaded into;
otherwise, the first volume found by the key or path will be used.

_--offset_ is the position in the storage volume at which to start writing
the data. The value must be 0 or larger.

_--length_ is an upper bound of the amount of data to be uploaded.
A negative value is interpreted as an unsigned long long value to
essentially include everything from the offset to the end of the volume.

If _--sparse_ is specified, this command will preserve volume sparseness.

An error will occur if the _local-file_ is greater than the specified
_length_.

See the description for the libvirt virStorageVolUpload API for details
regarding possible target volume and pool changes as a result of the
pool refresh when the upload is attempted.

<a name="vol-download"></a>

### vol\-download


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-download vol-name-or-key-or-path local-file
       [--pool pool-or-uuid] [--offset bytes] [--length bytes]
       [--sparse]
    .ft P
.UNINDENT
.UNINDENT

Download the contents of a storage volume to _local-file_.

_vol-name-or-key-or-path_ is the name or key or path of the volume to
download into _local-file_.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool the volume
is in. If the volume name is provided instead of the key or path, then
providing the pool is necessary to find the volume to be uploaded into;
otherwise, the first volume found by the key or path will be used.

_--offset_ is the position in the storage volume at which to start reading
the data. The value must be 0 or larger.

_--length_ is an upper bound of the amount of data to be downloaded.
A negative value is interpreted as an unsigned long long value to
essentially include everything from the offset to the end of the volume.

If _--sparse_ is specified, this command will preserve volume sparseness.

<a name="vol-wipe"></a>

### vol\-wipe


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-wipe vol-name-or-key-or-path [--pool pool-or-uuid] [--algorithm algorithm]
    .ft P
.UNINDENT
.UNINDENT

Wipe a volume, ensure data previously on the volume is not accessible to
future reads.

_vol-name-or-key-or-path_ is the name or key or path of the volume to wipe.
It is possible to choose different wiping algorithms instead of re-writing
volume with zeroes.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool the
volume is in. If the volume name is provided instead of the key or path,
then providing the pool is necessary to find the volume to be wiped;
otherwise, the first volume found by the key or path will be used.

Use the _--algorithm_ switch choosing from the list of the following
algorithms in order to define which algorithm to use for the wipe.

**Supported algorithms**
.INDENT 0.0

* ·  
  zero       - 1-pass all zeroes
* ·  
  nnsa       - 4-pass NNSA Policy Letter NAP-14.1-C (XVI-8) for
  sanitizing removable and non-removable hard disks:
  random x2, 0x00, verify.
* ·  
  dod        - 4-pass DoD 5220.22-M section 8-306 procedure for
  sanitizing removable and non-removable rigid
  disks: random, 0x00, 0xff, verify.
* ·  
  bsi        - 9-pass method recommended by the German Center of
  Security in Information Technologies
  (_http://www.bsi.bund.de_): 0xff, 0xfe, 0xfd, 0xfb,
  0xf7, 0xef, 0xdf, 0xbf, 0x7f.
* ·  
  gutmann    - The canonical 35-pass sequence described in
  Gutmann's paper.
* ·  
  schneier   - 7-pass method described by Bruce Schneier in
  "Applied Cryptography" (1996): 0x00, 0xff, random x5.
* ·  
  pfitzner7  - Roy Pfitzner's 7-random-pass method: random x7.
* ·  
  pfitzner33 - Roy Pfitzner's 33-random-pass method: random x33.
* ·  
  random     - 1-pass pattern: random.
* ·  
  trim       - 1-pass trimming the volume using TRIM or DISCARD
  .UNINDENT

**Note**: The **scrub** binary will be used to handle the 'nnsa', 'dod',
'bsi', 'gutmann', 'schneier', 'pfitzner7' and 'pfitzner33' algorithms.
The availability of the algorithms may be limited by the version of
the **scrub** binary installed on the host. The 'zero' algorithm will
write zeroes to the entire volume. For some volumes, such as sparse
or rbd volumes, this may result in completely filling the volume with
zeroes making it appear to be completely full. As an alternative, the
'trim' algorithm does not overwrite all the data in a volume, rather
it expects the storage driver to be able to discard all bytes in a
volume. It is up to the storage driver to handle how the discarding
occurs. Not all storage drivers or volume types can support 'trim'.

<a name="vol-dumpxml"></a>

### vol\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-dumpxml vol-name-or-key-or-path [--pool pool-or-uuid]
    .ft P
.UNINDENT
.UNINDENT

Output the volume information as an XML dump to stdout.

_vol-name-or-key-or-path_ is the name or key or path of the volume
to output the XML.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool the volume
is in. If the volume name is provided instead of the key or path, then
providing the pool is necessary to find the volume to be uploaded into;
otherwise, the first volume found by the key or path will be used.

<a name="vol-info"></a>

### vol\-info


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-info vol-name-or-key-or-path [--pool pool-or-uuid] [--bytes] [--physical]
    .ft P
.UNINDENT
.UNINDENT

Returns basic information about the given storage volume.

_vol-name-or-key-or-path_ is the name or key or path of the volume
to return information for.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool the volume
is in. If the volume name is provided instead of the key or path, then
providing the pool is necessary to find the volume to be uploaded into;
otherwise, the first volume found by the key or path will be used.

If _--bytes_ is specified the sizes are not converted to human friendly
units.

If _--physical_ is specified, then the host physical size is returned
and displayed instead of the allocation value. The physical value for
some file types, such as qcow2 may have a different (larger) physical
value than is shown for allocation. Additionally sparse files will
have different physical and allocation values.

<a name="vol-list"></a>

### vol\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-list [--pool pool-or-uuid] [--details]
    .ft P
.UNINDENT
.UNINDENT

Return the list of volumes in the given storage pool.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool.

The _--details_ option instructs virsh to additionally display volume
type and capacity related information where available.

<a name="vol-pool"></a>

### vol\-pool


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-pool vol-key-or-path [--uuid]
    .ft P
.UNINDENT
.UNINDENT

Return the pool name or UUID for a given volume. By default, the pool name is
returned.

_vol-key-or-path_ is the key or path of the volume to return the pool
information.

If the _--uuid_ option is given, the pool UUID is returned instead.

<a name="vol-path"></a>

### vol\-path


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-path vol-name-or-key [--pool pool-or-uuid]
    .ft P
.UNINDENT
.UNINDENT

Return the path for a given volume.

_vol-name-or-key_ is the name or key of the volume to return the path.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool the volume
is in. If the volume name is provided instead of the key, then providing
the pool is necessary to find the volume to be uploaded into; otherwise,
the first volume found by the key will be used.

<a name="vol-name"></a>

### vol\-name


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-name vol-key-or-path
    .ft P
.UNINDENT
.UNINDENT

Return the name for a given volume.

_vol-key-or-path_ is the key or path of the volume to return the name.

<a name="vol-key"></a>

### vol\-key


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-key vol-name-or-path [--pool pool-or-uuid]
    .ft P
.UNINDENT
.UNINDENT

Return the volume key for a given volume.

_vol-name-or-path_ is the name or path of the volume to return the
volume key.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool the volume
is in. If the volume name is provided instead of the path, then providing
the pool is necessary to find the volume to be uploaded into; otherwise,
the first volume found by the path will be used.

<a name="vol-resize"></a>

### vol\-resize


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    vol-resize vol-name-or-path capacity [--pool pool-or-uuid] [--allocate] [--delta] [--shrink]
    .ft P
.UNINDENT
.UNINDENT

Resize the capacity of the given volume, in bytes.

_vol-name-or-key-or-path_ is the name or key or path of the volume
to resize.

_capacity_ is a scaled integer (see **NOTES** above) for the volume,
which defaults to bytes if there is no suffix.

_--pool_ _pool-or-uuid_ is the name or UUID of the storage pool the volume
is in. If the volume name is provided instead of the key or path, then
providing the pool is necessary to find the volume to be uploaded into;
otherwise, the first volume found by the key or path will be used.

The new _capacity_ might be sparse unless _--allocate_ is specified.

Normally, _capacity_ is the new size, but if _--delta_
is present, then it is added to the existing size.

Attempts to shrink the volume will fail unless _--shrink_ is present.
The _capacity_ cannot be negative unless _--shrink_ is provided, but
a negative sign is not necessary.

This command is only safe for storage volumes not in use by an active
guest; see also **blockresize** for live resizing.

<a name="secret-commands"></a>

# Secret Commands


The following commands manipulate "secrets" (e.g. passwords, passphrases and
encryption keys).  Libvirt can store secrets independently from their use, and
other objects (e.g. volumes or domains) can refer to the secrets for encryption
or possibly other uses.  Secrets are identified using a UUID.  See
_https://libvirt.org/formatsecret.html_ for documentation of the XML format
used to represent properties of secrets.

<a name="secret-define"></a>

### secret\-define


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    secret-define file
    .ft P
.UNINDENT
.UNINDENT

Create a secret with the properties specified in _file_, with no associated
secret value.  If _file_ does not specify a UUID, choose one automatically.
If _file_ specifies a UUID of an existing secret, replace its properties by
properties defined in _file_, without affecting the secret value.

<a name="secret-dumpxml"></a>

### secret\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    secret-dumpxml secret
    .ft P
.UNINDENT
.UNINDENT

Output properties of _secret_ (specified by its UUID) as an XML dump to stdout.

<a name="secret-event"></a>

### secret\-event


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    secret-event {[secret] event [--loop] [--timeout seconds] [--timestamp] | --list}
    .ft P
.UNINDENT
.UNINDENT

Wait for a class of secret events to occur, and print appropriate details
of events as they happen.  The events can optionally be filtered by
_secret_.  Using _--list_ as the only argument will provide a list
of possible _event_ values known by this client, although the connection
might not allow registering for all these events.

By default, this command is one-shot, and returns success once an event
occurs; you can send SIGINT (usually via **Ctrl-C**) to quit immediately.
If _--timeout_ is specified, the command gives up waiting for events
after _seconds_ have elapsed.   With _--loop_, the command prints all
events until a timeout or interrupt key.

When _--timestamp_ is used, a human-readable timestamp will be printed
before the event.

<a name="secret-set-value"></a>

### secret\-set\-value


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    secret-set-value secret (--file filename [--plain] | --interactive | base64)
    .ft P
.UNINDENT
.UNINDENT

Set the value associated with _secret_ (specified by its UUID) to the value
Base64-encoded value _base64_ or Base-64-encoded contents of file named
_filename_. Using the _--plain_ flag is together with _--file_ allows one to
use the file contents directly as the secret value.

If _--interactive_ flag is used the secret value is read as a password from the
terminal.

Note that _--file_, _--interactive_ and _base64_ options are mutually exclusive.

Passing secrets via the _base64_ option on command line is INSECURE and
deprecated. Use the _--file_ option instead.

<a name="secret-get-value"></a>

### secret\-get\-value


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    secret-get-value [--plain] secret
    .ft P
.UNINDENT
.UNINDENT

Output the value associated with _secret_ (specified by its UUID) to stdout,
encoded using Base64.

If the _--plain_ flag is used the value is not base64 encoded, but rather
printed raw. Note that unless virsh is started in quiet mode (_virsh -q_) it
prints a newline at the end of the command. This newline is not part of the
secret.

<a name="secret-undefine"></a>

### secret\-undefine


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    secret-undefine secret
    .ft P
.UNINDENT
.UNINDENT

Delete a _secret_ (specified by its UUID), including the associated value, if
any.

<a name="secret-list"></a>

### secret\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    secret-list [--ephemeral] [--no-ephemeral]
       [--private] [--no-private]
    .ft P
.UNINDENT
.UNINDENT

Returns the list of secrets. You may also want to filter the returned secrets
by _--ephemeral_ to list the ephemeral ones, _--no-ephemeral_ to list the
non-ephemeral ones, _--private_ to list the private ones, and
_--no-private_ to list the non-private ones.

<a name="snapshot-commands"></a>

# Snapshot Commands


The following commands manipulate domain snapshots.  Snapshots take the
disk, memory, and device state of a domain at a point-of-time, and save it
for future use.  They have many uses, from saving a "clean" copy of an OS
image to saving a domain's state before a potentially destructive operation.
Snapshots are identified with a unique name.  See
_https://libvirt.org/formatsnapshot.html_ for documentation of the XML format
used to represent properties of snapshots.

<a name="snapshot-create"></a>

### snapshot\-create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-create domain [xmlfile] {[--redefine [--current]] |
       [--no-metadata] [--halt] [--disk-only] [--reuse-external]
       [--quiesce] [--atomic] [--live]} [--validate]
    .ft P
.UNINDENT
.UNINDENT

Create a snapshot for domain _domain_ with the properties specified in
_xmlfile_.   Optionally, the _--validate_ option can be passed to
validate the format of the input XML file against an internal RNG
schema (identical to using the virt-xml-validate(1) tool). Normally,
the only properties settable for a domain snapshot
are the &lt;name&gt; and &lt;description&gt; elements, as well as &lt;disks&gt; if
_--disk-only_ is given; the rest of the fields are
ignored, and automatically filled in by libvirt.  If _xmlfile_ is
completely omitted, then libvirt will choose a value for all fields.
The new snapshot will become current, as listed by **snapshot-current**.

If _--halt_ is specified, the domain will be left in an inactive state
after the snapshot is created.

If _--disk-only_ is specified, the snapshot will only include disk
content rather than the usual full system snapshot with vm state.  Disk
snapshots are captured faster than full system snapshots, but reverting to a
disk snapshot may require fsck or journal replays, since it is like
the disk state at the point when the power cord is abruptly pulled;
and mixing _--halt_ and _--disk-only_ loses any data that was not
flushed to disk at the time.

If _--redefine_ is specified, then all XML elements produced by
**snapshot-dumpxml** are valid; this can be used to migrate snapshot
hierarchy from one machine to another, to recreate hierarchy for the
case of a transient domain that goes away and is later recreated with
the same name and UUID, or to make slight alterations in the snapshot
metadata (such as host-specific aspects of the domain XML embedded in
the snapshot).  When this flag is supplied, the _xmlfile_ argument
is mandatory, and the domain's current snapshot will not be altered
unless the _--current_ flag is also given.

If _--no-metadata_ is specified, then the snapshot data is created,
but any metadata is immediately discarded (that is, libvirt does not
treat the snapshot as current, and cannot revert to the snapshot
unless _--redefine_ is later used to teach libvirt about the
metadata again).

If _--reuse-external_ is specified, and the snapshot XML requests an
external snapshot with a destination of an existing file, then the
destination must exist and be pre-created with correct format and
metadata. The file is then reused; otherwise, a snapshot is refused
to avoid losing contents of the existing files.

If _--quiesce_ is specified, libvirt will try to use guest agent
to freeze and unfreeze domain's mounted file systems. However,
if domain has no guest agent, snapshot creation will fail.
Currently, this requires _--disk-only_ to be passed as well.

If _--atomic_ is specified, libvirt will guarantee that the snapshot
either succeeds, or fails with no changes; not all hypervisors support
this.  If this flag is not specified, then some hypervisors may fail
after partially performing the action, and **dumpxml** must be used to
see whether any partial changes occurred.

If _--live_ is specified, libvirt takes the snapshot while
the guest is running. Both disk snapshot and domain memory snapshot are
taken. This increases the size of the memory image of the external
snapshot. This is currently supported only for full system external snapshots.

Existence of snapshot metadata will prevent attempts to **undefine**
a persistent domain.  However, for transient domains, snapshot
metadata is silently lost when the domain quits running (whether
by command such as **destroy** or by internal guest action).

For now, it is not possible to create snapshots in a domain that has
checkpoints, although this restriction will be lifted in a future
release.

<a name="snapshot-create-as"></a>

### snapshot\-create\-as


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-create-as domain {[--print-xml] [--no-metadata]
       [--halt] [--reuse-external]} [name]
       [description] [--disk-only [--quiesce]] [--atomic]
       [[--live] [--memspec memspec]] [--diskspec] diskspec]...
    .ft P
.UNINDENT
.UNINDENT

Create a snapshot for domain _domain_ with the given &lt;name&gt; and
&lt;description&gt;; if either value is omitted, libvirt will choose a
value.  If _--print-xml_ is specified, then XML appropriate for
_snapshot-create_ is output, rather than actually creating a snapshot.
Otherwise, if _--halt_ is specified, the domain will be left in an
inactive state after the snapshot is created, and if _--disk-only_
is specified, the snapshot will not include vm state.

The _--memspec_ option can be used to control whether a full system snapshot
is internal or external.  The _--memspec_ flag is mandatory, followed
by a **memspec** of the form **[file=]name[,snapshot=type]**, where
type can be **no**, **internal**, or **external**.  To include a literal
comma in **file=name**, escape it with a second comma. _--memspec_ cannot
be used together with _--disk-only_.

The _--diskspec_ option can be used to control how _--disk-only_ and
external full system snapshots create external files.  This option can occur
multiple times, according to the number of &lt;disk&gt; elements in the domain
xml.  Each &lt;diskspec&gt; is in the
form **disk[,snapshot=type][,driver=type][,stype=type][,file=name]**.
A _diskspec_ must be provided for disks backed by block devices as libvirt
doesn't auto-generate file names for those.  The optional **stype** parameter
allows one to control the type of the source file. Supported values are 'file'
(default) and 'block'. To exclude a disk from an external snapshot use
**--diskspec disk,snapshot=no**.

To include a literal comma in **disk** or in **file=name**, escape it with a
second comma.  A literal _--diskspec_ must precede each **diskspec** unless
all three of _domain_, _name_, and _description_ are also present.
For example, a diskspec of "vda,snapshot=external,file=/path/to,,new"
results in the following XML:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <disk name='vda' snapshot='external'>
      <source file='/path/to,new'/>
    </disk>
    .ft P
.UNINDENT
.UNINDENT

If _--reuse-external_ is specified, and the domain XML or _diskspec_
option requests an external snapshot with a destination of an existing
file, then the destination must exist and be pre-created with correct
format and metadata. The file is then reused; otherwise, a snapshot
is refused to avoid losing contents of the existing files.

If _--quiesce_ is specified, libvirt will try to use guest agent
to freeze and unfreeze domain's mounted file systems. However,
if domain has no guest agent, snapshot creation will fail.
Currently, this requires _--disk-only_ to be passed as well.

If _--no-metadata_ is specified, then the snapshot data is created,
but any metadata is immediately discarded (that is, libvirt does not
treat the snapshot as current, and cannot revert to the snapshot
unless **snapshot-create** is later used to teach libvirt about the
metadata again).

If _--atomic_ is specified, libvirt will guarantee that the snapshot
either succeeds, or fails with no changes; not all hypervisors support
this.  If this flag is not specified, then some hypervisors may fail
after partially performing the action, and **dumpxml** must be used to
see whether any partial changes occurred.

If _--live_ is specified, libvirt takes the snapshot while the guest is
running. This increases the size of the memory image of the external
snapshot. This is currently supported only for external full system snapshots.

For now, it is not possible to create snapshots in a domain that has
checkpoints, although this restriction will be lifted in a future
release.

<a name="snapshot-current"></a>

### snapshot\-current


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-current domain {[--name] | [--security-info] | [snapshotname]}
    .ft P
.UNINDENT
.UNINDENT

Without _snapshotname_, this will output the snapshot XML for the domain's
current snapshot (if any).  If _--name_ is specified, just the
current snapshot name instead of the full xml.  Otherwise, using
_--security-info_ will also include security sensitive information in
the XML.

With _snapshotname_, this is a request to make the existing named
snapshot become the current snapshot, without reverting the domain.

<a name="snapshot-edit"></a>

### snapshot\-edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-edit domain [snapshotname] [--current] {[--rename] | [--clone]}
    .ft P
.UNINDENT
.UNINDENT

Edit the XML configuration file for _snapshotname_ of a domain.  If
both _snapshotname_ and _--current_ are specified, also force the
edited snapshot to become the current snapshot.  If _snapshotname_
is omitted, then _--current_ must be supplied, to edit the current
snapshot.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh snapshot-dumpxml dom name > snapshot.xml
    vi snapshot.xml (or make changes with your other text editor)
    virsh snapshot-create dom snapshot.xml --redefine [--current]
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

If _--rename_ is specified, then the edits can change the snapshot
name.  If _--clone_ is specified, then changing the snapshot name
will create a clone of the snapshot metadata.  If neither is specified,
then the edits must not change the snapshot name.  Note that changing
a snapshot name must be done with care, since the contents of some
snapshots, such as internal snapshots within a single qcow2 file, are
accessible only from the original name.

<a name="snapshot-info"></a>

### snapshot\-info


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-info domain {snapshot | --current}
    .ft P
.UNINDENT
.UNINDENT

Output basic information about a named &lt;snapshot&gt;, or the current snapshot
with _--current_.

<a name="snapshot-list"></a>

### snapshot\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-list domain [--metadata] [--no-metadata]
       [{--parent | --roots | [{--tree | --name}]}] [--topological]
       [{[--from] snapshot | --current} [--descendants]]
       [--leaves] [--no-leaves] [--inactive] [--active]
       [--disk-only] [--internal] [--external]
    .ft P
.UNINDENT
.UNINDENT

List all of the available snapshots for the given domain, defaulting
to show columns for the snapshot name, creation time, and domain state.

Normally, table form output is sorted by snapshot name; using
_--topological_ instead sorts so that no child is listed before its
ancestors (although there may be more than one possible ordering with
this property).

If _--parent_ is specified, add a column to the output table giving
the name of the parent of each snapshot.  If _--roots_ is specified,
the list will be filtered to just snapshots that have no parents.
If _--tree_ is specified, the output will be in a tree format, listing
just snapshot names.  These three options are mutually exclusive. If
_--name_ is specified only the snapshot name is printed. This option is
mutually exclusive with _--tree_.

If _--from_ is provided, filter the list to snapshots which are
children of the given **snapshot**; or if _--current_ is provided,
start at the current snapshot.  When used in isolation or with
_--parent_, the list is limited to direct children unless
_--descendants_ is also present.  When used with _--tree_, the
use of _--descendants_ is implied.  This option is not compatible
with _--roots_.  Note that the starting point of _--from_ or
_--current_ is not included in the list unless the _--tree_
option is also present.

If _--leaves_ is specified, the list will be filtered to just
snapshots that have no children.  Likewise, if _--no-leaves_ is
specified, the list will be filtered to just snapshots with
children.  (Note that omitting both options does no filtering,
while providing both options will either produce the same list
or error out depending on whether the server recognizes the flags).
Filtering options are not compatible with _--tree_.

If _--metadata_ is specified, the list will be filtered to just
snapshots that involve libvirt metadata, and thus would prevent
**undefine** of a persistent domain, or be lost on **destroy** of
a transient domain.  Likewise, if _--no-metadata_ is specified,
the list will be filtered to just snapshots that exist without
the need for libvirt metadata.

If _--inactive_ is specified, the list will be filtered to snapshots
that were taken when the domain was shut off.  If _--active_ is
specified, the list will be filtered to snapshots that were taken
when the domain was running, and where the snapshot includes the
memory state to revert to that running state.  If _--disk-only_ is
specified, the list will be filtered to snapshots that were taken
when the domain was running, but where the snapshot includes only
disk state.

If _--internal_ is specified, the list will be filtered to snapshots
that use internal storage of existing disk images.  If _--external_
is specified, the list will be filtered to snapshots that use external
files for disk images or memory state.

<a name="snapshot-dumpxml"></a>

### snapshot\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-dumpxml domain snapshot [--security-info]
    .ft P
.UNINDENT
.UNINDENT

Output the snapshot XML for the domain's snapshot named _snapshot_.
Using _--security-info_ will also include security sensitive information.
Use **snapshot-current** to easily access the XML of the current snapshot.

<a name="snapshot-parent"></a>

### snapshot\-parent


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-parent domain {snapshot | --current}
    .ft P
.UNINDENT
.UNINDENT

Output the name of the parent snapshot, if any, for the given
_snapshot_, or for the current snapshot with _--current_.

<a name="snapshot-revert"></a>

### snapshot\-revert


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-revert domain {snapshot | --current} [{--running | --paused}] [--force]
    .ft P
.UNINDENT
.UNINDENT

Revert the given domain to the snapshot specified by _snapshot_, or to
the current snapshot with _--current_.  Be aware
that this is a destructive action; any changes in the domain since the last
snapshot was taken will be lost.  Also note that the state of the domain after
snapshot-revert is complete will be the state of the domain at the time
the original snapshot was taken.

Normally, reverting to a snapshot leaves the domain in the state it was
at the time the snapshot was created, except that a disk snapshot with
no vm state leaves the domain in an inactive state.  Passing either the
_--running_ or _--paused_ flag will perform additional state changes
(such as booting an inactive domain, or pausing a running domain).  Since
transient domains cannot be inactive, it is required to use one of these
flags when reverting to a disk snapshot of a transient domain.

There are a number of cases where a snapshot revert involves extra risk, which
requires the use of _--force_ to proceed:
.INDENT 0.0
.INDENT 3.5
.INDENT 0.0

* ·  
  One is the case of a snapshot that lacks full domain information for
  reverting configuration (such as snapshots created prior to libvirt
  0.9.5); since libvirt cannot prove that the current configuration matches
  what was in use at the time of the snapshot, supplying _--force_ assures
  libvirt that the snapshot is compatible with the current configuration
  (and if it is not, the domain will likely fail to run).
* ·  
  Another is the case of reverting from a running domain to an active
  state where a new hypervisor has to be created rather than reusing the
  existing hypervisor, because it implies drawbacks such as breaking any
  existing VNC or Spice connections; this condition happens with an active
  snapshot that uses a provably incompatible configuration, as well as with
  an inactive snapshot that is combined with the _--start_ or _--pause_
  flag.
* ·  
  Also, libvirt will refuse to restore snapshots of inactive QEMU domains
  while there is managed saved state. This is because those snapshots do not
  contain memory state and will therefore not replace the existing memory
  state. This ends up switching a disk underneath a running system and will
  likely cause extensive filesystem corruption or crashes due to swap content
  mismatches when run.
  .UNINDENT
  .UNINDENT
  .UNINDENT

<a name="snapshot-delete"></a>

### snapshot\-delete


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    snapshot-delete domain {snapshot | --current}
       [--metadata] [{--children | --children-only}]
    .ft P
.UNINDENT
.UNINDENT

Delete the snapshot for the domain named _snapshot_, or the current
snapshot with _--current_.  If this snapshot
has child snapshots, changes from this snapshot will be merged into the
children.  If _--children_ is passed, then delete this snapshot and any
children of this snapshot.  If _--children-only_ is passed, then delete
any children of this snapshot, but leave this snapshot intact.  These
two flags are mutually exclusive.

If _--metadata_ is specified, then only delete the snapshot metadata
maintained by libvirt, while leaving the snapshot contents intact for
access by external tools; otherwise deleting a snapshot also removes
the data contents from that point in time.

<a name="checkpoint-commands"></a>

# Checkpoint Commands


The following commands manipulate domain checkpoints.  Checkpoints serve as
a point in time to identify which portions of a guest's disks have changed
after that time, making it possible to perform incremental and differential
backups.  Checkpoints are identified with a unique name.  See
_https://libvirt.org/formatcheckpoint.html_ for documentation of the XML
format used to represent properties of checkpoints.

<a name="checkpoint-create"></a>

### checkpoint\-create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    checkpoint-create domain [xmlfile] { --redefine | [--quiesce]}
    .ft P
.UNINDENT
.UNINDENT

Create a checkpoint for domain _domain_ with the properties specified
in _xmlfile_ describing a &lt;domaincheckpoint&gt; top-level element. The
format of the input XML file will be validated against an internal RNG
schema (idential to using the virt-xml-validate(1) tool). If
_xmlfile_ is completely omitted, then libvirt will create a
checkpoint with a name based on the current time.

If _--redefine_ is specified, then all XML elements produced by
**checkpoint-dumpxml** are valid; this can be used to migrate
checkpoint hierarchy from one machine to another, to recreate
hierarchy for the case of a transient domain that goes away and is
later recreated with the same name and UUID, or to make slight
alterations in the checkpoint metadata (such as host-specific aspects
of the domain XML embedded in the checkpoint).  When this flag is
supplied, the _xmlfile_ argument is mandatory.

If _--quiesce_ is specified, libvirt will try to use guest agent
to freeze and unfreeze domain's mounted file systems. However,
if domain has no guest agent, checkpoint creation will fail.

Existence of checkpoint metadata will prevent attempts to **undefine**
a persistent domain.  However, for transient domains, checkpoint
metadata is silently lost when the domain quits running (whether
by command such as **destroy** or by internal guest action).

For now, it is not possible to create checkpoints in a domain that has
snapshots, although this restriction will be lifted in a future
release.

<a name="checkpoint-create-as"></a>

### checkpoint\-create\-as


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    checkpoint-create-as domain [--print-xml] [name]
       [description] [--quiesce] [--diskspec] diskspec]...
    .ft P
.UNINDENT
.UNINDENT

Create a checkpoint for domain _domain_ with the given &lt;name&gt; and
&lt;description&gt;; if either value is omitted, libvirt will choose a
value.  If _--print-xml_ is specified, then XML appropriate for
_checkpoint-create_ is output, rather than actually creating a
checkpoint.

The _--diskspec_ option can be used to control which guest disks
participate in the checkpoint. This option can occur multiple times,
according to the number of &lt;disk&gt; elements in the domain xml.  Each
&lt;diskspec&gt; is in the form **disk[,checkpoint=type][,bitmap=name]**. A
literal _--diskspec_ must precede each **diskspec** unless
all three of _domain_, _name_, and _description_ are also present.
For example, a diskspec of "vda,checkpoint=bitmap,bitmap=map1"
results in the following XML:
.INDENT 0.0
.INDENT 3.5

    .ft C
    <disk name='vda' checkpoint='bitmap' bitmap='map1'/>
    .ft P
.UNINDENT
.UNINDENT

If _--quiesce_ is specified, libvirt will try to use guest agent
to freeze and unfreeze domain's mounted file systems. However,
if domain has no guest agent, checkpoint creation will fail.

For now, it is not possible to create checkpoints in a domain that has
snapshots, although this restriction will be lifted in a future
release.

<a name="checkpoint-edit"></a>

### checkpoint\-edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    checkpoint-edit domain checkpointname
    .ft P
.UNINDENT
.UNINDENT

Edit the XML configuration file for _checkpointname_ of a domain.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh checkpoint-dumpxml dom name > checkpoint.xml
    vi checkpoint.xml (or make changes with your other text editor)
    virsh checkpoint-create dom checkpoint.xml --redefine
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking, including that the edits
should not attempt to change the checkpoint name.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

<a name="checkpoint-info"></a>

### checkpoint\-info


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    checkpoint-info domain checkpoint
    .ft P
.UNINDENT
.UNINDENT

Output basic information about a named &lt;checkpoint&gt;.

<a name="checkpoint-list"></a>

### checkpoint\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    checkpoint-list domain [{--parent | --roots |
       [{--tree | --name}]}] [--topological]
       [[--from] checkpoint | [--descendants]]
       [--leaves] [--no-leaves]
    .ft P
.UNINDENT
.UNINDENT

List all of the available checkpoints for the given domain, defaulting
to show columns for the checkpoint name and creation time.

Normally, table form output is sorted by checkpoint name; using
_--topological_ instead sorts so that no child is listed before its
ancestors (although there may be more than one possible ordering with
this property).

If _--parent_ is specified, add a column to the output table giving
the name of the parent of each checkpoint.  If _--roots_ is
specified, the list will be filtered to just checkpoints that have no
parents.  If _--tree_ is specified, the output will be in a tree
format, listing just checkpoint names.  These three options are
mutually exclusive. If _--name_ is specified only the checkpoint name
is printed. This option is mutually exclusive with _--tree_.

If _--from_ is provided, filter the list to checkpoints which are
children of the given **checkpoint**.  When used in isolation or with
_--parent_, the list is limited to direct children unless
_--descendants_ is also present.  When used with _--tree_, the use
of _--descendants_ is implied.  This option is not compatible with
_--roots_.  Note that the starting point of _--from_
is not included in the list unless the _--tree_ option is also
present.

If _--leaves_ is specified, the list will be filtered to just
checkpoints that have no children.  Likewise, if _--no-leaves_ is
specified, the list will be filtered to just checkpoints with
children.  (Note that omitting both options does no filtering, while
providing both options will either produce the same list or error out
depending on whether the server recognizes the flags).  Filtering
options are not compatible with _--tree_.

<a name="checkpoint-dumpxml"></a>

### checkpoint\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    checkpoint-dumpxml domain checkpoint [--security-info] [--no-domain] [--size]
    .ft P
.UNINDENT
.UNINDENT

Output the checkpoint XML for the domain's checkpoint named
_checkpoint_.  Using
_--security-info_ will also include security sensitive information.
Using _--size_ will add XML indicating the current size in bytes of
guest data that has changed since the checkpoint was created (although
remember that guest activity between a size check and actually
creating a backup can result in the backup needing slightly more
space).  Using _--no-domain_ will omit the &lt;domain&gt; element from the
output for a more compact view.

<a name="checkpoint-parent"></a>

### checkpoint\-parent


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    checkpoint-parent domain checkpoint
    .ft P
.UNINDENT
.UNINDENT

Output the name of the parent checkpoint, if any, for the given
_checkpoint_.

<a name="checkpoint"></a>

### checkpoint


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    checkpoint-delete domain checkpoint
       [--metadata] [{--children | --children-only}]
    .ft P
.UNINDENT
.UNINDENT

Delete the checkpoint for the domain named _checkpoint_.  The
record of which portions of
the disk changed since the checkpoint are merged into the parent
checkpoint (if any). If _--children_ is passed, then delete this
checkpoint and any children of this checkpoint.  If _--children-only_
is passed, then delete any children of this checkpoint, but leave this
checkpoint intact. These two flags are mutually exclusive.

If _--metadata_ is specified, then only delete the checkpoint
metadata maintained by libvirt, while leaving the checkpoint contents
intact for access by external tools; otherwise deleting a checkpoint
also removes the ability to perform an incremental backup from that
point in time.

<a name="nwfilter-commands"></a>

# Nwfilter Commands


The following commands manipulate network filters. Network filters allow
filtering of the network traffic coming from and going to virtual machines.
Individual network traffic filters are written in XML and may contain
references to other network filters, describe traffic filtering rules,
or contain both. Network filters are referenced by virtual machines
from within their interface description. A network filter may be referenced
by multiple virtual machines' interfaces.

<a name="nwfilter-define"></a>

### nwfilter\-define


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-define xmlfile
    .ft P
.UNINDENT
.UNINDENT

Make a new network filter known to libvirt. If a network filter with
the same name already exists, it will be replaced with the new XML.
Any running virtual machine referencing this network filter will have
its network traffic rules adapted. If for any reason the network traffic
filtering rules cannot be instantiated by any of the running virtual
machines, then the new XML will be rejected.

<a name="nwfilter-undefine"></a>

### nwfilter\-undefine


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-undefine nwfilter-name
    .ft P
.UNINDENT
.UNINDENT

Delete a network filter. The deletion will fail if any running virtual
machine is currently using this network filter.

<a name="nwfilter-list"></a>

### nwfilter\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-list
    .ft P
.UNINDENT
.UNINDENT

List all of the available network filters.

<a name="nwfilter-dumpxml"></a>

### nwfilter\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-dumpxml nwfilter-name
    .ft P
.UNINDENT
.UNINDENT

Output the network filter XML.

<a name="nwfilter-edit"></a>

### nwfilter\-edit


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-edit nwfilter-name
    .ft P
.UNINDENT
.UNINDENT

Edit the XML of a network filter.

This is equivalent to:
.INDENT 0.0
.INDENT 3.5

    .ft C
    virsh nwfilter-dumpxml myfilter > myfilter.xml
    vi myfilter.xml (or make changes with your other text editor)
    virsh nwfilter-define myfilter.xml
    .ft P
.UNINDENT
.UNINDENT

except that it does some error checking.
The new network filter may be rejected due to the same reason as
mentioned in _nwfilter-define_.

The editor used can be supplied by the **$VISUAL** or **$EDITOR** environment
variables, and defaults to **vi**.

<a name="nwfilter-binding-commands"></a>

# Nwfilter Binding Commands


The following commands manipulate network filter bindings. Network filter
bindings track the association between a network port and a network
filter. Generally the bindings are managed automatically by the hypervisor
drivers when adding/removing NICs on a guest.

If an admin is creating/deleting TAP devices for non-guest usage,
however, the network filter binding commands provide a way to make use
of the network filters directly.

<a name="nwfilter-binding-create"></a>

### nwfilter\-binding\-create


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-binding-create xmlfile
    .ft P
.UNINDENT
.UNINDENT

Associate a network port with a network filter. The network filter backend
will immediately attempt to instantiate the filter rules on the port. This
command may be used to associate a filter with a currently running guest
that does not have a filter defined for a specific network port. Since the
bindings are generally automatically managed by the hypervisor, using this
command to define a filter for a network port and then starting the guest
afterwards may prevent the guest from starting if it attempts to use the
network port and finds a filter already defined.

<a name="nwfilter-binding-delete"></a>

### nwfilter\-binding\-delete


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-binding-delete port-name
    .ft P
.UNINDENT
.UNINDENT

Disassociate a network port from a network filter. The network filter
backend will immediately tear down the filter rules that exist on the
port. This command may be used to remove the network port binding for
a filter currently in use for the guest while the guest is running
without needing to restart the guest. Restoring the network port binding
filter for the running guest would be accomplished by using
_nwfilter-binding-create_.

<a name="nwfilter-binding-list"></a>

### nwfilter\-binding\-list


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-binding-list
    .ft P
.UNINDENT
.UNINDENT

List all of the network ports which have filters associated with them.

<a name="nwfilter-binding-dumpxml"></a>

### nwfilter\-binding\-dumpxml


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    nwfilter-binding-dumpxml port-name
    .ft P
.UNINDENT
.UNINDENT

Output the network filter binding XML for the network device called
**port-name**.

<a name="hypervisor-specific-commands"></a>

# Hypervisor-Specific Commands


NOTE: Use of the following commands is **strongly** discouraged.  They
can cause libvirt to become confused and do the wrong thing on subsequent
operations.  Once you have used these commands, please do not report
problems to the libvirt developers; the reports will be ignored.  If
you find that these commands are the only way to accomplish something,
then it is better to request that the feature be added as a first-class
citizen in the regular libvirt library.

<a name="qemu-attach"></a>

### qemu\-attach


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    qemu-attach pid
    .ft P
.UNINDENT
.UNINDENT

Attach an externally launched QEMU process to the libvirt QEMU driver.
The QEMU process must have been created with a monitor connection
using the UNIX driver. Ideally the process will also have had the
'-name' argument specified.
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ qemu-kvm -cdrom ~/demo.iso e
        -monitor unix:/tmp/demo,server,nowait e
        -name foo e
        -uuid cece4f9f-dff0-575d-0e8e-01fe380f12ea  &
    $ QEMUPID=$!
    $ virsh qemu-attach $QEMUPID
    .ft P
.UNINDENT
.UNINDENT

Not all functions of libvirt are expected to work reliably after
attaching to an externally launched QEMU process. There may be
issues with the guest ABI changing upon migration and device hotplug
or hotunplug may not work. The attached environment should be considered
primarily read-only.

<a name="qemu-monitor-command"></a>

### qemu\-monitor\-command


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    qemu-monitor-command domain { [--hmp] | [--pretty] [--return-value] } command...
    .ft P
.UNINDENT
.UNINDENT

Send an arbitrary monitor command _command_ to domain _domain_ through the
QEMU monitor.  The results of the command will be printed on stdout.

If more than one argument is provided for _command_, they are concatenated with
a space in between before passing the single command to the monitor.

Note that libvirt uses the QMP to talk to qemu so _command_ must be valid JSON
in QMP format to work properly.

If _--pretty_ is given the QMP reply is pretty-printed.

If _--return-value_ is given the 'return' key of the QMP response object is
extracted rather than passing through the full reply from QEMU.

If _--hmp_ is passed, the command is considered to be a human monitor command
and libvirt will automatically convert it into QMP and convert the result back.

<a name="qemu-agent-command"></a>

### qemu\-agent\-command


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    qemu-agent-command domain [--timeout seconds | --async | --block] command...
    .ft P
.UNINDENT
.UNINDENT

Send an arbitrary guest agent command _command_ to domain _domain_ through
QEMU agent.
_--timeout_, _--async_ and _--block_ options are exclusive.
_--timeout_ requires timeout seconds _seconds_ and it must be positive.
When _--aysnc_ is given, the command waits for timeout whether success or
failed. And when _--block_ is given, the command waits forever with blocking
timeout.

<a name="qemu-monitor-event"></a>

### qemu\-monitor\-event


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    qemu-monitor-event [domain] [--event event-name]
      [--loop] [--timeout seconds] [--pretty] [--regex] [--no-case]
      [--timestamp]
    .ft P
.UNINDENT
.UNINDENT

Wait for arbitrary QEMU monitor events to occur, and print out the
details of events as they happen.  The events can optionally be filtered
by _domain_ or _event-name_.  The 'query-events' QMP command can be
used via _qemu-monitor-command_ to learn what events are supported.
If _--regex_ is used, _event-name_ is a basic regular expression
instead of a literal string.  If _--no-case_ is used, _event-name_
will match case-insensitively.

By default, this command is one-shot, and returns success once an event
occurs; you can send SIGINT (usually via **Ctrl-C**) to quit immediately.
If _--timeout_ is specified, the command gives up waiting for events
after _seconds_ have elapsed.  With _--loop_, the command prints all
events until a timeout or interrupt key.  If _--pretty_ is specified,
any JSON event details are pretty-printed for better legibility.

When _--timestamp_ is used, a human-readable timestamp will be printed
before the event, and the timing information provided by QEMU will be
omitted.

<a name="lxc-enter-namespace"></a>

### lxc\-enter\-namespace


**Syntax:**
.INDENT 0.0
.INDENT 3.5

    .ft C
    lxc-enter-namespace domain [--noseclabel] --
       /path/to/binary [arg1, [arg2, ...]]
    .ft P
.UNINDENT
.UNINDENT

Enter the namespace of _domain_ and execute the command **/path/to/binary**
passing the requested args. The binary path is relative to the container
root filesystem, not the host root filesystem. The binary will inherit the
environment variables / console visible to virsh. The command will be run
with the same sVirt context and cgroups placement as processes within the
container. This command only works when connected to the LXC hypervisor
driver.  This command succeeds only if **/path/to/binary** has 0 exit status.

By default the new process will run with the security label of the new
parent container. Use the _--noseclabel_ option to instead have the
process keep the same security label as **virsh**.

<a name="environment"></a>

# Environment


The following environment variables can be set to alter the behaviour
of **virsh**
.INDENT 0.0

* ·  
  VIRSH_DEBUG=&lt;0 to 4&gt;

Turn on verbose debugging of virsh commands. Valid levels are
.INDENT 2.0

* ·  
  VIRSH_DEBUG=0

DEBUG - Messages at ALL levels get logged

* ·  
  VIRSH_DEBUG=1

INFO - Logs messages at levels INFO, NOTICE, WARNING and ERROR

* ·  
  VIRSH_DEBUG=2

NOTICE - Logs messages at levels NOTICE, WARNING and ERROR

* ·  
  VIRSH_DEBUG=3

WARNING - Logs messages at levels WARNING and ERROR

* ·  
  VIRSH_DEBUG=4

ERROR - Messages at only ERROR level gets logged.
.UNINDENT

* ·  
  VIRSH_LOG_FILE=\`\`LOGFILE\`\`

The file to log virsh debug messages.

* ·  
  VIRSH_DEFAULT_CONNECT_URI

The hypervisor to connect to by default. Set this to a URI, in the same
format as accepted by the **connect** option. This environment variable
is deprecated in favour of the global **LIBVIRT\_DEFAULT\_URI** variable
which serves the same purpose.

* ·  
  LIBVIRT_DEFAULT_URI

The hypervisor to connect to by default. Set this to a URI, in the
same format as accepted by the **connect** option. This overrides
the default URI set in any client config file and prevents libvirt
from probing for drivers.

* ·  
  VISUAL

The editor to use by the **edit** and related options.

* ·  
  EDITOR

The editor to use by the **edit** and related options, if **VISUAL**
is not set.

* ·  
  VIRSH_HISTSIZE

The number of commands to remember in the command  history.  The
default value is 500.

* ·  
  LIBVIRT_DEBUG=LEVEL

Turn on verbose debugging of all libvirt API calls. Valid levels are
.INDENT 2.0

* ·  
  LIBVIRT_DEBUG=1

Messages at level DEBUG or above

* ·  
  LIBVIRT_DEBUG=2

Messages at level INFO or above

* ·  
  LIBVIRT_DEBUG=3

Messages at level WARNING or above

* ·  
  LIBVIRT_DEBUG=4

Messages at level ERROR
.UNINDENT
.UNINDENT

For further information about debugging options consult
_https://libvirt.org/logging.html_

<a name="bugs"></a>

# Bugs


Please report all bugs you discover.  This should be done via either:
.INDENT 0.0

* 1.  
  the mailing list

_https://libvirt.org/contact.html_

* 2.  
  the bug tracker

_https://libvirt.org/bugs.html_
.UNINDENT

Alternatively, you may report bugs to your software distributor / vendor.

<a name="authors"></a>

# Authors


Please refer to the AUTHORS file distributed with libvirt.

<a name="copyright"></a>

# Copyright


Copyright (C) 2005, 2007-2015 Red Hat, Inc., and the authors listed in the
libvirt AUTHORS file.

<a name="license"></a>

# License


**virsh** is distributed under the terms of the GNU LGPL v2+.
This is free software; see the source for copying conditions. There
is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE

<a name="see-also"></a>

# See Also


virt-install(1), virt-xml-validate(1), virt-top(1), virt-df(1),
_https://libvirt.org/_

