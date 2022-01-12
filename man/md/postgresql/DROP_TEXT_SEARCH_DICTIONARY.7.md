# drop text search dictionary(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DROP_TEXT_SEARCH_DICTIONARY - remove a text search dictionary

<a name="synopsis"></a>

# Synopsis

```


```
    DROP TEXT SEARCH DICTIONARY [ IF EXISTS ] name [ CASCADE | RESTRICT ]

<a name="description"></a>

# Description


**DROP TEXT SEARCH DICTIONARY**
drops an existing text search dictionary. To execute this command you must be the owner of the dictionary.

<a name="parameters"></a>

# Parameters


IF EXISTS
Do not throw an error if the text search dictionary does not exist. A notice is issued in this case.

_name_
The name (optionally schema-qualified) of an existing text search dictionary.

CASCADE
Automatically drop objects that depend on the text search dictionary, and in turn all objects that depend on those objects (see
Section&nbsp;5.14).

RESTRICT
Refuse to drop the text search dictionary if any objects depend on it. This is the default.

<a name="examples"></a>

# Examples


Remove the text search dictionary
english:

.if n \{.RS 4
.\}
    DROP TEXT SEARCH DICTIONARY english;
.if n \{.RE
.\}

This command will not succeed if there are any existing text search configurations that use the dictionary. Add
CASCADE
to drop such configurations along with the dictionary.

<a name="compatibility"></a>

# Compatibility


There is no
**DROP TEXT SEARCH DICTIONARY**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TEXT SEARCH DICTIONARY (**ALTER\_TEXT\_SEARCH\_DICTIONARY**(7)), CREATE TEXT SEARCH DICTIONARY (**CREATE\_TEXT\_SEARCH\_DICTIONARY**(7))
