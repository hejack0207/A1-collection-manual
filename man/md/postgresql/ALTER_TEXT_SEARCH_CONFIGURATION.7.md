# alter text search configuration(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_TEXT_SEARCH_CONFIGURATION - change the definition of a text search configuration

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER TEXT SEARCH CONFIGURATION name
        ADD MAPPING FOR token_type [, ... ] WITH dictionary_name [, ... ]
    ALTER TEXT SEARCH CONFIGURATION name
        ALTER MAPPING FOR token_type [, ... ] WITH dictionary_name [, ... ]
    ALTER TEXT SEARCH CONFIGURATION name
        ALTER MAPPING REPLACE old_dictionary WITH new_dictionary
    ALTER TEXT SEARCH CONFIGURATION name
        ALTER MAPPING FOR token_type [, ... ] REPLACE old_dictionary WITH new_dictionary
    ALTER TEXT SEARCH CONFIGURATION name
        DROP MAPPING [ IF EXISTS ] FOR token_type [, ... ]
    ALTER TEXT SEARCH CONFIGURATION name RENAME TO new_name
    ALTER TEXT SEARCH CONFIGURATION name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER TEXT SEARCH CONFIGURATION name SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER TEXT SEARCH CONFIGURATION**
changes the definition of a text search configuration. You can modify its mappings from token types to dictionaries, or change the configurations name or owner.

You must be the owner of the configuration to use
**ALTER TEXT SEARCH CONFIGURATION**.

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing text search configuration.

_token\_type_
The name of a token type that is emitted by the configurations parser.

_dictionary\_name_
The name of a text search dictionary to be consulted for the specified token type(s). If multiple dictionaries are listed, they are consulted in the specified order.

_old\_dictionary_
The name of a text search dictionary to be replaced in the mapping.

_new\_dictionary_
The name of a text search dictionary to be substituted for
_old\_dictionary_.

_new\_name_
The new name of the text search configuration.

_new\_owner_
The new owner of the text search configuration.

_new\_schema_
The new schema for the text search configuration.

The
ADD MAPPING FOR
form installs a list of dictionaries to be consulted for the specified token type(s); it is an error if there is already a mapping for any of the token types. The
ALTER MAPPING FOR
form does the same, but first removing any existing mapping for those token types. The
ALTER MAPPING REPLACE
forms substitute
_new\_dictionary_
for
_old\_dictionary_
anywhere the latter appears. This is done for only the specified token types when
FOR
appears, or for all mappings of the configuration when it doesnt. The
DROP MAPPING
form removes all dictionaries for the specified token type(s), causing tokens of those types to be ignored by the text search configuration. It is an error if there is no mapping for the token types, unless
IF EXISTS
appears.

<a name="examples"></a>

# Examples


The following example replaces the
english
dictionary with the
swedish
dictionary anywhere that
english
is used within
my_config.

.if n \{.RS 4
.\}
    ALTER TEXT SEARCH CONFIGURATION my_config
      ALTER MAPPING REPLACE english WITH swedish;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER TEXT SEARCH CONFIGURATION**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE TEXT SEARCH CONFIGURATION (**CREATE\_TEXT\_SEARCH\_CONFIGURATION**(7)), DROP TEXT SEARCH CONFIGURATION (**DROP\_TEXT\_SEARCH\_CONFIGURATION**(7))
