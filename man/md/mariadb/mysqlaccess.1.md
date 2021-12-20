# \fbmysqlaccess\fr(1)

MariaDB 10\&.4, 28 March 2019

.nh






<a name="name"></a>

# Name

mysqlaccess - client for checking access privileges

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysqlaccess&nbsp;[host_name&nbsp;[user_name&nbsp;[db_name]]]&nbsp;[options]&nbsp;'u mysqlaccess [host_name [user_name [db_name]]] [options]
```

<a name="description"></a>

# Description


**mysqlaccess**
is a diagnostic tool written by Yves Carlier. It checks the access privileges for a host name, user name, and database combination. Note that
**mysqlaccess**
checks access using only the
user,
db, and
host
tables. It does not check table, column, or routine privileges specified in the
tables_priv,
columns_priv, or
procs_priv
tables.

Invoke
**mysqlaccess**
like this:

.if n \{.RS 4
.\}
    shell> mysqlaccess [host_name [user_name [db_name]]] [options]
.if n \{.RE
.\}

**mysqlaccess**
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
  
  
  **--brief**,
  **-b**

Generate reports in single-line tabular format.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--commit**

Copy the new access privileges from the temporary tables to the original grant tables. The grant tables must be flushed for the new privileges to take effect. (For example, execute a
**mysqladmin reload**
command.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--copy**

Reload the temporary grant tables from original ones.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--db=****db\_name**,
  **-d ****db\_name**

Specify the database name.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--debug=****N**

Specify the debug level.
_N_
can be an integer from 0 to 3.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--host=****host\_name**,
  **-h ****host\_name**

The host name to use in the access privileges.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--howto**

Display some examples that show how to use
**mysqlaccess**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--old\_server**

Connect to a very old MySQL server (before MySQL 3.21) that does not know how to handle full
WHERE clauses.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--password[=****password****]**,
  **-p[****password****]**

The password to use when connecting to the server. If you omit the
_password_
value following the
**--password**
or
**-p**
option on the command line,
**mysqlaccess**
prompts for one.

Specifying a password on the command line should be considered insecure. See
Section&nbsp;5.3.2.2, “End-User Guidelines for Password Security”.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--plan**

Display suggestions and ideas for future releases.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--preview**

Show the privilege differences after making changes to the temporary grant tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--relnotes**

Display the release notes.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--rhost=****host\_name**,
  **-H ****host\_name**

Connect to the MariaDB server on the given host.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--rollback**

Undo the most recent changes to the temporary grant tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--spassword[=****password****]**,
  **-P[****password****]**

The password to use when connecting to the server as the superuser. If you omit the
_password_
value following the
**--spassword**
or
**-p**
option on the command line,
**mysqlaccess**
prompts for one.

Specifying a password on the command line should be considered insecure. See
Section&nbsp;5.3.2.2, “End-User Guidelines for Password Security”.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--superuser=****user\_name**,
  **-U ****user\_name**

Specify the user name for connecting as the superuser.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--table**,
  **-t**

Generate reports in table format.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--user=****user\_name**,
  **-u ****user\_name**

The user name to use in the access privileges.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--version**,
  **-v**

Display version information and exit.

If your MariaDB distribution is installed in some non-standard location, you must change the location where
**mysqlaccess**
expects to find the
**mysql**
client. Edit the
mysqlaccess
script at approximately line 18. Search for a line that looks like this:

.if n \{.RS 4
.\}
    $MYSQL     = '/usr/local/bin/mysql';    # path to mysql executable
.if n \{.RE
.\}

Change the path to reflect the location where
**mysql**
actually is stored on your system. If you do not do this, a
Broken pipe
error will occur when you run
**mysqlaccess**.

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
