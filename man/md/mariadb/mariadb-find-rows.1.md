# \fbmysql_find_rows\f(1)

MariaDB 10\&.4, 28 March 2019

.nh






<a name="name"></a>

# Name

mysql_find_rows - extract SQL statements from files

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysql_find_rows&nbsp;[options]&nbsp;[file_name&nbsp;...]&nbsp;'u mysql_find_rows [options] [file_name ...]
```

<a name="description"></a>

# Description


**mysql\_find\_rows**
reads files containing SQL statements and extracts statements that match a given regular expression or that contain
USE _db\_name_
or
SET
statements. The utility was written for use with update log files (as used prior to MySQL 5.0) and as such expects statements to be terminated with semicolon (;) characters. It may be useful with other files that contain SQL statements as long as statements are terminated with semicolons.

Invoke
**mysql\_find\_rows**
like this:

.if n \{.RS 4
.\}
    shell> mysql_find_rows [options] [file_name ...]
.if n \{.RE
.\}

Each
_file\_name_
argument should be the name of file containing SQL statements. If no file names are given,
**mysql\_find\_rows**
reads the standard input.

Examples:

.if n \{.RS 4
.\}
    mysql_find_rows --regexp=problem_table --rows=20 < update.log
    mysql_find_rows --regexp=problem_table  update-log.1 update-log.2
.if n \{.RE
.\}

**mysql\_find\_rows**
supports the following options:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**,
  **--Information**

Display a help message and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--regexp=****pattern**

Display queries that match the pattern.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--rows=****N**

Quit after displaying
_N_
queries.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--skip-use-db**

Do not include
USE _db\_name_
statements in the output.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--start\_row=****N**

Start output from this row.

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
