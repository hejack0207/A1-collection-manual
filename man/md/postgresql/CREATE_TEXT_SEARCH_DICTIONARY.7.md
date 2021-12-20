# create text search dictionary(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_TEXT_SEARCH_DICTIONARY - define a new text search dictionary

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE TEXT SEARCH DICTIONARY name (
        TEMPLATE = template
        [, option = value [, ... ]]
    )

<a name="description"></a>

# Description


**CREATE TEXT SEARCH DICTIONARY**
creates a new text search dictionary. A text search dictionary specifies a way of recognizing interesting or uninteresting words for searching. A dictionary depends on a text search template, which specifies the functions that actually perform the work. Typically the dictionary provides some options that control the detailed behavior of the templates functions.

If a schema name is given then the text search dictionary is created in the specified schema. Otherwise it is created in the current schema.

The user who defines a text search dictionary becomes its owner.

Refer to
Chapter&nbsp;12
for further information.

<a name="parameters"></a>

# Parameters


_name_
The name of the text search dictionary to be created. The name can be schema-qualified.

_template_
The name of the text search template that will define the basic behavior of this dictionary.

_option_
The name of a template-specific option to be set for this dictionary.

_value_
The value to use for a template-specific option. If the value is not a simple identifier or number, it must be quoted (but you can always quote it, if you wish).

The options can appear in any order.

<a name="examples"></a>

# Examples


The following example command creates a Snowball-based dictionary with a nonstandard list of stop words.

.if n \{.RS 4
.\}
    CREATE TEXT SEARCH DICTIONARY my_russian (
        template = snowball,
        language = russian,
        stopwords = myrussian
    );
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**CREATE TEXT SEARCH DICTIONARY**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TEXT SEARCH DICTIONARY (**ALTER\_TEXT\_SEARCH\_DICTIONARY**(7)), DROP TEXT SEARCH DICTIONARY (**DROP\_TEXT\_SEARCH\_DICTIONARY**(7))
