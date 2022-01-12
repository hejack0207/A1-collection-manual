# drop text search template(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TEXT_SEARCH_TEMPLATE - remove a text search template

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TEXT SEARCH TEMPLATE [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP TEXT SEARCH TEMPLATE**
drops an existing text search template. You must be a superuser to use this command.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the text search template does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing text search template.

CASCADE
Automatically drop objects that depend on the text search template, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the text search template if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Remove the text search template
thesaurus:

.if n \{.RS 4
.\}
    DROP TEXT SEARCH TEMPLATE thesaurus;
.if n \{.RE
.\}

This command will not succeed if there are any existing text search dictionaries that use the template. Add
CASCADE
to drop such dictionaries along with the template.

<a name="compatibility"></a>

# Compatibility


There is no
**DROP TEXT SEARCH TEMPLATE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TEXT SEARCH TEMPLATE (**ALTER\_TEXT\_SEARCH\_TEMPLATE**(7)), CREATE TEXT SEARCH TEMPLATE (**CREATE\_TEXT\_SEARCH\_TEMPLATE**(7))
