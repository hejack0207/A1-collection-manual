# \fbmysqlslap\fr(1)

MariaDB 10\&.4, 28 March 2019

.nh







<a name="name"></a>

# Name

mysqlslap - load emulation client

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysqlslap&nbsp;[options]&nbsp;'u mysqlslap [options]
```

<a name="description"></a>

# Description


**mysqlslap**
is a diagnostic program designed to emulate client load for a MariaDB server and to report the timing of each stage. It works as if multiple clients are accessing the server.

Invoke
**mysqlslap**
like this:

.if n \{.RS 4
.\}
    shell> mysqlslap [options]
.if n \{.RE
.\}

Some options such as
**--create**
or
**--query**
enable you to specify a string containing an SQL statement or a file containing statements. If you specify a file, by default it must contain one statement per line. (That is, the implicit statement delimiter is the newline character.) Use the
**--delimiter**
option to specify a different delimiter, which enables you to specify statements that span multiple lines or place multiple statements on a single line. You cannot include comments in a file;
**mysqlslap**
does not understand them.

**mysqlslap**
runs in three stages:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Create schema, table, and optionally any stored programs or data you want to using for the test. This stage uses a single client connection.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Run the load test. This stage can use many client connections.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Clean up (disconnect, drop table if specified). This stage uses a single client connection.

Examples:

Supply your own create and query SQL statements, with 50 clients querying and 200 selects for each:

.if n \{.RS 4
.\}
    mysqlslap --delimiter=";" e
      --create="CREATE TABLE a (b int);INSERT INTO a VALUES (23)" e
      --query="SELECT * FROM a" --concurrency=50 --iterations=200
.if n \{.RE
.\}

Let
**mysqlslap**
build the query SQL statement with a table of two
INT
columns and three
VARCHAR
columns. Use five clients querying 20 times each. Do not create the table or insert the data (that is, use the previous test\'s schema and data):

.if n \{.RS 4
.\}
    mysqlslap --concurrency=5 --iterations=20 e
      --number-int-cols=2 --number-char-cols=3 e
      --auto-generate-sql
.if n \{.RE
.\}

Tell the program to load the create, insert, and query SQL statements from the specified files, where the
create.sql
file has multiple table creation statements delimited by
\';\'
and multiple insert statements delimited by
\';\'. The
**--query**
file will have multiple queries delimited by
\';\'. Run all the load statements, then run all the queries in the query file with five clients (five times each):

.if n \{.RS 4
.\}
    mysqlslap --concurrency=5 e
      --iterations=5 --query=query.sql --create=create.sql e
      --delimiter=";"
.if n \{.RE
.\}

**mysqlslap**
supports the following options, which can be specified on the command line or in the
[mysqlslap]
and
[client]
option file groups.
**mysqlslap**
also supports the options for processing option files.

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
  
  
  **--auto-generate-sql**,
  **-a**

Generate SQL statements automatically when they are not supplied in files or via command options.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-generate-sql-add-autoincrement**

Add an
AUTO_INCREMENT
column to automatically generated tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-generate-sql-execute-number=****N**

Specify how many queries to generate automatically.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-generate-sql-guid-primary**

Add a GUID-based primary key to automatically generated tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-generate-sql-load-type=****type**

Specify the test load type. The allowable values are
read
(scan tables),
write
(insert into tables),
key
(read primary keys),
update
(update primary keys), or
mixed
(half inserts, half scanning selects). The default is
mixed.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-generate-sql-secondary-indexes=****N**

Specify how many secondary indexes to add to automatically generated tables. By default, none are added.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-generate-sql-unique-query-number=****N**

How many different queries to generate for automatic tests. For example, if you run a
key
test that performs 1000 selects, you can use this option with a value of 1000 to run 1000 unique queries, or with a value of 50 to perform 50 different selects. The default is 10.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-generate-sql-unique-write-number=****N**

How many different queries to generate for
**--auto-generate-sql-write-number**. The default is 10.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-generate-sql-write-number=****N**

How many row inserts to perform on each thread. The default is 100.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--commit=****N**

How many statements to execute before committing. The default is 0 (no commits are done).

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
  
  
  **--concurrency=****N**,
  **-c ****N**

The number of clients to simulate when issuing the
SELECT
statement.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--create=****value**

The file or string containing the statement to use for creating the table.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--create-schema=****value**

The schema in which to run the tests.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--csv[=****file\_name****]**

Generate output in comma-separated values format. The output goes to the named file, or to the standard output if no file is given.

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
\'d:t:o,/tmp/mysqlslap.trace\'.

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
  
  
  **--debug-info**,
  **-T**

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
  
  
  **--delimiter=****str**,
  **-F ****str**

The delimiter to use in SQL statements supplied in files or via command options.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--detach=****N**

Detach (close and reopen) each connection after each
_N_
statements. The default is 0 (connections are not detached).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--engine=****engine\_name**,
  **-e ****engine\_name**

Comma separated list of storage engines to use for creating the table. The test is run for 
each engine. You can also specify an option for an engine after a colon, for example
**memory:max\_row=2300**.

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
  
  
  **--init-command=str**

SQL Command to execute when connecting to MariaDB server. Will automatically be re-executed when reconnecting.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--iterations=****N**,
  **-i ****N**

The number of times to run the tests.

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
  
  
  **--no-drop**

Do not drop any schema created during the test after the test is complete.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--number-char-cols=****N**,
  **-x ****N**

The number of
VARCHAR
columns to use if
**--auto-generate-sql**
is specified.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--number-int-cols=****N**,
  **-y ****N**

The number of
INT
columns to use if
**--auto-generate-sql**
is specified.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--number-of-queries=****N**

Limit each client to approximately this many queries. Query counting takes into account the statement delimiter. For example, if you invoke
**mysqlslap**
as follows, the
;
delimiter is recognized so that each instance of the query string counts as two queries. As a result, 5 rows (not 10) are inserted.

.if n \{.RS 4
.\}
    shell> mysqlslap --delimiter=";" --number-of-queries=10
             --query="use test;insert into t values(null)"
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--only-print**

Do not connect to databases.
**mysqlslap**
only prints what it would have done.

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
**mysqlslap**
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
  
  
  **--post-query=****value**

The file or string containing the statement to execute after the tests have completed. This execution is not counted for timing purposes.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--post-system=****str**

The string to execute via
system()
after the tests have completed. This execution is not counted for timing purposes.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--pre-query=****value**

The file or string containing the statement to execute before running the tests. This execution is not counted for timing purposes.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--pre-system=****str**

The string to execute via
system()
before running the tests. This execution is not counted for timing purposes.

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
  
  
  **--protocol={TCP|SOCKET|PIPE|MEMORY}**

The connection protocol to use for connecting to the server. It is useful when the other connection parameters normally would cause a protocol to be used other than the one you want.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--query=****value**,
  **-q ****value**

The file or string containing the
SELECT
statement to use for retrieving data.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--shared-memory-base-name=****name**

On Windows, the shared-memory name to use, for connections made via shared memory to a local server. This option applies only if the server supports shared-memory connections.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--silent**,
  **-s**

Silent mode. No output.

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
