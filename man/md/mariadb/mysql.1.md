# \fbmysql\fr(1)

MariaDB 10\&.4, 28 March 2019

.nh











<a name="name"></a>

# Name

mysql - the MariaDB command-line tool

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysql&nbsp;[options]&nbsp;db_name&nbsp;'u mysql [options] db_name
```

<a name="description"></a>

# Description


**mysql**
is a simple SQL shell (with GNU
readline
capabilities). It supports interactive and non-interactive use. When used interactively, query results are presented in an ASCII-table format. When used non-interactively (for example, as a filter), the result is presented in tab-separated format. The output format can be changed using command options.

If you have problems due to insufficient memory for large result sets, use the
**--quick**
option. This forces
**mysql**
to retrieve results from the server a row at a time rather than retrieving the entire result set and buffering it in memory before displaying it. This is done by returning the result set using the
mysql_use_result()
C API function in the client/server library rather than
mysql_store_result().

Using
**mysql**
is very easy. Invoke it from the prompt of your command interpreter as follows:

.if n \{.RS 4
.\}
    shell> mysql db_name
.if n \{.RE
.\}

Or:

.if n \{.RS 4
.\}
    shell> mysql --user=user_name --password=your_password db_name
.if n \{.RE
.\}

Then type an SQL statement, end it with
“;”,
\eg, or
\eG
and press Enter.

Typing Control-C causes
**mysql**
to attempt to kill the current statement. If this cannot be done, or Control-C is typed again before the statement is killed,
**mysql**
exits.

You can execute SQL statements in a script file (batch file) like this:

.if n \{.RS 4
.\}
    shell> mysql db_name < script.sql > output.tab
.if n \{.RE
.\}

<a name="mysql-options"></a>

# Mysql Options






**mysql**
supports the following options, which can be specified on the command line or in the
[mysql], [client], [client-server] or [client-mariadb]
option file groups.
**mysql**
also supports the options for processing option files.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**,
  **-?**,
  **-I**

Display a help message and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--abort-source-on-error**

Abort 'source filename' operations in case of errors.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-rehash**

Enable automatic rehashing. This option is on by default, which enables database, table, and column name completion. Use
**--disable-auto-rehash**, **--no-auto-rehash**,  or **--skip-auto-rehash**
to disable rehashing. That causes
**mysql**
to start faster, but you must issue the
rehash
command if you want to use name completion.

To complete a name, enter the first part and press Tab. If the name is unambiguous,
**mysql**
completes it. Otherwise, you can press Tab again to see the possible names that begin with what you have typed so far. Completion does not occur if there is no default database.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--auto-vertical-output**

Automatically switch to vertical output mode if the result is wider than the terminal width.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--batch**,
  **-B**

Print results using tab as the column separator, with each row on a new line. With this option,
**mysql**
does not use the history file.

Batch mode results in nontabular output format and escaping of special characters. Escaping may be disabled by using raw mode; see the description for the
**--raw**
option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--binary-mode**

By default, ASCII '\e0' is disallowed and '\er\en' is translated to '\en'. This switch turns off both features, and also turns off parsing of all client commands except \eC and DELIMITER, in non-interactive mode (for input piped to mysql or loaded using the 'source' command). This is necessary when processing output from mysqlbinlog that may contain blobs.

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
  
  
  **--column-names**

Write column names in results.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--column-type-info**,
  **-m**

Display result set metadata.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--comments**,
  **-c**

Whether to preserve comments in statements sent to the server. The default is --skip-comments (discard comments), enable with --comments (preserve comments).

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
  
  
  **--connect-timeout=****seconds**

Set the number of seconds before connection timeout. (Default value is 0.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--database=****db\_name**,
  **-D ****db\_name**

The database to use.

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
\'d:t:o,/tmp/mysql.trace\'.

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

Prints debugging information and memory and CPU usage statistics when the program exits.

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
as the default character set for the client and connection.

A common issue that can occur when the operating system uses
utf8
or another multi-byte character set is that output from the
**mysql**
client is formatted incorrectly, due to the fact that the MariaDB client uses the
latin1
character set by default. You can usually fix such issues by using this option to force the client to use the system character set instead.

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
  
  
  **--defaults-group-suffix=****suffix**

In addition to the groups named on the command line, read groups that have the given suffix.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--delimiter=****str**

Set the statement delimiter. The default is the semicolon character (“;”).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--disable-named-commands**

Disable named commands. Use the
\e*
form only, or use named commands only at the beginning of a line ending with a semicolon (“;”).
**mysql**
starts with this option
_enabled_
by default. However, even with this option, long-format commands still work from the first line. See
the section called “MYSQL COMMANDS”.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--execute=****statement**,
  **-e ****statement**

Execute the statement and quit. Disables **--force** and history file. The default output format is like that produced with
**--batch**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--force**,
  **-f**

Continue even if an SQL error occurs. Sets **--abort-source-on-error** to 0.

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
  
  
  **--html**,
  **-H**

Produce HTML output.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ignore-spaces**,
  **-i**

Ignore spaces after function names. Allows one to have spaces (including tab characters and new line characters) between function name and '('. The drawback is that this causes built in functions to become reserved words.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--init-command=****str**

SQL Command to execute when connecting to the MariaDB server. Will automatically be re-executed when reconnecting.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--line-numbers**

Write line numbers for errors. Disable this with
**--skip-line-numbers**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--local-infile[={0|1}]**

Enable or disable
LOCAL
capability for
LOAD DATA INFILE. With no value, the option enables
LOCAL. The option may be given as
**--local-infile=0**
or
**--local-infile=1**
to explicitly disable or enable
LOCAL. Enabling
LOCAL
has no effect if the server does not also support it.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--max-allowed-packet=****num**

Set the maximum packet length to send to or receive from the server. (Default value is 16MB, largest 1GB.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--max-join-size=****num**

Set the automatic limit for rows in a join when using
**--safe-updates**. (Default value is 1,000,000.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--named-commands**,
  **-G**

Enable named
**mysql**
commands. Long-format commands are allowed, not just short-format commands. For example,
quit
and
\eq
both are recognized. Use
**--skip-named-commands**
to disable named commands. See
the section called “MYSQL COMMANDS”. Disabled by default.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  \h'-04'·\h'+03'\c
  .\}
  
  
  **--net-buffer-length=****size**

Set the buffer size for TCP/IP and socket communication. (Default value is 16KB.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-auto-rehash**,
  **-A**

This has the same effect as
**--skip-auto-rehash**. See the description for
**--auto-rehash**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-beep**,
  **-b**

Do not beep when errors occur.

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
  
  
  **--one-database**,
  **-o**

Ignore statements except those those that occur while the default database is the one named on the command line. This filtering is limited, and based only on USE statements. This is useful for skipping updates to other databases in the binary log.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--pager[=****command****]**

Use the given command for paging query output. If the command is omitted, the default pager is the value of your
PAGER
environment variable. Valid pagers are
**less**,
**more**,
**cat [&gt; filename]**, and so forth. This option works only on Unix and only in interactive mode. To disable paging, use
**--skip-pager**.
the section called “MYSQL COMMANDS”, discusses output paging further.

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
**mysql**
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

The TCP/IP port number to use for the connection or 0 for default to, in order of preference, my.cnf, $MYSQL_TCP_PORT, /etc/services, built-in default (3306).

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
  
  
  **--progress-reports**

Get progress reports for long running commands (such as ALTER TABLE). (Defaults to on; use **--skip-progress-reports** to disable.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--prompt=****format\_str**

Set the prompt to the specified format. The special sequences that the prompt can contain are described in
the section called “MYSQL COMMANDS”.

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
  
  
  **--quick**,
  **-q**

Do not cache each query result, print each row as it is received. This may slow down the server if the output is suspended. With this option,
**mysql**
does not use the history file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--raw**,
  **-r**

For tabular output, the
“boxing”
around columns enables one column value to be distinguished from another. For nontabular output (such as is produced in batch mode or when the
**--batch**
or
**--silent**
option is given), special characters are escaped in the output so they can be identified easily. Newline, tab,
NUL, and backslash are written as
\en,
\et,
\e0, and
\e\e. The
**--raw**
option disables this character escaping.

The following example demonstrates tabular versus nontabular output and the use of raw mode to disable escaping:

.if n \{.RS 4
.\}
    % mysql
    mysql> SELECT CHAR(92);
    +----------+
    | CHAR(92) |
    +----------+
    | e        |
    +----------+
    % mysql -s
    mysql> SELECT CHAR(92);
    CHAR(92)
    ee
    % mysql -s -r
    mysql> SELECT CHAR(92);
    CHAR(92)
    e
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--reconnect**

If the connection to the server is lost, automatically try to reconnect. A single reconnect attempt is made each time the connection is lost. Enabled by default, to disable use
**--skip-reconnect** or **--disable-reconnect**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  
  
  **--safe-updates**,
  **--i-am-a-dummy**,
  **-U**

Allow only those
UPDATE
and
DELETE
statements that specify which rows to modify by using key values. If you have set this option in an option file, you can override it by using
**--safe-updates**
on the command line. See
the section called “MYSQL TIPS”, for more information about this option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--secure-auth**

Do not send passwords to the server in old (pre-4.1.1) format. This prevents connections except for servers that use the newer password format.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--select-limit=****limit**

Set automatic limit for SELECT when using **--safe-updates**. (Default value is 1,000.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--server-arg=****name**

Send **name** as a parameter to the embedded server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--show-warnings**

Cause warnings to be shown after each statement if there are any. This option applies to interactive and batch mode.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--sigint-ignore**

Ignore
SIGINT
signals (typically the result of typing Control-C).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--silent**,
  **-s**

Silent mode. Produce less output. This option can be given multiple times to produce less and less output.

This option results in nontabular output format and escaping of special characters. Escaping may be disabled by using raw mode; see the description for the
**--raw**
option.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--skip-auto-rehash**

Disable automatic rehashing. Synonym for **--disable-auto-rehash**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--skip-column-names**,
  **-N**

Do not write column names in results.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--skip-line-numbers**,
  **-L**

Do not write line numbers for errors. Useful when you want to compare result files that include error messages.

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
  
  
  **--table**,
  **-t**

Display output in table format. This is the default for interactive use, but can be used to produce table output in batch mode.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--tee=****file\_name**

Append a copy of output to the given file. This option works only in interactive mode.
the section called “MYSQL COMMANDS”, discusses tee files further.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--unbuffered**,
  **-n**

Flush the buffer after each query.

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

Verbose mode. Produce more output about what the program does. This option can be given multiple times to produce more and more output. (For example,
**-v -v -v**
produces table output format even in batch mode.)

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

Print query output rows vertically (one line per column value). Without this option, you can specify vertical output for individual statements by terminating them with
\eG.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--wait**,
  **-w**

If the connection cannot be established, wait and retry instead of aborting.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--xml**,
  **-X**

Produce XML output.
The output when
**--xml**
is used with
**mysql**
matches that of
**mysqldump ****--xml**. See
**mysqldump**(1)
for details.

The XML output also uses an XML namespace, as shown here:

.if n \{.RS 4
.\}
    shell> mysql --xml -uroot -e "SHOW VARIABLES LIKE 'version%'"
    <?xml version="1.0"?>
    <resultset statement="SHOW VARIABLES LIKE 'version%'" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <row>
    <field name="Variable_name">version</field>
    <field name="Value">5.0.40-debug</field>
    </row>
    <row>
    <field name="Variable_name">version_comment</field>
    <field name="Value">Source distribution</field>
    </row>
    <row>
    <field name="Variable_name">version_compile_machine</field>
    <field name="Value">i686</field>
    </row>
    <row>
    <field name="Variable_name">version_compile_os</field>
    <field name="Value">suse-linux-gnu</field>
    </row>
    </resultset>

You can also set the following variables by using
**--****var\_name****=****value**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  connect_timeout

The number of seconds before connection timeout. (Default value is
0.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  max_allowed_packet

The maximum packet length to send to or receive from the server. (Default value is 16MB.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  max_join_size

The automatic limit for rows in a join when using
**--safe-updates**. (Default value is 1,000,000.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  net_buffer_length

The buffer size for TCP/IP and socket communication. (Default value is 16KB.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  select_limit

The automatic limit for
SELECT
statements when using
**--safe-updates**. (Default value is 1,000.)








On Unix, the
**mysql**
client writes a record of executed statements to a history file. By default, this file is named
.mysql_history
and is created in your home directory. To specify a different file, set the value of the
MYSQL_HISTFILE
environment variable.

The
.mysql_history
should be protected with a restrictive access mode because sensitive information might be written to it, such as the text of SQL statements that contain passwords.

If you do not want to maintain a history file, first remove
.mysql_history
if it exists, and then use either of the following techniques:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Set the
  MYSQL_HISTFILE
  variable to
  /dev/null. To cause this setting to take effect each time you log in, put the setting in one of your shell\'s startup files.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Create
  .mysql_history
  as a symbolic link to
  /dev/null:

.if n \{.RS 4
.\}
    shell> ln -s /dev/null $HOME/.mysql_history
.if n \{.RE
.\}

You need do this only once.

<a name="mysql-commands"></a>

# Mysql Commands


**mysql**
sends each SQL statement that you issue to the server to be executed. There is also a set of commands that
**mysql**
itself interprets. For a list of these commands, type
help
or
\eh
at the
mysql&gt;
prompt:


.if n \{.RS 4
.\}
    mysql> help
    List of all MySQL commands:
    Note that all text commands must be first on line and end with ';'
    ?         (e?) Synonym for `help'.
    clear     (ec) Clear command.
    connect   (er) Reconnect to the server. Optional arguments are db and host.
    delimiter (ed) Set statement delimiter.
    edit      (ee) Edit command with $EDITOR.
    ego       (eG) Send command to mysql server, display result vertically.
    exit      (eq) Exit mysql. Same as quit.
    go        (eg) Send command to mysql server.
    help      (eh) Display this help.
    nopager   (en) Disable pager, print to stdout.
    notee     (et) Don't write into outfile.
    pager     (eP) Set PAGER [to_pager]. Print the query results via PAGER.
    print     (ep) Print current command.
    prompt    (eR) Change your mysql prompt.
    quit      (eq) Quit mysql.
    rehash    (e#) Rebuild completion hash.
    source    (e.) Execute an SQL script file. Takes a file name as an argument.
    status    (es) Get status information from the server.
    system    (e!) Execute a system shell command.
    tee       (eT) Set outfile [to_outfile]. Append everything into given
                   outfile.
    use       (eu) Use another database. Takes database name as argument.
    charset   (eC) Switch to another charset. Might be needed for processing
                   binlog with multi-byte charsets.
    warnings  (eW) Show warnings after every statement.
    nowarning (ew) Don't show warnings after every statement.
    For server side help, type 'help contents'
.if n \{.RE
.\}

Each command has both a long and short form. The long form is not case sensitive; the short form is. The long form can be followed by an optional semicolon terminator, but the short form should not.

The use of short-form commands within multi-line
/* ... */
comments is not supported.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **help [****arg****]**,
  **\eh [****arg****]**,
  **\e? [****arg****]**,
  **? [****arg****]**

Display a help message listing the available
**mysql**
commands.

If you provide an argument to the
help
command,
**mysql**
uses it as a search string to access server-side help. For more information, see
the section called “MYSQL SERVER-SIDE HELP”.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **charset ****charset\_name**,
  **\eC ****charset\_name**

Change the default character set and issue a
SET NAMES
statement. This enables the character set to remain synchronized on the client and server if
**mysql**
is run with auto-reconnect enabled (which is not recommended), because the specified character set is used for reconnects.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **clear**,
  **\ec**

Clear the current input. Use this if you change your mind about executing the statement that you are entering.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **connect [****db\_name**** ****host\_name****]]**,
  **\er [****db\_name**** ****host\_name****]]**

