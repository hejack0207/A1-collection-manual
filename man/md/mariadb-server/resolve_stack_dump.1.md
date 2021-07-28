# \fbresolve_stack_dum(1)

MariaDB 10\&.3, 9 May 2017

.nh






<a name="name"></a>

# Name

resolve_stack_dump - resolve numeric stack trace dump to symbols

<a name="synopsis"></a>

# Synopsis

```
.HP \w'resolve_stack_dump&nbsp;[options]&nbsp;symbols_file&nbsp;[numeric_dump_file]&nbsp;'u resolve_stack_dump [options] symbols_file [numeric_dump_file]
```

<a name="description"></a>

# Description


**resolve\_stack\_dump**
resolves a numeric stack dump to symbols.

Invoke
**resolve\_stack\_dump**
like this:

.if n \{.RS 4
.\}
    shell> resolve_stack_dump [options] symbols_file [numeric_dump_file]
.if n \{.RE
.\}

The symbols file should include the output from the
**nm --numeric-sort mysqld**
command. The numeric dump file should contain a numeric stack track from
**mysqld**. If no numeric dump file is named on the command line, the stack trace is read from the standard input.

**resolve\_stack\_dump**
supports the following options.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**,
  **-h**

Display a help message and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--numeric-dump-file=****file\_name**,
  **-n ****file\_name**

Read the stack trace from the given file.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--symbols-file=****file\_name**,
  **-s ****file\_name**

Use the given symbols file.

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
