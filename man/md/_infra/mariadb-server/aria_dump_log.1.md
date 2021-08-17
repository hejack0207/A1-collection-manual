# aria_dump_log(1) - Dump content of Aria log pages.

Version 1.0, May 2014

```
aria_dump_log -f file OPTIONS
```

<a name="description"></a>

# Description

Dump content of Aria log pages.

* **-#**, **--debug**[=_name_]  
  Output debug log. Often the argument is 'd:t:o,filename'.
* **-f**, **--file**=_name_  
  Path to file which will be read
* **-?**, **--help**  
  Display this help and exit.
* **-o**, **--offset=**#  
  Start reading log from this offset
* **-n**, **--pages=**#  
  Number of pages to read
* **-U**, **--unit-test**  
  Use unit test record table (for logs created by unittests
* **-V**, **--version**  
  Print version and exit.

Default options are read from the following files in the given order:
/etc/my.cnf
/etc/mysql/my.cnf
~/.my.cnf

The following groups are read: **aria\_dump\_log**

The following options may be given as the first argument:

* **--print-defaults**  
  Print the program argument list and exit.
* **--no-defaults**  
  Don't read default options from any option file.
* **--defaults-file=**#  
  Only read default options from the given file #.
* **--defaults-extra-file=**#  
  Read this file after the global files are read.


<a name="see-also"></a>

# See Also

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/

<a name="author"></a>

# Author

MariaDB Foundation (http://www.mariadb.org/).
