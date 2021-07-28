# \fbmysql\&.server\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh






<a name="name"></a>

# Name

mysql.server - MariaDB server startup script

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysql&nbsp;{start|stop}&nbsp;'u mysql {start|stop}
```

<a name="description"></a>

# Description


MariaDB distributions on Unix include a script named
**mysql.server**. It can be used on systems such as Linux and Solaris that use System V-style run directories to start and stop system services. It is also used by the Mac OS X Startup Item for MariaDB.

**mysql.server**
can be found in the
support-files
directory under your MariaDB installation directory or in a MariaDB source distribution.

If you use the Linux server RPM package (MySQL-server-_VERSION_.rpm), the
**mysql.server**
script will be installed in the
/etc/init.d
directory with the name
mysql. You need not install it manually.

Some vendors provide RPM packages that install a startup script under a different name such as
**mysqld**.

If you install MariaDB from a source distribution or using a binary distribution format that does not install
**mysql.server**
automatically, you can install it manually.

**mysql.server**
reads options from the
[mysql.server]
and
[mysqld]
sections of option files. For backward compatibility, it also reads
[mysql_server]
sections, although you should rename such sections to
[mysql.server]&.

**mysql.server**
supports the following options.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--basedir=****path**

The path to the MariaDB installation directory.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--datadir=****path**

The path to the MariaDB data directory.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--pid-file=****file\_name**

The path name of the file in which the server should write its process ID. If not provided, the default, "host_name.pid" is used.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--service-startup-timeout=****file\_name**

How long in seconds to wait for confirmation of server startup. If the server does not start within this time,
**mysql.server**
exits with an error. The default value is 900. A value of 0 means not to wait at all for startup. Negative values mean to wait forever (no timeout).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--use-mysqld\_safe**

Use
**mysqld\_safe**
to start the server. This is the default.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--use-manager**

Use Instance Manager to start the server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--user=****user\_name**

The login user name to use for running
**mysqld**.

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
