# ipcmk(1) - make various IPC resources

util-linux, July 2014

```
ipcmk [options]
```

<a name="description"></a>

# Description

**ipcmk**
allows you to create shared memory segments, message queues,
and semaphore arrays.

<a name="options"></a>

# Options


* Resources can be specified with these options:  
* **-M**,** --shmem **size  
  Create a shared memory segment of
  _size_
  bytes.
  The _size_ argument may be followed by the multiplicative suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, etc. (the
  "iB" is optional, e.g., "K" has the same meaning as "KiB") or the suffixes KB (=1000), MB (=1000*1000), and so on for GB, etc.
* **-Q**,** --queue**  
  Create a message queue.
* **-S**,** --semaphore **number  
  Create a semaphore array with
  _number_
  of elements.

Other options are:

* **-p**,** --mode **mode  
  Access permissions for the resource.  Default is 0644.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.


<a name="see-also"></a>

# See Also

**ipcrm**(1),
**ipcs**(1)

<a name="author"></a>

# Author

.MT [hayden.james@gmail.com](mailto:hayden.james@gmail.com)
Hayden A. James
.ME

<a name="availability"></a>

# Availability

The ipcmk command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
