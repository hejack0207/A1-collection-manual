# \fbmy_print_defaults(1)

MariaDB 10\&.3, 9 May 2017

.nh






<a name="name"></a>

# Name

my_print_defaults - display options from option files

<a name="synopsis"></a>

# Synopsis

```
.HP \w'my_print_defaults&nbsp;[options]&nbsp;option_group&nbsp;...&nbsp;'u my_print_defaults [options] option_group ...
```

<a name="description"></a>

# Description


**my\_print\_defaults**
displays the options that are present in option groups of option files. The output indicates what options will be used by programs that read the specified option groups. For example, the
**mysqlcheck**
program reads the
[mysqlcheck]
and
[client]
option groups. To see what options are present in those groups in the standard option files, invoke
**my\_print\_defaults**
like this:

.if n \{.RS 4
.\}
    shell> my_print_defaults mysqlcheck client
    --user=myusername
    --password=secret
    --host=localhost
.if n \{.RE
.\}

The output consists of options, one per line, in the form that they would be specified on the command line.

**my\_print\_defaults**
supports the following options.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**,
  **-?**

Display a help message and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--config-file=****file\_name**,
  
  
  **--defaults-file=****file\_name**,
  **-c ****file\_name**

Read only the given option file. If no extension is given, default extension(.ini or .cnf) will 
be used. **--config-file** is deprecated, use **--defaults-file** instead. If **--defaults-file** is 
the first option, then read this file only, do not read global or per-user config files; should be the first option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--debug=****debug\_options**,
  **-# ****debug\_options**

Write a debugging log. A typical
_debug\_options_
string is
\'d:t:o,_file\_name_\'. The default is
\'d:t:o,/tmp/my_print_defaults.trace\'.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-extra-file=****file\_name**,
  
  
  **--extra-file=****file\_name**,
  **-e ****file\_name**

Read this option file after the global option file but (on Unix) before the user option 
file. Should be the first option. **--extra-file** is deprecated, use  **--defaults-extra-file**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-group-suffix=****suffix**,
  **-g ****suffix**

In addition to the groups named on the command line, read groups that have the given suffix.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--mysqld**

Read the same set of groups that the mysqld binary does.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-defaults**,
  **-n**

Return an empty string (useful for scripts).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--verbose**,
  **-v**

Verbose mode. Print more information about what the program does.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--version**,
  **-V**

Display version information and exit.

<a name="copyright"></a>

# Copyright
  

Copyright 2007-2008 MySQL AB, 2008-2010 Sun Microsystems, Inc., 2010-2015 MariaDB Foundation

This documentation is free software; you can redistribute it and/or modify it only under the terms of the GNU General Public License as published by the Free Software Foundation; version 2 of the License.

This documentation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with the program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335 USA or see http://www.gnu.org/licenses/.


<a name="see-also"></a>

# See Also

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/

<a name="author"></a>

# Author

MariaDB Foundation (http://www.mariadb.org/).
