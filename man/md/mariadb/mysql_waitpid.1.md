# \fbmysql_waitpid\fr(1)

MariaDB 10\&.4, 28 March 2019

.nh






<a name="name"></a>

# Name

mysql_waitpid - kill process and wait for its termination

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysql_waitpid&nbsp;[options]&nbsp;pid&nbsp;wait_time&nbsp;'u mysql_waitpid [options] pid wait_time
```

<a name="description"></a>

# Description


**mysql\_waitpid**
signals a process to terminate and waits for the process to exit. It uses the
kill()
system call and Unix signals, so it runs on Unix and Unix-like systems.

Invoke
**mysql\_waitpid**
like this:

.if n \{.RS 4
.\}
    shell> mysql_waitpid [options] pid wait_time
.if n \{.RE
.\}

**mysql\_waitpid**
sends signal 0 to the process identified by
_pid_
and waits up to
_wait\_time_
seconds for the process to terminate.
_pid_
and
_wait\_time_
must be positive integers.

If process termination occurs within the wait time or the process does not exist,
**mysql\_waitpid**
returns 0. Otherwise, it returns 1.

If the
kill()
system call cannot handle signal 0,
**mysql\_waitpid()**
uses signal 1 instead.

**mysql\_waitpid**
supports the following options:

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
  
  
  **--verbose**,
  **-v**

Verbose mode. Display a warning if signal 0 could not be used and signal 1 is used instead.

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
