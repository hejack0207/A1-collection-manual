# aria_pack(1) - generate compressed, read\-only Aria tables

Version 1.0, May 2014

```
aria_pack [OPTIONS] filename...
```

<a name="description"></a>

# Description

Pack a Aria-table to take much less space.
Keys are not updated, you must run **aria_chk -rq** on the index (.MAI) file
afterwards to update the keys.
You should give the .MAI file as the filename argument.
To unpack a packed table, run **aria_chk -u** on the table

* **-b**, **--backup**  
  Make a backup of the table as table_name.OLD.
* **--character-sets-dir**=_name_  
  Directory where character sets are.
* **-#**, **--debug**[=_name_]  
  Output debug log. Often this is 'd:t:o,filename'.
* **-f**, **--force**  
  Force packing of table even if it gets bigger or if
  tempfile exists.
* **-j**, **--join**=_name_  
  Join all given tables into 'new_table_name'. All tables
  MUST have identical layouts.
* **-?**, **--help**  
  Display this help and exit.
* **-s**, **--silent**  
  Be more silent.
* **-T**, **--tmpdir**=_name_  
  Use temporary directory to store temporary table.
* **-t**, **--test**  
  Don't pack table, only test packing it.
* **-v**, **--verbose**  
  Write info about progress and packing result. Use many **-v**
  for more verbosity!
* **-V**, **--version**  
  Output version information and exit.
* **-w**, **--wait**  
  Wait and retry if table is in use.

Default options are read from the following files in the given order:
**/etc/my.cnf /etc/mysql/my.cnf ~/.my.cnf**

The following groups are read: **ariapack**

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

**myisampack(1)**

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/
