# \fbmysqld_safe\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh








<a name="name"></a>

# Name

mysqld_safe - MariaDB server startup script

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysqld_safe&nbsp;options&nbsp;'u mysqld_safe options
```

<a name="description"></a>

# Description


**mysqld\_safe**
is the recommended way to start a
**mysqld**
server on Unix.
**mysqld\_safe**
adds some safety features such as restarting the server when an error occurs and logging runtime information to an error log file. Descriptions of error logging is given later in this section.

**mysqld\_safe**
tries to start an executable named
**mysqld**. To override the default behavior and specify explicitly the name of the server you want to run, specify a
**--mysqld**
or
**--mysqld-version**
option to
**mysqld\_safe**. You can also use
**--ledir**
to indicate the directory where
**mysqld\_safe**
should look for the server.

Many of the options to
**mysqld\_safe**
are the same as the options to
**mysqld**.

Options unknown to
**mysqld\_safe**
are passed to
**mysqld**
if they are specified on the command line, but ignored if they are specified in the
[mysqld_safe] or [mariadb_safe]
groups of an option file.

**mysqld\_safe**
reads all options from the
[mysqld],
[server],
[mysqld_safe], and [mariadb_safe]
sections in option files. For example, if you specify a
[mysqld]
section like this,
**mysqld\_safe**
will find and use the
**--log-error**
option:

.if n \{.RS 4
.\}
    [mysqld]
    log-error=error.log
.if n \{.RE
.\}

For backward compatibility,
**mysqld\_safe**
also reads
[safe_mysqld]
sections, although you should rename such sections to
[mysqld_safe]
in current installations.

**mysqld\_safe**
supports the options in the following list. It also reads option files and supports the options for processing them.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**

Display a help message and exit.

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
  
  
  **--core-file-size=****size**

The size of the core file that
**mysqld**
should be able to create. The option value is passed to
**ulimit -c**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--crash-script=****file**

Script to call in the event of mysqld crashing.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--datadir=****path**

The path to the data directory.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-extra-file=****path**

The name of an option file to be read in addition to the usual option files. This must be the first option on the command line if it is used. If the file does not exist or is otherwise inaccessible, the server will exit with an error.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--defaults-file=****file\_name**

The name of an option file to be read instead of the usual option files. This must be the first option on the command line if it is used.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--flush-caches**

Flush and purge buffers/caches before starting the server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--ledir=****path**

If
**mysqld\_safe**
cannot find the server, use this option to indicate the path name to the directory where the server is located.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--log-error=****file\_name**

Write the error log to the given file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--malloc-lib=****lib**

Preload shared library lib if available.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--mysqld=****prog\_name**

The name of the server program (in the
ledir
directory) that you want to start. This option is needed if you use the MariaDB binary distribution but have the data directory outside of the binary distribution. If
**mysqld\_safe**
cannot find the server, use the
**--ledir**
option to indicate the path name to the directory where the server is located.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--mysqld-version=****suffix**

This option is similar to the
**--mysqld**
option, but you specify only the suffix for the server program name. The basename is assumed to be
**mysqld**. For example, if you use
**--mysqld-version=debug**,
**mysqld\_safe**
starts the
**mysqld-debug**
program in the
ledir
directory. If the argument to
**--mysqld-version**
is empty,
**mysqld\_safe**
uses
**mysqld**
in the
ledir
directory.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--nice=****priority**

Use the
nice
program to set the server\'s scheduling priority to the given value.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-auto-restart**

Exit after starting mysqld.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-defaults**

Do not read any option files. This must be the first option on the command line if it is used.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-auto-restart**

Exit after starting mysqld.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--numa-interleave**

Run mysqld with its memory interleaved on all NUMA nodes.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--open-files-limit=****count**

The number of files that
**mysqld**
should be able to open. The option value is passed to
**ulimit -n**. Note that you need to start
**mysqld\_safe**
as
root
for this to work properly!

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--pid-file=****file\_name**

The path name of the process ID file.

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
  
  
  **--port=****port\_num**

The port number that the server should use when listening for TCP/IP connections. The port number must be 1024 or higher unless the server is started by the
root
system user.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--skip-kill-mysqld**

Do not try to kill stray
**mysqld**
processes at startup. This option works only on Linux.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--socket=****path**

The Unix socket file that the server should use when listening for local connections.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  
  
  **--syslog**,
  **--skip-syslog**

**--syslog**
causes error messages to be sent to
syslog
on systems that support the
**logger**
program.
--skip-syslog
suppresses the use of
syslog; messages are written to an error log file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--syslog-tag=****tag**

For logging to
syslog, messages from
**mysqld\_safe**
and
**mysqld**
are written with a tag of
mysqld_safe
and
mysqld, respectively. To specify a suffix for the tag, use
**--syslog-tag=****tag**, which modifies the tags to be
mysqld\_safe-_tag_
and
mysqld-_tag_.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--timezone=****timezone**

Set the
TZ
time zone environment variable to the given option value. Consult your operating system documentation for legal time zone specification formats.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--user={****user\_name****|****user\_id****}**

Run the
**mysqld**
server as the user having the name
_user\_name_
or the numeric user ID
_user\_id_. (“User”
in this context refers to a system login account, not a MariaDB user listed in the grant tables.)

If you execute
**mysqld\_safe**
with the
**--defaults-file**
or
**--defaults-extra-file**
option to name an option file, the option must be the first one given on the command line or the option file will not be used. For example, this command will not use the named option file:

.if n \{.RS 4
.\}
    mysql> mysqld_safe --port=port_num --defaults-file=file_name
.if n \{.RE
.\}

Instead, use the following command:

.if n \{.RS 4
.\}
    mysql> mysqld_safe --defaults-file=file_name --port=port_num
.if n \{.RE
.\}

The
**mysqld\_safe**
script is written so that it normally can start a server that was installed from either a source or a binary distribution of MariaDB, even though these types of distributions typically install the server in slightly different locations.
**mysqld\_safe**
expects one of the following conditions to be true:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  The server and databases can be found relative to the working directory (the directory from which
  **mysqld\_safe**
  is invoked). For binary distributions,
  **mysqld\_safe**
  looks under its working directory for
  bin
  and
  data
  directories. For source distributions, it looks for
  libexec
  and
  var
  directories. This condition should be met if you execute
  **mysqld\_safe**
  from your MariaDB installation directory (for example,
  /usr/local/mysql
  for a binary distribution).

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If the server and databases cannot be found relative to the working directory,
  **mysqld\_safe**
  attempts to locate them by absolute path names. Typical locations are
  /usr/local/libexec
  and
  /usr/local/var. The actual locations are determined from the values configured into the distribution at the time it was built. They should be correct if MariaDB is installed in the location specified at configuration time.

Because
**mysqld\_safe**
tries to find the server and databases relative to its own working directory, you can install a binary distribution of MariaDB anywhere, as long as you run
**mysqld\_safe**
from the MariaDB installation directory:

.if n \{.RS 4
.\}
    shell> cd mysql_installation_directory
    shell> bin/mysqld_safe &
.if n \{.RE
.\}

If
**mysqld\_safe**
fails, even when invoked from the MariaDB installation directory, you can specify the
**--ledir**
and
**--datadir**
options to indicate the directories in which the server and databases are located on your system.

When you use
**mysqld\_safe**
to start
**mysqld**,
**mysqld\_safe**
arranges for error (and notice) messages from itself and from
**mysqld**
to go to the same destination.

There are several
**mysqld\_safe**
options for controlling the destination of these messages:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **--syslog**: Write error messages to
  syslog
  on systems that support the
  **logger**
  program.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **--skip-syslog**: Do not write error messages to
  syslog. Messages are written to the default error log file (_host\_name_.err
  in the data directory), or to a named file if the
  **--log-error**
  option is given.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  **--log-error=****file\_name**: Write error messages to the named error file.

If none of these options is given, the default is
**--skip-syslog**.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  



If
**--syslog**
and
**--log-error**
are both given, a warning is issued and
**--log-error**
takes precedence.

When
**mysqld\_safe**
writes a message, notices go to the logging destination (syslog
or the error log file) and
stdout. Errors go to the logging destination and
stderr.

Normally, you should not edit the
**mysqld\_safe**
script. Instead, configure
**mysqld\_safe**
by using command-line options or options in the
[mysqld_safe]
section of a
my.cnf
option file. In rare cases, it might be necessary to edit
**mysqld\_safe**
to get it to start the server properly. However, if you do this, your modified version of
**mysqld\_safe**
might be overwritten if you upgrade MariaDB in the future, so you should make a copy of your edited version that you can reinstall.

On NetWare,
**mysqld\_safe**
is a NetWare Loadable Module (NLM) that is ported from the original Unix shell script. It starts the server as follows:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Runs a number of system and option checks.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  Runs a check on
  MyISAM
  tables.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Provides a screen presence for the MariaDB server.

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  Starts
  **mysqld**, monitors it, and restarts it if it terminates in error.

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  Sends error messages from
  **mysqld**
  to the
  _host\_name_.err
  file in the data directory.

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  Sends
  **mysqld\_safe**
  screen output to the
  _host\_name_.safe
  file in the data directory.

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
