# \fbmyisamlog\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh







<a name="name"></a>

# Name

myisamlog - display MyISAM log file contents

<a name="synopsis"></a>

# Synopsis

```
.HP \w'myisamlog&nbsp;[options]&nbsp;[log_file&nbsp;[tbl_name]&nbsp;...]&nbsp;'u myisamlog [options] [log_file [tbl_name] ...]
```

<a name="description"></a>

# Description


**myisamlog**
processes the contents of a
MyISAM
log file.

Invoke
**myisamlog**
like this:

.if n \{.RS 4
.\}
    shell> myisamlog [options] [log_file [tbl_name] ...]
    shell> isamlog [options] [log_file [tbl_name] ...]
.if n \{.RE
.\}

The default operation is update (**-u**). If a recovery is done (**-r**), all writes and possibly updates and deletes are done and errors are only counted. The default log file name is
myisam.log
for
**myisamlog**
and
isam.log
for
**isamlog**
if no
_log\_file_
argument is given. If tables are named on the command line, only those tables are updated.

**myisamlog**
supports the following options:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-?**,
  **-I**

Display a help message and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-c ****N**

Execute only
_N_
commands.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-f ****N**

Specify the maximum number of open files.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-i**

Display extra information before exiting.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-o ****offset**

Specify the starting offset.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-p ****N**

Remove
_N_
components from path.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-r**

Perform a recovery operation.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-R ****record_pos_file record\_pos**

Specify record position file and record position.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-u**

Perform an update operation.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-v**

Verbose mode. Print more output about what the program does. This option can be given multiple times to produce more and more output.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-w ****write\_file**

Specify the write file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **-V**

Display version information.

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
