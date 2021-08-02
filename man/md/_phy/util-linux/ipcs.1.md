# ipcs(1) - show information on IPC facilities

util-linux, July 2014

```
ipcs [options]
```

<a name="description"></a>

# Description

**ipcs**
shows information on the inter-process communication facilities
for which the calling process has read access.
By default it shows information about all three resources:
shared memory segments, message queues, and semaphore arrays.

<a name="options"></a>

# Options


* **-i**, **--id** _id_  
  Show full details on just the one resource element identified by
  _id_.
  This option needs to be combined with one of the three resource options:
  **-m**,
  **-q** or
  **-s**.
* **-h**, **--help**  
  Display help text and exit.
* **-V**, **--version**  
  Display version information and exit.

<a name="resource-options"></a>

### Resource options


* **-m**, **--shmems**  
  Write information about active shared memory segments.
* **-q**, **--queues**  
  Write information about active message queues.
* **-s**, **--semaphores**  
  Write information about active semaphore sets.
* **-a**, **--all**  
  Write information about all three resources (default).

<a name="output-formats"></a>

### Output formats

Of these options only one takes effect: the last one specified.

* **-c**, **--creator**  
  Show creator and owner.
* **-l**, **--limits**  
  Show resource limits.
* **-p**, **--pid**  
  Show PIDs of creator and last operator.
* **-t**, **--time**  
  Write time information.  The time of the last control operation that changed
  the access permissions for all facilities, the time of the last
  **msgsnd**(2)
  and
  **msgrcv**(2)
  operations on message queues, the time of the last
  **shmat**(2)
  and
  **shmdt**(2)
  operations on shared memory, and the time of the last
  **semop**(2)
  operation on semaphores.
* **-u**, **--summary**  
  Show status summary.

<a name="representation"></a>

### Representation

These affect only the **-l** (**--limits**) option.

* **-b**, **--bytes**  
  Print sizes in bytes.
* **--human**  
  Print sizes in human-readable format.

<a name="see-also"></a>

# See Also

**ipcmk**(1),
**ipcrm**(1),
**msgrcv**(2),
**msgsnd**(2),
**semget**(2),
**semop**(2),
**shmat**(2),
**shmdt**(2),
**shmget**(2)

<a name="conforming-to"></a>

# Conforming to

The Linux ipcs utility is not fully compatible to the POSIX ipcs utility.
The Linux version does not support the POSIX
**-a**,
**-b**
and
**-o**
options, but does support the
**-l**
and
**-u**
options not defined by POSIX.  A portable application shall not use the
**-a**,
**-b**,
**-o**,
**-l**,
and
**-u**
options.

<a name="author"></a>

# Author

.UR [balasub@cis.ohio-state](mailto:balasub@cis.ohio-state).edu
Krishna Balasubramanian
.UE

<a name="availability"></a>

# Availability

The ipcs command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
