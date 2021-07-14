# mountpoint(1) - see if a directory or file is a mountpoint

util-linux, July 2014

```
mountpoint [-d|-q] directory | file 
 mountpoint -x device
```


<a name="description"></a>

# Description

**mountpoint**
checks whether the given
_directory_
or
_file_
is mentioned in the /proc/self/mountinfo file.

<a name="options"></a>

# Options


* **-d**,** --fs-devno**  
  Show the major/minor numbers of the device that is mounted on the given
  directory.
* **-q**,** --quiet**  
  Be quiet - don't print anything.
* **-x**,** --devno**  
  Show the major/minor numbers of the given blockdevice on standard output.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="exit-status"></a>

# Exit Status

Zero if the directory or file is a mountpoint, non-zero if not.

<a name="author"></a>

# Author


Karel Zak &lt;[kzak@redhat.com](mailto:kzak@redhat.com)&gt;

<a name="environment"></a>

# Environment


* LIBMOUNT_DEBUG=all  
  enables libmount debug output.

<a name="notes"></a>

# Notes


The util-linux
**mountpoint**
implementation was written from scratch for libmount.  The original version
for sysvinit suite was written by Miquel van Smoorenburg.


<a name="see-also"></a>

# See Also

**mount**(8)

<a name="availability"></a>

# Availability

The mountpoint command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
