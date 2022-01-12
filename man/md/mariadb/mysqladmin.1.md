# \fbmysqladmin\fr(1)

MariaDB 10\&.4, 27 June 2019

.nh








<a name="name"></a>

# Name

mysqladmin - client for administering a MariaB server

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysqladmin&nbsp;[options]&nbsp;command&nbsp;[command-arg]&nbsp;[command&nbsp;[command-arg]]&nbsp;...&nbsp;'u mysqladmin [options] command [command-arg] [command [command-arg]] ...
```

<a name="description"></a>

# Description


**mysqladmin**
is a client for performing administrative operations. You can use it to check the server\'s configuration and current status, to create and drop databases, and more.

Invoke
**mysqladmin**
like this:

.if n \{.RS 4
.\}
    shell> mysqladmin [options] command [command-arg] [command [command-arg]] ...
.if n \{.RE
.\}

**mysqladmin**
supports the following commands. Some of the commands take an argument following the command name.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  create _db\_name_

Create a new database named
_db\_name_.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  debug

Tell the server to write debug information to the error log.

This also includes information about the Event Scheduler.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  drop _db\_name_

Delete the database named
_db\_name_
and all its tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  extended-status

Display the server status variables and their values.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-all-statistics

Flush all statistics tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-all-status

Flush all status and statistics.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-binary-log

Flush the binary log.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-client-statistics

Flush client statistics.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-engine-log

Flush engine log.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-error-log

Flush error log.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-general-log

Flush general query log.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-hosts

Flush all information in the host cache.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-index-statistics

Flush index statistics.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-logs

Flush all logs.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-privileges

Reload the grant tables (same as
reload).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-relay-log

Flush relay log.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-slow-log

Flush slow query log.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-status

Clear status variables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-table-statistics

Flush table statistics.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-tables

Flush all tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-threads

Flush the thread cache.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  flush-user-resources

Flush user resources.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  kill _id_,_id_,...

Kill server threads. If multiple thread ID values are given, there must be no spaces in the list.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  old-password _new-password_

This is like the
password
command but stores the password using the old (pre MySQL 4.1) password-hashing format.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  password _new-password_

Set a new password. This changes the password to
_new-password_
for the account that you use with
**mysqladmin**
for connecting to the server. Thus, the next time you invoke
**mysqladmin**
(or any other client program) using the same account, you will need to specify the new password.

If the
_new-password_
value contains spaces or other characters that are special to your command interpreter, you need to enclose it within quotes. On Windows, be sure to use double quotes rather than single quotes; single quotes are not stripped from the password, but rather are interpreted as part of the password. For example:

.if n \{.RS 4
.\}
    shell> mysqladmin password "my new password"
.if n \{.RE
.\}
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Caution**
.ps -1  
Do not use this command used if the server was started with the
**--skip-grant-tables**
option. No password change will be applied. This is true even if you precede the
password
command with
flush-privileges
on the same command line to re-enable the grant tables because the flush operation occurs after you connect. However, you can use
**mysqladmin flush-privileges**
to re-enable the grant table and then use a separate
**mysqladmin password**
command to change the password.


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ping

Check whether the server is alive. The return status from
**mysqladmin**
is 0 if the server is running, 1 if it is not. This is 0 even in case of an error such as
Access denied, because this means that the server is running but refused the connection, which is different from the server not running.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  processlist

Show a list of active server threads. This is like the output of the
SHOW PROCESSLIST
statement. If the
**--verbose**
option is given, the output is like that of
SHOW FULL PROCESSLIST.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  reload

Reload the grant tables.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  refresh

Flush all tables and close and open log files.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  shutdown

Stop the server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  start-all-slaves

Start all slaves.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  start-slave

Start replication on a slave server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  status

Display a short server status message.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  stop-all-slaves

Stop all slaves.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  stop-slave

Stop replication on a slave server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  variables

Display the server system variables and their values.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  version

Display version information from the server.

All commands can be shortened to any unique prefix. For example:

.if n \{.RS 4
.\}
    shell> mysqladmin proc stat
    +----+-------+-----------+----+---------+------+-------+------------------+
    | Id | User  | Host      | db | Command | Time | State | Info             |
    +----+-------+-----------+----+---------+------+-------+------------------+
    | 51 | monty | localhost |    | Query   | 0    |       | show processlist |
    +----+-------+-----------+----+---------+------+-------+------------------+
    Uptime: 1473624  Threads: 1  Questions: 39487
    Slow queries: 0  Opens: 541  Flush tables: 1
    Open tables: 19  Queries per second avg: 0.0268
.if n \{.RE
.\}



The
**mysqladmin status**
command result displays the following values:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  Uptime

The number of seconds the MariaDB server has been running.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  Threads

The number of active threads (clients).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  Questions

The number of questions (queries) from clients since the server was started.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  Slow queries

The number of queries that have taken more than
long_query_time
seconds.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  Opens

The number of tables the server has opened.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  Flush tables

The number of
flush-*,
refresh, and
reload
commands the server has executed.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  Open tables

The number of tables that currently are open.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  Memory in use

The amount of memory allocated directly by
**mysqld**. This value is displayed only when MariaDB has been compiled with
**--with-debug=full**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  Maximum memory used

The maximum amount of memory allocated directly by
**mysqld**. This value is displayed only when MariaDB has been compiled with
**--with-debug=full**.

If you execute
**mysqladmin shutdown**
when connecting to a local server using a Unix socket file,
**mysqladmin**
waits until the server\'s process ID file has been removed, to ensure that the server has stopped properly.





**mysqladmin**
supports the following options, which can be specified on the command line or in the
[mysqladmin]
and
[client]
option file groups.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**,
  **-?**

Display help and exit.

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
  
  
  **--compress**,
  **-C**

Compress all information sent between the client and the server if both support compression.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--connect-timeout=****timeout**

Equivalent to **--connect\_timeout**, see the end of this section.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--count=****N**,
  **-c ****N**

The number of iterations to make for repeated command execution if the
**--sleep**
option is given.

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
\'d:t:o,/tmp/mysqladmin.trace\'.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--debug-check**

Check memory and open file usage at exit..

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
  
  
  **--default-auth**

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

Set **filename** as the file to read default options from after the global defaults files has been read.
Must be given as first option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-file=****filename**

Set **filename** as the file to read default options from, override global defaults files. Must be given as first option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--force**,
  **-f**

Do not ask for confirmation for the
drop _db\_name_
command. With multiple commands, continue even if an error occurs.

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
  
  
  **--local**,
  **-l**

Suppress the SQL command(s) from being written to the binary log by using FLUSH LOCAL or enabling sql_log_bin=0 for the session.

.ie n \{\h'-04'·\h'+03'\c
.\}


**--no-beep**,
**-b**

Suppress the warning beep that is emitted by default for errors such as a failure to connect to the server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-defaults**

Do not read default options from any option file. This must be given as the first argument.

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
**mysqladmin**
prompts for one.

Specifying a password on the command line should be considered insecure.

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
  
  
  **--port=****port\_num**,
  **-P ****port\_num**

The TCP/IP port number to use for the connection or 0 for default to, 
in order of preference, my.cnf, $MYSQL_TCP_PORT, /etc/services, built-in default (3306).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--print-defaults**

Print the program argument list and exit. This must be given as the first argument.

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
  
  
  **--relative**,
  **-r**

Show the difference between the current and previous values when used with the
**--sleep**
option. Currently, this option works only with the
extended-status
command.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--shutdown-timeout****timeout**

Equivalent of **--shutdown\_timeout**, see the end of this section.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--silent**,
  **-s**

Exit silently if a connection to the server cannot be established.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--sleep=****delay**,
  **-i ****delay**

Execute commands repeatedly, sleeping for
_delay_
seconds in between. The
**--count**
option determines the number of iterations. If
**--count**
is not given,
**mysqladmin**
executes commands indefinitely until interrupted.

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
  
  
  **--tls-version=****name**,

Accepts a comma-separated list of TLS protocol versions. A TLS protocol version will only be enabled if it 
is present in this list. All other TLS protocol versions will not be permitted.

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

Verbose mode. Print more information about what the program does.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--version**,
  **-V**

Display version information and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--vertical**,
  **-E**

Print output vertically. This is similar to
**--relative**, but prints output vertically.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--wait[=****count****]**,
  **-w[****count****]**

If the connection cannot be established, wait and retry instead of aborting. If a
_count_
value is given, it indicates the number of times to retry. The default is one time.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--wait-for-all-slaves**

Wait for the last binlog event to be sent to all connected slaves before shutting down. 
This option is off by default.

You can also set the following variables by using
**--****var\_name****=****value**

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  connect_timeout

The maximum number of seconds before connection timeout. The default value is 43200 (12 hours).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  shutdown_timeout

The maximum number of seconds to wait for server shutdown. The default value is 3600 (1 hour).

<a name="copyright"></a>

# Copyright
  

Copyright 2007-2008 MySQL AB, 2008-2010 Sun Microsystems, Inc., 2010-2019 MariaDB Foundation

This documentation is free software; you can redistribute it and/or modify it only under the terms of the GNU General Public License as published by the Free Software Foundation; version 2 of the License.

This documentation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with the program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335 USA or see http://www.gnu.org/licenses/.


<a name="see-also"></a>

# See Also

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/

<a name="author"></a>

# Author

MariaDB Foundation (http://www.mariadb.org/).
