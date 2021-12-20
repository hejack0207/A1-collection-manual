# drop text search parser(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TEXT_SEARCH_PARSER - remove a text search parser

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TEXT SEARCH PARSER [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP TEXT SEARCH PARSER**
drops an existing text search parser. You must be a superuser to use this command.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the text search parser does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing text search parser.

CASCADE
Automatically drop objects that depend on the text search parser, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the text search parser if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Remove the text search parser
my_parser:

.if n \{.RS 4
.\}
    DROP TEXT SEARCH PARSER my_parser;
.if n \{.RE
.\}

This command will not succeed if there are any existing text search configurations that use the parser. Add
CASCADE
to drop such configurations along with the parser.

<a name="compatibility"></a>

# Compatibility


There is no
**DROP TEXT SEARCH PARSER**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TEXT SEARCH PARSER (**ALTER\_TEXT\_SEARCH\_PARSER**(7)), CREATE TEXT SEARCH PARSER (**CREATE\_TEXT\_SEARCH\_PARSER**(7))
