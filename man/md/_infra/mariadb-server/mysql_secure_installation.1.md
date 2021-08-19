# \fbmysql_secure_inst(1)

MariaDB 10\&.3, 9 May 2017

.nh






<a name="name"></a>

# Name

mysql_secure_installation - improve MariaDB installation security

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysql_secure_installation&nbsp;'u mysql_secure_installation
```

<a name="description"></a>

# Description


This program enables you to improve the security of your MariaDB installation in the following ways:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  You can set a password for
  root
  accounts.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  You can remove
  root
  accounts that are accessible from outside the local host.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  You can remove anonymous-user accounts.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  You can remove the
  test
  database, which by default can be accessed by anonymous users.

**mysql\_secure\_installation**
can be invoked without arguments:

.if n \{.RS 4
.\}
    shell> mysql_secure_installation
.if n \{.RE
.\}

The script will prompt you to determine which actions to perform.

**mysql\_secure\_installation**
accepts some options:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--basedir=****dir\_name**

Base directory.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-extra-file=****file\_name**

Additional option file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-file=****file\_name**

Option file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-defaults**

Don't read any defaults file.

Other unrecognized options will be passed on to the server.

<a name="copyright"></a>

# Copyright
  

Copyright 2007-2008 MySQL AB, 2008-2010 Sun Microsystems, Inc., 2010-2017 MariaDB Foundation

This documentation is free software; you can redistribute it and/or modify it only under the terms of the GNU General Public License as published by the Free Software Foundation; version 2 of the License.

This documentation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with the program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335 USA or see http://www.gnu.org/licenses/.


<a name="see-also"></a>

# See Also

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/

<a name="author"></a>

# Author

MariaDB Foundation (http://www.mariadb.org/).
