# setsid(1) - run a program in a new session

util-linux, July 2014

```
setsid [options] program [arguments]
```

<a name="description"></a>

# Description

**setsid**
runs a program in a new session. The command calls
**fork**(2)
if already a process group leader.  Otherwise, it executes a program in the
current process.  This default behavior is possible to override by
the **--fork** option.

<a name="options"></a>

# Options


* **-c**,** --ctty**  
  Set the controlling terminal to the current one.
* **-f**,** --fork**  
  Always create a new process.
* **-w**,** --wait**  
  Wait for the execution of the program to end, and return the exit value of
  this program as the return value of
  **setsid**.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.

<a name="see-also"></a>

# See Also

**setsid**(2)

<a name="author"></a>

# Author

Rick Sladkey &lt;[jrs@world.std](mailto:jrs@world.std).com&gt;

<a name="availability"></a>

# Availability

The setsid command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
