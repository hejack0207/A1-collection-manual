# alter text search parser(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_TEXT_SEARCH_PARSER - change the definition of a text search parser

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER TEXT SEARCH PARSER name RENAME TO new_name
    ALTER TEXT SEARCH PARSER name SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER TEXT SEARCH PARSER**
changes the definition of a text search parser. Currently, the only supported functionality is to change the parsers name.

You must be a superuser to use
**ALTER TEXT SEARCH PARSER**.

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing text search parser.

_new\_name_
The new name of the text search parser.

_new\_schema_
The new schema for the text search parser.

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER TEXT SEARCH PARSER**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE TEXT SEARCH PARSER (**CREATE\_TEXT\_SEARCH\_PARSER**(7)), DROP TEXT SEARCH PARSER (**DROP\_TEXT\_SEARCH\_PARSER**(7))
