# \fbmysql_plugin\fr(1)

MariaDB 10\&.4, 28 March 2019

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh






<a name="name"></a>

# Name

mysql_plugin - configure MariaDB server plugins

<a name="synopsis"></a>

# Synopsis

```
.HP \w'mysql_plugin&nbsp;[options]&nbsp;plugin&nbsp;{ENABLE|DISABLE}&nbsp;'u mysql_plugin [options] plugin {ENABLE|DISABLE}
```

<a name="description"></a>

# Description


The
**mysql\_plugin**
utility enables MariaDB administrators to manage which plugins a MariaDB server loads. It provides an alternative to manually specifying the
**--plugin-load**
option at server startup or using the
INSTALL PLUGIN
and
UNINSTALL PLUGIN
statements at runtime.

Depending on whether
**mysql\_plugin**
is invoked to enable or disable plugins, it inserts or deletes rows in the
mysql.plugin
table that serves as a plugin registry. (To perform this operation,
**mysql\_plugin**
invokes the MariaDB server in bootstrap mode. This means that the server must not already be running.) For normal server startups, the server loads and enables plugins listed in
mysql.plugin
automatically. For additional control over plugin activation, use
**--****plugin\_name**
options named for specific plugins.

Each invocation of
**mysql\_plugin**
reads a configuration file to determine how to configure the plugins contained in a single plugin library object file. To invoke
**mysql\_plugin**, use this syntax:

.if n \{.RS 4
.\}
    mysql_plugin [options] plugin {ENABLE|DISABLE}
.if n \{.RE
.\}

_plugin_
is the name of the plugin to configure.
ENABLE
or
DISABLE
(not case sensitive) specify whether to enable or disable components of the plugin library named in the configuration file. The order of the
_plugin_
and
ENABLE
or
DISABLE
arguments does not matter.

For example, to configure components of a plugin library file named
myplugins.so
on Linux or
myplugins.dll
on Windows, specify a
_plugin_
value of
myplugins. Suppose that this plugin library contains three plugins,
plugin1,
plugin2, and
plugin3, all of which should be configured under
**mysql\_plugin**
control. By convention, configuration files have a suffix of
.ini
and the same basename as the plugin library, so the default configuration file name for this plugin library is
myplugins.ini. The configuration file contents look like this:

.if n \{.RS 4
.\}
    myplugins
    plugin1
    plugin2
    plugin3
.if n \{.RE
.\}

The first line in the
myplugins.ini
file is the name of the library object file, without any extension such as
.so
or
.dll. The remaining lines are the names of the components to be enabled or disabled. Each value in the file should be on a separate line. Lines on which the first character is
#\*(Aq
are taken as comments and ignored.

To enable the plugins listed in the configuration file, invoke
**mysql\_plugin**
this way:

.if n \{.RS 4
.\}
    shell> mysql_plugin myplugins ENABLE
.if n \{.RE
.\}

To disable the plugins, use
DISABLE
rather than
ENABLE.

An error occurs if
**mysql\_plugin**
cannot find the configuration file or plugin library file, or if
**mysql\_plugin**
cannot start the MariaDB server.

**mysql\_plugin**
supports the following options, which can be specified on the command line or in the
[mysqld]
group of any option file. For options specified in a
[mysqld]
group,
**mysql\_plugin**
recognizes the
**--basedir**,
**--datadir**, and
**--plugin-dir**
options and ignores others.

mysql_plugin Options

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
  
  
  **--basedir=****path**,
  **-b ****path**

The server base directory.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--datadir=****path**,
  **-d ****path**

The server data directory.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--my-print-defaults=****path**,
  **-b ****path**

The path to the
**my\_print\_defaults**
program.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--mysqld=****path**,
  **-b ****path**

The path to the
**mysqld**
server.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--no-defaults**,
  **-p**

Do not read values from the configuration file. This option enables an administrator to skip reading defaults from the configuration file.

With
**mysql\_plugin**, this option need not be given first on the command line, unlike most other MariaDB programs that support
**--no-defaults**.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--plugin-dir=****path**,
  **-p ****path**

The server plugin directory.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--plugin-ini=****file\_name**,
  **-i ****file\_name**

The
**mysql\_plugin**
configuration file. Relative path names are interpreted relative to the current directory. If this option is not given, the default is
_plugin_.ini
in the plugin directory, where
_plugin_
is the
_plugin_
argument on the command line.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--print-defaults**,
  **-P**

Display the default values from the configuration file. This option causes
**mysql\_plugin**
to print the defaults for
**--basedir**,
**--datadir**, and
**--plugin-dir**
if they are found in the configuration file. If no value for a variable is found, nothing is shown.

With
**mysql\_plugin**, this option need not be given first on the command line, unlike most other MariaDB programs that support
**--print-defaults**.

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
  

Copyright © 1997, 2013, Oracle and/or its affiliates. All rights reserved., 2013-2015 MariaDB Foundation

This documentation is free software; you can redistribute it and/or modify it only under the terms of the GNU General Public License as published by the Free Software Foundation; version 2 of the License.

This documentation is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with the program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335 USA or see http://www.gnu.org/licenses/.


<a name="see-also"></a>

# See Also

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/

<a name="author"></a>

# Author

MariaDB Foundation (http://www.mariadb.org/).
