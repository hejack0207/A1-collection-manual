# \fbmysqlimport\fr(1)

MariaDB 10\&.4, 21 May 2019

.nh










<a name="name"></a>

# Name

mysqlimport - a data import program

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysqlimport&nbsp;[options]&nbsp;db_name&nbsp;textfile1&nbsp;...&nbsp;'u mysqlimport [options] db_name textfile1 ...
```

<a name="description"></a>

# Description


The
**mysqlimport**
client provides a command-line interface to the
LOAD DATA INFILE
SQL statement. Most options to
**mysqlimport**
correspond directly to clauses of
LOAD DATA INFILE
syntax.

Invoke
**mysqlimport**
like this:

.if n \{.RS 4
.\}
    shell> mysqlimport [options] db_name textfile1 [textfile2 ...]
.if n \{.RE
.\}

For each text file named on the command line,
**mysqlimport**
strips any extension from the file name and uses the result to determine the name of the table into which to import the file\'s contents. For example, files named
patient.txt,
patient.text, and
patient
all would be imported into a table named
patient.


**mysqlimport**
supports the following options, which can be specified on the command line or in the
[mysqlimport]
and
[client]
option file groups.
**mysqlimport**
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
  
  
  **--character-sets-dir=****path**

The directory where character sets are installed.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--columns=****column\_list**,
  **-c ****column\_list**

This option takes a comma-separated list of column names as its value. The order of the column names indicates how to match data file columns with table columns.

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
  
  
  **--default-auth=plugin\_name**

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
  
  
  **--delete**,
  **-d**

Empty the table before importing the text file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--fields-terminated-by=...**,
  
  
  **--fields-enclosed-by=...**,
  
  
  **--fields-optionally-enclosed-by=...**,
  
  
  **--fields-escaped-by=...**

These options have the same meaning as the corresponding clauses for
LOAD DATA INFILE.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--force**,
  **-f**

Ignore errors. For example, if a table for a text file does not exist, continue processing any remaining files. Without
**--force**,
**mysqlimport**
exits if a table does not exist.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--host=****host\_name**,
  **-h ****host\_name**

Import data to the MariaDB server on the given host. The default host is
localhost.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ignore**,
  **-i**

See the description for the
**--replace**
option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ignore-foreign-keys**,
  **-k**

Disable foreign key checks while importing the data.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ignore-lines=****N**

Ignore the first
_N_
lines of the data file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--lines-terminated-by=...**

This option has the same meaning as the corresponding clause for
LOAD DATA INFILE. For example, to import Windows files that have lines terminated with carriage return/linefeed pairs, use
**--lines-terminated-by="\er\en"**. (You might have to double the backslashes, depending on the escaping conventions of your command interpreter.).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--local**,
  **-L**

Read input files locally from the client host.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--lock-tables**,
  **-l**

Lock
_all_
tables for writing before processing any text files. This ensures that all tables are synchronized on the server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--low-priority**

Use
LOW_PRIORITY
when loading the table. This affects only storage engines that use only table-level locking (such as
MyISAM,
MEMORY, and
MERGE).

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
**mysqlimport**
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
  
  
  **--plugin-dir=****name**

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
  
  
  **--replace**,
  **-r**

The
**--replace**
and
**--ignore**
options control handling of input rows that duplicate existing rows on unique key values. If you specify
**--replace**, new rows replace existing rows that have the same unique key value. If you specify
**--ignore**, input rows that duplicate an existing row on a unique key value are skipped. If you do not specify either option, an error occurs when a duplicate key value is found, and the rest of the text file is ignored.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--silent**,
  **-s**

Silent mode. Produce output only when errors occur.

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
  
  
  **--use-threads=****N**

Load files in parallel using
_N_
threads.

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

Here is a sample session that demonstrates use of
**mysqlimport**:

.if n \{.RS 4
.\}
    shell> mysql -e 'CREATE TABLE imptest(id INT, n VARCHAR(30))' test
    shell> ed
    a
    100     Max Sydow
    101     Count Dracula
    .
    w imptest.txt
    32
    q
    shell> od -c imptest.txt
    0000000   1   0   0  et   M   a   x       S   y   d   o   w  en   1   0
    0000020   1  et   C   o   u   n   t       D   r   a   c   u   l   a  en
    0000040
    shell> mysqlimport --local test imptest.txt
    test.imptest: Records: 2  Deleted: 0  Skipped: 0  Warnings: 0
    shell> mysql -e 'SELECT * FROM imptest' test
    +------+---------------+
    | id   | n             |
    +------+---------------+
    |  100 | Max Sydow     |
    |  101 | Count Dracula |
    +------+---------------+
.if n \{.RE
.\}

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
