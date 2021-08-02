# pidof(1)

"", 2018-03-03

pidof -- find the process ID of a running program.

<a name="synopsis"></a>

# Synopsis

```
pidof [-s] [-c] [-x] [-o omitpid[,omitpid..]] [-o omitpid[,omitpid..]..] [-S separator] program [program..]
```

<a name="description"></a>

# Description

**Pidof**
finds the process id's (pids) of the named programs. It prints those
id's on the standard output.

<a name="options"></a>

# Options


* -s  
  Single shot - this instructs the program to only return one _pid_.
* -c  
  Only return process ids that are running with the same root directory.
  This option is ignored for non-root users, as they will be unable to check
  the current root directory of processes they do not own.
* -x  
  Scripts too - this causes the program to also return process id's of
  shells running the named scripts.
* -o _omitpid_  
  Tells _pidof_ to omit processes with that process id. The special
  pid **%PPID** can be used to name the parent process of the _pidof_
  program, in other words the calling shell or shell script.
* -S _separator_  
  Use _separator_ as a separator put between pids. Used only when
  more than one pids are printed for the program.

<a name="exit-status"></a>

# Exit Status


* **0**
  At least one program was found with the requested name.
* **1**
  No program was found with the requested name.
  

<a name="bugs"></a>

# Bugs

When using the _-x_ option,
**pidof**
only has a simple method for detecting scripts and will miss scripts that,
for example, use env. This limitation is due to how the scripts look in
the proc filesystem.


<a name="see-also"></a>

# See Also

**pgrep**(1),
**pkill**(1)

<a name="author"></a>

# Author

Jaromir Capik &lt;[jcapik@redhat.com](mailto:jcapik@redhat.com)&gt;
