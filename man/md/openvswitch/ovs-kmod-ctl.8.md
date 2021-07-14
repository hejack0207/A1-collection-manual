# ovs\-ctl(8)

Open vSwitch, February 2018


<a name="name"></a>

# Name

ovs-kmod-ctl - OVS startup helper script for loading kernel modules

<a name="synopsis"></a>

# Synopsis

```
ovs-kmod-ctl insert
ovs-kmod-ctl remove
ovs-kmod-ctl help | -h | --help
ovs-kmod-ctl --version
ovs-kmod-ctl version
```

<a name="description"></a>

# Description


The **ovs-kmod-ctl** program is responsible for inserting and
removing Open vSwitch kernel modules.  It is not meant to be invoked
directly by system administrators but to be called internally by
system startup scripts.  The script is used as part of an SELinux
transition domain.

Each of **ovs-kmod-ctl**'s commands is described separately below.

<a name="the-insert-command"></a>

# The ``Insert'' Command


The **insert** command loads the Open vSwitch kernel modules, if
needed.  If this fails, and the Linux bridge module is loaded but no
bridges exist, it tries to unload the bridge module and tries loading
the Open vSwitch kernel module again.

<a name="the-remove-command"></a>

# The ``Remove'' Command


The **remove** command unloads the Open vSwitch kernel module (including
the bridge compatibility module, if loaded) and any associated vport
modules.

<a name="exit-status"></a>

# Exit Status

**ovs-kmod-ctl** exits with status 0 on success and nonzero on
failure.  The **insert** command is considered to succeed if kernel
modules are already loaded; the **remove** command is considered to
succeed if none of the kernel modules are loaded.

<a name="environment"></a>

# Environment

The following environment variables affect **ovs-kmod-ctl**:

* **PATH**  
  **ovs-kmod-ctl** does not hardcode the location of any of the programs
  that it runs.  **ovs-kmod-ctl** will add the _sbindir_ and
  _bindir_ that were specified at **configure** time to
  **PATH**, if they are not already present.
* **OVS\_LOGDIR**  
  .IQ "**OVS\_RUNDIR**"
  .IQ "**OVS\_DBDIR**"
  .IQ "**OVS\_SYSCONFDIR**"
  .IQ "**OVS\_PKGDATADIR**"
  .IQ "**OVS\_BINDIR**"
  .IQ "**OVS\_SBINDIR**"
  Setting one of these variables in the environment overrides the
  respective **configure** option, both for **ovs-kmod-ctl** itself
  and for the other Open vSwitch programs that it runs.

<a name="files"></a>

# Files

**ovs-kmod-ctl** uses the following files:

* ovs-lib  
  Shell function library used internally by **ovs-kmod-ctl**.  It must
  be installed in the same directory as **ovs-kmod-ctl**.

<a name="example"></a>

# Example


**ovs-kmod-ctl** isn't intended to be manually executed.  However, the
following examples demonstrate loading the kernel modules.

* **ovs-kmod-ctl** insert  
  Attempts to insert the Open vSwitch kernel modules.
* **ovs-kmod-ctl** remove  
  Attempts to remove the Open vSwitch kernel modules.

<a name="see-also"></a>

# See Also

**README.rst**, **ovs-ctl**(8)
