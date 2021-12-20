# create text search template(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_TEXT_SEARCH_TEMPLATE - define a new text search template

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE TEXT SEARCH TEMPLATE name (
        [ INIT = init_function , ]
        LEXIZE = lexize_function
    )

<a name="description"></a>

# Description


**CREATE TEXT SEARCH TEMPLATE**
creates a new text search template. Text search templates define the functions that implement text search dictionaries. A template is not useful by itself, but must be instantiated as a dictionary to be used. The dictionary typically specifies parameters to be given to the template functions.

If a schema name is given then the text search template is created in the specified schema. Otherwise it is created in the current schema.

You must be a superuser to use
**CREATE TEXT SEARCH TEMPLATE**. This restriction is made because an erroneous text search template definition could confuse or even crash the server. The reason for separating templates from dictionaries is that a template encapsulates the
“unsafe”
aspects of defining a dictionary. The parameters that can be set when defining a dictionary are safe for unprivileged users to set, and so creating a dictionary need not be a privileged operation.

Refer to
Chapter&nbsp;12
for further information.

<a name="parameters"></a>

# Parameters


_name_
The name of the text search template to be created. The name can be schema-qualified.

_init\_function_
The name of the init function for the template.

_lexize\_function_
The name of the lexize function for the template.

The function names can be schema-qualified if necessary. Argument types are not given, since the argument list for each type of function is predetermined. The lexize function is required, but the init function is optional.

The arguments can appear in any order, not only the one shown above.

<a name="compatibility"></a>

# Compatibility


There is no
**CREATE TEXT SEARCH TEMPLATE**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER TEXT SEARCH TEMPLATE (**ALTER\_TEXT\_SEARCH\_TEMPLATE**(7)), DROP TEXT SEARCH TEMPLATE (**DROP\_TEXT\_SEARCH\_TEMPLATE**(7))
