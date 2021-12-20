# show(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

SHOW - show the value of a run-time parameter

<a name="synopsis"></a>

# Synopsis

```


```
    SHOW name
    SHOW ALL

<a name="description"></a>

# Description


**SHOW**
will display the current setting of run-time parameters. These variables can be set using the
**SET**
statement, by editing the
postgresql.conf
configuration file, through the
**PGOPTIONS**
environmental variable (when using
libpq
or a
libpq-based application), or through command-line flags when starting the
**postgres**
server. See
Chapter&nbsp;19
for details.

<a name="parameters"></a>

# Parameters


_name_
The name of a run-time parameter. Available parameters are documented in
Chapter&nbsp;19
and on the
**SET**(7)
reference page. In addition, there are a few parameters that can be shown but not set:

SERVER_VERSION
Shows the servers version number.

SERVER_ENCODING
Shows the server-side character set encoding. At present, this parameter can be shown but not set, because the encoding is determined at database creation time.

LC_COLLATE
Shows the databases locale setting for collation (text ordering). At present, this parameter can be shown but not set, because the setting is determined at database creation time.

LC_CTYPE
Shows the databases locale setting for character classification. At present, this parameter can be shown but not set, because the setting is determined at database creation time.

IS_SUPERUSER
True if the current role has superuser privileges.

ALL
Show the values of all configuration parameters, with descriptions.

<a name="notes"></a>

# Notes


The function
**current\_setting**
produces equivalent output; see
Section&nbsp;9.26. Also, the
pg_settings
system view produces the same information.

<a name="examples"></a>

# Examples


Show the current setting of the parameter
_DateStyle_:

.if n \{.RS 4
.\}
    SHOW DateStyle;
     DateStyle
    -----------
     ISO, MDY
    (1 row)
.if n \{.RE
.\}

Show the current setting of the parameter
_geqo_:

.if n \{.RS 4
.\}
    SHOW geqo;
     geqo
    ------
     on
    (1 row)
.if n \{.RE
.\}

Show all settings:

.if n \{.RS 4
.\}
    SHOW ALL;
                name         | setting |                description                                                          
    -------------------------+---------+-------------------------------------------------
     allow_system_table_mods | off     | Allows modifications of the structure of ...
        .
        .
        .
     xmloption               | content | Sets whether XML data in implicit parsing ...
     zero_damaged_pages      | off     | Continues processing past damaged page headers.
    (196 rows)
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


The
**SHOW**
command is a
PostgreSQL
extension.

<a name="see-also"></a>

# See Also

**SET**(7), **RESET**(7)
