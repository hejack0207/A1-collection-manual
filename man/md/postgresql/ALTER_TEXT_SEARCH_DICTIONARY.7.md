# alter text search dictionary(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_TEXT_SEARCH_DICTIONARY - change the definition of a text search dictionary

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER TEXT SEARCH DICTIONARY name (
        option [ = value ] [, ... ]
    )
    ALTER TEXT SEARCH DICTIONARY name RENAME TO new_name
    ALTER TEXT SEARCH DICTIONARY name OWNER TO { new_owner | CURRENT_USER | SESSION_USER }
    ALTER TEXT SEARCH DICTIONARY name SET SCHEMA new_schema

<a name="description"></a>

# Description


**ALTER TEXT SEARCH DICTIONARY**
changes the definition of a text search dictionary. You can change the dictionarys template-specific options, or change the dictionary\*(Aqs name or owner.

You must be the owner of the dictionary to use
**ALTER TEXT SEARCH DICTIONARY**.

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of an existing text search dictionary.

_option_
The name of a template-specific option to be set for this dictionary.

_value_
The new value to use for a template-specific option. If the equal sign and value are omitted, then any previous setting for the option is removed from the dictionary, allowing the default to be used.

_new\_name_
The new name of the text search dictionary.

_new\_owner_
The new owner of the text search dictionary.

_new\_schema_
The new schema for the text search dictionary.

Template-specific options can appear in any order.

<a name="examples"></a>

# Examples


The following example command changes the stopword list for a Snowball-based dictionary. Other parameters remain unchanged.

.if n \{.RS 4
.\}
    ALTER TEXT SEARCH DICTIONARY my_dict ( StopWords = newrussian );
.if n \{.RE
.\}

The following example command changes the language option to
dutch, and removes the stopword option entirely.

.if n \{.RS 4
.\}
    ALTER TEXT SEARCH DICTIONARY my_dict ( language = dutch, StopWords );
.if n \{.RE
.\}

The following example command
“updates”
the dictionarys definition without actually changing anything.

.if n \{.RS 4
.\}
    ALTER TEXT SEARCH DICTIONARY my_dict ( dummy );
.if n \{.RE
.\}

(The reason this works is that the option removal code doesnt complain if there is no such option.) This trick is useful when changing configuration files for the dictionary: the
**ALTER**
will force existing database sessions to re-read the configuration files, which otherwise they would never do if they had read them earlier.

<a name="compatibility"></a>

# Compatibility


There is no
**ALTER TEXT SEARCH DICTIONARY**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE TEXT SEARCH DICTIONARY (**CREATE\_TEXT\_SEARCH\_DICTIONARY**(7)), DROP TEXT SEARCH DICTIONARY (**DROP\_TEXT\_SEARCH\_DICTIONARY**(7))
