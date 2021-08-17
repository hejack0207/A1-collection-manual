# \fbresolveip\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh






<a name="name"></a>

# Name

resolveip - resolve host name to IP address or vice versa

<a name="synopsis"></a>

# Synopsis

```
.HP \w'resolveip&nbsp;[options]&nbsp;{host_name|ip-addr}&nbsp;...&nbsp;'u resolveip [options] {host_name|ip-addr} ...
```

<a name="description"></a>

# Description


The
**resolveip**
utility resolves host names to IP addresses and vice versa.

Invoke
**resolveip**
like this:

.if n \{.RS 4
.\}
    shell> resolveip [options] {host_name|ip-addr} ...
.if n \{.RE
.\}

**resolveip**
supports the following options.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**,
  **--info**,
  **-?**,
  **-I**

Display a help message and exit.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--silent**,
  **-s**

Silent mode. Produce less output.

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