Reconnect to the server. The optional database name and host name arguments may be given to specify the default database or the host where the server is running. If omitted, the current values are used.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **delimiter ****str**,
  **\ed ****str**

Change the string that
**mysql**
interprets as the separator between SQL statements. The default is the semicolon character (“;”).

The delimiter can be specified as an unquoted or quoted argument. Quoting can be done with either single quote (\') or douple quote (") characters. To include a quote within a quoted string, either quote the string with the other quote character or escape the quote with a backslash (“\e”) character. Backslash should be avoided outside of quoted strings because it is the escape character for MariaDB. For an unquoted argument, the delmiter is read up to the first space or end of line. For a quoted argument, the delimiter is read up to the matching quote on the line.

When the delimiter recognized by
**mysql**
is set to something other than the default of
“;”, instances of that character are sent to the server without interpretation. However, the server itself still interprets
“;”
as a statement delimiter and processes statements accordingly. This behavior on the server side comes into play for multiple-statement execution, and for parsing the body of stored procedures and functions, triggers, and events.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **edit**,
  **\ee**

Edit the current input statement.
**mysql**
checks the values of the
EDITOR
and
VISUAL
environment variables to determine which editor to use. The default editor is
**vi**
if neither variable is set.

The
**edit**
command works only in Unix.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **ego**,
  **\eG**

Send the current statement to the server to be executed and display the result using vertical format.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **exit**,
  **\eq**

Exit
**mysql**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **go**,
  **\eg**

Send the current statement to the server to be executed.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **nopager**,
  **\en**

Disable output paging. See the description for
**pager**.

The
**nopager**
command works only in Unix.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **notee**,
  **\et**

Disable output copying to the tee file. See the description for
**tee**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **nowarning**,
  **\ew**

Enable display of warnings after each statement.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **pager [****command****]**,
  **\eP [****command****]**

Enable output paging. By using the
**--pager**
option when you invoke
**mysql**, it is possible to browse or search query results in interactive mode with Unix programs such as
**less**,
**more**, or any other similar program. If you specify no value for the option,
**mysql**
checks the value of the
PAGER
environment variable and sets the pager to that. Pager functionality works only in interactive mode.

Output paging can be enabled interactively with the
**pager**
command and disabled with
**nopager**. The command takes an optional argument; if given, the paging program is set to that. With no argument, the pager is set to the pager that was set on the command line, or
stdout
if no pager was specified.

Output paging works only in Unix because it uses the
popen()
function, which does not exist on Windows. For Windows, the
**tee**
option can be used instead to save query output, although it is not as convenient as
**pager**
for browsing output in some situations.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **print**,
  **\ep**

Print the current input statement without executing it.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **prompt [****str****]**,
  **\eR [****str****]**

Reconfigure the
**mysql**
prompt to the given string. The special character sequences that can be used in the prompt are described later in this section.

If you specify the
prompt
command with no argument,
**mysql**
resets the prompt to the default of
mysql&gt;.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **quit**,
  **\eq**

Exit
**mysql**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **rehash**,
  **\e#**

Rebuild the completion hash that enables database, table, and column name completion while you are entering statements. (See the description for the
**--auto-rehash**
option.)

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **source ****file\_name**,
  **\e. ****file\_name**

Read the named file and executes the statements contained therein. On Windows, you can specify path name separators as
/
or
\e\e.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **status**,
  **\es**

Provide status information about the connection and the server you are using. If you are running in
**--safe-updates**
mode,
status
also prints the values for the
**mysql**
variables that affect your queries.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **system ****command**,
  **\e! ****command**

Execute the given command using your default command interpreter.

The
**system**
command works only in Unix.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **tee [****file\_name****]**,
  **\eT [****file\_name****]**

By using the
**--tee**
option when you invoke
**mysql**, you can log statements and their output. All the data displayed on the screen is appended into a given file. This can be very useful for debugging purposes also.
**mysql**
flushes results to the file after each statement, just before it prints its next prompt. Tee functionality works only in interactive mode.

You can enable this feature interactively with the
**tee**
command. Without a parameter, the previous file is used. The
**tee**
file can be disabled with the
**notee**
command. Executing
**tee**
again re-enables logging.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **use ****db\_name**,
  **\eu ****db\_name**

Use
_db\_name_
as the default database.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **warnings**,
  **\eW**

Enable display of warnings after each statement (if there are any).

Here are a few tips about the
**pager**
command:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  You can use it to write to a file and the results go only to the file:

.if n \{.RS 4
.\}
    mysql> pager cat > /tmp/log.txt
.if n \{.RE
.\}

You can also pass any options for the program that you want to use as your pager:

.if n \{.RS 4
.\}
    mysql> pager less -n -i -S
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  In the preceding example, note the
  **-S**
  option. You may find it very useful for browsing wide query results. Sometimes a very wide result set is difficult to read on the screen. The
  **-S**
  option to
  **less**
  can make the result set much more readable because you can scroll it horizontally using the left-arrow and right-arrow keys. You can also use
  **-S**
  interactively within
  **less**
  to switch the horizontal-browse mode on and off. For more information, read the
  **less**
  manual page:

.if n \{.RS 4
.\}
    shell> man less
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The
  **-F**
  and
  **-X**
  options may be used with
  **less**
  to cause it to exit if output fits on one screen, which is convenient when no scrolling is necessary:

.if n \{.RS 4
.\}
    mysql> pager less -n -i -S -F -X
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  You can specify very complex pager commands for handling query output:

.if n \{.RS 4
.\}
    mysql> pager cat | tee /dr1/tmp/res.txt e
              | tee /dr2/tmp/res2.txt | less -n -i -S
.if n \{.RE
.\}

In this example, the command would send query results to two files in two different directories on two different file systems mounted on
/dr1
and
/dr2, yet still display the results onscreen via
**less**.

You can also combine the
**tee**
and
**pager**
functions. Have a
**tee**
file enabled and
**pager**
set to
**less**, and you are able to browse the results using the
**less**
program and still have everything appended into a file the same time. The difference between the Unix
**tee**
used with the
**pager**
command and the
**mysql**
built-in
**tee**
command is that the built-in
**tee**
works even if you do not have the Unix
**tee**
available. The built-in
**tee**
also logs everything that is printed on the screen, whereas the Unix
**tee**
used with
**pager**
does not log quite that much. Additionally,
**tee**
file logging can be turned on and off interactively from within
**mysql**. This is useful when you want to log some queries to a file, but not others.


The
**prompt**
command reconfigures the default
mysql&gt;
prompt. The string for defining the prompt can contain the following special sequences.
.TS
allbox tab(:);
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l
l l.
T{
**Option**
T}:T{
**Description**
T}
T{
\ec
T}:T{
A counter that increments for each statement you issue
T}
T{
\eD
T}:T{
The full current date
T}
T{
\ed
T}:T{
The default database
T}
T{
\eh
T}:T{
The server host
T}
T{
\el
T}:T{
The current delimiter (new in 5.1.12)
T}
T{
\em
T}:T{
Minutes of the current time
T}
T{
\en
T}:T{
A newline character
T}
T{
\eO
T}:T{
The current month in three-letter format (Jan, Feb, ...)
T}
T{
\eo
T}:T{
The current month in numeric format
T}
T{
\eP
T}:T{
am/pm
T}
T{
\ep
T}:T{
The current TCP/IP port or socket file
T}
T{
\eR
T}:T{
The current time, in 24-hour military time (0–23)
T}
T{
\er
T}:T{
The current time, standard 12-hour time (1–12)
T}
T{
\eS
T}:T{
Semicolon
T}
T{
\es
T}:T{
Seconds of the current time
T}
T{
\et
T}:T{
A tab character
T}
T{
\eU
T}:T{

Your full
_user\_name_@_host\_name_
account name
T}
T{
\eu
T}:T{
Your user name
T}
T{
\ev
T}:T{
The server version
T}
T{
\ew
T}:T{
The current day of the week in three-letter format (Mon, Tue, ...)
T}
T{
\eY
T}:T{
The current year, four digits
T}
T{
\ey
T}:T{
The current year, two digits
T}
T{
\e_
T}:T{
A space
T}
T{
\e&nbsp;T}:T{
A space (a space follows the backslash)
T}
T{
\e\'
T}:T{
Single quote
T}
T{
\e"
T}:T{
Double quote
T}
T{
\e\e
T}:T{
A literal “\e” backslash character
T}
T{
\e_x_
T}:T{

_x_, for any
“_x_”
not listed above
T}
.TE


You can set the prompt in several ways:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Use an environment variable._
  You can set the
  MYSQL_PS1
  environment variable to a prompt string. For example:

.if n \{.RS 4
.\}
    shell> export MYSQL_PS1="(eu@eh) [ed]> "
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Use a command-line option._
  You can set the
  **--prompt**
  option on the command line to
  **mysql**. For example:

.if n \{.RS 4
.\}
    shell> mysql --prompt="(eu@eh) [ed]> "
    (user@host) [database]>
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Use an option file._
  You can set the
  prompt
  option in the
  [mysql]
  group of any MariaDB option file, such as
  /etc/my.cnf
  or the
  .my.cnf
  file in your home directory. For example:

.if n \{.RS 4
.\}
    [mysql]
    prompt=(eeu@eeh) [eed]>ee_
.if n \{.RE
.\}

In this example, note that the backslashes are doubled. If you set the prompt using the
prompt
option in an option file, it is advisable to double the backslashes when using the special prompt options. There is some overlap in the set of allowable prompt options and the set of special escape sequences that are recognized in option files. The overlap may cause you problems if you use single backslashes. For example,
\es
is interpreted as a space rather than as the current seconds value. The following example shows how to define a prompt within an option file to include the current time in
HH:MM:SS&gt;
format:

.if n \{.RS 4
.\}
    [mysql]
    prompt="eer:eem:ees> "
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  _Set the prompt interactively._
  You can change your prompt interactively by using the
  prompt
  (or
  \eR) command. For example:

.if n \{.RS 4
.\}
    mysql> prompt (eu@eh) [ed]>e_
    PROMPT set to '(eu@eh) [ed]>e_'
    (user@host) [database]>
    (user@host) [database]> prompt
    Returning to default PROMPT of mysql>
    mysql>
.if n \{.RE
.\}

<a name="mysql-server-side-help"></a>

# Mysql Server-Side Help


.if n \{.RS 4
.\}
    mysql> help search_string
.if n \{.RE
.\}

If you provide an argument to the
help
command,
**mysql**
uses it as a search string to access server-side help. The proper operation of this command requires that the help tables in the
mysql
database be initialized with help topic information.

If there is no match for the search string, the search fails:

.if n \{.RS 4
.\}
    mysql> help me
    Nothing found
    Please try to run 'help contents' for a list of all accessible topics
.if n \{.RE
.\}

Use
**help contents**
to see a list of the help categories:

.if n \{.RS 4
.\}
    mysql> help contents
    You asked for help about help category: "Contents"
    For more information, type 'help <item>', where <item> is one of the
    following categories:
       Account Management
       Administration
       Data Definition
       Data Manipulation
       Data Types
       Functions
       Functions and Modifiers for Use with GROUP BY
       Geographic Features
       Language Structure
       Plugins
       Storage Engines
       Stored Routines
       Table Maintenance
       Transactions
       Triggers
.if n \{.RE
.\}

If the search string matches multiple items,
**mysql**
shows a list of matching topics:

.if n \{.RS 4
.\}
    mysql> help logs
    Many help items for your request exist.
    To make a more specific request, please type 'help <item>',
    where <item> is one of the following topics:
       SHOW
       SHOW BINARY LOGS
       SHOW ENGINE
       SHOW LOGS
.if n \{.RE
.\}

Use a topic as the search string to see the help entry for that topic:

.if n \{.RS 4
.\}
    mysql> help show binary logs
    Name: 'SHOW BINARY LOGS'
    Description:
    Syntax:
    SHOW BINARY LOGS
    SHOW MASTER LOGS
    Lists the binary log files on the server. This statement is used as
    part of the procedure described in [purge-binary-logs], that shows how
    to determine which logs can be purged.
    mysql> SHOW BINARY LOGS;
    +---------------+-----------+
    | Log_name      | File_size |
    +---------------+-----------+
    | binlog.000015 |    724935 |
    | binlog.000016 |    733481 |
    +---------------+-----------+
.if n \{.RE
.\}

<a name="executing-sql-statements-from-a-text-file"></a>

# Executing Sql Statements from a Text File











The
**mysql**
client typically is used interactively, like this:

.if n \{.RS 4
.\}
    shell> mysql db_name
.if n \{.RE
.\}

However, it is also possible to put your SQL statements in a file and then tell
**mysql**
to read its input from that file. To do so, create a text file
_text\_file_
that contains the statements you wish to execute. Then invoke
**mysql**
as shown here:

.if n \{.RS 4
.\}
    shell> mysql db_name < text_file
.if n \{.RE
.\}

If you place a
USE _db\_name_
statement as the first statement in the file, it is unnecessary to specify the database name on the command line:

.if n \{.RS 4
.\}
    shell> mysql < text_file
.if n \{.RE
.\}

If you are already running
**mysql**, you can execute an SQL script file using the
source
command or
\e.
command:

.if n \{.RS 4
.\}
    mysql> source file_name
    mysql> e. file_name
.if n \{.RE
.\}

Sometimes you may want your script to display progress information to the user. For this you can insert statements like this:

.if n \{.RS 4
.\}
    SELECT '<info_to_display>' AS ' ';
.if n \{.RE
.\}

The statement shown outputs
&lt;info_to_display&gt;.

You can also invoke
**mysql**
with the
**--verbose**
option, which causes each statement to be displayed before the result that it produces.

**mysql**
ignores Unicode byte order mark (BOM) characters at the beginning of input files. Presence of a BOM does not cause
**mysql**
to change its default character set. To do that, invoke
**mysql**
with an option such as
**--default-character-set=utf8**.


<a name="mysql-tips"></a>

# Mysql Tips


This section describes some techniques that can help you use
**mysql**
more effectively.

<a name="displaying-query-results-vertically"></a>

### Displaying Query Results Vertically


Some query results are much more readable when displayed vertically, instead of in the usual horizontal table format. Queries can be displayed vertically by terminating the query with \eG instead of a semicolon. For example, longer text values that include newlines often are much easier to read with vertical output:

.if n \{.RS 4
.\}
    mysql> SELECT * FROM mails WHERE LENGTH(txt) < 300 LIMIT 300,1eG
    *************************** 1. row ***************************
      msg_nro: 3068
         date: 2000-03-01 23:29:50
    time_zone: +0200
    mail_from: Monty
        reply: monty@no.spam.com
      mail_to: "Thimble Smith" <tim@no.spam.com>
          sbj: UTF-8
          txt: >>>>> "Thimble" == Thimble Smith writes:
    Thimble> Hi.  I think this is a good idea.  Is anyone familiar
    Thimble> with UTF-8 or Unicode? Otherwise, I'll put this on my
    Thimble> TODO list and see what happens.
    Yes, please do that.
    Regards,
    Monty
         file: inbox-jani-1
         hash: 190402944
    1 row in set (0.09 sec)
.if n \{.RE
.\}

<a name="using-the-safe-updates-option"></a>

### Using the \-\-safe\-updates Option



For beginners, a useful startup option is
**--safe-updates**
(or
**--i-am-a-dummy**, which has the same effect). It is helpful for cases when you might have issued a
DELETE FROM _tbl\_name_
statement but forgotten the
WHERE
clause. Normally, such a statement deletes all rows from the table. With
**--safe-updates**, you can delete rows only by specifying the key values that identify them. This helps prevent accidents.

When you use the
**--safe-updates**
option,
**mysql**
issues the following statement when it connects to the MariaDB server:

.if n \{.RS 4
.\}
    SET sql_safe_updates=1, sql_select_limit=1000, sql_max_join_size=1000000;
.if n \{.RE
.\}

The
SET
statement has the following effects:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  You are not allowed to execute an
  UPDATE
  or
  DELETE
  statement unless you specify a key constraint in the
  WHERE
  clause or provide a
  LIMIT
  clause (or both). For example:

.if n \{.RS 4
.\}
    UPDATE tbl_name SET not_key_column=val WHERE key_column=val;
    UPDATE tbl_name SET not_key_column=val LIMIT 1;
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The server limits all large
  SELECT
  results to 1,000 rows unless the statement includes a
  LIMIT
  clause.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The server aborts multiple-table
  SELECT
  statements that probably need to examine more than 1,000,000 row combinations.

To specify limits different from 1,000 and 1,000,000, you can override the defaults by using the
**--select-limit**
and
**--max-join-size**
options:

.if n \{.RS 4
.\}
    shell> mysql --safe-updates --select-limit=500 --max-join-size=10000
.if n \{.RE
.\}

<a name="disabling-mysql-auto-reconnect"></a>

### Disabling mysql Auto\-Reconnect


If the
**mysql**
client loses its connection to the server while sending a statement, it immediately and automatically tries to reconnect once to the server and send the statement again. However, even if
**mysql**
succeeds in reconnecting, your first connection has ended and all your previous session objects and settings are lost: temporary tables, the autocommit mode, and user-defined and session variables. Also, any current transaction rolls back. This behavior may be dangerous for you, as in the following example where the server was shut down and restarted between the first and second statements without you knowing it:

.if n \{.RS 4
.\}
    mysql> SET @a=1;
    Query OK, 0 rows affected (0.05 sec)
    mysql> INSERT INTO t VALUES(@a);
    ERROR 2006: MySQL server has gone away
    No connection. Trying to reconnect...
    Connection id:    1
    Current database: test
    Query OK, 1 row affected (1.30 sec)
    mysql> SELECT * FROM t;
    +------+
    | a    |
    +------+
    | NULL |
    +------+
    1 row in set (0.05 sec)
.if n \{.RE
.\}

The
@a
user variable has been lost with the connection, and after the reconnection it is undefined. If it is important to have
**mysql**
terminate with an error if the connection has been lost, you can start the
**mysql**
client with the
**--skip-reconnect**
option.


<a name="copyright"></a>

# Copyright
  

Copyright 2007-2008 MySQL AB, 2008-2010 Sun Microsystems, Inc., 2010-2015 MariaDB Foundation

This documentation is free software; you can redistribute it and/or modify it only under the terms of the GNU General Public License as published by the Free Software Foundation; version 2 of the License.

This documentation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with the program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335 USA or see http://www.gnu.org/licenses/.


<a name="notes"></a>

# Notes


*  1.  
  Bug#25946
      http://bugs.mysql.com/bug.php?id=25946

<a name="see-also"></a>

# See Also

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/

<a name="author"></a>

# Author

MariaDB Foundation (http://www.mariadb.org/).
