# create text search configuration(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_TEXT_SEARCH_CONFIGURATION - define a new text search configuration

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE TEXT SEARCH CONFIGURATION name (
        PARSER = parser_name |
        COPY = source_config
    )

<a name="description"></a>

# Description


**CREATE TEXT SEARCH CONFIGURATION**
creates a new text search configuration. A text search configuration specifies a text search parser that can divide a string into tokens, plus dictionaries that can be used to determine which tokens are of interest for searching.

If only the parser is specified, then the new text search configuration initially has no mappings from token types to dictionaries, and therefore will ignore all words. Subsequent
**ALTER TEXT SEARCH CONFIGURATION**
commands must be used to create mappings to make the configuration useful. Alternatively, an existing text search configuration can be copied.

If a schema name is given then the text search configuration is created in the specified schema. Otherwise it is created in the current schema.

The user who defines a text search configuration becomes its owner.

Refer to
Chapter&nbsp;12
for further information.

<a name="parameters"></a>

# Parameters


_name_
The name of the text search configuration to be created. The name can be schema-qualified.

_parser\_name_
The name of the text search parser to use for this configuration.

_source\_config_
The name of an existing text search configuration to copy.

<a name="notes"></a>

# Notes


The
PARSER
and
COPY
options are mutually exclusive, because when an existing configuration is copied, its parser selection is copied too.

<a name="compatibility"></a>

# Compatibility


There is no
**CREATE TEXT SEARCH CONFIGURATION**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TEXT SEARCH CONFIGURATION (**ALTER\_TEXT\_SEARCH\_CONFIGURATION**(7)), DROP TEXT SEARCH CONFIGURATION (**DROP\_TEXT\_SEARCH\_CONFIGURATION**(7))
