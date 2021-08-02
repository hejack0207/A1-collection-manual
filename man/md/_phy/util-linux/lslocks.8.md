# lslocks(8) - list local system locks

util-linux, December 2014

```
lslocks [options]
```


<a name="description"></a>

# Description

**lslocks**
lists information about all the currently held file locks in a Linux system.

Note that lslocks also lists OFD (Open File Description) locks, these locks are
not associated with any process (PID is -1).  OFD locks are associated with the
open file description on which they are acquired.  This lock type is available
since Linux 3.15, see **fcntl**(2) for more details.


<a name="options"></a>

# Options


* **-b**,** --bytes**  
  Print the SIZE column in bytes rather than in a human-readable format.
* **-i**,** --noinaccessible**  
  Ignore lock files which are inaccessible for the current user.
* **-J**,** --json**  
  Use JSON output format.
* **-n**,** --noheadings**  
  Do not print a header line.
* **-o**,** --output **_list_  
  Specify which output columns to print.  Use
  **--help**
  to get a list of all supported columns.
  
  The default list of columns may be extended if _list_ is
  specified in the format _+list_ (e.g. **lslocks -o +BLOCKER**).
* **--output-all**  
  Output all available columns.
* **-p**,** --pid **_pid_  
  Display only the locks held by the process with this _pid_.
* **-r**,** --raw**  
  Use the raw output format.
* **-u**,** --notruncate**  
  Do not truncate text in columns.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.
  

<a name="output"></a>

# Output


* COMMAND  
  The command name of the process holding the lock.
* PID  
  The process ID of the process which holds the lock or -1 for OFDLCK.
* TYPE  
  The type of lock; can be FLOCK (created with **flock**(2)), POSIX
  (created with **fcntl**(2) and **lockf**(3)) or OFDLCK (created with fcntl(2).
* SIZE  
  Size of the locked file.
* MODE  
  The lock's access permissions (read, write).  If the process is blocked and waiting for the lock,
  then the mode is postfixed with an '*' (asterisk).
* M  
  Whether the lock is mandatory; 0 means no (meaning the lock is only advisory), 1 means yes.
  (See **fcntl**(2).)
* START  
  Relative byte offset of the lock.
* END  
  Ending offset of the lock.
* PATH  
  Full path of the lock.  If none is found, or there are no permissions to read
  the path, it will fall back to the device's mountpoint and "..." is appended to
  the path.  The path might be truncated; use
  **--notruncate** to get the full path.
* BLOCKER  
  The PID of the process which blocks the lock.
  

<a name="notes"></a>

# Notes

    The lslocks command is meant to replace the lslk(8) command,
    originally written by Victor A. Abell <abe@purdue.edu> and unmaintained
    since 2001.


<a name="authors"></a>

# Authors

    Davidlohr Bueso <dave@gnu.org>


<a name="see-also"></a>

# See Also

**flock**(1),
**fcntl**(2),
**lockf**(3)


<a name="availability"></a>

# Availability

The lslocks command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
