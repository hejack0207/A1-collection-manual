# \fbmysqlshow\fr(1)

MariaDB 10\&.4, 28 March 2019

.nh











<a name="name"></a>

# Name

mysqlshow - display database, table, and column information

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysqlshow&nbsp;[options]&nbsp;[db_name&nbsp;[tbl_name&nbsp;[col_name]]]&nbsp;'u mysqlshow [options] [db_name [tbl_name [col_name]]]
```

<a name="description"></a>

# Description


The
**mysqlshow**
client can be used to quickly see which databases exist, their tables, or a table\'s columns or indexes.

**mysqlshow**
provides a command-line interface to several SQL
SHOW
statements. The same information can be obtained by using those statements directly. For example, you can issue them from the
**mysql**
client program.

Invoke
**mysqlshow**
like this:

.if n \{.RS 4
.\}
    shell> mysqlshow [options] [db_name [tbl_name [col_name]]]
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If no database is given, a list of database names is shown.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If no table is given, all matching tables in the database are shown.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If no column is given, all matching columns and column types in the table are shown.

The output displays only the names of those databases, tables, or columns for which you have some privileges.

If the last argument contains shell or SQL wildcard characters (“*”,
“?”,
“%”, or
“_”), only those names that are matched by the wildcard are shown. If a database name contains any underscores, those should be escaped with a backslash (some Unix shells require two) to get a list of the proper tables or columns.
“*”
and
“?”
characters are converted into SQL
“%”
and
“_”
wildcard characters. This might cause some confusion when you try to display the columns for a table with a
“_”
in the name, because in this case,
**mysqlshow**
shows you only the table names that match the pattern. This is easily fixed by adding an extra
“%”
last on the command line as a separate argument.

**mysqlshow**
supports the following options, which can be specified on the command line or in the
[mysqlshow]
and
[client]
option file groups.
**mysqlshow**
also supports the options for processing option files described.

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
  
  
  **--character-sets-dir=****path**,
  **-c** _path_

The directory where character sets are installed.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--compress**,
  **-C**

Compress all information sent between the client and the server if both support compression.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--count**

Show the number of rows per table. This can be slow for non-MyISAM
tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--debug[=****debug\_options****]**,
  **-# [****debug\_options****]**

Write a debugging log. A typical
_debug\_options_
string is
\'d:t:o,_file\_name_\'. The default is
\'d:t:o\'.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--debug-check**

Print some debugging information when the program exits.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--debug-info**

Print debugging information and memory and CPU usage statistics when the program exits.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--default-auth=****name**

Default authentication client-side plugin to use.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--default-character-set=****charset\_name**

Use
_charset\_name_
as the default character set.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-extra-file=****filename**

Set **filename** as the file to read default options from after the global defaults files has been
read.  Must be given as first option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-file=****filename**

Set **filename** as the file to read default options from, override global defaults files.
Must be given as first option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-group-suffix=****suffix**

In addition to the groups named on the command line, read groups that have the given suffix.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--host=****host\_name**,
  **-h ****host\_name**

Connect to the MariaDB server on the given host.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--keys**,
  **-k**

Show table indexes.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-defaults**

Do not read default options from any option file. This must be given as the
first argument.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--password[=****password****]**,
  **-p[****password****]**

The password to use when connecting to the server. If you use the short option form (**-p**), you
_cannot_
have a space between the option and the password. If you omit the
_password_
value following the
**--password**
or
**-p**
option on the command line,
**mysqlshow**
prompts for one.

Specifying a password on the command line should be considered insecure. You can use an option file to avoid giving the password on the command line.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--pipe**,
  **-W**

On Windows, connect to the server via a named pipe. This option applies only if the server supports named-pipe connections.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--plugin-dir=dir\_name**

Directory for client-side plugins.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--port=****port\_num**,
  **-P ****port\_num**

The TCP/IP port number to use for the connection.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--protocol={TCP|SOCKET|PIPE|MEMORY}**

The connection protocol to use for connecting to the server. It is useful when the other connection parameters normally would cause a protocol to be used other than the one you want.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--print-defaults**

Print the program argument list and exit.
This must be given as the first argument.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--show-table-type**,
  **-t**

Show a column indicating the table type, as in
SHOW FULL TABLES. The type is
BASE TABLE
or
VIEW.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--socket=****path**,
  **-S ****path**

For connections to
localhost, the Unix socket file to use, or, on Windows, the name of the named pipe to use.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl**

Enable SSL for connection (automatically enabled with other flags). Disable with 
**--skip-ssl**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl-ca=name**

CA file in PEM format (check OpenSSL docs, implies
**--ssl**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl-capath=name**

CA directory (check OpenSSL docs, implies
**--ssl**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl-cert=name**

X509 cert in PEM format (check OpenSSL docs, implies
**--ssl**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl-cipher=name**

SSL cipher to use (check OpenSSL docs, implies
**--ssl**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl-key=name**

X509 key in PEM format (check OpenSSL docs, implies
**--ssl**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl-crl=name**

Certificate revocation list (check OpenSSL docs, implies
**--ssl**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl-crlpath=name**

Certificate revocation list path (check OpenSSL docs, implies
**--ssl**).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ssl-verify-server-cert**

Verify server's "Common Name" in its cert against hostname used when connecting. This option is disabled by default.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--status**,
  **-i**

Display extra information about each table.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--user=****user\_name**,
  **-u ****user\_name**

The MariaDB user name to use when connecting to the server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--verbose**,
  **-v**

Verbose mode. Print more information about what the program does. This option can be used multiple times to increase the amount of information.

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
