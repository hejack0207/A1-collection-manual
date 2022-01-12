# drop text search configuration(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TEXT_SEARCH_CONFIGURATION - remove a text search configuration

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TEXT SEARCH CONFIGURATION [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP TEXT SEARCH CONFIGURATION**
drops an existing text search configuration. To execute this command you must be the owner of the configuration.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the text search configuration does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing text search configuration.

CASCADE
Automatically drop objects that depend on the text search configuration, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the text search configuration if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Remove the text search configuration
my_english:

.if n \{.RS 4
.\}
    DROP TEXT SEARCH CONFIGURATION my_english;
.if n \{.RE
.\}

This command will not succeed if there are any existing indexes that reference the configuration in
**to\_tsvector**
calls. Add
CASCADE
to drop such indexes along with the text search configuration.

<a name="compatibility"></a>

# Compatibility


There is no
**DROP TEXT SEARCH CONFIGURATION**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TEXT SEARCH CONFIGURATION (**ALTER\_TEXT\_SEARCH\_CONFIGURATION**(7)), CREATE TEXT SEARCH CONFIGURATION (**CREATE\_TEXT\_SEARCH\_CONFIGURATION**(7))
