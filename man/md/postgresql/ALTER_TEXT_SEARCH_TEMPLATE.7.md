# alter text search template(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_TEXT_SEARCH_TEMPLATE - change the definition of a text search template

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER TEXT SEARCH TEMPLATE name RENAME TO new_name
    ALTER TEXT SEARCH TEMPLATE name SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER TEXT SEARCH TEMPLATE**
changes the definition of a text search template. Currently, the only supported functionality is to change the templates name.

You must be a superuser to use
**ALTER TEXT SEARCH TEMPLATE**.

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing text search template.

_new\_name_
The new name of the text search template.

_new\_schema_
The new schema for the text search template.

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER TEXT SEARCH TEMPLATE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE TEXT SEARCH TEMPLATE (**CREATE\_TEXT\_SEARCH\_TEMPLATE**(7)), DROP TEXT SEARCH TEMPLATE (**DROP\_TEXT\_SEARCH\_TEMPLATE**(7))
