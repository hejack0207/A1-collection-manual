# lsns(8) - list namespaces

util-linux, December 2015

```
lsns [options] [namespace]
```


<a name="description"></a>

# Description

**lsns**
lists information about all the currently accessible namespaces or about the
given _namespace_.  The _namespace_ identifier is an inode number.

The default output is subject to change.  So whenever possible, you should
avoid using default outputs in your scripts.  Always explicitly define expected
columns by using the **--output** option together with a columns list in
environments where a stable output is required.

**NSFS** column, printed when **net** is specified for
**--type** option, is special; it uses multi-line cells.
Use the option **--nowrap** is for switching to "," separated single-line
representation.

Note that **lsns** reads information directly from the /proc filesystem and
for non-root users it may return incomplete information.  The current /proc
filesystem may be unshared and affected by a PID namespace
(see **unshare --mount-proc** for more details).
**lsns**
is not able to see persistent namespaces without processes where the namespace
instance is held by a bind mount to /proc/_pid_/ns/_type_.


<a name="options"></a>

# Options


* **-J**,** --json**  
  Use JSON output format.
* **-l**,** --list**  
  Use list output format.
* **-n**,** --noheadings**  
  Do not print a header line.
* **-o**,** --output **_list_  
  Specify which output columns to print.  Use **--help**
  to get a list of all supported columns.
  
  The default list of columns may be extended if _list_ is
  specified in the format **+list** (e.g. **lsns -o +PATH**).
* **--output-all**  
  Output all available columns.
* **-p**,** --task **_pid_  
  Display only the namespaces held by the process with this _pid_.
* **-r**,** --raw**  
  Use the raw output format.
* **-t**,** --type **_type_  
  Display the specified _type_ of namespaces only.  The supported types are
  **mnt**, **net**, **ipc**, **user**, **pid**, **uts** and
  **cgroup**.  This option may be given more than once.
* **-u**,** --notruncate**  
  Do not truncate text in columns.
* **-W**,** --nowrap**  
  Do not use multi-line text in columns.
* **-V**,** --version**  
  Display version information and exit.
* **-h**,** --help**  
  Display help text and exit.
  

<a name="authors"></a>

# Authors

    Karel Zak <kzak@redhat.com>


<a name="see-also"></a>

# See Also

**nsenter**(1),
**unshare**(1),
**clone**(2),
**namespaces**(7)


<a name="availability"></a>

# Availability

The lsns command is part of the util-linux package and is available from
https://www.kernel.org/pub/linux/utils/util-linux/.
