# \fbmysql_tzinfo_to_s(1)

MariaDB 10\&.3, 9 May 2017

.nh







<a name="name"></a>

# Name

mysql_tzinfo_to_sql - load the time zone tables

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysql_tzinfo_to_sql&nbsp;arguments&nbsp;'u mysql_tzinfo_to_sql arguments
```

<a name="description"></a>

# Description


The
**mysql\_tzinfo\_to\_sql**
program loads the time zone tables in the
mysql
database. It is used on systems that have a
zoneinfo
database (the set of files describing time zones). Examples of such systems are Linux, FreeBSD, Solaris, and Mac OS X. One likely location for these files is the
/usr/share/zoneinfo
directory (/usr/share/lib/zoneinfo
on Solaris).

**mysql\_tzinfo\_to\_sql**
can be invoked several ways:

.if n \{.RS 4
.\}
    shell> mysql_tzinfo_to_sql tz_dir
    shell> mysql_tzinfo_to_sql tz_file tz_name
    shell> mysql_tzinfo_to_sql --leap tz_file
.if n \{.RE
.\}

For the first invocation syntax, pass the zoneinfo directory path name to
**mysql\_tzinfo\_to\_sql**
and send the output into the
**mysql**
program. For example:

.if n \{.RS 4
.\}
    shell> mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
.if n \{.RE
.\}

**mysql\_tzinfo\_to\_sql**
reads your system\'s time zone files and generates SQL statements from them.
**mysql**
processes those statements to load the time zone tables.

The second syntax causes
**mysql\_tzinfo\_to\_sql**
to load a single time zone file
_tz\_file_
that corresponds to a time zone name
_tz\_name_:

.if n \{.RS 4
.\}
    shell> mysql_tzinfo_to_sql tz_file tz_name | mysql -u root mysql
.if n \{.RE
.\}

If your time zone needs to account for leap seconds, invoke
**mysql\_tzinfo\_to\_sql**
using the third syntax, which initializes the leap second information.
_tz\_file_
is the name of your time zone file:

.if n \{.RS 4
.\}
    shell> mysql_tzinfo_to_sql --leap tz_file | mysql -u root mysql
.if n \{.RE
.\}

After running
**mysql\_tzinfo\_to\_sql**, it is best to restart the server so that it does not continue to use any previously cached time zone data.

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
